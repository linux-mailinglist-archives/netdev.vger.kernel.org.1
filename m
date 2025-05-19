Return-Path: <netdev+bounces-191679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0485EABCB3C
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 01:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8467A3BFB59
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 23:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56D310E4;
	Mon, 19 May 2025 23:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kK/xaEUs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897A22868B;
	Mon, 19 May 2025 23:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747695665; cv=none; b=ghyooqtDrGZw/a+vnYQc+xoopm+0pLvr/TVIJT1Mqgh32ogAB90In0QIJzqMmgrRoNFJeib+x7Kp22JbkuR3Q0ItSAZdrsruHTprIkGcRc3Ulp5MhbFQpLdvochZr1yvcaNBbt9tRU5oJNN0QzuhcgwEcY4afZbVn7/L+MNsYaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747695665; c=relaxed/simple;
	bh=UOvrAvKttJi122NoVir8gO+DuRbWd7w3i3FaBzW8fek=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qpQ9UdEiy1lCS2W9nqUQIUJdVdA8irG2YZxpeqnZijtWdE/D/yx0o8K/is7j2vWBQ5JRHx4KDeuPy8OQ2PXBBkBTNoFsOdSxqoOdlqmj7t1Q2LncP6syoagagriB54E1YNAPHrUEWZBXBfTh7HL+4jn7FHm3N5X5TZuNus8gQBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kK/xaEUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB439C4CEE4;
	Mon, 19 May 2025 23:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747695665;
	bh=UOvrAvKttJi122NoVir8gO+DuRbWd7w3i3FaBzW8fek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kK/xaEUsFGOJ90fRVfxI+qrKLLKlE40dpX4FZf7kEwEqbUAQPcRkMDffznWPPMfFn
	 ob8OuCz8ktKUD745f09Ff9tdh5etqkrMGGDt5NHdYkIdozx1SwI9lMYCWz+EghKH+0
	 VbDTtcDtzi72/sFDAF3Sa71+SJqKece7glS/OKcY09Ag2ueUd/Y2VZLrfl4hoqIaNr
	 g5hOyf4x2mdF5B0dAMJfxWm3FhB24OdRShpKniDA/9wOwQ23FIDsNmCFEzlUp+3/TY
	 mBBQNC4jPbyEjhvEQe7mWRrUV3EPP5H5YMHlq97o9GqCtzX/vcnEGIz0p4tmiS5vnB
	 wXRHyCDfnUaxw==
Date: Mon, 19 May 2025 16:01:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: netdev@vger.kernel.org, Steve Sears <sjs@hammerspace.com>, Thomas Haynes
 <loghyr@hammerspace.com>, kernel-tls-handshake
 <kernel-tls-handshake@lists.linux.dev>, Sabrina Dubroca
 <sd@queasysnail.net>
Subject: Re: RPC-with-TLS client does not receive traffic
Message-ID: <20250519160102.26d95e57@kernel.org>
In-Reply-To: <48aaf181-b7cf-45d1-ba60-bf90ad45d842@oracle.com>
References: <0288b61b-6a8e-409d-8e4c-3f482526cf46@oracle.com>
	<20d1d07b-a656-48ab-9e0e-7ba04214aa3f@oracle.com>
	<62cbd258-11df-4d76-9ab1-8e7b72f01ca4@suse.de>
	<7014c4fa-fa99-45d4-9c3b-8bf3ff3f7b38@oracle.com>
	<20250516162716.340fb97c@kernel.org>
	<8ABF3663-1BDD-4B87-8DA5-AB39774B1B89@oracle.com>
	<20250516165355.6efb470e@kernel.org>
	<48aaf181-b7cf-45d1-ba60-bf90ad45d842@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 May 2025 12:39:58 -0400 Chuck Lever wrote:
> > Hm, yes, my intuition would be to add a xs_poll_check_readable() 
> > after connection set up to check if we raced with data being queued?
> > 
> > IIUC sk->sk_user_data is not set up when the first event fires
> > so xs_data_ready() ignores it?  We can't set user_data sooner?  
> 
> I think the answer to this is that sunrpc never sees a data ready event.
> The value contained in sk->sk_user_data is therefore irrelevant.
> 
> Because tls_setsockopt() sets strp->msg_ready, when the underlying
> socket event arrives tls_data_ready() is a no-op. That terminates the
>  ->data_ready call chain before xs_data_ready can be called.  
> 
> The handshake daemon sets the session key by calling tls_setsockopt.
> When it hangs:
> 
> function:             tls_setsockopt
> function:                do_tls_setsockopt_conf
> function:                   tls_set_device_offload_rx
> function:                   tls_set_sw_offload
> function:                      init_prot_info
> function:                      tls_strp_init
> function:                   tls_sw_strparser_arm
> function:                   tls_strp_check_rcv
> function:                      tls_strp_read_sock
> function:                         tls_strp_load_anchor_with_queue
> function:                         tls_rx_msg_size
> function:                            tls_device_rx_resync_new_rec
> function:                         tls_rx_msg_ready    <<<<<
> 
> The next call to tls_data_ready sees strp->msg_ready is set, returns
> without doing anything, and progress stops.
> 
> In the successful case, tls_strp_check_rcv() simply returns, leaving
> strp->msg_ready set to zero. The next call to tls_data_ready can
> then process the ingress data and call xs_data_ready.

Is there any data queued on the TLS socket already when it "hangs" ?
If it's getting into msg_ready state without the data - it's a bug 
in TLS. If there's a full record queued at the time when handshake
passes the socket back to the kernel - it's up to the reader to read
the already queued data out.

