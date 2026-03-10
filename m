Return-Path: <netdev+bounces-266315-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iF4BHT58sGnLjgIAu9opvQ
	(envelope-from <netdev+bounces-266315-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:17:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D16AD257720
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5428B3036EC0
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 20:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B953E9280;
	Tue, 10 Mar 2026 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="PGQBdHk7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60B33E1D05;
	Tue, 10 Mar 2026 20:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173653; cv=fail; b=exSf3oPdz37o9+R1r8A/mpNGVMtJNn9KMoY5G/qR2auUjzGoXajI2oheE2Xr3AQyGFDbkW+sKsXwWdKyIEZxLHxXlF/ELeySN25NdcMe1L4/AqP/mbdU3L/jvq33nDPhRX8OuUsiHNauolgpesNPsMwyyE25HbSwoRmGA5NfwPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173653; c=relaxed/simple;
	bh=2+7SyzQESzRwKxq3Ze5N7Wy6NsAWjiuk/HiO5Qir/NE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mT5ST/6I5P8flwRALYm+9Ihk52ILH3uCTiBRd5CQH0L9Q8IqrKvdhcNjp7EqStGLi8VgZMMVwtG1pSCPa73lJpjSemI4Nd/qX0kBYXLyqxiSuQPafXOIa/4H56TgjUfK+CVqe9D6WtXI7rdsda4Re4BGoEKssLYmffiUj+mhsek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=PGQBdHk7; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AITPLN919888;
	Tue, 10 Mar 2026 13:14:00 -0700
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11022103.outbound.protection.outlook.com [52.101.43.103])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cte4tahew-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 13:14:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JB45jgMOJfoMw90g0+GrukXfk/o1jfCaCpStmEuDU1Ic8hzt38eqYWkfapBUXH4pzl1RpoZwJxNfv66n6MsS23cI2w/XsUCb00ZPANE+tHkZQjKWw9uSK7kpForkrGAX84f1LP784PF1cGlMNvsTj9smUsNVCGU9fQzdQFUfVHeCHGgjbqdN2iCPH6DBdeVT0qV81YD/2EHQKK9N4eIwvS//TmapCxCshh68SJ10M97K1SsfCITylOCRJwDvo7PXZFp3sxys32LtTWIovYKEcWIGjnY11jWsM+LZY628XC72DyAIWv/QhQN6Y1nIMU1JUrHvlu5bS0C/RuJVfSteVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+7SyzQESzRwKxq3Ze5N7Wy6NsAWjiuk/HiO5Qir/NE=;
 b=kaCl2ut9lqt4fAdZW+P2GiUteA4aLEN61ClW5ZTepCY1I0I8Y6xN2W6dzJTg86Cs/jSIcPdsEHwyMltewSfcip28CZ9VT120xiTotrY+hOAcPxwuP9LZcfVmP8Hu3oCQPapw9u1xF+am2qwdQhlSxw5qJBCWm1VsOPgwKaZP/8YbwGWKoD3yp6bcOG6MichnGedDc8tZkcsGcGtAL45/FnCSN13rawgiANMZR/zp0kpp0r6t24IxwUygP1ARDhFQcsh+i+NGvPho6Djw69wK1tocbz3owKISca6/TfPL1d0JWnOqRSjE3bkWqcJLuYmtrqgpnGmdJvaz5IO2xccFfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+7SyzQESzRwKxq3Ze5N7Wy6NsAWjiuk/HiO5Qir/NE=;
 b=PGQBdHk7ustitDae9l0CFePHfD9qOn5ZsKFTrpIFZaQFjVqSRCQLKcBgaI1Li9CK6RGxd2GdJfGvU+efXVO6fyVITl/ip8ykYyIDUPwhzn67uN2UmYonCel3k2RsjEvpfFRKWV8qc8Mq3d/CNR11nZ1ufhCgvvW7EJNw0amLeuo=
