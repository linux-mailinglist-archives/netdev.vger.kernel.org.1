Return-Path: <netdev+bounces-26138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D73776EA2
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 05:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E757281EF8
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 03:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2DEA57;
	Thu, 10 Aug 2023 03:38:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EECA4F
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:38:22 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72772103
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 20:38:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gt1Gv+7sJv2Y17XyRBbSMa9pyQCiYMAvfny/an53OAvImqOIJk+/hguUw4e75F6sZBmh8lwhfccmcoNnjF/TQ9iV38zl9wmTk+MQnj71BtOSIHuKzEWzZqRe9VrpanzvmswlO2RDSxClXVDl4zL4xiTcel45vItsGfeQnyPShwBndlVvLBp30QU/govdfY3gZDutoawUH6wdxUEyzyzuNiJqjuyhjAmIBx35gZLeUYoWcSYLjjLV0r6KxjWsayJqM1wyFdkWRe0SZ6k9h+faQUqfEq0bKPIrI+PioCOKuZQjVqBJu+3j9EwMvdvkBxgtyU+UDB88zD+ZyMe5FjdU1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnLtYcsoEKEYfhC018aIiX189H9G+YraLpCz2PKsw9w=;
 b=NSCY6s4Yh5EKGD4kJNFhkoDx6cCebwtxkPEms5DNKCy9eYq+hfToJ1A05UF/tTqgFEWalzVZacAjxVUzjN+bQyXaGf32+qzPCn3CJAzc4jTXtvvEVl1MwBTSJiTYGOkeOMMkDh92lt1Y4OcTIiOW5kqN2xASLquo76zhUf8fU43B/KRYl2gJEUQURt/ZVDiodjK76Ah8I5M6Wy6heXIK9VU6c25qwtt5QDFTqQJzqkqOn28TZs1GM0c4LW6IDeIuabwyEIAfrDpKvWOAhfNrsLvoij7NARlxU6cAEvHdY6/EosHhS7D8M4Wc72ckrlG8tELsz44j0KTEN9gzNw7d7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnLtYcsoEKEYfhC018aIiX189H9G+YraLpCz2PKsw9w=;
 b=Z/yS+3+/ooH4yVPUqkVb4aLHMrAjWjETrzi+3QEUh4tiYA4UP+6Xuf3+Jf6neh24sccT3dq8m/05+A/9/ZWaa/JTFDilPN4IizfEK/2esBfkdgtpEv0ey63K6IAPfdGX7khGcaRiloRi0LdsmU5PJjDc1PRBDtUdjaYRR362sbs=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by AM9PR04MB8713.eurprd04.prod.outlook.com (2603:10a6:20b:43c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 03:38:17 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6652.028; Thu, 10 Aug 2023
 03:38:16 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Oleksij Rempel <o.rempel@pengutronix.de>, Marek Vasut <marex@denx.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Heiner Kallweit
	<hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Oleksij Rempel
	<linux@rempel-privat.de>, Paolo Abeni <pabeni@redhat.com>, Russell King
	<linux@armlinux.org.uk>, Clark Wang <xiaoning.wang@nxp.com>
Subject: RE: [PATCH] net: phy: at803x: Improve hibernation support on start up
Thread-Topic: [PATCH] net: phy: at803x: Improve hibernation support on start
 up
Thread-Index:
 AQHZxv1ZKz1KraSXKUS2W3fAHhGdoK/gFe9AgACqzgCAAHgJ0IAAL1wAgAAHR2CAAJDRAIAA56yQ
Date: Thu, 10 Aug 2023 03:38:16 +0000
Message-ID:
 <AM5PR04MB313940F68C4817BEEC2377E78813A@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230804175842.209537-1-marex@denx.de>
 <AM5PR04MB3139793206F9101A552FADA0880DA@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <45b1ee70-8330-0b18-2de1-c94ddd35d817@denx.de>
 <AM5PR04MB31392C770BA3101BDFBA80318812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <20230809043626.GG5736@pengutronix.de>
 <AM5PR04MB3139D8C0EBC9D2DFB0C778348812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <d8990f01-f6c8-4fec-b8b8-3d9fe82af51b@lunn.ch>
In-Reply-To: <d8990f01-f6c8-4fec-b8b8-3d9fe82af51b@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|AM9PR04MB8713:EE_
x-ms-office365-filtering-correlation-id: beb5bce7-d50b-4d66-7c38-08db99533be3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 baV4dnFQf8Zwf6pIYhDZ2lbeG4gMUfPlF8CEJT5UQenOQsKhT3P17uUnpRB+KPPa7KfwUEd5reE/O2Sf6bXXUfLEifF1S3FXYRIl240GH0WK/McfqCEXMdRkB0FempKwapov3DRHQrGzeU+OJ7KDeVMI9cjPYvqfhmQZnaW79k/86Sk7DIs/jXfvYh4Gv9VSgCErH+UUw2f7SOMSz2BgZhT0i2piKhvTPHcqJ8TGviwbi9O5haCwvubdC8gYYa4NcpaGJEelhlwQ4kKaGYICtwEYyB8XTdLuQKlXmqd8HQHnouU19Yqc771zuXEHlSLSTyTFHoUMHaHBNQzgS6sLWkHs8P+zXZAmvxBT8wofjOpJPtEdeZdjaiiDIdscpCLWAIQwQsXPUqKuIjqysTUwHVfMskY406Apd05FgCkJ8ggps/T+QWTXfhDQUkhG/Iulr2vXAc9XA6WFaSuSXMy0nsz7xjShgmYhunz+CF+VGp8K1w91uxwjwRz1cmLPRYdW5cDj6mS7UWqd12/7DfSGPV8CSnvDho5ZS4jQ6YdyXCysVjfAYIaeAtdMAbtqPwr1c0uCn2maYMzDV03q+2byKMGSPw48Koa1+hvuYTqsEk4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199021)(1800799006)(186006)(83380400001)(2906002)(38100700002)(54906003)(478600001)(122000001)(86362001)(55016003)(7416002)(44832011)(5660300002)(71200400001)(38070700005)(52536014)(6506007)(26005)(316002)(9686003)(7696005)(8676002)(8936002)(33656002)(41300700001)(76116006)(66556008)(64756008)(66476007)(66446008)(66946007)(4326008)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Z3wsrX8/aCS9BOnkg26u2FzONW4y0P7QVRLFCwW1AUx+Q0hy/7fN0ySOlAiI?=
 =?us-ascii?Q?e9vSr84vl14h2Se2B82Lse6dHflD437YZh4TacmTOZQ+CIdgepRHLt0WkD9H?=
 =?us-ascii?Q?Wo4woYjl3FN/4x/iCp6esmm4ca2JkjUSG2OR5ecIw2ZRUvWcgfLAJmPVOzOC?=
 =?us-ascii?Q?Ygi9xyr+PI9DrMmvyiF8nVVfcz/zRtjqsv91kszc3Ic/UrCxniuCpHe7khNm?=
 =?us-ascii?Q?ukivi7dOGc971EjsXZWFQ7qeegJDxGq2V4yU8lzWaWnRztTHeY0UDhhOOTG9?=
 =?us-ascii?Q?L4RwVAfTEcGY+OM0KiCPYEvb/VjVLT1B8QTvkfG57tm5U1qRMMEsWrupdpL5?=
 =?us-ascii?Q?O+gW/qNGNHPo21REoKhUU0zM4VIDFpaB1f97s21u59WHbqV2u+JRprBxaUN+?=
 =?us-ascii?Q?Bga/Uzvq+o85+biOpzi4+fzxfkx0xiN4hvwK7kK0Jb5QNDD8jt7OBz6HZgCx?=
 =?us-ascii?Q?h03vUt+zATfWuEyT0SK/DMxK61PGVr+QRire9C+WiMntURvxM35jxRwuvTob?=
 =?us-ascii?Q?oO8GWHTeSW/opQDNF3cYskPZW2USEv+QQjEeSz3eYPZUqAjz/0LZzP7Q/Eot?=
 =?us-ascii?Q?OdPz1BjRKWQf1KnMd+OnkZbzTUUpCaA2lPS172d7FpfR8+SeJlgdwm3pNR5K?=
 =?us-ascii?Q?qI3l8vl+/9Tj5FX91xqcb83T7K8FnBnsGEgCgz62JmAE58TGsLRyEucQbYcZ?=
 =?us-ascii?Q?J9jhCa80K9ZgoprG15vTNf02XVgkuBGPyOkrOIIMKRkccahfgBuRV1AijHxQ?=
 =?us-ascii?Q?4ZmM4g73kEwjRe1QWkB7sHrAYa5sHxNd0rxpwNKzDuOfDUcnE90jvGHvhzJe?=
 =?us-ascii?Q?VwHG9XOY3+fjRV27NoYvOruljJbPpzyaKYuVpe7hp2AyKXGw5qRGZB0Rdwh5?=
 =?us-ascii?Q?7h5Ugcm6sU7s0oikbstgVONgN55c644fGfF31Yl7sg2HcEcd2PJi5YPsp6q0?=
 =?us-ascii?Q?czNTQk3SUOYYjrnzUmZ4IITFH14AUV/8k5NTnW1f3KuW2IyuUdXMIZEaQmOA?=
 =?us-ascii?Q?Vwj/7jRCymlp32K7vWGPPwCBpQgD86BXcRkp6hbuFmDg9RcvWbjiGq8Xbs0a?=
 =?us-ascii?Q?xNnClszAxrt6UTx2lFoYSoTL3fRa84eg7cPs2NAac/+DBkfRSJdQkyPSo9X6?=
 =?us-ascii?Q?TFQOvbXJpIjUlF34q/O2HaZcqX62Geg65sAdAX+OMzZc38qx44Z8LupTc0y7?=
 =?us-ascii?Q?GKcEs+XX6p2rtrzOXrJhotlxir19WituIuNnJ6u+J+hoITGK5eTowwXmujOO?=
 =?us-ascii?Q?aKDEtUyKaFdIbrvX5Md8Dtx3hiVvAPlEePLUtR6yBZDwrbA4QsxyQuAkW910?=
 =?us-ascii?Q?4MeiDZhAvqG+CY+yQHC8rayvKNcLBIiT6eeo6Qx/PEvFckvaVYlxMU84uCES?=
 =?us-ascii?Q?O88WwTZFneEvVvibPNQq6BGL2Bh7CaKv0TOnoYAhYxj2GtkkClCI/x8pobtw?=
 =?us-ascii?Q?1u42Y01hMzx0g8ixNu3sTRvd48lfi3t939OyXBPs00CGJU4OFp3T4AvU8H18?=
 =?us-ascii?Q?kgRzPIKM6JE6AG8oF61tIDd8tCymb1rxvdjAp7A+0uUwOpkZRkRNwzT2NDwX?=
 =?us-ascii?Q?rOMC4tkwDWldmXu4FhQ=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb5bce7-d50b-4d66-7c38-08db99533be3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 03:38:16.8976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uR4F9J7c5H7Wzw5o0vovSJeZYN04O7t/i5lZl6N19gGe8dgiEPu8gsiF2lTdFSCS3vR6mf9alwMM40NKmnrPKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8713
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > > Hm.. how about officially defining this PHY as the clock provider
> > > and disable PHY automatic hibernation as long as clock is acquired?
> > >
> > Sorry, I don't know much about the clock provider/consumer, but I
> > think there will be more changes if we use clock provider/consume
> mechanism.
>=20
> Less changes is not always best. What happens when a different PHY is use=
d?
> By having a clock provider in the PHY, you are defining a clear API that =
any
> PHY needs to provide to work with this MAC.
>=20
Yes, as Russell mentioned the issue of suspend/resume, that i.MX platform u=
ses
the RTL8211 PHY. But now I don't have a clear idea to solve this issue on d=
wmac
IP, the design of this IP is so different.

Cc to Clark to aware of this issue on dwmac IP.

> As Russell has point out, this is not the first time we have run into thi=
s
> problem. So far, it seems everybody has tried to solve it for just their =
system.
> So maybe now we should look at the whole picture and put in place a
> generic solution which can be made to work for any PHY.


