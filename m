Return-Path: <netdev+bounces-295878-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L/dgAzvxImoqfgEAu9opvQ
	(envelope-from <netdev+bounces-295878-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 17:54:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 718FC649835
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 17:54:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=Tmxjpo3G;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295878-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295878-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3BE930E1446
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 15:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0108C3BA241;
	Fri,  5 Jun 2026 15:44:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F033B4439
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 15:44:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674298; cv=none; b=Wfm1GRdKP9Asxj9tvwbirugDMhDGbFmACW35oXxBnqnVBuBREZLzNChBHLLqSeCECnK7VExHFuBpF80cxjW5F0tGeDP6GvU85qJ4iE+CfsAjNb0Hsgn+dTi2WGUUPgVzE0+MvCSiY7xGg3WA/T7LXtHdPcf89iaIaas/QCtrHhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674298; c=relaxed/simple;
	bh=vkg+/5RnlmTXitJe/CvCE6slGXba7/DahK6XIN4z2E4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=CzBNUoQ4JjBHDMYogDSij+3qcvMk8A77SVfTpvFkqRBHCvpc3jXT2q0LB9CNDO+qPcWewFZt7x0a5Y2YeY9P3eRQWYYa3Bx5OLUG6Nz016Qk73hlBd/3ypMBeePn4a/Oq6mu+1vkzL47qPqokvxScCgG58lLKm6AwkC/ggiRcPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=Tmxjpo3G; arc=none smtp.client-ip=170.10.153.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780674291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vkg+/5RnlmTXitJe/CvCE6slGXba7/DahK6XIN4z2E4=;
	b=Tmxjpo3GGdcFANi9q+ERCIk3xe+bLzandl4MAo4+Pt/QB2xadcOySMTK0VcVryhOmlh8pG
	k03u3JIoaxflbXr6y49lIoV5jDOEBHanHoHircuz8mXiYYdpXZvmi601BdPBUCo0bY9UcY
	M3gJr2LR7ClGzWAe94CRyqhGKEY3vb+x493n6xrairao2jj6NWEw34AOhUx0BfhCE4yuYh
	YakqsLT5o5cn292IIuebc2HpF7UzS2Zx1ZYfamFRhce1dWc8QFSUbwYTxW1SmC0GbFCLNt
	LkCV3H5/pGCRcoJnyXmbH7AiYpElzMwFVwxzxwMiTlBAb++bh98hmI9I7VefJg==
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011055.outbound.protection.outlook.com [52.101.62.55])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-10-fHF7-MHaMSC6LRZCJT4jIw-2; Fri,
 05 Jun 2026 08:44:37 -0700
X-MC-Unique: fHF7-MHaMSC6LRZCJT4jIw-2
X-Mimecast-MFC-AGG-ID: fHF7-MHaMSC6LRZCJT4jIw_1780674273
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by PH0PR02MB8748.namprd02.prod.outlook.com (2603:10b6:510:db::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Fri, 5 Jun 2026
 15:44:31 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 15:44:30 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: "Jerry.Ray@microchip.com" <Jerry.Ray@microchip.com>, Piergiorgio Beruto
	<Pier.Beruto@onsemi.com>, "Parthiban.Veerasooran@microchip.com"
	<Parthiban.Veerasooran@microchip.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v3 06/14] net: ethernet: oa_tc6: Support for
 hardware timestamp
Thread-Topic: [PATCH net-next v3 06/14] net: ethernet: oa_tc6: Support for
 hardware timestamp
Thread-Index: AdzvmN2xAORlG4rISm+APIR4nWIH9QFU7NZgAATiPvA=
Date: Fri, 5 Jun 2026 15:44:30 +0000
Message-ID: <CY8PR02MB924971B4B8ED2F93B883263683112@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB92493D70B9443A982AB0305C83162@CY8PR02MB9249.namprd02.prod.outlook.com>
 <CH3PR11MB77238F88676369D0B20E3475EF112@CH3PR11MB7723.namprd11.prod.outlook.com>
