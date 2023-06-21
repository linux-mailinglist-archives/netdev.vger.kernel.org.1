Return-Path: <netdev+bounces-12581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D52E738370
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 14:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5ACB1C20DF5
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 12:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BE5156DB;
	Wed, 21 Jun 2023 12:15:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB9B134A2
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 12:15:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308171721
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 05:15:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQyPs+9DkIOlFM+DBY+E/WQM8fpN929TOxjYfjqbS1RGpKlUDUH8W7ri3CgD+wmqLmwjevifNDbBp6TcbJ6uTHIIlHgJgMMUjI1g0Ks2RRNaVk4uWoVjy7xzGINqZUCqcgIBB2ro/OzOSd14ijl1QtakIqST65i+77KPfnx0K8JTI/N5zInIWPzo1Ov8L+xedXSFUnqlnbsFV43Y81LOWCqMU2ZRo8crtJeZLKcWojQWXlmSzWW5nEMPOl0mQuT6hcwei1L2B/fsKdMvDNImGtlyXRjHTR8UBqGe88GzAPoKtkIx3qrs2CNZpLNLwHFeYk7UkjT5VQVNWB5fTRKuAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4YKF+ZrWmE9Azt5g4Q3+g8JF60QPqs1U3biLZwaRzE=;
 b=HvcPvdzZ8bwHrz0OcFKpr+p6aVI1BItal657yDhscV33CxGEZJWddOTXk8eQTCGypejq1le0c844l9kKmTMwMXksB3xkmxpFo1fVGc/VIRbb9x1ZHbT3wZHsV91jL8TwFWbZ9iJ+IJlOq5Qxf9HubqXfrQFWolYPcqXn9NxXFsw8HI/Jaycdcdj0WUvNk747f35gPwONlJfGP+NPdAGq2X3tfVKM68qv+DfiyYlNIxG61OyXSvXQOaAF//8z6n+cuiN2U5DvhLqRqgWNBHIjYxyEDMvIlb9TLifd+IVYpkfkUXfvQSZhLJwjz6rTUgdwKENNNxBRlD2XsIWcnfqKwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4YKF+ZrWmE9Azt5g4Q3+g8JF60QPqs1U3biLZwaRzE=;
 b=Q/BYnKshTcLTNd9bWvQ5kJalCjJUmmK+qc1p+aAniUWosDJXQx7EIzvQTBp6POJwCajJbMCiFaSH14yYMLxcHRqpDWYwh819pIJDSgBH5on36AzdW77lVUPfyA3wBahhHLVqImQTOwN8k2JGWkAHZy2o2rfr2w0so+/T++xl+zs=
