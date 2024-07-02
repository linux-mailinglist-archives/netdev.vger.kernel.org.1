Return-Path: <netdev+bounces-108317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9227791ED25
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 04:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B08282362
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 02:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809DCD530;
	Tue,  2 Jul 2024 02:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3Xy+9fI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4878830
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 02:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719888860; cv=none; b=aZax+/wQMhai4G58zt06yQXFWrPXIaSAwaeN6IjvPmuoqZSiWAYHzX/fxSx0xLieXX9Ile7y/swKKgzDpfza9CLensf9MVjGHHnKKiknP+xKcig/CwI1jTJVS6ZuPX75RdIvFmi0gV7S0IzCrTUEHC7uhiGdwEejX3q9W7XuAM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719888860; c=relaxed/simple;
	bh=+fJPPf5ioQv2m64JCVAs4aS23yBQ1ElY5vsQMmHtDbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+X1RpsU2jw9sbY3v0XqJ9S44f+EcBBIPzDB7CZ8QA7yiPvwl/DLIc701GCiS2CDLsL2Q2wIEr2qig5+tzn+jTBFEcAQ2owOX/OvqkYz+SQ2x4D3G8+zTvqLue9N8RRj1OEWiJVaVSqrYb/pCQJ+KZ6+jDUZGF+IqxYdcFZVoQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3Xy+9fI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F343C116B1;
	Tue,  2 Jul 2024 02:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719888859;
	bh=+fJPPf5ioQv2m64JCVAs4aS23yBQ1ElY5vsQMmHtDbw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c3Xy+9fIRQVe6avOYkhHxFxidQXtEBdYrbyGuQFUAHHxdGMW5ZhKgqiGYEdbPoEl1
	 xwtv24dpDZ3bFFCZZAO2MtOn3lrW0hEu8azH9Q+pqL7yibXa/pcr2Nmox4WuSjV2uw
	 VYKR4oaa4qGkMI7esbKl1vXbXS8vLRf6EMo5EKCCXIavuMCSESYU7yh55nXWtAuhrd
	 nPAiaqPdUlzkfcmbQs3x0C0+e3o/UcPJBTcoJGjylJKQL9oSNsAIvzrMehdiHZg9sZ
	 e58hH8OYUOGrEqDYPcjgfhBIedLDtCGDR7UL6Y0+2x10f1UwKfozbN766XpOmPa9dm
	 gx7F8HEEYGUjQ==
Date: Mon, 1 Jul 2024 19:54:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>
Subject: Re: [PATCH net-next 1/5] netlink: spec: add shaper YAML spec
Message-ID: <20240701195418.5b465d9c@kernel.org>
In-Reply-To: <4df85437379ae1d7f449fe2c362af8145b1512a5.camel@redhat.com>
References: <cover.1719518113.git.pabeni@redhat.com>
	<75cb77aa91040829e55c5cae73e79349f3988e06.1719518113.git.pabeni@redhat.com>
	<20240628191230.138c66d7@kernel.org>
	<4df85437379ae1d7f449fe2c362af8145b1512a5.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 01 Jul 2024 12:14:32 +0200 Paolo Abeni wrote:
> > > +      -
> > > +        name: shapers
> > > +        type: nest
> > > +        multi-attr: true
> > > +        nested-attributes: ns-info  
> > 
> > How do shapers differ from shaping attrs in this scope? :S  
> 
> the set() operation must configure multiple shapers with a single
> command - to allow the 'atomic configuration changes' need for Andrew's
> use-case.
> 
> Out-of-sheer ignorance on my side, the above was the most straight-
> forward way to provide set() with an array of shapers.
> 
> Do you mean there are better way to achieve the goal, or "just" that
> the documentation here is missing and _necessary_?

I see, I had a look at patch 2 now.
But that's really "Andrew's use-case" it doesn't cover deletion, right?
Sorry that I don't have a perfect suggestion either but it seems like
a half-measure. It's a partial support for transactions. If we want
transactions we should group ops like nftables. Have normal ops (add,
delete, modify) and control ops (start, commit) which clone the entire
tree, then ops change it, and commit presents new tree to the device.

Alternative would be to, instead of supporting transactions have some
form of a "complex instruction set". Most transformations will take a
set of inputs (+weights / prios), shaping params, and where to attach.

> > > +operations:
> > > +  list:
> > > +    -
> > > +      name: get
> > > +      doc: |
> > > +        Get / Dump information about a/all the shaper for a given device
> > > +      attribute-set: net_shaper
> > > +      flags: [ admin-perm ]  
> > 
> > Any reason why get is admin-perm ?  
> 
> Mostly a "better safe then sorry" approach and cargo-cult form other
> recent yaml changes the hard reasons. Fine to drop it, if there is
> agreement.

I thought we default to GET being non-privileged.
I think that's better, monitoring shouldn't require admin perm
and presumably those shapers may grow stats at some stage.
But no strong feelings.

