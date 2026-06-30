Return-Path: <netdev+bounces-302970-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w9iMJ09WQ2ooXAoAu9opvQ
	(envelope-from <netdev+bounces-302970-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 07:38:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F382F6E07F4
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 07:38:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=selector1 header.b=O1kwSTGZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302970-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302970-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD508302BCC3
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D70838F236;
	Tue, 30 Jun 2026 05:38:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010050.outbound.protection.outlook.com [52.101.46.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76707233927;
	Tue, 30 Jun 2026 05:38:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782797898; cv=fail; b=lKw895HMBDwhgJyx/9dQtYz3uzCWDD+LcZB1uZB2oiS4OfYJCRfvcGS74emlAgtA6EDmtpFSr7PEXjPNSzyKWCcRNOQ4giN6tr0AzXEHkyN52RwdPTlWFDySUy5NSiXdPkhiCgNpMvzW1JEsbkxn4+BgVxZu+uzRTaiqToJBX2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782797898; c=relaxed/simple;
	bh=CbisSd5KGuucjWP5aGTnwnnc3llbU4SFArHSHhhnubg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IUVw9EkrkelAg3jv59pW5gn1a6PS3L3FOYYo+8iJ4SshypihVKgFEXmxsOX9Dj8HNa2y2z90mkkni2eZIGa189Ys5rVXH0B58Jr8Hkkjgx5ui15zjOE6SG6+bMCKJc+tASCCmbU54t3bnawWYlJBvf6y/WQBkMUSAZ7reXWyCh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=O1kwSTGZ; arc=fail smtp.client-ip=52.101.46.50
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTzMn9YDYams9cbQc7lye7QRK3aScDvKtz5yRfeYbQ3UCujwIZ69W9CYBX/fyZ4UIG6zKRNGzTb1zt/7Vb1LJIdXovJiXLfX5HuqRIn8jdMGwf3AcMKz4XqoY0WJC7wQ68zp9zzDJqs42knJFO8FMYlvSqG4z3nou9UwEodlW0UZHGLRenn//WafUkGqMrxqhbnjF3lm8SbTGeMASR6R5b2iRVHGFvdZZuHWc+0A5LCauNUvhWM45whYeicyNUp/mM/7p05mQpR3EQo4mMBKHrPlE5Ti4xd3YZ+njkOn108amtHr6BGicuN+5d4UuAv0n4XvneYlbJVsOOMcXei/hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbisSd5KGuucjWP5aGTnwnnc3llbU4SFArHSHhhnubg=;
 b=CGYVn1TDhiJ1k0/r8oGxqZp5XLSVG/fTH7IK1u2vmz4YqNP/CHaO/r71Z6vNiJw3kmQ27FN9il3UpaI6M2cYmozRgAphaLbUX+qj30JHCtbFhqHN9DVSR61/Gx5D2QYj5RmldrrBy+Qhx07VQnLKCzUJDu34mfD7T6dgF9A/KpaohlIAslJ6gdpxND3GD08m0GB1BW9KZb1gHHgQykIyIqLs5AQRJwfXKFcfD7KbpNi9OgKHvu3mRqF83Npdq2IfClh9eUjNGMv1ttJKW7MJ9lvuxqfehlJMFAl2y/LuZD+wQagVX2oIMcqA5fN1ka2eBm+9fjMKvZHML13mS6rKXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbisSd5KGuucjWP5aGTnwnnc3llbU4SFArHSHhhnubg=;
 b=O1kwSTGZiTRRiKGbHJRkVtYN10nNs8+Y0Y91/w1jfqJ+L/vktNBQKS33VfAuuv3CzYutR8xjwlCLBveS2oLXPXmY8AO/neip5jd/nnQjFvefSQGevRedHF/mC34N2g4qtRkrfdvAxHdytpEvdKxQSNntU5XT0nciX5l80YT8VC8IcbOGFJOSGfIDQ30Z4C0jbK30dVfgzHA4PqCBcqpMUnHQtSIoM45ZoADG5lK08yqcajyoI1x4v3K3Bc71MHx7Mz+Q00ZLHf4ex7o3BNL0OoZcIJcMBOkDEZVa1P95ld8T0KcB+LSVc9HztipYbVU+CJkW/ks+aQ1wJnbz3gQgwA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SJ0PR11MB6624.namprd11.prod.outlook.com (2603:10b6:a03:47a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 05:38:13 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf%4]) with mapi id 15.21.0159.013; Tue, 30 Jun 2026
 05:38:12 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <Selvamani.Rajagopal@onsemi.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<andrew@lunn.ch>, <andrew+netdev@lunn.ch>, <pier.beruto@onsemi.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net v2 0/2] Fix to possible skb leak due to race condtion
 in tx path
