Return-Path: <netdev+bounces-80316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B229D87E53E
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 09:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1A541C20D5B
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 08:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E9828DA6;
	Mon, 18 Mar 2024 08:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="RafZYsj8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38D424A12
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 08:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710751909; cv=fail; b=ehHg2fp1qc1dvqXmYNPnGiLbkNatTOWPl3l6wNup7GgG+ilddwKD1+Bn3crc6F2hgtKZPAZQ+Pp3CJPKCii08IBB4PnT+uXp+NTkqTNuvoxSYVSEEXF7v37oC2ZyW1yeYU+aW77djcQZL08EqU7qkmMtg8LhLPUjDeBKsZnmcCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710751909; c=relaxed/simple;
	bh=6DDt+TdpxLbgyR2TBdghS/+CCBrCyL8mlyoU7O3VO0M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G2vYkV2Ocqf8nOd7TfmbvE/3qAlSMHj4G6dJpndqDY0A3uM3rNAUp3wLedsHRe6hRnsMFfb5JwxELLTKXiO1lzA+ehlnMHwBXNDbWBUTan04N2NonpW5zqS1g9/+VX2CKzOYsa2AmfZS8EZFXPC1JQpwWizgu8lH7EQAxw3SBEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=RafZYsj8; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42HMwHvN011594;
	Mon, 18 Mar 2024 01:51:43 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wwaxgc3jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 01:51:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPUBHmche1NFhq8sJKm26tMcTBwUKQoomdekeBJdoOZzAZYU5dx71qVNDE/xBmBtIZyux5NSVZfx7k540XnkcH5HTsVS5RCvRhCqbbA8kjR6RnGjQKqv9qvOibD3AzDdMJZ3Spr5O+ZtR2yb+5XM60kdn0i+QwdkXdWjRiPywDShZ0TepgYhCXUbi95wd7XjlsM2MdUQ4um2Mj9oQ6bClBWr8i+kSJs1M7hfU/MUnnM9VCGC1Mz4239sntjfsGt9sLaJac5bd7WaoZ184EcYF147IgkCXOHwHe3RMnCde7I2rJ+Z9mHbQ9LOaK8/Pa8NLm/WTgH3gZZJVuaO7d81eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XLfxR/PjJunmoGRoSZNvJIhZyaG+wppsCdyTVvk9po=;
 b=aHFUpnu4XW/kKfoU0o2J7xxbkH1/RyjJ5wYMvJB4cK8NVi5TjsMNf1xpW1aAdr8oLUnF2ELziVrjK/nH4XgKrlEDUg+7qX3fjMDNTycfhUb5dfGTbwcRRQhDMtDatMsUCPUAG1USZH4SHR8ksI0Ls+jp8gc0DzQkyktR3HtiOLfgNtz1Cbm+pOlp5o2f6Y4dF2Gydi/pJ2zQ49JkVS2G9TUtnFDFVLDQjrnqyLdaZpy5ansnLBCyhCBk2iUev4ieBscTmuW3K3VTPNg5i/L8rLAwBP+SvRpFEgdvBHOHBZ2GB9zeVl8qQc4A5SchYegIGbX3zB7RXb/Wf1mc/WRHoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XLfxR/PjJunmoGRoSZNvJIhZyaG+wppsCdyTVvk9po=;
 b=RafZYsj8/z3Q4URyKZFUofd38xPPVCGzwKOvDRdNnHkmKCgGQsIdOj9W3nYC/sibx+XOssEZMwbIrXj+fyjxtIF2cV6ePFoZ8skRjlKVu6sGrmxchzjp5sAvpCLPBPlProYJJVia3fena5kCmeGpijAumEry5dWECn057Qbs89A=
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 (2603:10b6:301:68::33) by PH0PR18MB4890.namprd18.prod.outlook.com
 (2603:10b6:510:119::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 08:51:40 +0000
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::cfab:d22:63d2:6c72]) by MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::cfab:d22:63d2:6c72%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 08:51:40 +0000
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Max Gautier <mg@max.gautier.name>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH iproute2-next v2] arpd: create
 /var/lib/arpd on first use
Thread-Topic: [EXTERNAL] Re: [PATCH iproute2-next v2] arpd: create
 /var/lib/arpd on first use
Thread-Index: AQHaeQ+DEXH4amMOoUe+d+9xZxG5A7E9LjQg
Date: Mon, 18 Mar 2024 08:51:40 +0000
Message-ID: 
 <MWHPR1801MB1918B6880C90E045C219B9ADD32D2@MWHPR1801MB1918.namprd18.prod.outlook.com>
