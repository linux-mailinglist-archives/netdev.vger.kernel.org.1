Return-Path: <netdev+bounces-20390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BA975F4E7
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 13:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A6072813EB
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC375690;
	Mon, 24 Jul 2023 11:29:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184BD23A3
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 11:29:22 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D09FE54;
	Mon, 24 Jul 2023 04:29:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GskoFfXZ+mIRJWqiapEoRX7Qgh5FWAy+d6vgqiVz94GL09+wkk8CtB3gsvWqPqihG9Hh6nqozX/teyCLwuxAcWX6U+ITpRlOf2gm+0IjU0nIHon6NZCFKlFmr5lC/7Kma+onNln1MM3VIeChGjDAM4X/QJ1hczj3KJHBa0VQ6txQXCrajnVZYcIK9sGsph4DLN69JhZ+SjhHi/V6Ug7Pl96yJ6y7iLbOSECIuruKbmQAoXlD/XUT1AzmipWGi3zrRfEv2lHSlJXQVP6hLVFEg+0mpfxY6oWR7pe3qhE1RVt0t7/4mKzV8/DHaNYwEqz2DSGu5YGdjnoRN3Htv5rf2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/HEcDwGW1j2TTnHqB4zMwbSsdre41jJvauX8pVaVvE=;
 b=n8kB5JBZSdL93Sfp9KoMTqLHZvBnZdDXUfiL6GDV8zB8QKzWDduhd1no6mu4ewvfxev78qGI5V8YjghtQbrxd/f2HkSK13R8tvvrjUOiM0kX6cIqV0ZWTpZ2cKVwm6WHSxLv/ZjYK6yZnG6yEIQP/2Sen4Bi5pGrZt5fgtv9rZ5pVE2gWe5OuI9UKvl2wOYStm6Ccjb7GDv0B2yYqSySlWkydeiS5Q4djzxSz0eDCT/DZyRTUPs7d2buCH2d94I5+WhMfO+FrkvnSJ70iFvYnDsU9B8MI0wGGzDmVNh0FlEu3gZZjTWniGCqO8oL1eCi5Zwcwjd9JNofasdYW4TJWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/HEcDwGW1j2TTnHqB4zMwbSsdre41jJvauX8pVaVvE=;
 b=liA4vAhwq769uuq/kFxEXV8dUd+0+ZtmmC7UiMxoDglj0vaMGVTRU6ocwlI8XAhLKXhWJURoxG0wLBpGNk7GLPh/y7ST2BkQhDMs5ZkOeGErXYMhPbeQ7R9wFj7shr1bRhV4UFCj7FWcBhEn6+1SW7PUoQCKcqlgIVavPXbJQ9A4P9zmvjJYpko6JQliXG2lM3S033RilZs7Ln0YPlgHeTtyUuEcr7tFsil8mbhIBR+adnJjsDC9d5h3kUx7LFuFCGRD8Xs9/SbhydLGvkeG5fpRYqTR55Z1B6ElT6js6hqoe5aiWEkC3MyCNPj3dt6/Xlb/jeKoBMEKAY2IfzIvfA==
