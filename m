Return-Path: <netdev+bounces-55922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4CE80CD9A
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286F91F21832
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8D64A986;
	Mon, 11 Dec 2023 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wc46B/23"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B085184
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 06:08:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CI6tbiOq7MOcKUiztG1uWT4zFqSX2l2UQw/KKSklb5zm7/g2Ib9QslyZkTG9G+5uhyEXDSWqqgtg8TSVqIZGB6IplbiAG7DQbr50Y3qOvXRlphIshWaveFlgnX8VtXOpX2KRxXXaqtl3VR2IFGUwhTB8c5cXkA0mMrVZ0QAwbsXa9mQK9gSJWeulpwqSSRBlRHxEZ/GGH1RvR4/rHVulRvwfEOJTaoJW7DcxSNyEvAHldbRChZB1KqOC+HicMRdoaqdIR8In08acdLybQ2lt/DKd3PvSD/y9rrvrf5wfM+aaUhrUhJzIN79UjZGrzZAlbOliH7GPtW2aKEB2Uy4Amg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cp4t4t0ripjSMkC9FatbZH+vNgAO0yUpab33gxUwfWM=;
 b=Qs8QXGVBTU9NQd/M5QWXIJWSBcZFbqXYZqayjIfxA7rpYnvmfdjciuDfLacxg6CLh/AdOmikPBkfg7mvKVZYAcf2mOJAQRpM7K5leCDUTQfwEuKS0T9mfsoO64yoEnLMPd1EO1y67rvY7lBo3FAvrmoIbkNStamgJkyWbD6Rr1qrcR0ygNQXN93z9zmqRa4xCawB0RAI7c0Azy2HD8UTdbZaM6huqtPxSBxbEdgVba4owpVSBx4wk9nbGCptWp9icRDoVmQTiqCxbG8tu8L4JdO/ExNxKOtWCqYAitjobDrV4WLqVca3FUtQXjGj50BtCY+QTWTTgOeXVwPN9gnB4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cp4t4t0ripjSMkC9FatbZH+vNgAO0yUpab33gxUwfWM=;
 b=Wc46B/23gu0OQdwgNHfXROqgk6z2uzb/+kGrkNc6+nhCIBq9QvsOouE51c7QzDQrg2WiOtY754xGYyIhW2nuqzDtsPVZR29/lxHlfLv0ZUndKU08CVb0Ltr+tqpiE47EJkOrixC2uKE9sVSAx8Vu42nPuIdrhxEDmJu/PbpZDAbr2r+R5eKbD6WQkX2vFvFFwpxJN2BN54W/UsMrcsHMmo/Bc8SJcrnbvuj5OXuV4/s9LV8x1sOg4AFitpsOXr4Gi3bYoEX19dmXmtqRI5Wo7oyUHaDAqfJXq4O29QEq7oO0KZ/nc0fUfJlpZ44yW52GYSq0q9/r3XZPDsB4X5r1Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 14:07:59 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:07:59 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: [PATCH iproute2-next 06/20] bridge: vlan: Use printf() to avoid temporary buffer
