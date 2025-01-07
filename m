Return-Path: <netdev+bounces-155740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA57A0383C
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 07:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767723A467D
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 06:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC14319D8BE;
	Tue,  7 Jan 2025 06:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="GGKf5Zp7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53504879B
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 06:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736232938; cv=fail; b=ifKiIsReU8DwtTb3FkfyJUifTSsxb+z0AQMxk3sAUylCuQfCcVNLD3TqECho8wqIQQVU78oolYuvXiX6/osWM3Z/Bfh1W3qrB04Eeq79RhIwdXFVCdhbLI5FitcJJ54c36JTVYyUI5PoxLSqbL9wbjVCX1O1ZVkXb3EDvvDobCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736232938; c=relaxed/simple;
	bh=IPRjkGxioYy8VLYrlqTbnCLJQuSBKZN55sRUhX42W0Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E53cM8owSwEgdgzRILotdcXCpmqMfqtBrCGtM1NjcKBbOGaZyn+/4nX+Q9E2K+YuOWyVokho3IbO3VR4e74IygwgvTDIXYOZp2N81Mhu21xewK9WmOw+A2Mj5eNFhhboXkDDIbzaLfh7adLtXAcyfhzRp1eyeyYlDPxbRecXu+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=GGKf5Zp7; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5074csGO002565;
	Mon, 6 Jan 2025 22:55:32 -0800
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 440we106qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 22:55:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsb5UDmPuy8LpzLBW321HgeIfGlgJvbgvPgmNx1LSX/jqKtZ1va9jbPCdHLQwGf1Isz/JM+pPjoxjtjehJznOUqrnNl1UEgPST3r0uyB3OnjMc7s/Hd1FPjqX0rvkGKAAW8KoFyquDBHYy12JNZUvuT0Hw2sRJSlObNiKpoY9uWViLqyLjqdFt89HNnG5TR1l/6jPdQcnjkq0z9ZApbJgVw+DxjtJOo/VdJCZ5FVqJLjTDQqK6AC1JBGcNfC+Kk684EOAtbp9Uz+3OpZQJzfUeSvLQPIBUgUDYtU3hq33uPuxBRncNLdYjsB4ncML0aoTgmugUN8eoVBc3DMUiuQTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPRjkGxioYy8VLYrlqTbnCLJQuSBKZN55sRUhX42W0Q=;
 b=iUv53txdSN60gIFBKAbjRxqAISwriEv2fdiBkyVypjzJ73d7iPOhiaRf+UZC3fOLWW/A6dN9My0wn+PMNaQaiS6TR4qKyYl3TAsk4XOwtbVmGNbjGNkb+ltgsvdrMw9kZP6OfkSwukYkNlLpu1IYtPVexKP4JT/n/loHJwuChWay06RBaGIv7eWg9VJQKC8vP7XueydOavXgfTl2sJlIS1JxiqRcxluUp62iw220UQItk5aOVIMSx1CGHdZrgnuAfdib9WT0Im/Q8bxAG0M4Ql3OpZEK+/LWA8aTgYOubIPS1KpsS7rShE+EZYBUS6wgi2sKbfn68p/Kww6JBcLhog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPRjkGxioYy8VLYrlqTbnCLJQuSBKZN55sRUhX42W0Q=;
 b=GGKf5Zp7u9OMahySAGRMbUM/ORtMy+I9Su5+B71caIdI4cpbM3x6PM7EXIfzJXSx4RureazGr9XEjIU7eWyHR3L0+K22SXFIpE/NMkYbnWVqFWRZJ5rbnxY0kzYrpDcBaO6ddR84y49sQaPf4R2UIveQb4Hyurw3P1VLVwpMnWU=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by DM4PR18MB5408.namprd18.prod.outlook.com (2603:10b6:8:184::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 06:55:24 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30%6]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 06:55:24 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [net-next PATCH v8 4/6] octeontx2-pf: CN20K mbox REQ/ACK
 implementation for NIC PF
Thread-Topic: [net-next PATCH v8 4/6] octeontx2-pf: CN20K mbox REQ/ACK
 implementation for NIC PF
