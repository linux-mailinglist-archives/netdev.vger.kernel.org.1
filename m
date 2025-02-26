Return-Path: <netdev+bounces-169696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7610FA4547E
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 05:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C4017AC72
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 04:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D8326E17D;
	Wed, 26 Feb 2025 04:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iGV4yn9N";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="fz7rGobh"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0914926E162;
	Wed, 26 Feb 2025 04:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740543308; cv=fail; b=f5vzdvHN6TtARMP1cJL8wZeiJiFwERF8G3qUhU0GkR8Fn2eXG7Y2stXAabcEA6VYEOi8xqNMpYNmonP7v32BnK+uhXJIT7duKFSPnSkB81aTzbIq+Sj49aXcZ3RRLEiK7wJn2BApq4pPU2KTCmY29GYvLBP8NJeKfEBEzd4snq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740543308; c=relaxed/simple;
	bh=gERJjsNv+SQWp7iod4lLLgyeHwd5DOpEnMbHRWplTSI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XyrERGfrSYEzCfVv3PFUAaurh+p7yhWKOMrrF2WdamyRH+upUYBvby79WocLGJN1uCqaM/H83P3sVVbrEbwprfWWNQa+7M2L+o1zcsyzQmkgXwiYZVoWtRvHKh/7exTnjndhCEYyVECKkBixV4IAGaJR+cL0mJ01lTrhhCs9yLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=iGV4yn9N; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=fz7rGobh; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3f5e0688f3f811efaae1fd9735fae912-20250226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=gERJjsNv+SQWp7iod4lLLgyeHwd5DOpEnMbHRWplTSI=;
	b=iGV4yn9NyRi5MbvIMLi31K0F2vM5TN5SBeKt2+qvThL8a3C/pJmikVV7jLLBU10a0sdhsfiujEp+NNHqw1GjambSA8KlGwxpcgyShYSsGX84Uls666xVyvKdkGj+ybiQhJkWVrCIP/sI1Fyp/nbxiG12fH8X2hNIOiSGi0geClc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:29f23063-a08f-4e33-b597-5a83004b0a7a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:7584eed9-654e-41f2-8a8e-a96c1e834c64,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3f5e0688f3f811efaae1fd9735fae912-20250226
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2007835743; Wed, 26 Feb 2025 12:15:01 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 26 Feb 2025 12:15:00 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 26 Feb 2025 12:14:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=doaBe366B0ObAmSUY3S+biLkQ5hdj+3ZWQB+sOdluY5+npFzExsIRh46Y8/Pf2UAHliBnLU/pdg9zC6mwbpy0omE1Y5RBOFjAyBUtzNpBnA0rg0z31XtERA2//k5KcC9+/oYzMzg9Z5n7iJNMpuuWR9U9QRGBqlhMH+IxLMIL/bh8DrbZ9VC1n4kgyd4ETZCpygU4yFVE11ZWZKESlFmYT9vJKRF9KJ9JUQNhIanRnRtNXRepObEjsuQI5kOPb6vYAM0Qp3a52m27B1wpiw7Kx+CwhaStliRfRQLcc4kRrF1TYVxFBB9uLK0mgU74PYP6XMdM4ktE59dSkNwfEta/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gERJjsNv+SQWp7iod4lLLgyeHwd5DOpEnMbHRWplTSI=;
 b=wwWovJyqM78rQi1RmnrxC4E5PbkHNHadTV4w5qHR9bneQp8+2yBbrnP2EjcvneQPc23DFaDkXfi7m2liEIRCtpkm2NIOXFYboNFA5rTTNG/2Xu2ivxrNHruXsywznErBit6b/4QhFSHm9+PLEhyRcH3Hrf61YtOlw4Te5r67fedKmuNM3nfKngywLV9kHWk1x/2Vm2FpsexttD6znwL2S+Fq1WW5iadj/L7wxVxQ8GH6mSrOsr7GIX8a8A0QC9WI6NIhhZPbYgLnf4fK45T+V5hui2rIRj+s5szvHKBin1RXqTJ8usljk8tIxA1ifXU5jb/Txz4xD0aGCB0XajvNyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gERJjsNv+SQWp7iod4lLLgyeHwd5DOpEnMbHRWplTSI=;
 b=fz7rGobhxDEzZQE6TQCagR0JxmeNsiIb4wfC1EcP4Z85G2+zK/cjaui8rP4tLiMS+28bLSrubi9Qw/8ywnB2jvQm2WnD0wbKHrnBy8aEwLF5owREj22ekPahXCoeYg5mQN/gT1IirAR7zfKjF5sLz995oDz4SK2yWClMJ8AmpjI=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by TYZPR03MB8463.apcprd03.prod.outlook.com (2603:1096:405:70::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 04:14:57 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%5]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 04:14:56 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: =?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"dqfext@gmail.com" <dqfext@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH net-next v2 1/3] net: phy: mediatek: Add 2.5Gphy firmware
 dt-bindings and dts node
