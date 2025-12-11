Return-Path: <netdev+bounces-244328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0F0CB4F21
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 07:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EFB43005FFA
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 06:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF87B29C328;
	Thu, 11 Dec 2025 06:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="GSQn2mJN"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29512285C8C;
	Thu, 11 Dec 2025 06:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765436231; cv=none; b=Hb0I0VrZ2GXhn3Gz56Qq80yMKYD5JNIFz9Kdctmm0bvHGvcmFJn6Wy/5TxYTWD8c9sDNSN73oFRKkH7E342lFQl4gDtWD1GV3njShkTz10eKNndxGoVcDFVTgv1yMMg9YjrbGaKEdsnU/GBukYRkzi4q8XoVc2YJ2RhRawae3VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765436231; c=relaxed/simple;
	bh=dLdC6eLIidNFyGFZn6+viSJ/nhS8FJ69TAs/ybdDS1k=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=azNvwosYqbtu2pyqLYLlwwP/GgjPDIGf7GZZogwSuUsKrPSKX/9n/BcSsZ70czvTpu9tUYRXJOo9TVa8EQtmvWKoWSX+uI8I52O/QSo5QdXqyR759Y/qqHS7xR0YAhBxRu28SNvKT3FhWZ+pYtmvzMJM6yoqPqaqbtnwvWIZKSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=GSQn2mJN; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1765436219; bh=SNtRta4kDzBbYL5hbL8sEoGkhm6rnwmjsdYj6RTtqbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GSQn2mJNWY7+IrgLiOOWg49Npalx3tvm+7egGXL7c7ABRcVYu5jynZYOtKM4iieOU
	 yH6y5N8o2/8k1Woc0FPAct5dTt69KjIl5U23DDm2EzmdqRlZAAReS6P5pwt6cjwPdZ
	 ldbi8zPxJiJmwqWoa3Dp26CeKJQ0BRElV+XiMzgc=
Received: from lxu-ped-host.. ([111.201.7.117])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id DED130A6; Thu, 11 Dec 2025 14:55:45 +0800
X-QQ-mid: xmsmtpt1765436145ti6j9884e
Message-ID: <tencent_58BAB3BB5133049EA81B004B7D1B0D255508@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnL6Bwp0Vxd3dONlXuUkExXRwucpb3lq7lH5upI7c3nXMtezr25ru
	 1AUkeULm5H7XjaPFvybrEZ/f2S1rrQ2LbewlI+/nakDxZQc+G+PZoudWTXVTRYh2jIArM+liXqjp
	 oty+mtGMTvX5zEQggvxQ/VkJn40JZTLMWrrbQ9bEwQvbt+ve+VZahoUbBJbKnBSr9x7vYx/jw3ZH
	 YEELae/o2rJPgQYy4bYggJs7vhTC+IRmN/Dn3mmr9k2DQ/zetbvOx3fJ9Itk5M+xP7DUZ5ZUuqU1
	 DmDDIngd+5Q7KVzwfyqPd1M/CgjMUKarOHbXXZqoWxA8QWUGtKyq98DpKwV/Xq4txW+S8J6NEjT8
	 tatXh69i/r+QMfEBsCE/dKlJxbcTIhQYdC4jitl8ZAZ5CVZJkOrLWAfPqnaEHveyozG7lMhRZC+q
	 VrJv5f4TvhKBqyaStXZ8dNF4TR7W8NGo57A5Ma+oKiaQsl1y9/EJvItIuS9ZPC5hqVz8LfDueJpR
	 /BRNedfrU0xASnBcPA2KIUjElMOB3EwpLBBAQADaWqgs1mvqQXOAPCPIN78p9uuBDW8K+9fgT8q9
	 h+cZKsuybmRmW+6xNsyBhKGoJ4SbN4ucTQnmpfOCHxDizOcZJiE2gmMIEQTxpakOMIdHn9NWQALH
	 kd2mQ2eatQ+3JCFU4STXBDBCneNRXPpTwCp1929rbhF7pd84o+Ewoyyb3y198XFDYIq+33riL4U4
	 ZEXHXk4+FnsTxZJFBRYQe3ZkScfWd5kcnAhdEIwybXnBP8e7gF2ayNiak8L2DNmDaX7Jq2YVntoa
	 P18iOo4Mu4rkpJNWjSyS5FsXD0z0166xcBhHBwP0vYT1Cycv/UBTjPNJ+7P9XtyYq1V/vepE/29U
	 7k3wLwmMNbL6B5l2I2mSEEpslwaWLwyhTYvGRTkdkh50H514uFs9pfe3Gf3Maus+gOX+ZK+5XHCI
	 Qm/tgi3IBRQ6swPca4uHx7jcGk3xzqWggi/XfCQS1XUsP2Su1iG4Ehc3XBQnIvaYtrasPJU1lh3U
	 30HXbRoe5B9DAPSnVH
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: horms@kernel.org
Cc: davem@davemloft.net,
	eadavis@qq.com,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net v3] net: atm: implement pre_send to check input before sending
Date: Thu, 11 Dec 2025 14:55:45 +0800
X-OQ-MSGID: <20251211065544.40903-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aTlvgIS6TxZ_Q5zE@horms.kernel.org>
References: <aTlvgIS6TxZ_Q5zE@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 10 Dec 2025 13:02:56 +0000, Simon Horman wrote:
> On Wed, Dec 10, 2025 at 06:50:02PM +0800, Edward Adam Davis wrote:
> > Sun, Wed, 10 Dec 2025 10:31:34 +0000, Simon Horman wrote:
> > > > syzbot found an uninitialized targetless variable. The user-provided
> > > > data was only 28 bytes long, but initializing targetless requires at
> > > > least 44 bytes. This discrepancy ultimately led to the uninitialized
> > > > variable access issue reported by syzbot [1].
> > > >
> > > > Besides the issues reported by syzbot regarding targetless messages
> > > > [1], similar problems exist in other types of messages as well. We will
> > > > uniformly add input data checks to pre_send to prevent uninitialized
> > > > issues from recurring.
> > > >
> > > > Additionally, for cases where sizeoftlvs is greater than 0, the skb
> > > > requires more memory, and this will also be checked.
> > > >
> > > > [1]
> > > > BUG: KMSAN: uninit-value in lec_arp_update net/atm/lec.c:1845 [inline]
> > > >  lec_arp_update net/atm/lec.c:1845 [inline]
> > > >  lec_atm_send+0x2b02/0x55b0 net/atm/lec.c:385
> > > >  vcc_sendmsg+0x1052/0x1190 net/atm/common.c:650
> > > >
> > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > Reported-by: syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com
> > > > Closes: https://syzkaller.appspot.com/bug?extid=5dd615f890ddada54057
> > > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > > ---
> > > > v3:
> > > >   - update coding style and practices
> > > > v2: https://lore.kernel.org/all/tencent_E83074AB763967783C9D36949674363C4A09@qq.com/
> > > >   - update subject and comments for pre_send
> > > > v1: https://lore.kernel.org/all/tencent_B31D1B432549BA28BB5633CB9E2C1B124B08@qq.com
> > >
> > > FTR, a similar patch has been posted by Dharanitharan (CCed)
> > Didn't you check the dates? I released the third version of the patch
> > on December 4th (the first version was on November 28th), while this
> > person above released their first version of the patch on December 7th.
> > Their patch is far too similar to mine!
> 
> Yes, I was aware of the timeline when I wrote my previous email.
> 
> My preference is for some consensus to be reached on the way forward:
> both technically and in terms of process.
I'm a little confused. Why are you explaining the process to someone
who submitted a patch 99% similar to mine, just a few days after I did?


