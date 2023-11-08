Return-Path: <netdev+bounces-46680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 575D27E5C95
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 18:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC060B20BF8
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 17:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90322328D2;
	Wed,  8 Nov 2023 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Vfuj33OK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB8E3067F
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 17:45:43 +0000 (UTC)
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CDD1BD4;
	Wed,  8 Nov 2023 09:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1699465544; x=1731001544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AK1H4ZliE+KrTVct4+YI0xIeUq39oi6R9KO0Gwj6lOo=;
  b=Vfuj33OKkbs6ipC97GixWiJ3Su5TZWbNQ4T5m+nzYivLe3lvss6jWn2b
   hyCp0hbc0S5KWHM5mViwa97kjXJailXhJ9aykQA5W5on4Qy4hbI/CJ28n
   2fLPTYhml+wZzdirPq02IpcKu2VGgOe3Sf+cVMhvO+vUQY3oFYgCbFSi9
   E=;
X-IronPort-AV: E=Sophos;i="6.03,286,1694736000"; 
   d="scan'208";a="369205610"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 17:45:40 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com (Postfix) with ESMTPS id 3CE9A80728;
	Wed,  8 Nov 2023 17:45:38 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:5790]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.241:2525] with esmtp (Farcaster)
 id c63ccabf-3b4a-4598-82c4-8b129f1bdbfb; Wed, 8 Nov 2023 17:45:37 +0000 (UTC)
X-Farcaster-Flow-ID: c63ccabf-3b4a-4598-82c4-8b129f1bdbfb
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 8 Nov 2023 17:45:37 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.39;
 Wed, 8 Nov 2023 17:45:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <dw@davidwei.uk>
CC: <avagin@gmail.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzbot+71e724675ba3958edb31@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] WARNING in inet_csk_get_port (2)
Date: Wed, 8 Nov 2023 09:45:25 -0800
Message-ID: <20231108174525.1452-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1d1f7518-6ff9-4402-a874-5c0138bedefd@davidwei.uk>
References: <1d1f7518-6ff9-4402-a874-5c0138bedefd@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.100.12]
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: David Wei <dw@davidwei.uk>
Date: Wed, 8 Nov 2023 08:11:56 -0800
> On 2023-09-20 11:59, Kuniyuki Iwashima wrote:
> > From: syzbot <syzbot+71e724675ba3958edb31@syzkaller.appspotmail.com>
> > Date: Wed, 20 Sep 2023 11:02:55 -0700
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    2cf0f7156238 Merge tag 'nfs-for-6.6-2' of git://git.linux-..
> >> git tree:       upstream
> >> console+strace: https://syzkaller.appspot.com/x/log.txt?x=17405ab0680000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=d594086f139d167
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=71e724675ba3958edb31
> >> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b2e118680000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=127b55c4680000
> >>
> >> Downloadable assets:
> >> disk image: https://storage.googleapis.com/syzbot-assets/456b02029fa8/disk-2cf0f715.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/9f9ff0c00454/vmlinux-2cf0f715.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/0ede19fba30f/bzImage-2cf0f715.xz
> >>
> >> The issue was bisected to:
> >>
> >> commit c48ef9c4aed3632566b57ba66cec6ec78624d4cb
> >> Author: Kuniyuki Iwashima <kuniyu@amazon.com>
> >> Date:   Mon Sep 11 18:36:57 2023 +0000
> >>
> >>     tcp: Fix bind() regression for v4-mapped-v6 non-wildcard address.
> >>
> > 
> > We need this condition to put v4 sk and v4-mapped-v6 sk into
> > the same bucket.
> > 
> > ---8<---
> > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> > index dfb1c61c0c2b..6487357d1ddd 100644
> > --- a/net/ipv4/inet_hashtables.c
> > +++ b/net/ipv4/inet_hashtables.c
> > @@ -822,7 +823,8 @@ static bool inet_bind2_bucket_match(const struct inet_bind2_bucket *tb,
> >  			return ipv6_addr_v4mapped(&tb->v6_rcv_saddr) &&
> >  				tb->v6_rcv_saddr.s6_addr32[3] == sk->sk_rcv_saddr;
> >  
> > -		return false;
> > +		return ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr) &&
> > +			sk->sk_v6_rcv_saddr.s6_addr32[3] == tb->rcv_saddr;
> >  	}
> >  
> >  	if (sk->sk_family == AF_INET6)
> > ---8<---
> > 
> > Scenario is like
> > 
> >   1) bind(v4) creates a tb2 bucket
> >   2) bind(v4-mapped-v6) creates another tb2 bucket
> >   3) listen(v4) finds the second tb2 and trigger warning
> > 
> > ---8<---
> > from socket import *
> > 
> > s = socket()
> > s.setsockopt(SOL_SOCKET, SO_REUSEPORT, 1)
> > s.bind(('255.255.255.255', 0))
> > 
> > s2 = socket(AF_INET6, SOCK_STREAM)
> > s2.setsockopt(SOL_SOCKET, SO_REUSEPORT, 1)
> > s2.bind(('::ffff:255.255.255.255', s.getsockname()[1]))
> > s.listen()
> > ---8<---
> > 
> > Will post a formal patch after doing more tests with SO_REUSEPORT.
> > 
> > Thanks!
> 
> Hi Kuniyuki, did you get around to fixing and posting this patch? I
> couldn't find anything on the mailing list.
> 
> Would you like help fixing this?

Hi,

It's fixed by this patch.
https://lore.kernel.org/netdev/20231010013814.70571-1-kuniyu@amazon.com/

Thanks

