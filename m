Return-Path: <netdev+bounces-299311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xmAgA1p9L2q6BQUAu9opvQ
	(envelope-from <netdev+bounces-299311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 06:19:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8428C6833AE
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 06:19:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=selector1 header.b=Jj62fcOR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299311-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299311-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8B9B3001FEF
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 04:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601082E764D;
	Mon, 15 Jun 2026 04:19:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012039.outbound.protection.outlook.com [52.101.43.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D51262A6;
	Mon, 15 Jun 2026 04:19:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781497176; cv=fail; b=tODe4497SrUk1OoKIkEx0N+H8AR9u03WjyCPYorTj5OiFoOqs2WuWptZZkqs1SXQHOQCPnHcpsrQYMU5BAapEEElgcKp3bT9jstdjq1IzmPMQaOVcixY2PKZQJpXBsqdAP8+9XqYPlzCsZ56WulclAX2MR0R2jXVDUlsVbCz2ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781497176; c=relaxed/simple;
	bh=bK4zIMPPdgOT1UQ8GBYwRb567+bBq6JOeohzm9HSVd4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BfIz5Rerp47cKKPnM64CPHRkVGdWn+HzFmaa/ILy68F9+C2hSVWIeAi9bq6KPIT7IrcCQQlltyXheRI7SNEwcRYxpNNNy+ANuBl97x0CmRHAm2pnpm3o7XIH0yU/Qnt30R+z0C6Fo60+z9vcG0ai8UhW6YJj1/Np0kHq1MwkY50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Jj62fcOR; arc=fail smtp.client-ip=52.101.43.39
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iAqbpMXWmBfZRGUwGIflkXsxUfW1g8NAeJARwnNJCcKHp9i8CrTl7ElFRjnoXgCxEtDuj2JxmCenVN//Ff/h4qw0wsTm3rqWoYedlWd7Jwwpgwu5cBFHoD8GWhccr9RMu81Lm1hfRvNkAeQd3zgvH2SyyrsWKbUTJv99xpR1MrfhMOFbUhgDietNWeYyNlLj9kdDmY3CeFpZK8tLbwoWjzeBK57lCG2NCVUfQYmwdhEDXt6I7QPt/lfO4n+Woqtms1ZeBmpxeGt2s/mUYthhAAO/PwZ5X8K9nZaovelzrR3HBQ1MhIu+jjpITVeWW0yzHqaAiZ3kCS0qvxg3xHwZBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6MKA5XFkNhc6q8l1Ql8ABfQ8bs1ogMnuNJP8RNI3sc=;
 b=AEFRhJxXCTR4rc6PC5yNGy6zOFg6U71lUMX+QmBi+hQ0euxS2Q6kQK0LX6JNcxMzWOaaxSWUj07OXs6RAoDOP62AeB1HoSTxu2XSQnqBaX66xNr8ois+KFcZFpYji8ZT+w5ZzaZ3fPjrIiIJHqTMcx7gWXsigfkyvc36NO9e6uyVWgEEpm5l2RZnctRUj0hIU/1VcLl4TSZ1wHMrGN2yT9K2I+TX1toWjf3S+OG9yiR365e/FE0p0Djyy1QL0GttCfc/1wte9EVOKm3fASSdwfixu6SdwXYRCbyjnQeNWekTCOjGVZOx9Cjm2UrAFa8YMo2vb2+6WHcVvq4ucHxkBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6MKA5XFkNhc6q8l1Ql8ABfQ8bs1ogMnuNJP8RNI3sc=;
 b=Jj62fcORYFQfh42EhQUV/NcdVGWJHNdXLiZiuT2S/+xE0kN5usnmP4HzdLph+94TLZwIk9RWvJlZ80pSDPFXcobPPi0XGDmw4xY3++DzCjzu68YJKcheNVDLVwl+TDNZmijrXDAKOVfBJjv+Akkfv3v5FjvTqIvEI03hJRjjT36fpt6xx+BPjfF8sSuzLeYHC/JVXTjgCspg4XayBcuBsRdumk/+BmZHMWhvEFIdUmrWfIg4E1RFAkV4nIGtyV01VaYo3znpNBsvRt4cCaVtjhjsS6iHaTuk/Js+KNH8oJmtMmODANhUAnidlsHFKAxNADtXShjv5J6VB6bCQCpxxw==
Received: from DSWPR11MB9715.namprd11.prod.outlook.com (2603:10b6:8:355::17)
 by DSWPR11MB9715.namprd11.prod.outlook.com (2603:10b6:8:355::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 04:19:33 +0000
Received: from DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139]) by DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 04:19:32 +0000
From: <Thangaraj.S@microchip.com>
To: <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <Bryan.Whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v3 1/2] net: lan743x: add RMII strap status
 detection for PCI11x1x
