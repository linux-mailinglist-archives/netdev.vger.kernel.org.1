Return-Path: <netdev+bounces-115371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC2B94608B
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 17:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B9E1C20B3D
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 15:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C52175D26;
	Fri,  2 Aug 2024 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0jfeYrk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE866175D20
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722612697; cv=none; b=Gy4FEhBWu2+VTmV5z9qIOLGnrjdWYvvQ2Rpq7k7qkZ+Bg0JlraIZukbJAS2sHicdpRBv6boVGpgsjg1QPh2mapgqvLIzfiAHpnBfWG8hrDcsXgMlurXanDVCnReOG0+EGVO1P5TFoG9mC34woE4y2pGpwbcoEoInOdSnxp7vdmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722612697; c=relaxed/simple;
	bh=Q2EL8Vubkn7cUY9f5/AfEXR2r5J9stHFLifTmyWqEaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCMXNPM1nva0o4gaqxf5MqWaIux2YpclRedg/lGka/WYMvWBCIZsx5X6tWaAswiNSAZaWKzRn0qpvmNVHjX6hkjZc5Dck+A916r9UeRtDg3E6wnALfN7qRe62I9HY3CIWgkthhCiA84BulxWw1Cx0a1Ld3SY1CSEeQjvB9nlQME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0jfeYrk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFBCAC32782;
	Fri,  2 Aug 2024 15:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722612697;
	bh=Q2EL8Vubkn7cUY9f5/AfEXR2r5J9stHFLifTmyWqEaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F0jfeYrkJJZWA4wsL1+FvPLOmkHj1dKv/zzneQD4VBXv7EFCjTh8ILrDtDzpN6gzz
	 TZdXeStwdTyK1+utYajvqjDzNVS4L/swRHwVmzgyAReu1L1LSaX9GnbTAemknVE/Pp
	 9wUha623LhH05EaxfxZThwWlYIulLx/WohF/heJbZ/SlLoTisLC1R6kGVOjSbiv3R6
	 ee3s63ATsZiP7MbFpPtYpETQLGBu25w/C09Fnty5urZsAQcbZvaVWYQpUH2ro/E798
	 w9H0hIKvdviVNJfLVaWSNVIcZsNUTN7LJf1KrDF30SoQr/PUpp30txC+sd1iA4ST53
	 WQTGhWM5vvrcg==
Date: Fri, 2 Aug 2024 16:31:33 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, kernel test robot <lkp@intel.com>,
	alexanderduyck@fb.com
Subject: Re: [PATCH net] eth: fbnic: select devlink
Message-ID: <20240802153133.GF2504122@kernel.org>
References: <20240802015924.624368-1-kuba@kernel.org>
 <20240802145038.GE2504122@kernel.org>
 <20240802080148.53366633@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802080148.53366633@kernel.org>

On Fri, Aug 02, 2024 at 08:01:48AM -0700, Jakub Kicinski wrote:
> On Fri, 2 Aug 2024 15:50:38 +0100 Simon Horman wrote:
> > But while exercising this I noticed that PAGE_POOL is also needed,
> > which I locally resolved by adding:
> 
> Oh, good catch. I'm a bit surprised how slow kbuild bot is :(
>  
> > 	select PAGE_POOL
> > 
> > I can provide a follow-up patch after this one is merged.
> > Or perhaps you can address this in a v2?
> > I have no preference either way.
> 
> Please send your version with both selects, I'll mark mine as superseded

Sure. I'll set myself as the author, to save negotiating about that,
and as it's only two lines.  Do feel free to update as you see fit.

