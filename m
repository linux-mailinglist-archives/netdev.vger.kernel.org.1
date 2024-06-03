Return-Path: <netdev+bounces-100077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F19E8D7C53
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633051C21AFB
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 07:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90AD3F9D9;
	Mon,  3 Jun 2024 07:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QPtAkiOH";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="leUBGit9"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F053EA95;
	Mon,  3 Jun 2024 07:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717399189; cv=fail; b=hIoemx7gi0ltXO61nazOs1VYJAvrSMl06jU11oK6n9q/BBcVo1WSkggyCxiDBy5Z7eUDuClIT2/A8JTpo7TQGZqfLFHd7HOmiUFQ9H5kaGVB0IEMAS0ITVc9/DLGgm3kIqwdtQYwDGZ1JkDRdkr+0xsYgJ5Bl1nuMZQJBLbxgYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717399189; c=relaxed/simple;
	bh=7uNWwlz4FCymI3ylCvdAKbEq9jK8S5hGZl/w+q0Hqaw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f1SH+0P7sueGSKVvIJYDLXxxs5n9Xr+NhQocjmfX4CGNwtK3QJdPba1TsZekI5QkizB2r6D5lYbSzeik9iWhxE07dd8QJNkkp8u29IDva2wjgD8GA6NR5juVgK+sfXJzJiQcjAiGkB6IfZiOf8WW6cEUF4IYOjrxNNJdOtHoruY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QPtAkiOH; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=leUBGit9; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a3448a5c217911efbace61486a71fe2b-20240603
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=7uNWwlz4FCymI3ylCvdAKbEq9jK8S5hGZl/w+q0Hqaw=;
	b=QPtAkiOHNpfKT9G5gc30TXZkTWZsv1DXRThkmsbwAmOqXtUzHFAsen5P3miBawJ6qtVtDgXFjIzxEMT7u4wYs8u6h2qkbRFmHjOHld7ahTzN1Wg0G0XlPpuQlcJ58Q2mhT6v5yE1DsVxC9+HnRqpYj262yJZsboeSQSN8L7geLk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:da579aad-f372-42dd-b1ee-40a0cc86de5f,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:393d96e,CLOUDID:9e7f2144-4544-4d06-b2b2-d7e12813c598,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: a3448a5c217911efbace61486a71fe2b-20240603
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 846361397; Mon, 03 Jun 2024 15:19:38 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 3 Jun 2024 15:19:38 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 3 Jun 2024 15:19:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0oeJylUi5YEw8QLsQzC5mj/0BpTRPm56Sj0OegvTo4DGv053vPBWSGZJL3r9MNIwZouyX9ZmSrO9GBZEMk5zavOLTXDkAeyEH05Z8yARGIOsFJk/kXLYHqnFjNNUvN+Qx4/bZuzjd+iRzNKfp85aVVazjL+FEqnuxarUlOyrRCe6/tP5Lz+rQ+aaN39DzXHxLlqNu3GUHzh6qfNMnrxpn1ahSk1dKR9650gH2l+sLxj3IdALH+4L7syVxVHe57qy3OVJ5AiOcXku6BUKsKGFjTdjEhsXYn+b+WuHpb50/TxMUvGUoiowW8nmQcSWssFGVkPSgxp2Om+Eun7cAfp/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uNWwlz4FCymI3ylCvdAKbEq9jK8S5hGZl/w+q0Hqaw=;
 b=VOBsB93GMO4VjuSePmRdgtwiHR1Zd8xU8CBVpH0O3It+J+Np/cRQIUrshC8S0G5a6z/SHBy1SxdihgxdCFhIgJEZDpjQ03tptWgoYUiuSOISZCziijFWqLSAWM/4V9y1PWwVyweHzJVOumkuPHmEbMz9Cw/zYjc1jM7xwRYiK7uBAa7XFbQIyR7D2C/BNBTekgdXyvk9L9JebCIoJ93qJke9wVL7EVoe70e9V5MX+ujxdP4b+RwSbms4jfTtg1k/lzFKD5wLYB1zJXK+uwKDn5Rel/1ejG91h/UGulGIR5Rol1WbhaaR5KVzuGTOMXiCWhndDYHrFiaBuzEPwp9STw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uNWwlz4FCymI3ylCvdAKbEq9jK8S5hGZl/w+q0Hqaw=;
 b=leUBGit9KRwVF4XzxFhyG6RKpKlGU+VXNRnZ7D9tYp3ZFeYCRMQOh/koP7+blOb/BJj4loK/novNzo2JFSXzvFZt0aSsKpm/MPBiMpyhghV5i2n9xPbEXUS+FaiDkmS448qfiZ41rto+dtn9WW5OqAglGXnw6GuKtM2hVj+d9ag=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by PUZPR03MB7188.apcprd03.prod.outlook.com (2603:1096:301:119::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.15; Mon, 3 Jun
 2024 07:19:35 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%3]) with mapi id 15.20.7656.007; Mon, 3 Jun 2024
 07:19:35 +0000
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
Subject: Re: [PATCH net-next v5 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Thread-Topic: [PATCH net-next v5 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Thread-Index: AQHaskSsuAYxyIGHGE6fd61psDix3LGvlbQAgABh2ACAAAhEgIAFqGqA
Date: Mon, 3 Jun 2024 07:19:35 +0000
Message-ID: <71a414402c1566a3bb93ca01a9519a824cda7df9.camel@mediatek.com>
References: <20240530034844.11176-1-SkyLake.Huang@mediatek.com>
	 <20240530034844.11176-6-SkyLake.Huang@mediatek.com>
	 <ZlhWfua01SCOor80@shell.armlinux.org.uk>
	 <0707897b44cfbc479cd08a092829a8bfc480281b.camel@mediatek.com>
	 <ZlivgVpycflhLUcl@shell.armlinux.org.uk>
In-Reply-To: <ZlivgVpycflhLUcl@shell.armlinux.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|PUZPR03MB7188:EE_
x-ms-office365-filtering-correlation-id: a7bab6c5-7191-4488-0494-08dc839d858e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?T08wQ3Vvd3JXQ2N2WFNEancxdnNmZ09yT1M4QlVBTTQwOUZ2YmVYQnNUbXJ6?=
 =?utf-8?B?ZWdBV2pWOW9XOE1GUE1SSVBQWFVsaHZzdzJUNms1MTlicXpCMHdpQzlVL1Vl?=
 =?utf-8?B?SWUyYnFiR3UvakZiYS8rRTdRMHFaV0Mvb2pXK1VQdjVkLzlwY25Rd0o2MUdp?=
 =?utf-8?B?b2hPYzF6eVROdG9XdmlOcXVPb3RRQXVsYWpFNGliaTZSWlIycUt2aEJhbkh5?=
 =?utf-8?B?SEJXTXdTOGtKU0FUUjA1NzlXZms0d1h2L2tPRlRxM3hOQVFVRnJCMFdlQVRB?=
 =?utf-8?B?cC9GcFhHblJsNDdJaHNkUUdpOC9UcGtjSlpBV3BaVmtGRldJUDRwNDQ3Nmpa?=
 =?utf-8?B?UkVTSWVVSmErUk5WN1k1bmFJMjZJRlFxL0hTZ25DMUNBK0JPcldVVmN0M3Rm?=
 =?utf-8?B?RUdqTkhZbFVDVlJVTzVwUUx3K2VibzR5RVFYQm5sNDBWNFBtVm15TnNTVEtF?=
 =?utf-8?B?Witnc0FKdU9MbVZTaUhJVm13aXIrazhlRXMzSUI2SXd5L0g5OVVkRnh5YUww?=
 =?utf-8?B?SEdHcnRWR0xhVlFCcjJDOE1zSlJMUjMwcXNGcWZvOXZETEUyM2ttWFNSY3Nx?=
 =?utf-8?B?dTNCQ0RHNVd0Nk9zWURGZXdTVGRYOVR2ZmRlb0VmOEkwYWJYUThsODl6T3ls?=
 =?utf-8?B?bGIybUJlM3NuMGpBcThibCthWklmOVpLYTNvbTJOMzBGZk4zb3FUZWdNK1N0?=
 =?utf-8?B?aUFwanlIMGJkdWkrdWpKSlFLUncxTFR6dW1UZklRWkpmb3BRWm5kcmlBbW5D?=
 =?utf-8?B?c0Rxa3J0ald4RWcxd2UrelZ0YWl5cXRCQjh0MWk3SzUrdndJRmlWS21FOURR?=
 =?utf-8?B?Y1lhTG9TOGJCZlJDbWk4WGp0VVJta1V4SXF1MjB0NVdldHdCREtWaEpjL0NR?=
 =?utf-8?B?T01EK0xaN1RZVlNDRVF3NmxTbHFrV2pFdlMzdkxKQVRIdnJNYkFwNnVJdUwx?=
 =?utf-8?B?M0taRjZRNmFReXBjeXlEejh4SWY0MFEwd2RZK0pDRGprdWZtR1pUd0lvVDZ1?=
 =?utf-8?B?SlE4aS95NkJnUTZHK2t6bzBUSktLbkRMZmVtbkFZbngyQWRQU29LUGpFSFVK?=
 =?utf-8?B?THdQYkZydUJjVzdCZmRqSzg5NStTdWxiT3VlckVUVkFCcGR2VXEyaW9MRVJB?=
 =?utf-8?B?M0lBTHFhbnlLVk1DK2hlOWpQNDk3aEppVlEyME9WM1BJaDRNcW9MbTExaVA1?=
 =?utf-8?B?WTZ3bC9EekhiNE9xUm5vSkNHWmVBa2ZJUzYzY1BVZkg2RWp4cDN6cWd5Q1hH?=
 =?utf-8?B?Y09qL2l4ZG4zOHRYcVplWGNwRkgyYzgyUGswTGJaMEo2TWwxbVZyRFJVanhF?=
 =?utf-8?B?Q09YRHNObWw3YjhJSlllYlJVZjd4OUpqV3plZlMyNWVKWDBuVlVmTkYyYWNl?=
 =?utf-8?B?MzNMM1ZaNXBpTjRpN3hkZDdDVmw0bzdCRGgrU2NSR09ORFVrWnNMYUxvZFMy?=
 =?utf-8?B?UDRWWlZjZ3NPVDNiYWdtR25Jamg0M0xCMFVjd1BMOGhKN3RsRW9NZkVta0po?=
 =?utf-8?B?bmpjZW5CSkM0RTAwVXFlUEs4d1RoSE5ENUE4UUtPTE9KUGZmTlVBVFh6N3RV?=
 =?utf-8?B?QmgzdFpXbDdYTFJPOWVhQnVZNHBCOXQwZks4YmRvTVMxRVUwY3Y1dFd0VExN?=
 =?utf-8?B?WU1IRDJsUjIvclVXdEV1VnRWbWUranc0eWxTK1crRy9uZ1dPeE4xTU5wT2lr?=
 =?utf-8?B?T2ZYRmJtZzhLNHJEQTNFWVVCYm43MVVLY2NIV3FjZC9Lb2xReG5jVUV3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDNHREI3cEhtL0ZoWjgwVk9Da0Z6dDZBYnpldXNSdW1DdUJDRk1nZFJGUkg1?=
 =?utf-8?B?dXh0SjJqYmVLWkJRVkJIeStpOVJ0TFZsczViRlk2UlUyaWNlVEZkVFVKY01t?=
 =?utf-8?B?anJSS0F0NlgvSGg5V0dpc2NSUmVrNWtlMVRnU0V2bHFnd0Vmbkdla1ZmNnh6?=
 =?utf-8?B?V1hUN1RlTk1WTlpURFVYamJINnJnOWZYQ3hweC95VUR1eGlaUkcwemZoWjJz?=
 =?utf-8?B?OUR5T0pldkVnQlRCanZIR1lIbWFuSzdHUU5adzc5SHVBQWYwVTVIb1F4OXpF?=
 =?utf-8?B?ZGJpUzN1MzhtQnl6WXE0SU9zaEE2NEZwNHVqUWh6RlhvOUpuT3RMbmRkNTZw?=
 =?utf-8?B?dHRHS0dHZ3JjVUhHaldNaWVIcjBNR0VCUXJhYVVFK3lEb1JyVzNCN3NPaTdV?=
 =?utf-8?B?Zy81YU14bkZHSEpZaGtweExUdzZtamxBbVFZNTNBdGZ1ZjJ5OElZRU1udUZu?=
 =?utf-8?B?bDl5S1o4TDk5ZDFCODBtYzhNMEVzWnkyVStXYXc4QU1zREtzeG5yM3FCQmNp?=
 =?utf-8?B?dGk0ODFlcGtwenowdXY1L2JNY0NzRGxaTHpXbXg1c3k4MDZFWXlGUkNxVHFV?=
 =?utf-8?B?RzFTRjlaUkc1dUF0SUkvMENmWXJvQW0zZFlKK1NnZC8yazUrT2RGMW9EYTE3?=
 =?utf-8?B?alJ2N0k3M1lucC84YmJPOTFNMUR1Nit3TnN4NS81YlZ1Ky9UQm5wWG4zdmd0?=
 =?utf-8?B?NEtuaERpTmptVWtmTDdzY3ZzQ25hL1Z2Q3pVQ0doc0FvMjJLVWd3dUpVUm0y?=
 =?utf-8?B?clBzL0pLRnBpQXJMQW5MeDBEUFZ2RERCRUJlRmhWbERMOCt1U2N5bHpwS1Y3?=
 =?utf-8?B?V1N5ZnVKdktTb3NSbk9Da2ptRi9SZ0NBV3RTTlR3RHVjeEFCQkk2SjBLSDIz?=
 =?utf-8?B?SkRmZnZYZjlEdytoZzV1L1ZvWC96Z3ZBVURHK1FrZkZRdGxjT2wyQUNkaHdF?=
 =?utf-8?B?VnpEWFkvdWpDTTY1UGtkeTAxbmhHZTJZTjhRVXpGamJmZ3NXL2RoL1pEYTB6?=
 =?utf-8?B?bUVvTVhzNjdyVzBPdlIwWEdFdjYvdUlhSjVFS0kwQjhNQk8xQUxMZWc0VGgx?=
 =?utf-8?B?elluakNuMXJ2RDRCR3lxaHpBZlptZ2ltR2N0T3F4UENDYS9KQkZlR1ZQSC85?=
 =?utf-8?B?NGdUZHFyMTdpcEF5L1U5YUpkYnVKeXo3STQyNGhOOWlWNEYxK3NHZVBVaVl6?=
 =?utf-8?B?WHBzQThwYmYwZGwyQkw2QjlCNjl0bFhuclJKZXNiTEpsYlNLZm9CbjRJeVds?=
 =?utf-8?B?NFlnQy9tdkJtaXI1RVo5cmo4UXBFeFZoR0Z2RU1OaW4ydXA1VWRQdjRoUkZY?=
 =?utf-8?B?S3Y3aE1LTkFMMm9neFBNeHVWWTNsdHJRQUR0YVB6V0NqODhvZHBuT2FaNEY4?=
 =?utf-8?B?UzQ2bjFzUmZYZTVwVFp2RmNwTk5hTXI2K1VucVlBV1ZjY25xeFVQWWhFVFp3?=
 =?utf-8?B?NDJJQXNpWS85NEZ4TXA2SldXdWpYYzk5V1hLL05aWDIweENjMlJSLy9mdm5K?=
 =?utf-8?B?TGl6MXg5eVRVeENsZ1VHZVhYZHpqdGNqdXhSS2dkVG5ibEN2aHNkU1BVZDZ5?=
 =?utf-8?B?RFB6ZW5xQmxGbm9VMzloZGFhNkdCeEVIWnVkNXB0NE9xeDNnbHlPZGhKVmNw?=
 =?utf-8?B?OUUzMUNUQTNucHpzekdLMHRuSDh5YVJKNzVUSnpSYzJMYlVyZmhpbCtaaVEw?=
 =?utf-8?B?ZVBqTUx4T2NyKzdLemtGdXJBd2UzZUhTaloreVkwblZGclVZM0pORWM4aXV6?=
 =?utf-8?B?Q082eHY4NUNlT0RINUo5eHF4YTFDNGNSVC9sTnRUV2x2Q1ZoSHlOaHNkSDVw?=
 =?utf-8?B?ajJ2bU0xK2EvdmRuR1oyZUNUNlBnSTgyVTd3RmpONDRac21kM1JlcGgwRkdt?=
 =?utf-8?B?cEd3dzh3ckVhc090NG9tUS9sNllKMk1BWXFKQk9wL3l2cFVjSHRHQlNuaVIw?=
 =?utf-8?B?TllPNnVXbG5FeGNLQ1BERVdWaENSV1Y0OFVRUlFWa3pZckYzUjU0cEhJejZK?=
 =?utf-8?B?M0ZwRHNEdTZuZVprcW9wMC9OVTdra21ndEQ3TUx5dFVPZWF3dVRJaGxUT3pK?=
 =?utf-8?B?M05lcDJ1RGM5SUZTOWk2Q1NXaWp5b09HSStObzNjck5UUytUSUZtN093Ukpj?=
 =?utf-8?B?czNDempBRjhBY1E5RFRsdTZCMW82ZENxM0Y1bHFlSUtqL1ppQW5BVmVCR0Yx?=
 =?utf-8?B?SEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8314F02BA4E6744DA9087497B4FCA655@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bab6c5-7191-4488-0494-08dc839d858e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 07:19:35.2952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+iczgZoi7esOrqivCWL5IkaVmAF5GrWKdFRUEUV7w19Na5g9LEL378OMOcNTWIkizV7Fr2tNeVnGjMsFkS8cQPVTKtbP0RlzwRqxyWuX24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7188

T24gVGh1LCAyMDI0LTA1LTMwIGF0IDE3OjU1ICswMTAwLCBSdXNzZWxsIEtpbmcgKE9yYWNsZSkg
d3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2Vu
ZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgT24gVGh1LCBNYXkgMzAsIDIwMjQgYXQgMDQ6MjU6NTZQ
TSArMDAwMCwgU2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKSB3cm90ZToNCj4gPiBPbiBUaHUsIDIw
MjQtMDUtMzAgYXQgMTE6MzUgKzAxMDAsIFJ1c3NlbGwgS2luZyAoT3JhY2xlKSB3cm90ZToNCj4g
PiA+ICAgDQo+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cw0KPiB1bnRpbA0KPiA+ID4geW91IGhhdmUgdmVyaWZpZWQgdGhl
IHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiA+ICBPbiBUaHUsIE1heSAzMCwgMjAyNCBhdCAx
MTo0ODo0NEFNICswODAwLCBTa3kgSHVhbmcgd3JvdGU6DQo+ID4gPiA+ICtzdGF0aWMgaW50IG10
Nzk4eF8ycDVnZV9waHlfY29uZmlnX2FuZWcoc3RydWN0IHBoeV9kZXZpY2UNCj4gKnBoeWRldikN
Cj4gPiA+ID4gK3sNCj4gPiA+ID4gK2Jvb2wgY2hhbmdlZCA9IGZhbHNlOw0KPiA+ID4gPiArdTMy
IGFkdjsNCj4gPiA+ID4gK2ludCByZXQ7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKy8qIEluIGZhY3Qs
IGlmIHdlIGRpc2FibGUgYXV0b25lZywgd2UgY2FuJ3QgbGluayB1cCBjb3JyZWN0bHk6DQo+ID4g
PiA+ICsgKiAgMi41Ry8xRzogTmVlZCBBTiB0byBleGNoYW5nZSBtYXN0ZXIvc2xhdmUgaW5mb3Jt
YXRpb24uDQo+ID4gPiA+ICsgKiAgMTAwTTogV2l0aG91dCBBTiwgbGluayBzdGFydHMgYXQgaGFs
ZiBkdXBsZXgoQWNjb3JkaW5nIHRvDQo+IElFRUUNCj4gPiA+IDgwMi4zLTIwMTgpLA0KPiA+ID4g
PiArICogICAgICAgIHdoaWNoIHRoaXMgcGh5IGRvZXNuJ3Qgc3VwcG9ydC4NCj4gPiA+ID4gKyAq
ICAgMTBNOiBEZXByZWNhdGVkIGluIHRoaXMgZXRoZXJuZXQgcGh5Lg0KPiA+ID4gPiArICovDQo+
ID4gPiA+ICtpZiAocGh5ZGV2LT5hdXRvbmVnID09IEFVVE9ORUdfRElTQUJMRSkNCj4gPiA+ID4g
K3JldHVybiAtRU9QTk9UU1VQUDsNCj4gPiA+IA0KPiA+ID4gV2UgaGF2ZSBhbm90aGVyIGRyaXZl
ciAoc3RtbWFjKSB3aGVyZSBhIHBsYXRmb3JtIGRyaXZlciBpcw0KPiB3YW50aW5nIHRvDQo+ID4g
PiBwdXQgYSBoYWNrIGluIHRoZSBrc2V0dGluZ3Nfc2V0KCkgZXRodG9vbCBwYXRoIHRvIGVycm9y
IG91dCBvbg0KPiA+ID4gZGlzYWJsaW5nIEFOIGZvciAxRyBzcGVlZHMuIFRoaXMgc291bmRzIGxp
a2Ugc29tZXRoaW5nIHRoYXQgaXMNCj4gPiA+IGFwcGxpY2FibGUgdG8gbW9yZSB0aGFuIG9uZSBo
YXJkd2FyZSAoYW5kIEkndmUgYmVlbiB3b25kZXJpbmcNCj4gd2hldGhlcg0KPiA+ID4gaXQgaXMg
dW5pdmVyc2FsbHkgdHJ1ZSB0aGF0IDFHIGNvcHBlciBsaW5rcyBhbmQgZmFzdGVyIGFsbA0KPiBy
ZXF1aXJlDQo+ID4gPiBBTiB0byBmdW5jdGlvbi4pDQo+ID4gPiANCj4gPiA+IFRodXMsIEknbSB3
b25kZXJpbmcgd2hldGhlciB0aGlzIGlzIHNvbWV0aGluZyB0aGF0IHRoZSBjb3JlIGNvZGUNCj4g
PiA+IHNob3VsZA0KPiA+ID4gYmUgZG9pbmcuDQo+ID4gPiANCj4gPiBZZWFoLi5BcyBmYXIgYXMg
SSBrbm93LCAxRy8yLjVHLzVHLzEwRyBzcGVlZCByZXF1aXJlIEFOIHRvIGRlY2lkZQ0KPiA+IG1h
c3Rlci9zbGF2ZSByb2xlLiBBY3R1YWxseSBJIGNhbiB1c2UgZm9yY2UgbW9kZSBieSBjYWxsaW5n
DQo+ID4gZ2VucGh5X2M0NV9wbWFfc2V0X2ZvcmNlZCwgd2hpY2ggd2lsbCBzZXQgY29ycmVzcG9k
aW5nIEM0NQ0KPiByZWdpc3RlcnMuDQo+ID4gSG93ZXZlciwgYWZ0ZXIgdGhhdCwgdGhpcyAyLjVH
IFBIWSBjYW4ndCBzdGlsbCBsaW5rIHVwIHdpdGgNCj4gcGFydG5lcnMuDQo+ID4gDQo+ID4gSSds
bCBsZWF2ZSBFT1BOT1RTVVBQIGhlcmUgdGVtcG9yYXJpbHkuIEhvcGUgcGh5bGliIGNhbiBiZSBw
YXRjaGVkDQo+ID4gc29tZWRheS4NCj4gDQo+IFBsZWFzZSBuby4gInNvbWVkYXkiIHRlbmRzIHRv
IG5ldmVyIGhhcHBlbiwgYW5kIHlvdSdyZSBiYXNpY2FsbHkNCj4gdGhyb3dpbmcgdGhlIHByb2Js
ZW0gb3ZlciB0aGUgd2FsbCB0byBvdGhlciBwZW9wbGUgdG8gc29sdmUgd2hvDQo+IHRoZW4gaGF2
ZSB0byBzcG90IHlvdXIgaGFjayBhbmQgZXZlbnR1YWxseSByZW1vdmUgaXQuDQo+IA0KPiBXZSBu
ZWVkIHRoaXMgc29sdmVkIHByb3Blcmx5LCBub3QgYnkgcGVvcGxlIGhhY2tpbmcgZHJpdmVycy4g
VGhpcw0KPiBpcyBvcGVuIHNvdXJjZSwgeW91IGNhbiBwcm9wb3NlIGEgcGF0Y2ggdG8gcGh5bGli
IHRvIGZpeCB0aGlzIGZvcg0KPiBldmVyeW9uZS4NCj4gDQpJIGRvbid0IGludGVuZCB0byB0aHJv
dyAgcHJvYmxlbXMgdG8gb3RoZXIgcGVvcGxlLiBBbmQgYWN0dWFsbHkgdGhpcw0KaXNuJ3QgYSAi
cHJvYmxlbSIgY3VycmVudGx5KGF0IGxlYXN0IGluIHRoaXMgZHJpdmVyKS4gSU1ITywgZGlzYWJs
aW5nDQpBTiBpc24ndCBhIG5vcm1hbCBvcGVyYXRpb24gZm9yIGN1cnJlbnQgZXRoZXJuZXQgZW52
aXJvbm1lbnQuIEhvd2V2ZXIsDQpub3csIGV0aHRvb2wgc3VwcG9ydHMgdGhpcyBraW5kIG9mIGNv
bmZpZ3VyYXRpb24uIE1heWJlIHdlIHNob3VsZA0KcHJvaGliaXQgIkFOIGRpc2FibGUiIGNvbmZp
ZyBmb3IgY2VydGFpbiBzcGVlZD8gT3IgbWF5YmUgZm9yIGFsbA0Kc3BlZWQ/IFRoaXMgd2lsbCB0
YWtlIGxvdHMgb2YgdGltZSBmb3IgZGlzY3Vzc2lvbi4gTm8gbWF0dGVyIHdoYXQsDQp0aGVzZSBk
aXNjdXNzaW9ucyBoYXZlIGxpdHRsZSByZWxldmFuY2UgdG8gdGhpcyBkcml2ZXIuDQoNCkZvciB5
b3VyIHJlZmVyZW5jZSwgdGhlcmUncyB0aGUgc2FtZSBkZXNpZ24gaW4gZW44ODExaF9jb25maWdf
YW5lZygpIG9mDQpkcml2ZXJzL25ldC9waHkvYWlyX2VuODgxMWguYy4NCg0KPiA+ID4gPiArLyog
VGhpcyBwaHkgY2FuJ3QgaGFuZGxlIGNvbGxpc2lvbiwgYW5kIG5laXRoZXIgY2FuIChYRkkpTUFD
DQo+IGl0J3MNCj4gPiA+IGNvbm5lY3RlZCB0by4NCj4gPiA+ID4gKyAqIEFsdGhvdWdoIGl0IGNh
biBkbyBIRFggaGFuZHNoYWtlLCBpdCBkb2Vzbid0IHN1cHBvcnQNCj4gQ1NNQS9DRA0KPiA+ID4g
dGhhdCBIRFggcmVxdWlyZXMuDQo+ID4gPiA+ICsgKi8NCj4gPiA+IA0KPiA+ID4gV2hhdCB0aGUg
TUFDIGNhbiBhbmQgY2FuJ3QgZG8gcmVhbGx5IGhhcyBsaXR0bGUgYmVhcmluZyBvbiB3aGF0DQo+
IGxpbmsNCj4gPiA+IG1vZGVzIHRoZSBQSFkgZHJpdmVyIHNob3VsZCBiZSBwcm92aWRpbmcuIEl0
IGlzIHRoZQ0KPiByZXNwb25zaWJpbGl0eSBvZg0KPiA+ID4gdGhlIE1BQyBkcml2ZXIgdG8gYXBw
cm9wcmlhdGVseSBjaGFuZ2Ugd2hhdCBpcyBzdXBwb3J0ZWQgd2hlbg0KPiA+ID4gYXR0YWNoaW5n
DQo+ID4gPiB0byB0aGUgUEhZLiBJZiB1c2luZyBwaHlsaW5rLCB0aGlzIGlzIGRvbmUgYnkgcGh5
bGluayB2aWEgdGhlIE1BQw0KPiA+ID4gZHJpdmVyDQo+ID4gPiB0ZWxsaW5nIHBoeWxpbmsgd2hh
dCBpdCBpcyBjYXBhYmxlIG9mIHZpYSBtYWNfY2FwYWJpbGl0aWVzLg0KPiA+ID4gDQo+ID4gPiA+
ICtzdGF0aWMgaW50IG10Nzk4eF8ycDVnZV9waHlfZ2V0X3JhdGVfbWF0Y2hpbmcoc3RydWN0DQo+
IHBoeV9kZXZpY2UNCj4gPiA+ICpwaHlkZXYsDQo+ID4gPiA+ICsgICAgICBwaHlfaW50ZXJmYWNl
X3QgaWZhY2UpDQo+ID4gPiA+ICt7DQo+ID4gPiA+ICtpZiAoaWZhY2UgPT0gUEhZX0lOVEVSRkFD
RV9NT0RFX1hHTUlJKQ0KPiA+ID4gPiArcmV0dXJuIFJBVEVfTUFUQ0hfUEFVU0U7DQo+ID4gPiAN
Cj4gPiA+IFlvdSBtZW50aW9uIGFib3ZlIFhGSS4uLg0KPiA+ID4gDQo+ID4gPiBYRkkgaXMgMTBH
QkFTRS1SIHByb3RvY29sIHRvIFhGUCBtb2R1bGUgZWxlY3RyaWNhbCBzdGFuZGFyZHMuDQo+ID4g
PiBTRkkgaXMgMTBHQkFTRS1SIHByb3RvY29sIHRvIFNGUCsgbW9kdWxlIGVsZWN0cmljYWwgc3Rh
bmRhcmRzLg0KPiA+ID4gDQo+ID4gPiBwaHlfaW50ZXJmYWNlX3QgaXMgaW50ZXJlc3RlZCBpbiB0
aGUgcHJvdG9jb2wuIFNvLCBnaXZlbiB0aGF0IHlvdQ0KPiA+ID4gbWVudGlvbiBYRkksIHdoeSBk
b2Vzbid0IHRoaXMgdGVzdCBmb3INCj4gUEhZX0lOVEVSRkFDRV9NT0RFXzEwR0JBU0VSPw0KPiA+
ID4gDQo+ID4gV2UgaGF2ZSAyIFhGSS1NQUMgb24gbXQ3OTg4IHBsYXRmb3JtLiBPbmUgaXMgY29u
bmVjdGVkIHRvIGludGVybmFsDQo+ID4gMi41R3BoeShTb0MgYnVpbHQtaW4pLCBhcyB3ZSBkaXNj
dXNzZWQgaGVyZSAoV2UgZG9uJ3QgdGVzdCB0aGlzIHBoeQ0KPiBmb3INCj4gPiAxMEcgc3BlZWQu
KSBBbm90aGVyIG9uZSBpcyBjb25uZWN0ZWQgdG8gZXh0ZXJuYWwgMTBHIHBoeS4NCj4gDQo+IEkg
Y2FuJ3QgcGFyc2UgeW91ciByZXNwb25zZSBpbiBhIG1lYW5pbmdmdWwgd2F5LCB0byBtZSBpdCBk
b2Vzbid0DQo+IGFkZHJlc3MgbXkgcG9pbnQuDQo+IA0KSSBndWVzcyBJIGdvdCB5b3VyIHBvaW50
Lg0KT24gbXQ3OTg4IA0KMXN0IFhGSS1NQUMgKFhHTUFDMik6IEZvciBidWlsdC1pbiAyLjVHcGh5
IG9yIGV4dGVybmFsIDEwR3BoeQ0KMm5kIFhGSS1NQUMgKFhHTUFDMyk6IE9ubHkgZm9yIGV4dGVy
bmFsIDEwR3BoeQ0KDQpCYXNpY2FsbHksIGlmIHdlIHVzZSB0aGlzIGRyaXZlciBmb3IgYnVpbHQt
aW4gMi41R3BoeS4gV2UnbGwgb25seSBwYXNzDQpwaHktbW9kZSA9ICJ4Z21paSIgb3IgcGh5LW1v
ZGUgPSAiaW50ZXJuYWwiIGluIGR0cywgaS5lLA0KUEhZX0lOVEVSRkFDRV9NT0RFX1hHTUlJIG9y
IFBIWV9JTlRFUkZBQ0VfTU9ERV9JTlRFUk5BTC4NCkFsc28sIHdlIHBhc3MgcGh5LW1vZGUgPSAi
dXN4Z21paSIgKFBIWV9JTlRFUkZBQ0VfTU9ERV8xMEdCQVNFUikgaW4gZHRzDQpvbmNlIHdlIHVz
ZSBleHRlcm5hbCAxMEdwaHkgd2l0aCBYR01BQzIuDQoNClNvIHdlIGRvbid0IHRlc3QgUEhZX0lO
VEVSRkFDRV9NT0RFXzEwR0JBU0VSIG9yDQpQSFlfSU5URVJGQUNFX01PREVfMTBHS1IgaW4gZHJp
dmVyJ3MgcmF0ZV9tYXRjaGluZygpLg0KDQpCdXQgSSB0aGluayBJIHNob3VsZCBjaGFuZ2UgaXQg
dGhpcyB3YXk6IA0KDQppZiAoaWZhY2UgPT0gUEhZX0lOVEVSRkFDRV9NT0RFX1hHTUlJIHx8DQog
ICAgaWZhY2UgPT0gUEhZX0lOVEVSRkFDRV9NT0RFX0lOVEVSTkFMKQ0KCQlyZXR1cm4gUkFURV9N
QVRDSF9QQVVTRTsNCnJldHVybiBSQVRFX01BVENIX05PTkU7DQoNCj4gPiANCj4gPiA+ID4gK3N0
YXRpYyBpbnQgbXQ3OTh4XzJwNWdlX3BoeV9wcm9iZShzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2
KQ0KPiA+ID4gPiArew0KPiA+ID4gPiArc3RydWN0IG10a19pMnA1Z2VfcGh5X3ByaXYgKnByaXY7
DQo+ID4gPiA+ICsNCj4gPiA+ID4gK3ByaXYgPSBkZXZtX2t6YWxsb2MoJnBoeWRldi0+bWRpby5k
ZXYsDQo+ID4gPiA+ICsgICAgc2l6ZW9mKHN0cnVjdCBtdGtfaTJwNWdlX3BoeV9wcml2KSwgR0ZQ
X0tFUk5FTCk7DQo+ID4gPiA+ICtpZiAoIXByaXYpDQo+ID4gPiA+ICtyZXR1cm4gLUVOT01FTTsN
Cj4gPiA+ID4gKw0KPiA+ID4gPiArc3dpdGNoIChwaHlkZXYtPmRydi0+cGh5X2lkKSB7DQo+ID4g
PiA+ICtjYXNlIE1US18yUDVHUEhZX0lEX01UNzk4ODoNCj4gPiA+ID4gKy8qIFRoZSBvcmlnaW5h
bCBoYXJkd2FyZSBvbmx5IHNldHMgTURJT19ERVZTX1BNQVBNRCAqLw0KPiA+ID4gPiArcGh5ZGV2
LT5jNDVfaWRzLm1tZHNfcHJlc2VudCB8PSAoTURJT19ERVZTX1BDUyB8IE1ESU9fREVWU19BTg0K
PiB8DQo+ID4gPiA+ICsgTURJT19ERVZTX1ZFTkQxIHwgTURJT19ERVZTX1ZFTkQyKTsNCj4gPiA+
IA0KPiA+ID4gTm8gbmVlZCBmb3IgcGFyZW5zIG9uIHRoZSBSSFMuIFRoZSBSSFMgaXMgYW4gZXhw
cmVzc2lvbiBpbiBpdHMNCj4gb3duDQo+ID4gPiByaWdodCwgYW5kIHRoZXJlJ3Mgbm8gcG9pbnQg
aW4gcHV0dGluZyBwYXJlbnMgYXJvdW5kIHRoZQ0KPiBleHByZXNzaW9uDQo+ID4gPiB0byB0dXJu
IGl0IGludG8gYW5vdGhlciBleHByZXNzaW9uIQ0KPiA+ID4gDQo+ID4gPiAtLSANCj4gPiA+IFJN
SydzIFBhdGNoIHN5c3RlbTogDQo+IGh0dHBzOi8vd3d3LmFybWxpbnV4Lm9yZy51ay9kZXZlbG9w
ZXIvcGF0Y2hlcy8NCj4gPiA+IEZUVFAgaXMgaGVyZSEgODBNYnBzIGRvd24gMTBNYnBzIHVwLiBE
ZWNlbnQgY29ubmVjdGl2aXR5IGF0IGxhc3QhDQo+ID4gDQo+ID4gRG8geW91IG1lYW4gdGhlc2Ug
dHdvIGxpbmU/DQo+ID4gK3BoeWRldi0+YzQ1X2lkcy5tbWRzX3ByZXNlbnQgfD0gKE1ESU9fREVW
U19QQ1MgfCBNRElPX0RFVlNfQU4gfA0KPiA+ICsgTURJT19ERVZTX1ZFTkQxIHwgTURJT19ERVZT
X1ZFTkQyKTsNCj4gPiANCj4gPiBXaGF0IGRvIHlvdSBtZWFuIGJ5ICJSSFMgaXMgYW4gZXhwcmVz
c2lvbiBpbiBpdHMgb3duIHJpZ2h0Ij8NCj4gPiBJIHB1dCBwYXJlbnMgaGVyZSB0byBlbmhhbmNl
IHJlYWRhYmlsaXR5IHNvIHdlIGRvbid0IG5lZWQgY2hlY2sNCj4gPiBvcGVyYXRvciBwcmVjZWRl
bmNlIGFnYWluLg0KPiANCj4gfD0gb25lIG9mIHRoZSBhc3NpZ25tZW50IG9wZXJhdG9ycywgYWxs
IG9mIHdoaWNoIGhhdmUgb25lIG9mIHRoZQ0KPiBsb3dlc3QgcHJlY2VkZW5jZS4gT25seSB0aGUg
LCBvcGVyYXRvciBoYXMgYSBsb3dlciBwcmVjZWRlbmNlLg0KPiBUaGVyZWZvcmUsIGV2ZXJ5dGhp
bmcgZXhjZXB0ICwgaGFzIGhpZ2hlciBwcmVjZWRlbmNlLiBUaGVyZWZvcmUsDQo+IHRoZSBwYXJl
bnMgb24gdGhlIHJpZ2h0IGhhbmQgc2lkZSBvZiB8PSBtYWtlIG5vIGRpZmZlcmVuY2UuDQo+IA0K
PiAtLSANCj4gUk1LJ3MgUGF0Y2ggc3lzdGVtOiBodHRwczovL3d3dy5hcm1saW51eC5vcmcudWsv
ZGV2ZWxvcGVyL3BhdGNoZXMvDQo+IEZUVFAgaXMgaGVyZSEgODBNYnBzIGRvd24gMTBNYnBzIHVw
LiBEZWNlbnQgY29ubmVjdGl2aXR5IGF0IGxhc3QhDQoNCkknbGwgZml4IHRoaXMgaW4gdjYuDQoN
ClNreQ0K