Thread-Topic: [PATCH net-next v2 1/3] net: phy: mediatek: Add 2.5Gphy firmware
 dt-bindings and dts node
Thread-Index: AQHbgqnLe8B1VmttFEm1xmvjplPof7NOv+6AgAABHwCACSJvgIAAL8sAgADxXwA=
Date: Wed, 26 Feb 2025 04:14:56 +0000
Message-ID: <c5728ec30db963c97b6e292b51e73e2c075d1757.camel@mediatek.com>
References: <20250219083910.2255981-1-SkyLake.Huang@mediatek.com>
	 <20250219083910.2255981-2-SkyLake.Huang@mediatek.com>
	 <a15cfd5d-7c1a-45b2-af14-aa4e8761111f@lunn.ch>
	 <Z7X5Dta3oUgmhnmk@makrotopia.org>
	 <ff96f5d38e089fdd76294265f33d7230c573ba69.camel@mediatek.com>
	 <176f8fe1-f4cf-4bbd-9aea-5f407cef8ac5@lunn.ch>
In-Reply-To: <176f8fe1-f4cf-4bbd-9aea-5f407cef8ac5@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|TYZPR03MB8463:EE_
x-ms-office365-filtering-correlation-id: a6e51ccf-e642-4d99-a44c-08dd561c20bf
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NnRreUJnTGZ3RzdnV1VEVk1RNE9XM0JxYXBxdm9xYmVZK3d5WnM0UGVHK0JV?=
 =?utf-8?B?ZlJ5YytmdDJxQS9zN09EQWJhZWxLTUxTdHJEMWR6SFJpUFJCVmg1czhzVndh?=
 =?utf-8?B?WVFiQjMvdUFybkVnVjl1Tk9TYmZGb2xTMDJCRVJ5S3lIYVRKdlV2a3RnZEkz?=
 =?utf-8?B?MHFTZHpYNTEyelkyUVErdGdGbEU1N2RxekNZTnZIaHN5WG9JWHAzaVFYK3Vm?=
 =?utf-8?B?MVJyNkxDcUFBNVZ6ckRheFArYmpTcld6VXU5cjY3dmNWSnF3OStSb3N3Qlhj?=
 =?utf-8?B?NE5mYlJrUEc2WXFOcjl0TXBoSzVNOXgwUC95SFROd1RLc2p6SWtLK1F3R0lk?=
 =?utf-8?B?YXBYOVRyb3FZY01jL2tRNS9TOHhxSWc3VTFXanNZaFZNRkhkNE1xQS9ieUhs?=
 =?utf-8?B?M3liQitaUXlUeWxkdVgwTmF4cmVURjA5S2xHN05wZG4yVXdMUk1UZ0xvMjJ1?=
 =?utf-8?B?eHFUSTU3eXJWMkVTVitRaWVGK2prVUxrcVNKaFY1OEwxQk16L3RsMkRJM2Fu?=
 =?utf-8?B?Q1RQWHlWYlNHbE50aW5UZDlqSUttcXVxNk55TWJoa2RZZzZraVgwYTF3RStI?=
 =?utf-8?B?ZlpuTUJ5SWJpZmFiRWlwUGJEZ1E1dTU1bDdvOTZ4VUxuUTIxaVNpUHdFbmJv?=
 =?utf-8?B?bzdkbFhSTzMzNFJJUVRpbHVWNnJwM2UxRWxqdHBKRVNDaHdnZzluM1cvYTd0?=
 =?utf-8?B?Y0xYWHorakRxNEJOUTh3T0xvUlhDSmhJa3QvSk5FRjhKWmRySTROSjdnQ1hJ?=
 =?utf-8?B?TTRIL09tZ3NNQ08zZW5BRDlzWGRFUzRjM2Y3M2xyOFhTYTJnUVBvVEJkUzB0?=
 =?utf-8?B?TTI0QlBEb0dOcEhEa2F1ZlRuMUVvdVpsRnZjYk1CVzNzVUtDdUJrc2JHZEdo?=
 =?utf-8?B?c2lKWDlhUnhEU3FmZ1ZSMjVGQ04zdHJENXRNb0sxaUxHSTVCcDZnVWxXZGpC?=
 =?utf-8?B?NjdtaXk0dFdpQmwzRlZsWFBTdDh5a2hJMU9CTnk0czd5T0UyWUZYZlM5RXho?=
 =?utf-8?B?Z05GdU5FYVlZM1kwVUtLbXBKcXdHN3Z5T21xcHhYSXE5L2ovRUg5RXpTTzl6?=
 =?utf-8?B?bURKdGJMMFE4dDNLc1RvM1F1YmxQK3FncVI5RGJBUytWKzA0TWh4UmJTMUM1?=
 =?utf-8?B?N1d5RTVzZnUrQmFqMEhEVnYwcVhwNVlXM0VMR2tILzN3amhMU1VweXMyWVdk?=
 =?utf-8?B?L004NitzaWY3OWZWQ29oMWtkVGkwdTZpSmpFemREQW9VeGxkcUd2bHArTFZB?=
 =?utf-8?B?aTdta244bHR4TjFXajRRVjdLbGl4RXE4YVJLV3hhN3JpQk9xa3FWVmlVclMz?=
 =?utf-8?B?YTNMZVNwT0FEWjBsc3M1M1FCdzAweGpqQmJld0ozM1pxSnVIZlN0bFNnSVJ0?=
 =?utf-8?B?SGpobU9vYXBoTEZoSWsrbks2UmxFeEk3eFRrOFdrbFBmck9oREJvbkdlS09z?=
 =?utf-8?B?RkY5QXlyb3ltTWhHZDhEYjVlTmNjaFRJK0VWZ3Q4bWloSFVpNkh5N2FOOGdt?=
 =?utf-8?B?bC92SjZnajFocVRWZllBeUhuamFlNkpvTSs5RlUyN0g0aDl3V2JVSjZnTFJr?=
 =?utf-8?B?Rm5vZDA0ZkNTSDdlbzM4eDk5ZzlaMDhudTNtT1I3aTVJdEFTeU44YjlXVkJT?=
 =?utf-8?B?eGJqUndVZEZOKzNNWldKYjNuUGdEemlFbjk1OVNMZjk0aVZZOWcySHBlQ2NP?=
 =?utf-8?B?aVg4MEV4L09sQ2Jmc05mYmZRbEEyTWFXRTZPcG0yWGlEUU5jYWFndkxsUjRW?=
 =?utf-8?B?K2ZGOW5PT1BJdTE3eG5WV0hSL3dJaXZZR0RsY3hhYXZMUHpiVXlTTGVSS2tp?=
 =?utf-8?B?UXJFWG13WWJnZFkxNjBUalBqeFFLb0V3R1N5WU5oL2p0UEpibDFxZms1eit0?=
 =?utf-8?B?blNCMWdTZkZsQjEvakFabkppZ3dHKzFRNy9Vb3U4MTIyS0hPalBhVWV1MWFZ?=
 =?utf-8?Q?4p+Ek3GuQ0ueJSWap8qsREMVRWHUvBkZ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFRaOXM5S2wzVzZUUVZ2UzhueU92cnpqTnNOb0plOEFRT0dBallWWURLbkRW?=
 =?utf-8?B?K2d4RGl1dlNmNFliU2p0aUhDMnNub1FpMmdNdnVxMllDTmVzTi8xT3huK2xz?=
 =?utf-8?B?WnJMM1owYWE4UllEckxjWGtyUlFBeWdCYnF6WkhJNzNtQkhDa3hXN1BXRVUy?=
 =?utf-8?B?bGMxNXpycnBRTVY4bjNYUGF3S0FwQkd6Wi94Q3ZQRy8wdHBIbWFWL25YeTBT?=
 =?utf-8?B?akFDNjZuWElib1JYUDUzNGNjZk8ydThNd1VGcld3SnF1YkZRZUdnY2VBS29w?=
 =?utf-8?B?dStmd2VaUTFEWUZucnJ1WFV0ZDdtcHVjcjAyQUlOL3JuK2V1ZTlVaFoxRFo3?=
 =?utf-8?B?SEliNHJmaDRETlZ5Vkl6TE5ERlhRNSt5MWVLWjNEaXl2czUzeHRueCttQUxu?=
 =?utf-8?B?K001Zm9hYTg2WlFlL2tlZ2lDek9EZXdVNmM4ZngyYmhIUDFKNEI3U2dmbFRz?=
 =?utf-8?B?dnpZWE92RXMxZkdiR28zc2VqTk1Vd0Z3OWJscW1jY0JNWGRwK1lBUUhjK2dG?=
 =?utf-8?B?KzhmdjZRQS85b0FoWFhUUzJJYWUvKy9rZVU1K2twTFpFQWV2aEVNQ01vdHBV?=
 =?utf-8?B?VXhJais2U1pBQWtpUFpkcEQ1bkQ4REk1blV5aVhzeUVJR0dSUDNHMkI0OFpl?=
 =?utf-8?B?TEZ5VFRrMXBxUXNDVFQwbzhJTlZYbWVxSEQ0MmhCSmlzWllONndJK29GMDZv?=
 =?utf-8?B?T2RRR0wyNUVsV1ZOWkVBSHlvN0hxWVpsUDZVVmVoQklxZXNmUWpuZVo0bzg5?=
 =?utf-8?B?WE56eEoxS3NpakdvNVhzcVovaFJHM2lHMXluZ0x4eEQ4SmNEMGJNVWl4MVNa?=
 =?utf-8?B?eXJPRS9aa3FIaU5DTDNXZmhZL2psaTFMdDZzK0hwL0VXZ1Q0M09HY2lqS3pl?=
 =?utf-8?B?NGtyUEtjdzF3bjBINkhvR2R0S2pXd3h4Z2lIdUFKMTN4SXRiR0NEUWxXQWNu?=
 =?utf-8?B?dXNuSzUrd3lRU3JzeHZKNnZudjEvS0M2cTlDREF1WVRMOU0wa0NEZzduQzVI?=
 =?utf-8?B?ZEl2Z1JkeDlBYnllVWRDOFFUZlNIV3pOYzM5MDd1MTRsUzBTcWRidFdCdy85?=
 =?utf-8?B?YVV2dnViQUQ0S2tscjJTSGhXczlFdUc2RlFMZjByaWNPeXQzeWFSS1JJRXRt?=
 =?utf-8?B?YzlJUDB4YXd5TlhEejV6SWFLK1dOclViUENKRTNxd2M1TlNtSmhMTWlxZExI?=
 =?utf-8?B?M290b1RSdTJ2ZFNTME1XY1daWGV0bVliNXAyYzdudS9yUjRyQ29QRkxRS1hm?=
 =?utf-8?B?aXlNaDB4SjRGMzRRRWl0VGJCRlV6YjJaQVZzTndRRnNwVllCVFJ1Z3l3UzVJ?=
 =?utf-8?B?ZllUV2JTMWpaeHlvbGhUaXRrbTJqWFczYWZCY0pBaVI3eW8wVDlaaUZBN05D?=
 =?utf-8?B?R1FsYnRKeTBHT0JMMTIxbWtIeFRWcCtqUzNya0pBYU9lV3JzNCt4TEw4YTFU?=
 =?utf-8?B?SzJmS1hLV3QxT1diYk51b2ZxZzVNVVg0dVVzZ0lUUW9oNjVjcCtGU0MxTnpu?=
 =?utf-8?B?aFBNZ2k2VEprT2VkbncxVGFkZStEY0Y0b2RIYmRUc2M1UGpsZjh2dFhvWWhS?=
 =?utf-8?B?SU9HVGU1cWgvKzUyZXhDT1RaaDNVaFB0a0FVZ2tyTnpLV0I1bmsvTGZrNlFw?=
 =?utf-8?B?WUZVVlZVb3VRTEpBUXYwSGFueHZVRVpzb0xlYTlTVUJrV3ZvdVA4VGo5NDVZ?=
 =?utf-8?B?MURyR1NBK2pJYWlmM3ZLVXIrbERzOU9xclQ0eHRyNW05a0R6ZVB2L2V4a3A3?=
 =?utf-8?B?Mk9RazVWalBHNnBNQ3hxQTA2VUpWMEJXVDhlUEVhejJqNTIxWjJBVE55MjN6?=
 =?utf-8?B?VkxvYm5EUXU2Y2NwQmsra1dGQWVDZG5Nbm1ZUGxLeHQ0MnV3cUdjNXpvQ2p1?=
 =?utf-8?B?NHMwcHVxNWJKa0hzWlRKMUNHTDB0TUY0emZvWnBrYjkxNjZHWlAra1QxOUFT?=
 =?utf-8?B?TjFJcm5HNzZSdDVQcFAzaVYzZXZjdGc4cGZUVmdQTjl5TE1kdDVKOHA0WXox?=
 =?utf-8?B?TUNtN0xJVGpRTGd0b0MwdzZCY21XZWwyclZsMXI5RFZYdmJpZVpVZE0xeEdv?=
 =?utf-8?B?V3R2ZHhJUVQ5N013bGdJVUhMaldKK1hyanNKWDJ4aTlvUVZHelR1cUJ5Mkd1?=
 =?utf-8?B?Vmh3eVo4VnJOOTBqdmhMNzFsOHB1WUZVS0dySXlXZ1QvS3pEVzd0cWQ2OTJ1?=
 =?utf-8?B?TlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C03FC100C586941ADC77ED4A5000A60@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e51ccf-e642-4d99-a44c-08dd561c20bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 04:14:56.4698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aPrj199fMG2ddfVG5eWySmyJCk48mEfMNw7zTr/hvXhDLMup/ANC1TajFe1D4vI7wskesBqD21lXoNnoTjgGIJvAtFfC4Xpdr0lDZAjqBSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8463

