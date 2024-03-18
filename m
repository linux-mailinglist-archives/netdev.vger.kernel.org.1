Return-Path: <netdev+bounces-80322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7CE87E589
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 10:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A6B9B20DBF
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 09:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E49A2C185;
	Mon, 18 Mar 2024 09:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="mRuEFmW8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE0828DCA
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753553; cv=fail; b=qR3fagCx+MIdgnTznJXR4b5gLdO54TuqyuYce4hpJgjWoDfDT5rkG+a9A9PEeR4eJ0sLiEQ3HywuyCETQzaGVsL52fVF6bK5DeEdHWdtvnz3CxJteAdr//IzhECfLalAOWVtUrSxrO0GLKe8w+6nzaBSQdUelulxyal/iPPbrQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753553; c=relaxed/simple;
	bh=Jvz1jGCd4or6d07A6yd2fnKLgTJr4716QcuOTkxOw7Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SqZsVdQyqmqj9NgmtTxSdIpZ7THL00az+7Ot4OdNGDQwVLD1yoqJhETNqrqgWpVKNrVu3dq7dZ4j4Ad349GWPLiLOs0ehOsAmGOUv4oQqz3hO02kKAx4i6LrkHsHVsINFLjKiYt3CGMjLIyilrZTTKJ7umAhrGFYDvvKrA2qUfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=mRuEFmW8; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42HMo28l006638;
	Mon, 18 Mar 2024 02:19:05 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ww8skmh0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 02:19:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+4bhDi1wDQZGl8QNu5p0/v21WNOuSFAMMostvlY10XInCRln+l467Wo3w8SMqfhWJGFAPZEKK/kpu+nz+u+0wNSyMiHrWIGinRkOcL34D5lGE5i8nUZJVUccWK5Zx61Q6wnjGW+gZlB7HFrZMnFlIDNpWWu7g5xRQWU+5M4RRzW6t9uBKJmw0JxTZbdWHYPqbZUtdVdLOvkjyFM78lODXXj8XCBl+Wpvjo8Bc2+DEoiOkLPusbmVsOUhU5ZipLHtG0CHn7c7a8u9mRdGCYukqs1eKlE1vJZrSoDptT9/O3292rLSdfzOyxWzlJf8jEJf78acn6nPLVzIvyEQDQpog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5veS6gZnJp2n0mCWBM+b8v5lxm2av9QZavaZ3lLLh28=;
 b=DAiLnAYrKAEpzhN6mUL2wSqyCXiiRahohGhgeDV8FQolG1kAPd7m9O4eb0t5/+7JQRMnV66dsNXj9S6Y2dXJ9qTtCDXGpIr0DqRBJasuS3SFkMKE3KPYOBfGUrE4QMTT7ZtOdtMbLooyMfeLfmD8pOksCocl8r+EO8MACVeWbYzEkNFekji/SEqw95n12F3moCiV6gmcvJ2e7TDyJBh97X7cFDTSa0JXzKBvfMRWv1XwaMYWEZkEySAVRoZF9QR0Y/Q4VvKYDLP/rXZEPBR7u0lYGpILReMry4g0tZFttz/w1huP9uXbB2Gu7OXqhfFPj5oPlCliKJ8Q0xDldFJH+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5veS6gZnJp2n0mCWBM+b8v5lxm2av9QZavaZ3lLLh28=;
 b=mRuEFmW8bS/nt5VTzntcNMuBB3VW5GYPp78QvzwxgU/WzUSXh5njyuI9+60nfAo5ls4cOUae9VCpGUWpNuuGpmkQyYf34hw2CZjL42xVld4ZlBh/bnmViLf5bW+qtZe3wm2rwFhR46CtGTLB/rbm1H7rEVQ+/rKATvJnKEhpxJg=
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 (2603:10b6:301:68::33) by BY1PR18MB6090.namprd18.prod.outlook.com
 (2603:10b6:a03:4ac::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 09:19:00 +0000
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::cfab:d22:63d2:6c72]) by MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::cfab:d22:63d2:6c72%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 09:18:59 +0000
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Max Gautier <mg@max.gautier.name>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH iproute2-next v2] arpd: create
 /var/lib/arpd on first use
Thread-Topic: [EXTERNAL] Re: [PATCH iproute2-next v2] arpd: create
 /var/lib/arpd on first use
Thread-Index: AQHaeQ+DEXH4amMOoUe+d+9xZxG5A7E9LjQggAAEyQCAAAEwIA==
Date: Mon, 18 Mar 2024 09:18:59 +0000
Message-ID: 
 <MWHPR1801MB191828A6FF7D83103C75ED6AD32D2@MWHPR1801MB1918.namprd18.prod.outlook.com>
