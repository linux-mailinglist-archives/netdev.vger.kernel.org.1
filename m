Return-Path: <netdev+bounces-132638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6982992989
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 12:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA4DA1C2219B
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 10:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9851D0F5F;
	Mon,  7 Oct 2024 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="i/7YvWsU";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="j6RCEjEa"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1C015D5C1;
	Mon,  7 Oct 2024 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298388; cv=fail; b=pGraZBaHATAwpJyelxdejWr5Fjt/+0BdT0CXZcXMRN8Y3bTyeS7ig1CqpXPw+A8WQcSyCaXeXQ+qoQJEHg0MUK1bOT3APJB3pxPfdJyoX91uyMsdDv0cbQHnayGfdQQ+tytCcScc69M8118w7oYx9WxQ2pzc+ZvX+MFJ/MRsjcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298388; c=relaxed/simple;
	bh=rt4BUQ7TdtW+0EVqKK3Q6WkbLTE07By+7jE7CvfM6Wc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rNa0lwYgI37dJMBXBL3RrxWM2gbt4S+jx3cFIm22qTF94WSWSY5usAKxkopTp4w5Q+OHJgYEsQa8I1ncCgFXUUiFeIn9NYNRWOIkKPid9MP8o3HR9HRfZ/3iKxizi1JE6RUpKEKvJokhGPEVlrU/rVs5luytwXn+UugJtn/L7ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=i/7YvWsU; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=j6RCEjEa; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 51c07482849a11ef8b96093e013ec31c-20241007
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=rt4BUQ7TdtW+0EVqKK3Q6WkbLTE07By+7jE7CvfM6Wc=;
	b=i/7YvWsUeng5fVhoF/6oMlXBOz3hVWs337YxJePUN90UAPyBELEITb+VIr9N5E1HSMZoXbeNpzpSFWL7lTYGMTpKaD43/9eKa9H5L7F4n1iUozdiBhUicKmDV9cYxsQR2EuQoN/9FAMGo2lKkIda1tKQ4hd5lB8f74ge5t3BtZ4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:82cb0d3b-b130-48ca-bc5a-030fa04429fd,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6dc6a47,CLOUDID:02ebdf40-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1|-5,EDM:-3,IP:ni
	l,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 51c07482849a11ef8b96093e013ec31c-20241007
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1535316340; Mon, 07 Oct 2024 18:53:00 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 7 Oct 2024 03:52:59 -0700
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 7 Oct 2024 18:52:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PoYJPubEkPgIsZwSRSBRzrvkL7syTKdOjtD4w86GL92OaM7dykqnIo2Brx+XQuShBKQOsGpSQCKRfZxXlYd42YIhdF/KyU5MMGWuxB1lJY74E/QryUe9a3aJyI0nteOwWFWvywU9+pt5OCwvsspi7Kbrm26corlmZP9lr66Jg+eWIpJxC3IooTvG7wQxp/mpCmmBbc3SycmJutux+6oMkkCOfd/F3lEJMA7LjZNcb4WuAJum2yc65vQAwH+Z9SGyRD8HvQMknxbQb6RvmCAAsoTDG23k26PNcjapKu3jjHPJ3q78HmRztMbwA5HRYxBbjBMoXlDw2wdN4F/VC1XoMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rt4BUQ7TdtW+0EVqKK3Q6WkbLTE07By+7jE7CvfM6Wc=;
 b=McGfKFmZ2bmn+b3Rf2gddn/yVUFtqtxdw5BjhCbU6IbNCqqXG1mo8gPKT9bQOqLPpXzyvvL5V3HHve2tYcXMcjsRX9SnhXsDGHgY1IcX6dAN1QnauB/vbgQk31AqCgQEKw/NohgXw09GDXT7hCD7HKhNuC8GJ6cj/GXkEuFowg35N3nYm1b5BkeoEV3O+MvHJ3DkL3R6w9Y0vHTL8BygdkyFQmtS1VryfKjWjN7lBNyBcQrAMYRJBNYOjjac5FpTyo8V9t9J86POJ6rZOida24+YLLppsSWrkzMzgIvWVbP8n0eJ1Qg5hxBSM3TZ94qjIUv8FIoIrbQ0//xcEt+avw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rt4BUQ7TdtW+0EVqKK3Q6WkbLTE07By+7jE7CvfM6Wc=;
 b=j6RCEjEajMpi4lDCePSaD0teuoePVPrr1ui1qJceNt9S7bXA9DrbZ/6CSct+57p4DQzyvOUz7fAMsN1SdlCPSn8/QHyP8+wPskGsAT8M5sCaCUUPWDSTWlkyoAuorEytitg5aa0q1WcpahQdODWsrdkNH9LNtb3I83aVyDQnQ7c=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by SEYPR03MB7843.apcprd03.prod.outlook.com (2603:1096:101:166::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Mon, 7 Oct
 2024 10:52:54 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 10:52:53 +0000
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
	"daniel@makrotopia.org" <daniel@makrotopia.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next 8/9] net: phy: mediatek: Change mtk-ge-soc.c line
 wrapping
