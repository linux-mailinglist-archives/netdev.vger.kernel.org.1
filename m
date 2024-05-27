Return-Path: <netdev+bounces-98263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0D68D0659
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 17:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28626B2310B
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 15:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C897317E91D;
	Mon, 27 May 2024 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="jYwzqRHa"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219D379E1;
	Mon, 27 May 2024 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716824208; cv=fail; b=FyC3WdbA0kRdYORQu/moDHJa1HQQNQJuaMzTG2Jx0JJbyHySjDQHTVeRKhOFuuzA/8PE8+ZG6oGUNdKCOLqd3kNNyBp2jBXIUY42OOw8/ZOOZzV5QTyCxLVUN/J+9fjBwiPOp8Hx0trG828ocBtVTdY41PlQHbAin2BrMvBjDf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716824208; c=relaxed/simple;
	bh=WbtsxmCGwszSrQOqugluLQkDrjX/H1A13aA+8/kvnt8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g/Wlb7XWJkCWZ/cp/GUZod0C4cAcLqPzMGnz7Fu+SZs35wUceFsvJ26v4fdp1jiZbFEai+oicir7UilAPDfkXXKz/xFzQR3fUHLsbkFC3WP+VsHyNwAk0htH+RGOvIxXvrr3rClBgHJQJKGH6VLTL0ilH1v4ODkwSyYRSjnmY5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=jYwzqRHa; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44R9bfSs010731;
	Mon, 27 May 2024 08:36:26 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ycqpyh6gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 08:36:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ts7miYEmX9vgekXxdSsshl5U/XaxnkrbxguLw9V+OzfM+TUWaga/NggwRzFhKe9jYNXnKEMwtIDHsTvelPnvdE+gTDT5eKaKZj9wWk4lWVzYIiCzRPgyz8dsemjPmsX8C+iUpKVpav/piHlr0y3PU5+snst5Zw4KBMEsihcUOOScpniLiTc+mTRa28fguC9ho9r64wB7boBhMPz2zrVxbfN3r43Y6noVYnCHnXRoFIEEFGNjPeu3eIXNDiSeQkgpJnk8XVkV75097lswimqU1PHkKFfm/Dz582UNSICZoqW2rj868243ENIn2ELMbKA/5IGgPkddiZ865Q8Mazi9zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbtsxmCGwszSrQOqugluLQkDrjX/H1A13aA+8/kvnt8=;
 b=i7WZek9i1Smse9Y4f7Kd2EBzxlVgpXK6yZ9E5s7K5ud/il2PyekHzoB4+SIGujbvOeaLyaRduLPH3kcHNuyb0l1+NQPdiSwS7ClDdZo6/9BHH5ygMhJT0JxqlBtl6VIHzQuofaaFuSZ5EcQiNpbazmGXsKVtaXSYTaoANy1kwNz41CYut+50sxVm1oyWS+pF5OC7lwZvc0algcDN811RNdkA9q+Si1UERHL/SmaFWzp/fJOGqPZkeH1+utiTuqHaSTteFC5wlhWgjQb35fJnL3PWWrIJCjsqsTirO7O2XATisxJygoHfnhX94YLHKTBDNutVJkXEGGynyPFsD4Pyiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbtsxmCGwszSrQOqugluLQkDrjX/H1A13aA+8/kvnt8=;
 b=jYwzqRHablnreCAYC/tTM96GYRURAGlYbci8vvuwUO5uRySagWnbYP665iS75ZbL6jiElei6hUPIMc9OPDl1PiNYrrZ9VRyRsMT3bOtsLPhxxeiGhcL6lB+T0L++scKNMtm5SIsmpV41r+uMxPkHfewMo4DhILA/uS+D6FK+RE4=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by SJ0PR18MB5188.namprd18.prod.outlook.com (2603:10b6:a03:418::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 15:36:22 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e%5]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 15:36:22 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: "Ng, Boon Khai" <boon.khai.ng@intel.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S .
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "Ang, Tien Sung" <tien.sung.ang@intel.com>,
        "G Thomas, Rohan" <rohan.g.thomas@intel.com>,
        "Looi, Hong Aun"
	<hong.aun.looi@intel.com>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>
