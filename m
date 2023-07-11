Return-Path: <netdev+bounces-16977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BAF74FB74
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 00:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B43281551
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 22:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4521EA76;
	Tue, 11 Jul 2023 22:56:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAE3182D0
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 22:56:42 +0000 (UTC)
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A41310DF
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 15:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689116201; x=1720652201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y+qnV3OCFHWd50ua7CBHDeY2WGrf3SruMwH96ymp+3s=;
  b=tgl31Tp/OduobOO/pHSSVZNyte5pqJ47TNsI9+aKcDApOP/P1yf8aCbR
   V2Bi2JQHOvbbdG0UqJrn9DNAq5f+9BGJKmPWSSu93848x1b1QTKS2hsGU
   8mrDPzvVxypvAikOnHw8s+rv49ldNZ+WrvgWmRPtDOAqaX38PhCkmjGv7
   U=;
X-IronPort-AV: E=Sophos;i="6.01,197,1684800000"; 
   d="scan'208";a="659340202"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 22:56:35 +0000
Received: from EX19MTAUWB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com (Postfix) with ESMTPS id F302680FF5;
	Tue, 11 Jul 2023 22:56:34 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 11 Jul 2023 22:56:34 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 11 Jul 2023 22:56:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <hcoin@quietfountain.com>
