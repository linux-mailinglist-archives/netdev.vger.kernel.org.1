Return-Path: <netdev+bounces-269755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OE19NFmrvGmk1wIAu9opvQ
	(envelope-from <netdev+bounces-269755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 03:05:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCAB2D4FBE
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 03:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BD823103F4B
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 02:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFE52DB780;
	Fri, 20 Mar 2026 02:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ds+8iXN9"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010002.outbound.protection.outlook.com [52.101.69.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3722E3397;
	Fri, 20 Mar 2026 02:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773972163; cv=fail; b=l3XW8t6K3qOmnRzn8UOs3tOj7pfcUndHQixQ/DwSGF2Jjrk1QFXrLgXpvbpu1Tyt2UoQRN0SNoaiawpWhITUmNrE0kyAPTQr8nYAWaa2s1nncNwTzrkwpM7EADk8UOKgDBkNRkqnN6whUYNcw0qjCESNz/Oi45apzUnN6I2xkXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773972163; c=relaxed/simple;
	bh=4N+lI3FoGWTPaoBLByadd2N+DITNtuSviM5H5prv+lw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XuFkDm6ssTPpJLc1AsFKbgzRs7Xs500vE9JEtRfqlOAeK1Zw4SbHELu+qGrq+uy2/PaHPJ3VC7zB4/4ljU++U2Ap9Ao16TaRju+k/MheW2YbTanjXG1WGLd3jHktYmuwf74x0Y/F2hzrV5pUz4+F9pj1O9oKbKGQodW4rJCFlhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ds+8iXN9; arc=fail smtp.client-ip=52.101.69.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PcjmW6Ju4j0OfMmchviAyD7alL54Hnep71PDhDaozdUxo1jLaMgBTB4gLyjqLyEfFu1ihtcFU52Ur3W2VLjPiOVTLZ3thRAQRIXXwHOKsfoU1DfGbneYpP1nuUHIhagJrRsxFYpjS6V8C4Jeg9vHzSphP4PdxAu22r3y03ym+dFx16zSD5v/F/IbjaVjqrVOPhlQpuFMV0OpOM8J/Mv/j+wXjREMRdBdiO1gSm2gzGrbAVt5mUMaf1h/+ZCkBdEFZyPCTvDzPmOJA/KGqApaAQpsi4J5fbJ+QcgNTHFbw6dCI1LBHymfLupn5zFXEw6WrtxOzQwZoZ8kjS9HMAC3LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4N+lI3FoGWTPaoBLByadd2N+DITNtuSviM5H5prv+lw=;
 b=EygwmbHcjFDmZbyqaCnm0+AfKi5YhEkozA0aJSm+7RREKr0u5SGhshl+8RcrdWYkrcnhleL2Pj2146W0fUyvNfEAnQY1v6pU2vJ56m7cVyPnrQwUNfoHcJ/SRH3Pchu6uOC6m4yO6YW9hOnA5M1YF79NPwzleqVXw9TdW7SWdWduAqMEBmaL97ukT2Ff8JPO/sCagFOYyloajv3ItxJhx2tRu1qMyxYBGi24WwK1iHZmc/kNnXTGYwJR7C6vL8aWKgcSjZCsTEwxjHRhV2I1ByYIZWSDB9/QU+Hwhhx71uTSRzzQd3fZNj1ipAN6VgEkQg4iGrPcbsmOrE776PfVag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4N+lI3FoGWTPaoBLByadd2N+DITNtuSviM5H5prv+lw=;
 b=Ds+8iXN9U+kTI22M7m2PqfKHDmmdyvHADbPuAsgDfUJuDWHxFn3GdxQkqVhGElkgU4jQW6kWKM3w81UFhJnORaIZA6LHhnw5a2ljTd8x9jVgs7EOY1y8S8IJwGEOTBp5tIT5VZyaYL/fRLAysMa9LJPq5w5nCF8ff157TSK1QLOCoY7uFZurcdH33WR+GZ2Sn/TvM4xoG0irAlPV37rHs90Ammb1iddnIri+ONo2BqhQqI2GalC2BI9Kn+kHunxQfdf2wfGzQYc/GV8b31jrNPDYxsUlEs73oTh83SKZS+ukXj9sbJLWNgXX1xOEGunlv4UefEnKy/kRNBepJa6tig==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB9764.eurprd04.prod.outlook.com (2603:10a6:800:1d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 02:02:31 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 02:02:23 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net] net: enetc: fix the output issue of 'ethtool
 --show-ring'
Thread-Topic: [PATCH net] net: enetc: fix the output issue of 'ethtool
 --show-ring'
Thread-Index: AQHct3GI2Tnqm3/cYUG7kUqnP1dXP7W2Cj+AgACfzmA=
Date: Fri, 20 Mar 2026 02:02:23 +0000
Message-ID:
 <PAXPR04MB851042386A4154ABED31B3FA884CA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260319072716.511992-1-wei.fang@nxp.com>
 <20260319092223.799798a5@kernel.org>
In-Reply-To: <20260319092223.799798a5@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI1PR04MB9764:EE_
x-ms-office365-filtering-correlation-id: 52f34d1c-933a-4500-5698-08de8624ba58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|19092799006|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 Il0D3xygyV6OgKNOyCkF5BVBL3MPS+nvdrIf8NzSbeEvFe648BBV9TscbWRcSZg6eNoNFC+nVy3t0CyJmr+qXH0VWJuoq4lij6shja01C7y2pD7VuqBQGzH1XT4c2P3ADIpcaG4MP5PoICiw3Yv/pN65RupL6ahLIn1+yeWI1IM24K6vH1hxQBAWIWmnF5W4TpLxrw1NLO0DkhkIdgqqMy1VARGCFt44Ww9r2OYzQ0o8WQhTsLEMVslJAx4PH3KyiGlDUQ8apX3F48BPhe4CspSRU64IgCoYxanCddmjjuBaWomSHTg1duutxgaliqSZLmhGLTvsZ43CfS0V+wNXWZ6b0e/Omq1QKLl20dR/UDUnEC+cyt4DZSadq05cDYZA3L8IvhE7Bj2Mqx63U4W47uThFeFNAgdE6FbGO53bM1EHzB+ioelAWcViLdvrIJJHPFcqnlckUUSVws/gF8+QHmifbWRVSWVcU58qwyEyJeUVIXrhdcyftzd409vh1uB4mjs7SLjjFeeTEohlBCNiGhc5FVGI/ks0oBWA0VMeRxkWGEdanSrHp4fCSdMzoJwI6BsKakj4H/SsGZ3w4I2asSQyrqfEPS9JJpgph9vV6rJBt2ia6g19GelHOLT5zOGkw2uPd73tgWJpqu/FgxOAEQcKSJg7ghVXqpLVZSV4e0NUVYBTWlzS7gWnY+1j6SgM8eQc0ZZOBzngRO5eiOMzxwOLsNRdMM9tS0Tzl6jzBJAhzy94U+QMfxixYcB7P5ior0b5DJ/1mEH9zfAZ5c437jQmBdGq/c2cmsyLQ+YIA2I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?O1N7wMsWbGl1HzHNgmMb9x7ytejIehmaxorp+MPPzfSrjQ87JDAANhLOjwEJ?=
 =?us-ascii?Q?OZUmxEDm41YCXUVJlldK09nPhjNJhBBq0RVCfMfqG3d4pQ2hQkR1bVGew0FB?=
 =?us-ascii?Q?+niMCp/I4JQMPtqo/orrsIUASBaCawfjaVWNi9VcYKFOqpc4N88FsVl1iiz2?=
 =?us-ascii?Q?wlH2eggq82s8X5wwT1y1LtS6bHtBpuJtnlE+Hb7DyBaFwcWGVRfYdNYuFIkK?=
 =?us-ascii?Q?uHwW0Wvm0g1h7eqc3EEU+J0XV3dbB29ao7uDKBnfBPvnz91QRPoHlFAH1Lwq?=
 =?us-ascii?Q?HogOsgHyKf20Xllptqv7TTZjxmEMahXMud5iLBII++L0ZMbL1gaggbSS/DCC?=
 =?us-ascii?Q?MawijBY0MCHvn6mgLwaoCsNy8tKK2bV1dMuxCgexFwh98842c7hPkc5aHupj?=
 =?us-ascii?Q?H412Y+AQ2AcP6gIcWfjxJvzrsPgPA8dGtGi180KwXpQX819Xzb7zA8BjjWho?=
 =?us-ascii?Q?IhwUELbnj64FvOcnnlyEjTYDN9od2T9sjLL0mESxih3rPaOv0htzcFNrnTnu?=
 =?us-ascii?Q?otAdmR6NAASdxRIMc15IjJOOj2djv+F0qWknhjsIyDxFRUb/izdEEtUCxX8s?=
 =?us-ascii?Q?aBnKOW9qRxz7J3V+ypjMw5lInpETZP3bjdSWBeZbdPGK1NbysnXXynxL5+G5?=
 =?us-ascii?Q?VNyIzcsVjt4aB6jhT/sDm0iG6Zj1KzvR/+CG9R6ouaK1w0LpEETkDI96MWOI?=
 =?us-ascii?Q?G+bwxGjoioGdjuxVIaxfN2nRwyNinBKzB3Ni4fJb+DRkK8TskYIsC/xXRk98?=
 =?us-ascii?Q?Xc++ViqYkZ+7nmcrDUV6HVfDnKXtikDN6OI3TOGpZLYY9MA5CVF3stQRmxtj?=
 =?us-ascii?Q?3XKr4qXG+f14mIgHk/GM5yfv8YWATJEhtj1pfMV9aNMMLjvYSOgbAhwhW6tr?=
 =?us-ascii?Q?EsP2pM18Z03zeCBohKrmFzmWfw0CxxjpJr7YtMHnIqoTsbNlRR5H3b7sL2gU?=
 =?us-ascii?Q?O2t8BUoKPjtSBZH/Uu9gPXzTMONK+q8+5eGFGks5W4l/K8L3QTriji2gMaz3?=
 =?us-ascii?Q?wQwhJkzXzukfS5h4RqYuz3xJ5v1X7h8FoKi/F6rPi8/1YpfqvrG0gPV6CwLW?=
 =?us-ascii?Q?3yWQgIkbXvs1oki0clVCmoJ1uUi/1trIV27WR/qLdye7XvreDbHzAiNQIulS?=
 =?us-ascii?Q?CsfiW19C5mDNsYvxKS8w9uDYCJRYCaMef6VRSRumGs2E4A6UdRgmRL1OtS4H?=
 =?us-ascii?Q?xVzojJGoZIRFELU13H9qlL4H/+JX7KrEieoMQGDm+uv/vDmtSlp6v0JdC7Q5?=
 =?us-ascii?Q?4Tc6mdv+kv2DMaaSln2NplKitmnqW+MeU5uwvXCqbMFQc7gQNJ7z3UO5zBkl?=
 =?us-ascii?Q?ZJDDlYjdU0Z+WOjXBybLzyoTI9VnaDAfJiMz/eujUZ2li0llidvHWVs4so7G?=
 =?us-ascii?Q?n+DFfvh6+UdOcX5n3oYJb/nzg/OBMit9kFKJy+om9ndXhXKNgqZhVddXmI6S?=
 =?us-ascii?Q?X9Yrn45AaovHlaFakYVlxd47LX62NoXBox//Yyj8G/7jlpzU6Adme3v+dTpt?=
 =?us-ascii?Q?RxsmSYRX2uMhRZ9apLhMyn5gZUV/OP54xbPVQBPZ7PLJkhzenl9W0suP/Srp?=
 =?us-ascii?Q?9obQY54YHGUHgjvkL2/OEWUA5E3gkCC0sEuwbYrzBRbPKOivIpHHTcPzbU26?=
 =?us-ascii?Q?Zy1NFvn+T07AL9efu9nUbI8cflum4YqVMNmvLubCkDn1lg0ouuofrrTQ5yW0?=
 =?us-ascii?Q?N5fHVwHfQQKD+h6DnyqgQjb3R//9/IHtFMb2v45887rD3QaJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f34d1c-933a-4500-5698-08de8624ba58
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 02:02:23.6027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6zJr0d1ieFQG3B9MoPHI6Yjg0+1bHUAdH7vqtNzawkabaDmosXMScQGYk3QpQD0qzjrw7J0eoKgoCmU82qfb3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9764
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269755-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	NEURAL_HAM(-0.00)[-0.979];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[PAXPR04MB8510.eurprd04.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: CCCAB2D4FBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Thu, 19 Mar 2026 15:27:16 +0800 Wei Fang wrote:
> > Currently, enetc_get_ringparam() only provides rx_pending and tx_pendin=
g,
> > but 'ethtool --show-ring' no longer displays these fields. Because the
> > ringparam retrieval path has moved to the new netlink interface, where
> > rings_fill_reply() emits rx_pending/tx_pending only if the correspondin=
g
> > rx_max_pending/tx_max_pending values are non-zero. So rx_max_pending
> and
> > tx_max_pending to are added to enetc_get_ringparam() to fix the issue.
>=20
> Why set it to 64k vs priv->*x_bd_count ?
> There's not set_ringparam so user can't actually change the value,
> wouldn't setting max to 64k give user the impression they can increase
> the size?

I thought that *x_max_pending represents the hardware's capabilities. You
are right, we don't currently support set_ringparam(), which might cause
confusion for users. I will change them to priv->*x_bd_count and state this
in the commit message, thanks.


