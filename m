Return-Path: <netdev+bounces-29973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 041DC7856A4
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 13:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 262E01C20C4C
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 11:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19CEBA4B;
	Wed, 23 Aug 2023 11:17:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE40BBA3A
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 11:17:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20610.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::610])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD895E54
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 04:17:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxhZvDq+hW5yBqpjofD69K7BM0dl538oHuzGCzCYUP4shFbVHghpIi03RC0a4VEvc3iPOiinhTB4Q2bSSrRSDmnXI8DJrGFy1hvJHB/4NQ+pye5pB+By0Ojmb4Xy7TC+BmH0WwQLmwooGpwgMcp0tdtJB3cWJEEmxvvY9cljQpJBCw6AyfbLiH86YiNMrQNY65JdUkeKahty21Ty7MzD2+xPveXfR1wc5Aeex12d/Gto5ilROOj6uw3yCnR/7ooNUwFiXcVzWaj5dY4tC5IEDEgwq8g8IVB0BmIIgdNXWp2Ha4Li296jMbtqklfA7eGYn4NU9nVacFCHsRLCuBmoHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQBGcNrG9ItHxRo4LPxCQBssTqB1tAqvaqyfHmsEvAE=;
 b=PpWEvtRViaishDXXu/HAT8puXym8n3kbWpaSTVC9MJ4QrnUd9F/9z2KsIDPzOY3Fi/F2ywbnmnHtVSdXOUiMM/JqzlGzuexbUgB8iTrxjMKdoRblsy/2A9KvAu1ro7HPXjkRMPp0u5NoK9TAFXzmfK3aAZV3Vrg1xE+tHJo88+Xe0tsBohU8YUjO8kDLosOAqFmYykxts0GCCfRVCMqvcHamN2vi3luUorhmHtHYL1qMitZ1Ke9jHUTw4BGWJmGc/AjcUPhltEQb/cZLkRTPA0xreZSuXZCGiTMIBKMNrHc1bojL8IpqwcLPbYITc+l0M823TGU7/EK71sZ5dKiZmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQBGcNrG9ItHxRo4LPxCQBssTqB1tAqvaqyfHmsEvAE=;
 b=5W0km7ytbJBekYBEE9u61NUPuz/xT9pgnwoDB7NG9v8TYV+mvDb+tdHCITNs8z4qKnMwFaI5O4na1h5gIav4Q+LTKbl9HPYFhkvlLi/aqHabG74GnmMR0lVG4Ua0x/ZPprn/57wSbWnZKoavXMNoUndBuccaYvQ+ZCGuHnxPUD8=
