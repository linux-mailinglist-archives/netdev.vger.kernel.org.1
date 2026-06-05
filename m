Return-Path: <netdev+bounces-295486-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UXHlHfsTImoNSQEAu9opvQ
	(envelope-from <netdev+bounces-295486-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 02:10:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF63264416B
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 02:10:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=selector1 header.b=YXXOod04;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295486-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295486-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B0723036D69
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 00:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D9F26AF4;
	Fri,  5 Jun 2026 00:10:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011040.outbound.protection.outlook.com [40.93.194.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72DD171CD;
	Fri,  5 Jun 2026 00:10:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780618232; cv=fail; b=UZ8iJYDVoRV61bXeJfZTN6elmFhR2yCsvzjxtI8J8BH0KohFYpphCrKhQqPOad+8tP+o2CQaBNUZGeRco8DxE8R7ZV3NT/HuVBXrFpoljCO6XO0zAw/RWW5Qx0wacqMPRdfDdraMUCx7a8EdonzEGhCwMofJGk/DUxJhIerWims=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780618232; c=relaxed/simple;
	bh=S27Wka8jKDL/2144luXMZWzeuMo4C2ijTjcky3Kgo7I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t4K5gNQndADW/wrxdYwjs4rYmzIDoMKC7CMt1FQRMCeiM5k3Svxy3LpeVuZwMUZ8HmW2MtBi+8stGfM8v8PVP1rdRRsUJvXxUfdu1KARR8FrGWJf7Fm1JnpG++CAlhmWk/7vqW7h+Q2dQSt1pPPVnsLoJ1CFpeUspCh8PoVQ3ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YXXOod04; arc=fail smtp.client-ip=40.93.194.40
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itvIj/L6w/a6gdTEYm8EnSJerLM8LQ7qMsAqq9f64ytgeVzcXU7bEUDRCiAtXN/p/E4adGxvyFcQFb5XbPwpqeE+8ab7eUTYJezyaLjhx2Rh2YbRMoHV0w/qX6lITYC9SLO/Yh+ksNX3TUl911vpfY96g9uz90wubYXl5mw+p1fb9Rc62jMIQtPRIIdGqKUdmyP3Or3O0vSlFdJPPKM2axHQIS1QauA0M4I81wIbGHBBjDjVpjNh2vZMocWWzpshA8YbyFoWD86LWA7AIA3Ruovm3iHXGgRF726dTgPdiD12DmWujVzh1awA9e+xJbJeKEdso9L0QntkhmnhdCHwEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gd9Rw/rizQ1M1R5Oi3Jq4CdMw6HlwRibQMWpLTYJDg=;
 b=UqFWO3KryR2Zd9B5EF8NtL6yDm2mW2OYwQnrS2iwyog3zjRSrhJ0QpSpvipzM/bx9oSc7lUPGjMSe40acNi9FaNTyCRejqkSMxCVna5ulpvAh19Jbh69qCbtXjkBXk2fVRc5U39Wl2AlC1YxV3ab/WwPrxvql0hG7FOVLCkRpZPgjTYZoLgGOFUb3in4MQ+6pJ5rAJLDmT5hzzpY4al7mGR6a/OTykmQmHdUZdhZBsM2P3WHfMJLjBtA2js8Q7bJJ0zdScjO0tuUzqbAXMYGv18jvMXQSdtdZvtywdwl/lahJ0KBYblabzKhjB2kgl1BZDwY+ACwgefqPKYeEKnqBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gd9Rw/rizQ1M1R5Oi3Jq4CdMw6HlwRibQMWpLTYJDg=;
 b=YXXOod04Zefs/A1XJ+n052C3LAe0R0Ixx+4iLZsn6mAPNYPo9llnGJDTIxYMrGs4mAntjD8At7hnc9TK9jQBhN58gCbHnebwAGjLmf8T4gvwWB2PcasOkhFmLx2pkf+SZs2UkKgH6OZKdOFQ7DH4dkjcYOx+5+dIVM5N31CuXFQuAk6vVVFvAyYtCGPxqp3nt2EcOVAkYIBnZjX255BgxI1BCdlySuUxvy8IHck8EUDWqWC57aw1Vrbnl7+gXPaWHu7Gp4TtaIU0WYBzK6184Ljh9Ml24A9jI2FQ4yGxRBrvUZFtu0xSxRTx0JqbJktK/hTWXqE2V6awv1NiUBBcxg==
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by MW3PR11MB4635.namprd11.prod.outlook.com (2603:10b6:303:2c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 00:10:27 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::b351:6cda:caf7:64a]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::b351:6cda:caf7:64a%5]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 00:10:27 +0000
From: <Ronnie.Kunin@microchip.com>
To: <andrew@lunn.ch>, <Thangaraj.S@microchip.com>
CC: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<Bryan.Whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<linux@armlinux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/5] net: lan743x: read SFP straps from PCI11x1x device
Thread-Topic: [PATCH v4 2/5] net: lan743x: read SFP straps from PCI11x1x
 device
