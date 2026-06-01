Return-Path: <netdev+bounces-293531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFN8NHj9HGoYUwkAu9opvQ
	(envelope-from <netdev+bounces-293531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 05:33:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 287F36193B3
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 05:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 394A33010BAB
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 03:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5904265CD9;
	Mon,  1 Jun 2026 03:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OCIYJBm3"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012019.outbound.protection.outlook.com [52.101.48.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334371C5F13;
	Mon,  1 Jun 2026 03:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780284789; cv=fail; b=GZiPiTbG5fa1BSMSNCv49rouRXc8i+03gmD5EF4QPjW3LZPw6/GcC/TVObmxPAUEng6vLVFLA3K/3rRV36ZPd6lwY9YnR4kJyMNh6Yzeep0Gfrxujs3RYKwZiY+nMaUYY6YxKpPyTruL+Y2TbDOTtHDlHhdGjmzYNOFuQfzBTSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780284789; c=relaxed/simple;
	bh=cGmJ57em/ONXR97G/s/gNtM2TV/DFquFRScWKkpHV8U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VPsMRM/0blh/pQ7gse6gUBp8Vebr6rfoqCAa3l0HelmPEe5tBrzZjyGo2mixp8X5GhjUvGvRcMrdalwNoLq8pyB1sla0oCJF//hi8h0qu3Bg/FG88geQJhODg6rhoy4YXp+SiDtCi1IlLTrGZynjvqKOhImy2xOSSQv5+0HqoP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OCIYJBm3; arc=fail smtp.client-ip=52.101.48.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/hveto1xCKu9V14yeM9UrqHZwxSww0gSerqNgLd3szkcJuYDSUH/WVGaRx1DfiZgtmVaxWd0ME/pgdfR5EhaRI0Jubw0yssVYR/HGsOgqDl6Xjcf4gOmpG9xZX+aU0mFTJm6WhamTVlQiQUd6N7RzIr693kFlGMdy6D8gJ2UwiYWF023vB467na1uHYN1Lu43BfLWon9DgyzHrwcJ4YYkVu1q0VfiMadi/FdmU8xW71hTKd98NzDFmkWebzXrUQu1P4zJrtM7cbPcAFcbA2sS1XTO82u4bWUSGgpoKzBHSNVVu+Cc7lxfKkou3er9Ph8mfpWA9w8ePp6KnPsvxndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jk6cLOErD/V2M6Oy+tNR8/SPVcHyS9Dy3ukMKmFsDl8=;
 b=f6nVFMiFQDEGDEdG7Quq0e5+9F9w1O7jLaH3BhDwS/ihe/ui2cEVp0vAuxRgxnnkvnlKORjhZHjTnqkG9liCNKHeOLN0cJ+vn8jQig7U25QyZRMkfHirMrbReZp+2C5l7CdZ4qRI9JCNREHsng0H1zhSYvh325ekgp0ifxQYeLVvEOikViGIfodHiR4skb6jprqsYOCchgL+JHA/ecyfCGHs+ey43NsfB2Q02q5d0ARfDcmeR0x8jJzl5mS1eOv1RoGcqtsMdlu57PLHmGzGK/1k0xd0FcA+po5egvDsg90vIg1cMhBgsonJGS7jemVF6ltEFE2GrT/y8bAVycLbbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jk6cLOErD/V2M6Oy+tNR8/SPVcHyS9Dy3ukMKmFsDl8=;
 b=OCIYJBm3YRQG0r560rc4sIAsEZ8dmWMXeVfUHdAyBcmuPtbeyo3RWaOKp+ODqxGZohmNV45lLu+7t9MD7TRfFx1VaD/BIXczPbuo9f8ybD6T4Y1FCh/SBqeCTJG8JL2E3e4VMo2BwrUBMlD4wLu3GSWhnwTanJtRKrl6Q0iJR6HOTGXfQoUDnSW2yJ7v59sqm0Tq0fVxLoeoD6cR6FnDyWLh5RGdoeMzEajw280dt7sV2hadqQw8sIWUhfN4n+uatBp1o153VBz9tmr2z0qct1qqpT5srX4Ytv6qmoWdtXn245d4RUe6hHDp8dZm9fXqAInyuRe5k/ZpHuxwgtWtrw==
Received: from DSWPR11MB9715.namprd11.prod.outlook.com (2603:10b6:8:355::17)
 by LV2PR11MB5997.namprd11.prod.outlook.com (2603:10b6:408:17f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 03:33:05 +0000
Received: from DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139]) by DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139%6]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 03:33:05 +0000
From: <Thangaraj.S@microchip.com>
To: <davthompson@nvidia.com>, <Bryan.Whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v2] net: lan743x: permit VLAN-tagged packets up to
 configured MTU
