Return-Path: <netdev+bounces-24017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9282176E786
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D4B281E2A
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B921EA9B;
	Thu,  3 Aug 2023 11:57:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FE31DDF6
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:57:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAAC2D7B
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:57:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SM5THmLYMz0wSTd1znG62qgiRtZnW51KbtiYaVj9f1X1rZE5dk8YPUlOn10PHZS3mpUK9koZo991oMeSY3CXeBa77xDJZgge7E7XrUI9tY0PiPaGl8xqHAx5OIVFEfzQc2k3N5QfWgvyhxn8pM8VdrhY058ItbedcVIe+WXH1TmvmRIN71G/lnvqj8j1mmVoqlPgIE1/OjEzASYSEaghL1gHUekTaK4jk06e4Qb1cL+/I6niig39qkz9k5zLokTa+xf14L5rQsIQAGKU8dZu4ejccv8vea4GVPhT7qTYL+0tTcw+1WNsZA9sAO2aX6dVFbXRL8OseeWo7tCYYjELRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15M3/teQgXdBA8u8VCXr+YJW/X+frph3OgYBoZdCKTw=;
 b=P3C7pjzDdE1celJsmiuK+ndoc3Qy9M9TVaNKL9h7tS/Mdrf8EDsf+3BFfkV0uFsPahs/vdwYCq5fdURYwBVYPnapXZG21gXhSyhdUREI+TXoOy48Wtza5rtDXW1BaYAyFGfs4SVhTYrk7XXeyazzv1ZvofJRwGdGkKbQcOKZ7pTwentdP9aEhVeoqMUhpN5RXgrfiti5Eq4v8sLXgdpI4s2C6/yql91KBcRy3a0WJDt5KziovCCjIlMXMAyUARf+bpEC09dV6esw5SowCIo6+jzmLNxqAHImufieCqwRenuMxm4Us8wOE3qE+SYpbX5hID2YS0ImH0Kg1p8NWq9gDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15M3/teQgXdBA8u8VCXr+YJW/X+frph3OgYBoZdCKTw=;
 b=A53AX+4QUgzaQ7/uAP5zAMZV+VwN6i6OoEoEloZSPgCF5REjWGUWSYBMWiQw8KfKERkmWzcQkkLs8Qee5F8X9wshv5dPfrhpu03xxHz70XfkVjh6Qq6boexzBrm2oc082w1pLm6R7pODUPoO97Fft/i3p0ulp5gc4Qzt2VSJD0o=
Received: from DS7PR03CA0040.namprd03.prod.outlook.com (2603:10b6:5:3b5::15)
 by PH8PR12MB7136.namprd12.prod.outlook.com (2603:10b6:510:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 11:57:32 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:5:3b5:cafe::62) by DS7PR03CA0040.outlook.office365.com
 (2603:10b6:5:3b5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Thu, 3 Aug 2023 11:57:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 11:57:31 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 06:57:29 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 04:57:29 -0700
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 3 Aug 2023 06:57:27 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, Pieter Jansen van Vuuren
	<pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH net-next 1/7] sfc: add MAE table machinery for conntrack table
