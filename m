Return-Path: <netdev+bounces-140614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3519B73EF
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 05:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2ED01C217AD
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 04:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F5F12C552;
	Thu, 31 Oct 2024 04:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hQ9+FpCp";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="DzZfxAgR"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5038713B58F;
	Thu, 31 Oct 2024 04:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730350449; cv=fail; b=dVH3m6xWPAEQUegIfcK9Mqveiy/6NpcFr3l5rcxGQQMu6xMU5TggAqWYCFuOk/NC6F+bdngHijByxl14xNcI3qgAmg4dGPdMQgVEaez6aiBzAzaJELETVabhNFcsL1YDq7jmG9pUZ7+uAovrNyQB6hQexTF9SoL3DeKUFgsdubs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730350449; c=relaxed/simple;
	bh=6vP7fLLRnddDRnvCsbDHjK25aRMQ7OfQ0jhwhpc3gYo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rb4iLuG6D2JBDsXDTwoS0IiTsEHPROQxxtyH6/mQDfwdzitU9dyYowA4pWyanNcm6DlHRqHmV7zEgTsD7Lkk8i4ZWtA/pDjlxWchwCnfrrScsHDYwj9+3t6MmJ4TE0iSe4qYmjHG62UQ2MZvo7vZcV/9NV7cEcEVtpZ3hYWt4p8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hQ9+FpCp; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=DzZfxAgR; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 201ce20a974411efbd192953cf12861f-20241031
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=6vP7fLLRnddDRnvCsbDHjK25aRMQ7OfQ0jhwhpc3gYo=;
	b=hQ9+FpCpNvSsUj5Qu65ePgpxSKfL/Vsk7iMzuXRU83ujcNeXCcxOyvcB/jbba25ntk0xIXgZ9vKvUOglgB6owrDm6az46wUEauPd4R+vrj6Jsvu+vSUHb+UlVX+0yY+H8I7hxjMSVeIL9NSQpP5I/fQzy8QcoIrHIQKSttjqLAw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:322711b7-670d-4f7c-95b3-aa8a3232c383,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:b88453e7-cb6b-4a59-bfa3-98f245b4912e,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 201ce20a974411efbd192953cf12861f-20241031
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1873449110; Thu, 31 Oct 2024 12:53:52 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 31 Oct 2024 12:53:51 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 31 Oct 2024 12:53:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVCl1v4zIe7II9i3Oi4F0TgpghdpT/H7nIHuN+KmcQRVIwq1/hLR484UT5sDTGz3z5Rb4BK8ucc5P+4I3H2b4zW1UjYui5VkBpj//7ZoqD40NcG4lcz4elUTdP8vFDwOxfHptLLnAdQiKoAP95rG5UPmAsvciRfbM0USlO8hHfwFegiJr1iaCsenmzsdvk0H96euwoleMzmrt6Yd4T4gdk89L6Zj/tLaZjDYsk2V/DjW8h8VXnKujRPff84Z//djwDRufjHkrxuIhia5mMBSK/Cpp3151Z+67O67A0Px742avbNzwQlu4k6L/suvsGVlC/vbcAYrULkk6BXVhB3nnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vP7fLLRnddDRnvCsbDHjK25aRMQ7OfQ0jhwhpc3gYo=;
 b=tf7fFkNbbrUadFWQewdpCgON6tUDooVluk9BCYZgw8DoyuEET60P4Isi+PYu+2TrBcNf2Sbv7oRlNCmj3mhgZGxgEj61OXtSA920hD2zGNzB2fr58w6e3uFX4SVqHH4+X2VJUefj79abwb/m+vmkcNGppXii8lckpUx/C7gIg/VSuEkfFV6dtigjrWb6PtenT4ySbzsTxyJBhT93g0Y+7EHKYe87SfQRTmfbCIVnTsfzDzJphVP15d8Gg7vZsEtfbflq3+qLI0yTbz7gVBIcm987kXKh82p5uIbiReStHPTvaXNsl2iw3BKfLenuUg8An1RNe2uIaNZfPrkzNcX6Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vP7fLLRnddDRnvCsbDHjK25aRMQ7OfQ0jhwhpc3gYo=;
 b=DzZfxAgRC/+Hi7WLrRqhML96uSHVtdOA5PbK8jJw+LK/xQLPf03XPySiVJGupWasLg3cBYgJ9v7X6COa7gE3zVUuo527YjIWMXApfGcMuTND9322jncrKPODjNJkNO/WsoO9+n422vLFWYiY0aEmY+KSQX9UTYX3CHcAhhovGhU=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by TYSPR03MB7524.apcprd03.prod.outlook.com (2603:1096:400:42f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.28; Thu, 31 Oct
 2024 04:53:47 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%4]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 04:53:47 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "horms@kernel.org" <horms@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dqfext@gmail.com" <dqfext@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next 1/5] net: phy: mediatek: Re-organize MediaTek
 ethernet phy drivers
