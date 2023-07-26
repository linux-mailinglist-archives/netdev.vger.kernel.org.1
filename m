Return-Path: <netdev+bounces-21574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DED763EDB
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 20:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D597281EC0
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550D54CE71;
	Wed, 26 Jul 2023 18:48:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9BE7E1
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 18:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4953EC433C7;
	Wed, 26 Jul 2023 18:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690397298;
	bh=kEN47qLcvSl+2RGDErUZd6Gs7ZP2H8X9MFxpFdAaNNY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k++zZlJMi3Q64vFadKV61Lz65nP5CmZ8AgIaQYbV+a+nhf3m/ok0vzkBshU2wKF1Z
	 /g9qZAj8bQrlAOgj39Ln2+FDDk5uHyZXfXagkjqE9JTXxDs8LKDVWs/+4kEFKMOEB8
	 KMlcBss0B85Q8X+AAVlBVvVpavgWRbEIiygrB/dd7QTGemqeIVfHC5w6WmaR0Wxlsr
	 UX9P4C+pCrg1+caWhRgh+GOloJHQikoRAFNS2J46dAWzY66fZ1HowTIB1YnFvnfZcN
	 +C+6YHPoi3EkDclccm5f9XzeZfO+aFwTBFCwz7VtZE6AwgZPKO/YQwSFbyp6TsXE9P
	 39U3HPqOe1cWg==
Date: Wed, 26 Jul 2023 11:48:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Joe Perches <joe@perches.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, geert@linux-m68k.org,
 gregkh@linuxfoundation.org, netdev@vger.kernel.org,
 workflows@vger.kernel.org, mario.limonciello@amd.com
Subject: Re: [PATCH v2] scripts: get_maintainer: steer people away from
 using file paths
Message-ID: <20230726114817.1bd52d48@kernel.org>
In-Reply-To: <CAHk-=wi9MyyWmP_HAddLrmGfdANkut6_2f9hzv9HcyTBvg3+kA@mail.gmail.com>
References: <20230726151515.1650519-1-kuba@kernel.org>
	<11ec5b3819ff17c7013348b766eab571eee5ca96.camel@perches.com>
	<20230726092312.799503d6@kernel.org>
	<CAHk-=wjEj2fGiaQXrYUZu65EPdgbGEAEMzch8LTtiUp6UveRCw@mail.gmail.com>
	<20230726112031.61bd0c62@kernel.org>
	<CAHk-=wi9MyyWmP_HAddLrmGfdANkut6_2f9hzv9HcyTBvg3+kA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jul 2023 11:29:44 -0700 Linus Torvalds wrote:
> On Wed, 26 Jul 2023 at 11:20, Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > You are special,  
> 
> So my mother tells me.
> 
> > you presumably use it to find who to report
> > regressions to, and who to pull into conversations.  
> 
> Yes. So what happens is that I get cc'd on bug reports for various
> issues, and particularly for oops reports I basically have a function
> name to grep for (maybe a pathname if it went through the full
> decoding).
> 
> I'm NOT interested in having to either remember all people off-hand,
> or going through the MAINTAINERS file by hand.
> 
> > This tool is primarily used by _developers_ to find _maintainers_.  
> 
> Well, maybe.
> 
> But even if that is true, I don't see why you hate the pathname thing
> even for that case. I bet developers use it for that exact same
> reason, ie they are modifying a file, and they go "I want to know who
> the maintainer for this file is".

I don't hate the file path, I say as much in the commit msg:

  The file option should really not be used by inexperienced developers,
  unless they are just trying to find a maintainer to manually contact.

I'd love to make it easier to use for people who know what they're
doing. Maybe check for a magic file in the tree, listed in .gitignore?
Feels dirty. Create a separate script "blame_maintainer.sh" which just
calls get_maintainer but tosses in --silence-file-warning -f ?

> I do not understand why you think a patch is somehow magically more
> important or relevant than a filename.

Judging by traffic on the ML vast majority of the submissions are
patches, not random reach outs and conversations. That's why patches
are more important.

We get at least one fix a week where author adds a Fixes tag
but somehow magically didn't CC the author of that commit.
When we ask they usually reply with "but I run get_maintainer -f,
isn't that what I'm supposed to do?".

Then there's people who only run -f on the path where most of 
the changes are, not all the paths.