Subject: RE: [EXTERNAL] [Enable Designware XGMAC VLAN Stripping Feature v2
 1/1] net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
Thread-Topic: [EXTERNAL] [Enable Designware XGMAC VLAN Stripping Feature v2
 1/1] net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
Thread-Index: AQHasBkWheaSobs03U+dZKCIDRr6V7Gq42wggAAv24CAACMg8A==
Date: Mon, 27 May 2024 15:36:22 +0000
Message-ID: 
 <BY3PR18MB4737DAE0AD482B9660676F6BC6F02@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20240527093339.30883-1-boon.khai.ng@intel.com>
 <20240527093339.30883-2-boon.khai.ng@intel.com>
 <BY3PR18MB47372537A64134BCE2A4F589C6F02@BY3PR18MB4737.namprd18.prod.outlook.com>
 <DM8PR11MB5751CE01703FFF7CB62DAF9BC1F02@DM8PR11MB5751.namprd11.prod.outlook.com>
In-Reply-To: 
 <DM8PR11MB5751CE01703FFF7CB62DAF9BC1F02@DM8PR11MB5751.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4737:EE_|SJ0PR18MB5188:EE_
x-ms-office365-filtering-correlation-id: d94afb32-3fc8-4afc-4df8-08dc7e62c339
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|7416005|1800799015|376005|366007|921011|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?IHok2lZuvhX0Dh1LrhdlOjqZChTlrCvKhPmb1atewaJuxaWXWLacuj3YcGDM?=
 =?us-ascii?Q?lz7II5wka9OZbEGGcAOfjETOtn0Ew6zLGbJHceQoypkWVoJIFFaS6/heafSu?=
 =?us-ascii?Q?UDkHGs26SrvHTIY1E9Z4X0o/S4O4lPyyMO64lqhE19bIVs1Kfb7vE6wh9hen?=
 =?us-ascii?Q?t9Ykg3b0dzPo5N2+/JQhFv1m4glFg0EjIvsMzc/vbMciKgKUrmMzH6Wj9veV?=
 =?us-ascii?Q?BiD2ziYgAXYtsuc9MUP8+SMYtl+g0cvii4W7efuF41a+4d6uBu+yKnwwphFM?=
 =?us-ascii?Q?Iyn84l9FEj5RAtQoYpP7EKM6uJ8yfXGPpZeqgmFBSVGH62tlfoCXqvjXlxC6?=
 =?us-ascii?Q?oVHVzEhnF8es7d91gFuaTPLb47UjCOJYBKYf1GYAk98XDA0r0kbu0y97RWaW?=
 =?us-ascii?Q?+63cmgsrfN9EiPMffmDZmal83YEYY+f+1/89gi3TH9HVqJWtwCP8YC1LUnGu?=
 =?us-ascii?Q?+UHNsy10vcoCLY6vKpQQPMJEP4T2d8xeUW59KuKbY+VH71ojnViH0s4DvPH6?=
 =?us-ascii?Q?wzoTX03kBwFUa5iaW5A7GIIhDf/60J323Jmjjs2oxd/vZYWyd7yimMj1l3/M?=
 =?us-ascii?Q?KYXO6TpybqRBiqTmXLaE3HIM/8pezy9vHykx8XxaSYAsP8+g/I1ePfycIwNp?=
 =?us-ascii?Q?BKWfPE40pSKb3XKpUCS7qZs4QcSppN5ZTX35JZ3FhODqJty2o1PluLxnpQBF?=
 =?us-ascii?Q?UNRwAWzzmRrR/cfNd9KLNNXHuQOaZBMP/4SwhWWipqzcfsETBKGfXyFp2v0l?=
 =?us-ascii?Q?nvcid8zH2sRYxLzIPM9gEcouJRIyIFZdILMsiQBoYHfLW6fXYiJ2xAi1Ouon?=
 =?us-ascii?Q?qGf5Ng9VPjP20iPpAaQKbrpa1qSBgcjogPU4dNpsSFFkQ88k18m4rM5nd00D?=
 =?us-ascii?Q?mXc59IzN01YDcNCwJlW2ywGRlbw11GoxWjv0Qj6xuoFjlaPMWxXjNkABEZd8?=
 =?us-ascii?Q?mJQskQJDG4uK1t9z96RY6uheiIVm2YUaRiR+sdfh+7xc1BopqgK3FAtn4fuy?=
 =?us-ascii?Q?oLfKDErttdYHfhfbajeXyCIWzhbJn2lGcIjF4hGvVtHTsUg6y2kEUraFVv3H?=
 =?us-ascii?Q?B9Qpa4L4mBqVajzCdPmwca5FUzwAsGoRRt0azvAqacTzuewmT57zGxSIPEJs?=
 =?us-ascii?Q?p0E5vl6h0sGEX4DObA5m4f66PQFGOllrQSleAXchkrUBwSokzFrHfq6ss42E?=
 =?us-ascii?Q?EUIGa4Itpwxnpl6aBtjwsr1gLrANJNGaOOsx07uKBp01ekDFRJJ9S1alwjIF?=
 =?us-ascii?Q?Bb4Bidml4RinKC77MhOu5cBUhJxEFrPB3+a6XfKuWe2OueS+QHNNdNcZIyk9?=
 =?us-ascii?Q?yjM=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?NjV8b+wmBhYeBAd8zqvkD5Vg+75mqJlzII5y4CYwwlpEN7RVoP0hSECpPF/d?=
 =?us-ascii?Q?Aw5FeqFKXB4xapKIBLOUCXLIjGbinM2bYgE7SyPtT2RlnPHsnrByALPWnpFM?=
 =?us-ascii?Q?PMroSstb6oNmAuy563ViElFZSUCUD+T9dmT7QM13w0b+soSX9UV9q1d956x7?=
 =?us-ascii?Q?GfzMgyObnuG+ZygixopzQ1hha77hXEfmHNCQbRcS8M26ww7igS4rdBy1Ay/e?=
 =?us-ascii?Q?TrfjxFgrMkqjFa6o6YTRN4yaV9UwRu91ZpJbxeJ3sVyiLLse8cJVICAKoyp0?=
 =?us-ascii?Q?EJOkAJGCZ5LLgfWinms++AYNkn6I58Erz0Mjtamld1aeyQpMqkCFnDgv4Xw8?=
 =?us-ascii?Q?HrB4UgjhpIpNleHHjUvYyKiurJEFuq0rsV5e8lm5BeO4xF+iJc4NYaQusz+/?=
 =?us-ascii?Q?ds1q4QOTm/s1CeNoXXLHArexFIKzliRwTGeXKAUKBYQxyzFFD/Cl9WBM078G?=
 =?us-ascii?Q?RLAd1TcJU+5BRxx8qmw5Z8ZVEPUebawoboMySVBkXNs4GYONGH1oFdV+E2us?=
 =?us-ascii?Q?YWvBagbKHwYxpRHUOOH98LKmYzNy8L66fkcI9cJq2gCchBUG9kOovnVAAlWx?=
 =?us-ascii?Q?OWGfprZzLa219LjT5J9I5K7ddopEsJK3/KIbuYQIdkdJhlAXSGoUV/ypTsTk?=
 =?us-ascii?Q?lz2CJKp6HFzTo0s6eO9z4ksK29XJPemtAeWIjRdazCd/XlhpG0uB+8kdL0eq?=
 =?us-ascii?Q?DitG2nINd/nfd8cal5mOxmHb3DmwU7rFD1AlTxTqRNdot6ictod79ljHSLNp?=
 =?us-ascii?Q?8c70ognHf5wI3Aqay0OTYmNm0v0EvxW/+X+EiXSkQGuJHd5dpGoxQuSgJtiR?=
 =?us-ascii?Q?h6Vn+PiCYdJAvbROgGLBAjHyQhYSNaDnzgP8yHV3v5+trugT4kT9A6SJlO+h?=
 =?us-ascii?Q?ovqAK0E93jPMZXK1pfJKj8vMkS7tIHmd+Jpg9WxAY2dycjyWwqvSmQzTdnd8?=
 =?us-ascii?Q?itHl9v8MKmmrRfg1WRwZLTtl2phImxFmpcGDC/mxpSLloDxVHxkIIvuykKfb?=
 =?us-ascii?Q?tGWBMlyWE6+3mJaEllFeNDVeGrimjGTEO13/tZkpfohfc02tqDoXJlD93z9q?=
 =?us-ascii?Q?KccsbSIuUjAMOWXfvLvMOuS7j2i3d5Ul0st87BeCpdTzgT3nWyjoQD7vdh2z?=
 =?us-ascii?Q?ZvIhG0V47iueUHsHYC/Qo6cScd+O63+nRsSwMfedzEgZMeofCcYbGJAtY7Gc?=
 =?us-ascii?Q?4HCfjYVptI6RVQI7ESPOPVZF3BHlo260z5p92jRyKTF5GBaSdBqRQawg4gHf?=
 =?us-ascii?Q?quqbDTnX1RTS1jvy0pOC+fV2fzpe5EvyHTMvxJbwEiIM64nqSrwXP0Xz9EKc?=
 =?us-ascii?Q?fZ+IwQEmZObTN9UBa3NKd2u5uauzWq9lcthP/tJ8NHqwH2lvzTcccoKsrEsZ?=
 =?us-ascii?Q?FbxxZHrvHQWDSSvq1moVaZ0P9MRsRQYGOgLS6MrNcbWN+6FLKRouCbzAUp3M?=
 =?us-ascii?Q?K6EWswdcAahM+DoOJJf8107OYXjT3mZxPS9iKAIOB6EWCcgSsXyBN0aCaNwR?=
 =?us-ascii?Q?HwVNUVSsVpb4bvL1jA22AcXY+O50VidEGbiIEbbCWvtE1FUwxhnF6krddGtb?=
 =?us-ascii?Q?9vjP85oRmqC+39kdO+MTkmFnBHAwPGRtXsHGu2mf?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d94afb32-3fc8-4afc-4df8-08dc7e62c339
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 15:36:22.6398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6fC4Xw3LjzSuA0keYiX2qY5ZcfVrS+Pq61f5ZctKBuWzpltmqEd74LZVL8c2m44/mP5jYerYTMxTmUZ05YWfjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB5188
X-Proofpoint-GUID: aBWER19B_235upXKTaKvt_vhTl4ZGnWy
X-Proofpoint-ORIG-GUID: aBWER19B_235upXKTaKvt_vhTl4ZGnWy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_04,2024-05-27_01,2024-05-17_01



