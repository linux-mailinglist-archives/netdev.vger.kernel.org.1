Return-Path: <netdev+bounces-267937-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNsSEyXetmlMJwEAu9opvQ
	(envelope-from <netdev+bounces-267937-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 17:28:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D16B62916DF
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 17:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7752A3009F32
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 16:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7E0371D19;
	Sun, 15 Mar 2026 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7LkekBr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563962F2914;
	Sun, 15 Mar 2026 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773592096; cv=none; b=TWwes9EDqabufiuehOehnDCZRAezVqXqfolAJfwU7WwMGxHANMM6wqijKPD1cIy+PmyQGMY8ZZjba3Eh3pHwLypEkhr1hfuORJ9aKS+F7UdTUFy9dydo0o23pT+Kjhuon9v+aS6PGc3+4FG9noDfYMwIzHz9tLPZG/qxq0YfmGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773592096; c=relaxed/simple;
	bh=xOjKR0tFQLh7NVKP3TuLU6yEiJpBek/7xxzo0eG2SsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBPYljSWPmlz2BDdgV4HfvorkbHyjBkw/aZZVrHdiaCaguLZASd6iDxz65gpErRVbxGwgj+s6/Z/OLy3VSQ1U5AG6IaKVhEWcMnNwu5orT5vmTrMBLkOpwQ4uj8q1nb4WM3ca2re0BYDw5u9AElt/DVDR37Dy6i8XOJAdXzm9PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7LkekBr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97E1C4CEF7;
	Sun, 15 Mar 2026 16:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773592096;
	bh=xOjKR0tFQLh7NVKP3TuLU6yEiJpBek/7xxzo0eG2SsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g7LkekBrPJ9cKt/zbK+Lo5Xfhdj3uJc5sNkE8qRDj9+aYIpOrz7GPNnbQ4TdC8GUc
	 6GmCGs58jD6kKrvf+CAztmbX8gJTuPsJ6dgzCfxBWtRG81On1wtBnirmdNnJ3MFxgQ
	 a6Jm3xF0RzTobFkLPSN3HzEjy5Iheldwz+WvOtjtfqzADfEbbZVoesidFnPkw41qte
	 ydXYJS/4EmXl14omp/KQBYmMlQhC7uhtCHvFw2na3xwE228IBwvydRweuL4woSjER0
	 WAsbhlPqvR5a6HR26rn2XBjTcAuIzzxZ9o8ylRAbYiUmWnWMd1AF50dSs0n0sdoXXV
	 UoqKB4okRRJcQ==
From: Simon Horman <horms@kernel.org>
To: lizhi2@eswincomputing.com
Cc: Simon Horman <horms@kernel.org>,
	alexandre.torgue@foss.st.com,
	devicetree@vger.kernel.org,
	alex@ghiti.fr,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	ningyu@eswincomputing.com,
	linux-riscv@lists.infradead.org,
	krzk+dt@kernel.org,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	conor+dt@kernel.org,
	weishangjuan@eswincomputing.com,
	kuba@kernel.org,
	robh@kernel.org,
	edumazet@google.com,
	pjw@kernel.org,
	rmk+kernel@armlinux.org.uk,
	palmer@dabbelt.com,
	mcoquelin.stm32@gmail.com,
	pinkesh.vaghela@einfochips.com,
	linux-kernel@vger.kernel.org,
	pritesh.patel@einfochips.com,
	pabeni@redhat.com,
	aou@eecs.berkeley.edu,
	wens@kernel.org,
	netdev@vger.kernel.org,
	linmin@eswincomputing.com
Subject: Re: [net-next,v4,2/3] net: stmmac: eic7700: enable clocks before syscon access and correct RX sampling timing
Date: Sun, 15 Mar 2026 16:27:35 +0000
Message-ID: <20260315162735.1427325-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313075416.1607-1-lizhi2@eswincomputing.com>
References: <20260313075416.1607-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,foss.st.com,vger.kernel.org,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com,eswincomputing.com,davemloft.net,lunn.ch,google.com,armlinux.org.uk,dabbelt.com,gmail.com,einfochips.com,redhat.com,eecs.berkeley.edu];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_FROM(0.00)[bounces-267937-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: D16B62916DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: stmmac: eic7700: enable clocks before syscon access and correct RX sampling timing

The second Ethernet controller (eth1) on the Eswin EIC7700 SoC may fail
to sample RX data correctly at Gigabit speed due to EIC7700-specific
receive clock to data skew at the MAC input in the silicon. The existing
internal delay configuration does not provide sufficient adjustment range
to compensate for this condition at 1000Mbps. Update the EIC7700 DWMAC
glue driver to apply EIC7700-specific clock sampling inversion only
during Gigabit operation on MAC instances that require it.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
> index bcb8e000e720..b230bc5b902a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c

[ ... ]

> @@ -61,8 +81,26 @@ static int eic7700_clks_config(void *priv, bool enabled)
>  static int eic7700_dwmac_init(struct device *dev, void *priv)
>  {
>  	struct eic7700_qos_priv *dwc = priv;
> +	int ret;
> +
> +	ret = eic7700_clks_config(dwc, true);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(dwc->eic7700_hsp_regmap,
> +			      dwc->eth_phy_ctrl_offset,
> +			      EIC7700_ETH_TX_CLK_SEL |
> +			      EIC7700_ETH_PHY_INTF_SELI);
> +	if (ret)
> +		return ret;

Does this code leak the enabled clocks? The function calls
eic7700_clks_config(dwc, true) to enable the clocks, then later calls
regmap_set_bits(). If regmap_set_bits() fails, the function returns
without disabling the clocks.

Looking at the caller in stmmac_main.c:stmmac_dvr_probe():

    if (priv->plat->init) {
        ret = priv->plat->init(priv->device, priv->plat->bsp_priv);
        if (ret)
            return ret;
    }

    ret = __stmmac_dvr_probe(priv->device, priv->plat, &res);
    if (ret)
        goto error_exit_init;

The exit handler is only called when __stmmac_dvr_probe() fails, not
when init() fails. This leaves the bulk clocks in the prepared-and-enabled
state on this error path.

> +
> +	regmap_write(dwc->eic7700_hsp_regmap, dwc->eth_axi_lp_ctrl_offset,
> +		     EIC7700_ETH_CSYSREQ_VAL);
>
> -	return eic7700_clks_config(dwc, true);
> +	regmap_write(dwc->eic7700_hsp_regmap, dwc->eth_txd_offset, 0);
> +	regmap_write(dwc->eic7700_hsp_regmap, dwc->eth_rxd_offset, 0);
> +
> +	return 0;
>  }

[ ... ]

