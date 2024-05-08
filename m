Return-Path: <netdev+bounces-94502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 018E58BFB5E
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 12:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AADCA2830BC
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 10:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A143A8174C;
	Wed,  8 May 2024 10:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="J3ghOBa1";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="brhTkz2b"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FAB7C085;
	Wed,  8 May 2024 10:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715165805; cv=fail; b=dtvbcKA3k/ogZK5n9d3xA9SFj4hGZIeS9mPNneNke+lSA+wEVPVVssaPEQJmReVL3O6ZdV0J9891ml3PLShSr1LBGV5vjNupxhF5Z891drDZ/9eJs5aM/lrSk/svtbCVA1zbcvyu69PvZa27Yq/ufYWxijd3VCatIYDxz3i+iYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715165805; c=relaxed/simple;
	bh=EpFfPisF9Pq9nm/JzprKmJfqwMsQ3mbpm7/vukj3PEQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LKqPk6x4EiUKcYklwYZkHshqkggncVyeGvQXb3l4CYMqxxCoq2MYeUY2x5A9H5jRpo8c6UobDjkgxIcgoxzc7VtM+8PqK1u4JagcdaO9vgojLFBQeUbOItUnZnen0PGrdd0wH04kEeJGL5gnwcxoLIMFNMVbT9SOG4vkTh3RBsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=J3ghOBa1; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=brhTkz2b; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a0eb80580d2911ef8065b7b53f7091ad-20240508
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=EpFfPisF9Pq9nm/JzprKmJfqwMsQ3mbpm7/vukj3PEQ=;
	b=J3ghOBa1IHQt+ZhnHwP+j7IkOlD9Rpnev+ZiPzmK5JLOuYaIoTvRMBBOsmrHxI1vJ+e6+1Lv8hwH0XSCJeX56RAPtepk2u/kRj4J+Zt8Z+H5IxLT+hhewMPAf7j8ZNT8s+HVRkwvCeNHUVFbG5RYe308xCNE9AyjsWjZa+UwxCk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:04151a24-859d-49b9-b2e6-003177f38aee,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:82c5f88,CLOUDID:8e548192-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: a0eb80580d2911ef8065b7b53f7091ad-20240508
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 635229112; Wed, 08 May 2024 18:56:31 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 8 May 2024 18:56:28 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 8 May 2024 18:56:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlKQ0QlJGhxGAi4Y3G8ki9Q5ziaETdQKSpam/+ngiC7FmKto1Q+sq+3CYFnd56zUcKY9Ad8IH+0ItWhmwjmO70ppbRv06Myl6nNXXDpyZwqpQCIfpQ6TIb68rwyVzgXnNhPUv/WS105sI5LnxDqiC0SpZ0XlF8wBcA79A1wuY3SumGs8Kp2tUIudZwpkjI72r2QwZA85Cgziw3AgKVK//C9BGdtMWi7OMZG45O8q0FwncMOh11YmrivFC7X+i/6CffxRVPt8WJCkXtjx1eTWb5fGcjgX9WkL8Qy6Ja0EMdLAxIHP2MJathnkZTJYdU838rRhJUoQ2AAt3vl2bevvOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpFfPisF9Pq9nm/JzprKmJfqwMsQ3mbpm7/vukj3PEQ=;
 b=QfsV/gnSjTKaFm/f/ULNNf0sWwZGgRKisojCfaRKInKZUOUgW9X/NbfgqKpxlcvl0FRiMhc28DkzQy8RA46oSJfoNEGRld7yAEHALkked0QoDicomkUHwgHcKhAwQjclmbC56f24yK6tNHMde6qwmv/l0jN5tIZs3m/ZcxfEzyocpo0+wIeLVr/RHVvw4Ggn2hWvE9IAmVGfMbzOUkQ9/XZENy9k9CnlmfUn65hr7rrKwArsxr82QAaeC+qXH0eFrdjlNpHJxJx0PvjMIdEioqZkiQdQmc2ZBj+6lUXD/HDfhYvg+Sk7b+4rkRxMpme2kvBG7osT7fK5iRvhiSD5ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpFfPisF9Pq9nm/JzprKmJfqwMsQ3mbpm7/vukj3PEQ=;
 b=brhTkz2bPRPmS8Xw5sjZETqakutoTsVDvPX1cvT56XoiIEHHPZzHD/YdLQCZQ+HnZzX6iGgU2pQP+BncJRIK6TjXu9+rGhBL3h53EzLX/PknDUYVnhC12UDxC51lY1/Pz+op4O8AsK4QDfTs0H8RcJXG5SPpKTbc/anu0awdKN4=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by SEZPR03MB6764.apcprd03.prod.outlook.com (2603:1096:101:67::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 10:56:26 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::5c9b:e435:35b5:8871]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::5c9b:e435:35b5:8871%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 10:56:25 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 3/3] net: phy: mediatek: add support for built-in 2.5G
 ethernet PHY on MT7988
