Return-Path: <netdev+bounces-284038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF0KCGIH+Wnx4QIAu9opvQ
	(envelope-from <netdev+bounces-284038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 22:53:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3F84C3C5F
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 22:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26B043020A58
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 20:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0950D31E84E;
	Mon,  4 May 2026 20:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="Lnu0I7xw"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B675322533
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 20:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777927889; cv=none; b=Hk8y80YGHghW04qxxtJ/UXX4aLL+Xv8WzHTsEgRfOD5DXA0JMo3c2Alc1loXO4SETRuQszNb2CIi0RqTsL1oVJ9+dYHBHjmTwECajlosF307PNiJC99kGDdsx56ZG//HE7JnL76F2KPpRq/CaRQi0CK9GMP5MSFRvjfFvc3I2dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777927889; c=relaxed/simple;
	bh=wqpanBpbOAS/Op6nh6P74WdSdQlBbIDA1rpbfd6lMfg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=gU1opUhlS358K2qLTnmO3mca8S5W/1BQwQ37JJSsWozWXH2E6KRxiBReIZKio5L9twgw0SMPLU7Y3dprjEqAUAS9+bayZsOakP12QnIjC3Bp0WYLboVrvDEnJFp0e4XEylDox5iYHV4fZa0vFSQ2EOSnhnazpVky0mOkd3E24D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=Lnu0I7xw; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1777927883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wqpanBpbOAS/Op6nh6P74WdSdQlBbIDA1rpbfd6lMfg=;
	b=Lnu0I7xwn72J5y2hrKXFMovYozyDeHsNMUgZKyisUBqKdu9MaISdpBdQjG6wQH2No7RZqx
	ZOxVk/WgATXN4eXAYVNj2kg6GHia1Z3WvDZZiro67vFzYEDxnGnlwkW5FU4Yk3kWpfqP9C
	s4vjipP4LkpQWavTL67O9SBNd1OiAcb5cGNEhUBfHuWvjVcops+wKjF5j8tXzKihQNtGAL
	7YcfXD+rkcfAtUd4ORZ5B4cWS5445Di5Fvlt5/G5f1N3Xip7h2RjOt5z12FaNl2R7G5HSb
	8wi+UthZ/tvDG1n4JAZx5Q1sfBt1MGDZZR2YhFNzYkX3/fCcNcVCnCLlrN0D2w==
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012021.outbound.protection.outlook.com
 [40.93.195.21]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-55-H9mcz39-MfSDroZ6EHsQAA-2; Mon, 04 May 2026 13:51:19 -0700
X-MC-Unique: H9mcz39-MfSDroZ6EHsQAA-2
X-Mimecast-MFC-AGG-ID: H9mcz39-MfSDroZ6EHsQAA_1777927877
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by CH3PR02MB10510.namprd02.prod.outlook.com (2603:10b6:610:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 20:51:14 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 20:51:14 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 4/5] onsemi: ncn260xx: Add driver support for
 NCN26010 and TS2500 MAC-PHY
Thread-Topic: [PATCH net-next 4/5] onsemi: ncn260xx: Add driver support for
 NCN26010 and TS2500 MAC-PHY
Thread-Index: AdzZld+FrVHyslWiQ5KiIZOby61/UQAElaYAAJPFZ9AAAMRGAAAAD6yQAAA61gAAAsE9YA==
Date: Mon, 4 May 2026 20:51:14 +0000
Message-ID: <CY8PR02MB92491007818FE180C0FF0A8283312@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB92494A5A16B7AF4EA3A69F2483322@CY8PR02MB9249.namprd02.prod.outlook.com>
 <12245592-fb85-46d9-9f26-5ed37efacbfc@lunn.ch>
 <CY8PR02MB92499BF412C31A04BADE609183312@CY8PR02MB9249.namprd02.prod.outlook.com>
 <5f07822d-6ea9-4beb-a222-58a94e4801d6@lunn.ch>
 <CY8PR02MB9249082A82E8E2C503D6773683312@CY8PR02MB9249.namprd02.prod.outlook.com>
 <e2f03fc4-2948-4046-83a6-7d587e09ef62@lunn.ch>
In-Reply-To: <e2f03fc4-2948-4046-83a6-7d587e09ef62@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|CH3PR02MB10510:EE_
x-ms-office365-filtering-correlation-id: afba77ab-37a7-4ff7-b5f5-08deaa1ee1b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|38070700021
x-microsoft-antispam-message-info: 5bquB3IWUkG1ZmEJlu69zXBAiS20A3Nqab8daFbMVylEH0Sxpcnz/jYxxmLg9u7SDww4SpbqrF3d6ZBh8QW1999wM2NMyYkwcs23blkOa4V74SU7f8gxE85N/0X8nOOk2+W4doA1GK7BqN97kSV+wQVBm4LzHyAr4bBhRgjJOO05o65d7lo0/O2qxIx2HK6AwbTscTuXIveVa4tbVvP5RThWSGxqGGNusKjJz0vPCET3eGnNKBCQnU6Piv2F/vNOEDsSS0onZDaueE6GbX3UVLjk9cuoHO6LRIN1d0muEbehGd5k6zUeI9E+KqjZI5wdo9+wjrJByQZDwjfL13kfIqZziJvbH64wSyt4UW9fhZTU8ZHY2ynC+brTM8T+HtADW+2KaA8MPWuAoozG1xwuEsIgmpMbqcLcGRLIioEO6p3kO9J8pvrSBqFv8tU1R0vq0+xlf2zWIBKOGDSAyxpBWx7VF+zzhdkmC61OryMRwfpU6XLmsM0rQP8BZ34sqnW+tICML1GDP1FTosxE8gu0b2GPFoBiDiV/so4NHDghtGaihP7Q9v2FukGDSjhf4EcEGmXcYWiHT/T4+oqowmNrkOyzOdyjtsO5lvWCTy6IBMlyRIub2p3M3w7kfctDfZ/WZ2j+cVnRrB2AZzeyM+20lC1XCy3CEloxfr+RZcW3PEgoTZ0mVsZGN2do5JXOxSPkz13bP+st5PdwsBzMJU3NGIXGVLNJ/iHZ1uHjTRGyWNiIhNX4keG9KdsO3Q0EtdTe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VktIN3NwVklJYUdPeXk3QmwwNS9XSC9KTzh3TjQ0MVJXdVUzWDRuaFpzTncz?=
 =?utf-8?B?Yk1tSHpHL1Q4ZzMycXBJNmpzSWpMREo0UUFUaGUySncvdVVxeDg4ejhYMVlG?=
 =?utf-8?B?Y3orR3BCTlJVNXQ2RW5WSkZHa3hxYWlJRVhUQS83Z2Z4eDVsVGlueEZqKy9T?=
 =?utf-8?B?ZHIyaVQwQnpKYkM3UFpxWWVUajRodm9sS0RCVEVDL0tVTGpyMDBBazNRZHo1?=
 =?utf-8?B?Rkg4VVBKbmFyd2JKa2pjdzh0aGpSVmwrZEdWcGVyR2tlcXFLLy9iRUZLNXZT?=
 =?utf-8?B?MW5jVTBTbVdobkJtSllEVU50OVIrVFl6d0U3M3FXbGMxR09YLzNjd2xNcThY?=
 =?utf-8?B?SVJpVEhSVVgvQ2F3WVZEblJHVWtWTGhWN2thOC83SW56RXFxQlpZZUR6WDdQ?=
 =?utf-8?B?aEI2dGRlRzlBQmhaaSs4N0NtVmt5TERzN0NNU0h1eGdsZFVsSWtqamcvWDlr?=
 =?utf-8?B?R3FoMFZCeWgvcEErY0NEU0txWE85S3ZPSGduaFd3dEJnL2tvZjArVWpWd1lo?=
 =?utf-8?B?bUs5U3BGQWljeTFNbUJUNnpCRUR6RFVxR2REUm4rOWtYd2xzb201c2FJQmQ2?=
 =?utf-8?B?c0xFSlZGT0hmRCtkeDluQk5JdzhVNFdSRXd0Rzkrb0FoeHNWNlFNMVlUWGNQ?=
 =?utf-8?B?LzNsSk9FbGVIcCtsOHlWYjdLZ1YraGZKeTBOOUx5dmp1eU00eGtmK1lSdW1t?=
 =?utf-8?B?aDlrU096KzFSUFlWZlNRRk4xSjRwb3loRTBidlZiWEd3SXBFNENsQkY1Uy9O?=
 =?utf-8?B?dVdzSTFSQW5CYnRtbTNmQ1A0anBtYjlHaEhJdFBubmVVaDJKVXBvOWYyWW12?=
 =?utf-8?B?YVdhVVNsdXpGRWJlV0pFOXpnWlkwbTBNTFFianRhWXNBRnlTRjFNeTRtZ1Nj?=
 =?utf-8?B?Qjk3Tk81VmQ5MktiZGVoTFRoQWtaZm1ETVB5UnBMRGI0OE9VbGtZL21ZSUYz?=
 =?utf-8?B?blJTeUVNRG9lL1NGZWI0NjVtOXpMOW5paEhvWmtTLy8vTENlS0lscmlMbFgv?=
 =?utf-8?B?bkJFeWtwSDNqSXlJRkgxZldpOTJlaUs3NXNuUVpVcFJEY1lnWTc0d0xFNGhh?=
 =?utf-8?B?bjRBbmpZNGdidDVpcUVvU1JJcURnZmRXemJ3WE1FbFQ4NEFDeFlJYlNGY0sr?=
 =?utf-8?B?SzZiUjBjWjY2UnRSdGR0OHdwQnp3aDU1SFNmV1JyMzJ3a0Fyb2g5ZXJiTk81?=
 =?utf-8?B?MmZhSldJQkxiK0ZaWTFwK1VmNWVFeTNxdFhhelRhZVk1ejVpS2hwU1N4cVox?=
 =?utf-8?B?aGQ5OTE5UFh3OUxxSlpoTFd2MUpDNWhwamZYOGVtK1NtWTU4dGhCY0lReDFj?=
 =?utf-8?B?YW84bGdYTDBqNlJqM2M0THREekZhaURTeGo1d0xUNGpEeFNVRHhyRytZeTdU?=
 =?utf-8?B?TlZEUjQwSGQxczdLTitpemxkTXlxNTI1WDdiNGdBRjVWOGNjZzJaL3lHWU1Z?=
 =?utf-8?B?TkxWQ2FJa2hMZDBYY21NZzJMYTlZdkJwMWozc3Y5cWhSV2U3Z3VVNzBhRy8y?=
 =?utf-8?B?ZndxRnVHOURDQTdLb082eE5xTnlOdUYxQ05FUERTTzMwTTRId0o3NEExQ2pZ?=
 =?utf-8?B?QVdDUlR4aVlqRUZjZVRiMmtveUs5N0gyU2s1Nm9EMHl2Nmc1SUh0VVVtcVNl?=
 =?utf-8?B?cE5lZjhxMFNGSEdrczkvckd6cjJRUENvT3E1THhCTFBBWDRwQ1pGRDlUMVVv?=
 =?utf-8?B?Z1I4aVRIeEhlazJhdlRSZmhvU2JMZUV4NFFFTTdveVVMYWt0amtKWEIvd1kx?=
 =?utf-8?B?cDhTMm42aktwTjJtT0VEWDRBeFZYdkFib3ZwK1VycnpwUUQwUlo0dmFzWHpI?=
 =?utf-8?B?VmNpRW0yRlpkZitxTnJsaUoyeDZKdEg0OTEwTmpIaFhGRXlCRHRnYkVYVXhX?=
 =?utf-8?B?UkhDUElKdG0xM3lGZzhhT0s0cHZCWGVNNDdFLzdGOHFZTTFlTlBTcGY0WXhC?=
 =?utf-8?B?ZENUS1lZUm1MSk0yekV0MHVBQkxxcW1ydEl2WlpaWDBmZndRb1Y2N3hma1dG?=
 =?utf-8?B?Rkkvcm1wTElWS0JrSTJjd1hNblR1MmYrOXpjMW9WNmpKYTk4YW03Zm9xSGFo?=
 =?utf-8?B?bEY2REZoSk1CUXd3dHRqd1VibmpOYUQ0dm1zY2pPZVZmMm1aWjAzbEhBSTNp?=
 =?utf-8?B?WWY1b3doWEN5TEsrOE94TW02elhpaWh6c1lEdVZsendlM2IyRWRENmhDR1VO?=
 =?utf-8?B?QStHK2EzdTFPcHpoY1JtWlNLVzVBdDBjVTUzYzQ2NEJkdFFrTk5UdXkyMEN2?=
 =?utf-8?B?WjhTNElYZ2p3NldFSTBJNkpVOU4vbGdXRTR3aFhsSFJiOWtGcXZmcnBGeTgr?=
 =?utf-8?B?bGlHa3RDRE1UZzhWVWhPb0RYR2NYK0hrSWhWajBGbDI1M01jSjErOFl4cWMz?=
 =?utf-8?Q?G+CcrJldBK3eDq5Y=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: o3Pa9XJLWp8rcKxDsiuslKRsxy0x3lLsCaq4d4DDySSINzlOpIdoc3AU/TnQznelJitbx1JMYOrlguoyJS9AxOrK/UrGpA5kO7YGMrKr2mcmonMLKLctY3E2eq0l8EB83RNdnNv4pHIk6p1Yo/caEb6icZ7H4W8eJ+O5JJ4M24IP+TH7m4gT2kkBCjEeQugHo+7sXuVo3OUcU5Z1AiegjuKGA6oLyGMWQtvNMZmi7iEXuKGl+qAg6n4LN0k1l/NCc9RnKTfpX3SBo8D01kxynt4evn0MrSC1T2obpn7iCGxwHe/5Bm0S5vlUwyZ8n6+XUN9sKIZxSQDYVh7jp1wDQw==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afba77ab-37a7-4ff7-b5f5-08deaa1ee1b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 20:51:14.5205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jEXzceb8WQMU5fR6My0AEJHP/VNfBGNKSsIc0VnKp2qomSddlbDcqVkgpoVYOgWaXtLc6m9LXU6XSiiuCNHCergDSUR6WfhnVuE1GpNykSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10510
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SZiun8GzaDqYR6QTUAM7Sws2hKy0u4zFsGAga1rPgFc_1777927877
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Queue-Id: 6F3F84C3C5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284038-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[onsemi.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email,onsemi.com:dkim,onsemi.com:email]

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IEx1bm4gPGFu
ZHJld0BsdW5uLmNoPg0KPiBTZW50OiBNb25kYXksIE1heSA0LCAyMDI2IDEyOjI0IFBNDQo+IFRv
OiBTZWx2YW1hbmkgUmFqYWdvcGFsIDxTZWx2YW1hbmkuUmFqYWdvcGFsQG9uc2VtaS5jb20+DQo+
IENjOiBQaWVyZ2lvcmdpbyBCZXJ1dG8gPFBpZXIuQmVydXRvQG9uc2VtaS5jb20+OyBhbmRyZXcr
bmV0ZGV2QGx1bm4uY2g7DQo+IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5j
b207IGt1YmFAa2VybmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb207DQo+IG5ldGRldkB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCBuZXQtbmV4dCA0LzVdIG9uc2VtaTogbmNuMjYweHg6IEFkZCBkcml2ZXIgc3VwcG9ydCBm
b3IgTkNOMjYwMTANCj4gYW5kIFRTMjUwMCBNQUMtUEhZDQo+IA0KPiANCj4gVGhpcyBNZXNzYWdl
IElzIEZyb20gYW4gRXh0ZXJuYWwgU2VuZGVyDQo+IFRoaXMgbWVzc2FnZSBjYW1lIGZyb20gb3V0
c2lkZSB5b3VyIG9yZ2FuaXphdGlvbi4NCj4gDQo+ID4gPiBZb3UgZmFpbGVkIHRvIGFuc3dlciBt
eSBxdWVzdGlvbiBhYm91dCB0aGlzLiBXaGF0IGhhcHBlbnMgd2l0aCB5b3VyDQo+ID4gPiBkZXZp
Y2UgaWYgeW91IGFjY2VzcyBDNDUgcmVnaXN0ZXJzIHdoaWNoIGRvbid0IGV4aXN0Pw0KPiA+DQo+
ID4gU29ycnkuIFdhaXRpbmcgZm9yIGFuIGFuc3dlciBmcm9tIGhhcmR3YXJlIGRlc2lnbmVyLg0K
PiANCj4gSXQgc2hvdWxkIG5vdCBiZSB0b28gZGlmZmljdWx0IHRvIHByb2dyYW0gdXAgc29tZXRo
aW5nIGxpa2U6DQo+IA0KPiBmb3IgKGludCBtbWQgPSAwIDsgbW1kIDwgMzI7IG1tZCsrKQ0KPiBm
b3IgKGludCByZWcgPSAwOyByZWcgPCA2NTUzNTsgcmVnKyspIHsNCj4gdmFsID0gcGh5X3JlYWRf
bW1kKHBoeWRldiwgbW1kLCByZWcpOw0KPiBwcmludGYoIiUyeCAlNHg6ICU0eFxtIiwgbW1kLCBy
ZWcsIHZhbCk7DQo+IH0NCg0KQW5kcmV3LCBJIGhhZCByZXBsaWVkIHdpdGggdGhlIGFuc3dlciBl
YXJsaWVyLiBUaGUgYW5zd2VyIGlzLCB5ZXMuIGl0IHdvdWxkIHJldHVybiAwLg0KDQpSZWNlbnQg
dXBkYXRlIGlzIHRoYXQgYWZ0ZXIgdGFsa2luZyB0byBvdXIgcHJvZHVjdCB0ZWFtLCB3ZSB3YW50
IHRvIHN1Ym1pdCB0aGUgc3VwcG9ydCBmb3IgVFMyNTAwIGZpcnN0IHdoaWNoIGRvZXNuJ3QgcmVx
dWlyZSB0aGUgcXVpcmtzIHdlIGFyZSBkaXNjdXNzaW5nLiBJdCBpcyB0aGUgb2xkZXIgY2hpcCwg
TkNOMjYwMTAgdGhhdCByZXF1aXJlcw0KdGhlIHF1aXJrIGZsYWcgeW91IHN1Z2dlc3RlZC4gDQoN
CkluIHNob3J0LCBuZXh0IHZlcnNpb24gd291bGQgaGF2ZSBtb2RpZmljYXRpb24gdG8gT0EgVEM2
IGZyYW1ld29yayB0byBhZGQgaGFyZHdhcmUgdGltZXN0YW1wIHN1cHBvcnQgb25seS4gV2Ugd2ls
bCByZXZpc2l0IHN1cHBvcnQgZm9yIG9sZGVyLCBOQ04yNjAxMCB0aGF0IHJlcXVpcmVzIG1vZGlm
aWNhdGlvbiB0byB0aGUgd2F5IE1ESU8gYnVzIEFQSSBhcmUgaGFuZGxlZCwgbGF0ZXIuDQoNCldp
bGwgcmUtc3VibWl0IHNvb24gYWZ0ZXIgcmVtb3Zpbmcgc3VwcG9ydCBmb3IgTkNOMjYwMTAuDQoN
Cj4gDQo+IEFuZHJldw0KDQo=


