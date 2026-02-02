Return-Path: <netdev+bounces-255807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KarGsdygGkw8QIAu9opvQ
	(envelope-from <netdev+bounces-255807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 10:47:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFEBCA42B
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 10:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E102F3001CC4
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 09:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786E82D6E67;
	Mon,  2 Feb 2026 09:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="R9OHq+O7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63C52D6401
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 09:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770025665; cv=fail; b=sUtOMSVep4lG3T3TfZQbNNnKeuqMwlD224d9scyTioQIdeCTvY9j4adqaTXM3ZscUvJlgQlfpHQW9lIpzGSM23eZIj9xLNaa3jNM2JTqJadrkxEdrVaAvRL1yqiUgArtGLBX7667abw+6mvNmaCsxBs73gkGKmZb/V6VFpTh+jA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770025665; c=relaxed/simple;
	bh=iVBcn5kx/A1ZSQWy+Qx6Mm/3AwpZ306VN0qiuQF5yqw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=stgCnBijcu9lujA1d4u/tPWFe3+an1sXwa/RQJNRXDxpJ4dCneXgp6xs8wou/PHNIfAPT6wtj/BiriDmGUnNZui7eK4z1aONBGzU6Tpl5BSIQ7mFjPBxFOz77cl3f8C60g2uguHLt2F6CIYS6IeqCOErnK6eaS0n5UScWTEXNxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=R9OHq+O7; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 611MngSx3353805;
	Mon, 2 Feb 2026 01:47:34 -0800
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11022073.outbound.protection.outlook.com [40.107.200.73])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4c28mvsf4q-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 01:47:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6EXSbytnRmTjcWiP3Y7oQEZ1n8p21d6ZmQm8yAnNRVbgZFWh6cqOdpfqXMEE8m+WcyKr02Z9wniQiir6D2WLRoIfhYy7tkuzB0YYRa2Wtpegacfi3393xMa7CK7kOQ8gfnNUDUmnMiyANTjN8TDhFBbbx2JOXO+7QT+3wMnqBsb7rOm5R/atJL2XmwJa9H2BGPoBTf4xEolJc00MnO65qoxdOWW/VMKV4jfG/T9znP6/DB2yFg9M+xf1g5weVzmv0xBJDIpUadFJT3j4enFR3zQB/a/9cr0Pyj+REjDroOF0INimGIrHE9dWiWBq4ZEsj+iM6o4qeasnR2b9dcDfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohRMEZ6u1PkqCDy/mLLoqYYdrLJwDscQnlk2e9HY46I=;
 b=b5tjME3AaeaQPp28/TgsjdOoRqhrCVlEakqq2NiAS7myTOSLv95qP9DPq37jsG1ywPTvF/q/UTxnpAjtTAkaeumudeirSCWitHb69uqKbzZZeyVMUnLHEdgxIsgLshxZ2PfQzdaFMM8XRLLiNP2VPGL/yMZi0GAlUOzKDPpPP+I4FlLiDCqw6bmfWWPaEFn3pPRKWapammcAnFBwUkBuMXbY/V5RwFrh31Yf+1hZcLWHgJoHLDj4yqsmBrk29HNXmQQp8XHL/AIZVXyRH2QKB6wUu8rhJjjSSvaYRS1musBASYc2qMWkQsIRCjhPR4x/Bj+vn8eQWb+LABFLLjNUOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohRMEZ6u1PkqCDy/mLLoqYYdrLJwDscQnlk2e9HY46I=;
 b=R9OHq+O7/LyXXh3NwWw1hxhRNl33dj8Eum0dZ5lzEspIf6H2Cj94UGlLKJz95O67utCaj+4+ZDzyAYFQQ3z18rBNW5Kxii6/42UdJiJdiMiTJOZj5xqdEKSr8KFU2f/4FA2i68Fmf/4BdMHgmdmU58/YSy6Xc522PBmL6WHUUAI=