References: <20240316091026.11164-1-mg@max.gautier.name>
 <20240317090134.4219-1-mg@max.gautier.name>
 <20240318025613.GA1312561@maili.marvell.com> <Zff9ReznTN4h-Jrh@framework>
In-Reply-To: <Zff9ReznTN4h-Jrh@framework>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR1801MB1918:EE_|PH0PR18MB4890:EE_
x-ms-office365-filtering-correlation-id: 5f89ad74-cfcf-4225-4af0-08dc4728a104
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 KPMAJaKjqGEFKq7EZGpbmAb91jDxt5Z4fSaiVk5G72N7EwW7h/w7u5KrsZ9vu/dxx+Bk+EWTR1Nb9V8m3W/S7UrrPnz1pCgr3WnsuVlsAv9uOZ38aPyK81gjA/QVyRapBTzD6EZkUMzoMyQwwft7BlGTLW5yBSaG/rDVwlDS78fKl99VrvRImtcObIT4i1SLcyWFnq7pnDiHeuOQhn4qAku8+oxAnEUKHzZYnas5FVJv6V9DJJmOH/EurLtGXQ4fuHjwn6mPQx5QXAM9ddUVLQJibnwwrDzjzNFOTrTLlVkGc/WwuvhMQxis6ZrE+puXYpuuopJ6XHg4mx9PNJInVhnjnTt/YQVl0XDMlfDoxzwdRn3UXIi1IiY8TqAg+UyqxF3buAArIv1l1F8xpBh2zDAswFl5uadz7PH7e/OTbE91Vyjwe7LKnu7PrdMLCyiB88W+tvnl0Mgoww8WiYWSHmBiqDO0Z5kSSLQ/BqD0p4sA541B0Qum7oimxJig57QWzAk/J5L13oBArMZRLd0bf+5HY1hXIUFmPCf+S1dTDHyK/8bt3F9JfBtmpfPydlftiFmTHyN4zm22Fk05K0TcIp6W6B3yqazSpSP35uy0zAUMiRvDc1UdAn3+Rt0AcopVx3G7Zn8tYiwCxpSIeUmp/6XTzFy3aEQzPAzCjBqhaYhQhBMrVGSA0WSmVbWtcw9rNN7ptGvz0kat9Ty0cAutAkOtUZZMdC3lq98hCvFDAcs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1801MB1918.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?vA+BXH6m7IsOkzwh2K8H03FsOT9CvNxYlBK7uYb4kLkRu0Rp/1mLradJtdKA?=
 =?us-ascii?Q?4aVsTMYduJDb4ZM4B5384yCH2mnBKdzZwFiN98+QxJtEEoTrGZBlwGBxZWiT?=
 =?us-ascii?Q?O2m1aopdYAu+OMR5NvKF8kVZSbbZKysXDmJufseg8ng0pglrF1w3PejH0Ear?=
 =?us-ascii?Q?KA+bFoDwDJuhVbRLOlMXqKphdkp1cOu9FftLr5B8mFOy/ue5SfLf/fPL1YQ8?=
 =?us-ascii?Q?VKquWt1UvJdFmKp6FxYKTEW1uIYFtLf7FZ/JTAMmT8AQf3kahdr7VbwTD+iz?=
 =?us-ascii?Q?fsG34zodvKKYfqdV3QMI5M2BpHQnxpmjF9be/GtSwfvPn0/7NtKJAiGkzibw?=
 =?us-ascii?Q?4YzSYo5oIDraVEapj7y/ECzX3mf+AydfziyxoeXQCPFM1s+CoKBLRUtJnXIb?=
 =?us-ascii?Q?uOv82MfTKyOjQmTL5F/kNTdxXZ59f+pSKylHm9JTnzT0PCOGaLb/mVRubgk8?=
 =?us-ascii?Q?unVgwsq9lBxGCb81owS212uJxwKPQySWCwTdmyV7T563E5YgiTOxzBALICM9?=
 =?us-ascii?Q?Qlp02dX3AOY4yOh9Jkz3+Yov5pvVXK6hWZ+KcttLwqzrAskaGDoPeDRMq3cs?=
 =?us-ascii?Q?HtwAuN6MuAIyeJpS9uG7dEquR0iwh+JYP8weMA3frTcrueIXq+S23DCzaJqo?=
 =?us-ascii?Q?ksU61yKizM+ILwff2dXAVq8wL4Eb2qJ3V1BrjcubNneDkau80ybXD9u2WYGL?=
 =?us-ascii?Q?LOnGQ/8/dMsMyMVGL4kb3ZWX+vjlaklPZ6WuD99I+3eijsYRlOpw+ilJ5EZT?=
 =?us-ascii?Q?5Y11qsV7BddmwPdJkITH/9pA+NPw9QlWnvVncNjQKB1dMyEdY/7zt3Lt517T?=
 =?us-ascii?Q?lGxpbdkwhvmq6YLEpRR7hRUAyii5BhJsofKBp3R1Xv/MpFAG9Fv7cb2C5bQE?=
 =?us-ascii?Q?BvWmol2ozy1Q/gotY6r6QuGHKwg9vxU7Q0GliKn64u8VEjrIlkBeahESbCwy?=
 =?us-ascii?Q?hoXU/G/Gq2oWoPudvV96/jgSWEbqztV4hsOplrhA+geRvF6TD2UKA5cao849?=
 =?us-ascii?Q?Hkp4XlEeaOHuFhg1E6VI+gpVzHLnuNHcMgVdp00xPVJlv+YfykRSfGscyxLL?=
 =?us-ascii?Q?jwEI4sLvSOb2l3nNx0eH8qgmS8KhpaTRJu3+rrQZr/Mm/UAr+FUixddvZIHR?=
 =?us-ascii?Q?64+m+CTXVuFT0yPAPtA+jUEbVEN5OF1qQ+0+Y/NbVo0D+xbclnUkVlsMgvJB?=
 =?us-ascii?Q?6qKzeYMxWR3MpbNRiOxbEmTl3by+0YJGd/BDSYr8KFdM8c18GQo/e7viQKSt?=
 =?us-ascii?Q?ZE4AnyDu/QUWY7dXUPnXIBfrDM4kpL7tdtFB8d+Wc7UzV6Rx4eQ5xobYkePA?=
 =?us-ascii?Q?WXAVl+FJ7kGZVeRimSfJZR8LdM2jqhryZQSM1q5zQtY9OViMeWzBS/3UU+67?=
 =?us-ascii?Q?11DjpnLY4pHWySxMCU6339u/Xuv5vZzT8tEq2qlDtLmEChgx/uLEjK41zBpc?=
 =?us-ascii?Q?wnUNnanF8UJPyy1XlX5KncKiyxh49cIrMGeBVGv578HvHy34kNB31kjSJg2f?=
 =?us-ascii?Q?kUeBa/LnjjYzGVnFlmWTSRnFs41iJFmevnKvVsKqHC8K+LcS+sGipQQaVZIS?=
 =?us-ascii?Q?/zHGnS+Tj/VXk2su1oorIeEQSRcDVTeEX7Zd9Qkr?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f89ad74-cfcf-4225-4af0-08dc4728a104
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 08:51:40.5092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CEBIzs3LyUqd0ukjG+45eO9qlvf9zue0GdDSEg/Ulz/+UxHisSztQDirol6n3yyHSGpZSYDGVBMgBEKJllKCYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4890
X-Proofpoint-GUID: wFBysbiLLgAjE1jIkvhLXmitoa0k_cFV
X-Proofpoint-ORIG-GUID: wFBysbiLLgAjE1jIkvhLXmitoa0k_cFV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-18_01,2023-05-22_02

