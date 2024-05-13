Return-Path: <netdev+bounces-95971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B608C3EEE
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B1928558C
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7E44437C;
	Mon, 13 May 2024 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="JISMFj2+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884681CAB3;
	Mon, 13 May 2024 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715596305; cv=fail; b=GtDO0H2kB35+ynAQJ4ZpKkC+nxDxfvf32sEW6YnYwpy2SyMNxv5iCOEo3MdYM7zHF5LOowBcSq7txxAJN/Yh5+rs/a/bYhNGcPIKt3kvYKBPeU+P94oO1+/B2bUIs1pNtyS/eaT/vz746eRFukJojOeXa84UWPqlwovne2JVtSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715596305; c=relaxed/simple;
	bh=9u3C1VCbgYlIwcMEY2aaHsaZcqOP1+kiWwPaMpDL+fE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hbnjq97v1y0b++pC1H2mkyOsCGv/vlEw38DdQJeWQg9kiPi5/1wz9cpXMUWsNccOAOaFRTdWnsnzZiwsiqJzlVKuRqSoFmWyCUxMQDeknyOYuiNtrQ9gGOzf2VzQSPvxk6TShpJhu4ZhIIluDvjZr7nEZ+zxUOSxUkk0Zd3dGH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=JISMFj2+; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44D9fi0Y014208;
	Mon, 13 May 2024 03:31:37 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y3gf4g3uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 03:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7YjTUuailkZoEMAqK1sGUP0/5e2COaTmqnVYwfQZIDRIv2+niYL1mU9DGux6zs82t53u8KJycMXOuinmiGyi3wGYEVNTtolD45ja6rxBKBgnTEpyo1GThKEno8rFxM+pRNrMt6+nEmwtPgtTTfD86LJVgMDe2TCqdVSyzEOBPMrMpcbRVFYaIPqrHYUA9ZH2fu8/q/4RyrCJMEQdIKEXJs6/97xAZUoDmtZxeFj/spP4UROG1+J2/p4mOfgDfGBaFzCJhd4sXj3f6WKYqpDBJ6+3s2b79ib/9fjRl8Pqcmhcl/wxOzWGRWApzVQOsIJVcclqz2kaCx7tryKO0havA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMWvOnWVUU8JNHfVVmh1YHZvcRGoovnVmuwuNUO3Zgs=;
 b=XhFoTIUbLPFQRw7jPbv4LWThbLgOlG7CdmvVHTeU/xwJ6cabpWkW3RnM7NO+Z+qd0vk0zPLIZpyn13wy43GlhZkFSkhpdi2bgvkF8i0RDR9L2T5RjAk2nPmiRABYdVAzYylJrrROvThOb3zYSmeP4IbDU4wO/KlK1C5JHKXssWXhtXi4f+8V5+JJQv9wIDlFYnrH1NNzMclugOeZzEZlyMSTvbQ8OeRUzLmIf66mS8pNDo6NARuahVPNbmfYlIbtfikStrruibRnis8NDaTvTO9f5TsqedVh6V0AYr618Hm+BoSMyK9F/sLJ4xR8hYl1qTKWyPhtcol9MNMAqMP+HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMWvOnWVUU8JNHfVVmh1YHZvcRGoovnVmuwuNUO3Zgs=;
 b=JISMFj2+2AgZod4GAfRtnEK3XDXyJ8z0heiYTJvlnaKAGZnmZoH6Hl5JjBVHpowMc/VCtx8leRVMfJ7vnUqEdFCDXvJarLRU1iqkVysmURQTtehpDDt84nd7yyBEFSbK40Pmz1JgwuwTjreHuMPAr9OUWEgLv15rXwQNgmGjJqg=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by MW4PR18MB5082.namprd18.prod.outlook.com (2603:10b6:303:1a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 10:31:33 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 10:31:33 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil
 Kovvuri Goutham <sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v4 00/10] Introduce RVU
 representors
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v4 00/10] Introduce RVU
 representors
Thread-Index: AQHaoJ0hUHsTlISHgUKGS+7tVuhSG7GP1RyAgAUqYaA=
Date: Mon, 13 May 2024 10:31:33 +0000
Message-ID: 
 <CH0PR18MB43394B847D270FCC1645EF58CDE22@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240507163921.29683-1-gakula@marvell.com>
 <20240509203557.61841c70@kernel.org>
