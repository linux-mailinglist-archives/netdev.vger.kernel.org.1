Return-Path: <netdev+bounces-302944-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IqhTKohDQ2r7WAoAu9opvQ
	(envelope-from <netdev+bounces-302944-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:18:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4B76E037D
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:18:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=Ew5hDZst;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302944-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302944-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A590D3038780
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 04:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1BD3E171E;
	Tue, 30 Jun 2026 04:16:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0CE3E121F
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 04:16:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793004; cv=none; b=ftbmHZzkB88xk9wkSg7CJjhqiW0KxONLYZJrnEGmc7qRICfRLSeHKFQ1JWeivV6taDvXkWdU9I3mTzxKZ1qoN9DcYOVH8zdQfXiXRNTpvD5dXmjv1JJSmD2uRq7gzaefIOJO3286B1saedLXRt5l8S206fQbE4NzO2Uer9/WicU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793004; c=relaxed/simple;
	bh=ul0PSuBlbUAOEuGRb4HiEcT0meNiqBhjAMbJVkQfMnw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=f2j+RrBrLfK3INoNVuEl7230eYUyyz4pHqLEpw+aHZxgQNl34j45uoiAz5WnUi2KWo7jdHjeReS5CHe8JUxns9bcHKxjD7mevEL/0MN3rkKBVLTTdtUjD0+Eu0UB2QOWqc6wtUJMTLY178ontxJQJl4qSq4bqZUGQLigx/7t5tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=Ew5hDZst; arc=none smtp.client-ip=170.10.151.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1782792997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ul0PSuBlbUAOEuGRb4HiEcT0meNiqBhjAMbJVkQfMnw=;
	b=Ew5hDZst+y1x1O9MECzsLM0AZw3XEQq0HIH7K51q62IBeBc7BR2Fo6RWBQRhKLqVb3mViB
	gtFspCW88BmSHoanTglFEBIhaxLO/XK0l4teA9LEfvp6rsTLDVajQ24827fyHuEP7cR1Bg
	5ogpghyM4QXNVtWIcKVMZghYMfNv28nfz14GOSFwls2GtFsfbf74o+Q9o+T9Vc6wmDJAee
	GOgeOV9R55M4xshbxS2fJvyoRJkwcqRtWqswWd/+hhkKn2QMCD0m3YY87jjREdL8mRKvZD
	E/eNsgybnvFRd4PC6nPEbAoWfS3ObqAu6Jac1m4eZS/OVJyFWwEt5rtDyYpgvw==
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012019.outbound.protection.outlook.com [40.107.209.19])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-71-9tu2hYhTOO6VLyvBm_xz5g-1; Mon,
 29 Jun 2026 21:16:27 -0700
X-MC-Unique: 9tu2hYhTOO6VLyvBm_xz5g-1
X-Mimecast-MFC-AGG-ID: 9tu2hYhTOO6VLyvBm_xz5g_1782792986
Received: from CYYPR02MB9828.namprd02.prod.outlook.com (2603:10b6:930:b8::20)
 by DM6PR02MB7097.namprd02.prod.outlook.com (2603:10b6:5:25d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 04:16:24 +0000
Received: from CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca]) by CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca%4]) with mapi id 15.21.0159.012; Tue, 30 Jun 2026
 04:16:24 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Jakub Kicinski <kuba@kernel.org>, Selvamani Rajagopal via B4 Relay
	<devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
CC: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>
Subject: RE: [PATCH net v2 1/2] net: ethernet: oa_tc6: Protect skb pointer
 used by two different kernel instances
Thread-Topic: [PATCH net v2 1/2] net: ethernet: oa_tc6: Protect skb pointer
 used by two different kernel instances
Thread-Index: AQHdBYF66FssyrlyDECu/NblP7SpALZWYb2AgAAeN2A=
Date: Tue, 30 Jun 2026 04:16:24 +0000
Message-ID: <CYYPR02MB9828DBA5FD39F4DB45FC890A83F72@CYYPR02MB9828.namprd02.prod.outlook.com>
References: <20260626-fix-race-condition-and-crash-v2-0-b6c5c10e604f@onsemi.com>
	<20260626-fix-race-condition-and-crash-v2-1-b6c5c10e604f@onsemi.com>
 <20260629191553.0a305168@kernel.org>
