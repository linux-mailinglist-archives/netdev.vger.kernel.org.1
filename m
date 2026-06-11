Return-Path: <netdev+bounces-297967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fG/nL4JXKmrengMAu9opvQ
	(envelope-from <netdev+bounces-297967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:36:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D03666F0FE
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:36:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=rd8vKFXK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297967-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297967-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F869303B6C8
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 06:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ADF35F191;
	Thu, 11 Jun 2026 06:34:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013070.outbound.protection.outlook.com [52.101.83.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4043F35676A;
	Thu, 11 Jun 2026 06:34:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159658; cv=fail; b=SG1ojeBpcEHkXPIdAGqKDWmvX4AyS3TZBv3ZFAM5mNxzZk2acIjzrusBUL7zW/rAJEHx/tl6uByMx1oB3C3NS5d1Y/aJSn6AFgVsG7h1/CC4OymRRMZLJeTZSq39UlVvUCxHkxTZ6x28EtagziFB+NpkM3xi4KbrWaOXXPjFE+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159658; c=relaxed/simple;
	bh=/1f7RFgPU73QG6qeAxnQLEl6qn1I0kEg1Rhv8Vq3qMw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n/XGBBPnZHiqm3vKAxZ1HUJHQHtvrEnI6S9bP2fybK2yeO2tfX52vt6zSfSW6pYnLsGf9yFSucQ54FHmS4N2cvn9fP4VXt4wfHw9INPaAL+Y3ff22GkkJDAA62xRZBmfj5/KypTHwbp378IXtjgYwFfd63Ep6bYm46eQ/3hEc10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=rd8vKFXK; arc=fail smtp.client-ip=52.101.83.70
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWwj2zlRFL07Yz5pHE/NOZWK4dGZVesjaeWPgyPmWpsqwehLLUbgE8uDdXGLeGe1GAjzRRHbuvFypAha0rcrYUROgmDGVAhfGEIwLDiBKCwQDm185wxAjjlESr+lEaA68p3oGzb5940FB6W1uGD9SHLEpNaIzZvCmIfcNhqvQAKqd9Ptn21Dl6CQ21a9oamCHU9KwGwUHSOSArW5GJbjS14jmGA9xOr3vkSBXT73BUwKk9g1qgWlUV9bHOtONn5S1BKydMXzAOVDqtnSZu/loZkqreYhlU5Cg85VddPm+6h+hfO5+KXsSZ9lzsATbyNMswMi58hFotqrz0s8JgiaiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reTI0uzOzA//x4mvPcCdFJxMrbFzzBdJzRuu3yiBia8=;
 b=OeuItEkeJaXeoWhevSNSLpTaGDBnsDER8iUhrGvzaOMxcxT176EK/YwXWCXYKkypBVCixYHjzTJa4niV4IRPvZVAbQwyrJnxIfyEQHOciY6O5nlzssbirv2GdSUohCNcyLcvvoL69ce/Wqx2mt3gbkmyKkgOadE/T1PFapzc1endOZSFJmtaMTLcalrcvPvhvaqHUV9SVTpahSKfPwinXjxXKG1M0e3+I0DWigQROHvaKXGC+mC/207y7mWmWZBMfedrLlgeCev+YwwYz5pPO4FqeRflXcrnpfYI84Q3C6fVkyK8udtS3yQaW0gpoE034+PdfnY6vwAHz1/Aet5KhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reTI0uzOzA//x4mvPcCdFJxMrbFzzBdJzRuu3yiBia8=;
 b=rd8vKFXKZYS4YQrXQwbQw7Ci1LDf5HvV1Xm9qhn3KFCQZ20iFNED9kPKjeEFX6GXrYZnEJ3EgyI5khQUETZOZ0wdxNu93bvZRm4Y9y85gk8BpRxOYlCff19yLy77A57sJ+YIyqyadlvpw8jK1asqEpeoAFZgwePfAPy5H+7HE8f46rmVzGyn1iY/odJnmv2RSXSPoQIxRZH60PCFiEimLeqHQQY2eaXs2Vd0NMYq0ShEPq/sKK7C4au1i/3f1hwWlTrAeFb2Yiqtb+DgVUXbntCDJi4e1CnSuj22bfXW9T/z2/I9XG3nhriAWegu6TuBMnA8qkKg1z9TFAqEQrmwSA==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 PAWP189MB2592.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:362::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.11; Thu, 11 Jun 2026 06:34:12 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 06:34:11 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Doruk Tan Ozturk <doruk@0sec.ai>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>
Subject: RE: [PATCH net v2] tipc: fix slab-use-after-free Read in
 tipc_aead_decrypt_done
Thread-Topic: [PATCH net v2] tipc: fix slab-use-after-free Read in
 tipc_aead_decrypt_done
Thread-Index: AQHc+RTOyMkQg45BZ0atzvBgrVOC7rY45MwA
Date: Thu, 11 Jun 2026 06:34:11 +0000
Message-ID:
 <GV1P189MB1988B2B662DC781F7347EBD4C61B2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260610200332.33960-1-doruk@0sec.ai>
In-Reply-To: <20260610200332.33960-1-doruk@0sec.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|PAWP189MB2592:EE_
x-ms-office365-filtering-correlation-id: a06a32e9-ddfd-4d2f-5393-08dec78372e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|38070700021|22082099003|18002099003|83080400003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 zCfq2zgUjm0EgZaI8L33QkHMPRQTkKdfqhc9YEr0u7pL1qmoNrBqQaI3W0qCwEY4ZlYXDNxDDNNx8/VWsPM48qPIWEaGDJWbvJrEZR6w6PXc/xabMLUOyMYIhBTJWiTyTu1Qm08Za/7qJrLFJNTqb9EiEV6hMKMeMFGlC5stAEvLPZQVCNjPTBYdNC352cM1sV7SwWWWr+7NU3i9NF+F642qCCOrsk6/RIc5k93FnN3h2THbbpRpsxUtBPKv1QJRVwEHdVvi/jv47sool9mJJ/ht8iErVZdZcWy4jVvpEntathucVqklj7hJJRmhz9SCisJpL1WK+YsqlWxG4KlyQwGuG3LgASqNhAgnHl1XJgaTzau4TFHSb0dBzGqP7uZmqw5cTst1GvWuO7PbUI4XZ2QrSFvUtOyd2+AEc6HwXKT0j0kyf3R4jn+Sc98f9HZbFB79aOe3TUIk/wrVReNhiVVBCfGdMvq43ZRT21jEVTyr7vIt/guJrB+lw1tPHN+L5/JOEnfAVMF8lPn5uD7GHAcaaP0cmnjiF0/1AZq1Czp/wpDVV51fTlMIOw6qjbLF73QUTlN5omzEjE9YEdvfiVeuF8EZmnDsXSG4Pd2CjIZlhWxj2mjYavbVduGsqDMfiaNqSf4jg972L+bN7b0TnLGwsgdaXFNTUq+4d427FYydfIfI1TZNf3nEPSAe21+ENwQcdg9cM6kqOxDz+YQ/mn8/mu50QHVksznT3foPo0k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(38070700021)(22082099003)(18002099003)(83080400003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Tlyw5uOZu+NcijA91Q0DaTIujC4irfYLDYu14gmHLHvPAyGx7aq20z4fkmbP?=
 =?us-ascii?Q?av1PKNP2VfktBmvwsc7uIYFaxpaG+HfHRGiN8vjb9cOXn7ORQ2XxhbXCT4tB?=
 =?us-ascii?Q?KDbgjTd4v4Y0kmmLU00j92AzTdqRy1DVwqI7oQzKTy7BcizpADz0goM+toCV?=
 =?us-ascii?Q?zxEjwGoIVKXWwHOp1Ew2vH6YdPK4jpfRyBqRCsMs4KHSpxRpnI9XWlkW50h4?=
 =?us-ascii?Q?zIyYvtXR1EjGKBV6wdrcqkHICxYQIrdFx+TDJw8Q4AGLZsTirP6ObmgPG7qF?=
 =?us-ascii?Q?euMazhH1ggm9mahCkhJ3yHh4XE4M0e5BhliY0urwyW9KzBxzMbQvSWCFZQTi?=
 =?us-ascii?Q?EMJIk49aaVJpfLsMau66QeaeYKBdSZznx4d4Smi7AgxubK1TC42pAg7LoFYi?=
 =?us-ascii?Q?AQOmHkfDuZ81fvHKDdeyTjClkV5MFqcN9Ei5B/P5v3fiS0bwJgZEdDZeJie1?=
 =?us-ascii?Q?rdxR6t718vGJ1CD/ADS3/zmfaspIgQRpTlYhPUjz4dQxkVgs3sUtc0bSW+BU?=
 =?us-ascii?Q?7tnMGm23IuhVjlpz6kfKPRkSYgBX3gWZC3mZAGz/2WH/HUv26jLjDDGp/x0q?=
 =?us-ascii?Q?MzxEOf9VweapRCUwWsUkfrCAgbtGjpY35ZIpZ2Q+xuIDEXVeikdYBAHIiHqM?=
 =?us-ascii?Q?nUbnlzEqDuno6EBX/6bHE9CcEUJI0O8mQysHnFRVmt69GYpP+dWgcMVMAvD1?=
 =?us-ascii?Q?xoARQI+Igw4j5aeZm8bo0xH0LX8A6/kn3LBbXjg13lCWE4DebcZMrDHhSAoF?=
 =?us-ascii?Q?T2LwEjLFjFGkFGKhvFeRiKmPoQ/F37v5Gu2jX6NfLBNStQd7TSNSVxpiCiXt?=
 =?us-ascii?Q?UhcaStNUmHzYr+zK77LLAqUNeeJTkqKiibbZSb9kiKwmbJjVSwcaz4XjZuyJ?=
 =?us-ascii?Q?NN/8ipeMjY71JPYVTr7tz9/bYAiUFfPL8zWUGSIEU4hhEUeqrBL0t4g9Ml+A?=
 =?us-ascii?Q?7uzfbTdV3O1E1b5niTzg16XjAo8VZuWMJ8kASG1X3p8z1+67uSVFJEpOx42l?=
 =?us-ascii?Q?UpuMH9arvU+pXKlGk/RYM86TTQ90qZ9o++S1itTY52vwJu6e2aOUQRtuUZWu?=
 =?us-ascii?Q?zxxITyncJA93zJu838eA8XlLlJaayFG/ld7Z/8/TS4ZU9iKjakjK/d982Xr2?=
 =?us-ascii?Q?UcCOpIA9ZPNLbO84jMX9Dqk/vj5WKZ5Ur62f4y1baLLL9OYkeOO2J1G3w4e0?=
 =?us-ascii?Q?suabW1/Ptl4ks7oG6FE4jJfZMFJlf1fjc4jPgJcsu9N4Os1MDDDtUczx5UYz?=
 =?us-ascii?Q?VTF9De0c/1vp7t6Ed+KbYkqmCGNbu2i01s+Zh6I9LU/5qiPkAG/Pisi9BCLQ?=
 =?us-ascii?Q?jDt9nXtrD7Ru/DoXjMLzcPuEmCgqU4zbslFR6d5OYBLWeh0yF/z9FAGBJYZb?=
 =?us-ascii?Q?ONLuOxU5Q2J69f/yTbdvTfGDg/ZNxNBWWAe7rFNcrGD2pZAf3sukRZyHJ6z8?=
 =?us-ascii?Q?Ld6f8dOLqupsBR+bJRJ0vDLN25Af4WSEU+C0NT4FIMqmfPy1tu1PoVEvVLe1?=
 =?us-ascii?Q?TerEJY5p8jiHdh4xu3Lmm/cT0YJ1ibQpmVpLkZ0aVKg+7/+EL2nJ7fYP0aZ2?=
 =?us-ascii?Q?OFngw8kH53MFaKiJRzv+VOW66YvRDBD3dWyLSDGE8GpcSHdj2ZKrMZqlD2Mw?=
 =?us-ascii?Q?TfT2/m1TeI1MlciblSY5Y/330Pc7za1TUJGYSbT++e0Y5GpNYr92AVp1PZsO?=
 =?us-ascii?Q?XDzaIeE1PWbXWHO47/2NxdKS9h03GIRfzadDIr0roYzPYRc3jVpkmSShXLmY?=
 =?us-ascii?Q?5TLfNPaNhg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a06a32e9-ddfd-4d2f-5393-08dec78372e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 06:34:11.5328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZkP2VJlQMEzeHX5Ts5lKH/FWXv2qznWqlM9l3rHVVRd+7rEy4fITCQo7XXKZcijKaca8UTg53anlRW0LDblA0mvVkG2Whg8CIQ0nmesGhTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWP189MB2592
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[est.tech];
	TAGGED_FROM(0.00)[bounces-297967-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:doruk@0sec.ai,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:jmaloy@redhat.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[est.tech:dkim,est.tech:from_mime,intel.com:email,0sec.ai:url,0sec.ai:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D03666F0FE



>-----Original Message-----
>From: Doruk Tan Ozturk <doruk@0sec.ai>
>Subject: [PATCH net v2] tipc: fix slab-use-after-free Read in
>tipc_aead_decrypt_done
>
>The async decrypt completion path mirrors the encrypt one but is missing t=
he
>net reference that guards against the tipc_crypto being freed during netns
>teardown.
>
>When crypto_aead_decrypt() is offloaded to cryptd (the SIMD aead wrapper
>queues the request when crypto_simd_usable() is false), the cryptd worker
>runs tipc_aead_decrypt_done() asynchronously. If the bearer's netns is tor=
n
>down in the meantime, tipc_exit_net() -> tipc_crypto_stop() frees the
>tipc_crypto, and the completion then reads it: tipc_aead_decrypt_done()
>dereferences aead->crypto->stats and aead->crypto->net, and
>tipc_crypto_rcv_complete() dereferences aead->crypto->aead[] and the node
>table, reading freed memory:
>
>  BUG: KASAN: slab-use-after-free in tipc_crypto_rcv_complete
>  Read of size 8 at addr ffff888104c8c808 by task kworker/3:2/70
>  Workqueue: cryptd cryptd_queue_worker
>  Call Trace:
>   tipc_crypto_rcv_complete+0x1dd6/0x2240
>   tipc_aead_decrypt_done+0x1c3/0x300
>   cryptd_aead_crypt+0x3ae/0x660
>   cryptd_queue_worker+0x12b/0x200
>   process_one_work+0x66c/0x10c0
>   worker_thread+0x55d/0xc80
>   kthread+0x269/0x340
>  Allocated by task 1550:
>   tipc_crypto_start+0x7e/0x890
>   tipc_init_net+0x30d/0x480
>   ...
>  Freed by task 116:
>   tipc_crypto_stop+0x1a4/0x2a0
>   tipc_exit_net+0x11c/0x1c0
>   cleanup_net+0x510/0xaf0
>

Can you decode above stack trace (using linux/scripts/decode_stacktrace.sh)=
 for more readable text ?

>This is the same class of bug that commit e279024617134 ("net/tipc: fix sl=
ab-
>use-after-free Read in tipc_aead_encrypt_done") fixed for the encrypt side=
.
>The encrypt path takes maybe_get_net(aead->crypto->net) before
>crypto_aead_encrypt() and drops it with put_net() on the synchronous retur=
n
>paths and in tipc_aead_encrypt_done(); the -EINPROGRESS /-EBUSY return
>keeps the reference for the async callback to release. The decrypt path wa=
s left
>without the equivalent guard.
>
>Mirror the encrypt-side fix on the decrypt path: take a net reference befo=
re
>crypto_aead_decrypt() (failing with -ENODEV and the matching bearer put if=
 it
>cannot be acquired), keep it across the -EINPROGRESS/ -EBUSY async return,
>and drop it with put_net() on the synchronous success/error return and at =
the
>end of tipc_aead_decrypt_done().
>
>Reproduced under KASAN on v6.12.92: a UDP bearer with a cluster key is

Is the issue reproducible on latest net branch or just on the old v6.12.92 =
as you mentioned ?

>flooded with encrypted frames from an unknown peer (driving the cluster- k=
ey
>decrypt path) while the bearer's netns is repeatedly torn down. The SIMD a=
ead
>must be forced onto its cryptd async child for the completion to outlive
>tipc_crypto_stop(); with the patch applied the same workload runs cleanly.
>Found by 0sec automated security-research tooling while auditing the sibli=
ngs
>of commit e279024617134.
>
>Found by 0sec automated security-research tooling (https://0sec.ai).
>
>Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
>Cc: stable@vger.kernel.org
>Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
>Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>---
>v2:
> - Add Cc: stable@vger.kernel.org and Alexander Lobakin's Reviewed-by
>   (per his review of v1). No functional change.
>
> net/tipc/crypto.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
>diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c index
>6d3b6b89b1d1..84a6489da036 100644
>--- a/net/tipc/crypto.c
>+++ b/net/tipc/crypto.c
>@@ -941,12 +941,20 @@ static int tipc_aead_decrypt(struct net *net, struct
>tipc_aead *aead,
> 		goto exit;
> 	}
>
>+	/* Get net to avoid freed tipc_crypto when delete namespace */
>+	if (!maybe_get_net(aead->crypto->net)) {
>+		tipc_bearer_put(b);
>+		rc =3D -ENODEV;
>+		goto exit;
>+	}
>+
> 	/* Now, do decrypt */
> 	rc =3D crypto_aead_decrypt(req);
> 	if (rc =3D=3D -EINPROGRESS || rc =3D=3D -EBUSY)
> 		return rc;
>
> 	tipc_bearer_put(b);
>+	put_net(aead->crypto->net);
>
> exit:
> 	kfree(ctx);
>@@ -984,6 +992,7 @@ static void tipc_aead_decrypt_done(void *data, int err=
)
> 	}
>
> 	tipc_bearer_put(b);
>+	put_net(net);
> }
>
> static inline int tipc_ehdr_size(struct tipc_ehdr *ehdr)
>--
>2.43.0
>


