Return-Path: <netdev+bounces-265145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3ARjFfcurGlUmgEAu9opvQ
	(envelope-from <netdev+bounces-265145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 14:58:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3BD22C018
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 14:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 175AD3014BC4
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 13:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97E32D4813;
	Sat,  7 Mar 2026 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="a1ZjJURg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EEB2D372D;
	Sat,  7 Mar 2026 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772891892; cv=fail; b=Szm9vvONRBJChlOnyRRCrTFt35LKjQ/j9cx6Ip5xxxftk/8QEWHnG7TsqAmao6SZO8IgwUv0pBexSnp/z1o6eiF3QkDwYCmQxVgCihXun3NjUY/EROkfqFT0VAbGeBAyK4M9V/YWQeEUC85NmeyNpui3zPIgDpuNztrbB1aMYvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772891892; c=relaxed/simple;
	bh=qxapAJ+KB8ClmC27gjflIuHl2CWpSdUASyOFe+a+oUg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sX5KTXDImTqwa0c9lE8cy7ncnKXq0foqtEzBGB/wYm6DGUEnhAn7UBP8W2zcIAxns4W1frQr57E95vXB/hkH83qKXRTOtkUBSET+fuMMDo92kZXbQHLZTRJriUjgCBpi1GweRguqoR63rVIV9dUAVttx7ow7nhEBc1vsHccpndw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=a1ZjJURg; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6278U1d12302928;
	Sat, 7 Mar 2026 05:57:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=SK9XACr6QZAmJ9wAlyCsLnyFVOaKiDE6KInNSeb5JUg=; b=a1ZjJURgyf/e
	qaxeV/Nq/cYpMX43LoNG0dQD3LQaAF8PuK0/JH1BZ0k1JfeXOHor9s3e5SsVNA3c
	UVKclQtb/vzeIQdeiE69t4TMO5GNAUuut8v3MTFxVqNdx7MgQgCQIo3EbGQV2rFj
	tBaDQ9ObYvGiut3vhA/MMuBZ1EjJ4ceH5XWsaxPy1USiVVl1Dn04fUQ6WZaaP0NT
	9acTF864iAbnobV0QW473F98EQaReZKPOkDWEjLOsSSguv0FCCNkE3DxiHJK+LJ9
	xvkk6ppEDgH21yT5D3fPKx+BA8ljUcEVOZX0Ub80DP1XlyI5rZJtAOk/+OyuOGVz
	ifij8iQbBw==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012060.outbound.protection.outlook.com [52.101.48.60])
	by m0001303.ppops.net (PPS) with ESMTPS id 4crgjbsnfp-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 07 Mar 2026 05:57:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEus0ZcGDBm5YcJYHzGazgNhk/sGuMbX9IQayTLZuwgu3IrnUTND5VLeLRrtsetjbulQwP30LrPsvC9o8AbxNZ8pxMilpU3NmuRQUu8AlGeSVL3zLgKhv0RI2CnVvt2WnHxTkStTWZNWfX5wbPL7SXFSxM3BhlAhAgAqDvSGGlhJ3yHzMeOECU8acIwTwIzwFl4pp6EYbKdNytJPHP5hCeGcZ6IySpPQ7O9tsfycl6ihb2MczjlV5GVFqBUHBwrOa7E1fEjQ/vTvYpRcTjYVWoOldEhIRvd9s34m08o0qsLuUYPceoLePi7RjlaTrqsjRvYjAQ4/+AIDgN2dZ0CJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SK9XACr6QZAmJ9wAlyCsLnyFVOaKiDE6KInNSeb5JUg=;
 b=qKfT/WTRFkij+fRuZbthEa84LlSUmE5mS4esTJeHnIyNcbiWsV+FCTDL1jV+Oe9QXD1Po/g2C172CxX412L83YzqRzT46TqmiNoOMdBhVn7I1LIVnq955u+ASwtg+s0VVsLts7dDBrsPsozd7UYC6XZhxi5UJj6P1kotdl8eyj44eP6ul8nBE8nL7A5blhnSzeEypThP19/aWAQR37QhcsrQ7hc1WbUO2HP8uRJagWaBqY9joH5W7OXCWHdlQYTd4Uys956ssgcjJEczkOGzNc5VHES5VH9CisC/6oxBW2TVi6MKSZdnSxu3+rWsxSkY2NOdgJm62To4+s3VZPSTlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB3893.namprd15.prod.outlook.com (2603:10b6:5:2b6::17)
 by MW4PR15MB4506.namprd15.prod.outlook.com (2603:10b6:303:107::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.8; Sat, 7 Mar
 2026 13:57:49 +0000
Received: from DM6PR15MB3893.namprd15.prod.outlook.com
 ([fe80::12c7:cfea:e8a3:9667]) by DM6PR15MB3893.namprd15.prod.outlook.com
 ([fe80::12c7:cfea:e8a3:9667%4]) with mapi id 15.20.9700.003; Sat, 7 Mar 2026
 13:57:49 +0000
Message-ID: <be848f0c-be28-47ca-a86c-e53e1f6a996e@meta.com>
Date: Sat, 7 Mar 2026 19:27:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10] virtio_net: add page_pool support for buffer
 allocation
