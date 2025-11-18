Return-Path: <netdev+bounces-239650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D8292C6AE98
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 18:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id EA3192CDB6
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 17:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2420369237;
	Tue, 18 Nov 2025 17:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="KI5buitu"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C022369201;
	Tue, 18 Nov 2025 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763486212; cv=none; b=hnt4EueDCTRO6i8yDyZFWWPDhKXi4mS8Ic1ZFY91ddJeS6BeedJK7RowuyDYbOgWTTD+n41hDRcAylH5Y9ZcIAgx1odZ/G6gvPvVF2kN+92w+m5A9LkGHPByNKPFwC1+r6NINdaLiuDa9DNJtUIOOYT09TEhg9HNA019GYkryPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763486212; c=relaxed/simple;
	bh=HhJcusgK4gBGdJeJoNSwYRT1qkaAQlNrgbmsRu5oSFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4zwj1zubW7hOiAqBY/H8JRB3vqpXLsSzV0hCXiYor8rg+V21Q3xHy9TMNwrbflxzIjJsbT2p9JDbYMZQSZhuqgCkmNK27lxAaak9eR8YZH9cysKTOB8p4n/IDBCQ9TvW3t7pAf3L9ToNVbhdKxZyEl4Q4jnawNXntd/RvM6UFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=KI5buitu; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1763486205;
	bh=HhJcusgK4gBGdJeJoNSwYRT1qkaAQlNrgbmsRu5oSFs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KI5buituNFxmPC1Ezzluw4+/nkc/uuapbnCZVH3CP3sYH0GDSpuiUUDDagz1lr3s3
	 4tA7yx2+KtPXaVRtJmup/psjBjRI3wlAFp11m+dldHlfJYLpU9YQVSTDWZruJEuLQ+
	 AcWrSI7+tb3VRte7/WSuJ01dC5EQGbc7M3Byzdmpq5Ejz1IxSpNPhPQvxyPhh+sCH5
	 CP8HphNNflhH62kP7i7jd+8JhiyPgBEsgUqD22/wA6owtOHUgHaIvcZnp9ggdylxXE
	 h9KLd3LeaCs3cyRaCsry3miMNMaGIlqUnWb0qtJdDu/+ethufv+uesjBCkQMLr6ycH
	 v2wEOP6kBs8zw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id BD11A600FC;
	Tue, 18 Nov 2025 17:16:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 591372017A4;
	Tue, 18 Nov 2025 17:16:12 +0000 (UTC)
Message-ID: <29155dac-97c4-4213-8db5-194d9109050e@fiberby.net>
Date: Tue, 18 Nov 2025 17:16:12 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 08/11] tools: ynl: add sample for wireguard
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jordan Rife <jordan@jrife.io>
References: <20251105183223.89913-1-ast@fiberby.net>
 <20251105183223.89913-9-ast@fiberby.net> <aRyO2mvToYf4yuwY@zx2c4.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <aRyO2mvToYf4yuwY@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/18/25 3:20 PM, Jason A. Donenfeld wrote:
> On Wed, Nov 05, 2025 at 06:32:17PM +0000, Asbjørn Sloth Tønnesen wrote:
>> +CFLAGS_wireguard:=$(call get_hdr_inc,_LINUX_WIREGUARD_H,wireguard.h) \
>> +	-D _WG_UAPI_WIREGUARD_H # alternate pre-YNL guard
> 
> I don't totally grok what's going on here. As I understand it, this
> makefile creates `wireguard-user.h` in the generated/ include path,
> which has all the various netlink wrapper declarations. And then this
> also references, somehow, include/uapi/linux/wireguard.h, for the constants.
> For some reason, you're then defining _WG_UAPI_WIREGUARD_H here, so that
> wireguard.h from /usr/include doesn't clash. But also, why would it?
> Isn't this just a matter of placing $(src)/include/uapi earlier in the
> include file path?

The aim is to use the generated in-tree header, while avoiding making a
copy, and avoiding the system header.

As an example then in tools/net/ynl/generated/Makefile:

%-user.o: %-user.c %-user.h
         @echo -e "\tCC $@"
         @$(COMPILE.c) $(CFLAGS_$*) -o $@ $<

Where for the "wireguard-user.o" target, then "$(CFLAGS_$*)" expands to
"$CFLAGS_wireguard".

CFLAGS_wireguard has two parts the normal one similar to the other families,
and a transitional extra guard.

The header guard in the old UAPI header is "_WG_UAPI_WIREGUARD_H".
The header guard in the new UAPI header in-tree is "_UAPI_LINUX_WIREGUARD_H".
The header guard in the new UAPI header in-system is "_LINUX_WIREGUARD_H".

Linux uapi headers are installed using scripts/headers_install.sh, which
transforms the headers slightly, one of these transformations is to alter
the header guard, stripping the _UAPI in the beginning of the guard.

So "get_hdr_inc=-D$(1) -include $(UAPI_PATH)/linux/$(2)" does:
1) Defines the in-system guard
2) Includes the in-tree header

The purpose of defining the in-system guard is disable the include in
the code, as it's header guard is already defined.

I added the extra transitional define of the old UAPI guard, so that
it also works on systems with the old header installed in /usr.
This extra line can be removed in a few releases, when we don't care
about compiling these tools on a system with the old header installed.

