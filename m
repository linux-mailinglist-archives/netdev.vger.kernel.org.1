Return-Path: <netdev+bounces-240158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA453C70E31
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5D540347F0D
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57105371DCA;
	Wed, 19 Nov 2025 19:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="EGQtZOMM"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC25836C0B8;
	Wed, 19 Nov 2025 19:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763581645; cv=none; b=AEsGE1lMDaBW5ZDgteh1941Yd47lkPQHbOol25hY13bkyK38puBj+WwvAR2xbfgnDZIqi3xscuxVqyzR74WzoHof4m5hDCKyC+tF6oZd3S0TaI0P5iYl1IsgP+nfhf15/VFkTW2A4iyWUSRbGKNSfya3g6Q0KGy1B2JM+fiesqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763581645; c=relaxed/simple;
	bh=KsI8Umf4mFSB6UvvlEIpBMW3/4PuQgsM3Xm+he9VpiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+dSzvmHNp/HA3VAhnut+55zVFoXJ8l8WM/8XtuimciotM5TH5so1EFL8aoCjRFNA6P78IlDe8KasgWVHGeMb9sQpeODGW0gc+VnE3ojc4SAkQXAGVk9NcKbJlraMldcL2J5lG9B6s/bdpT0BZEwlTETqFxQD5Nk/PEUE+qxZhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=EGQtZOMM; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1763581638;
	bh=KsI8Umf4mFSB6UvvlEIpBMW3/4PuQgsM3Xm+he9VpiQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EGQtZOMMqC3N7PPrM+5Z4snmrD4mUcpaa6R20RoV9h/fzNab8WQjxtImodyGzpkXe
	 /xfleVAzRCQePC1WUCMNoi2WF7uJqUrKDGRfj5iYHZgzmelN0b2piwnwkWSlwBeeVd
	 c24s66iVrPvXn67i4ZpQ2WOgOxVBC5Etp1Q2DcB+ZEQXAvWZfTPCChT7LuM93u/XKW
	 gszRsfBfJYnhla6b7Pz5AJfvpxuKFhJzHoQJYpZtYhsLBYoZt7MwPEYDotcCaVxuTy
	 yxn+9jeThY1hrsb+bkbIDugRhm1o0NC3yIG9HYLHqbX01Dm0GdtBwVJkqTb8guVyFV
	 pvqmLNlIDAwAg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id D623D600FC;
	Wed, 19 Nov 2025 19:47:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id D9FEC2017A4;
	Wed, 19 Nov 2025 19:47:13 +0000 (UTC)
Message-ID: <36bdb7f1-fb64-44b5-8848-6c3a8d37b88d@fiberby.net>
Date: Wed, 19 Nov 2025 19:47:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 04/11] netlink: specs: add specification for
 wireguard
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jordan Rife <jordan@jrife.io>
References: <20251105183223.89913-1-ast@fiberby.net>
 <20251105183223.89913-5-ast@fiberby.net> <aRvWzC8qz3iXDAb3@zx2c4.com>
 <f21458b6-f169-4cd3-bd1b-16255c78d6cd@fiberby.net>
 <aRyLoy2iqbkUipZW@zx2c4.com>
 <9871bdc7-774d-4e35-be5f-02d45063d317@fiberby.net>
 <aRz4rs1IpohQpgWf@zx2c4.com> <20251118165028.4e43ee01@kernel.org>
 <f4d147da-3299-4ae7-b11e-b4309625e2c9@fiberby.net>
 <CAHmME9rzr8EGkTy3TduTXK45-w1CwEYnRLX=SjkAqo1CTTgVHA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <CAHmME9rzr8EGkTy3TduTXK45-w1CwEYnRLX=SjkAqo1CTTgVHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/19/25 7:22 PM, Jason A. Donenfeld wrote:
> On Wed, Nov 19, 2025 at 8:20 PM Asbjørn Sloth Tønnesen <ast@fiberby.net> wrote:
>> B) Add a "operations"->"function-prefix" in YAML, only one funtion gets renamed.
>>
>>      wg_get_device_start(), wg_get_device_dump() and wg_get_device_done() keep
>>      their names, while wg_set_device() gets renamed to wg_set_device_doit().
>>
>>      This compliments the existing "name-prefix" (which is used for the UAPI enum names).
>>
>>      Documentation/netlink/genetlink-legacy.yaml |  6 ++++++
>>      tools/net/ynl/pyynl/ynl_gen_c.py            | 13 +++++++++----
>>      2 files changed, 15 insertions(+), 4 deletions(-)
>>
>> Jason, would option B work for you?
> 
> So just wg_set_device() -> wg_set_device_doit()? 

Sorry, no, wg_get_device_dump{,it} too.

Did my test on top of my branch were they are still renamed, so overlooked that rename.

