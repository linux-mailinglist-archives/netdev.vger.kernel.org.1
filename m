Return-Path: <netdev+bounces-16974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B6674FA24
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 23:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F052817E3
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 21:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2361ED34;
	Tue, 11 Jul 2023 21:51:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF8A1DDEE
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 21:51:53 +0000 (UTC)
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94A210C7
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 14:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689112312; x=1720648312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w2/rkcKWyutIqP+eQIHwkSv5dzQrtUSyt752Jipk/Pg=;
  b=eHPN1tfkyY8uYuscez39BoqMZt5PHWSE3uJt5/XKII2mCo3ehQ7NgKU2
   6SFbj1dMyvhKy+W0pTYyEgorGy20Z7r+WF+Xqohy66hEGlLewjfqkbXmB
   o5lB1AqN3oakww2zJR2ebwG1aV6g1bCVnegbnm8yDSCIqOYijR5+tmtVI
   w=;
X-IronPort-AV: E=Sophos;i="6.01,197,1684800000"; 
   d="scan'208";a="142149319"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-00fceed5.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 21:51:50 +0000
Received: from EX19MTAUWB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1d-m6i4x-00fceed5.us-east-1.amazon.com (Postfix) with ESMTPS id 8BC69A0A7E;
	Tue, 11 Jul 2023 21:51:49 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 11 Jul 2023 21:51:42 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 11 Jul 2023 21:51:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <hcoin@quietfountain.com>
CC: <andrew@lunn.ch>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: llc needs namespace awareness asap, was Re: Patch fixing STP if bridge in non-default namespace.
Date: Tue, 11 Jul 2023 14:51:32 -0700
Message-ID: <20230711215132.77594-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <9190b2ac-a3f7-d4f5-211a-ea860f09687a@quietfountain.com>
References: <9190b2ac-a3f7-d4f5-211a-ea860f09687a@quietfountain.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.35]
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Harry Coin <hcoin@quietfountain.com>
Date: Tue, 11 Jul 2023 16:40:03 -0500
> On 7/11/23 15:44, Andrew Lunn wrote:
> >>>>>> The current llc_rcv.c around line 166 in net/llc/llc_input.c  has
> >>>>>>
> >>>>>>            if (!net_eq(dev_net(dev), &init_net))
> >>>>>>                    goto drop;
> >>>>>>
> >> Thank you!  When you offer your patches, and you hear worries about being
> >> 'invasive', it's worth asking 'compared to what' -- since the 'status quo'
> >> is every bridge with STP in a non default namespace with a loop in it
> >> somewhere will freeze every connected system more solid than ice in
> >> Antarctica.
> > https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> >
> > say:
> >
> > o It must be obviously correct and tested.
> > o It cannot be bigger than 100 lines, with context.
> > o It must fix only one thing.
> > o It must fix a real bug that bothers people (not a, "This could be a problem..." type thing).
> >
> > git blame shows:
> >
> > commit 721499e8931c5732202481ae24f2dfbf9910f129
> > Author: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
> > Date:   Sat Jul 19 22:34:43 2008 -0700
> >
> >      netns: Use net_eq() to compare net-namespaces for optimization.
> >
> > diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
> > index 1c45f172991e..57ad974e4d94 100644
> > --- a/net/llc/llc_input.c
> > +++ b/net/llc/llc_input.c
> > @@ -150,7 +150,7 @@ int llc_rcv(struct sk_buff *skb, struct net_device *dev,
> >          int (*rcv)(struct sk_buff *, struct net_device *,
> >                     struct packet_type *, struct net_device *);
> >   
> > -       if (dev_net(dev) != &init_net)
> > +       if (!net_eq(dev_net(dev), &init_net))
> >                  goto drop;
> >   
> >          /*
> >
> > So this is just an optimization.
> >
> > The test itself was added in
> >
> > ommit e730c15519d09ea528b4d2f1103681fa5937c0e6
> > Author: Eric W. Biederman <ebiederm@xmission.com>
> > Date:   Mon Sep 17 11:53:39 2007 -0700
> >
> >      [NET]: Make packet reception network namespace safe
> >      
> >      This patch modifies every packet receive function
> >      registered with dev_add_pack() to drop packets if they
> >      are not from the initial network namespace.
> >      
> >      This should ensure that the various network stacks do
> >      not receive packets in a anything but the initial network
> >      namespace until the code has been converted and is ready
> >      for them.
> >      
> >      Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> >      Signed-off-by: David S. Miller <davem@davemloft.net>
> >
> > So that was over 15 years ago.
> >
> > It appears it has not bothered people for over 15 years.
> >
> > Lets wait until we get to see the actual fix. We can then decide how
> > simple/hard it is to back port to stable, if it fulfils the stable
> > rules or not.
> >
> >        Andrew
> 
> Andrew, fair enough.  In the time until it's fixed, the kernel folks 
> should publish an advisory and block any attempt to set bridge stp state 
> to other than 0 if in a non-default namespace. The alternative is a 
> packet flood at whatever the top line speed is should there be a loop 
> somewhere in even one connected link.

Like this ?  Someone who didn't notice the issue might complain about
it as regression.

---8<---
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index 75204d36d7f9..a807996ac56b 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -201,6 +201,11 @@ int br_stp_set_enabled(struct net_bridge *br, unsigned long val,
 {
 	ASSERT_RTNL();
 
+	if (!net_eq(dev_net(br->dev), &init_net)) {
+		NL_SET_ERR_MSG_MOD(extack, "STP can't be enabled in non-root netns");
+		return -EINVAL;
+	}
+
 	if (br_mrp_enabled(br)) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "STP can't be enabled if MRP is already enabled");
---8<---

