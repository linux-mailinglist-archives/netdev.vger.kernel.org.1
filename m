Return-Path: <netdev+bounces-306028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iKirNLoHT2pzZQIAu9opvQ
	(envelope-from <netdev+bounces-306028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 04:30:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB0172BF1A
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 04:30:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=Duipelcg;
	dmarc=pass (policy=reject) header.from=onsemi.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306028-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306028-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B865330478E0
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 02:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BF7330337;
	Thu,  9 Jul 2026 02:29:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED6C2E06E4
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 02:29:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564182; cv=none; b=PKFRTj94u6U/O4aCd6Ffg3swTqRoTqfat7XeYvHrvQmLxLFMQd0Bum309lKzWzHj3P05YxRCgh3sl4Xg0rM79MutXjV0bXMPRrCHZ/L4FeELZStXmRWKanEf7cYSfbA5U0bbuKfch23yBFYsJLzsjxVqAOlwSoVldmWe+LExhtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564182; c=relaxed/simple;
	bh=h7ixAFmKcgZptEaFgwYIMwhx22MwAhDKeNBxTwFO+gk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=FhHPKDFgAeYGpICqiIE6gpoAoBRn9ZsE8im4Wc8zx9OItZlUEAMBX9vVo1MhhazkE9qacc0AED9G2Xl7F6Vp6oH/urwd2gtXf/mBZKss8GxYVmmLYTVS0S0f/EmAwXF1jLxJm8bOcTyDU3xju2GnlsF9uq0pFgY1yyemUn6Acd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=Duipelcg; arc=none smtp.client-ip=170.10.153.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1783564180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h7ixAFmKcgZptEaFgwYIMwhx22MwAhDKeNBxTwFO+gk=;
	b=DuipelcgW0J7slaGL0HMXjByWyBK7qGVRFrnXjhxKLolub/8zO+ibffoYssiQ/pqRY2UaE
	UNBfbVaJ4cJCFOS8zNZvsCiH1w4+e/fuPiwT6+smI9QfCgNg0HLnjyJgFPIhRgNit/lACF
	1mixe+A3ECByXI9DSMFx4c9SqIc3ZkMq7Zadcp1HSb58KYU+Bve+KAvR0zeJyQiDbLKEOz
	KvLVW1NhGyeuoQgkF4zVHYzlCHx8nesOQ6YWWjt4lCiR2JMDIDTgvEUSeIr6wBDpzRzhgO
	31WLwUG6Z0iH6x4nbwYv7yJpzmGOAQN2eJKyGgKTcFqbftP6Aj/b99kT79E8Mw==
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011044.outbound.protection.outlook.com [52.101.62.44])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-10-v36LDFo5NyKphKHIYueCfQ-1; Wed,
 08 Jul 2026 19:29:34 -0700
X-MC-Unique: v36LDFo5NyKphKHIYueCfQ-1
X-Mimecast-MFC-AGG-ID: v36LDFo5NyKphKHIYueCfQ_1783564168
Received: from CYYPR02MB9828.namprd02.prod.outlook.com (2603:10b6:930:b8::20)
 by BN0PR02MB7917.namprd02.prod.outlook.com (2603:10b6:408:160::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 02:29:27 +0000
Received: from CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca]) by CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca%4]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 02:29:27 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: "ciprian.regus@analog.com" <ciprian.regus@analog.com>, Parthiban
 Veerasooran <parthiban.veerasooran@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH net-next v5 10/13] net: phy: add generic helpers for
 direct C45 MMD access
Thread-Topic: [PATCH net-next v5 10/13] net: phy: add generic helpers for
 direct C45 MMD access
Thread-Index: AQHdDmHokZwNZhTmyEi12dE3JLi4pLZkd5Zw
Date: Thu, 9 Jul 2026 02:29:26 +0000
Message-ID: <CYYPR02MB9828A0F83559EF025D01A14C83FE2@CYYPR02MB9828.namprd02.prod.outlook.com>
References: <20260708-adin1140-driver-v5-0-4aca7b51a58b@analog.com>
 <20260708-adin1140-driver-v5-10-4aca7b51a58b@analog.com>
