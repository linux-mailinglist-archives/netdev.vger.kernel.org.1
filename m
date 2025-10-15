Return-Path: <netdev+bounces-229524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E31BDD8E0
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 10:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6CF9935618F
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 08:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B10D319605;
	Wed, 15 Oct 2025 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PYd0q8ap";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZgCEdsWJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F9D3191AF;
	Wed, 15 Oct 2025 08:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518629; cv=fail; b=h628BaaaPkt2CBCPZYkqnVHoj8iypwBfmbMlq8xTiqVd3eMlbC7f4nIed/txWKC0/xwFz4OZUSje2J/JkrLN54p4IREXCT35SPxYCK8w/nfzUIr1iqUIgqaNDeYD2GP88BAWfK/tCL9AVdmOJUaactuYOO1/YnlE4x03yb5OtHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518629; c=relaxed/simple;
	bh=4EHTjerDX1qLoiIJGpUMDuRYY4+ZVIuHtokrf47cEGE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pF/MbUOhSuuNlQWs6FVjwHs0IadcuzKvc2tLnx7mibQcqXBE27H6gTLWNPwSVpbwxaifTRElPTY0Kw/v3vc9JchAVMQ83xHSyHL2z16XnSdjLPsk9oEX2q1RTX8JkOVGf3Df82u9LVXhwai60i1uMIr7k2nz9L4rhxXxmpY12tY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PYd0q8ap; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZgCEdsWJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F4uF5H012813;
	Wed, 15 Oct 2025 08:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=La7ZdSD9pl3VRw8SHzwn+kS289U0g8KKTFvn6yDF4ks=; b=
	PYd0q8apsj1KVYKf77PCBkc8Z7ZrokCUrupGQzjFQZcrrP1x1f7ma0nzjKCJYEiY
	BWUKckXnOCSM/vZ60GJc6n96mQ9MR6FgjDd76uFAHiTyBT6orLNioip3pNVOyJMn
	Q0Lz9w0ffxcoaPbC7GTiZ9hzS65IpNq7734ar346MCo6HQtBDCMnxV8Ka6ySHskq
	6eqqFg4RkEmetxqWqrPyibckMBqVAL3s/foln13oFLHve3fmMGHLaFJC9Y45QXWN
	yaJLA+0HwJXcLIMJ2S9qbts5kzJAWr9ERQXfWUUPByTdHMHvHHESTpHUaAcMLfNT
	oFCKIOUFTKnqDMrWHWTetg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qe59e5va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 08:56:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59F6j9Mn018003;
	Wed, 15 Oct 2025 08:56:54 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010036.outbound.protection.outlook.com [40.93.198.36])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp9ubme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 08:56:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MwxoNb3npRLdqt6cdtK/SfpbFH222LcAwig8qfu8SChHtF4ex+/uOCMl3rhuGrBszsydxqL8xJRayWmz6fWam1YvQjAJvRc83s2VKc+ssHmWh4Bl4sUsfOoqfn/e3CnMyIwi0Dt1z6d4Bnl5hqh5Oz5E81KYLAbEe1DlTmTNVKvdDEb/OMcMzpOA1AjSPvqAc9FYicA1z3w4ZhqRJiu5jFXQ4uvBtIWU1sDoeewYv9MEY6hc7IVbsNMykLAZMe/Xz3DhqF+AMJAiiHlqPs0rCrpfbF8T0pyGlRbDvgNtiZo83N7T+B6MRd3QGIAUSF5YymSkrfTtkCxKT7WJBdrwmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=La7ZdSD9pl3VRw8SHzwn+kS289U0g8KKTFvn6yDF4ks=;
 b=IDr6nDxkLNqzJhoTSm6suYtlcwvNWx36q+GvuUF7Q8K2XNGQrepVbzh9duqimXSFjKNOaBYNPmvO64GvBebk19dbvmnVmC9qDmR9fca4G9Xrwjs8Pi1S/zwqA67MIo1WGieyXt3GrveR1yiD5XklzzzyLQeUCN9JeZkDN3avZV0VmstNChfUcxa8n9y1b2B2hoKadwEdS8c+T2T4YpOfaH3kHzK5iBKwusMstFGP6kwpU1nm0X74+bIv9Knsj+0soQ+IU6fY5T7CCBQRBcc5SIezfOrvM0wV1Z0MlzkAPhgQaQR9YXrXrpK9oyFntJ6Jj/IOS2DF+3+aOb+V2OE85Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=La7ZdSD9pl3VRw8SHzwn+kS289U0g8KKTFvn6yDF4ks=;
 b=ZgCEdsWJKqfFSsgCv+pHVwUpTKQAK85LckVcyvOsTaIt92gSj2n6cw+DQL1h4Xnp3AVj6UH/VF838NacO7TX2bhcrqweZOZHQ1QUa+jgnTfVDsj/GmbRqvE8HfW7ISJKDreasQZKMEwwK4NTgLachb8W2oz2nxwZrVYfOQ+s6TM=