To: Paolo Abeni <pabeni@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        David Wei <dw@davidwei.uk>, Matteo Croce <technoboy85@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
References: <20260303074253.3449987-1-vishs@meta.com>
 <dba095d1-6fb7-4a3c-b889-c721e66c7b0d@redhat.com>
Content-Language: en-US
From: Vishwanath Seshagiri <vishs@meta.com>
In-Reply-To: <dba095d1-6fb7-4a3c-b889-c721e66c7b0d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0006.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::12) To DM6PR15MB3893.namprd15.prod.outlook.com
 (2603:10b6:5:2b6::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB3893:EE_|MW4PR15MB4506:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b14c72-f999-4b7c-c512-08de7c518449
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 CnDYBt2Duqk7W03UH6AdgYpDPfdzFPn2rge3brlRivryyxAB5KS8AAEz8IsWkFqnYt8fSLY3djHsZLcf5RfDOYAcFK9pQ57SvnWbYY3j1RIZcE9lMh8GYSzurgSP5OU2cGb3S8BHT2uA6eqGx8ClK8GJyoOm/23eTqTx9MQwP0pdedmaEvMfAfPqr6AmEJa7IeeczrlYPjP5gVfRYlLpiCPUmGJaueLZu16UP6wI7kS2PVuWpFbw+aRiaay4Q5AqJw4Uw/YKwGChfg2dCqY20g7tFcxSJYFwPqFBdvg3EcSdWUCKAoNVFJ7nnGauA22F6aS418wD+O5vAetcPOPXbCLZ1tva9VweNFvowed99QyaKsCM4TvwDlmveyBozxcArETuUnRWngDbqvZuryVGBZJhIEy6VO9ogxrRhonDqMnN3noWePUNCotyjM1GU1EAK4o3zopd9tHY8RcuBuKafS7TrsqpA/KTVjV2AmJ4jUi56JdVlF7Dv1cDjMNhNHYcD7IYWrdAnviVBDbM/lEE+HF9hXXvzv9sxR/UDfVt/7skICKf9jl+UjfChbOu9/bvsEOmdcM7VT/OeFLvpqljC44vMJDk0Ym8ZuHy3xmXxlKI7EZYxY1W0dzP3BAG6E0f7ZbRvrUYKFenstTddyEz95Qrj4HOlitgivxm9r8x1sWVms59J5+CZItCou7c0uJ1Vu59mm0e6X4Ydv+ibvqdA7Hl4qgMGjwNGQZc5FbHj7Y=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB3893.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RnZNd3FWWGdSSEp6UHExeXUzSFI0bnlNdkdzOTV6d29KTVNSVEFYSTRxbzgv?=
 =?utf-8?B?eVJsTXU3cDZWZGhMNFRwOCtWUEVnRU1acnBHa3NUc0laWW42TCtYbFNBa28v?=
 =?utf-8?B?UEdFMVNobXdQU2NudStoQmlzL3ByS203dmdMRy9hU1NpeVBaMXF5RFBNM1Az?=
 =?utf-8?B?cTR4Mk8wQ1BWS1VwbS83U3pTZSt1WW0zV0lQdlB5TGZ4d1YwWktIOFl2QXI1?=
 =?utf-8?B?YVFIQ0ZoMTVhdllBdktXOC9wMjlZL1hyZjBCMFJWV0Fnd09BUWMxZ0NneU5y?=
 =?utf-8?B?di9CeHJFUU1jWGhZWnFuVUxqTW84QllSZHJ3UEVBQzdQVGR1SER0TGwxRVhM?=
 =?utf-8?B?Q0NzVE94TEVOSUxQZEk5UGVtSktOQTBBQmpPdm96Sit0dFJUMHNROHFLaS9L?=
 =?utf-8?B?VG9pYUpjWGc2NDZ1S2tINUxReFVjMm4vU0E2aVJMYnRsMjVldGF1WWthSFlZ?=
 =?utf-8?B?K3JSY0RDUnNObjBEaTdsM0NtV2FmV01NTVRtTEtGNFEyVUJBU1IwM1oyVXRv?=
 =?utf-8?B?b0xEeWVpSXBLK05TVUJibGlLdDJKdjhQZXYyeG80TzIyK2xQclErNjdBMjE0?=
 =?utf-8?B?SjliUUJqallpdG5BOUVNMVl4Q1U1aFB1N09YNE1DL1d3dHJQczBubTZKVjI2?=
 =?utf-8?B?NzFBcm9IRGJzZGJVbXQ1dCtQL0QreTEwemRkRXI4K3dkTG4zbHNNQkh0V2ZP?=
 =?utf-8?B?RnRNbUNheThPWS9LN3pwS3NEZUx6TExNSmFRYW12ZXAwQzkzMklLeFpHOWx4?=
 =?utf-8?B?OHpKYW1MZWlGZUxIeW1rYkZkeE4rdHNwQ2dZazMwRW5ubTZBYStiYUJLUnFh?=
 =?utf-8?B?eUtLUUM0WEtLNkRYbXNreGdmY2l4VzRsQ0FNUzBlRTI1VndGeVNib00zOVNu?=
 =?utf-8?B?ZUNqTFNjOXNzMUErSlpnTFZPNFBYMUJYL0lrY3FEclkydWhuOEF0UEFoZldo?=
 =?utf-8?B?dHBEdk1vaEdjR2RZbnNNMUJhcVArZXZiUW9NSGJyZEtmUzUySzhLT3dFaldZ?=
 =?utf-8?B?Q3JWc3YyaXBiQ2Y4WFlNQy9jdTBQbUR3MHBlNGI1K2JjNGpwMzBNRzNQSHk2?=
 =?utf-8?B?T2xTYWV0WnMydGRBNXN5VzdEZ3pkWElxeGNGL1dTZkd1Rk1JcnArcFR5Qjht?=
 =?utf-8?B?MkhMUWhZZUorck9JVjhqSzdvazVZVWRSTjk1eUR1ZzdFbjJxUitVUmFrSTBa?=
 =?utf-8?B?Yi9xTlROcDI2WGlibkV1Um5ZUkdDQVhVWGpDRmVMaS9jY21nOE95MEVQZmlF?=
 =?utf-8?B?cHhwOGM1R2ZHcFBIcWdhZC81ZkFsajUxM1RBaUswOWROcmkvL3hzVDZSa2RD?=
 =?utf-8?B?QVQ1Q0N2a1BhRlMwYXdDWTVyWUl6TVRERkZxSmYzaUlqTGswYTdiZEo3dkM4?=
 =?utf-8?B?Z0UwZHYvKzVydFd0akZFL09NZktyV0IrSEJPQSt4b2w2SGRqOVdaUjgyOG9n?=
 =?utf-8?B?OGF2QSswdUVXcVhiMndnNmRvL3Y4YkVab0pLQ1lOUlZsSEJIdnp2Uk9TSWdr?=
 =?utf-8?B?TVRBM0oyQ0haeTBjU1plMW5EL0ZrYUJnTk1rQ3JzOW1aaVp1L2htVStXUGtH?=
 =?utf-8?B?TkpoemU5Y09lTFkvSG1sYWd6RXc5K243RUxzUVd5U1BiMGplOHVHcm51QXAv?=
 =?utf-8?B?MUltZEt1b3Q3OVY3SlJ0cHk2Q0hIYVFaaG90SDh4b295ZTlmRVA2ZTUwQk1C?=
 =?utf-8?B?TzRCaGtTbThHRERpK3J6b28veVUwR09oaFhnYXBFNUNMYmNpU1RlZkg3MERI?=
 =?utf-8?B?dDFncXd5enZlQkhPd0hneW1abkV2dlcwVlYybkE3aHhpcmI4L29sL014TW1k?=
 =?utf-8?B?dzkyMEliZnVaM0lKWXF1QnpRL3ZIVjdlNGVNbVJrRGt6OTYzQUVLeHNVOC9I?=
 =?utf-8?B?aGhiYVVMTTgzdWVrMXdlUzd3SWYzK2xkWlQ4eWFYS21TalIxVHlJUUVxUnov?=
 =?utf-8?B?VDdmdThWOExOcHNjQ1RaNDQrL2VYSDVJdlJLWm9UT1lGV0w4OTNJYklWLzdU?=
 =?utf-8?B?R1hKOTRaR0Z6bGg0d2NIYWJjMlVrdVhHYUg3ei8wZ2U2L3BkQUtrd1VkTXpj?=
 =?utf-8?B?TEpJNCs4ZzQxaFBUbzNUMkdQeklGU3daKzJSejUxdnE1cFdvWkZ6cGNxU0Ez?=
 =?utf-8?B?WEZidHdNNXBHdDZUUjlmUlB3UFN5MzV0dkcxRzYxMExTQkZ4UWx4d0s3OXVC?=
 =?utf-8?B?cTRFM2F4a0ZpU2tndFFIRHJ1bjVMNXo2UUpwMzlWT0ZKUkNnWU1ML0xWdEpI?=
 =?utf-8?B?Z0pZNEdyZEhJVHVzVlZCeStaMS83TTYxME9ZZGR3MkliNXZOemJYU0lJV0FG?=
 =?utf-8?Q?oDvbeHWngTKYmLIkjn?=
X-Exchange-RoutingPolicyChecked:
	KfA2kSes0s9A9J3UFqrjmlWFgu8gevnjrVTG6bz7gmatUZknH26k0wNR7wH/DU5hjg6ZANGIguaY8gt40BYkbP9/SWOyviUbuguyPMDM3f6AWQDQvBx1OFzI4vgpWGyvlLMdR0K/RNL1zxoNrKF4tdiMaSROOad9EEC+6zxNPRBbspCw1BO8pDH9jEZibGOoIF/6l3WgzZfidBfPACaqjvUD5wHf9hGUeqFysL2ngve3JvtaC9MZiWdaAHx08Hb4gK1tofUDn42SxKFL6l2FoDOFHo0akQPoqkTwj2immaiUhyQCl2r/HmEke60yo8T76bWTZ6ZrpPavmh83k2uL+Q==
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b14c72-f999-4b7c-c512-08de7c518449
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB3893.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2026 13:57:49.0875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1pzUmaDC56hBKI8/jHsOVIdaiBY7fdgWUuiBVJ3I25A0Sxi9X7kM0+yyUxdNc3b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4506
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDEzMSBTYWx0ZWRfX8B9lADfu+a4E
 UxdZeGfZdNwfjQf98rwHYxiWn0Xc0EC4MZ+2cdbtZnuZQCAYjXfSJ0WgycS4GnYL19HmLKVQ1L1
 y8Fe/gmuwF3+CF3+8ySL1dolUaHdniAMu1EfvbEe8EsM/BfpRnJKZFriyeaU6ZadlZNWy8X07iq
 ZBSsbGk88YKk9GcqQJqmlcFdmm1lxO9tKEXnU2OvtsaelGudqYdi8pLX8lYV1A3U8ItaPgoWrHM
 +Im3CDaQ/Ong5QPZqcIKZ7Yb3ue6i+tDEOBawnMlaf4YRAAgMK8+hHq/mP9YH0geR4viKjMvdxO
 Izlwvz4GSuDjFHscIS3jFXZXrZqGVorBC6SHDFBde1xENcMvkPEaikY3mDfzoyN/kl22ub1YgBQ
 5FaGT4dAWZGs/3E9s/EarGn4A24xScmgXdV02HtlsGc6uAzmopGST7P9HryYEXMFyBEm6iumvlW
 OG6nCq7AAjXL+ZFAejA==
X-Proofpoint-GUID: 30gBvH8gjCgvFSt9-VAtZMQefOQ0KxIN
X-Authority-Analysis: v=2.4 cv=LYUxKzfi c=1 sm=1 tr=0 ts=69ac2ee0 cx=c_pps
 a=MzitxtHdenuwXKuz6QWlPg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22
 a=aYmhyGnNTLQyLaClKr0A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: 30gBvH8gjCgvFSt9-VAtZMQefOQ0KxIN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_04,2026-03-06_02,2025-10-01_01
X-Rspamd-Queue-Id: 9F3BD22C018
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265145-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux.alibaba.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:dkim,meta.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishs@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/5/26 5:33 PM, Paolo Abeni wrote:
> 
> As noted by Micheal in the previous revision the above will
> skb->truesize under accounting. That is not safe and at least need a
> solid explaination, which is still missing.

I misunderstood Michael's v9 feedback as a variable naming issue and
only added a separate alloc_len to avoid clobbering len, without
actually propagating the real allocation size to truesize. 
page_pool_alloc_va() can return more than requested when the remaining
page fragment is too small for another allocation. The small buffer path
ignores this and reconstructs buflen from constants in
receive_small_build_skb(), so build_skb() sets truesize based on the
requested size, not the actual allocation.

I'll fix this in v11 by encoding the actual allocation size in the ctx
pointer (similar to how the mergeable path uses mergeable_len_to_ctx)
so receive_small_build_skb() can pass the real buflen to build_skb().

> 
> /P
> 


