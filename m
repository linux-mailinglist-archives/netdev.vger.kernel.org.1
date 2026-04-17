Return-Path: <netdev+bounces-279340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJs5CDpF4mlh4AAAu9opvQ
	(envelope-from <netdev+bounces-279340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 16:35:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BFA41C1B5
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 16:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D46CB301A3E9
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 14:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9600A3B5307;
	Fri, 17 Apr 2026 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="AG6s762A"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C1A39F166;
	Fri, 17 Apr 2026 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776436528; cv=none; b=n+3+jEhV78xvKLFMCQF7pd9XF0B6eHcq01vwvQUbyHaPOwBfdaKDaOY8Y8SjaBdxtpPN+VVWKGLjI72jEry6Gks1i7e0pzwLJ+6nAG46VS69S7RoOStjFrq5VZIKMVs/w9wQWp/QON9Bn1sIUJla81Kbxmz1TAf3NSwhmz9lasM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776436528; c=relaxed/simple;
	bh=jczm1PnfFPygvbwaGzI2Gk+7jIMW700+2aiidjax8Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DjDXRm+gjDy2iOBa9USLgHMb1TnjOR3HNz8czE9RMSxBngUTL5uqjGopiYUJxWClVSiiZtoAi2qs/nKfIERfLkDmBUnlzj8TR6WVFmuihGsRETmCPtzKAUGojg/UsUuCzTuabMDuvE8zfotjWr7XbvY1F8OgN6QUWYSPkJrkNqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=AG6s762A; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 25CC2112A17;
	Fri, 17 Apr 2026 16:35:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776436514;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=hm/ULijNEj/gH6i3cnyc+IouTD/J0aajXF9ntUCA9Cg=;
	b=AG6s762A2gtajTBXhqkgBMGPHE9rRoYqRDDJMUzwrKwHsz0wHwG2iSlJLG7RPHqARhuVxt
	UB5S3SxoGPFHxAlFB+gSvSzyaqF6RYT4IxPjtUvUbEf2YYRAf51AWWlnHPNi08D8XwCrYP
	ZS9wbrNWRE0RivCyF4f6NoUJ9cb907TFh3KUOI3M1Ri4bis6bY2unFlR0IUuWt9kDkllyQ
	6pN4k58TGMcXXZPoVz572mPO1G/7A0F3wKzKkV/DdUReWBf2Ojx8fc4SPmgOCJnnKA0zxP
	TGxBCmrrfQV8QDtLbp577PGuIEcj3+HT4oV20qoQ4M2hHDqr4tB6PeG1qEpmiA==
Message-ID: <10e325c0-aeb0-47b1-b758-e4f47ff7b004@nabladev.com>
Date: Fri, 17 Apr 2026 16:35:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
To: Fidelio Lawson <lawson.fidelio@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Marek Vasut <marex@denx.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260417-ksz87xx_errata_low_loss_connections-v4-0-6c7044ec4363@exotec.com>
 <20260417-ksz87xx_errata_low_loss_connections-v4-1-6c7044ec4363@exotec.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260417-ksz87xx_errata_low_loss_connections-v4-1-6c7044ec4363@exotec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279340-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nabladev.com:dkim,nabladev.com:mid]
X-Rspamd-Queue-Id: 41BFA41C1B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/17/26 2:44 PM, Fidelio Lawson wrote:

[...]

> @@ -1271,6 +1287,29 @@ int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
>   		if (ret)
>   			return ret;
>   		break;
> +	case PHY_REG_KSZ87XX_SHORT_CABLE:
> +		if (!ksz_is_ksz87xx(dev))
> +			return -EOPNOTSUPP;
> +		ret = ksz87xx_apply_low_loss_preset(dev, !!val);
> +		if (ret)
> +			return ret;
> +		break;
> +	case PHY_REG_KSZ87XX_LPF_BW:
> +		if (!ksz_is_ksz87xx(dev))
> +			return -EOPNOTSUPP;
> +		ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_PHY_LPF, (u8)val);
> +		if (ret)
> +			return ret;
> +		dev->lpf_bw = val;
> +		break;
> +	case PHY_REG_KSZ87XX_EQ_INIT:
> +		if (!ksz_is_ksz87xx(dev))
> +			return -EOPNOTSUPP;
> +		ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_DSP_EQ, (u8)val);
Do these values need some check, so they would be in the correct 
range(s) / in the correct bitfields before being written into those 
registers ?