Thread-Topic: [PATCH net-next 1/5] net: phy: mediatek: Re-organize MediaTek
 ethernet phy drivers
Thread-Index: AQHbKreMKceuqAQmrkmm54FhhkB45rKf0cOAgAB6iIA=
Date: Thu, 31 Oct 2024 04:53:47 +0000
Message-ID: <01ed46ea6898e40b89de370af1b8a31a384e0044.camel@mediatek.com>
References: <20241030103554.29218-1-SkyLake.Huang@mediatek.com>
	 <20241030103554.29218-2-SkyLake.Huang@mediatek.com>
	 <cd2f249b-6257-4692-ac2f-93252534cff4@lunn.ch>
In-Reply-To: <cd2f249b-6257-4692-ac2f-93252534cff4@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|TYSPR03MB7524:EE_
x-ms-office365-filtering-correlation-id: 82cd897e-b2e9-4ee9-f53e-08dcf9680131
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZXdzcEExbXZ0NjVyYVVEWTBwQ29NU1ZTRk1uNnkrd1BpcTFLeFdGcHV1Rjg1?=
 =?utf-8?B?MnJQc3RINzVmem9IckRRR3RwSG1wQVEyVXZQUGRleWZ5dHE0T0I2ZG1UbHh2?=
 =?utf-8?B?cWJsVWdHYWNyL1F6VzhyQkFpbWV3dmlTVERMMkVLdW12cFljUGY2SE9icVZ0?=
 =?utf-8?B?dnN6TVJHMnEveXJtS3RKM3FkMm1HYjZ5TWVTbERUekwybm9rdHowWTloV0hH?=
 =?utf-8?B?SGF2RFYwZTRtbGM4NG51QUdPNkh5dHJKeU94NDBjWE05ODVNSzR0RkRVMHN3?=
 =?utf-8?B?Q1FxYkkvRHZQbmNkblRmSnFIeGFIQjh0aHBpdjFZMVBvUW1nMkF0US9wS0Mz?=
 =?utf-8?B?MUJ2M3VZVDd6eGtHWndkYmdtdzVMTWp1c2EyLzNsdkQ4azY1YzZESnpRY2hy?=
 =?utf-8?B?YmNndWZJMVJ5WGtWN1ZwWWpnUTNIMDN2M3hTcVdYOUZnOFBSVTJoVE45dGx3?=
 =?utf-8?B?KytlazJUSzlEVXVBTUFNZzZldFpmT05aWkdEVHUrZVpFWUJweGJWUjZUMGdM?=
 =?utf-8?B?NXFsRnJVTDRYUlBQTDZyMGtxQTloUnV3aWkyWjJ0S0I0NnBlVzBjSWY0TmRi?=
 =?utf-8?B?MENRbWdYL1Znd0NUdEg1d0pvSWF0emYxOWs5ZnRQNmFTbmdyQ0RGTEN0UXpB?=
 =?utf-8?B?RFV2aTdkYXUrZUc4WlY4WlNNVm1lcEJPZ29pQ1RTeWR0OU15Qjl0ak8vQkNv?=
 =?utf-8?B?R080OWdLQUljemttZWRTazU3cVhOU3pWZXBpQys1aU9sdkQvZVBZZXQxRXJ1?=
 =?utf-8?B?bWFxNURJYkpEdGJzTloxUDM4MWpEd09sd1c1aEtkV2JTNk0xaHNmakxHRjdZ?=
 =?utf-8?B?QXFveS9MMThKZVJaTWVOU1pPVDFFSUN5cHhHVnFjUjZHN0dvc2x0b1JFWVB5?=
 =?utf-8?B?ZzJ0TDdGazZPQ0JMRWtMSGs3T3lnQmRkS2ZrdXpGR091ZjNBMlNYNEZ2bitR?=
 =?utf-8?B?aTk2a0J5NDd6b1dWUVhlVi9PUDgyMjMrT29rQURFUmpRQ24ralJmcVBPREZK?=
 =?utf-8?B?eW9GaGhIZjB6R1Q1QTB3WkdnNXBlVFVRTWd6TVZQdndXc0VHVnhCcTJVVTcw?=
 =?utf-8?B?eVJ6RVpBbUhVMFUyUmJaak9VYThERnRybWhyVndtSjZXbndvYVR5WEFJTWky?=
 =?utf-8?B?U0hobTZ1eHJDanlzb3lOVkFDUkh2eVQxQ0g0S1VSd3BpSDFlVnBIL09tSVd4?=
 =?utf-8?B?MnJTTC9zZis1b0FiQ0RpQnRsSUh0TjRTL3lKNlhYMTlSRnBsUFhGa2cvTkxh?=
 =?utf-8?B?blJyUi9QUGs4SGlGdzhtcHYzYW9PZi9HWmJwZndMQUJiZnE5Vm01SGNUcVBR?=
 =?utf-8?B?YkhqUUZUV0JlRWJacXVYQTdienl2NU5ocjdML1pjMlF0dHE0RTBONEYrU3FQ?=
 =?utf-8?B?RmJkZnlwbGptamwxOFBBSHIyS0FUdXVKY0t3MW9lU2FBa3Y4LzZyOWpvZ2dB?=
 =?utf-8?B?NUs1RVk4R21pSHAxQXg3OUxHbnpQQVJ2TExrcU4vajg3dlg4QTRxR1hpUzVV?=
 =?utf-8?B?Mkx3Yld0RUVXNXYySVcxY3BubUhzTnd2bjNZbzU4R2w5N3B2Y1dITG5xdHVG?=
 =?utf-8?B?bUd0ODhJZXVBWE04Mm5scTFtQm5SNlppWlVnanQ5N0t5WHkvU1ZOY1luMnV4?=
 =?utf-8?B?U01VNTU3MlVjdThvNXFRT25EQjV3dmdKOG00d0s4YlhxOWpQMFVJbCtISEFK?=
 =?utf-8?B?a0FqeEh3QkZWdVNIeWhvMEpLQW9sRnJHbFJHZEpXd0F5TVFTanV4ekErcFB3?=
 =?utf-8?B?SktMMGRrbzdTZ0JxTlkvR3d3VE52Y01aWXlkd3M4c1hvTjlGb1hhTVZEOXBR?=
 =?utf-8?Q?7L2fwwBoY2JXDFwDHiEjAROp62eq7LjapAKvg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1poOGZwSDQ3ZDdFNXhHRjNQV0xKQ0JsMUhsSDNmc3FadnNVOURNQ2FxWU45?=
 =?utf-8?B?Z1Z6eEc2RUprWS9walNOUk1xYWwvcHdEbVhSNEtjUStGOVo0VWN1SlB5WkVk?=
 =?utf-8?B?bHpRUnorSW9jMHg5czZZTU53dWdrN29lSS8zcGtia29DWHkwREt1bjFiR1Jw?=
 =?utf-8?B?bnIrK2FwMkE3Ymg5bWJNNDY0dlRjcDAxL2ljK3JkaWpGbThRSFU5RVJLeGUz?=
 =?utf-8?B?SXZZSHVNSTlyOHBvVkJld3BqS3hqZVRlNjFNcWgvRlMrb2RxaStpU2NCRjhi?=
 =?utf-8?B?UmlXNG1MT3BiWE5ET2tkd01rS1A2UXFhdlpsYlZTMjJBMUg0dU1oUSt3aUR1?=
 =?utf-8?B?aW55TXIzWDV0OVhRY0lpWjQ1T25OK3A3M0E0U25lNk9rdzFCa3YrYjlEVERX?=
 =?utf-8?B?d2tLQ0RtWlR3K0dyd3p0VS9EUzBINFRuaDRJL0w1WTRWQUpjRXNBN2l4TzI3?=
 =?utf-8?B?VEpIQUk1U0liTHQycldKYnRYUU9Ccis2TEZPbGE0L1lwSmRpUXBLMlZVM1JQ?=
 =?utf-8?B?YlBGbVZZaWo1S041WS9YcnJZUm5JcHZac1R4OWRqbmoyYjdka2ozZU9YTkw1?=
 =?utf-8?B?M1ljSllLVDFzM0ppNXJyYWF6bnNCQ3V4bUVPT3c3NC9uSWxtYzZUSGgvYVVx?=
 =?utf-8?B?cDVLbGt0eUJFbHpWWXgweWE4bDlGOWR6RTEwM0ZrZjBVdlR6SnRvVndLNXFB?=
 =?utf-8?B?dFlBRmZmVlJIdHNrSUFPVFA0ckR2YThnU0RXUk5Yc0plM1Q2WExpbWJycnA3?=
 =?utf-8?B?d2hsaXpEMEtScUl0TVFPalkwQzdaK2VXaUxSa05UVU5HWm9CZmwwOTRUU2dj?=
 =?utf-8?B?Q1pIdzM0MEJNc1VkSjdQUXdjZ0lIdks0eHRVZytteDllSnZyV053N1RUclZi?=
 =?utf-8?B?Q05uZ1k4YUNkRUlTcTh3NG5RNXNScnJVS2RjdUJENHJxemxsSCtYRU9LUC9P?=
 =?utf-8?B?cjRETldwVXBUM3RqZld3enAzUzdFK00wWVlweU45MXBzakVEUlhCT2hFazlR?=
 =?utf-8?B?QXdpNjhqQ3d3ZEQ1UmNNaGh0V2JXWHhiRUpadVQzTVFmK3diQmZBbU03U0RI?=
 =?utf-8?B?bFgwMG1DMm5ObXpWWE5qTlNvajhyNjRrMFRDNllvQ2cwN2Q1SWV1SjNIWkZD?=
 =?utf-8?B?eXFvT241WHJaOCtqcFgrSjFHcGRxQkd3VGFUREZlMkswT1FpODk3WkUwQjg0?=
 =?utf-8?B?Qlh5Vk5hNFMrYVBTL0xsN1VYTTFLcUlaMm15SmY4ZjI5aDhlTHdPVE8zbE5O?=
 =?utf-8?B?ajRNUlR3VUZGeWV4OVJUczVCSWd3Y3kyQUNITHZRNmVUdkxIdWpETXlEVEtH?=
 =?utf-8?B?TTBuNytTakRKWmJMTmw2MWF0UHJHVHBZQjNyTFhEOHp1S2ErQnpybjdNMkxl?=
 =?utf-8?B?Q3M3OUFINUxtNWhwU2wySkpBWkdZcUFJUXJ0WWxEZnB4cXJxRnF4WlY3aUhs?=
 =?utf-8?B?UGVGSzU0S1NzUlp1UjNCb0YwREdTTG1iTnY3Q3Ixam9jNDlwd245YlZoTDdw?=
 =?utf-8?B?TXc1b3dDcnBXcFN0Tkd2ZXh6TFlPOU5DVUlyaFJ1R2NXa0xyVkhZVWdlZ0Vn?=
 =?utf-8?B?NTFEZXJtSWU2RDhaR3FUeTZsSlFabnVIUCtWV2VhNXZWQjNNY3ArbVNmcDFZ?=
 =?utf-8?B?WGdsSTVDOUNOa3hOTGhtd3h2QkM0WGkxSDViei9KbXRsbW52Uk5Mci9LR3B3?=
 =?utf-8?B?S1lyeW5LaU0wK2luM1hSRFJVbEJIQkdMaDJ6ZEFINkdaK2RQbXlKOXBKZEVQ?=
 =?utf-8?B?QkFQQXI0cThPd3RWZUYwcURaVU81SUh1dG1od1pqSWdqaEIwZHFYMjR2YkJD?=
 =?utf-8?B?d1AxZ21WeEs0UkRoTFBGVHNuZVlGVnA2bFVnMDdWMDRnalFZTlJoaUNjNmVR?=
 =?utf-8?B?Qnd5SE44c1I2UGQzSVNmdHlURyttZ3NWem9RMy9yQmw2bS9zSzkxY3JwVXdj?=
 =?utf-8?B?ZXNQbkJlc3RqSmY0bzE4TnBCK1RzYUpkZWpOWnViTlFOdjBWSm1xenYxK0E5?=
 =?utf-8?B?ZVlGTWxCTUtBeUVEVU41Sk1UQzliUnJDeGtsbVhlWFkzUHRSRm1aOWhROE9p?=
 =?utf-8?B?eXduTnhUNzdOYWpxR3ZxbG4ra2JEUXl0Y3ZpUHpmSTl6T0NCek43MmwvUSsx?=
 =?utf-8?B?T2lNWDZTYnVSVzZIb0JjOENEeGhqdnBtdTBGRmdCeTdabElaQTRaLzVDVWpz?=
 =?utf-8?B?UVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9180334FD41DB6419AFA95FAC064872B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82cd897e-b2e9-4ee9-f53e-08dcf9680131
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 04:53:47.1223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e/wB7MZ+E5J17WYzJoilR07Vabg6Q5IN6aM5KoUcmzZFdkcHWaZZZV+lYBOaxaHaSkofEozgidNX8N//3XnJpiyZJRvDjF8R+o/2vuHfYqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7524