Thread-Topic: [PATCH net-next v3 1/2] net: lan743x: add RMII strap status
 detection for PCI11x1x
Thread-Index: AQHc9y5VKw1WPwWBfk+QD1te2Z63brY3/QoAgAcPRKA=
Date: Mon, 15 Jun 2026 04:19:32 +0000
Message-ID:
 <DSWPR11MB9715A868735D547BEE29C477ECE62@DSWPR11MB9715.namprd11.prod.outlook.com>
References: <20260608100435.11214-2-thangaraj.s@microchip.com>
 <20260610162507.466793-3-horms@kernel.org>
In-Reply-To: <20260610162507.466793-3-horms@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSWPR11MB9715:EE_
x-ms-office365-filtering-correlation-id: 3f12a4a1-26f5-400d-6c5e-08deca954d51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|5023799004|4143699003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 732ggkvRLYnktTDCZwIfnxTvd7tZXM2r26aizoT1EVJk2EmS+dbW97cbIgo2yTiVNxpvCOkg0xg1GdX7a6Gwbej+tLCXeYxsirTxfJ9aufGvyFd8h4aTTOGrXBYu96O2CWFuetqHJzXG+jYR7XEs4WHqimwL5ZZEGVMhQEsC3LTUQgW55A7dRxgj94I1w8xP+klH1X5yZoj4n3z78HtmzNCjwZXENoF/LunmVa/xHydZRUYZFTUK9cWzlS+hm1crrXxjkC5DmN/bKeGZlrAoSnl1gUjq+8+MyDC4XMp58uq9UVfs3qTWbsEgO5ik/iKDrOSaxczPcgB4Tlp8UZBUa8LzGd2uFZk2NsGv+8B9pBqVE2rd8o15pPwlHSEyGfQsZOOJJf2MrgOVGL0Stq1Vtx0dQnn+BvU/1VaGxJBVvgTd298EjXJGLeofW4V+6pqBSXP/ZMT6di+jHfM+5iUORX4nrnPmN4Vyrbl1Iscl398uPM1G0R+750uDuU22Bk/oHBCa4fnyGNbCr4kfuTG3LF0hgnLLCvukmDIz6xej46zlKnFuKR94rgLK8LxZBKta92Kinamzi/gIkZLPp9Mke3AzkDHHzeQf19LzuLhIWYNvISsUrWQTgbGc3TmL2TX1LHkDaFsaeaC1rLoullkNuQ9LZj+YW4QiyIYAyak/7zYooTZ4bjTtdOzri8cIJBQKvjU3El+gcZzqI3qGHl9sAg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSWPR11MB9715.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(5023799004)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aXhD+xWMTIUEZqJ0B1LdmQ8Luoyg0l9+z65IEv8ii6NTt2EostGVORjUnznT?=
 =?us-ascii?Q?SAm4zJnbgAsxj1cGnzhfo+IfHuYwAdYeZuTK4icSU31fZnbz5jOdiJvvkjgU?=
 =?us-ascii?Q?l+KnAAyKiLdOaGMEKEas+YQ5uDVBy12MMTyitAUnVDxzlRjOJ7Rr35riGSyk?=
 =?us-ascii?Q?WSE0Pxr58Bd30VIt5+S5PZXMU1GlwY/uifuURH0PMFk4IKRYHID2eGAZnbzG?=
 =?us-ascii?Q?elqNuK61DIsKvWUR4HcVNVobSe9sXM6qZuK4F5NbLzw+opyPKc2o2Vu9gjgm?=
 =?us-ascii?Q?dp4O7QJz7LxQX81FNFvlvN85OYvHR5y2VTuBnnNuixDuyL2r5djgX4KbZaBw?=
 =?us-ascii?Q?ac5ZQNiD2iKmD3r01Uq3UKuOSlMkwvMq4SJr5HcxiJU4pN3ZtkSkDRMbp2U0?=
 =?us-ascii?Q?YKaxKGe6mZBV71bOSq+YmnECD/YvElczIGFkx7a4kcgPPBzKcHwI7ru+hofI?=
 =?us-ascii?Q?X/eoirOMLjfdOaD9aajwcRffImf29p1UkxXXA40Eyn1FmGS9kF4j26vwVGt7?=
 =?us-ascii?Q?tQZhETTFv+ySwqRrcsTgLVD9MBabBI7iC9cRpiGwrpA4Pxu0Ob+nng88SBX3?=
 =?us-ascii?Q?DXK5DyrNLH6luaxn0I7o+9P6orAubZfrlVl888+00m2BWHnyfTUJPOr93zqo?=
 =?us-ascii?Q?nuGZbNMtOX0+JiYys9aPGwKlqCK0hmqTBIdW5CLhsQ8KwGVqcdc908GCIEE9?=
 =?us-ascii?Q?fDF+M4dRLDTS86m9GQXYqCQi1bcZlMsKAeN5F1SN5DTckIJtP2rR87ZvXcCa?=
 =?us-ascii?Q?786ebZ4P19MBDb6Zez4qaZMKz6IetVLfnUEAJHsWtR0gp8oEesfTevyn5mfu?=
 =?us-ascii?Q?iWy1fuqhFjOyWET3pmmYcRmEoFoIJIpSwnp78lDU178NEGCS4Zg+dRfbzHfM?=
 =?us-ascii?Q?0beG4Km5Q+toSSKAlu9MiFA/0pC9y3EPuAPd6/uAZulXU6NACezv1HY0a2Gn?=
 =?us-ascii?Q?xTTQXuzP8pGLXoqx9MkAM1S88RaaWeFUf6AKmP5B+qKSNvt6cR34Sx4OaxyJ?=
 =?us-ascii?Q?XtdA1dH+KARBRKPL+c4mbO8c81QmIa2MUtlkMpdStL06Q2YnB8b7ws8s38eA?=
 =?us-ascii?Q?777AscRkjTAu+sPl0XEWnFfK3AiI/F0wiJtKBgiilaRfPf7SqMG/LSNDka99?=
 =?us-ascii?Q?p+SX2B8hrJ2XnAScCbhXonVqVHN4dQAFe1FnAvXhzIPmViv/SOFNCxo8u2hA?=
 =?us-ascii?Q?zQ/1fMMxOACiUS+ISuh9xY1osOQ2mYuiISPwqHajS7YlFuQaHO7rVPcorYiH?=
 =?us-ascii?Q?n3b2CG9qp8ATz8UONftrIjnudaD481/hWIHYSul5VTZzKKACdfLl5eysF4bn?=
 =?us-ascii?Q?yIuKzTK6ECYwpUdZ1VACP0B8PdstNtqAca6aCbIP63rC1a2Z6k3jCigGMuiD?=
 =?us-ascii?Q?DVgEE7VTt71VnYfL/CwF1le5WwYoN/hUpdCkEpgWWaRxp3qMepLFE4edep6+?=
 =?us-ascii?Q?FRoGSgxANNddzBHJClwE77uQZkEzgWa45qhbF3IjvNMvBM95G82cgcnsvcG/?=
 =?us-ascii?Q?MdaaO3yEsGJ4MtZ6qRXYwQ8Nf+MCvZLZgay+WfDRSTV5Afb7OurRSrHl6rs2?=
 =?us-ascii?Q?nTHK7lkZdBumIHgQCPupZySlJUMwGJjYCnLfcCAHjpyD0f20ObBJZGTUWqTW?=
 =?us-ascii?Q?m78+L1uT1TBS6qEqpdEGIaU82p4Bn2DHlSqB2LEGifiqNj5gfZS+nfulaYQI?=
 =?us-ascii?Q?RWT8F0IQ8d7G4fyIS86h8ukV5fSA35IY7KzjjpsuAJeHAX806rgja9lxXdnP?=
 =?us-ascii?Q?8UxRdrling=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DSWPR11MB9715.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f12a4a1-26f5-400d-6c5e-08deca954d51
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 04:19:32.9059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v2wXOUzOH800UHxARCxBp0EoiyVR24nFbjYHbFPMQobRx6rfMVhIDJuw1JeMydhl3eXukvvLBiuUUtMLGvSRIJ3mRjRi5i/pHpqH7hTMQYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9715
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299311-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Thangaraj.S@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:netdev@vger.kernel.org,m:Bryan.Whitehead@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[microchip.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Thangaraj.S@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lunn.ch:email,davemloft.net:email,microchip.com:dkim,microchip.com:email,microchip.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8428C6833AE

Hi Simon,
Thanks for the comments.

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Wednesday, June 10, 2026 9:55 PM
> To: Thangaraj Samynathan - I53494 <Thangaraj.S@microchip.com>
> Cc: 'Simon Horman' <horms@kernel.org>; netdev@vger.kernel.org; Bryan
> Whitehead - C21958 <Bryan.Whitehead@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH net-next v3 1/2] net: lan743x: add RMII strap status
> detection for PCI11x1x
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> From: 'Simon Horman' <horms@kernel.org>
>=20
> This is an AI-generated review of your patch. The human sending this emai=
l
> has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> Subject: net: lan743x: add RMII strap status detection for PCI11x1x
>=20
> This patch extends pci11x1x_strap_get_status() to read RMII strap bits fr=
om
> STRAP_READ and initialise a new is_rmii_en flag on the adapter, updating =
the
> netif_dbg() to print the selected interface as SGMII, RMII or RGMII.
>=20
> > diff --git a/drivers/net/ethernet/microchip/lan743x_main.c
> > b/drivers/net/ethernet/microchip/lan743x_main.c
> > index 1cdce35e1423..0798f3f1f435 100644
> > --- a/drivers/net/ethernet/microchip/lan743x_main.c
> > +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> > @@ -73,8 +74,15 @@ static void pci11x1x_strap_get_status(struct
> lan743x_adapter *adapter)
> >                       adapter->is_sgmii_en =3D false;
> >               }
> >       }
> > -     netif_dbg(adapter, drv, adapter->netdev,
> > -               "SGMII I/F %sable\n", adapter->is_sgmii_en ? "En" : "Di=
s");
> > +
> > +     if (!adapter->is_sgmii_en && strap & STRAP_READ_USE_RMII_EN_) {
> > +             if (strap & STRAP_READ_RMII_EN_)
> > +                     adapter->is_rmii_en =3D true;
> > +     }
> > +
> > +     netif_dbg(adapter, drv, adapter->netdev, "Selected I/F: %s\n",
> > +               adapter->is_sgmii_en ? "SGMII" :
> > +               adapter->is_rmii_en  ? "RMII"  : "RGMII");
> >  }
>=20
> [Low]
> This isn't a bug, but does the new "Selected I/F: %s" debug print stay
> consistent with the rest of the driver when is_rmii_en is true?
>=20
> In lan743x_mdiobus_init() the non-SGMII branch still prints unconditional=
ly:
>=20
>         } else {
>                 dev_dbg(&adapter->pdev->dev, "RGMII operation\n");
>                 // Only C22 support when RGMII I/F
>                 adapter->mdiobus->read =3D lan743x_mdiobus_read_c22;
>                 adapter->mdiobus->write =3D lan743x_mdiobus_write_c22;
>                 adapter->mdiobus->name =3D "lan743x-mdiobus";
>=20
> So an RMII-strapped board will report "Selected I/F: RMII" from
> pci11x1x_strap_get_status() and then "RGMII operation" from
> lan743x_mdiobus_init() in the same boot. The C22-only setup is correct fo=
r
> both RGMII and RMII, so the only effect is the contradictory dmesg line.
> Should this dev_dbg() also be updated to reflect the RMII case, either in=
 this
> patch or in the follow-up "net: lan743x: add support for RMII interface"?
[Thangaraj Samynathan]  Agreed, I will fix this in next revision.

Thanks,
Thangaraj Samynathan

