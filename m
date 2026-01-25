Return-Path: <netdev+bounces-253240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBD+GpCWdml6SgEAu9opvQ
	(envelope-from <netdev+bounces-253240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:17:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C378C82A89
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C635301ABA8
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C31030594E;
	Sun, 25 Jan 2026 22:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLVoODqI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593AB1DDC3F
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 22:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769379398; cv=none; b=l21LLGOFQRcvnUk4J3mjQJj9/uNbSefG4D0FoQsE0EXqyi+pjjkV+GXAMSVU3uCyM0Nr2e8FonrLvg9CBVhQ6R2vJ9FpY3DML1kXpMAZuRDj6xd99n8p0HZlyDF2utGaInSYzTRVV4Vm1ohglUwM/rwX75D11dHwe7Xio8jJiDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769379398; c=relaxed/simple;
	bh=LmmZJZI79asCLMPi5aZ4+J3qsvgagrp0jkKqM4T2DNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnYjWNHRx51kQ1/T+aONGSnasEs2jriGCW6nJtR2USd/fCJI7tOocnELM+WGNtGlwxa18xAADlf3puBYRa8/qLhqszJxLPDJhY7UJuKrCQPG6fLBq11XLt8Z4aE50+VKRUcz8x0ocPZlsrEiw5Kq4v8WlknPMRagyNx0lR19w24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLVoODqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687AEC4CEF1;
	Sun, 25 Jan 2026 22:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769379397;
	bh=LmmZJZI79asCLMPi5aZ4+J3qsvgagrp0jkKqM4T2DNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FLVoODqIPzzzBNLL8gike2sj+iyIVEMzCg/NnT2zt/WerdLI80Z5bP90aJyizHYyx
	 rEAJkyOWCY3KeFBUG2Z93Z98RWr48dP6jKtvcYhbBCRPA9O22ifXvqKIsYzkRLSLiq
	 RJ+AYZCgpdFVBt46ROYYHCXN4u0aIAGOkRqPUbe6hxYi98x/Ce6fbOv/JSCRiViQ1P
	 nNfMayWDsH4Fopi55qmgAeLeYYbpEFARu9IFgOfhNq8B78+4KBW+qprj1aWnetZwCH
	 Fd+PbBbLbuBoHx80w5I3naIizZfFDNr71ddQH9/Unbt9D6jPTT1smsgVIuhEvnB2bM
	 s8KN+a8PWvejA==
From: Jakub Kicinski <kuba@kernel.org>
To: rmk+kernel@armlinux.org.uk
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	andrew@lunn.ch,
	davem@davemloft.net,
	alexandre.torgue@foss.st.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	heiko@sntech.de,
	andrew+netdev@lunn.ch,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [net-next,21/21] net: stmmac: rk: rk3506, rk3528 and kk3588 have rmii_mode in clock register
Date: Sun, 25 Jan 2026 14:16:36 -0800
Message-ID: <20260125221636.3396323-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <E1vjEvV-00000005ghc-0ZkO@rmk-PC.armlinux.org.uk>
References: <E1vjEvV-00000005ghc-0ZkO@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-253240-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C378C82A89
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: stmmac: rk: rk3506, rk3528 and kk3588 have rmii_mode in clock register

This commit moves the RMII mode bit configuration from the dedicated
set_to_rmii() functions to rk_gmac_powerup() using a new rmii_mode_mask
field in the clock register structure.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index ebbc09ea572a..759deb66ef2a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c

[ ... ]

> @@ -1412,6 +1385,15 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
>  			return ret;
>  	}

For context, prior to this hunk, ret is set by rk_get_phy_intf_sel() to
hold the PHY interface value (e.g., PHY_INTF_SEL_RMII = 4). Then in the
block above (not shown here), if gmac_phy_intf_sel_mask is set, there is:

    ret = regmap_write(bsp_priv->grf, bsp_priv->gmac_grf_reg, val);

This overwrites ret with the regmap_write() return value (0 on success).

> +	if (bsp_priv->clock.rmii_mode_mask) {
> +		val = rk_encode_wm16(ret == PHY_INTF_SEL_RMII,
> +				     bsp_priv->clock.rmii_mode_mask);

For rk3588, gmac_phy_intf_sel_mask is set in rk3588_init(), so the
previous block executes and ret becomes 0. Then here, the comparison
ret == PHY_INTF_SEL_RMII evaluates to 0 == 4, which is always false.

This means the RMII mode bit will never be set for rk3588 in RMII mode.
Should this use bsp_priv->phy_iface == PHY_INTERFACE_MODE_RMII instead,
or should the PHY interface value be saved to a separate variable before
it gets overwritten?

> +
> +		ret = rk_write_clock_grf_reg(bsp_priv, val);
> +		if (ret < 0)
> +			return ret;
> +	}

[ ... ]

