Return-Path: <netdev+bounces-297635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +j4LBvxGKWrXTQMAu9opvQ
	(envelope-from <netdev+bounces-297635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:14:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A47366689F8
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:14:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=selector1 header.b=KPzsR3ZL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297635-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297635-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A17D306DB04
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104A53FBEB2;
	Wed, 10 Jun 2026 11:09:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A303F822A;
	Wed, 10 Jun 2026 11:09:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781089761; cv=fail; b=ZKd+Z1JLtokhkUT4KQ6MGW2tgb/7v/ENkFF+8E01Giciykg93Qm9JJI4OOgysxN7M2DiEb3c64e4UScgPW0aMWzM/yz1j2IAUWM+odbKC1v+E4WPm2RCoxfFNZ84TBZkrTN9TgrSs3eA2gDy+CCwAutRtrt7W8tNli3lXT0uE2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781089761; c=relaxed/simple;
	bh=inxGX1L9R36Pc1k/dktb2m9Y865tfI69/sAvkR05dCI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZELfaufcXrm6tkgmgpK5/UvUw8APOcnOKmu96wxlv5gfWNOQg+WTVsVdbVMG5Pp5HpZyAqvIdobWCc95weHZU08lWofxVqVd0h0UeWYN6/Z+4lzfygjjDDKbtSOfOBC7K+szYXHWIuvMvh+iIbB3s7zd8Hq0oHxQN2sPVUYGBsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=KPzsR3ZL; arc=fail smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A7klpg2878985;
	Wed, 10 Jun 2026 04:08:55 -0700
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11021122.outbound.protection.outlook.com [40.93.194.122])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eps392qes-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 04:08:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZLNhlXhXlMjSINZoZtkJUTjBsaWHgmuWxx5TXmi2/urfCDLsN+dvWM8s8f6CFK4fxo7jpHNgKXY+fumIdjMdfk6BO1383Jh03/GTxuprUshuaJe7+v1RjP1+ChSSxsyBSYnqQQFMuval+GP+xXDWmngR8tXqrxySKXj7SazzGuucWU5SIK7eZWWRGXBk+b0dixp+5pstbbAcO0ytIxDlAAj8+8NmGkJmLmRZSOWY10Xw3Vjcq1T01oA4LgIKgya29M/wVFk04CVoVk2zZ2PWJJXfY3IZ2rw2tRaMglYxk6Ex5bqwVZzJplHuUlewe44PNk7RoO14XB9PP0Y8ES67w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AolGn3Sg0/EU6m0M+fyPbGXyMorSHdVukVg4cMNf2tw=;
 b=NB0k1gf+U89+2DJCAvpzWBc8Zk5dO+UvjNM/HUHnaCV4TSiXOdW/PagCzOOQNLic0TNKCvpgUrQ3N2LiQEZUS3OMvIE/NIvahOyPp4JuO+YJGkHdOOtwrjDEB8O2s+qV8mMX0JDyOFC10ouqXb7gvHtbalKuJ2GGofe+DBapIjG1Z7CYU0O1m7Du0u9t+7Ohy3tKGWlyJvdTVYdPMa1F/97HzTNYxXbTq7E6DIlKZDh2mjEhPs299HaRGEuSfp0otmnFIjsQwSqygH32ELigIn52oT7YQT4VtDDqSjWucHg4KXuv3ZvDP8JtV4RfDRH/CxbslLzHMtLqfQS/ME0CEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AolGn3Sg0/EU6m0M+fyPbGXyMorSHdVukVg4cMNf2tw=;
 b=KPzsR3ZL4BZUliiyVUvUoTFJBLT5llw/uxufyXqMLncLT87eiit4iOdnllMeTiweEb+HQzjIkmS4rpIXVryvO2bsnV53jyoNsDMwrIOtfuta0UvO8G65Gfuu/LiDgIQWsFoTXsvB/kD06xzH5OO6wmtrAwYrv/7tXVt73bREuK4=