Thread-Index:
 AQHc44+Rl3nM2RNgTkS/7Cm+QBJFurYNeG6AgBQPwQCAAGixAIAHYpyAgABtTgCABWj4EA==
Date: Fri, 5 Jun 2026 00:10:26 +0000
Message-ID:
 <PH8PR11MB7965C207ECBC42946B4024E195112@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20260514105028.42942-1-thangaraj.s@microchip.com>
 <20260514105028.42942-3-thangaraj.s@microchip.com>
 <053eaadf-07f3-431f-a0a4-28980adb8213@lunn.ch>
 <DSWPR11MB971561B42BB157F7C8C436C2EC082@DSWPR11MB9715.namprd11.prod.outlook.com>
 <af49a018-952a-439a-8beb-2e300a1d266a@lunn.ch>
 <DSWPR11MB97156347E4D54CC898A1CA43EC152@DSWPR11MB9715.namprd11.prod.outlook.com>
 <e6ef6386-47e2-4a96-ad89-bcf018d794fe@lunn.ch>
In-Reply-To: <e6ef6386-47e2-4a96-ad89-bcf018d794fe@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|MW3PR11MB4635:EE_
x-ms-office365-filtering-correlation-id: 522da973-1385-41a0-f4b5-08dec296d8a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|18002099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info:
 IsbWK60m2tCHOxfAdQ994NUOzKOJI98PgulYgyHzSPyLUxXkyujy0F9tTzu1IwEcvjgJKwUVlaZUQH0m7PooGGGdfseNutXa8hbBQ6baQwBJx9ndwh5614pPtCBjPoPBEGJgGj76Hc87a3Xcawkyc0Vwg4cNuhydF9VzKEt+55M15XS9MQISsEOj5qTHVPZvDJlY0M3LkV1PUv78IiJPo0QQNDz1pOTsnjVPIjflyF9pt4Gl5ft1/lk+Axj6PSPHj9Hy7bbI7loZ0h0lzOhNdjXOQiOBd2wAsCDldEWkQeVXbP3zoTc5rX2K5uK0JGDG8e/ahAHJYtLXZ8KEXt69bsvTXKdDncClKPazREbT7wKEIuo7qk49enrBWPA8jt68kLKDJoQQiq86BT3Bi5yThP93U3vaQDDMAKlI4Clw36BM+SoAGzU9GY4p2DTxkRaV0trZbCaV+w8fno5e7k9P9eYf8YvdIdI8pwjkG480FNw6wdodWZsuaT7qRpXA6+Dxhdzdyw6kJ0p4N7kaZ5DeGqwdoPrZMGSp6xJ6/WII2UaotSHPTbvYA8iEOVDhuotkSFSXcHpmvkja1z1+jNblTsQWv+Tla/fxaYN2KbovQAFjUKQS5uk3xd8/U3yMbhVNCgdlae74BSpL7Utntz2JpEKoTK6w/THYUDieM1OHZIZwsTpXRY2iJxin/tL2pHBTpEUoBv5fPmAdnGFSBgn4RjbquicfRQ84xu1ccmC6x6wkBqwzFtwqCnaqpQppiRXk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YS4vo5NZN4fdwS3Cy09gNSpKflV5Dsx3RJZvIOSPFywLNmN7LR0v3fIx3BVq?=
 =?us-ascii?Q?JpByJCGIdNmfHwFgsXX9+CbI2jQTb6i6IPLwWeEjYjzDwml5f820Pm1LGKlj?=
 =?us-ascii?Q?1vD6JhurvQ2NaT8hFPLqI8yeu5A9H2mN5EMiqVN6+BN9AgRbj+AprrrOvBsv?=
 =?us-ascii?Q?q/WPmxB/8XkPhmEtK10za1WMCXL6rR4tVQY7wmPhh4GP7M+yeizRuGkehGwQ?=
 =?us-ascii?Q?ikDFfO1hGHR4ISyUDjWMOFg2N0W5VjSG/gS01IzOpzSxp3NpJ89zk3idHR8k?=
 =?us-ascii?Q?FLSaipqy4taTZrgg5wZDN3kCbESHA7hfnuYNE+8Yzw1EMAIxVdsDatOvTUWz?=
 =?us-ascii?Q?FgbK38IQPV+O+MSsLsqa7PMgipV6R6R+2qt3BWLrTzlLjphlYTwuF8sVEMep?=
 =?us-ascii?Q?NFJDwgfs2h8cox9IlHC8DgLuHy8SkHPES9t9iUv7JkkTavZHtjIpAjYzZsC2?=
 =?us-ascii?Q?WCw/pLP8tzCBIG/OFv6U4P7gFUJRp6Ks4G/N7H7ekVQ4RclfpYoqyOkRWf/N?=
 =?us-ascii?Q?H73FpOJyFX718yXyT+KYyrDtnXZuDPDzkHTqCE2FIWE3pRA16BJ6iDBnCDOs?=
 =?us-ascii?Q?D3c7gYHRGy8P8qs9tuYPpX06skPLp1KTc1qDASm9QJIZzt8cJCmWaeA2cDVB?=
 =?us-ascii?Q?GAbIr7Hg/hFxqgqtkPb6unGA97BRHDGuxPW/CSy9J9H4pmOt30QhEybrWSoG?=
 =?us-ascii?Q?nVEq1wWacuYmkIOsrckpBtjplN/ZUDaLOdQGkwRb09r+4JKOz4sgjviJEyJ7?=
 =?us-ascii?Q?lU4iCG+bbYOt8QyjhAEwq6Vmgupa3TRNNivr/7nbYpcuxEjNLBbWsGXjBDZq?=
 =?us-ascii?Q?/FZW3B8Sa4mhUTJD0BoLrZ5aTTcwPBjuG0HXTdhAjud3o0zticWZFEErcVal?=
 =?us-ascii?Q?hH/utCfDAQEgjPODRlLWstTNzTqj8pnx7MLinLNmm6zAYn6vpAWy5oFn9P5q?=
 =?us-ascii?Q?RfPhuNnH5NvnoZ/o77S18Vx91PNPZMq0IKFScbiIR82m/iQVYi6pR5oH5VIv?=
 =?us-ascii?Q?XvMwN+FaZEByfu6sMgZpU5QFVhx+95JtdbA8pO98ZDM4Mbk4uF0XK6fhkirl?=
 =?us-ascii?Q?0HvcxMGnNQxrxfm70ubxeTsXVyLA+jDZqqWuzipcv2LXWYpeIPaExcGX+DTX?=
 =?us-ascii?Q?CRU8+f3/yQ13qZtL2HUrMcEHnDHhUDoZ4STZzJNGmC1ewsJiZHPrTXn4vJJG?=
 =?us-ascii?Q?hfrg+ZkUQ4iFeYQmJohGWuy2EGSRI+9Hj5VVXDeC0C0VQlJRpBD5FjdORUJX?=
 =?us-ascii?Q?WJhP8sl+acgmB427h9kZlEyzl5rSAdG0t6c+0uLFHe2t75C/A9SXxFVN2Xgg?=
 =?us-ascii?Q?VNEIc4Y5QuR8nTYP6IZepnawKXhGtyrk+DcpbKc8igxiyxVZ+KJmL1zVhtox?=
 =?us-ascii?Q?qK6uwt33jm34NEsh+4zaWWFwsSSm9cMrDJXkn6rEcKl+DjS3wQvI57XNqepj?=
 =?us-ascii?Q?XRzRhfFz8Feq+Td4r+6LJ70TuXWBLMS7/YVBE+kiWp4+3K6tygKqRpsdLWNb?=
 =?us-ascii?Q?5SekeBjJZbkjOJZnxKTAm8XaOSJboGvcaxxQGHHWJJV6Lm1dmPUJgZWcFNTC?=
 =?us-ascii?Q?Y40f+Ift8sMw6PZOaRiz2yQB95VijMMXzBWE/Ub9yxk4/1nU9xD+55IBf3v6?=
 =?us-ascii?Q?CMjJVQGtHZti28X7qVgTJYqkD5tZNSti+lFHRtMn8a0+plfH6lkKDkltWFxe?=
 =?us-ascii?Q?7htDWmiHd94rLu46qG8R1pV0zIDqzYbqs99iD0YQSQc7GfEkIUJCm497O4PF?=
 =?us-ascii?Q?+d/eQEudKw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 522da973-1385-41a0-f4b5-08dec296d8a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 00:10:26.8065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: awDNtPkxwZm8QG/1gQqwY1vul+5isvRcdEM33jqXpPg+bYcoarPYWBEuAF4lC7UwYnysbuTCya4UBXmI2ydDXkiFajmy0Pqg/AS/6tmWM54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4635
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295486-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Ronnie.Kunin@microchip.com,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[Ronnie.Kunin@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:Thangaraj.S@microchip.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:Bryan.Whitehead@microchip.com,m:UNGLinuxDriver@microchip.com,m:linux@armlinux.org.uk,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF63264416B

Hi Andrew,=20
Thanks for your comments

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Monday, June 1, 2026 8:41 AM
> To: Thangaraj Samynathan - I53494 <Thangaraj.S@microchip.com>
> Cc: netdev@vger.kernel.org; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Bryan Whitehead - C21958
> <Bryan.Whitehead@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; linux@armlinux.org.uk; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v4 2/5] net: lan743x: read SFP straps from PCI11x1x
> device
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> > > In practice distributions turn on nearly everything. So the code is
> > > likely to be built. Rather than a Kconfig symbol, can you move the
> > > code into a module, which only gets loaded for pci11x1x?
> > [Thangaraj Samynathan] Thanks for the suggestion. We agree this is a
> reasonable direction.
> > For this series, CONFIG_LAN743X_SFP addresses the dependency concern.
> > For distro builds that enable most options, a separate module would
> > typically be built and loaded as well, so the practical result is the
> > same.
>=20
> Not necessarily. You have a strapping pin, which indicates if the hardwar=
e has
> been designed for SFP. Use that to load the kernel module with all the SF=
P
> code.

