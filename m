Return-Path: <netdev+bounces-128668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CD997ACA7
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 10:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27CC91C21E27
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 08:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D50157485;
	Tue, 17 Sep 2024 08:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtFcF6wS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF39156C40;
	Tue, 17 Sep 2024 08:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726560769; cv=none; b=CUo99YKZFP+TbkA4wE3nxOyyQ+KNR2OkYg+sjpBe7heb7dWXv8+v6JrKUUPTjcmJ7z2KIjhQaJl5GwHi3m6vcD37IPTaqHI0LQsv7d/0cZlX3J2uSvEf+mq9UzKN32s8MmGTCf9tY3SbHRD87lDUBuBoiOs87bL1ucxkHf3mXrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726560769; c=relaxed/simple;
	bh=gA1z5zipx9nSpvAP6lOqzt3yq0fvj5PLSAbcUV1yiug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijv6oE0e0ZHWN1R3RCPwtmPjdrP+O7grRrLhDf8Phj3b1OSe9OKLUv9y3oRSIvB6wrsAKB7sXt/LU792KNceot7ZN7+Oro0N4aW0eJNtCeTLwtdljT+SlXgUIerAotyu07kTKfVxVm9uv57QHWfN86X6kigL2KwgW7o/ZSx0kuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtFcF6wS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E11C4CEC6;
	Tue, 17 Sep 2024 08:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726560769;
	bh=gA1z5zipx9nSpvAP6lOqzt3yq0fvj5PLSAbcUV1yiug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DtFcF6wS+aBZNAZWCirlwe+iWLcz+VO+EEOoIMUMXZV95EiIVpK7Czk1uBwNHaUnn
	 6kJ5xFIK/ceXzb5/TcYMAnXN37OSDC0zk5zda8vkQ1u+MBFJ9SSQwM+k/AtZKSg1zc
	 8csddfRrDQGOUttyo8unBsZEeTJM2eqzxcpGl4O/K1Igr5nA+6OVpuW5ygSpE53C7W
	 dcHQyJB4OfUEID/dXBNMYAxky+FAJYWS6J/Z6VUUkawIIYOdkGzcXDe9gw3RozfHK0
	 FcDKRVmeGnI7J5d7sBxEDPrsgJsgETF4lpxNLC2gSnif/hLMDy7Fu34dH76i/L3kvc
	 AIxV7JGUDnZpQ==
Date: Tue, 17 Sep 2024 09:12:44 +0100
From: Simon Horman <horms@kernel.org>
To: Linu Cherian <lcherian@marvell.com>
Cc: davem@davemloft.net, sgoutham@marvell.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, gakula@marvell.com,
	hkelam@marvell.com, sbhatta@marvell.com, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v2 net-next 1/2] octeontx2-af: Knobs for NPC default rule
 counters
Message-ID: <20240917081244.GK167971@kernel.org>
References: <20240912161450.164402-1-lcherian@marvell.com>
 <20240912161450.164402-2-lcherian@marvell.com>
 <20240914081317.GA8319@kernel.org>
 <20240917043826.GA720400@hyd1403.caveonetworks.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917043826.GA720400@hyd1403.caveonetworks.com>

On Tue, Sep 17, 2024 at 10:08:26AM +0530, Linu Cherian wrote:
> Hi Simon,
> 
> On 2024-09-14 at 13:43:17, Simon Horman (horms@kernel.org) wrote:
> > On Thu, Sep 12, 2024 at 09:44:49PM +0530, Linu Cherian wrote:
> > > Add devlink knobs to enable/disable counters on NPC
> > > default rule entries.
> > > 
> > > Introduce lowlevel variant of rvu_mcam_remove/add_counter_from/to_rule
> > > for better code reuse, which assumes necessary locks are taken at
> > > higher level.
> > > 
> > > Sample command to enable default rule counters:
> > > devlink dev param set <dev> name npc_def_rule_cntr value true cmode runtime
> > > 
> > > Sample command to read the counter:
> > > cat /sys/kernel/debug/cn10k/npc/mcam_rules
> > > 
> > > Signed-off-by: Linu Cherian <lcherian@marvell.com>
> > > ---
> > > Changelog from v1:
> > > Removed wrong mutex_unlock invocations.
> > 
> > Hi Linu,
> > 
> > This patch seems to be doing two things:
> > 
> > 1) Refactoring some functions to have locking and non-locking variants.
> >    By LoC this is appears the bulk of the code changed in this patch.
> >    It also appears to be straightforward.
> > 
> > 2) Adding devlink knobs
> > 
> >    As this is a user-facing change it probably requires a deeper review
> >    than 1)
> > 
> > I would suggest, that for review, it would be very nice to split
> > 1) and 2) into separate patches. Maybe including a note in the patch
> > for 1) that the refactor will be used in the following patch for 2).
> >
> 
> Ack. Will split into two while reposting.

Thanks.

Please note that net-next is currently closed for the v6.12 merge window.
So please wait for it to re-open before reposting. That will occur
after v6.12-rc1 is released, most likely about two weeks from now.

> 
> > As for the code changes themselves, I did look over them,
> > and I didn't see any problems.
> 
> 
> Linu Cherian.
> 

