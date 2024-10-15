Return-Path: <netdev+bounces-135790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 982F099F395
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26F91C22652
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4241F9ED9;
	Tue, 15 Oct 2024 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="tUNFX+Uz"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1548C1FAEEA
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729011598; cv=fail; b=Ak84bjTk4+cn+MUPhRNW9AwcvnEor8/kLFB6IxTUJ/nsB5z9CLZsfjrwb2AZwssYAr4RlKxqfehxb/DS162gd3sN2rMZAarLUV6TFQEQABvpnU9qiOj3YRgTRxRkQ/Z6ocDxUhC+0i/3UbN8/Ezvl+iEGcWsvvEOqn8N4Fhimjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729011598; c=relaxed/simple;
	bh=TovbSJ0os06xxq2VkZmFY7wFC3lAKfN7L/IpdaJg9MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bdyz3sWYJ6217yO0lCWFCrA8ZJ3o+A73Nm6hUndDWmreR0MwBZw0X7VNHiG65WJu3m/BglT3KsE2XIljtNy9pfoNHmI3p85jnOpdHGv67UshD5PN/hU0gVP7D6K883soGA4zlTgKJXxKAR9P/P4VZRUBM+quN+ThojHejNp4LZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=tUNFX+Uz; arc=fail smtp.client-ip=185.183.29.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2172.outbound.protection.outlook.com [104.47.17.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 9C1D3200051;
	Tue, 15 Oct 2024 16:59:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSbEhLCrrC5abPcgMOx9CRIoxwVi0gpmKgpZKUybcnErXTF70anjPsLAjrcZ8b73DiNQwacskMhA+bEu48lCLEKYjTvgo8OIehrNhWkJoFFytY+XkTyWaAejfR1DqeAQWNTlCslOUM8PyFT/deLq1qrGvyOU6dSI88oluKiElHMRl8WlFDHDDhEpUlRJqUJqRdZgRWFPz0SRuCxyY3O/OGum95c1O+iokpbjj9jXMLVCFY4ggkreGrF08BdDpa4E1GcRLp620eanmIz5eQYj3V4v6wTQQYHQ8imCKWHtjRVbbIyMYHylMxGgGPdCPeyn8WtQpMe6DjpJwdsl43fNAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmEJauJotV5YE4waAL3AhBonmkwobPKGVGWn3lk9ePI=;
 b=RmUvVJF+VaVef3lmnumo8hKuJa7Oy82vRSsX4Xr1wXlh9e2WemOG0tF6yQQE76CyOAsQB2hLXaA2wWsFSvV2TutL5ufnrZgrTyu2knwmpWaDNV4Dt/JnVoXk3htNUU359gp2iprlGyb/CQ7LKc84a4hA8W5LQVGId7Ig/XQeohYfDIF+FoztZJX5k9xiOBpNkZ9OrMjN0EP9ZMG2XJYKyvoB0cQvyNMv0PcpqbiWHjEZ85bfS88I/dZlP+GTgNx6HuvMmkMzRSRLKkSH1dAFcFDOoAUzyqxIgzmB6TAJTS5kgQlopKG7hHYlRFY5vK6qEYI6Iap9Aweij+B8VERp6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmEJauJotV5YE4waAL3AhBonmkwobPKGVGWn3lk9ePI=;
 b=tUNFX+UzqWIskV1uti+PmH8K3Q5bTPKdoHESHWCYLP9HtTLaIrww20g1NML2cxSAua76UoJHqQUsJF9tXzJoE4nENOXbb51/wCpZhK+TlhDFHkfin9t9LVdrsc0n7kJp81NnSwgvXXfWVoatwzkuIVjxPwFOgZFMTklV3RTGNSQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AS8PR08MB8249.eurprd08.prod.outlook.com (2603:10a6:20b:53f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 16:59:46 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 16:59:46 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH net-next v4 5/6] Remove bare neighbour::next pointer
Date: Tue, 15 Oct 2024 16:59:25 +0000
Message-ID: <20241015165929.3203216-6-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241015165929.3203216-1-gnaaman@drivenets.com>
References: <20241015165929.3203216-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0059.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::23) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AS8PR08MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: e1afdfcc-5a0b-4ad1-ae91-08dced3ac5cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pjyaYtCvOZqkAC2k1aEFAFUXbNnbawjIbzuNZzb//Ge1sOyfcXGoYoRQmrjW?=
 =?us-ascii?Q?XXHhJmyg82P+0vWFOc0yli0l76DH1X6M8ZrMyjAGWnYwlts26geHVttY4YTE?=
 =?us-ascii?Q?atdKQeTbVJ2Qv10hBw5bsT5j8TFieMQ41mN2ZYfzUozqlZSgi46ENxmf3A7i?=
 =?us-ascii?Q?WPsCi7MjQRMi+1DqUAF2Ch0FgS0zR8YLgQZoEAIETbhRr6UjztCp4Zd3KCGR?=
 =?us-ascii?Q?xSnWQAaIu/VmUHktzUu9zuz1AydOgizZpYvVl97MVf7x5cWQ1A9MZqVslLqo?=
 =?us-ascii?Q?gOKPj+luoeG99o7+J4zmbf7yiG3hXZl3SKkTf/6lF0AN0VG0Cjf+1sNGUy1h?=
 =?us-ascii?Q?XXzQ5uubM+fMMqg7suZ6JDDcGV4iSOpDYSmQdTt5ncs0AMnfflFAOBmhTJmF?=
 =?us-ascii?Q?BOCVFkqH9Q5oeGvkAL5Tx6jRtiwuA0x9gzRlUPauo6f4UMN2vx4hujkLrETP?=
 =?us-ascii?Q?3EKLLw9XtPFDr0SP0BI+qV42RHj9rzPLXz30HUTO3oT0+q+4hPh6upBK0cyx?=
 =?us-ascii?Q?oY/7RMTgBme5A/DIep97PSZdS3RvRsqVHirhuPWt80tlfqb35y+H7BxOkw92?=
 =?us-ascii?Q?f5VA1k3LcegVcYkU01r7Op6L9zinVtN2maRG3TgekktLPej1qPtFZo92n0+J?=
 =?us-ascii?Q?r+yYQch0ydqLRaGhzWF6emZrzzxbTclWHhYZVdyV1fZ/br9Qvi8/ItJr8Fp7?=
 =?us-ascii?Q?b78odRXc00wlovySRlt1t47/PFOAQX99aL5X6h7JUqECXyvsmWKsR2ks7Jzv?=
 =?us-ascii?Q?il7v8FzTjOS2Z4kLWtP1/hx7a870Z8BjNEHHzdJqOhXnT5XG88sTCswRX5Zr?=
 =?us-ascii?Q?+Bx84fNx6uG0EMgO3veCv86mktsIEHt+WxV8STQfTXRFt6hwXs1DkggAy/Fx?=
 =?us-ascii?Q?p3nmBVvzQAH0gsLBpH0XL+l2OmqwlIObRKWFJNhtbdmENxy7t2wSVMyRAR7b?=
 =?us-ascii?Q?5TAXWblGkS/o+/3PAmsvqAIaPsuszmAch5/4jrDoc3kfv2hNTD3CYXkU9Wze?=
 =?us-ascii?Q?nL/mPvQhTYxHqB2WATFEhwuKzQAJ6NCFGm65Xf4OPPiXxyLQ+mgzKARuGk0y?=
 =?us-ascii?Q?9ZD1pg7DkfRBf0brUNQPfyglPMAIvU5GIX+HfWmRi9hhzxcMogZOxhdLFxVC?=
 =?us-ascii?Q?wOYJRlxMTBBc6KsbCqGV5IDB9gAmpaOzbpAlZqFXLsheGNDqgnLPzdAwR8v8?=
 =?us-ascii?Q?gUvJE7rvNDh84Zk4fYuARBEPql3/GUSl6kfow4zqczoBcinP0dueViXUVeSD?=
 =?us-ascii?Q?PJMkWoTOYyogyxcu+UINJ+VpXNoupAQXo+EHjwfyUNoaFXngizMiqn7f+Msi?=
 =?us-ascii?Q?4qtcvvXB/4JMK/yx9g0ntInK9InA3sgohfOpRG6Lrn6vIw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sNxvqeKwhHQ5AMIPKHZQq9l1WdU5pjbFmC2Doa6T3PbG0CuojXy1k6KsHZZl?=
 =?us-ascii?Q?x13SNJxqSlGBsVlrDNROFJX4MkeIp7M1ODWZi5yEl+vbu78K74wGEbIVitss?=
 =?us-ascii?Q?olbaS7fYZU3xKcKAKhB4+TD4g2zrYLt0smQnRkoxcBkh8Am0TaTccr1/6GCw?=
 =?us-ascii?Q?ZIeMIIGXUCZ2mIPsgDNthlmVEznL7YpQn/+PWUt9lc60aJzPpL4u+2PXLPbB?=
 =?us-ascii?Q?VGob8CgBJAkBn6kES+LQrjnmMVGJmX6DXjW2h2bQeLc+6kZ3IN0fFZWXyvbR?=
 =?us-ascii?Q?ygCEWatXja3vgkgfIRPE8fZlrnJ91MmaK2ohTpm/J0XvT/qzJeHla5Rh+jxQ?=
 =?us-ascii?Q?kDx1haflyFgEXOYL1kx68WbJrVwG+fSkrlIABoVzLXCnx9ekAW3P0AMF6cwT?=
 =?us-ascii?Q?SBd2ve1PNG8qrpbtKbzKLu4O+0cTsEb+V/6Dv3nu0pFVXGlztQlJW4AACjSt?=
 =?us-ascii?Q?zknFiUjnPIs1Q7ex9S+drUtszSolmXuD6S3b+Da2MbMyB0N3jiWd0O9RiHy4?=
 =?us-ascii?Q?awv3Og5+i/UUP71HviGjJo/ec6S//f8e1h/4Kpm6VeE8OYbYfleh9gii5+xk?=
 =?us-ascii?Q?VsoQOK7cDSD1gyeGQ2m4iFEp6ra/KN57VKXOYrbAvvmR/8yalqR8JheykC7a?=
 =?us-ascii?Q?bx+X6atXehgZAX1KCggkPsxJtoUFmrjZj3hJM7+bkc/6rhfM6rjf2pbHmb92?=
 =?us-ascii?Q?CmXTNdXZOL/GGA5RYwZuG6v5T1/V3h8f6IGF327yeTok9zf+j4zNFPVipG+6?=
 =?us-ascii?Q?7eAj+VjxFWvyWA8gZ8Q0vedV8Y5wmD97lbo0gdO+F1ha4dASBwv2PMskqIEr?=
 =?us-ascii?Q?zhG7RPRpImQwJPviXn3WUh90DLB1wB3mFsuh6Gl2DZF73R0fh977PDCDu9e7?=
 =?us-ascii?Q?Z6q/GHBKuN/ppIXUL3Yl0/Pwh7aOVZOnsME9Fp6vFUC13Z0ofbNZYh5RlK1r?=
 =?us-ascii?Q?s3dBnjuxRKeZJB0MbDFEc8zQLV8/UGOSOXcrRBkluXjoMLSFTz/8HS9lDsfz?=
 =?us-ascii?Q?vK9GUnAPvEdVSxYyTp/rczL/3ujz2RIFyDAxp9t0fYT774mAN2qp3emKaI+4?=
 =?us-ascii?Q?RKSUksv7e/+dXwR+ZrkPxA/cwy7NjcjqQEzqbftcwmd9ZK76wl31Uzonkpjf?=
 =?us-ascii?Q?W3UmJgUaiQ/u8rUbJGmC/sH6mnad6AkKZFWhYFUOxCXmGjj+iKjg7xllPyPK?=
 =?us-ascii?Q?7CmmdNZA78sownIzITVkfMdm0W/vzvNDcJnFehQI3nAv4sPiNUvfBUwmslUk?=
 =?us-ascii?Q?7pWtxHznluYT4u2S0ADOdRi3D7awB+kmWwVw8/ILPYYpp6BaGCUjYJf3Z9nV?=
 =?us-ascii?Q?fbpr9dUTq00L9tnDsZIJl0VTRoBGtOh364N+8iqhZ+414Ltb0A3Tler+0/cV?=
 =?us-ascii?Q?JStVq2XYnEjyQ2iBLyoQbKZu2XX+8rfrTsrlwGhavy9cHGZPDdbIZWKuunFU?=
 =?us-ascii?Q?/ELaM+aiBUgRHd75CFw9ficvVuxAQsVVpMy17/p7lmpdtbxBLMIyUwQZcGX2?=
 =?us-ascii?Q?UL4qdOYC2JgbziFbPWViho7qw1TJ6ex+42E79pDIyMcqynmJCB29ML7gDj1B?=
 =?us-ascii?Q?QklhRieKQAcAJLy5njS3NB+PCfLjxZKP+rnwYjcqi14voJc4EXO7GgtkxJzt?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/uH0IEP2P9UOx897GSYCW6oLkPl2B4rVnEEllpfRggi9vqPqSghjJiMdgJxrM0lLT8HsHD8XUsa7SwjvSH0jCS47UZyNhO47ow+AUFVHDUdyV1+tu8XT6hBDn0mcznSMXV1Xq9R9Z+QumC3yo/pFtYLqFbXqYCOURtXk8RHuw2wQIgEHLa+8OQHiOrJt9JHgSUKqaIZpHWrkfGzDbxDS9yJ22wGxg2GrEYim0vLBFImDpZAR8XZc/GHByq/P7l74j7subUodetNSQlZRsNWApOt3cR6qEicsJMjrf8jG2KbfZoB1zY3/C1Bo6u/foHJgpT+b1mN3uV4Q8k+23C47DO1/odnAdB5sQMrpiQd3ADHRl2FQgq6PVzhQCwNHXL68KWjhagxqUHdtjm39dh1oXnr6kUqJu7xwxa4TIsPMTBtuSJW88j4Mrdj5AITr/xtlXnlHl89OXlr2Fp+nO0A2g4O4Zh273F5GsI3Wm27j2jdllpcMPyAUDx2zuH9x9UipIP8jXRYyKqmi2IU9X8V5bR5bkVLaVABZY78JHtKfK9Nb0uV0kcySbBAjf+fteoSQDop2CEHH7cziHA/xA4dU4H15CymMeND9DwyEe8Bbxoka1KiwbHJ/PSjH2v01Aq3J
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1afdfcc-5a0b-4ad1-ae91-08dced3ac5cc
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 16:59:46.3665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGvlClagIpW8DV6cDTbsWmKkkm3Ox4E7qQUCzVPnCamvb3hAX2x+ScVdvKSPHnxDRiAgeBQjSMzG49G6JXkpRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8249
X-MDID: 1729011588-V-0D41zhNx9V
X-MDID-O:
 eu1;ams;1729011588;V-0D41zhNx9V;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

