Return-Path: <netdev+bounces-29894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF4E78515A
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 09:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC29280DBA
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 07:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FD08F65;
	Wed, 23 Aug 2023 07:19:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE25E8F41
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 07:19:18 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745FBDB
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 00:19:17 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bf7423ef3eso21732145ad.3
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 00:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692775156; x=1693379956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1Cwp20mRDTlFVzBZ9uKIZSA/6Ops9zq35MDGxSaKDg=;
        b=kO2LLVqXZ0luFeSsycABJTM2c41qgRl6DssK7FYZ84bCFiqam/uer1IuFgp2H/m9a1
         CUBo5sByi+cqozJSwS/Y3dE8Y01h9IXIrg9yMg1JitbtOWMJN2AAIY6PRKsCeWupAbEv
         tBczSAZWfuflng+QfCAK43a03D6mHSAp2z/vyluwPwEiO4Og0p/G+z9aS1VptYqvgqXE
         rUPzYM+rSlXOeL2u3dxr6JXBtij4oMkd5c1pLpQGKsF9bAF0B/kjpsU2MRm9bgBxe3rt
         UQTxTZFCMeGKG1H9ZaGxkq3gHxnIt8crMX2WBL4aFc67DpuHvoX0w1XbTkXgmaNaZemz
         MSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692775156; x=1693379956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q1Cwp20mRDTlFVzBZ9uKIZSA/6Ops9zq35MDGxSaKDg=;
        b=Rp9Q+NmHtQ9sdYmKJ2gNQWE6AxM0HV5emOjsHHjIEc1LfIgPBJHcH3VrxuUxhDZWJQ
         7LkIoeJlgGHRrjHq8LuCFWb74MdE1c8IX+QBfMF7CZfmSvMKjC39TPEMXZplDtgTZ9uc
         tzGEu0ea3txJHqcStX2h1RyisqvXQgdRAAday9Sh8eskxiNjpAlmp7MEucPGCo+Lxqjw
         WWP1lDlz09JA5fhJFZJQ3fHXaOBlHz2Rrlj5BOJWg6JoDAd3gaSBDWbWxNY9xo5bzq+E
         +KwwRLbzs9vs0SjZTlyiurksP/MFcprqIJD4bOksZPMePnxHB60q84QC4n1niOfR7j4x
         woxQ==
X-Gm-Message-State: AOJu0Yz6Usj2g2hg9cIZwXGMmePlHTnEbNXzVNn5d4AnUzR8gw87l4Si
	oHkJvvkFUegviPIiQv7GvMLhVhwbowEtFw==
X-Google-Smtp-Source: AGHT+IGQ1ONQoz2SuHcZQYOYeu0Odm0jZ9bCAgK0xZ8gi0FpGD7M3FKftYb4oJV1o2F0oO3pVlqc5A==
X-Received: by 2002:a17:903:244a:b0:1b5:561a:5ca9 with SMTP id l10-20020a170903244a00b001b5561a5ca9mr10177139pls.50.1692775156365;
        Wed, 23 Aug 2023 00:19:16 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id iw14-20020a170903044e00b001bdea189261sm10221212plb.229.2023.08.23.00.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 00:19:15 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Liang Li <liali@redhat.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	susan.zheng@veritas.com
Subject: [PATCHv3 net 1/3] bonding: fix macvlan over alb bond support
Date: Wed, 23 Aug 2023 15:19:04 +0800
Message-ID: <20230823071907.3027782-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823071907.3027782-1-liuhangbin@gmail.com>
References: <20230823071907.3027782-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The commit 14af9963ba1e ("bonding: Support macvlans on top of tlb/rlb mode
bonds") aims to enable the use of macvlans on top of rlb bond mode. However,
the current rlb bond mode only handles ARP packets to update remote neighbor
entries. This causes an issue when a macvlan is on top of the bond, and
remote devices send packets to the macvlan using the bond's MAC address
as the destination. After delivering the packets to the macvlan, the macvlan
will rejects them as the MAC address is incorrect. Consequently, this commit
makes macvlan over bond non-functional.

To address this problem, one potential solution is to check for the presence
of a macvlan port on the bond device using netif_is_macvlan_port(bond->dev)
and return NULL in the rlb_arp_xmit() function. However, this approach
doesn't fully resolve the situation when a VLAN exists between the bond and
macvlan.

So let's just do a partial revert for commit 14af9963ba1e in rlb_arp_xmit().
As the comment said, Don't modify or load balance ARPs that do not originate
locally.

Fixes: 14af9963ba1e ("bonding: Support macvlans on top of tlb/rlb mode bonds")
Reported-by: susan.zheng@veritas.com
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2117816
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v3: no update
v2: update comment message in rlb_arp_xmit.
---
 drivers/net/bonding/bond_alb.c |  6 +++---
 include/net/bonding.h          | 11 +----------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index b9dbad3a8af8..fc5da5d7744d 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -660,10 +660,10 @@ static struct slave *rlb_arp_xmit(struct sk_buff *skb, struct bonding *bond)
 		return NULL;
 	arp = (struct arp_pkt *)skb_network_header(skb);
 
-	/* Don't modify or load balance ARPs that do not originate locally
-	 * (e.g.,arrive via a bridge).
+	/* Don't modify or load balance ARPs that do not originate
+	 * from the bond itself or a VLAN directly above the bond.
 	 */
-	if (!bond_slave_has_mac_rx(bond, arp->mac_src))
+	if (!bond_slave_has_mac_rcu(bond, arp->mac_src))
 		return NULL;
 
 	dev = ip_dev_find(dev_net(bond->dev), arp->ip_src);
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 30ac427cf0c6..5b8b1b644a2d 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -722,23 +722,14 @@ static inline struct slave *bond_slave_has_mac(struct bonding *bond,
 }
 
 /* Caller must hold rcu_read_lock() for read */
-static inline bool bond_slave_has_mac_rx(struct bonding *bond, const u8 *mac)
+static inline bool bond_slave_has_mac_rcu(struct bonding *bond, const u8 *mac)
 {
 	struct list_head *iter;
 	struct slave *tmp;
-	struct netdev_hw_addr *ha;
 
 	bond_for_each_slave_rcu(bond, tmp, iter)
 		if (ether_addr_equal_64bits(mac, tmp->dev->dev_addr))
 			return true;
-
-	if (netdev_uc_empty(bond->dev))
-		return false;
-
-	netdev_for_each_uc_addr(ha, bond->dev)
-		if (ether_addr_equal_64bits(mac, ha->addr))
-			return true;
-
 	return false;
 }
 
-- 
2.41.0