Received: from BYAPR18MB3735.namprd18.prod.outlook.com (2603:10b6:a02:ca::16)
 by BL1PPF25EF7E22A.namprd18.prod.outlook.com (2603:10b6:20f:fc04::d8e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 20:13:57 +0000
Received: from BYAPR18MB3735.namprd18.prod.outlook.com
 ([fe80::448e:bd83:47c:f8b3]) by BYAPR18MB3735.namprd18.prod.outlook.com
 ([fe80::448e:bd83:47c:f8b3%5]) with mapi id 15.20.9678.016; Tue, 10 Mar 2026
 20:13:56 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Rosen Penev <rosenp@gmail.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Raju Rangoju <Raju.Rangoju@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        open list
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv3 net-next] net: xgbe: use device_get_mac_addr
Thread-Topic: [PATCHv3 net-next] net: xgbe: use device_get_mac_addr
Thread-Index: AQHcsMpsM5p7u+Mq+UaV4MFXwRgWUg==
Date: Tue, 10 Mar 2026 20:13:56 +0000
Message-ID:
 <BYAPR18MB37354275B172B05EE7C869C0A046A@BYAPR18MB3735.namprd18.prod.outlook.com>
References: <20260310194647.3794-1-rosenp@gmail.com>
In-Reply-To: <20260310194647.3794-1-rosenp@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR18MB3735:EE_|BL1PPF25EF7E22A:EE_
x-ms-office365-filtering-correlation-id: c70c7d5e-4301-4f22-8942-08de7ee18f39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 8Zx60VAIgxOzMKEJPK4R6MUeQbJQzygqJRqRx7k2F/jzXsPETWRGE+zDQDmTRxRnYPcmVkqMLvHEplKNUNn4UF6+ECGeD+HMi4FZrMRFIk8p49QD3b+uKbXqkyERvLFB1PK+fOClNr3evDNU0AOk6B50uMD5ErsG/m3SKCwvp1nlOoQOvg14+IaIEflzyz4ZxxzuNGR1gFQhmzu8CUXB5oOAI9KDuez6kVPfvF8zJ2UYL1g1Tukovd831afkyfAadXkLbs6U3VtwBpPfu3XWOaT9F+ddKF50Rh2dKb6p7wQ2I4avd0cH6D0D/zFr99SEwsFv5sWcOieVf55vqMSxC2jPQ89O9FlKEpWdSDmbXOILPeRG2VZXIAXL3wfXyXdx7lt2sXhL21CV4r5Au1BCq1ztjl5MMas2F9zAj/gVqZUywQeZCLzsRVAwCw6P8YuJeeSKjH2hGKe1e0iB7BUbTBwc+cjFKQ9itSMnQ4Emp63lM3u0zAaw9imXspfPmG+qVkYXlh5naYvuUby5pYqv5m67WztHpw5hAZzZYoZntzwMQXPgMZiyD7PmDHdVecaztPnMQPeEysqu/MlOiuH7TyzxCppfcCbYBdFcqYEYDlO+MVkXOVpuiAOfNmv6h2ex8YZlhoPeE9HspjwFKmN0XQC/EmOvot/kugVcJyES0glvn1RF/hW+qJaEuXe4osNesYXYnym0zqH9Gve6lyMkjZZvLba+xc3ap8l2irE0ZX7B37XHqpQ78wJyvKPrhFs8H0DF8JQr6dspqP5rBN9nLVyz5+dbaEdvyrNRVGs+JzY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB3735.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WnVISnNINVM4YUx6ZnlXUmNrbjFGcmZ5WUVNbGl3cGxtTm5Ed1dSZWpPVmhO?=
 =?utf-8?B?TFNkUUg1bzRxMUdOcTR0dUdmb3BMMytzN2NyL2JHV3Y1RE54aDdnL0ZROHQv?=
 =?utf-8?B?M2dMVEozM05UTmJ0eFkwSVlSaloydlFjTFRsZTdYam1zY2hkam15SkVkTWxy?=
 =?utf-8?B?bCtpZkxISzlqUFBLcW9rSGt6anNkaERNaTVLSmtKMTdkOHEvK2xsYnYva3lu?=
 =?utf-8?B?RzRKU21Wam84RFJITEJKckRoQVE5aURPVjMwMWZpVnJEeEVxK1RQNGJ4QWZ3?=
 =?utf-8?B?b3VOZDRwZHpPcjB5dWpISG9tRENCYTBlcmg4Y0Nqbm1DMy9GZHMwY0dLdVg0?=
 =?utf-8?B?Y0lNTTJ2OGFVNWdFVmNMMWNwVE1ESzNQaEJEVHMvMk9ndk5YKzBvZE42UTYz?=
 =?utf-8?B?emZJUitKejdGQTVLWEJaOVg1WmZoZUQ3TllkVUcrUGtobDN1RElWVDMveExH?=
 =?utf-8?B?SUNYczNLOU5HdWx6cG1laDl3d29KWHFOeG0xb283amxkWExOQ1ZoRkk1MytI?=
 =?utf-8?B?eFFHcWg3ZEVtSEwwQTVOZUFMYWJFd3lTeW84MS85ek9YT2VWd245Sy9NNzNv?=
 =?utf-8?B?T0FkSjJVOFJKMVRMUHB0NVlKWVFSb3lDZ0U2WW53dXNPNCtXaml4YTZJenRH?=
 =?utf-8?B?YTF6YkRFMDRJQ0piOWhsb2s1dU5KRzdVOU53MFNTUEtqS2p0MGxteFMxRVlB?=
 =?utf-8?B?N3ZYMGt6SjRkNG5hU2g1YWVQOC9KK3AzSXY0c085UkFmNUdqZ1RVaHhwblkx?=
 =?utf-8?B?ajRscTY0T3BUN1l2aDNoOXJENGlzWGVTYU5SdEZtSCtvS3lnemdkWm5PYmxO?=
 =?utf-8?B?blBPTC9mRzNtL0FXMnB6L0NrcjNzd3NMNFdqdW45TFk2VXRmUm1zZ1haTzNt?=
 =?utf-8?B?OTAvQWtzakpNR0F4aEhoSUVGSUJqMWc2eG83a2FxMXZpWHBybjhVYTZROGlD?=
 =?utf-8?B?c3BxcWhWZkdMSnVYNXoxN3Z2dWxucmZvdnlaS1M4WGRiQkdtUTlFYmVnUGg2?=
 =?utf-8?B?OWhBTDVtL045MksraGJ5dEpCdlFTUlFnYkljRTJRQ2wrM29pd0ErUkNJdkxI?=
 =?utf-8?B?Y1JBS1NPcnlwZ1M1aUVHakxUNTNqWFE2MmVPWUQyVVp5UVlZczdjTi93YmdF?=
 =?utf-8?B?WUNvem5kWDExZWM0eGxkNXpxUmNIb1Fmem9EMUJqTXdNc3Z4d2lkN01vcW9M?=
 =?utf-8?B?d2hpRGFLTjNiOFJnL0sxQUtQWU5sMkFUMWFWbDhxL2xtRHRQbDRlZlM4RXNq?=
 =?utf-8?B?UStWMHJmMzFvemdsbndaTXpUUmtnbDBza0d5cFludERUSjhEeUJONitPV3Yy?=
 =?utf-8?B?UFJjb3NzTFpBcFpvc2YyakFyanprVFhDZE1VTHRLY2RRSHZHOVZaSm5NaVlr?=
 =?utf-8?B?Y0h4ODdpNURXUGFlRWVySUVMTTVvTFBpd01Ic2tNcUtkeVJWbWxaQVZ3TjlO?=
 =?utf-8?B?SldQczRDWlgvWnI0cTQyVVBicGx2VE9kQm1SRTFyZVFERFRId1lWZkE2TzFB?=
 =?utf-8?B?VlBNdGVRVVgrMkdiYzBCUytHaHBkejVUNXg0c1NQSGZnTUxoNzR4cUhySzEy?=
 =?utf-8?B?Ulo4RnFLUnF3UDhnYzRQNzExSXZnSFBsNkEyM0NXa3djamhJeDRKUG5HNWg5?=
 =?utf-8?B?SnpLbUE2WlRiQXpMamFpQVBybGJ0NFF2bVY5cHlMMlFqSVFPSVpnZWRDVFdt?=
 =?utf-8?B?cE52TGY5ZFY0OE9YRnVMUWNuV3pvT3cxSHNNbjdOS2dQbndGN1RCalAySXht?=
 =?utf-8?B?UHorOG8yRERDRU9vQ0tibDdKUXNQL2ZjTm1TeVBZLzk2MGZ5NjNuSCtja0pQ?=
 =?utf-8?B?VENTa2RxS3AxNk9laENpMXJsUUlMenN0VWQ1N3ZvZUtJOW9ONmdkV0RYc1VW?=
 =?utf-8?B?cUdlN1o4VWVEbHgyM2NzcFAxNW8wRWxraFhEMks1d1FDaFZZRUQ5SFJQSjJI?=
 =?utf-8?B?N3dhaHd6Q1FwQzF5WnI1RWY3L1RKQmNQdDVJOUx4MVEvaFgzRHg3TW1WWXhn?=
 =?utf-8?B?VnBzbWZoUUl4Q0s4czlGMzNkYk1rN3ppeXVyQzN0Q3J5UXhXU3VoM0owckdj?=
 =?utf-8?B?bEFFdTYrY1BLcVNyR2hqSFNIMXc5V2VqZFhBWEVVVXRBUFBXdGNoaUQwVmZD?=
 =?utf-8?B?Tkl5ckd2THpqVlZ6NFplcFpaQWRLWTRnY0VXN2xuQWVFK1h6Sk5lL2Z4N2Zm?=
 =?utf-8?B?RHQweENwNGVsMmc1Y1V5MU11dFV1VXNlYnhhRFQ0UzNpQXRKNFNYaUEzRUU2?=
 =?utf-8?B?NkZlRzBDVnJNUGxGekZUZVpXNWljTTZQK1crN2RUNitlcUM1QmtWWVBFd0hW?=
 =?utf-8?B?QXVnNXZVV3pLRU1oVmhtazQ2ZjZIRjV1dkgyL3ZxQnYwQ1A5WHhHdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	cVIQQ8qtq2SOH1GUxBwVGySAK9InUABhfMXkzqRwOr6rAOUkpB+cYurmEis6hAedl+11n6nyL1+OBd+H9ierJ3tPpU7gQkbh3XwwdiMGKByylW5LP36iO83Eb8nBhHLpBQaN1XzWST+xsNeLOLMIZrm1kqRwBD54SZWu5i1BGmqVw/YhdHFBeZCYSfKcwY2CXR0m+Zb4NBLeOqzEUie3DeQiJnL1lFdymmJDvz/6CtdkAbIGY7jm+6IFaeEvlXb5g2EnQerAKWZ+wEW5kERduI398xj1cMP0qUEYLBt8G5xJ8i1JCSfRkDplunUJQYTmnK5fteroezdD0UCJzn9ElA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR18MB3735.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70c7d5e-4301-4f22-8942-08de7ee18f39
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 20:13:56.8649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LK650WSXXBZvEm8jQuIracIyTWsRki1wBo6Td46oZnTNtgIvCY35G1Oycbq4CdSRxFM3pLsT0ZyXdhmR4qm/Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPF25EF7E22A
X-Authority-Analysis: v=2.4 cv=YpMChoYX c=1 sm=1 tr=0 ts=69b07b88 cx=c_pps
 a=poLntA6gJg8PyknBlaXY5w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8
 a=20KFwNOVAAAA:8 a=M5GUcnROAAAA:8 a=rcom-R4f4X4EVwpdamwA:9 a=QEXdDO2ut3YA:10
 a=y1Q9-5lHfBjTkpIzbSAN:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE3NiBTYWx0ZWRfX7OLHPXNcENFy
 6PDj6dUqAXeaBf7picCm5oUnHib9b/rdwvlwkmHsxrASET+rFL+UEkUCkDtqPicDDrcEB0RdPGa
 QvLCw1Tu8UdKAWSuvQoXonfi5j8yuvcb75NplceadDxqxGqEgChwmnd2WIpM6z3+wwsZ2u0wZTY
 pldgihfJgk7CzHTvLCgoKe5I7FaLL9JGurV2goasoIVYzXhDRW0fPzfr1ig5BinnSyYAOjm+/Qy
 kjfPE2MXYwm5FWAidvZd4/8T+5rEln1W1uGPPiYEiU7gqOitXLassSUdDjXKd6PJMzIRyaiMTMG
 OrI+8c7oG7mNyd36MNO0CR8Rh+YE/wwp+CPoq9YOz7Xixf3XCN5Adq409oPoaaTAkCxCNtykeT0
 gYgxDDewkiefNkhv9GSDNNte5vd0QG4d2I/5OnJd1AWsMwM8HtL2viNauDfieRU8NBgwe9o9CxK
 zlfyd8J4jHAGIuSa4Ow==
