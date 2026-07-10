Return-Path: <netdev+bounces-306642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hNNEGiI0UWryAgMAu9opvQ
	(envelope-from <netdev+bounces-306642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 20:04:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDEF73D2F1
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 20:04:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=EVp8K01M;
	dmarc=pass (policy=reject) header.from=onsemi.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306642-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306642-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4026C3013ECC
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 18:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877C136C0AB;
	Fri, 10 Jul 2026 18:03:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38E1261B71
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 18:03:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783706615; cv=none; b=tbUPwy5xtlE5xn1A43Ww/2SEyahZI9iVQRIAUqEbQmI/fV5843MURtzDLIcwnKTZNJz9uGCB1btc9QipmmZ5bLSvGZkCU5YmEDVDjzGsOOeL9niWdBz0u93nzSfk7D5XwoqcIUHFJF8veOkyr0j5vubOto5RrN37XhEqpi8P1vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783706615; c=relaxed/simple;
	bh=h2lwFS5wObsnxrlkBOqjBL09AG8fBsDE8agWADGnLWA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=DiyuqviuQoJ3dlJBYPCrH/cDkUexSVdNNPDUI/NwPMZ1ZHBkL1Ydd0gZnjdudWjxYfuYkdxsi7pD9F2yeQ5Uxf89ZBzdYPuMpYOY43ad046rGO6SLNqvrDgieCVVk/Flkm30eS16nJXOdHqNTDjobGWt3uZQakEjwQ8/aMRjk6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=EVp8K01M; arc=none smtp.client-ip=170.10.153.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1783706606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h2lwFS5wObsnxrlkBOqjBL09AG8fBsDE8agWADGnLWA=;
	b=EVp8K01MF68Ua0Xb2RkJzy1ZLo1tRMadKMnfvirvWfxKYWG1tBbEAANAiw0/NVfK/FeKmS
	R0VU0T2b1g+lKpxArRWHvW4o9CgR5lkKM+80CSjcQ6BYL103d1sO0rkqx/zPvV1UNKbHXr
	5I7hvw5h0kn9AJpjsHo9ECtujgbDY5Z/mPUgi3dSAUKlPLCnG5Y+LN9+zA3UQNCK+wqzuD
	Gg4QcSqdnkDHOueGmj5Kmt+FuA9f0jWBVp4zzV7IiX7O3BxsRXlbki9J2dMTFLDqS0ntqb
	b3b1mrRYrr0K0zyJ/nLPRaNgnJMwQ89reVxpDzbFr8twT224xkE+0mz4icb6Zg==
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-44-R1IHUdiGPmaR3b0p1Nrmyw-1; Fri,
 10 Jul 2026 11:03:22 -0700
X-MC-Unique: R1IHUdiGPmaR3b0p1Nrmyw-1
X-Mimecast-MFC-AGG-ID: R1IHUdiGPmaR3b0p1Nrmyw_1783706597
Received: from CYYPR02MB9828.namprd02.prod.outlook.com (2603:10b6:930:b8::20)
 by PH0PR02MB8504.namprd02.prod.outlook.com (2603:10b6:510:105::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 18:03:15 +0000
Received: from CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca]) by CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca%4]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 18:03:15 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Simon Horman <horms@kernel.org>
CC: "parthiban.veerasooran@microchip.com"
	<parthiban.veerasooran@microchip.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"Parthiban.Veerasooran@microchip.com" <Parthiban.Veerasooran@microchip.com>
Subject: RE: [PATCH net v3 2/3] net: ethernet: oa_tc6: Improvement in buffer
 overflow handling
Thread-Topic: [PATCH net v3 2/3] net: ethernet: oa_tc6: Improvement in buffer
 overflow handling
