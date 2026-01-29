Return-Path: <netdev+bounces-254580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OK96FlX0emnDAAIAu9opvQ
	(envelope-from <netdev+bounces-254580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:47:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7731AC090
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA3933012CCE
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 05:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66D1303C88;
	Thu, 29 Jan 2026 05:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NlvyYxPS"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E970830217A;
	Thu, 29 Jan 2026 05:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769665618; cv=fail; b=JNDnVhQfAl1yQokSee/ybJdCAel4TxP2tGoCUYsZgtx/8a1WtllEfg9eWYdfMG6lD3D1nFOJc9csJ3TJr3TC5giBSxZCPUtGecQO/vEpmR7t3p4nzi6PLUvQpA/AS4DMZWj4dMff5t8Iu7E99WqFT0ug2G7cjt2TxtN2/qqMads=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769665618; c=relaxed/simple;
	bh=2/oJ22D6i81bQM/Ar0korn3vozFYA8P8tFy1G/nfFL0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XVXVcQAuNjJXuvkULPLZb/BNlx5KWYagrsdJAF1d8DUtjlMF6+qHSVUb5Cbmn2oS20/chBoXjLp59j74BsHdjkjdpez7NRStIbXjj8tTSQ53NRTPCsbxizhNfyGBnIa1m+4d9wU6gKzY9GXgl8FzQwOKtosFDuLHHANM3lwWgKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NlvyYxPS; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SMDXvp1301476;
	Wed, 28 Jan 2026 21:46:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=AvzPKwYiH8GKWQ3RR3vB8fSDOS1UrVG9Pr7LPhW1SEc=; b=NlvyYxPSGxI6
	VRlFwyvmlcnmxKNPKrpLupcAWYfdznnyVgUK+aRsyIfnYFdS2RJaDuP04OLn2vw+
	OWzJ3Txqv702mMfOk/tCFF06+UBTNFPg2UJjkw/h5T1F2Lo6QZuudzMy4OoIvTth
	bcPs5CXixBjVy1kYpJxa4F6UVJ/OHxexkVzmMGQZ5hLug550zEFtfTaoOHJvacdw
	ZfSl1wcpEHclWJhowQ2q5ygQ7l4HScB2/JToWKqPGOOSH8596M9vwZYLdKHNP3Ym
	qQOHD5+c0ZT3YxGmfXH8TBw91igygVhy5JDDu0sUMAHu0ySDlEC33DE4KiomqdPh
	8VFL/mgNnQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013018.outbound.protection.outlook.com [40.93.201.18])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4byu2e2xrg-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 21:46:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7iNC/N6PWJHoDi6FW8VR4XYzlaJ5XdViKAWR3TpDTayPislJMh55t3leUlDgNXV6IfTWFxhyY8q4jWY2hS3lpoQlAxlNzG0abGqEKJ1dG98YlBDG7UPJUPO9Kxu9UIAtBmaGfzateso3R0cylKrIyT5AGDb7WD9Svgd6A3JGOKzeVa2fKoCOQrVQErMSUc5+565ZocipKRtYhJIc67RLV55MXQndb5l0V/pSHVH0BIrT3IixgoWlX8hl0vd0ia5JEZm5ELBjNxhA2lopv5RC2OFWZivWF0/CcpdSDs/czjiixEi29Yd2FXmv//3c2lxRpN4zxjcm8bi1SiitMmprw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvzPKwYiH8GKWQ3RR3vB8fSDOS1UrVG9Pr7LPhW1SEc=;
 b=iUcMY4QfmQW8TZ7A6DMKkm4z7IOKtxePOaY1P7urnScKbYoYioHLMpW1/Ew7lDUrISmAhomlak4f48PRnvaVD6GBOifH+5JD17eXi0u7OAlQSoSVdUKRx169M3cb/t5LzfqVVUXN/im+p8YqR5wMixNc3QpRM8UctaaJqHi2aNeyCudY/rYt4QH+BgfoqRRrj7l+YGYYj5Dntqjqu/YkbE3u4ShFWwzUCLOCKp4XoGb8NbBCf9ugjO99zlRPJHEFfYi2y3yA92SrVyRCRsOVxEVqWoQtsDwHrKMsG+h5cRVsTeS+luThg4M15xc6U9EGEPIk6a9XhTAJXmtLb5fuPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BLAPR15MB3889.namprd15.prod.outlook.com (2603:10b6:208:27a::11)
 by BLAPR15MB3955.namprd15.prod.outlook.com (2603:10b6:208:274::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 05:46:24 +0000
Received: from BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044]) by BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 05:46:24 +0000
Message-ID: <38412fe3-76e2-47df-91d6-4815982742ff@meta.com>
Date: Wed, 28 Jan 2026 21:45:34 -0800
User-Agent: Mozilla Thunderbird
From: Vishwanath Seshagiri <vishs@meta.com>
Subject: Re: [PATCH v2 net-next 0/2] virtio_net: add page_pool support
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260128212031.1431746-1-vishs@meta.com>
 <20260128173737.04277eeb@kernel.org>
