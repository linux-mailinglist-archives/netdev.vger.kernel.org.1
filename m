Return-Path: <netdev+bounces-100107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0B78D7E15
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991581F21A7B
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36707F481;
	Mon,  3 Jun 2024 09:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="h6n0nuX4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2099E7A140;
	Mon,  3 Jun 2024 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717405586; cv=fail; b=Ol0GdCB3DpXSHN1pqd789lWu/+J1J1EPWmLP5Rb17GZJkcSqXuwQi14/WIZydlhwbNZpH+Q5IOnsNu3se2SOd4Kxg/gtyzKXYEtQi2JvJUSciInRdeHjvijFlQUGJmmR3Tvgx4Upklv+DZbif7DjLhR0uCnRGM/14dt02yusF+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717405586; c=relaxed/simple;
	bh=S1spURpvq/SrRUfYymQH22t9HjCWO/JMFYZ8XFvI9iY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T0R9eLY2sLM9na3L+OBO9Oei2zumasJPAn7/vZa/Ugj6LXB1zY/ul+zOGWWrPzf/3B7jdCgbEMUzSyrBVMer0i7rIgZSZ+q3QkFZckL0YZTuhoNWw0TNawLbElLbDCD8DIWFZ9iGRaTvd7x4sHEtnOw3jbSLBhU7Dh/Dit/fOVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=h6n0nuX4; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 452LkQDW015935;
	Mon, 3 Jun 2024 02:06:16 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ygufmsymk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 02:06:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwAK3kTdPzYzQhhw7MFlYRwo8xwjn1sXLhfUoIiSpqh8F1uWZ5AnHNi1R8Mo/74vpjMx32PzsJ53LtF/BX7qJpjn1anMg09+PvW/YERo8FxovsT5tqXE/mc3R+0NMuPmWtM33HsJ2HsI2vysFAE3bIQTNNLPBJBKsc7lK+TJlx+73jS87xA0eFwm+qgHaCns+5wpv8wPATMzjJYQPFjcq/8y6QrGcoulppixgyXXjFtZG4NWomk2SLmecd3k1VwDFvkYt8779IO+IkBjYGa9BZQoqS0fLAD5oxky7AMDzWjlqrox/p7LYJTDepZ6zHGmLt2dK9Uy2AumPX+rHB5mYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rs0jhJFAInPk+o2aYkuzei81RhHCIz19Br0ZPqWkoA=;
 b=TBqwds5blU6Np/kv84KNveRAtUZkwtrSSyEDdz/3am+aFAi7h74bGVXWI2rv6b9+UJtcKMGhI2710qTZFz09whAZYeI04UP7mK7ga7Gt8QIaEaYlVWb2PbJSPmcW51gNacuCU7mUHsPwrwrkPUTtpNgG0pNK8muTicL2fuK0mdsyxLAski0kUlCUP4AnM1i2qmvSoodXcYLLWQlxDwmFLFnJFKiqLHL6SSRq6cKdGt6uAzGOW/JlRzfvBxIHecSDhYwQiwE35fjQpvh/7XAijvoX+SfmEZKVApOaoZAOuIsaT+1pHavxSte/Vh/369aXx3fVtw6ZAqSE8YMuweQApQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rs0jhJFAInPk+o2aYkuzei81RhHCIz19Br0ZPqWkoA=;
 b=h6n0nuX4reR/qXISWZpR6mvJG4ghuSIf7RbniJE7MztLsie9IjlBh4bCFcEO/ddj9FHjL4neMy76Cg6l/OQMo7C0WYNwU/EV0jxAl51bxW/Ue/bXPvEKe5gohZUvM/n6dvKdZWqui+BYF/utq78vxoqrhONFWlt3dViAsq7TZhg=
Received: from SN7PR18MB5314.namprd18.prod.outlook.com (2603:10b6:806:2ef::8)
 by CH3PR18MB5859.namprd18.prod.outlook.com (2603:10b6:610:1d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Mon, 3 Jun
 2024 09:06:13 +0000
Received: from SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::f808:b798:6233:add8]) by SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::f808:b798:6233:add8%6]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 09:06:13 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri
 Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam
	<hkelam@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Jerin Jacob
	<jerinj@marvell.com>, Linu Cherian <lcherian@marvell.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>
