Return-Path: <netdev+bounces-121847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAF195F03B
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 13:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B13E28399C
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 11:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD02156678;
	Mon, 26 Aug 2024 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aUBMN8fI"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721FB14D2BD;
	Mon, 26 Aug 2024 11:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673450; cv=none; b=ZhFrs1hL1Lq4xrBX6rIKcwapJFAI/QB2TIcIswMqeatFMy5p5FYIoj4mqne0i3iHXjitbUoUd94J40XtSX3jerCGNhEV071iYSh5YBJVucPeckjBoxhS/hnM0hHk9n4NJYscMnnuNVYidIOIreV/jqyuXZzobOg806W85ee/JBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673450; c=relaxed/simple;
	bh=KCbUD9eH8LCzhGdlsLFe73vocWOdGRnaS8Xa1UMb09c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nv9SZf0Defe+DHRkiO/t32QGZL0/ZQT/QFv0LJWWXwEe0Umet5TNudZQM0LNIUcwnPy+Qs6j9VYW49TqZMsIxjOAqvlSrB/f0VqRLNi9hGcSVsMaTVAAhN0f1AcKj6AZW36WdVZdb9nD3kvioq4oiYirdgrhMXrmXvbCRfkp2fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aUBMN8fI; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9E2F4C000C;
	Mon, 26 Aug 2024 11:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724673446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ixB3mCKx/2c6H/MOtHpN24XKXD01J8jwLAN4TJa5ds=;
	b=aUBMN8fIUXdfW0ieqoSZM0/uQJNAre2Q9/Fq5urCYMXIRoGAbhBlzMTS8t7fo4V1EUvCtl
	WXfigiHTLJMcx8XU0NCQfcHad0PRDlOGzyyQ9Mqq5gwd2etYBsQ1I/Bgc5EfN48+A1OWbf
	UP1WNZDOf9nL/SZo49cDzFT6uyVf+nVZ6p3JPYzb1yqvs6ff/oZ7j3JXgjgJC/ML2pXaEy
	KhbBAKnOim0NQTcrltWXI3ENkqpUA1EXSl2dr3Ll5u9mXborOuI46zsWkkeoFrIaPsd7GD
	ZAxxOt9/v8y1nUrWUTVxqgTQJ+q5iZde/tSZ9Qi2qBDxCXcJvnZrovRgvuywMQ==
Date: Mon, 26 Aug 2024 13:57:23 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: syzbot <syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com>
Cc: andrew@lunn.ch, christophe.leroy@csgroup.eu, danieller@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kory.maincent@bootlin.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, petrm@nvidia.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in ethnl_req_get_phydev
Message-ID: <20240826135723.32c5aa58@fedora-3.home>
In-Reply-To: <0000000000004168390620923787@google.com>
References: <0000000000004168390620923787@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello,

On Mon, 26 Aug 2024 01:50:24 -0700
syzbot <syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f9db28bb09f4 Merge branch 'net-redundant-judgments'
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1051fa7b980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=df2f0ed7e30a639d
> dashboard link: https://syzkaller.appspot.com/bug?extid=ec369e6d58e210135f71
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113da825980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d5f229980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/585e02f7fe7b/disk-f9db28bb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b9faf5d24900/vmlinux-f9db28bb.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/f9df5868ea4f/bzImage-f9db28bb.xz
> 
> The issue was bisected to:
> 
> commit 31748765bed3fb7cebf4a32b43a6fdf91b9c23de
> Author: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Date:   Wed Aug 21 15:10:04 2024 +0000
> 
>     net: ethtool: pse-pd: Target the command to the requested PHY
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13d09047980000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=10309047980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=17d09047980000

Looks also like this is triggered because the validate callback doesn't
run under rtnl() as I wrongly assumed. I'll look into it.

Thanks,

Maxime

