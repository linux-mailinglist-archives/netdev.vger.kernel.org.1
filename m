Return-Path: <netdev+bounces-274866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAlAK9A2z2nutwYAu9opvQ
	(envelope-from <netdev+bounces-274866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 05:41:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E825390B4B
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 05:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E590302BDE0
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 03:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7973235295E;
	Fri,  3 Apr 2026 03:41:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2090.outbound.protection.partner.outlook.cn [139.219.17.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CF2340280;
	Fri,  3 Apr 2026 03:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775187661; cv=fail; b=FMgkZwFk3mvquzMs24n6WyH9ht7qrgHaXa+B1Ry1EVo3TrGDuPEQ7rA4DWOvVUBY0XM9tmwkePaLPlOoMZ2Qc52nGLAb3pYQFJa7col8Ll1GdYzR+nG2lU/qzZlYZ5+g6kccnVrRisnOhVsZjugcCdEoIUj3c0Sb2IVVSYATGVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775187661; c=relaxed/simple;
	bh=w/PhTHOYfv/DdHGrUiQBOj4e9PBEDJOioQz5f2Mw+3E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fD9XvNFwU+XAki8E+VE2e39lj1LLEOFPnloPKXZsd/Xq3MQqjviTn3rff57ekZnFFrYJjCwa1viF0HF/r5h3kndvW++JMo1QOFC1mYGO+A1jv0Q4lSk+A6W1tySoRTCySOAWHZTsIzoTQliHwO9G6Yy/1TUzJnfGzcJQSK97wQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Is96KV8aRnrq2LQKFW7dJE6st9Efyak5vevYoUzZzEBXTETyiyUzrEPLuxZ7ARPTi3gF02SBRNkpbdR9Vh2pQxpZRRxuzKtCQDJNvEG9c8GuK/dJC5EiXKRmBhbY5CwqOEA+WtUEFMJwqJ1mMNp1KOqeZ0CMH/4+ulizgyUSQTOZSidMuUyGumGPeVXgdQ8/IP9gyLczeUH8IXRbKlPjgIqFDbJgSRRr4xeMsB2hc3bqgVWBdxpw3HEb94wC9OEPv0CNT6ICpUSrN0KmJHgYY+VnUTF9HaG0XuyFMDgOe07OXbBwWrkNjYE3TbGtQ9ASfoYzjbg+IHxVqVi3jqxjTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0P4YssrS/yDASRO+4SS5ajBlRd6hKXf3bWb/JjZJqdk=;
 b=LKhHYFv4084yjj1VMxDMe9RanAyQONr8QzBnx4d0vHpMPNDwxz+0pie6D7CG59X8LJc1LV+oRj5gSWBMIy2ryA/p63EAubziCpHyPQdJflpfLk68Mg/DVKu/iTpDBHtBTfmD69JxkGDc6wP/j14kq/qo9PcMMoeUPfAr4B5kNtyKERXgujxfFzHR33vIKePJZ/2RZ2YgICoivyHISw6jhHWlrYSfvIIxGelzgsPtwE2YL29qkrJ9Jr7kbaZ2R1y3JNi3HMYH6oqRrk/owe6LNMOTJLWiiS8aIFogoSl4SqkveDX46TYSWcgDu7Z/da/Mn9IW85+IB3VxG4ZKr4clHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1235.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 3 Apr
 2026 01:07:48 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%5])
 with mapi id 15.20.9769.020; Fri, 3 Apr 2026 01:07:48 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Conor Dooley <conor@kernel.org>
CC: Michael Turquette <mturquette@baylibre.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Philipp Zabel
	<p.zabel@pengutronix.de>, Emil Renner Berthing <kernel@esmil.dk>, Kees Cook
	<kees@kernel.org>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, Richard
 Cochran <richardcochran@gmail.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, JeeHeng Sia <jeeheng.sia@starfivetech.com>, Hal
 Feng <hal.feng@starfivetech.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>
Subject: Re: [PATCH v1 22/22] riscv: dts: starfive: jhb100: Add clocks and
 resets nodes
Thread-Topic: [PATCH v1 22/22] riscv: dts: starfive: jhb100: Add clocks and
 resets nodes
Thread-Index: AQHcwo9YmfBTEkKdxUm0c+lYETzpKbXLr3UAgADX/ZA=
Date: Fri, 3 Apr 2026 01:07:48 +0000
Message-ID:
 <ZQ4PR01MB12025313E4A491A86580558DF25E2@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
References: <20260402105523.447523-1-changhuang.liang@starfivetech.com>
 <20260402105523.447523-23-changhuang.liang@starfivetech.com>
 <20260402-fox-overhand-9a45ec670bce@spud>
