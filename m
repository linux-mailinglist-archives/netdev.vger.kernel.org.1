Return-Path: <netdev+bounces-99010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4768D359E
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 13:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4A01F23A5D
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 11:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D79E180A65;
	Wed, 29 May 2024 11:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fcjTkmyI";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="StnD9q2K"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F2B13DDB1;
	Wed, 29 May 2024 11:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716982530; cv=fail; b=nnk36Oq0ImBv29ktDJRsT6tGWw+wwf0z7nZhlnL2Q45e+axLA2CKLwXRsohfJfu7CgUaKOTEKWNsJuCqmuQwO+dx1LE1CaCafqgLttC3FjHF/b0w8ifD2Gh/hmK1ZAl3w9g6WpSXaZ1UnlX8JKbVWnGkelICJE2YctJ6RaFL0RI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716982530; c=relaxed/simple;
	bh=KAN9AUNNftvUye3ftZdkF5AdVXaTqn23Uhsp8o3WDOc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=smqW7S1OhCnxsmApPoz4QsTTIprBu6AmOVKCA8X/GCjlweOb5/G7LSJA6SLG3KMrxbJDusJvsTzKKmrw7l8jscTLQYzA5eBqqrJylJUT8slH1hLeHKmTRgaqrUoHR5Mnj/shOch5v6cMX/dwksFfcUGA7vdMMpYcWOc3jMEtZqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=fcjTkmyI; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=StnD9q2K; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 888bf5ba1daf11ef8c37dd7afa272265-20240529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=KAN9AUNNftvUye3ftZdkF5AdVXaTqn23Uhsp8o3WDOc=;
	b=fcjTkmyIPeRS7/8MRRCHdNtkG1XMbeZquYSFMLj1nId/llZ1TchHnR7GdyCuj9xvBORhT9oHm3KCO8FDpvxaREgKs9qZc+t1oVP200/dtRJ9vpp1BGQbdUWHcnLQNCX/5j61nxPHgA5UHWkcrcfmZnj9dLf87DMW2QAozp4VWiA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:d4f0e784-7b96-49e3-b2d1-944da359c295,IP:0,U
	RL:35,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:35
X-CID-META: VersionHash:393d96e,CLOUDID:1029f443-4544-4d06-b2b2-d7e12813c598,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:11|46|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 888bf5ba1daf11ef8c37dd7afa272265-20240529
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <lena.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 394615376; Wed, 29 May 2024 19:35:21 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 29 May 2024 19:35:20 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 29 May 2024 19:35:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcsGBeYj7TVrOjUH+ffl9IYS7aXdGXfMk0G6kzP/asypkJtMDwl8e5/FHI2dUeekaNL4SyJZ20AcNuqm9X4EqD86aaqacrUjSS8UXWeTvGKX2iLzCjqjBjIEDfEtz7wnytMPoGWRyBsr1b2tzpZ36EVJbTuAwG65G1OvxNEvOx9z4Y0QdQ0AQ67mN8aWXccKy2snlg2RPMKamt2Z7mNhQ0waMfDuh2gWRok/CGcgBWDyRQ4uV3NlWqcTGIxMJi9iIscNlV6tSQPBAZZY0YDogyiWoskqpn1RUHz66B/tCJhFn6iZkwhXQUb0wDZudUkIBnhyml0nDQS/mA4afMQHOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAN9AUNNftvUye3ftZdkF5AdVXaTqn23Uhsp8o3WDOc=;
 b=aFBFjohSl3AcDGmeJYE8ztmE3XGcNHGEUw+Xen1H3hbPAZZ1IpwYyIcfYc8Qvmv6Jg2b6/0YPRkrMyypAm7BgAbnIjxBkE0tNuj+jhvYsIn95fpWCCEYwxFbIuBmhAXrnQVomVYxATfm55lYsbCqWPBEvUuat1V1kVncIvQZ3ni7MGhJy0MICjA0wR1PX1vMjb6OmyTbHN9lgYrIirVSBezuWJWXySqfElwyMwrjNmMSwyD5RF8wCz60l3iNjQ36p/wOpywDEtX9j6wDlevdO3uwqfqjUws0Axo4N9BGuAoyALiPi6RyT2pIW84udxRcpIH3dsdlMUOFRJVizhVVEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAN9AUNNftvUye3ftZdkF5AdVXaTqn23Uhsp8o3WDOc=;
 b=StnD9q2KkzOnnZ2A4r5j832q/j3FGGPyLitKd06LwHoHj3j8L1espcZ7qMh/0tjvDjg/5ji9ISxS4CQJ72AsJXVPaoaqoLxP1EvlhvS19rm2SmiNij4/kX5s306Bg3uwBgmTW0RlM9xZ3b5YY4lMiWdlH9jWZTMzBew1ZWKHfN0=
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8)
 by SEYPR03MB8390.apcprd03.prod.outlook.com (2603:1096:101:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 11:35:18 +0000
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::54f:1c26:8bd1:5824]) by SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::54f:1c26:8bd1:5824%4]) with mapi id 15.20.7633.001; Wed, 29 May 2024
 11:35:18 +0000