In-Reply-To: <20240509203557.61841c70@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|MW4PR18MB5082:EE_
x-ms-office365-filtering-correlation-id: fe12d1c3-7b8c-45dc-ad43-08dc7337dc3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?sZF6udPFZ4E7d5WWv1ynDRoXefn3On68A3NTaOmQx0hQFRJnSFZc0gZJh9In?=
 =?us-ascii?Q?kPCEppdHgOY/IiWYIciYL8iDjVL0MBhw/NBOMjdG5x4fdL8meHZ4It9XExxL?=
 =?us-ascii?Q?OJHufBDyoSiZd2ij7vcoLVZd5KOo4TFVFCOpeMxd/UmPwh8VenOWcUkKV1Fd?=
 =?us-ascii?Q?JRpa87sM0y0NO7Q444sU6pOWS1aWqXVQ316I+qKWHbgPszRYqID36dwSLReK?=
 =?us-ascii?Q?s1Bu4NYIy/KJhHj8dxf8AeIy7Ny8NhZyhfbTNhAWLQE9vAMatYWj6EofngLe?=
 =?us-ascii?Q?u96IY8SeA1ezZWSSKpVzF6Z/j2fbzsNUsETvOIsLX88QUargKVYcbd0wEz7v?=
 =?us-ascii?Q?+RNDQXIRPMNHZzWsi65UbG0JeXgE7BF8tyZxsZ1L2fYbjBmJIvKy8iqN8bVG?=
 =?us-ascii?Q?7WSq+VYNo7JXEcyIMsMHHRa8ZYk+b0PsioomkjUkDehQ2qLPaK9Acnaoe0UF?=
 =?us-ascii?Q?lLJ5G1qAE5ftzLC4S2nV2E45t1RJcni7D7nrcfbwwm0X8ZwB2oxEB0j1qYWA?=
 =?us-ascii?Q?lcSepsGLyN/LXHAlDkJZU9x0nQR6uVLnyB3YRKYOq9PARSIKsxA8csbn9ZoS?=
 =?us-ascii?Q?iCxgvsqv5q5GKTf1ynLDFsVpp6yzjC2Bwp6idT2XALdZ6KCHA15ZieUYpUHk?=
 =?us-ascii?Q?aDe/LUplLf4ubgOwCrXv9dtvViT465F95DysTFNnqHfnNzD7iYS8Dedwaw54?=
 =?us-ascii?Q?BDqp9aQIZboDHTszD1WkRvrhRrmSYVumTjT9XgCPply7RexHhIw/chi3oKor?=
 =?us-ascii?Q?nhMVXRk9fKutw8njvjzC1lqaXBcvLVfZoHD00Gt5G0phhML0emsKj0ONzTFj?=
 =?us-ascii?Q?IhXr/UXNRCmBjMf4XjsDlp8KEWLQK89nM2VwuKAbl/o9TXB6ovrRrjk/kdiF?=
 =?us-ascii?Q?JKmbYREPlSS2RCWYTcL1RjxdOyrmSTjZT3EJi491NeDPxRhGdMwg5YyUN4mz?=
 =?us-ascii?Q?ePOUyVFDJjv+OePjf0d0rKpkOSpQkCW5icT8zI8l0P5NtG8kdfw8FtTydTDn?=
 =?us-ascii?Q?xShIoFbJ400fbcwYZcpC8BehBUEWc1Ot60h+PDV6qZvbx5QTAu/Lm+e0KHmf?=
 =?us-ascii?Q?sg1+mAQcPwbA6hIsraXMGOhg2pIJQzo/TMTmuKhKNKMKaRzgn07HDb2DHEV3?=
 =?us-ascii?Q?drBmPK/PUiDGZtsEVOYlo56eT/ZkXvg944kvsJqpOcjcuptRQFYyoUad5VGk?=
 =?us-ascii?Q?1XmDhh+eKYWo3zEypvmNgHosMyxBUgpy1wamwIBBp+RSMjU1Ub6Bzs41bzah?=
 =?us-ascii?Q?sTNdZa7QbumASCqs8GCPEHUEI9R0s7+lN+UvyWq5nVbgDqPLRG9kxJsAamlQ?=
 =?us-ascii?Q?ACxu5ZQDwuaZEIOXhEOQytrKz7Q0E/HlSLK+rz2LJHpy4w=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?mjZ7m49//s2ZDFqX8Ed2WCspX5wIphDvrMywhpogDIipYq7hQyX/YaAJoWh3?=
 =?us-ascii?Q?4G4R3fyiUNzBNdmqi8GMgsjAJyK2H1LO7Bm2WfwT7wMqTMVcHxpnKyP4Gh6R?=
 =?us-ascii?Q?PjJjWYqOAQLaekdZZvtft3g0jp9rmYFM9mlRXM2IrII2sR4fAXX8HcjvnNmb?=
 =?us-ascii?Q?jWGn1WgHNps34RimBI2FzIMPqhf7zSwEm5fTmnOCpmv1ve8aB/fAew4avRrO?=
 =?us-ascii?Q?fMUnOEuYTvlMhqj+4MYsfdHv4hgEyJmfTPpcXarqC0f+A2JZhW3R2ZZO57LD?=
 =?us-ascii?Q?AuMCGTHhPVViCfuZycadIn3HwLttQKInoQicLrkegkZVRwpiW3NCL7mxn7db?=
 =?us-ascii?Q?G8th25bEfZiaaAsd6a0j7cDMKTUnnBSOlBqNRlN/+E/ap44tU3Sk0C8yAT+b?=
 =?us-ascii?Q?D7d7MZIVMnTlWbtMpSiPAdBQ8HvAHIpUwdN3Jha7vwH+CGHQ6Hvred+dsqpA?=
 =?us-ascii?Q?rEagbb2wwxiqzO8VWndwM/zAyX8YlzSqSgw9gqpPzMPuDhkTi9cjQQW8OeAJ?=
 =?us-ascii?Q?08N3qRzEStlg7kyeGH5ebqGPcDXu8tq2wPvq8rEfHgdtrmmpfZQVR4pNpPBj?=
 =?us-ascii?Q?cqkIt5VJw6cR1mZ0ho7LiCKgoatkLzJWPhVKq/TYq/EwwCqApzk35HEkdEfh?=
 =?us-ascii?Q?CF8/IvpCo7Zh1X/mKEXbA6xeNuHjjjEnkRKfxIpaF4Y0+yKo+mw+cSpPBilG?=
 =?us-ascii?Q?KrIt6N+8q5qERT0Fj1Db/Kjq/r4A02egTCH/Gce6bv3ImNMXjTOsP4fSoMvs?=
 =?us-ascii?Q?O1zQtbKNNXYuF6ceiUG886yTT4fCumy8okfowOlBPyPqyjWIID3Z5LLk7bIK?=
 =?us-ascii?Q?H5ifGkYOjFFiOFEFRLwATjTr6MSKiBVD7S3s6vteHUIZK4fjgno0jUeHaC3y?=
 =?us-ascii?Q?pv6ksjtWJu/l3t5lPpSe4Z03bDy7PUQhzdRF7e3v8FhUckGNQ0+lRpwP/a1a?=
 =?us-ascii?Q?o4xRyTRxDpYBuCnzwzs+UL7N+GLvNZ6BG0YBKy7MMaf5aFnPZdd+z+f/B7NJ?=
 =?us-ascii?Q?1CRGvGgc+Etgbj1oTIGmmmiTUC2bYU0UKDj6pSBou9bEAixWpctoU7/XOrs7?=
 =?us-ascii?Q?Iyl478D9qFCARSU2svk2n3ZBjcUtFfNeD6na1emWyz8C9YtQhDDTLCHs+du/?=
 =?us-ascii?Q?uQx6AqdbCef2qMRKRCI3tSI4tH2gqX1/VBBZLH5bo/3idrn5Iqz8bTIo34vB?=
 =?us-ascii?Q?6ZZSo7AHsau88zXu4eXbybmdGxHjEkx/jlI/7npvtDDal9cExBQFLc05s3aK?=
 =?us-ascii?Q?aoLB1PP4CnQRNRFjuzkgtkIRaLVzgjOTh5r6/YHVTqZIIIdeiv7EuJbNM9AC?=
 =?us-ascii?Q?R/pGT9pqmd8MBqI6eTFWvLDT6STHqbGsrWwyBWN9c0SBNV4m1zAGzT+u6YeV?=
 =?us-ascii?Q?BEwQi30t4CyeR34i5xOodX/Glyfjm0mJ+9Kup2ScBkK2JpDdSwVxHdRrjmqp?=
 =?us-ascii?Q?lg3gp+VN4px8RQzzDuFuYkTcRqubS54fO6p/eYJH5eoxMwhn4IwR2gRD+WlR?=
 =?us-ascii?Q?Y25blXXpBOztZNEPtAMA3YJ87eoRFC3unOtFQPOo5GneiaUZaxw1WLOlWD/J?=
 =?us-ascii?Q?EXSUbnZ1ZfYP5RmImmo=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe12d1c3-7b8c-45dc-ad43-08dc7337dc3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 10:31:33.5076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9I9QebVanQdyqVhQM/d79Uw9onDRldHZB38mYXzJ9s8cAALdar4il88lZ6FbmC9rEp80PoUafQ7napIs2rfJsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR18MB5082