Remove the now-unused neighbour::next pointer, leaving struct neighbour
solely with the hlist_node implementation.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 include/net/neighbour.h |   2 -
 net/core/neighbour.c    | 128 ++++++++--------------------------------
 2 files changed, 24 insertions(+), 106 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index c0c35a15d2ad..21c0c20a0ed5 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -135,7 +135,6 @@ struct neigh_statistics {
 #define NEIGH_CACHE_STAT_INC(tbl, field) this_cpu_inc((tbl)->stats->field)
 
 struct neighbour {
-	struct neighbour __rcu	*next;
 	struct hlist_node	hash;
 	struct neigh_table	*tbl;
 	struct neigh_parms	*parms;
@@ -191,7 +190,6 @@ struct pneigh_entry {
 #define NEIGH_NUM_HASH_RND	4
 
 struct neigh_hash_table {
-	struct neighbour __rcu	**hash_buckets;
 	struct hlist_head	*hash_heads;
 	unsigned int		hash_shift;
 	__u32			hash_rnd[NEIGH_NUM_HASH_RND];
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index cca524a55c97..61b5f0d4896a 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -205,49 +205,24 @@ static void neigh_update_flags(struct neighbour *neigh, u32 flags, int *notify,
 	}
 }
 
-static bool neigh_del(struct neighbour *n, struct neighbour __rcu **np,
-		      struct neigh_table *tbl)
-{
-	bool retval = false;
-
-	write_lock(&n->lock);
-	if (refcount_read(&n->refcnt) == 1) {
-		struct neighbour *neigh;
-
-		neigh = rcu_dereference_protected(n->next,
-						  lockdep_is_held(&tbl->lock));
-		rcu_assign_pointer(*np, neigh);
-		hlist_del_rcu(&n->hash);
-		neigh_mark_dead(n);
-		retval = true;
-	}
-	write_unlock(&n->lock);
-	if (retval)
-		neigh_cleanup_and_release(n);
-	return retval;
-}
-
 bool neigh_remove_one(struct neighbour *ndel, struct neigh_table *tbl)
 {
 	struct neigh_hash_table *nht;
-	void *pkey = ndel->primary_key;
-	u32 hash_val;
-	struct neighbour *n;
-	struct neighbour __rcu **np;
+	bool retval = false;
 
 	nht = rcu_dereference_protected(tbl->nht,
 					lockdep_is_held(&tbl->lock));
-	hash_val = tbl->hash(pkey, ndel->dev, nht->hash_rnd);
-	hash_val = hash_val >> (32 - nht->hash_shift);
 
-	np = &nht->hash_buckets[hash_val];
-	while ((n = rcu_dereference_protected(*np,
-					      lockdep_is_held(&tbl->lock)))) {
-		if (n == ndel)
-			return neigh_del(n, np, tbl);
-		np = &n->next;
+	write_lock(&ndel->lock);
+	if (refcount_read(&ndel->refcnt) == 1) {
+		hlist_del_rcu(&ndel->hash);
+		neigh_mark_dead(ndel);
+		retval = true;
 	}
-	return false;
+	write_unlock(&ndel->lock);
+	if (retval)
+		neigh_cleanup_and_release(ndel);
+	return retval;
 }
 
 static int neigh_forced_gc(struct neigh_table *tbl)
@@ -389,20 +364,13 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 
 	for (i = 0; i < (1 << nht->hash_shift); i++) {
 		struct neighbour *n;
-		struct neighbour __rcu **np = &nht->hash_buckets[i];
 
 		neigh_for_each(n, &nht->hash_heads[i]) {
-			if (dev && n->dev != dev) {
-				np = &n->next;
+			if (dev && n->dev != dev)
 				continue;
-			}
-			if (skip_perm && n->nud_state & NUD_PERMANENT) {
-				np = &n->next;
+			if (skip_perm && n->nud_state & NUD_PERMANENT)
 				continue;
-			}
-			rcu_assign_pointer(*np,
-				   rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock)));
+
 			hlist_del_rcu(&n->hash);
 			write_lock(&n->lock);
 			neigh_del_timer(n);
@@ -426,7 +394,6 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 					n->nud_state = NUD_NONE;
 				neigh_dbg(2, "neigh %p is stray\n", n);
 			}
-			np = &n->next;
 			write_unlock(&n->lock);
 			neigh_cleanup_and_release(n);
 		}
@@ -532,39 +499,26 @@ static void neigh_get_hash_rnd(u32 *x)
 
 static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
 {
-	size_t size = (1 << shift) * sizeof(struct neighbour *);
-	size_t hash_heads_size = (1 << shift) * sizeof(struct hlist_head);
+	size_t size = (1 << shift) * sizeof(struct hlist_head);
 	struct neigh_hash_table *ret;
 	struct hlist_head *hash_heads;
-	struct neighbour __rcu **buckets;
 	int i;
 
 	ret = kmalloc(sizeof(*ret), GFP_ATOMIC);
 	if (!ret)
 		return NULL;
 	if (size <= PAGE_SIZE) {
-		buckets = kzalloc(size, GFP_ATOMIC);
-		hash_heads = kzalloc(hash_heads_size, GFP_ATOMIC);
-		if (!hash_heads)
-			kfree(buckets);
+		hash_heads = kzalloc(size, GFP_ATOMIC);
 	} else {
-		buckets = (struct neighbour __rcu **)
-			  __get_free_pages(GFP_ATOMIC | __GFP_ZERO,
-					   get_order(size));
-		kmemleak_alloc(buckets, size, 1, GFP_ATOMIC);
-
 		hash_heads = (struct hlist_head *)
 			  __get_free_pages(GFP_ATOMIC | __GFP_ZERO,
-					   get_order(hash_heads_size));
-		kmemleak_alloc(hash_heads, hash_heads_size, 1, GFP_ATOMIC);
-		if (!hash_heads)
-			free_pages((unsigned long)buckets, get_order(size));
+					   get_order(size));
+		kmemleak_alloc(hash_heads, size, 1, GFP_ATOMIC);
 	}
-	if (!buckets || !hash_heads) {
+	if (!hash_heads) {
 		kfree(ret);
 		return NULL;
 	}
-	ret->hash_buckets = buckets;
 	ret->hash_heads = hash_heads;
 	ret->hash_shift = shift;
 	for (i = 0; i < NEIGH_NUM_HASH_RND; i++)
@@ -577,23 +531,14 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
 	struct neigh_hash_table *nht = container_of(head,
 						    struct neigh_hash_table,
 						    rcu);
-	size_t size = (1 << nht->hash_shift) * sizeof(struct neighbour *);
-	struct neighbour __rcu **buckets = nht->hash_buckets;
-	size_t hash_heads_size = (1 << nht->hash_shift) * sizeof(struct hlist_head);
+	size_t size = (1 << nht->hash_shift) * sizeof(struct hlist_head);
 	struct hlist_head *hash_heads = nht->hash_heads;
 
-	if (size <= PAGE_SIZE) {
-		kfree(buckets);
-	} else {
-		kmemleak_free(buckets);
-		free_pages((unsigned long)buckets, get_order(size));
-	}
-
-	if (hash_heads_size < PAGE_SIZE) {
+	if (size < PAGE_SIZE) {
 		kfree(hash_heads);
 	} else {
 		kmemleak_free(hash_heads);
-		free_pages((unsigned long)hash_heads, get_order(hash_heads_size));
+		free_pages((unsigned long)hash_heads, get_order(size));
 	}
 	kfree(nht);
 }
@@ -613,7 +558,7 @@ static struct neigh_hash_table *neigh_hash_grow(struct neigh_table *tbl,
 		return old_nht;
 
 	for (i = 0; i < (1 << old_nht->hash_shift); i++) {
-		struct neighbour *n, *next;
+		struct neighbour *n;
 		struct hlist_node *tmp;
 
 		neigh_for_each_safe(n, tmp, &old_nht->hash_heads[i]) {
@@ -621,14 +566,7 @@ static struct neigh_hash_table *neigh_hash_grow(struct neigh_table *tbl,
 					 new_nht->hash_rnd);
 
 			hash >>= (32 - new_nht->hash_shift);
-			next = rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock));
 
-			rcu_assign_pointer(n->next,
-					   rcu_dereference_protected(
-						new_nht->hash_buckets[hash],
-						lockdep_is_held(&tbl->lock)));
-			rcu_assign_pointer(new_nht->hash_buckets[hash], n);
 			hlist_del_rcu(&n->hash);
 			hlist_add_head_rcu(&n->hash, &new_nht->hash_heads[hash]);
 		}
@@ -733,10 +671,6 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 		list_add_tail(&n->managed_list, &n->tbl->managed_list);
 	if (want_ref)
 		neigh_hold(n);
-	rcu_assign_pointer(n->next,
-			   rcu_dereference_protected(nht->hash_buckets[hash_val],
-						     lockdep_is_held(&tbl->lock)));
-	rcu_assign_pointer(nht->hash_buckets[hash_val], n);
 	hlist_add_head_rcu(&n->hash, &nht->hash_heads[hash_val]);
 	write_unlock_bh(&tbl->lock);
 	neigh_dbg(2, "neigh %p is created\n", n);
@@ -971,7 +905,6 @@ static void neigh_periodic_work(struct work_struct *work)
 	struct neigh_table *tbl = container_of(work, struct neigh_table, gc_work.work);
 	struct neighbour *n;
 	struct hlist_node *tmp;
-	struct neighbour __rcu **np;
 	unsigned int i;
 	struct neigh_hash_table *nht;
 
@@ -998,7 +931,6 @@ static void neigh_periodic_work(struct work_struct *work)
 		goto out;
 
 	for (i = 0 ; i < (1 << nht->hash_shift); i++) {
-		np = &nht->hash_buckets[i];
 
 		neigh_for_each_safe(n, tmp, &nht->hash_heads[i]) {
 			unsigned int state;
@@ -1009,7 +941,7 @@ static void neigh_periodic_work(struct work_struct *work)
 			if ((state & (NUD_PERMANENT | NUD_IN_TIMER)) ||
 			    (n->flags & NTF_EXT_LEARNED)) {
 				write_unlock(&n->lock);
-				goto next_elt;
+				continue;
 			}
 
 			if (time_before(n->used, n->confirmed) &&
@@ -1020,9 +952,6 @@ static void neigh_periodic_work(struct work_struct *work)
 			    (state == NUD_FAILED ||
 			     !time_in_range_open(jiffies, n->used,
 						 n->used + NEIGH_VAR(n->parms, GC_STALETIME)))) {
-				rcu_assign_pointer(*np,
-					rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock)));
 				hlist_del_rcu(&n->hash);
 				neigh_mark_dead(n);
 				write_unlock(&n->lock);
@@ -1030,9 +959,6 @@ static void neigh_periodic_work(struct work_struct *work)
 				continue;
 			}
 			write_unlock(&n->lock);
-
-next_elt:
-			np = &n->next;
 		}
 		/*
 		 * It's fine to release lock here, even if hash table
@@ -3118,22 +3044,16 @@ void __neigh_for_each_release(struct neigh_table *tbl,
 	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
 		struct neighbour *n;
 		struct hlist_node *tmp;
-		struct neighbour __rcu **np;
 
-		np = &nht->hash_buckets[chain];
 		neigh_for_each_safe(n, tmp, &nht->hash_heads[chain]) {
 			int release;
 
 			write_lock(&n->lock);
 			release = cb(n);
 			if (release) {
-				rcu_assign_pointer(*np,
-					rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock)));
 				hlist_del_rcu(&n->hash);
 				neigh_mark_dead(n);
-			} else
-				np = &n->next;
+			}
 			write_unlock(&n->lock);
 			if (release)
 				neigh_cleanup_and_release(n);
-- 
2.46.0


