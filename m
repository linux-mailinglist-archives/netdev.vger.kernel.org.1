Return-Path: <netdev+bounces-291229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CApRM8G1E2ptFAcAu9opvQ
	(envelope-from <netdev+bounces-291229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 04:36:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 349AE5C56ED
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 04:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 655F130056CA
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 02:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A44282F31;
	Mon, 25 May 2026 02:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C1cVIXOS"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011019.outbound.protection.outlook.com [52.101.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC869322A;
	Mon, 25 May 2026 02:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779676595; cv=fail; b=oSH1r2Lt+PdkltQL3v40kGCwEpyoSDVlB5s0FXWE4J0H5xYPqFrpkhvBQ0HUCeWU317INNRUR9aW3MrbSDZPn8Rai/9EyHij+mBA/UULQI32FvuNObUfDlmm/lfR7JqzmXjIjU1+4Xr6Fm9d6EwH4sZMRLIX037cD/+LHvbpo88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779676595; c=relaxed/simple;
	bh=n8P0S4+k345xUBHjRrO+K6PVLlAirBoOKal+xqS1xWg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pzWXEVxgxcpnLtEgPFs+MMfJ0bDr1qAo54VC3V3hJpvmY51ycaeqUvURYflhL8GN6eLGSNMcR2AfkgFk5LL9BoPEbJo5PDLT44OwExyMIEDgM+Mes4yz99SU+nD8ZnaFgpJ/ZTxhpT+qMPioENBX1HSvDSF4xwKUMjxQYdqhWio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C1cVIXOS; arc=fail smtp.client-ip=52.101.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfWj5fba75yeDIaYtobuu5leUi4Kfp+S/AFxKAtCEfMwvAQqgtvVviyIrDeRRjdKMu9K1EIK26vjRwiwzHFI1znHXD47/cSauo5s87/Dbl5wYBX2YEGiQ/+jsEOJiRs0Iv23OQU/n2KjKF3chd1ZcHHCxF/Xrjgv3RaeP/wuAd+WOrTFu7mc6akiryDiyQ0LDMJLvA5hJORAJD94GG4Q8NCj7hVRURJuh7ztjLm0/rmFe9qGCDqNPU8TW3+3B309dvU90rWMLMxIDayWXqB1c/rj3DcuuNMCWMdyZfsWj/LnfD22QB7Z74T4/bLRq/eQDfYBYBFcQ0E3Aq6IWyG8fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjfJ6KaCVOfJbVG+2RbXHaz/jvfuyszM06tGbwklypw=;
 b=d7bSYiTNcpGWTSdM7Q5VIQHRwWUMNKEk9TqvX01CTItOMNedVm87b5J2udRpSN6mrO/SBcrRAE053Iv14vbg1UtQ8fy9ANC2912S/DhiUuDaR6o6lYcEVXIzB7l3DAgaxZPXGecof/ke1Bb3R0vpf8x/DU3ecenj9JToseUc4Jog3jZZuYvF+TA8/9N6e3JXGA1scRGg0eCQGD6s40Zxhh4vnZ59bpUw4kBrJDFL11SFtbtyYiadwJGg8QzU4b/eCQpz2klTgpHBROsK71pzbVXP5qnN+ded/dt+A9+AnmWs9AuckCG7JUSqRhMNEK4p5EsNOOQ3r9x1w/Gm+3SyWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjfJ6KaCVOfJbVG+2RbXHaz/jvfuyszM06tGbwklypw=;
 b=C1cVIXOSbHqcC8XEVJG0xcxlzzbRopR4Cgoz+oubWMIcli4FoQLCA0JEl7fpmGszEFmBUoTx/0MLDS/PwrtLJa4VO90aNNnVxxZ45vd1Z3UimpFzm0+oKh7zn/onI/xSzaFwcteBE4NDLsgufvURDJCAlUB0gHlwPyBnVdxjdCpf8e7QfFtaxY2a9VVo/5LVksASIe1Niq8mCx4f4dbcQ423bmlHffxtuf9za0RDCM3JpWOj3qrplK+9Nwm7lHvlJi320t+zwVXlHwpl04F9IO+iKG1wolSL6UTdBSj8AwA0l0I1JNJN9tkDBsUuEBt1KxxULiFDe/Q2fjYpHlW1GQ==
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by FRRPR04MB12619.eurprd04.prod.outlook.com (2603:10a6:d10:1d1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 02:36:30 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 02:36:30 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 net-next 12/12] net: enetc: dynamically allocate rxmsg
 based on VF count
Thread-Topic: [PATCH v2 net-next 12/12] net: enetc: dynamically allocate rxmsg
 based on VF count
Thread-Index: AQHc6cyOJisv85N6v0iyDoBrMmPsJbYeCBkQ
Date: Mon, 25 May 2026 02:36:30 +0000
Message-ID:
 <DBBPR04MB7500AD1BEB312E1332736F1A880A2@DBBPR04MB7500.eurprd04.prod.outlook.com>
References: <20260522092438.1264020-1-wei.fang@nxp.com>
 <20260522092438.1264020-13-wei.fang@nxp.com>
In-Reply-To: <20260522092438.1264020-13-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7500:EE_|FRRPR04MB12619:EE_
x-ms-office365-filtering-correlation-id: 3de177c0-989d-41dd-f65a-08deba066d7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|38070700021|4143699003|56012099003|22082099003|6133799003|18002099003|11063799006;
x-microsoft-antispam-message-info:
 smrFkGBk3sho47MZcCxD2IcSU4VAF2fKNvK6/F9xzG3KX4SPL07B3VRZYIfg5Hp4qt/Z4j3XA1lGmw2leAW7HqjdBjUip5cp9ceMuukK/38A9KRs6rAeyspx12l+FZSrLwAs0BSCyscRttEPRFCLsZ9wPSD4YsC/USnDXoJQluJ2l1PDcehCwFHWXwRu2GcgXu7f5Mcff2Gv6KyRrVQAlwOpzJYzvqOMmGeLDJGmT1yg011Z8ungFFhwP5LvbFTOuOMdtgfl1ryVr2AUo+iJoVIRiRDtL4tCJ6riP+X9BwjAMIunRuWQYzmGTf4bpRlWACfuDXnJLEEauhwx9o693pBhsfkW26F8NWjNc9J836l2w+XZy/wDnVCvPjl8JFzzQBbAeCkGPmB5uAEryQBW+/wWAMTt+adXP5CbD9LYzE45+VVM5QCcAIEiVMSFN26gY1DliwoP4KPLrMt/+LXxb+OUPwABeGpCzXf7Mo3DwJ+JOUyz9lvK18vPEg6zDQmvIDNZRdlN3UkJLBcl1LJhVGwMemCKhykrMcFkH9vppabuwYE4EJ/UFejJNk+MArV/C7/jOAUvtNDAvLVrSR/lRztHkyvLs/Po5Lc5C1+luhZOw0l+P/4I2pW6YO5z3Xz46WZsIET1zUymfQ8Eu0ubWtRidEkBwfHOb509GYY+rt2GIJWC9LTmtFtlN1KtdImIK25gSuSSRKXelMyeiqgIODunNIBZnWD9Di2KvFfjgYxSWy+p/qTSfIJXyhblVR62
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700021)(4143699003)(56012099003)(22082099003)(6133799003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uWoOpJ05Tb3LhklQrv/682bxigGpCchQkAdyDn8sOpXx4MXxbz63SPc8jBgR?=
 =?us-ascii?Q?oIhcdyR7afGQ3j/wJUan6wdyKZZ5ROl1BySDIT3UX473fqsOuXGARhc7YtEt?=
 =?us-ascii?Q?BOSt1Yg90gljzbBmUxELZHxm/qi9aN4DYL1sK4AO2IY5yP3AoMfdkjSPWNd4?=
 =?us-ascii?Q?sToPbe5H85NiB4WL/VtOQLa5JWp2GYknc3L40b29wiEoRfpZnTRiZMGXKzB1?=
 =?us-ascii?Q?7pSh41TpCtbMCb36WZgmhhD4S9rfJqeWct+WfIyr88cu/OL3W+v+EBrVbVaW?=
 =?us-ascii?Q?0PCAHukB8sGsVEbwnwmzrUqkPVYre0EWTkq2uhVryJjwsOwjyyGO8Vw9+T6D?=
 =?us-ascii?Q?Ru7x9oba27c8mEXeAC1RZ1dCBSzN/uEHhgi9n7tHKdX3DpISBjN+yRhNwpjJ?=
 =?us-ascii?Q?bxflAaAojSkvJGRTbjpdpk2U/6dLV3wGEX1o1XNvSDFi5FPrXEH3hhxD0E5O?=
 =?us-ascii?Q?ucxCbDjDItR4jzKO3LFQwv6mvClwk8r/0Szu7IRLSi5I64Gs+N4KzfSSjy28?=
 =?us-ascii?Q?Ho62cL5u/kNRDlyCTyEKx8VSnybURPZDYkWapRuP5tvU8BSXAfo8VMzpEjlY?=
 =?us-ascii?Q?KV+jH923H5SotP76djaU51mSZiHGKiQZWDLUjYcpx1FkE4i751bTmsohju4K?=
 =?us-ascii?Q?Sm445BUcNHb2DwKiYq9PSLhKo2B7EalZRZOeVhFVsSVuL1DJKuSOhUMjZ6XF?=
 =?us-ascii?Q?BV/aMHsvSaYC1xbd8c2qFZ/opU8KW4HX504BOtRn2eJeMbviD2LJxB3jRGtm?=
 =?us-ascii?Q?k8GULIke0+xHpi1Urkrf07KOOoHk++r+CHFECrHlYP8WzRnQItwJrF7woasD?=
 =?us-ascii?Q?r6AJAocKHTd3QW0GXpgH0PkcuY3CU9U1ysJZzl5I9wuIr6Pkrp10VO9+hHs7?=
 =?us-ascii?Q?VwwFJthSJlfIAcPUekKPCgSWfQ8qHS0TdyHyH+SLN6Qjn8VdzwFZxpQHT6mA?=
 =?us-ascii?Q?LM0T7UwsYtW6SzHmX1Q2o2o++bH7rU9bjl8wjkMOq+IX/qw2ruCqYCoh+Kx/?=
 =?us-ascii?Q?92WPcKrNDIkDRz4TPH2J5e3AsYPtq7mKYPGjNh4D7dZ/Uc7ydBeYyxAplSDa?=
 =?us-ascii?Q?Z9i+zs2jhjad2NbFdHQLDHs0ekidOss5yeZC8Qx9LJV11kYC2WKLgK6wUs8z?=
 =?us-ascii?Q?B0H8R0/eZ8lgUkYvuZVGx79WKbkvyTWlzszNsjV7CBHN3GI2GcbcQF5bdBYi?=
 =?us-ascii?Q?9vs9PQcdWFftqnQEEVxULD3oQHx4AGui9JLNRiGk8b6keKVzZJzndx/9YxfW?=
 =?us-ascii?Q?X9j040QrAMSNljht8fGD3k04kPsitrRkUMVWKh7XDOVAfQHnebHUlfn4XRJp?=
 =?us-ascii?Q?wgp/duL3j6FZZI5xpy5SPC5yhuNMKLpUNbi8W8eOQxGBmYfirkc0nkGziMtF?=
 =?us-ascii?Q?zrsy5/GWtobA8WdXEXAX9ZRi+JFL1o2F0Jw4GvxhUOtmXtDRX2Ri1ALveskE?=
 =?us-ascii?Q?zHARd4/CYclax+cVtY5T+LLmRf6o9ZDkEp1sOAHNV2QwUUsFwqIotUEuBczf?=
 =?us-ascii?Q?99JhNvkA35I5HPjE76kwTOqNsd5ebwVFHLtMK5nHhuUcD5ZsFLX2JeQyh0Gv?=
 =?us-ascii?Q?W/J5ap2Sw3ke4Ocp6XIZ6Vgs9zi0mN4sLqD78+4X6nxEkwNFlh6fBp/IGy8O?=
 =?us-ascii?Q?bs8wQbxRWcFC2qsJCI8D1G5ABr+4c5ai3izCs87QSNnvsQseR06gdIzv4zxt?=
 =?us-ascii?Q?YpmTqTVA2dnIZHmK2y1+wYMkHjbD8lzOOrQ1Qo+9vXk8+8HB?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de177c0-989d-41dd-f65a-08deba066d7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 02:36:30.2111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FYQnXog8aIUgB+vs3UvKrgn6Rh7cvQEHZ1BONxVo0OZ8up8ZLSA6iOo6frWTl4uIRVn8xKx1S/rFUgo/E9UiFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRRPR04MB12619
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291229-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:dkim,DBBPR04MB7500.eurprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 349AE5C56ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The below issues reported by Sashiko are false positives. The ENETC v4
(i.MX series) uses a different driver (enetc4_pf.c). enetc_pf.c and
ENETC_PSIPVMR_SET_VP and are only used by the ENETC v1 driver,
and ENETC v1 supports 2 VFs, so the issues do not actually exist.

Sashio:

>     i.MX94 standalone ENETC: 0 VFs

This is a pre-existing issue, but if a device supports 0 VFs and reports
more than 8 hardware rings during probe, will this result in a division by
zero?

In enetc_port_si_configure(), the driver reserves 8 rings for the PF and
distributes the rest to the VFs:

drivers/net/ethernet/freescale/enetc/enetc_pf.c:enetc_port_si_configure() {
	...
	if (num_rings)
		num_rings -=3D ENETC_PF_NUM_RINGS;
	...
	if (num_rings) {
		num_rings /=3D pf->total_vfs;
		val |=3D ENETC_PSICFGR0_SET_TXBDR(num_rings);
		val |=3D ENETC_PSICFGR0_SET_RXBDR(num_rings);
	}
	...
}

If pf->total_vfs is 0 and there are remaining rings, the division by zero
will cause a kernel panic.

>     i.MX94 internal ENETC:   3 VFs

This isn't a bug introduced by this patch, but since 3 VFs means there are
4 Station Interfaces (1 PF + 3 VFs) in total, will VLAN promiscuous mode
work for the 3rd VF?

The ENETC_PSIPVMR_SET_VP() macro uses a hardcoded 0x7 mask (3 bits), which
covers only the first 3 Station Interfaces:

drivers/net/ethernet/freescale/enetc/enetc_hw.h:
#define ENETC_PSIPVMR_SET_VP(simap)	((simap) & 0x7)

Because of this mask, the 4th Station Interface (the 3rd VF mapped to bit 3=
)
is silently dropped from the VLAN promiscuous mode configuration.

