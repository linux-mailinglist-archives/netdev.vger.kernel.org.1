Return-Path: <netdev+bounces-254678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0J+MHE8ue2m3CAIAu9opvQ
	(envelope-from <netdev+bounces-254678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:54:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE01AE4A1
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB02E3013B5D
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE1C37FF71;
	Thu, 29 Jan 2026 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKX7li8J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EF037F8B1;
	Thu, 29 Jan 2026 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769680459; cv=none; b=KqmIRWgHxLgLh4muu7//3JcN+Uabz4Ldeu3oLNVu9C/Sj22kSiLEDfPiR7CaUsNb7ua7xPjNK77Fhr+8PiZdrxiiPt6tt5Uq1CsE7qnzJ8tHROfN3gtvjVW0T3InLzfmGNybBqmzWgiq2iBhz/NoPJO8wHOUexQ2CK1TbtT9XlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769680459; c=relaxed/simple;
	bh=EnOTj/7CZJ9tyZqdurXyWWI0fv+qLb1PjDZ8+646Wj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scoqhxeZCCCwI8lOfzwhUbNrIrdVNT2DYXHY8IlC4CqF5Ec3LtgK9oI1jbesXKEbYOKfsnQ5luE3fjp75AyN9FhBS9MN1ME/XabBXXjK4yQJxQD2JziKH8P5CEZKVvufSHNqUTFuaf/eds1B7lbubm/BeiExN3LehPoT4p/iL3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKX7li8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A56C4CEF7;
	Thu, 29 Jan 2026 09:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769680458;
	bh=EnOTj/7CZJ9tyZqdurXyWWI0fv+qLb1PjDZ8+646Wj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uKX7li8JfZPEdKeB1hBz8vBzLGN3uCNhd+sHkwTGTkJD5nNgCGxu88Shq8feblZWM
	 7fb/NUtu1fVDkPOIYo0mlr8zHv9A3KUBNPNnN1Pt50ZycH3lvLgXAl6H7J0xaHtEid
	 rApdiYCn5zrDIUovDT7gonalq6ycUOIABp9ypiyB4yhTDtiWsRx3XOZBjw3xUMqi+A
	 0HkyXHWBY0bPE/9w0XWx+R9T+w4uw4MzzSx1nzr+MWICq1lAr4FInbGkUX55Y2+ZgH
	 LICcilYOu7iiKrVFCMl3SjduswdnI20aCMusYEipXRpakmFazkmWpSEqzOyec3Ck3v
	 OPQKsuwm5Yl5g==
Date: Thu, 29 Jan 2026 09:54:13 +0000
From: Simon Horman <horms@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ciprianmarian.costea@oss.nxp.com, s32@nxp.com,
	p.zabel@pengutronix.de, linux@armlinux.org.uk,
	ghennadi.procopciuc@nxp.com, bogdan-gabriel.roman@nxp.com,
	Ionut.Vicovan@nxp.com, alexandru-catalin.ionita@nxp.com,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, Frank.li@nxp.com
Subject: Re: [PATCH 2/4] phy: s32g: Add serdes subsystem phy
Message-ID: <aXsuRTZUUnw0kdzV@horms.kernel.org>
References: <20260126092159.815968-1-vincent.guittot@linaro.org>
 <20260126092159.815968-3-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126092159.815968-3-vincent.guittot@linaro.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254678-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: DDE01AE4A1
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 10:21:57AM +0100, Vincent Guittot wrote:

...

> diff --git a/drivers/phy/freescale/phy-nxp-s32g-serdes.c b/drivers/phy/freescale/phy-nxp-s32g-serdes.c
> new file mode 100644
> index 000000000000..8336c868c8dc
> --- /dev/null
> +++ b/drivers/phy/freescale/phy-nxp-s32g-serdes.c
> @@ -0,0 +1,569 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * SerDes driver for S32G SoCs
> + *
> + * Copyright 2021-2026 NXP
> + */
> +
> +#include <dt-bindings/phy/phy.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>

Hi Vincent, all,

I think that you also need:

#include <linux/iopoll.h>

So that read_poll_timeout() is declared.
Else this patch causes a transient build failure
(for x86_64 allmodconfig)

> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/processor.h>
> +#include <linux/reset.h>
> +#include <linux/units.h>

...

> +static int s32g_serdes_phy_set_mode_ext(struct phy *p,
> +					enum phy_mode mode, int submode)
> +{
> +	struct s32g_serdes *serdes = phy_get_drvdata(p);
> +
> +	if (mode == PHY_MODE_PCIE)
> +		return -EINVAL;

This is part of an AI Generated review.
I have looked over it and I think it warrants investigation.
For information on how to reproduce locally, as I did, please see [1].

[1] https://netdev-ai.bots.linux.dev/ai-local.html

  This returns error if mode IS PHY_MODE_PCIE, but this is a PCIe PHY!
  This looks like a typo. Should be !=.

> +
> +	if (!is_pcie_phy_mode_valid(submode))
> +		return -EINVAL;
> +
> +	/*
> +	 * Do not configure SRIS or CRSS PHY MODE in conjunction
> +	 * with any SGMII mode on the same SerDes subsystem
> +	 */
> +	if ((submode == CRSS || submode == SRIS) &&
> +	    serdes->ctrl.ss_mode != 0)
> +		return -EINVAL;
> +
> +	/*
> +	 * Internal reference clock cannot be used with either Common clock
> +	 * or Spread spectrum, leaving only SRNSS
> +	 */
> +	if (submode != SRNS &&  !serdes->ctrl.ext_clk)
> +		return -EINVAL;
> +
> +	serdes->pcie.phy_mode = submode;

The AI review also suggested that it may be unsafe
to set the submode after s32g_serdes_phy_power_on()
has been called. And that there is nothing preventing that.

TBH, I am unsure if either of those statements are true.
But it seems worth validating with you.

> +
> +	return 0;
> +}

...

> +static int s32g_serdes_get_ctrl_resources(struct platform_device *pdev, struct s32g_serdes *serdes)
> +{
> +	struct s32g_serdes_ctrl *ctrl = &serdes->ctrl;
> +	struct device *dev = &pdev->dev;
> +	int ret, idx;
> +
> +	ret = of_property_read_u32(dev->of_node, "nxp,sys-mode",
> +				   &ctrl->ss_mode);
> +	if (ret) {
> +		dev_err(dev, "Failed to get SerDes subsystem mode\n");
> +		return -EINVAL;
> +	}
> +
> +	if (ctrl->ss_mode > S32G_SERDES_MODE_MAX) {
> +		dev_err(dev, "Invalid SerDes subsystem mode %u\n",
> +			ctrl->ss_mode);
> +		return -EINVAL;
> +	}
> +
> +	ctrl->ss_base = devm_platform_ioremap_resource_byname(pdev, "ss_pcie");
> +	if (IS_ERR(ctrl->ss_base)) {
> +		dev_err(dev, "Failed to map 'ss_pcie'\n");
> +		return PTR_ERR(ctrl->ss_base);
> +	}
> +
> +	ctrl->rst = devm_reset_control_get(dev, "serdes");
> +	if (IS_ERR(ctrl->rst))
> +		return dev_err_probe(dev, PTR_ERR(ctrl->rst),
> +				     "Failed to get 'serdes' reset control\n");
> +
> +	ctrl->nclks = devm_clk_bulk_get_all(dev, &ctrl->clks);
> +	if (ctrl->nclks < 1)
> +		return dev_err_probe(dev, ctrl->nclks,
> +				     "Failed to get SerDes clocks\n");

If devm_clk_bulk_get_all returns 0 then this value will
be passed to dev_err_probe(). And 0 will, in turn be returned by
dev_err_probe() and this function. However, that will be treated
as success by the caller, even though this is an error condition.

Perhaps something like this is more appropriate if ctrl->nclks
must be greater than 0. (Completely untested!)

	if (ctrl->nclks < 1) {
		ret = ctrl->nclks ? : -EINVAL;
		return dev_err_probe(dev, ret,
				     "Failed to get SerDes clocks\n");
	}

Flagged by Smatch.

...

> +static int s32g_serdes_parse_lanes(struct device *dev, struct s32g_serdes *serdes)
> +{
> +	int ret;
> +
> +	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> +		ret = s32g2_serdes_create_phy(serdes, of_port);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;

Perhaps it cannot occur.
But if the loop above iterates zero times,
then ret will be used uninitialised here.

Also flagged by Smatch.

> +}
> +
> +static int s32g_serdes_probe(struct platform_device *pdev)
> +{
> +	struct s32g_serdes *serdes;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	serdes = devm_kzalloc(dev, sizeof(*serdes), GFP_KERNEL);
> +	if (!serdes)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, serdes);
> +	serdes->dev = dev;
> +
> +	ret = s32g_serdes_get_ctrl_resources(pdev, serdes);
> +	if (ret)
> +		return ret;
> +
> +	ret = s32g_serdes_get_pcie_resources(pdev, serdes);
> +	if (ret)
> +		return ret;
> +
> +	ret = s32g_serdes_parse_lanes(dev, serdes);
> +	if (ret)
> +		return ret;

The I review also says:

  The probe function calls s32g_serdes_init() which enables clocks,
  configures hardware, and deasserts reset. However,
  s32g_serdes_parse_lanes() creates PHY providers via
  devm_of_phy_provider_register().

  Problem: PHY consumers can start calling PHY ops (like power_on) as soon
  as the provider is registered, but the hardware isn't initialized until
  s32g_serdes_init() runs afterward. This creates a race window.

  Recommendation: Move s32g_serdes_init() before s32g_serdes_parse_lanes().

> +
> +	ret = s32g_serdes_init(serdes);
> +
> +	return ret;

nit: This could be more succinctly written as:

	return s32g_serdes_init(serdes);

> +}

...

