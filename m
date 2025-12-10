Return-Path: <netdev+bounces-244253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BA8CB2F80
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 14:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1734C303FE56
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 13:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B10322C67;
	Wed, 10 Dec 2025 13:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEOC3TdG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEFD2494D8;
	Wed, 10 Dec 2025 13:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765371782; cv=none; b=kITMGtnza11qE6sXW/J5hahituw8PWlW5EcuY2+2h7S8kX/wgzQl54nAyoRYTtqJcycf9nSO5YqHpTD45IuPVsIC7EFn2OqTvvewef2lJ9JZAseNJskl5g4MNGr22XPx/XVvDdT2YvJcXnQmJ28+3cvgsJZwKb/Wqb0cTrjC0sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765371782; c=relaxed/simple;
	bh=aNpw8kvr+DoIFi3UMjPFZem70ccZRqzTV6hLBbAQIo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwZnFncP9MTPHB9qkKR+S4SEQ77oOkxaiTFJLcsJwES1B1MzQZwC9S+NjPOcoTIwJmzYdxKd5+Aay7RqfBaKUT4zGVTHRqRrSpYBrIsW2FxUJodZIX6kSQKbKrcKHZvitekBpazf8yEZ+X7pnUHo9OcNsUg99qbG6punqXHGT5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEOC3TdG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F22C4CEF1;
	Wed, 10 Dec 2025 13:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765371780;
	bh=aNpw8kvr+DoIFi3UMjPFZem70ccZRqzTV6hLBbAQIo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uEOC3TdGwqchFUrqQ0k7Gd2iee8sdr4TKGPuDcaEZTKXBIs8/Cq3eaFROWB4tZOUA
	 v6BT8Z5qcEqV7dqWGuqGFB4fB17E6SC9c5/ZUmuxAWlrdCFyr5J0esSowTaiPV6O+V
	 kMe78hjb5BT6KchyAHADY8P3hhfG+flE+3NYkoSmiWjy0+Rn4OgTtDa3/W88LweQwH
	 mbldSf+H6uaMFrnv4eLEiyZgxq8sxMzoUHrOnOpti1WanBOIWiGBZjtuDU6RXM4Z0e
	 0ZcDrTultgT94jXvYhSjZaydWvtlL43AoCmDPq0da2I61c0QtJaFFVMcnV6/ud2rn7
	 H+wF/Dr4NUwnQ==
Date: Wed, 10 Dec 2025 13:02:56 +0000
From: Simon Horman <horms@kernel.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net v3] net: atm: implement pre_send to check input
 before sending
Message-ID: <aTlvgIS6TxZ_Q5zE@horms.kernel.org>
References: <aTlMBiGNH7ZChSit@horms.kernel.org>
 <tencent_4312D7064DC99FEEF62ED1CC8827F946E806@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_4312D7064DC99FEEF62ED1CC8827F946E806@qq.com>

On Wed, Dec 10, 2025 at 06:50:02PM +0800, Edward Adam Davis wrote:
> Sun, Wed, 10 Dec 2025 10:31:34 +0000, Simon Horman wrote:
> > > syzbot found an uninitialized targetless variable. The user-provided
> > > data was only 28 bytes long, but initializing targetless requires at
> > > least 44 bytes. This discrepancy ultimately led to the uninitialized
> > > variable access issue reported by syzbot [1].
> > >
> > > Besides the issues reported by syzbot regarding targetless messages
> > > [1], similar problems exist in other types of messages as well. We will
> > > uniformly add input data checks to pre_send to prevent uninitialized
> > > issues from recurring.
> > >
> > > Additionally, for cases where sizeoftlvs is greater than 0, the skb
> > > requires more memory, and this will also be checked.
> > >
> > > [1]
> > > BUG: KMSAN: uninit-value in lec_arp_update net/atm/lec.c:1845 [inline]
> > >  lec_arp_update net/atm/lec.c:1845 [inline]
> > >  lec_atm_send+0x2b02/0x55b0 net/atm/lec.c:385
> > >  vcc_sendmsg+0x1052/0x1190 net/atm/common.c:650
> > >
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Reported-by: syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=5dd615f890ddada54057
> > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > ---
> > > v3:
> > >   - update coding style and practices
> > > v2: https://lore.kernel.org/all/tencent_E83074AB763967783C9D36949674363C4A09@qq.com/
> > >   - update subject and comments for pre_send
> > > v1: https://lore.kernel.org/all/tencent_B31D1B432549BA28BB5633CB9E2C1B124B08@qq.com
> > 
> > FTR, a similar patch has been posted by Dharanitharan (CCed)
> Didn't you check the dates? I released the third version of the patch
> on December 4th (the first version was on November 28th), while this
> person above released their first version of the patch on December 7th.
> Their patch is far too similar to mine!

Yes, I was aware of the timeline when I wrote my previous email.

My preference is for some consensus to be reached on the way forward:
both technically and in terms of process.

