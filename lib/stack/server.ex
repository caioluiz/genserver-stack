defmodule Stack.Server do
  use GenServer

  #####
  # Extermal API
  def start_link(stash_pid) do
    GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def push(value) when value > 0 do
    GenServer.cast __MODULE__, {:push, value}
  end

  def pop do
    GenServer.call __MODULE__, :pop
  end

  def status do
    GenServer.cast __MODULE__, :status
  end

  #####
  # GenServer internal implementation
  def init(stash_pid) do
    stack = Stack.Stash.get_values stash_pid
    {:ok, {stack, stash_pid}}
  end

  def handle_call(:pop, _from, {stack, stash_pid}) do
    [head | tail] = stack
    {:reply, head, {tail, stash_pid}}
  end

  def handle_cast({:push, value}, {stack, stash_pid}) do
    new_stack = [value | stack]
    {:noreply, {new_stack, stash_pid}}
  end
  
  def handle_cast(:status, {stack, stash_pid}) do
    IO.inspect stack
    {:noreply, {stack, stash_pid} }
  end
  
  def terminate(reason, {stack, stash_pid}) do
    IO.puts "Terminating stack because of: #{reason} on server #{stash_pid}"
    Stack.Stash.save_values stash_pid, stack
  end

end
