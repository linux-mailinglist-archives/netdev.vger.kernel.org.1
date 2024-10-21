Return-Path: <netdev+bounces-137469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB4B9A68DD
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF771F236D1
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2671F4FAA;
	Mon, 21 Oct 2024 12:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="NCOP2ZIv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741591EF94B;
	Mon, 21 Oct 2024 12:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514612; cv=fail; b=r9zAm3MBnKSQ9rBL3w1an9NJssUaLhkgt+g4uQjrmaDhhM4E2hti5c6toScyV0+be/1ybbE87d2GvLHRfKuh6UL+1qjPpvjaqNB7Vc/rQT/EOzXAV4OUNuilicw/1iQ4xgTThecid5/JT22oSbgzT4C67JmJy/B3KgR1IfDQSDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514612; c=relaxed/simple;
	bh=2FMDtAsUp1ejupo9I7IPVbOyBtIcTA0zdJCK8/c6Nic=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f5J4W+ECoPWF193WIFqtLUxIXeK9ml0gIiv8ooV1ayXcl/LfoEU6YW8+XbDiIxBc7qibo5t0rIjrA8j8do1ipAWZX08PW380h853XZD2v6i0i67jvSKZz7a+Iawzhw/RWv4TGSJi9A45jOB/cMyp1ve9qBX9YsIDEgy/iYWlUeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=NCOP2ZIv; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LCQxhg004165;
	Mon, 21 Oct 2024 05:43:20 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42dpxv013m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 05:43:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLNJNC6Y6VDmvvo7JVW4SNh+hgyKhPoRQ2N2QHUa+3wac9x1t7PXhGmeEv2UDtAHla+vuPozn+qWzPtrGnhbo11i0B06NF6pIKT/HnhcWz9/LGyb/w9jXo+9d+FokCXKmD6C/jegpxbUQ2qMRzDmF4JDK/snE2s4Z71MMaY3ucmtyPA3DJDlec9gpW+wApWcRpehkXLmeaitB2xrLG9XmZsdGHfnqDUQPqrh0IR0eKaOlGh2z9CpPjkbOMeEJmkVBDLTxTU1T8SLQjEK9Rvwc1UOoodcrFdYC9durJ6VdAlwJDFZ0+O1A/n67bYZLmrLj1fXYY6K1HFNIFgf0zWPzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FMDtAsUp1ejupo9I7IPVbOyBtIcTA0zdJCK8/c6Nic=;
 b=nLuobwEhjhlMQsGfw9yV6Mv/4m5oQfkhqjoPUyxEVuAJbG5738QZCQ7wSWX6t3hD9XIW2kkZvgM2adFikOW/vv2Il3uuaGFSKuump0VNkUM8qLJ5+zvn6Zh3RcQUK0LQEuO+u5PKapkkjkdYORP3OWCdcI0xN5TL11OPtJDkaMJfKscegX+T2w8VRI5K6ucJjWV/z7G2rUcJ+3ErZN1rDcjX2ejIQl/zbcsCReqYvKqywDKx+CjL1EcYca6YbPvGh6UmhKt87sE4Igi0Yid/FctCwWYq8w2ePC0VxzK5F8MhRO3+KvIDuDcYqCyxusmsVZ20cRru1A0Q4RC940+00Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FMDtAsUp1ejupo9I7IPVbOyBtIcTA0zdJCK8/c6Nic=;
 b=NCOP2ZIveboxuqUwz5bFpz3FA/9LMB043eT23KIkM07XMippt742iEA/jAiZoeMD3XRJ8Tkm48dF47v8yAUQihYG90tksmWuE6tT4EVYbMRrY2MS/7j1YPi86mEURfz2dtEcsDlyAqczBf4a1375Dnevg/BfY00HBgHi4D+y9Zg=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by BL1PR18MB4118.namprd18.prod.outlook.com (2603:10b6:208:313::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 12:43:08 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30%7]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 12:43:07 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Linu Cherian
	<lcherian@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        Hariprasad Kelam
	<hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
Subject: Re: [net-next PATCH 2/6] octeontx2-af: CN20k basic mbox operations
 and structures
Thread-Topic: [net-next PATCH 2/6] octeontx2-af: CN20k basic mbox operations
 and structures
Thread-Index: AQHbI7bHGDvFlF+6CECkHgVkBuJufg==
Date: Mon, 21 Oct 2024 12:43:07 +0000
Message-ID:
 <BY3PR18MB4707134E6C53529760BFE5C3A0432@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20241018203058.3641959-1-saikrishnag@marvell.com>
 <20241018203058.3641959-3-saikrishnag@marvell.com>
 <CAH-L+nMzLbRXbNeiQVYWRcCnvqAXs7S6wHp1JqOPMU==78rATA@mail.gmail.com>
In-Reply-To:
 <CAH-L+nMzLbRXbNeiQVYWRcCnvqAXs7S6wHp1JqOPMU==78rATA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|BL1PR18MB4118:EE_
