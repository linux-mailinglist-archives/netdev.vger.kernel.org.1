Return-Path: <netdev+bounces-175296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2910A64F95
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 13:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041B4164265
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 12:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BB41E505;
	Mon, 17 Mar 2025 12:46:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658411DDD1
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215567; cv=none; b=ggq8GGBCETfb5agVdiC2rWa1ZHE4lCXm/NHB66iSorGPQuAG/Ja6cMpisr/SoCOaUBSA42os5KwkjJD/R6SdwkTE0A92EvKT/xXcFBAgiHHu7GEGq1lWeDhaYkvd3BsRPSD9YbnWZpzeGx+5YyncSj3+CYD90EkmmxYE+HAAvCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215567; c=relaxed/simple;
	bh=gu5tdQie3PXjE9UKnouXcaXft1uLAYhn2LNXTlZeflU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQuMKDIawb+QugqQPixnQg5QRA+QUZ0OaD177+rgZcrL6ZxgsVrMY6DjU3j76yPVYMAnQW+DAJknic190LMUSvFiywBWlYU6smws9RukkYxe9FGy+2UAlwLPLPxZ5HPgLsaFD8EAthMH5q2FzL3EULh5lU+/SSAuzKEeyCYFrvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tu9ma-0002fR-81; Mon, 17 Mar 2025 13:41:34 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tu9ls-000Fod-2e;
	Mon, 17 Mar 2025 13:40:45 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tu9lt-001Blb-0C;
	Mon, 17 Mar 2025 13:40:45 +0100
Date: Mon, 17 Mar 2025 13:40:45 +0100
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
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 06/12] net: pse-pd: Add support for budget
 evaluation strategies
Message-ID: <Z9gYTRgH-b1fXJRQ@pengutronix.de>
References: <20250304-feature_poe_port_prio-v6-0-3dc0c5ebaf32@bootlin.com>
 <20250304-feature_poe_port_prio-v6-6-3dc0c5ebaf32@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304-feature_poe_port_prio-v6-6-3dc0c5ebaf32@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Mar 04, 2025 at 11:18:55AM +0100, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
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

Should we lock the pi[] array at some level?

> +	for (i = 0; i < pcdev->nr_lines; i++) {
> +		int ret;
> +
> +		if (pcdev->pi[i].prio != prio ||
> +		    pcdev->pi[i].pw_d != pw_d ||
> +		    !pcdev->pi[i].admin_state_enabled)
> +			continue;
> +
> +		ret = pse_disable_pi_pol(pcdev, i);

If the PSE has many lower-priority ports, the same set of ports could be
repeatedly shut down while higher-priority ports keep power
indefinitely.

This could result in a starvation issue, where lower-priority group of
ports may never get a chance to stay enabled, even if power briefly
becomes available.

To fix this, we could:
- Disallow identical priorities in static mode to ensure a clear
shutdown order.
- Modify pse_disable_pi_prio() to track freed power and stop
disabling once enough power is recovered.

static int pse_disable_pi_prio(struct pse_controller_dev *pcdev,
                               struct pse_power_domain *pw_d,
                               int prio, int required_power)
{
    int i, ret;
    int freed_power = 0;

    mutex_lock(&pcdev->lock);

    for (i = 0; i < pcdev->nr_lines; i++) {
        if (pcdev->pi[i].prio != prio ||
            pcdev->pi[i].pw_d != pw_d ||
            !pcdev->pi[i].admin_state_enabled)
            continue;

        ret = pse_disable_pi_pol(pcdev, i);
        if (ret == 0)
            freed_power += pcdev->pi[i].pw_allocated_mW;

        /* Stop once we have freed enough power */
        if (freed_power >= required_power)
            break;
    }

    mutex_unlock(&pcdev->lock);
    return ret;
}

The current approach still introduces an implicit priority based on loop
execution order, but since it's predictable, it can serve as a reasonable
default.

> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

....

> +/**
> + * pse_ethtool_set_prio - Set PSE PI priority according to the budget
> + *			  evaluation strategy
> + * @psec: PSE control pointer
> + * @extack: extack for reporting useful error messages
> + * @prio: priovity value
> + *
> + * Return: 0 on success and failure value on error
> + */
> +int pse_ethtool_set_prio(struct pse_control *psec,
> +			 struct netlink_ext_ack *extack,
> +			 unsigned int prio)
> +{
> +	struct pse_controller_dev *pcdev = psec->pcdev;
> +	const struct pse_controller_ops *ops;
> +	int ret = 0;
> +
> +	if (!pcdev->pi[psec->id].pw_d) {
> +		NL_SET_ERR_MSG(extack, "no power domain attached");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/* We don't want priority change in the middle of an
> +	 * enable/disable call or a priority mode change
> +	 */
> +	mutex_lock(&pcdev->lock);
> +	switch (pcdev->pi[psec->id].pw_d->budget_eval_strategy) {
> +	case ETHTOOL_PSE_BUDGET_EVAL_STRAT_STATIC:
> +		if (prio > pcdev->nr_lines) {
> +			NL_SET_ERR_MSG_FMT(extack,
> +					   "priority %d exceed priority max %d",
> +					   prio, pcdev->nr_lines);
> +			ret = -ERANGE;
> +			goto out;
> +		}
> +
> +		pcdev->pi[psec->id].prio = prio;

In case we already out of the budget, we will need to re-evaluate the
prios. New configuration may affect state of ports.

Potentially we may need a bulk interface to assign prios, to speed-up
reconfiguration. But it is not needed right now.

> +		break;
> +
> +	case ETHTOOL_PSE_BUDGET_EVAL_STRAT_DYNAMIC:
> +		ops = psec->pcdev->ops;
> +		if (!ops->pi_set_prio) {
> +			NL_SET_ERR_MSG(extack,
> +				       "pse driver does not support setting port priority");
> +			ret = -EOPNOTSUPP;
> +			goto out;
> +		}
> +
> +		if (prio > pcdev->pis_prio_max) {
> +			NL_SET_ERR_MSG_FMT(extack,
> +					   "priority %d exceed priority max %d",
> +					   prio, pcdev->pis_prio_max);
> +			ret = -ERANGE;
> +			goto out;
> +		}
> +
> +		ret = ops->pi_set_prio(pcdev, psec->id, prio);

Here too, but in case of microchip PSE it will happen in the firmware.
May be add here a comment that currently it is done in firmware and to
be extended for the kernel based implementation.

> +		break;
> +
> +	default:
> +		ret = -EOPNOTSUPP;
> +	}
> +
> +out:
> +	mutex_unlock(&pcdev->lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pse_ethtool_set_prio);
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

