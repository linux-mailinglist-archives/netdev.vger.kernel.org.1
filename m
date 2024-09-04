Return-Path: <netdev+bounces-124809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2336796B088
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 07:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE771F24E91
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 05:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9872824BB;
	Wed,  4 Sep 2024 05:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="ATvrQqhb"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F6D39B;
	Wed,  4 Sep 2024 05:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725428158; cv=fail; b=uYBrpvIQJ4GqbUrzwPG3byLL6CXPEYf3QrMlBTezkrqKhb3nuzC3mVwR79f9/q3VYJESvIN1NcpV6zsvIqSnhjiVSL3yUBf59Ko6d596YGwvIhHoxHatmvzV4tKb/w5Hb4uI8fqqEJ9MJXvOPvUSzc538AkZeqhFlFMyZrjZ8JY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725428158; c=relaxed/simple;
	bh=Ub/2man5jTxz47eJ3V1FTlZpT7kPNDEZweb7uEd2Ais=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b2mYETR63PFoCfuWbQ5xeJ9QxpUfMmSOnU3ZUSkHAjorNM0tUBjfQcR1zYs/4dpP0iRNMQ5bo+kbvti3HmehbKV7fnaURXYIUOn5qG3HUwU7fmpHos6Cdt9/N3DtFOOmZ6KeFNRtFxlHHmIb5naURvDv6eBK5FHO/nZYfB/LCCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=ATvrQqhb; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483Lw4r5016612;
	Tue, 3 Sep 2024 22:35:35 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41e3bsbjjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 22:35:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4TqQWL2hFcBYkwEIYfDYxI0HB1LSwdi/V0u/vltb7E3Pz9j4b7S/Oc6VYqm01AiTqRvASpahtmCv4+Yo8KlCWuHeRvzj3AXouPeqCsaWjr92rdwXnYUnRdm3W+F6w+gut5FRFpn5KXJ5pdq1pUnmWX6wa63Re9ROzDcBk3T3jrYyaqaJfu/bpfpDDycFqCmxs7K2GEDrSYMeYC1N00wcdrSPOO3pehvcUgC3y3bxWxXy2cgtHeya288wu6qYQyUOc6pv2V7Kh9dwwuelAdrY3t0F3qUN4KuKHoKde2Mb3MlP75g7H/Z450tl7ITRo9FsVSipgYSoQdrmyhMoqhWCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ub/2man5jTxz47eJ3V1FTlZpT7kPNDEZweb7uEd2Ais=;
 b=ssru4n5xcJYibQGzJqfKZJ/I0A0A4QjkOgwLJaLU+tPhXJjue/nX3VabiEZkE42T5qOrIE8D9dtVi6suwdNeRziWYRVxhCiXr6+235nw+fvG8gunzaPSx3/h9ceW7P0zvmOyZm8HT8C3938upnBOrC2OTlfwjEgUPHOhSRLKr0CDQ13XL5Vm1/OjVvbNvcXSaBa8fGpmHHgCFrvMW/0jU9cT7HISmSFsrnLb6+xHbYJgX7W9jXXNvjJ9Jha43zFmiHTRZ91CYiTfdByl65nf65Sp012h2SQV0YuGSCE7xllQl2uaaKqcCP2OcXabBEQPWV9D3/evN0FXyS+YWnvBhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ub/2man5jTxz47eJ3V1FTlZpT7kPNDEZweb7uEd2Ais=;
 b=ATvrQqhb5a+/8FoJNPusK2lZ+A1NSgNNQmOETgq5vtWQwD2wysgzOcgzMltF3MWbuY4kYg0a/667b/GxQoRLRVaQsNmfQabMVKMsOFmz40AmKvEA/wt0zAapnmV4ZL+z4ofKSgONqzkGNl5MTCKWtvKcn0n5UFGDzREKerkGnpI=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by BL1PR18MB4199.namprd18.prod.outlook.com (2603:10b6:208:31b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 05:35:31 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%2]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 05:35:31 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "edumazet@google.com"
	<edumazet@google.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam
	<hkelam@marvell.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH 2/4] octeontx2-pf: Add new APIs
 for queue memory alloc/free.
Thread-Topic: [EXTERNAL] Re: [net-next PATCH 2/4] octeontx2-pf: Add new APIs
 for queue memory alloc/free.
