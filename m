Return-Path: <netdev+bounces-24981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EC977268F
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 15:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C164280E4D
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 13:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E90111B8;
	Mon,  7 Aug 2023 13:49:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DCF1118A
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 13:49:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C221722
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 06:49:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4WhEEN49YT0nQ6z6sVAEx+6jhRh2qi/uXiTOMeHXqw7CAGB7oYRUfd4sKSBtdDswGuBVKSrNLJ7go5ENFvxxbDCG9BXpAiF7EcLJesUSGo8PAFqnFBEFLvDWY62W54fHYm+0SJSwF1wNvRN/E/cbx5/s5taRw/Ibt0kjZIBa6SmoOULCDPwHcmojzfSlYUADokkkRcF5+6zRhgkeejMOngIkPbsWEjXPA9ex8r9z6MG9hFv3PTmelckT0kDKeeiWgyr9PwVZJUlKMAUhWkfmvidORwqFAAq+wKawekHUx9O0gTPQ7meHiMqbOTzc9+4/s42qlHL4Wik9Wm9ECEBug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqWV3Jn+qkhWwyG+/kOE+tz4lvuH52+TzjFiDuVFHiA=;
 b=hz5I2lxi61Oj5J2sYNbxXF0Y/4WgivA65pKbALx5ZFHu3Cw1lWiiQDIk7/HpL6Z277XImxdEyfFmb20eSlMuE6gntn6GRR4eUtOh7fAoFAFz6h1oZlmkHuTX9V00RUU9B5jiNp45fQHgj3TL+EednQEgsPFbQZ3OvrYrRZxqf0S6pcT65weYrW1B+uxpkOQAgMbqySwV8hDRYeeIwVwpsOfQI8lfsjS30wFj+kIUIcLFPPKfH2dW82unsnqqMvxU938h6AOW0+MaU4z60H8nBPi45MwfWtTyRZl+HOcvNeYr9qbx+lOPIDQ/mZmIpw4aoo1u5DMnIdMSC+d/ptdfqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqWV3Jn+qkhWwyG+/kOE+tz4lvuH52+TzjFiDuVFHiA=;
 b=aX91/BWlfSkgUICf+X1s/v1YLTrcFtBOhcA8B1Abmm0s5wT1ff9VY2wFWGtN991J1tWi7ktKSJh0C71doR2JrqOa1r9h9dzxiUjlp+YN9+EwS4vHon9W7FEUQwLSOP4rWfCrsT4v6ljuingYlACVC577RXIZbs7sBXIwsr461H4=
Received: from BYAPR04CA0024.namprd04.prod.outlook.com (2603:10b6:a03:40::37)
 by MN6PR12MB8516.namprd12.prod.outlook.com (2603:10b6:208:46f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Mon, 7 Aug
 2023 13:49:26 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::51) by BYAPR04CA0024.outlook.office365.com
 (2603:10b6:a03:40::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Mon, 7 Aug 2023 13:49:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 13:49:24 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 08:49:16 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 06:49:16 -0700
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Mon, 7 Aug 2023 08:49:15 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, Pieter Jansen van Vuuren
	<pieter.jansen-van-vuuren@amd.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH v2 net-next 3/7] sfc: functions to insert/remove conntrack entries to MAE hardware
