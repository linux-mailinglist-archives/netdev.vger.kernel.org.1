Return-Path: <netdev+bounces-264680-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMVwIhZrqmlORAEAu9opvQ
	(envelope-from <netdev+bounces-264680-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 06:50:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC0921BD27
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 06:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3CBE83025262
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 05:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA45F334688;
	Fri,  6 Mar 2026 05:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RWETvEfg"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011033.outbound.protection.outlook.com [52.101.70.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA99F2206AC;
	Fri,  6 Mar 2026 05:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772776211; cv=fail; b=nQzSvMywuoj2ZC1RWcRBPyTk34FevQpdq2Wlf/vVVELEz47zZWbFtcCQ5FXyriTGDpxtX1y7mxB3O9afr75wTm816VTKEj3ThogelrsAF3b4iJpWkvUQ/+83LeOVNKN/n971l2kF25+HsnU4zh0zaJGYlwYkQASUbR+z9Oz+R1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772776211; c=relaxed/simple;
	bh=CYy7kay/v7+/eZvTiliIRS4opev5IQIp6g3971jbcC0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QIKzQaqWvF0kl/hUJwJCERVUOIWkPys/69a7LAFf/zkaNL4qT1VGhwQ4c83TlhCzTC7B0aGQO3HJwS8C69tEngdyq3lu2KrTPmbXldQCq/6r70d/OEV+ufy9adbxy4Twpwga+EjXCOuVsSOYEMAxA621eUPlIglKxVmOtqMO+2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RWETvEfg; arc=fail smtp.client-ip=52.101.70.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bb1mERiOrTqIWRD/yQqP0rqH0bPs5Q1sNgl22ZJJDXj8ytOWwu5B3cx9fmMjBx4buHIxZmSoZumZwV8DhP5kuw8K6Vf6A+sdYWxxlFIb2zhZWu55cn0zqCAcNXOE8lkKZHKeF2xV6l16kFPOGuLVXyA9kjDOuYC/MXwg2woZreZmHfyX7sRbP1tB+eL1r/TJMPr768+5bBs3peRRRqBo9fM5HTtK4wR1i9nfo1rFgsa2Jp7Ku7TO0BOnk2GnjlNa4ZuPn/zAML4oOi6vcMH5u3j9qTfnwrDLSn18HnYHehYvXO8lP+U6y3bpRIAL2nU6+rtAfT7QVROAy7SvuVy2TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4lqeeyrRDZ1lX2lAP6Zj+6U5KIKrIhgZ8zdcpO6bcQ=;
 b=ne/oGuogXl2rBnSE+mRQDzFU16gT4swht1igkY4YkB2cSn+Xw9RVodMOaBXDa+08JP8MjvWcIMHQ2LcykYLJW6jE1Vmz6g90n0Cmx6B1J3dtFmTbBiTlbp+j9/CQE+CSoCfWq3BChnZnjKOVzI6JLK2tBmvw3nNzdpVg3Dtq6qFpyUQ626cnVN+UHr+VerPIWg0+h319s5Jv2palUCskByHG3/KnYY4DiuCjQpoiYDz9894ck557tuW8y1Oj5xklhEZsBm6wDCNl82fW2PuoAmnXQ5zXNpD4daA1uMAWT/29zwAc0Pqhpar7+eKI21zLLdgyJP+kCuIXu2qtWzG3qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4lqeeyrRDZ1lX2lAP6Zj+6U5KIKrIhgZ8zdcpO6bcQ=;
 b=RWETvEfg0ywlepvEQCH3YrwJxjnquOwkGnkjxoM/T5ZZgu3XtNvm7t5fV5VAdKotumuK6mdwZeUYxMsoTaCTBNDdiXFyEs3x/8dxZGs+b23Fs1oTub7O7lbnpgREbq0048yW1Iy9EYuTUqJYn0mnDQomNnuqfeTkCxHMf7xTt34A/7YbIsjCNaHvVWoDDlia9VN/zBKsEA1Ft9YQMMjJSH7F3vS5Ujy1LeSgW8LJIVORztqVRmdZoYbuwDvT5AfDA0L01Wxau3yB/0doAKWFv7bBTy+tOH6BKA9UcTWWLw6fvGzGKbSoUO9TrXIIU9i58gGlqn27KdTNG6nlGpjqBw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV2PR04MB11189.eurprd04.prod.outlook.com (2603:10a6:150:27c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 05:50:05 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 05:50:05 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, Frank Li <frank.li@nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net] net: enetc: safely reinitialize TX BD ring when it
 has unsent frames
Thread-Topic: [PATCH net] net: enetc: safely reinitialize TX BD ring when it
 has unsent frames
Thread-Index: AQHcrStuINDxuw1sR0C5AmU+yxos17Wg/ohg
Date: Fri, 6 Mar 2026 05:50:05 +0000
Message-ID:
 <PAXPR04MB8510B6B8E6B1CA0D83148883887AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260306054002.2208360-1-wei.fang@nxp.com>
In-Reply-To: <20260306054002.2208360-1-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GV2PR04MB11189:EE_
x-ms-office365-filtering-correlation-id: febb6bf6-02b2-4ea2-8b98-08de7b443795
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|19092799006|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 3lLpeCrIzrAJ9Q0huw0trI2nlJGnW7+2BBAp+ILKbrTRzhxz4lA52JiOOBWGHvkM7qAmBq5/H+8zHRQn9k3+xsrsFQ5eWrVHvILWXim+viAkKmQqdB6QGtcaQmXmK4jwlumsJET84sA0W7IhStORxYQy6xPSqW02kf3CKfDz5pLaYRS0wmxbgQgTHdD4CiNmKfQCB/p2rpaaXf6z4LBgRZhwiGyFFQ1Zj9T9wemMAWCOi/hCQRVb0LHp6p68s9wnLWVn+Kkm2SCM+oBFRZgOuShuQ97mEeA2cWEr+WP3wFcRsf7CdIYdNzeuv0+ZpkSeXtDwhrggKv948udiEFfnoUPwadyCSumDpZ0/f74fkM4nLjSXdu8ixhKcjF5X2E9rqFBuePo5ooWWSXiEQfWsJWrqmdaQXNHYEHfJH1QMIJPCybU7fbqghhMdTWxym6X9NGsr/9aS0P9u7Z/GppR2yecTpBCQhYtZjSWLv5P/YUZbzPL13/HH3qdJfLraJP/d2qOh0JqR7fSpA/4j5cFnvkdUvgko6deUvoBcwaRSfyjNqFEQXUt5hdOskbI+W8Pz4aQ8UFmrgAf2IMAloH7zsbouk0lLc3k0vvc4EZycm7JMNeBQ+KqphFMY+ZHMQwNjGFsI42n1hCXq0zAX5BeZV7lreComLukWVeDDk/U7YvX1vWCVgB0hz2rVVjZPoQUfX8DvjR+RB87uyDIeS8UID2BDj7Hf6wAluZx/L9YStxbomJDbACBQ7p4hblIsC7xPNtW2Vl/wfV4qGM5dBkGAOsYH+vxi6exqSV8djnHnAZc2iCZk1dEakDOqA89Ky+lE
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2B6//teDm5q8mcdvPkyPcLLDoWbmOetGJMKAHQ61vo0ASceyeaXKPP79aUOy?=
 =?us-ascii?Q?OmSwzmAynZU3iOawGdhryX+yEVafBlBeNX3i30kjiilLIXFdZM0AH2xHwF1X?=
 =?us-ascii?Q?asWpR/QXxMyO4zpeZ5eQh9ekHZ7VMhX3IvO5lgkmgdGXrprMcmr2suYaA/Fs?=
 =?us-ascii?Q?G6lSBpqkEVpZVrdyhnhpgqXhAyjLPnUFeB/JlI4YpmG1BwnlLkAZ5dM2U2Sy?=
 =?us-ascii?Q?uUO39FQ9qS0Wb0hrsNiL8U94zDEL/rIGrDx/b3iLGfp3lPdFcNcsS6bnrFY3?=
 =?us-ascii?Q?mszh6CsCSTwvQmTSx68VNXxaop8rCcjP8boWiUcyug8yD7nzop2e4KynKGvb?=
 =?us-ascii?Q?294yMkm1wL5DHwjZL+lfRpZnhwkFQCsSXU7x0qt7eD31EOg22kzYlpzQrbo0?=
 =?us-ascii?Q?jHPAFpdy2gI8kMMTkDFX1GTI+4y6PFwCMS+lNxBJlqgck4LeMCPiVo2uHyhC?=
 =?us-ascii?Q?cjj5EfwVT5oCSjCw9Sai4in6JsoceKiFPLV3oCyTIUKuMqJNrMiFoBL69kah?=
 =?us-ascii?Q?k/m3yrKZK57c7CzHAmcbrFdFnLEU8cBxYdB5XSffLMgEtu2w9xZhDS6/4jIl?=
 =?us-ascii?Q?HMJDIOJ4gfdCGuQWeta08Vw+gW4VcijBm4q50WPY1wf89rTbKA70qb+UpkBI?=
 =?us-ascii?Q?3kseKpOhoNNH8H/sjI5GILUEOc2S5kXoXzOl83bhFM8OEhK/aFvnCn9Ik0kB?=
 =?us-ascii?Q?cw+dNrPODDJhKhlsWqbVIT5NY/56ojyW8V2jmEMsoNvKBKnizheD2wh59qh/?=
 =?us-ascii?Q?5Q3gvJupBcEx8nFhLJO7E7YzFuZ7eKP+Ag5hoONdrybOznYA8IsAY8rY37OB?=
 =?us-ascii?Q?flSc8ha30vGjerh4w5EJSCHB9kww9OA+GgU5bO7PNKdX4aXa3v+9WObuVvv6?=
 =?us-ascii?Q?KnexdW3bR8YW1SZmJYjt/xcKCcCBk5PJ5+DcpPGTt19ruT9c0MnVKRz8K+Jx?=
 =?us-ascii?Q?hQlvm7SIZmCAv6N9aSsEQM0cdTpuoaZR870EV+Y0Qeyvdhj1jlXFEXdpADW4?=
 =?us-ascii?Q?tFm8P1k5ZZu9L6cuxrnEPcUHXUjYktmCp4byO0KfeJjS8UrFLTsGvFr2zr48?=
 =?us-ascii?Q?QwdlAaVBtxv0osLri7JwOLBgDcTtFKNH1qp9E0+ip5S+AgNdxIgHblmYyRU5?=
 =?us-ascii?Q?kBjp4x8wbz7Y2F6BGJZ/tHnIAPXM7t5qjRF3cQ1UCW0i7jdekjjtZEL1KDLz?=
 =?us-ascii?Q?i6XMan9uwE90dvhnJ4EY6l09WpkFwkn4S7d1mfLFgqscl/3JLwMh70Q8xdoU?=
 =?us-ascii?Q?REmhyir6ZgPh0IpixbGIntBh+rjzKeJpE0qBprRgIJBjffSJWNGdN1dbHC3c?=
 =?us-ascii?Q?P0PrlYD7CKrP/ABl+s1PI/JaKc1TQ9M5saB5wInWcQbcJQbIAuUIikVLKTBD?=
 =?us-ascii?Q?9/fjfgAkSujlIRvIuhO4YJQEvS4ugK8RtxhwBgN19QFXpEULZhZYaU9leCz0?=
 =?us-ascii?Q?b+We0znN2UVqUFfg3x5E44sCZvyJ0sIAgEQ/H22sOIXIB+LHlVAwLsjzGlh+?=
 =?us-ascii?Q?6lEGgpG3HfPUdOqhhYGbBMUiqp19thM7wt9yRQmkXl/J9Pb1wWf3135rv/O1?=
 =?us-ascii?Q?nYkIvRw1fT3gCLAND89p1RhwbaRDICL1rVEy+JPrylWiZBxqydy0+eRBVagD?=
 =?us-ascii?Q?RO4YUjmmYGYgYn+brkEpB+9b9PuaJ7JTokbWH3WRSitS/Fo189lT+RwOJz1/?=
 =?us-ascii?Q?WQzFC7g5dG7Ew2TCvJ/uTeIUTM+GPCtYVtmA0dB0reqnpaWh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: febb6bf6-02b2-4ea2-8b98-08de7b443795
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 05:50:05.3655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hiqhMzlbl20/x8GTQ8FgFEPrM+y4pGZDYOEWPp+lwiHcZ7dzEPBCtAquYbuiD0MrS+LVADNR8AtjiPC2Lso5Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11189
X-Rspamd-Queue-Id: 2AC0921BD27
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264680-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nxp.com:dkim]
X-Rspamd-Action: no action

> --- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> @@ -20,6 +20,8 @@
>  #define ENETC_SIMR	0
>  #define ENETC_SIMR_EN	BIT(31)
>  #define ENETC_SIMR_RSSE	BIT(0)
> +#define ENETC_SISR	4
> +#define  SISR_TX_BUSY	BIT(0)

Sorry, I only realized I hadn't removed this debug register after
sending this patch. :(

I will remove this in v2.