Thread-Index: AQHa/f6MvN3H2HxQbk2MHN6q2qmTvrJGK04AgADw7TA=
Date: Wed, 4 Sep 2024 05:35:31 +0000
Message-ID:
 <CH0PR18MB43390396F1138E2AE7D79450CD9C2@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240903124048.14235-1-gakula@marvell.com>
 <20240903124048.14235-3-gakula@marvell.com>
 <CALs4sv3KVxTFex3FHWSFjx37FahOTiMN0DJyZ0Zn9qxQZQpZow@mail.gmail.com>
In-Reply-To:
 <CALs4sv3KVxTFex3FHWSFjx37FahOTiMN0DJyZ0Zn9qxQZQpZow@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|BL1PR18MB4199:EE_
x-ms-office365-filtering-correlation-id: 5feccaa1-e3ff-4a6f-ee60-08dccca3642c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M0c1aHYvMjVSa3hCcHRHR2xwMGRiclUyY1JROHJqZkRwMnBuVjBSa2JYU0Fz?=
 =?utf-8?B?ZjFrTlhGTHZNOENFdXdpVndkZFFBY2VuelRuK0RnWjBZUDBkR24vdDZ6SXJN?=
 =?utf-8?B?MytFek1rdFZ4ZEU4ckhraXJJMk01eE51SUh5em9wRjVXb216eUh5Tit3U2NY?=
 =?utf-8?B?MEovRm9vNnAwWTRXVXB5T0hWZ0xUYUtEOWRqQk1yL3M4SWtXbHhnd0sxOFJX?=
 =?utf-8?B?RllzTDVaZldKTnNack5YU0xzMFQxclpod0FENHRtamU1eWZTaVgvQnBiYzNx?=
 =?utf-8?B?dzVuSHVNVHVpN0dzbldYQVdGSEhhZDRvd1RmWTRUS05Tc3U3dG5GYWdNbHYy?=
 =?utf-8?B?c214TWpZV3hIeDFJNEo4Zzlid0REZk5BVjlENS9ZbzFQem1ZbFdVMkJXNlFw?=
 =?utf-8?B?aUd0K2NxWFh3TVNVenhTazJrYXVxV2ZKdm9JU1dWNkhwR3ZINGNBUW1VSGFR?=
 =?utf-8?B?SHdpdEczZkJCRlM2WHRGRnppa2RoQ1lQd3VwcDhBUlo5dGhHR1dMVmNSb2xh?=
 =?utf-8?B?Q25yVG9Tcm5EY3kyOGlSZFhHR3FianJtTkdMc1JDRjdBZWVXWHg1RmFDNnV6?=
 =?utf-8?B?WElpTHFoY1VtR1prSjJGY0JxcDF2NlF3elVxSjJ0VG5FYzd0Q0VzakxiRDhI?=
 =?utf-8?B?akNGcXVpTFlLRlM2eU1YVTMrSktic2ptbXdwNVdDd2NQVFZ2MklEZmd3Wkl5?=
 =?utf-8?B?amRNbFdOMWRoeXR6dnpwYWZXZG43dWgreDNXRDR1VTZ2aU9MV2djT2U3Nkpr?=
 =?utf-8?B?UlN6NGhta3RYbjBOMU1adU01QjhaWi9QUlgwVTEzZnVPVEF4cjI5MlFPaFl3?=
 =?utf-8?B?c2NlZGRSUFU2ZEZ1dGxLNGEyenFiRlNIWmtBM243ajZsMnl3bnk2cml5eWlu?=
 =?utf-8?B?ZDRnTkVkYzN6Q04zVkRiNmxVRTBMWFNTbks0VE5zSkN4dXhnRHFnZlVjd2tR?=
 =?utf-8?B?emgyTXJOVC9ZK0tWa0VsWDBiQmlaM3h3Vmd2amdNcmdiakxMUzAvZzVQUTlP?=
 =?utf-8?B?cnRnME5oTXBkQ3BuUERnbnFTQVR5QzlXQWtiSTdRUzVseW5iWCttY3djeDFY?=
 =?utf-8?B?SlgzNHJ0MVAvL0x2a1hkZDlobmZJMjJ1VldrdGt4bHp5Rm50WlptQmhHZ0Zo?=
 =?utf-8?B?cXNSWDE2aGgrTHN0SEhPNVdjL3ZTeVJjV2szcVhlYVpwNVNERW9FNjh6NWJi?=
 =?utf-8?B?VWprb0pMUDM3TTN6czNyUDBKNGRIcFBPNm1DVFh1NDBLT2lCaHZzaURLNnZv?=
 =?utf-8?B?OG9PZ2pLUFg2Wjk2RjU0TW1QMFc5emVlYUlsQXBHVnFsVUsvcXFaOTdSZEtJ?=
 =?utf-8?B?OTBFT1d0a1pZOWlxUXkzc04yMFBiMFprYW55eTFyNGl4dWxvWGQwVG04dVV6?=
 =?utf-8?B?cmgwcDBOdys4cTRFL2hFeVBrbEhBK1g5NDNiYVV0MkRvQ0hjQ3FXVXIvV3Q1?=
 =?utf-8?B?b2RoR0FWdHdqTm45NDMwWXdYOXdZTDhLZDJHbzRRRmVFK1JxNmxQb1VaNkVP?=
 =?utf-8?B?Q3UzYzVldEhzSDdpcVBGSkUybkJhbEFxN0ROWkh4cUFmQXdES3VvVFlIZkI1?=
 =?utf-8?B?amxiWlJIak91Wms3aXNsY1RWakJiL0NpSFg3VXJRUENXS2xxVkh2QWY4eDBs?=
 =?utf-8?B?UFZSNFJuMHZKaDMzS0U5RTAzeTFOZDBMQzhxNTFDRFI4NzJKaU5TTEEvTjBq?=
 =?utf-8?B?NlQ4ZlRvY2w5YUlZVEFkRXhRSEs5Z3hxdzFVMkZCQW5OR0J5SG9WSEJFNno0?=
 =?utf-8?B?VlFHY2Rsbk9qNnFFbDNUOGs3WmlPN0dyWkxSYTJnaFJ6SDB4ZjhUTFgvV3RB?=
 =?utf-8?B?UFFaVzVsZVcvcjJpSkk0Wk44bnBRemJOTmpGeTlKS0Qya0VqTXhoTVU2ZGw1?=
 =?utf-8?B?VW4xbmdjdFFJT2VWUjA1MTlsZVRiMHlNZzE5MnQzZmZ5TXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RkZFVUdaMTh2UjR6RjZOQWx6aWgzWFBMUFNaODZWYVh1UWpmNlFxZjZFc09O?=
 =?utf-8?B?Yk9zUVlaeGJ2dWJmeDM4dmMxU1Rmb1NEaG1jcXlsME5vOE5YNTlWeThvaDZ2?=
 =?utf-8?B?VlRydjJCdGFyVzlNQkpIbStkTTRPbGpmcldtMGs4VGZrRHpEeVI2ajBTQnda?=
 =?utf-8?B?akU5ZkZhRTMyQXZwSmIzKzliWVY1cTNUazNMdHpQSE5udkhnUzh6MXI2ZVNh?=
 =?utf-8?B?TTh5T3NsdSt0Nys5T25raE9UVWtEUVRmaGNPcnFvTzZtYzhPOTluWG5sRWdD?=
 =?utf-8?B?bk0yVElhQ1l3c3ZkRVNjdVpPdmNSMnFGR1lYaVFjYlJsNGVqNHFtbXo0MXl6?=
 =?utf-8?B?ZzNDOHplYlUrWFYxZzdsWWRaMmVRNnhRa0hmb25ISWMvOWpvczNBTGpzYk9H?=
 =?utf-8?B?VnI4MDZzZ05OL3lPRklZcUMyTFU5YkNsdTNlU1RXdE9OYW42VnczQ0lRR1ZX?=
 =?utf-8?B?c3hwSVJFWFlQNUt6MU1DZi9PMlNxZllYS0RpRUZHOThIUE5SMnhLWWNnTCtQ?=
 =?utf-8?B?UDQrOERFc0ZxTVZwWEFqcFp6dllyNFBBdysxU2V4UEtmS1BuckEzVTIyRTJJ?=
 =?utf-8?B?MmMvSmFmbXNCZW9oT2J5Q1E2L1J0aUo2T2NDV2NaYVdFb0o5d01jQWt6VHRi?=
 =?utf-8?B?K3p3dE9Jb2NNc2xtU3Y3V0tUcFpYOXFhejdsYkd6U2NIZk9jeHZRT1dDZ0h6?=
 =?utf-8?B?ZzhNZjN6bTBidW1MU2hiWEY0QW1WNDhpZUdGc1BBTGkzVk9xenMrT3pWbEpN?=
 =?utf-8?B?N2ZGeCtwekxPZThwTHJ0dE1wK1ZoemovQTdnTUwxS0t2MGNnN3o0a1JMVTIv?=
 =?utf-8?B?dTU5UVRNc1pGdzBYNTc3RS96Uy9CeXZjWDlYc2djanlKZjlkeEM5QWh5ZkpW?=
 =?utf-8?B?K25ZNC9wOTh0TEdSZSs2NlBSVWgzWGkxM3BudUt3RkJIdm9vaGhydHJqZEh3?=
 =?utf-8?B?MUlOSTNOMitQTWQ1aFhvSlhON0JabzM4UTNZaTVBSlRRVWhYQkpNWFdpUWUx?=
 =?utf-8?B?bVdWSCs3VmhHc1B0dFVCbFkwWVcxdmk0Y1IxV2VlT282Y0N0TmwyUVFIVklh?=
 =?utf-8?B?elBIaVl3b1lYMXRndlhMR2E5emNWRlhKdFQ0Y2VZdUFCcEFHSzJWeG43NkZK?=
 =?utf-8?B?cnpMcU5IUFJCbkNiZGxxLzV2Sm1pWWVRYWhuNEtsb052cmcxWGpZTkt6Wjd4?=
 =?utf-8?B?NDlNQUFYaDlRdTFmSFM1RC9ScjVxT0JxUi9VM1l1WDU0NjExOWNFUk04b3lH?=
 =?utf-8?B?Tk1oYy8zMVdDbVdCQTlPcTBaeWhUTzVLUCtxZkE3dmZtdFFPZXJJV2dwc0p3?=
 =?utf-8?B?VU01WnVYbTNkQzdGL1c0ZFpTOEhmSkhyTm1yU1JWMnExS2F6YXhMNFJKTU5p?=
 =?utf-8?B?RzIzNGIremQ2VEVSSkNSNjNzR3Nnd1NOVmx3ZWFKTktoSEtxVVdQdkQrNjl6?=
 =?utf-8?B?YlVnUmRVUWh2LysxM3lGbU9YSWpWcDZHbTFPanlFL2xtU3p6VWo0NHo0NFZi?=
 =?utf-8?B?RXYySEpZSW9YczVTM0xHL0VKdW41QjM0KzRvdG1ZSGFEN0w4aXBuR3R4MlRz?=
 =?utf-8?B?T2M3eWtjT0lCR3BZWWJRSFVXa3NxWTlBeGNDbFVPTDAzY2szYnNHbkxnejRK?=
 =?utf-8?B?N0JSZ2tLb050YTJjN3dhWGVvL3d0S1VJL0llamp2ZGpaZTN3NUFZY1ZRbW1V?=
 =?utf-8?B?cnNYcW1tSnZhdEdnRU9DZGMybkRjZDRyb0JsOTJDQ1lpeDZlaEcvY2VNTzk0?=
 =?utf-8?B?bWFZVUZYWEk0UjJhT0VxYXlIU1FtMkVXejdVRlpkQ09EbnMrRjZiaytjYngr?=
 =?utf-8?B?Tjc0WEF2RUkxcFZwNmx6dE9XeEt5bU1KQUw2Ympqckh2YW9VM3lNSmtlR005?=
 =?utf-8?B?QkxzRGRhaERUZVI1c0diUzRPYndnUzJsOUY4ZnNTWlY4M1NVZFNwYVcrTmZw?=
 =?utf-8?B?RzBXUGNuSHpOSG1YZE83ZENSYit1dW8yanFLUHExWDlsUm9XWnhOeWk2SFM5?=
 =?utf-8?B?VzVIMFdBNVgyK24rOVA1eVk1RWRkY3EvbFp0R1Zjb0dXamlYQjJOMUh6YkdH?=
 =?utf-8?B?eDlXa21xYStoeUNmQ3h6TG1kTUlkdWlreituN3V0MVFqWHlWZk9qZzdvclJy?=
 =?utf-8?B?RUtnRkZBNnpUaGhJdTRXY3BLRlhDaUROYXIvUG4yOUF4M0tsQ1lqRmYyWG5j?=
 =?utf-8?Q?GXG+LfVHS2SqaAD1d9pzPT3oEnWaVyLPko3lYALD2A35?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5feccaa1-e3ff-4a6f-ee60-08dccca3642c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 05:35:31.1944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1QG/hu4vg6+A04cbK1VrO8SLz4my1OZ47K7F2pOzNGb/17PGM0GbCS1rlEFw3Ncrz0UWgjDePrk/GHxipOX2EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4199
