Return-Path: <netdev+bounces-57434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C12813183
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C121C21ABD
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDBB56472;
	Thu, 14 Dec 2023 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hwZeiXas"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76820131
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:26:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNiTGfiLmvZ9MbvJ+k42FOc/X/Onn4Zxwrh7A9NWGBvJp3dxRrZ0c4G7OrWtqdE+/arzR3wAzm0glfN0yIgCAovBuOjXHWNZG4iBDOunB+/lGZ/ldUnV5OkwLosw0dPZauWOnC6H6GdGVPCoYGDMbwHpE5pSDEB5CWqvfyxOPT+1y59uEmkvSJ5TcdO759sbjjGdmK9Tpj9Qel3pB1ScgC/EsxRHpbtQgXOharG9iUckw1kb+8EZgvs65+KgCW+20tiNYd1KEJqIhX0iNhRj88nDLOryeRy1bDTsVNeHVadzZLuo2Su/+AgUJaGsxLpoqR++lHwzo3xJJ6M81e+NNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYvVSRFTgY2wWY/42+MsPX2QgXrFds9afsSovT6ix2I=;
 b=mdMPj02FmNe2bjssAfKfhyGPi2f78y/g9m24Vcrz0MEYBa0QUL45UeiWhvPFPd63l/u6yuaochZUAgfnC8QMHZCdMMwY6hpy3rN4+jN5NwGSFoTfgI1Jx7/oJelOYUUYzDKEmROHSpCUbOG1zPvZ+2a5k6Al3GKn5As7CE5kUnbsiIQ+c7kAAqIH5r6r6S7NKpgKsfg5Im7exbv9G9aE1CYJzyaMTlctbEKSkO21XwcRCEE3CeSiggndcxRjqnF+ycmdL+tJpeEPfb8FYr5UckHryB1/cfdjWz7Q7TJ6KefLCw0YOJyXvWKT3ta4BcBpRzu0EUAD6OEWrayhOogt7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYvVSRFTgY2wWY/42+MsPX2QgXrFds9afsSovT6ix2I=;
 b=hwZeiXasfAg0D/P2JMlU/5rkiT/cK7uRTpkO1Xy9BaTXWmnE+QRAzFqb0hxEmX4GSyHnDs5ciMDGA/ShVYQpP5zX1xPASNq75BzHhi3IriGsQMHdrwzvgaRxoebn9vdcLKGqItp4QcRLCgFSlRaUgXFOn7uI2Z6ImG1rGHno+XmbwtM0UWZiTzlA2wp+rUGqGt537qohvf5a+AEIdF6gZtY2TKbvN5+gWTtpVngVomgxg/DkK4GLU5MJV4v/aqXh7bE4RxwqeSYlKhGBQvqdCQEd3aAcRUpO9zm0Ci3RTUPdCvNhvvZH2mPMKqION7LMZgVLd9MLdZPWKmVnc6wONg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MW6PR12MB8708.namprd12.prod.outlook.com (2603:10b6:303:242::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 13:26:52 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 13:26:52 +0000
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
Subject: [PATCH v21 03/20] iov_iter: skip copy if src == dst for direct data placement
Date: Thu, 14 Dec 2023 13:26:06 +0000
Message-Id: <20231214132623.119227-4-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214132623.119227-1-aaptel@nvidia.com>
References: <20231214132623.119227-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::18) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MW6PR12MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f2164c6-2e9e-4666-6792-08dbfca8552f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/mLj9bTmxeEdGa94OIjqeXftXwkAH+vXqDjrSOsUCfcHOGKWHn1w0BQGdrtXvvqo8QU9P68PWcBuTS/MlopgNw2cLx+vRzcGwsX1cYiZowM3SEaFVhOKYrT8/ZI886QxHZd5LufU3Jm0UBWOaTxqatOdN4DbHH5olyW5jTaeGJBKuiwzP7npxQPQba7gHLL8JaHMAh6oeBYPYbKyz+y1hqpbAZymPA4Sgz6v/nZW4kFKkEmoFvC5CzXeSfVv9IO8LNQkd3Of4DF+byk75l2p/Jv1l47fPiGKbkwbA1zbddfyexkQrE0K7Nynct/IFCyA5ffGZ87mHqLk9iMj1HF3LYHHsHqOzo6LqAE/rKwAL8KSC8xIycLNotyiZpSS9RBredYfk9ZI++xyc6KWmOiMCci44oIFP55b4anGb/jgpj1ynBihHKgptAo7ypp6BtOSJQbTtK79I+UwugJa+0kzjzP2EVUtVNYVz69vNYLmVrumg7JUnW7QezziglJ97IA0Mlo+68Sl896823pqUOn1FRwN27Li2o0uA448RjABMnJbFQEbyreV4GuW2lnbUhcB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(7416002)(2906002)(38100700002)(36756003)(41300700001)(86362001)(2616005)(4326008)(8676002)(8936002)(6512007)(6486002)(6666004)(478600001)(83380400001)(66476007)(66556008)(316002)(66946007)(6506007)(5660300002)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9XqB3AE6kqO6KoyIykEvuDYN3xYCjf2+6qe71s3qeieZli5B1KgTVE9hGEO1?=
 =?us-ascii?Q?r5nCyN/q0xAkPw1pOIgdS/nc3m0nlVvG9ylr0MasDvOMn+UXzRsrxYm5vexl?=
 =?us-ascii?Q?UflgqNoYeASkocI2MNkpVRd4y4vNVq0XEFIzwpsFseUR1do30aSObf1aDdUi?=
 =?us-ascii?Q?aoKzwTsAx/seDQN2Yr95fiRHXGAqgHjhExLx/e8ICKU/5K+HMT/meFnMGGnz?=
 =?us-ascii?Q?NqZCIy3cHKRG+ucdY4P0pGt72IrZoy8G/waBI5di9NDfNynCx74sSEMf/k0W?=
 =?us-ascii?Q?Af9WdZPpZ3OXxUbc6GRbqYkG6EhAwu4Y2b8btY44DhjxSwiNJVKOvyVeAa/H?=
 =?us-ascii?Q?P8JGOQnlV77p1PteqPOmeqFvwYZ6lZgAlR3MGQxHRIyvWHBq3662XdEqR0+Y?=
 =?us-ascii?Q?pZ+lBWezjarBKeDj4G6QVcwOgNZXuTpnuUvqiQYKLfmC2ejniDk2SWBBf1q+?=
 =?us-ascii?Q?dAOGTetJWCylBo8pWD5j/XMFJNyZuMyFhPqRnOyjuJNiQBjw7VQQqbYYcSv4?=
 =?us-ascii?Q?ZeR4BIlzJQTT8VKDaM5pNw6oaRYrNDPgeuM1AsQmVCeNrKj27Uc+9rnmWkpN?=
 =?us-ascii?Q?qxWIaPXQ04F1fZXIEi5ML7FogjSDrsi5LcjFcQWiwG+W/4bk/VG2qSSdB3bo?=
 =?us-ascii?Q?dqCbXOjpyQKCF4lnFUKs8OdN+rn4TOLA8Kyq8bbXgBZ4mcGADXpLp9cHpq1H?=
 =?us-ascii?Q?7ODJ8tGGLrDZwUQRrliN2Bragnw98fT+eDtWF68r5HgAeY5WXwB/57Tx+XzZ?=
 =?us-ascii?Q?fIbIiG2o3oO1siE/R7iba9fQHU4cm8/wxppw/HVHBOGMRYbzWR1CKAhvE7zw?=
 =?us-ascii?Q?aEqW3sSam3lTi5tM0i+FD7WtEZf1TrCROyU5dj+4+ByAQ0KRGemmabvGJ9t+?=
 =?us-ascii?Q?CzdCNjBG6qGsFBF7lorN+3C9e+Mz0ZmiEdKO/6q5Wih8Tt09ziei+aK7oIlx?=
 =?us-ascii?Q?ldvOncS8chPDhxAMWviKgp594EpLRo9E6kNPteSeG1ZY29vPVHIF8SVFOAUt?=
 =?us-ascii?Q?KcNK/PZXU8590ZL4eDCTsZhgzIDQsAkJygmmzDZTT9mpnHgbNKGMxUyAelLD?=
 =?us-ascii?Q?RmXDu0L3Ac4qhnU1fUIEFC2C0jOajgZNbXakoUS9CN1OWn5cO6YAExgZBuP1?=
 =?us-ascii?Q?qOMaCHfKWGfFnqu7o3wCqesSeukmnjpWZsyW/VJLML0Q+pJg2dBewaQDniEp?=
 =?us-ascii?Q?zwYHLkwZt7nkTIITZPF1YFzuJG8MdtL6KvJRQLQto9xEnVv9KqX54d71i83s?=
 =?us-ascii?Q?UGjgbo1fHUu/S8j/irfUITt/8taqYloo6NIkq4mQ7OOkPe+//axv8A3Svyd1?=
 =?us-ascii?Q?yIghNVYzLtzwOtXM1OgzuLzvyIQlX0ewzbA1fb6Bal9i0tKb90TXYBvajhKQ?=
 =?us-ascii?Q?Eei0RhA+LJ88GxCfYckgHathLT3KEx3Y4WzrJh3k+3Ve7kpB5ey8fbllqenZ?=
 =?us-ascii?Q?6H7J6Y1TJd0woBmXO9HDgGbCR+Oi5PI81z4Umf1Ier4yiP8aHpSFcjyEp/oz?=
 =?us-ascii?Q?4Xf6maBJAG8hkYEjkt1yz4DccEzb4hy9vv8WYx+2RZ4VBy3hwy84d5GDcUPo?=
 =?us-ascii?Q?/r8XlYXYvQ6ywHHir7+0vN5mYwg/w573SeelFrSX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2164c6-2e9e-4666-6792-08dbfca8552f
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 13:26:51.9699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tdnh32oSY5aqZE0RBb4rdgi+gDJmsdRPk+mEAICUqDhRkraw0KXFMTdketJ5lpvRd4HCm8FwD4/Va9X/u2Kgxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8708

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


