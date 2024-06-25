Return-Path: <netdev+bounces-106616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBF4916F80
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 19:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92FD21C20AF9
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE7617799B;
	Tue, 25 Jun 2024 17:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="diFLLuVf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D735176FCE;
	Tue, 25 Jun 2024 17:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337488; cv=fail; b=UYfIyIoPway7GyLAC3mbF70WERZDwHvi7VlSvdW9s8FEX8gP9d7+K8gUGEDGqPIVZPcr0YLyxZE+GZ5Y85DenIgIaa6pgSXryhkqBcDnY+fKj+GbrnKdPz2ELwq+we4xHtSf83KTCxrKTpmTtVb1gYeq67+o65ZFy+0QGrAihY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337488; c=relaxed/simple;
	bh=73l/h9oGUJqLcNRWGSAB5cRsfGDsDVRRLQMfr3Yzbew=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GNfMBnZgOn0ech0NRkgdDcNycNMUqM+qsVb2mSmgAEyDKhmmx8xxniZAs35CnDRtoayO6hoFur18j1pv51lhNCiuDU1Lv2HQXKyBIU1ZlLn74lPzHkuysaMy4I57eZlijTpv9/JTU5kVumidlnk6HQnF8VSR2kqLkfsAWedHfTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=diFLLuVf; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PBtVt1001297;
	Tue, 25 Jun 2024 10:44:38 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yywec9mn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 10:44:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iucR5aGQXA1Ljtd0xmYq+juNzIAjrK+57xmIx43murLj1YegF3iqYlixNyHf0GNtpuSSclRhNXu8rCCwbx5zDprrr6QaG2I0fCSeGdt+7lSdary3s0plMCBjnFQLRQ0VaKgUPw2lqfU8PArgy0lkKgrl8kd3m5hrfyoycLkW2/dR76KaxSYYyiwB0C1lpOPIenS9oVebzIVvAQisII90pSeyrdE0MTNRdR/gTMqv0mmHdDyS5zRH+YBNRXBVmLkBX05lNVaPX4SRNWnB8TXNZDJSu8sqPmKgnPTpeZ88yAs6g6dfVj8+EhLBHu5ZHokmS5pnePFxOp899AhjUmQ+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3bQu8j2vGSt6olF/L261iHhQgwMCY+8rj5/+heGhFQ=;
 b=VRWlkUiK8MHsWqcatFobuVc5BGAmmb7XvbBRBeoB8I08TQDM1uTa00DP2+hSoxduT5NRREVoc+PwgyKD+UBDLqqv5Q9HoKz05QzXdHf7tdIi+UJE5eWczc7PhEi2CE27RMTq9frfZ4v0qJW17Dmm9XnJ6HbWcMbwWmkjKFHrn4HSrnw8KHjFvycRGHPareFoUgnUXPRHhiPFI9jBSD3Gxev1a7xH2s8ssWIKvMd4LXj3420UH9SDPdrPA1+/77pIpavqsaSrukRUzCpjzAswx6Dt4wQvhm4uLf9x629Snk70Q6ExD1ngF9Oh0t3zaeKcIBOC76eS9+c2mBzPn8y9ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3bQu8j2vGSt6olF/L261iHhQgwMCY+8rj5/+heGhFQ=;
 b=diFLLuVf3+LWmqLq2scrmp/iNHoQULw7vPx0XFnk0rdfQTIFabyL+hCJkLkZoBlb9GEgQnfIPMKemVFxEWGvCUr3XmLuRQ/qgH27D5+eYwnJj0e2ZqKByfW6hD2IRhvp0UJN1P5XA+cCdtGCyGPRdxZdqxKltQvFaqnrcDhIhkY=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by LV8PR18MB5913.namprd18.prod.outlook.com (2603:10b6:408:22d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 25 Jun
 2024 17:44:32 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 17:44:32 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Jon Kohler <jon@nutanix.com>, Christian Benvenuti <benve@cisco.com>,
        Satish Kharat <satishkh@cisco.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE:  [PATCH v2] enic: add ethtool get_channel support
Thread-Topic: [PATCH v2] enic: add ethtool get_channel support
Thread-Index: AQHaxydWMyLwYq8KKkSVKkAHeGo8qA==
Date: Tue, 25 Jun 2024 17:44:32 +0000
Message-ID: 
 <BY3PR18MB4707C45665890659CE11220EA0D52@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20240624184900.3998084-1-jon@nutanix.com>
In-Reply-To: <20240624184900.3998084-1-jon@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|LV8PR18MB5913:EE_
x-ms-office365-filtering-correlation-id: 2318bfb5-d8aa-4508-0e74-08dc953e78ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|1800799022|366014|376012|38070700016;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?gi04h+KXqSa9f6DohyhUxe4JLa27g7hSdr06rqlkYHNIbfxLpA++WS12A58J?=
 =?us-ascii?Q?3SW7ascSFE2h8/kpo1fHS8yPji7Ve1kvti2KgpGxDZYi6QfA2J73ojPcZCny?=
 =?us-ascii?Q?jdqidX07MoDpn0UWVrCWFJLxJOLmkiRjHVNVi9VT+7Y224JfYY8rtV5+UmB+?=
 =?us-ascii?Q?v7jQQtlWSA//07Ug9Ifje0nAQtsGzwKyK2jkbZ9h62JaLvGuN4LQ3JhF9MkN?=
 =?us-ascii?Q?DHsGms5jNVD4rgdrsh5U5b+XZtfltHrJ33oownJ/ejBEXHPVWaY46vgBllPe?=
 =?us-ascii?Q?rvz0iQHg+nDrDmPpBNeWWQuoHcwCdxdLXSE2xZE4zSu0PqYeq+fQGQHbW8z4?=
 =?us-ascii?Q?RKB6PSiCt6agJBvoqDQuASqFiNFQgHBbQlIp/q6pow+YBFskGUVI/mBxDj7D?=
 =?us-ascii?Q?0BCNw4k0ekEUd86cOoXwb9T1BJz+0IIF4RX44KTo76GsNBHhm6zyhsY4NQj7?=
 =?us-ascii?Q?ndb6JNRfvNYBY+VsPmOa/7A3NDcUZXNNIBhp7iG9vCpPB7WTTWEPIkmYxy9z?=
 =?us-ascii?Q?bQkIi/P/AqduOFd+EhhUwTkr3D4chfkQdCW6sGW6+5vBOYgjD0HbBxbH62We?=
 =?us-ascii?Q?eyTpL41ZITEERkbArLyXAIE4dcuDM+cpW77CR7y4J1GcTOEkYJvM0Vf3mTYd?=
 =?us-ascii?Q?sgmukjE11Xn2uephqOvlQSTi+cjuF0VL1VORFARxDKy437l5AlGtPsts1fLV?=
 =?us-ascii?Q?eAqZuUY65Gv6W26SrvpFEL8m+R5050tRQ/iiRjAPViCsM/Na3/XULilh9+61?=
 =?us-ascii?Q?oXHo0SO/sbsTuXF+0pdhJVW46uYYdMfpfm9O3EiBitz7NOnVBLcPXq2hzo80?=
 =?us-ascii?Q?6SoW/tmihxTXdwJo6VMuXmOOmv7MvNX/DEwiHI6rTRwfL4EZswwEBhdklyx/?=
 =?us-ascii?Q?AILjUgQHCZRcCRLpBprq2yFtWX6heXp5x53P7NACABgkq8eyn3E4iy21/87L?=
 =?us-ascii?Q?0lSvsoL7eLSgKKuSVdfKWdrEW4VkE+0JA6/5qYwmH2Y71gTXg/MGblFD/IwC?=
 =?us-ascii?Q?U+jDIZZIsY8bj4WKGKVZUScRxJ9PDFYwGesGPWLa/Kd1IzCKt4GBsdSnt/Jq?=
 =?us-ascii?Q?5TfTRpqVfxwGmWOPVlXopfEu6T56oI7UpqjG2Qwl6fnuHVtMWThEO0VsvDfo?=
 =?us-ascii?Q?DrUOqA4It87B+yPwffPVh6KjGjuSDsdXflo366Cl+yhLtemVgcGu8gGTRa7c?=
 =?us-ascii?Q?zKWH+xUKyYylaKr3D1WqhGnBeYgGBuNTKUPPpZ46tkYm7mzuhNuoDIU/9Xbm?=
 =?us-ascii?Q?+Ozzdol1WKj7URr5Lqz1lrUeFAB/Wj7zFs1E2hy1S5WjMxS9f0nZUIS3MWzw?=
 =?us-ascii?Q?ZAFzIugvVxd5mSDgECYPu0UF?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012)(38070700016);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?7fLzrBsfeUGKn+s4X0JgP4s9poIjuFwqNiTDMRh/5wBhXoOxNimcQMPrwWgH?=
 =?us-ascii?Q?wmpiN0rQ0tb3TAOBmXh02dQwR3TeZOBll5bZOy/7CL1c1tvG686Lsx0njj8l?=
 =?us-ascii?Q?xh6tkjOfIKSnzv2u5tYEWic2JjkoS2JZpYR2wgLQUZMa2/kRtk0gRD/1uWNV?=
 =?us-ascii?Q?qZQY5Vt/h5EaTxqlpE+hX+17cFHhJHmI58LXV6rliMTpVyHiNFznPRYkIlxM?=
 =?us-ascii?Q?TYXi5DKsFwu20NE6qYBRRHOlVwAz7yclBY436s/0f5LaVqFXlkphL7UvsPVy?=
 =?us-ascii?Q?ZJOWqDLe6CZQH8WefesEP6QeX4fSLDPKJuUbupUngpWuXhUz6gcKOXMn7SmL?=
 =?us-ascii?Q?DnAWMdjHy49coeTZ0vu411GfJH7qYUYt/KOd3id8FajBkAhN5vZjPOQvqq02?=
 =?us-ascii?Q?sWLAv7JrleS1wVjd4bcu3WQFZyueD/RkazURA+WrMfn6Ah2LBhpN0vfiIr/t?=
 =?us-ascii?Q?uXEaiK/8PZmakK0ISU2H1IT3w5vjtO4p4P6DbtNgZ1DEaIalssvxCtVUHUsa?=
 =?us-ascii?Q?yeChy49Uw1fvJLe1YqEq9Z+plUeK0qsZ0nevimuZKJSqWHfFVsPyxZY8NauK?=
 =?us-ascii?Q?wi0lwkUTSa6cb9ewiB3gVfgK+MvZIEBEB411P2rJc1NQ/nfUfCDJTFG2iMvA?=
 =?us-ascii?Q?P+oUUT2uFY3Wur4ud8clP7puyq0gjo+d+b+kVofhTImSHYzdsBEMGT/7SJGa?=
 =?us-ascii?Q?1K7Q07rwFUfx8XHKox1KmhNyYZ57RGq4uwA8/COGhAkhq18ODq92XbAmowxd?=
 =?us-ascii?Q?uktcxM1AyLP5zknetsbbvYmRE/AM9gnT0ogf2X6NzCt1M9GyU248kv0Zw+Vi?=
 =?us-ascii?Q?+G0YyKNqeW2Yv+9k5mOroM6V3WjRt60g3tbqjzMzDXhW7zoFfpUHCfbfA/eb?=
 =?us-ascii?Q?+IHMrCozrpUliGGMH1On8zacu1jyYpGG6z6nDGXgZmBlZ+/MSuzfb2uxQL8D?=
 =?us-ascii?Q?dmgZAN5peWYoh0QITgi6M7tdl0hVo8PXENCdC+8A8fk0H7SEm2aRyno4Q5b/?=
 =?us-ascii?Q?I90MiB6iTkLNzQQJueohrWW6VGjyhInMTFLNtP2iHT3fa5n8rsyDgoH99sjY?=
 =?us-ascii?Q?0YMKtjgg5cMVC9qflHo3E/cwkUtPQePT9y8frsA0vp7/6BFTHujev6x9H48X?=
 =?us-ascii?Q?zYIbwLQwEzEYBI/sOphw9nY7OZAFl9W+i8ejZWxAftAf/fdM9jAhOOC1wn63?=
 =?us-ascii?Q?pK7NGpJ7jlLF4KWa3ojtNzgIy/rTtaH8zzu/VZGfD+0TKFANyYQLMwFlaRJU?=
 =?us-ascii?Q?H+SOyMm/S533l3RRB+/GuZmeh7l1XV9+Cfo+ul5PnoBBgJEc4P/8M6oflxxi?=
 =?us-ascii?Q?7GO5yoQXDHHIEJULkkqbp/hoyv3by3yPOefV35kv8Q0Gp4HLaGso4UsEz/N+?=
 =?us-ascii?Q?PwQ5SbAhkPplUrBS8oRgUe+PTsj5e0mU5MT/a0IofslMXKl3A04RvQ5af+9M?=
 =?us-ascii?Q?FYhz1rA5id4bOSWHvZI1p7vK5dlrXaVImaBwZshzfMkkDdcFsvRoIsmdO7r9?=
 =?us-ascii?Q?kP1gNeapk6Z0jggsZBiTh2prY8H9w++Ol1W0zRnpBzHhiZwPVeAG84rFyjQD?=
 =?us-ascii?Q?avWJxQA4upHsGgYK1/15mwUcNds2ZkyvELmR/olC?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2318bfb5-d8aa-4508-0e74-08dc953e78ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 17:44:32.4370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1doEirMb9r+8sywYxmwyguhTVOl+mo/gC43r+lOHrPMelfDsJkSU02xSw/C1aKAgzBkMGd3O4Am6Qii82+YbcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5913
