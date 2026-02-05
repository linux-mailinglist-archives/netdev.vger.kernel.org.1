Return-Path: <netdev+bounces-256983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC75H+E3hGn51AMAu9opvQ
	(envelope-from <netdev+bounces-256983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 07:25:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B77EF01B
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 07:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 328FC30078F3
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 06:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97151350D6E;
	Thu,  5 Feb 2026 06:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="F1vFmYwv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8C034D396;
	Thu,  5 Feb 2026 06:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770272711; cv=fail; b=MaUQ+yc3MxYDJ+0CbOGvu0byONkdc9RpvUbSEWymksSoCUiEruXX3FjXkCEcU3Qh2M0jMHqK5ev5VRBSHvTe4vo1oe3kZR450suUo98SFFaxUeBv7ZB8i2t+f4pB692EVmJDLZq0UAtHzcxjKtCRW5t43A7l18kLqQL4gwiqwQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770272711; c=relaxed/simple;
	bh=u/ExEtlsGqKiLb4GbJNSR4q0UhOJsmgEgpEzoclSWqw=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MSqQWJUBecfO6eb16H+oNPGGEh33XpFPGA88mLB5dCD2NyepCfd4062Z0EEjut6walF/uYuEBGFO8exZ07lORUzNGk/LD9Y7GpfrrTxGd3cbtmDxZQ/f4xkCNFAI/OjHJVDV4liqQuhbG3qdvSlWKCu2tb286P2XZNCujjIBi+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=F1vFmYwv; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6151HFYA1818725;
	Wed, 4 Feb 2026 22:24:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=d1ra3w5WrFoY2A7/lUjKObb7eKotCfP8Ma35ncx/82U=; b=F1vFmYwv/abI
	DhNMlpJozow+ciBPf7sj0WqfngrYf6ul4hTaYqAabvN+jzgzRano3vUVkDJXrbtj
	qr950amN2xaZfKBhA+PquGj+tH7EI1hrokFs1M5YfZnNdeQxNXs26Yfsu9Tvkjuj
	ga7EJ8iPKTLwY1bnRvfcLWxvF+kx4ajCtuaSh6U3CXwpxxe6EAldtyXgQ2eFXIVo
	pyjXTpzyT/y+gVhufRAlRpYu5sm899gLQAoyw6XC0bUseQX+w5sczHxZW/XDVzau
	qWE9lfqRQ5TkVkPGhgAweDynDMT+LaheMGwFl2bcSDhvHBKj0vQRKQ5HAy2uCad/
	EKDfNnC1Zg==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c4h3e9wan-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Feb 2026 22:24:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9CZm4/VotNpGD/pMJxk1Yh8Ng/x7ww61x1UXzmXubgred8PBRLhYZboP6WRxDZ6mB+O2taMYjmTKSswlUulbc1A11vNUQ/sthLoj5RnHHGjKOQPr7EtSEVIrewi/Ck0TigCQMhl8imEw+hVzpDKOrzfcNSBT91oL5RyNa6TwC3NyHAzKE0PRd9vUP1Ao1ThlwEKDGQbExSe2LEEG8+wBj9/KSaB7AWVWzPH4gV9XYq4LbMuBkMX7huQ3dtapDoMYcqbQtpp8/JKIaOAa44083MVY/HiNOxCxQCccDlNvGRh5YaKbuhTGsWW3q500j+x+E3aCtMU60jlBgWHlEQyXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1ra3w5WrFoY2A7/lUjKObb7eKotCfP8Ma35ncx/82U=;
 b=sPkqQEeDXxPJFvTvuNAyheHT61FCQL4oYibZj1OLpdZewgYXXZZD5tJniTs2ICQnqQj0JlN9WibyDqCi1RXK0mpmgoZtm73YlEZZjYWi5mZ7wAEtA41KCazr2zstmIfHbmEiqT9nwPQQrimRNVsr2oaqxisV7A9s29RWKjK0kNB5LHzCljj8veJBb17ZVehJynHkM8Uzx0Ce/toM2buMnrYRjH+wuiy1aRKRUJ+A7ZWGMJ5AIXvtYdSRS4t6hW6WbUufm2lFym6z6rVoUh1ciSYKNsblD+XkrcWkFaFt/32VhcyFA2fRLvsqazqotWqwfgLtbIxbpiSYmexs+UVOCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BLAPR15MB3889.namprd15.prod.outlook.com (2603:10b6:208:27a::11)
 by SJ0PR15MB4533.namprd15.prod.outlook.com (2603:10b6:a03:376::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 06:24:53 +0000
Received: from BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044]) by BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044%5]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 06:24:53 +0000
Message-ID: <45f17fbb-9550-47fd-813d-008e647a3624@meta.com>
Date: Wed, 4 Feb 2026 22:24:22 -0800
User-Agent: Mozilla Thunderbird
From: Vishwanath Seshagiri <vishs@meta.com>
Subject: Re: [PATCH net-next v4 2/2] selftests: virtio_net: add buffer
 circulation test
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        David Wei <dw@davidwei.uk>, Matteo Croce <technoboy85@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
References: <20260204193617.1200752-1-vishs@meta.com>
 <20260204193617.1200752-3-vishs@meta.com>
 <20260204212511.017153cd@kernel.org>
