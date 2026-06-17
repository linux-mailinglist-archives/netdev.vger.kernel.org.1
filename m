Return-Path: <netdev+bounces-300150-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VZ2fKTeKMmrs1gUAu9opvQ
	(envelope-from <netdev+bounces-300150-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:51:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D536994A0
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:51:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ti.com header.s=proofpoint-05-2026 header.b=nuUkp9XJ;
	dkim=pass header.d=ti.com header.s=selector1 header.b=KoHiXlZ5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300150-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300150-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=ti.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCD5131B169D
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2799D3E3164;
	Wed, 17 Jun 2026 11:32:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D4C2E7387;
	Wed, 17 Jun 2026 11:32:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695941; cv=fail; b=DuDASj7TPoHXp+vwyZ6LpHFmVDh7rN1YcBoGsyEDC3QGyS8K+EdwS69Yecxv4ELo3YyYv7A9+E2SPU80fCS6LDg51y9NInsd6O7iZFg/IVAeAm8r+JyIR39QBR/PBMHriHGD/QcCh8Nu/V6OXX7kagwK+DSQcTTKzeKCvNzerdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695941; c=relaxed/simple;
	bh=Ofp8O1/EQsBslTNw0Oki12YmhyqGJEzLbkKGeIgBCC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qwCqn9W183iNVHlKGyfluFXuFDsNLKNbCcGvsrzt6uyqbX/JNBbt2+LkNz3lys/UcQj9G3gCLHlApCjl5fDszMdMOrN7eWhjMIqhsBexw24oQHL07X6UqAkgbr43PsFhfd6pFtmMEzMuZRclUZUF1peAYZ+0QgMy+udI3APknDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=nuUkp9XJ; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KoHiXlZ5; arc=fail smtp.client-ip=148.163.150.75
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65H8VMQQ249953;
	Wed, 17 Jun 2026 06:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=DseNcwgMfYvxtnWdRCdz0CClsXryc/hLkZBgTFtVq
	s4=; b=nuUkp9XJcg0Z+1smLY+idX4LdOpNBJjTJqYPlLlFtZDwzfswbG8/Dv2E+
	7NxUQOSvx+UVekgphKkaZ2Vhj1A8IGB61cWi/pv+mjAK7ON2NXbtEXZAm77A97rd
	dfZx/2bqaUbZ5YwPXMNy7x4TnCpD+Fu7MVZnWvXqs8CAH1OiZI2MtLNHDQS595en
	FtiN9vQRG4c8ni5+8/zFb/2AL+NH/lnV3bedaEShcgCoUK03EXUbf2knRnD1O9pt
	Mw5wvCUX0txCGBrxUbYn/4HdpAJD4klPJ1cJ0G2pNdHiwE/FGd+uVEV9BCv4bKDf
	pRl1DbSKIc6NK4oM9ilXiocyJmZWw==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010006.outbound.protection.outlook.com [52.101.46.6])
	by m0384305.ppops.net (PPS) with ESMTPS id 4eueffccr4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 06:31:42 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8bXKkbEFd26JBuaJwl9RHeE3n6njxNXMVDY7RYjNk/uKlq3L0EpYqL/k8gtA+xZ31IbBSXanZOpy3zPQdIOykwt6D+HhR3sR0iRL9+p1/SlIeoiLiK8Ku7+3JDfj/Mj5yrV0Go6Ir8j5vdK4/yZ5KEnbTxKnEMu80H4rtOcMrphY6dvs5KuGgLFER9eWTLpFzPtkGMhz2eHlpgREsa1tpq0JVF7AyDj49iH7k+F7r3oHa3ftf/iqByP7ZmCxpCYUd3pKb3HgP1F3ON0pWeDV79AQBsrXoIhCp5t5XNx5OjXlCix/GeQRe8zWvcTDvHEQ7wrm9kXERfJ+8YkIZwxyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DseNcwgMfYvxtnWdRCdz0CClsXryc/hLkZBgTFtVqs4=;
 b=dDTnNeKje3RZO+Jk80simiYVVZCO8eeayQka+0i3aYLz4uYMrjTv+Pb0g3I0g7r0dUtCRKSIwDk+EGCQjyzU9XWY8mEUwSOfSaVndqEP9q5GMq9nLwXUSAdxRzMKiluKCXftCu9xM+jOzhYIzgJIAAsDL4Ck+riSOllbCaw/FFYGfL9TiowlinNyoQp6OgF0k3B/z/h03OynGdl+ZGQ/hTdOzXgT4E0+V0u1JxzqVaAhK5rqph5x+tayYJtMmpwDtNzH8K+3ky80FZu67wwyScbg+Na91foV+gRC+8RT6cNHSfNB6fd16DrsPxaYJZmvP1aHjzFS5X2B5sLlcU6Fxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DseNcwgMfYvxtnWdRCdz0CClsXryc/hLkZBgTFtVqs4=;
 b=KoHiXlZ5uxV3Arp5X1gLUBcD5W496gtQSf6NPrhg8DtoJK45lgG5gBydttFXDJV+hKKuM869GoP/7E53Z4Ejewoiko2PkxQRQHQ9pl4rPE433pt/5NWAFA2wQ1GVPPyUGl0alMdFYDOQaDOcHMYBwMP5fkfCJXjrJYHzxXnKv7Y=
