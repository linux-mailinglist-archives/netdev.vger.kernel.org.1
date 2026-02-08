Return-Path: <netdev+bounces-257864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMBKAOL0iGmOzgQAu9opvQ
	(envelope-from <netdev+bounces-257864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 21:41:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B67E710A1F8
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 21:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A8F443001CD9
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 20:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE9833F8D9;
	Sun,  8 Feb 2026 20:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="pKSh8uSx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38179258CDF;
	Sun,  8 Feb 2026 20:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770583259; cv=fail; b=rzseEQSuVvf190umaFIB+zvpT6D/heCzLckviKbMXDGk88FYWV/he6GUuen+PSU3zOCYrLag3R+7jHRZ4DGnbycl8fpBMP8q/l1qWkfdrcvWD4R02ZIuhfDDwZ+Z2GLBKCP6LjzYEm5CIcj/Hjs3nOrEM2VyDbGfJJ5SAqfaiw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770583259; c=relaxed/simple;
	bh=HzyIKRzGkDDwLSXe1YnEicVUsqQdElXnmuofamOv528=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YYurBtqar+ByPMN282Qx8fKMRA3eBJOTXdHS1/bLXLnkSGar36nI84mjBQtot7R5fie4M6GtupVtccjwVf9ND3OdWFqbanJ5Cn4DB87tWdA78JAdhonl2FScLb0E2BiM7t8aBLZ5oj2gJjmEb4wfFpn9LjZgA2yAi6GpyGi+DEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=pKSh8uSx; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 618IW4QZ116721;
	Sun, 8 Feb 2026 12:40:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=xfE7eBMlc3TG/3WdtHUX1jE1kQcXXwHgM4POVU6uPpQ=; b=pKSh8uSxIaES
	CgFuPtHg/mD73o1/yKgpfwGmHm8/OFG5jDt6tOXd4IIQ2W8qhmtoe+fChKgmQLHS
	qe5wgHju5n4qey7hZ8jglEH3JtJ5GEt+I/tAE0V63lIjQV3/BY5SqyzkQVnTScrd
	8PexRrZw4pDGVSA+vNGFRU437Dzt2BhOSNI+KTTRjL6IMkdKEeEK7CSz00kB54GM
	698COG4aKkfoxhAPtiBdXLxqC4udFDZXKI0hoWJsbZ4xH5wH55XrIyscFI8pRWwZ
	DIWtzZGLsHnuGyi/Umau+9aQg7Zj5XZspsME45fagwgtkRdrymjLXfL2uKi0p+2w
	o9boQ9b+dw==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010063.outbound.protection.outlook.com [52.101.85.63])
	by m0089730.ppops.net (PPS) with ESMTPS id 4c6yuq0sa0-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 08 Feb 2026 12:40:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAqMoJX/7tf+yucmuMlTnabkPQ3Nd+ZIDvE+1bDFkD4C6dZJh0Nyidp2VWtUi8aP47N/P+t7tBmnpCQayxx/SBK1k+2CGYAiHnb+N6OCbFSg3XeAJJlKzEvQAO00KF/pQ/7SZsDqToz3UZ9dUy/RjUab86rFlgnX8NsrO4/gnr/mwFqRKJEeoIgUPhW4WXCwPOyQSo3OTg/youdCHsa9pNs8fXMtrc+kOo1LSdvGeKXP+FReGNNBroqCvzVn0duDDF7Yf44M6e/b7PfY/ph0XIx/akhmWXGRmBlMsOio8TGbF8rHRMfSu2uauR+2hd7VEoYCST2j2i9DjrqLCtWTGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfE7eBMlc3TG/3WdtHUX1jE1kQcXXwHgM4POVU6uPpQ=;
 b=O0HFVVyRR3FNGDY6IK2x5fxF2gFzOZ9zplLcTqRv6PkzUxL0obrL+PBlkT9Gp9Or9e7PV0i6dIk1ca2aIWjycQ8GQc3WXxvUZnEMyyCFMzXrdQSMf0Wuc0piWn7OTL7DhLY8QqW/lZsDKEYmxJW73c2qkq9RjquDifZxwADb8cCfWov7ytC7pSWoMVD8VqTGyf+q/+5CKuRPFshJbZBraIDSBUc7PPyQT927b46yoHE4JbsyGr3UvcGNNBPgf7DaskYsGiefpLBzLJO6nW4Q8EtwxyKVr1i18M4giK3MjD1fyVhxg/QrA8Qkh0HWNuHfH/PZ/VGXRL30b5oKe4w8Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BLAPR15MB3889.namprd15.prod.outlook.com (2603:10b6:208:27a::11)
 by PH0PR15MB5037.namprd15.prod.outlook.com (2603:10b6:510:cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 20:40:40 +0000
Received: from BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044]) by BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044%5]) with mapi id 15.20.9587.013; Sun, 8 Feb 2026
 20:40:39 +0000
Message-ID: <87479293-96c9-4560-b7d7-c3ea6b10d9d9@meta.com>
Date: Sun, 8 Feb 2026 12:40:29 -0800
User-Agent: Mozilla Thunderbird
From: Vishwanath Seshagiri <vishs@meta.com>
Subject: Re: [PATCH v6] virtio_net: add page_pool support for buffer
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
References: <20260208175410.1910001-1-vishs@meta.com>
 <20260208131355-mutt-send-email-mst@kernel.org>
 <3e6f368f-8c52-487c-816c-4dae13c70478@meta.com>
 <20260208140302-mutt-send-email-mst@kernel.org>
