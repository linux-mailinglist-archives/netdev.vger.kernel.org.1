Return-Path: <netdev+bounces-13402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FC473B735
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 14:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D01EC281B62
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 12:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8802311E;
	Fri, 23 Jun 2023 12:28:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96C6230F2
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 12:28:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831A610A;
	Fri, 23 Jun 2023 05:28:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8yqhIJV59zP89eWkIfMdZM5m5FS1ExA16Rlt713waA9r8gDUaO9QZ+JeE/uoEJ7CgdtNsHDwUZGC3gIrw0+OpR3WHgwn+G1NheuE/+57fUEDeV1APNjB66i+xb9fPo3ZCQRqEpSvLcKaF36wCKZyZpH79S3F057XfB+7xkQTSUAWP5KwAGD4OeRBq14kpL3TYF/0ehMut1uf7Dex/sZI1rkVEMfGf51SQjuV1Dq9hueiy1Q3vBhiNvyfqOtRXIqjClDok0gjSfAZfNjwaWx1QvdKGUW13xwsHMkLCiQNbGKDCobJztbmREVFogNQFYwfIlbdUi57fOdBfh02G/e9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+rbmbe2ewphiIdMSWk2p55AwHNnicWxmmZSZj5Vq80=;
 b=DJ+dltav/EXZ/F44V29QLCALfIZb6sNmAJCwR1JwRJAIu/BiOuE3ESFCViGIsJaYx5yLjVL0otzXtClYTEF7tHzSwWL0nK1VadEHEWjwYxMfh9Y48Rxpp2vC2CDTfXajWzBAI8ypAUESl+600K1jZHYsfFyopi7jBikMxqewuREsWQznj1TcJ+z6ks4TgqO6k1bYGXiJLwWknh+PRt/moO76mCSR+NlGh/JAXGXSWEwJHe7lCIzNPRp38KgEDPTOc2KDTIKug/1m/DWO1V7+kq9E4b6pEB1O5iDFvaZfAeZuwOMFX1Lwb3LsoZ4X491BQ+eYFsdzQ2Yo7m6raeLJBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+rbmbe2ewphiIdMSWk2p55AwHNnicWxmmZSZj5Vq80=;
 b=Pl6WcMtB+HQOV6d1s1SpX0KHXHvmZbGpa9CUrbg7c4wNq/OMuIroZjh5Jeqdw7rw6C8W1Z67+He+xJM0OClW0m9En/8mFszphyC148vFlsbzjq6gmmlxnJlFQwcjO7+ldACAumFAhxDPtJYGLhJ6QdTZKRavuQfzHw7jGTHlA+fuNOkZWh9oBR7MXwOzxzIq11355Lx6JU8LyR0y00jQX7lIqMm9+g1dx39J8amjUGELOdidXxIrHoV+VTwYBTbw7aOnQ1PjZ8T0DhG9RhVfrVNrAaC/n5F+33Yz/MVXPfrKzmt73aATlBLdyRmTNJTOwDRVF36gPl0Z0bPN8Hvp+g==