x-ms-office365-filtering-correlation-id: f9c008f5-7566-44d8-6d60-08dcf1cde9ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cVJMajZteEtwcWplS2N3UG5hN3hBaS9pQkNoL2F4QnpzblF0ZG9PK1RtaTg1?=
 =?utf-8?B?TmJ0TngwMXFiOW11K3BybFlEbHlKSnFmQjAyaDBYRjM4Q3UxU1E0akFJUG5O?=
 =?utf-8?B?TDhGbDRlQzdSWStYWjJtV0wwNnZuV3NzcFdreFloSU5UODBFS0RFQzV6NDN6?=
 =?utf-8?B?MUVNQXlYNUFncjR0NzJjeU1MakluaGUxSjBhUWlwNjZLaGhLc0VUdWdnanRE?=
 =?utf-8?B?SS9kQzcrUS9JcGF4RHo5U3pVMkl2QUFjSFFVRHJzRVNiSHVaR1BveVBQaC9Z?=
 =?utf-8?B?YzlGVWlSMEp1RmxMcXlQNGw4dWJrNTMzRFBqNVhOUExBVG1oalFGN1NIYnEy?=
 =?utf-8?B?TkIya2sxU2t2dDdvRzhMS1NzdkhQZEEwcWN3UDFrZEI0a3oyTkxZcWhSNVVm?=
 =?utf-8?B?WllSbTRySmVPejU1OVdRRG5YczBKYTQ2bW04UEJYUm03SkFoOW9GVVFnOGpY?=
 =?utf-8?B?Z3BoQWRqdnhvNTRleWxlMXdsTFM4elRLWE12Y2dCNXRBazBJQ0JOTXhEamo2?=
 =?utf-8?B?WStINnRDZElCbjFmNGVwM1l3QXVBYkpHaVpzL0NOL2lXcjNrZDRpKzRESHMr?=
 =?utf-8?B?NzJtR1pXazBPT2NBMG5MdVo1WnZFUlZseFBSL1YrM1YvR2taQi9NRGVsTnRI?=
 =?utf-8?B?czNyYUQreXZ5d24rTFpoY2ZyUkdOOExBMHhGMm1ZTUZQdVZjZ1hVSnZXd1Ax?=
 =?utf-8?B?UUtxRW5YNTNGYUhCTHVyeXEzTmNTTFd1eXgzYUVVYThZNmhUU1lZR1FQOHZ1?=
 =?utf-8?B?cU5iODhnNW1LS2hPNEFtaVloWVgwZnpEUzlBYW93cU42cjd2TzdUTUtLV0VW?=
 =?utf-8?B?Y2pnbm1TWDNSSW9CRkFwNFFWRmcrbUo3KzNHWXgyUVhDeFpGQTNmRGd2SFow?=
 =?utf-8?B?QlZheVBMY2RsRHpxdFpQNFppaStHWnNKeWxiaE1BOEY4cVJmS3ZRbDF2K29T?=
 =?utf-8?B?MW11WlRrNkRnaUlDSENGRFkxWTF6Z2M4N2MrVk1YTlJvNXp2M2F1Myt4Y3pM?=
 =?utf-8?B?Y3ljRVlkN3F6aWRvNGhEQUJCY3BWUDYwaENyT0Q1NzU3QWVsNWFzNW5CM0lJ?=
 =?utf-8?B?amlpd1hkY3N1L0prOVRucmp5SVJVWHI2VHNsOGFZVDBuc3dXUERFdzN3UG8y?=
 =?utf-8?B?azN6ZFd0bnZYQlF6c0JuQS9kVlBRSkRPVXRodVZnSzhIVlVFRWhvTVB0WDdi?=
 =?utf-8?B?VHpuN1pORWhuZlN0eEE4OGkxNmgrcU0yOWdKTjA1YlVKeDFoaTFzYytacTNh?=
 =?utf-8?B?b2xHZk9XRUE5TythN0YwVWVLak5ZdCtMTzYxSmxNSUdJRTBSY2dzcW5UNnlL?=
 =?utf-8?B?cXE4ZXUyTEJYT1pObGE0dkFPbERmdm42OExHYXZER3dSYi9LVVA3ZkFteHV5?=
 =?utf-8?B?MWhzS1N2Q0E1Vjk1b1JGalRtYmJJYkp4WStoS3pTSG9ZazBsazBJZmRJUW5j?=
 =?utf-8?B?V3o3YlljT253YUlob2xvWFpIK094U0VZSmNDN2trajdaQkE0cXBrdUhmWmlE?=
 =?utf-8?B?ZzVhM1RpZzg4Y0ZFY3Q2TEJTb2VEbG9nb2VvMGgvN2xldm0xVGkxT1pVSSs5?=
 =?utf-8?B?aCtlSXNYWlZFSWNQbWdOQUUvQjJuKzQ0bFNMK1ZWU1lKYjVDMlEzaWswbHlU?=
 =?utf-8?B?U0JRQVN0aDZZZlZ2U0FYQW5CUlYzY0M0eVBOeS83TVhYRWF3U3lKL001UnZh?=
 =?utf-8?B?LzdZcHR3OUFNSHhBN3k5akhKYjQvVng4QUdVUS85ald6ZjdXek0veUo5aHZv?=
 =?utf-8?B?Q01FRmxxUUxUUjA0eEl1VlRsMHlWQ0kyOVdaVTg4WlFITDNmNHcwTmR0czFu?=
 =?utf-8?Q?+yYz4/0VFsbOrq/4AYwYeVk2DJHm+sDpVGRmo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Zk9sZ1JBYlFZNEtVOVhxVkVlLzBlZTdEUWtuRDMzd1pvRmFFSVJ2a2xBL3dy?=
 =?utf-8?B?a3lYUjRJVElDWUhadlVwMkhEcE1LZmxWZGQ1RUxsSTJMNHZoNzhKYXc4MER1?=
 =?utf-8?B?KzViVkx6Y3k5YUgrMW1ZeGs1Qmp0ekY5OUFjNU5ia0tMRWZ2SnlGclBjbmtI?=
 =?utf-8?B?SmtCWWNROXJnWkhld0RybG5MckxNMFJ4bmFWeFRsb2QxbVZTQkVha2lZTFRJ?=
 =?utf-8?B?MHJYc2tZUGtObzBMM09BQ1VzQjdWWjVLZHU5VUxIRHk3eU1WbW1xVmxhekQ5?=
 =?utf-8?B?OWg3TW0ySEEvcGovd0YvOU94WVgvU2liR0N2VmpLellrQkxxdmNjSVdTRllN?=
 =?utf-8?B?SlRTeTJwb1hpS0d1YW1lU3dqcTczdTNoSmdOZ2ZaS1RYay94UWszajdNVmFF?=
 =?utf-8?B?QVVwM05VYUhjU3NDQ0hNY3N3cHZrK1F1Z3JMRU5YTTgzRzZZTXZyMUIwSXBR?=
 =?utf-8?B?ZUZtcHI3RUxQRVc2YlRCWEp0cWZoRE9iRkJFZklmWEpuV05hVVZYQ0pUQU5G?=
 =?utf-8?B?QmJ0TWVNd0JuODIyK3UxdWM3VjlUUFBYS1RZT1JSSmRONFFlNVlULzQ5NHRY?=
 =?utf-8?B?STJadU9iVUw1WGozTVVkNkMwekkxNHRJMjQzMnNtVVJqUkpYdHc1dlhVZ2tT?=
 =?utf-8?B?d291akpCbFA2dDhIZlhMSjlKRlhTZjFGWDlVSXV1SjEvWHVBNVN1TmV4RERy?=
 =?utf-8?B?VkhGOHNPYmdpb1A5ZEtFNXNERTFINUZyT09PTHNKZVRjMkZaa3BwOEpsQ0Z5?=
 =?utf-8?B?UlBpZThidGMvUnRhMzNIYUdVd3phTTJOS21VUzhGY1BHQVQrbEJCQkxDUEZn?=
 =?utf-8?B?cHM2Nmo5ODVWNkRpTXVLZlhaUXFNY3ZiU3o3NkR4MWQ5UDJ4aytNc0ROYm44?=
 =?utf-8?B?bXFtTEVzemQ3L0w3Qjc3aUdjQmtSZVNsOUpkcmg4ZXFqcTRpcEFiTjg0cHE4?=
 =?utf-8?B?Uk5PWmRVSnBoZmhhcTVsd1Y5WTdmaWdiMGxYaGpBdUFkUG1ObXlPUjJtR3BZ?=
 =?utf-8?B?aUNkb3VIUHkwU1QzV2Jrajc2VjYrTlRYNnFzcmRJTFlxbkUwTXMyUHBxazNL?=
 =?utf-8?B?TkNGRWE5WjlFcUNOaHQrQUU0WjBFczRYcHcwc04xc29iUkhrcncwVWJTcmJF?=
 =?utf-8?B?T2JTOGx2cENhVUZrM3Fva0hHK3pVaEVQa2dSRTZjZ2h1Z3pZN3BaSnR4dnBZ?=
 =?utf-8?B?NmhjeWpaeFNJRWNId2pYV0QyVGkxUkxPTnJLL0xKaU5pWGF6ZzVta0xHR3Fv?=
 =?utf-8?B?ZXYrd1ZMcC95Uzh4VXJlQXk0N3BwQTlwTnFvMXI4VnIyMjhNTDVEOGxGOW5x?=
 =?utf-8?B?bVlieTlPUmsrb1hNK0pWdTBDTzZETFBrWElQa01FM1h1WVA1QnhzTk03THFE?=
 =?utf-8?B?VTFndzFodlNqSDBuaDRxSWdXYnkwU2tXYWRONjJjcGFDRzluSzZqOWVEd05T?=
 =?utf-8?B?b2QvUEZad2ZQTGNHLzk5d0VDZ0Y5UWsybThXUlp2Y2t4LzQyb2hHbzJoVnBs?=
 =?utf-8?B?YzhVc3pUbEhzU2k0OUdZc1Fxb0JpKzhRUEZuV1g5YmllaWFFaVZWTlRkdGEy?=
 =?utf-8?B?WUl2WUlockdDeElvS3MwTDJTS3FicDYxLzlJNzErTEs3UnBUaE9XSFJ2NlNW?=
 =?utf-8?B?V1NhTGY5Z3dTeCtmUEJGSkszc1lObjBFYnRJV1pVc2tDK1BaQU5RSzQ5aTRY?=
 =?utf-8?B?RkFvaVJ6TzdsN0JreEhQVkpPaExnZ0w4eGR0aDBFcmI0K080dW94TjA5QVBw?=
 =?utf-8?B?N1ltODRsdGRDVm84NkFid2RyMnBQUUZXa3B1MWNFbDJLSXRxY3hzOVVzUWhu?=
 =?utf-8?B?eEV3TjlrUWtYRTlYVG1tcVdac0hGaDVjVXhQS0kzNFpVdWx2aEZBU1RTM1pG?=
 =?utf-8?B?SGVxYXg2Mm5NTnZCNG9NYnNraThsUjNRT3Z3cC9LeVhVYzFaaWt4QW9IMWdm?=
 =?utf-8?B?UzNEYzVOYzd4KytTRitCYlYzVzEreGJaT0lqMi9VQUFjTnNVaXRBaGJmL1JE?=
 =?utf-8?B?QWlXb0YwT1lna2dVbERVY1FXZGk2Z3VtaUpCbkg1QTZyU05tNC9FZldiTy9r?=
 =?utf-8?B?SjBhaDB1SEtzelFjTTZrdHROS3NkWlNPRGk2d3d6QnE4R3ZnYk1tNVlpN0sv?=
 =?utf-8?Q?sY1U5oKDVO/okQYCp4TFwVtO0?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c008f5-7566-44d8-6d60-08dcf1cde9ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 12:43:07.5622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hlhNVRLs8X5dVtsXuvEPJ4cXSJ6osYmaakQIPEzJl8X56fUIlpM6s8GwICAGm/PhgSGoWjajxiI4Scj/CgzDJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4118