Date: Mon, 11 Dec 2023 09:07:18 -0500
Message-ID: <20231211140732.11475-7-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211140732.11475-1-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0324.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::28) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: 152851ab-f1d8-440e-ee07-08dbfa5294bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	96t5+vRxR0sOo+W2c9ItuUwhw1eRYrdCueZhPEkn96IKUDpU+4wCh0VdGXiDlY8UkSE00nghnegb0Bhu1V392/1sxkmH9p78wrxCKlrCLl6lzipy4xW4A1KamzsZmkDcAAgz6KRcajLOFbq/2MwQyrW5vJ0bgimet5ZoWPmA0Up6mNxsvOHcAgRFpARpy0HVzubbWH2CYmMChIPQf4XMjNpEUiCUy/C0Pe04rivFFHpjvTRr7iExaGyb4VQdeqynQjbvv3zKyLkfsS/m90sSX3OcmM/5t7nyF8SR5/cvPDRutkS1nhBKuVJXRjkbnxPct9rwiOkqhsMQGZfklvOkMrnZz7xsBAS2mnLYW/tBdylccKPyP4RjIGANwQ0gFCmkQ8G8xdXWf91wLygR6D+9ssSFUWNdvVO/Rju0KFJO73CqX2Pt2YuldeAOrE9qJEu3R0RPuZ7M5UniN1O2anxWGkvVAc1eyF5AKyD3PA5foq+8Hjj1nP4OtKI7HXSdIYl6yqwNSkvB0ipw0gbqlFg9thHRuunvHOTzZN2ATo7HVp2XOFweduNo4pVLJcw0dVEi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(2906002)(316002)(6916009)(66946007)(66476007)(66556008)(54906003)(5660300002)(8676002)(8936002)(4326008)(86362001)(36756003)(6512007)(6666004)(6506007)(83380400001)(107886003)(26005)(2616005)(1076003)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eX+/z93eym44//d4wfW/6xDQpZVkxSyCU6wBYyQcPcEW4WcSdo4QL90zKmaU?=
 =?us-ascii?Q?shmY8bu5/1+dDDBIX2Pp6Jk7x8gGVwy9AE+9aoYjk7h4W7SZVGvFU8PGD+AD?=
 =?us-ascii?Q?pCMkgsFbLmVifEidiFYvRgd+oNl84mE4/U/k32XYE4urXxMFPKjeeaTeimEf?=
 =?us-ascii?Q?E7IqFdMAG0hVr5o71arPfIXfQ+4eU6S/l1KG/gsMAgeZxjeoxkWZC9l/T+MW?=
 =?us-ascii?Q?PhQb0SrdQxVQM7qWiBxfc5kBqG+ohGJKucA9eHhowZJO+gulL9dUpV9UJXF9?=
 =?us-ascii?Q?0eOLJREqxdueiznQOpWWlK4f9pu+r0i3SKEgW42cMIRiLAqumTHWIfhY7fYJ?=
 =?us-ascii?Q?nEVfxwOjDv7XGsyj6lJh94QzA2onMODswT/cvveicczs+Dykg1E62kbEtDkd?=
 =?us-ascii?Q?KZjhHPYQ0HBwZ932FeY/RtxbbZd7JRQtdjPV3zX6cSWoutiV2ymPuJXmRDKT?=
 =?us-ascii?Q?y+nVOQoIk+Ai+iy31DbxnynQ0FxQ57HVSP4h8NXbaI0xJLIO6ViEoLsHTQes?=
 =?us-ascii?Q?Uu/C3Mb74m9nH+brmEHCbug3yXF7WFZweT7GY6E6VAsflHUooBZSzZuIU8uz?=
 =?us-ascii?Q?vKNcm711Ftna/1FykExcTpLdHTj/AD5flr+Tiye7Ak8mWI2dg3eHpjfO6P5i?=
 =?us-ascii?Q?6aOOkwDhxUjuWDrHlzbaleVZx1Xx73DM/THMsx9MLKwJCPQbhbsGFf/RDI6G?=
 =?us-ascii?Q?kIOh9m20xqHPkrxUFLgGkfL75SZNSEbYiGipH98oTl5lpEIDtuYImsC098kM?=
 =?us-ascii?Q?QwNcJ6jt0STIw02dqE8mqUrs5BZUYnogj0CDr90B8mNUWVnb4HQA//UNfTUT?=
 =?us-ascii?Q?M65zxLyrRBmqri8NU58GkeVjzZ0l32HAOBMCBcpf4dqhrXx8Y18LcQCFpRze?=
 =?us-ascii?Q?A/yTAEcFuen9T3XGa/4CBAxk4K/Dpu9Qqws6gheq3dYr5hyIXJsm59PrIaW+?=
 =?us-ascii?Q?qjbdvg60AUkOqrjRBzspmNpVvG8LnhgCka8XaDVJfriYzsJbKjkyokYAremc?=
 =?us-ascii?Q?Vb3kQEEtB27arAvGFWuJaGvvmSl71iSsUZftzYjh8E4mxgcRx8EtdDVPhlS1?=
 =?us-ascii?Q?CSpDh71JdbVkFqTjh3wpnNjwxdLpbhqIKM3l5zFcLYPz1HR1tcppa3NfNixX?=
 =?us-ascii?Q?1Odd6b3DDPBkrjy8N8+xt1tE3imZO2+vrn9T26qUXmXtrUAcWWIbZb5AhD1l?=
 =?us-ascii?Q?vfT3R/hlvbFNKLwmjn5TRIeCR97+gkrgZH67Fg1aGymxxLJoLrcZSIKs2ohy?=
 =?us-ascii?Q?FVoINJ2EvhmEw10YcGtaMIXHgK81JZusJ1KBCP3YOP5jkQYTwplMsPMTqXjN?=
 =?us-ascii?Q?EnKbyqqSYS/AHoxL0kl1P38h8S1jVCJICWFMOEYvbU2MQF9VnqVsL4Pkb3vW?=
 =?us-ascii?Q?+rSaMzk0KWx455kzqXP/INvSb30KV/whFQOcUrjOtZyRepoMBtrYXuN0hUSy?=
 =?us-ascii?Q?m+iDYWVXMmKqElrMfdqyeBvMoIUi1kCId7A7iYFrlTIenIzf2ThlR6B98To/?=
 =?us-ascii?Q?x1isG7jFEc9HvS8W+krOoWNk9+obDwA7hnp7T0IRR89EyXj7GnvAzXzarkFf?=
 =?us-ascii?Q?060FZsCaImFQC8+uwpZaXbxckLr1BWkguiywstnJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 152851ab-f1d8-440e-ee07-08dbfa5294bc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:07:59.3973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: opPsqao7OJa0RySNVtfgzIBslKTp2R09JO6sRh0Dhnw1pA2J4i91gBLWB2rUhI1Mf6VWJit2Vzh1xCzNghpZPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193

Currently, print_vlan_tunnel_info() is first outputting a formatted string
to a temporary buffer in order to use print_string() which can handle json
or normal text mode. Since this specific string is only output in normal
text mode, by calling printf() directly, we can avoid the need to first
output to a temporary string buffer.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 bridge/vlan.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/bridge/vlan.c b/bridge/vlan.c
index dfc62f83..797b7802 100644
--- a/bridge/vlan.c
+++ b/bridge/vlan.c
@@ -662,11 +662,8 @@ static void print_vlan_tunnel_info(struct rtattr *tb, int ifindex)
 		open_json_object(NULL);
 		width = print_range("vlan", last_vid_start, tunnel_vid);
 		if (width <= VLAN_ID_LEN) {
-			char buf[VLAN_ID_LEN + 1];
-
-			snprintf(buf, sizeof(buf), "%-*s",
-				 VLAN_ID_LEN - width, "");
-			print_string(PRINT_FP, NULL, "%s  ", buf);
+			if (!is_json_context())
+				printf("%-*s  ", VLAN_ID_LEN - width, "");
 		} else {
 			fprintf(stderr, "BUG: vlan range too wide, %u\n",
 				width);
-- 
2.43.0