Content-Language: en-US
In-Reply-To: <20260208140302-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::45) To BLAPR15MB3889.namprd15.prod.outlook.com
 (2603:10b6:208:27a::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR15MB3889:EE_|PH0PR15MB5037:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b237a8e-c394-4532-c280-08de6752520f
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NThIcmpFWlZaSDM5bEVFcWd6amlsMVh1eWwwVXhjTUJHMTgrbnhoY0pYUzVB?=
 =?utf-8?B?VVFvWUc2NjZUT1hqalVrbHc0OGZxYUdHdk9XbGhuSkZ6VlIzdkpMd3hpMnJZ?=
 =?utf-8?B?WE1uR1BrUkhGVUdqUVZoN2tmL0cvTnJsQXhUaFVUelNhVklVKzV4K1VRWVJr?=
 =?utf-8?B?SDM5OEFoMVVRTFliT1VscEFQcWVMYlVjc2RaeWdZY3JtUGpDZlhPWHZoRllx?=
 =?utf-8?B?NVRIVW55V0pYT3NXcU10RGFFNWsxSjhCbDZSRVJKTXpJSmFOclBpazhFOVo0?=
 =?utf-8?B?emZuS2ZPT2R3dlJrNE9XWDBDUEVGVko0aE45SDh4S1JPc254K1dpcTJCZTM0?=
 =?utf-8?B?cHp2QjZDRDNNb1dQMU90d2JQQzlvRTBoa2hYNkl0cUpZWmFMMnhTeDFzOXAz?=
 =?utf-8?B?UTcrekRwUlBHc0w5Y0VDNEFZcC9KZUJIVHU3Y3dCQThKR0RPSDl4SDIxUDhi?=
 =?utf-8?B?Tm1Ia3E1WEd1MVFjb0Y3aVpycmg3WGFyYWQyb2ZiRFdwR0lBWE53ZEZpMGtU?=
 =?utf-8?B?cTNKMWlEaEFGNHJYZnRTVWg3WC94SnM1QWpoUkI4UXA1WlBXVk9TSnhIeWlq?=
 =?utf-8?B?Zy8zbGRiY0lpNlJlTXQ2Z2pTTGFXTWhtQzdiaVM2bm05eHd6bXY5Q2Z3ZXpP?=
 =?utf-8?B?ZHNaS2xMMCtOczRUWEtOTDdiM0Vyc0FHaUdVcTRJQis4QnJ5bVlFbWk0NWQ2?=
 =?utf-8?B?aWUzb3puKzAvTkQwbTR3SjEzMUhrK0FveVY3RVBDL2c4L3NtNXJ2Si9BWm9t?=
 =?utf-8?B?eExvbVNyNCtiOWZYbi9SbzlNWnpIMEV1SU9HUTJIQkMrTWN0N0hFNzA0dFNE?=
 =?utf-8?B?OEo4dDlJNkswaTErZ0ErQTQ3RU9UNFBJZ3RZUmF4RkkxTlNHMTlUTjNSU0pR?=
 =?utf-8?B?Z3UvUWl2UFBocW44MGRPZ2h4MWkrcFlYbzdOOGs4b2Q3UFRpZ1RaaVlnWlE2?=
 =?utf-8?B?clp4QSs5UnJIRXVZWFBxN1p3VWZ2KzhhV1IrWWVkc1pndFB5RExVcVlTN0VO?=
 =?utf-8?B?ekFEM0RjdTh5dTcxVHRUdkg2S0N1Ni9WTkhNbGNUQ0tiYWg1amJmdmhOUUV6?=
 =?utf-8?B?Q2tjM21wSENBaWFpMHFwYkJqQWtLV3F0OWJ3R1lDemVVRlkvUzhERzNlOUxK?=
 =?utf-8?B?Q3RiRm9sekVyQVIwNy9DUGFhZlh6T01wYXYyR200S1hKMXc1cE5paE9WTWQ1?=
 =?utf-8?B?VFFqU2lRT3k2a28wR1d4WnZaMnJpM3FFU1VUTXB4Ri9OMGVSSmVVZ3JWSXpE?=
 =?utf-8?B?T3YzWnpqQ0w4UFNxcm9TOFpUMENQVHRjcmZ2S0VCMjNaSUJUV3hoZWcxTDRI?=
 =?utf-8?B?M3BPN1dzN2JOMEZSd0ozbGRKa1JaWVFxaythNEhkRWhsdzlWSVNFY2F6ZXNG?=
 =?utf-8?B?WDNlY1ZjN0dPMkI5eFN6UzBRbXFBeHI0c1ozaXk2cldEYjVoalppTGFVdHd3?=
 =?utf-8?B?TndNcGVKc2ZxYm1Vb3pUdzBZcW9zeStlN2lIVTd4dGtDZDFxTFB1cng3T0wx?=
 =?utf-8?B?K3oxeXAyNEM2V3BUS0t4RjBtMUVKTlNYcHEvbWNZLy9vMnVQc20yTmNIcUpD?=
 =?utf-8?B?UHRMMDVqZURJSGlWbXFMSE43RDZwS09aM1crclZKVGt2dDFJQnBTMVJFbDNq?=
 =?utf-8?B?YTliTU9RZ1lSR0pkZm4wMjk5WThaa1pZZmRCajg3dy9IdHVvZGk1b0ZQSENy?=
 =?utf-8?B?K2pmVEVpbC9qZ3lsaXJCYWxBcnhkZDYzY2RDOVhyVGZrOTNJS3J4SFErYkE4?=
 =?utf-8?B?MEt3b0NENXRISzBndE9Od1grOFpMK2RtNE1UQkJURGFSK2FmOTZQWm8vYi9I?=
 =?utf-8?B?YTRuMityL2RVRlJxR2hLNm5Cdk1VUzhjNzg2cVBBUmIxaUEyY0FLSER2dUpG?=
 =?utf-8?B?aWJ2eE0vQUljbzJUNVJPejhmUVVmaElXaEwvVHFJc2xMRkl4a25DVkw3VTg4?=
 =?utf-8?B?b0Z3RFM3NVpyRU44ZkZsUXFXaFBsUlg1RFBUR3A3OTZQUXYyQ09FRnpJMkEw?=
 =?utf-8?B?a210VG1JUEdZczluVEtwTWZ1R0l1UzhXOElMWGk1SzB0cFVYOXNTVzE3NXow?=
 =?utf-8?B?Z0hIRG1VRWpLNERIRzZhVlo0eUlDTTUxWlZKUGNWM2dxMkV2RnZlZ0J3emE3?=
 =?utf-8?Q?j2c4=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR15MB3889.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?R2VTTVI5Y3BFb3cxYmk1Z2M0SGNSY0Nsemx2WHkrYUVEeHpGVVF5Yk9NRTB2?=
 =?utf-8?B?ajR5Q1dacEIrOGZWQk5HNnBoZGdLVXU0bUh2S1lZMGZ1MkxNN3pwV0U4aGZ2?=
 =?utf-8?B?UVIvQ3l1NGZmYnFwdFJBR2hGeXV4Tm1OMXkwWDBoZUZ2Q3EreGtKNHd0Mkdk?=
 =?utf-8?B?ZGIzY2lsZzNaVW1CM3Zvc05VRklJaysvcndTYUFKV3d3TXE2Z2F0RDRnb1ZL?=
 =?utf-8?B?QllzQWVqbjlwMFZ3K1ozb2NTUTVpMGhlY3hnLzdtbkNjQk5sb1FuamxKbm9T?=
 =?utf-8?B?dk82amNaNWFuRnlQK2poVGM5QnNNL0JSaHFENFhEaFZ3b251cSs4SG4zM1FJ?=
 =?utf-8?B?TDdxTVB1dFd0MDlEcmpzeEtWWGRZYUpveVNpMGorSkxZbFM0Yk1OSzZlb2RZ?=
 =?utf-8?B?L0ZQdjF6UGZJaHFxNDZvNFdPTkZwOFBHdlk2WHl1YjFGOHN2UDROUTVtSlhk?=
 =?utf-8?B?N0Njckw5N1lpZm1PZTNoNlh1bDB4c1YvREs5MVE4T1BkU0FQa3c3Y2t2SHBJ?=
 =?utf-8?B?Z1NERUlGTzIxZDVJSjFreDlFc0xaZWk4VS9BVll2TUdnTGxEU00vQ0gxWkNp?=
 =?utf-8?B?cXRWUjBnNXJnS0dHckUxaDVoWGdXZWZ3a0Z4QVViWlpud2JlZzlMUFltN3ps?=
 =?utf-8?B?VnRWeHFrVWE4QlJ1WXA4eDZ0VG8xQnNadVhGYllRS3VaYWZ5SER3M3RRR1lU?=
 =?utf-8?B?YW40UVN4eGlHTHdIYkdkMTh2bThIc3FLR2FDZE5qYTBncE5YSWVrM1JHdVJ1?=
 =?utf-8?B?QlA4OGVuL2dsUTdZUkdSZmdKNkwwSTBjL0FyY2RBV3VoWTVaUzE2SUtHVmJY?=
 =?utf-8?B?K3VzU2V1MVROTEw5RGlxam4ydyswREhtSnA3ek5ZVnl3VXNNd1VuZU14T0VJ?=
 =?utf-8?B?eVFVRlBRNmtLWXFxWHFuaW1jT0ZiQitBVXBUWkRBZjNlMHNCelZtKzEreEZ3?=
 =?utf-8?B?bWd0T3ZQYTE0ZkNPSEkrWldRTk1HZnNtcjlXbC9PNVFmZnluOG5ueHF6cU9O?=
 =?utf-8?B?NTlFdXRhMWVmZ3lvbU8xK25MQ05SZjFQeXRqdzBDSjVUYUI3elZ2RmFRNHJx?=
 =?utf-8?B?N3V0M3F1MWphckFGTEd3TGFvS1BNbDRUSzloSDljQmVlWDlkcUpLV1l3SGNn?=
 =?utf-8?B?d29UOVpMcVRVc3ZJNEdLaDJma2JzVG1SekpFekFIQTNPU1RzNVZDMjNVa0pI?=
 =?utf-8?B?R3U4UWk1RDhIUk1URUJJVkloZWlHa3Nza2lzckpxZmVBd1IxMnRGT050VW9L?=
 =?utf-8?B?ZFBZcE1aYldsNk9kaXptSXlpd3ZVczFIelJNOGZuai9oK1VYSGJKcFE5Y1Av?=
 =?utf-8?B?SVlmaW05VG9mbzF6clh2d0tzVFRvL1A3bXlnTi9zZkI4TzNSRlVPTk1FMkY0?=
 =?utf-8?B?OWp0bTBHWmRPdG1RVlNuaXhBODdCUU9sOC9Ib1prclN1Umh4YVhnUWZiQ1Bk?=
 =?utf-8?B?cXpCcGNCdXllNExuZEZ6VzU3WTRzOGZ0dlBGM0ptRGxVeU9JQmg3Rjd6UHZt?=
 =?utf-8?B?eHZDK0ttZ2RUOE1SWnJISmd5SWgrcDhLY0RLWHdBcXJqdWdtZGFqbEtNQnlo?=
 =?utf-8?B?YUpxWEw4R0w5eUtPSm1XeHpEbjFKaTl5TGttYVNBQjl0TzYwdWxmV3VRMWRC?=
 =?utf-8?B?RFNHa202Y0hRRmY1cXpmTkYwbGR1VG51dWZyWGEzR202UldDOWtFUnRreGNB?=
 =?utf-8?B?TEc4OUE5Yk5YZXI4cVZzeFpkb3NvaHBnZGNnK1lGZWpaaS9aQzk3RlN6aC9w?=
 =?utf-8?B?TGFFc1ZFeDRVb2d5NlNza253RUJMRkswOVBvbXNSQ3RCLzUwVmV4cndpVHdl?=
 =?utf-8?B?Sno4NWJNRExDZkk4b1VhOXowUnFtbG45QVRwYjM0Z0ZFUGFkQTJxdlVDUUhD?=
 =?utf-8?B?a0Ixay9FYjJhVXlrVzRpSjcrb3h6cmZ0M3JmT1g3SnMyNDRReWxxOFMrUHJj?=
 =?utf-8?B?MU45cEh1WGhrV2Zab3duanEvQ2kyV0RkZWhsYURGNG5MVGdyVkliWmJwR2hU?=
 =?utf-8?B?L3lLekdmK3lYQldYdzlWZXpTemFJRjJnSERDb09FNExiWXkxSkcrZURZdEFE?=
 =?utf-8?B?K0tqZjFrNzFsUktIUmtIT2hoR3ozMUR6YUtTZ1FSdmdySWhtYjdQM1pGbjY5?=
 =?utf-8?B?SElEbElDVDg0MkQ5ZmZWRmJQeHA2S09JVGxVSExjdTQwd1k0WUlwOFpDTkRz?=
 =?utf-8?B?TkVEWEx6THgvbm83OFhRclZjV1pFcnRNL1MrRHR4WXdVS3Zjb2dERU40VWdv?=
 =?utf-8?B?T0pENjFLb2F5TjQ0cURwTnFkVXVYRkE3R1BwVXJ2QXZ4dUFURnI0YWFUSjdG?=
 =?utf-8?B?SUxkcTJuKzl6VUpicmhyL3Vxc0Y5WFNzbkxadjQ2S0ZFc202MkVBYUJqWlVS?=
 =?utf-8?Q?53buobxOcGjZg+4Qrn6mK4erlilPfW9DUSoL4?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b237a8e-c394-4532-c280-08de6752520f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR15MB3889.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 20:40:39.6901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gxfZZPfSZICzpMzysGkUkozkkeE3C65tuzhXKTl8wdqmTm8hXOoV7C6VbFRB6tNl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5037
X-Authority-Analysis: v=2.4 cv=WZUBqkhX c=1 sm=1 tr=0 ts=6988f4cb cx=c_pps
 a=mOz+rD6hbbSUvRiPFvEd3g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=940HtmYJq-ZW6wbYau4A:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: JSsvaZD1sVOROUB7KZ7_BiaVUrn_8m4M
X-Proofpoint-GUID: JSsvaZD1sVOROUB7KZ7_BiaVUrn_8m4M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA4MDE3OCBTYWx0ZWRfX2m1eBn3EUdpc
 rLvadJ4SsRIlv4ECgS/Rov8JWi38110tc0rfm1rDUr+t4T4hSH+zpev+/usz78F3W+g7+/kmAt1
 YqMWmtPBcOz7b9fr+ETacpAU8/wzv8uZymGMNFm/y3mvzyXq4Vw93icO6DrdrRF8SX0Up5CsOmR
 B4LxVkD5M+QM2G/rMHEwMj1+r66XckAMAcaePTin3qWG3rZcBcQz+b8HOjUSxD1R6dWQAYpXEDF
 i9Pp+XskU4WQ2jw2ck/4d9/ErcCMSEBVcp7RFBF6FenYtgdWwTgD1qq0zDsZ5EjaF6pAJFhpvLJ
 dzwMEuCuHrfpAsOUYQyuKb69/o9NX8eoFAo+nSvooFGTfwXi96/tEI0abpurk2Nvlo+deFGxzHL
 uN1MNTQ2d0dhySmbEvCnz0fVUXXa7610Lg4I/VvzAuMFkBQjnxpdsM1H6ImV1izEBkVK4XyWUdU
 jzzgjWkXRsSVZQMY2Wg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257864-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:dkim,meta.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishs@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B67E710A1F8
X-Rspamd-Action: no action

On 2/8/26 11:05 AM, Michael S. Tsirkin wrote:
> On Sun, Feb 08, 2026 at 10:56:15AM -0800, Vishwanath Seshagiri wrote:
>> On 2/8/26 10:42 AM, Michael S. Tsirkin wrote:
>>> On Sun, Feb 08, 2026 at 09:54:10AM -0800, Vishwanath Seshagiri wrote:
>>>> Use page_pool for RX buffer allocation in mergeable and small buffer
>>>> modes to enable page recycling and avoid repeated page allocator calls.
>>>> skb_mark_for_recycle() enables page reuse in the network stack.
>>>>
>>>> Big packets mode is unchanged because it uses page->private for linked
>>>> list chaining of multiple pages per buffer, which conflicts with
>>>> page_pool's internal use of page->private.
>>>>
>>>> Implement conditional DMA premapping using virtqueue_dma_dev():
>>>> - When non-NULL (vhost, virtio-pci): use PP_FLAG_DMA_MAP with page_pool
>>>>     handling DMA mapping, submit via virtqueue_add_inbuf_premapped()
>>>> - When NULL (VDUSE, direct physical): page_pool handles allocation only,
>>>>     submit via virtqueue_add_inbuf_ctx()
>>>>
>>>> This preserves the DMA premapping optimization from commit 31f3cd4e5756b
>>>> ("virtio-net: rq submits premapped per-buffer") while adding page_pool
>>>> support as a prerequisite for future zero-copy features (devmem TCP,
>>>> io_uring ZCRX).
>>>>
>>>> Page pools are created in probe and destroyed in remove (not open/close),
>>>> following existing driver behavior where RX buffers remain in virtqueues
>>>> across interface state changes.
>>>>
>>>> Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
>>>> ---
>>>> Changes in v6:
>>>> - Drop page_pool_frag_offset_add() helper and switch to page_pool_alloc_va();
>>>>     page_pool_alloc_netmem() already handles internal fragmentation internally
>>>>     (Jakub Kicinski)
>>>> - v5:
>>>>     https://lore.kernel.org/virtualization/20260206002715.1885869-1-vishs@meta.com/
>>>>
>>>> Benchmark results:
>>>>
>>>> Configuration: pktgen TX -> tap -> vhost-net | virtio-net RX -> XDP_DROP
>>>>
>>>> Small packets (64 bytes, mrg_rxbuf=off):
>>>>     1Q:  853,493 -> 868,923 pps  (+1.8%)
>>>>     2Q: 1,655,793 -> 1,696,707 pps (+2.5%)
>>>>     4Q: 3,143,375 -> 3,302,511 pps (+5.1%)
>>>>     8Q: 6,082,590 -> 6,156,894 pps (+1.2%)
>>>>
>>>> Mergeable RX (64 bytes):
>>>>     1Q:   766,168 ->   814,493 pps  (+6.3%)
>>>>     2Q: 1,384,871 -> 1,670,639 pps (+20.6%)
>>>>     4Q: 2,773,081 -> 3,080,574 pps (+11.1%)
>>>>     8Q: 5,600,615 -> 6,043,891 pps  (+7.9%)
>>>>
>>>> Mergeable RX (1500 bytes):
>>>>     1Q:   741,579 ->   785,442 pps  (+5.9%)
>>>>     2Q: 1,310,043 -> 1,534,554 pps (+17.1%)
>>>>     4Q: 2,748,700 -> 2,890,582 pps  (+5.2%)
>>>>     8Q: 5,348,589 -> 5,618,664 pps  (+5.0%)
>>>>
>>>>    drivers/net/Kconfig      |   1 +
>>>>    drivers/net/virtio_net.c | 434 +++++++++++++++++++--------------------
>>>>    2 files changed, 217 insertions(+), 218 deletions(-)
>>>>
>>>> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
>>>> index ac12eaf11755..f1e6b6b0a86f 100644
>>>> --- a/drivers/net/Kconfig
>>>> +++ b/drivers/net/Kconfig
>>>> @@ -450,6 +450,7 @@ config VIRTIO_NET
>>>>    	depends on VIRTIO
>>>>    	select NET_FAILOVER
>>>>    	select DIMLIB
>>>> +	select PAGE_POOL
>>>>    	help
>>>>    	  This is the virtual network driver for virtio.  It can be used with
>>>>    	  QEMU based VMMs (like KVM or Xen).  Say Y or M.
>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>> index db88dcaefb20..5055df56e4a7 100644
>>>> --- a/drivers/net/virtio_net.c
>>>> +++ b/drivers/net/virtio_net.c
>>>> @@ -26,6 +26,7 @@
>>>>    #include <net/netdev_rx_queue.h>
>>>>    #include <net/netdev_queues.h>
>>>>    #include <net/xdp_sock_drv.h>
>>>> +#include <net/page_pool/helpers.h>
>>>>    static int napi_weight = NAPI_POLL_WEIGHT;
>>>>    module_param(napi_weight, int, 0444);
>>>> @@ -290,14 +291,6 @@ struct virtnet_interrupt_coalesce {
>>>>    	u32 max_usecs;
>>>>    };
>>>> -/* The dma information of pages allocated at a time. */
>>>> -struct virtnet_rq_dma {
>>>> -	dma_addr_t addr;
>>>> -	u32 ref;
>>>> -	u16 len;
>>>> -	u16 need_sync;
>>>> -};
>>>> -
>>>>    /* Internal representation of a send virtqueue */
>>>>    struct send_queue {
>>>>    	/* Virtqueue associated with this send _queue */
>>>> @@ -356,8 +349,10 @@ struct receive_queue {
>>>>    	/* Average packet length for mergeable receive buffers. */
>>>>    	struct ewma_pkt_len mrg_avg_pkt_len;
>>>> -	/* Page frag for packet buffer allocation. */
>>>> -	struct page_frag alloc_frag;
>>>> +	struct page_pool *page_pool;
>>>> +
>>>> +	/* True if page_pool handles DMA mapping via PP_FLAG_DMA_MAP */
>>>> +	bool use_page_pool_dma;
>>>>    	/* RX: fragments + linear part + virtio header */
>>>>    	struct scatterlist sg[MAX_SKB_FRAGS + 2];
>>>> @@ -370,9 +365,6 @@ struct receive_queue {
>>>>    	struct xdp_rxq_info xdp_rxq;
>>>> -	/* Record the last dma info to free after new pages is allocated. */
>>>> -	struct virtnet_rq_dma *last_dma;
>>>> -
>>>>    	struct xsk_buff_pool *xsk_pool;
>>>>    	/* xdp rxq used by xsk */
>>>> @@ -521,11 +513,13 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
>>>>    			       struct virtnet_rq_stats *stats);
>>>>    static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
>>>>    				 struct sk_buff *skb, u8 flags);
>>>> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>>>> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
>>>> +					       struct sk_buff *head_skb,
>>>>    					       struct sk_buff *curr_skb,
>>>>    					       struct page *page, void *buf,
>>>>    					       int len, int truesize);
>>>>    static void virtnet_xsk_completed(struct send_queue *sq, int num);
>>>> +static void free_unused_bufs(struct virtnet_info *vi);
>>>>    enum virtnet_xmit_type {
>>>>    	VIRTNET_XMIT_TYPE_SKB,
>>>> @@ -706,15 +700,24 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
>>>>    	return p;
>>>>    }
>>>> +static void virtnet_put_page(struct receive_queue *rq, struct page *page,
>>>> +			     bool allow_direct)
>>>> +{
>>>> +	if (page_pool_page_is_pp(page))
>>>> +		page_pool_put_page(rq->page_pool, page, -1, allow_direct);
>>>> +	else
>>>> +		put_page(page);
>>>> +}
>>>> +
>>>>    static void virtnet_rq_free_buf(struct virtnet_info *vi,
>>>>    				struct receive_queue *rq, void *buf)
>>>>    {
>>>>    	if (vi->mergeable_rx_bufs)
>>>> -		put_page(virt_to_head_page(buf));
>>>> +		virtnet_put_page(rq, virt_to_head_page(buf), false);
>>>>    	else if (vi->big_packets)
>>>>    		give_pages(rq, buf);
>>>>    	else
>>>> -		put_page(virt_to_head_page(buf));
>>>> +		virtnet_put_page(rq, virt_to_head_page(buf), false);
>>>
>>> equivalently:
>>>
>>> 	if (vi->big_packets && !vi->mergeable_rx_bufs)
>>>     		give_pages(rq, buf);
>>> 	else
>>> 		virtnet_put_page(rq, virt_to_head_page(buf), false);
>>>
>>> and then it matches the check we have like in 10 places in
>>> this file.
>>>
>>> maybe it's time for a helper that does vi->big_packets &&
>>> !vi->mergeable_rx_bufs?
>>>
>>> maybe virtnet_no_page_pool()?
>>
>> Good idea. I will create the virtnet_no_page_pool() api and use
>> that for making intent clear.
>>
>>>
>>>
>>>
>>>
>>>>    }
>>>>    static void enable_rx_mode_work(struct virtnet_info *vi)
>>>> @@ -876,10 +879,16 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>>>    		skb = virtnet_build_skb(buf, truesize, p - buf, len);
>>>>    		if (unlikely(!skb))
>>>>    			return NULL;
>>>> +		/* Big packets mode chains pages via page->private, which is
>>>> +		 * incompatible with the way page_pool uses page->private.
>>>> +		 * Currently, big packets mode doesn't use page pools.
>>>> +		 */
>>>> +		if (vi->big_packets && !vi->mergeable_rx_bufs) {
>>>> +			page = (struct page *)page->private;
>>>> +			if (page)
>>>> +				give_pages(rq, page);
>>>> +		}
>>>> -		page = (struct page *)page->private;
>>>> -		if (page)
>>>> -			give_pages(rq, page);
>>>>    		goto ok;
>>>>    	}
>>>> @@ -925,133 +934,18 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>>>    	hdr = skb_vnet_common_hdr(skb);
>>>>    	memcpy(hdr, hdr_p, hdr_len);
>>>>    	if (page_to_free)
>>>> -		put_page(page_to_free);
>>>> +		virtnet_put_page(rq, page_to_free, true);
>>>>    	return skb;
>>>>    }
>>>> -static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 len)
>>>> -{
>>>> -	struct virtnet_info *vi = rq->vq->vdev->priv;
>>>> -	struct page *page = virt_to_head_page(buf);
>>>> -	struct virtnet_rq_dma *dma;
>>>> -	void *head;
>>>> -	int offset;
>>>> -
>>>> -	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>>>> -
>>>> -	head = page_address(page);
>>>> -
>>>> -	dma = head;
>>>> -
>>>> -	--dma->ref;
>>>> -
>>>> -	if (dma->need_sync && len) {
>>>> -		offset = buf - (head + sizeof(*dma));
>>>> -
>>>> -		virtqueue_map_sync_single_range_for_cpu(rq->vq, dma->addr,
>>>> -							offset, len,
>>>> -							DMA_FROM_DEVICE);
>>>> -	}
>>>> -
>>>> -	if (dma->ref)
>>>> -		return;
>>>> -
>>>> -	virtqueue_unmap_single_attrs(rq->vq, dma->addr, dma->len,
>>>> -				     DMA_FROM_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
>>>> -	put_page(page);
>>>> -}
>>>> -
>>>>    static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
>>>>    {
>>>>    	struct virtnet_info *vi = rq->vq->vdev->priv;
>>>> -	void *buf;
>>>>    	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>>>> -	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
>>>> -	if (buf)
>>>> -		virtnet_rq_unmap(rq, buf, *len);
>>>> -
>>>> -	return buf;
>>>> -}
>>>> -
>>>> -static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
>>>> -{
>>>> -	struct virtnet_info *vi = rq->vq->vdev->priv;
>>>> -	struct virtnet_rq_dma *dma;
>>>> -	dma_addr_t addr;
>>>> -	u32 offset;
>>>> -	void *head;
>>>> -
>>>> -	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>>>> -
>>>> -	head = page_address(rq->alloc_frag.page);
>>>> -
>>>> -	offset = buf - head;
>>>> -
>>>> -	dma = head;
>>>> -
>>>> -	addr = dma->addr - sizeof(*dma) + offset;
>>>> -
>>>> -	sg_init_table(rq->sg, 1);
>>>> -	sg_fill_dma(rq->sg, addr, len);
>>>> -}
>>>> -
>>>> -static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
>>>> -{
>>>> -	struct page_frag *alloc_frag = &rq->alloc_frag;
>>>> -	struct virtnet_info *vi = rq->vq->vdev->priv;
>>>> -	struct virtnet_rq_dma *dma;
>>>> -	void *buf, *head;
>>>> -	dma_addr_t addr;
>>>> -
>>>> -	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>>>> -
>>>> -	head = page_address(alloc_frag->page);
>>>> -
>>>> -	dma = head;
>>>> -
>>>> -	/* new pages */
>>>> -	if (!alloc_frag->offset) {
>>>> -		if (rq->last_dma) {
>>>> -			/* Now, the new page is allocated, the last dma
>>>> -			 * will not be used. So the dma can be unmapped
>>>> -			 * if the ref is 0.
>>>> -			 */
>>>> -			virtnet_rq_unmap(rq, rq->last_dma, 0);
>>>> -			rq->last_dma = NULL;
>>>> -		}
>>>> -
>>>> -		dma->len = alloc_frag->size - sizeof(*dma);
>>>> -
>>>> -		addr = virtqueue_map_single_attrs(rq->vq, dma + 1,
>>>> -						  dma->len, DMA_FROM_DEVICE, 0);
>>>> -		if (virtqueue_map_mapping_error(rq->vq, addr))
>>>> -			return NULL;
>>>> -
>>>> -		dma->addr = addr;
>>>> -		dma->need_sync = virtqueue_map_need_sync(rq->vq, addr);
>>>> -
>>>> -		/* Add a reference to dma to prevent the entire dma from
>>>> -		 * being released during error handling. This reference
>>>> -		 * will be freed after the pages are no longer used.
>>>> -		 */
>>>> -		get_page(alloc_frag->page);
>>>> -		dma->ref = 1;
>>>> -		alloc_frag->offset = sizeof(*dma);
>>>> -
>>>> -		rq->last_dma = dma;
>>>> -	}
>>>> -
>>>> -	++dma->ref;
>>>> -
>>>> -	buf = head + alloc_frag->offset;
>>>> -
>>>> -	get_page(alloc_frag->page);
>>>> -	alloc_frag->offset += size;
>>>> -
>>>> -	return buf;
>>>> +	return virtqueue_get_buf_ctx(rq->vq, len, ctx);
>>>>    }
>>>>    static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>>>> @@ -1067,9 +961,6 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>>>>    		return;
>>>>    	}
>>>> -	if (!vi->big_packets || vi->mergeable_rx_bufs)
>>>> -		virtnet_rq_unmap(rq, buf, 0);
>>>> -
>>>>    	virtnet_rq_free_buf(vi, rq, buf);
>>>>    }
>>>> @@ -1335,7 +1226,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
>>>>    		truesize = len;
>>>> -		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
>>>> +		curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
>>>>    						    buf, len, truesize);
>>>>    		if (!curr_skb) {
>>>>    			put_page(page);
>>>> @@ -1771,7 +1662,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>>>>    	return ret;
>>>>    }
>>>> -static void put_xdp_frags(struct xdp_buff *xdp)
>>>> +static void put_xdp_frags(struct receive_queue *rq, struct xdp_buff *xdp)
>>>>    {
>>>>    	struct skb_shared_info *shinfo;
>>>>    	struct page *xdp_page;
>>>> @@ -1781,7 +1672,7 @@ static void put_xdp_frags(struct xdp_buff *xdp)
>>>>    		shinfo = xdp_get_shared_info_from_buff(xdp);
>>>>    		for (i = 0; i < shinfo->nr_frags; i++) {
>>>>    			xdp_page = skb_frag_page(&shinfo->frags[i]);
>>>> -			put_page(xdp_page);
>>>> +			virtnet_put_page(rq, xdp_page, true);
>>>>    		}
>>>>    	}
>>>>    }
>>>> @@ -1873,7 +1764,7 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>>>>    	if (page_off + *len + tailroom > PAGE_SIZE)
>>>>    		return NULL;
>>>> -	page = alloc_page(GFP_ATOMIC);
>>>> +	page = page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC);
>>>>    	if (!page)
>>>>    		return NULL;
>>>> @@ -1897,7 +1788,7 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>>>>    		off = buf - page_address(p);
>>>>    		if (check_mergeable_len(dev, ctx, buflen)) {
>>>> -			put_page(p);
>>>> +			virtnet_put_page(rq, p, true);
>>>>    			goto err_buf;
>>>>    		}
>>>> @@ -1905,21 +1796,21 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>>>>    		 * is sending packet larger than the MTU.
>>>>    		 */
>>>>    		if ((page_off + buflen + tailroom) > PAGE_SIZE) {
>>>> -			put_page(p);
>>>> +			virtnet_put_page(rq, p, true);
>>>>    			goto err_buf;
>>>>    		}
>>>>    		memcpy(page_address(page) + page_off,
>>>>    		       page_address(p) + off, buflen);
>>>>    		page_off += buflen;
>>>> -		put_page(p);
>>>> +		virtnet_put_page(rq, p, true);
>>>>    	}
>>>>    	/* Headroom does not contribute to packet length */
>>>>    	*len = page_off - XDP_PACKET_HEADROOM;
>>>>    	return page;
>>>>    err_buf:
>>>> -	__free_pages(page, 0);
>>>> +	page_pool_put_page(rq->page_pool, page, -1, true);
>>>>    	return NULL;
>>>>    }
>>>> @@ -1969,6 +1860,12 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>>>>    	unsigned int metasize = 0;
>>>>    	u32 act;
>>>> +	if (rq->use_page_pool_dma) {
>>>> +		int off = buf - page_address(page);
>>>> +
>>>> +		page_pool_dma_sync_for_cpu(rq->page_pool, page, off, len);
>>>> +	}
>>>> +
>>>
>>> hmm no this is wrong i think:
>>>
>>>           struct virtio_net_hdr_mrg_rxbuf *hdr = buf + header_offset;
>>>           int off = buf - page_address(page);
>>>
>>> you should sync from hdr not from buf.
>>
>> Yeah, the sync offset should be from where device actually writes. I
>> will add change it in v7.
>>
>>>
>>>
>>> besides did not receive_small already sync?
>>> we do not need two syncs.
>>
>> Yes, 2 syncs are redundant. I will keep it in receive_small, so that
>> two syncs do not happen.
>>
>>>
>>>
>>>
>>>
>>>>    	if (unlikely(hdr->hdr.gso_type))
>>>>    		goto err_xdp;
>>>> @@ -1996,7 +1893,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>>>>    			goto err_xdp;
>>>>    		buf = page_address(xdp_page);
>>>> -		put_page(page);
>>>> +		virtnet_put_page(rq, page, true);
>>>>    		page = xdp_page;
>>>>    	}
>>>> @@ -2028,13 +1925,15 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>>>>    	if (metasize)
>>>>    		skb_metadata_set(skb, metasize);
>>>> +	skb_mark_for_recycle(skb);
>>>> +
>>>>    	return skb;
>>>>    err_xdp:
>>>>    	u64_stats_inc(&stats->xdp_drops);
>>>>    err:
>>>>    	u64_stats_inc(&stats->drops);
>>>> -	put_page(page);
>>>> +	virtnet_put_page(rq, page, true);
>>>>    xdp_xmit:
>>>>    	return NULL;
>>>>    }
>>>> @@ -2056,6 +1955,12 @@ static struct sk_buff *receive_small(struct net_device *dev,
>>>>    	 */
>>>>    	buf -= VIRTNET_RX_PAD + xdp_headroom;
>>>> +	if (rq->use_page_pool_dma) {
>>>> +		int offset = buf - page_address(page);
>>>> +
>>>> +		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
>>>> +	}
>>>
>>>
>>> similar issue I think. off by header len.
>>
>> ack. will change it in v7.
>>
>>>
>>>> +
>>>>    	len -= vi->hdr_len;
>>>>    	u64_stats_add(&stats->bytes, len);
>>>> @@ -2082,12 +1987,14 @@ static struct sk_buff *receive_small(struct net_device *dev,
>>>>    	}
>>>>    	skb = receive_small_build_skb(vi, xdp_headroom, buf, len);
>>>> -	if (likely(skb))
>>>> +	if (likely(skb)) {
>>>> +		skb_mark_for_recycle(skb);
>>>>    		return skb;
>>>> +	}
>>>>    err:
>>>>    	u64_stats_inc(&stats->drops);
>>>> -	put_page(page);
>>>> +	virtnet_put_page(rq, page, true);
>>>>    	return NULL;
>>>>    }
>>>> @@ -2142,7 +2049,7 @@ static void mergeable_buf_free(struct receive_queue *rq, int num_buf,
>>>>    		}
>>>>    		u64_stats_add(&stats->bytes, len);
>>>>    		page = virt_to_head_page(buf);
>>>> -		put_page(page);
>>>> +		virtnet_put_page(rq, page, true);
>>>>    	}
>>>>    }
>>>> @@ -2253,7 +2160,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>>>>    		offset = buf - page_address(page);
>>>>    		if (check_mergeable_len(dev, ctx, len)) {
>>>> -			put_page(page);
>>>> +			virtnet_put_page(rq, page, true);
>>>>    			goto err;
>>>>    		}
>>>> @@ -2272,7 +2179,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>>>>    	return 0;
>>>>    err:
>>>> -	put_xdp_frags(xdp);
>>>> +	put_xdp_frags(rq, xdp);
>>>>    	return -EINVAL;
>>>>    }
>>>> @@ -2337,7 +2244,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
>>>>    		if (*len + xdp_room > PAGE_SIZE)
>>>>    			return NULL;
>>>> -		xdp_page = alloc_page(GFP_ATOMIC);
>>>> +		xdp_page = page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC);
>>>>    		if (!xdp_page)
>>>>    			return NULL;
>>>> @@ -2347,7 +2254,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
>>>>    	*frame_sz = PAGE_SIZE;
>>>> -	put_page(*page);
>>>> +	virtnet_put_page(rq, *page, true);
>>>>    	*page = xdp_page;
>>>> @@ -2393,6 +2300,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>>>>    		head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
>>>>    		if (unlikely(!head_skb))
>>>>    			break;
>>>> +
>>>> +		skb_mark_for_recycle(head_skb);
>>>>    		return head_skb;
>>>>    	case XDP_TX:
>>>> @@ -2403,10 +2312,10 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>>>>    		break;
>>>>    	}
>>>> -	put_xdp_frags(&xdp);
>>>> +	put_xdp_frags(rq, &xdp);
>>>>    err_xdp:
>>>> -	put_page(page);
>>>> +	virtnet_put_page(rq, page, true);
>>>>    	mergeable_buf_free(rq, num_buf, dev, stats);
>>>>    	u64_stats_inc(&stats->xdp_drops);
>>>> @@ -2414,7 +2323,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>>>>    	return NULL;
>>>>    }
>>>> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>>>> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
>>>> +					       struct sk_buff *head_skb,
>>>>    					       struct sk_buff *curr_skb,
>>>>    					       struct page *page, void *buf,
>>>>    					       int len, int truesize)
>>>> @@ -2446,7 +2356,7 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>>>>    	offset = buf - page_address(page);
>>>>    	if (skb_can_coalesce(curr_skb, num_skb_frags, page, offset)) {
>>>> -		put_page(page);
>>>> +		virtnet_put_page(rq, page, true);
>>>>    		skb_coalesce_rx_frag(curr_skb, num_skb_frags - 1,
>>>>    				     len, truesize);
>>>>    	} else {
>>>> @@ -2475,6 +2385,10 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>>>    	unsigned int headroom = mergeable_ctx_to_headroom(ctx);
>>>>    	head_skb = NULL;
>>>> +
>>>> +	if (rq->use_page_pool_dma)
>>>> +		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
>>>> +
>>>
>>> nice but where is the sync for reset of buffers?
>>>
>>>>    	u64_stats_add(&stats->bytes, len - vi->hdr_len);
>>>>    	if (check_mergeable_len(dev, ctx, len))
>>>> @@ -2499,6 +2413,8 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>>>    	if (unlikely(!curr_skb))
>>>>    		goto err_skb;
>>>> +
>>>> +	skb_mark_for_recycle(head_skb);
>>>>    	while (--num_buf) {
>>>>    		buf = virtnet_rq_get_buf(rq, &len, &ctx);
>>>
>>> ok so we have recycling.
>>> I *think* that since below you set PP_FLAG_DMA_MAP, then page_pool does
>>> not sync_for_device on recycle;
>>> so CPU can write into packet data (e.g. XDP_PASS) and leave dirty cachelines.
>>> After reuse, on non-coherent DMA that can corrupt later packets unless you add
>>> PP_FLAG_DMA_SYNC_DEV (with max_len/offset) or do an explicit
>>> dma_sync_for_device before requeue.
>>>
>>>
>>> See Documentation/core-api/dma-api-howto.rst
>>>
>>> I agree it's annoying since maybe we did not touch it at all.
>>>
>>
>> Right. I initially left it out since dma_sync_for_device is a no-op on
>> coherent platforms where virtio-net is typically deployed, but it's
>> needed for correctness on non-coherent architectures. Will add
>> PP_FLAG_DMA_SYNC_DEV with appropriate max_len/offset in v7.
> 
> 
> erm. pls document assumptions like this in the future.

ack. will add these assumptions it into v7.

> 
> 
>>>
>>>
>>>
>>>>    		if (unlikely(!buf)) {
>>>> @@ -2517,7 +2433,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>>>    			goto err_skb;
>>>>    		truesize = mergeable_ctx_to_truesize(ctx);
>>>> -		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
>>>> +		curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
>>>>    						    buf, len, truesize);
>>>>    		if (!curr_skb)
>>>>    			goto err_skb;
>>>> @@ -2527,7 +2443,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>>>    	return head_skb;
>>>>    err_skb:
>>>> -	put_page(page);
>>>> +	virtnet_put_page(rq, page, true);
>>>>    	mergeable_buf_free(rq, num_buf, dev, stats);
>>>>    err_buf:
>>>> @@ -2666,32 +2582,41 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>>>>    static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>>>>    			     gfp_t gfp)
>>>>    {
>>>> -	char *buf;
>>>>    	unsigned int xdp_headroom = virtnet_get_headroom(vi);
>>>>    	void *ctx = (void *)(unsigned long)xdp_headroom;
>>>> -	int len = vi->hdr_len + VIRTNET_RX_PAD + GOOD_PACKET_LEN + xdp_headroom;
>>>> +	unsigned int len = vi->hdr_len + VIRTNET_RX_PAD + GOOD_PACKET_LEN + xdp_headroom;
>>>> +	struct page *page;
>>>> +	dma_addr_t addr;
>>>> +	char *buf;
>>>>    	int err;
>>>>    	len = SKB_DATA_ALIGN(len) +
>>>>    	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>>>> -	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
>>>> -		return -ENOMEM;
>>>> -
>>>> -	buf = virtnet_rq_alloc(rq, len, gfp);
>>>> +	buf = page_pool_alloc_va(rq->page_pool, &len, gfp);
>>>>    	if (unlikely(!buf))
>>>>    		return -ENOMEM;
>>>>    	buf += VIRTNET_RX_PAD + xdp_headroom;
>>>> -	virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN);
>>>> +	if (rq->use_page_pool_dma) {
>>>> +		page = virt_to_head_page(buf);
>>>> +		addr = page_pool_get_dma_addr(page) +
>>>> +		       (buf - (char *)page_address(page));
>>>> -	err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx, gfp);
>>>> -	if (err < 0) {
>>>> -		virtnet_rq_unmap(rq, buf, 0);
>>>> -		put_page(virt_to_head_page(buf));
>>>> +		sg_init_table(rq->sg, 1);
>>>> +		sg_fill_dma(rq->sg, addr, vi->hdr_len + GOOD_PACKET_LEN);
>>>> +		err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1,
>>>> +						    buf, ctx, gfp);
>>>> +	} else {
>>>> +		sg_init_one(rq->sg, buf, vi->hdr_len + GOOD_PACKET_LEN);
>>>> +		err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1,
>>>> +					      buf, ctx, gfp);
>>>>    	}
>>>> +	if (err < 0)
>>>> +		page_pool_put_page(rq->page_pool, virt_to_head_page(buf),
>>>> +				   -1, false);
>>>>    	return err;
>>>>    }
>>>> @@ -2764,13 +2689,14 @@ static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
>>>>    static int add_recvbuf_mergeable(struct virtnet_info *vi,
>>>>    				 struct receive_queue *rq, gfp_t gfp)
>>>>    {
>>>> -	struct page_frag *alloc_frag = &rq->alloc_frag;
>>>>    	unsigned int headroom = virtnet_get_headroom(vi);
>>>>    	unsigned int tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
>>>>    	unsigned int room = SKB_DATA_ALIGN(headroom + tailroom);
>>>> -	unsigned int len, hole;
>>>> -	void *ctx;
>>>> +	unsigned int len, alloc_len;
>>>> +	struct page *page;
>>>> +	dma_addr_t addr;
>>>>    	char *buf;
>>>> +	void *ctx;
>>>>    	int err;
>>>>    	/* Extra tailroom is needed to satisfy XDP's assumption. This
>>>> @@ -2779,39 +2705,36 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>>>>    	 */
>>>>    	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
>>>> -	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
>>>> -		return -ENOMEM;
>>>> -
>>>> -	if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_dma) > alloc_frag->size)
>>>> -		len -= sizeof(struct virtnet_rq_dma);
>>>> -
>>>> -	buf = virtnet_rq_alloc(rq, len + room, gfp);
>>>> +	alloc_len = len + room;
>>>> +	buf = page_pool_alloc_va(rq->page_pool, &alloc_len, gfp);
>>>>    	if (unlikely(!buf))
>>>>    		return -ENOMEM;
>>>>    	buf += headroom; /* advance address leaving hole at front of pkt */
>>>> -	hole = alloc_frag->size - alloc_frag->offset;
>>>> -	if (hole < len + room) {
>>>> -		/* To avoid internal fragmentation, if there is very likely not
>>>> -		 * enough space for another buffer, add the remaining space to
>>>> -		 * the current buffer.
>>>> -		 * XDP core assumes that frame_size of xdp_buff and the length
>>>> -		 * of the frag are PAGE_SIZE, so we disable the hole mechanism.
>>>> -		 */
>>>> -		if (!headroom)
>>>> -			len += hole;
>>>> -		alloc_frag->offset += hole;
>>>> -	}
>>>> -	virtnet_rq_init_one_sg(rq, buf, len);
>>>> +	if (!headroom)
>>>> +		len = alloc_len - room;
>>>>    	ctx = mergeable_len_to_ctx(len + room, headroom);
>>>> -	err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx, gfp);
>>>> -	if (err < 0) {
>>>> -		virtnet_rq_unmap(rq, buf, 0);
>>>> -		put_page(virt_to_head_page(buf));
>>>> +
>>>> +	if (rq->use_page_pool_dma) {
>>>> +		page = virt_to_head_page(buf);
>>>> +		addr = page_pool_get_dma_addr(page) +
>>>> +		       (buf - (char *)page_address(page));
>>>> +
>>>> +		sg_init_table(rq->sg, 1);
>>>> +		sg_fill_dma(rq->sg, addr, len);
>>>> +		err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1,
>>>> +						    buf, ctx, gfp);
>>>> +	} else {
>>>> +		sg_init_one(rq->sg, buf, len);
>>>> +		err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1,
>>>> +					      buf, ctx, gfp);
>>>>    	}
>>>> +	if (err < 0)
>>>> +		page_pool_put_page(rq->page_pool, virt_to_head_page(buf),
>>>> +				   -1, false);
>>>>    	return err;
>>>>    }
>>>> @@ -3128,7 +3051,10 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
>>>>    		return err;
>>>>    	err = xdp_rxq_info_reg_mem_model(&vi->rq[qp_index].xdp_rxq,
>>>> -					 MEM_TYPE_PAGE_SHARED, NULL);
>>>> +					 vi->rq[qp_index].page_pool ?
>>>> +						MEM_TYPE_PAGE_POOL :
>>>> +						MEM_TYPE_PAGE_SHARED,
>>>> +					 vi->rq[qp_index].page_pool);
>>>>    	if (err < 0)
>>>>    		goto err_xdp_reg_mem_model;
>>>> @@ -3168,6 +3094,81 @@ static void virtnet_update_settings(struct virtnet_info *vi)
>>>>    		vi->duplex = duplex;
>>>>    }
>>>> +static int virtnet_create_page_pools(struct virtnet_info *vi)
>>>> +{
>>>> +	int i, err;
>>>> +
>>>> +	if (!vi->mergeable_rx_bufs && vi->big_packets)
>>>> +		return 0;
>>>> +
>>>> +	for (i = 0; i < vi->max_queue_pairs; i++) {
>>>> +		struct receive_queue *rq = &vi->rq[i];
>>>> +		struct page_pool_params pp_params = { 0 };
>>>> +		struct device *dma_dev;
>>>> +
>>>> +		if (rq->page_pool)
>>>> +			continue;
>>>> +
>>>> +		if (rq->xsk_pool)
>>>> +			continue;
>>>> +
>>>> +		pp_params.order = 0;
>>>> +		pp_params.pool_size = virtqueue_get_vring_size(rq->vq);
>>>> +		pp_params.nid = dev_to_node(vi->vdev->dev.parent);
>>>> +		pp_params.netdev = vi->dev;
>>>> +		pp_params.napi = &rq->napi;
>>>> +
>>>> +		/* Check if backend supports DMA API (e.g., vhost, virtio-pci).
>>>> +		 * If so, use page_pool's DMA mapping for premapped buffers.
>>>> +		 * Otherwise (e.g., VDUSE), page_pool only handles allocation.
>>>> +		 */
>>>> +		dma_dev = virtqueue_dma_dev(rq->vq);
>>>> +		if (dma_dev) {
>>>> +			pp_params.dev = dma_dev;
>>>> +			pp_params.flags = PP_FLAG_DMA_MAP;
>>>> +			pp_params.dma_dir = DMA_FROM_DEVICE;
>>>> +			rq->use_page_pool_dma = true;
>>>> +		} else {
>>>> +			pp_params.dev = vi->vdev->dev.parent;
>>>> +			pp_params.flags = 0;
>>>> +			rq->use_page_pool_dma = false;
>>>> +		}
>>>> +
>>>> +		rq->page_pool = page_pool_create(&pp_params);
>>>> +		if (IS_ERR(rq->page_pool)) {
>>>> +			err = PTR_ERR(rq->page_pool);
>>>> +			rq->page_pool = NULL;
>>>> +			goto err_cleanup;
>>>> +		}
>>>> +	}
>>>> +	return 0;
>>>> +
>>>> +err_cleanup:
>>>> +	while (--i >= 0) {
>>>> +		struct receive_queue *rq = &vi->rq[i];
>>>> +
>>>> +		if (rq->page_pool) {
>>>> +			page_pool_destroy(rq->page_pool);
>>>> +			rq->page_pool = NULL;
>>>> +		}
>>>> +	}
>>>> +	return err;
>>>> +}
>>>> +
>>>> +static void virtnet_destroy_page_pools(struct virtnet_info *vi)
>>>> +{
>>>> +	int i;
>>>> +
>>>> +	for (i = 0; i < vi->max_queue_pairs; i++) {
>>>> +		struct receive_queue *rq = &vi->rq[i];
>>>> +
>>>> +		if (rq->page_pool) {
>>>> +			page_pool_destroy(rq->page_pool);
>>>> +			rq->page_pool = NULL;
>>>> +		}
>>>> +	}
>>>> +}
>>>> +
>>>>    static int virtnet_open(struct net_device *dev)
>>>>    {
>>>>    	struct virtnet_info *vi = netdev_priv(dev);
>>>> @@ -6287,17 +6288,6 @@ static void free_receive_bufs(struct virtnet_info *vi)
>>>>    	rtnl_unlock();
>>>>    }
>>>> -static void free_receive_page_frags(struct virtnet_info *vi)
>>>> -{
>>>> -	int i;
>>>> -	for (i = 0; i < vi->max_queue_pairs; i++)
>>>> -		if (vi->rq[i].alloc_frag.page) {
>>>> -			if (vi->rq[i].last_dma)
>>>> -				virtnet_rq_unmap(&vi->rq[i], vi->rq[i].last_dma, 0);
>>>> -			put_page(vi->rq[i].alloc_frag.page);
>>>> -		}
>>>> -}
>>>> -
>>>>    static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
>>>>    {
>>>>    	struct virtnet_info *vi = vq->vdev->priv;
>>>> @@ -6441,10 +6431,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>>>>    		vi->rq[i].min_buf_len = mergeable_min_buf_len(vi, vi->rq[i].vq);
>>>>    		vi->sq[i].vq = vqs[txq2vq(i)];
>>>>    	}
>>>> -
>>>>    	/* run here: ret == 0. */
>>>> -
>>>>    err_find:
>>>>    	kfree(ctx);
>>>>    err_ctx:
>>>> @@ -6945,6 +6933,14 @@ static int virtnet_probe(struct virtio_device *vdev)
>>>>    			goto free;
>>>>    	}
>>>> +	/* Create page pools for receive queues.
>>>> +	 * Page pools are created at probe time so they can be used
>>>> +	 * with premapped DMA addresses throughout the device lifetime.
>>>> +	 */
>>>> +	err = virtnet_create_page_pools(vi);
>>>> +	if (err)
>>>> +		goto free_irq_moder;
>>>> +
>>>>    #ifdef CONFIG_SYSFS
>>>>    	if (vi->mergeable_rx_bufs)
>>>>    		dev->sysfs_rx_queue_group = &virtio_net_mrg_rx_group;
>>>> @@ -6958,7 +6954,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>>>>    		vi->failover = net_failover_create(vi->dev);
>>>>    		if (IS_ERR(vi->failover)) {
>>>>    			err = PTR_ERR(vi->failover);
>>>> -			goto free_vqs;
>>>> +			goto free_page_pools;
>>>>    		}
>>>>    	}
>>>> @@ -7075,9 +7071,11 @@ static int virtnet_probe(struct virtio_device *vdev)
>>>>    	unregister_netdev(dev);
>>>>    free_failover:
>>>>    	net_failover_destroy(vi->failover);
>>>> -free_vqs:
>>>> +free_page_pools:
>>>> +	virtnet_destroy_page_pools(vi);
>>>> +free_irq_moder:
>>>> +	virtnet_free_irq_moder(vi);
>>>>    	virtio_reset_device(vdev);
>>>> -	free_receive_page_frags(vi);
>>>>    	virtnet_del_vqs(vi);
>>>>    free:
>>>>    	free_netdev(dev);
>>>> @@ -7102,7 +7100,7 @@ static void remove_vq_common(struct virtnet_info *vi)
>>>>    	free_receive_bufs(vi);
>>>> -	free_receive_page_frags(vi);
>>>> +	virtnet_destroy_page_pools(vi);
>>>>    	virtnet_del_vqs(vi);
>>>>    }
>>>> -- 
>>>> 2.47.3
>>>
> 