T24gV2VkLCAyMDI0LTEwLTMwIGF0IDIyOjM1ICswMTAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVu
dC4NCj4gDQo+IA0KPiBPbiBXZWQsIE9jdCAzMCwgMjAyNCBhdCAwNjozNTo1MFBNICswODAwLCBT
a3kgSHVhbmcgd3JvdGU6DQo+ID4gRnJvbTogIlNreUxha2UuSHVhbmciIDxza3lsYWtlLmh1YW5n
QG1lZGlhdGVrLmNvbT4NCj4gPiANCj4gPiBSZS1vcmdhbml6ZSBNZWRpYVRlayBldGhlcm5ldCBw
aHkgZHJpdmVyIGZpbGVzIGFuZCBnZXQgcmVhZHkgdG8NCj4gPiBpbnRlZ3JhdGUNCj4gPiBzb21l
IGNvbW1vbiBmdW5jdGlvbnMgYW5kIGFkZCBuZXcgMi41RyBwaHkgZHJpdmVyLg0KPiA+IG10ay1n
ZS5jOiBNVDc1MzAgR3BoeSBvbiBNVDc2MjEgJiBNVDc1MzEgR3BoeQ0KPiA+IG10ay1nZS1zb2Mu
YzogQnVpbHQtaW4gR3BoeSBvbiBNVDc5ODEgJiBCdWlsdC1pbiBzd2l0Y2ggR3BoeSBvbg0KPiA+
IE1UNzk4OA0KPiA+IG10ay0ycDVnZS5jOiBQbGFubmVkIGZvciBidWlsdC1pbiAyLjVHIHBoeSBv
biBNVDc5ODgNCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBTa3lMYWtlLkh1YW5nIDxza3lsYWtl
Lmh1YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiBObyBjaGFuZ2Ugc2luY2UgY29tbWl0
Og0KPiA+IA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzIwMjQxMDA0MTAyNDEzLjU4
MzgtMi1Ta3lMYWtlLkh1YW5nQG1lZGlhdGVrLmNvbS8NCj4gPiANCj4gPiBBbmRyZXcgTHVubiBo
YXMgYWxyZWFkeSByZXZpZXdlZCB0aGlzLg0KPiANCj4gWW91IHNob3VsZCBhcHBlbmQgdGhlIFJl
dmlld2VkLWJ5OiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+IHRvDQo+IHRoZQ0KPiBjb21t
aXQgbWVzc2FnZSwganVzdCBiZWZvcmUgeW91ciBTaWduZWQtb2ZmLWJ5Oi4gVGFraW5nIHRoZSBw
YXRjaGVzDQo+IG91dCBvZiBhIHNlcmllcyBsaWtlIHRoaXMgc2hvdWxkIG5vdCBpbnZhbGlkYXRl
IGEgUmV2aWV3ZWQtYnksIHNvDQo+IGxvbmcNCj4gYXMgeW91IGRvbid0IG1ha2UgYW55IGNoYW5n
ZXMgdG8gdGhlIHBhdGNoLg0KPiANCj4gICAgIEFuZHJldw0KPiANCj4gLS0tDQo+IHB3LWJvdDog
Y3INCj4gDQpUaGFua3MgZm9yIHRoZSB0aXAuIERvIEkgbmVlZCB0byBzdWJtaXQgdjIgdG8gZml4
IHRoaXMgdG8gZ2V0IG1lcmdlZD8NCg0KQlJzLA0KU2t5DQo=

