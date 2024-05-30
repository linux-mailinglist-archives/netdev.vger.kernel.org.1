Return-Path: <netdev+bounces-99241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFF18D4321
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 03:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D980D285808
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 01:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330B417548;
	Thu, 30 May 2024 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LHEu22U2";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="EIW0Yfv7"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312AC1078B;
	Thu, 30 May 2024 01:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717033630; cv=fail; b=l9al3qM7g50u6phnfU9E+TwtyHvQ4c/aIHREuYt+aBPMj7+Vql9/g8z3TDn7N6bj7ishSx8ob5Jc04L2yEGeSMreahkiqoMyrfl+ZZ0ob9MycHjWUNE5T3U1tVdJNLqMfK4XwdUPUuilzu3JhnTrslIVG6aKNW7mzgW66Uf6vVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717033630; c=relaxed/simple;
	bh=XLLb6N6Q7a5i3zBzijvBWMcGGyD79reJ2LJQ8uFK75c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I0frleN3mr4q0yntk/3fUFUA+OHEXtuWjyLUBItT5+B0DQrGqzSTG7vLIqoMqT48MQK/yfqgZpI3gp+4Zb1sO1BWddK845RiIhra2ICu3V4LJpfrb617bqRkmbnA9TejXn8bRKQo+AzI2vrVOQT6poVeNeC1NJWXm1zhWp9M0Fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=LHEu22U2; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=EIW0Yfv7; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 82534e381e2611efbfff99f2466cf0b4-20240530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=XLLb6N6Q7a5i3zBzijvBWMcGGyD79reJ2LJQ8uFK75c=;
	b=LHEu22U2SjI+f5ry3vlrm2VELydt6apmOQLs1XxGNHJ+xnOs7lmikmDebnyu9ju41s/A1Qsj+QaXkmx70NigeDB7dsrR042Z4yqJDK3YwAfh4IxE31C+6hY0WPNEEWtKU6vPrTMJOsBtJm6LsFjQS3CeMlZ57JFITS0Cr9peHNs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:604e644f-81b7-46a8-b335-aead958791fe,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:2cf77b84-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 82534e381e2611efbfff99f2466cf0b4-20240530
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <bc-bocun.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1348941677; Thu, 30 May 2024 09:47:01 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 30 May 2024 09:47:00 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 30 May 2024 09:47:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkICvfrGDWmucyncJrtNAxxQJ7Xvp8mcJLikqc2tCTx5hwOGpTBe/aKbmpEuXsnY6/VYuNuZ+/fXbGMh/b4zHQqstpzpCOPkUUEAddEpmAH65nwekbauLhzeSbfoKMoeBJGM+2FlfpQPENjN/o3c78seyM0215wnG6Fj6Z5ECuAxQyga6idvNPcnRPRzRfA6vzS5Qe2T1T9K1UhPfTj/r8CrAHfyeuTRPand1OUg9mVI9XOnFmXl6CCLLZ5TuKJuWWX/AmnzuN4PCBrKqrWw+aCo+VYrDwey7Yb6obszCmEcKOedEU9mGeyXPi1Ko+Q585J0Ua32L2VARWyWTfOWtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLLb6N6Q7a5i3zBzijvBWMcGGyD79reJ2LJQ8uFK75c=;
 b=VCLgmLLsIguhXrmO/3iF1RF8k3S/hEdJytmtHqjkUPq6rkSh52NAaeBO95F0FkdEGEY9Sx+u1DES5t7XXRClK+CdCyauG7/5vvFkz47k872/Kn3LPO/W9K7d7EAxgBdRwiECaTPyuXxFYDt8YXiBfgY5Ffld/VDgXh6ENyuVUPqRSjB/DiQOJIUiIUpa7ah8/3Vg/pOB9BSIUFaW1cB8UqgHtHJ2NkbKMcxyE93QwZJvM/d0/9TPMrkX9XUQaqE62e1kdBqp6p1GF0SDlAy79qPBRvGc8Vq3ZoS0lo510cgrz30IMbkmzShFKTeb/avVXq81NfskHKw3aYyJHn87Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLLb6N6Q7a5i3zBzijvBWMcGGyD79reJ2LJQ8uFK75c=;
 b=EIW0Yfv7nOHmMY1IU4Rp1ia2XD6BY0F5sbbKXDGu17aAso9a3c1nPqqNGPpsdzMF9vTWftycCWSk909Uhfu6qg5bjM47w8lpvLwZNj2T5Lc0ApSjtdHl/kcDUPIzZzZ6txhygB4I3ubnciooUZtUUEaItXywiKkxnunorHCZQRM=
