Return-Path: <netdev+bounces-105113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8486B90FBF8
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 06:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71AAA1C22A2B
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 04:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D158B219F3;
	Thu, 20 Jun 2024 04:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VmD0PcFb";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="c0Bahb7X"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D01386;
	Thu, 20 Jun 2024 04:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718857959; cv=fail; b=OijqijGZBvEsikjTQGmBg2Olsghcj60fwVV80eHG0IJ6TuswyOVK44LsPBvlIvkqEP/fK7MIHO5FoC73bWCuefojwTv2UigFjCV3/3pSQetiwn7aCiIHTr6kIDeHW2TjJseH4iLYXljJ1XyiC/eGUn90amMZI1aM2xuC+O404Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718857959; c=relaxed/simple;
	bh=MiRmki6VpCKkv9qWau3uOREQXdPqiguJ0C7atrmsJLE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CkGNQCWOb2XtQAJVNIB5Hg65wSr7p7dd61ALRBuPaPdpQ06hExKxlnbpDqOusEO1gfdZkBhd8TkHJM5rR4dG35Uw2oNfK9SWUyJhZ1TIdhiUkomT8lsoV0BOIUargMc9IxEMnLPa1SfedgMdbXHnnjckPhmFOMQ6YMJ/yQbZCSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=VmD0PcFb; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=c0Bahb7X; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1af54a7c2ebe11ef99dc3f8fac2c3230-20240620
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=MiRmki6VpCKkv9qWau3uOREQXdPqiguJ0C7atrmsJLE=;
	b=VmD0PcFbAp6K17dSx64KnBvQhrtySxuqFS+B/xFs3/O2Al4FSimMvMDU7fKxUkaZzUh9ZkmCTuIMMuj73+MxRZV5XKa7EYT+wxKz+/4dcGVRJc6EaBoQF8CfB6Md4f4mXSzucqXeKhxadFuYqF+L4V6ui22AIVxIaJHa5RZdjpY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:e0cc9d55-ed46-404b-a654-cd736fe593a3,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:393d96e,CLOUDID:e265cc44-4544-4d06-b2b2-d7e12813c598,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 1af54a7c2ebe11ef99dc3f8fac2c3230-20240620
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1795311865; Thu, 20 Jun 2024 12:32:30 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 19 Jun 2024 21:32:29 -0700
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 20 Jun 2024 12:32:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UI1//ByTqdNiEOZVNztlIcJG7Z0WLInmuaQAR1OFhtsYCVijNeHC9amLfDqgMssC/3hB2WT9WLwAlw1W5TnhJTm2sJ2IfoxNcefjbMEUEHilxXyzEM9T2y19wgDycYE0x4zPYxwoC/TWEUpGdusC0XsNdSgQcGTGGpOQkxSCjMc4Gfb4MtspDqEW0mdsb42dkfzmbYXY3f/A/JPzDDx1SxnYWds7eqNHbB8g25tsFKu+R6LoJ296uCe8oga28BeVcwKSLnmwNdQT2biktR3OJ98EGOzrGN3UrJQgCAzPC/f6FiLxz+bych41N8XD32XSZso9dKJq+wX3gQ04gSNa4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiRmki6VpCKkv9qWau3uOREQXdPqiguJ0C7atrmsJLE=;
 b=ch+9woRezEfOr5DNY5kkn+GAzhkO19ZgNYSjR5ek8+1+5T8l44TOOWDwyFF7LfU04A2usKWcgKEyxq5WawyWjCnKkFOisSaoN1LeW384iW9PVPZIyWg13henTYYHVvkAG+YXpgW39iiIOPu1/Yxjga5rFZVg4n7xPmcW8YByAXcecwsBHjE5QrPW/RGnMyVjxNW6tMYziDRS0LFN+GqZOZ+EMd70pDyLpQITc1C12yH3tpAHG5fPOehWPS8XUnvpJlgxDCbq3yzWNtpAqaXxUG9xfvTqA/8IC/qOenvkYLf/G21jBfENyN9/olpG2Dp3p/h6RvVKDmwKi5sk134c2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiRmki6VpCKkv9qWau3uOREQXdPqiguJ0C7atrmsJLE=;
 b=c0Bahb7XrqYFfqyhj0fO+HK3FPG9UAM0tJaFirSga0wWZWdbaJDNqsQb7qvRr2aczOTqqUK9pEOMXx8kBLf+JaeWantjeD0j2RC6Lig50KJAHMTGn5LSDHaVFA34Juw3VuTcq/9SJirlUjcHWfOnOe7k9jHuubsxJuvGDdQEjZg=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by TYSPR03MB8396.apcprd03.prod.outlook.com (2603:1096:405:56::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Thu, 20 Jun
 2024 04:32:25 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%5]) with mapi id 15.20.7677.030; Thu, 20 Jun 2024
 04:32:25 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dqfext@gmail.com" <dqfext@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "daniel@makrotopia.org"
	<daniel@makrotopia.org>