CC: <andrew@lunn.ch>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: llc needs namespace awareness asap, was Re: Patch fixing STP if bridge in non-default namespace.
Date: Tue, 11 Jul 2023 15:56:24 -0700
Message-ID: <20230711225624.85902-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <0f531295-e289-022d-5add-5ceffa0df9bc@quietfountain.com>
References: <0f531295-e289-022d-5add-5ceffa0df9bc@quietfountain.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.35]
X-ClientProxiedBy: EX19D041UWA004.ant.amazon.com (10.13.139.9) To
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
Date: Tue, 11 Jul 2023 17:44:20 -0500
> On 7/11/23 16:51, Kuniyuki Iwashima wrote:
> > From: Harry Coin<hcoin@quietfountain.com>
> > Date: Tue, 11 Jul 2023 16:40:03 -0500
> >> On 7/11/23 15:44, Andrew Lunn wrote:
> >>>>>>>> The current llc_rcv.c around line 166 in net/llc/llc_input.c  has
> >>>>>>>>
> >>>>>>>>             if (!net_eq(dev_net(dev), &init_net))
> >>>>>>>>                     goto drop;
> >>>>>>>>
> >>>> Thank you!  When you offer your patches, and you hear worries about being
> >>>> 'invasive', it's worth asking 'compared to what' -- since the 'status quo'
> >>>> is every bridge with STP in a non default namespace with a loop in it
> >>>> somewhere will freeze every connected system more solid than ice in
> >>>> Antarctica.
> >>> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> >>>
> >>> say:
> >>>
> >>> o It must be obviously correct and tested.
> >>> o It cannot be bigger than 100 lines, with context.
> >>> o It must fix only one thing.
> >>> o It must fix a real bug that bothers people (not a, "This could be a problem..." type thing).
> >>>
> >>> git blame shows:
> >>>
> >>> commit 721499e8931c5732202481ae24f2dfbf9910f129
> >>> Author: YOSHIFUJI Hideaki<yoshfuji@linux-ipv6.org>
> >>> Date:   Sat Jul 19 22:34:43 2008 -0700
> >>>
> >>>       netns: Use net_eq() to compare net-namespaces for optimization.
> >>>
> >>> diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
> >>> index 1c45f172991e..57ad974e4d94 100644
> >>> --- a/net/llc/llc_input.c
> >>> +++ b/net/llc/llc_input.c
> >>> @@ -150,7 +150,7 @@ int llc_rcv(struct sk_buff *skb, struct net_device *dev,
> >>>           int (*rcv)(struct sk_buff *, struct net_device *,
> >>>                      struct packet_type *, struct net_device *);
> >>>    
> >>> -       if (dev_net(dev) != &init_net)
> >>> +       if (!net_eq(dev_net(dev), &init_net))
> >>>                   goto drop;
> >>>    
> >>>           /*
> >>>
> >>> So this is just an optimization.
> >>>
> >>> The test itself was added in
> >>>
> >>> ommit e730c15519d09ea528b4d2f1103681fa5937c0e6
> >>> Author: Eric W. Biederman<ebiederm@xmission.com>
> >>> Date:   Mon Sep 17 11:53:39 2007 -0700
> >>>
> >>>       [NET]: Make packet reception network namespace safe
> >>>       
> >>>       This patch modifies every packet receive function
> >>>       registered with dev_add_pack() to drop packets if they
> >>>       are not from the initial network namespace.
> >>>       
> >>>       This should ensure that the various network stacks do
> >>>       not receive packets in a anything but the initial network
> >>>       namespace until the code has been converted and is ready
> >>>       for them.
> >>>       
> >>>       Signed-off-by: Eric W. Biederman<ebiederm@xmission.com>
> >>>       Signed-off-by: David S. Miller<davem@davemloft.net>
> >>>
> >>> So that was over 15 years ago.
> >>>
> >>> It appears it has not bothered people for over 15 years.
> >>>
> >>> Lets wait until we get to see the actual fix. We can then decide how
> >>> simple/hard it is to back port to stable, if it fulfils the stable
> >>> rules or not.
> >>>
> >>>         Andrew
> >> Andrew, fair enough.  In the time until it's fixed, the kernel folks
> >> should publish an advisory and block any attempt to set bridge stp state
> >> to other than 0 if in a non-default namespace. The alternative is a
> >> packet flood at whatever the top line speed is should there be a loop
> >> somewhere in even one connected link.
> > Like this ?  Someone who didn't notice the issue might complain about
> > it as regression.
> >
> > ---8<---
> > diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
> > index 75204d36d7f9..a807996ac56b 100644
> > --- a/net/bridge/br_stp_if.c
> > +++ b/net/bridge/br_stp_if.c
> > @@ -201,6 +201,11 @@ int br_stp_set_enabled(struct net_bridge *br, unsigned long val,
> >   {
> >   	ASSERT_RTNL();
> >   
> > +	if (!net_eq(dev_net(br->dev), &init_net)) {
> > +		NL_SET_ERR_MSG_MOD(extack, "STP can't be enabled in non-root netns");
> > +		return -EINVAL;
> > +	}
> > +
> >   	if (br_mrp_enabled(br)) {
> >   		NL_SET_ERR_MSG_MOD(extack,
> >   				   "STP can't be enabled if MRP is already enabled");
> > ---8<---
> 
> Something like that, but to your point about regression -- It a 
> statistically good bet there are many bridges with STP enabled in 
> non-default name spaces that simply have no loops in L2 BUT these are 
> 'buried'  inside docker images or prepackaged setups that work 'just 
> fine standalone' and also 'in lab namespaces (that just don't have L2 
> loops...) and so that don't hit the bug.  These users are one "cable 
> click to an open port already connected somewhere they can't see" away 
> from bringing down every computer on their entire link (like me, been 
> there, it's not a happy week for anyone...), they just don't know it.  
> And their vendors 'trust STP, so that can't be it' --- but it is.
> 
> If the patch above gets installed-- then packagers downstream will have 
> to respond with effort to add code to turn off STP if finding themselves 
> in a namespace, and not if not.   They will be displeased at having to 
> accommodate then de-accommodate when the fix lands.   As a 'usually 
> downstream of the kernel' developer, I'd rather be warned than blocked.

Ok, will post the diff above as a formal patch shortly.


> 
> Looking at those dates... wow!  I expect other os kernels and standalone 
> switch vendors would see fixing this one as a removing a reliability 
> advantage they've had for a long time.
> 
> Perhaps a broadcast advisory "Until this is fixed, your site will have a 
> packet flood worse than an internal DDOS attack if there's a loop in a 
> link layer and if even one docker image or prepackaged project uses a 
> net bridge with STP enabled and is deployed in a non-default netns / net 
> namespace.   Check with your package vendors if you're not sure.  You'll 
> avoid this problem if your link layer layout chart is tree-and-branch 
> without even one crosslink."   Yup, that'll be somewhat less than 
> popular.  But better warned and awaiting a fix than blocked.
> 
> How hard can the fix be?  Instead of dropping the packet if in the 
> non-default namespace, as each device is in a namespace it should be 
> fine to pass the packet only to listeners in the same namespace as the 
> device that received the packet.  Back in the day this code was written, 
> it was probably 'hard to know' among the multicast subscribers what 
> namespace they were in.
> 
>   I suspect the impact of this fix on existing code will be minor since 
> the only effect will be packets appearing where they were expected 
> before but not received.

Looking around the code, fixing the issue will not be so hard,
but we should be careful so that we will not leak frames that
should have been invisible.

