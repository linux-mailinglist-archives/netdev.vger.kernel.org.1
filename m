Return-Path: <netdev+bounces-96682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3228C720A
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 09:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A391C20964
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 07:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C131128DD1;
	Thu, 16 May 2024 07:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="iNs/3FD1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBE91E48A;
	Thu, 16 May 2024 07:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715844521; cv=fail; b=JzfdEcuYs3IVXIUHH//F7m9SzszPEHqfmeZPXiP1m4k6xIapZs6GW7oSi5clpJHLLVQ21Bk++YvS7XQZn/KjVrbNgzp/mbMQriGmJzMqvVxWcy2iRAEm8i+0M48ptooj1P9aZHMHZjS7swkcry5ixmlkDFl0+7yst3FVy3yUqmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715844521; c=relaxed/simple;
	bh=DKyys0xtYXKCbCpt53fQHwQXWJ2knyB4VG8NH4EHzns=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RdFJ1oD04d5vSk46+MFFmXcFtq0SSS7eMUXyRqdErwEtgeSvKBuMA4mT+BCoNDtxF53lK2s9tgF30JZNcBk1WHzlozD6pQoclnG26rebiWL59QYm6ILZbVxxM9DdXN4eOdoBP//d1Ft1hl6f5pJG2sKeyO++Fimc5B6ltl1fLno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=iNs/3FD1; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44G04OcQ001122;
	Thu, 16 May 2024 00:28:11 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3y579b905f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 00:28:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Etf/RnAfVwaxsfsO+zBx92GqP4JZ7uZnZOy3xMPPHW8UX/+V4dYaHSa5WSO0b0KewqNa5ZN7VEzZQiTDXdbzgeShkv5QcVybomD0408249eszIwMEZfI2QO5THDkAmrwEZNODlTFBNfE4ZeXZOvSmNh9+nHty+XE/besdkQYPxDDuKcnDevIMRAXQa3NFzJ78Ocs2Ecy4361JZjjgfC5FEXhTbrldL0hTa6tqq4uO/rXjGp2Zyg69wq6IQO8Rc8iXlgPhmNrHmGWJ5OTEz6xCNvTPMCWuf81F6dpMX41wMol1IdcqWC8Ooe5Gq2IcKEE4IyPORk8Idu217MwFB0WHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEA4E4/SOyoWiSXNST5x1aEwIQrF1WCWfYKEqDakjf8=;
 b=UJXFz4H8dVSB/MmiZeqYQ94ylI4RZy8TSVK9+gSSC2P9u5v3ooAmNBStgwOm4GaLu1C7v6P3YVUeU+/CtdBcR2QdTOgZW/4ns2456axlEZNcnimLXK2G+i//6YpFgjyC0Q8IbgntCpQKNwnlBjh5sSMaO+M+/ZFU5guTUteBbleOjLBIq45WggSUVenQPB3bgLgGhpEmJ+mgcdapptPyHAYWLZbvEfDVYtEfkJlilxAh5BUFSCOjU+upYRtuD9pJEhp/KtxXntWtliYVo/QTO5LLm7MrsMzvQD+UH5Nx14OO2L7h1VY6Q05CpxswFxEEg5xtXJlclLmm9AZgm3MP4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEA4E4/SOyoWiSXNST5x1aEwIQrF1WCWfYKEqDakjf8=;
 b=iNs/3FD1nU44Tf0pGB4s8wDlxWJbvME6bUkOMI1ifTKFIUomavAj23f+8anBnciw62zK+GQdBdh8oJEHVo1CT2WEiDlHHdzdkr0Rx9hLnGEmpmPOTfvTjohYQX4seCqv6YMep2uMIny+yvxY1niut+kEUK5F/OU8AxLL9em8K6Q=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by BN9PR18MB4234.namprd18.prod.outlook.com (2603:10b6:408:118::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 07:28:07 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916%5]) with mapi id 15.20.7452.049; Thu, 16 May 2024
 07:28:07 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
        "David S. Miller"
	<davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet
	<edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean
	<olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss
	<arun.ramadoss@microchip.com>
CC: "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
        David Ahern
	<dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
        Willem de Bruijn
	<willemb@google.com>,
        =?iso-8859-1?Q?S=F8ren_Andersen?= <san@skov.dk>
