Return-Path: <netdev+bounces-20522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D205F75FED1
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 20:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA0B1C20950
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 18:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DA8100AD;
	Mon, 24 Jul 2023 18:09:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98613E574
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 18:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFE8C433C7;
	Mon, 24 Jul 2023 18:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690222187;
	bh=+pWi1r3aCY7xeRVAh3EZgJfEfKcDCtnfNsmOx5/49f4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R/pADjoK5lpWcAvs6GsyN0/fc9vCEgP9oNnxIo6HlMT2O1huD7JiCdjAtZO28bcIi
	 53FLT1mxN7p2qfdaJItP4aslh7w04VID/PPfkevWVqHm7pYS93tg0gyqb52UCpg5Hu
	 EMWgBDuGO1h50tSM9lO5rj1ckzXm1Q54Qz7L78rV1JK3CFB7JscBFRTHMeDiUioIGf
	 1awNTDgnaxrqjBQGgpnzdOyCsFHYko6rHLTRhX1QINhfRX3EQBWqEmTgqxd9GpQdth
	 ShrZnHZisW356+RzkWzqch3/QXvo2CTbwwsNh/WDcBlsbRcHkiyN7mceHcB+OSxaYl
	 Uum16QHHuvXfQ==
Date: Mon, 24 Jul 2023 11:09:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?= <maze@google.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, Thomas
 Haller <thaller@redhat.com>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, David
 Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Xiao Ma
 <xiaom@google.com>
Subject: Re: [PATCH net v2] ipv6 addrconf: fix bug where deleting a
 mngtmpaddr can create a new temporary address
Message-ID: <20230724110945.55e91964@kernel.org>
In-Reply-To: <CANP3RGfsp3eHmSabzwsvHJbc6mb6QGgfPmoEF3B0t03SHwNkFA@mail.gmail.com>
References: <f3e69ba8-2a20-f2ac-d4a0-3165065a6707@kernel.org>
	<20230720160022.1887942-1-maze@google.com>
	<20230720093423.5fe02118@kernel.org>
	<CANP3RGexoRnp6PRX6OG8obxPhdTt74J-8yjr_hNJOhzHnv1Xsw@mail.gmail.com>
	<CANP3RGfsp3eHmSabzwsvHJbc6mb6QGgfPmoEF3B0t03SHwNkFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Jul 2023 14:07:06 +0200 Maciej =C5=BBenczykowski wrote:
> I see this is once again marked as changes requested.
> Ok, I get it, you win.

FTR wasn't me who set it to changes requested :S=20
My comments were meant more as a request for future postings.

I don't see a repost so let's just bring the v2 back:

pw-bot: under review

