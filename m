Return-Path: <netdev+bounces-155295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 344BFA01C08
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 22:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0128188487A
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 21:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464341D6187;
	Sun,  5 Jan 2025 21:30:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2112.outbound.protection.outlook.com [40.107.122.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E09F156238;
	Sun,  5 Jan 2025 21:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736112646; cv=fail; b=nIanqtt9aOMwfl5J/eAFZq/MrCt+NN8vt9hMkicnDEeje8CsJGyJR/AO3bNjUeW2PZ3Fvyl5HyjaRjmqxsQwiOay3sE6r+oToBw/0BK6CH11cAHUSaMA07dXAtJeGos8ktgbpAGcI8HJaNwyCDnhnmr5HGqwc3Mi3RxZHWGXZM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736112646; c=relaxed/simple;
	bh=qPsBN62Da0J2dSFpXzGMy7ubQq+8L0lOBIH3YOS/g3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FJZWGTvMaRilMrC37kokf0k6mi0B940QsMmoX6QgCT3TTu4J7erIJwIhLXq8kGfLnO+FikO6GXsMQoo8h1laW2Kig91o8UGXcpMcyytodzbairunS9HjBkE4104bC0SXRAC++ol+kNr8OWj2YH9aG8+GDIsAY0AzSLRNQQn+KmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=40.107.122.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nae3Zj60V9cXUmNS1i++YYWzgjoIJ3mVxjaKtaLxNVvE9SYYuiSWATRMa/zandcOsSQgQAc58/64jp0dQ9qPem3qGpvjrlsYkUM/oRVCtlnlDbo7pKQefMP+eziQS3ljWKXOyxAybdgxQJgGczYOL/a5MICVZEydkHzVjil83t36zv9APRKYKHMCYYjFqxSeM3L+9YwNEvVII2FtX9uQ/wfHjaiX7kDqYOPbG7PvdHsIuO33WhLpslHYRtwvImXF0rd+lSFOVmCpLGjRVeTww11cKlKnG0gN0NnPoZjCEaOFNe0MfdGHleAEpJK7bxJlmLLxwEZrAmcEVGXJukpK4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nf/L4Gg3kVMPsldGll9347UPy20rzbGiVkUztrSztw=;
 b=UEwfNFeWZKtipWZ6xJYAvfh7cNSFRaWk05N8JRtq5h7lQ6mY5lWU0X3wAsnllf0P/roZOLslNV2qNAA1NQ1uzHnYrvq9nmP8Su+ScrHqXeju+Le7K7WR6cMk073Seokf0Fxi6VSg3Z/nwBKDV1AD5544rVVRujJidZzJrMS8j7IOBZplhB6VPPVwOqjJ0Ifu4SnY9Rg6I03kDJavp42NVPWByUy1UAMXh+bLdR2AsrWdXeG7AHYgVU6bpsqyV6WUN0FY+S/lPnVDd3fIWg181mxU5EihU7VXyGmV7vMTGhH8T+5uYy3SwQlORIE0nCIkzPMRuQW12vpaX4WP5ohAbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWXP123MB3461.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Sun, 5 Jan
 2025 21:30:39 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6%7]) with mapi id 15.20.8314.015; Sun, 5 Jan 2025
 21:30:39 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: ronak.doshi@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	atomlin@atomlin.com
