Return-Path: <netdev+bounces-20395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BC675F505
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 13:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B303E1C20B4F
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A5A5697;
	Mon, 24 Jul 2023 11:30:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1146ABA
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 11:30:12 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25A3E7D;
	Mon, 24 Jul 2023 04:30:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3sehT9LhTO+v5AEYCG1tId9vS7X3g+qhNPZDlNlTs1U9BR7veGsCI4ef9ZbpR6NxU+1NBDVpHI+pZ0lE8wlDv4CRtBCm7eJYH1FDves6ftLxGWhdNIHpbHujaki0gHvy+pEHSsE3nqRqN9HSW6Wtlm64F4PVwQwZTIDAZ7UhPVEhH66eX4s2Wwhovz3OueZJ8UkzlxirDFNbej9G9+Jrc72s+PktUU3qPZaIomIrlo9zF9pMjkM4JgDN/enNB1zc8hi8+DMsFWqoF2er9x95BFGArFNIbkv2ZKZHfLYPxqCFbwCoqkrhcnGxS4Z3Ig2C0hpMdbczrGJUwa0aew1+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KY4E+TgABKEna02Q9ai7LFqrXvlDSBO4xcsPrOUmJTA=;
 b=C1ogp/9JFiOusaP/3i0dD6gaCdqVyOtWRx8zWPzIzPSgmoY4nZM5FJWsaqVSUTLj74GM0NZSWw+P6ZPZMxzaYOnpcoQ7K9d/hRNmZoFiyTFP2Duz6AdZcD/edzpMX/5mCzsqc5d0roUQVDz9x+fCaxyED//P8HKZmA+WiwQu2C/IHekNq6jZT5szJ0TNFfPJ8dTfkz7VnRjYjr8hQ/hlPC2/eJdUC2Zyd8dmYfGi+ykiV4tlKtJKNKAGxlUZPsorUbpu+4MJjdtx2pkJCZof6WV0hh4Tec9R0M384qI6ZwwFjg8xTDsJSf+a9192Z603tLhtp8pFDqx1IeiviUN7Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KY4E+TgABKEna02Q9ai7LFqrXvlDSBO4xcsPrOUmJTA=;
 b=MulrrslbQOUc4uN7Itbhpq1wo0HvKuZ88pmDvEZ1C3C/pQ5D/hiG2fefhIDsrNWFRPRW0BOqihoAlJtlVAEkWKtmOxwS2nuxMDeZlO5HF9bHcZUZIwtSRnTChdwVFj89padS5aPiLn2KiaBgiyQTr+XXUowv71ThxYv5OJLleUObPcPPbrDz1pJbfGrT8LqKEtXn4CmpKUlSkwp5sxBXvw87Veti+WtPMPPJfrcHgJCp2lE9IaNtgkZdtTafr9FgBQqvWASzA8i0OOHvc5KMqFt+Mn9oToBriMuQzbripjlht0uRKaZa/v0vczzdvh3juxJNFsVZlAPQyiUaWtLMsw==