Thread-Topic: [PATCH net v2] net: lan743x: permit VLAN-tagged packets up to
 configured MTU
Thread-Index: AQHc766ckoPeqg0nH0utplhGKt8v47YpDptA
Date: Mon, 1 Jun 2026 03:33:05 +0000
Message-ID:
 <DSWPR11MB97159C9E7346B05485AC55D8EC152@DSWPR11MB9715.namprd11.prod.outlook.com>
References: <20260529210300.433135-1-davthompson@nvidia.com>
In-Reply-To: <20260529210300.433135-1-davthompson@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSWPR11MB9715:EE_|LV2PR11MB5997:EE_
x-ms-office365-filtering-correlation-id: dca29b5e-e132-41f0-2570-08debf8e7de5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info:
 83asy2CPrrutYImRFtHMHlbbIv2/cDDDSMLX79pUyHUkAslgyePyVJap3lM61myd7fHlEgxKSTMDiGZ2hrrycSDy9x2AsWh0crBfnF5HpYohgylhAkbzXzvjGciuY8pE73znyrLAj+Z+S0DKXsD5cnmn9gzFW8YC0uVQyvhnp77ykwGpypjg/Pl9NzdLMoi0aUjK+fOJS0BQJLLYNkDEmODIRmQaB3/NDtwhOpzLKhDhsE58E93Cidq1wciCraA5/QG1ez+x1W7NKgzy9R4C71Hu0Qr4slHWHBn//yLS/3ovcaxTODQtXi2gBOAaM0JYr3MpOI9WsuXY1UYq0I728aJrkc64CN+e+MbKl4a9C83C7UJRc8KOi+tm6oQ81WbIaAyc/R/0MvhK5ABaxbn/71ieJ2yOM7avhS1pQ8gAYXnC4mQ04ixiLuz/O0X8VcvyYj4UGi8WxqEVmnzKsZ9ntyQeq1FkSZuTFiM4+PdpCFLeri6tTjahO/ftqC1sUNvAQ40tuDy7vOvygXF7JCQCx/E7iQ+35BvG1ZUsaqxqw8BIhBnC+axfC9NavPRjRawnrKFn2rfxtFPz+OqwzK/mA/eecwbdAF02r0oX6G+YcO78LeI654XHsVw4qSMQEGqj2V1wJ8G3FRb3uidiJB1F8FUHMbi5B7RVwlHB21pEEh/bQcmdMsQHFrxW/vzOOqUmnJat+zIlHBxdWYgjxkoZMQltzGKvfy1PJcUXhd6xAWM5LZ7c5ssSpnb4u1qSUAiI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSWPR11MB9715.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MZ6mE2EAr2I5Tzxju+whHeCjJmKY1tPlG8yFFYUrE3iZ+dRpvIHa03JZO7fT?=
 =?us-ascii?Q?ck98uVuTINeAr0kmzBxM9BIL7+SdEOYPQrDwihsd4yQJRl+rnu+ZlrPHNYdz?=
 =?us-ascii?Q?kA1HQUWc3bJ/kmywToS3lw+cIw7xTv1uj1L8/CwKu+z5equkTTrAbSenWn+O?=
 =?us-ascii?Q?N5ZY77Alczwx2Gr7hAFnyVg4wbFtktsKeydHYC/GG4xvvd+pImsnWt68G07i?=
 =?us-ascii?Q?akRjY3d7zaTqLHNUuPcIr70U5xeqMUDHVjJ8qycirlPg28Qti0QQ/eAwH8cG?=
 =?us-ascii?Q?yLFbdsarjfyYAdiHL3MqcIYfk3oVpuRYYpt/wbSt1VInPbRtD1BG77ShyG3l?=
 =?us-ascii?Q?ekqUWlAjjiMl0lshImj84Fx4NscMjfpPgMVcoiGfF2X8IMZfH5tmzA14RgBr?=
 =?us-ascii?Q?5+2WGnCq27d+jppXurSwaUk29YK+/DUBT+HTVe6CTBxCKiZ/9fk5pnXH/X1R?=
 =?us-ascii?Q?QEE8yvYxr7aScA1EF5ejB8HonUBJv1FmiobdSsdlnhrXTAqgZg1XccOeBC1a?=
 =?us-ascii?Q?yEZ+sag3TEgmlH2J/IzmOXgcECWAkCpjLNAq3jIJYmRQ0yY3F0KtPFmJtuup?=
 =?us-ascii?Q?y31x8a4WHWGUnGUsmoCI1IE4Mvog9RaWx2otFd+/1eAzaDcG4CX4hnjX+eu5?=
 =?us-ascii?Q?YsWiEu24NyVG7jGFMsw+Ux2sObwAPDheiUF3A4/dRyWtLQ48mLQKo76CxpNd?=
 =?us-ascii?Q?gkZirZTu+E1XymT3VvsFRBMDC6MoqZOxmLMeBAwZZYWpaVV+SxYU+2xkM9j+?=
 =?us-ascii?Q?LhrorSVzI3OF7tPFa2+LHryQ+TEcLz0rQoFhvz10g7ECoZcUVbIrpbhNLTDm?=
 =?us-ascii?Q?PUVk8L8O0tqMoXECZpTEJj9r8NlAtsKK8CP1BuVC5OfPtukQCPaJSxnCmYY7?=
 =?us-ascii?Q?yKei9yBlMnyVzLLsIFTFldEUOR5oBFZiVHfmJW/bIrcuqeSHmVGI0omDThFS?=
 =?us-ascii?Q?IMbvmrV68kRu7TA7Ui9TBHOBhdQ2EvOJPGWYRfqrcqkSXYA8yrxQAhcenNiT?=
 =?us-ascii?Q?mc/5i+i0kedGN7kJAb7fY70iSxOdkud6+niR1tcKO0jOzLRg0Uk7/7YL6qOi?=
 =?us-ascii?Q?2L42O0xyMblx8jW7h3vs9ePSDzZzUnIlowC1pnGp607bunzqAwhYQU6k+Ys5?=
 =?us-ascii?Q?H5aca9Wq+JoowBdboRNZhjwUZPPTTrXVBRsSn6tPRsybwISVITeYes4oq9pB?=
 =?us-ascii?Q?2EiXSvs/jbLPGxENPUr6NoDpA74htO/bNgro0iBmE1/sutMsUuWrxbgNIaUc?=
 =?us-ascii?Q?8Pw3fey3acTR4XSK3EuCKkK3yhN6PcGuco9p14kUKPQMCGPAL2FTgZw+yRU7?=
 =?us-ascii?Q?MkcNNsHCDbRisSt2K7VXy9gylTmHPuYs59GQdR+XMprB7RmMWy7DnqC0T8QV?=
 =?us-ascii?Q?D8Gws9cheV8Aih1vcIut1lFwiThcAX1dhz5YPmFV+3LqYIdvR6fPBfnXfKt5?=
 =?us-ascii?Q?h8jYY2g//DGp6qo/lWd040HxvNk7skzkC7OkqWXK++ZEvwxlOgopMGfh4s5I?=
 =?us-ascii?Q?oxgVguCYlFI/niOWf3zxXvvxwNq70wKBaf01qkKzAvROkklCUTqkTRu7UASd?=
 =?us-ascii?Q?eSRSqty+ssYxzxRu1ejJmFGsR5aQABdHjyahcXyakSuqEFmQwI0lcXcUt8Ys?=
 =?us-ascii?Q?RS6q6Ld+RWMEyTCOswgck4DCvW+alSowB9Xy5PEUZiUp+xyyd/fDOeQ12/9g?=
 =?us-ascii?Q?O8dVYqooRapJf6AlPRYYzwfT2c1Amfh9ZBJqYt63pwYA20wQY1Z3dJxnc5p7?=
 =?us-ascii?Q?ECc0uqKZZQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dca29b5e-e132-41f0-2570-08debf8e7de5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 03:33:05.1174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qlFvy+JHEYE20ygtr0eQzBO9bMnr+4RUlMQf/7wECtJbD1wc4HLxzM3jDhvY/9X4kvpW4WqTpFyo4w9+5UMieyesPhbJLgpNQLvbOMLUzLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5997
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[Thangaraj.S@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	TAGGED_FROM(0.00)[bounces-293531-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,microchip.com:email,microchip.com:dkim,nvidia.com:email,davemloft.net:email]
X-Rspamd-Queue-Id: 287F36193B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: David Thompson <davthompson@nvidia.com>
> Sent: Saturday, May 30, 2026 2:33 AM
> To: Bryan Whitehead - C21958 <Bryan.Whitehead@microchip.com>;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; David Thompson
> <davthompson@nvidia.com>
> Subject: [PATCH net v2] net: lan743x: permit VLAN-tagged packets up to
> configured MTU
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> VLAN-tagged interfaces on lan743x devices were previously unreachable via
> SSH and failed to respond to large ping packets (e.g. "ping -s 1469" give=
n
> MTU=3D1500). In these scenarios, "ethtool -S" reports non-zero "RX Oversi=
ze
> Frame Errors". According to Microchip AN2948, the MAC_RX FSE (VLAN field
> size enforcement) bit determines whether frames with VLAN tags exceeding
> the base MTU plus tag length are discarded.
>=20
> The driver must set the MAC_RX.FSE bit before setting MAC_RX.RXEN to
> allow VLAN-tagged frames up to the interface MTU, preventing them from
> being treated as oversized. As a result, both the base and VLAN-tagged
> interfaces can use the same MTU without receive errors.
>=20
> Fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x driv=
er")
> Signed-off-by: David Thompson <davthompson@nvidia.com>

