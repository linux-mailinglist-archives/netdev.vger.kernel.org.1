Return-Path: <netdev+bounces-274068-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MI0wIfoBzWmSZQYAu9opvQ
	(envelope-from <netdev+bounces-274068-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 13:31:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88213379793
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 13:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 424C2300AD87
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 11:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504273CFF7D;
	Wed,  1 Apr 2026 11:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="mHv/VLVh"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786453D34A4;
	Wed,  1 Apr 2026 11:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042030; cv=none; b=TFGiiY+f+zJA3zxqjNdjRVSX3Mko+vZnDvAhqXW7PZ9n3LBabe1CjUplYcPcwcAv/o8MSaziWSepZa4ZlHaQroF9Qoo2dVL0VaXWhL6cwfiBPD7zZPEBfW6sernan8QC29FmXUaAGsklFGWTC5IfqgqAhwG/9SK5nKlbIc+pDLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042030; c=relaxed/simple;
	bh=GsDfng+YUixHLJx4M56ebk2b5l4g8eMD2QCLAz5ciEU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=SEDDmIE0MI60K5K5oFWT9UU3Yw/Yp5I2gspfywVqhDwP8xASOdVr1rOFBE74Yeb2m7sy/PVSmIf/3ZmpR0HETaB9yZ/9yW6Y7SaGCrSLXuoY5EbGSgxDcc2rra9tyKM40VYVX7lvCQ3ICi8eDoPflWL7l0lMbj3W9+G+Gw9jt1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=mHv/VLVh; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 36137A585F;
	Wed,  1 Apr 2026 13:13:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775042009; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Q9yvKMMQnqcDALJLjGbsxYPaoRAnEzHYwPyWde/eKJo=;
	b=mHv/VLVhZpV198DJI0DoNipdp9DcWWViqPp7+Os/OMGOZrKbpX8ODsNCi5SFGd0Ifp3vvn
	VpRjw9nAMtSlAdJBURagXEy9o8/YdOsxQ8N22/iM/i2HGC3ArxPTO3I/y/sY9WRlY8Jxpa
	JlG7DDFXAntYtLEojsAqJn3mtmbO3HzXD4E1q35PdCFAfSB2wN5m9zfmKkzPP5D3BpOXS8
	2VelQf3sto29TcXtUwVngMh2j4j5rnwKIU3LOlbkHhxTLHBkv3Gg1SDJU7txuFh53mmadd
	mt2III+7KcDR3Y4FZO6vYWABio58boCp0HU5kKQgl7y2K09b2Jwr8oOiLwuTgA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 01 Apr 2026 13:13:21 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: "David S . Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Russell King <linux@armlinux.org.uk>, Daniel
 Golle <daniel@makrotopia.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] net: phy: realtek: Add support for PHY LEDs on
 RTL8221B
In-Reply-To: <20260401100010.3079700-1-amadeus@jmu.edu.cn>
References: <20260401100010.3079700-1-amadeus@jmu.edu.cn>
Message-ID: <28961808c3aa133f74257494f5e327c6@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274068-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,redhat.com,kernel.org,google.com,armlinux.org.uk,makrotopia.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,jmu.edu.cn:email,tipi-net.de:dkim,tipi-net.de:mid]
X-Rspamd-Queue-Id: 88213379793
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1.4.2026 12:00, Chukun Pan wrote:
> Realtek RTL8221B Ethernet PHY supports three LED pins which are used to
> indicate link status and activity. Add netdev trigger support for them.
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  drivers/net/phy/realtek/realtek_main.c | 146 +++++++++++++++++++++++++
>  1 file changed, 146 insertions(+)
> 
> diff --git a/drivers/net/phy/realtek/realtek_main.c 
> b/drivers/net/phy/realtek/realtek_main.c
> index 023e47ad605b..8a22e18e5c56 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -150,6 +150,15 @@
> 

[...]

> 
> +static int rtl822xb_led_brightness_set(struct phy_device *phydev, u8 
> index,
> +				       enum led_brightness value)
> +{
> +	int ret;
> +
> +	if (index >= RTL8211x_LED_COUNT)
> +		return -EINVAL;
> +
> +	/* clear HW LED setup */
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
> +			    RTL822X_VND2_LED(index), 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* clear HW LED blink */
> +	return phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2,
> +				  RTL822X_VND2_LCR6,
> +				  RTL822X_VND2_LED_ACT(index));
> +}

This clears HW triggers but never actually turns the LED on when
value != LED_OFF. Both paths do the same thing: clear link and
activity config (value isn't used at all).

For LED_OFF that works (no triggers = LED off), but for LED_ON the
LED stays off too since there's no force-on written anywhere.

Compare with bcm_phy_led_brightness_set() which explicitly switches
between BCM_LED_SRC_ON and BCM_LED_SRC_OFF based on value.

If the RTL8221B has a software force-on register, it needs to be
programmed here. If it doesn't, brightness_set should not be
implemented at all. The framework handles its absence.

[...]

Thanks

Nicolai