Received: from BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22)
 by DM4PR12MB7528.namprd12.prod.outlook.com (2603:10b6:8:110::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 11:29:19 +0000
Received: from BL3PR12MB6450.namprd12.prod.outlook.com
 ([fe80::8dd4:fb0b:cea7:fce0]) by BL3PR12MB6450.namprd12.prod.outlook.com
 ([fe80::8dd4:fb0b:cea7:fce0%4]) with mapi id 15.20.6609.022; Mon, 24 Jul 2023
 11:29:18 +0000
From: Revanth Kumar Uppala <ruppala@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>, "Russell King (Oracle)"
	<linux@armlinux.org.uk>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, Narayan Reddy <narayanr@nvidia.com>
Subject: RE: [PATCH 1/4] net: phy: aquantia: Enable Tx/Rx pause frame support
 in aquantia PHY
Thread-Topic: [PATCH 1/4] net: phy: aquantia: Enable Tx/Rx pause frame support
 in aquantia PHY
Thread-Index: AQHZqb4y/UnCFG0OJkmo9e/Tj/o/pq+gNgMAgAAEfoCAKKujIA==
Date: Mon, 24 Jul 2023 11:29:18 +0000
Message-ID:
 <BL3PR12MB6450050A7423D4ADF4E4CFE9C302A@BL3PR12MB6450.namprd12.prod.outlook.com>
References: <20230628124326.55732-1-ruppala@nvidia.com>
 <ZJw2CKtgqbRU/3Z6@shell.armlinux.org.uk>
 <ce4c10b5-c2cf-489d-b096-19b5bcd8c49e@lunn.ch>
In-Reply-To: <ce4c10b5-c2cf-489d-b096-19b5bcd8c49e@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6450:EE_|DM4PR12MB7528:EE_
x-ms-office365-filtering-correlation-id: d0818721-dcd1-45ef-c887-08db8c393832
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LfR2lQKjOWRGbTkaK9IQfg5S615MyGqRjpufIYxE+P/hGFoU+/nydtJQeiAspP0d0jNBKJ+n3ArIuw5G+GQasAi96YUSGZiEkn9Uw8ur9d8krzo0L0tAR9fzQk3aTpeOap+LTImQcMn/I+UrNDy38xtBR9PP5n8Ebj0ndjP9caYw8awrUBezFHgvLCIVj+/VT4Y5UpmeEzQsjLbJ8Rxk+EkYEsiU7VkkPdENPeLpZOArCdcjP21OkxjOqNvPNb8UN01zVo+9U3lq4pVABN71dwXp2ywaHzJqXIOLCkzsrXXBcdPB9W8n7xcmZBJM/qcf2aR6d6tJcfqCZMAZnVILx3u2ep/l7U5gZaT6heMYavVYBGJFwIf02XDhHjyMs5EhMteXCENg+iAmyZIM3hOeWnAbX5xgmzjdtFpZ7OIH777CWhYFt9HWKfOBHNUqYdMchyTZFqDQZ58L7XmUDp+n93ScVKIARAbOP3ARgmtoINT6Nmr0b+xWt7YCTICKAmzukP18F91R7Df5VyAVN5nImNpOKimIxv+V2TiYQ7QW2EpX82o2Zn/QHnE2AHn7InEWS0G53DLgf0+Oy5P/nPZ7ZDoadSyoR9XDiigJLjrj04nuMgDe6iG4CQ1x3rQ6m4/E
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6450.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199021)(66556008)(66446008)(66476007)(66946007)(64756008)(8676002)(8936002)(316002)(4326008)(86362001)(76116006)(33656002)(38070700005)(83380400001)(122000001)(2906002)(41300700001)(52536014)(38100700002)(5660300002)(478600001)(110136005)(55016003)(54906003)(71200400001)(107886003)(6506007)(7696005)(9686003)(53546011)(186003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0JHQ4T8bzdrGbPjBOQpKx6wuTBli97iO3vGG6zzPd27FymBjSE5kOQlmIQZ6?=
 =?us-ascii?Q?4B/oAuk7OtrG5d7kXOGJhdWLIRTRpURpKAisaFME+LpxYuzww/6PJq0rHp9V?=
 =?us-ascii?Q?85Ssz1N9WNFjxdbOAVnvigYzhc3kdPb+HLDrufJdLy8vJFULP3T3DYajZytm?=
 =?us-ascii?Q?GIr0jkfiUoiejXrgwmF4j5kM07LAvlgNpAYM2AaReWuuAltSjKUTZObUhJpX?=
 =?us-ascii?Q?MbrDZV/ULl4L/tanM90VzyoTTBbVU0/lpo8pjHuBIL0b+FZqF1WUVKjQQ5gU?=
 =?us-ascii?Q?xD8UrzmSXeQg6tboctfOGUppB31Pr4TmVS0uaXNZX4TP4VyVFhsQdMXjTxYG?=
 =?us-ascii?Q?nRQt+iXKPukHTPoRRf7g6rPbNbOrSX+7i/rekV6/YqlEtPjHni4PAh6kgn35?=
 =?us-ascii?Q?gH+1EroXbHusHASBZLjqS9b5gyElsaPxFmWUapQPTEb5w1XmOVO1t4oGG23b?=
 =?us-ascii?Q?eZ7rfvuQIuUhNX/MScwO2ciwQaE31iwVDhlqKDa96Y4RFoSK5Hx6b2rRDFI6?=
 =?us-ascii?Q?+dwyyHumE+xrnp6rmsMl15JrJqv8fvH9YcybbqgrejcjxZMUi0cZLDQa03yC?=
 =?us-ascii?Q?znMZRWZtaSxtGyuHs155QFRdUvHtUVxJh7GbCqT4uJTJMeKYcK2qFicgSg0z?=
 =?us-ascii?Q?ax5aEbyoM0gGXXMqPTV1m/501210aDIXKBeECDieUz6sBH8T2OgTxAx+tljj?=
 =?us-ascii?Q?A3LkoHMaVmKiWSkguKKcbP64H9q+oRjEqsJVckMXmZ0LJGC1egpffkuKDWb5?=
 =?us-ascii?Q?rG7g5F6Ki1ofocSebgzUQn45qaP8Jfi1GGVh1OHu6fYOkOW0R+9bxpBqVgmE?=
 =?us-ascii?Q?sd5iJtrh4P5+cksIbNMNupgkZqIO+u6X7jXlO69R+yVuoEPnquWVKLW9/OZu?=
 =?us-ascii?Q?3U7t/d0Af+o44vsfdv92cLPQzyQI1B8wMA/LHRC4Ze9dfsxDljvAQAqCzvwI?=
 =?us-ascii?Q?DwOHnSiMO0jbjkQrqhkO0nt/EupJNKa41CuTfrpTNMpY1zrapLWgVqBTBJ4t?=
 =?us-ascii?Q?ZEXw6O1n4fu/QbB6Qg55/ALmYX20Cr6IZB83kGohuoQ5Jn2o9wyMc7+y507t?=
 =?us-ascii?Q?7nL7r7mz06nXGIhSUhGD+YgqcNQRT4MyuGTgrwTM3i+1SoZYLvvu0n5VLKks?=
 =?us-ascii?Q?MAVI7TgfxjY4AC+I8QuWYTt9PvyVnNcAdzjxmkZX6Kzuq3Pvs3EZl7B71Z/U?=
 =?us-ascii?Q?3+T3+LNqDX9X/Y+9XVlggneio7OJeVA0ls1BjtQQgm7PVVwFm/6ZvY1q1b2I?=
 =?us-ascii?Q?7ogHBatAgOa+oWE+JSjhLMAaRTg5SvzmnLaeqFhMqDkMy8n+al7FeUEeGLhL?=
 =?us-ascii?Q?8ox92t4cEG9EWFMorEiQheNU3ifhWNZPndLs1jtA6YzQeMba84sfp59aWNSt?=
 =?us-ascii?Q?P0zd+XW+Lm+GYrEGlMxBxSC56UKmSTORI4p8nDeLFMEFe+78iQ3RAebF2Lta?=
 =?us-ascii?Q?Rv8M6CIuXa+d1ove2Om8KcnR4v9ouOyPo/A0wp6LXwTIR3vkQGbdFDgV5FoK?=
 =?us-ascii?Q?n2TiNLzr/ADC/uVSuHcWlWWfZv50K9vc3SvUAKjcU/GHY5jAVhcLwMFcnvyX?=
 =?us-ascii?Q?r1E27+8A4GOUXOkkFgbJhJ6TQo9imRNvFGa6puoB?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d0818721-dcd1-45ef-c887-08db8c393832
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 11:29:18.6904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x6z5yXl3kx58SJiQaX5+Vr++UHUunkWcXeWO9dRiUCMDVmEfyaDZycTz4BEMINvJyVsFlUMLauqB3957cdkO4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7528
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Wednesday, June 28, 2023 7:17 PM
> To: Russell King (Oracle) <linux@armlinux.org.uk>
> Cc: Revanth Kumar Uppala <ruppala@nvidia.com>; hkallweit1@gmail.com;
> netdev@vger.kernel.org; linux-tegra@vger.kernel.org; Narayan Reddy
> <narayanr@nvidia.com>
> Subject: Re: [PATCH 1/4] net: phy: aquantia: Enable Tx/Rx pause frame sup=
port
> in aquantia PHY
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Wed, Jun 28, 2023 at 02:30:48PM +0100, Russell King (Oracle) wrote:
> > On Wed, Jun 28, 2023 at 06:13:23PM +0530, Revanth Kumar Uppala wrote:
> > > From: Narayan Reddy <narayanr@nvidia.com>
> > >
> > > Enable flow control support using pause frames in aquantia phy driver=
.
> > >
> > > Signed-off-by: Narayan Reddy <narayanr@nvidia.com>
> > > Signed-off-by: Revanth Kumar Uppala <ruppala@nvidia.com>
> >
> > I think this is over-complex.
> >
> > >  #define MDIO_PHYXS_VEND_IF_STATUS          0xe812
> > >  #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_MASK        GENMASK(7, 3)
> > >  #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_KR  0 @@ -583,6 +585,17
> @@
> > > static int aqr107_config_init(struct phy_device *phydev)
> > >     if (!ret)
> > >             aqr107_chip_info(phydev);
> > >
> > > +   /* Advertize flow control */
> > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, phydev-
> >supported);
> > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, phydev-
> >supported);
> > > +   linkmode_copy(phydev->advertising, phydev->supported);
> >
> > This is the wrong place to be doing this, since pause support depends
> > not only on the PHY but also on the MAC. There are phylib interfaces
> > that MACs should call so that phylib knows that the MAC supports pause
> > frames.
> >
> > Secondly, the PHY driver needs to tell phylib that the PHY supports
> > pause frames, and that's done through either setting the .features
> > member in the PHY driver, or by providing a .get_features
> > implementation.
> >
> > Configuration of the pause advertisement should already be happening
> > through the core phylib code.
>=20
> I really should do a LPC netdev talk "Everybody gets pause wrong..."
>=20
> genphy_c45_an_config_aneg() will configure pause advertisement. The PHY
> driver does not need to configure it, if the PHY follows the standard and=
 has the
> configuration in the correct place. As Russell said, please check the PHY=
s ability
> to advertise pause is being reported correctly, by .get_features, of the =
default
> implementation of .get_features if that is being used. And then check you=
r MAC
> driver is also indicating it supports pause.
From .get_features, it is not possible to check PHY's ability to advertise =
pause is being reported as there is no such register present for AQR PHY to=
 check capabilities in its datasheet.
Hence, we are directly configuring the pause frames from  aqr107_config_ini=
t().
Thanks,
Revanth Uppala
>=20
>         Andrew

