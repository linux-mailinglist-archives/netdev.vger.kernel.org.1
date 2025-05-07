Return-Path: <netdev+bounces-188772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378B6AAEAA4
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 20:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2B397B970A
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 18:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F15628BAA1;
	Wed,  7 May 2025 18:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=palmerwirelessmedtechcom.onmicrosoft.com header.i=@palmerwirelessmedtechcom.onmicrosoft.com header.b="S53LZ7Ln"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2130.outbound.protection.outlook.com [40.107.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACA11482F5
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 18:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746644267; cv=fail; b=j988Eq8pz51uhLNqUMrQzJTsUvZdBCxQjpxHpzShFuTn94RVh4zC89JrvDW3XWIID1Cwu9Lj5zES17NGF0XUQWAsoKQN/EsxWfBNkB33+QjYMFCpqbp4qEGfbvNqhCPad6sO1c0/BFaZlraXWJoalBxIjPXYgvlG7J/bNUxXFS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746644267; c=relaxed/simple;
	bh=ggwYTm0kbhLrUr14C+CTsTowSFfY5pTfmqInaBcLcF4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XyhALPYPmE6ouMh9kh/4oL1BlSqa0efiYNMovdzY9jhOzs5wUOtnYZWAL4mrrWOscDxrttUloT8y3L/txQoMXJHN/kJA9whFMyUXKo8BQi0eWhIpAfGnU++t9xbLmOVfXTtNqw9qsBCGp///SXcZadTevEkEqnKsiW5OUaXvcd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=palmerwirelessmedtech.com; spf=pass smtp.mailfrom=palmerwirelessmedtech.com; dkim=pass (1024-bit key) header.d=palmerwirelessmedtechcom.onmicrosoft.com header.i=@palmerwirelessmedtechcom.onmicrosoft.com header.b=S53LZ7Ln; arc=fail smtp.client-ip=40.107.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=palmerwirelessmedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=palmerwirelessmedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5N/O+ugrtmf4GBgTm2zcN1Z86Y2i3/2fA/3+Bv+kCkpPuaQO8vVu+XwXTVBrQuSBrCyrKz+yyhZz+cdDVmBwdO+PMZYJ4Z8bQd44BhyeFiw+eY0ekb4HHfUP/MAvrgXZoe53Q3ZrawsQziDTnIPSKAcEZmvrRJMBYv85b+RUBeyyPcRaOZmqkC0PZzpS1vnUvxeK9+GSU8/lGbclh6tH1Ko0hjEv0P9WbBiMn0pcqz45v+ZLjfYgwQ0PpPh1MpRK94QkMbmHSeSI3RSuV4qOvSD8Zwh53BgzG7wRE0dwOLKNaO4HjLAFZF2EJC5fj/CsWua/fFdUR2ZUnwlwbawxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEnVV6/QjLhfsLQdqZIFWHKWdzwEylYvSSqTHn+N0no=;
 b=slRFTwNLus2Mya9U7116Bjkr+IgMwKH1fd22DEjTTmmZq8/9G+w/sgijfSJ2MyF1VYt3CD006J6AwXz3CkMZZzVMXo8BKvf+OB1Z4sOaR0fv6Vycvc4mTh1Md+y8UqNsl+LX5QXKKCAfb+Vb5ZFjam0Bayj8m1trQlEwCGxUjeA4UlVpKN9VqXFKybIGNzILQQfda7lxo3+OSUKK+3FeLZB346FXc/VHNMjwEn7ZTxTTo0/E7Nwua8Ik4valGDtV+kKqqUy4Pz64H79I7lVeXtjTyWfXsmH1sQi+On0hFvEYqgginXYSGqqB7dEXE9D2hetkMTvNfFeveP6aptH0Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=palmerwirelessmedtech.com; dmarc=pass action=none
 header.from=palmerwirelessmedtech.com; dkim=pass
 header.d=palmerwirelessmedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=palmerwirelessmedtechcom.onmicrosoft.com;
 s=selector2-palmerwirelessmedtechcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEnVV6/QjLhfsLQdqZIFWHKWdzwEylYvSSqTHn+N0no=;
 b=S53LZ7Lnk0YeXedLSjLPddGOsJR4OySlnis30vvWgt3PNQZujpbQsriUoyjliWQvYXGz9el3qeYRK/lSdJtn+yxDetvWmfMhx0HWkKSEVJZuAKzuT7sHL/VFgqqJbVF/ZVIEhhrt7OmBPkzS4/yDvTXzvjHTxA1MwrselTWSvkg=
Received: from MN2PR15MB3295.namprd15.prod.outlook.com (2603:10b6:208:3d::18)
 by DS0PR15MB6186.namprd15.prod.outlook.com (2603:10b6:8:115::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 18:57:37 +0000
Received: from MN2PR15MB3295.namprd15.prod.outlook.com
 ([fe80::3489:1b9c:24c6:8c2c]) by MN2PR15MB3295.namprd15.prod.outlook.com
 ([fe80::3489:1b9c:24c6:8c2c%4]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 18:57:37 +0000
From: Edward J Palmer <ed@palmerwirelessmedtech.com>
To: Steve Broshar <steve@palmerwirelessmedtech.com>, Andrew Lunn
	<andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: request for help using mv88e6xxx switch driver
Thread-Topic: request for help using mv88e6xxx switch driver
Thread-Index: AQHbv2Bc+TYavxBZNEG3KPwJ+KHfDbPHRtgAgAAyN4CAAAfKsA==
Date: Wed, 7 May 2025 18:57:37 +0000
Message-ID:
 <MN2PR15MB329506AD2E0EF1530AFE22A0C588A@MN2PR15MB3295.namprd15.prod.outlook.com>
References: <20250507065116.353114-1-quic_wasimn@quicinc.com>
 <d87d203c-cd81-43c6-8731-00ff564bbf2f@lunn.ch>
 <IA1PR15MB6008DCCD2E42E0B17ACBC974B588A@IA1PR15MB6008.namprd15.prod.outlook.com>
 <0629bce6-f5eb-4c07-bff0-76003b383568@lunn.ch>
 <IA1PR15MB60080519243E5CCD694FCBD4B588A@IA1PR15MB6008.namprd15.prod.outlook.com>
In-Reply-To:
 <IA1PR15MB60080519243E5CCD694FCBD4B588A@IA1PR15MB6008.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=palmerwirelessmedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR15MB3295:EE_|DS0PR15MB6186:EE_
x-ms-office365-filtering-correlation-id: bb71c686-ebbc-4b5d-a9d1-08dd8d990919
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?uKFV+FBVOSd0MYfZsKurxkSXCpjuW60f2SVD7yj6BHwQ8oAmZlry5nwtmKwU?=
 =?us-ascii?Q?r89DDTHcTkkLc0ATy/XVPxNll3T0u2n8dlOiUQUqwl6D6VWqAIK9ll9B+Et+?=
 =?us-ascii?Q?4V9emT9+zFpDrTr423aRPX9fQV/bERgmcTQRie6XcapQoUBX1aieK3LwJIXv?=
 =?us-ascii?Q?ymblfNAgGAEgfI4fVclhO7o9EvzQHar0TXMMCEBfy31iEdLPadbWDv4Jo5wW?=
 =?us-ascii?Q?IrqNAoft9IGxc0mfU3QJ2qsFVYaZVd8Kg6vV3aEuQHwLwz9ns9BmZ3di/kpI?=
 =?us-ascii?Q?QzvDnxjIv93T2xzLTZrtlADqIjgFdp01QRf5jEdaeiRoH03Sb0TEcnLdyvg/?=
 =?us-ascii?Q?GQEGbd/cU8euehE6gT5VWkecwrkfWiBSb239uPA8q4M+orsRzaMSDnAJXVUN?=
 =?us-ascii?Q?67WZE26kNANLT9icxnEJHb5H5P4FfrO+FdpeNtiuebUgfbaIoTR38h0ffd2p?=
 =?us-ascii?Q?5iJHVJcsyNSbX0Fa+/YA0Bmh1/pLPCX8+uZac+5ig3ixlVp05WvHaZMln9li?=
 =?us-ascii?Q?rAxXpCeeurv96ix6+QCIZInpP2alGOD140MhZXNG5k8LWWo9J+f7eYtLvKVm?=
 =?us-ascii?Q?ryl2fDdvtmL8Dfwj7181smQjicUfpcF3w9OAoKanMxi9AGAeORUG9PbPAWP9?=
 =?us-ascii?Q?9EyFCmKAZoCfYt0hciAF9Ib7cZnHgf8Z+GVhzHTcuIlL2RbNvgh82ceHaYUX?=
 =?us-ascii?Q?Yhfmu7alc7NByWAaQe2pthMl2NRqAIJaHS1ka9XFSRR7oOt5qx0/S4ofjkC0?=
 =?us-ascii?Q?nqATwEWdjID0ACPaoj99Hjoe4UQWPQm6UouppnIUFkFFHlXuSGmW6odq21/H?=
 =?us-ascii?Q?DSBxMUJHWN7opjsErkeGwxYfhwt4XJylQ0YE4N9fsLxdjbD48xDgTQe2DlEl?=
 =?us-ascii?Q?9ZADeLDpgQW/LfnbJ+GIFmrzi6mzPEVm2XHmiwrPdBfQ6FdVnxGI+GluiW3T?=
 =?us-ascii?Q?2CPFQ49GdV767+7mSy0mw6bZZWlVHnam1FOFdaN8BAQmgZfCHSFl2QBfzF61?=
 =?us-ascii?Q?ZWW/YxL+ndq1p+Y4M80GlwKrFJnPcRbXV7DJQQPfP17LUMK25QAqStwG9XNn?=
 =?us-ascii?Q?HL5OoCM5weiBISsEMYuQnsAqVwI6qT3pJLCbH5BJWmypDhyrKCnHgfDf2im8?=
 =?us-ascii?Q?to3SVFJ2I3dqUirOUJETt3d/KHBPXncNQ2JcFQ2FDAgq09pn3cgbGS2bOai6?=
 =?us-ascii?Q?MPjhQKZic3h8mcrZod1k2Ga1N88gF3eVHNJ9veSWTB8SweopHCKgGA1gHz0U?=
 =?us-ascii?Q?mqAImvPPyuraEv0elIZvLjFiKwVX9loneGHhedie7f3WnK4ljRAjaxpK7EPc?=
 =?us-ascii?Q?f04kGgzdM6dqopBQk95ElybL7AvdxxKbNxo/plUB8sz5k0KgFJ+A3TmZluMb?=
 =?us-ascii?Q?yK7eHkDQJnD2V5JKcZSfYGhMv+GfWe4fFz8QpYyO4CWh+hWaH+ngSy2z81tN?=
 =?us-ascii?Q?HefWiRynOa0XzsZ+aJcsjeBx4ommOhP0ivkB7EiGvskzrCE6meWhjw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB3295.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Er0C7ISqoy3xv/LE5AwEY661ZHq11pMmo+2a8oHicZT/O5RfK43RW5ABW+R5?=
 =?us-ascii?Q?DEKP0d6DDG1YzA3aQKDAkWCEq3R+x6iWRo72y2u8/tueBNNgl9GXJkOSgjbb?=
 =?us-ascii?Q?y2B3P/q5RgxAO+lVkqcy3UD18edw+apeLcWyHg9eWF3YUixrT9JAwh4hdiw1?=
 =?us-ascii?Q?SPR7cLwllK5DRqUBvnf09WGQz1fVkbDgi3imu0RlSX3zq3eEMtJdckDG2KlG?=
 =?us-ascii?Q?G+qf05HubMyZUZDxBGyBv7upmFyKZQYV87Bih5Y6J6aCVpNRtEH7D+F0UBV1?=
 =?us-ascii?Q?nETI49z+8TzKHPB9k5V8Rp2/VQUg7yzNm85CvP7yEMESzSVMfPwp/BELz1dW?=
 =?us-ascii?Q?gDJVZRM50reP9r75fPrCKnMWT2agDLnnuISszwmKQi01fgSE8AWvI3tl3ZCI?=
 =?us-ascii?Q?D+Sh9Vm+432FVjZiDD4qeTGXTACTPmM/jpqaKHjuEbdaXpW6Pb/hNwEju6ZT?=
 =?us-ascii?Q?I9JWGmTSHwhSYYoY6JqcZku7eh8gw4Rr1OlLXWnlMbzS3B3vV0JiX0KqoUxC?=
 =?us-ascii?Q?fwxEkY4x0cQ4qhdNUX5lXaldQjDk1meGYUiZLSviOkl0uh/JUaAtf9NRV3fu?=
 =?us-ascii?Q?1PjPdf0JYat2Tv7HllLlq/Fgoa61/zAXg9X7w/crDyAp7dSuFGHr8oNgsmyV?=
 =?us-ascii?Q?HvlnIT7H7lobSAgkq6DNn8+QoKMkWtQSf7oByP8xrDuCAT1E0m1g0u8wYEPu?=
 =?us-ascii?Q?3xFr+PajC8Wbkh6xC1LC0zuoZnbGQ+qml0Hk6B4fPXmcxuzkrZ8MiA76IEQX?=
 =?us-ascii?Q?Xjs7Z0YOJF0qMQnDplwNB8RL8CnTEfWSDiyyMHGWs6xTJq0uYRGRvOM/GYyn?=
 =?us-ascii?Q?hcoeOJSEPrvUASVWwy5+dN4UkIL+kAHoLZztzr5yY/G12I1CzQ5csV5fxI4Z?=
 =?us-ascii?Q?9+Web+SdtPFqSBPngbquPnPWvbOeb4dDA3x+m8qx+yEUXyn28Ira4K3sS+p9?=
 =?us-ascii?Q?l6acPZp2FqnOeQruFd0CxS9m/McQi5BdeQ9awLiEXi81fVTmGpdJYqMVrOrM?=
 =?us-ascii?Q?cSyB2Kkh2atFqJvuxvjm5mpFtrf+3eVBvZ5uSTY2MDDYLfVRuKr8UCIjevWc?=
 =?us-ascii?Q?yZoKnUqST8NnO29GOgQq46/0V6pMLwne8jBlUSsVec3saDLgBS6eyEXZVKVH?=
 =?us-ascii?Q?SwqfbK90poSdae2pu3A45+B0OWz39QvpieOK8GKQpfKRI3YgtvSnwjueekhq?=
 =?us-ascii?Q?QzzmVMC2xoF41KTjjNLrOZihnPtsn158etAZ0w56ZEwWKbq5Zm0vT46QXNyM?=
 =?us-ascii?Q?jaWS/gC1diT+5YELUNQDxJYGDF+y7VBL9deKRaAUI+6aDqH13buNIsq0Jckb?=
 =?us-ascii?Q?VBSaxvwzqcjthwcKEzyqEUIh4pSxVjFsqcMD9QikfPNJ3gf8CuDHpR1vj0EU?=
 =?us-ascii?Q?1OGMspbbITz2LWV8tKq2VFmrbkOVcPS1HBKCGD+kRaiq7SVVg/dM1Wf8e5wg?=
 =?us-ascii?Q?ZCXrw9aolEiyDC9W2U8yhlRFgj7svSuKpPyMkB7Tog5Tn+NjIG75kDSuNV2x?=
 =?us-ascii?Q?6NNix7De3GlrsS8ERvjACHB+4EPXKrpsgO4Ua6OOuuBoDs5uRjmA0PTOW/HI?=
 =?us-ascii?Q?6+M4q2xlE/7ynBVQgt0U5nfaSJmZUAz1Qk7RVGMPWfns7FTIitCUBNimo8Jb?=
 =?us-ascii?Q?Lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: palmerwirelessmedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3295.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb71c686-ebbc-4b5d-a9d1-08dd8d990919
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 18:57:37.8493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18187d5c-662c-4549-a9f0-3065d494b8dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/SB8Vg8gjWeDAaufnfMu5xdcIF/KgWfXdF+LcnzpeNLiEzTzc7gc9CgvzUlycbqdqxnI0L2qDNTgOvgi1mWrpGJn6CPZ5NWHkrkHe2uBP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6186

Well, what I'll say is that we have the typical RGMII signals between the F=
EC on the iMX8 Nano and port 5 on the Marvell 88E6320 switch (as well as th=
e MDIO bus).  I am not sure if the switch can be called a "MAC" in this set=
up, but it's true that those RGMII signals between the FEC and switch compo=
nents *don't* have the magnetics and connector for an Ethernet RJ45 connect=
ion for a typical PHY.

Ed

-----Original Message-----
From: Steve Broshar <steve@palmerwirelessmedtech.com>=20
Sent: Wednesday, May 7, 2025 1:29 PM
To: Andrew Lunn <andrew@lunn.ch>; Edward J Palmer <ed@palmerwirelessmedtech=
.com>
Cc: netdev@vger.kernel.org
Subject: RE: request for help using mv88e6xxx switch driver

+Ed (hardware expert)

Ed, Do we have a direct MAC to MAC connection between the FEC and the Switc=
h?

Following is the DT configuration which has a fixed-length node in the host=
 port node. TBO some of these settings have been verified, but many are mys=
terious.

&fec1 {
	// [what is this? Does this tell the driver how to use the pins of pinctrl=
_fec1?]
	pinctrl-names =3D "default";

	// ethernet pins
	pinctrl-0 =3D <&pinctrl_fec1>;
=09
	// internal delay (id) required (in switch/phy not SOC MAC) [huh?]
	phy-mode =3D "rgmii-id";
	// tried for for Compton, but didn't help with ethernet setup
	//phy-mode =3D "rgmii";
=09
	// link to "phy" <=3D> cpu attached port of switch [huh?]
	// [is this needed? port 5 is linked to fec1. is this link also needed?]
	phy-handle =3D <&swp5>;

	// try this here; probably not needed as is covered with reset-gpios for s=
witch;
	// Seems like the wrong approach since get this msg at startup:
	// "Remove /soc@0/bus@30800000/ethernet@30be0000:phy-reset-gpios"
	//phy-reset-gpios =3D <&gpio2 10 GPIO_ACTIVE_LOW>;
=09
	// enable Wake-on-LAN (WoL); aka/via magic packets
	fsl,magic-packet;
=09
	// node enable
	status =3D "okay";
=09
	// MDIO (aka SMI) bus
	mdio1: mdio {
		#address-cells =3D <1>;
		#size-cells =3D <0>;

		// Marvell switch -- on Compton's base board
		// node doc: Documentation/devicetree/bindings/net/dsa/marvell.txt
		switch0: switch@0 {
			// used to find ID register, 6320 uses same position as 6085 [huh?]
			compatible =3D "marvell,mv88e6085";

			#address-cells =3D <1>;
			#size-cells =3D <0>;

			// device address (0..31);
			// any value addresses the device on the base board since it's configure=
d for single-chip mode;
			// and that is achieved by not connecting the ADDR[4:0] lines;
			// even though any value should work at the hardware level, the driver s=
eems to want value 0 for single chip mode
			reg =3D <0>;

			// reset line: GPIO2_IO10
			reset-gpios =3D <&gpio2 10 GPIO_ACTIVE_LOW>;

			// don't specify member since no cluster [huh?]
			// from dsa.yaml: "A switch not part of [a] cluster (single device hangi=
ng off a CPU port) must not specify this property"
			// dsa,member =3D <0 0>;

			// note: only list the ports that are physically connected; to be used
			// note: # for "port@#" and "reg=3D<#>" must match the physical port #
			// node doc: Documentation/devicetree/bindings/net/dsa/dsa.yaml
			// node doc: Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
			ports {
				#address-cells =3D <1>;
				#size-cells =3D <0>;

				// primary external port (PHY)
				port@3 {
					reg =3D <3>;
					label =3D "lan3";
				};

				// secondary external port (PHY)
				port@4 {
					reg =3D <4>;
					label =3D "lan4";
				};

				// connection to the SoC
				// note: must be in RGMII mode (which requires pins [what pins?] to be =
high on switch reset)
				swp5: port@5 {
					reg =3D <5>;
				=09
					// driver uses label=3D"cpu" to identify the internal/SoC connection;
					// note: this label isn't visible in userland;
					// note: ifconfig reports a connection "eth0" which is the overall net=
work connection; not this port per se
					label =3D "cpu";
				=09
					// link back to parent ethernet driver [why?]
					ethernet =3D <&fec1>;
				=09
					// media interface mode;
					// internal delay (id) is specified [why?]
					// Note: early driver versions didn't set [support?] id
					phy-mode =3D "rgmii-id";
					// tried for for Compton, but didn't help with ethernet setup
					//phy-mode =3D "rgmii";

					// tried this; no "link is up" msg but otherwise the same result
					// managed =3D "in-band-status";
				=09
					// ensure a fixed link to the switch [huh?]
					fixed-link {
						speed =3D <1000>; // 1Gbps
						full-duplex;
					};
				};
			};
		};
	};
};