In-Reply-To: <CH3PR11MB77238F88676369D0B20E3475EF112@CH3PR11MB7723.namprd11.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|PH0PR02MB8748:EE_
x-ms-office365-filtering-correlation-id: 3e142c0e-2b2b-4c8b-51b8-08dec3195556
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|38070700021|921020|56012099006|4143699003|11063799006|5023799004
x-microsoft-antispam-message-info: Krf75uO/CQj3E4/yXzaPe9rYeozPbaPXye9Kc38PnoG4WI/xE1VAUxXdFIzHPFfCcN3P6xF2aROSwrLMTzOlABoVYi5IuVyty9LqKaaFdoO8FVkIFqnbGEJqrv9ynZe4SViGz/leTNIgzRdabvudu9ccEtTfvlwiWXWl4LpXuuGiTzAW10w/LN8Ajjgn4pc+yKBakZ2MzCBiEmnVD+DA4obuaY3MOUvoE0yJH5PhkYzE5E1uMzCKbCiiTjde2FOHOhfcQepaugECiPf9YcHMWcXzHMp8h50swDZ9mzhGSovsVW9rpuOlIbMymuZnXMvENxnRk+MSkaCdHTHNUFKdQY62DERTBO28z4/itnojnWTDIfEB/2lMr3xceBEdP+MIUwTQbHtYE1dxUtic9Cg+b03ITRFk0cGHrtZVbwVbbzY1cviVRzMsyd/v+rLriaKZyIPjh31s/xiTaS7vqMxJbtmuXhWR1hRx8l2RnJEXWxBC2yV2o+pSmfzlWSi5pGRYk8E71jpoUrCaTOZWE/ol3ogs0xCW7jo/QCPgOmBl+QCDRHMocoKWPXF2bzABVaDTh5pzz5B1z/3DahRpyn7Hp67YV0TEmu7zV/HX1lQJArmwUgZy/Esjgms37d5HXAZgTxqplUXJ3jYb355fAvJ4oGUwb8BDNr/pZnrGrW0SzDgrx8wfkBFNB58cGSPoE1up1alYJ7mnJudJGcuMeA3aR/W8SBsmYpVloee/hGKRoE2jRdn0OylynzCLZkiMkjZfLU1Q1Bgp3OwirBYkYjGhcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(38070700021)(921020)(56012099006)(4143699003)(11063799006)(5023799004);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V01mL1QxdG4zRk9WSkxnTFlQUG9CZDR0bDB5YzVvSDNQd1FYMkZwWllXa0dj?=
 =?utf-8?B?ZGsxM3JVWlkxZk5qZHY1OEJOLzA3c0c3UkFQdWlLMitHTGs1dHJ1RzBJVVZo?=
 =?utf-8?B?ZTFsNjFRalVHYlNzQW8zR3UvdVdCdDZ6UmVzb3FIN2lLL0NXd2lFdEY3bUg3?=
 =?utf-8?B?YktrTDRoOUY2TzV2KzA1Qk1KeE9yS05QaDdLYklDdnZ1T1B6UkZUQm9wTWV2?=
 =?utf-8?B?VEtKN3hkNlNZUHN3bGZhQWpRUld2N0sxUS80ZjE4U0JhNHk3SWc4U0dMdEVR?=
 =?utf-8?B?ZVA2MkxuNkU3SFZIUkUzTTJNYVloLzBHeTlGQkozcS9LRjZYZkNONDRGU1dy?=
 =?utf-8?B?UURaQlpjQU1SY2FBS2ZwYjYzczNQTGZUZ2tXdFBhVjZJeVRKdFB0SVRXZmU5?=
 =?utf-8?B?ZmtEeEZvdWF3MWFTb1p3VUQ0MnVpeTh4RkU5UHJMb3RkaTRxcFhTNCt6STM0?=
 =?utf-8?B?TFBHcEQvaHd2U0FTM2NLWDBMTzhRQitpNGJidHAyRkxxTThzYVAyODdubWtv?=
 =?utf-8?B?M3VHVkNENjgrcGFWWEdlUm9xWXY1YVk5dWE1MkNWb0o0T0VFSm9ydGVzajBS?=
 =?utf-8?B?cVljaWxpcmtycVl3b214TTBKNlE1WmU3RVpyUkdNOXNnU29EaURCTE5iL2Ny?=
 =?utf-8?B?bzl6TVBDNjlmenptdmt4U3V3ZTJ6YXNESzBHWUM1UDJXWXB3dkxqc1plNjNn?=
 =?utf-8?B?dWdTcGNWMjdzUFFLa3QwcFlNdFNnUGNyM3FNMWlOdEJqNVdkVGltZG1VUjA3?=
 =?utf-8?B?MmZicFRZaUhodmdSN2tvWnpiRm9tQXFGdmxpa0JXNEdRTldUc1Y5UG9nRlRx?=
 =?utf-8?B?MHd4RDRjSnc1SHQzSVNOZ05sdjlReVhzNzZRYVA3VE9hT1hXU2ZzSXFRME5w?=
 =?utf-8?B?cG5lMnVTWVhrTUYxUm8rdVdjR1IwVnAzT1FBTE1JK0ZuNWhvaEJRZFVhMG9o?=
 =?utf-8?B?MTQ1blhtUzhSclA2MUQ3NHBVbk5lM0l4RkJ0QmE1L3hha2RQSTNOT1lBbmVw?=
 =?utf-8?B?WSt0K2VqZkNqa0VYZXp1Szhwc21tODVOMG9FOCtXaGhMZEJVVE9lcjF0bmFO?=
 =?utf-8?B?ek0wVHdpc0pzR0VNZjEzQUZtcmsxR1JNekY1SzJoTDJYamZ2YWlhNVg1bU11?=
 =?utf-8?B?U1FSSEdhbTd0dHVNZXptbncvT3FPL0huais3NnB5MlczbGNzajhReTJIWTVR?=
 =?utf-8?B?Q004czZOVTdvYzdqc1phWmcyYmZJUFZrTTU4cDhkNThDN1RjU2x3WUdsY3ZM?=
 =?utf-8?B?Wm9TcGFaanA5SzNXaGVKTFBkNWtQVVJEZVA3bUtsR2svN3ZtbWlMQzYrOEFl?=
 =?utf-8?B?V0QyMk1qdTFWMFJsNXNFb3FJbTN3SEl1cGM3dFFhZ1h3THZKQ2IxbWJob2JS?=
 =?utf-8?B?WTUwdDZ3NDJya0lBUXRGMmt4UVJtaHh1OUFnN2Q2OVRPTGpORTdPd09ES01l?=
 =?utf-8?B?UURpcVZobXphMk1wMkoxdkFGeWZTaEEwSFlFZ2IzS0VtdkhlaTZxaFMvWktR?=
 =?utf-8?B?STlxTXZ4YkVIZmgyT2RLam91NGZXVkZjUWlGdkhNakRPZG5jN25Vcm15Q2JT?=
 =?utf-8?B?L1ZsQ0o4aGJJeVFkTmxpR21jSjdLUTJici9jOU4vNHRQTTQ1S0lucmplcncy?=
 =?utf-8?B?aFAvc1hPN3U3cTVhbTB5Y0Z3MWl5MmZFSFdDSXFtK2ZvQ1RmT1ZQVm5FNnVF?=
 =?utf-8?B?OHNBTU1JOUdOWmorVE9kYmljaTVGc2VYYmg1b3NBY2RGamltYzBHTzdyMTBE?=
 =?utf-8?B?ZVRiaW14T1BnemJiMlRCRDNRUENuYmZrWGFMQ3dKT091bllQSlE0ODNZWm9V?=
 =?utf-8?B?NjhlQ1ROU1dKUEJDVXFHdFJaWGNscG5TUFh0MERSNU9iRE1hWW1oWFdxYnVL?=
 =?utf-8?B?ZmJ5QkU5Yzk2OXUveU5kdTErcFF6VCtucVB2ZE9yYU5LZ0dlZ3d1d052MzF3?=
 =?utf-8?B?SGNBVmQ2ZjNNa2FQR284K1IxdFVMUTJubUlFQ2dHZ1cvTWtLM29zWUVoZC8w?=
 =?utf-8?B?TXI0TUthd0IrZzNLYWlwR2lPb3JXanV3SFg5YjNtYjcxaDBuYXVTMEpiNFdO?=
 =?utf-8?B?b0RjSWlkMloyWkRoWXJPSGl4TU9Ua3ZUbCtwbjhaQVFlUFlRSVBoYnpLbWY3?=
 =?utf-8?B?S1BkVDRNVHNISk9Ib0doRWFOM1RtWjkrY1pjUGJXYWthZjlFMW9FWXFOTUdG?=
 =?utf-8?B?dzJxUzVXcjFzNW5ReTgvQ08rL2Izc08xR3dFakpiT2JnVW1oWlNJQW5FYUs4?=
 =?utf-8?B?ZFpwZmhvbzF5RnFWU3ZSMklYNHkrRi9LRHBpRGxLRmRLbGQxN1Bra3ZONFRC?=
 =?utf-8?B?bWhsbEh0REV4OXZ1RGtQSVZ0WUUwVGdmRTBpMUp5UFFDc2JFcU5WSEpZRjJE?=
 =?utf-8?Q?F0hG6SI64syAyQds=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MbR9IbyA3QzSjFVN8uPbiaOv8lMzFC9beLGSWziAr1raFbBVREkW0256re2wiqEuVygc6hT4/xLAsTIsRr190O5tgClAaHu0xvPaPppBz4hTp3MPkuIZVdR2ZpCNN1fSrFpbeZFi8lm7YGTMUjNWvlrcB27Ne9U+wuBXJKUCwUdO0j9d6XKr8QVZGL7WkdmNC15SxqqX2pWpK8pxoo4wCHPJPybS/pEij0nR53sVRHkH+vu1lv4B2Pp9nOr3XxgdwaNdRUDT8JkyZ/HzUZO5xEKP2KcX5ROdqFi4z7/KNO2qGvviJFrigJILAMP9yQcanHDZjbHWJ/1Ji6/aZeZY+g==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e142c0e-2b2b-4c8b-51b8-08dec3195556
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 15:44:30.5986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CcHnVRQrzqhvTWUhfIljmhN/JX5KMKJhQoJTvQW2zxHzF9nf0UrBpKNT0JhOAWxOmUM8LSaXX+FtKPDeO5S8TyImLrLt+2gd01jZHN735+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8748
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gkLjXwN4Rk03tY3_XIlY9TBp0nlCKjP5inqVa2-bbas_1780674273
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295878-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:Jerry.Ray@microchip.com,m:Pier.Beruto@onsemi.com,m:Parthiban.Veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[onsemi.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,CY8PR02MB9249.namprd02.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 718FC649835

PiANCj4gSGkgUmFqYWdvcGFsLA0KPiANCj4gSSBoYXZlIHVzZWQgeW91ciBvYV90YzYgZnJhbWV3
b3JrIHRvIGltcGxlbWVudCBQVFAgc3VwcG9ydA0KPiBmb3IgdGhlIE1pY3JvY2hpcCBMQU44NjUw
LiBXaGlsZSB3b3JraW5nIHRob3VnaCB0aGlzLCBJIGZvdW5kDQo+IHR3byBpc3N1ZXMgd2l0aCB0
aGUgZnJhbWV3b3JrIGFuZCBhIGxhdGVudCBpc3N1ZSByZWxhdGVkIHRvIFJYIEZDUy4NCj4gDQo+
IDEuIFRUU0NBIGNhcHR1cmUgYmFzZSAweDEwMTAgd3JvbmcuIFNob3VsZCBiZSAweDAwMTAgUHJv
dmVuIHRvIHdvcmsgZm9yIExBTjg2NTANCg0KDQpUaGFua3MgZm9yIHRlc3RpbmcgdGhlIFBUUCBz
dXBwb3J0IGFuZCBjYXRjaGluZyB0aGlzLiBJIGFtIGJvdGggaW50cmlndWVkIGFuZCBlbWJhcnJh
c3NlZC4gSW50cmlndWVkIGJlY2F1c2UgDQpob3cvd2h5IGl0IHdvcmtzIGluIG91ciBzZXR1cCB3
aXRoIHRoaXMgYWRkcmVzcy4gSSBuZWVkIHRvIGRpc2N1c3Mgd2l0aCBvdXIgaGFyZHdhcmUgZGVz
aWduZXIuDQoNCklycmVzcGVjdGl2ZSwgeW91IGFyZSByaWdodCBhbmQgdGhpcyBkZWZpbml0aW9u
IGlzIG5vdCBmb2xsb3dpbmcgdGhlIHNwZWNzLiBXaWxsIGZpeCB0aGlzIGluIG5leHQsIHY0IHN1
Ym1pc3Npb24NCg0KDQo+IDIuIEZUU0Ugd2l0aG91dCBGVFNTIGxlYWRzIHRvIDMyLWJpdCBwcmVw
ZW5kIHZzIDgtYnl0ZSBzdHJpcCwgY2F1c2luZyBhbGwgUlgNCj4gdG8gYmUgY29ycnVwdGVkIC0t
IENPTkZJRzAgbXVzdCBiZSAweEMwLg0KDQpJIGludGVudGlvbmFsbHkgbGVmdCBpdCBmb3IgdmVu
ZG9yIHNpZGUgY29kZSB0byBpbml0aWFsaXplIHBvc3Qgb2FfdGM2X2luaXQgYmVjYXVzZSBJIHRo
b3VnaHQgaXQgbWF5IGJlIHZlbmRvciBkZXBlbmRlbnQsDQp3aGV0aGVyIGEgdmVuZG9yIHN1cHBv
cnRzIDMyLWJpdCB0aW1lc3RhbXAgb3IgNjQtYml0IHRpbWVzdGFtcCwgIFRob3VnaCBJIHNheSB0
aGlzLCBvYV90YzYuYyByZWFkcyA2NCBiaXRzIG9mIA0KdGltZXN0YW1wIGRhdGEgd2l0aG91dCBj
aGVja2luZyB0aGlzIGJpdCwgYmVmb3JlIGNhbGxpbmcgc2tiX3RzdGFtcF90eCBvbiB0aGUgc2ti
LiBTbyBjb2RlIGlzIHdyaXR0ZW4gZm9yIDY0LWJpdHMgDQp0aW1lc3RhbXAuDQoNCkkgYW0gb3Bl
biB0byBzdWdnZXN0aW9ucyB3aGV0aGVyIEkgc2hvdWxkIG1vdmUgRlRTUyB0byBvYV90YzYuYyAN
Cg0KDQo+IDMuIFJYIEZDUyBub3Qgc3RyaXBwZWQgcHJvcGVybHksIHJlc3VsdGluZyBpbiBwdHA0
bCAiYmFkIG1lc3NhZ2UiDQoNCkV4cGVjdGVkIHVubGVzcyB2ZW5kb3Igc2lkZSBjb2RlIGhhcyAN
CiAgICAgICBuZGV2LT5od19mZWF0dXJlcyB8PSBORVRJRl9GX1JYRkNTOw0KQXMgeW91IGNvdWxk
IHNlZSwgDQoxKSBvYV90YzYuYyBjaGVja3MgZm9yIHRoaXMgYml0IGJlZm9yZSBzdHJpcHBpbmcg
dGhlIEZDUy4NCjIpIE91ciBjb2RlIChvbnNlbWkvczI1MDAuYykgaGFzIHRoaXMgc2V0IGFuZCAN
Cg0KSG9wZSB0aGlzIGlzIG9rLiBJZiBub3QsIG9wZW4gdG8gc3VnZ2VzdGlvbnMuIA0KDQo+IA0K
DQo=