Received: from DS0PR12MB6464.namprd12.prod.outlook.com (2603:10b6:8:c4::5) by
 PH8PR12MB7181.namprd12.prod.outlook.com (2603:10b6:510:22a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 12:28:49 +0000
Received: from DS0PR12MB6464.namprd12.prod.outlook.com
 ([fe80::6225:12ad:5c53:2676]) by DS0PR12MB6464.namprd12.prod.outlook.com
 ([fe80::6225:12ad:5c53:2676%6]) with mapi id 15.20.6521.020; Fri, 23 Jun 2023
 12:28:49 +0000
From: Revanth Kumar Uppala <ruppala@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, Narayan Reddy <narayanr@nvidia.com>
Subject: RE: [PATCH] net: phy: Enhance fixed PHY to support 10G and 5G
Thread-Topic: [PATCH] net: phy: Enhance fixed PHY to support 10G and 5G
Thread-Index: AQHZpGG2v06qXL/IjUKgGgjd0p9AMa+Vg00AgALPNTA=
Date: Fri, 23 Jun 2023 12:28:49 +0000
Message-ID:
 <DS0PR12MB6464B3A556B045BB35B293BBC323A@DS0PR12MB6464.namprd12.prod.outlook.com>
References: <20230621165853.52273-1-ruppala@nvidia.com>
 <f6e20ec1-37a7-4aae-8c9b-3c82590678f6@lunn.ch>
In-Reply-To: <f6e20ec1-37a7-4aae-8c9b-3c82590678f6@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6464:EE_|PH8PR12MB7181:EE_
x-ms-office365-filtering-correlation-id: 1516ac6e-f8da-4e89-112e-08db73e565b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fFl1c3ax341qI4uxnuZYxn0sRarmtRD13kS/ghIM+B+AIvlfGGIA30GU5TurNB+H9VWPsVWXsS5QloJWyb9tyqxFk2ApdtJs+9NELO+PceavnZKflQn8VLwumo2GsuOjE28RrVC8U3aDFE9dyzMYgAL0GBQ9k/mTSPKqMlUe4HLRU3dYdyXxKAlYw6oCJzgyfVioAULM/p5v4SPGffxec/g0WKzba+7MgqS17FPJNFjkUiq8AcLILggN3YT0k0c4DxFBSyRSVVpp+57Lp2wvEsSjb5Gift1iebbZiGZGuJb38kp2hn4O4DJwI9LbCGm6xA+C6AtKFiSB/ZJs4UtfBCyTjp1Kb+f306xR2LztJZ3Q+oXKMOvfRrub3T8R/72aELI0NW2F8IlnsZgkjs5k80eqJ0CI0ZPdbRxBg6dp6HeGqxM/eIfDfiHJp3Bp9ijqTeik5BhrftaTF4RdP6pysm3SjqAdJqRWH42TJSxRBHcLcxA2JC7kptSkQ89tp5Vt6nlSAEFHb8hptgsTLqt4bEF1kK4cLaqwzO8euXCbq/a/Z9/e0Hw/Mb5A0Y/o9kMLXP/P6nIA+b48D7MpPJ432kgofCWOsBliGqkNn1/mvWp9smUnyoVTOLU7kjKmPdsd
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6464.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199021)(6506007)(53546011)(9686003)(52536014)(5660300002)(86362001)(33656002)(38070700005)(55016003)(122000001)(316002)(71200400001)(186003)(54906003)(2906002)(26005)(107886003)(76116006)(478600001)(6916009)(7696005)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(8936002)(8676002)(41300700001)(38100700002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Nawe8fZRgE2HS1P1WxblkNq/jVNZPsGM6Mlq6YxGRpSk22irS3tdxQsux4Kk?=
 =?us-ascii?Q?OzmktRghGInfmtsWsMNTKhOzDmPnx1zjrK8WSqBMxucHSzuqIFYxRAMtYggH?=
 =?us-ascii?Q?zk622DwvyzDVEMQIDnIDaX2RJDXjKPrfuaQpvlmJgQnm6thIlNZ+UZM8EF4r?=
 =?us-ascii?Q?+tha2tq6BZ5nojDH/40MZs2BGuTv2tVILu8kOzLjyatNHt1vEPCU3uh168yF?=
 =?us-ascii?Q?6cRRjdIb4Igi9Hvv1RNmzD27cV8aESXYrTUT9W9NPzKEitxQUEQshWpBl9xf?=
 =?us-ascii?Q?c0gNNbizcGS2K2H/mwarqyiLz7UEo+IVOcpHY6bR+g64/MLfQ2t01jcunw1N?=
 =?us-ascii?Q?ICsmpICFEegpVVCJiJJg1rKNgmRYiACDUlwtDCANxrMyAz8SSXNBcGagh3j8?=
 =?us-ascii?Q?caAPsBWs1/z8AFR+jN32tslLuRZUX2TYuUPDBbVjsmyAOOFAiwnf+BULDUUu?=
 =?us-ascii?Q?3hUutdRbtMCQLH4vFGCHlcIAXqW91jIYsMT3Az63/Y6WAACk6fv8U0yqyijV?=
 =?us-ascii?Q?xbc3l6Iso7Q4fDtno7GlQaHSadmpHQNzb/0tBEM7S2TkyEhyFNuiRlO2mlfJ?=
 =?us-ascii?Q?UeBoYiExRNz4yhNqNLsKQ0OIv186SlKahaHksM3H0Nz/y5QVuFIoJSZT2F5d?=
 =?us-ascii?Q?BoAmcRJPefbIYVqIwzxFjjmEliSYCKR92wGXzY7qdbTvqsqPBParsrwwsEVB?=
 =?us-ascii?Q?+k6s9EwyigXggGLffQ7o3OKmtpT2agU4Hb2Jv0A9jesMeyZKX5GCeEI2XUaW?=
 =?us-ascii?Q?5XuQcd2qq6fleGGOwNLvjszO5cBVgrcnqLnXVWNfXcsaDBdozamAdWsGl05H?=
 =?us-ascii?Q?xeQYww8VrCh9CA5PA/abx4b0NB7TJxoP6vzIaZYZjxpU7uYmBQWTBwx67MEx?=
 =?us-ascii?Q?ks8nL0f5WBWj//NrMlrNyt2Voh12ACti9XE/6pnMqSWj25n3Jyrtk4eYhh2h?=
 =?us-ascii?Q?4uLOI8E2epUE7wIttrnEsvr/CFzxIhi7w4P7Dq8NcJ+M7xGo9NV8a3i8TBLe?=
 =?us-ascii?Q?KSJLaAydfc4scWl0/L/V170oyRb0e5KQ+MmA9zvTbJFawG/OZJLwnxh0r77q?=
 =?us-ascii?Q?tqjTvNpcY5LYYLbEkWpPpoZEqhYr1vxu3uZF/3GC9u+QrrisZI771LIYoJJx?=
 =?us-ascii?Q?sfYg4RMNffQtUT6Wn7tW5WksMiZApvkR3shhoO+qAAD195S258MG+wzCyZHb?=
 =?us-ascii?Q?GbCwcfUcJOVy98yaU3mWvKi5LC0O+eSxT9BAtdieWG074tJe9eiAgRZmnTjD?=
 =?us-ascii?Q?E62h0dhO9qjVdKvZLgKHnXqB7pkT6tQG1wKM2Fr438pfA/iFc7n89CUKGiPV?=
 =?us-ascii?Q?9jdjHq4YH1xhA4tKNfgsPqebMBAQgcdki3H6Ky502PIKR74QFkyFOA5ycTb1?=
 =?us-ascii?Q?3FDC8G3HwuWhdB9hjPd81fXoY2fTZ9odaKFqCHjg6EfIfo+gYpP+JSQj/0/7?=
 =?us-ascii?Q?qHGOP01f35I7Z+NjPPXnNMkQgbCs1BsmawjGUgt50kL0uknru6pJDyPLkzZ4?=
 =?us-ascii?Q?+hx0s474J0Tn+mGG4JQ9K5NUdhDTKxvbnwbe5/bgySLvGf13Pmfn0aKg07+R?=
 =?us-ascii?Q?OgqOqxVN86WT2hvWTu4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6464.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1516ac6e-f8da-4e89-112e-08db73e565b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 12:28:49.3963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2VbKjukAyHpnua0sMeqRws8z8TC1gGpV09ZsSWREGxPjoHVtYTwrX3kvP0mVxB0uIcjo+6rUbDPc/4fzZfRjLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7181
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Wednesday, June 21, 2023 11:00 PM
> To: Revanth Kumar Uppala <ruppala@nvidia.com>
> Cc: hkallweit1@gmail.com; netdev@vger.kernel.org; linux-
> tegra@vger.kernel.org; Narayan Reddy <narayanr@nvidia.com>
> Subject: Re: [PATCH] net: phy: Enhance fixed PHY to support 10G and 5G
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Wed, Jun 21, 2023 at 10:28:53PM +0530, Revanth Kumar Uppala wrote:
> > Add 10G and 5G speed entries for fixed PHY framework.These are needed
> > for the platforms which doesn't have a PHY driver.
> >
> > Signed-off-by: Revanth Kumar Uppala <ruppala@nvidia.com>
> > Signed-off-by: Narayan Reddy <narayanr@nvidia.com>
>=20
> This is the second time you have sent me this patch. You have failed to a=
nswer
> the questions i asked you the last time.....
Apologies for sending twice.
C45 registers are not defined in the kernel as of now. But, we need to disp=
lay the speed as 5G/10G when the same is configured as fixed link in DT nod=
e.
It will be great if you can share any data for handling this.
As of now, with this change we have taken care of providing proper speed lo=
g in kernel when 5G/10G is added as fixed links in DT node.
Thanks,
Revanth Uppala
>=20
>     Andrew
>=20
> ---
> pw-bot: cr

