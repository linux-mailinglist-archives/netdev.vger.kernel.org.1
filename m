Return-Path: <netdev+bounces-305971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t4FJGY+oTmo+RgIAu9opvQ
	(envelope-from <netdev+bounces-305971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 21:44:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5955729EB7
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 21:44:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Z9wamYBJ;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305971-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305971-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 168A1300579E
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 19:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAA93DCDB5;
	Wed,  8 Jul 2026 19:44:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152F43D25A3
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 19:44:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783539847; cv=none; b=SewPJwv4zceU9hqOMFELvZQ62SHWpPd2AqI5INcoZmDb9ji3ZL2lJhS2o4Z4EQxd73xI80zGAJ94cXh3P4cgZX13HuKfO1fh2G5YBAOEeONKK9NGtth/X6Alfh6fG+L4bj2ltD0bY5VthPMXSFvDYrE+y+mHNdurh4cdX2Jto+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783539847; c=relaxed/simple;
	bh=sCBV4R2IskE+Qnt8X1ddpdk4fJf5MMWKVa9tRTgLXvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fb5z9OK7X/MFaNVyrNcAljZ+hRrg/4JKiih/AoZvOoLEzJZdVNkKRHN9kRVB260sO7RWGhCH4iICbgbXnafccTpRBGZddZb44lizHdC8zGoH5aezRm/kFGMPeAtM4gu/NhHpJGB4IgTXFJXPTwsE19ODA/luTGgXF/su1UzAUWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9wamYBJ; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493d92b7db3so11439875e9.2
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 12:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783539844; x=1784144644; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sCBV4R2IskE+Qnt8X1ddpdk4fJf5MMWKVa9tRTgLXvA=;
        b=Z9wamYBJkxQNjZkhmBdNJWvecPMkya3cozZAsa/1bbhEEbfEV+4QvdJj0A+4VqfDOE
         icvHtxykM+DmHp8EZjo5waUgBHoFU0L6fgUrq4tv3YEIx4rSIXe2PT3xRRhbTs7OjG0Z
         03Va/KtNSAOPYTP6gi8YI4g30nerFCmnv8loOh8sIgXNYTmO30Tjw5sJBbJmfuHZEYuq
         9qI2tNFmUyBKph+PsKxOplrqbyqhtI/i7WtWQLAlz9qm14MPuDoVHVmZ3aLUc1BCVhZD
         IvO5KXy9zP7WjvGrw6ZdLevwvr6W+68LFaXW0LZZ/CP/jCUbERmJC/p4K24qfzFk55mq
         NqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783539844; x=1784144644;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sCBV4R2IskE+Qnt8X1ddpdk4fJf5MMWKVa9tRTgLXvA=;
        b=ZzLdAttkad/pvrolCqPkX/h++HS7NiW9hHuk+7iXb37nN0zG/wmdFES7Lgbfi8jYWU
         nXspkyVsPC0d5Poe2k6o9y+oi+fG7fk/uAzYHG3cXbcHxEphFyCXZl6TNbaPoHMp2DFv
         j9WPcqykC2M1GergMU0emSWz2JZVUCe9dKdzr/2HCwL6OZvroXuUaNqdSFnPg9QCZQC8
         MNM75QHwnQMxfoz+AzxIvUWVFbJx4zU42m1RLMev8aUQI9CnVakbLNLP2yOyXYTyaIDZ
         sE2fTPbN2phlITnMfj1iRFSLMapHa9auZnwFtmYa1GsxucRSes6AL4AoasZU2RjKefTG
         s/YA==
X-Forwarded-Encrypted: i=1; AHgh+RpCtznirVE9Q9tVGJwzrEXmgX6mGmUbFfzAN0gFniosudiddHTRjB1blJ0sp5KO121q9xwkoho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE2m5MWxWr2uDQgZXrqzbQmlXv1SZ15kSvQZiiMtn+2SnyLeOL
	K+KU+WzIauM2i9SsK3gFFaON1nKpjAcc2ktQ+h10d/bd2oqjyHu2my4S
X-Gm-Gg: AfdE7cmmbfb969LkjKCPUODeYr3WzYFD7Kuu1edZuwV0QmuokVLhIUhLjVcKEmAPCw4
	G9Dh884GG5Q+i+59sh4tspN7WPk4j6NTS1lviv8CoEZJglF31U8HC+T31G9G4/iou3dtHdMw4rO
	58zNFR+YA3hBjS2gt2o2sR+60ZXRsuBMTVj97UMKd5s2LOrJbCIUqsSZ/e63dKT3YBzVEnlIwJA
	h6SQMJ/fuCDb+KROcftQO8rChUaBsY1O2aTu46R3DW8cm0GrLckIIoVVKfj1VhXh6aNMCduwQdF
	Fvr+OO06qmVJj6Qap+UNHrkDnnkJyRCxzLkrnZwl6LLnYgDejcD3Xs5nRBc+q6RozJ1Ib+83mBO
	f3E0MFoLHdfiQlW4OOY5M70gLZHJn/srj5+pmNQyWq6JXlWmjg4OFO2nrtJVUctSmMmckxKX3n1
	B7Lz1e9+7mQoJzL2GNm2ywjgI6jaQiCMPbMrYr5iAbe2oRTDXXeN5U/G7VTPKkaLZJw6lUMjaNr
	EO2cVlNaXE0
X-Received: by 2002:a05:600c:1d0f:b0:493:cfd2:cd06 with SMTP id 5b1f17b1804b1-493e68b8007mr39812645e9.6.1783539844178;
        Wed, 08 Jul 2026 12:44:04 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f108:7101:a0d0:f2a:50b6:7266? ([2001:9e8:f108:7101:a0d0:f2a:50b6:7266])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e3e2702sm47175156f8f.9.2026.07.08.12.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 12:44:03 -0700 (PDT)
Message-ID: <df0aaf90-2baa-424c-8c83-aed52a4b4321@gmail.com>
Date: Wed, 8 Jul 2026 21:44:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/4] dt-bindings: net: pse-pd: add bindings
 for Realtek/Broadcom PSE MCU
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Golle <daniel@makrotopia.org>, =?UTF-8?Q?Bj=C3=B8rn_Mork?=
 <bjorn@mork.no>
