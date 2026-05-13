Return-Path: <netdev+bounces-287647-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAZoIlWfBGqvMAIAu9opvQ
	(envelope-from <netdev+bounces-287647-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:57:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC4F5369A6
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C925A345379B
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C824963D5;
	Wed, 13 May 2026 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="OBLs+elI"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDA947ECDC
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685303; cv=none; b=P8EMfzvWYyZwtzMQiEINXVPYKK8HXlqPD+0PPMBsr0eNQFwwxV7AZR9E7Xnl76LPp8pX7o6HrwhAhgmoaY7fUUu2W7iNq4LOCih1vq9OUE8FvRcXAoR6rAsz/1eBlagFamFycGYsSahyvGgEgC9O/zfdBKkvUDWInHiKybeG+lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685303; c=relaxed/simple;
	bh=f5WP3cmNxOcvbC86sPprRywV+x+LtGHFckmqjB0JsnU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=e2vs2Qht0Xpozan+965Ro9mC6/g1/AsdrDl37zHv3umWDfEzQ8eJoyDth6Nn2X0Gu9/HYWdm2nIhrJybteKVDae49l8aF/Wsw74YucjErssfH7dKuczdHNeMGFnAaGFoBPcC/vLYP3tipY3Kpy7Ob1DcqkT4lI322OsH9GiUrkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=OBLs+elI; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1778685295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f5WP3cmNxOcvbC86sPprRywV+x+LtGHFckmqjB0JsnU=;
	b=OBLs+elI0RClcTLJyXY2COzJRup7QESPj5xpsgV66UE+v4Mj+/g0BkCGSZoXDzRuoNHMdx
	L7NO6ZzCCEfY1rpVT9+ZG1fKN/mS6uZOOeL6cz5I3AWNZIqqSk6BcoQUMu7ZndxV3d+0jG
	fgDAotoheaJfM525gKSqTs55yNmJFF89C5/M/auSs/0EvBy6BnGGQvuqee0ko1c/YK8bgf
	2PNEBbIh6kLbrNirz76adaYOn0887ObejfXy+jA94hgjuXrrmvle+TKzxaKuhF8ER4mYUs
	nRPzEl+xmCdptZJBb4E6/MNISqfR2xJPBnVO0yqMxb/fUNcn4XDp+LqJe3kBCg==
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010003.outbound.protection.outlook.com [52.101.61.3])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-7-bq4uVM5PO-WaO0Z4oUcxHg-1; Wed,
 13 May 2026 08:14:49 -0700
X-MC-Unique: bq4uVM5PO-WaO0Z4oUcxHg-1
X-Mimecast-MFC-AGG-ID: bq4uVM5PO-WaO0Z4oUcxHg_1778685283
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by LV3PR02MB10618.namprd02.prod.outlook.com (2603:10b6:408:287::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Wed, 13 May
 2026 15:14:38 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 15:14:38 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2 1/9] dt-bindings: net: add onsemi's S2500
 10BASE-T1S MACPHY
Thread-Topic: [PATCH net-next v2 1/9] dt-bindings: net: add onsemi's S2500
 10BASE-T1S MACPHY
Thread-Index: AdzhcEqKHy9WMaaoSHKX00ujMX5pNgACjxcAAFv2XRA=
Date: Wed, 13 May 2026 15:14:38 +0000
Message-ID: <CY8PR02MB924974BBC348DE4814DA3C7C83062@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB924920C8825C7AE5D22EFA4483382@CY8PR02MB9249.namprd02.prod.outlook.com>
 <20542d76-6f70-4c2d-9fef-0de620a8d6d1@lunn.ch>
