Return-Path: <netdev+bounces-28105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CA677E3E4
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896801C210D0
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD3A156EE;
	Wed, 16 Aug 2023 14:40:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE9B156D1
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 14:40:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2133.outbound.protection.outlook.com [40.107.244.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697B3DF
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 07:40:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBsCLWi8qAoQNX4ErRxXgua6RBm5MGwr7CFw1tGYD4dfG+BKZZZLsyuwkrfbCNLV//PGx5/trVEknd1+o178KzZsmMre7u90FKgxyODosxHT1B1A1060wDSpx+o+n+QP9SDZosHuj9Bw4VBnjGaB2X0N1wrh8NnIQOygVP4I6M0VJ3+b9FzgEFtsHJsqPDk43y6rfCzosVX/wJJ/Mrv30WqfOV+lHi7bowjDUdbXQjzrXur45Dsy09a06R1Vs80Y/jPhex5D4ErzH18gjel5APRgymtotAHyXSKIXAcDw8gv4EKM/S7E7ZapozoxGYjHy+CGCcPzz1s+BQzPNfKLnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBlNZmNO5a070nckayBvpOAGIsAcwrvOv/jNrAKlHbU=;
 b=Q/Od989EmMYMYtMSlagEfungHB7LEhBLGQ3qMGiAzLIA3+53ZAE0qCHtdFCxjCCl2kPB04ts2KMpKhtblmWhD95xiD3pkJjYbbQCG7BPIwKtT770ee615DYvKgKfMWNtgfvULxV0OggiUolu3Ht8N+V05QXvO8r98Ijc/nqfofLl6LBA2a1JnYUYnglPaDNngm6FMmPUThyIeaNp2jlKDyvJPJqfwWxopr0YL+B2E05PYWoN2jjDAfCHYHVfgCs2oQ0Fk2RvNu1f0Hl9dd7Nj5dciG4WpLy0N1MVGIUZDr8Yxgdmt611hkB5piFHrwiwdB4e7YNaXFBJcLG52IplZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBlNZmNO5a070nckayBvpOAGIsAcwrvOv/jNrAKlHbU=;
 b=HgV9xDSx/QfsiZR9TgX9xMRNWjLkBDtqx7fOrDQ9pjeVSNSpPG93C/HrAcNld8FpCxw0J99FVtIpPNUxEYl0RdqZu/GohdSdLUIumRIORETmVGlzS2xMjPjXZm2U3qQN1VwiNDQY17mZf9KXZQcTem3ldq9SzrVg+OFMQ8Ah2BI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 DM6PR13MB4097.namprd13.prod.outlook.com (2603:10b6:5:2a2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.29; Wed, 16 Aug 2023 14:40:10 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23%6]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 14:40:10 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Tianyu Yuan <tianyu.yuan@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v2 05/13] io-64-nonatomic: truncate bits explicitly to avoid warning
