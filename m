Return-Path: <netdev+bounces-94377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 220C88BF4B0
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 04:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2651C219E6
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64DD10A31;
	Wed,  8 May 2024 02:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+lnNjm0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC765228;
	Wed,  8 May 2024 02:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715136288; cv=none; b=lph8Et2nZYEVABzXZLDVgCoLgakr/om0iEiAHZPjPEsOPElCc/2wUC2j3sLLKIF1aECZiM4czCkBOPth5iXfcBZ4g8fgdnBQVQZiamnZ7Wi7FkwGlVJLxyImi3pXIoyq3cofRPJoqZ4jwIDllZPFcZB8fyUTko38dcnLlI0+u0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715136288; c=relaxed/simple;
	bh=y8zJhSdEO0O3byTO332Xra8ThwWspihaa4gkDTlXj0k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DroFcL1tr07jgOkd4YAX59kIP/SObMjZmOtBxbm/31dkhCH7Er55FbDu//DJ9LbqhZJbDITfIRGBaK/ICEavXiRh0Xjzemu2WXAQxZaaVSsoapKBNGGj6nYT5zi6Fj6vOdcs8p8CcnkDN8HZcweRS52tCvKfFrspR7B1u513meo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+lnNjm0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0A7C3277B;
	Wed,  8 May 2024 02:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715136288;
	bh=y8zJhSdEO0O3byTO332Xra8ThwWspihaa4gkDTlXj0k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r+lnNjm0mULfNsnnstEFN43bopDd61eWXCqsf9avhWdNKb7skA5lSdhEak0tF0IYe
	 mq/gs92V2QHFthaG4vbRlRL7iVdqTzvN/m5rUSmt1oHlA/j1Fmf2TS9oSyCtKGdlR0
	 kLe89fFYDOefmD8m+P6lYUaaA7I6tGTUayZbpz0fi5Gi5LvVBueSVReBTG18KWvA2P
	 GZdrhFoSAcEinVS1MKkLH7DvmXKwV0Z+iniJhwA4axP8Fr2Kd0Odmb4hp7Jw5oomq8
	 lKAw5SIames4pHi+tH5fCkRQEJltyXlJqIQJk5IljH1+L5rQgCGRkPCh0O0uBWstmC
	 x3YdM6WjTeXng==
Date: Tue, 7 May 2024 19:44:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/5] rxrpc: Miscellaneous fixes
Message-ID: <20240507194447.20bcfb60@kernel.org>
In-Reply-To: <20240503150749.1001323-1-dhowells@redhat.com>
References: <20240503150749.1001323-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 May 2024 16:07:38 +0100 David Howells wrote:
> Here some miscellaneous fixes for AF_RXRPC:
> 
>  (1) Fix the congestion control algorithm to start cwnd at 4 and to not cut
>      ssthresh when the peer cuts its rwind size.
> 
>  (2) Only transmit a single ACK for all the DATA packets glued together
>      into a jumbo packet to reduce the number of ACKs being generated.
> 
>  (3) Clean up the generation of flags in the protocol header when creating
>      a packet for transmission.  This means we don't carry the old
>      REQUEST-ACK bit around from previous transmissions, will make it
>      easier to fix the MORE-PACKETS flag and make it easier to do jumbo
>      packet assembly in future.
> 
>  (4) Fix how the MORE-PACKETS flag is driven.  We shouldn't be setting it
>      in sendmsg() as the packet is then queued and the bit is left in that
>      state, no matter how long it takes us to transmit the packet - and
>      will still be in that state if the packet is retransmitted.
> 
>  (5) Request an ACK on an impending transmission stall due to the app layer
>      not feeding us new data fast enough.  If we don't request an ACK, we
>      may have to hold on to the packet buffers for a significant amount of
>      time until the receiver gets bored and sends us an ACK anyway.

Looks like these got marked as Rejected in patchwork.
I think either because lore is confused and attaches an exchange with
DaveM from 2022 to them (?) or because I mentioned to DaveM that I'm
not sure these are fixes. So let me ask - on a scale of 1 to 10, how
convinced are you that these should go to Linus this week rather than
being categorized as general improvements and go during the merge
window (without the Fixes tags)?

