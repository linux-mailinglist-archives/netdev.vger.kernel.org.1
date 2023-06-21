Return-Path: <netdev+bounces-12858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF787392BD
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 00:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A2DC2816E2
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 22:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6097A1C75F;
	Wed, 21 Jun 2023 22:58:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A9E19E6A
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 22:58:19 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B52419AD
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 15:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687388297; x=1718924297;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U5EYe6uKIxNH/dgUBBaISiRDfysxWGYZV4FsR8ioYZw=;
  b=ul61661jYLGy2vtSoaHvuI5N4fIPEQKyEUIW5LXbnFlYO8oclhMtAUg8
   jpVWvHTF23fAvJn4W3UL171Onz0CCNDSldH9essND6yZqDMqz/qjWPS/8
   VA/OraJc5ntFUy8cj8kYj5ISZzi1ZzhL7I97MhAe3ZUnFvpJROYDu+kU5
   R1CAAL6OIW/sGfZ97UoE70SczYj9LG0HObd300CTwp7yW6mbrn6qmdUxK
   lxeDkHM6NXlxjpZMEUmN9i3yZWK+2xkj5AFNWa8Jb+ZeZ/ayuqFFn6CAz
   dDqVRJU1k6hw03IFUi+Cf5ib+6UcyrHJMY4ITta0MTNpINCYi76eCaaPU
   A==;
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="231473190"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jun 2023 15:58:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 21 Jun 2023 15:58:15 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 21 Jun 2023 15:58:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDV4NRC2SIjAgGNaabDF8QPZFqpKmRluSJntW5H+kNTFOJtNrmlv+1gy8BCJnXgofMInxtANRVVz0cDIiqfrbFeTTnaBrlB9kEw5YeJTCjnv479Ml27erB73UWBZRqntLJn8U2n0418D2DhevkP5Ymij1o8ctWjbZYF0/SKSCxhQ4EqNyeh4aF5QYqG/Rc+XozzZiti27hr/uclPOBFmIKzHSWFK+tAaW2/lrVWDdXW4C6qu3J3z9F78XtMHYL5d7MHthM3Ybnlr3kpUIMWFVN8lN1aG+Oy8GKaQQsstOXT9BMpcAiefiN5ibePKvH9t0rl67Q9WrlNnB5IwvEsHQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7+f+b+CgLtBwmfBS9TxdEsvcN/ECpFiTq8aTnb5mLY=;
 b=Cuqgpq1/KiFu3qzEEZbogqAOKX+GdkcIDJHF+yMUQP/lEYC9UewGJ1foVAx9u5skPj/YHcgS1q05X8N1tLrVk8YYMw/5rTLNnHFbhRI1IvMtHPBw5FvvDqM2RUAb5134qHLae/59Hex7/OfSwF/+bTRpJx6Re+pHCAX6ntmfo8Q5WBu/U/AOHZko0RQJtG+nQKnr2N2U58elQN+kig/MesYHwCTt74fJBT3qlxJoBzmQjgBqgsWu2dVigGXPqHC/PgAqcP/g1uBIXUcM3Me0Zb70rRJ8f03MBQ2R15T9324DyADveiiBDffsj9OV7TwLZ5rMCLjL0DLy03yeIoF3Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7+f+b+CgLtBwmfBS9TxdEsvcN/ECpFiTq8aTnb5mLY=;
 b=O8rBymNuYejgrg64yoar47k2Xkm9urNxfLFWzjaHBu2Tvl+EC/xj/2QSTb/oVP8C3GqcN3rxlSUBp4aHBVPnGaaJP/dJd/3kNnIHPKvSQBKKVP5nTdfTHU+dRcI+5JBz0pEoBfSCPTqeqC61cPWWV4iFydn4mxfTSlNU6RvLaV4=
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by PH0PR11MB4997.namprd11.prod.outlook.com (2603:10b6:510:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 22:58:12 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::9617:4881:ecb2:7ce]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::9617:4881:ecb2:7ce%4]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 22:58:12 +0000
From: <Tristram.Ha@microchip.com>
To: <kuba@kernel.org>
CC: <andrew@lunn.ch>, <f.fainelli@gmail.com>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v2 net-next] net: phy: smsc: add WoL support to
 LAN8740/LAN8742 PHYs
Thread-Topic: [PATCH v2 net-next] net: phy: smsc: add WoL support to
 LAN8740/LAN8742 PHYs
