Return-Path: <netdev+bounces-260887-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDcjAEXYnmkTXgQAu9opvQ
	(envelope-from <netdev+bounces-260887-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:08:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1E0196424
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB47A304209D
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60700393DC8;
	Wed, 25 Feb 2026 11:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="D/uIPvrh"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCB432D0E6;
	Wed, 25 Feb 2026 11:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772017459; cv=fail; b=OlJgQiI5y8/t3Fo7EoGbD3gr7fLmJBRkT0MV6/QXchUZLJdwOlgA6QzmzEYa/IfOG8/7pRg78OeDEXtiZfr7y2yCVSXGZdlPBUNlcS/+00hN+43yk8SK50pV62+kq2PK9VkiqK3MW6AQNe8o7BelfjIM+QbmFM9Jb7Rq/y9a+pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772017459; c=relaxed/simple;
	bh=BudNAsLfAwZI/tr5VWsFJgj+CIat7sh2y+4H6ISFSeE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hzsIqbTJsU+0Lw8ReBBXW26pIVUYBVwMvr7CLBEL9K8q/BYNTqA7p8GAyuIMqmu6UAJMCX4w5sv51kJV9gL7L9gqQIDAbtpnfMz21MHgIj4Houg/+VXJ2SHi6oqdV+QSMEXAUlmMjNvlbxFZm7J0MQ//e8oFYzhK4VfMthrNi/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=D/uIPvrh; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P9QfWV2806764;
	Wed, 25 Feb 2026 03:04:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=fgXo4F2qWN6VT2LmQRY8Sh+xlzhj/CpFNrbKy7QIjE8=; b=D/uIPvrhA4vp
	4YUu72la69KgMWdroK6IsF1QfqRlRDPYWoibC1t6RmvEFFat7N/OwRQuvecZx+86
	fEjmCQ8u+MWH3GHo5gADCQF2a9eaECthTEgJpCMuSQsFjf5aNjsxC5xF9Cbs7V5B
	kiadh5sxn+4hgkD1g69GSRMjMtGyDo1G8f0OCRde2kqodnOSEUn8ATfHNejFlvvu
	gGen2yS1P3za9meJVPeDNEoefP+Y8diU67W79NW8nsf1cJArK72VhNjyZxa6uKu0
	fdV05Mc3ULAP+12WlbRCXBbsi6b40NsetGUQc1wnUMSQ6pz3zDwtD36kGdB5UvCj
	Bd5RS4zbcg==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012041.outbound.protection.outlook.com [52.101.48.41])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4chn94ca3m-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 03:04:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dcuWVP2J3Et/FBG7jzjXVb6Pjrvv06Tf76Jd1HKijclBLJ9uZQWuKVcGjPPjreq4RTALcucS+s3Z5h7qykGT/gWqStG439G++sUOWveAirLg+XSbwIqMAkemDZQSllDxZNZzIeLr3a4FGTBII9nosZgp57TYG3blHUBiAUv4DkhAwiQl/H91R04OvAMTnqaS9mReBp4PZ1vLiPa4gH/UHODfoUPcJnB5YTEULRDr7SAeq9cwaj+sIph9lHNvccA3shlr2iq8cXMBcGTZcJM1tPrjT9zyk7fijimMPEuPuqGOfNpzSQj+HNThsCk+uxUv3qaqxZy5Zf64HzIcKYC0Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgXo4F2qWN6VT2LmQRY8Sh+xlzhj/CpFNrbKy7QIjE8=;
 b=c+h8urJfx6EVZtqhzqif7BQYeiS+9++zkD0hOO3j674cHVPEtc7r77RuL2uZeUFBh84baG3MesvNnAQAbh0BsuAZViNZikWoVDs+WXP5dnSg0hj/5et7aJG/4osaDPNwUq0xfSNk6NezMVY1+NuUx8Y9DegRFYb2c6Tu1fs490Je3eSRt3ERhatZrRIkDfFhepNkpoakFm7WNHFOG2vnlJlSxKNgQfkPvjf/tZ9K6UdgsFe4I6gQx9NH0gDNXTdCiZX07MJrRr3BAzdFvFdDEuKt91EHN6eG2Efe2zhd+N9pXRsqDly3nPoTpmITWts49TZXT9/5HNV1opC7x/OvtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB3893.namprd15.prod.outlook.com (2603:10b6:5:2b6::17)
 by PH3PPF387AEB7F3.namprd15.prod.outlook.com (2603:10b6:518:1::496) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 25 Feb
 2026 11:03:58 +0000
