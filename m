Return-Path: <netdev+bounces-104779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A9890E551
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 10:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D28AA281092
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 08:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4996D78C66;
	Wed, 19 Jun 2024 08:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VkxFORow";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="BkwRTjDd"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6A6763FD;
	Wed, 19 Jun 2024 08:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718784816; cv=fail; b=a20BNicoB4xXpO6Dmk/mXbmoJhuYGdZhQkyMOu1sgU2Mbjivg/1Kb6IWy03lcP0wSale9nhlVFyat3s21GxT3zJjnvLuWeQ4ZT2Je8lpRJzOnpFEc4t5T5BdBY7x+Y3ecUCqQGxbN2xAks1lKQr/t9fIVN4TJEx1GpVcdq7oqWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718784816; c=relaxed/simple;
	bh=XRE+yhwyr8uiCusShz81D+xg5dFdKNhlTxH02oUF9+A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=odARD8SQJr1aS5v5omg2Ibnz3xd/H/7VX/4lLXTKpWI8dxPaqen0Ixk9BdwRQcabLHjLuGfQTr9PjaC3dKCy3qDcRlR1BkH4kpInFP8rNNlSh9cWnzKMSph4hE+Q+QJQ/RePVnmrTOomZtieKhhdejU9ylCmumLRHpx5UHlCeqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=VkxFORow; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=BkwRTjDd; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cdf3924c2e1311efa54bbfbb386b949c-20240619
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=XRE+yhwyr8uiCusShz81D+xg5dFdKNhlTxH02oUF9+A=;
	b=VkxFORowiEMgpUNaaje2AprYhS3Rq+PU+sLqZUP024yTqPiXA4Xg6QnKskZKvp/53eUXN+8AD7W90qqXrPEMWHIYSwH3qpSLgLkwCmjJ23NwHnXdADa3SAuqUft2OqvrT7L7/8aFAuYtKUx8YHvxmawe6bw6EmLo0+LWgdOrp9g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:ba6ed10d-f0cd-44ab-8ade-a7ccd16561a5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:d912c344-4544-4d06-b2b2-d7e12813c598,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: cdf3924c2e1311efa54bbfbb386b949c-20240619
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1477256017; Wed, 19 Jun 2024 16:13:26 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 19 Jun 2024 16:13:25 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 19 Jun 2024 16:13:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H98AF+o4N2DFa+ORAEpdZZWoEveCJvSdPJ+C6pCzmwrM3RVXzroDQ2iSTmLz1nr1XeNSnYIBaYWKjh6S4mz3BO8y4Vpu2hS2VfrTs1D32zgKVWAuq5E+/BFEbwBV5Clkj6as32FJ0ekL3RwyyOlaVkByVTq/TlyF9DLptnFCZ6Ez0r8xK5LVwutKllpeFmjQdJMKCv4PcCUySLPmg8PtUNBjcpzfdsenYfHBJ8xqvYdfQazyTyfNheYo4ZH/KuMbLJj2SghsUzycb0/U/gvqRwnp8O2fk5HKZBubKPGli+ODaeb3vDUT5DJDmoGAiKqmXM3obd/GddarNs9ZwxML/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRE+yhwyr8uiCusShz81D+xg5dFdKNhlTxH02oUF9+A=;
 b=LGz1Hok9/Zx0kQloSQnfrum0A2YMxiwbPRpoGdoLot7LS6WVJ3F3qx7ZxOeMJokKQr604nsnb9lyy/XezDCYcFBnO6C44CW1eq6pucxwvP4AQgUhcOsehNHxxUDc0GWsJFsFjFoibTu/3k3xmcVna/vPw4iRLgPL9i3Qvl7xi0Md/UP9Soxh9K0RCrR7KNc+5Uv0ul/qhd8gQxAoSZGWFpJHTm4mZmgw5CCc2vl7lILeSp3+Hxft08JScAfOeknKr5d2ZvGu+wahkFNxLqaqK9KTheEKph+4GhngexwvS3leF170S/GE/FIOdlBCqBW4mlVow88NNhzRNa+d8EQhYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRE+yhwyr8uiCusShz81D+xg5dFdKNhlTxH02oUF9+A=;
 b=BkwRTjDdZ/60IPrTh5BIYDa7cLGprLvz8zN8CXBv9EBi5TYjl5si9TazNSdnBFsDaxuefmFNd2b1iGWJtL+2CpPKqgGCUdN37DhRp0WPUQy+JYJJFBmnSx73j+L59+7fqJnA2uMFdBOeRgVjcfvvx+mi69KjtNZAbv8o7h6g1DQ=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by KL1PR03MB6898.apcprd03.prod.outlook.com (2603:1096:820:9d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 08:13:23 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%5]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 08:13:23 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "horms@kernel.org" <horms@kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next v7 2/5] net: phy: mediatek: Move LED and
 read/write page helper functions into mtk phy lib