Subject: RE: [EXTERNAL] Re: [net-next,v3 6/8] cn10k-ipsec: Process inline
 ipsec transmit offload
Thread-Topic: [EXTERNAL] Re: [net-next,v3 6/8] cn10k-ipsec: Process inline
 ipsec transmit offload
Thread-Index: AQHasQaTfyi6mWkXDkOBPclCj0tdJLGyuFMAgAMP14A=
Date: Mon, 3 Jun 2024 09:06:13 +0000
Message-ID: 
 <SN7PR18MB5314C837EBC54B24350DC638E3FF2@SN7PR18MB5314.namprd18.prod.outlook.com>
References: <20240528135349.932669-1-bbhushan2@marvell.com>
 <20240528135349.932669-7-bbhushan2@marvell.com>
 <20240601101930.GB491852@kernel.org>
In-Reply-To: <20240601101930.GB491852@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR18MB5314:EE_|CH3PR18MB5859:EE_
x-ms-office365-filtering-correlation-id: 0495eb40-a67d-4db2-ba92-08dc83ac6b3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?Ah82SZ05tPX+7uYX6/H8wtIxI295UE+K5P67SlWgx5x8rUwzKc9S8G2ywcD4?=
 =?us-ascii?Q?pqrb5r3PFRG5IcjWLqa8BQ8FQevoxPuNNwtffsrHoqoc1XC9y3N727o1RBgO?=
 =?us-ascii?Q?SmWooNGDTc4ymRdvyMO3tGfIcIKEyJFcOj3SFWMDN4x3x6eddYecUFRURMhr?=
 =?us-ascii?Q?e/h61rrN+G5jonexrjYY6gnk30kZ2YUc1oOz/Bm6Q0Lm0qVK/eoxXr9QklXI?=
 =?us-ascii?Q?FFLDoclvwoMdFhgNBQ+fWfNRGW9Wtdj0ZIB5tf7bX0XejYJdr4xlFO13eCJg?=
 =?us-ascii?Q?jSobkJAb84g15hNN2DgzYDFofF5AyhuZ7eyYbwP7iU2t50T4Bx3vBApsviXV?=
 =?us-ascii?Q?dZ92VTPM6L/s3pTawmzlIa5uRmMnK4zlphhjq2zqrpIDhOWvtBJaY2B2FHDE?=
 =?us-ascii?Q?fBuiPpV1O89cKNvvxImIaOEXKz1rn2tsDnJBAhHY9q2fHDjMp5z0mahtfJ4G?=
 =?us-ascii?Q?EWPSe6UNDhPrfMcDRzOAILMh6X464PX0VDpleBtMpg8KY7tVxSy2i8uhgYbv?=
 =?us-ascii?Q?SG+yDhCqGKqJs1OA18klHQN8+tuZd1rmzUgLPRm6pXrP1gco6Jeh9V/GVwC6?=
 =?us-ascii?Q?UlSltbrlNu7VomFlCVpf7Vs3b+XTvq7N73cHkByOSUhBq31j6sM3K/hRhkUZ?=
 =?us-ascii?Q?opaPEM/powV73CDhf/lwtXwDkKPbjymGwXM2kxIJN+JUIrAdKdXhwPMip8Lm?=
 =?us-ascii?Q?SkwL9vpNG0HQdEKsHNEogXf2Sn/DPvEmJUQOjlVs3rG60DkiP9VXjGqadx7m?=
 =?us-ascii?Q?kJJLDcA2QkwGsO4+dK/6y0r5ifJ2dTILXUtzVKlNxwAjNbufhm84Tmt4UVY4?=
 =?us-ascii?Q?+PQBmG/Ln8Ayf0MdRR0w7BaoRkSo9hGGCHTl8wfJ6nCjL+0PwtSakiHUa2Ct?=
 =?us-ascii?Q?61Gii96LcCVWSpZb3zS1hQ+Go1VlEonewfR1tSaeFQw7TktFeT7Cfh2s+okw?=
 =?us-ascii?Q?Lp8epFDzrfctmtyQUslE7twFAk9XXksJxZAVonZ1GnfNh17fApMLyt1fNtXZ?=
 =?us-ascii?Q?RskdQzGoDfebJoOE5k8d9DnxSVGSXzxSk2WOTpnqGMG4UVkREi/b1BWMUKXj?=
 =?us-ascii?Q?TnV/kkZXTiJ/zma5QICMLsC8xGLEexJgfKLnDheo+7qMSzn0WDrHMZvsWRm7?=
 =?us-ascii?Q?1FZYJvSclqRrphV+rOGH0rMgcrqLNAe9KEFBum34qDd3zCs8YZMJXyt7D3om?=
 =?us-ascii?Q?gJykqDZw7W5JqVhi5yPEbUAfZKqrp+yS6YkFR05Yx0S8PMuU4/AxAk/u+eJe?=
 =?us-ascii?Q?xXOWzqtPKvNiL9JnuJEKBl7QtkFt+/dxKxdXva1HVqf9f1i8VK96yT49fgIx?=
 =?us-ascii?Q?BRNRzY+YaR1tHjpTAP8HMrEfZ6q3IKcpi0nZxobeFcKcBA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR18MB5314.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?08LZcTtI86cQALu+b/vUXX4zY3mAyqDH9agoRN2nrpwY7bnKrcMgUxvqaYIc?=
 =?us-ascii?Q?nbQvi/gZpJ6g2NQJx4HvvsnYm2oVt6jbkrupTB0LoZMg+QWF5PYrV67CZ7Vm?=
 =?us-ascii?Q?8ViRhXT5ANZaYrtBmiB6cevbyEmCyAW55lp8+SVftFoXzy1PXMmdtksmJ7Ty?=
 =?us-ascii?Q?yG7ZvbbH/T/1mqo/8ghtKsNB2EgrytVNLNZd6wSiEgoYKFxNKzydLIZX+bpB?=
 =?us-ascii?Q?weI9rLjo+RsKjGGiiol6IvxIVrTAG27ovDt/QXySnAVIlulJrG9hAco2JXHA?=
 =?us-ascii?Q?cDIfUnp3FmSbXTVczcLL2rKNZCEk6911Y1A/XRvI4oiGnE+C67F+4tILk8sg?=
 =?us-ascii?Q?EXOn2esQXi3H83C+CdV+/ySPNSIEzAtJq/2PZG/2xzhy1XSlju/EC5pkxnj/?=
 =?us-ascii?Q?lsIhjgG6IzdewfZbo8GLK+TVevdZcxEj7wWsFVytuhSCano+aD1WJ4TJM3cn?=
 =?us-ascii?Q?+65kbx4HluhiQD4cSOUsROxOic/71wvGRFFU89thhRewzo2/BU4v3y4jg4eu?=
 =?us-ascii?Q?jtZ7nUQFolk252Trvfl/+2eWNLKmEUvOzq9fb+iXXhSRor3uXLMpqJAGjbhp?=
 =?us-ascii?Q?fzhwEA0/2IHY4SpKJc0mC1UC3RhpIHTQixCGIPx/jkGlaMYgkbDLjJpxi3Cm?=
 =?us-ascii?Q?VLyfv68IbCckikt68dyE18FwySvHyO9ja0uBqV44Shvg/gQ7iS9us9aEoFvP?=
 =?us-ascii?Q?PNtIzFm16SOmioc5Qv8jWOAQ/yiYIezGaPo73owF2wr7FS9CAKs0O2MehogJ?=
 =?us-ascii?Q?Xdx2iok38N0mBjB7i+pcs4wfZ0AtcnxK01FHeACgxYw/G4JefR+y0YL5EK6E?=
 =?us-ascii?Q?JKRdFtgtjEtSG//hiFzhtj7u0YfBhZvETxenj7vJDee9mXycauv1SWtu486N?=
 =?us-ascii?Q?AD9NXsHVscMWy+M1y2pJO9fxxMShpGyltczePHGFpcjL98JuM/sTeMOUMV2d?=
 =?us-ascii?Q?5ulv/VF8pO1FYlgYfBweSZ3vZ5Jjb1UgWu2Aemxr2G4MoM9vlPFUw/MPxVmt?=
 =?us-ascii?Q?gip6nHrN8iQv2hrpxNkoCu026D1/YeyNspmEKoy/kFmzSG0+YThSFgwOuBS4?=
 =?us-ascii?Q?uqE35tF2I1m7y9C87JawpoQxssYPsyo62jpxVhvIvWgV9kqaGHEoj+E8y6vx?=
 =?us-ascii?Q?MG2PhAp1Xzmz6Vkjin1AgcWKmJyATM90ACoJLv2wFEaw8S3X8tjQc6AWkpHz?=
 =?us-ascii?Q?jhPJgm9NSL6wGQuTZa83OmXLEuTO28lNLqCdiZQJqFiV5NpnBQmD56IPps60?=
 =?us-ascii?Q?XOPtjbEmhCK9QK2FTUnssRz9Z2KrVaFAf5CG7HekxdjVLA+CO+pdsITWTO/M?=
 =?us-ascii?Q?dkL6xOMOZKg9IZ/qDIn6JBggkrxYuN4IMUcdV5z+Xy5nKo5byGx1jAjJGlFV?=
 =?us-ascii?Q?z2JYNendSj1/2GlzUJOfwxnUC5beO1IDLVe4Y6O/EPIPmVR6SFnqWA34R/g4?=
 =?us-ascii?Q?O3PjF/JHdNpApPukaP01dFIcZb5Vb68Fbk1I2EdaHUA4ZJ9N8niZMaQiN0OG?=
 =?us-ascii?Q?AvBHq+2x+7Jdsd8Mw8+CASQnUI2/s2wWB7uGqoQbJrczpBUHnF5qzO7zfkBi?=
 =?us-ascii?Q?DJ3S7SZKiS4icFHq0eirNwetmxVLHpTPvuaBqbdK?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN7PR18MB5314.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0495eb40-a67d-4db2-ba92-08dc83ac6b3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 09:06:13.6427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PnXC5l6op3nG+RzX2Jim6c02jeAsKdImxk/CXXPoXpEqTyka3QOtkzI/n1y7TuaYMO128e5JuMuxLO4h0QeX1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5859
