Return-Path: <netdev+bounces-16681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB0B74E53C
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 05:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CFD62815FB
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 03:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7D83D60;
	Tue, 11 Jul 2023 03:22:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6D8361
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 03:22:31 +0000 (UTC)
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E94C0
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 20:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689045750; x=1720581750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gk+BSQCTgU460AjZTRJ9IFdqrksmYw8s0l20noMhbHE=;
  b=ToIPfG4T57nfHyepr9AyppD4Bybk0rLeJK7xubey6WnWPIuEsCKvFGIe
   KsUQrZBS/WWFmoA2plc1IvR/lEJppQ3Qc/BwBzLWUutHzcKCmm6SRVP8G
   K5LjvvS7/U1qinx+LgHS6zHRGYbpum4fv3pDajy1hOAYUaelYxvDLFslb
   0=;
X-IronPort-AV: E=Sophos;i="6.01,195,1684800000"; 
   d="scan'208";a="226036609"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 03:22:28 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com (Postfix) with ESMTPS id 18D60806B3;
	Tue, 11 Jul 2023 03:22:28 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 11 Jul 2023 03:22:27 +0000
Received: from 88665a182662.ant.amazon.com (10.119.65.132) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 11 Jul 2023 03:22:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <hcoin@quietfountain.com>
CC: <netdev@vger.kernel.org>, <kuniyu@amazon.com>
Subject: Re: Patch fixing STP if bridge in non-default namespace.
Date: Mon, 10 Jul 2023 20:22:17 -0700
Message-ID: <20230711032217.46485-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <608c37f9-34b1-85e6-2b4b-2a0389dd3d47@quietfountain.com>
References: <608c37f9-34b1-85e6-2b4b-2a0389dd3d47@quietfountain.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.119.65.132]
X-ClientProxiedBy: EX19D033UWC004.ant.amazon.com (10.13.139.225) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Harry Coin <hcoin@quietfountain.com>
Date: Mon, 10 Jul 2023 08:35:08 -0500
> Notice without access to link-level multicast address 01:80:C2:00:00:00, 
> the STP loop-avoidance feature of bridges fails silently, leading to 
> packet storms if loops exist in the related L2.  The Linux kernel's 
> latest code silently drops BPDU STP packets if the bridge is in a 
> non-default namespace.
> 
> The current llc_rcv.c around line 166 in net/llc/llc_input.c  has
> 
>         if (!net_eq(dev_net(dev), &init_net))
>                 goto drop;
> 
> Which, when commented out, fixes this bug.  A search on &init_net may 
> reveal many similar artifacts left over from the early days of namespace 
> implementation.

I think just removing the part is not sufficient and will introduce a bug
in another place.

As you found, llc has the same test in another place.  For example, when
you create an AF_LLC socket, it has to be in the root netns.  But if you
remove the test in llc_rcv() only, it seems llc_recv() would put a skb for
a child netns into sk's recv queue that is in the default netns.

  - llc_rcv
    - if (net_eq(dev_net(dev), &init_net))
      - goto drop
    - sap_handler / llc_sap_handler
      - sk = llc_lookup_dgram
      - llc_sap_rcv
        - llc_sap_state_process
	  - sock_queue_rcv_skb

So, we need to namespacify the whole llc infra.