Subject: [PATCH net v1 1/1] net: dsa: microchip: Correct initialization order
 for KSZ88x3 ports
Thread-Topic: [PATCH net v1 1/1] net: dsa: microchip: Correct initialization
 order for KSZ88x3 ports
Thread-Index: AQHap2KYtFQlblzcdky1cgB9oid70A==
Date: Thu, 16 May 2024 07:28:07 +0000
Message-ID: 
 <PH0PR18MB4474CE8F239C66F349F043E1DEED2@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20240516070852.1953381-1-o.rempel@pengutronix.de>
In-Reply-To: <20240516070852.1953381-1-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|BN9PR18MB4234:EE_
x-ms-office365-filtering-correlation-id: 2ed4e87e-e667-486c-574c-08dc7579bb2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|1800799015|7416005|366007|38070700009|921011;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?S+HSbeLnA2WfmnNzNHydwzrpMlmCoWIjxtIlq8MAxM0yw/jGKuhCFn9p9E?=
 =?iso-8859-1?Q?DczP24JkzJ/xQ0xlv195VuNVE0nAxxlS8NzJvkqRVL0JD15AYdXod4iqY+?=
 =?iso-8859-1?Q?9uiMTRLMsxAH/16bL35Q7j/n+QDwnwr6GV8CQ9fVzr+ODMUMVTGI+YPGu3?=
 =?iso-8859-1?Q?uZ6FkGz7lSPKghm3tror84JvF9xl/f5XQ0PZjZu20Z9lxZ4fNBiGy3SQ7d?=
 =?iso-8859-1?Q?xJ8TVVhKNYSxVjxYE1ukCWrwXYrLDUgsj+mNzyLnlPmesrSdyrT9YxZEJG?=
 =?iso-8859-1?Q?vThxPS58bv23K4pvVi1JA0Y4NX3gv8h/LqR6oYf1US0YBXnt1VGdxuf/vP?=
 =?iso-8859-1?Q?JdeDjG+Kv/6+qADEAZpdhqt7bkhzkHiJmmsUpiXNC6GB1iuxamF2z852le?=
 =?iso-8859-1?Q?SVRhhWrzazruzghD78NN+lgGTqfKd+bZ9kDjYfj147gJP5y4cFP73tou1B?=
 =?iso-8859-1?Q?ZUvmn9p4TjKUm67t6h8DidFGMe6rg279OLwygG4Aur+3Mxpb4ata2eDktD?=
 =?iso-8859-1?Q?PQ2LorN9kGuRx6A0IphVTZuipIpCNjyzq3Mcfh06OSJTuI1e0wSGKtJphC?=
 =?iso-8859-1?Q?xwPB9+RH9QRf1GBrWlD5BhOCX2NQjSW131wZCRWL6JcRrRS4mXmnDnd8Pa?=
 =?iso-8859-1?Q?MLCWFSLpqMaIqwvtqUmChOJGNLBoUejqzUyw6G/Jb4GrT2hC7vlilIAJCP?=
 =?iso-8859-1?Q?bn3o2qAdVTlPxzDRa9+RE6CpQ+yoC0k5avFIksauCMxsatHEsqPmg0ImlR?=
 =?iso-8859-1?Q?/ev5Ht1q6LQEjjOQpNBahPs9Lf+ITc4/GbVZMqcFq5kP0ELw2pmJlkKz/X?=
 =?iso-8859-1?Q?VaAjgg6w+BEK7JhdrVUT1NM3pRhj4jk/vbjY2um3pdy1nmYgg26WK46VR9?=
 =?iso-8859-1?Q?nvsJfZvC8XS5Ku6w4EqlktlgOOz4r5LBV7FUo3hgpVzDoc6GuUOQzZb3wi?=
 =?iso-8859-1?Q?BTv+amDmVfykCNbAj8JFbli7teBz4bah2+G7nkUVPD1bIpc/Oe5j6YKc2M?=
 =?iso-8859-1?Q?B/LRjrnrufyq4kn+OxZub3KMMMKh86WP9xxiWdcb5WyLPQ1Z+/X5wpEGR8?=
 =?iso-8859-1?Q?XTPsIyr8aS/WpDx89nZfN6n3qnsX2mlc8Oqyuftu3HDc5NWdRske8oBIJy?=
 =?iso-8859-1?Q?HslBuGElAOiRhyZyyjrsPlIsRxWEKQhr9yyXyTY12ga5RQVSdHEgcJGL2+?=
 =?iso-8859-1?Q?PPKAeU3rCmeVGdAo//GFt6Nx87SmQ+oY42+RNDi74vD7HHcU1RmocfI7mC?=
 =?iso-8859-1?Q?rNH4pKIqVk5FBZLzgdtkwq4h/Icayv4JKToUt032HAiVuhBiJ2tlBrU+sb?=
 =?iso-8859-1?Q?2SWT8tGEvAIRsyRiJQGhySgD2d5b1dPYamX8Q3ihNMgI9x69IjYzdmWu5y?=
 =?iso-8859-1?Q?mF99kXepthq3dBeENASt0U9257pQoyGDt106nmtoNywv+9cRjbGio=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?ysbwMol5Z9ZUDuX64sXNy3bmjar4JE5ysepyOSrPSU6psvAU0/t6Ok00hc?=
 =?iso-8859-1?Q?FdhBIN1kO7jaiGHeXDoEGyxAJAf7cdMx4a8n/SPvc8sgQ6+jwPFJNpVu13?=
 =?iso-8859-1?Q?u61OcB8ZwBwnOngSLlUJT0lGVVnY8wjTQH00EVQOOUiney9na3/n6b62K6?=
 =?iso-8859-1?Q?W9ZItcQFaWgrYjUdnyqPI4vkin1kKoU8iL2GPfyKK6S+pzLHf/g9SqM47R?=
 =?iso-8859-1?Q?0cYwZHC9RJvRuf1BGo/GJdKr/NJcTOFn9brMtlLPNjU3biO1QeHQIf748T?=
 =?iso-8859-1?Q?AwJc44DVOGXupWcqfEqSWbuSb///810Ohum9VQ7ThwFfxEoIpQuKw3zZ1J?=
 =?iso-8859-1?Q?3SYnJVOfDFXmkrR/YkpookaspdqwLymBwvQRRedEiRo2XTTNg0vf2hDVBP?=
 =?iso-8859-1?Q?36aLAy3A6PEiV90m7koB3fRSqD7R/5hQl3z/qeX5apku7+/QiI4Pj6bDaH?=
 =?iso-8859-1?Q?ClkEvY5fCMPTqfw2GkbLbD3Bhhz0i7w62tkWMdFCqrFk+OwN1MVDVwDopg?=
 =?iso-8859-1?Q?CWqnwou+xkCzBn41ldc1IdpeDRihVJ6STBh3oVPwKY8QbkNo05ChwWgwO4?=
 =?iso-8859-1?Q?P/Qntrg7SoP9fltiF46s113RO1KVu2bj5AqnM0T0AS6RgjZahhQbSi42jf?=
 =?iso-8859-1?Q?AQTVIAelzjZg4EBBjjrpv8xNmasf/yk8eHwdyYGURAD5+DaAomGT14jmsH?=
 =?iso-8859-1?Q?SVeA7cEkKadGZ6F+7ObzWNNr5R9tPHg3Ee5qd3kI8sDj0FluBSLtCSwIIH?=
 =?iso-8859-1?Q?tE5CRVHASHofj1XaWU8iOiUNZBKVK9VFEgufE74bepEG0c41BoAgEIvOnM?=
 =?iso-8859-1?Q?xVZkyxiK2SL2h88aT6YzWNyap/UmGYeb82xx85FhPfsifW9H2Gp01eIdev?=
 =?iso-8859-1?Q?/6Au4Djou39Tl6ff6PVObiMCWlfLfJB9CuNWWvRTOFyZsSlqU4AuvgWZpX?=
 =?iso-8859-1?Q?vd9OoIv43wnaknBBOfHzgI+kihFweYNFnQS8Ezrf0pNfkk3VnA4fuTgRme?=
 =?iso-8859-1?Q?emUIR7k42mc2tcIk9pkykKIE3K7OjYrehEIW2rqd3C4+6+Wp+Y+xezLsZL?=
 =?iso-8859-1?Q?B6JEIoojVrELuJf0OLpRCkuxRCV2Aey0lSxEJ/wJyIuhta7HIyOg4Z4fZ1?=
 =?iso-8859-1?Q?anvkixL4GLulw18F7taJU/xc3XREUvz0Sz2EUGJuaOcBIV6mVde+t48w5+?=
 =?iso-8859-1?Q?fipDqiIvRJrY4SDLe4yjcnWOdiPmLj6zBtTQckAUXNeLa2buock9jBgFU6?=
 =?iso-8859-1?Q?z1ExfqPy6kZRfoVwLuPCM9jrxFc64lDzRR4GlCiBrKum82DjaCYG3UP/HT?=
 =?iso-8859-1?Q?SHJPevv8ql8e0MYeCg27gDM1Rb1sgc29rUBk0mQucUCQBvCsRok4B4GIqa?=
 =?iso-8859-1?Q?X7Dtj3UjG54j8zssg1+kX+L8KgVT0fNsqqCGAQdpIeUp87tTkVKK4p5Cb4?=
 =?iso-8859-1?Q?kHQAERY6LJ4Bcza1Ots5M7SydH29g2BUf7MktxPumts/F3VOa/1YF6nhBJ?=
 =?iso-8859-1?Q?fiSHsF0iZSrbf2EBRDQ+3NI2GZnYsDmjfOdw6dbkmBQysJv/SUCZIkvCPH?=
 =?iso-8859-1?Q?Yv/9yQXe5HU3ULZxSa/8tHB8mNSsiP7qcDcUa3FbmwSuQt3V8tDSnFsq26?=
 =?iso-8859-1?Q?qK0ze51T3CaOc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4474.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed4e87e-e667-486c-574c-08dc7579bb2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 07:28:07.1427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rwkS1EBZW55O6jCL+eaWKj3dLDkZ4sDl8GgH4rbYFWkyDjMSZLv0Iwn+3pYR6cH2QKEn405mI/Rb+Csxi+fXpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4234
