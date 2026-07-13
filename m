Return-Path: <netdev+bounces-307012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mGRdECN+VGpvmgMAu9opvQ
	(envelope-from <netdev+bounces-307012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 07:56:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97036747615
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 07:56:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ti.com header.s=proofpoint-05-2026 header.b=PSdMY7O3;
	dkim=pass header.d=ti.com header.s=selector1 header.b=j1HkSZhl;
	dmarc=pass (policy=quarantine) header.from=ti.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307012-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307012-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD3833031008
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 05:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914F2361DB1;
	Mon, 13 Jul 2026 05:54:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85EC356749;
	Mon, 13 Jul 2026 05:54:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783922099; cv=fail; b=EXUDz/IBAIRsxmvp5ifRqq3kK1u66Z9laKuxPJVDKz8ikw54aDTs5GVhl9qQ2cV0Hg2LC+RD23Z5jC1toWW5wtf0CZl+rWn1K941cnyIVO91aa6NhdiaWR4FTpHiygR3/8jaju0XYSfBjzrbsA0zVjSDtnd2kl519+iBnZXKMVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783922099; c=relaxed/simple;
	bh=fXY/FGlY9iYNyNA/wgkwd7n7wmVBQCHe32OGFnDWAg0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=crmmCUqjpev6mORQiSsmOLUDf2Ba27yNhIHfsmnm7f4OAnnZq7Ddh/oCrJ1p3SlHmSSCJFU5lRYNbY4lnFkIhonr3RuOse58z736S2fjNq1rT7Ha79ylu+z82FZbFnpzR7SjPybWgHvhHqnnGOrHpKRfKkNxWVLo5HTut8xpr7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=PSdMY7O3; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=j1HkSZhl; arc=fail smtp.client-ip=148.163.150.75
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66D3AHGR2430030;
	Mon, 13 Jul 2026 00:54:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=W6w+hPmhhS/RYZ7j75EZs7UsyuxXgUiWWHMWO8Pg5
	pY=; b=PSdMY7O3WgxckH6T0YtBLAPc/U1CEbSuobnD7bgDVXEXLnvme8Ku4F0Fl
	mxQUKf4Up7dDNMsxMD5OqpJFaY+z7ug4W1N9KMRRBcXYxZ++iSWVJbOeRpzoNDts
	OOcaZ1E48E8YGnkzM9pESb2tz5ant11YY/SRxvvhCKLEg2h40XA6whbFPRNYpROD
	kOLta1XlFuzJYK9C4ihCQCwYWiRFa10t64xqTS2UelxOsh75PdbbOwZ7coUNOOGk
	e+9GtbU2xKLvUBU4aHyFnf1OjkTu2PdP7G/WL+tdfjXqkEgUburgLTMMttxAxHAr
	O3g76gJEXqbyguvJP5ASavOi4LFvQ==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
	by m0380145.ppops.net (PPS) with ESMTPS id 4fc6unbxsy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 00:54:32 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxCdLobeNCTJOclZNrhe2rbuMCMqI8Jf3K2p+xZKI9STBDpUxXiPNITORn6R0bQvSOiGzFbGJaZ7yEIrepo2zMeS6BVC/RG6GtdycCtDC4s/1n80kfNtSFgYjcs1nuI0zFFpZ5fIB8tdNGvjaGBo+yhAAYMGxVU8njmvQbF7fKpMqEFk1dOwAijFxTcA/eAP6qZ8MTW5VgfScCgCqHgOlx1jXS/xW4F5oeo5QxMZJoUQQk/4GuX3gK2R2qyceNEjYXZhhRypk+Ce1gvLUhe3I+y7yVkiHEU/Ih99eUAktOk/pdRaBJd56PUD+ywUK1rgOi12l3w4cJT8fiWCBuhQqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6w+hPmhhS/RYZ7j75EZs7UsyuxXgUiWWHMWO8Pg5pY=;
 b=io6hrUsQYJX3KEYpMC97uJ6TKTKxwAY9K5AntcICusL9vE2Jm5wg3AhRqYBYATWOIA2z5Eif+tseA6qd9CAKigfbRcmQNbW+NLbTb1+NrIYZTbogWUFbwZY5xqg5P96ZHuG1ZF2lcpaGHW2CAJeTFFRil9Dcwu+24B4953HZMmFkaBfMGulieOraWbWinl5vwO17rNe/v2djZ/BW0L5aAVni/NMNinvvttgudNg37scn45nv2B7TJyETPOqC8rRun3YSaIAEzaJaHsYxvd047ytIHChlWHXW70Dw2AzgLKIrNuq8WSC6BqJ5/hJPgEhioFUmGHaoWGEQsH81FhZKpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6w+hPmhhS/RYZ7j75EZs7UsyuxXgUiWWHMWO8Pg5pY=;
 b=j1HkSZhlJvpfFooEq1V7h8MUuypGnEfFu60G3TCboJk+3qvbJwNpqGznMEr5KE83eC+nHr39cuSaADX5+QBY+ZTWmKP2t7Lm5PrxuGIGUt6PckHJUI13Wc6Ne1jCq3m/CuMhFM1azBYy1UDs2UTnNuhJTHGioT2o7t7QaJ7Ibnc=
Received: from CH0P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::9)
 by SN7PR10MB7103.namprd10.prod.outlook.com (2603:10b6:806:32b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 05:54:29 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::a9) by CH0P223CA0021.outlook.office365.com
 (2603:10b6:610:116::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 05:54:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 05:54:28 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 13 Jul
 2026 00:54:27 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 13 Jul
 2026 00:54:27 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 13 Jul 2026 00:54:27 -0500
Received: from [172.24.231.152] (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66D5sNrM809166;
	Mon, 13 Jul 2026 00:54:24 -0500
Message-ID: <3d02c4e9-a271-4080-a54b-8ba4d7a86622@ti.com>
Date: Mon, 13 Jul 2026 11:24:22 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix link-local addresses being
 forwarded out of slave ports
From: MD Danish Anwar <danishanwar@ti.com>
To: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Simon Horman <horms@kernel.org>, "Meghana
 Malladi" <m-malladi@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20260701112535.4027920-1-danishanwar@ti.com>
 <71a1bacf-c54f-45b0-80df-7175261cf2ac@redhat.com>
 <5c9fc598-9449-49aa-aa4b-2afc247bc761@ti.com>
Content-Language: en-US
In-Reply-To: <5c9fc598-9449-49aa-aa4b-2afc247bc761@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SN7PR10MB7103:EE_
X-MS-Office365-Filtering-Correlation-Id: cb337d19-aa7a-441e-297a-08dee0a333b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|3023799007|6133799003|18002099003|22082099003|56012099006|4143699003|13003099007;
X-Microsoft-Antispam-Message-Info:
	1PCs8YFRcerCmXyh58YJloDA0b6J4+wQWZZebroK3iN1vcdkP8Dk24KjE3QM+IJ9E8ogF+xX70N/BQlP++/cr4dkOaTNsiuj3a0Iy+xtKMbPWHTne80VEUtBMYB99DHcRs1gGRfCPsrs6EgjvBVpqkRckEE91gGO6CFQdSAWmpezwkvtoKsnMfGfOdCik2Y2K6eXBsJXck0XgEFoSI9fY5M1V0IfQgoRVXEeEmj4gS8RVgtEu2dG1KxMvnXDn1p65OQSAkmy3BWvZhphZR/f8XCO3jXAE3bpAhQkkAPDfLigxWbKMAKULiZjFfmVhYa3KK7Ns+veGBLdA47voNLXV4Wqj+fcsmWhQ5Wfc30DFXfErIbP9FcR9a5azRuxSKRO8WVmSby6z4WijdJUVAHNmkcgGMwHmIAEpdul9Ysxbf8PDwF2FPZFeZW/Cf0Vu8r/0wKlsfUklCdvDHXsds7Bv1gJiWh5Jnk66OPtOGiDapFZKrJa99tpCgUirshIYDeoF6WAbI+B/xZWOvjZO37wmZwRS76Je2ZEm7rhunfSqrY76tS5Ckf+4kmKtHeoQLonqkd+BVtiM2Rn1RYyeUueDiPq1LY6y+vcBAX70Zops7uI9mtKcO98a8ql22/6K2bbKfVmUJXyi9aznJ1SJkYuxQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	z0jzVHTXLTejShDH5L7803/mezE6oM/SOcGBz01RqDe8ftvXOQcNNRs2XUnmfGse6Qh2M1WMzEKjT8OmHPegqLfgUeowiYG7wH2idXtVg1zpkGQPKWGVUbPbCaOpz/keSIjXvIbW4cyu+f2Rnho9vQpJuPRMYzCHE5C8EJkTLB9DLzAr14jfO6xCU/Hfe9jOgob2P+DQHjsAuWLOwpqUWp0XF2OeDfamT80x/aXEdrCcCMFgY+yXhUPqrdLlsYKarEKfgvGsJSd9P01V33OhrNaYjxLECRqytx3d7RDrDVgIvDZKGC/A2BHN0mChcE8E6ixjW+PE1Wmitg33AXWjYkwmLos3U2iX+aQc+UFvK8kEd/NOhtGQHGvfbkkFi9NYKQ0hCmaQnnxWpEOSvUnpb/Ib6hrgNbwDFJEazi6BlCm84s09Fz/9Nj8xD+JK+L1R
X-Exchange-RoutingPolicyChecked:
	C1/al8NQPq6T73cp+C04SUUaLlDVxi9Zx5jDvUhYc0m39cvA0XrOB2NXs20rZlTVKOtZAKgQMWReMxBfO2YulpZIJPJnA08c5kCpKz2XkVTrw2p1oxLq68elaE2oOzEWGzXtb8Dc/mTK73ON7VjqHqkax7c9bnskJlx8imcCEsVGIYvnyogdnIkhlbNY3bQ/GZeo2XLEETWcQnVPCz+CqFp4hN2WkZS0jZroB/STMarFUTob9Q1iqotxZHDsVBm6bHQwn39e4qJ+C3/s/zabVXf1DvhlINWRvfP2olm3IUnFLSfDhXgGpEihKB0Pjiy32BTC4dELpomokTSE84iUcA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 05:54:28.3828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb337d19-aa7a-441e-297a-08dee0a333b3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA1OCBTYWx0ZWRfX6HEENoL8jtTx
 22nYp1jRtX48t1bKLI7/N1HZnwXZrVMf/bhMQOdLldmYtFM5drSQkqn7ExFBoeKl8OJqauZ357b
 muQWpsaVOKvFwm8l1NFZQMiAPXcy5PnJnlq1Lc3Vcfvswwff7WFjRx0cDimdnXiiNsC6FVbKERA
 hNsm/2vL69IN/SapsTM9EXOfhnkVMpTaTyr1tGbsXGQAsiMy3z1sDn/ABdIDxnlCK6hcF6JJS17
 CH7zr48Q3vyxgpDYvVtfSG0esI5ny+8NOZSsvPOcFV3wOE5uZ8MTvvba6H/GMEpLAAQjKhUbKhl
 s9lvq86w5RF5rXxqIspjCty7Gnr6GhZmsk8RZBYXTnOfK1ydb2RUxHaw2X1yMBAyQJ3PhM38/Xe
 QDdpNv9isKNeRgx7zlewPx11bsv9D1989jip+I6U+ZXqe6kGhmUQWJ4awoe+2DdF+HHnGsOTkYT
 UeNFD6SYhkOXSFJ6vTQ==
X-Authority-Analysis: v=2.4 cv=IMQyzAvG c=1 sm=1 tr=0 ts=6a547d98 cx=c_pps
 a=WxwGY4H08PlrDVivH1wjUg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=c92rfblmAAAA:8
 a=sozttTNsAAAA:8 a=TpfAaOI81706nv7RqeAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA1OCBTYWx0ZWRfXyriLTbEsILWz
 W5aBT2okJIYGVLF4Le1pMdBVZjqnlRoJ8lzwlAOumN5J4a70r3OV4WJEN4BYyk22HdCkIKA4lhS
 xIBVoufQ47W1SR1PyznaNi7iCI+zqOc=
X-Proofpoint-ORIG-GUID: vKn8lnrHeQYb_QXBhzuM-tzMMzAGFgQe
X-Proofpoint-GUID: vKn8lnrHeQYb_QXBhzuM-tzMMzAGFgQe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130058
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
	TAGGED_FROM(0.00)[bounces-307012-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:m-malladi@ti.com,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 97036747615

Hi Paoli,

On 07/07/26 4:09 pm, MD Danish Anwar wrote:
> Hi Paolo,
> 
> On 07/07/26 4:00 pm, Paolo Abeni wrote:
>> On 7/1/26 1:25 PM, MD Danish Anwar wrote:
>>> Link-local multicast addresses (01:80:c2:00:00:0x) must only be
>>> delivered to the host port (P0) and must not be forwarded out of
>>> the physical slave ports. icssg_fdb_add_del() was programming these
>>> addresses with P1/P2 membership bits set, causing the firmware to
>>> forward them out of slave ports.
>>>
>>> Clear P1/P2 membership and set only P0 membership when
>>> is_link_local_ether_addr() returns true.
>>>
>>> Fixes: 487f7323f39a ("net: ti: icssg-prueth: Add helper functions to configure FDB")
>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>> ---
>>>  drivers/net/ethernet/ti/icssg/icssg_config.c | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
>>> index 3f8237c17d099..04a81402e3f3c 100644
>>> --- a/drivers/net/ethernet/ti/icssg/icssg_config.c
>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
>>> @@ -732,6 +732,16 @@ int icssg_fdb_add_del(struct prueth_emac *emac, const unsigned char *addr,
>>>  	u8 fid = vid;
>>>  	int ret;
>>>  
>>> +	/* Link-local addresses (01:80:c2:00:00:0x) must only be delivered to
>>> +	 * the host port (P0). Clear P1/P2 membership to prevent the firmware
>>> +	 * from forwarding them out of the physical slave ports.
>>> +	 */
>>> +	if (is_link_local_ether_addr(addr)) {
>>> +		fid_c2 |= ICSSG_FDB_ENTRY_P0_MEMBERSHIP;
>>> +		fid_c2 &= ~(ICSSG_FDB_ENTRY_P1_MEMBERSHIP |
>>> +			    ICSSG_FDB_ENTRY_P2_MEMBERSHIP);
>>> +	}
>>
>> Sashiko gemeni mentioned it could be safer to reject entirely wrong masks:
>>
>> https://sashiko.dev/#/patchset/20260701112535.4027920-1-danishanwar%40ti.com
>>
>> It's not clear to me if the mentioned bad scenario is actually possibly,
>> please have a look.
>>
> 
> I had a look at the Sashiko comment. This seems to be a false positive
> to me.
> 
> Link-local addresses (01:80:c2:00:00:0x) are IEEE 802.1D Table 7-10
> reserved addresses that bridges MUST NOT forward. They are consumed
> locally by STP, LACP, LLDP, PAE, etc.
> 
> No valid protocol or user configuration would add an MDB entry for these
> addresses on a slave port — doing so is a misconfiguration regardless of
> hardware.
> 
> The silent enforcement in icssg_fdb_add_del() ensures the hardware
> always reflects the mandatory protocol behavior. Returning -EOPNOTSUPP
> would only matter if there were a legitimate caller we needed to reject
> — there isn't one.
> 
> I think silently adding host port to FDB membership for Link Local
> addresses is OK. This Sashiko comment can be ignored.
> 

I have responded here to the Sashiko comment. I see that this patch is
marked "Changes Requested" in patchwork.

Since the Sashiko comment was false positive, can you please pick this
patch if it's OK with you or do I need to send a v2?

I haven't sent v2 yet as Sashiko will run again on it and give the same
comment again.


-- 
Thanks and Regards,
Danish