That is what we were originally doing: single driver, no conditional compil=
e, decide on SFP strap. But previous review recommendations to solve depend=
ency problems from Jakub took us towards adding conditional compile for the=
 SFP feature.

>=20
> Maybe also go talk to Marketing. What has this device been designed for a=
nd
> what applications is it marketed towards? >You talk about Intel drivers. =
They are
> used in servers and desktop machines. You generally don't worry too much
> about code size for those targets, there is a lot of RAM available. Howev=
er, if
> the target market is deeply embedded, RAM can be short.=20

The PCI11x1x is a general-purpose piece of silicon. It can (and based on ex=
perience with previous general-purpose devices we've made) will be used in =
all sort of designs and use cases ranging all the way from deeply embedded =
to industrial PC clients (onboard or thru PCIe adapters) or even servers (a=
lbeit on the management interfaces, I don't think this has been designed in=
 any server data plane so far). The device does not have an internal PHY an=
d typically our customers will select one phy and for their final product p=
ut it in the same board where the PCI11x1x is. So why did we make an evalua=
tion board with an SFP cage ? So that our customers can evaluate whatever P=
HY they want regardless of what their use case is.=20

> However, why
> would use pick an embedded SoC which does not have integrated Ethernet?
> Pretty much all embedded SoCs do.

We've certainly had many cases where even if there was integrated ethernet =
in their SoC of choice, they still wanted our ethernet device as well due t=
o features we have the integrated one did not.=20

>=20
> Make the architecture fit the use case.
>=20
>    Andrew

Going back to the original discussion about whether a kconfig option, as re=
commended by Jakub in his review, is acceptable. Beside the above explanati=
on on use cases which by itself may provide enough justification, I just to=
ok a quick peek and saw quite numerous kconfig bool options exist across ma=
ny other drivers enabling extra features like debugging interfaces, ptp sup=
port, special modes of operation of the hardware, etc. Looks to me like thi=
s bool SFP kconfig selection for LAN743x is along the same lines of those, =
so why would it not be a valid alternative for our driver?=20

Ronnie


