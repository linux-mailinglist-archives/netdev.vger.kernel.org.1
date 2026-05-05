Return-Path: <netdev+bounces-284294-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AHqKsK/+WlqDAMAu9opvQ
	(envelope-from <netdev+bounces-284294-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 12:00:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 497D64CA4FB
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 12:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BB6630827C1
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 09:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADE43CF034;
	Tue,  5 May 2026 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b="C9m0aIJ3"
X-Original-To: netdev@vger.kernel.org
Received: from FR4P281CU032.outbound.protection.outlook.com (mail-germanywestcentralazon11022109.outbound.protection.outlook.com [40.107.149.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2506D3A5E92
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777974792; cv=fail; b=smSnT/Fjw8ug1e8cJyaD1W/vcBG2gj+TqOfJIrGmDPjIvfDe5YLNUpZcPldL9CQTG9m47a34a3iNAw5lTyZlEcrI1fAQQcDKDBmpwqoidsq6CVZnVOgNvgRADxGY2cj29KiTjzLnOx+kAck6bcJniirFA2WnpFafzHTDNdnEuO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777974792; c=relaxed/simple;
	bh=MWqxtj/EQzA7MV2dDxV7AjDTNrFqgg2HaXC7wdeQJYg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=amxE+bwbVqPQsrRfnP2lkv6lR0wdIPHKj2fzlFf9ValTjX0N9IIfCRLlbJYz5xMbL22Ta4ZwxxZJpgT3wM3DuqZuQPdcKo0nieBxqKE1w38yUKHnu2hxYfj4+2aLl5EFVlSvkxn6cSLPW0Oz9qjX/PzGKz0j3hSwAOlCVZ/asHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de; spf=pass smtp.mailfrom=schleissheimer.de; dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b=C9m0aIJ3; arc=fail smtp.client-ip=40.107.149.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schleissheimer.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UP5z7cKKhK1Dc0meVxCl5L4I7hrC2oTuL9kEcR7Bk3CjHqqUucYBAeYPKut6YcA1veWd82HkAoJtPxe7eaDdlw3z4i+3/RWcraY0npVBa1oJKWuhgJFIY333pIdFzoqf65Qiu2MT41eVfe9X76VjSUqde507pN5371vDl9SAqzXTBNyDt5Y8mFvwtJ7oyFrMjEhYnKVOK2Frn1qGZ9SUAmR0p70qOlTnY0fuURi1V826ySuv2QCh9HASk3vdr3A9nYabYAWiZXywXiVK0sdIQKZ9U6BNYyz8NhObUUY6cEWmLYCGpfPJ/IN6NfC+kQWWB4ZIUxW2fCV+TEyhkeQkjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWqxtj/EQzA7MV2dDxV7AjDTNrFqgg2HaXC7wdeQJYg=;
 b=Po+e7+rtZQ+A/TPVgPlG5PDkLGKRhMFoKOPGC5k4PKHKPZ3eoKqwotifSGFefrooCN+mpkECnhV4GUEdgVdjd4XtJPB8d9dlyyUMZWpmjooQVgM746On3xrUnEYTeNDER30ZUaf3lVsqZSM5TBetJMuesbjtXKYUsHz1JOrCHDWCa3VPIR7AYZ9WR2wr0OnidS1pLMZBhQOcSSpmxhxaexd8EyCb6H/t7ycnr39wPuVbuNnmktRATL8AFf3PheSNB7prtS1AUZt1eIXxz1qfHyVv3L3xgVX34DzC/s65YAVYrD32y5m7V9X7rOHlTq1ncAwHpWy069ZjJ5LHL2EO9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWqxtj/EQzA7MV2dDxV7AjDTNrFqgg2HaXC7wdeQJYg=;
 b=C9m0aIJ3cpIs9y6D6uDeJ1hrXpZZY6UIZegukVEjrex+s+bAHlkNkuP6lMjx3gVPRTbNKp/VYWVBaFaMinDP1vL8FLp8tlsVMbXFc4Dnx75L+sgcRPckkV1dA4FRvXC/nj7SJTcCViIgHgnuIC+oeP8EFswMioDeEb1QmeMXJL8=
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:52::10)
 by FR0P281MB1984.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:28::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 09:53:06 +0000
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2bc1:32a6:153:c3e9]) by BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2bc1:32a6:153:c3e9%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 09:53:06 +0000
From: Sven Schuchmann <schuchmann@schleissheimer.de>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: assert in phylink.c with lan7801 and dp83tc811 since kernel 6.18
Thread-Topic: assert in phylink.c with lan7801 and dp83tc811 since kernel 6.18
Thread-Index: AQHc3HSt2FaNRg+Hc0Clgdk/8rilDw==
Date: Tue, 5 May 2026 09:53:06 +0000
Message-ID:
 <BEZP281MB224533D524B27CFC6E47B447D93E2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=schleissheimer.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2245:EE_|FR0P281MB1984:EE_
