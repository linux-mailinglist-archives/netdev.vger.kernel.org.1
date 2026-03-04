Return-Path: <netdev+bounces-263945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJotGS5tqGn9uQAAu9opvQ
	(envelope-from <netdev+bounces-263945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 18:34:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED936205340
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 18:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D7A030C087D
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 17:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF7E1DE4EF;
	Wed,  4 Mar 2026 17:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="fVq/d10G"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9313B5842
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 17:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772645328; cv=fail; b=RxXN44w3hit8mAutOK57I40PkSOKDcU9BdgeTuauZ+hudIuBaWDnEAi2ITzVNdlVfSgy3chaMV8EtdscSyk4wjCBRMWPqayAqW/i470Tpy1XBKlBJLoQ/WMZInrJcYpYKS5doP3HzA8CYo0Tol+VUkXODfq9zmjHJ3ousEB43Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772645328; c=relaxed/simple;
	bh=o47JUVTkuLMYtih1UGhRNlljqZqC5H5maqspk69tq/E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=NsLEJhIWrenpSYexjYFmGT0NrMHxXfMauZjxCaTRi1j2au+m7wxkbyBKk8GSKzGKWVERkznuMmUNwBGLLfV5z09JF+JfP++SuKPBh+c0g5anA3Nb/bSSvuYQGmN5tLh1UuNmY955YCcQeBRtW9G/YFPqEbNYGuqv6+As9Xd4uyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=fVq/d10G; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 624H6BkI1719820
	for <netdev@vger.kernel.org>; Wed, 4 Mar 2026 09:28:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=trMf0tZ4WBg+DIpDRCtvjeh34LSSdK+Piakg7AH0wqo=; b=fVq/d10GnrxO
	L1kBPiiirqTloydSmwmzJbOsH8r74y+bf/1LXZgy6m011wTvRO9caqc30oNjNMc7
	sdDEZkLwX+E3cHDdYYtv1q2Q1dMlVeF8D5Y7dSQcP1xODLotzx29UfJyoWbvHZoj
	7miHZDGMdYoV3wE+cy3dfsJmbIsm4K1p97IrWdTyRCiOd+D+xo+Um3bKznNHMMRa
	8Jb4K0lktcsb1AEizv7hSc23FXJuhdT3Y8IHMkgs6ncrHdz92apWW+ZO5eX8gFnv
	VMkCvkbrggdr/VSmmFIIrb9lVVWy/J2wcapAOyk7Rrk7Nz1WQ3GHHiB+N1MohuW/
	BRCPgo/mhQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010021.outbound.protection.outlook.com [52.101.56.21])
	by m0001303.ppops.net (PPS) with ESMTPS id 4cpr6urwbu-4
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 09:28:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWOwgbEhFF4RC+wWHLkNlDia15npnIg3FPrMhlq5S5a28vlGCGNnVZ1RY+SLrMLH4o8I9YTk3zXM8WIU4RtYiGiol1qpUMVGSwU9M+PF5jM4WBuB0T/Cg/SkruVzvNmbqdN5bEpFT21AnHRjFI5dkLT70BqQxMYb+jvet0ZMDWZyAwuqt4Md+lZssJrRQtu0ip4TxOrWsTuWJBuDG5f0cJjaS6gvfI52o7s4TIc4wo10W8VfklUM/VBqb8roSb3iZDpC98v41svVm7PEXClJqs3S5rIh6aXHsG51lLleYOONv85yuUdg5fkWa7Wgkqr8N/TTiwoB/a448mpY8fLBbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eljm4SRiAEo0DoZx6MnEsT/3K4+ArBkHvqPoZKRxtfs=;
 b=pf22NQN1bDhBx0W3vnsusl5weaZfCKp0m1BBNsb/LE2+PGRcVIU289oV3jQ4mXxH9Tum5ex4Plr8mMTLzekZPNldl2HNVIltOj03/IaSTvhm2as5/5RzQraEs4/rhEjJHw/dYHjSnSkZrQIxE4vpuF9L7y5TZQUV3y6fslcBeSLejqSz/M90EJWjxlPMXNpWo5Zvf1utr1XeboZPXf50nF8t9Irg8SQoPNIDDups0FHxexoIZKoXfB8pqJbywXaCkilzpnMZ0LL3pK3dD+hWqqIq/uzbQxv0Mo9ocKGJCbTdnKgTeytGXdK3UYWN6oLvPGRoxvnZbcYdhoO7Zp5oJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5817.namprd15.prod.outlook.com (2603:10b6:806:33a::11)
 by DS4PR15MB6912.namprd15.prod.outlook.com (2603:10b6:8:322::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 17:28:39 +0000
Received: from SA1PR15MB5817.namprd15.prod.outlook.com
 ([fe80::5aee:c356:70f0:66c2]) by SA1PR15MB5817.namprd15.prod.outlook.com
 ([fe80::5aee:c356:70f0:66c2%6]) with mapi id 15.20.9632.015; Wed, 4 Mar 2026
 17:28:39 +0000
From: Wei Wang <weibunny@meta.com>
To: "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David
 Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 net-next 6/9] psp: Add new netlink cmd for dev-assoc
 and dev-disassoc
