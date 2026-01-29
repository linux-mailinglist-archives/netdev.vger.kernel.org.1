Return-Path: <netdev+bounces-254863-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEIRBBSUe2nOGAIAu9opvQ
	(envelope-from <netdev+bounces-254863-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:08:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E68B2A67
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21EF93012CB9
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B0433123C;
	Thu, 29 Jan 2026 17:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YjmIAV+G"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010064.outbound.protection.outlook.com [52.101.56.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318343375A7
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769706504; cv=fail; b=cdutrr6eGzUbyRBvKfayuMX9MFTAeVJjb0L9xYIVXoR3ALL3FESN8umFWu8ZPdgppRXMVesoUbmTnTz3z8hUdcFW+IaZHlFLYrTaFw12WsHOtTWARIssgY/6hg8BElP1cssjgqsKQ06XFEKa9ZuHtYgRlIaScLN3oqZx65NYcno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769706504; c=relaxed/simple;
	bh=K/lofPuqcv+UhH7Nr21e4x3EVB6h0FwzM5YksoMzJlg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lrPVei913OUQjxyMXTQ/kDrq2h8z+PsJD462afzZsYwEfHI78xMwrW4XF57/Uq3I27Kl4EWWwvpJ1zIOxgZpx5i+lCyiJXCh1Iko4mPfYUtIaWhaQxnCRxN47h8lnnBqRw/b7puGcAnaP0kXvUURYndVABjfWW4XfOGrzDXg+ZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YjmIAV+G; arc=fail smtp.client-ip=52.101.56.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdfmnKmQotYqHlwFS/dXQ/0xazmtWuU57D4mfoS6HvDNv8QERJil/gcmurF4b/Nyr9y5/ryDEcjXo4DW9Wy0/YAapSjCyNtCRKoVUWK7PLpgYPykwlZcAjJ7jKIvQJsE6Xa0NV0J0dxG2D7LLnBZb01FWYK3YdNw9sUzYySQQ7Yx6KY7AclQ8s38Uj3min9lJ0Yy3kLq4d1RLPNftFNCYCtpWI5c8nzceV/XvyBdSKed0rcAgAw+BgZCvnzA32v7oIOuzDIRyb9S5soBqU+bcs2htvFp92n4bmiSd9bP5Dl8jvCkMxNDObtmCfnErdXv07sNAX6eBiTRvlrceUz5Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yo6aTTI7jzLk7fRbII3aL5NwfF96n3JEBJIHpfHVvNM=;
 b=VEv3NHbiL8VFpE/9ymtNWO4i7LgMfKWIpkTpD62Pu25I8ObFCPZjbN4MW/BDLKJGLtutma13u51QmRJYdTyGdGFuW1jlgpXYLE4OdbOAiqxYQgTQxxCwDrR7tjSFooWK5NbqdD+MKEMShRJSCUyfaofa3RYUHxuEAGmPLZsIbPoyRAvNGlxMPQF/xxwXEXnyDfunT5/Sh7gWKPzbi4kUaw6a4J6H8h6BQuxzHEF8F91ZSSWns2uh8jWPKCYzy1BjfLEjUoMqVQjfpG8jxytDZuOqMzNeI6SRU03XEKeLf7hLia39JJS+Nhi5dUoRicK0GQNxE9k/RNQ56p/p9h0dbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yo6aTTI7jzLk7fRbII3aL5NwfF96n3JEBJIHpfHVvNM=;
 b=YjmIAV+GD9kPl3tofucyB8sDvF17NQqglAORPx13xGowZWSXWesFLuLJ6k7Z6ZLJyNSVIZFonHU3oUDE2lwoJ/bqA6um6YQRXwvbwfdRuKnwQacs/JwBLT5DbjhEXyiRBN2AOZeWhel7MxuGqq0OHcAFUsMNABYJtowHOl5l5t7o5pRgON4lj5qH1cnYKdVmT6EAAGh2nFla+DebLUaY4ioIVK/mayLZ8jQA6dLkemYntP6s1dhRTJH00P+vEnAcFcQyx1Hn64V/xf6A+G8VjV/OUFg0VoTacI25jVYRmiRIk2AxUYxBOui91s48m8tkhXzRs+X5/yAmJx+nhNxpqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5415.namprd12.prod.outlook.com (2603:10b6:8:25::5) by
 IA0PR12MB8375.namprd12.prod.outlook.com (2603:10b6:208:3dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Thu, 29 Jan
 2026 17:08:20 +0000
Received: from DM8PR12MB5415.namprd12.prod.outlook.com
 ([fe80::e757:d15e:4293:e24b]) by DM8PR12MB5415.namprd12.prod.outlook.com
 ([fe80::e757:d15e:4293:e24b%4]) with mapi id 15.20.9564.008; Thu, 29 Jan 2026
 17:08:20 +0000
Message-ID: <1aecc98e-8215-4fc7-97f6-e1247da60339@nvidia.com>
Date: Thu, 29 Jan 2026 11:08:16 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v16 06/12] virtio_net: Create a FF group for
 ethtool steering
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20260121220652.894364-1-danielj@nvidia.com>
 <20260121220652.894364-7-danielj@nvidia.com>
 <20260122165014-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20260122165014-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0078.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::19) To DM8PR12MB5415.namprd12.prod.outlook.com
 (2603:10b6:8:25::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5415:EE_|IA0PR12MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: 30bba9c5-575f-468b-1027-08de5f590081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVdXcFV1Um5waHR1UGNsOHZMbW51a240Rm9TV3pDN1hnb1JMeUJDdWZUbk8x?=
 =?utf-8?B?NXgveUVuRkR3cktkUTNISjZBK0hYdkcyUHJYMm9lRVBVUXlYUXhqRHkwSXM5?=
 =?utf-8?B?eHBEd01JamV1ZkVUejJnNEg4ZmUycVRKUFRLbXN6MHRpREhmdDhzZFljYnJW?=
 =?utf-8?B?MVZ6OGhOYXUyUW5KaTdJbG1BR0JrYXlGM2RwMlM0TnU5MnJCMUl2ZFhONTRO?=
 =?utf-8?B?ZlNGOWFpemNGVUk5cXBuTmxMZ1lqM3UwMUwyaGtrMnp5b3I5YVZmblZIZkdG?=
 =?utf-8?B?UGVnM3JHaWh1aytjWHhVanFteUFVMWVxM2ZnTlJXd041Y2ZKZWx1WGxHRFox?=
 =?utf-8?B?VFdsa2orWllmRUhWdlhlcWRYdENUMEFwTnh6V2FMTTBYd0IvNXZRQnJRRnFV?=
 =?utf-8?B?SXU5QkRkOWRXU0VkWUQ2ZTVMVjhLNHJScm9Ecng0aVA5Vmt2N1hZYjdmb0xv?=
 =?utf-8?B?RkluZFlyVjIwL0tNWmJWTDFhZW9hNmhDZ3hPZEhYUFk4c0ttaEoxNFMvK2NK?=
 =?utf-8?B?eEVGN2xqTndWVHp4SjhpZEg3UHI0dUpCcFVkcWtOS1pQRzRGQ3dSemw3K09H?=
 =?utf-8?B?aVp1R3pISkFKWVhrMFJvcVFQQjBsbjJ1QVJoR1FRM2RGWDBwUitqZGxyWU5Y?=
 =?utf-8?B?WnR2UlpZanYzcUlzUGdMTFVMVTloYkZSZ2grNGUwNk1ldXlqU1MzZlZYWkdI?=
 =?utf-8?B?cUY4ZGp3UEF4UEZYYm9DNVgyTUlINEFBRDUwN1dLV0dXWWFhMjNDYWl1dnJU?=
 =?utf-8?B?N3ZXZTZ4T0R3dXJvTVFVSlY3bFlvMEJpNUNVNEZHSENIa1B2WXhoNG5NZUdr?=
 =?utf-8?B?ZXNWZEwyUHd0bURsU1JZeFNqdTNtNWZzL2xuSlJhZXNaQUhCemR4K2F2KzZZ?=
 =?utf-8?B?aEoxc2lRbmFaYTdzdDRxdEZqV3JZSXNXdlFBL0ROVXQxRHpxY2VQMlUwVVRw?=
 =?utf-8?B?dDdDZzdSeXBQWmdJN0NTTGZCeTlSZlg1OUZURzFBQVE2VnJONkozOTVUcGZx?=
 =?utf-8?B?WFhaLzVBamFiYWdOR21uUjZNcTBBN2xLdlR4b1JUaW5DbFIxN05xa3lQY090?=
 =?utf-8?B?OWRSemJvNEtFUFQ0Z0hNVVJJRWNOc1NKQUxPYjlGSVI1WnNDUkFVZ3RTNFpE?=
 =?utf-8?B?NDlIZkRoVUxuWlVYVjRMR2hsVXJrRlBEZkUydWxoVzJiTUwzOEhuVkNwOHdH?=
 =?utf-8?B?d3RqOXRzbG9hZHJEUVBpSmZidFVCR0xpbUdlenRKYnFIMWxRcFFsdFZwZVVY?=
 =?utf-8?B?WkpmOGdhQzBjb0k2Zk5KOTV5MW4yTS9XVU5XNlc1SnpuaEwydHZYWW02L0NB?=
 =?utf-8?B?Mk92NmN4RGEycnFCMHlQdTF5djhLaDJEMHk4UXpPU1Rvd0RjdGRFMFV5ZU5X?=
 =?utf-8?B?Vy9FbWNQakVYWklRUE0yR2JJa3M1U055Rm1VMmxoWVdham8yTmIzd3RMQ2pV?=
 =?utf-8?B?WEJNWVJhaHhZQVpLdUxrWHdkQW1BcDB2OFNqa2h3bjd1dHFzdlpjQ2dxbFNz?=
 =?utf-8?B?VU9xREpWZ01HbVJUWTJpTXRzazZFMkEvT2JwTXNIYitvanZMVE92QVMrT2dC?=
 =?utf-8?B?dnduYU1UNGtNeUY1MnhOM3Nzc0l5VjRnZGhlS0s0dGQ5TFZxRGw2Qkk1MmZU?=
 =?utf-8?B?akVwVitLR09iL3I1NXZXdjl2UjRHekg4NWVlUDRLSGdEVmRMcmxNbzA3aG1E?=
 =?utf-8?B?S3l4V0Fyb0kxODh4L0NzRjdHRm8ra0VCQk1RYTVzNmt3N1J5RXpOSXFYcTJQ?=
 =?utf-8?B?endPWWl2ZElEemlYTG8zTGdQb2pxYVRwMjE4TmdwT2h1SUhjaUFaMkhnL3JB?=
 =?utf-8?B?YVhqN3pETVR0WkZxTGxUTXNZd29pRlpmd3dYeTZqS0hnbkRTZ2ZCTFpQcjdl?=
 =?utf-8?B?T2NGYndWalllSFVwRzdwMkhDU01vaklkLzFxRTkzVkRZSEs0dnMzU29Bc0o3?=
 =?utf-8?B?cktOekdsczl1NnFYcUZOdkdLREpRZzhCOWYxVEliNHFTdTEzZlZIZ2xlQ2Ra?=
 =?utf-8?B?VTFJVWZ6MzdmT0xSalV1MVJRZlJnd0VGQit4TXFZMVBuc1plNFN5NWFzTEdL?=
 =?utf-8?B?UWh3UkVVWU41MDhLc3htNG53bFArb3JvdzJ3TlRvS25XM1c0U2dOSjhIakRX?=
 =?utf-8?Q?yG/A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5415.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2RBOW5qalFhMWZoUlpkZ2NndWxCYU84SlVLWlRnRWlPN3ozQnY2K0JSZjA4?=
 =?utf-8?B?ZS9OWnhWYjBwSlBBODZFSUk5MFlLdDZBaFgrYmJ1SU5rVmpud1psemh6TkZV?=
 =?utf-8?B?eVFuSFN2TlB2YTlFNDJnRnVFUGVKbU1leE1UdlhJZzhFaHhDdk5TREV5NHlt?=
 =?utf-8?B?MC9vdlJGelZFcmFOWEk1c296aHpxVU5tV1NIcU91SkVxMGxsNWVBZFdjeE83?=
 =?utf-8?B?eVl4TnNWT1oyTVZrVnlITUFFTjBtcXpGQ1lIejg4SE9sYldzQXluR3VhcFk1?=
 =?utf-8?B?YVFsWTJscjUrOXYwL0l3RUlFMWQ3ZmVlZzZ2VFQxWGdSQ2tVamRIQWkvblp6?=
 =?utf-8?B?UGxtZnhRVkJpMFdYWmFxdEM4L29hWStxMjZIUlFhYkZDRExRYXR2TnhiZFFC?=
 =?utf-8?B?YXdURG9haWJiUDBZY3d6YS8vRENNbXJGei9BdUdadGsyVTUrKzE1ZFl5bG0x?=
 =?utf-8?B?MUVZOE02bEVwVHpXS1NGR2lkMVpZWkxvSjlmVUhCL0JyenZCK3dLVmpuNVdM?=
 =?utf-8?B?MkxJZjBXWVNHc1EvcWVnWStINWpZT0hkNEFJTGlwVjFFR2JpcUhBTEhwaERz?=
 =?utf-8?B?TG5hcXYwbENpTVBYQWVjczRVUG11ZGluYTJ4VEtxRU5td1lFSXpZZkVLSTky?=
 =?utf-8?B?RXRNTmlSVjRqa0ZLT01BNVdBWmM5cnRBQ1MveGJ2THVmTjNJdjBTSUhJZEU2?=
 =?utf-8?B?dlVSU2p0NFcwUGNKaWpMTXpTZno2NXJqOFFJNE1iVHdaVUd2L2UvWXJxTnpZ?=
 =?utf-8?B?QXdwNjZNR2xDUzJ2QU9qTmlQM3d3UHFMN2tLQ0YzWFpleitkSi9BK3JqNFlI?=
 =?utf-8?B?K3NZaWRUOFpLa3d1T2JndFd5bXhqN2J3OUZxbnVrMi8rYmw1T2NFY3UxcDEx?=
 =?utf-8?B?cWVMZHpVdkhxakpzTVpycmZBTW1tRVBtekxQa3YxdHJsT2RuQzJmMWxFRUh6?=
 =?utf-8?B?bGdXSXU4T0YrN3JadndrN1hGSmVSZmNzT3VIaVorVTgvV2FDTlF2UTl2Zkox?=
 =?utf-8?B?L09ZVzhIUzNKNzNkeDdqSzQ1S3BIRE9MdmphNmJyNlI1UHNKZzNKNnAzUE9M?=
 =?utf-8?B?MjFTbURsRTNtbVBBWHhFZmRHWS9WTE5FY1B6SmkxcGc2MlFaVWZlSTAxWUQx?=
 =?utf-8?B?L1JBODhMOWV6eE50UGlYTU9weFp4bk9qSGtVS25sdXpjTnlRWGhPSnVGZDVx?=
 =?utf-8?B?UWdpajdIRGpaMWJRTUtBQWVKOVNkRTBlb1ZXUVdoVGtiMlFYRnNKcnI2VEx3?=
 =?utf-8?B?NlBHVDJROU9JT25tdlgwR3d4a1NYRnlIN2xXVU95QjFEKzFPQVdoRHdpdU9n?=
 =?utf-8?B?VDRFaTNUalNEUVYwdUZmQkJTTktSTHFmdUJCVFl2Qm90aFc4ZGwxU3UxVEZw?=
 =?utf-8?B?NEZDaWRETlBZZk02ckVYRGVEaGRWRUlUeU1wNGJleWN3K0JnR3V6TCtmMXpB?=
 =?utf-8?B?L1UrZlp1dDFCWVRlQlQwZ2JTU3loUksvbkpGeXZlR2lWajBPU0dTcTcxRTBB?=
 =?utf-8?B?K1V2NnhPbmFBUm4rNEVEQ0RjRXdGK1NSaG1oNm11MlAzUVNtTStURTRvTGw3?=
 =?utf-8?B?NnVFMk1IQXlVdE80c2srOXVqQjExdlNnaktDSS9LZ3VKZ2lQdHFveWc3alhJ?=
 =?utf-8?B?a0IwSVdicFdtTm93QndxOEVRQWR6TlBwL01pODR2dDJjWUJiaFViUjE4Vmpp?=
 =?utf-8?B?elFCUktQeHVCNUhaUUdCb2Y5NHhFb2wxRHlNU3VjVFdXL2hhczJMQjh2WGlO?=
 =?utf-8?B?ZTJ2ZkpGSUNnQ0Y4WXducmJkdEtzR1VCOHJiNWFLaEZzRWZHdE1LZ0dNMERr?=
 =?utf-8?B?ZzBXK3RpVjluMTNrVmFQeU9hR3dsUTNOSVlZbXVUeHRiNGdxcTluSVhscncv?=
 =?utf-8?B?THBoTGJMN1MrR29qdm9RSXNocmNOZ1Y5VENyL1hYbjkralc2Wko5T3BhNG9T?=
 =?utf-8?B?VEJEM0cyT0FuaG9tMnU3ejNDQ25BV2d6VDFiYUxKb1AzRGZzNmxEUlJvQWtU?=
 =?utf-8?B?Z2VnL1RQdkdwUndHcHhETGY1QlV6N3VNYmVINzlHSnBVL1BZY2tpcXdRdVV4?=
 =?utf-8?B?RVVJem92MnVJdTkwbFB2NEl6Zlhpa2VJTERLWFJMUnVlTEhXL2ZGbDVhdThN?=
 =?utf-8?B?V1NzZ2hnUGRiT1MvRXdUMXVTTjZLM0txMDlOVVFBc0NneUtoT2M4TCtpSC9u?=
 =?utf-8?B?VjFwM3NiLzdEeUdhUEZwa0hyeGdZa1gwWjk5M00vSFBVLzFsTUF1d2FLejE1?=
 =?utf-8?B?MjA3RWlvWWVjZEFuOWFnRWxPeFVXMnNpMjB5UmhoTnR5WHhXdjh4VmVZemxM?=
 =?utf-8?B?TkRnTGlCNmhwMTZ4bExFdStpeU9rbVBGb2VDcGxjTFVEK2RFaEE5Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30bba9c5-575f-468b-1027-08de5f590081
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5415.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 17:08:20.0426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jp6EywTdX/x+XdMQ6D48HK86ybDmsvdrbpKUjaIEBtatJE3cO7jvmwNMkaxZEz0I1DSHYSvSxbS5q9vZzw6Alg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8375
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254863-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 79E68B2A67
X-Rspamd-Action: no action

On 1/22/26 3:51 PM, Michael S. Tsirkin wrote:

>> +	ethtool_group.group_priority = cpu_to_le16(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
>> +
>> +	/* Use priority for the object ID. */
>> +	err = virtio_admin_obj_create(vdev,
>> +				      VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
>> +				      VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
> 
> This (3rd param to virtio_admin_obj_create)
> is the object ID actually. Setting this to 1 means it is outside
> of range for group limit which should be 0...limit - 1 and limit is 1.
> 
> don't you mean 0?
>

No, the the maximum number of groups being 1 doesn't say anything about
the ID you use for that group. Higher IDs indicate higher priorities. I
intentionally choose 1 here because a reasonable follow on series would
be to implement ARFS. In that case it would make sense to have user
created rules higher priority than ARFS rules.

> 
>> +				      VIRTIO_ADMIN_GROUP_TYPE_SELF,