Received: from BN9PR18MB4251.namprd18.prod.outlook.com (2603:10b6:408:11c::10)
 by PH3PPF615866D7F.namprd18.prod.outlook.com (2603:10b6:518:1::c9b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.7; Mon, 2 Feb
 2026 09:47:30 +0000
Received: from BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::8581:a781:5bfd:fc1b]) by BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::8581:a781:5bfd:fc1b%4]) with mapi id 15.20.9587.010; Mon, 2 Feb 2026
 09:47:29 +0000
From: Elad Nachman <enachman@marvell.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>,
        "Taras Chornyi [C]"
	<tchornyi@marvell.com>,
        "Volodymyr Mytnyk [C]" <vmytnyk@marvell.com>,
        Yevhen
 Orlov <yevhen.orlov@plvision.eu>,
        "Vadym Kochan [C]" <vkochan@marvell.com>,
        Taras Chornyi <taras.chornyi@plvision.eu>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "alok.a.tiwarilinux@gmail.com" <alok.a.tiwarilinux@gmail.com>
Subject: RE: [EXTERNAL] [PATCH net-next] net: marvell: prestera: fix FEC error
 message for SFP ports
Thread-Topic: [EXTERNAL] [PATCH net-next] net: marvell: prestera: fix FEC
 error message for SFP ports
Thread-Index: AQHclATztfec2vxpy0GKf3Rvu5UivrVvKOwQ
Date: Mon, 2 Feb 2026 09:47:29 +0000
Message-ID:
 <BN9PR18MB4251E4EEABFDF66B49DC799FDB9AA@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20260202052816.28191-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20260202052816.28191-1-alok.a.tiwari@oracle.com>