Received: from BN0PR08CA0015.namprd08.prod.outlook.com (2603:10b6:408:142::31)
 by CH0PR10MB4889.namprd10.prod.outlook.com (2603:10b6:610:d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 11:31:38 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:142:cafe::1) by BN0PR08CA0015.outlook.office365.com
 (2603:10b6:408:142::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 11:31:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 11:31:37 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 17 Jun
 2026 06:31:31 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 17 Jun
 2026 06:31:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 17 Jun 2026 06:31:31 -0500
Received: from [172.24.231.93] (ti.dhcp.ti.com [172.24.231.93] (may be forged))
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65HBVOgl2215776;
	Wed, 17 Jun 2026 06:31:25 -0500
Message-ID: <0c24f699-9deb-4fee-8d1e-4a70fa3d985f@ti.com>
Date: Wed, 17 Jun 2026 17:01:24 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/4] net: ti: icssg: Fix XSK zero copy TX during
 application wakeup
To: Jakub Kicinski <kuba@kernel.org>
CC: <diogo.ivo@siemens.com>, <haokexin@gmail.com>, <vadim.fedorenko@linux.dev>,
        <devnexen@gmail.com>, <horms@kernel.org>, <jacob.e.keller@intel.com>,
        <sdf@fomichev.me>, <john.fastabend@gmail.com>, <hawk@kernel.org>,
        <daniel@iogearbox.net>, <ast@kernel.org>, <pabeni@redhat.com>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
        <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
References: <20260611185744.2498070-1-m-malladi@ti.com>
 <20260611185744.2498070-5-m-malladi@ti.com>
 <20260615162157.3748bcda@kernel.org>
 <ed0bc332-0196-4613-8066-9b94f8ed0013@ti.com>
 <20260616081954.0d12aa13@kernel.org>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <20260616081954.0d12aa13@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|CH0PR10MB4889:EE_