X-Proofpoint-ORIG-GUID: lv4v3czYa7chNYRUCPWUOVZQTub2OS_2
X-Proofpoint-GUID: lv4v3czYa7chNYRUCPWUOVZQTub2OS_2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_13,2024-06-25_01,2024-05-17_01

> -----Original Message-----
> From: Jon Kohler <jon@nutanix.com>
> Sent: Tuesday, June 25, 2024 12:19 AM
> To: Christian Benvenuti <benve@cisco.com>; Satish Kharat
> <satishkh@cisco.com>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Jon Kohler <jon@nutanix.com>
> Subject: [PATCH v2] enic: add ethtool get_channel support

It is better to indicate the patch is for NET or NET-NEXT ex: [ PATCH net-n=
ext v2].=20

>=20
> Add .get_channel to enic_ethtool_ops to enable basic ethtool -l support t=
o
> get the current channel configuration. Note that the driver does not supp=
ort
> dynamically changing queue configuration, so .set_channel is intentionall=
y
> unused. Instead,=20
> Add .get_channel to enic_ethtool_ops to enable basic ethtool -l support t=
o
> get the current channel configuration.
>=20
> Note that the driver does not support dynamically changing queue
> configuration, so .set_channel is intentionally unused. Instead, users sh=
ould
> use Cisco's hardware management tools (UCSM/IMC) to modify virtual
> interface card configuration out of band.
>=20
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---
> v1
> - https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__lore.kernel.org_netdev_20240618160146.3900470-2D1-2Djon-
> 40nutanix.com_T_-
> 23u&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3Dc3MsgrR-U-
> HFhmFd6R4MWRZG-8QeikJn5PkjqMTpBSg&m=3DIIWcqk3E-
> aJ8g4EtpjIC9Jg_2T37OpnceY8mwAIuWEBmyGG9tHKaQp1rAgD5__2K&s=3DhTRY
> fTAQB9Tli-3DbKoTQkrJ2OxTBab-RqcKIJUjQTc&e=3D
> v1 -> v2:
> - Addressed comments from Przemek and Jakub
> ---
>  .../net/ethernet/cisco/enic/enic_ethtool.c    | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
> b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
> index 241906697019..54f542238b4e 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
> @@ -608,6 +608,32 @@ static int enic_get_ts_info(struct net_device *netde=
v,
>  	return 0;
>  }
>=20
> +static void enic_get_channels(struct net_device *netdev,
> +			      struct ethtool_channels *channels) {
> +	struct enic *enic =3D netdev_priv(netdev);
> +
> +	switch (vnic_dev_get_intr_mode(enic->vdev)) {
> +	case VNIC_DEV_INTR_MODE_MSIX:
> +		channels->max_rx =3D ENIC_RQ_MAX;
> +		channels->max_tx =3D ENIC_WQ_MAX;
> +		channels->rx_count =3D enic->rq_count;
> +		channels->tx_count =3D enic->wq_count;
> +		break;
> +	case VNIC_DEV_INTR_MODE_MSI:
> +		channels->max_rx =3D 1;
> +		channels->max_tx =3D 1;
> +		channels->rx_count =3D 1;
> +		channels->tx_count =3D 1;
> +		break;
> +	case VNIC_DEV_INTR_MODE_INTX:
> +		channels->max_combined =3D 1;
> +		channels->combined_count =3D 1;
> +	default:
> +		break;
> +	}
> +}
> +
>  static const struct ethtool_ops enic_ethtool_ops =3D {
>  	.supported_coalesce_params =3D ETHTOOL_COALESCE_USECS |
>  				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
> @@ -632,6 +658,7 @@ static const struct ethtool_ops enic_ethtool_ops =3D =
{
>  	.set_rxfh =3D enic_set_rxfh,
>  	.get_link_ksettings =3D enic_get_ksettings,
>  	.get_ts_info =3D enic_get_ts_info,
> +	.get_channels =3D enic_get_channels,
>  };
>=20
>  void enic_set_ethtool_ops(struct net_device *netdev)
> --
> 2.43.0
>=20
Reviewed-by: Sai Krishna <saikrishnag@marvell.com>

