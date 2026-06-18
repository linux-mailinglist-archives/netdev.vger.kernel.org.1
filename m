Return-Path: <netdev+bounces-300313-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +H12ObdzM2qHBwYAu9opvQ
	(envelope-from <netdev+bounces-300313-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 06:27:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 379C469D7E5
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 06:27:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b="e7Q/SrNS";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300313-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300313-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69BC3301039B
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 04:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E853B311940;
	Thu, 18 Jun 2026 04:26:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5907C37646E
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 04:26:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781756792; cv=none; b=oNpkCt/gjPp9a0roVCN0WaqBoQZNwS5hYrsP7IqWyvHJhp1cDPfHe8lKcWUA2qbor6Z70f67xkAVfWXE3CvZyWzMZLK4xZSJOBycmrfh1nh+4vxmsnF51M5BAF0NJ3IUxV8UO+aWRcJSx6ANtwYe5nxT387C1NvMQXQcK/UX1Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781756792; c=relaxed/simple;
	bh=Fk8cWVNN8hpFZ3zqXQy1i4Nn/sXrV/nZqhbQ7dEvj2Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=uIGCD8vZdoYNSf7vkxPZEo9prNJlgsQclnjnTcY8dDaAk7RyB+IjI5LWcD2lD0UwcgFNZu/cj0ICTOweAnVfJlDeSw7ld+AUNXGTgpyrm8PUD4Xq27S66trglBTZbWgBc7FbAlXcqjni80gQisL3lEfPp8hUlkZ4iuBNJg+0mAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=e7Q/SrNS; arc=none smtp.client-ip=170.10.153.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1781756790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fk8cWVNN8hpFZ3zqXQy1i4Nn/sXrV/nZqhbQ7dEvj2Q=;
	b=e7Q/SrNShRuTtsVrK0C4GYY2SUOXNg7uo3aK8Hj0rB3EMRV0Kk1wbc9Dc6xzHVnMNWfZsc
	yTW9htVO1A4qsHKwwrGitWnckh/JxOSYkz1hM3ZN11yNvVzLcx9hruRbQd0tQveSQME0oT
	J0YzIsxFnewili2W+TGQJRstFUDuU1yRSSUTwbN9e4Tuh/46n2tg7MbmJkxx6v/EXyHM5R
	DgBziYcny6Q560jnhqFB94kqYzvTl4V3OfaTjm8U/8Aqq2FMtwB0evRpxAbXy8+wWOjuJ5
	5SUc9OciH05pliKxVb26aSVu6lZQ4M2Pty+kPUBX977il8vpP4Gc3npiaC8faA==
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013044.outbound.protection.outlook.com
 [40.107.201.44]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-36-5TsXRuxINPOmsxHnl6K4Wg-2; Wed, 17 Jun 2026 21:26:25 -0700
X-MC-Unique: 5TsXRuxINPOmsxHnl6K4Wg-2
X-Mimecast-MFC-AGG-ID: 5TsXRuxINPOmsxHnl6K4Wg_1781756782
Received: from CYYPR02MB9828.namprd02.prod.outlook.com (2603:10b6:930:b8::20)
 by BN0PR02MB7885.namprd02.prod.outlook.com (2603:10b6:408:148::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 04:26:19 +0000
Received: from CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca]) by CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca%4]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 04:26:18 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: "Parthiban.Veerasooran@microchip.com"
	<Parthiban.Veerasooran@microchip.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, Piergiorgio Beruto
	<Pier.Beruto@onsemi.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Conor.Dooley@microchip.com"
	<Conor.Dooley@microchip.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH net v5 1/4] net: ethernet: oa_tc6: Interrupt is active
 low, level triggered.
Thread-Topic: [PATCH net v5 1/4] net: ethernet: oa_tc6: Interrupt is active
 low, level triggered.
Thread-Index: AQHc+e0nFxx0u09WdkC+bo9XNPrS8rZAt0OAgAMGobA=
Date: Thu, 18 Jun 2026 04:26:18 +0000
Message-ID: <CYYPR02MB9828CD98EEEB9B218A940E4483E32@CYYPR02MB9828.namprd02.prod.outlook.com>
References: <20260611-level-trigger-v5-0-4533a9e85ce2@onsemi.com>
 <20260611-level-trigger-v5-1-4533a9e85ce2@onsemi.com>
 <7c89df6b-32ac-46c8-8400-945879037f2e@microchip.com>
