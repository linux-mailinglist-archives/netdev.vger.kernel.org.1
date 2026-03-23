Return-Path: <netdev+bounces-270652-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QP8/EnSDwWnATgQAu9opvQ
	(envelope-from <netdev+bounces-270652-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:16:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F792FB1CA
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C89CC307BB71
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56BA3BE65C;
	Mon, 23 Mar 2026 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="bE/YA0y2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B27397E94;
	Mon, 23 Mar 2026 17:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774288271; cv=fail; b=Qxt3PHMaGxM7TmzUYBvMz69tC4BZEzVNCYm9Ir0pbOcSvYfAU/tIOa8yshkMIp/KnOMm6wMldSFrv4OPWDMs7bVbu4W59VCzxPBmaDDmBbMTqt3PZ6NHcW6phZKsrp9DJwNG28eP+H2lU/edh21zzqCnb/pTLYn6HZ/iq8xei/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774288271; c=relaxed/simple;
	bh=ICtXne6zGV/lbsVcdY0oi0W0jlMu4HX79zzY3i4eEyw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LyPXHVnls114fgulJH1+FUu9J5eJw7dhLqyKorGYiUkuNKPBUXIvVuFJi4EhKZCh1wjZt7Xs6EftnfvRIQzfAfEZkT3lvK0fcE1OSyVMaJO036D4HgYA0/vToI2dh4azVbdZ1UHP/VLg14StRy0SlOoZOWrAUCfiQn8WCzrYw64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=bE/YA0y2; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NHGvCW657396;
	Mon, 23 Mar 2026 10:50:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=PCKfWXDqLwc4mZQcBEYJnP7Yhq9HkaDczVcrrU1rzwE=; b=bE/YA0y2pDzb
	yaB7F/vjfm445uO3x67HaIMalnggR68TgVDo1IdQLCV2LxZEysUS7Q5Cpn28eL4j
	CLCIbNzjA3OsiMzfXhko/6CTJ2wzC+wcwzQ3fIGzNpdbzazilos67iEF7RZw92y7
	+LY0XfDDLG0fAQnPBUiTZgrvxDXJN8dUBBOtiG8zb0HPL/HQshEGXJ45QeYCH1Qo
	3IkBtNJlla7tPgGCHhojl+UxdnLdu4n7ZwmvPIbYRfvIMd5+RxTYSNvJKjocvx75
	5wfk091lBAfNk1lGT7Q/jRCJoXVL8mB27KPGUkG0X5ohf9kvLZM6drRA1cocZegL
	YvSSlXWVOg==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4d38pfj39r-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 10:50:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJuUG6GP/xuTjCoPZzQesO3iVQSO2klB2Qr+AWYJGwEG2yuT5W2xulDrX+BR6MJjVQvzIr+9rV5XbhJ3oLJSsRwfHusDP+OXNmOe4vnm6+IMxmfqfyLDD0MCDse0L+Tu0hy0u5Yeny6tje7awUrAmJjLiwKjEcHLLouFGvlsa8c89dXZtxTgkg1b15nB09DODyr5lLbDSsdGZXqbQFO9PNrLA9eDlSE6R/u/O5y9DZg8ZF8922M1ppwIO91tVCDcpZdwJo9FGFuH0hE2qGZJWsmVOfay2jzS/KAfuEHqlY8VRYWRgl0K8djODghtLBPj0nGqy+2cooPPJcoQVVpPhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCKfWXDqLwc4mZQcBEYJnP7Yhq9HkaDczVcrrU1rzwE=;
 b=n8CaMauBQ/dY7tyNiwna1FMIKx19/JTvCAhRXz20ejskLJYUhNR3dbbpjIZ61eBGlsI3CVNtzR7bAVFDBg0I3iKP7a9R4vdqTA8xZGhqrX1DCtFx7BjorE+j3CUa584Wvl/rFGawizFhXpG5824HnvjGKsOgnAWfa3hYO9x6FIuRV4FMARW9ZxVxo6YVzdhbxBGo7yRUXOm9T09qWtWQJht/r49+FsuAgyNYNwKbwqWoXQLrkW9ornwheharAWYpWPQzakcnxu9WXO6aPTDF2W0ndPeODdttocirf7NZn36WQ+wzSzYSgj9MnXtc5Od8i9Kt2fuTYbRc/Nvuk3wLeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR15MB2287.namprd15.prod.outlook.com (2603:10b6:805:23::15)
 by LV3PR15MB6682.namprd15.prod.outlook.com (2603:10b6:408:26d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 17:50:32 +0000
Received: from SN6PR15MB2287.namprd15.prod.outlook.com
 ([fe80::8a07:a6bb:5ae5:c9e5]) by SN6PR15MB2287.namprd15.prod.outlook.com
 ([fe80::8a07:a6bb:5ae5:c9e5%5]) with mapi id 15.20.9723.013; Mon, 23 Mar 2026
 17:50:32 +0000
Message-ID: <f91a42f7-1e90-4db0-923a-371dac8245e0@meta.com>
Date: Mon, 23 Mar 2026 13:50:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11] virtio_net: add page_pool support for buffer
 allocation
To: Omar Elghoul <oelghoul@linux.ibm.com>,
        "Michael S. Tsirkin"
 <mst@redhat.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, dw@davidwei.uk,
        edumazet@google.com, eperezma@redhat.com, ilias.apalodimas@linaro.org,
        jasowang@redhat.com, kernel-team@meta.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, technoboy85@gmail.com,
        virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
References: <20260310183107.2822016-1-vishs@meta.com>
 <20260323150136.14452-1-oelghoul@linux.ibm.com>
 <20260323114313-mutt-send-email-mst@kernel.org>
 <20260323122728-mutt-send-email-mst@kernel.org>
 <6b6bea74-4bff-4301-8dbf-a9c162456185@linux.ibm.com>
Content-Language: en-US
From: Vishwanath Seshagiri <vishs@meta.com>
In-Reply-To: <6b6bea74-4bff-4301-8dbf-a9c162456185@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:208:52c::25) To SN6PR15MB2287.namprd15.prod.outlook.com
 (2603:10b6:805:23::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR15MB2287:EE_|LV3PR15MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c5cd4e-e4ef-49ca-fb57-08de8904ad8a
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr,ExtFwd
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
 FTqIU7lupCzBqxZTe/tKd8A/ta+rIMrotfOr5nLoVOmNf+G1mvvNHousdzO9pDJdIU3NBIvLBken00HkRXZmVIScOTw0Hua8VScovq0qtaZwApDTa6iT+eWgNCGsezMbGYN5kPBo19KQ+1Sf824yci5fe2Y8edMymcK/WMada/Nqkn2ru/Ph8DCH88CDKX8ErAXQnOr5YqdhWNyy/m+WPl3iJAlNVDSHT3cEJaZFWlwUUBXdRB/yQ7ZbDxOuar+Ihg4TiatgNjHg1iOhaBkFVhrISzCv38FV7aTiviTcTYVRx73IbG3Y4OKJE9LJLi/WHHvd++gHUVO01ytGP8O2hTGkJG/fRQtYnvFTS+ymZ7KA0QyXKDU6IQgkvoE9Rfmn4A0uxadMqQrNwbBZrD0UbB6YR3Lafk1RXHn8kBZmHBn2C+WpStDr1/MyvxhjdK7L+oIY3FKXtRjf9TF8Ryg6S0fDDKyoPrFHyapzKyLriyNf18ysIzCzcq5+HJwAzILsWWnJ4TnwSj9pehl2wPosH3Sulb81S9IJuAG/c6jW1b2WLVjPPhG7aBE3l1mCGYHD4S8laEYp18Hd5SiV5SM7TLSa/uoZzt6lmWq+Z21WxmyDTKGkuDBpe1V2Z0JDLSy+9CRylGR59YVE72elaRNufXGfXNAbFxsuEXuffdSr/nQzhXSZVnsCHkbYl47uSQ7sxBbTLEZ5EJAKr0CV3Q4ajBOgyIiNIQ7AgN6qmWNLNug=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR15MB2287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UWlOakZQblZNTVVKbnpjbldhRnZOY291QmtJTzVhVHdqRXorNVZsRGNka0to?=
 =?utf-8?B?TktsMnlFT0RCR2diYmZIR2hhOU92QmRRN3c2cUtOaHRaZ0JvMjBjek9nTGZt?=
 =?utf-8?B?OTBaR2lMU3BSUHZGNFI4ZlpqcnZMd3RNRTRVUnBmRGtYdU5qU2E4cS9sZURv?=
 =?utf-8?B?NlNzNEN5YUF6Q0ZFSExsVEhzSXhaUlVubUxUVUJxcVRCZ2lXRVFsNitBaFBS?=
 =?utf-8?B?KzhMOHBPZTdsRW53WjJhVjRrQ2FTRmtxRElUd3p6OVp5TlJpbHh0Wk1MSThi?=
 =?utf-8?B?RkVlL3NuT1Bvd2U5UDFObVFiRThFZ2FpRFVBN0NXZmUycmFMWjVFRzBRRVdv?=
 =?utf-8?B?TmRlQkd0alJyYWdCS3JYNUtWOG5paHpwM1RnOVRweTNPK003d09YRlRlWjFR?=
 =?utf-8?B?djNFd2dmV0p1OGVwV3lUQyt3VzRoOUoyQWR6ZzBCR2pjWUd5aEhndDFURlow?=
 =?utf-8?B?ckZXa2VvOVlJaCt5VDRnVUc1aXhmQ1FqVmRtbGNDM2xueEVmTERaeVlRdHR5?=
 =?utf-8?B?OEhNU2NZWnlEdzdUMmZDaW5CTzY1RkljN3NGSG1sRmlYQkZ1bnhEY0JHNmFO?=
 =?utf-8?B?SjJnWXNxM3l2RGNlNVAvME9KNzBZN1lOTjJyYTFkanN0OFlGcGp2b3A0bGxE?=
 =?utf-8?B?RHplQzVUM0Y0S29rc3o2bzg5QWxhaTc2d2lDYnhlU3R1RnIvS0IwcHp3elZt?=
 =?utf-8?B?cXgvaFlDSUhDb3VBR1VIVjRaNmdnRzZYV3FzNWx5NTB5OWM1TXNsVnN4aVJW?=
 =?utf-8?B?ZTFzVkdQbWdlQ0JIN1FZY0tldGltcUpZVWJ2TmQwamFVNHlROUxySTV5TkRa?=
 =?utf-8?B?dnUwZkhuZWF5ZWJyeitvV1JwMWx6a2phWjI2WUZhVEliNjN1Ym1KM1FYSW1l?=
 =?utf-8?B?SURiTE91VDJNVzdndmtta1BqaVVUREZxMlhLSEpUWWx5UWlwRUQ4MzRtZ29Z?=
 =?utf-8?B?cUR6RmF0SytkN01rbHIxNGVVajljcVBYMzFnOGlzQjdVcXlSM1poenkxeTk3?=
 =?utf-8?B?Q25PWTF3UEJRMFVqQXJ5em9QZXZpbE5CcVhsSVQrbEV3NXJ0YkxoWXNRQnZ1?=
 =?utf-8?B?N1pqRnN4dEN4VlNYWjNvTmJ5bzFKaVdQOWs1RENaMGxqNWxpTWx1amkwamhD?=
 =?utf-8?B?eHU5SHA4a1g3anQreDA3Wm1uZEV5dUN3d00rcC9qSmhoYm5hWnJqRXY4TEY2?=
 =?utf-8?B?MmtDVGJoTEVQV1N3ZERmbitvTjdWOE5PSWVybllyaVAwQ2N1WlVTcG5BODFw?=
 =?utf-8?B?R1BtMnBtVDBiNW9iQ0lKdG43MXRjZHh3ZW5pOGxNYW1UT01acFBjd0pQc2cr?=
 =?utf-8?B?b0FOTnQ1VkI4Nk5VSGd6NUR1dlhNNU91eTNSNUYxZ0hTbkdyLzNuVE9vRGt3?=
 =?utf-8?B?UjVhcmxqVldIUnovQjFkMTNtQnd2ZXFUOE40L0hkUkZDYVBRVGRNeFNUZDdi?=
 =?utf-8?B?VFZ0U3VnZGVhT01nQzlFTUpRWWI5MVFmMFp6OGt0MjV3QWdkaHhpNjhrbjcv?=
 =?utf-8?B?NHEzbzFFZ1dhbmhqaElvM1gxUnQzS0hrN3N5K3pDYnBRb05XK3NCVTFoTnIv?=
 =?utf-8?B?ZDYwQUxvckk5TWQ1Y014eWFvck1BN05WRlZGME51UklLaHBVY1hpVnJEMmVL?=
 =?utf-8?B?QVd4UjI0WWZkd0Z1VStEd3g4Mkt4L3Y1a2sxbmoxL3RNQzYrUi8vRkJBeWpw?=
 =?utf-8?B?UTczWUY3ZEMrazJUaXFjdnVXU0Y4RDBUcndBU1gyVXJ6djBxdWJjTlFrVDhw?=
 =?utf-8?B?NmpXdjFSckMrcnp2M3RjaC9TYVJlN01oYThySkpsRlhkdlpLNTJwYXhJS1Yw?=
 =?utf-8?B?b2NDTUxUK3A3NG9QQjVTMWM3NlVHS0t5bGhrTGUzdHpDai9meDRmT3FteUsw?=
 =?utf-8?B?WWJsVWJFL0ZIZXhKQStha1BPUlFmazJQNHdLT294QkZoYnVHMVRZUXA0dzhN?=
 =?utf-8?B?K1hzNC9aQk9heHBPNWYwRnllSFNGMjdtY1JLekpzS2U0VEc5SHNQV05WRHhy?=
 =?utf-8?B?ODB2SlVFaTNWUjU0YVNHYVJnaTM0SDFMK3BlUFRqb1V1VTJuOUFoRm1ROWxW?=
 =?utf-8?B?aGluanBYTXNja0VNbG13RmdyMnhGUGphVnI0bWZoRlJvcndJbENQQ0xQYmZl?=
 =?utf-8?B?SlJyaUhvRTVpbWhDTnBoUHRkdDFmZmhZT1RCRkVTb2dCOFprRnZBM1JoMnJ4?=
 =?utf-8?B?aTVvQTIxOXNUd3E4OVZLN2dBNkZqK2JsOSs2M3J4K0kzbWFLUndCV0dlbWpP?=
 =?utf-8?B?MFd1V0VVeXFxdUNtRFdUU0hwSzBGN1U3NW85dFpaVU1US1JkRUorN3Z2N2NE?=
 =?utf-8?Q?NbpsQbjWUASwsXV5GC?=
X-Exchange-RoutingPolicyChecked:
	JzI5cXzIjI4e1Ra5NontlE9GKsNexL9KQi1XTPQYRnAJlwXJl/Qi2saZPzdmCfUR5IoxqOagDh8CsTWGjoed4bxTcjeDrFKTXgEwrumkabna8osbcCVuwh7AdosanAESyuGd3I3NgIxUuPP8BcDmkl9y/NUV/ApFd53UoiE3N2ePpRuX7F9C0d7z+2BqaGj2/klTVQwI0FnThBJ3KxmGFnjZkxnXmVloFU0Alo2pVuYZSTmmvqNFxqq5VleY5So1hZM9se9pdYcobXhD6pCS6OV6FFWL85BN0gS7DpPdpwNTfHdnQ7B6WyVJ10wO5Mzw05yxeb2419QbRJ6kDCX+/Q==
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c5cd4e-e4ef-49ca-fb57-08de8904ad8a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR15MB2287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:50:32.2284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fl8J66RuubTaDWlGUi5YXUAcm9egcf6kfmr269wtYn5cUSE1EcYmBkKLHqsjvO+t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR15MB6682
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEzMSBTYWx0ZWRfX1daetHn7QkZM
 KDUK+88qk3KLBnZ1al2YLRmEyBhoExnWaJAcp/Y7CZmfjg5DC0Q4UM40hkIIJRekEKAG1SFlqE6
 JOXpSTb7p/hZslsly3Ock6PC6I5kXfo1CCq5FGqYU/9Vweo1ngGMBDpsLKHfKIXfeTdl5p2bkUZ
 XTz/RdsF/ITWPkAVWCfKfo9DbQly/vYZ1cNbKknuMM6Ab1nebQDPz/BIEtJOkXQTnVCpZnYGqrT
 69kOnkCJRt4qP0wx4iFogQNf/i5dBMsmWTu6cVgNH9bE1gEsiTzVb5LGJYfOND2zvB+y3+5bbKm
 li9Z2l3yJQ9nHzslB9g3zUvGnl8AgpoxOkDIe0CjqBniV1nIGtNC5gy9Ow9ZkS8ihaYLeY0RX0E
 GwqN06oIHCseP+wnjd1/tEZ+ToSnFW4vP16zoVG7pH1Qb42a53TQR8SW7MUBo880ViK2sHuoqQX
 FW6xU7KnIOEWZz26Jwg==
X-Proofpoint-GUID: wCyvdY3cnU2EduG-xZQs_V7idPHI8SY4
X-Proofpoint-ORIG-GUID: wCyvdY3cnU2EduG-xZQs_V7idPHI8SY4
X-Authority-Analysis: v=2.4 cv=LryfC3dc c=1 sm=1 tr=0 ts=69c17d7c cx=c_pps
 a=cj6+QZNyov9unU3rCXIAQA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=GbPsI2Ihf5RTnMjR_gZv:22
 a=hZhFEPdvpiY5ShvhQ5IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270652-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,davidwei.uk,google.com,redhat.com,linaro.org,meta.com,kernel.org,vger.kernel.org,gmail.com,lists.linux.dev,linux.alibaba.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:dkim,meta.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishs@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F0F792FB1CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/23/26 10:39 PM, Omar Elghoul wrote:
> On 3/23/26 12:58 PM, Michael S. Tsirkin wrote:
> 
>> On Mon, Mar 23, 2026 at 11:52:34AM -0400, Michael S. Tsirkin wrote:
>>> On Mon, Mar 23, 2026 at 11:01:31AM -0400, Omar Elghoul wrote:
>>>> [...]
>>> Well... I am not sure how I missed it. Obvious in hindsight:
>>>
>>> static void receive_buf(struct virtnet_info *vi, struct receive_queue 
>>> *rq,
>>>                          void *buf, unsigned int len, void **ctx,
>>>                          unsigned int *xdp_xmit,
>>>                          struct virtnet_rq_stats *stats)
>>> {
>>>          struct net_device *dev = vi->dev;
>>>          struct sk_buff *skb;
>>>          u8 flags;
>>>          if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
>>>                  pr_debug("%s: short packet %i\n", dev->name, len);
>>>                  DEV_STATS_INC(dev, rx_length_errors);
>>>                  virtnet_rq_free_buf(vi, rq, buf);
>>>                  return;
>>>          }
>>>          /* About the flags below:
>>>           * 1. Save the flags early, as the XDP program might 
>>> overwrite them.
>>>           * These flags ensure packets marked as 
>>> VIRTIO_NET_HDR_F_DATA_VALID
>>>           * stay valid after XDP processing.
>>>           * 2. XDP doesn't work with partially checksummed packets 
>>> (refer to
>>>           * virtnet_xdp_set()), so packets marked as
>>>           * VIRTIO_NET_HDR_F_NEEDS_CSUM get dropped during XDP 
>>> processing.
>>>           */
>>>          if (vi->mergeable_rx_bufs) {
>>>                  flags = ((struct virtio_net_common_hdr *)buf)- 
>>> >hdr.flags;
>>>                  skb = receive_mergeable(dev, vi, rq, buf, ctx, len, 
>>> xdp_xmit,
>>>                                          stats);
>>>          } else if (vi->big_packets) {
>>>                  void *p = page_address((struct page *)buf);
>>>                  flags = ((struct virtio_net_common_hdr *)p)->hdr.flags;
>>>                  skb = receive_big(dev, vi, rq, buf, len, stats);
>>>          } else {
>>>                  flags = ((struct virtio_net_common_hdr *)buf)- 
>>> >hdr.flags;
>>>                  skb = receive_small(dev, vi, rq, buf, ctx, len, 
>>> xdp_xmit, stats);
>>>          }
>>>
>>>
>>> So we are reading the header, before dma sync, which is within
>>> receive_mergeable and friends:
>>>
>>> static struct sk_buff *receive_mergeable(struct net_device *dev,
>>>                                           struct virtnet_info *vi,
>>>                                           struct receive_queue *rq,
>>>                                           void *buf,
>>>                                           void *ctx,
>>>                                           unsigned int len,
>>>                                           unsigned int *xdp_xmit,
>>>                                           struct virtnet_rq_stats 
>>> *stats)
>>> {
>>>          struct virtio_net_hdr_mrg_rxbuf *hdr = buf;
>>>          int num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
>>>          struct page *page = virt_to_head_page(buf);
>>>          int offset = buf - page_address(page);
>>>          struct sk_buff *head_skb, *curr_skb;
>>>          unsigned int truesize = mergeable_ctx_to_truesize(ctx);
>>>          unsigned int headroom = mergeable_ctx_to_headroom(ctx);
>>>          head_skb = NULL;
>>>          if (rq->use_page_pool_dma)
>>>                  page_pool_dma_sync_for_cpu(rq->page_pool, page, 
>>> offset, len);
>>>
>>>
>>> Just as a test, the below should fix it (compiled only), but the real
>>> fix is more complex since we need to be careful to avoid expensive 
>>> syncing
>>> twice.
>>>
>>>
>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>> index 97035b49bae7..57b4f5954bed 100644
>>> --- a/drivers/net/virtio_net.c
>>> +++ b/drivers/net/virtio_net.c
>>> @@ -931,9 +931,19 @@ static struct sk_buff *page_to_skb(struct 
>>> virtnet_info *vi,
>>>   static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, 
>>> void **ctx)
>>>   {
>>> +    void *buf;
>>> +
>>>       BUG_ON(!rq->page_pool);
>>> -    return virtqueue_get_buf_ctx(rq->vq, len, ctx);
>>> +    buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
>>> +    if (buf && rq->use_page_pool_dma && *len) {
>>> +        struct page *page = virt_to_head_page(buf);
>>> +        int offset = buf - page_address(page);
>>> +
>>> +        page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, *len);
>>> +    }
>>> +
>>> +    return buf;
>>>   }
>>>   static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>>>
>>>
>>>
>>>
>>> -- 
>>> MST
>> or maybe like this:
> Both of these patches resolve the issue on my end.
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 97035b49bae7..835f52651006 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -1956,13 +1956,6 @@ static struct sk_buff *receive_small(struct 
>> net_device *dev,
>>        */
>>       buf -= VIRTNET_RX_PAD + xdp_headroom;
>> -    if (rq->use_page_pool_dma) {
>> -        int offset = buf - page_address(page) +
>> -                 VIRTNET_RX_PAD + xdp_headroom;
>> -
>> -        page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
>> -    }
>> -
>>       len -= vi->hdr_len;
>>       u64_stats_add(&stats->bytes, len);
>> @@ -2398,9 +2391,6 @@ static struct sk_buff *receive_mergeable(struct 
>> net_device *dev,
>>       head_skb = NULL;
>> -    if (rq->use_page_pool_dma)
>> -        page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
>> -
>>       u64_stats_add(&stats->bytes, len - vi->hdr_len);
>>       if (check_mergeable_len(dev, ctx, len))
>> @@ -2563,6 +2553,13 @@ static void receive_buf(struct virtnet_info 
>> *vi, struct receive_queue *rq,
>>           return;
>>       }
>> +    if (rq->use_page_pool_dma) {
>> +        struct page *page = virt_to_head_page(buf);
>> +        int offset = buf - page_address(page);
>> +
>> +        page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
>> +    }
>> +
>>       /* About the flags below:
>>        * 1. Save the flags early, as the XDP program might overwrite 
>> them.
>>        * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_VALID
>>

Hello Omar. Thank you for the bisect, apologies for breaking the
functionality. Thank you Michael for the patch, I will be careful next
time about DMA sync issues. Looks like the bug is fixed, is there
anything else needed from my end?


