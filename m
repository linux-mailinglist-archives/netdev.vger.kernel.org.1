Return-Path: <netdev+bounces-80341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8FC87E62F
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 10:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A29E1C20FF6
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 09:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148F72C694;
	Mon, 18 Mar 2024 09:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="TPoq/Cp4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7D62C690
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 09:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710755167; cv=fail; b=T87gp25wxzcRiclcQXit2IO/0eXL/eBsQTvWKdYpqyrKHjrW3QPWww5fF5eKOkhsV4ds5rRxd/KiIIjniMhYTz7salZtIvF/m9oFU8rNbpfC7a/+xeaHvVHfqGtiPzeyoq2dks9eYmkP7b983zuKHVWV0CgxYEfzJ4eaLfQEXbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710755167; c=relaxed/simple;
	bh=oAdBltMrN0cMnbfDvNeKDDLkvSfIGEaf9iKy99L6tvU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iqrwMHWg7jRTDjj4O11LgkbTBjnkcePaMam0JadK0xMFPrjGhShvbXzq/uaTzp5jc7akggEPeM9LuHm7cNES4a5TtkoZGkyZwYaT3vACb8Cf9CbNahu3T/syjW4HX6H8iSfAo8Vdo183nzaksUVSxoxgB5Ya6bvDGnntbe5rjEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=TPoq/Cp4; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42HLdm29010148;
	Mon, 18 Mar 2024 02:45:52 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wwaxgc87g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 02:45:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGNd+HVW37ead19vSy0CoxGVG29zDBC/VlXcNqh2CxtFI9xjq7ulHLkWa0j9BaXv9PxTPnZfDjM1TCs/fukaASs27E/al4SSyrhx2sxuU2Lf6rSy3PoBfmTTr3GoQBNoxSASZPWR/kJKUGXJieVWNYZtTZHBRx8xUCSFLnwmkyp7wI9dU7+9HHkz4PTh8g9wODhOB8RXBiKZoopeuM7F+ljzdqs2lVuF1VvsWOEh83scDb4B41d9Uq3cqdmbolhgw1qQcyo2mWukdKBaB+0QKHTo6Tzn456gAHNUMrE+vO/3cK7rzGSKEgE7SfEOhqcN84gFQpw7w7kCP0DmqRrTLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wk0+Fxb2tl+Jr5wxq0LxQIIO4wqwFbBZ66JlbwfV1jE=;
 b=Ex1xulADtjiojF22iUEfcoeunwsAPpki+TlZpaD9ASZXbqiaIctnMkuX4wBKntXLg0h8/7ARFDuPqBSy/B8G333gb1GKo9QOL6ffGnA86M/mk+4qRLxc34X+3pfRYP6o+72lvEr47HLRT2xMMFAVbI7JD1unSr0hWK4IB7UsLtZTG0t9N3la/YMCX5+4Af1KUgE+TD1PsjsO7QOATXkuubexS7R1dWluOiFLymwWCZmAZUSgs+5eIvUJGJiTo0OoaT1jYu1R1xynV2bAusuBPZj5VRnHcgPaiRQ3MeuoFJvEvkG4xXh3pPQrZU2mBfy3Eox7TTyB+vhRFPqprte4Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wk0+Fxb2tl+Jr5wxq0LxQIIO4wqwFbBZ66JlbwfV1jE=;
 b=TPoq/Cp48YuMWQY5ICmvrPFqefKt5WMU/qpjipjgfX/4qri3O/1c/kY/9awXBb0or3YF90mGpRNWvnYKBLGcg0y1+vfrkfg2HoW9laswwF8wQs/VyGVBtGWn5PUWPEh55sU7S2bqR4lIJdbLwQavzbKJbMN9FyuiJu9XCNYkTkQ=
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 (2603:10b6:301:68::33) by DM8PR18MB4439.namprd18.prod.outlook.com
 (2603:10b6:8:34::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 09:43:52 +0000
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::cfab:d22:63d2:6c72]) by MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::cfab:d22:63d2:6c72%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 09:43:52 +0000
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Max Gautier <mg@max.gautier.name>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH iproute2-next v2] arpd: create
 /var/lib/arpd on first use
Thread-Topic: [EXTERNAL] Re: [PATCH iproute2-next v2] arpd: create
 /var/lib/arpd on first use
Thread-Index: AQHaeQ+DEXH4amMOoUe+d+9xZxG5A7E9LjQggAAEyQCAAAEwIIAABoEAgAAEkKA=
Date: Mon, 18 Mar 2024 09:43:52 +0000
Message-ID: 
 <MWHPR1801MB19182C5B4649293D29098689D32D2@MWHPR1801MB1918.namprd18.prod.outlook.com>
