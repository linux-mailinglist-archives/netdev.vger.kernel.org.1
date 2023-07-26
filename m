Return-Path: <netdev+bounces-21507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A26C763BD8
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 17:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49F5281D42
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C26137989;
	Wed, 26 Jul 2023 15:59:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675CB27734
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:59:44 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2072.outbound.protection.outlook.com [40.107.7.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777CE268C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 08:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeXJpazNcqZZJzC3HkrwkmkoPW0zXthIz4vlIHTKG4KmivaP9Fo+F1EeZE0m/meH6lAXVbb0XOv3fNvtvvs+aBOIX1SlSi1N3FwkGDW5iI/OroKgl/p2RDiRw06/k54sAWf6QiwK67qf5Y2lql509Juqb/5MMT0Zrddyd6J15rML1cS48dQRBygELiTSXvKfO7iOUXYEpZlLZNQSBhGLFBEWw3uPLDJZQ6zQZqVCTW0A0DEqaGCYWhbq4lyirN5BHZbQh5rzy5gXS9bWg4n3IGmmcZ1LgmLDPDFKHW4QX7GQRn+RlFP/u47HqiPxQ9cRDKjMS8OUbHMfpmeeM2Ui5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKLk4BgXZY0EquenSBa5i2KVy8wSESha6piVzonXAZU=;
 b=Fah4kyQGM6+N7CCDj/ftQ0mwGEFfH+LlRY3fqCdHUIgVeD7h8/9BoazHXpLxqF5li6sCvmOp0yK0tS8WzJ5K5JIWG2tjAiWxyrOvM7pL4RlH7mE3Kk6B5JeKsn29KadTHFjfaBVNur9LrJ/LCw8FAd0b0RXUsmNF0OvFKexL9l9R4kHZI3TIk4jPtMAvQX7taJjv+ECiXrfemXS7hVbcfWpPmuCUBMIY6VQV8lK1aINFB/bHDzInHMmoL1u8PGJPGiUrLOL9BaKBthKFx5514S6fByRutPKk9/wCe3TLJzm6+CpXOsNsYfvkKHKfXaLu/m/0b0zCQnFLb8JD/Y3RnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKLk4BgXZY0EquenSBa5i2KVy8wSESha6piVzonXAZU=;
 b=EyvWd/jK2kkCNIR3BypfCFcoXxh566V3qRxRSFkBpEW5Vtq5F3hN+MrvQ03znP98hTjmqwmw7TeRnV2B5g9o7/gehi4NVGJ2A9bACmbDc7FDROZ9XEu8gv5fablPeuAts4pZZS0qbIwokVkStiAnyLYWaoF7ND38IRreVKsnhwo=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AS8PR04MB8119.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 15:59:38 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 15:59:38 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Russell King <linux@armlinux.org.uk>
CC: Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>, dl-linux-imx
	<linux-imx@nxp.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>,
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, Frank Li <frank.li@nxp.com>
Subject: RE: [EXT] Re: [PATCH] net: stmmac: dwmac-imx: pause the TXC clock in
 fixed-link
Thread-Topic: [EXT] Re: [PATCH] net: stmmac: dwmac-imx: pause the TXC clock in
 fixed-link
Thread-Index: AQHZvzEtwr0cB5x9EUCXrQC85+we9K/LNgwAgADv2GCAAAekgIAABiMw
Date: Wed, 26 Jul 2023 15:59:38 +0000
Message-ID:
 <PAXPR04MB91856018959FE0752F1A27888900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230725194931.1989102-1-shenwei.wang@nxp.com>
 <20230726004338.6i354ue576hb35of@skbuf>
 <PAXPR04MB9185C1A95E101AC2E08639B78900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <ZME71epmSHYIB4DZ@shell.armlinux.org.uk>
In-Reply-To: <ZME71epmSHYIB4DZ@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|AS8PR04MB8119:EE_
x-ms-office365-filtering-correlation-id: 296d8b1c-360b-4d36-1c1c-08db8df150e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 QBI7YfU+EWmLGLimFCVFMitHfOGEOAma0N69xB0katX65cDvZm6BeyeywGc+/Ys48wbgkjId3D8/hF53xJ1H1pkCFKYpoW1MGA5anr+ajrsNA2kYQ1pXKW/d6bZR2RFQnOOfVqB31g354WOY0kfDop31PTl68kT5LQ/mkf3aZLYF5vHXpKxYzwhIwiXavAKDtORny00uk1lgADucl5+BgQz1h4y4Y2yH2HlgvpfKuBOe30nVECVixkotW6SLBM6123m944nkJsNT7mOAYaGO2YZOupWvxSw44K3YFxv48qKu9U4GjOlp86q49KRJIs6lcmyFDEI4siLPTcSlQqZ/J1kaextOC9CBs2WexgMW353hvs3JHxDFMl/YiTah2OwcvhnBq2qvkxxmChDTuLmlF6iPxIJgSG3y97ykrgNbCjsTuM67EvEfikjG9fP8+/TkatyZobEtMsc5FljZUCDLv414TSFJUgMfNDc4t/DmB0BLSOxLpfa/HGTZzwjmCqKjkw+4VNQOz4FPNK8pL6GP8gZDoLb/qL6DylWUjMts5nuRDcupeVOBqFNO6HuyvuvmZlU1t8MKw1zawH5EkJ/r6z72ZeBOtqD55W4WC9EDaUM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199021)(9686003)(54906003)(45080400002)(966005)(7696005)(478600001)(55236004)(26005)(53546011)(186003)(6506007)(2906002)(71200400001)(64756008)(66446008)(66556008)(66476007)(6916009)(4326008)(316002)(52536014)(66946007)(8676002)(7416002)(8936002)(5660300002)(44832011)(41300700001)(76116006)(122000001)(38100700002)(33656002)(55016003)(38070700005)(86362001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5cM7YIUkG1NUAn7nGQ97UygZDPsIwW3qJmVkCpUSQLBLl5bn60DFrdtdqnvE?=
 =?us-ascii?Q?XrcihWaUWWIi9nbQpYHxUu93vxPjTK0rs6jtpviqRgfb8A79bFcuyiiV71hu?=
 =?us-ascii?Q?y+gyXhEFXCqtokC3E5k5PkBjWJBwPXd2EUV9Q7ZOggThAPqxkG1ZnwVixcmb?=
 =?us-ascii?Q?YFH/Ji36cuMUGeOhapT7EktDhMOenY48i44T/qVmwdUa4r9yUUvmnuZCDEdm?=
 =?us-ascii?Q?fxpZ1b/0qgeGoz05czxHzNZM8MCUDXE3g/DFFOyRjsbjp58horIYbjDPuDk4?=
 =?us-ascii?Q?xB4ODMN5Na2kbjASLTraCL1TOP8q1GozoOy+s7q9W94XE+KhHiYr+3A16bpX?=
 =?us-ascii?Q?VkFGD9hGH2H+1bSFarja7PGK7uxIdypEMIzB+e5CUtf2COGp3tEs77rkp+uL?=
 =?us-ascii?Q?jZXIX9kIKALGAvwvBZrrlHr2M8oI6S8JI/fNqddGcymA9x5PfhLAXtdl+DD4?=
 =?us-ascii?Q?iTxY+a11J0hy3P9JUDM3ThRXXjm99MXgWfVLIk3AHFSWwKPPv5DcFq23C+KY?=
 =?us-ascii?Q?YmI4kW1xAvMZkKexLJdAPRlmye/SrWb8CsDY1ti3pv6GvCETCBrJZPLe2nCA?=
 =?us-ascii?Q?4jgJOVxS7KmW1Li/XnP/sOPD/QCSaX8p+zZx+SWvJXcTNYSw4QZwz5r49jSl?=
 =?us-ascii?Q?KApVRCrH7OsVf/RBP4lqr+83GmN3v/38hVYlG9nwJnOEBkhxtdxOa3hIkBIA?=
 =?us-ascii?Q?eZkljTzW+2+ZoUT1xWGat81fN8XkmZqTAprehwzuYjJphjNJAJCLsAjEb3/k?=
 =?us-ascii?Q?R8jwrXxkhlSnDZFjOokVv79h2L4MiI7unldGYUO5fEEvpIbGIDb832XvoBcM?=
 =?us-ascii?Q?kS2TejZII1CqOE1hfhJwQpRq/AR3eu9x7s8dNoOIrZplE9nbPwLKNs+wpSAv?=
 =?us-ascii?Q?+GyvguEyIZR6z2DTA6LlCpE4di/fYRMrgroJ1XofYLGPJ1SXmsOUyEVJ07JL?=
 =?us-ascii?Q?yIQexLiQTgAOGOwDm6PMUdvqMOPQ6umJqIr/4F+kHo/MT2E3gKlJmGWZP+6I?=
 =?us-ascii?Q?oXDzrdkW+a3Dc5rXQBwXDHWvAMldGITTc4PWHBKGYk6e88hnaMpdJK54YNms?=
 =?us-ascii?Q?RrVm8gadTqypUdjcrG7j/lRyaB+Rx80TkZWWAzZEUk/InUJlfp6wDXtHXFUr?=
 =?us-ascii?Q?8pwVFYQ+BM/ukOVpUmCxCswy6EvytFRVCx2M2okvAO+DBr3IwfaVhTm6mVBY?=
 =?us-ascii?Q?HGgJJ0b0obyIRU1krXTjh0eQgllLJlMn9GRWj5tTPSUFjoZTZ3revxTV48vu?=
 =?us-ascii?Q?q2UVfWSJsZw42B5do8XM1dZm84Dq6s7fUrYiCTiq1BN2pfcWB+tgOY/wTMNz?=
 =?us-ascii?Q?pK3GhFNTmYwhxZQiTMwQRhTCd2gJh2aSUUpygvPK2UCwUDIyQw/w8MlvxnxJ?=
 =?us-ascii?Q?UAyfRpz7RdbKmQ9qnSe8NWy/ucZfiuB7EE+bRuLD/F5bQiV3YNt/h6cJjIjq?=
 =?us-ascii?Q?fFluR7ZqurNVXtkMxeCDEdXcRXez4DMaBPppM9zsE78LXZCcCTRRRB1fpfgf?=
 =?us-ascii?Q?54c7JRXX+YLWtjRNy4jGgx6FEo9h3kt9BzccnA5sinJ+Y7QjlfNDNpVfdb5A?=
 =?us-ascii?Q?2+xH5gF+PcbrfWs/HYOyThfrRk2dOKfFwU2b3aUt?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 296d8b1c-360b-4d36-1c1c-08db8df150e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 15:59:38.6446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: txtrlGMIZj0AtCPTYbFwwGLFHI7CYgfo1P8YY67/lSt2SoXc2Rfe2MLoFARhrwH9hBOTULUub7l/8XE22hVsvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8119
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Russell King <linux@armlinux.org.uk>
> Sent: Wednesday, July 26, 2023 10:29 AM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: Vladimir Oltean <olteanv@gmail.com>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Maxime
> Coquelin <mcoquelin.stm32@gmail.com>; Shawn Guo <shawnguo@kernel.org>;
> dl-linux-imx <linux-imx@nxp.com>; Giuseppe Cavallaro
> <peppe.cavallaro@st.com>; Alexandre Torgue <alexandre.torgue@foss.st.com>=
;
> Jose Abreu <joabreu@synopsys.com>; Sascha Hauer <s.hauer@pengutronix.de>;
> Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; netdev@vger.kernel.org; linux-stm32@st-md-
> mailman.stormreply.com; linux-arm-kernel@lists.infradead.org;
> imx@lists.linux.dev; Frank Li <frank.li@nxp.com>
> Subject: Re: [EXT] Re: [PATCH] net: stmmac: dwmac-imx: pause the TXC cloc=
k in
> fixed-link
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report =
this
> email' button
>
>
> On Wed, Jul 26, 2023 at 03:10:19PM +0000, Shenwei Wang wrote:
> > > if (of_phy_is_fixed_link(dwmac->dev->of_node)) {
> > >
> >
> > This does not help in this case. What I need to determine is if the PHY=
 currently
> in use is a fixed-link.
> > The dwmac DTS node may have multiple PHY nodes defined, including both
> fixed-link and real PHYs.
>
> ... and this makes me wonder what DT node structure you think would descr=
ibe a
> fixed-link.
>
> A valid ethernet device node would be:
>
>         dwmac-node {
>                 phy-handle =3D <&phy1>;
>         };
>
> In this case:
>         dwmac->dev->of_node points at "dwmac-node"
>         plat->phylink_node points at "dwmac-node"
>         plat->phy_node points at "phy1"
>         Your "dn" is NULL.
>         Therefore, your imx_dwmac_is_fixed_link() returns false.
>
>         dwmac-node {
>                 fixed-link {
>                         speed =3D <...>;
>                         full-duplex;
>                 };
>         };
>
> In this case:
>         dwmac->dev->of_node points at "dwmac-node"
>         plat->phylink_node points at "dwmac-node"
>         plat->phy_node is NULL
>         Your "dn" points at the "fixed-link" node.
>         Therefore, your imx_dwmac_is_fixed_link() also returns false.
>
> Now, as far as your comment "What I need to determine is if the PHY curre=
ntly
> in use is a fixed-link." I'm just going "Eh? What?" at that, because it m=
akes zero
> sense to me.
>
> stmmac uses phylink. phylink doesn't use a PHY for fixed-links, unlike th=
e old
> phylib-based fixed-link implementation that software-emulated a clause-22=
 PHY.
> With phylink, when fixed-link is specified, there is _no_ PHY.

So you mean the fixed-link node will always be the highest priority to be u=
sed in the phylink
use case?  If so, I just need to check if there is a fixed-link node as Vla=
dimir pointed out, right?

>
> There is no need to do any of this poking about to determine if the link =
that is
> being brought up is a fixed-link or not, because phylink's callbacks into=
 the MAC
> driver already contain this information in the "mode" argument. However, =
that
> is not passed to the driver's internal
> priv->plat->fix_mac_speed() method - but this is the information you
> need.
>

Yes, you are right. The best way is to change the fix_mac_speed prototype b=
ut it
will change several other platforms. That's why I didn't go that way.

Thanks,
Shenwei

> There is no need to write code to try and second-guess this, phylink tell=
s drivers
> what mode it is operating under.
>
> stmmac really needs to be cleaned up - and really doesn't need more compl=
exity
> when the information is already being provided to the driver.
>
> --
> RMK's Patch system:
> https://www.ar/
> mlinux.org.uk%2Fdeveloper%2Fpatches%2F&data=3D05%7C01%7Cshenwei.wang
> %40nxp.com%7C3d20eec67cbe49ecdbf008db8ded1aab%7C686ea1d3bc2b4c6fa
> 92cd99c5c301635%7C0%7C0%7C638259821712485867%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn0%3D%7C3000%7C%7C%7C&sdata=3DpMle7Mu4ed57Qjf7DR2PPQ67F5oKq9qr
> GRG%2BNMpSMDM%3D&reserved=3D0
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