Thread-Topic: [PATCH 3/3] net: phy: mediatek: add support for built-in 2.5G
 ethernet PHY on MT7988
Thread-Index: AQHalrke9MXYYy54CkKXxHycrZR1mrF4sQIAgBSORoA=
Date: Wed, 8 May 2024 10:56:25 +0000
Message-ID: <4ccd437ee744382a8483ffe71d06cd495dacec71.camel@mediatek.com>
References: <20240425023325.15586-1-SkyLake.Huang@mediatek.com>
	 <20240425023325.15586-4-SkyLake.Huang@mediatek.com>
	 <ZiocBmBWiNnbeyGq@shell.armlinux.org.uk>
In-Reply-To: <ZiocBmBWiNnbeyGq@shell.armlinux.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|SEZPR03MB6764:EE_
x-ms-office365-filtering-correlation-id: c7a0f886-06bf-47c3-bbcf-08dc6f4d817e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?UWxuSlZqcm1IZFRndms4RitDQTVTMGo2Rm41WjBGMFR0NDdTLzh4T0U3dTBz?=
 =?utf-8?B?VzU4YmQ0QUtNM1B6N2RZbFhjTGZHU1V3aTF3VEFUcFFQSjdKWFBYZWlVZThE?=
 =?utf-8?B?Y3ZMeTRwc3pTNUM1QTJEZytXVnlGamhVQ3FhTVo2KzJMWXFmZTE3endQUks1?=
 =?utf-8?B?aFJTc2NwL2VkUjBSaTcwYnBWVHFUbWdYdFVudjVhTkpXcVJrVFQxdnpwSnpS?=
 =?utf-8?B?akhhYmlJa2ZpUlN1VVIxMFlhckNBUTFXVEVTeW11bmJUTmR6VkRtWHd2cTVU?=
 =?utf-8?B?R1YwdnJLUVg2VVBIeFRDaXg0YjBoMnRmRjh5cGhDS3pJNm5Hb2Mvb0hqSFFj?=
 =?utf-8?B?RnJRVWRlODZPdE4yZnBtZFp1eXVYUzU5d0Mya3pCSWJlalNzM3B1NnQ3bjVY?=
 =?utf-8?B?YkJkTHB6djlZUDVQREJvcnRJek9RYWkvVCtHWktkallsN3lLbWNGV0MwLzRh?=
 =?utf-8?B?UEcvaEo3TzR1b3pqSXZBVkJrWWg2MERtWFpySTJnTHJnVHlIdnp0elQ3TlUv?=
 =?utf-8?B?eWswU1A0ODRHTkZROGtmbmo4aFQ2QTAxOHRMR25DNEtDZTFuSzFkR0ZCbjRN?=
 =?utf-8?B?bmhCWVN1MmNyN2F1SDN3U095VzNhVFRERWxzUTdNb1hhRHFMQS9kbHR5R3RR?=
 =?utf-8?B?a3ZnMjh0U1lYOERPK0FPbDd3b3B0QzcyMTVBVUJmVU4vMU12UXVwcjNnNXVV?=
 =?utf-8?B?aGFtRGUrUjlmWWh4RHR1MmFxQVhyd3lLMFp6bDRIMXYrWkNBQWIzYUdTZWNT?=
 =?utf-8?B?cWh0TE9GRWkzaW12clFZN0l6NEFxcW9CaVRUVjVBc2NEVkFoNm0yakxjRWlN?=
 =?utf-8?B?bUJ0NGVrNW11UGtKR0x5WG5ZK3Z4UEVON1JGTXVrcE1ZUnk3TEJFR0d4UjZt?=
 =?utf-8?B?cmttcmVzZnlHYnJydDZwYzBJVVVXRGNIaC9tQ3dkQVZYMXlZeDdlZDJJUERP?=
 =?utf-8?B?eFByOEllNGRJdmlsOXh0d0tGWWYrTEt0a1g4eE1nbzVYcEdrVi95ZTdjaWVW?=
 =?utf-8?B?N25NdGRXS3lBOGNyaGJCcnRxbmYySURRbmh0UXQ1VU5NK1oxWHcycmp6eVNs?=
 =?utf-8?B?WGMxcDVoM3RPTmUxWDhnMGQ1OXJ0S29CdXA3S2Q2NDFjY2VCM2RKR1d2MXQ2?=
 =?utf-8?B?RzRKOHF4N1NPemFod21rZjZLZXZwKzN2b0FSRmZucjJydHR6Ukg4SE9mZHky?=
 =?utf-8?B?ZEQ0TFNBS2VyNXc0R3lST1VNQjNlMHdiQmE1Z2JKOHd0YTQxK3h1K2ZaeG1P?=
 =?utf-8?B?Q3NJZERyY2NIMlUwMEh0MFNDVmxKS1YwbCtJTzFHeVBiMEN4aWQwUW1SSVFY?=
 =?utf-8?B?TU43ZGM5M1pxMGQxdlJaUGpRSjFkSStjUEEyV0wybVE2dzdLU25peHgvZ21I?=
 =?utf-8?B?Z3NUUmZjdzFnaWE4WkV0VW81WVFOSFpLczFJc3IyTnltRWFaVzFZZ2cxaE1L?=
 =?utf-8?B?ejJEOEFoOXVhSUhaaHJpcUgyVnM1VDBxVnpERXZNMDNOOEZkVXdNVnJlbVNG?=
 =?utf-8?B?ZlZtYWtQclFyWTEwN3lLMWRvMGdWaXFpSmpRdUdVLzg4RkdZWUZWYWllK3lB?=
 =?utf-8?B?S2cwNWJnNWh6WDFpZ0hIUXB4eWlyOEk4dkxpVXA1V3daYkRRYTNBSmJTU0Yv?=
 =?utf-8?B?bFNRb2RHcm5XbGozMTkxUjJmdldveVVFb1NEaDliTVdVNldhVzRXOWJYNGw3?=
 =?utf-8?B?OG14QzhiRk1YUjJ6MDNGamhNSFdHalppM3RmN3p6Z25MWE14ak9PbEV3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXgxSC9pWklYLzVzcDNDN2RjakZVQTlYdi9HVU9jb1dRS3cwbmYyL1lZSnpB?=
 =?utf-8?B?WllZR3BxSkdJL2c0eitFMFhLQ250THlxbFlLR0cxdmFSRTZzdStLMFNrNG1K?=
 =?utf-8?B?K28ydlREZW5HZWVNRFRHdmxzTHg1RVJOUDdCL2VjcE9yK0ZxdktIMnNWdVJX?=
 =?utf-8?B?d2NQY1cwaXBQd3RhN2xteXBoREk5dXdpSHZodk9oSkh0WlBrRGVDZm5QdzAw?=
 =?utf-8?B?OXFUcXpRalpZeFJLdjdLbHFmeEtrVlNTOHkrZEdtL1YyY3Y5UUloejlBWjA0?=
 =?utf-8?B?Q3JHUnROSm85MHk0WFhUak51Z0dieWNPTWFvWlBXaEo2b0pyZklVZjdrNmtS?=
 =?utf-8?B?UUpMWE1lNmdKaFV1RElOOWdrZm11SzVnTGhzTXdHWTlyQVJ5WFlnT3NNQjRR?=
 =?utf-8?B?QzJLRnNpWW1TMUU2YXVqeURtMzdlZzllWjVzbis0MmFqNCtuQVNocnNJaUsv?=
 =?utf-8?B?RmFmbUh5R1lTd3p5amlpNG1WNi96MVgrcmVOTlVRN0JHSHVZWTZzMnpmdzhk?=
 =?utf-8?B?ZURZZzBSWjRHZDBsczZYSm56SzhqZ05mSFh1a2dOSUpqY3QvV2xBVnlMcXIx?=
 =?utf-8?B?SFdoVUdFVkdYUDhiL1NLcGg4d09YZEhnbjI4bmRGZEtseHR6aS9mbmhmbG5Y?=
 =?utf-8?B?dmxsUHcramd6TGE0RnBzbnBNd0pqZDFMeEhwd2lnaUs0ZWE2dTNnSXZZN2cr?=
 =?utf-8?B?WTYwODlwZmVtd2RFNnFvT2F0NmdyS1hGRzNaM01CMkpkUWhIRzByRk9VeVdm?=
 =?utf-8?B?OHJpTTZPdHg3d3pyRXVhVUV1akNYVm5QUjBwMFZhbDdFMGdHbEk0WXZURnBY?=
 =?utf-8?B?Z2JhaC9rNGh3YmJjR2xJU29LQVhhSWhxTi9YYm9PVXd4dUxuS2pubnN1Q3Bm?=
 =?utf-8?B?cW1rSjVjcStOSVJBY2lVOHlGaVlJRHFtVnF2am9xNmRsdTFGcFlLSUM3VUs4?=
 =?utf-8?B?VVc5MWJueHdXVHFFbDJnVXZUb1VPSk9zdmFZOGtqaEhQMkFDeGNKeWN6RWRG?=
 =?utf-8?B?UmcybEhjNkwvVWIxakFBK1BlM1RlUkJJQlpxbzRFeG1SMEUxK0kweTU4WG9x?=
 =?utf-8?B?SS9hNkM5VXorYnNLN3cxbDcrWS9pbkhTeWs1eG5EWGRrV3ppckt3N01IcWFk?=
 =?utf-8?B?aTFEM2ROZHk5eWhQV2dqTG1ZOGxJS0gyUDQ2a3Z1ejJkM2h1eTROcVpJSyt3?=
 =?utf-8?B?Y3lQYUJZR3FUdUh3MWYyVU42S3c2MFVGMTNFTFBNTXZXZE5XZXUwSm1Salk3?=
 =?utf-8?B?Ukt5WUwrb01GSTFkVUFyRURjWHRTRG5BV3NMWVFYZnl2cVhKMTU3Tlgzd0Zx?=
 =?utf-8?B?VWFTbXFnWklzYkkxSWsyMGdzak5TSFJ2TUZ3RzQxUlBXU2JtV0NRbmtLNCtl?=
 =?utf-8?B?K3JHNEJFcGdXWHFaMWpJcUl0b29yU0ptbSt2RWpKL0RncmlxKzJRdkV5WFlR?=
 =?utf-8?B?dk5DdVpzOHBDWWVXSFBGM24yeHB2SnRVVTZ4eTlUZmJyTjFJOW9FQ2hXb2Vn?=
 =?utf-8?B?ekl0THJJVTR6YmtDalpVMWNFbXdRRDZibU9WVzNYM3d0cU16RDVVbjFiNlIz?=
 =?utf-8?B?UGxzcUFqTitjaGdyR2lhSVhCYWxhNHJEQUlsdDhoSmJJWFl6ejJGUkxJaWVr?=
 =?utf-8?B?UnNSZ1pxT3MvcGZ4QXMyYmlIejY1bzR6TS90N0VLdnQyK0J6Qkl2QzdkdDNo?=
 =?utf-8?B?Z1Ywc1pkKzYwQ2dxRUdLcnVuOENpWS9yTVM0cGRQaWEwcGsycUhQTnE0Wkw5?=
 =?utf-8?B?akxhd0JZbzd0T21URXh6dkNNa3Y4UzNDaEUxbkRXWHJtOGFMcklkT1EyMGVD?=
 =?utf-8?B?YTZ4R3VrUGFaaXVEc2JMZEhGS2RnR2JSZ2VvQ2xOcE5yYnhiQytvbmdEMGlo?=
 =?utf-8?B?dlYwYitPb3JrdVhneXhyWVdDajhLNngyNHRMdGJNT0JReTVlN3V3TWFtbHJX?=
 =?utf-8?B?ajZjZ3RSa1JBb0h4U1pUTk01ZjZBaDZFL2FyNGcyaEFaM2MzYU1xK2tDTGI0?=
 =?utf-8?B?eEFJRXFSUG9ONVowcGdyUmhkSS9WSUNmNkYvQ0puN2syY2RUYlQxMXluTjFJ?=
 =?utf-8?B?Y0EvTVZ2ZlVWZEsrM0plUS9za1FNb1dWSmI4Ykl2Z0wzei91T1daVHArNTN4?=
 =?utf-8?B?OXRlWk1LTmkyL1JRNEhobE5BUGZEWEx6VlR0S1R3Q1lCekxnU3J5cWZIZjYw?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72DF443B033BD94195C25AE71EF6F5E6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a0f886-06bf-47c3-bbcf-08dc6f4d817e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 10:56:25.5112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4OHvNoH9Okxs1c1X8v+EIVsrJksng/GfCq/gCLzffF3QIIF2iAjhMcv7/ADbKwYScivmGX1cnP4UVRsUIfddP1kmgpSUQnWB9CfMuEUoduc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6764
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--27.248200-8.000000
X-TMASE-MatchedRID: 6E41RGmUyPrUL3YCMmnG4j/bje4fv8tVq/HFNJkJHyMNcckEPxfz2DEU
	xl1gE1bkfdd9BtGlLLzx1uczIHKx54/qvvWxLCnegOqr/r0d+CwjRLEQhrITC5722hDqHosTkmi
	3zE7HIvlX6UIPOG+iLf7mPzHkYf6Z8ZTibkDR5X1NI82n17+7UxSRa9qpSosf1updbK8gT4HVjy
	JHFzru4eDAL60xjtvIzY7fTHE4UVCF3ycRlH+Eg935+5/2Rxqm1y6uJbbZR/8UtdRZTmEaIX9MU
	W3noMgm+VR0Qdjw4GE8MXho6UtjB1vQ2lxoUSXg4ATm0fvouhl9LQinZ4QefKU8D0b0qFy9suf7
	RWbvUtyrusVRy4an8bxAi7jPoeEQftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--27.248200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	D54FBFC0E0E89A175C15274EFB613A2639747F47519BADB7FAB57338E7528B132000:8

