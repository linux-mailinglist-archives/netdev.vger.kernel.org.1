Return-Path: <netdev+bounces-285678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFCRGoiJ/WnWfgAAu9opvQ
	(envelope-from <netdev+bounces-285678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 08:58:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F664F2AE4
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 08:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC8763030105
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 06:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7BF37BE71;
	Fri,  8 May 2026 06:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="mI5n03QQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30A53793BD;
	Fri,  8 May 2026 06:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223418; cv=fail; b=gsJTZs7lBJYQZtclX9bBQaA0+hJnDBVyuNjHctvTNzFkbjniSOFWIDhUoscESWi5A1olBPHAK5uXQtVrt/G+IJf2vrnqlNPeeQ9TvFMtSZZ0KZHpvgUEmNZj3HiwIWIQrJWwT8oHx9rg1C6f3lga/IiGGaBfIPF7uuMAy24H3AE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223418; c=relaxed/simple;
	bh=JHIJ56QhPWVW+8NggCb11VV0qPLbQhWUg3Cwhix2klQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xn/vIArL5g+eyy7xKKPv9yecuCgBSFim0tjycWOldbbh7yP6OFeOQBB5p6FwVW50tc5nbGhBWmtiglnEDNDaeyFH/9s/T8PA8HIn+nPUJthN/ISq5fNOKKYgxhXAq3Q1vucOUHzJEb5nN7zZ2MYPDmqG7O25ekFTBKFdmKcaNWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=mI5n03QQ; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6484DHZM2850900;
	Thu, 7 May 2026 23:56:22 -0700
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11020117.outbound.protection.outlook.com [52.101.193.117])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e0wy2a5mu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 23:56:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uH56Uz/wWLwjCsnJ5oO0w5AymgJ95VVu6cgMdzfvHGFTNhZ4otPKYneTMCJdYCnlzar0L8zKhReYW6YBLeTrCQfFD0OJg1FIl984u2VdIw1zJPURVGuTwZu+RfNVkkJNnC/5UxR+eNvy9R+Cu0CVPdt457jrrimLxuvH0h9iI9rin3J2Yo4MtL6dMDOGDzUdMEBVqEMaT1PKBDyRXv/jgnC6o12tV8bYFGZIfvxGN3Cyyjh6YZm5nIkbx8uVF9zOaoToShRLmldDhUbr1xu3BIxwoHfgS6/jJGJ4qbwYBfmvjAadgupV7DEES+vukNLWUAxYZ5xMyTxUtGyw9mVuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHIJ56QhPWVW+8NggCb11VV0qPLbQhWUg3Cwhix2klQ=;
 b=DtXwbX+8VdgzCUq0gxXfa1Bqz4+mCBXAiJrC6vLuonDtFGPv5QOjz+uyAph8FuDfygi8gjFd3guPx2Yb49DoHZteG9pd0XsKZwPXeIBfhfJ3LBckkncz+hC9e053xnHQYu3Q0gcdKJ/jjr9DHdX9mUz0AlwJOEAcufrlcCVgDAllAn/UYFovFRO610f27lzdASTnDFqi4pc1xh7MrsYKJdnKhqjcqPaK7qeKInT5f95UrQHbXWWEmt/fenZaBH9nqHEpWUp1HAqesWf6df9vrojfVgRGO/trTdVENYWLYqGU4XxYRJfpYHd1A41wHmMWFijZUmL1SJVSWrdqbSkhcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHIJ56QhPWVW+8NggCb11VV0qPLbQhWUg3Cwhix2klQ=;
 b=mI5n03QQLdRv6uExwfAwKSlFRkzgz22KVBCx7iSFkmausPJuig2SZIKmRXqOk7tC19EdojTw0ti3IKD7CtVw5GNJO16iRnv4mwV9fUwrmDyqD9u/OpgfH6McQgp0HDkzuTKXOJKImrTL7XwKaveNeZ2g07pkB6MiCXroiDBDM10=
