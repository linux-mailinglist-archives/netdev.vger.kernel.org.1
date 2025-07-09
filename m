Return-Path: <netdev+bounces-205319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC026AFE2DC
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 453457B7A16
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 08:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3765327BF80;
	Wed,  9 Jul 2025 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvAS8mJX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137872737FA
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 08:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050327; cv=none; b=it5XIX3fl6+WnRwrrJiaHYcHOfErAGaKNqlkEhLfVIqVrzJRxjdsDZCC63ZD5Nbeblu2U+QqAhKRmaKC6k7G9RDuZLsNk1r3f0qyNpQREtj7PKEGs1bHPEZRsbRcA+JkvVXCMiHezLaEh8YMUbmKFWAkFK1cZ1r5oZgDZstEOOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050327; c=relaxed/simple;
	bh=Xp92XxaKyEQTDhBN9CrZSL2sxQTLz4PaLOlT5b9BC1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zmk23SXPsmjeH4VzgokLVQclcfUdD3tRFSG3Trdc9M2uCx/NOvZdsqGQ1NjM7PmpRXrqhJWzfqh5ig3079GRplHY7Aw3y2E1XWQBLcm5ToJkG68+VMrx+W1VOZq8ldH3FK0Pj7YYAFXqcRb69X5d16cVbuYflaXjfaAu6JjcxOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvAS8mJX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92235C4CEEF;
	Wed,  9 Jul 2025 08:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752050326;
	bh=Xp92XxaKyEQTDhBN9CrZSL2sxQTLz4PaLOlT5b9BC1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BvAS8mJXD0CrDWpimb10swaSZ4bi+TB3OUwU4K88cAvAQcPW2VtcvdqIw+2n3DT1w
	 0rJzZMvKt6b0v8y9sws9PY6TESBSFFcs1tD6KSQD/sCX3WIKgrXl8H8mF6sMx5FQzu
	 1Lyfzb9XyTv/lGbd6UD7iqQIk1Q8mKSQTWD0iN75PfHF71UquirJwGvy4zC+W9HT7u
	 6r2zchFHa9IY7SPTi12+5DOONe19frA3nv8HNljA8AiLRcol46HWlaTb7MOExBuBRz
	 2D7KoafbMk5YCYstgCFaEqoZl7oVNsZ3G5FQ0VNXtz4SVtteMoRKvDnFk/8Upz1rgx
	 /R6N38vLMpyqw==
Date: Wed, 9 Jul 2025 09:38:42 +0100
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V5 00/13] devlink, mlx5: Add new parameters for
 link management and SRIOV/eSwitch configurations
Message-ID: <20250709083842.GA581653@horms.kernel.org>
References: <20250706020333.658492-1-saeed@kernel.org>
 <20250707162546.GN89747@horms.kernel.org>
 <aG3cPvni2Lhwye7R@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG3cPvni2Lhwye7R@x130>

On Tue, Jul 08, 2025 at 08:04:30PM -0700, Saeed Mahameed wrote:
> On 07 Jul 17:25, Simon Horman wrote:
> > On Sat, Jul 05, 2025 at 07:03:20PM -0700, Saeed Mahameed wrote:
> > > From: Saeed Mahameed <saeedm@nvidia.com>
> > > 
> > > This patch series introduces several devlink parameters improving device
> > > configuration capabilities, link management, and SRIOV/eSwitch, by adding
> > > NV config boot time parameters.
> > 
> > ...
> > 
> > Thanks Saeed.
> > 
> > Overall this patchset looks good to me.
> > And, importantly, I believe review of earlier versions has been addressed.
> > 
> > But unfortunately it does not apply cleanly against current net-next.
> > Could you rebase?
> 
> Done, posting v6 now, Thanks Simon for the review.

Likewise, thanks.

