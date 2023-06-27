Return-Path: <netdev+bounces-14213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BFB73F8C5
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 11:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204621C20A9D
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 09:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C555168DE;
	Tue, 27 Jun 2023 09:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D87010F9
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 09:30:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE0C1987;
	Tue, 27 Jun 2023 02:30:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVsM4fJy44BgRsul2D2Wbkmf+65lkITZOR3XgamQOLpjp2BvpUFGts2WnzZ6JXNULR1XqCbIEBymLF6rsTYTJVAjDeKrVT0dtEh7wn2cK3INYoprMLK3f56rttKhUveSduqvMuM0m79/DM71x87Bb8XRIUPwB2kxe66uc9yyV+YIXwreSI70xGLEgJL+s+oyXYt4VMxGQOxb4SoYiSExVphd6ojry2JMk0dkRT9ceROLJb9WIk+jE3higJ62UYpPDdeQN9HuQ8RIHQVIrHFzsleyI6fOCV6g+k51Nhot9K28LQiqfWW5yi6mltPRU7hROqPFmzYAHXmISnXjFcQF4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nGiYeyGJ9vzqyj77yI7Yx/kCdt5KQ1KXvg6mYwzmR8=;
 b=dhXFmcBgF0hzx+1pULY3MolIJLdv8BN5QwZKhEqKWQsvQAc1WgmCzgvIzqG5H2k1GnqCd0T9dAy2ffbqvJLHcFFVbnzrMusvYHsadlaORAbpwvr+vbY1Cxx2cGIUL1ui8arBLxLNsTYgYx+Km84k6LJ1fFkspkzC0Exq/DOmEfYFJq4+5NcXYJXWyqIFWJuuqYAIFLnwtYgSHyLSljgLRn6uArZfEvJO+jxtxpNqWbz0J8shttjnXv0puUXcmhyr0VR70A+aQD2qjawvRQPa1eiWcCkWu3tOSnKpFor9DJClq2C5SV/JEu86AOPVhOUfH4SkOVgRi09nDdqFZ6nbCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nGiYeyGJ9vzqyj77yI7Yx/kCdt5KQ1KXvg6mYwzmR8=;
 b=B/7JkWLLNKhqWJkwjU6yTgau63k7XqPzPls9pTuRlLYuPrOotLrThqYef6V0ZwsE3BxhCjfNDHDnb4uRPVvavlfewPbivakIjKoRFR7eVj7EDArpvOGhOZbZrncJpK8kkBh8WCnZ5hUXvKdOe2tnEUXb3hW02C2umOqy+uZfsEhr+cnaOBYa9QBnCZED76wovisatdgs7WprTaqNN0jwDiqtc/WMTvLtqeBhXdfzBjI55LOUTBCD2qMkp9nB3iQe/tn5enj15HQrUaKMWSGkZOG3nyZC/xP+Gr1Duje7EQAo/x9JJ0GvaImnEMp0cWM1TH12C3vqZecMEOGDQ3QJhQ==