X-Proofpoint-ORIG-GUID: 44EVNLe3glf8jtRaMisym_i48QPPFwrU
X-Proofpoint-GUID: 44EVNLe3glf8jtRaMisym_i48QPPFwrU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_07,2024-05-10_02,2023-05-22_02



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, May 10, 2024 9:06 AM
> To: Geethasowjanya Akula <gakula@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
> Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
> Subject: [EXTERNAL] Re: [net-next PATCH v4 00/10] Introduce RVU
> representors
> ----------------------------------------------------------------------
> On Tue, 7 May 2024 22:09:11 +0530 Geetha sowjanya wrote:
> > ~# devlink port
> > pci/0002:1c:00.0/0: type eth netdev r0p1v0 flavour pcivf controller 0
> > pfnum 1 vfnum 0 external false splittable false
> > pci/0002:1c:00.0/1: type eth netdev r1p1v1 flavour pcivf controller 0
> > pfnum 1 vfnum 1 external false splittable false
> > pci/0002:1c:00.0/2: type eth netdev r2p1v2 flavour pcivf controller 0
> > pfnum 1 vfnum 2 external false splittable false
> > pci/0002:1c:00.0/3: type eth netdev r3p1v3 flavour pcivf controller 0
> > pfnum 1 vfnum 3 external false splittable false
>=20
> There are only VFs on the device? How does one install egress rules towar=
ds
> uplink?
 pci/0002:1c:00.0/0: type eth netdev r0p1v0 flavour pcivf controller 0  pfn=
um 1 vfnum 0 external false splittable false
This represent the uplink port. Will fix the flavour.=20

