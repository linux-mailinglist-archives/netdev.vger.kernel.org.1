Return-Path: <netdev+bounces-300032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zSOVON4oMmq2vwUAu9opvQ
	(envelope-from <netdev+bounces-300032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 06:55:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8418F6968A7
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 06:55:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=jnNjjWX7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300032-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300032-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B797F303B3FC
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 04:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306E635C188;
	Wed, 17 Jun 2026 04:55:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E1935DA49
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 04:55:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781672110; cv=none; b=Gs68aSgo0y8FKbh91CXqSVsaSskAT0THY63MOkiJfWePmHdUVMDLJ+VVpTW6s+MBivouHoS/6DPPH3UOfCKcv23LfoogLgsJLDqL0ExVSt9QelTu4tmoGoHfBOqlqlo5o7INfY/nBcaEi/JPsUkrGmTdQPMGYDQlAMSlsO/EhKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781672110; c=relaxed/simple;
	bh=VKSIp1hqO/6BaEqstNYrrSvv+n5piAhSDOZo9EpH1sk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=QzPJIls9eDtAzZ96zzQ+Z8jEvincFWuJJEuNzm2Dhc9OHywrsIpZMho7MCaHHpvgysYJbWlkp7BlFOT5Wzjz110/NzMMk1YXJM7tj3CZmAtvSXhGyP++GMrNIT5X3s+9fZEiAWoCI9KPizln1VCFGLV4DCnWG2LzecZR/B7CMSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=jnNjjWX7; arc=none smtp.client-ip=170.10.153.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1781672095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VKSIp1hqO/6BaEqstNYrrSvv+n5piAhSDOZo9EpH1sk=;
	b=jnNjjWX7tXBvhV1FmvD28plB+P5XxzCd/r6njzCQOb//d+b3yrLhaZA022U1yNSu4ZOOoB
	mXe/JwojtYeDzdELOl3dJ5q7QHwcxrWV+rH1viy7rT+Ty8R5eJVtKUj4OfN4SuLoXQCTOF
	q+mZ+TuQgek5TvpG8LF1EJbT1DFa84/iuGFatPiVjzWCGwoKNBz7PdALj66lEiiwOqQImL
	9joVXLwhruRFyl9cVqDvFJq8Yo+9g3nilBPlK9W/kxWntMLv3M67qJESwJEegQiDLFPqn3
	TFNRqYg4Jix0vhQYtJh8+6VzXskWgw/BhIKT0CsYrrIJbzApBh3S+oJQLbQi6Q==
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012013.outbound.protection.outlook.com
 [40.93.195.13]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-10-miz2B9F0OuKPTzVvTTHHAg-2; Tue, 16 Jun 2026 21:54:51 -0700
X-MC-Unique: miz2B9F0OuKPTzVvTTHHAg-2
X-Mimecast-MFC-AGG-ID: miz2B9F0OuKPTzVvTTHHAg_1781672087
Received: from CYYPR02MB9828.namprd02.prod.outlook.com (2603:10b6:930:b8::20)
 by LV4PR02MB11099.namprd02.prod.outlook.com (2603:10b6:408:2da::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 04:54:45 +0000
Received: from CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca]) by CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca%4]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 04:54:44 +0000
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
Thread-Index: AQHc+e0nFxx0u09WdkC+bo9XNPrS8rZAt0OAgAF+ZZA=
Date: Wed, 17 Jun 2026 04:54:44 +0000
Message-ID: <CYYPR02MB9828B41845A534BDF0B0C17083E42@CYYPR02MB9828.namprd02.prod.outlook.com>
References: <20260611-level-trigger-v5-0-4533a9e85ce2@onsemi.com>
 <20260611-level-trigger-v5-1-4533a9e85ce2@onsemi.com>
 <7c89df6b-32ac-46c8-8400-945879037f2e@microchip.com>