Thread-Index: AQHbYNEgsLO01lUXdUiu9gvjMVrJdw==
Date: Tue, 7 Jan 2025 06:55:23 +0000
Message-ID:
 <BY3PR18MB4707A2342DA89BB8F556A278A0112@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20250105071554.735144-1-saikrishnag@marvell.com>
	<20250105071554.735144-5-saikrishnag@marvell.com>
	<SA1PR18MB47094FA3D15F05C8EDFC02C1A0102@SA1PR18MB4709.namprd18.prod.outlook.com>
 <20250106125330.15cf523b@kernel.org>
In-Reply-To: <20250106125330.15cf523b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|DM4PR18MB5408:EE_
x-ms-office365-filtering-correlation-id: 3f46307b-4e31-4ac1-a9f2-08dd2ee84294
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cFpGVklkVkRQbmZCZDhqSEFyaGRnR3M3TzVwMTV1WWFXQVV2bkNYVDVVTld1?=
 =?utf-8?B?ZUVNM0FoMEFSZWNBRG5qM2xJWWNCMnBLR1drdW1BNWo2Wk8rczZwakpyaEtC?=
 =?utf-8?B?ck92NVY2UDlCaEdwVUNPVHJEaVk2cW8zcmFCc3pUOFhKZGIreTE3SjlqU3ZJ?=
 =?utf-8?B?SHI2TzhwWXJjK093M1h6YkxHTGN6RGZOREtIaUhwcnFva1k0SkV4eW85MzlJ?=
 =?utf-8?B?OGVxdVBzc0tMS0ZYYTF1UHI5TTlSNHZDbExpNklGN3NYb2JzT09aWlJTeVda?=
 =?utf-8?B?ZDlpNzNuQ3ZMcTd1a1J0V2lIcHFKcXE1VmdUdlA2aC92cFBsN1MvZmNsVkRY?=
 =?utf-8?B?cjhpaER4YTlnbzJHOVVkYlczSXd3ckgwSHVDbC9WZUlsczZ2VUF5L3pHTXZW?=
 =?utf-8?B?N09WR1Y0S0liYmg0T2Y1VzdFUUJ0ZGQ1UHhObG1vVDV3OGNLbVhNMGZ0di8y?=
 =?utf-8?B?RFVmTW9Jdk9xRWJLbE5GbDhMRFlSQ2NIZG02cEVOSzdJWjV6c0dLdjFiLzc0?=
 =?utf-8?B?YmxiOW5vT09iU0hOR1doQ2lacEQ2ZG9GcHFtVS9BNG5RaTZRNk1Qa1kvRU5x?=
 =?utf-8?B?QUtIRzdsMzVUejJLOTFsS2VHekgrTHcwYTU1VGdweDkwUUc0TnhQYndMOUIz?=
 =?utf-8?B?QkduTjVEbSswdEprN1diNEZ5R0w1Y2dqazdRT1Zwb3pUN1dGT3JYZW1JOGRN?=
 =?utf-8?B?bkl5bDFQV09SZU5lRmNTMG9YTzgxcDZ0bTFJeVBtT3BKTGZBWGtib3NvZkc3?=
 =?utf-8?B?dW9jejhDd29YTmVKN1dNVy83NTRBbExzS2ZySjFPLzZaZmMrNER3bnRzNEtY?=
 =?utf-8?B?U05ub3hpdUdiUGUwNkViWVNGZG1MYjRDQVVuaE9xbG8rdFJYd0dtRjllNHlr?=
 =?utf-8?B?ZTUxTjg1MThGZXQxTjFOemUvM1NGNDNITkY2VGFzVTdQRzBkenpvOTc3YVZM?=
 =?utf-8?B?V25WcmdpVHZETjM3MU1pSDduME16UDBtRGg2QWY5MmRaS25jMFhxa1hKMndT?=
 =?utf-8?B?ank3ZXBoa2lSYmt2KzNObm1CZVNTQ3M1OFBLUm1ZNDlBeG45OGttM3NML085?=
 =?utf-8?B?Y3R1KzJ6ek05QjMzRTZoOTFUYVUzMkZPRit5UUZFckVyY2RDdFRnaDFHSUJy?=
 =?utf-8?B?dlNGZEY2MFdOc212bUZFeGNYaWprbnRJS0pIYUY4Z1BBdFo2SnIySjNIU0cr?=
 =?utf-8?B?K2gxU0NybHpVdEp5QkZrTFJGTWptVzU1RVU2Z2pOZnppYmh6d2FOTHhCQ0Nk?=
 =?utf-8?B?Qld4Z0lSU0lqbWxWaUxDWFIxV084OHF4Mm82R0lMSXZhQSsvWnppcUVQSERW?=
 =?utf-8?B?ZmYvVGlBUWtKc0EwL29PRGZrdDRkSkFoSmc5bVIzdytPR0gyN2grMG0yRzJD?=
 =?utf-8?B?N1J2NWlERlVyRys2N2svVzJiTnZBTTFtWDB1OG5Yc0ROb1BjTzNGS0tSbHVx?=
 =?utf-8?B?RzFyV1NZZ0QzNFNHeThzdFcxaDRrQ0hNRDluWlNzZHdudnZxUW5KMDROaXNE?=
 =?utf-8?B?alRoYmhESXNBbXpLTUpoTzkxS0c3R3RWYVRRWnVrQVM3dW9YN0k5dkJiWFpR?=
 =?utf-8?B?TklaRDh5REJTM2xCYjIrL2lmVjdvWnVuVzUvKzVFQ2V0cWhLcGJsTmZtQmU4?=
 =?utf-8?B?bDhScHBibCtTZkZHSGYvQlFFY1pmL0VaZGd0TjN6ZXFodnY1dnA0K3Q3T0k3?=
 =?utf-8?B?cUdlbFhDNEgvV3JoOE5iY0NIdm80THUzVEl2ZFJvWFMwcXZma1JuNXdzVmE1?=
 =?utf-8?B?dENncndrRjYvRmVzWklVYm84VmxiM1FzZVNhTENXOFEzSTVlRnRVZTErYnAz?=
 =?utf-8?B?LzJuOUIxRXJrZC8vZ2tyUm1hcHJKRWdWZ2dCc2lvMWNTd3dWb0JYSEVzancy?=
 =?utf-8?B?RnhHZmNRRXkweXUxc21tOEZCNG81MzRZRk5WMzBiNTJPTjRCMDFaVWVLVGpq?=
 =?utf-8?Q?tNN7XBTx/wEuarX+5kNXbYBVQtamQDFe?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cThiQjJvbUtIZTdHdDV5U3NFQTllcDhSNWhobG1JbjA3a1YzUHZ3ZEsycS9O?=
 =?utf-8?B?dXMza3p4WldsWE5sMDRHTzBLSS9DL212MUpBTzlDTzFrUzRYZzBuOWk3WEtJ?=
 =?utf-8?B?NjY5OFYxREx3cnlBUlE1VzFsbkVOcUllandKd08yL2VTa1I2MytvVDhnMnNL?=
 =?utf-8?B?NGZyZXlpWXZsRGtxVEwyYVVZa0N0TDg3alYyRWN2a3pvcFhHSUt3WTNwNWMw?=
 =?utf-8?B?K0dPd2laQVNPTnIrbjEwZlVoZERUYTZPMHJFbS9RTlMzb3pzc0xJNzMzbVNJ?=
 =?utf-8?B?NkYvNWl1c2ZXNVBLc1FZR2Z0dnY3aHg1WHVySmtjSDF1ZUZ1aExBVWM1bDc5?=
 =?utf-8?B?WTlUaVh2d2w2TzRHWG5mMGZNbkJIVzA4Y2ZGSUM0WGhPVW4xOFBCRzVtK0NN?=
 =?utf-8?B?UE5yMG9oTys0THlLajBxQ1pxUVJSYjdhc0xLQnZPNU1ZMks4WGpyVy91Tk9m?=
 =?utf-8?B?aS9pbTRpYkZTV09OZU14T2NDYUhJSEFPeXZwYnpCQm0rN3pqd004MUxHUElK?=
 =?utf-8?B?NHQ1ektVTW1sK0RHcHNDY0k4Y2hEUitVc0RqbmdJNlZjdW5BR1d3NWZIZWJW?=
 =?utf-8?B?MjRCeUJIVWd6TitSSmIxaDQwdE5yS08zd2RqdGt2S1JxaEVVOVBwcExVODlp?=
 =?utf-8?B?UWFuZGgyREdDVE51amZTNGx2VlNrcEsrMjMxUTFmQ0VMZzRHWkhwSjFoRWh5?=
 =?utf-8?B?WUxGdWZmbEJkT3I3WTdvVGJJSUtqOW85bWMrZlRtbUtVdndDRmRhamZqZy9R?=
 =?utf-8?B?MnRmc0kyT3o2SjFmdlNhRzExVTMyR0VyNnoyZVVmdTEvR1VKdW5JNlU1YzNM?=
 =?utf-8?B?aWFjdWV5U1V6Wng5MmRxaWQ0Tm5oQWxLMUtYNDNFQXBXc0ZWTkZaczlSbFFL?=
 =?utf-8?B?RzlHLzd5anFVZkZscTFMczVxTnA1bmhyVHJ0L2NXU3FUSVdvL044ZWhOOEs4?=
 =?utf-8?B?QjNMUFdxOHVVVkV6MkZSa3lHNFh2clpXUERPV0NaUVR2RmV4dmpYNDNsUFV3?=
 =?utf-8?B?MkdxYmhTK2c1allJdnlzSG1HUkFmYWt1WitFYWhVT3BmTzhUM3RkbWcxTDNh?=
 =?utf-8?B?NGR5eE5GM05pVXRqNVo2enlSOUkxS1JvUjk4K3hOcDYxamw3MU5NVWFnQzNo?=
 =?utf-8?B?RisrYWRpSnNpbHJWeVVxdWVEdDZkb2RBdHpKZUk1L2xiKzZtZjV0V1NrNFl1?=
 =?utf-8?B?b2k3QUliZjNTemNuaDVSbGo2TzhpSjllNmRTRmFsYlZvNCt4SXJvRmFYKzVa?=
 =?utf-8?B?d0VWMHg2S0E3bzk2emsyMHVYS3Y1K0RoOFNMRFhDQnZtSy9nUjRIWHBvaUpD?=
 =?utf-8?B?S21NWjM1TlczTmc1aDdDald3UHNkWGRtakdiOC9VQ251ZVFXNFZ4MzRtNXhz?=
 =?utf-8?B?SStoeE9RTzFvOEV6WEZHeVM3THJKa1Rsb0tGd3NVSndPYWkzcTE2VzZLMEhZ?=
 =?utf-8?B?ZzQvUzljMHcwNVRMZjV5WlVoVDlGaWFXUUF3LzZ6T0tEK2RjV1hPK2RJZlF3?=
 =?utf-8?B?bnhmT0VDaG9tOWZTMWdnNUZ2NlphTTY2ZklTQ2NFOENiZ20wNThFWjBZZUJt?=
 =?utf-8?B?S1RlalhkRWRWajZvWjRyamp5aWgrV1M3VEFYRTl5Y2M4ZHdFaEV0TUp5T0N4?=
 =?utf-8?B?aUZCY29CUU85MWU3TjQ4cW52djdCRTU0WmR4NURsYkp6Kys2Qlo5aVdvKzlR?=
 =?utf-8?B?QzdaUkJTTDYxMUR0eFFwRnpXYjF4L01EVXVkeTR1SkFpSkxWYXkzNDhjK2th?=
 =?utf-8?B?d3U4NllvY2l6UG56S1BOV2JwMTh4cGdjTXJLdFZVTE9xdTVHdTNEMysxeDJ0?=
 =?utf-8?B?OE45aS9CV2ROT0NOVFcxcGhZWEVCWlZYWTFJNTZQclFMRUk1WUFZWHh2RUI4?=
 =?utf-8?B?Ry9UNng2eEYwekJoN1hCSEFCZjdmTHhvUWtjSnMrSTgrOEhNU1VOdm83NFVN?=
 =?utf-8?B?TFFLdXlVRkxsdFBmbkpJdCttakxiNTE3TFVuQXNESVN6UWh6WHJtTTVNUDhH?=
 =?utf-8?B?MUtabSszQ2FJcVN1cGlHWGN5czJYaUJvSjYwRkhYeXBrTXkwcndMTVNnK2My?=
 =?utf-8?B?Ris3SUR1Lys0TlAyRS96S2g2SGFZS1ZyUlIxOHB2Rzg0N0ZHNFd0K0FVWVEr?=
 =?utf-8?Q?+IhkAsxlcih5JCZD1aK+vaHbJ?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f46307b-4e31-4ac1-a9f2-08dd2ee84294
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 06:55:24.0717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8qm/woURINMsaZZzUcbCUavn1vB1F+ltclEWzSX6IONynM1Sx1avbLO1e3RIMImsDAFXP7h1O4c/HpQ6+wreSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5408
X-Proofpoint-ORIG-GUID: vv-B8n61HRu3x9Mu44NvM_Lgk0SVPLqs
X-Proofpoint-GUID: vv-B8n61HRu3x9Mu44NvM_Lgk0SVPLqs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDcsIDIwMjUgMjoyNCBBTQ0K
PiBUbzogU2FpIEtyaXNobmEgR2FqdWxhIDxzYWlrcmlzaG5hZ0BtYXJ2ZWxsLmNvbT4NCj4gQ2M6
IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtuZXQtbmV4dCBQQVRDSCB2
OCA0LzZdIG9jdGVvbnR4Mi1wZjogQ04yMEsgbWJveA0KPiBSRVEvQUNLIGltcGxlbWVudGF0aW9u
IGZvciBOSUMgUEYNCj4gDQo+IE9uIE1vbiwgNiBKYW4gMjAyNSAxMzrigIowODrigIoyOSArMDAw
MCBTYWkgS3Jpc2huYSBHYWp1bGEgd3JvdGU6ID4gSSBoYXZlDQo+IHB1c2hlZCBWOCBwYXRjaHNl
dCBmb3IgQ04yMGsgbWJveCBtb2R1bGUgeWVzdGVyZGF5LCBhcyB0aGUgPiBwcmV2aW91cw0KPiB2
ZXJzaW9uIGdvdCBkZWZlcnJlZCBkdWUgdG8gd2ludGVyIGhvbGlkYXlzLiA+ID4gV2Ugc2VlIGJl
bG93IHdhcm5pbmcvZXJyb3INCj4gbWVzc2FnZSBmb3IgcGF0Y2ggDQo+IE9uIE1vbiwgNiBKYW4g
MjAyNSAxMzowODoyOSArMDAwMCBTYWkgS3Jpc2huYSBHYWp1bGEgd3JvdGU6DQo+ID4gSSBoYXZl
IHB1c2hlZCBWOCBwYXRjaHNldCBmb3IgQ04yMGsgbWJveCBtb2R1bGUgeWVzdGVyZGF5LCBhcyB0
aGUNCj4gPiBwcmV2aW91cyB2ZXJzaW9uIGdvdCBkZWZlcnJlZCBkdWUgdG8gd2ludGVyIGhvbGlk
YXlzLg0KPiA+DQo+ID4gV2Ugc2VlIGJlbG93IHdhcm5pbmcvZXJyb3IgbWVzc2FnZSBmb3IgcGF0
Y2ggNCB3aGVuIGNvbXBpbGVkIHdpdGgNCj4gPiBjbGFuZyBvcHRpb25zLiAibmV0ZGV2L2J1aWxk
X2NsYW5nCWZhaWwJRXJyb3JzIGFuZA0KPiA+IHdhcm5pbmdzIGJlZm9yZTogMTYyIHRoaXMgcGF0
Y2g6IDE2MyINCj4gDQo+IEl0J3MgYSBrbm93biBwcm9ibGVtIDooIFVuZm9ydHVuYXRlbHkgb25l
IG9mIHRoZSBjb3JlIGhlYWRlcnMgKGxpbnV4L21tLmgsDQo+IElJUkMpIGdlbmVyYXRlcyBhIHdh
cm5pbmcgd2hlbiBidWlsZCB3aXRoIGxhdGVzdCBjbGFuZywgc28gd2UgZ2V0IGZhbHNlIHBvc2l0
aXZlDQo+IGZhaWx1cmVzLiBIb3BlZnVsbHkgdGhpcyB3aWxsIGJlIGZpeGVkIGR1cmluZyB0aGUg
Ni4xNCBtZXJnZSB3aW5kb3cuDQo+IA0KPiBJZiB5b3VyIHBhdGNoZXMgYXJlIHN0aWxsIGluIGFu
IGFjdGl2ZSBzdGF0ZSBpbiBwYXRjaHdvcmsgbm8gYWN0aW9uIGlzIHJlcXVpcmVkIG9uDQo+IHlv
dXIgc2lkZS4NCj4gDQo+IEFkZGluZyBiYWNrIHRoZSBsaXN0LCBwbGVhc2UgYXZvaWQgcmVtb3Zp
bmcgQ0NzLg0KDQpBY2ssIFRoYW5rcyBKYWt1YiBmb3IgdGhlIGNvbmZpcm1hdGlvbi4gDQoNClJl
Z2FyZHMsDQpTYWkNCg==

