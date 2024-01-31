Return-Path: <netdev+bounces-67610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E685844426
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 17:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61CD1F2A9DD
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 16:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D1D12BE8F;
	Wed, 31 Jan 2024 16:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeRCMUwo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA06129A8D
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718370; cv=none; b=RVNauZ7wJSCQgQrEQX7DcJod3U2YYUQdnrMggw5BuRl1/h0EFBlBhFUPNS2JA+3Vz5yMI2+idKUw6EqbNX+OD6l6fFm3ZICyPhJK7mCpqxnTm1paDW9wsC8pf/J7JpJaeI7sMQR60MQNErI1plJvL7DnbwHsJ98Pr0cwr/9UQGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718370; c=relaxed/simple;
	bh=zoRtSDiRAOvg3fLkrgpTpzQxQNA78gT59a2EWepqBX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTvsFXYDQ/bS0LvSPHqwOr4FTq0vCGSxcKMm149biGRmm6Rpnr7XlomlCu05wbhsvTQLxY0+V4rpKp9hdZRQBm3D/lAuy4USq6+FU1heLR9VF5S04snOU3o9YjQkvaZvHpGTH2kl2DrRIeFl897h20LeqBlSs0ME9nI/OgENQRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeRCMUwo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8315C433F1;
	Wed, 31 Jan 2024 16:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706718369;
	bh=zoRtSDiRAOvg3fLkrgpTpzQxQNA78gT59a2EWepqBX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CeRCMUwoMjyw3c2+3D/tDb2VXgmCQgPqusRARJsNsmCBKkprmFp726kMBMOT+fild
	 VA90qrCkLQsb6l96gCC0cqju/R+zQTgggR7vzP+Pg84WYsQKInQYvOutu7XcqFdPJG
	 QdlybdI6MWo/dJdYNn9jBLCX93o4jAmxHlI20OH1OIj2H65P2OAEqIUkAbeMj+wETM
	 CTB3gfqO7HaXqvTvpNc5nnv27rHY3B1pNErq+5VTfyaErebP7FjFYGg7iNHaC7kNvd
	 z0gA6WdvBzUN870Fx+B8CinKGLGrRxMUbKv3vXIYLXCH7pPVHLklTXlJn7Au65E5d8
	 TzRIPPpJOyYWw==
Date: Wed, 31 Jan 2024 10:26:07 -0600
From: Seth Forshee <sforshee@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [Intel-wired-lan] i40e XDP program stops transmitting after link
 down/up
Message-ID: <Zbp0n4HTPw/xMtB5@do-x1extreme>
References: <ZbkE7Ep1N1Ou17sA@do-x1extreme>
 <47eea378-6b76-46a7-b70e-52bc61f5e9f0@molgen.mpg.de>
 <Zbkq4cVJ1rEPda8i@do-x1extreme>
 <ZblN2ABkWPM0gGZB@boxer>
 <Zblyz7ZnA2GXh04k@boxer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zblyz7ZnA2GXh04k@boxer>

On Tue, Jan 30, 2024 at 11:06:07PM +0100, Maciej Fijalkowski wrote:
> On Tue, Jan 30, 2024 at 08:28:24PM +0100, Maciej Fijalkowski wrote:
> > On Tue, Jan 30, 2024 at 10:59:13AM -0600, Seth Forshee wrote:
> > > On Tue, Jan 30, 2024 at 05:14:23PM +0100, Paul Menzel wrote:
> > > > Dear Seth,
> > > > 
> > > > 
> > > > Thank you for bring this up.
> > > > 
> > > > Am 30.01.24 um 15:17 schrieb Seth Forshee:
> > > > > I got a inquiry from a colleague about a behavior he's seeing with i40e
> > > > > but not with other NICs. The interfaces are bonded with a XDP
> > > > > load-balancer program attached to them. After 'ip link set ethX down; ip
> > > > > link set ethX up' on one of the interfaces the XDP program on that
> > > > > interface is no longer transmitting packets. He found that tx starts
> > > > > again after running 'sudo ethtool -t ethX'.
> > > > > 
> > > > > There's a 'i40e 0000:d8:00.1: VSI seid 391 XDP Tx ring 0 disable
> > > > > timeout' message in dmesg when disabling the interface. I've included
> > > > > the relevant portions from dmesg below.
> > > > > 
> > > > > This was first observed with a 6.1 kernel, but we've confirmed that the
> > > > > behavior is the same in 6.7. I realize the firmware is pretty old, so
> > > > > far our attempts to update the NVM have failed.
> > > > 
> > > > Does that mean, the problem didn’t happen before Linux 6.1? If so, if you
> > > > have the reproducer and the time, bisecting the issue is normally the
> > > > fastest way to solve the issue.
> > > 
> > > No, sorry, I should have worded that better. I meant that they were
> > > using 6.1 when they noticed the issue, not that kernels before 6.1 did
> > > not have that issue. We've also tried a 5.15 kernel build now and still
> > > see the issue there, we haven't tested anything older than that.
> > 
> > Hey Seth,
> > 
> > I am observing same thing on my side with xdpsock in txonly mode, so I'll
> > take a look at this and will keep you updated.
> 
> Can you try this diff on your side?

That fixes the problem!

Thanks,
Seth

