Return-Path: <netdev+bounces-297627-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id COsbEGFEKWpETQMAu9opvQ
	(envelope-from <netdev+bounces-297627-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:02:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF3F6688B1
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:02:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=selector1 header.b=QJZEySxG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297627-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297627-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD3FD308ABC9
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C61D3FBEA2;
	Wed, 10 Jun 2026 10:57:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D8A3E0222;
	Wed, 10 Jun 2026 10:57:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781089042; cv=fail; b=UAohnT1NWdORlC7c1IbJEfnx+dplLtu6mrRzIfdyfuFuQJnaGJB81zarCUOMg3kmAb4mNyZwFkMTVA1Ggo9D8/mmdTmaNzSJv6nQteQk1/rS/NzNe6w/43tmY62/ZbfYfQJ7fJIaetNPrrcquWSlET4S5NyKeS3aCk6yINw8ACE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781089042; c=relaxed/simple;
	bh=7qn6zo/+mveehGMJWQFbLb1YRR0Aq+nPnhIrcrvIRPA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a1JMR3sYQyKDRit7Yb6ralupBmd3nYaCm8lfnJjAOahvNL2WX3GfQh0Z8QTF6Wzvie/OLhII5S6ojkD6OiDJIjpmoqVWhDrHOd8mzPWEfV54xilM4dX6jsCS1S00HxTzQOQhzVUxtF41gV8Nt91mPvghXGWbBEINTqiHyeXUFAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=QJZEySxG; arc=fail smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A7kDDo3125415;
	Wed, 10 Jun 2026 03:56:58 -0700
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11022118.outbound.protection.outlook.com [52.101.43.118])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4epex1n2sh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 03:56:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNYiBLn2QAhJIEjYadtT5fGVq0IRbnJ8Gbx4d6mspLhJJllRFrOeSo0GTBx8PrOhWGApUJBOQSakvhY8X0LLuIR1y5fT3PUm4ynMqnZvTSPDxbpa+IOcWKb7Eg+40CecU0l6yHHGDaPVyPrrEWnUzAiQpUbjyGJvlxdt/bt+w96/lXQUeR6tUbQf/WqqLqSO7tVcT8EWGNeF+1tqAjhrGCjiMCEPulQXPuAdNTcROTJHgBsAd+gDIE8oQo/ldCq4loYVNdEuiEEGI8NhN0qLFnEaqPXYDC6CPPXNxDchk/JDtu2o57axEnKEMDVl8iQUy8TIHiDkFZbDJlDRiCTfMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhjB61H/z3+vAo85s8pDoj2Lu3Fbc/wnwGsPty0x7FE=;
 b=jXHad0lRiHVga3xibg1AFWTcresqXhy+uHfa1u8mquhQRvScbB9JmeSF6zjJNCrXXTFqPMF1pGpiM3KD6jETjLQ0MJev6KNvjMYg9a+kV+03Xnrsa2mP5vTp7icWR5RKPe1Fr5oHEETn0sL+QHkAGNiHkdK7k+R9jAtsG8wmgA4cOe8zi+6fC8pi4dDnBZyL8YWioi4qE8Amup0JY35/3Lac+A5qAaxBrE/7cSJPD46aU9iXv/615ZcCjOcek79B/ZpH+arYSbl22ypyCu174LBvIqbX5e7CNNhQrnWO+wgTlfBZTb4feMsMnWK353pN6yUwmPHz/JuM80FkPi0++Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhjB61H/z3+vAo85s8pDoj2Lu3Fbc/wnwGsPty0x7FE=;
 b=QJZEySxG2sRo3rIuvmbTS3WRtkGP52DDu7Pq7nThY+Xan+llQI9xitZb3K7rVEbm9Eo2wBAB8d5Wy8d1FmLjwaFHr7hITIUyxW8FldEqtNjLlPi5EmDrA6yEvhR6dOn7s2tz2JNZSfwaJUWXO36XfwRzKEfxOaCVZV0KkGZF6ts=
