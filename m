Return-Path: <netdev+bounces-216974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4957EB36D2A
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 17:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F2CB2A1008
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F265521B9C8;
	Tue, 26 Aug 2025 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DgokgclF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ezTSUrhV"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E53511712;
	Tue, 26 Aug 2025 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220486; cv=fail; b=sb1AGILkeHaM52cXUeT9yin8yIFZUHZ8FaUbRjU+mZoyuAeFWBil4LmjUKnJ50UXADXKVDDtIgvhunXXMpz1q11UcgLAEhpZxhYAJENkeZ4rfQ3HG+5edw9C2IHnsRLOWashmNH1BDIEid+/P0ebqZ8N5h3vwIH/d3xTqydKaV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220486; c=relaxed/simple;
	bh=hBHkWvCiV3AWfn+hh3vzL6RIHrRB7rLv34aTzatApTM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mEP5xojKYWvePdZQegsJsauN1rAH1QC8yT9aMEB5bRo+IqwCuaFpKz4kNBkv2YdTQLSoekn1bxjZ4JxSHaiXbvy+EhV3xpORUg5C6fkpQIW/M/lA3ldawpcgBWuDbUu2jfQCao4zWWUsYGb9CklURTphriHW8hsEB500UjjaoZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DgokgclF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ezTSUrhV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QCGqfo027361;
	Tue, 26 Aug 2025 15:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WO4STplCyKCLzq/NlrRiUyI4T79BsrUQZNeep1Fob/Q=; b=
	DgokgclF2W1BxCiCm24l4TnE1VDZPb2PdXlOUZtu92XhIQcv9ghq07g7FJnOEl48
	+VI4OEjcisETgCRN2naxo1KTks0JgXIQd0dPYtRJzW/buhgB16s9c51z0+sP+9Z/
	IJ/DyqN5+STVJWLTEC4V9e1qlk/rAQEazZD86GVV9UGn00QvHq0CjsE2gGfMydmN
	MPbIXyIuUbM9btgI5lDjQl1fPnYiwvAFTSYnZHmXc3Ywd2qLLpvAmHEU/tDgeeBP
	9Tw6EWaKLZ7tYVlYpoiYpoc9oKlBxGGedNgtK6ruk23D3Et+Ykvcp1hdJnoO0kP2
	kj9NiQhqdIQkSXjlC2mk0g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4jamm3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 15:01:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57QErbx2018956;
	Tue, 26 Aug 2025 15:01:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q439q34g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 15:01:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctmn2sbEPRiPkHlTv2bGIb/gE10QKXXfy5dPLaGF+Xb3q3Zc6VEQawNNdKlU4nHuVCVZsYwq6qqgjL7yFTyNPUdGmRPxYnf1K2gYANDwAB79OYFcCRPa/KPwhT/6k3dc0+c01pq0YgpR7NFVpzwbqdExazk7LIuIud7Gkteb99G8V8MEi7bOSwzjr4FYg39z+OXaB1IC52Fat0chv8QPyJe2gI111Yz8lp2XzZQ66r88TUU45qTG8KgZxAID9L5Ga7T8BihdvgMUXr9B9veC+SOVlXP0RPV14xZBS0S0HHHMQGWY44ZEME4E7LFQYs0vffeu81fya/HKxljPAhkyxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WO4STplCyKCLzq/NlrRiUyI4T79BsrUQZNeep1Fob/Q=;
 b=F9TfPAArKymGWq4+3xUJ56s9bJMxYsn4LYXLEOqa8f/Uns8lFJbuBcL1Rx5+6kSo89GW0U1X5vBNsKixpF9eX/l4u7Wrf7MLYXSk07QbEVPFFRDcL4LK+MgL/kaJtg7whMnEu68MMLmX/bfa0yA3bSnwrh42cQFoG6h3WRiAq1Y3dk9mv7L6LdNdHKOTin79ZX74F9kg6r/iq9Fuk8f0uxhxzmJ7291RtB7GLWZMQhCtewrYpcUc/2AGYDGHiqy9rugStYVXvFCTUd/XmyFkY24/yd+//j4KahiRcxX5fuwpys/IHrxTwAVRNHxinT3UvP9bTKB0Bj/3Y7duN/8IHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WO4STplCyKCLzq/NlrRiUyI4T79BsrUQZNeep1Fob/Q=;
 b=ezTSUrhVIl13y941E+hQccyaeqRmrxtDzDIEPXJImDoF7DBNnYuGrK8+5p5DX5GKSI+fxwz9s6SOK/Mdtf4xAdwbUKuniGTWgxOokIbVie5hT65x7Hs4nWOxFR+Q2tjDnd1Ron43jGiIlA9GTMOTmOkWSt0gT9Fx0zsMmKQEgZo=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DM4PR10MB6814.namprd10.prod.outlook.com (2603:10b6:8:10a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Tue, 26 Aug
 2025 15:00:58 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.9052.017; Tue, 26 Aug 2025
 15:00:58 +0000
Message-ID: <a4ad132d-ffb7-465d-b19a-4c5e0c0665fa@oracle.com>
Date: Tue, 26 Aug 2025 20:30:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v4, net-next 3/9] bng_en: Introduce VNIC
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
        vsrama-krishna.nemani@broadcom.com,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
