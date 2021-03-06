% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DataSimulateR.R
\name{DataSimulateR}
\alias{DataSimulateR}
\title{DataSimulateR}
\usage{
DataSimulateR(NetworkMatrix, dT, Tstart, Tstop, T0_nodes = 100,
  influx_vector = NULL, influx_Tframe = NULL, rate_vector = NULL,
  rate_mapping = NULL, RateFunctionObject = NULL, plot_out = TRUE,
  plot_title = NULL)
}
\arguments{
\item{NetworkMatrix}{The underlying network in matrix form (e.g. form the NetworkCreateR function).}

\item{dT}{Simulation time step (must be small enough to avoid approximation errors).}

\item{Tstart}{Starting time point.}

\item{Tstop}{Ending time point.}

\item{T0_nodes}{Vector (or single value) with the initial node value(s) (metabolite concentrations).}

\item{influx_vector}{Vector with the influx (per time unit) received by the corresponding metabolites.}

\item{influx_Tframe}{Vector of two values indicating the start and ending time of the influx (if only single ending time value supplied, assumption of influx start = Tstart is made). This can also be a data frame/matrix with 2 columns and 1 row per metabolite, or just a single ending value.}

\item{rate_vector}{Vector with the initial rates. Number of rates can be between 1 and the number of edges in the network.}

\item{rate_mapping}{A matrix (same size as NetworkMatrix) with for every link/edge in the network (1 in NetworkMatrix) an index of rate_vector to be matched.}

\item{RateFunctionObject}{An object from RateFunctionBuildR describing the evolution of rates. If not provided, the rates are constant.}

\item{plot_out}{Whether to plot the simulated data.}

\item{plot_title}{Optional plot title.}
}
\value{
A list with: the time vector and a matrix with the simulated data. (1 row per node)
}
\description{
Simulated dynamic/longitudinal data based on an underlying network. The network is initialized with values 
for every node (e.g. concentrations in the case of metabolites). These values evolve over time caused by the
(variable) rates.
}
\examples{
Nmetabos <- 20L
Nrates <- 10L

Network <- NetworkCreateR(N = Nmetabos, BA_power = 0.5, BA_mValue = 4)

Rate_function <- RateFunctionBuildR(type = "sigmoid")

rate_vector <- round(5*runif(Nrates))

rate_mapping <- Network
active_rates <- which(Network == 1, arr.ind = TRUE)
for(rr in 1:nrow(active_rates)){
    rate_mapping[active_rates[rr,1], active_rates[rr,2]] <- sample(seq_along(rate_vector), size = 1)
    }
    
 No_influx <- DataSimulateR(NetworkMatrix = Network, dT = 0.01, Tstart = 0, Tstop = 3, 
                            T0_nodes = 100, rate_vector = rate_vector, rate_mapping = rate_mapping, 
                            RateFunctionObject = Rate_function, plot_out = TRUE)

}
\author{
Charlie Beirnaert, \email{charlie.beirnaert@uantwerpen.be}
}
