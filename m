Return-Path: <netdev+bounces-256702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJZSFRhGg2nqkgMAu9opvQ
	(envelope-from <netdev+bounces-256702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 14:14:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7058E63F5
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 14:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2ED3300E272
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 13:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5719140759F;
	Wed,  4 Feb 2026 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="arKPhera"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBADF3939C2
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770210836; cv=fail; b=ql5cvcqZRn8AQRCdNHbXPlBfwmPkIcfg7f+5LR6gLKM3s+Ts7pqVS+FvZaNiGYRtjuG5TyCgwPDF9Dtmjx047cr3MTjrOBzJrjnsOXFPwl5dVS1OA1KOGhxBrEnyiW122hSW5tltiNZVJCcj5vrCgNbzgj3ZHFXRq/St70TRVH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770210836; c=relaxed/simple;
	bh=CfUwAGjFlCIKG/BwEXofIuDkdaDdGIi1ucV6gyaRAY4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VW8iWm26NkDK5zvL0aEQNe9HJX0G5HBPpyX+/vr58i90u8/fQVRoqO9X0vDCtITHpw/aXseC/VxaRla0gc7hNrsjblruSRaD2bqgMR0+o3ZE/WAsqR93ENkKRVseTXwF+OTqZkRhrvcE8uzXLVy78oSnfW/ZMXABzH8EefA+Ty4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=arKPhera; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614BdZon3671716;
	Wed, 4 Feb 2026 05:13:34 -0800
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11020088.outbound.protection.outlook.com [52.101.85.88])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4c45e4r574-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Feb 2026 05:13:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRJvC+zmwDnZGjB2O3ODepDC1yu/q4Zf1kuJXX8Bp5+Wa9VKsCJNHK92VCwiFPwrGSXN8Nhl+YA2o4I76wNnBlKilFuBP86hWSZtUedpYo/Z8wNA0/FQqFwftPhxd0hcRk9fyHJxpZE74BF5jpH5FlWp2ewMiuQswAKt8ysJt6UKC/v7o4xIYfIJmSP1t8JZ9SENX9zxDPitb6bdgLuMc05ilDPAJNgPGCMniEwYfwPimuRRMnuA+CW2JKS9/HT8V8vh3LRaWQuWbbDWCuEaTYruXOBufo5GjUJS28Keah0aQzZlpx7TbtEeDmQxi1MTOQ7/nmFo9bsJakBwvTQqAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfUwAGjFlCIKG/BwEXofIuDkdaDdGIi1ucV6gyaRAY4=;
 b=lFfKlUCNmLHzeKRce2DjJv32jennul5qPxdZW8RNDtMCPJrCKhh0crPhKKVYxah2OvkVn0oGOzCvRTODP7Op5WqLNRKniQMxss36ntuM3S4+kgy/x++nwdUDp8GCJH05fh2Tb2Aqyn+t1YRi1TIeJF2ctd149ZwB4lJmXHyOqmQ1RktQbcvyCyrB+Ud7Fjj0ia1d5yVfWkSVYIGcmQkmATOLRTxVdVzg96X5tAQ7rfIvrEKz0fVuXMqTA80Mqbe+reX1NKwCf+Waxm2d27puhBRN7IaQo5cxh07O9z3WeXjzhyQNCEdv9fqOacMhmFkPJfGZL6M46Myay07k/rfD3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfUwAGjFlCIKG/BwEXofIuDkdaDdGIi1ucV6gyaRAY4=;
 b=arKPheraetk5CznA3FN9gzq2dpwCBiNAz/2dpstfJ8AWPhCp6uRFIagrIAYZ6b81I49u1UnmnHqTJk/WrnG6TmVM7BVOPgszNQdFfen73DVpyD3vHVPpuVMsNiand6JXKovhwl7bafGYgdQliUiyMQDv2Otmk9VaMHc94UL393s=