Content-Language: en-US
In-Reply-To: <20260128173737.04277eeb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0362.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::7) To BLAPR15MB3889.namprd15.prod.outlook.com
 (2603:10b6:208:27a::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR15MB3889:EE_|BLAPR15MB3955:EE_
X-MS-Office365-Filtering-Correlation-Id: 42c53d01-0e9d-4f44-9976-08de5ef9bd05
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bHF4akphV0NEdVdzbDAyQitvUzJqS1k0c3N0QVZMOW5JWU5ubHZ1d1NtN1VL?=
 =?utf-8?B?aWoyQ0lwR2tIbWp5RG9wektEUVdzalhkWG51OC9sUkZKQlVpZ3R2NHJvWDdW?=
 =?utf-8?B?Sm1Wa2piQ0xFdERWdURnWDhmS0UvUUhoMUpWUFZlajU3NXF0eXVzaE5xKzJN?=
 =?utf-8?B?UExNbGhKK0JRZ0Z5MnBtb2IyS0k3R1hYUjZGSTNkSm5zaVVwREt4ajJzRDNY?=
 =?utf-8?B?UHJJMlBHanJxOXpGd1RSeWRKU05PcU1lV21ZeGU0S0VHblplU2NlTUNzSzNu?=
 =?utf-8?B?bGFjOVZHbGRoUkNob1JqSm9UMkdpcjdpK094MHA5djZrVFNrU284SFZYVWQ3?=
 =?utf-8?B?MFVnb2QzU3lTRXFpSUZ5UHZvZXV0ZThmVzhmMU9Vb1JibzVGcVR6NVlPZDBn?=
 =?utf-8?B?Zy9wRFRGUW5uQW1zUGNrTXJURVVib2Q2U0dveFpZKzRWVDIyby9weTVWcHNh?=
 =?utf-8?B?UFZQZU12cDY2MUZZazRLK3BCc2l3cHA2bzlpYmNmMVBZRThYSWlmRGtDOURS?=
 =?utf-8?B?YkFvRmpodXFuNU1EY1Ura2h2ZjBmK3RXdGZpMlNmelQ3aDJuRjQ0WVMrTC9J?=
 =?utf-8?B?SkZhR3ljLzA2UVRhOHNNWHhXM1JrcWFBZ1lFZ3hhVFZFanZNVm4wUDZya3hR?=
 =?utf-8?B?UFIxZWN4Z0FYVFpXTUo1aTF6MmZoZysvelhOWEFmajVWSjNJTFczZVFlRVp6?=
 =?utf-8?B?T3FIb05HYVYwMU9Dc3pGM0VmaGlXcUh3a0pLWDVrRTZvZkJoaE1XVkdNOHRz?=
 =?utf-8?B?Qm0yTnBIQ1ZaWk5IcHRsTUhBOWJOVnhjejV2aEVEZjZ3ZHUrSGF5VTdYc2xZ?=
 =?utf-8?B?a3o0dlBzc2dwVEE5ODIwOU51ZHYySDdscGR1L25Editoa040QVFMMmFLc21P?=
 =?utf-8?B?ZW5MUW9OemVxWnBTcTBwY2liNXoxWEJWS2FDWWJiUmlBK2Yvbm4wc3VocER2?=
 =?utf-8?B?QnlnS3MrS2JaeHVPd0FvTUNNbGdtV1Fpdk9WRjhXcWQ4M1BnR0psTEdYMWw1?=
 =?utf-8?B?aXpWWGFDMG5lOTl4Y1U1RlMvVWNzT0RxY0ZyUGRkQVBlM1JKaHpMVUMrSkF0?=
 =?utf-8?B?b2hpUC9XdjB0Tm5XM25xWjVkR3ZvcW1uYVg0RHlveEV3cXEvdjkwOHgyYktM?=
 =?utf-8?B?UDFlVzkxbW5ERVdzcm5jbnRGNWg2SE90UlMzNTdNaHZ4MENjUWMxTXB3OEtW?=
 =?utf-8?B?U2NIWTh5TlFpWmFnUGVIUHQvVG44Tko5SzZzQVNHbDh2dDBWVWpNbndMYXBC?=
 =?utf-8?B?c3o1NEVmeFIzTDBDdlVlMGkwZ1NnbHhRcEw4cXJ5QTUzQitESmY2TW8rT01J?=
 =?utf-8?B?TUNWai9FUmp0NWlZM25RWGtoVHV5eWI3SmdFS1ArUHhFUEIvS0xKOENlTHZn?=
 =?utf-8?B?SFVtbklqTHZwRWxyWi9SaE1WemhQYmpVY2JzVjFydUJCaCtxb3BCODVLaUVD?=
 =?utf-8?B?U1EwQnBzUVlFc2N4UEVDYzZ3eFlxa2EwZTJIREV2Y2JwVzV0eC9tOWcyemxN?=
 =?utf-8?B?eGRFZ1hYQXJ1Uk5NbG9tdGhrK0R4bU9MRkQ0eHQzbGdBVjBBcW1RcU5MQzRp?=
 =?utf-8?B?UUo0ZDhtWWR0bjRLaVlzcUc3WjdaaUVHbHpSdnRadzcrUVNFTXk5N3JsWkhn?=
 =?utf-8?B?ZUZnd0JsQU4xYXRMT3dtaEdhc0pPcXY5Qm5mTVMrcEU4djFJZlI1amNHSXJS?=
 =?utf-8?B?VElCUXJERHNPbFVUdkJDOG01aVF3WEkwbjNhQUhjRGhKeld6TEtyYVFyRlVy?=
 =?utf-8?B?OG1tWE10RmQ5NXpXS1ZKaGN5SGtpODBrZmtva2d4N05tTU1ZVHhZZzlUNlUx?=
 =?utf-8?B?OGh0T1hJVG1PVXZUREY5NkRleHpiVEJaOHUzUzFDMFF5ZkNHQzQ2UnpkV21D?=
 =?utf-8?B?SmJJQllETWJkbXNjdU1PeGlnOUQ0d2RGSkFra0I1c2NFdDZha3NjcWViTXVt?=
 =?utf-8?B?YzZKalVRd3YrN3ozSlR5K3U1MXhqcXZWallUMjhyaGw4cUlSUGZwTWZlN1Jp?=
 =?utf-8?B?ank4dy9tT2tXWFBONVNWbUdMeFBpUHhsMHd3ZDJKU3VzYkt3TkJFVHVBaENt?=
 =?utf-8?B?eEl2dGFkcTIyS2E5dTR1b3hQOERBWXBQWTQ1eHc2cE51dktFY2crcXFyb0Ux?=
 =?utf-8?Q?Iiwg=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR15MB3889.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WDdCUmhwaCtSb2YzZHAzV3hETHE3VEpnbGZkVnFXc0owcGRNM0RHTWtKY2t5?=
 =?utf-8?B?RmtIYVFqYkdBS1hLanZEL1lQR3VjaG04NEYyalM0Z3FFY0FnaHZ2MEZQUFR4?=
 =?utf-8?B?Sk16UTJ0aVhWS2t5aWxlMzNxSENSR2hwejhFaHR1aTJZUEZ2WkVaMG5MNnds?=
 =?utf-8?B?ZzZJVXFMcm5NYkhFNGlxWUtxRTg4alhNSlJlWHBsMVZ4dEMwbXlNdWxCWlJh?=
 =?utf-8?B?UVgyeWloWUdybkVkM3NxeWtjOGwrQTVHZ1Q3VmpwRXdDOHpQRzBXaGlVQk05?=
 =?utf-8?B?Yk9zVnJQMWpPOEdRUTg1dXVmZmZseUlNWDdzUUxmaDRyTk9QUlg4REJ4Q0l0?=
 =?utf-8?B?WTREazRrMGlia1V1SGxac0wxZW14c2dOVVVrVGpBZllTelNhUVV5TlVWeVFH?=
 =?utf-8?B?ZkNkeFM2YmdlMXVuWjVQRkt5NlF1WEEyQVRwQjRmNlA3ekIwNloxVHJlaS9W?=
 =?utf-8?B?enJzMm9QLy9PZHlSRXJZdmcrTEdRQWFzdmpDdkxQbEhrQmtLWHAzZjdUeHhQ?=
 =?utf-8?B?dHpuOCtGbUtmN296eC82K1dRMzRhZnk3S1VQanRtaXZTWWVGNXhpSzBaQ2ZE?=
 =?utf-8?B?bG9IdHhkd3Q3dXRUaWdISGNQQmUrYlpvRXZWOGVwYXo2MDhyaWROaGtvZVJJ?=
 =?utf-8?B?NDlzc2xJUE9waGtmeTVNdUtUMXdFK2RiTjI1WXlGUzRoUlluY1FGbzgvT1FT?=
 =?utf-8?B?NDJpVVQ4ZHhSdy9wMWpValNvd0VZek9ZaGVLSjFNTmVIVCs1dkxvdXptQzY5?=
 =?utf-8?B?am4vUDdOWTVmTnoyNDZaUnIrZmJTL04ySmRseXpCVVQ3c1Npa0dlZDdmcVI0?=
 =?utf-8?B?V01ocnN0b2ZRTTNLZ2VEVGZ2YXJZTHhWdVNMd01LVkhjelNodkNXM0wxdHVq?=
 =?utf-8?B?UkRRVHJPNEVjQVkzL1pqbjlwUFZuUzhWT2duaCtOSnJoZFlMZmNMMGVhMUk5?=
 =?utf-8?B?Vk1mZUxDbzA3WDBiaTg1TnJFZDlUYmZqUHFvY0oyTHdNMzROcDRvS3ljOFhS?=
 =?utf-8?B?VlRDZUEzOWZZZU53QVdUTUNsenJkTkNhcUhrNE40Z2lhSkpFbkVsSTBwRlc0?=
 =?utf-8?B?bktETVlSVnEvcng2Yit5Q0RUaUI4a0xQYzk2TDM1ajVqR3JjREhrbDN1eXZX?=
 =?utf-8?B?RjlhczF0QnlncHNMdnZTVDliWURQbWx0Qko4UzJiaWdNV3JQY2tuYkVTUG1n?=
 =?utf-8?B?Mk54VGI2a0JNazA3Yi9jSjl6QkxtOEFka3o2NjB0NUVtVW9kYWxhWTJXVnlH?=
 =?utf-8?B?TkdkRGR0Sk5XZmNWcDZaNWtkVGZ2TGVmZ3FUV3hWU1JZOGZmTTBSeDl2T1l0?=
 =?utf-8?B?ZERpSk5BNjRNNnoxVXR2OTVYcGtwTkFpdGcyYk5ua0tuN3RjWXhOdHBZa1FV?=
 =?utf-8?B?M1BOR0FtMGltVkZUK01VWFNUYWMxMnpMMUdRREdJcmhHeE9RMHo5dGtId3Zk?=
 =?utf-8?B?b2Z5Y2hCVzl0TE9wSjZnMU8xZnBESFYvKzBWRk5aYWQxNGxLRVRORk1rbTA3?=
 =?utf-8?B?OVBWODZtY1hzV1BLTlVpOTBjamN2MVhtSk8rT2ZraCt2Y0x6dHJjaVRjS0xv?=
 =?utf-8?B?eXpSZzNuTGRha2E5UVlSbTdmK3pOVmJqQTlGNnYzZVhwb1ZwYzlVMDEzSUNu?=
 =?utf-8?B?Z09FMzV2bm9yY2VYeHBQYlhrbnJPcGNDUkpHNDhiRERCMXZwUFlKTG1tVjFV?=
 =?utf-8?B?WnBidi9Ga0V2WHNoekwzVWlQU291MHR5bngrYkh6UHQzeFB1Wk42ZVlqZDFl?=
 =?utf-8?B?QmxrdDVmZldPYUc0RnhqSlVocXkreXQ0L2hTTU1hdjlJSWRSZmFjSjRUN1JQ?=
 =?utf-8?B?dmJhZW4vN0h1NXo2c2o2OWNwakZzN3pQYlZ5UFloUkxsRCtyeFBBT1B0eDI1?=
 =?utf-8?B?N01ibnlnMmk3bnMybFpJaEduZHRhdm9QNFI0bWVuMkVKaUJYYUpFQ1o4dHdr?=
 =?utf-8?B?bnlLRnNCMnpVMElGZ29nY1NEZmRrTXJkcmpZRnlyZFFSdllKY0IvWU1Gb29N?=
 =?utf-8?B?aHg3emc4eTZBbGRJSWF2MUt1b0R1SWpndEFMOWJxZEpydlg5WDhnbTEvWGdk?=
 =?utf-8?B?M0JTdEdvdjZBakN4Q2RDSEl4UkZZUW5SUHZ2dVozS1BTSDJjQUFaRnRQWWlD?=
 =?utf-8?B?VjIzejdJbkQ2b2JsOEhIU0pVditjK29HcHpiVjlHY0c1SldHR1hLM2k5RUZF?=
 =?utf-8?B?bTd2N0RhVzRrSHZOZ2JKVFdENlp0dG1uQnpvcDlMeXA1UTd3SkRaNEF1cmV3?=
 =?utf-8?B?aW1vd2tKcGxZSHRSazEyYlJLTTJubXIzcVVTTFFqcUZrNWxsNDRQMkxFckQy?=
 =?utf-8?B?UFAxbzRFb3NoRWp3dVFOWE81elpPMlRPM3FrUWtHbDl2bkY1MTg2Zjhxd1Q3?=
 =?utf-8?Q?4J1gEp4goW6PBy8ZmnPb2Rph1VFVc0fri44uC?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c53d01-0e9d-4f44-9976-08de5ef9bd05
X-MS-Exchange-CrossTenant-AuthSource: BLAPR15MB3889.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 05:46:24.5880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjciWZx7O9k5iADUHxn7Ez/nDA7YRc3OjXi/BSAD7fCZAy3te5f33VZi/U8bWVgd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3955
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDAzMyBTYWx0ZWRfXzvgBjQXCQUqv
 vUYtCgyozmaBMEV7nMoedF07aIFpom+f4dJaPlsajsHd4NmmHoJOUvJD5364ybKLug1NHl9AhLe
 VNGnXQ77Odh1wJ+skompheP8w7OhZCauVPEv9/F6O0qu5mElwzqMnOY8/pWeqNZbNVqX01Cy0+a
 L1bYgbNAWkKhO81r9ENUQWOAUoyBo+TmgK6Cf3JM31M1FSHQh+y2SJCOvPHKOvm/4sDFgRK95cS
 mQNlCKcB/e+why9IWiX8qFnTi4Lu3VVTf7UPWUTeJ4N8OKhUPW4pzsUSBCmRx30Z/1sGCwNhOgw
 gV5P5CNhgBOREuf1DDoT8KsOrOd729SFB/8HIUPjg6yKuXDDINO5Idw3RdEeXvfi7SGbryZ6oVo
 yhqZ0mL2F151YmFxFV17uebwsTewe9RQYsH7Ces4Kgyya+yIgblmFhZE8R4DCOuF5MVc0x4+SaZ
 SiEF3R+Grqx9C3dy/cQ==
X-Proofpoint-ORIG-GUID: YxXrHw-eghP7FLmglp3PYCimwb1WtGqV
X-Authority-Analysis: v=2.4 cv=U5ufzOru c=1 sm=1 tr=0 ts=697af433 cx=c_pps
 a=bOzAxYZ/tHfqF28wl7V57Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=9R54UkLUAAAA:8 a=7vThbV2zn1M4ogfneqkA:9
 a=QEXdDO2ut3YA:10 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-GUID: YxXrHw-eghP7FLmglp3PYCimwb1WtGqV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254580-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[urldefense.com:url,meta.com:mid,meta.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[meta.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishs@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[urldefense.com];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B7731AC090
X-Rspamd-Action: no action

On 1/28/26 5:37 PM, Jakub Kicinski wrote:
> On Wed, 28 Jan 2026 13:20:29 -0800 Vishwanath Seshagiri wrote:
>> Introduce page_pool support in virtio_net driver to enable page recycling
>> in RX buffer allocation and avoid repeated page allocator calls. This
>> applies to mergeable and small buffer modes.
>>
>> Beyond performance improvements, this patch is a prerequisite for enabling
>> memory provider-based zero-copy features in virtio_net, specifically devmem
>> TCP and io_uring ZCRX, which require drivers to use page_pool for buffer
>> management.
> 
> Struggles to boot in the CI:
> 
> [   11.424197][    C0] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN
> [   11.424454][    C0] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> [   11.424606][    C0] CPU: 0 UID: 0 PID: 271 Comm: ip Not tainted 6.19.0-rc6-virtme #1 PREEMPT(full)
> [   11.424784][    C0] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [   11.424913][    C0] RIP: 0010:page_pool_alloc_frag_netmem+0x34/0x8e0
> [   11.425054][    C0] Code: b8 00 00 00 00 00 fc ff df 41 57 41 89 c8 41 56 41 55 41 89 d5 48 89 fa 41 54 48 c1 ea 03 49 89 f4 55 53 48 89 fb 48 83 ec 30 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 32 05 00 00 8b 0b 83 f9 3f 0f
> [   11.425413][    C0] RSP: 0018:ffa0000000007a00 EFLAGS: 00010286
> [   11.425544][    C0] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000820
> [   11.425697][    C0] RDX: 0000000000000000 RSI: ffa0000000007ac0 RDI: 0000000000000000
> [   11.425846][    C0] RBP: 1ff4000000000f54 R08: 0000000000000820 R09: fff3fc0000000f8f
> [   11.426000][    C0] R10: fff3fc0000000f90 R11: 0000000000000001 R12: ffa0000000007ac0
> [   11.426156][    C0] R13: 0000000000000600 R14: ff11000008719d00 R15: ff1100000926de00
> [   11.426308][    C0] FS:  00007f4db5334400(0000) GS:ff110000786fe000(0000) knlGS:0000000000000000
> [   11.426487][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   11.426617][    C0] CR2: 00000000004e5e60 CR3: 000000000b9da001 CR4: 0000000000771ef0
> [   11.426768][    C0] PKRU: 55555554
> [   11.426846][    C0] Call Trace:
> [   11.426927][    C0]  <IRQ>
> [   11.426981][    C0]  ? alloc_chain_hlocks+0x1e5/0x5c0
> [   11.427085][    C0]  ? buf_to_xdp.isra.0+0x2f0/0x2f0
> [   11.427190][    C0]  page_pool_alloc_frag+0xe/0x20
> [   11.427289][    C0]  add_recvbuf_mergeable+0x1e0/0x940
> [   11.427392][    C0]  ? page_to_skb+0x760/0x760
> [   11.427497][    C0]  ? lock_acquire.part.0+0xbc/0x260
> [   11.427597][    C0]  ? find_held_lock+0x2b/0x80
> [   11.427696][    C0]  try_fill_recv+0x180/0x240
> [   11.427794][    C0]  virtnet_poll+0xc79/0x1450
> [   11.427901][    C0]  ? receive_buf+0x690/0x690
> [   11.428005][    C0]  ? virtnet_xdp_handler+0x900/0x900
> [   11.428109][    C0]  ? do_raw_spin_unlock+0x59/0x250
> [   11.428208][    C0]  ? rcu_is_watching+0x15/0xd0
> [   11.428310][    C0]  __napi_poll.constprop.0+0x97/0x390
> [   11.428415][    C0]  net_rx_action+0x4f6/0xed0
> [   11.428517][    C0]  ? run_backlog_napi+0x90/0x90
> [   11.428617][    C0]  ? sched_balance_domains+0x270/0xd40
> [   11.428721][    C0]  ? lockdep_hardirqs_on_prepare.part.0+0x9a/0x160
> [   11.428844][    C0]  ? lockdep_hardirqs_on+0x84/0x130
> [   11.428949][    C0]  ? sched_balance_update_blocked_averages+0x137/0x1a0
> [   11.429073][    C0]  ? mark_held_locks+0x40/0x70
> [   11.429172][    C0]  handle_softirqs+0x1d7/0x840
> [   11.429271][    C0]  ? _local_bh_enable+0xd0/0xd0
> [   11.429371][    C0]  ? __flush_smp_call_function_queue+0x449/0x6d0
> [   11.429497][    C0]  ? rcu_is_watching+0x15/0xd0
> [   11.429597][    C0]  do_softirq+0xa9/0xe0
> 
> https://urldefense.com/v3/__https://netdev-ctrl.bots.linux.dev/logs/vmksft/virtio/results/494081/1-basic-features-sh/stderr__;!!Bt8RZUm9aw!7wS5Fv2oMa1yF_50zUYFtTbdPGX3y338sThfMUM_j_v_r6DUE5bRwHw9N4yAEVYm-uYHa48$

The CI error is a bug in my patch where page pools is not created for
all queues when num_online_cpus < max_queue_pairs. This is the issue
Jason caught about using max_queue_pairs instead of curr_queue_pairs.
I will fix it in v3.