Reviewed-by: Thangaraj Samynathan <Thangaraj.s@microchip.com>
> ---
> v2:
> - Added helper function, lan743x_mac_rx_enable_fse(), to set FSE bit prop=
erly
> - Added explicit comment about use of distinct write cycle to set FSE bit
> - Moved setting of FSE from lan743x_mac_open() to lan743x_mac_init(),
> allowing FSE
>   bit to be set upon probe() path or suspend/resume path. This change fix=
es an
>   issue raised by Sashiko
> ---
>  drivers/net/ethernet/microchip/lan743x_main.c | 32 +++++++++++++++++++
> drivers/net/ethernet/microchip/lan743x_main.h |  1 +
>  2 files changed, 33 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c
> b/drivers/net/ethernet/microchip/lan743x_main.c
> index f3332417162e..ffac22883e49 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -1219,6 +1219,36 @@ static void lan743x_mac_set_address(struct
> lan743x_adapter *adapter,
>                    "MAC address set to %pM\n", addr);  }
>=20
> +static void lan743x_mac_rx_enable_fse(struct lan743x_adapter *adapter)
> +{
> +       u32 mac_rx;
> +       bool rxen;
> +
> +       mac_rx =3D lan743x_csr_read(adapter, MAC_RX);
> +       if (mac_rx & MAC_RX_FSE_)
> +               return;
> +
> +       rxen =3D mac_rx & MAC_RX_RXEN_;
> +       if (rxen) {
> +               mac_rx &=3D ~MAC_RX_RXEN_;
> +               lan743x_csr_write(adapter, MAC_RX, mac_rx);
> +               lan743x_csr_wait_for_bit(adapter, MAC_RX, MAC_RX_RXD_,
> +                                        1, 1000, 20000, 100);
> +       }
> +
> +       /* Per AN2948, hardware prevents modification of the FSE bit whil=
e the
> +        * MAC receiver is enabled (RXEN bit set). Use separate register =
write
> +        * to assert the FSE bit before enabling the RXEN bit in MAC_RX
> +        */
> +       mac_rx |=3D MAC_RX_FSE_;
> +       lan743x_csr_write(adapter, MAC_RX, mac_rx);
> +
> +       if (rxen) {
> +               mac_rx |=3D MAC_RX_RXEN_;
> +               lan743x_csr_write(adapter, MAC_RX, mac_rx);
> +       }
> +}
> +
>  static int lan743x_mac_init(struct lan743x_adapter *adapter)  {
>         bool mac_address_valid =3D true;
> @@ -1258,6 +1288,8 @@ static int lan743x_mac_init(struct lan743x_adapter
> *adapter)
>         lan743x_mac_set_address(adapter, adapter->mac_address);
>         eth_hw_addr_set(netdev, adapter->mac_address);
>=20
> +       lan743x_mac_rx_enable_fse(adapter);
> +
>         return 0;
>  }
>=20
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.h
> b/drivers/net/ethernet/microchip/lan743x_main.h
> index 160d94a7cee6..1573c8f9c993 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.h
> +++ b/drivers/net/ethernet/microchip/lan743x_main.h
> @@ -182,6 +182,7 @@
>  #define MAC_RX                         (0x104)
>  #define MAC_RX_MAX_SIZE_SHIFT_         (16)
>  #define MAC_RX_MAX_SIZE_MASK_          (0x3FFF0000)
> +#define MAC_RX_FSE_                    BIT(2)
>  #define MAC_RX_RXD_                    BIT(1)
>  #define MAC_RX_RXEN_                   BIT(0)
>=20
> --
> 2.43.0


