Return-Path: <netdev+bounces-43036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E9E7D1129
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 16:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3131C20EFC
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E971CFA6;
	Fri, 20 Oct 2023 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="plwzcFyo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70F712E65
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:02:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9DE91
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 07:02:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvvhSd0jm5g/bR9ViLqljCbVyH0+ShnBABDznmOW7LVp0ZUOQT60rx8u7vtxQyVE4aeXaKBTHJ0MiN3ME9cpsINC1fzXCPxr9/eu3oLxHT5m1+LpgUcR1Y3c40M5P6PO4vI2L70a7PdNQu/pHJ9SVl5in8BJ6tvfTiKjiSstOkVJ9zhGm1lLttbKXwOA/+IH8zmC0CccPWIQJKkQGZOAkk6MJ1FgoEzDqyeHYosp/8OYGYrsUcG5oOPMQTG/dABWEvPgjPe7esf9zeQIKQbA/S4a81GHZQgqTCUHNw/r9NI7CGL0Q+gyvuLmu0s4cGLkNk/kyEiDk4GIkdXUVd2qDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8m3vQFHXEIglWJZ7Jhoq69U2v0yNTW2dF4AY88WXf8=;
 b=dH8FPSdtIXKgSueA9+mZPLkvjNFPwk2FX/vg8MUIbu9BrCS0nLpTMSNlWjEuwO8h75A+LZgxlELIh+XcLrrdELnKmyj+K1SuSiBV1Do1nknkiBsYJhQ9azuUErsqZ/KyxzSJ+Ks+mMUdojfjRvTRdhZHYIF1y2zjyK584hp+7173pIJWTzWBpEG2cRTAConVWXAd1l2/+BWlwxYhWF2+hzVPs1TEYnMMxCl5VcwsdnPAscQaY25PUFaW5xs7AGkHqV3IvfUcS5ITw6Tkk3MWMk27NyfnUQ2vinQ/LFQBowMZ/n4Xx+PjJ6qKrMYsS55vO5m2NcHmnG/GwCVLqRG6qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8m3vQFHXEIglWJZ7Jhoq69U2v0yNTW2dF4AY88WXf8=;
 b=plwzcFyoLvnG+aCqQWuCkj+hGml3fOb7UGmWxXKJnJQqLx7d34AR3E3nZHZjKmlQIuaVOZhu9cK08DdJ6+/c2kAYCn8Q2RpgDBt82MGddl3+qKTegyvFDQrSrcDe+zNDF7tRewufrmYfjLx4CegiGM3B44mqk99ajc/6F6+j8b8=
