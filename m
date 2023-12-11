Return-Path: <netdev+bounces-55924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5349180CD9B
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708591C212E8
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F964A99A;
	Mon, 11 Dec 2023 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PMoevxHN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5942B2D74
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 06:08:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcYDN6XC3FseNrfXGi54yRTm1oqG+tAFy02TMl/nAFfwjI9NboKbjCjGMEs92uByfu7S9IAKYwEVxwWPh3bI27PkAtc8ZxvmaFa3qWCDSLfI3AxcwqrarXEDRWL/iSefaScbOtL7x1iC4d3Z0bPTVLQU97JisxZF4mUBBXKGZJL4RsBGQdiUJhLjmVpKnaiN/2Jzj3cNeUYqjgA/n+lDWlCg7cZfG3ioHwwynbyMzR1SURVsBhPYfRf+MdTlm1JYKC4L9Ax+/IHG66syQYxlYPZVkOkFk//VVa+3j5GoAhPgZYS8It/XYsEPnamZ+wNMMeX33Hy+ZWkaPHMQKcjFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2f5sHtkjq5aN5HgzYKRzM5xXUc5vmXYCOFSVzcEZWfQ=;
 b=WsisCxrehd1tC8usFUVbjXUQ5Wmt7VxofAauD4CAK0hZGTRY9Y6+uNJwHz9Ncq1FaCV0u/veWNyiS9jireVfNJWACVSFtBNShI4ZjBS71Dq80l38zIX+eG3Uujilzw9JrZE1LdCZR1FgVQUOeODpmuGAraPjY5clR0MVOjbK7UilQG7/zWi06Knkl5/zkbsOu2anRuN2RLvwcMevWVHEeTs9brnwZkI9nlythCF3Gq3/+VBCKXwWPGG3sovFem5x2zHfVXlJi6dHlldh0dZ72F349LDR7EN+CKwF+NPqi5/Bclivk59GIXRfNma4HThcH9yxq+cAOsnFawpua0Tu/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2f5sHtkjq5aN5HgzYKRzM5xXUc5vmXYCOFSVzcEZWfQ=;
 b=PMoevxHNGPa2LUlkxDiVzDFu3yi11rt91FA3Pua/Mm0R0r9LK2RJ+KkKgsldSZVm9i9Gchm7TA6hLAa3HtlakyRd8zfQDmcmvTpJTsrj+n7PXOkyTSbYVIJ7IVoHxn4xqh/mFRI9qW2VOoEithf0+KBGiwZ+GEPaFv8StrLD7d8GkeeZbFQU8wtEDRsmMosGQW1sy4PBvf5tYTOcfrNtmioc3ClDVCfGsLgczu3TWBjAg8BaKkgagagDKRBSNYVcNrYw7w1sd3/4+zsCzXTzdvOUmA3e8gwSEV76h8kMcz8V3/sTAe2y7DBuypodxv2znOBQ99jypcrMuHf5s62Z8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 14:08:01 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:08:01 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: [PATCH iproute2-next 07/20] bridge: vlan: Remove paranoid check
