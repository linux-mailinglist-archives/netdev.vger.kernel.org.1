Return-Path: <netdev+bounces-302955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E3aoHvxIQ2ovWgoAu9opvQ
	(envelope-from <netdev+bounces-302955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:41:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3666E0500
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:41:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=E9SPzoZV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302955-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302955-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C2743002D03
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 04:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1253D6CB0;
	Tue, 30 Jun 2026 04:41:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B5C37C92C
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 04:41:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782794485; cv=none; b=baLHIoJhCQqEppCDCcJGPAHBP2RSFmFHiZesZrX8QN+v71+slY4Khs+b/KARaA/mArU+Qb21PnH8hs3+05WQOUW8UtjjuWhvcVdfG8yAGC2ge0vg9M6exjRvPtYQ634rCGoQ3JkI+OkwD0EDrBhPDuJMIfJXM4XT62aLPdi72Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782794485; c=relaxed/simple;
	bh=kvh8RvntUHxiVAct4O8cKAOM93DIFvzPHjN1nQG9ZDY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=aGpAzTdViH6SdbwfonPY4Nr1ePd8QOhQKPON3ubxTu/WshlD9J79Amqic5OYt7zd3TROsqN4ZOcl8H6WmABIlnRL259ak6VxCXw5mIFDpR6l7zi+i69KC2qCxsF2jPnBwAQdMMmh7jC1GDKhbfV7P0eLef7y9Bvos52VweqtLwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=E9SPzoZV; arc=none smtp.client-ip=170.10.153.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1782794483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kvh8RvntUHxiVAct4O8cKAOM93DIFvzPHjN1nQG9ZDY=;
	b=E9SPzoZV8Lfts8Ba5u3t9ncD40U4Sr2lRiUDeGUoQ2rk5dTT/kTv/CA+6GEZai86pL3aob
	FHPNI8H0r4p4Sk+WRCX0rPUJ4l7ow+heL8FVHVmNG9s7eIzyGIWiTfn3Nzh6yCS+UlenfE
	2yaVySUz8gyJbhMSWXfKkvvsLYwBABX2tAdPBpRUmQMNda3YGr8JVkxEFtagIzsxi7+S/A
	TO1CPRFTzxYQUtAZNd7K5SEGdodPou2SR0FLYL0TZlr4i+bP/sWHa7Hc0Kpzc4GpB2VGtu
	itSpRIS61aJ0ltuNAHs2nnFn3kPaOJn51Jye+ibp/s/Bq+qtTrRW8iytMK/LDQ==
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-26-YJcoaHRxO0aI3A7SPGUSdg-2; Mon,
 29 Jun 2026 21:41:17 -0700
X-MC-Unique: YJcoaHRxO0aI3A7SPGUSdg-2
X-Mimecast-MFC-AGG-ID: YJcoaHRxO0aI3A7SPGUSdg_1782794474
Received: from CYYPR02MB9828.namprd02.prod.outlook.com (2603:10b6:930:b8::20)
 by DM3PR02MB10255.namprd02.prod.outlook.com (2603:10b6:0:47::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 04:41:12 +0000
Received: from CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca]) by CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca%4]) with mapi id 15.21.0159.012; Tue, 30 Jun 2026
 04:41:12 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Jakub Kicinski <kuba@kernel.org>, Selvamani Rajagopal via B4 Relay
	<devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
CC: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>
Subject: RE: [PATCH net v2 2/2] net: ethernet: oa_tc6: Improvement in buffer
 overflow handling
Thread-Topic: [PATCH net v2 2/2] net: ethernet: oa_tc6: Improvement in buffer
 overflow handling
Thread-Index: AQHdBYF5CZg1uG2Gi0uYhx93Ba22XLZWZa6AgAAfIPA=
Date: Tue, 30 Jun 2026 04:41:12 +0000
Message-ID: <CYYPR02MB9828CDE148F00E6C78C70DD983F72@CYYPR02MB9828.namprd02.prod.outlook.com>
References: <20260626-fix-race-condition-and-crash-v2-0-b6c5c10e604f@onsemi.com>
	<20260626-fix-race-condition-and-crash-v2-2-b6c5c10e604f@onsemi.com>
 <20260629192959.445776c9@kernel.org>
