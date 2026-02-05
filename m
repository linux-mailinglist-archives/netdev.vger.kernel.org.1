Return-Path: <netdev+bounces-256985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jaFVCTA6hGnX1QMAu9opvQ
	(envelope-from <netdev+bounces-256985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 07:35:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 719E1EF09A
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 07:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D9A030104BD
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 06:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D038933E37C;
	Thu,  5 Feb 2026 06:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="r86dnvgb"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7275884A35;
	Thu,  5 Feb 2026 06:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770273323; cv=fail; b=A+Gw4q1VnXY87q9QJ0xHmNWxXKm8jdI1c31Aikg0k6CkwMj4taUwr0pXrh7PlmoNcp51WiJ2TbFZKvaMtDsIoWoUaBGCngpRLuvdUQQ7VBNIMMBC/B/BL4/I6cWiQObrQMvVHZ4lvxCIqpim1XS5a6VkKzZhpEA7ZB9ArDNqumk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770273323; c=relaxed/simple;
	bh=JlXFNgkOSxxBa2ESZPVt+YC2uW4nU4WrMiWfam53QUE=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aa3t+J5iKCTusdkcVCpbbKVstVB1kZlgOGTLhrGV9XlRqH+MBc5O5DH8yhHPd5gC46E4Mz5w2ZQOIbJvd1ojmrbgSQ01DW5+6NQWs4QsLvJmQYROoTB7TtuG84BCqlrbTsKeVJhEXJylZ5S912FoMAOhX3qagweNS5qOQ+d5FS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=r86dnvgb; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6151L5pS3835802;
	Wed, 4 Feb 2026 22:34:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=tDuQOEVdYCoWRK5roWFdVPs6Pb9FF4y+wmpuOQSlIE0=; b=r86dnvgb/2iC
	V/lEkcVjnIz77r5FpEIQ1cWeD7GEa5VWxEkz+zDly9cYhmXnTAU09FSgAUAa8ghF
	oirBNRbHcROgXzozii5I+WDaAMtjFAiH9LCdGSDXHi7TT4Ya0gn5lpaFGIAfhHTM
	7Z1QZgeakaL9u8mGFZdYCrV3hJFadgMh4vFpS+lYP03H/BUXhLkAgd9YBhZfWHVJ
	Zx3fW/gmH7brhwZmxj2t5TwSrthuVDzx5VzNMdkHbIlvJuuu91OyQKbFNivcin7V
	tELfUABcbhKzsgfUzqrU60Bx6M5XsBouIq+pz0L3bSFmE7aCPHVPyfppB+c7G8vJ
	R6irHPLVAw==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013044.outbound.protection.outlook.com [40.93.201.44])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c4h2r9xs0-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Feb 2026 22:34:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmiGTvdFQP27SwTeZfICKFr+BfcpaqG4kXOTcgFU4MwBnkspMeuXxfJyphhYrHBNWj/ruxtba7NNbydALxpGQvahqDh9lcrTYnnVA6325vP5lTL2lRva5mHZ9kVzZep75LX0VzV7QRLL6FInwqmYTqcTeYMveXk/Hs/BvTQ3kcEpYqqUbJCxz22wu5/pzKzmV597K5Qpjn/6THHuktV9ZKQdryllUf7r1tdEyyQvvq/26T+cw8iLYit529fTGIGoYY1IUe5Bezc9Wph+F5ITuPFb3U+0mRIjjQpk2eGTHuu9vwa+rT2exdseIpFH6bUA3/JmtXGHWR1FPWIXwHGgFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDuQOEVdYCoWRK5roWFdVPs6Pb9FF4y+wmpuOQSlIE0=;
 b=l71X1nQexp1lhlAe5FSoR6WK01vuJ4+wI0t5LqIzN+Vhum9n2USCV93VGHyuHC7oBw0I4ifE+O79KfcQoMOYAV7BngjShjP2Ab3utg+vm2gssD0M+lj6pxCBvm1/gE7UCPjJDCcYFKDZN/8s/gnu3TFiE5+2EK3aWO+C/EGTWixiCRBiKSI6+ySOojSHmGnWquL/uANPboD/OUZu7zJfIJkSkO6VPKOxE5SNrKm60ob+mF30WDwlicP9rkHF5PLDBEpKv8D0PiQxESJEmuog9EWEcvzmQ+zIiedtWrqBnWRWdjRdUWY2D0UiXVnpC1mKZE8nm29M27FRUN1ey9w/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BLAPR15MB3889.namprd15.prod.outlook.com (2603:10b6:208:27a::11)
 by SJ0PR15MB4170.namprd15.prod.outlook.com (2603:10b6:a03:2c9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 06:34:46 +0000
Received: from BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044]) by BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044%5]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 06:34:45 +0000
Message-ID: <efa1f22b-eabc-4602-8886-b7cf5e3c057e@meta.com>
Date: Wed, 4 Feb 2026 22:34:38 -0800
User-Agent: Mozilla Thunderbird
From: Vishwanath Seshagiri <vishs@meta.com>
Subject: Re: [PATCH net-next v4 1/2] virtio_net: add page_pool support for
 buffer allocation
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>,
        Matteo Croce <technoboy85@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
References: <20260204193617.1200752-1-vishs@meta.com>
 <20260204193617.1200752-2-vishs@meta.com>
 <20260205000916-mutt-send-email-mst@kernel.org>