Received: from SEZPR03MB7219.apcprd03.prod.outlook.com (2603:1096:101:ef::15)
 by TY0PR03MB6776.apcprd03.prod.outlook.com (2603:1096:400:219::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 30 May
 2024 01:46:54 +0000
Received: from SEZPR03MB7219.apcprd03.prod.outlook.com
 ([fe80::6198:1b1c:c38e:fae4]) by SEZPR03MB7219.apcprd03.prod.outlook.com
 ([fe80::6198:1b1c:c38e:fae4%4]) with mapi id 15.20.7633.001; Thu, 30 May 2024
 01:46:54 +0000
From: =?utf-8?B?QmMtYm9jdW4gQ2hlbiAo6Zmz5p+P5p2RKQ==?=
	<bc-bocun.chen@mediatek.com>
To: "daniel@makrotopia.org" <daniel@makrotopia.org>, "sgoutham@marvell.com"
	<sgoutham@marvell.com>
CC: =?utf-8?B?TWFyay1NQyBMZWUgKOadjuaYjuaYjCk=?= <Mark-MC.Lee@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>, =?utf-8?B?U2FtIFNoaWggKOWPsueiqeS4iSk=?=
	<Sam.Shih@mediatek.com>, "linux@fw-web.de" <linux@fw-web.de>,
	"john@phrozen.org" <john@phrozen.org>, "nbd@nbd.name" <nbd@nbd.name>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>, "frank-w@public-files.de"
	<frank-w@public-files.de>, Sean Wang <Sean.Wang@mediatek.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [net v2] net: ethernet: mtk_eth_soc: handle dma buffer size soc
 specific
Thread-Topic: [net v2] net: ethernet: mtk_eth_soc: handle dma buffer size soc
 specific
Thread-Index: AQHasXMYNi3xSZU3p0KmKIWq/uy+z7GtmbyAgADk2ICAAIUCAA==
Date: Thu, 30 May 2024 01:46:54 +0000
Message-ID: <4611828c0f2a4e9c8157e583217b7bc5072dc4ea.camel@mediatek.com>
References: <20240527142142.126796-1-linux@fw-web.de>
	 <BY3PR18MB4737D0ED774B14833353D202C6F02@BY3PR18MB4737.namprd18.prod.outlook.com>
	 <kbzsne4rm4232w44ph3a3hbpgr3th4xvnxazdq3fblnbamrloo@uvs3jyftecma>
	 <395096cbf03b25122b710ba684fb305e32700bba.camel@mediatek.com>
	 <BY3PR18MB4737EC8554AA453AF4B332E8C6F22@BY3PR18MB4737.namprd18.prod.outlook.com>
In-Reply-To: <BY3PR18MB4737EC8554AA453AF4B332E8C6F22@BY3PR18MB4737.namprd18.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7219:EE_|TY0PR03MB6776:EE_
x-ms-office365-filtering-correlation-id: 854f6c34-8a73-4983-a7d3-08dc804a621c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?R1RyUm9vWG1rTm5IWlpKTVFCa1cvcFZPVk8xb0tER1RMejFreFZQT3RhT3hI?=
 =?utf-8?B?dzNQaldQZWlLeEFBRzh4blV3K3VlTEJaWldnVzJibjNCdHM5bGRlUFFxTGJr?=
 =?utf-8?B?Z3NvK0RXanBHNWxPODRsQXlnK1hvOThHNFlBWHZEQVhBU1JseHB3anMzUmhv?=
 =?utf-8?B?SnRsZ2hEM0xnOUd3cDdyNWEvQ3d3eksvZW50eFcyZGU5Q05Jbmsxdk5zVTho?=
 =?utf-8?B?UW4yUDNDU0FmdjgyRVFKL3RoZ3A4dXhPdFVIeUZDcFlsUUpaYk5nT1dZL1J1?=
 =?utf-8?B?b3JieW4vU1VWOC9jZWZzb2VLZVZXaUg5MkZ6bVZFd2IvcWhQQzVQd3pFU1l2?=
 =?utf-8?B?MGs3MHJlM1llcFlkdW9PaGs3bXIyWWo1a3pqVGZTNmtobWVsQ0owSkpBVmg2?=
 =?utf-8?B?RDg0NlJPN3pFQ0hWcS9TZGtreUZyU24yTmVCZlZQVXlNN0NUSkowZjgyNU03?=
 =?utf-8?B?cEdLa1ZOVGx0YmdwZDdReXU4Z3BKZjhuYktIMngwWjAxZWdidld0M082TFd3?=
 =?utf-8?B?VFVBZDNsVU5HYnhHZ09VZEdVQytrbWtHWVQ5dDgvdnVGMjRWV0tndElIcUpK?=
 =?utf-8?B?bWxFc0p4OHVlcVVDNHZLbjkreis2VVNhZWE5bHN5anRHYVQrWkFDNDNVWGFZ?=
 =?utf-8?B?OHhZQW84bzEvRVpnR0NVVE1zdlVTYlUwNk5vck42U0x5b1gybzc2YTB5c1Nr?=
 =?utf-8?B?V1kvVndYUHdMeTJvcUQycnJOWnRuaHBXTHgyejJ2M3NjNU96Z0JFMm1JbHFy?=
 =?utf-8?B?QVdRNjMvUkIycGtXNGZ3d2ErYTNWRXJuNEZnOXpHSGF3eW5MWnMwc1gyRVVy?=
 =?utf-8?B?YnBOOXlYK0RYd2xIQWRsek1Id1lMYmk1eHhUYklrSjdFQUl0MnNKOUhQd1ZV?=
 =?utf-8?B?KzZOY2ROLy9pK0JFR0dwRllzbjZLaUhyamxBQU10dEdnd3E4V0N6bHVxZG54?=
 =?utf-8?B?a2lwVjdJL1FiSStrUDZiYnRVM2VHcGFOQ1dRSHBEa1d0dGhhbkVQbkxHaHla?=
 =?utf-8?B?YURkNGQvYTlzUUdDdktCdjlaTVZRNGhndURCaXFwZ251TzlzV1AxcmlhN2tq?=
 =?utf-8?B?d2RoK3FYSVVyQTlVVGwyVlRRRmVidEQzcWRROVoyd3lnZ1pyWkc5Z1paSW9K?=
 =?utf-8?B?UFlYczM5Q2FFVzVKVHpLaThUWitpVzFFakRqS2VSRFpwY1Q4VHN3eXljY1dz?=
 =?utf-8?B?MlNHdm5vZlZzS2Mzc0JWMHJXcWFMbU5CU2Y5OHlORVNpa2l0OTVLVHhCZ0lE?=
 =?utf-8?B?MWlzRmd6ZnprYzMxeXpWcCt5bTlFSFViNmxUbmVIOVF3VVFXaHE0RmI4WFN3?=
 =?utf-8?B?czJpUTlZR0FCZmNhNThKd2pVdjZmbnJ2U1BJSzYxODMxSmk1bE9tYUxxNElU?=
 =?utf-8?B?aFFFcnNrQ3k4MXUyUnhHN0ttYXhybU11NzYycitUYkJPMG5ORzFEK2paM0pZ?=
 =?utf-8?B?ME9NakhNRmdqVGFwcDRWV2ZvVVhiS2hzMUVoTXc0a0hxczJmaTd2bGFVQjJQ?=
 =?utf-8?B?UUg5SW9IMWh3MFNqVDJYNkU2bVZta0o1WmthVmxodGlyM2s1Uk5YenNOL0Rj?=
 =?utf-8?B?TjVwZWpETTlMRTRnbHJxYU01aVhjVnpHTTB5M1l5Q0RaRzlnSzVFenhWb3U3?=
 =?utf-8?B?dVJYS2JMSHBLTnFsUFNHZHQvVG1RVU50Ym5qZHplUytHN0tXWjhhcmJFTzJM?=
 =?utf-8?B?S01oYktsak5xdStmdG5uakpSenRMTlUxVGdYZUZtK2NibDBVRUU5Mko5a3c1?=
 =?utf-8?B?alVXVlpvY3g2cWJpN3FKT1N6VTJ3UDZkWEU2d2FEL2FTRm5OVkpzQ0RCaFZ6?=
 =?utf-8?B?VkVjMDJLQW92K1c4V2Y5Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7219.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3BWdzlpbXFZVWQySEswemx2OWo0RkU5a2lnNVA4Nmk5Uy9ORnlRL3dGdEw0?=
 =?utf-8?B?U3dDSEF5OTFzY3dtUnN4cjkzQWg0MzJUSi90VlJvOVltL0tKQ3NOL2V5WEQ3?=
 =?utf-8?B?S0xUN0x3dU8wRTdxSmZkZjlnT1ZLOXpaMTFxSUdCNjdJVm93Y2ptYzNJYVll?=
 =?utf-8?B?d2V5V0hUb3dXOVZDaWJEc0VHV2RaTHN4dnBGdTd4OTM5QUI0TDIzTXJBVVBG?=
 =?utf-8?B?U3NJdUhmcWxWNVF2L1h2TGdWYlNrY0pGa21KOXdNNGt2aGg4bjJsdGZreUJy?=
 =?utf-8?B?UDhtRGJtcVU5OEN2THZHUVA2M21HNVRkMFd0NWx2d3JtQkR4dzBOQ1MwcFhD?=
 =?utf-8?B?REpJKzA4WkZ3QXY0NlFSUzcwU0twaHBVcDlMTmZidUZZZFU1Y1ZBWDYzdjVs?=
 =?utf-8?B?MUlBR2lrQUF1YXRoMDlSN1hGSWtiQVNxdERldklybVZvMGFlcXRCdlhHL3ho?=
 =?utf-8?B?bXpJQ3ZkZUdEL2VHdjV0S0ZXdmdKcCtjTHQ0L2J6U1lsT2pPaDg5QmRhcmZR?=
 =?utf-8?B?em9EY2dZU05QcXVKWXU4R3VZMjRlT3RkcWJHNFA3dXNZcTI3NlZSK0VSc3A3?=
 =?utf-8?B?b2dSYWFDOGljdXpnVnIzaU01b2xXTFVQQzE1bUhFTUVXd1NzdmZidG84SFVm?=
 =?utf-8?B?NGtEK210TmNmcWhzaWtnNTlWcW9xZUFheTc0NitXbGNLYWxad0dqelZ2ZFU5?=
 =?utf-8?B?cWhwM3JaUlpaTFZzK3FLQTJFeTRTQjcvZGs5WjV4cTlManN6MHBhYjlTTTFH?=
 =?utf-8?B?bmNTTXN2VFNmOHpIbW1zSWNtbjB1UFhUYW9rRkJSRXVSaWFMR3VDVDFUdEtu?=
 =?utf-8?B?M0ZqWHcwUHZtcHZvTVJ1WldtMlpyc0lZOTNQY2ZYWWI0NUdHQldyRUlHOFRD?=
 =?utf-8?B?K3RjWjZmMGxXaVkzRTNzL1lPdzFxWmdIZlFmV0xvTlAxek5HbS84dXBsakl6?=
 =?utf-8?B?SFFabGM0SEg5ajgxUDlDNmxqRFF2OVdOa2ZTSTloc3lIWXdqS2pXY1VGRUNl?=
 =?utf-8?B?OFpCWi9WOFBoOGszZnd1MlQxcWR2OXVFckFTc3pBOVFzcmFDRXNwdEtzbm1T?=
 =?utf-8?B?S3d0ZUNwWUhRSE0vZXhBanJ0Y0N6b1hickJlRCs0YlUzMTh3VXVzR0pVaUdQ?=
 =?utf-8?B?OEc3UitZdjc3VWtKQWpEeUlCcE02SWtjVm82NGlHZXVISFRXdkhJQ0RDa1k0?=
 =?utf-8?B?SlNtdDg0SVZ2a0xEMTRTTTlOaXhHVEYrRFBoc1dVdll3T0czS3FVK1VzREdM?=
 =?utf-8?B?Rzc2TGdjOUVzRnpFZE5mNWV5OW1TdGpzSDFVd3JHeldCOWJaZlpUZDd6K2JU?=
 =?utf-8?B?cEFnTnJDZ3VCcGx0R0hQRi9mN1FHNlQ5V3dibjQ2MkRncDBPell6WXdjeU44?=
 =?utf-8?B?cHd1ZnhqUjgreW1ZQWFvSFVTZy9PeUpTcmdsTXV4MjJtM3djUm5hSGtIMGhR?=
 =?utf-8?B?Qy9FSXM4aUkxUHgyVGw5a3NCaFM3T3lGWkN6ejBja04rL1JENDR0WXhoOXJ6?=
 =?utf-8?B?RDVNSkVxWXdqaFlXUTZzRkhVWjFqbTdhL1NkMUZMdFNUQUhjVkFPcGtYTm5r?=
 =?utf-8?B?ZWMxVUJKcC9VYTkzL1lzT09heVVoRXNWSnJEdGFQYy9kb0E4UENhcnV2YWtO?=
 =?utf-8?B?cjJwRFVtcWlxU3hyYlpZTFJYRm9vWXh2R1lUQ3c3NHd1dmsxeXVnaDRTNm5E?=
 =?utf-8?B?TmpaWW92dHVaZVBHTGhPb1I1VVlTWDljSmcyRDRwSkdEK0FDTjlJc0FNS3l2?=
 =?utf-8?B?UVhteU1nUHMrbTg5SjllM1daanhjbnJ5L1JMYkJ6UU1qWGVycVlmbU9KQzF1?=
 =?utf-8?B?dkZhRzBQbTBWMU5SRERqOGtuamdLbXh5Nnc1NXFENHpBa0l5T3NMS2JGeFlQ?=
 =?utf-8?B?UExHR1BYWCtQeU9ONS83T1k2V2NUK3Btb0JyaEpoWC96NDFTM1RITDk5cE1E?=
 =?utf-8?B?RG1FR0pFakRoS2k4QnRFZWNUVUwrVnhNbWlKZGo0OWxxVEVnYkdhVmRPVlJZ?=
 =?utf-8?B?Y0pDVXZqa1pYU1dZY29kbVZ0L1N0TDYwRmZGcHlRQ29hZ0JYNjdva0VpTlR4?=
 =?utf-8?B?VHRoYWVOa3R5VW9kMUowL0s5ZGcyUzF3RHNlNWszblJZTVhqaDZvYXBHMTho?=
 =?utf-8?B?dzladnY3UU5lVkZpWGljQ2llVTBNQVZjcjhDK1pFTzFIYW03ZkRLQVBGOFRt?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D51CD0A4591134A86898A813E0D74A4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7219.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 854f6c34-8a73-4983-a7d3-08dc804a621c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 01:46:54.1503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3BxuH+1x44U79IhmNdBbQUGp3eVjjmOubyIAqm2JJCRg7memha592OW03WO2m7SjVBMypCcOH4yuAR99MCJ15NKyv35N7c+4eWj+K+/8sCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6776
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--35.562400-8.000000
X-TMASE-MatchedRID: ng/CxAXAtvvUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCvg6JVNagPxEmlaAItiONP1sro1pLtThlC62hjZS0WoY+87
	6KLWQRT3oZhkFaHHn+jQvuFj/ABA6foP8n93yeyS/W88A/PbYWWHn2exfZC4LdglcMH9WvorS7l
	9oY/zO1ITs/K2vTSkmR/rLbgiK0qfpxfgwmjaGmbMjW/sniEQKsEf8CpnIYtnfUZT83lbkEDXdz
	535oUyncG0MRoabZqItzrR8/DOKly2W7Y+Npd9Rl1zsjZ1/6ayRPtwwl97om/iynjEO4PxspVwX
	L8sTVNLU1O68dJT01r59kd3tU9KQF/5MvE19+Drzh2yKdnl7WHFvlcB5q2DlJxXJwKAKea/lGPX
	tygG6B6QMBSslHxKEMPWw250euu8qvVOPrBalENjko+KiQPUGZV3I+XI0DVK6pZ/o2Hu2YUQpLL
	jhlj23J33xEljo07yu7L71B3I1KfkixIx8lCPlHPYwOJi6PLmgD0t7xcmlukENV4Lwnu7BbsTaW
	d4cSvSAYikR0dWTeQLOiNEiqZV1okxfHrKxz/YtwsCVUafM+pVl8bxyvq1ea3i4wb5+qKyEPcQg
	Sz36SHB3rJH2Dr3Iuyr9EDhG9KQYB2fOueQzj9IFVVzYGjNKWQy9YC5qGvz6APa9i04WGCq2rl3
	dzGQ1DBbGvtcMofyUTGVAhB5EbQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--35.562400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	A3608761AFD42AA914AF0447C408C4F57B56EBC92A67D0EF4917D6FD776F738E2000:8

T24gV2VkLCAyMDI0LTA1LTI5IGF0IDE3OjUwICswMDAwLCBTdW5pbCBLb3Z2dXJpIEdvdXRoYW0g
d3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2Vu
ZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgT24gTW9uLCAyMDI0LTA1LTI3IGF0IDE3OjEzICswMTAw
LCBEYW5pZWwgR29sbGUgd3JvdGU6DQo+ID4gPiBPbiBNb24sIE1heSAyNywgMjAyNCBhdCAwMzo1
NTo1NVBNIEdNVCwgU3VuaWwgS292dnVyaSBHb3V0aGFtDQo+ID4gd3JvdGU6DQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
ID4gPiA+ID4gPiBGcm9tOiBGcmFuayBXdW5kZXJsaWNoIDxsaW51eEBmdy13ZWIuZGU+DQo+ID4g
PiA+ID4gPiA+IFNlbnQ6IE1vbmRheSwgTWF5IDI3LCAyMDI0IDc6NTIgUE0NCj4gPiA+ID4gPiA+
ID4gVG86IEZlbGl4IEZpZXRrYXUgPG5iZEBuYmQubmFtZT47IFNlYW4gV2FuZyA8DQo+ID4gPiA+
ID4gPiA+IHNlYW4ud2FuZ0BtZWRpYXRlay5jb20+Ow0KPiA+ID4gPiA+ID4gPiBNYXJrIExlZSA8
TWFyay1NQy5MZWVAbWVkaWF0ZWsuY29tPjsgTG9yZW56byBCaWFuY29uaQ0KPiA+ID4gPiA+ID4g
PiA8bG9yZW56b0BrZXJuZWwub3JnPjsgRGF2aWQgUy4gTWlsbGVyIDwNCj4gZGF2ZW1AZGF2ZW1s
b2Z0Lm5ldD4NCj4gPiA+ID4gOyBFcmljDQo+ID4gPiA+ID4gPiA+IER1bWF6ZXQNCj4gPiA+ID4g
PiA+ID4gPGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwu
b3JnPjsNCj4gPiA+ID4gUGFvbG8NCj4gPiA+ID4gPiA+ID4gQWJlbmkNCj4gPiA+ID4gPiA+ID4g
PHBhYmVuaUByZWRoYXQuY29tPjsgTWF0dGhpYXMgQnJ1Z2dlciA8DQo+ID4gPiA+IG1hdHRoaWFz
LmJnZ0BnbWFpbC5jb20+Ow0KPiA+ID4gPiA+ID4gPiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdu
byA8DQo+ID4gPiA+ID4gPiA+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNv
bT4NCj4gPiA+ID4gPiA+ID4gQ2M6IEZyYW5rIFd1bmRlcmxpY2ggPGZyYW5rLXdAcHVibGljLWZp
bGVzLmRlPjsgSm9obg0KPiA+ID4gPiBDcmlzcGluDQo+ID4gPiA+ID4gPiA+IDxqb2huQHBocm96
ZW4ub3JnPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgDQo+ID4gPiA+ID4gPiA+IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiA+ID4gPiA+IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZzsgDQo+ID4gPiA+ID4gPiA+IGxpbnV4LW1lZGlhdGVrQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7DQo+ID4gPiA+ID4gPiA+IERhbmllbCBHb2xsZSA8ZGFuaWVsQG1ha3JvdG9w
aWEub3JnPg0KPiA+ID4gPiA+ID4gPiBTdWJqZWN0OiBbbmV0IHYyXSBuZXQ6IGV0aGVybmV0OiBt
dGtfZXRoX3NvYzogaGFuZGxlIGRtYQ0KPiA+ID4gPiBidWZmZXINCj4gPiA+ID4gPiA+ID4gc2l6
ZSBzb2Mgc3BlY2lmaWMNCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gRnJvbTogRnJhbmsg
V3VuZGVybGljaCA8ZnJhbmstd0BwdWJsaWMtZmlsZXMuZGU+DQo+ID4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiA+IFRoZSBtYWlubGluZSBNVEsgZXRoZXJuZXQgZHJpdmVyIHN1ZmZlcnMgbG9uZyB0
aW1lIGZyb20NCj4gPiA+ID4gcmFybHkgYnV0DQo+ID4gPiA+ID4gPiA+IGFubm95aW5nIHR4DQo+
ID4gPiA+ID4gPiA+IHF1ZXVlIHRpbWVvdXRzLiBXZSB0aGluayB0aGF0IHRoaXMgaXMgY2F1c2Vk
IGJ5IGZpeGVkIGRtYQ0KPiA+ID4gPiBzaXplcw0KPiA+ID4gPiA+ID4gPiBoYXJkY29kZWQgZm9y
DQo+ID4gPiA+ID4gPiA+IGFsbCBTb0NzLg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBV
c2UgdGhlIGRtYS1zaXplIGltcGxlbWVudGF0aW9uIGZyb20gU0RLIGluIGEgcGVyIFNvQw0KPiA+
ID4gPiBtYW5uZXIuDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IEZpeGVzOiA2NTZlNzA1
MjQzZmQgKCJuZXQtbmV4dDogbWVkaWF0ZWs6IGFkZCBzdXBwb3J0IGZvcg0KPiA+ID4gPiBNVDc2
MjMNCj4gPiA+ID4gPiA+ID4gZXRoZXJuZXQiKQ0KPiA+ID4gPiA+ID4gPiBTdWdnZXN0ZWQtYnk6
IERhbmllbCBHb2xsZSA8ZGFuaWVsQG1ha3JvdG9waWEub3JnPg0KPiA+ID4gPiA+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBGcmFuayBXdW5kZXJsaWNoIDxmcmFuay13QHB1YmxpYy1maWxlcy5kZT4NCj4g
PiA+IA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gLi4uLi4uLi4uLi4uLi4NCj4gPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lZGlhdGVr
L210a19ldGhfc29jLmMNCj4gPiA+ID4gPiA+ID4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWRp
YXRlay9tdGtfZXRoX3NvYy5jDQo+ID4gPiA+ID4gPiA+IGluZGV4IGNhZTQ2MjkwYTdhZS4uZjFm
ZjFiZTczOTI2IDEwMDY0NA0KPiA+ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9tZWRpYXRlay9tdGtfZXRoX3NvYy5jDQo+ID4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0
L2V0aGVybmV0L21lZGlhdGVrL210a19ldGhfc29jLmMNCj4gPiA+IA0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gLi4uLi4uLi4uLi4uLg0KPiA+ID4gPiA+ID4gPiBAQCAtMTE0Miw0MCArMTE0Miw0NiBA
QCBzdGF0aWMgaW50IG10a19pbml0X2ZxX2RtYShzdHJ1Y3QNCj4gPiA+ID4gbXRrX2V0aA0KPiA+
ID4gPiA+ID4gPiAqZXRoKQ0KPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY250ICogc29jLQ0KPiA+ID4gPiA+ID4gPiA+dHguZGVzY19zaXplLA0KPiA+ID4gPiA+ID4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmV0aC0NCj4gPiA+ID4gPiA+ID4gPnBoeV9z
Y3JhdGNoX3JpbmcsDQo+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBH
RlBfS0VSTkVMKTsNCj4gPiA+IA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gLi4uLi4uLi4uLi4uLi4N
Cj4gPiA+ID4gPiA+ID4gLSAgZm9yIChpID0gMDsgaSA8IGNudDsgaSsrKSB7DQo+ID4gPiA+ID4g
PiA+IC0gICAgICBkbWFfYWRkcl90IGFkZHIgPSBkbWFfYWRkciArIGkgKg0KPiBNVEtfUURNQV9Q
QUdFX1NJWkU7DQo+ID4gPiA+ID4gPiA+IC0gICAgICBzdHJ1Y3QgbXRrX3R4X2RtYV92MiAqdHhk
Ow0KPiA+ID4gPiA+ID4gPiArICAgICAgZG1hX2FkZHIgPSBkbWFfbWFwX3NpbmdsZShldGgtPmRt
YV9kZXYsDQo+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICBldGgtPnNjcmF0Y2hfaGVh
ZFtqXSwgbGVuICoNCj4gPiA+ID4gPiA+ID4gTVRLX1FETUFfUEFHRV9TSVpFLA0KPiA+ID4gPiA+
ID4gPiArICAgICAgICAgICAgICAgICAgRE1BX0ZST01fREVWSUNFKTsNCj4gPiA+ID4gPiA+ID4N
Cj4gPiA+IA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQXMgcGVyIGNvbW1pdCBtc2csIHRoZSBmaXgg
aXMgZm9yIHRyYW5zbWl0IHF1ZXVlIHRpbWVvdXRzLg0KPiA+ID4gPiA+IEJ1dCB0aGUgRE1BIGJ1
ZmZlciBjaGFuZ2VzIHNlZW1zIGZvciByZWNlaXZlIHBrdHMuDQo+ID4gPiA+ID4gQ2FuIHlvdSBw
bGVhc2UgZWxhYm9yYXRlIHRoZSBjb25uZWN0aW9uIGhlcmUuDQo+ID4gDQo+ID4gPg0KPiA+ID4g
KkkgZ3Vlc3MqIHRoZSBtZW1vcnkgd2luZG93IHVzZWQgZm9yIGJvdGgsIFRYIGFuZCBSWCBETUEN
Cj4gPiBkZXNjcmlwdG9ycw0KPiA+ID4gbmVlZHMgdG8gYmUgd2lzZWx5IHNwbGl0IHRvIG5vdCBy
aXNrIFRYIHF1ZXVlIG92ZXJydW5zLCBkZXBlbmRpbmcNCj4gPiBvbg0KPiA+ID4gdGhlDQo+ID4g
PiBTb0Mgc3BlZWQgYW5kIHdpdGhvdXQgaHVydGluZyBSWCBwZXJmb3JtYW5jZS4uLg0KPiA+ID4N
Cj4gPiA+IE1heWJlIHNvbWVvbmUgaW5zaWRlIE1lZGlhVGVrIChJJ3ZlIGFkZGVkIHRvIENjIG5v
dykgYW5kIG1vcmUNCj4gPiA+IGZhbWlsaWFyDQo+ID4gPiB3aXRoIHRoZSBkZXNpZ24gY2FuIGVs
YWJvcmF0ZSBpbiBtb3JlIGRldGFpbC4NCj4gIA0KPiA+V2UndmUgZW5jb3VudGVyZWQgYSB0cmFu
c21pdCBxdWV1ZSB0aW1lb3V0IGlzc3VlIG9uIHRoZSBNVDc5ODg4IGFuZA0KPiA+aGF2ZSBpZGVu
dGlmaWVkIGl0IGFzIGJlaW5nIHJlbGF0ZWQgdG8gdGhlIFJTUyBmZWF0dXJlLg0KPiA+V2Ugc3Vz
cGVjdCB0aGlzIHByb2JsZW0gYXJpc2VzIGZyb20gYSBsb3cgbGV2ZWwgb2YgZnJlZSBUWCBETUFE
cywNCj4gdGhlDQo+ID5UWCBSaW5nIGFsb21vc3QgZnVsbC4NCj4gPlNpbmNlIFJTUyBpcyBlbmFi
bGVkLCB0aGVyZSBhcmUgNCBSeCBSaW5ncywgd2l0aCBlYWNoIGNvbnRhaW5pbmcNCj4gMjA0OA0K
PiA+RE1BRHMsIHRvdGFsaW5nIDgxOTIgZm9yIFJ4LiBJbiBjb250cmFzdCwgdGhlIFR4IFJpbmcg
aGFzIG9ubHkgMjA0OA0KPiA+RE1BRHMuIFR4IERNQURzIHdpbGwgYmUgY29uc3VtZWQgcmFwaWRs
eSBkdXJpbmcgYSAxMEcgTEFOIHRvIDEwRyBXQU4NCj4gPmZvcndhcmRpbmcgdGVzdCwgc3Vic2Vx
dWVudGx5IGNhdXNpbmcgdGhlIHRyYW5zbWl0IHF1ZXVlIHRvIHN0b3AuDQo+ID5UaGVyZWZvcmUs
IHdlIHJlZHVjZWQgdGhlIG51bWJlciBvZiBSeCBETUFEcyBmb3IgZWFjaCByaW5nIHRvDQo+IGJh
bGFuY2UNCj4gPmJvdGggVHggYW5kIFJ4IERNQURzLCB3aGljaCByZXNvbHZlcyB0aGlzIGlzc3Vl
Lg0KPiANCj4gT2theSwgYnV0IGl04oCZcyBzdGlsbCBub3QgY2xlYXIgd2h5IGl04oCZcyByZXN1
bHRpbmcgaW4gYSB0cmFuc21pdA0KPiB0aW1lb3V0Lg0KPiBXaGVuIHRyYW5zbWl0IHF1ZXVlIGlz
IHN0b3BwZWQgYW5kIGFmdGVyIHNvbWUgVHggcGt0cyBpbiB0aGUgcGlwZWxpbmUNCj4gYXJlIGZs
dXNoZWQgb3V0LCBpc27igJl0DQo+IFR4IHF1ZXVlIHdha2V1cCBub3QgaGFwcGVuaW5nID8NCj4g
IA0KWWVzLCB0aGUgdHJhbnNtaXQgdGltZW91dCBpcyBjYXVzZWQgYnkgdGhlIFR4IHF1ZXVlIG5v
dCB3YWtpbmcgdXAuDQpUaGUgVHggcXVldWUgc3RvcHMgd2hlbiB0aGUgZnJlZSBjb3VudGVyIGlz
IGxlc3MgdGhhbiByaW5nLT50aHJlcywgYW5kDQppdCB3aWxsIHdha2UgdXAgb25jZSB0aGUgZnJl
ZSBjb3VudGVyIGlzIGdyZWF0ZXIgdGhhbiByaW5nLT50aHJlcy4NCklmIHRoZSBDUFUgaXMgdG9v
IGxhdGUgdG8gd2FrZSB1cCB0aGUgVHggcXVldWVzLCBpdCBtYXkgY2F1c2UgYQ0KdHJhbnNtaXQg
dGltZW91dC4NClRoZXJlZm9yZSwgd2UgYmFsYW5jZWQgdGhlIFRYIGFuZCBSWCBETUFEcyB0byBp
bXByb3ZlIHRoaXMgZXJyb3INCnNpdHVhdGlvbi4NCj4gIA0KPiBUaGFua3MsDQo+IFN1bmlsLg0K
PiANCj4gIA0K

