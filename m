Return-Path: <netdev+bounces-27677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3296877CCD8
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 14:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3CD1C20D40
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 12:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9CA111B0;
	Tue, 15 Aug 2023 12:43:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC89E101D6
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 12:43:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2128.outbound.protection.outlook.com [40.107.243.128])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7128E1B2
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 05:43:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmeWVLyJBbYDVqlWeYkDiFnvtZ0/KQFg1O/RWjUyzspkj5/qvRuztm7RVq7Yhcq/v6eBZwYnXtvs/ukMODpgmC2QPjzqBlMx2kbrprLRJqUfQ10iMESgT2hw0OvtFLDUmQ4JtJo3zLET9C9jysBgPemOmxyyIaD5t6XBerIjbk7XNrbD0i65Jd4uOZNUwT37t1J8diTwZE1DipjiFoyB9FlkozQtdH2wfHjrEX9RSgbS3oONUKo4iVjVcXlMNDgkd3E8BGNOtTKLqJD0S6FEQHPFpKHLrhqgJNgAB24W+vtB9+op/gJfYtIjVhleAtUXKzhe+B8XBIrNPsCMXntdYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlMa9Py3GuRh0RhsnjhBah8SbSQdL4JOpC4A4wGV/Cw=;
 b=m8JUP9ggGDpb1q5LhD5YABr8XTlEX/+xLyThMGn6cUrw7nfbAMMAk8VPO0VgXUMhl1wAEytx9WifNLGDoe4/wlunOSCElMchixcLW9Gt88e+vJk3ylPFasM0mM4GRGwApdVPy/xtWqu5HNPJiB7tQxssm1nUb2vtFhpbTn27ISy35xgLpjYerFfd2gr4WuSDVyjdeKDxUT8rRvj29XU1csd2tO+ouu3tr54QVoe+F8NEFupEsQ9VPFEpyb7qYBOsp49evBsYqKvLzI3eCD01Ayf9jp0tdqxAY9DAJSh7Hn18pr2CFM0ckx0m9c+JjTSVk5ZeZtoI3BLUX8B8C5+ARQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlMa9Py3GuRh0RhsnjhBah8SbSQdL4JOpC4A4wGV/Cw=;
 b=PW6Tpu7NiBh8v1EDqU3tgZauVP4svbgY0Ob/i6+coda6iVz+iXpXbzqP4K/zsZgopo6U2wEgG0zGe3wTExDyiqGHxbb+I56Im/YEXJIv02FMfGPss5WFfmjRBtBW7j9ISJ1rPXdBZf2Tl2nO9Alwpp+RlGt0JqIvEAPFgBI7OXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 SA1PR13MB5538.namprd13.prod.outlook.com (2603:10b6:806:231::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 12:43:52 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 12:43:52 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next] nfp: update maintainer