In-Reply-To: <20260402-fox-overhand-9a45ec670bce@spud>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1235:EE_
x-ms-office365-filtering-correlation-id: 3c69da36-b625-49c9-3e28-08de911d6bd2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 E/rjzM1MFY6CwaV4cRpRJBN5JpED16YzI8Ev89M3BtXeeTGPyMPDeBG4Ps74hq2HFiuhMYaq95iDz+C7zN31HKFjt4o8AbQmdbRQNt4L2Eovv5D14YE47YG1zLpNS66wR4/iRM+12FR8JuLnrQ2PgOVRUImM3h+sSJIWJEveqnvMBGSiSArADVjh2O0IuolXN1QP7SoxdUnilmTCMEsjoQcCTkMIEmLlTGELNj3/0rn4B0TZXbj7ErdNC2weIrxylRgNeyVPuBbcuxui/bVpjJ/hTdWxvXmvEYb7BQmE/Yysb90HZD+HUc7GRh/ayedrQgkgLYNCRFb7bcsNBeoTUxBcABtxWtg+4ojpVVk4x5/5UQ/X0WuyPC8PbpBwB1EknaPyEfsmyCi376WCBQIIY28edq9vBIWOhgmqQejbJG28VQ34LI1rdWWG2fKEDhGuIeOUgZn5h/PpY5dbY7NlPqYEkU2wZTDW2PC6nZ84eiIDI0zIKnYe7fmc9r9oD3Sub8c15d+kaZQRBNrw0U3v66DLsHSktMTD6dykTOzzdaOgy5xjb/90dUIe7dXWLwx3u6oY8r3pGgwv5DfrIL8NnLaLgYAJPM8iGbRvXJ6TvUY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ntTMaczhEB/VMXHk//khsCx41PJN47jXbaFJlLv5DIgOqi6YfcZHmdXlyGfH?=
 =?us-ascii?Q?a5mhYi0UpqdQeucRy0pbYuAT6YNxFioh96nOe2QKwKS+DJuloGSfhVp7lZzv?=
 =?us-ascii?Q?4009SfwFddF+ViGt8NOUimroG81zNZJmWy1rzc8gNom8vzL/Q4rtt4VZRl1F?=
 =?us-ascii?Q?e3nA55Rc+nZpvw3wriggBer/5j6y4/xiVYL/kTZVeppUG1dK6LPoYJn21E7E?=
 =?us-ascii?Q?GH1is/tpMdYNfre3ubeNT6PsjF33b+funBjSep83Tt1tOdRs0bES+cTdt0Hs?=
 =?us-ascii?Q?IN0iim6w26pQHDtLchclGkoHUBysq9lviOWrt7eB4wfAn19Ace+xmZ2WYSGs?=
 =?us-ascii?Q?fQfvIzHVEQcyBl5yBnhOJr4IrAFnG6HSJKI/EpXcOSEShNS8pgJh/lS1marB?=
 =?us-ascii?Q?/vfswznJPQHbu77R014fwpFyv/IJ3V6p5PfKJqIcZkwp2IfJfDSAoYNFd+N6?=
 =?us-ascii?Q?Hg24JL8TM7F1nERxP4G1r6iKiY6xFYUn45SAmk+JII1NDxyPxixletdFsgH7?=
 =?us-ascii?Q?ktX9r0EWUknP4WcnjbQokCSumSQg2K39xaOJ9UGThcR2m3gu4T2JydGmO36y?=
 =?us-ascii?Q?iWoeGWwhVSUnWfmRVTSwpUb1v5+lydWMhVf3DKuNNKCjNGX1Lur9KJscFqEK?=
 =?us-ascii?Q?RFxQnUaSzelIuzOrLxY6AkuIdGAnwHGQqgdKbqweIwBVwhviJJp+MaEP0bpY?=
 =?us-ascii?Q?yIwnFKdWLIEMOgEm0DlnyZPcSu0xzrqdb2J87jFWZ01Y6t9AmMHERk1sBDjB?=
 =?us-ascii?Q?aO7vOz9BsaDC+JAELd+8Ywz9guv61cYIL8tz3zd2+q/rd6gf+J/QUW/ipJlO?=
 =?us-ascii?Q?agbEKWlr5PoTdWsTLeni//VRswcrMWVs9ooMAvWStBshXxMC1GGLSPh+lkPl?=
 =?us-ascii?Q?yD4yNwOF3pIoeZIj0JGcB6iYqWp0KiFDrjcTCt4lzXT9mW1s3Oqkau8V6QXL?=
 =?us-ascii?Q?J3z7Ix7R4jxh8lktGQmenBoGTK7LQpyRk/ogj34P+8cNfezvq8ZrXCOgJe33?=
 =?us-ascii?Q?50QOCKQiJcdqNHAnbbzbBspCC4sNTZOJewUIydKvLjDDrgKu3R2ym1OWuIFd?=
 =?us-ascii?Q?8KLEbw4B2glQaXyV+GZQO5ORG3SEgqMV5zV34ZluD0Px9bXWQWEwrD7iC+yi?=
 =?us-ascii?Q?kQYvbr3P50Rk5tkaiFM0Knz+soV12mmlKgpEeWdFOhvsVNzaLEfM8SMtVFr3?=
 =?us-ascii?Q?YEv4zSvl8Q1SiiNXOkLTvPHB4OOMq3GP4c/7kzt7HDEV9KnQNWOO5/RBCV8g?=
 =?us-ascii?Q?/35DlHGVV8/lyU063JvAGTretFsbSm8VNYwPWcanlkL4XkdQFi67YoL71g/9?=
 =?us-ascii?Q?/1A0SV01PvrKCtV2YNo87qMglCvEOxvPJthJnpjqrU/DeUpdiozJ4SI8pQ73?=
 =?us-ascii?Q?LEqTZsM/J9Kf+kXDOWJlgVNcfrC/wSuT0vNEfeW9opFyUMPK7AxnuFvDTZzN?=
 =?us-ascii?Q?C7xzPguebMTjrqMr3xPkFE9y3wYw9Ymb9zIOqtuu0Is1Kto/bNYuZ3mmAkAw?=
 =?us-ascii?Q?NQtdBvzTdCTeM/Aj2XSZuNQlxbK7JCDQwNRHcwbR9yxrQnWn9UQhFpyBuar/?=
 =?us-ascii?Q?NWA/OIpMz0VgO8o/kRj7AKMWiI3b0tSHd97pOgfVx9mc4z0/w9HCGrlhHUz5?=
 =?us-ascii?Q?yLRYkYJVNDSY0bRG05PGyp1gkUN8x1aRD3zl09Mc4g6999m25JcagzeRd3+A?=
 =?us-ascii?Q?oOjLheDstc+y42SlDzOfGx1lHsxm+wZ1nsHpweUsiGz+tus2Rc3Gsp1pDIZk?=
 =?us-ascii?Q?QgKkkC1qhp2mdU9gg9VMExZ/VWfwFaM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c69da36-b625-49c9-3e28-08de911d6bd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 01:07:48.1650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AAZcpXpb6/c4mSFsaKzB5WZQ857rx86QT3P4wOZdnIyCaYXwEoGYGE3km23jGF4ZYRpgpBSYTeDQ4HjYgquAEOxtTG8OHcdDWuLd7XA6z8cLS6qQcMielCyykKVPoo/7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1235
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com,vger.kernel.org,lists.infradead.org,starfivetech.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-274866-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.184];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn:mid,starfivetech.com:email]
X-Rspamd-Queue-Id: 8E825390B4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi, Conor

