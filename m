Return-Path: <netdev+bounces-129973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC30987510
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 16:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A40FA1C21247
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 14:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7CD54F95;
	Thu, 26 Sep 2024 14:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jf3bIuHp";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="NcMX1KtS"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DCB4174A;
	Thu, 26 Sep 2024 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727359522; cv=fail; b=ETjwWxp7eNcmbpwA0bpLVotT7p+lSes65LTLeZnAzIl7HthJC2OHGIy1UWR7iWGDQflm0cKJRgMuZThA2rR+zaumw7lckEOSIm1JV0K7XfMsQF6Qm1QPH2penwceI0+qwY1B+OYPoAg08N1I/1iqec4wzk3E8EoFihHpJ/CAx2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727359522; c=relaxed/simple;
	bh=BnWcfz1+h9n/ysuAgNAiisJf7GVhcZtJUfU6cb/X+IA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m7mSNL+0bHFdEa6jMxQzIhwReUZcbHhxz0C+TscRYG6Br2yhlRkmu/PAgedBBVOc7PwXnnCbef2RRCk/OJvFqAOdrNAfSPj0DZ4ygT+25rW1COBuYytc+BauBUvA68WU0BqT5A5PmsVFJGqT/Mlz2M0Y45mLj6ftQFi02srcPwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=jf3bIuHp; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=NcMX1KtS; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5278687c7c1011efb66947d174671e26-20240926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=BnWcfz1+h9n/ysuAgNAiisJf7GVhcZtJUfU6cb/X+IA=;
	b=jf3bIuHpa12WNF7W/qOSXbYcjP+L2b9fbqjEc+BLyaRpXIxr3fusokOmIbNY/zcr3SPHjevfv4TdbVN+P5jI854RH+GQPg6yXjiiF2tmYDYF2GlofCdKB1d82zsZii4tDdmOFXQalqDWCdhGsohKXkDWGe1YiwFeZz/Atm4GspA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:96834703-810e-4124-b582-744addf1c108,IP:0,U
	RL:0,TC:0,Content:1,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:6dc6a47,CLOUDID:96609c9e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|-5,EDM:-3,IP:ni
	l,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 5278687c7c1011efb66947d174671e26-20240926
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <lena.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1254862589; Thu, 26 Sep 2024 22:05:01 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 26 Sep 2024 22:05:00 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 26 Sep 2024 22:05:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2JytgVmN98PDm0rL78LS8q37VkH9yK5DECSYAe39slFIduBC7waLpOjyZhc4N4NiKegt4BghZ6uEJXFsdFyyNxsu6oOvFUGkemdLQq0HzBTQ9VvmwbWvrZwtpgBZoEFNV4OwKkQ7QH1Hatxh2sOA+97Y3sXdWVhwSOUVwf2t4pzVi0Ad9805ZTgNPqOWVP6iEAyaw3C0BQYNuL7sY9W61nfKQwwesjdwnyYwd8uZNgkZWGVU5fNEsjY5HWtM8aGzysn18eSaZPaY4W2ZNiQC/3/LiUBAvuHYpwQYfyjNp7vtdU4iih3UuLGehtUqmGTAvVOp8uZmnkT8KTB3b3hDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnWcfz1+h9n/ysuAgNAiisJf7GVhcZtJUfU6cb/X+IA=;
 b=Cz//wUMcfNAZBnWYlziNEIqQGioSmXjpbBeLR2xdrlaYp6f3dSCai8Go1QsgVNDubm8Ifx8jWr85hEF2XM3+DLdeLWL3oIsUuSsB2ENOS/Tldj6vNaXC6eOtuUbVocYf3ltCL2QbCAuTL9VdzVznWTT26N054LZ+L3RlLHbMnOpJQIkgz5FdCmvFQkB1XnqGZ+DcupouDJXrycfujdIebwSsKygpc+lKvTGiXXQeezcH5/vvwsnC/Hxw1icYWOLRTQ33prlPW8xoXtmYcoxZAr5Zq9zZXXFzH0IOaJLc8HjSpPPmXMUm0EnwiDLPll+iVRz7XEVjiCU1dvF1Sd91Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnWcfz1+h9n/ysuAgNAiisJf7GVhcZtJUfU6cb/X+IA=;
 b=NcMX1KtSERbrJsMll0yXpriR7X0v5d6melT0oPwk4yV5trGgksCuB8n23wseLJugVtgfSK4Px39Pk43jJCXYmgDsl2rAk1y6vxV+Nm4k7dZwHnIW9ZPj2Ts157VNjqnHpNJZ5KEQtn7QKC1QnPaoZGDLL+TUBa4SM4YPSefPV6g=
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8)
 by SEYPR03MB8007.apcprd03.prod.outlook.com (2603:1096:101:175::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Thu, 26 Sep
 2024 14:04:57 +0000
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::54f:1c26:8bd1:5824]) by SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::54f:1c26:8bd1:5824%6]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 14:04:57 +0000
From: =?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
To: "edumazet@google.com" <edumazet@google.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net] tcp: check if skb is true to avoid crash
Thread-Topic: [PATCH net] tcp: check if skb is true to avoid crash
Thread-Index: AQHbD+lrIP72NUOJMEOPmySjZwI2lbJpxzkAgABTpoA=
Date: Thu, 26 Sep 2024 14:04:57 +0000
Message-ID: <28c0330f1d1827fb61eee26a697cc7cf4735fb15.camel@mediatek.com>
References: <20240926075646.15592-1-lena.wang@mediatek.com>
	 <CANn89iKt-0LCJaJS8udObGOKz530seK67ieUgvmxr5woos+hyQ@mail.gmail.com>