X-Proofpoint-GUID: Xv8aTlwHkDcZJoIat1LAeFBVl1bVKF4K
X-Proofpoint-ORIG-GUID: Xv8aTlwHkDcZJoIat1LAeFBVl1bVKF4K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_03,2024-09-03_01,2024-09-02_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBhdmFuIENoZWJiaSA8cGF2
YW4uY2hlYmJpQGJyb2FkY29tLmNvbT4NCj5TZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMywgMjAy
NCA4OjQyIFBNDQo+VG86IEdlZXRoYXNvd2phbnlhIEFrdWxhIDxnYWt1bGFAbWFydmVsbC5jb20+
DQo+Q2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IGt1YmFAa2VybmVsLm9yZzsNCj5kYXZlbUBkYXZlbWxvZnQubmV0OyBwYWJlbmlAcmVkaGF0
LmNvbTsgamlyaUByZXNudWxsaS51czsNCj5lZHVtYXpldEBnb29nbGUuY29tOyBTdW5pbCBLb3Z2
dXJpIEdvdXRoYW0gPHNnb3V0aGFtQG1hcnZlbGwuY29tPjsNCj5TdWJiYXJheWEgU3VuZGVlcCBC
aGF0dGEgPHNiaGF0dGFAbWFydmVsbC5jb20+OyBIYXJpcHJhc2FkIEtlbGFtDQo+PGhrZWxhbUBt
YXJ2ZWxsLmNvbT4NCj5TdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbbmV0LW5leHQgUEFUQ0ggMi80
XSBvY3Rlb250eDItcGY6IEFkZCBuZXcgQVBJcyBmb3INCj5xdWV1ZSBtZW1vcnkgYWxsb2MvZnJl
ZS4NCj4NCj5PbiBUdWUsIFNlcCAzLCAyMDI0IGF0IDY6MTLigK9QTSBHZWV0aGEgc293amFueWEg
PGdha3VsYUBtYXJ2ZWxsLmNvbT4NCj53cm90ZToNCj4+DQo+PiBHcm91cCB0aGUgcXVldWUoUlgv
VFgvQ1EpIG1lbW9yeSBhbGxvY2F0aW9uIGFuZCBmcmVlIGNvZGUgdG8gc2luZ2xlIEFQSXMuDQo+
Pg0KPj4gU2lnbmVkLW9mZi1ieTogR2VldGhhIHNvd2phbnlhIDxnYWt1bGFAbWFydmVsbC5jb20+
DQo+PiAtLS0NCj4+ICAuLi4vbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfY29tbW9uLmggICAg
ICAgfCAgMiArDQo+PiAgLi4uL2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3Bm
LmMgIHwgNTYgKysrKysrKysrKysrKy0tLS0tLQ0KPj4gIDIgZmlsZXMgY2hhbmdlZCwgNDEgaW5z
ZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX2NvbW1vbi5oDQo+Yi9kcml2
ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml9jb21tb24uaA0KPj4g
aW5kZXggYTQ3MDAxYTJiOTNmLi5kZjU0OGFlZmZlY2YgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml9jb21tb24uaA0KPj4gKysr
IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfY29tbW9u
LmgNCj4+IEBAIC05OTcsNiArOTk3LDggQEAgaW50IG90eDJfcG9vbF9pbml0KHN0cnVjdCBvdHgy
X25pYyAqcGZ2ZiwgdTE2IHBvb2xfaWQsDQo+PiAgaW50IG90eDJfYXVyYV9pbml0KHN0cnVjdCBv
dHgyX25pYyAqcGZ2ZiwgaW50IGF1cmFfaWQsDQo+PiAgICAgICAgICAgICAgICAgICAgaW50IHBv
b2xfaWQsIGludCBudW1wdHJzKTsNCj4+ICBpbnQgb3R4Ml9pbml0X3JzcmMoc3RydWN0IHBjaV9k
ZXYgKnBkZXYsIHN0cnVjdCBvdHgyX25pYyAqcGYpOw0KPj4gK3ZvaWQgb3R4Ml9mcmVlX3F1ZXVl
X21lbShzdHJ1Y3Qgb3R4Ml9xc2V0ICpxc2V0KTsNCj4+ICtpbnQgb3R4Ml9hbGxvY19xdWV1ZV9t
ZW0oc3RydWN0IG90eDJfbmljICpwZik7DQo+Pg0KPj4gIC8qIFJTUyBjb25maWd1cmF0aW9uIEFQ
SXMqLw0KPj4gIGludCBvdHgyX3Jzc19pbml0KHN0cnVjdCBvdHgyX25pYyAqcGZ2Zik7DQo+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290
eDJfcGYuYw0KPmIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290
eDJfcGYuYw0KPj4gaW5kZXggNGNmZWNhNWNhNjI2Li42OGFkZGM5NzUxMTMgMTAwNjQ0DQo+PiAt
LS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml9wZi5j
DQo+PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4
Ml9wZi5jDQo+PiBAQCAtMTc3MCwxNSArMTc3MCwyMyBAQCBzdGF0aWMgdm9pZCBvdHgyX2RpbV93
b3JrKHN0cnVjdCB3b3JrX3N0cnVjdA0KPip3KQ0KPj4gICAgICAgICBkaW0tPnN0YXRlID0gRElN
X1NUQVJUX01FQVNVUkU7DQo+PiAgfQ0KPj4NCj4+IC1pbnQgb3R4Ml9vcGVuKHN0cnVjdCBuZXRf
ZGV2aWNlICpuZXRkZXYpDQo+PiArdm9pZCBvdHgyX2ZyZWVfcXVldWVfbWVtKHN0cnVjdCBvdHgy
X3FzZXQgKnFzZXQpDQo+PiArew0KPj4gKyAgICAgICBrZnJlZShxc2V0LT5zcSk7DQo+PiArICAg
ICAgIHFzZXQtPnNxID0gTlVMTDsNCj4+ICsgICAgICAga2ZyZWUocXNldC0+Y3EpOw0KPj4gKyAg
ICAgICBxc2V0LT5jcSA9IE5VTEw7DQo+PiArICAgICAgIGtmcmVlKHFzZXQtPnJxKTsNCj4+ICsg
ICAgICAgcXNldC0+cnEgPSBOVUxMOw0KPj4gKyAgICAgICBrZnJlZShxc2V0LT5uYXBpKTsNCj4+
ICt9DQo+PiArRVhQT1JUX1NZTUJPTChvdHgyX2ZyZWVfcXVldWVfbWVtKTsNCj4+ICtpbnQgb3R4
Ml9hbGxvY19xdWV1ZV9tZW0oc3RydWN0IG90eDJfbmljICpwZikNCj4+ICB7DQo+PiAtICAgICAg
IHN0cnVjdCBvdHgyX25pYyAqcGYgPSBuZXRkZXZfcHJpdihuZXRkZXYpOw0KPj4gLSAgICAgICBz
dHJ1Y3Qgb3R4Ml9jcV9wb2xsICpjcV9wb2xsID0gTlVMTDsNCj4+ICAgICAgICAgc3RydWN0IG90
eDJfcXNldCAqcXNldCA9ICZwZi0+cXNldDsNCj4+IC0gICAgICAgaW50IGVyciA9IDAsIHFpZHgs
IHZlYzsNCj4+IC0gICAgICAgY2hhciAqaXJxX25hbWU7DQo+PiArICAgICAgIHN0cnVjdCBvdHgy
X2NxX3BvbGwgKmNxX3BvbGw7DQo+PiArICAgICAgIGludCBlcnIgPSAtRU5PTUVNOw0KPkkgZG9u
J3Qgc2VlICdlcnInIGdldHRpbmcgc2V0IHRvIGFueXRoaW5nIGVsc2UuIENhbiBhdm9pZCB0aGUg
dmFyaWFibGUNCj5hbmQgZGlyZWN0bHkgcmV0dXJuIC1FTk9NRU0gZXZlcnl3aGVyZT8NCldpbGwg
Zml4IGl0IGluIG5leHQgdmVyc2lvbi4NCg==

