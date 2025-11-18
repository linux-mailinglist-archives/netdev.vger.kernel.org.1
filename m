Return-Path: <netdev+bounces-239729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2022CC6BCAC
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 23:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id D158C2BA07
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 22:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B63223705;
	Tue, 18 Nov 2025 22:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="dYjl3/bQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5965B3702F1;
	Tue, 18 Nov 2025 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763503243; cv=none; b=X3jkOpmkJm9H4TumoLBg6/PfgmMi6k/lKaqxP1KEnPEjWwXCkaECC/B1bSkmR0TZ8YgJbWHLxY4UMhH0dsrj3da0/luxsUaE4y40vnOleELTNAjx3W57+BCMrFiuQZzFp/C8rL0KTrz0whW2dZ3Bd5f/2vitgs0scgNLEegysho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763503243; c=relaxed/simple;
	bh=wSq9nkMhOrqUYoM5UqOfCd2cKo+gg7tNC4z9SKtDj4w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KvqBXVIJniHV3iOa+xsl1FbgmjBde3LQY65EYue1lEz+9gnEi1he2pywYUORwqV96koJDw995cM2kzXp5J99sapTTY13npIpJG6obsRwgiMyxIhBx4Yvg5pGEdwztsASfFno894gW10uD776kuix/NYqODbAgi6IlvYx97V+yZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=dYjl3/bQ; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1763503234;
	bh=wSq9nkMhOrqUYoM5UqOfCd2cKo+gg7tNC4z9SKtDj4w=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=dYjl3/bQdM0hW+WrDre6UuCHpWvPcVo/N42mZ2IbStpO4QvSci5Ph6N9dQgKFFkGJ
	 8C7K1ZKVcZ3ExJDzp9oFaf8cvNgWNhyTy5zE+r68cUm2Z0m5TESm91JCBZ3Mi9VplQ
	 CN2tzNF93bpSV6MXB3SC9pYrAEwS5wzejbgWJF8xWTRthN09fTeFYP9wXjOQ2tftQV
	 b7IAxDrGOPXepLM+GcfiT2I7f/N0x41X3KGIZUAjfH/8j8nfiAjMUhJz29W92WpTor
	 vgD/W0QBpHhsgfd8FRcNi0rsjPFTrK1/3Fw90sOzufW2xiPpPE7rRaHjHOdAKcM0kJ
	 aUb1YMmVFc/Dg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 46794600FC;
	Tue, 18 Nov 2025 22:00:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id D2457203EA5;
	Tue, 18 Nov 2025 21:59:45 +0000 (UTC)
Message-ID: <9871bdc7-774d-4e35-be5f-02d45063d317@fiberby.net>
Date: Tue, 18 Nov 2025 21:59:45 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Subject: Re: [PATCH net-next v3 04/11] netlink: specs: add specification for
 wireguard
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jordan Rife <jordan@jrife.io>
References: <20251105183223.89913-1-ast@fiberby.net>
 <20251105183223.89913-5-ast@fiberby.net> <aRvWzC8qz3iXDAb3@zx2c4.com>
 <f21458b6-f169-4cd3-bd1b-16255c78d6cd@fiberby.net>
 <aRyLoy2iqbkUipZW@zx2c4.com>
Content-Language: en-US
In-Reply-To: <aRyLoy2iqbkUipZW@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/18/25 3:07 PM, Jason A. Donenfeld wrote:
> On Tue, Nov 18, 2025 at 12:08:20PM +0000, Asbjørn Sloth Tønnesen wrote:
>>> There's lots of control over the C output here. Why can't there also be
>>> a top-level c-function-prefix attribute, so that patch 10/11 is
>>> unnecessary? Stack traces for wireguard all include wg_; why pollute
>>> this with the new "wireguard_" ones?
>>
>> It could also be just "c-prefix".
> 
> Works for me.

Unfortunately, it isn't that simple.

The functions are defined as:
name = c_lower(f"{family.ident_name}-nl-{op_name}-doit")
name = c_lower(f"{family.ident_name}-nl-{op_name}-dumpit")
and
name = c_lower(f"{family.ident_name}-nl-{op_name}-{op_mode}it")

The "c-prefix" would replace "family.ident_name" aka. "wireguard",
but the "-nl-" would remain, which isn't in the current naming.

So "c-function-prefix" or something might work better.

My idea with "c-prefix" was to also cover the family and version defines,
but they are eg. WG_GENL_NAME where the default would be *_FAMILY_NAME.

>>>> +      dump:
>>>> +        pre: wireguard-nl-get-device-start
>>>> +        post: wireguard-nl-get-device-done
>>>
>>> Oh, or, the wg_ prefix can be defined here (instead of wireguard_, per
>>> my 10/11 comment above).
>>
>> The key here is the missing ones, I renamed these for alignment with
>> doit and dumpit which can't be customized at this time.
> 
> Oh, interesting. So actually, the c-prefix thing would let you ditch
> this too, and it'd be more consistent.

The pre and post still needs to be defined as they aren't used by default.

