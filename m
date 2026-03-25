Return-Path: <netdev+bounces-271561-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLADAQnkw2lvugQAu9opvQ
	(envelope-from <netdev+bounces-271561-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 14:32:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B3878325D53
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 14:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1E2C3077711
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7043D811D;
	Wed, 25 Mar 2026 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="q7wnVKBF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BFD19CD0A;
	Wed, 25 Mar 2026 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774444905; cv=fail; b=LgVTyopoORkk38x4NVio3N/W+8lwyoaDhASI7SqonFgd3SciqpuhvJ9QWWN0y1ZpKt/S2pI3tWyD6DHgjJRWvxkzZRTmeA5SPKbpMyQzPntxdm51WObNpzHeU5YreEny3NnT0jofWfNggqtfljt7uGuJRrRA927G3DwfybI6F5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774444905; c=relaxed/simple;
	bh=mdUuwSlrsYK8vKbA2buEOA+T1S4T6N5FNpCXd+cy19M=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PGGvO3ZDMyP41CYKzf5dU6ELSayhZkJhJTMh+tlDB40AQTaYu2V/uDoKTaVBXFrlOQwCNjXrhc8ck0EtU94fRoqsMHxR0IXxQSYAzexdLb3sZ9pnLJfD/KfKBsz4fJapoXZtw1R7oEYjDvMkuiTuSJyd/41fKyl57YBu3ZC3f3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=q7wnVKBF; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P5tBe41331910;
	Wed, 25 Mar 2026 06:20:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=UzLg0iqUIaj2S1MaishOHYpscX3qurw+XDjVSayHcZU=; b=q7wnVKBF+2YL
	u1vyDBdTojlVs3uPoO8rCpDLYX6sooislsp9o7jGNaGdvYb+e0Vfan6pAHF9jvsK
	opn21wJQ4HkiFB7fCHTCobnTAA4xxklS/rlw04r11ahJtEDmoBcT0zxiC3PSyogy
	/ajCSqj7t1JZbeAGlBeiDiGNg5unfSHBwDIFdJ80eA36zHMNNuAGGckvYydslQiT
	9sTJXbScACi2WWfoaf8cuG/oGZDIFwtLBDqNhsUCpkdDyM+CR5APJJirBs0ZUqcs
	L/vtODu2su9xlJuX+9umITy1JNd+oqV1XBnAMT2+Tuen0rITYRx69xmsS4fKQf2x
	ZHnSYq0z3g==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4d42fayk63-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 06:20:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2iEVCCZAce1tHNKxhnQjRZN0ZETdm+EPxyZg6GZQBlF0RyVf0NX5f+9Nh8xAQdmZv6Rwu4nxFZf0WtOSsA/fZnK9O9L65DmaZDvocm6JnZVEmw2baKg29u1wS5SRDZSE3RDQk/gR4pXwVNSH0hzPl/UfW51/mvGaV9Ce6KtQmJVpox8e4GWNw7AUMOAAweT2JRJOPlBSRrFIzWvU/ARaxWnmtEKVngBtJKRHqWbPDkQktSLGwgjBoLzOf3CTgT1YwoWjGwg9Cn4dXwxqkyXVtiptUlcJzXoyqWxwVX1NiKCZvpGGk1jpUNv5aOpciudwsEteHBR0VcxWou60c+S+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzLg0iqUIaj2S1MaishOHYpscX3qurw+XDjVSayHcZU=;
 b=d47NlcNCMNeHW22SgoTMmHsXBZbTnRGQWhAxJTRujHDczzf0mVhSb4HoKXaGO7X55tpRnfp4HkYqz6cEVIrB0uExmhBOWkEXQtCy16l19QEhlydX355tPV50NGFQ9+g4bwn3MTQ6NkIrQ+lDbUtM8xnIQ6D7RvBEg9GQqu6haSkmlsJcXplqbrTrzv5dTOY3HQVLYSEjlYfBjCc9Ne1uhTojl2vtr6WrSZ418wggPhwamYJi4ad61XnTvo+q4fq/eSI8+uldZ2LAZjqaWPUVoV0ilkM/wutp99Lk4NGAqUSB4udIHVEKLQoxY5a/aAQdzTFHvd4kUJs/UUe5IttTsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR15MB2287.namprd15.prod.outlook.com (2603:10b6:805:23::15)
 by DM3PPFD9BD1B782.namprd15.prod.outlook.com (2603:10b6:f:fc00::449) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Wed, 25 Mar
 2026 13:20:39 +0000
Received: from SN6PR15MB2287.namprd15.prod.outlook.com
 ([fe80::8a07:a6bb:5ae5:c9e5]) by SN6PR15MB2287.namprd15.prod.outlook.com
 ([fe80::8a07:a6bb:5ae5:c9e5%5]) with mapi id 15.20.9723.013; Wed, 25 Mar 2026
 13:20:36 +0000
Message-ID: <9bf4f8d2-69b0-4ed1-9dac-e3223863cede@meta.com>
Date: Wed, 25 Mar 2026 09:20:32 -0400
User-Agent: Mozilla Thunderbird
From: Vishwanath Seshagiri <vishs@meta.com>
Subject: Re: [PATCH net-next] virtio_net: sync RX buffer before reading the
 header
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Omar Elghoul <oelghoul@linux.ibm.com>, Srikanth Aithal
 <sraithal@amd.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
        virtualization@lists.linux.dev, bpf@vger.kernel.org
References: <f4caa9be9e5addae7851c012cab0a733be7f0974.1774365273.git.mst@redhat.com>
Content-Language: en-US
In-Reply-To: <f4caa9be9e5addae7851c012cab0a733be7f0974.1774365273.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:408:fd::29) To SN6PR15MB2287.namprd15.prod.outlook.com
 (2603:10b6:805:23::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR15MB2287:EE_|DM3PPFD9BD1B782:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e870c38-c211-46f9-4d05-08de8a714c20
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|18002099003|56012099003|7053199007|22082099003;
X-Microsoft-Antispam-Message-Info:
 wOpXIy7nIP12vdc7Y8t1USDn0KNn9FDAH6vgf+xxeTKYRMdjc8QuqgpJE+OQ+GmD2OTGXQ1J1SpFhCeV8HLMZMg8vyHiVeEqTkYZ0Es/6ehrT476dpBiYlSe4iNRxMs0qYVwSJHDMECrRFjQbWZYv6IzYicXAnt6NXvmuLkGPR6xUUcdmXF3p/PzJoSYuegcG8iYIspaIo56P8j0NrjiEY91TuL6p9O8stbTC+2VkoxOlZmsSiKIgSd+lBbGbMhcAyDrpirxyGkObEC0liKDqLeepJIfBrSDfUHPUv+rI+dea40IzH+DiOWpc8zgMHKoHPAHmMdOziIREj0YOI75Ua+vvFqNEL5Xg3bepdXNFjZKdewgqYeiEP9M5mRCcMJbqWYYvgmEGueUoNaRC7M7R3Azj5rTn42EnNTbp1nUG56RPt+AtOJBIgsKEfTu7Tmet9iE73j/qQBpGZ78MrAEqainmlzxZZFHKIUAKyxwwdrZqJpxgqNERr0BKZrz5P5fmabS57jcEieYcMaTwJecaN+yoiXZ9C69G+EGYF+qZWWS+jGRTNBltcwD/druVXE7NTRBjse5IkoAXnKE4TR30lFZv0dsWBSmdN618hnpZYkA5vEMN8056zKYbZ1hK+e53cYftpooP0y1FiuB8vXJgiuwTONhyrSrprdgMCsVnj/2qJVYECOWnd6fW+f+kqL/TNxBMdY1KPH8ElF0T4SkT8hk/pBL65lU/80hQo68FgA=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR15MB2287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(18002099003)(56012099003)(7053199007)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?N0tzUGxJTjR2dEIzVy9ablh6blVEQ1hoYmlxU2hieTBqTyt1NlRpVDJTdjFl?=
 =?utf-8?B?V1RiK0xUeVJjMG0zK0NVY0RlenZ2Zml5NjZlc0dreUVRaURTdjYvOEFGT0VB?=
 =?utf-8?B?aTFYMHM4dk43d3ZJMURVbkpZUzhEVm1KUkFkU25La1RkMGdUNjAxSWlxQnlK?=
 =?utf-8?B?WjQ2TmpYOWZDeGN1bi9VME5tbTBLbGxVcXlrZjkrVHh6aWg2ZWVwOUdpOS8y?=
 =?utf-8?B?cXloYVdtdDV4NkcvcXRvR1I2aDFtKzlURFZSbnZjMWhSRlBjTE0yUUNMUndE?=
 =?utf-8?B?dUd1YzVyN3d0UGxkZGQ1Tk9vSUdPL0crbmROTjhMOXVJNSs4VW9BZmI0b01W?=
 =?utf-8?B?TWJ2SlVKd2kvL2d5dmlteUIvY05Bczh6ZEJIYlhOeWJINVJDQ2g0MlI4UTRE?=
 =?utf-8?B?WVQ5MHd3YTNCQkdhbmNHa0pRb2RSazBRdTZQNnZBMlpxd3VZTVJ6NHlMWU5F?=
 =?utf-8?B?dlBwQjJIWDEyZ216bFEyakJSMzRCR016Zzl0WjlyclV1amtMSnZFcEF0aTZY?=
 =?utf-8?B?aGY0MDJqYWpEWFkvNTJPZ1BIaEM1b25QMUdyTnNheFRnRC83SjNYbTNPSEhP?=
 =?utf-8?B?UUpsMUpJekg2c0k4ZTVJRFhQRkRQT0phY0R1cU1saytITzArcEE1dnEwM3ZL?=
 =?utf-8?B?ZDR3NkZFejBscmM1aElpN3BkK3dydkNaNlZyZFlvRE9lVGpWZFNLTEtra3E2?=
 =?utf-8?B?MGtna0RNWnM1RGszYzVxb2pjT29Idm1FWllJYjFqNDFxakFpaitoYm5Eanp4?=
 =?utf-8?B?WmF2empqQkVFZnlGbVJLQjNOMk0ySFhHYlpQS05TOTB2aUY1M2dLWk1BV05k?=
 =?utf-8?B?dndxYjRYSk5kaFZ5U2ptbVVZV2p5UXI0OWFLd2R3ek1ZV2FJNDloc2lXUmRt?=
 =?utf-8?B?TkxSczh5RkpLanJ2aTIyazlmVkluZS91TEZ2ajZTak1pUjVXR1FMbUVmWlJ6?=
 =?utf-8?B?VWhKWFBEWm1PNVRXV3J0dG5sbHlZdWlIeXFEY3lWemN0UjllVCtqaWhvOUdM?=
 =?utf-8?B?SWQya1B6MWttZTNzZW5qNW5vb01CWmFwcnhYNVdlbUVZRFhHQXByeXlwQ21J?=
 =?utf-8?B?N2JwbU5rZEVtOS9icmx6TTI3N0pkMnNvdnk2blhvTVgvMTBCSldGYTV6Ym42?=
 =?utf-8?B?SGFMblN4a28rVWNESUgvVnE4UDNxbU1wRTRhekkyZXIySTFWa05lRm9pQ1dP?=
 =?utf-8?B?SkhndFB0U2Z3SDdXcmhqbEhaWFBSU3lsTVFmYVoyNzZrY0ZqL25hREJoVmF3?=
 =?utf-8?B?RGZmUlZhRms3RWxHNUF3SVFHbzNNQUJhS1NNQklRM3FYQnNOMWdpdjRZRElP?=
 =?utf-8?B?bnp3aDFjeTk0aUtkd3krZ0hLS25aSW5SVFp1NnQ0MG95aGUyci9MMjZJUEtq?=
 =?utf-8?B?QUJ5UENGNDRvYXJTK3lBL3dPMEZXVnVMOEtKYzJNeUlzMjNFaGlVZVpXYmRD?=
 =?utf-8?B?MDc0UE4rNTFFUEc4eHBWK0kyNUpod2Erd09pM3E5RFAyM1g5cFV0U0EwcTFn?=
 =?utf-8?B?V2g2QXQxRXVRaVhjck9RRWIvN2dOZW9ySmp4ekxiUXRaaHVkZ1FwQ2w3V01s?=
 =?utf-8?B?ZTVPQ083R1pQRHg2RC9ORHVLRk0zWGJzd0NjaVZ0SlZtQW1PQU4rOGkybzdn?=
 =?utf-8?B?dnFZRjRSaHprcWRJY0JXdmR1bWN1a3RUcEUvbU1pU0NsTXhhaEE1MjRzVkZj?=
 =?utf-8?B?T2lhd0tIY2NYT2lqODZwTzljeEwyakd4c1lxRUM2QmQ2bGdOTmdOcm84VDR6?=
 =?utf-8?B?dEUxR1FxWXptYVYwMnlsbzdxdFBIZVNhZUtlMEg1ZUhpa1VJdEY4d0c2bDcy?=
 =?utf-8?B?dWFYNnh5QzdFNUM4SzRwR0RiUG8rTHl5KzFPK3FTVU83TVc3Y2NpSlBFWHI3?=
 =?utf-8?B?RHQydUt2ZmtmQlNHZUdST2NSeUhLakUyQ0hDRFlCNVdFbkd1aGZuaEJOZ1dl?=
 =?utf-8?B?VHNtMWNJSDMxUzNuNjBtbFpidHdjckU1OG4wam80NUVwcXcwbzRYblhReElP?=
 =?utf-8?B?REZGVEViL2VwQk8rMEZ5dys4cjZTNVdWL0FDYUdzL3JoNWNmcjlzU0JuNlNn?=
 =?utf-8?B?NFlRc01tS3BSNTFmS254aFhXd0t3UjRmUFFvdEN6bGdoMFk2L2x4aUEzZ1My?=
 =?utf-8?B?cTNJTTVwSVFCZE1wMmQvOVlRSEpzanpzditqY25TdW1qVGo2S3hHaFk4ZzE3?=
 =?utf-8?B?YzZtcGM1YlEwUlA0V3dqVEgwSmpOTXc2Njg0RVYzUkZCR3VqUTBLN0d2NytO?=
 =?utf-8?B?Q2NFeVloQ0F3S0NhVENBMC9ENWlkMWdRcVR6RFNmWGNCSFkySUtiWCs3UU0y?=
 =?utf-8?B?d3lBeXZsQ3hTeU43MWQrSndQdFhXOGtVeGZJMGxJenE4NklyUGRQZ2VnYWw3?=
 =?utf-8?Q?cSEcHWvJ/AL/bSWpap9wUpZM60JuNSrMN9mCh?=
X-Exchange-RoutingPolicyChecked:
	O+KdYiW5ykxA20FGoJcYutgAzZbeMu9Rpt6BVWT0wy6OkviI9n5DIlfqyhcCzHO/a0jnuSV8SfjZzgUOa25AKa40hiic1Qm0rPIAe+OJ77lWsLGEZSJ7WDsyLcK/davrgO3T0da3Qs/Gea1jFVXh3RkufNVT9lh/JMqqmEKmZITM4LFOVYUyZjOK7vLirLMGBL++UEzecR9Jkos7ukNg1PtZSCTg/Lx0Kly7Oe28CsCkVF2z9VhQEY4r7j3amEzGyU8wLAIorymrBJn/lho36KE9ON8zqU6H9G63kxt1ImPXmBuN9EvdkSDfy++RA3GJd21snkklOfX1FFqUGiWUDA==
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e870c38-c211-46f9-4d05-08de8a714c20
X-MS-Exchange-CrossTenant-AuthSource: SN6PR15MB2287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 13:20:36.6032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +dQVaxSz2Rty5ypUvF40bzlejERTEIAmrx2nyBn/snMynaddk6S5fHoLEMvfpjXU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFD9BD1B782
X-Authority-Analysis: v=2.4 cv=KtZAGGWN c=1 sm=1 tr=0 ts=69c3e12b cx=c_pps
 a=bquUzJqYOqw1EpBvECFzMQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=wpfVPzegXHpEFt3DAXn9:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=zd2uoN0lAAAA:8 a=20KFwNOVAAAA:8
 a=VabnemYjAAAA:8 a=fq1xoqLLIO8VfXpRw4AA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: BqI5EgrFJanPd3JShb9PUwKyG_ehFTIz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA5NSBTYWx0ZWRfXydxN29DkAvfb
 bVXDL3QfVBfOf/lE6aVXDhGBZCygKaiYyMfeErhX3zsKqxnwWM8+wRM9vtFSYDn+Q3FCPihmLZ/
 U7z/qSM8C2S8Vnw0TzmVRtvOGPANm4r9UFVJH/nUOLHzT1ZNzkTttfVcJXD7KySYG2MN8bTB9l3
 zF3zpfVKiocsASf7ARjjm3YaeUSrVlzNiih0FFBGVDZD2FABqJCEgwd6hXfxuYJwSBRAj4XdFfd
 vZX8WCWGpIDxXwXJgw3xs80Ql2HAhLgbBJmn/rdaSGsUu/3YMC49VEnKFzgdk2DHoWQ3QzeNuXp
 82ekfgQ3vyxASnd8N+RyCdDZ6YD+YamlfITWDVV/hwTx5th05PygIdi3JJZu2sfGXQGhVpp0IKG
 zAweDGjcAbEPTfa4zkRZjsLvgNAT9v7lVLMBfgqJy1wliFtvm/4GiPcnSLLF78yp4aoQChzuk9u
 ZWxijW/pIxmN7UFBnug==
X-Proofpoint-GUID: BqI5EgrFJanPd3JShb9PUwKyG_ehFTIz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271561-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux.ibm.com,amd.com,redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email,meta.com:dkim,meta.com:email,meta.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishs@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B3878325D53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/24/26 11:15 AM, Michael S. Tsirkin wrote:
> receive_buf() reads the virtio header through buf before
> page_pool_dma_sync_for_cpu() runs in receive_small() or
> receive_mergeable(). The header buffer is thus unsynchronized at the
> point where flags and, for mergeable buffers, num_buffers are consumed.
> 
> Omar Elghoul reported that on s390x Secure Execution this showed up as
> greatly reduced virtio-net performance together with "bad gso" and
> "bad csum" messages in dmesg. This is because with SE sync actually
> copies data, so the header is uninitialized.
> 
> Move the sync into receive_buf() so the
> header is synchronized before any access through buf.
> 
> Tool use: Cursor with GPT-5.4 drafted the initial code move from prompt:
> "in drivers/net/virtio_net.c, move page_pool_dma_sync_for_cpu on receive
> path to before memory is accessed through buf".
> The result and the commit log were reviewed and edited manually.
> 
> Fixes: 168b61da6871 ("virtio_net: add page_pool support for buffer allocation")
> Reported-by: Omar Elghoul <oelghoul@linux.ibm.com>
> Tested-by: Srikanth Aithal <sraithal@amd.com>
> Tested-by: Omar Elghoul <oelghoul@linux.ibm.com>
> Link: https://lore.kernel.org/r/20260323150136.14452-1-oelghoul@linux.ibm.com
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/net/virtio_net.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 97035b49bae7..2f57245c682d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1956,13 +1956,6 @@ static struct sk_buff *receive_small(struct net_device *dev,
>   	 */
>   	buf -= VIRTNET_RX_PAD + xdp_headroom;
>   
> -	if (rq->use_page_pool_dma) {
> -		int offset = buf - page_address(page) +
> -			     VIRTNET_RX_PAD + xdp_headroom;
> -
> -		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
> -	}
> -
>   	len -= vi->hdr_len;
>   	u64_stats_add(&stats->bytes, len);
>   
> @@ -2398,9 +2391,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>   
>   	head_skb = NULL;
>   
> -	if (rq->use_page_pool_dma)
> -		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
> -
>   	u64_stats_add(&stats->bytes, len - vi->hdr_len);
>   
>   	if (check_mergeable_len(dev, ctx, len))
> @@ -2563,6 +2553,16 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>   		return;
>   	}
>   
> +	/* Sync the memory before touching anything through buf,
> +	 * unless virtio core did it already.
> +	 */
> +	if (rq->use_page_pool_dma) {
> +		struct page *page = virt_to_head_page(buf);
> +		int offset = buf - page_address(page);
> +
> +		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
> +	}
> +
>   	/* About the flags below:
>   	 * 1. Save the flags early, as the XDP program might overwrite them.
>   	 * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_VALID

Tested on x86_64 vhost-net/KVM, no regressions
found. I will send out the benchmark numbers soon.

Tested-by: Vishwanath Seshagiri <vishs@meta.com>


