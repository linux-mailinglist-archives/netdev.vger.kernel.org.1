Return-Path: <netdev+bounces-106215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE23F91551D
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 19:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A904C28559D
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 17:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1B419EEB6;
	Mon, 24 Jun 2024 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="LOQzn95F"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570C61EA87;
	Mon, 24 Jun 2024 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719249088; cv=none; b=U9N2gi4GwfNFxUE5GV1aJkbXTeLcbmJhcz3Sen+BVPRJWOdEAaOkvE/rwEKXpCiKxyWTrvcONCuqYOsQ/4yqKxdlRaMzxEyFvqynSH72IOYCeIGrAwLHu4sBl1+5jJqCg3rAozJhV3lqBrDTtcGEzB/lk6hUiow34Yo2uYusDR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719249088; c=relaxed/simple;
	bh=aXXT46SUGpiJ27fZUeOgMf5lZkDl9JQ5BySNUsfBIy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G35YIWZPWkLCT7Aokf+GzeD0rUkh6I88/CIrikRGAWsUH+++BDjjPJLc7genudEJzaJk9hmXnoybR7vQB5vLnsUk/59t2FLWrDkOfBLqfkhU1YBkwzmkRE0D/JcNNjBUZInDk5JkUezSND+ClUUsvp8Nm4ufJhn4tEg2JIspTus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=LOQzn95F; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 36DF61BF203;
	Mon, 24 Jun 2024 17:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1719249078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cbq+IRDjaXI3n18CSkRfCToz7wao508HEFXD7HtdFds=;
	b=LOQzn95Fd2nYfNo6AEWfDttJbKX5hiNjfxAXVjsdZMqv2HfwoaS/h6voCJIITx+1WD4IuM
	Y2xnhslNCADv0pFF7Hzj+kVsbifxwRAghOXOevy3iKT7NUyFfva88n00G5LRy787T+JkJu
	iOkrqgv4XjwHv5LfHY5KN4oLgynuo9xrMuseUpgl+0mgHJo+iZ7G+Bw+uPCvVbD+evka9M
	hWYrCAcCLDoy0b/IdA8sGeZQdb4EGbtnkOlUEa728UPA1NIo8pCGyFYhr20t/6oupnF5Mb
	R6y+mLGjcHNsZvA+mRzsZMUyeZOt7mfh+0mJdCrxhasFO5o6ngf5a8bQ7YF+Qg==
Message-ID: <a17f35ae-5376-458a-b7b5-9dbefd843b40@arinc9.com>
Date: Mon, 24 Jun 2024 20:11:10 +0300
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
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240624-supernova-obedient-3a2ba2a42188@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 24/06/2024 20.02, Conor Dooley wrote:
> On Mon, Jun 24, 2024 at 07:59:48PM +0300, Arınç ÜNAL wrote:
>> On 24/06/2024 19.29, Conor Dooley wrote:
>>> On Mon, Jun 24, 2024 at 10:00:25AM +0300, Arınç ÜNAL wrote:
>>>> On 24/06/2024 05.58, Chris Packham wrote:
> 
>>>>>       and the switch registers are directly mapped into SoC's memory map rather than
>>>>>       using MDIO. The DSA driver currently doesn't support MT7620 variants.
>>>>>       There is only the standalone version of MT7531.
>>>>> -  Port 5 on MT7530 has got various ways of configuration:
>>>>> +  Port 5 on MT7530 supports various configurations:
>>>>
>>>> This is a rewrite, not a grammar fix.
>>>
>>> In both cases "has got" is clumsy wording,
>>
>> We don't use "have/has" on the other side of the Atlantic often.
> 
> Uh, which side do you think I am from?

Who would call it clumsy to use "have" and "got" together for possession...
Must be an Irishman! :D

