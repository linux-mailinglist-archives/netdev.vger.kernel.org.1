Return-Path: <netdev+bounces-303613-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4WtTKh76RGqO4QoAu9opvQ
	(envelope-from <netdev+bounces-303613-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 13:29:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B5D6ECD37
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 13:29:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ti.com header.s=proofpoint-05-2026 header.b=oatcDWKO;
	dkim=pass header.d=ti.com header.s=selector1 header.b=gW0bLChG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303613-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303613-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=ti.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6A2C83028BDB
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 11:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B003477E33;
	Wed,  1 Jul 2026 11:26:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A01D477E22;
	Wed,  1 Jul 2026 11:26:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905167; cv=fail; b=C6lCvtZc/1SLs6vYgsZhR5AxyV4FIu7rxnO7ZvomTJf7gcDceuWsl7lJrsRMhHKUsF5lpNieqJU61i1wheS207FIxPxQxwF+lKa/zkjBhEwwMXIuIb/2DWvovIRkakachvimKQNLD4BgBIKLpTy7Rl1yT2/VecVASivihK2M7oI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905167; c=relaxed/simple;
	bh=Yf5RQrM1N9kCk6yxnzHKWAcbh2A4VM9+DSuaLQ4xgRA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kcx3j1J4bBKPeE05fnsoFt3NYEFglDUH5tP4Ws1Mq670o+aCeCByCbe1CshutR2nAMmRilo8tYgtVAkQpnEVBRPl1iu9eeLMhhwAXBmYUKZC/C8+5dEaU+qrHMq1J0eeJMUjIhyyRyS6iJs5ER+9CSU8lib6gPqCrbY8H+G9XhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=oatcDWKO; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gW0bLChG; arc=fail smtp.client-ip=148.163.154.28
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661BGM2K3560048;
	Wed, 1 Jul 2026 06:25:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=kmpxZHgQtOp2G
	e0Ilu+a2vZ+v9FK2TIdp9LqMN/BZqM=; b=oatcDWKOtohkZQL+dzIwUeQv2o55F
	Agc4oKeVu5hmVMdiPI+7Adz+z1/elTwAVoKd13yQ06PgS7ah1VWTvahPWOm2glUF
	VgVPySWheY+O3N8XbOHQt28yv44wRkqCW/Jqhe9/zY38ZUWTJrkGTp+5bQmjHORZ
	lNHmu2/lmJH733W+mZl6HoTbf5G/joWt8MkTJesz6O/ZrYLQYFQGJ7vP45ab/wPS
	rippxdMBeJYxI0rT1LDyXQv5JctP8hW0A7nko5ZzWeQ+OniPNK5hpWP2PmPwvlwa
	XO9teG5pokcZR/VbEBbISdoR8ayOu7LsJUGqVKpzkjwEwlfZfRtBLbckw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011064.outbound.protection.outlook.com [40.93.194.64])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f51ve01ac-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 06:25:50 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIFzVnuy62DOn/g9FV4ZaRAq4wk+48Jv3+Ilgg6BCTkSqpycqefFrrzzh28/kTt+LJFjeqtRP+H5RtpsMwHx1TPr4exjofBsl+i0O7voGclA0JThylzS+V5aVHNYQafaBfmuRDRffuzmJXulOap01huk95nnmsrqu2Srj9DOstwuTO/XJiPoloA4+SW22dnQdRKpUY0z4IpdFDBOh8fB9e/NLFc7wHriWSZbK57FDaZM0E4gO9GCEi5USloLQRxjE2xX8gF/ehOdk6+Tx/jxsl2b3K5avXp9I6mSCgOToInECD+ITAAK8JC04oDS1nFJuaqcoP/C2X0T3QKJt0rvjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmpxZHgQtOp2Ge0Ilu+a2vZ+v9FK2TIdp9LqMN/BZqM=;
 b=mNpl4KTuF0b21WKlnitTrF3Rxw6Fp0tVNYllU3nZftI8ufqMiN0aiTGAbXpwBMpFuHUSC7z3lqnAuaHrQlRULlIjV1dNFYemPr7hInaJm7/Yi08vODvOd4x56HOdvBeLDoF1mTbEkFZg1J1GUd7Cscrl4N7jIuTjNF2+raXPAavj8ts5V8uX2IlL9Vs+HgRaxOaxYk0iHcLRtRpwZc1ofwP1nMMJXmQVJIHlsEF0R7SFe9N73bgTWzzXhqL+NHM3l5dryh7pgDc0BKjjXe23uzFbeqPrgfDOgcILeuYAKqvaNoNWw3cc0P0psYyHI1Zbf65hV+4EJuQLFwUn8PVwVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lunn.ch smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmpxZHgQtOp2Ge0Ilu+a2vZ+v9FK2TIdp9LqMN/BZqM=;
 b=gW0bLChGNBBSNPvJ87/oSGPqU6h6QJ9FNOxi6fInquLlZkah2K6vM1qpx7SWvDuBqGhZjBI/715Vx538AxzBWn+eOrJ3vWqt5pV0O0hrOU/Yq76/+APFmonN12M9CbM1fAIcIzyS+rZj818Jxlt3GwyBcgQAtZH1N2gqeK/3gxU=