Content-Language: en-US
In-Reply-To: <20260205000916-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::25) To BLAPR15MB3889.namprd15.prod.outlook.com
 (2603:10b6:208:27a::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR15MB3889:EE_|SJ0PR15MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: 92092825-f000-47e9-907e-08de6480a725
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NlVOU3UyaHI0bFk1M1VrbSs3TnZXL1Ezck9ZUzE3Vzk1L25yVmFaTFQzTXJT?=
 =?utf-8?B?RlZLK05RV1B0VkxtaVRQR1ZPZ1hwVzdhY2k2dllwYTdFazFSMy9BYWMvNUNM?=
 =?utf-8?B?MnRVcGRKSXpvOE5aN1g2dnQzZjc5Ykt1UytzVW0yYzhJRVF4Smc5SWtvNncw?=
 =?utf-8?B?NURoSmlWYmxHM2psNXRycitDeFVPWGZ1UGdtRXQ1TVpRcGszbXUvYUJiU2lX?=
 =?utf-8?B?NmJSMDV6QSsvSGZhcnl2QmxGbjM0WWJvcVdRR0haS09PamNnM1FEaTlxbnVl?=
 =?utf-8?B?OGZXamlwTWVseWo0RjRYVW0vaGxON2ZsTnRkMzNGV0FranRpcHN3eVNVa3Q0?=
 =?utf-8?B?NUJLTk1zSFJJSzlMOW5zV3RlS2VmVUxCR3B4VWlYNk1vNU9GRHl5TkNrSjdy?=
 =?utf-8?B?VGs4a2xIT0RwZmZiMGFhNUVEUnZwVEdaUXl0VDJSanQvc0c3bjJRQ2U2d051?=
 =?utf-8?B?bG9xU1cwTExkbHVFUmVGb0ZiSER0K1F0R3ZkVXp1aFRFTDJuWTBvVFozNE9P?=
 =?utf-8?B?bGFPYlpOamY0b3ZFUE1uVU44R0pCUXRKTnJpcFpPclYrZ1BTc3Z4ZXpTNEp4?=
 =?utf-8?B?eE5WMTNBSzdOM2hNdGtMN3ltZWhBcmwzZ2xrb3FJNy9pL1VwcHNpK3FKRTBF?=
 =?utf-8?B?VmVlN28yZEM3c2JFVldicmk5UG16VnRZMVRzYm5hTk9wUlBmUERiOWxmVC9S?=
 =?utf-8?B?YlRjd2FTSnpRZE5mc3IyRXhVR1JCYjl0TWZHZ3RYVUdSci91RzBIamY2S2g4?=
 =?utf-8?B?SXFRSmdHTzhXcnNJR3d3TjVCQTgrWHR2Ym5wTW9LeXBPOURycUo5UFJJdlUx?=
 =?utf-8?B?aEdaNXFWa3NqVjJneE5rWEEzM1prUEhzTG5IVUU3OWljT3J2RkgyRThwV2kr?=
 =?utf-8?B?TVk4clhnZEFTN1F2eUhMYWJRMXpIekR1NVpSY1BiOWZyNFIvak5oZHF2aXlt?=
 =?utf-8?B?Nk9ObnlBNU9QYU9xYlpqQzRwSmsrRlJEYkxmRXNjVWNPR1NDb2FnanpQLy9J?=
 =?utf-8?B?dkVpeU53TEVZSmVYRVJQT1IyTEZjUG4zS2dGdFlYREJYcFpzVWh6S0J2Nitz?=
 =?utf-8?B?RXFQbEN4WHY5dFZ3RG9XcERmVnhzZHpvTjhzWGNZVEtzMytLYjU5bXJWcHl2?=
 =?utf-8?B?ekVzVnlscDJKak15OEpwU1I2THp6MCtlZnNPWXE0WWc5eDZXaFlLZW5hSHI3?=
 =?utf-8?B?b1J5RWF5QmNxdjJLMnBUa2x6UkRlYW04TjUrMHBQRzgwWjFDVThxT0RDOFNE?=
 =?utf-8?B?VEJiL1RTSWFUbnBKUzVzemtkY25RcmhZWWRvS1crV3AxNXZpTmJLbUVDRGho?=
 =?utf-8?B?Z2xVem1GaGNnb2tpWG5CdFRBL1J6Y29WVDkvd3JBalFVVitKMlkwTGFNZzRy?=
 =?utf-8?B?ejIyakxGUmJuUXdqZGlTZzlCNWV0THQ2clNDZ21abEMyekptTmdsQy9wZ3hL?=
 =?utf-8?B?QitOYnAxSEMveVNZSDZLVWg1UGtCVUxJZ0VWUEF6bG1iVWhQSGUwZnQ4aXdr?=
 =?utf-8?B?dktBenJVZEpKUzIxWktQZEd2RCtqTGNwenU3OXppNUl2NGRhNGpPWU8wOWhY?=
 =?utf-8?B?cG1MUjZsMTJ2RStxSnR5QVRvREEvckRESjJZSXhjVWQ4cXlOQ1JqeGhYUXU0?=
 =?utf-8?B?eVh2VVljY2s3RnRKQ3hLb0cxcHJ1ZnNwM3BjQ3Q3MWI3OVUwUEtpQ3VGVmFF?=
 =?utf-8?B?UWxxNGNyeklaQndXL2gzMVFodFNkeXdvM2d6eEJXQ28vT0d4LzlsaWFjYlhh?=
 =?utf-8?B?dm9YTDN2eU54L0xVbjFSMmZxbjNkdzQzYXdxMUdJbFAxbXNydHlyaEc5UHpJ?=
 =?utf-8?B?QitNdkxUVmwzdENFcVBXODNXUmx0Qk5NM2ZrMmJLRHZyL0YybEsrRFBVeDBF?=
 =?utf-8?B?dmVZdzVWNTJsVFRFQ2xBOEdZeHM4VFlrVUJRUUd5TTJCdElTZDh4QTBDdGdD?=
 =?utf-8?B?OGlveTYyVEVETFJaUGYvcnpMZ2pjdXFINFM2OTkyVVNGbWdDYmVXM0dSOVA3?=
 =?utf-8?B?ZTNaT3VmRHk4bWUyR1FBdzFvRGdNZ0lYaTZCcDlDdDM4TWQ5cWNBVTdyNk5h?=
 =?utf-8?B?dDFrYWZGNEt3bFVFQS9KWTJBOGtOWDA3eGpjaDB3bGlid2J2YWRPTytzUm5K?=
 =?utf-8?Q?r734=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR15MB3889.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WUxMSUhwYTJIVTlxY0V2ZHZRTHhSVkZuS1E0dHZlcXp5aWJYRG91dTRiQk9K?=
 =?utf-8?B?UUxWNUxXUjdPM2ZwczA5MGZGOGlvV2d6cm9tSjkyN1o0S3Z3TEJGQlhMdVdy?=
 =?utf-8?B?QzhzNDR3ZHhTY1VsbngyUVVSQVNyQUs4U2N6bTE3anptVjgydnlMdDFEdVlD?=
 =?utf-8?B?NElsazU0U1VrTnRHMU5DVWdjc085UnEvYkwvWk1IenJER0h2QTJpUlFaMjdE?=
 =?utf-8?B?b0hYRDRSaUgrZjNvSWg3Z1loRHpsdy9RbU40Rk9qZzcvTmQxS3hoK1ZVSWh5?=
 =?utf-8?B?a0pnaUxjY2g5N0o4d2xmQVZxQWxoaG1ZQVVUSXFFWk0ydStiZUJnNXlTSEln?=
 =?utf-8?B?Q2g0VWpRTkFnRXBKaUVNc0xGbzRod0dRa3FlbE9ZY2p2TGM4MDBxV0NOQTg2?=
 =?utf-8?B?QmRxajJET1h3R21zTzJXSGhhRFNrOEVGZ0t4ODNMaWJUek9lNURVS2lSMXdB?=
 =?utf-8?B?UldxbW1yRmxGRXpRRnp4V0plc1d0czk5ejUwNDJiUmVKZlkwZVREcld2WStv?=
 =?utf-8?B?eDhVa0ltZjdHQkQ1V1E0eGQwdHVJUFI3bXg4Z09xS2FZWmFIZkdKRGg5WUZD?=
 =?utf-8?B?UHdrTUxQOUcyQ09mL2ZVR2hmVlZ3d2V6ZUV4ZlFqRmtQaUJLanVqSlRLSE1J?=
 =?utf-8?B?SW10RWVuUnlOQnFDQW5VTEpMTnRZQXJOcmtDeDlSVm1IQUFIWTU1czhqc21L?=
 =?utf-8?B?ejgxK29TcE0wWWloczIvbGJ5TWtTYnFXZGVwMjFkb3lQNktxNGMxQWd6SVVR?=
 =?utf-8?B?dWJHVTYrek1DR2RSai9mVitiSlBMSzA1eWsvaE55c2taajVtc0hITmJpdVNt?=
 =?utf-8?B?WVJqR2lGUUl2a2xoZHVtK1VvSmduSUdaK1V0TXQyaVpvZ2NrTUJmenZBSCt5?=
 =?utf-8?B?NkFHdE0xTWg4OG9UdTNJaHlzazRpM0ZwT2UyblFjaDg4UU1nRTUwWVh3NW9i?=
 =?utf-8?B?aERieU82bEczVzNUVFN4U25qRmpka0dsekRZd3FQWk5aOVJyTHpTNTVNRHNw?=
 =?utf-8?B?QTFBemR2SXp4SmhiaDZBU0RlWGpSMEJqY2pPT3JRQ2FoV3J4MlZSNHFSS1FX?=
 =?utf-8?B?ZTcybzVXUVF4YVhHbVljOEJBaUJvcE9BdWZBUGpiblVuZzI1Qm1LaGFybVFW?=
 =?utf-8?B?RktxVmhHNEdjZDBESHJWZFVQQmZJWE9EWWZGRTRJN244aHFCOTRhc01kQWpl?=
 =?utf-8?B?U29WNEVZM0pHVkxnbVF1U2N4UkhPelJua2RpeThZS1ArcmhnMkQyNUxQVlV5?=
 =?utf-8?B?TWZtUmRETEZ5aDk0VXNqRU9DK3hvTGNHbXQvbHNuajI1SDFsU081TTgwMld6?=
 =?utf-8?B?TTUrMlJSazA2d0l6YmVFUHQ3SGlmR2R2ZzRlc1JQMnNKMEsvT0NQMm91TEJy?=
 =?utf-8?B?aEJOYnVuRUFLbnhGdDFsbncrTVJ6N09jRzZmbklldUdQWXNOVkRBV3pYY1Nq?=
 =?utf-8?B?V2NqeHM1UFJodjdQS1ZhekZ0Vk5vVG03NnQ4Q01lQUI1MzVkOHdtR0VSUkRJ?=
 =?utf-8?B?LytIeUEwY1RjSTdZd2wrYnNXcktMMGcvOE9sa1ArY2QzZlNWYU9BTVZWTm5I?=
 =?utf-8?B?MFB5MFV0ZGJvMnN2dy9RQ083V2VFRHc0K1ZGZ2pkdHdUS1FURmtLUmVkRy92?=
 =?utf-8?B?Yi9Oemc4WGhhM052YXFHQk5KRXlIcGZCRE9ZaGNDNnRWSkJxTHd4cWFOMmlE?=
 =?utf-8?B?RThDaVFSb2p3MkdkQmJlUTlUc1BqZ2wyYThnbE9pVCthYzdyT085SXRhSUJH?=
 =?utf-8?B?VVNjSVVnL2RHWUVDVFdjbkV3VWh4cHdKb2hUSlF5bVVSUmpCcXdESWJWR3Yx?=
 =?utf-8?B?RnpGRXlvMUVudkp4S1NVUkVpU2loUWpzWXM1RGZpQVkyRHVsYmlvVTU2NFRr?=
 =?utf-8?B?Q3hGTkRRVWVLWkc1bDlzdVhHTTh1ZnpobGNvRXpXaUR6eS9TdDVVUGsydlQy?=
 =?utf-8?B?SUdFMTJXYlZsdjlUTUlXMm04ZkVDblZpQWxkRDcwK09QTlNJRDdtYUFWZUY1?=
 =?utf-8?B?QkNvSVJqQ1kzTkRXc01pU1lJYmxNbEFPcmo2cU9MZ084c1pnRHl3NEhyd0Fr?=
 =?utf-8?B?em4xRFkraWQydlRyZjZHd1RFcU5FMlNlemVhL2hOWFIvOWdENjFZQjB5bXB3?=
 =?utf-8?B?SlR1MFM5THZBNnZscUY0cFU1V25uUkZGb1Z5djZSOTV5QmNXZGF6NHgxUys5?=
 =?utf-8?B?dnlwR3VHRnB4RTRYTG5EbnlpMzBMZHpGR0Z0NlJxaGp3NStUMWMyWXRGWXh5?=
 =?utf-8?B?RysvdDB5RUNFbDZmaThhSHBRVkFxdTU0MkQzRmpiYlRKbVB0OWhGdTBXL1ZJ?=
 =?utf-8?B?RGxPbmNwOUlXSnNGc2tIcDBLQXprWDJqTlVNV3h0cXlYZTNPRGFmVkpZRCtY?=
 =?utf-8?Q?dvFThZQpvV2ZRsiSCS5UgNAmxn5+XC9/8E+Hi?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92092825-f000-47e9-907e-08de6480a725
X-MS-Exchange-CrossTenant-AuthSource: BLAPR15MB3889.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:34:45.8249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dchfo59jVK5JdbCP/RR/caY4CnhSE030PC7FQen+mpzSxjyunN+v1L0PcgMg9NI/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4170
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA0MyBTYWx0ZWRfX26Yq5JiyO8rH
 +aSSiOm60qeSeP75nwFAHOM6gGvGTcEo9j6hROA9QXecMYVcAceWSl7x6sKewZMjdcKgogzpGuI
 b2yH9kROF3jQh13LCkrGB253TaWJm1azK94B7IoBcZ3hxFqucONIKrnPYx4MS2jmHDFMuaAhrzL
 HQexHZlIc5oHHCuLu3ANn8peM/pSRKcIEnkoR56fPAgQF5JtUVHHKrI1u8beEZofV0Kx/DlVqTW
 R5T26cUejuoI2ujpRL9ZvcxovZpn+8iT/kmOj2Zne6nxj8OD9SCvGHAjqbfWSX+cNYagSwNj3Y7
 Q/lo3LqQ36gXVyju1U3CNZR6rcwFFSrCc/4Z0pnQ/WA8U58O1Km/YO5rKJrjqGHhT3Glzi4CXRK
 6CSEJkg/Z0nrisKMhHVaZ8nsaRhsurJhs/8h9DW0tLpwwhFgwdnTY7283gF7qfIF/5JYtfeq8Ws
 IDf+o0JEbMhJfja/3vQ==
X-Authority-Analysis: v=2.4 cv=WtAm8Nfv c=1 sm=1 tr=0 ts=69843a09 cx=c_pps
 a=fVVZRgaqDuj868rfKEvgUg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VabnemYjAAAA:8 a=OYI5DvtAVg1VkXrQVs8A:9
 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: CdGYvHxLVGebCpcwKJaGfDg0uJOUkcsw
X-Proofpoint-ORIG-GUID: CdGYvHxLVGebCpcwKJaGfDg0uJOUkcsw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_08,2026-02-04_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256985-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:dkim,meta.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishs@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 719E1EF09A
X-Rspamd-Action: no action



On 2/4/26 9:30 PM, Michael S. Tsirkin wrote:
> On Wed, Feb 04, 2026 at 11:36:16AM -0800, Vishwanath Seshagiri wrote:
>> Use page_pool for RX buffer allocation in mergeable and small buffer
>> modes to enable page recycling and avoid repeated page allocator calls.
>> skb_mark_for_recycle() enables page reuse in the network stack.
>>
>> Big packets mode is unchanged because it uses page->private for linked
>> list chaining of multiple pages per buffer, which conflicts with
>> page_pool's internal use of page->private.
>>
>> Implement conditional DMA premapping using virtqueue_dma_dev():
>> - When non-NULL (vhost, virtio-pci): use PP_FLAG_DMA_MAP with page_pool
>>    handling DMA mapping, submit via virtqueue_add_inbuf_premapped()
>> - When NULL (VDUSE, direct physical): page_pool handles allocation only,
>>    submit via virtqueue_add_inbuf_ctx()
>>
>> This preserves the DMA premapping optimization from commit 31f3cd4e5756b
>> ("virtio-net: rq submits premapped per-buffer") while adding page_pool
>> support as a prerequisite for future zero-copy features (devmem TCP,
>> io_uring ZCRX).
>>
>> Page pools are created in probe and destroyed in remove (not open/close),
>> following existing driver behavior where RX buffers remain in virtqueues
>> across interface state changes.
>>
>> Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
>> ---
>>   drivers/net/Kconfig      |   1 +
>>   drivers/net/virtio_net.c | 351 ++++++++++++++++++++++-----------------
>>   2 files changed, 201 insertions(+), 151 deletions(-)
>>
>> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
>> index ac12eaf11755..f1e6b6b0a86f 100644
>> --- a/drivers/net/Kconfig
>> +++ b/drivers/net/Kconfig
>> @@ -450,6 +450,7 @@ config VIRTIO_NET
>>   	depends on VIRTIO
>>   	select NET_FAILOVER
>>   	select DIMLIB
>> +	select PAGE_POOL
>>   	help
>>   	  This is the virtual network driver for virtio.  It can be used with
>>   	  QEMU based VMMs (like KVM or Xen).  Say Y or M.
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index db88dcaefb20..74c51e597c3f 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -26,6 +26,7 @@
>>   #include <net/netdev_rx_queue.h>
>>   #include <net/netdev_queues.h>
>>   #include <net/xdp_sock_drv.h>
>> +#include <net/page_pool/helpers.h>
>>   
>>   static int napi_weight = NAPI_POLL_WEIGHT;
>>   module_param(napi_weight, int, 0444);
>> @@ -359,6 +360,11 @@ struct receive_queue {
>>   	/* Page frag for packet buffer allocation. */
>>   	struct page_frag alloc_frag;
>>   
>> +	struct page_pool *page_pool;
>> +
>> +	/* True if page_pool handles DMA mapping via PP_FLAG_DMA_MAP */
>> +	bool use_page_pool_dma;
>> +
>>   	/* RX: fragments + linear part + virtio header */
>>   	struct scatterlist sg[MAX_SKB_FRAGS + 2];
>>   
>> @@ -521,11 +527,13 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
>>   			       struct virtnet_rq_stats *stats);
>>   static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
>>   				 struct sk_buff *skb, u8 flags);
>> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
>> +					       struct sk_buff *head_skb,
>>   					       struct sk_buff *curr_skb,
>>   					       struct page *page, void *buf,
>>   					       int len, int truesize);
>>   static void virtnet_xsk_completed(struct send_queue *sq, int num);
>> +static void free_unused_bufs(struct virtnet_info *vi);
>>   
>>   enum virtnet_xmit_type {
>>   	VIRTNET_XMIT_TYPE_SKB,
>> @@ -706,15 +714,24 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
>>   	return p;
>>   }
>>   
>> +static void virtnet_put_page(struct receive_queue *rq, struct page *page,
>> +			     bool allow_direct)
>> +{
>> +	if (page_pool_page_is_pp(page))
>> +		page_pool_put_page(rq->page_pool, page, -1, allow_direct);
>> +	else
>> +		put_page(page);
>> +}
>> +
>>   static void virtnet_rq_free_buf(struct virtnet_info *vi,
>>   				struct receive_queue *rq, void *buf)
>>   {
>>   	if (vi->mergeable_rx_bufs)
>> -		put_page(virt_to_head_page(buf));
>> +		virtnet_put_page(rq, virt_to_head_page(buf), false);
>>   	else if (vi->big_packets)
>>   		give_pages(rq, buf);
>>   	else
>> -		put_page(virt_to_head_page(buf));
>> +		virtnet_put_page(rq, virt_to_head_page(buf), false);
>>   }
>>   
>>   static void enable_rx_mode_work(struct virtnet_info *vi)
>> @@ -877,9 +894,12 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>   		if (unlikely(!skb))
>>   			return NULL;
>>   
>> -		page = (struct page *)page->private;
>> -		if (page)
>> -			give_pages(rq, page);
>> +		if (!rq->page_pool) {
> 
> I think this is ok because big_packets is exactly when this happens.
> but it is confusing that the conditions on free and alloc are
> written differently. A comment with an explanation, at least?

I will add a comment here in v5.

> 
> 
>> +			page = (struct page *)page->private;
>> +			if (page)
>> +				give_pages(rq, page);
>> +		}
>> +
>>   		goto ok;
>>   	}
>>   
>> @@ -925,7 +945,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>   	hdr = skb_vnet_common_hdr(skb);
>>   	memcpy(hdr, hdr_p, hdr_len);
>>   	if (page_to_free)
>> -		put_page(page_to_free);
>> +		virtnet_put_page(rq, page_to_free, true);
>>   
>>   	return skb;
>>   }
>> @@ -965,93 +985,10 @@ static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 len)
>>   static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
>>   {
>>   	struct virtnet_info *vi = rq->vq->vdev->priv;
>> -	void *buf;
>> -
>> -	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>> -
>> -	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
>> -	if (buf)
>> -		virtnet_rq_unmap(rq, buf, *len);
>> -
>> -	return buf;
>> -}
>> -
>> -static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
>> -{
>> -	struct virtnet_info *vi = rq->vq->vdev->priv;
>> -	struct virtnet_rq_dma *dma;
>> -	dma_addr_t addr;
>> -	u32 offset;
>> -	void *head;
>> -
>> -	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>> -
>> -	head = page_address(rq->alloc_frag.page);
>> -
>> -	offset = buf - head;
>> -
>> -	dma = head;
>> -
>> -	addr = dma->addr - sizeof(*dma) + offset;
>> -
>> -	sg_init_table(rq->sg, 1);
>> -	sg_fill_dma(rq->sg, addr, len);
>> -}
>> -
>> -static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
>> -{
>> -	struct page_frag *alloc_frag = &rq->alloc_frag;
>> -	struct virtnet_info *vi = rq->vq->vdev->priv;
>> -	struct virtnet_rq_dma *dma;
>> -	void *buf, *head;
>> -	dma_addr_t addr;
>>   
>>   	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>>   
>> -	head = page_address(alloc_frag->page);
>> -
>> -	dma = head;
>> -
>> -	/* new pages */
>> -	if (!alloc_frag->offset) {
>> -		if (rq->last_dma) {
>> -			/* Now, the new page is allocated, the last dma
>> -			 * will not be used. So the dma can be unmapped
>> -			 * if the ref is 0.
>> -			 */
>> -			virtnet_rq_unmap(rq, rq->last_dma, 0);
>> -			rq->last_dma = NULL;
>> -		}
>> -
>> -		dma->len = alloc_frag->size - sizeof(*dma);
>> -
>> -		addr = virtqueue_map_single_attrs(rq->vq, dma + 1,
>> -						  dma->len, DMA_FROM_DEVICE, 0);
>> -		if (virtqueue_map_mapping_error(rq->vq, addr))
>> -			return NULL;
>> -
>> -		dma->addr = addr;
>> -		dma->need_sync = virtqueue_map_need_sync(rq->vq, addr);
> 
> it gives me pause that this patch never does sync.
> don't you need page_pool_dma_sync_for_cpu somewhere?

I missed the page_pool_dma_sync_for_cpu in the receive path before
reading the buffer data. I will add it in v5.

> 
> 
> 
>> -
>> -		/* Add a reference to dma to prevent the entire dma from
>> -		 * being released during error handling. This reference
>> -		 * will be freed after the pages are no longer used.
>> -		 */
>> -		get_page(alloc_frag->page);
>> -		dma->ref = 1;
>> -		alloc_frag->offset = sizeof(*dma);
>> -
>> -		rq->last_dma = dma;
>> -	}
>> -
>> -	++dma->ref;
>> -
>> -	buf = head + alloc_frag->offset;
>> -
>> -	get_page(alloc_frag->page);
>> -	alloc_frag->offset += size;
>> -
>> -	return buf;
>> +	return virtqueue_get_buf_ctx(rq->vq, len, ctx);
>>   }
>>   
>>   static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>> @@ -1067,9 +1004,6 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>>   		return;
>>   	}
>>   
>> -	if (!vi->big_packets || vi->mergeable_rx_bufs)
>> -		virtnet_rq_unmap(rq, buf, 0);
>> -
>>   	virtnet_rq_free_buf(vi, rq, buf);
>>   }
>>   
>> @@ -1335,7 +1269,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
>>   
>>   		truesize = len;
>>   
>> -		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
>> +		curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
>>   						    buf, len, truesize);
>>   		if (!curr_skb) {
>>   			put_page(page);
>> @@ -1771,7 +1705,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>>   	return ret;
>>   }
>>   
>> -static void put_xdp_frags(struct xdp_buff *xdp)
>> +static void put_xdp_frags(struct receive_queue *rq, struct xdp_buff *xdp)
>>   {
>>   	struct skb_shared_info *shinfo;
>>   	struct page *xdp_page;
>> @@ -1781,7 +1715,7 @@ static void put_xdp_frags(struct xdp_buff *xdp)
>>   		shinfo = xdp_get_shared_info_from_buff(xdp);
>>   		for (i = 0; i < shinfo->nr_frags; i++) {
>>   			xdp_page = skb_frag_page(&shinfo->frags[i]);
>> -			put_page(xdp_page);
>> +			virtnet_put_page(rq, xdp_page, true);
>>   		}
>>   	}
>>   }
>> @@ -1873,7 +1807,7 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>>   	if (page_off + *len + tailroom > PAGE_SIZE)
>>   		return NULL;
>>   
>> -	page = alloc_page(GFP_ATOMIC);
>> +	page = page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC);
>>   	if (!page)
>>   		return NULL;
>>   
>> @@ -1897,7 +1831,7 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>>   		off = buf - page_address(p);
>>   
>>   		if (check_mergeable_len(dev, ctx, buflen)) {
>> -			put_page(p);
>> +			virtnet_put_page(rq, p, true);
>>   			goto err_buf;
>>   		}
>>   
>> @@ -1905,21 +1839,21 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>>   		 * is sending packet larger than the MTU.
>>   		 */
>>   		if ((page_off + buflen + tailroom) > PAGE_SIZE) {
>> -			put_page(p);
>> +			virtnet_put_page(rq, p, true);
>>   			goto err_buf;
>>   		}
>>   
>>   		memcpy(page_address(page) + page_off,
>>   		       page_address(p) + off, buflen);
>>   		page_off += buflen;
>> -		put_page(p);
>> +		virtnet_put_page(rq, p, true);
>>   	}
>>   
>>   	/* Headroom does not contribute to packet length */
>>   	*len = page_off - XDP_PACKET_HEADROOM;
>>   	return page;
>>   err_buf:
>> -	__free_pages(page, 0);
>> +	page_pool_put_page(rq->page_pool, page, -1, true);
>>   	return NULL;
>>   }
>>   
>> @@ -1996,7 +1930,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>>   			goto err_xdp;
>>   
>>   		buf = page_address(xdp_page);
>> -		put_page(page);
>> +		virtnet_put_page(rq, page, true);
>>   		page = xdp_page;
>>   	}
>>   
>> @@ -2028,13 +1962,15 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>>   	if (metasize)
>>   		skb_metadata_set(skb, metasize);
>>   
>> +	skb_mark_for_recycle(skb);
>> +
>>   	return skb;
>>   
>>   err_xdp:
>>   	u64_stats_inc(&stats->xdp_drops);
>>   err:
>>   	u64_stats_inc(&stats->drops);
>> -	put_page(page);
>> +	virtnet_put_page(rq, page, true);
>>   xdp_xmit:
>>   	return NULL;
>>   }
>> @@ -2082,12 +2018,14 @@ static struct sk_buff *receive_small(struct net_device *dev,
>>   	}
>>   
>>   	skb = receive_small_build_skb(vi, xdp_headroom, buf, len);
>> -	if (likely(skb))
>> +	if (likely(skb)) {
>> +		skb_mark_for_recycle(skb);
>>   		return skb;
>> +	}
>>   
>>   err:
>>   	u64_stats_inc(&stats->drops);
>> -	put_page(page);
>> +	virtnet_put_page(rq, page, true);
>>   	return NULL;
>>   }
>>   
>> @@ -2142,7 +2080,7 @@ static void mergeable_buf_free(struct receive_queue *rq, int num_buf,
>>   		}
>>   		u64_stats_add(&stats->bytes, len);
>>   		page = virt_to_head_page(buf);
>> -		put_page(page);
>> +		virtnet_put_page(rq, page, true);
>>   	}
>>   }
>>   
>> @@ -2253,7 +2191,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>>   		offset = buf - page_address(page);
>>   
>>   		if (check_mergeable_len(dev, ctx, len)) {
>> -			put_page(page);
>> +			virtnet_put_page(rq, page, true);
>>   			goto err;
>>   		}
>>   
>> @@ -2272,7 +2210,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>>   	return 0;
>>   
>>   err:
>> -	put_xdp_frags(xdp);
>> +	put_xdp_frags(rq, xdp);
>>   	return -EINVAL;
>>   }
>>   
>> @@ -2337,7 +2275,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
>>   		if (*len + xdp_room > PAGE_SIZE)
>>   			return NULL;
>>   
>> -		xdp_page = alloc_page(GFP_ATOMIC);
>> +		xdp_page = page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC);
>>   		if (!xdp_page)
>>   			return NULL;
>>   
>> @@ -2347,7 +2285,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
>>   
>>   	*frame_sz = PAGE_SIZE;
>>   
>> -	put_page(*page);
>> +	virtnet_put_page(rq, *page, true);
>>   
>>   	*page = xdp_page;
>>   
>> @@ -2393,6 +2331,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>>   		head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
>>   		if (unlikely(!head_skb))
>>   			break;
>> +
>> +		skb_mark_for_recycle(head_skb);
>>   		return head_skb;
>>   
>>   	case XDP_TX:
>> @@ -2403,10 +2343,10 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>>   		break;
>>   	}
>>   
>> -	put_xdp_frags(&xdp);
>> +	put_xdp_frags(rq, &xdp);
>>   
>>   err_xdp:
>> -	put_page(page);
>> +	virtnet_put_page(rq, page, true);
>>   	mergeable_buf_free(rq, num_buf, dev, stats);
>>   
>>   	u64_stats_inc(&stats->xdp_drops);
>> @@ -2414,7 +2354,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>>   	return NULL;
>>   }
>>   
>> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
>> +					       struct sk_buff *head_skb,
>>   					       struct sk_buff *curr_skb,
>>   					       struct page *page, void *buf,
>>   					       int len, int truesize)
>> @@ -2446,7 +2387,7 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>>   
>>   	offset = buf - page_address(page);
>>   	if (skb_can_coalesce(curr_skb, num_skb_frags, page, offset)) {
>> -		put_page(page);
>> +		virtnet_put_page(rq, page, true);
>>   		skb_coalesce_rx_frag(curr_skb, num_skb_frags - 1,
>>   				     len, truesize);
>>   	} else {
>> @@ -2499,6 +2440,8 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>   
>>   	if (unlikely(!curr_skb))
>>   		goto err_skb;
>> +
>> +	skb_mark_for_recycle(head_skb);
>>   	while (--num_buf) {
>>   		buf = virtnet_rq_get_buf(rq, &len, &ctx);
>>   		if (unlikely(!buf)) {
>> @@ -2517,7 +2460,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>   			goto err_skb;
>>   
>>   		truesize = mergeable_ctx_to_truesize(ctx);
>> -		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
>> +		curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
>>   						    buf, len, truesize);
>>   		if (!curr_skb)
>>   			goto err_skb;
>> @@ -2527,7 +2470,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>   	return head_skb;
>>   
>>   err_skb:
>> -	put_page(page);
>> +	virtnet_put_page(rq, page, true);
>>   	mergeable_buf_free(rq, num_buf, dev, stats);
>>   
>>   err_buf:
>> @@ -2666,32 +2609,42 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>>   static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>>   			     gfp_t gfp)
>>   {
>> -	char *buf;
>>   	unsigned int xdp_headroom = virtnet_get_headroom(vi);
>>   	void *ctx = (void *)(unsigned long)xdp_headroom;
>>   	int len = vi->hdr_len + VIRTNET_RX_PAD + GOOD_PACKET_LEN + xdp_headroom;
>> +	unsigned int offset;
>> +	struct page *page;
>> +	dma_addr_t addr;
>> +	char *buf;
>>   	int err;
>>   
>>   	len = SKB_DATA_ALIGN(len) +
>>   	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>>   
>> -	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
>> -		return -ENOMEM;
>> -
>> -	buf = virtnet_rq_alloc(rq, len, gfp);
>> -	if (unlikely(!buf))
>> +	page = page_pool_alloc_frag(rq->page_pool, &offset, len, gfp);
>> +	if (unlikely(!page))
>>   		return -ENOMEM;
>>   
>> +	buf = page_address(page) + offset;
>>   	buf += VIRTNET_RX_PAD + xdp_headroom;
>>   
>> -	virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN);
>> +	if (rq->use_page_pool_dma) {
>> +		addr = page_pool_get_dma_addr(page) + offset;
>> +		addr += VIRTNET_RX_PAD + xdp_headroom;
>>   
>> -	err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx, gfp);
>> -	if (err < 0) {
>> -		virtnet_rq_unmap(rq, buf, 0);
>> -		put_page(virt_to_head_page(buf));
>> +		sg_init_table(rq->sg, 1);
>> +		sg_fill_dma(rq->sg, addr, vi->hdr_len + GOOD_PACKET_LEN);
>> +		err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1,
>> +						    buf, ctx, gfp);
>> +	} else {
>> +		sg_init_one(rq->sg, buf, vi->hdr_len + GOOD_PACKET_LEN);
>> +		err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1,
>> +					      buf, ctx, gfp);
>>   	}
>>   
>> +	if (err < 0)
>> +		page_pool_put_page(rq->page_pool, virt_to_head_page(buf),
>> +				   -1, false);
>>   	return err;
>>   }
>>   
>> @@ -2764,13 +2717,15 @@ static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
>>   static int add_recvbuf_mergeable(struct virtnet_info *vi,
>>   				 struct receive_queue *rq, gfp_t gfp)
>>   {
>> -	struct page_frag *alloc_frag = &rq->alloc_frag;
>>   	unsigned int headroom = virtnet_get_headroom(vi);
>>   	unsigned int tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
>>   	unsigned int room = SKB_DATA_ALIGN(headroom + tailroom);
>>   	unsigned int len, hole;
>> -	void *ctx;
>> +	unsigned int offset;
>> +	struct page *page;
>> +	dma_addr_t addr;
>>   	char *buf;
>> +	void *ctx;
>>   	int err;
>>   
>>   	/* Extra tailroom is needed to satisfy XDP's assumption. This
>> @@ -2779,18 +2734,14 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>>   	 */
>>   	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
>>   
>> -	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
>> -		return -ENOMEM;
>> -
>> -	if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_dma) > alloc_frag->size)
>> -		len -= sizeof(struct virtnet_rq_dma);
>> -
>> -	buf = virtnet_rq_alloc(rq, len + room, gfp);
>> -	if (unlikely(!buf))
>> +	page = page_pool_alloc_frag(rq->page_pool, &offset, len + room, gfp);
>> +	if (unlikely(!page))
>>   		return -ENOMEM;
>>   
>> +	buf = page_address(page) + offset;
>>   	buf += headroom; /* advance address leaving hole at front of pkt */
>> -	hole = alloc_frag->size - alloc_frag->offset;
>> +
>> +	hole = PAGE_SIZE - (offset + len + room);
>>   	if (hole < len + room) {
>>   		/* To avoid internal fragmentation, if there is very likely not
>>   		 * enough space for another buffer, add the remaining space to
>> @@ -2800,18 +2751,27 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>>   		 */
>>   		if (!headroom)
>>   			len += hole;
>> -		alloc_frag->offset += hole;
> 
> Hmm. All these allocations are tricky.
> So we used to advance offset by hole but with page pool api
> what advances pool->frag_offset? If nothing will not the next
> small allocation reuse the space and overlap the buffer?

I tested with debug tracing and confirmed the issue triggers with
typical 1536-byte allocations. When len += hole extends the buffer into
3072-4096, page_pool's internal frag_offset stays at 3072, so a
subsequent smaller allocation could overlap.
Since page_pool manages frag_offset internally and there's no API to
advance it past the hole, the fix is to remove the if (hole < len +
room) block entirely.

> 
> 
>>   	}
>>   
>> -	virtnet_rq_init_one_sg(rq, buf, len);
>> -
>>   	ctx = mergeable_len_to_ctx(len + room, headroom);
>> -	err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx, gfp);
>> -	if (err < 0) {
>> -		virtnet_rq_unmap(rq, buf, 0);
>> -		put_page(virt_to_head_page(buf));
>> +
>> +	if (rq->use_page_pool_dma) {
>> +		addr = page_pool_get_dma_addr(page) + offset;
>> +		addr += headroom;
>> +
>> +		sg_init_table(rq->sg, 1);
>> +		sg_fill_dma(rq->sg, addr, len);
>> +		err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1,
>> +						    buf, ctx, gfp);
>> +	} else {
>> +		sg_init_one(rq->sg, buf, len);
>> +		err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1,
>> +					      buf, ctx, gfp);
>>   	}
>>   
>> +	if (err < 0)
>> +		page_pool_put_page(rq->page_pool, virt_to_head_page(buf),
>> +				   -1, false);
>>   	return err;
>>   }
>>   
>> @@ -3128,7 +3088,10 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
>>   		return err;
>>   
>>   	err = xdp_rxq_info_reg_mem_model(&vi->rq[qp_index].xdp_rxq,
>> -					 MEM_TYPE_PAGE_SHARED, NULL);
>> +					 vi->rq[qp_index].page_pool ?
>> +						MEM_TYPE_PAGE_POOL :
>> +						MEM_TYPE_PAGE_SHARED,
>> +					 vi->rq[qp_index].page_pool);
>>   	if (err < 0)
>>   		goto err_xdp_reg_mem_model;
>>   
>> @@ -3168,6 +3131,81 @@ static void virtnet_update_settings(struct virtnet_info *vi)
>>   		vi->duplex = duplex;
>>   }
>>   
>> +static int virtnet_create_page_pools(struct virtnet_info *vi)
>> +{
>> +	int i, err;
>> +
>> +	if (!vi->mergeable_rx_bufs && vi->big_packets)
>> +		return 0;
>> +
>> +	for (i = 0; i < vi->max_queue_pairs; i++) {
>> +		struct receive_queue *rq = &vi->rq[i];
>> +		struct page_pool_params pp_params = { 0 };
>> +		struct device *dma_dev;
>> +
>> +		if (rq->page_pool)
>> +			continue;
>> +
>> +		if (rq->xsk_pool)
>> +			continue;
>> +
>> +		pp_params.order = 0;
>> +		pp_params.pool_size = virtqueue_get_vring_size(rq->vq);
>> +		pp_params.nid = dev_to_node(vi->vdev->dev.parent);
>> +		pp_params.netdev = vi->dev;
>> +		pp_params.napi = &rq->napi;
>> +
>> +		/* Check if backend supports DMA API (e.g., vhost, virtio-pci).
>> +		 * If so, use page_pool's DMA mapping for premapped buffers.
>> +		 * Otherwise (e.g., VDUSE), page_pool only handles allocation.
>> +		 */
>> +		dma_dev = virtqueue_dma_dev(rq->vq);
>> +		if (dma_dev) {
>> +			pp_params.dev = dma_dev;
>> +			pp_params.flags = PP_FLAG_DMA_MAP;
>> +			pp_params.dma_dir = DMA_FROM_DEVICE;
>> +			rq->use_page_pool_dma = true;
>> +		} else {
>> +			pp_params.dev = vi->vdev->dev.parent;
>> +			pp_params.flags = 0;
>> +			rq->use_page_pool_dma = false;
>> +		}
>> +
>> +		rq->page_pool = page_pool_create(&pp_params);
>> +		if (IS_ERR(rq->page_pool)) {
>> +			err = PTR_ERR(rq->page_pool);
>> +			rq->page_pool = NULL;
>> +			goto err_cleanup;
>> +		}
>> +	}
>> +	return 0;
>> +
>> +err_cleanup:
>> +	while (--i >= 0) {
>> +		struct receive_queue *rq = &vi->rq[i];
>> +
>> +		if (rq->page_pool) {
>> +			page_pool_destroy(rq->page_pool);
>> +			rq->page_pool = NULL;
>> +		}
>> +	}
>> +	return err;
>> +}
>> +
>> +static void virtnet_destroy_page_pools(struct virtnet_info *vi)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < vi->max_queue_pairs; i++) {
>> +		struct receive_queue *rq = &vi->rq[i];
>> +
>> +		if (rq->page_pool) {
>> +			page_pool_destroy(rq->page_pool);
>> +			rq->page_pool = NULL;
>> +		}
>> +	}
>> +}
>> +
>>   static int virtnet_open(struct net_device *dev)
>>   {
>>   	struct virtnet_info *vi = netdev_priv(dev);
>> @@ -6441,10 +6479,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>>   		vi->rq[i].min_buf_len = mergeable_min_buf_len(vi, vi->rq[i].vq);
>>   		vi->sq[i].vq = vqs[txq2vq(i)];
>>   	}
>> -
>>   	/* run here: ret == 0. */
>>   
>> -
>>   err_find:
>>   	kfree(ctx);
>>   err_ctx:
>> @@ -6945,6 +6981,14 @@ static int virtnet_probe(struct virtio_device *vdev)
>>   			goto free;
>>   	}
>>   
>> +	/* Create page pools for receive queues.
>> +	 * Page pools are created at probe time so they can be used
>> +	 * with premapped DMA addresses throughout the device lifetime.
>> +	 */
>> +	err = virtnet_create_page_pools(vi);
>> +	if (err)
>> +		goto free_irq_moder;
>> +
>>   #ifdef CONFIG_SYSFS
>>   	if (vi->mergeable_rx_bufs)
>>   		dev->sysfs_rx_queue_group = &virtio_net_mrg_rx_group;
>> @@ -6958,7 +7002,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>>   		vi->failover = net_failover_create(vi->dev);
>>   		if (IS_ERR(vi->failover)) {
>>   			err = PTR_ERR(vi->failover);
>> -			goto free_vqs;
>> +			goto free_page_pools;
>>   		}
>>   	}
>>   
>> @@ -7075,7 +7119,10 @@ static int virtnet_probe(struct virtio_device *vdev)
>>   	unregister_netdev(dev);
>>   free_failover:
>>   	net_failover_destroy(vi->failover);
>> -free_vqs:
>> +free_page_pools:
>> +	virtnet_destroy_page_pools(vi);
>> +free_irq_moder:
>> +	virtnet_free_irq_moder(vi);
>>   	virtio_reset_device(vdev);
>>   	free_receive_page_frags(vi);
>>   	virtnet_del_vqs(vi);
>> @@ -7104,6 +7151,8 @@ static void remove_vq_common(struct virtnet_info *vi)
>>   
>>   	free_receive_page_frags(vi);
>>   
>> +	virtnet_destroy_page_pools(vi);
>> +
>>   	virtnet_del_vqs(vi);
>>   }
>>   
>> -- 
>> 2.47.3
> 


