Return-Path: <netdev+bounces-147343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972F29D9368
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56476283454
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 08:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F62B19D8B2;
	Tue, 26 Nov 2024 08:38:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6009433A6
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 08:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732610332; cv=none; b=fyEfIUT+Dw9C/1ftNkj02Zw4EGHIbtVTnPj4KLZdtyKE3yV4GetxJ6A36UBZcPJFrD7+UsTZoOLUQKLbm630p89RgliHKkXuVfjAptmz+2W3FVCemlQZ+qR0LTrzSZQhLTyNCyZbqRk9tAQSZ+FqxSBDUAdV86jaQmRIuz7wqYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732610332; c=relaxed/simple;
	bh=47Vvnl2PJG2vfhoBjhEmMLildU6H08DQwK9Fe/nW/xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thNlp49FIIvK7l9LtgfS0oEd91bghNF/6Hs40EjXvDBMg6mjYH9yRqqdkGTNNcr7wUSUW2WZfQ05TSfnJUpEN2J+6ZNFCSctFjhBaz3xL7EAvdyQSZ2eTsW9GTHoy16AutJeB6XhqmuiTyMkLiBtj+UbHAod4teyHSGGYPPslZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tFr5b-0001TV-Mp; Tue, 26 Nov 2024 09:38:31 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tFr5X-000Dch-0k;
	Tue, 26 Nov 2024 09:38:28 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tFr5X-00GYuB-2q;
	Tue, 26 Nov 2024 09:38:27 +0100
Date: Tue, 26 Nov 2024 09:38:27 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v3 21/27] net: pse-pd: Add support for
 getting and setting port priority
Message-ID: <Z0WJAzkgq4Qr-xLU@pengutronix.de>
References: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
 <20241121-feature_poe_port_prio-v3-21-83299fa6967c@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241121-feature_poe_port_prio-v3-21-83299fa6967c@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Nov 21, 2024 at 03:42:47PM +0100, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> This patch introduces the ability to configure the PSE PI port priority.
> Port priority is utilized by PSE controllers to determine which ports to
> turn off first in scenarios such as power budget exceedance.
> 
> The pis_prio_max value is used to define the maximum priority level
> supported by the controller. Both the current priority and the maximum
> priority are exposed to the user through the pse_ethtool_get_status call.
> 
> This patch add support for two mode of port priority modes.

Priorit mode is too abstract for me, in this case we are talking about
Budget Evaluation Strategy.

