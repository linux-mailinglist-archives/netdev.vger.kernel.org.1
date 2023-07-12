Return-Path: <netdev+bounces-17234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5905E750E2E
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 18:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF6F281A0F
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2F014F8E;
	Wed, 12 Jul 2023 16:16:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEF914F8B
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 16:16:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266D1211F
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 09:16:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLX30f0thiWQ0dgJ2xZfyMUciayVEkIkLXzVNK8UpYjOr/P23ncvgz6WwPN6ewoK1lCaCdRKtan0gEPt4ITXog8apk17pBvE+qjpPG7HCBGbRflXcFDMhJNRuS4AW8FwbPHd05dn9iJFsiuFjP+nm4HTniA1YTWpl45ds+X0gM97Kn8KZuHXOG8hfFEaE2vkuXpAlrz6VqWfWIaNc3VC2vWpWS5bVWQ1h8ySELtbtS9Akgyy7PO/TlFk4WFQmn4gr0Uxn8EGhFszzO12lwhEb9ahvYMmS+lAh70/uNC8VduRvooItMDB/gRou+QoOduWPEIFN07u9Y19b+BWfuqzVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adGWJ7CqkKmGJmazviZBltSyLz7gvsUXFxFx0R/d9hc=;
 b=l/igle9UaBEUBCUBlcFnJSObDnBC8UuQErNsP4pOuBcBpDceIG+UEOjV7g1PD9wdWNKbPV2LGX7PtoqrjbWW71yrRpFTHFWC3yMcMA3+nkZ457U2xCancYhekaycwM0ZyonGB1MsPRa1wgj8NDykr0+SNSN9kNICMmqNEGNaBo/RndcCB7d1oYxq6aQUkKfllZAvS/Qydz2ZUFusIcqHV+3rdJitf13OIxyxBjMHVUSVjCKRZ65mYYE/QxXyNXfCkdmKZUppF9Uk0F1zn+aoqxTP/6kJuJzpSBK8Rzb1tGUlrzvlm95VkSPJXmV7QcZmVTFJ9SMs69yRFS2CDSg/xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adGWJ7CqkKmGJmazviZBltSyLz7gvsUXFxFx0R/d9hc=;
 b=DKQTvHZCSQyAClIC0+2cjdU06awzUgMsn1WZDjenKamwOSLW17YPQq9FTz5wI6vve7sF0frbVGXrsKwSNrBgq0Vlrv9Qjt6oYCOHfy6ZPkTIGAtgxA32JEnWhIBUtUQIqNynUfWWR6ArPlpMUG5aXeI8Kx+5M93h93duukxWgO3bpMm6OOQFKOweyDkmyS0Y3pn/kJdc1k2e32D9jAkKT9DgHXmF4YzXVW48KyNFfOoWRjidoO2D45nK3C0hSHYsGJ8UN7UhsXcD5w9XwwxzYFiZQJVZALtwrpdTkZ92zv1DkgvTgh78NncXhA/guVsFF85qWlY9fdcK3EvNSC8A5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 16:16:53 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 16:16:53 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Ben Ben-Ishay <benishay@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v12 05/26] iov_iter: skip copy if src == dst for direct data placement
