Return-Path: <netdev+bounces-253238-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBU5CVCWdml6SgEAu9opvQ
	(envelope-from <netdev+bounces-253238-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:16:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAB982A65
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AFF03007941
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51C630E0C5;
	Sun, 25 Jan 2026 22:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVC1RG8m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CA32FC891
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 22:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769379394; cv=none; b=AQ/oh0Ao+CwJnD48iyGnxgFUH0SLBYYdTaZlY/Rb9uX0ii5T5kC/WL/Aq1ylhzX3b0MdOnfJTbN2NpAKhi3ceeBGwJGaMsay+oJyJzNWcxF6ltvraN2WOAN7XxZ3qexjwOJ8AsweTeV8dtEJtBabU/fLSN6UEPzNqcvIrNfa2E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769379394; c=relaxed/simple;
	bh=OEKubGr3hY5a5xOVN3rLMvcTBl4TpWU/SIwppQrSWZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bho7KnH47l6qYiTAd8eQuqdsn07M10ZXSsbbKW8gaGdJm05xGsIlmhTMgoBNgIvhpwErfdAXS/1QC9iJ5G7hJMfRTT6u+LXBzjvU5mH+bUzi3MHw0xCts70I3MgDQEh83R4QImYEc03rFpJX5t+owEj+FUPxeh12uNXc3+kU31Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVC1RG8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97C0C19425;
	Sun, 25 Jan 2026 22:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769379394;
	bh=OEKubGr3hY5a5xOVN3rLMvcTBl4TpWU/SIwppQrSWZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LVC1RG8mh2klyraPJhN3DvpajxYAguCSbvBvWYpoPMcL2i4ldFU7OEuGeJNc3Ed3x
	 P4lw1apJZ3PIR++RZCynsg7sQNPWIQMqndzO0FNC1+un62PqZ6h4mF0PtfpyxY0Uf0
	 5+jBJQ3dpHd6ZMNpIZN+YKE8ryaEW6CTrUbLZ1mLYahbFSq8vNxto8527vGeqmfknp
	 0ZGa5hg0U32UR6WNjB5pl4Nn8MyRY2hmu6+Glr+v87wN1oQ29aFdm2Qml+0A5SK+PY
	 1gTRxMgEfy0H+kQLPaHWbBVP4nGv+DYJoVtqtAKaLl4teix/5IjROiirS66OmPKGDx
	 YeM7cFtbBqf9w==
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
Subject: Re: [net-next,19/21] net: stmmac: rk: rk3528: gmac0 only supports RMII
Date: Sun, 25 Jan 2026 14:16:32 -0800
Message-ID: <20260125221632.3396270-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <E1vjEvK-00000005ghP-3lCt@rmk-PC.armlinux.org.uk>
References: <E1vjEvK-00000005ghP-3lCt@rmk-PC.armlinux.org.uk>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-253238-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url]
X-Rspamd-Queue-Id: 8EAB982A65
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: stmmac: rk: rk3506, rk3528 and kk3588 have rmii_mode in clock register

This commit moves the rmii_mode configuration for rk3506, rk3528, and
rk3588 from the per-SoC set_to_rmii() functions into the centralized
rk_gmac_powerup() function, using a new clock.rmii_mode_mask field.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index ebbc09ea572a..759deb66ef2a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c

[ ... ]

> @@ -987,6 +966,7 @@ static int rk3588_init(struct rk_priv_data *bsp_priv)
>  		bsp_priv->clock.gmii_clk_sel_mask = GENMASK_U16(3, 2);
>  		bsp_priv->clock.rmii_clk_sel_mask = BIT_U16(2);
>  		bsp_priv->clock.rmii_gate_en_mask = BIT_U16(1);
> +		bsp_priv->clock.rmii_mode_mask = BIT_U16(0);
>  		return 0;

[ ... ]

> @@ -1412,6 +1385,15 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
>  			return ret;
>  	}
>
> +	if (bsp_priv->clock.rmii_mode_mask) {
> +		val = rk_encode_wm16(ret == PHY_INTF_SEL_RMII,
> +				     bsp_priv->clock.rmii_mode_mask);

For rk3588, the variable ret has been overwritten by the preceding
regmap_write() in the gmac_phy_intf_sel_mask block. At this point ret
contains 0 (success) rather than PHY_INTF_SEL_RMII (4).

Looking at rk_gmac_powerup(), the flow for rk3588 is:

    ret = rk_get_phy_intf_sel(bsp_priv->phy_iface);  // ret = 4 for RMII
    ...
    if (bsp_priv->gmac_phy_intf_sel_mask || ...)     // true for rk3588
        ...
        ret = regmap_write(...);                     // ret = 0 on success
    ...
    if (bsp_priv->clock.rmii_mode_mask)              // true for rk3588
        val = rk_encode_wm16(ret == PHY_INTF_SEL_RMII, ...);  // 0 == 4 is false

Since rk3588_init() sets both gmac_phy_intf_sel_mask and
clock.rmii_mode_mask, does this mean RMII mode can never be correctly
configured for rk3588?

> +
> +		ret = rk_write_clock_grf_reg(bsp_priv, val);
> +		if (ret < 0)
> +			return ret;
> +	}

[ ... ]

