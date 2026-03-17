Return-Path: <netdev+bounces-268392-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGGEDzO5uGnZiQEAu9opvQ
	(envelope-from <netdev+bounces-268392-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 03:15:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C3F2A2C71
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 03:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8185F3024296
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8669346FC6;
	Tue, 17 Mar 2026 02:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iqw8GZRP"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011030.outbound.protection.outlook.com [52.101.65.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3738F19AD8B;
	Tue, 17 Mar 2026 02:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773713709; cv=fail; b=I8nE+J2f5+6/DZCuXZ/U007z8+lTjpYP25HXv7689/D1qdu/Ux0PacrFPCJKwr0mJJ4qIHmydwBJ8V9Q870zy+3Pn5yXB2I/HbABBbog4PbCARsQLygbMyG3bk77iA6k5qfy5URkE5p9dF0MftWxXOH74Hppa7PBQb2vIEKAEpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773713709; c=relaxed/simple;
	bh=D99LS9G0zxHpKWgmN6fshV9GlnPIMtturya73Ov0AaI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qWbgWPqdAqN0lGBjA79bb7LO20freSJBaFKt6JxBq2EanAfgkL35UuQRN+jhj6wUjYznV0jumzvHSY1kMFMRiLhrC4zfycLBQD3cgKojyzrK0VoNHEyaKo8p2MNLrr75MSJOY6Bnd1bSlAaghGKxniMa/jGW07Q3cJC69ddkLUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iqw8GZRP; arc=fail smtp.client-ip=52.101.65.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jajD5vDbes7s0CseKbemlyw69Avkvv0/8QjL+4m2+mGVVE1MHtVTtJZQ3jjFcFtbeK778TLr8VehRaP0YProY+PWadR35SuueCibNLhrikxg/vNEqlkqZW7L/WUa3Yi6b2BGtsNuU66Ah9HdAEDEyHAnhynNE2ca7bOmoAeshqeow/TiovZ85N3a8b/4vs9PVknvyaRVlb5/kY0SHGewmPb1eNUAAhNHWHn6ptTDgaXWH/WsdEGp6KdTgna5LryZBYoGXnDMoBtn5XpLPIs+2/5PWVFXOIpvbeGqUZvDLxVnTOdZLJj22kXr/ABIOS2RsNGfowx648JTL+La0va9/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZhMtiO/ig2BTuMv4t4f9cTV2Da+nM0SNAMI/uLXJG8=;
 b=iY49FgRDz1e0FzKVnxA9SZrH3ztdDlt1c3Zgv/d5C31r9r0Zs/OoHGDjjCZU7oB9pI3T9Mqnr0w1oWCWdb/jreg2ZN19dV5ZOkh+LXK8VVUrPUPf5sYv4PWuLyLeFaHaIvJw8WCDa/sKOCOl3xjAfFpUe8N8pc/i0oFsWYVBYcnm0lPvS7C0CpTWhsaTaGt4dqCfxHDq1bjB2Ej1k41asxs2cyGhGRRv7Z8m0g/Ktfi9NTHS+sXQkDH/wlnLtEShWxcXnxlOgWURbadXrM9KZbQ0yuhTM1la5NRe+wGDtsWi1laabRHvlrgQ6vJXCDFSGWlcTqAMS0FaUZoSeq9YcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZhMtiO/ig2BTuMv4t4f9cTV2Da+nM0SNAMI/uLXJG8=;
 b=iqw8GZRPIUu2qMlwfsrtGh7CYZvcF2HvTOvfDs2hDQPaRP0rkbedWoFdJfahOzY69+GbyUV7nOXL8EQTVvrnwlrxj+cIYrBHWW+UOGOwpJviY/EFgH5U6MrQl/y6PSn+TS/mfr5I03RO4NhwDVOkjfianI1fRa/AEJ19h1qH9B+ChtKT9CTWuqvy8BkCcIQPadTIIhyeSelNs1hWft78AvhmxX4gDS8sU9xvduAf/ZJcgvTbo281VsVEGyVdnrf2M8INxYwIWsmAPfEyVr0bH6XfJ5io3oyQ/3CkkZ0sLQFpF0km0spUED4rtFWIDhoib4zs+yo3hHXiefgawCXPUA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7518.eurprd04.prod.outlook.com (2603:10a6:102:e4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 02:15:06 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9700.024; Tue, 17 Mar 2026
 02:15:03 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, Frank Li <frank.li@nxp.com>,
	"horms@kernel.org" <horms@kernel.org>, "saikrishnag@marvell.com"
	<saikrishnag@marvell.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v5 net 3/3] net: enetc: do not access non-existent
 registers on pseudo MAC
Thread-Topic: [PATCH v5 net 3/3] net: enetc: do not access non-existent
 registers on pseudo MAC
Thread-Index: AQHcss4SxJ+JYoGdOUeXTK0PGIZ8m7WxOGYAgADJOPA=
Date: Tue, 17 Mar 2026 02:15:02 +0000
Message-ID:
 <PAXPR04MB85104DB72F31FB794B4A456F8841A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260313094644.1132411-1-wei.fang@nxp.com>
 <20260313094644.1132411-4-wei.fang@nxp.com>
 <GV2PR04MB11740DD2AEB7641D7617E452F9640A@GV2PR04MB11740.eurprd04.prod.outlook.com>
In-Reply-To:
 <GV2PR04MB11740DD2AEB7641D7617E452F9640A@GV2PR04MB11740.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA4PR04MB7518:EE_
x-ms-office365-filtering-correlation-id: a2777700-cd66-4a36-26e4-08de83caffb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|19092799006|22082099003|56012099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info:
 OAwqW22dE/Okrqsc/SbzDT0HiZVjaAPpE0U5jiBGk/6yt4qInSI4ILCIuF+0DrexP1hhfp1MeXmHX4K79xOjPKEnYRnIeoo1ikkOlqjdG4O5saetzMKPWcqrkn2hv3Mi8lfp0UjCY/zO9+eW5OCvTIDwF11cadYa2OKB1pHmx7PEryu3myJgC5dCeIdEUuPIL15va/KACo1IfMEhmcRSYi7Py4uooHtv0yQBMq9CGZxtwcjkXIGhp7e2tdt+qqroFdpocHiqOoypMAhlbdyuWbGTibFtWXNhBqYhtgPwT6De821E82vE0/AM3SFgOMxlMbSu0nGmQIU0S4zL4I2Q4ChUGtSp4+xGa7RnxqGwyQaAPbmpxRFqgh5U6N8idZ+xj1UK9gGqtgj9yKj4Bb2jHRK8gWaxJKLMg2SGQ6Bsnb6CsSusXi41WKxRMTbwl4hfzTBSPfQJeUYekeZlU3EPiUBsOQeaVNtIGj3Ou6DGJZmC0ILCjrBztHw/yDzMcXRaWcwlIfPJgAc5+ZY9WZ8HbRfUF9CAud3o/HcDi0hjroWq+0dWLqFIcnueERTaJZoFQ526/CMasacU8w27tXqrjnO2SC1s06fDV0eDvW5eh05uMnb0BhyZyp3FDp/uJzWeYFjyfUld6rWNSxtjqjwgsjOZOuMXB2qDle72qKBeMSu6P1mmhs3gkxb9JfOm5Yd6GwK4rOJqbIchH+jw4m6ZEKnX9u8IoFeYypWFjBdxkRsq6dOAT919HRpuxQImPreierR25gKgSBGPKGv+8NCfeozxvUA+WcMhLPTB1JtBDDCSWi2pjmV2VbIUxqdFxFFj
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(19092799006)(22082099003)(56012099003)(18002099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GhYzyg01wUuooIbFX7twgIcB8SxcuPQr7TDv7rxD7wjvBBacR46haQ1WQdgx?=
 =?us-ascii?Q?6sCEd8cTdCxsKUrAxZaEnfx3jME+YUVQKP2XbtwvYj1NLoM4dowYglIHj0aS?=
 =?us-ascii?Q?n7goq/M5TSiX2TkrP7L2+XQf5fxNn3i/1C0h5cKHpPGghbqyccNePWS+RXFY?=
 =?us-ascii?Q?o0TKZzXOutXCUCv0OncTtGIEOF8S1JBweJWWr1WXql/f7hVYQ0e/RE8JgbYK?=
 =?us-ascii?Q?5d078ylE4Gt2zlTyx7sZ33hOZL5TxYNwMypWMH5RsjcQOVWmacq9QWuOSNgL?=
 =?us-ascii?Q?wKy6xmAUIeP0nXQyFvbdvfKN26ubjW1sthmtH8rYD/tyehreK8pUtq5QalkV?=
 =?us-ascii?Q?m91tRlXxRHa0/gHMDHjchcpIlqm2R8vnXPUhr/1j39cYxxaRNjk200/DdaIF?=
 =?us-ascii?Q?zy42GlsxCR3PgO4SQtUwuShaGrh3RK87S75JKqsGvYwKU753p55sHNBcNudM?=
 =?us-ascii?Q?gxXC6pXMCRzW6l7ZZX/yydF4KTKGEi7+fhRSBWjVRgBIfpcFtLsH1c8O3lP0?=
 =?us-ascii?Q?Renab4OmHlqSVLZCn2nc8e1EtnediobFqyaZAP/kEWyVHR4LoCq/YxGZFaaT?=
 =?us-ascii?Q?n+bF+6PkAFr8V7JhZPFm6WAR2gJGTaFS8Tj0DJneu2AUd/AtDBa7A9OieYns?=
 =?us-ascii?Q?wOUIalGLPfD9aeY7I0By2HneJEnwWErd6mjN3U4xSEJwoT37fGwjD5QlnNpH?=
 =?us-ascii?Q?Us56rxTl72H9O2we5oD+DQFbYyUewIRgHnsDcpuPMBzD2wR768XgHHGfCtUL?=
 =?us-ascii?Q?DpaXY8Rd+7NzOCJ0IbwRNxiBWvsHlDYYN+SRv3i/LaBzcFIFz+Jo9BEmznyw?=
 =?us-ascii?Q?NS8n+hkIaSx8j+VmGY/AnhN/gKartgfUi0n7IH8cPPV97hWPeAr0cniogtPF?=
 =?us-ascii?Q?GgJZ4cTGG1ygz8j/wsBaYhuuawgK5J8jTa0r/gmsJV1qDuhPNgf/Bgbm+puB?=
 =?us-ascii?Q?2HI5uLRTKzzR/WbgnxNVMYp3SjQ4GmIQSK++W1jkFiwaPatMZ/RvQ+Q8uFR5?=
 =?us-ascii?Q?BHuq1Oc1jxxlZ81O2afOZo24BYUji30XDqlEUUXNvFS/DELsyTg8Y+0q/CYP?=
 =?us-ascii?Q?Fa969N0/dAj3LlXe7m7YN+tQCe4OzuuoynpXTQYVa3i5cq+INvq5BV8POBjX?=
 =?us-ascii?Q?TY7F2G2+6gAbToGp3rxZ9P88di61miULNkVfk+1LHcvS1IRu3+BZGO51rc0n?=
 =?us-ascii?Q?TAlTykHAptCpj7JnCJHRiMoDsB77KctO3A524Rl4pANyucYY0NUetsoJ8hzR?=
 =?us-ascii?Q?bM+Ym++Y+gmvQOYuohzcYdx2khtnznOBXUnXLcRJdgrg1CG0zBlyFRxOHyqi?=
 =?us-ascii?Q?YPGW7l4S4YW/aBg0BeJLnQdK9PwExXmMODB2VpPSdVqXs/qSaY7OkUe2OBe3?=
 =?us-ascii?Q?d1WeYZpWzHxpBiOptdOpQZ96kF4ST8tx4scthrAUChRx5owxPRdxGTW6c8C9?=
 =?us-ascii?Q?3r7afRNl6Jdq3bhBiiz0nPZlVZWkmT3ewX8GBxBXaFXrTQhBVfa/PO1c6ulH?=
 =?us-ascii?Q?J4nElbolhPOarWfQ4JYJacxhCFbcWKpV+ZN8qGbjhb9GajmH/T3OBrK6GGKC?=
 =?us-ascii?Q?/mAlai9CeZxF3h117kW3xQRaoMxFyJGlGMjb0nyQJF67/iIzx+fYE9oADlqv?=
 =?us-ascii?Q?rRhIXYTw19r2i+Hr31EQmE1DogKnmhA6o1Okl5WKfHavpa+68E2E24y3GnL9?=
 =?us-ascii?Q?ESX1LwB6G0HyDpH75h1G+1kHITJ9qk99Gkl92RzYRNonGpVr?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a2777700-cd66-4a36-26e4-08de83caffb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 02:15:03.0021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rBmUcgYXFha95+dmAnzfAtFzsh5/MAwCXSe62Nj7b+A2eWvIkL/Fn/JR4VgamIMs7+y6kQ5Cpw0J3OlSPrIovw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7518
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268392-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: C5C3F2A2C71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > -----Original Message-----
> > From: Wei Fang <wei.fang@nxp.com>
> > Sent: Friday, March 13, 2026 11:47 AM
> [...]
> > Subject: [PATCH v5 net 3/3] net: enetc: do not access non-existent
> > registers on pseudo MAC
> >
> > The ENETC4_PM_IEVENT and ENETC4_PM_CMD_CFG registers do not exist
> on
> > the ENETC pseudo MAC, so the driver should prevent from accessing
> > them.
> >
> > Fixes: 5175c1e4adca ("net: enetc: add basic support for the ENETC with
> > pseudo MAC for i.MX94")
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> > Note that the commit 5175c1e4adca ("net: enetc: add basic support for
> > the ENETC with pseudo MAC for i.MX94") does not have such issue, this
> > patch depends on the patch 2 in this patch set.
> > ---
> >  drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > index 53cecbb23a97..56899f2254aa 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > @@ -814,6 +814,9 @@ static void enetc4_mac_tx_graceful_stop(struct
> > enetc_pf
> > *pf)
> >  	val |=3D POR_TXDIS;
> >  	enetc_port_wr(hw, ENETC4_POR, val);
> >
> > +	if (enetc_is_pseudo_mac(si))
> > +		return;
> > +
>=20
> Shouldn't the ~PM_CMD_CFG_TX_EN step apply to pseudo-MACs too?

Based on the NETC block guide, the pseudo MAC does not have
PMa_COMMAND_CONFIG register. So no need to set PM_CMD_CFG_TX_EN
and PM_CMD_CFG_RX_EN bits for pseudo MAC.

>=20
> >  	enetc4_mac_wait_tx_empty(si, 0);
> >  	if (si->hw_features & ENETC_SI_F_QBU)
> >  		enetc4_mac_wait_tx_empty(si, 1);
> > @@ -856,6 +859,9 @@ static void enetc4_mac_rx_graceful_stop(struct
> > enetc_pf
> > *pf)
> >  	struct enetc_si *si =3D pf->si;
> >  	u32 val;
> >
> > +	if (enetc_is_pseudo_mac(si))
> > +		goto check_rx_busy;
> > +
>=20
> Shouldn't the ~PM_CMD_CFG_RX_EN step apply to pseudo-MACs too?
>=20
> >  	if (si->hw_features & ENETC_SI_F_QBU) {
> >  		val =3D enetc_port_rd(hw, ENETC4_PM_CMD_CFG(1));
> >  		val &=3D ~PM_CMD_CFG_RX_EN;
> > @@ -868,6 +874,7 @@ static void enetc4_mac_rx_graceful_stop(struct
> > enetc_pf
> > *pf)
> >  	enetc_port_wr(hw, ENETC4_PM_CMD_CFG(0), val);
> >  	enetc4_mac_wait_rx_empty(si, 0);
> >
> > +check_rx_busy:
> >  	if (read_poll_timeout(enetc_port_rd, val,
> >  			      !(val & PSR_RX_BUSY),
> >  			      100, 10000, false, hw,
> > --
> > 2.34.1