Received: from IA4PR10MB8421.namprd10.prod.outlook.com (2603:10b6:208:563::15)
 by CH3PR10MB6904.namprd10.prod.outlook.com (2603:10b6:610:145::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Wed, 15 Oct
 2025 08:56:50 +0000
Received: from IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77]) by IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77%6]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 08:56:50 +0000
Message-ID: <47282962-19bd-48bc-a09b-df957b467097@oracle.com>
Date: Wed, 15 Oct 2025 14:26:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Octeontx2-af: Fix pci_alloc_irq_vectors() return value
 check
To: Simon Horman <horms@kernel.org>
Cc: Sunil Goutham <sgoutham@marvell.com>, Linu Cherian
 <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Andrew Lunn
 <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Nithya Mani <nmani@marvell.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
References: <20251014101442.1111734-1-harshit.m.mogalapalli@oracle.com>
 <ec88f0a0-12ee-4c16-bb0a-fb572d6e020b@oracle.com>
 <aO9dClea18rk9Kdx@horms.kernel.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <aO9dClea18rk9Kdx@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0493.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::12) To IA4PR10MB8421.namprd10.prod.outlook.com
 (2603:10b6:208:563::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8421:EE_|CH3PR10MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 663d4e0b-6a15-4fa7-cb33-08de0bc8c786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2s2eUhjTStEUFFwbFdoVEZld1ZVT3gwQ2RsMXgwbnF2U2RwZ1lSUVB1MHNo?=
 =?utf-8?B?dlJhemVscDd4VkVqb1lRbVBPZGkvOTFzM1BJRWZwMzNQZnVSTWdhbFB3Q25u?=
 =?utf-8?B?bkRuS0hoZTFJQW1zNG03Qy9YaEdGKzFDb2lZT21SNmJuUGxrWnJ1RzdRMjBU?=
 =?utf-8?B?SVFKRUhnajZVSTR5bUlOSkM5ZWRwTTVUc2pKS3IzVEZwSFJ0aTI5T3dTbi9u?=
 =?utf-8?B?eDhlaDVGU1dXa041WGZkcUwwb1JSRmY4cnEzd25IMjNia3MrT0RReFA4VGh0?=
 =?utf-8?B?YldFME1ETCs0a0RsdWFGMVdNNHlMUjVxdGNqZ05RSVJWaVA5dm5xM0p4UjJE?=
 =?utf-8?B?YklWMDQyTlI1YTFFVEVPZlJkRzJwYWU4a1JqcWN6Zko0REVoMHZTeGZmMkFB?=
 =?utf-8?B?cU56VDJCdDBiSUZZTUw3Snc3T21uc3hqQ1dGU1p4cDFoNnlzazlNUTJaUkZw?=
 =?utf-8?B?VHZJRm1ySnMxZGdqOVQyT1dnMytSdkY2TWJiMm1VRW5qSEdOZWtJaUdRMDYx?=
 =?utf-8?B?VjN1ZU9kR0lDY1BrM2VqVSsrWU9yZGZoL0tTYi9ZQ1dHUCtXeXU4WGU1NlV1?=
 =?utf-8?B?NlhXT1Yva09CWTJ5K092WS91VXk2cEpzSlkrUStFWXdkYkFMSVR0MktlOU0r?=
 =?utf-8?B?VEFzak92MlI2emMwbXJiQTRCR2dkby9sZ1dPeGtod3lLQzE1eTFrNmVrNkE2?=
 =?utf-8?B?RU5EeXljN3k0UVJMdFhmaEpZanB6dTJBZU5vZ0xEakJtVG1BT29jRkFYRG5O?=
 =?utf-8?B?TXN1ZnVJejFuclBBZk9mT25GTkFncjFvWlZleVhTMEY5RVAwOU1BaGlCRVRI?=
 =?utf-8?B?emhzUkozSHlxVTZaWkZxbkduT2hZMXdSV1hxM1A2WTI3ZGtDMWJsM1U3N1lV?=
 =?utf-8?B?M0hOdzQybmZraFlCQ2hTcldkQVE5cnJTZnU4Vjl6bUhyMWoxYmxCbkR5clZH?=
 =?utf-8?B?Q2RFNDNKVVJaaW9pV2EyYy9PWlhRQm84SUc4SFJ0L0ZCUjlUY05mbVQwczFy?=
 =?utf-8?B?YjF1NjczaVkwTUx0enNHbVZrRlFhVnhTK0Y4L2oxNnNYeWlRcWM4VTNrVWNP?=
 =?utf-8?B?NXEvQVVjUjdva2tpcXJPazU0bkNBRjg2aUVCY1lXNi9HNEFJa0xxc3BDWFJQ?=
 =?utf-8?B?ZVlMNjZKZVlZMTdVQW1aeU4rbk5xR05tVjlvYkVsV2VQOGplWGEvaGp2SjRV?=
 =?utf-8?B?S3BaUCtLYmpzUnM5dDhHWitSY3BielJoK3VJL1dZdVl3Uld2S3VmZXdxRXp1?=
 =?utf-8?B?ajhwaGN4WW5Zb1dhcGpSNE9wUDNPaWE5ZFN2T3NBS3d2Y3E2WE0vQlYyZllQ?=
 =?utf-8?B?b2hOcURjOVBvWWhXYWhDL1F0cUZMam9sOWNMc3VrQ2syRzFIZHM2VHQrNkxC?=
 =?utf-8?B?MmFKdDJ0ZWpja0orOVFtZkQrdmhSUnZocklTdW9xTnNGcmdQVy9sRFNHem04?=
 =?utf-8?B?YW5TR2pyWDl0RmcxREZGK0hUTDNIK1J6dHFVK01Fa1pHTDdrRVN2UjJpMEM0?=
 =?utf-8?B?WjhrbFdsOFdtbmExNmtSd0N3TFAvSVp5cnpLZThYd25BRllHNXRsT1YvT2Zv?=
 =?utf-8?B?akZ4SHhHUVE3VjVSb1dBZnJ2a3FlM3NiN0pKUkNqWFBuZlZyVFlzUmJxWXpl?=
 =?utf-8?B?RHVENEJPc201YjJWeHJTcnQ3T2w4K3F0VzNNVXFqQVBqTHh3cXgrL1c3a1BU?=
 =?utf-8?B?SVQ0R2lVR1JBaTF5U24wanlPTFhSL3VCME5UNlZDWHpFVWN1NTluaEVWbnhQ?=
 =?utf-8?B?TVFHSnIyVzFtd3gvZTRycVEySmR5YjNiVHhkdzN6a09JOFg4SndQcTdqZFVa?=
 =?utf-8?B?WnJleEpKK0dLNGEvaDFzWncvV216c1pmZlp1NmluOVE5S2VMc0U0SE9BRG41?=
 =?utf-8?B?MmlKS2FiSCs2RU16RVZqZ3lNYzJJOWNpQWJPRTRFbjd5Wmg4clIrRnMxSFVh?=
 =?utf-8?Q?rbOJFk//rjRrDN1UG1PSiOzsQ+r7AEYB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8421.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXJFbkdsbEpsOXR6cUYvWDlpQWZ5K0hUeTlpSHVFTFFBV2pMdmNIeFBpUkFG?=
 =?utf-8?B?UkRLNm5vWlJud091YmE5LytNY1RFemtUWWpQUzFPOHRYOUZKTWM0eFIyWnlC?=
 =?utf-8?B?SzJjaTFsSzlFRUZOYytoUGRFOFVmYXpJbUc5QUNwQXlkSElDWVZtdUNuWkMz?=
 =?utf-8?B?b2FJTEozbW5lbjZvRzZZanFZc1g1OEVGMVZmbWpFcFRYL0JtM3JsWHY3RVJ1?=
 =?utf-8?B?aXMwaFpIL2RMUGlhalR3cFh2S0JiN1hEVlpSOW1iczhPMTVKR1RkVU5tbnQ4?=
 =?utf-8?B?MmE1dnFkaGFpTTRyNUdPMWFOaFYzdmZRaUN4STdIRW5mTFVxLzFRem91MjBN?=
 =?utf-8?B?QklwTUhzMlhBSk1mQmZZWUVxaWNhU3VZcWpGNHdBUEk1b3lTRWxPNlFOcWFL?=
 =?utf-8?B?ZDhWNWplRlE0bFNlY0FiVFhick9oMmQzcGsxdUdVMHFsbkpnU0MxSUZqWFV6?=
 =?utf-8?B?K2xCMEFBMEJhVDJaamN3SWpZUXZ4ZGlxa3haTkNBTG1xalkxOGVLbUVKNW9K?=
 =?utf-8?B?akNMM3UzbUh1MWpDSURVTlFCTFV4Y0NoNXJwUDVKYWhML1Q3TWNmdHFoNXZZ?=
 =?utf-8?B?UHQyd2VSSEVXZDVGcXBqMWNCZnJSeU84ak54Z1lmSzloZ0VaS2JGZS85ZWZG?=
 =?utf-8?B?bVEva3EwUCtOK1F5SUpEeTBTNUZaUGxoUjg4d3p0N3ZiMHNQUVlrdEMwZUFk?=
 =?utf-8?B?bnA2SkcranhnQXdSM0ZzQndCYmVsaC9sREtDTjBZN2N4blE5ZmJXUVhNZDZO?=
 =?utf-8?B?KzZaMEtPL0xXZ2RQQTdENW9ETGF6R3BSTGthdW1ETWU2UGIrT1pFbUlJUzFw?=
 =?utf-8?B?SHZYRFQ3OEx2LzFsNnJLMzN0NTlqWWc3YktscmliZG9xKzBjTnFMZFB5YWdh?=
 =?utf-8?B?aVlXZ3ZnMEl0V0xIT3dEaVl2M2VTRmg5YjlRQ0xiNlY2UGFvZUpSRGVSd0lY?=
 =?utf-8?B?dE11ZjM1bWRwdzdEUXZDTWdiTVliaitNd0lockFFV1dOKzJlU2tnaFM4ZktF?=
 =?utf-8?B?dGVxc1R3Rk1FQUs4VFFBN1hqd1MxUUp3cHgzc08zRjJxWEpPZHYyZHpnOWd4?=
 =?utf-8?B?SkozMjlCbEVla3NoYWNXbi9PWS8wUk10YU1wS2ZzNnFGTGRUQzNmd2NGRE13?=
 =?utf-8?B?N2hmRWpuWlVvbGVQQXowZ2EwUlJJYVZ3N09NSlh0eXBlVWNEUTIxNnNXQzRX?=
 =?utf-8?B?ZXVlejJ6bTZOQmIyM2JKWW44eThCUHFmMW9ndHBsVjN2THU5VjJWaGNJSlQz?=
 =?utf-8?B?Q1FBUUtUQ2ppUG5SZ3BTdWhVTzZLVnJvSk1RWTNtUDBGRXJIUStST1FTMGJX?=
 =?utf-8?B?R3NaSFdDclU4b1NDV21xSUZoNkIrUmowRFJZR3VhWG03ODRXei9lUTU4dHZl?=
 =?utf-8?B?V1JRQ2orV3VHY3Y4dHpwVGJFY0xIQ3hGYVk5Wm1Gamp4bC93Nm1jMldndnhW?=
 =?utf-8?B?bHFlbDZESGl4TURsdEtNTkd4dlhRQUNTcFpNWHM5MExndlNJYUhacmhpYktk?=
 =?utf-8?B?djBDazFleXYzZHBBcHh4c21PanZmTjA4Smt6L3NFTnJIVGpxbmxDYW43WEZq?=
 =?utf-8?B?ck5JQnkvK3FzMU1QNVRHeDBVSHcrR25BZUFQMTdzU2ExQndVcUdESTBCNFBi?=
 =?utf-8?B?ejRzTW9yYlN1WXA4LzJ1aWxEemV0cTZzQVBPRnBYUHRZZEZIck9PcE1QbjJw?=
 =?utf-8?B?Qk96NHgyeEI4V0dKNVdjMzBINnhGbE5ENFhtR1kwRDN4YzdKVTVaT3Q1U001?=
 =?utf-8?B?c3pJb3hLWkMrb3Npdnh2QzVuNzNkL0J2Zm5ENDVmU3NwNGpqM0JaQWx4NHQy?=
 =?utf-8?B?d1pxRHEwVHdkaGZyWUdSenlwMEdaaWR5L3JsYUVIMnd6ZWN5TXRiRDYyODlF?=
 =?utf-8?B?WlUyRG90eklBajlKMFBGSXdWczB3TW1rUnZaMnlqNkNFMlpJZ1N2a0l3cVF6?=
 =?utf-8?B?NnNJRkNtZWxiVkVyWllvOWtlTnBvUHdoT3N2V296bHY5aU4zWmdiT25VbmNm?=
 =?utf-8?B?NHBlTWVqMkNiV1lIQ1luajc5NGx5Ly8vTWZrVlhUVFlCMHhvYTRhR0tXZWRL?=
 =?utf-8?B?YUhVekNoQ2FiUUxvd2hvSUlQNXA1VmVyTk84TEd1MlpaZnV0M0lkMnZqa2Nu?=
 =?utf-8?B?ek84R0NEWDgrQkdCU3gwRjJTM05wVU5NWFp3OTIwTjB2Qng4VHh1Y2ZRYXM0?=
 =?utf-8?Q?Gmc/2f7r6foCs+EdK2i91C0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lKcM7kyIPlKBofcVzgROgIeXuwyGJeGv9Sap0N2zh9aXd1q1BSigOFWS2eL5FZLf1T2bggpSICQREiRjUfwZMAsCApMmwo8k4A6k6dizcs35FF5maQKC+xwUYhcIEKE80QMW+oGwbsyKCONzSo2VGV0bZi/WKbBobQyGNYzvqskL4mU0hm7EUXhdeV0XgrtnqUT9uvUXDBGaJ0xVNu5H3CP3TYu4ACcLC9ddmkt820ZGW6ivWgH58Z3DOg0w7AahWmqajN8AUzwm0a89cfkKBJqW5NNREDMjbcgAybuZffa6Pp8aRiQkoB3cT0s9zWBb5NUKX1uvf1ujqqh2vM3eMKGZXYwtNaSU04bSEeIN/V0KKvEQtJGa0wF6nbixpsLeLUIFoSwmrdqHpJ7R4Tm6MAFp5LyNwgs9ADvxYXsw5ZR1h8lEM9YVay6NBomCq1XM7FTXGIZ36YAFwJONhshmj/++mtupDIH8q3XWY57ARAQzyFSC0QEMQE7zSBizAdRmeqyrD20ClbVHbB3ROd0xxtkDKawD0sJXfKEh21fRC8Dcsgdb7Ilvlnjx8ZtF/MUTDjV4ClzAq98dAK7KYfHO80lT4+msnodPpuQmrrjvCLo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 663d4e0b-6a15-4fa7-cb33-08de0bc8c786
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8421.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 08:56:50.3756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pL9kbT6Up/SQRZ8HPgFDubCKcUhDLlZYUsmWs+gPVKpK+9iCzcgAYhAuw5AD6fx7oTCzZSRUmf8i2pKIL1UAcivn5slx9JYY1dIgFDUjPeYCjTyQIT4ksw1goZCjg1V4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6904
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510150067
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMCBTYWx0ZWRfX/jR9HC6wRUkF
 iNp0X4im+MesK7RCx1/ygFN1CF7Id4APf/I690LH9pMahegOYMggdbvGsAGpnH0kpIpr8EsPhNX
 hpVgq8/xV4OD7MiEa2p11gIrqNZukFpgyIigDHItM1+00fwpqSMssEO/GE92tVqJW5qqqUFOOF3
 axTZ14ONXAbyP8pUmwjCkIVLccpHIBYJBjuZz9SxepzGt0YRfFv9tNdH535pJ1n++JFcsIKjAAO
 tm1l4aO7CkUyvtXy06xKjCPXSnWQSfy9gOCUKbL4d7VO/Z3U/md6LEuVWaXD1hzuINgNhgYxHrw
 vcG8k7xrPl6NzspeJyOzhwLTgteIp+vA2wPjzylzkAVK/LoWOP8gbRGqgKRUaCW1EUR2Zwkluzj
 t1GKrlixJAOp+MESm+XEmrZWBUZICQ==
X-Authority-Analysis: v=2.4 cv=V7JwEOni c=1 sm=1 tr=0 ts=68ef61d7 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=OOab8uZhG_VM4ynorSQA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=HhbK4dLum7pmb74im6QT:22 a=pHzHmUro8NiASowvMSCR:22
 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-ORIG-GUID: nCGP5okA3d-HS6z3PSCAbcQs4SiB2MU6
X-Proofpoint-GUID: nCGP5okA3d-HS6z3PSCAbcQs4SiB2MU6

Hi Simon,
On 15/10/25 14:06, Simon Horman wrote:
> On Tue, Oct 14, 2025 at 03:50:47PM +0530, Harshit Mogalapalli wrote:
>> Hi,
>>
>> On 14/10/25 15:44, Harshit Mogalapalli wrote:
>>> In cgx_probe() when pci_alloc_irq_vectors() fails the error value will
>>> be negative and that check is sufficient.
>>>
>>> 	err = pci_alloc_irq_vectors(pdev, nvec, nvec, PCI_IRQ_MSIX);
>>>           if (err < 0 || err != nvec) {
>>>           	...
>>> 	}
>>>
>>> Remove the check which compares err with nvec.
>>>
>>> Fixes: 1463f382f58d ("octeontx2-af: Add support for CGX link management")
>>> Suggested-by: Paolo Abeni <pabeni@redhat.com>
>>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>>> ---
>>> Only compile tested.
>>> ---
>>>    drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
>>> index d374a4454836..f4d5a3c05fa4 100644
>>> --- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
>>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
>>> @@ -1993,7 +1993,7 @@ static int cgx_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>    	nvec = pci_msix_vec_count(cgx->pdev);
>>>    	err = pci_alloc_irq_vectors(pdev, nvec, nvec, PCI_IRQ_MSIX);
>>> -	if (err < 0 || err != nvec) {
>>> +	if (err < 0) {
>>>    		dev_err(dev, "Request for %d msix vectors failed, err %d\n",
>>>    			nvec, err);
>>
>>
>> Now that I think about it more, maybe we want to error out when err != nvec
>> as well ? In that case maybe the right thing to do is leave the check as is
>> and set err = -EXYZ before goto ?
>>
>> Thanks,
>> Harshit>   		goto err_release_regions;
> 
> Hi Harshit,
> 
> My reading of the documentation of pci_alloc_irq_vectors() is that
> Because nvec is passed as both the min and max desired vectors,
> either nvecs will be allocated, or -ENOSPC will be returned.
> 

Ah thats a nice summary of the correctness of this patch.> Maybe it is 
worth adding a comment about that to patch description
> or the code. But I think the code in this patch is correct.

Definitely will add this and send v2.

Thanks,
Harshit

