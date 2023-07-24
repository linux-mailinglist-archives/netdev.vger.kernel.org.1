Return-Path: <netdev+bounces-20394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A563A75F502
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 13:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE7F1C20B09
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964595691;
	Mon, 24 Jul 2023 11:29:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C44C63A8
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 11:29:50 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E89310C0;
	Mon, 24 Jul 2023 04:29:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSH2m9v+dZxJ5jKL3/sryTQybwmWNxfc+lnHwRTpM9xogXHzSYPjOQ1W5HmVLrFMj0snbtJdXoRk1GArvnQEDA+7Ide6zytF3yxGmKwP9OtawwPHyf/zV1Ibore7qY2dh9l6+q+bL2mWN4FIoBICgq+NhPu4zNDfRPlsf48J2xM5rk72QSvkX2QAWWJtCPfitc6HJiXKCGLxCoA/KSsQ+BKH12AKFkIYUI375+oNM/Ob7rUi59IEqWN/5oQJtbdvs5gUQy1/kLW64G9Yy/f7mXsNG8s9Xzwk9rXKJynwodrgDY5+IqjUuhkYyvLDihy+YGm6t3CfUVTnGRIjNIRPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZD4iWGq2LGQ4kfWzpg8OSRudcEOqbDpQUXBgWTForMM=;
 b=CcWhMq5zTxZmjTMgj09B+0jdhunq4aqYH49AwBKrRfFWjD46EjDniVGUY9dD9TS0CHUZji6PciRjEazhYTBwCz4D82qnVsUWGDIofzWffmuXdceBURpNMYTXnRjtSS8aIWHOpBNrFCSRAWLOiigpXVVlx19RDcxWswntG2ekDgQNDaUIEFJjjGNFSgkPOFG58HcqhveGorxPoS14wqs4Swe/9g3WkraO3JBKp2hl9V+ccg4aebhfLohsbYI669xd8E4vw4CpQiGliV5X/Dw2pNTOsKvBCuBdpqh8fy32ljOq5QH21GOiffqb2XXFfpPvtipkQ5vuFWyMXrr8fSbclw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZD4iWGq2LGQ4kfWzpg8OSRudcEOqbDpQUXBgWTForMM=;
 b=DzHqpg8vluNx/65r6yJOkbWE4wMdyKJbZXAqGIs/XtllOBrNqquMgY6rBGGC90G/mT0SClf+2HrlkMekR8m8upJ1NUG0zoGgKCCJuph6JQ168j8V7y2lzT9ARwqBl0XbY8pO7SnbyDiU8f42kkGTP5YuPafSweLbRYnxKXpctiENzXRdx2h4XTEx/xdOfAWhJ9eJDR5rre1joxx+nfTUIobWl143e44VHMBfykw14O49rCHeDyU+MWfyzGPj4FEbScxMXj2b7BIwwLGn/x69k7E8im5fKxLrZwBJRsHR7QGU/Z2auyA+WdM6HgFpVmTRx6keRXTP5XF1A6iyw/DpiA==