x-ms-office365-filtering-correlation-id: 80efea25-3d72-4bbe-aa86-08deaa8c1b7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 FdVJrfXficR0bq3iVFutncdBmfTx9lW8kSWkYQSCreQ9NXLUbO1aHoLNhVpw9ehUoIWxjn+8odoZzdRQIlnOxc3nx9CNlY+QLcD9EioN/OJmO84zRBJPYt8k/o9AHkZdKPMcxftwq9+uZoEeLMHLKaN5cZXeGQmcuWDVPtrvxg4ZDiwoe6WFVqlO4X5EzksHDOZu7YbBkDIxdgXIKAP2mX4Uo7tO0D8okDdholxfPhqSuULE0868hRxfBJqcU60voxEZTvRPG3CoQ4idialncMEcpeiHT5mwbP0Gpbjcv3VrgKmGbtNpNblLeXUmSIR3+bsjkfcps9ZViRFjqLvUKm43vuGajYb9xRoyV4+5BassDewj9ggF6G8GDupAOmh7AXSkXAVV4+iyVfsBQj2pS3Fq5pw/MjBJFMjaqO6R815SYXTw1j6y6zs+rRlZKcWjkxCaf/NzxozlUVTPk2ANJ1scBqJNJNq9E0BWONe2URQcIPgiTTAzk95U0cbQhjnV7JRqf9phFS9j4I3iZ6acDrlLVRH6C7BMLT86T4DOMdeW1XeCouCg3GDqpEALhfqrxQNXYgSSX9MIHSKdg5KkZvUrQFPa3JbM+tE8xPDlxVTasK1BpTkBIbIU7miojhRvVdq4vQMA/F3SS7V7VLJSyvnO6nONWSPkmux/Ehuyfau9qbLDDiRsYFZXMum0mSKOptRz57/p9JTZ9r6AZgCV2np5tammx7a7gcHokzBnGjNacyBV/0egcSJf6T5ABxbH
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NkNJdEdJb2swT3RhRE5WSHVFYlJoN21uazBWaDdBL3dBbVRYQVZpdFBzTHlz?=
 =?utf-8?B?MXRUcVRVaHhONGdNWG9GUTdnZUVzKy95Vy81TzVXN290ZWt3ZGdxWm13Y2Vx?=
 =?utf-8?B?b3hqbXBUWjNCSlFXT3I5U1Fta21PbldCRmxxQ1JsR3BSdENOWldMUmJlbDRj?=
 =?utf-8?B?bVA1S2dnVURGMFZhdC9KNE5HcHdsT0JYN1pTYVUxdmxyUkNuaXR2a3dGYy9N?=
 =?utf-8?B?akhYc1Q2ZmhTc2RwdmpHMEdubG0rUWVqbnJERHVHR0x3WFZDU1lnd3A4UUFs?=
 =?utf-8?B?Q2NycVlqR3JjZmdHRnlNR2N6UFIzNTJBeWFOS1BEcVBVWnpHSFFtbmkrS3Jh?=
 =?utf-8?B?cElCV05BWW9JOTNVWTVGdWlmdXhhcXYzOVJWVUIvNmNWdmduOGVhRFR4TGQv?=
 =?utf-8?B?bTVvR1U4aVBadTJYa2d6NStDcTJGdVpMWDdOMHN0bVpSdlNBa1U3ck1TT1Jo?=
 =?utf-8?B?eVNWcHdUcExiYWlYQjZhcDJmaC9Xam51VkNYKzdZeUFpU25FdUZkVnV6bWFv?=
 =?utf-8?B?R0hJWDh3dFhWaGFUbVN5bDBUblpLc01yLzV5TVAwMWtmNG5kWE9MM25GOXNM?=
 =?utf-8?B?TnNXSDNFZTRzTXA0QWlmcnFuLzdhS0hOZkhJK24zeisvN094ZzZ3c05BTGhw?=
 =?utf-8?B?KzZQZk10amo1L2dMVHZaQ0U5V3drS3BjbUtmZkhzamdwSDR5LzR1ejg4Slo1?=
 =?utf-8?B?YlZCWFd2aXRGMWd5TnZTbll2L0lDWXFpRkxuNWVjRC9DRVZhcmZEMlV4ZDVk?=
 =?utf-8?B?VjNNRzNqalJVSTYza2JkMnRhSG1MOWkwajgrRnRiYUFSa3JHZmE3dXlXb1FX?=
 =?utf-8?B?VUJBa3ErTFJWUGpLQ2thNlA3UE4zcGM5UmF2NWJuUzVZVFl6RmVhZG5tVWgz?=
 =?utf-8?B?SDhnQmV5dlJGUWlJQzZJT2s4Z1FQdXNQTi9KU0pFdEJiVzRqckJJd0RBYTFy?=
 =?utf-8?B?ZTVRSEhzbXltdmxxOTNnbyt1NlVZK2M0akVkK1JSeUJUcHduNHpYeG9nTzRO?=
 =?utf-8?B?STdZVWIrQ3dSNVZnS1N1dTdxVDFnZ1gwTitCM3NLL0NUZ2xwV0k2TS9DS2ZO?=
 =?utf-8?B?SXdwMlo5VzJ0a2hPOXdQdHhQU1NTa3M1VHVOc2h4dWQ5VFRCZmRvU1YxL3Bu?=
 =?utf-8?B?VGVJTmg4VTU4anBpbnNldVJjMjdlVUI1ZWpEWVFOQkU4Z2xhKzlOaFFFV2du?=
 =?utf-8?B?Yms3M1kzQ25IaHFCaFQyMTVRVWk1NTFJS1ZPbldJNkY0TklDVHJXMmNPNy9O?=
 =?utf-8?B?ckFlcUtRNkd6LzUrTnR5MU9RZm5PSGNYVFlRMnBMYnZNbGU1WjNDM0R4TUtl?=
 =?utf-8?B?YW93alBhdVlDU2JaWG1RKzhYdzNQK0ZhNnEzSFNqSXJGUFIvYVpybVVXRlBF?=
 =?utf-8?B?MTBhZDc3cmtkb2ZRQ1hqaVVxWFBvbmZEdUVYUjJnRUg4UkkxckpIQzg5dkMz?=
 =?utf-8?B?S1V5alltSGw5aCtaUXhMUVpvcWt1VG1Qdk81VXlYNzhsOGRWSjl6YTN2bEFK?=
 =?utf-8?B?MkxiQVZmRU1FWHFvTVMxZHBSWFpBWmltdGk2WXBzWWNnSDBselpGRVdwejVi?=
 =?utf-8?B?WWhScEZwV1oxdGJuTlpsdjdsbGxFVUw5bGwrb3FuNzNGZ2NWUlRWVVVYSDM4?=
 =?utf-8?B?OU1NNDk0eDMzRjY1QXU0RDhremtVUktTK1ZoWEo0Y0ozV1NOc0VFQzNKTWZu?=
 =?utf-8?B?M3hZOHNXWE53alk0RUdIVVpjazRNZHpjcGFJZHkyRTZHd2drMXEwdUZwbXIx?=
 =?utf-8?B?bmFySCt5WVpsVitzMitvMjZrc0hqUGtzNzhxRzBPUnRrZ1FxTGxSdUJ3UnZu?=
 =?utf-8?B?aEdJT2NGZC9qTTgzcHNJRFZwMmd0eGd2cEJHZEY4MlN6VVJtYWVpYjRmRkE0?=
 =?utf-8?B?TDdFeUYxK3lhQVp4bnZNV253VGpURnFzNXNlK21iUEZpaXpIYThDQnRDbUZJ?=
 =?utf-8?B?dW5ONmJWczZhN3NVWXBLNUFYbEFyUVlhZEIrV3g0aWF6WjF1ditxYmc0eGJI?=
 =?utf-8?B?dTFSc1lzV0hKcTh0WW83dk1iMEw3eGlIc2xMMWEyT0RZUjhGQVhxVFdtUG9i?=
 =?utf-8?B?SHdjYlVaV2lKYVEwdHNnWFRGcml0UUcvd3lNUlhzSit1RFhEQ3V3VTNrcjd3?=
 =?utf-8?B?SlpVN1NneUR2NXlrQlk0YmJUK21VUm5VaE1SMldwZXZwUlFNK1lVZmRwYmE0?=
 =?utf-8?B?Mkc0bXhKcm1ZaHE3aTlXVTJ3RlI1NjltMWlWbkpBb0plZGExUnNyWFBxZ1h2?=
 =?utf-8?B?clpaMmIrT0lqUG5xakRQV2RWUzF3MTJzc3Z3ajFhNjlEazFaTVYzT0szbzhh?=
 =?utf-8?B?YlRiekNXdUFZVkhqYmhuK2QyU3pjTE43VU13RVJvZVFiK2gyb0pyUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 80efea25-3d72-4bbe-aa86-08deaa8c1b7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 09:53:06.6067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OJYmGjx7ihPFXBHkfaTKC9ZRyWGDaWNrfhaIjb7WpgxKSpWm3+s5KYdXrERnLIr+9thp5bVyto6LO/g1nJP98u3cIwM+KOWuUgpJxOkABYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1984