Content-Language: en-US
In-Reply-To: <20260204212511.017153cd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:74::31) To BLAPR15MB3889.namprd15.prod.outlook.com
 (2603:10b6:208:27a::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR15MB3889:EE_|SJ0PR15MB4533:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a469096-eabe-4eda-bd05-08de647f461e
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SEovUzNTYlZ2TTZod21qeUdqZ25yYjF1N0hQWG05UnkvNEJZNUYxQ0EzT0tx?=
 =?utf-8?B?eUxqNHdzRDJ3by93MkMxdzBKVU9oWFEwbWdzN0lKWHNNeGEzYlpnMUZBTkpD?=
 =?utf-8?B?ampKTzVLMlp5NTJOQ3g4bzNFRjhjVmEwTmdrejVUYmFOOTlXOWhuVVVwVStG?=
 =?utf-8?B?eVZvZ3Qzdncwekkrc3RFWWxLOEtQZ0VaSGdLdnJLNjQ0Rkx4VUtFa2lUeGFh?=
 =?utf-8?B?aHdhdVFRc3BSN3JlMXlUbWRSQlZMMWJxTEsrWm5QRGlYaThCbXhVZlBVUVJF?=
 =?utf-8?B?SmRwZTdOeE9UekVrRWhGRlFrVXRVUXVGY1BWVUdWYXlKcHpPNG5yY1RnK00z?=
 =?utf-8?B?bis3alFhZmFTeUlwMU5CeE9xdnNQdnNZS21CbTQ5NkRsWkxZSzZyNXFPb1pE?=
 =?utf-8?B?eGtyMktObHlZQ3MvOXdLdVR5Tkl3Y2J2MnFIdmtYcyttQ0QvUE5Vc0VmK1lo?=
 =?utf-8?B?U1YzMjBvQS9taW5pQUhZd1dyOE0zKzBRYlMrVWlaNTR6VzZvVlZTUFN5Mnla?=
 =?utf-8?B?QlppcTZZeHZ3ckhJbHJOUkR3L0p1NlhkNmk0aUpXVTU2NzlBVlRIQkQzd1Vu?=
 =?utf-8?B?MExIWWN5R1B1WTVqSStmOGlraTk3MG5iTGIrK1plLzhYeFU0ZWFzUHBudVgv?=
 =?utf-8?B?aGQ3OE9PN1djRFNxT3UvUnJaZVVwemR0K1V3Y2MwQm9GSStFWWZwL2x1YU5K?=
 =?utf-8?B?STZuWEJna01SVlMyUlBqRHc4ODU1RUZJejdhOXNKZ3o1Zi9aUVVGclFKaEk0?=
 =?utf-8?B?Mks3ZVhDblY2QVFDQjhqNE9JYm1Eb0x5b3RBTFhKc2R3aTFicUYyYlJPTlE1?=
 =?utf-8?B?dkw4cnhIRVNPMHM3ZUdjcHl3TUJPYnhCNmIyeG45ZkVWMDBxN3hvdnlCQ0tG?=
 =?utf-8?B?dyszRjZZTUFJM2JaTWdZSkhmUlU3VTg5Z2drOEF5dTlTYUdSdTFFekZuQU5Q?=
 =?utf-8?B?WVRYT3Q2U3lRbTRoRit5Y0hGSVJHdUUzZUVlVVJHRFk0Uk9VVlh3VVhxQy9q?=
 =?utf-8?B?Tk1tdmMvZWI4N0EvLzF0MDlCdldCSHh3ZlYwVCsxN0tSVjlrb1luWnFvTGpC?=
 =?utf-8?B?bkRyVU1vRmVhYW8vbUpPa2kraklFK3g2czBGRHVxeTZkQ0dhNHhIL0tEK05L?=
 =?utf-8?B?SnhlT2VnRVRqVlYzUitUTlZ6bmQ1UEVlVGN0SVJFdjFmUUE1N29OSzN6eEZy?=
 =?utf-8?B?TkFsamFrdGRQNHFtaTRKYjU2THpwVDRXdmhMMU1HSG1aK090YnZkMXMrWmtB?=
 =?utf-8?B?am5FK3B4ZjFTaDMwSXZKRG51b01VUDZVZk5CL05iNTZHSmtPcHJvYzdmSE9y?=
 =?utf-8?B?cDA4eG9tdDNoZHJCZG40VFNMUHIvd1ozOE14bVk3NHVvQk42WDFaMEI0VFFt?=
 =?utf-8?B?VDVRWjdJQ0M3OFpxRjJmSXdCSHdXS3VhNmZPOXNQdUQ5bjV0bC9NZTRJaUtj?=
 =?utf-8?B?bWMxeG50UVNlYjdLREdJZnRSYVc3ZHc4S0tPVmUrdnZia1JJaExsdG9PY2lD?=
 =?utf-8?B?VHBaaTR5MERRNjR3NHJ2S2tvR1M1YjR3UlR0SG16M3NKaVdzVFNvb1NHRUJy?=
 =?utf-8?B?aTIvQnEzc3ZjbmFzUlY2UmxnaWVwWFlYRlRIYVRVc01sa1laangwNTcvVVgv?=
 =?utf-8?B?SWhOZ2sxZ1U3d1lrbXlhUVBMQk1MV3lRRC9wdHYrczA2ZEZ2OWl3N1BDVmNG?=
 =?utf-8?B?aVpjY3ROSzVmbzBOUjBBbEs2NHJ2dGdnTnZhSlV2YWZkM2hlUnNIYVNOM3RM?=
 =?utf-8?B?bDloWmVpTXNQS1g5L2VVckhXSDJBMzd5WGtUN1RBNWRueXBLMW52ZmJHOHZK?=
 =?utf-8?B?UDJWVHozV2lWVC9YVE5LbTl5K1F2djd4ZnZRME9qZXlIQkNMQTFpM2lMb0FH?=
 =?utf-8?B?N0F4V3VRdXhmY3NJN29jaERLUHdoNUtOLzhSWVZ1QXQ5TFFSdE55Yy84NnZF?=
 =?utf-8?B?dUZ6VWVOdGpmT3dxaExUbjRlWEhhQVorc05ZRmo2NGNaOFByQlRDSllTNG1L?=
 =?utf-8?B?U3Q5U2dUMW5HS3ZLL29nUUdUMXhHN0cza0FNWUZLYkJzeXkydVErUElITVpE?=
 =?utf-8?B?OThubGtaY2VyMjNiTXI4UDVjbTJzNWdXeGpBYSs1VkgwWmEwU2ZVZEt5d3JT?=
 =?utf-8?Q?w0Jw=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR15MB3889.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?KytCanNPZllGVmRWRzZkWmZCWXIrOFVTZzlMa1prampHbHV6YUtIaUlYMkdW?=
 =?utf-8?B?OEZLU1ZJeWQ4Y2xlUGhoRmw3a3ZET0hibVRkeWF0TTdITHZKY0VWVCtURjBJ?=
 =?utf-8?B?S3l3bnRoUWxFTUp5eWFLanhGV01mNE5SZDhOTjI5T3I0OTRrQ2hPM1ZOSHhH?=
 =?utf-8?B?SEpzbVBIMUJCbHZXK2t0ZVBkUXo5TDBxRXZRY1pYaTZpanl5cmhBZjVpM2pL?=
 =?utf-8?B?NlRyZjdKZHUwVUdydGUxbGwyeldRWkVSM0krRjdZTW85OGIzR0YxZVRPdmV3?=
 =?utf-8?B?Q05NRjZnY0duSUNpOEpzZ3RwVmJ4dFBXeFdyVUQxcDFKSzN1VGhRdDcyamd0?=
 =?utf-8?B?enc1d2xsL2xRMUtvem1rRVJ4a3JYbWRnNkFyQ2k2V0RkdTBUZTFPY1BBWDV4?=
 =?utf-8?B?NjFzOEVmYTE5UzA3Vmo1UWJ6WUMvLzBMNkl2ZkpCVDVhSllyTHc1aG5BVnR0?=
 =?utf-8?B?dHlmbnZ6Ymd0c2RoSVJ5eWVRZlVLMDI3MkRNQ2ZJU2UzcUd3WUpEbUZkcDdy?=
 =?utf-8?B?OVB0cDlQcDZOZ3IweStGelZDOFArUi85TU1rSURsUDhtWUNlKy94MWJXcVhP?=
 =?utf-8?B?bmVFQjZiN0FOakVNcm9tVnBsdHNGcVEzbUNqUGc4ZU5uTFRjd0JmdFZDK2cz?=
 =?utf-8?B?WjRxNllDdndrajIzeEhYZWtkb1AyZHArZDFwYkpvdGxRMk9jbHJKeGZWWmFL?=
 =?utf-8?B?S1p1TTFnOXJKTTJpWmU2NDhwOTI3ajVSRFVHWmNBTlpldExBOER2ckpWN3U3?=
 =?utf-8?B?Q2t1V2NwV1VaNFB1SGNaM0FndU1wVUw5S1RteWt4bEd6OEJLTlFPRFhOallN?=
 =?utf-8?B?TlNPM25wS1FRb0R2dkhBQVlCVG9uWms2Qm80Q2Q2emZJYU1aTU0zNTdndm5m?=
 =?utf-8?B?enQzME82bjNwTEoyTHNEaTBHeWRpa1M0cGxsWFByMHVZa0VFclJqOEhUaXhh?=
 =?utf-8?B?STVuNDg5ZlhZbDcvaDN4NkVNNWlRajFPZW5uRjNQMmVvSmpyNlhRaEZqQjRY?=
 =?utf-8?B?SE4xZk1FbnluVDZtYThyaGt5V3pBNEg1SDNPZGdTVHIwcGF1UUoySS9reHZM?=
 =?utf-8?B?bnJoWGhXbnNPcm1IeU5WcjkxNDdjVkRneElHSTYzVERabUNqUzNXdGI5S0xr?=
 =?utf-8?B?djV4ajBjVStheTJ0Z2E3UzNIdUswNTlLZVo3QmQ5cmRrRzJONGRucWprMXFu?=
 =?utf-8?B?QjNTSUNrRCtrendFK0g2bzh0V2E0MzNWbVQvWkRTT29sWnBsQkVDYU5NNTZ6?=
 =?utf-8?B?eDFtNTdIVjRlWG1jckNaMjVYTFdURW9LaVBMVVJvNUllUVNtaHlmTlJ4ekRD?=
 =?utf-8?B?NjYxSFZzUU92QlBMT2p3cjRZai8vMFI3VDNGekhmNG5ITS9Ca3JqZW80STlV?=
 =?utf-8?B?eXVNd1ZzQmRzaVRYcjhGK3M1K0FQVW1vdHNLVVRBZTkwbHA2UmhZbDRyK3Nz?=
 =?utf-8?B?ZGV4dnpnd3k4dXlxVEViQWVkNVEwR29sZFd1OExUTkZWUm5RNENza0Z1OTZV?=
 =?utf-8?B?aHVnWkJXZ1RZdm9EZmc5ekxwYVoxVHh5SEdyN3JlWDBBQ2Jjcyt2d2NMNTZp?=
 =?utf-8?B?OC9NV2VFQ3hiY3Vyd1U4ZlVFdVk5elFaRVlCU081UnZJZVAxbGVIMFd1aGZs?=
 =?utf-8?B?N09nZlpqU2ROTksyOHRKaGt6YjZtMkl4TlZaUUxaY2g0bmYwc3cxcytRVCtD?=
 =?utf-8?B?Z3NReDJzbTFTb2ZUL1lSMUQvSzZTM3hscFh2NE1WbmdrZHdvR0FLMEg3MUZ6?=
 =?utf-8?B?cFVNSS9XdnRkNktHdzRtSjFNRDlMYW9xcWNsMGhqTEFzL1BUZWJxVnhaL0M3?=
 =?utf-8?B?dElacXhzQjFDekI1RCtDYkRDUzV0TW9maWFjN0c5bFFhaTFJa2VMVEU5QXE1?=
 =?utf-8?B?QllUVmptTUtZTUlmMWorb3lkSkYrWXI1S01ENjA3ZXV6VlBCQkNRMjNicGJl?=
 =?utf-8?B?cmltYUtWQmdQRW11T2tTb3JKcDNGVG5wQ0lOaFlGT3Jqd0FvZ3ZDVjU3MFAr?=
 =?utf-8?B?QmZ1ZUcrTWc0cnUzYnpYM2tMcFBhNTlXaGhyMW9IQi8zdnpVcllNRmk3c2pU?=
 =?utf-8?B?Y3pKOEx0VUg5d1dLM1dycjdjREM0OTdlSkZtZEs5d0hqYWU1TU5rSmRjU0RF?=
 =?utf-8?B?ZFp6Q0pTOWh2b0dJU01jVFFrUHlQNndvT2RrMmhnbHQ2NVdqVzdzc2Y5dUYy?=
 =?utf-8?B?TEVYZzhDN3JiUGlTSWdqOVZoS0lzb1dsamhZcktqb04xVUtxRTJtaVlpdmll?=
 =?utf-8?B?OC9CbXFDMm1KbW84am5STmd5UUNGWTgzdVhZQVFRdXVvRk55eGU1eU5TOXhI?=
 =?utf-8?B?d01uanhQYThiQ3hvcDVVTGtNMlY4dkt3cWRTd2ZWNjBPYVg1M2t4NXpOME16?=
 =?utf-8?Q?TqUkgGD67LgaLls66JpefmDey+CHOgNgf560a?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a469096-eabe-4eda-bd05-08de647f461e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR15MB3889.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:24:53.6417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M5aDnsj6W6UyBmSopAwwZTZUkl7f3ibZ0VOfdXO8zfwZMT0c1B7PTcIliU3YkT3P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4533
X-Proofpoint-GUID: GzhmmffF0acmt3s3bQjUbOHdKLc4ZojD
X-Proofpoint-ORIG-GUID: GzhmmffF0acmt3s3bQjUbOHdKLc4ZojD
X-Authority-Analysis: v=2.4 cv=TeGbdBQh c=1 sm=1 tr=0 ts=698437b9 cx=c_pps
 a=UyUtkpB65yKBl9uddpDweA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=HD48bZuOcb1G8hYhV34A:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=M91JV_wKSCcA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA0MyBTYWx0ZWRfXyPUCD62EdnFZ
 wIn2GJfuVX25jDckvS+5Rp41aB7JgJ0J8PI3u+8E1LPjX6LEvC/PWceRWum9aoKRD+cqLUPI1yJ
 Kg4QOEWvqbvdDudIHO/hmiAaqvJEiBnscVLBZ9WPgnSKoiQY64QBSRSHQfoKUUqc16oANKKsq16
 fzHj5zRXhIjz73j4FTSzFbi2HKA2CH1mF0yBGFqHJz0Ad1WFP0Py0UmvWUs5H1Cg+FmOU3C7AeQ
 d/AihUYoR+/gAPlGP0yojYzLsQ0dDptLKxUTokZCKvNVwd/i0jrTUpJpZrkLaVq7ub6vyDwSvmk
 szO6GRSL4ROcqCcMBTOktdLsp73vCPD2pACqEyleFGXTT3294vJqh+upsSGndXClx4bKWfzQt52
 sWXSJnk0Q1ntkmG88mmfiEgqgR5V7EjKmHxozQ0grBBpVtH0yJOtthosBPY/zi+S4S8Ul+Co0Fx
 gnZfqm4GIiVqW1Ung9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_08,2026-02-04_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256983-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:mid,meta.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,meta.com:server fail];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	DKIM_TRACE(0.00)[meta.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishs@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E1B77EF01B
X-Rspamd-Action: no action



On 2/4/26 9:25 PM, Jakub Kicinski wrote:
> On Wed, 4 Feb 2026 11:36:17 -0800 Vishwanath Seshagiri wrote:
>> Add iperf3-based test to verify RX buffer handling under load.
>> Optionally logs page_pool tracepoints when available.
> 
> TBH I wouldn't bother with this.
> 
> We run full battery of driver tests in netdev CI, there's not much
> value in a dedicated virtio test that just runs iperf...

Okay. I will remove it in v5.

