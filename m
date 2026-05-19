Return-Path: <netdev+bounces-289356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAuwG18vDGq0XwUAu9opvQ
	(envelope-from <netdev+bounces-289356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:37:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B2057B693
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60AA2300853A
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6FA3FB7DC;
	Tue, 19 May 2026 09:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="i65ZrHXv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915593F0AB6;
	Tue, 19 May 2026 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183058; cv=fail; b=gJuuzPdHdRgtYoVMEbaG16lZWEakr44NLK0ADQyf05f9lN6Iua7TwpwIn4fxMhesp8CUg3AJsB/A2PIhLXB/i4m1T1S9SS9HTnEn1yy7P1vSxfjInq9TJfciCeLDPgYfQ4ccEBRDk/FHxXY7wsJIy9i0v6YNQiALvJZp23ZU+sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183058; c=relaxed/simple;
	bh=ARHxHuRk1yq7pALCl8jnr/hqB82MUwX/wCnts9qkhPw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T2ZHFIlrB21gs0p7uGK6SByZcuHUJT8Je4S7oLeCf6ZW88Kn+joHDjJ9Yat+my/UBDOvlNhFSELIP55CJFhi1FTUj45Mx9r2rxILyJV9sKoaEP4tFAJa0Z7DXKEyXKERZ9g5U8FmW32KB6lwHkcwqAGI9vB783oRYX1opuwEU48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=i65ZrHXv; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J6qmNJ3009138;
	Tue, 19 May 2026 02:30:38 -0700
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11022074.outbound.protection.outlook.com [52.101.43.74])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e8jyw8dv6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 02:30:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nefYaGmTRJv4tl2D4Ph55oq4V2GHApgfaboOBBSboQoNM2bU/T4oA7WlgGOLoe1jkkumEjJHovYVC9rpd82G6lBNcUrAf8n12CJpT6WeKu9Ofh8uPZHaq/bkqZ13ilTpq+xRrNSVhVUKe5Jfgh0AigtyV4gCec8uvEqZoHnDDExbd3KoHqgMk2yjIzrxds/QhR2dFS9Yf410dg/ZvFoG9X8k1czdDHLH0pi20Qvjd7D+rMmnRljmzzaokLUkE402VW1YaiO5lmt80yOb9rloGGcZYzNcv53dqlfOBeM3rZXRug1w4w3aOSLTXFxvDPmd+BWjEOIVASFq9441ydgQ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARHxHuRk1yq7pALCl8jnr/hqB82MUwX/wCnts9qkhPw=;
 b=ryEOreRivVnaYlw2IYJh7feF6APp1ffeMnmcjM/N9H1M0yHXQvYbGcL38u7XPkTOIIKkFgkwUeLSS+y0bTte6EFTrv8z4c/8MdQGNR06Sl4WF3IktYIR7lC97nYsjFPsdyqN2O2P17VuA7TqTCqnYKhZ4l1+naFKcGFoopOUEzXDg/106XYCCdPxwYP+tdfWEW5vVIt1TdigiKnYiWgwPFOHBwFle+Hq53bKQXmII2d1xvKkByqAI6dAgFOyG6CrTcAL4BHRtLiEUeZqnkkKMjouxyUD0rOp7F3iZVfYp0tX5Pvt1BZMZjBTg7Qq/dyzRRR6iMQMmCeMibZu8phGeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARHxHuRk1yq7pALCl8jnr/hqB82MUwX/wCnts9qkhPw=;
 b=i65ZrHXvYL1489rz5muai2Ewb5gH/85ybpAWnWoWvx9rzn7Xx2IVWZVLVDo1Nv6WRnbgsIoSeBIFCQ/e7hPeylhlHVSB+FLIb0JJoe/5IHZs2EUlgeq/G7hA4qiZ9peJ7WMwImol4saF5LAS2pMjYMGMPzwSuo6DEukc0o3C/aE=
