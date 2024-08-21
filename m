Return-Path: <netdev+bounces-120746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B116595A7F1
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 00:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDBA1C22028
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 22:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4785F17B500;
	Wed, 21 Aug 2024 22:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzgPG2DD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159BD170A30;
	Wed, 21 Aug 2024 22:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724280847; cv=none; b=Qk1GEoSyUwF+H9idWoAStJ9+KfR9NndvNvSVcGoDpodDSFqgz/aZ6KKT4NQPB/LywiD9vHk4RTvxo6apcOZ/UaTPmglnPIsCW9Wli8DtRPiDw/G9/hVHDnseKlhaFTnbBcloR6ZsupCo0p+neh1DNL8GcpC4Aoor6ffPKaDXhn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724280847; c=relaxed/simple;
	bh=jVdISEGJxwg+R8J6TCoIS814tqUGAul5muvo2/Z+JV4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ULstVNXzST+E6GvRgmiQoMRvErkJUSTikG9bGwhCN4d/L7FMOeLG3YygEKYz8DvP/8+Lfhm1fG7l0cfgo4XpLe8CBUtN7KLwvWgie4pJ+RekoP5OLGBrA3d4MbQQRIcn8mLVBpRsWX8hHgrNehzu7GmCTfr7yZiOtNmbCpy4j3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzgPG2DD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C623C32781;
	Wed, 21 Aug 2024 22:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724280846;
	bh=jVdISEGJxwg+R8J6TCoIS814tqUGAul5muvo2/Z+JV4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bzgPG2DDEtAsED1FRurCyIMYKOSGrhqQLjtR4U1rg0ci3YSEhiWPT/j1ASFriCth8
	 ko9nrmcXVI2HQpkSWTbnKO9a8tqAENQi1J5veucq8qixEitNBoV2m7jhNJabG2gwNl
	 4fu86aK5pNvlCEK1yxunXfvQ4/rXSLe8amMNeNtrrCSHC2JN5PzSh53SbIYLf6XOzK
	 pzJuB1e8zEwsVsr5vf95FLhUO4cnI96Y3/pEZ9k2ZwRYtShp7nA93JsP8/0BH1ppFD
	 sVKiG+0F/NwwlzhIBeOk6lEpbXq79mhWLvazEYPZWd/PL4uAWTp8R090p+czhjE0T5
	 2uXjEDgF/HxWw==
Date: Wed, 21 Aug 2024 15:54:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] netconsole: pr_err() when netpoll_setup
 fails
Message-ID: <20240821155404.5fc89ff6@kernel.org>
In-Reply-To: <ZsWoUzyK5du9Ffl+@gmail.com>
References: <20240819103616.2260006-1-leitao@debian.org>
	<20240819103616.2260006-3-leitao@debian.org>
	<20240820162409.62a222a8@kernel.org>
	<ZsWoUzyK5du9Ffl+@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Aug 2024 01:41:55 -0700 Breno Leitao wrote:
> On Tue, Aug 20, 2024 at 04:24:09PM -0700, Jakub Kicinski wrote:
> > On Mon, 19 Aug 2024 03:36:12 -0700 Breno Leitao wrote:  
> > > netpoll_setup() can fail in several ways, some of which print an error
> > > message, while others simply return without any message. For example,
> > > __netpoll_setup() returns in a few places without printing anything.
> > > 
> > > To address this issue, modify the code to print an error message on
> > > netconsole if the target is not enabled. This will help us identify and
> > > troubleshoot netcnsole issues related to netpoll setup failures
> > > more easily.  
> > 
> > Only if memory allocation fails, it seems, and memory allocation
> > failures with GFP_KERNEL will be quite noisy.  
> 
> Or anything that fails in ->ndo_netpoll_setup() and doesn't print
> anything else.

Which also only fails because of memory allocation AFAICT.

> Do you think this is useless?

I think it's better to push up more precise message into the fail sites.

> > BTW I looked thru 4 random implementations of ndo_netpoll_setup
> > and they look almost identical :S Perhaps they can be refactored?  
> 
> correct.  This should be refactored.
> 
> In fact, since you opened this topic, there are a few things that also
> come to my mind
> 
> 1) Possible reduce refill_skb() work in the critical path (UDP send
> path), moving it to a workqueue?
> 
> When sending a message, netpoll tries fill the whole skb poll, and then try to
> allocate a new skb before sending the packet. 
> 
> netconsole needs to write a message, which calls netpoll_send_udp()
> 
> 	send_ext_msg_udp() {
> 		netpoll_send_udp() {
> 			refill_skbs() {
> 				while (skb_pool.qlen < MAX_SKBS) {
> 					skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC);
> 				}
> 			}
> 			skb = alloc_skb(len, GFP_ATOMIC);
> 				if (!skb)
> 					skb = skb_dequeue(&skb_pool);
> 			}
> 		}
> 	}
> 		
> Would it be better if the hot path just get one of the skbs from the
> pool, and refill it in a workqueue? If the skb_poll() is empty, then
> alloc_skb(len, GFP_ATOMIC) !?

Yeah, that seems a bit odd. If you can't find anything in the history
that would explain this design - refactoring SG.

> 2) Report statistic back from netpoll_send_udp(). netpoll_send_skb()
> return values are being discarded, so, it is hard to know if the packet
> was transmitted or got something as NET_XMIT_DROP, NETDEV_TX_BUSY,
> NETDEV_TX_OK.
> 
> It is unclear where this should be reported two. Maybe a configfs entry?

Also sounds good. We don't use configfs much in networking so IDK if
it's okay to use it for stats. But no other obviously better place
comes to mind for me.