X-Proofpoint-GUID: qHfH_tbcAJZ4R08NLQnOis9dyttZZ06-
X-Proofpoint-ORIG-GUID: qHfH_tbcAJZ4R08NLQnOis9dyttZZ06-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEthbGVzaCBBbmFra3VyIFB1
cmF5aWwgPGthbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tPg0KPiBTZW50OiBNb25k
YXksIE9jdG9iZXIgMjEsIDIwMjQgOTowMSBBTQ0KPiBUbzogU2FpIEtyaXNobmEgR2FqdWxhIDxz
YWlrcmlzaG5hZ0BtYXJ2ZWxsLmNvbT4NCj4gQ2M6IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1h
emV0QGdvb2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsNCj4gcGFiZW5pQHJlZGhhdC5jb207IG5l
dGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IFN1
bmlsIEtvdnZ1cmkgR291dGhhbSA8c2dvdXRoYW1AbWFydmVsbC5jb20+OyBHZWV0aGFzb3dqYW55
YSBBa3VsYQ0KPiA8Z2FrdWxhQG1hcnZlbGwuY29tPjsgTGludSBDaGVyaWFuIDxsY2hlcmlhbkBt
YXJ2ZWxsLmNvbT47IEplcmluIEphY29iDQo+IDxqZXJpbmpAbWFydmVsbC5jb20+OyBIYXJpcHJh
c2FkIEtlbGFtIDxoa2VsYW1AbWFydmVsbC5jb20+OyBTdWJiYXJheWENCj4gU3VuZGVlcCBCaGF0
dGEgPHNiaGF0dGFAbWFydmVsbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbbmV0LW5leHQgUEFUQ0gg
Mi82XSBvY3Rlb250eDItYWY6IENOMjBrIGJhc2ljDQo+IG1ib3ggb3BlcmF0aW9ucyBhbmQgc3Ry
dWN0dXJlcw0KPiANCj4gT24gU2F0LCBPY3QgMTksIDIwMjQgYXQgMjowMuKAr0FNIFNhaSBLcmlz
aG5hIDxzYWlrcmlzaG5hZ0BtYXJ2ZWxsLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBUaGlzIHBh
dGNoIGFkZHMgYmFzaWMgbWJveCBvcGVyYXRpb24gQVBJcyBhbmQgc3RydWN0dXJlcyB0byBhZGQg
c3VwcG9ydA0KPiA+IGZvciBtYm94IG1vZHVsZSBvbiBDTjIwayBzaWxpY29uLiBUaGVyZSBhcmUg
ZmV3IENTUiBvZmZzZXRzLCBpbnRlcnJ1cHRzDQo+ID4gY2hhbmdlZCBiZXR3ZWVuIENOMjBrIGFu
ZCBwcmlvciBPY3Rlb24gc2VyaWVzIG9mIGRldmljZXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBTdW5pbCBLb3Z2dXJpIEdvdXRoYW0gPHNnb3V0aGFtQG1hcnZlbGwuY29tPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFNhaSBLcmlzaG5hIDxzYWlrcmlzaG5hZ0BtYXJ2ZWxsLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgLi4uL2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL01ha2VmaWxlICAgIHwgIDMg
Ky0NCj4gPiAgLi4uL2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL2NuMjBrL2FwaS5oIHwg
MjIgKysrKysrKw0KPiA+ICAuLi4vbWFydmVsbC9vY3Rlb250eDIvYWYvY24yMGsvbWJveF9pbml0
LmMgICAgfCA1MiArKysrKysrKysrKysrKysNCj4gPiAgLi4uL2V0aGVybmV0L21hcnZlbGwvb2N0
ZW9udHgyL2FmL2NuMjBrL3JlZy5oIHwgMjcgKysrKysrKysNCj4gPiAgLi4uL25ldC9ldGhlcm5l
dC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9tYm94LmMgIHwgIDMgKw0KPiA+ICAuLi4vbmV0L2V0aGVy
bmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL21ib3guaCAgfCAgNyArKw0KPiA+ICAuLi4vbmV0L2V0
aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2dS5jICAgfCA2NSArKysrKysrKysrKysrKyst
LS0tDQo+ID4gIC4uLi9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvYWYvcnZ1LmggICB8
IDIyICsrKysrKysNCj4gPiAgLi4uL21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2dV9zdHJ1Y3QuaCAg
ICAgICAgIHwgIDYgKy0NCj4gPiAgOSBmaWxlcyBjaGFuZ2VkLCAxOTIgaW5zZXJ0aW9ucygrKSwg
MTUgZGVsZXRpb25zKC0pDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBkcml2ZXJzL25ldC9l
dGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9jbjIway9hcGkuaA0KPiA+ICBjcmVhdGUgbW9k
ZSAxMDA2NDQNCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvYWYvY24y
MGsvbWJveF9pbml0LmMNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+IGRyaXZlcnMvbmV0L2V0
aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL2NuMjBrL3JlZy5oDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvYWYvTWFrZWZpbGUN
Cj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9NYWtlZmlsZQ0K
PiA+IGluZGV4IDNjZjRjODI4NWM5MC4uMzhkODU5OWRjNmViIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL01ha2VmaWxlDQo+ID4gKysr
IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvYWYvTWFrZWZpbGUNCj4g
PiBAQCAtMTEsNCArMTEsNSBAQCBydnVfbWJveC15IDo9IG1ib3gubyBydnVfdHJhY2Uubw0KPiA+
ICBydnVfYWYteSA6PSBjZ3gubyBydnUubyBydnVfY2d4Lm8gcnZ1X25wYS5vIHJ2dV9uaXgubyBc
DQo+ID4gICAgICAgICAgICAgICAgICAgcnZ1X3JlZy5vIHJ2dV9ucGMubyBydnVfZGVidWdmcy5v
IHB0cC5vIHJ2dV9ucGNfZnMubyBcDQo+ID4gICAgICAgICAgICAgICAgICAgcnZ1X2NwdC5vIHJ2
dV9kZXZsaW5rLm8gcnBtLm8gcnZ1X2NuMTBrLm8gcnZ1X3N3aXRjaC5vIFwNCj4gPiAtICAgICAg
ICAgICAgICAgICBydnVfc2RwLm8gcnZ1X25wY19oYXNoLm8gbWNzLm8gbWNzX3J2dV9pZi5vIG1j
c19jbmYxMGtiLm8NCj4gPiArICAgICAgICAgICAgICAgICBydnVfc2RwLm8gcnZ1X25wY19oYXNo
Lm8gbWNzLm8gbWNzX3J2dV9pZi5vIG1jc19jbmYxMGtiLm8gXA0KPiA+ICsgICAgICAgICAgICAg
ICAgIGNuMjBrL21ib3hfaW5pdC5vDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL2NuMjBrL2FwaS5oDQo+IGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvYWYvY24yMGsvYXBpLmgNCj4gPiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uYjU3YmQzODE4MWFhDQo+ID4gLS0tIC9k
ZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgy
L2FmL2NuMjBrL2FwaS5oDQo+ID4gQEAgLTAsMCArMSwyMiBAQA0KPiA+ICsvKiBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMCAqLw0KPiA+ICsvKiBNYXJ2ZWxsIFJWVSBBZG1pbiBGdW5j
dGlvbiBkcml2ZXINCj4gPiArICoNCj4gPiArICogQ29weXJpZ2h0IChDKSAyMDI0IE1hcnZlbGwu
DQo+ID4gKyAqDQo+ID4gKyAqLw0KPiA+ICsNCj4gPiArI2lmbmRlZiBDTjIwS19BUElfSA0KPiA+
ICsjZGVmaW5lIENOMjBLX0FQSV9IDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSAiLi4vcnZ1LmgiDQo+
ID4gKw0KPiA+ICtzdHJ1Y3QgbmdfcnZ1IHsNCj4gPiArICAgICAgIHN0cnVjdCBtYm94X29wcyAg
ICAgICAgICpydnVfbWJveF9vcHM7DQo+ID4gKyAgICAgICBzdHJ1Y3QgcW1lbSAgICAgICAgICAg
ICAqcGZfbWJveF9hZGRyOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArLyogTWJveCByZWxhdGVkIEFQ
SXMgKi8NCj4gPiAraW50IGNuMjBrX3J2dV9tYm94X2luaXQoc3RydWN0IHJ2dSAqcnZ1LCBpbnQg
dHlwZSwgaW50IG51bSk7DQo+ID4gK2ludCBjbjIwa19ydnVfZ2V0X21ib3hfcmVnaW9ucyhzdHJ1
Y3QgcnZ1ICpydnUsIHZvaWQgKiptYm94X2FkZHIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGludCBudW0sIGludCB0eXBlLCB1bnNpZ25lZCBsb25nICpwZl9ibWFwKTsNCj4g
PiArI2VuZGlmIC8qIENOMjBLX0FQSV9IICovDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL2NuMjBrL21ib3hfaW5pdC5jDQo+IGIvZHJp
dmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvYWYvY24yMGsvbWJveF9pbml0LmMN
Cj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uMGQ3YWQz
MWU1ZGZiDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0
L21hcnZlbGwvb2N0ZW9udHgyL2FmL2NuMjBrL21ib3hfaW5pdC5jDQo+ID4gQEAgLTAsMCArMSw1
MiBAQA0KPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+ICsvKiBN
YXJ2ZWxsIFJWVSBBZG1pbiBGdW5jdGlvbiBkcml2ZXINCj4gPiArICoNCj4gPiArICogQ29weXJp
Z2h0IChDKSAyMDI0IE1hcnZlbGwuDQo+ID4gKyAqDQo+ID4gKyAqLw0KPiA+ICsNCj4gPiArI2lu
Y2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvaXJxLmg+DQo+
ID4gKw0KPiA+ICsjaW5jbHVkZSAicnZ1X3RyYWNlLmgiDQo+ID4gKyNpbmNsdWRlICJtYm94Lmgi
DQo+ID4gKyNpbmNsdWRlICJyZWcuaCINCj4gPiArI2luY2x1ZGUgImFwaS5oIg0KPiA+ICsNCj4g
PiAraW50IGNuMjBrX3J2dV9nZXRfbWJveF9yZWdpb25zKHN0cnVjdCBydnUgKnJ2dSwgdm9pZCAq
Km1ib3hfYWRkciwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IG51bSwg
aW50IHR5cGUsIHVuc2lnbmVkIGxvbmcgKnBmX2JtYXApDQo+ID4gK3sNCj4gPiArICAgICAgIGlu
dCByZWdpb247DQo+ID4gKyAgICAgICB1NjQgYmFyOw0KPiA+ICsNCj4gPiArICAgICAgIGZvciAo
cmVnaW9uID0gMDsgcmVnaW9uIDwgbnVtOyByZWdpb24rKykgew0KPiA+ICsgICAgICAgICAgICAg
ICBpZiAoIXRlc3RfYml0KHJlZ2lvbiwgcGZfYm1hcCkpDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgY29udGludWU7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICBiYXIgPSAodTY0KXBo
eXNfdG9fdmlydCgodTY0KXJ2dS0+bmdfcnZ1LT5wZl9tYm94X2FkZHItPmJhc2UpOw0KPiA+ICsg
ICAgICAgICAgICAgICBiYXIgKz0gcmVnaW9uICogTUJPWF9TSVpFOw0KPiA+ICsNCj4gPiArICAg
ICAgICAgICAgICAgbWJveF9hZGRyW3JlZ2lvbl0gPSAodm9pZCAqKWJhcjsNCj4gPiArDQo+ID4g
KyAgICAgICAgICAgICAgIGlmICghbWJveF9hZGRyW3JlZ2lvbl0pDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgZ290byBlcnJvcjsNCj4gW0thbGVzaF0gTWF5YmUgeW91IGNhbiByZXR1cm4g
ZGlyZWN0bHkgZnJvbSBoZXJlIGFzIHRoZXJlIGlzIG5vDQo+IGNsZWFudXAgYWN0aW9uIHBlcmZv
cm1lZCB1bmRlciB0aGUgbGFiZWwuDQoNCkFjaywgd2lsbCBzdWJtaXQgVjIgcGF0Y2ggd2l0aCB0
aGUgc3VnZ2VzdGVkIGNoYW5nZXMuDQoNCj4gPiArICAgICAgIH0NCj4gPiArICAgICAgIHJldHVy
biAwOw0KPiA+ICsNCj4gPiArZXJyb3I6DQo+ID4gKyAgICAgICByZXR1cm4gLUVOT01FTTsNCj4g
PiArfQ0KPiA+ICsNCj4gPiAraW50IGNuMjBrX3J2dV9tYm94X2luaXQoc3RydWN0IHJ2dSAqcnZ1
LCBpbnQgdHlwZSwgaW50IG5kZXZzKQ0KPiA+ICt7DQo+ID4gKyAgICAgICBpbnQgZGV2Ow0KPiA+
ICsNCj4gPiArICAgICAgIGlmICghaXNfY24yMGsocnZ1LT5wZGV2KSkNCj4gPiArICAgICAgICAg
ICAgICAgcmV0dXJuIDA7DQo+ID4gKw0KDQouLi4NCi4uLg0KDQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2dS5oDQo+IGIvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvYWYvcnZ1LmgNCj4gPiBpbmRleCA5Mzhh
OTExY2JmMWMuLjlmZDdhZWE4YzQ4MSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhl
cm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnUuaA0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0
aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2dS5oDQo+ID4gQEAgLTQ0NCw2ICs0NDQsMTAg
QEAgc3RydWN0IG1ib3hfd3FfaW5mbyB7DQo+ID4gICAgICAgICBzdHJ1Y3Qgd29ya3F1ZXVlX3N0
cnVjdCAqbWJveF93cTsNCj4gPiAgfTsNCj4gPg0KPiA+ICtzdHJ1Y3QgbWJveF9vcHMgew0KPiA+
ICsgICAgICAgaXJxcmV0dXJuX3QgKCpwZl9pbnRyX2hhbmRsZXIpKGludCBpcnEsIHZvaWQgKnJ2
dV9pcnEpOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAgc3RydWN0IGNoYW5uZWxfZndkYXRhIHsNCj4g
PiAgICAgICAgIHN0cnVjdCBzZHBfbm9kZV9pbmZvIGluZm87DQo+ID4gICAgICAgICB1OCB2YWxp
ZDsNCj4gPiBAQCAtNTk0LDYgKzU5OCw3IEBAIHN0cnVjdCBydnUgew0KPiA+ICAgICAgICAgc3Bp
bmxvY2tfdCAgICAgICAgICAgICAgY3B0X2ludHJfbG9jazsNCj4gPg0KPiA+ICAgICAgICAgc3Ry
dWN0IG11dGV4ICAgICAgICAgICAgbWJveF9sb2NrOyAvKiBTZXJpYWxpemUgbWJveCB1cCBhbmQg
ZG93biBtc2dzICovDQo+ID4gKyAgICAgICBzdHJ1Y3QgbmdfcnZ1ICAgICAgICAgICAqbmdfcnZ1
Ow0KPiA+ICB9Ow0KPiA+DQo+ID4gIHN0YXRpYyBpbmxpbmUgdm9pZCBydnVfd3JpdGU2NChzdHJ1
Y3QgcnZ1ICpydnUsIHU2NCBibG9jaywgdTY0IG9mZnNldCwgdTY0IHZhbCkNCj4gPiBAQCAtODc1
LDExICs4ODAsMjggQEAgc3RhdGljIGlubGluZSBib29sIGlzX2NneF92ZihzdHJ1Y3QgcnZ1ICpy
dnUsIHUxNg0KPiBwY2lmdW5jKQ0KPiA+ICAgICAgICAgICAgICAgICBpc19wZl9jZ3htYXBwZWQo
cnZ1LCBydnVfZ2V0X3BmKHBjaWZ1bmMpKSk7DQo+ID4gIH0NCj4gPg0KPiA+ICsjZGVmaW5lIENO
MjBLX0NISVBJRCAgIDB4MjANCj4gPiArDQo+ID4gKy8qDQo+ID4gKyAqIFNpbGljb24gY2hlY2sg
Zm9yIENOMjBLIGZhbWlseQ0KPiA+ICsgKi8NCj4gPiArc3RhdGljIGlubGluZSBib29sIGlzX2Nu
MjBrKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQ0KPiA+ICt7DQo+ID4gKyAgICAgICBpZiAoKHBkZXYt
PnN1YnN5c3RlbV9kZXZpY2UgJiAweEZGKSA9PSBDTjIwS19DSElQSUQpDQo+ID4gKyAgICAgICAg
ICAgICAgIHJldHVybiB0cnVlOw0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiBmYWxzZTsNCj4g
W0thbGVzaF0gWW91IGNhbiBzaW1wbGlmeSB0aGlzIGFzOg0KPiByZXR1cm4gKHBkZXYtPnN1YnN5
c3RlbV9kZXZpY2UgJiAweEZGKSA9PSBDTjIwS19DSElQSUQ7DQoNCkFjaywgd2lsbCBzdWJtaXQg
VjIgcGF0Y2ggd2l0aCB0aGUgc3VnZ2VzdGVkIGNoYW5nZXMuDQoNCj4gPiArfQ0KPiA+ICsNCj4g
PiAgI2RlZmluZSBNKF9uYW1lLCBfaWQsIGZuX25hbWUsIHJlcSwgcnNwKSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBcDQo+ID4gIGludCBydnVfbWJveF9oYW5kbGVyXyAjIyBmbl9uYW1l
KHN0cnVjdCBydnUgKiwgc3RydWN0IHJlcSAqLCBzdHJ1Y3QgcnNwICopOw0KPiA+ICBNQk9YX01F
U1NBR0VTDQo+ID4gICN1bmRlZiBNDQo+ID4NCj4gPiArLyogTWJveCBBUElzICovDQo+ID4gK3Zv
aWQgcnZ1X3F1ZXVlX3dvcmsoc3RydWN0IG1ib3hfd3FfaW5mbyAqbXcsIGludCBmaXJzdCwNCj4g
PiArICAgICAgICAgICAgICAgICAgIGludCBtZGV2cywgdTY0IGludHIpOw0KPiA+ICsNCj4gPiAg
aW50IHJ2dV9jZ3hfaW5pdChzdHJ1Y3QgcnZ1ICpydnUpOw0KPiA+ICBpbnQgcnZ1X2NneF9leGl0
KHN0cnVjdCBydnUgKnJ2dSk7DQo+ID4gIHZvaWQgKnJ2dV9jZ3hfcGRhdGEodTggY2d4X2lkLCBz
dHJ1Y3QgcnZ1ICpydnUpOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9t
YXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnVfc3RydWN0LmgNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5l
dC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnVfc3RydWN0LmgNCj4gPiBpbmRleCBmYzhkYTIwOTA2
NTcuLjkwY2IwNjNkMDBmMCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9t
YXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnVfc3RydWN0LmgNCj4gPiArKysgYi9kcml2ZXJzL25ldC9l
dGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnVfc3RydWN0LmgNCj4gPiBAQCAtMzMsNyAr
MzMsOCBAQCBlbnVtIHJ2dV9ibG9ja19hZGRyX2Ugew0KPiA+ICAgICAgICAgQkxLQUREUl9ORENf
TklYMV9SWCAgICAgPSAweDEwVUxMLA0KPiA+ICAgICAgICAgQkxLQUREUl9ORENfTklYMV9UWCAg
ICAgPSAweDExVUxMLA0KPiA+ICAgICAgICAgQkxLQUREUl9BUFIgICAgICAgICAgICAgPSAweDE2
VUxMLA0KPiA+IC0gICAgICAgQkxLX0NPVU5UICAgICAgICAgICAgICAgPSAweDE3VUxMLA0KPiA+
ICsgICAgICAgQkxLQUREUl9NQk9YICAgICAgICAgICAgPSAweDFiVUxMLA0KPiA+ICsgICAgICAg
QkxLX0NPVU5UICAgICAgICAgICAgICAgPSAweDFjVUxMLA0KPiA+ICB9Ow0KPiA+DQo+ID4gIC8q
IFJWVSBCbG9jayBUeXBlIEVudW1lcmF0aW9uICovDQo+ID4gQEAgLTQ5LDcgKzUwLDggQEAgZW51
bSBydnVfYmxvY2tfdHlwZV9lIHsNCj4gPiAgICAgICAgIEJMS1RZUEVfVElNICA9IDB4OCwNCj4g
PiAgICAgICAgIEJMS1RZUEVfQ1BUICA9IDB4OSwNCj4gPiAgICAgICAgIEJMS1RZUEVfTkRDICA9
IDB4YSwNCj4gPiAtICAgICAgIEJMS1RZUEVfTUFYICA9IDB4YSwNCj4gPiArICAgICAgIEJMS1RZ
UEVfTUJPWCA9IDB4MTMsDQo+ID4gKyAgICAgICBCTEtUWVBFX01BWCAgPSAweDEzLA0KPiA+ICB9
Ow0KPiA+DQo+ID4gIC8qIFJWVSBBZG1pbiBmdW5jdGlvbiBJbnRlcnJ1cHQgVmVjdG9yIEVudW1l
cmF0aW9uICovDQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0KPiA+DQo+IA0KPiANCj4gLS0NCj4g
UmVnYXJkcywNCj4gS2FsZXNoIEEgUA0K