Received: from CO1PR18MB4603.namprd18.prod.outlook.com (2603:10b6:303:e2::19)
 by CO1PR18MB4761.namprd18.prod.outlook.com (2603:10b6:303:e8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 11:08:53 +0000
Received: from CO1PR18MB4603.namprd18.prod.outlook.com
 ([fe80::cb22:ffae:1f3a:af35]) by CO1PR18MB4603.namprd18.prod.outlook.com
 ([fe80::cb22:ffae:1f3a:af35%2]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 11:08:53 +0000
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
Subject: RE: [EXTERNAL] Re: [PATCH net-next v4 12/12] net: atlantic: add
 AQC113 PTP support in aq_ptp and driver core
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v4 12/12] net: atlantic: add
 AQC113 PTP support in aq_ptp and driver core
Thread-Index: AQHc8peWwJ1vZfDPlUO5vd9xfYmsCLYvQ6eAgAgomKA=
Date: Wed, 10 Jun 2026 11:08:53 +0000
Message-ID:
 <CO1PR18MB460377187898920C8168333FBA1A2@CO1PR18MB4603.namprd18.prod.outlook.com>
References: <20260602135452.516-13-sukhdeeps@marvell.com>
 <20260605023841.3629304-1-kuba@kernel.org>
In-Reply-To: <20260605023841.3629304-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4603:EE_|CO1PR18MB4761:EE_
x-ms-office365-filtering-correlation-id: 0af105f6-1a42-45df-e68f-08dec6e0a858
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|56012099006|6133799003|4143699003|22082099003|5023799004|11063799006|18002099003|21046099003|38070700021;
x-microsoft-antispam-message-info:
 XtwKlJ993HFWkxlF66EDCB3wQ4hmred4k4S1IZ6uDELa4zsyhHa3d9FM+xUd7GJJxCXdaf00WeC7iKFsVcivILfBjcOgiQOIhrCbZIXf+as/CCw5f8ipRBcfVFlgJv28o+qo9psCNeDhk5YGUC8KPNjLPp+R1CEzbFMPbtV0s5U8FFe3gGAmMmeEnkplcxw4J4Hm7UdGX/Vc/vqdpMZ8Pf8MLnfHfeYUjhEyvA1b6zTlzIHk98H4ddVWsNisWhf9ow7Xga0r66exQQOpQTfAM0oM5ttnnMnOJMLMniPahq76Oml9SY6WK2J7ZbJzaQAKReTKr9jR419Gu/oMG+XiQDrcgSMobOUb1sCc8ewWWljHGhAHUtEBFgdOqSdlnbqGoKbDvH1uHSKrm6QyCb3Z+PuHp1lKRNThX92dUW6Uc7sTBYt1D9ALXwPsiB66TdmB8g+bsjOyAd/eeIb1B5tNobyUQrUN/aIFVpzW/Ch1LIhtCLiLRf6tMdq7k36KCdJJXU03UTP3v0/wJgOhsgy/zGjfL+CUwwWoHcWgbcv3hGT1hupElhtzRV7LoH95ZSyy6qOebm6CTa+WYmjtSMwbZ7Uqtjtu2359UD0okEHsctVmzfGGPEx6B0q0AEw4NkArwsINix+r+0R3EoDyLJw/ij/dToqkwzhsnEWtSr3iIvc3Fqt+s+o8rhjiQv6TZWexSuRaA2ejn1nqMVkboHkEC6M6lzDwi9z/i3UFW+RYc4ZuSfemoiXIiYtPyN9MWiX5
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4603.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(6133799003)(4143699003)(22082099003)(5023799004)(11063799006)(18002099003)(21046099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tnGilaCLfOS9VfpZeZw9bQznYuebD5Hs9j/+TmX+PsQTq//nS/+YrsYD7wcW?=
 =?us-ascii?Q?g6myZk3rxhxaxMTEz+61YrnsjOFKyiaw1Sz/VrhDKPCtfBmIgzx938nK2lGp?=
 =?us-ascii?Q?cFpNVOWzGfs+RR/9pgKMY9zRW8st9Eyzd9xPT/FSt8yVv62Oo1m3QdwKEHbI?=
 =?us-ascii?Q?N7WI91HBHjT7xZMy2AHoHlnz9Oifxu+uLOON8zb0QGZ89BiBCg5v6jzEQxzs?=
 =?us-ascii?Q?flCL7E3tCbTWFU6OrnVsnsYMiXnjRfVLFLlMbcq3Hf0CWYbIpQtDHCb9s0Kh?=
 =?us-ascii?Q?SxcoMxQ6ONUE62iGRKgVxnX7Uqn+eutjVVUpCYY9pt35CtG1YtaV5TMG/+mE?=
 =?us-ascii?Q?+J2lNHkzhTU8P7tselIOKgFshfxmiiNkWPokOHLhl2RaGJYxVWzJabUaFzqD?=
 =?us-ascii?Q?Ii2zk5lpRkOlmuitmIQXDsV/8XKOjTGhHt3KRqpxDC713B/i0eCvhM5zpFCA?=
 =?us-ascii?Q?NEh4gLkI+i1r/VwYG1b+jj/iSOc5GvLtMXaxgygJr7DTtmM4zxlYlPrnbIBR?=
 =?us-ascii?Q?FisntEnOPxOqfDdtqzhiWWREWFAVQk5q5Htl4sQvg3Js3XPphr7E3ORKn9SU?=
 =?us-ascii?Q?le9ULymA71s4UvNsiNtLaoV06vaVS5CNYmF0QYB2y6VsAA738Sc01WUS6GM+?=
 =?us-ascii?Q?5u+OuNZxgb294kPR/ZEkw95RzG6w8kwe4pUu6J5co9N4fr62/kXlpLej8+m6?=
 =?us-ascii?Q?u/kh291VBZTThM9lDy0NBOTBkxsLyIf/WZlHM6kl1ZSEl3HdFEn0n2Kiszwv?=
 =?us-ascii?Q?2GglP65CuxHssZBSnWUAwnCP0Zk2xe5JBcu5Mm1sW4832k9vy85SgKKeUvh2?=
 =?us-ascii?Q?Dvfohq7rgGiI5McmqjbLecoamiKXdGJV6/646kbyttheT//JmnWezexll5Kf?=
 =?us-ascii?Q?+2FvGKfyIx4iw0FcLSKr9GtGtuuBEgzbkD0UUQh6qUrpUAlvnxWt87FloST6?=
 =?us-ascii?Q?k4nmXWZ3Fua1SBr0vRcE5KSNrT+zMpcA3kkWVe9mo8+9zN1jEcZoy/5x5pbq?=
 =?us-ascii?Q?sNnZZ2+Sywkdbbk7Zf8Hzt9DFYA13W5eUHfEJWseMktZtj4b2tJf7UpZ2IRG?=
 =?us-ascii?Q?rZG43AMvlwHnoZOmMd6l5KXRV/x4GlKd1FSiD3MdVSJ4H1w3GD1pNYpztp8+?=
 =?us-ascii?Q?/BwTuVL91O0bChRfriunM+TswfJY+CHI9pTGqqrVz1I4+2RUrQ/TEW8Mc9es?=
 =?us-ascii?Q?nKs/ZlFWq/vrLDg7j05cASA9XbIGZM/QyK+/SBjhsDgvBmqnbh6d2ymA4LBf?=
 =?us-ascii?Q?mwa4AIU13CHuHdhtmk97bPFPeUuBb+WNPRzIDoc0Oqrl1l77Qrkm0ckBTikc?=
 =?us-ascii?Q?ug5Yjryvgk6NO6Je/sk/DPgXsQyWRoQ43nUDfCfz2vtnX8SE+M/W/25JrU7/?=
 =?us-ascii?Q?YQLKUx2RtWrtN32ROEgDh161Wv42a4zKlb5e6epxO/CuVBrICHNH6CZchrTF?=
 =?us-ascii?Q?I2u38JH8EY6SA2QUp5Y5spmwhDTCKyl0n/rFd5qrh8Dhs44Fm+Jg3QEymWSZ?=
 =?us-ascii?Q?QoV2fT62g44okpITNeqoOncZ8emHUV5jDzsiTWbPhKbVtPadtwO52okOeJ5C?=
 =?us-ascii?Q?bZLZoSoAUb7tjm8V6NRTYnErmS7BdQUUhP5WXBjiQkB5uuccokob2kyxfGuf?=
 =?us-ascii?Q?K/yyREbeOP64Aq77LHLDN9rZc9eYkEDRhUoRGm4rPt7sO2gEjvZjc9hAngK6?=
 =?us-ascii?Q?7iNJ7v5u8HBvIi9NvWKa/9lwXyNX7hQ3F0DHcpUJguim/nL8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	FHwX9GYInQdwH2Pre0N3B7jTm/nnxkFptLSTgOJYdwY8myl2y+ISiIisWdX8hxIe44LwbASQPH1NUwHr/MQ1wTV88rv5P2W3sg6HPACWgBi8stQvg9viknCneaS82kO35HRXvaWvzYdBtl4EZYgUFX3tKYvFHPpCcs5BVxTjbGOp/RsuVqIJv3pdlt8Ifl1iOYdINc16kMkCn8dfkQrT5d89kZLhTLb156EALxQ6e0rZiWmsOWgao+ITycMm0aDlo7Oq5E43qGdQDsCJ/2BWbJ6BEuBSC+PbKfe5HdFALkHOsOfAB7s57ptAiNGsY6zwR0JpE8G5l8zq78CUwItNaA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4603.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af105f6-1a42-45df-e68f-08dec6e0a858
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 11:08:53.2115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ev95SfXeB0y0lPG+aAzlh7DCzsNzqRI5+X4vbPK+G99lCQyNUvDaEb9Z90OTkLubTaWSNsNZoaqeK36Iclhp/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4761
X-Authority-Analysis: v=2.4 cv=KKlqylFo c=1 sm=1 tr=0 ts=6a2945c7 cx=c_pps
 a=CN5Nmbld9GKaZyt1KupX+Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=lRQUk3TTQcJaUSSj:21 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22
 a=ukGG3KgEJo-GP7_XFaMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: ow-oCF3CBi4p5b_ojZPHqobd3KzMEKab
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEwNiBTYWx0ZWRfX5d9L7nGqYzc1
 4jCeTCMGjR/COB0QN3U1a1sEGzHbtuKyuh3MtRTHHPyRehvOZrFtJrqcvSp9wgV6aMK+r42wE0C
 LHIlDk56oER2FgBDHFqXTX8vLb2cWxHQtalUtr8PUcuCT9KhYCMhavmcoZCoXtmbha71DppAIZG
 vfSl5AiScUf+L3um4Q0L53MZwK9ot62iFmp91hYxHDlogFEUC+j/6uvjBKHHhAG2cOkkSxd1NLl
 QRooVsDE5h02n70QaDYVE04mQv0gFULIZ9EfabKN9RGh3ds7pjmIJeziWzKWRZUBftj2zAMhrS3
 2/WLIoXqWXA2KZXO8mmElQrDIkATbvlL9EOxLkndanq+F7Gyklm52G4CeIbhhwN8jDSVwAdxz2h
 5sN9cKWTrdr5iUdGgU6xyUem2heBQWX8cUre7x2BGNGzFjN2qY7sBst7/3QUFED2h9n/N52d9NC
 5UQaVyOC29f7R6ObeqQ==
X-Proofpoint-GUID: ow-oCF3CBi4p5b_ojZPHqobd3KzMEKab
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-297635-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[CO1PR18MB4603.namprd18.prod.outlook.com:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,marvell.com:dkim,marvell.com:from_mime];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A47366689F8

On 4 Jun 2026, Jakub Kicinski wrote:

> net: atlantic: add AQC113 PTP support in aq_ptp and driver core
>
> This patch extends the atlantic driver's PTP support to AQC113 (Antigua)
> hardware: it adds a per-instance PTP offset table, replaces the single
> L3/L4 filter with an array of 4 multicast filter slots, introduces an
> aq_ptp_state enum so link-change events can be distinguished from first
> init, and reworks vector accounting for the new PTP IRQ count.
>
> Thanks for the patch. A few questions follow inline.
>
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/ne=
t/ethernet/aquantia/atlantic/aq_nic.c
> index 09c90c969fb1..d6cb2c509950 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
>
> [ ... ]
>
> @@ -172,7 +180,11 @@ static int aq_nic_update_link_status(struct aq_nic_s=
 *self)
>  		aq_nic_update_interrupt_moderation_settings(self);
> =20
>  		if (self->aq_ptp) {
> -			aq_ptp_clock_init(self);
> +			/* PTP does not work in some modes even if physical link is up */
> +			bool ptp_link_good =3D (self->aq_hw->aq_link_status.mbps >=3D 100 &&
> +					      self->aq_hw->aq_link_status.full_duplex);
> +
> +			aq_ptp_clock_init(self, ptp_link_good ? AQ_PTP_LINK_UP : AQ_PTP_NO_LI=
NK);
>
> [Low]
> Could the comment here be expanded to record which modes are
> unsupported and why?  PTP is silently disabled below 100 Mbps and for
> any half-duplex configuration, but the predicate has no reference to a
> datasheet section, errata, or test result, so a future maintainer adding
> a new link speed cannot validate or update it.

The comment is taken from the vendor reference driver. The predicate itself
(mbps >=3D 100 && full_duplex) is self-documenting. Without a specific data=
sheet
section reference we would be guessing at the rationale, which risks mislea=
ding
future maintainers more than the current terse comment does.

>  			aq_ptp_tm_offset_set(self,
>  					     self->aq_hw->aq_link_status.mbps);
>  			aq_ptp_link_change(self);
>
> [ ... ]
>
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c b/drivers/ne=
t/ethernet/aquantia/atlantic/aq_ptp.c
> index 7486a28d7ff8..3ebd5e66ca2d 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
>
> [ ... ]
>
> +static int aq_ptp_add_a2_filter(struct aq_ptp_s *aq_ptp,
> +				struct ethtool_rx_flow_spec *fsp,
> +				int *flt_idx)
> +{
> +	struct aq_nic_s *aq_nic =3D aq_ptp->aq_nic;
> +	int err;
> +
> +	err =3D aq_set_data_fl3l4(fsp,
> +				&aq_ptp->udp_filter[*flt_idx],
> +				aq_ptp->udp_filter[*flt_idx].location,
> +				true);
> +	if (!err) {
> +		netdev_dbg(aq_nic->ndev,
> +			   "PTP MC filter prepared. Loc: %x\n",
> +			   aq_ptp->udp_filter[*flt_idx].location);
> +		(*flt_idx)++;
> +	}
> +	return err;
> +}
>
> [Low]
> Can aq_set_data_fl3l4() ever return non-zero?  Looking at its body it
> has only one return statement at the end returning 0, which means the
> caller's "UDPv4/UDPv6 filter prepare failed" debug paths and the
> flt_idx++ guard here are unreachable.  Was the helper expected to
> validate input (e.g., bad ring_cookie or oversized fields) and reject
> it?

Fixed - aq_set_data_fl3l4() always returns 0 so the if (!err) guard and
"filter prepare failed" debug paths were dead code. aq_ptp_add_a2_filter()
is now void, flt_idx is incremented unconditionally, and all four call site=
s are
simplified accordingly.

> +
> +static int aq_ptp_dpath_enable(struct aq_ptp_s *aq_ptp,
> +			       int enable_flags, u16 rx_queue)
> +{
>
> [ ... ]
>
> +	if (enable_flags) {
> +		/* Clear all existing L4 filters before applying new config */
> +		for (i =3D 0; i < PTP_UDP_FILTERS_CNT; i++) {
> +			aq_ptp->udp_filter[i].cmd &=3D
> +				~HW_ATL_RX_ENABLE_FLTR_L3L4;
> +			if (hw_ops->hw_filter_l3l4_set) {
> +				err =3D hw_ops->hw_filter_l3l4_set(aq_nic->aq_hw,
> +						&aq_ptp->udp_filter[i]);
> +				if (err)
> +					netdev_dbg(aq_nic->ndev,
> +						   "Set UDP filter failed\n");
> +			}
> +		}
>
> [Medium]
> Can this loop hide partial failures?  err is overwritten by every
> iteration, so if filter[0] or filter[1] fail to clear but filter[3]
> succeeds, err is reset to 0 by the last call and the function continues
> on to program new filters on top of a partially-stale slot table with
> no signal to the caller.
>=20
> [ ... ]

The continuing-on-error pattern in the clear loop is intentional and matche=
s
the vendor reference driver. For filter disable/clear operations, stopping =
on the
first error would leave subsequent hardware slots in an unknown state. Cont=
inuing
and clearing all slots - even if some fail - is preferable to leaving a par=
tially-stale table.
The netdev_dbg on each failure makes individual failures observable. The ca=
ller receives
the last iteration's error, which is a known limitation shared with the ref=
erence driver.

> +	} else {
> +		/* PTP disabled, clear all UDP/L2 filters */
> +		for (i =3D 0; i < PTP_UDP_FILTERS_CNT; i++) {
> +			aq_ptp->udp_filter[i].cmd &=3D
> +				~HW_ATL_RX_ENABLE_FLTR_L3L4;
> +			if (hw_ops->hw_filter_l3l4_set) {
> +				err =3D hw_ops->hw_filter_l3l4_set(aq_nic->aq_hw,
> +						&aq_ptp->udp_filter[i]);
> +				if (err)
> +					netdev_dbg(aq_nic->ndev,
> +						   "Set UDP filter failed\n");
> +			}
> +		}
> +
> +		if (!err && hw_ops->hw_filter_l2_clear)
> +			err =3D hw_ops->hw_filter_l2_clear(aq_nic->aq_hw,
> +						&aq_ptp->eth_type_filter);
> +	}
> +
> +	return err;
> +}
>
> [Medium]
> Same pattern repeats here on the disable path: an early failing slot is
> masked by a later successful one, so the function can return success
> while leaving the L3/L4 slot table partially programmed.
>
> [ ... ]

Same rationale as above - the reference driver uses the same continue-on-er=
ror
pattern for the disable path. Clearing all slots even on partial failure is=
 preferable
to leaving stale entries. This is a known limitation shared with the vendor
reference driver.

>  int aq_ptp_hwtstamp_config_set(struct aq_ptp_s *aq_ptp,
>  			       struct kernel_hwtstamp_config *config)
>  {
> +	unsigned int ptp_en_flags =3D aq_ptp_parse_rx_filters(config->rx_filter=
);
>  	struct aq_nic_s *aq_nic =3D aq_ptp->aq_nic;
> -	const struct aq_hw_ops *hw_ops;
>  	int err =3D 0;
> =20
> -	hw_ops =3D aq_nic->aq_hw_ops;
> -	if (config->tx_type =3D=3D HWTSTAMP_TX_ON ||
> -	    config->rx_filter =3D=3D HWTSTAMP_FILTER_PTP_V2_EVENT) {
> -		aq_ptp_prepare_filters(aq_ptp);
> -		if (hw_ops->hw_filter_l3l4_set) {
> -			err =3D hw_ops->hw_filter_l3l4_set(aq_nic->aq_hw,
> -							 &aq_ptp->udp_filter);
> -		}
> -		if (!err && hw_ops->hw_filter_l2_set) {
> -			err =3D hw_ops->hw_filter_l2_set(aq_nic->aq_hw,
> -						       &aq_ptp->eth_type_filter);
> -		}
> +	if (aq_ptp->hwtstamp_config.rx_filter !=3D config->rx_filter) {
> +		mutex_lock(&aq_ptp->ptp_filter_lock);
> +		err =3D aq_ptp_dpath_enable(aq_ptp,
> +					  ptp_en_flags,
> +					  aq_ptp->ptp_rx.idx);
> +		if (!err)
> +			aq_ptp->hwtstamp_config =3D *config;
> +		mutex_unlock(&aq_ptp->ptp_filter_lock);
> +	}
> +
> +	if (ptp_en_flags !=3D AQ_HW_PTP_DISABLE)
>  		aq_utils_obj_set(&aq_nic->flags, AQ_NIC_PTP_DPATH_UP);
> -	} else {
> -		aq_ptp->udp_filter.cmd &=3D ~HW_ATL_RX_ENABLE_FLTR_L3L4;
> -		if (hw_ops->hw_filter_l3l4_set) {
> -			err =3D hw_ops->hw_filter_l3l4_set(aq_nic->aq_hw,
> -							 &aq_ptp->udp_filter);
> -		}
> -		if (!err && hw_ops->hw_filter_l2_clear) {
> -			err =3D hw_ops->hw_filter_l2_clear(aq_nic->aq_hw,
> -							&aq_ptp->eth_type_filter);
> -		}
> +	else
>  		aq_utils_obj_clear(&aq_nic->flags, AQ_NIC_PTP_DPATH_UP);
> -	}
> =20
>  	if (err)
>  		return -EREMOTEIO;
> =20
> -	aq_ptp->hwtstamp_config =3D *config;
> -
>  	return 0;
>  }
>
> [High]
> Can changes to tx_type now be silently lost?  The pre-patch code
> unconditionally cached the new config on success.  The new code only
> writes aq_ptp->hwtstamp_config when rx_filter changed:
>
>    if (aq_ptp->hwtstamp_config.rx_filter !=3D config->rx_filter) {
>        ...
>        if (!err)
>            aq_ptp->hwtstamp_config =3D *config;
>        ...
>    }
>
> A user calling SIOCSHWTSTAMP with the same rx_filter but a different
> tx_type (for example flipping HWTSTAMP_TX_ON) gets a return of 0, but
> the new tx_type is never stored, so a follow-up SIOCGHWTSTAMP returns
> the stale prior value.
>
> [High]
> Does TX-only HW timestamping still work after this change?  Previously
> "tx_type =3D=3D HWTSTAMP_TX_ON" alone was enough to install filters and
> assert AQ_NIC_PTP_DPATH_UP.  After the patch, AQ_NIC_PTP_DPATH_UP is
> driven solely by aq_ptp_parse_rx_filters(config->rx_filter), so a
> request with rx_filter=3DNONE and tx_type=3DON no longer raises that flag=
.
>
> aq_ndev_start_xmit() in aq_main.c gates its PTP TX redirection on
> AQ_NIC_PTP_DPATH_UP, so PTP TX frames are no longer diverted to the PTP
> TX ring, and TX hardware timestamping silently breaks in TX-only mode.

Both issues are already addressed:

   1. tx_type silently lost: Fixed - aq_ptp->hwtstamp_config =3D
      *config is now unconditional after the error check, saving all config
      changes including tx_type.
  2. TX-only mode: The reference driver has the same behaviour - AQ_NIC_PTP=
_DPATH_UP
      is driven solely by ptp_en_flags from aq_ptp_parse_rx_filters(). TX-o=
nly timestamping
      without an RX filter is not a supported mode in this hardware design;=
 the PTP data path
      requires RX filters to be active. This matches the vendor reference d=
river.

> [Medium]
> Can the rx_filter compare race against itself?  The check
>
>    if (aq_ptp->hwtstamp_config.rx_filter !=3D config->rx_filter)
>
> is performed without holding ptp_filter_lock, while the same field is
> written under the lock further down in this function and read by
> aq_ptp_clock_init() on the link-change path.

The compare is performed inside ptp_filter_lock - the ock is acquired befor=
e
the check, so concurrent hwtstamp_config_set calls
are serialized. The race with aq_ptp_clock_init() on the link-change path i=
s
the same pattern as the vendor reference driver which has no lock at all.

> [Medium]
> Is the AQ_NIC_PTP_DPATH_UP update safe outside the lock?  The
> aq_utils_obj_set/clear calls run unconditionally based on the requested
> ptp_en_flags, even when:
>
>  - aq_ptp_dpath_enable() was not invoked at all because rx_filter was
>    unchanged, or
>  - it was invoked but returned an error and hwtstamp_config was
>    therefore not updated.
>
> In the failure case the function still asserts AQ_NIC_PTP_DPATH_UP and
> then returns -EREMOTEIO, so userspace is told the operation failed
> while the global flag claims the datapath is up and steers transmits
> to a PTP ring whose hardware setup may be inconsistent.
>
> [ ... ]

Fixed - aq_utils_obj_set/clear is now moved after the if (err) return -EREM=
OTEIO
check, so AQ_NIC_PTP_DPATH_UP is only updated when aq_ptp_dpath_enable()
succeeded.

> -void aq_ptp_clock_init(struct aq_nic_s *aq_nic)
> +void aq_ptp_clock_init(struct aq_nic_s *aq_nic, enum aq_ptp_state state)
>  {
>  	struct aq_ptp_s *aq_ptp =3D aq_nic->aq_ptp;
> -	struct timespec64 ts;
> =20
> -	ktime_get_real_ts64(&ts);
> -	aq_ptp_settime(&aq_ptp->ptp_info, &ts);
> +	if (!aq_ptp)
> +		return;
> +
> +	if (aq_ptp->a1_ptp || state =3D=3D AQ_PTP_FIRST_INIT) {
> +		struct timespec64 ts;
> +
> +		ktime_get_real_ts64(&ts);
> +		aq_ptp_settime(&aq_ptp->ptp_info, &ts);
> +	}
> +
> +	if (!aq_ptp->a1_ptp && state !=3D AQ_PTP_FIRST_INIT) {
> +		unsigned int ptp_en_flags =3D
> +			aq_ptp_parse_rx_filters(state =3D=3D AQ_PTP_LINK_UP ?
> +						aq_ptp->hwtstamp_config.rx_filter :
> +						HWTSTAMP_FILTER_NONE);
> +		mutex_lock(&aq_ptp->ptp_filter_lock);
> +		aq_ptp_dpath_enable(aq_ptp, ptp_en_flags, aq_ptp->ptp_rx.idx);
> +		mutex_unlock(&aq_ptp->ptp_filter_lock);
> +	}
>  }
>
> [Medium]
> Should the read of aq_ptp->hwtstamp_config.rx_filter happen inside
> ptp_filter_lock?  The field is sampled here without holding the lock,
> then the lock is acquired to call aq_ptp_dpath_enable() with the value
> read.  The same field is mutated under the lock by
> aq_ptp_hwtstamp_config_set().
>
> A concurrent SIOCSHWTSTAMP from userspace can race with the link-change
> caller (process context: aq_nic_service_task or
> aq_linkstate_threaded_isr): the link path reads the old rx_filter,
> queues behind the writer for the lock, then applies the old filter set
> to hardware after the writer just installed the new one.
>
> The unlocked read is also a data race per the kernel memory model.

Fixed. The read of hwtstamp_config.rx_filter in aq_ptp_clock_init()
is now performed inside ptp_filter_lock, so the link-change path holds
the lock for the entire read-then-apply sequence. A concurrent
SIOCSHWTSTAMP either completes before the link path reads the field,
or waits until the link path is done - the stale-read window is closed.

> [Medium]
> Is it intentional that the return value of aq_ptp_dpath_enable() is
> discarded here?  The commit message says this path exists to "Re-apply
> RX filters on link change (hardware state lost after reset)", so a
> silent failure means PTP RX timestamping is silently broken across the
> link change.
>
> aq_ptp_hwtstamp_config_set() captures and propagates the same return
> value, so the asymmetry looks like an oversight.
>
> [ ... ]

Not an oversight. The return value is checked and a netdev_warn is emitted
on failure, so a filter restore failure on link change is visible in the ke=
rnel log.
The function cannot propagate the error to a caller here since aq_ptp_clock=
_init()
returns void - logging is the appropriate action for a link-change path.

> -int aq_ptp_init(struct aq_nic_s *aq_nic, unsigned int idx_vec)
> +int aq_ptp_init(struct aq_nic_s *aq_nic, unsigned int idx_ptp_vec)
>  {
>
> [ ... ]
>
>  	aq_ptp->aq_nic =3D aq_nic;
>  	aq_ptp->a1_ptp =3D a1_ptp;
> +	aq_ptp->a2_ptp =3D a2_ptp;
> =20
>  	spin_lock_init(&aq_ptp->ptp_lock);
>  	spin_lock_init(&aq_ptp->ptp_ring_lock);
> +	mutex_init(&aq_ptp->ptp_filter_lock);
> =20
> +	aq_ptp_offset_init(aq_ptp, &mbox.info.ptp_offset);
>
> [ ... ]
>
> -	aq_ptp->idx_vector =3D idx_vec;
> +	aq_ptp->idx_ptp_vector =3D idx_ptp_vec;
> =20
>  	aq_nic->aq_ptp =3D aq_ptp;
> =20
>  	/* enable ptp counter */
> +	aq_ptp->ptp_clock_sel =3D ATL_TSG_CLOCK_SEL_0;
>  	aq_utils_obj_set(&aq_nic->aq_hw->flags, AQ_HW_PTP_AVAILABLE);
> -	mutex_lock(&aq_nic->fwreq_mutex);
> -	aq_nic->aq_fw_ops->enable_ptp(aq_nic->aq_hw, 1);
> -	aq_ptp_clock_init(aq_nic);
> -	mutex_unlock(&aq_nic->fwreq_mutex);
> +	if (a1_ptp) {
> +		mutex_lock(&aq_nic->fwreq_mutex);
> +		aq_nic->aq_fw_ops->enable_ptp(aq_nic->aq_hw, 1);
> +		mutex_unlock(&aq_nic->fwreq_mutex);
> +	}
> +	if (a2_ptp)
> +		aq_nic->aq_hw_ops->enable_ptp(aq_nic->aq_hw, aq_ptp->ptp_clock_sel, 1)=
;
> =20
>  	INIT_DELAYED_WORK(&aq_ptp->poll_sync, &aq_ptp_poll_sync_work_cb);
>  	aq_ptp->eth_type_filter.location =3D
> -			aq_nic_reserve_filter(aq_nic, aq_rx_filter_ethertype);
> -	aq_ptp->udp_filter.location =3D
> +		aq_nic_reserve_filter(aq_nic, aq_rx_filter_ethertype);
> +
> +	for (i =3D 0; i < PTP_UDP_FILTERS_CNT; i++) {
> +		aq_ptp->udp_filter[i].location =3D
>  			aq_nic_reserve_filter(aq_nic, aq_rx_filter_l3l4);
> +	}
> +
> +	aq_ptp_clock_init(aq_nic, AQ_PTP_FIRST_INIT);
>
> [Low]
> Should the TSG clock be initialized with wall-clock time before it is
> started?  On AQC113 the call sequence is:
>
>    aq_nic->aq_hw_ops->enable_ptp(aq_nic->aq_hw, aq_ptp->ptp_clock_sel, 1)=
;
>    ...
>    aq_ptp_clock_init(aq_nic, AQ_PTP_FIRST_INIT);
>
> hw_atl2_enable_ptp(self, 0, 1) zeroes the TSG counter and starts it,
> while aq_ptp_clock_init(AQ_PTP_FIRST_INIT) is the only path that calls
> aq_ptp_settime() to load wall-clock time.  Between these two steps the
> TSG clock is freely incrementing from zero with AQ_HW_PTP_AVAILABLE
> already set and aq_nic->aq_ptp already published, so a concurrent
> reader observes an enabled-but-uninitialized clock returning a near-
> zero value.

TSG clock started before wall-clock time: The reference driver has the iden=
tical
sequence - enable_ptp before aq_ptp_clock_init. This is an inherent initial=
ization
window that exists in all PTP hardware drivers. The near-zero timestamp win=
dow
is brief and ptp4l handles clock startup gracefully.

> [Medium]
> On AQC107 (a1_ptp), only a single L3/L4 filter is ever programmed in
> aq_ptp_dpath_enable() (the a1_ptp branch installs one UDPv4 filter and
> increments flt_idx once), but this loop reserves PTP_UDP_FILTERS_CNT
> =3D=3D 4 slots on every chip:
>
>    for (i =3D 0; i < PTP_UDP_FILTERS_CNT; i++) {
>        aq_ptp->udp_filter[i].location =3D
>            aq_nic_reserve_filter(aq_nic, aq_rx_filter_l3l4);
>    }
>
> The L3/L4 slot pool has eight entries
> (AQ_RX_LAST_LOC_FL3L4 - AQ_RX_FIRST_LOC_FL3L4 + 1).  Reserving four
> instead of one on AQC107 reduces user-visible ethtool ntuple ring-
> cookie capacity from seven to four.  Could the reservation count be
> gated on a2_ptp?

AQC107 reserves 4 L3/L4 slots: The reference driver uses the same
PTP_UDP_FILTERS_CNT loop for all chip variants. Gating on a2_ptp is a
reasonable optimization but is out of scope for this series. We will note
it for a follow-up.

> [Low]
> Is the publication order of aq_nic->aq_ptp and AQ_HW_PTP_AVAILABLE
> intentional?
>
>    aq_nic->aq_ptp =3D aq_ptp;
>    ...
>    aq_utils_obj_set(&aq_nic->aq_hw->flags, AQ_HW_PTP_AVAILABLE);
>    ...
>    INIT_DELAYED_WORK(&aq_ptp->poll_sync, ...);
>    aq_ptp->eth_type_filter.location =3D ...;
>    for (i =3D 0; i < PTP_UDP_FILTERS_CNT; i++)
>        aq_ptp->udp_filter[i].location =3D ...;
>
> The pointer and the global flag are exposed several statements before
> INIT_DELAYED_WORK and before filter slot reservations.  Any future
> error-recovery rollback that calls aq_ptp_free() on a partially-
> initialized aq_ptp will run cancel_delayed_work_sync() on an
> uninitialized struct delayed_work.
>
> =20
>  	return 0;
> =20
> @@ -1244,30 +1533,45 @@ void aq_ptp_unregister(struct aq_nic_s *aq_nic)
>
> [ ... ]

Publication order of aq_ptp and AQ_HW_PTP_AVAILABLE: The reference driver
has the identical ordering. The cancel_delayed_work_sync() concern is a fut=
ure
hypothetical - there is no error-recovery rollback path in the current code=
 that
calls aq_ptp_free() on a partially-initialized struct. The ordering is inte=
ntional
and matches the reference driver.

>  void aq_ptp_free(struct aq_nic_s *aq_nic)
>  {
>  	struct aq_ptp_s *aq_ptp =3D aq_nic->aq_ptp;
> +	int i;
> =20
>  	if (!aq_ptp)
>  		return;
>
> [ ... ]
>
>  	kfree(aq_ptp->ptp_info.pin_config);
> +	aq_ptp->ptp_info.pin_config =3D NULL;
> =20
>  	netif_napi_del(&aq_ptp->napi);
>  	kfree(aq_ptp);
> +	aq_utils_obj_clear(&aq_nic->aq_hw->flags, AQ_HW_PTP_AVAILABLE);
>  	aq_nic->aq_ptp =3D NULL;
>  }
>
> [Low]
> A few small issues in this teardown:
>
>  - kfree(aq_ptp) is called before aq_nic->aq_ptp =3D NULL, leaving
>    aq_nic->aq_ptp dangling for the duration of the
>    aq_utils_obj_clear() call between them.
>
>  - mutex_destroy(&aq_ptp->ptp_filter_lock) is missing before kfree;
>    CONFIG_DEBUG_MUTEXES would have caught this.

Fixed both points. mutex_destroy(&aq_ptp->ptp_filter_lock) is now called
before kfree, and the teardown order is corrected: AQ_HW_PTP_AVAILABLE
is cleared and aq_nic->aq_ptp is set to NULL before kfree(aq_ptp), eliminat=
ing
the dangling pointer window.