X-Proofpoint-ORIG-GUID: uZYKiq0BANrirF2A9dCKnEoRnbabKiWD
X-Proofpoint-GUID: uZYKiq0BANrirF2A9dCKnEoRnbabKiWD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_05,2024-05-30_01,2024-05-17_01



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Saturday, June 1, 2024 3:50 PM
> To: Bharat Bhushan <bbhushan2@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Sunil Kovvuri
> Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
> <gakula@marvell.com>; Subbaraya Sundeep Bhatta <sbhatta@marvell.com>;
> Hariprasad Kelam <hkelam@marvell.com>; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Jerin Jacob
> <jerinj@marvell.com>; Linu Cherian <lcherian@marvell.com>;
> richardcochran@gmail.com
> Subject: [EXTERNAL] Re: [net-next,v3 6/8] cn10k-ipsec: Process inline ips=
ec
> transmit offload
>=20
>=20
> ----------------------------------------------------------------------
> On Tue, May 28, 2024 at 07:23:47PM +0530, Bharat Bhushan wrote:
> > Prepare and submit crypto hardware (CPT) instruction for outbound
> > inline ipsec crypto mode offload. The CPT instruction have
> > authentication offset, IV offset and encapsulation offset in input
> > packet. Also provide SA context pointer which have details about algo,
> > keys, salt etc. Crypto hardware encrypt, authenticate and provide the
> > ESP packet to networking hardware.
> >
> > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
>=20
> Hi Bharat,
>=20
> A minor nit from my side as it looks like there will be a v4 anyway.
>=20
> ...
>=20
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
> > b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
>=20
> ...
>=20
> > +bool cn10k_ipsec_transmit(struct otx2_nic *pf, struct netdev_queue *tx=
q,
> > +			  struct otx2_snd_queue *sq, struct sk_buff *skb,
> > +			  int num_segs, int size)
> > +{
>=20
> ...
>=20
> > +	/* Check for valid SA context */
> > +	sa_info =3D (struct cpt_ctx_info_s *)x->xso.offload_handle;
> > +	if (!sa_info || !sa_info->sa_iova) {
> > +		netdev_err(pf->netdev, "Invalid SA conext\n");
>=20
> nit: context
>=20
>      checkpatch.pl --codespell is your friend.

Will fix here and run this on all patches.

Thanks
-Bharat

>=20
> > +		goto drop;
> > +	}
>=20
> ...

