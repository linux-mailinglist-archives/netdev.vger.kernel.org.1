Return-Path: <netdev+bounces-136469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F729A1DCD
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEF02283422
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1791D86E6;
	Thu, 17 Oct 2024 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBhsGYDE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED76B1D7996
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 09:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729155872; cv=none; b=hpE8Q8kBua1h5bREcM/L28Yftu0PS5vmLUtAzceqM/IszJlZtf7IRn0ExIa6XOXEhKLKrAVm+CGML1Ba9Jt26YLE+CfLjebp8/fudVTrr0uK9cval6kEXkZtnEZhnoejx2IUZk/iERyKK9XsY4QepPkhQGFGvRpTYlqjjSIw8qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729155872; c=relaxed/simple;
	bh=d5kqO4Bh9+2mLG4iFeXcX1lSGbbJ2UL2sLpOF4R3KX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lG3U+YcLyx8wBt/IK/C257CnHYqt3MSMggCYgJVp2Q+PiP4brbzz/tHEyc4wvYiqmmTS3/dgpFt40GsBsZDOCFXp80T9VSKwuQGyrcZgt4S4I8WoRUjAjmqsMSpqs19ZxGAlijRw2FZTAFos+8qAf8HHtANShYP1Kc9OmgtIPRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBhsGYDE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9EDC4CEC3;
	Thu, 17 Oct 2024 09:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729155871;
	bh=d5kqO4Bh9+2mLG4iFeXcX1lSGbbJ2UL2sLpOF4R3KX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fBhsGYDEZBWr9wfeIkUXehVLJCt/J7hM7gGxAJdLccpuNX1U0hYNC98bIGTWzqhbk
	 Llp/chNtnicm3xiUxDYY3lzr8qQCNeMOFl18oJG8nKQV39Bb/EEPGXF+MKusJ9giUK
	 +OXz5msY94POZSBJ07Qrs67baL//sIQppD6TSL0XiTGLC13ic+f/gOkTIiRld18t0w
	 9cSsx4UmItjp6pz3VDPgF42dQqMuxOkjJ0jAaHc+ticCg8mxqCtnR5c7/Qshp2noxH
	 QFNCK8Oyh64BQx8AlnEbq2LktCJKdDgpnypgCG5Uz20x2yk9yOk7p3/DKY8bVrQ+/y
	 ypcvstjsXz0Fg==
Date: Thu, 17 Oct 2024 10:04:28 +0100
From: Simon Horman <horms@kernel.org>
To: Joshua Hay <joshua.a.hay@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, aleksander.lobakin@intel.com,
	madhu.chittim@intel.com, netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan][PATCH iwl-net] idpf: set completion tag for
 "empty" bufs associated with a packet
Message-ID: <20241017090428.GS2162@kernel.org>
References: <20241007202435.664345-1-joshua.a.hay@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007202435.664345-1-joshua.a.hay@intel.com>

On Mon, Oct 07, 2024 at 01:24:35PM -0700, Joshua Hay wrote:
> Commit d9028db618a6 ("idpf: convert to libeth Tx buffer completion")
> inadvertently removed code that was necessary for the tx buffer cleaning
> routine to iterate over all buffers associated with a packet.
> 
> When a frag is too large for a single data descriptor, it will be split
> across multiple data descriptors. This means the frag will span multiple
> buffers in the buffer ring in order to keep the descriptor and buffer
> ring indexes aligned. The buffer entries in the ring are technically
> empty and no cleaning actions need to be performed. These empty buffers
> can precede other frags associated with the same packet. I.e. a single
> packet on the buffer ring can look like:
> 
> 	buf[0]=skb0.frag0
> 	buf[1]=skb0.frag1
> 	buf[2]=empty
> 	buf[3]=skb0.frag2
> 
> The cleaning routine iterates through these buffers based on a matching
> completion tag. If the completion tag is not set for buf2, the loop will
> end prematurely. Frag2 will be left uncleaned and next_to_clean will be
> left pointing to the end of packet, which will break the cleaning logic
> for subsequent cleans. This consequently leads to tx timeouts.
> 
> Assign the empty bufs the same completion tag for the packet to ensure
> the cleaning routine iterates over all of the buffers associated with
> the packet.
> 
> Fixes: d9028db618a6 ("idpf: convert to libeth Tx buffer completion")
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> Acked-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Madhu chittim <madhu.chittim@intel.com>

Thanks for the detailed description.

Reviewed-by: Simon Horman <horms@kernel.org>

