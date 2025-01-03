Return-Path: <netdev+bounces-154931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE3FA0063C
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 09:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DA1D7A2060
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 08:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174BA1C5F2D;
	Fri,  3 Jan 2025 08:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="B0WrzmsT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8DE199938;
	Fri,  3 Jan 2025 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735894095; cv=fail; b=j7I44qn+5E0YWh+I/qoJbnd3hafcTDfd0w5rIiipyKPE+lx9nYfO9hLa9yVO/0bSEe4255fYrrSyD046N1jA/jYHXhZJhn+rZmGKGOrJduNMrJxtG7+OobBQzvbduK2Zacxq7uMm31I8jLaEfac4m/Esmg87ouLW3/OAU7zsKU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735894095; c=relaxed/simple;
	bh=8BgZX36dCXk81W3fW2vBHTj8QbgMhkOUqfAh8U53OY8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=nd8S29tAgnOchjtlo6ht4kZdy4fMzqIG40y9RiqC7v6Mb8yzH85X7fd4n7yO6xPyHtc2L5bC6y1OPye+JfqKd7elcrB4Um1zcV7Dl6fztNvFCanVT7bxeMKchdndYQzEwFxvm/zR1efRm0ErYJyJCzCS7BtAaqTT+gD1eazoonA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=B0WrzmsT reason="signature verification failed"; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5037Jg2u020127;
	Fri, 3 Jan 2025 00:47:19 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43xbd1g7kt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jan 2025 00:47:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGg3cyvHAxjY02meUah+W5lvSO9/bkpN5EWSTDxFHDGfYqqcHcYRyoWTsMuTCsF7BHfUpLGcjwLSlpDxbluRfuBVQm19qw1sebzfXaU1p+1qQUYoJzcgRslU9qmLQdQG+vrcMZP+wxVJUNOWMN8yvN91gqdKgDxJoxJjdPQ8Ogpj/b7r9yDStWwTcFjlGFEg+50gHQ/CXLoQy2KnmPsvedfHaqOnL5JAHHpoEqmDjCco0I8KDIvtRRVRTvD1BlgkF8qSgUoWxovmdsYs1yveAabrj4JAFygVprlQ+iz0tMMwxu3yhwc5Imy8lvuxWfrDqm0XW09f/WMiHuSPSkgj6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KA1WhvS2NjPocLrsrsAU1O87p0LlIZ14gY7rxM1LTVo=;
 b=SamY1/PVigZ5vTkjCeJ8c2gpwGJ/2/92FlHIxsYGxq67vCJbr0MmxulvaQikEHrFN5ChF5kiV2SE/d96NSuEjIY9eg7j553rMnfxyWsukfehlnIZSe+fLKrjX38W1TiNQ7e7mEikxNQi35OfsNvaIXQJk5reDPhkdWHTFIvIeK619JSnkAUCqBk6dVGl2+yt+f0ZDL6EUmHZ9EELzctAusw4I6UXtxxlG4RKizPCjJENeWkMoSexM4ApYo7HRQ0+2o9NhQ4HCiVqevTj7lBtOOzpJMyVR2wyg0w3O3VZactQOKc8FwylP3kQG6RSqSn6L3+kZnfLyi9aVtPE5AQl0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KA1WhvS2NjPocLrsrsAU1O87p0LlIZ14gY7rxM1LTVo=;
 b=B0WrzmsTbu1oHysEFVRor+c9nB9Z6yMYyh/wOJyiaAS8jwTCkraiIL5cGAIqJVnaz0gk+5SV3Gpr/SRHE1P5JgTajeforYkjSPN8jFlbtILaRJBafj5ryaZAVhihPD9Jhnbk7upOA0VPQm5hFIwDfZTOlyLYzaSV9q+nAckU8as=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by MW4PR18MB5183.namprd18.prod.outlook.com (2603:10b6:303:1b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Fri, 3 Jan
 2025 08:47:09 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1%5]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 08:47:09 +0000
From: Suman Ghosh <sumang@marvell.com>
To: Gur Stavi <gur.stavi@huawei.com>, gongfan <gongfan1@huawei.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet
	<corbet@lwn.net>, Bjorn Helgaas <helgaas@kernel.org>,
        Cai Huoqing
	<cai.huoqing@linux.dev>, Xin Guo <guoxin09@huawei.com>,
        Shen Chenyang
	<shenchenyang1@hisilicon.com>,
        Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
	<wulike1@huawei.com>,
        Shi Jing <shijing34@huawei.com>,
        Meny Yossefi
	<meny.yossefi@huawei.com>
Subject: RE: [EXTERNAL] [PATCH net-next v03 1/1] hinic3: module initialization
 and tx/rx logic
Thread-Topic: [EXTERNAL] [PATCH net-next v03 1/1] hinic3: module
 initialization and tx/rx logic
Thread-Index: AQHbXEv/S0WzAHyfMEeYpR/xN9ZcN7MDPdwg
Date: Fri, 3 Jan 2025 08:47:09 +0000
Message-ID:
 <SJ0PR18MB5216BED17023369322EE4A6ADB152@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <cover.1735735608.git.gur.stavi@huawei.com>
 <aa5947d298f46f984deb8bc04ea05f896f7f2ad6.1735735608.git.gur.stavi@huawei.com>
In-Reply-To:
 <aa5947d298f46f984deb8bc04ea05f896f7f2ad6.1735735608.git.gur.stavi@huawei.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|MW4PR18MB5183:EE_
