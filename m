Return-Path: <netdev+bounces-55921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC42480CD98
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4D01C21057
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93F2495EB;
	Mon, 11 Dec 2023 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c59dCil9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5149A2D54
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 06:08:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmF3PRTE3SPQg2DsxqhV4OI9/5vEkVBrVcVOfm5D9Ika4K4qnwrb860TsHwukJXz9mf80F5Dx3fWY9NEYodTaYaLu5haoTOdTfY4PHLmiuG6WxhEQJ976K2k2mzSaTZlAO3WfqqjGBV8nzIughUpZxlMlP8fZgikUJpFKV1AryhrPlLvTt5VVTzQx81usqpCHmSuqFi6Akar3foZ1cEsnlY4vnhLSKkK+X+fFRQ4Dk0roYgS89NazBmjSZ4CBaUfVoWj6lxHApHD3GuZiRKrCEtsVAqMzGvs/5j4KcYfijhW1ELZtBYlpgCQRFl0azUndBnxyhDplmodkB+gPPT4Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Rdau9PYG9AM8qZY0RiFsmr2sIJ+TwVr0mrKyAxtunw=;
 b=EgHHSnq5Kb6Rq5zmv7yvlepikOGx9eaZ7SieU284XwXmptKthugc2TYyeY2fYoO69gTByjX9EilaLpRxBrqY7266HP60qjbmQTuVKxF2O4ACbfu+hE0ZZYldIjaPQ+SdyI7hgPD7+4v7QhDOSnJfJMoLh+AmjsmotGXHPbT4PZX43kCS3Ze1wGSN3uniyGjZKMnQubZc6jFMhVHOw2f+kmDLOSkYxJT0vlp/BkWeQwOcRR87Dz7DAcwfaj4Szh8rin7V7rdKuNrA0QG0HOTJlKhAwEalTuV4eD/WIGEV0nr+3n4J4a0XITpXTinylxn/TBgbkk6eTBucBwhgKReC8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Rdau9PYG9AM8qZY0RiFsmr2sIJ+TwVr0mrKyAxtunw=;
 b=c59dCil9rdKZp1M6K3Y5ikha428otSDFSdwjyLJ1wCfQ7VrKGmGr0XSn+3Ktsy8NfylGrHH54fCliF7qwjD6TTI9qK+zFr+YF1s9wzTOeQsMEBoHv6l48XVCH6u7ta+T4hlII/iSiNolhcRv7F23nKyzPmN/nY9LfYNz4cKjF9LNhM1GzvwavXvKtNOxIQx9JsM9Wg5lIV6cVbXhcNlR6x+knKhNeqRDxsw29XRfbTVlXl1jlZjPIEufKSlDyxyB3s8OKQEBFzCxGZiNuPHgthD6p5N+aDmSJoYkK0e7kS+rsw90jkHBPVusvL3zQ5sOeY4GgjoSKfGnGiDhSJbSww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 14:08:17 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:08:17 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: [PATCH iproute2-next 15/20] bridge: vni: Align output columns
