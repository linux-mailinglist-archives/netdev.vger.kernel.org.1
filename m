Return-Path: <netdev+bounces-244366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4E7CB5850
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 11:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B9EB30052F1
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 10:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F0A2FF17F;
	Thu, 11 Dec 2025 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmmjU8HQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B042F28C864;
	Thu, 11 Dec 2025 10:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765449049; cv=none; b=MerZbn7wcYimt1P83PCnA+rwGifZxT5WwTll/v5fnPfN8NFWMUzzKW4oVjzTCwk0zM/U+gZ5m8uXVaofJoaWmvRJMXFbwJxalxdWY9OCt5g4tmsdZBYBz7Rg7gz6JwqfobdTtz7B+gkgyUNMVGqEYbdpssF/mJJMSC9+CADOL54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765449049; c=relaxed/simple;
	bh=Bks6WfBvXZRiysgGfz3X789jvv7vY5FL6+JWgKtcYSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9aPgD5bXcnpZl8qHbROQrph0BNfKkdABFIt2rOVFdKU0aiO8v2sX60n6A7f1k8xx8wE9SLA16u3jzGYgRblPYoFKFfsGThoPz/dD5LbaR1jTxI5uwQPFsiswrpzK9NOxgGvVWaEDoriiY0/LphAV0sjXQIUwcVyXaXv8kLiN0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmmjU8HQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FD1C4CEF7;
	Thu, 11 Dec 2025 10:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765449047;
	bh=Bks6WfBvXZRiysgGfz3X789jvv7vY5FL6+JWgKtcYSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mmmjU8HQduSgO2FgbAbsBdbN/TKLyRws1rewY1Xl5dDd/nfYqTvLBv4P3gfDOZH5z
	 luDv6xfcL7sZTUcUhWwE2c2c3edrE+47XfJkQKx0cXcrcKzezIu94uVRdkvhX8SClG
	 j1ke0Igy9iFMgkMgjk6tlwgok30FwrXOIhKfztXn85IqjhQMKCHnN+kXnQoTxiav7r
	 oF3wnV2w+gwgQoJbixCzoy5jOn2Le2wBeWSsAJvYjPL5IKln4xZHWFRySOs96NCrjA
	 EouJtVErzn6M2lUkIfkCSeiBWv2logqd0rC36CYCouYXv3oIP6L1sX1qVvzKNWs5Qp
	 jJQ10oh57lwvw==
Date: Thu, 11 Dec 2025 10:30:43 +0000
From: Simon Horman <horms@kernel.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net v3] net: atm: implement pre_send to check input
 before sending
Message-ID: <aTqdU0b1USWpKBGW@horms.kernel.org>
References: <aTlvgIS6TxZ_Q5zE@horms.kernel.org>
 <tencent_58BAB3BB5133049EA81B004B7D1B0D255508@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_58BAB3BB5133049EA81B004B7D1B0D255508@qq.com>

On Thu, Dec 11, 2025 at 02:55:45PM +0800, Edward Adam Davis wrote:
> On Wed, 10 Dec 2025 13:02:56 +0000, Simon Horman wrote:
> > On Wed, Dec 10, 2025 at 06:50:02PM +0800, Edward Adam Davis wrote:
> > > Sun, Wed, 10 Dec 2025 10:31:34 +0000, Simon Horman wrote:
> > > > > syzbot found an uninitialized targetless variable. The user-provided
> > > > > data was only 28 bytes long, but initializing targetless requires at
> > > > > least 44 bytes. This discrepancy ultimately led to the uninitialized
> > > > > variable access issue reported by syzbot [1].
> > > > >
> > > > > Besides the issues reported by syzbot regarding targetless messages
> > > > > [1], similar problems exist in other types of messages as well. We will
> > > > > uniformly add input data checks to pre_send to prevent uninitialized
> > > > > issues from recurring.
> > > > >
> > > > > Additionally, for cases where sizeoftlvs is greater than 0, the skb
> > > > > requires more memory, and this will also be checked.
> > > > >
> > > > > [1]
> > > > > BUG: KMSAN: uninit-value in lec_arp_update net/atm/lec.c:1845 [inline]
> > > > >  lec_arp_update net/atm/lec.c:1845 [inline]
> > > > >  lec_atm_send+0x2b02/0x55b0 net/atm/lec.c:385
> > > > >  vcc_sendmsg+0x1052/0x1190 net/atm/common.c:650
> > > > >
> > > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > > Reported-by: syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com
> > > > > Closes: https://syzkaller.appspot.com/bug?extid=5dd615f890ddada54057
> > > > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > > > ---
> > > > > v3:
> > > > >   - update coding style and practices
> > > > > v2: https://lore.kernel.org/all/tencent_E83074AB763967783C9D36949674363C4A09@qq.com/
> > > > >   - update subject and comments for pre_send
> > > > > v1: https://lore.kernel.org/all/tencent_B31D1B432549BA28BB5633CB9E2C1B124B08@qq.com
> > > >
> > > > FTR, a similar patch has been posted by Dharanitharan (CCed)
> > > Didn't you check the dates? I released the third version of the patch
> > > on December 4th (the first version was on November 28th), while this
> > > person above released their first version of the patch on December 7th.
> > > Their patch is far too similar to mine!
> > 
> > Yes, I was aware of the timeline when I wrote my previous email.
> > 
> > My preference is for some consensus to be reached on the way forward:
> > both technically and in terms of process.
> I'm a little confused. Why are you explaining the process to someone
> who submitted a patch 99% similar to mine, just a few days after I did?

It's always tricky when similar patches are on the ML on the same time.
Ultimately what I would like is for a correct solution to be merged.
Ideally in a way that makes everyone happy.

I'm explaining that to everyone: in this thread, and elsewhere.

