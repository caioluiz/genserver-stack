defmodule Stack.Stash do
  use GenServer

  #####
  # External API  
  def start_link(stack) do
    {:ok,_pid} = GenServer.start_link( __MODULE__, stack)
  end

  def save_values(pid, values) do
    GenServer.cast pid, {:save, values}
  end

  def get_values(pid) do
    GenServer.call pid, :get
  end

  #####
  # GenServer internal implementation
  def handle_call(:get, _from, current_values) do 
    {:reply, current_values, current_values}
  end

  def handle_cast({:save, values}, _current_values) do
    {:noreply, values}
  end
end