Received: from BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22)
 by DM4PR12MB7528.namprd12.prod.outlook.com (2603:10b6:8:110::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 11:29:39 +0000
Received: from BL3PR12MB6450.namprd12.prod.outlook.com
 ([fe80::8dd4:fb0b:cea7:fce0]) by BL3PR12MB6450.namprd12.prod.outlook.com
 ([fe80::8dd4:fb0b:cea7:fce0%4]) with mapi id 15.20.6609.022; Mon, 24 Jul 2023
 11:29:39 +0000
From: Revanth Kumar Uppala <ruppala@nvidia.com>
To: Russell King <linux@armlinux.org.uk>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Narayan Reddy
	<narayanr@nvidia.com>
Subject: RE: [PATCH 4/4] net: phy: aqr113c: Enable Wake-on-LAN (WOL)
Thread-Topic: [PATCH 4/4] net: phy: aqr113c: Enable Wake-on-LAN (WOL)
Thread-Index: AQHZqb430S9qped/xEmn85gOamKO/a+gOXuAgCixmQA=
Date: Mon, 24 Jul 2023 11:29:39 +0000
Message-ID:
 <BL3PR12MB64507235FB47CDF03C4C5669C302A@BL3PR12MB6450.namprd12.prod.outlook.com>
References: <20230628124326.55732-1-ruppala@nvidia.com>
 <20230628124326.55732-4-ruppala@nvidia.com>
 <ZJw48a4eH0em8kjW@shell.armlinux.org.uk>
In-Reply-To: <ZJw48a4eH0em8kjW@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6450:EE_|DM4PR12MB7528:EE_
x-ms-office365-filtering-correlation-id: cad09f0c-a479-4af6-4fe5-08db8c3944bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zOdK4N6KOcEHtfQCJP+MFKB4qaZo7kZCOKsP1NiojU2iJX9P/GHcLVp12EM8VNh2T5iMP9Qs7Pz+gMSx3cr35sts6c/H85GluvYH9slttlRyVv9drs2t0VcKPcU2E/KCzT9HoDpioX24SmQ9p3v4uv1DvRoH3tY5aQ0kmQoOCIyKa9J/bBx3IvXR4oRl4G/QX4yMNRRTy7JNN/uGkk3GPXyWjbpGJErT/9wcFDJc38ZHoSCNEOimZOwvwrNu2rVcj6sx9OSxfldUjbuLGZfKRc+f1hyQj7wlTTuIGbDVSM1ZsQu5oczhGMgkiztV4MFOqMTcXoPX9F98RO/SGllgWC0jXfqMfQCrxed6VLXtJ8snTU//A+kS3OrmXeiFqRI0bjPF6v+lP26DAeUyfTEJ74ttJdWYnJPv4fv5XTUt9I2pxiKQoxZa2EWxw//Dql9MqVgK80bPn/Z5BijlgHBjoXTMYwGDpoEFzbyl57dLzlZ3lPH2mrbbbGtQPLpdHpTfIG+hSzugbN1ib7HOGFdD46gwsJQO0u1wM029mPmOqNN2INDbFQXINiYWABT3gcu0kJcMsntNOg+H+eSs+k+GDlTMFQMxMO6FBGLP6PQUWx0RvAwogBie/3mDp5hAzskAf7Coaga6XciqnrZeTPMCUBLwNS21eDfQfTLyWJ0ovXc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6450.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199021)(66556008)(66446008)(66476007)(66946007)(64756008)(8676002)(8936002)(6916009)(316002)(4326008)(86362001)(76116006)(33656002)(38070700005)(83380400001)(122000001)(2906002)(41300700001)(52536014)(38100700002)(5660300002)(478600001)(55016003)(54906003)(71200400001)(107886003)(6506007)(7696005)(9686003)(966005)(53546011)(186003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CNS+RHS1ayLSWoo2Lgcj2Vc9Tam1kpC1lSdpnekwWVZW7P3z09dYHzgm9zI5?=
 =?us-ascii?Q?Sii4rnrrUd+n50cRMBd1WREFtMTP73KTda42IBR/TzhpyBEEWYbNPA8LjHii?=
 =?us-ascii?Q?n3T1dHbLF/QtTUabViBYJgOrOQfS4HG73E9trV5tTBtpfxSdYJtRL7Bd/TZD?=
 =?us-ascii?Q?168iSVUos6j8hs4Td0btqImEm77kuerFdBCKBpEBNsiC2fKRwwERz7jxs4J3?=
 =?us-ascii?Q?xeVGE1BHwgsFKNmgJIKCIrPTbB86aBiIkG357ji10fMvB0SFaXpFBHdem0Ty?=
 =?us-ascii?Q?ZtuEYrzmKRTryeghHuJpjGD27u189zMs0eY5JpNKDakmTdKIuehewFYS0CLT?=
 =?us-ascii?Q?W6HRvZFZvxBH9zSAxPQ+L8DZ7wi5i5u4zY9p6KG1t1/dWhEpbL4ZGqhD7cdk?=
 =?us-ascii?Q?GUSlBRsShosIHz6QrHTrhuzN3aODPzvVmQcCqGsSXin1WnEQGOIlBKcNXmes?=
 =?us-ascii?Q?zlqsZujSv2bHraNrBoU/J80pQI5p+R9PvpvbRxtHkarYlD+AZwPNYEOhHHUn?=
 =?us-ascii?Q?1tFyASVZuBSlnVMlbL0zFA1v1TLvijwCLFL91o0AHLo+YU9Cxaqr+2lVfXIe?=
 =?us-ascii?Q?ireSNQeWr6G0jR9TIfl4uv+Sil5MuJ2WcHFo+QuxAtyS/uEgrSlRroBJ1s/a?=
 =?us-ascii?Q?lr27H2ACEyZVHGu1zG9CaNvAFH3W3t/wZXB/ORsEmQkjM9yUofYqsGh4FXew?=
 =?us-ascii?Q?qygOwWfo3+RlIbPINJx7nj0ZIvi8va+qyM1WZ3c219bbtbWW3/RUeNtz8HFY?=
 =?us-ascii?Q?qbyeTBssN+SI89Vu/gG9N27FdoyUCvtuSfNrzLydsxHb3uy2l9/ishlFTNvL?=
 =?us-ascii?Q?Qgo2nqQ77seN2FH+A2NHzmMG+agjBPSdCgpG0f29DfeOGt1VXSl0UzJRsqi1?=
 =?us-ascii?Q?u/yw6SEqI9Zexs4kkcHw27z5qOmr60DXKLAaGngmioV6lDhGgGro/HmtQQKk?=
 =?us-ascii?Q?T9obi2v8Yz260wTJ3AqvuVX8xmvYOFKLmjiRHulz+/FOaSRD2+mW9JAhEwnH?=
 =?us-ascii?Q?K8IKRT2chdks7gX6TdH44JHA19Ql7jm0yc61jyKdhkd3l1z88iL8cNNL7BDk?=
 =?us-ascii?Q?rTX89vf2S37ubOY8H/Dx+7U7tCKmu/gQ2DgVmNeTS2Kx2wyBAjdPtnvz+/qQ?=
 =?us-ascii?Q?dwIdJzOi4tNo7A78IkTZZva06lPXYk3+IV5TK8QFlIyRKJmV3212RygObbvm?=
 =?us-ascii?Q?arl1rtZV1wIvpGDzq7hv1ULohrOA2+EbaNHwJGHSh+O0Ej1yoyakd1Mkt+qq?=
 =?us-ascii?Q?oiWKTQP7J0YkeD+arL8nlU4jNnq6BuSEuQxCG7Ymov8NM5il6CspA3/nRPYM?=
 =?us-ascii?Q?vnTkBdWCP4T3dnW1nu1sXuy+9WaYJSpWqYfgoSKzxAF0XxDT2sX2ZNLyWEeC?=
 =?us-ascii?Q?2ei0+04+HXgXO071L7dzGSdvIr7cfFVnZKAV1zi2qCSVVTZXG+svXFJ7zCiq?=
 =?us-ascii?Q?o3Z16o1oaBlfuXy5tt2DQBszcqJDLbzluYBnEs2wAlEJxYVOvhCxMyQ71vct?=
 =?us-ascii?Q?BvQYgvn0NRi46dHJD4JKMw3jA9jvzpQAGnGaizXQFUGUfY20/Ek9iu58bFHF?=
 =?us-ascii?Q?Mu9Hw9yjJM27x3XiKI0vn6qFQqte+MkOYPIbrx1D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6450.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad09f0c-a479-4af6-4fe5-08db8c3944bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 11:29:39.6965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VbfiePE8qGAy3/BZL4uUrWuh7SIt5glGc5gNiicTmx6+AsaQXV6o/Ki1hsh4T414E03LnJ1sQSY/sbGYVNL4zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7528
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Russell King <linux@armlinux.org.uk>
> Sent: Wednesday, June 28, 2023 7:13 PM
> To: Revanth Kumar Uppala <ruppala@nvidia.com>
> Cc: andrew@lunn.ch; hkallweit1@gmail.com; netdev@vger.kernel.org; linux-
> tegra@vger.kernel.org; Narayan Reddy <narayanr@nvidia.com>
> Subject: Re: [PATCH 4/4] net: phy: aqr113c: Enable Wake-on-LAN (WOL)
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Wed, Jun 28, 2023 at 06:13:26PM +0530, Revanth Kumar Uppala wrote:
> > @@ -109,6 +134,10 @@
> >  #define VEND1_GLOBAL_CFG_10M                 0x0310
> >  #define VEND1_GLOBAL_CFG_100M                        0x031b
> >  #define VEND1_GLOBAL_CFG_1G                  0x031c
> > +#define VEND1_GLOBAL_SYS_CONFIG_SGMII   (BIT(0) | BIT(1))
> > +#define VEND1_GLOBAL_SYS_CONFIG_AN      BIT(3)
> > +#define VEND1_GLOBAL_SYS_CONFIG_XFI     BIT(8)
>=20
> My understanding is that bits 2:0 are a _bitfield_ and not individual bit=
s, which
> contain the following values:
I will define bitfield instead of defining individual bits in V2 series
>=20
> 0 - 10GBASE-R (XFI if you really want to call it that)
> 3 - SGMII
> 4 - OCSGMII (2.5G)
> 6 - 5GBASE-R (XFI5G if you really want to call it that)
>=20
> Bit 3 controls whether the SGMII control word is used, and this is the on=
ly
> applicable mode.
>=20
> Bit 8 is already defined - it's part of the rate adaption mode field, see
> VEND1_GLOBAL_CFG_RATE_ADAPT and
> VEND1_GLOBAL_CFG_RATE_ADAPT_PAUSE.
Sure, I will use above mentioned macros and will set the register values wi=
th help of FIELD_PREP in V2 series
>=20
> These bits apply to all the VEND1_GLOBAL_CFG_* registers, so these should=
 be
> defined after the last register (0x031f).
Will take care of this.
>=20
> > +static int aqr113c_wol_enable(struct phy_device *phydev) {
> > +     struct aqr107_priv *priv =3D phydev->priv;
> > +     u16 val;
> > +     int ret;
> > +
> > +     /* Disables all advertised speeds except for the WoL
> > +      * speed (100BASE-TX FD or 1000BASE-T)
> > +      * This is set as per the APP note from Marvel
> > +      */
> > +     ret =3D phy_set_bits_mmd(phydev, MDIO_MMD_AN,
> MDIO_AN_10GBT_CTRL,
> > +                            MDIO_AN_LD_LOOP_TIMING_ABILITY);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret =3D phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_VEND_PROV);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     val =3D (ret & MDIO_AN_VEND_MASK) |
> > +           (MDIO_AN_VEND_PROV_AQRATE_DWN_SHFT_CAP |
> MDIO_AN_VEND_PROV_1000BASET_FULL);
> > +     ret =3D phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_VEND_PROV,
> val);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /* Enable the magic frame and wake up frame detection for the PHY=
 */
