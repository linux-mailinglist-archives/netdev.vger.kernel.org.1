Return-Path: <netdev+bounces-295703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id acOUEEJ8ImpJYQEAu9opvQ
	(envelope-from <netdev+bounces-295703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:35:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A93156460A9
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:35:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=jxHbk0TH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295703-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295703-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3B943047076
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE51F47B42E;
	Fri,  5 Jun 2026 07:33:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011065.outbound.protection.outlook.com [52.101.65.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF21447A0C2;
	Fri,  5 Jun 2026 07:33:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644822; cv=fail; b=QnFP3vFacmH5/JVY/eM01sk0nJqbVhgUjTF//lF+ALeBlNkbPVYF3gcObBorL8lG/sqPeSPP+YsjrE5gdKIcgyfXwuaDFBgOFCWjixXu/uHbePlOGWTONfIraKqsKAKDGjgtgfaj4NNIE0rf96+Tft0iUvlMmsDJQuun3GN0W6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644822; c=relaxed/simple;
	bh=+3Qmf1X0e9tWSBaB1mRqYspacKbzl/cemLcVH6lh6Z4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ns0gktTZFxG4GwTU7OPx34jijFUnDL5QI6rUbStZalWzlG0L90g87wwYlgF34oqF3qgpRw5idZRIRnoYynJcNlVYb9b6K4XeotlQVez8e7DUTyg4jwXbJVAIBtQenJlppPK4t8vvyYPDyd+x5xXVPZx/kf/LM1zZZhHOF777lhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=jxHbk0TH; arc=fail smtp.client-ip=52.101.65.65
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCpFX9kgx7PKN1PnGfDnR7ij2blfwfGlncxnzSI/5gEJbIjwnGmxMNHJdGr3eHs/RA2j+hxynpgw3k6wj6RQQoAVhS7kedyJNt5fDMT+wtsVuVfxpAXyz/VzBhWWocJUDBv3gLNPGpfc9VWb5UsdGoAWe4TD7/y+Kkt6UibXibg2s+Zfb6VQ32CG5kiQaiZdaTL547TcPbV89JOdJ+BTD4YVR7UpeCS+X2Hg9T0+NuPa0P7HLykd3Zg0kPmwt2T+FSgUUJzsVRU6OsHT2SfgczZ75cD0vR1sw1fjkAMJxmDDw7Itid/UhRD++rduYKsS9xyuIvwVbLF1krMfyFSwNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UIR0qr+MCyhcqyh176VxKwOQofQDmIznqTeaRbOA/o=;
 b=ZNunoYgE/rXDHyVRQnBdrw2/zvqwUFOCHuRcqLSQT96lis+N7SFm5A7FKg9arFZSwqPnKZ8Rjc+ue+fkJ11MphjlToZed0wSlbw5P8gKVu8NFpvX0B31Lw9/ZXmduSVprCCKgw/Ser3bubpmI+2eeBksubcojGByGwcLoNe2hgJ3OANF7tCJFXJYZsoUtU7x2NR1KhLCLmoIBMgjfqigh2Cqn0iaSyw66d6Gb4CNgMJhnYZhjxyP7M9k2Bb9iCd4F7jfSgIhYR6dOGS2Ma3n5LzZXc4UvGfAX6csl+Buy73vPYUBot2uSRk0AnjrE2ZhYkLXaiWo5cAUFs/hZIRYxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UIR0qr+MCyhcqyh176VxKwOQofQDmIznqTeaRbOA/o=;
 b=jxHbk0TH6y1Et80pZeweQsPyC6DcFt9gg6+iWeber5zcbbxUnd0r3VjzxS0SDxGE+UEVsttUQBJIXrTxm0b12QfWUYMiOwM7eVvYfSXNTu8MmhS9oiYzp+XXfkWKI0/700Oc/AAcXmFwT2G/8pmB/2w45HEFreaMbTNncgoxHxPDa/AiiGwwDpSXUqViLNweJtM70iFo9bs42BXTzJhY9s4f0IBytox7Po3QNtF9QgD3z+YrZMg5rr7DECU8Ygq7hETQXdzQ3eOxfBxcMnatpHNZLGX14UqCr2miC3nAkg8Z6Yrfr/iCFIGosBjG4MVD1lagAw1kovLqHwhTAymPIQ==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 GV2P189MB2912.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:26e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.8; Fri, 5 Jun 2026 07:33:36 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 07:33:36 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>
CC: Simon Horman <horms@kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net] tipc: require admin privileges for TIPCv2 mutators
Thread-Topic: [PATCH net] tipc: require admin privileges for TIPCv2 mutators
Thread-Index: AQHc9EL8BMh0sI0f4kKmrWLCm578SLYvkK0A
Date: Fri, 5 Jun 2026 07:33:35 +0000
Message-ID:
 <GV1P189MB198889FC61EF33D109D8B100C6112@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260604163102.2658553-1-dominik.czarnota@trailofbits.com>
In-Reply-To: <20260604163102.2658553-1-dominik.czarnota@trailofbits.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|GV2P189MB2912:EE_
x-ms-office365-filtering-correlation-id: d7a48354-edc5-4066-fcd6-08dec2d4c0ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|3023799007|11063799006|56012099006|5023799004|6133799003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 /iDWidjmlzdHhcszvBcfs0w7kEGehEN6zrMRhCLqr9xmF/q/3pyinpW/7nsUKX3lYWkuTlJTeOQ/B2gz7+kVaZN8Lcf+t/7k1uPcmI8QFvkNfoVk3tdQbZvgXkrh7MVRmHPwDNnRJojMvuyyW+FtkXQeEZXaFA/xcmvpTRF4f+ALhRlmQ8J6iwSo/6GWtjX3hRKuc0e1KOPHD0mLzMZpV6DY2/d+iLkbcotOKy0pSb8ZASF12bkAgltX6EknM2HUFdfYIhhtzro7GdGnHhCyWzkCkfh/3nHL/7SSZkrIXCle3uOUEh98RzF3+oqmKfNq1R4Ip4ECkcaDcDVPh0kpNASRrSPtzHzrc/2NxIY87pTqXhqE5tB622NYgt5xiUGOHGQUPFzFCHObSEHvDWAHD/pk/91qLe1trXOa5vvb45IgycD+wH7Re9LHiZKlJqEoqcvhUKeeVs5iFCNljqPf6wBlCk9V6JP6JTvbLUZT+zN4fGymDKGDg6NaYYG89bCjy7IKqaaH9jEUok11ZncF81d56K9aGOqEn3/S2xhDbKSQF14UcapNfj9wfTbp8RKSoEzCJhFdZPoHkkaJrPcrHznJ22OuMbLPCdcrz9A96stw2C1kDOUvzzIrDDskQsRWFVlCXlLjA2JD1brYTX024f5Rp4V0/wXauwOfLLNlxoOb3IS9KXHHNXk56AzZ/LvD+Pj+ZMsCcL28hnEX1P+9a2Sjmbwx1qghP2rTX13wM8yu5Z/4YjsjxqS8ICYEAsYX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(3023799007)(11063799006)(56012099006)(5023799004)(6133799003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3AtEuVUfBNk3mW4QOObCKraB0q7CQT153sfT36Jk/HRWQ7gWgLTBXTTHQnVt?=
 =?us-ascii?Q?4fOIEkwkDFMCz4XIfWSY2JbbHKaEz9UlAQSp2S6qcxy+Y9LzVlx1L3jBmv4l?=
 =?us-ascii?Q?PG51Fk0+Qnn+OBjozOxdTbAWEn1F1Mlujjl+7ljPTJBKu+A/4BVqCw8bkCGH?=
 =?us-ascii?Q?ti5MxSusG38GLedTNYCRkbYiGvkOKVW4KBD3mUpVmTEQ32w8z41JlM1ymW9u?=
 =?us-ascii?Q?Kl8MH6X2X0sLmZwYNbxCM2xJBI8bwuiQxtnG/IlOxJLyni/Fj/VhqOJoH8gu?=
 =?us-ascii?Q?/uiyGybvOgNGdyfVsvEDXbAirAfP1m9sNqvCVHb7pxsuq6pcD1tH8QipvUVB?=
 =?us-ascii?Q?Z8+6bvavcsYf1+f6jC3DFxx9zr5qukr3/+cu/+iKPG9IEc+bKEUS7IICgSUP?=
 =?us-ascii?Q?6C38PsJkqcVJ6FgxN6gVak341TlWrNxmv44DaiLAU/eBj3oKWjLGBUhtjV8P?=
 =?us-ascii?Q?xv81qsG7+MD8gQ8rJUAf1piPG8LAFcZn5IxtBLFUSlVIkP0/71SDpU77ZCdJ?=
 =?us-ascii?Q?VV0sWzh02pRhfW5TUUSERR5xVXpkgO8RsYq9+tTqaRg+QBfE4N5xmden6URC?=
 =?us-ascii?Q?wSvfeNTFRqwDsmecT4PbHuJIhlM4Zr7akrEMwoYtAOatFqHpLpZibkRqwO91?=
 =?us-ascii?Q?REpjC/uBmAImrxhXc7h1VH6fKV2C/6V9ZBooFWLUjv9t311rA4JyDYhgeb5i?=
 =?us-ascii?Q?8J3+o3lNRTPRtbtHsYi8u8of2kOtUkYPCN7nceV8y4RxVbEKE8UfsyXitavj?=
 =?us-ascii?Q?jMUmVDRv7poEPty2AY1S708zaLj6gFr0nCVJk3bE21aWDWKroP9v7QQic4uy?=
 =?us-ascii?Q?3nz0dRcBCagAQXBTvRoNpiS1TkdEWXuXgqo4m08tYwNTeWw6GjYLsarGzcB+?=
 =?us-ascii?Q?zw0CBXr2bM1RjjP06U0czx6SDhGjkzzZWQayZb1kSluBDRwhIYVqRGnC05md?=
 =?us-ascii?Q?H2JNfz++K5SbAkOApc3/7GYq1If/59exWhYJdV12FCwh4aeofGFiKW5IIWmZ?=
 =?us-ascii?Q?BI3VfO5rYcHDlLkiay73i0dz+an6QosTr337hnOzcYH899XImWpdYo2m2zvB?=
 =?us-ascii?Q?C6GLzaYjWSYX0azzkTrKvVcdUdNxWCjLLdCj01LJ67aQ66gT34SGxTBibOX9?=
 =?us-ascii?Q?9esul1+UBYY23gzPzG90kbGhGREn0cWsOMR2twA3R3FUc/JKlza3iSH2biXg?=
 =?us-ascii?Q?yBA6H2oTufZDht+QAKJ6zSEbBJrjPp+7lNXHRf2icO5kZ3GRmgK0SV6cINcV?=
 =?us-ascii?Q?oYvxMhKPJJo6e7tlckpbfGDKBTVH7kOTa/aywruDy3QBdOMlJQDeN9AANLl0?=
 =?us-ascii?Q?IdR5SgpyqbPjNp1V8ofBPGYE8RUtT/OlVXPE9S9BqQVVLgrAo5MIiE1jvikV?=
 =?us-ascii?Q?rfdCzZDXh3JoExlFsgu/n5MfJAYlZCB32E1oTmVMteLKwyeK774er1b8b41B?=
 =?us-ascii?Q?d3GxiTzdfWZeeMGOo/gNMlNLN2vKKT0lACjcEAw7mYO2wK+IORji+OI4AUBg?=
 =?us-ascii?Q?HVygTlZ9FPkDf2pRLShts8HS0lnvELZzLG1y5tk8llE6yXgEQPuSjEt5BNmh?=
 =?us-ascii?Q?CA9S7nW9ozeO7W44Jw3VFQlKhy8OC84oS9yd/SoU01zE0Fxv/PWMx6IqvV7S?=
 =?us-ascii?Q?T4CNjQjYcMQoXhTK8cxOkg/iNq0NgNedK1PrcgOp3Yzgh+oQdsIgkSEl2sjO?=
 =?us-ascii?Q?8BCeJ9NbmpXFm59LFUnnSwbAK5NdGrUgrCqzzKqL59D4qbzS7KvnVCqJFH4V?=
 =?us-ascii?Q?BMWBBFdUzg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a48354-edc5-4066-fcd6-08dec2d4c0ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 07:33:35.8643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YMYta4DuLOVLGndOWdlNV3c0SiVl4zkyiRsTyPP//CpFzqfYeYOoSOVXXgiA0UmHkp1FhqNJ9QY9aXY3LHGkPDEsXl6p2mjM8XonWET7el4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P189MB2912
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dominik.czarnota@trailofbits.com,m:horms@kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295703-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[est.tech];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[est.tech:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A93156460A9

>Subject: [PATCH net] tipc: require admin privileges for TIPCv2 mutators
>
>TIPCv2 registers its generic-netlink mutating commands without permission
>flags. Generic netlink only checks CAP_NET_ADMIN when an operation carries
>GENL_ADMIN_PERM or GENL_UNS_ADMIN_PERM, so callers without
>CAP_NET_ADMIN can invoke these setters.
>
>This allows an unprivileged caller to change TIPC control-plane state, inc=
luding
>bearer, link, network, monitor, peer and crypto-key state.
>TIPC_NL_MEDIA_SET is broader because it updates the shared media defaults
>returned by tipc_media_find(), including UDP MTU, priority, tolerance and
>window values, which can affect later bearer setup.
>
>Require CAP_NET_ADMIN for all TIPCv2 mutators. Use
>GENL_UNS_ADMIN_PERM for network-namespace scoped state, matching the
>legacy compat path and normal netns administration semantics. Use
>GENL_ADMIN_PERM for TIPC_NL_MEDIA_SET because it mutates global media
>defaults rather than state owned only by the target net namespace.

A similar patch has been submitted using the same AI:
https://patchwork.kernel.org/project/netdevbpf/patch/20260602133555.769727-=
2-michael.bommarito@gmail.com/

Your patch suggests using GENL_ADMIN_PERM while above patch does not.
Did AI suggest using GENL_ADMIN_PERM or you suggested it yourself ?

>
>Fixes: 0655f6a8635b ("tipc: add bearer disable/enable to new netlink api")
>Assisted-by: Codex:gpt-5.5-cyber-preview
>Signed-off-by: Dominik 'Disconnect3d' Czarnota
><dominik.czarnota@trailofbits.com>
>---
> net/tipc/netlink.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>
>diff --git a/net/tipc/netlink.c b/net/tipc/netlink.c index
>1a9a5bdaccf4..5bbe134284ac 100644
>--- a/net/tipc/netlink.c
>+++ b/net/tipc/netlink.c
>@@ -152,11 +152,13 @@ static const struct genl_ops tipc_genl_v2_ops[] =3D =
{
> 	{
> 		.cmd	=3D TIPC_NL_BEARER_DISABLE,
> 		.validate =3D GENL_DONT_VALIDATE_STRICT |
>GENL_DONT_VALIDATE_DUMP,
>+		.flags	=3D GENL_UNS_ADMIN_PERM,
> 		.doit	=3D tipc_nl_bearer_disable,
> 	},
> 	{
> 		.cmd	=3D TIPC_NL_BEARER_ENABLE,
> 		.validate =3D GENL_DONT_VALIDATE_STRICT |
>GENL_DONT_VALIDATE_DUMP,
>+		.flags	=3D GENL_UNS_ADMIN_PERM,
> 		.doit	=3D tipc_nl_bearer_enable,
> 	},
> 	{
>@@ -168,11 +170,13 @@ static const struct genl_ops tipc_genl_v2_ops[] =3D =
{
> 	{
> 		.cmd	=3D TIPC_NL_BEARER_ADD,
> 		.validate =3D GENL_DONT_VALIDATE_STRICT |
>GENL_DONT_VALIDATE_DUMP,
>+		.flags	=3D GENL_UNS_ADMIN_PERM,
> 		.doit	=3D tipc_nl_bearer_add,
> 	},
> 	{
> 		.cmd	=3D TIPC_NL_BEARER_SET,
> 		.validate =3D GENL_DONT_VALIDATE_STRICT |
>GENL_DONT_VALIDATE_DUMP,
>+		.flags	=3D GENL_UNS_ADMIN_PERM,
> 		.doit	=3D tipc_nl_bearer_set,
> 	},
> 	{
>@@ -197,11 +201,13 @@ static const struct genl_ops tipc_genl_v2_ops[] =3D =
{
> 	{
> 		.cmd	=3D TIPC_NL_LINK_SET,
> 		.validate =3D GENL_DONT_VALIDATE_STRICT |
>GENL_DONT_VALIDATE_DUMP,
>+		.flags	=3D GENL_UNS_ADMIN_PERM,
> 		.doit	=3D tipc_nl_node_set_link,
> 	},
> 	{
> 		.cmd	=3D TIPC_NL_LINK_RESET_STATS,
> 		.validate =3D GENL_DONT_VALIDATE_STRICT |
>GENL_DONT_VALIDATE_DUMP,
>+		.flags	=3D GENL_UNS_ADMIN_PERM,
> 		.doit   =3D tipc_nl_node_reset_link_stats,
> 	},
> 	{
>@@ -213,6 +219,7 @@ static const struct genl_ops tipc_genl_v2_ops[] =3D {
> 	{
> 		.cmd	=3D TIPC_NL_MEDIA_SET,
> 		.validate =3D GENL_DONT_VALIDATE_STRICT |
>GENL_DONT_VALIDATE_DUMP,
>+		.flags	=3D GENL_ADMIN_PERM,
> 		.doit	=3D tipc_nl_media_set,
> 	},
> 	{
>@@ -228,6 +235,7 @@ static const struct genl_ops tipc_genl_v2_ops[] =3D {
> 	{
> 		.cmd	=3D TIPC_NL_NET_SET,
> 		.validate =3D GENL_DONT_VALIDATE_STRICT |
>GENL_DONT_VALIDATE_DUMP,
>+		.flags	=3D GENL_UNS_ADMIN_PERM,
> 		.doit	=3D tipc_nl_net_set,
> 	},
> 	{
>@@ -238,6 +246,7 @@ static const struct genl_ops tipc_genl_v2_ops[] =3D {
> 	{
> 		.cmd	=3D TIPC_NL_MON_SET,
> 		.validate =3D GENL_DONT_VALIDATE_STRICT |
>GENL_DONT_VALIDATE_DUMP,
>+		.flags	=3D GENL_UNS_ADMIN_PERM,
> 		.doit	=3D tipc_nl_node_set_monitor,
> 	},
> 	{
>@@ -255,6 +264,7 @@ static const struct genl_ops tipc_genl_v2_ops[] =3D {
> 	{
> 		.cmd	=3D TIPC_NL_PEER_REMOVE,
> 		.validate =3D GENL_DONT_VALIDATE_STRICT |
>GENL_DONT_VALIDATE_DUMP,
>+		.flags	=3D GENL_UNS_ADMIN_PERM,
> 		.doit	=3D tipc_nl_peer_rm,
> 	},
> #ifdef CONFIG_TIPC_MEDIA_UDP
>@@ -269,11 +279,13 @@ static const struct genl_ops tipc_genl_v2_ops[] =3D =
{
> 	{
> 		.cmd	=3D TIPC_NL_KEY_SET,
> 		.validate =3D GENL_DONT_VALIDATE_STRICT |
>GENL_DONT_VALIDATE_DUMP,
>+		.flags	=3D GENL_UNS_ADMIN_PERM,
> 		.doit	=3D tipc_nl_node_set_key,
> 	},
> 	{
> 		.cmd	=3D TIPC_NL_KEY_FLUSH,
> 		.validate =3D GENL_DONT_VALIDATE_STRICT |
>GENL_DONT_VALIDATE_DUMP,
>+		.flags	=3D GENL_UNS_ADMIN_PERM,
> 		.doit	=3D tipc_nl_node_flush_key,
> 	},
> #endif