Date: Thu, 3 Aug 2023 12:56:17 +0100
Message-ID: <095ba82ea0d62ddc956c757768a72fa597c3d5fd.1691063676.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1691063675.git.ecree.xilinx@gmail.com>
References: <cover.1691063675.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|PH8PR12MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 6570095e-7dc5-48f5-ce6e-08db9418d126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I8zC08DoCZPraCYGey17WvcVJvkk/54ZQJLmK841P0o+RusKBt3ZtuUMEfVxKLcwCz6zlGbQ2bqz22PgN7yWh6pNWUADUCzgek80QYPBggLfxG2HVKe6OfIyMVtgSyso7jsUmBPMlD0mFY5KVcnNFQyx0mq7Qn78bqIJo/nM5Ec4aOLzWF/lEqjQxEx1oPsxS8Hs2FOMVoI/N1QSzAbGVT2SBSxhFuxi7Yqk+UFqEwRSynooisRs9K1gTv6L8c5A5rM/2NGMZ8CPh9BQwR66VArqrm1VRkLUpy0VvdWLQsDZIS4LU3ukMs+fgGBmz8Mh7PgsjOUdiQZORDGHgdD9dFIZCZDKUFRNNprwHtezmwc7+1hupwBFR/smiW9fOhnpeRCWyb0iViM2DjPaMMI65lG/iXDW/b45rxUBk/uoDe7z6xYodRdkOpiVa042cnMzHR3cGkB6hh0ILXNo3ojZH7joUdPH0qWSikh0EuyjATVTiKRDNeTQQ3gOdEh6UFPAJTnRpxRpzYTxCeKEffZmjPtFX0QmVplSC1pdmCfwKIQuuW/O84nr2xlf3Mx7HOhXpaFkK+2PD0kHhkskuUlBHKnPfk0UeV34r8l3WFf4rM3qfYECutj1gcGiQ6/ZLwJU3x12QErpjSxZbbSs70BgZGHcH1jYBBrkQNSF+OaMP0OxUJH0NKcH6cvNywK3xZ94zf/J8WLAeiLpLaAw2ZaROkqoJdAO/E9WqrdrVW6zEnZtoBto1+YSV3GvS18ANgGISMbjm3+03ZY0CwLU40bVcQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(82740400003)(40460700003)(426003)(83380400001)(26005)(186003)(336012)(47076005)(36860700001)(316002)(2906002)(2876002)(70586007)(70206006)(4326008)(5660300002)(30864003)(41300700001)(8676002)(8936002)(6666004)(9686003)(54906003)(110136005)(478600001)(40480700001)(356005)(81166007)(36756003)(55446002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 11:57:31.0601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6570095e-7dc5-48f5-ce6e-08db9418d126
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7136
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

Access to the connection tracking table in EF100 hardware is through
 a "generic" table mechanism, whereby a firmware call at probe time
 gives the driver a description of the field widths and offsets, so
 that the driver can then construct key and response bitstrings at
 runtime.
Probe the NIC for this information and populate the needed metadata
 into a new meta_ct field of struct efx_tc_state.

Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/mae.c  | 250 ++++++++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/mae.h  |   3 +
 drivers/net/ethernet/sfc/mcdi.h |   3 +
 drivers/net/ethernet/sfc/tc.c   |   9 +-
 drivers/net/ethernet/sfc/tc.h   |  44 ++++++
 5 files changed, 308 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/mae.c b/drivers/net/ethernet/sfc/mae.c
index 0cab508f2f9d..33ae2c852b44 100644
--- a/drivers/net/ethernet/sfc/mae.c
+++ b/drivers/net/ethernet/sfc/mae.c
@@ -227,6 +227,256 @@ void efx_mae_counters_grant_credits(struct work_struct *work)
 		rx_queue->granted_count += credits;
 }
 
