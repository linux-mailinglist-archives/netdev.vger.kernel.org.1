Return-Path: <netdev+bounces-287057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ViwlJ+L8AmquzQEAu9opvQ
	(envelope-from <netdev+bounces-287057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:11:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3590D51E504
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F69E3037D65
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FEC4C6F15;
	Tue, 12 May 2026 10:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nOBWifub"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BBF3A9636;
	Tue, 12 May 2026 10:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778580430; cv=none; b=odb2gUTC66eHXaYmawJ4VGdEePLpanpg+3IcK4puBXDTO5B8BijNt1qoq8mPVlIGseIaKRFm4r+mmeQCFLQMHRyQk+HLkM28P1HAKmhaakQe/vjhM8h2fBFfwU3ThoJI0vNvkGM007Q+4Xcut7i1C5/92xYGIm4vczM4Nmu5MfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778580430; c=relaxed/simple;
	bh=gHVsMjQD7aYoLyArV6/rnfHEj2pFAXxQkhyn4lAkbNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lk9od4kqrHUiHqz71h+9aqSEijatcl9lhDS3MsjLRNo/vWumhrUMkE4qXE/BgxNh18NQar7uPnBN6NB1ikTSJzJ5KHf9kzitSQskMLdv/M4KVvAD20THdTHL1os2q0zBVhidHu0/3Whcn9bgcbUufTQ6i4Vn1rT+feDi0rjiA5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nOBWifub; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C23EF4E42C07;
	Tue, 12 May 2026 10:07:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 921DA60646;
	Tue, 12 May 2026 10:07:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8A0C311AF9D8C;
	Tue, 12 May 2026 12:06:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778580422; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Yp1fdytKhgczNXp8hx7NGLHKbUoAsfvVyxx20NBUGrc=;
	b=nOBWifubxiotEk+Plput5uZwfcLCh9WQTFgEdjp0PpXf/bZA3v77pWiI5MeJX6UzOq6eRa
	f/gjC73zGnC2ir5gm/x56NavRnHJgZbxZmLEXDuGlte2N5nEJEsJapmVpOZNF0S3nkrw8M
	NXnFKHG6dMNvH2VpTnoYJcH+39bRt944qmfr4F6MowpgSamWoVuz9VoNYb5sd2M6JlplXG
	n7sIJU4KnKEJ3YSF8l9HiyQJamfdUM6dIELywu+jsDgoM7z4i7QTE/ag5fEZoyiA6DGP+E
	jisNwk6jMym4ht2U3nrxbN21DS1Ky4xT21vF8nbgwHicDztDDgA7JtwPVZ69Cg==
Message-ID: <e77b4028-c201-4dd4-9214-721bdf67e976@bootlin.com>
Date: Tue, 12 May 2026 12:06:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/6] net: phy: Introduce Airoha AN8801/R
 Gigabit Ethernet PHY driver
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: kevin-kw.huang@airoha.com, macpaul.lin@mediatek.com,
 matthias.bgg@gmail.com, kernel@collabora.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260512-add-airoha-an8801-support-v3-0-1edb34e363ae@collabora.com>
 <20260512-add-airoha-an8801-support-v3-5-1edb34e363ae@collabora.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260512-add-airoha-an8801-support-v3-5-1edb34e363ae@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 3590D51E504
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287057-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[collabora.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[airoha.com,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:email]
X-Rspamd-Action: no action

Hi :)

This looks good, I just have very minimal comments

On 5/12/26 06:33, Louis-Alexis Eyraud wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Introduce a driver for the Airoha AN8801R Series Gigabit Ethernet
> PHY; this currently supports setting up PHY LEDs, 10/100M, 1000M
> speeds, and Wake on LAN and PHY interrupts.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

[...]

> +static u32 an8801r_led_blink_ms_to_hw(unsigned long req_ms)
> +{
> +	u32 req_ns, regval;
> +
> +	if (req_ms > AN8801_MAX_PERIOD_MS)
> +		req_ms = AN8801_MAX_PERIOD_MS;
> +
> +	req_ns = req_ms * 1000000;

Use NSEC_PER_MSEC :)

