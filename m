Return-Path: <netdev+bounces-292149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJbrI62hFmqBnwcAu9opvQ
	(envelope-from <netdev+bounces-292149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:47:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4015E09BF
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE8983007F46
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61C9393DE2;
	Wed, 27 May 2026 07:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B9U5iQzU"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC42F175A60;
	Wed, 27 May 2026 07:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779868074; cv=fail; b=QfizhIwZiy20KlBfzfDd/DkcscAr3z4PdzFF09LBDx2HgTnRyW5rDnizINoK2A/Q1a0/Juj9FjBFRlDni+gFOBGDbnwXFH8KDZgFWWPGlMf9x1Q9lUqxvqIWkJhP8/BKq/Z2+IpZf8S3IJZv+Ygo8JgnOtaA6SFC/hlXD5xhoao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779868074; c=relaxed/simple;
	bh=jvh9VDdqWpFT6aeBtSVqVfxq8+xIIJoRb9IDTL9nPoQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zez8CzJXiC0nPayrC+AHwCItY6DfrBQ9SW+ouKy2KP5jvOUOgOTf4jbM0S0W/b+EtjQnlQAm42u8UAdC9PC8QxON6I5qrX6ozdV2Ca0+903JiLQgCleuqxCq2FP1VuPpnFNTJ/7gflSYYNCkfGgmXLhJtsKVUnw2KnQsL6LbQrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B9U5iQzU; arc=fail smtp.client-ip=40.107.162.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deqiq8On+h1aF4NKB1kdLzN3w1FDjuSYyCtT8Fwhf4qqgDQU+XyPvqXdJT7BfdA16IOIus9gZuF4spqUAhyuPv1YRu/JVONxck5SVzGw6AlSs1aWTX7ZKkInwcR1B0FH9E7x1dYj3Yz6+ZA5qfyy/TSFlQ1Rmo2t9AqzlU7bD90/VzWr77ThhZzcIVE77HkwU8Pe/J/CuDsWE2De1KkQ0QQRvjh97Fu1qtWWO8nWjGCeHY9GW1OS94IXI3v5RhP6GFTfoAmj0uRSjtONHlvsuYjqas1KAcjeovrkc1RXZnPoyX+i/zjjk8E1m9GTh0iFkCfHxoBTazl9w+NaUo0Mow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgEFBCypAFuiMIa9OOHUwhkPRLzVgJHjR+mBBowSV58=;
 b=SW4dES9fD+cjndvp+fwj+kmauXYybaLsSjKi+RzczXpFxyUFh2ULRovx2y37MX4QC7lsKP75shUShaE5mIm7M45Z0+wh1g2EascuRzcRYZKLhzdjZvfds6h8foI634c63FDLlimErCPZ3AkTRbFc0rrOoMxKW7+GYNqdEs5ZJs8nJzZWwEIEO5ugWnqbbuwTt25jYubbAeiJcpgUUwl8ar6ABsMy3PUVuh4O/gmE0VtOz6HmykDhKzPCjqw2fFUIQB/ODEehJKvXDaPTUZ+jsnTpIKSHLXr4Ltca/8KbVwY8fYFMe+83+IcQSQKy1y6jMdopfEpHCXCTgO8+9ofPEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgEFBCypAFuiMIa9OOHUwhkPRLzVgJHjR+mBBowSV58=;
 b=B9U5iQzUHzfKBIeJU3dVIGh9kA9TpN6H5NngkaIvHsuAKCBm6x7HapwTr7vs5UhcF/Q6u00wASSL8RrLd6Lwlfbx9UoWbYRMgWE0NqHN0SP/MBf6BHL9ECu0W6og+pr/0WyLOJpJ336EMPsF25WCbZp0g+CBoiamWgJdTzUSgA4vpSL1Hkjz/LqcMK6PcFG1vcszpyBGLNKOYi2LFvuXS4P/+gi5v24Fkt10DW12q5bXhvJ/4RyIncgT7upTMoz9eTqJL6P2d3CdCV+VLLf5Fu9QE3miTAiXoEq9a8selAHes1oneGudMXW5V3DRo6fb6eyQcnIYxmnO0b7vDCS/Pg==
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by DB9PR04MB8300.eurprd04.prod.outlook.com (2603:10a6:10:243::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 07:47:47 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 07:47:47 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Frank Li <frank.li@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [PATCH v2] net: fec: fix pinctrl default state restore order on
 resume
Thread-Topic: [PATCH v2] net: fec: fix pinctrl default state restore order on
 resume
Thread-Index: AQHc7Y5CWXPIyB4KjECBTw15uia7NbYhchYw
Date: Wed, 27 May 2026 07:47:47 +0000
Message-ID:
 <DBBPR04MB75001DF6E52F4316085D551388082@DBBPR04MB7500.eurprd04.prod.outlook.com>
References:
 <20260527-b4-fec-resume-pinctrl-order-v2-1-293096f48703@vaisala.com>
In-Reply-To:
 <20260527-b4-fec-resume-pinctrl-order-v2-1-293096f48703@vaisala.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7500:EE_|DB9PR04MB8300:EE_
x-ms-office365-filtering-correlation-id: 904d8a7a-e044-496b-5289-08debbc43ebe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|38070700021|22082099003|18002099003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 U2BEEU4xSI+4UYavXThD1siyA6YuyPNBWYuYjc+kNU/1oH1MFWDCAJx4Lx2EB2mr91BBu7JX5HAfkTgVypGCzWLcbf7ARmSJ0pwjFwWMbbu2TSDgK8jb1vBtPZ0kheAieGiQhwk+bkcwgHiG/0H3IlwREOF/EBENbrmoXOOn3yk5G3Z6Mg36fOsiMQZoMlNORIAYsds6ar8PZdyv2WVjyk/se+rFAK1rTsHEVRplxAnDml0nmG0fc3EIl0j2qeJWETqYEmwMABstwODUxi0PCfXdMs6ETeSTNZ8XGIx2c0YrqTibIV8TNg4mmq8cW3jfGsVBhbVwPwJs9EHBA/f2koNUzwhJ2F20DZ//VpJwNC3TNdo02q+Flzh3RjNObptKb5M/iHh2FDlXIjODhEh+TxdZMd80HfNod912d/qHtKiC23QPi+EI4e3rtL4mebk4H3Z8CUT+dUgcJ1zxK/YBOSSZWA0hY3AoBruvus/3RrsNiCBqPDRPoEIp2QrPnrjpLJhVYXTGTN/mp7e9TRRU0CD4AQUyd4w2qDkOEfADg//+sutgWtPmbmS4Rt85IQ/UjHiuwdM5xGqq1gkgAz9yHR5R68hvTULR483w1Rf/FXD5pQ1vh30gTnW7t64nZh0uenXWIF1xu93M3V4MmYSIpe/g6ubi4Cd//9PYsV43GMeV6GdrVytDNKcV4+oMvdreNkbESX4/mHb756KJZYqL3Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rnZ0ZrMVtSp2OqbKmpTyCVPfr6E89K8nBxRqsnma2mU79l6aWZzfJ3ffurDn?=
 =?us-ascii?Q?MqjEqnTnQvj4qpz0JFo/iF1NCAucSRqIHmr+UbYcC2H8EY3moKFKheq0SZ19?=
 =?us-ascii?Q?rnqhmCHlSn3r+yQ3iQRlTJU1hFfGkDsMZyNhM1HZl4IcfMLnHR/fYKiq26Eu?=
 =?us-ascii?Q?SsdAZzuULuHIWDIdwvcdt2Sx7C8AxfXfv5LpvwA2zP7jXz+mdBSGx69mKXJa?=
 =?us-ascii?Q?LWaOV/vWQhOqyQCfpc3PhD4FLE1LHKt7Z1gLwe/NM5/Ew17CohcT147WYUCr?=
 =?us-ascii?Q?TT1TmJ9PGlWWmUGu0xCaDrbGh+uDi2qqh9EAD4GO1sBQZdlV0fAFvCUA1Em2?=
 =?us-ascii?Q?0+UQe/FEF2Wvf8X3gEobfbMcd4LZfOG87nRFV+kHMW0fQ9MMZ50WLt5iIU3t?=
 =?us-ascii?Q?lle4PN3t8mGsinNpjRIUnlfFpaZRUNJmGM9VVqHH+QvazwgSF3RN/GPdWeyJ?=
 =?us-ascii?Q?0RzMi4X3F6p2I1pRpuw3LQUgzLHuwfo25qqD4z+tR67YmFJVNKYQf8EdgidD?=
 =?us-ascii?Q?GF6Rx4KhNEV8l6sczYwhhPItLKjiDN8CVKTYmCfjxHt4IYWtmJ7L20sKCQPz?=
 =?us-ascii?Q?mVFKCiepWRFOkgVVv2E90Yb/ENhmgjN5hu9qZ+4NDBfgftBB/dg9MKANyK+B?=
 =?us-ascii?Q?/HE48CkcL3iyoSO2crXT+KSFQ0e4bTDaOyCKQFXWWgHDGXhf60vtXQQINVd/?=
 =?us-ascii?Q?KXYxUBK39UCu2NRzy3fJuhliaBOLigKL6VZhj5eigjvO2fgmp6/9ctijp7pf?=
 =?us-ascii?Q?3eN0S22Gw4kno64afgCxgDqzX0dfZIG6Lzfl1NwT8bgoXTB2uxKjGwuf6Atu?=
 =?us-ascii?Q?WqFeCgeYREkn1PUhWj+tSawjTTiQEeEdT+0WwNoQYG8qj/U2iB6rBk0w4KJY?=
 =?us-ascii?Q?XOuHVX9aCpHQzPqIAsjWg4uqjO5/lPZnhjre++LyEQr/e5yfEvkOJyNFAZ8Z?=
 =?us-ascii?Q?2NXl0MTt+JsGLzqqqMrLnq1gN+CYYTZcC15sUamUyvrNDDcNLvA2FGElGuzL?=
 =?us-ascii?Q?W91G4ObrMMMlLB5DswVfLXB9bqki1xRdyhzhRq5v/F96wtjKaNE3PBQNxQo2?=
 =?us-ascii?Q?GtAhLmdfuZ85IxbSpswPoQvFBMP8wADki6MeA6lg2/IBcbuWZxhQw7IQ35OD?=
 =?us-ascii?Q?uu3NyCsR/4PMKC98x56Vu0NOdb6hK0eBko3PsUve/NePAT+3xWvtDxm+G3gQ?=
 =?us-ascii?Q?k4oOMQsClO7AToRP2fl96f5SbqpOOL00Dk7w+lEObgSn2MyOf1yr08lzvuTs?=
 =?us-ascii?Q?rXgYFwewix2SXIxMgETDWMnP3zsdWrW7rOA2Wv+pmuQ0iTJWpSyqd57KGIkS?=
 =?us-ascii?Q?cMKZjElIUnRw2XYQizq1BL8wiewgJNuRCF8vGY6Eq9+o9r1SQms/tVw7I+zV?=
 =?us-ascii?Q?l7JxveQXclTNcTYt6LnNhFJFRwMfeLYTFF6GOxE+Pelo4iqw7K/X89yQTGJr?=
 =?us-ascii?Q?201FoDF8r6HeUXG1zdl5r+Kxdmz8EiwPsIPQuiGqlLf/Bv2/OcUXiK8G1jKA?=
 =?us-ascii?Q?jk4SGVYd3z53fYXRitjfnpLI+Ne71rQ4Dsa88qj4jnMmGObHqqdGMyDqmdxc?=
 =?us-ascii?Q?JXTQGy3YXBepoG1ZiUpeN3w8k1oiwVIqbpDbAQn738boNuzp4SEaP6RHcXAQ?=
 =?us-ascii?Q?2re/gtrDkziAkljfLOlPk/u2Z2tWuUcY82mXj4K5424FobjsYpAFXvm3KjD7?=
 =?us-ascii?Q?Ut1f7fMgGtcY77sOb+5Araluv5+I99xiMXc1fj0z5BDvFoSn?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 904d8a7a-e044-496b-5289-08debbc43ebe
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 07:47:47.2997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dHnQLQUWM69VccHS96eHMluWaTl8NubYJtjebaSHM1Cakvo2RCEdDUzXbZVMMsX3yLoFMvZy6kr2MqPKXE40uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8300
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292149-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:url]
X-Rspamd-Queue-Id: DF4015E09BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Please wait at least 24 hours before sending a revised version. Give review=
ers
enough time to provide feedback.
See https://elixir.bootlin.com/linux/v7.1-rc5/source/Documentation/process/=
maintainer-netdev.rst#L15

> @@ -5594,12 +5594,12 @@ static int fec_resume(struct device *dev)
>                 if (fep->rpm_active)
>                         pm_runtime_force_resume(dev);
>=20
> -               ret =3D fec_enet_clk_enable(ndev, true);
> -               if (ret) {
> -                       rtnl_unlock();
> -                       goto failed_clk;
> -               }
>                 if (fep->wol_flag & FEC_WOL_FLAG_ENABLE) {
> +                       ret =3D fec_enet_clk_enable(ndev, true);
> +                       if (ret) {
> +                               rtnl_unlock();
> +                               goto failed_clk;
> +                       }
>                         fec_enet_stop_mode(fep, false);
>                         if (fep->wake_irq) {
>                                 disable_irq_wake(fep->wake_irq);
> @@ -5612,6 +5612,11 @@ static int fec_resume(struct device *dev)
>                         fep->wol_flag &=3D ~FEC_WOL_FLAG_SLEEP_ON;
>                 } else {
>=20
> pinctrl_pm_select_default_state(&fep->pdev->dev);
> +                       ret =3D fec_enet_clk_enable(ndev, true);
> +                       if (ret) {
> +                               rtnl_unlock();
> +                               goto failed_clk;
> +                       }
>                 }

I think fec_enet_clk_enable() can be moved before fec_restart(), and there =
is
no need to call fec_enet_clk_enable() separately in the if...else... branch=
es.

Or move pinctrl_pm_select_default_state() before fec_enet_clk_enable(),
as shown below:

--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -5644,6 +5644,7 @@ static int fec_resume(struct device *dev)
                if (fep->rpm_active)
                        pm_runtime_force_resume(dev);

+               pinctrl_pm_select_default_state(&fep->pdev->dev);
                ret =3D fec_enet_clk_enable(ndev, true);
                if (ret) {
                        rtnl_unlock();

>                 fec_restart(ndev);
>                 netif_tx_lock_bh(ndev);