Received: from CO1PR18MB4603.namprd18.prod.outlook.com (2603:10b6:303:e2::19)
 by IA6PR18MB041337.namprd18.prod.outlook.com (2603:10b6:208:5eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 10:56:56 +0000
Received: from CO1PR18MB4603.namprd18.prod.outlook.com
 ([fe80::cb22:ffae:1f3a:af35]) by CO1PR18MB4603.namprd18.prod.outlook.com
 ([fe80::cb22:ffae:1f3a:af35%2]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 10:56:55 +0000
From: "Sukhdeep Soni [C]" <sukhdeeps@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "horms@kernel.org" <horms@kernel.org>,
        "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v4 5/12] net: atlantic: add AQC113
 filter data structures and firmware query
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v4 5/12] net: atlantic: add
 AQC113 filter data structures and firmware query
Thread-Index: AQHc8pd+bd7Yum9JkkKSdgiWkJkSmbYvQ5gAgAann8A=
Date: Wed, 10 Jun 2026 10:56:54 +0000
Message-ID:
 <CO1PR18MB460357FFE7F2D7755935CBF1BA1A2@CO1PR18MB4603.namprd18.prod.outlook.com>
References: <20260602135452.516-6-sukhdeeps@marvell.com>
 <20260605023828.3629062-1-kuba@kernel.org>
In-Reply-To: <20260605023828.3629062-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4603:EE_|IA6PR18MB041337:EE_
x-ms-office365-filtering-correlation-id: b5b7493b-d3b1-4cd0-e3ba-08dec6defca6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|38070700021|22082099003|18002099003|6133799003|56012099006|3023799007|4143699003|11063799006;
x-microsoft-antispam-message-info:
 ek5lqtYAsplk9WlOABLraF2TIBu5YFP/Vud0tNE3KhVdo0vmWoQmogVPdNBVgd4qNhEVR6ksVKR9Us+qLBrjpKgTSykZpdQz+mWbGh6dJ6vNKwLsmMJ3pnZCuw0OX8kh+Y8b5h0o8dJ+vT8AlAmRtXmngV2Sj5Qdsqs1+5rX8bs0ln9gtfHiGxwJu0y7zk8mKP7S7EjwWaQDnnShrxIT8qJ8ML4+8XjaapGjNITARw46qnFmv7g3XO+yIYn6R6bTH2TnXqZTB7NspsVDLZJ7H+LDLYyb6umREhjp/VMOr2gDHRxlNbE9xFmSadoEMa03aFh0MTF3oK97X/3FGLBengqRRXMdrmfVKY+/7/xk5jzXfa3A2iGTObxNKrrlKfRLdLbyMthH445svlAlQYvVbwBPWvyjCCPIzZ47LSQzSQCyMKsc2n0YwSqfVgOKzg9qJ0pvgksvZS2HfNhR47pZhar/R2f8kPYpwwDzNMJvSwQhVsbXPEzgLYfqNGrZF1hvroJKhoLLNlpbU9t3C/Z5kUNW1TOK0ficaHdseRIEhEvkz+ZBBoRfHtEzFbBYDR+4kpvWwRMfML/ViHKliXGKGcnlCi0gWESF0jxf8ss9bS8rgNejWPt7n2jxN0LgnRhjb41Tr9mhpWOfmjghqKx7Ci0honpfS1Iq62nHOEa8qPMGXSN/Pi2Iu+l13V1jKWm8iQcrw0w6I7fazM68ZTbrDoaLzmDyxPYR3j1zBw5YEmV35DqcbU5tTVdGUsaICo5W
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4603.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(22082099003)(18002099003)(6133799003)(56012099006)(3023799007)(4143699003)(11063799006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Cp3LXINM310BddlsLSwwK9o5qL4bmYlJTSa8RYXa+r3LAXkPScKyCsg6+2Ne?=
 =?us-ascii?Q?j7fIspccS6JISFoGm5G73xHw/FDYc/A7tbOWTg+2CHKGmVTudGsZS97E2Tx6?=
 =?us-ascii?Q?uBuL+RWyIT8xaR8hvKvGTP/GsDFLbNtB+P4or+A9Oq3XaWAZX7pj29S8OMmR?=
 =?us-ascii?Q?1pcW/O7Gb+eIYDCe/03ETd2CGbWIq2ipKZMY0oqYUeDy698tYANl6RT2sybe?=
 =?us-ascii?Q?9dP+pVkzZaW7gupBgxRkYEFctvku3ipmitGkunjA5szIApo3U9lQ4UhWdG4h?=
 =?us-ascii?Q?5hGXED0U3kgiwfYAw7nSYk0XymQ+IkxKM0cxXYrbOounaDO+R8hQZYtuvTOU?=
 =?us-ascii?Q?85qA4BPbmhTfJg2le8TOKGMC+NemBylIyBgWsweBMs/sBqEfi95XLQoGgiPQ?=
 =?us-ascii?Q?VRgNUwrlF+J9zHM5nNObkcdSbfn5RSqz4em0i+xL0ZnAoVUXPp8CoZqHvGqq?=
 =?us-ascii?Q?mxzLETnI4DnfhZ5sdvokKPcgsUONxNqgfC9uhSCM9J4pzas9972dUnsfCp42?=
 =?us-ascii?Q?TWolfRiCfBlzCT1sPSaXQfapVOEFw7jSNjpK8KBLuIT/L00N6PH4Hn9WKzRl?=
 =?us-ascii?Q?igbDrlRs5aeHGwYWJBWCni2XK9DpIVzb19CUo+0rTyOY5kb7kwLSm8EXW+DF?=
 =?us-ascii?Q?cipJDm+IUgPMGxkgEZzqFaXu5OKpGy7sCSsBU66qeFhXoH8mA4AbpLl7qJmP?=
 =?us-ascii?Q?uAwLNCoTkaqMIhSSGV1HXcJ3MBCbARlhtBG4pWnwtUd65Z9mYQLklDixOqQb?=
 =?us-ascii?Q?6u13+Wq7XVmIz9gcLaf2oZSr3CXCQ5e21wLoYFV63rY1MYu0m7+AxapRgxph?=
 =?us-ascii?Q?mKvvOYaANqUW0ucztTzGnqOIgCa3Hqei+MGj7wFqbRtvpfl1HeTrEyJ61gDW?=
 =?us-ascii?Q?2mnp3FuRPVaS3Qhh3yKpgqHXyzomqV3JTkiJkz3kLX9Byx6qtu6KNA8TquT+?=
 =?us-ascii?Q?Es+ItXHbSmdCs6mmCVG6AldAbXsL82svC+izA/2IeJhTnFDlE0JnVdrhJImf?=
 =?us-ascii?Q?F5zNebhfHrAFKY+84xOHG0nsZ8GRr2Bk3gclnLGdehe9gYBD2zjH1iqCBzZv?=
 =?us-ascii?Q?CA9j5rkEZA/p80puwaNUTqkG3BvWa36m3GNTgheO11Qoqqw/MhhlGRGaNxhu?=
 =?us-ascii?Q?ZJpXcnC1K3kI+8zbFc2XF5IeZ3kSR8hUdln9H0vxPWKCS8XD54gZde+saPOE?=
 =?us-ascii?Q?al+53xETProhw0aCRDuM5cenivcqUz3jiI0Tc2DjBb3VKOR1xYok+y5EoG8N?=
 =?us-ascii?Q?Qo7IHi1iCdg01DfnirEGkkxgV3FDzqp/Ee7sDgpbkiJpS0XqgZ/2ZEdFCl10?=
 =?us-ascii?Q?nvEpQTFOVmpLyJRCPuY8BMu9Sfmb6SO7255GGjGR1eARG9CwqtgqFNe9X0D9?=
 =?us-ascii?Q?SrUnpYly1lm5cL0zLVaWqiCrcaES9WGMB2sti44bqyfrSdyaFKY9DLuxtzp8?=
 =?us-ascii?Q?Dxx4cO0GsDSw/S5hQR6or0reyJWrc4LcsT4OrjQHrEgx1yIaO7IFXXSqlunA?=
 =?us-ascii?Q?t6fBgAlIC4yQTihHjoHeKNsQwrD/R4tcCiv7m5xkuAWx62iLuSDVjsUP9aOc?=
 =?us-ascii?Q?xGgoljupJ8moeaRtnkNRubrrhehgMInapSRDxzyNRS8Q3py+7U01c1RNDAdk?=
 =?us-ascii?Q?+mbuoGtjrWkRHdr7ZSPjhGE6XJOUpyEX5cBVdHqQZzhmwkDj2fN9CQoJiFX0?=
 =?us-ascii?Q?ffaq+tZCoJFb4wQRoHoRkkQHTEqAGgPTWG2QYE07xTDn4ik2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	l3mDeds3WgoCFrVy6Xjlb1sjY0KyzO3TKiKWvDsOGH+/OoUOlUXVLtJYhoM9KImrLOqBsgE03CUlPBkcjoEjvbu+X5d+VGC3eAHKOI/yYqkG58Zc9RN5MsWF1s1RS7veVaGXrkHYb2JDC5cfZcJAxvuxectr+p21DVaqELnDQzR8Va8zV1H9fEU9ub+uKlPrPpwLr3FKKKp/ji+gkUMWZBnY/OxRJCHfnexMyroYbbBJ7Fswdt09mtWXkUyDY8yhkUgdq4kxKm/ctwx5R9ZQPVgJVsMCQMMgAaMWXXCx1sxL4wU7Wd1hFp1EBZcFwq2G8n7RNXFbecbf5/H2fQy8Pw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4603.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b7493b-d3b1-4cd0-e3ba-08dec6defca6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 10:56:55.6302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PtLAaX7mtgS6WRGCahntBRoaq8iB1abzuDJg94xESZAhtf9PDwQ80QAQ1sG2LcqUtLqglunS05gUOS38XRP64w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR18MB041337
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEwNCBTYWx0ZWRfX8ZJ5gmKkIjjl
 JPui8v98ShofglLAP7wM+a2Ugtdc/YoSUX+CINfTV7Utnd3ZQQH+N6yNOtePaA80lpzfb6ykGY6
 Lj8H2/ZO7BXegcWeuyu7cmOA38abpSzddGCcUwxSMQrx90Gc23J023unsPYzCr73R8T8Wf2Xncy
 klGf4nI1HwrYJZo1EhDH10I14AAhtNoq75CS/fp7vBzm/vsRqVm4q4ekc1g57z6WU3xusUa8lGc
 ePmRXuF7JjxboXvo7sgOlI8UViDAadGbME8RyBngc64nyHHv2vVGYz3IVCENZomCHrYDOnp7AMQ
 /yEO7mi8U+GWze09E+3nwOynv+jzIFj7DJwZvDbJgIxJd1T5ipxveNZBpcrFywe1IbML14qW0+X
 o8A120QRQhAkvnoInLhyOZVn+1Zts7NxaUY7lCYy9LPEfmfN2Qd6P8xpao52MdogHeQGlk0G5H4
 4GhFri5KKleUusOE9dw==
X-Proofpoint-ORIG-GUID: y6avlUMNT8rVmQ07IhmcxK4ZF7Z313jr
X-Authority-Analysis: v=2.4 cv=Aa2B2XXG c=1 sm=1 tr=0 ts=6a2942fa cx=c_pps
 a=IM9eEZCEoeE/lAIW3pMUqA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=dkCXZzNpbxr8RSS2Q_8A:9
 a=CjuIK1q_8ugA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: y6avlUMNT8rVmQ07IhmcxK4ZF7Z313jr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-297627-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CBF3F6688B1


On 4 Jun 2026, Jakub Kicinski wrote:

> net: atlantic: add AQC113 filter data structures and firmware query
>
> This patch adds L3/L4/L3L4 and ethertype tag filter data structures to
> hw_atl2_priv, defines RPF L3/L4 command bits and several filter count
> constants, and queries filter capabilities from firmware shared memory
> during aq_a2_fw_init().  It also adds an unrelated MAC register dump
> helper hw_atl2_utils_hw_get_regs().
>
> A few questions inline.
>
> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_inter=
nal.h
> b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h
> index 5a89bb8722f9..fc086d84fb91 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h
>
> [ ... ]
>
> @@ -94,6 +106,12 @@ enum HW_ATL2_RPF_ART_INDEX {
>  #define HW_ATL2_ACTION_DISABLE HW_ATL2_ACTION(0, 0, 0, 0)
>  #define HW_ATL2_ACTION_ASSIGN_QUEUE(QUEUE) HW_ATL2_ACTION(1, 0, (QUEUE),=
 1)
>  #define HW_ATL2_ACTION_ASSIGN_TC(TC) HW_ATL2_ACTION(1, 1, (TC), 1)
> +#define HW_ATL2_RPF_L3L4_FILTERS 8
> +#define HW_ATL2_RPF_L3V4_FILTERS 8
> +#define HW_ATL2_RPF_L4_FILTERS 8
> +#define HW_ATL2_RPF_VLAN_FILTERS 16
> +#define HW_ATL2_RPF_ETYPE_FILTERS 16
> +#define HW_ATL2_RPF_ETYPE_TAGS 7
>
> [Low]
> HW_ATL2_RPF_L3V4_FILTERS and HW_ATL2_RPF_L4_FILTERS look unused.
>
> Every array in hw_atl2_priv (l3_v4_filters[], l3_v6_filters[],
> l4_filters[], l3l4_filters[]) is sized with HW_ATL2_RPF_L3L4_FILTERS, and
> the bounds clamps in hw_atl2_utils_get_filter_caps() also compare against
> HW_ATL2_RPF_L3L4_FILTERS.  HW_ATL2_RPF_L3V4_FILTERS and
> HW_ATL2_RPF_L4_FILTERS appear nowhere else in tree, and there is no
> symmetric HW_ATL2_RPF_L3V6_FILTERS even though the commit message
> enumerates IPv4 and IPv6 as distinct categories.
>
> Should the unused names be dropped, or should the arrays and clamps be
> switched to use them so that, for example, lowering
> HW_ATL2_RPF_L4_FILTERS in the future actually has effect?
>
> [ ... ]

HW_ATL2_RPF_L3V4_FILTERS and HW_ATL2_RPF_L4_FILTERS are now
used as min_t() upper bounds in hw_atl2_utils_get_filter_caps().
HW_ATL2_RPF_L3V6_FILTERS has also been added with its own clamp for
the IPv6 filter count, so all three filter categories now have named per-ty=
pe
constants and consistent clamping at the firmware boundary.

> +struct hw_atl2_l3_filter {
> +	u8 proto;
> +	u8 usage;
> +	u32 cmd;
> +	u32 srcip[4];
> +	u32 dstip[4];
> +};
> +
> +struct hw_atl2_l4_filter {
> +	u8 usage;
> +	u32 cmd;
> +	u16 sport;
> +	u16 dport;
> +};
>
> [Low]
> The commit message says these structures provide "reference-counted
> sharing support", but the only field that looks like a refcount is a
> plain u8 usage with no atomic_t, refcount_t, or paired inc/dec helpers
> in this commit.  Could the wording in the commit message be tightened
> to match what is actually added (a serialized usage counter, not a
> refcount)?
>
> [ ... ]

Will fix in v5 - the commit message now reads "serialized usage counter for
filter sharing" rather than "reference-counted sharing support".

> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils=
.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.c
> index 0fe6257d9c08..ef549e172dd9 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.c
> @@ -128,3 +128,37 @@ int hw_atl2_utils_soft_reset(struct aq_hw_s *self)
>  err_exit:
>  	return err;
>  }
> +
> +static const u32 hw_atl2_utils_hw_mac_regs[] =3D {
>
> [Low]
> The subject and body describe filter data structures and firmware
> capability discovery, but the diff also adds a 72-entry MAC register
> table and the new register-dump helper hw_atl2_utils_hw_get_regs().  The
> register dump utility is unrelated to filter discovery and is not
> mentioned in the subject.
>
> Would it be better to split this into a separate patch (or fold it into
> the follow-up commit that wires hw_atl2_utils_hw_get_regs() into
> hw_atl2_ops) so that this patch is one logical change?
>
> [ ... ]

The subject line is updated in v5 to explicitly include "register dump" alo=
ngside
filter data structures and firmware query. The register dump helper
hw_atl2_utils_hw_get_regs() is intentionally placed here rather than in pat=
ch 6
because patch 5 is where hw_atl2_utils.c is first touched - moving it to pa=
tch 6
would leave the function declaration in patch 5 with no definition until th=
e next patch,
which is worse for bisectability.

> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils=
_fw.c
> b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c
> index 7370e3f76b62..3011c7cd5259 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c
>
> [ ... ]
>
> +int hw_atl2_utils_get_filter_caps(struct aq_hw_s *self)
> +{
> +	struct hw_atl2_priv *priv =3D self->priv;
> +	struct filter_caps_s filter_caps;
> +	u32 tag_top;
> +	int err;
> +	u32 min_val;
> +
> +	err =3D hw_atl2_shared_buffer_read_safe(self, filter_caps, &filter_caps=
);
> +	if (err)
> +		return err;
> +
> +	priv->art_base_index =3D filter_caps.rslv_tbl_base_index * 8;
> +	priv->art_count =3D filter_caps.rslv_tbl_count * 8;
> +	if (priv->art_count =3D=3D 0)
> +		priv->art_count =3D 128;
>
> [Low]
> What does the literal 128 represent here?  It has no #define, no comment,
> and no log message.  If firmware legitimately reports a 0 count (feature
> unavailable, FW bug, restricted SKU), this silently substitutes 128 ART
> entries and the driver could later program slots beyond what the part
> actually has.
>
> Could this be promoted to a named macro alongside HW_ATL2_RPF_ART_INDEX
> with a short rationale, and possibly a netdev_warn() noting that the
> firmware did not advertise an ART count?

The literal 128 has been promoted to HW_ATL2_ART_TOTAL_ENTRIES defined
alongside the other RPF constants. Regarding the netdev_warn(): this fallba=
ck
is the normal boot path on older firmware that predates the capability adve=
rtisement
field - a warning on every such boot would be misleading noise. The silent =
fallback to
the hardware maximum matches the vendor reference driver behaviour.

> [Low]
> priv->art_base_index now has two writers reading the same firmware
> field.  This function sets:
>
>	priv->art_base_index =3D filter_caps.rslv_tbl_base_index * 8;
>
> while the pre-existing helper
>
>	int hw_atl2_utils_get_action_resolve_table_caps(struct aq_hw_s *self,
>							u8 *base_index, u8 *count);
>
> is still called from hw_atl2.c, which then assigns
> priv->art_base_index =3D base_index * 8 from its out-parameter.
>
> Is one of these now redundant?  Should callers move to consume the
> cached priv->art_base_index, or is there a reason to keep both
> sources of truth?

hw_atl2_utils_get_action_resolve_table_caps() no longer exists in v5 - it w=
as
removed as part of consolidating filter capability discovery into
hw_atl2_utils_get_filter_caps(). There is only one writer of priv->art_base=
_index
in this series, so there is no duplicate source of truth.

> +	priv->l2_filters_base_index =3D filter_caps.l2_filters_base_index;
> +	priv->l2_filter_count =3D filter_caps.l2_filter_count;
> +	priv->etype_filter_base_index =3D filter_caps.ethertype_filter_base_ind=
ex;
> +	priv->etype_filter_count =3D filter_caps.ethertype_filter_count;
> +	priv->etype_filter_tag_top =3D
> +		(priv->etype_filter_count >=3D HW_ATL2_RPF_ETYPE_TAGS) ?
> +		 (HW_ATL2_RPF_ETYPE_TAGS) : (HW_ATL2_RPF_ETYPE_TAGS >> 1);
>
> [Low]
> The L3 and L4 paths below clamp base_index against HW_ATL2_RPF_L3L4_FILTE=
RS
> and use min_t() on the count, but the etype, l2 and vlan_filter_base_inde=
x
> fields are copied verbatim from filter_caps_s u8 values (range 0..255).
>
> Is that asymmetry intentional?  It would be easier for future consumers
> to reason about if every firmware-supplied capability field were
> range-checked against its compile-time array bound (etype_policy[] is
> sized HW_ATL2_RPF_ETYPE_FILTERS, etc.) at the FW boundary, in this one
> place.

The asymmetry is inherited from the vendor reference driver, which applies =
the same pattern.
The l3/l4 min_t() clamps exist there because those counts drive array index=
ing against fixed-size
arrays, while the etype/l2 base_index and count fields are used only as har=
dware register
offsets - they are not used to index into software arrays in the current co=
de. Adding defensive
clamping for all fields at the FW boundary is a reasonable future cleanup, =
but changing the pattern
beyond what the reference driver does is out of scope for this series.

> +	priv->vlan_filter_base_index =3D filter_caps.vlan_filter_base_index;
> +	/* 0 - no tag, 1 - reserved for vlan-filter-offload filters */
> +	tag_top =3D
> +		  (filter_caps.vlan_filter_count =3D=3D HW_ATL2_RPF_VLAN_FILTERS) ?
> +		  (HW_ATL2_RPF_VLAN_FILTERS - 2) :
> +		  (HW_ATL2_RPF_VLAN_FILTERS / 2 - 2);
> +
> +	if (filter_caps.vlan_filter_count > 2)
> +		priv->vlan_filter_count =3D min_t(u32,
> +						filter_caps.vlan_filter_count - 2,
> +						tag_top);
> +	else
> +		priv->vlan_filter_count =3D 0;
>
> [Low]
> When firmware reports filter_caps.vlan_filter_count of 1 or 2, the
> "> 2" gate forces priv->vlan_filter_count to 0 silently, with no
> netdev_dbg()/netdev_warn().  The comment only documents the 2-entry
> reservation when the count is large.
>
> Is the silent disable on a small but nonzero count intentional, and
> worth a short log line so users can tell why VLAN filtering came up
> disabled?

The silent disable is intentional - a firmware-reported count of 1 or 2
means all slots are consumed by the two reserved entries
(tag 0 =3D no tag, tag 1 =3D vlan-filter-offload), leaving zero usable slot=
s. This is a
hardware constraint, not a runtime error. The > 2 guard was added as a deli=
berate
improvement over the vendor reference driver which uses
min_t(u32, vlan_filter_count - 2, tag_top) directly with no underflow prote=
ction.
We will add a pr_debug() to make the condition observable for debugging.

> +	priv->l3_v4_filter_base_index =3D filter_caps.l3_ip4_filter_base_index;
> +	if (priv->l3_v4_filter_base_index >=3D HW_ATL2_RPF_L3L4_FILTERS) {
> +		priv->l3_v4_filter_base_index =3D 0;
> +		priv->l3_v4_filter_count =3D 0;
> +	} else {
> +		min_val =3D HW_ATL2_RPF_L3L4_FILTERS - 1 - priv->l3_v4_filter_base_ind=
ex;
> +		priv->l3_v4_filter_count =3D min_t(u32,
> +						 filter_caps.l3_ip4_filter_count,
> +						 min_val);
> +	}
>
> [Medium]
> Is the "- 1" in this clamp intentional?
>
> The arrays are sized HW_ATL2_RPF_L3L4_FILTERS (=3D 8), and consumers in
> the follow-up patch "net: atlantic: implement AQC113 L2/L3/L4 RX filter
> ops" iterate over priv->l3_v4_filters[] / l3_v6_filters[] / l4_filters[]
> as a half-open range:
>
>	for (i =3D base; i < base + count; i++)
>
> With base_index =3D 0 and firmware reporting count =3D 8 (the natural
> maximum for a 4-bit field):
>
>	min_val =3D 8 - 1 - 0 =3D 7
>	priv->l3_v4_filter_count =3D min_t(u32, 8, 7) =3D 7
>
> so slot 7 is permanently unreachable.  With base_index =3D 7 (still
> in-range, since the validity check is ">=3D HW_ATL2_RPF_L3L4_FILTERS"):
>
>	min_val =3D 8 - 1 - 7 =3D 0
>	priv->l3_v4_filter_count =3D 0
>
> so the entire pool reports zero filters even though slot 7 exists.
>
> For the half-open consumer convention, the formula that exactly fills
> the array is:
>
>	min_val =3D HW_ATL2_RPF_L3L4_FILTERS - priv->l3_v4_filter_base_index;
>
> The same pattern is duplicated in the l3_v6 and l4 blocks below, and
> unlike the VLAN logic in this same function (which has the "- 2"
> comment explaining its reservation), the "- 1" here is undocumented.

You are right about - base_index being incorrect - with base_index=3D7 it
produces min_val=3D0, making that slot unreachable. We will simplify to
HW_ATL2_RPF_L3L4_FILTERS - 1 (same cap the vendor reference driver uses).
The - 1 is intentional - it reserves one slot at the top of the array for i=
nternal use,
matching the reference driver's HW_ATL2_RPF_L3V4_FILTERS - 1 convention.
We will add a comment to make that explicit. Same fix for l3_v6 and l4 bloc=
ks,
and min_val will be dropped.

> +
> +	priv->l3_v6_filter_base_index =3D filter_caps.l3_ip6_filter_base_index;
> +	if (priv->l3_v6_filter_base_index >=3D HW_ATL2_RPF_L3L4_FILTERS) {
> +		priv->l3_v6_filter_base_index =3D 0;
> +		priv->l3_v6_filter_count =3D 0;
> +	} else {
> +		min_val =3D HW_ATL2_RPF_L3L4_FILTERS - 1 - priv->l3_v6_filter_base_ind=
ex;
> +		priv->l3_v6_filter_count =3D min_t(u32,
> +						 filter_caps.l3_ip6_filter_count,
> +						 min_val);
> +	}
> +
> +	priv->l4_filter_base_index =3D filter_caps.l4_filter_base_index;
> +	if (priv->l4_filter_base_index >=3D HW_ATL2_RPF_L3L4_FILTERS) {
> +		priv->l4_filter_base_index =3D 0;
> +		priv->l4_filter_count =3D 0;
> +	} else {
> +		min_val =3D HW_ATL2_RPF_L3L4_FILTERS - 1 - priv->l4_filter_base_index;
> +		priv->l4_filter_count =3D min_t(u32,
> +					      filter_caps.l4_filter_count,
> +					      min_val);
> +	}
> +
> +	return 0;
> +}
>
> Same "- 1" question as above for the l3_v6 and l4 blocks.

Same fix as above for l3_v6 and l4 blocks, and min_val will be dropped.