Received: from SN7PR04CA0194.namprd04.prod.outlook.com (2603:10b6:806:126::19)
 by SJ2PR12MB8978.namprd12.prod.outlook.com (2603:10b6:a03:545::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Wed, 23 Aug
 2023 11:17:36 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:126:cafe::5e) by SN7PR04CA0194.outlook.office365.com
 (2603:10b6:806:126::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Wed, 23 Aug 2023 11:17:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 11:17:35 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 06:17:35 -0500
Received: from xcbpieterj41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 23 Aug 2023 06:17:33 -0500
From: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
To: <netdev@vger.kernel.org>, <linux-net-drivers@amd.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH net-next 1/6] sfc: introduce ethernet pedit set action infrastructure
Date: Wed, 23 Aug 2023 12:17:20 +0100
Message-ID: <20230823111725.28090-2-pieter.jansen-van-vuuren@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230823111725.28090-1-pieter.jansen-van-vuuren@amd.com>
References: <20230823111725.28090-1-pieter.jansen-van-vuuren@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|SJ2PR12MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: 729ad60e-d8ff-414a-65ed-08dba3ca8db3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k6KWVRwcJsvm0a/7AeltgiAiTX8BGeAfT4K4Ms2wvqNW2UPm38GgmlqCEcXV+Gnb4i0eZUcQiUDJpwXaykJe2jXDy1/mNKWikBmj3X4axdRJyK79TgB+6+UtbVOIZ3IazAbPTWrVNRQ9zU/bK/3mrbFLf2s0OOk4buVmItbV+uI2HYfEpib94qWlS4TkzOAP4OjVge/0bVzehfCaeNH840j+nfqYpXrNwOjwFNwmm0608J1FuRefgWBMfjlhRd9/V8a+qYfAKy8zwdAMXtnNuJlPucrW35Spz5yqMlIzN5lkRdFVOyuVO6Pt3r7DYfLCQ1HIHxxgqQr6K7TaDGgXzscyEBoHx5CubCyYpp8haCMKjcU0le76Wl/Ls3QywF584rYioTdT2D5yuq+smhAq30Kfi6pjE4gI3o2d+DPhr+RonDMAhowEaxyRF/MxiTSQyCvTDo9eK6yhIUZpzzitB9XA0SH4kkRxyNh8qGMQRMJNsmCC48oS9oV6xFZfdp4B61SC+0vgsLv4Ry14T0gilWS79bptIIMzud1oPI3Pbd8OueN6yDO/SjNlpOhzIGhEo65BkSCYlahBrOBTjYiRZzEt300qoIyV+4m75apFSihmT9UPaV5V2g/h/vFZ87w7jGf6dTlFb/Q+3d2g8L3LOjadqUFYqgCKwRJgEgs00bF9KTUVx4dZdaqa6dAX1QZOd1L0we/zLd41uK4BZaS67P7cU4guPMb5/myMcKMSsv/dgU5xxDFYoJN4oDc6SxvI5h57wnjo2DoTjnnXtsBZmg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199024)(82310400011)(186009)(1800799009)(36840700001)(40470700004)(46966006)(86362001)(41300700001)(110136005)(5660300002)(70586007)(54906003)(2616005)(70206006)(30864003)(2906002)(316002)(6636002)(8676002)(478600001)(4326008)(8936002)(6666004)(26005)(356005)(40460700003)(36756003)(82740400003)(47076005)(81166007)(336012)(426003)(36860700001)(1076003)(83380400001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 11:17:35.8497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 729ad60e-d8ff-414a-65ed-08dba3ca8db3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8978
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Introduce the initial ethernet pedit set action infrastructure in
preparation for adding mac src and dst pedit action offloads.

Co-developed-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/net/ethernet/sfc/mae.c | 83 ++++++++++++++++++++++++++++++++--
 drivers/net/ethernet/sfc/mae.h |  4 ++
 drivers/net/ethernet/sfc/tc.c  | 70 ++++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/tc.h  | 56 ++++++++++++++++++++---
 4 files changed, 202 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/sfc/mae.c b/drivers/net/ethernet/sfc/mae.c
index 3b8780c76b6e..a7ad7ab8c5f4 100644
--- a/drivers/net/ethernet/sfc/mae.c
+++ b/drivers/net/ethernet/sfc/mae.c
@@ -1219,6 +1219,71 @@ int efx_mae_enumerate_mports(struct efx_nic *efx)
 	return rc;
 }
 
