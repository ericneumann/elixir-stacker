defmodule Stacker.Server do
  use GenServer

  alias Stacker.Stash

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def push_item(item) do
    GenServer.cast __MODULE__, {:push, item}
  end

  def pop_item() do
    GenServer.call __MODULE__, :pop
  end

  def init(_) do
    {:ok, nil}
  end

  def handle_call(:pop, _from, _) do
    item = Stash.pop()
    IO.puts item
    {:reply, item, nil}
  end

  def handle_cast({:push, item}, _) do
    Stash.push item
    {:noreply, nil}
  end
end