Received: from PR3P195CA0012.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:b6::17)
 by CY8PR12MB7657.namprd12.prod.outlook.com (2603:10b6:930:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Fri, 20 Oct
 2023 14:02:08 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10a6:102:b6:cafe::70) by PR3P195CA0012.outlook.office365.com
 (2603:10a6:102:b6::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24 via Frontend
 Transport; Fri, 20 Oct 2023 14:02:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Fri, 20 Oct 2023 14:02:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 09:02:05 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 09:02:01 -0500
Received: from xcbpieterj41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Fri, 20 Oct 2023 09:02:00 -0500
From: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
To: <netdev@vger.kernel.org>, <linux-net-drivers@amd.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH net] sfc: cleanup and reduce netlink error messages
Date: Fri, 20 Oct 2023 15:01:49 +0100
Message-ID: <20231020140149.30490-1-pieter.jansen-van-vuuren@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|CY8PR12MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: 9482b18d-0fb7-4175-3431-08dbd175258c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I5CtkaLWmfkcK2ycDi5I3UQIBvdMgfDrHdyUKZOXEzYaPrORY9zSRbPIOISXNS/EKFDj99/qtqxA1gB+lV5V6DS2qrlJs/gF3QUw0TwHkwnTun9GjlJlnnz8367SxhTr6QIidvqI3kCQJIfzAP7yaDxXiWnRX3maHUjgjWF9IfWQDDgBvD/yBKzQZYNHdS11tAEDZaqjHZf+HtkIMAVoswTx+LZNwC8FmH4ynmytOE3IILDgfp7EPBkwltetX89WJIrbiYqn78ZAKJqsdDErsi3xyiZxf7p6T/ZUx4UdyGX5E1C61jdmzzXiB/Gq8pmtgW73RQzv6mETNSQ7b2V2+5fUtSd7QbzZiAuIgU962AsCUTXDQV4SHSpl0Co+sIvJuV+6ymbaoUKD5Ee3rsaLUzsI9gwATktaxr14/eYd4uS/tRf3aUdBuv2rKjyXISWtEpwkQRY0+GEyz+AcRiKNdnCb6vqyIu95cuOvLjm+Y3rrgWJnqg+sqAe8F6QzMDPCXd9CReU31b+6B5Y07/yc4KGXsCYJXb1ExNj+EcP8ZzHVlcvciKcAwHnAWYo1XrW/3rS55qVh+KD70POW4RKcSV6GWu0wqKDBrP2yRLpKlkQJfQtM0m0SSMMJEhIV8ZQr9pDtZZax9Hn/hKw6C+qf+JkcmILWL5VByqW/PYHLqnP/jmLLHt/z7SOj/sIPbjbuG7iscjr45Dt06Sj2BoAbc0owwrnwLlVlAJdngjR6CjTS9FE78IeoKZgD2IkDRsDoY1oERnYrwu0hJdgzdVPCqQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(82310400011)(186009)(36840700001)(40470700004)(46966006)(83380400001)(86362001)(316002)(40460700003)(36756003)(2616005)(81166007)(478600001)(6636002)(1076003)(70206006)(70586007)(2906002)(8676002)(5660300002)(54906003)(8936002)(41300700001)(4326008)(110136005)(6666004)(40480700001)(966005)(15650500001)(426003)(336012)(356005)(26005)(82740400003)(36860700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 14:02:07.3756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9482b18d-0fb7-4175-3431-08dbd175258c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7657

Reduce the length of netlink error messages as they are likely to be
truncated anyway. Additionally, reword netlink error messages so they
are more consistent with previous messages.

Fixes: 9dbc8d2b9a02 ("sfc: add decrement ipv6 hop limit by offloading set hop limit actions")
Fixes: 3c9561c0a5b9 ("sfc: support TC decap rules matching on enc_ip_tos")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310202136.4u7bv0hp-lkp@intel.com/
Signed-off-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/tc.c | 38 +++++++++++++++++------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index 834f000ba1c4..30ebef88248d 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -629,14 +629,14 @@ static int efx_tc_flower_record_encap_match(struct efx_nic *efx,
 			}
 			if (child_ip_tos_mask != old->child_ip_tos_mask) {
 				NL_SET_ERR_MSG_FMT_MOD(extack,
-						       "Pseudo encap match for TOS mask %#04x conflicts with existing pseudo(MASK) entry for TOS mask %#04x",
+						       "Pseudo encap match for TOS mask %#04x conflicts with existing mask %#04x",
 						       child_ip_tos_mask,
 						       old->child_ip_tos_mask);
 				return -EEXIST;
 			}
 			if (child_udp_sport_mask != old->child_udp_sport_mask) {
 				NL_SET_ERR_MSG_FMT_MOD(extack,
-						       "Pseudo encap match for UDP src port mask %#x conflicts with existing pseudo(MASK) entry for mask %#x",
+						       "Pseudo encap match for UDP src port mask %#x conflicts with existing mask %#x",
 						       child_udp_sport_mask,
 						       old->child_udp_sport_mask);
 				return -EEXIST;
@@ -1081,7 +1081,7 @@ static int efx_tc_pedit_add(struct efx_nic *efx, struct efx_tc_action_set *act,
 			/* check that we do not decrement ttl twice */
 			if (!efx_tc_flower_action_order_ok(act,
 							   EFX_TC_AO_DEC_TTL)) {
-				NL_SET_ERR_MSG_MOD(extack, "Unsupported: multiple dec ttl");
+				NL_SET_ERR_MSG_MOD(extack, "multiple dec ttl are not supported");
 				return -EOPNOTSUPP;
 			}
 			act->do_ttl_dec = 1;
@@ -1106,7 +1106,7 @@ static int efx_tc_pedit_add(struct efx_nic *efx, struct efx_tc_action_set *act,
 			/* check that we do not decrement hoplimit twice */
 			if (!efx_tc_flower_action_order_ok(act,
 							   EFX_TC_AO_DEC_TTL)) {
-				NL_SET_ERR_MSG_MOD(extack, "Unsupported: multiple dec ttl");
+				NL_SET_ERR_MSG_MOD(extack, "multiple dec ttl are not supported");
 				return -EOPNOTSUPP;
 			}
 			act->do_ttl_dec = 1;
@@ -1120,7 +1120,7 @@ static int efx_tc_pedit_add(struct efx_nic *efx, struct efx_tc_action_set *act,
 	}
 
 	NL_SET_ERR_MSG_FMT_MOD(extack,
-			       "Unsupported: ttl add action type %x %x %x/%x",
+			       "ttl add action type %x %x %x/%x is not supported",
 			       fa->mangle.htype, fa->mangle.offset,
 			       fa->mangle.val, fa->mangle.mask);
 	return -EOPNOTSUPP;
@@ -1164,7 +1164,7 @@ static int efx_tc_mangle(struct efx_nic *efx, struct efx_tc_action_set *act,
 		case 0:
 			if (fa->mangle.mask) {
 				NL_SET_ERR_MSG_FMT_MOD(extack,
-						       "Unsupported: mask (%#x) of eth.dst32 mangle",
+						       "mask (%#x) of eth.dst32 mangle is not supported",
 						       fa->mangle.mask);
 				return -EOPNOTSUPP;
 			}
@@ -1184,7 +1184,7 @@ static int efx_tc_mangle(struct efx_nic *efx, struct efx_tc_action_set *act,
 				mung->dst_mac_16 = 1;
 			} else {
 				NL_SET_ERR_MSG_FMT_MOD(extack,
-						       "Unsupported: mask (%#x) of eth+4 mangle is not high or low 16b",
+						       "mask (%#x) of eth+4 mangle is not high or low 16b",
 						       fa->mangle.mask);
 				return -EOPNOTSUPP;
 			}
@@ -1192,7 +1192,7 @@ static int efx_tc_mangle(struct efx_nic *efx, struct efx_tc_action_set *act,
 		case 8:
 			if (fa->mangle.mask) {
 				NL_SET_ERR_MSG_FMT_MOD(extack,
-						       "Unsupported: mask (%#x) of eth.src32 mangle",
+						       "mask (%#x) of eth.src32 mangle is not supported",
 						       fa->mangle.mask);
 				return -EOPNOTSUPP;
 			}
@@ -1201,7 +1201,7 @@ static int efx_tc_mangle(struct efx_nic *efx, struct efx_tc_action_set *act,
 			mung->src_mac_32 = 1;
 			return efx_tc_complete_mac_mangle(efx, act, mung, extack);
 		default:
-			NL_SET_ERR_MSG_FMT_MOD(extack, "Unsupported: mangle eth+%u %x/%x",
+			NL_SET_ERR_MSG_FMT_MOD(extack, "mangle eth+%u %x/%x is not supported",
 					       fa->mangle.offset, fa->mangle.val, fa->mangle.mask);
 			return -EOPNOTSUPP;
 		}
@@ -1217,7 +1217,7 @@ static int efx_tc_mangle(struct efx_nic *efx, struct efx_tc_action_set *act,
 			/* check that pedit applies to ttl only */
 			if (fa->mangle.mask != ~EFX_TC_HDR_TYPE_TTL_MASK) {
 				NL_SET_ERR_MSG_FMT_MOD(extack,
-						       "Unsupported: mask (%#x) out of range, only support mangle action on ipv4.ttl",
+						       "mask (%#x) out of range, only support mangle action on ipv4.ttl",
 						       fa->mangle.mask);
 				return -EOPNOTSUPP;
 			}
@@ -1227,7 +1227,7 @@ static int efx_tc_mangle(struct efx_nic *efx, struct efx_tc_action_set *act,
 			 */
 			if (match->mask.ip_ttl != U8_MAX) {
 				NL_SET_ERR_MSG_FMT_MOD(extack,
-						       "Unsupported: only support mangle ipv4.ttl when we have an exact match on ttl, mask used for match (%#x)",
+						       "only support mangle ttl when we have an exact match, current mask (%#x)",
 						       match->mask.ip_ttl);
 				return -EOPNOTSUPP;
 			}
@@ -1237,7 +1237,7 @@ static int efx_tc_mangle(struct efx_nic *efx, struct efx_tc_action_set *act,
 			 */
 			if (match->value.ip_ttl == 0) {
 				NL_SET_ERR_MSG_MOD(extack,
-						   "Unsupported: we cannot decrement ttl past 0");
+						   "decrement ttl past 0 is not supported");
 				return -EOPNOTSUPP;
 			}
 
@@ -1245,7 +1245,7 @@ static int efx_tc_mangle(struct efx_nic *efx, struct efx_tc_action_set *act,
 			if (!efx_tc_flower_action_order_ok(act,
 							   EFX_TC_AO_DEC_TTL)) {
 				NL_SET_ERR_MSG_MOD(extack,
-						   "Unsupported: multiple dec ttl");
+						   "multiple dec ttl is not supported");
 				return -EOPNOTSUPP;
 			}
 
@@ -1259,7 +1259,7 @@ static int efx_tc_mangle(struct efx_nic *efx, struct efx_tc_action_set *act,
 			fallthrough;
 		default:
 			NL_SET_ERR_MSG_FMT_MOD(extack,
-					       "Unsupported: only support mangle on the ttl field (offset is %u)",
+					       "only support mangle on the ttl field (offset is %u)",
 					       fa->mangle.offset);
 			return -EOPNOTSUPP;
 		}
@@ -1275,7 +1275,7 @@ static int efx_tc_mangle(struct efx_nic *efx, struct efx_tc_action_set *act,
 			/* check that pedit applies to ttl only */
 			if (fa->mangle.mask != EFX_TC_HDR_TYPE_HLIMIT_MASK) {
 				NL_SET_ERR_MSG_FMT_MOD(extack,
-						       "Unsupported: mask (%#x) out of range, only support mangle action on ipv6.hop_limit",
+						       "mask (%#x) out of range, only support mangle action on ipv6.hop_limit",
 						       fa->mangle.mask);
 
 				return -EOPNOTSUPP;
@@ -1286,7 +1286,7 @@ static int efx_tc_mangle(struct efx_nic *efx, struct efx_tc_action_set *act,
 			 */
 			if (match->mask.ip_ttl != U8_MAX) {
 				NL_SET_ERR_MSG_FMT_MOD(extack,
-						       "Unsupported: only support mangle ipv6.hop_limit when we have an exact match on ttl, mask used for match (%#x)",
+						       "only support hop_limit when we have an exact match, current mask (%#x)",
 						       match->mask.ip_ttl);
 				return -EOPNOTSUPP;
 			}
@@ -1296,7 +1296,7 @@ static int efx_tc_mangle(struct efx_nic *efx, struct efx_tc_action_set *act,
 			 */
 			if (match->value.ip_ttl == 0) {
 				NL_SET_ERR_MSG_MOD(extack,
-						   "Unsupported: we cannot decrement hop_limit past 0");
+						   "decrementing hop_limit past 0 is not supported");
 				return -EOPNOTSUPP;
 			}
 
@@ -1304,7 +1304,7 @@ static int efx_tc_mangle(struct efx_nic *efx, struct efx_tc_action_set *act,
 			if (!efx_tc_flower_action_order_ok(act,
 							   EFX_TC_AO_DEC_TTL)) {
 				NL_SET_ERR_MSG_MOD(extack,
-						   "Unsupported: multiple dec ttl");
+						   "multiple dec ttl is not supported");
 				return -EOPNOTSUPP;
 			}
 
@@ -1318,7 +1318,7 @@ static int efx_tc_mangle(struct efx_nic *efx, struct efx_tc_action_set *act,
 			fallthrough;
 		default:
 			NL_SET_ERR_MSG_FMT_MOD(extack,
-					       "Unsupported: only support mangle on the hop_limit field");
+					       "only support mangle on the hop_limit field");
 			return -EOPNOTSUPP;
 		}
 	default:
-- 
2.25.1