+/**
+ * efx_mae_allocate_pedit_mac() - allocate pedit MAC address in HW.
+ * @efx:	NIC we're installing a pedit MAC address on
+ * @ped:	pedit MAC action to be installed
+ *
+ * Attempts to install @ped in HW and populates its id with an index of this
+ * entry in the firmware MAC address table on success.
+ *
+ * Return: negative value on error, 0 in success.
+ */
+int efx_mae_allocate_pedit_mac(struct efx_nic *efx,
+			       struct efx_tc_mac_pedit_action *ped)
+{
+	MCDI_DECLARE_BUF(outbuf, MC_CMD_MAE_MAC_ADDR_ALLOC_OUT_LEN);
+	MCDI_DECLARE_BUF(inbuf, MC_CMD_MAE_MAC_ADDR_ALLOC_IN_LEN);
+	size_t outlen;
+	int rc;
+
+	BUILD_BUG_ON(MC_CMD_MAE_MAC_ADDR_ALLOC_IN_MAC_ADDR_LEN !=
+		     sizeof(ped->h_addr));
+	memcpy(MCDI_PTR(inbuf, MAE_MAC_ADDR_ALLOC_IN_MAC_ADDR), ped->h_addr,
+	       sizeof(ped->h_addr));
+	rc = efx_mcdi_rpc(efx, MC_CMD_MAE_MAC_ADDR_ALLOC, inbuf, sizeof(inbuf),
+			  outbuf, sizeof(outbuf), &outlen);
+	if (rc)
+		return rc;
+	if (outlen < sizeof(outbuf))
+		return -EIO;
+	ped->fw_id = MCDI_DWORD(outbuf, MAE_MAC_ADDR_ALLOC_OUT_MAC_ID);
+	return 0;
+}
+
+/**
+ * efx_mae_free_pedit_mac() - free pedit MAC address in HW.
+ * @efx:	NIC we're installing a pedit MAC address on
+ * @ped:	pedit MAC action that needs to be freed
+ *
+ * Frees @ped in HW, check that firmware did not free a different one and clears
+ * the id (which denotes the index of the entry in the MAC address table).
+ */
+void efx_mae_free_pedit_mac(struct efx_nic *efx,
+			    struct efx_tc_mac_pedit_action *ped)
+{
+	MCDI_DECLARE_BUF(outbuf, MC_CMD_MAE_MAC_ADDR_FREE_OUT_LEN(1));
+	MCDI_DECLARE_BUF(inbuf, MC_CMD_MAE_MAC_ADDR_FREE_IN_LEN(1));
+	size_t outlen;
+	int rc;
+
+	MCDI_SET_DWORD(inbuf, MAE_MAC_ADDR_FREE_IN_MAC_ID, ped->fw_id);
+	rc = efx_mcdi_rpc(efx, MC_CMD_MAE_MAC_ADDR_FREE, inbuf,
+			  sizeof(inbuf), outbuf, sizeof(outbuf), &outlen);
+	if (rc || outlen < sizeof(outbuf))
+		return;
+	/* FW freed a different ID than we asked for, should also never happen.
+	 * Warn because it means we've now got a different idea to the FW of
+	 * what MAC addresses exist, which could cause mayhem later.
+	 */
+	if (WARN_ON(MCDI_DWORD(outbuf, MAE_MAC_ADDR_FREE_OUT_FREED_MAC_ID) != ped->fw_id))
+		return;
+	/* We're probably about to free @ped, but let's just make sure its
+	 * fw_id is blatted so that it won't look valid if it leaks out.
+	 */
+	ped->fw_id = MC_CMD_MAE_MAC_ADDR_ALLOC_OUT_MAC_ID_NULL;
+}
+
 int efx_mae_alloc_action_set(struct efx_nic *efx, struct efx_tc_action_set *act)
 {
 	MCDI_DECLARE_BUF(outbuf, MC_CMD_MAE_ACTION_SET_ALLOC_OUT_LEN);
@@ -1231,10 +1296,20 @@ int efx_mae_alloc_action_set(struct efx_nic *efx, struct efx_tc_action_set *act)
 			      MAE_ACTION_SET_ALLOC_IN_VLAN_POP, act->vlan_pop,
 			      MAE_ACTION_SET_ALLOC_IN_DECAP, act->decap);
 