Received: from CH0PR04CA0029.namprd04.prod.outlook.com (2603:10b6:610:76::34)
 by SN4PR10MB997922.namprd10.prod.outlook.com (2603:10b6:806:4fe::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 11:25:47 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::31) by CH0PR04CA0029.outlook.office365.com
 (2603:10b6:610:76::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 11:25:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 11:25:46 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 1 Jul
 2026 06:25:39 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 1 Jul
 2026 06:25:39 -0500
Received: from fllvem-mr07.itg.ti.com (10.64.41.89) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 1 Jul 2026 06:25:39 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvem-mr07.itg.ti.com (8.18.1/8.18.1) with ESMTP id 661BPd8Y2382163;
	Wed, 1 Jul 2026 06:25:39 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [172.24.231.152])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 661BPbPQ022838;
	Wed, 1 Jul 2026 06:25:37 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>,
        Meghana Malladi <m-malladi@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net] net: ti: icssg-prueth: Fix link-local addresses being forwarded out of slave ports
Date: Wed, 1 Jul 2026 16:55:35 +0530
Message-ID: <20260701112535.4027920-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|SN4PR10MB997922:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe1adcd-40f8-4c44-a063-08ded7637f48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|18002099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	eDNugjx+5Bqu01SWLRgzPWKiR4RsocJM5VFfrfx90kiL8Gy3pAUMhBhMM/vwXeDa1nO1TxkvGk9ZzGSMIAtMlKI/sWkl3qozfhIAcPHqNK9SNjkhCdMyIt/LGMWJZq9Xan/1kOTu0mA3B1AAfsiYl05rh1Nsvt356f+zi+K1gP0ccejLcuqiVLZvWLNHFr8VSzOQAG7l4dUV/Z7twBwLTw2mlTHrK0GMfcBwqiwyCwHScxFjURhDP9Umdu9j1swHCpJ51gNB8ceQb9OBK4A935o9ktqti0yv0nd99IlSdEDl3UQ1tctS3tfRV46BC2iSwcWRN+8aVsRjc4r/K3tq1M1OwomuCmYvhGcnaBlJJWB/Uq5ejkRbOwuKFTuqMj/duprU0NdIzh4ejNaazYw2eFkhaVjx7OpovGmLcqewmzQg0syZm39tvpP1wPLEXtp/3Qmz9xHsNN1C3sfMUm1YDZkfwNgs6Zlx914rU3gaR4UcgAM0wAw744iljJIy3BREGhd9al7pDwUx8oTH1TL9IbPbn/e0lvOOIm//pka4/BH7reD82U72SaePY9FnQHsb+lq/WYf8GA4xAUsBFeauqxTbKvBp/dI4yotA5WSfJ4JPxBsQUaHYg9trsdUfdlnYGCRk1393vsC427t4pux/zpz1TfC4QwJhgAMQGsqtUSPXDPeHW0OWaPYi0DJG35F+Xg1STOkq5thsLO6/UV8F1g==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(18002099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EUnwUIcActgCIrPg2T3JLYho/a08XrDJvLD8XNUDGMOYscxql6L+W5a4w8yH9fJC0L2BFR+YZ2WgW8W6HYJGJLqnaa6jf0W91sr17d3SFCsPrtA/So/OrhBNrhb1AftW/mPSEUxA4+eA2yOyHEr7zOJjFAUtqNx36pWB534Gcm17n1jlKH7SsjA98NW3avGulXB8k/CP1xldC30so8UUoURS+igt57LmDuSiHPVsNMjkR+n0IQlIj52lhA2zBZz6n9UXFmG6T3G2KLUa24duo8vUo03caaTAVjHyr5ZgpFyj6GwgJOs7T7eFN/HwoaYb8K+ZBG0gG/thqUwnxoJwU4Oahw1wGhYFkXhiLmao5HuJDDb3tg64aDBQD4eioARcrIX6nbRR5D/XimhlSSqsJjF+ZpR1UhMTugUofTljzFuZ8Q79JUg2Eo9xAaDTh1Hn
X-Exchange-RoutingPolicyChecked:
	Hw5p0/a4+49nmtOtGljzP4GzDvkZlT6+Z/FJuLiAg70PSOgo7s4v38Ed6xPhoBR5Mxta88Xbih1G8DKcxExJCcezlmbxf6fmLMvE/Lw5YKb5hV0EhoPQi9rJT1ao58nVJGXDlIETxZYEf5EnnxINmDdrnHhF99pARhZojANHqqKf4PPUgnwamSTYHddStrA/5VejZbmVfjqsxZwZCJFq1fOm8FK0xHLgWJ/x3VCDBD5Go7iHfGUqcc3jzIN0m5b14iBiJG45AmgJCNazpnurisGRYZOg4tdeN4kITCtpqFICAGtsH7RQABa8VyEwjGEG08V/BCjNanOSrXbK6KS5qA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 11:25:46.9460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe1adcd-40f8-4c44-a063-08ded7637f48
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB997922
X-Proofpoint-ORIG-GUID: F3HMM6mCj0t6gbsNh8iF6e_eyTlf3x-9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDEyMCBTYWx0ZWRfXw4I17mZAsl7D
 U6HTT3/tOXdhksM4u/8nL/I7BVBLdxxeonbfrxYVgGqK9bHFBECqy6xyaIpko5xcXQpEnJojXAo
 IkyLYGt9DGyj2w4JFq5Uxmg+hakmor5fFJcBe4MfGr248wdEPINFVt3cIVgNzYNCFv2hgmcD1H2
 KaQc6rtOMgB8B8mS7V9hK6OQlxN3/fl9+IWsDvFqwXsKr/IA4h2ufMbhyTgdYK6773Xik09QDiH
 QUjYhRbWcuHfwbBvm/CjF670mwUTVYTO3/1otYilX5MdzMN+WH9sQqZZLRRF3Z0iU1sgpCg1jPS
 KoBrE7gurncge16Dbz5mraiib7lp6/YEx8ZGG6EKsCe6lXCCtrUB/kG5YFa4CRQCSByFxRpwlcR
 YKyHWx0ZlpRdj9qy1q3dGaIYW/lW1EZysRGW7s7Cc3E8Llx9P/54A+8JYmwyE1ioWwnQ0qVHQFg
 zsSElG9eiy3BrpTf1qQ==