Date: Mon, 7 Aug 2023 14:48:07 +0100
Message-ID: <2d4f6577dcbb6a7c6377c98385e9fe8d0351b737.1691415479.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1691415479.git.ecree.xilinx@gmail.com>
References: <cover.1691415479.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|MN6PR12MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: f8012fac-bacf-4b40-edf7-08db974d1c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TrgY7PEGKpR/B9iEpgVbeBN5BYHEP7/w+qwubJbaX0yb0bfWic1zsevQejSE5/Lv3Hki895UrZB7Ng9IPu9gGrb8a56wXZmE9h7c90x9SwGmv3DnARxOx2P/GG/UBfKvnP/4TkNb986Z863mGrNFU3B0fP/T9woyswKNaiX9hNBGJupRrv1v3DomnXTf8Vt+xZ8LunxQQcVsqe0XJBZ+BwSG/COaJAB708YR+FCpj4XVK0jKrBzwsVm09/rshDmYaj8sQzmB31MJZDAN/qmGXkLK+7uaGOIhdoZPRr4BC5aqsjiapHXOpFl680CRp5HhM3mpACXPxbaYBdq4xF0FUR7AdiN/WViB9Wk1TQlS05o9cnzbPN7NTQdNgdLXwFDpNE5Nc8I13NvltwJRqqCuWOO6NA4ijPQia79vlbH4DQ3nd93vxRLFQ6YkfRzhW3V01T6ojR1fYVnfHHp+eavMz4Q3M1nfJrmBDIPBFgLvqM0pvt2qfSQGmXDpFB+h0v0vsURxl1ZbMnuvfaiCOAxubBg0HRVw8KauRYv4jVExJ6MtXdASSfTRKWTRo6IXlHJr6XXX5XKgQJCduZG/lC8WYeIcQKH+kk8FQDkQEZ7xbDrzmLHpyZUho8st0rPAdB0z0pkZ0CiyBFQXzX7J7BANGEFiIZQmK5Qh3dsNDDDuS3H0bNoiYJYYTIxh3YWVuxbGr7wUbGXAk3sAk7+7XgtK5aX7hkW8+2C+96KL/0fBZHSsvr9wbz+Tskn/9NyxHDxWBkKJ6o+ROlLvW2KuITZgKw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(82310400008)(1800799003)(186006)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(9686003)(6666004)(478600001)(86362001)(82740400003)(55446002)(81166007)(26005)(36756003)(41300700001)(356005)(30864003)(316002)(5660300002)(8936002)(8676002)(54906003)(110136005)(4326008)(2906002)(2876002)(70206006)(70586007)(336012)(83380400001)(47076005)(36860700001)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 13:49:24.8677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8012fac-bacf-4b40-edf7-08db974d1c8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8516
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

Translate from software struct efx_tc_ct_entry objects to the key
 and response bitstrings, and implement insertion and removal of
 these entries from the hardware table.
Callers of these functions will be added in subsequent patches.

Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/mae.c          | 257 ++++++++++++++++++++++++
 drivers/net/ethernet/sfc/mae.h          |   3 +
 drivers/net/ethernet/sfc/tc_conntrack.h |  14 ++
 3 files changed, 274 insertions(+)

diff --git a/drivers/net/ethernet/sfc/mae.c b/drivers/net/ethernet/sfc/mae.c
index 33ae2c852b44..8ebf71a54bf9 100644
--- a/drivers/net/ethernet/sfc/mae.c
+++ b/drivers/net/ethernet/sfc/mae.c
@@ -16,6 +16,7 @@
 #include "mcdi_pcol.h"
 #include "mcdi_pcol_mae.h"
 #include "tc_encap_actions.h"
