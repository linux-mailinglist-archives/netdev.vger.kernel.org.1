Return-Path: <netdev+bounces-106107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CB0914DDA
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 15:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F947B229F6
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5E913D50E;
	Mon, 24 Jun 2024 13:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="hZbOtX4y"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B73C13A3F4;
	Mon, 24 Jun 2024 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234240; cv=fail; b=RakwlRWQ/ZznUkzAldIVOv5gy2XotFOR68t+DCeF9n60qtmynWV5K1vJ9RXX6jAg7i3sd2QBF+we8vpcgVAGK4HvDP0kMEnWmgP7qzu18bJZOWzqUgzVkJf3p3BJv/Cef4mlGWBMKvGCwwUoJ/M1EoKDJuTIxgNeaj4SAVbjPPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234240; c=relaxed/simple;
	bh=lwyS2M1c33vlRmMkoSyMMIujdxkqYSPP4AW45TAFstY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r3VvuWv5tc99haH+DpPfqc+/tYf3Ioq/KBUrxQ7GAnK3oc79tMmO4pMfxogNmVioVZebNThPj/gdz18LZ9rl6/ZrWyYh6N+xl1w9mlMu2XYrPwfJhHGlnWkXPev4EyU1F03N5KLYfSo4LFt85YTdJTpDINGBPQys14vf/251Xe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=hZbOtX4y; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45O8Aek8010638;
	Mon, 24 Jun 2024 06:03:28 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ywx4gct9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 06:03:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOuo3GLIcDnKho1MQQGxL39+zfDa2VZRoejOoBws0NQeywijua7jQllGO6SGolljI8V1ki5MrJLt0dc6g45Qthy98X9Rwgnc3TKgCf8DGJWuUAZfpV3Jn1iqKSiHc8oPvp/Mu5SiNNyx+P+pg0/EMHYWmpxzQ9ARp/yuseRZuzgQSqZN/YOgm9RykEOdHibmBe6MEKk3VBwLd+wpmU2UY4nSJV+750jxhxpZhAiqsTJshcMS9cCeBzBaTPrI96a9O4ur/EHrvm8jkOVsYhMzli/eB+AWESKJlxD0z761ybh+3gLmCuDO8nt2M96YojKbFGTw1G//zmdbiW/sSlE8iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OosPbmtxmTNXmOA5+nrVE0/A8FRMZSNnewoHdLfPIMc=;
 b=b9qdALLWrLqrt5z54pYw0n2yeep7qOSFcToR90lXTSnWfv70wpAftqGa66evNw1piOef90RZOIS86e+pDrYFDBMB2N85AftxhjJf4jE8vz3d1IGPAjxNqXZ/9+aFn2F8/fuo2jagaFyF4mZBVyrX7zkXrBPzBGgNw+Xs1JUSPmo33nziw9/QHXoD1zk+jnYJWfNqmr/R9KrcQg1v2MXJVvBApO0wGWKpf/G2L+StqWWvkfB+RGlUxLEhVgsdXYSpOC3tG+j19iEOPg/59OWsknS4OqLc+7aXDnTop7JRmJVmt+TiLkgQTuoxQ9RWN1aiO+XCebmrWiO7pgaKweK0Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OosPbmtxmTNXmOA5+nrVE0/A8FRMZSNnewoHdLfPIMc=;
 b=hZbOtX4yaV876Sa2DQceqT9epmEmZSA6dt/ClSCzOv8hF0knz4CwefCfRCLv1krDfE1DiAVhHMxnK3QGQrBTI+OlWBojtypN0V6L0GcaoTrEJbuFAmtHW+e+3DW1M5Ae6ttgfGWp8VwYCcaJPmDtwmIx3m8DSRGWmzY2Az1u5oA=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by MW3PR18MB3547.namprd18.prod.outlook.com (2603:10b6:303:2e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.27; Mon, 24 Jun
 2024 13:03:23 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 13:03:23 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "nbd@nbd.name" <nbd@nbd.name>,
        "lorenzo.bianconi83@gmail.com"
	<lorenzo.bianconi83@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "conor@kernel.org" <conor@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org"
	<robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "upstream@airoha.com" <upstream@airoha.com>,
        "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>,
        "benjamin.larsson@genexis.eu"
	<benjamin.larsson@genexis.eu>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>
Subject: RE: [PATCH v3 net-next 2/2] net: airoha: Introduce ethernet support
 for EN7581 SoC
Thread-Topic: [PATCH v3 net-next 2/2] net: airoha: Introduce ethernet support
 for EN7581 SoC
Thread-Index: AQHaxjbl8d7sSKYfkE2iCFYLYzqmfQ==
Date: Mon, 24 Jun 2024 13:03:23 +0000
Message-ID: 
 <BY3PR18MB4737D3B6C1CA79E3FFDCCDEBC6D42@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <cover.1719159076.git.lorenzo@kernel.org>
 <89c9c226ddb31d9ff3d31231e8f532a3e983363a.1719159076.git.lorenzo@kernel.org>
In-Reply-To: 
 <89c9c226ddb31d9ff3d31231e8f532a3e983363a.1719159076.git.lorenzo@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4737:EE_|MW3PR18MB3547:EE_
x-ms-office365-filtering-correlation-id: db97ea32-b3c1-40e5-bfd7-08dc944e07a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230037|366013|1800799021|376011|7416011|38070700015;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?EOC1nogOuuSgNuL8rid69GqzFT1ohe9AbGGE4n/0fUw9wzSiEWWgCwaXPQFo?=
 =?us-ascii?Q?yvS1Qm/qeJOdHqF/7PrFXOpqIqaYP94Ic4T4aNGq/3NIw3xsSelHU4aLNLqB?=
 =?us-ascii?Q?hYZ5SweNK4wWYklMHqRoeALNsXV45sgB3/GHc6Myr00kM8I73JEgvBFLi70d?=
 =?us-ascii?Q?blnASKeXNYWDSS77decOvqxykgIaaE+Eu1dNbrEoPeMDUj8Xaxb0RgeE17gf?=
 =?us-ascii?Q?p5th/d/OtTJHXp6Wi0BPAlgvHa8Hxkg1qw5YPfXT7Ns1Zjzq27ppdyCXha7u?=
 =?us-ascii?Q?JUSqAUNH02RV5kjnOXQJcvB0QIXZAN+lVs2S7lcAptl8XOXJI4t/jGnjDayG?=
 =?us-ascii?Q?gwgsHiqe+JYkhNtSEjUfU5y9ZWiT39BmW+8q4aVnLyHTct8kVdryhh7rvPV2?=
 =?us-ascii?Q?a/wkkeqCpC2800Zg8KdJv3Ipxo7qgbDEx7ZoxiyU3sSAHVxxsCUV3R5GqA1A?=
 =?us-ascii?Q?wEeljeVaCA5SedVguIFH7Qmb1JbdfRRmD2SmTsPr4+EDahlugkp+O8jbHxmb?=
 =?us-ascii?Q?cpDt0X4W5KH5+btSTQL+u6QVGEtiHCuuF2UlSsVrhKrzAe7z7uZzwXvtJScs?=
 =?us-ascii?Q?dMw3LkfDtBzQyI4cTXuFqTwAfWQk0AfRF4Fl3QdkrVHWwRS6mRIH21LaxGCM?=
 =?us-ascii?Q?2NUdQ638r8HF5cG4ZyHvjWG87rfJv/gmpyhC/Rtlnz0xsTOlsR4Tn40roZcE?=
 =?us-ascii?Q?7ZYQXe0CjFXFNMAGPfKJuOly/B/qZnNszc7eJ4yh16gpi7i0wLZLqZgA36a4?=
 =?us-ascii?Q?rxhfIWkeucUAhie4P6IO1SGvHN9Fg4A9pe3zy8+LR+Wy1d5i7YDCm8srVAJj?=
 =?us-ascii?Q?hVopBNlcCyhF0/50zPwZ+GvZ+8A3wLNw4ZwEpU+/Z0NCtGMCZjz8/nipsMjH?=
 =?us-ascii?Q?1j+wSGIp1Ou9emI+vdHHnV0JqWFHiSVcrSQtXQcccVcCyAop9aWuXpaVs81D?=
 =?us-ascii?Q?A0MP4f1UIG86d9B0LDzk0Of+yqwMylxfXkzUjDn/xW26dRbMu+yMJ/TvSTox?=
 =?us-ascii?Q?eXzOhYxzt2qpcY3UDheKxn6gKMNO04kDpuRZAo2VlnYVDdJTOBpRmfN6sfrg?=
 =?us-ascii?Q?FjNKlE6He2SnfREwMscV1fqZ7PBIQCS26moZP7WFvpRnybM2vqYjh7LCHtZa?=
 =?us-ascii?Q?+Uzv7WIEvaul3R4XpkpBwx+fvXX8Mnwp08vsClbpj6IQ0AMrZTco3acoj7s6?=
 =?us-ascii?Q?xZLyf8jQ+UxaMMF+lS0/fO/nS4E+WTo//RjFmGC0zRorbwQj1OdOAqqBNxNO?=
 =?us-ascii?Q?VTZ7iK+Fk62mPpHBqxwnFRH2qxWDnEkmTx3cFD0v71O7q/+y5WlHS7/Tlsnt?=
 =?us-ascii?Q?mR7pEaLeBA4zcw+Soqlqj3th2JzY8+NHGoFLmLEF+G4QeiulwA4eCbKqg+Bj?=
 =?us-ascii?Q?zIo9akA=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011)(7416011)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?auxD6uhihwF5+74EjMNzAkn0uCemp0yFn2jYsAH7BVx3IV/LVtJKGXce4D12?=
 =?us-ascii?Q?GCQjVuguxHtXHaxYu0sPKy6n6JgK4I1gJ3kxO34pw8srv+o0IhCgrr8Q4tNM?=
 =?us-ascii?Q?wMu08f0QAqF5dlUaKK3UoBPXskHqMKoDEekqsd2D8fGkez5EvSNtumcMrtVL?=
 =?us-ascii?Q?QV67E/Uh17Vv5NEraqpSvehztSghiHyv4iouuWCI3uuDng46ALc3CPWkvXS5?=
 =?us-ascii?Q?qUxfNw109R6RVwh01MyGfW6VDasInDQ4BFA4dSxMLGIUXwmi+nAJhZyWbFfl?=
 =?us-ascii?Q?4y3dJ66IQIjPYnVhhnVRIzF/OFQHe/ee90fejrTXLgGGHrDgDJKwn6dknW/E?=
 =?us-ascii?Q?6sh81lrj18BlPx7fuxZJKFkX1eQGyK9YK1/+sxAusg3YAAe2GTIX6g5lKDOW?=
 =?us-ascii?Q?THEuDPQLUQBK4fwhDC/M4aRtJOe/w+x5tCh0qZLVC3MAixrWKcp1lpvarhSZ?=
 =?us-ascii?Q?yJVnMhD8HF6U6glFu2ipyDEjdz3qboVlmjjHsf8clqIrM/45zRaDnWHbrvrb?=
 =?us-ascii?Q?KCFz0mML2toErk5XOh3mYo/i1wZlqLOn2m9dcMH8VbIJx+IKZLrSm377pOxw?=
 =?us-ascii?Q?rz0JKJtlfF59NzpJvx9TUdPv5mCUIyNBicpGcwMy2pjiJn/AJnAQP11rrtb0?=
 =?us-ascii?Q?u8NtMc6nAO+PoHuPdpHGAut0+2r2kh1ULw+nzGnFzhcfldFAuLrfsUEY6Jmb?=
 =?us-ascii?Q?pkYEo75gkuYBLQFpTa8Nvyuvh9HoCxoIuRHJmj01dy6ZE6WUNsBlmgaVJELI?=
 =?us-ascii?Q?Xn/vE28XAXUWJnvWk5+AD94H/gxLzc4Y6L/y7xGfZQHZi0UQMrgjB4uOXKnN?=
 =?us-ascii?Q?8HN6+gj8HLYNg9QDb2MxOUbHEKWqqaYjNKLEOuaU15CfP0BkcQlWBKvuNEzV?=
 =?us-ascii?Q?B9chd+8rQOeTUWF3AZmVBTzam6MHiDjt/T9Js3dkZWhr7tJdFDGf8BeXjhie?=
 =?us-ascii?Q?tDDIWAVgbJ1Nrh3bAUyQKddHkCHKl24EG+iXvoSPS91r4wP6oaINxLeJMl/z?=
 =?us-ascii?Q?0AC3C0o488ead7sBH8xk1FIWCK6qOvDzq3kgEQ1YhHW9OzyOcpujq+FmrZCF?=
 =?us-ascii?Q?F5NA6tQmO3m+ZPFjntCx8+HOzmW8JsZ2q1EwHa8NB3dQ+HR76UKE0gBli3e9?=
 =?us-ascii?Q?edzgK+vm18yI6Xbk3vj1yp66x+E7ll6ptPURGqHJ5L57b6Nhi3+kIlcipFmI?=
 =?us-ascii?Q?GXRevP5V1DZmWtTsAWh9/Tnne0/p+yIdtYKhqIXLgt9QjKcODQk7GFiGdLEf?=
 =?us-ascii?Q?dZlVBV0k/+a0EH1VfO1ojWFqqJRAqm2M08YhU5yLliINUCNQRBpRlj97Euwo?=
 =?us-ascii?Q?GhKiUY8yQlDHxcbX84pVktYroni/zqLpS/0CXkyFVQqXI8MaX7vXuxkKpwN8?=
 =?us-ascii?Q?TmdveFh+PmcHfVymm4y1aGdDWVeNmIFHonxp/VbWIdAkqdsiJS1TKYDjI1PV?=
 =?us-ascii?Q?covrDt8upQo0pd0HoNiaS9Luyhdy2ytwghwwyQ/u/wtVntiU5t8SKcme5B5E?=
 =?us-ascii?Q?kC/kIqR2Tep8t8aUz2DXsFY/tce0O7IuymgUOSCoQD4s9zZvIphOJI+hJzRP?=
 =?us-ascii?Q?xfH5HOiPXysCjqPpXbf2p0ZhlDdwoWDokKSpFbhl?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4737.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db97ea32-b3c1-40e5-bfd7-08dc944e07a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 13:03:23.6338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jnrZKTEt6J6eHm58SmelnSuwGm68MbJQffoB39m28UEN1xnH6bGUuRN3NqB8Hfg6lK/2CERBxi4Y8MdFNm/PcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3547
X-Proofpoint-GUID: AtMF61kJ5nDsg7oU-wye55oQZnWLDlT7
X-Proofpoint-ORIG-GUID: AtMF61kJ5nDsg7oU-wye55oQZnWLDlT7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_09,2024-06-24_01,2024-05-17_01

>Add airoha_eth driver in order to introduce ethernet support for
>Airoha EN7581 SoC available on EN7581 development board (en7581-evb).
>en7581-evb networking architecture is composed by airoha_eth as mac
>controller (cpu port) and a mt7530 dsa based switch.
>EN7581 mac controller is mainly composed by Frame Engine (FE) and
>QoS-DMA (QDMA) modules. FE is used for traffic offloading (just basic
>functionalities are supported now) while QDMA is used for DMA operation
>and QOS functionalities between mac layer and the dsa switch (hw QoS is
>not available yet and it will be added in the future).
>Currently only hw lan features are available, hw wan will be added with
>subsequent patches.
>
>Tested-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
>Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>---
>
>+
>+static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
>+{
......................
>+		skb->ip_summed =3D CHECKSUM_UNNECESSARY;

Unconditionally setting UNNECESSARY for all pkts.
Does HW reports csum errors ?

Thanks,
Sunil.