References: <20240316091026.11164-1-mg@max.gautier.name>
 <20240317090134.4219-1-mg@max.gautier.name>
 <20240318025613.GA1312561@maili.marvell.com> <Zff9ReznTN4h-Jrh@framework>
 <MWHPR1801MB1918B6880C90E045C219B9ADD32D2@MWHPR1801MB1918.namprd18.prod.outlook.com>
 <ZfgCZNjlYrj5-rJz@framework>
 <MWHPR1801MB191828A6FF7D83103C75ED6AD32D2@MWHPR1801MB1918.namprd18.prod.outlook.com>
 <ZfgI2Aow6751-EGj@framework>
In-Reply-To: <ZfgI2Aow6751-EGj@framework>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR1801MB1918:EE_|DM8PR18MB4439:EE_
x-ms-office365-filtering-correlation-id: d091b41b-1bec-41b3-1d41-08dc472febae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 QMBYUlrGNJwhA/wSysXgtue7iHHR6UIwYlBIHuaxTUOAQCMjO4taoPZl/d5W615izU+SiPJoHkc0ydWJCUNllIo5Bs+2CB8SenBn3ysruEpKWQFNZ7Vk7ytMlHY8xIo+nnwySdlgMRuIxdmNryFRbmTeMqLxFdeyAKMEbDB8mI3I1vDBCg/50Yw+RIQ4fbNDRfWvnfFbTCHPMhcCT64HtIRYPjqHfYXqIDR7rIqDagLoqVYJFs5cQEoAdYgvWYCdwVtZIQj2kXyKJBb8Mas74JeKpGXfh1hevjC/hjZPs6AIduLpwN7aPXJ46mfC0yf5xbMQkwmgzpYzHtUW/LBEFxuxu9GVw7UI0dGNyyeORsti2yaDcyvfRJHeuzFtZnIs3S02m+Fla+UGbg+EpBvvFa+OxHA/konGo+CuFZZkk0k+OFHX/NnaJJSqtLW9EAko/UFycsb0KEaAbIHg+ArevzM8vjryHYm0QA7XxpzPk/Fe/6MejlHVnMUoATd7pW7oxMQoLizob7C9d3z6sF6ZmVBht/aWnyE5u+0l7XGJCIveYTLc6I4Hsq9tchiYUWQM/y/AdpsxtcUNb7kkwBAbNe9tbaD3unqonq7m1TeVl+KNEZfJQ5c85HknuTxERGBnooCZpSl6NNbDColhrbSpLUlIkgTHBANRMLhJ/NvpI+PDx3jX/UAq5NZb6Clr9P1uZiV+yl5TDk44loDbXpM56NDVY1M3o15y6Edq+JU6noY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1801MB1918.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?got7gsGTSjgNoCOlir5TMQOYNEX+T9ASMAlfogr8RnkP8wc2fgT2ZpBs+3cO?=
 =?us-ascii?Q?97EGj7oBFk23YECCrzES081ZI6oDg2qiVNEkqWI6/+ntU6i8a0zSzREgp31+?=
 =?us-ascii?Q?CFAEBZPRgUbxbtPBh88dqwOkXxwXQXWhsWpAWckDJhrnVTw5eD63HTPECSko?=
 =?us-ascii?Q?AIIFadQto2felGV1QtQz6+aO/m1VmZpAlMcNU1+14NZpqVST0dRAOQuGXkI8?=
 =?us-ascii?Q?4LwLu5OewdPTESWSxXBc7j7SCKGJpGZimKE5Y7eJljf/swEdh4fpGh0vJBgE?=
 =?us-ascii?Q?OVuRhgUv6sqrokkdYfIQ37Dp/cPxaXvnoXhosnVq5PC/Gps3te/j4VAPnicn?=
 =?us-ascii?Q?6cAezyEAjkIvAi9cVTPZi7AdQAev6YMTOsvLAu8zwEPzDt42+yIlTs5sbPax?=
 =?us-ascii?Q?l51L3wPj6PNjPnwqi6l9v+QJYRDh8MGdHRVDrTEul9Ns8UnOYcVrBbiMHfhG?=
 =?us-ascii?Q?6VsuECNxqRorcpKEOOJ5skN1m0p1PZvlbxkv6l/NhsF5x8Ji4+V8p5+1rRvT?=
 =?us-ascii?Q?Qgkp4cU3wQ95T5hlG2Ci9KeOe/YPd4tuU1InYtswCByZQErtQUtWF9ZFPxew?=
 =?us-ascii?Q?bufICMUhQz5YsMGNFLF4tAz0EaKzg0PpbSfHL0oNnR/WZ5wR0Klsu2wB3Xfd?=
 =?us-ascii?Q?SonvM7nnAH8xIQEG9tlbi9M2IWwq9lMPVDXTzTDtDIM5IDTUyAKWKkl//KUZ?=
 =?us-ascii?Q?qQB+cpT7z6YHDVwtw06WF/fj+SfcaR6B+HbK6EqSGQUp1+HHuesKHz2F3rfj?=
 =?us-ascii?Q?WD3zNKDD7ImwloA72vcU8E5iT6kot3w+hO9tyn55wLC0l+hgV2D0llIGBwCH?=
 =?us-ascii?Q?ckHQ79Z2VQXyzHLF2HLKy7gYAsgSMbKTUZvcBUAiVbJHKlSXMSEzfykyXuWO?=
 =?us-ascii?Q?I+GZtnOglzTwrWiFyiVikWlmi7Ihihp5UOvfKim1WNIrkFF2vfLl6xLyhkES?=
 =?us-ascii?Q?xTOprTdagTuOHiQGUnerbAUW0WUNBP/7FrEcfa3clGKJurxSABvEBBBS9++5?=
 =?us-ascii?Q?WPUSMLqohceq2DHVS15kn4/Hiv/pl6cPhCSBsb2pX/BRtGwvXa13EDH5HPWi?=
 =?us-ascii?Q?W0Q+jZtFJcWJNDp8EFUQgbR0TTw8Aex4QMBngpTmQsML8QmznIErxOaf8oBf?=
 =?us-ascii?Q?KNlMqeJutDK67dMvdD2syedDPdeJfkG7EEVVG7ImLnXii0ax8RtgXZFAxtkg?=
 =?us-ascii?Q?uhnAh/h0PrmE0FdrLxP6fmE7pcU3DxV1Z3RmZtfeTuubi1zCRR5TN3aN7z/9?=
 =?us-ascii?Q?/KYnwS3t5NVSfuyV8CsBL4Q6BAhjhywlve/N6j2ZBtqDbyHDdMaJkfnMUTsD?=
 =?us-ascii?Q?Zmx39G6f7VhMXOWPfGrdVIVkH3s+Oo+o3eFqaVS0a/jy+93YcJPv2q496++m?=
 =?us-ascii?Q?4aJfjbgzwBqui3bvfxUhjemegciYJmz2y3InfJpaDeaNIrLyMsUEJtBbGRxi?=
 =?us-ascii?Q?kDajgVzS9Oh6geLPwIkwph7/f4eo752mMO7R2nIxyAJQrtrRG9EwuQ+hzCOR?=
 =?us-ascii?Q?0YCYdQ2BlAYkxmnRnOMDea5NHCt9RCDqZDxCt8HP16xRa64RwKeovRmHQ5nU?=
 =?us-ascii?Q?6t8OOyKN/EGZPk4Ljxd45stnEEugFpKJFoegKrRL?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d091b41b-1bec-41b3-1d41-08dc472febae
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 09:43:52.2643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: upp6yJYMwsI4Fa6Jde9fhrqvXH3yQ6ArgcaFenRuoe5BCFZtYL6ZnrtW10CcKTAecIIqTcoXIE7wLHyr2l3xLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR18MB4439
X-Proofpoint-GUID: U9WbxcNkZkcOSUbPp2_Qd5yc1wIMAG3N
X-Proofpoint-ORIG-GUID: U9WbxcNkZkcOSUbPp2_Qd5yc1wIMAG3N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-18_01,2023-05-22_02

