Return-Path: <netdev+bounces-212820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF745B221CF
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B67772082C
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 08:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACFF2E7655;
	Tue, 12 Aug 2025 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kd0Rpl8N";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="EOqqZTpx"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E732E6133;
	Tue, 12 Aug 2025 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987982; cv=fail; b=fGjEn3wG6CBks2Wd8Emq1xNWV5OEGCVfWp71p3s0ARjDFuXXySYX3dZlWKxf5XFchr5Iazfg+ZEjK/yR9yEKSL1WV1yt4Nz2M+snZleRYdXYJmd5SCqa3CJRyKd/msLsM/eaFGbfvvXNWus98PJR1zYmfGoadyEdJ7ru/xhNcR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987982; c=relaxed/simple;
	bh=xB429bzdgZUTxIbLTus+KLSR+lz8BAYWt5dY4sSnbfY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lQFpFXHhgdw7syRGGYy2eLtSEIsX7MYGjZPFX33FUSojRYD+4Pd+3vuAODsCC5SFnjQCHqKz7ajrq6MgX9ROiaPzh3/9xXGbgQijq09CVQZvryUj4hIEk3k5uwNmcLv0LIMC7UeIlCWEb9f8IedzlnGkmxDIhumrUp5aK7Jb+ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kd0Rpl8N; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=EOqqZTpx; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: da2650ca775711f08729452bf625a8b4-20250812
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=xB429bzdgZUTxIbLTus+KLSR+lz8BAYWt5dY4sSnbfY=;
	b=kd0Rpl8NVYtnc/sDEPe6UjtQ6Z/xExntuQHa5Hpy2jKcg8H0pZ1el1zRUjyuozeQn+24pZm+JaIKyxESgYi8Ytbb7CWLe8diIpkd/7/edsLCrkq1K1LSsxoSzOOMSoU2ElbOteJWoUTbAQahK4P6meJvTPsDM/VHcMsBqNhFC+U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:1ff58d60-780b-40ac-9202-e2a0fb4ec2fc,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:25a551ce-1ac4-40cd-97d9-e8f32bab97d5,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: da2650ca775711f08729452bf625a8b4-20250812
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1494280449; Tue, 12 Aug 2025 16:39:25 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 12 Aug 2025 16:39:23 +0800
Received: from TYDPR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 12 Aug 2025 16:39:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imw5iy9q7tTYa2lrvl8iO0ERAYkPzK6kVpyR3PI8elgA53bZoMes2kEfcFGWkbOt/YoUDIhPDaB2uwFronGP+dwvqgB05z2Yp4nW0jedYaf+iykvaq0WS9QCWKFwnlv9XSE7w05EIEPt3EYyhvSqdsKxEby6HVPoKOB6DHOJiMmIpImk/1XQQfxrrizn4+wtFGNJfdLjaVwfuBO0fBEm/lSSzUo2xBRK4mH2LZujiDZ6/8Wh3g8r26TlgOWprEPTS2KXG8A3p4JvdLOsg1uckz0v70WAHThogDZMZpu9Otp942TMiknJxcWBmVhKS1/aiFSN/w7gmTpZ6cqHG2yVpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xB429bzdgZUTxIbLTus+KLSR+lz8BAYWt5dY4sSnbfY=;
 b=NfmbHwBtjN+G11vNCZo8CGKqJ4GRUOaZ6T0ehvwpSV8GCrjYfss+5pQzcuF84ime7xICtxEGN4eL6ajojzitXsnStUGYag/wbe/SB4KbojTcRLEAyWYQkML3vhCsP0cyx3HK5UsN8BmX25KKCsp/HxD6IptkDLolojeaUTWRugAWZXVpZjM156dqmWoFP7qOnqw+nppDO7J7mRFPwP2uqx2cmiXdTmE/sffJo4fQf3ugTX2It/n70H995NcNB+u/vqZmPHYNh4DBGm8cvZLchh2djWgPCaLkV0mT4iceKFST7M22tBwWySzTQNqQeNC+IAuH0dbuG497B7W6N4Magg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xB429bzdgZUTxIbLTus+KLSR+lz8BAYWt5dY4sSnbfY=;
 b=EOqqZTpxiscn1EYT0F75TpX27VqetNC3GuqWg4hfIfYQQBKdi/kJaJnoAh/ZWdNfn1FrlTo1GgfT/HewBjnTjedq62z3O6ROg0NmPgK/zlw7TGrRyaY0kECLNi0nkdodYdeHxOzwQ8MK3MLRcKudtPMrYGWKTztXzzHBLhvzLb4=