X-Rspamd-Queue-Id: 497D64CA4FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[schleissheimer.onmicrosoft.com:s=selector1-schleissheimer-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[schleissheimer.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284294-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail,schleissheimer.onmicrosoft.com:server fail,BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM:server fail];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schuchmann@schleissheimer.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[schleissheimer.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

SGVsbG8sCkkgaGF2ZSBhIHJhc3BiZXJyeXBpIGFuZCBzd2l0Y2hlZCBmcm9tIGtlcm5lbCA2LjEy
IHRvIDYuMTggYW5kIG5vdyBJIGhhdmUgYSBjcmFzaCBpbiBwaHlsaW5rLmMuCgpJIGFtIHVzaW5n
IGEgTUFDOmxhbjc4MDEgYW5kIFBIWTpkcDgzdGM4MTEgYW5kIG5vdyBpdCBjcmFzaGVzIGxpa2Ug
dGhpczoKClsgwqAgwqAzLjAxOTE3NF0gdXNiIDEtMS4zOiBOZXcgVVNCIGRldmljZSBmb3VuZCwg
aWRWZW5kb3I9MDQyNCwgaWRQcm9kdWN0PTc4MDEsIGJjZERldmljZT0gMy4wMApbIMKgIMKgMy4w
MjExNTJdIHVzYiAxLTEuMzogTmV3IFVTQiBkZXZpY2Ugc3RyaW5nczogTWZyPTEsIFByb2R1Y3Q9
MiwgU2VyaWFsTnVtYmVyPTMKWyDCoCDCoDMuMDIzMTkyXSB1c2IgMS0xLjM6IFByb2R1Y3Q6IExB
Tjc4MDEKWyDCoCDCoDMuMDI1MDE5XSB1c2IgMS0xLjM6IE1hbnVmYWN0dXJlcjogTWljcm9jaGlw
ClsgwqAgwqAzLjAyNjc3Ml0gdXNiIDEtMS4zOiBTZXJpYWxOdW1iZXI6IDAwODAwRjc4MDEwMApb
IMKgIMKgMy4wNzg1NDJdIGxhbjc4eHggMS0xLjM6MS4wICh1bm5hbWVkIG5ldF9kZXZpY2UpICh1
bmluaXRpYWxpemVkKTogaW50IHVyYiBwZXJpb2QgNjQKWyDCoCDCoDMuMDkxNDM0XSBsYW43OHh4
IDEtMS4zOjEuMCAodW5uYW1lZCBuZXRfZGV2aWNlKSAodW5pbml0aWFsaXplZCk6IHZhbGlkYXRp
b24gb2YgcmdtaWktaWQgd2l0aCBzdXBwb3J0IDAwMDAwMDAsMDAwMDAwMDAsMDAwMDAwMDAsMDAw
MDYyODAgYW5kIGFkdmVydGlzIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgZW1lbnQgMDAwMDAwMCwwMDAwMDAwMCwwMDAwMDAwMCwwMDAwNjI4
MCBmYWlsZWQ6IC1FSU5WQUwKWyDCoCDCoDMuMDk4OTI4XSBsYW43OHh4IDEtMS4zOjEuMCAodW5u
YW1lZCBuZXRfZGV2aWNlKSAodW5pbml0aWFsaXplZCk6IGNhbid0IGF0dGFjaCBQSFkgdG8gdXNi
LTAwMTowMDQsIGVycm9yIC1FSU5WQUwKWyDCoCDCoDMuMTAxMDk0XSAtLS0tLS0tLS0tLS1bIGN1
dCBoZXJlIF0tLS0tLS0tLS0tLS0KWyDCoCDCoDMuMTAzMTYzXSBSVE5MOiBhc3NlcnRpb24gZmFp
bGVkIGF0IGRyaXZlcnMvbmV0L3BoeS9waHlsaW5rLmMgKDIzMzcpClsgwqAgwqAzLjEwNTM4Nl0g
V0FSTklORzogQ1BVOiAyIFBJRDogMjggYXQgZHJpdmVycy9uZXQvcGh5L3BoeWxpbmsuYzoyMzM3
IHBoeWxpbmtfZGlzY29ubmVjdF9waHkrMHhmMC8weDEwMApbIMKgIMKgMy4yOTcwNDldIE1vZHVs
ZXMgbGlua2VkIGluOiBpcHY2IGxpYnNoYTEKWyDCoCDCoDMuMzAyOTA0XSBDUFU6IDIgVUlEOiAw
IFBJRDogMjggQ29tbToga3dvcmtlci8yOjAgTm90IHRhaW50ZWQgNi4xOC4yNiAjMiBQUkVFTVBU
ClsgwqAgwqAzLjMxMzY1N10gSGFyZHdhcmUgbmFtZTogUmFzcGJlcnJ5IFBpIENvbXB1dGUgTW9k
dWxlIDQgUmV2IDEuMSAoRFQpClsgwqAgwqAzLjMyMTg1NF0gV29ya3F1ZXVlOiB1c2JfaHViX3dx
IGh1Yl9ldmVudApbIMKgIMKgMy4zMjc4OThdIHBzdGF0ZTogNjAwMDAwMDUgKG5aQ3YgZGFpZiAt
UEFOIC1VQU8gLVRDTyAtRElUIC1TU0JTIEJUWVBFPS0tKQpbIMKgIMKgMy4zMzY2ODZdIHBjIDog
cGh5bGlua19kaXNjb25uZWN0X3BoeSsweGYwLzB4MTAwClsgwqAgwqAzLjM0MzM5MV0gbHIgOiBw
aHlsaW5rX2Rpc2Nvbm5lY3RfcGh5KzB4ZjAvMHgxMDAKWyDCoCDCoDMuMzUwMDM1XSBzcCA6IGZm
ZmZmZmMwODAxMWI1MDAKWyDCoCDCoDMuMzU1Mjg1XSB4Mjk6IGZmZmZmZmMwODAxMWI1MDAgeDI4
OiBmZmZmZmY4MDQzOTE4YTAwIHgyNzogZmZmZmZmODA0MzkxOGFhMApbIMKgIMKgMy4zNjQxNzBd
IHgyNjogZmZmZmZmZDg2YTNlZTAwMCB4MjU6IGZmZmZmZjgwNDM5MThhNDAgeDI0OiAwMDAwMDAw
MDAwMDAwMDAwClsgwqAgwqAzLjM3MzA4M10geDIzOiAwMDAwMDAwMDAwMDAwMDEwIHgyMjogZmZm
ZmZmODA0NDhmNjAwMCB4MjE6IDAwMDAwMDAwZmZmZmZmZWEKWyDCoCDCoDMuMzgyMDcwXSB4MjA6
IGZmZmZmZjgwNDQ4ZjU4MDAgeDE5OiBmZmZmZmY4MDQxZTA5NjAwIHgxODogMDAwMDAwMDAwMDAw
MDAwNgpbIMKgIMKgMy4zOTA4MzVdIHgxNzogNzQ2MTIwNzQyNzZlNjE2MyB4MTY6IDIwM2EyOTY0
NjU3YTY5NmMgeDE1OiBmZmZmZmZjMDgwMTFhZjEwClsgwqAgwqAzLjM5OTU1MV0geDE0OiAwMDAw
MDAwMDAwMDAwMDAwIHgxMzogZmZmZmZmODA0MDg2ODU0MCB4MTI6IGZmZmZmZmMwODAxMWFmZTgK
WyDCoCDCoDMuNDA3Mjg1XSB4MTE6IDAwMDAwMDAwMDAwMDFlMDAgeDEwOiBmZmZmZmZkODZhMWFl
Y2Y4IHg5IDogZmZmZmZmZDg2ODkzNTU3MApbIMKgIMKgMy40MTU5NzRdIHg4IDogMDAwMDAwMDBm
ZmZmZWZmZiB4NyA6IGZmZmZmZmQ4NmExYWVjZjggeDYgOiA4MDAwMDAwMGZmZmZmMDAwClsgwqAg
wqAzLjQyNDY1NV0geDUgOiAwMDAwMDAwMDAwMDAwMTNjIHg0IDogMDAwMDAwMDAwMDAwMDAwMCB4
MyA6IDAwMDAwMDAwMDAwMDAwMDAKWyDCoCDCoDMuNDMzMzI5XSB4MiA6IDAwMDAwMDAwMDAwMDAw
MDAgeDEgOiAwMDAwMDAwMDAwMDAwMDAwIHgwIDogZmZmZmZmODA0MDgzODAwMApbIMKgIMKgMy40
NDE5OTFdIENhbGwgdHJhY2U6ClsgwqAgwqAzLjQ0NTk1MV0gwqBwaHlsaW5rX2Rpc2Nvbm5lY3Rf
cGh5KzB4ZjAvMHgxMDAgKFApClsgwqAgwqAzLjQ1MjI0OV0gwqBsYW43OHh4X3Byb2JlKzB4YmNj
LzB4ZTE4ClsgwqAgwqAzLjQ1NzQ2MF0gwqB1c2JfcHJvYmVfaW50ZXJmYWNlKzB4ZDgvMHgyYjgK
WyDCoCDCoDMuNDYzMTAwXSDCoHJlYWxseV9wcm9iZSsweGM0LzB4MmIwClsgwqAgwqAzLjQ2ODE0
MV0gwqBfX2RyaXZlcl9wcm9iZV9kZXZpY2UrMHg4MC8weDE0MApbIMKgIMKgMy40NzM5NDVdIMKg
ZHJpdmVyX3Byb2JlX2RldmljZSsweGUwLzB4MTcwClsgwqAgwqAzLjQ3OTU1OV0gwqBfX2Rldmlj
ZV9hdHRhY2hfZHJpdmVyKzB4YzAvMHgxNDgKWyDCoCDCoDMuNDg1NDI2XSDCoGJ1c19mb3JfZWFj
aF9kcnYrMHg5MC8weGY4ClsgwqAgwqAzLjQ5MDY2OV0gwqBfX2RldmljZV9hdHRhY2grMHhhOC8w
eDFhMApbIMKgIMKgMy40OTU5MTRdIMKgZGV2aWNlX2luaXRpYWxfcHJvYmUrMHgxYy8weDMwClsg
wqAgwqAzLjUwMTQ3Nl0gwqBidXNfcHJvYmVfZGV2aWNlKzB4YjQvMHhjMApbIMKgIMKgMy41MDY2
NThdIMKgZGV2aWNlX2FkZCsweDU4OC8weDc2OApbIMKgIMKgMy41MTE0NzBdIMKgdXNiX3NldF9j
b25maWd1cmF0aW9uKzB4NGI0LzB4YWEwClsgwqAgwqAzLjUxNzIzMV0gwqB1c2JfZ2VuZXJpY19k
cml2ZXJfcHJvYmUrMHg2OC8weDk4ClsgwqAgwqAzLjUyMzA3NF0gwqB1c2JfcHJvYmVfZGV2aWNl
KzB4NDQvMHgxMjgKWyDCoCDCoDMuNTI4MjQzXSDCoHJlYWxseV9wcm9iZSsweGM0LzB4MmIwClsg
wqAgwqAzLjUzMzAxNV0gwqBfX2RyaXZlcl9wcm9iZV9kZXZpY2UrMHg4MC8weDE0MApbIMKgIMKg
My41Mzg1MzZdIMKgZHJpdmVyX3Byb2JlX2RldmljZSsweGUwLzB4MTcwClsgwqAgwqAzLjU0Mzg3
NF0gwqBfX2RldmljZV9hdHRhY2hfZHJpdmVyKzB4YzAvMHgxNDgKWyDCoCDCoDMuNTQ5NDc1XSDC
oGJ1c19mb3JfZWFjaF9kcnYrMHg5MC8weGY4ClsgwqAgwqAzLjU1NDQ3MV0gwqBfX2RldmljZV9h
dHRhY2grMHhhOC8weDFhMApbIMKgIMKgMy41NTk0NThdIMKgZGV2aWNlX2luaXRpYWxfcHJvYmUr
MHgxYy8weDMwClsgwqAgwqAzLjU2NDc2OF0gwqBidXNfcHJvYmVfZGV2aWNlKzB4YjQvMHhjMApb
IMKgIMKgMy41Njk2NzFdIMKgZGV2aWNlX2FkZCsweDU4OC8weDc2OApbIMKgIMKgMy41NzQyMzNd
IMKgdXNiX25ld19kZXZpY2UrMHg0MDAvMHg0ZjAKWyDCoCDCoDMuNTc5MTI2XSDCoGh1Yl9ldmVu
dCsweGRkYy8weDE1NzgKWyDCoCDCoDMuNTgzNjQ2XSDCoHByb2Nlc3Nfb25lX3dvcmsrMHgxNTgv
MHgzYjgKWyDCoCDCoDMuNTg4NjYyXSDCoHdvcmtlcl90aHJlYWQrMHgxOTQvMHgzMjgKWyDCoCDC
oDMuNTkzMzk4XSDCoGt0aHJlYWQrMHgxNGMvMHgyMTAKWyDCoCDCoDMuNTk3NjA0XSDCoHJldF9m
cm9tX2ZvcmsrMHgxMC8weDIwClsgwqAgwqAzLjYwMjEzOF0gLS0tWyBlbmQgdHJhY2UgMDAwMDAw
MDAwMDAwMDAwMCBdLS0tClsgwqAgwqAzLjYxNzgzMF0gbGFuNzh4eCAxLTEuMzoxLjA6IHByb2Jl
IHdpdGggZHJpdmVyIGxhbjc4eHggZmFpbGVkIHdpdGggZXJyb3IgLTIyCgoKaXQgc2VlbXMgdG8g
aGFwcGVuIG92ZXIgaGVyZToKLyoqCsKgKiBwaHlsaW5rX2Rpc2Nvbm5lY3RfcGh5KCkgLSBkaXNj
b25uZWN0IGFueSBQSFkgYXR0YWNoZWQgdG8gdGhlIHBoeWxpbmsKwqAqIMKgIGluc3RhbmNlLgrC
oCogQHBsOiBhIHBvaW50ZXIgdG8gYSAmc3RydWN0IHBoeWxpbmsgcmV0dXJuZWQgZnJvbSBwaHls
aW5rX2NyZWF0ZSgpCsKgKgrCoCogRGlzY29ubmVjdCBhbnkgY3VycmVudCBQSFkgZnJvbSB0aGUg
cGh5bGluayBpbnN0YW5jZSBkZXNjcmliZWQgYnkgQHBsLgrCoCovCnZvaWQgcGh5bGlua19kaXNj
b25uZWN0X3BoeShzdHJ1Y3QgcGh5bGluayAqcGwpCnsK4oCC4oCC4oCC4oCC4oCC4oCCc3RydWN0
IHBoeV9kZXZpY2UgKnBoeTsKCuKAguKAguKAguKAguKAguKAgkFTU0VSVF9SVE5MKCk7CgpNYXli
ZSBhbnlvbmUgY2FuIGhlbHAgbWU/CgpSZWdhcmRzLAoKwqAgwqBTdmVu

