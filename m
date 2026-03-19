Return-Path: <netdev+bounces-269280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONRkKrxmu2lVjgIAu9opvQ
	(envelope-from <netdev+bounces-269280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 04:00:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0AA2C53C7
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 04:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB90030620C1
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765BC3876B2;
	Thu, 19 Mar 2026 02:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M1RL/rqQ"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011031.outbound.protection.outlook.com [40.107.130.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C089E2C3251;
	Thu, 19 Mar 2026 02:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773889195; cv=fail; b=p7airfFc/gXkLCb5krpH+qFr5PFxDUbCYhcVEvPRBhTvU63isZplNDgCRZU5Gj8owtENOpdovaAKoo0vI+5aUhYTjoRo1cWR5RQODyV1lAIvxFNE8PUfsvKgM8V8yv8sOBdyT1XaRuLyE/2yCgd90WTqr/Hp8JUlTtUk+pmhLMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773889195; c=relaxed/simple;
	bh=Ii3KpD+1kosjQjhBmqi0sSjw/vXx5LJlCmZorDBA83k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DYBiZqezdJbSGCA26QlMIPM9jKoMHF5DDgFwHqMz30PEy6gLgzfN0Y63COON/QeFGHejs3i+aso9H1+5hyLLNYKz2CC9zMia4gknEkGeDxdCqa38Lj0UWBqVK+Vg5cDgQLHmV9KW8mTMwSUE0nKUBwSgRD271nO7Spak/m0Kp4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M1RL/rqQ; arc=fail smtp.client-ip=40.107.130.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7BWDGyhDsYe5BO2xZo9nxHfzhDExibIOZGdbE6aDSe0vVKCSsLTv4heXk5bZYZG4yj+xLl4fufHLNFI5jUkwV2RFLqwAas39RtdfMRy4/8mP7yTfYowS4PviGLjJP0pHAc8f3qqleeGbZqAjaP1TYR4QY/Ag+nCNAO07unoHrUB3B3OMBNNG8CLSHubuQtK1u3ACudaUPqWziJAETRp8n3vwa0K48NPrqpO851DtNEN2DfDCJAx52MZ8lwcO0OeaTGYoKUq/pfMfaEAZ9gtrjvS4h+0PaqT7H1Z6oIpx49Vm7R1OegTEAlk1Ni0UuRLErPa30ZP1+HmeeVkuUjHWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bJ7kA9ej++G09B/+8ohAipN9ABF8VWdt8S3XAnBics=;
 b=SiBfVUYvK7nis66K/Qs/N8D21NJKAnM2ZhzkAuiIb8lQLYR/UbHvTQutng2KkPrCSIrrsGNaU1cvODSm5ggzXx40/hSPISIvVR78cpZ55VDHR0p4SdBq8NM5CLEqjWcyy3OkaKNBjNu0osfHADlWyHfpG5TypQPqsyc7yBpDC0UtpZ0bTjdwOOzp00x9cVnkgVpYWkvkfSm4RFTvfr+jTH2PltfQ8LIiNz7zWvvzDH41a4PgGwCWtdn2VMdqZmlK11H6OPzxZtsuYmUPuVHnm/VZH8qMCRbg47jxAW0GfBb4zTMaRmgv0AJ3RCjJ7nxbHNM+3dmz6UrPN363Ng+BOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bJ7kA9ej++G09B/+8ohAipN9ABF8VWdt8S3XAnBics=;
 b=M1RL/rqQQOFRqNNcPwb3IFP1YSEJNQMKL7KOa1rdGVTzW0IpOV+fNDU995UAgTYyLsQOzYpuoGoadPSygo5jUPy8fV3XiwnUvUBtwZ+aM3czNFPDa0v6/clrT6IbfSVw9HpgrVGo4VL4WQBbE8mMqF6pbvwOYVQjcnbi/oq5nonBQluzOUvrSa03Cfx+798BZ88EyaZpEkYfiRdBX7Xg5i6QVTXNsCgyegiH3L4g+uPy8IE+ruZHqDQJOrnx95IyH7U9WNo5rfHslxu2vbCwrvyVynywNvIJSG16NohsengTIfKk76JY8RqPOoJl567d3e9hRDOAPqtqvinMXqdAiA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8318.eurprd04.prod.outlook.com (2603:10a6:102:1c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 02:59:49 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 02:59:45 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Simon Horman <horms@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, Frank Li <frank.li@nxp.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"kuba@kernel.org" <kuba@kernel.org>, "chleroy@kernel.org"
	<chleroy@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [net-next,12/14] net: dsa: netc: add more basic functions support
Thread-Topic: [net-next,12/14] net: dsa: netc: add more basic functions
 support
Thread-Index: AQHctub30hADsLC0r06uQJxn29cQ0LW1KBOQ
Date: Thu, 19 Mar 2026 02:59:45 +0000
Message-ID:
 <PAXPR04MB85109C928E024E0D2506CAA0884FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260316094152.1558671-13-wei.fang@nxp.com>
 <20260318144954.1893193-3-horms@kernel.org>
In-Reply-To: <20260318144954.1893193-3-horms@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAXPR04MB8318:EE_
x-ms-office365-filtering-correlation-id: 919dd5eb-5e02-4c94-4bd9-08de8563938e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|19092799006|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 W6ECTeLKtHbomk9dNutnCQB0JuKmiJhAfHIhAqlhZc7jlM+LCHs1lAcE2ydYp24oQnWM6euCoo3hd3mSpqs7rpSSFg8szefF1WZgVg/3W492CPjo/VUPHC2kA53F+VDZkYvZOss3XrgM7gb/diJ+LzgXCLPrgyU4RGyUDhUgMibpj3UqfnDrRaFcB6Yq6GyRaU7kPRxeNumNWDT/rWMGiFnOiCx/DeyPk94AKb+K/0f4m44KaQI5oool/2lLO1ARYpLeLFhDFDNSqQ0PSVmXJCzlAFw0cfEpOMCagFpYH1o7CZVO0ialTKoks0ag2TsGAvRPpdcQwsstByiezRapWSN9c/VXn+xtVDOM8HWWmPtPnl05J+w/iqKv1OaO1VVHrSMJ1p0cqi2BsrD+4Di5D2ydW71PXb/odYv/sMan6FzJxmOfNobURcUG2NTZl6Lgyv9nq5obMk5lxARr2f0ADAL337G13pk89wTtiJq/mKfNGaEO7a/V+LAhzKlFgOWUenWtMSGTVU0MEZ6dopIaXcYOR0AP/zEbESiZOiU7v4QqQjqV/utsxYfdxeqSXpTTHrx2OfDj4bhU6Ri01LO7j/SvSsT++MgxS2/JUVfTmzwonSCvlhTsbbgGqiJ6G1OyhL9QfVpNmIgM2QtM0AABQOOb/xlLyUAZ1Zn7VGkqQxkJ1de11oEVH/3ka07or3YthcLO/uf0ehuhBbWQ41wYbccTCPuQ8LSZYDBdpwQ7WSlvkKsmNt3DWv16XENzMPnJki+BWLaQX1y2G4fjKwIttNhLWQoYDbJUF93Yk4g3qKQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(19092799006)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HAm9xvCjliz0WXI2IFx0AFkPXigjRI2f0srK/9LaV0SD+Zcg8nBVae+P49X3?=
 =?us-ascii?Q?8f68JgszzcYqiXFJ/oi+ifuKWVQ5NGgKyzuwxC/7+fZlBKXmWSWuQwwTKZ8j?=
 =?us-ascii?Q?1PHEGJhRF7e5x2Qpit7NI9kWVuXktrK7w6H0EqYVCs/tLRMzsc3e0QIOhk4f?=
 =?us-ascii?Q?LFH7hDphNeIjZgt9kKFObL5JmuZZeqId3oaOWetRISwdhz1XW3g19gNj21wd?=
 =?us-ascii?Q?oswrf7Supc+SYYB3xn80vGyfZ/bvurp1DZSW239Y+y8IL1HKY6OlyoaSUkYM?=
 =?us-ascii?Q?AOIdUx2FYiUGBGbrQGdD/5clDX2kYyeFptQGMICcuM4QTAuow7Ksl0RCIsXV?=
 =?us-ascii?Q?4zqNBfNM7asuVpMUTOst5KBPJxRZxsmetJbhmv95iJERdfRO7JZoWe/Z7eYd?=
 =?us-ascii?Q?5rhu+Qk+TbjXNyhx4T+DwPH9ujx5Ig4jJXyhf9PJSDQb+QI/MsGajdNqku/m?=
 =?us-ascii?Q?4ni2f3aNFivxx+GBNW1AvFI5gMyuksGmvHZiD++UK1JU/kFH/0OoIVRruUmU?=
 =?us-ascii?Q?KFaIA4/gWE8id4radVhisVp3pU4ExNL1T/7MzbpHcDFuL4G61w/Pn2Odj/Zf?=
 =?us-ascii?Q?p+iyQXJk83PwokacKaXDcVU6laSeQkqIwUuQE1HwKb6FLLrNVzW3A+dlHFg3?=
 =?us-ascii?Q?qTKEjDme0DF8+qsbhXEJiZhx5unhAgovDE3PDKoVjCK8FKADD0HSWQpX1aZX?=
 =?us-ascii?Q?lVs0VpCymhr862iPwUIsxpyIumoxw1T7vAnmuwNxO1NJX5xva2x7FF5SpMgP?=
 =?us-ascii?Q?sS6cKLYAaUB1uA6zZYm8Wj1QLR1JSFx0EQUBD1M0Ch6CDr2h5M0xTbu/lLsc?=
 =?us-ascii?Q?tZuOTmJzUxW226qOwfDaneY0UiH4AtI2GxofVEZdGFkXSvNoNBvkla6NZ1dy?=
 =?us-ascii?Q?RtfSCstAgbsV7YyMFrU9FLts/4HG9M2u2vsueUfy3r+LVhJNMUq/58/Gtqop?=
 =?us-ascii?Q?u3OU08es8U9lHMj98Fzaeq+fj16h7+/iUQP0ebRDNRCOKtp39XzgCKlyXBmF?=
 =?us-ascii?Q?DTey/DOYuS4B+S8LpwBlRrqmZyvEB3NINnfluSbBGHlAU1GAUIDz07SWzpKZ?=
 =?us-ascii?Q?fLCEyK21LQ/L+NIKU0zNn+9RYRWTIdDtK7Ev8baMhF7PiP6vWZDY5QYOwl4d?=
 =?us-ascii?Q?NnznLRziRkLyPyA+Uly0l4e3CEhWqhAjPUyl8bwO3729GsB4eQkdEN+kzM6h?=
 =?us-ascii?Q?5eC75vFxHdQky2k5BFIhsXdxNMo06md7xIMQhM8AkvbolsFn2levmln01+iG?=
 =?us-ascii?Q?E9SIFLg5Eoaq3/GFsO65IwO5Ki60PDVUz09psq0snwA3J0L9FDyouG8pR8AJ?=
 =?us-ascii?Q?KqYK6MG0x7B9X1t9rCDc8sVye9Ru2Xyn7dosdXLf+eYp4Wv3UULgKzqf1H52?=
 =?us-ascii?Q?eeUG2t1aCGmLZJDtXOxjINtgVt6sbhdodTIPTHHvUJYYvqUO7AmbqwLTbmLW?=
 =?us-ascii?Q?Tx8DBFLGAyL/i+I0+xAZnQ0l/4yVRgfhaE94+vUz1UJGCkLTERSQ4KaQ1JMd?=
 =?us-ascii?Q?lJWgoX3MS9ozOQhNdnhz5qmqXHp2l/xtLIRJ6pjyBSH/DATHUzxvrn17d5dJ?=
 =?us-ascii?Q?KHZQjbNzzt+Rvgbnu5X/kbSgU5FO0J//E+KxlQKR0dwxBlQp/XbRVmgDAxAJ?=
 =?us-ascii?Q?SVqXL3rsVPkWzrOSe/oLnn79ewheKQw5ZKMpd0InIJxPnagLg4Z3snRlcd+X?=
 =?us-ascii?Q?voonxLspY4WKBFpANK5N5rhP7gv0qCTYWU9sTZR6UOo9XIko?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 919dd5eb-5e02-4c94-4bd9-08de8563938e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 02:59:45.5976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fWzbmKexZSu5NDNEs5ML2ufoS+Z2W/3YkgoULaT5U7uAOlv67JSmmn78L8zzDrQ/c0PhGe4/Dyx4acFQaNsKwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8318
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269280-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,nxp.com,vger.kernel.org,gmail.com,lists.linux.dev,google.com,davemloft.net,armlinux.org.uk,lunn.ch,lists.infradead.org,lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.946];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,PAXPR04MB8510.eurprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 0C0AA2C53C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > @@ -427,24 +658,57 @@ static int netc_setup(struct dsa_switch *ds)
> >  	if (err)
> >  		goto free_mdio_bus;
> >
> > +	INIT_HLIST_HEAD(&priv->fdb_list);
> > +	mutex_init(&priv->fdbt_lock);
> > +
> >  	netc_switch_fixed_config(priv);
> >
> >  	/* default setting for ports */
> >  	dsa_switch_for_each_available_port(dp, ds)
> >  		netc_port_default_config(priv->ports[dp->index]);
> >
> > +	err =3D netc_add_standalone_vlan_entry(priv);
> > +	if (err)
> > +		goto free_ntmp_user;
> > +
> > +	err =3D netc_add_standalone_fdb_bcast_entry(priv);
> > +	if (err)
> > +		goto free_ntmp_user;
> > +
> >  	return 0;
> >
> > +free_ntmp_user:
> > +	netc_free_ntmp_user(priv);
> >  free_mdio_bus:
> >  	netc_free_mdio_bus(priv);
> >
> >  	return err;
> >  }
>=20
> Does the error path handle the mutex properly?
>=20
> In netc_setup(), the mutex is initialized with mutex_init(&priv->fdbt_loc=
k).
> If netc_add_standalone_vlan_entry() or
> netc_add_standalone_fdb_bcast_entry()
> fails, the error path jumps to free_ntmp_user:
>=20
> drivers/net/dsa/netc/netc_main.c:netc_setup() {
> 	...
> 	INIT_HLIST_HEAD(&priv->fdb_list);
> 	mutex_init(&priv->fdbt_lock);
> 	...
> 	err =3D netc_add_standalone_vlan_entry(priv);
> 	if (err)
> 		goto free_ntmp_user;
>=20
> 	err =3D netc_add_standalone_fdb_bcast_entry(priv);
> 	if (err)
> 		goto free_ntmp_user;
>=20
> 	return 0;
>=20
> free_ntmp_user:
> 	netc_free_ntmp_user(priv);
> free_mdio_bus:
> 	netc_free_mdio_bus(priv);
>=20
> 	return err;
> }
>=20
> But netc_free_ntmp_user() and netc_free_mdio_bus() don't call
> mutex_destroy(&priv->fdbt_lock) to clean up the mutex.
>=20
> Looking at the normal teardown path in netc_teardown(), it calls
> netc_destroy_all_lists() which properly handles both the FDB list and
> mutex cleanup:
>=20
> drivers/net/dsa/netc/netc_main.c:netc_destroy_all_lists() {
> 	netc_destroy_fdb_list(priv);
> 	mutex_destroy(&priv->fdbt_lock);
> }
>=20
> drivers/net/dsa/netc/netc_main.c:netc_teardown() {
> 	struct netc_switch *priv =3D ds->priv;
>=20
> 	netc_destroy_all_lists(priv);
> 	netc_free_host_flood_rules(priv);
> 	netc_free_ntmp_user(priv);
> 	netc_free_mdio_bus(priv);
> }
>=20
> Should the error path in netc_setup() call netc_destroy_all_lists() befor=
e
> calling netc_free_ntmp_user()?

