Return-Path: <netdev+bounces-296174-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BkeYKPHcJGoLAwIAu9opvQ
	(envelope-from <netdev+bounces-296174-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 04:52:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA75764EB45
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 04:52:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="a/FdvTZq";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296174-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296174-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4309300B9B2
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 02:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F06223DFF;
	Sun,  7 Jun 2026 02:52:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013065.outbound.protection.outlook.com [52.101.72.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725CE3FFD
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 02:52:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780800751; cv=fail; b=sNyBmC1otrGBz8umq4/Gl1v8IB+Qj/mH6OibfZlPPcBa82raKQbnfwp4k10oHx3vpXO8UHBulFrhxZvYJZ7EgtuueiE1NZKt0v7s1eoRXSmCbyWf4HHWdrRagruu1SPkb9hzNEzUm5TPHRqoPklt+B8lkUiUh0VPbZuv7oXqH+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780800751; c=relaxed/simple;
	bh=N890W0OIjMuU8f5RXoy+tCbHY/xtB0OLz0716CYy6vU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=scwI2t5ssmZll5/2sV/uLJZj5POgankdyqdajiKMfeN0mBd0zV8nbjqg3uauvpdaHM97S6QTuMyWT06htxBnflOxNRqEtLDXoALZ/JYscn+yzyMDr19tC+8kiHNiIx1e5Y4BNs1M45nfl1FauzYIBRoONWszm9kDmrx28p53Sq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=a/FdvTZq; arc=fail smtp.client-ip=52.101.72.65
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkQqHf+YHX13+pix3f8xO6tNoaUTo20L7X1rk69994JRcSUPK1fb71v340nmQcS47q8+fvtRYLlMnqFN6OkXCad4UoBFISiE/cRTSGtvFIIpIcuUc8unz4OYoruW9Ge0xdPPglLOWMls0GykIL0lm88K1UTNpuTcckHO8ulQYHY5l619vNL0UJGkVXR8FzuFMokwKiOv7np0kN8P0n6RMG1Gd6n4A3CipT+WVCelx+/gh+hibzdw+F2kM3cvfruXYhtONB3IDq/0d28XweK1hpf0L8GBep+G0/t0guluZRAnP9awT56O0WjVRUOV/ADdZPBkvKeRZklcchUTz+ii1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N890W0OIjMuU8f5RXoy+tCbHY/xtB0OLz0716CYy6vU=;
 b=Oht9UKGCa/u/2YZtgBl94s5TggJrhYyT4MhrwbPG7rBuWQuheByDySObv2EWpqO/bkjivf3Q8nWzMZWJjbh8yeAihLzBMS69996cfb2xKqDBnI9JqTFO5cre7twiOdyyjamsyrF6MjyD6xs3TpoKXJKA76aY1IdeVbmzRz2DIH8neTwzORG3rKmPgDtnvqpqnBE0LbzpKR+UtaZ2FJ8CHZGWXioCLdDIlPe13X8vVfhTGPF5mSt6A9SaXmeH0wAlo0TbmM47ZMMa0nhllHpWyvnSxPN6jKLqdeCUPLqANh5XjHPwqa/UAJHpQniM2LXNdU9vWRGY4/LQrmKq//NYtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N890W0OIjMuU8f5RXoy+tCbHY/xtB0OLz0716CYy6vU=;
 b=a/FdvTZqRjJ9ZD2j4QDma63s3r8YrztCDznundEU0HbEO7iHtas7IgOrsqOx19muUthQCWhaAy6YO1sh1oAFYeTgRHhP+h2p3zy/sgitXQmOKufRDAr6RIpcPMJSqzAPW1pF9CZDA+95fQdQtchuJ9ICpUJjVoYiFsTmCVsBPF2h32vIsj3MPEYx/vgW50ZtdWtOatHIaoPkfwWRerAMq+8pHSjjZ6izD9bDJIfTJOsNva/+hyunolWJdEyN4ixKKLxhJuU/AOdcmD6GgOtNumJerZ76MauYnzQpeafHeeNw2rfDcdjjsVuOQxQlbYZqJaRGforhIkpPpRVV/E1OzA==
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com (2603:10a6:10:2dc::6)
 by AM0PR04MB12052.eurprd04.prod.outlook.com (2603:10a6:20b:745::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Sun, 7 Jun 2026
 02:52:23 +0000
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47]) by DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47%6]) with mapi id 15.21.0092.010; Sun, 7 Jun 2026
 02:52:23 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "Frank.Li@kernel.org" <Frank.Li@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, Networking <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next 08/15] net: enetc: move mac_filter from struct
 enetc_pf to struct enetc_si
