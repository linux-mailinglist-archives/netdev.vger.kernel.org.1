Return-Path: <netdev+bounces-254880-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oA44D4uee2nOGAIAu9opvQ
	(envelope-from <netdev+bounces-254880-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:53:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA85AB3417
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 479B63031337
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2C23559C4;
	Thu, 29 Jan 2026 17:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="TRj1ztaF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F278C3542C9;
	Thu, 29 Jan 2026 17:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769708949; cv=fail; b=kL5K4hIii2E8s43xrxFR3V+Xv/mA1y81uKjouVk1V9alHtbBtATE+DNUPyhe3uXLtUcYeoStfh0iZkVe+ghaoVrftWodazxZhkCpOXRJchdRqOe/RN8ESP2Cr37Wflq9n6R2HkfSrUDF7tM9SeVvw+70w8hPVrqbzsWp5vhWiyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769708949; c=relaxed/simple;
	bh=l7X5WOnKTeJ54jcA5KJblC7DdV4K/0CO0rBOsE1xU/w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jG440KD9AkQuMXtllSOqwnu0L6N4NgzwDWi70EPtKOIgkpAFBzD6m/x/hzBDHiBsjayF4BiIafHeHFxJhMM9dpcGyTsDs/+1Ks6mkNfktFLKhRGxH4jkueSbrRUKNJKFAfGuOPaoZVOQ/dAf63nB9UI+0EWWAWPnEd2JYVGfXSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=TRj1ztaF; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TCthce3205954;
	Thu, 29 Jan 2026 09:48:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=4vD+0CtjqY3j7CwiJ1vMQHEQbcUqoyWXoG/kmQhI5qM=; b=TRj1ztaFRKQv
	QXiFLgmVoYanJ1xg7GPR9r5OhRlScLYHDnjWPW6DK61VKVwEwkINjvF6rqMhf7bJ
	6U1Jv6/SYKYg/Ur49WmZAMkUp9JRbGISb2RQi78pzL+GLNU3WRNznSbNh/WN4THO
	cCaAYETO6wKzgNpHsvDXVBZq9ue/HBv6aPnGL/OOgbXQU78FubVuFxW1a3i4lvgY
	JGTPZedrqEIGVKXTp5EbcRdmJfMfFUNkCiEVjRmIHQjb1mp+DYJS/Amo7l9cOp+c
	ArnNtrOo+lrkX3CosxpTEJOurzTdxcMXBbJ4tiikRvmOGJfSfMmFYNwDSocMJxvv
	TKxfvkMPNg==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c080037pg-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 09:48:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouen4ZD0BIt9wj9T0Y8xTtbkIzkYCYovODvVDDTQ0kW9yl9Muk8k486Bb6YXqujk7qyW6lMzjQgWAnkHTbjaVvwhw9yw3hfHNtuT7tWch9wpa+CGAohwzA2khxYnCIX63R2AmT9XG+83yI4bQrKSMxDHxLoEQVmphZlJpLBt1l7afbsXiRo7dIkpuFWR0TpkJhU+4CDdTmmuqSHfX4AOECqXIsRoCJ84iMobnXHybwSy6lDUJUjZGEGubYKiOXLdf9lkNwZ1Evpcr6R6h3L8Q27Tfq10eTiBGM9VdwunDeyqaRdvna/3GOpglfzd56j0bvl5N901VhoqeoB1ApFMaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vD+0CtjqY3j7CwiJ1vMQHEQbcUqoyWXoG/kmQhI5qM=;
 b=bHfI0vwDBb5RVnG0l1cBeGROShQvaxoEF4ZwS+wV5I7Z5eKpfhx5/31s7PeM4nu3OY7atRVGoONAq0NEPoveqmlaBrAFhBX0JoGZJmIiWBTY4va1GfRlREvpVDTxbVQZ4eWkGrp3PXMFSkHkmLl7y+16DsoJSdnmu/Vhbe4bUuetSVQyPCkRjAfy+aXhcKLz0YZeHqRffXD55vUPiD0a7v0jHILAmk0Ill3E46+xp6tgNAjUUtmq59UWlmDzGWoaJEIvN1k8Jka0B+BQqs/jXlsWIcvOOgY/IioYVzu0ZsqMhSKmambHpL5f2ORFforxD/1XuujghoHwDKkWW6fCyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BLAPR15MB3889.namprd15.prod.outlook.com (2603:10b6:208:27a::11)
 by IA1PR15MB5489.namprd15.prod.outlook.com (2603:10b6:208:3aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 17:48:48 +0000
Received: from BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044]) by BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 17:48:48 +0000
Message-ID: <6d7386ba-0012-4f13-b31b-fcd7a15f173e@meta.com>
Date: Thu, 29 Jan 2026 09:48:42 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 1/2] virtio_net: add page_pool support for
 buffer allocation
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>,
        netdev@vger.kernel.org, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20260128212031.1431746-1-vishs@meta.com>
 <20260128212031.1431746-2-vishs@meta.com>
 <20260129012534-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Vishwanath Seshagiri <vishs@meta.com>