Date: Mon, 11 Dec 2023 09:07:27 -0500
Message-ID: <20231211140732.11475-16-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211140732.11475-1-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0325.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::23) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: 8579c432-535f-49fb-f2ed-08dbfa529fb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IXw57UXKhY7+K7rOifF/U4GgFFxcjTXWPaQ08dtzUOX87rzFw2bUkeCwYpD957n5EykpneX9Bq53UqJlarfsb6ROE4NasLUmGYTmhWYDfJoQlOeeu8BdO5FdMocoYx7enmBdYzpSNnYDNfjLSxumN38PpBciMpmI/TZlpfsO//jt31IzbtcS9pmvkHq/v4R356W9MYgKUrqNlb1PkF7utpO8Bnis+/MjnnDt1Bx4BCMBIPEVHh4vdx1fYQ4FMEzo73ls8DMvmjQfmR9Tz4U1DWoc7hg6hPJRgKWYpqVcpPY5pquyU2OvzTEhx7WsMjq2nCVirJ+WZjTmwB41StpnoQqi8Ga5rRWOH+TxxiQEBtepOF25yQ0nbQE4hswU7fLwhedggFxQ2cCad6TQB5KWUQs4RcZeghR43eAw3FMI3kC6doBABrRVM5Oo9ZvKpdwiT6Xe8gRRjNJ8qRFQ2x7x9OKhrcICJ8WpIL23W9F4u7jroIJCAqyONkXakl4yGwf4fOmce2h2WZqoIQMZ/M/bzWAwgf4PvH3m++9kJl4Kdbqx+NT+RkvM170YJe9LIayS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(6506007)(1076003)(5660300002)(26005)(2616005)(107886003)(36756003)(66946007)(6486002)(54906003)(66476007)(66556008)(6916009)(2906002)(83380400001)(41300700001)(478600001)(86362001)(8676002)(8936002)(4326008)(316002)(38100700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vskvS30Si5ZA/LzBlwNe/1bOIl73RuS0zUm1Rbv20iu5soSsNpsdmaGMGmVk?=
 =?us-ascii?Q?/1jecnLpzAnDZPGyRzM78V++yfW01X9QAyaovzFAOllwrdMLsQQBLcy2Y6Tu?=
 =?us-ascii?Q?CtSvMeA0ghzAF903li95bsK859MGrBvsb9Adhju0ceIGuGjypVSndq+o8SbI?=
 =?us-ascii?Q?opUZc7mUcnRGXj6y5r9v1GcKZPUJlB3BPJxQzmvc1+bpcHdUimWR4fo1hFMi?=
 =?us-ascii?Q?WQU1wxotozLeCh4Ne1iOwK6XyB5oQGR/xRPVi7MBlq3b5vsbAhyDfAiDrgwz?=
 =?us-ascii?Q?QvdmrscvD1z6H5EUibQxSecxgL0At6xoV9FViM264CET4jQHMtJGr6o1AYDI?=
 =?us-ascii?Q?TUCfz7cUsMtmw90+Ml1f6qqhC6pz7PSFgbNK84LezwNdnUXpGBoabxkopA3O?=
 =?us-ascii?Q?90FggD7CBSXeit1M3WJexLd0ytp4HCGEnw4mAGKRDNcklDMzbZAn97hIAn0q?=
 =?us-ascii?Q?qMvVnEzPX0R+tRGh4IutH5jtSzAylEIq6m41lNb2IIgCQg3asUvgJ4R6jlbC?=
 =?us-ascii?Q?/j4dr8xOmlu3UJ4T5bbVQUyVw2/GaVSxGYsa33ZD7arf/U7lycGQxlNnXzjs?=
 =?us-ascii?Q?v3H//4AXyP5vKumh14lfIRQupG5csukvvBZ4CDH1yQ9STs8x8sfn96PhjgD6?=
 =?us-ascii?Q?s+TpAI2bUOIL+7ZSzqhHYSsTItXzYMO8YKP2M9SNhtLyLyFs8L1X13Ky5bzf?=
 =?us-ascii?Q?rcfSa46Z0QZJG0TquG6ZJPOzztxC1rOW2cJY9gDR3V3HV2jZz29ATUBv8woZ?=
 =?us-ascii?Q?kb6ZFOx6XINMHQdE6eMKPu6W5B5b6Uc+EE+scUV+5Me7BpU/8AZAlWLTMP38?=
 =?us-ascii?Q?iG6JZdoo2PFEJnMMpaMwD6z4t2G1x5KAc6s4F1bzLV3S1QK0pcsuEv0UStBZ?=
 =?us-ascii?Q?2zD83GftRM1wvbb3GRBwORSRwikZs7PfQcyDZWYmT6MRKviHx+sr8+Bh1oCk?=
 =?us-ascii?Q?Zi0uByfhHbaoKTKm187mSUol8Nwwn1nVRSLejWdRluJKjK3JkHJZvAn51vrj?=
 =?us-ascii?Q?LcQeEGbAqkGYNDAavnDvjwyoOjz+nrsoaLCEdMlzy4oHWXKLr8i7rmyVbZZI?=
 =?us-ascii?Q?oRQ4jrBs8JJwqbiBbTUPMDe3PYzS3S40HOaOF7/dVmfFeiXCW85G5gQ0viks?=
 =?us-ascii?Q?HhuVErSaqRR+YlP7oN6RNQn1FdQuq7A/cc9pFpC2J8oMuxToz+3+cnyeDI+B?=
 =?us-ascii?Q?r/HOJEo5lKO4UmyhgRli7NToMSkuauEYyOhVbtTvFRxLPCTBFXupGVmgj6Bh?=
 =?us-ascii?Q?iNmY+qkjV/KEtf1By37spX+PwVq+sUAA59uGfT9WvF43LykzEaXDmCDKiuMT?=
 =?us-ascii?Q?6vr2k+E+oPKaWlPmx7uWVSQ0vW5hbvni58yGhE/VbBaycELEZCfUoOz/bQV6?=
 =?us-ascii?Q?HzCEh+xz/g2p57S+Q2cOcEQrXk/fWaOTxSEbhijMCm/lrnz8M8vYHHB5uwKo?=
 =?us-ascii?Q?/0s5dRNQradJNm790EzlB2C/hBnno4A3V85lWQ/IQY7OtAHpL1zu1LJyRPYI?=
 =?us-ascii?Q?skDq42Fv7vD0OwT+plWOiaZvjojXBvegrJzqauMxYOI3tbEE1SMT/P0Tr+hp?=
 =?us-ascii?Q?Nfj7vV3cQ54Zo/2OAoJG2LJSONCWtISlZX4pPRXG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8579c432-535f-49fb-f2ed-08dbfa529fb0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:08:17.7643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZnNUZkrN7taINuj4YwRy/pktH05gUbmVbl4+Eidc6D9ZmriJSpeaSxV7bMug5i5/IO1c/qcITAsVg4/jnL149Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136

Use fixed column widths to improve readability.