X-Proofpoint-GUID: 4s_IqH20qhS5lWrz57mYXBRTCMqIOWTk
X-Proofpoint-ORIG-GUID: 4s_IqH20qhS5lWrz57mYXBRTCMqIOWTk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_03,2024-05-15_01,2023-05-22_02



> Adjust the initialization sequence of KSZ88x3 switches to enable 802.1p
> priority control on Port 2 before configuring Port 1. This change ensures=
 the
> apptrust functionality on Port 1 operates correctly, as it depends on the
> priority settings of Port 2. The prior initialization sequence incorrectl=
y
> configured Port 1 first, which could lead to functional discrepancies.
>=20
> Fixes: a1ea57710c9d ("net: dsa: microchip: dcb: add special handling for
> KSZ88X3 family")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/dsa/microchip/ksz_dcb.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/net/dsa/microchip/ksz_dcb.c
> b/drivers/net/dsa/microchip/ksz_dcb.c
> index a971063275629..19b228b849247 100644
> --- a/drivers/net/dsa/microchip/ksz_dcb.c
> +++ b/drivers/net/dsa/microchip/ksz_dcb.c
> @@ -805,5 +805,18 @@ int ksz_dcb_init(struct ksz_device *dev)
>  	if (ret)
>  		return ret;
>=20
> +	/* Enable 802.1p priority control on Port 2 during switch initializatio=
n.
> +	 * This setup is critical for the apptrust functionality on Port 1, whi=
ch
> +	 * relies on the priority settings of Port 2. Note: Port 1 is naturally
> +	 * configured before Port 2, necessitating this configuration order.
> +	 */
> +	if (ksz_is_ksz88x3(dev)) {
> +		ret =3D ksz_prmw8(dev, KSZ_PORT_2,
Nit :  instead, just call return ksz_prmw8();
Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>



> KSZ8_REG_PORT_1_CTRL_0,
> +				KSZ8_PORT_802_1P_ENABLE,
> +				KSZ8_PORT_802_1P_ENABLE);
> +		if (ret)
> +			return ret;

Thanks,
Hariprasad k
> +	}
> +
>  	return 0;
>  }
> --
> 2.39.2
>=20


