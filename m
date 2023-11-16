Return-Path: <netdev+bounces-48462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B147EE6B6
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 19:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE8F9B20CC1
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 18:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A0248CF7;
	Thu, 16 Nov 2023 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qOSpAH7n"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625C31A8
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 10:29:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYzcKKxDIlrBoxDMgNMaPDERoISubDNlCeS3xKibs+s8MwoOMOG0K3JGVA0xVDqU5tzKHmBsA1RDtrwB73PbeSCobi6yz/tnp011fV9dRHL4ygzUlQ5/EmPfxppvDepP9xG69aB83J+DMZ8GHbOxhR+t20WJx3h5mnXgTmubcOOoWe+ZBBTFIFRb2biCUr6NTamnrjpf+lzqz65DljSDKZ3DLOdxdFWE82rcyy+YPhqBtnJI3a+qFQZgr9PNq/QFZOMqtPk7M2S9Eb55lXikQgljTH5OmPBjRvqyvrpiZ6YujV9GxsqCdua3c5UDFi49qzSA/yEnbDqrXu5Jgn8ZSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9/8G4NNPOSL2c9MUONsG/xC8dRa5Vd6mhMZqNEvtho=;
 b=obXUq2d4groTcUeD/Y2dxhxCHEOC126OmnFgTNPEfhc0k0aaHvc4vgB6pBKCYG9MAfugwT4PVjEgZF3Lttgm93mO+a1cl3bfOMBsgzLstcxd5tyFNedD8hdhY3Ogcoau1urnh5h8ZIz2k+pnSinxy074sltvRT74Y81yt9ogT20a7MH2hSZQ4WyOscpUpa8Btxsu4pxbKGUwgBLtai1LtSV49Ad1tyQvOrx8m6WiFAsPA+n3SKjQJnR6+VCnKmx1p3sf+l8KZ2Hhau/0s3url7RtsATWC0vTu/BaAcqiNfoFhREkksTYusp9v+wdNJ8VbnXBFeR93uIuTAER0z6xYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9/8G4NNPOSL2c9MUONsG/xC8dRa5Vd6mhMZqNEvtho=;
 b=qOSpAH7nre0J9l/GJGYyMuS+5szumcIznK9lBEaVhs4U6Gl7pAyK50KGlsLX6CkbjgbmCuQbcMOFdDwgHjYApq7NlcFW8+sfkxE4VurxA6gA7yh0aWfz17pbAATQWhJQ0HnWkwQgV+xFs4hph+8SHDU2xiVYHkykH0sSK1VLUufH2FY1WpiFi14icMY2S/pffrMHXpmX97QtNtUuh5T0PcZEnHmLos7kE5qKxo+a6ZgYV+jd72EmWC36wqcRaiJK65PyjldUhdytKdFwXWBMZF95WnvhrsEw7f79s0i+Q9a8VC6YSyrd6zqhQj3hBCtzyQ2Q6oRroafAsoR/SxheaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 18:29:14 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::a24:3ff6:51d6:62dc]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::a24:3ff6:51d6:62dc%4]) with mapi id 15.20.7002.019; Thu, 16 Nov 2023
 18:29:14 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: netdev@vger.kernel.org
Cc: Leon Romanovsky <leon@kernel.org>,
	Saeed Mahameed <saeed@kernel.org>,
	Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH RFC net-next v1 2/3] macsec: Detect if Rx skb is macsec-related for offloading devices that update md_dst
