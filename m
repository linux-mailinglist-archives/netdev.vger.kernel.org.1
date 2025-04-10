Return-Path: <netdev+bounces-181249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E0BA842ED
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 14:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7017C8A7A3F
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C2E284B2E;
	Thu, 10 Apr 2025 12:20:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EAE284B37
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744287632; cv=none; b=eqEvEQ7o+qgv4cDbMdPSOJn4K1Lf7sgIzoj8ARmYVlVvbmQ0KwmFGk/lMcdqjqTdfuF1tbmZe48PRv79J1NJCNNqqlGcb7JZbDvZFs7f79UYpOQbKJWL5YN7chJMp1+q6CgHmHDtKLdInonXfg0ijuoeKAs4HNHkH9m3JE8atsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744287632; c=relaxed/simple;
	bh=RnQI4rW3gJeF4oBjr8qkkvR6vsldEGuaiKpBZWCYWtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtTBp3Zl2ank8XpUDfEv7261XB1rS7qURPgqaiGz3hVrtZ6AuqqpvZd0kjg2IyUOHta+rvAQbEYQ4FisoThpWDnGtCL39ohK9k/cePvgikRucldozHDRPJvqmhKdwbqzva1+qeikkjzjYnLrudxhrptAO5w5h8hzWqip3XU9T8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u2qt0-0001re-VG; Thu, 10 Apr 2025 14:20:02 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u2qt0-004GfH-0i;
	Thu, 10 Apr 2025 14:20:02 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u2qt0-00AN7d-0G;
	Thu, 10 Apr 2025 14:20:02 +0200
Date: Thu, 10 Apr 2025 14:20:02 +0200
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
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	kernel@pengutronix.de, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Dent Project <dentproject@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 07/13] net: pse-pd: Add support for budget
 evaluation strategies
Message-ID: <Z_e3chchKI5j6Ryv@pengutronix.de>
References: <20250408-feature_poe_port_prio-v7-0-9f5fc9e329cd@bootlin.com>
 <20250408-feature_poe_port_prio-v7-7-9f5fc9e329cd@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250408-feature_poe_port_prio-v7-7-9f5fc9e329cd@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi,

looks like i started to review it and forgot to send it. Sorry :)