Date: Mon, 11 Dec 2023 09:07:19 -0500
Message-ID: <20231211140732.11475-8-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211140732.11475-1-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQXP288CA0002.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::19) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: da0e6003-bd79-4b18-852f-08dbfa5295b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TaQ8ui9xD3qHd7eV0XatdpzbqtaSI96wYa2ZUAIy8tkUKov97iqTOT5iSpZ02Sc4QcxRw7Sab2CHMgVfZRB4bvzHp5/VnLcjKJP7/R+GPMinYoOwJht3Y1dLZw82QzDxvgrtb1PZTc4aDrqx1mW3SVRZ023gHf6NYutCm13HDAqPj2JsgzVkac/bHaRxdJQ3qZmDIcunVe6s5gLE4ZghDU9eLyYGU1QG+dUwMZzKaT1gtDSzbMK/LKXjlR76Vw4+heDyyMsA5pcxN26e7Y300w0PlwszxihTIc/0pQjZ6qPZhuJ0MUlUJPIGMTKh7EqAX2YwjJ8+JI7+OeEpmN0PI6vw7gI5qQup9vLlYYIhGi1L20KSss2PvxcY1hT0Q2+IhWIDR8TTmXfFiLTEBBAY5bWIZ4UwhbxEAgj8nFyGitVAnafldkKbTMu6p+r0M0xUaW4lLi56rXqafFFK++VlgzeRSmupnP5bPHX3X1/XJyxsMWKfIsLJ15h3P9QlCaSouPQgjb8HsB7Dk32A5SNnZ3Y8EoZ7wk8mwB+9ZadhFKfKXFHNeEYqrpWwYeE8PK/Q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(2906002)(316002)(6916009)(66946007)(66476007)(66556008)(54906003)(5660300002)(8676002)(8936002)(4326008)(86362001)(36756003)(6512007)(6666004)(6506007)(83380400001)(107886003)(26005)(2616005)(1076003)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rylk8Eon0Mxg57763Pw49TEcM32XVDFhAIG94tp4DlFMJ8YwBXYzA1IUuukU?=
 =?us-ascii?Q?V/p9ihSfl30t8CEurlNUXUR8/aOP7IdIq/XnHoQeEnSbHtdGJfErRZfanE2T?=
 =?us-ascii?Q?7/tthmZdHJ2O8A2T77JF/Bi9ZJCeiC5crJuj/stl4daWntaAU9pdIUxMWlxU?=
 =?us-ascii?Q?4936dv69r0pCsyg3Uu/TveqWJWiIzFGYukw2x/S6KnKPtYZDcwGxL8CbzgRH?=
 =?us-ascii?Q?fHrDBgxD/SiczV4hjL1JsVKOj+k93/HqQOHQiDa0gl4VKiRarQWejnHwhj9R?=
 =?us-ascii?Q?uHG4tV0YKk6ooQg5LlGFeIaUY/jetYiZdah7vLPNmVJgfrXWZ68gXnq+6Emy?=
 =?us-ascii?Q?ZIZAKZ5GOWTo3D2BRXWFI4KEYR1Sls9b0l2sJAlsKawqJPT4BGl+T/4KLMf3?=
 =?us-ascii?Q?K6tpkRqtofwY1mOXR59fR7IzpYG0Kf4GIV/+5mnxkG5f89cykwA1LqnarmXC?=
 =?us-ascii?Q?DJqtLbk7qAIf6Y3aSH2V8ql3tpJMRQDs2b2ONm8VIBmpG3FtZ/dyg7iOsMk0?=
 =?us-ascii?Q?JwpUZaIjg2gpCT7Tn4+EWtRFLLNVtoCCrfpy0T13d+J9exE8fxaWfOFVKT7Q?=
 =?us-ascii?Q?IIzwSE5bYH2n0JUoW2MrJYsZUXrVdLxXyaqEZTrVql3latOqem5s1EoCySS/?=
 =?us-ascii?Q?xsn3Y7713PXtONMpFXwIfIW8IbRd6K5F1arshmg1HGd2roA0tQSdK+2IlUPD?=
 =?us-ascii?Q?1f74v2VkDwevTNzmg+M6az41kL73OV8HGNvPra+X7uRWJo30iTL1uE2Jl5Tw?=
 =?us-ascii?Q?4WYLCAwj1hApbJ5AULLIOt9RAPL3sSUuW7TtEZuQ8ASgwzt9JV1R1UAIesVg?=
 =?us-ascii?Q?0FUFIv4Ox3lqm6n7pNtr9w07YkvdiAIrLB/tt5IWlrjPF16qwOpidQaTFCnp?=
 =?us-ascii?Q?fMGKU0+XAB/tCbOW7TpGHIS4lllumkyklQW0WGE2Nd3r6rXYkh+2XegFU9pW?=
 =?us-ascii?Q?Ny3tF478QnFcz6j5CuyP4NrTQtbgLRZrOII+tY+ISo2h+8js8mqy8CtwtSxy?=
 =?us-ascii?Q?F5A8C5ghLus3SkRfY6pkQ/D2q6GSoRGOyHYPUtpfvcaqcPFxhz/pr3xfZvfz?=
 =?us-ascii?Q?alba2UAEWX35bGiwccbPeyqe2cPskGYDnCYBxT0zZ/+jSK/OwStFkc4Z+qzM?=
 =?us-ascii?Q?hgptH4SppCtD9FnpRUoDZQnd3xZiYbV1ru+bNbGUXDFS0w1TJiTq2UaFjx+E?=
 =?us-ascii?Q?kQJW6P0vqkS5Sbe6af35amLIkBSqAqdVJebAnRObaFzrMoOQ4O2FGegGRXpJ?=
 =?us-ascii?Q?NfPalkFJXPEGoyz75/oA3fuNhL0joy16dAjz/ipQqoVg1gn25zZgxc12Xq2e?=
 =?us-ascii?Q?/VH5GsjThDBMfikIXDt10qzvgI9jgWEe6aoMaLqjSDxCmto5TeW4EZjtAypf?=
 =?us-ascii?Q?4fwdYe5qgqxg/ml8V/yxerS2l2Ewx2//RZQaUVbCnCoySKIXbuiFErHc5kdf?=
 =?us-ascii?Q?Mg0VXTjffS8HvNPw3b1INWgrG7GJ5Xoo1RCOqJJ6GYLvoYmmf9HK6wvK8bfQ?=
 =?us-ascii?Q?kZTmIoV60pY8jCo7Vqz32zUwy21swhvRxjTYfrBTiVelnIyhBWuc5DGfZVFd?=
 =?us-ascii?Q?Bj+H5FXa/2RJBsp36lNCwLFZgVkWEKSg/xbCn1uV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0e6003-bd79-4b18-852f-08dbfa5295b2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:08:01.0147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HZIKIuLo7yKyAplwXEw6AVa+tqc9ujmSfwXhmzv5/S9ohG0R7CgDLIKXaXvyNaZSQ3CyypMMM2l67WBls3pnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193

To make the code lighter, remove the check on the actual print_range()
output width. In the odd case that an out-of-range, wide vlan id is
printed, printf() will treat the negative field width as positive and the
output will simply be further misaligned.

Suggested-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 bridge/vlan.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/bridge/vlan.c b/bridge/vlan.c
index 797b7802..7a175b04 100644
--- a/bridge/vlan.c
+++ b/bridge/vlan.c
@@ -661,13 +661,8 @@ static void print_vlan_tunnel_info(struct rtattr *tb, int ifindex)
 
 		open_json_object(NULL);
 		width = print_range("vlan", last_vid_start, tunnel_vid);
-		if (width <= VLAN_ID_LEN) {
-			if (!is_json_context())
-				printf("%-*s  ", VLAN_ID_LEN - width, "");
-		} else {
-			fprintf(stderr, "BUG: vlan range too wide, %u\n",
-				width);
-		}
+		if (!is_json_context())
+			printf("%-*s  ", VLAN_ID_LEN - width, "");
 		print_range("tunid", last_tunid_start, tunnel_id);
 		close_json_object();
 		print_nl();
-- 
2.43.0


