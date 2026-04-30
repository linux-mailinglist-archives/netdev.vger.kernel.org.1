Return-Path: <netdev+bounces-282591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AF4AWS18mmUtgEAu9opvQ
	(envelope-from <netdev+bounces-282591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:50:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 589D549C1B2
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF887300C035
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB0E28150F;
	Thu, 30 Apr 2026 01:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HbUL9ocB"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010039.outbound.protection.outlook.com [52.101.69.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856352765FF;
	Thu, 30 Apr 2026 01:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777513809; cv=fail; b=O4zjqKS8cBrr/TIAJ1hZLp+8A/vXK0w0d6uB4yKU1HMbddHm0URgN7xYSGoPEuVyq/NtERd/smsyiOEPbMSgGry7c+NzUnPtNSttCBk3/M/deCxDHQTe66TZrkv7n4YQUlVfZPH0VOtAk60mPH67qIOULWwyddF49j1npSvXAbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777513809; c=relaxed/simple;
	bh=fSGBArnYoW9ZD3VSvj2BndTDbKVvvoS7TtQm72HqR8Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TUh/voEVOvGNxeGv4EOQJCZzqEh7EGeBc2t+1NbhZhprgajY/J9ElK+nyzVYrjvmE0vpc71BhXsNsaqQE8iKgz/1db4b8ylDW0AuYU5pY/fnvRwq5+UZGLmjv5b40eFkAMsjNBn6ouWVEl8wm9B7ZsnxnBSrh9cSvzS+zSRF7mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HbUL9ocB; arc=fail smtp.client-ip=52.101.69.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYBTTmiAqJwY+G4tPckJo9Za1zZOAXFinc6/KL6f25fvg5JgcCWj7vs2wdp1008dSKZNEKu5RYam/Q49eOIUxa7lSAXgzU5MnYz4DvTvB0IR9bZZclQ/A26ggGLNssxxTGb2AGrR+kwWxfpOctmXCvGRSO/y9Oc38IzUN0SDPg/+dnm6vcjnOeVb2T2AUmESwNprX6jfmr+uRGc7K8iFrXP8YoMi6XWObxX64aGLEAfCPypBwXd2UUTJRJ+2/WAarF7al6QT1Yg6/K84RDgxtc2UqjN4FjagYWaMZyeVdpYBlYn9JjIa5fyeT8wRproG9VSxgYq4BUPZK8w5ReTF3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4xFWTKiTMp6hxwDbsPyRvxFIhA1pOaxWGU2DHG1R+E=;
 b=YzgMWaLCxNQbqNBafFFkR48JSYWntxUzOfODXD10xibq/7bXapxulnOA78BMjZkuJmpaHpgix9HiXaSsbjuIeSGhzNvD76ydP3cZBsAS919RvPc9VntVk8kBZq7x1U9RY3nttLR5FABu1RasnTsFJqlEm5p3zKkRQqJkDUWrDSr6zMOnP4D/VPdofy7p2vCHJKvWrNWu/tIw5B+FLnpetZlKlfvD+V4d5M442Ktn5ROLAyc41KTWCPbPSpOKk/ljvodLggPXG04fbkzYsN5Ya5StUeEk/XpF56/V2FQNlVUZAQ3xiQXAxe7NS+dns/sUfn6977JJ8zq+E3agt0DiYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4xFWTKiTMp6hxwDbsPyRvxFIhA1pOaxWGU2DHG1R+E=;
 b=HbUL9ocBUGWVFQIx7TCrYzD0Cl+2X0lSgSbN83qQRGErp2sK7xgVg5EuoS9w37Z9AIGY5m9XXEXLz/ciCEQ27g3cMSC+33eR84nW0BzzQBGCotBrMUrOgg1Qd4Q9SyeHKtQyKRHWDuu7/Lk+/4rCtrxIL8nxEGy7kVItJfcL3XOaRykaVev6wA+7RHe3ODj86ATOBQy+RKlDwYzqlWEAwn3xqycDQyf14CknXKVL8O0+eIY1f1KxMmP8jZ1JjtrxtFjq/rKa5mMHPBuUDwUwM/WO07OKAgAAIMNzSf0babKlxPak036yxLxI4HUbdc7OqS0A5oQ5s3bg9oguSU2t6w==
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AS1PR04MB9654.eurprd04.prod.outlook.com (2603:10a6:20b:476::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 01:50:02 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 01:50:01 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v2 net] net: enetc: fix VSI mailbox timeout handling and
 DMA lifecycle
Thread-Topic: [PATCH v2 net] net: enetc: fix VSI mailbox timeout handling and
 DMA lifecycle
Thread-Index: AQHc1thLiLwwm6j7SEuRJk/sDV13p7X2y3YAgAANZ2A=
Date: Thu, 30 Apr 2026 01:50:01 +0000
Message-ID:
 <DBBPR04MB7500FCEA54A182D85A996E6A88352@DBBPR04MB7500.eurprd04.prod.outlook.com>
References: <20260428063111.2869408-1-wei.fang@nxp.com>
 <20260430005919.2320380-2-kuba@kernel.org>
In-Reply-To: <20260430005919.2320380-2-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7500:EE_|AS1PR04MB9654:EE_
x-ms-office365-filtering-correlation-id: caad7311-999b-4bc7-3948-08dea65acb1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 TxtfsMVNqS9XCjbvEpwyreygcYWmyUVkbIKOIJg7hfMjgYulVM+GtvzjxpXedK/HLG8Ft1chetWTaEfMX3vjmjQgAKEZIG8n3+96ThBzQ/2rOImv+1D79zyim5szeT+3xGXDF9PK2yDurAmrMqAmOtR/GmEzfrmqT85Peb867xzTz/L3WTjgG96CToFOIK2oXuBaf9YxtPhFJRdhkKqddSF5ULAXyuoa82x0djZsQkFQPWbuYaIsqNbUSlpBL0VMWGKnGhfK5CbbdASOq/8jk3+nZa8L1XUTOPzJ+ulU7geZ1FKJCdoF7sTEUt93IwtA0nhhDLZ7wZeJugBPZXEc1QcxPuToxbUAo+tJhoBBU7OtxDFhmAW0AiLAuT9QFKSXX4dQwGZYSrVmEtDPs3xre2pgY02WHiLuKdF1gZTRVofY/xpA91taLn861lEG/C78u6LQO0MpEFYM9mIU14RuyXIKM3Rd6eS5QV5xg4IXutRb6P468WDHjS00dMWuHzJdxhYZ/cYUZfMg3+Ah37oY6qOTLLU4/RzbdHfB3OOP3H+Dkq2q5NIeKbVKiE0aO4KgJ1EXFpCZb3Eg/61USMI7uVnQGFLeMtov+uUX94Omkp5MvObFbpMoUU888SkYL2Nbfb90We2mJQZQtM68nHlwERY0jTUE0ZpI8TAukGAI3jqjB28KFiV2m21Jp0yMfnvDEWOCvcJd1NksxSIVf/NkczLEFC7sRVKXTmj98uEQh4GJBP8Wss8NAqpmr8q/qRh5ldJGWBqT8bRerKd003Je3ZYc1mTHQ40IrJTdMQ8iqRw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QDcRFE1KqupD+3pSDuBeoViOvP8ybWjgVT8ySjualLnoWPcJ9lAaZb/ScNIe?=
 =?us-ascii?Q?aXst+4Jt3COb17jCqBsTjwSCGPbBlfZWGr1QAQ5cE4gKXvSWYtqMEiJNsdQt?=
 =?us-ascii?Q?cDhYAZCeeojlOAyPouuaQphAx3G8YsDgvhJ912aMwF/kqcDYPkjfcEkf/JFj?=
 =?us-ascii?Q?t0BnhiiLsKJ+Xy1k0U9kZR3oJzKeZvEgRDVpAIPkreVq0jbIAw0/5fZhhpbQ?=
 =?us-ascii?Q?DgLr6gcUkPqPhrNJA9VO16kSWyTUq5RP/SPR3kWmaEyX3XN2RZfVvpw/Ag5J?=
 =?us-ascii?Q?SgtSpMNe2rlCE0u9ZsB+rnsgy2WwVKliD/5ndMWOTPquZ5Abg49JH/nIcNll?=
 =?us-ascii?Q?h9+Z/uoJyUFBpeDlMiSUrXaGEc6h7zqVV7jH675aC0k5SyOcyTsrgrJajbJi?=
 =?us-ascii?Q?HBMoBIzt0Jp6AG5lHE3dtlf9ZNxcPzCNyyboQZsebjMjiQVhCFP5veM1zywq?=
 =?us-ascii?Q?rX8FG0OeyxthPtywqzZR/WK5rV/SMBpmaOXaneR4kGZD+9lSSLJevWzwAKaP?=
 =?us-ascii?Q?8txXvnX9CpKsBnhs+2iWgwLTLbgc2WIF1OjlE3DWzTPMTNsVopJ8W/8ZWG25?=
 =?us-ascii?Q?hmcQYYKxOkkFUYbNeevmbTMuwpyGrFwrsUgf52YDEQ5Zg499nk/RLFY+b34T?=
 =?us-ascii?Q?u5YrdefTn+gwfxxBY5nR3sEqf0tYUabe5ieZKJj2ek7afGKsuJgSB/nA8rHN?=
 =?us-ascii?Q?HWh4G98p4+cOuuuiZjVZeCpUXbhX+oxpPzbltingtABh8Y37oJBI4O2IOZ6O?=
 =?us-ascii?Q?yJkEWFWz3ZuNsDI7wxM70sgNFDjKwRfM6+4z84HkmkATLKbA57QyYwUn/zqk?=
 =?us-ascii?Q?i1zg/KiiqFYWiCGGaBq5pHTsap8m16gn9LE/z3ALG6ET6HrrD1Wfl2vZPm/M?=
 =?us-ascii?Q?SD4UDjAkKhagZWN+ZbMdxBVvoul4JhBU3Xc8hH+hhXZSgu9KzIWtMMcm22Vg?=
 =?us-ascii?Q?AzQDcl7y84mDdUZm1YDUgjAuo1J12ytMo8s6V1/K4OBohnH5yhFuWrw1jaHU?=
 =?us-ascii?Q?RusG1z/NpqgqVP9Esh7fjLL0WFbio94EfN/IbaoCJgF8m17gguwdFeCzIszt?=
 =?us-ascii?Q?sMYL24Nd72DkJzvFXO0/Zqk0Z5/3ot6BVqdPWLXWuutfnRyVHXSD2Wgp8XlS?=
 =?us-ascii?Q?P3UuiZRtNl4gbRBgMxEtA29fUme07WQAiFtwtzRmHjHszqyfFuAQlZsr5sGw?=
 =?us-ascii?Q?JR7XrhLT4/2D5z5jwwBypax3lTLWF6Mw7s2JNHo3EjlX3101oAJAc6Iuvq2E?=
 =?us-ascii?Q?5YqS9nZcTqZLstjVv0gWO8aMFcCFsYG2KAcWMjwp/rjXVXNY4Qhh7kwzd0qV?=
 =?us-ascii?Q?/dJBO4TI477h/m+qOR7RNM7nsD3iAUAe54HkKa7Qy9smZloZK0ypQhtKOzE7?=
 =?us-ascii?Q?qGxCj2iFqEJksPr1vgr70uv4UzBYjrn/A+/gtRtrHv0+Ny/FzhPEQGsVldor?=
 =?us-ascii?Q?47+YlgB/0qclDHOPAShPYviuEQKkJNAbNjJILjcFqtaxcRl/99pdBJzKcHa5?=
 =?us-ascii?Q?FTe1/zacXLYt0jQoKjP+KFR9obs0STIzkmhV7VcDmiOhxr9z3hojE4bM1cxY?=
 =?us-ascii?Q?A5NVAZRS/D8zxjo0Q3inyr2MuunyAQGeVDg3DwFYMZRbMm37zH7xhyAwn92M?=
 =?us-ascii?Q?teAFqZ6ZCeXwIl4Jk32V09BGntpiGj70aLgnD+ev1/DTlbzZHwNHxh8BB1so?=
 =?us-ascii?Q?19LTaqh+cHUjh0JnEZggbshINszmkvn2R68wz2e6NMnXG36e?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: caad7311-999b-4bc7-3948-08dea65acb1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 01:50:01.8084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MTuvzqz9yI7wTCZTuCClIuf5vOyB1KxcVm4Lvk9EodNTQc2S3jWMSO3ET4qM+tr8egM7x69ihT4qZ5K7nkibSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9654
X-Rspamd-Queue-Id: 589D549C1B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282591-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim]

> > @@ -258,6 +281,7 @@ static int enetc_vf_probe(struct pci_dev *pdev,
> >  static void enetc_vf_remove(struct pci_dev *pdev)
> >  {
> >  	struct enetc_si *si =3D pci_get_drvdata(pdev);
> > +	struct enetc_msg_swbd msg =3D si->msg;
> >  	struct enetc_ndev_priv *priv;
> >
> >  	priv =3D netdev_priv(si->ndev);
> >  	unregister_netdev(si->ndev);
>=20
> Is there a race between this local copy of si->msg and a concurrent
> ndo callback?

Yes, it is a risk. I noticed this warning from patchwork so I sent v3 yeste=
rday.