Thread-Topic: [PATCH v2 net-next 6/9] psp: Add new netlink cmd for dev-assoc
 and dev-disassoc
Thread-Index: AQHcq2vkvUbGdmGllU+4dolkuGUwQbWejfOAgAATMmQ=
Date: Wed, 4 Mar 2026 17:28:39 +0000
Message-ID:
 <SA1PR15MB5817E58022591D21EC96621DBD7CA@SA1PR15MB5817.namprd15.prod.outlook.com>
References: <20260304000050.3366381-1-weibunny@fb.com>
 <20260304000050.3366381-7-weibunny@fb.com>
 <316b1fdd-f495-4a12-acd8-669ba5f2bf26@gmail.com>
In-Reply-To: <316b1fdd-f495-4a12-acd8-669ba5f2bf26@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5817:EE_|DS4PR15MB6912:EE_
x-ms-office365-filtering-correlation-id: 4a589a07-164b-41d3-013d-08de7a13795b
x-ld-processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 cXWYAV30fDe9F3p6A8QbkrIdn56FYenQ2iKR9wAJ28oR6svJrBWLJwWgTwRKZY7XJnzLETOqHa8Nm6yD6+KWpnyWs9ZxO6rK/lFMpHLkLqUQR+M6i8ZOp+TIVGZyqBF+Lb8DA1sifNhhmX8a5JZnbizu3tJ+b1Wn02yl+2HyOl9E0V8XOTYEvzcXhPZojk5uHU4T9jLq9hr6I3+w4WUyVWZut0TYwbFrFMoq6wP/5Ckzn1A5J2Ycu67BjQlhEOtrEB2IpwokYMGjfi8IjNtsKPlDYVIYTbC3l0toAhaOUx/nF7/ITOH7eqIC3YFPSl9u/pC3JUynEI3QPbpXBM3/4WNgVvdg6++UhEuA5gDzN6zo+2gkcw+lHB8hg1nImWF9PWr9DbUoz35QaDQaUdP54qJHvhxsVpJw56VUakJ30+dxSDakxqNcZFGGUsqj10NJK7PM1PzaH9ezR8HR3vwQJUVHIAvr8lE0CwHurqzfBF1YBuOB10EyKxZ4N2MxIcR/8tV9gKQ7OfG5fU195Gr/CJmuUwpsfsflkr+My6BhLJPJwyXDMLwYOYQWeA7qLu/CjtbDSuvmW+2n36Ju+5rnOGGKRtCMXvawQp6S4PfFjimRqOEpJrr5X2dQ+uFVq7wwIvlrZFIXl0376Pa0u/TCvEiYoALUSgA1xyiMtGI+5xRSltbm84Dxo98NfOLGG5scUUPSIk78gwz7UxK8OWzTp6wRC1grVaYEL1CvRoPKJgV0pW3dpSYXbnTtF+uydMTs/urtBAgpr5JsBReOZFpnZkcIPWFxZLuvwrk++0R+zmg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5817.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?GOncdPyqIzIAqRo7iAVoqwL29I7pHHGMNM8RHX0JZbsdEclixmIeKms3rO?=
 =?iso-8859-1?Q?5s7CeZOgohG3Vtk3+qUtCL1Gd0tzQv1wVqovcX7eu0aS/+wsL8l+XjxRoN?=
 =?iso-8859-1?Q?9vZ+m4vYvw2tSh2GLyy51Wfshlqp7nN6wAFqtdsyFyUj2ohSH4xB+T2L7V?=
 =?iso-8859-1?Q?1/FHabT3bALaJVPs0wiR4XXnk4a51Y+4UeAkt1EANpUNRCYRpuqGFNAXEO?=
 =?iso-8859-1?Q?4kEGiDmWNkjbiRl7U0zNIQDYs/70OGwmI/BkPV3jcHrPYe7Ee7CT/VX9FR?=
 =?iso-8859-1?Q?ZNuue/63gGGD9+IRnVXe8Dm3iarMtlljgp75Z2c5UdhahzQSo2LJDQsPYI?=
 =?iso-8859-1?Q?+nqhOcZHpq4XYx8dyINmugHv16BbLipwogWwmQ+xFZD8A72pUna6h8b2du?=
 =?iso-8859-1?Q?I35UDob6xXAFmDTzyVsxoINbqpkydHYQcrx1VKDlcaKXD+Xqi/we8hxy2W?=
 =?iso-8859-1?Q?1fWErhSM8w3L8/+OdM+bg7p6mI5wIzLLMz7437fg7rurFECPJdyDSZ5azn?=
 =?iso-8859-1?Q?VmxJUdo/c4sQxE7kLoB9OqFuy5h0qzGRgi95tZtA7/1iXwrHEGvh9pNtma?=
 =?iso-8859-1?Q?nMeZp4qt9h7xl/gcQVZCz/AFH6eFUzkXFS0gwpl8q6sSD9wKdr1p2zjmy1?=
 =?iso-8859-1?Q?hXTYD34kDnWm2gw/Q0GmpuoTVc1rS5A+NGzFt9u2uRpSSgH20l7sAUlvlD?=
 =?iso-8859-1?Q?RghBBONiwsW8JZlh2C0x6oYDqpDBtDkQILSWCok93934Dz9bOSiqAEkK8W?=
 =?iso-8859-1?Q?tLm7f/RhgpzMBptG3xki0FZPa2M7R2WARKjVfl1hS4+lGKoGATFFuLvlUY?=
 =?iso-8859-1?Q?NN9KjPBz3DihgTKyhnZML2/06lDkFrJvWFTN2IlcGJtrVvSQq0oWcfH9Kc?=
 =?iso-8859-1?Q?ECAGZ878fqlGcLMccWfRwD7reac2ehltuq2XbkbZ8LxcqhmmOg3Y/Xn67Q?=
 =?iso-8859-1?Q?B1KQv6JL7bCygWCIdt47rpNMlVUQkWNj+eVnLkm9gRLeO5WT4N93z5zXAy?=
 =?iso-8859-1?Q?SVwo9Vf2jYa75Xxfggnl+00ggs4Ge7h72ntitCpnitRZSnoEGQ8wTzBrw4?=
 =?iso-8859-1?Q?EtL+64kU780/WwPCz7h0UmToSfd1nKpfJeMYGwEQt7Vt75GRqPjrCABh33?=
 =?iso-8859-1?Q?lRFWeYAdO+zRnILwhZGFix3NlpRIXF0efiXvMN4ohPEfMw2EDRFS1cTqfn?=
 =?iso-8859-1?Q?5fr5edRyrBO02YgQgRy9FLc9MAz9HRo2BDm159q4QMxuaZiZKmWxjInsOG?=
 =?iso-8859-1?Q?nQyeJUSretrxJYMxZzXmAHmDlm68cwJ+DxLFvWWGa0/33B/eteDmrbYb+l?=
 =?iso-8859-1?Q?Uwdzk78iuff2wHLAwYUNR6V9PZHMQMssAi/tlp9cIYusDOYFXd7ai5ICNO?=
 =?iso-8859-1?Q?FDvEXKfZ7F0x5SYHdsg1ROBFYDS1kEMvrrB1b3dqQ/3X7E6MAkFEsy3Lm+?=
 =?iso-8859-1?Q?Qyb0p3FGOx08ymuJVBhpqyOmsN54jXXf/ceJc7GhOEZxXRez8MI0L++djk?=
 =?iso-8859-1?Q?et2r0qDSzwkI4pNj4hsdu4Zke/cQhsHbcSeDurxkL4xwMP6yOz+iG3NdRT?=
 =?iso-8859-1?Q?PkU5R/wUdQJSEbOFcrsdE+6ep/+kfGseZX+ubpGpDDkuF66DRDbWEQ5Vho?=
 =?iso-8859-1?Q?tAKzH/Z88LK0Dic6kGIG7LP6QFusNjnMw25Ys/OcgcuoqpXxhEUfV02oT9?=
 =?iso-8859-1?Q?QN/FlvSA0FWU9x/1I3sdQ3qAx1d2Axcul3jfNOAXGoCCDosFfNIcELCaNJ?=
 =?iso-8859-1?Q?TVeTFLsF2bLNiraJ3TTWftcvWSRUyfRx6H+N9zmVPpMUiJEJXp8pUt8p3/?=
 =?iso-8859-1?Q?Y6s0OD3wDg=3D=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5817.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a589a07-164b-41d3-013d-08de7a13795b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 17:28:39.2030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WqjT1ky/Go6OYt2XqwaV16+JkkcUdHzNxKJylMvpHz6DvS7+mhi1s1AqNweSGNZcXI2jmQbnWgA04H3HFcJrzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR15MB6912
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 9TAWFXVTf-q49h1frwVuvLgomoVYLPXL
X-Authority-Analysis: v=2.4 cv=JcexbEKV c=1 sm=1 tr=0 ts=69a86bca cx=c_pps
 a=KMYGTuEAqwcz7NPofZ4ZnA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_78whYxrdx1mplLwxq1U:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=QZ7BxJU8to1C9nr8pvYA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: 9TAWFXVTf-q49h1frwVuvLgomoVYLPXL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE0MSBTYWx0ZWRfX+IUqzBDOZLzW
 uXS8MQUt8KVu7cqu7i6JPOOtyls2F++DM+f1upCQTx/hO2LtykpZxtSjylRZEzwhEUq3STm5nrr
 92bkONoeDSFClivFyh3Kbj2TE7j+VTp3OcyWIjykjnnMretltrW/CvZgkxxilEaP9M+JrfHRFOL
 g6GuLHkmb37lDTJN+CdVApJT5Thu7ELdjya5cSQGhQ1uu1FPr+gqdYsTH+XG9mk7eDDw+kf5sB3
 sc6W3Jbf4mEig2y2rXlErananwM38/Wukf8VSAX80iPaXEApnbgoyCyd6fWypxmwhW6age+bXhH
 1V7+JqVO4l6vTa8/4phq20lchcXXJ0/S8PG40CSy0GwSW04byKJ1nHTCFzrkLtxMIEcxAfmk1JW
 Mf3eiAyaWZ+mGVaMlVPh90M+gwggBI044DzgjKI+XmAhLODdLedNFWJ7jAX4oFpdHxRTBNYY7vW
 rE1oSqbj4jRpqG9J+GA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_07,2026-03-04_01,2025-10-01_01