x-ms-office365-filtering-correlation-id: 17b187d4-319b-4aa1-fc33-08dd2bd3357d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eXVnaG9CQUtVamFkWmI1eXhCV1pLK01FTnc5REk2QWpCcmhmam5HbzVJWXdw?=
 =?utf-8?B?cUdhcE9UNy9oL3RHMnlxRExUTDJnNHQrdVZaekhoRTBIdmxSTURwMGJycTlF?=
 =?utf-8?B?RzNwem4yZVZOVXpHRDJYejlsemxxdy8xejk3T2R2Qy9WSjB1NytUZktEUDdX?=
 =?utf-8?B?U3RKanlyNmh5dHdBWlR0Y2ZvYlViTEp6MTRwbS9lRWJhZHExcUxIZFl2Y2FW?=
 =?utf-8?B?M2tOUXN2Wk1aT0x3eXNnQUdSUXpkSFl5N1Q0Wms0bWJOcXRHU0syTFB4NE1R?=
 =?utf-8?B?ckRXR3NzWm1HZ1ROUEphWXhEa2o5TXhxTExkT0REc25FeTZaQ0FEWkZJMHVC?=
 =?utf-8?B?SXpwcTJ3dCtHTVJlaFk5ckpHcFBnYmtUVmJ1NGtSUzUrTXNuRmlyUm1WVnVG?=
 =?utf-8?B?bkhXaHVvZ2F5MEdReHBWREUwWlRwRGhOU2ttUktVeWJsUGNCMjFCMGd0UFRW?=
 =?utf-8?B?ZGZBZExkSVZzeUJPVXpncXY3TS8yb1J6VWZaTXloZTBUNFk4U0kvYm9MT2Jq?=
 =?utf-8?B?UW04NUhVbjFrbGR6ZG9kMDZBUWFBNHE3QUdka0poSWF4VDl2YUNVMjFnZVZ5?=
 =?utf-8?B?SmxCSFdWZTZIT05yejh6aDFvdmNJMk81bEpQcWRKOEZxWEFSOVBGQis0SDQ1?=
 =?utf-8?B?ekQwSzFVTWgzV3h2Nzg3a0U2ajQ0a0phbmtPYzBmRS9OL1M3aHAvdWN1YTVq?=
 =?utf-8?B?cUtQU05hd0RVZ0lQL09lVGEyaFVnK2x6YXFPUSsxZzR1ZVZUOHBqU0w4ZU41?=
 =?utf-8?B?RnhsUGRMUTYwQXlaT3VVemVoQnlSWlpGbG9EUzJhNFp6N1pYZS9GZ05CSXpG?=
 =?utf-8?B?MytJR1N3U3RvUDQxN1ZrTUdOcm1UbFFkKzVlSUt0Y2ZqMEczWGVzczI3VmVP?=
 =?utf-8?B?S2t3QklvZ3lzeWcxLzVmTHM1a3hTcWJuc1JYWXRLUjM3Q1R6ZEZZeVR0clZp?=
 =?utf-8?B?SXo1c2cxMllPS1Q4RkVMUkpNOEJ6M0YzSUhGQjMrZEFVME1GUFo2c2pvT0tQ?=
 =?utf-8?B?WHh3RmhHRlFvRi9MdTJwR29XQkwxQXpsWE1uejNyUnA2bEV1alB4VFNLa2Fo?=
 =?utf-8?B?K2FqYW1lQnVoZHZ5MFh1bDRNdXM0MmpTa1M4NzQvUW9WYkg0N01oZTh6TjQ4?=
 =?utf-8?B?TmdwZ1RDN1NjYmZGY2UwRXdaOUNsOEJOenZzRERrN2YvMW9OQ3ZCbzVlQVkw?=
 =?utf-8?B?bzJmU21mWXpaWHo4dy9lb0RLNStObGtmSldlMU9QaVlmcTdIN0NqZ1NVQWRa?=
 =?utf-8?B?cTJHT3Q1ckNyMzROSUpOanBlUXg3YWN2WDFtU2JSZFc0WTFLdHBXMFdIS1V4?=
 =?utf-8?B?WXl4VnNjREpVMTFCOFdFNHprb0hPVGFWM3VZdUh2WlJucXlGTEtHVjBIUzZM?=
 =?utf-8?B?cGFvbC8vN2JoZnFYSVBMM0dCRllBT2o2ZVhVTVlLSSs1N2ZmQmpiN01NWGc3?=
 =?utf-8?B?WlhQeWhTYUl4SFFMR1ZiWE1MNnJiMDk1TVB4R283b1Y0bjBUcnloMmduT0wz?=
 =?utf-8?B?M0FxM3BOcmRRVFExY2FrdlZWTUxOc2JFc1Z5akFQK0xUYTNXenBlMVNlVTdr?=
 =?utf-8?B?WjJ0YUN0d05uZXlCZ25BY0hjNzVZRWtzdWdVSHNtY2JqZWYrRUlRNmtpYnVk?=
 =?utf-8?B?dDBLQktRZmViaVM4c0VyMHg5T2xMUSswTFBNRHRVcklYSXpWTEN6aEhWL1or?=
 =?utf-8?B?VnIrZmw0aS81REpYWW5vbzBucWhucFgydlp1cUQvbENuM285TzN3OVphWFov?=
 =?utf-8?B?RmRXb1pLWjgzeXpwRm0wVmZvclAwMU1hTnpRY0dxaWI1dHU1ckJVeWplTFIz?=
 =?utf-8?B?SUIrcGlWZWNvQzhZNlNjaVhPWEErQVNkTVFpenlLMFJORk9xQ25WMTVmUmdt?=
 =?utf-8?B?VDB6T3FIaUxyeXZWOE5TOGgrVUF5K0JoMFFCMjBWUGM3R1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWtlaDlDdHplYWp4R296MnZyWlBJMXZwc1A1M3VIRXhpNGdkdG1ZQkcvYUV4?=
 =?utf-8?B?UjVVQWlXWlBzUTVMUDd6VW5rdEJPUk0yS1RPeWpNV0dGaGdvQ3dhTmVxamxN?=
 =?utf-8?B?c09kN2JKMnRHM2JjQ0hKMFVDQVFrUFQzd0FJaitSbWR2bGhDZDVQb29KWjFO?=
 =?utf-8?B?OWVTR0s5ZmFlb3MyS1Ryb1NiU21ibzR4OWlROEpSUnlTeVNzdldLV2JuenZJ?=
 =?utf-8?B?WXkvQm5Wd3R5ZHdCeG9JeE5BUWR3ZW55dzBCbWpla2JQOU15ZGZjUUlCYVhK?=
 =?utf-8?B?bTdEK0lTRlNsY2dUZWduTytvVm5wRSt2MlE4Q0J1dm1tRnZrOSsvOGswQXgz?=
 =?utf-8?B?cC9ONVJ6SUlYWHVqUzhCeXRVNFVuejNadDZZcERPMW9aazV5OFBuaFBiM3hQ?=
 =?utf-8?B?RnBFNnd3MjhyRzJTcW9TRzJPWUpLVStoS1dZL3NwTzRabFN2NHZ3VHRtZHZw?=
 =?utf-8?B?TkNwYmk1Ry8xbHZqbFQ4N3Q3d0crY2hESDhvbG9MWVRJRHpLVEhEUnhBYVNq?=
 =?utf-8?B?RGx3NFh2aXY3aENVbThwd1dsRm4xeDVycnlWRGYvNXE0ejZaZ3NsTWJJVW93?=
 =?utf-8?B?dWRra3JxRUc0MVh1YUFhaU53ZTl4czZSSERIdnMxR2xQd0c5MllyNzQ1VFNp?=
 =?utf-8?B?eTRtd1NTekFveXBqNzJnOXg5YmtVWGxpbVhuTEEyS3ZOY0tDcnYzdnhtb0Iy?=
 =?utf-8?B?a3JXYjJJbU9YRmJxM0Y5WGdrMVZTbkVCQnB1N3hDdExPekxySVBDczZMc3E5?=
 =?utf-8?B?cWJOVE9KTnBJMVgyZ0Q5dHpMOXh3UUlSUFlKT0QycUMycW8zclBJWDFpUGJE?=
 =?utf-8?B?eDQxcmp4TEdocG5uK2NaMWV5UEJpUURhRFN4MHR5YUV3bElOdzV0Q3l1VldM?=
 =?utf-8?B?M0VTajBvcFZqYUpDTkhpSWZZdnduczluWWl4bnZDdUwzbzNwVnN1Y3F0S1F3?=
 =?utf-8?B?R212RmZYcG1ZaWtTb3JvTDM0RzkwWThTN1ZXeUY5OFlxZ05SbUJLQ2czdUdU?=
 =?utf-8?B?MW5YeTZVbmM4YWUxQXk0bUh3UzBvM2hUT3JYQmY0MmNyNXpJWjRtMW9zZlB5?=
 =?utf-8?B?bW5JeXRyWXRtd0ZUUXBMVldOSGM0cW9tWlY2N213VUt1TUc4KzZpSmVDYWkz?=
 =?utf-8?B?SjRlTFRpMGpHbTBuUEs5aUJrcXpINk81VFQzN3JpWnFubEJHcE5DUEdHdUNM?=
 =?utf-8?B?MDNjejFCZmxKUUhjVjFLNU5La3ZZNnNBRzRncUkyM0xKMkxpR0FRS0NyOFpP?=
 =?utf-8?B?dXAxTG1TMFFUZW9oc1M1eWpJcmZtbzBKZ2Y4WWZKWG02a21XTFdrL3ROV1VW?=
 =?utf-8?B?Y3NnQndOcnJ1MzMrRWhOeE5VVm04elE0M1l0U3NlN0ZXS3RteDVBVXNIaDVR?=
 =?utf-8?B?RDd2R1NiSU1zM1cwdlpUcTI0NTd3VkhxMVBmZmZvYytLSm5qSWdObFE3OXBv?=
 =?utf-8?B?VktXbjF2SDBJaEkxSy9SUnJpbmd3L2dKMW90LzEvZWVFSmc2N3BMOGxpM2dI?=
 =?utf-8?B?cmRMVWUrclByU3MzZnV1MEpJWWZmczhiM05TSmNUVWE0RHBKNXVUYi9TcTV0?=
 =?utf-8?B?RGVSOEZoNkNYVkF2M205QkFrMVpWT0hFY1ZsN0pFS0VHS3dPM2FDWWR2Ni95?=
 =?utf-8?B?R2w3dHI5amFZcnJmVGdDaXI1MzF5Tmp2K3VlTUErTithRWJ4M3VldU5UOFNU?=
 =?utf-8?B?N21oTzIrbHY1LzRTWkYrdmZqNXJ6ei9rK1RhSmoycTM0bE4xTGpqejhLTTBZ?=
 =?utf-8?B?RTlSbmFsZVljb2dTS0Y2RWZ5cG52OXQ2WXZpSWt4Y0Y1dkE4eVpkeW9WSit3?=
 =?utf-8?B?V0dRd1ZrSzYxOXZmSzdTOUpNTmxVOE1lbWxEN05HQzNMbmZWN3F5WDg5UzJy?=
 =?utf-8?B?YzRXYzA3dFlKelRzdkpsVnZWbkZsdkpIcFhuUUpYbjJCN1dxWmUrSGdGaVJN?=
 =?utf-8?B?V3RBdXhsVm81dU90NWM4WmVvWmRsbVBlV2JtZnpLM1FMcE1VT255aHIvdld4?=
 =?utf-8?B?blpTcnJiNE03bWU3VE1jUkJWekh4NFlOMVQyVlhnU3gxZHpCNTJRV0NvUUxn?=
 =?utf-8?B?NnJib2tqRTJKSWVaWVd6cTFUeVhpMGhsS0cyU2thZGthWitYa2xxNmVNQjdl?=
 =?utf-8?Q?EMlAb0N4D5grYHzuqn8QLctXE?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5216.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b187d4-319b-4aa1-fc33-08dd2bd3357d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2025 08:47:09.1472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gY17gtKbRmu92SsLbS1nVDd62wgkw4vwx9zmjKc1B12Z14cPP3vM+R+FcELTtyYEFESQFP1SYtdhRNX8ZSzmKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR18MB5183
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: D7lxh2XCQCxtxFr-0RFAUDrv447_KZrp
X-Proofpoint-ORIG-GUID: D7lxh2XCQCxtxFr-0RFAUDrv447_KZrp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01



Regards,
Suman

