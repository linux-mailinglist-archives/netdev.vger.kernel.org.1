Return-Path: <netdev+bounces-297625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fn1YFFJCKWqbTAMAu9opvQ
	(envelope-from <netdev+bounces-297625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:54:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C319668776
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:54:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=jVQGZRHP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297625-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297625-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EE283073968
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED253DD50D;
	Wed, 10 Jun 2026 10:53:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012055.outbound.protection.outlook.com [52.101.66.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388FC3D75B8
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 10:53:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088830; cv=fail; b=gwj8pJjPYy+/D6BTpdFSGlS8wahADW0XNjtQujvBOJDzPOAEdCNKJE9bYqHm/HZTEd2AOtNVztTEMW10xr1erN+pKIb9msrZbaySWOViK0eZYgIMDcGMLY6uUmn1VtiVBdynh/mEyh3o9393W+jMhMUVKBRlpdPJjw3W15tc1gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088830; c=relaxed/simple;
	bh=fTKsSs9UvIO/R1vgIMPySjsGFfKkDFNFDQpAsjnmLFE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ddFyW1J8wdOHv5BvYJHVMtGmfLHxEiNCaAKqgC0O2+tolKKKySH+7Rn2wOD0SoREpLXTeK3fFephFmzYYDJUVA+pWz/kiuj+YF48drAD23ehtXX6sxGZs86w+5m8s1xj/zawbwFIzb2G5LTyYKa7GDT89UIy5GGQ/B13gJ42gkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jVQGZRHP; arc=fail smtp.client-ip=52.101.66.55
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMQM6XE1j4ExrGmbzco6A4HMXVWZoI7K5vsfNRqj8B6yMGqUHA8s9hpw9VK6muof68Q2RBrMW5qglGAzDkCfeiOn/292szapxLSK2iZkjAI6OAEM/NcIq7XsVQbpoCTNv4PC+15ZxC0TxVGXkGwWZEtURmWRI5c/mIXbMnW1ky+LtsJwuuJw1cQXdeaO9Y3bVqkx4KATUahyTwBztJL2YgY5BH0+VYT7EW1rRX9I4ZjVtkeiXlvFcmDWEJh6TA7GfM683GMho3/jlKa129xbFhh07uIQHO1zC0kfbey/vZhwyz+6bwV1elE7ZCHVeYMtU7lQxKTlL14MLxYkdCz8IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkjWs4uZxNTyGO2y4e7lNGg9COu/KvuWF8myZD54Ies=;
 b=wlHY16IrTnIgcV8BsfpjfTVxF09wh0Wi9XrLRI+OkIteay5Gy2tIofaXv5LqK1y/qh7eMg7NEjbIeVVNSSI0+nvG5Sp5T3SoKcbkAx5ccW8oU6cDc/OoeCvI5JAT0ttULYLF/Guhf0+WYc9q4gzsr94Rehjw17D23SLQD7mxMB1emUpbWG4EjXcAQctqH5mDeNYDW++pK+uLlOzMH1qQBtKlsilVm3E0OIPGxQeA9BRUurVaiyJFHtE4JIs2c3//vvvfs1vrNSiGNVCIl6In4V94hQqcw+4gBqXr4my8km2VLL6RBCkvm5wiZf8LHK+ye5L6juWrayxwLzsTQF0Zig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkjWs4uZxNTyGO2y4e7lNGg9COu/KvuWF8myZD54Ies=;
 b=jVQGZRHPfAfSO74GuVyCrutuvdAYMiuEQ613DkHAXvolSgllh8ZVClv5m+v9tpUXZittfMqpKjmlqXMbCGWGvBnY6pH7qwKiBk/R0RuCbvLpMS8WvqlXvEF4DFBHzkgGBseLzM7wMJekNTHyNJi4ZyEv2/N+ykuUiuo2Fo1ZwDOYnTTUhkAf8VXx38bb+HhbEKW5bX1m9sVm7YEVgrF5CxY0f+Ky63kI0nPcq6k57tTxz/ZY1pLjlyWkPYTtid7pa+qHn0UkuEMYgFb+L7GqckOF1rGedRVsDJfG/5yk1IfiNX2Xk+WB3EiREvkjjYVT1H5UTFDky48ovHApnCFxwQ==
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com (2603:10a6:10:2dc::6)
 by DU2PR04MB9020.eurprd04.prod.outlook.com (2603:10a6:10:2e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.15; Wed, 10 Jun
 2026 10:53:45 +0000
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47]) by DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47%6]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 10:53:45 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
Subject: RE: [PATCH] net: fec: remove reference to nonexistent
 CONFIG_GILBARCONAP option
