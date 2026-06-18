Return-Path: <netdev+bounces-300365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sUfMMqyyM2q+FAYAu9opvQ
	(envelope-from <netdev+bounces-300365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:56:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFBD69EA30
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:56:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=selector1 header.b=FcKLpWdx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300365-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300365-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F2EC3075364
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 08:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE17331A48;
	Thu, 18 Jun 2026 08:56:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6F2319859;
	Thu, 18 Jun 2026 08:56:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772970; cv=fail; b=V1V333tgaooc9gFUoTJ3tOYtfSBeZEr+fWObN36D7SqnYie/YzqndwNLNOgYjAx3LV/2I9HeZf+uLOcWIo/ye1ajuYtu0DQvliq2PRsh2sKDYR0cPQRwqW6jurcyNDKPMsNqowpbDtAJHsXZsfthWBe/LGgYxJgq7UKuQhlrH5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772970; c=relaxed/simple;
	bh=bkmJK8jVm3yw2HCUKBhTvhpX6I1r2+TzvJzdPY8+pdU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m+om0bpTwtGfSbwoBNLF6M4bPDOKe4hablY/8fnzcbtXq4OkuY0P6HomqJHCDTbCKEU0xEDwQRWxEaDG0VF6og3Ndvu5XMt8LyTfU+BpUCRBZSb+R3nTddIcs3eTDo8yPeppbtukC1ohdyiwIFdVgYTm1YDFk3X8kbFUtMO0o+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=FcKLpWdx; arc=fail smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I8ED4R014755;
	Thu, 18 Jun 2026 01:55:54 -0700
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022127.outbound.protection.outlook.com [40.93.195.127])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eueg5e4a3-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 01:55:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qbol6BcrsusNbnMv236U5c2ZomnAe9YpJJNfpC6ADC/6Zu3QMeRS7kjoX3YKuVu8Az3vNvhXZJS59xrwhdGGyvJNjz1gGQNjvtNRxD/KXN3IV6Yu+4AXhyCy6gBwobwqKyuUR/H1hYc44dgYONw9uwnNs51Hg1TVuJWY9KxMh+39hVD4zX7sSftYlpRyQPgoey4Nk3Vbk9obiTvMmjqM2cazhIuzWNgI/1WulGlDC1mcIsvl7RED6eP5gtQlctDt6zFQYXywUVGzzZJEep+hZVSMsVJ1lTtZiqHsTmPcj+lOsrhhEt+LhlcBbzuTjMdeT7UkBspXHEKIonH30GnlSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqVtkmD6hfO8FmtC+qR6Fh6Ga/hfIf8I3K9r7zjRSPw=;
 b=hY2X4jBM+3b8OHs8wOZWITycVDiLKKYHFDmlmxHuO/CPXKnDz3UhbnptzyTmc72BfD8YA0SeOkDmt69KV2M6OlDxvIUevGy4Rf4ahciVcQyDjfgUMm5WjKeKo4g5+qgTSTf8cjAZ2oqe9/dGs89DofzAFFmUqgvKSXq4SSx5qmd/bZUGmDHSUM9JA1fe1dygwpT175N247a+9nKRaFQfPiswYFBM9zpiGrsCH8Lr0H7sefiAsygcNJDok/cWBTQBu0533BTfD7Jh72NsD4Y37omJOGqUGNzWh5dQPKDqNzsOplqiSsQuKI2W/VWPzOIqXGQafpLkm2bgNDutTzzldA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqVtkmD6hfO8FmtC+qR6Fh6Ga/hfIf8I3K9r7zjRSPw=;
 b=FcKLpWdxdFNYMfb5F4K3oBrWl1ak+xyUp+wVk1vLBYg6CDCyi6qkv4wAgOzjWTSUvBdZqOtokRuWF0y/r+WdRxoHU3YouWzK2E+ZdToOivrHuuV6W4DGiffG01PECx9uO9SaIr2tYsBzizH/Varf6blnYkQ/LXV6NWj4yiqdkyI=