Received: from BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22)
 by MN6PR12MB8516.namprd12.prod.outlook.com (2603:10b6:208:46f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 09:30:19 +0000
Received: from BL3PR12MB6450.namprd12.prod.outlook.com
 ([fe80::5af5:2b89:2fd2:1444]) by BL3PR12MB6450.namprd12.prod.outlook.com
 ([fe80::5af5:2b89:2fd2:1444%7]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 09:30:18 +0000
From: Revanth Kumar Uppala <ruppala@nvidia.com>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
	Narayan Reddy <narayanr@nvidia.com>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>
Subject: RE: [PATCH] net: phy: Enhance fixed PHY to support 10G and 5G
Thread-Topic: [PATCH] net: phy: Enhance fixed PHY to support 10G and 5G
Thread-Index: AQHZpGG2v06qXL/IjUKgGgjd0p9AMa+Vg00AgALPNTCAABIggIAAB1KAgAX+lSA=
Date: Tue, 27 Jun 2023 09:30:18 +0000
Message-ID:
 <BL3PR12MB64503DF203DC50B78494F985C327A@BL3PR12MB6450.namprd12.prod.outlook.com>
References: <20230621165853.52273-1-ruppala@nvidia.com>
 <f6e20ec1-37a7-4aae-8c9b-3c82590678f6@lunn.ch>
 <DS0PR12MB6464B3A556B045BB35B293BBC323A@DS0PR12MB6464.namprd12.prod.outlook.com>
 <9cd7f2bd-20e5-4c4e-8901-3913e4ce5e30@lunn.ch>
 <ZJWkTTI5CY8rJmhT@shell.armlinux.org.uk>
In-Reply-To: <ZJWkTTI5CY8rJmhT@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6450:EE_|MN6PR12MB8516:EE_
x-ms-office365-filtering-correlation-id: 614cf48d-60e9-4aac-d61c-08db76f11f5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 gnbVLYuTBboQiCXch6vThDcaI2o6ytY26XsHkk9EWGPRRyyuwl3Jpk2UWPttwdacbhr48zQBf1a6t6b1DCMieugXFrZqdkeuzqtNnQ3/4WLjhhZ7miVr9GM1gwIZlv1TwHpvnIv5CPwmWeHrRAPejtGmgciRKnCI0UAggPuUmAXx3Y7PRWCVQrsOnwBo6tkDY+q3BMOV1fV8b7bhOtBaILtK7uPldqQnu1ooAPLFOOo/WUX7t35Ka3sIkmxI6uD2773CFz/3Vm6ewwVVluP6tcVawELmXMYPee3R0zWYJkvdbpnWv0WqXLHpKsasNrZ8sK6CM6sS1iVQjb4vioRfkaLl7mZ4txK5hWFPN42cYmTKBl0Ult1tQabt2g/FV6mJmqELf10ODf0bMe74sdzSAtoCCfhkd4yOJQwU5+l9724UPF9RpopXOFI2HDGRyscxHx1Zzwh/SHobYvGKXHAlJpGFzefK0ja/czD6Idr/Z8h4T12cWXz/VYEGIiYYQr2hpUw6FYB1DjAi5C9gkEcYeJnsS3+Qg7tLXZUSWX48LjSO1hvgqEb4UNgpyIRDdc6kCx8GSEKw8WApd4DNkTumQacmu1+ap6LMd5sHkYs05lh7rT/mM+JCLHkvaIY0F4qHcvfJASo/3d4A/NbMNmLVLp2MOQOHRKMBC6EXnM3xZ5s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6450.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199021)(83380400001)(7696005)(54906003)(966005)(110136005)(478600001)(26005)(6506007)(53546011)(33656002)(9686003)(71200400001)(2906002)(186003)(66476007)(64756008)(66446008)(66556008)(8936002)(4326008)(66946007)(52536014)(76116006)(5660300002)(6636002)(41300700001)(316002)(8676002)(38100700002)(122000001)(38070700005)(55016003)(86362001)(66899021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EBjQd4PbdX7dHpSolbQtfjjSGyDWxwvQzkZhLBn8n4xo99Ip0fIa2sLBAAsa?=
 =?us-ascii?Q?FHfwEzXKAHEr8Ir0VpAOPQXiXMEMaX19xklX5aWgS3hcTRhJcTBOt26K3ZfH?=
 =?us-ascii?Q?rYUmUQUUpKxv+/+Amrc8s3tEQ8qLFCFVDPb6W7ngYu0krqdhozwf+PupOlX1?=
 =?us-ascii?Q?2tR1/zuVOJ6lkI3jQbgec/i7+40UeiLGMLRnG3u4mfYMcnVdKn+4kupLOBRR?=
 =?us-ascii?Q?fZpB3PPYjpcokZjWCGS+EGrSHeAvu0H2+J38Mz0FtImDt3iAMZzJGx6s8rqO?=
 =?us-ascii?Q?NLI2SAc9cRM3GthQeqVYWYEHBFc6tW5d0l/rhLI4LPuZctBsg00v3VC5dRx3?=
 =?us-ascii?Q?mBTPOxfgkV3QcN/q5A6TXR+CIbu0bkYg7nTBvAi/6+rwajPSNEZh5dRdG1al?=
 =?us-ascii?Q?SH/EKUSDQkiaD/UrJbmZcPfttTAE78FbA0xOOHO2fAaz8/Hq1mtC4v5OQtsc?=
 =?us-ascii?Q?OQhHC9ceKNvKG8n74oSHnklLfCZiCyPHnG5zc59tuFKLo6JgpGW3PX8pB11h?=
 =?us-ascii?Q?TxMHMVgMa1XvpDjuS1yv+igqNbY3yBVDflfYMJm9EwetaeG7hh7r5+BIB2YW?=
 =?us-ascii?Q?xq0YfKnNQx4gj4+1+lHNnek1bR/BV+lXbss885OKVqEpBtIM9yZBZBP3GV8D?=
 =?us-ascii?Q?srP2RcfLDLGTh24VTyDFtsuvL0RIRrmkHcxWuvp43Lvu617qQqypYkLp8mcp?=
 =?us-ascii?Q?g1bj5SWDv+aRCJPAALaM7u9KjGQM8QVtVXA2onOym94NSdh+U5an3Eyl1zJz?=
 =?us-ascii?Q?durq5imZKl8S7G15yQUvognihkIdT709LelvWiMwTs7/4nJME+5smoX+6BYm?=
 =?us-ascii?Q?xs6e3iJwSC5y8cHhz5lq7jRr32qVMFF5U/P9VnzJ5AZiYkujhDB3JGoGEuSY?=
 =?us-ascii?Q?Vwe7Evec0t6/YvygucR/QW6Zm8Ybp3EqrXksiMG8PL2QSsZTOgI1s1gdyLFC?=
 =?us-ascii?Q?pObH1ZaZWTANV12pCTTDoAZCVBdOFhzJ79uAY3zqWOs4Uyc3oWLgNrLHjojc?=
 =?us-ascii?Q?5UTsvhBoYrlOctgNT2YKkrR+k+QlcK0n+mI1wf0mMV4Yb7TX0rP7Oyn1KBQz?=
 =?us-ascii?Q?2TjSrLMBB45w9KYoUCJmASq3cpOeFqYKb2z1HSIX/b4VAgsjROwhfvzVOpyZ?=
 =?us-ascii?Q?UeRUO01XL9l0WiCOEy5nR3y/L1Z1AcHjHrtidm4pleQKFMG1yVJSKHLK5SIK?=
 =?us-ascii?Q?nUz/WI4Ev3m7joVJR1U0nMyV6cE+/ACsokibj/Zd90EOsPn27N6OAjeUHvM4?=
 =?us-ascii?Q?Br9a/oFS1GJEF3wZIy6n6KwUmrFfTHACI2eSaofMywMge4RwgxGu1WrHEMw3?=
 =?us-ascii?Q?h1fDkBPh33+NRyNVdSs/FtaMZ1hoX7Mhu0QpznebeSIzS80YLGOgNNSq5jGG?=
 =?us-ascii?Q?A1u89JMAnuv/e/5DytRTV0ngG05mP5XMNyNri8K26ifQme1NJDSWQoFsR7js?=
 =?us-ascii?Q?SdKtIhp3y7ye3Kzr/4S99/cfo1vbbYHswb0e/pjNL1J1uFn3CqiytCvontCl?=
 =?us-ascii?Q?cdJFrVuHBNyoKw48VZeAxL7SG4LD/z572u4KqbggMEo1gVYFrLxz0vSzO77I?=
 =?us-ascii?Q?N3epNh0+oMqm4d+xtj4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 614cf48d-60e9-4aac-d61c-08db76f11f5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 09:30:18.8188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tukhwc+iG1rdwt4Z4WIinU73HbZlBSCJaToXXgQmkgp0O0TONBs5SW/YWGOkrUtX/PODIs485ha9dQJ7sdmOsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8516
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Russell King <linux@armlinux.org.uk>
> Sent: Friday, June 23, 2023 7:25 PM
> To: Andrew Lunn <andrew@lunn.ch>; Revanth Kumar Uppala
> <ruppala@nvidia.com>; Narayan Reddy <narayanr@nvidia.com>
> Cc: hkallweit1@gmail.com; netdev@vger.kernel.org; linux-
> tegra@vger.kernel.org
> Subject: Re: [PATCH] net: phy: Enhance fixed PHY to support 10G and 5G
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Fri, Jun 23, 2023 at 03:29:13PM +0200, Andrew Lunn wrote:
> > On Fri, Jun 23, 2023 at 12:28:49PM +0000, Revanth Kumar Uppala wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Andrew Lunn <andrew@lunn.ch>
> > > > Sent: Wednesday, June 21, 2023 11:00 PM
> > > > To: Revanth Kumar Uppala <ruppala@nvidia.com>
> > > > Cc: hkallweit1@gmail.com; netdev@vger.kernel.org; linux-
> > > > tegra@vger.kernel.org; Narayan Reddy <narayanr@nvidia.com>
> > > > Subject: Re: [PATCH] net: phy: Enhance fixed PHY to support 10G
> > > > and 5G
> > > >
> > > > External email: Use caution opening links or attachments
> > > >
> > > >
> > > > On Wed, Jun 21, 2023 at 10:28:53PM +0530, Revanth Kumar Uppala wrot=
e:
> > > > > Add 10G and 5G speed entries for fixed PHY framework.These are
> > > > > needed for the platforms which doesn't have a PHY driver.
> > > > >
> > > > > Signed-off-by: Revanth Kumar Uppala <ruppala@nvidia.com>
> > > > > Signed-off-by: Narayan Reddy <narayanr@nvidia.com>
> > > >
> > > > This is the second time you have sent me this patch. You have
> > > > failed to answer the questions i asked you the last time.....
> > > Apologies for sending twice.
> > > C45 registers are not defined in the kernel as of now. But, we need t=
o display
> the speed as 5G/10G when the same is configured as fixed link in DT node.
> > > It will be great if you can share any data for handling this.
> > > As of now, with this change we have taken care of providing proper sp=
eed
> log in kernel when 5G/10G is added as fixed links in DT node.
> >
> > This is architecturally wrong. As i said, swphy emulates a C22 PHY,
> > and a C22 PHY does not support speeds greater than 1G. To make swphy
> > really support 5G and 10G, you would need to add C45 support, and then
> > extend the default genphy driver to look at the C45 registers as well.
> >
> > However, that is all pointless. As i said, phylink fixed-link is not
> > limited to 1G speeds. Given what i see in Cc: i assume this is for a
> > tegre SoC? And that uses a Synopsys MAC? So you probably want to
> > modify the dwc driver to use phylink.
>=20
> Absolutely correct. I seem to recall having had this come up before, and =
I think it
> was explained at the time, but I don't seem to find anything in my "sent"
> mailboxes for the start of 2022 to present.
>=20
> (To nvidia)
>=20
> The classical swphy/fixed-phy offers a software emulated clause 22 PHY so=
 that
> phylib can be re-used to make a fixed link work without needing special c=
ode
> paths in phylib nor in MAC drivers.
>=20
> However, clause 22 PHYs do not support speeds in excess of 1G, so this pl=
aces a
> hard ceiling on the speed that can be supported with this method. PHYLIB'=
s
> clause 45 support is specific to vendor PHYs, and the "generic" implement=
ation
> only supports 10G speed. Emulating a specific vendor PHY to achieve this =
old
> way of supporting fixed links when we have a better way is really a waste=
 of
> effort.
>=20
> The "better way" is phylink, which makes fixed links work without needing=
 to
> resort to PHY emulation, and thus it can support any speed that a MAC hap=
pens
> to support. This is the modern way.
We will look into what you have suggested.
Thanks for the feedback,
Revanth Uppala
>=20
> We (the phylib and phylink maintainers) will not entertain extending the =
old now
> legacy method using swphy/fixed-phy for fixed links to include any faster
> speeds.
>=20
> Thanks.
>=20
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

