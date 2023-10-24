Return-Path: <netdev+bounces-43850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EDF7D505D
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 14:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B37628199B
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 12:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85960273CB;
	Tue, 24 Oct 2023 12:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HJeGhH4E"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDAB2033F
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 12:55:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FA9DD
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 05:55:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faI4jKlWKuzvNG4LTdG5/ZpdHiTJkkOnCt9A8lNGPQsz8s3i6AutGa6rjIngD5hVv7tsI5Xn/qABHAFr1HcJ7jktOQWjhzDElCr5p7q/duDnRV5W7CkK/IUqMNvuy77DnbwCCxzqOM12oXQOwBBpi7ViXPu8bG3HRQ+3Y4UGofPxuQkuaxbJGFg7edRTJddFL4rtoeNV3rVpM11Pc3XC4gTE9BDB/jF0AbyAMmvoCQ0los0NpIGgtm2uVwXDNfLtpykUENdC6IaixfOWYqgdtSoP6sGlRi7uc9cBeUHBmFtcM9L7Rq72ZQwgMx7MLytEHALE+Eaoh4vT0fOIAkFNag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVhYgmoQQgwNGg70Yd/OYeT/fhog1Ihoa6b4xYGf9ms=;
 b=RTJwiQHpNzmCuRP4cf4pf47BdKH5TdTn61eBgIcW6Xr75/DBSJMlnGN3IUCIA4T3rc/t0NNZID50aFCSPWKAI1i4RY7iVZu8/gisxOSVZNs82s5XrODxYZToYgaCmsANbDvGymk4GmwlimTKP0J4LZPgCYqRF4Baff0Atbld+GOwrL07GP4QX9QCF/1DfDK5pCGVYQRpKENKoypKw6/1LC0ZM9eUlCEaymKJRT47+mczee6k2rjeps+K4KdY1/n3KGoivrlcYickOG2EmKOQ8rI1Of7IRjuNHafjrVYyNsI6XT2BAUpC/JWrudnHG/niF1U1uI6QQS2awaPAluR+PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVhYgmoQQgwNGg70Yd/OYeT/fhog1Ihoa6b4xYGf9ms=;
 b=HJeGhH4EXQ/4+r78X+BcC9ui1qhNOg+uhODQdpUUv0fHOSNPMkizEmpbUAebt278oiJJUag5l2/rkGlcAZhNTaYtxHZ4hLO2fsX/OrvrdhttV3o70ZWFiCgC2pNWgjx4C/kGHxOThq4GuCaIpeT/IgLMK14foPDZZghIqQTF7Av1uoeV8jqFj8GPhf2avLAiydelWxZAhijKh6s2SSYlYlk/eXkREf1yUPPE/fFgEeydGBxhy4Cl+ZYI7iqu6jhdehtqpWDZ06pIaVli1OSMwd50BoN+8fuiWqdCY9qmVpwq7U9vEBwYr04suzBlG2bXyO8WDzCl46mBa5iPyEAqYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 12:55:16 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%6]) with mapi id 15.20.6907.030; Tue, 24 Oct 2023
 12:55:16 +0000
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
Subject: [PATCH v17 03/20] iov_iter: skip copy if src == dst for direct data placement
Date: Tue, 24 Oct 2023 12:54:28 +0000
Message-Id: <20231024125445.2632-4-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024125445.2632-1-aaptel@nvidia.com>
References: <20231024125445.2632-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0065.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::29) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|IA1PR12MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ad6d17-801d-490d-ceb5-08dbd490784f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i78u5QqzhuABN2gOZnbXzYp40sJDaUAnk+F6TyOFo9PUA9PvS7z7vmJUSsBWU5x1c8cTE3kBORRjgXk5RhVVUBl6J2higI9KOvOBVlUEEnaZzVcZwf8AeLQf+gN27YmkXZsPcbJoBWW8nMBywOlcQp2Prbaxb6/r4c7jpBOd/oDZfVfC+6E3yIwV7vAwv+rpD5SJd4IEyJUaNcTHZ+NkEiPFuUIRxwDxoEeHfz5SxlxlqNa7/DdR7+cuI4MsszvHQSAhjJleG+m13qKcGH5PgTcCpnD/UzQ+C60vu6WIDMxpEJvAjmy/ogXJqhGp4AAgiLdZDJe+dgIH7zN31zhZwTwfPkS1Vp/ascNKZEyW9kCzHHzNzb/Ps2i6hi6MSbYI7oJsEN+FFDv7Q9Dwu/GRn+z3eAUMeLvfSIgs+nBUAzgcbYhkyKsUX1XdaKfOmkgvR51UyF9BXWZAY/8EDneTcQvb1B0aY4gVn/q30JR4efbrOsuk92QCxkpqG1OolQziO/Eo0+kGP5nO8/okkP/hT3hGXyM9Hui/46UXt/B9O0JZqUrkUB5h9BoaJF8c4JGd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(478600001)(6486002)(66946007)(6512007)(6506007)(6666004)(5660300002)(316002)(66556008)(66476007)(83380400001)(41300700001)(2616005)(2906002)(7416002)(1076003)(26005)(36756003)(38100700002)(4326008)(8676002)(86362001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RlIG22GgMjVnAg9RcOsCSwMI0ov6hAHp1ZDAanEClO48LyI36gP05MQiSykf?=
 =?us-ascii?Q?2VbDQAWBoBt+P9w+Y/jqQChQg3Vjm5tS3HOptI3cHvsfcrzYy4F5K9TDe126?=
 =?us-ascii?Q?SHDsAhQZK/PpK6dwgLgYi2JPbnkNfM1b8iCFEh/gbK6izVc/ECMAeXRz6jaJ?=
 =?us-ascii?Q?1UMbZyFDozrmurH5gADGQeoxRgE/9k0O3yP7QJZDXeUdRTCpAVJ1pJtsGMlV?=
 =?us-ascii?Q?N10PhoWK0bWT7fU47skNv0AYd9kv2A5S2nmfglDTOAnXMCIaERyWbV3Le8N/?=
 =?us-ascii?Q?EY1qFiH5jL9dsbyeRQXm4ZTY7uclYl9pawSCk1DhD2qoMB+a7bw2OQlJam8G?=
 =?us-ascii?Q?PaNncMKOyT5mZlADU3AhPg3OoQ3c5kKRQ/JUx1DcQXC8d7XxS3EA1OyBkhCq?=
 =?us-ascii?Q?w2dbg43zN45Y0XmxBDqvT1InqFdAvUgkKKdK4vO/5OTmwsEibfpmuTeu+x1x?=
 =?us-ascii?Q?Tc0ZexTgIGZ02yFnCcyFXU+79iy0iEZREkTI1XKDbQnqmd7lf2UUEWxV/nG1?=
 =?us-ascii?Q?sSLmYZOmMjgGNnmbj8ChJ6vzBR8DjKecHdS9cwvXC6/3FXCLiQwzssvTqCRj?=
 =?us-ascii?Q?++vdC/Esy3IOqoRWtOgit1IVE+GG+yqhlpEavbLGVn/dPsgLJ7iQYC2J2Dry?=
 =?us-ascii?Q?PQsJf4kUeRzTtyjsoX1X5fXsxaba+H1CWlKXQGIDMYx5la74BkYKFlTMvMbS?=
 =?us-ascii?Q?QUOCMtEquDpSgo5NUK+uoezIqdvH+nkjb06NNGDbqqAQAJ+oxOqrMul+lY3p?=
 =?us-ascii?Q?Tu0lOxWLUZkGPMEALX4kjoS9deKhvJHfn+XCLk50lI1OgKKpP8s4m3OJ7ZCW?=
 =?us-ascii?Q?6Rdt0jSJ58iGvAvUZUboGw+0WsgkVShBpMKYEtIY01qWM1fMEhM1OLxZWF7Q?=
 =?us-ascii?Q?SIvS0MMpYWin4SrGEWsS1dOVUTzAuWSIf3hlIStQNuQqbrtu5LFCmTwOkwfG?=
 =?us-ascii?Q?aXObkZEGzlEiLS+uls1cvu96gdzhXOky5P3kRn7cirVxI/Kxrxf4FIfpidLi?=
 =?us-ascii?Q?/z35BH9ulj4Haj0ecsMIooSpxR/63uQXZGVr7j9XMGziVBX3gyswoCX5GxhC?=
 =?us-ascii?Q?16l2+Ev5XcDsSnAYJVG30CEOur5T6pyX6pjhYETkPRpv0/xhvLweU+EuxGP8?=
 =?us-ascii?Q?o+JQ7ocRfbVPksGhN7/VF98NhjRuIFhgqi1ylkqWjlXJPuhnNea8uR7y4gMq?=
 =?us-ascii?Q?v+8m92B/LNq638qGubdHNwGytKPMl/DlVECi84qrU5ljRfq+UDRmJMdlKalh?=
 =?us-ascii?Q?PKvo/LnOZ96ZF6Q5ZzqdT+0RdYQ9APox1o5eogGGRArnH+P2zjByziK86VKH?=
 =?us-ascii?Q?8ZJ+FIXQQ6XaLJPdaAqIM7n0LSfFpKkbP7xtqYv1gqWGM1jzeEj5MfxuMSQ0?=
 =?us-ascii?Q?6NnaWjophV3S6I2zq+h+IieAq4vY59BwNSsl6PK/UqsHM9wpJc8w7Rqo5sVq?=
 =?us-ascii?Q?6AvENf163pzMFloKa7znFvK795OILcHZk79UEJ6/q0jgrAxiOFB8jBXoVd69?=
 =?us-ascii?Q?LQ0sPoF195U5PeTtdLU/xX8//5K6hzeIkrHxQ4UL0YXjWI4CarK8dhCsme6D?=
 =?us-ascii?Q?DCKVH2hmxbjW9jSqp2PRV8FW+PzQnZqbvZiNiF71?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ad6d17-801d-490d-ceb5-08dbd490784f
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 12:55:16.3572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aI6oANMS44MhCP7xAwgjHes6HRo3pAHb6X+dVMv9HTXhhTsaydUqt9zCxARWONxRftaT04w5+pIBvXaAcxlkkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6259

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
index 27234a820eeb..279b2c5b1936 100644
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


