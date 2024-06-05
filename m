Return-Path: <netdev+bounces-101170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0E58FD9D2
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 00:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740D7285C53
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 22:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0583D155356;
	Wed,  5 Jun 2024 22:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJILipUC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38206FD0
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 22:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717626273; cv=none; b=dfYZqXqT30Q4Att0H9SwVliiJKr0DGIdHdd7ZfTqoNi6JNULXC965QE1LH2JhkKMapQMxUNZTTEJJLT5NDIILoBRBd1q6LHM4KnxHgVlxPRsXuh++QNGii2KlEe4o9eOls1f4NLPh0RcCx6vIsLBGN/kinHG7orwFO2LPRT2Hqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717626273; c=relaxed/simple;
	bh=3PiLjoOXPscodYtgfMCSdWfecpbOlvV3oAgW/zUZyRk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JPqjutF8TJHVKRm/RxFP6aMnfFjAAnzrJlBFYbngfMIJzj71RiKk2aJZAK6Y6zz/dlG0Gn6vvZ4KJpQ0DGS0hyb/7ylYuwLevUqzAG/GXPLaflu13l/gTqzyhmQWac9Vnxrl/awxri2XhAFIEae4uXG+bRsI5KiP0tcc8/jxqFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJILipUC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5673C2BD11;
	Wed,  5 Jun 2024 22:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717626273;
	bh=3PiLjoOXPscodYtgfMCSdWfecpbOlvV3oAgW/zUZyRk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TJILipUC0S+oWO7FGfswjv37C7696iY8CFf4sdmCrd1vY2gyjla2yj9Dz4m+ekngB
	 h6KVOgjPKt8Fsegkm5FxBTe2hkS1HhEy06cbyvsJ+xqfsXyI5d/nFBoZLK7XuuKF65
	 ygWlCkYNd8JasmLeoYOiSZgywdPJRm8D59pl5Ir1JrAZsdg37pUkW17/KJsciL8w91
	 GdJHh8cffsqyMIHQxthUIWAtkW4IDeZzVl8W9N/DiAjs582xepW+auttuBKKJS4ZTF
	 mkvvarMU1xo2RiFsyat/RQpDjxMqqVmj/KpTvej5NdaJnnCT8SNnnlxgIm9Bi4eVe2
	 gVvrieNHAklEg==
Date: Wed, 5 Jun 2024 15:24:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, borisp@nvidia.com,
 gal@nvidia.com, cratiu@nvidia.com, rrameshbabu@nvidia.com,
 steffen.klassert@secunet.com, tariqt@nvidia.com, mingtao@meta.com,
 knekritz@meta.com, Lance Richardson <lance604@gmail.com>
Subject: Re: [RFC net-next 01/15] psp: add documentation
Message-ID: <20240605152431.5f24cb45@kernel.org>
In-Reply-To: <6660c673921ff_35916d294ef@willemb.c.googlers.com.notmuch>
References: <20240510030435.120935-1-kuba@kernel.org>
	<20240510030435.120935-2-kuba@kernel.org>
	<66416bc7b2d10_1d6c6729475@willemb.c.googlers.com.notmuch>
	<20240529103505.601872ea@kernel.org>
	<6657cc86ddf97_37107c29438@willemb.c.googlers.com.notmuch>
	<20240530125120.24dd7f98@kernel.org>
	<6659d71adc259_3f8cab29433@willemb.c.googlers.com.notmuch>
	<20240604170849.110d56c1@kernel.org>
	<6660c673921ff_35916d294ef@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 05 Jun 2024 16:11:31 -0400 Willem de Bruijn wrote:
> > The retansmissions of K-A are unencrypted, to avoid sending the same
> > data in encrypted and unencrypted form. This poses a risk if an ACK
> > gets lost but both hosts end up in the PSP Tx state. Assume that Host A
> > did not send the RPC (line 12), and the retransmission (line 14)
> > happens as an RTO or TLP. Host B may already reach PSP Tx state (line
> > "20") and expect encrypted data. Plain text retransmissions (with
> > sequence number before rcv_nxt) must be accepted until Host B sees
> > encrypted data from Host A.  
> 
> Is that sufficient if an initial encrypted packet could get reordered
> by the network to arrive before a plaintext retransmit of a lower
> seqno?

Yes, I believe that's fine. 

I will document this clearer but both sides must be pretty precise in
their understanding when the switchover happens. They must read what 
they expect to be clear text, and then install the Tx key thus locking
down the socket.

1. If they under-read and clear text data is already queued - the kernel
   will error out.
2. If they under-read and clear text arrives later - the connection will
   hang.
3. If they over-read they will presumably get PSP-protected data
   which they have no way of validating, since it won't be secured by
   user crypto.

We could protect from over-read (case 3) by refusing to give out
PSP-protected data until keys are installed. But it adds to the fast
path and I don't think it's all that beneficial, since there's no way
to protect a sloppy application from under-read (case 2).

Back to your question about reordering plain text with cipher text:
the application should not lock down the socket until it gets all
its clear text. So clear text retransmissions _after_ lock down must be
spurious. The only worry is that we lose an ACK and never tell
the other side that we got all the clear text. But we're guaranteed
to successfully ACK any PSP-protected data, so if we receive some
there is no way to get stuck.  Let me copy / paste the diagram:

01 p       Host A                         Host B
02 l t        ~~~~~~~~~~~[TCP 3 WHS]~~~~~~~~~~
03 a e        ~~~~~~[crypto negotiation]~~~~~~
04 i x                             [Rx key alloc = K-B]
05 n t                          <--- [app] K-B key send 
06 ------[Rx key alloc = K-A]-
07     [app] K-A key send -->|
08        [TCP] K-B input <-----
08 P      [TCP] K-B ACK ---->|
09 S R [app] recv(K-B)       |
10 P x [app] [Tx key set]    |  
11 -------------------------- 
12 P T [app] send(RPC) #####>|   
13 S x                       |<----    [TCP] Seq OoO! queue RPC, SACK
14 P      [TCP] retr K-A --->|   
15                           |  `->    [TCP] K-A input
16                           | <---    [TCP] K-A ACK (or FIN) 
17                           |      [app] recv(K-A)
18                           |      [app] [Tx key set]
19                            -----------------------------------
20

Looking as Host A, if we receive encrypted data, we must have
allocated and sent key (line 7) so we will start accepting encrypted
data. But at this point we are also accepting plain text (until we
reach line 9). We will send a plain text (S)ACK to encrypted data, 
but that's fine too since Host B hasn't seen any encrypted data from us
and will accept such ACKs.

> Both scenarios make sense. It is unfortunately harder to be sure that
> we have captured all edge cases.

Are you trying to say packetdrill without saying packetdrill? :)

> An issue related to the rcv_nxt cut-point, not sure how important: the
> plaintext packet contents are protected by user crypto before upgrade.
> But the TCP headers are not. PSP relies on TCP PAWS against replay
> protection. It is possible for a MITM to offset all seqno from the
> start of connection establishment. I don't see an immediate issue. But
> at a minimum it could be possible to insert or delete before PSP is
> upgraded.

Yes, the "cut off" point must be quite clearly defined, because both
sides must precisely read out all the clear text. Then they install 
the Tx key and anything they read must have been PSP-protected.

Hope I understood the point.

