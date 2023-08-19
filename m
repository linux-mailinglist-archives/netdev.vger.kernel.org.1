Return-Path: <netdev+bounces-29061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C317818C7
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 12:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C401C209D7
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 10:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4F246AD;
	Sat, 19 Aug 2023 10:31:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB0F46AB
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 10:31:44 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057341A28F
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:02:27 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a412653335so1266067b6e.1
        for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692435745; x=1693040545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSlHUWaRoWoYyzE+8M2lAdKkPSAJgcttuz28f+BnHZI=;
        b=ki/EegGJBp4utHS9AV2d/6VC3atnCQJ7yChlxKZG8QTEMt2Ev4chdkriRzIN49i3bP
         NxGIdl4YfrQh3EgCNuKuODBbsLBIKEPDVDgvH22W/JGQC3Oi3j8d9h6UvkQhX2QqEl3v
         QYvC1V3Yq0ySpoOx8o9+26QsryTiYMMKs2AalGgOmCLKDAdGV6XEtrHs1CNblANDft7X
         A2OdsS+0FL8FKWI+qbrITGupdPV0awv//zduhpmz5da86Ws4vFmn/jQX1Ual5ARx/L+s
         7VEGhwX6GYwSse9cW7Xt4C2vuwh/a/VI/FKi8lxWAQ+Nhbt6hUPSbvTIHLMt+7T+TxTi
         QY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692435745; x=1693040545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSlHUWaRoWoYyzE+8M2lAdKkPSAJgcttuz28f+BnHZI=;
        b=k6inw0XuKuoaRuL3kBP75iSus8F/okDNe9w1decou0dQb7FzgqXG5RuP8VA+njsmi8
         I8y6T5efz9pIdYeOmaWVwaMHC3Ptk/zQflCno87CmCERLcUMYEYZ5H2S0QdwgVnYDwBt
         tuKVaLVl8TaMHKM+7DynNMcjLI2QEvB0QMq/kanY1UK/oLsByl8Y8vQXy/AKtbERivby
         SlavMJvMn4NvAe+OZA0TiW7yr6dGLqL/WW69WyBOGti5tiloDmdXlDkL9NiP/pb674Se
         qIbQcHNCUCMH3trbPWwYk95yGP1foGtYfeKiWkYEpjylrVgXT3lWC/VLWw9j/HnmmHkb
         RFjw==
X-Gm-Message-State: AOJu0YyP1fqTQfelcUvoFVvUhvxn7V2OvhKdEl1raPzUGpQAkH0uLdQu
	+opnejOpX7J2S/oCA/oxZrqMYJuMZ29HgyHT
X-Google-Smtp-Source: AGHT+IFKF6oAxAxjwoh2XC6e2/vtZBHMub7BA+5nqm3CduZN7Z835AoymV4lZxd61QnfxG2lMU2PRQ==
X-Received: by 2002:a05:6808:2a49:b0:3a7:9bc2:ff6b with SMTP id fa9-20020a0568082a4900b003a79bc2ff6bmr1787330oib.5.1692435745720;
        Sat, 19 Aug 2023 02:02:25 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e9-20020aa78249000000b00688435a9915sm2758895pfn.189.2023.08.19.02.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 02:02:05 -0700 (PDT)
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
Subject: [PATCH net 1/3] bonding: fix macvlan over alb bond support
Date: Sat, 19 Aug 2023 17:01:07 +0800
Message-ID: <20230819090109.14467-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230819090109.14467-1-liuhangbin@gmail.com>
References: <20230819090109.14467-1-liuhangbin@gmail.com>
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
 drivers/net/bonding/bond_alb.c |  4 ++--
 include/net/bonding.h          | 11 +----------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index b9dbad3a8af8..7765616107e5 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -661,9 +661,9 @@ static struct slave *rlb_arp_xmit(struct sk_buff *skb, struct bonding *bond)
 	arp = (struct arp_pkt *)skb_network_header(skb);
 
 	/* Don't modify or load balance ARPs that do not originate locally
-	 * (e.g.,arrive via a bridge).
+	 * (e.g.,arrive via a bridge or macvlan).
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


