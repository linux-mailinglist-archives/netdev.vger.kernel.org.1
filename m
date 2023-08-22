Return-Path: <netdev+bounces-29501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5202D783854
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 05:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D51A280FAB
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 03:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AAD111F;
	Tue, 22 Aug 2023 03:12:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A747B7F
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 03:12:37 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B57138
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 20:12:36 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bf48546ccfso19107525ad.2
        for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 20:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692673955; x=1693278755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3N//JAXn+iP9GxafYXcq5dnVmknMgYw8MIdH8Llq3gM=;
        b=hTERO5HTyoQyVeiBeXvRNj+rhLl1T+ubLo7aQfox1rpamWhwC68KIbSan36WwrfIMe
         tdPBuXhpydE9yCObmZQH+Kn4Um9sWU4/t1ggUwp8QY4AipwKI9dfHecJw6OSjQUoKrLp
         D9mdoaipDoHJzm+xfQKO8h8UpeChYqDdPsKTUxSYRxXsKyQNJGXd0CxbDOQUiAmqupsa
         K8KSyZBnC5hzL/E/JEA2wWv+bn/PqS1f4qVX29iGcdrYImfgE8blayTQWjHwjj0/gJ/E
         8Zyio+LKJkMCXO65SAnRSD17wX3C6J8SSxtcvZ35/ROWuAGtrNkTL4Vt1i8w8kda0niv
         JbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692673955; x=1693278755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3N//JAXn+iP9GxafYXcq5dnVmknMgYw8MIdH8Llq3gM=;
        b=GoRBm3GtAwKxmdr+oDBm3IpDo3ZQsCuHK5/4oSTXkIlfCId8MGVxsYhc50jn0f4ez+
         blK8EQCHFrnPDdawoD8lBNsprpMDUsBkgaQrRh6oiXI9mxL3Efg8vXv+zsdUlAww/8TN
         DmD6yFpte6jBdqam7Ej3/OMvT2D/IdfF0Wmn5ce0uAJUD167G0xL0xIiIbSX+7riT1lG
         dmXkjqx+t4p/RqBilWcYwlM5ZWxGvekg9v76GAqDW7E7sxG7SN5eXaADaNA2fUDDA18u
         20+HmCD+4RAdCC405mLyecFzp8lMY8yHrzIY33JauzQxdHYqhk+9B2L00SwLUandNWZH
         d01A==
X-Gm-Message-State: AOJu0YzK4an3jLnX8CC0EKazctLw2lyuHNhj/nOVKdnH/2pA3EoZuQ1B
	9Oey8X6IyGO3Gzvmy1Afv0Sap1/RUYoYzg==
X-Google-Smtp-Source: AGHT+IFVoU0rF5rc8faNUZFIfxyXW2JxL4LH2yqvd4fgmhBWj8AbP7j+T3mn23ZUNNPApaCq7cwXyQ==
X-Received: by 2002:a17:902:d2c6:b0:1bf:1052:f28f with SMTP id n6-20020a170902d2c600b001bf1052f28fmr6727637plc.52.1692673955396;
        Mon, 21 Aug 2023 20:12:35 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ix21-20020a170902f81500b001bde6fa0a39sm7803601plb.167.2023.08.21.20.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 20:12:34 -0700 (PDT)
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
Subject: [PATCHv2 net 1/3] bonding: fix macvlan over alb bond support
Date: Tue, 22 Aug 2023 11:12:23 +0800
Message-ID: <20230822031225.1691679-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822031225.1691679-1-liuhangbin@gmail.com>
References: <20230822031225.1691679-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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