> > +     ret =3D phy_set_bits_mmd(phydev, MDIO_MMD_C22EXT,
> MDIO_C22EXT_GBE_PHY_RSI1_CTRL6,
> > +                            MDIO_C22EXT_RSI_WAKE_UP_FRAME_DETECTION);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret =3D phy_set_bits_mmd(phydev, MDIO_MMD_C22EXT,
> MDIO_C22EXT_GBE_PHY_RSI1_CTRL7,
> > +                            MDIO_C22EXT_RSI_MAGIC_PKT_FRAME_DETECTION)=
;
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /* Set the WoL enable bit */
> > +     ret =3D phy_set_bits_mmd(phydev, MDIO_MMD_AN,
> MDIO_AN_RSVD_VEND_PROV1,
> > +                            MDIO_MMD_AN_WOL_ENABLE);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /* Set the WoL INT_N trigger bit */
> > +     ret =3D phy_set_bits_mmd(phydev, MDIO_MMD_C22EXT,
> MDIO_C22EXT_GBE_PHY_RSI1_CTRL8,
> > +                            MDIO_C22EXT_RSI_WOL_FCS_MONITOR_MODE);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /* Enable Interrupt INT_N Generation at pin level */
> > +     ret =3D phy_set_bits_mmd(phydev, MDIO_MMD_C22EXT,
> MDIO_C22EXT_GBE_PHY_SGMII_TX_INT_MASK1,
> > +                            MDIO_C22EXT_SGMII0_WAKE_UP_FRAME_MASK |
> > +                            MDIO_C22EXT_SGMII0_MAGIC_PKT_FRAME_MASK);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret =3D phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
> VEND1_GLOBAL_INT_STD_MASK,
> > +                            VEND1_GLOBAL_INT_STD_MASK_ALL);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret =3D phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
> VEND1_GLOBAL_INT_VEND_MASK,
> > +                            VEND1_GLOBAL_INT_VEND_MASK_GBE);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /* Set the system interface to SGMII */
> > +     ret =3D phy_write_mmd(phydev, MDIO_MMD_VEND1,
> > +                         VEND1_GLOBAL_CFG_100M,
> VEND1_GLOBAL_SYS_CONFIG_SGMII |
> > +                         VEND1_GLOBAL_SYS_CONFIG_AN);
>=20
> How do you know that SGMII should be used for 100M?
>=20
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret =3D phy_write_mmd(phydev, MDIO_MMD_VEND1,
> > +                         VEND1_GLOBAL_CFG_1G,
> VEND1_GLOBAL_SYS_CONFIG_SGMII |
> > +                         VEND1_GLOBAL_SYS_CONFIG_AN);
>=20
> How do you know that SGMII should be used for 1G?
>=20
> Doesn't this depend on the configuration of the host MAC and the capabili=
ties of
> it? If the host MAC only supports 10G, doesn't this break stuff?
>=20
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /* restart auto-negotiation */
> > +     genphy_c45_restart_aneg(phydev);
> > +     priv->wol_status =3D 1;
> > +
> > +     return 0;
> > +}
> > +
> > +static int aqr113c_wol_disable(struct phy_device *phydev) {
> > +     struct aqr107_priv *priv =3D phydev->priv;
> > +     int ret;
> > +
> > +     /* Disable the WoL enable bit */
> > +     ret =3D phy_clear_bits_mmd(phydev, MDIO_MMD_AN,
> MDIO_AN_RSVD_VEND_PROV1,
> > +                              MDIO_MMD_AN_WOL_ENABLE);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /* Restore the SERDES/System Interface back to the XFI mode */
> > +     ret =3D phy_write_mmd(phydev, MDIO_MMD_VEND1,
> > +                         VEND1_GLOBAL_CFG_100M,
> VEND1_GLOBAL_SYS_CONFIG_XFI);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret =3D phy_write_mmd(phydev, MDIO_MMD_VEND1,
> > +                         VEND1_GLOBAL_CFG_1G, VEND1_GLOBAL_SYS_CONFIG_=
XFI);
> > +     if (ret < 0)
> > +             return ret;
>=20
> Conversely, how do you know that configuring 100M/1G to use 10GBASE-R on
> the host interface is how the PHY was provisioned in firmware? I think at=
 the
> very least, you should be leaving these settings alone until you know tha=
t the
> system is entering a low power mode, saving the settings, and restoring t=
hem
> when you wake up.

Regarding all the above comments ,
We are following the app note AN-N4209 by Marvell semiconductors for enabli=
ng and disabling of WOL.
Below are the steps in brief as mentioned in app note
For enabling the WOL,
1. Set the MAC address for the PHY. Make sure the MAC address is a legal ad=
dress=20
2. Disables all advertised speeds except for the WoL speed (100BASE-TX FD o=
r 1000BASE-T)
3. Enable the magic frame and wake up frame detection for the PHY
4. Set the WoL enable bit
5. Set the WoL INT_N trigger bit
6. Optional: Enable Interrupt INT_N Generation at pin level
7. Set the system interface to SGMII by writing into below registers
MDIO Write 1e.31b =3D 0x0b (Sets SGMII for 100M)=20
MDIO Write 1e.31c =3D 0x0b (Sets SGMII for 1G)
8. Perform a link re-negotiation/auto-negotiation
9. The WoL status bit should be 1 which indicates that the WoL is active. T=
he PHY now is in sleep mode

For remote WAKEUP via magic packet,
1.MAC detects INT from PHY and confirm Wake request.
2. Disable the WoL mode by unsetting the WoL enable bit.
3. Restore the SERDES/System Interface back to the original mode before WoL=
 was initialized using SGMII mode i.e; back to XFI mode.
MDIO write 1e.31b =3D 0x100 (Reverts the 100M setup to original mode)
MDIO write 1e.31c =3D 0x100 (Reverts the 1G setup to original mode
4. Perform an auto-negotiation for the register values to take effect and e=
stablish a proper link

Thanks,
Revanth Uppala=20
>=20
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

