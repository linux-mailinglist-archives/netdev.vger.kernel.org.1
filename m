Return-Path: <netdev+bounces-21650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6FD764183
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C874281F9F
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD80CA63;
	Wed, 26 Jul 2023 21:57:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC051BF07
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 21:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB31C433C7;
	Wed, 26 Jul 2023 21:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690408642;
	bh=tAlkFh8lTCa8bL32N8xgDfGEtzco/lV9MYjctWZA4+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VBRKPcqX/JaPGrEj1BXBVAJFPPa2Ymb/SPsNhcVKtUwQm458GgI/X0Gv4YRtUD9bv
	 +fw87Qb2DqQ5zrZbWkWO59+EOYckfsRKTMpXtlHAXoSdMgeKLPR4vsJLdKhhnkG0XS
	 VqFKM13VhqxqjZdKH28wHpVre9C68XK3UkEQlBXrqfftMWvUgXsX4S/E2Ck972Zfwa
	 XA3IE3R1Izl93IguTTz559kn8jjfZlMtpIpxjwo41eINePyA3/q5BbbF17YX5UvGdd
	 amxBqdVOSjvYEGNRKEfdhC4Ovo7sE08IUQsJlHYXzR3E0Vx8J5CCJdEKMCstUwZA6A
	 Sbtar2vcyC9ew==
Date: Wed, 26 Jul 2023 14:57:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Joe Perches <joe@perches.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, geert@linux-m68k.org,
 gregkh@linuxfoundation.org, netdev@vger.kernel.org,
 workflows@vger.kernel.org, mario.limonciello@amd.com
Subject: Re: [PATCH v2] scripts: get_maintainer: steer people away from
 using file paths
Message-ID: <20230726145721.52a20cb7@kernel.org>
In-Reply-To: <CAHk-=whZHcergYrraQGgazmOGMbuPsDfRMBXjFLo1aEQPqH2xQ@mail.gmail.com>
References: <20230726151515.1650519-1-kuba@kernel.org>
	<11ec5b3819ff17c7013348b766eab571eee5ca96.camel@perches.com>
	<20230726092312.799503d6@kernel.org>
	<CAHk-=wjEj2fGiaQXrYUZu65EPdgbGEAEMzch8LTtiUp6UveRCw@mail.gmail.com>
	<20230726112031.61bd0c62@kernel.org>
	<CAHk-=wi9MyyWmP_HAddLrmGfdANkut6_2f9hzv9HcyTBvg3+kA@mail.gmail.com>
	<20230726114817.1bd52d48@kernel.org>
	<CAHk-=wiuR7_A=PbN8jhmqGPJQHypUHR+W4-UuSVhOVWvYXs1Tg@mail.gmail.com>
	<CAHk-=wh4pbrNZGqfV9u1urZr3Xjci=UV-MP+KneB6a5yo7-VOQ@mail.gmail.com>
	<CAHk-=whCE9cWmTXu54WFQ7x-aH8n=dhCux2h49=pYN=14ybkxg@mail.gmail.com>
	<20230726130318.099f96fc@kernel.org>
	<CAHk-=wjfC4tFnOC0Lk_GcU4buf+X-Jv965pWg+kMRkDb6hX6mw@mail.gmail.com>
	<20230726133648.54277d76@kernel.org>
	<CAHk-=whZHcergYrraQGgazmOGMbuPsDfRMBXjFLo1aEQPqH2xQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jul 2023 14:07:28 -0700 Linus Torvalds wrote:
> On Wed, 26 Jul 2023 at 13:36, Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > Just so I fully understand what you're saying - what do you expect me
> > to do? Send the developer a notifications saying "please repost" with
> > this CC list? How is that preferable to making them do it right the
> > first time?!  
> 
> Not at all.
> 
> The whole point is that you already end up relying on scripting to
> notice that some people should be cc'd, so just add them
> automatically.
> 
> Why would you
> 
>  (a) waste your own time asking the original developer to re-do his submission
> 
>  (b) ask the original developer to do something that clearly long-time
> developers don't do
> 
>  (c) waste *everybody's* time re-submitting a change that was detected
> automatically and could just have been done automatically in the first
> place?
> 
> just make patchwork add the cc's automatically to the patch - and send
> out emails to the people it added.
> 
> Patchwork already sends out emails for other things. Guess how I know?
> Because I get the patchwork-bot emails all the time for things I have
> been cc'd on.  Including, very much, the netdevbpf ones.
> 
> And people who don't want to be notified can already register with
> patchwork to not be notified. It's right there in that
> 
>    Deet-doot-dot, I am a bot.
>    https://korg.docs.kernel.org/patchwork/pwbot.html
> 
> footer.
> 
> So I would literally suggest you just stop asking people to do things
> that automation CAN DO BETTER.
> 
> The patchwork notification could be just a small note (the same way
> the pull request notes are) that point to the submission, and say
> "your name has been added to the Cc for this patch because it claims
> to fix something you authored or acked".

Lots of those will be false positives, and also I do not want 
to sign up to maintain a bot which actively bothers people.
And have every other subsystem replicate something of that nature.

Sidebar, but IMO we should work on lore to create a way to *subscribe*
to patches based on paths without running any local agents. But if I
can't explain how get_maintainers is misused I'm sure I'll have a lot
of luck explaining that one :D

> See what I'm saying? Why are you wasting your time on this? Why are
> you making new developers do pointless stuff that is better done by a
> script, since you're just asking the developer to run a script in the
> first place?

For the last time, most people already run get_maintainer, they just 
choose the wrong "mode" of running it for the use case.
I am not trying to make anyone do anything they aren't already doing.

> You are just wasting literally EVERYBODY'S time with your workflow
> rules. For no actual advantage, since the whole - and only - point of
> this all was that it was scriptable, and is in fact already being
> scripted, which is how you even notice the issue in the first place.

And it has nothing to do with *my* workflow. Unless you're arguing 
that asking for authors of patches which Fixes points to is part of
"my" workflow and nobody else's.

> You seem to be just overly attached to having people waste their time
> on running a script that you run automatically *anyway*, and make that
> some "required thing for inexperienced developers".

I said "for the last time" so I won't repeat...

> And it can't even be the right thing to do, when experienced
> developers don't do it.

I explained to you already that Florian's posting is a PR.