X-Proofpoint-GUID: F3HMM6mCj0t6gbsNh8iF6e_eyTlf3x-9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDEyMCBTYWx0ZWRfX30y3NfXMPPLG
 YrBa40HCvORuR8i0alGEayhFWKstZvMAjMrfTPYE9Vy2eqo7ui9vmYipOIhPrtLL9RLD3MaC3Si
 fssDXXb+vUuTV0JqfS0hUcSn6//kdk8=
X-Authority-Analysis: v=2.4 cv=PtOjqQM3 c=1 sm=1 tr=0 ts=6a44f93e cx=c_pps
 a=cAYAfY5XwGGlFG+HVYY7CQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=Rd4WDvdUmoZ5dRQ_ZTIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010120
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=proofpoint-05-2026,ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303613-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:m-malladi@ti.com,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:danishanwar@ti.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	RCVD_COUNT_TWELVE(0.00)[13];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,ti.com:dkim,ti.com:email,ti.com:mid,ti.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6B5D6ECD37

Link-local multicast addresses (01:80:c2:00:00:0x) must only be
delivered to the host port (P0) and must not be forwarded out of
the physical slave ports. icssg_fdb_add_del() was programming these
addresses with P1/P2 membership bits set, causing the firmware to
forward them out of slave ports.

Clear P1/P2 membership and set only P0 membership when
is_link_local_ether_addr() returns true.

Fixes: 487f7323f39a ("net: ti: icssg-prueth: Add helper functions to configure FDB")
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_config.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
index 3f8237c17d099..04a81402e3f3c 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
@@ -732,6 +732,16 @@ int icssg_fdb_add_del(struct prueth_emac *emac, const unsigned char *addr,
 	u8 fid = vid;
 	int ret;
 
+	/* Link-local addresses (01:80:c2:00:00:0x) must only be delivered to
+	 * the host port (P0). Clear P1/P2 membership to prevent the firmware
+	 * from forwarding them out of the physical slave ports.
+	 */
+	if (is_link_local_ether_addr(addr)) {
+		fid_c2 |= ICSSG_FDB_ENTRY_P0_MEMBERSHIP;
+		fid_c2 &= ~(ICSSG_FDB_ENTRY_P1_MEMBERSHIP |
+			    ICSSG_FDB_ENTRY_P2_MEMBERSHIP);
+	}
+
 	icssg_fdb_setup(emac, &fdb_cmd, addr, fid, add ? ICSS_CMD_ADD_FDB : ICSS_CMD_DEL_FDB);
 
 	fid_c2 |= ICSSG_FDB_ENTRY_VALID;

base-commit: a225f8c20712713406ae47024b8df42deacddd4a
-- 
2.34.1


