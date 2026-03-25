Return-Path: <netdev+bounces-271440-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AICEHgSRw2mCrgQAu9opvQ
	(envelope-from <netdev+bounces-271440-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:38:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B350320D00
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A975A3051AA7
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C846A371867;
	Wed, 25 Mar 2026 07:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fjhENj0+"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013007.outbound.protection.outlook.com [40.107.159.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F4B371045;
	Wed, 25 Mar 2026 07:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774424137; cv=fail; b=IsKpsaFnVbw62pMY3WD1PsrdsPSG53CQhUzxGDcKYYw/cs0wAF2dju/Wh4tkRA+4lJI07Wh1XRRghfmKBeVaHTYS7pHFXNvQYcPPuCxAoYk9r7FipH93vWvF3ZInikCUP2oZ8anQNr0JG4Z+HMzfD+t+73ThFFmB1DimqgoVo6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774424137; c=relaxed/simple;
	bh=lyED1Kthg98i9+YK7S2LGxM4d3OBueOEaobjeAnteug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tz2/oo4/piOewH73wC+7ufx5n3YA3VdjeAgpATQy4+kVtuPo/gG3hs9MalIyumawKIvrUkpv3fifXYjQKK8WqyDmK1359GzYNmN4cGwTfXq4qCZP//gO9a6kNh3Bku40O0SVOA7ZS9XfvXMoJx92+f30ZruwGfunllS96XlK1x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fjhENj0+; arc=fail smtp.client-ip=40.107.159.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmwo2dletuL7GrJdCZK4aHjzyp36yt4VJJ1v8EvHNNRaHw7K0nrhgaWKiKN8AKmDf2J3rnAD5Tly/+C9qqJTMVR4ugP4GhrNfDwNqqjPM5pbXCiDHpXYp0uiDXashjuxIUI8nqRGQR565rXKTPhRBIiERNtr6Ow7Ly9Ngq+FbqM9DqdMLMJpDG/7sFtVT9Krh9jfTkjEA8kKyNwCQJkAVl6bXTDCd78PzkU/rsk8c8IXnQyUXyThx4VV1YOf/NXCVk066kCMIJVLaKTz6up/T3J6VELS+Bgwl9tc0TZ3Ow1Fl0+8hlicIVnDO6e4ok1Z2ZLsHXd2zHMOzfRtqa+adg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyED1Kthg98i9+YK7S2LGxM4d3OBueOEaobjeAnteug=;
 b=Z7JZnjGpeIS9ibM67HzQ+as9UzzDaDXrvPqS/DXMSrJPjorn9DJr+zFcEqZVgNzGdDMe0hgYQWRY5K0kIZuhum5O3GkPVz862HK4B6wmEhvjGTT0cCOGssBnuvd8UKCJwJQEQKjyO/13sDPVP8FxKYg7nbDUCXKYxdzysmfMEpu0jIgoXTMmEp8e7BGXtDaV6GccOgHktN5AZNDt3i6YsGXiGMyX08I9tKnjrWF92JGAGbIqROT3/FS+sPn/QibaJ51QjJsGjUh2nXYLmik1NwQH5HMYlA+lcGxJ0inUJ6khSdaKzb5hp8RJu+Tnitk3s0+VaFBx881z1cnBqXjTvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyED1Kthg98i9+YK7S2LGxM4d3OBueOEaobjeAnteug=;
 b=fjhENj0+f7pfkDXDbTgqEGchklNApf1VLTp51YUHQ1YdZWP/r2oH8ADpzkohahzE4G6DiYYTJO6amT6bFKXyPuxAOzeMJHjXUvxzO+z6l9vpgn0il3uvYstwpPLnO8SaUKaa5YXxjjr4O8qmoDB2b+WEjhEaUPSxACKA061OcINo9p4rORZxfxNQQufO9S7b4TMJV/LF5HTVCQhRq+BEe7cVXCuv0FrSZedqAQoxPQEVZFtZRDmVdcXCgOhwWTy5Nbjfb4APu3s5jEIYKu4UAWVH+FYZEnxXwo6Wce3wXkMRrmd5mi4Gh0LjItqOGo7y0JvNNsl/dLbtDuA97PPY+w==
Received: from AM9PR04MB8382.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::11)
 by OSKPR04MB11463.eurprd04.prod.outlook.com (2603:10a6:e10:9c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 07:35:33 +0000
Received: from AM9PR04MB8382.eurprd04.prod.outlook.com
 ([fe80::f02b:c2a0:7fd:6d63]) by AM9PR04MB8382.eurprd04.prod.outlook.com
 ([fe80::f02b:c2a0:7fd:6d63%3]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 07:35:33 +0000
From: Clark Wang <xiaoning.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, Alexandru
 Marginean <alexandru.marginean@nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net 1/2] net: enetc: check whether the RSS algorithm is
 Toeplitz
Thread-Topic: [PATCH net 1/2] net: enetc: check whether the RSS algorithm is
 Toeplitz
Thread-Index: AQHcvCRNIB/UeW4UEUK4hlkZzKeYV7W+2z/A
Date: Wed, 25 Mar 2026 07:35:32 +0000
Message-ID:
 <AM9PR04MB83820EBFAEBA20F245703752F349A@AM9PR04MB8382.eurprd04.prod.outlook.com>
References: <20260325065647.2882997-1-wei.fang@nxp.com>
 <20260325065647.2882997-2-wei.fang@nxp.com>
In-Reply-To: <20260325065647.2882997-2-wei.fang@nxp.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8382:EE_|OSKPR04MB11463:EE_
x-ms-office365-filtering-correlation-id: 0250d881-f37a-48de-2a48-08de8a411901
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|19092799006|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 TvFkRT+fylBrIt1KikXsDEhqt3+eQ736/NAab4BeH1Yl/65p2COwis7cCzdGXuetCm51iLJ/RGbGyrh7S3OOJ67X4ns7vQ9F5r02cbNmKRzdJCgmPwvYXHKq6zzeh51NkH2l7tA/7wheR59elLE6O/y/4O1VZsHLq6sioj0M/fgDG6ssfUfbtMuOZigGzicPj7QLWRLiODqgB5c4Jf4/WqkyIax309RqXXuxfU4XQPXHQxjWqiygL73EnJsn3xfAxysm6/MDdDX7uTxtk6YPfcmZyUHoYQJI0XFRkAvBFWuShDgnqZi666YTQ2FSHM0msO/XhxjDiac/MfXVD9rQoB1dzsV7EKLIQ329SzivMZqHfzbix1V1l/TvU8CzpLMd2+xRAKoKPlLkWmR4V/GyJEUYnT+Fz1pxxG02nlMdfivICeRiT3ofGspQT17ki7PQVD5v+6CjuMu8NEN/McyEmitFB8dlYfFlhWQwENDrf7bF/x4ZrS0pMRGJ1KgaVJtdCdo6ks4mjbEx5dnWRGCj9+E57sM5zjfR31y2EVcGLAOhMpKPXoC8ASODPIwWdhquoKRTa1M/g9gJ2BJ3cVNHEAkvMTBDd+12qVPO1RANJCXS3050uMZ9gtRC2d1gizBSI02J5XJm0+4rCVNnoCd4vd/mRua/K431Qjy1qNMy1w22+NYZo32JHjC3EulMPnTGISVYAB6K4FRLH1cwelPl+GE2iHsURLs1XieT/1RUtUTf/k3D9jDmRoGYebNpa7Lwx5OKF47uLAMm/em+bkh8yN1uGJK5EaPmgjQ+O2ivuWI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pSdt2wxmP6KvnQ5b8YfO6HSg8HTS4U7O1V3ETsx1/qYeKSEHBOIv3UJv1Q9p?=
 =?us-ascii?Q?hzJ4xghxIC38rL2dM1TLdVGFzUdA+pbKTU/bquiMnw95IXwHgCSkNNCjXzXJ?=
 =?us-ascii?Q?3/mnbgJ12W+E305LOJIipkI0XFPgmOEZ+bDpZDBtmvami8axZ3NWVoZp40YI?=
 =?us-ascii?Q?y9htjfqdfH9vL0ezusvc9YlcywyyxdsFIo9AegcYk0OkIRDL8PPmYd/txmdY?=
 =?us-ascii?Q?bKQSC+8y7sHpVFaYsBOB5nsIOiJ6d7KJsgAQy1JBI+zRZgf6i5cPeU+H7R9Y?=
 =?us-ascii?Q?gBcELSN4gQS7DJSMjV15/kb7BaCieXlC2048NjLhLsRFXlM4SZ81uaqRS04r?=
 =?us-ascii?Q?xRN4PofsqP+UIqFdKJ7Doh9UPsVtDMjOug0XolSyW1bMMuohcXTSCjiDDtu4?=
 =?us-ascii?Q?SapAXpZeyZAKkLyB3EUAjIxOiB2eu/u12THf1VH1ZCMGy0yY3LS4MPgZsr61?=
 =?us-ascii?Q?4LDkYu1ecaWSqiAi1O/LDXfu/46QTNWtlf4CaTg3mZcLZYkJdHzbsn2jfzOj?=
 =?us-ascii?Q?pcfxyLAOrGjST3KnNlVsMt0LH2Y5wUAvWQHqg2e0IsLMe+S9Jm+DvWuvGSGv?=
 =?us-ascii?Q?BxOUa4CNuM+OAovPKQlyVzPlv5mfZScTgdIWK62yp8ymbHw/VhWzFmcPgO5H?=
 =?us-ascii?Q?I/Cla+56+Z+CJfdZsURAeauM2Fst0+PogiaRHClBC3H/yLpFz39ibZJ6scnI?=
 =?us-ascii?Q?8ztNkQlTFHg1Jwscu1qQilb7/qq8+e9LvSZRIcPm0oyscfryzHQRnYXRT2xd?=
 =?us-ascii?Q?gv52CnLORo3sF888FVroQ3J1Bdb7e7MSJMcBDUNC1ZEwK3oBrheX2cdEkeJJ?=
 =?us-ascii?Q?IFOsdUryQ3heu2VbWpsHrS3HBORaw1pz2jra19m75FiJdfbFA++HP5UZCaP/?=
 =?us-ascii?Q?1pbQ7y150uQeRfYKls2AkKuFyhtwdoVJcHAvSPLi85AveZET1ykvr607cH+h?=
 =?us-ascii?Q?onS71vutlwdr9qFeJlehuyQcm2V2woceKTEua0JvlcgOjZGDgZqBoviiZU9o?=
 =?us-ascii?Q?dm7gdBPsDZ3CYJLOhOFKsVBQZgG8plHCWiKfWAwsZvsulnqZD8NpdPyBfpXZ?=
 =?us-ascii?Q?r6Dv51/KexOySBipWdHFv0H09SmXq7OOEx++/+FQNODD2cQQtV0vCXdV6Bwe?=
 =?us-ascii?Q?5Us11N2TnIA1Tk02BqZWETTNiXQ/NKM9E9s0ZBWqvKI24Xp07sEsM5uKKyG1?=
 =?us-ascii?Q?Lz0xeSuo6GNdXHGg6p8TkdFCsYucZMWvpnOM3qhEtrv+seWO1IURy5dD2veW?=
 =?us-ascii?Q?Q2xvfMz4ghD/mQ5R8bF6DmTQ2AEKIEgmlVtUogPlzA8wTWAV8su8MMBcBeTz?=
 =?us-ascii?Q?ZswAL9NFRDhhurwC+S0oC2T0TnwxRPPPVNlBJhOvhAw0Yeto631pa3twIFST?=
 =?us-ascii?Q?2riihUGpUI/ntkaCn04p4T5WdYLWdAnlZaZ8myGgpVeUN4xAVAFb6jY1uZxV?=
 =?us-ascii?Q?Q3O2UWlvjOsmwLsSJ2ZG3XozuS+qhrIR6cBbbVN4XK/sPtFGlerCDS6crpG7?=
 =?us-ascii?Q?yOK3UJkSIeNpwj6CZ3yXy52vGUowq14hK9za6/iNV2Mg1IxYJbb7sgcpvAW5?=
 =?us-ascii?Q?Oc98llvVeGNlAwmXmrCy45zfECEE9I+02zAlGwFZykcfs1ENPKh6I41Z7+jf?=
 =?us-ascii?Q?rnUQZE3kBEHwWmZsDcXnD48cesI3qSOgKproyEoEf8r/1WuncyFtt4bqTTsg?=
 =?us-ascii?Q?EkSzwAddG1XFFv/CIZxctHovGXkBoe6XwKe8i1yQ+CJZ2slXPEBAoIequjzF?=
 =?us-ascii?Q?qVvrYVguMw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0250d881-f37a-48de-2a48-08de8a411901
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 07:35:33.0053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C7YQ1K2WhGxynce0bV/gvc+wQUu4qXzZiLD7N/x+VcWdRzFo4kgPnVkQ+sGyYZizubZLZHAqhI08gs8PvzWjjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11463
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271440-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiaoning.wang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[AM9PR04MB8382.eurprd04.prod.outlook.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: 7B350320D00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Both ENETC v1 and v4 only provide Toeplitz RSS support. This patch adds
> a validation check to reject attempts to configure other RSS algorithms,
> avoiding misleading configuration options for users.
>=20
> Fixes: d382563f541b ("enetc: Add RFS and RSS support")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>

