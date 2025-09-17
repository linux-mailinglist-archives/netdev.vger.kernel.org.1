Return-Path: <netdev+bounces-224092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F42B80A10
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3E267A41A8
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888CA33AE82;
	Wed, 17 Sep 2025 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="duATcIlV"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B53C30C0F9;
	Wed, 17 Sep 2025 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123432; cv=fail; b=NGwAO8rEsu+yHjvQ/XfpmlS7Thv2dS78sCsbENosnSsi9dnwTejOb0NSVSSM3Mrxe6Tg0Gz16BZb1QhtBVN+t7HqhVIjuBf6xlh6m/bV7SOZSqHYjWMM1no720LvtYpT/QZBgc0ZHweKMQvN9tKIptSGBfvucN81AhZZjgVTcXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123432; c=relaxed/simple;
	bh=5zlOyseGY2a12mIH0pp7n82/QDRPL8mVnq+tTRpVY5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=n8nf4X4F7fuo0YRG6b0Rv0fqexqVHrsUiXx3iIzHBlxdFUurPquGf1gOW7Q8dltOGVaYBAGB+2P1OC0o+B9gtkq4mms9VV3JefJv2awELieuZxsA4bmR8yZmU9IY84qc5O+ZMchwpEw92gjN+kcyfGlZg52Ci13WhfftbLPSaJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=duATcIlV; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HFVOdl020429;
	Wed, 17 Sep 2025 17:36:50 +0200
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11012071.outbound.protection.outlook.com [52.101.66.71])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 497fxhmf6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 17:36:50 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRhqa7TMH7TzDQg8fh9wvONEbbjPUvZ6u2Wj8dg863cRL/3MC/2HWY6zIlVIehgUr6a5ybfKTdOVfVtzHKBqPIKWfZvjK3hMKq88Z3WtGZwfLz9gOzhhEwNRrPJNwBTiCNpKVFXfsWCxJf8BNCC7jhpgzZe3xiMsl9XM02VF7lXIo2zd1zcYPoan4HxYuS/WOQnHkwIxVzgHc6bFcPq7WuFkRNTrRAXvqqf0D3BJEzVt+bt5gLUulrKzMdrFQ88W/4llpKXGjXKjdeVOTaXwuFXNxuTXFFB+hsnbouFnpFZ96sqpkoY+MJYLu3d3qnin8JGkLCwsXrj3DHm3Lg0eYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPGrfqg8UaxEktjEHfSecm4NyduW08Yu5c4nY2o6pg8=;
 b=S5py3lkEN0U0+N0C6JVhk1/0fWOlCM7nIfmUZL60+P9RrD2hvm+CmhGZ95FMKSaOL0kwBojb5cW7HHbt9Ko7t/Df7X77KxAv/BaEWCNL6+k4Zoy4y1UEJwMlzH3vAJxmnlq8HTJXyheihNOtgRiV6DakjlSyUDIc77bjLraSxs1xGoxrvhce4NHxp6l4arN0DNbzTL+uHc14qoFmb8J04My+mljgXB2IaLXhLHKAO3WyPj3b0aLDLJttIm4Ib9zeK9dw08oz8YR6GUBjPxTB/XHDhPihkSntxm3eER+oirDAu64/U+qZ8DF1JI4+hJ6kN/AV03asmLfgEysvS8GInw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=google.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPGrfqg8UaxEktjEHfSecm4NyduW08Yu5c4nY2o6pg8=;
 b=duATcIlVCaSV9LGDTgMveGjab6bups4M3+BOsR6iDZq6xGGAaZ0fMxyA6pXNJ2YgKowkovLEfeGjS24YJFQMiNZSAp9hvI/i07UNV730BprBuTm60926ApFP1W7wF80Vc5Y3TksV+ycIIxpWxkBvY2VzRIFfyvhzJ0IjCOclR/4E4qwBtlk11oJrfdQG5i/kszFDGvbVh/2opfVCqQEuWScUOk244TRnbFCjAe3SYX9U84ObzOr0nD4SnKy3E49Lsz4p6QdwHpOYvu12A7Iovh6wMRe2BtvGCMf5uHbBREE1j9cH5w+txqo6LYaRgiZzo8Rw//47A5i2zXKx1ZO60Q==
