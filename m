Return-Path: <netdev+bounces-303488-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WRsfFMK4RGoxzgoAu9opvQ
	(envelope-from <netdev+bounces-303488-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 08:50:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBF86EA55D
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 08:50:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=dsZjbIHy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303488-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303488-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDBE83055D69
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 06:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30E43B19CD;
	Wed,  1 Jul 2026 06:50:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CFB394464;
	Wed,  1 Jul 2026 06:49:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782888600; cv=none; b=brwM1rW7h6bM/yO/4CIAbH6yAqJzVMZVhaGokrT8RU2knnRii/M3FiBXRKGLXXQpEFXhAi1k1/GAUgqEVY86juQQ8PSgaSSlsqYv2y3YQ1GBHSRb4020YLgs/tiGCRwl9j4CxZCvJs8mCHvXhtPH2qAdNpF9vPC/BNVolIKO62Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782888600; c=relaxed/simple;
	bh=2FjNShPuvMhSCa8aCIVcHDUXE7fQvQOTF5pqcEUnxNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=trJzwLl1oHX/960nHrOae9e5OnJGRJJ5zgVLWwl+O8vc9JpqmLTYsDORtsVO0tGkuYqedE1loH83FJRTAHyVSl3k946OQBtvjH6MVGTCJzlLTmMsYgNHa7Zub+DyXFRB9xlVd1b3lgd7T+LqO4fUfndLYjwypzEMSlN3aAU3vYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dsZjbIHy; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DE6F71A0DA4;
	Wed,  1 Jul 2026 06:49:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9DDDD60288;
	Wed,  1 Jul 2026 06:49:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 456F2104C998E;
	Wed,  1 Jul 2026 08:49:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782888593; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=mVeRRJJSZeObgGNAULymnreJVn5f+SfTJtLSNLvtxrU=;
	b=dsZjbIHyHqKbtNQgFtTpEmSmyzCKQ7Bqkrs+wIv64J3pAN2yA9llX5SJd2drVb0BFDtWcP
	D0x2IIDqvmtxF2dXJOnh7ebPykzEBIhHaBoWMDOr+zjssqu7hPKgQtUpVGPObByHIkurYm
	U11hDLemXrwlJCfWuL9kouozaGqSifrJh2k1rmKFMF2paiBOjgyXU1NFFo4P5R1hK0c+s+
	2twCQoDUUG0MBesiqroBqWoPI5lm2WmogR2uZr3zYcwF+sx1NFeDBdqCcmi65KTdiIob2p
	y86oqdjnFwakf0YdGy2B7sRrQnMjUX1ROvtm5gbnwQyz5Drewewdak8EDhj9WA==
Message-ID: <7d33f825-01a8-48bf-930a-5b1db80d8ee5@bootlin.com>
Date: Wed, 1 Jul 2026 08:49:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] net: stmmac: dwmac-socfpga: Add mac-mode DT property
 support
To: muhammad.nazim.amirul.nazle.asmade@altera.com, dinguyen@kernel.org
Cc: rmk+kernel@armlinux.org.uk, krzk+dt@kernel.org, conor+dt@kernel.org,
 robh@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260630133108.27244-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260630133108.27244-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260630133108.27244-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303488-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:muhammad.nazim.amirul.nazle.asmade@altera.com,m:dinguyen@kernel.org,m:rmk+kernel@armlinux.org.uk,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robh@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rmk@armlinux.org.uk,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,altera.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DBBF86EA55D

Hi,

On 6/30/26 15:31, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> Russell King's commit de696c63c1dc ("net: stmmac: socfpga: convert to
> use phy_interface") replaced mac_interface with phy_interface in
> socfpga_get_plat_phymode(), noting that no upstream DTS files set the
> "mac-mode" property, making the two values identical.
> 
> The Agilex5 SoCDK TSN Config2 board is an exception: its gmac1 TSN
> port uses GMII internally in the MAC while the PHY-side interface is
> RGMII, so mac-mode and phy-mode differ. Without restoring mac_interface
> support, the MAC is configured with RGMII instead of GMII, causing
> connectivity failures on this board.
> 
> Add socfpga_of_get_mac_mode() to read the optional "mac-mode" DT
> property and store it in a new mac_interface field. When the property
> is absent, mac_interface falls back to phy_interface, preserving
> the existing behaviour for all other boards.

After our discussions, indeed mac-mode seems to be the way to go, however
I have some remarks on how it's handled right now.

> 
> Fixes: de696c63c1dc ("net: stmmac: socfpga: convert to use phy_interface")
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-socfpga.c   | 23 ++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> index 1d7f0a57d288..6a6837c4a414 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> @@ -69,12 +69,30 @@ struct socfpga_dwmac {
>  	void __iomem *tse_pcs_base;
>  	void __iomem *sgmii_adapter_base;
>  	bool f2h_ptp_ref_clk;
> +	phy_interface_t mac_interface;
>  	const struct socfpga_dwmac_ops *ops;
>  };
>  
> +static int socfpga_of_get_mac_mode(struct device_node *np)
> +{
> +	const char *pm;
> +	int err, i;
> +
> +	err = of_property_read_string(np, "mac-mode", &pm);
> +	if (err < 0)
> +		return err;
> +
> +	for (i = 0; i < PHY_INTERFACE_MODE_MAX; i++) {
> +		if (!strcasecmp(pm, phy_modes(i)))
> +			return i;
> +	}
> +
> +	return -ENODEV;
> +}
> +
>  static phy_interface_t socfpga_get_plat_phymode(struct socfpga_dwmac *dwmac)
>  {
> -	return dwmac->plat_dat->phy_interface;
> +	return dwmac->mac_interface;
>  }

Taking a look at the logic in socfpga_gen{5|10}_set_phy_mode(), we have :

  phy_interface_t phymode = socfpga_get_plat_phymode(dwmac);
  u32 val;

  socfpga_set_phy_mode_common(phymode, &val)

  if (dwmac->splitter_base)
	  val = SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_GMII_MII;

[...]

  if (phymode == PHY_INTERFACE_MODE_SGMII)
	  socfpga_sgmii_config(dwmac, true);



With this new patch, we now have 2 different ways of handling this
converter block (splitter presence, and mac-mode presence in DT)

Can you unify this a bit ?

One thing could be adding a helper to get the macmode such as
socfpga_get_plat_macmode()

I think we should move the splitter handling before calling 
socfpga_get_plat_macmode() :

 if (dwmac->splitter_base)
   	dwmav->mac_interface = PHY_INTERFACE_MODE_GMII

We'd get the intf_sel value based on the macmode, and also calls to
helpers such as socfpga_sgmii_config(phymode, xxx) need the actual
phymode as a parameter, not the macmode.

Thanks :)

Maxime