In-Reply-To: <7c89df6b-32ac-46c8-8400-945879037f2e@microchip.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR02MB9828:EE_|BN0PR02MB7885:EE_
x-ms-office365-filtering-correlation-id: df306944-f6bd-4671-47ce-08deccf1be4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|22082099003|18002099003|6133799003|38070700021|56012099006|4143699003|11063799006|921020
x-microsoft-antispam-message-info: 5EQUCuCCx5N3y4nPfuGZE0iCKJWCSEZ0sM5xWVdTriaCdae5yxaPUHtr5ksyYQm2HYPUUA+5FfhZah9983oEDYX0dYp5bmdnodsjKpgGmY8sDDfzu6orcbqVJv/OGKSqxYswdAdhvFxyz6qGs56L1kqeN42IvPXmxAUnx3fyZkJV75VomoKuy8wXPlBDNAtwJx4ZUyxhhFyCRDuaJCYiQlgbvGobIea7rDpwDd8AgpKs7u/hhnMYxtxxMfLmK4f7bHLCjFaso8ErbjqceuYaaApudm6mubQjarh4/SoUgWpDx3edYvfGhkBD5z/NiNe08eZRuqIFg/VNmi5z166w/fNOjo+WdmwP145QS0HJrEBpLzMaijwbNVwzWiaD7UqxewewrXedWJWAraUf4gV3F4jF5I6ujOLlOa0CFmbif+jXi8QU9mv5LpRAcJLwtpEyG6hhu4Asu3TeJdhl6FIeHINut+kF7M0CXurwAwIO9d3eqBDDm2jxcXy6c4Jmiy7IYpdDfTYqy9r46+RYRagWN0LgemRtnlcot3dhGWCEo5gw8eyWOjK+nD7lMQhYEwY7Ntvfg/iD1P6IY5CiqWhafYG7eDSmf4rrbusF4elcMoNeaLiPkJ40Ol0vn/9UiZTrIrZDUONCoe+UWTXlNpYwTca+Dcbstf30oFSvdsxi2FvkiAc0G7B1NH1Js1xrmNabVbmpUl/Z+hLS88z98DizdBpUvMkObykxfAY9Rz7uZjGTcMzbGNoboxDQBEt81CjEt0hyMYcZU87KEz0ECc0+sA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR02MB9828.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(22082099003)(18002099003)(6133799003)(38070700021)(56012099006)(4143699003)(11063799006)(921020);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1doY0tSbENhTTlENzRqTVoxYlFyVjdCeVFUZ0xxL0tJM3pEZFhpaGNnRjQ5?=
 =?utf-8?B?Ny9tNFdQOFdQeGdjRitMcU81dE9ORW90RkQwdVRqVzJZSUJ6bWhha0V4cS9k?=
 =?utf-8?B?NkZ1bXdibWJXN3E0bFNOYnRHbHkycUxrSHFkWGJrekdZN2FjZUtoNEVHTXZL?=
 =?utf-8?B?NG1PYVRVTWJCdUwxanZSb3lYT3N5MlRYQUpNYmcwU1Z3UTFPSnd1TUVRTEVa?=
 =?utf-8?B?VU9uKzdQS2pjd2NqbzRDT1dodHU0aEFHU09RMk1IVy94b1RqeS95eHREWVBl?=
 =?utf-8?B?ai9KTmJUeXN4bm96U3ZwTEdDR0poT0dyMWZmMkpaaTNYdGcxekp4Nkd5WE90?=
 =?utf-8?B?bkxQaWxaeG9NTjBGSXRYN2dkWmxXc256cHZVd0dCbkRMMGNuWnBnVisvSUJL?=
 =?utf-8?B?c3hwNUZzY0pRQWN5YytLU1dYbXY3SG1Zd09uRWRGSWdoV1ViNXpUTVo5VG5S?=
 =?utf-8?B?MGlXRXUxTkNyeVZjRFRJUGsxdjRpayt1MWZub2h2UGx5ZjVaS3B3UW5Fa3RK?=
 =?utf-8?B?M0ZDbzFFdWhleUdZcDFKc2dVY1ErdUZXa05sc1hwTHhsVjQ3ZGtYa083eDVO?=
 =?utf-8?B?b3owRHEyNmdRN0FhemIxUjFWT2RJS21LbDFMMTBWUXd3czRldTQyNis2M2Jt?=
 =?utf-8?B?RmZOZExmOE05RDdiZXhBUTArbSszWUNHYkthRmozMlVhdzBmUUdzWjMxRndE?=
 =?utf-8?B?cm9oRWMydmc2M3RjQXhzaTRVN3F0UjQ0eVNXQ21DU3hGd2dmbURCNU9TT1hR?=
 =?utf-8?B?MEpvMnlwdVQyT2xLdW5XdEpwUlIzMDRxUmd2Z0NXN1drQWwvaThvNG9uNGRX?=
 =?utf-8?B?dlFYdVBnSGxwaTREYi9BbnJnZ1NIQkRSLytKNVVhNmhrdTVXNlp5NHJnVHcv?=
 =?utf-8?B?ay9Va0NrNDRnOFd1VWlsOGhSZW83aUErU0l5RlBieCsycjQ1WC9YaGtQcUVs?=
 =?utf-8?B?TVBrWnU2VzllSXFsVHlxS0JoMVRkSUNrUitmcWhWcHNjYURMdkk1KzdLZXRa?=
 =?utf-8?B?YW5zMmxUVDVTQnJ3L1NXUzQwZjBEOTcyYVhURGFET01XYTRMSlRmRDhOYnhx?=
 =?utf-8?B?RmRnaDNyTXlaMXUrZm5BN0JvRitnbkw5TXY0eHBaOHhBZDRBRXh1THhzYWwy?=
 =?utf-8?B?NjRXb25ORnpZbURjYzNTeElLRVFueFpSdHNiUXVmR1E2NEN1QUdrNjFvaVVz?=
 =?utf-8?B?WkVZcC9ucEovditvTENNWDFSdWNzRFhEYVN0R1c5SXNaOS9RRE90V1IzRDVu?=
 =?utf-8?B?Z2pwalZhMnVBWXBjSkJTekRwdFVQQStQWUlrdGJxK0VaR3prazBJTkRuVjJL?=
 =?utf-8?B?US9hNEpWM3EvT3hWUHNEMTFNK0oxTGswRUxWM1dGK2hnSHU3OWpEUFk4M3NP?=
 =?utf-8?B?cEduZHhpTmtMemQ3WmVmYXBDajhmRUpXQ0JuSFp3ZXpxUEs2WUdjYmExcTJj?=
 =?utf-8?B?WDdGTkRmcTYwL1hUQTNTUW92V0FWZ1o4Tk5ZOHlSWWJ0OWltcDhTVUh6UHRS?=
 =?utf-8?B?c3ZVeTVCYmFpWmNhVVl1ZEdLWWRqT24rS2xpRFhTWXVyVWtsUDd1eUNQQ2NF?=
 =?utf-8?B?Tmx1TkRGV3NnMDdhSFhheUs5YjNEVTNTVXlxYWczdmZLaFB4dERwbnJRV2Zh?=
 =?utf-8?B?N1FmbFp6UlpiNHk4YWc2aFhDMFhiVUMzQWlEdUdYWFZWckNrTGRlWktic3hp?=
 =?utf-8?B?SkFhSHU2R2Q0bDhUSU9YYzgzR2dyem9IUXRqV2xMS2JRRUxWcFRnWUdaMWRp?=
 =?utf-8?B?elcxelNOeEVEbVBtaUVuWVRodEVaQUlPa0F2SmVta29NT3dkb0U3NldYRkVB?=
 =?utf-8?B?T2R4d3grMlpJS25TZVkxMDBSL24wWEJoZ3BrV3FpMmJOUUprdlJSWXpxYjZk?=
 =?utf-8?B?WW9nK3MvREhOaXF2QUQzQjFKdDlzaFVLMGpLYi9IRUY3b0F5Y0VtQm9aWmVV?=
 =?utf-8?B?RWpFL1ZwTjRRVVdsc3FGR1FYaGJVZ0NSRnFoMmVKMmtJZ2FaaWx2VmVxZkdZ?=
 =?utf-8?B?VUNxa3M3L29lSFB5WitRTHEwMGF2enQ0RkJ4K3JwOHhPcmNta3NtaGMyRk52?=
 =?utf-8?B?Mk5LMjlBM1Fac1FYT3ptMHdZUlVIWDE5QUdUNTZ1Yk1mYzFPNzNqd1YrYmVp?=
 =?utf-8?B?TGZ5bERmdXc0R2lTSnU5SmNhSVdnZm9Idkc1KzhUS0M2NTBvVlJoVGNnTmtI?=
 =?utf-8?B?N3BNTWNXZ0U3VDdlYVdPQTZVbmhWRVF0UzZrdHNsWTc2TjMyeUd5SFdKdzBQ?=
 =?utf-8?B?SFRwNWpSSjRHQTcySkk1RnVvaGVIRU9TSHN4dSs0eFRaMWU5aXU4Qlg0QjBH?=
 =?utf-8?B?dE9OS0lBWkZzUW5VNXhsVTdsckp6WlFkc3I0aGsxd1UzRDFCQkNEeHBibFNF?=
 =?utf-8?Q?HtCGXab1dWlk2uvo=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GwoL9KK8ivF7GNYzWCaFznfzR98ElHHCmUqXnzFBmxP60UbLWJO1te/1KmYuuvkNSYiWtLMOWFa/YtB0kvEmEc92pFunMmRDVd2U+mkM9OgCU75coIIRNAXdUCuZ9NBmCamnDiCD75KrqOJKb4+FCWdfYpu7LkXTIbHaGuFDiDpLcGwmpqEis5zy/h46AWvAzcEvIZHk5MwIl5EamFR433PkUYKzK2jSupR7UN7jfxlFviA1ULdRyuQZksWuWY6RX+f25KX49sOf7ZF5CrZrO/ILlSsWrQqYtUDtRlpEBc9+tTjr5JjYBs0HuEcoeU9RkmdTQ9sH/BHae+XYNAb0Bw==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR02MB9828.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df306944-f6bd-4671-47ce-08deccf1be4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 04:26:18.4239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RINr/n4KRFvN04JgW9FX/dsr3jY6gefusgGizrAz4aMDLg9Lrj7XP2eo54wTXi3b+yeIfN20HG79amPP5oo/q6CAHBHCCUSjnsOX6PtXmUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7885
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0Xp5VpaxqJmOvL7HMDyoojwPkAu8RFo_7vMLt1eiZc4_1781756782
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.56 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300313-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:Parthiban.Veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Pier.Beruto@onsemi.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Conor.Dooley@microchip.com,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[onsemi.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,CYYPR02MB9828.namprd02.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 379C469D7E5

PiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldCB2NSAxLzRdIG5ldDogZXRoZXJuZXQ6IG9hX3RjNjog
SW50ZXJydXB0IGlzIGFjdGl2ZSBsb3csIGxldmVsDQo+IHRyaWdnZXJlZC4NCj4gDQo+IA0KPiAN
Cj4gVGVzdCBjYXNlIDI6IFR3byBMQU44NjUxIGluc3RhbmNlcyBvbiB0aGUgc2FtZSBSUEk0DQo+
IA0KPiBTZXR1cDoNCj4gDQo+IFJQSTQgIzEgKyBMQU44NjUxIChJUDogMTkyLjE2OC4xMC4xMDEp
IDwtLS0gUlBJNCAjMiArIEVWQi1MQU44NjcwLVVTQg0KPiAoSVA6IDE5Mi4xNjguMTAuMTAyKQ0K
PiBSUEk0ICMxICsgTEFOODY1MSAoSVA6IDE5Mi4xNjguMjAuMTAxKSA8LS0tIFJQSTQgIzIgKyBF
VkItTEFOODY3MC1VU0INCj4gKElQOiAxOTIuMTY4LjIwLjEwMikNCj4gDQo+IFJlc3VsdDoNCj4g
DQoNClBhcnRoaWJhbiwNCg0KSXQgYXBwZWFycyB0aGF0IHdlIGNhbid0IHJlcHJvZHVjZSB0aGUg
Y3Jhc2ggeW91IHNhdyBpbiB5b3VyIHNldHVwLiBDb2RlIGhhcyBiZWVuIHJ1bm5pbmcNCmFsbCBk
YXkgd2l0aCA1KyBtaWxsaW9ucyBvZiAi4oSiUmVjZWl2ZSBidWZmZXIgb3ZlcmZsb3cgZXJyb3Ii
IChZZXMuIEkgYWRkZWQgYSBjb3VudGVyIHRvIHNlZSBob3cgDQptYW55IHRpbWVzLCBjb2RlIHJl
dHVybnMgRUFHQUlOIGVycm9yIGNvZGUpDQoNCk9uZSBvYnZpb3VzIHJlYXNvbiBpcyB0aGF0IG91
ciBFVkIgaGFzIG9ubHkgb25lIG5ldHdvcmsgaW50ZXJmYWNlLiBKdXN0IGxpa2UgeW91ciBzZXR1
cCBpbiBUZXN0IGNhc2UgMSwNCndoZXJlIHlvdSBkaWRuJ3Qgc2VlIGFueSBpc3N1ZS4NCg0KQUkg
cmV2aWV3IGJvdCBTYXNoaWtvIHN1Z2dlc3RlZCBvbmUgcG90ZW50aWFsIGlzc3VlIHdoZXJlIHNr
YiBwb2ludGVycyBhcmVuJ3QgcHJvdGVjdGVkLiBCdXQgdGhvc2UgDQpjb25jZXJucyBhcmUgaW4g
dHJhbnNtaXQgcGF0aC4gVGhpcyBjcmFzaCBzZWVtcyB0byBiZSBpbiByZWNlaXZlIHBhdGguIElm
IHlvdSB0aGluayB0aGF0IG1pZ2h0IGhlbHAsDQpJIGNhbiBnZW5lcmF0ZSBhIHBhdGNoIGZvciB0
aGF0Lg0KDQpXaGF0IGRvIHlvdSBzdWdnZXN0PyBTaW5jZSB5b3UgYXJlIGFibGUgdG8gc2VlIHRo
ZSBjcmFzaCwgd291bGQgeW91IGhhdmUgdGltZSB0byBpbnZlc3RpZ2F0ZT8NCg0KU2luY2VyZWx5
DQpTZWx2YQ0K


