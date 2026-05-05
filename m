Return-Path: <netdev+bounces-284410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GM22CYTw+WmcFQMAu9opvQ
	(envelope-from <netdev+bounces-284410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:28:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8833E4CE7C7
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5447230A4DF9
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 13:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B2E392C32;
	Tue,  5 May 2026 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="XJJEck8P"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBBC30B50C;
	Tue,  5 May 2026 13:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987446; cv=none; b=WDD0IiG/YFufUY9yooxCM0ZpMfEveftpWy+olGnDnh2Vp8aOscBM2m0vs0FoIhd3YUoED4bvuI89tBnqHUQ4/xbbwdoqj/C+BIah1qxqCNXwXTYPvODOCl75U011Xf97iLlrivqbptoPboRfgb2Y6vzUZPpQAxSVhntAGCrNaGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987446; c=relaxed/simple;
	bh=cJGE+uHkMo2XrKSdJQRlK06JSeRZS1FPVrMTVzfg3ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6PPS/3JMolW6iC2oX/46EsQvJDlguBcF3ag56ToXMkP/oNGIeVDaEsmu6puw/8KDnneE6kkmuBa02MYNReOjJa4TvQBmkNo+fLZGfW/XbUFXA7SCiq5K2Pkjfn8fYpzwZNbxUfmmYeKNHsOvXRlF4XzpnIdbgIFBLTpgaUMVRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=XJJEck8P; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AC6991137E5;
	Tue,  5 May 2026 15:23:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1777987442;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=1vizPUW0FlszOfHJLst6PwlnlTyCSMe3aajO8GaMzRc=;
	b=XJJEck8PJkysg8ZavW/iEdtUH4t0zkIgMi86HcHzupwD4CWnoj4y3BVfgbUfjWnfmNb0PD
	0HYfCl4jbFy9lpi36BPYlZGc7L51wR7j8+8Vw9+9SsiR4Nh3PnXr+SIXO5wjXacoZIhjDl
	fFBPk3u23uguJUUI0r6al1UiEaL4YMCPWPHBn7gJFWfMTOnOMf+oOtGcsC8K6EJSZ5lrUX
	madFIdeq9QYbMVTfP03jzl+eaAEvb4OjOeTNRroIvUyQQRpR3mlaWpei0DC14WFUQ4pIt8
	CR2g7VU4r/Vguo+kneJ75/e28Urp1Q1pK7d/WHysur9Rau1cdUhWHmxJQ/P+XA==
Message-ID: <6c3b4490-c618-4650-8b3d-7bb71da196d3@nabladev.com>
Date: Tue, 5 May 2026 15:23:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
To: Fidelio Lawson <lawson.fidelio@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Marek Vasut <marex@denx.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Tristram Ha <Tristram.Ha@microchip.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260505-ksz87xx_errata_low_loss_connections-v5-0-da4002b21c42@exotec.com>
 <20260505-ksz87xx_errata_low_loss_connections-v5-1-da4002b21c42@exotec.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260505-ksz87xx_errata_low_loss_connections-v5-1-da4002b21c42@exotec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 8833E4CE7C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284410-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nabladev.com:dkim,nabladev.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 5/5/26 1:42 PM, Fidelio Lawson wrote:

[...]

> @@ -2096,11 +2141,39 @@ int ksz8463_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
>   	return 0;
>   }

Nitpick, either turn the "Apply the Microchip..." code comment into a 
kerneldoc for this function, or use netdev style multi-line comment.

> +int ksz87xx_apply_low_loss_preset(struct ksz_device *dev, bool enable)
> +{
> +	/* Apply the Microchip erratum short-cable preset (LPF 62 MHz, EQ init 0) */
> +	/* providing a conservative configuration for short or low-loss cables. */
> +	u8 lpf_bw, eq_init;
> +	int ret;
> +
> +	lpf_bw = KSZ87XX_PHY_LPF_62MHZ;
> +	eq_init = KSZ87XX_DSP_EQ_INIT_LOW_LOSS;
> +
> +	if (!ksz_is_ksz87xx(dev))
> +		return -EOPNOTSUPP;

Please add newline here.

> +	if (!enable)
> +		return 0;

Please add newline here.

> +	ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_PHY_LPF, lpf_bw);
> +	if (ret)
> +		return ret;

Please add newline here.

> +	dev->lpf_bw = lpf_bw;
> +	ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_DSP_EQ, eq_init);
> +	if (ret)
> +		return ret;

Please add newline here.

> +	dev->eq_init = eq_init;
> +
> +	return ret;
> +}
> +

[...]

> diff --git a/drivers/net/dsa/microchip/ksz8_reg.h b/drivers/net/dsa/microchip/ksz8_reg.h
> index 332408567b47..cd41214f874e 100644
> --- a/drivers/net/dsa/microchip/ksz8_reg.h
> +++ b/drivers/net/dsa/microchip/ksz8_reg.h

[...]

> @@ -729,6 +736,21 @@
>   #define PHY_POWER_SAVING_ENABLE		BIT(2)
>   #define PHY_REMOTE_LOOPBACK		BIT(1)
>   
> +/* Vendor-specific Clause 22 PHY registers (virtualized) */
> +#define PHY_REG_KSZ87XX_SHORT_CABLE		0x1A
> +#define PHY_REG_KSZ87XX_LPF_BW			0x1B
> +#define PHY_REG_KSZ87XX_EQ_INIT			0x1C
> +
> +/* LPF bandwidth bits [7:6]: 00 = 90MHz (default), 01 = 62MHz, 10 = 55MHz, 11 = 44MHz  */
> +#define KSZ87XX_PHY_LPF_90MHZ          0x00
> +#define KSZ87XX_PHY_LPF_62MHZ          0x40
> +#define KSZ87XX_PHY_LPF_55MHZ          0x80
> +#define KSZ87XX_PHY_LPF_44MHZ          0xC0

You could use GENMASK_U32() and FIELD_PREP() for these bitfields:

#define KSZ87XX_PHY_LPF_MASK     GENMASK(7, 6)
#define KSZ87XX_PHY_LPF_90MHZ    FIELD_PREP(KSZ87XX_PHY_LPF_MASK, 0)
#define KSZ87XX_PHY_LPF_62MHZ    FIELD_PREP(KSZ87XX_PHY_LPF_MASK, 1)
...

[...]