Accept-Language: en-US, he-IL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR18MB4251:EE_|PH3PPF615866D7F:EE_
x-ms-office365-filtering-correlation-id: 7da96d54-b10c-4e64-cebf-08de624014b6
x-ld-processed: 70e1fb47-1155-421d-87fc-2e58f638b6e0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?22Qb4UUT+z5cllr7QiG0kALWefXKDxePxtcYcEqaI82+zfDI8SsyKd1RGyl3?=
 =?us-ascii?Q?SPXZ7fH0kj3tVoeHHFuiAmoysr4B9eUWuuPQSR3IZV56ur1aj7pt/LncmS5H?=
 =?us-ascii?Q?pMlGmJ0gFIy+0hccEXck2BGMEtcMUL55ymey2suIhI9lkMBsGAEDZmGbYtUH?=
 =?us-ascii?Q?j33A5VZ3oE1HP+ElK7n5QWjwFNR2z/S9DmcN6LvwH1b4VlpmjNhB1LkdgXK8?=
 =?us-ascii?Q?OAE/TGceI+VNkvy00FMi9hWWMsM9Zy1B7Pv9EABxEwhe+6X63Mz12koMxP/7?=
 =?us-ascii?Q?leA/yJyrhAVch98I5wERCTKqST5uwybaXN2pajlGBL/lpVXUxcCdQIA0x7/0?=
 =?us-ascii?Q?cxwua+v9IqQBTmUGToMmHk4HIMdQ10hGja6Xj/U9Y2d/O85AhCUdEl15LU81?=
 =?us-ascii?Q?P78BUdRs9qtoCEAfXBUg29t+KZ9fjbqCTmRCKqE5I1sXs8Ac5mlTzH4CKFuQ?=
 =?us-ascii?Q?C/KNNwlN1iHXgnk64fZhOiiMvDazKzeiNsi69QUYS/5Y56YrYCD/TSLYA0AB?=
 =?us-ascii?Q?QHyfA75SaUQFesx1/ChuvyM8sbSo/iLF95wHGc1kJGMv2qjk/qVrFL3CsyEE?=
 =?us-ascii?Q?AL6yNXkRagfAFtU6Gdk2rpzPDVb6ptuIoSDW8mcS6qSbHhPDvZvGnL/nVhXp?=
 =?us-ascii?Q?uhOr8m4DUJ1fpks/7PxjQB9yVZ7GEgru3pwdVnQqoeOpe4r+OhugNFegGnf+?=
 =?us-ascii?Q?Q8KBJ3yKNyVoEzGRSQ/DBD+DpehlcxFNUX2T/ui91VjtoK+tcGDxxC77TbbQ?=
 =?us-ascii?Q?MjnVgoJpO4rihs8lyHrMqah4iQLkiFdsPeyEe/irwqyxu7gI9fp6VWK5c4OP?=
 =?us-ascii?Q?UeCkLTLYBOizmdmeNP5WATrT98fB+k//2CxzGDaPVGbVHsGZLo1CGxxLlEJS?=
 =?us-ascii?Q?0niE+XeasYdmcZ1fmBdO1QpJlmVVhIaxPpcTQ4VfsljQakoonld+2dF9bc6j?=
 =?us-ascii?Q?YGiNoZKcy4VXLyhyQCcrnEFnbkGli9EuTM2pEP7hJS8K3/o31BHjOYSCjoeY?=
 =?us-ascii?Q?AqyS6GJboaAu5bqL/4qiqaCj+xltaJK0gtarYsW3xQCe2F//cIUb4xcUvTWr?=
 =?us-ascii?Q?lBH8CPij9K/jl/J+UddtCMT0pz1aMwkqpEh3881WlEAsNFBpBjHru1+Le9+4?=
 =?us-ascii?Q?q1ZXW/RSWWnjnbaG3/GMqI+0MEul9gw4X6IE5BhMTQrlzf2NYTSDwvqk7PRq?=
 =?us-ascii?Q?Pt3x222rgnyhoWTK8N8OEYW5BrxukkMOSibXBtI01vGSm1i5Sqfi0/ZiSSZp?=
 =?us-ascii?Q?sxEHrE4sMdQiJxiAYTy2cY38/0d1bdr42tBw3aqaS82LNH/VDRmgoejLC4VF?=
 =?us-ascii?Q?4YLhGUemnWIgWBfMJEQU3nfZGawUnkYeJJ7G+ef/dId/RKllTapHhEMsk1ks?=
 =?us-ascii?Q?GJ33hN3k2BULGitQOB9uB+pQF0dc+JkJ+oBtua21y6r7ljaZCXnkFAjScN2u?=
 =?us-ascii?Q?tD0J0W0kSxyLi1WOL9KqfrUqCznOtZcEh18KaCAYvvTqZ4G+zedbIOv5vDaC?=
 =?us-ascii?Q?k6CaG0UOyJ8kg1WkJ3XydyWFgRkvTUGxkRhgcVh+P3BLDYE85blIa9llmPsV?=
 =?us-ascii?Q?tvO1/R7Va10PcABNKmnXomMyHswKVkveDNum3Ag5+7rb2E1j89LvLTDlG/mS?=
 =?us-ascii?Q?sA7Xl+DR1Cl81VWx1YN9eMSHhFR3kEYCV0PMPxV1KGQj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4251.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020)(38070700021)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lOV7o4WebzG3zKIEhkSIcv8Y3NZ7ZaCY5zg0W6bVSm7P9pccw/tQy1HJlFvO?=
 =?us-ascii?Q?2QHFin8dRSBVbqYibFlbReSuYbYMdyHrjmrWhmfIPjWGg8wZ3eB/TIPeWiRU?=
 =?us-ascii?Q?djNX4vV1B4PL7yCjFOmJoy3Yx2racxagTgfOkESryiK7gACZ4IQTKOPbvrO/?=
 =?us-ascii?Q?s0mVdUkvMC3tB/7P7ZPkIxk45ofl+6yeAbubb8MKLYvUc7lRvrFPd6jx1DEo?=
 =?us-ascii?Q?aTvKlxS4CqdwucsUlQQ0o3QOSAohTixNlLZ73rysXMXZMZ+xZJk55IndGVu3?=
 =?us-ascii?Q?0gF5lObx+oHtzU0R1Mx9vUfKAOKP4GwLknyeKYCQMgy1NXZKRBOeZyqwe2b5?=
 =?us-ascii?Q?QQDWx5ZWjQNi18M8ywV0czznAKjwUuLwWUyIctToOIauGOFEnAvyK55YuPcU?=
 =?us-ascii?Q?McpcnTLavuQV+x078UvPyjUbHahmWW1E0dMlLfHYyp+MOYnczcDDEscRoOb0?=
 =?us-ascii?Q?gq84e55lnxhc+lcfJjrx2E1eKB1PhccHjfT69y6OPgjOVYVy4cQA2NlBbvTi?=
 =?us-ascii?Q?KgRFCArZd2vAAx7crQA8IyiD2apmBRBG+y8hGvRt1P8UDwAyQW8aegdsrsRR?=
 =?us-ascii?Q?RQAdiN/DDgDE5jib1r5s2yMLVeZc53RsbuZaA719pHOiBSyEXLGR48s3wYMy?=
 =?us-ascii?Q?uKK5da+cYUMK30LmC7I/7OakOyBAHrK94kdDZttE9TboG72Q7yEpZcjme8Ix?=
 =?us-ascii?Q?ElErqqx5htJQD+PajZcbdH+MInKalC/EfXlQycsI+eZevD+s2WVwvSMIz93Z?=
 =?us-ascii?Q?3X+R4M2cBndH4eg5Tuwx+jr9NErLcei37m7mhVHdeS1srWhmAblUeNGDY1Z5?=
 =?us-ascii?Q?T4L496Jw0NChxbLqy0s5UUHDJQt1BpUSpxnJU+nMgx62Tbdwa97s8tiTL3gc?=
 =?us-ascii?Q?qUU7EBQwoxAzclZqu1TOFiYruw0YvHe/n1/vAYVIk3coYLm9jjF+1xsAl9M7?=
 =?us-ascii?Q?BcoUOqKgsmv5O859QuMWgTi41g6Jl2qVE+sVVRJdJuXdAY+kPvDHW5AZo6kG?=
 =?us-ascii?Q?NKwkqnKzMVFhFYkqDDKU+dKItGHxksQGZnc4A61aiPVeut9qggz04TdteloK?=
 =?us-ascii?Q?J7vSOmMrgX3eDoUY+5mN46zPMuUIOlbWS+n9GuCUNLBbIW3z3+DhokwFzNvm?=
 =?us-ascii?Q?Nw1OMXHol97QFX0jtNiayFtZf5vG1YozV5WZjG3ZLI2Abu2+9sKy3tCVt8+X?=
 =?us-ascii?Q?M4z0lllKBzJRfHI4Endf9o42hjYpjs9WqdHyw/mCOkfBcS3mEqmkWToVFdOg?=
 =?us-ascii?Q?VtpRN4S8EpwBlWWZEl2MGgBgt9HPG61H8OyxenXeLVSpQM9oq4rgTv4iVBE1?=
 =?us-ascii?Q?2DfEiDSthxIqlMPuk9fVBb0aIzVA6jmBYLhdxmdMYUqR+n+EiRwaQpA2jCmc?=
 =?us-ascii?Q?tRwqs+FmyeE+N1AoMtlNJ3de3v9Y3oKC03zHDKFgA1rzt0YbJmg9lu14p520?=
 =?us-ascii?Q?vOByOZwH1Z+OXHXNiRh8uwLYfZVhqYApBIkxuo2/WH7QJZytoSpudKYF1Skw?=
 =?us-ascii?Q?7WHY2QMJSfT+rSCoNAdZVRhxU5v9CvwGcxiCEEpUDzaqwTR9Hv/3A69kGPtR?=
 =?us-ascii?Q?4UeRQeh/gddHItAwXbzl3Ifh1cHzmW9F/ioVPq6lps7cqsYhBzrDiRa2ogyX?=
 =?us-ascii?Q?rcMrewIs60DE+F39ejyIHT9ygnXY60kif7mybRRcS3xRDJ2Jo04AWwkd4Fxz?=
 =?us-ascii?Q?P1o8zEp4PJpucOKGF8ZLu0r55nxq4z1Wh5V4SU6L4b25Ta1D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN9PR18MB4251.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da96d54-b10c-4e64-cebf-08de624014b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 09:47:29.7531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V1s/jk7gjbLa/taT7sjVNdO/eDvzNSpuA1OowaWDwwkEfCvenXi5Q/KFgUrZ4iiXtImjdrz60G88RzCxRDZghA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF615866D7F
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=MuhfKmae c=1 sm=1 tr=0 ts=698072b6 cx=c_pps
 a=mhBramkM2YKFwkQI7AGxcA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=M5GUcnROAAAA:8 a=g8kJ_gb0AAAA:8 a=20KFwNOVAAAA:8
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8 a=pGLkceISAAAA:8
 a=6g9ZoisztaecFTe_7f0A:9 a=lqcHg5cX4UMA:10 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=ecSNLfPMzbq-p5zXJZOg:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-ORIG-GUID: N0iSGfHqURhVWJavHkHvQGXyPmeLL9b1