+static int efx_mae_table_get_desc(struct efx_nic *efx,
+				  struct efx_tc_table_desc *desc,
+				  u32 table_id)
+{
+	MCDI_DECLARE_BUF(outbuf, MC_CMD_TABLE_DESCRIPTOR_OUT_LEN(16));
+	MCDI_DECLARE_BUF(inbuf, MC_CMD_TABLE_DESCRIPTOR_IN_LEN);
+	unsigned int offset = 0, i;
+	size_t outlen;
+	int rc;
+
+	memset(desc, 0, sizeof(*desc));
+
+	MCDI_SET_DWORD(inbuf, TABLE_DESCRIPTOR_IN_TABLE_ID, table_id);
+more:
+	MCDI_SET_DWORD(inbuf, TABLE_DESCRIPTOR_IN_FIRST_FIELDS_INDEX, offset);
+	rc = efx_mcdi_rpc(efx, MC_CMD_TABLE_DESCRIPTOR, inbuf, sizeof(inbuf),
+			  outbuf, sizeof(outbuf), &outlen);
+	if (rc)
+		goto fail;
+	if (outlen < MC_CMD_TABLE_DESCRIPTOR_OUT_LEN(1)) {
+		rc = -EIO;
+		goto fail;
+	}
+	if (!offset) { /* first iteration: get metadata */
+		desc->type = MCDI_WORD(outbuf, TABLE_DESCRIPTOR_OUT_TYPE);
+		desc->key_width = MCDI_WORD(outbuf, TABLE_DESCRIPTOR_OUT_KEY_WIDTH);
+		desc->resp_width = MCDI_WORD(outbuf, TABLE_DESCRIPTOR_OUT_RESP_WIDTH);
+		desc->n_keys = MCDI_WORD(outbuf, TABLE_DESCRIPTOR_OUT_N_KEY_FIELDS);
+		desc->n_resps = MCDI_WORD(outbuf, TABLE_DESCRIPTOR_OUT_N_RESP_FIELDS);
+		desc->n_prios = MCDI_WORD(outbuf, TABLE_DESCRIPTOR_OUT_N_PRIORITIES);
+		desc->flags = MCDI_BYTE(outbuf, TABLE_DESCRIPTOR_OUT_FLAGS);
+		rc = -EOPNOTSUPP;
+		if (desc->flags)
+			goto fail;
+		desc->scheme = MCDI_BYTE(outbuf, TABLE_DESCRIPTOR_OUT_SCHEME);
+		if (desc->scheme)
+			goto fail;
+		rc = -ENOMEM;
+		desc->keys = kcalloc(desc->n_keys,
+				     sizeof(struct efx_tc_table_field_fmt),
+				     GFP_KERNEL);
+		if (!desc->keys)
+			goto fail;
+		desc->resps = kcalloc(desc->n_resps,
+				      sizeof(struct efx_tc_table_field_fmt),
+				      GFP_KERNEL);
+		if (!desc->resps)
+			goto fail;
+	}
+	/* FW could have returned more than the 16 field_descrs we
+	 * made room for in our outbuf
+	 */
+	outlen = min(outlen, sizeof(outbuf));
+	for (i = 0; i + offset < desc->n_keys + desc->n_resps; i++) {
+		struct efx_tc_table_field_fmt *field;
+		MCDI_DECLARE_STRUCT_PTR(fdesc);
+
+		if (outlen < MC_CMD_TABLE_DESCRIPTOR_OUT_LEN(i + 1)) {
+			offset += i;
+			goto more;
+		}
+		if (i + offset < desc->n_keys)
+			field = desc->keys + i + offset;
+		else
+			field = desc->resps + (i + offset - desc->n_keys);
+		fdesc = MCDI_ARRAY_STRUCT_PTR(outbuf,
+					      TABLE_DESCRIPTOR_OUT_FIELDS, i);
+		field->field_id = MCDI_STRUCT_WORD(fdesc,
+						   TABLE_FIELD_DESCR_FIELD_ID);
+		field->lbn = MCDI_STRUCT_WORD(fdesc, TABLE_FIELD_DESCR_LBN);
+		field->width = MCDI_STRUCT_WORD(fdesc, TABLE_FIELD_DESCR_WIDTH);
+		field->masking = MCDI_STRUCT_BYTE(fdesc, TABLE_FIELD_DESCR_MASK_TYPE);
+		field->scheme = MCDI_STRUCT_BYTE(fdesc, TABLE_FIELD_DESCR_SCHEME);
+	}
+	return 0;
+
+fail:
+	kfree(desc->keys);
+	kfree(desc->resps);
+	return rc;
+}
+
+static int efx_mae_table_hook_find(u16 n_fields,
+				   struct efx_tc_table_field_fmt *fields,
+				   u16 field_id)
+{
+	unsigned int i;
+
+	for (i = 0; i < n_fields; i++) {
+		if (fields[i].field_id == field_id)
+			return i;
+	}
+	return -EPROTO;
+}
+
+#define TABLE_FIND_KEY(_desc, _id)	\
+	efx_mae_table_hook_find((_desc)->n_keys, (_desc)->keys, _id)
+#define TABLE_FIND_RESP(_desc, _id)	\
+	efx_mae_table_hook_find((_desc)->n_resps, (_desc)->resps, _id)
+
+#define TABLE_HOOK_KEY(_meta, _name, _mcdi_name)	({			\
+	int _rc = TABLE_FIND_KEY(&_meta->desc, TABLE_FIELD_ID_##_mcdi_name);	\
+										\
+	if (_rc > U8_MAX)							\
+		_rc = -EOPNOTSUPP;						\
+	if (_rc >= 0) {								\
+		_meta->keys._name##_idx = _rc;					\
+		_rc = 0;							\
+	}									\
+	_rc;									\
+})
+#define TABLE_HOOK_RESP(_meta, _name, _mcdi_name)	({			\
+	int _rc = TABLE_FIND_RESP(&_meta->desc, TABLE_FIELD_ID_##_mcdi_name);	\
+										\
+	if (_rc > U8_MAX)							\
+		_rc = -EOPNOTSUPP;						\
+	if (_rc >= 0) {								\
+		_meta->resps._name##_idx = _rc;					\
+		_rc = 0;							\
+	}									\
+	_rc;									\
+})
+
+static int efx_mae_table_hook_ct(struct efx_nic *efx,
+				 struct efx_tc_table_ct *meta_ct)
+{
+	int rc;
+
+	rc = TABLE_HOOK_KEY(meta_ct, eth_proto, ETHER_TYPE);
+	if (rc)
+		return rc;
+	rc = TABLE_HOOK_KEY(meta_ct, ip_proto, IP_PROTO);
+	if (rc)
+		return rc;
+	rc = TABLE_HOOK_KEY(meta_ct, src_ip, SRC_IP);
+	if (rc)
+		return rc;
+	rc = TABLE_HOOK_KEY(meta_ct, dst_ip, DST_IP);
+	if (rc)
+		return rc;
+	rc = TABLE_HOOK_KEY(meta_ct, l4_sport, SRC_PORT);
+	if (rc)
+		return rc;
+	rc = TABLE_HOOK_KEY(meta_ct, l4_dport, DST_PORT);
+	if (rc)
+		return rc;
+	rc = TABLE_HOOK_KEY(meta_ct, zone, DOMAIN);
+	if (rc)
+		return rc;
+	rc = TABLE_HOOK_RESP(meta_ct, dnat, NAT_DIR);
+	if (rc)
+		return rc;
+	rc = TABLE_HOOK_RESP(meta_ct, nat_ip, NAT_IP);
+	if (rc)
+		return rc;
+	rc = TABLE_HOOK_RESP(meta_ct, l4_natport, NAT_PORT);
+	if (rc)
+		return rc;
+	rc = TABLE_HOOK_RESP(meta_ct, mark, CT_MARK);
+	if (rc)
+		return rc;
+	rc = TABLE_HOOK_RESP(meta_ct, counter_id, COUNTER_ID);
+	if (rc)
+		return rc;
+	meta_ct->hooked = true;
+	return 0;
+}
+
+static void efx_mae_table_free_desc(struct efx_tc_table_desc *desc)
+{
+	kfree(desc->keys);
+	kfree(desc->resps);
+	memset(desc, 0, sizeof(*desc));
+}
+
+static bool efx_mae_check_table_exists(struct efx_nic *efx, u32 tbl_req)
+{
+	MCDI_DECLARE_BUF(outbuf, MC_CMD_TABLE_LIST_OUT_LEN(16));
+	MCDI_DECLARE_BUF(inbuf, MC_CMD_TABLE_LIST_IN_LEN);
+	u32 tbl_id, tbl_total, tbl_cnt, pos = 0;
+	size_t outlen, msg_max;
+	bool ct_tbl = false;
+	int rc, idx;
+
+	msg_max = sizeof(outbuf);
+	efx->tc->meta_ct.hooked = false;
+more:
+	memset(outbuf, 0, sizeof(*outbuf));
+	MCDI_SET_DWORD(inbuf, TABLE_LIST_IN_FIRST_TABLE_ID_INDEX, pos);
+	rc = efx_mcdi_rpc(efx, MC_CMD_TABLE_LIST, inbuf, sizeof(inbuf), outbuf,
+			  msg_max, &outlen);
+	if (rc)
+		return false;
+
+	if (outlen < MC_CMD_TABLE_LIST_OUT_LEN(1))
+		return false;
+
+	tbl_total = MCDI_DWORD(outbuf, TABLE_LIST_OUT_N_TABLES);
+	tbl_cnt = MC_CMD_TABLE_LIST_OUT_TABLE_ID_NUM(min(outlen, msg_max));
+
+	for (idx = 0; idx < tbl_cnt; idx++) {
+		tbl_id = MCDI_ARRAY_DWORD(outbuf, TABLE_LIST_OUT_TABLE_ID, idx);
+		if (tbl_id == tbl_req) {
+			ct_tbl = true;
+			break;
+		}
+	}
+
+	pos += tbl_cnt;
+	if (!ct_tbl && pos < tbl_total)
+		goto more;
+
+	return ct_tbl;
+}
+
+int efx_mae_get_tables(struct efx_nic *efx)
+{
+	int rc;
+
+	efx->tc->meta_ct.hooked = false;
+	if (efx_mae_check_table_exists(efx, TABLE_ID_CONNTRACK_TABLE)) {
+		rc = efx_mae_table_get_desc(efx, &efx->tc->meta_ct.desc,
+					    TABLE_ID_CONNTRACK_TABLE);
+		if (rc) {
+			pci_info(efx->pci_dev,
+				 "FW does not support conntrack desc rc %d\n",
+				 rc);
+			return 0;
+		}
+
+		rc = efx_mae_table_hook_ct(efx, &efx->tc->meta_ct);
+		if (rc) {
+			pci_info(efx->pci_dev,
+				 "FW does not support conntrack hook rc %d\n",
+				 rc);
+			return 0;
+		}
+	} else {
+		pci_info(efx->pci_dev,
+			 "FW does not support conntrack table\n");
+	}
+	return 0;
+}
+
+void efx_mae_free_tables(struct efx_nic *efx)
+{
+	efx_mae_table_free_desc(&efx->tc->meta_ct.desc);
+	efx->tc->meta_ct.hooked = false;
+}
+
 static int efx_mae_get_basic_caps(struct efx_nic *efx, struct mae_caps *caps)
 {
 	MCDI_DECLARE_BUF(outbuf, MC_CMD_MAE_GET_CAPS_OUT_LEN);
diff --git a/drivers/net/ethernet/sfc/mae.h b/drivers/net/ethernet/sfc/mae.h
index 24abfe509690..afdf738254b2 100644
--- a/drivers/net/ethernet/sfc/mae.h
+++ b/drivers/net/ethernet/sfc/mae.h
@@ -66,6 +66,9 @@ int efx_mae_start_counters(struct efx_nic *efx, struct efx_rx_queue *rx_queue);
 int efx_mae_stop_counters(struct efx_nic *efx, struct efx_rx_queue *rx_queue);
 void efx_mae_counters_grant_credits(struct work_struct *work);
 
+int efx_mae_get_tables(struct efx_nic *efx);
+void efx_mae_free_tables(struct efx_nic *efx);
+
 #define MAE_NUM_FIELDS	(MAE_FIELD_ENC_VNET_ID + 1)
 
 struct mae_caps {
diff --git a/drivers/net/ethernet/sfc/mcdi.h b/drivers/net/ethernet/sfc/mcdi.h
index 454e9d51a4c2..995a26686fd8 100644
--- a/drivers/net/ethernet/sfc/mcdi.h
+++ b/drivers/net/ethernet/sfc/mcdi.h
@@ -221,6 +221,9 @@ void efx_mcdi_sensor_event(struct efx_nic *efx, efx_qword_t *ev);
 #define MCDI_BYTE(_buf, _field)						\
 	((void)BUILD_BUG_ON_ZERO(MC_CMD_ ## _field ## _LEN != 1),	\
 	 *MCDI_PTR(_buf, _field))
+#define MCDI_STRUCT_BYTE(_buf, _field)					\
+	((void)BUILD_BUG_ON_ZERO(_field ## _LEN != 1),			\
+	 *MCDI_STRUCT_PTR(_buf, _field))
 #define MCDI_SET_WORD(_buf, _field, _value) do {			\
 	BUILD_BUG_ON(MC_CMD_ ## _field ## _LEN != 2);			\
 	BUILD_BUG_ON(MC_CMD_ ## _field ## _OFST & 1);			\
diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index 4dc881159246..4dc979fdc968 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -1658,13 +1658,19 @@ int efx_init_tc(struct efx_nic *efx)
 	if (rc)
 		return rc;
 	rc = efx_tc_configure_fallback_acts_reps(efx);
+	if (rc)
+		return rc;
+	rc = efx_mae_get_tables(efx);
 	if (rc)
 		return rc;
 	efx->tc->up = true;
 	rc = flow_indr_dev_register(efx_tc_indr_setup_cb, efx);
 	if (rc)
-		return rc;
+		goto out_free;
 	return 0;
+out_free:
+	efx_mae_free_tables(efx);
+	return rc;
 }
 
 void efx_fini_tc(struct efx_nic *efx)
@@ -1680,6 +1686,7 @@ void efx_fini_tc(struct efx_nic *efx)
 	efx_tc_deconfigure_fallback_acts(efx, &efx->tc->facts.pf);
 	efx_tc_deconfigure_fallback_acts(efx, &efx->tc->facts.reps);
 	efx->tc->up = false;
+	efx_mae_free_tables(efx);
 }
 
 /* At teardown time, all TC filter rules (and thus all resources they created)
diff --git a/drivers/net/ethernet/sfc/tc.h b/drivers/net/ethernet/sfc/tc.h
index 1549c3df43bb..27592f10b536 100644
--- a/drivers/net/ethernet/sfc/tc.h
+++ b/drivers/net/ethernet/sfc/tc.h
@@ -143,6 +143,48 @@ enum efx_tc_rule_prios {
 	EFX_TC_PRIO__NUM
 };
 
+struct efx_tc_table_field_fmt {
+	u16 field_id;
+	u16 lbn;
+	u16 width;
+	u8 masking;
+	u8 scheme;
+};
+
+struct efx_tc_table_desc {
+	u16 type;
+	u16 key_width;
+	u16 resp_width;
+	u16 n_keys;
+	u16 n_resps;
+	u16 n_prios;
+	u8 flags;
+	u8 scheme;
+	struct efx_tc_table_field_fmt *keys;
+	struct efx_tc_table_field_fmt *resps;
+};
+
+struct efx_tc_table_ct { /* TABLE_ID_CONNTRACK_TABLE */
+	struct efx_tc_table_desc desc;
+	bool hooked;
+	struct { /* indices of named fields within @desc.keys */
+		u8 eth_proto_idx;
+		u8 ip_proto_idx;
+		u8 src_ip_idx; /* either v4 or v6 */
+		u8 dst_ip_idx;
+		u8 l4_sport_idx;
+		u8 l4_dport_idx;
+		u8 zone_idx; /* for TABLE_FIELD_ID_DOMAIN */
+	} keys;
+	struct { /* indices of named fields within @desc.resps */
+		u8 dnat_idx;
+		u8 nat_ip_idx;
+		u8 l4_natport_idx;
+		u8 mark_idx;
+		u8 counter_id_idx;
+	} resps;
+};
+
 /**
  * struct efx_tc_state - control plane data for TC offload
  *
@@ -155,6 +197,7 @@ enum efx_tc_rule_prios {
  * @encap_match_ht: Hashtable of TC encap matches
  * @match_action_ht: Hashtable of TC match-action rules
  * @neigh_ht: Hashtable of neighbour watches (&struct efx_neigh_binder)
+ * @meta_ct: MAE table layout for conntrack table
  * @reps_mport_id: MAE port allocated for representor RX
  * @reps_filter_uc: VNIC filter for representor unicast RX (promisc)
  * @reps_filter_mc: VNIC filter for representor multicast RX (allmulti)
@@ -186,6 +229,7 @@ struct efx_tc_state {
 	struct rhashtable encap_match_ht;
 	struct rhashtable match_action_ht;
 	struct rhashtable neigh_ht;
+	struct efx_tc_table_ct meta_ct;
 	u32 reps_mport_id, reps_mport_vport_id;
 	s32 reps_filter_uc, reps_filter_mc;
 	bool flush_counters;

