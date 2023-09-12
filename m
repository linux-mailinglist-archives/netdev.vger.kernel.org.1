Return-Path: <netdev+bounces-33133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B315A79CCBC
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 12:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD4E1C20E77
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 10:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682501774C;
	Tue, 12 Sep 2023 10:00:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590261640A
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 10:00:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424D110E3
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 03:00:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJMEbp4urjb7D/QY/6paKHZ11550St/fRXlJWKXy+O0MCFTVg00+zkyMyP215ovLfKz0TXpZcAksAgKxyaZhK3Tom9OChlOxeDrj3TnnseYISbo990jeOoLjppKWyKuXGFaOAn4cMrlGKqGcFnrnAD04RwkjCek0YjwmY8j6g0sY0b/q4vuwnC7eXO3ktp/B6vPJkukJvX3qEf2OwTGyhdExLRskeSdOyMIq9MlmEtfKiKkZyFQ5kSJm9P9KYOKNc7mehAPHER4jIRPVN8NUE/h0GeKMj2RWtcLnxiUPz7N6ni/9av0GgBzrHu4rhp8wAs4gF6yVFXllDC86DTLkBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeinKB0TeGtV0ahzDu4uK0d8mEaxgFkxZOtX6H1OhQg=;
 b=ZkJl7Wmmru2uUPe3eMa6+Jn5YQS7wbhhJw9X9S6OE1CwIyKfxR6UqrULV881xXlcIBaO6ub57cOw/nsOD9jW9kdfw9DHe/fbHWn0tPONFNaxnmOSnrTAEmAbfRwg6Lu3AWptQ1gyN9SknQXTtFQR/E9PMZFVrbUjeTIFoilniby6CthOF8dXes2PS02QHkyHoqk0jU8DMzZUZZXk3WVEDzJ9/voymY5ZgpZ5pxRisrtZ9a4hSj/wpXlhmbClVwZSvWupNGrDbGCKECHP2TGVgLiVJmM2QgHAlABYCcDYTPMdZx8zSk7m0iT1A8voC8rFweNo7y/AWc0Zgrhksit8Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeinKB0TeGtV0ahzDu4uK0d8mEaxgFkxZOtX6H1OhQg=;
 b=qg1XTzuDQskFD/4GuSqgzzZ9QqCZAps0OpGE/f8SIZvD1o4+fcgANFPVYJj6JFwsfhJtY67FJIHA7rW30M+XR65ZRdS6nuTY7wWdXYMM3LUOdV7+goJYNMZHRycVUGs1we+p9mXtJelzZYD3mEPJ8v6VSHuAsx7UTMeHFgWhtVdpqUpazypspj+ITZiJj3WfEsPp/cTc22CdlaPMFcmS8KZUKKzx1AGdV+RbsTOb15SlifhRrvJDALAV+ZvMi6XJZ4jCB8vRvZML4Ctk/Rh57xKe8v69m0BIFXw+3qxwp0+DmpzDt/Iyx+FwYKBW45vmuUMZ4mUiTsVm8A7RCDHGDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) by
 BN9PR12MB5034.namprd12.prod.outlook.com (2603:10b6:408:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 10:00:30 +0000
Received: from DS7PR12MB6069.namprd12.prod.outlook.com
 ([fe80::8ce3:c3f6:fc3a:addb]) by DS7PR12MB6069.namprd12.prod.outlook.com
 ([fe80::8ce3:c3f6:fc3a:addb%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 10:00:30 +0000
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
	mgurtovoy@nvidia.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH v15 03/20] iov_iter: skip copy if src == dst for direct data placement
Date: Tue, 12 Sep 2023 09:59:32 +0000
Message-Id: <20230912095949.5474-4-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912095949.5474-1-aaptel@nvidia.com>
References: <20230912095949.5474-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::14) To DS7PR12MB6069.namprd12.prod.outlook.com
 (2603:10b6:8:9f::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6069:EE_|BN9PR12MB5034:EE_
X-MS-Office365-Filtering-Correlation-Id: b859a9f3-c764-42df-440d-08dbb37718d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VeUdMxH5v9C7I/Mxm5qQCS6dx+4fW14SN0w39EQUX2rdJXn19d8cESvuWui4cVRbvdXCdXEJocKn0O3QyO49tCGcVGIPp+Zd0GCh7J8sotwZOl6iK5vPzZHPU2QBufjcGDMCmSatfXRfpfMlCKoh78WBrbw1zTUTRMgSc9/z8JthPTdNjaEowQ8oWvb+zQ5Ffzpia0wIefg0ZJ+95BeltM5FJ3kevWeihG6zSYDdNUyG4z4p7UO/+N0utOzrWnqH5qXX9oWcn208m7XYk7GIOMiGrl6sIXeFrXL6RWcyePX8t7t2m7vu966wg0ZrfHeGgAK1kWcuH6EdK/6QMLBcMXhiydPCSJryC61yRKTNYw75DPzOcdqIOkpdTswYwCHT4Znzw8QRg6cfX6z0yieednib55oPhfuwJZZU1DAds3U/juMSQTk7wROiY9vKjhHuPZrQNOMQZmh4kgUoVCOYfJR+om7CO+qdGglPE/OZU5p5CvB4Cd99Ny7oEGHb4q6jOiUKamsI2/Fy41dAaneuPcI3Q1hRbQB0FCTj1c6uLPkh6MMLUbQ4r0K14Yxxnehd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6069.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(136003)(396003)(1800799009)(186009)(451199024)(1076003)(26005)(86362001)(83380400001)(2616005)(6486002)(6506007)(2906002)(7416002)(6512007)(38100700002)(36756003)(478600001)(4326008)(5660300002)(8676002)(8936002)(66476007)(66556008)(316002)(66946007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qfo3l6nCPITHlBL1VSkc1LIenN/CjFAn+Z+sRoZuB++lWdNCjJWlbBPGTGzp?=
 =?us-ascii?Q?ExTrUakD4p+kql/04noa6PSaRj0grpyBj5SN0QO7gg5ATTFDzH8Lq3YXz+5v?=
 =?us-ascii?Q?Dj1T6ydip8zzkhz2LF00hZx3sOTNzlR9iRZ5k4NloxOuG872YvDiKGsjQHgL?=
 =?us-ascii?Q?ElkI+vROG4JQq6DyG/QSUck+t4GvjGxpzDfIlZAIJXYSmH9JzJgtLn2C7WfA?=
 =?us-ascii?Q?G3175x2/8i2rsPIwQtfo7OZ2Adail4f/JgmOJnhM3IYxluMHtkCbbT6mzOTZ?=
 =?us-ascii?Q?UQMf5YKODnzjr61JOjW/Ro1weuNFKhSqu8wy5ePsj8YV0Gvct/HfA4Sk9qdX?=
 =?us-ascii?Q?6GE7+KQTEFWGz/UsOUeonBOEpy5XqIEukV4kMAB+QP7LG7aSyc88gcgXMCqO?=
 =?us-ascii?Q?kjy9QjetePEr3NTexQ8JbKSYlTDmjd/++KyJcUr2Mzf0F4FzqB0Rsfhmw/rY?=
 =?us-ascii?Q?7d3ugr4rvm3K5JSWxmLtqkWr188+AUqSPjorsYlmUgKq/hcH2bijywTpzH2l?=
 =?us-ascii?Q?eoxzEvSr9Jcl85pYIN2LPt7uwel00fSI8uPspCXqQSEkAzTDyjQ7Nak32h6s?=
 =?us-ascii?Q?SceKIKs/V6QD4Bgh0+poESA2PRRdFwlNTnHrZAymqi9dU5/LrciVPAh++E/c?=
 =?us-ascii?Q?W4pTxUZOWiysNx8+1+OLWH/PFIsz8CpYbYZv0PP81FupqPL4BNxJcA5gs2MF?=
 =?us-ascii?Q?EOAQS5glwGqrhtZqM7B4+YKScEm5sFOV1banxLAUCNay/IZb5jes/DkwI74M?=
 =?us-ascii?Q?isz0kn6t4vG3W3/xVFM+zsgaKdjSqE1BzLQd1Q6H1EcfZTOzWewp1GLt1C+w?=
 =?us-ascii?Q?JNAMCzrRjxhBj8uU9VE2as30Hawj/8RkhYZzYKKs20hPwkAAROAIIpJ1PFF6?=
 =?us-ascii?Q?yFZa0kHE7n4vQSv/EShujHtrNOjfS/AWtRrKk3vZV+5110CgXrFiufUj+Fhp?=
 =?us-ascii?Q?kFKoq05Ph/ZU3le0OAxR/eJ0uaIVbq1pBIMnexiT7VGRCX7DVqFFA/UhZcCc?=
 =?us-ascii?Q?xSTchZ/pwZxuZoYbIDa/Vb3LKUao6QNvIe7dLzQxdkuAH6zYJkPDBcEb+P0I?=
 =?us-ascii?Q?36F+KiXz6fGiiTs3KQxSjFEJ5RkY6jgPguv74DW9pMcD72Plyeuw0yaPLdjT?=
 =?us-ascii?Q?a+bKPm2KEdiEC392cMJmqNE9tajqzme9r/WiVX462UMT8jMc0H+FD6/q54mq?=
 =?us-ascii?Q?dVbGNS7kN94noFBcwmxpuiqG4EQ7mEBp3fX6rCioZS8w+svSriLDrhcz5PBK?=
 =?us-ascii?Q?qBlJW5wcogxLUjDM+pOC1Ti/IHR8FxGRbIV8z9DZOVhMKTbNz/BOdyaZNMQp?=
 =?us-ascii?Q?nPAWCmIp7LkEhiRuClP6GFOyGRXn0ntSJtdPNGU8QqGO4YlY1xOS/8ozXW4R?=
 =?us-ascii?Q?ClDEKA/DUpQESnM8I8IYAKq32RjDUrWjEowJm7nU5pItPiEgOd6fadOV4jVF?=
 =?us-ascii?Q?/PvXMlOqOCkRiuw1pxb/ip9Zu+N1PhzZ8B/Nb/dRPQqXF8+QD7nnsrlCSPJT?=
 =?us-ascii?Q?OoiZ3g1bCBrmst/kkxLM69OA54gR0wwK81tflvY/X0bOHtVwq3tOdxZ4l5sd?=
 =?us-ascii?Q?Dz+xaUVqpd+Zp8S3AssEKEoLu22OU2ekSA7ZGx0K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b859a9f3-c764-42df-440d-08dbb37718d9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6069.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 10:00:30.3851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wmv0qcpm4XbnD09u9BFtQQJ4fmo+YEkY/03vuy/uKAcKqPq/xcyRpfbRHga19a91zYStKQ1D/XXQBg/NxJeapA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5034

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
index 424737045b97..5d9c8c196a39 100644
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


