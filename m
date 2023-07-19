Return-Path: <netdev+bounces-19114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96114759C65
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9520F1C2102F
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 17:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B13D1FB56;
	Wed, 19 Jul 2023 17:30:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9851FB2E
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 17:30:36 +0000 (UTC)
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE59CE69;
	Wed, 19 Jul 2023 10:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689787835; x=1721323835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TQcUan7l1y5Yv0vldMssZE2G80VjsCzDArJ5W4+oGwY=;
  b=cQbmiFa/rdWZsFmxpWCHNp9LK+JoCbJa6H7jRoBc2eupM8mRmxh8BM1M
   FeaH8s3/KytBWpr+g9F1us9786NICnExLVJ7I9+bVT1OuSgA9vU1jJrMw
   NVsGuWVP41kOhkq8aWM1EABv3RQ+ZPVd7hfmXaiM8SF0SYWCZyDltBbTt
   A=;
X-IronPort-AV: E=Sophos;i="6.01,216,1684800000"; 
   d="scan'208";a="345522651"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-a893d89c.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 17:30:31 +0000
Received: from EX19MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2b-m6i4x-a893d89c.us-west-2.amazon.com (Postfix) with ESMTPS id F2D4740D58;
	Wed, 19 Jul 2023 17:30:29 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 19 Jul 2023 17:30:29 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Wed, 19 Jul 2023 17:30:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <alexander@mihalicyn.com>, <ast@kernel.org>, <davem@davemloft.net>,
	<dhowells@redhat.com>, <edumazet@google.com>, <kernelxing@tencent.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <leit@meta.com>,
	<linux-kernel@vger.kernel.org>, <lucien.xin@gmail.com>,
	<martin.lau@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: Use _K_SS_MAXSIZE instead of absolute value
Date: Wed, 19 Jul 2023 10:30:17 -0700
Message-ID: <20230719173017.33951-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ZLga+cBUKkN5Fnn7@gmail.com>
References: <ZLga+cBUKkN5Fnn7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.39]
X-ClientProxiedBy: EX19D036UWB001.ant.amazon.com (10.13.139.133) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Breno Leitao <leitao@debian.org>
Date: Wed, 19 Jul 2023 10:18:49 -0700
> On Wed, Jul 19, 2023 at 10:04:45AM -0700, Kuniyuki Iwashima wrote:
> > From: Breno Leitao <leitao@debian.org>
> > Date: Wed, 19 Jul 2023 01:44:12 -0700
> > > Looking at sk_getsockopt function, it is unclear why 128 is a magical
> > > number.
> > > 
> > > Use the proper macro, so it becomes clear to understand what the value
> > > mean, and get a reference where it is coming from (user-exported API).
> > > 
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > ---
> > >  net/core/sock.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > index 9370fd50aa2c..58b6f00197d6 100644
> > > --- a/net/core/sock.c
> > > +++ b/net/core/sock.c
> > > @@ -1815,7 +1815,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
> > >  
> > >  	case SO_PEERNAME:
> > >  	{
> > > -		char address[128];
> > > +		char address[_K_SS_MAXSIZE];
> > 
> > I guess you saw a bug caught by the fortified memcpy(), but this
> > doesn't fix it properly.
> 
> Not really, in fact. I was reading this code, and I found this
> discussion a while ago, where I got the idea:
> 
> https://lore.kernel.org/lkml/20140930.005925.995989898229686123.davem@davemloft.net/

I got it, but I prefer using struct sockaddr_storage as done in
other places.

  $ grep -rn sockaddr_storage net/

Also, there would be some situations where we must cast each
family-specific address back to sockaddr_storage for fortified
library.

Then, it makes more sense to use sockaddr_storage rather than
_K_SS_MAXSIZE.