Yes, I will fix it.

>=20
> > @@ -595,6 +859,261 @@ static void netc_switch_get_ip_revision(struct
> netc_switch *priv)
> >  	priv->revision =3D val & IPBRR0_IP_REV;
> >  }
> >
> > +static void netc_destroy_all_lists(struct netc_switch *priv)
> > +{
> > +	netc_destroy_fdb_list(priv);
> > +	mutex_destroy(&priv->fdbt_lock);
> > +}
> > +
> > +static void netc_free_host_flood_rules(struct netc_switch *priv)
> > +{
> > +	struct dsa_port *dp;
> > +
> > +	dsa_switch_for_each_user_port(dp, priv->ds) {
> > +		struct netc_port *np =3D priv->ports[dp->index];
> > +
> > +		kfree(np->host_flood);
> > +		np->host_flood =3D NULL;
> > +	}
> > +}
>=20
> [Simon says: I think this is a false positive and the clean-up
>  suggestion is not needed in tear down]
>=20
> Does this properly clean up the hardware state?

No need to clear the hardware IPFT entry in tear down. Because PCIe FLR wil=
l
be performed when the switch is registered, it will reset hardware state. T=
he
driver only needs to free the memory to avoid memory leak.

>=20
> netc_free_host_flood_rules() just frees the host_flood memory and sets
> the pointer to NULL:
>=20
> drivers/net/dsa/netc/netc_main.c:netc_free_host_flood_rules() {
> 	struct dsa_port *dp;
>=20
> 	dsa_switch_for_each_user_port(dp, priv->ds) {
> 		struct netc_port *np =3D priv->ports[dp->index];
>=20
> 		kfree(np->host_flood);
> 		np->host_flood =3D NULL;
> 	}
> }
>=20
> But it doesn't delete the hardware IPFT entry or disable the PIPFCR regis=
ter.
>=20
> Compare with netc_port_remove_host_flood() which performs complete
> cleanup:
>=20
> drivers/net/dsa/netc/netc_main.c:netc_port_remove_host_flood() {
> 	struct netc_switch *priv =3D np->switch_priv;
>=20
> 	if (!np->host_flood)
> 		return;
>=20
> 	ntmp_ipft_delete_entry(&priv->ntmp, np->host_flood->entry_id);
> 	kfree(np->host_flood);
> 	np->host_flood =3D NULL;
> 	np->uc =3D false;
> 	np->mc =3D false;
> 	/* Disable ingress port filter table lookup */
> 	netc_port_wr(np, NETC_PIPFCR, 0);
> }
>=20
> In netc_teardown(), netc_free_host_flood_rules() is called before
> netc_free_ntmp_user(), so the NTMP command infrastructure is still
> operational at that point.
>=20
> Should netc_free_host_flood_rules() call netc_port_remove_host_flood(np)
> for each user port instead of directly calling kfree()?

