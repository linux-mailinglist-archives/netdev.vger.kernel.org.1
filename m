Return-Path: <netdev+bounces-285585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFVCKZVO/Wm1aQAAu9opvQ
	(envelope-from <netdev+bounces-285585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 04:46:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E96304F0E9C
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 04:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E713300F9FC
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 02:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E1421A453;
	Fri,  8 May 2026 02:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="imXsrakc"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011046.outbound.protection.outlook.com [52.101.70.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962E2155757;
	Fri,  8 May 2026 02:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778208402; cv=fail; b=aIdVOgqI7sUbmisSptlgGcDrVHi8js0XdR7YQ65d3XDpqZIX1Zbp23JWPqQvKmzCcygwCYO9CEgjo6WI+Wg1JVlVyC/qJEJMsq12KOY3o+aG3QzbdDLfKVTpjAzyo6//E4+lU2y7SIXYfi1I7XrSGxmhloqAJNHbVI/7Hy7f2+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778208402; c=relaxed/simple;
	bh=0XYVpomz5GifiFKEwxuErgW3K8U905z7MuhJZpQT0sA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I5mSs6R6jfqSI87cf7ihOjxF6Yt1FSPbgYKDGHYKsNJVj+N5jayjtpfJjgm2AQmVzhbPnQ3BHU11NgKDx5ZKa9OoKmFBeYmssM65u6X05a1bJ2abKQhCqo53wIE0ZL3lbbwZ5upv28EDp0bJvVYYeLEQmSjKRdIQd2gaJz0RTVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=imXsrakc; arc=fail smtp.client-ip=52.101.70.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pe/Qs5RUTbMmF/uy3HCFeMIZR2ca48AfAiVSrpYuRttLt+9tO6o1l3ztR2MyfNK6EXZYp9+t1Tx9TdcJ/IZB7WVvyqIUf7hD/iIwMOVotmtbwmrmuqI2DEAYDC9RyvTI7uufonl2MyVU446HJRfoiiHi8eHdN09ioBRvMlHysGyh5e6lNeovf8kALKqpmTzOKZ9xgC9L2jwsnnxrF5uLKhYKgm0j6fI67h4kv1ZNVpvPR1MwOS4hWK/Y/wBRzrPMnqXR5ySYAhPF0PABZGeoh+cLBBUEQTtDloRDszg5p8aijNsqNzh+oQ/HJZ2wOlLX/BQPaypR++5Cli8+FKF5NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzBSorI8DJlvFga46QUPv4tnQQuOgsSCk7XFQY7kUUA=;
 b=GDdqoFCLWROK4ZZwZo/sUKH6MP5zpa6P0QE/lK6VsU41uQnXJMKoOe5n2khAw5B2MONTlqWdGA3RT+a1abhaZxiqd9qNcf3Ck2Szb/y40unLvfxvhZBFfl0MZFhMOehO5t2HPKaDPFMk2CGTADxkcylWESV161mHhV2Wqp1S1Ygyn5Z05mQpDyrXzB2opyR/0CGhC9DDnV/NehsyyPXpvKbxPQqESVWyMxxBX9UHiCR75rNcOw6qiCKzIhGXWPbdg+tVAl/iDDCUOZSy0LCBq2y+lkmLGRK8Ris/73Nf737bamWwbO/PR0Nxi3AQ3ix2TV0ThgtlLSXCOGDmZdeNVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzBSorI8DJlvFga46QUPv4tnQQuOgsSCk7XFQY7kUUA=;
 b=imXsrakc4cH9cpDHv8+M9qBBgsOrHMoDHbPf0ayZ4GAyaJfD+mk+ggBFJt/kXPcjwT2NHqQyLvwCu0etL52jBlxoPgM5wmUArpqMfqbVHM8FAtPnevy/tZTBTwcG8CU7DWCDMWLsXZD3npnj4+mRFtoKV6ncrRjOz3t0HgaAHlELAt3MKxp7X08YChIMI72AdmcES/Tm0SpFLhbKVEJyHfN34cK4ZApBlCFFQ1L7rxwPOShUPY01mc921fA9By8GUU/v52EwuWEp6g1AAx9C56YAfYWrG3zewU1pqa+kvwK+YsyYyMUGbAo5x2sAKcKulGYVPvv1WRlumXCoR7CNzg==
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AM7PR04MB7096.eurprd04.prod.outlook.com (2603:10a6:20b:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 02:46:38 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 02:46:38 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Greg Ungerer <gerg@kernel.org>, "linux-m68k@lists.linux-m68k.org"
	<linux-m68k@lists.linux-m68k.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"arnd@kernel.org" <arnd@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>,
	Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [RFC 1/4] net: fec: do not use readl()/writel() for ColdFire
Thread-Topic: [RFC 1/4] net: fec: do not use readl()/writel() for ColdFire
Thread-Index: AQHc3WSQFQftmBcNm0etAxstaTRQurYDaxsQ
Date: Fri, 8 May 2026 02:46:38 +0000
Message-ID:
 <DBBPR04MB750044F98B1E719AD9DBD93E883D2@DBBPR04MB7500.eurprd04.prod.outlook.com>
References: <20260506142644.3234270-2-gerg@kernel.org>
In-Reply-To: <20260506142644.3234270-2-gerg@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7500:EE_|AM7PR04MB7096:EE_
x-ms-office365-filtering-correlation-id: 8af19e3f-3b3c-4967-e3df-08deacac06ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 9dDarhdbAfys7/92IeVnsQbnycNBxMVkFJvfCWv9L4Rm4cnGsOWvgmbpxtvQQ8oSiyRVMbskvo9r4J/CQnsKZpcjKMKLrexn4o+CqqKl0j9Pv13MoFRjkD8cd+kmMtNF0nj5Aq3upgaTlBq1m7U8cbILAVXgK5XvOI/XOIOt5dxt5hnxWIHiqSZq71rPpie/TPnk9LmR2RMadS2h5BsdDGUbbC2MdjlSuITbm4ZTOPDyLcag60LZqFqR+BP8/rA/nD4kEokQJuARB/9+CM63C76+iaPrXxt7uao1KRw0t+/Gz53Uo4y/a8ICK1ybfA2EOn7eW2CRSfNBzclwaWYtcKcgzBpWO8JoKEZ6X/+k26QdENcVFHa4ERdgBjUnXROdU0RWFLSmK83evl1hYuy1Rx9WoyOmWdPsMN8w+HVdU81Au7WAPEHfgYquFgtSyCOSnXPtYW7i3pX+/YmlJ/hPCh91HRNgLspNrSyTpiNxpmd/f2dSx3MZZKi4rtMqMQWqCmNydkzbCqqQJKzDMoXpe1hC7pbuRMwMYv+dxKBYcx3uSHy7LKAttMU0A0UvbwA11aej1T87nHh1W3wB57MO7Ugyylp5RDvDaml8ONpNR2p+xq5QKfsTbZ0V/MKrWjCvru7zrk04a0fibCrcqJqDW9aVsQO5g2uDjzurM8+LhuaedaSL9xbzyMXNRceY/VuTvjB4mF4KZpvIh6DXh2HLiw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pDNyhnrLXBHHX65BWR3URWmf18C4ADnQcwKp2PrfuxxMPocWOC7Wf3H+1FE7?=
 =?us-ascii?Q?26lZQlC/TuQk2y+zLcQRvY4i9Kxr05kt9XqnBAE9VPMKfxw5xlie4MVF2gCG?=
 =?us-ascii?Q?noJ6dJVqhUeoK7z5ymcLc2fAegqa0VBdv9z7VSSaSMcPtHHyvcTy535/lwBp?=
 =?us-ascii?Q?6muifqOwla8IIeqNS9NWKrZGZnRwmcCozb7yQCuu84y/7qedioEYdnBTHZcN?=
 =?us-ascii?Q?I+aySbKEkxF1nfkwUlzZx63nh+zXm53548NVmH2TN5H0KMUzSt6P6cydl80K?=
 =?us-ascii?Q?6ci6OGvD45L+nFlX8hU6HZiB5r1SH7Tep3DgKo0nHeLwy8EiyJcUydgVpb/A?=
 =?us-ascii?Q?JAP1DCV0FZ/IZQjGSgWStQh0yPa/8ZezQiVeMLZc1stS3D38Gl/xDhomR9Ys?=
 =?us-ascii?Q?ypYFxrCV89blISqJE1A7DWok7VSl6ZVuNpb2ZxsB4WbF6QbUkd0mbQqjsrm4?=
 =?us-ascii?Q?kEw2Kwm93N4N3EL/qEKmkOPtPeHTshfnlgIa8madYnrPCfnFzGyCwyAAJfi9?=
 =?us-ascii?Q?0G02zSFuK78/Z69kk4hRmFmzQgF2EGs9zVuSlv7HleGmCe3Vx3I+mWe2uwcz?=
 =?us-ascii?Q?GWQu1sPtuw4EfwiRhqMFQxqtEDGVZVWWWCWZkjPYSEARSYznDK1+HlKiB+82?=
 =?us-ascii?Q?+pSSCVmASNTCxA/eKn7MZtLVzmpF6VXPy5rZ2e1L6owg7+y7JvdF9+E++GDJ?=
 =?us-ascii?Q?MZyCs006b0vLxT8zTIEGkWZVHkebpeeVq2llXKCDMKvHs7uMKFiUWgIS3imq?=
 =?us-ascii?Q?gwpkE/O37dk1xW7I7V1DahlL4NTQ8i1iN2e/AqFVnJhi7oR4M1F1AkXjYdD/?=
 =?us-ascii?Q?dzQVW3ePkOPCn0y5IthgJhPmoXPjBeVgv+hQABGmTp0U6Je9mrN/HW4pASE+?=
 =?us-ascii?Q?YxFURSaftnCzM1q4SrLRhIZ0RkhewLWb34l7nVFbd6R8sv3yHVcgc9MKVnu5?=
 =?us-ascii?Q?pa0NTlm/g5lUt+z3lLMDcq9QQ6CF66CARgLAt2/rMx2nYwoLYBd11yx1Vtdm?=
 =?us-ascii?Q?z0mXcr2vgRmx9a0n5cLoTVkKvuhYm/gHTa8SUhXu9QQOwCzZ1r40KDXa7e+a?=
 =?us-ascii?Q?1f3A1P1JAy3KLjxT7+8ox2YlrDEMFvO5U5Rrv730p2HBT0WgVjBCMIe7fM3E?=
 =?us-ascii?Q?boOYWv23FtwHiLfY9VgbYwW1cA+qqRpz/7ioFrB7IToE0EL42LyD8Lo2vbzl?=
 =?us-ascii?Q?ZLwbBbEYs1nMoJDkIsSpqCz520MpQ18gAOPCuEMOCqLH17wQQKExxKFeH/Dc?=
 =?us-ascii?Q?fogsTlfUtUnharnP/nXWhFowg30ejNEJwb7wwhgPOZBsF4ct++CK+pt/wH42?=
 =?us-ascii?Q?sc0B+S5/zB7bO30SdUwagyrYVHlLQ+sQIjY6zjoTZmztV5Yjaa6b7FCMR0ry?=
 =?us-ascii?Q?7yVm+MyJT3lCqxRL9PxVYflz56Z5x94cxDymeZdYYlm9pF2uj8p3koXViCQX?=
 =?us-ascii?Q?t+LUrudLvd8CwIM0vmCOZgHaOh0q4ospO754haqc2JeDPqYeht2vf+Xgo6N0?=
 =?us-ascii?Q?faOQK5byXLS5GTqJIxc+lCJFxY2K065BGlxGsCgxibT9L6xZfcvT/JD6RgWP?=
 =?us-ascii?Q?+ohaiekOuF4jXFEDoecbfWxc/Naj4psrvLV1dNqv/djVEBOn1XEiDq+MToZT?=
 =?us-ascii?Q?PuW3AyWSWQ8ltOS8f+hGnlrkqLeWxZkDx/9lNyHI18WRbgIiBJercTBJAN+H?=
 =?us-ascii?Q?M5bVYoYjgdOyD6ev6431ZsYt5MJAMkiRFTcQpJd6uwx1jynH?=
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
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af19e3f-3b3c-4967-e3df-08deacac06ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 02:46:38.3485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vW2XvlpoZAqplsKYyGaTuyxxIhoinYcYL4xBljSpzy0kN1jYS+YMYcQVpw552gdYtS8NPRwHyJx45HvFgWJNVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7096
X-Rspamd-Queue-Id: E96304F0E9C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285585-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,DBBPR04MB7500.eurprd04.prod.outlook.com:mid]
X-Rspamd-Action: no action

>  static void
>  fec_stop(struct net_device *ndev)
>  {
>  	struct fec_enet_private *fep =3D netdev_priv(ndev);
> -	u32 rmii_mode =3D readl(fep->hwp + FEC_R_CNTRL) & FEC_RCR_RMII;
> +	u32 rmii_mode =3D fec_readl(fep->hwp + FEC_R_CNTRL) & FEC_RCR_RMII;

This is not an issue, but since you changed this line, the new code should
follow the "reverse xmas tree" style.

See: https://elixir.bootlin.com/linux/v7.0.1/source/Documentation/process/m=
aintainer-netdev.rst#L380

>  	u32 val;
>=20
>  	/* We cannot expect a graceful transmit stop without link !!! */
>  	if (fep->link) {
> -		writel(1, fep->hwp + FEC_X_CNTRL); /* Graceful transmit stop */
> +		fec_writel(1, fep->hwp + FEC_X_CNTRL); /* Graceful transmit stop */
>  		udelay(10);
> -		if (!(readl(fep->hwp + FEC_IEVENT) & FEC_ENET_GRA))
> +		if (!(fec_readl(fep->hwp + FEC_IEVENT) & FEC_ENET_GRA))
>  			netdev_err(ndev, "Graceful transmit stop did not complete!\n");
>  	}
>=20