T24gVGh1LCAyMDI0LTA0LTI1IGF0IDEwOjAxICswMTAwLCBSdXNzZWxsIEtpbmcgKE9yYWNsZSkg
d3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2Vu
ZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgT24gVGh1LCBBcHIgMjUsIDIwMjQgYXQgMTA6MzM6MjVB
TSArMDgwMCwgU2t5IEh1YW5nIHdyb3RlOg0KPiA+ICtzdGF0aWMgaW50IG10Nzk4OF8ycDVnZV9w
aHlfY29uZmlnX2luaXQoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldikNCj4gPiArew0KPiA+ICtp
bnQgcmV0LCBpOw0KPiA+ICtjb25zdCBzdHJ1Y3QgZmlybXdhcmUgKmZ3Ow0KPiA+ICtzdHJ1Y3Qg
ZGV2aWNlICpkZXYgPSAmcGh5ZGV2LT5tZGlvLmRldjsNCj4gPiArc3RydWN0IGRldmljZV9ub2Rl
ICpucDsNCj4gPiArdm9pZCBfX2lvbWVtICpwbWJfYWRkcjsNCj4gPiArdm9pZCBfX2lvbWVtICpt
ZDMyX2VuX2NmZ19iYXNlOw0KPiA+ICtzdHJ1Y3QgbXRrX2kycDVnZV9waHlfcHJpdiAqcHJpdiA9
IHBoeWRldi0+cHJpdjsNCj4gPiArdTE2IHJlZzsNCj4gPiArc3RydWN0IHBpbmN0cmwgKnBpbmN0
cmw7DQo+ID4gKw0KPiA+ICtpZiAoIXByaXYtPmZ3X2xvYWRlZCkgew0KPiA+ICtucCA9IG9mX2Zp
bmRfY29tcGF0aWJsZV9ub2RlKE5VTEwsIE5VTEwsICJtZWRpYXRlaywycDVncGh5LWZ3Iik7DQo+
ID4gK2lmICghbnApDQo+ID4gK3JldHVybiAtRU5PRU5UOw0KPiA+ICtwbWJfYWRkciA9IG9mX2lv
bWFwKG5wLCAwKTsNCj4gPiAraWYgKCFwbWJfYWRkcikNCj4gPiArcmV0dXJuIC1FTk9NRU07DQo+
ID4gK21kMzJfZW5fY2ZnX2Jhc2UgPSBvZl9pb21hcChucCwgMSk7DQo+ID4gK2lmICghbWQzMl9l
bl9jZmdfYmFzZSkNCj4gPiArcmV0dXJuIC1FTk9NRU07DQo+IA0KPiBXb3VsZG4ndCBpdCBiZSBi
ZXR0ZXIgdG8gZG8gdGhpcyBpbiB0aGUgcHJvYmUgZnVuY3Rpb24gcmF0aGVyIHRoYW4NCj4gaGVy
ZT8NCj4gDQpBZ3JlZS4gSSdsbCBtb3ZlIHRoaXMgdG8gcHJvYmUgZnVuY3Rpb24gaW4gdjIuDQoN
Cj4gPiArDQo+ID4gK3JldCA9IHJlcXVlc3RfZmlybXdhcmUoJmZ3LCBNVDc5ODhfMlA1R0VfUE1C
LCBkZXYpOw0KPiA+ICtpZiAocmV0KSB7DQo+ID4gK2Rldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGxv
YWQgZmlybXdhcmU6ICVzLCByZXQ6ICVkXG4iLA0KPiA+ICtNVDc5ODhfMlA1R0VfUE1CLCByZXQp
Ow0KPiA+ICtyZXR1cm4gcmV0Ow0KPiA+ICt9DQo+IA0KPiBUaGlzIHdpbGwgYmxvY2sgZm9yIHVz
ZXJzcGFjZSB3aGlsZSBob2xkaW5nIHBoeWRldi0+bG9jayBhbmQgdGhlDQo+IFJUTkwuDQo+IFRo
YXQgYmxvY2tzIG11Y2ggb2YgdGhlIG5ldHdvcmtpbmcgQVBJcywgd2hpY2ggaXMgbm90IGEgZ29v
ZCBpZGVhLiBJZg0KPiB5b3UgaGF2ZSBhIG51bWJlciBvZiB0aGVzZSBQSFlzLCB0aGVuIHRoZSBS
VE5MIHdpbGwgc2VyaWFsaXNlIHRoZQ0KPiBsb2FkaW5nIG9mIGZpcm13YXJlLg0KPiANCkknbSBu
b3Qgc3VyZSBJIHJlYWxseSBnZXQgdGhpcy4gTVQ3OTg4J3MgaW50ZXJuYWwgMi41R3BoeSBpcyBi
dWlsdA0KaW5zaWRlIFNvQy4gV2Ugd29uJ3QgaGF2ZSBhIG51bWJlciBvZiB0aGVzZSBQSFlzLg0K
DQo+ID4gKw0KPiA+ICtyZWcgPSByZWFkdyhtZDMyX2VuX2NmZ19iYXNlKTsNCj4gPiAraWYgKHJl
ZyAmIE1EMzJfRU4pIHsNCj4gPiArcGh5X3NldF9iaXRzKHBoeWRldiwgMCwgQklUKDE1KSk7DQo+
IA0KPiBUaGlzIGlzIHByb2JhYmx5IHRoZSBCTUNSLCBzbyBpZiBpdCBpcywgcGxlYXNlIHVzZSB0
aGUgZXN0YWJsaXNoZWQNCj4gZGVmaW5pdGlvbnMuDQo+IA0KPiA+ICt1c2xlZXBfcmFuZ2UoMTAw
MDAsIDExMDAwKTsNCj4gPiArfQ0KPiA+ICtwaHlfc2V0X2JpdHMocGh5ZGV2LCAwLCBCSVQoMTEp
KTsNCj4gDQo+IFRoaXMgYWxzbyBsb29rcyBsaWtlIGl0J3MgcHJvYmFibHkgdGhlIEJNQ1IuDQo+
IA0KPiA+ICsNCj4gPiArLyogV3JpdGUgbWFnaWMgbnVtYmVyIHRvIHNhZmVseSBzdGFsbCBNQ1Ug
Ki8NCj4gPiArcGh5X3dyaXRlX21tZChwaHlkZXYsIE1ESU9fTU1EX1ZFTkQxLCAweDgwMGUsIDB4
MTEwMCk7DQo+ID4gK3BoeV93cml0ZV9tbWQocGh5ZGV2LCBNRElPX01NRF9WRU5EMSwgMHg4MDBm
LCAweDAwZGYpOw0KPiA+ICsNCj4gPiArZm9yIChpID0gMDsgaSA8IGZ3LT5zaXplIC0gMTsgaSAr
PSA0KQ0KPiA+ICt3cml0ZWwoKigodWludDMyX3QgKikoZnctPmRhdGEgKyBpKSksIHBtYl9hZGRy
ICsgaSk7DQo+ID4gK3JlbGVhc2VfZmlybXdhcmUoZncpOw0KPiA+ICsNCj4gPiArd3JpdGV3KHJl
ZyAmIH5NRDMyX0VOLCBtZDMyX2VuX2NmZ19iYXNlKTsNCj4gPiArd3JpdGV3KHJlZyB8IE1EMzJf
RU4sIG1kMzJfZW5fY2ZnX2Jhc2UpOw0KPiA+ICtwaHlfc2V0X2JpdHMocGh5ZGV2LCAwLCBCSVQo
MTUpKTsNCj4gDQo+IEFuZCBhbHNvIHByb2JhYmx5IHRoZSBCTUNSLg0KPiANClRoYW5rcy4gSSds
bCBjaGFuZ2UgdGhlc2UgdG8gY29ycmVzcG9uZGluZyBCTUNSIGRlZmluaXRpb25zIGluIHYyLg0K
DQo+IC0tIA0KPiBSTUsncyBQYXRjaCBzeXN0ZW06IGh0dHBzOi8vd3d3LmFybWxpbnV4Lm9yZy51
ay9kZXZlbG9wZXIvcGF0Y2hlcy8NCj4gRlRUUCBpcyBoZXJlISA4ME1icHMgZG93biAxME1icHMg
dXAuIERlY2VudCBjb25uZWN0aXZpdHkgYXQgbGFzdCENCg==