References: <20240316091026.11164-1-mg@max.gautier.name>
 <20240317090134.4219-1-mg@max.gautier.name>
 <20240318025613.GA1312561@maili.marvell.com> <Zff9ReznTN4h-Jrh@framework>
 <MWHPR1801MB1918B6880C90E045C219B9ADD32D2@MWHPR1801MB1918.namprd18.prod.outlook.com>
 <ZfgCZNjlYrj5-rJz@framework>
In-Reply-To: <ZfgCZNjlYrj5-rJz@framework>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR1801MB1918:EE_|BY1PR18MB6090:EE_
x-ms-office365-filtering-correlation-id: d22433fc-849a-4f99-ab10-08dc472c722f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 AA3sRaf0VOPI2kfeozzuEOO2BghzzSHrP2HKHLTyeihlC1aaZV3PVCdVypzmPKvDqmR3swmgaC0GcGw8JmDcECkTW2Knen5qbAUo2p2lGXCNBAkJnSKsXkiCtNJi7ncghD3/q+U0QpP5eTMblKfdM1iA6qQcZyFP6xt4Tf3nL5RuOtfLXd8nK0e5hHDh4zrmlibq8TmME6mJnBJ/tDydPZ27zzibaQt1TG4NU1JoB5OSXGLRwNMwobVCoQCc6puba6cpqxOjXDDaZ6ZGowYFiXha2SaVpoxhYFp5K/mt1Q/c+QbpM1GPMdC50IU42YkCQIWPKUlJehWRF92F9QeoCsSAqgi6B0alFXchcO6tQGpJyYywpguKhaNupC9TGKv9NqX0T4jmFBXMpJDwKgyk/INZJbP5r2gVTaQq42ncELWo6q9DpVJdRXI1gVGnPXfC7M+iNT/e3/QE+qtkOLK6IAoVZLHbc8ObgisnG0nlmTBcDJUy+9TIgSkUrFq6cd5PYdrAmhyRZgiWzGGln6vdYvtjLoQKPYC+qXSI/CQrPuQgLwMRSRhR9TGP9kgXzANfhO13UEfNIHlNb9GViuM8iTyLKv7DRjYVT6QOD/Jld3TULaCdCFw68JzWKqeLq8jy8i8V2/DZds+PUflVJywJWaDP876uIBXhDPT3yanUtgqDB/Rxuqs2mIU/XdkpimeKG0iJoDDU9vQ/WFkhKG22Tk0Wr+tzczW+UWy70dCGizY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1801MB1918.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?GaTcm1LY68CqVup0vpRFExI84TE77c5czJ0lZ9gJU/lXjKM47VYb/FLnx8UJ?=
 =?us-ascii?Q?EI1OQP0TvUKPnjxBttThCNN8XoxMNzTXgD0qoRxsJ9/El08KaWtkW7OJ3URD?=
 =?us-ascii?Q?vzj6oTP41QT2TT+qU6h+VoWuEQHDkSdRM1AXDJKne9FlkgqPaYRAZ4BH/TMP?=
 =?us-ascii?Q?ezV+wEEKk3K1a2KFmkwB93r1K50iwh5OUawd1JifO7+0a33mK9VujRmBagdd?=
 =?us-ascii?Q?/6sONRk1zzwigr2EHJOhFC/FHe0bCjAfa0ohcatjRWzRzNTBCvFlSEliZOFJ?=
 =?us-ascii?Q?GQuiMhxwNwW84yb/9mkdRk6LPps1ZkY6j3VkF7VvOQYyzdz2X9NBjbirm0zP?=
 =?us-ascii?Q?WjSBbexYDw1mOYE+o0RgtEDXvO31HtfBLsqZ59D3+eb9IlPkggOVmMYma8vY?=
 =?us-ascii?Q?FHuZIHYPDj50Uyii9ifM5G8ZRC+2ueG+8pnP1fuAKX6mWAZHZcyevXgXGYbh?=
 =?us-ascii?Q?2vboSlrGaZJlVilaxZ5Gxt12vZRPELKlo/1eIpdIgJW89Wi1Nvka62g8TIqS?=
 =?us-ascii?Q?/4GTMwahxDAOw4zz6CmNTpv7HXrBGF0cLDkehODnvBLfhTuUwrIb3esKfLzn?=
 =?us-ascii?Q?xpt0skOw72S7bzvDH0WBL7DpPc/E9jMVmjvyut/BggxaAcqp8bvTHlPmY5St?=
 =?us-ascii?Q?JpxmUmpz6a9Z7bvJmwDtcTUx65uvXoHpgB8t616AZZLV0bhalTaJhTf9gDrk?=
 =?us-ascii?Q?vogGn8MP9Y2euWatgUdjBIBvA2stKjedARO0g2bjDOsar754NxLoLhXkeLaO?=
 =?us-ascii?Q?vDNrJuVjx4xLi7s74S2ZW8Oih6zqLrgUQDU6rioPMQZAFotGPhHeaO/xjMqi?=
 =?us-ascii?Q?b//Ww+BtpD4JScwzhSyhZO7xBYkSp4dWAZOxvcuklCW217aVgwnrVY/b3ob2?=
 =?us-ascii?Q?t4T9QaWaQF6hvnRJyzyWmbCKmAimZA9Cvbx4nm4jYfxOFECiVyFfzS+PUCcY?=
 =?us-ascii?Q?zNWJiMIRcNtqFXyNaymBd0DqgFJJFGFhnYVXdeYd44LhrnIgRhwv7lqF+Ebs?=
 =?us-ascii?Q?INhu735UZ7PUwT/Wo2M95fl4K4fhkiSg79opNkR7dopWJOCFY6VDH8WbX3LD?=
 =?us-ascii?Q?bm30veKiOD9CWwN8aVRIbDWm/EwOHJ25LSAyz2GXEBcVVm4RPY4VI9HGMTpT?=
 =?us-ascii?Q?bKcSMLfFhsLEq8QqqhgN6kF/EwTEVpxZwJzjxOhb9LE2k5bRFUH5Q9oAm0op?=
 =?us-ascii?Q?s34l1RBIzXaO4Ex8OezBNIflHNm75TRXvjLGAgFHLKLv5Cz7ApUUii70qh8v?=
 =?us-ascii?Q?bp8EWL4plJ4OrYBu2avjp0Cx69cJ4jbVZjfxGsS6dp5UhtDubuG9ShrsDCkv?=
 =?us-ascii?Q?skXiLe0aWoj/zEDtGATohERTcuWMHHJaVDpuqE3h4BeYFgvCr5V5MzAMK+cj?=
 =?us-ascii?Q?xdKC1KonJCj/JF/f9BCZWmSCom3Ux4u64FF9kRxcvdJyNXTHY1XHdIfPajUH?=
 =?us-ascii?Q?bP4kW09sntpEXzME69u8pwghPzFsa9j45VxjDu7nFl8eHQkV7FGgdi/GLf9K?=
 =?us-ascii?Q?QeiZvGYeWgkWF4loYPYK51o3KZK9h9Y8Va0+/gsfJiQlG4VSitKb16Bg8K+U?=
 =?us-ascii?Q?XcZhUuXZ2AmS1OvVnH3kEA6TZ9YT0zVk/kAEzyDQ?=
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
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1801MB1918.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d22433fc-849a-4f99-ab10-08dc472c722f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 09:18:59.9304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kj0Obpwlh4QZILPf2wBzECBrD0FXmoK/mIJK29mgwjwvfW6r50TybDGDzonjuQ/veBu3Wg2DOvSTKSb07X90ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB6090
X-Proofpoint-ORIG-GUID: Xww5zdCJvAWAYCHShBXDpSyN6tfjY8Ty
X-Proofpoint-GUID: Xww5zdCJvAWAYCHShBXDpSyN6tfjY8Ty
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-18_01,2023-05-22_02

