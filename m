Return-Path: <netdev+bounces-73787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9472F85E68E
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 19:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50675282795
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 18:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95D385276;
	Wed, 21 Feb 2024 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgVy4ts7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A598082D97
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708541106; cv=none; b=m5XkMBlwmHQdffwfpdrl30H2CajaCyfwfkG9eIParXGM9Cc25o8x6/74tI3RJT8+BkD37rB9l/Z8Jq9923gJQ0DAl7RtaZmdcQc0QM/R0gem/Nzb2WZ9CCxLb+Y+pyXIooK7U44CJrBcOH/JWopKlaPhsqV1dL0npQKiD/L6wYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708541106; c=relaxed/simple;
	bh=fnyhnQ6/5aUd3bsKNeZLVmArtImRok1AlLWxA7S3IT4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8Hmb0pExeprtCK9/pDbgRAwfZr4n401ahuib1IAYfp+5FPFdThR6d19goTy29FiEJVMskpFwLprLGp7x08NalBBD27zmqtFQEp8RLgmu4sbcH01NViazYTa7K0A5Ec4Pe++DqWevvAXD6mOm8+6BITo27IrjYGrhOhwRLbURrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgVy4ts7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179FAC433F1;
	Wed, 21 Feb 2024 18:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708541106;
	bh=fnyhnQ6/5aUd3bsKNeZLVmArtImRok1AlLWxA7S3IT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qgVy4ts70GAFTpSHZq3RCVs8Eo6AENNorDlL9Werumc9b1qEhyKShEcBu4csoOivk
	 s7pTF+A/Zmz9iRc8jNSRL7tZ+xC+AGvKHm6gGwNMETrT9nxCt0uUGPdslEN6A2HnEz
	 VP2cMH2WEeHzzshLDuaNqGaFBLVnn6BEkxUWGIWlQJtC4C1QDSP3iNHZlPpnmtakGJ
	 +RcsKc+2Y4+jsD13xf3COp50T3z0xhsNSsIyIfbwJJljlWT3jBnfN/Di6xoxK/5MKK
	 Xg8S5bu9lx08Xk5S20yJ1c9u1M8LF3lh7fDyPBrIkXwQY/GAFDoKloLfxSfBupS8ia
	 eADRUkLWRJM8w==
Date: Wed, 21 Feb 2024 10:45:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com,
 swarupkotikalapudi@gmail.com, donald.hunter@gmail.com, sdf@google.com,
 lorenzo@kernel.org, alessandromarcolini99@gmail.com
Subject: Re: [patch net-next 06/13] tools: ynl: introduce attribute-replace
 for sub-message
Message-ID: <20240221104505.23938b01@kernel.org>
In-Reply-To: <ZdXxDZIAM5iLlO55@nanopsycho>
References: <20240219172525.71406-1-jiri@resnulli.us>
	<20240219172525.71406-7-jiri@resnulli.us>
	<20240219145204.48298295@kernel.org>
	<ZdRVS6mHLBQVwSMN@nanopsycho>
	<20240220181004.639af931@kernel.org>
	<ZdXxDZIAM5iLlO55@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 13:48:13 +0100 Jiri Pirko wrote:
> >But TC and ip-link are raw netlink, meaning genetlink-legacy remains
> >fairly straightforward. BTW since we currently have full parity in C
> >code gen adding this series will break build for tools/net/ynl.
> >
> >Plus ip-link is a really high value target. I had been pondering how 
> >to solve it myself. There's probably a hundred different implementations
> >out there of container management systems which spawn veths using odd
> >hacks because "netlink is scary". Once I find the time to finish
> >rtnetlink codegen we can replace all  the unholy libbpf netlink hacks
> >with ynl, too.
> >
> >So at this stage I'd really like to focus YNL on language coverage
> >(adding more codegens), packaging and usability polish, not extending
> >the spec definitions to cover not-so-often used corner cases.
> >Especially those which will barely benefit because they are in
> >themselves built to be an abstraction.  
> 
> That leaves devlink.yaml incomplete, which I'm not happy about. It is a
> legacy, it should be covered by genetlink-legacy I believe.
> 
> To undestand you correctly, should I wait until codegen for raw netlink
> is done and then to rebase-repost this? Or do you say this will never be
> acceptable?

It'd definitely not acceptable before the rtnetlink C codegen is
complete, and at least two other code gens for genetlink-legacy.
At that point we can reconsider complicating the schema further.

