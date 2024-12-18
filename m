Return-Path: <netdev+bounces-153055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD2E9F6AD6
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAE627A2EDA
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EF1148855;
	Wed, 18 Dec 2024 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cawC5tBl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340B14690
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734538580; cv=none; b=RTQA/LnyoLxFXRpPeGC2cQ3vYWWF8kXqzwXKDjV6DemB3MBWqi+7LCFytOeSEW3nE6kK+zFpk7aWuev+Py0rE8sSxLeDqsdICSFj2+gRePHqxqXwLN+lYK8gmF0rlD3hnWwBva/mHq882A/9F7w4LMIoi8yRqPH5OQgUqEf86OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734538580; c=relaxed/simple;
	bh=2ykDN7usEABu5FtwNQsCHDsZTlOsntshgdyfuO2HShY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KsuavtiLkrmR2DDpL3xO+w8VSljQ8iXBpbAi7gTGrv3Vg/GjAYkrWR9RRxQJvCwhje2WgWz6PN4ewFdUNfDQmcQafqxyvjdek9XAUVW0OylVwmBSE0N2CzW3UuMzTw6AU+jV85jOwX2TytUbb5SHlvONlzYIMPNF91L69eYjNUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cawC5tBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55F2C4CECD;
	Wed, 18 Dec 2024 16:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734538579;
	bh=2ykDN7usEABu5FtwNQsCHDsZTlOsntshgdyfuO2HShY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cawC5tBlB1NaVwqcg9ycuvYYDsce1pQ6MRC7KSU5WRVq3bmyY9c5zBPnMCEsFfBNM
	 Orl1+omo0NtJo6bXRp227g207+26AWldeE4gjjFBpLRaWbIuzsKTO+zvsedecD9ihU
	 xwP4dRAVx0FSlUgizXDM/HxdJ74v/ZlbI7+snoD9ic1cIlrKz4Uo55HD/ikkQaFpzS
	 j+SwhibpSqq47UZe3A/Vv6BpK59kiRr07sn6jHSWu7BEgpMVpq9Rv0v/jAuxhFYHAK
	 K5ENmvXjCRBdNEAaRs1tYlLJs/eztpAs1aQnEuYkhB9iGCGWUa6Svi+NNRDL4ZPjQZ
	 ya9His1QTnaRg==
Message-ID: <fe1dda39-7dfb-434c-a6ba-30b9e1e1e74c@kernel.org>
Date: Wed, 18 Dec 2024 08:16:18 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next, v7] iproute2: add 'ip monitor maddress'
 support
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org,
 jimictw@google.com, prohr@google.com, liuhangbin@gmail.com,
 nicolas.dichtel@6wind.com, andrew@lunn.ch, pruddy@vyatta.att-mail.com,
 netdev@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?=
 <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
References: <20241218150852.185489-1-yuyanghuang@google.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241218150852.185489-1-yuyanghuang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/24 8:08 AM, Yuyang Huang wrote:
> 
> Changelog since v6:
> - Remove unnecessary commit messages given that the kernel patch is already
>   merged.

I forgot push v6; applied it over the weekend.