Subject: Re: [PATCH net-next v7 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Thread-Topic: [PATCH net-next v7 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Thread-Index: AQHavX6rqn6FofMcLkServtyDdJOQbHO1eaAgAArMwCAAI0xAIAAjGmA
Date: Thu, 20 Jun 2024 04:32:25 +0000
Message-ID: <e6c2c78f71ccd721ca144e011f3ada242eca8d57.camel@mediatek.com>
References: <20240613104023.13044-1-SkyLake.Huang@mediatek.com>
	 <20240613104023.13044-6-SkyLake.Huang@mediatek.com>
	 <ZnKgYSi81+JdAdhC@shell.armlinux.org.uk>
	 <ac5cfcdeefb350af4467fe163b8a93b7873d3889.camel@mediatek.com>
	 <ZnM7DkKhMABNgjEi@shell.armlinux.org.uk>
In-Reply-To: <ZnM7DkKhMABNgjEi@shell.armlinux.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|TYSPR03MB8396:EE_
x-ms-office365-filtering-correlation-id: 81d70994-7b9f-4f57-2075-08dc90e1fc15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|1800799021|7416011|376011|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?enVoYzlFL0d2NE9SWFgzTjVRaStMY0dVOE1LNXVZSHYySjJxSjVENm1jbmZz?=
 =?utf-8?B?UUp4Q3JVT1lETWUrR0QveElocThiZ0hGaWZrcEp0SnBlM1IwU0RVNjFveHBC?=
 =?utf-8?B?SUFkWHlabjc2QjQyWDZyeEdQRWJ0OFVmajdhVHppYktMbTg3RmtOanUzTHlS?=
 =?utf-8?B?ZmlVRnlmYThNQ3pSbHBPR3UzM2N5SXhrQ2liUGFMdno1NVVwdFRUdzNaS1VN?=
 =?utf-8?B?WGd0MHlJMUt1S1J2R1A5SU1yOXczMlVzblBRUTMyazNnSTZoT0xlcGVqK3px?=
 =?utf-8?B?KzU1bHlyS3pWMFJ6aEJPOEhLajFjN3pjSmJ5c2QwcnM5b1B5VEZsMWwvUW0v?=
 =?utf-8?B?WE9ucUZCWUVCN1A4ZFJvSTJKZlNLMG9TQzlyeUVsQWxQMjVhcnBNZ3p3cE1I?=
 =?utf-8?B?VzdyZkx0Qk00czhBN2hNRTM2bURUWVRHN1V5VFd3cGxJWC93VXVvazdDdWEr?=
 =?utf-8?B?WU1jL2NlR3hlc2k2ZzkyTlhSdXRuMUNjYXFib2d6SGx2Z3Zzemp0ZExlTkE3?=
 =?utf-8?B?MUtwcDArZDdrb1NzMGVBU0R1elhVZWRPcy9DZXVoOWg0eEs3VUVuZmlvZEZM?=
 =?utf-8?B?SUR0WmV2ckJLQ0JGRW9yT3A3ZWh4U1FDbnpHYk5zcEJ4RHc3NVc4anlZTmVB?=
 =?utf-8?B?UHdlNDlrTkNCcjdKSnJKbmFuK0pSSEZ4MTliU2JudmlFVnNtUzRWTWRlZkxq?=
 =?utf-8?B?bFI3Q1A3UFV4SFBhQTRHaHQ5SDdLb3BkNXNNRTk3ajgvR1M4Mkhva093UUk1?=
 =?utf-8?B?SHJCUU84WlpIR2lKMnNhcXBKWk5QV1pSZi9uM3JvNnd3eFl2SXlyRVZ2U2RH?=
 =?utf-8?B?MGlHY2NObThJWE4rKys1TDN6azhaSnBKNjNMdGdXSy9Vbktwb1MxaWd0eFF2?=
 =?utf-8?B?QWZaNXlTcGZjSzNIaHA3YUFnODNBd0c1VDdVYW91YWF0bVpGRU5lSTJ2YnY2?=
 =?utf-8?B?ZGFQQzIvczFLcmdxZFVsK1lZejc4YWVRK2psUDZXZCt0c0NPYWwvNVVueU1Q?=
 =?utf-8?B?SlJPUHRleFJsK3hTazc0VFNDUk1ZQ1AzZVVMYjJDSUNlUmNxdkJDU0kvVGpI?=
 =?utf-8?B?aHhqdkpvbERrZm5kWmx2cmE2cWpOcVprb01QcEhuY3VUMG1nK1FSeUlwLzF1?=
 =?utf-8?B?aFVHbDVDc3h2VkpGVm8xUWt1dmpWZGJSZzNjK1IrcVF4Vlo3eGtPZFVmZ3NU?=
 =?utf-8?B?NEs2aTRmbWpneFhCYXBJazFMMjYwNzdHMVdVSXFQS2tITnN4eCtRSkJxbHQz?=
 =?utf-8?B?WlZxU2tLbFNORFY3RzNNZmFZdktocGhXVWlTU1lEck9seE1TUlRIVDU0Z2hE?=
 =?utf-8?B?TVE0eGpuMTNnVmZDSW1KSk53S0FRVEtYY1BURzJNbHVvbWkxeCtKV1FoVE9R?=
 =?utf-8?B?ZVFQS0o3d3RtRnQyb2RIQnl0WW9WVjhCcXp0bG5kdzYveVlOUHQydi84b01x?=
 =?utf-8?B?bzZpQVJLellwL1ROUllkTE1sd1gvQlhwNEdKVnY2ci9zR1hrNDQzK2JZaitx?=
 =?utf-8?B?NW1mZjFDM1V2cGtyZ0VselE2aHJvN3VJejhaRk84TUVBMG9EbWpVS3NCejdt?=
 =?utf-8?B?bWxrZS9oZG42bU9pQWJEcnpPeGdId2FiaVR5L3RDUE9NaTlGVkpVa2ZDTU5h?=
 =?utf-8?B?eHN2cWM5YXBSb2Y1Q3ByZk94eWpEUUpoc203bFlQbHRDVlZOejZ3cGZELzJB?=
 =?utf-8?B?R2k1MUNTVDUzcGx0a3M2Q2tmZGRwK0hHSSt1VmZheXp5c2laZUdZWWhFd3VL?=
 =?utf-8?Q?kxR0CDoAifdXSpUtzGCFh97b4rxzlcGzi0wK9nl?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(7416011)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WS9HcXJTU0dpcUVvZU4yOE1UZjJzWTNCNXBMdk9WSDAyWDhXZEt3c1NwRHV4?=
 =?utf-8?B?WjZTSXplZDlaQjZGbkJrQzc4WDlXOXBNYXBOdE9rMkFaTWViMXFXK0p3N3o1?=
 =?utf-8?B?OEdkRFZZRlphWjhEZi84NmFkMlRnSURLQVZ6VWpLWkM2MExjZVpudUtlRXUw?=
 =?utf-8?B?MzVxcmhOMUZ1ZGphc3VpRzBwVklRK3lTNVFoSXB0eWsrUkgyMlJuMzZZWXdl?=
 =?utf-8?B?dGlqRUFwWVZ1V2FpZlhrOWlJMFBnUWdSQlY1SnM4dGZ0bGJTaWp6Z2tKcXVZ?=
 =?utf-8?B?a2VXZlRYMUhUTzQ2Q0xSWk9pdEo4ZGE3ekE1VCtRSjJnR0JsOWlodkg2VHI4?=
 =?utf-8?B?eTFMeFRiR29aVnVaRmM3djNieGxEVHFGTWpCUzJ3dW9kdE5Gc1lBdVNWQTRF?=
 =?utf-8?B?NVdTSm5obHlJR0VnYjREdDhuMTVhUDF5L2FoTjFUVzM4dU5EblpvZ05sbTZz?=
 =?utf-8?B?a2JTQWpLalVRdnJzTy9udlQza21nSEgyYTNlK2w5L09RNThHWVBMLytGMk5r?=
 =?utf-8?B?VUtNODZCTHByZ1p4MGVkQjlhd0w5MG90TElLeDV3SXZHQ3lON0svWFd5SURC?=
 =?utf-8?B?bUhNYlIrSXR6QWhqQ0hGNmd6SS84K2ZDRC9Kb0wwZVptczFlNGp5N1JhQVo2?=
 =?utf-8?B?cDN0eDdSNGVmY0hsN2t5NGRXbVpEK0dNamFXb0xCWEZ1enFVUlRQek1iRjBp?=
 =?utf-8?B?RmtHY2Y2eHdMN3h5UXZGMC9EN1NDYmZ0d2lFd1BnazNlZ1AwalF3VFVGbUhC?=
 =?utf-8?B?ZjVmdm5rVzhTbzlwSDFMMHZXbW55dklQcWNhL2QweHk5cG5ZM1hwbW5WZUZE?=
 =?utf-8?B?UWtZSWQyQys3cklOKzhWRVlpZ2thd1IrUWtEVmt1Y3J3SlZNS1BjLzJ3RFg3?=
 =?utf-8?B?ZG5SVW5jdmFWS0VNK2JmbGtSVHJXQURlWGdDQVNuWFlmS29CbnZHOVlrdnM2?=
 =?utf-8?B?NlZsRFc4ZW5TbzJRWWIvSktBR3A1d0V2amxkdnR5b3RRbFVpWXFCMlhFYkJu?=
 =?utf-8?B?d0xqU0U3NXUxMnJ4Q1NqSUJkREZXdENiQlVneEdCRXdLTisxVGgxSERldWY4?=
 =?utf-8?B?c2ZGb2xvdDR3QUdYamdHWWFiNjdvR2NlS3FGTkh0alNiODJtbGp0RFN4NXVv?=
 =?utf-8?B?U2JwcXRwY01kM2dLK0QzVER2NEtySCs1YU1XRXVQazF5MkJDTmNYWFJVSFpn?=
 =?utf-8?B?dTZpbDhJYmNiSTN5KzR6OFpwWGxWT2YrbysxbUgxZjJFRjN2VlhjN3NlMkNn?=
 =?utf-8?B?Yjl2aHcxNU4xY2tUVGcrd2loZTVtU0NpYStIV2ZZWFJEbSs1TDdQKzJvcGFO?=
 =?utf-8?B?V3V2MGN2Z2hNUDdsQ1lLcGJNZFZ3UHBGL056YkFkUXhqd1BNTWVrWDZ5YW5k?=
 =?utf-8?B?RFYxNVVjc2U5SmFxcHl3TGxYZGxtMG5ZZFMwZldrR2xRc2NOUUxxVnZ1RHUy?=
 =?utf-8?B?YzdHaHJ3MkkrZjB4ajJjUVZmYXFXQ0JMRlVoVUlOUHFhL0J3N3FncmprWmV0?=
 =?utf-8?B?dnNaZ3dIUzhDRnlLazB2LzBNU1dQQkNSTlBYdWtQeitXa2FLUWtQZUo2OVdK?=
 =?utf-8?B?ZkdyeGdFK1hpZE5tSE0yM0pCU1hmK1BaeGhIQityQVRKUXgwNmFmSjlRUjdT?=
 =?utf-8?B?S1BwYTJlNzhGcXFLcytWcHFmdlA0enJiRFFCUkl4Ni9PejE3elFpZm5vZkRr?=
 =?utf-8?B?aFd4S2R0RjVWanlkWFhkUHpkZUplY3pLMkd4c2QzS1FrQnBwNTJCdEpzSGxS?=
 =?utf-8?B?SEFWVlJ4TE9xTHQxVUs3aHM0NVFJN3kxRG5yUkRVWTdLa0JZdlcwMm51VDAz?=
 =?utf-8?B?T3pEblhVTHVVb0ExQ0NqSGFhRS9TNzBneERaRk9hSGl4d2p1MFJkelZaMTlL?=
 =?utf-8?B?YU96RzFaNlVYNUxuNnl5RHVxUlA5UHJpSHBJWFpEd1EzWEdwZ1p2UEg5L0xj?=
 =?utf-8?B?TXZWTDJBczU1UUZvOVFlTWpidzEzZEd1VllIbEgzbzBMdVBXKzVDYldvQkdN?=
 =?utf-8?B?NHlwMHdNRXhRZ2NUWnMwUjYwZXNhV0RaSEw5UVFpQXNsYURScHFzSVR4QXo3?=
 =?utf-8?B?Qm5BWDNXa0FJY3YvMHA0U2huc243MnExdnBqSVdSbERvYTVUOHpwZHY3OGJ6?=
 =?utf-8?B?VWwvdW1VMndScDlWZU1hQ0x6M3NsZXdLb3ZCbExPcjJXTjFrKytVYytKRlVl?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FD401622BF416448FA54C7F5E13DABB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d70994-7b9f-4f57-2075-08dc90e1fc15
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 04:32:25.0981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W9pFEmrdqDn+CrAaglIApfLPhbzDlLTnqT7w7s8OzKUmWoWQgvNWyG5yGo/aU1e7a8zSuqdZUzhdC7pbzhWkva6neQbq6691jx+CK7UnZIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8396

T24gV2VkLCAyMDI0LTA2LTE5IGF0IDIxOjA5ICswMTAwLCBSdXNzZWxsIEtpbmcgKE9yYWNsZSkg
d3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2Vu
ZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgT24gV2VkLCBKdW4gMTksIDIwMjQgYXQgMTE6NDQ6MzJB
TSArMDAwMCwgU2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKSB3cm90ZToNCj4gPiBPbiBXZWQsIDIw
MjQtMDYtMTkgYXQgMTA6MDkgKzAxMDAsIFJ1c3NlbGwgS2luZyAoT3JhY2xlKSB3cm90ZToNCj4g
PiA+ICAgDQo+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cw0KPiB1bnRpbA0KPiA+ID4geW91IGhhdmUgdmVyaWZpZWQgdGhl
IHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiA+ICBPbiBUaHUsIEp1biAxMywgMjAyNCBhdCAw
Njo0MDoyM1BNICswODAwLCBTa3kgSHVhbmcgd3JvdGU6DQo+ID4gPiA+ICtzdGF0aWMgc3RydWN0
IHBoeV9kcml2ZXIgbXRrX2dlcGh5X2RyaXZlcltdID0gew0KPiA+ID4gPiArew0KPiA+ID4gPiAr
UEhZX0lEX01BVENIX01PREVMKE1US18yUDVHUEhZX0lEX01UNzk4OCksDQo+ID4gPiA+ICsubmFt
ZT0gIk1lZGlhVGVrIE1UNzk4OCAyLjVHYkUgUEhZIiwNCj4gPiA+ID4gKy5wcm9iZT0gbXQ3OTh4
XzJwNWdlX3BoeV9wcm9iZSwNCj4gPiA+ID4gKy5jb25maWdfaW5pdD0gbXQ3OTh4XzJwNWdlX3Bo
eV9jb25maWdfaW5pdCwNCj4gPiA+ID4gKy5jb25maWdfYW5lZyAgICA9IG10Nzk4eF8ycDVnZV9w
aHlfY29uZmlnX2FuZWcsDQo+ID4gPiA+ICsuZ2V0X2ZlYXR1cmVzPSBtdDc5OHhfMnA1Z2VfcGh5
X2dldF9mZWF0dXJlcywNCj4gPiA+ID4gKy5yZWFkX3N0YXR1cz0gbXQ3OTh4XzJwNWdlX3BoeV9y
ZWFkX3N0YXR1cywNCj4gPiA+ID4gKy5nZXRfcmF0ZV9tYXRjaGluZz0gbXQ3OTh4XzJwNWdlX3Bo
eV9nZXRfcmF0ZV9tYXRjaGluZywNCj4gPiA+ID4gKy5zdXNwZW5kPSBnZW5waHlfc3VzcGVuZCwN
Cj4gPiA+ID4gKy5yZXN1bWU9IGdlbnBoeV9yZXN1bWUsDQo+ID4gPiA+ICsucmVhZF9wYWdlPSBt
dGtfcGh5X3JlYWRfcGFnZSwNCj4gPiA+ID4gKy53cml0ZV9wYWdlPSBtdGtfcGh5X3dyaXRlX3Bh
Z2UsDQo+ID4gPiA+ICsubGVkX2JsaW5rX3NldD0gbXQ3OTh4XzJwNWdlX3BoeV9sZWRfYmxpbmtf
c2V0LA0KPiA+ID4gPiArLmxlZF9icmlnaHRuZXNzX3NldCA9IG10Nzk4eF8ycDVnZV9waHlfbGVk
X2JyaWdodG5lc3Nfc2V0LA0KPiA+ID4gPiArLmxlZF9od19pc19zdXBwb3J0ZWQgPSBtdDc5OHhf
MnA1Z2VfcGh5X2xlZF9od19pc19zdXBwb3J0ZWQsDQo+ID4gPiA+ICsubGVkX2h3X2NvbnRyb2xf
Z2V0ID0gbXQ3OTh4XzJwNWdlX3BoeV9sZWRfaHdfY29udHJvbF9nZXQsDQo+ID4gPiA+ICsubGVk
X2h3X2NvbnRyb2xfc2V0ID0gbXQ3OTh4XzJwNWdlX3BoeV9sZWRfaHdfY29udHJvbF9zZXQsDQo+
ID4gPiANCj4gPiA+IEkgZG9uJ3Qgc2VlIHRoZSBwb2ludCBvZiB0cnlpbmcgdG8gYWxpZ24gc29t
ZSBvZiB0aGVzZSBtZXRob2QNCj4gPiA+IGRlY2xhcmF0b3JzIGJ1dCBub3Qgb3RoZXJzLiBDb25z
aXN0ZW5jeSBpcyBpbXBvcnRhbnQuDQo+ID4gPiANCj4gPiBTb3JyeSBJIGRvbid0IGdldCB5b3Vy
IHBvaW50IG9uIHRoaXMuIFdoYXQgZG8geW91IG1lYW4gYnkgInRyeWluZw0KPiB0bw0KPiA+IGFs
aWduIHNvbWUgb2YgdGhlc2UgbWV0aG9kIGRlY2xhcmF0b3JzIGJ1dCBub3Qgb3RoZXJzIj8gRG8g
eW91IG1lYW4NCj4gPiAibXQ3OTh4XzJwNWdlX3BoeSIgcHJlZml4Pw0KPiANCj4gU29tZSBvZiB0
aGUgbWV0aG9kIGluaXRpYWxpc2VycyBhcmU6DQo+IA0KPiAuZm9vPHRhYj49IG1ldGhvZF9mb28s
DQo+IC5iYXI8dGFiPj0gbWV0aG9kX2JhciwNCj4gLi4uDQo+IA0KPiB3aGlsZSBvdGhlciBhcmU6
DQo+IA0KPiAubG9uZ2xvbmduYW1lPHNwYWNlPj0gbWV0aG9kbG9uZ2xvbmduYW1lLA0KPiANCj4g
U28gd2hhdCB0aGlzIGNhdXNlcyBpczoNCj4gDQo+IC5mb289IG1ldGhvZF9mb28sDQo+IC5iYXI9
IG1ldGhvZF9iYXIsDQo+IC5sb25nbG9uZ2JheiA9IG1ldGhvZGxvbmdsb25nYmF6LA0KPiANCj4g
d2hpY2ggbG9va3MgbWVzc3kgLSB3aHkgdXNlIHRhYnMgZm9yIHRoZSBzaG9ydCBvbmVzIGFuZCBh
IHNwYWNlIGZvcg0KPiB0aGUgb3RoZXJzLiBXaHkgbm90IGJlIGNvbnNpc3RlbnQsIGUuZy46DQo+
IA0KPiAuZm9vID0gbWV0aG9kX2ZvbywNCj4gLmJhciA9IG1ldGhvZF9iYXIsDQo+IC5sb25nbG9u
Z2JheiA9IG1ldGhvZGxvbmdsb25nYmF6LA0KPiANCj4gPw0KPiANCj4gLS0gDQo+IFJNSydzIFBh
dGNoIHN5c3RlbTogaHR0cHM6Ly93d3cuYXJtbGludXgub3JnLnVrL2RldmVsb3Blci9wYXRjaGVz
Lw0KPiBGVFRQIGlzIGhlcmUhIDgwTWJwcyBkb3duIDEwTWJwcyB1cC4gRGVjZW50IGNvbm5lY3Rp
dml0eSBhdCBsYXN0IQ0KDQpHb3QgaXQuIEknbGwgZml4IHRoaXMgZHJpdmVyIHdpdGggImZvbzxz
cGFjZT49IG1ldGhvZF9mb28sIiBhbmQgYWRkDQphbm90aGVyIHBhdGNoIHRvIGZpeCBtdGstZ2Uu
YyAmIG10ay1nZS1zb2MuYyBpbiBuZXh0IHZlcnNpb24uDQoNCkJScywNClNreQ0K