In-Reply-To: <CANn89iKt-0LCJaJS8udObGOKz530seK67ieUgvmxr5woos+hyQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6466:EE_|SEYPR03MB8007:EE_
x-ms-office365-filtering-correlation-id: 1ace0e93-e30c-4c7d-d6d2-08dcde34340f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RlpEeCs2bm5CTnNuZHRSV2p0WGxtOGE4THZEUFFJTm1SeXJMWnE5S1JuSks2?=
 =?utf-8?B?QXVLUTFhMzBkQ2l4NWRBazM0KzJyeGVqZlA2VkRUODdlSHlmK29RNkVkcnZ3?=
 =?utf-8?B?Mmk0UG0wL2pWTmR6SU1wVG8rZzc0N1ZBS3kxUVE0MW5NSEhRVG0wVlBPV1F1?=
 =?utf-8?B?RUM5Wnk4VHRUdFNTalN2QklkT0pPM1J3blpTOWNzbWZIMS9ZMFFoVWc4OU9r?=
 =?utf-8?B?UEN5SE9helQreTU5YUU0YWJ3d3BOdEMrQ0FRd1JqTUVSNWVzTDFpeFpwSzMz?=
 =?utf-8?B?bnA2a0x2VmE1V0pjbThoKzFyMDNMZHNVdlUwSTh6WG0vRENMamVyODZ5U3JC?=
 =?utf-8?B?eDRaYm5jcCtHODBaNG5xaTczZVpxdnZQR0g5UTZKckxTSmhqQ0tOSnVhUnp2?=
 =?utf-8?B?NlRnTGZaQkpvQ0VSNmg2Y2ZiNFlYQnQ1Y1ZteUpMM25pQldvUGlNb3Q2Rkpm?=
 =?utf-8?B?VlNCdW5rY2I2MXNuWG1SWTdBVGdyU0lIUjk3MmdVcVdMY2x3WEIyUkVHaGxH?=
 =?utf-8?B?bGNXTDZLZTRVamY5MFpJLzd1bHhPQUpPNkE1aTRhdVYxUEkxQzFyT0tiOW1W?=
 =?utf-8?B?MUx0L2hTcWVWTHhFOGxwUStmUUZKWFJhRGFRL3BRNGtkTGpSOHlGeUJxZUZH?=
 =?utf-8?B?V3hERHRuSmc0WmJBS2hnSkQ4UDVUNzFPd3RvQzIrMklSeXIwUCtnWXRjNCs2?=
 =?utf-8?B?MEJVR3h3S1hMRVhkLzhEL21wMksvWUduNGNZUklOUlZGODhrd3V5OVk2YXFH?=
 =?utf-8?B?bEsxWmJTUjZpaGRVTGtNaEt2Nk9Wb2JqOGtZV0xLaU03NlJKRmZMbTFYYnlz?=
 =?utf-8?B?TmRHbW9SMEQzOVM2ZVpnSEt3V09HellpOGF2VloxSGd3TTc0WGNjZXNLWUdC?=
 =?utf-8?B?RDRWbXlhb04vZVEybzhKVThxbWlaV29FQ2dGektUUFJoMjZoSHZXQ0t5bk5a?=
 =?utf-8?B?bGNCanNZUms1VlRFMjQvcU9OOGJ1R0oyZlRHUVpYaFNVcjdwN0hBbE9lNEtL?=
 =?utf-8?B?RkIrbHZMMjVPclpJZGJrMnVZTGdFbGd5anYxUGJXNUxKR3phRHRwRzg4bUcw?=
 =?utf-8?B?SFlVdDVkcWtwZzA2czJ1NG1SNmhnallBUU52TXRhekNiSkVKSDBOTnkvcnU1?=
 =?utf-8?B?Y2xzSno4bEZqT2Naby85TUwzTXdELzlQdzlGRXc3ZnMrT2FNU0R3V3ZHTEpL?=
 =?utf-8?B?VThoYkFJQUNDaWlURVhaU0JjYlQ1VnBvWVNFbVFPQ3UzNWVhYVNWK3RMcnh1?=
 =?utf-8?B?WWlOV0ZCZUN4dWdHUUlPUjducUovNDZoL1d1M3MxMndLNWMzV3ZlOUxWSTU4?=
 =?utf-8?B?WHA5NVBBaWxoNG04RzlrV3pMT1VDM2NRSTVRbEt5R08zeGJXVE1qVjgvb0xS?=
 =?utf-8?B?b3VUL3RNVGJFdGhXUFRqMkEvWnZjUmh0NzN3OXlkQUIwL0FiMzBFbHJpaVFu?=
 =?utf-8?B?TUxXU1JVUittdjExTWRUMnR5bjZqQnpubzFuemVsK0F4VElYTnJ6SHNPZ2Rq?=
 =?utf-8?B?L3Eva1h2aXlZMnBwY25RRUVzTi9MSDlrZTFLRElxYXZaWW8zVStjL3dHeS9r?=
 =?utf-8?B?bzl3OGdIRHl0emIra3NxQldRWDBWS2pPc0E2TEQrQTZTV0hqaXNpbmtuL3JD?=
 =?utf-8?B?L1ltNU4vT1c2bzluZkpJWnpTVk8wZUZ2SStRREFvV096VS9aTCtxcUpzYVZK?=
 =?utf-8?B?MU95NU1ZaGdWVUpBVnhGSHdudWttc0hTQlBJdmE2L1ZPSVB6eTRkR3RTUEta?=
 =?utf-8?B?VDZBUGMybHZJOU9SZVRJYkRJOGllMHE2MkFnOVZONzhVU2toZEcyMUt6dDdY?=
 =?utf-8?B?dEtxaWZ5Wmo4eVNsZFNLZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6466.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnkySTdJVzhyME1FTjFJdW1QTmZaK0JrempvNEFvUUZuSG4vNlpPWFBSY2NE?=
 =?utf-8?B?RmticE5PYlQ3WEZSbXIwd0tIb3JwRktubkFBTzJYQmkvR1kwU3NzWnZ2WklM?=
 =?utf-8?B?ZVZyYWdEQjEzNGsyRnc1WnhQUFpMT0FDSFFneG91cEtUUFJxbmlxRG9DQkdy?=
 =?utf-8?B?VW1QTWFHYWRnbXlleUdWOW53eDNhUkUvY21YblhaSndyWnpKeldrRFVSRXF2?=
 =?utf-8?B?RnlGdTZ5eWN0R001TkNkT0k3NHdzSkdLQkpkR2JnUGVYT1dKZDJ4b2ZscDho?=
 =?utf-8?B?Zis2TVFBU0JYNmFHc3hab1FWejlRUjdJVVVGNUkwNzFiQld1MGdvWVZ2NXhs?=
 =?utf-8?B?UElaNlBCOEpXRlZZcHhSTjZMUjhnL01ZbHdkNTZSTVlSbzRaWmdZK0dJUVFp?=
 =?utf-8?B?UHZmM3FjWVkrUEVhc1E2a0JhYlBZVHB5KzZuRzdLNDJ0aUpWUmZkSjNvVzJt?=
 =?utf-8?B?YmZmRzJ2RGRuM24xa3RoU1kvRmZIUnFuY0dJcWlRd2xjSHlyNXl2SXE0endH?=
 =?utf-8?B?K3hWbkxwUzk5bk82Q0FpK1duaFIrdkhWQjNPYWpSNXF3N0VZRjZiL2R6R3RR?=
 =?utf-8?B?NXlPQlI0WFF1cTRiUVFWR1YxbVFLbDZMdHJ4ZWpTWFBpa2l6ZTc2TGsyOC9p?=
 =?utf-8?B?U1ZTZWM1aXpGRWE1WFhyK1lVTnVJZmc3MEFaYzlLWVNWZndka2QzTzdWU2Q3?=
 =?utf-8?B?UVQ5djdPWWxWTHhKNzVCclF3ME03ME1DbTdBQndqcTFaQWp5S3BMWjlCTDRJ?=
 =?utf-8?B?bTA2YUpqQ1dDV0xiWlp5OHJlOHF0aW9HczdBS0Q0ZDhOUDRweVl5M1BQMUNT?=
 =?utf-8?B?NjJpQkV4SHVwOVR5cnhlMU1iTnZjeVNFczI0ZytKVUhOd0xBYWNtd2NxZllq?=
 =?utf-8?B?WXhHcHNyU2Q5YVplcFhpQW50eS9RajV3dzlQV3RJcjVnVUJvVE5MdnRHRHkx?=
 =?utf-8?B?QnBjeC82NUdScG5ndWFHNmIrSE5veG80YWw0Q05oTjNKQWM2RWhqT3hDMy9h?=
 =?utf-8?B?UW45TTlSTXJNUXpJNUx2ME5jdjRrMWh0eEY5Q29neFdRam5kTk1kcTFZVUpJ?=
 =?utf-8?B?TFFEMElXRmQyVEZ6TTlkdDAxSXBLcUp4WENGb212aHJmYmJGc1B3dXRvcko0?=
 =?utf-8?B?cTY5SEdxN1A0K0dsOGFVTUNzNnM3bkpyaVJiSk9ORFhmSWRIM2ZzUnk0dlhE?=
 =?utf-8?B?RXFNc0c3NGdRMzBBRUxwNXRSMU5rNVo0WEE4M1JNM2JqSFpvZVRkMkMvQStS?=
 =?utf-8?B?M3hLWFRCVDJpblR1UkNPU0Q5OTh3Q3dmaHZrenlXRXJCekhqbFVLbU9vSnRT?=
 =?utf-8?B?NlpWNnJnTEVrTitzQU9obGNRb1pkU1VyZit4cVlENTVBSFJYeWw1MU43M2sz?=
 =?utf-8?B?TlNkcUtlZHJyTHFVeDB4d2ozRWRUMElGV2poNmw1Q0lVT0QrbmgyRXJqVC9a?=
 =?utf-8?B?QmxmNVAzY2JaM0dJWG1vVHdtSkFLRnRXVVFBQjltZnEzckg3WlRYc1ozeXJ2?=
 =?utf-8?B?emo1bnJCRUFpVEpMcHh4VkdVL21MbGR2ajJId29SZDhMMDN1TjFJZ04vSVVx?=
 =?utf-8?B?U0ZXK1VJTUEyK29lRGhiRG5nd1pQeWIvemRRODZhUHdLSmFUTFhUOTQ1Ykhp?=
 =?utf-8?B?NzBDci84RUNicDk5OUgyMW1Nbk5nc0F3cG1GWTAxcGgzTlI1TVM2N2VSR0ZH?=
 =?utf-8?B?QTBTeUpQN0Q1Y05XOWpwTmJaSVFMT3NHOHVHZ3Y4YlJhRUZyV0c4cW8vOE5x?=
 =?utf-8?B?MzhpYmhlMnhqOWNHRHphK0VWa2dvaG9jMVlDb01jUGZtcUh0cFdqUjBmZnhN?=
 =?utf-8?B?NmwyWlh6NFc3OUxNa0k1QTJYMjJBYy9iRmdWWElFUDdkeWhDQnF3WWUwTUJp?=
 =?utf-8?B?OXhUc3ZseTJzazRXckVpbHRsWUVCVi9kdHVZVVIzejViWnZmeXlMTTJDd0I1?=
 =?utf-8?B?dG53WS9tOGdtZHFqdkRvSVpDdExITml3cmRSUU1uTEpyQTBubGY1c0NiQ1VC?=
 =?utf-8?B?M0FtcEM0YVQwMDc1Z1lUbnJsUVFVSTB2VDhhQStrdmVOV3Z0dWJnNUZMUWhD?=
 =?utf-8?B?a0gvMEhFRldCVG8yNkFnVU42SUllaU1NZlhWMHVjUlFlQThzcDg0bnRaK0w3?=
 =?utf-8?B?bDVxTWowUzBha2lSeEhPelJ6MVFOaVUrMHhBZVZ2N2twSVBnQXB1SndwaVdX?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <574F416694981346B146D5475BC433DF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6466.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ace0e93-e30c-4c7d-d6d2-08dcde34340f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 14:04:57.2697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uCcHUsVsIWZyLhYB1U9ZsVBZybaGYI3eMfDsOCQ5nx+LASSSLvT2bCRFmNwp2RJbaTLg8XsY8u0y5/zGs3W5rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8007

