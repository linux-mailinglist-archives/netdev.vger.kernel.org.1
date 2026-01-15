Return-Path: <netdev+bounces-250286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A0DD27D50
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 19:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 28EED3053E94
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 18:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF403D3D01;
	Thu, 15 Jan 2026 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="QGWmOvYS"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F203C199C;
	Thu, 15 Jan 2026 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=35.162.73.231
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499513; cv=fail; b=R8tPng2/3Qm4Vbsydod4jXXJn79oWE4+cVdDKtayu8BxYoez3/iehVsmoO1opqCqLoq2clgwMKW0BPpe0P15TC78pbsbKFwzpYfJGmm/V21msaCQgNyrbaD7JJwkIIWqGkbN8I0axolqAaY86ZprWwxYWUkGpa6ghPFpuUg+I48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499513; c=relaxed/simple;
	bh=fKdFMiOSI4alZVmQBO4mpQdM42VZqjE2Z7vlE196NOY=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JaulIp1c8FRGtcuNa5iU3TxsYs5/Dq5hZY6ucZvhiqJ+UiSPSztb5bPHUNPUHZLGocVll4GNiBBS0eec4go0cCGubn0MZT6uts+kSmq71vVSC0T0eEyhiBTq54NshD3MDIXcbyGaFBxNFuDlxS7e5XSmAXbKrj0eFcD5oA91sNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=QGWmOvYS; arc=fail smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1768499512; x=1800035512;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=fKdFMiOSI4alZVmQBO4mpQdM42VZqjE2Z7vlE196NOY=;
  b=QGWmOvYSeRsLXvuv+Xb7vixWs86ph8pFKQau17+g16oMzRzgM2YZ4R0b
   bltJeatTyIx6Z5Squ+QeolahjB1V18+Nrw3hBCcOdClsGBlzy3+kZKqZt
   QIR9Y8zNuPXJXGiKwEbrYXOAi61GEWUC0go665xk6ryMwwoXLzUWrVzZo
   KXc1f754S1qKW4ItgxmGt9MEOjKHT9e6/UMpSTbtwSuFKcVumQYNsx61B
   TCtgzyO8SzLHtl3XN9SqsE3kxaJxXvHtJNbTQUrV/AU6AJj21MXbpm25b
   HDy5j2krzyfqkmcIkvhd9+c7R889RQMM1MYQAYkgvgHueGX5mBmR29hb+
   Q==;
X-CSE-ConnectionGUID: PzRjbUKnRTK+4+DpdTPi+Q==
X-CSE-MsgGUID: 1PJe4b0gRROcuoUtm3jzWQ==
X-IronPort-AV: E=Sophos;i="6.21,228,1763424000"; 
   d="scan'208";a="10736755"
Subject: RE: [PATCH net-next 4/9] net: ena: convert to use .get_rx_ring_count
Thread-Topic: [PATCH net-next 4/9] net: ena: convert to use .get_rx_ring_count
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 17:51:49 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:10397]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.220:2525] with esmtp (Farcaster)
 id 2d426bee-9da0-4c3f-9810-9f03c81248d4; Thu, 15 Jan 2026 17:51:49 +0000 (UTC)