Date: Tue, 15 Aug 2023 14:43:25 +0200
Message-Id: <20230815124325.14854-1-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JNXP275CA0045.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::33)
 To DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4249:EE_|SA1PR13MB5538:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e15621-6240-4383-d278-08db9d8d4775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qJmYACsGC03OLVfxdqBg0tXs+2plCmzj/lhixLE0j3R5TaKvW4RxJLL3sEqGUJhnKUgOkkMRhqAo7vLLE+k5l/3+btGhANLPbDKrBqAtbgNtxKLTOXqbQ8TEmx88YKbZRfEf0P0zz8F+06wyUZRdoVsroiePbRg3fGZcWxEKUUTdjKokSaroeRxjYNE2VKaUTR6yioKCrc4QYcBh3h1PgWNNcwcJzQrBlCdC1bRmrFOJg3Ya7btMvBrmnKFyCdW3NOIa00bWixYm2ax7/zcfX4SFd6qC3EYe9PGavIVfRWIsjCrDFE3tAIpjeOPwMof7gdUXyA9w2xzwnlb1poixfuotBKyALmcKt0MzJXOGD5WN+nVoTj9ZLUP8zcb0+383MNJ9eTSb7nCApHWTtoSOoZHj41idPSBvFRaaDOY/y1hMev+BKFl7m2g4ntqwD59VeXdSN1jrUiieuzgYj2TB+Qb1qQ4YZBzM28HR/wklHCUFsnx1CSEG3Fz/Ja+3an5SqUg+6udv3hDFRyT5SkWBxWQmYZUVOJ2kS5CHGanDtrmv3huvkqRWXbKImJXkWN3MN12sNVlI8o02ApTT5D1HHpYZ+xmOCaU3YiKZBmmMyWAdQzM5bd1b0vV4280fYE/lGGwtVYMb0zrCESVDn44quvpNwUJG36Uo1As9rmqbyNXO/SBC52lLyB/hBDbyKzMuPdVQg1xDaTWZIyjAnoNAgQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39830400003)(376002)(346002)(366004)(136003)(451199024)(1800799009)(186009)(26005)(52116002)(36756003)(2616005)(83380400001)(38350700002)(86362001)(316002)(41300700001)(4744005)(8676002)(44832011)(5660300002)(2906002)(8936002)(66476007)(110136005)(66946007)(38100700002)(4326008)(66556008)(478600001)(6512007)(12101799018)(107886003)(6666004)(6486002)(6506007)(1076003)(55236004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WwML9WblycVl789kNZzDcT7+u6Q2LP9bV6SJ8aAx8xcA7MGOnmffqpy1B20i?=
 =?us-ascii?Q?fRMpBBvrFO88uIbqLbo9oHOAh21eL47vCEnoqPDmEN8Mr0wkumpfKOe12kzK?=
 =?us-ascii?Q?GDiuE0wUe7NtrOVqskVDK8Yt7wnimwuDNPCesKT3X7dTSP0+GM+t+JZ86tQO?=
 =?us-ascii?Q?aPbSPM3QPkF1OEXgwZf6aNt661x2xvt0e7qfUPZOEIhqvaFJ6ye930jPY+Dk?=
 =?us-ascii?Q?QXfY6r/RRqIt6iqe/6Wt6ey1Vm+kkzczs5Wmrp/10du051yTqkEkLS5OOBig?=
 =?us-ascii?Q?vZm0J27EqeUAQcdPUW7a+UVwrjbXwWtY9KNe+p6/hmQiWre4/3gf9tKZzZ/w?=
 =?us-ascii?Q?vtWUf7Bk15uTgD46ENjTevH5eY7m1IQ9Q4qSd+dAriQGF3nRC2/F8016R/Xi?=
 =?us-ascii?Q?FrIEmbs9NUxbtXMvc29xITH+MmFQhO/l1tWG/bbEwB4hlFw0z/PFdLAVUhYA?=
 =?us-ascii?Q?fcqEPJsTta1mNZC9sKgMuAaWBo/mn0PXXPm5c00hsVQ8bjJMxUYjIPu8LaNy?=
 =?us-ascii?Q?jj+t1CtTaw3nyK11yHcf4rLIrjfTfBopujemfNN2stg0kbAQ3VFzQsIInQpk?=
 =?us-ascii?Q?Xjya4e9UIhZGP2WwAupNY+zv1vzdAKg52goSt+VT7XZFP8wNro9daYL2RLPZ?=
 =?us-ascii?Q?/t5OAX/Phdk2FQC/2mabf50Ki8Pj0hGdcsiBYs2s8518UvtArgoOThcEYm9K?=
 =?us-ascii?Q?PckrmFc5/iPCitWAAR4ZzWoU5RmOONTO/yaAK9Ir+ILvu0kowOiW/0zmeuDx?=
 =?us-ascii?Q?o8ztc93Mk61pxac72TxMrkAF1C7tdRic6f/j5Zc7C6FGPGj8mB0jdThA0yJU?=
 =?us-ascii?Q?kCFSMmKSYOsUEWhDoq5fKWI0hzzFd7w3zMcNemGrO1sEw14Vfph+sqMSPz66?=
 =?us-ascii?Q?eVfKIVJBUd6Kjc9PYJOIIV1tZds8khm/0CdhNiRHY4N6hjSnweUDx1flmhTp?=
 =?us-ascii?Q?HCn1lqyjTuJoRZi4J3cFsvS0tcgmhxnIhpSxQxQSRe8zU2wge1Crp/xoZdWa?=
 =?us-ascii?Q?WeHI78651/wBUzvs1e+bAdkX62aBfzYx7u2rQ1Df+esqSAMIi3+cYzyCWKi5?=
 =?us-ascii?Q?Vd1YQFtnU/DC5Ax+IXXCvVJd3TfIYPkBX9vBOP2GFsedDcfCgK+ZXtXS/5+I?=
 =?us-ascii?Q?BQ+FVgJRWzv3jNabJ+bE1LZPyfL4K6iNp6DOg2ri6QL4q/KSfJHpq1te9rIP?=
 =?us-ascii?Q?wGPjBYnffPncFkr85vE4KYHWZFcD62/lYnVvEp0W4s5A+fIFLnWVfokqpEHw?=
 =?us-ascii?Q?jVc2XszLD4x/Y5hy/7xlkgtX9aCxCW1b2AfL+NkXcKvZHRMAvxcf0xieq7SL?=
 =?us-ascii?Q?e+PpG2cXOvFp6GYoLJVCM8xbjYXlQIOWC8LBCeuJkK+0OZa6534QAf/VJJ7q?=
 =?us-ascii?Q?V5oqYsURxM2nHF80eyYF83L232pfeDNKFnpBKVtC+8bTRbdgL3kYNyU8eKcw?=
 =?us-ascii?Q?/9RbJuudFH7mAhnF+CM8kStaoahf+GrGX1SYt9Vuhe8NWUSZjcHmurH1A9Yh?=
 =?us-ascii?Q?rpamc+FBd8g6J8SYvbDCFpfF3OPMYlHIgdIfxSN8nNtHczRTgo1F6gVW2GPp?=
 =?us-ascii?Q?0eYTwnn5akAU6xIwDdf4l4GT3M9ejo/4MyWL9MGUa8VW9p9mvQgvnRULGSxq?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e15621-6240-4383-d278-08db9d8d4775
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 12:43:52.3971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nApQI8wermujkfD1+bC1cvbxxd5ZTu5gn+kYYoaiB9FfZJbB4WDr9+up243PSZfPYk2o04m71cyjaVrMPxE1CAdqdhb10UAwybWr4UThuec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB5538
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Take over maintainership of the nfp driver from Simon as he
is moving away from Corigine.

Signed-off-by: Louis Peens <louis.peens@corigine.com>
Acked-by: Simon Horman <simon.horman@corigine.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d984c9a7b12c..f150561a396e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14658,7 +14658,7 @@ F:	drivers/rtc/rtc-ntxec.c
 F:	include/linux/mfd/ntxec.h
 
 NETRONOME ETHERNET DRIVERS
-M:	Simon Horman <simon.horman@corigine.com>
+M:	Louis Peens <louis.peens@corigine.com>
 R:	Jakub Kicinski <kuba@kernel.org>
 L:	oss-drivers@corigine.com
 S:	Maintained
-- 
2.34.1