Thread-Topic: [PATCH net-next v7 2/5] net: phy: mediatek: Move LED and
 read/write page helper functions into mtk phy lib
Thread-Index: AQHavX543grjkC4X80W7mzpSDXaiMLHL3mcAgALnr4A=
Date: Wed, 19 Jun 2024 08:13:23 +0000
Message-ID: <5d5d5044093d9b6fd9bffdb01a0afe59259c54bb.camel@mediatek.com>
References: <20240613104023.13044-1-SkyLake.Huang@mediatek.com>
	 <20240613104023.13044-3-SkyLake.Huang@mediatek.com>
	 <20240617115132.GR8447@kernel.org>
In-Reply-To: <20240617115132.GR8447@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|KL1PR03MB6898:EE_
x-ms-office365-filtering-correlation-id: e0b43dfe-732d-4e77-6858-08dc9037b03e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|7416011|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?YVh2UU5yRHp0N1R6MzNMSm1JSzFOTVp1VWZrWlphVWlUWVBUQVV3V2lqOHBp?=
 =?utf-8?B?TmdCWk5taHdQZFhMaWEvMForTmVPK2kxdmVMTWZNNTRQaE16ekVmMy9Qc3VP?=
 =?utf-8?B?YyswdlFjZU9ISFVleUUvT2ZXZVdTMGtUcHM4V2lkUUJmKzJkdzBGMnM2cmxL?=
 =?utf-8?B?VVVEdVVGS2ZpWWFhb3JxTWk3Ymk5S1BKTzhETG4zK3hZeTRJMnFCbExYYmpi?=
 =?utf-8?B?UGRDeWlobGg4ZXIvcHNJendUaHd1ZUc2N2hNaW5CUzJSRVB6MUxQUTh2RkM0?=
 =?utf-8?B?dFRVQ1B3NzlhWSsyZ3Z3WFhjTCs4UUtPU003REZCUVlVYUN1clVrY0trTjRY?=
 =?utf-8?B?OGxYWGRlbTcxNEp3U0kyQTZIa1JJYUFwVlZpWVhkeXlralNodXBYWGREQVk0?=
 =?utf-8?B?VGZJK2NoK3JlejBsd3d0VDdkTElDTkM3bGluS09maXJkcitNeDUzV0J5T0ZX?=
 =?utf-8?B?TWNQQk1hc0gwU0JRZnpVUCs5ZUZ0clpBcW8xM0pJS2ViZ2FOc3JyRzUrWitp?=
 =?utf-8?B?WEhpUWpDb1BDQUJZczYvQnpDcVBXODFmM3A3Z1E1TVg1eFVjMkdMUXd1VlJM?=
 =?utf-8?B?RDFVYzgvb0NPSVF2VzRpK0lXanlGM1BKKzVHYStjblpOeGpSZ09KZXMvN3Mx?=
 =?utf-8?B?ZlJLd1JKSW9XTEw3UmxTdTA2bEtBK2ZLYWVVOC9vWUF5NjN2ZjludnFZbjN2?=
 =?utf-8?B?VGNXWjJOZ3BYb3Y1ODJUU25vZys1bkMycld4LzdCdmY1ZTJqM2J0cHlpYWYw?=
 =?utf-8?B?UFdqWE4wN243eHR3VmxNTU84a0t4SHBVUGEzUWpYNFQyaFlib0ROTmJNNE1q?=
 =?utf-8?B?d2IzL0tmRjJKb0F1b2JPeG1LTnhRamVMM0l0cVFKL0J3SzZGUUJiZTZUcjgy?=
 =?utf-8?B?U0dza09sS2ViRWJGTFpoTmtHR284YjlzWDY2UVhzcnU0Rmd4M2RpcXdHVnV3?=
 =?utf-8?B?OFJtR01sOHRUWW1EbkNtek1DRDBJeFp1WUlBY3ducllJejBaYXBVUjdTQkJm?=
 =?utf-8?B?M25WQlVabTRXNWxyblBDYUJRN01rMGR0YjQybGt3d3hGMWdRWEo3d0UrdFVn?=
 =?utf-8?B?QVpGSVh2bGZyR1JBNW5iRHYzbk5Ba1B0QjJMTFJYbFZDZmtBcmhWZ3pJbW45?=
 =?utf-8?B?Vk1xT2RLODJTZnpUMkpZZ1ZhNVAyYW5ya2FXbldqTGxPNnZHaDNmN3RHbWZO?=
 =?utf-8?B?RytOaTB3djZSN1YwdnJrTnRQLzl4cFN6c3hVL01iZ3JxUjlNNUk4UWUyWVc5?=
 =?utf-8?B?MkE5MHZ0RHNRdWc4Yk5QcCtxNXM5Z0ZEZkIyQ05tWE5MTVY5eHgyTkJqczUv?=
 =?utf-8?B?NXZNK0E1V2UrUUdpQm5XK21Uc3pwNHZMazM1U0RJaXl0eUZMaXJieGMwVGlw?=
 =?utf-8?B?b3NTUFAxNnd5U2ZoS3llQkIxYm4xZXlDdTNsaGllMDAvcjBURXRiV2luWEpj?=
 =?utf-8?B?ZWZpcFVJYXVka0pwZDlFT1hYMVBwSVBnTEtLYTVKL3RycUJLOTVXdFZFSU5v?=
 =?utf-8?B?WDhSSVcrZW9MeTAyMWxraGk5U2dNdVpGV1p3dFI2dFdzUFRsN2hEYldjVm5j?=
 =?utf-8?B?NkJScFE3MjNoOFhGOFNoSUlaSjArRFdJRzBXYXFrTlc1OW9taHVOZUh4REZy?=
 =?utf-8?B?YXNlV2lsMlpqWTNDc0ZhY2h4ZU5UcmY1QUhWZnBCdm5QamVaUXUyeDFndnRx?=
 =?utf-8?B?RDliTGswV2Fkc2k1UWI5aVVSNWRxc216NEw3Vm5SSEFFV3NmRjg2aDJYSXF1?=
 =?utf-8?Q?vrcIbQbJuZruRpakcfpIwJjRQhMK9nBEi2t1KvX?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(1800799021)(366013)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHpYdGVYRkcvQlE2eHhNREF0azYvdmgyMDc0MW1zVXNKUjhaUkZHK09PN2gz?=
 =?utf-8?B?dllkL1J6R041RHo4bE41aHZTd3BXc0RHVXVMWmJsZnZydlJ5WDBRekRtUVdH?=
 =?utf-8?B?citkMVdmZUorKzR3RjBuS1g2c0lMQ1htSlRnZ2prYXNLNHdocnQ2OGhoYjJj?=
 =?utf-8?B?eE1NdWQ3bzdIakpvRkJzWk5QVmwrTmFDQlpLRXEvZkRpeXpVRHlZQnZSWE5G?=
 =?utf-8?B?VzljTzJlTVJoWG43UlQ2cEhrYitzc3hiRi9hZzVuNjhic3BqVjNlVUgxK00x?=
 =?utf-8?B?OXNSUExIV2VKaGErME5BV1dwdS84QkJDeHpxTVZxUGhKN0lTcTQvN0Fvd2NU?=
 =?utf-8?B?SnVDSjFKZFc3RzNlZXNsTjJqcVF0emVPL3pxdDhTRHhORzJyMzlPTWZndmRI?=
 =?utf-8?B?eEFRdmVJOFQ1QUdtMmlqL041WlU4RmJXVkU1VncwelVVWk9HVjJ1Q3JkMTh1?=
 =?utf-8?B?ZXRsVTFEV2RHdkF1U21pTlRORXhqYkxPTzBWaEV2bitGdFlaVlUxd0FobTRp?=
 =?utf-8?B?a0JweTRpZHkzVjBJMnpLS1d2dm5yTU1oRWVLSW9HWGVkMDRyUWVyTzQzRjcr?=
 =?utf-8?B?S1p4ZkgwZmh2UUdCaG1HVkVydlRkcVlGZUp3RFc3cmJrVEk4L2lKOGJhektO?=
 =?utf-8?B?Y205L3AvVVhOUEduRm1uZkh1NW5KVTJwa2xSNDhSUFJkNDRXWng5eGU5N0hJ?=
 =?utf-8?B?SXhzZ3Q2Yno2bFd0bkx2SE94bEtkc0I0TGpDYXpNV2l1TUVaWUU2cTF1bUt6?=
 =?utf-8?B?YVZsK0tJVmxGY3pySmRPVFdwVUtzTG9jbVR5MStWaUQrZ1BpOVVQR3MrT2VZ?=
 =?utf-8?B?ZFp2UHNUKzBOT2ZabDFEK0N1SGxpQSt4VFNzM2c1Y3REbm02UXZMdWtRYXJO?=
 =?utf-8?B?WXpudXpKNlZaRDkxbHEzTmJGY2ZULzBTYUI2QlhNMk5uSzFjVlArakxreW9I?=
 =?utf-8?B?TW5KZnVvRFpSazZOUmlwNS94eDVwbzNXRkxVMFpLZlBISkt5eGd3aXRxZEZx?=
 =?utf-8?B?MXFSSWZOb2hOV29JOFN5Q1ArVE1ITVRmaWZwZEZkeFFkUkpRR1E3eXBkMXg5?=
 =?utf-8?B?ZnptTnQvdVBvOUNBY1k4L3pVeFFPdU41bWtWUk5WeVVmall2S0xkUHpqTmFT?=
 =?utf-8?B?Q2JDSnkvYTRWK2VWcTNHT0RxOXpJVFBLRVh2VTc3bndNeHdWSWRrNkNOblRX?=
 =?utf-8?B?L3dTMmNxRHljd2lXSlJYemJyQ3RxZHJ5dGJWaEFuSTZKS1pjeWFOc2ZCVUxV?=
 =?utf-8?B?ZFRxWUdqTTZnTEhnRGFkNGN1ZFBmTXVad0dHQ0dOc2IyTFM5ZFpBcUZNL01p?=
 =?utf-8?B?SkNZU0NIdmZqd0JOaDhZdVJVYk9DbERiMVNBUjJBTUEvSTBjTXQrajZ4SkNY?=
 =?utf-8?B?SDl4QTlhNWJRdWZBNUk5SlVlNTVYc3g3WlNCd2RDU0d0cjZyc3ljYXJTL0Ra?=
 =?utf-8?B?a1JsaTFMdGxZdkducXppM0tsV205aWJYVStnTzZkRXRQZlhuTldUNlZVZzlI?=
 =?utf-8?B?NUp5WGtHaWFvbWVoYWxHbERNbGRNcFo5dWswN1ZmWFNkeU14UklpaXlmL1ky?=
 =?utf-8?B?MFVSUkk4L2g4UXZEUnJhTEhjVWRzVVYrMjZ0MlMwRWN3VmI0cVIrOW83YjA0?=
 =?utf-8?B?QnBma1U4SmpBRTR2TE5vb0N2ajRud3NLMGJUVDRJWm1xLzNiMVJHcmR1eEli?=
 =?utf-8?B?dVVCRmZpQmRhTFdTa25KeUxqMFZhWHk1Nkg3cGl0em1ZZWJKZWVpbStEMWVs?=
 =?utf-8?B?N1MzMzFIN282WURyNjRDaHg0NWt3Rk5lc2l5eTluSHVRb2Z6ZkRQK0dGQndq?=
 =?utf-8?B?enpVRU54eTVyVDhDUHBXVkp5SmtIY3Z0UjJlSkxJaGl3S2IwaUNxTklqOGlZ?=
 =?utf-8?B?dDY5aVdmclcxTnRQSlFWc1YvTXlkTXg1eXZHUGpwSjFyamI0OWZaT3RmTWRa?=
 =?utf-8?B?YWxKQi85S2dteUgvM0F6SS9nNmFFWDY0eTR3NDNRUUwyNHNaaGRoS1BaVkNs?=
 =?utf-8?B?a0FUM2pKMGlzamkydHRxQjIvTHdQYVlQYjViQnJXcmkvY3JrRUJUVlhhVVQ2?=
 =?utf-8?B?MzVSelcxRWNjbFZyQjBENnIwSkVSWE9EMWRIckZ2NjZMa0VNU0lNeWVtVFc0?=
 =?utf-8?B?VGJqNnA5OWJ1UENvVUxUVWhqWWhlWjhLQ3FGZGcxbWZKYkRyYmg0TUtuMVIz?=
 =?utf-8?B?TWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36BA33AAE6DCBE49B65C7D8E3F128C0E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b43dfe-732d-4e77-6858-08dc9037b03e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 08:13:23.4232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VVfH3RoRxp/S3trgYQy5UaLoAjr3KPDYno0Ve+b52MlE/PMS9Va6BR0ZUtFi/Nl+TP1r3PYMwXeOMB7QtMrLPxiEWLwGBMLUt1s/hhQBmKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6898