In-Reply-To: <20260129012534-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::23) To BLAPR15MB3889.namprd15.prod.outlook.com
 (2603:10b6:208:27a::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR15MB3889:EE_|IA1PR15MB5489:EE_
X-MS-Office365-Filtering-Correlation-Id: 34aaffed-a0bf-4cfd-6b76-08de5f5ea817
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|10070799003|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ejlTd05HcmJwRCtCMC9ERUJ5Y25aanpXMEtWdjFYbDl6aWRYeGdhMkdKbndu?=
 =?utf-8?B?TVc0S2RtVlV3ZlpHVFN4ZnAzcllFaWlMRmRUeFdzUlo5bEM4NFNlVERyeERF?=
 =?utf-8?B?QmxKRmdZNlRqVzZJQmFZZFZralc0M0tDWGkxNGswQ3IxMjFjWkkybDYwNVFj?=
 =?utf-8?B?NkJlbzFDQk1qTkJvZG42NWVIM1hiUU1UT0d1RDdSRmpKZ0xMSUMwUnA1d1Iw?=
 =?utf-8?B?RGxvUHA1RUhkVGsyNnp3NTMxSGZXS0lxMmkrTEc0ZmVpVUpqeXZORWQyTnZ0?=
 =?utf-8?B?UXlVcmlqOXJJYml6bGRyaGgySkYvVTJYMEJqcFRCRnlreGVldDNsSGpYbE9M?=
 =?utf-8?B?RC9qRG5KWnBNV3Z0SVlKRWdBam9PY2hWNytYcFdkeisxczZFRnQyWDdsSXln?=
 =?utf-8?B?ckRBcmkyeUVubUhVbDlhbzFkM2xoYVl1V05WYS9UT2l6MjRCOHFFVXVPa3Y2?=
 =?utf-8?B?ZUNZd3RTVnEwY0tZWjUrTjIzcjNQeDEvbHg4UUFpYldPbHRzQ2J2WGJNQmE3?=
 =?utf-8?B?aXJTNnVhR1VEcWJHMmhnOFhHdkhsMUFpTUJpM0ZXQklkZ0hLVGJoeHNFZmZ3?=
 =?utf-8?B?T3VaS25kOHlWSVZxaTBBZFJCNFphVHN4eHNWR3hZKzEydEdjTVRXbGc1aWtT?=
 =?utf-8?B?WGZvWmNQa1dPVnY2aHMzSE9MYlRibHBKSGM4TFhpMFc4bm4xaHhOaXJ5SEdq?=
 =?utf-8?B?Uk9OMVFUNFg5U004NnhKc0x2R1RjNW00cDBsc3VsSGdLbGMwLzFTaDdXdUYv?=
 =?utf-8?B?Y3U0UEVQejEvdUZsQjBSbzFWN0N6K0twRlhQejdYakI5bnVsQWZkQ2ExWlNh?=
 =?utf-8?B?bmx2SERrV3ZnRFZ3ZzJSYW93LzN5eTlRKzM2UE5oaE50eFF1cEl0OEVZcmw5?=
 =?utf-8?B?N0Q3blhaQjMzU3VpcVdyZ2xFazVGME1rdkZPUXc5S3BHb3liSnNGaWJuNGRs?=
 =?utf-8?B?OEQyb0VYbkQydkhTNW05NDZ5eVd0OElpeTMxeGNLUG9FQnd5RkJtYVRCWStS?=
 =?utf-8?B?UVNLY2pmQ2U5eUZYY09SS21YYnVOYUo2eW9FTEtCeGcxNVcxRGRLRmlidFdo?=
 =?utf-8?B?UTBpTlo1OHVNMDFkWUt5NUUySEpvdlhWaFZqOGFPdFBkTXhSbHhIYzZPMjlC?=
 =?utf-8?B?U3dFV3JzNWo5djVZY3NLdURlTm1QTUkzMWI5WDNxMDQxM0x1YkpoMTZqdGd5?=
 =?utf-8?B?Y2UvMHJrYVp1ZUwzU29qa0wxZ3AvelF1SThpd0lkcDE1bmJQM00xMTVoVnA2?=
 =?utf-8?B?TEhlMnRiR0dPZmp2dzNUT05SRjdrQU9sMG5Pc2dQb0NseFdCeUV0bDUxbGhw?=
 =?utf-8?B?L2VNdnRYeEVNWnV4RlhUbUZFd0hUYjBWb2h4T1o2NXpHeVcrZ2V0TEdPWnhs?=
 =?utf-8?B?V204dGxMQVZLczF5b2dGSFFpaVNNc1ZoWkJDZ0ZCeTQvVndXV01BQzRSU3VB?=
 =?utf-8?B?b2FTZDIvUTVKUDJyTVhyNnpudDBGOTd6UWJxKzZXMFp4L3k5TDk2NTVkc0lG?=
 =?utf-8?B?MTJ5QTlic3NOVGdGeFU4dWZzVnQ3QjNLeHoxdFEwREVGVkJGRGNPWG9RL21X?=
 =?utf-8?B?SE9vSnd2TjBEbVN6NHJoSWdLWEZibXF4bXZOV0FmcythNG54Szh0aEFhR0lz?=
 =?utf-8?B?bTdFMkt2clJGTlM5NjBQYm5sYnpRVG5JZ2ZIczgwMHg0WVYybzRIdVYxV1Mv?=
 =?utf-8?B?b3YycFBYMFhuYUJMWTlwODIwYTQvMGRhY0p3dUJZWm9qSStpR1ArcXRRQVFK?=
 =?utf-8?B?S0MrbVFQOFFnRjlpbzJqUCsvcWNpRGNCVnpkbzdTM1lhamZYQXhMZWhXZEw3?=
 =?utf-8?B?RnVMQTBGOVRkeCtGeG5jd0s1Si9NQnZnUDlwQ2R6ZUF6NEw1cHF4dFJYNVMr?=
 =?utf-8?B?SnNmU1JpYy91Vzk1NFlHY0lLd3o2SG1sdTkzbXhmb0ViQ3ZvSW1meDY5UDd2?=
 =?utf-8?B?Z2FzUHlyMGwxeVJHOFNkcWdvSldLSmptRU9CczdOVTZrOVdxenRuK1Y0TXZ4?=
 =?utf-8?B?NzRlNkxZNjNBZjFSUURVN2E1dlYrSUZpZVQrQVdvajhKWnAzWTlkMUZicG1Q?=
 =?utf-8?B?VEFlMDNjSHh3a1VGVTJwS2U1Vkw0SkE5TThWZHM2ZFpvL3lXc3pxZ21KQ2Yz?=
 =?utf-8?Q?P2BE=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR15MB3889.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SVNTdk5ITnB4bjdnUCtMMDVpTHB2TVlHcTlJRjFPYW5zWlRiSk9lN3ZXc2dt?=
 =?utf-8?B?ZnFKSHFJV0FwUlpMT2M5VkJXdWpUTXJVdURnS2VDSHVvZUs3ZElUMlUxTTNE?=
 =?utf-8?B?eGJLT0c2cFd3OU9PQkt3Q2M2ZEZ6VTgyUnJ2VHZpVDllVERuVnE2NjFpNC9x?=
 =?utf-8?B?YWk5K2dlWmwyWmhYMFRZSnprMDczcTBjK2trMXU5MW5rQ2FQSEgxYitrMkw0?=
 =?utf-8?B?d0h3dlZ6UXVVWGhTOGhSUEJVS2cwaUZTTUYySHB6RzVPTFQ3SFl0MUNNKzFv?=
 =?utf-8?B?TE9GSUVrTVdJWTlMekVoWlRaWTJNZkJKaGpVenF1Q29uOVQ1QUQyeFVkMFFQ?=
 =?utf-8?B?YXhEQ090aDZWNEl5Z2EzYUNlWDN1R25hMWNGdERYK1dQQVBtLzAxaWlhRkpK?=
 =?utf-8?B?RDlOeXAyMWJhdFl5bHJjQXVwT1JkUS9ibjJYeHRYM0hYL1I4cld5VmlWek55?=
 =?utf-8?B?K1VqV1ZhcFlBczloaXl3dlB4aHRhd2JmR0x4a1lOU2E4dEt6U0VUdlI3aENE?=
 =?utf-8?B?TTF0ekIxaUJsd2NFVm5xdGdZOHByaXpSUC8xTUFpMXQrQ0RIbHAyMGZQUXdi?=
 =?utf-8?B?cHJPT1FiSjRrNk5TVXhHVXQ0SFVYeFNtcTEvNCtvQ1ZFamErS1JrekoxMHMx?=
 =?utf-8?B?RC9tS3pWc1k0UWdURE5yUDZET0VuWGhWZzlxT1ZZM2x6SFJlNFY5eDJWcVNS?=
 =?utf-8?B?UnBKUXFvK1M4Mi9SNHhPWE9hWHBBM3hPcThnR2xwYWdzVXFMbklyMDNLZlEv?=
 =?utf-8?B?dkJxb0gzN1ZBZzluSkpyUXRnMytzN05PaDhYZ1cxLzlZT2xUOEkyd3FtVWZC?=
 =?utf-8?B?azdFSHN4Nlo5U2kza3NETXBUR0gycEoyeFRuMUVHbUZaL0ZML1VEWmJpSzNi?=
 =?utf-8?B?YTNSMXlOcmdTWnROakF0WDhOcDlYL1E4dm9CVGR4T0hvNnl2UHZvd0dCdW9q?=
 =?utf-8?B?cHNCcWNwQ0hmc3JFUEtQQUZjRXBXU01sN3BGYVl1SVN2aE9sU0NMSnA3cUFE?=
 =?utf-8?B?amNHRmlnWkhzR2x4SmthUkFXdk0rZXdEaWxJeU4wdG5wVU15S0x3RmRDYUxP?=
 =?utf-8?B?S2FQUzAxRWg4SFBpVWdUa01tRHUyUEZkeHE1dEJQMm91VnFRTStZWDIrVyt4?=
 =?utf-8?B?UVhjNklNTmJqMWorcTdxWnNVU3EzRVhZNW1hR3dHdE1tRkVtak9DWSs0eG9T?=
 =?utf-8?B?bmdmK01sZVBtM3hxdFlHQ0dYSlM0VUdXNHFMNFQwaXo4eFBPc3R2dDBjT09V?=
 =?utf-8?B?M0E1NC9FeERINHdleWZWeUpmR0NTcGp4YUF5N1RQQUFsV1Qydjl4WXJZUk1j?=
 =?utf-8?B?M2RLczZvSFdxYXlHSVJBSGVjVENaNjFDU2lmSzUvTjkxdjFpVDNtQnd5RGp4?=
 =?utf-8?B?MUdjbDVPS3lOZHZnbnpLQWVMdksrQXAxbjdXeE1vLzIxaUZhNit2K0x5NWdY?=
 =?utf-8?B?ZmRsRmY0K0RNcmhHVFlBZk5ydS84cHlvTC9KSFROUjlkNys1WEFieVJLV2tj?=
 =?utf-8?B?T1N6U3R5eVpDQ25SNUZRSFFvSWpzTklJMVRpU2MxcU5NR2psWkZHUktKQ0lZ?=
 =?utf-8?B?NDFsSURBV3lxcUFuVm5EN1RYNy9vSlErZVdCSVFQWU5pSG5Hb1E1SkNCckRk?=
 =?utf-8?B?cElEK2JqKzk3V3Q0VmVPQkxHaUdJYnhQeXJCU3NVeUxQc2hiVnJSWTJyeGtG?=
 =?utf-8?B?dkdQS0tXWkZUMTdIdVVvWG1zOVVFTFQvMTdNcFIyL1NBMFozVGxZdUMvY0x4?=
 =?utf-8?B?Z3dCMDJJRGh0Wis0Zmp5T0JWNkwxQVdYWGhVbXQ3dGwzSGx1SGNlWHYvQUps?=
 =?utf-8?B?UitvWElUUzFRNnBrV05HNHZrRzVnMjJQS01zcmtjd1V3cHJYZEFIWDliMjQr?=
 =?utf-8?B?ZlY0V1ZJQ05LNzRBZE9MNkVhSDRrSlhVYU9SckRKSDZLTEkxVWJ4NDQvL2ti?=
 =?utf-8?B?WXJVRTVEbXNWay9CUWs2TnFTdGlSRElFRmVxV000cnVKZHY3UkEyeFZPVDRE?=
 =?utf-8?B?cGtkMm9tN0hVNkF1MUJXWmQ1WFpBNTRvZThxUmRiYzFRNEhHbDdFV01ra3FW?=
 =?utf-8?B?Z3pDdTJwTUEvVXZ4emltYVIvcDNNOE44R0k2cnoyRXVqL1htY00zeXN2TnJS?=
 =?utf-8?B?dzQ4b25EWVhWZjd5aHNnbXpESTFUR1JFM1lMbHVsQWEvTzZPN2NMOUNyRWpC?=
 =?utf-8?B?K1BsSlpRWGcrUDZnbVB6TmlxKzZDL0liVGtPWndCUHE2Ly9SQnBmbndBRzIy?=
 =?utf-8?B?NlVkTzhVUGQwekVSS3dVVHl6OGJQRE51c1MrYWlJNmd0OW9uSGRDeE5FcWR5?=
 =?utf-8?B?bUg0Q1NuSDlUNzhTdmtqR2YzNXpKVmRDazFaWmdwd0RDRVRocVpYbElSRVRQ?=
 =?utf-8?Q?V+Ca0CPnSEaws7i1BKIB4doo3Cg+DSMLrSxix?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34aaffed-a0bf-4cfd-6b76-08de5f5ea817
X-MS-Exchange-CrossTenant-AuthSource: BLAPR15MB3889.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 17:48:48.7883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z7ZZ9rG0ziCD0OchEVkCQzRXeXOHtuIj0wwlBExohqrI88gIpuKItb8ugzKInnhx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5489
X-Authority-Analysis: v=2.4 cv=AojjHe9P c=1 sm=1 tr=0 ts=697b9d85 cx=c_pps
 a=Upp9xsdEppYJlq5B+Xcl6Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VabnemYjAAAA:8 a=_-5IICEH9htX8uYARTEA:9
 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: pX5j8SmF8P9qAvNcytWMVVVHE7BemDWS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEyNiBTYWx0ZWRfXw6R6DU0dJq5D
 XawWmDC3YfPVdCofRTUzKq1zFBHOfWKKQBsdaI3tQEoE9xqNN87ScJGT5ihKDhvErkxR2n0mBr/
 qD1b7+8aYi15vmfGZJX5DXMakTDKMqZUqMD80VJebSYTHzzeLXy5NalmPecC1gmfUU6fN//irhU
 jnLGDkJOKWI/WTttzgQGO4XHZqO6ubpZp2ZSNAsiNAhMCcFpR7R/DWQ266S2uVvfXNt2qR0Nmsj
 EYGPrsj2719OeWXLD3JHK5ufKDtyynFZNHs6UI5SqWA+/MZu56uuAi87duA8WXkkTyCdS1jw3by
 Dh3BzlkOesnn25yMVp8SiCiPgKYvKuNhM5bQtwqmSkXjnSHKgNiE5x+I65pOkY5tEepnAYxOI9O
 nhQvwMScTIjPgdc0EPs7S+6O7dyljpEDO8vzbGYFn5W+z3jJj2NE9rkCfbpQAXh3mN7v3BXi0Yq
 NZjMDvY4eaoWKdppI+Q==
X-Proofpoint-GUID: pX5j8SmF8P9qAvNcytWMVVVHE7BemDWS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-254880-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:dkim,meta.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishs@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AA85AB3417
X-Rspamd-Action: no action

On 1/28/26 10:30 PM, Michael S. Tsirkin wrote:
> On Wed, Jan 28, 2026 at 01:20:30PM -0800, Vishwanath Seshagiri wrote:
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
>> The rx_mode_work_enabled flag prevents virtnet_rx_mode_work() from
>> sending control virtqueue commands while ndo_close is tearing down
>> device state, avoiding virtqueue corruption during concurrent operations.
>>
>> Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
>> ---
>>   drivers/net/Kconfig      |   1 +
>>   drivers/net/virtio_net.c | 353 ++++++++++++++++++++++-----------------
>>   2 files changed, 203 insertions(+), 151 deletions(-)
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
>> index db88dcaefb20..df2a5fc5187e 100644
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
>> @@ -706,15 +714,21 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
>>   	return p;
>>   }
>>   
>> +static void virtnet_put_page(struct receive_queue *rq, struct page *page,
>> +			     bool allow_direct)
>> +{
>> +	page_pool_put_page(rq->page_pool, page, -1, allow_direct);
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
> 
> 
> what I dislike here is how big_packets mode still pokes
> at give_pages but other modes use the page pool.
> 
> Given all modes operate with struct page it's hard to
> shake the feeling we could be trying to put a page
> we did not get from the pool back into the pool,
> or vice versa.

The allocation and free paths are symmetric for each of the modes.
Although, I made an error in the give_pages() path of big buffers.
That being said, the dual system approach is fragile. and I excluded
big_packets because it chains via page->private, which conflicts with
page_pool's internal use of page->private.

Would you prefer I extend the page_pool to big_packets in v3 or
followup? This would require building an alternate chaining mechanism,
which conflicts with page_pool's internal use of page->private.

> 
> 
> 
>>   
>>   static void enable_rx_mode_work(struct virtnet_info *vi)
>> @@ -877,9 +891,6 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>   		if (unlikely(!skb))
>>   			return NULL;
>>   
>> -		page = (struct page *)page->private;
>> -		if (page)
>> -			give_pages(rq, page);
>>   		goto ok;
>>   	}
>>
> 
> For example above you did not touch give_pages, here
> you are ripping out give_pages. Superficially, weird.

This was done in error, I will fix it in v3.

> 
> 
> I ask myself whether page pool is not better than the
> homegrown linked list that give_pages uses, anyway.

Extending page pool support is not only for performance, but
it is also needed for future zero copy features across RX modes.

> 
> Will need some perf testing though.

If you want me to run specific performance tests, I can add it in v3.

> 


