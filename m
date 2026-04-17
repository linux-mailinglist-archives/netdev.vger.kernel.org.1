Return-Path: <netdev+bounces-279349-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMOgGG5Q4mnx4QAAu9opvQ
	(envelope-from <netdev+bounces-279349-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 17:23:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D439F41C8B3
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 17:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56936309B987
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 15:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630512FB084;
	Fri, 17 Apr 2026 15:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5hO/iyY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D2E2E7179
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776439267; cv=none; b=adJfuVqBJawWNBkhsVPgQ/7DJVxHuCTPauP5lbCzrWfJ4sBaJejmgZ9bHFtqh5bXCAgFhqrif685sbtR/ovfqmrYuyP5zNEfCh80PUtNzMs4XTIq5LnyF74UASTgzp8mfYI+0bnhuIhXG7DvR2f/hNqloa3l+79na0Es4+8wvXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776439267; c=relaxed/simple;
	bh=4fCv9WUuJ2WzPc7sBFFOqX1mzOC6kIlREVQBRVyz25I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h34KVf0DiSLc3ItaAgJTXRvLZfBPs5EW15L8FYjCLfG/4vbX6e1pgGvc3eOrqIy/rcNPLWuykQX31E/NM505L2xYORtFodvwNfHAgl1L4TsT5ssQrbkYABhVFVGacC5NZGDDTIPwYLGQqu5UW5GEYDnDZVTb7Z/+9bjO7jy5c84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5hO/iyY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488ad135063so8038365e9.0
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 08:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776439264; x=1777044064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/U/CbRT2z3A4yG6akec4gYSLr/zQxiO2KM+Ee2yWyIU=;
        b=P5hO/iyYwGY4CULlkff52T9BbVXIb0d2kgrwX2QNL0srNV8Flzv4+4q+qH8f9fWhJq
         r53s/ooyYwXijklSfR9tngSvs3rNWYEASXjzFoUm5m8GW1Y7ssSAaBKo8SZjcJ80C79K
         dInmdXJUc9Jz32PCcydFkV5T7haY3jq8wsXvAZ78i5PpbN0IyXyrhECOQbtAyYSlAGJ+
         QObwAegV1kcDH/mUtjTACJ3++tXA5ObsiU3ji98dzZjoD4WIspYLyBNFfe7Rzzyet4T+
         ru4/Sp1snfvsCU9l8m+gCLIVT/4jlTYZV/Nkrrbj863pDu+renZvmKC9Poa/IvhKxPac
         ZUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776439264; x=1777044064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/U/CbRT2z3A4yG6akec4gYSLr/zQxiO2KM+Ee2yWyIU=;
        b=qO+O8VDvi+AeZiKB/CWwU6560X5ykmspVuedNRQZPWHFIbi8C1rm2dHezyyOeIMHh0
         +bSwSoEOAV6ieeo4O6dCfb3I6XabNDM4OzYELSCRzEdPIVz+nDqOqVVWtI+MNQJ8xfVW
         ODkQt8SmOhHT8OyHidGymT/NeXEZcVsyTG/xeWSy5MHVNoDVxQyymoIYWBcNEy+FUWkl
         jkNfppmZPaIV3tkhSUDa2bESJPyd71whzOlo8OfFYUVGuW6FhQjH6P7cfx2PhalDGpqG
         EtunQkeOL+ILvDZDWQfcniZuOKw4AdtTZ4OgddUEI29K/VgI0taoXuvtFzawMC4Dxggs
         4new==
X-Gm-Message-State: AOJu0YxJwHAUsmGvRlOCALQelemyPk2hxWJWki44mNpUIccWqALMz9aL
	4+Xc1yWk67Q8ITAucs7+FKjkoCc9m2NECJI3CzaVycckPNPEMbYuIZJi
X-Gm-Gg: AeBDieuSxZcPM3NwiX2GklKg6MxZTia8oh5fGgCaKdIJAt87ET07XTEJTF9Nf+XfM/Y
	e2eyjS/N/tOWTrGXGdBYHWOpmdBwsSGG2JgA5qtDopp+EX2vAbdbgj2guOp2/engA1nTVa31sn2
	AaS/PPHgLJ+Iybvn6jUf6/Ouxr78Bdqv7Hki5ioOH2bpYwgvWveOhpXUarTNJnG72BCWf3tTO8L
	Ur99SrdbM0v0L3TdkHQ3Z4ZPeZeNLGqrz2I2u65VZw39p5+mhi1bVuUxXOzN0LhJrlEwtNryXrh
	UaPVRFZipNDBl0YsscuPaEg/xEIw+4p03Wlcf3Z6sLJ4dQBR7h9Vh0IPgStW2VHh3BHxvjP8vIX
	97SNI7cZES/xFUO7lKiMgJr5sax5Z1surIlwQ59XNJewIRkPl6jHm6qctd/pKRFuQ6jUm95CP3J
	LJceZb+nlTJpO8Fyu0uIDeFouqtuY24Ucx2LhRI0+nMsJCiPpia3Bp5wu4X2KA+B/xYT1ii2Hqj
	aWngLKC8XKHTGaIy551
X-Received: by 2002:a05:600c:4711:b0:485:6e40:5584 with SMTP id 5b1f17b1804b1-488fb745261mr49761335e9.6.1776439264093;
        Fri, 17 Apr 2026 08:21:04 -0700 (PDT)
Received: from [10.1.4.108] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a06f3sm23099115e9.22.2026.04.17.08.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 08:21:03 -0700 (PDT)
Message-ID: <56034c9c-fede-4ede-b68d-5ecc484a64cd@gmail.com>
Date: Fri, 17 Apr 2026 17:20:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
To: Marek Vasut <marex@nabladev.com>, Woojung Huh
 <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
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
Content-Language: en-US
From: Fidelio LAWSON <lawson.fidelio@gmail.com>
In-Reply-To: <10e325c0-aeb0-47b1-b758-e4f47ff7b004@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279349-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[nabladev.com,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D439F41C8B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/17/26 16:35, Marek Vasut wrote:
> On 4/17/26 2:44 PM, Fidelio Lawson wrote:
> 
> [...]
> 
>> @@ -1271,6 +1287,29 @@ int ksz8_w_phy(struct ksz_device *dev, u16 phy, 
>> u16 reg, u16 val)
>>           if (ret)
>>               return ret;
>>           break;
>> +    case PHY_REG_KSZ87XX_SHORT_CABLE:
>> +        if (!ksz_is_ksz87xx(dev))
>> +            return -EOPNOTSUPP;
>> +        ret = ksz87xx_apply_low_loss_preset(dev, !!val);
>> +        if (ret)
>> +            return ret;
>> +        break;
>> +    case PHY_REG_KSZ87XX_LPF_BW:
>> +        if (!ksz_is_ksz87xx(dev))
>> +            return -EOPNOTSUPP;
>> +        ret = ksz8_ind_write8(dev, TABLE_LINK_MD, 
>> KSZ87XX_REG_PHY_LPF, (u8)val);
>> +        if (ret)
>> +            return ret;
>> +        dev->lpf_bw = val;
>> +        break;
>> +    case PHY_REG_KSZ87XX_EQ_INIT:
>> +        if (!ksz_is_ksz87xx(dev))
>> +            return -EOPNOTSUPP;
>> +        ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_DSP_EQ, 
>> (u8)val);
> Do these values need some check, so they would be in the correct 
> range(s) / in the correct bitfields before being written into those 
> registers ?

Yes, I can add validation to ensure that only the documented bitfields 
are accepted before writing the registers, (bits [7:6] for the LPF 
bandwidth and bits [5:0] for the DSP EQ initial value).