References: <20250826164412.220565-1-bhargava.marreddy@broadcom.com>
 <20250826164412.220565-4-bhargava.marreddy@broadcom.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250826164412.220565-4-bhargava.marreddy@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::17) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DM4PR10MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 08adc1fe-1d56-48ed-cedd-08dde4b15d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFE5bHNOdWJZaDZVbnRYZTl3cDdRbEtrK1ZKNXNHSndyR2dWSkZRYldyTFZY?=
 =?utf-8?B?aWl1WkNOc3pvSzd0NEsxRkhzeHZDbjZYK0tzNXlNQTA2OXdZZHhWcm5EeXMv?=
 =?utf-8?B?cXlGYzdNVlN2dFdIRlE3M0sxTHZhdE1qOGV0b2xKek5qTUQvSEdwR2ZuUWNu?=
 =?utf-8?B?TTdFU2Q0MGJsOEk0WmVyejN3ZGdOU3BnTk1HanA2RXFBQjcybjdDZWM4bTVz?=
 =?utf-8?B?NTh3ZUtWWVBxa2JZSitDZHMwRFpvOVA0UmF1Slg2ZlFZcGdBbitxd0cyaWR0?=
 =?utf-8?B?TkpndUFwVEIwT0NXVStuenhwTFpZeGRDZThmeDQ3b1R4cHg4ZlNHWnBRVUNJ?=
 =?utf-8?B?WlZJSFdpaEVWYTBraE5PdlJUejRmdXJ1eStmcysybytyVXFNcC9zcHRYU0h3?=
 =?utf-8?B?OStYMldab1I1bWJQdzEvVU42YnUvT1BtekZWQUk5TEljK1B1UmdMdEtuMnJm?=
 =?utf-8?B?Z3BDRUIxMkkrS1ZTQTE2Y3B2am9oWnNjeTBZamRybyt5bUhEWTRuRngzb3Vu?=
 =?utf-8?B?d3pTdkRsb0llQlRJSngzNnBlNmhxMkV3MEpvT0FDS0c4QVpmU1A2MlJNUEo1?=
 =?utf-8?B?eUNzbzVkL3plQ2JJYmYxVGFYdWNxSk81OXkycVZUdUtjMlkzY1RkS2JLYTkz?=
 =?utf-8?B?SjBxWThZYmFWOXhuRU5uRk5LYjIwT1BPbjZGWG9EN1l0NzZmWTVSZnpJeFo1?=
 =?utf-8?B?dGVTd2NKcVhKQjNmajlNcWtjK1JuenU0ZENsckVzQzdLSzZGemdCM21HOUUr?=
 =?utf-8?B?aEtIN2NsSmQ3OC83enZqRG9wOUFwNjd2cGQ4b3orRkc5RzcvaHRuUEw2dXVD?=
 =?utf-8?B?NDZxTXdmdS9vMjhlc0VJK3dtNHpIdDBXeXY5ZG1QRXltdEJNbWpwSVNjZkZi?=
 =?utf-8?B?NmJXcjE1N0FKd2pOQWJHNHdpM2x3SjkxYWJBd0RDaUU1R0FWZ0pXYjgyTy9n?=
 =?utf-8?B?KzJsT3JPNHE3dzVQV2xIU1lONUYxNnZCYUVhNTBWKzlKc2Zrb2QwZDAwdzhq?=
 =?utf-8?B?cGx6VnN5aUdlWXBQVkFqWENLSnZZaytLSlpjQ2JxMHBuUTVqZm1wOXlCMmE3?=
 =?utf-8?B?ZW1QTm1wZlRkcVdzUi81cU12RXNYVXhyb3ZmUTlTTEl1VTd3bHFtU1JHeUxC?=
 =?utf-8?B?RFo2dVhnb3lHM1M0TVhXV1RDazdIdDgwYmZybTdGL3pvUlVwd2JHbkVkUDdM?=
 =?utf-8?B?M1RqTUEvNmJscHZZMUlyYitYSHh1bzFxbVdIVEpqb2JpOGJoYlNrdGkrZ1RC?=
 =?utf-8?B?dHJWb2VXV2JreTYzUGVuU0Q3YW1DODhjampHNzhsSVNkQmxmTHE0a3IxQk1Z?=
 =?utf-8?B?ck9tOWFYTlNUZXA2NkUvOTVwUzdsL1l5N3JBdFVleUlVWVUvTGdDdlNncHdo?=
 =?utf-8?B?OFljSkVtaXJ5UURlUGVzWXE0SDVNVGgwbkZydzI3V2U0VEhhKytzMUZ4L0FL?=
 =?utf-8?B?Y0ZGU092cjdxMjBnTWdGaUVGU25YeVBzQXRkRHdXR0RpS1krZnpMbFFiczFJ?=
 =?utf-8?B?Mlp5Zi8yQnVVajNmYnhpSDBaMktENFF3OFpBYWdQVFh0Um0vMUNFdSthMVpj?=
 =?utf-8?B?bnN5N2pKeFZjMVFHVUI0SklZQ3dZV2Z0VGFQT2dwa2RNc1Z5RzNSTmpsclpw?=
 =?utf-8?B?VzhYWDkzRG1IZ0dGOGhYTnplK3NRVTJjMEFqT3Fvb3JhT1lRRDlRUHFwOGM0?=
 =?utf-8?B?dVZmNGdOdVpxek4xUHNodklWTHBScmtzU2xZd1QrTHNadDcrS3luaW50Q2ZB?=
 =?utf-8?B?T1hoaHpnVGlHSjVtOFBCMHpXNFZtUEhIc3h2Sm1PZXUxUDlYbTlpV09HNFNL?=
 =?utf-8?B?RXV3TTd6SnFOWFlCTnNyTVRPZWZOdFVGNWszU3JOVG9heE1ObVR2SWp2UEda?=
 =?utf-8?B?alM0eW5KV0hIMk0vVHlSd2RERVorVWh3a1BkM29DeGIvY29sN2s2MExPalN6?=
 =?utf-8?Q?ct5gjsKbm3g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHhZelZsdk9yeHZNYURpaUw5dWFVTUo0YjZaNjhtc1E0L0kxSUJzK1RYc1lR?=
 =?utf-8?B?L0RZMEFQL2dIbWRRWFRROHFtK3NUVTViMmJhbnJHZEpFRnhpaEFMVHZLUTZy?=
 =?utf-8?B?T0V4cS9RNTlpVVpYMDZPd1BuN1Z0UDVTa3JlWE91QzFWRWdhZHp4YitUa1RQ?=
 =?utf-8?B?aFdoR1NvTjVDbFhOVThFdDVvUy84NTEzQXVqelBKZ0h1NEJKVXpadDl3QkhK?=
 =?utf-8?B?bDB1dEtjQTZZejdFaW9EeDZhVVduM3FZaEcwUFBCbXU1RERnNmhZcXovaUxF?=
 =?utf-8?B?QVdkRHl1MkxJSm1IZXhjZG5tbU55T1VlaVh2L3dLVy9sR01yM2tyeTNaZGRP?=
 =?utf-8?B?YTRBallxbGJYR3ZOSW5yN21YSmZ3OFJGdWpVYkl2cks4VUxDZ1RoY3BrcUx4?=
 =?utf-8?B?bnhrQllkV3RJcG9jUHNSSEt1Sk5vUjBPNCtFdVZqSUxLNTBCUWorR3FxSHNK?=
 =?utf-8?B?eGJKVE9JOThFR01xMDVMd0VvMmJ1eXZxdmtqMEFQWUhPZCswMnRqNEYzT1VL?=
 =?utf-8?B?YmMzTmQ1N3lrekpweEZXOEk1ZjVBVVdtR0xRYkdab2RFWTM1UHc3czBrUkkv?=
 =?utf-8?B?TVQ2VEhGWnB0eFF6Y1k3cE5CaFNGZGltL2Z2UWdrWjJMSlNHamVBRVBCeTZX?=
 =?utf-8?B?SUl2cVZyaUUrWENCUytoVVd4TThNL3YrUmRadGZiWlJpRFNSQ2RleTZQZTFo?=
 =?utf-8?B?VEZvZXhxRml2T1BzK09zSktwamR2Qk9kVS9FR2dDSUVjVW9NZnlMQlRFSjMr?=
 =?utf-8?B?akJ2WlFVSTBnNkxodDFlODRWUUFCVjNuQkZVN2dld2ptQWhucXR0MkRadE9u?=
 =?utf-8?B?bll2WVVHWGg3NUJCbEU4dXRpTGpic0kzemMycmNzdzRMZGVERWUxQm9uaXJJ?=
 =?utf-8?B?Mnp6SFcrd2NpMy9UMm5NYStlcGJwbUdtOGJscmYwU29hekdoT3MxaEtNa01r?=
 =?utf-8?B?eXNkOURkRW8wSXBxSllod1VxVzVOUkJKYW01SENkRnh4ZGs0SGptS0pRdXBZ?=
 =?utf-8?B?MktnRHplb3pOYWlnUHBBT1V3c2VRbU5xa0ZuSVhxT2hIZ1ZiU3B3TE1XUzlO?=
 =?utf-8?B?QzBzUU9sSWxGaG1kdHp4SHo5SVB3TXBzQzQveDFPbzFVcFl5aGpKM1NXTHpZ?=
 =?utf-8?B?c25QRk1sd1ArcW5GNU1jTjJQOHVwOGZPM2p5RTFDVUYxVDY2b2lla2ZzQ2J0?=
 =?utf-8?B?d0YxY0taMTZLZWJJUmROeDYydVJoZ2IzbHNKYSt1bzM1anVqZDBSc1AzQTI1?=
 =?utf-8?B?U1FJWEhINFNMdlFVT2FUcnlNdVRhdVdVcHFWUUtFcFFjWnNweEZFOFVzb1NS?=
 =?utf-8?B?VlQxTHlUdDkrSXQzWW4rNGcyTEZsRHNSQXZwUWNkMmhFVmpRQng0dW9Tcld4?=
 =?utf-8?B?SkhMci83YlhlTUhwK2RKMkZkRGs2VjlnWEhKWnlhMU9zY3NBTnlxcm83a0M2?=
 =?utf-8?B?cXAxNjlKNDhmSi9NVkxRdVA2d3VXTGlhTTlPOGptZHc3RUdYQWFRUGlBTnNy?=
 =?utf-8?B?WEdDM3B2aklpdkNWZzkvMEoxQ1hUUHl0WHFMRk01TEVEZjlzWm5VVk83ZWRZ?=
 =?utf-8?B?QlpIc0JxWEx3S1dNdkNDT3pPZGp6SGZQb2g5Q2lFdmdGQXJ1cmJ4WG1COVFl?=
 =?utf-8?B?NEtBZXNUMGowUmdONG80cDF2UDJHWGdiMzc2TTJtSzN0d0ZKMWJVcXYyZE10?=
 =?utf-8?B?amJodVVmalowdE1uN1lSR1JRSDRhZlNSZU42NXZXc0R5aWx1Ymo0cy84c3li?=
 =?utf-8?B?ZEVob3pYVTNLNEJWNVZKaTU3eGwwTW1KT0F2cEdtSDJsRFFjR0VFR2xqYVZl?=
 =?utf-8?B?Q09zc05pN3huZDZpYzlDd3dBbHZ3WlYycnlFTkIwQUp2Z0FvblE1eURFUGZw?=
 =?utf-8?B?Q3FLd1Zna1h6blY3YUZ3V1RYQ3hLcTVYSCtVU000UjJuSFUrMG0zUFRhNHNQ?=
 =?utf-8?B?MWtiUk1vYkVIMS9jY0daWldXU1BuS0ZhYjFwV24xVjlPaXRLVEVHMHcySHNI?=
 =?utf-8?B?bVl3QmEzOEpQc2M2QngyY1Y3T09SdzlZSEladFpCRjJSK2hZeFBMc1NuTUJT?=
 =?utf-8?B?Q2NickFJbHZkWkhMM1MzcjBMcXBOSzIzVGFzQ1ErY1NvS2E5eVhzKzlTWGpx?=
 =?utf-8?B?c1gzWG1acWpRMnNkMjM0QS9sSjZGYlcyTGxJOWQ4elJLdytaMnFJazNLVUlC?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gTsaiDocqBvOy0w3dF1pUzDnOKYsA7tcKDoSRD90ABJODgrPjiqMJgaCQiPemS5/w0KAQyb/8j3th6SLbyclnT3n7/vnKsYwulEilquLrldK2KtBDYCfJ51skDY1MEQivcrbLAslcnNJ0o9YPpJD6+SE+fa+Qix/MrAik6jqMMspSpLAl6uK1BDoeIq8OiZdXbnm7oQWoWIvytiGrr0rBthj8uPhp5yLdmwYJGwZjpOjNJoLtN0walmIMbRfXKO3cyQdwY68D0HBuqmY/3TdLuu2jhSMQh1CIqrWxM0ZG8u3Ix7un7TGeALssas5H0DlnTBpDfRbQjweVTPMv7nCD3JbhDdpFVPkS0zjLmRyJq3tnEO+Cj/NPbPN37Y5lnG+8eeRTqq5ZDohRbpBQQZUKgKJe6+UOyV4Wu5eKSmXIhZeD4a2Rvy4YxDiEoJNsCUNr/edlDg5BWWA7x6hwKNXUd6r1/59gSirW8ccuaunoynyGfuKq84pBlY1vab8G1XsDeE7UsfOJu2GPLn64kQjnjIe0DGHkwM/ZQSTOzgItv7m1xFxQpGJ3YJ12FJ3TZ0V3i1uWG5zwMlu8+dx8MjeXL/XRKbgn8COgSbGznJZE6U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08adc1fe-1d56-48ed-cedd-08dde4b15d61
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 15:00:58.6538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Evxalfd5RJDspzVR03KNrwBcBaYuQ9LIpZYygIv4eBXpqM/sMPTOfMRmDM11+g9v1cXlVYmkjcOoADe/KSipkNJ5bmRKP7KtUUOSmvMfz5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=877 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508260132
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxOCBTYWx0ZWRfXyHXSHqawvuxC
 dvENcgfNcVOlXSovFENuHbpXhlczZaLZzS06fAHH6pWV2GNDRdi0Qe+oBPi64Hfisys/me+Y02R
 EoC+6sISh8a6m9RMs/aQ91QGDdvzsZWFwcEN36rQIgCl2t4NVpcIChrse84zNiFUPsuP4G2PRID
 Fwcn0737V+8YDRytAzJteQoV/8+YjCgXSdVuPq8k5Nx+uT7AfegKapLVn9wSo+3t3ksUFkccsBj
 msrndzEaHpffaUv0VxmeYIH92L7ueV0xmEU+cGLva3I45vLJ3YXgGtOqRA4j5IUgs4G2qihbfia
 iumfUUl+RYE16VD0BYXN9ChYFlD+tmfDn8fe+VQbDVoJK8xhg7ePqVtvjECT5nNhbgyb6BHh1+7
 uw2e3o6e
X-Proofpoint-GUID: SwRQGVjAX5xLUsku1zEZa5qvJq6ghGTI
X-Authority-Analysis: v=2.4 cv=IZWHWXqa c=1 sm=1 tr=0 ts=68adcc32 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=sngCCqdTzeqPtHC_mvoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: SwRQGVjAX5xLUsku1zEZa5qvJq6ghGTI



On 8/26/2025 10:14 PM, Bhargava Marreddy wrote:
> +		/* Allocate rss table and hash key */
> +		size = L1_CACHE_ALIGN(HW_HASH_INDEX_SIZE * sizeof(u16));
> +		size = L1_CACHE_ALIGN(BNGE_MAX_RSS_TABLE_SIZE);
> +
> +		vnic->rss_table_size = size + HW_HASH_KEY_SIZE;
> +		vnic->rss_table = dma_alloc_coherent(bd->dev,
> +						     vnic->rss_table_size,
> +						     &vnic->rss_table_dma_addr,
> +						     GFP_KERNEL);

@size, first calculation is overwritten by the second.

Thanks,
Alok