Thread-Topic: [PATCH net-next 08/15] net: enetc: move mac_filter from struct
 enetc_pf to struct enetc_si
Thread-Index: AQHc9Lw+qLB2Scw+g0aggbDG9UW797YxIZoAgAFGPuA=
Date: Sun, 7 Jun 2026 02:52:23 +0000
Message-ID:
 <DU2PR04MB8629EC8987F8FDC3BCDEC176881F2@DU2PR04MB8629.eurprd04.prod.outlook.com>
References: <20260605065550.3038579-9-wei.fang@oss.nxp.com>
 <20260606072440.9E3851F00893@smtp.kernel.org>
In-Reply-To: <20260606072440.9E3851F00893@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8629:EE_|AM0PR04MB12052:EE_
x-ms-office365-filtering-correlation-id: 0fe34581-262b-4a24-f527-08dec43fccf5
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|11063799006|4143699003|56012099006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 K1FKhmJGat0CvjRZrLu7i/0BSUN51pG/nVv9hZrtBddviJStl1l5+dEx5WBz3u+CZ8a8ye5V0q2tmJHVDwWx8i3O3flHjS7iCWlyttmZUjbOITtXmoqtu5BwXMmm5OLH8rqsBaPw8v9GEApbHdJXLVvuQYMmTHK2gVyTBTdrvvvJtpS3Rv+SOZxGgi8gazq1/3cFh9xIrb9kSiGtZ0JYiI4V9VNPO3F+HkMsBuox/y4W75sDu2MItkYiM3+7rNUjjM/Op9+gRxRMfR/mrfaB3XX5mD7FDXokuK9bNZl3WSFaZ+f/dwJPHphM/aTAb0KOqs0q+r4FSVwWEOc8fS9IVMmg2U8UZzLdJSknTPnm79vTxRzoDJVENIxKHBbNfa0mRptIQVhNYGexwz5AbIGCrgvfL0ZXLT5YzrNOlx1HO/oRswlrKRwJ20ZeEbREbvyztmfxhpP/4IRx4K3JoU5uiR63KGileSzaIUHOpxVyHYwMkm6CUoFwU266/Ow5EAmxVgMWUD+OHilvyZo9XkkVQKQknMFYS1+dVAeQnTshKA8sdXe+LPWF2ZOAh5rWh6Ped5U8IzOLyh3X9LsV3uCthTsSVW1va+xANSJf6mb0K0Edr1Y4cPOYzdn8MFl+VY5Bb9qr3a2HXfD9ydU5AHItKbpRJU/oLndcnC3Xf+xnWjZzbJzmWclMfuycUMa+fDnDbJ8BSYcbJO8goLHqzlhFwyTb/qkKtrjGBE1OPDmQcqCbBKj4yrYyT+9/enkohLw3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8629.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(11063799006)(4143699003)(56012099006)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z0J2eU5wejQ3ZmhlNTQzbHdhQmFFbHc3TURTemJ1NEo5bFMrZ0g2cC9CeXFE?=
 =?utf-8?B?SytDREdEL2VnUm1yS01Ueml3RWM5dU94RVJ2d05PSzltbEpnN1RtUXJqMkI2?=
 =?utf-8?B?VVFUUVFnWHpsUFRjeGhFMXFQU1VyMmxtbTlVamN5bWF4QjJUV0t5ZVR2VUNn?=
 =?utf-8?B?U2FtNnJGWkVtd0tkRFkyanUxUGI2UGFpMkF2M3NsanhlZXRBc0xyRmU2aHZN?=
 =?utf-8?B?NEFaVHBadjhTUDBnVjNzUzFnNUdnaml0RFJiL3ZwVnIvLzNKc24wWWFLQm9i?=
 =?utf-8?B?ZG5NL0Nmclh5SmNDVEFsSWN3NVF2aGlFK1ZjNVNCcnN5b3M4RHB1ZmdXSUY3?=
 =?utf-8?B?TU9zSXRtaTNCK0ZYZ2NITmhDUjBSdHY5dGN5SjBka0pLQXFDeGMwcEd6NmpO?=
 =?utf-8?B?VXVMbGU1aGlxek9XM0FGVklTcE96MU1KdGduK1F2bEM5Zk54OEVZL1RsVkZ1?=
 =?utf-8?B?UkJLL3gwTDZTdXFjVzZRdlhoLzNsT3locHBzMitIQkN6Q0VERkJ0MVRlQ0xZ?=
 =?utf-8?B?aUdmTWtnUGVYbEdBRHAyRWlWUE54Rlc0WkRPczZjK1VKSlFkcmtVNGpVUDdZ?=
 =?utf-8?B?bks0Nk1pdnc5UHkrakdXTXNCODNVZWhWSE93azhUcGZsa0gvaUZOcllrVEds?=
 =?utf-8?B?djFrUzhEeTNTOVlkM3grNDdGajZCRHI3WDNHZjc0YkY5c25lY3dnbzN2WHhC?=
 =?utf-8?B?RGd3aHdaNmJlZkNjZDJsYWY5WnJOSXhtUVpjUlI2aWRlNXhQdU8xUWZmVWNn?=
 =?utf-8?B?bDE2MFRESUtZRXhQN0ZFR3ROSFQ5eTdMSm9XMDZGQkFkRlBnSnhKcVo0VlIw?=
 =?utf-8?B?U0hpcFJ5TDNwN29HZXdyNkYyZ3JjNW9teUozQVpaMEtyTFkwMGdPVVhTSDdZ?=
 =?utf-8?B?SzJCbzZNU3BSYXoxRVQwZGFWSFp1aGRmTU9qM2RFTzBiY2VBQmppNmN1RzNq?=
 =?utf-8?B?SFBDdWI5ZTFjQU1saEN6NjFCK1ZXUldRUzZ6enMyNjQ4bGVmbmxFWUxXUzlo?=
 =?utf-8?B?a1pNS2lEbUlWdklLQjhRN0duRmNWckg4S0pmbksrR21NcWJ6NzVDeTJPaloz?=
 =?utf-8?B?T2swR2VYUUo2bXhCVVVpZ1ZKWEVXL00za1RMZG5IRUdzTHVTZkk2dUlBRFQy?=
 =?utf-8?B?UFY3cjN5Vkp1OEUvSUVnckVtcWNRdXBIMGt1SktrZTBuckFKZzcwemlJK0Fr?=
 =?utf-8?B?ZVVTRnNmTE0yK0R5UmEzcndtcDh3MjNYTmZ4SHI3Sk83OFpJYWFucFphZUwx?=
 =?utf-8?B?cGRlSTU0Q2NzcDRRRkZ2Zng2Uy9IOThWU1VOZ3hNeUxjMWVTZmFUbXowdVNC?=
 =?utf-8?B?cmxyWGJIK1lJd3kwQmw5aHR6Z0RPM0laS1dpNkZxZ0U4dEloNDNYZEMwZVR6?=
 =?utf-8?B?UTdHN2N2Vlp6K2I3VmE0OUZEQ0pPc3hjVE5vZmRFcHNGVUc1M0NkOTdESTc1?=
 =?utf-8?B?Q2d1Y0tWd3pKR3d0aGxvSU9mbk0rOU5DVlBaSENCdnd4NEpXb2wxNUkvVWYy?=
 =?utf-8?B?TE12bUhWcnJESWVOTk1WaDRTRGxmaVpWWnY4a2NZTTFLTldPMlM1eWI1VTY0?=
 =?utf-8?B?U1pkelBOa2xNbEI3cTUxeTFtKzdXVS8vL3lsZFFoWlYxN0t1Tmx4aVZDcjNG?=
 =?utf-8?B?c3NWQ1RDcnBBWFZsWVBjYzBqR2RBd1prRHpkTi9vRXFJMkhSRDBIVTBtdmJu?=
 =?utf-8?B?NG9WMEIrMUwvZFR2cE85aDZTRC9DcTQ2bUx4VUZmcnhmUnNkWng1L3NKSzBH?=
 =?utf-8?B?T0loQWNrVVZCZHhHZmhDUEtGZXhwQkFlQmNZODRGSXNaaEZuZi9jWk9yalZP?=
 =?utf-8?B?V1krclk5cjhVbDBhZk5vczU4MmhwQTdjVnF3K0dwb3BaTjBlWC9JQ3ZHSFNK?=
 =?utf-8?B?S1VxV1dmRkFWY0J0RUhGck8yM3A5UkNUakl1Q2JRNE9uWmJ2VHdxS2htajZm?=
 =?utf-8?B?MFFkSWJUUlNrU0NTMEFqVDNySFkzK0hDbzZvSGs3ZFdweTBSU2RaT3E1R3Ur?=
 =?utf-8?B?TTlCRUpVVDRySjVSUURmdkVNOEJ0V1ZFNGZOOWNmaEFrY1NQMkNNWUpEREE4?=
 =?utf-8?B?ZU45UmJtdDVMa2h3UmxmRzRTNjZCNDAxQjkzUHRUaXk3T0hGOWtRUTg5aHgw?=
 =?utf-8?B?cGRSRmU5TTRnZTJSOXpBT3h0N3NPQytyTVlVVEI4LzlIMzRXRlFDT3IwbTFM?=
 =?utf-8?B?Y1F0cThxU0VhdXMrUjRITXpOZDFuTFBvcDB0eCtVS3VXQXQwSEhHWUE4YXUr?=
 =?utf-8?B?ckZaa1hPN1hRVEFQZEpKL0d4Ly9QY0V5S01GZWxKMmwxQU1GbDRtZ1J3SmNH?=
 =?utf-8?Q?Bbiq/ZKL85yp0Xs1Wd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8629.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe34581-262b-4a24-f527-08dec43fccf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2026 02:52:23.3779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qgW49ZsdZpryZoxXvmCKW85PAPqnBjLCzv1QgN4wqUZbEHRcQwj1b9DGK/LD3iEsLL8xlYrH0vNfKSiKVz1//w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12052
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-296174-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,i.mx:url,NXP1.onmicrosoft.com:dkim,DU2PR04MB8629.eurprd04.prod.outlook.com:mid,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA75764EB45

PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5l
dGM0X3BmLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGM0
X3BmLmMNCj4gPiBpbmRleCA0Y2ZmMmYxMjM3ZjE4Li5mNjkyMGRlZDlmN2VmIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0YzRfcGYuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0YzRfcGYu
Yw0KPiA+IEBAIC0yMjUsMTEgKzIyNSwxMiBAQCBzdGF0aWMgdm9pZCBlbmV0YzRfcGZfc2V0X21h
Y19oYXNoX2ZpbHRlcihzdHJ1Y3QNCj4gZW5ldGNfcGYgKnBmLCBpbnQgdHlwZSkNCj4gPiAgCXN0
cnVjdCBuZXRfZGV2aWNlICpuZGV2ID0gcGYtPnNpLT5uZGV2Ow0KPiA+ICAJc3RydWN0IGVuZXRj
X21hY19maWx0ZXIgKm1hY19maWx0ZXI7DQo+ID4gIAlzdHJ1Y3QgZW5ldGNfaHcgKmh3ID0gJnBm
LT5zaS0+aHc7DQo+ID4gKwlzdHJ1Y3QgZW5ldGNfc2kgKnNpID0gcGYtPnNpOw0KPiA+ICAJc3Ry
dWN0IG5ldGRldl9od19hZGRyICpoYTsNCj4gPg0KPiA+ICAJbmV0aWZfYWRkcl9sb2NrX2JoKG5k
ZXYpOw0KPiA+ICAJaWYgKHR5cGUgJiBFTkVUQ19NQUNfRklMVEVSX1RZUEVfVUMpIHsNCj4gPiAt
CQltYWNfZmlsdGVyID0gJnBmLT5tYWNfZmlsdGVyW1VDXTsNCj4gPiArCQltYWNfZmlsdGVyID0g
JnNpLT5tYWNfZmlsdGVyW1VDXTsNCj4gDQo+IFtTZXZlcml0eTogSGlnaF0NCj4gVGhpcyBpc24n
dCBhIGJ1ZyBpbnRyb2R1Y2VkIGJ5IHRoaXMgcGF0Y2gsIGJ1dCBvbiAzMi1iaXQgcGxhdGZvcm1z
LCBkb2VzDQo+IGRlcmVmZXJlbmNpbmcgbWFjX2hhc2hfdGFibGUgdHJ1bmNhdGUgdGhlIDY0LWJp
dCBmaWx0ZXIgZG93biB0byAzMiBiaXRzPw0KPiANCj4gVGhlIG1hY19oYXNoX3RhYmxlIGlzIGRl
Y2xhcmVkIGFzIERFQ0xBUkVfQklUTUFQKG1hY19oYXNoX3RhYmxlLCA2NCksDQo+IHdoaWNoIGV2
YWx1YXRlcyB0byBhbiBhcnJheSBvZiB0d28gdW5zaWduZWQgbG9uZyBlbGVtZW50cyBvbiAzMi1i
aXQgc3lzdGVtcy4NCj4gV2hlbiBjb25maWd1cmluZyB0aGUgaGFyZHdhcmUgbGF0ZXIgaW4gdGhp
cyBmdW5jdGlvbjoNCj4gDQo+IGVuZXRjNF9wZl9zZXRfbWFjX2hhc2hfZmlsdGVyKCkgew0KPiAg
ICAgICAgIC4uLg0KPiAgICAgICAgIGVuZXRjNF9wZl9zZXRfc2lfdWNfaGFzaF9maWx0ZXIoaHcs
IDAsDQo+ICptYWNfZmlsdGVyLT5tYWNfaGFzaF90YWJsZSk7DQo+IH0NCj4gDQo+IERlcmVmZXJl
bmNpbmcgbWFjX2hhc2hfdGFibGUgZGlyZWN0bHkgbGlrZSB0aGlzIG9ubHkgcGFzc2VzIHRoZSBm
aXJzdA0KPiB1bnNpZ25lZCBsb25nLiBTaW5jZSBlbmV0YzRfcGZfc2V0X3NpX3VjX2hhc2hfZmls
dGVyKCkgdGFrZXMgYSB1NjQNCj4gcGFyYW1ldGVyLCB0aGUgMzItYml0IHZhbHVlIHdpbGwgYmUg
emVyby1leHRlbmRlZCwgZWZmZWN0aXZlbHkgbG9zaW5nIHRoZQ0KPiB1cHBlciAzMiBiaXRzIG9m
IHRoZSBNQUMgaGFzaC4NCj4gDQo+IFsgLi4uIF0NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Y19wZi5jDQo+IGIvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjX3BmLmMNCj4gPiBpbmRleCAzOGZjYzdi
NWZjNmRhLi4yMDlhMzUwMzYwOWY1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Y19wZi5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjX3BmLmMNCj4gPiBAQCAtMTExLDEwICsxMTEsOSBA
QCBzdGF0aWMgdm9pZCBlbmV0Y19zZXRfbWFjX2h0X2ZsdChzdHJ1Y3QgZW5ldGNfc2kgKnNpLA0K
PiBpbnQgc2lfaWR4LCBpbnQgdHlwZSwNCj4gPiAgCX0NCj4gPiAgfQ0KPiA+DQo+ID4gLXN0YXRp
YyB2b2lkIGVuZXRjX3N5bmNfbWFjX2ZpbHRlcnMoc3RydWN0IGVuZXRjX3BmICpwZikNCj4gPiAr
c3RhdGljIHZvaWQgZW5ldGNfc3luY19tYWNfZmlsdGVycyhzdHJ1Y3QgZW5ldGNfc2kgKnNpKQ0K
PiA+ICB7DQo+ID4gLQlzdHJ1Y3QgZW5ldGNfbWFjX2ZpbHRlciAqZiA9IHBmLT5tYWNfZmlsdGVy
Ow0KPiA+IC0Jc3RydWN0IGVuZXRjX3NpICpzaSA9IHBmLT5zaTsNCj4gPiArCXN0cnVjdCBlbmV0
Y19tYWNfZmlsdGVyICpmID0gc2ktPm1hY19maWx0ZXI7DQo+ID4gIAlpbnQgaSwgcG9zOw0KPiAN
Cj4gW1NldmVyaXR5OiBIaWdoXQ0KPiBUaGlzIGlzIGEgcHJlLWV4aXN0aW5nIGlzc3VlLCBidXQg
ZG9lcyBlbmV0Y19zeW5jX21hY19maWx0ZXJzKCkgYWxzbyB0cnVuY2F0ZQ0KPiB0aGUgaGFzaCB0
YWJsZSBvbiAzMi1iaXQgYXJjaGl0ZWN0dXJlcz8NCj4gDQo+IGVuZXRjX3N5bmNfbWFjX2ZpbHRl
cnMoKSB7DQo+ICAgICAgICAgLi4uDQo+ICAgICAgICAgZW5ldGNfc2V0X21hY19odF9mbHQoc2ks
IDAsIGksICpmLT5tYWNfaGFzaF90YWJsZSk7DQo+IH0NCj4gDQo+IExpa2UgaW4gZW5ldGM0X3Bm
X3NldF9tYWNfaGFzaF9maWx0ZXIoKSwgcGFzc2luZyAqZi0+bWFjX2hhc2hfdGFibGUgb25seQ0K
PiBwcm92aWRlcyB0aGUgZmlyc3QgMzIgYml0cyBvbiAzMi1iaXQgcGxhdGZvcm1zLiBGdXJ0aGVy
bW9yZSwNCj4gZW5ldGNfc2V0X21hY19odF9mbHQoKSBhY2NlcHRzIGFuIHVuc2lnbmVkIGxvbmcg
Zm9yIHRoZSBoYXNoOg0KPiANCj4gc3RhdGljIHZvaWQgZW5ldGNfc2V0X21hY19odF9mbHQoc3Ry
dWN0IGVuZXRjX3NpICpzaSwgaW50IHNpX2lkeCwgaW50IHR5cGUsDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgaGFzaCkNCj4gew0KPiAgICAgICAgIC4u
Lg0KPiAgICAgICAgIGVuZXRjX3BvcnRfd3IoJnNpLT5odywgRU5FVENfUFNJVU1IRlIxKHNpX2lk
eCksDQo+ICAgICAgICAgICAgICAgICAgICAgICB1cHBlcl8zMl9iaXRzKGhhc2gpKTsNCj4gfQ0K
PiANCj4gU2luY2UgaGFzaCBpcyBhbiB1bnNpZ25lZCBsb25nLCB1cHBlcl8zMl9iaXRzKGhhc2gp
IHdpbGwgYWx3YXlzIGV2YWx1YXRlIHRvIDANCj4gb24gMzItYml0IHBsYXRmb3Jtcy4gSXMgdGhl
cmUgYSByaXNrIHRoYXQgYW55IHVuaWNhc3Qgb3IgbXVsdGljYXN0IE1BQw0KPiBhZGRyZXNzZXMg
dGhhdCBoYXNoIHRvIGJpdHMgMzItNjMgd2lsbCBiZSBzaWxlbnRseSBkcm9wcGVkIGJ5IHRoZSBo
YXJkd2FyZQ0KPiBmaWx0ZXI/DQoNCkxTMTAyOEEsIGkuTVg5NS85NCBhbmQgbGF0ZXIgaS5NWCBz
ZXJpZXMgYW5kIFMzMk43IGFyZSBhbGwgNjQtYml0IGFyY2hpdGVjdHVyZXMuDQpTbyB0aGlzIG5v
dCBhIHJlYWwgaXNzdWUuDQoNCg==

