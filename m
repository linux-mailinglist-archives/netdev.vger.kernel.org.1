Return-Path: <netdev+bounces-289375-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLQ+Gig2DGoKaAUAu9opvQ
	(envelope-from <netdev+bounces-289375-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:06:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D67C757BDDB
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0806530AD635
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924D53DA7EA;
	Tue, 19 May 2026 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="VdMjvR8V"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268A3351C0B;
	Tue, 19 May 2026 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184523; cv=fail; b=dGHJF0MpwqZ9Hi2HBp2zgI4mSxSfw3NQ0Ym5e5aurfGY94UVAGCpZIrtN8NCmJReAn3ilKk5W4JOQ3qMhPoPNj1f9e5BVcImw5OzzYj37mrEXyBft2+Qno9DEFIwIXwPqA0G9FfH33mhsxJicfCBMfvTZOL5VeTW3jlk7yzX0Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184523; c=relaxed/simple;
	bh=v1omCCl5YZKxTTAIGWOOdIeFeO8TvDNIpQ6owFRC9jE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rip5Eq2rmwF+l20N6RbUdaeY29JhhokolMsVIGVqh/uTEZh+BZVSsRLX1WK0tVBy45irFPMqRHAGOrnc6snmWGkdXUPb/6whyC4d9w42zRqVR1RuFiwLj5RFdqoFy4x2ugqRN73P2ncZxerFCPaNNZ59d+Kqe/ek25NwhdZaWuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=VdMjvR8V; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J1p8GX3638405;
	Tue, 19 May 2026 02:55:05 -0700
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020141.outbound.protection.outlook.com [52.101.201.141])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e8ejb161y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 02:55:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVg0of6ltbRRY/bGmKky8faEz2ZofvE5wP9m27r+l1agpqmfB1BWgxYqSZb2KwT/j3vnQMzQZBOUjn9mWPfmvtMtxlQGZIbXvOkARlxCet/CrixrLz3n7kHA/SMtGvDvaObuWXBcZKEG3QFtcuFb8ndL/LQUb7OzbLU9mG/RgxUpZafkvxQu3n8zi/y+fwpSXQDA1mWwxUirPKG8gUCHvODvkJPZP3B8rs9vC8+SlkaU565TpnyRCp3bICnBlXfv/DUFExaXShxyTE4UJD3qKOL/UIpA28t4Ou+53p0hTvb8RtqnYVTT9slt/5/isZZTvpTEil5nIIIyaGWHPxnelg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1omCCl5YZKxTTAIGWOOdIeFeO8TvDNIpQ6owFRC9jE=;
 b=FJzk6hMTXyrSHbrD8BOWUAfr2/ofB5IhHtLKAx57HL95H767gb1SA3pHycNG1uk54KhYwk5+A+w+RIRrMOw2CjbR0SnEzZoEDHiabst/9FBXoClQ6QRCCCHtDdFVErqbKSY2UX5iqvnPK/IlpG15KcBrmUF/gQXX9yQl0GDZLQhEBpSQxycrtO7ewJLVZb7hQ/FXqglDzBccreA0iRF0Mu39B6VrHzhIPYUCGR5psNFfV+jjDjRkPTlCnrJcSXy4iNA6MiKLekD21I7tR+gJnrVU+OrAckqPTIImaMZ4b+Yd7vZnFg2qa2nzu6n1xomm48JwzjuhpotDulRMpispWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1omCCl5YZKxTTAIGWOOdIeFeO8TvDNIpQ6owFRC9jE=;
 b=VdMjvR8VLaAoukLLTSEJHv6DXDd7b89YVZ9U+44RkPlbBq2XQcVU6Y7c0fe3/TkGV1FSkDRSt2fyHyHqjg2vPkI8VioKLqBPrZOgISEI26M6XVdMwSLgZMGXKI9lqjzrbmhn6q8DFBEPfrSXdz1i7PSLtf7AAKTvSxlpSKg+1Uo=