Thread-Index: AQHdDNIEPFihzRID2EWGXn7wp5MuZbZm1NMAgAAsO8A=
Date: Fri, 10 Jul 2026 18:03:15 +0000
Message-ID: <CYYPR02MB98283EE3CC63739D5F173C5583FD2@CYYPR02MB9828.namprd02.prod.outlook.com>
References: <20260705-fix-race-condition-and-crash-v3-2-3e51841e4d08@onsemi.com>
 <20260710142019.1619159-1-horms@kernel.org>
In-Reply-To: <20260710142019.1619159-1-horms@kernel.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR02MB9828:EE_|PH0PR02MB8504:EE_
x-ms-office365-filtering-correlation-id: 589c0694-f619-44e3-aca7-08dedead83d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|38070700021|56012099006|11063799006|4143699003|18002099003|22082099003
x-microsoft-antispam-message-info: 9UdciZdJ7sn3Y03xnJoHXZjNv8ikwigB7nkTWgRjKbKOW4srig+aYPtwmDQ/TkmHQzX4qYNs6ualfcj3ddSNqnMsOY8T5FZqP6J5Y0ykPJhxiWmV/QyT5q0ZoTfYNLh7oEwKL/AWSISUBS59OWAkkJpaGRg5jnnWgGiO8rDPXXMBTfLVKPv5IjCiZss6tSVO8Bic/P5U1FybYWjmUtvuHYlgCRiFKSi67iOs8BbeoMuVi4okWNotAhpgbtUWGfOjhdDM1xFxHJY3GedwPHDgn5fvuIXrfZUa0flJOlxfVEVKGHSOTDtbDjEiP4t2p49Q1i6PrkiashhBumbTe/7/DSeDQOAlc9351OwK3gRV0iEwHld4/cBgVx4yDB4ZSfAYxxDyfobBkbwg5ZBPlqPD6rtNo1FfNf5fX6+VB9DfV/jaGIXEOcVGljO8KtCSsWXypqc8W6p3uxu0J5XWCSs7JgrejttLzgBZjQEWBHrg1P/M08aWrBtdidlpMmM9jLN/D3tXfW9LccRROqkFhrG3KkKG4/TGHZWVFej1fQSL4lSWa5wQz8zjzA25G1fVoIN34cdBXja3O9rPE9EArDTMoOMXNKlICCWA+mlt2R1a3LvOthlHpCn11Y0x2kvkwhAygrvlQ54CcZ2mpXOswOQNKZEzQk9b856F/zvp4g9q92FQg9Z6v6gU0eoQjuMOXIGS5gboQkzC36PGlgnHCAlbKAJlRnTvypweInUZSsnThU0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR02MB9828.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(38070700021)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eklqZFJvaXNnTVpvUGpJZDVMNk4xOGRCYmh6c3VTNncySWF0UlZXZnByZkFx?=
 =?utf-8?B?WFZoc0FQU3dZOU1lQzVxNVpPdFNNVStCZ0hadksrVU1USURuTmpCNjJGSmdL?=
 =?utf-8?B?S1plMXhQTWtuVVhTNldjRzNIWDNIZWtFa0VadzBMZmYwQ0JFdzZ4MjcvOXZy?=
 =?utf-8?B?N0Q5bmI3Y2xRM21BdEpmV3JOQk1kM1I5NUlsbU5jY0crS1pyVVVkcUdSdHdx?=
 =?utf-8?B?bStzY3hGODdYajdsRWY5K09LL01ic2FvTGs1bDMyc2I5SkxCS3plZ1hzRjdh?=
 =?utf-8?B?SytxUitVTkNlaGw4cldjRDdoejE4UUFHbGdCc05MVmhIdWtYSFhlZjlDcGNr?=
 =?utf-8?B?bWtvSENlRG5GcW9LMnN3VDBOeHl1aXY5YzNoN0dWS1htTXhobnVnTExIbkRu?=
 =?utf-8?B?bmhjbGIwVWhlamF3Yk9IemdKYWJ4cUFRbDBmNXVYQmJFTTNIR2habTUxdk5m?=
 =?utf-8?B?eWZZQmk1bk1jTzNXSGtRMlVsYmV5ZmcrM2hiZEFQcG5CbktWeCtnZWVkWGg1?=
 =?utf-8?B?ZUFTRE53SU9nSXltdTdqRFBTWFp1M1pmdmxpRUc5V3hTZmJZTjNjUkNxeE4r?=
 =?utf-8?B?K1dyMVhTYTdDaHlKRkhrUC9nS1FyLzVRdGhtanVXUTI3WUtrSGo3NU4rUVR4?=
 =?utf-8?B?WktxUlFDNitmdXdWS2ZQRi9ldGI0OTJYYnpIQ3RYOUpWRU9WVW1FSjJnWHdv?=
 =?utf-8?B?OEM2bVpoL0M1UlMrRExCc0x6QnNSdEZKUUVTRS8xSWc5OGNVQzdoYUhYWC9s?=
 =?utf-8?B?SXRmakg4QzcwMkQ4RHZjTCtQWDJ5ZURESUVNdTN6cDFMN29GbmZiY2dSdEdS?=
 =?utf-8?B?S0JXemNKTGllZlc1R0ovWTFQMjN6eHlKUVkrbHF6MjdtVmg1NkYzWFVLUnhX?=
 =?utf-8?B?V1hZM1VLVkJnSldVazdTMTNIQWJFOHlHM2x1bm1sdWdzM3JLTUpteEZobHRE?=
 =?utf-8?B?ZDRBM2crdHZkT0tNbjN4VWJ5UzVEZmxHeUtpekZyeXFnUk0rUFBNM2E2MWFv?=
 =?utf-8?B?VzdUbndiTWZ3aTdmQm1Eb2F1bm9UZk5CQk9DNmg2L2ZsYS9VZloxY0hUZ2tC?=
 =?utf-8?B?REc0YTlEU21OdGxUSUx6ZjRxSmwwMlc4Qlgwbk9iaUlWU0JJTzZOOGRQVHFp?=
 =?utf-8?B?ZmdUZ1ZvVnd6MVk0ZCtmSVNVSzdNZUUwUGJxTzloSWpXOFRhUWNaUGdpcVVv?=
 =?utf-8?B?cSt1dE9NRmhrOVM3NWVhUlhITzQ3NmdpaEppUEJHeVJVeWdIVVBRYWJZL0pP?=
 =?utf-8?B?UjBwQmVTdG1YVHFIdmlNbmVXaGRRWTNIa2ROYVBQanl0ODZCeGJkNVlwN1Zq?=
 =?utf-8?B?ZDNnVFQ2UEI2NjA0NEMzWFpmY2oyTFladnZIMjh5Y1ZtSFR0cXQ0aHQ3RElp?=
 =?utf-8?B?NUNSN1RNZkV2Q3NPUWxPWFBPRjlhU0RadFloaVA3bk8zS0MxMmQ2U3dZeFNJ?=
 =?utf-8?B?UGFCTm40R1BiT0Nvb01IQURqSFQzaU5Gek1zMUN2bUxGVTREV3BwV3lJM2dq?=
 =?utf-8?B?Rmw0bjVDMThKSmZubWpCYktSOE1kTk1jeEQ0MkNpWm1IM3hjeDdmQ3dkck9H?=
 =?utf-8?B?ZWpZdGZRaTIyMU9Fa1M3cGw5WEpibzdJZWErMUhpRDI2VDljdTZGQ1Urd1hs?=
 =?utf-8?B?WU8rWThuaExEbzFzbHNJMi9KcXkxRkhqSFk5QzdobGduZGVmbXk3UEthcGQ1?=
 =?utf-8?B?Y2VIdnowUllWNmZRUUc4ODVITVo4WlhDOWtRak5wL041RGtGV2R5aG5UUGZo?=
 =?utf-8?B?c0FhZThYWDNzMk9YSW56Vm5VUk1xcUFnMjFBSWdMYWk1eVROa2F0d2hzVVNC?=
 =?utf-8?B?NHVucTUya09meENiRVNWOVlXZTB1Ri9VZTRvZjUycUtucGo0UlNyRGZSZ2lK?=
 =?utf-8?B?Zm8zOVJJUXd2RDY1eThKTEpQMDljNzV0LzV4bzdKcTRpS3FPQ3FVdkdYVjNy?=
 =?utf-8?B?WUhTNm04UTVic1dSZVczb1dzblFBRGlyZW9CRnk3SG93dU9SL282Umg0TWFV?=
 =?utf-8?B?cVM4endWVGZvTlkrbnp2Rm1Lc1czbFgrRXhYZXBQM2dzaXdMc3lGTjRTN0lv?=
 =?utf-8?B?MkJ0bWd5R0ttYUYzVVJsbHgra0QvZGVObzFhaVRkMzVpTXVMTU5rbXJaZXBU?=
 =?utf-8?B?dkV2SEthYTVESUhMMVFZOHluT0gzSy9QOWN2TUsydDNhRTNkNGZDekE5SFZu?=
 =?utf-8?B?UDgzNG9QTzcvRFVkYlNjckdCTmN3U09OY0xQT1g5N1JtTytaN043TmNwbDNx?=
 =?utf-8?B?cnJsd0FrWnhyeTJNeFFUTWZRcVgyRm1TWm9UOXRLYkZUOEZkZ3k2dWpxYW9w?=
 =?utf-8?B?d0JUUllNRU5BNERmcmVGL2VubHVKSVhXZEN2KzNlcC81M1REYW1tWVBGeE5y?=
 =?utf-8?Q?CxIA6Cj3Yeqz29Mo=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nFQWksHWDaVyeZ3RU1KiWD2+VqKhpGo9SUpNPB7E/xZarQC6VXCyUGhtlKRJFjcfcUjold7iF0A85tkTMRwkU8Fg2CJR15pPkqtFaIZjUuiYD6ztQznRA7I47nHVrR5CqVE/MEmD0rxOx9nt23Zb5cTZ9fQbdPrNcrD6E58qEQwnbNvRUrq+8dvqeTcX0kLJejr9SaX2BAafya6swzhjPelHoqmh/Dp6p9a8zDskNLyPV+5FWcFW2TN7qznOG0eVdUug5CNHLk+Q6ZHKAsjXpJ/rQYbtPm7oT1n9cU+MmlFZEY0KYuhr2eRjUqSRtiRQQNCgZaBlhbtfdpHrZcbkyw==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR02MB9828.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 589c0694-f619-44e3-aca7-08dedead83d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 18:03:15.5390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ilaMNgyKMGLdTFGYnjPwbRv87YvXJgD5npoycOIUD5MEh/ZoWaeTi5uHkuffJNRBNLrA775L2qls/urRWqJyfoXMqXLj/5CWaf2RdaYhG58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8504
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e-B7qRgNwKkk4TxabU4FsnbwGWu-LYZDX0F77eXi7rM_1783706597
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306642-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:Pier.Beruto@onsemi.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:Parthiban.Veerasooran@microchip.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[onsemi.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,CYYPR02MB9828.namprd02.prod.outlook.com:mid,microchip.com:email,onsemi.com:from_mime,onsemi.com:email,onsemi.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CCDEF73D2F1

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaW1vbiBIb3JtYW4gPGhvcm1z
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgSnVseSAxMCwgMjAyNiA3OjIwIEFNDQo+IFRv
OiBTZWx2YW1hbmkgUmFqYWdvcGFsIDxTZWx2YW1hbmkuUmFqYWdvcGFsQG9uc2VtaS5jb20+DQo+
IENjOiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+OyBwYXJ0aGliYW4udmVlcmFzb29y
YW5AbWljcm9jaGlwLmNvbTsNCg0KPiANCj4gW0hpZ2hdDQo+IE5vdyB0aGF0IG9hX3RjNl9wcmNz
X3J4X2ZyYW1lX2VuZCgpIHJldHVybnMgaW50IChhbmQgY2FuIHJldHVybiAtRUFHQUlODQo+IHZp
YSBvYV90YzZfdXBkYXRlX3J4X3NrYigpIHdoZW4gdGFpbCArIHNpemUgPiBlbmQpLCBzaG91bGQg
dGhlDQo+ICJwcmV2aW91cyByeCBmcmFtZSBlbmQgKyBuZXh0IHJ4IGZyYW1lIHN0YXJ0IiBicmFu
Y2ggYWxzbyBvYnNlcnZlIHRoZQ0KPiByZXR1cm4gdmFsdWU/IFRoYXQgYnJhbmNoIGlzIG5vdCBz
aG93biBpbiB0aGUgZGlmZiwgYnV0IGluIHRoZQ0KPiByZXN1bHRpbmcgZmlsZSBpdCByZWFkczoN
Cg0KDQpObyBuZWVkIHRvIGNoZWNrIHRoZSByZXR1cm4gdmFsdWUuIE15IGNvbW1lbnQgYmVsb3cg
Z2l2ZXMgdGhlIHJlYXNvbi4NCg0KPiANCj4gSWYgb2FfdGM2X3ByY3NfcnhfZnJhbWVfZW5kKCkg
aGVyZSByZXR1cm5zIC1FQUdBSU4sIG9hX3RjNl9sb29rX2Zvcl9uZXdfZnJhbWUoKQ0KPiBoYXMg
YWxyZWFkeSBzZXQgdGM2LT5yeF9idWZfb3ZlcmZsb3cgPSB0cnVlIGFuZCBjbGVhcmVkIHJ4X3Nr
Yi4gRXhlY3V0aW9uDQo+IHRoZW4gZmFsbHMgdGhyb3VnaCB0byBvYV90YzZfcHJjc19yeF9mcmFt
ZV9zdGFydCgpLCB3aGljaCBhbGxvY2F0ZXMgYQ0KPiBmcmVzaCByeF9za2IgYW5kIGNvcGllcyB0
aGUgc3RhcnQgYnl0ZXMsIGJ1dCB0YzYtPnJ4X2J1Zl9vdmVyZmxvdyBzdGF5cw0KPiB0cnVlIGJl
Y2F1c2UgdGhlIGd1YXJkDQoNClllcy4gVGhpcyBpcyBhbiBpc3N1ZS4gSSB3aWxsIGNsZWFyIHRo
ZSByeF9idWZfb3ZlcmZsb3cgdG8gZmFsc2UgYXMgdGhlIGNvbmRpdGlvbg0KZm9yIGNsZWFyaW5n
IGlzIHRvIHNlZSBhIHN0YXJ0X3ZhbGlkIGJpdCAoYS5rLmEgbmV3IGZyYW1lKS4gQW5kIHdlIGhh
dmUgYSBuZXcgZnJhbWUgDQp0byBwcm9jZXNzIGF0IHRoaXMgc3RhZ2UuDQoNCg0KPiANCj4gW01l
ZGl1bV0NCj4gSXMgaXQgaW50ZW50aW9uYWwgdGhhdCBhIHJlYWwgLUVOT01FTSBmcm9tIG9hX3Rj
Nl9wcmNzX3J4X2NodW5rX3BheWxvYWQoKQ0KPiAob3JpZ2luYXRpbmcgaW4gb2FfdGM2X2FsbG9j
YXRlX3J4X3NrYigpIC0+IG5ldGRldl9hbGxvY19za2JfaXBfYWxpZ24oKSkNCj4gaXMgbm93IGZv
bGRlZCBpbnRvIHRoZSByZXRyeSBwYXRoIGFuZCBjb252ZXJ0ZWQgdG8gLUVBR0FJTiBhdCB0aGUg
ZW5kDQo+IG9mIHRoaXMgZnVuY3Rpb24/DQoNCg0KWWVzLiBJdCBpcyBpbnRlbnRpb25hbC4gQ29k
ZSBjaGFuZ2VzIGF0dGVtcHQgdG8gcmVjb3ZlciBmcm9tIGVpdGhlciBFTk9NRU0gb3IgDQpFQUdB
SU4uIFJlY292ZXJ5IGFjdGlvbnMgb24gYm90aCBlcnJvcnMsIGFyZSBzYW1lLiBJIHdpbGwgYWRk
IHNvbWUgbW9yZSBjb21tZW50IA0KdG8gbWFrZSBpdCBjbGVhci4NCg0KDQo+IA0KPiBCZWZvcmUg
dGhpcyBwYXRjaCwgLUVOT01FTSBwcm9wYWdhdGVkIHVwIHRocm91Z2ggb2FfdGM2X3RyeV9zcGlf
dHJhbnNmZXIoKQ0KPiBhbmQgcHJvZHVjZWQgYSBuZXRkZXZfZXJyKCJEZXZpY2UgZXJyb3I6ICVk
IiwgcmV0KSBwbHVzDQo+IG9hX3RjNl9mcmVlX29uZ29pbmdfc2ticygpIGNsZWFudXAuIFdpdGgg
dGhpcyBjaGFuZ2UsIHRoZSBvdXRlciB3aGlsZQ0KPiBsb29wIHRyZWF0cyAtRUFHQUlOIGFzIG5v
bi1mYXRhbCwgc28gc3VzdGFpbmVkIG1lbW9yeSBleGhhdXN0aW9uIGlzDQo+IHJlcG9ydGVkIG9u
bHkgYXMgaW5jcmVtZW50cyB0byBzdGF0cy5yeF9kcm9wcGVkIGZyb20NCj4gb2FfdGM2X2FsbG9j
YXRlX3J4X3NrYigpLg0KPiANCj4gVGhlIGNvbW1pdCBtZXNzYWdlIGRlc2NyaWJlcyB0aGUgY2hh
bmdlIGFzIGJlaW5nIGFib3V0IGJ1ZmZlciBvdmVyZmxvdw0KPiBlcnJvcnM7IGlzIHRoZSBjaGFu
Z2UgaW4gdmlzaWJpbGl0eSBmb3IgYWxsb2NhdGlvbiBmYWlsdXJlcyBpbnRlbmRlZD8NCg0KDQpN
YXliZSBJIHdpbGwgY2hhbmdlIHRoZSBjb21taXQgbWVzc2FnZSBhcyAiaW1wcm92ZW1lbnQgaW4g
ZXJyb3IgcmVjb3ZlcnkiDQoNCg0KPiA+IH0NCj4gDQo+IFtIaWdoXQ0KPiBDYW4gdGhpcyB1bmNv
bmRpdGlvbmFsIG9hX3RjNl9sb29rX2Zvcl9uZXdfZnJhbWUoKSBkaXNjYXJkIGEgZnJhbWUgdGhh
dA0KPiB3YXMgc3VjY2Vzc2Z1bGx5IHN0YXJ0ZWQgbGF0ZXIgaW4gdGhlIHNhbWUgYnVmZmVyPw0K
PiANCj4gZ3VhcmQgaW4gb2FfdGM2X3ByY3NfcnhfY2h1bmtfcGF5bG9hZCgpIHVudGlsIHlldCBh
bm90aGVyIHN0YXJ0X3ZhbGlkDQo+IGFycml2ZXMuIFdvdWxkIGl0IGJlIHNhZmVyIHRvIG9ubHkg
Y2FsbCBvYV90YzZfbG9va19mb3JfbmV3X2ZyYW1lKCkNCj4gaGVyZSBpZiB0aGUgbGFzdCBpdGVy
YXRpb24gd2FzIHN0aWxsIGluIGFuIGVycm9yZWQgc3RhdGUsIGUuZy4gYnkNCj4gdHJhY2tpbmcg
dGhlIG91dGNvbWUgb2YgdGhlIG1vc3QgcmVjZW50IGNodW5rIHJhdGhlciB0aGFuIGFuIGFnZ3Jl
Z2F0ZQ0KPiByZXRyeSBmbGFnPw0KDQpJIGRvbid0IHRoaW5rIHRoZXJlIGlzIG5vICJiZXN0IG1l
dGhvZCIgdG8gc29sdmUgdGhpcyBpc3N1ZS4gQnV0IEkgYW0gb3BlbiB0byANCnN1Z2dlc3Rpb25z
LiBJbiBteSB2aWV3LCB3ZSBtYXkgaGF2ZSBtYW55IGRhdGEgY2h1bmtzIHdpdGggYnVmZmVyIG92
ZXJmbG93IA0Kc2V0LCBub3QganVzdCBvbmUgb3IgdHdvLiBJdCBpcyBoYXJkIHRvIHRlbGwgd2hl
dGhlciBldmVyeSBjaHVuayB3aXRoIG92ZXJmbG93IGVycm9yIA0KaGFzIGdvb2QgKG9yIGJhZCkg
ZGF0YS4gDQoNCkNvZGUgdHJlYXRzIHRoZSBkYXRhIGNodW5rIGFzIGdvb2QgaWYgdGhlcmUgaXMg
bm8gImJhZCBoZWFkZXIiIGJpdCBzZXQsIGFuZCAiZGF0YSB2YWxpZCINCmJpdCBpcyBzZXQsIHdo
aWNoIEkgdGhpbmsgaXMgZmFpci4NCg0KSGVyZSBhcmUgdGhlIGNob2ljZXMgSSBzZWUNCg0KMSkg
T3JpZ2luYWwgY29kZTogRGlzY2FyZGVkIGFsbCB0aGUgcmVjZWl2ZWQgY2h1bmtzIG9uY2Ugd2Ug
c2VlIG92ZXJmbG93IGVycm9yLg0KMikgQ3VycmVudCBjaGFuZ2U6IExldCB0aGUgbG9vcCByZWNv
dmVyIGFzIG1hbnkgZnJhbWVzIGFzIHBvc3NpYmxlIGZyb20NCiAgICB0aGUgZGF0YSBjaHVua3Mg
cmVjZWl2ZWQuIEF0IHRoZSBlbmQgb2YgdGhlIGxvb3AsIHdlIHRyYXNoIHdoYXQgaXMgbGVmdC4g
WWVzLiBJdCBpcyANCiAgICBwb3NzaWJsZSB0aGF0IHdlIG1heSB0cmFzaCBhIGxhc3Qgb25lIHRo
YXQgbWF5IGJlIGEgZ29vZCBvbmUuDQozKSBXaGF0IFNhc2hpa28gc2F5czogSWdub3JlIGNodW5r
IGVycm9ycyBpbiB0aGUgbWlkZGxlIG9yIGJlZ2lubmluZyBvZiB0aGUgbG9vcC4NCiAgICBKdXN0
IHdvcnJ5IGFib3V0IHRoZSByZWNlbnQgY2h1bmsgd2l0aCBlcnJvci4gDQoNCkkgZG9uJ3QgdGhp
bmsgd2UgY2FuIGFjY3VyYXRlbHkgdGVsbCB3aGV0aGVyIDIgaXMgYmV0dGVyIG9yIDMuIEl0IG1h
eSBlbnRpcmVseSBkZXBlbmQgb24NCmhvdyBtYW55IGNodW5rcyBhcmUgc2V0IHdpdGggb3ZlcmZs
b3cgZXJyb3IgaXQgYXQgYW55IGdpdmVuIHRpbWUuIA0KDQpJIGNhbiBjaGFuZ2UgdGhlIEltcGxl
bWVudGF0aW9uIGlmIHNvbWVvbmUgdGhpbmtzICMzIGlzIGJldHRlci4NCg0KPiANCj4gWyAuLi4g
XQ0KDQo=