Received: from BL1PR18MB4248.namprd18.prod.outlook.com (2603:10b6:208:311::15)
 by SN7PR18MB3855.namprd18.prod.outlook.com (2603:10b6:806:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 13:13:31 +0000
Received: from BL1PR18MB4248.namprd18.prod.outlook.com
 ([fe80::2f85:8970:a4bf:7404]) by BL1PR18MB4248.namprd18.prod.outlook.com
 ([fe80::2f85:8970:a4bf:7404%4]) with mapi id 15.20.9587.013; Wed, 4 Feb 2026
 13:13:31 +0000
From: Elad Nachman <enachman@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Jonas Gorski <jonas.gorski@gmail.com>,
        Alok Tiwari
	<alok.a.tiwari@oracle.com>,
        "Taras Chornyi [C]" <tchornyi@marvell.com>,
        "Volodymyr Mytnyk [C]" <vmytnyk@marvell.com>,
        Yevhen Orlov
	<yevhen.orlov@plvision.eu>,
        "Vadym Kochan [C]" <vkochan@marvell.com>,
        Taras
 Chornyi <taras.chornyi@plvision.eu>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "alok.a.tiwarilinux@gmail.com" <alok.a.tiwarilinux@gmail.com>
Subject: RE: [EXTERNAL] Re: [PATCH net-next] net: marvell: prestera: fix FEC
 error message for SFP ports
Thread-Topic: [EXTERNAL] Re: [PATCH net-next] net: marvell: prestera: fix FEC
 error message for SFP ports
Thread-Index: AQHclC8b6gt1/8UWSk2yDCWxSDgf/7Vx4JqAgACk/FA=
Date: Wed, 4 Feb 2026 13:13:31 +0000
Message-ID:
 <BL1PR18MB4248EFE8E7D182A5601927E1DB98A@BL1PR18MB4248.namprd18.prod.outlook.com>
References: <20260202052816.28191-1-alok.a.tiwari@oracle.com>
	<795c3351-d65b-4a9a-83dc-b530177b9d28@gmail.com>
 <20260203191517.024dab80@kernel.org>
In-Reply-To: <20260203191517.024dab80@kernel.org>
Accept-Language: en-US, he-IL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR18MB4248:EE_|SN7PR18MB3855:EE_
x-ms-office365-filtering-correlation-id: 4a4dd9f0-ef15-42f1-d4e3-08de63ef31af
x-ld-processed: 70e1fb47-1155-421d-87fc-2e58f638b6e0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RDI4eU9PYkFVMDFtZlNybW1NSlE5a1ViVWtmaXMrWFJ3TnRTMUlUWWF1VjhD?=
 =?utf-8?B?K2I3c0lzakZEdUVpYVh1dHNRc1I3N3VBcGIyNkVVbk1jZlluaDNUaUt2cC9G?=
 =?utf-8?B?UUFVSEU4RnNwdzQ2QzVXRDdNdG1IcCs1aEEzWUoxczNDT1BlbDRHNFpMR3d5?=
 =?utf-8?B?MVVkUStqWjBPWTZoK21YSFhaaTRqT3Q1bXhjUy9wWDhSdi91cmloSTNIbzdk?=
 =?utf-8?B?YVBkM3hnajRocWJIVzVWMEYyZmdCSlpNQlJ0WVZLTjdVSDRvUGhJdnVMd2Zm?=
 =?utf-8?B?UGF3T2ZUWmtwQitldXFkVTZWSzVQQTVTdngzQlhFNDZZV1gvZXg4dU9HeW5u?=
 =?utf-8?B?dnVCa04yVGJQdnVKazMyRjdpUHRNNVRRNVh5blloZnFmM1Y5T3lDVm9RLzd4?=
 =?utf-8?B?UUJHbWxCUE9yYXFIQlJDaVArYWJNb0pseWcvTnpSSzJYSFlRWjF6d1lvY3lo?=
 =?utf-8?B?dHJmRjY2R0NtK0ZIQkcxMk9RTXBaYWVsaVRwK0pJaHZiZkNaUm95WnRMZDFx?=
 =?utf-8?B?OGF1d0pGcTJCYWdDRzRpZVcxRlZOMURKZ3ZOdk9FZmZpQzR2djdRN0lFenJv?=
 =?utf-8?B?Y2szeVpESElGcjdYREk5TE8rWWErVzUyWmxBQnZSWXFTem1HOWp4M1VIUXNT?=
 =?utf-8?B?WlFSNFF0dTR4dnV6QmVKUDMzTXhkLzZpT1YzWmw3cm8yWVRvcXRXRFM1MEtq?=
 =?utf-8?B?NzNzc1FKYkVvSkVkWUo1SUFBcy9GeFdxQXhvRk53T0d4MzFOTkVIN0szNDF5?=
 =?utf-8?B?OVNKVUgxbk16ZWRwM1pCMmR4ajBrMHhRcEdIQjBHc3dkTkpMMlg0d3NiZkU4?=
 =?utf-8?B?V0xaZnFwTmpid290SkhDUnc2NFY5aURpZGo0cEZtQmZwNTBkY0xJWG4yZEM2?=
 =?utf-8?B?NVBoT0I4SUk5Q2V4dXVSa2R2R29aR0pWeFpvSjlzOS9KSmZiTzBUOEJpMkVw?=
 =?utf-8?B?MDUrNU9EcnRVaEZtcEppUWIwM0plY1dUSXlvY3V4WWxPWUJnTnFudy85dFVL?=
 =?utf-8?B?aU1PWjh3MkxzZUIyVUpDRWM2aGZQaGdMaUhadVJWZ2VPWG8vZm5acEd1M2pH?=
 =?utf-8?B?dGRLTmU5V2k4cFY3Z2dhRkwvWGlKOFdQdk9nVjVUb3JiLzJpVkFIbTg4Unkw?=
 =?utf-8?B?eW5xb3dwVGNLOFpBNjZ2LzdhNEN0eStHTm5xVG1QaHpWZFprWHpGSTliaG1F?=
 =?utf-8?B?WjlkNTJxL2x6ZTlUT2VVUGUzNGhQbGFrWk8rdGxZWE43ME5kUW1SOENLTFZz?=
 =?utf-8?B?Y3F3THZHbDk3bFI4TituaS85R1RRZllqajJ1OGxISkUvUFpKVVBDdGJ3eDd2?=
 =?utf-8?B?anpyZGJwTTdCWm01UDhPRHFycnBRWFAvT3JGbFhFRDZRbHNpV1BKTzFFZE5J?=
 =?utf-8?B?c09IY0liV1Y1dEVMMzd1cXkzMlN3eDRMUHQxaklKZkx3OGFCd2dlYmdGZElX?=
 =?utf-8?B?NFcxWGpHNTZwd1FCdjZZTFZDc0wwWnVzRnZBdTJvU0s3SmJ1Sy9CVjQ3NWtu?=
 =?utf-8?B?NGxKeHY3K09lVDZoQ3gvbnh2Qy9Kdzg3N2g4S1FSbEthSVpwUlBKRERFNHdQ?=
 =?utf-8?B?R2tlY3JxN0V3b0RsTFJaQXpsQXRMMU1YZ2NxVDVkeFc2UW1FckZDemJvNFZ0?=
 =?utf-8?B?QXVlbmlIL2c2WGowZERuYWdxWlZLdXl5ZXR6aXBVckNGMGZXd1h4OTRUam05?=
 =?utf-8?B?UWF1Wjk2elFSaDRuV05vcjVDK0lNcFROajV2dWdrRUNDZWJmam0xTFArRG80?=
 =?utf-8?B?UGQ4WGZMT1hMS0VCVW9ZcmtUd1kyejI3WTJCZGs1d1BJeFdlWkFGNFdEeU5l?=
 =?utf-8?B?bzUreTFjdm5OTk5tcGMvUllVOVJMREdTOE9aTDhLVjlhQ3BKaCtnWUwvdU8z?=
 =?utf-8?B?d3VPZ25tU3hmeUVMU3V5WUlBQnJkQ1ZLUXc3K3BFVTQ0eEdGUXpMOVVqb0dp?=
 =?utf-8?B?RXhZNTdRbE04UUtqVjh1b1pPdkdZdzkvZStLV0JXaEd3SStFb1hVSzVabnhF?=
 =?utf-8?B?K1c4cHJtRENuVFBxZFpYV2xvc3VZSHRpam1WeGNLY0dIUU1LbGhueGM2aGd1?=
 =?utf-8?B?aFBkMUR1cU5HVGM3TEg1OW1pL1drMzdNYTFzdko4b1pNNEhaNjloUS9yTXRE?=
 =?utf-8?B?WjV0NC81UUNxdFBQam5NTDVjaUhtTGJUWHc0cExMdUNYRWpvWFgzL25OK2p3?=
 =?utf-8?Q?tQGpcRa48INDkiWFz2ZvOT8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR18MB4248.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WlpMa1M1K1ZuYjQ2eXpKR3hmMVRLVk14Ri9QWW51S1JBZUFraG12UUFFSCtv?=
 =?utf-8?B?TjJldTROTFZOb2ZDTnJ3MHNkQUxZd2NOSDBLQ0xmM0JUMWpjWTVOL1pieVBX?=
 =?utf-8?B?MXk2a2NUSHpLdUYzc004Y0FXbjU5ejNGM2FnWGtSZ2xpWVVNenJvTXM4K09V?=
 =?utf-8?B?ZkpDdWN0Y0JEV3pRRkU5dFJBVkRLcXEzb0prNjRsK2tqSVlCYnc2aTlyekEy?=
 =?utf-8?B?U2kvZGxIQVZWS0hpL1JtNTZNUDEvZnhFVFNZUUdET0RUSURMYmxYeG96RnNZ?=
 =?utf-8?B?NGxzNlVrTm1jN29tZlRDYUp3OThqSHRiVGI3dXpCa25ubkJjVFNSbzcxTzBv?=
 =?utf-8?B?TlI0NENIMlBjQ2VhRFIvSFduNmpXUmxWUkJLb205d0twa3JSVmhjY0orTmFQ?=
 =?utf-8?B?bW8rS2VMYW9jM1FjdFdXT2QzUERxV3I5RDlPSHFGZzh4ZGlPMXFMMUR4bXZ4?=
 =?utf-8?B?TVIvek5VZ3VkMlNhOHpEaWQvREFzODdjN1hCcVQxWVFnbGVjNkF3cjNiQW9W?=
 =?utf-8?B?RDlKeDlSbXRGbm4vZm9qRU1BQlJsOVVYdSs5MGU0WjFYUVczVkpFTU0zanR0?=
 =?utf-8?B?bThyOEh6NmFZR0tNb1JPN0tmRVE5RmtpaUtrdlo4RHBMM055VURnc0VVTDBo?=
 =?utf-8?B?ZFRjUTVTNkF2UENUcnlSQkZXTmFFOEt3eVRiZ0NkZmhkcnlVeEZrR1c4R2hP?=
 =?utf-8?B?czd6Ui9HTmFaTjFXSDA4MlhIYmc4UHZIR1h4S1JTOGdYbWJsRXBFZnFSUEJX?=
 =?utf-8?B?aVJqTFVQWXAvbWYrWm1iTEQ4WEZmSk9rUG1kd2E5R1BiQ2pDcG94eG1XakVs?=
 =?utf-8?B?dk1Kd1dKZkMwTWxweHQ0bFRRWXlHUyt3c1VDSWpkSXlkamZHNjF0WHMzZjcx?=
 =?utf-8?B?aE5ZUkNEZkdMZXpDZ2hiOE51TzVYUUJqaUo0OU04YTJwaHgrcDlzWnVkNXpl?=
 =?utf-8?B?YTZlU2M3QXM0WjhsOWRyUFJod05WTnhyRmN6dGlOMnBNNGtlaXMzb1I2YzlZ?=
 =?utf-8?B?MWJPait3eU8yajVQNEk1YTU3TC84ZUpHQ2ZjY2U3a3JSZ0NPTWp6S2FQblZp?=
 =?utf-8?B?L3c1QjdzUVBpVDRmOEFjZXZHdnNWbHgrYm5lcFEySEJlRitFZElQS0JyczI2?=
 =?utf-8?B?NktIMU9qY1NWTkE2ZDVEWklidVFiQ21iZXlNVjVwNWdUS3Jpb2lycld4VkRV?=
 =?utf-8?B?eDk4MFdWeGhzZ2o1VHFRSjBHdVlsTnNpUWRycHN0NHUwaGZwanVXSUIxcXhz?=
 =?utf-8?B?RWx3ekdHbll2d0pmRmUzR0ZKQ0IzT2luTDNrVS9EU1BIUWVqYTd6NlZhV2ZN?=
 =?utf-8?B?dlg0OEpVZ09zZnRWYUdTSnp6L0RYa29meEM5cHZmYXZpT0t6dFg5aE13QmhE?=
 =?utf-8?B?SUcwQjhTYk43Nnk4eVJvaTUxcEhQZjZBUVd6dUFqN3orUTRrY2Nmam9JeGlP?=
 =?utf-8?B?TkJyZEVVM2w0UkpQSGRpbEdyWlNveEd3T0hQaFhIaTR5d2pEeUluS0hkRlJ5?=
 =?utf-8?B?ZzYvMXdQUTNvQU5DVGhxd3h0QjBlUEFXYlZwSDZJWjY0dEUxVE9zVkZ3d3g2?=
 =?utf-8?B?VkVuYlBaM09LZExIa2ZYOXRtbUNjZmllbWlNZnhTQVhZZk1Jb0tWZnF1d1F0?=
 =?utf-8?B?Y2pZRE1qejk4dDhVTVo4NW1McEh1a3Vld1NJbnYrZWwrbC8yNjdaQ3BOUEov?=
 =?utf-8?B?SWcwN3E1WFJGQzJTUTVaeVI1MXVTQWxKMkhwTit1c09ZTC9tZHY1Y3VwTmx2?=
 =?utf-8?B?RFQ4UWxzU01hbGxRNlBPWWU2Mm00dmQxb1NycURLd2VsOENqcGpkTnZPZGpU?=
 =?utf-8?B?RGZvR0EveVRDcTYvTW5HWVhaZHNzbjI0NDRQMnhuNWx1ZHRRdnpJQzNhaWV6?=
 =?utf-8?B?U2laUFNLSk1kQkk0K2tRYlc0ckNDS1B3bnhaKzd0TjUzOVJRMmdDelpobFUy?=
 =?utf-8?B?ZFZaSWhMQm5abTRrSFlVTVh3V1hDQTNtdnUrMnRiTGZFRWxsMmhpcmtqb2pk?=
 =?utf-8?B?czZ4YXlBbkVTSXl1UkgwUitFWDJJRkQ5UG03UzFUalNUZ211ODNaSnRhVlhQ?=
 =?utf-8?B?V3B6ZTJweWNxN3RFRG4xT1c1WFFiVHlmeENwSDVyWXQwWlFnWTFjQTNkMTc4?=
 =?utf-8?B?TDkxZlhpeGREMDZwMkkzWFMva0lnK0EzYmtHU2VBcng2SmRDaXMzVENSdHpk?=
 =?utf-8?B?RnZ4ci9zdDNZNktmRUxmdnpWdGJOWllBK2s2djZMYzlPQkdtVlNMcmJnTmhJ?=
 =?utf-8?B?UFVzblBzWm4xVzFhSFVJQ2VLYU5rZkhtQ1ZHamY1NlR0aDA0N3ZBV0FHVVJG?=
 =?utf-8?Q?vsQEaXjcmCI+e8k8VC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR18MB4248.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4dd9f0-ef15-42f1-d4e3-08de63ef31af
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 13:13:31.4401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TRR/r8bXy1lvNmYRaX1ofaTfQOy5IT/QskokdHkf+uCtu5LXcU9hHAI0YTiu6pavNwBnJ2oFzT3t8BTbbw4QqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB3855
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: TdZjfyll8Y0E2mpdk7KPaE5eCyg9XskN
X-Proofpoint-ORIG-GUID: P0NRb1VTWXF9QBijQNKkWIL523lAsJUg
X-Authority-Analysis: v=2.4 cv=COonnBrD c=1 sm=1 tr=0 ts=698345fe cx=c_pps
 a=RH0axx9bUT6qb0hBLGrbHA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=g8kJ_gb0AAAA:8 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8
 a=M0qOatAKFLRlDgEQ9icA:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=ecSNLfPMzbq-p5zXJZOg:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEwMCBTYWx0ZWRfX3XbCVB+SpOjs
 HJe72vqbgDBtiJu/zy0fkciIq4/hK2Nvev+FDnDp9NkhxE33ShjGxJ1jp2NX7D+1ZNaw/2vEF3u
 /ynWOuQ9BdPJJRQOe3LCqzeizQ1bLQB0HG88CxiOzsts42Wdp3rAMbn9f6BQQY5mg+jriwhw/88
 J9tzDjcC5gSPe1u5KEfKAeEirv7kJys9/VgN0GzYanD1ZnCETiIHEo8AeQmoOxzz4wNH/qKPRyH
 VJpQqHe8w8vo2uhk6LdU/Wn89U6NuRHiF1HLqwTycgIaeTlNq8nPCcfSC6Nwzq+o2I7fmlW2XPf
 MVfPNXoMczlSuT4wctHIQBTFLMBsD3Ie8LztVoB1nSS4+7pxtqFugvwInKhnOKT9o/te4fQNawi
 wL4C21hhzm3i2V4vgXmYJlV4VjKTSeLm80dr9C0S/7zxorVfl0g4M4vub+yeoKtyQnR1k/Bo7/F
 OwJ5G4y02NFN4JahkGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_04,2026-02-04_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-256702-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enachman@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,marvell.com,plvision.eu,redhat.com,google.com,davemloft.net,lunn.ch,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C7058E63F5
X-Rspamd-Action: no action

SGksDQoNCj4gDQo+IA0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPg0K
PiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDQsIDIwMjYgNToxNSBBTQ0KPiBUbzogRWxhZCBO
YWNobWFuIDxlbmFjaG1hbkBtYXJ2ZWxsLmNvbT4NCj4gQ2M6IEpvbmFzIEdvcnNraSA8am9uYXMu
Z29yc2tpQGdtYWlsLmNvbT47IEFsb2sgVGl3YXJpIDxhbG9rLmEudGl3YXJpQG9yYWNsZS5jb20+
OyBUYXJhcyBDaG9ybnlpIFtDXSA8dGNob3JueWlAbWFydmVsbC5jb20+OyBWb2xvZHlteXIgTXl0
bnlrIFtDXSA8dm15dG55a0BtYXJ2ZWxsLmNvbT47IFlldmhlbiBPcmxvdiA8eWV2aGVuLm9ybG92
QHBsdmlzaW9uLmV1PjsgVmFkeW0gS29jaGFuIFtDXSA8dmtvY2hhbkBtYXJ2ZWxsLmNvbT47IFRh
cmFzIENob3JueWkgPHRhcmFzLmNob3JueWlAcGx2aXNpb24uZXU+OyBwYWJlbmlAcmVkaGF0LmNv
bTsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgYW5kcmV3K25ldGRl
dkBsdW5uLmNoOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBhbG9rLmEudGl3YXJpbGludXhAZ21h
aWwuY29tDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCBuZXQtbmV4dF0gbmV0OiBt
YXJ2ZWxsOiBwcmVzdGVyYTogZml4IEZFQyBlcnJvciBtZXNzYWdlIGZvciBTRlAgcG9ydHMNCj4g
T24gTW9uLCAyIEZlYiAyMDI2IDExOjI2OjAwICswMTAwIEpvbmFzIEdvcnNraSB3cm90ZToNCj4g
DQo+ID4gT24gMDIvMDIvMjAyNiAwNjoyOCwgQWxvayBUaXdhcmkgd3JvdGU6DQo+ID4gPiBJbiBw
cmVzdGVyYV9ldGh0b29sX3NldF9mZWNwYXJhbSgpLCB0aGUgZXJyb3IgbWVzc2FnZSBpcyBvcHBv
c2l0ZSBvZg0KPiA+ID4gdGhlIGNvbmRpdGlvbiBjaGVja2luZyBQUkVTVEVSQV9QT1JUX1RDVlJf
U0ZQLiBGRUMgY29uZmlndXJhdGlvbiBpcw0KPiA+ID4gbm90IGFsbG93ZWQgb24gU0ZQIHBvcnRz
LCBidXQgdGhlIG1lc3NhZ2Ugc2F5cyAibm9uLVNGUCBwb3J0cyIsIHdoaWNoDQo+ID4gPiBkb2Vz
IG5vdCBtYXRjaCB0aGUgY29uZGl0aW9uLg0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL3ByZXN0ZXJhL3ByZXN0ZXJhX2V0aHRvb2wuYyBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvcHJlc3RlcmEvcHJlc3RlcmFfZXRodG9vbC5jDQo+
ID4gPiBpbmRleCAyZjUyZGFiYTU4ZTYuLmEyNTlkYTlmMzBmNCAxMDA2NDQNCj4gPiA+IC0tLSBh
L2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvcHJlc3RlcmEvcHJlc3RlcmFfZXRodG9vbC5j
DQo+ID4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL3ByZXN0ZXJhL3ByZXN0
ZXJhX2V0aHRvb2wuYw0KPiA+ID4gQEAgLTcxOCw3ICs3MTgsNyBAQCBzdGF0aWMgaW50IHByZXN0
ZXJhX2V0aHRvb2xfc2V0X2ZlY3BhcmFtKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsDQo+ID4gPiAg
CX0NCj4gPiA+DQo+ID4gPiAgCWlmIChwb3J0LT5jYXBzLnRyYW5zY2VpdmVyID09IFBSRVNURVJB
X1BPUlRfVENWUl9TRlApIHsNCj4gPiA+IC0JCW5ldGRldl9lcnIoZGV2LCAiRkVDIHNldCBpcyBu
b3QgYWxsb3dlZCBvbiBub24tU0ZQIHBvcnRzXG4iKTsNCj4gPiA+ICsJCW5ldGRldl9lcnIoZGV2
LCAiRkVDIHNldCBpcyBub3QgYWxsb3dlZCBvbiBTRlAgcG9ydHNcbiIpOw0KPiA+ID4gIAkJcmV0
dXJuIC1FSU5WQUw7DQo+ID4gPiAgCX0NCj4gPiA+DQo+ID4NCj4gPiBJJ20gcHJldHR5IHN1cmUg
dGhhdCB0aGUgY29uZGl0aW9uIGhlcmUgaXMgd3JvbmcsIG5vdCB0aGUgZXJyb3IgbWVzc2FnZS4N
Cj4gPg0KPiA+IEFGQUlLIGl0IGRvZXNuJ3QgbWFrZSBzZW5zZSB0byBjb25maWd1cmUgRkVDIG9u
IGV0aGVybmV0L2NvcHBlciBwb3J0cywNCj4gPiBidXQgZm9yIFNGUCBwb3J0cywgaXQgbWF5IGJl
IHJlcXVpcmVkIGRlcGVuZGluZyBvbiB0aGUgdHJhbnNjZWl2ZXIgb3INCj4gPiBjYWJsZSB1c2Vk
LCBlc3BlY2lhbGx5IGZvciBmaWJlciBtb2R1bGVzLg0KPiA+DQo+ID4gSSBtYXkgYmUgd3Jvbmcg
dGhvdWdoLg0KPiA+DQo+ID4gVGhpcyBjaGVjayB3YXMgaW50cm9kdWNlZCB3aXRoIGJiNWRiZjJj
YzY0ZCAoIm5ldDogbWFydmVsbDogcHJlc3RlcmE6DQo+ID4gYWRkIGZpcm13YXJlIHY0LjAgc3Vw
cG9ydCIpLCBidXQgdGhhdCBjb21taXQgZG9lcyBub3Qgb2ZmZXIgYW55DQo+ID4gZXhwbGFuYXRp
b24gZm9yIGl0IGluIHRoZSBjb21taXQgbWVzc2FnZS4NCj4gDQo+IEVsYWQsIGNvdWxkIHlvdSBj
bGFyaWZ5IHRoaXM/IEEgYml0IGhhcmQgdG8gdGVsbCB3aGV0aGVyIENSIGlzIGluY2x1ZGVkDQo+
IGluICJTRlAiIGZyb20gZ2xhbmNpbmcgYXQgdGhlIGNvZGUuDQoNCkJhc2ljYWxseSwgdGhlIHN1
cHBvcnRlZCBkZXZpY2VzIGhhdmUgRkVDIG9uIDEwRy1CQVNFLUtSIGFuZCB1cHdhcmRzIChDUjog
ZnJvbSA0MEctQkFTRS1DUiksDQphbmQgZm9yIFVTWEdNSUkgU0VSREVTLCB3aGljaCBkcml2ZXMg
bXVsdGlwbGUgY29wcGVyIFBIWXMuDQoNCkp1ZGdpbmcgYmFzZWQgb24gYWxsIG9mIHRoZSBhYm92
ZSwNCkkgdGhpbmsgaXQgaXMgYmVzdCB0byByZW1vdmUgdGhpcyBjaGVjayAocGx1cyBzYWlkIGVy
cm9yIG1lc3NhZ2UpIGFsdG9nZXRoZXIgYW5kIGxldCB0aGUgZmlybXdhcmUgcmV0dXJuIGFuIGVy
cm9yIGlmIHRoZSBtb2RlL3NwZWVkL0ZFQyBjb21iaW5hdGlvbiBpcyBpbnZhbGlkLg0KDQpGWUks
DQoNCkVsYWQuDQo=