T24gVGh1LCAyMDI0LTA5LTI2IGF0IDExOjA3ICswMjAwLCBFcmljIER1bWF6ZXQgd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgT24gVGh1LCBTZXAgMjYsIDIwMjQgYXQgOTo1NeKAr0FNIExlbmEgV2Fu
ZyA8bGVuYS53YW5nQG1lZGlhdGVrLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBBIGtlcm5lbCBO
VUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgcmVwb3J0ZWQuDQo+ID4gQmFja3RyYWNlOg0KPiA+IHZt
bGludXggdGNwX2Nhbl9jb2FsZXNjZV9zZW5kX3F1ZXVlX2hlYWQoc2s9MHhGRkZGRkY4MDMxNkQ5
NDAwLA0KPiBsZW49NzU1KQ0KPiA+ICsgMjggPC9hbHBzL09mZmljaWFsUmVsZWFzZS9PZi9hbHBz
L2tlcm5lbC0NCj4gNi42L25ldC9pcHY0L3RjcF9vdXRwdXQuYzoyMzE1Pg0KPiA+IHZtbGludXgg
IHRjcF9tdHVfcHJvYmUoc2s9MHhGRkZGRkY4MDMxNkQ5NDAwKSArIDMxOTYNCj4gPiA8L2FscHMv
T2ZmaWNpYWxSZWxlYXNlL09mL2FscHMva2VybmVsLQ0KPiA2LjYvbmV0L2lwdjQvdGNwX291dHB1
dC5jOjI0NTI+DQo+ID4gdm1saW51eCAgdGNwX3dyaXRlX3htaXQoc2s9MHhGRkZGRkY4MDMxNkQ5
NDAwLCBtc3Nfbm93PTEyOCwNCj4gPiBub25hZ2xlPS0yMTQ1ODYyNjg0LCBwdXNoX29uZT0wLCBn
ZnA9MjA4MCkgKyAzMjk2DQo+ID4gPC9hbHBzL09mZmljaWFsUmVsZWFzZS9PZi9hbHBzL2tlcm5l
bC0NCj4gNi42L25ldC9pcHY0L3RjcF9vdXRwdXQuYzoyNjg5Pg0KPiA+IHZtbGludXggIHRjcF90
c3Ffd3JpdGUoKSArIDE3Mg0KPiA+IDwvYWxwcy9PZmZpY2lhbFJlbGVhc2UvT2YvYWxwcy9rZXJu
ZWwtDQo+IDYuNi9uZXQvaXB2NC90Y3Bfb3V0cHV0LmM6MTAzMz4NCj4gPiB2bWxpbnV4ICB0Y3Bf
dHNxX2hhbmRsZXIoKSArIDEwNA0KPiA+IDwvYWxwcy9PZmZpY2lhbFJlbGVhc2UvT2YvYWxwcy9r
ZXJuZWwtDQo+IDYuNi9uZXQvaXB2NC90Y3Bfb3V0cHV0LmM6MTA0Mj4NCj4gPiB2bWxpbnV4ICB0
Y3BfdGFza2xldF9mdW5jKCkgKyAyMDgNCj4gPg0KPiA+IFdoZW4gdGhlcmUgaXMgbm8gcGVuZGlu
ZyBza2IgaW4gc2stPnNrX3dyaXRlX3F1ZXVlLCB0Y3Bfc2VuZF9oZWFkDQo+ID4gcmV0dXJucyBO
VUxMLiBEaXJlY3RseSBkZXJlZmVyZW5jZSBvZiBza2ItPmxlbiB3aWxsIHJlc3VsdCBjcmFzaC4N
Cj4gPiBTbyBpdCBpcyBuZWNlc3NhcnkgdG8gZXZhbHVhdGUgdGhlIHNrYiB0byBiZSB0cnVlIGhl
cmUuDQo+ID4NCj4gPiBGaXhlczogODA4Y2Y5ZTM4Y2Q3ICgidGNwOiBIb25vciB0aGUgZW9yIGJp
dCBpbiB0Y3BfbXR1X3Byb2JlIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBMZW5hIFdhbmcgPGxlbmEu
d2FuZ0BtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+IA0KPiBJIGFtIG5vdCBzdXJlIHdoeSB0Y3Bf
c2VuZF9oZWFkKCkgY2FuIHJldHVybiBOVUxMLg0KPiANCj4gQmVmb3JlIHRjcF9jYW5fY29hbGVz
Y2Vfc2VuZF9xdWV1ZV9oZWFkKCkgaXMgY2FsbGVkLCB3ZSBoYXZlIHRoaXMNCj4gY29kZSA6DQo+
IA0KPiBzaXplX25lZWRlZCA9IHByb2JlX3NpemUgKyAodHAtPnJlb3JkZXJpbmcgKyAxKSAqIHRw
LT5tc3NfY2FjaGU7DQo+IA0KPiAvKiBIYXZlIGVub3VnaCBkYXRhIGluIHRoZSBzZW5kIHF1ZXVl
IHRvIHByb2JlPyAqLw0KPiBpZiAodHAtPndyaXRlX3NlcSAtIHRwLT5zbmRfbnh0IDwgc2l6ZV9u
ZWVkZWQpDQo+ICAgICByZXR1cm4gLTE7DQo+IA0KPiANCj4gDQo+IERvIHlvdSBoYXZlIGEgcmVw
cm8gPw0KSGkgRXJpYywNCkl0IGp1c3QgaGFwcGVucyBvbmNlIGluIG1vbmtleSB0ZXN0LiBJIGNh
bid0IHJlcHJvZHVjZSBpdC4NCg0KZnJvbSB0aGUgZHVtcCBsb2csIGl0IGNhbiBzZWUgdGhlc2Ug
dmFsdWVzOg0KKGdkYikgcCB0cC0+cmVvcmRlcmluZw0KJDE2ID0gNA0KKGdkYikgcCB0cC0+bXNz
X2NhY2hlDQokMTcgPSAxMjgNCnByb2JlX3NpemUgPSA3NTUNCnNpemVfbmVlZGVkID0gNzU1ICsg
KDQrMSkqMTI4ID0gMTM5NQ0KDQooZ2RiKSBwIHRwLT53cml0ZV9zZXENCiQxOCA9IDE1NzEzNDM4
MzgNCihnZGIpIHAgdHAtPnNuZF9ueHQNCiQxOSA9IDE1NzEzMzY5MTcgDQp0cC0+d3JpdGVfc2Vx
IC0gdHAtPnNuZF9ueHQgPSAxNTcxMzQzODM4IC0gMTU3MTMzNjkxNyA9IDY5MjEgPiAxMzk1DQo=

