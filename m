Return-Path: <netdev+bounces-152674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C16D69F555A
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 19:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F02716F56D
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 17:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C591FA840;
	Tue, 17 Dec 2024 17:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="oPAAM0KB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D751F7563;
	Tue, 17 Dec 2024 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457789; cv=fail; b=CdYulO8CgKvGjW6n2qWTbenKmWswfn3u4uI5AOVSZqmRYQBAQDILqIhhmmuYloimXgoRUJXWaya2Rdxz1YYUjVe9bjfgjmP2F3nC/mJ7tzYYZFYENT8IKk8SV7hn4cVw5dDOh0HbNYM52G6p7uf6QANSu3nbrX111muLhmQM3Nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457789; c=relaxed/simple;
	bh=E1Oh7V19OYHCGxt9JR0pgXHBdGB8mqJU5c8NdNA7Bww=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lSmJrYd95V5qsb5MA7QbH0M3DGW5RvXRlVHCWz4dHHrpucE1IaGxVCPlozr+6sdsSoLQCkw7uttRRVIngD5Hm/5sCdMlaTnsAmKSTfgFwit6Pu5VmeldgEyNgXtGf4FCVB6+JKcoVHFehyfr7xDULRyBlirbhGEXQUDfH4L2CI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=oPAAM0KB; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHGHOZP012997;
	Tue, 17 Dec 2024 09:49:16 -0800
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 43kcpfr80v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 09:49:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfZvXz2NhoeEMkIskB7I179KMiPzDGI86Q3Kv3x+2bH91HychpLXWj3hxsshILokt9+3VJHCxWw0zPaup7siohZhYd2aaWCAlwBWU3VydRkYVf21CtXz1IaPFJafpefQfJofJrzcGKfOp5qh73SVtYYgKNFK6olYZUfw+zXttpp0Jo6s1SQVzkXVbz7YCJZVPw1g6THbSMMgIQLIgJx+7/yuW7Jh4bFO0wL6wCGBr8fhxDRhwIN0gEMddXfjSCLL6I46jGW8dlerxYAmVp6dzq30LSitg6Vs7ACXvbjzPpJZ16OY2ApEF6WKmmEHodBEO7qgfVn5svzHwnISpLcSyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1Oh7V19OYHCGxt9JR0pgXHBdGB8mqJU5c8NdNA7Bww=;
 b=D1PEp+ZOCu0a3/b93q7p8EebYXSH1fa6bllTDY3tXx1atutUn3K9XC+rMaZPPmlqJO9yd+wOoWjEFu7qKnl8OdeXKI5x+NEDxdVz/eih/yvc0Thbn/QPwWSM5UxBayALVCiNcnHj+EhkPen9+L5cNTVf5WC5SIUVFyFQNsoAVO208vMLIKLOqhFLfkaa9CX6+i77/oHaGCKAiBjjPdUnqx5ka5xVx+aGxd+GZ0pacFil8sasjCq4A2mE470+tsjmki3nKiFy1M8lSDhvhonylEToYOlZZ4y7CbatVpW+CyNuobAoHDbE6bhFMMv6LlWEIaBEgpL/2qMhwNL5grpgdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1Oh7V19OYHCGxt9JR0pgXHBdGB8mqJU5c8NdNA7Bww=;
 b=oPAAM0KBopD+hw2/61/X7DiOYVzotOLB7AH5nrNmMXP57OLUELbITIrgRrv7mhQpADQJtSHIjg8kVmIpNTVspKNfH/g/Kr87bEW6GJ/3DSLj+BnnV35ko107/rMYsPotlhr+RHWbakgqoxo29O8KadaU86kHK3Pku9JlHc49Xi0=
