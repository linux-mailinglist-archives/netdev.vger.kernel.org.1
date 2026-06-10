Return-Path: <netdev+bounces-297476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PDQQJ5wDKWpoOwMAu9opvQ
	(envelope-from <netdev+bounces-297476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:26:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8366663A2
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:26:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=shLVBjyF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297476-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297476-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31C8631CA911
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D51E371D01;
	Wed, 10 Jun 2026 06:19:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013045.outbound.protection.outlook.com [40.107.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC8637267B
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 06:19:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781072346; cv=fail; b=jviH6CNfLpBL5II0aWd1nBp7HOSpcSHljMSr/uqwxxmyneWtT3kZJdS4SorFcyvjfD5990Zw27AhNBaQLKHLb/O90phKhmZPJFJee6O4JTiTbkz26UZrPtX6DbMe7ZWjQvQ0siKvtvRNasCcHKzWGsxttt1xd6rJBsygIUKcjf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781072346; c=relaxed/simple;
	bh=Y+6wZ2oKR+XI3IPJHVNlzt2aebJQEoWUAjrYdhyEUjM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JykVHJU/vPZC4HBQht4F14PsHgkMc7jb6PSy/TcTPnzxf3LtO4IJES7vxOhYge8QLyZ25UKacMTy5u/Zcsp9O5rvCz7zJc9V/imccjX8cJflwV5+/YBtU4oAsZhczC/paZtOHgfFe2p4p9uar6/XPVNQ6UM4wCo48e2uEgInw1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=shLVBjyF; arc=fail smtp.client-ip=40.107.201.45
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MeMS6cK/+/+2lOkuWv9jjbGMpm6vBm1G+JA1UbARzU4zSXINfTWtBIG6IuFjYKvtS/1GL7VdWEqzyiKBNkSPy+/EftQD1biqVpNnfxTWj04jSf9ZQtd2f+b9AFGVYB3h+7xl/QGEONgeaEj7ErIckFkNABfe2MdW7CgG7q9XS8Atrkvdm5EWIfOtBTJa7SFDCqCkV9DRM9F2tEPse9DgnTCU8YzPnTI6h7+msAXhH+F6tnm5PfglP9GaEsOn6qRqfuT/yVBK0AlNafgYarZTAxwcVj1DTH3abOc8JdNU/qIIhCoyBkJGK5BN9BFFCOr70MbqusygYifKyFpCxnmv4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVlfZO/QWhve/iw/G5HjGpVhUwYrb9sx1aNKOPF3nIU=;
 b=rKfrbSicaPdjBE5XC/UPB+pSxtiClThrzYrKj7kGV+FlKVVuaG4rqAl1BQrDYAEB/Rs9RbgpLylfM3PgPEQM/In5RMIKKnmOJJzzoGMS48U35lV7AcoTlojQUEil7Jb22A3PRllZKPaItei2qA1C0u9s9Eh9TIHfunsBlrXLcmqim6LcpfjJPhzvj4vK6Wu7cOQODlFSzVqvt1Ux9qceXV67MCkHRzQserrQ7oPcsa9+N93i/z85/z2DQYK6DzA8xmQQi7x3D4BaZvnA8D/Wam9wI13N+n4RQQPqxslWcohimJWlLeE/m6cWZs3qKFEDDVKuqm97psKhCDJEZORyQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVlfZO/QWhve/iw/G5HjGpVhUwYrb9sx1aNKOPF3nIU=;
 b=shLVBjyFfgKxj/5PAMLelZJ42Fn6sf5XOg18x/IYtcfpEobeYUujitn3VRmIJcWjuvpSOE+BFNVR9EETrTpWL4MOfWWQqfOq3JmFBqyhAfgt1yhHohqHyndQhKqdaGmFIfJzv5qOGEjvdfSimePNtes9NEtc1CiF4U+1fqcba6M=
Received: from MN2PR14CA0012.namprd14.prod.outlook.com (2603:10b6:208:23e::17)
 by PH8PR12MB7135.namprd12.prod.outlook.com (2603:10b6:510:22c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 06:18:53 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::af) by MN2PR14CA0012.outlook.office365.com
 (2603:10b6:208:23e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 06:18:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 06:18:53 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 01:18:51 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>, Eric Joyner
	<eric.joyner@amd.com>
Subject: [PATCH net-next v4 2/5] ionic: Update ionic_if.h with new extra port stats
Date: Tue, 9 Jun 2026 23:18:27 -0700
Message-ID: <20260610061830.51037-3-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260610061830.51037-1-eric.joyner@amd.com>
References: <20260610061830.51037-1-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|PH8PR12MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: b96f13b3-8dba-4562-76b0-08dec6b82570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|6133799003|3023799007|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	lS5s7Y7Y/gO3LWMSRSMlPSeH+2WDE23rjVP8I9MIMasAoKyIQD3wlF1trgDEjua9sWQWgHNyYizklD3cuaVJOmUZqkmNWLQxCXS1VFGirry2rFzXd0owpkrETTxY4LwzDTbl6XEUpuEmjeYF/J5PTZnONEE/BYdKhb1Y4C5Q+9stpwXEykDWPPOPYeSnYbsC1XwfdnF/tTJ3wc0SCkDsDfZMd8A0/TYnSOpvZHmNguhq2Qe78SAgpBF86Ay8TXkSmwAE9H83pu84X0urcIYarAcPKulWXekXifk0+S79NHlZds/bBREzQHxriX54T/rjizKIxvVqeyGJXX41xfTfEQ9hW+MGQBwfa5FcE4Vbwp8k9zAQhITsETTlj9uYl5rcmr2Xa3CYJcaRvT/ffPMcDn0h9x3tjPGLnbpOZ0LaNis9czTPkPHwDZn2Wtgzmjf4NFDm/tBrYIkakLdq/3h7nMF610SwhHbaaG1d5bpLPgntlJnhMxkyiVkrVPQzlIyf09jUUesecqKXK5zUJm2oU3d04hJWoxl9i1NtKLL2ue9hMH1TOC++vi7JXE/Wo9VYFmFQKzP7pPcyXtHenT4pFZrcrK1pQgvllEHFjO/942X5DzYwC/HtoN5VXWUqIKVN1OyWa7bZ6TcT6mKYJq3CH+ywzkeDL/i8Wav3hO19sJcgkurRBHmXQjbcxNF5KsgzAYjdiv0bcThhmZ1+kB40bIg/rH+kl+VyfK44W868QC0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(6133799003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vzyezhXyyGXt2/VRYZB79ERRzk5SqQvhB4HVNxftdUn3DLYPseLu71+JfskOmd7g6DPRPPkfvgFpKaYX3+IxDuSb98eb3Z0Db0YBVX708RKWVj4iZZvvbXWGL0ikqufluMJjBOHeb8Hq/KNbkXIcVG2TkF8CtM8rCcXBZaXNC+qhXooFIofTJ4wvjFLPM6m1QYNs+M8/i3S2vJKhV5a0U3ZB2l7XtNuYts7q1r848W50xNoPkn3WIlP1icVFRVWxIJkhutWnLDGpZB9BrER8J9gPBSHH1x1AAuGBxYrDnIARxP+r/REv7Z+haCug/cV1DZtn9Ny8Rc2Y8KiAYFuXBZO0dwhmnwnNa6hwFBpLL2cWzYukVWGPXTYIcsCbwby03bEDaGKpaBZig68Qp3koXt6Mh27oQV4udTAd7Yee+/OOY6J0Xqn26YGMeoTU0MbS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 06:18:53.7152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b96f13b3-8dba-4562-76b0-08dec6b82570
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7135
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297476-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:eric.joyner@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A8366663A2

Add a new structure to report additional statistics from the firmware to
struct ionic_port_info. This new struct currently only contains FEC
related statistics, but any new port-level statistics collected by the
firmware would go into it.

The new structure is located in the same area as the unused
ionic_port_pb_stats structure, so this patch also removes that since it
was never used in this driver.

Finally, to indicate firmware support for the new structure, introduce a
new device capability that the driver can use to see if the attached
device supports reporting these extra stats.

Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_if.h    | 39 +++++++------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_if.h b/drivers/net/ethernet/pensando/ionic/ionic_if.h
index 23d6e2b4791e..e84df6115a77 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_if.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_if.h
@@ -7,6 +7,7 @@
 #define IONIC_DEV_INFO_SIGNATURE		0x44455649      /* 'DEVI' */
 #define IONIC_DEV_INFO_VERSION			1
 #define IONIC_IFNAMSIZ				16
+#define IONIC_STAT_INVALID			((__le64)-1)
 
 /*
  * enum ionic_cmd_opcode - Device commands
@@ -273,10 +274,12 @@ union ionic_drv_identity {
  * enum ionic_dev_capability - Device capabilities
  * @IONIC_DEV_CAP_VF_CTRL:     Device supports VF ctrl operations
  * @IONIC_DEV_CAP_DISC_CMB:    Device supports CMB discovery operations
+ * @IONIC_DEV_CAP_EXTRA_STATS: Device supports extra stats schema
  */
 enum ionic_dev_capability {
 	IONIC_DEV_CAP_VF_CTRL        = BIT(0),
 	IONIC_DEV_CAP_DISC_CMB       = BIT(1),
+	IONIC_DEV_CAP_EXTRA_STATS    = BIT(4),
 };
 
 /**
@@ -2855,6 +2858,14 @@ struct ionic_mgmt_port_stats {
 	__le64 frames_tx_pause;
 };
 
+struct ionic_port_extra_stats {
+	__le64 rsfec_correctable_blocks;
+	__le64 rsfec_uncorrectable_blocks;
+	__le64 fec_corrected_bits_total;
+	__le64 rx_bits_phy;
+	__le64 fec_codeword_error_bin[16];
+};
+
 enum ionic_pb_buffer_drop_stats {
 	IONIC_BUFFER_INTRINSIC_DROP = 0,
 	IONIC_BUFFER_DISCARDED,
@@ -2883,28 +2894,6 @@ enum ionic_oflow_drop_stats {
 	IONIC_OFLOW_DROP_MAX,
 };
 
-/* struct ionic_port_pb_stats - packet buffers system stats
- * uses ionic_pb_buffer_drop_stats for drop_counts[]
- */
-struct ionic_port_pb_stats {
-	__le64 sop_count_in;
-	__le64 eop_count_in;
-	__le64 sop_count_out;
-	__le64 eop_count_out;
-	__le64 drop_counts[IONIC_BUFFER_DROP_MAX];
-	__le64 input_queue_buffer_occupancy[IONIC_QOS_TC_MAX];
-	__le64 input_queue_port_monitor[IONIC_QOS_TC_MAX];
-	__le64 output_queue_port_monitor[IONIC_QOS_TC_MAX];
-	__le64 oflow_drop_counts[IONIC_OFLOW_DROP_MAX];
-	__le64 input_queue_good_pkts_in[IONIC_QOS_TC_MAX];
-	__le64 input_queue_good_pkts_out[IONIC_QOS_TC_MAX];
-	__le64 input_queue_err_pkts_in[IONIC_QOS_TC_MAX];
-	__le64 input_queue_fifo_depth[IONIC_QOS_TC_MAX];
-	__le64 input_queue_max_fifo_depth[IONIC_QOS_TC_MAX];
-	__le64 input_queue_peak_occupancy[IONIC_QOS_TC_MAX];
-	__le64 output_queue_buffer_occupancy[IONIC_QOS_TC_MAX];
-};
-
 /**
  * struct ionic_port_identity - port identity structure
  * @version:        identity structure version
@@ -2950,7 +2939,7 @@ union ionic_port_identity {
  * @sprom_page2:     Extended Transceiver sprom, page 2
  * @sprom_page17:    Extended Transceiver sprom, page 17
  * @rsvd:            reserved byte(s)
- * @pb_stats:        uplink pb drop stats
+ * @extra_stats:     Extra port statistics data
  */
 struct ionic_port_info {
 	union ionic_port_config config;
@@ -2968,9 +2957,7 @@ struct ionic_port_info {
 		};
 	};
 	u8     rsvd[376];
-
-	/* pb_stats must start at 2k offset */
-	struct ionic_port_pb_stats  pb_stats;
+	struct ionic_port_extra_stats extra_stats;
 };
 
 /*
-- 
2.17.1


