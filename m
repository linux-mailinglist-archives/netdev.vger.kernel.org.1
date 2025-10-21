Return-Path: <netdev+bounces-231106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28C9BF523A
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 10:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B7E3B9572
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 08:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B12D28D83F;
	Tue, 21 Oct 2025 08:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="A/knU53z"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2005B22FDFF;
	Tue, 21 Oct 2025 08:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761033817; cv=fail; b=Z5ZjHWNBN7M6gIZaTZCCD1/9sk9pA9buBpcRXJU1g8VbRHwGt+c/SY3ptkUQpmTyW+YT2e0qHA4uxxNcWb4fPqtMjKcHPizxxh8zvnOvcAdUDch3ra5CR2+6XLu0buKg/wiIE9UaV3LtxrTJlgbCpMv82YTIQdDsGvMWmfy17jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761033817; c=relaxed/simple;
	bh=LJekVO2HBtbNOBd4W5iw9+UmhpuM5SB3/4a99TeJZkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lnqmTbeNuqm/mLDkzGpjxWau5podhOcj+IZDOSQKCW+sVX5ozo5Q66GeCDZICvIw8975m9T4+HsDNGlU4tBbZ6+GuBSYB/afuv+pUoPqbrOiJyn5grKc14rHDaqck3y9567VCXMjU4RAk20b9OQoxzFfXEiE15Ki4yyxnu5rX04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=A/knU53z; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L7Xdmp028041;
	Tue, 21 Oct 2025 10:02:52 +0200
Received: from as8pr04cu009.outbound.protection.outlook.com (mail-westeuropeazon11011008.outbound.protection.outlook.com [52.101.70.8])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 49wqj2b2cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 10:02:52 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLdCIossLlvNm7U/xItP8p0Tp4TfkmI/vL3HrNLzSDPbQlVZoM1pCTzrORS4Rh9+JDodsLbiv38WaX0fGdxHIcB+bqc7bgmv7EwRRQi60xn2IGSX0vjNwHFjgHBT2Ae85+fUhQDPzSnikoxs36QaZuBJK7NCN4wsbFkuSccG7Y36Opnbqj/NGbjWRlGm+lsNdOhPRJujBvo7LpqCwD7E5IA8mS8pJ0HCBH4gYk1uuBmmholhEsDqi+ZRIfLID+3+8uiuH2T542oMfeLRoHgIugoyXT57FNTV5zxnIJncSJdJ97wBS5HK91/shMRLcSVbWf/bQMqvrFHl6LX5gXrRwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DSfee/GxeSil2o+FOSiXQCszemBw73Yz6dkeZQP4nw=;
 b=O0ch/ayVfyn27S4A08S4CZAJl6sVrCwJ8MtqZNAwTkGG6VlW41tVGLSJRmVTktVaXYJPuGbmCFvJcjp2hf8PCgjZ2vER0g46NRhyKoI5pw0vZntj5yLcAwoVGwyxgTY32WH81u7WKZfUk6ZENhjLIaGekFvTZrJtjJMtJ94BoyIRwfhfVJloXZcAe9QXATc9Dxnbr1l5cF69jg1N0ED2dje3bv9m7dlxWyeH5FQa91QawKTxYlcZRKRXOJBykjiwq4ZDUQtGBoTMg4L/sLqbyo+ThtU3wuLI6WEx1WiuOz3NsVVWJAulqsKkMz6O1RoqMDQ5iDYj4WNgq2zwA6vRaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DSfee/GxeSil2o+FOSiXQCszemBw73Yz6dkeZQP4nw=;
 b=A/knU53zsIQXEGa+cVU+nNrA4mWIhpIuv26W92Vld/FoU3E0tID+XSIWR33TQeUyB0kCRDLeL0Mls80etriR8b3uU6le6bHIqw/z6iM3J0XBsj/szm5fNaWnzr6FGJffSYPpy6LyK4NQGBSzNNjxvVOaK3mBKMlOFcHVh8Dp5cWtRiG7n3gylbSEEXnvQbAH/f2rq+iXdUkjsmYOQkskBCa3mAjNTjNGyYaAeZieuH5IjgJ9lnpx/aCUAT0YSn/J7PmkZagrHo7aWaPGz2SPCyt/nmpG0PQ5eFl0QPUi97W4UFkBQap+1jYezfTMJse/7zBHujAk0FeUbZP1zD/kPQ==