>-----Original Message-----
>From: Gur Stavi <gur.stavi@huawei.com>
>Sent: Wednesday, January 1, 2025 6:35 PM
>To: Gur Stavi <gur.stavi@huawei.com>; gongfan <gongfan1@huawei.com>
>Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; David S.
>Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
>Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Simon
>Horman <horms@kernel.org>; Andrew Lunn <andrew+netdev@lunn.ch>; linux-
>doc@vger.kernel.org; Jonathan Corbet <corbet@lwn.net>; Bjorn Helgaas
><helgaas@kernel.org>; Cai Huoqing <cai.huoqing@linux.dev>; Xin Guo
><guoxin09@huawei.com>; Shen Chenyang <shenchenyang1@hisilicon.com>; Zhou
>Shuai <zhoushuai28@huawei.com>; Wu Like <wulike1@huawei.com>; Shi Jing
><shijing34@huawei.com>; Meny Yossefi <meny.yossefi@huawei.com>
>Subject: [EXTERNAL] [PATCH net-next v03 1/1] hinic3: module
>initialization and tx/rx logic
>
>From: gongfan <gongfan1@=E2=80=8Ahuawei.=E2=80=8Acom> This is [1/3] part o=
f hinic3
>Ethernet driver initial submission. With this patch hinic3 is a valid
>kernel module but non-functional driver. The driver parts contained in
>this patch: Module initialization.=E2=80=8A
>
>From: gongfan <gongfan1@huawei.com>
>
>This is [1/3] part of hinic3 Ethernet driver initial submission.
>With this patch hinic3 is a valid kernel module but non-functional
>driver.
>
>The driver parts contained in this patch:
>Module initialization.
>PCI driver registration but with empty id_table.
>Auxiliary driver registration.
>Net device_ops registration but open/stop are empty stubs.
>tx/rx logic.
>
>All major data structures of the driver are fully introduced with the
>code that uses them but without their initialization code that requires
>management interface with the hw.
>
>Submitted-by: Gur Stavi <gur.stavi@huawei.com>
>Signed-off-by: Gur Stavi <gur.stavi@huawei.com>
>Signed-off-by: Xin Guo <guoxin09@huawei.com>
>Signed-off-by: gongfan <gongfan1@huawei.com>
>---
> .../device_drivers/ethernet/huawei/hinic3.rst | 137 ++++
> MAINTAINERS                                   |   7 +
> drivers/net/ethernet/huawei/Kconfig           |   1 +
> drivers/net/ethernet/huawei/Makefile          |   1 +
> drivers/net/ethernet/huawei/hinic3/Kconfig    |  18 +
> drivers/net/ethernet/huawei/hinic3/Makefile   |  21 +
> .../ethernet/huawei/hinic3/hinic3_common.c    |  53 ++
> .../ethernet/huawei/hinic3/hinic3_common.h    |  27 +
> .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    |  30 +
> .../ethernet/huawei/hinic3/hinic3_hw_cfg.h    |  58 ++
> .../ethernet/huawei/hinic3/hinic3_hw_comm.c   |  37 +
> .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |  13 +
> .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  85 +++
> .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |  24 +
> .../net/ethernet/huawei/hinic3/hinic3_hwdev.h |  82 +++
> .../net/ethernet/huawei/hinic3/hinic3_hwif.c  |  15 +
> .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |  50 ++
> .../net/ethernet/huawei/hinic3/hinic3_lld.c   | 410 +++++++++++
> .../net/ethernet/huawei/hinic3/hinic3_lld.h   |  20 +
> .../net/ethernet/huawei/hinic3/hinic3_main.c  | 421 +++++++++++
> .../net/ethernet/huawei/hinic3/hinic3_mbox.c  |  17 +
> .../net/ethernet/huawei/hinic3/hinic3_mbox.h  |  16 +
> .../net/ethernet/huawei/hinic3/hinic3_mgmt.h  |  13 +
> .../huawei/hinic3/hinic3_mgmt_interface.h     | 111 +++
> .../huawei/hinic3/hinic3_netdev_ops.c         |  77 ++
> .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   | 254 +++++++
> .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  45 ++
> .../ethernet/huawei/hinic3/hinic3_nic_dev.h   | 100 +++
> .../ethernet/huawei/hinic3/hinic3_nic_io.c    |  21 +
> .../ethernet/huawei/hinic3/hinic3_nic_io.h    | 117 +++
> .../huawei/hinic3/hinic3_queue_common.c       |  65 ++
> .../huawei/hinic3/hinic3_queue_common.h       |  51 ++
> .../net/ethernet/huawei/hinic3/hinic3_rss.c   |  24 +
> .../net/ethernet/huawei/hinic3/hinic3_rss.h   |  12 +
> .../net/ethernet/huawei/hinic3/hinic3_rx.c    | 401 ++++++++++
> .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  91 +++
> .../net/ethernet/huawei/hinic3/hinic3_tx.c    | 692 ++++++++++++++++++
> .../net/ethernet/huawei/hinic3/hinic3_tx.h    | 129 ++++
> .../net/ethernet/huawei/hinic3/hinic3_wq.c    |  29 +
> .../net/ethernet/huawei/hinic3/hinic3_wq.h    |  75 ++
> 40 files changed, 3850 insertions(+)
>
>diff --git
>a/Documentation/networking/device_drivers/ethernet/huawei/hinic3.rst
>b/Documentation/networking/device_drivers/ethernet/huawei/hinic3.rst
>new file mode 100644
>index 000000000000..fe4bd0aed85c
>--- /dev/null
>+++ b/Documentation/networking/device_drivers/ethernet/huawei/hinic3.rst
>@@ -0,0 +1,137 @@
>+.. SPDX-License-Identifier: GPL-2.0
>+
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+Linux kernel driver for Huawei Ethernet Device Driver (hinic3) family
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+
>+Overview
>+=3D=3D=3D=3D=3D=3D=3D=3D
>+
>+The hinic3 is a network interface card (NIC) for Data Center. It
>supports
>+a range of link-speed devices (10GE, 25GE, 100GE, etc.). The hinic3
>+devices can have multiple physical forms (LOM NIC, PCIe standard NIC,
>+OCP NIC etc.).
>+
>+The hinic3 driver supports the following features:
>+- IPv4/IPv6 TCP/UDP checksum offload
>+- TSO (TCP Segmentation Offload), LRO (Large Receive Offload)
>+- RSS (Receive Side Scaling)
>+- MSI-X interrupt aggregation configuration and interrupt adaptation.
>+- SR-IOV (Single Root I/O Virtualization).
>+
>+Content
>+=3D=3D=3D=3D=3D=3D=3D
>+
>+- Supported PCI vendor ID/device IDs
>+- Source Code Structure of Hinic3 Driver
>+- Management Interface
>+
>+Supported PCI vendor ID/device IDs
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+
>+19e5:0222 - hinic3 PF/PPF
>+19e5:375F - hinic3 VF
>+
>+Prime Physical Function (PPF) is responsible for the management of the
>+whole NIC card. For example, clock synchronization between the NIC and
>+the host. Any PF may serve as a PPF. The PPF is selected dynamically.
>+
>+Source Code Structure of Hinic3 Driver
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+hinic3_pci_id_tbl.h       Supported device IDs
>+hinic3_hw_intf.h          Interface between HW and driver
>+hinic3_queue_common.[ch]  Common structures and methods for NIC queues
>+hinic3_common.[ch]        Encapsulation of memory operations in Linux
>+hinic3_csr.h              Register definitions in the BAR
>+hinic3_hwif.[ch]          Interface for BAR
>+hinic3_eqs.[ch]           Interface for AEQs and CEQs
>+hinic3_mbox.[ch]          Interface for mailbox
>+hinic3_mgmt.[ch]          Management interface based on mailbox and AEQ
>+hinic3_wq.[ch]            Work queue data structures and interface
>+hinic3_cmdq.[ch]          Command queue is used to post command to HW
>+hinic3_hwdev.[ch]         HW structures and methods abstractions
>+hinic3_lld.[ch]           Auxiliary driver adaptation layer
>+hinic3_hw_comm.[ch]       Interface for common HW operations
>+hinic3_mgmt_interface.h   Interface between firmware and driver
>+hinic3_hw_cfg.[ch]        Interface for HW configuration
>+hinic3_irq.c              Interrupt request
>+hinic3_netdev_ops.c       Operations registered to Linux kernel stack
>+hinic3_nic_dev.h          NIC structures and methods abstractions
>+hinic3_main.c             Main Linux kernel driver
>+hinic3_nic_cfg.[ch]       NIC service configuration
>+hinic3_nic_io.[ch]        Management plane interface for TX and RX
>+hinic3_rss.[ch]           Interface for Receive Side Scaling (RSS)
>+hinic3_rx.[ch]            Interface for transmit
>+hinic3_tx.[ch]            Interface for receive
>+hinic3_ethtool.c          Interface for ethtool operations (ops)
>+hinic3_filter.c           Interface for MAC address
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+
>+Management Interface
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+
>+Asynchronous Event Queue (AEQ)
>+------------------------------
>+
>+AEQ receives high priority events from the HW over a descriptor queue.
>+Every descriptor is a fixed size of 64 bytes. AEQ can receive solicited
>or
>+unsolicited events. Every device, VF or PF, can have up to 4 AEQs.
>+Every AEQ is associated to a dedicated IRQ. AEQ can receive multiple
>types
>+of events, but in practice the hinic3 driver ignores all events except
>for
>+2 mailbox related events.
>+
>+Mailbox
>+-------
>+
>+Mailbox is a communication mechanism between the hinic3 driver and the
>HW.
>+Each device has an independent mailbox. Driver can use the mailbox to
>send
>+requests to management. Driver receives mailbox messages, such as
>responses
>+to requests, over the AEQ (using event HINIC3_AEQ_FOR_MBOX). Due to the
>+limited size of mailbox data register, mailbox messages are sent
>+segment-by-segment.
>+
>+Every device can use its mailbox to post request to firmware. The
>mailbox
>+can also be used to post requests and responses between the PF and its
>VFs.
>+
>+Completion Event Queue (CEQ)
>+--------------------------
>+
>+The implementation of CEQ is the same as AEQ. It receives completion
>events
>+from HW over a fixed size descriptor of 32 bits. Every device can have
>up
>+to 32 CEQs. Every CEQ has a dedicated IRQ. CEQ only receives solicited
>+events that are responses to requests from the driver. CEQ can receive
>+multiple types of events, but in practice the hinic3 driver ignores all
>+events except for HINIC3_CMDQ that represents completion of previously
>+posted commands on a cmdq.
>+
>+Command Queue (cmdq)
>+--------------------
>+
>+Every cmdq has a dedicated work queue on which commands are posted.
>+Commands on the work queue are fixed size descriptor of size 64 bytes.
>+Completion of a command will be indicated using ctrl bits in the
>+descriptor that carried the command. Notification of command
>completions
>+will also be provided via event on CEQ. Every device has 4 command
>queues
>+that are initialized as a set (called cmdqs), each with its own type.
>+Hinic3 driver only uses type HINIC3_CMDQ_SYNC.
>+
>+Work Queues(WQ)
>+---------------
>+
>+Work queues are logical arrays of fixed size WQEs. The array may be
>spread
>+over multiple non-contiguous pages using indirection table. Work queues
>are
>+used by I/O queues and command queues.
>+
>+Global function ID
>+------------------
>+
>+Every function, PF or VF, has a unique ordinal identification within
>the device.
>+Many commands to management (mbox or cmdq) contain this ID so HW can
>apply the
>+command effect to the right function.
>+
>+PF is allowed to post management commands to a subordinate VF by
>specifying the
>+VFs ID. A VF must provide its own ID. Anti-spoofing in the HW will
>cause
>+command from a VF to fail if it contains the wrong ID.
>+
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 1579124ef426..78819812093a 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -10602,6 +10602,13 @@ S:	Maintained
> F:	Documentation/networking/device_drivers/ethernet/huawei/hinic.rst
> F:	drivers/net/ethernet/huawei/hinic/
>
>+HUAWEI 3RD GEN ETHERNET DRIVER
>+M:	gongfan <gongfan1@huawei.com>
>+L:	netdev@vger.kernel.org
>+S:	Supported
>+F:	Documentation/networking/device_drivers/ethernet/huawei/hinic3.rst
>+F:	drivers/net/ethernet/huawei/hinic3/
>+
> HUGETLB SUBSYSTEM
> M:	Muchun Song <muchun.song@linux.dev>
> L:	linux-mm@kvack.org
>diff --git a/drivers/net/ethernet/huawei/Kconfig
>b/drivers/net/ethernet/huawei/Kconfig
>index c05fce15eb51..7d0feb1da158 100644
>--- a/drivers/net/ethernet/huawei/Kconfig
>+++ b/drivers/net/ethernet/huawei/Kconfig
>@@ -16,5 +16,6 @@ config NET_VENDOR_HUAWEI
> if NET_VENDOR_HUAWEI
>
> source "drivers/net/ethernet/huawei/hinic/Kconfig"
>+source "drivers/net/ethernet/huawei/hinic3/Kconfig"
>
> endif # NET_VENDOR_HUAWEI
>diff --git a/drivers/net/ethernet/huawei/Makefile
>b/drivers/net/ethernet/huawei/Makefile
>index 2549ad5afe6d..59865b882879 100644
>--- a/drivers/net/ethernet/huawei/Makefile
>+++ b/drivers/net/ethernet/huawei/Makefile
>@@ -4,3 +4,4 @@
> #
>
> obj-$(CONFIG_HINIC) +=3D hinic/
>+obj-$(CONFIG_HINIC3) +=3D hinic3/
>diff --git a/drivers/net/ethernet/huawei/hinic3/Kconfig
>b/drivers/net/ethernet/huawei/hinic3/Kconfig
>new file mode 100644
>index 000000000000..274d161a6765
>--- /dev/null
>+++ b/drivers/net/ethernet/huawei/hinic3/Kconfig
>@@ -0,0 +1,18 @@
>+# SPDX-License-Identifier: GPL-2.0-only
>+#
>+# Huawei driver configuration
>+#
>+
>+config HINIC3
>+	tristate "Huawei Intelligent Network Interface Card 3rd"
>+	# Fields of HW and management structures are little endian and are
>+	# currently not converted
>+	depends on !CPU_BIG_ENDIAN
>+	depends on X86 || ARM64 || COMPILE_TEST
>+	depends on PCI_MSI && 64BIT
>+	select AUXILIARY_BUS
>+	help
>+	  This driver supports HiNIC PCIE Ethernet cards.
>+	  To compile this driver as part of the kernel, choose Y here.
>+	  If unsure, choose N.
>+	  The default is N.
>diff --git a/drivers/net/ethernet/huawei/hinic3/Makefile
>b/drivers/net/ethernet/huawei/hinic3/Makefile
>new file mode 100644
>index 000000000000..02656853f629
>--- /dev/null
>+++ b/drivers/net/ethernet/huawei/hinic3/Makefile
>@@ -0,0 +1,21 @@
>+# SPDX-License-Identifier: GPL-2.0
>+# Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights
>reserved.
>+
>+obj-$(CONFIG_HINIC3) +=3D hinic3.o
>+
>+hinic3-objs :=3D hinic3_hwdev.o \
>+	       hinic3_lld.o \
>+	       hinic3_common.o \
>+	       hinic3_hwif.o \
>+	       hinic3_hw_cfg.o \
>+	       hinic3_queue_common.o \
>+	       hinic3_mbox.o \
>+	       hinic3_hw_comm.o \
>+	       hinic3_wq.o \
>+	       hinic3_nic_io.o \
>+	       hinic3_nic_cfg.o \
>+	       hinic3_tx.o \
>+	       hinic3_rx.o \
>+	       hinic3_netdev_ops.o \
>+	       hinic3_rss.o \
>+	       hinic3_main.o
>diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_common.c
>b/drivers/net/ethernet/huawei/hinic3/hinic3_common.c
>new file mode 100644
>index 000000000000..d416a6a00a8b
>--- /dev/null
>+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_common.c
>@@ -0,0 +1,53 @@
>+// SPDX-License-Identifier: GPL-2.0
>+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights
>reserved.
>+
>+#include <linux/dma-mapping.h>
>+#include <linux/delay.h>
>+
>+#include "hinic3_common.h"
>+
>+int hinic3_dma_zalloc_coherent_align(struct device *dev, u32 size, u32
>align,
>+				     gfp_t flag,
>+				     struct hinic3_dma_addr_align *mem_align)
>+{
>+	dma_addr_t paddr, align_paddr;
>+	void *vaddr, *align_vaddr;
>+	u32 real_size =3D size;
>+
>+	vaddr =3D dma_alloc_coherent(dev, real_size, &paddr, flag);
>+	if (!vaddr)
>+		return -ENOMEM;
>+
>+	align_paddr =3D ALIGN(paddr, align);
>+	if (align_paddr =3D=3D paddr) {
>+		align_vaddr =3D vaddr;
>+		goto out;
>+	}
>+
>+	dma_free_coherent(dev, real_size, vaddr, paddr);
>+
>+	/* realloc memory for align */
>+	real_size =3D size + align;
>+	vaddr =3D dma_alloc_coherent(dev, real_size, &paddr, flag);
>+	if (!vaddr)
>+		return -ENOMEM;
>+
>+	align_paddr =3D ALIGN(paddr, align);
>+	align_vaddr =3D vaddr + (align_paddr - paddr);
>+
>+out:
>+	mem_align->real_size =3D real_size;
>+	mem_align->ori_vaddr =3D vaddr;
>+	mem_align->ori_paddr =3D paddr;
>+	mem_align->align_vaddr =3D align_vaddr;
>+	mem_align->align_paddr =3D align_paddr;
>+
>+	return 0;
>+}
>+
>+void hinic3_dma_free_coherent_align(struct device *dev,
>+				    struct hinic3_dma_addr_align *mem_align)
>+{
>+	dma_free_coherent(dev, mem_align->real_size,
>+			  mem_align->ori_vaddr, mem_align->ori_paddr);
>+}
>diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
>b/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
>new file mode 100644
>index 000000000000..f8ff768c20ca
>--- /dev/null
>+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
>@@ -0,0 +1,27 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights
>reserved. */
>+
>+#ifndef HINIC3_COMMON_H
>+#define HINIC3_COMMON_H
>+
>+#include <linux/device.h>
>+
>+#define HINIC3_MIN_PAGE_SIZE  0x1000
>+
>+struct hinic3_dma_addr_align {
>+	u32        real_size;
>+
>+	void       *ori_vaddr;
>+	dma_addr_t ori_paddr;
>+
>+	void       *align_vaddr;
>+	dma_addr_t align_paddr;
>+};
>+
>+int hinic3_dma_zalloc_coherent_align(struct device *dev, u32 size, u32
>align,
>+				     gfp_t flag,
>+				     struct hinic3_dma_addr_align *mem_align);
>+void hinic3_dma_free_coherent_align(struct device *dev,
>+				    struct hinic3_dma_addr_align *mem_align);
>+
>+#endif
>diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
>b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
>new file mode 100644
>index 000000000000..be1bc3f47c08
>--- /dev/null
>+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
>@@ -0,0 +1,30 @@
>+// SPDX-License-Identifier: GPL-2.0
>+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights
>reserved.
>+
>+#include <linux/device.h>
>+
>+#include "hinic3_hw_cfg.h"
>+#include "hinic3_hwdev.h"
>+#include "hinic3_mbox.h"
>+#include "hinic3_hwif.h"
>+
>+#define IS_NIC_TYPE(hwdev) \
>+	(((u32)(hwdev)->cfg_mgmt->svc_cap.chip_svc_type) &
>BIT(SERVICE_T_NIC))
>+
>+bool hinic3_support_nic(struct hinic3_hwdev *hwdev)
>+{
>+	if (!IS_NIC_TYPE(hwdev))
>+		return false;
>+
>+	return true;
>+}
>+
>+u16 hinic3_func_max_qnum(struct hinic3_hwdev *hwdev)
>+{
>+	return hwdev->cfg_mgmt->svc_cap.nic_cap.max_sqs;
>+}
>+
>+u8 hinic3_physical_port_id(struct hinic3_hwdev *hwdev)
>+{
>+	return hwdev->cfg_mgmt->svc_cap.port_id;
>+}
>diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
>b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
>new file mode 100644
>index 000000000000..cef311b8f642
>--- /dev/null
>+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
>@@ -0,0 +1,58 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights
>reserved. */
>+
>+#ifndef HINIC3_HW_CFG_H
>+#define HINIC3_HW_CFG_H
>+
>+#include <linux/mutex.h>
>+
>+struct hinic3_hwdev;
>+
>+struct irq_info {
>+	u16 msix_entry_idx;
>+	/* provided by OS */
>+	u32 irq_id;
>+};
>+
>+struct cfg_irq_alloc_info {
>+	bool                     allocated;
>+	struct irq_info          info;
>+};
>+
>+struct cfg_irq_info {
>+	struct cfg_irq_alloc_info *alloc_info;
>+	u16                       num_irq;
>+	/* device max irq number */
>+	u16                       num_irq_hw;
>+	/* protect irq alloc and free */
>+	struct mutex              irq_mutex;
>+};
>+
>+struct nic_service_cap {
>+	u16 max_sqs;
>+};
>+
>+/* device capability */
>+struct service_cap {
>+	/* HW supported service type, reference to service_bit_define */
>+	u16                    chip_svc_type;
>+	/* physical port */
>+	u8                     port_id;
>+	/* NIC capability */
>+	struct nic_service_cap nic_cap;
>+};
>+
>+struct cfg_mgmt_info {
>+	struct cfg_irq_info irq_info;
>+	struct service_cap  svc_cap;
>+};
>+
>+int hinic3_alloc_irqs(struct hinic3_hwdev *hwdev, u16 num,
>+		      struct irq_info *alloc_arr, u16 *act_num);
>+void hinic3_free_irq(struct hinic3_hwdev *hwdev, u32 irq_id);
>+
>+bool hinic3_support_nic(struct hinic3_hwdev *hwdev);
>+u16 hinic3_func_max_qnum(struct hinic3_hwdev *hwdev);
>+u8 hinic3_physical_port_id(struct hinic3_hwdev *hwdev);
>+
>+#endif
>diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
>b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
>new file mode 100644
>index 000000000000..fc2efcfd22a1
>--- /dev/null
>+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
>@@ -0,0 +1,37 @@
>+// SPDX-License-Identifier: GPL-2.0
>+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights
>reserved.
>+
>+#include <linux/delay.h>
>+
>+#include "hinic3_hw_comm.h"
>+#include "hinic3_hwdev.h"
>+#include "hinic3_mbox.h"
>+#include "hinic3_hwif.h"
>+
>+static int comm_msg_to_mgmt_sync(struct hinic3_hwdev *hwdev, u16 cmd,
>const void *buf_in,
>+				 u32 in_size, void *buf_out, u32 *out_size)
>+{
>+	return hinic3_send_mbox_to_mgmt(hwdev, HINIC3_MOD_COMM, cmd,
>buf_in,
>+					in_size, buf_out, out_size, 0);
>+}
[Suman] Any reason we need this wrapper? We can directly call hinic3_send_m=
box_to_mgmt() from hinic3_func_reset()
>+
>+int hinic3_func_reset(struct hinic3_hwdev *hwdev, u16 func_id, u64
>reset_flag)
>+{
>+	struct comm_cmd_func_reset func_reset;
>+	u32 out_size =3D sizeof(func_reset);
>+	int err;
>+
>+	memset(&func_reset, 0, sizeof(func_reset));
>+	func_reset.func_id =3D func_id;
>+	func_reset.reset_flag =3D reset_flag;
>+	err =3D comm_msg_to_mgmt_sync(hwdev, COMM_MGMT_CMD_FUNC_RESET,
>+				    &func_reset, sizeof(func_reset),
>+				    &func_reset, &out_size);
>+	if (err || !out_size || func_reset.head.status) {
>+		dev_err(hwdev->dev, "Failed to reset func resources,
>reset_flag 0x%llx, err: %d, status: 0x%x, out_size: 0x%x\n",
>+			reset_flag, err, func_reset.head.status, out_size);
>+		return -EIO;
>+	}
>+
>+	return 0;
>+}
>diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
>b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
>new file mode 100644
>index 000000000000..cb60d7d7826d
>--- /dev/null
>+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
>@@ -0,0 +1,13 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights
>reserved. */
>+
>+#ifndef HINIC3_HW_COMM_H
>+#define HINIC3_HW_COMM_H
>+
>+#include "hinic3_hw_intf.h"
>+
>+struct hinic3_hwdev;
>+
>+int hinic3_func_reset(struct hinic3_hwdev *hwdev, u16 func_id, u64
>reset_flag);
>+
>+#endif
>diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
>b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
>new file mode 100644
>index 000000000000..5c2f8383bcbb
>--- /dev/null
>+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
>@@ -0,0 +1,85 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights
>reserved. */
>+
>+#ifndef HINIC3_HW_INTF_H
>+#define HINIC3_HW_INTF_H
>+
>+#include <linux/types.h>
>+#include <linux/bits.h>
>+
>+#define MGMT_CMD_UNSUPPORTED  0xFF
>+
>+struct mgmt_msg_head {
[Suman] Any reason you are not maintaining hinic3_* prefix here?
>+	u8 status;
>+	u8 version;
>+	u8 rsvd0[6];
>+};
>+
>+enum hinic3_service_type {
>+	SERVICE_T_NIC =3D 0,
>+	SERVICE_T_MAX =3D 1,
>+	/* Only used for interruption resource management, mark the request
>module */
>+	SERVICE_T_INTF =3D (1 << 15),
[Suman] any reason to define a type after _MAX? Does _MAX has some other co=
nnotation? Also, one generic comment would be to use symmetrical naming con=
vention like HINIC3_SERVICE_T_NIC or something like that.
>+};
>+
>+/* CMDQ MODULE_TYPE */
>+enum hinic3_mod_type {
>+	/* HW communication module */
>+	HINIC3_MOD_COMM   =3D 0,
>+	/* L2NIC module */
>+	HINIC3_MOD_L2NIC  =3D 1,
>+	/* Configuration module */
>+	HINIC3_MOD_CFGM   =3D 7,
>+	HINIC3_MOD_HILINK =3D 14,
>+};
>+
>+/* COMM Commands between Driver to fw */
>+enum hinic3_mgmt_cmd {
>+	/* Commands for clearing FLR and resources */
>+	COMM_MGMT_CMD_FUNC_RESET              =3D 0,
>+	COMM_MGMT_CMD_FEATURE_NEGO            =3D 1,
>+	COMM_MGMT_CMD_FLUSH_DOORBELL          =3D 2,
>+	COMM_MGMT_CMD_START_FLUSH             =3D 3,
>+	COMM_MGMT_CMD_GET_GLOBAL_ATTR         =3D 5,
>+	COMM_MGMT_CMD_SET_FUNC_SVC_USED_STATE =3D 7,
>+
>+	/* Driver Configuration Commands */
>+	COMM_MGMT_CMD_SET_CMDQ_CTXT           =3D 20,
>+	COMM_MGMT_CMD_SET_VAT                 =3D 21,
>+	COMM_MGMT_CMD_CFG_PAGESIZE            =3D 22,
>+	COMM_MGMT_CMD_CFG_MSIX_CTRL_REG       =3D 23,
>+	COMM_MGMT_CMD_SET_CEQ_CTRL_REG        =3D 24,
>+	COMM_MGMT_CMD_SET_DMA_ATTR            =3D 25,
>+};
>+
>+enum func_reset_type_bits {
>+	RESET_TYPE_FLUSH        =3D BIT(0),
>+	RESET_TYPE_MQM          =3D BIT(1),
>+	RESET_TYPE_SMF          =3D BIT(2),
>+	RESET_TYPE_PF_BW_CFG    =3D BIT(3),
>+
>+	RESET_TYPE_COMM         =3D BIT(10),
>+	/* clear mbox and aeq, The RESET_TYPE_COMM bit must be set */
>+	RESET_TYPE_COMM_MGMT_CH =3D BIT(11),
>+	/* clear cmdq and ceq, The RESET_TYPE_COMM bit must be set */
>+	RESET_TYPE_COMM_CMD_CH  =3D BIT(12),
>+	RESET_TYPE_NIC          =3D BIT(13),
>+};
>+
>+struct comm_cmd_func_reset {
>+	struct mgmt_msg_head head;
>+	u16                  func_id;
>+	u16                  rsvd1[3];
>+	u64                  reset_flag;
>+};
>+
>+#define COMM_MAX_FEATURE_QWORD  4
>+struct comm_cmd_feature_nego {
[Suman] Same as above about maintaining hinic3_ prefix
>+	struct mgmt_msg_head head;
>+	u16                  func_id;
>+	u8                   opcode;
>+	u8                   rsvd;
>+	u64                  s_feature[COMM_MAX_FEATURE_QWORD];
>+};
>+
>+#endif
>diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
>b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
>new file mode 100644
>index 000000000000..014fe4eeed5c
>--- /dev/null
>+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
>@@ -0,0 +1,24 @@
>+// SPDX-License-Identifier: GPL-2.0
>+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights
>reserved.
>+
>+#include "hinic3_hwdev.h"
>+#include "hinic3_mbox.h"
>+#include "hinic3_mgmt.h"
>+#include "hinic3_hw_comm.h"
>+#include "hinic3_hwif.h"
>+
>+int hinic3_init_hwdev(struct pci_dev *pdev)
>+{
>+	/* Completed by later submission due to LoC limit. */
>+	return -EFAULT;
>+}
>+
>+void hinic3_free_hwdev(struct hinic3_hwdev *hwdev)
>+{
>+	/* Completed by later submission due to LoC limit. */
>+}
>+
>+void hinic3_set_api_stop(struct hinic3_hwdev *hwdev)
>+{
>+	/* Completed by later submission due to LoC limit. */
>+}
>diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
>b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
>new file mode 100644
>index 000000000000..a1b094785d45
>--- /dev/null
>+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
>@@ -0,0 +1,82 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights
>reserved. */
>+
>+#ifndef HINIC3_HWDEV_H
>+#define HINIC3_HWDEV_H
>+
>+#include <linux/pci.h>
>+#include <linux/auxiliary_bus.h>
>+
>+#include "hinic3_hw_intf.h"
>+
>+struct hinic3_cmdqs;
>+struct hinic3_hwif;
>+
>+enum hinic3_event_service_type {
>+	EVENT_SRV_COMM =3D 0,
>+#define SERVICE_EVENT_BASE    (EVENT_SRV_COMM + 1)
>+	EVENT_SRV_NIC  =3D SERVICE_EVENT_BASE + SERVICE_T_NIC,
>+};
>+
>+#define HINIC3_SRV_EVENT_TYPE(svc, type)    ((((u32)(svc)) << 16) |
>(type))
>+
>+/* driver-specific data of pci_dev */
>+struct hinic3_pcidev {
>+	struct pci_dev       *pdev;
>+	struct hinic3_hwdev  *hwdev;
>+	/* Auxiliary devices */
>+	struct hinic3_adev   *hadev[SERVICE_T_MAX];
>+
>+	void __iomem         *cfg_reg_base;
>+	void __iomem         *intr_reg_base;
>+	void __iomem         *db_base;
>+	u64                  db_dwqe_len;
>+	u64                  db_base_phy;
>+
>+	/* lock for attach/detach uld */
>+	struct mutex         pdev_mutex;
>+	unsigned long        state;
>+};
>+
>+struct hinic3_hwdev {
>+	struct hinic3_pcidev           *adapter;
>+	struct pci_dev                 *pdev;
>+	struct device                  *dev;
>+	int                            dev_id;
>+	struct hinic3_hwif             *hwif;
>+	struct cfg_mgmt_info           *cfg_mgmt;
>+	struct hinic3_aeqs             *aeqs;
>+	struct hinic3_ceqs             *ceqs;
>+	struct hinic3_mbox             *mbox;
>+	struct hinic3_cmdqs            *cmdqs;
>+	struct workqueue_struct        *workq;
>+	/* protect channel init and deinit */
>+	spinlock_t                     channel_lock;
>+	u64                            features[COMM_MAX_FEATURE_QWORD];
>+	u32                            wq_page_size;
>+	u8                             max_cmdq;
>+	ulong                          func_state;
>+};
>+
>+struct hinic3_event_info {
>+	/* enum hinic3_event_service_type */
>+	u16 service;
>+	u16 type;
>+	u8  event_data[104];
>+};
>+
>+struct hinic3_adev {
>+	struct auxiliary_device  adev;
>+	struct hinic3_hwdev      *hwdev;
>+	enum hinic3_service_type svc_type;
>+
>+	void (*event)(struct auxiliary_device *adev,
>+		      struct hinic3_event_info *event);
>+};
>+
>+int hinic3_init_hwdev(struct pci_dev *pdev);
>+void hinic3_free_hwdev(struct hinic3_hwdev *hwdev);
>+
>+void hinic3_set_api_stop(struct hinic3_hwdev *hwdev);
>+
>+#endif
>diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
>b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
>new file mode 100644
>index 000000000000..4e12670a9440
>--- /dev/null
>+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
>@@ -0,0 +1,15 @@
>+// SPDX-License-Identifier: GPL-2.0
>+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights
>reserved.
>+
>+#include <linux/device.h>
>+#include <linux/io.h>
>+#include <linux/bitfield.h>
>+
>+#include "hinic3_hwdev.h"
>+#include "hinic3_common.h"
>+#include "hinic3_hwif.h"
>+
>+u16 hinic3_global_func_id(struct hinic3_hwdev *hwdev)
>+{
>+	return hwdev->hwif->attr.func_global_idx;
>+}
>diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
>b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
>new file mode 100644
>index 000000000000..da502c4b6efb
>--- /dev/null
>+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
>@@ -0,0 +1,50 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights
>reserved. */
>+
>+#ifndef HINIC3_HWIF_H
>+#define HINIC3_HWIF_H
>+
>+#include <linux/spinlock_types.h>
>+#include <linux/build_bug.h>
>+
>+struct hinic3_hwdev;
>+
>+enum func_type {
>+	TYPE_VF =3D 1,
>+};
>+
>+struct hinic3_db_area {
>+	unsigned long *db_bitmap_array;
>+	u32           db_max_areas;
>+	/* protect doorbell area alloc and free */
>+	spinlock_t    idx_lock;
>+};
>+
>+struct hinic3_func_attr {
>+	enum func_type func_type;
>+	u16            func_global_idx;
>+	u16            global_vf_id_of_pf;
>+	u16            num_irqs;
>+	u16            num_sq;
>+	u8             port_to_port_idx;
>+	u8             pci_intf_idx;
>+	u8             ppf_idx;
>+	u8             num_aeqs;
>+	u8             num_ceqs;
>+	u8             msix_flex_en;
>+};
>+
>+static_assert(sizeof(struct hinic3_func_attr) =3D=3D 20);
>+
>+struct hinic3_hwif {
>+	u8 __iomem              *cfg_regs_base;
>+	u64                     db_base_phy;
>+	u64                     db_dwqe_len;
>+	u8 __iomem              *db_base;
>+	struct hinic3_db_area   db_area;
>+	struct hinic3_func_attr attr;
>+};
>+
>+u16 hinic3_global_func_id(struct hinic3_hwdev *hwdev);
>+
>+#endif
>diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
>b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
>new file mode 100644
>index 000000000000..604f7891b97b
>--- /dev/null
>+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
>@@ -0,0 +1,410 @@
>+// SPDX-License-Identifier: GPL-2.0
>+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights
>reserved.
>+
>+#include <linux/delay.h>
>+#include <linux/iopoll.h>
>+
>+#include "hinic3_lld.h"
>+#include "hinic3_hwdev.h"
>+#include "hinic3_hw_cfg.h"
>+#include "hinic3_mgmt.h"
>+
>+#define HINIC3_VF_PCI_CFG_REG_BAR  0
>+#define HINIC3_PCI_INTR_REG_BAR    2
>+#define HINIC3_PCI_DB_BAR          4
>+
>+#define HINIC3_EVENT_POLL_SLEEP_US   1000
>+#define HINIC3_EVENT_POLL_TIMEOUT_US 10000000
>+
>+static struct hinic3_adev_device {
>+	const char *name;
>+} hinic3_adev_devices[SERVICE_T_MAX] =3D {
>+	[SERVICE_T_NIC] =3D {
>+		.name =3D "nic",
>+	},
>+};
>+
>+static bool hinic3_adev_svc_supported(struct hinic3_hwdev *hwdev,
>+				      enum hinic3_service_type svc_type)
>+{
>+	switch (svc_type) {
>+	case SERVICE_T_NIC:
[Suman] Are there other SERVICE type which will be introduced later?
>+		return hinic3_support_nic(hwdev);
>+	default:
>+		break;
>+	}
>+
>+	return false;
>+}
>+
>+static void hinic3_comm_adev_release(struct device *dev)
>+{
>+	struct hinic3_adev *hadev =3D container_of(dev, struct hinic3_adev,
>adev.dev);
>+
>+	kfree(hadev);
>+}
>+
>+static struct hinic3_adev *hinic3_add_one_adev(struct hinic3_hwdev
>*hwdev,
>+					       enum hinic3_service_type svc_type)
>+{
>+	struct hinic3_adev *hadev;
>+	const char *svc_name;
>+	int ret;
>+
>+	hadev =3D kzalloc(sizeof(*hadev), GFP_KERNEL);
>+	if (!hadev)
>+		return NULL;
>+
>+	svc_name =3D hinic3_adev_devices[svc_type].name;
>+	hadev->adev.name =3D svc_name;
>+	hadev->adev.id =3D hwdev->dev_id;
>+	hadev->adev.dev.parent =3D hwdev->dev;
>+	hadev->adev.dev.release =3D hinic3_comm_adev_release;
>+	hadev->svc_type =3D svc_type;
>+	hadev->hwdev =3D hwdev;
>+
>+	ret =3D auxiliary_device_init(&hadev->adev);
>+	if (ret) {
>+		dev_err(hwdev->dev, "failed init adev %s %u\n",
>+			svc_name, hwdev->dev_id);
>+		kfree(hadev);
>+		return NULL;
>+	}
>+
>+	ret =3D auxiliary_device_add(&hadev->adev);
>+	if (ret) {
>+		dev_err(hwdev->dev, "failed to add adev %s %u\n",
>+			svc_name, hwdev->dev_id);
>+		auxiliary_device_uninit(&hadev->adev);
[Suman] memleak for hadev?
>+		return NULL;
>+	}
>+
>+	return hadev;
>+}
>+
>+static void hinic3_del_one_adev(struct hinic3_hwdev *hwdev,
>+				enum hinic3_service_type svc_type)
>+{
>+	struct hinic3_pcidev *pci_adapter =3D hwdev->adapter;
>+	struct hinic3_adev *hadev;
>+	int timeout;
>+	bool state;
>+
>+	timeout =3D read_poll_timeout(test_and_set_bit, state, !state,
>+				    HINIC3_EVENT_POLL_SLEEP_US,
>+				    HINIC3_EVENT_POLL_TIMEOUT_US,
>+				    false, svc_type, &pci_adapter->state);
>+
>+	hadev =3D pci_adapter->hadev[svc_type];
>+	auxiliary_device_delete(&hadev->adev);
>+	auxiliary_device_uninit(&hadev->adev);
[Suman] should we memset hadev->adev to 0 also?
>+	pci_adapter->hadev[svc_type] =3D NULL;
>+	if (!timeout)
>+		clear_bit(svc_type, &pci_adapter->state);
>+}
>+
>+static int hinic3_attach_aux_devices(struct hinic3_hwdev *hwdev)
>+{
>+	struct hinic3_pcidev *pci_adapter =3D hwdev->adapter;
>+	enum hinic3_service_type svc_type;
>+
>+	mutex_lock(&pci_adapter->pdev_mutex);
>+
>+	for (svc_type =3D 0; svc_type < SERVICE_T_MAX; svc_type++) {
>+		if (!hinic3_adev_svc_supported(hwdev, svc_type))
>+			continue;
>+
>+		pci_adapter->hadev[svc_type] =3D hinic3_add_one_adev(hwdev,
>svc_type);
>+		if (!pci_adapter->hadev[svc_type])
>+			goto err_add_one_adev;
>+	}
>+	mutex_unlock(&pci_adapter->pdev_mutex);
>+	return 0;
>+
>+err_add_one_adev:
>+	while (svc_type > 0) {
>+		svc_type--;
>+		if (pci_adapter->hadev[svc_type]) {
>+			hinic3_del_one_adev(hwdev, svc_type);
>+			pci_adapter->hadev[svc_type] =3D NULL;
>+		}
>+	}
>+	mutex_unlock(&pci_adapter->pdev_mutex);
>+	return -ENOMEM;
>+}
>+
>+static void hinic3_detach_aux_devices(struct hinic3_hwdev *hwdev)
>+{
>+	struct hinic3_pcidev *pci_adapter =3D hwdev->adapter;
>+	int i;
>+
>+	mutex_lock(&pci_adapter->pdev_mutex);
>+	for (i =3D 0; i < ARRAY_SIZE(hinic3_adev_devices); i++) {
>+		if (pci_adapter->hadev[i])
>+			hinic3_del_one_adev(hwdev, i);
>+	}
>+	mutex_unlock(&pci_adapter->pdev_mutex);
>+}
>+
>+struct hinic3_hwdev *adev_get_hwdev(struct auxiliary_device *adev)
>+{
>+	struct hinic3_adev *hadev;
>+
>+	hadev =3D container_of(adev, struct hinic3_adev, adev);
>+	return hadev->hwdev;
>+}
>+
>+int hinic3_adev_event_register(struct auxiliary_device *adev,
>+			       void (*event_handler)(struct auxiliary_device
>*adev,
>+						     struct hinic3_event_info *event))
>+{
>+	struct hinic3_adev *hadev;
>+
>+	hadev =3D container_of(adev, struct hinic3_adev, adev);
>+	hadev->event =3D event_handler;
>+	return 0;
>+}
>+
>+static int mapping_bar(struct pci_dev *pdev,
>+		       struct hinic3_pcidev *pci_adapter)
[Suman] hnic3_mapping_bar?
>+{
>+	pci_adapter->cfg_reg_base =3D pci_ioremap_bar(pdev,
>+						    HINIC3_VF_PCI_CFG_REG_BAR);
>+	if (!pci_adapter->cfg_reg_base) {
>+		dev_err(&pdev->dev, "Failed to map configuration regs\n");
>+		return -ENOMEM;
>+	}
>+
>+	pci_adapter->intr_reg_base =3D pci_ioremap_bar(pdev,
>+						     HINIC3_PCI_INTR_REG_BAR);
>+	if (!pci_adapter->intr_reg_base) {
>+		dev_err(&pdev->dev, "Failed to map interrupt regs\n");
>+		goto err_undo_reg_bar;
>+	}
>+
>+	pci_adapter->db_base_phy =3D pci_resource_start(pdev,
>HINIC3_PCI_DB_BAR);
>+	pci_adapter->db_dwqe_len =3D pci_resource_len(pdev,
>HINIC3_PCI_DB_BAR);
>+	pci_adapter->db_base =3D pci_ioremap_bar(pdev, HINIC3_PCI_DB_BAR);
>+	if (!pci_adapter->db_base) {
>+		dev_err(&pdev->dev, "Failed to map doorbell regs\n");
>+		goto err_undo_intr_bar;
>+	}
>+
>+	return 0;
>+
>+err_undo_intr_bar:
>+	iounmap(pci_adapter->intr_reg_base);
>+
>+err_undo_reg_bar:
>+	iounmap(pci_adapter->cfg_reg_base);
>+
>+	return -ENOMEM;
>+}
>+
>+static void unmapping_bar(struct hinic3_pcidev *pci_adapter)
>+{
>+	iounmap(pci_adapter->db_base);
>+	iounmap(pci_adapter->intr_reg_base);
>+	iounmap(pci_adapter->cfg_reg_base);
>+}
>+
>+static int hinic3_pci_init(struct pci_dev *pdev)
>+{
>+	struct hinic3_pcidev *pci_adapter;
>+	int err;
>+
>+	pci_adapter =3D kzalloc(sizeof(*pci_adapter), GFP_KERNEL);
>+	if (!pci_adapter)
>+		return -ENOMEM;
>+
>+	pci_adapter->pdev =3D pdev;
>+	mutex_init(&pci_adapter->pdev_mutex);
>+
>+	pci_set_drvdata(pdev, pci_adapter);
>+
>+	err =3D pci_enable_device(pdev);
>+	if (err) {
>+		dev_err(&pdev->dev, "Failed to enable PCI device\n");
>+		goto err_pci_enable;
>+	}
>+
>+	err =3D pci_request_regions(pdev, HINIC3_NIC_DRV_NAME);
>+	if (err) {
>+		dev_err(&pdev->dev, "Failed to request regions\n");
>+		goto err_pci_regions;
>+	}
>+
>+	pci_set_master(pdev);
>+
>+	err =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>+	if (err) {
>+		dev_warn(&pdev->dev, "Couldn't set 64-bit DMA mask\n");
>+		/* try 32 bit DMA mask if 64 bit fails */
>+		err =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>+		if (err) {
>+			dev_err(&pdev->dev, "Failed to set DMA mask\n");
>+			goto err_dma_mask;
>+		}
>+	}
>+
>+	return 0;
>+
>+err_dma_mask:
>+	pci_clear_master(pdev);
>+	pci_release_regions(pdev);
>+
>+err_pci_regions:
>+	pci_disable_device(pdev);
>+
>+err_pci_enable:
>+	pci_set_drvdata(pdev, NULL);
>+	mutex_destroy(&pci_adapter->pdev_mutex);
>+	kfree(pci_adapter);
>+
>+	return err;
>+}
>+
>+static void hinic3_pci_deinit(struct pci_dev *pdev)
>+{
>+	struct hinic3_pcidev *pci_adapter =3D pci_get_drvdata(pdev);
>+
>+	pci_clear_master(pdev);
>+	pci_release_regions(pdev);
>+	pci_disable_device(pdev);
>+	pci_set_drvdata(pdev, NULL);
>+	mutex_destroy(&pci_adapter->pdev_mutex);
>+	kfree(pci_adapter);
>+}
>+
>+static int hinic3_func_init(struct pci_dev *pdev, struct hinic3_pcidev
>*pci_adapter)
>+{
>+	int err;
>+
>+	err =3D hinic3_init_hwdev(pdev);
>+	if (err) {
>+		dev_err(&pdev->dev, "Failed to initialize hardware device\n");
>+		return -EFAULT;
>+	}
>+
>+	err =3D hinic3_attach_aux_devices(pci_adapter->hwdev);
>+	if (err)
>+		goto err_attatch_aux_devices;
>+
>+	return 0;
>+
>+err_attatch_aux_devices:
>+	hinic3_free_hwdev(pci_adapter->hwdev);
>+
>+	return err;
>+}
>+
>+static void hinic3_func_deinit(struct pci_dev *pdev)
>+{
>+	struct hinic3_pcidev *pci_adapter =3D pci_get_drvdata(pdev);
>+
>+	hinic3_detach_aux_devices(pci_adapter->hwdev);
>+	hinic3_free_hwdev(pci_adapter->hwdev);
>+}
>+
>+static int hinic3_probe_func(struct hinic3_pcidev *pci_adapter)
>+{
>+	struct pci_dev *pdev =3D pci_adapter->pdev;
>+	int err;
>+
>+	err =3D mapping_bar(pdev, pci_adapter);
>+	if (err) {
>+		dev_err(&pdev->dev, "Failed to map bar\n");
>+		goto err_map_bar;
>+	}
>+
>+	err =3D hinic3_func_init(pdev, pci_adapter);
>+	if (err)
>+		goto err_func_init;
>+
>+	return 0;
>+
>+err_func_init:
>+	unmapping_bar(pci_adapter);
>+
>+err_map_bar:
>+	dev_err(&pdev->dev, "Pcie device probe function failed\n");
>+	return err;
>+}
>+
>+static int hinic3_remove_func(struct hinic3_pcidev *pci_adapter)
[Suman] can be a void function?
>+{
>+	struct pci_dev *pdev =3D pci_adapter->pdev;
>+
>+	hinic3_func_deinit(pdev);
>+	unmapping_bar(pci_adapter);
>+	return 0;
>+}
>+
>+static int hinic3_probe(struct pci_dev *pdev, const struct
>pci_device_id *id)
>+{
>+	struct hinic3_pcidev *pci_adapter;
>+	int err;
>+
>+	err =3D hinic3_pci_init(pdev);
>+	if (err)
>+		goto out;
>+
>+	pci_adapter =3D pci_get_drvdata(pdev);
>+	err =3D hinic3_probe_func(pci_adapter);
>+	if (err)
>+		goto err_hinic3_probe_func;
>+
>+	return 0;
>+
>+err_hinic3_probe_func:
>+	hinic3_pci_deinit(pdev);
>+
>+out:
>+	dev_err(&pdev->dev, "Pcie device probe failed\n");
>+	return err;
>+}
>+
>+static void hinic3_remove(struct pci_dev *pdev)
>+{
>+	struct hinic3_pcidev *pci_adapter =3D pci_get_drvdata(pdev);
>+
>+	hinic3_remove_func(pci_adapter);
>+	hinic3_pci_deinit(pdev);
>+}
>+
>+static const struct pci_device_id hinic3_pci_table[] =3D {
>+	/* Completed by later submission due to LoC limit. */
>+	{0, 0}
>+
>+};
>+
>+MODULE_DEVICE_TABLE(pci, hinic3_pci_table);
>+
>+static void hinic3_shutdown(struct pci_dev *pdev)
>+{
>+	struct hinic3_pcidev *pci_adapter =3D pci_get_drvdata(pdev);
>+
>+	pci_disable_device(pdev);
>+
>+	if (pci_adapter)
>+		hinic3_set_api_stop(pci_adapter->hwdev);
>+}
>+
>+static struct pci_driver hinic3_driver =3D {
>+	.name            =3D HINIC3_NIC_DRV_NAME,
>+	.id_table        =3D hinic3_pci_table,
>+	.probe           =3D hinic3_probe,
>+	.remove          =3D hinic3_remove,
>+	.shutdown        =3D hinic3_shutdown,
>+	.sriov_configure =3D pci_sriov_configure_simple
>+};
>+
>+int hinic3_lld_init(void)
>+{
>+	return pci_register_driver(&hinic3_driver);
>+}
>+
>+void hinic3_lld_exit(void)
>+{
>+	pci_unregister_driver(&hinic3_driver);
>+}
>diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.h
>b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.h
>new file mode 100644
>index 000000000000..b84b6641af42
>--- /dev/null
>+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.h
>@@ -0,0 +1,20 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights
>reserved. */
>+
>+#ifndef HINIC3_LLD_H
>+#define HINIC3_LLD_H
>+
>+#include <linux/auxiliary_bus.h>
>+
>+struct hinic3_event_info;
>+
>+#define HINIC3_NIC_DRV_NAME "hinic3"
>+
>+int hinic3_lld_init(void);
>+void hinic3_lld_exit(void);
>+int hinic3_adev_event_register(struct auxiliary_device *adev,
>+			       void (*event_handler)(struct auxiliary_device
>*adev,
>+						     struct hinic3_event_info *event));
>+struct hinic3_hwdev *adev_get_hwdev(struct auxiliary_device *adev);
>+
>+#endif
>diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
>b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
>new file mode 100644
>index 000000000000..d9534e996551
>--- /dev/null
>+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
>@@ -0,0 +1,421 @@
>+// SPDX-License-Identifier: GPL-2.0
>+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights
>reserved.
>+
>+#include <linux/netdevice.h>
>+#include <linux/etherdevice.h>
>+
>+#include "hinic3_common.h"
>+#include "hinic3_hwdev.h"
>+#include "hinic3_nic_cfg.h"
>+#include "hinic3_tx.h"
>+#include "hinic3_rx.h"
>+#include "hinic3_lld.h"
>+#include "hinic3_nic_dev.h"
>+#include "hinic3_nic_io.h"
>+#include "hinic3_hw_comm.h"
>+#include "hinic3_rss.h"
>+#include "hinic3_hwif.h"
>+
>+#define HINIC3_NIC_DRV_DESC  "Intelligent Network Interface Card
>Driver"
>+
>+#define HINIC3_RX_BUFF_LEN           2048
>+#define HINIC3_RX_BUFF_NUM_PER_PAGE  2
>+#define HINIC3_LRO_REPLENISH_THLD    256
>+#define HINIC3_NIC_DEV_WQ_NAME       "hinic3_nic_dev_wq"
>+
>+#define HINIC3_SQ_DEPTH              1024
>+#define HINIC3_RQ_DEPTH              1024
>+
>+#define HINIC3_DEAULT_TXRX_MSIX_PENDING_LIMIT       2
>+#define HINIC3_DEAULT_TXRX_MSIX_COALESC_TIMER_CFG   25
>+#define HINIC3_DEAULT_TXRX_MSIX_RESEND_TIMER_CFG    7
>+
>+static void init_intr_coal_param(struct net_device *netdev)
>+{
>+	struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);
>+	struct hinic3_intr_coal_info *info;
>+	u16 i;
>+
>+	for (i =3D 0; i < nic_dev->max_qps; i++) {
>+		info =3D &nic_dev->intr_coalesce[i];
>+		info->pending_limt =3D HINIC3_DEAULT_TXRX_MSIX_PENDING_LIMIT;
>+		info->coalesce_timer_cfg =3D
>HINIC3_DEAULT_TXRX_MSIX_COALESC_TIMER_CFG;
>+		info->resend_timer_cfg =3D
>HINIC3_DEAULT_TXRX_MSIX_RESEND_TIMER_CFG;
>+	}
>+}
>+
>+static int hinic3_init_intr_coalesce(struct net_device *netdev)
>+{
>+	struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);
>+	struct hinic3_hwdev *hwdev =3D nic_dev->hwdev;
>+	u64 size;
>+
>+	size =3D sizeof(*nic_dev->intr_coalesce) * nic_dev->max_qps;
>+	if (!size) {
>+		dev_err(hwdev->dev, "Cannot allocate zero size intr
>coalesce\n");
>+		return -EINVAL;
>+	}
>+	nic_dev->intr_coalesce =3D kzalloc(size, GFP_KERNEL);
>+	if (!nic_dev->intr_coalesce)
>+		return -ENOMEM;
>+
>+	init_intr_coal_param(netdev);
>+	return 0;
>+}
>+
>+static void hinic3_free_intr_coalesce(struct net_device *netdev)
>+{
>+	struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);
>+
>+	kfree(nic_dev->intr_coalesce);
>+}
>+
>+static int hinic3_alloc_txrxqs(struct net_device *netdev)
>+{
>+	struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);
>+	struct hinic3_hwdev *hwdev =3D nic_dev->hwdev;
>+	int err;
>+
>+	err =3D hinic3_alloc_txqs(netdev);
>+	if (err) {
>+		dev_err(hwdev->dev, "Failed to alloc txqs\n");
>+		return err;
>+	}
>+
>+	err =3D hinic3_alloc_rxqs(netdev);
>+	if (err) {
>+		dev_err(hwdev->dev, "Failed to alloc rxqs\n");
>+		goto err_alloc_rxqs;
>+	}
>+
>+	err =3D hinic3_init_intr_coalesce(netdev);
>+	if (err) {
>+		dev_err(hwdev->dev, "Failed to init_intr_coalesce\n");
>+		goto err_init_intr;
>+	}
>+
>+	return 0;
>+
>+err_init_intr:
>+	hinic3_free_rxqs(netdev);
>+
>+err_alloc_rxqs:
>+	hinic3_free_txqs(netdev);
>+
>+	return err;
>+}
>+
>+static void hinic3_free_txrxqs(struct net_device *netdev)
>+{
>+	hinic3_free_intr_coalesce(netdev);
>+	hinic3_free_rxqs(netdev);
>+	hinic3_free_txqs(netdev);
>+}
>+
>+static int hinic3_init_nic_dev(struct net_device *netdev,
>+			       struct hinic3_hwdev *hwdev)
>+{
>+	struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);
>+	struct pci_dev *pdev =3D hwdev->pdev;
>+	u32 page_num;
>+
>+	nic_dev->netdev =3D netdev;
>+	SET_NETDEV_DEV(netdev, &pdev->dev);
>+	nic_dev->hwdev =3D hwdev;
>+	nic_dev->pdev =3D pdev;
>+
>+	nic_dev->rx_buff_len =3D HINIC3_RX_BUFF_LEN;
>+	nic_dev->dma_rx_buff_size =3D HINIC3_RX_BUFF_NUM_PER_PAGE * nic_dev-
>>rx_buff_len;
>+	page_num =3D nic_dev->dma_rx_buff_size / HINIC3_MIN_PAGE_SIZE;
>+	nic_dev->page_order =3D page_num > 0 ? ilog2(page_num) : 0;
>+	nic_dev->lro_replenish_thld =3D HINIC3_LRO_REPLENISH_THLD;
>+	nic_dev->nic_cap =3D hwdev->cfg_mgmt->svc_cap.nic_cap;
>+
>+	return 0;
>+}
>+
>+static int hinic3_sw_init(struct net_device *netdev)
>+{
>+	struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);
>+	struct hinic3_hwdev *hwdev =3D nic_dev->hwdev;
>+	int err;
>+
>+	nic_dev->q_params.sq_depth =3D HINIC3_SQ_DEPTH;
>+	nic_dev->q_params.rq_depth =3D HINIC3_RQ_DEPTH;
>+
>+	hinic3_try_to_enable_rss(netdev);
>+
>+	/* VF driver always uses random MAC address. During VM migration to
>a
>+	 * new device, the new device should learn the VMs old MAC rather
>than
>+	 * provide its own MAC. The product design assumes that every VF is
>+	 * suspectable to migration so the device avoids offering MAC
>address
>+	 * to VFs.
>+	 */
>+	eth_hw_addr_random(netdev);
>+	err =3D hinic3_set_mac(hwdev, netdev->dev_addr, 0,
>+			     hinic3_global_func_id(hwdev));
>+	if (err) {
>+		dev_err(hwdev->dev, "Failed to set default MAC\n");
>+		goto err_out;
>+	}
>+
>+	err =3D hinic3_alloc_txrxqs(netdev);
>+	if (err) {
>+		dev_err(hwdev->dev, "Failed to alloc qps\n");
>+		goto err_alloc_qps;
>+	}
>+
>+	return 0;
>+
>+err_alloc_qps:
>+	hinic3_del_mac(hwdev, netdev->dev_addr, 0,
>hinic3_global_func_id(hwdev));
>+
>+err_out:
>+	hinic3_clear_rss_config(netdev);
>+
>+	return err;
>+}
>+
>+static void hinic3_sw_deinit(struct net_device *netdev)
>+{
>+	struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);
>+
>+	hinic3_free_txrxqs(netdev);
>+	hinic3_del_mac(nic_dev->hwdev, netdev->dev_addr, 0,
>+		       hinic3_global_func_id(nic_dev->hwdev));
>+	hinic3_clear_rss_config(netdev);
>+}
>+
>+static void hinic3_assign_netdev_ops(struct net_device *netdev)
>+{
>+	hinic3_set_netdev_ops(netdev);
>+}
>+
>+static void netdev_feature_init(struct net_device *netdev)
>+{
>+	struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);
>+	netdev_features_t cso_fts =3D 0;
>+	netdev_features_t tso_fts =3D 0;
>+	netdev_features_t dft_fts;
>+
>+	dft_fts =3D NETIF_F_SG | NETIF_F_HIGHDMA;
>+	if (hinic3_test_support(nic_dev, NIC_F_CSUM))
>+		cso_fts |=3D NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
>NETIF_F_RXCSUM;
>+	if (hinic3_test_support(nic_dev, NIC_F_SCTP_CRC))
>+		cso_fts |=3D NETIF_F_SCTP_CRC;
>+	if (hinic3_test_support(nic_dev, NIC_F_TSO))
>+		tso_fts |=3D NETIF_F_TSO | NETIF_F_TSO6;
>+
>+	netdev->features |=3D dft_fts | cso_fts | tso_fts;
>+}
>+
>+static int hinic3_set_default_hw_feature(struct net_device *netdev)
>+{
>+	struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);
>+	struct hinic3_hwdev *hwdev =3D nic_dev->hwdev;
>+	int err;
>+
>+	err =3D hinic3_set_nic_feature_to_hw(nic_dev);
>+	if (err) {
>+		dev_err(hwdev->dev, "Failed to set nic features\n");
>+		return err;
>+	}
>+
>+	return 0;
>+}
>+
>+static void hinic3_link_status_change(struct net_device *netdev, bool
>link_status_up)
>+{
>+	struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);
>+
>+	if (!HINIC3_CHANNEL_RES_VALID(nic_dev))
>+		return;
>+
>+	if (link_status_up) {
>+		if (netif_carrier_ok(netdev))
>+			return;
>+
>+		nic_dev->link_status_up =3D true;
>+		netif_carrier_on(netdev);
[Suman] don't we need to call netif_tx_start_all_queues as well?=20
>+		netdev_dbg(netdev, "Link is up\n");
>+	} else {
>+		if (!netif_carrier_ok(netdev))
>+			return;
>+
>+		nic_dev->link_status_up =3D false;
>+		netif_carrier_off(netdev);
[Suman] don't we need to call netif_tx_stop_all_queues as well?
>+		netdev_dbg(netdev, "Link is down\n");
>+	}
>+}
>+
>+static void nic_event(struct auxiliary_device *adev, struct
>hinic3_event_info *event)
>+{
>+	struct hinic3_nic_dev *nic_dev =3D dev_get_drvdata(&adev->dev);
>+	struct net_device *netdev;
>+
>+	netdev =3D nic_dev->netdev;
>+
>+	switch (HINIC3_SRV_EVENT_TYPE(event->service, event->type)) {
>+	case HINIC3_SRV_EVENT_TYPE(EVENT_SRV_NIC, EVENT_NIC_LINK_UP):
>+		hinic3_link_status_change(netdev, true);
>+		break;
>+	case HINIC3_SRV_EVENT_TYPE(EVENT_SRV_NIC, EVENT_NIC_LINK_DOWN):
>+		hinic3_link_status_change(netdev, false);
>+		break;
>+	default:
>+		break;
>+	}
>+}
>+
>+static int nic_probe(struct auxiliary_device *adev, const struct
>auxiliary_device_id *id)
>+{
>+	struct hinic3_hwdev *hwdev =3D adev_get_hwdev(adev);
>+	struct pci_dev *pdev =3D hwdev->pdev;
>+	struct hinic3_nic_dev *nic_dev;
>+	struct net_device *netdev;
>+	u16 max_qps, glb_func_id;
>+	int err;
>+
>+	if (!hinic3_support_nic(hwdev)) {
>+		dev_dbg(&adev->dev, "Hw doesn't support nic\n");
>+		return 0;
>+	}
>+
>+	err =3D hinic3_adev_event_register(adev, nic_event);
>+	if (err) {
>+		err =3D -EINVAL;
>+		goto err_out;
>+	}
>+
>+	glb_func_id =3D hinic3_global_func_id(hwdev);
>+	err =3D hinic3_func_reset(hwdev, glb_func_id, RESET_TYPE_NIC);
>+	if (err) {
>+		dev_err(&adev->dev, "Failed to reset function\n");
[Suman] **_adev_event_unregister?
>+		goto err_out;
>+	}
>+
>+	max_qps =3D hinic3_func_max_qnum(hwdev);
>+	netdev =3D alloc_etherdev_mq(sizeof(*nic_dev), max_qps);
>+	if (!netdev) {
>+		dev_err(&adev->dev, "Failed to allocate netdev\n");
>+		err =3D -ENOMEM;
[Suman] **_adev_event_unregister?
>+		goto err_out;
>+	}
>+
>+	nic_dev =3D netdev_priv(netdev);
>+	dev_set_drvdata(&adev->dev, nic_dev);
>+	err =3D hinic3_init_nic_dev(netdev, hwdev);
>+	if (err)
>+		goto err_undo_alloc_etherdev;
>+
>+	err =3D hinic3_init_nic_io(nic_dev);
>+	if (err)
>+		goto err_undo_alloc_etherdev;
>+
>+	err =3D hinic3_sw_init(netdev);
>+	if (err)
>+		goto err_sw_init;
>+
>+	hinic3_assign_netdev_ops(netdev);
>+
>+	netdev_feature_init(netdev);
>+	err =3D hinic3_set_default_hw_feature(netdev);
>+	if (err)
>+		goto err_set_features;
>+
>+	err =3D register_netdev(netdev);
>+	if (err) {
>+		err =3D -ENOMEM;
>+		goto err_netdev;
>+	}
>+
>+	netif_carrier_off(netdev);
>+	return 0;
>+
>+err_netdev:
>+	hinic3_update_nic_feature(nic_dev, 0);
>+	hinic3_set_nic_feature_to_hw(nic_dev);
>+
>+err_set_features:
>+	hinic3_sw_deinit(netdev);
>+
>+err_sw_init:
>+	hinic3_free_nic_io(nic_dev);
>+
>+err_undo_alloc_etherdev:
>+	free_netdev(netdev);
>+
>+err_out:
>+	dev_err(&pdev->dev, "NIC service probe failed\n");
>+
>+	return err;
>+}
>+
>+static void nic_remove(struct auxiliary_device *adev)
>+{
>+	struct hinic3_nic_dev *nic_dev =3D dev_get_drvdata(&adev->dev);
>+	struct net_device *netdev;
>+
>+	if (!hinic3_support_nic(nic_dev->hwdev))
>+		return;
>+
>+	netdev =3D nic_dev->netdev;
>+	unregister_netdev(netdev);
>+
>+	hinic3_update_nic_feature(nic_dev, 0);
>+	hinic3_set_nic_feature_to_hw(nic_dev);
>+	hinic3_sw_deinit(netdev);
>+
>+	hinic3_free_nic_io(nic_dev);
>+
>+	free_netdev(netdev);
>+}
>+
>+static const struct auxiliary_device_id nic_id_table[] =3D {
>+	{
>+		.name =3D HINIC3_NIC_DRV_NAME ".nic",
>+	},
>+	{},
>+};
>+
>+static struct auxiliary_driver nic_driver =3D {
>+	.probe    =3D nic_probe,
>+	.remove   =3D nic_remove,
>+	.suspend  =3D NULL,
>+	.resume   =3D NULL,
>+	.name     =3D "nic",
>+	.id_table =3D nic_id_table,
>+};
>+
>+static __init int hinic3_nic_lld_init(void)
>+{
>+	int err;
>+
>+	pr_info("%s: %s\n", HINIC3_NIC_DRV_NAME, HINIC3_NIC_DRV_DESC);
>+
>+	err =3D hinic3_lld_init();
>+	if (err)
>+		return err;
>+
>+	err =3D auxiliary_driver_register(&nic_driver);
>+	if (err) {
>+		hinic3_lld_exit();
>+		return err;
>+	}
>+
>+	return 0;
>+}
>+
>+static __exit void hinic3_nic_lld_exit(void)
>+{
>+	auxiliary_driver_unregister(&nic_driver);
>+
>+	hinic3_lld_exit();
>+}
>+
>+module_init(hinic3_nic_lld_init);
>+module_exit(hinic3_nic_lld_exit);
>+
>+MODULE_AUTHOR("Huawei Technologies CO., Ltd");
>+MODULE_DESCRIPTION(HINIC3_NIC_DRV_DESC);
>+MODULE_LICENSE("GPL");
[Suman] I will try to post my comments on rest of the patch in a separate r=
esponse.=20