Date: Wed, 16 Aug 2023 16:39:04 +0200
Message-Id: <20230816143912.34540-6-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816143912.34540-1-louis.peens@corigine.com>
References: <20230816143912.34540-1-louis.peens@corigine.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: JNXP275CA0012.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::24)
 To DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4249:EE_|DM6PR13MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: 3868b850-033e-420a-fd8c-08db9e66b186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PSNfElvPPiDE2bCbZeFqMcWyIxswCduqRTaXD8d+nSIAooDw6qiZ2eyGAKaqHFQ5RVLX5HPlNWbaOo2B4f9rHFE0WHs17MlApA955uC4ZbrUi4udk3vrS3jbSH9Jh/ippAKp6sfnbGmutpaPxHxWyjg7q5Sc9U58k5ZmPfiRV4j6TYmTJGynQfiw//NRcvCZaX257tbegPHQflDnv1VenxrdCS21YCXVyaOG2b6XPDiUuXl8xawCdHmOdj2U4RDW9kxJe3Qso6f+VL4moaRcStFePw5yZywLjC5FFAqssLTtdMmrQwIMVme7tpa9sQLvzSxfQgKuaGpO/kMbyXZs6AVBkrFx6izRrNY94mvB1/SHPnNvC6BtQAfbr46NUWbWUTXwxz2clti8FQhu80ze8AOk6obNf1PJmk0iKrNe4W86e1nszt/AEI4TqLXYIDE3E6R7G93mVmxokXHrz0C6zkWdegwFdlLv5CNxcGg/Me05sEAn1Daxwae7Dh+JIzCIpW6A8Iuv4FPpnlDADlOf3JsUHVMWv/DNOjGmIOTBvw+Kz3giYBHYtvQd9MUb4xuhbtvrVLyEVHj2m0Xjsy+pN3Inp5PZ2Ew8JG4hAQkna2As9JawwnBkYG5aMNaLJL63QxKcpeFeNRDNlYccv9odTPrMx6cNxpkWA3kXqR6d9YOqtQXgbPp3Iy1PIeMjxc6V
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39840400004)(376002)(451199024)(1800799009)(186009)(316002)(54906003)(66946007)(110136005)(66476007)(66556008)(12101799020)(966005)(41300700001)(5660300002)(44832011)(8936002)(8676002)(38100700002)(38350700002)(4326008)(2906002)(83380400001)(26005)(478600001)(86362001)(6512007)(52116002)(107886003)(6666004)(1076003)(36756003)(2616005)(6486002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkxEK2JuUjRKZGRidk1YZkJwM0NpbnFORXJtUlZBSWh4bjVobzlmLzh4QVMz?=
 =?utf-8?B?SGhyUnYxWnZEMEhUcm43bXZrUnprSHNwTmF3ZERTUi94aHVIaXpDTUMzM21T?=
 =?utf-8?B?d2Q5b1NZbnlpSHJoUUxvdy9ZNS9EeXJKN2hUK014RU9Uc2p5OVE3d01hL2E3?=
 =?utf-8?B?NjhUNXdzenpxem9JZlE1REJJV0xSWmYxNWdudUlydFNKT3dpRnNnWjRsdVp5?=
 =?utf-8?B?Y0lBTnJVSWsva3JtbDVPeXJxUmJQMEhsQ2hUVXQxS2tFWVhhUTJ4SVFKREVq?=
 =?utf-8?B?RlNtRFN6bk5XajNlbXlJUHFUVUlpTGhya1pLRTZjdFVmZW5zWVB1YXp5OGxy?=
 =?utf-8?B?MG1MUExtdmQxbXczWXcwSXJCUkhSYXZ3MW1SYmdTekZXSTFad0FTMnJsT2hW?=
 =?utf-8?B?eVJseU1TR21KL3oxeDd4UjZ4NksxR1JRNDBLdDUveTY4MlpjNVNRZVZ2U0xR?=
 =?utf-8?B?L05uRkFSTldDRmRzYW51RkZ4dFpiWHhwNmtZeXdsdU1kdStNRXZ2SWF2aVZZ?=
 =?utf-8?B?YnBtYWYxUWZCcHg1bi9TSCsyVXM5OXdLaC9majBwRER0QkZGNXNyelVrR0pM?=
 =?utf-8?B?TnJ2MWttR3A1eU44enZxMFB0SzFEOVZ2K2NteWwzVzk2WVZWVlFpQXY3d0ZG?=
 =?utf-8?B?a05PM0JTeUZyaGlEdXNUWVdDYmZDSEdGK21wSGZrUS82dUJLM2dSemwzWGFP?=
 =?utf-8?B?Sm5pbUNqM0ZjWVFFWDBtbGhJbWN0VmRjRTdPZUxvNEY4NE43NDd1R2paaC9V?=
 =?utf-8?B?S2ZSTS9hVEdkN0hPeUhrem45NXJWRmw0L3EveHRPemRpZTJ6WXdxdU4yVVA5?=
 =?utf-8?B?TVRZUmVXTG1vM0N1bWsxODFnamdMOHI4ZTI3M2REcGwyN3NYK1dzbUFGajFi?=
 =?utf-8?B?NjV3dENmUDVaMlNwV2hETUtkZTVyK01QcVZtZXdHZUdXTFIrcm92bk5Ba051?=
 =?utf-8?B?V3l5U2tHdWR3UTVNZmdIU3U3VnpTN252Tm9Ca25tbEd1RGFmMTk1Ulgxbmp3?=
 =?utf-8?B?V05DRDZHZkJ6bGN0bFhWdTcvOUxYeWdUVFRiaWYwejVRR01lUEZEL25LRzlp?=
 =?utf-8?B?U1dyNTA0UmV1U1ZNWDIvWWZZWTd2RUpnUXk4dHlLeDgzUmxBd2F6dFJLdHls?=
 =?utf-8?B?RXlXcGIzdGROK0NHdmpWZzdkaVFYWnQyZkVwZU1KakpVM012RFBVMzFyVUYr?=
 =?utf-8?B?dWI5ejZZSGpKamNLNkJNWDNhYkZSdytDWXRBcEhSQ3RvNmwxeHVWK3pxRENj?=
 =?utf-8?B?WDNPdXNpVkMveVhaaDBQaklDbS9rMjAvbSsrU3RzbEcyQ1FLVWJKM2hqQ3d5?=
 =?utf-8?B?RHRPQlVxSlBQRGlicXhvcFkvQ1VLaFdRUzkzc1VHYUVwZGx1RzBHWDNxMllH?=
 =?utf-8?B?L0pjZGw4Tzgxb3BJTkhDeGRNeDlUNVBTUS9pTzNiNVZZN0M1YkpTdHVjS2pE?=
 =?utf-8?B?b2pMMUVad2VKOGozUVBHa3dpU1UyRFBZTXFBQkNXVG1ZNGZZSVAzMUN1RVp0?=
 =?utf-8?B?YzErTnVaN1kzVjRQVGFZY2hvQnJBVXZDYnpTbU0rNnM3SXZWU3V6N2dHSUE1?=
 =?utf-8?B?c2hnQVJWbzdlN3BkRndPejFYZWloRWdlRGRNYm5nVmR4MlAxU2ZUVzRhRSsr?=
 =?utf-8?B?c1BDZmFiOXhMMVQ2UlA0T3dZR3lOMUh0anJ4ZHNma2RWd0EwM1pwZUg3N3dD?=
 =?utf-8?B?N2p6TjQ2Zi9QVWdJY0k5cG9jdFA5Q3o0RjJsK20wNzg1Ni9IOGc0MlJUT2hl?=
 =?utf-8?B?Z09pYVFrT05qayttRFBycEdJMWlLaWt1cFFBOHZYK09Cc3BZNXhaSjlVZlZI?=
 =?utf-8?B?ODV0QzI0TUdVRlc2QlkweVFERnp3VXUzRitiWVdmQ1hXcWlPU29ZZ2NMQ0RT?=
 =?utf-8?B?aHV5N1IwY1pEQ24ySEZCd0VzeEZyNXNXT2FKN3Y2eTNPMG1yS1RTVzBpcjF5?=
 =?utf-8?B?QUhXcmlKckE0eTZ1K3RVTVZUbEUySFpLVkZUaGdEQkN6VWpNQkNGWUM4K3h6?=
 =?utf-8?B?T1Nud1pOOUQrN2d6K0huNGZmL1U5d0Nsczk0Qm9OcmJxZDZNcDR4YjEvdDFC?=
 =?utf-8?B?L1o3a0hOM3Noak5mdzRGTzBXdkNZTTRQNTZ2dENkNDJNTGZTNmdDM0NDSTU3?=
 =?utf-8?B?cE8zZEFpMzFyRE4wYmFQQkEzMm9ac21OZ3k0cXRRdlZGVVRWOXFJRzYwWGNK?=
 =?utf-8?B?K0E9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3868b850-033e-420a-fd8c-08db9e66b186
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 14:40:10.6969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5OhhGDd1/LjnMx7AxJc7T0UdPU8D/vtqeTsunhv/4ayzqcMcRxhrqxdKh8msUk5MTeVLnPaCNERCELiNlKaCedsfYbC5eWHMDn8sllpBKOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4097
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yinjun Zhang <yinjun.zhang@corigine.com>

Sparse complains when passing constant value to these nonatomic io
write functions:

include/linux/io-64-nonatomic-hi-lo.h:22:16: sparse: sparse: cast truncates bits from constant value

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307300422.oPy5E1hB-lkp@intel.com/
Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Acked-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 include/linux/io-64-nonatomic-hi-lo.h | 8 ++++----
 include/linux/io-64-nonatomic-lo-hi.h | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/io-64-nonatomic-hi-lo.h b/include/linux/io-64-nonatomic-hi-lo.h
index f32522bb3aa5..60bb802d4f23 100644
--- a/include/linux/io-64-nonatomic-hi-lo.h
+++ b/include/linux/io-64-nonatomic-hi-lo.h
@@ -19,7 +19,7 @@ static inline __u64 hi_lo_readq(const volatile void __iomem *addr)
 static inline void hi_lo_writeq(__u64 val, volatile void __iomem *addr)
 {
 	writel(val >> 32, addr + 4);
-	writel(val, addr);
+	writel(val & U32_MAX, addr);
 }
 
 static inline __u64 hi_lo_readq_relaxed(const volatile void __iomem *addr)
@@ -36,7 +36,7 @@ static inline __u64 hi_lo_readq_relaxed(const volatile void __iomem *addr)
 static inline void hi_lo_writeq_relaxed(__u64 val, volatile void __iomem *addr)
 {
 	writel_relaxed(val >> 32, addr + 4);
-	writel_relaxed(val, addr);
+	writel_relaxed(val & U32_MAX, addr);
 }
 
 #ifndef readq
@@ -73,7 +73,7 @@ static inline u64 ioread64_hi_lo(const void __iomem *addr)
 static inline void iowrite64_hi_lo(u64 val, void __iomem *addr)
 {
 	iowrite32(val >> 32, addr + sizeof(u32));
-	iowrite32(val, addr);
+	iowrite32(val & U32_MAX, addr);
 }
 #endif
 
@@ -95,7 +95,7 @@ static inline u64 ioread64be_hi_lo(const void __iomem *addr)
 static inline void iowrite64be_hi_lo(u64 val, void __iomem *addr)
 {
 	iowrite32be(val >> 32, addr);
-	iowrite32be(val, addr + sizeof(u32));
+	iowrite32be(val & U32_MAX, addr + sizeof(u32));
 }
 #endif
 
diff --git a/include/linux/io-64-nonatomic-lo-hi.h b/include/linux/io-64-nonatomic-lo-hi.h
index 448a21435dba..b73acd377507 100644
--- a/include/linux/io-64-nonatomic-lo-hi.h
+++ b/include/linux/io-64-nonatomic-lo-hi.h
@@ -18,7 +18,7 @@ static inline __u64 lo_hi_readq(const volatile void __iomem *addr)
 
 static inline void lo_hi_writeq(__u64 val, volatile void __iomem *addr)
 {
-	writel(val, addr);
+	writel(val & U32_MAX, addr);
 	writel(val >> 32, addr + 4);
 }
 
@@ -35,7 +35,7 @@ static inline __u64 lo_hi_readq_relaxed(const volatile void __iomem *addr)
 
 static inline void lo_hi_writeq_relaxed(__u64 val, volatile void __iomem *addr)
 {
-	writel_relaxed(val, addr);
+	writel_relaxed(val & U32_MAX, addr);
 	writel_relaxed(val >> 32, addr + 4);
 }
 
@@ -72,7 +72,7 @@ static inline u64 ioread64_lo_hi(const void __iomem *addr)
 #define iowrite64_lo_hi iowrite64_lo_hi
 static inline void iowrite64_lo_hi(u64 val, void __iomem *addr)
 {
-	iowrite32(val, addr);
+	iowrite32(val & U32_MAX, addr);
 	iowrite32(val >> 32, addr + sizeof(u32));
 }
 #endif
@@ -94,7 +94,7 @@ static inline u64 ioread64be_lo_hi(const void __iomem *addr)
 #define iowrite64be_lo_hi iowrite64be_lo_hi
 static inline void iowrite64be_lo_hi(u64 val, void __iomem *addr)
 {
-	iowrite32be(val, addr + sizeof(u32));
+	iowrite32be(val & U32_MAX, addr + sizeof(u32));
 	iowrite32be(val >> 32, addr);
 }
 #endif
-- 
2.34.1