Received: from DM6PR15MB3893.namprd15.prod.outlook.com
 ([fe80::12c7:cfea:e8a3:9667]) by DM6PR15MB3893.namprd15.prod.outlook.com
 ([fe80::12c7:cfea:e8a3:9667%4]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 11:03:58 +0000
Message-ID: <72f48f65-1ad7-4ed0-8e08-b76196206ce0@meta.com>
Date: Wed, 25 Feb 2026 16:33:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 RESEND net-next] virtio_net: add page_pool support for
 buffer allocation
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
References: <20260225044910.1328791-1-vishs@meta.com>
 <1772008398.9732423-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Vishwanath Seshagiri <vishs@meta.com>
In-Reply-To: <1772008398.9732423-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To DM6PR15MB3893.namprd15.prod.outlook.com
 (2603:10b6:5:2b6::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB3893:EE_|PH3PPF387AEB7F3:EE_
X-MS-Office365-Filtering-Correlation-Id: 68a78750-092c-435a-c7e4-08de745d9300
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
 Gc+x52K4ljlQRUgAdGMdZVbohALC0JIKP//IOwiKekaRGs1bgGWFGBYpR+L6VU8XMBvGXcBgHdiUIKE2oVl8xQ0La56KqVpeO48hfQswO9VI5Hi23AWoi/nF3NFbNrjyl3jhGn92FPBSWTZS0IJnYZqETxYudSKXgS6B3mAiOCwt+YqPcUUWhP82ihUIlniHz8XDY+/hmVdSZxX8UDUJ63lJLMlpfozMD+djhY2tWifjj+0D7lvrRAiT2e26Ss4mJb77sE/jwrgbQNQ+5AP50cyBo5/Oof4DPJps/aN/9N1my7XIxPKHJRFEJPrvpSTatIscGWJlyJ1o6rtRqp8S3MadYTW9bXCBLKxb2nsrn4SNrI4+vuKrjk8GFgLvfAi7Nqi4+MBWppfXt65RLT1fegznitVIBz5NL3HKH445x0nHd4O0a6aMaSoBm0M//nBHih+mpbZmbHQHfNwQX3vabKlU+RHVhkO6K3iDYgZzSef47+IEewHSNagqetyoMX8ubjRUmLkLEhOLM+kGWtpq8DpuPjNZ+doU2WNvI4AjSlTm0zEudzU3EjPgUxcVixsbqJ6KQdT6jnzbUuHn/3kNG9CtcAxPnOIwQMWCpxVSz0AMEqmdP/gsZcjWDWo2zlAi8gTpdHIOyHV+xr6Q909NHRnK4z2fgJqGahYD2NYvYvPwINCMALnrwmv/aQucb8/uZFY0zlVxbRDDE08gKwoANDGTkb/IzofeEDrCSVY93Z30LsXaZrK/7uwoyBtlE5h9
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB3893.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aTRFeXpzb0lDVmpKSkRUeVYwRVNNM1hZU01vbWo4UTIvTmR4MktxT1BDa0Fj?=
 =?utf-8?B?dzJEYVVscm9FK3dycEt4K2FIS00wOGVaa2xWMFdtTWt3aWhrNEJyeDEzRUZh?=
 =?utf-8?B?ak9Ca1IzNVU1bmxDQzg5RHIwQU4yN0hDdzViSWlCY2VNUmJ3a3dKb05DSjA2?=
 =?utf-8?B?RHNjOVk1c3Mwd25MN1c2S0ZXNVhnOFVaZDdSMUVHdzRSS1ZwaW5XV2JmWC9m?=
 =?utf-8?B?YmVjWmxGVGZjYVlac0hNRzRkQkJvY0poSml6eWlUc0VyZ3YycUJaQlpwdjFo?=
 =?utf-8?B?WEdJazF5dXNic1RNRDN2aThQdDdiRjZUa0p5blpJU0dxREplRDZ6NmFKWFRX?=
 =?utf-8?B?Z2VZR0lYNklvcG9pMGZYVmtCRjA4OStaTE1nQWNRT09HRWt5V0E2aGw0aXhp?=
 =?utf-8?B?UCtZV2RYSUZmSGlqWVpaSTByVHZ1bUxoL25WSVp5eWhtTkRkaWQ0eW5xT0NN?=
 =?utf-8?B?aS8vS2g0WmQzTEV6VHFyQTlmVytvZTVYUzRrc1BYdUpzV2tRbStFOWtwVm1D?=
 =?utf-8?B?dWRWT2F2VzZ3d05EeVBVUmtvSnM4RkIvYWNzV2R5S1ZwOHR3N0lTcDY5TVIw?=
 =?utf-8?B?YkhUR3hoaGNUVUFOY0tFeTNMNGwwSnNxVU9jTHNwOXBTNmRUVXVBY3pKL292?=
 =?utf-8?B?NmZzQk9wRkJmeTBqREZGQXJ0TFhjdEtjY0c0UEdFTFM3Z29oQTlTYWV6R0Ew?=
 =?utf-8?B?Vm14WXhMK3hLRUQzY1p5OW1IdTFUYW44amVKb05Sa25ySzFPcDdaYjdQY2h2?=
 =?utf-8?B?RTRFZHZRWG5QMkVzUW96SURwOEpyKzV3eTJvdFlBdXRzQ3d5TGZPemM4blZi?=
 =?utf-8?B?MnpRelE2WGRmU0FrM0ViSUMzcnlreXFWNmNrOUF4L1ZlTmRSOGtFdjVjbkxB?=
 =?utf-8?B?SXBiZ0ZoYk4yZGRXOFF5dVpBK0FkVElCRno3WlFURFFUR2pjNm9MeFRXV1Ry?=
 =?utf-8?B?T3AyUzlvK3hnRmVMMCswZ0x6a0h6VjZxbThCWkExdWFrS2hNdmtZNE1kR3lw?=
 =?utf-8?B?dnRzRTNkOStKMm9RdUVKL0lINTRGdGNDUzFiWGM3QjdRN3p3RDFrc0x0bzlR?=
 =?utf-8?B?K0E3Y2xTbU10M1dkTHpVZlp2WDcyZWFNZ1NQOGhUUnowZHNZMDBWWDhuNHJv?=
 =?utf-8?B?USt5dTdDNGpnVmtnRktNSTMyMUhhdGU2MmtaSEpRTUwyd2prdGlOS3lKRDZP?=
 =?utf-8?B?eFdURVZwSHd0aENlTSt5ZE1neFZXRUd5bXd2K2dkTkgycVFpbGswbGcxWXo2?=
 =?utf-8?B?ekpQeWZkMm1EM3Z6NXEzc3V2OFk5WklmcGVSL0tISjF4RzYwQ0xCekQzck0x?=
 =?utf-8?B?eTU0WTdyRnVLbmVqYmtKazNBRER5WmRORWMyTkRENWJ4TUxsU3BWeFplWkFU?=
 =?utf-8?B?cnN0Y3J5STJlZEhabTVMU01xa3ZBdklHMkNSM0RoNXpySlZpcm1OZnAwTmN2?=
 =?utf-8?B?cEZ2MlhsSzIydTlNVmhVVzVrRFJGbFJWUjFIT1Bya29DSUZxREo5elV6TDRH?=
 =?utf-8?B?U1RhdFdzeE4yUzV1cmY1L3pKUDlGK2psLy9DUGlqeU9aaTROakUwZUpiYlAr?=
 =?utf-8?B?R1cxRUhWN3k0Wjl1NWtRNHoyZEJpY1JUWThQVVhSMXlVb3dVenlOUEFaSmZh?=
 =?utf-8?B?Yyt4V2lyOEZFMFV4dHdwSDNLQVRiM3gxWTVjMkFuVlNETzBXbDJFOTVqUkxI?=
 =?utf-8?B?VDFIVlVPaEhEZXZrR1EzV3BQOWd6R0pCQUhoRDZqbU5KRUVtMVIwUFU2K2Za?=
 =?utf-8?B?bmJtOHZhODlIYTZ2U05ZYytCRWY1RFJYM2hrSm5YeXR4YzM2WHVoQUx4K3c1?=
 =?utf-8?B?aFdBZW1IV2RUb1kyM0piT1Q1cU1WZjJKZEdoS1R2NEpMOEdwdzVjYUpKTEwv?=
 =?utf-8?B?djJyNCttTXlJc1BwNHRMeHo5cHZnTFNPRkVQSkZHQTI2TVlhL1FUVUJXU0t3?=
 =?utf-8?B?cUd4ZFZUS0NyTXpNa2RpaHN0SEpncFZsdzFhRm9kaGhhcHdCR0VHUStlUmll?=
 =?utf-8?B?Q3hoSjlBVFdvQ3NkOHROT0pzZ3VtKzg2RVFnLzR5TmNJcksyN2xrZHlOT0Rx?=
 =?utf-8?B?amI4WnMyWW03S0xkSUk0Y1hnenFac3lTTnFYT2htUnRuanNGS2tsc20zWkZZ?=
 =?utf-8?B?TlpPRUJJdTd0NUo1MithVUdkUnJkRjZoS0VXbVlPMG1HTWJnSFBhVzZPTXl0?=
 =?utf-8?B?TnBwOWNPTjNCTkxjRDIwZ0Z2QUpYNEh2UjgzSTNZazZZRElpY0Y3WmVDSjc2?=
 =?utf-8?B?M1pOak5QQytyTWFuTWdkSWJDait0aHY3U3NwdDFNV09CeFFpYkE0cFgwc1NG?=
 =?utf-8?B?TGRrT2RVcFZ3SFNzajV5UnBkM0N3VGUxRGpkeXBzdWRaRkJCZGpBeTl0M1Jj?=
 =?utf-8?Q?pe6Fx9d76/Xvx0BA=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a78750-092c-435a-c7e4-08de745d9300
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB3893.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 11:03:58.3195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxV9ayTHnuivUPffLZufql+2d3erJClLla2l1HAM/5vUM6q/kd8OjNts2R1AdRQc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF387AEB7F3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDEwOCBTYWx0ZWRfX1G+q58rGrd+P
 hYAPVU6ivr1Gh7TY3Va8iBS+NS8fDalBz6vTqS3gcLaSGyT/M9jlyL6Tty7c8sVwdSa2pYHj3DI
 BhghUcyjDtdVazuFQP7z3pMDpKmLDtroqzKg85xpK+O5U26SE+rMKfI9KpvEFJlYKFhF53ze90Z
 g7U9fvhjEkXnSh5szTgpeUS5yZtVYs1ndenuvo1IKVtNFQa0XSqU3FI1BtQul6r0hvFgZVVKh18
 HuNDGcirByNW9EACIq5/H7xeZWSAkzAl5aTpgPZzSJja2V36Ui0XBjlLxEuSlF/n/X9mMBdaKdB
 XVNDTYEfsHWC8I+URII0DxqvcD6o5GsquhUtD+FzOpncXKoCw4vvinnk5gZSVB4QI1ZeUgHCENc
 U6KCquMneVOhQ+kWAwQta1THgynk5eAcjqsUd5HkWuQQvLDJkcaUIgROnODtxStTaDlvzJMjpLt
 1zvLv0RKLuSsKt+bQqw==
X-Proofpoint-GUID: W5QWG1ufX2o0C6K7NpRjUmVW07YwjEhD
X-Authority-Analysis: v=2.4 cv=eszSD4pX c=1 sm=1 tr=0 ts=699ed721 cx=c_pps
 a=LPv6HZ59J3TLgKTE/qPS5w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=9LP2aP-SZ2uCgCimRgQA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: W5QWG1ufX2o0C6K7NpRjUmVW07YwjEhD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260887-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:mid,meta.com:dkim,meta.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishs@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4D1E0196424
X-Rspamd-Action: no action

On 2/25/26 2:03 PM, Xuan Zhuo wrote:
> On Tue, 24 Feb 2026 20:49:10 -0800, Vishwanath Seshagiri <vishs@meta.com> wrote:
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
>> Resend for net-next window (no changes from v7).
>> - v7:
>>    https://lore.kernel.org/virtualization/20260210014305.3236342-1-vishs@meta.com/
>>
>> Changes in v7:
>> - Replace virtnet_put_page() helper with direct page_pool_put_page()
>>    calls (Xuan Zhuo)
>> - Add virtnet_no_page_pool() helper to consolidate big_packets mode check
>>    (Michael S. Tsirkin)
>> - Add DMA sync_for_cpu for subsequent buffers in xdp_linearize_page() when
>>    use_page_pool_dma is set (Michael S. Tsirkin)
>> - Remove unused pp_params.dev assignment in non-DMA path
>> - Add page pool recreation in virtnet_restore_up() for freeze/restore support (Chris Mason's
>> Review Prompt)
>> - v6:
>>    https://lore.kernel.org/virtualization/20260208175410.1910001-1-vishs@meta.com/
>>
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
>>   drivers/net/virtio_net.c | 467 ++++++++++++++++++++-------------------
>>   2 files changed, 243 insertions(+), 225 deletions(-)
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
>> index db88dcaefb20..32aede2b1ed5 100644
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
>> @@ -521,11 +513,14 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
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
>> +static void virtnet_del_vqs(struct virtnet_info *vi);
>>
>>   enum virtnet_xmit_type {
>>   	VIRTNET_XMIT_TYPE_SKB,
>> @@ -706,15 +701,18 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
>>   	return p;
>>   }
>>
>> +static bool virtnet_no_page_pool(struct virtnet_info *vi)
>> +{
> 
> Can we check vi->page_pool?
> 
> In virtnet_create_page_pools, we can check
> "vi->big_packets && !vi->mergeable_rx_bufs" directly.
> 
> Then other calls will be more efficient.

Ack. Will make this change.

> 
> 
>> +	return vi->big_packets && !vi->mergeable_rx_bufs;
>> +}
>> +
>>   static void virtnet_rq_free_buf(struct virtnet_info *vi,
>>   				struct receive_queue *rq, void *buf)
>>   {
>> -	if (vi->mergeable_rx_bufs)
>> -		put_page(virt_to_head_page(buf));
>> -	else if (vi->big_packets)
>> +	if (virtnet_no_page_pool(vi))
>>   		give_pages(rq, buf);
>>   	else
>> -		put_page(virt_to_head_page(buf));
>> +		page_pool_put_page(rq->page_pool, virt_to_head_page(buf), -1, false);
>>   }
>>
> 
> 
> [...]
> 
> 
>>
>>   err_buf:
>> @@ -2666,32 +2586,40 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
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
> 
> Maybe we should introduce a helper to do this, as the merge mode needs this
> too.

Ack. I will add a helper here.

> 
> 
> Thanks.