On Tue, Apr 08, 2025 at 04:32:16PM +0200, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> This patch introduces the ability to configure the PSE PI budget evaluation
> strategies. Budget evaluation strategies is utilized by PSE controllers to
> determine which ports to turn off first in scenarios such as power budget
> exceedance.
> 
> The pis_prio_max value is used to define the maximum priority level
> supported by the controller. Both the current priority and the maximum
> priority are exposed to the user through the pse_ethtool_get_status call.
> 
> This patch add support for two mode of budget evaluation strategies.
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
> For now, budget evaluation methods are not configurable and cannot be
> mixed. They are hardcoded in the PSE driver itself, as no current PSE
> controller supports both methods.
> 
> Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> ---
> Change in v7:
> - Move Budget evaluation strategy enum definition out of uAPI, and
>   remove ethtool prefix.
> - Add support to retry enabling port that failed to be powered in case of
>   port disconnection or priority change.
> - Update the events name in ethtool specs to match the ones described in
>   the UAPI.
> 
> Change in v6:
> - Remove Budget evaluation strategy from ethtool_pse_control_status struct.
> 
> Change in v5:
> - Save PI previous power allocated in set current limit to be able to
>   restore the power allocated in case of error.
> 
> Change in v4:
> - Remove disconnection policy features.
> - Rename port priority to budget evaluation strategy.
> - Add kdoc
> 
> Change in v3:
> - Add disconnection policy.
> - Add management of disabled port priority in the interrupt handler.
> - Move port prio mode in the power domain instead of the PSE.
> 
> Change in v2:
> - Rethink the port priority support.
> ---
>  Documentation/netlink/specs/ethtool.yaml |   7 +-
>  drivers/net/pse-pd/pse_core.c            | 680 ++++++++++++++++++++++++++++---
>  include/linux/pse-pd/pse.h               |  62 +++
>  include/uapi/linux/ethtool.h             |  21 +-
>  4 files changed, 721 insertions(+), 49 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index e78dde7340ae..93e470895dc1 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -99,9 +99,12 @@ definitions:
>    -
>      name: pse-events
>      type: flags
> -    name-prefix: ethtool-pse-event-
> +    name-prefix: ethtool-
>      header: linux/ethtool.h
> -    entries: [ over-current, over-temp ]
> +    entries: [ pse-event-over-current, pse-event-over-temp,
> +               c33-pse-event-detection, c33-pse-event-classification,
> +               c33-pse-event-disconnection, pse-event-over-budget,
> +               pse-event-sw-pw-control-error ]
>  
>  attribute-sets:
>    -
> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index 5f1faa17f298..9b26d44e9498 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c
> @@ -44,11 +44,14 @@ struct pse_control {
>   * @id: ID of the power domain
>   * @supply: Power supply the Power Domain
>   * @refcnt: Number of gets of this pse_power_domain
> + * @budget_eval_strategy: Current power budget evaluation strategy of the
> + *			  power domain
>   */
>  struct pse_power_domain {
>  	int id;
>  	struct regulator *supply;
>  	struct kref refcnt;
> +	u32 budget_eval_strategy;
>  };
>  
>  static int of_load_single_pse_pi_pairset(struct device_node *node,
> @@ -252,6 +255,89 @@ static int pse_pi_is_hw_enabled(struct pse_controller_dev *pcdev, int id)
>  	return 0;
>  }
>  
> +/**
> + * pse_pi_is_failed_to_enable - Is PI in a failed to enable state
> + * @pcdev: a pointer to the PSE controller device
> + * @id: Index of the PI
> + *
> + * Return: true if the PI is in a failed to enable state, false otherwise
> + */
> +static bool pse_pi_is_failed_to_enable(struct pse_controller_dev *pcdev,
> +				       int id)
> +{

The function name pse_pi_is_failed_to_enable() is misleading. It doesn’t
check whether the PI actually failed to deliver power — it only checks
if the admin enable flag is set in software but not yet reflected in the
hardware admin state.

This is not the same as a real enable failure (like power budget
exceeded or fault). It may simply mean the controller hasn’t applied the
request yet.

Please consider renaming the function to something more accurate, like
pse_pi_admin_enable_not_applied() or pse_pi_admin_state_mismatch(), to
better reflect what it actually checks.

If the intention is to check whether power is truly being delivered,
then the function should be rewritten to evaluate the power delivery
status (e.g., ETHTOOL_C33_PSE_PW_D_STATUS_DELIVERING), and the name
should reflect that.

> +	int ret;
> +
> +	/* PI not enabled or nothing is plugged */
> +	if (!pcdev->pi[id].admin_state_enabled ||
> +	    !pcdev->pi[id].isr_pd_detected)
> +		return false;
> +
> +	ret = pse_pi_is_hw_enabled(pcdev, id);
> +	if (ret < 0)
> +		return ret;

We converting here negative return value to bool.

> +
> +	return !ret;
> +}
> +
> +static int _pse_pi_enable_sw_pw_ctrl(struct pse_controller_dev *pcdev, int id,
> +				     struct netlink_ext_ack *extack);
> +
> +/**
> + * pse_pw_d_retry_enable - Retry to enable port of a PSE power domain
> + *			    that are in the failed to enable state
> + * @pcdev: a pointer to the PSE controller device
> + * @pw_d: a pointer to the PSE power domain
> + */
> +static void pse_pw_d_retry_enable(struct pse_controller_dev *pcdev,
> +				  struct pse_power_domain *pw_d)
> +{

The function name pse_pw_d_retry_enable() may be misleading in the context of
IEEE 802.3-2022, where “enabled” and “delivering power” are not the same.

This function doesn't just re-apply the "enable" admin request — it tries to
start delivering power to ports that were already enabled and had a PD
detected, but didn't receive power (likely due to a previous over-budget
condition).

Please consider renaming it to something more accurate, such as:
pse_pw_d_retry_power_delivery()
pse_pw_d_attempt_restore_delivery()

> +	int i, ret = 0;
> +
> +	for (i = 0; i < pcdev->nr_lines; i++) {
> +		int prio_max = pcdev->nr_lines;
> +		struct netlink_ext_ack extack;
> +
> +		if (pcdev->pi[i].pw_d != pw_d)
> +			continue;
> +
> +		if (!pse_pi_is_failed_to_enable(pcdev, i))
> +			continue;
> +
> +		/* Do not try to enable PI with a lower prio (higher value)
> +		 * than one which already can't be enabled.
> +		 */
> +		if (pcdev->pi[i].prio > prio_max)
> +			continue;
> +
> +		ret = _pse_pi_enable_sw_pw_ctrl(pcdev, i, &extack);
> +		if (ret == ERANGE)
> +			prio_max = pcdev->pi[i].prio;
> +	}
> +}
> +
> +/**
> + * pse_pw_d_is_sw_pw_control - Is power control software managed
> + * @pcdev: a pointer to the PSE controller device
> + * @pw_d: a pointer to the PSE power domain
> + *
> + * Return: true if the power control of the power domain is managed from
> + * the software in the interrupt handler
> + */
> +static bool pse_pw_d_is_sw_pw_control(struct pse_controller_dev *pcdev,
> +				      struct pse_power_domain *pw_d)
> +{
> +	if (!pw_d)
> +		return false;
> +
> +	if (pw_d->budget_eval_strategy == PSE_BUDGET_EVAL_STRAT_STATIC)
> +		return true;
> +	if (pw_d->budget_eval_strategy == PSE_BUDGET_EVAL_STRAT_DISABLED &&
> +	    pcdev->ops->pi_enable && pcdev->irq)
> +		return true;
> +
> +	return false;
> +}
> +
>  static int pse_pi_is_enabled(struct regulator_dev *rdev)
>  {
>  	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
> @@ -264,17 +350,272 @@ static int pse_pi_is_enabled(struct regulator_dev *rdev)
>  
>  	id = rdev_get_id(rdev);
>  	mutex_lock(&pcdev->lock);
> +	if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d)) {
> +		ret = pcdev->pi[id].admin_state_enabled;
> +		goto out;
> +	}
> +
>  	ret = pse_pi_is_hw_enabled(pcdev, id);
> +
> +out:
>  	mutex_unlock(&pcdev->lock);
>  
>  	return ret;
>  }
>  
> +/**
> + * pse_pi_deallocate_pw_budget - Deallocate power budget of the PI
> + * @pi: a pointer to the PSE PI
> + */
> +static void pse_pi_deallocate_pw_budget(struct pse_pi *pi)
> +{
> +	if (!pi->pw_d || !pi->pw_allocated_mW)
> +		return;
> +
> +	regulator_free_power_budget(pi->pw_d->supply, pi->pw_allocated_mW);
> +	pi->pw_allocated_mW = 0;
> +}
> +
> +/**
> + * _pse_pi_disable - Call disable operation. Assumes the PSE lock has been
> + *		     acquired.
> + * @pcdev: a pointer to the PSE
> + * @id: index of the PSE control
> + *
> + * Return: 0 on success and failure value on error
> + */
> +static int _pse_pi_disable(struct pse_controller_dev *pcdev, int id)
> +{
> +	const struct pse_controller_ops *ops = pcdev->ops;
> +	int ret;
> +
> +	if (!ops->pi_disable)
> +		return -EOPNOTSUPP;
> +
> +	ret = ops->pi_disable(pcdev, id);
> +	if (ret)
> +		return ret;
> +
> +	pse_pi_deallocate_pw_budget(&pcdev->pi[id]);
> +
> +	if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d))
> +		pse_pw_d_retry_enable(pcdev, pcdev->pi[id].pw_d);
> +
> +	return 0;
> +}
> +
> +/**
> + * pse_control_find_phy_by_id - Find PHY attached to the pse control id
> + * @pcdev: a pointer to the PSE
> + * @id: index of the PSE control
> + *
> + * Return: PHY device pointer or NULL
> + */
> +static struct phy_device *
> +pse_control_find_phy_by_id(struct pse_controller_dev *pcdev, int id)
> +{
> +	struct pse_control *psec;
> +
> +	mutex_lock(&pse_list_mutex);
> +	list_for_each_entry(psec, &pcdev->pse_control_head, list) {
> +		if (psec->id == id) {
> +			mutex_unlock(&pse_list_mutex);
> +			return psec->attached_phydev;
> +		}
> +	}
> +	mutex_unlock(&pse_list_mutex);
> +	return NULL;
> +}
> +
> +/**
> + * pse_disable_pi_pol - Disable a PI on a power budget policy
> + * @pcdev: a pointer to the PSE
> + * @id: index of the PSE PI
> + *
> + * Return: 0 on success and failure value on error
> + */
> +static int pse_disable_pi_pol(struct pse_controller_dev *pcdev, int id)
> +{
> +	unsigned long notifs = ETHTOOL_PSE_EVENT_OVER_BUDGET;
> +	struct netlink_ext_ack extack = {};
> +	struct phy_device *phydev;
> +	int ret;
> +
> +	dev_dbg(pcdev->dev, "Disabling PI %d to free power budget\n", id);
> +
> +	NL_SET_ERR_MSG_FMT(&extack,
> +			   "Disabling PI %d to free power budget", id);
> +
> +	ret = _pse_pi_disable(pcdev, id);
> +	if (ret)
> +		notifs |= ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR;
> +
> +	phydev = pse_control_find_phy_by_id(pcdev, id);
> +	if (phydev)
> +		ethnl_pse_send_ntf(phydev, notifs, &extack);
> +
> +	return ret;
> +}
> +
> +/**
> + * pse_disable_pi_prio - Disable all PIs of a given priority inside a PSE
> + *			 power domain
> + * @pcdev: a pointer to the PSE
> + * @pw_d: a pointer to the PSE power domain
> + * @prio: priority
> + *
> + * Return: 0 on success and failure value on error
> + */
> +static int pse_disable_pi_prio(struct pse_controller_dev *pcdev,
> +			       struct pse_power_domain *pw_d,
> +			       int prio)
> +{
> +	int i;
> +
> +	for (i = 0; i < pcdev->nr_lines; i++) {
> +		int ret;
> +
> +		if (pcdev->pi[i].prio != prio ||
> +		    pcdev->pi[i].pw_d != pw_d ||
> +		    !pse_pi_is_hw_enabled(pcdev, i))

pse_pi_is_hw_enabled() can return negative value on error.

> +			continue;
> +
> +		ret = pse_disable_pi_pol(pcdev, i);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * pse_pi_allocate_pw_budget_static_prio - Allocate power budget for the PI
> + *					   when the budget eval strategy is
> + *					   static
> + * @pcdev: a pointer to the PSE
> + * @id: index of the PSE control
> + * @pw_req: power requested in mW
> + * @extack: extack for error reporting
> + *
> + * Return: 0 on success and failure value on error
> + */
> +static int
> +pse_pi_allocate_pw_budget_static_prio(struct pse_controller_dev *pcdev, int id,
> +				      int pw_req, struct netlink_ext_ack *extack)
> +{
> +	struct pse_pi *pi = &pcdev->pi[id];
> +	int ret, _prio;
> +
> +	_prio = pcdev->nr_lines;
> +	while (regulator_request_power_budget(pi->pw_d->supply, pw_req) == -ERANGE) {
> +		if (_prio <= pi->prio) {
> +			NL_SET_ERR_MSG_FMT(extack,
> +					   "PI %d: not enough power budget available",
> +					   id);
> +			return -ERANGE;
> +		}
> +
> +		ret = pse_disable_pi_prio(pcdev, pi->pw_d, _prio);
> +		if (ret < 0)
> +			return ret;
> +
> +		_prio--;
> +	}
> +
> +	pi->pw_allocated_mW = pw_req;
> +	return 0;
> +}
> +
> +/**
> + * pse_pi_allocate_pw_budget - Allocate power budget for the PI
> + * @pcdev: a pointer to the PSE
> + * @id: index of the PSE control
> + * @pw_req: power requested in mW
> + * @extack: extack for error reporting
> + *
> + * Return: 0 on success and failure value on error
> + */
> +static int pse_pi_allocate_pw_budget(struct pse_controller_dev *pcdev, int id,
> +				     int pw_req, struct netlink_ext_ack *extack)
> +{
> +	struct pse_pi *pi = &pcdev->pi[id];
> +
> +	if (!pi->pw_d)
> +		return 0;
> +
> +	/* PSE_BUDGET_EVAL_STRAT_STATIC */
> +	if (pi->pw_d->budget_eval_strategy == PSE_BUDGET_EVAL_STRAT_STATIC)
> +		return pse_pi_allocate_pw_budget_static_prio(pcdev, id, pw_req,
> +							     extack);
> +
> +	return 0;
> +}
> +
> +/**
> + * _pse_pi_enable_sw_pw_ctrl - Enable PSE PI in case of software power control.
> + *			       Assumes the PSE lock has been acquired
> + * @pcdev: a pointer to the PSE
> + * @id: index of the PSE control
> + * @extack: extack for error reporting
> + *
> + * Return: 0 on success and failure value on error
> + */
> +static int _pse_pi_enable_sw_pw_ctrl(struct pse_controller_dev *pcdev, int id,
> +				     struct netlink_ext_ack *extack)
> +{

Is it for "admin enable" or "start power delivery"?

> +	const struct pse_controller_ops *ops = pcdev->ops;
> +	struct pse_pi *pi = &pcdev->pi[id];
> +	int ret, pw_req;
> +
> +	if (!ops->pi_get_pw_req) {
> +		/* No power allocation management */
> +		ret = ops->pi_enable(pcdev, id);
> +		if (ret)
> +			NL_SET_ERR_MSG_FMT(extack,
> +					   "PI %d: enable error %d",
> +					   id, ret);
> +		return ret;
> +	}
> +
> +	ret = ops->pi_get_pw_req(pcdev, id);
> +	if (ret < 0)
> +		return ret;
> +
> +	pw_req = ret;
> +
> +	/* Compare requested power with port power limit and use the lowest
> +	 * one.
> +	 */
> +	if (ops->pi_get_pw_limit) {
> +		ret = ops->pi_get_pw_limit(pcdev, id);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (ret < pw_req)
> +			pw_req = ret;
> +	}
> +
> +	ret = pse_pi_allocate_pw_budget(pcdev, id, pw_req, extack);
> +	if (ret)
> +		return ret;
> +
> +	ret = ops->pi_enable(pcdev, id);
> +	if (ret) {
> +		pse_pi_deallocate_pw_budget(pi);
> +		NL_SET_ERR_MSG_FMT(extack,
> +				   "PI %d: enable error %d",
> +				   id, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