In-Reply-To: <20542d76-6f70-4c2d-9fef-0de620a8d6d1@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|LV3PR02MB10618:EE_
x-ms-office365-filtering-correlation-id: 70c9a68f-d215-43ee-67ca-08deb102599f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|56012099003|11063799003|3023799003|22082099003|18002099003
x-microsoft-antispam-message-info: FTjM4I5FUbxIwyic1aiXJb4se3lXWiWo75US+d1RnD/WSLz0pY9d018YrT01cbE8PfWzfVOVP5Ye0faPof2bTjVbQfH/ygSIsZNChgyE/kvYFj2QJ4T/53JQWDw1sjAm4fvyjSXM5pLUPeCEP62jvZlwY0zw+CzYFdL+bB+jUbWoLM/Inpix0ihBN8jgxZ2GXEtb9D6R7euhv0u69abj0MTcZe42nWXmdr86eKfXENmL6LqS5wXFHmZ+gkJ0/tX65G7BLr3j1TYddrj/s1f/7f6EysaIyhdiXAfFo7CwpXBlYwab40ZlNqr+oOpzE7oY2TfKVnB8jUp8BPvQK/9BghWUnbd0HSx6zAFuCqaGKWdioZubOqJxezvaTUR4z7j564RJOSkVzUNjfTmUD8TxVBO+uaPzW/ctZ2to9AoL+cbrKeNCxyL2EuSNj95LIajdEcqs8ZN4jnH5nDlOBeT29qcvDiU+Zrh87Ep/USd1xxCjF7LfSYO9k0WoHlhsKCitOkblDqrsnfv4gPtcIAP+U8skO1ufF8khI8KkMYrwzidextioLR0OPx4CeCMDaJ0FNBBZ9VegCwg66Tk9Me5zQo6+kMu7Js3jgDPSl60hJNMyzVdt3ftTLmtb5AhqzN4PNsg154zqId7Z0gX5h+mkHDBSMvjHEMzBY94kgLZxt8/KoZU+m9mssT+n3zh8scovD85lVd5dBym/tI5rj2l4u2eV9reVcFb3t8HWOBPU3knspgh2UwAFxSrCf3110fcN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(56012099003)(11063799003)(3023799003)(22082099003)(18002099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2pPUjlqdlk4RTBtRW9qOWpWK3FRSXpub0NJajkwTXBseVZCejR4NWZUUkIx?=
 =?utf-8?B?U3N2c1JmUjBtelUyMHlUSllpckVEZ3Q2Vk1BMWpwNXljcFpyRldINnVLTDY1?=
 =?utf-8?B?NWlKRk41RFBzVnM0M1VMUzJ1b055Zm9xWDlKQ25ZUXExeXVCTXQxb2tJSEdj?=
 =?utf-8?B?MWhGTTdRU0ZLT1dNNzFGNktXTG9vYXhkTzFUVlBubUxHc3pyZ1gzQVU4cThP?=
 =?utf-8?B?dzB4SllWZDlRS2dTQWtJUlFUK2U3UUk5MTVFWlY5SzlxYm5MV0hvb1RyWUdn?=
 =?utf-8?B?YjEwQUF1dnRpb3BpRzhyUW9nS09ZYkg4OG5Ba0dQR1pUSjZOWDhhZFpZUGxi?=
 =?utf-8?B?STNBbkYrbWVlQW1td2VGVkFGaVVJTTlxNXhlN01LR3BRVVdQU1VuSW9IbjJ3?=
 =?utf-8?B?L29Fb0dyYllKT0UycGE1SkFYemMvY0ZsZXhFelY2UWtNNUZqeVNhY0hVczdw?=
 =?utf-8?B?aFExM3dibGZJUTRJWmRnRTh5dDUzWVRCVStwV1dua1VkVzZFbkxkUXd2Y0Fx?=
 =?utf-8?B?RHJ0OE5iQURrdmtRN2Q4QlNWTCtNRlN0VitmUFJrRkdLbWN0MTVhUjlSL0lo?=
 =?utf-8?B?UHB5UXQwMkxDZ1dDVlZJM2xZSkZrM0ErV0N4dVB6MUJiZndQU0RWM0VCT1Az?=
 =?utf-8?B?cEJPTkdwRXQzeHN1MXJMWFZaWEd2L2JtcHJTMDlpVWlqMEVvL213eVgwVkJz?=
 =?utf-8?B?MVRqb2VzVkpTdDhhMk1ibjUyWW83a0lHaTU1MEV3NGJlV2JtRlpIUlhvUnUz?=
 =?utf-8?B?Z0NBMVlCUU1ha2VReVJuaFlsK2d6TE1vZ1NoTEZkd3N1WnRDR0htaENoZDh1?=
 =?utf-8?B?SmhFSEdrc0dYNnErNVJMNWxZeXJsTVVDV0YxcEd1ZVNEbXVZV1JJbXkzSkFT?=
 =?utf-8?B?amJpVTNyVTQxbExna0s5emxuSVR5NEE5ZDlQeEFObFhKQmxLL2F1ME9uekJv?=
 =?utf-8?B?bWxGMXBFYlFUVTJJWlRjZmkrQmJZREZ0TlpiY21oWnRTNUVpZ0J4TVFvdkZV?=
 =?utf-8?B?cHUzVkFscEZEOHVUaVk3M0ExQzh5MWtGcG5WNlVNOUlTSXF4bHNlc3JJejJF?=
 =?utf-8?B?WmF0RERtWUxIWThkbnJldEM2NkFoSU1ZNEJOY3JLa2V0bUZhd2FtU0JGenBy?=
 =?utf-8?B?YlRtSzJYS2FROUFNLzlBNWl4VW56bUVBZUxVUWpkcklLMDVWUkhUZVpScTZv?=
 =?utf-8?B?c2UwZFV5Q2lRQ2R2TzBjeTFNNGFQUWV1YTZXbUFPWnQyaW9JbUQ1QXcvam95?=
 =?utf-8?B?NlM5dU1BcnBvd1Iyc3poU2Y4NERpWlhRWHd3NS80cUpFbGd1NmZ1N2pXem0y?=
 =?utf-8?B?TEFxMEx4Zzg5WU4va1NmQVlIZlYvUTFWQncwdlF3NGNqRW43YnJkT1lINTMr?=
 =?utf-8?B?MExKUDBNTDVqelRodms4bnV2NXM0YTVUOEE4RmsvbkNGWjBjMFhTNTRVb3U1?=
 =?utf-8?B?YkVkdUVMWm8zZGhtTXAxZjFwN0x5REgxS0lsNUJCalN1MVh5aXQ2cHFkUWlq?=
 =?utf-8?B?dTI4VksxK3VoZ2ZvNVRWRXVSWUIxMjFkOW5GQ0gzTVc4UVpEQVd1c0U0UXM2?=
 =?utf-8?B?cmllM2J0RTNiN3ZqZ1R1MFRtOHlkYmlLUmtxWVJ3VjFzMkNsSFF0SkNQWkZ4?=
 =?utf-8?B?Y25FMFJXeEtpTTQwMTF5a2lHRnIzazJHVWowcHRzRFJ2RCswdUJzQ0ovemkr?=
 =?utf-8?B?aGtoWXdkS3dmNEhKL3ZOMnZxZXRrNE1HTlUvL1c1V0wrUHc3QStSSTNnS1FU?=
 =?utf-8?B?RXdrVVVNK0tQdkJ1UkdBU3ZjWEd0clVMeGNvdW13dnNJeTM5NUtyNFI3ZGxi?=
 =?utf-8?B?Q0VwMk04R2tyRUNnbmNLU2FuZVNtdndKZXNEUlAyc21FKzRsNnNNbkp2NEJF?=
 =?utf-8?B?ZlpMMWhOdWFrQWhyeTM2VXdaaHFYUklweDhoNDBHeVJob1oyb3lyWkY2cmJq?=
 =?utf-8?B?MWh5dEFiTXM1ZEtJNFZHYzFPYm1PRzhVRVZUWks0NkJ4Q0RCSXBBVS9VTGZB?=
 =?utf-8?B?amVZbXJ1U0Y5cjNLc3JZSy9zMzlDeENDYmwwR1NUY1dzRXJGd0hDdW53N0xq?=
 =?utf-8?B?MWl6T3JldmhjYjZGREhaeHdkZkJsYThZdnJUeVN2N2ZvTVcyQXUyL0ZCTk9q?=
 =?utf-8?B?c2tYeTdhaU1qVUoxZE5vSDFuQVk4cUYzTGI2clRkblBQak1ySFVPMHhwRU9u?=
 =?utf-8?B?WXJaU3R3OWI3VTk0dU9pUlB4bUd5bW5pVUZUN1U5UXMrRUNONEo2Qi9rYjJO?=
 =?utf-8?B?ekdmQjFQTzM5RGJyTDBoR2FTdm5YV1ZJYU1hTmV2dE1vQmFMYkhZSGpVS0Ev?=
 =?utf-8?B?SSs0WTVsd0NFMCtYQ2psUFRZMlkwMXFvT2duRDZLNXgwSVg0OUloZElSLzJX?=
 =?utf-8?Q?RE8xv+mdLMZOxnaA=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: M2jOBf/ojC8IkUHwPK2OqKfOFGi/T4IfYfh58BvLPjSSNgu8W2UFOlXh5Dv/cXNEgZfJks3Tot6/8VEtmHTyir2rsCqD0xXTP+dlycUbGjQrG3nVv90tWbc9fqjRPo24qFbEKLup9QyR8UIyitunMHh291ByFtXV5TxjwIUDGHp+q3HcE3t1O303dWxQ28OYc3z+WizcVE/p5oTdK+EXe5Pfbw1orV5Ixv9cMIb3GUuocUA31/hVGvXsO8zoEDF13svEPbxNoNAtH6kYOJk4st+WarkBbUqGhYHyR49p8m23NyHSo74XbLQ4banxsF5tZVHJR4b82IEnsO2F4FHrmg==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c9a68f-d215-43ee-67ca-08deb102599f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 15:14:38.4750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3akaKShbflcau9TlqKSzNcHBnHJmR5W5dd1zk2+qRd2r+Jdv2hB7xIXwF70h7/eE0z6Qj2VtwVjefKFKKCb8qBvqxE58gb76WFo6+o/RkPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10618
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OV4ojmPQ5u-c7_IKHKzXdKLUNXHVmiSUkeJQPGopacQ_1778685283
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Queue-Id: CBC4F5369A6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287647-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[onsemi.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.966];
	DBL_PROHIBIT(0.00)[0.0.0.0:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,CY8PR02MB9249.namprd02.prod.outlook.com:mid,onsemi.com:dkim]
X-Rspamd-Action: no action

PiANCj4gPiArZXhhbXBsZXM6DQo+ID4gKyAtIHwNCj4gPiArIHNwaSB7DQo+ID4gKyAjYWRkcmVz
cy1jZWxscyA9IDwxPjsNCj4gPiArICNzaXplLWNlbGxzID0gPDA+Ow0KPiA+ICsNCj4gPiArIGV0
aGVybmV0QDAgPG1haWx0bzpldGhlcm5ldEAwPiAgew0KPiA+ICsgY29tcGF0aWJsZSA9ICJvbm5u
LHMyNTAwIjsNCj4gPiArIHJlZyA9IDwwPjsNCj4gPiArIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVs
dCI7DQo+ID4gKyBwaW5jdHJsLTAgPSA8JmV0aDBfcGlucz47DQo+ID4gKyBpbnRlcnJ1cHQtcGFy
ZW50ID0gPCZncGlvPjsNCj4gPiArIGludGVycnVwdHMgPSA8MjUgMj47DQo+IA0KPiBJUlFfVFlQ
RV9FREdFX0ZBTExJTkcNCj4gDQo+IEJ1dCBpcyBlZGdlIGNvcnJlY3Q/IFNob3VsZCBpdCBiZSBs
ZXZlbD8NCg0KDQpJIGFtIHRvbGQgYnkgb3VyIGhhcmR3YXJlIGRlc2lnbmVyIChQaWVyKSB0aGF0
IGl0IHNob3VsZCBiZSBsZXZlbCB0cmlnZ2VyZWQuIFdvdWxkIGNoYW5nZSBpdCBpbiB0aGUgbmV4
dCB2ZXJzaW9uLiANCg0KSSBiZWxpZXZlIHRoaXMgd2lsbCBhZmZlY3QgdGhlIHBhcmFtZXRlcnMg
cGFzc2VkIHRvIHJlcXVlc3RfaXJxIGluIG9hX3RjNi5jLiBBdCBwcmVzZW50LCBJUlFGX1RSSUdH
RVJfRkFMTElORyBpcyB1c2VkLiBJdCBoYXMgdG8gYmUgY2hhbmdlZCB0byBJUlFGX1RSSUdHRVJf
TE9XLg0KQlRXLCBJIGRpZCB0ZXN0IHdpdGggdGhpcyBjb25maWd1cmF0aW9uLiBCb3RoIGVkZ2Ug
dHJpZ2dlcmVkIGFuZCBhY3RpdmUgbG93LCBsZXZlbCB0cmlnZ2VyZWQgc2VlbSB0byB3b3JrLCB0
aG91Z2ggdGVjaG5pY2FsbHkgaXQgaXMgc3VwcG9zZWQgdG8gYmUgbGV2ZWwgdHJpZ2dlcmVkLg0K
DQpNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgSSBzaG91bGQgc3VibWl0IHRoaXMgcGFydGljdWxh
ciBjaGFuZ2UgdG8gb2FfdGM2LCB0byBuZXQsIG5vdCBuZXQtbmV4dCBhcyBpdCBmYWxscyB1bmRl
ciBidWcgZml4LiBDYW4geW91IGNvbmZpcm0/DQoNCj4gDQo+IEFuZCBpIGhvcGUgdGhpcyBpbGx1
c3RyYXRlcyB3aHkgeW91IHNob3VsZCB1c2UgdGhlIGRlZmluZXMuDQo+IA0KPiBBbmRyZXcNCg0K


