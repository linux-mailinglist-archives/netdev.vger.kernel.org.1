Return-Path: <netdev+bounces-21467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC60763A84
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 17:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9051C2110B
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0278DC2CF;
	Wed, 26 Jul 2023 15:11:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB171DA20
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:11:29 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on060f.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::60f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE40A268C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 08:11:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTRxwqFBAVRzM9I2oLQZ054wnIVZtii+XVxCF6+wTmO8errk3qcE8G8imkeQP6WcSOaRZKCdAYEl4ihAAQ3JweCU2SZXJs25HyYeafqj1LXT8taL4g+yTvJZ+MVkg1nU72Kca9gQ9MvweBWrLmfTH5YDUvCrYANZ7dRxyTab9lR/SCWq3E6iRIaZs//N42IgFA2AeTc0s9Oapdwf7yP1oXromKhBGglgtS8lrQwAzoelALI2OdeoY0+S8muBJR5o5YtIGNh1GgW4Ca089M+vmRZZyND+0+CDnr3HkOjh+f+Fjibv2RsCjAPeoUvkUtZcbSW375SYxlgSawhVRG+ycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXtPt40fo/Irmsx3f6WbyKoaMRTiYztbv2MB3yaP+/w=;
 b=e9MkbqiTdWnaKq8f25l+stYaOGSfgPJlMUEs9W4ljdi8EE3ImYqOQKHI1hZyL9XZ0+WN3fYjnRv9iva/3vA/pSb/NmQc93rQflrQoH8ZdeWMhkZvTFIFNMayJ+2NiZd5p3u4JCBe79mybAr+DfT6RB8yNdj91vYDKBGiGrENBRdgOrdS3x27RM+RWEr15iUJvmBAU3mf8wnJa2ctLLxWzhfC0LYPE/lcbtNG1d8R1Vc2X2yfF96WDOenRkf6nECR0w86AKVV/DcrEezUXPHBFn0jgk6Z1Eori/JlWvmHgV7CU/Kxey+Xomb2hcMaKBgcmOmbjdKoiuDiFRHTrHYROw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXtPt40fo/Irmsx3f6WbyKoaMRTiYztbv2MB3yaP+/w=;
 b=TtuE/rytQdEPPtGPYNIreni3mKfddhaTB9k6KlWm7jus/AVYcLJeBQS6AR1Bpi/bp07ejy4hYLDtCt9fofVLRtW61HzilZGUCiytB785JprXNNoDQOPhA6Wol94FSYsOGPuf0DKjJ1byv7BqakFwLDVH9HO6CYzVb3TNpmuwc9Q=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by GV1PR04MB9514.eurprd04.prod.outlook.com (2603:10a6:150:20::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 15:10:19 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 15:10:19 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Vladimir Oltean <olteanv@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo
	<shawnguo@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Russell King
	<linux@armlinux.org.uk>, Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
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
Thread-Index: AQHZvzEtwr0cB5x9EUCXrQC85+we9K/LNgwAgADv2GA=
Date: Wed, 26 Jul 2023 15:10:19 +0000
Message-ID:
 <PAXPR04MB9185C1A95E101AC2E08639B78900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230725194931.1989102-1-shenwei.wang@nxp.com>
 <20230726004338.6i354ue576hb35of@skbuf>
In-Reply-To: <20230726004338.6i354ue576hb35of@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|GV1PR04MB9514:EE_
x-ms-office365-filtering-correlation-id: a867089d-03ae-4288-f7e5-08db8dea6d04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ob6ZWBHwiVRolLi2hJZ4IOe2fhWF4Q9G5n32il9ghOGfHUJ2l4rHE64RKRPD/a3/qoncmfOi5P41x2jAy8mMCWZbE9bxOsvQRiy8T8lZk02nUHCDJ+piOqLbCY5FVv30oC+GcfU/HPfVKYiBFRs9f4jsgD8vXebt3nHrJNM6uOCBAmQXgbQ07X2joYRxEMG1cQ59kqQvVBPcv1zIfs6uMV/VXjhL4s2sO+jqu1GhVNRZ4mTjvTXBphNLWPexe1LA9ePpTb/eQY8T/hlyB9EKTMtX9C/CidA5GKO0rfdkFxw79uu24hwJZ/UiPhexD5CR1zP84ncT0MWtkuTPj9eojn6jYB0M0XWij9FR0FaOcHrkDv1ItfFTnhVGcfF3VjCfdQr1kFvxXg1bXy76ee23Iqe8NWUTnCJuJDDkK01pQjhHp9s3fSbGKOWMUh9z5oq8YFOsoHgQ2LPTnpExOFYI6Ht1J9wM4n/wjqAVtZXbKd5733ARGfNrd85SkghboOVDyLNEShjwTKcwlVq9WAFo/rBiWBGH6G144NsmPw6C15YrLmVJz4B5+qkYE0AHe3XwC5efltxSY+zicQcJQGfyHEewMfEVW5+/mAaQM+EciUWxWtnNIT/m5TQOCwhfO8S4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(451199021)(7696005)(71200400001)(478600001)(83380400001)(6506007)(55236004)(26005)(53546011)(9686003)(6916009)(4326008)(122000001)(54906003)(66476007)(66946007)(66446008)(76116006)(64756008)(66556008)(186003)(38100700002)(38070700005)(52536014)(44832011)(7416002)(8936002)(8676002)(33656002)(5660300002)(2906002)(316002)(41300700001)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AFKva83H5njoeYog5L+aXmWhZJ1o1SqhLPtNaJ/NPVyOBarW46SMc/ykHQvg?=
 =?us-ascii?Q?GrReioaYW4FnMka0wfZR3Vz0wqajcvflpDUxTTCu4iFyCD5I/y+h6LJ3eIiP?=
 =?us-ascii?Q?UOpVaPn+ijrhF8fZtPWWc76ufdpA1X+PDbby6seyH80mYezk5ZqDACy4ZO9e?=
 =?us-ascii?Q?zzLs1r2WF2lu6zE35H7SCLZsXSQqB2Gn3oqN4IWbu2iS3JouBH8ZpVXBs+E6?=
 =?us-ascii?Q?OFNq5K5H/sFIYzFXOIwZUQG6GARP6K6oGnFtW6wmub4rwz/TNEjfQQBCTZyY?=
 =?us-ascii?Q?JSBkJHKzEy5QxxogzdolEfGlLukjYMqZwEft7a0mR1YYqA7cfhtAuEXmw+K1?=
 =?us-ascii?Q?wmpkUYpk7PQyKWacpReKmjkc1CkzkgTwf+5OZi3wEUSoGEU8aH+WyBTVDG8/?=
 =?us-ascii?Q?H8IuPfLw3XIcgjUoteBTBTAOViTipK4UwJxgbtKPEEt97Bmh2PoL7EHotUqB?=
 =?us-ascii?Q?pgkcbCr6RvSSZVxhgZ+fhJXzXfaxr3ClWxXioH+vzuITG7akL9pAq1UVmuQN?=
 =?us-ascii?Q?z4llkA1pzQbF3KaL+GhycNri/sxqlGVeWCyEvuftdemDFRrmo/bY8orj3n7I?=
 =?us-ascii?Q?nKVOSPQlY9izXMe2lHXDMzPKTbv6+YBHK42HfUlRr545JeYawF3h5/bg/hpa?=
 =?us-ascii?Q?o61Y1jZdvgwFKn14oZ3CpOaw1agTfSq1GBnVR38WowntU/6yruZHeavVO0zI?=
 =?us-ascii?Q?18B+yb+HIrD+O81BRseuULpXywpHjFxrNWHROf2w4D8VxnyQ3gVSgISBoeDh?=
 =?us-ascii?Q?jwZV2IG70X/xdPo9i3qcwVk3sntJyjcFoXN02o8XtrWXo1Csdeh1/Udz4b5r?=
 =?us-ascii?Q?ha4JOXPJKB7u59uKpVUnmRPykD44sh6cjZnMAIZyAOO/d+7NM+4vpLdXwYYh?=
 =?us-ascii?Q?KLa4aMAx17NOAxZV33YBWJ5+yPLgUntFGwi2SKLx0CpPZ5A5jizcutLZTVpu?=
 =?us-ascii?Q?3V0rWgRzlxKuBEKajvYh2gr0QT8x8DFnCpQE5sMo50ad5zI7WoBqbMqGBH8A?=
 =?us-ascii?Q?FkcLwXdw6UoFv/KGx2MLWRTQWfnyXpVQGR2psPy3ggH/ZSviveNrS7WRh61o?=
 =?us-ascii?Q?3TKzyicUPt4B0xAouC5G9TvQC9F1mw5+2eLikexbbwu2+NGcse7228i7X7Po?=
 =?us-ascii?Q?MRFwPX/zQ2dLepscuuNLPT/K/tkQZmbsUi4NdWh4IQ2iHBR3asx9p00+p7Ko?=
 =?us-ascii?Q?lqz2KbIhh3cgAhCsoi2ycfYsQI36iGsc12/qs2sWvMKs4otiv86ez9791MMR?=
 =?us-ascii?Q?jGB/kLvZ6Rp0c/D5B+Gji8+CwTTTYV+aOVaxr4sIQodBmqUdNsQ+6dGKcoKJ?=
 =?us-ascii?Q?OS5+a44l4/3L9hFDBXZaPRk+CdL2a/H9ICxBQyiCupDXyld5DXCnNmKAlYiU?=
 =?us-ascii?Q?3zLi5hoeecUmoOyzC2R3Q8ZbIyz8y2QL3RrwkM6BLCh3iGOVoGc0RYLydi0v?=
 =?us-ascii?Q?LhOV5/04gveiMMxcOsly2FT9fDFt+E7aP+EBNO1XFaArFmINEHUNC5Gue4eV?=
 =?us-ascii?Q?/KYe5Jtvb+ce2uaTVY6+tCZyM060Ugi4256/Mq44OAwTSDs6wXg7Bn+82F7M?=
 =?us-ascii?Q?A3nALgdoxjm8eu73tF4+ox+TODWUV9g3hKlHFJ5U?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a867089d-03ae-4288-f7e5-08db8dea6d04
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 15:10:19.3821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wy8UlhAFI3i7M3vN+HJcpx7ZJ1bEjrZdbp5S7fsykFZe0w+cWhNHMhS8Lu/ziovUsopUIokLe8XQkNCrRQ9Gdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9514
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Vladimir Oltean <olteanv@gmail.com>
> Sent: Tuesday, July 25, 2023 7:44 PM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Maxime Coquelin <mcoquelin.stm32@gmail.com>;
> Shawn Guo <shawnguo@kernel.org>; dl-linux-imx <linux-imx@nxp.com>;
> Russell King <linux@armlinux.org.uk>; Giuseppe Cavallaro
> <peppe.cavallaro@st.com>; Alexandre Torgue <alexandre.torgue@foss.st.com>=
;
> Jose Abreu <joabreu@synopsys.com>; Sascha Hauer <s.hauer@pengutronix.de>;
> Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; netdev@vger.kernel.org; linux-stm32@st-md-
> mailman.stormreply.com; linux-arm-kernel@lists.infradead.org;
> imx@lists.linux.dev; Frank Li <frank.li@nxp.com>
> Subject: [EXT] Re: [PATCH] net: stmmac: dwmac-imx: pause the TXC clock in
> fixed-link
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report =
this
> email' button
>=20
>=20
> Hi Shenwei,
>=20
> On Tue, Jul 25, 2023 at 02:49:31PM -0500, Shenwei Wang wrote:
> > When using a fixed-link setup, certain devices like the SJA1105
> > require a small pause in the TXC clock line to enable their internal
> > tunable delay line (TDL).
> >
> > To satisfy this requirement, this patch temporarily disables the TX
> > clock, and restarts it after a required period. This provides the
> > required silent interval on the clock line for SJA1105 to complete the
> > frequency transition and enable the internal TDLs.
> >
> > So far we have only enabled this feature on the i.MX93 platform.
> >
> > Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> > Reviewed-by: Frank Li <frank.li@nxp.com>
> > ---
>=20
> Sorry for not responding off-list. Super busy.
>=20
> I've tested both this patch on top of net-next as well as the lf-6.1.y ve=
rsion
> you've sent separately - on a cold boot in both cases. Both the
> i.MX93 base board and the SJA1105 EVB (powered by an external power suppl=
y)
> were cold booted.
>=20

As you can access the internal repo, you don't need this patch and can just=
 test the function directly on the
latest branch of lf-6.1.y.=20

> Unfortunately, the patch does not appear to work as intended, and ethtool=
 -S
> eth1 still shows no RX counter incrementing on the SJA1105 CPU port when =
used
> in RGMII mode (where the problem is).
>=20

I have two SJA1105 evaluation boards available, and both are functioning as=
 expected.

> >  .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 62 +++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> > b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> > index b9378a63f0e8..799aedeec094 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> > @@ -40,6 +40,9 @@
> >  #define DMA_BUS_MODE                 0x00001000
> >  #define DMA_BUS_MODE_SFT_RESET               (0x1 << 0)
> >  #define RMII_RESET_SPEED             (0x3 << 14)
> > +#define TEN_BASET_RESET_SPEED                (0x2 << 14)
> > +#define RGMII_RESET_SPEED            (0x0 << 14)
> > +#define CTRL_SPEED_MASK                      (0x3 << 14)
> >
> >  struct imx_dwmac_ops {
> >       u32 addr_width;
> > @@ -56,6 +59,7 @@ struct imx_priv_data {
> >       struct regmap *intf_regmap;
> >       u32 intf_reg_off;
> >       bool rmii_refclk_ext;
> > +     void __iomem *base_addr;
> >
> >       const struct imx_dwmac_ops *ops;
> >       struct plat_stmmacenet_data *plat_dat; @@ -212,6 +216,61 @@
> > static void imx_dwmac_fix_speed(void *priv, unsigned int speed)
> >               dev_err(dwmac->dev, "failed to set tx rate %lu\n",
> > rate);  }
> >
> > +static bool imx_dwmac_is_fixed_link(struct imx_priv_data *dwmac) {
> > +     struct plat_stmmacenet_data *plat_dat;
> > +     struct device_node *dn;
> > +
> > +     if (!dwmac || !dwmac->plat_dat)
> > +             return false;
> > +
> > +     plat_dat =3D dwmac->plat_dat;
> > +     dn =3D of_get_child_by_name(dwmac->dev->of_node, "fixed-link");
> > +     if (!dn)
> > +             return false;
> > +
> > +     if (plat_dat->phy_node =3D=3D dn || plat_dat->phylink_node =3D=3D=
 dn)
> > +             return true;
> > +
> > +     return false;
> > +}
>=20
> I'm really not sure what prompted the complication here, since instead of=
:
>=20
> if (imx_dwmac_is_fixed_link(dwmac)) {
>=20
> you can do:
>=20
> #include <linux/of_mdio.h>
>=20
> if (of_phy_is_fixed_link(dwmac->dev->of_node)) {
>=20

This does not help in this case. What I need to determine is if the PHY cur=
rently in use is a fixed-link.
The dwmac DTS node may have multiple PHY nodes defined, including both fixe=
d-link and real PHYs.

Thanks,
Shenwei

> and the latter has the advantage that it also matches (tested on imx93-11=
x11-
> evk-sja1105.dts). I've had to make this change for testing, because other=
wise,
> the workaround wasn't even executing. Other than that, I've done no other
> debugging.
>=20
> Considering the fact that you need to resend a functional version even in
> principle anyway, let's continue the discussion and debugging off-list.
>=20
> Ah, please be aware of the message from the kernel test robot which said =
that
> you're setting but not using the plat_dat variable in
> imx_dwmac_fix_speed_mx93().
> It's probably a remnant of what later became imx_dwmac_is_fixed_link(), b=
ut it
> still needs to be removed.