X-Proofpoint-ORIG-GUID: vwwCLIrxGYF9P6CtkrwL8kOilaQeaQKT
X-Proofpoint-GUID: vwwCLIrxGYF9P6CtkrwL8kOilaQeaQKT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Rspamd-Queue-Id: D16AD257720
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-266315-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,marvell.com:dkim,marvell.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,davemloft.net:email,amd.com:email];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[saikrishnag@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvc2VuIFBlbmV2IDxyb3Nl
bnBAZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDExLCAyMDI2IDE6MTcgQU0N
Cj4gVG86IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IFJhanUgUmFuZ29qdSA8UmFqdS5S
YW5nb2p1QGFtZC5jb20+OyBBbmRyZXcgTHVubg0KPiA8YW5kcmV3K25ldGRldkBsdW5uLmNoPjsg
RGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYw0KPiBEdW1hemV0IDxl
ZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBh
b2xvDQo+IEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IG9wZW4gbGlzdCA8bGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogW1BBVENIdjMgbmV0LW5leHRdIG5ldDogeGdi
ZTogdXNlIGRldmljZV9nZXRfbWFjX2FkZHINCj4gDQo+IGRldmljZV9nZXRfbWFjX2FkZHIgaXMg
YmFzaWNhbGx5IGRldmljZV9wcm9wZXJ0eV9yZWFkX3U4X2FycmF5IHdpdGggYW4NCj4gaXNfdmFs
aWRfZXRoZXJfYWRkciBjYWxsLiBBbGxvd3MganVzdCBjaGVja2luZyBmb3IgcmV0LiBSZW1vdmUN
Cj4gWEdCRV9NQUNfQUREUl9QUk9QRVJUWS4gZGV2aWNlX2dldF9tYWNfYWRkciBzdXBwb3J0cyBt
b3JlDQo+IHByb3BlcnRpZXMgdGhhbiBqdXN0ICJtYWMtYWRkcmVzcyIuIFNpZ25lZC1vZmYtYnk6
DQo+IA0KPiBkZXZpY2VfZ2V0X21hY19hZGRyIGlzIGJhc2ljYWxseSBkZXZpY2VfcHJvcGVydHlf
cmVhZF91OF9hcnJheSB3aXRoIGFuDQo+IGlzX3ZhbGlkX2V0aGVyX2FkZHIgY2FsbC4gQWxsb3dz
IGp1c3QgY2hlY2tpbmcgZm9yIHJldC4NCj4gDQo+IFJlbW92ZSBYR0JFX01BQ19BRERSX1BST1BF
UlRZLiBkZXZpY2VfZ2V0X21hY19hZGRyIHN1cHBvcnRzIG1vcmUNCj4gcHJvcGVydGllcyB0aGFu
IGp1c3QgIm1hYy1hZGRyZXNzIi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJvc2VuIFBlbmV2IDxy
b3NlbnBAZ21haWwuY29tPg0KPiAtLS0NCj4gIHYzOiByZW1vdmUgdW5yZWFjaGFhYmxlICFyZXQg
Y29uZGl0aW9uLiBkZXZpY2VfZ2V0X21hY19hZGRyZXNzIHNldHMgaXQgIHRvDQo+IHRoYXQuDQo+
ICB2MjogcmVtb3ZlIFhHQkVfTUFDX0FERFJfUFJPUEVSVFkNCj4gIGRyaXZlcnMvbmV0L2V0aGVy
bmV0L2FtZC94Z2JlL3hnYmUtcGxhdGZvcm0uYyB8IDEwICsrKy0tLS0tLS0NCj4gIGRyaXZlcnMv
bmV0L2V0aGVybmV0L2FtZC94Z2JlL3hnYmUuaCAgICAgICAgICB8ICAxIC0NCj4gIDIgZmlsZXMg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2FtZC94Z2JlL3hnYmUtcGxhdGZvcm0uYw0KPiBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2FtZC94Z2JlL3hnYmUtcGxhdGZvcm0uYw0KPiBpbmRleCA0N2Q1
M2U1OWNjZjYuLjBkZWJlMDE1MDczZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvYW1kL3hnYmUveGdiZS1wbGF0Zm9ybS5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0
L2FtZC94Z2JlL3hnYmUtcGxhdGZvcm0uYw0KPiBAQCAtMjUyLDEzICsyNTIsOSBAQCBzdGF0aWMg
aW50IHhnYmVfcGxhdGZvcm1fcHJvYmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikN
Cj4gIAkJZGV2X2RiZyhkZXYsICJzaXIxX3JlZ3MgID0gJXBcbiIsIHBkYXRhLT5zaXIxX3JlZ3Mp
Ow0KPiANCj4gIAkvKiBSZXRyaWV2ZSB0aGUgTUFDIGFkZHJlc3MgKi8NCj4gLQlyZXQgPSBkZXZp
Y2VfcHJvcGVydHlfcmVhZF91OF9hcnJheShkZXYsDQo+IFhHQkVfTUFDX0FERFJfUFJPUEVSVFks
DQo+IC0JCQkJCSAgICBwZGF0YS0+bWFjX2FkZHIsDQo+IC0JCQkJCSAgICBzaXplb2YocGRhdGEt
Pm1hY19hZGRyKSk7DQo+IC0JaWYgKHJldCB8fCAhaXNfdmFsaWRfZXRoZXJfYWRkcihwZGF0YS0+
bWFjX2FkZHIpKSB7DQo+IC0JCWRldl9lcnIoZGV2LCAiaW52YWxpZCAlcyBwcm9wZXJ0eVxuIiwN
Cj4gWEdCRV9NQUNfQUREUl9QUk9QRVJUWSk7DQo+IC0JCWlmICghcmV0KQ0KPiAtCQkJcmV0ID0g
LUVJTlZBTDsNCj4gKwlyZXQgPSBkZXZpY2VfZ2V0X21hY19hZGRyZXNzKGRldiwgcGRhdGEtPm1h
Y19hZGRyKTsNCj4gKwlpZiAocmV0KSB7DQo+ICsJCWRldl9lcnIoZGV2LCAiaW52YWxpZCBNQUMg
YWRkcmVzcyBwcm9wZXJ0eVxuIik7DQo+ICAJCWdvdG8gZXJyX2lvOw0KPiAgCX0NCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9hbWQveGdiZS94Z2JlLmgNCj4gYi9kcml2
ZXJzL25ldC9ldGhlcm5ldC9hbWQveGdiZS94Z2JlLmgNCj4gaW5kZXggNDMzM2QyNjllZTg0Li5l
NTdlNDE2YTFkNWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2FtZC94Z2Jl
L3hnYmUuaA0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9hbWQveGdiZS94Z2JlLmgNCj4g
QEAgLTk2LDcgKzk2LDYgQEANCj4gIAltaW5fdCh1bnNpZ25lZCBpbnQsIElFRUVfODAyMVFBWl9N
QVhfVENTLCAoX2NudCkpDQo+IA0KPiAgLyogQ29tbW9uIHByb3BlcnR5IG5hbWVzICovDQo+IC0j
ZGVmaW5lIFhHQkVfTUFDX0FERFJfUFJPUEVSVFkJIm1hYy1hZGRyZXNzIg0KPiAgI2RlZmluZSBY
R0JFX1BIWV9NT0RFX1BST1BFUlRZCSJwaHktbW9kZSINCj4gICNkZWZpbmUgWEdCRV9ETUFfSVJR
U19QUk9QRVJUWQkiYW1kLHBlci1jaGFubmVsLWludGVycnVwdCINCj4gICNkZWZpbmUgWEdCRV9T
UEVFRFNFVF9QUk9QRVJUWQkiYW1kLHNwZWVkLXNldCINCj4gLS0NCj4gMi41My4wDQo+IA0KUmV2
aWV3ZWQtYnk6IFNhaSBLcmlzaG5hIDxzYWlrcmlzaG5hZ0BtYXJ2ZWxsLmNvbT4NCg==