X-Farcaster-Flow-ID: 2d426bee-9da0-4c3f-9810-9f03c81248d4
Received: from EX19EXOUWA001.ant.amazon.com (10.250.64.209) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Thu, 15 Jan 2026 17:51:48 +0000
Received: from CO1PR08CU001.outbound.protection.outlook.com (10.250.64.206) by
 EX19EXOUWA001.ant.amazon.com (10.250.64.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35
 via Frontend Transport; Thu, 15 Jan 2026 17:51:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUU7jxw2NDS+EnuuVR9nby3VDw+tAe4dJ4aMFJn9u1FKaLCAOPy03emhw9qyOZtg6jfxiqu/gwmmtlW5bDPHCdjGhNg51E0d6tPNeGPRWhvY2xzuKQZE6oOe9w/f5wwWBc8idS5fw8ci7Xa0GQevO/Em2bokYfHr7lwxCuvjM2CuYP5QLeF0hEGz0GfrQs46WkrclqMGemfURFaRPCiVaZdkoFGVMWwed7tH7wnR3r69GOJxrgW4rXEzb5cUYUwJ+oNiJxKsoxDm5gqTMfKeukbnxsE/PA++P70USzXlpiCbTFUjBfpBgt8/2rALTPj8UDWnzWdW8pHDrPZV9zNcHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKdFMiOSI4alZVmQBO4mpQdM42VZqjE2Z7vlE196NOY=;
 b=dXTwEki/U3EHiUr4jnoLP7YWNqQ3LWoXmPEVkR8rlHZoEt0od2NvZokqtiD0ATI2bUibpaqBM7HFk9OcLwHw+ohrgUk5NRnljDWolaB4LS3Xe/9p9nPDofPJvR3+NbRovjrlF/EpxupmZ77oAzAPHEkDvTgR7v3Y08s7mI0ysLNgyMz+xx36AoSbxjWvVj3QTa1YnoPwiAdGWAC/m3n0Stz0qjP2BFqCI4cSUZpJjwyyF43aUpaov4/WSor+B/Bzpt4EcIb9nA7fNyKOwTIPQKEDia91YPxV2DJ1s8qI36uAR9yNOaKZmZf/v3yYHo72xW8funiWawSvKpcKZRzrVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from SA1PR18MB4664.namprd18.prod.outlook.com (2603:10b6:806:1d7::5)
 by PH0PR18MB4688.namprd18.prod.outlook.com (2603:10b6:510:cb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 17:51:45 +0000
Received: from SA1PR18MB4664.namprd18.prod.outlook.com
 ([fe80::972c:f0e:7126:9112]) by SA1PR18MB4664.namprd18.prod.outlook.com
 ([fe80::972c:f0e:7126:9112%3]) with mapi id 15.20.9520.003; Thu, 15 Jan 2026
 17:51:45 +0000
From: "Kiyanovski, Arthur" <akiyano@amazon.com>
To: Breno Leitao <leitao@debian.org>, Ajit Khaparde
	<ajit.khaparde@broadcom.com>, Sriharsha Basavapatna
	<sriharsha.basavapatna@broadcom.com>, Somnath Kotur
	<somnath.kotur@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Felix Fietkau
	<nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Allen,
 Neil" <shayagr@amazon.com>, "Arinzon, David" <darinzon@amazon.com>, "Bshara,
 Saeed" <saeedb@amazon.com>, Bryan Whitehead <bryan.whitehead@microchip.com>,
	"UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, "Shyam Sundar
 S K" <Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>,
	"Potnuri Bharat Teja" <bharat@chelsio.com>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Thread-Index: AQHchizJUNimdvOFqUmplFx2sp6IbLVTgWjw
Date: Thu, 15 Jan 2026 17:51:34 +0000
Deferred-Delivery: Thu, 15 Jan 2026 17:51:31 +0000
Message-ID: <SA1PR18MB4664CC040BB349C83990C1FBD98CA@SA1PR18MB4664.namprd18.prod.outlook.com>
References: <20260115-grxring_big_v2-v1-0-b3e1b58bced5@debian.org>
 <20260115-grxring_big_v2-v1-4-b3e1b58bced5@debian.org>
In-Reply-To: <20260115-grxring_big_v2-v1-4-b3e1b58bced5@debian.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4664:EE_|PH0PR18MB4688:EE_
x-ms-office365-filtering-correlation-id: 45bdab36-5b9c-4cf1-cb6b-08de545ebff1
x-ld-processed: 5280104a-472d-4538-9ccf-1e1d0efe8b1b,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WEhhOVI1ZkVNSHYzN3JQQ2FaSFhDRDU2MytHWXhsMjQydlc1d0tCRmVUaVZu?=
 =?utf-8?B?dW5pTm9NcktnU1I4NnAzV29vNEJRY1gxSjFyUDRlNGhocEZlRk9BWXlvNFU2?=
 =?utf-8?B?NnErWFRvWGF2R2NVeTNSZ21qYmQ3YUpSSGZiNkVKSzF6VEFUdkJIVGJyaGo2?=
 =?utf-8?B?YkhlNmxWakRyVFFCdlg5UmxGUWM1QnFhbmllWm4zcFZOT3ozcUJhNGQ1VWIy?=
 =?utf-8?B?OXI0MkJ6RnkyYUJ4NXJYNzFLdVBDRW5Nd1NMLzVGcVlQaVA0MEFLMURvWXZr?=
 =?utf-8?B?Mmo1OVZwNzNHeitOM2lSUm51bCtKRUo0SWhWRUVjYzNXUjdaSkQ1d2RVT1Er?=
 =?utf-8?B?SUtxSE1mb2V2UmlvakJZamJwNzBRVEQ5Z0pNOFNxL1dZZGE0djU3SHpRK2pw?=
 =?utf-8?B?dVcxbURHS1QrajN4S1RKUm4rd254MDQrWGdlQnhMbGI5SWwrNkJiQzR6TFoy?=
 =?utf-8?B?aWpzdXc4YmFsUjN5elhIZ2RwUFNoRHZJMEdpc2g1KzNtOTYzOTIwakNKbXVR?=
 =?utf-8?B?OFVBSkpVSWgyN1AvN1RSOCt6emF2VmFIUW5TUlRYY0lkMjlsVzV4a1dtMHUy?=
 =?utf-8?B?K00yR3V5NFBLeTBaeW9XTllsRnQzRTRUR3hLSy9oSXBFM3J5OTRrWXVTWlJT?=
 =?utf-8?B?K1h5bmpnb05aTnNLbW9BTXJoWVNnWkFYcmlLMi9vKy9OTXpIVG5KUlZYaktq?=
 =?utf-8?B?M0Z0dWZhZVZ5MSsyaFVybnRFYkowaTdZQmdaWkxnTTBQK3ZaOE1PcUJONHZ3?=
 =?utf-8?B?d0dLL0NYek9oUnE0NnBxbjRnQzh1UXZydXZ0TksrbjlYNkZEcEdvWDFmbWtC?=
 =?utf-8?B?c09iQVUvM1h2aHpuVzYvbXRSS2luSWpkdW1HSmo5a0V5OXVmLzlLQUMvVlRv?=
 =?utf-8?B?aWRPQ09mTTFpOWdkcmR2d1ZwcTAvTkVnVWZLM05xdTJjNmhDaUpXNWZGNG9B?=
 =?utf-8?B?d041bUZHY2Q5cmRqK1JXRUFqeE5FMVhIaURsMUkzbkM3ZWF3MHlBb0syelZm?=
 =?utf-8?B?NWFKQ3FkYVRVUENYYlZYNmR3ZVZCVDJMZFYvNWM0SlhWNlFvNElkT0lHMWh6?=
 =?utf-8?B?MGs3bi9CcEN1aUE0THVnaGVCSms2V0pBeXRIYS84QlBwd3J5YVhXRUpRWlVw?=
 =?utf-8?B?VjJLWEpXcHc5QlYxOFlPSG4wOGZQMXhPamdwRDE5SHNOa2hqUGRBbWVhUm4y?=
 =?utf-8?B?ZDh3bzQxcmJGUXk1WWx1dVlzSGd5WnFNTnEwZS9Za2lxSHRId1ZEQmJSbjg3?=
 =?utf-8?B?OTkzdDFjaXNlSnBCT08zNm95cmFCQUE4a2dqWnBTTTlIYURoWWNtd0REZDNN?=
 =?utf-8?B?TUhaL3RaVkJhZENPTXhDN0d0UFpIcm1qR0luc2JJZFJ6cmpkeGROUWUrdnRS?=
 =?utf-8?B?MktCekkxQTRrc1R2ZmptTjlET1o3WHY2dnVGT2s3WW1kRGtwVUh5L2JCdDcv?=
 =?utf-8?B?OVlaMDBhNGFwaDgxV3BndzR1Z3pWMjdWT2RSUmJDbGhtOWNTYnBiSTI5bm9G?=
 =?utf-8?B?VVZQVzd5NFp2Z3RmbGI4ZWVTem1MbDVwWmgxZHpuTU5wSWowNmtSZHlLa3Iv?=
 =?utf-8?B?UUZ1S281Ly9YV1JrcjV0TE0yV3FGTzFLQVVZU2pCOGFmQzVzTmY1Z1NDQzRh?=
 =?utf-8?B?QlAyc0ZFSWYwWGpRZ1VSUm10TkszbGVwRk1pTUdxY1FoUDJwTUtuZGRUS0pi?=
 =?utf-8?B?TVNxRkkrQVZISHh3UDZ6Tmp1dVdKcDNCV1BxME9jRys1UlpWYjBDWVBlT1NR?=
 =?utf-8?B?Q1RUZ0QwazV6WjMwb3RwRFJ5cWNoaHovQWJuN1A2SEJFZEJrLzlCMTh5U3k1?=
 =?utf-8?B?V2ljUmhrRExMNGpPK1B1NHlEYjRTdFRiaGJtd1B6SDlDRzFoOUdiT3Rpd0Vu?=
 =?utf-8?B?SnhZajMwMDFGck9yTDd4dVNMUU4xRHVvcGFzWFpJeVFKdkl1eGdCNTJzOEpt?=
 =?utf-8?B?YllYVmVubzM4MnZQNTRaSUtDVmNFUE5OK2lTa2ZwTVlHM0VFN3UvUDBzSWxr?=
 =?utf-8?B?bUFmVzRFNER4Zmp3UEV2OTZYQWdnR3Iwc0hjcWZCL3pIUm9PUU5oQmRDVk1r?=
 =?utf-8?B?SmZPU2F1UTNqWU02UlgzWnNGUmZEbENEYkt2b0ZDYW9DVkxMMlBHR21Pb1lv?=
 =?utf-8?B?OUpvY0dNemMwVWlBOHFXUWRXSkpQajhkeVBIU0ZjOW1OU3plVVFzLzMzTVk0?=
 =?utf-8?Q?PsSfZ71bS9Xsgc6I6H+7/dxSl7mj9XXmVVGSIvsrGFsc?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4664.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTZHZjBPUitUNUozMzBxa2VOdHV0U0hIZ2lJMUNCOE5UVGJHSGlZT0JKTGRX?=
 =?utf-8?B?VjR6czRIOEQxV0JVYkhydm16akVRc1FKaEU3emlucFVZWUVhRFl1bVFNSmRL?=
 =?utf-8?B?TGRBS0VYT3FLUTdubzYzNDUzOUhKVHVJRnFac0FidmFTNTQzSzJxaUE1R3BZ?=
 =?utf-8?B?K0ZrWDJ0UE5yemh6Z1lla24vV1RQNzA5alYwVW1ZSnlVR3FjdUMxK1g2MVNh?=
 =?utf-8?B?NWRQZk5zb25yMEtsTzdGRUhvMFBxL2dwbTBkL2Q5Q045YS9zMndvVXNlQVQ4?=
 =?utf-8?B?MnJRSTNOUkZZWUdoUlRNWVJPV0ZoQWRpUmlVaU1wM2xCWmxvNXlOQkwxVXEr?=
 =?utf-8?B?WUtzUkZteGIzeTR4NE9uVDNDaXE5aHFBYlZYWFpPV0tPWVMzMWw5U2ZQbVVI?=
 =?utf-8?B?QytiRTZnNFNpajJUQSs3SXZiNjVZQllZd3BlZmZ5L3QySytGSzA3VWI2SzJu?=
 =?utf-8?B?MWhBdHF5dVBsZHNjamoySlE4V1Rlb0hRWTZDZThYNXNRclpjN3pjTlBhTThr?=
 =?utf-8?B?ZEgwN1pLbm5CNWNVMjRNSkJNb0IrZkhXRTNXaU1pa3hYS1R6YWYwaFdZL2VD?=
 =?utf-8?B?elBXcE5Bb01WdXkwOVJWNFBDVWNxYUVYQ3BaaEZCU25pbkRHYmVIeUtHQzZ4?=
 =?utf-8?B?QkJDR1NVcURFRFhmT3dXL0dja2IzWU84UkJTcnIyZHZiWUhtS1ZJSlZaY1B0?=
 =?utf-8?B?a3Q3SXR4SUlFUDJXcGVuVnNMdTgrM044aFFiYWQ5RzZOTTYrSnp0MEZ3WE5R?=
 =?utf-8?B?aXVYcExHRk9FcFdiczA2NUc0L2NabXkyQXdpNXh4Qm5TUFRRbjZWMUhvOFlD?=
 =?utf-8?B?Y0Y4bk1GVzhjTlFrc3A3UFl4QTdhTUx4RGQ3UzdJUG5ncnNKN25EcUh6MXda?=
 =?utf-8?B?RWo2SU1pdUdJbGdpeFl0L0QzM1ZRaTc2MDc3RmcvTHA1b25XNFFGUlBSditT?=
 =?utf-8?B?NjBBeS9VMjkwYzJ2QXBaVENHYXVNU3YxM0ZZbE9lbVdJcFNuUzVjRnFTbUcw?=
 =?utf-8?B?VDB2WVVWakMvVjNrckVIQitTUTVKb3Q2VVVZQzRybWZ6cnR1YTlDUTArWUM2?=
 =?utf-8?B?Uis4N3U2SURtK2JvYjJUQjZwWlJDOUh5MExwTXhxT04wUVp2QUU0TVpUVENW?=
 =?utf-8?B?alcrdGljWVphdWNacHRqYWk4T1pTTW5TMVFYRTVSV2ZFdXJPMHNMeEg0bWFG?=
 =?utf-8?B?SFZHK25aLy9JU3V1MU1DdWlIaFpQVjFjeUJiZWMyQ3hySnhuOTRSeXNZZm9m?=
 =?utf-8?B?MzNERFhRV245c3ZjekxxQytzL05JMG53THErSFBQV3dYVXZyeE1HeDluN2w4?=
 =?utf-8?B?VHBJRHViVU1GaExmbVc4Yk52M1pTUUdoRURibHdiMjlCVVRKeFBXanoya2Rk?=
 =?utf-8?B?TVZsQVArQ2ZtWjFieVVmN1BKamIvdnk4aFlqZENSdzhTRHQ2R3JrWWtlZURU?=
 =?utf-8?B?V2I4c0hpQVVmclRCaklEOFhsZ3p3M0k2dWswLzU3Z1NyOGt4NVc4S0FOcTJw?=
 =?utf-8?B?clJzY0hVaFVjWkgwTVd6SmJvajdBaEVwdnZSWnBZMWJ1bGJuVVBuSUE3bmw5?=
 =?utf-8?B?S3h5Q2tUSUNWNHNTNHJKcXNRbnE0ZThxbjVJaVpTYVRCaGlqQVdKZXZrSnpZ?=
 =?utf-8?B?ZStEenBRSElMb0IyS25DWjFsQ2JJRHIzTnRKNUlMclRsT2xUYjBLOGlCRTdP?=
 =?utf-8?B?NGlibEwvRHNiQnQ4Z1JHaGIvTWFHZnRIZElyaXhvck5aYlpsdHFNMlFRUVc2?=
 =?utf-8?B?R3JiV2w1a2dINk5kcmpNS0xySlBsZ2poQ0kycTVWMWdISldVNlJzS0ZCS1Z5?=
 =?utf-8?B?SzBaYkdFYWhpK3I0OGkvRzE5RTZWK3VJVnRwcUtncC9NUW1qR29LdzdRM0Zu?=
 =?utf-8?B?MEpMbFJzZXg4dW8rRWtmY3JxOGlHMnR5bXlMV2hETm1FZUhQUktnSWU3WGxw?=
 =?utf-8?B?aEI2OWx3dEwwa3haaE9rdXVDNW01WlVkdi9vU0FoTENmcFNyTzc5Z2FibHN0?=
 =?utf-8?B?MFBYamhPMGhIZ1l4dVRvRVZCaDBxdzRIK250QVVReEtrWldkQnBhUWtwTzZR?=
 =?utf-8?B?K3dsTVFlbWhsQlhxYURNT0FObXBOR2xxaVJmMFhWVEpxZlFpWEkwaFljckQw?=
 =?utf-8?B?UXZoZmNkbU01aEFjTFFKK0laRHZrRmJqdEQ3VmEyR2NkcUNZcVR5R3J1STQx?=
 =?utf-8?B?eWlhNDU5NkN1VDN0RmI3ZjFya0p2SEJLZm41MVRGOENVYUhvcklub0JNaUFh?=
 =?utf-8?B?ZWx5dFVzcUxHanFWSTdZRlVBUEVOV3VYTVlJcGdHbjNUN01Hb2hsVk95OHdx?=
 =?utf-8?B?STRaQ1BucE1wQU9OWjFVeUlpVjFRNDBEdCt0Z0JIaDBHMTBaVytCdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4664.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45bdab36-5b9c-4cf1-cb6b-08de545ebff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 17:51:45.6631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UBlk3SRW8iGW4SHBqT0moSznNYp36brAWtfotR7GszfWDjzNhilhq8QaHL4lScO+LEJmbwWiyD797Ft6qxg2pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4688
X-OriginatorOrg: amazon.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJyZW5vIExlaXRhbyA8bGVp
dGFvQGRlYmlhbi5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDE1LCAyMDI2IDY6Mzgg
QU0NCj4gU3ViamVjdDogW0VYVEVSTkFMXSBbUEFUQ0ggbmV0LW5leHQgNC85XSBuZXQ6IGVuYTog
Y29udmVydCB0byB1c2UNCj4gLmdldF9yeF9yaW5nX2NvdW50DQo+IA0KPiBVc2UgdGhlIG5ld2x5
IGludHJvZHVjZWQgLmdldF9yeF9yaW5nX2NvdW50IGV0aHRvb2wgb3BzIGNhbGxiYWNrIGluc3Rl
YWQgb2YNCj4gaGFuZGxpbmcgRVRIVE9PTF9HUlhSSU5HUyBkaXJlY3RseSBpbiAuZ2V0X3J4bmZj
KCkuDQo+IA0KPiBTaW5jZSBFVEhUT09MX0dSWFJJTkdTIHdhcyB0aGUgb25seSB1c2VmdWwgY29t
bWFuZCBoYW5kbGVkIGJ5DQo+IGVuYV9nZXRfcnhuZmMoKSwgcmVtb3ZlIHRoZSBmdW5jdGlvbiBl
bnRpcmVseS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJyZW5vIExlaXRhbyA8bGVpdGFvQGRlYmlh
bi5vcmc+DQo+IC0tLQ0KDQoNClRoYW5rIHlvdSBmb3Igc3VibWl0dGluZyB0aGlzIHBhdGNoDQoN
ClJldmlld2VkLWJ5OiBBcnRodXIgS2l5YW5vdnNraSA8YWtpeWFub0BhbWF6b24uY29tPg0K

