Return-Path: <netdev+bounces-267538-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHqgAONAtGlljgAAu9opvQ
	(envelope-from <netdev+bounces-267538-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 17:52:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B95287946
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 17:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE96E30472BC
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3936A35DA6F;
	Fri, 13 Mar 2026 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="PhBWaFcy"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11853CA490;
	Fri, 13 Mar 2026 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773420672; cv=fail; b=moNTdYtNSm8wb+7WXmrJs679bhyeJ5NBlLXwNt6Nh13lHVYbLEkj+zybfgbHfA73N946/YvOK89Jc4Erl3FmwSLe39LKrca20xIDRMimsIRIyYIUDZ6OnxxUzPV7IpX8yObc1HFzHFUJ4ZNXqNuyYq2NHjmm2kpNf7UQvX+bxK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773420672; c=relaxed/simple;
	bh=4/XVHl6n8P5+e35qK9jd+kOoHVaJ7C2up1m6Tny7yiM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R7TI6Pv2+dE0arY2FNFp5aEEnJOO3a64MxAL+9/1xqinuf4qIXQEJKRVMI7q9TaH1wSCeYYoY6QsnJh8lB7Bld8Kt+ZkSmSA9SyzPMbP1y+s5JBk4gqrZtyn5kolSowpjb41vTl9r1CIRDoKiKirxs263wBWQjfQbqleW2KdAvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=PhBWaFcy; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 62DEZf8G3087550;
	Fri, 13 Mar 2026 09:50:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=u8fo+6BbZro+G9k1MsZB/7MmnGh89anKbb9jdBql6N4=; b=PhBWaFcyEdL7
	Y0IKztld05TRDF6bYrxyKsPDmOlOFoBfplWTa0n4oHzJIzLa7lUMB8PL/hoauFqO
	Es1hD2olrqR0t27rTPnslRSlJx0v7plRMjEuiOZ2uESD4oRuH3jsKPDqZMw14xaE
	0fZKff7xcafXToR6u6CiuermNYRMOHWItpge/3lGB1qqwdBEHoUNfwDOO3iCx4RW
	HreGK2+CiQY+7bP0YbBwXBZmNZlmLqG9EgUyMyJpj3kQlws5h+TqtyxdS9+rxgQ4
	URxLzC4urhGsxdwTbcjuPN4VRS1DW4K32ZiscmlMF5CE5mbFhhLQve54HLUVOsyB
	xuZlYcUcfA==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
	by m0001303.ppops.net (PPS) with ESMTPS id 4cvf8ep093-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 09:50:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCHHWpBCDvb2ETO8eE9/PxSpDLpO1Q5Lkxov4TQFYNlZjMwrov8HUjQUrSifWYlJrccdUf9h7j59A/ZPiyqfmttK4eMQ8WkNVZwRWYF/fcAEBkQaxGHfduwP774HgHY9JLq78YfVG2iz6DnHpu4gwwVtv4K1tidY5FPGDqFPL82W2ZZMA8gLgbHrJJ6diL5wCgkfrs1WBDiihNpzwEG8sP+RqqRikjRb4a3lg5xZjmmOIpoiKo51i4LB7vqTp59v/zczMaCqEm47rYvMQQNOXSz7gsiuzNkdhln6OoRcfJ2jTTq/3Pv8rdS1zXKDJRmXPGEbDjW0FwdZ6TR9KDM6QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8fo+6BbZro+G9k1MsZB/7MmnGh89anKbb9jdBql6N4=;
 b=UpJi8U6V56i9jG40SOcdCzAF8+rQs0R2r1gQ55JrPo/ui7QI6ueJnqywg7DQ70AQ/Xbp7S4b/StLrmsvzVGYBeHvHG5EreXFIl2HgCLCMsMuHzaqQWMnGXwywZqU5L0c+fd8eiVmhJHbw04hdQUK4O8yRy3/PNnJdaltjoaBEMYwvhXg1vvSoTAovO+WK44gm9JZqOE612qxIxkOgbQnFiWh++t6c1YwM5gVu082y/xSHOezpMuCtDI1TZJ0vaKPVZL8EfBV9+XNdLIdFRxBulI6fVj/S8Yz9+8MO7t8zBfenvPWaPc09AyN0yin48s0223Md6UyViYBrroHXM/SbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB3893.namprd15.prod.outlook.com (2603:10b6:5:2b6::17)
 by DM4PR15MB6225.namprd15.prod.outlook.com (2603:10b6:8:18a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Fri, 13 Mar
 2026 16:50:51 +0000
Received: from DM6PR15MB3893.namprd15.prod.outlook.com
 ([fe80::12c7:cfea:e8a3:9667]) by DM6PR15MB3893.namprd15.prod.outlook.com
 ([fe80::12c7:cfea:e8a3:9667%4]) with mapi id 15.20.9723.004; Fri, 13 Mar 2026
 16:50:50 +0000
Message-ID: <130cf9d5-79fd-4d12-ae3e-3cafebde02ce@meta.com>
Date: Fri, 13 Mar 2026 22:20:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11] virtio_net: add page_pool support for buffer
 allocation
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>,
        Matteo Croce <technoboy85@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
References: <20260310183107.2822016-1-vishs@meta.com>
 <CACGkMEt8WWbHRpD-e4aHBdwbK9QdvCcCX39xzK6FRrb263G+5w@mail.gmail.com>
Content-Language: en-US
From: Vishwanath Seshagiri <vishs@meta.com>
In-Reply-To: <CACGkMEt8WWbHRpD-e4aHBdwbK9QdvCcCX39xzK6FRrb263G+5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1P287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::26) To DM6PR15MB3893.namprd15.prod.outlook.com
 (2603:10b6:5:2b6::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB3893:EE_|DM4PR15MB6225:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d1c925a-1f4b-49fb-603e-08de8120aeb3
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 lDwEG4Jc3wpk7pbWIE2qpl+bMfh4C9KGpxgpunewHM8icrkYxpsOs6CYiEuqpphkS4k0xcLe2b/fiJoLMdcJcT9sMh4X35X+Sr6eyUqArSLjWJSq7R8i2dMxbWTvZfCD0Smrie/a8oJDwhpn9dTCIi28Rvz+vY2ci5Ma/9U8M3PYuPIs+SAQvNPiXHuKlQP3D4ZDnS9Rkkkas6IIgm41icWUnVZ3Xotuh6ODbpEoQTKpw0B/mVp6f2znYLwlX8pUFmCRVZRNLkD1S3lStTyAYOChZWoVtsW7M0F6U9Cg1g1SfbyW8+4WqajNAlOyS8GalWu99EpazhcsMn0+Mk8gZHHOwyL6J3wS8NdK1xsqxy2DX+c1NNxzfwwLJUJrRbsymC3teDnlTb//fg3N12ebVRR5WOzLzdzlGAAKAcomMgF4hGfkdCBViEBrA/w3q0Pj732OFVM/hiVFPCXfOoh2ybGLLxC7BgrcdcUehhpnUuN/BKhbPlHTlbfA3IbEoKAXlPyWNwC+qrfkpzEvZaip6obMlvRYAjfKQuy8Exhyi/50wbiMIw/FCRbEYLidnUXJtoEAHkZawvDpQpj4F68BcnVcdj2kk0hSPZ/m96Aaa82YPjC0+0SxGlFpuW1K+nwxTKy1znznyV/xJJjLQ0Gbt9cS3/ZO8+gCvsubGY2DFmfXHj2Q/ycC+EVfyEWgo7W47Mbzs5pVg75A4Dk9RcsOIMFyQiXpNIMINjDGsPZpbSk=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB3893.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WUdnTkMrQkxnNkcyVGVESWNRZnRyaWtRVW44Rm9lU0tsYnBMQVNvUUtqY1o3?=
 =?utf-8?B?M0hNTXdyc2l1eloxV1R2OG5JSzhnRitaRGFjemRsQWYwRHZ2NHFVYmE4WXY2?=
 =?utf-8?B?WSt1MzJnbERyTUFLRHg3L3YxK0dEd0YzVnRFTnVGb1FWc0pIazdwSHNFVmhW?=
 =?utf-8?B?S3Qzb1ozVWpzUWp2ekwyTXJteDJHcVU5Mmx0emI3L0llTTBLT3pkbXZzZWor?=
 =?utf-8?B?V3R5Y01mQzB6MFVFSlBjaFF1SmlGR0pVd2Yxa2dEVXpBUnk3TnFiNnFTMnRt?=
 =?utf-8?B?RGNWeGhmUS9ZS2pSOU9iZEc5SFZ3MytySUwzeitLYk53dG1KUjZ2M29Ia2NF?=
 =?utf-8?B?R2trdGtjd2Z3RDVoRXB0TTRxYjN4cE5rMkRyamRmVXJEUVpNaVFuNXhyYUJa?=
 =?utf-8?B?Mk8zTUJuT2FBbjVWS1Z1SitRU1NKbkFBNXExYkVFRlREa2podkJvM2w5eTA4?=
 =?utf-8?B?ZkxUVkFyUG5IbEZEek9Xd05YT2xsMjBYbDdNTmhNMmlxWUt5Zm1OTkNScUVs?=
 =?utf-8?B?MzdURkp2YUdFZXBwN3VMbjVWbWZSR3ArR2FmdVB4a0VZSjhRdU1jYWRzZmdw?=
 =?utf-8?B?eFM2N0t1QXVEbXVMZm4vMXdOWUdVVlJucVVuVlE2TjJObUtKajJvL2dQNllE?=
 =?utf-8?B?ck5PV1BOUllhZHVNdEE4dkpGTVFtbzQydDBJSStVNFRTUWpJNkYyQWs1dkVO?=
 =?utf-8?B?d0NWbm5VUk9hUUNZRXdndDlwR0dad01tMU94dXU0aEUzSVVhc2lKZFBWcCs1?=
 =?utf-8?B?Um5sS1NTaGkxYVRQV3Frb05aaFJpd1Z4WGxGa3VrOTRhM2wvZXNYd09FbXhw?=
 =?utf-8?B?UmVGKzZQOFJaaFJPVjZQaTFoNmJtNWp4UEkzMGozV3VPQ285bkNFbFg1NmRE?=
 =?utf-8?B?S250cDN5MU1PaXBkcGxCd240NXltQlFyN01uUmJMc3c0YmxheXYyMCtKNzJ5?=
 =?utf-8?B?Q2tPVFJZTW43UTkxUXVoUDhjWStBTzhDRGlGZjlqaENlT0NMODByYzVFWWMz?=
 =?utf-8?B?ZHgxZEtnNG56eXFDMnlFOGNKVDM2N2NWRHBUTkQxRGJjcDh2SWpvTWRNSFBr?=
 =?utf-8?B?ekNGZndncnFqRjlzT2F4Yko5bnZTMnFzR0xwZnVacVp4aDk3c09nL3Rmd0NH?=
 =?utf-8?B?YksybldpNUlGU0c1QTUwUkNOOFpmZEoxNEh4R1lZNjlDQXNFMllaQUdxeVlW?=
 =?utf-8?B?RncyTU1ONGQxYXg2VWhJc0ZKd0pOS1VGTko0c2hhT2lrc2JEbFRZdHUxL3dx?=
 =?utf-8?B?eXZaZnY1K3kwNVR0MzM5dUlDVklEUk5pTUcrdkwyRWtvRGlwMWpSa2IraXpi?=
 =?utf-8?B?U0djUmQzN2JtOE0vYU9TSktieTIrdkhySzA4b1NrSkZKYUdpSmdvMmk1ZnBi?=
 =?utf-8?B?eVFFWGgzdzNLbXJDVnlFVzV5elVleG5rNjg4NFlmbWpwRjRHaS9VZVRVYitL?=
 =?utf-8?B?d2ZWTkJNQWlqT1dRd1plQ3psYTRBZ3VSeDNYc0E5UmlwZFppRUFYL2ZnQm5p?=
 =?utf-8?B?U1JyUm9MVVV6SDgxL0NUaEdRVlhOR3FrRG9mbHJHNEtCV0dCSC9ySkVGS3lM?=
 =?utf-8?B?S2hYQ081V1ZxOVFTcTJJK0lOSW55SVdTZ1dRK2NWS3NUc280VjQ5MGpLNEtR?=
 =?utf-8?B?bFh5M0VaUjN4aUhFdUxnUHFqZXRqNklPcjREbEdqWVBwQlZhZGxjWnEwWDg2?=
 =?utf-8?B?ckhaZ2M1R3lPWFM1L051Z3J3MExjbk92L3FaUFRJVG1HZklxZldJYksrRXJu?=
 =?utf-8?B?dUh6aU56aDQxZWFxYjIwRXplaU9CeVZESjQzVkkxZEFlSVJ6ZTIza253bHBr?=
 =?utf-8?B?VjhuNkxQOGdjWXo0MEdWOTRrNlprRDREYzlLbktkYlhlNWZtemErdGxxNnZr?=
 =?utf-8?B?ZkFWRVlUcXZCY21GSVNnQk91KytTRytCdG5MV1Bwb25NVW9xcndYVHJnbEE5?=
 =?utf-8?B?bkRZY0tJMk1VYmRvMnoxdnBBcGRhSXRuSG4yWnJ1MzF1Zng5TUNEWi9zTm5T?=
 =?utf-8?B?RHhQWS9nemJndEJjR2pQTlBGVkJDcHRXcjJzV1dIaXB5MzBwYU5jN244c1Ny?=
 =?utf-8?B?VkMzVlBpREE4ZDBVTDBLYUlpUWppRGsxVTFma3BwbnZROC9rMC82U0ZtdUJ6?=
 =?utf-8?B?MFZ3R05lekhkRUx6MVpOcFhXUTNrYUVnMEp5TXZ3SFV3QkIrejhRVkwxaENu?=
 =?utf-8?B?ZVc0elA1Um0rajJEbElGZlE2K2E1cE83cFhjTVcralFvRE40YVE0MU96NTIy?=
 =?utf-8?B?UjBtZlUrM25OUlNXMmovZmRHbjg0dDh2UjBzbldVM3V1eHR6Y2NCbEdCcTlG?=
 =?utf-8?Q?AsVBWqwKG5q4m5Adz5?=
X-Exchange-RoutingPolicyChecked:
	HiPR+9YmNrQtVD9soZ3CDb3kFvzfotFLMP3DMMjM1Y1FuBTzq7UoU6eV1UH1HLf4G9rflD3QChvBRuoG3My9ZudI7AmINJQPdOO8TsP6SjLrJ4/yGhCzY1d0AKpgp5vdT6M8nNKkJJ6aMhCM3GQZ/e5zwS4lzzOssjbA/9m9Vf2UqsqT6VeINpKuBfiYbVbnjR3TEDofqwnlkftPwesgZHeD43h2/0Zwy36Hlik4bjJiuiMbtnJVKPPQoSjQ4ICq5y+du7YY22WLMEgszUqKnvLtl5LlH2IrNz2ECYSII2kwH5AuKImjaWqC5RPqpOBpFvY8+MUlhaO5HxwZrpWiYg==
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1c925a-1f4b-49fb-603e-08de8120aeb3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB3893.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 16:50:50.8726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vx7N9Y6CO4kMj21iGB5H9ZR6jYd5PGNpPyd8EWBRGzTEuOxvYZ4kfVXmOesSjZ2n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB6225
X-Authority-Analysis: v=2.4 cv=HZ8ZjyE8 c=1 sm=1 tr=0 ts=69b4406e cx=c_pps
 a=9H9ADJ10uJ0pYmVeXPB43g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22
 a=kBVPQyNxwNaCc7z1V0AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: XWVzSATU1AJ0dWtwRdtw6qQJ9jiR2hpX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEzMSBTYWx0ZWRfXzVxPm/uaH1qL
 IpR2r/rs1sTtaoSwNfJYt4nzuX8YxemLHVKPbeH2eqZnOsICfagbJb+CyaVsIj9KcQsM1T4UMbq
 E5//P6dtfA3WHBtDej/7yj3UB4f6ZXd6+vyCyyjdZ2Ky7MLBRY/V6MeXr4sqbOP//jr5RwPSBAf
 Rserd9VpgWg3qw7Gsj3gla7SNJxmfDSA8W91EjILcYt+5ZgPq9kzIDl6TxGohKgcAwUrnzOeWQ1
 FKgeslaVYOWa6c8H1RJ/l9fA9UFfcRXz5fHQlqdl/bM2pZR2Q+waatFkMtXi6azn822I76RdumT
 L64ZNWr9ap8mAusG1ubQ/SNiUhQI9D14X21GQBbFb46aIAS9+Q790l/BE5UPABycyjXBr9cmCtp
 /mKXAgrVCRrQ3LS4O9Q6enBHF6cEm4k5mpf11QpPk9HNhu8dK/aeSWNqGjG1JEsaPj1bz+0XleK
 u2a9uKOi6kTRIHCwEdg==
X-Proofpoint-ORIG-GUID: XWVzSATU1AJ0dWtwRdtw6qQJ9jiR2hpX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_03,2026-03-13_01,2025-10-01_01
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
	TAGGED_FROM(0.00)[bounces-267538-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,meta.com:dkim,meta.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishs@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 22B95287946
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/13/26 1:21 PM, Jason Wang wrote:
>> -static void put_xdp_frags(struct xdp_buff *xdp)
>> +static void put_xdp_frags(struct receive_queue *rq, struct xdp_buff *xdp)
>>   {
>>          struct skb_shared_info *shinfo;
>>          struct page *xdp_page;
>> @@ -1781,7 +1660,7 @@ static void put_xdp_frags(struct xdp_buff *xdp)
>>                  shinfo = xdp_get_shared_info_from_buff(xdp);
>>                  for (i = 0; i < shinfo->nr_frags; i++) {
>>                          xdp_page = skb_frag_page(&shinfo->frags[i]);
>> -                       put_page(xdp_page);
>> +                       page_pool_put_page(rq->page_pool, xdp_page, -1, true);
>>                  }
>>          }
>>   }
>> @@ -1873,7 +1752,7 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>>          if (page_off + *len + tailroom > PAGE_SIZE)
>>                  return NULL;
>>
>> -       page = alloc_page(GFP_ATOMIC);
>> +       page = page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC);
>>          if (!page)
>>                  return NULL;
>>
>> @@ -1896,8 +1775,12 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>>                  p = virt_to_head_page(buf);
>>                  off = buf - page_address(p);
>>
>> +               if (rq->use_page_pool_dma)
>> +                       page_pool_dma_sync_for_cpu(rq->page_pool, p,
>> +                                                  off, buflen);
> 
> Intresting, I think we need a patch for -stable to sync for cpu as
> well (and probably the XDP_TX path).

In the old code, I believed the sync was handled implicitly inside 
virtnet_rq_get_buf() -> virtnet_rq_unmap() before data was accessed. 
Could you point me at the specific path you're concerned about for 
-stable? I want to make sure I understand the issue correctly before 
sending a fix.

> 
> 
>> +
>>                  if (check_mergeable_len(dev, ctx, buflen)) {
>> -                       put_page(p);
>> +                       page_pool_put_page(rq->page_pool, p, -1, true);
>>                          goto err_buf;
>>                  }

Sorry for missing that comment in the earlier email