Subject: [RFC PATCH 1/1] vmxnet3: Adjust maximum Rx ring buffer size
Date: Sun,  5 Jan 2025 21:30:36 +0000
Message-ID: <20250105213036.288356-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250105213036.288356-1-atomlin@atomlin.com>
References: <20250105213036.288356-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0169.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::12) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWXP123MB3461:EE_
X-MS-Office365-Filtering-Correlation-Id: eea7282c-5781-4fe1-e056-08dd2dd03309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TMUp1Wc6s8cspf3nHtOqRQr3b+pvbXXdOdct9wh5oJhDEBqG9v5ClZdWYXpd?=
 =?us-ascii?Q?CV8C1B0chaEmjlbbqURV4w9lZV7VMK0KfJvWlwTQ5Zy6pnRoOoTYWEaALDxD?=
 =?us-ascii?Q?GKlfkzKGvz7y3/kjqxXdQazghWwQjnBsNDyBh73kgh162714awfN8M6opBYj?=
 =?us-ascii?Q?8P8pvYGMg9K7nPsY8doBYXfFNsLmVGzH5Jyeo0RMkMD9m412vMm4bAFNf1M2?=
 =?us-ascii?Q?OFEj6u8NEr+oWJYEX71m3kaLZAE9aRSpr7uWeY7U3lacM9VT3A+aOL9GK5MC?=
 =?us-ascii?Q?70fC2qlYejIuW2TqSEJk7a4rzqUbjFcYoG4UTj5TDNGFZHHnQIbKTqpTRPA4?=
 =?us-ascii?Q?1Pz8aZmyx+KPHzKIY9gLqGCuXgNAJuFun8VglHarra0+qCDpGV6SHM/mDlFd?=
 =?us-ascii?Q?wGkHUhrJk20Vo56k0wlKCeMTat3c1kikcrwkoudN2xUdx99/n4yNmZD52NTJ?=
 =?us-ascii?Q?FGGHzYfhsFF1/wAzr47morxX4SjKhUiyQJMuSAEPH/AZnmfpFmffvCOylppR?=
 =?us-ascii?Q?qOwcl/i8wpByXzw6myaD6tdpAFnnd7N4Fnke7xEw/issee7JscolLIsYmmMX?=
 =?us-ascii?Q?t7ZElkzJTHfB7V74wDVIfnT8d7Gv20fFVxwGXQBuyuakKxQ8D0i1A1/jcp9B?=
 =?us-ascii?Q?kWrNN9s0ECfrg6rBEYZa0IqDa0UxY23jS1JEL4WA2xXRLOHn65eS+imobsPF?=
 =?us-ascii?Q?UT3fHLdlJl5EAW0sy4jdZgzSy+wHcZ8zlSlje+ZK4S5MxTuFCreraKB98apz?=
 =?us-ascii?Q?thlQ2n5QLCRg+7zeDKovuB4ey8aOv+HmqUKeOXtuvvamzIoDBkBcfsNW0kMn?=
 =?us-ascii?Q?W7iruh4xihXwXbqfQaoj23JdxlrjJE5UXibWmMSbv0xsSSZruZYffuFCQHjJ?=
 =?us-ascii?Q?fdWO90eiAXLtbrw+Ms0UEtvGINLw5m52GSMN0AxDa9Dmjmb8zDDp15XujvNa?=
 =?us-ascii?Q?cvXYLmoA2+IB5VzgMrC0b/0NfBRUS/QIqH+sZOSOAlW7HwYHTW0VicYalGti?=
 =?us-ascii?Q?+l1OpKnqTXZ5VlBNo7nUWC/Q7O8umM7C5kc1FM5LHK3R+j7R2Y3K9Gg7sHFJ?=
 =?us-ascii?Q?hVKk7YxLjQnwmzkOtDnYSNQ2HLTRPqBq2sdJ2E8Vgz2gXUEeUcfsqY5SLZhn?=
 =?us-ascii?Q?qqxwtLNnYSs/lDSVstmgjZJWA+NErcHTkLn6+9NFliX7mTM/Yo9LEm39DMLV?=
 =?us-ascii?Q?KXC1pWXD0WiaGRndZjtAMx38KWk2f6hVTktXQVjJBSZf0oDUdfhIa6t4cK+1?=
 =?us-ascii?Q?mnsW/eQFjAcB3NQ5X2Xf/mYgoR+6ZQGyz7iIMheNYpiat3fp+1/p6OjEQ6FL?=
 =?us-ascii?Q?6zB5SfZFQz0T4MlX9eY883xWk+wcY7M4nK33eEyDKLk4NlNIBNfxLwgiSZ9A?=
 =?us-ascii?Q?sWUzTwiOfnaMrMIdeuK8TShfRagP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SUBSyrmngqtli6WsxAerF5ot2oZwuNEFvyw5A+8ETl05cNC7JquqE9AFdmzX?=
 =?us-ascii?Q?wFs+nqg47g1UDs8iUTIJU4UkDu9ZO2j+7CoNV+dAjDAox3Nxeilnv3NNuNF/?=
 =?us-ascii?Q?+q0oHTT3xcZ8WW6gTaI2me2TqMjcrmD78lWG191dZRE+6ZPqa8ujxCrArJR2?=
 =?us-ascii?Q?stUOTSs+Uf6Lj8sYm4fg8+exfW5G7EkfOk5g5YmAcR1TQHqBQzQeV0aNcUmA?=
 =?us-ascii?Q?oU/nW3Rm9S6ki2sd7h5r08Wk+WzaYvrJaLydN4q557R+u9HBjlo8lhzNwTK1?=
 =?us-ascii?Q?Nn9QJB6ZV4ssytE/5CIN8UD0QvZx8LFTNw8CDmiNITrBLrkN+jqlvxVLe1wZ?=
 =?us-ascii?Q?rdG9/Ha0TJzhR9CvBSz8p+TTnWSiGu4HOb5oaszmh44xji4Geht33GCqhdrr?=
 =?us-ascii?Q?HhiMglE6UqE/IOsgcq3Qft8S0jfYoT9GbnFbARK0CFRa+onTzoMXHn4TEcNP?=
 =?us-ascii?Q?aRLstr+TFFCdV8ZY5+C+V3pdPOqBgXFAWH0cPplLLZBmTcfrsE0mNoDKRHVc?=
 =?us-ascii?Q?9ppe3ueRSGzB/XuMhx6NwVDK3u30McWoYXs8fDZhN8akgGZ581nVjop9/dKz?=
 =?us-ascii?Q?kAou6h+N57RWY3ezCtSlpFiJD0d4FVz7aum5TshY/M20Xy1veJRr7DLApL4X?=
 =?us-ascii?Q?PptGf1zsizoNzh2O+BfypbGd8Z27tx0SQFqKudovn5+7BMcGOQjqPkJzFWP9?=
 =?us-ascii?Q?WcvGvlUxvVc/omV3ygn50mLDEr3etg4t02rW4bMS9hpKVJzB4XHhSCf9hOwf?=
 =?us-ascii?Q?FQkzAHOUlBGN+cqZqkz6sHRUOqd4s/oZ3ZtZ/pRrtiTVb4Dm+q5b/xQt59Me?=
 =?us-ascii?Q?wlFoPEgBH1HJRNExYHv/lNGnqaNwO05152t1ouKQmCvu4/jx4o/14GTjW61P?=
 =?us-ascii?Q?7clu1YKccKqFmx75wn7KTDB7jhke7uFji+HKue8Oap06N//ryNWU08N5nohx?=
 =?us-ascii?Q?wa1sx2bArGO5dMYPGcFXoNtRbTqM87HYwkHWN27Ck+KqSs6LHxt2DdqBrtF+?=
 =?us-ascii?Q?HLpWghdbs4p30IjWqmL4Qd+NBuJmdMr2MrGwILbD54xSyYpYyVxQ3B/xdQkZ?=
 =?us-ascii?Q?lm7LpynNg7yTLIyV+sZtKCdwSVfQpElqjstG0rnWNP5LApRjq5MnwA34WxyI?=
 =?us-ascii?Q?egTvkPjGeeeN3nWhjnj18LShyvqb4EprvR3CWauZ11biKqk2FjAcuqxJ7hvB?=
 =?us-ascii?Q?KDLXyiKv42fwFbSXPmQViZMupV93x/FGy3SanjY6cSK4nWRRdxl8BKqSLaeb?=
 =?us-ascii?Q?8y9Ld7U0othNdLpcQufVcYiIK3LrloX5BwyRQ2K1d55M3teCWyyH0mvnsNPB?=
 =?us-ascii?Q?EAzoPQ/n5RSIwR0vCFOuNCYBi+GLlJZUcEanKRWrG/9ziI0evx3VbI7kyx1G?=
 =?us-ascii?Q?Q8TdZ41wknci6iiQ77sZZZ15HU4vnrEVmElwL9HJAVUbgxVWBMb6DIOMTcsO?=
 =?us-ascii?Q?oHFmAt0xZ8PuBMslEIuZ08AuOMg1b3RDtFHYJQ3X1oo1JMXG+cGlxceI+zQs?=
 =?us-ascii?Q?Baushd1BRB8/0YQ5rQ6F5J05ljUwDdomWppexHSy09IZbQD18ZPzI0SMzZ52?=
 =?us-ascii?Q?AuZ5Db+4fw+SJTVWCvgdocU6ifAZOL79puL7MjCg?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eea7282c-5781-4fe1-e056-08dd2dd03309
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2025 21:30:38.9936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9PZCvWJLlPZTql7SRi/TVLObhVNZE5mNFNsXBCc4YdqbXx54LTm6U/LNW6KWSsdcNzx93AUhN8HsFIzXzBW68g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3461

