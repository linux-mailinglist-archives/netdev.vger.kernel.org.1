Return-Path: <netdev+bounces-20393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C6475F4FF
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 13:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B98281516
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D39D569D;
	Mon, 24 Jul 2023 11:29:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5D563A8
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 11:29:43 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB76910C4;
	Mon, 24 Jul 2023 04:29:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GccbGVhWqqDWlCp130AEm+RegO6Dphho1Nr0Z1Qh0aaGXNugnWNS2zmfsr2oUp0f4Jre/8k3jmQs05IO2LPzVRQyMqUmneCslpdlFldcRA/htOQ86LXhQ6RueB8HFIf595WTvrzV6ZEYUKS+W11i9/Izcl2qg5WHTl4b4iAcCDsuohgx8KWBrZU7AmB/SyxkRZ1AjZbD5r4NmqQLkZ8jTEHqVwy+cdbpmspMaUzxJsPRNE9fDbBDcUsC1+wYVfMm58F68g/FTsGICoSbHGbMb/p/5KucKzkmXvlV8923077cuJROK3YF3V6g/8F+IenMsSgU8gLJOY10EpL4FfMo4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rP2x9NaqfgP7/jCxLHbE5JNbfLjIn3esM2yYxFKzYR8=;
 b=kHcq6ISszHTfZ3QVJY02d+hcUJYKS5JS0FdTSHpTnYka2m6jKptClC4x28D+0cSmZmscnTkZfcrFvAwbnh8RuWIPv5wQjjdG0/GDfhmQTs0L9gr4+AJNYWxbPP3ggBS+510MPrAZ+AALZnfDM9A3VFglA6RpTdCIqR/mip+Axlphp2yHGbmaaVZnSUOAGzgbeQqaBdkh6plWqnrMGBuYHZ16i6KCQs8do+Cf5+FQFw/zDArSy/DOcry5HkVGWaJXr14vsY5NgZuPBbG0FaxjrIH1NmgpnXS2JuP/Nmm/wv50BMfIqE6pCH9q5GYF2C+dKPPKRX2027VZVg1ETcqDmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rP2x9NaqfgP7/jCxLHbE5JNbfLjIn3esM2yYxFKzYR8=;
 b=B4Sfct9p0rOc65uhXP1rm83CfMGv4hrtPEV9SLFyp4wlPHDLFOieyNSp6+b1psN/mtzmg37i0C8LkKJYEy4HYqP5OIzPMCWOIKNrjjhnsgIfKQT7Tl228Vj7VfntbLm2QeCXtgis5cC2tUGrvJtSteS/WYgHAS62ozaXnGrMGJCN/KkIVwHrSeUbmx+Gys7rwLBt18XsT3n47mQPRQUdy3LB1a8i94MbBLrDn4xt7+xCzuowKn0gpf9eQ2g9sxZCDoSurRvpg2oRzJ1JETH/xAwn4IfPBwjSU3YWtrI8LPU4ACuzkk7NWzjK0kd03hH3tpWyzb3EWsWZYsDjnAxSKQ==
