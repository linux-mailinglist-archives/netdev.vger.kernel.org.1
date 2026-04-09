Return-Path: <netdev+bounces-276763-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDtGJj371mkPKggAu9opvQ
	(envelope-from <netdev+bounces-276763-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 03:05:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 029C83C525E
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 03:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FABA3017030
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 01:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6100820E023;
	Thu,  9 Apr 2026 01:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="SbHNp7RI"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5664A1B4223;
	Thu,  9 Apr 2026 01:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775696661; cv=none; b=HewpSD0xqvCXbo8kK8aZ3+OV6L0Ylzlad9bNeSOp62HBqHEZtccmsLRrxSls1hEIy9UIapjiNy+2/bzXy1Th3zGSDL3sk+ExDsz6TUxUFgAcQnqAoG9SXJEGhcphl9kezVF5VtSKc+Au5ExDefYaT67+oT7aUZU/zVjIIesVtKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775696661; c=relaxed/simple;
	bh=WdXJtKmRDZgCpCGXFDTG/8KIgSgzFfhSEUxvitpYUd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jCgVAB2d4Rt5pazVIeoBgS9zAYlBMLK4mYnFmCFAOlAoWXeu+CJSGXQHrpaPx9bf7vPqkKIsb4D+xRGrypG8pO9D8+kbHpkomIOH93D9pFxKHvZ1Y8j6cgSLytuLH4MuSjHNLp9sMpK15xptaknnrgHcEn4Gc0PB53pNJgMWkWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=SbHNp7RI; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5899210C42F;
	Thu,  9 Apr 2026 03:04:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1775696656;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=fEMK6O4rb7+W03or4vD8icEM8Kqyr5nfEv+3NYAxvX4=;
	b=SbHNp7RI21tkLYh/fnFqtyqwy4N482r6oQBAg3M4AO2JJAa2sN7ntTuMXBN4LZNnPhJcVq
	l1GC4/OlKJ90+fv8r+3xrOkiE5Y8QkgJmGKIUhJsm5GuV4yT59nbtlic1P9DClVBPsUf5M
	qusbgbpRTnQ1/VkLzMvA9UPy+3ivZntFjKa3ABKXBeb21A2fw8GV7cDfWP9YYsm6JhHVUH
	meYlFGjh1QsWeHVZvhAck0DC0d7Vf6LCjW7WmG+T1VLmjshkeFm4b4FRZPK2LtK3JqtOoY
	5TicFa7mqwT6wFU5R1OVKHsmL2w1/NDMwQer0julycdVV6ciZVTgXJB4qG/CeA==
Message-ID: <4803f8a4-abb4-4e89-95e4-b9a5b151ded6@nabladev.com>
Date: Thu, 9 Apr 2026 03:04:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
To: Fidelio Lawson <lawson.fidelio@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260408-ksz87xx_errata_low_loss_connections-v2-1-9cfe38691713@exotec.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260408-ksz87xx_errata_low_loss_connections-v2-1-9cfe38691713@exotec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276763-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com];
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
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nabladev.com:dkim,nabladev.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 029C83C525E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/8/26 1:57 PM, Fidelio Lawson wrote:
> Implement the "Module 3: Equalizer fix for short cables" erratum from
> Microchip document DS80000687C for KSZ87xx switches.
> 
> The issue affects short or low-loss cable links (e.g. CAT5e/CAT6),
> where the PHY receiver equalizer may amplify high-amplitude signals
> excessively, resulting in internal distortion and link establishment
> failures.
> 
> KSZ87xx devices require a workaround for the Module 3 low-loss cable
> condition, controlled through the switch TABLE_LINK_MD_V indirect
> registers.
> 
> The affected registers are part of the switch address space and are not
> directly accessible from the PHY driver. To keep the PHY-facing API
> clean and avoid leaking switch-specific details, model this errata
> control as vendor-specific Clause 22 PHY registers.
> 
> Two vendor-defined bits are introduced in PHY_REG_LOW_LOSS_CTRL,
> and ksz8_r_phy() / ksz8_w_phy() translate accesses to these bits
> into the appropriate indirect TABLE_LINK_MD_V accesses.
> 
> The control register defines the following modes:
>    bits [1:0]:
>      00 = workaround disabled
>      01 = workaround 1 (DSP EQ training adjustment, LinkMD reg 0x3c)
>      10 = workaround 2 (receiver LPF bandwidth, LinkMD reg 0x4c)
> 
> Workaround 1: Adjusts the DSP EQ training behavior via LinkMD register
> 0x3C. Widens and optimizes the DSP EQ compensation range,
> and is expected to solve most short/low-loss cable issues.
> 
> Workaround 2: for the cases where Workaround 1 is not sufficient.
> This one adjusts the receiver low-pass filter bandwidth, effectively
> reducing the high-frequency component of the received signal
> 
> The register is accessible through standard PHY read/write operations
> (e.g. phytool), without requiring any switch-specific userspace
> interface. This allows robust link establishment on short or
> low-loss cabling without requiring DTS properties and without
> constraining hardware design choices.
> 
> The erratum affects the shared PHY analog front-end and therefore
> applies globally to the switch.
> 
> Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
> ---
> Hello,
> 
> This patch implements the “Module 3: Equalizer fix for short cables” erratum
> described in Microchip document DS80000687C for KSZ87xx switches.
> 
> According to the erratum, the embedded PHY receiver in KSZ87xx switches is
> tuned by default for long, high-loss Ethernet cables. When operating with
> short or low-loss cables (for example CAT5e or CAT6), the PHY equalizer may
> over-amplify the incoming signal, leading to internal distortion and link
> establishment failures.
> 
> Microchip provides two workarounds, each requiring a write to a different
> indirect PHY register access mechanism.
> 
> The workaround requires programming internal PHY/DSP registers located in the
> LinkMD table, accessed through the KSZ8 indirect register mechanism. Since these
> registers belong to the switch address space and are not directly accessible
> from a standalone PHY driver, the erratum control is modeled as a vendor-specific
> Clause 22 PHY register, virtualized by the KSZ8 DSA driver.
> 
> Reads and writes to this register are intercepted by ksz8_r_phy() /
> ksz8_w_phy() and translated into the required TABLE_LINK_MD_V indirect accesses.
> The erratum affects the shared PHY analog front-end and therefore applies
> globally to the switch.
> 
> The register defines three modes:
>    - 0x0: workaround disabled
>    - 0x1: workaround 1 (DSP EQ training adjustment)
>    - 0x2: workaround 2 (receiver low-pass filter bandwidth reduction)
> 
> The register can be read and written from userspace via standard Clause 22 PHY
> accesses (for example using phytool) on DSA user ports.
> 
> This series is based on Linux v7.0-rc1.
> ---
> Changes in v2:
> - Dropped the device tree approache based on review feedback
> - Modeled the errata control as a vendor-specific Clause 22 PHY register
> - Added KSZ87xx-specific guards and replaced magic values with named macros
> - Rebased on Linux v7.0-rc1
> - Link to v1: https://patch.msgid.link/20260326-ksz87xx_errata_low_loss_connections-v1-0-79a698f43626@exotec.com
> ---
>   drivers/net/dsa/microchip/ksz8.c       | 33 +++++++++++++++++++++++++++++++++
>   drivers/net/dsa/microchip/ksz8_reg.h   | 20 +++++++++++++++++++-
>   drivers/net/dsa/microchip/ksz_common.h |  3 +++
>   3 files changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
> index c354abdafc1b..d11da6e9ff54 100644
> --- a/drivers/net/dsa/microchip/ksz8.c
> +++ b/drivers/net/dsa/microchip/ksz8.c
> @@ -1058,6 +1058,11 @@ int ksz8_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val)
>   		if (ret)
>   			return ret;
>   
> +		break;
> +	case PHY_REG_KSZ87XX_LOW_LOSS:
> +		if (!ksz_is_ksz87xx(dev))
> +			return -EOPNOTSUPP;
> +		data = dev->low_loss_wa_mode;
>   		break;
>   	default:
>   		processed = false;
> @@ -1271,6 +1276,34 @@ int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
>   		if (ret)
>   			return ret;
>   		break;
> +	case PHY_REG_KSZ87XX_LOW_LOSS:
> +		if (!ksz_is_ksz87xx(dev))
> +			return -EOPNOTSUPP;
> +
> +		switch (val & PHY_KSZ87XX_LOW_LOSS_MASK) {
> +		case PHY_LOW_LOSS_ERRATA_DISABLED:
> +			ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_EQ_TRAIN,
> +					      KSZ87XX_EQ_TRAIN_DEFAULT);
> +			if (!ret)
> +				ret = ksz8_ind_write8(dev, TABLE_LINK_MD,
> +						      KSZ87XX_REG_PHY_LPF,
> +						      KSZ87XX_PHY_LPF_DEFAULT);
> +			break;
> +		case KSZ87XX_LOW_LOSS_WA_EQ:
> +			ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_EQ_TRAIN,
> +					      KSZ87XX_EQ_TRAIN_LOW_LOSS);
> +			break;
> +		case KSZ87XX_LOW_LOSS_WA_LPF:
> +			ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_PHY_LPF,
> +					      KSZ87XX_PHY_LPF_62MHZ);

Please adjust this and make the low pass filter bandwidth actually 
configurable according to the values supported by the hardware, see this 
article:

https://microchip.my.site.com/s/article/Solution-for-Using-CAT-5E-or-CAT-6-Short-Cable-with-a-Link-Issue-for-the-KSZ8795-Family

The indirect register (0x4C) is an 8-bit register. The bits [7:6] are 
described in the table below.

Low pass filter bandwidth
00 = 90MHz
01 = 62MHz
10 = 55MHz
11 = 44MHz

...

