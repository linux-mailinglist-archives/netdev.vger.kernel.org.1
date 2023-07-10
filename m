Return-Path: <netdev+bounces-16572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEF974DDAF
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 21:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A2B1C20B49
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 19:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7543D14284;
	Mon, 10 Jul 2023 19:01:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26B02581
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 19:01:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B4EC433C7;
	Mon, 10 Jul 2023 19:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689015662;
	bh=zMTFW7vzIIkgdRhriz4DqYVdMQ6BgkFTSAGBiZtHR4I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JvQ49PHhlv0da763jvQFysbANPXX6yNEUGIbNYJPB1qUFfxSdfn8CDNRxGlAnSdm+
	 IsCT7K4UzkUXydVuMmBfHuvNoHZfB028rTog5kO9XiPOL7R7cA3PsJvLHyK89mVC4d
	 RES4BrK9dD38YS33/plLu1WEI0xEnoDEKuqvkr20xpSuJ+oO9ud2sEh40quiAZJ/Ey
	 LzHi7hTvF3iqISWN+4gIwqXqlzHgw9NycmHsv9BCFH+2vgLhy7Vsk17aSNl3VGL7AA
	 Rj+NMAjkBqYOJjdL/6fXsdM2TNF+0bMtLR/jJkHRH55GYscHFisa/tK3PNzK54F4MT
	 2FiuWOeVmPG0Q==
Date: Mon, 10 Jul 2023 12:01:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Gregorio Maglione <Gregorio.Maglione@city.ac.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>,
 <netdev@vger.kernel.org>
Subject: Re: DCCP Deprecation
Message-ID: <20230710120101.4b6d78af@kernel.org>
In-Reply-To: <20230710182253.81446-1-kuniyu@amazon.com>
References: <CWLP265MB6449FC7D80FB6DDEE9D76DA9C930A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
	<20230710182253.81446-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jul 2023 11:22:53 -0700 Kuniyuki Iwashima wrote:
> From: "Maglione, Gregorio" <Gregorio.Maglione@city.ac.uk>
> Date: Mon, 10 Jul 2023 12:06:11 +0000
> > Hi Kuniyuki,
> > 
> > I saw the deprecation notice on the DCCP. We are working with a multipath
> > extension of the protocol, and this would likely impact us in the
> > standardisation effort. Do you know whom I must contact to know how I can
> > volunteer to maintain the protocol, and  to get more information about
> > the maintenance process?  
> 
> I think it would be better to review others' patches or post patches before
> stepping up as a maintainer.

Yes, I think we should document the expectations more clearly. I asked
on workflows@ if others already have docs.

https://lore.kernel.org/workflows/20230710115239.3f9e2c24@kernel.org/T/#u

For DCCP specifically I think we'd like to see some effort around
improving syzbot testing and addressing the bugs?

> However, this repo seems to have a license issue that cannot be upstreamed
> as is.
> https://github.com/telekom/mp-dccp

Right, in theory maintenance of the code already upstream is orthogonal
to protocol extensions. But if there is no user of the pure upstream
code then it seems hard to justify the effort of keeping it.