Thread-Topic: [PATCH] net: fec: remove reference to nonexistent
 CONFIG_GILBARCONAP option
Thread-Index: AQHc98u8ZRRGEJU4MkqANoNUO3y6wLY3nvOg
Date: Wed, 10 Jun 2026 10:53:45 +0000
Message-ID:
 <DU2PR04MB86295CF7C84FA84D9FDF80FB881A2@DU2PR04MB8629.eurprd04.prod.outlook.com>
References: <20260609045200.32606-1-enelsonmoore@gmail.com>
In-Reply-To: <20260609045200.32606-1-enelsonmoore@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8629:EE_|DU2PR04MB9020:EE_
x-ms-office365-filtering-correlation-id: 64ca2ad4-16c5-4818-a881-08dec6de8b59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|19092799006|38070700021|18002099003|22082099003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 ZwYitsrLLsfpwLJP3oWcgmBKy/TVLtzZ0j99khnFM333nN1Zd/kw+ZC/PSJt5ai7TdurRSDDcqsV5wBVjoyQ5BTYOOjrt5uZ/q0nR4DosDhfkorkkzzkA+06cy8TQKXsUptlXcRJ9QQ3qfOTLLeoa5tBg4Xpv8a/Zzg9eaBOwZlkfwqLF+dMI7DzDTW8AqQHWFKuQhInlHj+5cL37YFKPBF6lLOPj4I2dtJF5F7Z9doUDauPybB1tjRcVQ+LOFcHeU6ktrBFHahzm/7D+o3KoLGsr8tbIJjirMiX2t21u7a3xlUfzoXvHt6nweQKGas2FHMceyWDA3KPKa4dG0DKmcwB+yORWDyXZez4/+OsxcIK142PWoq5H8b5Abl0a5f3SSEJ6LgsbcUwL34Xmm0V7sLCtKh/X0sO/p2p91TeLJ06WEHflD2fze2sLOsIGB3tldyxqRxjOBvAe8QsHDAJeOlgUnayTBorb2W2k7cf9EveuugqYpCZohr7DWL5Qxn9GaXXpBogqyUpHdKtFC2tI9/WzZ4R2Ni/j0deUDM23RJ5ibDeUl2Zq7PXzPYaM7WzW3K4WFS/jVbzxwXZizRjhNmCU5CjjPsjrG4ZDCte56jhgRzGI445wvumrCJpPkI3qJDY0W4V47I129vKEkt+pNoW+omVoRedEB8z9LOCEV0h0tyAKFjI3RO/xt6DUjzm6kHjIy6xPuNsvQ1bkYVVN1xdeh0yq013Vl5RS0xE9XlZADlthMHRPMQCLBb/cHIe
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8629.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(19092799006)(38070700021)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OEGikDS9MN43+VSuoQJ6Aa1D66irx20Fx2R1I/ExePmtoZyl2z8F11qLVsu+?=
 =?us-ascii?Q?N2OJLpVnRqIUWuFnqysWHgWHvEBMXuLck4P1bHzIs+4UAH/tNC9LPMPlBp5K?=
 =?us-ascii?Q?KqY+GnY5QGaQZhcoj26dbsQrxmmk86SMAinVWVZ5Iz2LmvGlSzDuK+wC5nbP?=
 =?us-ascii?Q?ezPrl3RTSpQ9wHv7zq5t6fYrvvXPmW0t3Fq7XZc+NASq3dAAYhnBbsrioxda?=
 =?us-ascii?Q?uQrtKFm0NwweDaZJhSnYUFyvyhtu65c/TC2ipkv2zlxQ7sWGF4vbGqwgdfKw?=
 =?us-ascii?Q?f1iHBtcMz04aNyrnwtudLlSxSQA1Tyj6zyVUUUMaKebYulzYbCr5w4Udqp6F?=
 =?us-ascii?Q?6yO6yo+pJtar23kMV0CxkSBK/rngZE0JhnvpQIq3D1fNI0oDvy2b+bfJwpal?=
 =?us-ascii?Q?f6M5UvnqZuE0yui4nV1lV8GHL+eUrtzRNCrWdygeUsKJnBa3oPnebYlVyEe8?=
 =?us-ascii?Q?2mCQf1IsZOtJ7n9ZA1e7eV/DVY9lnheuVytwDrBs4LlmC8+TfA597bUSfvaZ?=
 =?us-ascii?Q?wdMg8q+RY0OJJoy+bozj2H34DJWlpRWOQvgQMQf7dqr05P6eZgJ8MgjMVvE0?=
 =?us-ascii?Q?moVYE1wzWScNXq0gAzzIJRgHAN6SKziClIEyBMmF2QkTs1Lg3lDdt6LvYIlz?=
 =?us-ascii?Q?L90y5BbTnIg+lQt+tFEMQIzXKGVbZB6WM9RSlR36xmV1Ihv4psGkLifwsSTj?=
 =?us-ascii?Q?AoFZFg23+kdi/8xKBR2koGNzUi1elj2+5fKRMDYwsEwLySAmr5323H3pM7JJ?=
 =?us-ascii?Q?5TDsFHtIoAbYPUXe00tqOwNBmHkwheZfVbN2trFsu07WBVwgSO2V8Bm/cTCz?=
 =?us-ascii?Q?wmqcVSULubAXYSuw9VyhhS3aqRLgqegegJk+O7MEaqZCF5g5guVDN4KEAGQy?=
 =?us-ascii?Q?n7uPeTP2WjCryMlLMUpgAYGXC+9rURsSVsjjKwl75OjmvS1sGo+WZnEEs/Ic?=
 =?us-ascii?Q?nn8Q7m8AHjv8Hp+1BFLRzQbJKKu9RqkxbvguN8WjmwcAkkayNV+jW9VPu+bc?=
 =?us-ascii?Q?hRXMgNxeN2cMdHbBXk3SrT7EMp5IzPUVEBtkm5Ho8pfyoVcLQedSMTWaHQRv?=
 =?us-ascii?Q?7jkUVgQe/dEH99204w+zbQnecYcnhSfokbZ00hjhBkIsvS5zoT8eYYyJD+vn?=
 =?us-ascii?Q?ULrsEPMI9zOOejlTIyCioSdfKo3NTjMWnX2qgcLxfdvdCh3b15EYfwMi8/QW?=
 =?us-ascii?Q?jNBpEkBFbZSsNuB2uV/qPqRFjIIEdkMyvvObc6F9OmDtA9wBwBj7YXDzdb3N?=
 =?us-ascii?Q?aQFcktiNZKh6T1j5tkdRaGXjz59Q4bwc7zNpbQrrUbb1oiztylIHvHwS4Ww8?=
 =?us-ascii?Q?HNNlRriN0M22Bqf9PP6YP9jz8o7feR0Olgs1P1nuSpPuevN3VuopxKFrLe4H?=
 =?us-ascii?Q?IfGodO/naehZZ2IEO9jFjAwxDXp5rOiOMDLG3VllUBC03vm0/Qqv7U3RIjm+?=
 =?us-ascii?Q?/suTubr6SMasw6aVRLzyur2vr8O+GagJ2yb4RQ8KsYLDaXON34lc+A6g/c73?=
 =?us-ascii?Q?1fkoP4Nl5QWYcPD732WYAj+xemYwolQIfl7fGIT5A83XYPz76CfTtl+mVaC4?=
 =?us-ascii?Q?+LVJYYAUTg5/LUctQ8bINjy7gqTj+FnIBXruxXhypu9hDaFRAPe6nfkw00s9?=
 =?us-ascii?Q?5TD/iwAxVgDUwGu1Qh6oM0RrRRaldMvq9zfgFDZuQqEoO9Y0svF4OaECdB0w?=
 =?us-ascii?Q?/5G8VbHJIgOfIkNU7C311bMHLJ620XTjsNHKT5IB52/TZs03?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8629.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ca2ad4-16c5-4818-a881-08dec6de8b59
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 10:53:45.6017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4kjjhP7/puerF36ELp3DqNlI91NJzIKuBk+z6PQOTjhmGI0tEYotOvdl3w8BfmQkBWuOia7e2pwnEkPLd0dPVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9020
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297625-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:enelsonmoore@gmail.com,m:netdev@vger.kernel.org,m:frank.li@nxp.com,m:shenwei.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,nxp.com:dkim,nxp.com:email,nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C319668776

> The CONFIG_GILBARCONAP option has never been defined by the kernel, but
> is referred to by drivers/net/ethernet/freescale/fec_main.c. Remove this
> reference to eliminate dead code.
>=20
> Discovered while searching for CONFIG_* symbols referenced in code but
> not defined in any Kconfig file.
>=20
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index 6ebde65d7f1b..ced4dbf8cd90 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -218,7 +218,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC
> address");
>   */
>  #if defined(CONFIG_NETtel)
>  #define	FEC_FLASHMAC	0xf0006006
> -#elif defined(CONFIG_GILBARCONAP) || defined(CONFIG_SCALES)
> +#elif defined(CONFIG_SCALES)
>  #define	FEC_FLASHMAC	0xf0006000
>  #elif defined(CONFIG_CANCam)
>  #define	FEC_FLASHMAC	0xf0020000
> --
> 2.43.0

Reviewed-by: Wei Fang <wei.fang@nxp.com>