T24gTW9uLCAyMDI0LTA2LTE3IGF0IDEyOjUxICswMTAwLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgT24gVGh1LCBKdW4gMTMsIDIwMjQgYXQgMDY6NDA6MjBQTSArMDgwMCwg
U2t5IEh1YW5nIHdyb3RlOg0KPiA+IEZyb206ICJTa3lMYWtlLkh1YW5nIiA8c2t5bGFrZS5odWFu
Z0BtZWRpYXRlay5jb20+DQo+ID4gDQo+ID4gVGhpcyBwYXRjaCBtb3ZlcyBtdGstZ2Utc29jLmMn
cyBMRUQgY29kZSBpbnRvIG10ayBwaHkgbGliLiBXZQ0KPiA+IGNhbiB1c2UgdGhvc2UgaGVscGVy
IGZ1bmN0aW9ucyBpbiBtdGstZ2UuYyBhcyB3ZWxsLiBUaGF0IGlzIHRvDQo+ID4gc2F5LCB3ZSBo
YXZlIGFsbW9zdCB0aGUgc2FtZSBIVyBMRUQgY29udHJvbGxlciBkZXNpZ24gaW4NCj4gPiBtdDc1
MzAvbXQ3NTMxL210Nzk4MS9tdDc5ODgncyBHaWdhIGV0aGVybmV0IHBoeS4NCj4gPiANCj4gPiBB
bHNvIGludGVncmF0ZSByZWFkL3dyaXRlIHBhZ2VzIGludG8gb25lIGhlbHBlciBmdW5jdGlvbi4g
VGhleQ0KPiA+IGFyZSBiYXNpY2FsbHkgdGhlIHNhbWUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogU2t5TGFrZS5IdWFuZyA8c2t5bGFrZS5odWFuZ0BtZWRpYXRlay5jb20+DQo+IA0KPiAuLi4N
Cj4gDQo+ID4gIHN0YXRpYyBpbnQgbXQ3OTh4X3BoeV9sZWRfYmxpbmtfc2V0KHN0cnVjdCBwaHlf
ZGV2aWNlICpwaHlkZXYsIHU4DQo+IGluZGV4LA0KPiA+ICAgICAgdW5zaWduZWQgbG9uZyAqZGVs
YXlfb24sDQo+ID4gICAgICB1bnNpZ25lZCBsb25nICpkZWxheV9vZmYpDQo+ID4gIHsNCj4gPiAg
Ym9vbCBibGlua2luZyA9IGZhbHNlOw0KPiA+ICBpbnQgZXJyID0gMDsNCj4gPiArc3RydWN0IG10
a19zb2NwaHlfcHJpdiAqcHJpdiA9IHBoeWRldi0+cHJpdjsNCj4gDQo+IEhpIFNreSwNCj4gDQo+
IEEgbWlub3Igbml0IGZyb20gbXkgc2lkZS4NCj4gDQo+IElmIHlvdSBuZWVkIHRvIHJlc3BpbiB0
aGlzIHBhdGNoc2V0IGZvciBzb21lIG90aGVyIHJlYXNvbiwgcGxlYXNlDQo+IGNvbnNpZGVyDQo+
IHByZXNlcnZpbmcgcmV2ZXJzZSB4bWFzIHRyZWUgb3JkZXIgLSBsb25nZXN0IGxpbmUgdG8gc2hv
cnRlc3QgLSBpbg0KPiB0aGlzDQo+IGZ1bmN0aW9uLg0KPiANCj4gTGlrZXdpc2UgdGhlcmUgYXJl
IGEgZmV3IG90aGVyIGNoYW5nZXMgaW4gdGhpcyBwYXRjaCB3aGljaCBsb29rIGxpa2UNCj4gdGhl
eQ0KPiBjb3VsZCBiZSB0cml2aWFsbHkgdXBkYXRlZCB0byBwcmVzZXJ2ZSBvciBhZG9wdCByZXZl
cnNlIHhtYXMgdHJlZQ0KPiBvcmRlci4NCj4gDQo+IEVkd2FyZCBDcmVlJ3MgdG9vbCBjYW4gYmUg
b2YgYXNzaXN0YW5jZSBoZXJlOg0KPiBodHRwczovL2dpdGh1Yi5jb20vZWNyZWUtc29sYXJmbGFy
ZS94bWFzdHJlZQ0KPiANCj4gPiAgDQo+ID4gIGlmIChpbmRleCA+IDEpDQo+ID4gIHJldHVybiAt
RUlOVkFMOw0KSGkgU2ltb24sDQogIFRoYW5rcyBmb3IgcmVtaW5kaW5nLiBUaGVyZSBhcmUgc29t
ZSBsZWZ0LW92ZXJzIGluIG1lZGlhdGVrLWdlLXNvYy5jDQpvZiBjdXJyZW50IHZlcnNpb24gb24g
cmV2ZXJzZSBYbWFzIHRyZWUgb3JkZXIuIEkgbWlzc2VkIHRoYXQuIEknbGwNCmNsZWFuIHRoaXMg
dXAgaWYgd2UgbmVlZCB0byByZXNwaW4gbXRrLWdlLXNvYy5jIGFnYWluLg0KDQpCUnMsDQpTa3kN
Cg==

