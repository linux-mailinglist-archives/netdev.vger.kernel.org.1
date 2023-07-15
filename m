Return-Path: <netdev+bounces-18046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EB4754632
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 04:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44FE1C2168A
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 02:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930BBA47;
	Sat, 15 Jul 2023 02:15:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881AD7EC
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 02:15:37 +0000 (UTC)
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E4430DF
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 19:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689387337; x=1720923337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/eA9P48xp9EhraCUWQn10mYo0s0VmQKc2ZGUqGGbPP0=;
  b=VbQ8lyTage3ghu9d2MQTfRApI+Egj1n7JlbE4mxZ/ZZeWcddoj6t1pDD
   CYfxMpNUgfSv9LzH3BZSSCrbiZFkLMV23VTiXoU4xCM9+WlfLBXzqJ+c3
   gnDNcEtgLsjxzyulDP4xy7HReAaFQMLuD8hOy2xNsLcdBYzyUkw4n/mQ8
   Q=;
X-IronPort-AV: E=Sophos;i="6.01,207,1684800000"; 
   d="scan'208";a="660734603"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-a893d89c.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2023 02:15:31 +0000
Received: from EX19MTAUWB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2b-m6i4x-a893d89c.us-west-2.amazon.com (Postfix) with ESMTPS id 439EA40D5B;
	Sat, 15 Jul 2023 02:15:30 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 15 Jul 2023 02:15:29 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 15 Jul 2023 02:15:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Harry Coin
	<hcoin@quietfountain.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, "Kuniyuki
 Iwashima" <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 4/4] Revert "bridge: Add extack warning when enabling STP in netns."
Date: Fri, 14 Jul 2023 19:13:38 -0700
Message-ID: <20230715021338.34747-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230715021338.34747-1-kuniyu@amazon.com>
References: <20230715021338.34747-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.14]
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This reverts commit 56a16035bb6effb37177867cea94c13a8382f745.

Since the previous commit, STP works on bridge in netns.

  # unshare -n
  # ip link add br0 type bridge
  # ip link add veth0 type veth peer name veth1

  # ip link set veth0 master br0 up
  [   50.558135] br0: port 1(veth0) entered blocking state
  [   50.558366] br0: port 1(veth0) entered disabled state
  [   50.558798] veth0: entered allmulticast mode
  [   50.564401] veth0: entered promiscuous mode

  # ip link set veth1 master br0 up
  [   54.215487] br0: port 2(veth1) entered blocking state
  [   54.215657] br0: port 2(veth1) entered disabled state
  [   54.215848] veth1: entered allmulticast mode
  [   54.219577] veth1: entered promiscuous mode

  # ip link set br0 type bridge stp_state 1
  # ip link set br0 up
  [   61.960726] br0: port 2(veth1) entered blocking state
  [   61.961097] br0: port 2(veth1) entered listening state
  [   61.961495] br0: port 1(veth0) entered blocking state
  [   61.961653] br0: port 1(veth0) entered listening state
  [   63.998835] br0: port 2(veth1) entered blocking state
  [   77.437113] br0: port 1(veth0) entered learning state
  [   86.653501] br0: received packet on veth0 with own address as source address (addr:6e:0f:e7:6f:5f:5f, vlan:0)
  [   92.797095] br0: port 1(veth0) entered forwarding state
  [   92.797398] br0: topology change detected, propagating

Let's remove the warning.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/bridge/br_stp_if.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index b65962682771..75204d36d7f9 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -201,9 +201,6 @@ int br_stp_set_enabled(struct net_bridge *br, unsigned long val,
 {
 	ASSERT_RTNL();
 
-	if (!net_eq(dev_net(br->dev), &init_net))
-		NL_SET_ERR_MSG_MOD(extack, "STP does not work in non-root netns");
-
 	if (br_mrp_enabled(br)) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "STP can't be enabled if MRP is already enabled");
-- 
2.30.2


