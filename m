Return-Path: <netdev+bounces-95945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8718C3E46
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BABF61F21A9D
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 09:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2115F1487F1;
	Mon, 13 May 2024 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="lhgtEP1K"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBCB219E7
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715593352; cv=fail; b=jfaVSiAS78yDh6WaOLdQqH4heYsKwPntLhHuNwRro9Wz1wsSIBgZSdlEiBh1N5O7QDG94CNyj5q4NHZCKTV4lqPRpXuovxXA53FtbOGNqWWTRpZCl/thkSTl/l1GbGd/WzBiYJNjEndQ+LMd/ltAfc/QrAXGXBM+J9LkSCy+ieA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715593352; c=relaxed/simple;
	bh=GBkyVe28pwxJMOeimwbluydaEQAIPCRll6uNcSorTjY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gGYQB1mdhuodMisIh/rOKZcC4rr0bdRZNfLSA6bIBG5U7JCOCdd1wl+eRFG/oUo0B1N7Lq+UUmqVESHo973h/aP0xxcwkByJQb0BwqLFV0V7ldztbWKbI3l8qfSUoBadiHqL/VpKPOh07IcRMLUCGuQ3wrlTrau7cDnGgBkI6EU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=lhgtEP1K; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44D9gBBN015103;
	Mon, 13 May 2024 02:42:11 -0700
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y3gf4g010-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 02:42:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gq9PwRjrhd0n9g6e4X4wCecZ4F1pQggRvlEgdB2r36le20hD3rjcLExBU5lTa32ylvRt2hT9ssPqeSgpV1mi+ge1Ogf7TdKjONjdib3FziZFpEi2xlMDJnGP4+Kswa1qb2J/5IiVHS51t6FVmLOh0ypTXOvSlOVjT1b83kUat8+yv8MEQqm1Og2wnVz2TfkatjTgAaYH1gFzK1G6CnhP9+ZE3PfHgZiLriYmPR9AmT3JEIRmCiZWL2od6HYukENQgGSC7LP1J7d/ODmOQDR4f/CDLEUFi+YBvAVzMhYdXZzsHW6pVx5DbcJ2acSPUUnm/WMz1V0hXG4ROscs9m5jmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VY0fzL1sLiryZkFVAQir2hDHBYS8QpWZ1DUTG+syCvY=;
 b=YWzBq3rv/lWf2kVimdYclWotLhvNnPYPuJhdxxDTtJBYRKBiZOrbya9uA1SoKclVz1t1/iWM2Ln640glDBOVHCnM59DI93sIhCA2GrN9FklreG0NtFqQ+hugCtIRmQmFnrdiCkXY8rozlaLw4yvfYRSvKiNhrztvPfyodkbe2wyI/AvR5SjL9Hp+wrxmLu/5nNSQf+DoaMRjBk73DMZolGjs7hKPEMtRd3XWXco7bghuh2mHV/Nl/+L7wpAz19BNJ3B02eiaRJey8j7HHueSXIRj7X2zE72SWLeAYGbRusRAUJCEadh90wm0b6M3TniAq/1+B4i5Aea9tbPNlOIbyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VY0fzL1sLiryZkFVAQir2hDHBYS8QpWZ1DUTG+syCvY=;
 b=lhgtEP1K3FVBmeZTUSv2CDQwsJ/TH1EyLGRkbB8Ux0BAxk01QTX/B7Kr0tGsA4In5zaXUJYqbCo8teRhTt2b8UBgZX36dzRwuvtyfD3CyX/uhvWEXs9+6dGDG4b97HLdrynCLksJjwh9O77Ydn7aCvvzMeo6RmJjGX1iRpvDwVU=
