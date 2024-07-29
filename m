Return-Path: <netdev+bounces-113489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24ACF93EBE4
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 05:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E68F1C2146A
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 03:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E998278C70;
	Mon, 29 Jul 2024 03:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OsqUpSKN";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="QNKw0EEL"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA09B801;
	Mon, 29 Jul 2024 03:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722224175; cv=fail; b=FQNdUaFuk9a+lhb0HymgN3nJJUdqckHIkdp/5hB/klBO/U3QZgRt5d0t14mxEMytk6jyBu/Ju1vDTt7L6RtE0X/WJ+07H/gnXK/GQNSfvVfFl7uSBVgZ2uEgKloe/doAQ5rsj1vsGjILll185E5Kmfr9DXtvRBCyd9VYlwofu1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722224175; c=relaxed/simple;
	bh=bQyttJ5SDWZYz9gR+tADLMwzOiZVBqtQfU+1O9fIwTk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MQiRHyAypY/BVzWBtT9k6OhXgeMNGOTKlrNYN8oVUomUgjG52mh5xFj9vNfr2JB7Xpsv5a2RYajISZgjPgU15le7EcsmIQwYxEohex5JlgyCMnMjdt8QuuzoOdy+5DtQFN5efp2+Dmxy1Lr0e2j/TKv1iQuRX5v797HxbqzpAws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OsqUpSKN; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=QNKw0EEL; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: acf4b6b84d5b11efb5b96b43b535fdb4-20240729
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=bQyttJ5SDWZYz9gR+tADLMwzOiZVBqtQfU+1O9fIwTk=;
	b=OsqUpSKNsp6tg7JhvlNLOA/3oASYwDC+UARXh+SUwNbNMRWucAZ//Bf7mwfmnBmoLoODxBdogVxKYqGz97pSgbdCOZ2vqSfUnaiwQgfCBKJSZaJbe35lJp/MByjIkq1pfxWk9kjFH7pt1eSee/pzCJKL6wBbBE3uEqArowaRzv8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:b741a5d6-7687-49d4-bd96-0671cd161d15,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:e264ded5-0d68-4615-a20f-01d7bd41f0bb,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: acf4b6b84d5b11efb5b96b43b535fdb4-20240729
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 264954168; Mon, 29 Jul 2024 11:36:01 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 29 Jul 2024 11:36:00 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 29 Jul 2024 11:36:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQCfugmlzN6wU32MktzJoB9p4tcHuCZbAJYkUr04DemdvcuBC7bfVSxAnPN76LrQ2Uev5b1GOc7VbNjjCBXHgKCCLDPMhPYWAD0CMdNYG9dzLlI73aMZyM2+5ka41koBz0kupCRnomYJ5A6GS+nde9kx3AWCXb6xKnThQanDM4PRy2IluDJoh0+M21zh3HBfMY+NlZaxPmY1eM2pBwoG+n2pniZDp02Hq8B8NzZWQDQ6iIcfkn8UXv7RtJ3TfUXTTmWe57KQ/NmB9vfG+fAQwPiAnKq2HTiu7/Oqy4zqI6BbdqZSRWBdQg3F/CKrrR+1OCr1PQ7h5DlEzxKNCoEm3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQyttJ5SDWZYz9gR+tADLMwzOiZVBqtQfU+1O9fIwTk=;
 b=Rtxhzy+807259TOLqRkHpXSfD761LPgtAma1aay1s0b5i4YYLrQ2HRQmG16KN13ex1Rw36fU2E5VnhqZ7M66c6p6xrj9+3ZFNWzh2NQhQX3DNNw8qVoB4QJ1A7UWoVRZMLu3lmh1mYnpWUMhO28a61O6NyS3a6NZvrC4tqUwc5duGinr+ByFAALtGa/qPTybzgmD6DlWHsAwcHwCFmeUP3flD3wr9cYw6QZ6T/VpsYoHu2gle9JSdivf6L6gqR3joQUuq5GXUZlVhUMp4NFkJr/4gQsRfkRsrGP1pCzKjZhsGmItythTaLTvxpkqqzr97XVHpRkqtFfASPX7nTKNRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQyttJ5SDWZYz9gR+tADLMwzOiZVBqtQfU+1O9fIwTk=;
 b=QNKw0EELjoWM8t+uyWW7nzIy//rzWhLadS4j82vWiTrzFqgMbYDRda6sq8Z5TKfLzNguRBWEiL6hxeMZzQoApimXUvjgr4X8DS2Mh7/4eSGG/Sq/Y093hmJSZesjOUti5kvU6pzplx+f5nOkRgfdXBX7OZQPqOCTRpFRcBEFSs4=