Thread-Topic: [PATCH net-next 8/9] net: phy: mediatek: Change mtk-ge-soc.c
 line wrapping
Thread-Index: AQHbFkiSkSYnWABd1UeowuXbZiplxrJ2f30AgASiDgA=
Date: Mon, 7 Oct 2024 10:52:53 +0000
Message-ID: <d0b28e331cb91f8b1e5d8f94441c7860f841f5e6.camel@mediatek.com>
References: <20241004102413.5838-1-SkyLake.Huang@mediatek.com>
	 <20241004102413.5838-9-SkyLake.Huang@mediatek.com>
	 <Zv_alBqCPvrSzRPL@shell.armlinux.org.uk>
In-Reply-To: <Zv_alBqCPvrSzRPL@shell.armlinux.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|SEYPR03MB7843:EE_
x-ms-office365-filtering-correlation-id: 145fe638-88bf-4d4f-2d0f-08dce6be31de
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Wlg4NDlHSG1mLzREV0NjVThOUDJBaXlwQ0xoenhWUjBSRnNaNVY0WXRmQzN1?=
 =?utf-8?B?d0NGbUY2Q2RNQnRIQ0Uxb1Q1cTdNVTF2cS85VWVIK0Ivd1d1VzV1SmFQbjBi?=
 =?utf-8?B?cm5RVVZnWVlTaThFS09KaFh6anMxNmJGSytkRDRUSFdlMzcySU5ObEx6LzlT?=
 =?utf-8?B?TVUzaW1SUjc3ZXpoc29oNmtQemVPTjdJK29GUkNma3JvMU95LzlhTmRoWE5r?=
 =?utf-8?B?Ly9PVXVHanQ4UGF4SHFSTVl1eUplT3JFeVNmK3hwQlpvOU9SbjZQU0IxZTZH?=
 =?utf-8?B?L0g3aGcvU010WDZzRWRBVnVNejlzaEErK1VwdTNwc3dZVXlOMjU2ekdTemNH?=
 =?utf-8?B?emJRenlRTTl4bDJIY2cydXBGdnhzVFVsMWtSTE50T0xMaVZqQUNJWWVJZHJi?=
 =?utf-8?B?eDZvRDNMS2dzTjlaclZ1d1NTMVhaK0hYKy9EVk5Wa3dQTjZhZzlxRmRTTFE4?=
 =?utf-8?B?YllXQjlJZE1VSzUwdFJTcktZWmdpYWFqYVJhNjEvbk9keHpkSWdhY3JQNWVJ?=
 =?utf-8?B?V0JtYm9USkZvTDRna0NrTGVHaHV5SFd5cDFZUDdrdktJbWJyYllwY3lEN1VD?=
 =?utf-8?B?bVRmNEplczRKYUdsbkVjTjRHMm1hRHFMaUtWeXB6cFRNcTZldzFiMUE2TnZ3?=
 =?utf-8?B?d2cwb0lPa1dUREJ5Qmc5ZTVRZ0xyMGtraWdHZ0ZtRFZiakFib3ZiVjJxckV1?=
 =?utf-8?B?MUlwb1ZNV05EWkVLSkdWZkR1WU45Rmw1dUZSMk1RK2pCM05ZYVNsK29PNFor?=
 =?utf-8?B?WEJZZEpzOWI1aGJ6bHhJMHk2WmY2bTNBclcyaEVMZ2J4Z2traUhqYStMeFB1?=
 =?utf-8?B?QWNpU1RZNmdubFV2L1JwNkFqNWhGZ2JKS3BTUXpLRERzV0RhUHZpTkZnaFdB?=
 =?utf-8?B?a1IyK1F5S0k0UVhQNS9Ka2QxV1J0WEVvNVRXdENxMEkwVzlUY2VuQlFqeHRw?=
 =?utf-8?B?Q0tCL3EwcWlwK24rczhkK0pjYThINUFtc29aWDBJazNrS1lRZHgrcmVuejBK?=
 =?utf-8?B?b0x0cnBTOTg1WVdjT0JMdDZSRW1LZ25rb2pGdlY0dlZuOEp5K25QSmFlNjRr?=
 =?utf-8?B?RDRDUHlWZHZJZVNoUDVJb3ZIWUV3VGxSdkhqSzlGWUFneTZTN1N3b3lIL25D?=
 =?utf-8?B?UUxJd0lXaEFJU05RSzZRNElCbUtwcUZEZFNaWGxWeEF0ZVBKU0lxUXJhNm9m?=
 =?utf-8?B?MG9GUVFvckxHYWx2dmVQcm45TkR0TVU5Qzh1akdjWHVkazgrNGRDeEUrM3VZ?=
 =?utf-8?B?RVozQXU4eVByL1NGY2pGdXZUZkdYWEpwRE5pUXFrZGs2LzRxVWJFNVgzdVJv?=
 =?utf-8?B?M2dMK0J6WDhaWnRYL2VsWE1xS29wZTh6ay9wdGxDSS9XeHB0Q21rbmh3Vmwz?=
 =?utf-8?B?UXA3TDVqTFdMT2RNaXVESHh1d0dJek43Rm9yZklVUHlhNnNMOTI4WUVjOU52?=
 =?utf-8?B?eG1VZ05vaS9yMkc5TE11SzBkbEcwdzV0Z1h2VGdGelE1Q3lUa1diK0p2YnlB?=
 =?utf-8?B?S2t4ZW0rcXVISnVXU1NnTkZjaFI5bU5JWXI2am9mTFVsd3J6R2hEV0NuYmU4?=
 =?utf-8?B?SE9RRngraDNha3Z0N0NaNGxMTEZYcVNKOGdYbmMwcUhJV1hXd3FaWEZZWTBs?=
 =?utf-8?B?OU9acERSQTBEbXBBS3hxS1VpVmtESFU1RFhXUGN3QTNqWFBBYTM4dmZvMjVV?=
 =?utf-8?B?OG5mNm1aNDZGRGRYcEpaRVdpYmJhVTdrdXVSU2E5VkhNS1hyTWc0cjF3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlhDaFBVV0IvN0liMkR1aWNYOVhWeFRYR3N0MWthVVF5UjdXVmduR3lCajd2?=
 =?utf-8?B?akxKLzRmUTR1UUtDSjlrTkFWbFVmVU1FQVRweXIwQ0xOK0hlQU1MWGZKSWo1?=
 =?utf-8?B?ZDVvQ0RNVi9zTGF3V09DUzlwYUQ3TC9jb1NTWFdRdStOY2RHZUlQdlhrNklE?=
 =?utf-8?B?VnpoNi9vb21ldlBwMlNJNWVYNUpGUWlBLzM4R29ybDFtL1hJdnFRQUdxd01S?=
 =?utf-8?B?S3A0U3AwdWdRdEp3UEczOGM0bGpmdzlXWFFLUlk0ZzVkNFlWRXNxcGV6Unl2?=
 =?utf-8?B?ZjI4Ny95QjR6NVBabFNOVzd1Z0xNUUQyUEVCQW11bXExUzdRbTJ5TVhkQnpa?=
 =?utf-8?B?WXR0QXBnazd3dlZCL1k3dzUva2MxWVAvazZQQWU0QnpuWFdzb2xNbjhlenhH?=
 =?utf-8?B?blAxVndvYm9lNGExMkd2d0pZV2JoenA1cDV5dGpONm1zYnpFbUtac3NDdDlC?=
 =?utf-8?B?UVd3d2ZMUFFWcjlLSS91ZVJ0dE9iTmoxMHZ0VnBYV0pjbHNVcVBPY0pHOEdG?=
 =?utf-8?B?SExza241dzNlQk5ScmhsNVRCd0RnSU1Scm9oODBLRVdXcHBHcnUwV1dYOXBa?=
 =?utf-8?B?MlBQdEVwVW8xQnhuSkl3aXo0MEtZSjB4eEloSU9ObTgrMEZKM2JIRmJ4aWtn?=
 =?utf-8?B?OXlqYmJHOXBXaDVuTk1ZK3hNT2M0VG55bElqSmR2bGN2VlByeVlPRE1malY4?=
 =?utf-8?B?bTJYTFlkalErc2E3ajRxeGZYUU5sK1JPZ3J1VWFvTWlmQU9zV0dVdXluUjNX?=
 =?utf-8?B?a3pVRnExaXoxdk9qUEpMOE1raEN1WVBuaXhaOWQvamxPWmRRRDdTeUttejlO?=
 =?utf-8?B?a2NaREZkTkNRcmVoNUZSVFBrL3pMcGhTNmFTTzZUMVhtNVhHNDMwOHJIYWpr?=
 =?utf-8?B?a3FpUzJsSnJMbHY5S2RoUGxMdzdzREphZTJOcGc5MjNMdU9wWXBiaUVTUDRW?=
 =?utf-8?B?Y1lLTThDSWZDaHIzcTdJOVEzbDhXVlR1RzZkMDR1V2l1Y2EweWhtV0R4VXNw?=
 =?utf-8?B?VDdmMndZY3ZIQ1ZabzI3OVRseCtSVFlqcmROZzJMYUlHZ0RjSmd1TCtnN2FI?=
 =?utf-8?B?RFBOMFJOV24zMXZwdWtyY0tzbmc1UUZuU2lVc2VJNHdpaDE4bmVUNkx2eTRy?=
 =?utf-8?B?QVhWSnM0OFJHdFZHWFVpdGdsWXE5RVB5ZkdkZWZuTmhOTnZJSS9ZNFBDZFQz?=
 =?utf-8?B?U1ZaOVRoZDgwRVd5Z0xBRzQ0UzNOalRCdENWd0U3dDFWUnZwRnUwQXh4OXpz?=
 =?utf-8?B?dlNHYUtzUDV6REFzQ1JyeURVZk51VEhDYjkydUFqaHFKMmtUbHdPQlVCdGVu?=
 =?utf-8?B?T0lWamdLQW1uMnJGbUZTYllIM0R5VzU3TW9Xbk91R0hRanVtaW54K1Q5WXdj?=
 =?utf-8?B?NHZEby9ZT2psRHI0NDNtR3RRcGJ1S01QRm4yT1cvTlIyK0phR3hNdDEyWFd2?=
 =?utf-8?B?Nkk1NlBxZnNEUEczVEdiNXA0bEg3RzVlQmtGL2kyQklPcUwwblZyVmRGWWZp?=
 =?utf-8?B?NnA3QjQ1L1k3ODRGZTR0eEFoT3J2TnFjRHQyYUpnVlIrN2s3L3hKL1pRNzdu?=
 =?utf-8?B?MExaMXlLMWFJNkpNK05QOXFZRlhJOXNpb2VJOFRMWXRGd2doRTlyUzZVTEk0?=
 =?utf-8?B?MzJDTDZiQUR6S2pXSlJWN1FWRDYyL21DYVVGNjBsQ0FyaU96ajBCOTZibndy?=
 =?utf-8?B?QTcvVXFIWFAvWlN6SXRvZ0pKNUdmamVMbklmMHVKRnJWZy9nRzQxYlFySHNa?=
 =?utf-8?B?QlVXZW5JenU2L3EweCtmN3FkczlyQzdrT3dxT1dqQ3FvZUFqZWdzVzdsM1lS?=
 =?utf-8?B?TlN1c0xBZVB3S2hUUnluc3pJcDRIVGRHS09Pd0tRSTRvZm9WeXliTXZINHJo?=
 =?utf-8?B?MFMrUGxHdFQ4aXE3WllITXpKTVNFbEVRQnR6MFVBSXZ2UGIxMlVzYUpucGN4?=
 =?utf-8?B?OENrS3ZRZWZPYUZhNHVkbDEyc3RHbEhvY0JlQ1FPdkxZd2NVb1RDUEx0dERw?=
 =?utf-8?B?VkVqVXB3K1FJWmRsTlR3Ykltc0l4WEhGcWc4V0dFam4ySTBnWEhDRm5GQzVq?=
 =?utf-8?B?c0d6YUZ3N1dpWTBCSm5lRnNzSHczUVdEUTNzZk80U09GeldIQ2tVU0E0dmRE?=
 =?utf-8?B?OFVFVzBFTHNiUWp2bEFqTDM3UGNkODhSVjhWT1FKNHV3YVVhc090MncrK3JJ?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E42712037DD894F96A7F1F2A8F504AD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 145fe638-88bf-4d4f-2d0f-08dce6be31de
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 10:52:53.4128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kOgPqaX6Ay9KRPRDixlxzu+le8clu1spZNn+fg49iBIhMxzXemD8YrE4Qxyi/R3XlDEabyENBpMyYb/mpH+DNixFyLKX4pp1U8QgLkxBQ9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7843

