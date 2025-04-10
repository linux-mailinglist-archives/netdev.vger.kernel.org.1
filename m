Return-Path: <netdev+bounces-181301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 646FAA8456F
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 15:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3933B48AB
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 13:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4E627E1A1;
	Thu, 10 Apr 2025 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhCWxzkk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7155926ACB;
	Thu, 10 Apr 2025 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744293282; cv=none; b=haUyeclDmkSNyElVTA5kIDN9Z/+p8AuyYEvDYywxNSfNbEEOTK9T/7ONaE00vwPnQOB5qG2Vdm3HMyjaf/lgrVNpRpF3oO62FXLcCkD7YnApZ5y/AyN4n7AjjA8zxlCJM0Et0uySRzdo8C4u+4f0ObrCk0ZuM2LIPQ7bWJgHUwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744293282; c=relaxed/simple;
	bh=0BHiwyArAddm4WmiLsfxlRbh5XvgJyYfVdLc0zk00U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sg2cF8m864i9zGp+o+jMhK0CvBN7LOs02/Xw5tV79fJoexfkyfTUpbqv/SGBH/Rr5eNK2iUJDvt7tw/VXvcLBAhJQ3nbZfFFzbB7+BIGSGEWRx6W6rudrIe3O0Kjn78z05kN4tf6ZeGYFWQ43xFdq6lpcBFDff3v2zwKlb6J7xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhCWxzkk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7424C4CEDD;
	Thu, 10 Apr 2025 13:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744293281;
	bh=0BHiwyArAddm4WmiLsfxlRbh5XvgJyYfVdLc0zk00U4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mhCWxzkkNE3wgzAzo0c/mGLjkRg4fpfhNZb6+tU04MYGHVoXR62NBFI9nPdivRv72
	 uB+6Uti6vX1klTxXcgEXJnbruKyvwtXAJNP6h5YR9XEgtN/047lyCyqmGh5KP3uz85
	 lv+FbPJnVg0GvzPfr58MIrwNgM17jOOrkyqOgxUisvLllDzH6xcgZKrq/Fs6BIUmBg
	 RV48LGZHxV77dU1eQTMqT18MMhuCGYG69qq97IeiNisvUtsdAA+qCD+4YCjNM+OS1q
	 y08n3PinwYkKKKk8aJNhKSeIj5inube0I5ILcDPMM2G86a91bEYlXHZdzO/slZ4IN0
	 O01kRlwdTKVCA==
Date: Thu, 10 Apr 2025 16:54:34 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Konstantin Taranov <kotaranov@linux.microsoft.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	Dexuan Cui <decui@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	Long Li <longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH rdma-next 1/3] RDMA/mana_ib: Access remote
 atomic for MRs
Message-ID: <20250410135434.GT199604@unreal>
References: <1743777955-2316-1-git-send-email-kotaranov@linux.microsoft.com>
 <1743777955-2316-2-git-send-email-kotaranov@linux.microsoft.com>
 <20250409122852.GL199604@unreal>
 <PA1PR83MB0662535F57D8F09C1C99DDDAB4B72@PA1PR83MB0662.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA1PR83MB0662535F57D8F09C1C99DDDAB4B72@PA1PR83MB0662.EURPRD83.prod.outlook.com>

On Thu, Apr 10, 2025 at 01:37:00PM +0000, Konstantin Taranov wrote:
> > > @@ -24,6 +24,9 @@ mana_ib_verbs_to_gdma_access_flags(int
> > access_flags)
> > >  	if (access_flags & IB_ACCESS_REMOTE_READ)
> > >  		flags |= GDMA_ACCESS_FLAG_REMOTE_READ;
> > >
> > > +	if (access_flags & IB_ACCESS_REMOTE_ATOMIC)
> > > +		flags |= GDMA_ACCESS_FLAG_REMOTE_ATOMIC;
> > 
> > Can you enable this flag unconditionally without relation to running RW?
> 
> Yes, ATOMIC access does not depend on Remote Read and Remote Write.

The question is "do you have FW which doesn't support
GDMA_ACCESS_FLAG_REMOTE_ATOMIC? and what will happen if such flag used
for such FW?"

> I also do not see any conditions in other drivers.

At least for mlx5, we are checking FW capability if it is supported.
See get_unchangeable_access_flags().

> 
> - Konstantin
> 
> > 
> > Thanks
> > 
> > > +
> > >  	return flags;
> > >  }
> > >
> > > --
> > > 2.43.0
> > >

