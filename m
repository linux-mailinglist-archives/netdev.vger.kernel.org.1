Return-Path: <netdev+bounces-21672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D017642DB
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 02:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138461C21497
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 00:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C53646;
	Thu, 27 Jul 2023 00:11:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5313C19C
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 00:11:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777A2C433C8;
	Thu, 27 Jul 2023 00:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690416684;
	bh=tKiRxD59OQixQ/evxuII/f2eAwOKeS3mdm+pVnVX+sI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UXKssJi+hZYTx+FhcYd583PTDvNIviwNYhxHkxMwqnAdHx77jakmR86QYiCdslsPn
	 coI6ChtYTro1hqCsi/GBnakYTVG/RZrmtfiy59meovOLzdsvuDh1flm7dXzAkDDazC
	 BConrzR++XSHeiOkcaUEPoUASdbpj5z2WRG9Ay8G6nrfkiNYtzAN6LYHsuxeq1/sYQ
	 /ud6OX7M2m2zn197b2aSkziC3YNRJqFRYMMLXbzF7zHkIsLcKbd4er8YxubZsBqNqP
	 C9BMPlc3+Od1T0sxGB37Jr3rdcWspbnvyzYEzy9QtHiyCesWb0Qg/RvOpdnUAOC3MU
	 wrH0l44JSvXig==
Date: Wed, 26 Jul 2023 17:11:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Joe Perches
 <joe@perches.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 geert@linux-m68k.org, gregkh@linuxfoundation.org, netdev@vger.kernel.org,
 workflows@vger.kernel.org, mario.limonciello@amd.com
Subject: Re: [PATCH v2] scripts: get_maintainer: steer people away from
 using file paths
Message-ID: <20230726171123.0d573f7c@kernel.org>
In-Reply-To: <20230726-june-mocha-ad6809@meerkat>
References: <CAHk-=wi9MyyWmP_HAddLrmGfdANkut6_2f9hzv9HcyTBvg3+kA@mail.gmail.com>
	<20230726114817.1bd52d48@kernel.org>
	<CAHk-=wiuR7_A=PbN8jhmqGPJQHypUHR+W4-UuSVhOVWvYXs1Tg@mail.gmail.com>
	<CAHk-=wh4pbrNZGqfV9u1urZr3Xjci=UV-MP+KneB6a5yo7-VOQ@mail.gmail.com>
	<CAHk-=whCE9cWmTXu54WFQ7x-aH8n=dhCux2h49=pYN=14ybkxg@mail.gmail.com>
	<20230726130318.099f96fc@kernel.org>
	<CAHk-=wjfC4tFnOC0Lk_GcU4buf+X-Jv965pWg+kMRkDb6hX6mw@mail.gmail.com>
	<20230726133648.54277d76@kernel.org>
	<CAHk-=whZHcergYrraQGgazmOGMbuPsDfRMBXjFLo1aEQPqH2xQ@mail.gmail.com>
	<20230726145721.52a20cb7@kernel.org>
	<20230726-june-mocha-ad6809@meerkat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jul 2023 19:47:31 -0400 Konstantin Ryabitsev wrote:
> > And have every other subsystem replicate something of that nature.
> > 
> > Sidebar, but IMO we should work on lore to create a way to *subscribe*
> > to patches based on paths without running any local agents. But if I
> > can't explain how get_maintainers is misused I'm sure I'll have a lot
> > of luck explaining that one :D  
> 
> I just need to get off my ass and implement this. We should be able to offer
> the following:
> 
> - subsystem maintainers come up with query language for what they want
>   to monitor (basically, whatever the query box of lore.kernel.org takes)
> - we maintain a bot that runs these queries and populates a public-inbox feed
> - this feed is available via read-only pop/imap/nntp (pull subscription)
> - it is also fed to a mailing list service (push subscription)

*Nod*

> The goal is to turn the tables -- instead of patch submitters needing to
> figure out where the patch needs to go (via get_maintainer or similar
> scripts), they just send everything to lkml or patches@lists.linux.dev and let
> the system figure out who needs to look at them.

My initial motivation for this was to let people (who are *not*
maintainers) subscribe to parts of netdev. During previous cycles we
saw ~246 emails a day. If someone is only interested in e.g. IP routing
fishing out the one routing patch a week from all the driver noise is
almost impossible.

> That's for the part that I was already planning to do. In addition, coming
> back to the topic of this thread, we could also look at individual patches
> hitting the feed, pass them through any desired configuration of
> get_maintainer.pl, and send them off any recipients not already cc'd by the
> patch author. I believe this is what you want to have in place, right, Jakub?

Hm, hm. I wasn't thrilled by the idea of sending people a notification
that "you weren't CCed on this patch, here's a link". But depending on
your definition of "hitting the feed" it sounds like we may be able to
insert the CC into the actual email before it hits lore? That'd be
very cool! At least for the lists already migrated from vger to korg?

