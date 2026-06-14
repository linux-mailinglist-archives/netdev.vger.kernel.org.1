Return-Path: <netdev+bounces-299174-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zgYBIXJYLmo1twQAu9opvQ
	(envelope-from <netdev+bounces-299174-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 09:29:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D86EF680917
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 09:29:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=v8NmUSFO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299174-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299174-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D2B53022069
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 07:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FF43939B1;
	Sun, 14 Jun 2026 07:28:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A0238D006
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 07:28:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781422111; cv=none; b=DAj0wMBbW2AdSyQKy4DGX08nA/c7Iuc9OnFkLJXwXR9LbDJzev8oFhzfKx4BdcVqh+MmRIkpDsMEPOJsDtYAVOOJN4c6XysY4pdsxd1djLT5GfFxB++7ihMqFRucfQEPCrSH3R/wr9MUG7gZgbeyAJlL/Rj1ITc9prDJzfJMaG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781422111; c=relaxed/simple;
	bh=bECMYOPYUqZlpw/VV2Rubu/aFJZdOOrGNKt9q4WwtPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YHOPAaIRzWgAPe3GZAy9IYiRg73cbNMXNgqE8CuPYjkh3ZUOL7+9M+EP6ZiD0dYXRe5lvk/qbHE61wtJSjWfk03VWOJLZ1/LXxnAOeDINhU2WbV2bxnrwq//W1XougHfzcSFbUIwuOBIdeXYEXMZDeEwYmiJsLeVI/myZg050Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=v8NmUSFO; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 29970C2BB20
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 07:28:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6FA2460014;
	Sun, 14 Jun 2026 07:28:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2AB91106C898D;
	Sun, 14 Jun 2026 09:28:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781422100; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=nvXgsoZvrQH/u2rhcGoSAkyYDPUbfVN5pXwmA7bDxoY=;
	b=v8NmUSFOt2VarEUTIlsTdjAvxfmKPLjbQMxJVSRzE74bMaJVW41Szjv+/Xrkr63DxPM6Ed
	97U88ZOXa/kxHA8Cvb/z5LZQJNsDKFWJkq9idgx0AXKhqhmMjTr4eyZ3FgixNqQHhcf0mR
	LPYISG83BP5kRg6wbqn+qGcmkpAC1U/fH4+fIsKj4G90w45UMshK4mhaLb5iLyUQKCwYbX
	/2a8vhA4eNhyZ/t/NX2dvz5yVV58sqWntkbBjaT5uZ7sa1yfwzl9nZUVPaUulJBuB+LChu
	PgaWvkU5+Jz6KmvrIIn8B3rLb55fakm9c1QHX14fTjBad7Tcvs9zx2v1kiVcpQ==
Message-ID: <63983efb-dcad-4b34-9d35-4086de11be5e@bootlin.com>
Date: Sun, 14 Jun 2026 09:28:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net: dsa: realtek: rtl8365mb: add SGMII
 support for RTL8367S
To: Johan Alvarado <contact@c127.dev>, linusw@kernel.org,
 alsi@bang-olufsen.dk, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, namiltd@yahoo.com, luizluca@gmail.com,
 linux-kernel@vger.kernel.org
References: <20260613232136.24246-1-contact@c127.dev>
 <0100019ec34adee6-37e8121b-823b-460e-b6bf-98588994adc8-000000@email.amazonses.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <0100019ec34adee6-37e8121b-823b-460e-b6bf-98588994adc8-000000@email.amazonses.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299174-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:contact@c127.dev,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux@armlinux.org.uk,m:namiltd@yahoo.com,m:luizluca@gmail.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[c127.dev,kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[armlinux.org.uk,yahoo.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,bootlin.com:dkim,bootlin.com:mid,bootlin.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D86EF680917

Hi Johan,

On 6/14/26 01:22, Johan Alvarado wrote:
> The RTL8367S can mux its embedded SerDes to external interface 1,
> which is typically used to connect the switch to a CPU port. The chip
> info table already declares SGMII as a supported interface mode for
> this chip, but the driver only implements RGMII so far.
> 
> Implement SGMII support, with the configuration sequence derived from
> the GPL-licensed Realtek rtl8367c vendor driver as distributed in the
> Mercusys MR80X GPL code drop:
> 
>  - Add accessors for the SerDes indirect access registers (SDS_INDACS),
>    through which the SerDes internal registers are reached.
> 
>  - Keep the embedded DW8051 microcontroller in reset and disabled. The
>    vendor driver loads firmware into it to manage the SerDes link, but
>    analysis of that firmware shows it only duplicates the link
>    management phylink already performs: it polls the port status and
>    writes the external interface force registers behind the driver's
>    back.
> 
>  - Clear the line rate bypass bit for the external interface, tune the
>    SerDes with the vendor-prescribed parameters, mux the SerDes to MAC8
>    in SGMII mode and only then take the SerDes out of reset, as the
>    vendor driver does.
> 
>  - After deasserting the SerDes reset, reset the SerDes data path via
>    the SerDes BMCR register to flush the FIFOs and resync the PLL.
>    This mirrors what the vendor firmware does right after deasserting
>    the SerDes reset, and ensures a clean link state from cold boot.
> 
>  - Force the SGMII link parameters (link, speed, duplex, flow control)
>    in the SDS_MISC register from the phylink mac_link_up/down
>    operations, in addition to the usual external interface force
>    configuration. SGMII in-band autonegotiation is disabled, so only
>    fixed-link and conventional PHY setups are supported, just like
>    RGMII.
> 
> Tested on a Mercusys MR80X v2.20, where the RTL8367S is connected to
> the SoC over SGMII.
> 
> Suggested-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Signed-off-by: Johan Alvarado <contact@c127.dev>
> ---

[...]

> +static int rtl8365mb_ext_config_sgmii(struct realtek_priv *priv, int port)
> +{
> +	const struct rtl8365mb_extint *extint =
> +		rtl8365mb_get_port_extint(priv, port);
> +	u16 val;
> +	int ret;
> +	int i;
> +
> +	if (!extint)
> +		return -ENODEV;
> +
> +	/* The SerDes can only be muxed to external interface 1 */
> +	if (extint->id != 1)
> +		return -EOPNOTSUPP;
> +
> +	/* Hold the embedded DW8051 microcontroller in reset and keep it
> +	 * disabled. The vendor driver loads firmware into it to manage the
> +	 * SerDes link, but the firmware only duplicates work that phylink
> +	 * already does: it polls the port status and forces the external
> +	 * interface configuration in the very registers this driver manages.
> +	 * Letting it run would race with phylink.
> +	 */
> +	ret = regmap_update_bits(priv->map, RTL8365MB_CHIP_RESET_REG,
> +				 RTL8365MB_CHIP_RESET_DW8051_MASK,
> +				 RTL8365MB_CHIP_RESET_DW8051_MASK);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->map, RTL8365MB_MISC_CFG0_REG,
> +				 RTL8365MB_MISC_CFG0_DW8051_EN_MASK, 0);
> +	if (ret)
> +		return ret;
> +
> +	/* The vendor driver clears the line rate bypass for all interface
> +	 * modes except TMII.
> +	 */
> +	ret = regmap_update_bits(priv->map, RTL8365MB_BYPASS_LINE_RATE_REG,
> +				 BIT(extint->id), 0);
> +	if (ret)
> +		return ret;
> +
> +	/* Tune the SerDes with vendor-prescribed parameters */
> +	for (i = 0; i < ARRAY_SIZE(rtl8365mb_sds_jam_sgmii); i++) {
> +		ret = rtl8365mb_sds_write(priv, 0,
> +					  rtl8365mb_sds_jam_sgmii[i].reg,
> +					  rtl8365mb_sds_jam_sgmii[i].val);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Mux the SerDes to MAC8 in SGMII mode */
> +	ret = regmap_update_bits(priv->map, RTL8365MB_SDS_MISC_REG,
> +				 RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK |
> +					 RTL8365MB_SDS_MISC_MAC8_SEL_HSGMII_MASK,
> +				 RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(
> +		priv->map, RTL8365MB_DIGITAL_INTERFACE_SELECT_REG(extint->id),
> +		RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK(extint->id),
> +		RTL8365MB_EXT_PORT_MODE_SGMII
> +			<< RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_OFFSET(
> +				   extint->id));
> +	if (ret)
> +		return ret;
> +
> +	/* Take the SerDes out of reset. The vendor driver does this only
> +	 * after the SerDes mux and the interface mode are configured.
> +	 */
> +	ret = rtl8365mb_sds_write(priv, 0, RTL8365MB_SDS_REG_RESET,
> +				  RTL8365MB_SDS_RESET_DEASSERT);
> +	if (ret)
> +		return ret;
> +
> +	/* Reset the SerDes data path and resync its PLL, mirroring what the
> +	 * vendor firmware does right after deasserting the SerDes reset.
> +	 * This flushes the FIFOs and ensures a clean state for the link,
> +	 * preventing silent drops and CRC errors.
> +	 */
> +	ret = rtl8365mb_sds_write(priv, 0, RTL8365MB_SDS_REG_BMCR,
> +				  RTL8365MB_SDS_BMCR_DPRST_PHASE1);
> +	if (ret)
> +		return ret;
> +
> +	ret = rtl8365mb_sds_write(priv, 0, RTL8365MB_SDS_REG_BMCR,
> +				  RTL8365MB_SDS_BMCR_DPRST_PHASE2);
> +	if (ret)
> +		return ret;
> +
> +	/* Disable SGMII in-band autonegotiation: the link parameters are
> +	 * forced in rtl8365mb_phylink_mac_link_up.
> +	 */

This comment implies that you could deal with SGMII aneg at some point. This, and
the fact that you end-up with more complex mac_link_up/down sequences that set the
"ext" settings then the "sds" settings while in SGMII makes me wonder if this whole
SGMII/2500BaseX series should be represented as a PCS phylink driver.

It would make more sense, and should also make the code easier to maintain in the
long run. Have you considered converting this to the phylink_pcs ops, or is there
something that doesn't quite fit the model here ? There are quite a few DSA switches
that makes use of this (grep for phylink_pcs), you should have plenty of examples
to pick from :)

Maxime


