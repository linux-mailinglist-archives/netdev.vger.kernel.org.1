Return-Path: <netdev+bounces-269359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDP2Km62u2lHmwIAu9opvQ
	(envelope-from <netdev+bounces-269359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:40:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1952C7FB2
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92C973014A31
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 08:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5706D3A8730;
	Thu, 19 Mar 2026 08:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YWfXyCpq"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010042.outbound.protection.outlook.com [52.101.84.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7831A9FA4;
	Thu, 19 Mar 2026 08:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773909612; cv=fail; b=QhFsdgAIWIuUl9mOP27Av1khVJjAyPfYkXSdKgNZ9V97BhoeYCM7wdbtud8/5YnUXhEJHGuV/uvB76bFiPiEQaLrxcHQ3H1gjcOm/l/vJDkMgDRIyzcmoc34QlGYgPWKW97YwMQFjs2iEM8YOdtzC1jTDtX7T8W98dHVgBIeT8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773909612; c=relaxed/simple;
	bh=6b17vZvX35SvsOuklByNKSX0muCRGLiBNi+HeMHjw5I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NsHbnIJl5HoLnmTfMCxFqL7VfaMieTZaAAaDKJGn+ii8VnIkytjJ7vZf53uJ4aFnN/3HopnwReWeWWvzWoK8uNXAyznvTptgzRP/WB9+W1MGkbzotM/kqaRAYVD442yzxT0k1jNdr/MAwEB2UfQa3hWCHTNLzKpJO05BbNuf0RQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YWfXyCpq; arc=fail smtp.client-ip=52.101.84.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lD1kpKhxGmv0jCd+TZ/VIBJB1wbdgyr17ycpISAkfSsen9fPB5PLdwwrxUdVyC1cRYuPTcB8BmvJO6STs9ECm8l1Mjs/VDlgtL8XaP00ix8tB02wlP/VzkDXNFGXZIGs7MB1MfxRQuUAy+6P/EvaMaDyZckEkzE9s1uAsKRVjq9tGGjD9OfMMxtr+LaKJIYkSu4C7JpVGFoM+ehOzuBQGAuxzZEJ/wgYBaPhqFkf5ByXKzztk4r7q1O/HwH9ZTuiS4PY0OBLOTQl2KkZ50UZCdl0/bP6ntmJY1dytt7J65b1gm3Dqh29OlbtkJ07BX2hDBHD+mjihRCV5jsd2xcwRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=466f+Juxr/3q5/HKuRngEowaeU5zhUGv9Ey+VsIMCLo=;
 b=Tt7gvcneNN5dwQwmGGevIwZPOUlmgNJLIg4xA2pMCwZStT04sPqUmrJjxVyJEK8MZKuYY5+6BzQms7I5UeGXyQAdYz6D7dYkfBB2hM0qsyPXcdWNE3XhTg92KpIiANjV7XMY6AmdV78JpR31pBBPsH3CRlXD0tB2nuAx3GOqrueRnQQCOXPMF9pHOeJAOh7VlincL18+BJIZWkwhJzrDqCjK4E77aKDDQj7swwWOLSztoUnTl09cvJ5ue4W4Nfp0TxaVDhxfmEl7WUJkb0BjA0Of4x3iEOWlmOoS1TxzPXdwYMl+YPIpS3Hp8fZ2f2jfV/JqCiT0AE8QeFHCX5vh1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=466f+Juxr/3q5/HKuRngEowaeU5zhUGv9Ey+VsIMCLo=;
 b=YWfXyCpq1fJ4n8aRhaO+LwhI+GaoT/kMre5lvmpG1KpwktvQNZihC3mhr9xi6U3EUAiPXULprTprVQnrf+T7K6oQrrGyC2LRaF2WjhpTR7kMgxIxGCLH0noBNhcrP8fiiEpWCCC9nhYPlqHolbNJciXytFaJIOnIITtvoXPwbwsN1YSWAryU+w2Efe9+xRXfLi5Uy0BH358OshJHfBu+DTic3mkXHqdIvpT5jmhK5IUj3sPuqmVLhHsxDSUccClmjTX9+D7c25q9m2SNAiid9J7yrPRvivxpkFVgmI+5koIcpHREVF5Ngj2wViAcMWGoVQvuGaeGDyszvfsa57pdrw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7963.eurprd04.prod.outlook.com (2603:10a6:10:1e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Thu, 19 Mar
 2026 08:40:07 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 08:40:02 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Buday Csaba <Buday.Csaba@prolan.hu>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
	=?iso-8859-1?Q?Cs=F3k=E1s_Bence?= <Csokas.Bence@prolan.hu>, Frank Li
	<frank.li@nxp.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net 1/1] net: fec: fix the PTP periodic output sysfs
 interface
Thread-Topic: [PATCH net 1/1] net: fec: fix the PTP periodic output sysfs
 interface
Thread-Index: AQHctu/GZE92suzIgk2+bQlhrX9NVLW1LrnggABRdQCAAAQesA==
Date: Thu, 19 Mar 2026 08:40:02 +0000
Message-ID:
 <PAXPR04MB8510C371616088C33A841A90884FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References:
 <e2518c8f932fd9da6754b5ab5cc892ed58a0c1db.1773849293.git.buday.csaba@prolan.hu>
 <PAXPR04MB8510E8145481F667DD769F23884FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <2894050ee58d428cba909b705b7684a2@prolan.hu>
In-Reply-To: <2894050ee58d428cba909b705b7684a2@prolan.hu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DBBPR04MB7963:EE_
x-ms-office365-filtering-correlation-id: 1d99d2cc-292e-4c7b-2ecd-08de85931cb6
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|19092799006|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 J/bBeZZXJMuNJHjwXNHTIGPtTiQRamhRfRQJKgXAJ0fEDeupWsKhDk9RmAfpTu3pLJw7xTXmb6XFt/hWJnNHB26Ckx77XasHf1nPuxt7aCcEDW6UihLZogW41hntOa9Fa8oymMDZNUA2LcQqoRp6w8KUhFliGxrkgsHI38ix/06q3b1YZQi1PRnKqnpOQEzB2NLUveEnOOFtm6etPLCZGnZZEZOwD0KcNTjzE3LmvvLHOuFWHJtXxXqXYHi2+qe5HlagWRP2m+jekw9xcML/4quMC6SAkAfALsMmW3dUKH67/g3rxbBAjKY/WdXy7AMqFYTXQUo1ilyI0WCwQRK1QCvRAK3jmsdcfubf1BRgQLiEfMtlwBEiJ1eWDgkuKLHbjHCTiFQSupMkR5obPaORPDSa+pMRl3cAJ1Lk9tKtUWH9kC4MMsXLnV+y5qCPBUpJbnXaVw7CvP7CF8GvHM1KfU2/u5ulEuHm0yznbZ5UHiUt6/nunlCTOG4rMivqLHhVo/ZYZ6ghNHn9fPEAcYxudGFwAEHFX1+oH6oGca5jQIVjtz6/v+sVG3LxOVYNPd2IqTyx5i+fzn8XAsGo0jKtLMxuHh1qQAX0DOcsk1lxzNGPh/YA8vMvKLt7XRiX4WbrVNsbW+SUR03d/4T88eiOMumv66PqsWxvz0H2P8op1EuHAeLwqaWL86dvcLiFoFDKWmxdek8+ED1nOa71TciQ2tDkUbU9fUMXRdJqXhUdXZHXltptqnhIVbdU9WeUAn0h
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(19092799006)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?pXAQAlO/58tGD8CKiq5rUF+FuWsGeD8DpdcrQ8Y26/IJz+QV7wQS8bCLbG?=
 =?iso-8859-1?Q?7voq8tEAlLJNeivRyJVtCBXk9ocxnVcgW1z722I0OEaQNCwiDVXdkftBDs?=
 =?iso-8859-1?Q?J2lyK6HDlIxaHB09tDzn95EDs+/rMW43UoZC4/fUgDLDaKvbd88A3X+qOp?=
 =?iso-8859-1?Q?pcm9AuWhYu+8QavWxU2LMy/6LvbHGSPQ6HUOqC2Ucbwc4IqyIeW+lsGLwC?=
 =?iso-8859-1?Q?rhwKesXTilfedcjXtkLRDrUk03jKCxEcf4+aA9FLsSIUhW7YL2k5e2ab/M?=
 =?iso-8859-1?Q?HV9LUPAB0tePqZRLq5+yLbjtotE8Kmp1IUG9ulzg6eBXJ2S9WQXiVAmKhx?=
 =?iso-8859-1?Q?AzWANwgQDWuV7GIJRZgY7btZiL7hu47BdUEljFqqnDZH0/wAPUjU58ChwV?=
 =?iso-8859-1?Q?PPPeuJ4ROS74zVYn9xn7gJQjIG2SkcER24C+Mq8/QUDDJN58idXraJRYRz?=
 =?iso-8859-1?Q?JudxN1CvXAlo8PRr3tKOEXo2LDt0+3tHCIONCot7nMVQ051SXiIOcUUy82?=
 =?iso-8859-1?Q?G7eyXlk9kV7ghPHhPCxSoLEDtnNxVLEITf39wbnsqM/kG31i7N3hQi5P8A?=
 =?iso-8859-1?Q?VkpdROIvYrv361yFOY8EpneHr3ayB6hrqRo4/yVfyMPIfbGeRLWNggR6Px?=
 =?iso-8859-1?Q?jNblzgN+xtLnp0LVK1KYEVtbBgfafbKK6/ODRbJXTuFP8v0hrf9GhKj0+s?=
 =?iso-8859-1?Q?9OYMgtzWFjqNWnFO5v9l69f9NwQcuAeJ/G3p8oSBuqtaQ+2En2dFsBTDQS?=
 =?iso-8859-1?Q?6aCSI0nhMvGJGHpZOkmY1rcnVNrT23emLHv/3J+TVkpeeaZNtByIU6lF0T?=
 =?iso-8859-1?Q?GVADn/kvslBBkrvMGBn4K9DPYwvtrYoVNhJcUNECm8cXUErJmCajvBDDbr?=
 =?iso-8859-1?Q?DL1x7cLnwNlYtbVGp1FU3lj2/B6H8Ee4QTmVPk2f6gsnFEIAxwCRaSU3n0?=
 =?iso-8859-1?Q?Av/4fepPvudxJbdawhg3hhX6BPd5ON/7PV56rPwBD8tb7+nI/HJzQi/M0J?=
 =?iso-8859-1?Q?zYHrQt3p/C5w1P9LFAUfbgXuqAYumy3jC3DDWB5DTcCYOc7sJWZyfo0av+?=
 =?iso-8859-1?Q?DiMONQzaamrUQk5I5uimd05dq1Dg16vQ6B4rkeMlozn8c4e3Wd7rvFsat7?=
 =?iso-8859-1?Q?B9a6pQ36OJ6gR1SYeRb6+Ywnnc+SDu/CvqDDWTP8ZZe5pkgkX2szrNvrwN?=
 =?iso-8859-1?Q?DtD7MUlVbnEfalNiFLepd7l549OYy13A16dxGtyxLPXnNGK0oOKeOB3ngP?=
 =?iso-8859-1?Q?bNdUnifpFD9B7QU8gOb3vf0rBHmac3xGyPUbjcE3nsLtkXtgtvJbaGSfP5?=
 =?iso-8859-1?Q?D5JqBWzoKLQcP15UaWI4mThyaaiszqUS0Li3B0QC1poK4Jks1u/aCHtv0J?=
 =?iso-8859-1?Q?BvvUDniCVhMPlScXAqIhLa7xcbSzcDRp1B3oFLGmgsVHB73vU46Q+St2Bn?=
 =?iso-8859-1?Q?q2nQ/P8F8BJeKkZSMBk/bApBxJKgI0RQ5wm7U+4FXBLL+cREtcU2mBGFW6?=
 =?iso-8859-1?Q?EJDxniKvzbOYtbn+vxCnagIo4PkW5iQz3gSJgTAAiVsgkFahiP4pA+q7Eq?=
 =?iso-8859-1?Q?S2ORYBPij3c04VLuuI/7h55c9RNYKiilUQcB1tU02dtSZzqjfbvdoilV4P?=
 =?iso-8859-1?Q?aDcZzKezYwGjnZqPjNPvRcWd6SCVkyUEK/n70dCkMNsMd1n11wuG+uzsCU?=
 =?iso-8859-1?Q?CH9siu2ziS+aLYm5xEp9SFhys+oB5DufUvP0ii9HUi/4O4y+TUSj4F6Tsz?=
 =?iso-8859-1?Q?GMWO0Iie6hPYoHinfnMrDy7fP/4EAViNfMZyM/7qfdRPrr?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d99d2cc-292e-4c7b-2ecd-08de85931cb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 08:40:02.0735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jlsQcnRpH/nzvbvx7T0o2LmTAguuK90biKE8CRkgSyDWwnRUSaVVlLe00f2Ka135hNrNyywBzPRWXrXInFTh6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7963
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269359-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,prolan.hu,toradex.com,lists.linux.dev,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.911];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:url,nxp.com:dkim,PAXPR04MB8510.eurprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 4E1952C7FB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> >> Fixes: bf8ca67e2167 ("net: fec: refactor PPS channel configuration")
> >>
> >> Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
> >> ---
> >>  drivers/net/ethernet/freescale/fec_ptp.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/net/ethernet/freescale/fec_ptp.c
> >> b/drivers/net/ethernet/freescale/fec_ptp.c
> >> index 7f6b574320716..c1af81002b8fa 100644
> >> --- a/drivers/net/ethernet/freescale/fec_ptp.c
> >> +++ b/drivers/net/ethernet/freescale/fec_ptp.c
> >> @@ -534,7 +534,7 @@ static int fec_ptp_enable(struct ptp_clock_info *p=
tp,
> >>  		if (rq->perout.flags)
> >>  			return -EOPNOTSUPP;
> >>
> >> -		if (rq->perout.index !=3D fep->pps_channel)
> >> +		if (rq->perout.index !=3D 0)
> >>  			return -EOPNOTSUPP;
> >>
> >>  		period.tv_sec =3D rq->perout.period.sec;
> >> --
> >> 2.39.5
> >>
> >
> > I think the correct fix should update the n_per_out value like below.
> >
> > @@ -756,7 +756,7 @@ void fec_ptp_init(struct platform_device *pdev, int
> irq_idx)
> >         fep->ptp_caps.max_adj =3D 250000000;
> >         fep->ptp_caps.n_alarm =3D 0;
> >         fep->ptp_caps.n_ext_ts =3D 0;
> > -       fep->ptp_caps.n_per_out =3D 1;
> > +       fep->ptp_caps.n_per_out =3D 4;
> >
> > The commit 566c2d83887f ("net: fec: make PPS channel configurable") add=
ed
> > the property "fsl,pps-channel" to indicate which pulse channel is avail=
able.
> > So we should not fix the pulse output channel to 0.
> >
>=20
> But is it wise to expose four channels, when only one is usable by this
> driver?

It's fine to expose 4 channels, the driver can check which channel can outp=
ut
pulses based on fep->pps_channel. And it will return " -EOPNOTSUPP " is the
channel specified by the command is unavailable.

>=20
> This patch does not affect the channel selection. That can be still made
> through the DT. The driver uses `fep->pps_channel` everywhere else, while
> rq->perout.index is only checked in this single line, and never used
> anywhere else.

rq->perout.index indicates which channel is used to output the pulses, See:
https://elixir.bootlin.com/linux/v7.0-rc4/source/Documentation/ABI/testing/=
sysfs-ptp#L130

But this patch sets rq->perout.index to 0. However, the driver actually use=
s the
channel specified by fep->pps_channel, which is unreasonable.

>=20
> So the question is whether userspace is supposed to reference the hardwar=
e
> channel number directly, or the mapping is meant to be left to the device=
tree
> and the driver internally.

Based on my understanding of the period parameters in the kernel doc. I
believe that the user space specifies the hardware channel number directly.

>=20
> I hope the netdev maintainers and/or Richard Cochran can clarify the
> intended purpose of `n_per_out` and the expected channel indexing.


