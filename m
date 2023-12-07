Return-Path: <netdev+bounces-54882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2816808CFE
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 17:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DFC5282139
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 16:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2B146B95;
	Thu,  7 Dec 2023 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieXDQ6gU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2844185B
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 16:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D906BC433C8;
	Thu,  7 Dec 2023 16:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701965928;
	bh=l0+7tHl+gq88vn9FQ2dWVgOBy52qRpm51eLf3HijXoA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ieXDQ6gU9KPZTGp/gw7SBILnpVOhFIKKF7XEgsltEnA1taF11K3GCW7C28muBQSRn
	 T/QtJAkuMhdyYdLf0ELXT/w/x6f9ip70Xn9Vcdki/7uLt8odOEgmC3biTAZD0IN9+t
	 WcC8JXOIfcMfoxdBzPArUIkY4IYl8vNQfdio5Bw9mV17yQmMmc9b0EuXMqPLbL39pI
	 VtvjCHQiKFIhqrV5RjFQ5mi7w7LvbnjlH5qeAQwaks8ztRnjTQ4baZCNvndnw1wHh6
	 urDozRpfawUv9EHM5ZFxVQNDSxvNdCtn5/flvSSBJODO4+msXWprsYp9cZj6GoLgli
	 4wEl5wvIHjRYw==
Message-ID: <5889e545-ee31-4f0f-bf27-5f9ebd9d24fc@kernel.org>
Date: Thu, 7 Dec 2023 09:18:47 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] net: ipv6: support reporting otherwise unknown
 prefix flags in RTM_NEWPREFIX
Content-Language: en-US
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
 =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Lorenzo Colitti <lorenzo@google.com>
References: <20231206173612.79902-1-maze@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231206173612.79902-1-maze@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/6/23 10:36 AM, Maciej Żenczykowski wrote:
> Lorenzo points out that we effectively clear all unknown
> flags from PIO when copying them to userspace in the netlink
> RTM_NEWPREFIX notification.
> 
> We could fix this one at a time as new flags are defined,
> or in one fell swoop - I choose the latter.
> 
> We could either define 6 new reserved flags (reserved1..6) and handle
> them individually (and rename them as new flags are defined), or we
> could simply copy the entire unmodified byte over - I choose the latter.
> 
> This unfortunately requires some anonymous union/struct magic,
> so we add a static assert on the struct size for a little extra safety.
> 
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Maciej Żenczykowski <maze@google.com>
> ---
>  include/net/addrconf.h | 12 ++++++++++--
>  include/net/if_inet6.h |  4 ----
>  net/ipv6/addrconf.c    |  6 +-----
>  3 files changed, 11 insertions(+), 11 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>

