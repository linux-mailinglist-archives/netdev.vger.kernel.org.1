Return-Path: <netdev+bounces-21552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC5E763E49
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 20:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9681C2126A
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCB01804D;
	Wed, 26 Jul 2023 18:20:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F4D1AA65
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 18:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2902C433C7;
	Wed, 26 Jul 2023 18:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690395633;
	bh=/XB7GSiYnWWBndJ8o+2CPxc3xzBL7SaoJwKNVSXs+bg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R2GteAwwrl9iYxOfk9upIwOHyDQ1Ql91aiJvZKe2udtztUFPbnFhIGLztawwXwkgC
	 U+T65Mc6dHcSNCN8Vlf1GEnGDFbZuGBFE4SEvTlZfh6vd7cUKomQHx8/iprJ23UInM
	 q4q8jPywTAItrRwQMVKHVv5zE01re3gvmdjOktZoAFKkpyULAbVO+98sNuNSi9ShLN
	 JFPRzOPe2Q6T8T1IGxMFtDCm7GbuKaAy4NcHP8Wi5BDNRYQMn43CHQpTnN7IKL/GkD
	 wAi0nkztJzqvP14xYfqM2cbz56ROsAVYIXOZDB0zS2booNDYkHOuMBnmSpe2LLJYKu
	 kO2Ut/6bTz+lA==
Date: Wed, 26 Jul 2023 11:20:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Joe Perches <joe@perches.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, geert@linux-m68k.org,
 gregkh@linuxfoundation.org, netdev@vger.kernel.org,
 workflows@vger.kernel.org, mario.limonciello@amd.com
Subject: Re: [PATCH v2] scripts: get_maintainer: steer people away from
 using file paths
Message-ID: <20230726112031.61bd0c62@kernel.org>
In-Reply-To: <CAHk-=wjEj2fGiaQXrYUZu65EPdgbGEAEMzch8LTtiUp6UveRCw@mail.gmail.com>
References: <20230726151515.1650519-1-kuba@kernel.org>
	<11ec5b3819ff17c7013348b766eab571eee5ca96.camel@perches.com>
	<20230726092312.799503d6@kernel.org>
	<CAHk-=wjEj2fGiaQXrYUZu65EPdgbGEAEMzch8LTtiUp6UveRCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jul 2023 09:45:25 -0700 Linus Torvalds wrote:
> On Wed, 26 Jul 2023 at 09:23, Jakub Kicinski <kuba@kernel.org> wrote:
> > > Nack on that bit.
> > > My recollection is it's Linus' preferred mechanism.  
> >
> > Let Linus speak for himself, hopefully he's okay with throwing
> > in the -f.  
> 
> It's not the '-f' that would be the problem - that's how the script
> used to work long ago, and I still occasionally end up adding the -f
> by habit.
> 
> So removing the auto-guessing of file paths wouldn't be a problem.
> 
> But the annoying warning is wrong.
> 
> I use get_maintainers all the time, and I *only* use it for file
> paths. If I know the commit, I get the list of people from the commit
> itself, so why should I *ever* use that script if I have a patch?

You are special, you presumably use it to find who to report
regressions to, and who to pull into conversations.

This tool is primarily used by _developers_ to find _maintainers_.
I mean *thousands* of developers use it every release to send their
patches.

The tool needs to see the commit message to fish out Fixes tags.

> So the whole "use of get_maintainers is only for patches, and we
> should warn about file paths" is insane.

Hrmpf, hrmpf.

> No. If I get that patch, I will remove the warning. The *only* reason
> for me to ever use that script is for the file path lookup.
> 
>              Linus


