Return-Path: <netdev+bounces-106579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3C6916E2F
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 18:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F24D2B21801
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB574172BD4;
	Tue, 25 Jun 2024 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="l2EvxNj/"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEA514A0B8;
	Tue, 25 Jun 2024 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333274; cv=none; b=ZxQXrWFTM85bKb1RIQ3v7PKAGQlkY+PV2F1ofv1xJIyMWoqCgLYMwYuYkrr0nT2j/Q67CUwgl4Zoiuv62FtMJuAKWv+s8B13Xp6cO7irbgKjT2yFk2UNnal0eWcQ7JPpgKLVzqX52TcgTCOb8xF2uuZGW6ISgiqdkKHJsCg0dIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333274; c=relaxed/simple;
	bh=yRbrl8pBo6hmUcs39DQUAtO1CFgz2Vf67wvVIsA4nh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTnZjV4i2eN1hkfM4N+NAJKyD9ukr18KEHmH9VX/WzUlB8V0nrQEfm1ODP1+UPewuHjCBsGN5XqnM+ZiGMaNp1/4YGIJmu+0GZqyeUinE8GadJdTH0xX9cWf/0SbwgYk1Z6Asqf3/fF2Jp6yGbAcOUjXMVB7tZNlMjf86ujQzaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=l2EvxNj/; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 396D8FF803;
	Tue, 25 Jun 2024 16:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1719333270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQcRzQLnkaoL4wQYeJunaQ65bdPeTfuBgWQEOy5uOio=;
	b=l2EvxNj/BT8ncbykHU91+LRRiUzl33lqWsvlnnM4JkFyhh55Iftxu8T539KpXS/vCTv8np
	hLMSBio9L9ApDHU5iw9ud2Ly0lkOgG5yDaLKnwet7/1BHan6kIReJRIshUqymxxriU91fM
	RCoA6AVahsPAPVX1m8tlGpNzhugGODLwdblnhchPqbVV851VrHTpzRCWq+5AX5Fuwdrkew
	JYeeBIO7Fq+00JENHd5RrSlggUYOpK/keIpOrhfnsEYtahun4655uE5TXlggSlEcH7GdAB
	FmUQi8dNMnlWoBGzgo1A4ZBmSb8HTAeHyfBLAvKLR/Sv3YIxXw5DXaOhLguzlQ==
Message-ID: <12446d57-8a88-472d-845a-58ee603cedcc@arinc9.com>
Date: Tue, 25 Jun 2024 19:34:23 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: net: dsa: mediatek,mt7530: Minor grammar
 fixes
To: Conor Dooley <conor@kernel.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Daniel Golle <daniel@makrotopia.org>
References: <20240624025812.1729229-1-chris.packham@alliedtelesis.co.nz>
 <704f4b95-2aed-4b76-87cb-83002698471c@arinc9.com>
 <20240624-radiance-untracked-29369921c468@spud>
 <68961d4f-10d8-4769-94d3-92ce709aa00a@arinc9.com>
 <20240624-supernova-obedient-3a2ba2a42188@spud>
 <a17f35ae-5376-458a-b7b5-9dbefd843b40@arinc9.com>
 <20240625-surfboard-massive-65f7f1f61f0d@spud>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240625-surfboard-massive-65f7f1f61f0d@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 25/06/2024 19.16, Conor Dooley wrote:
> On Mon, Jun 24, 2024 at 08:11:10PM +0300, Arınç ÜNAL wrote:
>> On 24/06/2024 20.02, Conor Dooley wrote:
>>> On Mon, Jun 24, 2024 at 07:59:48PM +0300, Arınç ÜNAL wrote:
>>>> On 24/06/2024 19.29, Conor Dooley wrote:
>>>>> On Mon, Jun 24, 2024 at 10:00:25AM +0300, Arınç ÜNAL wrote:
>>>>>> On 24/06/2024 05.58, Chris Packham wrote:
>>>
>>>>>>>        and the switch registers are directly mapped into SoC's memory map rather than
>>>>>>>        using MDIO. The DSA driver currently doesn't support MT7620 variants.
>>>>>>>        There is only the standalone version of MT7531.
>>>>>>> -  Port 5 on MT7530 has got various ways of configuration:
>>>>>>> +  Port 5 on MT7530 supports various configurations:
>>>>>>
>>>>>> This is a rewrite, not a grammar fix.
>>>>>
>>>>> In both cases "has got" is clumsy wording,
>>>>
>>>> We don't use "have/has" on the other side of the Atlantic often.
>>>
>>> Uh, which side do you think I am from?
>>
>> Who would call it clumsy to use "have" and "got" together for possession...
>> Must be an Irishman! :D
> 
> Okay, I was just making sure you weren't accusing me of being
> American...

Wouldn't be a bigger insult than calling you British anyway. :D

Arınç