> From: Max Gautier <mg@max.gautier.name>
> Sent: Monday, March 18, 2024 2:07 PM
> To: Ratheesh Kannoth <rkannoth@marvell.com>
> Cc: netdev@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH iproute2-next v2] arpd: create /var/lib/ar=
pd
> on first use

> > > +	if (strcmp(default_dbname, dbname) =3D=3D 0
> > > +			&& mkdir(ARPDDIR, 0755) !=3D 0
> > > +			&& errno !=3D EEXIST
> > why do you need errno !=3D EEXIST case ? mkdir() will return error in t=
his case
> as well.
>=20
> EEXIST is not an error in this case: if the default location already exis=
t, all is
> good. mkdir would still return -1 in this case, so we need to exclude it
> manually.

ACK. IMO, it would make a more readable code if you consider splitting the =
"if" loop.=20


 =20
>=20
> > > +			) {
> > > +		perror("create_db_dir");
> > > +		exit(-1);
> > > +	}
> > > +
> > >  	dbase =3D dbopen(dbname, O_CREAT|O_RDWR, 0644, DB_HASH,
> NULL);
> > >  	if (dbase =3D=3D NULL) {
> > >  		perror("db_open");
> > > --
> > > 2.44.0
> > >
>=20
> --
> Max Gautier