Received: from CO1PR18MB4603.namprd18.prod.outlook.com (2603:10b6:303:e2::19)
 by CH0PR18MB4241.namprd18.prod.outlook.com (2603:10b6:610:b8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 09:55:01 +0000
Received: from CO1PR18MB4603.namprd18.prod.outlook.com
 ([fe80::cb22:ffae:1f3a:af35]) by CO1PR18MB4603.namprd18.prod.outlook.com
 ([fe80::cb22:ffae:1f3a:af35%2]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 09:55:00 +0000
From: "Sukhdeep Soni [C]" <sukhdeeps@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Igor Russkikh
	<irusskikh@marvell.com>,
        Egor Pomozov <epomozov@marvell.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v2 0/9] net: atlantic: add PTP
 support for AQC113 (Antigua)
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v2 0/9] net: atlantic: add PTP
 support for AQC113 (Antigua)
Thread-Index: AQHc3uKdcgd5G0oo5k6pxB8g7qhGELYKRsMAgArlVMA=
Date: Tue, 19 May 2026 09:55:00 +0000
Message-ID:
 <CO1PR18MB460374CD80680A253926AFBBBA002@CO1PR18MB4603.namprd18.prod.outlook.com>
References: <20260506135706.2834-1-sukhdeeps@marvell.com>
 <20260508120156.3060-1-sukhdeeps@marvell.com>
 <20260512112708.GL27589@horms.kernel.org>
