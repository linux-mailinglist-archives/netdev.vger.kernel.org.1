Return-Path: <netdev+bounces-257887-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I0KBq5JiWmg5wQAu9opvQ
	(envelope-from <netdev+bounces-257887-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 03:42:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2574510B375
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 03:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59A553007F66
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 02:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98C82D9EF3;
	Mon,  9 Feb 2026 02:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="PzuqrO63"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0D6242D6C;
	Mon,  9 Feb 2026 02:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770604967; cv=fail; b=UsthxlxuOZzrWpQ0nKkoTNwrQ6brYdhx0Pt1fmgeEY/YOzVzFb3A6ThsG2cdHZ6lx++hpBHtpYOffhi8Z0UaPE40dugHMA0X3mAhvJS7dkkslUkSEn40X8najNzDUXfXMkkT6YDiBVdTjcEXjmAhttJ68LmvIkgY5tcgpxiShPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770604967; c=relaxed/simple;
	bh=YGjqBBRluYfxV5bqFwa8uZg0WpX6TSkWkhv6fdZJqo0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cnErwTluAW3BM2PYLldm+FbKuR2LacpJ1xy1OQWB9aijCEXXlg0Tc1XRSLfSzyAT3rY2GRvWh9/mv7Qc1WfCAnqcpGInXZQsnl43sxrfmy8w+z/lXKmjeSnE62LyN9Viegzyg0xBv+/A7D+5OoaEuxd8RD9E32l1A4rbFT+c5/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=PzuqrO63; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6192SInG2507955;
	Sun, 8 Feb 2026 18:42:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=hrI/Y2Fk5Kyv/zs5ml2gwI4faJmLvvUJGYwd7SViW6E=; b=PzuqrO635+C6
	rbioGJWW5I62J9WbvdW1XUC6NPoNCfvfKuZaRfWE8sggIQeA0pf5Yvu4weNQQNj2
	7pdsCU+O8VyLpYR4GEZsPJPiCgInQ8F+sQDKcZIS8Gra56OEU8fMshpWx2QpPuKY
	Lx3fJZFsuAJxhI5ImFgVRJOQFAtm9zP2cQ50iT7nmPrsuoyb3mONdt2r96q1USIp
	xz2cH1XXaQiv9A8l0DCarnYUmBU4LbzE53DEAw1AVJFbeGI6YyMqzpv7+wI62KXi
	KL3u/W9nhkOBetLV08U+129PolDZaTh2JntoL90RkQt2wO8m2Ne4bNQ239DZ7wYc
	OEKfXm2cuw==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c6vm1488d-4
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 08 Feb 2026 18:42:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vi1vwop6HOoT4XMVWS711Gs4D3SA7P77fkLPO4JqNYzMHlPkUo3GWmrG8It3Alsv98kre8ZVMT6q6AEZDRv1qg8fE0S+Rr1/7FqvkGDdUfUkBjo9LBOYiWvBOwxx0HTHT7tYxNnoemnCGcv97EiyXsTVNWKol9NJrMm+sGAHJrHrrFcQ/QALfJJyVwC9rQN2i3YYhrdTDqm/sq6oE8vmPgR59/+ACB2qAvikyk5g/J3L2Jx8lVG9ruRPMyHZkh6zLadof4yvknLB4Hf8F49I2mhhyN7bS1XBwgaDmdQHoJCb52ElFHNCzjhhNpZWSg+ISsdye6LoDPF+1ALneVjplg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrI/Y2Fk5Kyv/zs5ml2gwI4faJmLvvUJGYwd7SViW6E=;
 b=KMqUKHQIkY8EL7TXlGi0v9pPx7tKQPxh66iV5w4wLeBGFrAT34bF11fuafGxlrdHj2g1jaF/7tNN761vERBgL+Nt4ogZknUAEbjuh4PPew3lUixDzw4wSXwN4ihpShba1IFON4skBKSAFF4nk6yfF0CAUrj4Y5N3x1CGF/mkX7GdXwCLtqYQaF7eYdCKiUagGYYeicLJgomWVuC6lTov3whJuQZvcZNcpR5XOI5SbjMDkDoAy8XTQLawiEqZkReRgR2ssBce4n/LPr0injYWygug2ytRwpS/4KYuO27wow67B+asYMSiz74Sg/rFULXuT7CwO3k+vLUkDRmbxhlm7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BLAPR15MB3889.namprd15.prod.outlook.com (2603:10b6:208:27a::11)
 by PH0PR15MB4232.namprd15.prod.outlook.com (2603:10b6:510:29::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 02:42:30 +0000
Received: from BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044]) by BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044%5]) with mapi id 15.20.9587.013; Mon, 9 Feb 2026
 02:42:30 +0000
Message-ID: <b97cd16c-e35c-4e74-b258-056ae491aa1b@meta.com>
Date: Sun, 8 Feb 2026 18:42:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] virtio_net: add page_pool support for buffer
 allocation
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>,
        Matteo Croce <technoboy85@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
References: <20260208175410.1910001-1-vishs@meta.com>
 <1770602432.6451533-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Vishwanath Seshagiri <vishs@meta.com>
