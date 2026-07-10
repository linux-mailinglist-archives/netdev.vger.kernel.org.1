Return-Path: <netdev+bounces-306607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 15hbAOYHUWrs+AIAu9opvQ
	(envelope-from <netdev+bounces-306607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 16:55:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E3F73BF77
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 16:55:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=XEmPz3pU;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306607-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306607-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 45DC8300A668
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 14:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBD23955FF;
	Fri, 10 Jul 2026 14:39:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07707349CC9
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 14:39:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694363; cv=none; b=BgsD0pe0nbUw/dFM4cCPQFNxJtqYvYNJymhC55uMaccOwyRYeGOg7royMPtbGFHhAtF1PIE7jA6O130dGjHKVxsyun27Xd7+sNLql2zz7KSxKzSUHjVI4L8jTLO1tKxqaxahXZY3iATGOeE1txgB7Qi/BuXV6h26xYoiNGIU16A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694363; c=relaxed/simple;
	bh=4Gii1ym6K9QpzVfq94PZJSdWoP7NnEix+aBSrFpPCIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0kcCZv91luFP+WwResSa45f8D+BT7hFHBX0XS1mG+HzBPkIvMrfjkztZulEimKRzs2vLxBgSoAO0dnfsIJwCSKXn/tSyOoIPdIsE/Ipz7/zakSCd4hZqu8LDqdvE4WlLpzW4kupBKCwNg97Dlcrqho6/1vMmAa4nWTRA2Is+ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XEmPz3pU; arc=none smtp.client-ip=91.218.175.189
Message-ID: <a5c5b8a6-85a8-7830-e19b-ffd5de750e3c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783694349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7QFfQEvWIc8hC7yQXMHVs3FeaASqXtgVk5YNjOkXDQE=;
	b=XEmPz3pUI7UmGCNy0ohkq9/USDv+N0QFWPCEGJ1cxiuPA77A3xsmAqqU/7SLLi1HhOSJrf
	hhSlBrNgATMMFi4vVfAwiLbKvUsTZ8NQ/B/6/jA6wWWa2zMaK3bbQqb9E3NrW+ZNFlJDyf
	BWyeEUMKQsNnduL221Z7cKL44RujoJo=
Date: Fri, 10 Jul 2026 10:39:03 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] net: dpaa: fix mode setting
Content-Language: en-US
To: Michael Walle <mwalle@kernel.org>, Madalin Bucur <madalin.bucur@nxp.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260710143430.2276141-1-mwalle@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20260710143430.2276141-1-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306607-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[sean.anderson@linux.dev,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mwalle@kernel.org,m:madalin.bucur@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.anderson@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3E3F73BF77

On 7/10/26 10:22, Michael Walle wrote:
> Before converting to the phylink interface, the init function would have
> set the correct I/F mode depending on the maximum link speed of an
> interface. After converting to phylink, the established link speed
> is used to determine this setting and is set in the .link_up()
> callback. The callback isn't called because the link is never
> established between the PCS and a connected SGMII PHY.
> To fix it, don't use the current speed, but set the mode depending on
> the interface (which implies the maximum speed) in .mac_config().
> 
> Fixes: 5d93cfcf7360 ("net: dpaa: Convert to phylink")
> Suggested-by: Sean Anderson <sean.anderson@linux.dev>
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
> FWIW, I dropped setting a non-reserved mode in init(). The hardware
> default is 0 and the mac_config() will set a valid mode anyway.
> 
> Changes in v2:
>   - the setting is/was based on the maximum speed, not the current
>     speed. thus, move the setting into mac_config().
>   - Link to v1: https://lore.kernel.org/r/20260706121011.1948906-1-mwalle@kernel.org/
> 
>   .../net/ethernet/freescale/fman/fman_dtsec.c  | 26 ++++++++++---------
>   1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
> index fe35703c509e..7075f93bab49 100644
> --- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
> +++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
> @@ -900,22 +900,28 @@ static void dtsec_mac_config(struct phylink_config *config, unsigned int mode,
>   {
>   	struct mac_device *mac_dev = fman_config_to_mac(config);
>   	struct dtsec_regs __iomem *regs = mac_dev->fman_mac->regs;
> -	u32 tmp;
> +	u32 ecntrl, maccfg2;
> +
> +	maccfg2 = ioread32be(&regs->maccfg2);
> +	maccfg2 &= ~(MACCFG2_NIBBLE_MODE | MACCFG2_BYTE_MODE);
>   
>   	switch (state->interface) {
>   	case PHY_INTERFACE_MODE_RMII:
> -		tmp = DTSEC_ECNTRL_RMM;
> +		ecntrl = DTSEC_ECNTRL_RMM;
> +		maccfg2 |= MACCFG2_NIBBLE_MODE;
>   		break;
>   	case PHY_INTERFACE_MODE_RGMII:
>   	case PHY_INTERFACE_MODE_RGMII_ID:
>   	case PHY_INTERFACE_MODE_RGMII_RXID:
>   	case PHY_INTERFACE_MODE_RGMII_TXID:
> -		tmp = DTSEC_ECNTRL_GMIIM | DTSEC_ECNTRL_RPM;
> +		ecntrl = DTSEC_ECNTRL_GMIIM | DTSEC_ECNTRL_RPM;
> +		maccfg2 |= MACCFG2_BYTE_MODE;
>   		break;
>   	case PHY_INTERFACE_MODE_SGMII:
>   	case PHY_INTERFACE_MODE_1000BASEX:
>   	case PHY_INTERFACE_MODE_2500BASEX:
> -		tmp = DTSEC_ECNTRL_TBIM | DTSEC_ECNTRL_SGMIIM;
> +		ecntrl = DTSEC_ECNTRL_TBIM | DTSEC_ECNTRL_SGMIIM;
> +		maccfg2 |= MACCFG2_BYTE_MODE;
>   		break;
>   	default:
>   		dev_warn(mac_dev->dev, "cannot configure dTSEC for %s\n",
> @@ -923,7 +929,8 @@ static void dtsec_mac_config(struct phylink_config *config, unsigned int mode,
>   		return;
>   	}
>   
> -	iowrite32be(tmp, &regs->ecntrl);
> +	iowrite32be(ecntrl, &regs->ecntrl);
> +	iowrite32be(maccfg2, &regs->maccfg2);
>   }
>   
>   static void dtsec_link_up(struct phylink_config *config, struct phy_device *phy,
> @@ -948,15 +955,10 @@ static void dtsec_link_up(struct phylink_config *config, struct phy_device *phy,
>   	iowrite32be(tmp, &regs->ecntrl);
>   
>   	tmp = ioread32be(&regs->maccfg2);
> -	tmp &= ~(MACCFG2_NIBBLE_MODE | MACCFG2_BYTE_MODE | MACCFG2_FULL_DUPLEX);
> -	if (speed >= SPEED_1000)
> -		tmp |= MACCFG2_BYTE_MODE;
> -	else
> -		tmp |= MACCFG2_NIBBLE_MODE;
> -
>   	if (duplex == DUPLEX_FULL)
>   		tmp |= MACCFG2_FULL_DUPLEX;
> -
> +	else
> +		tmp &= ~MACCFG2_FULL_DUPLEX;

Did you test this when forcing 10/100 speed?

>   	iowrite32be(tmp, &regs->maccfg2);
>   
>   	mac_dev->update_speed(mac_dev, speed);

If so,

Reviewed-by: Sean Anderson <sean.anderson@linux.dev>