X-MS-Office365-Filtering-Correlation-Id: e8cb505c-1779-476a-865c-08decc63fe43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|36860700016|82310400026|18002099003|22082099003|56012099006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	GBLkDYDJEL82KZb4RfnS5FgAt8kNudEsO7e1CmBfOBeP9/NEAf2Oc//Tz99uGMTqbgTfn9qQvrohLtL2Iqvq/Hlk0LhNisLseBRZ9oBlVZ3E7+FSjipuI5wb00V46mm4xTFRQIyaiJe9fivkWu9WvykocFOLDwz/KFUMCS/s6DohQojenFMvFaVGSYu4AfWXjG+aADRu3jkoDLbjIMM+jH8gBt5lQJ8IIkiv+wVljEPFhD+mcUtRjyYdQC3YLRFU+5akeU0dMbu77mzjK1K7yHmmrtwVS56cahK0W1ynMyaM+6OdTbSRRtMHKKuwowaINeu3yhPeZ3toGxxh1kaXlnMda0yRQ2UhiVBUXFsCtBnHmnRmpi76yL62fLBVjMP3Ltvnv0+ThDix3CY5mG1t5YypuNN1fN7Yso5zp2CJqF4SoEni8FKWibDymvXkLbVjifrH0j5clQDmuTd3KiqTI7Zed/hzus3b11AZ0bCkdHLsy8TkwJMF65T0N5E0OtapgWXku9bbhp6sDPwGmyjwPmGqDn9VvQLsP4lZdS21LmrIQLowPcjMaNornafWS30uV0hvD5GlmJ8Z/FtNaHaEUX7vY2BdU1ULUXcpD2s4tQhAhJjZeudD/24/V11GrJ7Jr3fhBpNoM+vNwxalIqCWiRZ9q0kSO2H3WhIUPFlSaIXEKI7I25ggXnMmGZrREz4zvLFEXV7Gmbig9fBwqcxvL0F2b+No3rQ1OesI7SUhBZY=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(18002099003)(22082099003)(56012099006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZCM59ArjASzF5p8hMZeJgEYEqFADG/vYTABbDkwC3hyFPNdvAv+Umeu1cZI2f/KkBqxM7YqmSblWv39IDDAu9DByc13xxgtGf8tg9VU7jd+JBUT5aes4EikO4ai37fBkA+eo3qUq/ZsRIY4rTM9xdGmwPWAZmfiowvECa0mrEjcTiu16LEqtYQ9m9rL3PlJvx3qA4c+IMNN/6iRb+2sh1w+qWNf2OHCKKu7RGYU1AOD/HjNg1+49SHMzWH4TgrVwxldn7lUEc7taCcxBlyvMJUFcjNf0lfHzKxhqZ7WRMuH1kvy7KDRcYOyNkrhbLn3nTr37Y6bJRClDxSmk87Ygsqf3bV3897yea8tAafVwxljXDFvOOhKmZ3RZFjJt4xUKdQ5ncTv7pw6X9eSbZCAYFF1TO4NsyK/3SiMaNgJLAJ1PcZOFKgnlznZ2Czf8TPdx
X-Exchange-RoutingPolicyChecked:
	W3WfodFwzg1PhIEbEc8YWJzrrFmkHNhLREHR3SKIvgKzBzWAReNRNv3lubZgMUAvtcZsQYptEQxPYimu37HisKuyL0inKA9sHFPXTTTX9YCwDGUNK6KgtQF9eJWRmqziqUIFmWmsq4rX3vBuTA5CdkuHyCGSH74u7DItzSlcs/9zdi6CFQ7U4AMmp3N+jlcOGISdm/ddZAiEuJhiS2stEd7Ufm/sTcNn3iGgCSEnouUNrkkcToWrBEvx24baqF+TOMQZjmOZry2GBhZiPn5eg2N0+WlrJjhdYKtmt01CeEZydfedZ7xfJobjaSqnN3agszwF5Jjsv7PE5rYSwSoIPw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 11:31:37.1623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8cb505c-1779-476a-865c-08decc63fe43
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4889
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEwOSBTYWx0ZWRfXytQvgxnakenb
 BmbMyl+msM9ZAIp6nH7fFXhFKvHPTlO0sMi/qX5K3FsOUFtItTmSra0c4mVGzcLQHf0hCNyk2gt
 MkXv6hRnhdvKbsVLBGT+blNIyq9aku4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEwOSBTYWx0ZWRfXyP48b3ZSbYK7
 a3NWfedKVgU2YKO0Biuwyie1vIcCf3Nl+HYmCY5GX7VblzJc/4nx4hRbEieJJyEOwmkwqC288zF
 N6g2eeR7GBglXxnZU2f31LXh4AlgVtbLnAVdzlGsJw9DV4MT6O6JeT198L6wy1COzxi+aSHbXk6
 yioO7gyEo9ZtKDLZbOp+T4fcgNOBx9Uj0Q8JtpkBDkm2WXcRMB+6KuJ7VSBR+Aiu+qYUdQjxYmJ
 o8HS411XlPURmWn59zy2xIGJ42bMwRqn6FWIifJH8dhpe0sQ4ghvdrRgjU4kFFiF58KR9ZPw8mk
 c7CX1refGsrg1OphpLwvCH2WI87enhvHC4QtyDGtFsuT+rqFTJXXk4hT/7MkCtAgHwfR5lcBRy6
 4/hX6d/HX3vEh+KwsXkMIcwzZvrfRSFgpNz0IcU4EpAGF6alPRJt14kcg6HFl/Cj6KXo3ajeByt
 12oloD4WfquQeCfL7yw==