Received: from BL1PR18MB4248.namprd18.prod.outlook.com (2603:10b6:208:311::15)
 by SJ0PR18MB3993.namprd18.prod.outlook.com (2603:10b6:a03:2e5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 08:55:51 +0000
Received: from BL1PR18MB4248.namprd18.prod.outlook.com
 ([fe80::2f85:8970:a4bf:7404]) by BL1PR18MB4248.namprd18.prod.outlook.com
 ([fe80::2f85:8970:a4bf:7404%3]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 08:55:51 +0000
From: Elad Nachman <enachman@marvell.com>
To: Ruoyu Wang <ruoyuw560@gmail.com>,
        Taras Chornyi
	<taras.chornyi@plvision.eu>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Russell King
	<linux@armlinux.org.uk>,
        Oleksandr Mazur <oleksandr.mazur@plvision.eu>,
        Yevhen Orlov <yevhen.orlov@plvision.eu>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH net v2] net: marvell: prestera: initialize err
 in prestera_port_sfp_bind
Thread-Topic: [EXTERNAL] [PATCH net v2] net: marvell: prestera: initialize err
 in prestera_port_sfp_bind
Thread-Index: AQHc/pAeMZIwpdE3W0Oz4X6aWdcLDrZEALAg
Date: Thu, 18 Jun 2026 08:55:51 +0000
Message-ID:
 <BL1PR18MB42486562FC7E64FBEDB08E3CDBE32@BL1PR18MB4248.namprd18.prod.outlook.com>
References: <20260617193228.1653582-1-ruoyuw560@gmail.com>
In-Reply-To: <20260617193228.1653582-1-ruoyuw560@gmail.com>
Accept-Language: en-US, he-IL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR18MB4248:EE_|SJ0PR18MB3993:EE_
x-ms-office365-filtering-correlation-id: 80a0c243-c959-427d-e116-08decd176611
x-ld-processed: 70e1fb47-1155-421d-87fc-2e58f638b6e0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|921020|38070700021|5023799004|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 Syt/Rxm4pweB7N5WYxjw2QvL6wGi9ryyjbTFAexFbyGVaqfmR9E5RFo1nhBpsxJsZvUX3MLX4tJcFSqzgjDVfgpkGsR+5JCF2dDxlMfoai2d86GKjepMMqKeV+Wps+DASoh6Ju+r0/SX/QIalcE2+rRKFGKQqQUx3qhYixKiPD7YcEn3o/JvOzw8jAVzl9x6jzvBEmI26f0RwrJvII6p97KBqYJgaJD9jJbLz+xvsRthyp5Daui2AJdCfmwJ4xuSHFDHt0C3dZxi09cAoykkmFwvkbTFkjtzBlTPF/o5/EDNlHAiM6I19xAisY29nF1GmFGJdqMI23fLFXdBwsVobwBISN/KMm5wgvg+dSnE023WRTeGzSx/cKt57WMnmnlFnCtO12rpfYURzegZZz2r0v4WpUDIVTFYB7heDUwT+7ixT9dOUah7njTG/ijyU9RIFZDdhfi6nEIWrknn8hNlknkVsT2g6uH7ZmAF72rZitQ0CVl11PZ3VS5XBApAd98HkVami8pA5YEJmjwvjlWHlpMoAhXTNu3DYn7jmv3xv2EvpB22l0/5VFClSPML4FqyTA3q8MzLgg3ktiBrVIuJxM1GuDhkjzSalr0zaW0GSbcPZ1ocKe7GjSuQq1EDQe0WuR+0miNwRKRPbaByODH9leAJiJgMcf1+NvuWAa0y3Vg3+dOENKUAB+r+TUIq8pofG4eVnRWUoX6KzyyDQuIIdVvMWoiaWV2Mc+8lIndNyQScSX/hluK4OQCFSzegYmsMNQDMieGVk/jTePZAfTa09w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR18MB4248.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(921020)(38070700021)(5023799004)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?F7Nn61BIYRx/gmnNBOnlGcmFcvYa330XLUTA5ZSiE/AlGMkaqZK5vUl50FF2?=
 =?us-ascii?Q?3pHaG0feno2dTLK+OuaI7AWLJMK6vuCzUHQgUaSWu8ITan3NEIQyR1It4ZoC?=
 =?us-ascii?Q?vvgxt962YE0qVjw8SKuvJnayV542LpAcqNtlErEj4wpJXq9w2tVKYJx13+WW?=
 =?us-ascii?Q?dJGa0O4I78nz+CojRRzV/tERpC5PIW9S5IcLIXfQYHyUid/XpUT7D5bcGu5L?=
 =?us-ascii?Q?pbNqPSfWZ8KVx8cm+FNFde3RAHRXDq0Owm0LOfvux+j7PylXrcAeipMSxv5P?=
 =?us-ascii?Q?ELSVkfCcLHH4LKLpHZfRldHmwH+CaJKZ+P7C4GwgeVmdOs+gJX6m6WNpJ3wB?=
 =?us-ascii?Q?507PXB6k+5YCJoqsAhSAbGDMvI4gvKQBfCIrofyH1TEE5qiYlyndAxZSJFF0?=
 =?us-ascii?Q?lg88iUzTNi7p2+akgjaBPnhYMh1OOlQ8Qjr53O5UPkjrd+Iwi9oYj90Rsm4/?=
 =?us-ascii?Q?Txu/CwNU7J0MmRqb1Gm6MYYMGvxvM9InvGoCSTorxK2Hmlf2nytmlySQPyS6?=
 =?us-ascii?Q?37lCLZTuaT4sJ3dcE2hWBAGfjzSXw7XwHH7qRChQzUL0GJxLKRyHbTIcjyw3?=
 =?us-ascii?Q?DucjfIER/MeWjOHB9Q2gC5uTQ1xDENmHHig+fJVLLWCDireYPU+BgYUlD+rL?=
 =?us-ascii?Q?toitXoqhB11HcWyMMUT4wWpniGINM0LhzXruwEP4SZvMyEkxaBy/YupNm/74?=
 =?us-ascii?Q?/XOAIEph4JIokmqKjAuT8T70u35I3Osme2sLreyrq3wc5R8upoCpGjUsmBqF?=
 =?us-ascii?Q?vmz6usm/WvUi2Lghhw6gDFIgMTHPP0Tujjhm/qVg22bL4PA609Jy0pYqHj+V?=
 =?us-ascii?Q?qZNWeOrx7LpFuJBM3dxgsf2fZsXkyiINRmwGDuDfmvS4CBNLttwIRikR2BvP?=
 =?us-ascii?Q?b1ZRQtyQxVgCQdwDLdHollAiUNOdQ2B9yvKnOwy5VmpHze5RGJyd7+qIkFo/?=
 =?us-ascii?Q?scFMT/i0WlejIXzn4Fc90Qqhsn5n0mgB8LF7z3rA1MV2fHd7Cqo4F3gRAGiI?=
 =?us-ascii?Q?iQFQnI5Z//Uljb6GyHEPD0wAzIC1vbCmYWwQiV4F0GFdCMRh6eBZMV3Akbwe?=
 =?us-ascii?Q?HrIX6ySPf/c6mRNG7aqfr3k5cO/UQgS7NnVQFqjkC3bsmPVdKR8UvkD8ndg1?=
 =?us-ascii?Q?zLVFQ0imDY5MN9+VOew6ZAeUPK5zAxZmUo+EcWCZXha3icbn9PaXKDVveuwX?=
 =?us-ascii?Q?Yn+n2JbmWMn1eJWGZWezvC7PCyhOSL9J0SmrEayui7QhTLrd3JNia5XcCvnn?=
 =?us-ascii?Q?j36V312t+NYFcgg9muoJ0I5v6KaGBpu4PYSQPY2rjrqAhTeLfBInPQXvef+L?=
 =?us-ascii?Q?Gi6wdXXg4eDWk3ESmurX28Qhgx1KnPB8WX8shQipAnfgqhSXYJznqrd2BV/y?=
 =?us-ascii?Q?6UxY6HV1myg1iZHRI1dHFFQccS4YG3WzS9Y8rXAYO7HfH6KRHcN4+N+3eB7N?=
 =?us-ascii?Q?+BC9E+d3keMcEsJtRZSe+UjcLZD4J35mNd/fP3P7J1/wCOXGA/UQgz04nkWD?=
 =?us-ascii?Q?bCaE1vZ3W2eaE/kX09/lnB4+834tn+7OHKoq9v5ZZNMleZ8GW6MtuZbWzvQO?=
 =?us-ascii?Q?K5CcneXnjz1mu7fbDYIjk2je25XlCvJ7SVBLINXndsFF21udz/fRnGJVAb0L?=
 =?us-ascii?Q?KpSx63rvIHKzSfriiiBj0Kce7/tuHLTnA12rSgr0IR9Cw7IIm96d//AN0+dO?=
 =?us-ascii?Q?6HzK2+ZSoLP4AYmxc31PmT95vyPGaG1/8tSK/iigtLIumvzt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	GlZj59cUtQXKSBh6ntZDsWWHHQUSi6X2FzlPidfXvJfBAbCHAYdWcEocLoux7lFZYsZV+Shce0w4ztxi+9a1JQwXenBudRLxfl0pzqwE0G4fdS7OWlp48LXqBCxtv0s1PJWJ6cF9Y94IcNeX/1hcMCMJf/Xjn/RaXp5q8GHSC9EsyyR75lfZ/9oQIhpRhu93il7ScwEG43/ZTH3MRlVnH0gZDjgNYlJKlmFcFDGlxmLJ1fy1KOsTrvmtmSmkKmd0LcNbUMMdzXV3PbaBASfT6NCPQGYxJkLfMbWZwA5JfZ6hEtQNTLU52dho9KyvRU6IfWGg7XVSIpToIyOjj2fDYA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR18MB4248.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a0c243-c959-427d-e116-08decd176611
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 08:55:51.3547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DQosM41VD1/4tU7QwtaSZl0it3xIEwSl1LvwP94Xjjr1FuUXAZ0tStS+7VS/K27OgslRCVzQReFJguCroL1unA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB3993
X-Proofpoint-GUID: -KsDh_Xxn242o3GbDVdshJx6ENQHsxrE
X-Proofpoint-ORIG-GUID: -KsDh_Xxn242o3GbDVdshJx6ENQHsxrE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA4MSBTYWx0ZWRfX9g5ONjpVA/Qv
 ArnoSVatBI4jMvY8M77QkJYK0xEg16aCScCyog7f8OpRZL+bUFvFRRVFC+Bc1t3rpqG7NTbXR07
 0BCJjlBAqir/bFnKgLmBJoKbGCa0V9k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA4MSBTYWx0ZWRfX2XS9f1r5I3nc
 VX0oc+Q0KH/NbR1vDDjSdtZ+RyJySgAlsFOOCu91P05mrYaytZcUQeztvC5UsRfPOfk/892Ajr5
 ndSjmHLEoOMnfotzMZW8C5dbejVA983gqgRw6XwDQXW60stlJwwPkVJfcGXW2F5xmgh0SmW1U92
 zWNMaXvGNOfWmEKkQfTsPnKVh2v/0Rs1r3uuqsxlkBArSvbHokdInTbrp/d68wze141vCbcnhiw
 q3ZAe6/nVHovF6um7rIRkrNj5agqR3lx8QmXJm6DAPuWjIvhc0UkQfnejOwVkoIaRtDP2ThHPoG
 lvteopo8lY+C796J/zJnSV8yHuI8JJaFIdmEC+yA/6ilaww0RyKBWUPVJTYIUxPQQ5lDwlk43Hb
 u3TtycA3DMwx3Ja3RP6EPbhH3as3Nobmg3hDkyBEQGCGuQuqHb5XHtlFqtW+/i+npaP814lXf9s
 eX5GTaFUG8tGDAdwQSA==
X-Authority-Analysis: v=2.4 cv=UqNT8ewB c=1 sm=1 tr=0 ts=6a33b29a cx=c_pps
 a=4J2h7sJdpVYe1tCXGSmzzw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=pGLkceISAAAA:8
 a=g8kJ_gb0AAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=PHq6YzTAAAAA:8 a=M5GUcnROAAAA:8 a=DyCsGZyHgVGpfJ0Svo0A:9
 a=lqcHg5cX4UMA:10 a=CjuIK1q_8ugA:10 a=ecSNLfPMzbq-p5zXJZOg:22
 a=y1Q9-5lHfBjTkpIzbSAN:22 a=ZKzU8r6zoKMcqsNulkmm:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300365-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ruoyuw560@gmail.com,m:taras.chornyi@plvision.eu,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:oleksandr.mazur@plvision.eu,m:yevhen.orlov@plvision.eu,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,plvision.eu,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[enachman@marvell.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,davemloft.net:email,vger.kernel.org:from_smtp,lunn.ch:email,plvision.eu:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enachman@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3FFBD69EA30

>=20
>=20
> From: Ruoyu Wang <ruoyuw560@gmail.com>
> Sent: Wednesday, June 17, 2026 10:32 PM
> To: Taras Chornyi <taras.chornyi@plvision.eu>; Andrew Lunn <andrew+netdev=
@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@go=
ogle.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com=
>; Russell King <linux@armlinux.org.uk>; Oleksandr Mazur <oleksandr.mazur@p=
lvision.eu>; Yevhen Orlov <yevhen.orlov@plvision.eu>; netdev@vger.kernel.or=
g; linux-kernel@vger.kernel.org
> Subject: [EXTERNAL] [PATCH net v2] net: marvell: prestera: initialize err=
 in prestera_port_sfp_bind
>=20
> prestera_port_sfp_bind() returns err after walking the ports node. If no =
child node matches the port's front-panel id, err is never assigned. Initia=
lize err to 0 because absence of a matching optional port device tree node =
is not an error. In
>=20
> prestera_port_sfp_bind() returns err after walking the ports node. If no
> child node matches the port's front-panel id, err is never assigned.
>=20
> Initialize err to 0 because absence of a matching optional port device
> tree node is not an error. In that case no phylink is created and port
> creation should continue with port->phy_link left NULL. Errors from
> malformed matched nodes and phylink_create() still propagate.
>=20
> Fixes: 52323ef75414 ("net: marvell: prestera: add phylink support")
> Signed-off-by: Ruoyu Wang <mailto:ruoyuw560@gmail.com>
> ---
> v2:
> - Add net tree target to the subject.
> - Explain why the no-match path returns 0 instead of -ENODEV.
>=20
>  drivers/net/ethernet/marvell/prestera/prestera_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_main.c b/driv=
ers/net/ethernet/marvell/prestera/prestera_main.c
> index 41e19e9ad28d4..a82e7a8029851 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera_main.c
> +++ b/drivers/net/ethernet/marvell/prestera/prestera_main.c
> @@ -373,7 +373,7 @@ static int prestera_port_sfp_bind(struct prestera_por=
t *port)
>  	struct device_node *ports, *node;
>  	struct fwnode_handle *fwnode;
>  	struct phylink *phy_link;
> -	int err;
> +	int err =3D 0;
>=20
>  	if (!sw->np)
>  		return 0;
> --
> 2.51.0
>=20

prestera_port_sfp_bind() iterates only SFP ports.
Although all currently existing switch boards have at least one SFP uplink =
port,
In theory a manufacturer might produce a switch board without any SFP ports=
,
which will unnecessarily fail this function call, so for resolving this cas=
e indeed
err should be initialized to zero to make this function return 0 and not an=
 error.

Acked-by: Elad Nachman <enachman@marvell.com>