Thread-Index: AQHZnx6Lv6i4wvq/bEuHqT3GEKhSLa+UBjIAgAHiNuA=
Date: Wed, 21 Jun 2023 22:58:12 +0000
Message-ID: <BYAPR11MB355842E84AA9C943EE402BE3EC5DA@BYAPR11MB3558.namprd11.prod.outlook.com>
References: <1686788150-2641-1-git-send-email-Tristram.Ha@microchip.com>
 <20230620110830.7e16eb6f@kernel.org>
In-Reply-To: <20230620110830.7e16eb6f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|PH0PR11MB4997:EE_
x-ms-office365-filtering-correlation-id: 8373921c-fd19-4f80-3a58-08db72aafd6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ja2/AUrH4Vda2D0/gmXGQu6FU8CY0hHBQcpA+906+a9IQL0Nbxn7uqKM2dXrZHufcbL2k1VE+Oqt39ho/Ru5GFdFPGOPux/OuuAdumJtt8t+Vd5wAo8Aev0zgYz8Ub0Ydk5ErLrh6zUIOw5Kw5Bl4KIMUGghugx16xTX/r0LRtOk1WKfNGhZx9+O3Z3b6qW70njUrPIeP8dJ8lZWfjkt8/y/rj/HqO2L9el7pcRRzVXCRvK/wcPnVZeUXolqRamDzYdZmXElElLtdw3+zOs0CEtwREvA9/i5tHZQfeU5xwt1kv27S/vnggk9fTD5xVolN2H6IK1ySFsBsVewmIicjkUAq28i05eVuDqVECufpZRVr35EdhpWHvrPZYY1VfTd+Y98eqsYq5gmLrZYgxfLaVfIs0EABR6B/mtwVA1BhpYEakp2sKy83cXqDRoxTYQTiuLTX8Bp+LXuwk/kXWRc3qSZ+8QpOcxeXIBwLQ8ORwlIyd3Ixuikm+SzJILtZmoulKdYclfWjChxxr5n5hDh2zXSGt7UQnTpziucCECke5i631MKVEKfMgSGGEwo7FFwtdkSEzy7/oCzOJqQJeK3BmieJiGhyZBBoYfa6P633BQgillGPqm5Sv5are+MiMBp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199021)(5660300002)(52536014)(2906002)(55016003)(8936002)(76116006)(83380400001)(38070700005)(33656002)(86362001)(122000001)(38100700002)(66476007)(66556008)(64756008)(6916009)(66946007)(66446008)(4326008)(478600001)(8676002)(71200400001)(7696005)(54906003)(26005)(186003)(41300700001)(9686003)(316002)(107886003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2qyiPOc4zsqDAY8mXzuHYHfyZft5N6JADZeOHPBLPh4Fk3RU+9Va9vnW+Kl5?=
 =?us-ascii?Q?h7jFXsOTNWIBGs6KC883HjdVwpvSrwpBfRAu1iHIm6/Z5yuc43rgjtBloyzB?=
 =?us-ascii?Q?m0ljm55WJkldhqwRoKJl9jKc50190mk2kBzeuFEpO1TnETi+HENZ157oVpzF?=
 =?us-ascii?Q?dTH3kBJyBONsmj8sdsVPYrRJq9IwrkTmp4IUc62gBSsynt3aSfQBjV1v2pyy?=
 =?us-ascii?Q?+0fqunFKYQ14LkAF5HNo6CZCOTdB/IcRq/EJ963xH1WJUJ09ODgkFm2o5wOc?=
 =?us-ascii?Q?D78HZCWgPiBnpBN36SVPKs9/Wdeg3GSecr0HInUBFYf6ezuLdB/2qn2dxTJq?=
 =?us-ascii?Q?I9GSfTWscLZx0QKGjS5Xum8GPxIZJhUyKYSfOQq/vTy4ci9kFqM0V4loCOM3?=
 =?us-ascii?Q?sXAEn6XGym1pL2nY/0xL1l+8yL0UjIhSqVuHCCtjof/q4OSrY5xBdC/VDUJq?=
 =?us-ascii?Q?Yjk/djeoys7kQteu3l5c6IGVAFilnE/qP+AYtfRuYXZSAf/CUzUQf6dKhxHe?=
 =?us-ascii?Q?5yk97IGcU5gCdmJjDtaQ0LxmLyTgoipcOgEoQYaJC+Tzk2XaaIzQqKWMsMuC?=
 =?us-ascii?Q?vHpi/YtQGL+aPk5eC9yXooQY92n3IkecnNKOywGSeCYH8BLOnYzZaCWQUr33?=
 =?us-ascii?Q?u4yI+iLjcSvU0Smtn98svH7lqQgRXQHFJjmR9dTlR3t7CkDUX+p/A44WDSqP?=
 =?us-ascii?Q?TvjqV+vzagluRDHwCKOADaX9j+cN1fCKGpFiR+bh+vlQ+xWidiwmDOpV9Cs5?=
 =?us-ascii?Q?Gic4IYv7RbjazBeijda59QWS49+baBRoLuLI+9j6kHrlImDIupaSEBDoZB/J?=
 =?us-ascii?Q?5e3lB9nciKIQJyPs5ARzgzO8IhzVMQAHd7sGukinXKYf+YZU7p1rV5kEr4Y5?=
 =?us-ascii?Q?0+afGN7Q78R8c70wf+PFeAbBbDTZV2QK38jpxer7s0hW9/H4Q1c05t/EdgDP?=
 =?us-ascii?Q?Xy9/ywZuuo7if9GpBFFbiPbC5yJYZOJrkePvdK07wL6NffkZ6OrHOFYrEtEf?=
 =?us-ascii?Q?8lKTzMZC5iiNCD6B357tKFVjbrtATnXvYvOICfqjfGizPQslxGr218yln0PI?=
 =?us-ascii?Q?MmyUlIXAy56ZS37Ma3FBi8pGOiFm8Ajpsrmshn7/CJmjEsGbDIcBBvdajzjV?=
 =?us-ascii?Q?6tOuOfKzPJp5LXli3bD85Oj9Ny01GhPVMTyPylow+OSkxMuQcotZwd8eMrPR?=
 =?us-ascii?Q?6faxbIWg2eBzKf7jHuUbmy97sIl424ALVCbGWqUryfi/cNMUQhhvr5BDv3EO?=
 =?us-ascii?Q?OTiQiSUgtYEZ+ve4C8ZLDCYOxgF+ExrQflb6bBqrcAiUILFRrvfKYbluXp1v?=
 =?us-ascii?Q?NorXuOT5OXL1p/kmvrzNaq7F8/9iYzB2Id9Jr7XY/8qaZIugeARLYcG8bzgU?=
 =?us-ascii?Q?eLRBdZjtqXOdgyriqainGl4DL3QYNoNlYBYEA7HLYM0QhR3iEScNbRLPof8y?=
 =?us-ascii?Q?e8DF04kGYN9a/dg3cRrNhcr1Q/oX2/pa6LwzT6e/0CVKwzbJpIkYXUz9SVF/?=
 =?us-ascii?Q?zKKA7O4TpLnBV3lhlFZr5V6+//2njGdROxD52AUrS5S6sdwmdiQxl4iy+Rly?=
 =?us-ascii?Q?w2jchGmQi4czGllkGRx27yAdzI8svD2y0WCoq57D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3558.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8373921c-fd19-4f80-3a58-08db72aafd6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 22:58:12.4480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZnM3J7rMIC0W1uK901RyDqhkA4okSlEbuVji1kIGy299EkOhEXDdNx6lGnYiyIxTKzbeq7djSnyseCcZf23qIu0RuQUxPoSbvEUqfZnBE5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4997
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> On Wed, 14 Jun 2023 17:15:50 -0700 Tristram.Ha@microchip.com wrote:
> > Microchip LAN8740/LAN8742 PHYs support basic unicast, broadcast, and
> > Magic Packet WoL.  They have one pattern filter matching up to 128 byte=
s
> > of frame data, which can be used to implement ARP or multicast WoL.
> >
> > ARP WoL matches ARP request for IPv4 address of the net device using th=
e
> > PHY.
> >
> > Multicast WoL matches IPv6 Neighbor Solicitation which is sent when
> > somebody wants to talk to the net device using IPv6.  This
> > implementation may not be appropriate and can be changed by users later=
.
>=20
> Quick look at lan743x and natsemi seems to indicate that WAKE_ARP means
> wake on _any_ arp, not arp directed to the local IPv4 addr.
>=20
> Could you separate the changes to support other wake types out and post
> separately? We can merge that without much controversy. The ARP may
> need a discussion. My instinct is that since existing drivers interpret
> ARP as any ARP we should add a new type to the uAPI for local ARP.

It seems getting IP and IPv6 addresses from PHY driver is not well
supported or recommended, so a new patch just supporting generic ARP
and multicast WoL will be submitted.