Received: from CO1PR18MB4729.namprd18.prod.outlook.com (2603:10b6:303:e8::13)
 by SN7PR18MB3808.namprd18.prod.outlook.com (2603:10b6:806:10b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 17:49:14 +0000
Received: from CO1PR18MB4729.namprd18.prod.outlook.com
 ([fe80::3fc5:bf52:d1d0:3d9e]) by CO1PR18MB4729.namprd18.prod.outlook.com
 ([fe80::3fc5:bf52:d1d0:3d9e%7]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 17:49:14 +0000
From: Shinas Rasheed <srasheed@marvell.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haseeb Gani
	<hgani@marvell.com>, Sathesh B Edara <sedara@marvell.com>,
        Vimlesh Kumar
	<vimleshk@marvell.com>,
        "thaller@redhat.com" <thaller@redhat.com>,
        "wizhao@redhat.com" <wizhao@redhat.com>,
        "kheib@redhat.com"
	<kheib@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "einstein.xue@synaxg.com"
	<einstein.xue@synaxg.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew
 Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        Abhijit Ayarekar <aayarekar@marvell.com>,
        Satananda
 Burla <sburla@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH net v2 1/4] octeon_ep: fix race conditions
 in ndo_get_stats64
Thread-Topic: [EXTERNAL] Re: [PATCH net v2 1/4] octeon_ep: fix race conditions
 in ndo_get_stats64
Thread-Index: AQHbT5BaYIqjRH+Vi0yNdgQ+YpYURrLo7ucAgAAEnACAAD0IMIABfHCAgAAKTTA=
Date: Tue, 17 Dec 2024 17:49:13 +0000
Message-ID:
 <CO1PR18MB472973A60723E9417FE1BB87C7042@CO1PR18MB4729.namprd18.prod.outlook.com>
References: <20241216075842.2394606-1-srasheed@marvell.com>
 <20241216075842.2394606-2-srasheed@marvell.com>
 <Z2A5dHOGhwCQ1KBI@lzaremba-mobl.ger.corp.intel.com>
 <Z2A9UmjW7rnCGiEu@lzaremba-mobl.ger.corp.intel.com>
 <BY3PR18MB4721712299EAB0ED37CCEEEFC73B2@BY3PR18MB4721.namprd18.prod.outlook.com>
 <Z2GvpzRDSTjkzFxO@lzaremba-mobl.ger.corp.intel.com>
In-Reply-To: <Z2GvpzRDSTjkzFxO@lzaremba-mobl.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4729:EE_|SN7PR18MB3808:EE_
x-ms-office365-filtering-correlation-id: fd07866f-0a6c-430b-9061-08dd1ec31ec3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NDVxTXRJeFZFNUM0UXIvYmV6WmEzZndNdlNGTm9rVFBoQ25vN2RQOVd3cHds?=
 =?utf-8?B?MTRRTzljS2o3c3EwWU41TmhSS1U2WHBIZkVRTmlwb1ZiUFlHQTZRNW9MUXEz?=
 =?utf-8?B?cmJINk9GUE5Lcm03eU1TR3RvbzAwSlNUTHM3d0oxK2pUcnJseUpDQVk4Q0xJ?=
 =?utf-8?B?em1jcnorTDdKUkhjREpmc2tQOUhBN3ZWYnBIRUdOQXRNQ0tqWjAxc1ZsbkVL?=
 =?utf-8?B?QkVtcTRrWVRCYmhuMWlEakZMMEZ5Ymt0NGFWZkp6bDg0cmVQdXZMYjFEQzN6?=
 =?utf-8?B?cFE3cGgvN2RqRVpIcjIrNHQxaFZUeU85YWFFMzZXcHpxQjZRN3MzQ2FiN0pt?=
 =?utf-8?B?RU5melR1cTJWSnYxazBubDh3SDduK1RmUUk1VDcyQlFidVN0amplcmxaVTMw?=
 =?utf-8?B?MW1UV1dyYUg1UFNrQnkyVjN6SUFTVEVGOTdqWFpkTDZpbWpxRjVnVnFaczgz?=
 =?utf-8?B?RGJWK2g1eUJKWjZzUFBKeGowcGhQeTNoMmc4d0l3ejBreUNXTERhYzQvNVda?=
 =?utf-8?B?YW9PakVsQ2N0Q3RzVkt2ZHJ0Z3BFVVFsQXUvNmhjN3lMZW5mWHhEdW9uM2k0?=
 =?utf-8?B?U3M5aDBjcUdONlVoV2V0OHZRUTRPWmR1ejlNQ01SRlo1YWZJZ3VYZzZQeHBy?=
 =?utf-8?B?SGQ1SWV0RmJmR1JuUmRKb0ZQVXdvRzgxeU14enZBa3FrZjVoV2FkVmwwYVBL?=
 =?utf-8?B?WkNHb2cxay92NlFnNDVycmtVY3NzWVg4YitKWDh2V1BVK1NJek5KdUhaNlRT?=
 =?utf-8?B?MGpaOTU4Z2pFWUp4KzNXNEFSS2FmeWF0TkgrNzN3YnFUQ3BYeDhZMHMvYUR3?=
 =?utf-8?B?d2VMZTlKTlBVZDBVVUJCN3hMdVEwWndJT09qdEpOUmJMeDBVWG16V2lyS2hj?=
 =?utf-8?B?MXhobU8zRlMxbTQxUlYwZ2ZEOThWd3FIMVc5OEVKMWczUEJVNmtDcS94VzQw?=
 =?utf-8?B?Q3dBT1FLYVE4RnNBZVBWZTduTnhtT01yT1ZyaXVjd09xOTNmYjUwUEN5ZzdV?=
 =?utf-8?B?dkNTb1dEa0RpZUpqQnR6dUx2a3FnanE4WXhwbUYwdXJVd2NXSUpXdTY3L2dh?=
 =?utf-8?B?MG90YTFXeTg5bGg2NDNiZUtpSFZ3RG16R3NBNnBaTnV1aTJ5ZUFCWldxUlJR?=
 =?utf-8?B?WVZOaTlWWXB3SHdHdDk0Sms3QjVPQWtVbFpkcHZYbWEyY1c2aVQrTWlIQjNh?=
 =?utf-8?B?dGhHZTRlQlR1cG1aM1lDR2JKSHI4K3lhc3lUZGtSM3RjT0Z2MWc5WVVwUk1T?=
 =?utf-8?B?czYrM212dGZiWHhZcEpGNURwYlBKV3MrVmJYYkxtSDVUZzVhNi91SXRSYXFQ?=
 =?utf-8?B?Mk9GR3N5cml1OGZub2ZBUVFMNkhKWmVNUXhWUk4yeStIZkptSHBtb0JsK2hJ?=
 =?utf-8?B?U0tHNFM2cXVONUtqRVl6NUZucU5TekdoS0tQcXlYTHorbFhYeStYYy9JbzVU?=
 =?utf-8?B?ZUNyZ3FMWTN0UHJ5ZndBU010cnJaTUlNOWkrOXZMU0V6bVE0ZndJUlhGMUkx?=
 =?utf-8?B?SFFWNldDdEhESG9BVXpTRkVUR3dIaXF1aFNPa2QvUUVCdVg1TlBybEdUTnlW?=
 =?utf-8?B?V2tqeEZIdUVEL2RHSVNuWkFjRnV6cDhyUXBWQmxjTytSd3diZ05IdzVLUElH?=
 =?utf-8?B?RXk4dktHVU4vYnhtL2VYNUlqZkQ5ZitQQ2hFbmJsUHhVVzV5emFsVDR4WVJ2?=
 =?utf-8?B?RUR2SWRpTm9JRE92NzUvdFJ3Uk84YUNyaERLaHZ2V0ovYnZOTHpFVWlVUjlK?=
 =?utf-8?B?ckUraGhZU21CVHhzd0xUaXF0ZkJYd21xdVU2LzRQZnd2UlNycjFENGtrV01k?=
 =?utf-8?B?aVVwWURocGtDbjRVNHdUUk1TZ040SmtvWisyV25iZ1NrZWZoeHlvMjloRWNh?=
 =?utf-8?B?cFNUb2RwcDFTVmFIK3V6VSt1S1I1T0o2K3FUUEdZYUlVNWlid1p6ajRHLzZm?=
 =?utf-8?Q?tBreD8Ot+3jVH1vNW4x/UTzTfzTZkHyN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4729.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y2NDU3Y3bWVPRnU2dHpvcWZBeVRDdm1wRGNqVTllNWJNd1lYeldVUEhvWlN6?=
 =?utf-8?B?UVZ3T2RiUzJpTXFTczFoNlhCMjBORkRxRjIreVRrSklNUC9ON1hwNXY1R3BK?=
 =?utf-8?B?cFM2eDJUaklXU3kvbGFMOWlZLzlVc3FjNUlja3pJRERjTTdHeWZWMklWMlZ6?=
 =?utf-8?B?bHR4TkNYN3JRRlhZcDVwU0ZFOFhUZzRMV0JDZUdVL25EblJRS2xHZHdydXhi?=
 =?utf-8?B?NlF2enorcHFPbGpRWmhEemZWUERmWFNYNHlrTi9KWUV5UGJYV1k4bU9ud3d4?=
 =?utf-8?B?Zm44NUJ2NEpTWDZXNi84ZkU3ODIvL3RIaTFiVXA1bkdaRnZtcU5BSGtxVzRi?=
 =?utf-8?B?a1Jtaml3bm1hLzFZSnRqTWFzQ3NCRytGYzlXcTZkL0VWYWZTY3haTjBhMS9W?=
 =?utf-8?B?TU1QVVFnWHQwLzRrU2dWY2xjVFNiTHNvZmM1RTdzMHV4ZFJjMlJaUmNqaDBN?=
 =?utf-8?B?U0tqRGNFQUFEdDdPdVBBNkw0Mi9wcjJTeEVnWkNHVTh1bVNEK21pcFYxSmRE?=
 =?utf-8?B?MlozVkV6dmZMOE5IZVhsc2hjSHIyekdkNFpBZ01XLzNsVmhGWFI2QW9DcFEx?=
 =?utf-8?B?TzhZVHBvSDdPNXQzd3NwTlRtY2xxS25QbjhRS2JMVXlYNXNIZ1VzejE0dFg0?=
 =?utf-8?B?VWxVZXRaWk8wUG4wc1JjZHZDZG1heGpVM0xHVWFUb2k1bk1HMmlXZ1NiTnJK?=
 =?utf-8?B?Wm0xVktiOHROL3hsMTdLMzBaQnl1c3FxWDdiZVlIblI3RGxJYVdwWWswQ0NY?=
 =?utf-8?B?ZzhjYlNNcmJLSFBqWG14NUNTQzRqMU5VNU1FTzVLQW9TRjFnYkh1RGxPN3p1?=
 =?utf-8?B?eWFyZ1R5VDlrR1BxeVV1UzcrTG1JdHNIYyt6QXB5a1lldEZGSWp1aDBUTCtx?=
 =?utf-8?B?c2hXM3dpYVhvLzBwR0dLTGJUeVg5UUp6ek4xbDRmYmdoN2NrSUxrVWplRGxp?=
 =?utf-8?B?b2JrQ2ltK2JNUXlwOW1lTU5hR0FDajFoZCtZcFlGK3lQcVdkZVA1cklTSFRK?=
 =?utf-8?B?MFAyL2lDNWt5d2tHaHNlMjhLQzQ4UjFoY2FnWXNaRkRaem5NeWo1V1M5Ymhw?=
 =?utf-8?B?TmNQNjdIeGN5TlRtRXd6akpSbDFFYkZ3ZEhzbUI3RXhFT1Z2MmtIU1Y0QVBT?=
 =?utf-8?B?M0lIRmNRZ1BkWEp0YjVhellaTXgyQlB5OFpFdGQvS1V0TVN0VUtCNklvd2pk?=
 =?utf-8?B?QWI1VHR0RW9rSVBkMHhqYUt1V3ArbGsyOWYvNWxDekJJOE9Sb2ZLNVV1UWdG?=
 =?utf-8?B?a3hZQUFxTjJHRjlXNzZTazBhTTcwNXQya05KV0dHbzZOd3Jpei9GOTV0S1Fs?=
 =?utf-8?B?UTZVeFVxKzExWVoyNi9DNjZCdjcvUFdSUmpaRFhOamFlQXhlS3BBcktUQXhz?=
 =?utf-8?B?UUZ5K3JEcTBXSUFEbGdwTUFENzN5dzR2amFtQlM0QTREeUU4UXVUaURLVU8z?=
 =?utf-8?B?WUx4dnZGUG1nVExjSkw2em5CVDYzZDEvVzZZbzNYaUkvUzd4Qy9RVUFNMmtV?=
 =?utf-8?B?cW9SMlU3UTR3RVNtajhNallUc2VVSTVKdzltbWtKa2RDYzhuWW9SSVd3YVJ5?=
 =?utf-8?B?R1pQOWpNL1BQVmxkd1J4bnAwbEtKMDNzWndLdjhwWmtMTVdyMi9SclhzQWVD?=
 =?utf-8?B?OVBIamlKRUV1QzZ5UnhNV1dicjY5amVPd3p5aGxJby93dkxISjQwK1ppWU1O?=
 =?utf-8?B?eDJJS3pvTFcvU1IyZGxnV2RQeWNzdlhuQUZTRFYrazFlMndlVlpBWGpPVXlB?=
 =?utf-8?B?U0hhMGxCcWJEVDRJc1dOaXc3Z0FldnEyZGNVMStnZkNtV1dGMHN4QXVvZUEy?=
 =?utf-8?B?dzN4U29Vd3VPdytFamxUYzlPUFNpckJWZEhSNjFURDVBQTVBQmEyU2lHRHZo?=
 =?utf-8?B?VU5HdGp5NFVRQzMzaGtzVTZheUFPTitTZ0EyUERpVDBidDhubHh3bWVqa01V?=
 =?utf-8?B?M3lUaXh0WGZCVDh5Ly9EbHhkdFdtUUdRU3ZteHdtN0NxeXYvd3IwTjhaa0ho?=
 =?utf-8?B?VitWNk1VS05DaWRLclpyOSs4VUJwbU4xeStCclk4aUo2SlZKR00zeU1ydldV?=
 =?utf-8?B?bms2aFBxY3lEUTEwY2M1NW43b0ZOZm9lRVY1YXowK0JKd2grVWlaRmF0QzVH?=
 =?utf-8?Q?zVO7TvOxkwREfykkzgU+RVawe?=
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
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4729.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd07866f-0a6c-430b-9061-08dd1ec31ec3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 17:49:13.9672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eUkeDibKU77V4RRPUTQ8KUN69NzuMI2MWOvtpl46bh0tHxINlj6oizUMpIcgWcQb3rNyzApHL2Zl84OUS4kHJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB3808
X-Proofpoint-ORIG-GUID: gBG9G8JPRowMOJKnhEas5y27tUVDeA6N
X-Proofpoint-GUID: gBG9G8JPRowMOJKnhEas5y27tUVDeA6N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

DQoNCj4gPiA+IE9uIE1vbiwgRGVjIDE2LCAyMDI0IGF0IDAzOjMwOjEyUE0gKzAxMDAsIExhcnlz
YSBaYXJlbWJhIHdyb3RlOg0KPiA+ID4gPiBPbiBTdW4sIERlYyAxNSwgMjAyNCBhdCAxMTo1ODoz
OVBNIC0wODAwLCBTaGluYXMgUmFzaGVlZCB3cm90ZToNCj4gPiA+ID4gPiBuZG9fZ2V0X3N0YXRz
NjQoKSBjYW4gcmFjZSB3aXRoIG5kb19zdG9wKCksIHdoaWNoIGZyZWVzIGlucHV0IGFuZA0KPiA+
ID4gPiA+IG91dHB1dCBxdWV1ZSByZXNvdXJjZXMuIENhbGwgc3luY2hyb25pemVfbmV0KCkgdG8g
YXZvaWQgc3VjaCByYWNlcy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEZpeGVzOiA2YTYxMGE0NmJh
ZDEgKCJvY3Rlb25fZXA6IGFkZCBzdXBwb3J0IGZvciBuZG8gb3BzIikNCj4gPiA+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBTaGluYXMgUmFzaGVlZCA8c3Jhc2hlZWRAbWFydmVsbC5jb20+DQo+ID4gPiA+
ID4gLS0tDQo+ID4gPiA+ID4gVjI6DQo+ID4gPiA+ID4gICAtIENoYW5nZWQgc3luYyBtZWNoYW5p
c20gdG8gZml4IHJhY2UgY29uZGl0aW9ucyBmcm9tIHVzaW5nIGFuDQo+IGF0b21pYw0KPiA+ID4g
PiA+ICAgICBzZXRfYml0IG9wcyB0byBhIG11Y2ggc2ltcGxlciBzeW5jaHJvbml6ZV9uZXQoKQ0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9u
X2VwL29jdGVwX21haW4uYyB8IDEgKw0KPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKykNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9l
dGhlcm5ldC9tYXJ2ZWxsL29jdGVvbl9lcC9vY3RlcF9tYWluLmMNCj4gPiA+IGIvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb25fZXAvb2N0ZXBfbWFpbi5jDQo+ID4gPiA+ID4gaW5k
ZXggNTQ5NDM2ZWZjMjA0Li45NDFiYmFhYTY3YjUgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb25fZXAvb2N0ZXBfbWFpbi5jDQo+ID4gPiA+
ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb25fZXAvb2N0ZXBfbWFp
bi5jDQo+ID4gPiA+ID4gQEAgLTc1Nyw2ICs3NTcsNyBAQCBzdGF0aWMgaW50IG9jdGVwX3N0b3Ao
c3RydWN0IG5ldF9kZXZpY2UNCj4gKm5ldGRldikNCj4gPiA+ID4gPiAgew0KPiA+ID4gPiA+ICAJ
c3RydWN0IG9jdGVwX2RldmljZSAqb2N0ID0gbmV0ZGV2X3ByaXYobmV0ZGV2KTsNCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+ICsJc3luY2hyb25pemVfbmV0KCk7DQo+ID4gPiA+DQo+ID4gPiA+IFlvdSBz
aG91bGQgaGF2ZSBlbGFib3JhdGVkIG9uIHRoZSBmYWN0IHRoYXQgdGhpcyBzeW5jaHJvbml6ZV9u
ZXQoKSBpcyBmb3INCj4gPiA+ID4gX19MSU5LX1NUQVRFX1NUQVJUIGZsYWcgaW4gdGhlIGNvbW1p
dCBtZXNzYWdlLCB0aGlzIGlzIG5vdCBvYnZpb3VzLg0KPiBBbHNvLA0KPiA+ID4gaXMNCj4gPiA+
ID4gb2N0ZXBfZ2V0X3N0YXRzNjQoKSBjYWxsZWQgZnJvbSBSQ1Utc2FmZSBjb250ZXh0Pw0KPiA+
ID4gPg0KPiA+ID4NCj4gPiA+IE5vdyBJIHNlZSB0aGF0IGluIGNhc2UgIW5ldGlmX3J1bm5pbmco
KSwgeW91IGRvIG5vdCBiYWlsIG91dCBvZg0KPiA+ID4gb2N0ZXBfZ2V0X3N0YXRzNjQoKSBmdWxs
eSAob3IgYXQgYWxsIGFmdGVyIHRoZSBzZWNvbmQgcGF0Y2gpLiBTbywgY291bGQgeW91DQo+ID4g
PiBleHBsYWluLCBob3cgYXJlIHlvdSB1dGlsaXppbmcgUkNVIGhlcmU/DQo+ID4gPg0KPiA+DQo+
ID4gVGhlIHVuZGVyc3RhbmRpbmcgaXMgdGhhdCBvY3RlcF9nZXRfc3RhdHM2NCgpICgubmRvX2dl
dF9zdGF0czY0KCkgaW4gdHVybikgaXMNCj4gY2FsbGVkIGZyb20gUkNVIHNhZmUgY29udGV4dHMs
IGFuZA0KPiA+IHRoYXQgdGhlIG5ldGRldiBvcCBpcyBuZXZlciBjYWxsZWQgYWZ0ZXIgdGhlIG5k
b19zdG9wKCkuDQo+IA0KPiBBcyBJIG5vdyBzZWUsIGluIG5ldC9jb3JlL25ldC1zeXNmcy5jLCB5
ZXMgdGhlcmUgaXMgYW4gcmN1IHJlYWQgbG9jayBhcm91bmQgdGhlDQo+IHRoaW5nLCBidXQgdGhl
cmUgYXJlIGEgbG90IG1vcmUgY2FsbGVycyBhbmQgZm9yIGV4YW1wbGUgdmV0aF9nZXRfc3RhdHM2
NCgpDQo+IGV4cGxpY2l0bHkgY2FsbHMgcmN1X3JlYWRfbG9jaygpLg0KPiANCj4gQWxzbywgZXZl
biB3aXRoIFJDVS1wcm90ZWN0ZWQgc2VjdGlvbiwgSSBhbSBub3Qgc3VyZSBwcmV2ZW50cyB0aGUN
Cj4gb2N0ZXBfZ2V0X3N0YXRzNjQoKSB0byBiZSBjYWxsZWQgYWZ0ZXIgc3luY2hyb25pemVfbmV0
KCkgZmluaXNoZXMuIEFnYWluLCB0aGUNCj4gY2FsbGVycyBzZWVtIHRvbyBkaXZlcnNlIHRvIGRl
ZmluaXRlbHkgc2F5IHRoYXQgd2UgY2FuIHJlbHkgb24gYnVpbHQtaW4gZmxhZ3MNCj4gZm9yIHRo
aXMgdG8gbm90IGhhcHBlbiA6Lw0KDQpVc3VhbGx5LCB0aGUgdW5kZXJzdGFuZGluZyBpcyB0aGF0
IG5kb19nZXRfc3RhdHMgd29uJ3QgYmUgY2FsbGVkIGJ5IHRoZSBuZXR3b3JrIHN0YWNrIGFmdGVy
IHRoZSBpbnRlcmZhY2UgaXMgcHV0IGRvd24uIEFzIGxvbmcgYXMgdGhhdCBpcyB0aGUgY2FzZSwg
SSBkb24ndCB0aGluayB3ZSBzaG91bGQga2VlcCBhZGRpbmcgY2hlY2tzIHVudGlsIHRoZXJlIGlz
IGEgc3Ryb25nIHJlYXNvbiB0byBkbyBzby4gV2hhdCBkbyB5b3UgdGhpbms/DQoNCj4gPiBUaGFu
a3MgZm9yIHRoZSBjb21tZW50cw0K