X-Proofpoint-GUID: a8fbqlAbU4znxQszWv9SItPS2d0XOw5I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA4NCBTYWx0ZWRfX+4XfecF6x+8x
 M9LUhd8mN/CReI+FhjM3RkgnyP7j/YgOh1vPkaq7Be3OvZWud12Fgw4bP7URhu7gun2q+827d/1
 0N7wrbML9gK7t12+8lOgsBbstfMGw7zf2cVev2lXPoJnpPWBaJ7WMGi5LhNe7w0Cwnn55Bay7Ll
 TUtGLTuG+Tjmx8mLerd413hscfJPZhNZI81tpgjqF+yws17p8SnM/E50hKOUhwjInHLg819GP/v
 9jd2XW6Sqfnyd6cFWuDZNbGQQIeKx5xtjAZlFI1mTaeLWATjPivKkVIzQ+J4+Flk1rKrz5spqSe
 LV0QvhTLmZF2JaWEs69FxH7P5kCImH6Pd9VtfaPhOvk7pyi2koR+tKtEcGsxDUsAyp3t++bwWqJ
 kjht73gFmze1eset729xpR0Bdem2DRZldity/m9WDsg6ZyxE38QK2B+QMLM2EYfmacHGbRGXTUt
 7v51LqkBjumtoy/zUjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255807-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email,marvell.com:email,marvell.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enachman@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8FFEBCA42B