T24gRnJpLCAyMDI0LTEwLTA0IGF0IDEzOjA3ICswMTAwLCBSdXNzZWxsIEtpbmcgKE9yYWNsZSkg
d3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2Vu
ZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgSGksDQo+IA0KPiBPbiBGcmksIE9jdCAwNCwgMjAyNCBh
dCAwNjoyNDoxMlBNICswODAwLCBTa3kgSHVhbmcgd3JvdGU6DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L3BoeS9tZWRpYXRlay9tdGstZ2Utc29jLmMNCj4gYi9kcml2ZXJzL25ldC9waHkv
bWVkaWF0ZWsvbXRrLWdlLXNvYy5jDQo+ID4gaW5kZXggMjZjMjE4My4uY2I2ODM4YiAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL25ldC9waHkvbWVkaWF0ZWsvbXRrLWdlLXNvYy5jDQo+ID4gKysr
IGIvZHJpdmVycy9uZXQvcGh5L21lZGlhdGVrL210ay1nZS1zb2MuYw0KPiA+IEBAIC0yOTUsNyAr
Mjk1LDggQEAgc3RhdGljIGludCBjYWxfY3ljbGUoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldiwN
Cj4gaW50IGRldmFkLA0KPiA+ICByZXQgPSBwaHlfcmVhZF9tbWRfcG9sbF90aW1lb3V0KHBoeWRl
diwgTURJT19NTURfVkVORDEsDQo+ID4gIE1US19QSFlfUkdfQURfQ0FMX0NMSywgcmVnX3ZhbCwN
Cj4gPiAgcmVnX3ZhbCAmIE1US19QSFlfREFfQ0FMX0NMSywgNTAwLA0KPiA+IC1BTkFMT0dfSU5U
RVJOQUxfT1BFUkFUSU9OX01BWF9VUywgZmFsc2UpOw0KPiA+ICtBTkFMT0dfSU5URVJOQUxfT1BF
UkFUSU9OX01BWF9VUywNCj4gPiArZmFsc2UpOw0KPiANCj4gVGhpcyBpcyBmaW5lLg0KPiANCj4g
PiAgaWYgKHJldCkgew0KPiA+ICBwaHlkZXZfZXJyKHBoeWRldiwgIkNhbGlicmF0aW9uIGN5Y2xl
IHRpbWVvdXRcbiIpOw0KPiA+ICByZXR1cm4gcmV0Ow0KPiA+IEBAIC0zMDQsNyArMzA1LDcgQEAg
c3RhdGljIGludCBjYWxfY3ljbGUoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldiwNCj4gaW50IGRl
dmFkLA0KPiA+ICBwaHlfY2xlYXJfYml0c19tbWQocGh5ZGV2LCBNRElPX01NRF9WRU5EMSwgTVRL
X1BIWV9SR19BRF9DQUxJTiwNCj4gPiAgICAgTVRLX1BIWV9EQV9DQUxJTl9GTEFHKTsNCj4gPiAg
cmV0ID0gcGh5X3JlYWRfbW1kKHBoeWRldiwgTURJT19NTURfVkVORDEsIE1US19QSFlfUkdfQURf
Q0FMX0NPTVApDQo+ID4+DQo+ID4gLSAgIE1US19QSFlfQURfQ0FMX0NPTVBfT1VUX1NISUZUOw0K
PiA+ICsgICAgICBNVEtfUEhZX0FEX0NBTF9DT01QX09VVF9TSElGVDsNCj4gDQo+IEJlZm9yZSBj
bGVhbmluZyB0aGlzIHVwLCBwbGVhc2UgZmlyc3QgbWFrZSBpdCBwcm9wYWdhdGUgYW55IGVycm9y
DQo+IGNvZGUNCj4gY29ycmVjdGx5IChhIGJ1ZyBmaXgpOg0KPiANCj4gcmV0ID0gcGh5X3JlYWRf
bW1kKHBoeWRldiwgTURJT19NTURfVkVORDEsIE1US19QSFlfUkdfQURfQ0FMX0NPTVApOw0KPiBp
ZiAocmV0IDwgMCkNCj4gcmV0dXJuIHJldDsNCj4gDQo+IHJldCA+Pj0gTVRLX1BIWV9BRF9DQUxf
Q09NUF9PVVRfU0hJRlQ7DQo+IA0KPiBhbmQgdGhlbiB5b3Ugd29uJ3QgbmVlZCB0byBjaGFuZ2Ug
aXQgaW4gdGhpcyBwYXRjaC4gQSBiZXR0ZXIgc29sdXRpb24NCj4gdG8NCj4gdGhlIHNoaWZ0IHdv
dWxkIGJlIHRvIGxvb2sgYXQgRklFTERfR0VUKCkuDQo+IA0KPiA+ICBwaHlkZXZfZGJnKHBoeWRl
diwgImNhbF92YWw6IDB4JXgsIHJldDogJWRcbiIsIGNhbF92YWwsIHJldCk7DQo+ID4gIA0KPiA+
ICByZXR1cm4gcmV0Ow0KPiA+IEBAIC0zOTQsMzggKzM5NSw0NiBAQCBzdGF0aWMgaW50IHR4X2Ft
cF9maWxsX3Jlc3VsdChzdHJ1Y3QNCj4gcGh5X2RldmljZSAqcGh5ZGV2LCB1MTYgKmJ1ZikNCj4g
PiAgfQ0KPiA+ICANCj4gPiAgcGh5X21vZGlmeV9tbWQocGh5ZGV2LCBNRElPX01NRF9WRU5EMSwg
TVRLX1BIWV9UWFZMRF9EQV9SRywNCj4gPiAtICAgICAgIE1US19QSFlfREFfVFhfSTJNUEJfQV9H
QkVfTUFTSywgKGJ1ZlswXSArIGJpYXNbMF0pIDw8IDEwKTsNCj4gPiArICAgICAgIE1US19QSFlf
REFfVFhfSTJNUEJfQV9HQkVfTUFTSywNCj4gPiArICAgICAgIChidWZbMF0gKyBiaWFzWzBdKSA8
PCAxMCk7DQo+IA0KPiBBbm90aGVyIGNsZWFudXAgd291bGQgYmUgdG8gdXNlIEZJRUxEX1BSRVAo
KSBmb3IgdGhlc2UuDQo+IA0KPiA+IC1zdGF0aWMgY29uc3QgdW5zaWduZWQgbG9uZyBzdXBwb3J0
ZWRfdHJpZ2dlcnMgPQ0KPiAoQklUKFRSSUdHRVJfTkVUREVWX0ZVTExfRFVQTEVYKSB8DQo+ID4g
LSBCSVQoVFJJR0dFUl9ORVRERVZfSEFMRl9EVVBMRVgpIHwNCj4gPiAtIEJJVChUUklHR0VSX05F
VERFVl9MSU5LKSAgICAgICAgfA0KPiA+IC0gQklUKFRSSUdHRVJfTkVUREVWX0xJTktfMTApICAg
ICB8DQo+ID4gLSBCSVQoVFJJR0dFUl9ORVRERVZfTElOS18xMDApICAgIHwNCj4gPiAtIEJJVChU
UklHR0VSX05FVERFVl9MSU5LXzEwMDApICAgfA0KPiA+IC0gQklUKFRSSUdHRVJfTkVUREVWX1JY
KSAgICAgICAgICB8DQo+ID4gLSBCSVQoVFJJR0dFUl9ORVRERVZfVFgpKTsNCj4gPiArc3RhdGlj
IGNvbnN0IHVuc2lnbmVkIGxvbmcgc3VwcG9ydGVkX3RyaWdnZXJzID0NCj4gPiArKEJJVChUUklH
R0VSX05FVERFVl9GVUxMX0RVUExFWCkgfA0KPiA+ICsgQklUKFRSSUdHRVJfTkVUREVWX0hBTEZf
RFVQTEVYKSB8DQo+ID4gKyBCSVQoVFJJR0dFUl9ORVRERVZfTElOSykgICAgICAgIHwNCj4gPiAr
IEJJVChUUklHR0VSX05FVERFVl9MSU5LXzEwKSAgICAgfA0KPiA+ICsgQklUKFRSSUdHRVJfTkVU
REVWX0xJTktfMTAwKSAgICB8DQo+ID4gKyBCSVQoVFJJR0dFUl9ORVRERVZfTElOS18xMDAwKSAg
IHwNCj4gPiArIEJJVChUUklHR0VSX05FVERFVl9SWCkgICAgICAgICAgfA0KPiA+ICsgQklUKFRS
SUdHRVJfTkVUREVWX1RYKSk7DQo+IA0KPiBUaGUgb3V0ZXIgcGFyZW5zIGFyZSB1bm5lY2Vzc2Fy
eSwgYW5kIHRodXMgY291bGQgYmUgcmVtb3ZlZC4NCj4gDQo+IFRoYW5rcy4NCj4gDQo+IC0tIA0K
PiBSTUsncyBQYXRjaCBzeXN0ZW06IGh0dHBzOi8vd3d3LmFybWxpbnV4Lm9yZy51ay9kZXZlbG9w
ZXIvcGF0Y2hlcy8NCj4gRlRUUCBpcyBoZXJlISA4ME1icHMgZG93biAxME1icHMgdXAuIERlY2Vu
dCBjb25uZWN0aXZpdHkgYXQgbGFzdCENCg0KVGhhbmtzLiBJIHRoaW5rIEknbGwgaXNvbGF0ZSB0
aGlzIHBhdGNoIGFuZCBzZW5kIGFub3RoZXIgY2xlYW51cCBwYXRjaA0KZm9yIG1lZGlhdGVrLWdl
LXNvYy5jIGZpcnN0Lg0KDQpCUnMsDQpTa3kNCg==

