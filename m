Return-Path: <netdev+bounces-59765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49D281C035
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 22:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13AD91C21A3B
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 21:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3C876DC9;
	Thu, 21 Dec 2023 21:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JAaJ7d71"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEF076DAE
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 21:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9aJe7xKvH9LBqwcs6lIMb4xbLVobkKdfIIKIMy7R1WyrDQoISGEtibJl3dWCLdUQKNCQjIQpp1lQ4e6nFYV3tohUP5eXNbTh3LslmY5MjhNHdGtGwjnocP98LN8CXEGztfP22c/BB/ONXT87OWoOqO2hEhiHtD/GNg4zr1K/y1tLL1rcBctx/7Kk+M0YP9IaY7wpFxiUyCA6InrJXuCRzOrEGZmPYyI+DDxme67Ursn2zMDAsdejdh4b+M6pUVCb8Hr3eObqwZAD+OCS8WQ/P0ZUzDbvWASoI2uK2hrEkOozhCynSGY9rJRFtjmWi3KG4jI9uPsf4AjiBKSRFotKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYvVSRFTgY2wWY/42+MsPX2QgXrFds9afsSovT6ix2I=;
 b=FB+fgf+hPcRtiItNxVgUEQ/NqsDqQDi2SF1/peDcJ/j0DG35623YRLWvYpWC5uOR2zXReSUW/ilxznCmcCJfkAsUDhdzZOawOH0Gt3QGp/clCsoXo4eSBSWBkRN1a27Tefu9+W+7WRM2zXiH3Fh9NLPyQdXpFIq/bgWlcEXbF1nX/BEGpobVBBDIQG/AlqMNgBNm0J/MsZLh0TLovOEuhqA+KAGjgPk2VDvB28/3tt5f5sf5vwCYRsPPwCK29dXPF0xy+Ci53c/3O4bG7K311SObDA/ieQ2A+jW7WC1JnNPNUwIjNr7m0SPdIhJ/Xrj+zzwF2BWhPsocf3oqqzybsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYvVSRFTgY2wWY/42+MsPX2QgXrFds9afsSovT6ix2I=;
 b=JAaJ7d71Qw7jpbkQAVmHYfOt/lWPycNnxzry9/aAl9/9L/VNzLORYM3St+XSv00m9JiZNRq2mAwEOvvlWjDfe8VE2o4WqvZ4N/Cjk1roS1XBjae2/kss6gBurqA061WsAM8VV6wE9jUUwIyap62ve8HfziJ/fQsalhijg5Kg9a1KHBP0qFE1nJwCg0A44mD07/gmfPjaL4mYRJg5oG31ZDNIRUB3ePAtRfk6T7DwVXT/xBn8ZkpyiUPINWAdEW06NBCO/qkCn/WZ1kBi0Sr+/MJNNsozVJ5teXQWFWBXwphDgFOq178iEYJtB5viyzL2WtQr87d7hNJtUwBfzQB9OA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by IA0PR12MB8647.namprd12.prod.outlook.com (2603:10b6:208:480::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 21:34:21 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 21:34:20 +0000
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
Cc: aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH v22 03/20] iov_iter: skip copy if src == dst for direct data placement
Date: Thu, 21 Dec 2023 21:33:41 +0000
Message-Id: <20231221213358.105704-4-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221213358.105704-1-aaptel@nvidia.com>
References: <20231221213358.105704-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0547.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::16) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|IA0PR12MB8647:EE_
X-MS-Office365-Filtering-Correlation-Id: d43cc5f4-c20e-43b1-09c0-08dc026c97d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	psqbbuHaxGMK+/nrinE8WvZyZrftU+cmttI0yIlBQ7q0VhyQpVH+warJleQDENwMS6nTN75fzIwyfWYzQGvWTsbeQWRkL03x/3LwlnPmpn9woNUYwqeCQ6CXFWJL2L7WBaAH7kZdeytXI2Mig0jcQhP/O7zQk70a6mgjkun0sAuOLb75AHCiT0DZJ9iK+gUtqIwEXxpcuCwWtbFLWwRSrGnMJYizB8jfejw6wZxKM7QFMfD1UuIOo7G3bbfvVJTgBihNzEQeBBVLdOjwRxJf+UT/m7nvUjm3aM2AD992ImFDE5fFsK+S+y8B1V/EIvVGpEgEXxFEhqCS+SZRFh+tIeI7wtmP/LK2s/wn8NNNvE5vleXArYljFEEGX24M0VBDC6V7tMNIpp2uxnfWCCfT8CzJrkyHUHCbCO8R87MJW16xQ/XeVJ1hcjoRfUK/3CQAc/Fqyj0ZuXmaZyQpNB/tydT9yf4m+GiUDxjvn0Nq+W/e+zs0PD1lYVFBLzAE4FYYeQznb/lsG9uFcGsN/ZAoh0J97uBI/h7unbR5b5jdy1D2XUzXW1GH/noQa55TA3op
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(396003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6512007)(6506007)(478600001)(26005)(6486002)(2616005)(1076003)(41300700001)(66946007)(83380400001)(66556008)(66476007)(6666004)(316002)(86362001)(36756003)(8676002)(8936002)(38100700002)(2906002)(7416002)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xLphsLqcMzftzi5pL57d9ztOBgDDG77/KeXJW+9TPePZPKclomk7Vqf7tvUE?=
 =?us-ascii?Q?DftYu6pEqQHmgv1uu0Sq33W7OtkDRYcH3A876yPI/ZAFJ+HGrKiEj2XyaVd7?=
 =?us-ascii?Q?BNV0GVR5is4b5t0vTUPEoxrfP88H+yuF8YLzP6GO//ZqssdgcCx1OWrW664b?=
 =?us-ascii?Q?tAMRIASreApFN1R85UoiV6C4o6pbsh20h4revFiscPfGqIQFUb3kQcSgskVU?=
 =?us-ascii?Q?Uj8Fq0p50tD+xQhDaOed5GhY2qn7t/CA4XCjkknF0o6u7hkW2/GfX+XirxeY?=
 =?us-ascii?Q?8ywi3MjTCHdGMx9I2cILGRR037Pbu+MLhZwCbJ9HineEZdzICF7fF/rcESbn?=
 =?us-ascii?Q?LHngAkEXxxP8eqFf4jnDbn+pX3GNETY/wtbPo/MfXaQBYS6GBYeECisMm8Xv?=
 =?us-ascii?Q?KSvfDk97kqHZLo9Rg0iem06My6HqRFxKWxjgPcKRh+ryuUyZtG0k51YbVP0s?=
 =?us-ascii?Q?6yXcbMDg1bwMfDZG2f6h+zooVSLnNBc4kR+Tn/QBlDFdHIultPnmne7sXRtS?=
 =?us-ascii?Q?Pj74j2KYIEjruuGAJNwSwgcojAQwIWSnvWJr5bByZenCH2MfHzztu+7XOsJ0?=
 =?us-ascii?Q?xOS99ubZroYxMi1q58P28pqgrk6mClSLFu9raHZdkmRYEou+k9TvfHO38xdB?=
 =?us-ascii?Q?LBCAxCfqd7Zo3MFGktbmXbWGXPBX4nImZFzixpry+Na/wSqqb0XnHjR3Wnsm?=
 =?us-ascii?Q?3gMyp2uIhH7yl+fxj3ncYDonJOsreCwR8E0tsOa2tE6fSwIHf5l9g+u4iVQu?=
 =?us-ascii?Q?wkFdSmrkG/xcZn3Mnh7m1roLjWbMLrw9Axy5+m/x94tXcJQ1cGlgp7ufwdM3?=
 =?us-ascii?Q?8ODU0VzUDtlhqfSuG6/CGk+C1HNof8qa5YJX5LbKMG+VyBg6XRSzRRizxL11?=
 =?us-ascii?Q?L36Ce8B9ltd8RhgxM5nCoWL1+OUwlERR3i+9aguhHED3ZfZhEM1/hzRcwpqO?=
 =?us-ascii?Q?I0T2K9TiGvFk+UMWydoBoWOqUwSKbmwj7BBhE3aA+EjuIoJpeWN0GAJM/MTS?=
 =?us-ascii?Q?zq71cJ2SravaYQvueCV+PZibLNSC36597/cdWBZYHhZuSDE8Xwl6zImHBKS7?=
 =?us-ascii?Q?GYcwSHL+RpeZwWqsRtlcFX9BGAaVxXc4FEBtEkuQpob5yv6t5j8X6VoI8Ddg?=
 =?us-ascii?Q?Qt0RemYVlYymPD3RAoq+cdF0ph2ntRf9R7vz+yg5pCSHa00h1nQHaN3ESLjX?=
 =?us-ascii?Q?Cr1sNruYOmJY7zWMHg5gtEJCm29TKMSFJEo9SRN2kQgEjS/EPtkAoCuRyi/R?=
 =?us-ascii?Q?Tr0n++w+sJ8P/qROA6vzCwfsF1nL+AzkOOE/YfkdTU8g8FynBzhF34o7Qlm2?=
 =?us-ascii?Q?Tj7QdPnEtteyg6sfOyOZJAp5xDZIUALBjFDwFlJm0zvePcTHZ/7Os3SY7G82?=
 =?us-ascii?Q?stEbFrkttUrKQnUqJaf7koPybB7WGptAe194NldqiOerjYUXgBZXjJ9xXi5b?=
 =?us-ascii?Q?tbCZYg2uDgxzMZXuF8UwE0rDkdwne9lqr1c3UKKIvJjSUZ9lmyLwF/xWr7io?=
 =?us-ascii?Q?jh68yk8UYKVQfmF0KPpPnCmuTxSYlYNUG2pJy9+bbD6Zixd5Ic2VcYOez8w6?=
 =?us-ascii?Q?D7tnpOw47sf3ZOz1M+jgmSpMWO/erN5fXki5XZj9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43cc5f4-c20e-43b1-09c0-08dc026c97d9
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 21:34:20.8448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B7NRc0U0uriVOc00H0872gjEgVeyvV7f1xUNvgaMG3K2qPvFF4zO+p6IPHuE8r+RFQPTVFRsW9+DhItL/tnV0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8647

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
 lib/iov_iter.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 8ff6824a1005..b96d8b6f5818 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -62,7 +62,14 @@ static __always_inline
 size_t memcpy_to_iter(void *iter_to, size_t progress,
 		      size_t len, void *from, void *priv2)
 {
-	memcpy(iter_to, from + progress, len);
+	/*
+	 * When using direct data placement (DDP) the hardware writes
+	 * data directly to the destination buffer, and constructs
+	 * IOVs such that they point to this data.
+	 * Thus, when the src == dst we skip the memcpy.
+	 */
+	if (iter_to != from + progress)
+		memcpy(iter_to, from + progress, len);
 	return 0;
 }
 
-- 
2.34.1