In-Reply-To: <20260512112708.GL27589@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4603:EE_|CH0PR18MB4241:EE_
x-ms-office365-filtering-correlation-id: 86519c5b-77f5-43ac-d73e-08deb58cb14f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|22082099003|4143699003|56012099003|18002099003|11063799006|38070700021;
x-microsoft-antispam-message-info:
 KExWFZdPamM+u0URr0f+4RI2PTacQAt/YdgVwYD7KJBdFbSEpJnn1LC4TKjcbc94To/IRdjMnEey2FGsLkA+StEndzuBEHRIrbkpqBEADcrab92hOmQZzBziJYZnWJfDnKYiKCme98qkt4CJ8xYl9WhDEn/H6GHDKcifGmsNoMiONCYqZRRVLtht3yaTi49IAhHuTLXrsPcoJnx8BTVxoI1cfilnH/eKSStlszPLLj1H4coj8UFJcx6Y2Yj1P9LtZ7dSJF8andgscE7trueIU1GVO2fYYn7uXK74pu3tg3IE46GRdvnIdGcwavhqyU/Vb9oN405ektZnxOEKq7xD2gDouM9gct/jHWnpFjg0T3b6Eypz8AuMR9za5LJj/fJH49hcl0g2xAQtmC9DRiL7E+VXVw7RxDmk10joUVO3AWfx67S6JGXoNBloz4KpI5pxxBeNGaKh9iQFUAtsVepqg5numHvKMfdqbAXvzV5P3MGILknm5tL7Y/GMj8W6eOJXDhwbLq3bMRiJd6gpAxQrVip/5r7EUWpRRJ3pScUUAdTDQpHVNRvjH09m0oYqH6g2eN8nuWrDqkIiZYJ8v9iOe9B1h9XLmK62v8KzswZWplx7vA75WTyNm9oiJJeKqlXcy7u/lrqCG6GS8DrJT1Vjx3+hebPEOISKUmQ5IWtIZiJxt8OdVavO6pmgqcx+FnXw
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4603.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(4143699003)(56012099003)(18002099003)(11063799006)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NlkvNXRlTXFqZThQcTcrSGlBVFlMRFZZdWpBV1dpVkpaVWlWbE9FaGlNaFdh?=
 =?utf-8?B?bWFIWjRsYW5DYmtwVjA5dU8rNFF6NTZVSTZUa3hkajZycmNMWFNaNEI3WTF2?=
 =?utf-8?B?ZHloTkRDVEROaVJJUlptTU1QVUVmTFQvTDkrSmEwam1aVkhmNGRSVDJrRGR4?=
 =?utf-8?B?QnRqcWJDYjRIRzNpTmx5b0E4dU5ZbXUweVlqc1FLRlAxS2hxa3daTWlFamFw?=
 =?utf-8?B?Z2VQTHUyKzdiYVZ5OTd4NVI3Sm9KNHhPV3FUVVRjOFV4eTJKaGtBSXhtT2F0?=
 =?utf-8?B?bG1UTHZ3Q3k2TFRSWVlBSmlhellmeDVRaXpZL0JSOUkvVHplMGE4Z0h1V0or?=
 =?utf-8?B?d0xHWFNRQmdLUW5iaXpFOWR4QzdXN3R6emdFQ0FOUFlyakZBTmNUR09xUUNP?=
 =?utf-8?B?RUQwcmYxZUZpUkcrdzFubUliRzdQZ0hoTTJSblZNWTVnb2N3N1ppMEpNTTRG?=
 =?utf-8?B?d0ZqUWN5SEtyL1IrU3hqakhETklFaDZHbXlqajE1KzZBVnhSMlNGM0NiMWtF?=
 =?utf-8?B?WHNUeTNSdnNXT3BuclJGMUp1dnV5TDVqWnV6WXZBNmd2SG1WazM3dWcvZG45?=
 =?utf-8?B?aE83L1B0ckFBYkFVYUVqTk9EOVQ5bnpkeWxCMGhoQnZNTFpZNEhlZE96UzQ2?=
 =?utf-8?B?SFZzbDdVcUZtQnlCM0VFbXVZWHFXbS91ME1FQ0VvbzBNenRnZURWeGZtbEdG?=
 =?utf-8?B?NTVnczByVTBEZ0JHeFBHNG00SnFtNEVhQ1FaZnVCVU9QbUtrSjBXODNBT3l1?=
 =?utf-8?B?WVNKTHMwQkN3OHBaWkxEamZPRmNNQlcwMUpKR25tNzduazJwNXBEWHZPQUU0?=
 =?utf-8?B?S1dlV3RLYmRyVnl3Y3FwdWw2NnhhZjZYMTMyQ2xFSjMzWTg4TXNoM3g0R24w?=
 =?utf-8?B?eW56ZmtIb0FpTEpRS2hYeFhnakpISU9LbHEwKzR3c29Sdktrd0JHNHpwSElG?=
 =?utf-8?B?Y2VJWG91dG5rTUJzYVFIZU9MazgvV0hwQzZyWXBmTlowN1d5WXFnT2RTa2lB?=
 =?utf-8?B?Z1o4RTdYbFRWanN6UlN4L1gyd2tHOWs2RXdIT1Iyb1VHbU4wQVp4MDNlWEts?=
 =?utf-8?B?T21CTVJFVDBiMnFrKzMrRzNCTGZtTWpscWJmZUNDN1I0K2JMeXE1aDNkVjZB?=
 =?utf-8?B?VHNCTDl3cmpGN01WcWwvNWpZdDJZSCtJZWpxUTJPY0o5eGEvRlNoT3ZYenQr?=
 =?utf-8?B?YzYyWWxGMlhmOGxZeEs5Y21qck5CNFBCYXp1d01ZdHlaK1JOT3JscW1OTlQ0?=
 =?utf-8?B?RU9semFpTCtnWjJYUlpUU1lWMHNzUVlud3JhVXFyRHk2TGZkUXc4STVvV0RS?=
 =?utf-8?B?M0JwVXBwRWJITlltYUtvOVZibkFiNzhlZ0t5N29nZnNFT1J1VUJNWHVNQ2lz?=
 =?utf-8?B?bzJ1TVppUlRvcVVQdGNXN1d4V0NMVmVYTzJHZ0ZJcDNySGJhaEg1U0tMTFp4?=
 =?utf-8?B?cW01TVlNVEYzWXhaR0ZDR3Zya2h4TCtTNUZMeG9PK2pqeUNubkcwWS9sRXU0?=
 =?utf-8?B?Y2E0WjBaZVdnempXZHJxZWhGQjlVM0d6UW1ZL3c3Rk0reU02MGdVNmUwdmhW?=
 =?utf-8?B?SEFqY3JTNnpkRDBJN1E4a2s4SnM3K0t2ODZoMU9kaUM5dDh4QkpGM2NjSGMx?=
 =?utf-8?B?dFVkSGF5K3dPNXV1Sy9TZnhkYXdseStrOGdldW9kamVPamp3Uy9OTVNXVDR6?=
 =?utf-8?B?RFlkZDZFVk12RzlXd0NKazNzSjdHRUMyZVJmRjI3bFd1aVdoTmNTRi9xZkk1?=
 =?utf-8?B?R2hFZHVPc0pGOUt2dmJCWnE4dE80cmxzNGZpdENDRlBhMzBveUNQT2wvSUJs?=
 =?utf-8?B?UkdCNEl1aUNyeXM2d3o5bCtXWEJVQXhocGp2U0dHdUJ3TmtBQmhaY3pPNmow?=
 =?utf-8?B?YXk2eU95QWM1QTgvM21Ham9OajFDamdXV2xmK29IVlBOTlR0aDF5UVdxRHh5?=
 =?utf-8?B?N1FCSEFIVFdXT2tOT0dnbGduNFRWTy8rTjBlbkF2SWtqbGtEeHlWLzRIdjRy?=
 =?utf-8?B?dXhZTWZYS3gxRThneWZ1RDlFeTdLcWNnbUhMYnBzYlJqYmdVMjRUTVpqNmVL?=
 =?utf-8?B?c3ZyZFRnbFBKYmZHeXNSSFpnQ3ZkUkJseHhQaEcvbTB1M0kzamx6M1kvL1dl?=
 =?utf-8?B?YVRnQ2xxUjlWRzZLdGVhNnQ5bDdXOHlsQUU3b3VocnpzRmVWMFFuMCtZYTN0?=
 =?utf-8?B?SHNscUZSSWFnK1BnaUlVaTJXWE5KMW5ocWZrcFJ1Z2U4NUcrVlJCRUxJN09C?=
 =?utf-8?B?ZlBTYXVSRi9iZkNJbXZJMFpMaDVPYkNHR2JUQXAzNWJoYVc2S1BlWXdjQ2RK?=
 =?utf-8?B?M2pRZVROZ3MwMWhJZTZxOEhuaG0ybzZKZ1Y4WkJxRWRiYzhoTmJsdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	f2BQoxTCVqOO+4SpXGMV9qNAMMEbChLkspyUgxxW9YOqza8q8J5Sx3Umnch0w/oCDwSQ2mtUO97MoAEULztm6vRw2wI5Iw+JzEEdnP/Tm7b4kZJQQOIc8WgyaFbXeyi9vBfe3QPJOXXVr4O0jdgJLGL2iAqaL6YCIkUt8Iv+GS3w8ElCXZfj2Oet4GEW8zAOsI+HmPW1zpPc07qTtimUM5USxKwamkGDLv5MdyVk1XHWgV5jz9skOMHico4SWwhVAIAGxzjcicZm5MC5xZZqbzGbDwuTpxhawDXmBiBMR4yNebR9GquJWbXWCQtBuga2ME/9bZljpR8rlf6KewSTXw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4603.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86519c5b-77f5-43ac-d73e-08deb58cb14f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 09:55:00.7892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QhBOGo4eEC4UomoH40X4mguR5DHdW1UlI98CZNlumeFxkMT81socVN+tNBQ9oGdZFDr8k2yim5YP+3vPsCWwMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4241