T24gVHVlLCAyMDI1LTAyLTI1IGF0IDE0OjUxICswMTAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNv
bnRlbnQuDQo+IA0KPiANCj4gPiA+IFdvdWxkIHVzaW5nIGEgJ3Jlc2VydmVkLW1lbW9yeScgcmVn
aW9uIGJlIGFuIG9wdGlvbiBtYXliZT8NCj4gPiBPciBtYXliZSBqdXN0IGxlYXZlIHRob3NlIG1h
cHBlZCByZWdpc3RlcnMnIGFkZHJlc3NlcyBpbiBkcml2ZXINCj4gPiBjb2RlDQo+ID4gKG10ay0y
cDVnZS5jKT8gTGlrZToNCj4gPiAjZGVmaW5lIE1UNzk4OF8yUDVHRV9QTUJfQkFTRSAoMHgwZjEw
MDAwMCkNCj4gPiAjZGVmaW5lIE1UNzk4OF8yUDVHRV9QTUJfTEVOwqAgKDB4MjAwMDApDQo+IA0K
PiBUaGUgcHJvYmxlbSB3aXRoIGhhcmQgY29kaW5nIHRoZW0gaXMgeW91IG5lZWQgc29tZSB3YXkg
dG8ga25vdyB3aGljaA0KPiBzZXQgb2YgaGFyZCBjb2RlZCB2YWx1ZXMgdG8gdXNlLCBiZWNhdXNl
IHRoZSBoYXJkd2FyZSBlbmdpbmVlcnMgd2lsbA0KPiBub3QgZ3VhcmFudGVlIHRvIG5ldmVyIG1v
dmUgdGhlbSwgb3IgY2hhbmdlIHRoZSBiaXQgbGF5b3V0IGZvciB0aGUNCj4gbmV4dCBnZW5lcmF0
aW9uIG9mIGRldmljZXMuDQo+IA0KPiBQSFlzIGRvbid0IHVzZSBjb21wYXRpYmxlcyBiZWNhdXNl
IHRoZXkgaGF2ZSBhbiBJRCBpbiByZWdpc3RlciAyIGFuZA0KPiAzLiBJcyB0aGlzIElEIHNwZWNp
ZmljIHRvIHRoZSBNVDc5ODg/DQo+IA0KPiDCoMKgwqDCoMKgwqDCoCBBbmRyZXcNCkRvIHlvdSBt
ZWFuIHRoYXQgImFyZSBNVDc5ODhfMlA1R0VfUE1CX0JBU0UgJiBNVDc5ODhfMlA1R0VfUE1CX0xF
Tg0Kc3BlY2lmaWMgdG8gTVQ3OTg4Ij8gVGhlcmUnYSBhbm90aGVyIG91ciBuZXcgcGxhdGZvcm0s
IE1UNzk4NywgaGFzDQphbG1vc3QgdGhlIHNhbWUgYnVpbHQtaW4gMi41R3BoeS4gSXQgd2lsbCB1
c2UgdGhlIHNhbWUgIlBNQiIgYmFzZQ0KYWRkcmVzcyB0byBsb2FkIGZpcm13YXJlLg0KDQpTbyBJ
IGd1ZXNzIEkgY2FuIGRvIHRoZSBmb2xsb3dpbmcgYWNjb3JkaW5nIHRvIHRoZSBwcmV2aW91cyBk
aXNjdXNzaW9uOg0KMSkgUmVzZXJ2ZSBhIG1lbW9yeSByZWdpb24gaW4gbXQ3OTg4LmR0c2kNCnJl
c2VydmVkLW1lbW9yeSB7DQoJI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQoJI3NpemUtY2Vsc3MgPSA8
Mj47DQoJcmFuZ2VzOw0KDQoJLyogMHgwZjAxMDAwMDB+MHgwZjFmMDAyNCBhcmUgc3BlY2lmaWMg
Zm9yIGJ1aWx0LWluIDIuNUdwaHkuDQoJICogSW4gdGhpcyByYW5nZSwgaXQgaW5jbHVkZXMgIlBN
Ql9GV19CQVNFIigweDBmMTAwMDAwKQ0KCSAqIGFuZCAiTUNVX0NTUl9CQVNFIigweDBmMGYwMDAw
KQ0KCSAqLw0KCWkycDVnOiBpMnA1Z0AwZjEwMDAwMCB7DQoJCXJlZyA9IDwwIDB4MGYwMTAwMDAg
MCAweDFlMDAyND47DQoJCW5vLW1hcDsNCgl9Ow0KfTsNCg0KUmVzZXJ2ZSBhIG1lbW9yeSByZWdp
b24gaW4gbXQ3OTg3LmR0c2kNCnJlc2VydmVkLW1lbW9yeSB7DQoJI2FkZHJlc3MtY2VsbHMgPSA8
Mj47DQoJI3NpemUtY2Vsc3MgPSA8Mj47DQoJcmFuZ2VzOw0KDQoJaTJwNWc6IGkycDVnQDBmMTAw
MDAwIHsNCgkJcmVnID0gPDAgMHgwZjAxMDAwMCAwIDB4MWUwMDI0PjsNCgkJbm8tbWFwOw0KCX07
DQoNCgkvKiBGb3IgYnVpbHQtaW4gMi41R3BoeSdzIHRvcCByZXNldCAqLw0KCWkycDVnX2FwYjog
aTJwNWdfYXBiQDExYzMwMDAwIHsNCgkJcmVnID0gPDAgMHgxMWMzMDAwMCAwIDB4MTBjPjsNCgkJ
bm8tbWFwOw0KCX07DQp9Ow0KDQoyKSBTaW5jZSBQSFlzIGRvbid0IHVzZSBjb21wYXRpYmxlcywg
aGFyZGNvZGUgYWRkcmVzcyBpbiBtdGstMnA1Z2UuYzoNCi8qIE1US18gcHJlZml4IG1lYW5zIHRo
YXQgdGhlIG1hY3JvIGlzIHVzZWQgZm9yIGJvdGggTVQ3OTg4ICYgTVQ3OTg3Ki8NCiNkZWZpbmUg
TVRLXzJQNUdQSFlfUE1CX0ZXX0JBU0UJCSgweDBmMTAwMDAwKQ0KI2RlZmluZSBNVDc5ODhfMlA1
R0VfUE1CX0ZXX0xFTgkJKDB4MjAwMDApDQojZGVmaW5lIE1UNzk4N18yUDVHRV9QTUJfRldfTEVO
CQkoMHgxODAwMCkNCiNkZWZpbmUgTVRLXzJQNUdQSFlfTUNVX0NTUl9CQVNFCSgweDBmMGYwMDAw
KQ0KI2RlZmluZSBNVEtfMlA1R1BIWV9NQ1VfQ1NSX0xFTgkJKDB4MjApDQoNCi8qIE9uIE1UNzk4
Nywgd2Ugc2VwYXJhdGUgZmlybXdhcmUgYmluIHRvIDIgZmlsZXMgYW5kIHRvdGFsIHNpemUNCiAq
IGlzIGRlY3JlYXNlZCBmcm9tIDEyOEtCKG1lZGlhdGVrL210Nzk4OC9pMnA1Z2UtcGh5LXBtYi5i
aW4pIHRvDQogKiA5NktCKG1lZGlhdGVrL210Nzk4Ny9pMnA1Z2UtcGh5LXBtYi5iaW4pKw0KICog
MjhLQihtZWRpYXRlay9tdDc5ODcvaTJwNWdlLXBoeS1EU1BCaXRUYi5iaW4pDQogKiBBbmQgaTJw
NWdlLXBoeS1EU1BCaXRUYi5iaW4gd2lsbCBiZSBsb2FkZWQgdG8NCiAqIE1UNzk4N18yUDVHRV9Y
QlpfUE1BX1JYX0JBU0UNCiAqLw0KI2RlZmluZSBNVDc5ODdfMlA1R0VfWEJaX1BNQV9SWF9CQVNF
CSgweDBmMDgwMDAwKQ0KI2RlZmluZSBNVDc5ODdfMlA1R0VfWEJaX1BNQV9SWF9MRU4JKDB4NTIy
OCkNCiNkZWZpbmUgTVQ3OTg3XzJQNUdFX0RTUEJJVFRCX1NJWkUJKDB4NzAwMCkNCg0KLyogTVQ3
OTg3IHJlcXVpcmVzIHRoZXNlIGJhc2UgYWRkcmVzc2VzIHRvIG1hbmlwdWxhdGUgc29tZQ0KICog
cmVnaXN0ZXJzIGJlZm9yZSBsb2FkaW5nIGZpcm13YXJlLg0KICovDQojZGVmaW5lIE1UNzk4N18y
UDVHRV9BUEJfQkFTRQkJKDB4MTFjMzAwMDApDQojZGVmaW5lIE1UNzk4N18yUDVHRV9BUEJfTEVO
CQkoMHg5YykNCiNkZWZpbmUgTVQ3OTg3XzJQNUdFX1BNRF9SRUdfQkFTRQkoMHgwZjAxMDAwMCkN
CiNkZWZpbmUgTVQ3OTg3XzJQNUdFX1BNRF9SRUdfTEVOCSgweDIxMCkNCiNkZWZpbmUgTVQ3OTg3
XzJQNUdFX1hCWl9QQ1NfUkVHX0JBU0UJKDB4MGYwMzAwMDApDQojZGVmaW5lIE1UNzk4N18yUDVH
RV9YQlpfUENTX1JFR19MRU4JKDB4ODQ0KQ0KI2RlZmluZSBNVDc5ODdfMlA1R0VfQ0hJUF9TQ1Vf
QkFTRQkoMHgwZjBjZjgwMCkNCiNkZWZpbmUgTVQ3OTg3XzJQNUdFX0NISVBfU0NVX0xFTgkoMHgx
MmMpDQoNCnN0YXRpYyBpbnQgbXQ3OTg4XzJwNWdlX3BoeV9sb2FkX2Z3KHN0cnVjdCBwaHlfZGV2
aWNlICpwaHlkZXYpDQp7DQoJc3RydWN0IG10a19pMnA1Z2VfcGh5X3ByaXYgKnByaXYgPSBwaHlk
ZXYtPnByaXY7DQoJdm9pZCBfX2lvbWVtICptY3VfY3NyX2Jhc2UsICpwbWJfYWRkcjsNCglzdHJ1
Y3QgZGV2aWNlICpkZXYgPSAmcGh5ZGV2LT5tZGlvLmRldjsNCgljb25zdCBzdHJ1Y3QgZmlybXdh
cmUgKmZ3Ow0KCWludCByZXQsIGk7DQoJdTMyIHJlZzsNCg0KCWlmIChwcml2LT5md19sb2FkZWQp
DQoJCXJldHVybiAwOw0KDQoJcG1iX2FkZHIgPSBpb3JlbWFwKE1US18yUDVHUEhZX1BNQl9GV19C
QVNFLA0KCQkJICAgTVQ3OTg4XzJQNUdFX1BNQl9GV19MRU4pOw0KCWlmICghcG1iX2FkZHIpDQoJ
CXJldHVybiAtRU5PTUVNOw0KCW1jdV9jc3JfYmFzZSA9IGlvcmVtYXAoTVRLXzJQNUdQSFlfTUNV
X0NTUl9CQVNFLA0KCQkJICAgICAgIE1US18yUDVHUEhZX01DVV9DU1JfTEVOKTsNCglpZiAoIW1j
dV9jc3JfYmFzZSkgew0KCQlyZXQgPSAtRU5PTUVNOw0KCQlnb3RvIGZyZWVfcG1iOw0KCX0NCi4u
Lg0KZnJlZToNCglpb3VubWFwKG1jdV9jc3JfYmFzZSk7DQpmcmVlX3BtYjoNCglpb3VubWFwKHBt
Yl9hZGRyKTsNCi4uLg0KfQ0KDQpCUnMsDQpTa3kNCg==