Received: from BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22)
 by DM4PR12MB7528.namprd12.prod.outlook.com (2603:10b6:8:110::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 11:29:33 +0000
Received: from BL3PR12MB6450.namprd12.prod.outlook.com
 ([fe80::8dd4:fb0b:cea7:fce0]) by BL3PR12MB6450.namprd12.prod.outlook.com
 ([fe80::8dd4:fb0b:cea7:fce0%4]) with mapi id 15.20.6609.022; Mon, 24 Jul 2023
 11:29:33 +0000
From: Revanth Kumar Uppala <ruppala@nvidia.com>
To: Russell King <linux@armlinux.org.uk>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: RE: [PATCH 3/4] net: phy: aquantia: Poll for TX ready at PHY system
 side
Thread-Topic: [PATCH 3/4] net: phy: aquantia: Poll for TX ready at PHY system
 side
Thread-Index: AQHZqb4402m/dfTXLkur0Ja+NnQHoK+gNtiAgCiwsoA=
Date: Mon, 24 Jul 2023 11:29:33 +0000
Message-ID:
 <BL3PR12MB64504E3A40CD6D8EAB7FF0C8C302A@BL3PR12MB6450.namprd12.prod.outlook.com>
References: <20230628124326.55732-1-ruppala@nvidia.com>
 <20230628124326.55732-3-ruppala@nvidia.com>
 <ZJw2u6BIShe2ZGsw@shell.armlinux.org.uk>
In-Reply-To: <ZJw2u6BIShe2ZGsw@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6450:EE_|DM4PR12MB7528:EE_
x-ms-office365-filtering-correlation-id: 9e5b12a3-32d6-418f-e1b8-08db8c394114
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FCxyiuq+IEfIwcbKin/94ualSbfytcbJX/cuysv8ptvLamTolZ/PbxcM/hOdDgvvBkFOuP7P3IVo4yjoW1YOszCqsxrKs7VN7DHLMy7ygYxd9V4FxX52H16Z6eomH2KvWPQd48gIn/2tKjncnYPKyR7bEabOfuIhnnz9bpLk3bQBMONLPbddtaE3kol3O31/BwRGpBdydeMLcWoChIDWooAlchKqnxonrDP12OYwt6IijZAUilAXTekJ4M42tRB1F0g70pb1UPQD8VcKq4rBT5blrO81LQTushYkQOC3SwvSYIJKY3ww2gtDNZAVQ8GvFPIK+Gc4904rAMHwTxFSodjmUCc8RsBRj3OqDApY59dbgIqhMg6hCNB8NerAmS20Nonypyug7AM7vx33gryr1Cvdwvl+OC9X7ZLwE7cZ/OHCfcbZ3VNADqzIk8jkcsvNCevLhKDEOJ59Vad3tmki2ripeBMjB8lR/R/IeoxR/62SQkOgSR0rmUnC5AnTmV9hDQYJRy97+nb0dFz0oAnxYB7ewX7mAgz83GP3DGdTXc2Xu7Ptddv4u5Ppk3A5OYgBvlFNPjvHgycerkpfN49wISPn8X3rerGkSZ37JixcFeNgk45upceXcjp00yquQJBd5+Q9rRgyO4oPPD1uf65bE5qTndqQGx/Z8sEBxeMUT2k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6450.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199021)(66556008)(66446008)(66476007)(66946007)(64756008)(8676002)(8936002)(6916009)(316002)(4326008)(86362001)(76116006)(33656002)(38070700005)(83380400001)(122000001)(2906002)(41300700001)(52536014)(38100700002)(5660300002)(478600001)(55016003)(54906003)(71200400001)(6506007)(7696005)(9686003)(966005)(53546011)(186003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0ZdtqYqfowk9BjE1+yv2OYefDonFVOxneiSUkJCZfgYf1NyR/7qUOa6vZbez?=
 =?us-ascii?Q?BCIMzdREJcRonvigaJrkTfCdEVxQjd/HbDjyWPOu4L91HiQ65H8ITFkPwfH7?=
 =?us-ascii?Q?Ui3lbVVQzkpB+gSJKD8AGhsHPz9I8eTj8XjcvmiWyZGPefDm/nb5rmC1/PxT?=
 =?us-ascii?Q?EM9pvor7UI7rBijVIOdWjy8RTJ9LaejH0qCuhO3HPUKKWm1CV7aL9AFgUKST?=
 =?us-ascii?Q?+oH7EgGS23MTnySvmh8hNleVaU+ZLioC7KHSQM3Ywn6icSu0ssgzwunuOzG5?=
 =?us-ascii?Q?yxQvF719rC0R6C9/wPrILd5NbVS4Os2wG6UCuu/CDs16gnRRxQgNHLMD+twZ?=
 =?us-ascii?Q?Ocai1h7T3nn2WqZNLuQ+A+IhCu1PjAhTyqkfoq4ryZrf3GSpvCO8sIg50ERL?=
 =?us-ascii?Q?FtzrXlTrnnKGK/FDv2Y75x7ZP/wXA846ZZ72AXvNrmh08qqK5kAfKYu0bzhp?=
 =?us-ascii?Q?W+rwYr/YXtpseILIb3dMrzGInkHpaPFJp4aI4uY4HPjJ36My2NHhLUnZtdJd?=
 =?us-ascii?Q?5rwrL/+UN6+fpFQIk+x+cPZ0LNGsHDQlMQEGCk2pSvNgZYGlHafD7Fe0IO4q?=
 =?us-ascii?Q?Z+XDheE0ItRIvORcxZsMBrh6UcK/CraaIrY7X804WRHQAg+FYAJ2NkpbjPsA?=
 =?us-ascii?Q?v92PWjqxBWlgCcH5dyfMJnwJym6LoLBeWEZoUOqVAd0CWmL8aaJ4K8p/PQNT?=
 =?us-ascii?Q?yYiKkNX6YHiwqtiZBZPysNOd+PtciPmPfnwYRNVCmQ3nBWLJdr9okSOsYfUx?=
 =?us-ascii?Q?R3nHprS3nSJ4CFah3hKT9oT4eZvtAJBM4p5J5/IT+B8sJoiBZsW72khN+36U?=
 =?us-ascii?Q?2zHB5QbNaOYmUQbMErQLV+qq3tlahDsM2EziANxkJ8Qzk/cq+VKJcs9YXWaG?=
 =?us-ascii?Q?eX/MYoBnHPjiruV69+ZsoJBgi7YPeBb/Vlr1sAnIn60YTbw+v7sTdsegvub6?=
 =?us-ascii?Q?3U1IfTvc3DYJsQ0ioVajpbUi9Mnreg2SX1S4Ze9MIbkI43EIf/4meuX4ytSB?=
 =?us-ascii?Q?O6hOJlgJzsk8PkYBW4W76XfkV1zbgC6xeRkb7H5kKSz/t03TgXSTlO5mD1l2?=
 =?us-ascii?Q?ivN90dGssNf3cH7a0ydH3wvSFeGaqop1Qg89KAKWRtkkJxdz1P/yXxaUERiv?=
 =?us-ascii?Q?8nlo7qu5ccSCtyiYSs3HTjxQ3RloYS7+DQfhHhvdILlS5FGcpmAAc0rTQPKt?=
 =?us-ascii?Q?U45Mb0BLLBlXMgC6G/aQxBxnvl6XJHZ2V2bopv2/Rpwip47jDw6EgYUGsuF/?=
 =?us-ascii?Q?zR9CxCh7+Dwamnee/zuHJRPXx4a5XssbnOGakUHtYUXfKlaSUCJgCg74NevL?=
 =?us-ascii?Q?uCTZ/AZippP19/ni11Dg8PExAr6xR04FfEQN4A91qRBEZUZr4yzGhRinFQjb?=
 =?us-ascii?Q?919LVqltbw6+s0FETZFPSoy3lQWPLdVHZmk016MBqKDJobe1qt5fPV1gLN33?=
 =?us-ascii?Q?WgsDiFsknVRlR8yhNsg2sN143u1eb8IEnfadE9xx8o+kGGG4TaTtGJkyQoUt?=
 =?us-ascii?Q?I1fbPgBwUjNLdNMVDTVTCWOA21ynA4b/Nwaw9TgDSANoZoy468wECZu0+Ple?=
 =?us-ascii?Q?uJi/bJhxcCT+W6ehcz4Px0dmgfMDxPK9Qo6V1bDL?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5b12a3-32d6-418f-e1b8-08db8c394114
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 11:29:33.5559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VgpomXUxzy5MJnjyFEt0Ls7h7JNwV4HJHiXnmrVp+xTbkFKFOZ3wztiMNzrve5gH4s76KKgQ5AbV/5kDXABwtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7528
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Russell King <linux@armlinux.org.uk>
> Sent: Wednesday, June 28, 2023 7:04 PM
> To: Revanth Kumar Uppala <ruppala@nvidia.com>
> Cc: andrew@lunn.ch; hkallweit1@gmail.com; netdev@vger.kernel.org; linux-
> tegra@vger.kernel.org
> Subject: Re: [PATCH 3/4] net: phy: aquantia: Poll for TX ready at PHY sys=
tem side
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Wed, Jun 28, 2023 at 06:13:25PM +0530, Revanth Kumar Uppala wrote:
> > +     /* Lane bring-up failures are seen during interface up, as interf=
ace
> > +      * speed settings are configured while the PHY is still initializ=
ing.
> > +      * To resolve this, poll until PHY system side interface gets rea=
dy
> > +      * and the interface speed settings are configured.
> > +      */
> > +     ret =3D phy_read_mmd_poll_timeout(phydev, MDIO_MMD_PHYXS,
> MDIO_PHYXS_VEND_IF_STATUS,
> > +                                     val, (val & MDIO_PHYXS_VEND_IF_ST=
ATUS_TX_READY),
> > +                                     20000, 2000000, false);
>=20
> What does this actually mean when the condition succeeds? Does it mean th=
at
> the system interface is now fully configured (but may or may not have lin=
k)?
Yes, your understanding is correct.
It means that the system interface is now fully configured and has the link=
.
>=20
> If that's correct, then that's fine. If it doesn't succeed because the sy=
stem
> interface doesn't have link, then that would be very bad, because _this_ =
function
> needs to return so the MAC side can then be configured to gain link with =
the PHY
> with the appropriate link parameters.
>=20
> The comment doesn't make it clear which it is.
I will add the comment more clearly in V2 series.
>=20
> Thanks.
>=20
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