Received: from SA1PR18MB4600.namprd18.prod.outlook.com (2603:10b6:806:1d3::7)
 by BY1PR18MB5922.namprd18.prod.outlook.com (2603:10b6:a03:4b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 06:56:19 +0000
Received: from SA1PR18MB4600.namprd18.prod.outlook.com
 ([fe80::a9ff:1d54:811d:cff9]) by SA1PR18MB4600.namprd18.prod.outlook.com
 ([fe80::a9ff:1d54:811d:cff9%5]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 06:56:19 +0000
From: "Sukhdeep Soni [C]" <sukhdeeps@marvell.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Igor Russkikh <irusskikh@marvell.com>,
        Egor Pomozov
	<epomozov@marvell.com>,
        "richardcochran@gmail.com"
	<richardcochran@gmail.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next 6/9] net: atlantic: implement
 AQC113 L2/L3/L4 RX filter management filter management management
Thread-Topic: [EXTERNAL] Re: [PATCH net-next 6/9] net: atlantic: implement
 AQC113 L2/L3/L4 RX filter management filter management management
Thread-Index: AQHc3WB4zfhdLaOKp0CILdQKyR7v4rYBmLeAgADX2rA=
Date: Fri, 8 May 2026 06:56:19 +0000
Message-ID:
 <SA1PR18MB4600C02852830E4B08FAD0EDBA3D2@SA1PR18MB4600.namprd18.prod.outlook.com>
References: <20260506135706.2834-1-sukhdeeps@marvell.com>
 <20260506135706.2834-7-sukhdeeps@marvell.com>
 <2a15199c-d48f-4034-a907-6efa883d5d99@linux.dev>
In-Reply-To: <2a15199c-d48f-4034-a907-6efa883d5d99@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4600:EE_|BY1PR18MB5922:EE_
x-ms-office365-filtering-correlation-id: 908b2224-3c4b-48a7-139b-08deaccee82e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|38070700021|56012099003|22082099003|3023799003;
x-microsoft-antispam-message-info:
 XZ6AGBWeKO2GPXNBMoOsdubC87fT33EEQheP9KMLnM0T7GLSY45oPIm3uRrFomKHOK8aBhC8N/Yb1srTTPR/r0Vz2uTluEL++93einO8+coYa2DnlptwGWhYQ+orZJDYxhq5D+6nr9C3Zpgd8uow49IlxBTQIlDS5uXUL370lTSdV1GKZvVXs0GIabeHGyZyGzqoq1D8phlyp9YLdDafvg/oqHS6fugsRjd84SA06dxfD46gbJVYVp54nSa7eEnASLqmYQfS6Olo7TZMedFTodexrJLzk6/+BHo4sSwrVLX8WFYn1qqaBeCxBOSWc1ced1VOAgjaKXIDdvH5p/OL9OGnRvsQT2DSXMtSD15zgH3ntkrPVX4Ala/UsaGBAedD0XFyuovaGOg5kD6+NuIy27ZyKk4UcpMnaTbZG5DJqm/p2pwZq2x07ZuEr5NZee3hRfeUF/HwcPnATp6zkk9HmeaJxBgYFJKp569+Z7Wco14UBynw6P80+PuWTVvXp175yHfqMxfCTMJtQOTFDt3WXpHHYRhNdQt69vgwuxp4sgiNNxcmuHfpgJObUG2lCX9SdIBMXQCoiDeXwMhtyNyDlw+eJQ30BkZECxtrkv231xHzuW4pd4PLdnfXM5BDPQzBgPZrouQSMu79vhedrVaxBY00VWuwaNSZ39ZW1w7YUkxAAILJEqHuiRuIx5y2kYQpe0ivw9rG7XnP74hl62tNxcLrWvPZa5UvWt8AbZhAt0LzfRmiR3HVKj6I+j3xFN7t
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4600.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(38070700021)(56012099003)(22082099003)(3023799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1RMV2ZGMkxtY0xJeE5VYkwwVmpXZ2Q2UjZXYkpDaUFQMmU1TGZDbWNkVU1J?=
 =?utf-8?B?SkgxZzRyOWZNL3ZSd2JtWDNZZ1pDUEJ6Yjd2QUJGQXVSS2VDSlNaN0ZldXAr?=
 =?utf-8?B?ZUpHNmJMcDNLdzNrbko1MUxLaEpBSWVzMGFXbVFXTFJyYm5FSkhPKzlUSEtC?=
 =?utf-8?B?M1p0L1N0REs3OXpzUzNsd0ZDU01qK1p2eklWamUrRVIrQUpIdDJQdXk2MENW?=
 =?utf-8?B?b2l3N2lFNDVPV3BtTzFzYjNFMnJ2WStaTzdzS3lIblhkYk8rbEdtaDNQRkFt?=
 =?utf-8?B?M1BWR2IrZElvMUFsQ1FobmpaWE00S3F2NzNYK09STGlMcmw1U1JBUHVLZmt6?=
 =?utf-8?B?d1hibk0rWmNuSkFLUmppYjh1Z05QVzE2UEZpek9QOURSMGNaT3VIWngydnRN?=
 =?utf-8?B?ZTllMi8rN2F5ZkdWRldvSitkT0ZxcHdXeEVIVnV5YUNCMkFtdEg0aWhaQlFo?=
 =?utf-8?B?S1JWTGhEWE5uS1kzK2NZMTBGd2NyeFd4R2Q0NlVaQjFCblozbThaeTN0VmJS?=
 =?utf-8?B?ME9saFI0cmFhRENFS1dqSkZ0MXd3b3Mxd3NOei9ITHlpWmt5MXRMbmxNMUNw?=
 =?utf-8?B?UkxYNXpOQzFOZGI0dlFPWVNMa3VnU3hoODRXcmJiVEdlTWUwRWRPU0Q0YzlB?=
 =?utf-8?B?dXFJRHJKeU5UK3hHM00wSDI3am5qVkdJTGU2R1BQZE9kaWFvUTFvQmtYWlIz?=
 =?utf-8?B?MjA3SWpDWitVRnBwc290UlZ1dytnRUpPY2lMNU1QZVBMSkE4TjdyNjh4VnNW?=
 =?utf-8?B?SWszS1kreER2bWVJN1hsbDhUVjVkQnE3OG1TeXBUTXhiTUd0T3Vvb21lNmpt?=
 =?utf-8?B?VnFUeVNvZ2FnYlJxNUIrYUQwQTNSUE0rNnRtSzBLeHpqdTN3UExCWkVmN2or?=
 =?utf-8?B?NU1PcmtCR2hoTzlkVjVqS01LQ0xqNXErUEVwMGJXWVZLdVNQYVBNVGoxRUpm?=
 =?utf-8?B?VXdZUy9FVnk3ODF5Um4yS0NzV0svWmtBRmpkdDEwRENZOVNraitEVnYvMzcz?=
 =?utf-8?B?L3RFVlIxaFc4L2pSc05NN1VJU0NoZG5BcnpxY09DSWdCd1pUL21udG9JeWF4?=
 =?utf-8?B?MnkyMU5yeWtraTRZankvTkhaOEZKQVc5blB0N1hibnNkNzdmcGJ4NHNNbzNX?=
 =?utf-8?B?U29zKzhnK1BnV1J3UTZzcXFYNmhBVHR4UXc3N1MwSThFL1VTcjAzdWRqRy9o?=
 =?utf-8?B?M1ZEWmNwVXV4cXhlYThtZkVCQUk4WFRzVzRWblAwRlUwTE5BM3hzWUhxQ3hE?=
 =?utf-8?B?S1ZHN3FYbEVqcktvOWpRY0tYUWpUbDFiSm5IYXU2ZmVjQVhoNmc0M0tyN0ZK?=
 =?utf-8?B?TmFKWG5XS1duVDVVdTBQVTMrY1E4WGxZMnNNaVByd1VGdGFHMmdlN3ZVUjhD?=
 =?utf-8?B?c09TdXBrVkxZU09LL1pwMU45VnlraUF4eVhUY2hCbXN1Uko4T2xtK3lXdS9j?=
 =?utf-8?B?QnZ6R3NCRE0rT0ZGcEFFVjVwKzlpRWRMOTVqMC96dG1rbEJYQ2h3YWJUN1I1?=
 =?utf-8?B?Zm5vVEVtNytUNkQ3NW9VZFdISEtYMUdqem0vK3pENnNWeWZXTmQxSWVVNmZx?=
 =?utf-8?B?eUg3Z0QyeEpnY2p1VXYzVU80aXJhL3Z2MDFFckpGcHNQaWcyN1VHd2sxZlF2?=
 =?utf-8?B?dVhycTVyd09aZEhaaGZXbGEvbXo1cGZvRzBzeVU0VE82N1ByeGNZSjRJRjJi?=
 =?utf-8?B?SThRdFFtSUYzb3czcVpiMU1WU1htQ3UwbHZ3YmpLTVBjTkFPMlZUd2xBRnVN?=
 =?utf-8?B?NGtRblBaRmhLdzJNV2k2OW5oNGRacm9DWmthajBUcG9IUHpmNWdXM2N6ZUFM?=
 =?utf-8?B?Ump5Y25ZOVBxb2k3aXRQbjFmTGZUU1VwR1hlVFVOZFUzYWkvSUZhcUhGMG5S?=
 =?utf-8?B?dS85bmFnSWxjVVBYbjRxR3NqbGhwRCtUS21nTGY0L1RrYzloRmZSZStKUnVX?=
 =?utf-8?B?RGFkdm93MXh6dGNDVjFzeTJwOVZjUTQ1aU9CS3ZmQjFWSzdoOVUzSUxqOGRz?=
 =?utf-8?B?dHZjUmVoWDV0S1EzUU5uQWxRYWFyVGdKaDlYVDVQRExVd0FQd2ZxZFFCeTdE?=
 =?utf-8?B?UjNFZHh5Wmd5cmxEU1hUajhsekhOc2JHbEZZbnV1WE9NNXVyYUdsUDhmaEps?=
 =?utf-8?B?RTZ4UTYvRVpqRjNiSWR5NDJxS0crU2pxNVRtbWM0enZFZGhXdW1pS3NLMmJj?=
 =?utf-8?B?WUdFdDAxR21CQU92UEFmd3lqaTdrc2hyWkxvK0ZJbnoxdVlrU0RtM0JlMUFy?=
 =?utf-8?B?RU5sZHpPYXUxTk1oZFVtNU10T3dJWmxibk5LMFZEeGNWOHhDZ2FDcjZHMVVp?=
 =?utf-8?Q?as1tqlKgJdj4YRHy2H?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	caBi6/GN4VwX4RmGRw6NRi/EfzgtcrDdDZFsZJw24WZfHVrrRVq80ilRdQHJ9+QweTtkQ1K0/48Wr9ySLlyDHzqCZ50JJIkCBdMQny7QRvKHTgXDSH+DYeryoOszo9iTs70CysJkU8iqijUGk7SFq5QN8W3DZ9+aGop6SzWmEEFWQ480/cIMnKvQU5ERRLFtqfrR2EpFjmhrFSrJbornQshDnRo/kI3q9YiyccVcM+g+9QF7fZdq/UiD+ZFVzCP8iLrd1N63dV4E9zQuhJbtYMavEBC2gz4QD4pGyR4zClLAdfzikyTvCkpyu/hGgWrhIEY2t/bNKVKknEAZJ01wow==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4600.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 908b2224-3c4b-48a7-139b-08deaccee82e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 06:56:19.1684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7c0Qw/VgStfvoBLrhm20wBucQJjrkAkdPiJwlIw77LzCrA7dVHk+AkmPwbT9dd0CZZ0qRgo0HJeR/lLsob3x6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB5922
X-Proofpoint-ORIG-GUID: EKUPjs8dJIGc85-qc4YzYIqsWQTktvjP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDA2NyBTYWx0ZWRfX+gty+zAKQosu
 uQHat1bLMFdedL9IetnF+XGOKSsGRRSF8NXlkMg5xwXHHTMGUD9RGbYICnzRzZm7RZOYydzfB00
 9kKMc8GIGW08ZhZZF+LR4pBGKgnHNwcLPd4lpVbg84uimsxKHIt1IrOUx1799E8FgqHmbH/SScC
 iyJiL5taXNB8KXG/Ys7lkUfPC3FqM5G/HAjw7XvUBcyQg6WWC/pP+VaI5tRRzuNNSfcfgoLTj1r
 hGN6g36/cb4NqRnCU1U7K2HHJmLoFrqVcbV00ZHYnNXhieS1iTH+xBqHUMwtHkSZwqtnbwCR+SL
 qmVuWi61nsmQKCYGwGpB/OeJXol2gO7ltLNudX/xbGjr7N039sKOJ4kMaVrTuOw3y1yeWx7mhII
 7ij2h9CmOmPk8Dp2ieKG5a7i3x6YQCrgy/zBIA1DC51jpPIKoVYpRKoY5ZYMTRCQjn9jyYrhIno
 lHxgGBAVkCb+XT5XZpw==
X-Proofpoint-GUID: EKUPjs8dJIGc85-qc4YzYIqsWQTktvjP
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=69fd8916 cx=c_pps
 a=AhzfF/YxCie0pcxRiAEGiw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8
 a=7nw3L2cGkLIfurJT5nMA:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Rspamd-Queue-Id: C2F664F2AE4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285678-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SA1PR18MB4600.namprd18.prod.outlook.com:mid];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[marvell.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

T24gIDA2IE1heSAyMDI2LCBWYWRpbSBGZWRvcmVua28gd3JvdGU6DQo+IE9uIDA2LzA1LzIwMjYg
MTQ6NTcsIHN1a2hkZWVwc0BtYXJ2ZWxsLmNvbSB3cm90ZToNCj4gRnJvbTogU3VraGRlZXAgU2lu
Z2ggPHN1a2hkZWVwc0BtYXJ2ZWxsLmNvbT4NCj4gDQo+IEltcGxlbWVudCBjb21wbGV0ZSBSWCBm
aWx0ZXIgbWFuYWdlbWVudCBmb3IgQVFDMTEzIGhhcmR3YXJlOg0KPiANCj4gLSBBZGQgdGFnLWJh
c2VkIGZpbHRlciBwb2xpY3kgd2l0aCByZWZlcmVuY2UtY291bnRlZCBzaGFyaW5nLCBhbGxvd2lu
Zw0KPiAgICBtdWx0aXBsZSBmaWx0ZXIgcnVsZXMgdG8gc2hhcmUgdGhlIHNhbWUgTDMgb3IgTDQg
aGFyZHdhcmUgZmlsdGVyDQo+ICAgIHdoZW4gdGhlaXIgbWF0Y2ggY3JpdGVyaWEgYXJlIGlkZW50
aWNhbC4NCj4gLSBJbXBsZW1lbnQgTDMgKElQdjQvSVB2NiBzb3VyY2UvZGVzdGluYXRpb24gYWRk
cmVzcyBhbmQgcHJvdG9jb2wpDQo+ICAgIGZpbHRlciBmaW5kLCBnZXQgKHByb2dyYW0gSFcgYW5k
IGluY3JlbWVudCByZWZjb3VudCksIGFuZCBwdXQNCj4gICAgKGRlY3JlbWVudCByZWZjb3VudCBh
bmQgY2xlYXIgSFcgd2hlbiBsYXN0IHVzZXIgcmVsZWFzZXMpLg0KPiAtIEltcGxlbWVudCBMNCAo
VENQL1VEUC9TQ1RQIHNvdXJjZS9kZXN0aW5hdGlvbiBwb3J0KSBmaWx0ZXINCj4gICAgbWFuYWdl
bWVudCB3aXRoIHRoZSBzYW1lIGZpbmQvZ2V0L3B1dCBwYXR0ZXJuLg0KPiAtIEFkZCBjb21iaW5l
ZCBMM0w0IGZpbHRlciBjb25maWd1cmF0aW9uIHRoYXQgdHJhbnNsYXRlcyBsZWdhY3kNCj4gICAg
YXFfcnhfZmlsdGVyX2wzbDQgY29tbWFuZHMgaW50byBBUUMxMTMgc2VwYXJhdGUgTDMrTDQgZmls
dGVyDQo+ICAgIHByb2dyYW1taW5nIHdpdGggQWN0aW9uIFJlc29sdmVyIFRhYmxlIChBUlQpIGVu
dHJpZXMuDQo+IC0gQWRkIEwyIGV0aGVydHlwZSBmaWx0ZXIgc2V0L2NsZWFyIHdpdGggdGFnLWJh
c2VkIEFSVCBpbnRlZ3JhdGlvbi4NCj4gLSBBZGQgTUFDIGFkZHJlc3Mgc2V0dXAgdXNpbmcgZmly
bXdhcmUtcHJvdmlkZWQgTDIgZmlsdGVyIGJhc2UgaW5kZXguDQo+IA0KPiBVcGRhdGUgaGFyZHdh
cmUgaW5pdGlhbGl6YXRpb246DQo+IC0gVXNlIGZpcm13YXJlLXJlcG9ydGVkIEFSVCBzZWN0aW9u
IGJhc2UgYW5kIGNvdW50IGluc3RlYWQgb2YNCj4gICAgaGFyZGNvZGVkIDB4RkZGRiBzZWN0aW9u
IGVuYWJsZS4NCj4gLSBFbmFibGUgTDMgdjYvdjQgc2VsZWN0IG1vZGUgZm9yIHNpbXVsdGFuZW91
cyBJUHY0L0lQdjYgZmlsdGVyaW5nLg0KPiAtIEluaXRpYWxpemUgTDNMNCBmaWx0ZXIgaW5kaWNl
cyB0byAtMSBvbiByZXNldC4NCj4gDQo+IFdpcmUgdXAgaHdfZmlsdGVyX2wyX3NldCwgaHdfZmls
dGVyX2wyX2NsZWFyLCBod19maWx0ZXJfbDNsNF9zZXQsDQo+IGh3X3NldF9tYWNfYWRkcmVzcywg
aHdfZ2V0X3ZlcnNpb24sIGFuZCBod19nZXRfcmVncyBpbiBod19hdGwyX29wcy4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFN1a2hkZWVwIFNpbmdoIDxzdWtoZGVlcHNAbWFydmVsbC5jb20+DQo+IC0t
LQ0KPiAgIC4uLi9uZXQvZXRoZXJuZXQvYXF1YW50aWEvYXRsYW50aWMvYXFfaHcuaCAgICB8ICAg
MiArDQo+ICAgLi4uL2FxdWFudGlhL2F0bGFudGljL2h3X2F0bDIvaHdfYXRsMi5jICAgICAgIHwg
NTgyICsrKysrKysrKysrKysrKysrLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgNTgwIGluc2VydGlv
bnMoKyksIDQgZGVsZXRpb25zKC0pDQoNClsuLi5dDQoNCj4gICANCj4gQEAgLTM4MCw2ICs0MjIs
OSBAQCBzdGF0aWMgdm9pZCBod19hdGwyX2h3X2luaXRfbmV3X3J4X2ZpbHRlcnMoc3RydWN0IGFx
X2h3X3MgKnNlbGYpDQo+ICAgew0KPiAgIAl1OCAqcHJpb190Y19tYXAgPSBzZWxmLT5hcV9uaWNf
Y2ZnLT5wcmlvX3RjX21hcDsNCj4gICAJc3RydWN0IGh3X2F0bDJfcHJpdiAqcHJpdiA9IHNlbGYt
PnByaXY7DQo+ICsJdTMyIGFydF9maXJzdF9zZWMsIGFydF9sYXN0X3NlYzsNCj4gKwl1MzIgYXJ0
X3NlY3Rpb25zOw0KPiArCXUzMiBhcnRfbWFzayA9IDA7DQoNCj4gbm8gbmVlZCB0byBpbml0IHZh
cmlhYmxlIHdoaWNoIGlzIG92ZXJ3cml0dGVuIGxhdGVyIC4uLg0KDQpBZ3JlZWQsIHdpbGwgcmVt
b3ZlIGFydF9tYXNrIGluaXRpYWxpemF0aW9uIGluIHYyDQoNCj4gICAJdTE2IGFjdGlvbjsNCj4g
ICAJdTggaW5kZXg7DQo+ICAgCWludCBpOw0KPiBAQCAtMzk0LDkgKzQzOSwxNCBAQCBzdGF0aWMg
dm9pZCBod19hdGwyX2h3X2luaXRfbmV3X3J4X2ZpbHRlcnMoc3RydWN0IGFxX2h3X3MgKnNlbGYp
DQo+ICAgCSAqIFJFQyBlbnRyeSBpcyB1c2VkIGZvciBmdXJ0aGVyIHByb2Nlc3NpbmcuIElmIG11
bHRpcGxlIGVudHJpZXMgbWF0Y2gsDQo+ICAgCSAqIHRoZSBsb3dlc3QgUkVDIGVudHJ5LCBBY3Rp
b24gZmllbGQgd2lsbCBiZSBzZWxlY3RlZC4NCj4gICAJICovDQo+IC0JaHdfYXRsMl9ycGZfYWN0
X3JzbHZyX3NlY3Rpb25fZW5fc2V0KHNlbGYsIDB4RkZGRik7DQo+ICsJYXJ0X2xhc3Rfc2VjID0g
cHJpdi0+YXJ0X2Jhc2VfaW5kZXggLyA4ICsgcHJpdi0+YXJ0X2NvdW50IC8gODsNCj4gKwlhcnRf
Zmlyc3Rfc2VjID0gcHJpdi0+YXJ0X2Jhc2VfaW5kZXggLyA4Ow0KPiArCWFydF9tYXNrID0gKEJJ
VChhcnRfbGFzdF9zZWMpIC0gMSkgLSAoQklUKGFydF9maXJzdF9zZWMpIC0gMSk7DQoNCj4gLi4u
IGhlcmUNCg0KPiArCWFydF9zZWN0aW9ucyA9IGh3X2F0bDJfcnBmX2FjdF9yc2x2cl9zZWN0aW9u
X2VuX2dldChzZWxmKSB8IGFydF9tYXNrOw0KPiArCWh3X2F0bDJfcnBmX2FjdF9yc2x2cl9zZWN0
aW9uX2VuX3NldChzZWxmLCBhcnRfc2VjdGlvbnMpOw0KPiArCWh3X2F0bDJfcnBmX2wzX3Y2X3Y0
X3NlbGVjdF9zZXQoc2VsZiwgMSk7DQo+ICAgCWh3X2F0bDJfcnBmbDJfdWNfZmxyX3RhZ19zZXQo
c2VsZiwgSFdfQVRMMl9SUEZfVEFHX0JBU0VfVUMsDQo+IC0JCQkJICAgICBIV19BVEwyX01BQ19V
Qyk7DQo+ICsJCQkJICAgICBwcml2LT5sMl9maWx0ZXJzX2Jhc2VfaW5kZXgpOw0KPiAgIAlod19h
dGwyX3JwZmwyX2JjX2Zscl90YWdfc2V0KHNlbGYsIEhXX0FUTDJfUlBGX1RBR19CQVNFX1VDKTsN
Cj4gICANCj4gICAJLyogRlcgcmVzZXJ2ZXMgdGhlIGJlZ2lubmluZyBvZiBBUlQsIHRodXMgYWxs
IGRyaXZlciBlbnRyaWVzIG11c3QNCj4gQEAgLTUzMCw2ICs1ODAsMzUgQEAgc3RhdGljIGludCBo
d19hdGwyX2h3X2luaXRfcnhfcGF0aChzdHJ1Y3QgYXFfaHdfcyAqc2VsZikNCj4gICAJcmV0dXJu
IGFxX2h3X2Vycl9mcm9tX2ZsYWdzKHNlbGYpOw0KPiAgIH0NCj4gICANCj4gK3N0YXRpYyBpbnQg
aHdfYXRsMl9od19tYWNfYWRkcl9zZXQoc3RydWN0IGFxX2h3X3MgKnNlbGYsIGNvbnN0IHU4ICpt
YWNfYWRkcikNCj4gK3sNCj4gKwlzdHJ1Y3QgaHdfYXRsMl9wcml2ICpwcml2ID0gc2VsZi0+cHJp
djsNCj4gKwl1MzIgbG9jYXRpb24gPSBwcml2LT5sMl9maWx0ZXJzX2Jhc2VfaW5kZXg7DQo+ICsJ
dW5zaWduZWQgaW50IGggPSAwVTsNCj4gKwl1bnNpZ25lZCBpbnQgbCA9IDBVOw0KPiArCWludCBl
cnIgPSAwOw0KDQo+IGhlcmUgYWdhaW4sIGgsIGwgYW5kIGVyciBhcmUgbm90IHVzZWQgd2l0aCBp
bml0IHZhbHVlcy4NCg0Kd2lsbCByZW1vdmUgaW5pdGlhbGl6YXRpb24gZm9yIGgsIGwgYW5kIGVy
ciBpbiB2Mi4gVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3Lg0KDQo+ICsNCj4gKwlpZiAoIW1hY19h
ZGRyKSB7DQo+ICsJCWVyciA9IC1FSU5WQUw7DQo+ICsJCWdvdG8gZXJyX2V4aXQ7DQo+ICsJfQ0K
PiArCWggPSAobWFjX2FkZHJbMF0gPDwgOCkgfCAobWFjX2FkZHJbMV0pOw0KPiArCWwgPSAobWFj
X2FkZHJbMl0gPDwgMjQpIHwgKG1hY19hZGRyWzNdIDw8IDE2KSB8DQo+ICsJCShtYWNfYWRkcls0
XSA8PCA4KSB8IG1hY19hZGRyWzVdOw0KPiArDQo+ICsJaHdfYXRsX3JwZmwyX3VjX2Zscl9lbl9z
ZXQoc2VsZiwgMFUsIGxvY2F0aW9uKTsNCj4gKwlod19hdGxfcnBmbDJ1bmljYXN0X2Rlc3RfYWRk
cmVzc2xzd19zZXQoc2VsZiwgbCwgbG9jYXRpb24pOw0KPiArCWh3X2F0bF9ycGZsMnVuaWNhc3Rf
ZGVzdF9hZGRyZXNzbXN3X3NldChzZWxmLCBoLCBsb2NhdGlvbik7DQo+ICsJaHdfYXRsX3JwZmwy
dW5pY2FzdF9mbHJfYWN0X3NldChzZWxmLCAxVSwgbG9jYXRpb24pOw0KPiArCWh3X2F0bDJfcnBm
bDJfdWNfZmxyX3RhZ19zZXQoc2VsZiwgSFdfQVRMMl9SUEZfVEFHX0JBU0VfVUMsIGxvY2F0aW9u
KTsNCj4gKwlod19hdGxfcnBmbDJfdWNfZmxyX2VuX3NldChzZWxmLCAxVSwgbG9jYXRpb24pOw0K
PiArDQo+ICsJZXJyID0gYXFfaHdfZXJyX2Zyb21fZmxhZ3Moc2VsZik7DQo+ICsNCj4gK2Vycl9l
eGl0Og0KPiArCXJldHVybiBlcnI7DQo+ICt9DQo+ICsNCj4gICBzdGF0aWMgaW50IGh3X2F0bDJf
aHdfaW5pdChzdHJ1Y3QgYXFfaHdfcyAqc2VsZiwgY29uc3QgdTggKm1hY19hZGRyKQ0KPiAgIHsN
Cj4gICAJc3RhdGljIHUzMiBhcV9od19hdGwyX2lnY3JfdGFibGVfWzRdWzJdID0gew0KDQpbLi4u
XQ0K

