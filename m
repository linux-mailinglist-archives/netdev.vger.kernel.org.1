Return-Path: <netdev+bounces-16944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDED74F80A
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 20:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39A4E2819C2
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 18:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE3F171D9;
	Tue, 11 Jul 2023 18:32:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819D71EA84
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 18:32:25 +0000 (UTC)
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035EB10F0
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 11:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689100345; x=1720636345;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JpesXDHQq6rlWtf6v3OWRB9DvB7TVblx3YFHpTuRBn8=;
  b=GL6xurDG4VFxBURUA6lWRtskRFs4XbkwJ365UjhvIVsuSeIlFX3TphFf
   4LrfHx0KwKQvcsCYhN3wRUsdQE74vHVguVmfsL6Jdcuua/rjuydfFY3pw
   5hMsrNc50eBoP6mwXM5eXM4G/Xu1eEOe9cj3h7o5bLv9yuHvtfNNoZnOd
   Y=;
X-IronPort-AV: E=Sophos;i="6.01,197,1684800000"; 
   d="scan'208";a="659292742"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-6e7a78d7.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 18:32:19 +0000
Received: from EX19MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
	by email-inbound-relay-iad-1e-m6i4x-6e7a78d7.us-east-1.amazon.com (Postfix) with ESMTPS id 701E280FC7;
	Tue, 11 Jul 2023 18:32:17 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 11 Jul 2023 18:32:16 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 11 Jul 2023 18:32:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <hcoin@quietfountain.com>
CC: <kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: llc needs namespace awareness asap, was Re: Patch fixing STP if bridge in non-default namespace.
Date: Tue, 11 Jul 2023 11:32:06 -0700
Message-ID: <20230711183206.54744-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <f01739c8-8f59-97d6-4edc-f2e88885bb73@quietfountain.com>
References: <f01739c8-8f59-97d6-4edc-f2e88885bb73@quietfountain.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.35]
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
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
Date: Tue, 11 Jul 2023 12:08:15 -0500
> On 7/10/23 22:22, Kuniyuki Iwashima wrote:
> > From: Harry Coin <hcoin@quietfountain.com>
> > Date: Mon, 10 Jul 2023 08:35:08 -0500
> >> Notice without access to link-level multicast address 01:80:C2:00:00:00,
> >> the STP loop-avoidance feature of bridges fails silently, leading to
> >> packet storms if loops exist in the related L2.  The Linux kernel's
> >> latest code silently drops BPDU STP packets if the bridge is in a
> >> non-default namespace.
> >>
> >> The current llc_rcv.c around line 166 in net/llc/llc_input.c  has
> >>
> >>          if (!net_eq(dev_net(dev), &init_net))
> >>                  goto drop;
> >>
> >> Which, when commented out, fixes this bug.  A search on &init_net may
> >> reveal many similar artifacts left over from the early days of namespace
> >> implementation.
> > I think just removing the part is not sufficient and will introduce a bug
> > in another place.
> >
> > As you found, llc has the same test in another place.  For example, when
> > you create an AF_LLC socket, it has to be in the root netns.  But if you
> > remove the test in llc_rcv() only, it seems llc_recv() would put a skb for
> > a child netns into sk's recv queue that is in the default netns.
> >
> >    - llc_rcv
> >      - if (net_eq(dev_net(dev), &init_net))
> >        - goto drop
> >      - sap_handler / llc_sap_handler
> >        - sk = llc_lookup_dgram
> >        - llc_sap_rcv
> >          - llc_sap_state_process
> > 	  - sock_queue_rcv_skb
> >
> > So, we need to namespacify the whole llc infra.
> 
> Agreed.  Probably sooner rather than later since IP4 and IP6 multicast, 
> GARP and more as well as STP depends on llc multicast delivery.   I 
> suspect the authors who added the 'drop unless default namespace' code 
> commented out above knew this, and were just buying some time.  Well, 
> the time has come.
> 
> Now all bridges in a namespace will always -- and silently -- think of 
> itself as the 'root bridge' as it can't get packets informing it 
> otherwise.  This leads to packet storms at line-level speeds bringing 
> whole infrastructures down in a self-inflicted event worse than a DDOS 
> attack.
> 
> I think whoever does 'advisories' ought to warn the community that ipv6 
> ndp (if using multicast), ipv4 arp (if using multicast), bridges with 
> STP, lldp, GARP, ipv6 multicast and ipv4 mulitcast for sockets in the 
> non-default namespace will not get RX traffic as it gets dropped in the 
> kernel before other modules or user code has a chance to see it.  
> Outcomes range from local seeming disconnection to kernel induced 
> site-crippling packet storms.
> 
> Is there a way to track this llc namespace awareness effort?  I'm new to 
> this particular dev community.  It's on a critical path for my project.

AFAIK, there is no ongoing work for this.  I can spend some cycles on
this, but note that the patches might not be backported to stable as
it would be invasive.