From: =?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
To: "kuba@kernel.org" <kuba@kernel.org>, "willemdebruijn.kernel@gmail.com"
	<willemdebruijn.kernel@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	=?utf-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?=
	<Shiming.Cheng@mediatek.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "davem@davemloft.net"
	<davem@davemloft.net>
Subject: Re: [PATCH net] net: prevent pulling SKB_GSO_FRAGLIST skb
Thread-Topic: [PATCH net] net: prevent pulling SKB_GSO_FRAGLIST skb
Thread-Index: AQHamXh3SQ+1lKsnl0u0DlYO3sGEgbF/Qx+AgBjXXoCAAfkjAIAKqqeAgAAtOYCAACVQAIAJNP+A
Date: Wed, 29 May 2024 11:35:18 +0000
Message-ID: <782b9eb64af66eba132ac6382305d407e33dd604.camel@mediatek.com>
References: <20240428142913.18666-1-shiming.cheng@mediatek.com>
	 <20240429064209.5ce59350@kernel.org>
	 <bc69f8cc4aed8b16daba17c0ca0199fe6d7d24a8.camel@mediatek.com>
	 <20240516081110.362cbb51@kernel.org>
	 <15675c6e0facd64b1cdc2ec0ded32b84a4e5744b.camel@mediatek.com>
	 <664f3aa1847cc_1a64412944f@willemb.c.googlers.com.notmuch>
	 <664f59eedbee7_1b5d24294ef@willemb.c.googlers.com.notmuch>
