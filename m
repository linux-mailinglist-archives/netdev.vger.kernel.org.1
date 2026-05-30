Return-Path: <netdev+bounces-293294-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBmEEalEGmqS2ggAu9opvQ
	(envelope-from <netdev+bounces-293294-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 04:00:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F9960AD97
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 04:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 096A73040C3A
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 02:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A32730FC1F;
	Sat, 30 May 2026 02:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="RreTkWxF"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839FB30E851
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 02:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780106406; cv=none; b=r1xtdK4dvHBL9dF5mqLyn8howbmD/cawlKVxcG7QxiB+sFktU42bhrpeN9WdTQX/+jK1PY1+p7wbNskvTXVnM9uSbubOadTCBgoWqw8vuTRXSCJUaHDJbcz5MMiC2DLmI5bnPStoby9jcoVgMfzfFZ6BLSsWUm6Gu8Q4SUZwSjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780106406; c=relaxed/simple;
	bh=q/BHpxUIKClGyV8FB6bQXIePfFVquhFqaVSRCo7y88M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=YFGjawJPuI1BbNcRe2UFssYzeA7h3u/A1s7OQJwuNLRpF/Gitn41RJsnQUKQRGpDVh7etiom4PnD6xMsVgQBpjXywdrAYwQQsQ9QV43lMdFwTl6OnmQlQzuiymQScnJdpuIh7UEnstv/OZlTTWk1mTa77pCS9UwYr5WWy5A80nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=RreTkWxF; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780106405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/BHpxUIKClGyV8FB6bQXIePfFVquhFqaVSRCo7y88M=;
	b=RreTkWxFaoPqI2VHlO62NxGVm7eM+o6AhO4RhogIg1hyEylBZt3e0XIx3AwDTX5CxHWHnr
	2VIQOVYpaONpDF6JeO67AooyjSJNdONnQGhmpbm7XhBoKxQuTmZjaW3K0ZZZ/EH1SNAUqH
	nPjSo1asHR57GEvKCzJixrle1sUMEmuP3MzOkwuMEOIna9loaYj1sC2mloniixBDwWLLmv
	emuFVUigPMVsBXAbNxjtSgWnRYH8GWdLbHpsJQYAliBaetHtkqX86wzwSxX3HnIKgz6yc5
	eovLgw1ZzJ+U23vuJ0pQgPM4YXPK4gK+tC58nB0nvcB60PtwuqdTpN1Wi1fvmw==
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-19-9Wufl-rlN8SFMviMoqHhZA-2; Fri,
 29 May 2026 19:00:02 -0700
X-MC-Unique: 9Wufl-rlN8SFMviMoqHhZA-2
X-Mimecast-MFC-AGG-ID: 9Wufl-rlN8SFMviMoqHhZA_1780106401
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by IA1PR02MB8875.namprd02.prod.outlook.com (2603:10b6:208:389::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Sat, 30 May
 2026 01:59:59 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0071.011; Sat, 30 May 2026
 01:59:59 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v3 06/14] net: ethernet: oa_tc6: Support for
 hardware timestamp
Thread-Topic: [PATCH net-next v3 06/14] net: ethernet: oa_tc6: Support for
 hardware timestamp
Thread-Index: AdzvmN2xAORlG4rISm+APIR4nWIH9QAIeX4AAAbPxoA=
Date: Sat, 30 May 2026 01:59:59 +0000
Message-ID: <CY8PR02MB9249BCE589C0A733B58F7C2B83172@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB92493D70B9443A982AB0305C83162@CY8PR02MB9249.namprd02.prod.outlook.com>
 <15c67f3e-f2f5-41a1-b1d1-00cb622360de@lunn.ch>
In-Reply-To: <15c67f3e-f2f5-41a1-b1d1-00cb622360de@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|IA1PR02MB8875:EE_
x-ms-office365-filtering-correlation-id: fc1a1809-be53-4213-882e-08debdef27bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|11063799006|4143699003|56012099006
x-microsoft-antispam-message-info: f9DH0SeYy53ThbV6MD8iOoMPdHOTlfMAOEG/BYQwhzAigosWIyN25H2VMHNmIPofmYHw/GJoPtVfkWmd37ZDFGoCy8fIwQpr8EoxyIYxBNfN5aPzB7zgDHCovg/vLX31QWIUSsSKuJ1SJ79t/XApT01LqVEtVNPYEKT/lCdMxMZenQ+JBostdYyV0CLs24bHGyJ9KgDKEynIWrT3AY0iOOW+jtKhfjtndUjB8ScBn7shVlWXQSDUGJdbrjZI+jIsXPQbx0sB/7lNqJCMS3GBOeblVFmW2tsTxNeaA/JuQCFA90nIRk6hNnBbZDdjRUkQfI5kyK/bJsouZ0Y5nVlZb1qJim3AuKcrljH1t2zjfvBD0ptNmVyYJ1RzgZcFN0dJvLdbpYPNiwvV/2EVdBmIUo/Y/Qvq8gTgUZLD5QJWiIimw3otYezROnqSj7cax1fkdEbNIMyW1JuzTdhEN9bPe4hb4UOYwH3iaaCiMyfyqy1Ev7kEP02efLzBXqIK+h+4y7uUOF9Zl4n2hHBbzEN9fqVicUO7BMUh90WsXIlMXRR7xRTPBNnA5IyauNKIvzgc72rqlT3ueNvJ+VUvcLJV8KORHIjaFEyqjPPIsUSOEkuEKcFRZgPUwDH5jwKS1YsIdCNBqSB1RNg0c6LxLzpvEbdygZ3N03tVODrwA4lsBp9+JctSBPVEjwCSmPoIuPuKNH+TDpgABZoXh4UcK1N8XAoR4nZv2jq6ULS7cdaq4dQQeamlbcEwUGr6Kxw/Btl8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUE0TjAyS0lkVm45K3dLMlB3OGpFR04wYmJBNmF2Q21kYW1wWU9IL3I1Y1F0?=
 =?utf-8?B?R25YRHczRWVYRUUxQ3BFZUVCT2g3SVlqQ2g4NDcxMnFlUzlzU3dSaXpaQm5m?=
 =?utf-8?B?akNsS3RpYU1peVUzNCtBU25hUlZGQkthaDZBSmhTODlGRHAyNi9PU1ROdE1W?=
 =?utf-8?B?UnZBRW52WHhsWXVORko1MklLSFpmZlpRSnV4SzhSdXVkNDRRc1lMVEQ3eHFm?=
 =?utf-8?B?U29YK0ZwRGw4QVJjTTNGNmxCTFJOTURTZzB4UWg3TlF1WUU3ZkdQN1VScnFo?=
 =?utf-8?B?eXZvMzVnOFRVR204L2laWDhLWFhNQmlzZGRmMFpacUdIYSt4Ky9ZaTBEMXFZ?=
 =?utf-8?B?SHJ1aTBBWGNPQ3NhZElFOHorelg5TCtoMkw5UVRrVDR2TmF5MUFTdFAzdkNZ?=
 =?utf-8?B?V2NVeXJRWFAzUUVzQmxIY2JJQWVRK3pGaUsvdmorajAxR01waTlGdXhZa3c2?=
 =?utf-8?B?SldScVJ4cUF0T3JEcmZ6dFJJTENLZ1NvazBVZGV1SG51WnNoRkswUllQVmpy?=
 =?utf-8?B?SDhqVHRsWWNQWWJqV3NoVUp0Zkw0bjhxdzF1OHUrNHltM1lVSlNnWHNnRHM5?=
 =?utf-8?B?V1Q3WUdYVjNPVk9SUEdQejd0MEYxR015R0Z3ZitGZU9Lc3V4Q3pyblZkVzNv?=
 =?utf-8?B?ZVl0RE9SL203NndVUGVJeGJrOENZL2lXZU16Ym5ZTTRQSTM3UlZKT1JIaXU4?=
 =?utf-8?B?NWwyOGNLVWJ4ZkpZRUIreWd1OFhIWS8vdnFPRGJtSFRpN2E5TmxqbDZ5enM0?=
 =?utf-8?B?Vk1CR0tFQ1ltSU1FLzlWb0pLU2ZKbkNHUXdYenp2YWE3RitsSVRFTUZ5aUxM?=
 =?utf-8?B?OFhaS2VmdmxHbDdzeGJqVHdKR1BtWk96OWdIUWMyUUlrVjF3ci9Ic2V2bG1k?=
 =?utf-8?B?KzlkTFV6N2VPMFZXM3lwcDNPeHpLV284K0FobGtETHB4L21lTExqQ1BlT29r?=
 =?utf-8?B?Y3ZVay9IZVI4QVd6UEhLUEk2RGVVVEV3TTYybDNYR1RMa2p6V3ozUU0yc0VE?=
 =?utf-8?B?WUJoeUhPQkx3Lyt6cjdzUnU5MzE1WUNhUUhwVnBOSFlZblgxZHpQQVpiQzBD?=
 =?utf-8?B?TGN3M2k2amVmU0YyMlNxMnA3cDJjTkluWHBIT0hKMGtucGJqbWx2YVdwbWFX?=
 =?utf-8?B?M2hvRjdldTVISHFKTEdSUTRtWGllcnJ2b1MrWStVVUJ1OUJPdi92NXMwOEtE?=
 =?utf-8?B?U3R3WkN4emxXZncxV1J5Z0Y1bkFGRzZCb3dmT2swOXZVNXpML0FwRlZuVnRN?=
 =?utf-8?B?cFEvWHp2ditqVDZxOVZKb3lsTlhVK2ZjWVFDcVNkbTVOaHIxZFVFcDNra1Rm?=
 =?utf-8?B?WlNBRUVTU2NMSys4SmxGSjd0aW13Q2lDcW9pL2dwbGQwbzBFdHZjeW1Yb0wy?=
 =?utf-8?B?SCt4VUsvd2R3U0lqcyttbWU2M0lRMy9DdDM2aU55a3Rkc3FKajdTR01kS29n?=
 =?utf-8?B?amRIMk5KbDFINm5BL0Rad2xQaG5jTlp4Vk5MWHdoWm4wVzh3ODNadm1pdFkx?=
 =?utf-8?B?b1prZU1xWHd6SEQvMWZsRjVHbnNhM2EremVPaWtvZTd1dThWU3VST1lhM1h4?=
 =?utf-8?B?UnJ3NmlwQ3RJbXBwR0ZKaG9pUWVwN2xDYkJVUTlpUTNJSW9WcEI0MzhFZ3Z1?=
 =?utf-8?B?ckRYWVF6SHpFbzNBdzFJY2paenhRdHVDRWpJdExsVjNBUW5KM05EcXR1Ungv?=
 =?utf-8?B?WitlaFNlbXNiNEVYZ25sRU5YQVBEVmJxQ3ZIUlRYc3pROTc0dnBTUFNvU1Jq?=
 =?utf-8?B?WnpKVDBnL0gvMHYxU3ZoTG4rZ0ZMUHROUTZWSjU4dkFDZ3lkU1hpQkl2ak1N?=
 =?utf-8?B?UjhRY1g5c1FKYWk5L2pPRnZOWW5wY0N0YW5Xc3UwNXdsWDdacFloQkl3ZWNN?=
 =?utf-8?B?SmdoWWhmKzdUcUF3RDRHdFhUcGQ1bzdIVExmWXd2OWdIWXJkVHVidFFyRFlt?=
 =?utf-8?B?bWFZSWV3WHNQQVV6aEpnRkNzQXBHQ3VJQkZJMGtBTVQzUjFhazdXOWpDaExU?=
 =?utf-8?B?Y09wN1ptbC9Sd0FXSm5QSDkyWTFsNmdPQWxiMXdjSU9Ud0lWM3ZaNk0wRURx?=
 =?utf-8?B?S0kycnFMTkkwZVZGdFZGaWcvaHBuOEtQWVZxdkNaSTFqTGpFQzZidFVSS1VP?=
 =?utf-8?B?dzg1ZlBLUkpDNDBvSDhXWHNQbDByYjRLdFVQd28yWGN2NW1HeEVlOHJzVnhi?=
 =?utf-8?B?dGlNYStNQkZneTZ4a2RqZVZTVVBoWFAreG14bzNacWk4MXNkU2U2NDFRZzll?=
 =?utf-8?B?SUQvcWtOUjdtRGVIeFdqS1lMaFBncFkvclZoSDJtR1o1QWdhMTY1SURBUXJF?=
 =?utf-8?B?UVNleGJGRkhFTUpnemhoWFIxK0U1RzVvQUJid0xtcXA1S1A3N2VzdUVXU2sw?=
 =?utf-8?Q?VRK5jAyVsVkEhyDI=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IUI6F+ashGFajtVQH1UgbVl8xQGkJcdV3ZTQK1SCqWLcWrCh73jndl9ktHdY3qi2G6/ARavAE9+R+vZZr7wBe3DB7OUmzv8cPx9hsBoXwsg2McSGOt4YB6JAex2RYdbYa4lAHzw2l4IwIGpFhhukLRUc+0XrktEeBF9TKVjhWjb9JBGta8TVKEEFvEIr6s4QlqKulkZi+8wdfofraZGJRhHB9rp4xzNLu/w6DWtG3xv8kGGfpYcb+Jm5CK++mK9gg00ki1Q7R4Qxkev8cReCbCUl4zoXBaJr83LH0l0xgbrx702Rr0tRYC5/N04xUsXStRueb0yPiHlU4KNi+ofw3w==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1a1809-be53-4213-882e-08debdef27bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2026 01:59:59.4033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rIOTNji7hCxyepFPPo0ocOVLmREQdSGjDUxLFLcQPOPDhFP4zYf4BSf6DJH9tpZrEhj25p4zDBZrRHzgx692wl9yJzVctINc2EYulDUTJY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB8875
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0YIgywCBAuTufoU8XTT5pOlaNM8W4I9OlC8wBiT_psU_1780106401
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293294-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[onsemi.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D3F9960AD97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiANCj4gPiArc3RhdGljIHN0cnVjdCBvYV90YzZfdHNfaW5mb19yeCAqb2FfdGM2X3RzaW5mb19y
eChzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KPiA+ICt7DQo+ID4gKyByZXR1cm4gKHN0cnVjdCBvYV90
YzZfdHNfaW5mb19yeCAqKSgoc2tiKS0+Y2IpOw0KPiA+ICt9DQo+IA0KPiBBbmQgaGVyZS4NCj4g
DQo+IEkndmUgbm90IGxvb2tlZCBkZWVwIGludG8gdGhpcyBjb2RlIHlldC4gV2hhdCBpcyB0aGUg
bGlmZXRpbWUgb2YgdGhlDQo+IGRhdGEgc3RvcmVkIGluIGNiPw0KPiANCg0KSW4gUlggc2lkZSwg
SXRzIGxpZmUgc3RhcnRzIHdoZW4gc2tiIGlzIGFsbG9jYXRlZCBhZnRlciBzZWVpbmcgYSBjaHVu
ayB3aXRoIGJlZ2lubmluZyBvZiBhIEV0aGVybmV0IGZyYW1lLg0KSXQgZW5kcyBvbmNlIGNvZGUg
c2VlcyB0aGUgY2h1bmsgd2l0aCBlbmQgb2YgdGhhdCBmcmFtZS4gQXQgdGhpcyBzdGFnZSwgZnVs
bCBmcmFtZSBpcyBhc3NlbWJsZWQsIHRpbWVzdGFtcA0KZmllbGQgb2YgdGhlIHNrYiBpcyB1cGRh
dGVkLiBUaGF0IGlzIGp1c3QgYmVmb3JlIHNrYiBpcyBwYXNzZWQgdG8gdGhlIHN0YWNrIHVzaW5n
IG5ldGlmX3J4Lg0KDQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBvYV90YzZfZGVmZXJfZm9yX2h3
dHN0YW1wKHN0cnVjdCBvYV90YzYgKnRjNiwNCj4gPiArIHN0cnVjdCBza19idWZmICpza2IpDQo+
ID4gK3sNCj4gPiArIGlmICghdGM2LT5od190c3RhbXBfZW5hYmxlZCkNCj4gPiArIHJldHVybjsN
Cj4gPiArIGlmICghc2tiIHx8IChza2Jfc2hpbmZvKHNrYiktPnR4X2ZsYWdzICYgU0tCVFhfSFdf
VFNUQU1QKSA9PSAwKQ0KPiA+ICsgcmV0dXJuOw0KPiANCj4gQ2FuIHNrYiBiZSBOVUxMPw0KDQoN
CkkgdGhvdWdodCBpdCBjYW4gYmUgTlVMTC4gDQpJZiB3ZSBsb29rIGF0IHRoZSBjYWxsZXIsIHRo
ZXJlIGlzIGEgbG9vcCB0aGF0IGxvb3BzIHVudGlsICAxKSB3ZSBydW4gb3V0IG9mIHR4IGNyZWRp
dHMgMikgb25nb2luZ190eF9za2IgaXMgTlVMTC4NClRoaXMgb25nb2luZ190eF9za2IgcG9pbnRl
ciBpcyBwYXNzZWQgdG8gdGhlIGFib3ZlIGZ1bmN0aW9uLiBOVUxMIGNoZWNrIGZvciBvbmdvaW5n
X3R4X3NrYiAgaXMgbWFkZSBhZnRlciB0aGlzIGZ1bmN0aW9uIGlzIGNhbGxlZC4NCg0KPiANCj4g
QW5kcmV3DQoNCg==


