Return-Path: <netdev+bounces-243453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D680CA19DA
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 22:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7A8CD3001BFC
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 21:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8306F2C029A;
	Wed,  3 Dec 2025 21:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gFTF6Sgp"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F768482EB;
	Wed,  3 Dec 2025 21:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796031; cv=none; b=WHYM8lTQ5bAe5aEjTrThoh8QyiFyhvuUTX8G6X6m4A7+qPR0oVacBX06mG3yAjiiSG7/nxu8+sWZwUsIFy/5kmzKnL9auubEe7n+9D/LZTaMqGkutpnWjcWVfeT02mDozVE0tsAoPkychAMvBnglY+65hL3IeXwywM4zPgBwbzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796031; c=relaxed/simple;
	bh=FHr/8rEkE0/9LGy3++0mrMsHjoBIwdrl7vb54gvell0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B4O7LfqROE5vA7UwE6T3lfS0F4Skqe9s0SyAfeMH/17svtM7kiFsLVcOlpSFSufwvp/Ii0/5S3ORRJWn9PkdifNm9m6q05O1RQqlUASvJU1N6azMDmnGSOB6mHwIxbbhari9orkbfdFLQ29AoY2Oy4DpsSLy64L8/KhdSzqCl0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=gFTF6Sgp; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dM9F55Fk4z9tjp;
	Wed,  3 Dec 2025 22:07:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1764796025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJO4QFCGFgBLcxSYA3azxaNJyI+4wMLsFkxHrpPR0Fs=;
	b=gFTF6SgpByU/LyApdiThEtzPkr0azSt39iR1JNK7MIsYLuf3YHAUrPbbUMT4FSJ2i+JvpU
	jX/fGXDejP2tXo1CwUFZ2Okv464gGLgOkhDAeb5Hxjsadz0f3oARPRbHMalRZrf9oaTMf8
	GwmABGZRIHzx446zCIuUPu2CHym4TXaQ3DGyEWQeTDG7ThGkCxAbLkOXVijAL6vMeczDl4
	xSe1TTVGDjCohmG9Ik6EpAVGSFCZL5OW0w8kFSAQcUzRbxakSm8fCAgQziGS3/q0eacFXF
	MXvSGJhWX4o7AFm4pfU5dOLx7SQFR5RGfRtyN8R+UCctUa7TY8BxLD66Rfo5aQ==
Message-ID: <f0ecb69c-9163-49fd-b74c-0893d9b95593@mailbox.org>
Date: Wed, 3 Dec 2025 21:16:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next,PATCH 2/3] dt-bindings: net: realtek,rtl82xx: Document
 realtek,ssc-enable property
To: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Aleksander Jan Bajkowski <olek2@wp.pl>, Andrew Lunn <andrew@lunn.ch>,
 Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Klein <michael@fossekall.de>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, devicetree@vger.kernel.org
References: <20251130005843.234656-1-marek.vasut@mailbox.org>
 <20251130005843.234656-2-marek.vasut@mailbox.org>
 <f3046826-a44c-4aa9-8a94-351e7fe83f06@kernel.org>
 <a861aa24-e350-4955-be5a-f6d2f4bc058f@mailbox.org>
 <043053ec-0f57-45e9-9767-be9b518dea4d@kernel.org>
 <4aaa73b4-3a2a-44f6-ad81-74c30be13431@mailbox.org>
 <67b5f5b5-caf9-4dcc-b84d-a7ce338fc25d@kernel.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <67b5f5b5-caf9-4dcc-b84d-a7ce338fc25d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: cb227c3bb80474b9cae
X-MBO-RS-META: 36kjr4f8q3yoth5wffbqci1todbhw1z4

On 12/3/25 8:56 AM, Krzysztof Kozlowski wrote:

>>> I don't know, please look at existing work around SSC from Peng. If
>>> nothing is applicable, this should be explained somewhere.
>>
>> The work from Peng you refer to (I guess) is this "assigned-clock-sscs"
>> property ? This is not applicable, because this is a boolean property of
>> the PHY here, the clock does not expose those clock via the clock API.
> 
> OK, please mention this in the commit msg - that assigned-clock-sscs is
> not applicable, because these are clocks not exposed outside.

OK

> I saw already brcm,enable-ssc property, so use rather "realtek,enable-ssc".

The realtek PHY bindings use realtek,<feature>-{enable,disable} already, 
so I would like to be at least consistent here ?

>> However, I can call the property "ssc-enable" without the realtek,
>> vendor prefix ?
> 
> I think no, I am not so sure how generic it would be to cover all
> existing cases. Some devices, e.g. cdns, defines the mode of SSC, so
> uses an enum.
> 
>>
>> The remaining question is, should I have one property "ssc-enable" to
>> control all SSC in the PHY or one for each bit "realtek,ssc-enable-rxc"
>> / "realtek,ssc-enable-clkout" ?
> 
> I don't know. Can they be enabled independently? Does it make sense for
> the hardware to have different choices?
The hardware can turn SSC on separate on either signal, and the netdev 
discussion seem to be veering in that direction, so I will split them 
and create two properties.