Received: from SN7PR04CA0013.namprd04.prod.outlook.com (2603:10b6:806:f2::18)
 by CH3PR12MB8073.namprd12.prod.outlook.com (2603:10b6:610:126::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 12:15:35 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:f2:cafe::b7) by SN7PR04CA0013.outlook.office365.com
 (2603:10b6:806:f2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Wed, 21 Jun 2023 12:15:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Wed, 21 Jun 2023 12:15:35 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 07:15:34 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 21 Jun
 2023 05:15:34 -0700
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23 via Frontend
 Transport; Wed, 21 Jun 2023 07:15:33 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>
Subject: [PATCH net-next] sfc: keep alive neighbour entries while a TC encap action is using them
Date: Wed, 21 Jun 2023 13:15:04 +0100
Message-ID: <20230621121504.17004-1-edward.cree@amd.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|CH3PR12MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: a96ea576-b88d-493a-6966-08db72513789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kQK/E4rzEBm8NbDLn4Y5qcLuZ92El1sXaJyutGUDjxXQj7yUPX/7nLN/+MScI8s4NkUVnrodlPEb3uCy9IYZwJzdCsqazppo+FLwYkKYAOoEutAlEiH52CseFs6/uvRWyhc5ilF5rvYUZijrXHPHAT/EQ2Tu89hPgvFEEeEbw1Cz7WO63RRzDYoflfBcR3g8gz2YfKUlWRV3OOYfGNZVUNEN4F/VuYKkpOTS07UwWuoB8V/NpCaa3BQF/uh73mzQOPvlpwjKJnNp6ijU8+oBdM0pUb0G04R1KKq34VTn+SeE4gxMFSXTLZaRPXAG/EUlDdgagznir+hT1Amnv/i7cSwTWwol5EAVD1/vKEpD3pz7bisSvMgnB48sJEEtFGzBruQEP/5MZilghR0g/zu56T8UkezQdMtoxI0QWQCqimPOyZ93O/pm9ZReWLuuu+q2UmVHBNAdbKYcnVBEwCu+JnUcF5FF+kd+a7Y0Zlw2cZeUPr8JphX68RXDmpmtCzo59eqh8A4ee3EhK37iY/vl/kWHJHIIAVuhxXBbtNI0mVjrpFkPc7cvyyghwtRZHgu/jmESq50kzCdZtRDvXy2v62HJbre9KRObikQJIfPZAAaMBZnY0eSv+V1cyUxgx6m8d123HTi9ewwHispgBk4dFY/nRT4trd64SbIl9jGgmjDFXnLjjI7VW/rVwRniIVfWzNwts1mQM1dR/DqW1LTuXSJF4AA6liBq6A5TRC4FxDqO3aajvnEQ9wf4DyUph6x3Zkud8h/csBEHNZ3izMJ4Zw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(70206006)(70586007)(316002)(4326008)(8676002)(8936002)(41300700001)(26005)(186003)(1076003)(2616005)(426003)(336012)(478600001)(110136005)(54906003)(6666004)(40460700003)(82310400005)(2876002)(2906002)(5660300002)(40480700001)(81166007)(356005)(82740400003)(47076005)(36860700001)(83380400001)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 12:15:35.2101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a96ea576-b88d-493a-6966-08db72513789
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8073
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

When processing counter updates, if any action set using the newly
 incremented counter includes an encap action, prod the corresponding
 neighbouring entry to indicate to the neighbour cache that the entry
 is still in use and passing traffic.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/tc.c          | 20 ++++++++-
 drivers/net/ethernet/sfc/tc.h          |  1 +
 drivers/net/ethernet/sfc/tc_counters.c | 58 ++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/tc_counters.h |  3 ++
 4 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index 77acdb60381e..15ebd3973922 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -110,8 +110,13 @@ static void efx_tc_free_action_set(struct efx_nic *efx,
 		 */
 		list_del(&act->list);
 	}
-	if (act->count)
+	if (act->count) {
+		spin_lock_bh(&act->count->cnt->lock);
+		if (!list_empty(&act->count_user))
+			list_del(&act->count_user);
+		spin_unlock_bh(&act->count->cnt->lock);
 		efx_tc_flower_put_counter_index(efx, act->count);
+	}
 	if (act->encap_md) {
 		list_del(&act->encap_user);
 		efx_tc_flower_release_encap_md(efx, act->encap_md);
@@ -796,6 +801,7 @@ static int efx_tc_flower_replace_foreign(struct efx_nic *efx,
 					goto release;
 				}
 				act->count = ctr;
+				INIT_LIST_HEAD(&act->count_user);
 			}
 
 			if (!efx_tc_flower_action_order_ok(act, EFX_TC_AO_DELIVER)) {
@@ -1083,6 +1089,7 @@ static int efx_tc_flower_replace(struct efx_nic *efx,
 				goto release;
 			}
 			act->count = ctr;
+			INIT_LIST_HEAD(&act->count_user);
 		}
 
 		switch (fa->id) {
@@ -1120,6 +1127,17 @@ static int efx_tc_flower_replace(struct efx_nic *efx,
 				list_add_tail(&act->encap_user, &encap->users);
 				act->dest_mport = encap->dest_mport;
 				act->deliver = 1;
+				if (act->count && !WARN_ON(!act->count->cnt)) {
+					/* This counter is used by an encap
+					 * action, which needs a reference back
+					 * so it can prod neighbouring whenever
+					 * traffic is seen.
+					 */
+					spin_lock_bh(&act->count->cnt->lock);
+					list_add_tail(&act->count_user,
+						      &act->count->cnt->users);
+					spin_unlock_bh(&act->count->cnt->lock);
+				}
 				rc = efx_mae_alloc_action_set(efx, act);
 				if (rc) {
 					NL_SET_ERR_MSG_MOD(extack, "Failed to write action set to hw (encap)");
diff --git a/drivers/net/ethernet/sfc/tc.h b/drivers/net/ethernet/sfc/tc.h
index 607429f8bb28..1549c3df43bb 100644
--- a/drivers/net/ethernet/sfc/tc.h
+++ b/drivers/net/ethernet/sfc/tc.h
@@ -38,6 +38,7 @@ struct efx_tc_action_set {
 	struct efx_tc_encap_action *encap_md; /* entry in tc_encap_ht table */
 	struct list_head encap_user; /* entry on encap_md->users list */
 	struct efx_tc_action_set_list *user; /* Only populated if encap_md */
+	struct list_head count_user; /* entry on counter->users list, if encap */
 	u32 dest_mport;
 	u32 fw_id; /* index of this entry in firmware actions table */
 	struct list_head list;
diff --git a/drivers/net/ethernet/sfc/tc_counters.c b/drivers/net/ethernet/sfc/tc_counters.c
index d1a91d54c6bb..979f49058a0c 100644
--- a/drivers/net/ethernet/sfc/tc_counters.c
+++ b/drivers/net/ethernet/sfc/tc_counters.c
@@ -9,6 +9,7 @@
  */
 
 #include "tc_counters.h"
+#include "tc_encap_actions.h"
 #include "mae_counter_format.h"
 #include "mae.h"
 #include "rx_common.h"
@@ -31,6 +32,15 @@ static void efx_tc_counter_free(void *ptr, void *__unused)
 {
 	struct efx_tc_counter *cnt = ptr;
 
+	WARN_ON(!list_empty(&cnt->users));
+	/* We'd like to synchronize_rcu() here, but unfortunately we aren't
+	 * removing the element from the hashtable (it's not clear that's a
+	 * safe thing to do in an rhashtable_free_and_destroy free_fn), so
+	 * threads could still be obtaining new pointers to *cnt if they can
+	 * race against this function at all.
+	 */
+	flush_work(&cnt->work);
+	EFX_WARN_ON_PARANOID(spin_is_locked(&cnt->lock));
 	kfree(cnt);
 }
 
@@ -74,6 +84,49 @@ void efx_tc_fini_counters(struct efx_nic *efx)
 	rhashtable_free_and_destroy(&efx->tc->counter_ht, efx_tc_counter_free, NULL);
 }
 
+static void efx_tc_counter_work(struct work_struct *work)
+{
+	struct efx_tc_counter *cnt = container_of(work, struct efx_tc_counter, work);
+	struct efx_tc_encap_action *encap;
+	struct efx_tc_action_set *act;
+	unsigned long touched;
+	struct neighbour *n;
+
+	spin_lock_bh(&cnt->lock);
+	touched = READ_ONCE(cnt->touched);
+
+	list_for_each_entry(act, &cnt->users, count_user) {
+		encap = act->encap_md;
+		if (!encap)
+			continue;
+		if (!encap->neigh) /* can't happen */
+			continue;
+		if (time_after_eq(encap->neigh->used, touched))
+			continue;
+		encap->neigh->used = touched;
+		/* We have passed traffic using this ARP entry, so
+		 * indicate to the ARP cache that it's still active
+		 */
+		if (encap->neigh->dst_ip)
+			n = neigh_lookup(&arp_tbl, &encap->neigh->dst_ip,
+					 encap->neigh->egdev);
+		else
+#if IS_ENABLED(CONFIG_IPV6)
+			n = neigh_lookup(ipv6_stub->nd_tbl,
+					 &encap->neigh->dst_ip6,
+					 encap->neigh->egdev);
+#else
+			n = NULL;
+#endif
+		if (!n)
+			continue;
+
+		neigh_event_send(n, NULL);
+		neigh_release(n);
+	}
+	spin_unlock_bh(&cnt->lock);
+}
+
 /* Counter allocation */
 
 static struct efx_tc_counter *efx_tc_flower_allocate_counter(struct efx_nic *efx,
@@ -87,12 +140,14 @@ static struct efx_tc_counter *efx_tc_flower_allocate_counter(struct efx_nic *efx
 		return ERR_PTR(-ENOMEM);
 
 	spin_lock_init(&cnt->lock);
+	INIT_WORK(&cnt->work, efx_tc_counter_work);
 	cnt->touched = jiffies;
 	cnt->type = type;
 
 	rc = efx_mae_allocate_counter(efx, cnt);
 	if (rc)
 		goto fail1;
+	INIT_LIST_HEAD(&cnt->users);
 	rc = rhashtable_insert_fast(&efx->tc->counter_ht, &cnt->linkage,
 				    efx_tc_counter_ht_params);
 	if (rc)
@@ -126,6 +181,7 @@ static void efx_tc_flower_release_counter(struct efx_nic *efx,
 		netif_warn(efx, hw, efx->net_dev,
 			   "Failed to free MAE counter %u, rc %d\n",
 			   cnt->fw_id, rc);
+	WARN_ON(!list_empty(&cnt->users));
 	/* This doesn't protect counter updates coming in arbitrarily long
 	 * after we deleted the counter.  The RCU just ensures that we won't
 	 * free the counter while another thread has a pointer to it.
@@ -133,6 +189,7 @@ static void efx_tc_flower_release_counter(struct efx_nic *efx,
 	 * is handled by the generation count.
 	 */
 	synchronize_rcu();
+	flush_work(&cnt->work);
 	EFX_WARN_ON_PARANOID(spin_is_locked(&cnt->lock));
 	kfree(cnt);
 }
@@ -302,6 +359,7 @@ static void efx_tc_counter_update(struct efx_nic *efx,
 		cnt->touched = jiffies;
 	}
 	spin_unlock_bh(&cnt->lock);
+	schedule_work(&cnt->work);
 out:
 	rcu_read_unlock();
 }
diff --git a/drivers/net/ethernet/sfc/tc_counters.h b/drivers/net/ethernet/sfc/tc_counters.h
index 8fc7c4bbb29c..41e57f34b763 100644
--- a/drivers/net/ethernet/sfc/tc_counters.h
+++ b/drivers/net/ethernet/sfc/tc_counters.h
@@ -32,6 +32,9 @@ struct efx_tc_counter {
 	u64 old_packets, old_bytes; /* Values last time passed to userspace */
 	/* jiffies of the last time we saw packets increase */
 	unsigned long touched;
+	struct work_struct work; /* For notifying encap actions */
+	/* owners of corresponding count actions */
+	struct list_head users;
 };
 
 struct efx_tc_counter_index {

