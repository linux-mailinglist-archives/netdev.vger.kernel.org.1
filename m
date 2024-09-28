Return-Path: <netdev+bounces-130169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0B6988D16
	for <lists+netdev@lfdr.de>; Sat, 28 Sep 2024 02:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07F5EB21900
	for <lists+netdev@lfdr.de>; Sat, 28 Sep 2024 00:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A722223AB;
	Sat, 28 Sep 2024 00:07:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail115-80.sinamail.sina.com.cn (mail115-80.sinamail.sina.com.cn [218.30.115.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C9D23A6
	for <netdev@vger.kernel.org>; Sat, 28 Sep 2024 00:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727482038; cv=none; b=QLtk4/DAtsm4ZJCVTddev95zB0Eomkha8Kr1o60WNJIVzZ/6PTLlVpJjyD5/7bk/IFrSlH6rM4TkcRbq+dBiCvdBvJTDPnZfHj6bR+79TMAv6wH6WMRjHSkIqAKyd427ZzIuuMM9I5cshAvqQf+SJTOlh8sVpc6DsY2ZYklr200=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727482038; c=relaxed/simple;
	bh=TDLqSD+lw4KY1+l7lU2eWWFIt//CZcprmLjdRyTXGTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f1dWxS3lIALRsh6H8Azcn0RkPPCiWx/pnvkkBqUUOnGgpJDVb8f/JR4wKrrWD2BAIo+Mxt6KTy+tP94KHJvQAF0oBm4TxgNc60NDAXKwc9UTaNrZT8fDxogfxv2jpHVdmfMSV/7JtgogqxxwoLbmdbeB035HwVomLilHYMAKc8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.8.191])
	by sina.com (10.185.250.23) with ESMTP
	id 66F748AB000065D5; Sat, 28 Sep 2024 08:07:09 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8986698913264
X-SMAIL-UIID: 7D19F44053FF4BA6B5F3BEF716CC94AF-20240928-080709-1
From: Hillf Danton <hdanton@sina.com>
To: Eric Dumazet <edumazet@google.com>
Cc: syzbot <syzbot+05f9cecd28e356241aba@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Boqun Feng <boqun.feng@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] INFO: task hung in new_device_store (5)
Date: Sat, 28 Sep 2024 08:06:57 +0800
Message-Id: <20240928000657.1247-1-hdanton@sina.com>
In-Reply-To: <CANn89iJMHqg4e_tErTERx=-ERXbA+CRbeC0chp9ofqANwwjhLA@mail.gmail.com>
References: <66f5a0ca.050a0220.46d20.0002.GAE@google.com> <CANn89iKLTNs5LAuSz6xeKB39hQ2FOEJNmffZsv1F3iNHqXe0tQ@mail.gmail.com> <20240927110422.1084-1-hdanton@sina.com> <CANn89iLKhw-X-gzCJHgpEXe-1WuqTmSWLGOPf5oy1ZMkWyW9_w@mail.gmail.com> <20240927114158.1190-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 27 Sep 2024 13:54:59 +0200 Eric Dumazet <edumazet@google.com>
> On Fri, Sep 27, 2024 at 1:44 PM Hillf Danton <hdanton@sina.com> wrote:
> >
> > On Fri, 27 Sep 2024 13:24:54 +0200 Eric Dumazet <edumazet@google.com>
> > > I suggest you look at why we have to use rtnl_trylock()
> > >
> > > If you know better, please send patches to remove all instances.
> >
> > No patch is needed before you show us deadlock. I suspect you could
> > spot a case where lockdep fails to report deadlock.
> 
> Please try to not educate maintainers about their stuff.
> 
Is this the typical dude style in Paris when showing deadlock?

> lockdep is usually right. And here there is an actua syzbot report.

The word maintainer is abused in this case.