In-Reply-To: <664f59eedbee7_1b5d24294ef@willemb.c.googlers.com.notmuch>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6466:EE_|SEYPR03MB8390:EE_
x-ms-office365-filtering-correlation-id: bfbe7df0-b58f-47b8-afb0-08dc7fd36aaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?VFJUUkxYa0ZEc25uT1NDcXgwbVVKZ3dIeThWWXFMMENoQ1R5WHFSUEJqUmFR?=
 =?utf-8?B?U2F1Zm45b2RPV2JVSUxvQXk0Wm5oZ2JGWmV2Z05Od3lQWG13NmdXN2M0Snk1?=
 =?utf-8?B?cENINkUzTjR5a0VaVmd1Y1VpaU9rVGNtNnFIdUtIYkdOeldHdksyL2d2ajBI?=
 =?utf-8?B?QW1sbGU1Kzl0aEgzV2JkVGljaEl2c1VFV053M0hUbnBvWEtDWk80eHpNUmU4?=
 =?utf-8?B?Z3hRSyt1M2VWcHowMmJrbG15Y0FhcnV3eTQxQVloeU1DSENOSHllbndrTUQ5?=
 =?utf-8?B?U1Nlc0lha0QyZnZjODE1aW4zTlBqUENPTkRzSXBid3NLNVVpN1JVYUx1NlV6?=
 =?utf-8?B?YWpFRWhVVnhKYjhRSWluMXZvYWJnaG9QZHBvTFRnUnhXckZ2cllZdHVVdll2?=
 =?utf-8?B?dUx0NzZlaUNLRm1uRGZ5dU5FZzlGOFJ5Wk51bml6V1VYTTdWZjA1VXB4YTZM?=
 =?utf-8?B?NWRpYkM1MkhHbzhDcWJrU3JLOWF0cWlmbGpjbHBCWVVpK0wwc3FzTktWV1JX?=
 =?utf-8?B?VHBPVVV2RHdVSTlMaTU4VG41NFo2ZnJxZWxnYjRHOTNIR2plQUgrKzlvR2l3?=
 =?utf-8?B?WW9LMzIzRWJRZWJRT3h2SHNLZDFDV20vN2xTUlVodE9HY05DdTVlb3Z4amN4?=
 =?utf-8?B?QkpFWGpLcUR1YlkzcFBwNDdBM2RmVWhxWWhBK2I0RXlBMk5GalA3aUdyQncw?=
 =?utf-8?B?SHFuUU5PRnRTZHcyNmJZQjd2QUdNMUdwWVJ3bXh1d0dNS1hJSkFtQnlhei9y?=
 =?utf-8?B?dTFtSjVkLzVUaGxJTEp3cTFpcDNGM1FwSmtxU1hnR29TemVFbGxveWl4VTdG?=
 =?utf-8?B?RUdpUzVmQmNFcHltTW54eFpsS0dIbHNpNDB5ck5raUk1MU1KeHRRSDB3dGJk?=
 =?utf-8?B?RHlkdTlRTk14WEg0SG1yMjQ0WU11T245WVYrS0M1UmNJd0tTUldxWFUyRUpD?=
 =?utf-8?B?R1ZmWEFnclhnQzRtK0dYNTAwbkdoeHZ1Z0I0WmRxcTZ4WGJ1ZjJ3bUMxaXdz?=
 =?utf-8?B?TTNmTEkrRFVHZXd0SHFKSENuZ0ptZDNEWDV6SFY4SXdJOGlJL3IzT0hpVWtS?=
 =?utf-8?B?bW5uREU2U2F5VXh2dERtSjdPY0x6S2V6Ukc5MDROeElCcWtyVThGQnVpbHda?=
 =?utf-8?B?UTdreDAzK1VIdmRBYzAyanlnSkRYelordGVzSU5DZ0M5MnVVYTczUXN1TWNL?=
 =?utf-8?B?bUpERTFRNTU4a0JtTjNWbHRPd3REYXo3TDhOcWEzSDRlckwzQ2pOSEZJeUNW?=
 =?utf-8?B?SUVMdXVDY3JONDhhOUN4NCt6YUtYemlEdVNsUXg4MFV0Q0QxTnI1bEV0MWgr?=
 =?utf-8?B?S01QV1hSTDFiMnlNWmkrektoYkptcDlhLy9hMzRaRHloS0NVNEtTMVR3Z3Rx?=
 =?utf-8?B?S1hFcm1RSGh3dE1tZFRRZzRoSWNUQlh1K3Fpdzl1RHR6aWthK3VXbFpxVnFW?=
 =?utf-8?B?THVPOFBKTWpDMTBZNVhDYWRCVExYeWl5Q2hjMHRxN3VzYzUwb0U3OTNhUURT?=
 =?utf-8?B?aTYyeUlkLy94Um5PTHAwd2ZYQTRFZktkUDlpUlBYOXN5SnZYckx3TXpVaUxD?=
 =?utf-8?B?UEFZT3Z3bkhmV0NZdHg3NlF3SXQ5R0lkK2txemZKMGJ2NEVSRnllMWsrT0Nq?=
 =?utf-8?B?djI4MDZ5STNkTXFRWGNRcXlBT2VwYXJTR1JrUVV1M28vMmdSMi93UDlVcjI1?=
 =?utf-8?B?bEZaZ1QvN29qMnZGL05TR1dnV0JCZDVuVmNVdSsxNGU0OWVsOWpubHBGalZI?=
 =?utf-8?Q?4ughYvbEVTBeIRoI8E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6466.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3lGeDBxUm1NMlZSSXVTYXljOGZBc0RnZ25VRG4xSld4bzR2TGFsMC8vc2Q2?=
 =?utf-8?B?cXR0Vks3YVRZZThJWkJCZHo2QWxkaVRQWFcvSzJTRHBXSE1SSXkzYWdLUFJ3?=
 =?utf-8?B?Wm9FTVJSREVub29sNmI0YStaWjB0YkIvNU5xRENtc2ZRZjZKQmdVOUFsbFp3?=
 =?utf-8?B?YldYay9DMU52WkNob0dyWVdNU0MwZXJwclk0NzFTMUZ5WlpKM0Z4N0lFc0J5?=
 =?utf-8?B?ZU5kVmZja1RhZEt4S2FWdFZUR0YxMnBvU0VleHN4MGZDbUJHMWZNbmU4U0Vj?=
 =?utf-8?B?bDczQXY1QWd4cFRsMk5WcGhXT1E0ektybUozSmc0WjZObElLSVhZcldBQ0RX?=
 =?utf-8?B?Tmw5dVVNZk04UUx2WVYyZGY0TkZqcUZWWEk1R01mQWxqc1ducTRjOXd4b3d3?=
 =?utf-8?B?cnRXaWZGazluejdQSi9uNHNwWnlXNkZ5eVZPM0F3cXVtRXJ6czBGVHN2K2JC?=
 =?utf-8?B?RUhDMjdXY0dtamIzTW9Nbkx5MER4blBRTVYzQytqTG8vV00rMlZDZXpBU2tt?=
 =?utf-8?B?Nzg5UVdRejJWNnN4OUlCSE9FcmZhdFlabm1hck1RTGFMNldDWW42NldRU2w3?=
 =?utf-8?B?UVBkSkhNTGlnejdjTnlBR2hCTEtGRU9qNndFZGRTcUkyb2M5UmFNbzJENWhi?=
 =?utf-8?B?MFV1dU1Scm9kUk1RZmFLNXBBUjJ6c04yTXhsMGRqT2J0aVpTVjZjczk3K3NF?=
 =?utf-8?B?ZUVWTUl4d0FCTzFIbG93UDc5OWZ6NDdaSm0rV0FveUJ0MFRuRzc3cmxnQ1Qz?=
 =?utf-8?B?VWJMQmt3TGc0K3Y0QnhPTmd3R2ZJdlFrNVgzZU0walFCNDdRbkpkYXIrSkVq?=
 =?utf-8?B?cmlWdktkOWgxdzExNzRodFBLNlNvMG9iVmhHWm5TYTBKWHRpcmtlMldOM2JD?=
 =?utf-8?B?UEVIS3FHb2VjdTlUZEgwenoyKzYwREZqbXRGOWlyYXNDaEQwbjVreVpETGdi?=
 =?utf-8?B?eVg4emxJM0ZwMHN2Ri90MWFmZU40eTIrV3BpNkRzdlVsd1l1cWJBWFZqeCt0?=
 =?utf-8?B?VGdNUkJWUmw2Y1BxRi9NYTRRbGY3MDhiYW4wVTVsbElLSmRYRDUrOEhzMTN0?=
 =?utf-8?B?SU8vYzdYbWNMWUF3T0svTzBCVXFuaWxXdjhtN1QwalVtTEViY0JoSXpNd3Jw?=
 =?utf-8?B?RWdoL3NORTQ0cGF3YTJ6aTlka1g5R3pwL3Y5TndURUV2OHpjTDg5M3JjM09o?=
 =?utf-8?B?MDVjODB1Nm9uOENvSXFHYkt0WThVVDhESFUwT1FFT3FvbmFIWWZwaWQwL254?=
 =?utf-8?B?eHA2UDlvc3hhMXJrUFl0VUI0QkVZcGl1SzJpdmxScFpDeXZNc1ZLMDV4aGlo?=
 =?utf-8?B?bFN4aktIU0xnUHpWazIyMk9oK1dNTUxkNVV6NlkwMUtDei9qTStqenNhYjJz?=
 =?utf-8?B?V0k1bFBNMFp5dk9wWmx5dlVicndCZnVjK1RpdWQ5ZWdBOG82RWNNbGVtSlJ0?=
 =?utf-8?B?R3BPQkNoaEp0MFRENTNXbkZFdmV5blRkZFA1NnVXWXFja0I5RU5xN2VkZllE?=
 =?utf-8?B?V2ZQUDJ6K2lEUnBsZ3oyamkra2hPYU4xU3pTSExtTkdwQXFhTG9XNllCQzJI?=
 =?utf-8?B?ZlNHR1dXeFlhM0JPeFZwYmk5eUVlYVAxWmZJa0hiWlpIcVlHdUU5cWhlK3ZI?=
 =?utf-8?B?bVJMaHFBZlhjdEFYOThXRjJkdnNLNndzUGxocmZmYndhQVRLbHBQNEd0STlu?=
 =?utf-8?B?Ym5PUWJLSjBiNmZneWdLbnFaa05EOXAyekhGYW9EZUl4MjZnZENhb1Urc2Na?=
 =?utf-8?B?RXNMSjVwVUVPSDF4VDRMR2lNMFc0dXRBS1BGUGo5VmNLQXVBaXlmT3Y5cXBR?=
 =?utf-8?B?blFLUHdrQzNTRHkwaFMvbUVHNE9tcVByNVJTTlJ2K1lGVllReitNejQ2ZVRv?=
 =?utf-8?B?Nm91NjFxZmg0dVVEZWpia0VySTdHbm41MGsvdTltQ2o0bmMwMjhaUTJWdk5G?=
 =?utf-8?B?UHVlbzNWbVJJaHNyYU1ORWFKVVVyMkFUcG9NUlVIeGh3aW5BUS9VRTRQV1Qv?=
 =?utf-8?B?L1lkUDlFV2ErR2doZDNWNTh6anFVYU45VTlZWEUxSE0yMXFHUEZQbVBPNlYy?=
 =?utf-8?B?c2wvb2lGTWtDS0V2NnU5TjlkVSs0U29pR09sMGZXMm5qN1o2M3lTVHZvQVF2?=
 =?utf-8?B?eFZ1MVNJcURCUjl3aHF4TzBpZGkydjlwNmpYUlN1dE8wNkVsdTgzN05wOWRL?=
 =?utf-8?B?Z0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <199B0B2DF1E8454A9EB37701FC832B5D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6466.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbe7df0-b58f-47b8-afb0-08dc7fd36aaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 11:35:18.4116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 35Q8XpVsDME6NtKMO1m9P/7B/ti/eIrtMRTY0j8wxHfigC5qyT8ce8niu+Vvtf8lTV80JpowT1i/ZyOr+3hsHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8390

