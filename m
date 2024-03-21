Return-Path: <netdev+bounces-81122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F70B885FF0
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 18:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF94E1C21504
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 17:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E9C762EB;
	Thu, 21 Mar 2024 17:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xf79fn3N"
X-Original-To: netdev@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1948C0A
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 17:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711042898; cv=none; b=rDx+UmtQ5CBZoa8xRn0c7xEha3c13hItze8wgTenS29UfImqRyXXNaFjpKWO1mAtTH+KcU/p8pdT7ZfeG2akhy710/SGrCe9FGIz+awqgkt9YfpM8/AoQyxojeicEICtYSb8q+aTT/w9Etj3RXTcwW58M3kzIfkyj0/VjklFzwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711042898; c=relaxed/simple;
	bh=Ddafupa7iYOvMi+sXqfxmGGV7rCcvsCabj+hxTgAiD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4eH6+Vt56Wwg8Kstz4qdMGBOpWkF5OyHDqtnHUb4thRADahU9ZCbambxJ8FNJPiZm7fLv/mb7V4iASBxg+D76mS7J5fRD9yEk3d8EanCYTr/gH9+83nOtKsz5Fktbg3jLTJPEO2aZzACIQKF24+beTRJbuKgLMpXNgX4rZSBxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xf79fn3N; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id BF66832000D7;
	Thu, 21 Mar 2024 13:41:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 21 Mar 2024 13:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711042894; x=1711129294; bh=822J1JVuqbXk+PxzQ6ijlTZ3vZ4t
	+qgKbmLkE0nki7U=; b=Xf79fn3NQTPgG2ZH8lu1f6ILueo9nFJ50LN0RW2vm546
	xQIl3agmcH6jxCu6b6ATBmuHS6zPROApOsAVPF4mi0W6WJiLUT/gTxj08901hH9O
	01jVpqOWLT9y5AP0BQYxx1F9VSrIJWhZXVdWsiQmLBhnDHtzHubtOhckNrva4vk3
	Amq6jU2g89V1tgw1HNJUdw8WZyOHM9AP7RvXGjBNmTOoEooGFU9WVWfhQtjvlEc5
	9WBR+fQZzI6a87XjyilaqrjuzdmpD3gy0GYivx2bcPMB07y1TxGpdZbX2uVC/zIL
	OlaA411tZjgYa+KT3KXNsSLVY0zvrmsXA82beDECRA==
X-ME-Sender: <xms:TXH8ZcBzZP37zlI71NqPAIWBN-y-nHC1WYLSWh57JjS-zTjvqb3kjw>
    <xme:TXH8ZejkuaAe6A-UoLIEKI1GTh2CkAiCLXcJJevdXFHcroXbZYIzoNXDScO9i2qmk
    ljN3dl9VvnE8Ks>
X-ME-Received: <xmr:TXH8Zfk-D6D3eMkIOBa68UKvd2FHSxQ7ngCDXhiDYMBfq74pvKpa6v_sTNJh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleejgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpeffueevhffhuddvjeetfeeuudfgheegledvveehheeuueduvdehgedtteefheeg
    feenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:TXH8ZSzygBnMovpcbDpDbjBMEo4J-USgOeq55moGZyBAAJuIx58rLQ>
    <xmx:TXH8ZRRpTlootCA443LWB4bd1_WOzwSb6qyPy-UP7Rfg74coBEyokw>
    <xmx:TXH8ZdZRIZ30dDNhzdMu3lbGCuo6CgXEGFAV3-y9OEFn8WAzS6h3Cw>
    <xmx:TXH8ZaStm07fWqHALk9zifaFGFztozZvHN7ONoSSNlHj612YyThx6w>
    <xmx:TnH8ZQJf3gFwOHy8nz1QxM4U58nPXEeAho9Jr3UEtnbwImQP9TWHtw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 13:41:32 -0400 (EDT)
Date: Thu, 21 Mar 2024 19:41:28 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Gal Pressman <gal.pressman@linux.dev>, Jakub Kicinski <kuba@kernel.org>,
	Stefano Brivio <sbrivio@redhat.com>, davem@davemloft.net,
	netdev@vger.kernel.org, pabeni@redhat.com, jiri@resnulli.us,
	johannes@sipsolutions.net, fw@strlen.de, pablo@netfilter.org,
	Martin Pitt <mpitt@redhat.com>,
	Paul Holzinger <pholzing@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH net-next v2 3/3] genetlink: fit NLMSG_DONE into same
 read() as families
Message-ID: <ZfxxSBddQnLPfafc@shredder>
References: <20240303052408.310064-1-kuba@kernel.org>
 <20240303052408.310064-4-kuba@kernel.org>
 <20240315124808.033ff58d@elisabeth>
 <20240319085545.76445a1e@kernel.org>
 <CANn89i+afBvqP564v6TuL3OGeRxfDNMuwe=EdH_3N4UuHsvfuA@mail.gmail.com>
 <20240319104046.203df045@kernel.org>
 <7e261328-42eb-411d-b1b4-ad884eeaae4d@linux.dev>
 <Zfw7YB4nZrquW4Bo@shredder>
 <CANn89i+kqdRZrM6Z4TaUcW8q3UL1yzrsOm76mkP2znDAVX2YFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+kqdRZrM6Z4TaUcW8q3UL1yzrsOm76mkP2znDAVX2YFA@mail.gmail.com>

On Thu, Mar 21, 2024 at 06:26:31PM +0100, Eric Dumazet wrote:
> The following seems to react quite differently :
> 
> # ip addr  show lo
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
> group default qlen 1000
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>     inet 127.0.0.1/8 scope host lo
>        valid_lft forever preferred_lft forever
>     inet6 ::1/128 scope host proto kernel_lo
>        valid_lft forever preferred_lft forever
> # ip link set dev lo mtu 1000
> # ip addr  show lo
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 1000 qdisc noqueue state UNKNOWN
> group default qlen 1000
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>     inet 127.0.0.1/8 scope host lo
>        valid_lft forever preferred_lft forever

Yes, for loopback the NETDEV_CHANGEMTU event is treated as NETDEV_DOWN
rather than NETDEV_UNREGISTER:

if (dev->mtu < IPV6_MIN_MTU) {
	addrconf_ifdown(dev, dev != net->loopback_dev);
	break;
}

vim net/ipv6/addrconf.c +3656

> Reviewed-by: Eric Dumazet <edumazet@google.com>

Sorry Eric, already sent the patch without your tag:

https://lore.kernel.org/netdev/20240321173042.2151756-1-idosch@nvidia.com/