-	MCDI_SET_DWORD(inbuf, MAE_ACTION_SET_ALLOC_IN_SRC_MAC_ID,
-		       MC_CMD_MAE_MAC_ADDR_ALLOC_OUT_MAC_ID_NULL);
-	MCDI_SET_DWORD(inbuf, MAE_ACTION_SET_ALLOC_IN_DST_MAC_ID,
-		       MC_CMD_MAE_MAC_ADDR_ALLOC_OUT_MAC_ID_NULL);
+	if (act->src_mac)
+		MCDI_SET_DWORD(inbuf, MAE_ACTION_SET_ALLOC_IN_SRC_MAC_ID,
+			       act->src_mac->fw_id);
+	else
+		MCDI_SET_DWORD(inbuf, MAE_ACTION_SET_ALLOC_IN_SRC_MAC_ID,
+			       MC_CMD_MAE_MAC_ADDR_ALLOC_OUT_MAC_ID_NULL);
+
+	if (act->dst_mac)
+		MCDI_SET_DWORD(inbuf, MAE_ACTION_SET_ALLOC_IN_DST_MAC_ID,
+			       act->dst_mac->fw_id);
+	else
+		MCDI_SET_DWORD(inbuf, MAE_ACTION_SET_ALLOC_IN_DST_MAC_ID,
+			       MC_CMD_MAE_MAC_ADDR_ALLOC_OUT_MAC_ID_NULL);
+
 	if (act->count && !WARN_ON(!act->count->cnt))
 		MCDI_SET_DWORD(inbuf, MAE_ACTION_SET_ALLOC_IN_COUNTER_ID,
 			       act->count->cnt->fw_id);
diff --git a/drivers/net/ethernet/sfc/mae.h b/drivers/net/ethernet/sfc/mae.h
index e88e80574f15..8df30bc4f3ba 100644
--- a/drivers/net/ethernet/sfc/mae.h
+++ b/drivers/net/ethernet/sfc/mae.h
@@ -103,6 +103,10 @@ int efx_mae_update_encap_md(struct efx_nic *efx,
 int efx_mae_free_encap_md(struct efx_nic *efx,
 			  struct efx_tc_encap_action *encap);
 
+int efx_mae_allocate_pedit_mac(struct efx_nic *efx,
+			       struct efx_tc_mac_pedit_action *ped);
+void efx_mae_free_pedit_mac(struct efx_nic *efx,
+			    struct efx_tc_mac_pedit_action *ped);
 int efx_mae_alloc_action_set(struct efx_nic *efx, struct efx_tc_action_set *act);
 int efx_mae_free_action_set(struct efx_nic *efx, u32 fw_id);
 
diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index 039180c61c83..8a9fc2f47514 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -86,6 +86,12 @@ s64 efx_tc_flower_external_mport(struct efx_nic *efx, struct efx_rep *efv)
 	return mport;
 }
 
+static const struct rhashtable_params efx_tc_mac_ht_params = {
+	.key_len	= offsetofend(struct efx_tc_mac_pedit_action, h_addr),
+	.key_offset	= 0,
+	.head_offset	= offsetof(struct efx_tc_mac_pedit_action, linkage),
+};
+
 static const struct rhashtable_params efx_tc_encap_match_ht_params = {
 	.key_len	= offsetof(struct efx_tc_encap_match, linkage),
 	.key_offset	= 0,
@@ -110,6 +116,56 @@ static const struct rhashtable_params efx_tc_recirc_ht_params = {
 	.head_offset	= offsetof(struct efx_tc_recirc_id, linkage),
 };
 
+static struct efx_tc_mac_pedit_action __maybe_unused *efx_tc_flower_get_mac(struct efx_nic *efx,
+							     unsigned char h_addr[ETH_ALEN],
+							     struct netlink_ext_ack *extack)
+{
+	struct efx_tc_mac_pedit_action *ped, *old;
+	int rc;
+
+	ped = kzalloc(sizeof(*ped), GFP_USER);
+	if (!ped)
+		return ERR_PTR(-ENOMEM);
+	memcpy(ped->h_addr, h_addr, ETH_ALEN);
+	old = rhashtable_lookup_get_insert_fast(&efx->tc->mac_ht,
+						&ped->linkage,
+						efx_tc_mac_ht_params);
+	if (old) {
+		/* don't need our new entry */
+		kfree(ped);
+		if (!refcount_inc_not_zero(&old->ref))
+			return ERR_PTR(-EAGAIN);
+		/* existing entry found, ref taken */
+		return old;
+	}
+
+	rc = efx_mae_allocate_pedit_mac(efx, ped);
+	if (rc < 0) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to store pedit MAC address in hw");
+		goto out_remove;
+	}
+
+	/* ref and return */
+	refcount_set(&ped->ref, 1);
+	return ped;
+out_remove:
+	rhashtable_remove_fast(&efx->tc->mac_ht, &ped->linkage,
+			       efx_tc_mac_ht_params);
+	kfree(ped);
+	return ERR_PTR(rc);
+}
+
+static void __maybe_unused efx_tc_flower_put_mac(struct efx_nic *efx,
+				  struct efx_tc_mac_pedit_action *ped)
+{
+	if (!refcount_dec_and_test(&ped->ref))
+		return; /* still in use */
+	rhashtable_remove_fast(&efx->tc->mac_ht, &ped->linkage,
+			       efx_tc_mac_ht_params);
+	efx_mae_free_pedit_mac(efx, ped);
+	kfree(ped);
+}
+
 static void efx_tc_free_action_set(struct efx_nic *efx,
 				   struct efx_tc_action_set *act, bool in_hw)
 {
@@ -2156,6 +2212,14 @@ static void efx_tc_lhs_free(void *ptr, void *arg)
 	kfree(rule);
 }
 