In the context of vmxnet3_rq_create(), the Rx Data ring's size is
calculated by multiplying the size of Ring 0 by the size of the Rx ring
buffer. See __dma_direct_alloc_pages(). Now if CMA (Contiguous Memory
Allocator) is not available or the allocation attempt failed, the zone
buddy allocator is used to try to allocate physically contiguous memory.

The problem is, when the maximum supported Ring 0 and Rx ring buffer size
is selected, the page-order required to accommodate the new size of the
Rx Data ring is greater than the default MAX_PAGE_ORDER (10)
i.e. __get_order(4096 * 2048) == 11. Consequently, this request can
trigger the following warning condition in __alloc_pages_noprof():

	if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp))
		return NULL;

This patch ensures that the maximum Rx ring buffer size is reduced under
a Linux kernel without CMA (Contiguous Memory Allocator) support.
There is no point attempting a large memory allocation request that
could exceed the maximum page-order supported by the system.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 drivers/net/vmxnet3/vmxnet3_defs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/vmxnet3/vmxnet3_defs.h b/drivers/net/vmxnet3/vmxnet3_defs.h
index 5c5148768039..cc71e697a5f3 100644
--- a/drivers/net/vmxnet3/vmxnet3_defs.h
+++ b/drivers/net/vmxnet3/vmxnet3_defs.h
@@ -466,7 +466,11 @@ union Vmxnet3_GenericDesc {
 #define VMXNET3_TXDATA_DESC_MIN_SIZE 128
 #define VMXNET3_TXDATA_DESC_MAX_SIZE 2048
 
+#if defined(CONFIG_DMA_CMA)
 #define VMXNET3_RXDATA_DESC_MAX_SIZE 2048
+#else
+#define VMXNET3_RXDATA_DESC_MAX_SIZE 1024
+#endif
 
 #define VMXNET3_TXTS_DESC_MAX_SIZE   256
 #define VMXNET3_RXTS_DESC_MAX_SIZE   256
-- 
2.47.1


