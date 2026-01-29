Return-Path: <netdev+bounces-254916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOasCEvTe2nrIgIAu9opvQ
	(envelope-from <netdev+bounces-254916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 22:38:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB93B4DF2
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 22:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D97E83007F4D
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 21:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DD035CB7B;
	Thu, 29 Jan 2026 21:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="uPQviDBV"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D98030E836;
	Thu, 29 Jan 2026 21:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769722460; cv=fail; b=dDS9j/iz4bqqG88XT4aCmyul+qiwehSVokgmBE0HGle4z70K378TDgcExLrOnGQorC6/qFP/oOy9TiaIoi4MXNppbhNtm2pYmPiPXd+CFKgxYg+324Te/hpF317Y1wHUJ7Sr4yjJTC6uXL2rVTaKSPKFfck4HOZ0ghdwgNqYdkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769722460; c=relaxed/simple;
	bh=YolW0vyR+CRV2Ez3vyLmrVEwdZTq6ar2oK1WOQGI8Fc=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AYLImkI69Z3b9YNObvqxT5Pfzr54szJASmkQU/paLgyPQlN3I8q8KydEF4UMmu/TICiknb300uyJ5Nzz9pt7BWw4v1vfzPf+a257YScQwQIluOanZSDogYtmYKxoSnQm5gobT1whvPt3huPm1omX9JwE86A1cMcXFwHyo2OBX8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=uPQviDBV; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TJdWai3320602;
	Thu, 29 Jan 2026 13:34:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=OHYt8asWoI0jyYywztwTXE+xbZeL117GB51t4iOR5m0=; b=uPQviDBVQQYE
	Cu/XEfmOhsTmnXJ4G30c/qfTPNrXPNG31i+y7PBX5dk2V3815K8xsdDWXNthrL2P
	DCGwngxD4quxirSzuQBP3abS2pwF/bheeCcZSoSUnj9cDA5QmfkzH4awaq5U288B
	21GBxYqmYyuX5NGdLIQi9MhZMi8J3dACvYT3cXDtYP/e3mDsoabEKftXc+pf9/HD
	0P16RPyI5VUOp3Vpk+G+7u3IwIU+W/+dhBmZ4BTl22GaRy+jj1JL9A37J5gj2BF/
	HVMBiK6DSqUPWwn3ER+zB/anvDQ/mUDbPnycHvc8/Pw5ol5BlVxpyViY2gC3vPrN
	KLUY9UZhbg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011003.outbound.protection.outlook.com [40.93.194.3])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c09v6mqhs-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 13:34:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIw0btJtMo45Hl2z1HSRJee9hCj2FwGNigqQ5YGSgKQEgqUXMLfMT8TAppgRp1DzhO/OnJzjw4ChnKEqseYDL91uOdsWShC5IXrnE2EJ9zsZ4ZWQQdStkOAUHtPTO7Uvp+nG+hJMr39o8RQmYDM0SvbCsmwiEqzkAqeik5ude/WTySSeQaDve586zbnzEjfwlAjHTDpNmEukfpq9gkzjCszfO/Fz13GLv2+uL+99qZJifOkbcgc39y1Mk6K8nFPhbXhxKJapUS1HGcSJEOUmGAs9l1hYE3fJoWAmACzfVn5Q5I27Uu4yHa3IxSZSDwtjf7GB435zWX14DZVbloerUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHYt8asWoI0jyYywztwTXE+xbZeL117GB51t4iOR5m0=;
 b=vW2YiGyqgTrAxB9nCEvrvl1svflc8aVaYTrpy7kLmj2cM5F3T4uBEzBTF0WdndnLcW7zfumnME3QRHGmNKoMrZe112ZwX+/7+roOlnY2K9w14PaYqoxKtqk37BeJ/bSGz1KGtV2fAGJnJQivx0y+ybNZW8js3ti0g7wv8xJlBN8yMqvHQ7E6m+S5rZsIR7xtf8dmXcaSjR/93dA+ip2VhRH+9zSvgbyHSZnYehhYLvP/QDMy5llZ8MdnPCQE2RYXxlRlwfwRwIbHj3kv6Pvm0ajMrMDZudctAEGcDFWzfEg+QsvIfYUTKl6hAbqMGu+/bDQZhMd+A1jbmUtV3e3h2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BLAPR15MB3889.namprd15.prod.outlook.com (2603:10b6:208:27a::11)
 by SN7PR15MB4173.namprd15.prod.outlook.com (2603:10b6:806:10f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Thu, 29 Jan
 2026 21:34:00 +0000
Received: from BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044]) by BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 21:34:00 +0000
Message-ID: <21c8046f-cc80-4063-b6f3-f8a1e9f8d5c2@meta.com>
Date: Thu, 29 Jan 2026 13:33:42 -0800
User-Agent: Mozilla Thunderbird
From: Vishwanath Seshagiri <vishs@meta.com>
Subject: Re: [PATCH v2 net-next 2/2] selftests: virtio_net: add buffer
 circulation test
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
 <20260128212031.1431746-3-vishs@meta.com>
 <20260128171144-mutt-send-email-mst@kernel.org>