+static void efx_tc_mac_free(void *ptr, void *__unused)
+{
+	struct efx_tc_mac_pedit_action *ped = ptr;
+
+	WARN_ON(refcount_read(&ped->ref));
+	kfree(ped);
+}
+
 static void efx_tc_flow_free(void *ptr, void *arg)
 {
 	struct efx_tc_flow_rule *rule = ptr;
@@ -2196,6 +2260,9 @@ int efx_init_struct_tc(struct efx_nic *efx)
 	rc = efx_tc_init_counters(efx);
 	if (rc < 0)
 		goto fail_counters;
+	rc = rhashtable_init(&efx->tc->mac_ht, &efx_tc_mac_ht_params);
+	if (rc < 0)
+		goto fail_mac_ht;
 	rc = rhashtable_init(&efx->tc->encap_match_ht, &efx_tc_encap_match_ht_params);
 	if (rc < 0)
 		goto fail_encap_match_ht;
@@ -2233,6 +2300,8 @@ int efx_init_struct_tc(struct efx_nic *efx)
 fail_match_action_ht:
 	rhashtable_destroy(&efx->tc->encap_match_ht);
 fail_encap_match_ht:
+	rhashtable_destroy(&efx->tc->mac_ht);
+fail_mac_ht:
 	efx_tc_destroy_counters(efx);
 fail_counters:
 	efx_tc_destroy_encap_actions(efx);
@@ -2268,6 +2337,7 @@ void efx_fini_struct_tc(struct efx_nic *efx)
 	rhashtable_free_and_destroy(&efx->tc->recirc_ht, efx_tc_recirc_free, efx);
 	WARN_ON(!ida_is_empty(&efx->tc->recirc_ida));
 	ida_destroy(&efx->tc->recirc_ida);
+	rhashtable_free_and_destroy(&efx->tc->mac_ht, efx_tc_mac_free, NULL);
 	efx_tc_fini_counters(efx);
 	efx_tc_fini_encap_actions(efx);
 	mutex_unlock(&efx->tc->mutex);
diff --git a/drivers/net/ethernet/sfc/tc.h b/drivers/net/ethernet/sfc/tc.h
index 40d2c803fca8..91705411e5c5 100644
--- a/drivers/net/ethernet/sfc/tc.h
+++ b/drivers/net/ethernet/sfc/tc.h
@@ -18,6 +18,23 @@
 
 #define IS_ALL_ONES(v)	(!(typeof (v))~(v))
 
+/**
+ * struct efx_tc_mac_pedit_action - mac pedit action fields
+ *
+ * @h_addr: mac address field of ethernet header
+ * @linkage: rhashtable reference
+ * @ref: reference count
+ * @fw_id: index of this entry in firmware MAC address table
+ *
+ * MAC address edits are indirected through a table in the hardware
+ */
+struct efx_tc_mac_pedit_action {
+	u8 h_addr[ETH_ALEN];
+	struct rhash_head linkage;
+	refcount_t ref;
+	u32 fw_id; /* index of this entry in firmware MAC address table */
+};
+
 static inline bool efx_ipv6_addr_all_ones(struct in6_addr *addr)
 {
 	return !memchr_inv(addr, 0xff, sizeof(*addr));
@@ -25,20 +42,43 @@ static inline bool efx_ipv6_addr_all_ones(struct in6_addr *addr)
 
 struct efx_tc_encap_action; /* see tc_encap_actions.h */
 
+/**
+ * struct efx_tc_action_set - collection of tc action fields
+ *
+ * @vlan_push: the number of vlan headers to push
+ * @vlan_pop: the number of vlan headers to pop
+ * @decap: used to indicate a tunnel header decapsulation should take place
+ * @deliver: used to indicate a deliver action should take place
+ * @vlan_tci: tci fields for vlan push actions
+ * @vlan_proto: ethernet types for vlan push actions
+ * @count: counter mapping
+ * @encap_md: encap entry in tc_encap_ht table
+ * @encap_user: linked list of encap users (encap_md->users)
+ * @user: owning action-set-list. Only populated if @encap_md is; used by efx_tc_update_encap() fallback handling
+ * @count_user: linked list of counter users (counter->users)
+ * @dest_mport: destination mport
+ * @src_mac: source mac entry in tc_mac_ht table
+ * @dst_mac: destination mac entry in tc_mac_ht table
+ * @fw_id: index of this entry in firmware actions table
+ * @list: linked list of tc actions
+ *
+ */
 struct efx_tc_action_set {
 	u16 vlan_push:2;
 	u16 vlan_pop:2;
 	u16 decap:1;
 	u16 deliver:1;
-	__be16 vlan_tci[2]; /* TCIs for vlan_push */
-	__be16 vlan_proto[2]; /* Ethertypes for vlan_push */
+	__be16 vlan_tci[2];
+	__be16 vlan_proto[2];
 	struct efx_tc_counter_index *count;
-	struct efx_tc_encap_action *encap_md; /* entry in tc_encap_ht table */
-	struct list_head encap_user; /* entry on encap_md->users list */
-	struct efx_tc_action_set_list *user; /* Only populated if encap_md */
-	struct list_head count_user; /* entry on counter->users list, if encap */
+	struct efx_tc_encap_action *encap_md;
+	struct list_head encap_user;
+	struct efx_tc_action_set_list *user;
+	struct list_head count_user;
 	u32 dest_mport;
-	u32 fw_id; /* index of this entry in firmware actions table */
+	struct efx_tc_mac_pedit_action *src_mac;
+	struct efx_tc_mac_pedit_action *dst_mac;
+	u32 fw_id;
 	struct list_head list;
 };
 
@@ -220,6 +260,7 @@ struct efx_tc_table_ct { /* TABLE_ID_CONNTRACK_TABLE */
  * @counter_ht: Hashtable of TC counters (FW IDs and counter values)
  * @counter_id_ht: Hashtable mapping TC counter cookies to counters
  * @encap_ht: Hashtable of TC encap actions
+ * @mac_ht: Hashtable of MAC address entries (for pedits)
  * @encap_match_ht: Hashtable of TC encap matches
  * @match_action_ht: Hashtable of TC match-action rules
  * @lhs_rule_ht: Hashtable of TC left-hand (act ct & goto chain) rules
@@ -257,6 +298,7 @@ struct efx_tc_state {
 	struct rhashtable counter_ht;
 	struct rhashtable counter_id_ht;
 	struct rhashtable encap_ht;
+	struct rhashtable mac_ht;
 	struct rhashtable encap_match_ht;
 	struct rhashtable match_action_ht;
 	struct rhashtable lhs_rule_ht;
-- 
2.17.1