X-Rspamd-Action: no action

>=20
>=20
> From: Alok Tiwari <alok.a.tiwari@oracle.com>
> Sent: Monday, February 2, 2026 7:28 AM
> To: Taras Chornyi [C] <tchornyi@marvell.com>; Volodymyr Mytnyk [C] <vmytn=
yk@marvell.com>; Yevhen Orlov <yevhen.orlov@plvision.eu>; Vadym Kochan [C] =
<vkochan@marvell.com>; Taras Chornyi <taras.chornyi@plvision.eu>; pabeni@re=
dhat.com; kuba@kernel.org; edumazet@google.com; davem@davemloft.net; andrew=
+netdev@lunn.ch; netdev@vger.kernel.org
> Cc: alok.a.tiwarilinux@gmail.com; alok.a.tiwari@oracle.com
> Subject: [EXTERNAL] [PATCH net-next] net: marvell: prestera: fix FEC erro=
r message for SFP ports
>=20
>=20
> In prestera_ethtool_set_fecparam(), the error message is opposite of
> the condition checking PRESTERA_PORT_TCVR_SFP. FEC configuration is
> not allowed on SFP ports, but the message says "non-SFP ports", which
> does not match the condition.
>=20
> Fix the message to match the condition.
>=20
> Signed-off-by: Alok Tiwari <mailto:alok.a.tiwari@oracle.com>
> ---
>  drivers/net/ethernet/marvell/prestera/prestera_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_ethtool.c b/d=
rivers/net/ethernet/marvell/prestera/prestera_ethtool.c
> index 2f52daba58e6..a259da9f30f4 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera_ethtool.c
> +++ b/drivers/net/ethernet/marvell/prestera/prestera_ethtool.c
> @@ -718,7 +718,7 @@ static int prestera_ethtool_set_fecparam(struct net_d=
evice *dev,
>  	}
>=20
>  	if (port->caps.transceiver =3D=3D PRESTERA_PORT_TCVR_SFP) {
> -		netdev_err(dev, "FEC set is not allowed on non-SFP ports\n");
> +		netdev_err(dev, "FEC set is not allowed on SFP ports\n");
>  		return -EINVAL;
>  	}
>=20
> --
> 2.50.1
>=20
>

Acked-by: Elad Nachman <enachman@marvell.com>