Content-Language: en-US
In-Reply-To: <20260128171144-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0225.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::20) To BLAPR15MB3889.namprd15.prod.outlook.com
 (2603:10b6:208:27a::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR15MB3889:EE_|SN7PR15MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c4e848-9cbc-4927-90a2-08de5f7e1d54
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TW1KeFRoWjVWWU54Zi8xdXp3eTBwekZHMzFjQ0VkbHUweExIT0tKYjZKZjJv?=
 =?utf-8?B?R1BIdXNrUVdLZndWSFBDSEkzeXRVUEorUXBWejBvUEdtbjJzdVJlbmViT2V5?=
 =?utf-8?B?QktLbFQxMTh1cWJGczZqSHRkcUdoSGVwVE0wOHNrdDlDODJJVVJCMXF1NUgx?=
 =?utf-8?B?RU9Gdkh0YUJ5a2NzNERFQjJ4cHM2RnBVbkRGSncwRGFyaDR2OHRWd2d6a2ZF?=
 =?utf-8?B?K3VJclp3QlZucE5qZ2R6YTl3OWlvTS9PVExKTkZlNWlNY085Sk1uREdjY2N3?=
 =?utf-8?B?dzZUSGtBU0Q2b0FlRWtMODBVelNoOU9IdUVYU0ljVW51M2s0RUliN0hNZlRO?=
 =?utf-8?B?M0taTTVyQXJCeTFBM3ZzWE92eVFuWUVyMTFQd2s4djFmQWgySjVaRG93ZnV0?=
 =?utf-8?B?V1BkeUxTOFh4cXpEZjN5RVdsYTFyNHJJU2NsbEhCUGpPVFV6YUJyd1ZSZHhY?=
 =?utf-8?B?T1RpVTZ0bE9QV1d6NVFSc2luMy80ZEhGQnFsVG51R3pRRzVBZVVrY2hQOGZq?=
 =?utf-8?B?Zkh5OTY5SnZ2UDMxNmpWN1JFU256QXlRTmtlOTVueit5Si9MZ3R3bHlHWk9K?=
 =?utf-8?B?VHJKRHVhN1puTG9vVnlTeXBMTXIvSVJIbm1ZZmhGQy9waTZvMGt4VGlmdTYr?=
 =?utf-8?B?ZFA4MXBnYnc4RlhiS2k4TW9YS29RejZBakNTU0pmU0VuYlpYUnEraEx6cjYx?=
 =?utf-8?B?KzNYNWpyKzlUTzBwa0d2ZURyVzF2WXZqQnRLWURBUFlVbThkWHBkNUdDWGo2?=
 =?utf-8?B?RDAxQkhyRE8yV3I5M0pBVzFGc2V4WWZLcFZ5bVFnOHdtSzIrdDdXQyt4eEc5?=
 =?utf-8?B?b3BZcW1qWG1ZMXFYMTViUy9ud0htWi9BeGJLbTF0Z2lmODJockNaT2hlUHJM?=
 =?utf-8?B?Rjc0Sm9GbENiMHptckVYemZvUjhyT1NyNWpNTG5KWFdHUHZ3V25wZjR5L3Bh?=
 =?utf-8?B?RFJWUHFzVk1SclVIYlpxY3dmTkFLL0NGUXlCeXlBbGVDSTR0dktUbUk1cENH?=
 =?utf-8?B?RDltSnRjczZoMnlTRjVmUFU3b3dQMytxak9FRDZWelAxTkRwZEhpbERPYmQy?=
 =?utf-8?B?c3JSQkQybEovMzJmUjBPYmNjWlIwclh1ZG81SG5BcWtoRVo4YmQ5TkcxRm5l?=
 =?utf-8?B?M1NEQjk5R1hPajJLdjhKcXFrQlplTjVCRHIwcG1UK0lOVzgxWTF4MCtXeEkx?=
 =?utf-8?B?cUJlaDFCUUV6K3ZkQS9GNGt5TlBHQW1uYTlLVXFXZTBPVXJFeGVKZ0tNOXFB?=
 =?utf-8?B?T3VHNmdaN3plUncranlWNVJrRmxXdlRlSkxZSzYwZEh6Rk9mNnlKWENtakJV?=
 =?utf-8?B?ckZYUGluTGNhT05XcENqZFdvcDlaQ0dldDd3WmUweGFCUDNwZVJiUUFZKzFZ?=
 =?utf-8?B?b2hleW5xVFZxMXJNQTlxUWF0bGlsOEdXaGdybDRLc1RPUUlWQU83bWFtU0wz?=
 =?utf-8?B?SnhrRi9mcWVpSDRnUmthMElxdzY0cFdxR29MdGd0ZXUrdUlZSndGdUVBSkF5?=
 =?utf-8?B?M1JURXVaNDB1WHZhQVpZVUtkQk05SDRLNTEyMXFBZHlmb3B3amtJT3QwM1BC?=
 =?utf-8?B?R0VDVCtTaHYxTzJwWVl1akJCN2R3cjJtUElSdWtqaHFxNm8rdjZ1ZGVkSmtX?=
 =?utf-8?B?VWdiR2ZwUWowdmVLeTErcG5IU2E2OEttckpLK1RaMHBrZHZ6Y0M5U2RZRkNI?=
 =?utf-8?B?YzRENEovZS81RWcyQWhyWGNiTDRnSllhM0ZUd0tpUDRjSTRZcnZlWFBpSWJB?=
 =?utf-8?B?TUVPTzdMMWt4NGxDc2NrTFd3bG9pcDVJMERDaE5BM1NxZW1KQ3VvWm54OVhi?=
 =?utf-8?B?V2YrZlhpWTQxRVJoQStweDRublMrdEdMVHAvU1BlZlpxMHlXa3ZrY2tNbXIz?=
 =?utf-8?B?Z1VHc0RxR1JUTUl2dFRNWENCS2VLdUJ6aUxFY3o3OTBsOFk0U3lURVkzVDNI?=
 =?utf-8?B?OVhrMzBMUEpid1hRZXRkSDBBeSs2UFFNamZydmF3dUlvUGJjejBGQ0lmNnNz?=
 =?utf-8?B?SXVveVE3K0s0K2ExcHYzc1dQSVN0YW5UNTFLQjlXV3lOS1NEVmQ4Y2doUXRj?=
 =?utf-8?B?YUVtT3liOTZNK1cwQ094VW1JSFE5empwZmk3TlkrSG1OMkpBS3hoOHRtMEZS?=
 =?utf-8?Q?N37w=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR15MB3889.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?N1NNNTNCKzlPRENuQVFydFdXd05ydytvK3pHSmVicUsrbzRYZkVHZEdCRmJR?=
 =?utf-8?B?R3YvY0psczNSSDRKME5qTWZDdUZ0R0NiSDEyWW1IT0lhMTIrL3o3YXFFTjFa?=
 =?utf-8?B?QWtKV3pwYjgwb0VrWXI0Z2loN1liZVF1cHRpUm9PRjJDemZxZDAzTmE2Q1d0?=
 =?utf-8?B?S2s5MThXaFVwdDlRMWZTU2xuN3hzeEVEU2k3QkZwRndacHhna0NweUJxYkZM?=
 =?utf-8?B?TmpDRUZnUThycm9PVzlSTWw1SmRUb01oNldLNTN5ZnhkOWZHZCtZb3BkY1M4?=
 =?utf-8?B?ZHBrd1V6YkZiUnA4ZDZ4MzBjNVRQcVA3b2NXaklzT3VheTBPVkZtSWlVR0pP?=
 =?utf-8?B?U0JMaGFHV0VhQ2p3dkZJSG9BZjBwSVdoMXlGeUF5NmNUM2t0Wkh1Wlk5a2xS?=
 =?utf-8?B?a0VMMXhBRHREbStpUEordk4xd0ZnN1pxeCtwcVhxSldIQVprQ3NOa3hHUll6?=
 =?utf-8?B?M0E2YUpRWEttR1BCcW5hSE5UY1NXZGQ1c1hTUS9WOWF6empXYStFdkU4VW52?=
 =?utf-8?B?eGxQRjVEZEwwQXEwckRkbWExWmNWMDJUZ0JIQUZkMStUZTlxWVNUd0FPMzlN?=
 =?utf-8?B?ZDZKak8xNHpma3c4U1RVVWJIcjdxVFd2NkgwalltWDBsWjB2SVlTYkc2WmZI?=
 =?utf-8?B?TnhxKy9lL3pkWVZGWmU1RklsTWtJQ3ZQcStHQzUzK0VIekhMYTdINDU1NkQ4?=
 =?utf-8?B?T2t4ekxzNW5FZzYySVZmT2ptQmt4L0Q5dFdmVlJWWnhvS1dFWmwrSlhuUFBm?=
 =?utf-8?B?cUdiazJlbWFOK2ppTGNTTDRrK1duVVIzUDJoZ3NEY05jWFQrRStMcWNYR3pp?=
 =?utf-8?B?K2JwK0ZvVjg4S2VqYkdleFMrTWVUdUp1d0pzR3QxV0oyZE5jRmFyUGZGejd2?=
 =?utf-8?B?YjN1eEtvMUh4bHFEeUhMRHhaU2VHa1hsR1Jkc25UZmtxek1DOEEvOE82Szlw?=
 =?utf-8?B?cXBqSk5neDJSSkJpQ1ZCUTNsQ1VscEZHOWlIYmhZMWE2L0d5UjhNOVdJZy9i?=
 =?utf-8?B?NnI1SE1HWjNoRlBVcEhHQ2dOajFhSCtmdXNJOTcxUVRCQWVsa0JRWVNKZjgr?=
 =?utf-8?B?dG1VUXFvaW5qN1FFUWhvdU42MHlGQzRJZnpOVkJTLzVwVVo3SDdOSTRHY0pI?=
 =?utf-8?B?R0pKUUEzVzg3NnBDMjdQQ1FnSldSUGpHVWVpT2VIWVBOa3RZY3lTU0ZOaGJw?=
 =?utf-8?B?czduZkpndEtMaHZXdS9QWUVZZUxLV253eW9xVWhnb2psMFlkeFZVMjQ5Unk5?=
 =?utf-8?B?YklRcXFEV2lIYThYOFo3UnQ0eEs4c0dMTVpPRU5QVkVObHYzZTFaOFp3YWI0?=
 =?utf-8?B?MkNKWktpNHZYMVI0ODFzb1lUV2FHdGpIK0JqcjlXU3BTdDRTbjZxYmZZajlF?=
 =?utf-8?B?ejR6dWVZcjBVRkV0bVlTbUNGa3pqM0VwU2VFK2ZqcGE5d0FyU1RLWU1uRmQw?=
 =?utf-8?B?SmtFcStpVG1DWnRXaENVSXU0NVhHUkc0amJDakdDVEp0OVpTUmhSM2sxV0c4?=
 =?utf-8?B?VDZLSGs3WUNtanlaallaUXFoRWRUc1VobktIQ3B4L1lsZXF3enJZYk5JSlRl?=
 =?utf-8?B?ZmFFS3lHV0c4VXVwaytsSnl2RFVRYXZHRHZITGVFaWZkOW9oY0xCVlRlTTJ5?=
 =?utf-8?B?eStZQ3Bwdm03b2NzekxGeFhFSnBvdVBVZGdRamtTaFVrTHZ4RWpFZ25yN0wx?=
 =?utf-8?B?RExma2V5Y1VCRXpBcWNRQld3VkNmb25wNlNQamtkYy9jeGVacm1aUStlMVRX?=
 =?utf-8?B?U0lOK25ScWxOZlFJWlFoeElVVnk2U0RYOWtId3pZSUlhK043M0hqK3ZzMmNE?=
 =?utf-8?B?SXRQYjRMYklvR21lTGdPSXRnTnh1aU9lNkJBVVhtbVRGc0RjVlM4TWZ4b2VP?=
 =?utf-8?B?ejdkaHNtRFdVNjR4bVI1SHR1UGlTb0puZys3STFRV1hkY1d2cUUxVjkyZDUr?=
 =?utf-8?B?NUhJdjhsYmhXcGVaVjVsc0tkT1phWUdDa1BuMzkwQWdQdTRiTGZsUmIwaEIy?=
 =?utf-8?B?WGQxQ29EZXpIRm5lY1c2cmNLb3NKTkp1UjFneVlidnZUeHp6NDNrSWNSNVhK?=
 =?utf-8?B?dUJPeWJnL3dhYTlJcG5iZGVzQmQ4VkltZ2FzTGRkMkpCY3ZPNS9ReXU5RjBJ?=
 =?utf-8?B?RW8xa2c4cWdONlNCc1dYOEJDYWFWM0lRN2F1eFZmbVM1a1VJempzS0E4UmR5?=
 =?utf-8?B?RWRNN01zS0NnZS9Ia0txRVByamhycnNxcmlvbCtwWmtXd25pekV6SXMwbzYy?=
 =?utf-8?B?VzJ2bVM2V1VHOFZDNmlvV0RXb1pIRlZ6akVmaGFTWVB6Y1FpdjVpckVHK3hp?=
 =?utf-8?B?alBFWmJtU3Azdzl0eHJpRm5vWEdaRi9GQ0QyVFFPTEJLaUdpSUkzRVZ5UXFy?=
 =?utf-8?Q?7OI0LmTtXWPqOEFZM49o0Xq0J4bbYyKk6NJ+1?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c4e848-9cbc-4927-90a2-08de5f7e1d54
X-MS-Exchange-CrossTenant-AuthSource: BLAPR15MB3889.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 21:34:00.0908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /44WwHsDAPWgxgKXHTAiXOHRHbCOV/Q7xAb0PuMELdePATZxU72wvi0bfbcy7NlV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4173
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDE1NyBTYWx0ZWRfX+ZecAwe1hz+2
 5sFzB5dGSCKEQkPFpcprFYxRVE8I/1ZQMV6L6ZSic8MQgaPLA8XVLOgrgv2N7pSscxozRaHW2h/
 ZDTPVaxM2Xi0MO+JEpJ6GZP6C2PvrUnyykd0QjhyBcI+zrB/UruOms42lHc17VvLqKuuLJQe/Uh
 j0zVHToQmJzi13SgTbaqMHsOof2vo7FvIE08H+GuJ8xVDAAfzKsegadunP8jtPi3cUhqINC+noN
 mclfTYpofanBrnZCAmpBF4Sad8/0WU/x1M9RJnKW9C2Q3MbcSwGduB0DcqBLFttmrkczmtWhke9
 4G75gjSiHSg9T3bMViA5sRvom4Y3AvwuBRSgIpAr11a01aXhRqnq5O3QrZiwKV2z1S18BMOBqYJ
 tHXP0XM7ucyIBZwsMspJVlS2/OkrWVu/81+yZI7OEg1ELvj2XqIOYjJrA0SDRQXv4GSrhnaz1Vl
 48Ax5KyKU7IdNWnJZ6Q==
X-Authority-Analysis: v=2.4 cv=IeyKmGqa c=1 sm=1 tr=0 ts=697bd24b cx=c_pps
 a=z66bnWj0fqQOmAclyDzAfg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VabnemYjAAAA:8 a=GrSvk28Jg1ydmiLs8XMA:9
 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: 9pLIsWElsy0WrmF8JlfbBabNdRA51vHh
X-Proofpoint-GUID: 9pLIsWElsy0WrmF8JlfbBabNdRA51vHh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
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
	TAGGED_FROM(0.00)[bounces-254916-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 7CB93B4DF2
X-Rspamd-Action: no action

On 1/28/26 2:12 PM, Michael S. Tsirkin wrote:
> On Wed, Jan 28, 2026 at 01:20:31PM -0800, Vishwanath Seshagiri wrote:
>> Add iperf3-based test to verify RX buffer handling under load.
>> Optionally logs page_pool tracepoints when available.
>>
>> Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
>> ---
>>   .../drivers/net/virtio_net/basic_features.sh  | 70 +++++++++++++++++++
>>   1 file changed, 70 insertions(+)
>>
>> diff --git a/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh b/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
>> index cf8cf816ed48..c2c8023d2b92 100755
>> --- a/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
>> +++ b/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
>> @@ -6,6 +6,7 @@
>>   ALL_TESTS="
>>   	initial_ping_test
>>   	f_mac_test
>> +	buffer_circulation_test
>>   "
>>   
>>   source virtio_net_common.sh
>> @@ -16,6 +17,8 @@ source "$lib_dir"/../../../net/forwarding/lib.sh
>>   h1=${NETIFS[p1]}
>>   h2=${NETIFS[p2]}
>>   
>> +require_command iperf3
>> +
>>   h1_create()
>>   {
>>   	simple_if_init $h1 $H1_IPV4/24 $H1_IPV6/64
>> @@ -83,6 +86,73 @@ f_mac_test()
>>   	log_test "$test_name"
>>   }
>>   
>> +buffer_circulation_test()
>> +{
>> +	RET=0
>> +	local test_name="buffer circulation"
>> +	local tracefs="/sys/kernel/tracing"
>> +
>> +	setup_cleanup
>> +	setup_prepare
>> +
>> +	ping -c 1 -I $h1 $H2_IPV4 >/dev/null
>> +	if [ $? -ne 0 ]; then
>> +		check_err 1 "Ping failed"
>> +		log_test "$test_name"
>> +		return
>> +	fi
>> +
>> +	local rx_start=$(cat /sys/class/net/$h2/statistics/rx_packets)
>> +	local tx_start=$(cat /sys/class/net/$h1/statistics/tx_packets)
>> +
>> +	if [ -d "$tracefs/events/page_pool" ]; then
>> +		echo > "$tracefs/trace"
>> +		echo 1 > "$tracefs/events/page_pool/enable"
>> +	fi
>> +
>> +	iperf3 -s --bind-dev $h2 -p 5201 &>/dev/null &
>> +	local server_pid=$!
>> +	sleep 1
>> +
>> +	if ! kill -0 $server_pid 2>/dev/null; then
>> +		if [ -d "$tracefs/events/page_pool" ]; then
>> +			echo 0 > "$tracefs/events/page_pool/enable"
>> +		fi
>> +		check_err 1 "iperf3 server died"
>> +		log_test "$test_name"
>> +		return
>> +	fi
>> +
>> +	iperf3 -c $H2_IPV4 --bind-dev $h1 -p 5201 -t 5 >/dev/null 2>&1
> 
> is using hard coded ports like this fine?
> running several in parallel will fail ...

I will use a random port in the ephemeral range to avoid
conflicts when running tests in parallel. Will fix it in v3.

> 
> 
>> +	local iperf_ret=$?
>> +
>> +	kill $server_pid 2>/dev/null || true
>> +	wait $server_pid 2>/dev/null || true
>> +
>> +	if [ -d "$tracefs/events/page_pool" ]; then
>> +		echo 0 > "$tracefs/events/page_pool/enable"
>> +		local trace="$tracefs/trace"
>> +		local hold=$(grep -c "page_pool_state_hold" "$trace" 2>/dev/null)
>> +		local release=$(grep -c "page_pool_state_release" "$trace" 2>/dev/null)
>> +		log_info "page_pool events: hold=${hold:-0}, release=${release:-0}"
>> +	fi
>> +
>> +	local rx_end=$(cat /sys/class/net/$h2/statistics/rx_packets)
>> +	local tx_end=$(cat /sys/class/net/$h1/statistics/tx_packets)
>> +	local rx_delta=$((rx_end - rx_start))
>> +	local tx_delta=$((tx_end - tx_start))
>> +
>> +	log_info "Circulated TX:$tx_delta RX:$rx_delta"
>> +
>> +	if [ $iperf_ret -ne 0 ]; then
>> +		check_err 1 "iperf3 failed"
>> +	elif [ "$rx_delta" -lt 10000 ]; then
>> +		check_err 1 "Too few packets: $rx_delta"
>> +	fi
>> +
>> +	log_test "$test_name"
>> +}
>> +
>>   setup_prepare()
>>   {
>>   	virtio_device_rebind $h1
>> -- 
>> 2.47.3
> 


