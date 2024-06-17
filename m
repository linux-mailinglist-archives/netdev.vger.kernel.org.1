Return-Path: <netdev+bounces-104109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1848390B423
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 17:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF45C1F25892
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BBD1D9507;
	Mon, 17 Jun 2024 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdnI448E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631B91D9504
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718635967; cv=none; b=eMwTDwsK7GFt+Vkg5fJ4miB0aqzbIj9WP4/pD0ic6+6RAGMg4PmJqvTwG7LxJW+a/HZc46KymDDkyQg7HxRTXkQJrvu5xDE5sqiBlojQCNjwsTaqY0MTq3EBL8MM3O76ZHMGpvC+Ow4XYUR/wvez9FbKbfb9k3ITb+MlZJWhZ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718635967; c=relaxed/simple;
	bh=MG9R0YfcKoDfDsSnG7bCZrb8TdRezjqK3o93Y26S1tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3L2mTgcjxxu8RG3wtqwX54LiZndYT+TjFQ+qxzfspbxVe6SvhtTlPzN1/uOYV/PFguXQgMZwQ6RtbGQJRK2QF2HMjDn0qaq+43YCfo4PlK3vBu3+5GyxWHwUst1gpZByujQWnKeHbCemTqtoZWdgEBXSrr0rfyK2k6uIP3hSGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdnI448E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18967C2BD10;
	Mon, 17 Jun 2024 14:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718635966;
	bh=MG9R0YfcKoDfDsSnG7bCZrb8TdRezjqK3o93Y26S1tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CdnI448E7dlOEMvXHIL43p3SKF1g+6khI9sOn99rKqrjgzzTr45BhRTDk05D/GZBi
	 gJYL+H9T58CvtvKH75QvWBrVvzgfs0xGb/zsphaDAzSjBO+HXbXziFqzUN7FT9wYfc
	 uAHPIA+RMUWx6pJ/7OS9XTdWnfBsqe73kGeI4T5wLfWHxqU59gB8TP1xMh+rmZvdPi
	 fqpryfnXl7jHdGGfobSdybZFUNo3Hl17G+CGQqFpE6tVsC8AkrRDW/jbvfPU09YpC2
	 uvGAN63FOua4xp0MJr4pi94TxXYYNUQ9vIXXaSnyjqe3BYDtFK/v5mZGkJZjvMtEQq
	 0GkXvTkOKxEeQ==
Date: Mon, 17 Jun 2024 15:52:42 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Anil Samal <anil.samal@intel.com>, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, leszek.pepiak@intel.com,
	przemyslaw.kitszel@intel.com, lukasz.czapnik@intel.com,
	anthony.l.nguyen@intel.com,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH iwl-next v3 3/3] ice: Implement driver functionality to
 dump serdes equalizer values
Message-ID: <20240617145242.GV8447@kernel.org>
References: <20240614125935.900102-1-anil.samal@intel.com>
 <20240614125935.900102-4-anil.samal@intel.com>
 <20240614175559.4826e4aa@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614175559.4826e4aa@kernel.org>

On Fri, Jun 14, 2024 at 05:55:59PM -0700, Jakub Kicinski wrote:
> On Fri, 14 Jun 2024 05:58:17 -0700 Anil Samal wrote:
> > To debug link issues in the field, serdes Tx/Rx equalizer values
> > help to determine the health of serdes lane.
> > 
> > Extend 'ethtool -d' option to dump serdes Tx/Rx equalizer.
> > The following list of equalizer param is supported
> >     a. rx_equalization_pre2
> >     b. rx_equalization_pre1
> >     c. rx_equalization_post1
> >     d. rx_equalization_bflf
> >     e. rx_equalization_bfhf
> >     f. rx_equalization_drate
> >     g. tx_equalization_pre1
> >     h. tx_equalization_pre3
> >     i. tx_equalization_atten
> >     j. tx_equalization_post1
> >     k. tx_equalization_pre2
> 
> I'd be tempted to create a dedicated way to dump vendor specific signal
> quality indicators (both for Ethernet and PCIe). Feels little cleaner
> than appending to a flat mixed-purpose dump. But either way is fine by
> me, TBH. Much better than vendor tools poking into the BAR...

+1

In particular, I agree that either way ethtool -d is
better than than vendor tools poking into the BAR.
Because the Kernel can mediate access to the hardware
and see the data.