X-Proofpoint-GUID: I8hBflZOOVzxOU0zhVvmHvYCb96zfZtZ
X-Authority-Analysis: v=2.4 cv=KaPidwYD c=1 sm=1 tr=0 ts=6a0c3379 cx=c_pps
 a=QyNrOpZ8ttbodQqJgga0rw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=9R54UkLUAAAA:8 a=c92rfblmAAAA:8 a=xxv1aRCn4S_ur3tR6wUA:9 a=lqcHg5cX4UMA:10
 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YTcpBFlVQWkNscrzJ_Dz:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA5NyBTYWx0ZWRfX72ppR+CIp14D
 94e49SYkuMwQmMgkBqtbZAX9bLjBOVdad1hO/zwDeGi5SYCVkruyDmrpRXybbkTMdYE3H35Z/0y
 W7HBpL/P35B8u4wO2zMivAF8U3fRGaMy6mXbLdxLfyhFTmiBQlHQS8z2M3/bdBy3A0vHM00CuJU
 lBgqSTDPUlKE8vHAJ71FQg3ZuIICeR5BIovuIY2F76ViP6op+MSXXD/VNxJmAWyISp4Xy6jPN4H
 1mWTG7vMKPbz8Ug0TViujR1YJtHvVtMHWuxsNbZ4abi8l5PWlcYKSH01JM5jlmOTNuiUDAxFZE+
 zZLLlVg6kwBx6f+AB6jPd4n/kLijEFxRH9UKkIPWzMVmAG3HE0REQW7ZcVZ6VC8cLnpezyqVoGN
 TlCuJf6fZbBvLpQUwbwiMbANXPfdhH0euILKRrl2YEfjbFTZ0zcoflpBo6ilofyAUjiyGL/OdUs
 3dDkIRmVL1++vLf9jpA==