Received: from SEZPR03MB8273.apcprd03.prod.outlook.com (2603:1096:101:19a::11)
 by TYZPR03MB7483.apcprd03.prod.outlook.com (2603:1096:400:423::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 08:39:21 +0000
Received: from SEZPR03MB8273.apcprd03.prod.outlook.com
 ([fe80::f7ac:70cb:3cb4:acac]) by SEZPR03MB8273.apcprd03.prod.outlook.com
 ([fe80::f7ac:70cb:3cb4:acac%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 08:39:21 +0000
From: =?utf-8?B?TGlqdS1jbHIgQ2hlbiAo6Zmz6bqX5aaCKQ==?=
	<Liju-clr.Chen@mediatek.com>
To: "corbet@lwn.net" <corbet@lwn.net>, "krzk@kernel.org" <krzk@kernel.org>,
	=?utf-8?B?WmUteXUgV2FuZyAo546L5r6k5a6HKQ==?= <Ze-yu.Wang@mediatek.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "robh@kernel.org" <robh@kernel.org>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "will@kernel.org" <will@kernel.org>,
	=?utf-8?B?WWluZ3NoaXVhbiBQYW4gKOa9mOepjui7kik=?=
	<Yingshiuan.Pan@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: =?utf-8?B?U2hhd24gSHNpYW8gKOiVreW/l+elpSk=?= <shawn.hsiao@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?S2V2ZW5ueSBIc2llaCAo6Kyd5a6c6Iq4KQ==?=
	<Kevenny.Hsieh@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, =?utf-8?B?Q2hpLXNoZW4gWWVoICjokYnlpYfou5Ip?=
	<Chi-shen.Yeh@mediatek.com>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>,
	=?utf-8?B?UGVpTHVuIFN1ZWkgKOmai+WfueWAqyk=?= <PeiLun.Suei@mediatek.com>
Subject: Re: [PATCH v13 04/25] virt: geniezone: Add GenieZone hypervisor
 driver
Thread-Topic: [PATCH v13 04/25] virt: geniezone: Add GenieZone hypervisor
 driver
Thread-Index: AQHbNn029Xq+tnHy3U+kHaTtB6IkebLg5LqAgX9dFQCAAAU2gIAAFTEA
Date: Tue, 12 Aug 2025 08:39:21 +0000
Message-ID: <faa50dbe58e021a67786aff6fe646b6dcaaa05f5.camel@mediatek.com>
References: <20241114100802.4116-1-liju-clr.chen@mediatek.com>
	 <20241114100802.4116-5-liju-clr.chen@mediatek.com>
	 <7b79d4b5-ba91-41a0-90d1-c64bcab53cec@kernel.org>
	 <cb84d8d87a67516f9b92a89f81fe4efc088f7617.camel@mediatek.com>
	 <09179c67-1dbe-41e5-9905-26b4c6bf9f60@kernel.org>
In-Reply-To: <09179c67-1dbe-41e5-9905-26b4c6bf9f60@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB8273:EE_|TYZPR03MB7483:EE_
x-ms-office365-filtering-correlation-id: b4e964a0-d7b8-4f72-3b43-08ddd97bbbea
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dGR5UmlMcXZ6TzY2Rm15bUdETmVhTFF2L2dlZHZERHdVbVVCTmZ3OURBeThj?=
 =?utf-8?B?SUMrVUE0S0lrTEdzZEtQeWdiYmtPTEFxUUVlemg1QjJ6Y2tSZXAvZk95UzQ4?=
 =?utf-8?B?UHRDUm1BTjBRU2h5NzhQNUVXa3laejMzcFRsclNjWTlLK25ub2hjQUxoWmVR?=
 =?utf-8?B?cVpHaENBbUtjdVlMSXdRVTJNK2hDV3Vvb3JUQTg2dE5WTTdkVGxrSXhqRFQw?=
 =?utf-8?B?NHIrRlozQS9GRzdNcmFzZkEwM3BpVjBwaTVreHV2eFB2QUpUcDZ6UmcxRi8r?=
 =?utf-8?B?STFtT1dUTVJHN0xiY04zZ1JCb004NmNTNG9SNVg0Lzk3SXRQRkQyTkFndEZx?=
 =?utf-8?B?WHNUcmxFK0tJeGYzajNGalVnU1JoUWFpZ1R0VHVFSnhWWldpajFTUDZNQkpi?=
 =?utf-8?B?eTN4Z3hTclJZNDh0N1RBMVBUWnlOMDNTYzFxYUx0aWJXazVHYXhHaU9ydlVH?=
 =?utf-8?B?RkxrQnp5RFRRU0UrazB0a3prUjJQNHVOZ0NtcFY0VW9sSjVjRHNvNWFRZ2VJ?=
 =?utf-8?B?Q1BDd1JGS0NMQWIzQ3NZNmtQQ21wZGpUT2NvckFKblVtdlNOcStnYnNhN0J5?=
 =?utf-8?B?eFNBNWViNElVclptaHd2NnhsNkhWUlpPMUtBcnZReVVsTllpT2pmbHBoR25p?=
 =?utf-8?B?ZlN1MWt5VWljeU9pSWpiVjFsOWlWRTl0NnExbkx4b09TSG9YanJBOFZkSnpr?=
 =?utf-8?B?d2diVlVBQXlXN00rOVBkenp1R3M4UFhYQWdYYWlFdnVWc2MvRGlZS0ZRL09L?=
 =?utf-8?B?VTNpWjFMQnZaNDlvVmtmSlQzNUUxZ0Z4Mm8yN0lmRHI1bm1vU0dldGZmZmpE?=
 =?utf-8?B?UjZINklzSXpycUgzS2FhbjFWaHh0MG15VEk1SGhBL3M2eFJtdk5yOVBGbldC?=
 =?utf-8?B?SmdqSWFJQW1GYzNmb0Fjb3gvTDRzYy9jT08vM1BISGFBRDRuNnNqYWNnWlpn?=
 =?utf-8?B?emRyemFlQktJbm9mSCszNlMyenZxUTY0b0MyeEtUSkRqVXo4UmtwRWFNN1Ri?=
 =?utf-8?B?NVVUek5Bd1lPajV3dVVFSWl6dEJPUS9vTTF0aGN3YTF0ZFozUkNZbnNXd1d5?=
 =?utf-8?B?VTQxeWMrRDRpSHZ6TFhFWUNOSHhYU29RakxhUU1FL0ZLVlg5V1E4QitxY2lS?=
 =?utf-8?B?c0ZpTjdlTzlRNVlHOVZ3YmdlZGM4YlQxU0wyZW5hTGNEaW44emozQm5lNHVQ?=
 =?utf-8?B?Y3J2Qk1mYXpxZjNHTTBBRElNeWdvY1lpRmRsNThMaUczZlRMcG1RMC81SXVn?=
 =?utf-8?B?a0JDOXhJMDB2Q3JEb1FPMG9HY2dYNGJKbzN0bWZ1WXpyb1NDOHlaRjNFNWV6?=
 =?utf-8?B?b0o3MEN6TDNnZDFsM1lmdUd1bnFzMWkvQXlBWmxNelF4aHB4bnZNZ2NpMFdJ?=
 =?utf-8?B?QWV6MHdtNy9GZFRDNVZmUGZKMEltOUhqOERRMURodzB1b2FLU1haTnB6U3FW?=
 =?utf-8?B?ZnRmOXdQYlRqeEs4SzQxRE9yMGd4eG5YL1JUc25Sc0V3cWRick01ZWsvQVhU?=
 =?utf-8?B?SEI5VWNXRzZ1K3pIRm1UQm54bitJVm5ZVmNRMzBZVnJ4bzROTGRFOFA0ZGhZ?=
 =?utf-8?B?cWVIQWhDVFJYUVlKc3l4eFVZanVtb3JNUzVhcUxPblVtYmZ0RXhhM2pBMko0?=
 =?utf-8?B?N2Q4NWM2QUxCOGgxWUR4WUhpZVhYdWc5Qk93a2JxN25kRFdsRm11eHZVZkN2?=
 =?utf-8?B?Y2JUWVJhQ2hidm5HMWJtM05NS1k5UU9JSDVYME14YzJNb3kzL3Q4dE5iUnBE?=
 =?utf-8?B?UEZxRGdjRnNxL2N6NTRWb2szSHQ3ZzR3WmNrSFRVWENQL2FONGVaZkJnS2l3?=
 =?utf-8?B?a0lhMHY5QXZyL2JuMUJyWkRxcTBKcng1TlpjRTh2dExTdGMvSWNkOTZPSENk?=
 =?utf-8?B?eUJEdFlZRys4NjdzVnNlejgzWktscVBSVXF1V0ZVMHhXNUhpKzkyQlhTU1cw?=
 =?utf-8?B?a1p1Wk1nTjdGSkN4N0dkeTh2Z0xSVHhveVlvcVFvS3dLT3ZQMnFwelA3YlJL?=
 =?utf-8?Q?6IOjshP9Xx8fA/9lZhxl+zYQ9FJecI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB8273.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzhxelRhblIwUTJLUVVrbW5IYld0eWg4cXZMblZwaTBjRUluR080K293TkdU?=
 =?utf-8?B?ZWdJbUdVL0krcG52WjN3VUJoU3gwVE05S28waStJRHNaZURNdmtpeHRVSFEy?=
 =?utf-8?B?cENURTlYOXJFZjcrTkM2MVF5WWtsYnhiOTJEcm1GSFZSeitQK01xSzJObDZC?=
 =?utf-8?B?Z1ZRV0M3eENrSytvMS83LzZ5QWcraDVnVEhPZ0M5RFA4ZVRhbnRCVjkzL2FW?=
 =?utf-8?B?SGZZeVBiRUZMeGVqdmlPL3R2dEdua2k5UUY3WnRZOTVMYm1vYkw0R2tyTm0y?=
 =?utf-8?B?bHJtdHAyTTIyRUZ1b3NnUnJQdWNTZEpTaWNJZlkxdkxsZk9hRHo0ZmZDenJz?=
 =?utf-8?B?NWZPTFBXQWM5MVN3Zno2clhWd1R6YlpnRjBPL2ZZd2lPWWFZRGE5V3k1WUFo?=
 =?utf-8?B?dGlQMTVIMkZZbkpyL3VGVU93ZFlEVjdHdVJqNU9TSmhKMFZhWXlhb2EwUmF3?=
 =?utf-8?B?RHlabGRYWGc0bG9ZVGcrUDNETFhZQm9NSWd1VjErWkZRL25qYUVWS1N4dGFq?=
 =?utf-8?B?KzBpMUFoMURZNEo1YTlnQjlSVXNRRmdKWWcxZUhndHNPWWh5MjRzZXVyTHcv?=
 =?utf-8?B?bnIrQlY4bHNxckorKzhIWkF5VG5tMTQwdVg1c3l5ME9DWUpkaHFWSnF2UUJK?=
 =?utf-8?B?TEp2STgvUnhpeC9adVJpUzdyVjNzUmNCYnVUYWF3NjVmZWJUQ1J0YlJaMHEy?=
 =?utf-8?B?RTYyUlZ4Vy9xc2hieGRFbitwRmF4ZTBRMWFwYVZTRE5aRzlvdVlCSGg5M29Q?=
 =?utf-8?B?NkM1Q2J1Y1hkOGMwM3NKY1NweUh3MFpEWUxobGhsR1plWlFPaFMyeU14RGUw?=
 =?utf-8?B?ZlhNZndLR0I2UFQyZEh5T1dlL3h6R3VZYTFOV250QXp4VFRYUXVYb1hQbmU2?=
 =?utf-8?B?eHcrdExpT0t6WEZzWWpGRHUvKysvdjViTFFQQlJtOC80V1NiNWd3b1V4WTBB?=
 =?utf-8?B?bTFoUVh6aFBod1RzaWt2YUxRaEo5SnhoRUlTYUplNkNuUXl1Rko4QkJFUlhC?=
 =?utf-8?B?VEdxbVBtRHJlQXhFeHZrR1c0RFZSRUNLdzBLSElPT25aeEhnQnMrVFBKRXBq?=
 =?utf-8?B?aG9uYUg2aUt5by9ZR1d5VVZjZEtqTXF0aVB4cmNqTFJhSXFneUhKN0NkdHdl?=
 =?utf-8?B?cExpN2lYL2owL1VlYjh5RjhvVGdZb3E1eEdNaE1MZlhZVlc5V0dCNVErelkz?=
 =?utf-8?B?WUI1dkE5a3hORDFYOWJwVjQySWlJNWhuMmx0UDJCM2lxUjU5UmtUTnloRUZQ?=
 =?utf-8?B?dGRYaVphbThRK2lCZEJRRS8zUUVDWW1YVSt5bzBUSU1tckVJK2ljWUZyRlpx?=
 =?utf-8?B?TksrUnhKUWs4azF4d0w2eWJ0T000bUVGQmFWQ1dYVTBoTlpPV0ZNaXlFQjZv?=
 =?utf-8?B?a3FoZm5GUDRHb3BQdS9yanI4MENpRUdubUlvRWxiWFBtZXdzWTlKdE1COTRL?=
 =?utf-8?B?MXRDOExiam1Ea3dvS0hNUDNEODVGeHIwemx3TjZsNTlqTkcvNkRydHZBQWQr?=
 =?utf-8?B?MlduTHlaVmwrWmFXN0ZEM3VtMmJVUm5hQ1c2Y3l1WmJUdi9FRE1tRVFOeC83?=
 =?utf-8?B?enRUYjhISUd5MXgrZ1V1U0NNc1VwcVBUNFg2cXcvZWVXQlAzRm9Cb0U3LzRP?=
 =?utf-8?B?TGpwdUVkT1BWMVVaRjRDakIvbzI2clpoV1pWMVo0U00vSlUvQ09hdnBUajhl?=
 =?utf-8?B?QlZtSXhyZk1LL0xhY0FwdWdkbUlLWmJTTjdmTGxNRTlRem81SGtGTjZYdHVi?=
 =?utf-8?B?eWp3dHdiTXBNTnZSMTFLSTdBMkMzL2RoT3RQRlN0SFVDN2NoN1Jkb0V6d3hH?=
 =?utf-8?B?QmtWTnNPbVhwdUpaY21mT1pOemNidEZIVXJoQzRNTjI0N1BLdTBPWEhEQ1Q1?=
 =?utf-8?B?dEZvclFwMkJqQnM2ejBnZVYvTlQ1cE4wcCtWak8wZEl0NHdWQ0dQL1lJSlBo?=
 =?utf-8?B?OVhyRlE4OGhyTG1hYnBCL0IyeDNLTXdwZHAzRkxRcm9HaWZtVXJrNXR4QTh4?=
 =?utf-8?B?d24wOU56TnNINGFmOXhuQzNVMnh1WEZOMytrQzhVV21FTlorVjJVYUVpU1Ra?=
 =?utf-8?B?UFZPaFIrcXp0UmQ5UVEzcThBVUtDVm1EdnA1MTBMbThKMjRYb1VCL3VnQzMw?=
 =?utf-8?B?RDlLQ1k3WnFUa0pKVmhUeUsya2pTdnYxZ1orNnlmbUVFNUxCTDEvRUlIdGRZ?=
 =?utf-8?B?WGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0EBAB4CDD1B50C4DB557758DA880D551@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB8273.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e964a0-d7b8-4f72-3b43-08ddd97bbbea
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2025 08:39:21.3137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oYmRIS+9hkww3K1BrqiLuoWOxG/JjeIslMWyquQmjeZOOVR2BI8JntCDohN4VtK/kXIt1kRA+F0iOrjWMIYZYOIohvE7d907Kj3un5aqZR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7483

T24gVHVlLCAyMDI1LTA4LTEyIGF0IDA5OjIzICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBPbiAxMi8wOC8yMDI1IDA5OjA0LCBMaWp1LWNsciBD
aGVuICjpmbPpupflpoIpIHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAyNC0xMi0xMSBhdCAwOTo0NCAr
MDEwMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gPiA+IA0KPiA+ID4gRXh0ZXJuYWwg
ZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMNCj4g
PiA+IHVudGlsDQo+ID4gPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IE9uIDE0LzExLzIwMjQgMTE6MDcsIExpanUtY2xy
IENoZW4gd3JvdGU6DQo+ID4gPiA+ICsNCj4gPiA+ID4gK3N0YXRpYyBpbnQgZ3p2bV9kZXZfb3Bl
bihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZQ0KPiA+ID4gPiAqZmlsZSkNCj4gPiA+
ID4gK3sNCj4gPiA+ID4gK8KgwqDCoMKgIC8qDQo+ID4gPiA+ICvCoMKgwqDCoMKgICogUmVmZXJl
bmNlIGNvdW50IHRvIHByZXZlbnQgdGhpcyBtb2R1bGUgaXMgdW5sb2FkDQo+ID4gPiA+IHdpdGhv
dXQNCj4gPiA+ID4gZGVzdHJveWluZw0KPiA+ID4gPiArwqDCoMKgwqDCoCAqIFZNDQo+ID4gPiAN
Cj4gPiA+IFNvIHlvdSByZS1pbXBsZW1lbnRlZCBzdXBwcmVzcy1iaW5kIGF0dHJzLi4uIG5vLCBk
cm9wLg0KPiA+ID4gDQo+ID4gDQo+ID4gVGhhbmtzLCB3aWxsIGZpeCBpbiBuZXh0IHZlcnNpb24u
DQo+IA0KPiBJIGdhdmUgeW91IGNvbW1lbnRzIHdpdGhpbiBob3Vycy4gWW91IHJlc3BvbmRlZCA4
IG1vbnRocyBhZnRlci4gVGhhdA0KPiBpcw0KPiBub3QgbWFraW5nIHRoZSBwcm9jZXNzIGVhc3ku
DQo+IA0KPiBJIGV4cGVjdCBhbGwgY29tbWVudHMgYXBwbGllZCBpbiBzdWNoIGNhc2UgYW5kIEkg
d2lsbCBub3QgYmUgcmVhZGluZw0KPiBmdXJ0aGVyLiBZb3UgZ290IGNvbW1lbnRzLCBpbXBsZW1l
bnQgdGhlbSBmdWxseS4gSSB0aGluayB5b3UgcmVqZWN0DQo+IHRoZW0sIGJ1dCByZWplY3Rpb24g
YWZ0ZXIgOCBtb250aHMsIG1lYW5zIGFsbCBjb250ZXh0IGlzIGdvbmUuDQo+IA0KPiBOQUsNCj4g
DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCkhpIEtyenlzenRvZiwNCg0KVGhhbmtz
IGZvciB5b3VyIGZlZWRiYWNrIGFuZCBmb3IgcG9pbnRpbmcgb3V0IHRoZXNlIGlzc3Vlcy4NCkkn
bSByZWFsbHkgc29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5IGFuZCB1bmRlcnN0YW5kIHRoaXMgbWF5
DQpoYXZlIGRlbGF5ZWQgdGhlIHJldmlldyBwcm9jZXNzLiBJJ2xsIG1ha2Ugc3VyZSB0byByZXNw
b25kDQptb3JlIHByb21wdGx5IG5leHQgdGltZS4NCg0KVGhhbmsgeW91IGZvciB5b3VyIHRpbWUg
YW5kIHVuZGVyc3RhbmRpbmcuDQoNCkJlc3QgUmVnYXJkcywNCkxpanUtY2xyIENoZW4NCg0K