+#include "tc_conntrack.h"
 
 int efx_mae_allocate_mport(struct efx_nic *efx, u32 *id, u32 *label)
 {
@@ -1403,6 +1404,262 @@ int efx_mae_unregister_encap_match(struct efx_nic *efx,
 	return 0;
 }
 
+/* Populating is done by taking each byte of @value in turn and storing
+ * it in the appropriate bits of @row.  @value must be big-endian; we
+ * convert it to little-endianness as we go.
+ */
+static int efx_mae_table_populate(struct efx_tc_table_field_fmt field,
+				  __le32 *row, size_t row_bits,
+				  void *value, size_t value_size)
+{
+	unsigned int i;
+
+	/* For now only scheme 0 is supported for any field, so we check here
+	 * (rather than, say, in calling code, which knows the semantics and
+	 * could in principle encode for other schemes).
+	 */
+	if (field.scheme)
+		return -EOPNOTSUPP;
+	if (DIV_ROUND_UP(field.width, 8) != value_size)
+		return -EINVAL;
+	if (field.lbn + field.width > row_bits)
+		return -EINVAL;
+	for (i = 0; i < value_size; i++) {
+		unsigned int bn = field.lbn + i * 8;
+		unsigned int wn = bn / 32;
+		u64 v;
+
+		v = ((u8 *)value)[value_size - i - 1];
+		v <<= (bn % 32);
+		row[wn] |= cpu_to_le32(v & 0xffffffff);
+		if (wn * 32 < row_bits)
+			row[wn + 1] |= cpu_to_le32(v >> 32);
+	}
+	return 0;
+}
+
+static int efx_mae_table_populate_bool(struct efx_tc_table_field_fmt field,
+				       __le32 *row, size_t row_bits, bool value)
+{
+	u8 v = value ? 1 : 0;
+
+	if (field.width != 1)
+		return -EINVAL;
+	return efx_mae_table_populate(field, row, row_bits, &v, 1);
+}
+
+static int efx_mae_table_populate_ipv4(struct efx_tc_table_field_fmt field,
+				       __le32 *row, size_t row_bits, __be32 value)
+{
+	/* IPv4 is placed in the first 4 bytes of an IPv6-sized field */
+	struct in6_addr v = {};
+
+	if (field.width != 128)
+		return -EINVAL;
+	v.s6_addr32[0] = value;
+	return efx_mae_table_populate(field, row, row_bits, &v, sizeof(v));
+}
+
+static int efx_mae_table_populate_u24(struct efx_tc_table_field_fmt field,
+				      __le32 *row, size_t row_bits, u32 value)
+{
+	__be32 v = cpu_to_be32(value);
+
+	/* We adjust value_size here since just 3 bytes will be copied, and
+	 * the pointer to the value is set discarding the first byte which is
+	 * the most significant byte for a big-endian 4-bytes value.
+	 */
+	return efx_mae_table_populate(field, row, row_bits, ((void *)&v) + 1,
+				      sizeof(v) - 1);
+}
+
+#define _TABLE_POPULATE(dst, dw, _field, _value) ({	\
+	typeof(_value) _v = _value;			\
+							\
+	(_field.width == sizeof(_value) * 8) ?		\
+	 efx_mae_table_populate(_field, dst, dw, &_v,	\
+				sizeof(_v)) : -EINVAL;	\
+})
+#define TABLE_POPULATE_KEY_IPV4(dst, _table, _field, _value)		       \
+	efx_mae_table_populate_ipv4(efx->tc->meta_##_table.desc.keys	       \
+				    [efx->tc->meta_##_table.keys._field##_idx],\
+				    dst, efx->tc->meta_##_table.desc.key_width,\
+				    _value)
+#define TABLE_POPULATE_KEY(dst, _table, _field, _value)			\
+	_TABLE_POPULATE(dst, efx->tc->meta_##_table.desc.key_width,	\
+			efx->tc->meta_##_table.desc.keys		\
+			[efx->tc->meta_##_table.keys._field##_idx],	\
+			_value)
+
+#define TABLE_POPULATE_RESP_BOOL(dst, _table, _field, _value)			\
+	efx_mae_table_populate_bool(efx->tc->meta_##_table.desc.resps		\
+				    [efx->tc->meta_##_table.resps._field##_idx],\
+				    dst, efx->tc->meta_##_table.desc.resp_width,\
+				    _value)
+#define TABLE_POPULATE_RESP(dst, _table, _field, _value)		\
+	_TABLE_POPULATE(dst, efx->tc->meta_##_table.desc.resp_width,	\
+			efx->tc->meta_##_table.desc.resps		\
+			[efx->tc->meta_##_table.resps._field##_idx],	\
+			_value)
+
+#define TABLE_POPULATE_RESP_U24(dst, _table, _field, _value)		       \
+	efx_mae_table_populate_u24(efx->tc->meta_##_table.desc.resps	       \
+				   [efx->tc->meta_##_table.resps._field##_idx],\
+				   dst, efx->tc->meta_##_table.desc.resp_width,\
+				   _value)
+
+static int efx_mae_populate_ct_key(struct efx_nic *efx, __le32 *key, size_t kw,
+				   struct efx_tc_ct_entry *conn)
+{
+	bool ipv6 = conn->eth_proto == htons(ETH_P_IPV6);
+	int rc;
+
+	rc = TABLE_POPULATE_KEY(key, ct, eth_proto, conn->eth_proto);
+	if (rc)
+		return rc;
+	rc = TABLE_POPULATE_KEY(key, ct, ip_proto, conn->ip_proto);
+	if (rc)
+		return rc;
+	if (ipv6)
+		rc = TABLE_POPULATE_KEY(key, ct, src_ip, conn->src_ip6);
+	else
+		rc = TABLE_POPULATE_KEY_IPV4(key, ct, src_ip, conn->src_ip);
+	if (rc)
+		return rc;
+	if (ipv6)
+		rc = TABLE_POPULATE_KEY(key, ct, dst_ip, conn->dst_ip6);
+	else
+		rc = TABLE_POPULATE_KEY_IPV4(key, ct, dst_ip, conn->dst_ip);
+	if (rc)
+		return rc;
+	rc = TABLE_POPULATE_KEY(key, ct, l4_sport, conn->l4_sport);
+	if (rc)
+		return rc;
+	rc = TABLE_POPULATE_KEY(key, ct, l4_dport, conn->l4_dport);
+	if (rc)
+		return rc;
+	return TABLE_POPULATE_KEY(key, ct, zone, cpu_to_be16(conn->zone->zone));
+}
+
+int efx_mae_insert_ct(struct efx_nic *efx, struct efx_tc_ct_entry *conn)
+{
+	bool ipv6 = conn->eth_proto == htons(ETH_P_IPV6);
+	__le32 *key = NULL, *resp = NULL;
+	size_t inlen, kw, rw;
+	efx_dword_t *inbuf;
+	int rc = -ENOMEM;
+
+	/* Check table access is supported */
+	if (!efx->tc->meta_ct.hooked)
+		return -EOPNOTSUPP;
+
+	/* key/resp widths are in bits; convert to dwords for IN_LEN */
+	kw = DIV_ROUND_UP(efx->tc->meta_ct.desc.key_width, 32);
+	rw = DIV_ROUND_UP(efx->tc->meta_ct.desc.resp_width, 32);
+	BUILD_BUG_ON(sizeof(__le32) != MC_CMD_TABLE_INSERT_IN_DATA_LEN);
+	inlen = MC_CMD_TABLE_INSERT_IN_LEN(kw + rw);
+	if (inlen > MC_CMD_TABLE_INSERT_IN_LENMAX_MCDI2)
+		return -E2BIG;
+	inbuf = kzalloc(inlen, GFP_KERNEL);
+	if (!inbuf)
+		return -ENOMEM;
+
+	key = kcalloc(kw, sizeof(__le32), GFP_KERNEL);
+	if (!key)
+		goto out_free;
+	resp = kcalloc(rw, sizeof(__le32), GFP_KERNEL);
+	if (!resp)
+		goto out_free;
+
+	rc = efx_mae_populate_ct_key(efx, key, kw, conn);
+	if (rc)
+		goto out_free;
+
+	rc = TABLE_POPULATE_RESP_BOOL(resp, ct, dnat, conn->dnat);
+	if (rc)
+		goto out_free;
+	/* No support in hw for IPv6 NAT; field is only 32 bits */
+	if (!ipv6)
+		rc = TABLE_POPULATE_RESP(resp, ct, nat_ip, conn->nat_ip);
+	if (rc)
+		goto out_free;
+	rc = TABLE_POPULATE_RESP(resp, ct, l4_natport, conn->l4_natport);
+	if (rc)
+		goto out_free;
+	rc = TABLE_POPULATE_RESP(resp, ct, mark, cpu_to_be32(conn->mark));
+	if (rc)
+		goto out_free;
+	rc = TABLE_POPULATE_RESP_U24(resp, ct, counter_id, conn->cnt->fw_id);
+	if (rc)
+		goto out_free;
+
+	MCDI_SET_DWORD(inbuf, TABLE_INSERT_IN_TABLE_ID, TABLE_ID_CONNTRACK_TABLE);
+	MCDI_SET_WORD(inbuf, TABLE_INSERT_IN_KEY_WIDTH,
+		      efx->tc->meta_ct.desc.key_width);
+	/* MASK_WIDTH is zero as CT is a BCAM */
+	MCDI_SET_WORD(inbuf, TABLE_INSERT_IN_RESP_WIDTH,
+		      efx->tc->meta_ct.desc.resp_width);
+	memcpy(MCDI_PTR(inbuf, TABLE_INSERT_IN_DATA), key, kw * sizeof(__le32));
+	memcpy(MCDI_PTR(inbuf, TABLE_INSERT_IN_DATA) + kw * sizeof(__le32),
+	       resp, rw * sizeof(__le32));
+
+	BUILD_BUG_ON(MC_CMD_TABLE_INSERT_OUT_LEN);
+
+	rc = efx_mcdi_rpc(efx, MC_CMD_TABLE_INSERT, inbuf, inlen, NULL, 0, NULL);
+
+out_free:
+	kfree(resp);
+	kfree(key);
+	kfree(inbuf);
+	return rc;
+}
+
+int efx_mae_remove_ct(struct efx_nic *efx, struct efx_tc_ct_entry *conn)
+{
+	__le32 *key = NULL;
+	efx_dword_t *inbuf;
+	size_t inlen, kw;
+	int rc = -ENOMEM;
+
+	/* Check table access is supported */
+	if (!efx->tc->meta_ct.hooked)
+		return -EOPNOTSUPP;
+
+	/* key width is in bits; convert to dwords for IN_LEN */
+	kw = DIV_ROUND_UP(efx->tc->meta_ct.desc.key_width, 32);
+	BUILD_BUG_ON(sizeof(__le32) != MC_CMD_TABLE_DELETE_IN_DATA_LEN);
+	inlen = MC_CMD_TABLE_DELETE_IN_LEN(kw);
+	if (inlen > MC_CMD_TABLE_DELETE_IN_LENMAX_MCDI2)
+		return -E2BIG;
+	inbuf = kzalloc(inlen, GFP_KERNEL);
+	if (!inbuf)
+		return -ENOMEM;
+
+	key = kcalloc(kw, sizeof(__le32), GFP_KERNEL);
+	if (!key)
+		goto out_free;
+
+	rc = efx_mae_populate_ct_key(efx, key, kw, conn);
+	if (rc)
+		goto out_free;
+
+	MCDI_SET_DWORD(inbuf, TABLE_DELETE_IN_TABLE_ID, TABLE_ID_CONNTRACK_TABLE);
+	MCDI_SET_WORD(inbuf, TABLE_DELETE_IN_KEY_WIDTH,
+		      efx->tc->meta_ct.desc.key_width);
+	/* MASK_WIDTH is zero as CT is a BCAM */
+	/* RESP_WIDTH is zero for DELETE */
+	memcpy(MCDI_PTR(inbuf, TABLE_DELETE_IN_DATA), key, kw * sizeof(__le32));
+
+	BUILD_BUG_ON(MC_CMD_TABLE_DELETE_OUT_LEN);
+
+	rc = efx_mcdi_rpc(efx, MC_CMD_TABLE_DELETE, inbuf, inlen, NULL, 0, NULL);
+
+out_free:
+	kfree(key);
+	kfree(inbuf);
+	return rc;
+}
+
 static int efx_mae_populate_match_criteria(MCDI_DECLARE_STRUCT_PTR(match_crit),
 					   const struct efx_tc_match *match)
 {
diff --git a/drivers/net/ethernet/sfc/mae.h b/drivers/net/ethernet/sfc/mae.h
index afdf738254b2..24f29a4fc0e1 100644
--- a/drivers/net/ethernet/sfc/mae.h
+++ b/drivers/net/ethernet/sfc/mae.h
@@ -112,6 +112,9 @@ int efx_mae_register_encap_match(struct efx_nic *efx,
 				 struct efx_tc_encap_match *encap);
 int efx_mae_unregister_encap_match(struct efx_nic *efx,
 				   struct efx_tc_encap_match *encap);
+struct efx_tc_ct_entry; /* see tc_conntrack.h */
+int efx_mae_insert_ct(struct efx_nic *efx, struct efx_tc_ct_entry *conn);
+int efx_mae_remove_ct(struct efx_nic *efx, struct efx_tc_ct_entry *conn);
 
 int efx_mae_insert_rule(struct efx_nic *efx, const struct efx_tc_match *match,
 			u32 prio, u32 acts_id, u32 *id);
diff --git a/drivers/net/ethernet/sfc/tc_conntrack.h b/drivers/net/ethernet/sfc/tc_conntrack.h
index f1e5fb74a73f..a3e518344cbc 100644
--- a/drivers/net/ethernet/sfc/tc_conntrack.h
+++ b/drivers/net/ethernet/sfc/tc_conntrack.h
@@ -33,5 +33,19 @@ struct efx_tc_ct_zone *efx_tc_ct_register_zone(struct efx_nic *efx, u16 zone,
 void efx_tc_ct_unregister_zone(struct efx_nic *efx,
 			       struct efx_tc_ct_zone *ct_zone);
 
+struct efx_tc_ct_entry {
+	unsigned long cookie;
+	struct rhash_head linkage;
+	__be16 eth_proto;
+	u8 ip_proto;
+	bool dnat;
+	__be32 src_ip, dst_ip, nat_ip;
+	struct in6_addr src_ip6, dst_ip6;
+	__be16 l4_sport, l4_dport, l4_natport; /* Ports (UDP, TCP) */
+	struct efx_tc_ct_zone *zone;
+	u32 mark;
+	struct efx_tc_counter *cnt;
+};
+
 #endif /* CONFIG_SFC_SRIOV */
 #endif /* EFX_TC_CONNTRACK_H */