Date: Thu, 16 Nov 2023 10:28:59 -0800
Message-Id: <20231116182900.46052-3-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231116182900.46052-1-rrameshbabu@nvidia.com>
References: <20231116182900.46052-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0286.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::21) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CH2PR12MB4088:EE_
X-MS-Office365-Filtering-Correlation-Id: 8324e4eb-16fc-4fed-a84e-08dbe6d1ef49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XBFTxcz6j6cMD7lxhrjWcGYgYsSwtgbkQp0Megg151Lw+V69CtKNVtSEUwm1Jk09tus/W+2p+8z621ZFxBn1CxRdEfKZfKWjxjulfsDtzRX6zrmcCTnCOOf7YgTL4WduDPyAoSr5SRSxX9yD0TR4UV+IMUT01KcPpfCwZ2ORXwIKZG0RzehfVaR1OTWtO6RBaXvBKStVTn0iXzzyC07H0QhdHKewTUYemlErJuE7QWLpS2oJ0JdOFU8LVRN4fwdV2JiekVvo6uuAZClwGr/x6/78wiMpBvfps4ULUCZ6QvWY4zL+oH6T25iiNwue5uEiKyCYsk3Ek+XrPbd/qQ0gsqmOI9cGYXvSeY5w2nvtoM6jwe+gPQuYuVgSR7XF6Zzco18y8YDNCy1YHHqoY5FS6Komt+e6llr5M7ffi5CUtAj4gD8wO/NwYj/LHbNl5P6uwkO2PMCC+bs25GUadBTBAMyumc/Gnidw3UJqObG3WEE7Cmo4vhomBRRp96u/OrKXjztCZYRquwNjTcZ0vOomHpnXEV5OrtSg7e5saWttXoiMbGg1gCP8Io/0MkJ8ohLKWlqGwiHGaZpulJOVRsLIuhP6S1KOed5jvGjZ7NUEfDk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66946007)(41300700001)(66476007)(316002)(6916009)(66556008)(54906003)(8676002)(86362001)(5660300002)(2906002)(15650500001)(4326008)(8936002)(83380400001)(38100700002)(6666004)(966005)(6486002)(478600001)(36756003)(1076003)(2616005)(26005)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kZbWcgfNPMUQIgUBugj0Zt0VH/OFCgldW3EySuRTMr+ByjiRIATgfpfeoZz2?=
 =?us-ascii?Q?MFf2kQ8Uww5RaysWqa3+fDYKOBkn5AbqVNUMuCmpdflbUaVZ/BAbRkLwHWDf?=
 =?us-ascii?Q?B9SpbfztzqxkcASejySqXN4STVZf1pfXowGuCmyCnK6G/u6XuZ05y9Qrk9gZ?=
 =?us-ascii?Q?7gcaKa/nFgRLR7s8gjKTn9z6PXOG03iGkk6lhAUTfJoJy1EYwg2mMnfUNFJN?=
 =?us-ascii?Q?wKBTY08Pl+Ld+a0C+E+GFVJgiBLUy/LIedFeEuRsaTdRxMSEtldfwSG0DPO9?=
 =?us-ascii?Q?U421nLVXNrvg5gjasRm+iwQ9leZCxEJVCyaSiZA1b0FYfrc1LF/wVQrOmp6q?=
 =?us-ascii?Q?QqCsJa9ayXIUewlbkpWuTD5YyWcOYGIN8iuRikCz/gDKbU6cgOBe1RNkrvAX?=
 =?us-ascii?Q?+fhWyJLT4ZpB6ntz1tAAn8PvOZifjorPAHq3z+Ub9zFYB96XKvS7zYv8xeTq?=
 =?us-ascii?Q?fXJxTLkvrNs04IFC0Zf6e8j7WpofUvABmwZ+WZ2Wg/s7/T5r5qLK9Xrsyb+e?=
 =?us-ascii?Q?gUlMoN+5/HXdxAqnHQVyYAqezo5Y2CubwLsOnOy9+iLQ3EZ8E9REI75m/lrX?=
 =?us-ascii?Q?vxVRVUubqut61FlObgHBB2aGqVsT1gHjC8LWwSBx56IOpLFAy7CC1zdkuzsM?=
 =?us-ascii?Q?LjfHsBTO8pRUyrcIxsdBINLn9Xq9FiKKyq+/x/qUx/q9N7uDUR4gDIN/VLhu?=
 =?us-ascii?Q?0eCigbylingklXwmXBw8vHy4RezWggSgPTqfJ+Qgm3wFh+qfdhwOTDFzdLB5?=
 =?us-ascii?Q?0Sawr8xOv+35+CiP4QWXCsg8tmfYYbnF7QwC5c0JAEAtNBnMkewALngqUCY2?=
 =?us-ascii?Q?GookBVSNju9RfZfIxdaIH12pwscS7O0m9QfQVgJql0W/WY6A2yCbUX1tGe0G?=
 =?us-ascii?Q?ixnh4qL57W0WAycHCNQ3+PubNo3twm8QveM2g864E79Ql+3/FgN67nO3lFSM?=
 =?us-ascii?Q?2KeUNDwLX3eWknBXqv/pNyJGJl3lHtrBcwBv8ER1JXvFqISz/CHp3w6ZEAcy?=
 =?us-ascii?Q?BvwWK+09smMXSLxP6YlrMzY2igrDO+6EIamhQ8v+y4UAMi9CT9nGyP3RVKS3?=
 =?us-ascii?Q?X0FEfanK+KgPFfIAKTHQzXCoXxv3d29E8ueTZk1E2A5b/K53TnrTloOO9Z80?=
 =?us-ascii?Q?3JzgfiNttjc5w+gHvS6sGz5uOcnkyd/k7uXl+ZIPPe+UQ3AsgRzNAsR2aMPC?=
 =?us-ascii?Q?wYA/opbTVHYqTiEH1zd3OPyDlbNlkGUc7h7EbrIw0lJnSOpARCsQpAqiNnqF?=
 =?us-ascii?Q?3YrUlrE10rm41vTFEbwnAjQ5/6CeG90fSm69srNumlpbdlwb2TZvnQhx/701?=
 =?us-ascii?Q?F4bg+9yKS9scsRlMoHKju2XSPRBUXKEeBq9D0O3PqY7U2Gw9m0BLkg1QKWaA?=
 =?us-ascii?Q?UaKJNANVvW78lzwti0w/1JfbAVWx4PMenGcRYwrugj7bovOLvU0ke+45bz3o?=
 =?us-ascii?Q?IELBvQiDx8E5tUOoAZgZCBJSwSgmg/HrRES+u9Ea3jBSWZKBLd02x4fCOM/+?=
 =?us-ascii?Q?Xf2KU6k+YXgF0sKZ3YfY2cZJOOCNNSAglEgNesAMWbu4H150rTQFCHGfNxZn?=
 =?us-ascii?Q?w5bSD6crJNs80hson6drM89+dDUtZLhEZa1z/yBPLVEX1R9xM/0+WWXlozB2?=
 =?us-ascii?Q?HA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8324e4eb-16fc-4fed-a84e-08dbe6d1ef49
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 18:29:14.1977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aw3hklFtcKPkxaRXqwaY/3HCMmv9VltZ/oyOf8S1tS9BiP85eX8LuXu7I+DO8ue9gFnPhFzVvxtcxof3nnS5/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088