In-Reply-To: <20260708-adin1140-driver-v5-10-4aca7b51a58b@analog.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR02MB9828:EE_|BN0PR02MB7917:EE_
x-ms-office365-filtering-correlation-id: ea9e8d8c-2f13-49cc-b343-08dedd61e5cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|921020|38070700021|18002099003|22082099003|6133799003|56012099006|4143699003|11063799006
x-microsoft-antispam-message-info: OAZxQLv4TukccaRUtc9+mcsyCHTvPE0dfQYRmkiRyZrXNSJYQFt/9zrvVu2W8IPJfxbuP0BNwmeqyYVlUWz2Ek/kLJUSJciNNyTHcVDJj1eihlkgK4xcdwJ8/qd5EKEP3YTBrNCRW2g5SCfBhF9a4TRdwddgYe2AfVJl5SsbAmRoVM1KKTekfxJZh6vHpGedBWmOhRGc50sUfBqVHtLuI1JV1HoBgNFBVo4TA+WxbWReP5VXkAVuseIhavrA+V009+pcEkav0GlsWxblZrnReLr9NVhvtcORHbsIxjx1GNiOX4HcMgqY41M0WgQ6RgY8ttv9P4YySjr4qr7Km7DMTAU7OGzYFRlsGHYd5lauAPMw49t5VuKLz2pjmylyAiV/1UqwdhcBk1ehIER/Y0cgPldAO5R+35mWHox8w+JQV/5u7zZayPYzADIGoCAFit2kxBd4OE97XEvb+cA/IV3dBBMwUhSKAUvAIdOgTm0QRHPRgrwPDtnTSKAKfhDCsPCnlUX2zYNExbNEWnfOCL14Q3qinUZeM6KioDMlQ3HZ2+0V9zBhXU7V49k1lycloe0bt3S1i9nuzvql/K3F9tioZsZUDlnS0nMZ78KCQMa3ABmei1iMkznp424nhfQeTAz7wLbODBmj0EJTemeql9coaaUIspQXVDxfbtf7igUSmSIlel/W6vEcv/MAvMUmcWxKF/suRZXqqsp0G0/HT6Xm7zvRD1P4/IiuskjXFc/JemJEGZl1fbUW3gENF+t2SHnc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR02MB9828.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(921020)(38070700021)(18002099003)(22082099003)(6133799003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3Y5dTlKeE1GZTZiYXo4OFI2V09rdmhuSzNlRnJ3RVQycGNNc3RGK3BBUCtV?=
 =?utf-8?B?bHVPeE1aZEpFR3lWb0ppcjlGejNVSEkrUVEwWkcrTDF6cXhHSG1jTHJMZVZa?=
 =?utf-8?B?RFRDNTBhTUVoSTFEcmdoc1pjMnlYbnlDWllvMWREK3FaY1pGSzdJbWlYbS9H?=
 =?utf-8?B?WVN5Q1pVNU5jWGVzR0srczR2eTR0Yi83bnRTd2F6UXdZZE9qNG1aWlFPbUcz?=
 =?utf-8?B?WVU3bzNOS3ZPU3RsZzZNck1QcmcweFVac1RtbHd5NnYwcFlmeEpzanpCSXZy?=
 =?utf-8?B?TGtZUkptV0x3Y205cVdTTjBjTW5Oa0puaGZGU1U1NzRkcGZFSjJ1K2NvRzc4?=
 =?utf-8?B?a2hCUzhWSGZJUk55eWl6SElibm1oRkVKUDdDYnBURTRmRXp1S1ZZUXJWSzI4?=
 =?utf-8?B?bTFvcHJhR3c2Zi9XRmhMUGthZk1xWUM4b0svQUVBYW9WQklNMCs0cTlabHZH?=
 =?utf-8?B?c2wvVVJSNm1QUGtySGowWE5qZ0gzZUpndEpCU0crWnhQVy9hZkwrczcvOC8x?=
 =?utf-8?B?Tkd2QWhVZU1NZ21pajdEelJ6b2dtdWtSRUlqQXhiaXYyVFZ6VmhBYnZBSzhS?=
 =?utf-8?B?Z0lvTHlhR1ZaTnJZaGRpTEJHaFZzUnp0eEdkeUZ2T1VCNGtSVm83c3BSU3dZ?=
 =?utf-8?B?TVcrRm95cVBaeTV2SGRacktTd2V1bC9ObjFrSk1McGZsMllxdVFMNUFXeHdz?=
 =?utf-8?B?TStuTDljeFFUanN6QlhhZDY3cjI3aTRua3JmMFpKcDlmVDhUTFQ4N1Z0VW9k?=
 =?utf-8?B?YVVydUZiblJwQjlZNVRmOVBmL0MyaDRKeWVBckFwdlpYZjNKVU5yNVFCYmg3?=
 =?utf-8?B?bXNPd1FpNVphT2FSOUsxUkV0M1RDS1NtMnJlTGFVWW1ab0xQampKT1pmTCtF?=
 =?utf-8?B?aEU1OWxzU0QzNkFWbzhGWkNTZVA0ZFFldWJ2UjFwMjUyanVhQmNkQ2VMMk5H?=
 =?utf-8?B?TjNicHNqNGhqdTBpQ0lEM3VMQWdEdlltK0VpMUdnYWQrU3paSVJtWlFpMHhp?=
 =?utf-8?B?SjJsekF2MTBoNCs5cG1FVjNGYnFBYzVmZjZJVkZKV0l0TjJJZytBYUZqb1gw?=
 =?utf-8?B?TUhUaTdBbjg5anZxeEluYzgvZnZHb1JjTnVWUlRtMkZ2b2xxSnAxWnpFQ1c5?=
 =?utf-8?B?SkF0QU15MW1zcW5IakZyNU82d1ZHVzlaV051R3djczZCWlVRWE5rT3RMcG1G?=
 =?utf-8?B?UjlCQVBjaFZCZmdQYVVKZXkxUjd6MW5PcWJ6WTVOVU5EUFBpRERDSmQzKzNn?=
 =?utf-8?B?REpqYXhZcnRjTUxrbGYwTEd0ZmppRzRkRzBVTTdvcmNxL3p3dmpWQVdmOEts?=
 =?utf-8?B?TW53amsyOVI5MXZ5MzAxVWw4YU4xY1J2Tkoza1dsTm5WcU41NW9oL0Jybmgr?=
 =?utf-8?B?YWl5RWR6cTJkcENqSkEwS29lTldpb3B5bGVDYWFDK1BKR0dnaG04R1cwRUJC?=
 =?utf-8?B?bTRxbzAxeU5NZVQyRUZsZWhCYzJXYi8va3pXbEI3YVEydngzOHg1L0d0cFo3?=
 =?utf-8?B?aFRZc1BlRVdONjNndTFjSWNNSW9uNmRnMjFnTlFpbDQxcm44dzJxc3RqUmVw?=
 =?utf-8?B?T3RiQXowMHlCdEVQOEVRQVFlSVJtb09nckxsSjFqUzBvZnhPY1p3bHFNdFVl?=
 =?utf-8?B?dVRMbVhhYXBOUExzNXVrKzJYSEdQQVFET2IwV0JOdUhPaE05MW82aURtU3Ix?=
 =?utf-8?B?Vzg2dEJGdkdQd2pmQXhDTlM1YjBVbWt4eHVyL2RuMldIbVFYREtjR3ZyS2Rh?=
 =?utf-8?B?Zm5oNFBaN0hpeklaRGt3ams4UFZlVHRjaGp0eFZaOTlUTi9KUWUySGlEVEh3?=
 =?utf-8?B?NHgwb1BxaHBqVm1uMlVjVkVsMkRtV1JzSG80YTQrRUJFdmVXaFhpYVZUVm5Q?=
 =?utf-8?B?ZFpmckJPbVVLWVY0S3VWZzdNcW9mSFhMQ1hIUFJsbEdlL05zUks0b1RndENG?=
 =?utf-8?B?ay8xNndJRnlSV1p6NnFkTW4wTDZlSXY1ZDBDNUxLUUZIUnR4a3h5bm9qY0lP?=
 =?utf-8?B?QjJicWU3eExRSXhtTUhTUVRsbjMvRXdEUGtGSTQ2cXlJcnBZSG96N01LOHVj?=
 =?utf-8?B?OWg1UWtpU3ZUbHhrTmEyeXZHOFdNMUVIM211WWZWLzVyZFp1c1haNy9DVDhu?=
 =?utf-8?B?TGd0a2IxRmtGZHczNHNZam9HUTZpU09RaXJFQkwzTFJ0N094a2J6VFdJN1d5?=
 =?utf-8?B?MjluWDB2ai81VkY0MFdJSTZBOVpQRDB5L1pPbUdSWllVR1lhM3VJelRuZmla?=
 =?utf-8?B?TDJab0JlY0haVkZuT2kxbUJpU0xiTCtNVkxGNi9td0VHOG5waHRzWmNCdzFz?=
 =?utf-8?B?NHB6cXdKNG1MeUJRU2ZIREI1Q2lza3hFbVRWUGNNRmMxOWFBRTRUSm15eE9u?=
 =?utf-8?Q?meVj+lKBpoKlT39g=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ezuC4Yp30IrfcPbyz+qykLsl4WV28+xQI4zcaxJ31V0KWLG6w/22KqYkizVRuxBkxzPqX6I5mxcpMkFA5pIgn///RZFC+8QX7efuFqQZnla0o4xpkO3YfC19ubOzzAnWDvBErAL8i/253KePzQyjG/yG4QTyD8ghn1GUHkAne3DtnCKrwdlpNCmYYwI7wTHoNvF3d4wUZnHGoo+vOV7faRiqi2caPeZzN8bPqCx5/r1JilCrgPB70OHNRXNpT/FBmX22cIIicbkTFA9fqCHBFuGcM89Be1EKAVNPy3XQXDmOilxIS81zOfJdncjRMoUPwZ62JfQs6U4mnvvncp8oRQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR02MB9828.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea9e8d8c-2f13-49cc-b343-08dedd61e5cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 02:29:26.9607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dAC6CMVxNRglRSLs9Bu4f6KbdAKHjCg7w3XLLvpasRKYW+lNFfYWeopcx/Xi9U+zurSRCA2DECHEvjr3BYUWCwgNBk8xacQzxbAvjxOgEh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7917
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YrcEm1MrEAoWw-3UsaXCy3HKb6yFBklKzMPI_NSkkJw_1783564168
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ciprian.regus@analog.com,m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306028-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[analog.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,CYYPR02MB9828.namprd02.prod.outlook.com:mid,onsemi.com:from_mime,onsemi.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2FB0172BF1A

DQo+ICtpbnQgZ2VucGh5X3JlYWRfbW1kX2M0NShzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2LCBp
bnQgZGV2bnVtLCB1MTYgcmVnbnVtKQ0KPiArew0KPiArIHN0cnVjdCBtaWlfYnVzICpidXMgPSBw
aHlkZXYtPm1kaW8uYnVzOw0KPiArIGludCBhZGRyID0gcGh5ZGV2LT5tZGlvLmFkZHI7DQoNCllv
dSBtYXkgd2FudCB0byBpbnNlcnQgdGhlIGxvY2tkZXBfYXNzZXJ0IGhlcmUuIFRoYXQnbGwgZW5z
dXJlIHRoYXQgcmVhZC93cml0ZSBBUElzIGFyZSBjYWxsZWQNCmFmdGVyIHRoZSBtZGlvLWxvY2sg
aXMgdGFrZW4uIEFuZHJldydzIHN1Z2dlc3Rpb24uDQoNCiAgIGxvY2tkZXBfYXNzZXJ0X2hlbGQo
JmJ1cy0+bWRpb19sb2NrKQ0KDQoNCj4gKyByZXR1cm4gX19tZGlvYnVzX2M0NV9yZWFkKGJ1cywg
YWRkciwgZGV2bnVtLCByZWdudW0pOw0KPiArfQ0KDQoNCj4gK2ludCBnZW5waHlfd3JpdGVfbW1k
X2M0NShzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2LCBpbnQgZGV2bnVtLCB1MTYgcmVnbnVtLA0K
PiArIHUxNiB2YWwpDQo+ICt7DQo+ICsgc3RydWN0IG1paV9idXMgKmJ1cyA9IHBoeWRldi0+bWRp
by5idXM7DQo+ICsgaW50IGFkZHIgPSBwaHlkZXYtPm1kaW8uYWRkcjsNCg0KDQpBbmQgaGVyZSB0
b28uDQoNCg0KPiArIHJldHVybiBfX21kaW9idXNfYzQ1X3dyaXRlKGJ1cywgYWRkciwgZGV2bnVt
LCByZWdudW0sIHZhbCk7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MKGdlbnBoeV93cml0ZV9tbWRf
YzQ1KTsNCj4gKw0KDQo=