Received: from DU2PR04CA0288.eurprd04.prod.outlook.com (2603:10a6:10:28c::23)
 by DB9PR10MB5691.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 08:02:45 +0000
Received: from DU2PEPF00028D08.eurprd03.prod.outlook.com
 (2603:10a6:10:28c:cafe::10) by DU2PR04CA0288.outlook.office365.com
 (2603:10a6:10:28c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Tue,
 21 Oct 2025 08:02:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 DU2PEPF00028D08.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 08:02:44 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 21 Oct
 2025 09:55:44 +0200
Received: from [10.48.87.185] (10.48.87.185) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 21 Oct
 2025 10:02:42 +0200
Message-ID: <e32011c7-1471-489f-8de2-1f7ac2c868b3@foss.st.com>
Date: Tue, 21 Oct 2025 10:02:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/6] net: add phylink managed WoL and convert
 stmmac
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        "David
 S. Miller" <davem@davemloft.net>, <devicetree@vger.kernel.org>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>,
        "Paolo
 Abeni" <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Simon Horman
	<horms@kernel.org>,
        Tristram Ha <Tristram.Ha@microchip.com>
References: <aPIwqo9mCEOb7ZQu@shell.armlinux.org.uk>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <aPIwqo9mCEOb7ZQu@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D08:EE_|DB9PR10MB5691:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d9dc1a6-2ee8-4f8b-e9c7-08de10783793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjBYejNZejlhZEZ3WWpYTGVMSHJ0MW40Q2lobHlycEJYS2FHMFhoNHFoaHli?=
 =?utf-8?B?bHp0cmhEdnpUdzJpSTF1ZEZoblFocG9oRWpVRHZjS3diUm5YZEx0TGljMDg2?=
 =?utf-8?B?Z0laM2FtZjNyWTZhQ0lXRUlSMGh0RzdkSVhuQWtQNlB0UkYrOUVuMjQxa3VI?=
 =?utf-8?B?dHM4L2xBaWtqeVRWTG9xNDg5dGVtSDJ0d3ZHODdtWjJEZlRoWnlnbjB3Z0JX?=
 =?utf-8?B?VHA3dlp3SVlLdjFHVVB4SGZTcEJSOEJFSjZWTUpQZ0ZacmFmT2lkbHlwOThU?=
 =?utf-8?B?c1YxYTFKN3RYazQ3dDVhTU4yNVBsS21KMHdxakVqQ01CdXpQS0FiaC83bFRu?=
 =?utf-8?B?TEdIMDd2RncvU3piWE9nWWFrM3NKS1pXMGVXYTdHeXpEd0s4THVnd1IybnZV?=
 =?utf-8?B?am9GM1ViWGdJaWpRb1pSVEdXMWR2Rkl2SnZrM1N1akllaGx1N0xnMElLeHZN?=
 =?utf-8?B?OElTWDVVOHhodEJqY29JdzBrdGJ4VjBjL0NneDhHeFdZSTloK2p4cy8vVkxI?=
 =?utf-8?B?dlV3QUsxNWhiSVlKc3Y4Y1NmR1czd2xOcUJmV0ZJTUVLRkVNWFExQTRHeHhv?=
 =?utf-8?B?ZUFHWWdURk5jUHZDeUVpQlY5TFVVcVN0S2VRcG1XQm02aHY3TFo1V1RnVDRr?=
 =?utf-8?B?K0FITXE3MU94WFRic1pSOUtRKzI4OGVhTTNRTlB0K3hvaTZUcmhvM09oSkRC?=
 =?utf-8?B?VWdROU9DVDlPci9vb3lITlpWSFRYd2RoNWdja2tZd1pTOWtLTDZrOVFWRVZK?=
 =?utf-8?B?N0JQN0dDeGlHREQwMVI0UU5mcDBaYkpFblFjYlpYVDZzUnBNQmtuUHl2eXE0?=
 =?utf-8?B?eUt1QjJhNFJzNGxHekszR0I5L3pUMFczRmplTzIrSlc3SWprdDVWaWxDa2N6?=
 =?utf-8?B?V1czOGlreGJGc21jbW5jSlR2SVB2RG92N0ZBaFh1ZjRrYXFXbzQ0RHRQcW1u?=
 =?utf-8?B?bkR1dW5mVEpWM2g0SjZxSmc3b1VPQjBabHhpWTkwRHpsMGFqRTloN1dPd2xF?=
 =?utf-8?B?ZVFIZUlVdHpEUWprME15ZENVbE83UjVxNnVpQ0RDTk1WVWxjWU5ZODJLYk1i?=
 =?utf-8?B?aDk1dGwyUlFMK2ZmcnBZVUdvUDNXNjJ4Q2pNdnI0bnVKNGVzRG1xZ2RoRWZI?=
 =?utf-8?B?dlNLMHoxZmZ2N29YQUR2RWhxbC93K0lLNERYNkZVN0lBcU5CU21neGpoaWVC?=
 =?utf-8?B?VGtZT1lmY05WNTRacVEvNmQrM1NLcElYblFaWFRZNEx1clZlY0g5aEFNeEZN?=
 =?utf-8?B?ZURJYmtzc3F0c21xM1k1OXljdTI3TVB2Tm9VWlViMUxmbUUvQkRUMmcxSnY4?=
 =?utf-8?B?TEI2eFl0UCtSTmM3V0x5aDZBTDJNalpCeE5aazM0WDllWFlDUDlCeEFrOC8v?=
 =?utf-8?B?elpyMjJFWDVlZGxSOFYwbm8vaThibFhJOU9TLzZpUzJzQm5ZMGRBYkpZaEdP?=
 =?utf-8?B?dHJtRzZSZjB1UDZvQXRPSmxrV3BUR1RDYnlEa3dtNDRFOHZ5T0x4VWpHYzRH?=
 =?utf-8?B?SnNOSzYyZ1VQa1B5MTNkbU5tVHZ0K0VMYlByc01wK2tFN3cxQTgxME1nZnor?=
 =?utf-8?B?bUhtRjM5QWRQVThzM1NLTGVtWitoS1FrTFc5aklHQUNRTWl4cXkwa3pwVGZK?=
 =?utf-8?B?UlU5QWJaN2FiSENRdlAyRUtQaW1nVXFHenpYbXkzUHVjaGFRYXc4UENPdXRJ?=
 =?utf-8?B?cHpYUFE3SVg1N3FGWXFmanBHYTR3Zmhpak52akpwekVKUzVEeUtkTjYybGxy?=
 =?utf-8?B?VTc0c0NSZ0JVcGF4ZmxudEpiYTVCMHBGa1hPenk5Uld5MFJLRWU1M0tqVDkz?=
 =?utf-8?B?VDFPY085WWtyMDJCZXU1c2U3T1JCRGE1MEFzbjBhekdCL3MrVXJ5cUJRZXQx?=
 =?utf-8?B?RmwrV3pYdHdqM1c3RmJaeStOYWVBQlJQT2g2TGs2ZXB6NFNnNGFHYmFKUmpZ?=
 =?utf-8?B?dXh4bjdaMHJwRGptMEtIU29WOXBMdHJPd1V1VjU4d0ZxVW9tdGE3amVTc2RI?=
 =?utf-8?B?OEVJZ0ZzZXRhcERjbDdROXc0V29KcFN6T2ZTMEd3SUZJRytITzkwSnVNNkdi?=
 =?utf-8?B?ZkFlZG84cWxEYXJaeFV2ZndiYUg5c0U1bmY0NzJ4VEVIWnRxd1p0N2tmU2Nz?=
 =?utf-8?Q?DRwA=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.44;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 08:02:44.6620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9dc1a6-2ee8-4f8b-e9c7-08de10783793
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.44];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D08.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5691
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDEyNyBTYWx0ZWRfX1tmOtPQ3dhsG
 U4OqT4FgZ7TBYsgwdXGPeZiHp3+izDwd9kkLlfytwwTnmWcHf3nvACTitYnL/jY8seO5lmuARB+
 ZFP+RG2ez58ECjsNOZc/PRy/L//+7NUJ1hG3FpZkSeuQUuqShiWeWynFRYtU2+/T81sRRvgRVAD
 WMCq/OmY/PXXOIMPEelawGGqSV3Ur6mNezcbC52dCeZsWJ5N88dwky3CQ1FNagPPQ5thGalVWJo
 hkNG+BKfEN00wG41O4lScryRCje71BoCCR5cbPIK9h12kvMDEVltoolIgZ2wUCX11IdiMXNTV7t
 qS7ovMCzLEkTWonzU2YI81We+hd0vYkcAa9biqrW4u20ByIV2pLzwUl9gDk5Of7ltI/dd9pMOLA
 47m9DmKEiH2QSrfCzYnAJx66IIXRaw==