References: <20260706112425.3149226-1-jelonek.jonas@gmail.com>
 <20260706112425.3149226-2-jelonek.jonas@gmail.com>
 <20260706-player-handwash-0a3fe95cf5ec@spud>
 <c19e563a-8931-4f31-b05a-ff8def4a5161@gmail.com>
 <20260707-dove-fretful-e3c8e237f1eb@spud>
 <2afc9c9a-eacc-46ca-b965-4cabee8f7094@gmail.com>
 <20260708-lyrically-footrest-10963a12145f@spud>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20260708-lyrically-footrest-10963a12145f@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-305971-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:conor@kernel.org,m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:bjorn@mork.no,m:andrew@lunn.ch,m:krzk@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B5955729EB7

Hi Conor,

On 08.07.26 18:56, Conor Dooley wrote:
> On Tue, Jul 07, 2026 at 10:50:21PM +0200, Jonas Jelonek wrote:
>> [...]
>> Ok, I hope I put this together correctly. A concrete proposal:
>>
>> "realtek,pse-mcu-gen1"                        (Protocol Gen 1, UART)
>> "realtek,pse-mcu-gen1-smbus"            (Protocol Gen 1, SMBus)
>> "realtek,pse-mcu-gen2"                        (Protocol Gen 2, UART)
>> "realtek,pse-mcu-gen2-i2c"                  (Protocol Gen 2, raw I2C)
>> "realtek,pse-mcu-gen2-smbus"            (Protocol Gen 2, SMBus)
>>
>> This uniquely identifies the protocol used: first generation and second
>> generation. As Rob mentioned before [1], this also pulls in the raw I2C
>> vs. SMBus framing in contrast to having it in a property. The framing
>> suffix appears only on I2C attachments because it doesn't apply to
>> UART transport, and this is given by the parent serial@ node.
>>
>> Though I'm still open for suggestions regarding the protocol
>> identification if "-gen1"/"-gen2" is not acceptable.
> This seems reasonable enough.
>
>> [...]
>>
>> It would also be an exception to the other PSE-PD bindings. They describe
>> controllers used across many switches too, yet none encode the
> The difference is those cases (for what few pse-psd bindings there are)
> the compatibles correspond to individual devices. Here you have
> compatibles you're going to use to cover multiple devices (with device
> corresponding to a combination of mcu/firmware/hardware behind the mcu).
> That lack of a 1:1 mapping is why I'm asking for something different from
> you than you see with the existing pse-pd devices. The switch the device
> is integrated on seems to be the only thing that reasonably makes sense
> to use.
>
>
>> switch/enclosure. Board-specific compatibles might still be added later in
>> case a device really has a variation or quirk that genuinely needs its own
>> compatible.
> And in doing so, have to retrofit that compatible to all devicetrees
> that use it. This is one of the reasons that we generally demand
> device-specific compatibles.
>
> You could add switch-specific compatibles that fall back to the ones you
> provide above, with the driver only using the ones above unless
> something crops up in the future?

Thank you for the thorough explanation. I think I got your point now and
understand why it's required that way.

I'll rework this for the next version.

> Cheers,
> Conor.

Best regards,
Jonas