Date: Wed, 12 Jul 2023 16:14:52 +0000
Message-Id: <20230712161513.134860-6-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712161513.134860-1-aaptel@nvidia.com>
References: <20230712161513.134860-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::21) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: b10887ba-40f9-447f-85e9-08db82f3677b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l3UzVnx0evV1waw2THDbPlv4zudqd4sdym3Q6wKgVRisAw1F/RJMuBSleiWal2Fl/Sq7dvPXEMy3SIBOMxytALUe3Kk0SwKsGwSljjSFa20u3D6GU2zwIzX7NlA8+n3r6lJplLT1hnp7oqKEKnQeFebjTwfHAZYPgVOI1yN/Rr9KAq9DQWuMMh4vgFu3eIBrke6ySxTmwS9mgOT6fIUJ384cP1izYjKqbGNWAFigDMahBgWeTxrPYn8dXTCpAXJqyT33QPkp4LOXq3z2fpWH2Avc5OXqMApkUuuh+V2CGoq9pWJQFP7qUIvAgT8T96PErcqiz5huY25y/q89MVKUxWnS81ZylEMW8jiTbZZYm3g/VTlXCeqFB/QlniVquFgGZXRDt/sERclFjLtqwdrerYIYV01VquRCSuN3BTstmFxbEK/skRcfD9dvojwSeJDarYeK5u3gHHVlPziEGU0I+gwPES9XCfr0L+nysOGF48h9RGfTmvQ0qcHviCv2sOlvIzoCV129xXVBdDHl6ntPc+9OhmyVfnSyESK8pFscVjuar1OVRMZalSw41gAspv50
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(186003)(2616005)(86362001)(66476007)(66946007)(66556008)(316002)(83380400001)(107886003)(4326008)(6512007)(1076003)(26005)(6506007)(478600001)(2906002)(6486002)(36756003)(38100700002)(41300700001)(7416002)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iebE//iva1MX2p8gJPhmsqGgGu0nKIrpCnwREk+WY5T/L+Ee6qaRI+KCSoWw?=
 =?us-ascii?Q?oFfYimSGuCBgiJQmRMjijOK8RrgQzDrTpeTZTErqpzAJoRTitvcnLNH4rgIs?=
 =?us-ascii?Q?vyoQhD9q75Gf4RfQvZfuO7RSIIm15YGJ7IgNEbiNaQus3LXlhTg49eTA8TsX?=
 =?us-ascii?Q?15kBGTSnRMUVy0kUprWsPsgUbLXg2A+lLBCKQzt5cRV54r4VG4eIBfAn4KCn?=
 =?us-ascii?Q?fjzpA/MIfYkKt2QfMt+tH2y7/+ZcLreV3v3EVbP0XzyvYGgUlAaCsW9h+Q7z?=
 =?us-ascii?Q?30Sc5vtdxCxNp1oYY27jFgiDn06wDZT+z+qSz8rE5wYfhxt4uvchifmmkdd0?=
 =?us-ascii?Q?OONcJg8G+cVRFm+ooO7RL25H+UV8wzZQvVaEbZb1VgAte8IvUY/Lbedtlay4?=
 =?us-ascii?Q?0g/eAwnjr7O3F5BiXapeofQ9M/lFojiWDdbQ/2gT4N3jwTZuSusaZM96H4tv?=
 =?us-ascii?Q?/+LoLaYRW6/7X0ARIMpKGlEsYorgVZeqN10X+cNjSkBG2OzsILsrmCLhwROx?=
 =?us-ascii?Q?yEQXqGHCFN5nVhJ5L8DLnjL5vpm+SAYB18ZPqFBOa9rWmaW6bDA3kyf9Zzvk?=
 =?us-ascii?Q?wRJpL2qlPQ9QmCZ1R85S5Cl+8UQPESGrgCgncHJ0Vi/QxcWNlj36fY6DdOse?=
 =?us-ascii?Q?aPs66p7y0vgOju9Lde2lGbzQ8gM0bGXp8E+S/XSG0tv+1Ywf0u3J7p5IrUnT?=
 =?us-ascii?Q?daB/UlyRnn2D3u2l8jhHLuPaXyzZDVL6TM0hz6+qee9VVXEIFt1T0u7cMSZz?=
 =?us-ascii?Q?+5JXyfxWn7VJHOcVe7yFQkgCu6UbtYFFmagDEZO/QzjvIr7eYJC44aDRp9Du?=
 =?us-ascii?Q?GkfOGLKYtsFbzeotE/qqhiT5ivvbJLOx10zi9csN4hAVKumD3UJCOR4vq1m0?=
 =?us-ascii?Q?sulO8YFBkoqvGKe5reYN6RkfDH8GXkMo1OJfGVtP89MlYk/5FbWpSdzLv7Y8?=
 =?us-ascii?Q?/X67iQUbo0hlsvp7BISvsD/IlRr2jmi3Dr/UDCrkV6MHt8O/tvlt+uzpjWw7?=
 =?us-ascii?Q?ZhJp5AQD6eOsUBh9eZbm/MISUzInP6SIQgbsv4aIlA4bCkxp494BEYBMBV3l?=
 =?us-ascii?Q?Iw00V5o1NXdhqxH2pAb4Wp9qMPCZi770tj7c/0ijfAnx4L4165CSkszYXm2T?=
 =?us-ascii?Q?rb9C6xwogo2i6NjXb4qXB1IKkbts4hlXyji0fZoWUdDjy6MllB18/YeM9Wbv?=
 =?us-ascii?Q?zPVIaA5W38rfJALXmTZ+SWm5/XRshbN08YcrmPrnxBnFckWlf3l/QwI43bF+?=
 =?us-ascii?Q?OVEC+/YoxqoYd+SHKx++Ihd1WWZ30iu3InPRqACHbZxiywrEyfsiU6HwHyKx?=
 =?us-ascii?Q?G8Q7tnGTt9z4wOagXT9aosR74ULdksBM/kqf08Pe8xzkK6/dPNmSjkOuWgsN?=
 =?us-ascii?Q?3JNPaCXTPdSVM2QC5ytDnMJzpP2G2tTtIOXMOwrXb+qhoy/KgBtOj0qyGGYT?=
 =?us-ascii?Q?obEQqT39rOXAv6IimgmpGDDtr/QriL7AdtE1z+3Z2y3/wE8HD9XAGz8uD2TM?=
 =?us-ascii?Q?ezPYXevw5hcMwxi1kNpd09SCSVQmNJmxx1xR4vqBrV/+qLNUDMfzYAR2mmLt?=
 =?us-ascii?Q?dOuZsefGxKQzDI4X1bHyMELUSA4QXC+TZ7+qfEEZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10887ba-40f9-447f-85e9-08db82f3677b
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:16:53.0209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tuh6ZqUkvv7xFRqFja6Qegdv7Ru3l/OcYfqIAm+xRN1JlWdDiMLOJp6EOF/suIQ4ljRvZRppGmt24gh+r8ILvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ben Ben-Ishay <benishay@nvidia.com>

When using direct data placement (DDP) the NIC could write the payload
directly into the destination buffer and constructs SKBs such that
they point to this data. To skip copies when SKB data already resides
in the destination buffer we check if (src == dst), and skip the copy
when it's true.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 lib/iov_iter.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index b667b1e2f688..1c9b10e1e1c8 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -313,9 +313,15 @@ size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 		return 0;
 	if (user_backed_iter(i))
 		might_fault();
+	/*
+	 * When using direct data placement (DDP) the hardware writes
+	 * data directly to the destination buffer, and constructs
+	 * IOVs such that they point to this data.
+	 * Thus, when the src == dst we skip the memcpy.
+	 */
 	iterate_and_advance(i, bytes, base, len, off,
 		copyout(base, addr + off, len),
-		memcpy(base, addr + off, len)
+		(base != addr + off) && memcpy(base, addr + off, len)
 	)
 
 	return bytes;
-- 
2.34.1