Received: from SJ2PR18MB5635.namprd18.prod.outlook.com (2603:10b6:a03:55a::21)
 by BL1PR18MB4165.namprd18.prod.outlook.com (2603:10b6:208:310::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 09:40:08 +0000
Received: from SJ2PR18MB5635.namprd18.prod.outlook.com
 ([fe80::efe5:32a7:11a8:840d]) by SJ2PR18MB5635.namprd18.prod.outlook.com
 ([fe80::efe5:32a7:11a8:840d%7]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 09:40:08 +0000
From: Naveen Mamindlapalli <naveenm@marvell.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "horms@kernel.org" <horms@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>,
        "hfdevel@gmx.net" <hfdevel@gmx.net>
Subject: RE: [PATCH net-next v6 5/6] net: tn40xx: add mdio bus support
Thread-Topic: [PATCH net-next v6 5/6] net: tn40xx: add mdio bus support
Thread-Index: AQHapRmKFmA0aYAEwE+snYGCjralgg==
Date: Mon, 13 May 2024 09:40:08 +0000
Message-ID: 
 <SJ2PR18MB5635B758C9807AA7520E01EFA2E22@SJ2PR18MB5635.namprd18.prod.outlook.com>
References: <20240512085611.79747-1-fujita.tomonori@gmail.com>
 <20240512085611.79747-6-fujita.tomonori@gmail.com>
In-Reply-To: <20240512085611.79747-6-fujita.tomonori@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR18MB5635:EE_|BL1PR18MB4165:EE_
x-ms-office365-filtering-correlation-id: b0070faf-c5a4-49df-a080-08dc7330ad73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?L9JA+xxACXlLdWcDsOVxj1MaTCX5bYvdl9dxe79jg4rUJBTH7gF3XwNpi37o?=
 =?us-ascii?Q?fN3uO4Us1qgFflEbeSB3NowEeSw4HZeIttI8K3RoSlvgKs1F7TXpgbGOZUgq?=
 =?us-ascii?Q?1Brg9u0tJ2+h9+pD2liiO5uzl6USixdfLukV4Sf9onYYEqp5NUe2tn8zmHnS?=
 =?us-ascii?Q?k2MUNacB81eWjivp2zBZzhTrnVYx9RoKnCVhyQwYS7OuZYgR7PSOngAYeQSV?=
 =?us-ascii?Q?4M01YFsO5xHOOs24c2OoslEMrdE8laU7KNts/Ib4uqs1myJCE8kEe98Pwsu/?=
 =?us-ascii?Q?+3RTZy5+SuLdQHb2G70re6QsU+cavk0+IPowxCLReDGN06dTgR65g/bzH5mX?=
 =?us-ascii?Q?EXrnnGg3uMiI2hC4hB/lo25bYAgDo0qEgAIgrOfsDV5Er2WwhqEbF3iBBSU4?=
 =?us-ascii?Q?uNgVLOJuw5HrOCUeoY7pdqqVAoRziEJ+FqOoDVHI+Yi1ll9jQBdBNDIcaya3?=
 =?us-ascii?Q?NI2Z68b/AqQUHzSa9/qmuedMm+s8CSHrxWFkntckeknWF7hYBCoTL863mvRb?=
 =?us-ascii?Q?272CNiUCsXq2Sj/CaWPlB3o/6D3YJCWtEyQuhX5CxeiVPLFWQuE3exZsE2oP?=
 =?us-ascii?Q?okLLGbV/MIa2H0ikyGuSQiawhRzLBquKb3VJP+wKVrTp6b5SI7CapsSnUVOB?=
 =?us-ascii?Q?Q2Z31ux+KYntbeSCGc9pf4AzNY74HOIuShj6YAZaoDY3Rai9Tq2Y7Jt0jSa2?=
 =?us-ascii?Q?/6b/eT5la59RhZmmSiMFYmQTETDXKkAyg+wiCQzkaK+5dXZWM6rhDUGU/Jdy?=
 =?us-ascii?Q?J3y+yTG2WGnIps1Q/TKSvAD70Fpe2WDZo7EHqSeihiWZJ2o28MSdwit5UyB+?=
 =?us-ascii?Q?MyeNGHf8BGXhZmAmFMMIaXZhBF/5jeP4MfcGQuv0sPL+bQFQLtxutiKawabY?=
 =?us-ascii?Q?hcudVr40CiooTOwapUZtetknrt63UAvAtmlJfuoZ2toKxKa7T31ZO4sLdDQr?=
 =?us-ascii?Q?KlyieBY5kd5PURrDtOxWUxz83ECyKmyk6l1oFGZ0x8qoxXOzTErGwuzSZXX8?=
 =?us-ascii?Q?gQVoPs+dU0jPb4le6ou638uUXvrl72/Gxudwk601GlMDVT1L4zHcCZfeb1Ak?=
 =?us-ascii?Q?5ME+Y4n6Ro2Ckau1GfjqVre0RDctZzz9SWAkhF0bLN6J1SgZ/CmgZJc4UJ3N?=
 =?us-ascii?Q?lQM5Sqjb5OZGkX8SJ0pDVKLUCLvUwT9DPvygfxAK53Ezm0hcmpa/CDbIxkl0?=
 =?us-ascii?Q?S4mhUs8NZe8/SRtBmcjuiR1Uvfl1NO0886qC99dacYE/HrsQclaDQSMe8mMA?=
 =?us-ascii?Q?SnZ9Wdx/1wpkOzQS+y+eDdo8VbgjTHzX4TXFmFKCknKOLbg8WxoMhd1zWs3W?=
 =?us-ascii?Q?zGhpu4JDDLbNnNd8cDBP5iXxRcVpdHTyfuReZ7PnmJTY5w=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR18MB5635.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Yh5M2F9f7Svs8VEKpjQgLt5GgHfPrjt2P+tVqlmccqZwzq64HZowbht/kacB?=
 =?us-ascii?Q?yRVXFDZyT6o8F8z/++MHATFkG+FMUBvELoaNcR2FyWc92R6F6ueyRg/Xnde5?=
 =?us-ascii?Q?hAgSycY9Z/tss9hC5jf0UYJDAHyj399kfFe6Vk8EnoAHMHKfTExC/0fSCZbj?=
 =?us-ascii?Q?1De9Q4fI7ouoCpRy+UcpVmFZn9/MIN9s3SrnRXPGMfaLCb029v6iwcGWE1Z2?=
 =?us-ascii?Q?kb60NzUwUZml+2dE72JBkfOhjzB7iHqdTCYNqLY0ihkACstaBAIjnV2sPuBM?=
 =?us-ascii?Q?TC6OAyC/7Nn1RwaTj5SEx392oWXqn0JWvR+RO6L8Jw74NSJas7t8qmRwgCsq?=
 =?us-ascii?Q?Xfw28v/VNX+C9A88zs9GUTo6XIBK7eyZ08hIF8t0Bma7Q5efUvcPwldHKKzg?=
 =?us-ascii?Q?NIazcAtplQYxB0iSdJr+MCLG3y8DjbqN+pFlH174LmReKP1n0UUlt7yYJFZO?=
 =?us-ascii?Q?1FaF4kNQCwAkX7NyWg8r51/Zb+KXeZQ5AzsQFIS9KSZ0Q5PI9rnr4kL5S/AD?=
 =?us-ascii?Q?X5aU1RQq8YCzLg4yNumUzofWCszWL/MJSoI+ztNL6HpxCd3dGRepsDa7ClKn?=
 =?us-ascii?Q?zsR2fb/fIfv1ZcEJAxKDrLFDi+YQGhBDkd8MC7cOIyale0fkpAUABJNjuRCY?=
 =?us-ascii?Q?lI/+5LnGUyl1M8ksIYS6Fzmq0QwceAnu0XtNF9Ikg4GvZqdFuiIkvcPEM035?=
 =?us-ascii?Q?r4eyqMRP0THtsQud/L9Z3ulKzYnqMboVDuQjhrx7I+76T/UemqRrp9CQMad7?=
 =?us-ascii?Q?gon1gAaEHwBVWvErxxruhWyIKlHZsudy6unhug5cKIcKJOHnNGlkA4zV1Mx1?=
 =?us-ascii?Q?/+v8OjR2Z2TpgnVdFLuh0i/fucdtjhsyC2h5BvUC8+wdlp+7HtF5LpE/GBZy?=
 =?us-ascii?Q?T1nAi+FE8r/aymdLhocL7zVvXmL0VK8I1BN+rmX/2ZmRkTSpONF5SOmEKCcB?=
 =?us-ascii?Q?JHGrgySmlikZ0T1+gmwP+4cmn+8j+VwdPdcgKwrbuFYMhTM47NN+Qagsg6bj?=
 =?us-ascii?Q?sbOitHODoNOAdYJEsAFze9ZnhOzsLhhD14QrzC1WL75PCxG95XH8JE5M/PID?=
 =?us-ascii?Q?OeXnTDiFNBVgka5E0t2TXFgqWHJtgHj2pRHdY1/OdXci9mJauIzP43GX6Y31?=
 =?us-ascii?Q?QI6oi1A2Cw0tm9lTMwEWz7+/46BOiYDmZ93z0MWwpJIaQfrDjGdbLEh7TOsd?=
 =?us-ascii?Q?SR/e6YFy3G0a4mw9ci24gxU4HhfE67oLc1lS7TY1lfsDnhLBQkRZK3SrABjh?=
 =?us-ascii?Q?KrsR/GuJ+0NLIoFTHeh/7wksUjPuJIxoOBMoiqOlU03AaIOZ87b+cCOZsFJn?=
 =?us-ascii?Q?7s8KBGDtUGvNRZChOpRUbmuC5PgBsmO0bW+YraDwrrsGK5/tzZaTWYU5SwXO?=
 =?us-ascii?Q?eHeXo67Hen2WcTKL+pPHykROhF8TJl2DTF9xAqeMeZ9T0/rwZJQp3V3oWZnV?=
 =?us-ascii?Q?zUQtazUwdqfP/g4E+wx24LjUoDAHBiIZ3xDBiuj+5JMb12Y4Xq6tnV/1aEdC?=
 =?us-ascii?Q?Z20i+iwxdFSX9cQRUQqI4gcZJHyf6y2/NWxYlRoKMfMh0y4jHIkUQ0hN8beM?=
 =?us-ascii?Q?PF2HtmVp5DvS9qgp9vL0bjh1a9VTuKS6b7iNlPVJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR18MB5635.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0070faf-c5a4-49df-a080-08dc7330ad73
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 09:40:08.5222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AI2coz9cnj2vkURowYvGMyfkS09yRcVue8J+PMdn1HXG2Lp+Bjr3Qt9jpuJjHmLqkxcSLAZ/jJ90eKtnDKmZxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4165
X-Proofpoint-ORIG-GUID: fIQ9K84lcRlSgZODyxQAJFDjwY0-iq4B
X-Proofpoint-GUID: fIQ9K84lcRlSgZODyxQAJFDjwY0-iq4B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_06,2024-05-10_02,2023-05-22_02


> -----Original Message-----
> From: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Sent: Sunday, May 12, 2024 2:26 PM
> To: netdev@vger.kernel.org
> Cc: andrew@lunn.ch; horms@kernel.org; kuba@kernel.org; jiri@resnulli.us;
> pabeni@redhat.com; linux@armlinux.org.uk; hfdevel@gmx.net
> Subject: [PATCH net-next v6 5/6] net: tn40xx: add mdio bus support
>=20
> This patch adds supports for mdio bus. A later path adds PHYLIB support o=
n the
> top of this.
>=20
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  drivers/net/ethernet/tehuti/Makefile    |   2 +-
>  drivers/net/ethernet/tehuti/tn40.c      |   6 +
>  drivers/net/ethernet/tehuti/tn40.h      |   3 +
>  drivers/net/ethernet/tehuti/tn40_mdio.c | 140 ++++++++++++++++++++++++
>  4 files changed, 150 insertions(+), 1 deletion(-)  create mode 100644
> drivers/net/ethernet/tehuti/tn40_mdio.c
>=20
> diff --git a/drivers/net/ethernet/tehuti/Makefile b/drivers/net/ethernet/=
tehuti/Makefile
> index 1c468d99e476..7a0fe586a243 100644
> --- a/drivers/net/ethernet/tehuti/Makefile
> +++ b/drivers/net/ethernet/tehuti/Makefile
> @@ -5,5 +5,5 @@
>=20
>  obj-$(CONFIG_TEHUTI) +=3D tehuti.o
>=20
> -tn40xx-y :=3D tn40.o
> +tn40xx-y :=3D tn40.o tn40_mdio.o
>  obj-$(CONFIG_TEHUTI_TN40) +=3D tn40xx.o
> diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/te=
huti/tn40.c
> index 4ddbdb21f1ed..38b2a1fe501a 100644
> --- a/drivers/net/ethernet/tehuti/tn40.c
> +++ b/drivers/net/ethernet/tehuti/tn40.c
> @@ -1764,6 +1764,12 @@ static int tn40_probe(struct pci_dev *pdev, const
> struct pci_device_id *ent)
>  		goto err_unset_drvdata;
>  	}
>=20
> +	ret =3D tn40_mdiobus_init(priv);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to initialize mdio bus.\n");
> +		goto err_free_irq;
> +	}
> +
>  	priv->stats_flag =3D
>  		((tn40_read_reg(priv, TN40_FPGA_VER) & 0xFFF) !=3D 308);
>=20
> diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/te=
huti/tn40.h
> index 6efa268ea0e2..e5e3610f9b8f 100644
> --- a/drivers/net/ethernet/tehuti/tn40.h
> +++ b/drivers/net/ethernet/tehuti/tn40.h
> @@ -158,6 +158,7 @@ struct tn40_priv {
>  	char *b0_va; /* Virtual address of buffer */
>=20
>  	struct tn40_rx_page_table rx_page_table;
> +	struct mii_bus *mdio;
>  };
>=20
>  /* RX FREE descriptor - 64bit */
> @@ -237,4 +238,6 @@ static inline void tn40_write_reg(struct tn40_priv *p=
riv,
> u32 reg, u32 val)
>  	writel(val, priv->regs + reg);
>  }
>=20
> +int tn40_mdiobus_init(struct tn40_priv *priv);
> +
>  #endif /* _TN40XX_H */
> diff --git a/drivers/net/ethernet/tehuti/tn40_mdio.c
> b/drivers/net/ethernet/tehuti/tn40_mdio.c
> new file mode 100644
> index 000000000000..b0d559229ea3
> --- /dev/null
> +++ b/drivers/net/ethernet/tehuti/tn40_mdio.c
> @@ -0,0 +1,140 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (c) Tehuti Networks Ltd. */
> +
> +#include <linux/netdevice.h>
> +#include <linux/pci.h>
> +#include <linux/phylink.h>
> +
> +#include "tn40.h"
> +
> +#define TN40_MDIO_DEVAD_MASK GENMASK(4, 0) #define
> TN40_MDIO_PRTAD_MASK
> +GENMASK(9, 5)
> +#define TN40_MDIO_CMD_VAL(device, port)			\
> +	(FIELD_PREP(TN40_MDIO_DEVAD_MASK, (device)) |	\
> +	 (FIELD_PREP(TN40_MDIO_PRTAD_MASK, (port)))) #define
> +TN40_MDIO_CMD_READ BIT(15)
> +
> +static void tn40_mdio_set_speed(struct tn40_priv *priv, u32 speed) {
> +	void __iomem *regs =3D priv->regs;
> +	int mdio_cfg;
> +
> +	mdio_cfg =3D readl(regs + TN40_REG_MDIO_CMD_STAT);
> +	if (speed =3D=3D 1)
> +		mdio_cfg =3D (0x7d << 7) | 0x08;	/* 1MHz */
> +	else
> +		mdio_cfg =3D 0xA08;	/* 6MHz */
> +	mdio_cfg |=3D (1 << 6);
> +	writel(mdio_cfg, regs + TN40_REG_MDIO_CMD_STAT);
> +	msleep(100);
> +}
> +
> +static u32 tn40_mdio_stat(struct tn40_priv *priv) {
> +	void __iomem *regs =3D priv->regs;
> +
> +	return readl(regs + TN40_REG_MDIO_CMD_STAT); }
> +
> +static int tn40_mdio_get(struct tn40_priv *priv, u32 *val) {

The argument "val" is not used inside this function.

> +	u32 stat;
> +
> +	return readx_poll_timeout_atomic(tn40_mdio_stat, priv, stat,
> +					 TN40_GET_MDIO_BUSY(stat) =3D=3D 0, 10,
> +					 10000);
> +}
> +
> +static int tn40_mdio_read(struct tn40_priv *priv, int port, int device,
> +			  u16 regnum)
> +{
> +	void __iomem *regs =3D priv->regs;
> +	u32 tmp_reg, i;
> +
> +	/* wait until MDIO is not busy */
> +	if (tn40_mdio_get(priv, NULL))
> +		return -EIO;
> +
> +	i =3D TN40_MDIO_CMD_VAL(device, port);
> +	writel(i, regs + TN40_REG_MDIO_CMD);
> +	writel((u32)regnum, regs + TN40_REG_MDIO_ADDR);
> +	if (tn40_mdio_get(priv, NULL))
> +		return -EIO;
> +
> +	writel(TN40_MDIO_CMD_READ | i, regs + TN40_REG_MDIO_CMD);
> +	/* read CMD_STAT until not busy */
> +	if (tn40_mdio_get(priv, NULL))
> +		return -EIO;
> +
> +	tmp_reg =3D readl(regs + TN40_REG_MDIO_DATA);
> +	return lower_16_bits(tmp_reg);
> +}
> +
> +static int tn40_mdio_write(struct tn40_priv *priv, int port, int device,
> +			   u16 regnum, u16 data)
> +{
> +	void __iomem *regs =3D priv->regs;
> +	u32 tmp_reg =3D 0;
> +	int ret;
> +
> +	/* wait until MDIO is not busy */
> +	if (tn40_mdio_get(priv, NULL))
> +		return -EIO;
> +	writel(TN40_MDIO_CMD_VAL(device, port), regs +
> TN40_REG_MDIO_CMD);
> +	writel((u32)regnum, regs + TN40_REG_MDIO_ADDR);
> +	if (tn40_mdio_get(priv, NULL))
> +		return -EIO;
> +	writel((u32)data, regs + TN40_REG_MDIO_DATA);
> +	/* read CMD_STAT until not busy */
> +	ret =3D tn40_mdio_get(priv, &tmp_reg);

Is "tn40_mdio_get()" supposed to return any status in tmp_reg (which is mis=
sing?).

Thanks,
Naveen

> +	if (ret)
> +		return -EIO;
> +
> +	if (TN40_GET_MDIO_RD_ERR(tmp_reg)) {
> +		dev_err(&priv->pdev->dev, "MDIO error after write command\n");
> +		return -EIO;
> +	}
> +	return 0;
> +}
> +
> +static int tn40_mdio_read_cb(struct mii_bus *mii_bus, int addr, int devn=
um,
> +			     int regnum)
> +{
> +	return tn40_mdio_read(mii_bus->priv, addr, devnum, regnum); }
> +
> +static int tn40_mdio_write_cb(struct mii_bus *mii_bus, int addr, int dev=
num,
> +			      int regnum, u16 val)
> +{
> +	return  tn40_mdio_write(mii_bus->priv, addr, devnum, regnum, val); }
> +
> +int tn40_mdiobus_init(struct tn40_priv *priv) {
> +	struct pci_dev *pdev =3D priv->pdev;
> +	struct mii_bus *bus;
> +	int ret;
> +
> +	bus =3D devm_mdiobus_alloc(&pdev->dev);
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	bus->name =3D TN40_DRV_NAME;
> +	bus->parent =3D &pdev->dev;
> +	snprintf(bus->id, MII_BUS_ID_SIZE, "tn40xx-%x-%x",
> +		 pci_domain_nr(pdev->bus), pci_dev_id(pdev));
> +	bus->priv =3D priv;
> +
> +	bus->read_c45 =3D tn40_mdio_read_cb;
> +	bus->write_c45 =3D tn40_mdio_write_cb;
> +
> +	ret =3D devm_mdiobus_register(&pdev->dev, bus);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register mdiobus %d %u %u\n",
> +			ret, bus->state, MDIOBUS_UNREGISTERED);
> +		return ret;
> +	}
> +	tn40_mdio_set_speed(priv, TN40_MDIO_SPEED_6MHZ);
> +	priv->mdio =3D bus;
> +	return 0;
> +}
> --
> 2.34.1
>=20