Received: from BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22)
 by DM4PR12MB7528.namprd12.prod.outlook.com (2603:10b6:8:110::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 11:30:09 +0000
Received: from BL3PR12MB6450.namprd12.prod.outlook.com
 ([fe80::8dd4:fb0b:cea7:fce0]) by BL3PR12MB6450.namprd12.prod.outlook.com
 ([fe80::8dd4:fb0b:cea7:fce0%4]) with mapi id 15.20.6609.022; Mon, 24 Jul 2023
 11:30:09 +0000
From: Revanth Kumar Uppala <ruppala@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Narayan Reddy
	<narayanr@nvidia.com>
Subject: RE: [PATCH 4/4] net: phy: aqr113c: Enable Wake-on-LAN (WOL)
Thread-Topic: [PATCH 4/4] net: phy: aqr113c: Enable Wake-on-LAN (WOL)
Thread-Index: AQHZqb430S9qped/xEmn85gOamKO/a+gQyOAgCiqcEA=
Date: Mon, 24 Jul 2023 11:30:09 +0000
Message-ID:
 <BL3PR12MB645041618E60758B5DBAD149C302A@BL3PR12MB6450.namprd12.prod.outlook.com>
References: <20230628124326.55732-1-ruppala@nvidia.com>
 <20230628124326.55732-4-ruppala@nvidia.com>
 <c1aedb1e-e750-40ce-a19a-dfb21e2a971f@lunn.ch>
In-Reply-To: <c1aedb1e-e750-40ce-a19a-dfb21e2a971f@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6450:EE_|DM4PR12MB7528:EE_
x-ms-office365-filtering-correlation-id: fa56efcc-8045-4c46-aed5-08db8c395648
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NrhcDZR0gOk8S8bP3sR2n5U7O34DZUMmQQ4m0yLu/JKvujpCNkyA0a9P+347MYikQpXx4tdwoGdiNY7RBmpaKtTklZwU4oZXw+K0yQNrpCtjKEJxNpDpcaBQ9gMIbGrDmdLc/HDhcnkK2SnIYnTyYpz62UrzSqQzEB9wwmMPnlcsZGJVuQl+daaiqTmg52azBnFpxewqdR6gpwy+ChqL86Ra/+w3xMdmtkvWkAUQbHm4GPnDkuGeV7XohFkQ+21w1XQdoXvtI6QFlbZUEzobbmJZ9HgdkTJNLEmUxnNf0ESA6KxKPj4eQja3dbYLTxHO5G5S6nW5fXD7zsr+hSC7zXuzia3vb95fTprCMY59kDjYsS4k9mrprGcZis5H9VhmNFntSqa+3+Mbu+NLAf2C7GWEWGFHbrbbeyeB6wptFrPwDQHsD9F25UKbelHFBTH5tg0pSYREh8qvfA3/W3MvYQQx6w3AmRE2OdzDMKV36l/yYngQKcLb6FIvC41SYGXV2zCqmVUtnQkMXRy2eB2LPqT59TyxpRJayBv/dHLy4K9LCO5xK0A8DQsc/PemueL7L8hYysMny83CKFFGuTwZCI0xptABoF5cTks5v6k8X4n7ChDftn1+vEnFIikTJaon
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6450.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199021)(66556008)(66446008)(66476007)(66946007)(64756008)(8676002)(8936002)(6916009)(316002)(4326008)(86362001)(76116006)(33656002)(38070700005)(66899021)(83380400001)(122000001)(2906002)(41300700001)(52536014)(38100700002)(5660300002)(478600001)(55016003)(54906003)(71200400001)(107886003)(6506007)(7696005)(9686003)(53546011)(186003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/7Qg6KstdEI6MnCzrNpAShDBJihNZBhrkPqYy2ILUWaQwB14EtxUAuBsJQLd?=
 =?us-ascii?Q?psQZffTHOYd4JwMJ7jBEkAAXk8N71XGQF8dll9wnnTSD33U933LqDxdadKpT?=
 =?us-ascii?Q?4PJbPBhtsM3922mPuqUDKFXihTGOty0DAz+MATs82QydhvmHF4zjuFBHr+79?=
 =?us-ascii?Q?jNicgiP0lj6OJQ1nwIT9PYtb46Y1lsWj7mBKOwg6Cq8vBu5wTzsnVg8OgZNK?=
 =?us-ascii?Q?u+qLToYoDYFGK6r90U9VIINN+Yh4+kABxAVxn9koLa9Q8fhF6A6+Dvni5rfA?=
 =?us-ascii?Q?kt0BHtOSyt5b8qzKnf3c8c5STDwvOp60Q0GfNnoGDWaxZVYYHalomh8BhIo9?=
 =?us-ascii?Q?8PYE+q3dCMr+TSHJfTfyVY+M9GGZnwQMTzFht3CKXmbh1iZexiECQGbhaxSz?=
 =?us-ascii?Q?cTIHmTuEg2dVi1gOthn1TQtUyU03erid/RpjWZSt1WV7xRHAH1O2AjBbrtKX?=
 =?us-ascii?Q?9VbKGpapgmXxgzaPAgLmm7uoEoSl1G0tLSIZfd9TcygLo6m2Zwfd8u+swHPT?=
 =?us-ascii?Q?g5NraL8UdHFqcjDYxc21ixVZAzJ0/cWFViUJQnX3GJ+r8OjcyleQmOJ8ck3G?=
 =?us-ascii?Q?EgILsoLgwY/e5Mp1qVEcXddbtz7g6/MiknMTIo7jbI3AJH+bEtSHoFbJhsds?=
 =?us-ascii?Q?xfVA0J1qT7muISCHMBLBt+GV+ZwEXNUh2W4y3B29EfjV4WaFkyf42sa4yO4E?=
 =?us-ascii?Q?hDB21WaHorpkyzfUOEYMGv+7VNSiJVM2aIch3smKvaVs7Str6nKXawT0GRaz?=
 =?us-ascii?Q?Tmy+jf3wCIL5ElMbC29hNqp+HlcQwoSBg+85Uy2+PDlunkxQKZtA38F4i3Wi?=
 =?us-ascii?Q?F6ZoMO0IRBzxtjkoa4WzJKwu36BMlhVmIeM6HcmsbFBBIp+l3mSe1kLXoUjC?=
 =?us-ascii?Q?W/sXHpWvewdzltJsqy7744QvgOFGVgehYV6S5/0jDLi8M2wBYX0UYTnUlbYD?=
 =?us-ascii?Q?H7dCb3gwlIt429BMQmiPLd1LA6vjiWVUW1bzyWONZLY0xwX4NKBRfCCOxrb6?=
 =?us-ascii?Q?FzZH/VGRU/FXwwUQH5Z8AowevIFTEM7DD48qQ650YRqhGmttepftwWYcfQO3?=
 =?us-ascii?Q?6ZpiZbNwadtPgFvqjIu73LNYE2nXLuMuQIOGO9bXsWFsQEV8UvSqKPaSeO3W?=
 =?us-ascii?Q?KRICbKrcMrZtptuBK+qN9InfYeoqrfCVWkzMfKEbSAHjQpdWxYz/54GbK7We?=
 =?us-ascii?Q?s1VD7HbdlD5N2ymJQq2JFz63Pfj3IeEnsCpfKzbIq017PIyR/MLaEfUDZPOc?=
 =?us-ascii?Q?RsqwCdbCV3Gp8hIvBx3VfhCIcbsGqu2tDaf0HNJwO9CmFnrN7MLBrVqJ9dEW?=
 =?us-ascii?Q?zehoYv0g40I3ISchOJb7YjcRc0Pf/fFfaKHunt8S9N/OPvEyYe3FLeh+dPAy?=
 =?us-ascii?Q?SCi1A16MCzGAI7Gs9FJvy/giu7vGJf8uz5GVW9y6QbY4nsUMZOEUc7fvgRSH?=
 =?us-ascii?Q?e93fwobCKDUiJlsx4I3Y/tg1MZyhw9G5ZTKROEGhd1/gWDnCcw+UvtEmJlOr?=
 =?us-ascii?Q?VKzerghLy0sEHCxyeVEW/+9+FM94NeiYzIbekusQf5AoBsro5O+ynJ+8H7CQ?=
 =?us-ascii?Q?W4fqnpzWCXztbhg31VUiA1uv3EmpRb/LW09TS32N?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fa56efcc-8045-4c46-aed5-08db8c395648
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 11:30:09.1180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IYMWLhFEoCtiompi/soB0jDqnBVIBGTqwv2euy0EbaxpwRS2k5y+hwlyAW2IRehZykYxZ+ySWbRTjfTtT1+uHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7528
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Wednesday, June 28, 2023 7:48 PM
> To: Revanth Kumar Uppala <ruppala@nvidia.com>
> Cc: linux@armlinux.org.uk; hkallweit1@gmail.com; netdev@vger.kernel.org;
> linux-tegra@vger.kernel.org; Narayan Reddy <narayanr@nvidia.com>
> Subject: Re: [PATCH 4/4] net: phy: aqr113c: Enable Wake-on-LAN (WOL)
>=20
> External email: Use caution opening links or attachments
>=20
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
>=20
> Please take a look at phylink_speed_down() and phylink_speed_up(). Assumi=
ng
> the PHY is not reporting it can do 10Full and 10Half, it should end up in
> 100BaseFull. Assuming the link partner can do 100BaseFull....
>=20
> Russell points out you are making a lot of assumptions about the system s=
ide
> link. Ideally, you want to leave that to the PHY. Once the auto-neg at th=
e lower
> speed has completed, it might change the system side link, e.g. to SGMII =
and the
> normal machinery should pass that onto the MAC, so it can follow. I would=
 not
> force anything.
As per my reply to Russel's comment, we are following the app note AN-N4209=
 by Marvell semiconductors for enabling and disabling of WOL and above logi=
c is part of the same app note.
>=20
> > @@ -619,6 +784,31 @@ static int aqr107_config_init(struct phy_device
> *phydev)
> >       if (ret < 0)
> >               return ret;
> >
> > +     /* Configure Magic packet frame pattern (MAC address) */
> > +     ret =3D phy_write_mmd(phydev, MDIO_MMD_C22EXT,
> MDIO_C22EXT_MAGIC_PKT_PATTERN_0_2_15,
> > +                         phydev->attached_dev->dev_addr[0] |
> > +                         (phydev->attached_dev->dev_addr[1] << 8));
>=20
> I think most PHY drivers do this as part of enabling WOL. Doing it in
> aqr107_config_init() is early, is the MAC address stable yet? The user co=
uld
> change it. It could still be changed after wol is enabled, but at least t=
he user has
> a clear point in time when WoL configuration happens.
Yes, your assumption is correct.
Will move this logic to aqr113c_wol_enable() function to take care of above=
 scenario.
Thanks,
Revanth Uppala

>=20
> > +static void aqr113c_get_wol(struct phy_device *phydev, struct
> > +ethtool_wolinfo *wol) {
> > +     int val;
> > +
> > +     val =3D phy_read_mmd(phydev, MDIO_MMD_AN,
> MDIO_AN_RSVD_VEND_STATUS3);
> > +     if (val < 0)
> > +             return;
> > +
> > +     wol->supported =3D WAKE_MAGIC;
> > +     if (val & 0x1)
> > +             wol->wolopts =3D WAKE_MAGIC;
>=20
> WoL seems to be tried to interrupts. So maybe you should actually check a=
n
> interrupt is available? This is not going to work if the PHY is being pol=
led. It does
> however get a bit messy, some boards might connect the 'interrupt' pin to=
 PMIC.
> So there is not a true interrupt, but the PMIC can turn the power back on=
.
>=20
>     Andrew