X-Proofpoint-ORIG-GUID: d-5-NfrZHZCPpKBGCFNcIF5zZEU4HMgf
X-Authority-Analysis: v=2.4 cv=Gs9PO01C c=1 sm=1 tr=0 ts=68f73e2c cx=c_pps
 a=NTleJMBLGjSDdH8hSBVCOw==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Wpbxt3t0qq0A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=WV3FBPZkQZjz-neYx18A:9 a=QEXdDO2ut3YA:10
 a=HhbK4dLum7pmb74im6QT:22 a=nl4s5V0KI7Kw-pW0DWrs:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=bWyr8ysk75zN3GCy5bjg:22
X-Proofpoint-GUID: d-5-NfrZHZCPpKBGCFNcIF5zZEU4HMgf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 adultscore=0 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510200127



On 10/17/25 14:03, Russell King (Oracle) wrote:
> Hi,
> 
> This series is implementing the thoughts of Andrew, Florian and myself
> to improve the quality of Wake-on-Lan (WoL) implementations.
> 
> This changes nothing for MAC drivers that do not wish to participate in
> this, but if they do, then they gain the benefit of phylink configuring
> WoL at the point closest to the media as possible.
> 
> We first need to solve the problem that the multitude of PHY drivers
> report their device supports WoL, but are not capable of waking the
> system. Correcting this is fundamental to choosing where WoL should be
> enabled - a mis-reported WoL support can render WoL completely
> ineffective.
> 
> The only PHY drivers which uses the driver model's wakeup support is
> drivers/net/phy/broadcom.c, and until recently, realtek. This means
> we have the opportunity for PHY drivers to be _correctly_ converted
> to use this method of signalling wake-up capability only when they can
> actually wake the system, and thus providing a way for phylink to
> know whether to use PHY-based WoL at all.
> 
> However, a PHY driver not implementing that logic doesn't become a
> blocker to MACs wanting to convert. In full, the logic is:
> 
> - phylink supports a flag, wol_phy_legacy, which forces phylink to use
>    the PHY-based WoL even if the MDIO device is not marked as wake-up
>    capable.
> 
> - when wol_phy_legacy is not set, we check whether the PHY MDIO device
>    is wake-up capable. If it is, we offer the WoL request to the PHY.
> 
> - if neither wol_phy_legacy is set, or the PHY is not wake-up capable,
>    we do not offer the WoL request to the PHY.
> 
> In both cases, after setting any PHY based WoL, we remove the options
> that the PHY now reports are enabled from the options mask, and offer
> these (if any) to the MAC. The mac will get a "mac_set_wol()" method
> call when any settings change.
> 
> Phylink mainatains the WoL state for the MAC, so there's no need for
> a "mac_get_wol()" method. There may be the need to set the initial
> state but this is not supported at present.
> 
> I've also added support for doing the PHY speed-up/speed-down at
> suspend/resume time depending on the WoL state, which takes another
> issue from the MAC authors.
> 
> Lastly, with phylink now having the full picture for WoL, the
> "mac_wol" argument for phylink_suspend() becomes redundant, and for
> MAC drivers that implement mac_set_wol(), the value passed becomes
> irrelevant.
> 

Hello Russell,

Currently, I don't have the bandwidth to work on that subject.
It should be better in November.

I manipulated a bit this patchset when it was in the RFC state and I
remember having issues when suspending the platform with the PHY in
interrupt mode.
There was a PHY state change that generated an interrupt while the
suspend sequence was started leading to an immediate wakeup. This state
change occurs before the PHY driver ops are called. Therefore, I had
no chance of masking the non-WOL interrupts. I'm sorry for being
quite vague but I don't have the setup anymore.

Gatien

> Changes since RFC:
> - patch 3: fix location of phylink_xxx_supports_wol() helpers
> - patch 3: handle sopass for WAKE_MAGICSECURE only when the MAC is
>    handling magic secure.
> 
>   drivers/net/ethernet/stmicro/stmmac/stmmac.h       | 11 +--
>   .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   | 31 +-------
>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 45 +++++++----
>   .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |  4 +-
>   drivers/net/phy/phy_device.c                       | 14 +++-
>   drivers/net/phy/phylink.c                          | 92 +++++++++++++++++++++-
>   include/linux/phy.h                                | 21 +++++
>   include/linux/phylink.h                            | 28 +++++++
>   8 files changed, 182 insertions(+), 64 deletions(-)
> 