> -----Original Message-----
> From: Ng, Boon Khai <boon.khai.ng@intel.com>
> Sent: Monday, May 27, 2024 6:58 PM
> To: Sunil Kovvuri Goutham <sgoutham@marvell.com>; Alexandre Torgue
> <alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@synopsys.com>;
> David S . Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Maxime Coquelin <mcoquelin.stm32@gmail.com>;
> netdev@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com; linux-
> arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Ang, Tien S=
ung
> <tien.sung.ang@intel.com>; G Thomas, Rohan <rohan.g.thomas@intel.com>;
> Looi, Hong Aun <hong.aun.looi@intel.com>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; Ilpo Jarvinen
> <ilpo.jarvinen@linux.intel.com>
> Subject: RE: [Enable Designware XGMAC VLAN Stripping Feature
> v2 1/1] net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN
> Stripping
>=20
..........

> > > 1/1] net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN
> > > Stripping
> > >
> >
> > New features should be submitted against 'net-next' instead of 'net'.
>=20
> Hi Sunil, I was cloning the repo from net-next, but how to choose the
> destination as 'net-next'?

While creating patch you can add appropriate prefix .. like below
git format-patch --subject-prefix=3D"net-next PATCH"
git format-patch --subject-prefix=3D"net PATCH"

>=20
> > Also 'net-next' is currently closed.
>=20
> I see, may I know when the next opening period is? Thanks

Please track=20
https://patchwork.hopto.org/net-next.html


