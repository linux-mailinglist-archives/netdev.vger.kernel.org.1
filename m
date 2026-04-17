Return-Path: <netdev+bounces-279350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJNLAOtQ4mnx4QAAu9opvQ
	(envelope-from <netdev+bounces-279350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 17:25:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 822E241C96B
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 17:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71CBE3066593
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 15:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B44C30C62E;
	Fri, 17 Apr 2026 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="kPSmIm4c"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3DF2FF672;
	Fri, 17 Apr 2026 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776439361; cv=none; b=h39T/z34Y/cAwI8cZHUIR7W64K4SlXJBqvRaanU4ePy//EXK+8ERpbos4YYibez1DFLAOKJ+OwgCpM9+HEFTlIL1D0b6cMp7yOynG920lOuJ0Ujpa3Wn5Gebbe+LSIq9c6gUNP3g0SXuS+Bi2OC2L6aUhy82B7YlcMgS4boPrUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776439361; c=relaxed/simple;
	bh=pZs7SUOFjjFRnfjhSM9pSMPtvxhLFhmPRpp+bN8Zf1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ODzANPh2PmnCl9qCo/2FiErWshkcTbXEvc+XsdtDiXhUs+EARwfXfMnryvQk5Ggd56yxqZSGYyy9TDhK5Hq3wkoHRUR2YNId/y7osliJjoTM6h5hU5VUCfjFzjbsNpQtrBw08ZdW0Id6KBGTw+nG/7AqAsynyLESQ+1Ci14C8FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=kPSmIm4c; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 88471113801;
	Fri, 17 Apr 2026 17:22:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776439354;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=8yeEcnpV64ufmg8vfjC2sub2FYhWx0mZrP/mnLrmaIk=;
	b=kPSmIm4cBgkgH6C4VnY4W/OERM9LD8uDAkiliVbxOxTReS0cuhTnjfiqoayDzkFDJ6dUnT
	CFoMd4sTw3h6PT3MJO0BW47NYQtFbksNcSwZz6QES/Zx4qOWL06/o/500bEG8bL1uYHqtu
	yQnXZvJarvSKSL7pvTU6SrtfJH/tzA1ZOaL4eG64XCan86XK8IaHXSD+oeE+e1JeNYVFZ1
	no0VpL0y0KqD36SdlXky2+X18GS2XQYh6pAjQQOfVbFrfDy8U074IKntF0GgUcidv6cGra
	P+zjQJm2fWq56T/+xRILdWUwQtAFkDI9uXmMUo54RqknNEqvCiLvgEJG3ESrFA==
Message-ID: <1be493e9-e5d5-4f75-8c1c-60e3a025d82b@nabladev.com>
Date: Fri, 17 Apr 2026 17:22:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
To: Fidelio LAWSON <lawson.fidelio@gmail.com>,
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
 <10e325c0-aeb0-47b1-b758-e4f47ff7b004@nabladev.com>
 <56034c9c-fede-4ede-b68d-5ecc484a64cd@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <56034c9c-fede-4ede-b68d-5ecc484a64cd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279350-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nabladev.com:dkim,nabladev.com:mid]
X-Rspamd-Queue-Id: 822E241C96B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/17/26 5:20 PM, Fidelio LAWSON wrote:
> On 4/17/26 16:35, Marek Vasut wrote:
>> On 4/17/26 2:44 PM, Fidelio Lawson wrote:
>>
>> [...]
>>
>>> @@ -1271,6 +1287,29 @@ int ksz8_w_phy(struct ksz_device *dev, u16 
>>> phy, u16 reg, u16 val)
>>>           if (ret)
>>>               return ret;
>>>           break;
>>> +    case PHY_REG_KSZ87XX_SHORT_CABLE:
>>> +        if (!ksz_is_ksz87xx(dev))
>>> +            return -EOPNOTSUPP;
>>> +        ret = ksz87xx_apply_low_loss_preset(dev, !!val);
>>> +        if (ret)
>>> +            return ret;
>>> +        break;
>>> +    case PHY_REG_KSZ87XX_LPF_BW:
>>> +        if (!ksz_is_ksz87xx(dev))
>>> +            return -EOPNOTSUPP;
>>> +        ret = ksz8_ind_write8(dev, TABLE_LINK_MD, 
>>> KSZ87XX_REG_PHY_LPF, (u8)val);
>>> +        if (ret)
>>> +            return ret;
>>> +        dev->lpf_bw = val;
>>> +        break;
>>> +    case PHY_REG_KSZ87XX_EQ_INIT:
>>> +        if (!ksz_is_ksz87xx(dev))
>>> +            return -EOPNOTSUPP;
>>> +        ret = ksz8_ind_write8(dev, TABLE_LINK_MD, 
>>> KSZ87XX_REG_DSP_EQ, (u8)val);
>> Do these values need some check, so they would be in the correct 
>> range(s) / in the correct bitfields before being written into those 
>> registers ?
> 
> Yes, I can add validation to ensure that only the documented bitfields 
> are accepted before writing the registers, (bits [7:6] for the LPF 
> bandwidth and bits [5:0] for the DSP EQ initial value).
Yes please, thank you !

