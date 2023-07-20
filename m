Return-Path: <netdev+bounces-19585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B24975B48B
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 18:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F6A281EE8
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 16:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4E81BE8E;
	Thu, 20 Jul 2023 16:34:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523B42FA54
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 16:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A2CC433C7;
	Thu, 20 Jul 2023 16:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689870864;
	bh=3k4R/ohNBh4CLVom8Z/hG6btaqm/1S0Go/stgakaTHM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uGZZVRIXKC/V88/RbvYfOGJRezDB3JhrHTxeVxOjzKdaiBIU4J2vQ7rJzS0DtuurT
	 I0QkPESRfwl9Qb5a2TSsQ7Q1YBcvQcuZAMximzN9+shJavyguQLUgr7hngsEuRpkBG
	 nTqY5ojs+aSiTSBeYyPG0DuBByyWEyvTLHJh0xji3fV0U/cx9EdgOfTpc/xo+xluZl
	 r8zkmFu6Y/t2+rcqu8LcBuLplKVALcQJ3CcakCifiuoGfqdVJIk6EgTc9+TSiepOHQ
	 fFN4d/aT3AYYiSrb90S8CFSmdPmKkUOLPZvXZVZRpzPBC+D7E3kpKxOPVKMlYiYBJ+
	 OoH3noERMIMxA==
Date: Thu, 20 Jul 2023 09:34:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?=" <maze@google.com>
Cc: "Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?=" <zenczykowski@gmail.com>,
 Linux Network Development Mailing List <netdev@vger.kernel.org>, Thomas
 Haller <thaller@redhat.com>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, David
 Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Xiao Ma
 <xiaom@google.com>
Subject: Re: [PATCH net v2] ipv6 addrconf: fix bug where deleting a
 mngtmpaddr can create a new temporary address
Message-ID: <20230720093423.5fe02118@kernel.org>
In-Reply-To: <20230720160022.1887942-1-maze@google.com>
References: <f3e69ba8-2a20-f2ac-d4a0-3165065a6707@kernel.org>
	<20230720160022.1887942-1-maze@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Jul 2023 09:00:22 -0700 Maciej =C5=BBenczykowski wrote:
> currently on 6.4 net/main:
>=20
>   # ip link add dummy1 type dummy
>   # echo 1 > /proc/sys/net/ipv6/conf/dummy1/use_tempaddr
>   # ip link set dummy1 up
>   # ip -6 addr add 2000::1/64 mngtmpaddr dev dummy1
>   # ip -6 addr show dev dummy1

FTR resending the patch as part of the same thread is really counter
productive for the maintainers. We review patches in order, no MUA
I know can be told to order things correctly when new versions are sent
in reply.

Don't try too hard, be normal, please.