In-Reply-To: <1770602432.6451533-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0063.namprd11.prod.outlook.com
 (2603:10b6:a03:80::40) To BLAPR15MB3889.namprd15.prod.outlook.com
 (2603:10b6:208:27a::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR15MB3889:EE_|PH0PR15MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: a589f67a-faf3-46ba-c49b-08de6784de14
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?emVNS2VvZ1QwT0xWMWpVeHJvTDZrNE1yajNLR3R4Q2c2VUUxdzhtak1Sb0F5?=
 =?utf-8?B?YmQ1eTV4VWtRY1Areit4SWxuNnNmVTVDcDg0c3h0blV0QklBTEFMRDB2aExH?=
 =?utf-8?B?Mks1ZTNvL2VWMXg1SFFWbGhQZUdHUWdYYW04NlZETUZ3Ty9xZSt2ZGhDVkRT?=
 =?utf-8?B?blNaRjQ3Z0taN2M0RW1rOElXams3MFdVRnp2blVLYW5SbmRkVVZIcE5LZjRi?=
 =?utf-8?B?UG9kYzE5MUVxREQ5cjM1WlZMUXQycDdzeVFFMVlVNXdMckRHMzNpMXJ0QlJj?=
 =?utf-8?B?aTltMHE3TzI0UGJBUXRaTXloNGxWZXAzVVRoeXQ1aStTdEpPMkZTTnoxV0Vq?=
 =?utf-8?B?WG01eTZNTGFYcjVtOVh1VHZKSG1pL0l6SzBKRkN6b2ZMUGNQUFpneElIbCtt?=
 =?utf-8?B?VzNUaVhrMTc2LzRhVmN6Y2owb2l5T3ErQlBtY3ViMjg4ZEU2OEpBSDAzZlBh?=
 =?utf-8?B?TVVSVTAyZlNuS2N4NXJ6UDNBOWZQM0tEOHB4YlMyaE5zOU5UY1kyMUNROHoz?=
 =?utf-8?B?a2p6KzdJTDF6UUlLKzhOeWNLYUp1RG1raWs1NUhMcTU2Mm1BWTR4SXBPTCt2?=
 =?utf-8?B?TnFmVUhjUlBRR2R3d2loLzVzb0h6NFkrcHZwV0tNQ3ZCZnE0U1pHeDl1eGxN?=
 =?utf-8?B?M3V6ZDFOeXNoMWM5NkdDa2ZCdlZ3YmtKU3p2SVZIVm5OeUFNOE4yaHplelcr?=
 =?utf-8?B?QjJXVVNZUHZ6RDlGaVdOSGtWQjhjZEJqampreHFCWHVtN2I3QVN2OGFDc1BJ?=
 =?utf-8?B?K2tBTFhNY1ZneW9KMlpzdDZGaVFqaTBva0pVYjcxaEUya2dGNlBNWlQrbWFU?=
 =?utf-8?B?OGZxN2hCZzE1d0o3RjlmeTV6UEx0bFAxT1U4TVlpNlJnQ3BpWFRFaUNKTnlz?=
 =?utf-8?B?K2V6S2NqSXp2dUwzaGlrRnFMMjZGQXBnOEk3cW5uVnliUUErV0NaeTRpKzh4?=
 =?utf-8?B?TElTSFdqaG81VFM4VW4veDI3OU44amRDUUpNc05ZNmxadlRiK0JwZmwwRU1Z?=
 =?utf-8?B?UHllUzhsTVRmNVI1M2d6NmVtZ3NUalArZEN6bTJURGFzVVJxS3U1MVBXWlhm?=
 =?utf-8?B?MExYQzVXQVZscERZV3BxR2phNXV6TTNBek5VanRLS1lHbVNjS2ludzFISFls?=
 =?utf-8?B?Vm9ZSTAwSEZvUGFGTWNPQ1QzWDVrOUwvK2ExQytoT284eXJ5eDBvNldRMjg2?=
 =?utf-8?B?SS80cnlaWDBraVFkVmdVUm9yVDI4dXNRc29lQVJWbVY4MDY3dmlNNFZQUFF0?=
 =?utf-8?B?SXVuOEYrdUk4VE9SRy9jNGNveUpOTExBZ0grZ3VIb0tyZE5haEs2YWtXSTZB?=
 =?utf-8?B?RmtrOWx6SmpiN01RMHJXUG5jOTB6TDdNaG55NHlrcW5yOFBGR0wyVzgzTm9y?=
 =?utf-8?B?aFE1NzJoR3haNWpjZk5TWjNrcS8xZWpTVHc0WmhibHdoOTl5REpHMWpDa1Rs?=
 =?utf-8?B?Z2V6WWUrMFh4SVJQS0dPcktEczlmRURFeWh5V0t6UGJ6QUd3MU93d2thUkJB?=
 =?utf-8?B?TFQyTUZSeW9EZXBNdHlCaXY2TlN5NFduOGhzUi9iek45eGV6Wi9XaFFZQlNq?=
 =?utf-8?B?Nm9xbk1vbmNUVUV6YlZEaHdpTm1IZE5GUlBsc1VQUlVlNXk1dVgxbVJDcVpF?=
 =?utf-8?B?bzMvWFY4RjdvekVGYkFRT25pTnduZ3lIMksvVmlZYU8rZzFyMC85SGQ2c1dE?=
 =?utf-8?B?RGsxMHQycnY3bjl5QXk4N2ZJSm94M2dxeHAxSVhtMk93cmt4TTA3eU4rUHRO?=
 =?utf-8?B?MmFJWFZ5a2VQVDJKQkVSWmJKYVJVdTVVMWZ6TStnOGl2eTFja05xWlhjeDZz?=
 =?utf-8?B?WUdlcHl2WjcvOWJZTEpmSWJDVmRrc2JNTDhFelQvR1Y5RkJUdkxQaW50TUo5?=
 =?utf-8?B?V0hwTm85NVRMRWFNM21HV3c4NnN6Q1A3RE9uYzRNbjd6ZkNVeGFLWE1SMEly?=
 =?utf-8?B?ZUxISjk4d0s0THA1LzdjL3pNVGVRMGRadEppTGxzUkxIWEplTFpqOThmMHNG?=
 =?utf-8?B?TkFCVWpjbnpvcDliWk5VdHlXbDN4Nnk1b1B5aUF3NnBOMnNpS2JwWWgrZGRB?=
 =?utf-8?B?MFpYZzFPYkgzZVJDb2dDSmVVZG5zWGxaK1o0cjF0VnovcGt1M1pFMWdxNnpt?=
 =?utf-8?Q?LZYs=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR15MB3889.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?b29ydHVIMCszL00yNFVVcktkM1cvR0hXL0VFRklPaTc2Nlh1MEoxNExpVnll?=
 =?utf-8?B?Z1dsS1BreFhXS1BTR0VReVVwZW0vRVdqZjhPU01VOW13Yi93K2s3bGo2bEFn?=
 =?utf-8?B?Nm9OWmJ2b3YzY0lmcFRCazFkb2k4K3hJaGRtZjRYTThCRXYweThHTkY2bW5X?=
 =?utf-8?B?a0NUT2J6QS85N1FTNGJzc01iREdQNVhpQXVMQ1VGS2dPMmJYbG5IUE5iQmtB?=
 =?utf-8?B?L1FsVXJDN0VkdWdxTks4Z3ZDRE9mK0NzVDREN2NPQzJPbllTTzFpalQrTUw1?=
 =?utf-8?B?VkVCM1BhWGg1ZWw2YjlFNGUxWDg4dFE3MjFqNWNFM3NQZU1CUXU5S05LU3hC?=
 =?utf-8?B?enJIT3pub1hZeE1mVVJWQ3FodWZJL0kwaWxjaUJ5L3kydlBwdU5qSDZqbVg4?=
 =?utf-8?B?VjZ5dktVQy9BcXlVNW9KamdsdDljK0dyMGIzdUdtalg5L1N4Q09kVFZRNTBw?=
 =?utf-8?B?UkV0QmpvaW5UdFZ2cXUrUGt5WXFoQkUrb1ArUHluclp3WnFHTGRZWS9qaHZk?=
 =?utf-8?B?MTNpdnIvdHpXaTlDVHNwUm9iNUtWTTgzYjM2UUFLdVo2cWlZb2RkRDNzeGJR?=
 =?utf-8?B?YmIwVW9nSzI1SFNYWWdhQkpUdnhEZDV5Tjhpc3hUY3BSeFFGN3E1SGpXLytL?=
 =?utf-8?B?Zld0ek5GQzVpZytwRmtoZEd4c0F2bkR0RVFqR1I2QlUwbjZRNWQzTVJ2bldS?=
 =?utf-8?B?Z2J2RXBHWVZBUmh6VzVwU0RmM0FJM05RNUpabWJBU1RpS0tFUU9jWjlCWnFF?=
 =?utf-8?B?K0ZSWHgvVk9Tc1Nxd3lXRDkybVZ6eTBKR2lRMzlTZzNBekdkTTlJTXVVcUF3?=
 =?utf-8?B?QkRoTlhZRFNFaGZqRG0rZFJCcFM4WUx4UnFid0E5Z2RkL2ZQSk5DWDlhK3c4?=
 =?utf-8?B?VEZvYmw3M3V5NEJtU3FzcDN2T2VaNm92dFd1WFhRZGg2bk5GL1gvZ3RCZHpr?=
 =?utf-8?B?amloNGk4alVKdWRra3Uzei8vbTBVZnplMksrM3Nkd3JUZGowUmZVZnB4Sk9n?=
 =?utf-8?B?ZHl4NUZMQWxhTkRMdWZMSG43UzRCZk1hZEpNa0FjUnllR1VFZmtvZzN3Zk9I?=
 =?utf-8?B?WWhJcTBBRGN4YjFCWHQzKzNCUEJiRFFkUG85NnZ3Q0FQR2JBVGk3TUZTc3po?=
 =?utf-8?B?MGFZNm9ZSUNWNTJxbmRkd2FuT21tN1FZY1BJU09yNXpZRTRXTnhwNFRXaGJs?=
 =?utf-8?B?Y1lxZXl2R25ER3FDRnIzOEJSa0NVN2Q1ck85b3R4aVJZbmhpRDA1bU9YSjk3?=
 =?utf-8?B?RDVwdjcvRmxYOVJtSHpqTE1RN1dFaDFrd0s2eFJaVXZkV3k4NklFMXRMU2ta?=
 =?utf-8?B?WmE1ZEpVN201eEZoaEprdStGU1V6dzJBUWZWTi9jS3Vrcm4yazNUd0psc1I0?=
 =?utf-8?B?OHF2YzhBYi9zSy84eiszODNRbVVZTnZXMUI2a0J4NDJXNWx4M0p3ZnN5MURI?=
 =?utf-8?B?NUJQUHJVZHl4RHlJeGEzT04rQ3FMbnZRT01SMGRyRHUvdnNnb25lK05ReEN2?=
 =?utf-8?B?WTVJcU9uSmJIaTZFRm83QmZpYXlLUWFnUGhMcWFSQ2g2b1czWFJna1pxRm5x?=
 =?utf-8?B?WkJUYjZqUWJoOVR3ZmE0elpyWUF2cW01NllsOTN2cEF3ZXVxenhPazZkVEVa?=
 =?utf-8?B?SGxoVE9iM1orcnBoUmZITVZHU3RObHhTYkN6bUp4SUp2bWVUeUxORlpaNys3?=
 =?utf-8?B?Q2FPRE9lcWpzaEVEaVk4TFRPRFc1UmdjSWFOKzIwNUphUDh4UGFOa2JLYVR0?=
 =?utf-8?B?SEFSUDBpMTE1eXhmSkhmZTJvVENUSSs0NmNlR3h3VVBuTFJ0WGhaSi80OGVo?=
 =?utf-8?B?dUZheDgxMjhSWjIwTXZLdmVlaHc3M1V3dHJWSkp5a0Vncno0VGhoSmt4NVBF?=
 =?utf-8?B?aFRiR0phR0JyVkFOQVowQ3B0Q3RYYXNMOGwvY202bDhSWGQyQ3Q5YjJMVXZ3?=
 =?utf-8?B?Q0taMC9FOHJnRmIydjhWcW5iVlJqMjZYaEhaWFJWMEZjMnhjTUFGVWtiRXpM?=
 =?utf-8?B?dUxYc3h4d3hkNUNtajdFT0szY1ViK1lHVXZpNFhhZXVvVDVXOHhUWWtFWHg2?=
 =?utf-8?B?UFNVNHNsNDZSU3Y2bXRRbG1McDBBdXh2WjRKK0hrZUNzS1BGNTdlZXFKS0V0?=
 =?utf-8?B?cHdqVnhXbklVL0lzMUgrS3N4NzZWSUpEZ3JycHozYmRFTkxPMjJkYWM0Ym5p?=
 =?utf-8?B?cUFkUThENEpWWmdvclNTQTM1MXlkZkxVM2FWa1UvZ3ArZnRGaTJlclJVVkN1?=
 =?utf-8?B?QXdWcHZiQXp6cHNFSXIwUldleFZBV21Zay9jNFRDaklvd1ArY2wzQ0c5ZXBR?=
 =?utf-8?B?eFpHSVlKVUp1aURLbEY0czJKN0RQVVVzV29QazVxbVdhRlBlOGlmWjN0L1Fq?=
 =?utf-8?Q?pHuR4UaYESuYZ+nRdvijebNACPgWtldkXpIRq?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a589f67a-faf3-46ba-c49b-08de6784de14
X-MS-Exchange-CrossTenant-AuthSource: BLAPR15MB3889.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 02:42:29.6169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0xCJWOTPWhV28MFwgclkqLV3qtZdyHg+8qtIUIurvsdn2YuJHaZJHOvYlRgE0qd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4232
X-Authority-Analysis: v=2.4 cv=ILUPywvG c=1 sm=1 tr=0 ts=6989499a cx=c_pps
 a=fdYRkKHAJehZsuGPaltaPA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=LQxVJagRmHXr5uwAUZgA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: 39OAR6eAd5wn5WB6KxFNmOS24aA03w9_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDAyMSBTYWx0ZWRfX0Q6Zn6UYW6WX
 2YP64uj1SCMP30nVNWwNXL6qcOMl065j6tvIGgctOuCB5EANqoZ2cLrOvUUbFxMCXvOL4cMElFq
 HuxzApFlJmDfbSEy/LPk+4op3avCr/ECPuh8v7CpNvlQ/OSvFRhO3XBPAq19A3mC5KqNA58Wrmz
 T/BK6ADkApK3zpxMo4DbcYJlQVg4vP1A7+5L52p9kBwgeS5OurfkScbrfyYw57A4wuqk9avSymf
 vRCun2R6gXZHEXn7taVIK+a7aJWVN/iJy2Mew4MbZw+wkl0UfOnrxAw4t9JibwOkYBXeK+20exH
 ZtMR5cFLwTPOsEHOP6/cgqo40sEGzjVHZt30FRGSkrVA+dFSdsOO07xn3B1HZR5BYU/bCNHVhXc
 4Wwe/PE/nQJQ0b08TW9o0PDT77CeYHTj/6+llcjkDgdY/Tc9IuiTvU+zCs5y3td39pjnxTCdf3S
 sEly0TNWGNfoDTZtcEQ==
X-Proofpoint-GUID: 39OAR6eAd5wn5WB6KxFNmOS24aA03w9_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257887-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:dkim,meta.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishs@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2574510B375
X-Rspamd-Action: no action

On 2/8/26 6:00 PM, Xuan Zhuo wrote:
> On Sun, 8 Feb 2026 09:54:10 -0800, Vishwanath Seshagiri <vishs@meta.com> wrote:
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
>> Changes in v6:
>> - Drop page_pool_frag_offset_add() helper and switch to page_pool_alloc_va();
>>    page_pool_alloc_netmem() already handles internal fragmentation internally
>>    (Jakub Kicinski)
>> - v5:
>>    https://lore.kernel.org/virtualization/20260206002715.1885869-1-vishs@meta.com/
>>
>> Benchmark results:
>>
>> Configuration: pktgen TX -> tap -> vhost-net | virtio-net RX -> XDP_DROP
>>
>> Small packets (64 bytes, mrg_rxbuf=off):
>>    1Q:  853,493 -> 868,923 pps  (+1.8%)
>>    2Q: 1,655,793 -> 1,696,707 pps (+2.5%)
>>    4Q: 3,143,375 -> 3,302,511 pps (+5.1%)
>>    8Q: 6,082,590 -> 6,156,894 pps (+1.2%)
>>
>> Mergeable RX (64 bytes):
>>    1Q:   766,168 ->   814,493 pps  (+6.3%)
>>    2Q: 1,384,871 -> 1,670,639 pps (+20.6%)
>>    4Q: 2,773,081 -> 3,080,574 pps (+11.1%)
>>    8Q: 5,600,615 -> 6,043,891 pps  (+7.9%)
>>
>> Mergeable RX (1500 bytes):
>>    1Q:   741,579 ->   785,442 pps  (+5.9%)
>>    2Q: 1,310,043 -> 1,534,554 pps (+17.1%)
>>    4Q: 2,748,700 -> 2,890,582 pps  (+5.2%)
>>    8Q: 5,348,589 -> 5,618,664 pps  (+5.0%)
>>
>>   drivers/net/Kconfig      |   1 +
>>   drivers/net/virtio_net.c | 434 +++++++++++++++++++--------------------
>>   2 files changed, 217 insertions(+), 218 deletions(-)
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
>> index db88dcaefb20..5055df56e4a7 100644
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
>> @@ -290,14 +291,6 @@ struct virtnet_interrupt_coalesce {
>>   	u32 max_usecs;
>>   };
>>
>> -/* The dma information of pages allocated at a time. */
>> -struct virtnet_rq_dma {
>> -	dma_addr_t addr;
>> -	u32 ref;
>> -	u16 len;
>> -	u16 need_sync;
>> -};
>> -
>>   /* Internal representation of a send virtqueue */
>>   struct send_queue {
>>   	/* Virtqueue associated with this send _queue */
>> @@ -356,8 +349,10 @@ struct receive_queue {
>>   	/* Average packet length for mergeable receive buffers. */
>>   	struct ewma_pkt_len mrg_avg_pkt_len;
>>
>> -	/* Page frag for packet buffer allocation. */
>> -	struct page_frag alloc_frag;
>> +	struct page_pool *page_pool;
>> +
>> +	/* True if page_pool handles DMA mapping via PP_FLAG_DMA_MAP */
>> +	bool use_page_pool_dma;
>>
>>   	/* RX: fragments + linear part + virtio header */
>>   	struct scatterlist sg[MAX_SKB_FRAGS + 2];
>> @@ -370,9 +365,6 @@ struct receive_queue {
>>
>>   	struct xdp_rxq_info xdp_rxq;
>>
>> -	/* Record the last dma info to free after new pages is allocated. */
>> -	struct virtnet_rq_dma *last_dma;
>> -
>>   	struct xsk_buff_pool *xsk_pool;
>>
>>   	/* xdp rxq used by xsk */
>> @@ -521,11 +513,13 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
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
>> @@ -706,15 +700,24 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
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
> 
> Why we need this?
> For the caller, we should know which one should be used?
> 

This was after some feedback to unify the alloc/free path checks in v4.
But you raise a valid point - callers already know the mode via 
virtnet_no_page_pool(). I can simplify this to just call 
page_pool_put_page() directly, since virtnet_put_page() is only called
from paths that already checked we're using page_pool. Would you prefer
that?


> 
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
>> @@ -876,10 +879,16 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>   		skb = virtnet_build_skb(buf, truesize, p - buf, len);
>>   		if (unlikely(!skb))
>>   			return NULL;
>> +		/* Big packets mode chains pages via page->private, which is
>> +		 * incompatible with the way page_pool uses page->private.
>> +		 * Currently, big packets mode doesn't use page pools.
>> +		 */
>> +		if (vi->big_packets && !vi->mergeable_rx_bufs) {
>> +			page = (struct page *)page->private;
>> +			if (page)
>> +				give_pages(rq, page);
>> +		}
>>
>> -		page = (struct page *)page->private;
>> -		if (page)
>> -			give_pages(rq, page);
>>   		goto ok;
>>   	}
>>
>> @@ -925,133 +934,18 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>   	hdr = skb_vnet_common_hdr(skb);
>>   	memcpy(hdr, hdr_p, hdr_len);
>>   	if (page_to_free)
>> -		put_page(page_to_free);
>> +		virtnet_put_page(rq, page_to_free, true);
>>
>>   	return skb;
>>   }
>>
>> -static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 len)
>> -{
>> -	struct virtnet_info *vi = rq->vq->vdev->priv;
>> -	struct page *page = virt_to_head_page(buf);
>> -	struct virtnet_rq_dma *dma;
>> -	void *head;
>> -	int offset;
>> -
>> -	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>> -
>> -	head = page_address(page);
>> -
>> -	dma = head;
>> -
>> -	--dma->ref;
>> -
>> -	if (dma->need_sync && len) {
>> -		offset = buf - (head + sizeof(*dma));
>> -
>> -		virtqueue_map_sync_single_range_for_cpu(rq->vq, dma->addr,
>> -							offset, len,
>> -							DMA_FROM_DEVICE);
>> -	}
>> -
>> -	if (dma->ref)
>> -		return;
>> -
>> -	virtqueue_unmap_single_attrs(rq->vq, dma->addr, dma->len,
>> -				     DMA_FROM_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
>> -	put_page(page);
>> -}
>> -
>>   static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
>>   {
>>   	struct virtnet_info *vi = rq->vq->vdev->priv;
>> -	void *buf;
>>
>>   	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>>
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
>> -
>> -	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>> -
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
>> @@ -1067,9 +961,6 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>>   		return;
>>   	}
>>
>> -	if (!vi->big_packets || vi->mergeable_rx_bufs)
>> -		virtnet_rq_unmap(rq, buf, 0);
>> -
>>   	virtnet_rq_free_buf(vi, rq, buf);
>>   }
>>
>> @@ -1335,7 +1226,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
>>
>>   		truesize = len;
>>
>> -		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
>> +		curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
>>   						    buf, len, truesize);
>>   		if (!curr_skb) {
>>   			put_page(page);
>> @@ -1771,7 +1662,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>>   	return ret;
>>   }
>>
>> -static void put_xdp_frags(struct xdp_buff *xdp)
>> +static void put_xdp_frags(struct receive_queue *rq, struct xdp_buff *xdp)
>>   {
>>   	struct skb_shared_info *shinfo;
>>   	struct page *xdp_page;
>> @@ -1781,7 +1672,7 @@ static void put_xdp_frags(struct xdp_buff *xdp)
>>   		shinfo = xdp_get_shared_info_from_buff(xdp);
>>   		for (i = 0; i < shinfo->nr_frags; i++) {
>>   			xdp_page = skb_frag_page(&shinfo->frags[i]);
>> -			put_page(xdp_page);
>> +			virtnet_put_page(rq, xdp_page, true);
>>   		}
>>   	}
>>   }
>> @@ -1873,7 +1764,7 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>>   	if (page_off + *len + tailroom > PAGE_SIZE)
>>   		return NULL;
>>
>> -	page = alloc_page(GFP_ATOMIC);
>> +	page = page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC);
>>   	if (!page)
>>   		return NULL;
>>
>> @@ -1897,7 +1788,7 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>>   		off = buf - page_address(p);
>>
>>   		if (check_mergeable_len(dev, ctx, buflen)) {
>> -			put_page(p);
>> +			virtnet_put_page(rq, p, true);
>>   			goto err_buf;
>>   		}
>>
>> @@ -1905,21 +1796,21 @@ static struct page *xdp_linearize_page(struct net_device *dev,
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
>> @@ -1969,6 +1860,12 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>>   	unsigned int metasize = 0;
>>   	u32 act;
>>
>> +	if (rq->use_page_pool_dma) {
>> +		int off = buf - page_address(page);
>> +
>> +		page_pool_dma_sync_for_cpu(rq->page_pool, page, off, len);
>> +	}
>> +
>>   	if (unlikely(hdr->hdr.gso_type))
>>   		goto err_xdp;
>>
>> @@ -1996,7 +1893,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>>   			goto err_xdp;
>>
>>   		buf = page_address(xdp_page);
>> -		put_page(page);
>> +		virtnet_put_page(rq, page, true);
>>   		page = xdp_page;
>>   	}
>>
>> @@ -2028,13 +1925,15 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
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
>> @@ -2056,6 +1955,12 @@ static struct sk_buff *receive_small(struct net_device *dev,
>>   	 */
>>   	buf -= VIRTNET_RX_PAD + xdp_headroom;
>>
>> +	if (rq->use_page_pool_dma) {
>> +		int offset = buf - page_address(page);
>> +
>> +		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
>> +	}
>> +
>>   	len -= vi->hdr_len;
>>   	u64_stats_add(&stats->bytes, len);
>>
>> @@ -2082,12 +1987,14 @@ static struct sk_buff *receive_small(struct net_device *dev,
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
>> @@ -2142,7 +2049,7 @@ static void mergeable_buf_free(struct receive_queue *rq, int num_buf,
>>   		}
>>   		u64_stats_add(&stats->bytes, len);
>>   		page = virt_to_head_page(buf);
>> -		put_page(page);
>> +		virtnet_put_page(rq, page, true);
>>   	}
>>   }
>>
>> @@ -2253,7 +2160,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>>   		offset = buf - page_address(page);
>>
>>   		if (check_mergeable_len(dev, ctx, len)) {
>> -			put_page(page);
>> +			virtnet_put_page(rq, page, true);
>>   			goto err;
>>   		}
>>
>> @@ -2272,7 +2179,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>>   	return 0;
>>
>>   err:
>> -	put_xdp_frags(xdp);
>> +	put_xdp_frags(rq, xdp);
>>   	return -EINVAL;
>>   }
>>
>> @@ -2337,7 +2244,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
>>   		if (*len + xdp_room > PAGE_SIZE)
>>   			return NULL;
>>
>> -		xdp_page = alloc_page(GFP_ATOMIC);
>> +		xdp_page = page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC);
>>   		if (!xdp_page)
>>   			return NULL;
>>
>> @@ -2347,7 +2254,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
>>
>>   	*frame_sz = PAGE_SIZE;
>>
>> -	put_page(*page);
>> +	virtnet_put_page(rq, *page, true);
>>
>>   	*page = xdp_page;
>>
>> @@ -2393,6 +2300,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>>   		head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
>>   		if (unlikely(!head_skb))
>>   			break;
>> +
>> +		skb_mark_for_recycle(head_skb);
>>   		return head_skb;
>>
>>   	case XDP_TX:
>> @@ -2403,10 +2312,10 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
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
>> @@ -2414,7 +2323,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>>   	return NULL;
>>   }
>>
>> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
>> +					       struct sk_buff *head_skb,
>>   					       struct sk_buff *curr_skb,
>>   					       struct page *page, void *buf,
>>   					       int len, int truesize)
>> @@ -2446,7 +2356,7 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>>
>>   	offset = buf - page_address(page);
>>   	if (skb_can_coalesce(curr_skb, num_skb_frags, page, offset)) {
>> -		put_page(page);
>> +		virtnet_put_page(rq, page, true);
>>   		skb_coalesce_rx_frag(curr_skb, num_skb_frags - 1,
>>   				     len, truesize);
>>   	} else {
>> @@ -2475,6 +2385,10 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>   	unsigned int headroom = mergeable_ctx_to_headroom(ctx);
>>
>>   	head_skb = NULL;
>> +
>> +	if (rq->use_page_pool_dma)
>> +		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
>> +
>>   	u64_stats_add(&stats->bytes, len - vi->hdr_len);
>>
>>   	if (check_mergeable_len(dev, ctx, len))
>> @@ -2499,6 +2413,8 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>
>>   	if (unlikely(!curr_skb))
>>   		goto err_skb;
>> +
>> +	skb_mark_for_recycle(head_skb);
>>   	while (--num_buf) {
>>   		buf = virtnet_rq_get_buf(rq, &len, &ctx);
>>   		if (unlikely(!buf)) {
>> @@ -2517,7 +2433,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>   			goto err_skb;
>>
>>   		truesize = mergeable_ctx_to_truesize(ctx);
>> -		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
>> +		curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
>>   						    buf, len, truesize);
>>   		if (!curr_skb)
>>   			goto err_skb;
>> @@ -2527,7 +2443,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>   	return head_skb;
>>
>>   err_skb:
>> -	put_page(page);
>> +	virtnet_put_page(rq, page, true);
>>   	mergeable_buf_free(rq, num_buf, dev, stats);
>>
>>   err_buf:
>> @@ -2666,32 +2582,41 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>>   static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>>   			     gfp_t gfp)
>>   {
>> -	char *buf;
>>   	unsigned int xdp_headroom = virtnet_get_headroom(vi);
>>   	void *ctx = (void *)(unsigned long)xdp_headroom;
>> -	int len = vi->hdr_len + VIRTNET_RX_PAD + GOOD_PACKET_LEN + xdp_headroom;
>> +	unsigned int len = vi->hdr_len + VIRTNET_RX_PAD + GOOD_PACKET_LEN + xdp_headroom;
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
>> +	buf = page_pool_alloc_va(rq->page_pool, &len, gfp);
>>   	if (unlikely(!buf))
>>   		return -ENOMEM;
>>
>>   	buf += VIRTNET_RX_PAD + xdp_headroom;
>>
>> -	virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN);
>> +	if (rq->use_page_pool_dma) {
>> +		page = virt_to_head_page(buf);
>> +		addr = page_pool_get_dma_addr(page) +
>> +		       (buf - (char *)page_address(page));
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
>> @@ -2764,13 +2689,14 @@ static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
>>   static int add_recvbuf_mergeable(struct virtnet_info *vi,
>>   				 struct receive_queue *rq, gfp_t gfp)
>>   {
>> -	struct page_frag *alloc_frag = &rq->alloc_frag;
>>   	unsigned int headroom = virtnet_get_headroom(vi);
>>   	unsigned int tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
>>   	unsigned int room = SKB_DATA_ALIGN(headroom + tailroom);
>> -	unsigned int len, hole;
>> -	void *ctx;
>> +	unsigned int len, alloc_len;
>> +	struct page *page;
>> +	dma_addr_t addr;
>>   	char *buf;
>> +	void *ctx;
>>   	int err;
>>
>>   	/* Extra tailroom is needed to satisfy XDP's assumption. This
>> @@ -2779,39 +2705,36 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
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
>> +	alloc_len = len + room;
>> +	buf = page_pool_alloc_va(rq->page_pool, &alloc_len, gfp);
>>   	if (unlikely(!buf))
>>   		return -ENOMEM;
>>
>>   	buf += headroom; /* advance address leaving hole at front of pkt */
>> -	hole = alloc_frag->size - alloc_frag->offset;
>> -	if (hole < len + room) {
>> -		/* To avoid internal fragmentation, if there is very likely not
>> -		 * enough space for another buffer, add the remaining space to
>> -		 * the current buffer.
>> -		 * XDP core assumes that frame_size of xdp_buff and the length
>> -		 * of the frag are PAGE_SIZE, so we disable the hole mechanism.
>> -		 */
>> -		if (!headroom)
>> -			len += hole;
>> -		alloc_frag->offset += hole;
>> -	}
>>
>> -	virtnet_rq_init_one_sg(rq, buf, len);
>> +	if (!headroom)
>> +		len = alloc_len - room;
>>
>>   	ctx = mergeable_len_to_ctx(len + room, headroom);
>> -	err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx, gfp);
>> -	if (err < 0) {
>> -		virtnet_rq_unmap(rq, buf, 0);
>> -		put_page(virt_to_head_page(buf));
>> +
>> +	if (rq->use_page_pool_dma) {
>> +		page = virt_to_head_page(buf);
>> +		addr = page_pool_get_dma_addr(page) +
>> +		       (buf - (char *)page_address(page));
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
>> @@ -3128,7 +3051,10 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
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
>> @@ -3168,6 +3094,81 @@ static void virtnet_update_settings(struct virtnet_info *vi)
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
> 
> Can the page pool handles dma with vi->vdev->dev.parent?

No, we cannot use the page_pool DMA with vi->vdev->dev.parent in VDUSE
case because VDUSE uses its own address translation. virtqueue_dma_dev()
returns NULL, virtio doesn't use standard DMA API at all. Now that I 
think about it, setting pp_params.dev in this branch is unnecessary
since it is never accessed. I can remove it, if you prefer.


> 
> Thanks.
> 
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
>> @@ -6287,17 +6288,6 @@ static void free_receive_bufs(struct virtnet_info *vi)
>>   	rtnl_unlock();
>>   }
>>
>> -static void free_receive_page_frags(struct virtnet_info *vi)
>> -{
>> -	int i;
>> -	for (i = 0; i < vi->max_queue_pairs; i++)
>> -		if (vi->rq[i].alloc_frag.page) {
>> -			if (vi->rq[i].last_dma)
>> -				virtnet_rq_unmap(&vi->rq[i], vi->rq[i].last_dma, 0);
>> -			put_page(vi->rq[i].alloc_frag.page);
>> -		}
>> -}
>> -
>>   static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
>>   {
>>   	struct virtnet_info *vi = vq->vdev->priv;
>> @@ -6441,10 +6431,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
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
>> @@ -6945,6 +6933,14 @@ static int virtnet_probe(struct virtio_device *vdev)
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
>> @@ -6958,7 +6954,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>>   		vi->failover = net_failover_create(vi->dev);
>>   		if (IS_ERR(vi->failover)) {
>>   			err = PTR_ERR(vi->failover);
>> -			goto free_vqs;
>> +			goto free_page_pools;
>>   		}
>>   	}
>>
>> @@ -7075,9 +7071,11 @@ static int virtnet_probe(struct virtio_device *vdev)
>>   	unregister_netdev(dev);
>>   free_failover:
>>   	net_failover_destroy(vi->failover);
>> -free_vqs:
>> +free_page_pools:
>> +	virtnet_destroy_page_pools(vi);
>> +free_irq_moder:
>> +	virtnet_free_irq_moder(vi);
>>   	virtio_reset_device(vdev);
>> -	free_receive_page_frags(vi);
>>   	virtnet_del_vqs(vi);
>>   free:
>>   	free_netdev(dev);
>> @@ -7102,7 +7100,7 @@ static void remove_vq_common(struct virtnet_info *vi)
>>
>>   	free_receive_bufs(vi);
>>
>> -	free_receive_page_frags(vi);
>> +	virtnet_destroy_page_pools(vi);
>>
>>   	virtnet_del_vqs(vi);
>>   }
>> --
>> 2.47.3
>>