Thread-Topic: [PATCH net v2 0/2] Fix to possible skb leak due to race condtion
 in tx path
Thread-Index: AQHdBYF1dp5jUpnr70OodkVPlIeiZ7ZWmkQA
Date: Tue, 30 Jun 2026 05:38:12 +0000
Message-ID: <d3d382c6-5ae4-486f-89a4-885584d863c4@microchip.com>
References:
 <20260626-fix-race-condition-and-crash-v2-0-b6c5c10e604f@onsemi.com>
In-Reply-To:
 <20260626-fix-race-condition-and-crash-v2-0-b6c5c10e604f@onsemi.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|SJ0PR11MB6624:EE_
x-ms-office365-filtering-correlation-id: 59271fb8-59b9-47ea-b2fc-08ded669c6bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|38070700021|22082099003|18002099003|5023799004|11063799006|56012099006|6133799003;
x-microsoft-antispam-message-info:
 YFpLZ+2FJDE/dPFRBqSi0UAFHHW+QKFm6GfIgoopzAtoRSmtO+cW11tNSq+lT9Ig16VCLvTbG747Iqcnc99H/cVx3HH+RHsE4U2m72cCObM3TbnCkZHZSWapkp8YeoiyNE8hfn6TPGJ9FQpfoR6ohNFR5v8iK8iWmMj9PBmEkZBMCs9roMRgg9ANc3yB/9ZP4kDn6P1nAqaM1scjSq72rIYfMKlJufMqsLuGLN1LHpW0P3/CptK7lYDb+mSriwqKFh15+14R0nY2mnc18rOhoNjYQ7fcTY87/7E6pCyD2Z5hsqcc75x++v6U0sWHRpHodUIvyBiuu57urgj2qYyAJVOOs0Qq/thzRbRDa+kVsDKgNZalTusHp8zKl5nbVT9OMiUS/Z1yaGl7ADJI9wPs/h99vUOTegTPCH+JgO9WQyiE7AvZr+1eMQQx6Yxx/E3Zst1ZBvoA3ZmSbVhoN/jI/+BAuuyNfkJYRy/u1FGjMswztDw2bNjW/jKpJkJcDJiHedZTB8lopYIAHTzISoLK9NAoT+t/bwafYxclqOAfsoVzokyUR38SmiVXm1bhMCCA88Fbb3SN+ukaXLIleS9tfPRvd9kztEFGyCC+0JaBRWEyPJIpqs/TgyvGi10gheJRwMmbxd34Kg4T4MGIdpxne/S0T46ykzZF/4EdJpmzDvU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YjlGbkZHU21yYXZ0N3U0WHEzRjNzQll0S3IwMWZVTFQzZnRKQUg0emdmYmtz?=
 =?utf-8?B?bktjUk9KaWZ3THJGS0gydVMwMUJMaDVzMFhDa0pNMTZ0Y0lYclRGcW8ydWtK?=
 =?utf-8?B?Q3FRQmtlNXFjTVRyRmJQbFJYSTlJUlpKTk9EVzFDZ0lyQ1V1d3R4TnlXdEdu?=
 =?utf-8?B?ZEdlZnBKdDMwanh3NjRHQitGTTNZS0x0L0hjbkZFYXp5VHNMK2FXdGdTRUda?=
 =?utf-8?B?aEZGbzBiRnMvT21sV3FqQUUzT3JwbEN6UUh3Q2JIKzJROGxuYXBFZ213TndI?=
 =?utf-8?B?dGF4eFpZWjkzbXYvaGdpd08yZHJ4OXhkM2d1MHFsSjE5R1pRVzl0NnpLdHRi?=
 =?utf-8?B?MmhsS1JRamZyc1FJVE5HdGVEWkxGSmZ6SFZQQ00ySlRSUjB6dEJhTVdSZWdF?=
 =?utf-8?B?UFo4OXB3MHFvQnRHckFrbkkzMGhmVTlzdGdjbDRMYTB2Wkh1a3ZZTUtrSVVh?=
 =?utf-8?B?ZGk5cmp2WHFYSmJ0N1crc2I4aVNrS2hwMHJEQW0yZlZvcGd3Mk9MY0lRcEFB?=
 =?utf-8?B?cjV5eXVVcFRSRHdSK3RacityT29SS0NQNFJxODZxb1hTeHd1bzlnTThndUJk?=
 =?utf-8?B?dnl3eW5nR3d3TVpwVDhhMTRjSHVOWnVyNU1rY1c5VnV6cFY4MFFRRmtSdStM?=
 =?utf-8?B?Q0tta3Jnb2lmQzZqNmdJb0xqVTJPUjBiK1pmTzZBcmlaK3FRRDJPNzZJbGVS?=
 =?utf-8?B?Zk1PWEVvTVlhUzRFTUFQTXdMOWh1ZzJzckYzQS93T3BDTTcxTk5GUXd3TExr?=
 =?utf-8?B?NTY1UnZudC80azJNVzc5WWtmeXQwaW1PTXVuMWx4Y3ZrOThNbWxsYUg2TDhB?=
 =?utf-8?B?SUdFZXNEcmhrRjdKS1V5QXQ5Ti9MRGJiN2N5eUFjOUI2aTdBTGhUd0tTY0xE?=
 =?utf-8?B?YzRxcnNQVDEvSnZmZnNSODVnR1RmcGorbXBSTWFRSW1NOU4wSzErMlN3c2tF?=
 =?utf-8?B?SG1QNm9lM200QWJNYmZRTXF2VEZRdDVpQmFIOXorK1Q3NWxrY1Ayd0ZjVDZn?=
 =?utf-8?B?STZpeFlvOUl6cHRaUTgvYTdNd3BsK0s0a3ZVNElZR3E5ODQxaVNEMFlOQXRM?=
 =?utf-8?B?U1pWNTFycWtNSloxSEk2TXFpbkppNVNPNlFWWm0xczZ2c2l5L3Z2MktsWXk3?=
 =?utf-8?B?YjEvamJUSzNEbFVsNnM1QUFUb0hrWGxkWGxVeS9lLzY0eFBGdFRGMGZZakUx?=
 =?utf-8?B?N3Y3VWhrWGhjSTNTbTlPcDBIK0lwYW5vNzRlZ3o3YmZQa2JnUDFtRU1hUzAz?=
 =?utf-8?B?Vk1iVHBFS0lZN0dsOUFyV2ZhcDREczNYYXZlSzMvMWJGSzNOTlpqbU11eTNq?=
 =?utf-8?B?VnNvclB1QWlTYnlvaS82SDM4ZUJQRVM5WHNNcVJPQjk2dUZ2Qk51UzhDVnZn?=
 =?utf-8?B?a1JVSzZZZytwN2k3R2MyU0d1bjdIZ2Z6N1duK2NCdGdpNzVNdnVHQzdtTHZl?=
 =?utf-8?B?K0l4aGhISExaL043ajQycUxaZ2dLYWNONldpYzliSGZJQjRVVGdYMVFyL2dp?=
 =?utf-8?B?TlRnRDR6SUlUUVdZcUl0dDRDc29BY0h3a0pJNHZBcjBNZnp4QWhlK2FYWENm?=
 =?utf-8?B?M09YMy9aUC94cDA5a0ZScmdFcS82aGFnYmlhZklDOWVIU2hUcXpOaTcraW1L?=
 =?utf-8?B?UTBCMk9hcTlaQmxMN0YxMVo2SG4yU045dkJyTHI4UzV1OW1iZTlBcXJCVXdo?=
 =?utf-8?B?bGhSSE9QOG1sTEk5K29FaGh3RCtJQXcrS2FsT0xEWjVsN0dDSGd0TTExT3ly?=
 =?utf-8?B?NG5ycG9Rc0kwQ05kc2dLZmdRdGVFTmxMY0kxb2VnZzhKT1o4SGRiUEhFa01v?=
 =?utf-8?B?NGNFSWtGSUZEbkM1RWlsWlkyS2d3dGh0dTdRSElIYlB4QWlmd3B4M1hjTlBj?=
 =?utf-8?B?M25ERjBxYkY5U2FOY1liNzBSUk5GN3liYWI1ZWFkWE41Si9IR0Q4bVJwLys3?=
 =?utf-8?B?K0NLdVZzUUpiZ2tlMW5BSkw1OXEwZFp5V3NmamJaZTJIUlRqMjdGeXZvSFBr?=
 =?utf-8?B?R3dkYXdQMlZwd1MzakpqM0pZZkx3eDNER2tjZGFFc3pkK2JpKy9mOGRya0gw?=
 =?utf-8?B?U3U4ZVNHSE1jeHR0NUJoRENEUjVkbGdnL0w0RjdpRWM3d3ozOUNoN25IbWV1?=
 =?utf-8?B?bnRNZzY0Q2dvNDZlQlp2aDdRL0RJS2NWZ2pvS0EvaHZvRktNWEU5cVA1MndX?=
 =?utf-8?B?QnpxUlR3QXVmT25yOWRabzlmZWQ3Um55U3dDR29mdUtCVU84OUFHRDJVWXdn?=
 =?utf-8?B?OHpjT29uZnB1ek1ydDJwV0ZMaGEzRHUrL2RDME5rNEFWNUpwUVI0Z2ZUZkR4?=
 =?utf-8?B?ZG80Vk9FVXN0ZVVqeE1Cam5rNnpWOWdCMEZnREN3cHhUZjdYczNQTStWaVVq?=
 =?utf-8?Q?GXA0DDCtjHAIEkC8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2575FABBA4FF6F45B8F19EF1F63829E4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59271fb8-59b9-47ea-b2fc-08ded669c6bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 05:38:12.7290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H+74AXquXkll1Oo0dCt8D2Lx7c7SUM2GfZENnpSvihQBwWrUTqdvfjmLydH9cwEpQoyurM9xsTRVEc/cuICSf+o3+NFYPs7wGhP0k0IWL4Uak1P61wanV9SjSyKdnQQy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6624
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302970-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Parthiban.Veerasooran@microchip.com,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[Parthiban.Veerasooran@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:andrew+netdev@lunn.ch,m:pier.beruto@onsemi.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:url,onsemi.com:email,microchip.com:dkim,microchip.com:mid,microchip.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F382F6E07F4

SGkgU2VsdmFtYW5pLA0KDQpPbiAyNi8wNi8yNiA5OjA1IHBtLCBTZWx2YW1hbmkgUmFqYWdvcGFs
IHZpYSBCNCBSZWxheSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5r
cyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZl
DQo+IA0KPiBOb3cgdGhlIHRyYWZmaWMgaXMgaGFuZGxlZCBpbiB0aHJlYWRlZCBJUlEsIGFuZCB0
aGUNCj4gZGlzYWJsZV90cmFmZmljIGZsYWcgaXMgY2hlY2tlZCBiZWZvcmUgaGFuZGxpbmcgdGhl
DQo+IGRhdGEsIG5ldyByYWNlIGNvbmRpdGlvbiBpcyBleHBvc2VkLCBpbiB3aGljaA0KPiBidWZm
ZXIgbWF5IGxlYWssIGlmIHRocmVhZGVkIElSUSBpbnRlcnJ1cHRzIHRoZQ0KPiB0cmFzbWl0IHBh
dGggbWlkd2F5Lg0KPiANCj4gV2l0aCB0aGlzIGNoYW5nZSwgZGlzYWJsZV90cmFmZmljIGFuZCB3
YWl0aW5nX3R4X3NrYg0KPiBwb2ludGVyIGFyZSBwcm90ZWN0ZWQgYnkgc3BpbiBsb2NrL3VubG9j
ayBwYWlyLg0KPiANCj4gVGhpcyBpcyBoaWdobGlnaHRlZCBpbiBTYXNoaWtvIHJldmlldw0KPiBo
dHRwczovL25ldGRldi1haS5ib3RzLmxpbnV4LmRldi9zYXNoaWtvLyMvcGF0Y2hzZXQvMjAyNjA2
MTEtbGV2ZWwtdHJpZ2dlci12NS0wLTQ1MzNhOWU4NWNlMiU0MG9uc2VtaS5jb20NCj4gDQo+IEFs
c28gb24gYnVmZmVyIG92ZXJydW4gY29uZGl0aW9uLCBwcm9iYWJseSBkdWUgdG8gbG9zcyBvZg0K
PiBTUEkgZGF0YSBjaHVua3MsIHJlY2VpdmUgcGF0aCBkb2Vzbid0IHNlZSB0aGUgZXhwZWN0ZWQN
Cj4gZGF0YSBjaHVuayB3aXRoIGVuZF92YWxpZCBiaXQgc2V0LiBBcyBhIHJlc3VsdCwgZHJpdmVy
DQo+IGtlZXBzIGFkZGluZyBkYXRhIGNodW5rcyB0byB0aGUgc2tiIGJlZm9yZSBydW5uaW5nIG91
dA0KPiBvZiBzcGFjZSBhbmQga2VybmVsIHBhbmljIGlzIHNlZW4uDQo+IA0KPiBXaXRoIHRoaXMg
Y2hhbmdlLCBiZWZvcmUgYWRkaW5nIGRhdGEgdG8gdGhlIHNrYiwgaWYgdGhlcmUNCj4gaXMgbm8g
c3BhY2UsIHNrYiBpcyBmcmVlZCBhbmQgZHJpdmVyIHN0YXJ0cyBsb29raW5nIGZvcg0KPiBuZXcg
ZnJhbWUgYnkgbG9va2luZyBmb3IgYSBkYXRhIGNodW5rIHdpdGggc3RhcnRfdmFsaWQNCj4gYml0
IHNldC4NCj4gDQo+IFsgIDcwNS40MDU0OTBdIHNrYnVmZjogc2tiX292ZXJfcGFuaWM6IHRleHQ6
ZmZmZmZmZDJlYjcyYTI2NCBsZW46MTYwMCBwdXQ6NjQgaGVhZDpmZmZmZmY4MDRlNWNkYzQwIGRh
dGE6ZmZmZmZmODA0ZTVjZGM4MCB0YWlsOjB4NjgwIGVuZDoweDY0MCBkZXY6ZXRoMQ0KPiBbICA3
MDUuNDA1NTY5XSAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0NCj4gWyAgNzA1
LjQwNTU3NV0ga2VybmVsIEJVRyBhdCBuZXQvY29yZS9za2J1ZmYuYzoyMTQhDQo+IFsgIDcwNS40
MDU1ODldIEludGVybmFsIGVycm9yOiBPb3BzIC0gQlVHOiAwMDAwMDAwMGYyMDAwODAwIFsjMV0g
IFNNUA0KPiANCj4gWyA2NzAzLjQyNzY5MF0gQ2FsbCB0cmFjZToNCj4gWyAgNzA1LjkyNTE1N10g
IHNrYl9wYW5pYysweDU4LzB4NjggKFApDQo+IFsgIDcwNS45Mjg3MjZdICBza2JfcHV0KzB4NzQv
MHg4MA0KPiBbICA3MDUuOTMxNzcyXSAgb2FfdGM2X3VwZGF0ZV9yeF9za2IrMHg0NC8weDk4IFtv
YV90YzZfbW9kXQ0KPiBbICA3MDUuOTM3MDg0XSAgb2FfdGM2X21hY3BoeV90aHJlYWRlZF9pcnEr
MHgzZjQvMHg5MDAgW29hX3RjNl9tb2RdDQo+IFsgIDcwNS45NDMwODRdICBpcnFfdGhyZWFkX2Zu
KzB4MzQvMHhiOA0KPiBbICA3MDUuOTQ2NjU0XSAgaXJxX3RocmVhZCsweDFhMC8weDMwMA0KPiBb
ICA3MDUuOTUwMTM0XSAga3RocmVhZCsweDEzOC8weDE1MA0KPiBbICA3MDUuOTUzMzU2XSAgcmV0
X2Zyb21fZm9yaysweDEwLzB4MjANCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNlbHZhbWFuaSBSYWph
Z29wYWwgPFNlbHZhbWFuaS5SYWphZ29wYWxAb25zZW1pLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMg
aW4gdjI6DQo+IC0gSW1wcm92bWVudCB0byBob3cgZXJyb3IgLUVBR0FJTiBpcyBoYW5kbGVkLiBU
b29rIGNhcmUgb2YNCj4gICAgY291cGxlIG9mIHVzZSBjYXNlcyB3aGVyZSBzdGFydF9iaXQgYW5k
IGVuZF9iaXQgbWF5IGJlIG1pc3Npbmcgb3INCj4gICAgcmVwZWF0ZWQgZHVlIHRvIGxvc3QgZGF0
YSBjaHVua3MuDQo+IC0gUHJvdGVjdGVkIGhhbmRsaW5nIG9mIHdhaXRpbmdfdHhfc2tiIHBvaW50
ZXIgd2l0aCBzcGluIGxvY2sNCj4gLSBMaW5rIHRvIHYxOiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9yLzIwMjYwNjIxLWZpeC1yYWNlLWNvbmRpdGlvbi1hbmQtY3Jhc2gtdjEtMC04N2UyOTBkOTM1
N2ZAb25zZW1pLmNvbQ0KSSBwZXJmb3JtZWQgYSBvbmUtaG91ciBxdWljayB0ZXN0IHVzaW5nIHR3
byBpbnN0YW5jZXMgb2YgdGhlIExBTjg2NTEgDQpNQUMtUEhZIENsaWNrIChUZXN0IENhc2UgMiks
IGFuZCBpdCByYW4gd2l0aG91dCBhbnkgY3Jhc2hlcy4gVGhhbmsgeW91IA0KZm9yIHRoZSBmaXhl
cy4NCg0KQmVzdCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gDQo+IC0tLQ0KPiBTZWx2YW1hbmkg
UmFqYWdvcGFsICgyKToNCj4gICAgICAgIG5ldDogZXRoZXJuZXQ6IG9hX3RjNjogUHJvdGVjdCBz
a2IgcG9pbnRlciB1c2VkIGJ5IHR3byBkaWZmZXJlbnQga2VybmVsIGluc3RhbmNlcw0KPiAgICAg
ICAgbmV0OiBldGhlcm5ldDogb2FfdGM2OiBJbXByb3ZlbWVudCBpbiBidWZmZXIgb3ZlcmZsb3cg
aGFuZGxpbmcNCj4gDQo+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvb2FfdGM2LmMgfCA5MSArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDY0IGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQ0KPiAtLS0NCj4gYmFzZS1jb21t
aXQ6IDgwNTE4NWI3YzdhMTA2OWU0MDdiNmY3YjNiYzk4ZTQ0ZDQxNWY0ODQNCj4gY2hhbmdlLWlk
OiAyMDI2MDYyMS1maXgtcmFjZS1jb25kaXRpb24tYW5kLWNyYXNoLTk0ZDA1NWE2NjVjNA0KPiAN
Cj4gQmVzdCByZWdhcmRzLA0KPiAtLQ0KPiBTZWx2YW1hbmkgUmFqYWdvcGFsIDxTZWx2YW1hbmku
UmFqYWdvcGFsQG9uc2VtaS5jb20+DQo+IA0KPiANCg0K