Received: from SA1PR18MB4600.namprd18.prod.outlook.com (2603:10b6:806:1d3::7)
 by PH7PR18MB5080.namprd18.prod.outlook.com (2603:10b6:510:153::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 19 May
 2026 09:30:32 +0000
Received: from SA1PR18MB4600.namprd18.prod.outlook.com
 ([fe80::a9ff:1d54:811d:cff9]) by SA1PR18MB4600.namprd18.prod.outlook.com
 ([fe80::a9ff:1d54:811d:cff9%6]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 09:30:31 +0000
From: "Sukhdeep Soni [C]" <sukhdeeps@marvell.com>
To: Paolo Abeni <pabeni@redhat.com>,
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
        "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v2 9/9] net: atlantic: add PTP
 support for AQC113 (Antigua) (Antigua)
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v2 9/9] net: atlantic: add PTP
 support for AQC113 (Antigua) (Antigua)
Thread-Index: AQHc3uLSYAxR2J6KUEK/r5smg1KCRbYKM0iAgArw4qA=
Date: Tue, 19 May 2026 09:30:31 +0000
Message-ID:
 <SA1PR18MB4600A16C00852152C31591ADBA002@SA1PR18MB4600.namprd18.prod.outlook.com>
References: <20260506135706.2834-1-sukhdeeps@marvell.com>
 <20260508120156.3060-1-sukhdeeps@marvell.com>
 <20260508120156.3060-10-sukhdeeps@marvell.com>
 <f8ab7286-8a4f-4dfd-96b1-db1f05b1f2b1@redhat.com>
In-Reply-To: <f8ab7286-8a4f-4dfd-96b1-db1f05b1f2b1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4600:EE_|PH7PR18MB5080:EE_
x-ms-office365-filtering-correlation-id: be038e1d-f8af-4b51-dab7-08deb58945ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|18002099003|56012099003|4143699003|11063799006|3023799003;
x-microsoft-antispam-message-info:
 +Kw7/lI+h+rNsi5+EVHzw68klfg7aq11OPh0+TkOJfaA6P822FF6PFXavc12k46pY6R7vGW1POUlGfivCetsVOIJV7cbY3f2SyF0fZOpjLeJtwmwzYyUOrsrLVlCe5LGcd/XoXZxoT9nUWF3ZeVAjng2b0JkDJ6okB7mK9KmOkGaaBWmEIXZDG+s92W+/BRXWCxI1nknhCRUH3nTfPEYRPfmYpE3xoxRN576QzgP5MiHTK7AfxUDPPPVlB3NM7tcSCcXmWitx/5de/lzi6Wne5i4jjXbM+e8nthW84A6gwgzr1dyko1e4iWxT7oNX4A6Nz+JexvqrvaFx16EH26Of7MC4gz/oDq53vtXSmbXgXZT1K71YJM4zXqAo6PrSMfnc/PRb2RygWZ/dkl9AY6LsU6DiWyR8ox8LUS/CzgKwFaY4QL7TBltRL9bojw6EN+UKLVNL4k+46GMrTOHFpKnRbxgwO+fhKrCpEaeAFI/TrOorSuEJn8P5kO8uu2GCIMPajpJjoU43Dtlg4lqPf+rKPmSthU8jUXPoDFC3nH3EP3yg+JouFxmBUwDbwFA1Urn52IVstpmcdf7UGCX9f0HFfkqQzyPIOMolVD7Z8UHq7Oywa73b3ftU9luWarSDpaywYsR9XmC3pCdVKmcdZYoegaBhmbiBZeKXOlIhk5iSQrhR1kU9uDmB2TlOz9FKgOuzIucoGcNUtT5AqtMk4NSTB1F29dYSncwqyETZyJE2Pcjz/jsAHkPq9AbxKHzNgmz
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4600.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003)(4143699003)(11063799006)(3023799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZXZjRWlEVFVkaDcxUVYxN25UdHNRSjF3UW5IS1hvSHd1Mmtxczl3Q3BucEN5?=
 =?utf-8?B?eTk5bEY2eFJSYnBRWXBheG4zcnp5bU9UY1NGT1RNKzdRZ1YrOVFkS1VmWWpw?=
 =?utf-8?B?anAzNHhOZkYvQ3U3czByNXQrSVA2OUNjeDJnenJYU1YwSlZMNUhjWEE4Q1pn?=
 =?utf-8?B?WkY0VzEzNFU5VFRkd3UvZm94OVBXK0NscWx2eEl6Ulp1U3l4dk1PMWxvRUpq?=
 =?utf-8?B?N3Uzb05pb3F3NmRHd3FDTjFzM09kN0l2YjN6SjlPRXNXVEZ0RWpTbCsxbndt?=
 =?utf-8?B?dThIVmdibFY3T2V4U0NqeFVxbDJ4OU1ReEdSR21xN1ZvM0xaTzRXSGZHQUtD?=
 =?utf-8?B?THRYWHEwZlFyelpyTWtxaXZpVk1MZEs4N2RnK2M5bUFkMUl3WmFrVlRsalJV?=
 =?utf-8?B?M0RMRWRERjgxci9TaVp6YTVyeGNmaloxVjlKZWNNd3MrRFYrVU8xNTc5L0E5?=
 =?utf-8?B?dlNuUU9oY1UwZk5NeHE1WGpCUG5HaW5JbW4ra01NdzhsVmgydXpkNWpteWV0?=
 =?utf-8?B?QXZQYlUvTUhvSGhYK3JLVHo4YVYySXE2cDh1MnU0N1gvMHVuZFBYYnNXSVc2?=
 =?utf-8?B?bGVUUjNmd1NubW1GQ1c1ajFwUnBJU0FJb0RYYTBNZjlaaHJRNk01Tk5kQS81?=
 =?utf-8?B?aTlZR2pScnhHRkk4ZnhCQUtQSCs0SG92ME5nOGlISFRydzk0UFJKa0N4eTF6?=
 =?utf-8?B?TzVKam8raW5SckNFZ01EZFpOYTBLWWxMQTZUZ2Y4RVpmTjhRZzBWa0FDOFF4?=
 =?utf-8?B?V0pHNU9ocWlHZlM4ODZVeVNSdncyYWlxODJKMmloR3p0K0dUQlNhQTFMUy92?=
 =?utf-8?B?ZXZRbStCUHFnd0w0ZnJYQVBNWEV5REFYaDJrbnQ4L29HUUordExnKzFYZm83?=
 =?utf-8?B?UW1TNlU2R1ZFTGJBSXpHaG1BU0QxR3hQVUhUcXkyWElqWEJETHlFT24wVCtR?=
 =?utf-8?B?RTZBVGY0YlNiR2ExaDFJVUMwUW5sdHp6V3hxOU11QnlDSjh5RTNhYUhxZFB1?=
 =?utf-8?B?VXBSanBVb0hXRUJ0WVRnQVBOOWRFRDdiek1TWUFrc003TS9aU2hkWGpLMmJo?=
 =?utf-8?B?N3RCQk5FSGFYaWk1TlplR1ZrMEhVQkFTbXdyOG1kb01LK0FJak9kY0FOS3ZP?=
 =?utf-8?B?YllaVzJoMVM3VnV4cmZ1SS9wSXJ4TmQ4WFJjR094Uk1oWHBFaHNiL3d0WmtM?=
 =?utf-8?B?SFpBc2JaVmU5R1pPcklXMXZwZmNRbDFOYVd5c1Y1VGxYSWVXN3N0U1d1SEFY?=
 =?utf-8?B?UytzZTRmcG13dkVSclNGbkVId0FqbjVWU2t4WmhlV3BmZGJKTDhwdDAwSERa?=
 =?utf-8?B?bjFrb1V3RDhoMCtneVhvbnZLM2x6UC9FM3hzQjNnbFdIbC9iQ0ovWVphZmY0?=
 =?utf-8?B?Y2RkN2dCT3dKWGsrWE5ONXhha0dsc1J4V0xrbVhFNXoxYXgwdVpvSEl1SjVK?=
 =?utf-8?B?dkxSaHJyZXlqZ3lzSUo3M1pCU3Jic2hmcHV4b2wwYk9PMHNaem1Kam9ZK255?=
 =?utf-8?B?MWYxNEQvTVBDdUxLMWFaN3pxL0hXMDVvT01iL3FtNEFGSlpreEk2RGttYmFH?=
 =?utf-8?B?M0RuS1FSWmp5dXFiM0dYY1pRZ0swMlhYamxVTTRnc0Z0RWlVWks3UkkxV2Jy?=
 =?utf-8?B?YU4yaVlQaE1BNU9pSXpKVk5BV0NLZy9DOC9oMmpqVmt1ZE00cWtTREdaTGVM?=
 =?utf-8?B?WkNBWnNmNVN6QnVzRTVIRXRDdTVmaUlOVVBPSmpBWGN4UW1aaHdpYXFTbDZ4?=
 =?utf-8?B?VHVPQ25LdUdhcS96MUh3RzU4Y0pUWUc0MFVvSDNzbVoyVkpFMFkxWnJKUzBu?=
 =?utf-8?B?Q0N0alRJZGRrNUFsbTQ2U1pCYmdEMisrNk80ZXZyM2xMME1HUXlKVGd5cFNP?=
 =?utf-8?B?aW1vTCt1QVdtMmd0emt6NjhkR3gyQUdlT21VeHZCYnBFbmVQZGFrc2FuUUQ1?=
 =?utf-8?B?Nzgxd3QvZE5neVVhNzRjOEpEMk5QZDF5Z3FGdXFScHRUL3U1OWlENi9yUnc3?=
 =?utf-8?B?WWk5RTF4VHhGT2FxRXIzcVF0VDNGeGk3V0ZBZ3o3Uis4T3RIQnBrVktuWDhu?=
 =?utf-8?B?NlAzZ1U1V012NVJYbXNYa2Z6SWplR0ZwVmdMTCtrTmlVVXc0R0s5MS9jTUgz?=
 =?utf-8?B?ZlBKYnpaSGdGWEk4dFllOUthYjEwQnJ3ZnlraktKYW4yb0tGTjNxbjJqb1dR?=
 =?utf-8?B?NTRSbG84ZldvRzRlZEY4ZTlMSk93TjRZWkNGbWlsWklmOUxtSEMyMk40Z1BU?=
 =?utf-8?B?SS9NYXBTd3grdU9wN0J2QUlCZHNETDhGTm4xbzJCblhUZEkzaCt2OUZCaDFi?=
 =?utf-8?Q?o2IDm7X7Jh2oUK9x9K?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	pnnTrRZSmMaVoJzF0vHECKxzW8x3L3q9WBR/+X9N80/SpFa4+T7/qeOditcTcBKxZ2TVNu8ImkrtELTIq1nWb3OgE/+XrjTYsMsXNSUDcTcNYJZyatrbue+IvTi1A1fJ9tgLYtIvyPF7QfF0jT8F7LkfaAcaQrh41s3np+cTQp59WnZrIsdnyUpkw3/Ooi2uFXEIF4q8o6Sg+5uWC2wrznrk7VUHV2T6debPf0ERe0cibZfeixwNMjvyNon4oPkpVH6AUUl3B5Ok6gljmaV7D1a7WsCVeV1drhRG8jnXh4XOhec5vOLtPaK7SvzF8YXk5ogvutDYz4mW0wvYuRk/8g==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4600.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be038e1d-f8af-4b51-dab7-08deb58945ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 09:30:31.9006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SrTMBzISgRPv7/nvDjTTFZiX0nS0pwkjGwIRiDPpG/u86tmsSsO0oJ9xAHkEADSJ9zdDKEp1wjxN7W4Mf1VWUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5080
X-Proofpoint-GUID: DoW35XFcyFpeuI67CK_6uMFBFOcvmDlY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA5MyBTYWx0ZWRfX9FtDFgXeQtxu
 yEo4u3CgdX7NhiaIKAcn0tGx30ToI/2H/A8gc3PrfXRQHFcwElDzOtYJ1EfnG0Y8QokEHmYoLG2
 DXUP6Y4zGJ++5Mj8bJZfwqlU3TcSRp+ZVyoyS80pSUu7ELAr61O+N+8vcnsDkOp9iyXnOmWsq5d
 qZsSmNHKH47EMVeam/X7wTFJoG+MzFgMzi/m1tG5NMaC91rr6oVIEqbG74jyIB3Yw7TbrPW8uGC
 ixB4tk2hODxgwkT/3p3XZhehasaHGbdQJknGaE7XjsNC5zxWWwMzkqqVVF45U5B88DPXIjaoOw5
 DCsUIDR4ryZL1WcSSEXDW3tOXhnIqaTBbwYSi/nf+99Fbxzt4jO2jloPQvFQb2vkrpuaee69r2O
 Fyq439LaEFk795720Yb2owS9AjDbAsrwzOVa/WY/1y+u1+lOWlDVepX0NvxZGDPWjXuBdoZvd0p
 ILjurfRi2N06BYVE9bw==
X-Proofpoint-ORIG-GUID: DoW35XFcyFpeuI67CK_6uMFBFOcvmDlY
X-Authority-Analysis: v=2.4 cv=QbNWeMbv c=1 sm=1 tr=0 ts=6a0c2dbe cx=c_pps
 a=EjCBFqPm7gL+SGkxwm0cEw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=2s9r1aOuVh3W2gKzKMgA:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289356-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SA1PR18MB4600.namprd18.prod.outlook.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,marvell.com:email,marvell.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[marvell.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,linux.dev,vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F2B2057B693
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQpPbiAxMiBNYXkgMjAyNiwgUGFvbG8gQWJlbmkgd3JvdGU6DQoNCj4gT24gNS84LzI2IDI6MDEg
UE0sIG1haWx0bzpzdWtoZGVlcHNAbWFydmVsbC5jb20gd3JvdGU6DQo+IEZyb206IFN1a2hkZWVw
IFNpbmdoIDxtYWlsdG86c3VraGRlZXBzQG1hcnZlbGwuY29tPg0KPiANCj4gQWRkIElFRUUgMTU4
OCBQVFAgc3VwcG9ydCBmb3IgdGhlIEFRQzExMyAoQW50aWd1YSkgbmV0d29yayBjb250cm9sbGVy
DQo+IGFsb25nc2lkZSB0aGUgZXhpc3RpbmcgQVFDMTA3IChBdGxhbnRpYykgUFRQIGltcGxlbWVu
dGF0aW9uLg0KPiANCj4gQVFDMTEzIFBUUCB1c2VzIGEgZGlmZmVyZW50IGhhcmR3YXJlIGFyY2hp
dGVjdHVyZSBmcm9tIEFRQzEwNzoNCj4gLSBEdWFsIFRTRyBjbG9ja3MgKHNlbCAwIGZvciBQVFAs
IHNlbCAxIGZvciBQVE0pIGluc3RlYWQgb2YgUEhZLWJhc2VkDQo+ICAgdGltZXN0YW1waW5nDQo+
IC0gVFggdGltZXN0YW1wIHZpYSBkZXNjcmlwdG9yIHdyaXRlYmFjayBpbnN0ZWFkIG9mIGZpcm13
YXJlIG1haWxib3gNCj4gLSBQZXItaW5zdGFuY2UgUFRQIHRpbWVzdGFtcCBvZmZzZXRzIGluc3Rl
YWQgb2YgZ2xvYmFsIHN0YXRpYyB0YWJsZQ0KPiAtIEhhcmR3YXJlIEwzL0w0IGZpbHRlcnMgZm9y
IFBUUCBtdWx0aWNhc3Qgc3RlZXJpbmcgd2l0aCBJUHY0IGFuZA0KPiAgIElQdjYgc3VwcG9ydCAo
NCBmaWx0ZXIgc2xvdHMgZm9yIG11bHRpY2FzdCBhZGRyZXNzZXMpDQo+IC0gRGlyZWN0IGhhcmR3
YXJlIGNsb2NrIGNvbnRyb2wgaW5zdGVhZCBvZiBmaXJtd2FyZS1tZWRpYXRlZCBhY2Nlc3MNCj4g
DQo+IEtleSBpbXBsZW1lbnRhdGlvbiBkZXRhaWxzOg0KPiANCj4gUFRQIGNsb2NrIG1hbmFnZW1l
bnQ6DQo+IC0gQWRkIGFxX3B0cF9zdGF0ZSBlbnVtIHRvIGRpc3Rpbmd1aXNoIGZpcnN0IGluaXQs
IGxpbmsgdXAsIGFuZCBubw0KPiAgIGxpbmsgc3RhdGVzIGZvciBwcm9wZXIgY2xvY2sgaW5pdGlh
bGl6YXRpb24NCj4gLSBPbiBBUUMxMTMsIG9ubHkgcmVzZXQgdGhlIGNsb2NrIG9uIGZpcnN0IGlu
aXQgKG5vdCBvbiBldmVyeSBsaW5rDQo+ICAgY2hhbmdlKSB0byBhdm9pZCBkaXNydXB0aW5nIG9u
Z29pbmcgUFRQIHN5bmNocm9uaXphdGlvbg0KPiAtIFJlLWFwcGx5IFJYIGZpbHRlcnMgb24gbGlu
ayBjaGFuZ2Ugc2luY2UgaGFyZHdhcmUgc3RhdGUgaXMgbG9zdA0KPiANCj4gVFggdGltZXN0YW1w
IHBhdGg6DQo+IC0gQWRkIHBlci1wYWNrZXQgVFggdGltZXN0YW1wIHJlcXVlc3QgdmlhIHJlcXVl
c3RfdHMvY2xrX3NlbCBpbiB0aGUNCj4gICByaW5nIGJ1ZmZlciBkZXNjcmlwdG9yDQo+IC0gUG9s
bCBmb3IgVFggdGltZXN0YW1wIGNvbXBsZXRpb24gaW4gYXFfcmluZ190eF9jbGVhbigpIHdpdGgg
YQ0KPiAgIHRpbWVvdXQgbWVjaGFuaXNtIChhcV9wdHBfdHhfdHNfdGltZWRvdXQvY2xlYXIpDQo+
IC0gU2V0IEFRX0hXX1RYRF9DVExfVFNfRU4gaW4gVFggZGVzY3JpcHRvcnMgZm9yIHRpbWVzdGFt
cC1yZXF1ZXN0ZWQNCj4gICBwYWNrZXRzDQo+IA0KPiBSWCBmaWx0ZXIgbWFuYWdlbWVudDoNCj4g
LSBSZXBsYWNlIHNpbmdsZSBVRFAgZmlsdGVyIHdpdGggYXJyYXkgb2YgNCBmb3IgSVB2NC9JUHY2
IG11bHRpY2FzdA0KPiAgIFBUUCBhZGRyZXNzZXMgKDIyNC4wLjEuMTI5LCAyMjQuMC4wLjEwNywg
ZmYwZTo6MTgxLCBmZjAyOjo2YikNCj4gLSBBZGQgYXFfcHRwX2RwYXRoX2VuYWJsZSgpIGZvciBj
b21wcmVoZW5zaXZlIGZpbHRlciBzZXR1cC90ZWFyZG93bg0KPiAtIEFkZCBhcV9wdHBfcGFyc2Vf
cnhfZmlsdGVycygpIHRvIG1hcCBod3RzdGFtcF9yeF9maWx0ZXJzIHRvIEwyL0w0DQo+ICAgZW5h
YmxlIGZsYWdzDQo+IA0KPiBQVFAgVFggcGF0aCBpbiBhcV9tYWluLmM6DQo+IC0gQWRkIElQdjYg
UFRQIHBhY2tldCBkZXRlY3Rpb24gdXNpbmcgaXB2Nl9oZHIoKS0+bmV4dGhkcg0KPiAtIFVzZSBQ
VFBfRVZfUE9SVC9QVFBfR0VOX1BPUlQgZGVmaW5lcyBpbnN0ZWFkIG9mIG1hZ2ljIG51bWJlcnMN
Cj4gLSBNb3ZlIHNrYl90eF90aW1lc3RhbXAoKSB0byBub24tUFRQIHBhdGggdG8gYXZvaWQgZG91
YmxlIHRpbWVzdGFtcHMNCj4gDQo+IElSUSBhbmQgaW5pdGlhbGl6YXRpb246DQo+IC0gQWNjb3Vu
dCBmb3IgUFRQIElSUSB2ZWN0b3IgKEFRX0hXX1BUUF9JUlFTKSBpbiB2ZWN0b3IgbWF0aA0KPiAt
IE1vdmUgZmlsdGVyL1ZMQU4gcnVsZSBhcHBsaWNhdGlvbiB0byBhcV9uaWNfc3RhcnQoKSBmb3Ig
cHJvcGVyDQo+ICAgb3JkZXJpbmcgYWZ0ZXIgUFRQIHJpbmcgc2V0dXANCj4gLSBBZGQgQVFfSFdf
RkxBR19TVEFSVEVEIGZsYWcgbWFuYWdlbWVudCBpbiBvcGVuL2Nsb3NlDQo+IA0KPiBIVyBsYXll
ciAoaHdfYXRsMi5jKToNCj4gLSBJbXBsZW1lbnQgUFRQIGNsb2NrIGVuYWJsZS9kaXNhYmxlLCBy
ZWFkLCBhZGp1c3QsIGluY3JlbWVudA0KPiAtIEFkZCBHUElPIHB1bHNlIGdlbmVyYXRpb24gZm9y
IFBQUyBvdXRwdXQNCj4gLSBBZGQgVFgvUlggUFRQIHJpbmcgaW5pdGlhbGl6YXRpb24NCj4gLSBB
ZGQgVFggdGltZXN0YW1wIGRlc2NyaXB0b3IgcmVhZGJhY2sNCj4gLSBBZGQgUlggdGltZXN0YW1w
IGV4dHJhY3Rpb24gZnJvbSBwYWNrZXQgdHJhaWxlcg0KPiAtIFJlLWVuYWJsZSBQVFAgYWZ0ZXIg
aGFyZHdhcmUgcmVzZXQNCj4gLSBXaXJlIGFsbCBQVFAgb3BzIGludG8gaHdfYXRsMl9vcHMgdGFi
bGUNCj4gDQo+IFBlci1pbnN0YW5jZSBQVFAgb2Zmc2V0cyB3aXRoIGVtcGlyaWNhbGx5IG1lYXN1
cmVkIHZhbHVlcyBmb3IgQVFDMTEzDQo+IGF0IGVhY2ggbGluayBzcGVlZCAoMTAwTS8xRy8yLjVH
LzVHLzEwRykuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTdWtoZGVlcCBTaW5naCA8bWFpbHRvOnN1
a2hkZWVwc0BtYXJ2ZWxsLmNvbT4NCj4gLS0tDQo+ICAuLi4vbmV0L2V0aGVybmV0L2FxdWFudGlh
L2F0bGFudGljL2FxX2h3LmggICAgfCAgIDEgKw0KPiAgLi4uL25ldC9ldGhlcm5ldC9hcXVhbnRp
YS9hdGxhbnRpYy9hcV9tYWluLmMgIHwgIDM0ICstDQo+ICAuLi4vbmV0L2V0aGVybmV0L2FxdWFu
dGlhL2F0bGFudGljL2FxX25pYy5jICAgfCAgNDggKy0NCj4gIC4uLi9ldGhlcm5ldC9hcXVhbnRp
YS9hdGxhbnRpYy9hcV9wY2lfZnVuYy5jICB8ICAgNCArLQ0KPiAgLi4uL25ldC9ldGhlcm5ldC9h
cXVhbnRpYS9hdGxhbnRpYy9hcV9wdHAuYyAgIHwgNTM1ICsrKysrKysrKysrKysrLS0tLQ0KPiAg
Li4uL25ldC9ldGhlcm5ldC9hcXVhbnRpYS9hdGxhbnRpYy9hcV9wdHAuaCAgIHwgIDE1ICstDQo+
ICAuLi4vbmV0L2V0aGVybmV0L2FxdWFudGlhL2F0bGFudGljL2FxX3JpbmcuYyAgfCAgNDIgKy0N
Cj4gIC4uLi9hcXVhbnRpYS9hdGxhbnRpYy9od19hdGwyL2h3X2F0bDIuYyAgICAgICB8IDE3OSAr
KysrKy0NCj4gIC4uLi9hcXVhbnRpYS9hdGxhbnRpYy9od19hdGwyL2h3X2F0bDIuaCAgICAgICB8
ICAxMiArDQo+ICAuLi4vYXRsYW50aWMvaHdfYXRsMi9od19hdGwyX2ludGVybmFsLmggICAgICAg
fCAgIDMgKy0NCj4gIC4uLi9hcXVhbnRpYS9hdGxhbnRpYy9od19hdGwyL2h3X2F0bDJfdXRpbHMu
aCB8ICAxMCArDQo+ICAxMSBmaWxlcyBjaGFuZ2VkLCA3MTAgaW5zZXJ0aW9ucygrKSwgMTczIGRl
bGV0aW9ucygtKQ0KPg0KPiBWZXJ5IGxhcmdlIHBhdGNoLCB5b3Ugc2hvdWxkIHRyeSB0byBicmVh
ayBpdCBpbiBzbWFsbGVyIGNodW5rcy4NCg0KQWdyZWVkLCB3aWxsIHNwbGl0IHBhdGNoIDkgaW50
byBzbWFsbGVyIHBpZWNlcyBpbiB2My4NCg0KPiBAQCAtMTAzNSw0NiArMTI0Niw0OSBAQCBzdGF0
aWMgc3RydWN0IHB0cF9jbG9ja19pbmZvIGFxX3B0cF9jbG9jayA9IHsNCj4gIAkucGluX2NvbmZp
Zwk9IE5VTEwsDQo+ICB9Ow0KPiAgDQo+IC0jZGVmaW5lIHB0cF9vZmZzZXRfaW5pdChfX2lkeCwg
X19tYnBzLCBfX2VncmVzcywgX19pbmdyZXNzKSAgIGRvIHsgXA0KPiAtCQlwdHBfb2Zmc2V0W19f
aWR4XS5tYnBzID0gKF9fbWJwcyk7IFwNCj4gLQkJcHRwX29mZnNldFtfX2lkeF0uZWdyZXNzID0g
KF9fZWdyZXNzKTsgXA0KPiAtCQlwdHBfb2Zmc2V0W19faWR4XS5pbmdyZXNzID0gKF9faW5ncmVz
cyk7IH0gXA0KPiAtCQl3aGlsZSAoMCkNCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBwdHBfb2Zmc2V0
X2luaXQoc3RydWN0IGFxX3B0cF9zICphcV9wdHAsIGludCBpZHgsDQo+ICsJCQkJICAgdW5zaWdu
ZWQgaW50IG1icHMsIGludCBlZ3Jlc3MsIGludCBpbmdyZXNzKQ0KPg0KPiAnaW5saW5lJyBpbiBj
IGZpbGVzIGFyZSBoaWdobHkgZGlzY291cmFnZWQuIFVzZSB0aGVtIG9ubHkgZm9yIGNyaXRpY2Fs
DQo+IHBhdGggYW5kIHByb3ZpZGluZyByZWFzb25pbmcgKGkuZS4gdGhlIGNvbXBpbGVyIGRvZXMg
dGhlIHdyb25nIHRoaW5nDQo+IG90aGVyd2lzZSkuDQoNCkZpeGVkIGluIHYzLiBpbmxpbmUgcmVt
b3ZlZC4NCg0KPiBbLi4uXQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvYXF1
YW50aWEvYXRsYW50aWMvYXFfcmluZy5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvYXF1YW50aWEv
YXRsYW50aWMvYXFfcmluZy5jDQo+IGluZGV4IGUyNzAzMjdlNDdmZC4uYTUyZDZkM2ZlNDY0IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9hcXVhbnRpYS9hdGxhbnRpYy9hcV9y
aW5nLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvYXF1YW50aWEvYXRsYW50aWMvYXFf
cmluZy5jDQo+IEBAIC0zMDgsMjQgKzMwOCwzMCBAQCBib29sIGFxX3JpbmdfdHhfY2xlYW4oc3Ry
dWN0IGFxX3JpbmdfcyAqc2VsZikNCj4gIAkJCX0NCj4gIAkJfQ0KPiAgDQo+IC0JCWlmIChsaWtl
bHkoIWJ1ZmYtPmlzX2VvcCkpDQo+IC0JCQlnb3RvIG91dDsNCj4gLQ0KPiAtCQlpZiAoYnVmZi0+
c2tiKSB7DQo+IC0JCQl1NjRfc3RhdHNfdXBkYXRlX2JlZ2luKCZzZWxmLT5zdGF0cy50eC5zeW5j
cCk7DQo+IC0JCQkrK3NlbGYtPnN0YXRzLnR4LnBhY2tldHM7DQo+IC0JCQlzZWxmLT5zdGF0cy50
eC5ieXRlcyArPSBidWZmLT5za2ItPmxlbjsNCj4gLQkJCXU2NF9zdGF0c191cGRhdGVfZW5kKCZz
ZWxmLT5zdGF0cy50eC5zeW5jcCk7DQo+IC0JCQlkZXZfa2ZyZWVfc2tiX2FueShidWZmLT5za2Ip
Ow0KPiAtCQl9IGVsc2UgaWYgKGJ1ZmYtPnhkcGYpIHsNCj4gLQkJCXU2NF9zdGF0c191cGRhdGVf
YmVnaW4oJnNlbGYtPnN0YXRzLnR4LnN5bmNwKTsNCj4gLQkJCSsrc2VsZi0+c3RhdHMudHgucGFj
a2V0czsNCj4gLQkJCXNlbGYtPnN0YXRzLnR4LmJ5dGVzICs9IHhkcF9nZXRfZnJhbWVfbGVuKGJ1
ZmYtPnhkcGYpOw0KPiAtCQkJdTY0X3N0YXRzX3VwZGF0ZV9lbmQoJnNlbGYtPnN0YXRzLnR4LnN5
bmNwKTsNCj4gLQkJCXhkcF9yZXR1cm5fZnJhbWVfcnhfbmFwaShidWZmLT54ZHBmKTsNCj4gLQkJ
fQ0KPiArCQlpZiAodW5saWtlbHkoYnVmZi0+aXNfZW9wKSkgew0KPiANCj4gSSBzZWUgdGhpcyBp
cyBwcmUtZXhpdGluZyBjb2RlLCBidXQgd2h5IGlzIHRoaXMgY29uZGl0aW9uIHVubGlrZWx5PyBJ
DQo+IHN1cHBvc2UgdGhlIE5JQyBpcyBleHBlY3RlZCB0byByZWNlaXZlIHBhY2tldHMgOi1QDQo+
DQo+IEFsc28sIHVzaW5nIGEgZ290byBzdGF0ZW1lbnQgd291bGQgYXZvaWQgZXhjZXNzaXZlIGlu
ZGVudGF0aW9uLg0KDQpGaXhlZCBpbiB2My4gUmVzdG9yZWQgdGhlIG9yaWdpbmFsIGlmIChsaWtl
bHkoIWJ1ZmYtPmlzX2VvcCkpIGdvdG8gb3V0OyBwYXR0ZXJuDQrigJQgdGhlIHVubGlrZWx5IHdy
YXBwaW5nIGFuZCBkZWVwIG5lc3RpbmcgYXJlIGdvbmUuIFRoZSBQVFAgdGltZXN0YW1wDQpibG9j
ayBzaXRzIGF0IHRoZSBzYW1lIGluZGVudGF0aW9uIGxldmVsIGFzIHRoZSBvcmlnaW5hbCBza2Iv
eGRwZiBoYW5kbGluZy4NCg0KPiArCQkJaWYgKHVubGlrZWx5KGJ1ZmYtPnJlcXVlc3RfdHMpICYm
DQo+ICsJCQkgICAgc2VsZi0+YXFfbmljLT5hcV9od19vcHMtPmh3X3JpbmdfdHhfcHRwX2dldF90
cykgew0KPiArCQkJCXU2NCB0cyA9IHNlbGYtPmFxX25pYy0+YXFfaHdfb3BzLT5od19yaW5nX3R4
X3B0cF9nZXRfdHMoc2VsZik7DQo+ICsNCj4gKwkJCQlpZiAoIXRzKQ0KPiArCQkJCQlicmVhazsN
Cj4gIA0KPiAtb3V0Og0KPiArCQkJCWFxX3B0cF90eF9od3RzdGFtcChzZWxmLT5hcV9uaWMsIHRz
KTsNCj4gKwkJCX0NCj4gKwkJCWlmIChidWZmLT5za2IpIHsNCj4gKwkJCQl1NjRfc3RhdHNfdXBk
YXRlX2JlZ2luKCZzZWxmLT5zdGF0cy50eC5zeW5jcCk7DQo+ICsJCQkJKytzZWxmLT5zdGF0cy50
eC5wYWNrZXRzOw0KPiArCQkJCXNlbGYtPnN0YXRzLnR4LmJ5dGVzICs9IGJ1ZmYtPnNrYi0+bGVu
Ow0KPiArCQkJCXU2NF9zdGF0c191cGRhdGVfZW5kKCZzZWxmLT5zdGF0cy50eC5zeW5jcCk7DQo+
ICsJCQkJZGV2X2tmcmVlX3NrYl9hbnkoYnVmZi0+c2tiKTsNCj4gKwkJCX0gZWxzZSBpZiAoYnVm
Zi0+eGRwZikgew0KPiArCQkJCXU2NF9zdGF0c191cGRhdGVfYmVnaW4oJnNlbGYtPnN0YXRzLnR4
LnN5bmNwKTsNCj4gKwkJCQkrK3NlbGYtPnN0YXRzLnR4LnBhY2tldHM7DQo+ICsJCQkJc2VsZi0+
c3RhdHMudHguYnl0ZXMgKz0geGRwX2dldF9mcmFtZV9sZW4oYnVmZi0+eGRwZik7DQo+ICsJCQkJ
dTY0X3N0YXRzX3VwZGF0ZV9lbmQoJnNlbGYtPnN0YXRzLnR4LnN5bmNwKTsNCj4gKwkJCQl4ZHBf
cmV0dXJuX2ZyYW1lX3J4X25hcGkoYnVmZi0+eGRwZik7DQo+ICsJCQl9DQo+ICsJCX0NCj4gIAkJ
YnVmZi0+c2tiID0gTlVMTDsNCj4gIAkJYnVmZi0+eGRwZiA9IE5VTEw7DQo+ICAJCWJ1ZmYtPnBh
ID0gMFU7DQoNClsuLi5dDQo+IEBAIC04ODYsNiArOTEyLDEzOCBAQCBzdGF0aWMgc3RydWN0IGFx
X3N0YXRzX3MgKmh3X2F0bDJfdXRpbHNfZ2V0X2h3X3N0YXRzKHN0cnVjdCBhcV9od19zICpzZWxm
KQ0KPiAgCXJldHVybiAmc2VsZi0+Y3Vycl9zdGF0czsNCj4gIH0NCj4gIA0KPiArc3RhdGljIHUz
MiBod19hdGwyX3RzZ19pbnRfY2xrX2ZyZXEoc3RydWN0IGFxX2h3X3MgKnNlbGYpDQo+ICt7DQo+
ICsJcmV0dXJuIEFRMl9IV19QVFBfQ09VTlRFUl9IWjsNCj4gK30NCj4NCj4gV2h5IGRvIHlvdSBu
ZWVkIGFuIGhlbHBlciBoZXJlPyBVc2luZyB0aGUgbWFjcm8gZGlyZWN0bHkgc2hvdWxkIGJlIGp1
c3QNCj4gZmluZS4NCg0KRml4ZWQgaW4gdjMuIFRoZSB3cmFwcGVyIGlzIHJlbW92ZWQ7IEFRMl9I
V19QVFBfQ09VTlRFUl9IWiBpcyB1c2VkIGRpcmVjdGx5Lg0KDQo=

