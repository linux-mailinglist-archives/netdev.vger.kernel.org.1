Return-Path: <netdev+bounces-45577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79927DE69B
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 21:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8DF281296
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 20:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D131A262;
	Wed,  1 Nov 2023 20:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qgqDqzoI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1126C1079C
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 20:02:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D6E119
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 13:02:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3TYUzHdXxnvyzl0imf0EtTHV0ftxJDuuOLsVc8cIpwW+DS7yInATd7lDniGSWVbwwyu58AloVmed9Jkmxt8bwle1VNoo5xFanAbg4xqHjOMferV9523jFTNNrzyL5V2HYwvbqY/subMJ7dgZqoj33uFQMMoMaDMnCfLwVmgo15FmACSn6BAZNoGfBUsf+pW4nNhBaSNIUyTo5UV1Xp6BewRke09qSTpcIUh3UIAwm4UvbNSwRyU3PJM0nnehi4Ccf7XAF65JAi8MLwj9NcIjmgvUEqvd8O+c7omzSY7YRCGdbBerEq+uIddQUElAICOn2RGyZCa5p/zduA+OMnBYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFDOUQBpOpxqG/1zx76VnXMUQ6O8ZWiNSdK+B4343/k=;
 b=bNtddQaqX/vEC1tBE+LV7zvfsd1Uk1g8Uyx+B+zlaYwt7/PE8OfSbd78zNSCb+V+CprMFWfzZ4gCuqxSnU0ZtzPAe28DI6Qp8T97GddCmr1zBc8REWzXOUi40c+Lggc6QRJomoylXSNHLy6mMsdWneHKv9Ep8Of1BwhWxal3LPpMflA7d4AhR118m+rbQvS7Oit/gGilRmFhfB44+9bx1+T7ZNu7o1Jv+v1E+gUil3W6dG+F5wIcleBxePAJet6i0nfcluxCmihirl8Apd7x/Q89NxKtf6y+o4SPcUK2zfa2zvcXfBTh7YnMquB6xf7z7S+1W1xjSs3SzEG7bhDakQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFDOUQBpOpxqG/1zx76VnXMUQ6O8ZWiNSdK+B4343/k=;
 b=qgqDqzoITUIQeL/Lh79cwKG6o5pTYmfaK3l/xy5+4QdXIh8Y4emHkWNA1OrNrHLq6GJO/t3seCsw/x05HUOn/oDd5eUoKBlrDHZ/n4ggnkZQeZn0znKMDauYNLy20EqaZnhqelUVue2KTcgv/NEYAhB8Fm0FBns2/9rWjeViMvPlMy1tr4ko++suHR2NqubtUJZrJ7N0yz3oEOXjB2XCTjql8+zisiWiqyz9PeZb8um3XP62K54h4FpS4mdtMOB+qElWqfblJHusZR61fQ1homX38E3iU5URvGH6AKuY9Y+x2LvIniKrVJdhDSEPNgdDpRUzbhKu9FxFaM/4f8xaYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by BN9PR12MB5273.namprd12.prod.outlook.com (2603:10b6:408:11e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 20:02:25 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::a24:3ff6:51d6:62dc]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::a24:3ff6:51d6:62dc%4]) with mapi id 15.20.6933.029; Wed, 1 Nov 2023
 20:02:25 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net] macsec: Abort MACSec Rx offload datapath when skb is not marked with MACSec metadata