> On Thu, Apr 02, 2026 at 03:55:23AM -0700, Changhuang Liang wrote:
> > Add clocks and resets nodes for JHB100 RISC-V BMC SoC. They contain
> > sys0crg/sys1crg/sys2crg/per0crg/per1crg/per2crg/per3crg.
> >
> > Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> > ---
> >  arch/riscv/boot/dts/starfive/jhb100.dtsi | 198
> > ++++++++++++++++++++++-
> >  1 file changed, 195 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/boot/dts/starfive/jhb100.dtsi
> > b/arch/riscv/boot/dts/starfive/jhb100.dtsi
> > index 4d03470f78ab..700d00f800bc 100644
> > --- a/arch/riscv/boot/dts/starfive/jhb100.dtsi
> > +++ b/arch/riscv/boot/dts/starfive/jhb100.dtsi
> > @@ -4,6 +4,8 @@
> >   */
> >
> >  /dts-v1/;
> > +#include <dt-bindings/clock/starfive,jhb100-crg.h>
> > +#include <dt-bindings/reset/starfive,jhb100-crg.h>
> >
> >  / {
> >  	compatible =3D "starfive,jhb100";
> > @@ -268,12 +270,96 @@ pmu {
> >  			<0x00 0x22 0xFFFFFFFF 0xFFFFFF22 0x00007FF8>;	/* Event
> ID 34 */
> >  	};
> >
> > -	clk_uart: clk-uart {
> > -		compatible =3D "fixed-clock"; /* Initial clock handler for UART */
> > +	osc: osc {
> > +		compatible =3D "fixed-clock";
> >  		#clock-cells =3D <0>;
> >  		clock-frequency =3D <25000000>;
> >  	};
>=20
> Is this really on the SoC?

This is not on the SoC.

>=20
> >
> > +	pll0: pll0 {
> > +		compatible =3D "fixed-clock";
> > +		#clock-cells =3D <0>;
> > +		clock-frequency =3D <2400000000>;
> > +	};
>=20
> What's providing all of these PLLs? Are they all fixed-frequency on-chip =
PLLs
> without an off-chip reference? I find that somewhat unlikely.
>=20
> Since devicetrees are now being imported into U-Boot, it's important to m=
ake
> sure that I'm not merging fixed-clocks that later get replaced by dedicat=
ed
> drivers that U-Boot won't have.
>=20
> To that end, I won't apply the series this depends on without this patch =
being
> applied at the same time.

I am preparing a PLL driver series, but PLL0 and PLL1 will still retain fix=
ed frequencies.=20
The reference clock for each PLL comes from the osc. Perhaps I can use "fix=
ed-factor-clock"=20
to indicate the relationship of the reference clock.

Best Regards,
Changhuang