Received: from DB9PR01CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::9) by DU0PR10MB6851.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:47e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 15:36:46 +0000
Received: from DB3PEPF0000885A.eurprd02.prod.outlook.com
 (2603:10a6:10:1d8:cafe::8f) by DB9PR01CA0004.outlook.office365.com
 (2603:10a6:10:1d8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 15:36:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 DB3PEPF0000885A.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 15:36:45 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 17 Sep
 2025 17:29:41 +0200
Received: from localhost (10.48.87.141) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 17 Sep
 2025 17:36:44 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Wed, 17 Sep 2025 17:36:39 +0200
Subject: [PATCH net-next v2 4/4] arm: dts: st: activate ETH1 WoL from PHY
 on stm32mp135f-dk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250917-wol-smsc-phy-v2-4-105f5eb89b7f@foss.st.com>
References: <20250917-wol-smsc-phy-v2-0-105f5eb89b7f@foss.st.com>
In-Reply-To: <20250917-wol-smsc-phy-v2-0-105f5eb89b7f@foss.st.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "Heiner
 Kallweit" <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "Simon Horman" <horms@kernel.org>,
        Tristram Ha <Tristram.Ha@microchip.com>,
        "Florian Fainelli" <florian.fainelli@broadcom.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885A:EE_|DU0PR10MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: 39dcffb9-3aa9-4a91-14b0-08ddf6000219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzIxeTk2TkhRbmpmaldMT3VtbERSQkVNdFdjOEVnSVowVWMrcHhod2FjMzFY?=
 =?utf-8?B?ZnFtNEhXTTViQ0xzZTJKYlpEV20rMFFlRFZrclN3MDJJK2M0aldLYW1IMDNr?=
 =?utf-8?B?OGYrWHBta0F5eUgybWRZZjZJbVd2OVFFbUZTYVhOSFZySUJjc0VoVEVtd2Fz?=
 =?utf-8?B?cjZWcHM1cU5CeE9jeTVxR3VjMVVTYVNRK2F5cTlTK3IrRWwzMHJWcWwySVNQ?=
 =?utf-8?B?WDVBZFZxYll3aDEyZkdvUlNsYU5rWnVzWkpwZm81THB0K3U0WW1ySzJBRUZJ?=
 =?utf-8?B?UkVZbDduL2txeXl2ckN1N0RxcjZDa3NnOVg5dktRMkM0bXk0NHpFY3BjVDY3?=
 =?utf-8?B?azQwV3g4SzViQVVqL2xUcTArQTZqTStiRi9ISVlQODdMdWdiSmhhU1RpWGxR?=
 =?utf-8?B?QU9nMjRpNmFvZzhzcDRHYUxlUm1sbFFPZ0hHVW9qS3FNTXliYUtqTFVaQnlK?=
 =?utf-8?B?RGpyVndxWjVrQ1RsVkhnMERabUZXYjE5cyszQzVub2xGMWtta2xqSkV5OVBX?=
 =?utf-8?B?KysyOWtoeEtWSVNCQmdFR015T2dEVVZQYnNVeFQ2Yll2b2dMelQzS1p3UlVm?=
 =?utf-8?B?dFBSZnA0bHQzRlo1NnV0ZjFsT2JzV3JEYW00VEtpVFpLcUEwbnJ4Q3piQ0Q1?=
 =?utf-8?B?N0QyVXBIZTZMY25GcWFHSVdad3AydHZJbXV5ZXVZdWpvalVtRjhSK3ZXQ3dQ?=
 =?utf-8?B?Qm8xS1hNNTNQano0Qk1IS2c3a1dzQ1ZLWm9XK0E4bStJdUJCSFh3dEh4Mzly?=
 =?utf-8?B?b3NhNDB6Q1poWWxXTno2MlpEZ1B0UDFmTEJIZ04rWkJVMlNFeUxmZ2xHRUY3?=
 =?utf-8?B?OWxLTTFXWjVxWS93YnZ0bFdQbTQyTnpUdGt6dTdISGYwQnMyNFF6ZmxNbEpw?=
 =?utf-8?B?WTEzYkZTcWZsSi9RRU44S3M5eWZWb0dzK0c5aUNMa0VuM1FYYXJ2dDlab3Mz?=
 =?utf-8?B?K1ZkejJzSzJFOGoxS2Jtb0tpMnpWaVcybHRCSmNKNm9DaWtYUkdBKzh2UFlq?=
 =?utf-8?B?ZUxMOC9jdnhPNUE3Z25Fa3o1dGVDTEk4Q0E5NkJqTFRGM2sybTNveTlsS0F1?=
 =?utf-8?B?STlSMzVkRG4yZDEyaXlSQkhOUEg0NmYyck92RlJRUUgzM2d0Vzl1QmpvNXZ1?=
 =?utf-8?B?QlhRejZRWXVWa1Q1b09Oa2lDR3BjZDZOY2tOTXdoeVpBSzQ0aXVpL3NhMnlj?=
 =?utf-8?B?NVR5M3dmeThtRFZTOE91c3ptUTRGckRURHJqczg5SDV0K2NTZm50UUJZZ2VU?=
 =?utf-8?B?cndmUG80aWYyZ0srWGNQQW1mK3paVEtIOXRjWnZCT1pIK2puTVRlZm8xTm5y?=
 =?utf-8?B?OElNSUppdVVsOC9MK0wzd3NhbExVSEhNQS9yMDZGRkphN0pvSWNRU0t0RkxT?=
 =?utf-8?B?TkQwNHFNZW1VNFFyQlFvVVNocGNlMUxFcE5KNnRVM29BbG1aMjBQQVI5dTdI?=
 =?utf-8?B?Vm12WmlMQkx4eVM4RzBNTGlCTkpBQWJOalg5NHNtWWRSOW9lOStuSU1LM25S?=
 =?utf-8?B?c3kwaEZCQmF3Wmk1blkxMDZycjUxUWhZTEc4Q1d3R1Nua0hKSHFaTHJmSTQ1?=
 =?utf-8?B?ZDRnVWRabmhmS0JvTExhQ2lxNmNjUUJoM0JJUFVpWnBJVDFhNHozakdwYWpl?=
 =?utf-8?B?NG1zb0dWYU8yOEgzQ0pyejFrZ2srQk52NHl0YzVQQzB4WUkxMXpISThUb3hD?=
 =?utf-8?B?bTlUWUc3WW90Q3VvUDl1QkRNcWxZWGx1eFg5aERwS25LNzl5aXRGYkZDbzlq?=
 =?utf-8?B?KzdvWUNOZm5Kck82M294b3FvalMreFpVSndza3ZpRHl5V2puOU5jaCtzSjR4?=
 =?utf-8?B?cXhtOVZjVDJ6clgxZnRmazBSQzFHeHpyaTBxVXJucHBiVmN6VWhQYjdGVFJ0?=
 =?utf-8?B?SU0vemNOUUNuSXVMVS85NG9CS25zWTlaWXFvbzhzYzJyQUloS1dzTG1qYzZP?=
 =?utf-8?B?SE45OVljaThPU0RCMGxTVGtScm82aFJNRG56dWhtYXJJUTJlMnR1R0VFVHBV?=
 =?utf-8?B?SkV5aTlqVXhSNnpHWTgrVDhnczJxdEJHUFFuaTIrT2MyS3hUQ1Y0MEtGWlNV?=
 =?utf-8?B?cWxpNHM0VkFCT2p4MXdaTXM4bEdreGszOVhWdz09?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.44;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 15:36:45.1182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39dcffb9-3aa9-4a91-14b0-08ddf6000219
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.44];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6851
X-Authority-Analysis: v=2.4 cv=K9MiHzWI c=1 sm=1 tr=0 ts=68cad592 cx=c_pps a=zZ2aAuEz6FT5R9GdLdvfGA==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=ei1tl_lDKmQA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=8b9GpE9nAAAA:8 a=O-g4ZvEbhNzUwkRE0BQA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX8YOpeV5IWieT 4Xg44cq82HzilE2B7yj7XkDRwBlkzXv6ry887ayTEq9w4OVXtfNHK2SyABYQCQWNOyK2yTnR+QH 5NjXJtvxGsXRYKyMy6UXfPGF7st339YayUJ4f+V6wb8DywvxriY2x7+KnfH1QvULA7VUaa3Vvkz
 pcstEkASB62jx7Iz+Cg8drU85RKKOP4vGINleC8w4ieb7OLtN9PVnOZQ1+ZDdPNhFa1OL3zFt44 U4oGggNjLXyBwPqXQ1f0CxtXolhaf9qR+BDsa9v7GJBqTIQ/MLQ8tHqCi8XrDSSJVdQJBEdV/5h Chf7CrpNPcsyVrsX0hwIlKqKsOT5jmpL9XLUzD9um3QUHXbFbTkOOWOQ0OnR+VF4bmvSxLg1yul fMSEYsSK
X-Proofpoint-ORIG-GUID: il6zdilDNycZvZFX5EAh65VIGxkAWGGr
X-Proofpoint-GUID: il6zdilDNycZvZFX5EAh65VIGxkAWGGr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

On this board, the ETH1 supports WoL from PHY. Add the "st,phy-wol"
property to support it.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp135f-dk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/st/stm32mp135f-dk.dts b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
index 9764a6bfa5b428c8524a5902c10b7807dda46b3d..d746424b039013759bfbcce5193a701ff775e715 100644
--- a/arch/arm/boot/dts/st/stm32mp135f-dk.dts
+++ b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
@@ -193,6 +193,7 @@ &ethernet1 {
 	pinctrl-names = "default", "sleep";
 	phy-mode = "rmii";
 	phy-handle = <&phy0_eth1>;
+	st,phy-wol;
 
 	mdio {
 		#address-cells = <1>;

-- 
2.35.3