X-Rspamd-Queue-Id: ED936205340
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263945-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,davidwei.uk,lunn.ch,davemloft.net,google.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,meta.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunny@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action




________________________________________
From: Daniel Zahka <daniel.zahka@gmail.com>
Sent: Wednesday, March 4, 2026 8:17 AM
To: Wei Wang; netdev@vger.kernel.org; kuba@kernel.org; Willem de Bruijn; Da=
vid Wei; Andrew Lunn; David S. Miller; Eric Dumazet
Subject: Re: [PATCH v2 net-next 6/9] psp: Add new netlink cmd for dev-assoc=
 and dev-disassoc



On 3/3/26 7:00 PM, Wei Wang wrote:
>> +int psp_nl_dev_disassoc_doit(struct sk_buff *skb, struct genl_info *inf=
o)
>> +{
>> +     struct psp_assoc_dev *entry, *found =3D NULL;
>> +     struct psp_dev *psd =3D info->user_ptr[0];
>> +     u32 assoc_ifindex;
>> +     struct sk_buff *rsp;
>> +     struct net *net;
>> +     int nsid;
>> +
>> +     if (GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_IFINDEX) ||
>> +         GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_NSID))
>> +             return -EINVAL;
>> +
>> +     nsid =3D nla_get_s32(info->attrs[PSP_A_DEV_NSID]);
>> +     net =3D get_net_ns_by_id(genl_info_net(info), nsid);
>> +     if (!net) {
>> +             NL_SET_BAD_ATTR(info->extack, info->attrs[PSP_A_DEV_NSID]);
>> +             return -EINVAL;
>> +     }
>> +
>> +     assoc_ifindex =3D nla_get_u32(info->attrs[PSP_A_DEV_IFINDEX]);
>> +
>> +     /* Search the association list by ifindex and netns */
>> +     list_for_each_entry(entry, &psd->assoc_dev_list, dev_list) {
>> +             if (entry->assoc_dev->ifindex =3D=3D assoc_ifindex &&
>> +                 dev_net(entry->assoc_dev) =3D=3D net) {
>> +                     found =3D entry;
>> +                     break;
>> +             }
>> +     }
>> +
>> +             put_net(net);
>> +             NL_SET_BAD_ATTR(info->extack, info->attrs[PSP_A_DEV_IFINDE=
X]);
>> +             return -ENODEV;
>> +     }
>> +
>> +     rsp =3D psp_nl_reply_new(info);
>> +     if (!rsp) {
>> +             put_net(net);
>> +             return -ENOMEM;
>> +     }
>> +
>> +     /* Remove from the association list */
>> +     list_del(&found->dev_list);
>> +     rcu_assign_pointer(found->assoc_dev->psp_dev, NULL);
>> +     netdev_put(found->assoc_dev, &found->dev_tracker);
>> +     kfree(found);
>
> in the case where found was the last associated device in its netns in
> psd->assoc_dev_list, listeners in that netns will not receive any
> notification that a psp device has gone away.

You are right! Thanks for catching this. Will fix in the next version.

>> +
>> +     put_net(net);
>> +
>> +     psp_nl_notify_dev(psd, PSP_CMD_DEV_CHANGE_NTF);



