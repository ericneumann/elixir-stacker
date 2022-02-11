defmodule Stacker.Stash do

  use GenServer

  @me __MODULE__

  def start_link(initial_stack) do
    GenServer.start_link(__MODULE__, initial_stack, name: @me)
  end

  def push(item) do
    GenServer.cast(@me, {:push, item})
  end

  def pop() do
    GenServer.call(@me, :pop)
  end

  def init(initial_stack) do
    {:ok, initial_stack}
  end

  def handle_cast({:push, item}, initial_stack) do
    {:noreply, initial_stack ++ [item]}
  end

  def handle_call(:pop, _from, initial_stack) do
    {reply, new_stack} = List.pop_at(initial_stack, 0)
    {:reply, reply, new_stack}
  end

end
