Return-Path: <netdev+bounces-240537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3544DC761FE
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 20:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id E9826291A9
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 19:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0EC302743;
	Thu, 20 Nov 2025 19:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="RXZmxoDq"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B276D36D506;
	Thu, 20 Nov 2025 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763668186; cv=none; b=Ub625xdmof5PDrHY/VS5qg7CnN6MwguifD9+sEr0PEec+1DZp6VXCZdPR1i7fptg4fLcTbrpwgnUkadDuL1hOOphJ9GuHlyUJAUCoYhWPu34ylJagvaR/BTZw+Pga7BcKacXmX9l3TrqxVIyj/xL9XcgHBUS8dYj3miLwBGuHF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763668186; c=relaxed/simple;
	bh=aaQG0ySZh1Xhb3rGAP0lpVyomQzOOTAj00uXOU0D6mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d2/WvtYCn3DW1y1PnjqBgTNgX4Rn3Kok9SW5vGzYhGwSqmqlQbp2XYwqq2R43Y3HEMALaUoOgy/lslR7+GgkXVyUfI/n09q0h4jW9RjTLwd6AseOf+MsBaGuqK6TrVbJqVWVZ+auVs8CB/yUyC8anAOi8eZE1GGC15TYeNg0nQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=RXZmxoDq; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1763668174;
	bh=aaQG0ySZh1Xhb3rGAP0lpVyomQzOOTAj00uXOU0D6mo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RXZmxoDqsHM3U+fR6/ajCo/wBknWKev49UZoh23h/ZxTCcyrjiEGRa5zqya23A7c/
	 +3ggLQd5LiX3wXgEoVRuWjGvZhlBHGFS6+MG5Tx8lFbDYLkb5w/hiIsTnT2WBJ2oQh
	 14rB+E/PeVqpPhydZN1XGtl/bah0ZMu0jS7L2fBqeliK6FxWGGt8I6KgnWgXRNieDv
	 Y/hSrA7LxZCLYwl4YO0LuxtE0zkm5q/nEBgeAXblijCetwyf8tuPk9ZkYwqI+erRxA
	 WBBUtA5qX9d0xhoW/dtsj122s6v+aKav29kVtLwomUCIOMZzpIfsQ11tX4AyQx2m8L
	 SnWYHfT2DEOOw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id E2038600FC;
	Thu, 20 Nov 2025 19:49:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 67C0D2002DF;
	Thu, 20 Nov 2025 19:49:08 +0000 (UTC)
Message-ID: <6eb6b171-31f5-4c30-aab6-277f32d48678@fiberby.net>
Date: Thu, 20 Nov 2025 19:49:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 11/11] wireguard: netlink: generate netlink
 code
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jordan Rife <jordan@jrife.io>
References: <20251105183223.89913-1-ast@fiberby.net>
 <20251105183223.89913-12-ast@fiberby.net> <aRyNiLGTbUfjNWCa@zx2c4.com>
 <d2e84a2b-74cd-44a1-97a6-a10ece7b4c5f@fiberby.net>
 <aRz4eVCjw_JUXki6@zx2c4.com> <20251118170045.0c2e24f7@kernel.org>
 <aR5m174O7pklKrMR@zx2c4.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <aR5m174O7pklKrMR@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/25 12:54 AM, Jason A. Donenfeld wrote:
> On Tue, Nov 18, 2025 at 05:00:45PM -0800, Jakub Kicinski wrote:
>> On Tue, 18 Nov 2025 23:51:37 +0100 Jason A. Donenfeld wrote:
>>> I mean, there is *tons* of generated code in the kernel. This is how it
>>> works. And you *want the output to change when the tool changes*. That's
>>> literally the point. It would be like if you wanted to check in all the
>>> .o files, in case the compiler started generating different output, or
>>> if you wanted the objtool output or anything else to be checked in. And
>>> sheerly from a git perspective, it seems outrageous to touch a zillion
>>> files every time the ynl code changes. Rather, the fact that it's
>>> generated on the fly ensures that the ynl generator stays correctly
>>> implemented. It's the best way to keep that code from rotting.
>>
>> CI checks validate that the files are up to date.
>> There has been no churn to the kernel side of the generated code.
>> Let's be practical.
> 
> Okay, it sounds like neither of you want to do this. Darn. I really hate
> having generated artifacts laying around that can be created efficiently
> at compile time. But okay, so it goes. I guess we'll do that.

I generally agree, but given this generates code across the tree, then I
prefer this, as side-effects are more obvious.

To complete Jakub's earlier argument of not complicating everyone's life,
then this code generator is Python-based and depends on yaml and jsonschema.
Even doing compile-time generation for a single family, would elevate those
packages from developer-dependencies to build-dependencies.

> I would like to ask two things, then, which may or may not be possible:
> 
> 1) Can we put this in drivers/net/wireguard/generated/netlink.{c.h}
>     And then in the Makefile, do `wireguard-y += netlink.o generated/netlink.o`
>     on one line like that. I prefer this to keeping it in the same
>     directory with the awkward -gen suffix.

Sure, there isn't much consistency across families anyway.