T24gVGh1LCAyMDI0LTA1LTIzIGF0IDEwOjU5IC0wNDAwLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3Rl
Og0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gIFdpbGxlbSBkZSBCcnVpam4gd3JvdGU6DQo+ID4gPiBUaGUgcHJv
YmxlbSBub3cgaXMgdGhlIGV0aHRvb2wgaW4gdWJ1bnR1IGNhbid0IHN1cHBvcnQgInJ4LWdyby0N
Cj4gbGlzdCINCj4gPiA+IGFuZCAicngtdWRwLWdyby1mb3J3YXJkaW5nIiBhbHRob3VnaCBpdCBp
cyB1cGRhdGVkIHRvIHZlcnNpb24gNi43DQo+IGZyb20gDQo+ID4gPiBodHRwczovL21pcnJvcnMu
ZWRnZS5rZXJuZWwub3JnL3B1Yi9zb2Z0d2FyZS9uZXR3b3JrL2V0aHRvb2wuIA0KPiA+ID4gDQo+
ID4gPiBUaGVyZSBpcyBhbm90aGVyIHZlcmlzb24gaW4gDQo+ID4gPiANCj4gaHR0cHM6Ly9naXQu
a2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3Ry
ZWUvbmV0L2V0aHRvb2wNCj4gLg0KPiA+ID4gIFdlIGRvd25sb2FkIHRoZSBzb3VyY2Vjb2RlIGJ1
dCBkb24ndCBrbm93IGhvdyB0byBjb21waWxlIGZvcg0KPiB1YnVudHUgYXMNCj4gPiA+IG5vIC4v
Y29uZmlndXJlIHRoZXJlLg0KPiA+ID4gDQo+ID4gPiBJcyBpdCB0aGUgb25lIHdlIHNob3VsZCB1
c2U/ICBJZiB5ZXMsIGNvdWxkIHlvdSBwbGVhc2Ugc2hvdyBtZQ0KPiBob3cgdG8NCj4gPiA+IGNv
bXBpbGUgYW5kIGluc3RhbGwgdGhpcyBldGh0b29sPw0KPiA+IA0KPiA+IGh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9uZXR3b3JrL2V0aHRvb2wvZXRodG9vbC5naXQgaXMgdGhlDQo+ID4g
dXBzdHJlYW0gZXRodG9vbCByZXBvLg0KPiA+IA0KPiA+IFNpbmNlIHlvdSBhcmUgdGVzdGluZyBh
IGN1c3RvbSBidWlsdCBrZXJuZWwsIHRoZXJlIGFyZSBvdGhlciBoYWNreQ0KPiA+IHdheXMgdG8g
Y29uZmlndXJlIGEgZmVhdHVyZSBpZiB5b3UgbGFjayBhIHVzZXJzcGFjZSBjb21wb25lbnQ6DQo+
ID4gDQo+ID4gLSBqdXN0IGhhcmRjb2RlIG9uIG9yIG9mZiBhbmQgcmVib290DQo+ID4gLSB1c2Ug
WU5MIGV0aHRvb2wgKGJ1dCBmZWF0dXJlcyBpcyBub3QgaW1wbGVtZW50ZWQgeWV0PykNCj4gPiAt
IHdyaXRlIHlvdXIgb3duIG5ldGxpbmsgaGVscGVyDQo+ID4gLSBhYnVzZSBzb21lIGV4aXN0aW5n
IGtlcm5lbCBBUEkgdG8gdG9nZ2xlIGl0LCBsaWtlIGEgcmFyZWx5IHVzZXMNCj4gc3lzdGwNCj4g
DQo+IEFuZCBhcyBzaGFyZWQgb2ZmLWxpbmUsIHZpcnRtZS1uZyAodm5nKSBjYW4gYmUgYSBnb29k
IG9wdGlvbiBmb3INCj4gd29ya2luZyBvbiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cyB0b28uDQo+
IA0KPiBJZGVhbGx5DQo+IA0KPiBgYGANCj4gdm5nIC12IC1iIC1mIHRvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL25ldA0KPiBtYWtlIGhlYWRlcnMNCj4gbWFrZSAtQyB0b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9uZXQNCj4gDQo+IHZuZyAtdiAtciBhcmNoL3g4Ni9ib290L2J6SW1hZ2UgLS11c2VyIHJv
b3QNCj4gIyBpbnNpZGUgdGhlIFZNDQo+IG1ha2UgLUMgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMg
VEFSR0VUUz1uZXQgcnVuX3Rlc3RzDQo+IGBgYA0KPiANCj4gVGhvdWdoIGxhc3QgdGltZSBJIHRy
aWVkIEkgaGFkIHRvIHVzZSBhIHNsaWdodGx5IG1vcmUgcm91bmRhYm91dA0KPiANCj4gYGBgDQo+
IG1ha2UgZGVmY29uZmlnOyBtYWtlIGt2bV9ndWVzdC5jb25maWcNCj4gLi9zY3JpcHRzL2tjb25m
aWcvbWVyZ2VfY29uZmlnLnNoIC1tIC5jb25maWcNCj4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
bmV0L2NvbmZpZw0KPiBtYWtlIG9sZGRlZmNvbmZpZw0KPiBtYWtlIC1qICQobnByb2MpIGJ6SW1h
Z2UNCj4gbWFrZSBoZWFkZXJzDQo+IG1ha2UgLUMgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0
DQo+IA0KPiB2bmcgLXYgLXIgYXJjaC94ODYvYm9vdC9iekltYWdlIC0tdXNlciByb290DQo+IGBg
YA0KPiANCj4gDQo+IA0KaHR0cHM6Ly9scGMuZXZlbnRzL2V2ZW50LzE3L2NvbnRyaWJ1dGlvbnMv
MTUwNi9hdHRhY2htZW50cy8xMTQzLzI0NDEvdmlydG1lLW5nLnBkZg0KDQpEZWFyIFdpbGxlbSwN
CkluIGh0dHBzOi8vZ2l0aHViLmNvbS9hcmlnaGkvdmlydG1lLW5nIGl0IG5lZWRzIGtlcm5lbCA2
LjUgdG8gc2V0dXAuDQpDdXJyZW50IG91ciBlbnZpcm91bWVudCBkb2Vzbid0IHN1cHBvcnQgYW5k
IHdlIHByZXBhcmUgdG8gaW5zdGFsbCBhIFBDDQp3aXRoIGEgbmV3IHVidW50dTIyLjA0Lg0KDQpE
byB5b3Uga25vdyBhbnkgcmVxdWVzdCBmb3IgdWJ1bnR1IHZlcnNpb24gdG8gcnVuIHZuZywgV2hp
Y2ggdmVyc2lvbiBpcw0KbW9yZSBmaXQgZm9yPw0KDQpUaGFua3MNCkxlbmENCg0K

