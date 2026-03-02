Return-Path: <netdev+bounces-262611-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GZZLphrpWkaAQYAu9opvQ
	(envelope-from <netdev+bounces-262611-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 11:51:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 462491D6D69
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 11:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 345753007F59
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 10:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918FB350A1F;
	Mon,  2 Mar 2026 10:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="gXGfr/aB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F1A33E355;
	Mon,  2 Mar 2026 10:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772448388; cv=fail; b=kQQWVuj3+36m/HM5ihnRg7wBAEzhXuQdCKz0zEEzECwHP6vCKqwdEBMic0EoSvaMKXz0OTmoWtAap2pa1+a/nGavyi11GEliIza8qoOI4+7rNLJ+p6MDIO1XMEWQUIGeIYcVuyw2TN9+ZCJWETQ+e8PHv/ZtV/YKdHvHAimXuQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772448388; c=relaxed/simple;
	bh=P1j300axnyexyWnNHG8Td6Mxo0Jb6v07ZHeaWNhIhNw=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AcsYlrPd/ZcIavoAuu2HaIIUQNtFnL2xzjNC2NeID34ygOqLicfKAO4Tc/6QYWjxs4+0wA6VV2eKcQsXNGyQjUpypsVJPD/I32lowEvbbN+eYsO2PeVQs/5RE5o5nfWO7crAjl745mVkg3Fw3VJ9GgXx/qSQ81CGfbTSAJcMktg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=gXGfr/aB; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62245aTK2706683;
	Mon, 2 Mar 2026 02:46:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=uGhx4AapiZKqigSyF/xZPh5jejrKccvyMlXZle2oJ6g=; b=gXGfr/aBGmEK
	sUV/ss6CfhcMexauNOYwbPWKePE30kxEWk+Wq9HX9PoHmAG3AxabivFvJK2vb5aV
	PA0LvxMlO84VPVEY/qi5Bls6zVxrSB3ztE7hbA6yLNSY5taCZBptQ2EsGmo3TBjv
	BpTM3v+fjwtRnP+ODV9+AaX+EJFAJX+T4Rq/HWcCA5H55bGafYlli+10pC8NW3ao
	VsawBr6ASBWc9UCySwXVuLDE1pC55Fl1Zn8cyqZg33vm5+JtwpJMyfKTYmAPgqJl
	OrWJk2Y3ZK6TIbAy/61jPDEZfbEfDqZvsW7IP8bgz5fsA//3AQNsBeaWNIJoksRO
	k2971d88Jw==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cn372asbd-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 02:46:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNWe1fKKikh9+r/wQ03j8bNj5B0gJa5/IWqhhanEYDOL9vzuMG0pj6pv946IBpZzIgxBlF11h3tsaTGcT9rzsO/UpVHeogfV+F5SwsKyMzB8pEQJnLHMgHO6rB1akee3g80pKHZpKXolCslvHc4RyxW2d/QmrH3tCEQz3PB3LXB3AvxzsFI6v4887VzrZIB/rIFLtNKed+7IGJ1LUZ+ZEg0ploJeovCiT129XDoAN46WcDpLI6MA/luqYDkVTVn6lPJ8E9mOUTOf8p2YnNqISZHw9jrlrFIDyBgyb4YLJj+JfswJj5UH9G+occFLQQMTQwkAjMnE7EgPhGaFPPTtzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGhx4AapiZKqigSyF/xZPh5jejrKccvyMlXZle2oJ6g=;
 b=hdDFa//W8lhvAO0ZDhxkrZNh0FdzbeVwng30sINdV07lhU0WTpiZEJWZtiREiwO0IQ5LV4pBm4tD129oD1cnAiaLRMjYn0jcDyS0BfbBZ9ZDxn4yBp2A/+txpTbFHCJHCo/55mabkqYFTWYpwabceDhnX5l5hm/s4kCDropx/eOzP5dEWi3mdmbBS48Eg4hFJ2fzd7IBy2kK4HiA/1jIBsE9/oEGB72ad/nuUqUq5pEsKSMl+TbaIhObccctvfnXqIl+SzTa84+UPnD0IXu1IPYv+6KJFZQdL1fdXye7xNz5wXw7KsikLL3DzYgoASLuLAd16/TolhxcPACrBe/Btg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB3893.namprd15.prod.outlook.com (2603:10b6:5:2b6::17)
 by PH0PR15MB5639.namprd15.prod.outlook.com (2603:10b6:510:26d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 10:46:09 +0000
Received: from DM6PR15MB3893.namprd15.prod.outlook.com
 ([fe80::12c7:cfea:e8a3:9667]) by DM6PR15MB3893.namprd15.prod.outlook.com
 ([fe80::12c7:cfea:e8a3:9667%4]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 10:46:08 +0000
Message-ID: <3efbd98e-95df-4c18-88d7-78b7f7cb1648@meta.com>
Date: Mon, 2 Mar 2026 16:15:55 +0530
User-Agent: Mozilla Thunderbird
From: Vishwanath Seshagiri <vishs@meta.com>
Subject: Re: [PATCH net-next v9] virtio_net: add page_pool support for buffer
 allocation
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
References: <20260302041005.1627210-1-vishs@meta.com>
 <20260302050013-mutt-send-email-mst@kernel.org>
Content-Language: en-US
In-Reply-To: <20260302050013-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::6) To DM6PR15MB3893.namprd15.prod.outlook.com
 (2603:10b6:5:2b6::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB3893:EE_|PH0PR15MB5639:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a520d9d-4b26-4183-2f39-08de7848e978
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 CWhBT2m3ZMvOoqAtnirXnnHRXP4aMce4wsccccrPaQNsiFLPkPvlRZM5GvMi0L1UWsy33D85Ne4ueIcLSyyHKadN71I8TDVncKltINQc9HNtT5bdLLOrMkS4197mObwmH9VkLEIfjnhG6aWOMDQlj6Yt9g0PcyVxDexSxM9eBeJ+DMbDnJYF6piY+NflEUdx9ywHRFYt5M87N57NAKo5APqRPfW8Ctl9nd8/ULSKrAidbD6jQu3C7HWUNxvLGkJN9E78FQvB10KtitszuDNpluF6E89V0ak4bgbhfTI8MUVTptxpxCyNSwTszVZH5JBgAUaKdtlQXqPaWcmJnBdI8McWGb7h5CQhEh3G6cV5+vPa8IBcWAB+esTIz/Vg1EvAIL8eiKTs9/QQIkV7uMLDAEMWrwEmhm+ms9XZHoIuVraKJUM93/uCDjN6M/Kc5LFzO7S/+QZktbNbuClBbeWAGQjjpR2P4EnLqdzZnQ0o4fludFxxEN2eo/qFSFGT+jt0vpYpFYjUuuM7KpZPMbbgJ6heO96/HP4PGouEoRf2s6jwhFz+j8UwLUXbHlFv5EuGTFfnWF0VBWF5UwpJJyPOJpa8uj6S05G8Adz1LASM70o/wYoOhREt/5TMKYjSV6Mzy1Et3cCu+RdJB5nxOTLGXpnRBa05ziFOvxL1oRGQCgNQlJiqMsWW8wlR21y3e5MfR4s0REn2mzrorkFROrI6Fw5C1SiBRKfilbgdznwAPNI=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB3893.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UjVPby95STFQREN1OVRnOXFnejZoQ04zZWpSa05MVUw4YVpHTm1OSTJTTXhx?=
 =?utf-8?B?MUxzZEVvREdma0QySVRsM3Bkd2xUWHhoQ1M3UUJKQVNwZUt6RnVtRmpGOGt1?=
 =?utf-8?B?VEM1cmRWdmZqei9YRnp0bWZ1MlgrRHZ2d0Vrdno2WFJDeGdEM3pJdlAvb29X?=
 =?utf-8?B?cU9wMnRtYXVvU0ZmK3FxaUcwYnUwS0RPclBseUR3S2VLUDhFWTgrQ1Z0TElY?=
 =?utf-8?B?aUgxZzU2SXVHalEya3JOL1dCdE5LV2FMSUZjZTF1VUpEZEF3aW5odktGQXdE?=
 =?utf-8?B?WGwzWUV3Tk9Ka2pJdnhjbENaMFNOVUdnbkNFWnFmbW1IZlZMOWIxQnZ5Q2lQ?=
 =?utf-8?B?T2x3S2JsWE5LSm01VU9nZERVNkJid2hEdFQvbVdrbDlzUDhGbnVYSlVnbUMw?=
 =?utf-8?B?bnhDUjVLVWhtNUdoWGRrOHJpYy9Md01hNk5mTWQ0UGJlL2RaYkdkc0FIYm5Y?=
 =?utf-8?B?USs3ZU42ODVmVi8xakhBT1B3RnQ0VVVLOU9ESGNXNjk0enR4dUkzWSs1Tlky?=
 =?utf-8?B?azIwVnNwbTJDTEt1ZDhZOHcxNjgyWGlDZVdZMUZXSm4wbnFrZE5mN3QvR1Zt?=
 =?utf-8?B?K2pLa3dWdElPaTRLU3JHdnUxb3ZYQXRORDIxWGYzUGg5ZUpEcXJqSzNrNlpu?=
 =?utf-8?B?Q2dLV1NNY1FxcSttcWU5amdMK05FUUlMRkhmZFgzaXZCT2RNcTNDWHRGUnlV?=
 =?utf-8?B?WEJwZ25PUnlPN0JqcW9BQU1ySVpZbkhKUVFWM25RRjErbVpCaHl1N2kxakJV?=
 =?utf-8?B?NlcwajdCWk1HRXRld01ZMWhmczk5OVZCWVRFZUd0WjFKYzAzYS8yTFhEL3VS?=
 =?utf-8?B?YlhpVC9OZFo4OHB1UGoxcU5nQjdVeDluRXNDMlZyUGFBLzAvZUNReXNDQkRC?=
 =?utf-8?B?ZkhWRDRVTHpDYXJzRVZWSHZDSkRWZjYyazJqRXpZVTNkMVFoMTFwK3lkVGVI?=
 =?utf-8?B?eGVzWUhWd3QrbDFuVnJBK0RYZjBHRHBra3oxQWtNRllZbVV4dEpydU04WEw4?=
 =?utf-8?B?eHFPWS83b0hObFNMNlAxc0NPTnpYd1A0bFJ5WlJqck9vd2xaQlRLTXVXUHEx?=
 =?utf-8?B?d2pnSEI1RWxkQzAyL01wWGFmS2dzMFBzd2VDMyt6UDcrWS9PSlZFOWtraG1O?=
 =?utf-8?B?RUVNNnZBc2xCeS83U08xY1QvTEtsL21LZmZEYjZ5eHRBL0FiVmVOS05FRjVx?=
 =?utf-8?B?ZXpWSTIzYjhOVEEvYW9kOHpPamI3a0x3QWYwWFRoMHhYbCsydEpOMzVTVTRz?=
 =?utf-8?B?RnV4WFVRV3dwaGZ3VE9TQWdtNEh3TEs4UnR1OEcyYmpVckkwMnlCUjcyU1U4?=
 =?utf-8?B?UHlFc3dCV2dmVHNUWWsvNTFoNDRCV2tEcGNRanZGQURLYzcydnNUR1pHaVFE?=
 =?utf-8?B?eUFjNjhjRmpWQ0dwako2TERXUGlIOE5WNnpSUU11K3ZXOS9VTHdTc1duQms3?=
 =?utf-8?B?REdkbXlvY3gxSGVISi9GclBSOGIyT0M3ckZ6a25QdUJZYzdUekdMVlNCTjRZ?=
 =?utf-8?B?OFJqRjJRa05VclZyblhOUzV6QW1FTUZ6ZXlENllCUm53QmRFd2dNTktFV05Y?=
 =?utf-8?B?bzNlNkZCQ252THF6UXJyVnQwNG4vR1NnRnBGL3lFcHczbFl6MldRVjl6RjhK?=
 =?utf-8?B?QUNFc2dqblZleEJTblB1cksxYTd1ZHJyWTVxaTRYcUQ4RHFSUmNsbHB6TlVz?=
 =?utf-8?B?aXhuejRLalk0cWUrbUZqRjJCaUxJTUR6VXZzWTJBZk0yY3NMbFZJb0hlNWpl?=
 =?utf-8?B?aFViL2trV2t0TFBjekV0Uk9JbEV6Mk5DOVVHTjB1bHM0VzdkOXRNZERadGM4?=
 =?utf-8?B?Wlc4SllHVFVrdHltWlJ1WitqVXBTSDdFMWhGRTVrNnU5bXhlQXpveTNQSVdJ?=
 =?utf-8?B?cmdEdjlLYW5XVlRzZW5adFdPcit2NDdSVnNjd1N3SVI1di9rZ1UxRHRPajJR?=
 =?utf-8?B?bjdVQlBTTEdjZkRzRXpORklBUXNjc2tsbXNoLzlaNWM2bnlZdkp0ZytreC9j?=
 =?utf-8?B?UUVzN3FwSFFJNVRWbXllNGh0cWRGMWxqMWFDYmRnNCtCNS9wUmNxb1VFdlRy?=
 =?utf-8?B?M1NjcEQ3ZjhoajFHa3U5UFpqd1RMRGR0cTN2cCtQb3A5ZUkxS2t5ZHNOZlRZ?=
 =?utf-8?B?UXRJUzM1Z3U0KzhVK3JQeDhjc3RlajcrWmdmSDVWVlRzWlkwRWFub0NNVTY5?=
 =?utf-8?B?d0hzQzgwRWQyRnFGOXhheWRnd0xJRWk1YnhtV3hBdFpmL1czMTkwWUJaeHdY?=
 =?utf-8?B?RmRWckhJdktIYmg2Q3RxTzFIYzZObXB4SGFKaVRvVFQzN3FRUHFPQStNQjZt?=
 =?utf-8?Q?hK2ZW1H27kpWrgm8zw?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a520d9d-4b26-4183-2f39-08de7848e978
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB3893.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 10:46:08.8383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CExVLmKUOAks11ztbYHV+owY96Z7AYGOufMeKhz9yDGqftv5Lmck7eCEzxKrpbjt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5639
X-Proofpoint-ORIG-GUID: vCCxNcB_x-Ux8rmqlZd6PgjKoollsieU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA4NyBTYWx0ZWRfX9WBGmfmGDUdM
 0HnGksrqyfNyfok2wsmUy3+plU47JcAVw3FGYEhxLag+WM47Rf1ynmxxGMxmjuR+ek6MSLR80uI
 28gY/xTMZnUWnA5iSg0+B/1Kgs17LsQhwWh9IEPlWQ2QFb1SP5FI2xFpEGLU1zCDyQEYM5szg6m
 ClmsvRlCXnUmX7CVAMBTdB5ZQrE5sZvZcSGUcP3q6rqVcZKYDFJPkYTRhcC4kwpL3BQ674edORM
 qvjVqOazDxCv7NHsqYJ/vQazrKgZFpCHJYbQEzaexfBcI0uWJooiPqpjXv16yTN4UGWv0Hebg+L
 48V7Kd6j3rFNVFLppXdsIR0WAQBjX5K5x09aOIAUUZF6lZztGJdQ7Y8sbR/Z88QVkS6CNPABdmG
 q1fF2Xu/wX6x3Jee4kOo0wA1bsYuqL1kx9Aq5yEr0/ct6dIO8stAsOOwjHLq9GzUl8ZqnLKXQfS
 X4mx7F2oeaRcL/bGn2g==
X-Proofpoint-GUID: vCCxNcB_x-Ux8rmqlZd6PgjKoollsieU
X-Authority-Analysis: v=2.4 cv=HYEZjyE8 c=1 sm=1 tr=0 ts=69a56a73 cx=c_pps
 a=Ja4avHF4q49+S+GKa94BQQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22
 a=VQpods1Hlm8uXEkVyaEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262611-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishs@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 462491D6D69
X-Rspamd-Action: no action

On 3/2/26 3:57 PM, Michael S. Tsirkin wrote:
>> @@ -2666,32 +2603,25 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>>   static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>>   			     gfp_t gfp)
>>   {
>> -	char *buf;
>>   	unsigned int xdp_headroom = virtnet_get_headroom(vi);
>>   	void *ctx = (void *)(unsigned long)xdp_headroom;
>> -	int len = vi->hdr_len + VIRTNET_RX_PAD + GOOD_PACKET_LEN + xdp_headroom;
>> +	unsigned int len = vi->hdr_len + VIRTNET_RX_PAD + GOOD_PACKET_LEN + xdp_headroom;
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
>> +	buf = page_pool_alloc_va(rq->page_pool, &len, gfp);
> 
> So this can increase len (for end of page accounting).
> 
>>   	if (unlikely(!buf))
>>   		return -ENOMEM;
>>   
>>   	buf += VIRTNET_RX_PAD + xdp_headroom;
>>   
>> -	virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN);
>> -
>> -	err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx, gfp);
>> -	if (err < 0) {
>> -		virtnet_rq_unmap(rq, buf, 0);
>> -		put_page(virt_to_head_page(buf));
>> -	}
>> +	err = virtnet_rq_submit(rq, buf, vi->hdr_len + GOOD_PACKET_LEN, ctx, gfp);
>>   
>> +	if (err < 0)
>> +		page_pool_put_page(rq->page_pool, virt_to_head_page(buf), -1, false);
>>   	return err;
> 
> 
> But len is ignored in the rest of the function.
> Will this not under-account truesize?
> 
> 
> If it's intentional maybe add a comment explaining why?

It isn't intentional. I will add a separate alloc_len variable for the
page_pool_alloc_va() in v10.

> 
>>   }
>>   