In-Reply-To: <20260629191553.0a305168@kernel.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR02MB9828:EE_|DM6PR02MB7097:EE_
x-ms-office365-filtering-correlation-id: b2d97756-0d14-424a-22b5-08ded65e5909
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|38070700021|18002099003|11063799006|5023799004|22082099003|4143699003|56012099006|6133799003
x-microsoft-antispam-message-info: LmCEbpXuJuzCx670KNCNmk1J75Dv/2aDPLw577PaudvGx6uVzi3v4PsJySK3aIDweQBSOXuPnKIfW6YpK2l/EHzq1msPEJRMfkyTpqwdIV1Il172ssMz11Z/LbCldB4eyIC57NjFxV10/L81GuB0MYvLhdm2yCKPlwFvcJe+leATLKGSaMWmTkNEeZukZrQ75wmdE7g+kQgkAI4E9W380lmeWKkH6XtLxWLVAebg1LzPlQjAb/EzFvq2BPvx1VeXkOoMR3ZWUW5ydpZoXCcXd0feH3nKhNufSYyL6PR5XYtM0RgDftUgPL8l5jtUhW2JCUArvP8ZWOVDNr/GdiKv+6rWiMCHJEqg364WBE1zkfY30u4RWhrJqbLDNSQovfL2e2+ylk/U0DpZiNwKZ6eHQCzishj/3FxvqOc1dsjGponAF/KItgD3pMWuBl0HLu3klnxuVmd0SPNNsxC2Hqmmdvtq5oDcX3PDGv4Bfkfe0wfqxAaxW8iT+QRe/pDJGHeyAWek9I+RD8zFPHyTpHUzgFNT+Glh++qaW8w43rE7JgGngubHyrGJQUkah9o3AvDVgYGke8ROG037ybmeVgwkDxvRuc88bW0rsXSARQS1i4mym0V+jX5JPPzoZAF1jx9G9JAvDsz6A48V1nlw0x5WmNfnEcx81gE9kl0tndarQxM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR02MB9828.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(38070700021)(18002099003)(11063799006)(5023799004)(22082099003)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUFhLzVjWDVvbDBxS295NGQ5dEZDVmp3SjRZSDEvU3A2bEh4Unpmbm1OZ3ov?=
 =?utf-8?B?ZitGU3Y1NmVHaGhFaHJPODBmd0JQRlRXZmMwZzNZbnlSbzEyRjRiTHBmOG9U?=
 =?utf-8?B?VTBnSWV4RVhoclp0Rk1vbkVDQVNvMzI0UnFPWWltY0dwMHRYbU00TTFvK3NP?=
 =?utf-8?B?cm0zVkhBeFd4bWtsakxBVWlUbDk0cXRzSGVkeW0zc0pEZWlsL0dsRytGT0Vk?=
 =?utf-8?B?Rml3N2NZQmMvdDJGU2c5dUVCVEpEM29ybGxmemE1TmpTdGVVUmtXSi9QMWww?=
 =?utf-8?B?ZnJEc0J0N2dNSUFaYXpGcGxzMmtQMTAzaFFpTDZZazBhRHppMUlkdzFpQjJ6?=
 =?utf-8?B?cndNamVEQkZnemw2cEFia2hyMXNFRzhVY1BSQmVnNU4veklEUXdYNmxndFdI?=
 =?utf-8?B?MXdsWFZXUFZjeERsMkNMVjFLb29USkFTMkh3S0JXNW0vUEVEbXU4RlQvczY4?=
 =?utf-8?B?ODU5MHBRanZJTjArbHJoT005eDZMRDlUWDZGQy9OUXJUN05IcmZ4VFRkeXo2?=
 =?utf-8?B?UzZGMXZVNGpMVGoyRWR2RzRKSjVZMFI2MTRldUpyaDgwVVBWYWF0OWhDOHVr?=
 =?utf-8?B?NXBvTUE1VWZRUzNNNlkzNGJoR0FZaHg0S1VpdmRyWU5zNDd5MWdjczU2VXhi?=
 =?utf-8?B?aURHbXNhL1BHbkYwSitzL1hDdzEwWFR6WGcxcXRvSzhUNHJXd1pEaGF4STMy?=
 =?utf-8?B?bzhjK2tIL3JKL3pSemE3REtYMS95V0s4N3RZYXUyczExYlVrR3YydksxMmQr?=
 =?utf-8?B?Uk15UzRtZlVqbnRBMDB6Z1Q4dXZlbTdOQVo5V1NqUHBCdkQrd0xaSEFDa2o0?=
 =?utf-8?B?NFlmcGwzUGk5cmxJY1hmUXNOdzZQbFV1c2NlTE5MaFlvZFBiZHRrYk50SkVp?=
 =?utf-8?B?enlXNG1yS3R3OUtOTkxDVDlKYXpWUFg5STErblA3c0dhSnFFdEdaSzJSRmwx?=
 =?utf-8?B?V21lakdXNS81aUszSTdWbXBsOW1aV3VYNFUrMnROcTE0bkIzNUo1MDZiR25F?=
 =?utf-8?B?NmUzQi9ZYzI5QVVzWE8xU09FUEtPWkNXWFo0NzIvcGNMS0NHeWIyczV6eFRa?=
 =?utf-8?B?V2g5SnkvckxQdGVMKysycXd1cVZsZDU4Q0ZvWGQvSURZczJvYXNXQlZSc09t?=
 =?utf-8?B?RVJUMWU3NU9NSUM2LzV1RVkzeGZXS2ppL1pVSTFLQUZPRStIS3R0a3ErdFR0?=
 =?utf-8?B?Ym1zMWt6WDRvQVErMTE0ajFZS0ZNL2xob2xmQmNTbVpPNjN1eDh6QUxoTEpj?=
 =?utf-8?B?R1BqSTdPbkgyMTZ5ZWpIWGFMdm1RUXhteDJOVUZTQmpabStNa0l2N2pibGNL?=
 =?utf-8?B?M1p0TVRPd3dRbHZmbjB4L1lCS1poVVEvMEtycU4ydVowbEdmWm5IaUE2eTd0?=
 =?utf-8?B?RjEvS0QxeEhXODlkTDBSSGpKeFJSd3RzTzVxRUFsMmJidUtBYmtTOUlEM1Vx?=
 =?utf-8?B?Snp3anByQlBUMXJmR3RJMVFoczlFemkwbGdrRlYzRE14allmR3gwdW8xSFFQ?=
 =?utf-8?B?NTlTVUg5Z0RnZHlocnMrRDZGeVFLaURxMmpTV0twYXUrNDVYck93N1hIQUtq?=
 =?utf-8?B?WlhOTXBjeHBiRGZSQkhlQWhNS28zLzJ0VXQxVUNMQ1NLNXZZVTFoZ2c3dGJY?=
 =?utf-8?B?SzhQSDIyNGc2RjV4cDZUU2dSblg0Q0MwaGtDTk5ZY2Fabld6WXdzazNqVkZv?=
 =?utf-8?B?RHZtb1g1M1JxRWtEZXdqckdMNlpSZm9XT1I5L2Y1MnVwNFpqZU9zalYrYVkw?=
 =?utf-8?B?dkd4U3l5OWpyRzloM1pRWjZ6aHZhcEw3dmJwRTh2RHUwMVREYkZiSEtoQXZY?=
 =?utf-8?B?MW9TR0RVNHY5eTVQNzM3eE9qZ1IrNmMvQURBV1RVNkNHMEpKbGhvWDFPUWFh?=
 =?utf-8?B?ZWdxM0ZRbGd1UzgxZ0o2d3EzK2pLY09qakttNWxsRlY2Z3BCZU5HVUJwV2lZ?=
 =?utf-8?B?V3RVU2kvOEViOHE3NlVKUW41bzg0WlZ4VzZoUWIzbE5aZ1RpclBHRyt3d3Bk?=
 =?utf-8?B?Smk3ZXU4TXNjdy9rSzJ0REdsYk02d0JRRFdFRmJaellNQXJaS1BJZ2w5YklD?=
 =?utf-8?B?Y3ZpU0k2bS9Ia3VudW91SmlmZHVUUGxzVy85Zkg5bEVaTDBmQmdaTEpBSzFq?=
 =?utf-8?B?Q2NYQXpSQm9aRnJ4alhwV1pLNVpqenZ2dGdmWnFjMkluNGVlRVlZZ0RpMlRv?=
 =?utf-8?B?WGQ4SWxGZDNONTRWd2JhTXcxSWhHQjk0UklEZndnazQvVk5wQjBFVDMzbFZR?=
 =?utf-8?B?ejBJemdrQ2UxNXNCTitNdi94Q3lGRURmT0VXcXJVZGd2UUJ0bGVLT2lUZGxR?=
 =?utf-8?B?dlpVZUpwWXo2WmhwUmpmR3o5d2NVVU1SeGVvdXJZT21NYzN2clhIaE9HWVlG?=
 =?utf-8?Q?8SEVqRhgV6FWz/9I=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XlHSPXrvrNlkOiYFg+Bypm6ZUy9a6HH/p38dAC+5FLBFiagGkBmgJr7GZ+Zatgyc1f1yQEllojEtQgfr57nYGtE0ZGOYW69Zt0E01XYtkw29SHpmx0sxbHuU4asRhPu7sLxg4vM10kmPTHGbAX9qLOs/21mx9xxpx4BGORInAt9x0Ag1Y0F9nun1PcoZBVxG60bTGNT898DOIawQG3Iut/i8nKCTHXFO4Kq7VLdjHlVvC4eIjupAP9HuInGwq8eppfSI/ilF3H99kS0+t37uGu+OwV+mCQt4Rah2On9eF0aXiv4Xc1aMW8IvxM7BiiVsABH/u2rTn+NuzJnnADGlOA==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR02MB9828.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d97756-0d14-424a-22b5-08ded65e5909
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 04:16:24.1970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 48biCZ/fqoXBGgtVXuZ4f9hyppe79wkkhag6tYkZrCoL8TRkaoFhLrxUv2AWbzJO/crAv09VyCxyeYVn0FsxIShw/2rVf2TVqWi57eT8nX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB7097
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4CbAOO2jYzq9U8mIAodmqam_HV7opzcHZtqbUWVSaEo_1782792986
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
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302944-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,Selvamani.Rajagopal.onsemi.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[onsemi.com:dkim,onsemi.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B4B76E037D

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldCB2MiAxLzJdIG5ldDogZXRo
ZXJuZXQ6IG9hX3RjNjogUHJvdGVjdCBza2IgcG9pbnRlciB1c2VkIGJ5IHR3bw0KPiBkaWZmZXJl
bnQga2VybmVsIGluc3RhbmNlcw0KPiANCj4gDQo+IE9uIEZyaSwgMjYgSnVuIDIwMjYgMDg6MzU6
MTggLTA3MDAgU2VsdmFtYW5pIFJhamFnb3BhbCB2aWEgQjQgUmVsYXkNCj4gd3JvdGU6DQo+ID4g
VGhyZWFkZWQgSVJRIHVzZXMgd2FpdGluZ190eF9za2IuIFRyYW5zbWl0IHBhdGggYWxzbyB1c2Vz
DQo+ID4gdGhpcyBwb2ludGVyIHdpdGhvdXQgYW55IG11dHVhbCBleGNsdXNpb24gcHJvdGVjdGlv
bi4gQXMgYQ0KPiA+IHJlc3VsdCwgaXQgbWlnaHQgbGVhayBza2IgYnVmZmVyLCBwYXJ0aWN1bGFy
bHkgdGhyZWFkZWQgSVJRDQo+ID4gcnVucyBpbiB0aGUgbWlkZGxlIG9mIHRyYW5tc21pdCBwYXRo
LCBuZWFyIHNrYl9saW5lYXJpemUuDQo+IA0KPiBDYW4geW91IHNheSBtb3JlID8gb25seSB4bWl0
IHNldHMgd2FpdGluZ190eF9za2IsIHRoZSBJUlENCj4gY2xlYXJzIGl0LiBTbyB3aHkgaXMgSVJR
IHJhY2luZyB3aXRoIHhtaXQgbGVhZGluZyB0byBkcm9wcz8NCg0KSSBiZWxpZXZlIHhtaXQgcGF0
aCBhbmQgSVJRIHRocmVhZCB3b3VsZCBydW4gaW4gZGlmZmVyZW50IGtlcm5lbCBpbnN0YW5jZXMu
IEltYWdpbmUgb2FfdGM2X3RyeV9zcGlfdHJhbnNmZXINCmNhbGwgZmFpbHMgaW4gdGhyZWFkZWQg
SVJRLiBJdCB3b3VsZCBzZXQgZGlzYWJsZV9pcnEuIElmIHhtaXQgZnVuY3Rpb24gZGlkbid0IHNl
ZSB0aGF0IHdoZW4gaXQgY2hlY2tlZCwgYnV0IGl0IGlzIHNldA0KYmVmb3JlIHBsYWNpbmcgc2ti
IGJ1ZmZlciBpbiB0aGUgd2FpdGluZ190eF9za2IgcG9pbnRlciAoZHVlIHRvIHNrYl9saW5lYXJp
emUgZm9yIGV4YW1wbGUpLCB0aGUgc2tiIHdvdWxkIGJlIHN0dWNrDQppbiB3YWl0aW5nX3R4X3Nr
Yi4NCg0KQWxzbywgU2VlIHRoZSBTYXNoaWtvIHJldmlldyB0aGF0IGdhdmUgYSBTTVAgdXNlLWNh
c2UuIElmIHlvdSBzZWFyY2ggZm9yIENQVTAgMHIgQ1BVMSwgeW91IHdvdWxkIGZpbmQgdGhlIHVz
ZSBjYXNlLg0KDQpodHRwczovL25ldGRldi1haS5ib3RzLmxpbnV4LmRldi9zYXNoaWtvLyMvcGF0
Y2hzZXQvMjAyNjA2MTEtbGV2ZWwtdHJpZ2dlci12NS0wLTQ1MzNhOWU4NWNlMiU0MG9uc2VtaS5j
b20NCg==