> 1. Static Method:
> 
>    This method involves distributing power based on PD classification.
>    It’s straightforward and stable, the PSE core keeping track of the
>    budget and subtracting the power requested by each PD’s class.
> 
>    Advantages: Every PD gets its promised power at any time, which
>    guarantees reliability.
> 
>    Disadvantages: PD classification steps are large, meaning devices
>    request much more power than they actually need. As a result, the power
>    supply may only operate at, say, 50% capacity, which is inefficient and
>    wastes money.
> 
>    Priority max value is matching the number of PSE PIs within the PSE.
> 
> 2. Dynamic Method:
> 
>    To address the inefficiencies of the static method, vendors like
>    Microchip have introduced dynamic power budgeting, as seen in the
>    PD692x0 firmware. This method monitors the current consumption per port
>    and subtracts it from the available power budget. When the budget is
>    exceeded, lower-priority ports are shut down.
> 
>    Advantages: This method optimizes resource utilization, saving costs.
> 
>    Disadvantages: Low-priority devices may experience instability.
> 
>    Priority max value is set by the PSE controller driver.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Change in v3:
> - Add disconnection policy.
> - Add management of disabled port priority in the interrupt handler.
> - Move port prio mode in the power domain instead of the PSE.
> 
> Change in v2:
> - Rethink the port priority support.
> ---
>  drivers/net/pse-pd/pse_core.c | 550 +++++++++++++++++++++++++++++++++++++++++-
>  include/linux/pse-pd/pse.h    |  63 +++++
>  include/uapi/linux/ethtool.h  |  73 ++++++
>  3 files changed, 676 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index ff0ffbccf139..f15a693692ae 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c
> @@ -40,10 +40,17 @@ struct pse_control {
>   * struct pse_power_domain - a PSE power domain
>   * @id: ID of the power domain
>   * @supply: Power supply the Power Domain
> + * @port_prio_mode: Current port priority mode of the power domain

Same here, it is Budget Evaluation Strategy. May be: budget_eval_strategy

> + * @discon_pol: Current disonnection policy of the power domain
> + * @pi_lrc_id: ID of the last recently connected PI. -1 if none. Relevant
> + *	       for static port priority mode.
>   */
>  struct pse_power_domain {
>  	int id;
>  	struct regulator *supply;
> +	u32 port_prio_mode;
> +	u32 discon_pol;
> +	int pi_lrc_id;

We should store all ports withing the domain in a list and process the
list backwards or forwards, depending on disconnection policy.

>  };
>  
>  static int of_load_single_pse_pi_pairset(struct device_node *node,
> @@ -222,6 +229,33 @@ static int of_load_pse_pis(struct pse_controller_dev *pcdev)
>  	return ret;
>  }
>  
> +static void pse_pi_deallocate_pw_budget(struct pse_pi *pi)
> +{
> +	if (!pi->pw_d)
> +		return;
> +
> +	regulator_free_power_budget(pi->pw_d->supply, pi->pw_allocated);
> +}
> +
> +/* Helper returning true if the power control is managed from the software
> + * in the interrupt handler
> + */

Please use function comment format. I would really love to have comments
on all new functions.

> +static bool pse_pw_d_is_sw_pw_control(struct pse_controller_dev *pcdev,
> +				      struct pse_power_domain *pw_d)
> +{
> +	if (!pw_d)
> +		return false;
> +
> +	if (pw_d->port_prio_mode & ETHTOOL_PSE_PORT_PRIO_STATIC)

here should be pw_d->port_prio_mode == ETHTOOL_PSE_PORT_PRIO_STATIC

We can't support multiple evaluation strategies per port.

> +		return true;
> +	if (pw_d->port_prio_mode == ETHTOOL_PSE_PORT_PRIO_DISABLED &&
> +	    pcdev->ops->pi_enable && pcdev->ops->pi_get_pw_req &&
> +	    pcdev->irq)
> +		return true;
> +
> +	return false;
> +}
> +

....

> +int pse_ethtool_set_prio_mode(struct pse_control *psec,
> +			      struct netlink_ext_ack *extack,
> +			      u32 prio_mode)
> +{
> +	struct pse_controller_dev *pcdev = psec->pcdev;
> +	const struct pse_controller_ops *ops;
> +	int ret = 0, i;
> +
> +	if (!(prio_mode & pcdev->port_prio_supp_modes)) {
> +		NL_SET_ERR_MSG(extack, "priority mode not supported");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (!pcdev->pi[psec->id].pw_d) {
> +		NL_SET_ERR_MSG(extack, "no power domain attached");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/* ETHTOOL_PSE_PORT_PRIO_DISABLED can't be ORed with another mode */
> +	if (prio_mode & ETHTOOL_PSE_PORT_PRIO_DISABLED &&
> +	    prio_mode & ~ETHTOOL_PSE_PORT_PRIO_DISABLED) {
> +		NL_SET_ERR_MSG(extack,
> +			       "port priority can't be enabled and disabled simultaneously");
> +		return -EINVAL;
> +	}
> +
> +	ops = psec->pcdev->ops;
> +
> +	/* We don't want priority mode change in the middle of an
> +	 * enable/disable call
> +	 */
> +	mutex_lock(&pcdev->lock);
> +	pcdev->pi[psec->id].pw_d->port_prio_mode = prio_mode;

In proposed implementation we have can set policies per port, but it
will affect complete domain. This is not good. It feels like a separate
challenge with extra discussion and work. I would recommend not to
implement policy setting right now.

If you will decide to implement setting of policies anyway, then we need
to discuss the interface.
- If the policy should be done per domain, then we will need a separate
  interface to interact with domains.
  Pro: seems to be easier to implement.
- If we will go with policy per port, wich would make sense too, then
  some rework of this patch is needed.
  Pro: can combine best of both strategies: set ports with wide load
  range to static strategy and use dynamic strategy on other ports.

Right now we do not have software implementation for dynamic mode,
implementing configuration of the policies from user space can be
implemented later. It is enough to provide information about what
hard coded policy is currently used.

>  /* Maximum current in uA according to IEEE 802.3-2022 Table 145-1 */
>  #define MAX_PI_CURRENT 1920000
> @@ -62,6 +63,13 @@ struct pse_control_config {
>   *	is in charge of the memory allocation.
>   * @c33_pw_limit_nb_ranges: number of supported power limit configuration
>   *	ranges
> + * @c33_prio_supp_modes: PSE port priority modes supported. Set by PSE core.
> + * @c33_prio_mode: PSE port priority mode selected. Set by PSE core.
> + * @c33_prio_max: max priority allowed for the c33_prio variable value. Set
> + *	by PSE core.
> + * @c33_prio: priority of the PSE. Set by PSE core in case of static port
> + *	priority mode.
> + * @c33_discon_pol: PSE disconnection policy selected. Set by PSE core.

Priority configuration is not port of IEEE 802.3 specification. c33_
prefix should be removed here.

>   */
>  struct pse_control_status {
>  	u32 pse_id;
> @@ -76,6 +84,11 @@ struct pse_control_status {
>  	u32 c33_avail_pw_limit;
>  	struct ethtool_c33_pse_pw_limit_range *c33_pw_limit_ranges;
>  	u32 c33_pw_limit_nb_ranges;
> +	u32 c33_prio_supp_modes;
> +	enum pse_port_prio_modes c33_prio_mode;
> +	u32 c33_prio_max;
> +	u32 c33_prio;
> +	u32 c33_discon_pol;
>  };

....

>  struct module;
> @@ -143,6 +163,12 @@ struct pse_pi_pairset {
>   * @rdev: regulator represented by the PSE PI
>   * @admin_state_enabled: PI enabled state
>   * @pw_d: Power domain of the PSE PI
> + * @prio: Priority of the PSE PI. Used in static port priority mode
> + * @isr_enabled: PSE PI power status managed by the interruption handler.
> + *		 This variable is relevant when the power enabled management
> + *		 is a managed in software like the static port priority mode.
> + * @pw_allocated: Power allocated to a PSE PI to manage power budget in
> + *	static port priority mode
>   */
>  struct pse_pi {
>  	struct pse_pi_pairset pairset[2];
> @@ -150,6 +176,9 @@ struct pse_pi {
>  	struct regulator_dev *rdev;
>  	bool admin_state_enabled;
>  	struct pse_power_domain *pw_d;
> +	int prio;
> +	bool isr_enabled;
> +	int pw_allocated;

s/pw_allocated/pw_allocated_mw/

>  	return false;
> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> index a4c93d6de218..b6727049840c 100644
> --- a/include/uapi/linux/ethtool.h
> +++ b/include/uapi/linux/ethtool.h
> @@ -1002,11 +1002,84 @@ enum ethtool_c33_pse_pw_d_status {
>   * enum ethtool_pse_events - event list of the PSE controller.
>   * @ETHTOOL_PSE_EVENT_OVER_CURRENT: PSE output current is too high.
>   * @ETHTOOL_PSE_EVENT_OVER_TEMP: PSE in over temperature state.
> + * @ETHTOOL_C33_PSE_EVENT_DETECTION: detection process occur on the PSE.
> + *	IEEE 802.3-2022 145.2.6 PSE detection of PDs

33.2.5 and 145.2.6 -> 30.9.1.1.5 aPSEPowerDetectionStatus

> + * @ETHTOOL_C33_PSE_EVENT_CLASSIFICATION: classification process occur on
> + *	the PSE. IEEE 802.3-2022 145.2.8 PSE classification of PDs and
> + *	mutual identification

33.2.6 and 145.2.8 -> 30.9.1.1.8 aPSEPowerClassification

> + * @ETHTOOL_C33_PSE_EVENT_DISCONNECTION: PD has been disconnected on the PSE.

This one seems to be related to following parts of specification:
33.3.8 and 145.3.9 PD Maintain Power Signature
33.5.1.2.9 MPS Absent
30.9.1.1.20 aPSEMPSAbsentCounter

> + * @ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR: PSE faced an error managing the
> + *	power control from software.
>   */
>  
>  enum ethtool_pse_events {
>  	ETHTOOL_PSE_EVENT_OVER_CURRENT =	1 << 0,
>  	ETHTOOL_PSE_EVENT_OVER_TEMP =		1 << 1,
> +	ETHTOOL_C33_PSE_EVENT_DETECTION =	1 << 2,
> +	ETHTOOL_C33_PSE_EVENT_CLASSIFICATION =	1 << 3,
> +	ETHTOOL_C33_PSE_EVENT_DISCONNECTION =	1 << 4,
> +	ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR =	1 << 5,
> +};
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