This detection capability will enable drivers that update md_dst to be able
to receive and handle both non-MACSec and MACsec traffic received and the
same physical port when offload is enabled.

This detection is not possible without device drivers that update md_dst. A
fallback pattern should be used for supporting such device drivers. This
fallback mode causes multicast messages to be cloned to both the non-macsec
and macsec ports, independent of whether the multicast message received was
encrypted over MACsec or not. Other non-macsec traffic may also fail to be
handled correctly for devices in promiscuous mode.

Link: https://lore.kernel.org/netdev/ZULRxX9eIbFiVi7v@hog/
Cc: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---
 drivers/net/macsec.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 8c0b12490e89..e14f2ad2e253 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -1002,6 +1002,7 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
 	rcu_read_lock();
 	rxd = macsec_data_rcu(skb->dev);
 	md_dst = skb_metadata_dst(skb);
+	bool is_macsec_md_dst = md_dst && md_dst->type == METADATA_MACSEC;
 
 	list_for_each_entry_rcu(macsec, &rxd->secys, secys) {
 		struct sk_buff *nskb;
@@ -1014,10 +1015,13 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
 		if (macsec_is_offloaded(macsec) && netif_running(ndev)) {
 			struct macsec_rx_sc *rx_sc = NULL;
 
-			if (md_dst && md_dst->type == METADATA_MACSEC)
+			if (macsec->offload_md_dst && !is_macsec_md_dst)
+				continue;
+
+			if (is_macsec_md_dst)
 				rx_sc = find_rx_sc(&macsec->secy, md_dst->u.macsec_info.sci);
 
-			if (md_dst && md_dst->type == METADATA_MACSEC && !rx_sc)
+			if (is_macsec_md_dst && !rx_sc)
 				continue;
 
 			if (ether_addr_equal_64bits(hdr->h_dest,
-- 
2.40.1


