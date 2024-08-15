Return-Path: <netdev+bounces-118944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F82953995
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 20:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13EA4286A75
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 18:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011C95A0F5;
	Thu, 15 Aug 2024 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfMXQEjG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17C115CB
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723744891; cv=none; b=stO83EBDU9Lqbh5+z+tMa+YdhHSJCpdszG6Z8oo1t+U7Ly7HBybcACjOTMoovBRIimYBvKQwW7llI3sbfkHJneIItEMVSUA6HpNxkusB5pGI6BuWXxRhb0KeSMZPrMNIQ/uPGk9gTZu+LzDoudg+nBv5Gug8sOfTDHbLfhnGG9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723744891; c=relaxed/simple;
	bh=pYHdH9WKdPBBRTKpyk2SH3OifA8q6T4pmH2TbjMEdEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhtGfsmM2R9BtqPFGcmt5oFlI8BnIkl0iGHoaEMrROaZHLoMGooGNk4LEhbSjio/ugbatWVHLNZ0Tz7qzqvN9SQl8Isp+TQVUDC3YvsFJjElV5uKDTQpy9G7rQpJN6Ijv7rgH5WmKLYlJquobHhFkdh7rW3qB75LTu6n8d8Yk3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfMXQEjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A8DC4AF09;
	Thu, 15 Aug 2024 18:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723744890;
	bh=pYHdH9WKdPBBRTKpyk2SH3OifA8q6T4pmH2TbjMEdEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qfMXQEjGAHzVx9jmki7/89Zo39+S1zZOqGVOI/ALSjn2VraWDOay9Alegw/O1n38G
	 kYP4ilfWWoJIq8cK0lIaf1rXpwjhQzgs9v8kDGzeNXHugl0YR7e2sbZluB9MhL8yoW
	 19KvRJmPhRTjhm3odyXOLzGheehkHALPZ7QILzezEBjUlSgE1croIVQiY640ACfyJl
	 quibqYeK+uTwwh4qY8j7gddZCNjSmDySc8fRpExSgglzHo4MrpaBo+tccM5v+WhYZc
	 Uifl4uAq5oEzgRMaOJQsgw9cbu/DXED5gNyQ03ucwOkCrv7UUaMwE/wZfG/lRDchoR
	 QBtnuN9IkWx8Q==
Date: Thu, 15 Aug 2024 19:01:27 +0100
From: Simon Horman <horms@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Network Development <netdev@vger.kernel.org>
Subject: Re: Per-queue stats question
Message-ID: <20240815180127.GP632411@kernel.org>
References: <56a36d45-f779-0c67-2853-6ead9e8f9dc9@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56a36d45-f779-0c67-2853-6ead9e8f9dc9@gmail.com>

On Thu, Aug 15, 2024 at 06:11:42PM +0100, Edward Cree wrote:
> I'm working on adding netdev_stat_ops support to sfc, and finding that
>  the expectations of the selftest around the relation between qstats
>  and rtnl stats are difficult for us to meet.  I'm not sure whether it
>  is our existing rtnl stats or the qstats I'm adding that have the
>  wrong semantics.
> 
> sfc fills in rtnl_link_stats64 with MAC stats from the firmware (or
>  'vadaptor stats' if using SR-IOV).  These count packets (or bytes)
>  since last FW boot/reset (for instance, "ethtool --reset $dev all"
>  clears them).  (Also, for reasons I'm still investigating, while the
>  interface is administratively down they read as zero, then jump back
>  to what they were on "ip link set up".)  Moreover, the counts are
>  updated by periodic DMA, so can be up to 1 second stale.
> The queue stats, meanwhile, are maintained in software, and count
>  since ifup (efx_start_channels()), so that they can be reset on
>  reconfiguration; the base_stats count since driver probe
>  (efx_alloc_channels()).
> 
> Thus, as it stands, it is possible for qstats and rtstats to disagree,
>  in both directions.  For example:
> * Driver is unloaded and then loaded again.  base_stats will reset,
>   but MAC stats won't.
> * ethtool reset.  MAC stats will reset, but base_stats won't.
> * Traffic is passing during the test.  qstats will be up to date,
>   whereas MAC stats, being up to 1s stale, could be far behind.
> * RX filter drops (e.g. unwanted destination MAC address).  These are
>   counted in MAC stats but since they never reach the driver they're
>   not counted in qstats/base_stats (and by my reading of netdev.yaml
>   they shouldn't be, even if we could).
> 
> Any of these will cause the stats.pkt_byte_sum selftest to fail.
> Which side do I need to change, qstats or rtstats?  Or is the test
>  being too strict?

Maybe speaking out of turn (or through my hat) but my opinion is that the
test is too strict.

This is because I believe that in practice there can be constraints which
make it impractical or undesirable for stats to be fetched directly from
hardware. And that this leads to some level of caching in software. Which
in turn leads to some scope for stats to be out of date.

I think that is fine, so long as the stats don't lag too much. Where, IMHO
too much might be say more than 0.1s, or something like that. Because, in
my experience, that is fine as a user-experience: either a user, looking at
stats, or a process analysing stats for usage patterns.

> 
> On a related note, I notice that the stat_cmp() function within that
>  selftest returns the first nonzero delta it finds in the stats, so
>  that if (say) tx-packets goes forwards but rx-packets goes backwards,
>  it will return >0 causing the rx-packets delta to be ignored.  Is
>  this intended behaviour, or should I submit a patch?
> 
> -ed
> 