> From: Max Gautier <mg@max.gautier.name>
> Sent: Monday, March 18, 2024 2:29 PM
> To: Ratheesh Kannoth <rkannoth@marvell.com>
> Cc: netdev@vger.kernel.org
> Subject: Re: [EXTERNAL] Re: [PATCH iproute2-next v2] arpd: create
> /var/lib/arpd on first use
>=20
> On Mon, Mar 18, 2024 at 08:51:40AM +0000, Ratheesh Kannoth wrote:
> > > From: Max Gautier <mg@max.gautier.name>
> > > Sent: Monday, March 18, 2024 2:07 PM
> > > To: Ratheesh Kannoth <rkannoth@marvell.com>
> > > Cc: netdev@vger.kernel.org
> > > Subject: [EXTERNAL] Re: [PATCH iproute2-next v2] arpd: create
> > > /var/lib/arpd on first use
> >
> > > > > +	if (strcmp(default_dbname, dbname) =3D=3D 0
> > > > > +			&& mkdir(ARPDDIR, 0755) !=3D 0
> > > > > +			&& errno !=3D EEXIST
> > > > why do you need errno !=3D EEXIST case ? mkdir() will return error
> > > > in this case
> > > as well.
> > >
> > > EEXIST is not an error in this case: if the default location already
> > > exist, all is good. mkdir would still return -1 in this case, so we
> > > need to exclude it manually.
> >
> > ACK. IMO, it would make a more readable code if you consider splitting =
the
> "if" loop.
>=20
> Something like this ? I tend to pack conditions unless branching is neces=
sary,
> but no problem if this form is preferred.
>=20
> if (strcmp(default_dbname, dbname) =3D=3D 0) {
>     if (mkdir(ARPDDIR, 0755) !=3D 0 && errno !=3D EEXIST) {
>    ...
>    }
> }
ACK.  =20
instead of errno !=3D EXIST ,  you may consider stat() before mkdir() call.=
 Just my way thinking(please ignore it, if you don't like).=20
My thinking is --> you need to execute mkdir () only first time, second tim=
e onwards, stat() call will return 0.



