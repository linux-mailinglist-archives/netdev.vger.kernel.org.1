Return-Path: <netdev+bounces-254776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJdmLLtLe2mnDgIAu9opvQ
	(envelope-from <netdev+bounces-254776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:59:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E59AFD90
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8B973016CAB
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF403876AB;
	Thu, 29 Jan 2026 11:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+5IdhFD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0672A387352;
	Thu, 29 Jan 2026 11:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769687993; cv=none; b=IytpkJu8BTLp/zUHTJP8L9hmgdjZLzM6SBgk09gNrnnbwBk+IyG4MrLtPQqHD9WPlCqBwF+ro2RqJmsBNcobR8oNwZm42azu4lR52YbZ3LeY2zj1WIZeSrfPG6XwnQDX9QrvzirHzbUrDTmpgAbZolGnFXZWGsD90itASwAllsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769687993; c=relaxed/simple;
	bh=WZ9/YfisJXoXJYN8Rl5hCOUb1qqqV6UazDcJEt0myBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3x5uSgbjcxin5IQN+F/82EsUDnUonqndYsBGrCwHfuCJStITh2oXn8AzySw04nOyrEOVicvvNuix457Ju3sEGYoTivZq3vDuE9pUc8+fyokEFqYNzHANuCrPHm3fNa4V8oM5THDLv2WWBN/WuPAmYcMjgIhH73gERMWbUlQHoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+5IdhFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D24C4CEF7;
	Thu, 29 Jan 2026 11:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769687992;
	bh=WZ9/YfisJXoXJYN8Rl5hCOUb1qqqV6UazDcJEt0myBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c+5IdhFDBh4dGy30IROWqL06xxOcVDc8lgV0YqbAXg5ZwBaLp+AT6ofohEKxBZHGm
	 3JQPyGsaR40cV9I/ltnY6YHvSyK1kKDZtyhJhVaG8Rkf5r9cCSEX4PNDYcGVI+/waT
	 mIhe4Sin2AmquFmkMgIpIY4JVgfMfeVFolGe5Hl0UTQOYdh5dDtBCBSBtAleSqH9QW
	 CaUhn8+cpwfCZeaDIskypGEGVhBBI7ZwWJtSmC/bpsGNbN+vTBayO7txPcr1exLsq+
	 SCMLGrHMscgl2oQ7NxkNGGZJSiRLf+ZMlEnRUobKvTtMuMvbLaibR4ywxeB5hNcfNJ
	 YEHYiSpoUgKhg==
Date: Thu, 29 Jan 2026 11:59:46 +0000
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
Subject: Re: [PATCH 3/4] phy: s32g: Add serdes xpcs subsystem
Message-ID: <aXtLsuOkMMryrUs4@horms.kernel.org>
References: <20260126092159.815968-1-vincent.guittot@linaro.org>
 <20260126092159.815968-4-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126092159.815968-4-vincent.guittot@linaro.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254776-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 19E59AFD90
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 10:21:58AM +0100, Vincent Guittot wrote:

...

> diff --git a/drivers/phy/freescale/phy-nxp-s32g-serdes.c b/drivers/phy/freescale/phy-nxp-s32g-serdes.c

...

> +static void s32g_serdes_prepare_pma_mode5(struct s32g_serdes *serdes)
> +{
> +	u32 val;
> +	/* Configure TX_VBOOST_LVL and TX_TERM_CTRL */
> +	val = readl(serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_MISC_CTRL_2);
> +	val &= ~(EXT_TX_VBOOST_LVL_MASK | EXT_TX_TERM_CTRL_MASK);
> +	val |= FIELD_PREP(EXT_TX_VBOOST_LVL_MASK, 0x3) |
> +		FIELD_PREP(EXT_TX_TERM_CTRL_MASK, 0x4);
> +	writel(val, serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_MISC_CTRL_2);

This is part of an AI Generated review.
I have looked over it and I think it warrants investigation.
For information on how to reproduce locally, as I did, please see [1].

	The entire s32g_serdes_prepare_pma_mode5() function is ~70 lines of
	magic numbers with zero explanation. These appear to be
	hardware-specific PLL/PHY tuning parameters for 2.5G mode.

Please consider using #defines, to give values names.

...

> +static int s32g_serdes_init_clks(struct s32g_serdes *serdes)
> +{
> +	struct s32g_serdes_ctrl *ctrl = &serdes->ctrl;
> +	struct s32g_xpcs_ctrl *xpcs = &serdes->xpcs;
> +	int ret, order[2], xpcs_id;
> +	size_t i;
> +
> +	switch (ctrl->ss_mode) {
> +	case 0:
> +		return 0;
> +	case 1:
> +		order[0] = 0;
> +		order[1] = XPCS_DISABLED;
> +		break;
> +	case 2:
> +	case 5:
> +		order[0] = 1;
> +		order[1] = XPCS_DISABLED;
> +		break;
> +	case 3:
> +		order[0] = 1;
> +		order[1] = 0;
> +		break;
> +	case 4:
> +		order[0] = 0;
> +		order[1] = 1;
> +		break;
> +	default:
> +		return -EINVAL;

AI review also flags that s32g_serdes_get_ctrl_resources() ensures that
ss_mode is <= 5.  So this check is unnecessary.

> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(order); i++) {
> +		xpcs_id = order[i];
> +
> +		if (xpcs_id == XPCS_DISABLED)
> +			continue;
> +
> +		ret = s32g_xpcs_init_plls(xpcs->phys[xpcs_id]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (ctrl->ss_mode == 5) {
> +		s32g_serdes_prepare_pma_mode5(serdes);
> +
> +		ret = s32g_xpcs_pre_pcie_2g5(xpcs->phys[1]);

Also from the AI review:

	In mode 5, code directly accesses xpcs->phys[1] without checking if
	it was created. If XPCS1 wasn't created for some reason (DT
	misconfiguration, probe failure), this NULL dereferences.

...

> @@ -460,6 +741,41 @@ static int s32g2_serdes_create_phy(struct s32g_serdes *serdes, struct device_nod

...

> +		xpcs = devm_kmalloc(dev, sizeof(*xpcs), GFP_KERNEL);
> +		if (IS_ERR(xpcs)) {
> +			dev_err(dev, "Failed to allocate xpcs\n");
> +			return -ENOMEM;
> +		}

AI review also flags:

	devm_kmalloc() returns NULL on failure, not an error pointer.
	This check will never trigger.

[1] https://netdev-ai.bots.linux.dev/ai-local.html

> +
> +		xpcs_ctrl->phys[port] = xpcs;
> +
> +		xpcs->an = of_property_read_bool(dev->of_node, "nxp,xpcs_an");

AI review flags that nxp,xpcs_an is not part of the binding.

...

> +struct phylink_pcs *s32g_serdes_pcs_create(struct device *dev, struct device_node *np)
> +{
> +	struct platform_device *pdev;
> +	struct device_node *pcs_np;
> +	struct s32g_serdes *serdes;
> +	u32 port;
> +
> +	if (of_property_read_u32(np, "reg", &port))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (port > S32G_SERDES_XPCS_MAX)
> +		return ERR_PTR(-EINVAL);
> +
> +	/* The PCS pdev is attached to the parent node */
> +	pcs_np = of_get_parent(np);
> +	if (!pcs_np)
> +		return ERR_PTR(-ENODEV);
> +
> +	if (!of_device_is_available(pcs_np)) {
> +		of_node_put(pcs_np);
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	pdev = of_find_device_by_node(pcs_np);
> +	of_node_put(pcs_np);
> +	if (!pdev || !platform_get_drvdata(pdev)) {
> +		if (pdev)
> +			put_device(&pdev->dev);
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	serdes = platform_get_drvdata(pdev);

Also from the AI review:

	On success, the function gets a reference to pdev but never
	releases it. This leaks a device reference every time a MAC driver
	calls s32g_serdes_pcs_create().

> +
> +	return &serdes->xpcs.phys[port]->pcs;

Also from the AI review:

	The check port > S32G_SERDES_XPCS_MAX allows port=2,
	but array only has indices 0 and 1.

Also I'm not seeing bounds checking on port in s32g2_serdes_create_phy
which uses port as an index for the same array both directly and indirectly
via s32g_serdes_xpcs_init().

...

> diff --git a/drivers/phy/freescale/phy-nxp-s32g-xpcs.c b/drivers/phy/freescale/phy-nxp-s32g-xpcs.c

...

> +static int s32g_xpcs_regmap_reg_read(void *context, unsigned int reg,
> +				     unsigned int *result)
> +{
> +	struct s32g_xpcs *xpcs = context;
> +	u16 ofsleft = (reg >> 8) & 0xffffU;
> +	u16 ofsright = (reg & 0xffU);
> +
> +	writew(ofsleft, xpcs->base + ADDR1_OFS);
> +	*result = readw(xpcs->base + (ofsright * 4));
> +
> +	return 0;
> +}
> +
> +static int s32g_xpcs_regmap_reg_write(void *context, unsigned int reg,
> +				      unsigned int val)
> +{
> +	struct s32g_xpcs *xpcs = context;
> +	u16 ofsleft = (reg >> 8) & 0xffffU;
> +	u16 ofsright = (reg & 0xffU);
> +
> +	writew(ofsleft, xpcs->base + ADDR1_OFS);
> +	writew(val, xpcs->base + (ofsright * 4));
> +
> +	return 0;
> +}
> +
> +static const struct regmap_config s32g_xpcs_regmap_config = {
> +	.reg_bits = 16,
> +	.val_bits = 16,
> +	.reg_read = s32g_xpcs_regmap_reg_read,
> +	.reg_write = s32g_xpcs_regmap_reg_write,
> +	.wr_table = &s32g_xpcs_wr_table,
> +	.rd_table = &s32g_xpcs_rd_table,
> +	.max_register = 0x1F80E1,
> +};

AI review also flags that s32g_xpcs_regmap_reg_read and
s32g_xpcs_regmap_reg_write do not protect against concurrent access.

...