> From: Max Gautier <mg@max.gautier.name>
> Sent: Monday, March 18, 2024 2:57 PM
> To: Ratheesh Kannoth <rkannoth@marvell.com>
> Cc: netdev@vger.kernel.org
> Subject: Re: [EXTERNAL] Re: [PATCH iproute2-next v2] arpd: create
> /var/lib/arpd on first use
>=20
> On Mon, Mar 18, 2024 at 09:18:59AM +0000, Ratheesh Kannoth wrote:
> > > > > > > +	if (strcmp(default_dbname, dbname) =3D=3D 0
> > > > > > > +			&& mkdir(ARPDDIR, 0755) !=3D 0
> > > > > > > +			&& errno !=3D EEXIST
> > > > > > why do you need errno !=3D EEXIST case ? mkdir() will return
> > > > > > error in this case
> > > > > as well.
> > > > >
> > > > > EEXIST is not an error in this case: if the default location
> > > > > already exist, all is good. mkdir would still return -1 in this
> > > > > case, so we need to exclude it manually.
> > > >
> > > > ACK. IMO, it would make a more readable code if you consider
> > > > splitting the
> > > "if" loop.
> > >
> > > Something like this ? I tend to pack conditions unless branching is
> > > necessary, but no problem if this form is preferred.
> > >
> > > if (strcmp(default_dbname, dbname) =3D=3D 0) {
> > >     if (mkdir(ARPDDIR, 0755) !=3D 0 && errno !=3D EEXIST) {
> > >    ...
> > >    }
> > > }
> > ACK.
> > instead of errno !=3D EXIST ,  you may consider stat() before mkdir() c=
all. Just
> my way thinking(please ignore it, if you don't like).
> > My thinking is --> you need to execute mkdir () only first time, second=
 time
> onwards, stat() call will return 0.
>=20
> That's racy: we can stat and have a non existing folder, then have anothe=
r arpd
> instance (or anything else, really) create the directory, and we would hi=
t EEXIST
> anyway when we call mkdir.
ACK.=20

> Also, that needs two syscalls instead of one.
>=20
> --
> Max Gautier

