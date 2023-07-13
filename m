Return-Path: <netdev+bounces-17677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BCA752A9F
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 20:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129991C21414
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 18:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E2D1ED53;
	Thu, 13 Jul 2023 18:58:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15A81ED3A
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 18:58:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5A9C433C9;
	Thu, 13 Jul 2023 18:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689274718;
	bh=xvdOsy9jelIped55WfaZShRn7G15Xhu03qrC3/vIrIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ftif1alvjsdPjOWQxa5NQKlghAlSruaRScbTYaIPLWsQXZuHUtphjOCGACTDdjKfr
	 3Kuib8McUEtrNDpbxH7WJoP3mpQCy5I+hfQ/TdpWrfG5MPSfMTPpESXSlkxDjL9J3A
	 +JEiZIhNQ7vpV47cHw1EQWSC23St3zgSvxBvigNE9WMDtav1A/sWizjb+kYQ0Ixkwe
	 6nQscZ21Bc8Y76Wd1RK5Xzf79vHdzweQu1XaRmn1/oXTwRSD15WlG1TFGUnjHzz3Oz
	 dUArtl3TPEGw54qYFnhgXuHYwKFCDF5mCG6Eo/9gEHv0uw63UFzzzXWm7Ch4qYP9LD
	 r7wOI+NP9ayCg==
Date: Thu, 13 Jul 2023 21:58:33 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Eric Dumazet <edumazet@google.com>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next 09/12] net/mlx5: Compare with old_dest param to
 modify rule destination
Message-ID: <20230713185833.GI41919@unreal>
References: <cover.1689064922.git.leonro@nvidia.com>
 <5fd15672173653d6904333ef197b605b0644e205.1689064922.git.leonro@nvidia.com>
 <20230712173259.4756fe08@kernel.org>
 <20230713063345.GG41919@unreal>
 <20230713100401.5fe0fa77@kernel.org>
 <20230713174317.GH41919@unreal>
 <20230713110556.682d21ba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713110556.682d21ba@kernel.org>

On Thu, Jul 13, 2023 at 11:05:56AM -0700, Jakub Kicinski wrote:
> On Thu, 13 Jul 2023 20:43:17 +0300 Leon Romanovsky wrote:
> > > Reads like "can't be triggered with current code", in which case 
> > > the right thing to do is to add "can't be triggered with current
> > > code" to the commit message, rather than the Fixes tag.  
> > 
> > The code is wrong, so comes Fixes line, but I can remove it.
> 
> Yes, perhaps after death we will inhabit a world with clear,
> non-conflicting rules, where law can be followed to the letter
> and "truth" and "good" are clearly and objectively defined.
> 
> Until the sweat release, tho, let's apply common sense, and 
> not add Fixes tags to patches which can't possibly be of interest 
> to backporters.
> 
> Please and thank you...

Sure

> 
> > > I had a look thru the series yesterday, and it looks good to me
> > > (tho I'm no ipsec expert). Thanks for putting in the work!
> > > 
> > > Could you add some info about how the code in the series can be
> > > exercised / example configurations? And please CC Simon, it'd be
> > > great to get him / someone at Corigine to review.
> > > 
> > > And obviously Steffen, why did you not CC Steffen?! :o  
> > 
> > It works exactly like "regular" IPsec, nothing special, except
> > now users can switch to switchdev before adding IPsec rules.
> > 
> >  devlink dev eswitch set pci/0000:06:00.0 mode switchdev
> > 
> > Same configurations as here:
> > https://lore.kernel.org/netdev/cover.1670005543.git.leonro@nvidia.com/
> > Packet offload mode:
> >   ip xfrm state offload packet dev <if-name> dir <in|out>
> >   ip xfrm policy .... offload packet dev <if-name>
> > Crypto offload mode:
> >   ip xfrm state offload crypto dev <if-name> dir <in|out>
> > or (backward compatibility)
> >   ip xfrm state offload dev <if-name> dir <in|out>
> 
> I see, so all policy based IPsec?

Yes, it is.

> Does the order of processing in the device match the kernel?

Yes and this it why this fix was needed to make sure that we update
destinations properly.

> TC packet rewrites or IPsec comes first?

In theory, we support any order, but in real life I don't think that TC
before IPsec is really valuable.

> 
> > I didn't add Steffen as it is more flow steering magic series
> > and not IPsec :).
> > 
> > I'll resubmit on Sunday.
> 
> Thanks!