In-Reply-To: <7c89df6b-32ac-46c8-8400-945879037f2e@microchip.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR02MB9828:EE_|LV4PR02MB11099:EE_
x-ms-office365-filtering-correlation-id: 29b26fa1-e4c1-4d64-8912-08decc2c8ce5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|921020|56012099006|11063799006|4143699003|6133799003|22082099003|38070700021|18002099003
x-microsoft-antispam-message-info: RkI4LWkL8VvTmL+g6sS6Yzw+Zo8yGJNrnrQz1HYxOR9lOpQWRgCK/QhAJLKSalQ+DqZkVNYCWjpjHIOLyn38IfgQTLyqCUVBuN+KYoyVDnk/Oj0sascW1yc9S+Nx5L/+lGGkQt6b4pJWFIa2PmhA7rU88ByWI+M8GCOoWzwbkK4PBn0cur8klfbiCxkNyGzCx1QUj1fNskke1WSj7LzxFXYUyveA48cqkboA10+opEg1dY0ipIUMMHJMDyOIlt8KZQE/LVfNIWAO72utnLj9WMUrbDIGqWjprA5KiR7/xoeMjmpaDrNkfxRsmvup10y0VgYkGuSOtm0d1DRctHfD7SUjSGnfuU6dGnQBe9N4uRT8SFPz4xHURHoRoI0VP2Le2Bdw346Ucjbd6vH/KbKwiONgEPHqqeiMN67QzFUccLn+I3+C8+vzReShrRqDW5EWWi/2KMZEJIekLRhhS+CEQaP7Q2hEbcr8L7zmHIyVR0Wxbk9TdX1dbwXC4CKkaY85cELUb+0W5BsT9X/uxQ5Dm7QtJc9HpJytIWJIR1vqgMg1LR49tiRsO7dkc9N0uSP5clPzC5kOwnZIuIF9cuAnS0+O0uipUJ+cNY5Seh0oKriFajfFGFVpRinIyZ6o5h8vXDbwEaOGDg0TfbcPI0G7/8/FymIvrprQAjyvOdin9NHqEAagoehCex8rpclmytUr39vr7pJNnZP4NvMAayo+USpQ87EG0TUNyNHrTOoyQdOA8/x9jK0Se/KUe2qgBpKPpACCltdYVne2iMpplW/syA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR02MB9828.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(921020)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(38070700021)(18002099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1hWU2JQclhWbUx6QkZxeHE5cjAxL3RSQlhpMWdZUWpqN0tRbWI4Z1U0OEln?=
 =?utf-8?B?UThqaWRDem5BRkNkc3pLdWVXWit0UExYbTNsbjVJdlFRLzF1ZHhDTnY0TXI1?=
 =?utf-8?B?NTFTR0JHQTVUaUV3MFhLWE5HelJDS0E2dEhWZVVxNjZpbit1Q2lmOVdoQ0Na?=
 =?utf-8?B?VS9vTUZrY1lSVGlFbnVZVFErR3l2ckZYVkJZZkQxRVFmdDAxUHFiUEZPRUIr?=
 =?utf-8?B?dmFuaGc4ejExU05sREhyNzhTRXNPNVhvN2QyUWk0cGc3b0h0VGl1bDh5eVNK?=
 =?utf-8?B?Vk5sRlpjaWpWU2xyTWl4WXphMjhsNk1sZnorME5Id2g3dmRJTWg2RFUxTWVx?=
 =?utf-8?B?WDJiQndNY24vblpnRE5DdVlYNXVtcWx4NU5BdEx0S0lERnFHdDFPclNnZHdG?=
 =?utf-8?B?T3ZHMk9BZGlXTktoU293eTRkT0NxKy9LM1JsQTNyclk2N3oyU2xxaytaRytq?=
 =?utf-8?B?VlJudDRMemJuMlRlVmp3SHVpQURXeGxaRzQwS2tUeVpyTWVvQzNRcyt1MDFT?=
 =?utf-8?B?UzBYaDQzSmdOclNWT1ZUM2lOZ1Vac0thaFIxalJDbXljWW51ZXcwVTdWRGcy?=
 =?utf-8?B?REFLcnkvREUyWWZaQldEWVRNd05oTjdzeTU1dlVZY1U5akE4WVFJcnd5ZWdT?=
 =?utf-8?B?QXJFam9rMGJlNjdMOGV5SWJpNFFqZnNnaC9Kb2ZuQkJMbjh5WDMrMmFNNWU0?=
 =?utf-8?B?QTQ4MDlLRFhnWGhUL1hXcjBzTDBHLzgyN0pGaTV0RmI1c3dueVJtNWZWRW9X?=
 =?utf-8?B?U2hudEFYK1p1TWJ6dy9VcmRZRG1pVGdjbmZ2R3JuckFzTFJTSDBudFp5Qjgz?=
 =?utf-8?B?Z1N1aGl5UFJ3WHVCS1FSRmZYemRENlZkZ3FyVVdjRXkvZzUvTzl5T0hjRW42?=
 =?utf-8?B?dmlTcWtMQndsd1pWNTNUMmlydXV0K3dNTGh3SW5GcHJqYjF6SFF2UGRkb3Vo?=
 =?utf-8?B?cHNoSzhKb3JpRkRpOU1odSttSi9pRGFkQ3pIMmdVeFkycmErbmsyeUp4Qm9S?=
 =?utf-8?B?cVgwZjBmLzVuZUJRWkN2Y1RwU3IwL2U3UCt0Rlpyd1k0dTh4U0xjNmVPSFlq?=
 =?utf-8?B?aTY0NG03bGt4c1JJTisyN3NkeTc4c2swY3lXSDc1T1FuOWhnUTQ4ZVhOMGRB?=
 =?utf-8?B?eW5YK3lidndXMTNrM3JEK2h6L2JsZWhCaU5QV2k0U2FkUzZ6eURuY3o1VFZu?=
 =?utf-8?B?VTU2UDV4VUYxTVpuZStHdjdKeklCZzVyQS9YZmpPVGFvd3hpU2psUW5iUnVj?=
 =?utf-8?B?NnNHT3ZZMHJPR3I2ZGM4UWpDWk9vci9LNm4rcm5wYktnR0lKWFNwTEdmcjFP?=
 =?utf-8?B?VURYdGVpR2xNeFJDbzZlcVpJTGVhZ0l3TmZlUDZHWm1NWi9XcjY3MTdITGpq?=
 =?utf-8?B?ZDViVE9xSldnUUhYcHVCZmdJMGsrbThpZEtMNEVNNnlWdVBqYnlWY09ZZG1M?=
 =?utf-8?B?b01USXJUUGc1NGVxRTgwb2lPYlRwSGlUVy8wdHN1bUhrRFZaVmdUd0ZWckIv?=
 =?utf-8?B?QWRUVGZ3NmxzVVgzWDZnOVJWWTV1MkxIT3QrMUxDZHlaelBiR3JoVytQaFFJ?=
 =?utf-8?B?aDJKZFFoYnhUYUgrNmJ5Um0vMFBWRFVmZTlZZDUrV2ptTnNmb0E1dXhOeTAz?=
 =?utf-8?B?ZFIwQkZSZmJVUktrV1BUQ3B1OVM0Q09HcDdpNmdEWDU2a1lVYXVEN1lxOC92?=
 =?utf-8?B?UkVtczJBbStFZk5ZSXhuem9RUkk1djlwOHZwNXdwYUlsQnBTVVhsN1piMlQv?=
 =?utf-8?B?R0N3OEwwZXMxS3pjTFFZVjNmYmk4RmMxS2ZSTEtDak8rUHdtTmRKSWtOZ1py?=
 =?utf-8?B?V21Id3VMWXVtT1ZINEpkMkVhRFRubExhNkF2dDJJUm12RVRpL21VSmFaS0xo?=
 =?utf-8?B?NVFKWnJ6UEw3K3dHdjViRUhpZEk0TWNyVk9JQzd4aUxqOTNFbExjMGZ3LzdC?=
 =?utf-8?B?eVBrZEdXQkVSYTh3ZUhDOU1FZGhSRFIzMjhhVWk2VkdPSWxITEYweDdEek1z?=
 =?utf-8?B?a3ZTMi9aOVExbDhKd1hxZ0JXS1ZhR1FwNVZTM28vN3VLRFVRS09XcHNqYWFG?=
 =?utf-8?B?emdZQkpyU3ZTVHVBSFhiL0ZFcklSYU10SXRCa3B4eEYyV2dETXFIUXhhUSty?=
 =?utf-8?B?U0tkN1J5cUtsU2tSWEdJZ0pwdzkzbEtBOFJHRkZmYVdiOUJaWjVKT25yS1hP?=
 =?utf-8?B?SFpWS2NyNCtYbFZGVFR3ZlQvNHcwd3lBY1B4QUdjUXBoMUUvN09zZkNpRW1B?=
 =?utf-8?B?aUo5N1FYR3c3eGpWVlBqK2JoY2ZJVXFxUFB5QldVSk1SR1ZHdGw4ZEpMUDhD?=
 =?utf-8?B?Sm5zTUhoczV1L1NId1ZIK0phQ2Q5OFFGV29YRGwvNC9rK0FHbGpnbkpINjFM?=
 =?utf-8?Q?N5Bw+Ly2jcnROlu0=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qFHwWdo7NfzM5/yGuBTwimEKkmV609tlwZMNTsJ5vGs8vtgLO8YQNc0qJtBcEFjPRgrgjfu+/esG+q3pjWj+TZPIedOeQK4JF3AgrIE8Q5Effm4QFjzXWHtG7nIpS3WzBZEb6tWCaJXlUP2kowV2b7FdDp7N8RySDy47nA6koxl9dGYVh9tRtWkBt7+f9rQp+XZgtmdklSkeCkE2GGi6JWwGKJPWpDl1SCmAhMUJf8ZmXuFErfHlIjhXoxSqXKwSx4FwVzmFsLjC8eUZ3QenrWBhZRlgTMwdNbd97+THkrv+gluI/X+UQyZlp8T4fgw9kojM8QD/B2Ql21LjEPw2zw==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR02MB9828.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b26fa1-e4c1-4d64-8912-08decc2c8ce5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 04:54:44.7552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WMyVG6ojE4PAm5V+IjcGEjFW5TS868y3XKr7gf/VQRwpmGP5em1IOIlbapMy5vY0Y40ilTXkgLruRgOU5yqwwPMwowgsUsoVPvzU6bD5b8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR02MB11099
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Pe-REX5bWlk8J8C8P7TXgxpmyRs-JssTtgdUNQYzmJE_1781672087
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300032-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Parthiban.Veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Pier.Beruto@onsemi.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Conor.Dooley@microchip.com,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[onsemi.com:dkim,onsemi.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8418F6968A7

PiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldCB2NSAxLzRdIG5ldDogZXRoZXJuZXQ6IG9hX3RjNjog
SW50ZXJydXB0IGlzIGFjdGl2ZSBsb3csIGxldmVsDQo+IHRyaWdnZXJlZC4NCj4gDQo+IA0KPiBI
aSBTZWx2YW1hbmksDQo+IA0KPiBJIGRpZCBhIHF1aWNrIHRlc3QgYnkgY29ubmVjdGluZyBNaWty
b2UgTEFOODY1MSBDbGljayB0byBhIFJhc3BiZXJyeSBQaQ0KPiA0IGFuZCBzaGFyZWQgdGhlIGZl
ZWRiYWNrIGJlbG93LiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91IG5lZWQgYW55DQo+IGZ1cnRo
ZXIgZGV0YWlscy4NCg0KUGFydGhpYmFuLA0KDQpUaGFua3MgZm9yIHRlc3RpbmcgdGhpcy4NCg0K
VGhvdWdoIHRoZSBOVUxMIHBvaW50ZXIgcmVmZXJlbmNlIGFmdGVyIHNrYl9wdXQgaXMgYSBjbHVl
LCBJIGFtIHdvcmtpbmcgd2l0aCBvdXIgdGVhbSB0byBzZWUgd2UgY2FuIHNlZSB0aGlzIGNyYXNo
IGluIG91ciBzZXR1cC4NCldpbGwga2VlcCB5b3UgdXBkYXRlZC4NCg0KPiANCj4gWyA4Mjc2LjY5
MTA2NF0gZXRoMTogUmVjZWl2ZSBidWZmZXIgb3ZlcmZsb3cgZXJyb3INCj4gWyA4MjgxLjY2MjYw
MF0gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0DQo+
IHZpcnR1YWwgYWRkcmVzcyAwMDAwMDAwMDAwMDAwMDc0PiBkcm1fcGFuZWxfb3JpZW50YXRpb25f
cXVpcmtzIGJhY2tsaWdodCBuZm5ldGxpbmsNCj4gWyA4MjgxLjgzOTQyN10gcGMgOiBza2JfcHV0
KzB4MTQvMHg4MA0KPiBbIDgyODEuODQyODY0XSBsciA6IG9hX3RjNl9tYWNwaHlfdGhyZWFkZWRf
aXJxKzB4NDI4LzB4ODgwIFtsYW44NjV4X3Qxc10NCg0K