These changes are similar to commit e0c457b1a5a2 ("bridge: Align output
columns").

Before:
$ bridge vni
dev               vni              group/remote
vxlan1             4001
                   4002           10.0.0.1
                   5000-5010
                   16777214-16777215        10.0.0.2
vxlan2             100

After:
$ bridge vni
dev               vni                group/remote
vxlan1            4001
                  4002               10.0.0.1
                  5000-5010
                  16777214-16777215  10.0.0.2
vxlan2            100

Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 bridge/vni.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/bridge/vni.c b/bridge/vni.c
index 44781b01..e9943872 100644
--- a/bridge/vni.c
+++ b/bridge/vni.c
@@ -23,7 +23,8 @@
 
 static unsigned int filter_index;
 
-#define VXLAN_ID_LEN 15
+/* max len of "<start>-<end>" */
+#define VXLAN_ID_LEN 17
 
 #define __stringify_1(x...) #x
 #define __stringify(x...) __stringify_1(x)
@@ -162,16 +163,18 @@ static void close_vni_port(void)
 	close_json_object();
 }
 
-static void print_range(const char *name, __u32 start, __u32 id)
+static unsigned int print_range(const char *name, __u32 start, __u32 id)
 {
 	char end[64];
+	int width;
 
 	snprintf(end, sizeof(end), "%sEnd", name);
 
-	print_uint(PRINT_ANY, name, " %u", start);
+	width = print_uint(PRINT_ANY, name, "%u", start);
 	if (start != id)
-		print_uint(PRINT_ANY, end, "-%-14u ", id);
+		width += print_uint(PRINT_ANY, end, "-%u", id);
 
+	return width;
 }
 
 static void print_vnifilter_entry_stats(struct rtattr *stats_attr)
@@ -231,7 +234,8 @@ static void print_vni(struct rtattr *t, int ifindex)
 {
 	struct rtattr *ttb[VXLAN_VNIFILTER_ENTRY_MAX+1];
 	__u32 vni_start = 0;
-	__u32 vni_end = 0;
+	unsigned int width;
+	__u32 vni_end;
 
 	parse_rtattr_flags(ttb, VXLAN_VNIFILTER_ENTRY_MAX, RTA_DATA(t),
 			   RTA_PAYLOAD(t), NLA_F_NESTED);
@@ -241,12 +245,13 @@ static void print_vni(struct rtattr *t, int ifindex)
 
 	if (ttb[VXLAN_VNIFILTER_ENTRY_END])
 		vni_end = rta_getattr_u32(ttb[VXLAN_VNIFILTER_ENTRY_END]);
+	else
+		vni_end = vni_start;
 
 	open_json_object(NULL);
-	if (vni_end)
-		print_range("vni", vni_start, vni_end);
-	else
-		print_uint(PRINT_ANY, "vni", " %-14u", vni_start);
+	width = print_range("vni", vni_start, vni_end);
+	if (!is_json_context())
+		printf("%-*s  ", VXLAN_ID_LEN - width, "");
 
 	if (ttb[VXLAN_VNIFILTER_ENTRY_GROUP]) {
 		__be32 addr = rta_getattr_u32(ttb[VXLAN_VNIFILTER_ENTRY_GROUP]);
@@ -255,12 +260,12 @@ static void print_vni(struct rtattr *t, int ifindex)
 			if (IN_MULTICAST(ntohl(addr)))
 				print_string(PRINT_ANY,
 					     "group",
-					     " %s",
+					     "%s",
 					     format_host(AF_INET, 4, &addr));
 			else
 				print_string(PRINT_ANY,
 					     "remote",
-					     " %s",
+					     "%s",
 					     format_host(AF_INET, 4, &addr));
 		}
 	} else if (ttb[VXLAN_VNIFILTER_ENTRY_GROUP6]) {
@@ -271,14 +276,14 @@ static void print_vni(struct rtattr *t, int ifindex)
 			if (IN6_IS_ADDR_MULTICAST(&addr))
 				print_string(PRINT_ANY,
 					     "group",
-					     " %s",
+					     "%s",
 					     format_host(AF_INET6,
 							 sizeof(struct in6_addr),
 							 &addr));
 			else
 				print_string(PRINT_ANY,
 					     "remote",
-					     " %s",
+					     "%s",
 					     format_host(AF_INET6,
 							 sizeof(struct in6_addr),
 							 &addr));
@@ -382,13 +387,10 @@ static int vni_show(int argc, char **argv)
 		exit(1);
 	}
 
-	if (!is_json_context()) {
+	if (!is_json_context())
 		printf("%-" __stringify(IFNAMSIZ) "s  %-"
-		       __stringify(VXLAN_ID_LEN) "s  %-"
-		       __stringify(15) "s",
-		       "dev", "vni", "group/remote");
-		printf("\n");
-	}
+		       __stringify(VXLAN_ID_LEN) "s  group/remote\n", "dev",
+		       "vni");
 
 	ret = rtnl_dump_filter(&rth, print_vnifilter_rtm, NULL);
 	if (ret < 0) {
-- 
2.43.0