-----Original Message-----
From: Andrew Lunn <andrew@lunn.ch>=20
Sent: Wednesday, May 7, 2025 10:15 AM
To: Steve Broshar <steve@palmerwirelessmedtech.com>
Cc: netdev@vger.kernel.org
Subject: Re: request for help using mv88e6xxx switch driver

On Wed, May 07, 2025 at 02:57:32PM +0000, Steve Broshar wrote:
> Hi,
>=20
> We are struggling to get ethernet working on our newly designed, custom d=
evice with a imx8mn processor and a mv88e6230 switch ... using the mv88e6xx=
x driver. We have worked on it for weeks, but networking is not functional.=
 I don't know where to find community support or maybe this is the communit=
y. I'm used to more modern things like websites; not email lists.
>=20
> So that you understand the context at least a little: we have MDIO comms =
working, but the network interface won't come up. I get encouraging message=
s like:
>=20
> 	[    6.794063] mv88e6085 30be0000.ethernet-1:00: Link is Up - 1Gbps/Full=
 - flow control off
> 	[    6.841921] mv88e6085 30be0000.ethernet-1:00 lan3 (uninitialized): PH=
Y [mv88e6xxx-0:03] driver [Generic PHY] (irq=3DPOLL)
>=20
> But near the end of boot I get messages:
>=20
> 	[   11.889607] net eth0: phy NOT found
> 	[   11.889617] fec 30be0000.ethernet eth0: A Unable to connect to phy
> 	[   11.892275] mv88e6085 30be0000.ethernet-1:00 lan4: failed to open mas=
ter eth0

Do you have a direct MAC to MAC connection between the FEC and the Switch? =
If so, you need fixed-link. Look at imx7d-zii-rpu2.dts for an example.

	Andrew