X-Proofpoint-ORIG-GUID: TJ-26Yt8DxQBy19KaWFFmV-VGLtnJo4w
X-Proofpoint-GUID: TJ-26Yt8DxQBy19KaWFFmV-VGLtnJo4w
X-Authority-Analysis: v=2.4 cv=KKdqylFo c=1 sm=1 tr=0 ts=6a32859e cx=c_pps
 a=KOHnGYwbv2QpRqiwWHMRyQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=OLa_WR9myEd-ndLCeVYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170109
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=proofpoint-05-2026,ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300150-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:diogo.ivo@siemens.com,m:haokexin@gmail.com,m:vadim.fedorenko@linux.dev,m:devnexen@gmail.com,m:horms@kernel.org,m:jacob.e.keller@intel.com,m:sdf@fomichev.me,m:john.fastabend@gmail.com,m:hawk@kernel.org,m:daniel@iogearbox.net,m:ast@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:srk@ti.com,m:vigneshr@ti.com,m:rogerq@kernel.org,m:danishanwar@ti.com,m:johnfastabend@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[siemens.com,gmail.com,linux.dev,kernel.org,intel.com,fomichev.me,iogearbox.net,redhat.com,google.com,davemloft.net,lunn.ch,vger.kernel.org,lists.infradead.org,ti.com];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,ti.com:dkim,ti.com:mid,ti.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04D536994A0

On 6/16/26 20:49, Jakub Kicinski wrote:
> On Tue, 16 Jun 2026 16:41:00 +0530 Meghana Malladi wrote:
>> On 6/16/26 04:51, Jakub Kicinski wrote:
>>> On Fri, 12 Jun 2026 00:27:44 +0530 Meghana Malladi wrote:
>>>> @@ -169,9 +169,6 @@ static int emac_xsk_xmit_zc(struct prueth_emac *emac,
>>>>    
>>>>    		num_tx++;
>>>>    	}
>>>> -
>>>> -	xsk_tx_release(tx_chn->xsk_pool);
>>>> -	return num_tx;
>>>
>>> Why are you deleting this?
>>>    
>>
>> xsk_sendmsg() also calls this without an rcu-lock when transmitting the
>> packets if the xmit was successful, so I was assuming it is not required
>> and I removed this.
> 
> I think you still need it. Besides, seems like a separate cleanup.
> 

Okay, I will add it back then.

>>>>    void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
>>>> @@ -279,9 +276,6 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
>>>>    		num_tx++;
>>>>    	}
>>>>    
>>>> -	if (!num_tx)
>>>> -		return 0;
>>>
>>> Does something prevent us from running all this code if budget is 0?
>>> If budget is 0 we can complete normal Tx with skbs but we must
>>> not touch any AF-XDP related state.
>>
>> Can you elaborate more, I couldn't interpret your comment here
> 
> netpoll may call napi from any context, including from IRQ.
> It uses budget of 0 to indicate that it's trying to only reap tx
> completions, without doing any Rx or XDP work. XDPs can't be called
> from IRQ context.
> 

Ah I wasn't aware of this, I will add a check to ensure AF_XDP runs only 
when budget > 0 then.

>>>>    	netif_txq = netdev_get_tx_queue(ndev, chn);
>>>>    	netdev_tx_completed_queue(netif_txq, num_tx, total_bytes);
>>>>    
>>>> @@ -306,7 +300,9 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
>>>>    
>>>>    		netif_txq = netdev_get_tx_queue(ndev, chn);
>>>>    		txq_trans_cond_update(netif_txq);
>>>
>>> This looks misplaced, now we will hit it even if we didn't complete
>>> or submit any Tx.
>>
>> This code needs to be hit for packet transmission in zero copy mode.
>> emac_xsk_xmit_zc() submits the packets to the DMA in NAPI context,
>> when application wakes up the driver and triggers NAPI. Once DMA
>> transfer is done, irq gets triggered NAPI gets called which will handle
>> the tx packet completion + submit next Tx batch packets to the DMA.
>>
>> if (tx_chn->xsk_pool) -> check ensure this hits and runs for zero copy
>> only. Also above check (!num_tx) returns early during the application
>> wakeup (where budget is zero), hence it is removed.
> 
> I'm commenting on txq_trans_cond_update(), you're calling it
> effectively on every NAPI call when XSK is bound, whether
> Tx is making progress or not.

Ok got it, but I wonder if it will hurt in anyway to call this even when 
there are no Tx completions.
Nonetheless, I will move this inside xsk_frames_done check.