Date: Wed,  1 Nov 2023 13:02:17 -0700
Message-Id: <20231101200217.121789-1-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::19) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|BN9PR12MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: f05aeaf1-7424-4f98-d54b-08dbdb1577c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YKSrwXPH5M1eSpsxq2YVwAgbBmmb4Vtk0IUv8eMJxZLpNM8FTB9nKAQVeovykvw7WbTCDo4f5IYps8QVZv/7fM6u4L5PF8omSOZv+dFPKWkMk+/MTMuw2e07Fs8TY/JV3NyTKVAcYZ80LP+nw805ucvKRe8KVpojh8QFEggP8LlbiOg2e6jxwM2Dl0+YfkSKcihl5mLNrPT5Or5zr4FBt9Vs5TOS8zF/I+SKpl3MQf/JkW7qgH3iE1rnPkoEmVXiSYgrdk9F/y8rwE9EnAKQSGWJRSbKOi5hUJLN+C3vhnqmdvuu822nfK18HswvLyJ2XNngF8g9e1CM1k1kBudqjWyLrJwjORK/demlazuQE7JrpQEK7utit4b9ltJ/NbuUhL1hGJFPVJ5fszWpmCYtILKWzd+3boGzFfxt2QEa1VI8Ke+puO3yR4f34heJEeEYIc5JEziOiZakchvMW+apxBTelguzAgwSlEcXrlNcXJdF0QCVXFSVu5lwEZLC2d5Ntv9Mmjv8rKAc4WEzqggdpCKwOSrudsHFyS67VjmrOXtZxg7B0QJfjKt9D7f2H066
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(36756003)(8936002)(6486002)(8676002)(4326008)(1076003)(83380400001)(38100700002)(6506007)(6512007)(6666004)(2616005)(316002)(66556008)(54906003)(26005)(478600001)(6916009)(66946007)(66476007)(86362001)(41300700001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PaoRs8pDDpZ69d0TL//idol/742sCreysrdLlImH8kWm8a4JK6iLIYzES5W5?=
 =?us-ascii?Q?dc/p+qpGNNs2bw2Azf9757tehojZnStg8vZgsS7uKsvVRRW6/wgF60+RZZAN?=
 =?us-ascii?Q?rc4NbvhvyuKKMCuXLe9Gnrsy9LJ0YtAIqpfULS/Vfiwxbz/oXoF9Sj0cXmN3?=
 =?us-ascii?Q?WHyIu0uUOaCetCd9PmjQfx36V6qRnC0+VI9xlorjg9pJNf1HrjrWunYIuT06?=
 =?us-ascii?Q?hOJvu+WKLE7eUwcJrilAVGTbIZsW6d9oAreEurw6NKNDJf4IzaCNqdqYI9Fn?=
 =?us-ascii?Q?giBQTH2Ic8RRpUVj4H3Ph5T03RGkAaopAa8wENrYoT+/2K12x9P1AEHZCMMd?=
 =?us-ascii?Q?+oud8PoI8HwiFBWDR8vAUUgaXAhwMDuClKe7Odf0o502Y7b+S4ymUOrBU1TT?=
 =?us-ascii?Q?7ZVSdK6Uq9Zve6djfaUYxpdiej2XitJFbEC6+bqGRXroS2H+woCCQCwGqNA9?=
 =?us-ascii?Q?Tq8nBzd5RRY45EhfM/UeywluNncGvMhvoZp6Gbyrpsblq4NK4lZkRCLnVJf6?=
 =?us-ascii?Q?4Hq7c0tW+YuCIFHx2YJ/FNyJjNGi96uCxL0XHFuQlWX8xWmoRAjXOgssJdbE?=
 =?us-ascii?Q?Jw1xIhJjqQNKlcyD6/pempxLP7xVx9pyESIH8+dX7yvBnqD34m7IRh3MB64t?=
 =?us-ascii?Q?Lasx7JeB/3Y+oAKc2Rhz4q4LA3xcahHj2ZzAqgbHoYgbPCrLVdrUqT/J0K2n?=
 =?us-ascii?Q?dz2V5ltaZtuLtsDbEoSm4RwEbCmtK+aAtcSjqiwwrWoQYSs1nnINcFSTIXdt?=
 =?us-ascii?Q?vImpz6wtEBTu2eS9RYC2dtvjQ46w2tofzX0mV+yBY5pQbYcwpDWPNETRWtYQ?=
 =?us-ascii?Q?QfkhznWE3vGxOeyTeXQyBucYdewjEWOjYKPNUQhxIvsJLo7tt9+mUKWyRwz1?=
 =?us-ascii?Q?aiqBg7kX5VU5TxcNY/HDyz9+z/eUmFbvCtEZGeONmx3Qt9OrJkdeMYAvOFok?=
 =?us-ascii?Q?wNDFlCVUe+xv9qF/rqA3ldKbIt9YmP5aH4DF/6J52AHC2s3Z0CTQ0Dd0UzaI?=
 =?us-ascii?Q?p/wb8f8jK8Zjbuj4v/QTPDyk06OtLWy83BRbyQbwGklzmoDHBDDWMkrSGNIc?=
 =?us-ascii?Q?oKzn9O+aEun45dOV0XTsZI3pC1Ws80S5DsvUoE58SWu9P+91UqgB+nZs8yTU?=
 =?us-ascii?Q?t+5aQKZ6t+xJcuFpkrIuZ9dmt+sXrz9NggF+kAUTUli3/W+x4kj6P0sG1aTy?=
 =?us-ascii?Q?yH1OZ8ewzJq4+ZYLNa1+8EDdY8FIzj8/prHpLxCCPReLNE09Ng5kggbItWAj?=
 =?us-ascii?Q?HVTHtBmzRVSFzRHQPVtKnKED16uUOp806y83bY0nOgrw0/VURcI+WIe/l+6b?=
 =?us-ascii?Q?44rr3eOwNUG2lscar+ajlyDvCR+u4pp8w1AGo4EUgtCRZY7HA9uR7WHxVFOF?=
 =?us-ascii?Q?gBxigxhAJMu22E1YBFm+MZN2P/PpjHwg2U8ZYfTuOpni5FyDMOY3PVnqlNAZ?=
 =?us-ascii?Q?etFys2XJp/Gag2QqPdNyUNK/f5xIZfx19RBwWtnVcYz2iyf/Qxu3ZcEAs4Rh?=
 =?us-ascii?Q?Xt/Vb5klD/osPFUHpzhNFn3wxRHJ+gPkNpbilONqIXYlvFEInPvSJYU6pVws?=
 =?us-ascii?Q?GbgrETcI6P0NDIk5qe1HwZSFZFf2POFxiMEqX4cs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f05aeaf1-7424-4f98-d54b-08dbdb1577c6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 20:02:25.5261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YfRe6evK5je6xTdtsdJoPSXsU4vipbCv2gHuXhTYjF68S6GbfwCLzzrks5HfaZcglrnsDPHeQDtO7lf3+tx0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5273

When MACSec is configured on an outer netdev, traffic received directly
through the underlying netdev should not be processed by the MACSec Rx
datapath. When using MACSec offload on an outer netdev, traffic with no
metadata indicator in the skb is mistakenly considered as MACSec traffic
and incorrectly handled in the handle_not_macsec function. Treat skbs with
no metadata type as non-MACSec packets rather than assuming they are MACSec
packets.

Fixes: 860ead89b851 ("net/macsec: Add MACsec skb_metadata_dst Rx Data path support")
Cc: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Saeed Mahameed <saeed@kernel.org>
---
 drivers/net/macsec.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 9663050a852d..102200ce87d3 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -996,10 +996,12 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
 	struct metadata_dst *md_dst;
 	struct macsec_rxh_data *rxd;
 	struct macsec_dev *macsec;
+	bool is_macsec_md_skb;
 
 	rcu_read_lock();
 	rxd = macsec_data_rcu(skb->dev);
 	md_dst = skb_metadata_dst(skb);
+	is_macsec_md_skb = !md_dst || md_dst->type != METADATA_MACSEC;
 
 	list_for_each_entry_rcu(macsec, &rxd->secys, secys) {
 		struct sk_buff *nskb;
@@ -1012,10 +1014,11 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
 		if (macsec_is_offloaded(macsec) && netif_running(ndev)) {
 			struct macsec_rx_sc *rx_sc = NULL;
 
-			if (md_dst && md_dst->type == METADATA_MACSEC)
-				rx_sc = find_rx_sc(&macsec->secy, md_dst->u.macsec_info.sci);
+			if (is_macsec_md_skb)
+				continue;
 
-			if (md_dst && md_dst->type == METADATA_MACSEC && !rx_sc)
+			rx_sc = find_rx_sc(&macsec->secy, md_dst->u.macsec_info.sci);
+			if (!rx_sc)
 				continue;
 
 			if (ether_addr_equal_64bits(hdr->h_dest,
-- 
2.40.1