Received: from SEZPR03MB8273.apcprd03.prod.outlook.com (2603:1096:101:19a::11)
 by SG2PR03MB6801.apcprd03.prod.outlook.com (2603:1096:4:1ba::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Mon, 29 Jul
 2024 03:35:58 +0000
Received: from SEZPR03MB8273.apcprd03.prod.outlook.com
 ([fe80::f7ac:70cb:3cb4:acac]) by SEZPR03MB8273.apcprd03.prod.outlook.com
 ([fe80::f7ac:70cb:3cb4:acac%6]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 03:35:57 +0000
From: =?utf-8?B?TGlqdS1jbHIgQ2hlbiAo6Zmz6bqX5aaCKQ==?=
	<Liju-clr.Chen@mediatek.com>
To: "horms@kernel.org" <horms@kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	=?utf-8?B?WmUteXUgV2FuZyAo546L5r6k5a6HKQ==?= <Ze-yu.Wang@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?Q2hpLXNoZW4gWWVoICjokYnlpYfou5Ip?= <Chi-shen.Yeh@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>, "dbrazdil@google.com"
	<dbrazdil@google.com>, =?utf-8?B?UGVpTHVuIFN1ZWkgKOmai+WfueWAqyk=?=
	<PeiLun.Suei@mediatek.com>, =?utf-8?B?S2V2ZW5ueSBIc2llaCAo6Kyd5a6c6Iq4KQ==?=
	<Kevenny.Hsieh@mediatek.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "mhiramat@kernel.org"
	<mhiramat@kernel.org>, =?utf-8?B?WWluZ3NoaXVhbiBQYW4gKOa9mOepjui7kik=?=
	<Yingshiuan.Pan@mediatek.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?U2hhd24gSHNpYW8gKOiVreW/l+elpSk=?=
	<shawn.hsiao@mediatek.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v11 08/21] virt: geniezone: Add vcpu support
Thread-Topic: [PATCH v11 08/21] virt: geniezone: Add vcpu support
Thread-Index: AQHasaRM9mbhAgoFokuQ2KU9gwm3s7Gx0REAgFuceAA=
Date: Mon, 29 Jul 2024 03:35:57 +0000
Message-ID: <6ea77f032fc0f2df5ca76d89e88acec3cc8d37c1.camel@mediatek.com>
References: <20240529084239.11478-1-liju-clr.chen@mediatek.com>
	 <20240529084239.11478-9-liju-clr.chen@mediatek.com>
	 <20240531203612.GU491852@kernel.org>
In-Reply-To: <20240531203612.GU491852@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB8273:EE_|SG2PR03MB6801:EE_
x-ms-office365-filtering-correlation-id: adbf9a06-4367-4388-e594-08dcaf7f8f24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Sm1LRW9DQllqSjJUSk00YVE0a2pjNkMwMGJSc2hoMmlvenFNSnNrZDVQMVhv?=
 =?utf-8?B?dUFvOFV6VTlSM2lQU003bFErZnRtWlF2Y3pMUlc3ODNhdWJ6YUtGYjdZVUp6?=
 =?utf-8?B?R09oU05MdHArNFBFdXliRERhL21JM2xHUFRBQ3NVNENTY3I3N1RKbUM5Z050?=
 =?utf-8?B?QVFIZjBmSWRPYitvaDZ1WS96N0NCcEFZNlZYT3QraUsxUStmcDdQbGVMQUZP?=
 =?utf-8?B?QVRPZ21Od3Bkc1dyUVdNNU9WRUF4RnB1OGp0Z0pzNnk5WHMxeTBISlZXWVhv?=
 =?utf-8?B?OFl5eWZacTYxZkh6dDF1T2FrNDdQeXJPMVpYZnBicGZGN1U1bHZNWXZmRCt2?=
 =?utf-8?B?enVTK296dndoMEM3dVU4UlJ2elZmWVR2VGd6Z04ybG10dzBucjZ4V2thYzl5?=
 =?utf-8?B?Zzg1MEZNaVRFaUx6YjhhOWhWWU9lTlVDNTBlbFU2aXFpN0doQ09ESGN3SjRH?=
 =?utf-8?B?Mlpkc3NvT2szVnRidExmYVZVRzk0cGt6Q3pGclpnYmdJWWVNMk00RkhKaHJz?=
 =?utf-8?B?OVloU2JlNnJFM0JtWk9uVHdNSXdJRUJ1WEVWZ2NHM2wweGVRNlVSQWxJWWVp?=
 =?utf-8?B?Y3REc0RxeEVNZCtDYklKWThJYTdSVHEvZ0lEQVhiV2RJNFpQZVFaa1BqUTFh?=
 =?utf-8?B?ZWtLNE5lci82UFNzUmF2SVBaclFFN01EZ3lhZjhLV05ESDczNWJpZ0JMQ3R3?=
 =?utf-8?B?UGEzZmhrWmVEdHRxN2RLUngwZkQ2cmdlamZ0NVFHNFI0M1JjeG1OdlpPbFZN?=
 =?utf-8?B?QU9hcDZsMG00YmFEYmh4NUlFVVpxNUJZZFozK0c1K1pwb3ZaRmIxYUErYk9a?=
 =?utf-8?B?YVhNU0RueGRURm9Makw1SUdVQnpYZzBrbTFhV0lid09RWDM3c0VtcEMwUGFO?=
 =?utf-8?B?Qkw0cHRBLy9raGdRVXRpQVJ5SXVWcExVQU0xREhQd3ptNE85YUl3dzRSQWxq?=
 =?utf-8?B?WHRTUEQrWlRNM0FDMHZSWDcydWEwMS9VdjQyaGozbUhyaG9jakFUZzZLdTNu?=
 =?utf-8?B?NTFTQjIwMTVqVVZ4TmdXSnZMN0dUMENQRHZxbEkzM084YXFWTUQzRDUxVDha?=
 =?utf-8?B?bkdaQ0QzS0xIUmhKb1V4TVkxZU5xaTJvYTBNSTAvczhaZk1ldTVMZVRTTGsx?=
 =?utf-8?B?ZjA2RDRndXRvcTMydlgwa2xqMTNyQTVyci92alpUTDZxTFFZNXhWcnh6dU9E?=
 =?utf-8?B?bGY4SEZwbzQwdGxoRXdsUStCWDJCWWpsWlQ5U1VPQkZWM1QxSU1uQ3ZON1Bv?=
 =?utf-8?B?KzZqb09jOTRSQlZPeUtvSGs5UkgrQ1BNWlN1emRtYU1vNEhrQlJjK2Z5RDNX?=
 =?utf-8?B?ZDN5WDc1N2ZjK2duSnZxeVlpdS9jOGU2bEpGcU5wT1ZrcTNGclNPU2ZPUUtm?=
 =?utf-8?B?RElYT2lTYUllSDBmYy9oQ0gyZE5peEZ3d2w1OGl4Ly9qNXpNK2FucXNzUWtU?=
 =?utf-8?B?dVNmRG1ucXJoTUJrcWpvMm9uUnlxSDNheEZ5aldWWlM2TGdhQWNqQ0lhVmJE?=
 =?utf-8?B?bGRhTTZmYXBQeEZKaWZDLzNnMkdYTUd3Z0liN3g4b3JzM2tuMVkzbS9ST0FG?=
 =?utf-8?B?aE5yeFVYTDd1aFRSbTlWVm1wQzJGY083VU9QTVBsWW1XbldwR3M5Mk1ieWdo?=
 =?utf-8?B?a3RIaXhZcnYzRWxoMVIzbXBDMElWcUgzYjBxZ1ZiV0FmQVlnNjVWYk01QUo3?=
 =?utf-8?B?Y3BmZUt2NjQ3cHA1cjlodGlBRHJjVjdpUFZsc0Jzbk1STWwrN2pVcjVjck5k?=
 =?utf-8?B?UDRDaDc4V05hek4rUW80dFlsWWd3b0NzOHF4c3BLUC9BZ1Y4YzFQaFNZL25I?=
 =?utf-8?Q?kgY5Gs6CsmzmYdFMSK1QDUgGc0nyTD4+aEW68=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB8273.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkVFbXdQa01zcVowY05wOXRrREd1dFc5ZHJySis1TzJQWkx0Y0pEMXhvQzUx?=
 =?utf-8?B?NzUwb1hocXA5dUZ4U0h3Z2hzUGxzS1Q5cWcvN0x5N012QWhkNW1oSGJsY0t1?=
 =?utf-8?B?SDh5OG95aE9IS3A5WFluamZLUkJJbVRRVnBZMHRnYXZQeDZ0OEVyaWJna2lv?=
 =?utf-8?B?dmczeEJURVZtdDkzbVVDcDJCcENDSnRlVDlDQTZjSng1L1pibFF1aldwMGZp?=
 =?utf-8?B?OXlrOHNuM2c0UGJwVnNrbmRGenV0WXV3dFdmd1ZlT3lYN1hzbjFFTitIUzk1?=
 =?utf-8?B?SWtyLzlVaGxGYkllNkc3TndVSlR2VS9PNXIrUXhyR3g3UU5yVDFMeEhTS3VS?=
 =?utf-8?B?UjRHVUdnR1hycjRtTGhpQjBWZnFrY1NnSVZVeC9VQmhjUkQ2c3BHTjlhMGJz?=
 =?utf-8?B?aGIyS0VlckV1d1B0VVFJZjBiWlJmdnBrOUhVRVVucy9kZThURHEySGhlS0xO?=
 =?utf-8?B?WU41ZWlhWHlRSTBab0FsTjNlQ3kyZDVVakVxU0NaemZSb0FGZzVudFEzUURh?=
 =?utf-8?B?NXdLbmxGZThCbGV5Yk1MalZINVFaV29WUEZ1cHBsQmtUVkFFVFhVcEhQaHBZ?=
 =?utf-8?B?Q0xyV04zVXhrYkJOV2Mrb3ZzUXMxb2RQdnIzQ2JMM2w5dWVOaVlCUEFreXZI?=
 =?utf-8?B?U29RQk5PemoydnNIZnNwVE5TdHIyNVFoSjRmSGh3QmUvNGxFWDd0dGJPV2dk?=
 =?utf-8?B?bDBGeHg2MUxBTkM4WThDWi9OK1RPSEVaZ25GUDluelZaMjNWeFJFV0Zuc0Vt?=
 =?utf-8?B?ejN1NEo0dHRXcFhHZjlUdEN2RWdPektJYXV0bmVMV2NRdjNmRzJTU1dCMnRl?=
 =?utf-8?B?dDBFSXpyLzdtamNweG90ZVkvMW96UHE3QTF5aUQvYmFYdVNEMEptK2xuV1VP?=
 =?utf-8?B?K0FxeG4xdnFuc0RtTHUyODFNS0lLamRRN25WbEQweUR1OWRPelVPdzJicEIz?=
 =?utf-8?B?b0Y3UHVsYmlqaU9ISSswL2FSWDdQcDNIQTBMWUt5R1AxdXZpMEh3aExlV1Fr?=
 =?utf-8?B?NTg0aWEwdEIzSXBzYmtkQVBXaFAxcENmV0htWUNVMnlHOVZjcXdidG5LMmNk?=
 =?utf-8?B?S2Y1SnMwNzBaZVNpb1hoK0s3bkplYXp4N01DTUd5WTUzaFR1ajlsbk9WTEtl?=
 =?utf-8?B?UWUzZWF5SWNWT0ZzMXEwWTJ5TzBzanV6d2xxbm1KKys0S3FuM3g4V0ZWMjRH?=
 =?utf-8?B?K3lROGdBOGVkb00ybTRLckNBL2pGMmFzdjMrdWo2QU5kbk0rV09LWDE3cytu?=
 =?utf-8?B?OE1UTnVyNGs4dk1zTVJ5L3hzUUt1OHl2cVlGajQ5MCtEckhXMHhwQjk3N2RN?=
 =?utf-8?B?alVaNEhKM3gvd2U0VlM2VzNpclhsbTdPbmZ5T3hPcHRvbG5TVmhNRGY4NzJp?=
 =?utf-8?B?Zk5BMFVDNzFFV1VQUUVoTDl0TXNRRTBSdFN3bDdXWlZoeGVUWHBHUms2NFNv?=
 =?utf-8?B?NE9BRW9wcnZiNmRoRVNxLzVpNVFlVUt4bW0wNTdTa3ArcjBGdE10QmdwRnVw?=
 =?utf-8?B?UWU3d2JKS1Y1dEdJVElBenFmZkRqZFB2MHl5Z1EyQkFQSkduV2drTUppVTBw?=
 =?utf-8?B?aVJMUS80cnlyMnRiOXVlTEMzRDdvUW9XL0hXdVRXSHN1WFpmRzhoeko0anFE?=
 =?utf-8?B?YVJrY2pGUWhpWGZZWlVwV0Ztb3oyT0RLWjVLdTVNamxwZDZhcUZmWmRJdGli?=
 =?utf-8?B?Q1J2U0RzREwzb3RDQlNva0VMOWU2ZzIrWGFaQmIvbGpDZmhVY1RCUHdIODhK?=
 =?utf-8?B?NHdzRWJTWjRNa2RWekFRVWhlWStmTnl1UFU2OXFKVlQrNjd1Yll2STZqTkpp?=
 =?utf-8?B?NU5vdWZ0amtuWjM0N2F0R1ZNUmw1UWM5WWE2V0VjMmZGckRVSXlOUWxZRUxW?=
 =?utf-8?B?N1RQTUJsOW5ZSUtKcE03WSt2WEp2aXRRTGVRL293Nm0zTDB0bUJSMmREd0ov?=
 =?utf-8?B?blBZRzc0bFgvbXZwWmVXY0QzRjlCTGZCNU91M1ByWS9QMVJMWkJLRFQvQ2c5?=
 =?utf-8?B?WllkSm16TmQreFprY3M0VXNkN2tqSU9KLytBdHNocFRqeUIyS2tkcC9zckYr?=
 =?utf-8?B?OXFPOXQyek5lZnd4c3MvSUlqaForT1lOaHBOczgxNEZoRFZGak5OaGtEVFF1?=
 =?utf-8?B?MVBpRnREb2dBVThmcEVYdm1sNHZWZFJlbSsrd1MwUnlqcTlQT0RWaXA5Z3BM?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A234AAD735C6F14D8525F436D38DA886@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB8273.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adbf9a06-4367-4388-e594-08dcaf7f8f24
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 03:35:57.6811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jKZrVVr8SJsoNnT+7uDRHapYMPjIt+O7FYjG/ArTm0XGUhafRssU6W+Nboo9dsgjAdR4M4AdcZaK32a45zryGj+WEW7EjDKchk6178ht38U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6801
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--31.848900-8.000000
X-TMASE-MatchedRID: YHXf/4QH9w3UL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCmNvKIW9g24omlaAItiONP1Aq6/y5AEOOpps2hiiMFB2Zq2
	7yxeizC7huofOE6LSCRoChuL4/QNREUubDEShcPO/dvE/OIe6d14SPbQfgtNr7Q+7DPzi4OvbNQ
	h85GhqIoRx7Io+3USRdVYa3yVSesQIKTbeRIBWzPKUR83BvqItZa7LkubQvj+dCqKtxM6bh0aXE
	xLrrQUALoM2sfcA4fWtU0nd1OZo0q3onYxS1J4DFS5FC3EzJAFMkOX0UoduuWJkJOQVCIpwvWi5
	ex0jCdKuZ0IQ3OVGYuSWVqW5qzmOYiS5IMZgPcMSuhBXNJb1dLLiLKO9VZOiczkMPR6qFclVJ0A
	DqZV4hqlhINrkmUooYmV2ry96PkCoft0ZW3r/iaOuVibdZNTv+lX/RcQoG2FXPwnnY5XL5HHyDp
	4fu+gqQa/h2edydo5leFjJ/LgO8VWHhiPwsmKIngIgpj8eDcDBa6VG2+9jFNQdB5NUNSsi1GcRA
	JRT6POOhzOa6g8KrZRMZUCEHkRt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--31.848900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	AAE7090343A6F1250C356A9D099F44173D151A1C57C39F59F11E558AE5A58D472000:8

T24gRnJpLCAyMDI0LTA1LTMxIGF0IDIxOjM2ICswMTAwLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgT24gV2VkLCBNYXkgMjksIDIwMjQgYXQgMDQ6NDI6MjZQTSArMDgwMCwg
TGlqdS1jbHIgQ2hlbiB3cm90ZToNCj4gPiBGcm9tOiBZaS1EZSBXdSA8eWktZGUud3VAbWVkaWF0
ZWsuY29tPg0KPiA+IA0KPiA+IEZyb206ICJZaW5nc2hpdWFuIFBhbiIgPHlpbmdzaGl1YW4ucGFu
QG1lZGlhdGVrLmNvbT4NCj4gDQo+IG5pdDogSSB0aGluayB0aGVyZSBzaG91bGQgYmUgYXQgbW9z
dCBvbmUgRnJvbSBsaW5lLA0KPiAgICAgIGRlbm90aW5nIHRoZSBhdXRob3Igb2YgdGhlIHBhdGNo
LiBCYXNlZCBvbiB0aGUgU2lnbmVkLW9mZi1ieQ0KPiAgICAgIGxpbmVzIEkgYXNzdW1lIHRoYXQg
aXMgWWluZ3NoaXVhbiBQYW4uDQo+IA0KPiAgICAgIElmIHRoZXJlIGFyZSBtdWx0aXBsZSBhdXRo
b3JzIHBlcmhhcHMNCj4gICAgICB0aGUgQ28tZGV2ZWxvcGVkLWJ5IHRhZyBzaG91bGQgYmUgdXNl
ZCBiZWxvdy4NCj4gDQo+ICAgICAgQW5kIG9uIHRoYXQgbm90ZSwgaXQncyBub3QgY2xlYXIgdG8g
bWUgd2hhdCB0aGUgc2lnbmlmaWNhbmNlDQo+ICAgICAgb2YgdGhlIFNpZ25lZC1vZmYtYnkgbGlu
ZXMsIG90aGVyIHRoYW4gdGhhdCBvZg0KPiAgICAgIFlpbmdzaGl1YW4gUGFuIChwcmVzdW1lZCBh
dXRob3IpIGFuZCBMaWp1IENoZW4gKHNlbmRlcikgYXJlLg0KPiAgICAgIEknZCBzdWdnZXN0IGRl
bGV0aW5nIHRoZW0gdW5sZXNzIHRoZXkgYXJlDQo+ICAgICAgYWNjb21wYW5pZWQgYnkgQ28tZGV2
ZWxvcGVkLWJ5IHRhZ3MuDQo+IA0KPiAgICAgIEFuZCwgbGFzdGx5LCB0aGUgc2VuZGVyJ3Mgc2ln
bmVkLW9mZi1ieSBsaW5lIHNob3VsZCBjb21lIGxhc3QuDQo+IA0KPiAgICAgIFNlZTogDQo+IGh0
dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L3Byb2Nlc3Mvc3VibWl0dGluZy1w
YXRjaGVzLmh0bWwjc2lnbi15b3VyLXdvcmstdGhlLWRldmVsb3Blci1zLWNlcnRpZmljYXRlLW9m
LW9yaWdpbg0KDQpIaSBTaW1vbiwNClRoYW5rIHlvdSBmb3IgeW91ciByZXZpZXcuIEkgd2lsbCB1
cGRhdGUgaXQgaW4gbmV4dCB2ZXJzaW9uLg0KDQo+IA0KPiA+IA0KPiA+IFZNTSB1c2UgdGhpcyBp
bnRlcmZhY2UgdG8gY3JlYXRlIHZjcHUgaW5zdGFuY2Ugd2hpY2ggaXMgYSBmZCwgYW5kDQo+IHRo
aXMNCj4gPiBmZCB3aWxsIGJlIGZvciBhbnkgdmNwdSBvcGVyYXRpb25zLCBzdWNoIGFzIHNldHRp
bmcgdmNwdSByZWdpc3RlcnMNCj4gYW5kDQo+ID4gYWNjZXB0cyB0aGUgbW9zdCBpbXBvcnRhbnQg
aW9jdGwgR1pWTV9WQ1BVX1JVTiB3aGljaCByZXF1ZXN0cw0KPiBHZW5pZVpvbmUNCj4gPiBoeXBl
cnZpc29yIHRvIGRvIGNvbnRleHQgc3dpdGNoIHRvIGV4ZWN1dGUgVk0ncyB2Y3B1IGNvbnRleHQu
DQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogWWluZ3NoaXVhbiBQYW4gPHlpbmdzaGl1YW4ucGFu
QG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKZXJyeSBXYW5nIDx6ZS15dS53YW5n
QG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBrZXZlbm55IGhzaWVoIDxrZXZlbm55
LmhzaWVoQG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBMaWp1IENoZW4gPGxpanUt
Y2xyLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlpLURlIFd1IDx5aS1k
ZS53dUBtZWRpYXRlay5jb20+DQo+IA0KPiAuLi4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmlydC9nZW5pZXpvbmUvTWFrZWZpbGUNCj4gYi9kcml2ZXJzL3ZpcnQvZ2VuaWV6b25lL01h
a2VmaWxlDQo+ID4gaW5kZXggMjU2MTRlYTNkZWEyLi45Y2M0NTNjMDgxOWIgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy92aXJ0L2dlbmllem9uZS9NYWtlZmlsZQ0KPiA+ICsrKyBiL2RyaXZlcnMv
dmlydC9nZW5pZXpvbmUvTWFrZWZpbGUNCj4gPiBAQCAtNiw0ICs2LDUgQEANCj4gPiAgDQo+ID4g
IEdaVk1fRElSID89IC4uLy4uLy4uL2RyaXZlcnMvdmlydC9nZW5pZXpvbmUNCj4gPiAgDQo+ID4g
LWd6dm0teSA6PSAkKEdaVk1fRElSKS9nenZtX21haW4ubyAkKEdaVk1fRElSKS9nenZtX3ZtLm8N
Cj4gPiArZ3p2bS15IDo9ICQoR1pWTV9ESVIpL2d6dm1fbWFpbi5vICQoR1pWTV9ESVIpL2d6dm1f
dm0ubyBcDQo+ID4gKyAgJChHWlZNX0RJUikvZ3p2bV92Y3B1Lm8NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92aXJ0L2dlbmllem9uZS9nenZtX3ZjcHUuYw0KPiBiL2RyaXZlcnMvdmlydC9nZW5p
ZXpvbmUvZ3p2bV92Y3B1LmMNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAw
MDAwMDAwMDAwMC4uMWFjYTEzZmVmNDIyDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2Ry
aXZlcnMvdmlydC9nZW5pZXpvbmUvZ3p2bV92Y3B1LmMNCj4gPiBAQCAtMCwwICsxLDI0OSBAQA0K
PiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+ICsvKg0KPiA+ICsg
KiBDb3B5cmlnaHQgKGMpIDIwMjMgTWVkaWFUZWsgSW5jLg0KPiA+ICsgKi8NCj4gPiArDQo+ID4g
KyNpbmNsdWRlIDxhc20vc3lzcmVnLmg+DQo+IA0KPiBuaXQ6IEl0J3Mgbm90IGNsZWFyIHRvIG1l
IHRoYXQgc3lzcmVnLmggbmVlZHMgdG8gYmUgaW5jbHVkZWQgaW4gdGhpcw0KPiBmaWxlLg0KDQpP
ay4gSSB3aWxsIHVwZGF0ZSBpdCBpbiBuZXh0IHZlcnNpb24uDQoNCj4gDQo+ID4gKyNpbmNsdWRl
IDxsaW51eC9hbm9uX2lub2Rlcy5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvZGV2aWNlLmg+DQo+
ID4gKyNpbmNsdWRlIDxsaW51eC9maWxlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9tbS5oPg0K
PiA+ICsjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ID4gKyNpbmNsdWRlIDxs
aW51eC9zbGFiLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9zb2MvbWVkaWF0ZWsvZ3p2bV9kcnYu
aD4NCj4gPiArDQo+ID4gKy8qIG1heGltdW0gc2l6ZSBuZWVkZWQgZm9yIGhvbGRpbmcgYW4gaW50
ZWdlciAqLw0KPiA+ICsjZGVmaW5lIElUT0FfTUFYX0xFTiAxMg0KPiA+ICsNCj4gPiArc3RhdGlj
IGxvbmcgZ3p2bV92Y3B1X3VwZGF0ZV9vbmVfcmVnKHN0cnVjdCBnenZtX3ZjcHUgKnZjcHUsDQo+
ID4gKyAgICAgdm9pZCBfX3VzZXIgKmFyZ3AsDQo+ID4gKyAgICAgYm9vbCBpc193cml0ZSkNCj4g
PiArew0KPiA+ICtzdHJ1Y3QgZ3p2bV9vbmVfcmVnIHJlZzsNCj4gPiArdm9pZCBfX3VzZXIgKnJl
Z19hZGRyOw0KPiA+ICt1NjQgZGF0YSA9IDA7DQo+ID4gK3U2NCByZWdfc2l6ZTsNCj4gPiArbG9u
ZyByZXQ7DQo+ID4gKw0KPiA+ICtpZiAoY29weV9mcm9tX3VzZXIoJnJlZywgYXJncCwgc2l6ZW9m
KHJlZykpKQ0KPiA+ICtyZXR1cm4gLUVGQVVMVDsNCj4gPiArDQo+ID4gK3JlZ19hZGRyID0gKHZv
aWQgX191c2VyICopcmVnLmFkZHI7DQo+IA0KPiBuaXQ6IFBlcmhhcHMgdTY0X3RvX3VzZXJfcHRy
KCkgaXMgYXBwcm9wcmlhdGUgaGVyZS4NCj4gDQo+ICAgICAgQWxzbyBpbiBnenZtX3ZtX2lvY3Rs
X2NyZWF0ZV9kZXZpY2UoKSBpbiBwYXRjaCAwOS8yMS4NCg0KT2suIEkgd2lsbCB1cGRhdGUgaXQg
aW4gbmV4dCB2ZXJzaW9uLg0KDQpUaGFua3MsDQpMaWp1DQoNCj4gDQo+ID4gK3JlZ19zaXplID0g
KHJlZy5pZCAmIEdaVk1fUkVHX1NJWkVfTUFTSykgPj4gR1pWTV9SRUdfU0laRV9TSElGVDsNCj4g
PiArcmVnX3NpemUgPSBCSVQocmVnX3NpemUpOw0KPiA+ICsNCj4gPiAraWYgKHJlZ19zaXplICE9
IDEgJiYgcmVnX3NpemUgIT0gMiAmJiByZWdfc2l6ZSAhPSA0ICYmIHJlZ19zaXplICE9DQo+IDgp
DQo+ID4gK3JldHVybiAtRUlOVkFMOw0KPiA+ICsNCj4gPiAraWYgKGlzX3dyaXRlKSB7DQo+ID4g
Ky8qIEdaIGh5cGVydmlzb3Igd291bGQgZmlsdGVyIG91dCBpbnZhbGlkIHZjcHUgcmVnaXN0ZXIg
YWNjZXNzICovDQo+ID4gK2lmIChjb3B5X2Zyb21fdXNlcigmZGF0YSwgcmVnX2FkZHIsIHJlZ19z
aXplKSkNCj4gPiArcmV0dXJuIC1FRkFVTFQ7DQo+ID4gK30gZWxzZSB7DQo+ID4gK3JldHVybiAt
RU9QTk9UU1VQUDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArcmV0ID0gZ3p2bV9hcmNoX3ZjcHVfdXBk
YXRlX29uZV9yZWcodmNwdSwgcmVnLmlkLCBpc193cml0ZSwNCj4gJmRhdGEpOw0KPiA+ICsNCj4g
PiAraWYgKHJldCkNCj4gPiArcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gK3JldHVybiAwOw0KPiA+
ICt9DQo+IA0KPiAuLi4NCg==