> +
> +	/* Round to the nearest period unit... */
> +	regval = req_ns + (AN8801_PERIOD_UNIT / 2);
> +
> +	/* ...and now divide by the full period */
> +	regval >>= AN8801_PERIOD_SHIFT;
> +
> +	return regval;
> +}
> +

[...]

> +static int an8801r_led_hw_control_set(struct phy_device *phydev, u8 index,
> +				      unsigned long rules)
> +{
> +	u16 on = 0, blink = 0;
> +	int ret;
> +
> +	if (index >= AN8801R_NUM_LEDS)
> +		return -EINVAL;
> +
> +	ret = an8801r_led_trig_to_hw(rules, &on, &blink);
> +	if (ret)
> +		return ret;
> +
> +	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, LED_ON_CTRL(index),
> +			     LED_ON_EVT_MASK, on);
> +	if (ret)
> +		return ret;
> +
> +	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, LED_BLINK_CTRL(index),
> +			     LED_BLINK_EVT_MASK, blink);
> +
> +	if (ret)
> +		return ret;

Extra newline before the if()

> +
> +	return phy_modify_mmd(phydev, MDIO_MMD_VEND2, LED_ON_CTRL(index),
> +			      LED_ON_EN, on | blink ? LED_ON_EN : 0);
> +}
> +

[...]

> +static int an8801r_rgmii_rxdelay(struct phy_device *phydev, bool enable,
> +				 u16 delay_steps)
> +{
> +	u32 reg_val;
> +
> +	if (delay_steps > RGMII_DELAY_STEP_MASK)
> +		return -EINVAL;
> +
> +	if (enable) {
> +		reg_val = delay_steps & RGMII_DELAY_STEP_MASK;
> +
> +		 /* Set align bit to add extra offset for RX delay */
> +		reg_val |= RGMII_RXDELAY_ALIGN;
> +
> +		 /* Set force mode bit to enable RX delay insertion */
> +		reg_val |= RGMII_RXDELAY_FORCE_MODE;
> +	} else {
> +		reg_val = 0;
> +	}
> +
> +	return an8801_buckpbus_reg_write(phydev, AN8801_BPBUS_REG_RXDLY_STEP,
> +					 reg_val);
> +}
> +
> +static int an8801r_rgmii_txdelay(struct phy_device *phydev, bool enable,
> +				 u16 delay_steps)
> +{
> +	u32 reg_val;
> +
> +	if (delay_steps > RGMII_DELAY_STEP_MASK)
> +		return -EINVAL;
> +
> +	if (enable) {
> +		reg_val = delay_steps & RGMII_DELAY_STEP_MASK;

Is this bitwise and needed, as you have the check above ?

> +
> +		 /* Set force mode bit to enable TX delay insertion */
> +		reg_val |= RGMII_TXDELAY_FORCE_MODE;
> +	} else {
> +		reg_val = 0;
> +	}
> +
> +	return an8801_buckpbus_reg_write(phydev, AN8801_BPBUS_REG_TXDLY_STEP,
> +					 reg_val);
> +}
> +
> +static int an8801r_rgmii_delay_config(struct phy_device *phydev)
> +{
> +	bool enable_delay;
> +	u16 delay_step;
> +	int ret;
> +
> +	if (phydev->interface == PHY_INTERFACE_MODE_RGMII_ID ||
> +	    phydev->interface == PHY_INTERFACE_MODE_RGMII_TXID) {
> +		enable_delay = true;
> +		delay_step = AN8801_RGMII_TXDELAY_DEFAULT;
> +	} else {
> +		enable_delay = false;
> +		delay_step = RGMII_DELAY_NO_STEP;
> +	}
> +
> +	ret = an8801r_rgmii_txdelay(phydev, enable_delay, delay_step);
> +	if (ret)
> +		return ret;
> +
> +	if (phydev->interface == PHY_INTERFACE_MODE_RGMII_ID ||
> +	    phydev->interface == PHY_INTERFACE_MODE_RGMII_RXID) {
> +		enable_delay = true;
> +		delay_step = AN8801_RGMII_RXDELAY_DEFAULT;

Is it correct that AN8801_RGMII_RXDELAY_DEFAULT expands to 
RGMII_DELAY_NO_STEP ? feels strange, but it may simply be how the HW is 
made :)

Thanks,

Maxime