X-Proofpoint-ORIG-GUID: I8hBflZOOVzxOU0zhVvmHvYCb96zfZtZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
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
	TAGGED_FROM(0.00)[bounces-289375-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,CO1PR18MB4603.namprd18.prod.outlook.com:mid,marvell.com:email,marvell.com:dkim,sashiko.dev:url,linux.dev:url];
	DKIM_TRACE(0.00)[marvell.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D67C757BDDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gMTIgTWF5IDIwMjYsIFNpbW9uIEhvcm1hbiB3cm90ZToNCg0KPiBPbiBGcmksIE1heSAwOCwg
MjAyNiBhdCAwNTozMTo0N1BNICswNTMwLCBtYWlsdG86c3VraGRlZXBzQG1hcnZlbGwuY29tIHdy
b3RlOg0KPiBGcm9tOiBTdWtoZGVlcCBTaW5naCA8bWFpbHRvOnN1a2hkZWVwc0BtYXJ2ZWxsLmNv
bT4NCj4gDQo+IFRoaXMgc2VyaWVzIGFkZHMgSUVFRSAxNTg4IFBUUCBzdXBwb3J0IGZvciB0aGUg
QVFDMTEzIChBbnRpZ3VhKSBuZXR3b3JrDQo+IGNvbnRyb2xsZXIuIEFRQzExMyBpcyB0aGUgc3Vj
Y2Vzc29yIHRvIHRoZSBleGlzdGluZyBBUUMxMDcgKEF0bGFudGljKQ0KPiBjaGlwIGFscmVhZHkg
c3VwcG9ydGVkIGJ5IHRoZSBhdGxhbnRpYyBkcml2ZXIuDQo+DQo+IC4uLg0KPg0KPiBIaSBTdWto
ZGVlcCwNCj4NCj4gVGhlcmUgYXJlIEFJLWdlbmVyYXRlZCByZXZpZXdzIG9mIHRoaXMgcGF0Y2hz
ZXQgYXZhaWxhYmxlIG9uDQo+IGh0dHBzOi8vbmV0ZGV2LWFpLmJvdHMubGludXguZGV2IGFuZCBo
dHRwczovL3Nhc2hpa28uZGV2DQo+IHdpdGggc29tZSBvdmVybGFwIGJldHdlZW4gdGhlbS4NCj4N
Cj4gSSB3b3VsZCBhcHByZWNpYXRlIGl0IGlmIHlvdSBjb3VsZCBsb29rIG92ZXIgdGhlc2UgYW5k
IGFkZHJlc3MgaXNzdWVzIHRoYXQNCj4gYXJlIGVpdGhlciBpbnRyb2R1Y2VkIGJ5IG9yIGVmZmVj
dCB0aGUgZnVuY3Rpb25hbGl0eSBvZiB0aGlzIHBhdGNoLXNldC4gIEkNCj4gc3VnZ2VzdCBsZWF2
aW5nIG90aGVyIHByZS1leGlzdGluZyBpc3N1ZXMgYXMgZm9sbG93LXVwIHNvIGFzIG5vdCB0byBl
eHBhbmQNCj4gdGhlIHNjb3BlIG9mIHRoaXMgcGF0Y2gtc2V0Lg0KDQpUaGFuayB5b3UgZm9yIHRo
ZSBwb2ludGVycy4gSSBoYXZlIHJldmlld2VkIHRoZSBBSS1nZW5lcmF0ZWQgZmVlZGJhY2sgb24N
CmJvdGggc2l0ZXMgYW5kIHdpbGwgYWRkcmVzcyB0aGUgcmVsZXZhbnQgaXNzdWVzIGluIHYzLg0K
DQoNCg==