In-Reply-To: <20260629192959.445776c9@kernel.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR02MB9828:EE_|DM3PR02MB10255:EE_
x-ms-office365-filtering-correlation-id: bff15e63-f43e-4e62-b377-08ded661cff9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|38070700021|4143699003|56012099006|11063799006|18002099003|22082099003
x-microsoft-antispam-message-info: 1Q1MsynPcZj9x7ud/b60lKB7/RGwsPgIkLpLotoB8NP5Ku+o0kE7+7SWoOLJQY108yKYlmSR8rdZFtKLJsy9oa8r2kE3F8yUZ489gkFKdM2KW+LMFeFSusqN4HcbQROCyyTE0tHkEMOUGMygNkZAWH+aTBbvMcwpOne4fYiGEJqfIxF2u1PF/PqI5DI0KpCPuORMlmOOheYuu7fhOp+nzWXIMZLsFJLXzUMrS/ui8R2qY2byCM345NRonZ+1Ub8RgyHsRLxWf3zU9M0snlrdWWcugMJoh5UHait15EARZlAun2f0mM/FyRb8I63u9+p72R5KBfGA8jehR9Sk/zWV0CSzAXfWUhGmGIaFPgcBktwVtjGBb/v53t4UNGP7jQ5UD+pL+Cbbedmaie/9h/UlucEmnExCksL+7AW2LzDMSYB4PhbgmrS0jhSeCCwe/AZLbBZkkWjU9qWHB8tRbuVTPNxyuWy4pAMsVJ8uvBNU/tXl56aEydZG65sNpzA4hUtUiNilY4O2nAKsgVEzRL9+6lsH0KaAFr9E9COKWu+Pt9OCT3nzjxdk99NyFUrgP0MUYbJFCPMsRBgO3Y64y5T20UfZDOHb1WkxLTjskia5euKKmCrWVn63paPZxOTSZyDVvY1iTYNqvYzLEbx2N1ZgQPKlOuWdjswLbzIb2iBEahU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR02MB9828.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(38070700021)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVh4cThKNnN3OWVaWHhaYXFtZ3k2WWd3cm9RaEJHNlBLc2ZNQUIralNjb3Mx?=
 =?utf-8?B?NUlLeCtvL1FFWEtTWUhDZXdMR2VYRWpDUHloS3dsREExMTBJaDB3N3NQcUZB?=
 =?utf-8?B?U2h2MGN6TUt4eVcxajU4RVljbVcrYU9kY1RZK3hWeFdpdmVIZkRYaVFUSzhJ?=
 =?utf-8?B?N3hyVDZvQXFuS3laKzExRzlwckZPdy9kM1hHTWhxRUlaRDRMWVVDMVFVeFp2?=
 =?utf-8?B?QlNUWjI0Mm9Pb1FubjlqcFd0WDdmTnBZWnZ6NnhPNk54azVYY0ZZSkUrdjdr?=
 =?utf-8?B?Qk9pNTlVWHoxRjExenZLSnJRUTNqL0E4dmE1QThFRk84L0pCRjZnaS8rYTV0?=
 =?utf-8?B?VFRKWVd4WTJRejN4bHh4RVorN0JXMTFDOWZNZlpseDR0eGN1YjMvaU81azVi?=
 =?utf-8?B?NTBSSkxkQXNTM2FPM2RIc2hDREZsbFBxWW1BbDY3SHNTWTJXRjNEOEdTMVYz?=
 =?utf-8?B?MGFWaTgrQjh1TVlzL0dUck80dkVHb0tDWTBpWGN2QkIvQ1cxakh1YjRHdlJT?=
 =?utf-8?B?Z2RNS3ZPVjRvMkUwNWNoZE5QK2hQakY3QnhBcmIxOThYeWxVTFRlNkpoYmxt?=
 =?utf-8?B?MkVGejh2WWdQNjBEUjE1aWpVZlFwODF6Q09XWkVhYTlNZ2J4TUttY1lLc3or?=
 =?utf-8?B?UERoVTl5d05FZWN1QTFkZmhTa2lGb1haL0tpRmF3R1RDL2k4U3Ruc1lIZ29K?=
 =?utf-8?B?Y3VKUlpPblBmdmV2Y2sySWcveXpJZEVqTFpIcXcxQUdrRDZ1OTFNVmpzMGVB?=
 =?utf-8?B?YkVQdWtMenRkOXdIM01DSlExUTNIVk1TNXlRMzd4K2s5UHluMmU2YnEwQmo5?=
 =?utf-8?B?WlR3eWhQSjd5Ukx6TW9FNEFiTXZvUks1VHNqZS9jeXVZb3BSdU4zT0loZjR4?=
 =?utf-8?B?VTdpQWFPSjgvUUVKeGorSnllai9vU1VVQTk5ZVpsNGJiblFyWDkyZVJsWmNi?=
 =?utf-8?B?NjdIc1JUNWtnK2ozRXJ5bUlVZ0dZVFNYcVcya2llcnRZcWUxS0NzYnZOZi9t?=
 =?utf-8?B?cCt3SElmUkozRGVMaVJUdmxnSTlPT2xZMVVXWDNoWTkzUlRlYTZNSXhGZ0Vp?=
 =?utf-8?B?MGowS04yZzZIZjRHR29pc0FOVkZnRlVvRnNhdDZ6RmJDWHk5aTJ6bElBMEJp?=
 =?utf-8?B?dXNrMzNNMU5TTkdlOVpXL0xORkIvcU1SWm1mVGVoZkltTFRJWlBoL29aQVk5?=
 =?utf-8?B?Q3E2RWxjalZNeFJwVWFVczVJR1c1Sk1uOHZ6SlBNT0F4VWdWYWNINHVPUGFs?=
 =?utf-8?B?VkZycjdHVk4ydkdzbzhZN2xBVmJsYmFLSDNVTzZ1Zi9zWFdmWTl5S1FEWkg4?=
 =?utf-8?B?WG1qZHRHK21UdmU5TjkrMlB6UkU3YWRnendSQklrSytEQVZFRVhkQ01WVGdz?=
 =?utf-8?B?RUdwbks0UlB6WUZJaFF1Y2lObS9kVXRjNmU5TU1YanQzMWZQNENhYjkxb0ND?=
 =?utf-8?B?YnVMZ2ZCa0w4SVltU05LYmJ5endXZGxGckpQV1dzREZDOVAyb21uK3JXUFBR?=
 =?utf-8?B?dUZvVnNpQ3JGMHhVNGE4eWJRUytVSk55VjhlM0QvUWJDaC9Xa2xwdmFhUHFF?=
 =?utf-8?B?VGpQM2dnbnA2OUFNL3ZiQzZ3cVh2bG1aVW01SEhEbVlnQVl4RDZzNDR4UlZp?=
 =?utf-8?B?R1UzWWFCUHVibkFGTGRJWXZaMEk3RytMUUo2Um1VSmIvUmEyRHBxdGw4WG9r?=
 =?utf-8?B?NCsrbk5zSWI4cXJQZFAybGx4OE16ZFpXdmZ0MEl3U2RHdnBycVJZbFpkZ1Mx?=
 =?utf-8?B?VTdSRmFDWlBaanI4RTM3MlRJT2dsQ29ZdFdaYkpLY21FaDlTZnJEd25CdWcy?=
 =?utf-8?B?UzJBdVB4dGdZR3BRV3VUVGVCclBpUVFvREdMbXQ1WUlKQWIyWHdFV0VUYzJP?=
 =?utf-8?B?Wk1QajVUSHc3QlJwRkdXNFRTQS8wM0RGZnBLK25UY2E4VlU0RFh1TDJCWk05?=
 =?utf-8?B?a3BwNnQ1TTZ3cUZzSVkzQ2lPVnZDbEw1WWh6dTZtVUFUQW94MmxXOTJHZGFs?=
 =?utf-8?B?RjRDbEJEbSs2VFNsUTZpbzFsM0s0clF4Q1pZSGFFblROdmRRWCtHVWk2Tldp?=
 =?utf-8?B?bFZWMHZRNkVqT2FQc1FkMlE0QkRZTkY3RmtHdjJOSFJVKzh4aHlLM2UzQVNB?=
 =?utf-8?B?VTVYSE9wSVBoYmNObHgzc1RIS2hEMTh1dzNaL0UrV1U5WVdxZkZWMEN6UXFQ?=
 =?utf-8?B?RTZraW44R2xBR1dXd0IxRzUwVWxTZXpaYjlQbXdqckxUYWhsSG5aR2lHSWRT?=
 =?utf-8?B?aFlOZDU4TVd6SnhuUGdDTHJ6bHA0akZXWXpoc3lnS0RsUWJTV0M2MEVIWDJD?=
 =?utf-8?B?TlpUYzFtRnN6ekxxbzMrSlZiYmdKZXZMenhjMUppSWFtU1pHMlJ2eHluMUtP?=
 =?utf-8?Q?ptHS4mhqxpdkcq+8=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qwfUO/k7PpDdQLNuG/nqGzju94gv9d6TthiAXN9z26bk6d0mZi/sYm/Z3N/33S92hiwPB0TCaxjwZFe3kf1Bai3ru3eqNXCCzbf/kmKUGvLR23WxzpnOqevuG4Nbc+cngaPitU9xrdv6DiXrERLneAdMb5Yr9r/+mvusGvou1ZkstJPkqrRlTVc+WnNMyspltHYyLqt3BFSXWzYrxOVclhnpkLzXzVz9KiUzx5o78Rdn438+/ziDtrN+CvMnHliuDjF8DUe4v7W4mC9UoCp8vPb0GPhIy1F2iwarDRZ6nWy5ajnEVO3YV9xunEu/t7hI3aXM6JtjNPFjEfuAXa9oRQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR02MB9828.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bff15e63-f43e-4e62-b377-08ded661cff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 04:41:12.1954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ex+Bo+zJJ3LpMGPJaN7y1h9hLZ84FpKed/IkkH+l09NEMR/8ctdZGhGQgsAtgPaj4wF7kQ5lv/+rQ3nzM3aFjbouwaKLmbHW0XT0zdnPQr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR02MB10255
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3s9OmYmZK2YaoPykRHj3Zmi3yabJ9hLSgx_8jgs3WXA_1782794474
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302955-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:devnull+Selvamani.Rajagopal.onsemi.com@kernel.org,m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:Pier.Beruto@onsemi.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:devnull@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,Selvamani.Rajagopal.onsemi.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[onsemi.com:dkim,onsemi.com:email,onsemi.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F3666E0500

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIEp1bmUgMjksIDIwMjYgNzozMCBQTQ0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIG5ldCB2MiAyLzJdIG5ldDogZXRoZXJuZXQ6IG9hX3RjNjogSW1w
cm92ZW1lbnQgaW4gYnVmZmVyIG92ZXJmbG93IGhhbmRsaW5nDQo+IA0KPiANCj4gVGhpcyBzb3Vu
ZHMgcmF0aGVyIHNjYXJ5LiBUaGUgZHJpdmVyIHNlZW1zIHRvIGhhdmUgbm8gbGVuZ3RoDQo+IGlu
Zm9ybWF0aW9uIHRvIGNvbmZpcm0gaXQgZ290IGFsbCB0aGUgY2h1bmtzLiBTbyBpZiBpdCBtaXNz
ZWQNCj4gYSBtaWRkbGUgY2h1bmsgd2Ugd2lsbCBuZXZlciBrbm93PyBBdCB0aGUgdmVyeSBsZWFz
dCB0aGlzIHNlZW1zDQo+IGxpa2Ugc29tZXRoaW5nIHdlIHNob3VsZCBpbmNyZW1lbnQgcnhfZXJy
b3IgZm9yLCBub3QganVzdCByeF9kcm9wcGVkPw0KDQpJZiBtaWRkbGUgY2h1bmsgaXMgbG9zdCwg
d2Ugd29uJ3Qga25vdy4gSWYgd2UgbG9vayBhdCBwcmNzX3J4X2NodW5rX3BheWxvYWQsIGl0IHJl
bGllcyBvbiBzdGFydF92YWxpZCANCmFuZCBlbmRfdmFsaWQgYml0cyBvbmx5LiBzdGFydF9ieXRl
X29mZnNldCBhbmQgZW5kX2J5dGVfb2Zmc2V0IGFyZSBhbHdheXMgYXNzb2NpYXRlZCB3aXRoIHRo
ZSBhYm92ZQ0KdHdvIGJpdHMuDQoNCldoZW4gcnggYnVmZmVyIG92ZXJmbG93IG9jY3Vycywgd2Ug
ZG9uJ3Qga25vdyB3aGV0aGVyIHRvIHRydXN0IHRoZSBkYXRhIGNodW5rIG9yIGxvc3QsIGlmIGxv
c3QsDQpob3cgbWFueSBsb3N0LCBzbywgd2UgZHJvcCBldmVyeXRoaW5nIGFuZCBzdGFydCBsb29r
aW5nIGZvciBuZXcgZnJhbWUgaW5kaWNhdGVkIGJ5ICJzdGFydF9iaXQiDQpUaGF0J3Mgd2h5IGRy
b3AgY291bnQgaXMgaW5jcmVtZW50ZWQuIA0KDQpJZiB3ZSBkaWcgZGVlcGVyLCB0aG91Z2ggd2Ug
aW5jcmVtZW50IHRoZSBkcm9wcGVkIGNvdW50IGJ5IG9uZS4gSXQgaXMgcG9zc2libGUgdGhhdCB3
ZSBtYXkgaGF2ZSBsb3N0IA0KbW9yZSB0aGFuIG9uZSBmcmFtZS4NCg0KRnVuY3Rpb24gcHJvY2Vz
c19zcGlfZGF0YV9yeF9idWYgIGJhaWxzIG91dCBvZiB0aGUgImZvciBsb29wIiB3aXRoIG51bWJl
cl9vZl9yeF9jaHVua3MsDQphZnRlciBFQUdBSU4gZXJyb3IgaXMgc2Vlbi4gV2UgZG9uJ3QgZ28g
dGhyb3VnaCBhbGwgdGhlIHJ4IGNodW5rcyB0aGF0IGFyZSBhbHJlYWR5IHJlY2VpdmVkLCB3aGVu
IA0Kd2Ugc3RhcnQgbG9va2luZyBmb3IgbmV4dCBkYXRhIGNodW5rcyB3aXRoICJzdGFydF9iaXQi
LiANCg0KVGhhdCBpbXByb3ZlbWVudCBpcyBmb3IgYW5vdGhlciB0aW1lLiBJIGRpZG4ndCB3YW50
IHRvIGNvbXBsaWNhdGUgdGhlIGNoYW5nZXMgZm9yIHRoaXMgZWZmb3J0Lg0KDQo+IA0KPiBSZWdh
cmRpbmcgdGhlIHBhdGNoIGl0c2VsZiwgSSdtIG5vdCBjbGVhciBvbiB3aHkgd2UgbmVlZCB0byBs
b29rDQo+IGZvciBuZXcgZnJhbWUuIFdpbGwgd2Ugbm90IG5vdGljZSB0aGUgc3RhcnQgYml0IGlt
bWVkaWF0ZWx5IGFuZA0KPiBjYWxsIG9hX3RjNl9hbGxvY2F0ZV9yeF9za2IoKSAoaWYgdGhlcmUg
aXMgaW5kZWVkIGEgc3RhcnQgYml0IGluIHRoZQ0KPiBzdHJlYW0/KQ0KPiANCg0KVGhlIGNodW5r
IHdpdGggInN0YXJ0X2JpdCIgY291bGQgYmUgbmV4dCBjaHVuayBvciAibnRoIiBjaHVuay4gV2Ug
ZG9uJ3Qga25vdy4NCldlIGtlZXAgdGhyb3dpbmcgYXdheSBpbmNvbWluZyBkYXRhIGNodW5rcyB1
bnRpbCB3ZSBzZWUgYSBjaHVuayB3aXRoIGRhdGFfYml0Lg0KDQo+IFNvIGhhbmRsaW5nIHNrYi1h
bHJlYWR5LWV4aXN0cyBpbiBvYV90YzZfYWxsb2NhdGVfcnhfc2tiKCkgc2VlbXMNCj4gbGlrZSBl
bm91Z2ggdG8gc3RhcnQgYSBuZXcgZnJhbWUuDQoNCg0KSSBkb24ndCB0aGluayB3ZSBjYW4gcmVs
eSBvbiB0aGlzLiBXaGF0IGlmIHdlIGdldCB0d28gY29udGludW91cyBkYXRhIGNodW5rcyB3aXRo
ICJzdGFydF9iaXQiIHNldA0Kd2l0aG91dCBlbmRfdmFsaWQgYml0PyBMYXRlciBza2Igd291bGQg
b3ZlcndyaXRlIHRoZSBwcmV2aW91cyBvbmUuIChlaXRoZXIgZHVlIHRvIGNvcnJ1cHRpb24gb3Ig
bG9zdCBjaHVua3MpDQoNCg0KPiANCj4gU2FzaGlrbyBoYXMgYW5vdGhlciBjb21tZW50Og0KDQpM
ZXQgbWUgcmVhZCBhdCB0aGUgU2FzaGlrbyByZXZpZXcgDQoNCj4gDQo+IGh0dHBzOi8vc2FzaGlr
by5kZXYvIy9wYXRjaHNldC8yMDI2MDYyNi1maXgtcmFjZS1jb25kaXRpb24tYW5kLWNyYXNoLXYy
LTEtDQo+IGI2YzVjMTBlNjA0ZkBvbnNlbWkuY29tDQo+IDxodHRwczovL3Nhc2hpa28uZGV2LyMv
cGF0Y2hzZXQvMjAyNjA2MjYtZml4LXJhY2UtY29uZGl0aW9uLWFuZC1jcmFzaC12Mi0xLWI2YzVj
MTBlNjA0ZkBvbnNlbWkuY29tDQo+ID1zYXNoaWtvLmRldj4NCj4gLS0NCj4gcHctYm90OiBjcg0K
DQo=


