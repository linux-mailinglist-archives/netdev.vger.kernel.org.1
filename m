Return-Path: <netdev+bounces-110225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D285192B738
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 13:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87162281F87
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 11:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C38D158A3F;
	Tue,  9 Jul 2024 11:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="qSfKL2Uo"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52644158A29;
	Tue,  9 Jul 2024 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524042; cv=fail; b=YbOzvy+Nt6YoTFPZaqZAxl05W/FcQ3YJBjm3t2C7uFduoWvaQyO9qrt+crkapZvnyUg7EZu8FiSP5chIUYfR3YdduBZlNsMPYqbgY6Mw9xerVdHQPrGWbLbuV3X99VHAZIUWEheWd97A+j25DnTXyk4YV63VV1J63KVaWxXOP9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524042; c=relaxed/simple;
	bh=jZSVpt4ST87Uwdf1yHq8uwTU2cnmheE230UhEx1nkn8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hROrXhe/cG3OFDCP6MlfHKqH6179/Ardj0Mm79UFPMN47dqV+i0g2W0dVQigJWGi8jdL8j4jcWyLF4XPLsezWC3OjSdYxK2O9KTviBuD/JAOkkA05Jvtsex87QZSSaE6JdteH1YUJd87GereS7c7FCWMh+kCWx4ElWiOXQJg2+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=qSfKL2Uo; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697HuH5024363;
	Tue, 9 Jul 2024 04:20:23 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 408ntyjpce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 04:20:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vp/p6NJNVifSqTSkeNw2NtDX0RP3dPbgTW+zoCiZdu4fiCmojRI25n2v1z8thpvOcuEq+Po8XwWLFFI9l/nAC1fwLSOf8zv39HrrTH6e9F0IXtYeMsvfFqpY6u28+cIe+qs7vvfe7x7IUv0cVPSZQgGDhksN54Id25DxteLyuCWCyoURUYGbmU2YHwNMkk+aGVDNSrtJnuvXkSQm82QiaGTKgo3rMAsVEs7FGe328DuuEuk3DD7c4AMeGKLrDrJtGI7Brm7Qp/3tVYYsBSY6e9iQA1zLuz4erih3nJGViCVpE8U8so6p4qLFd+YgPv3fh5e6QZvQaFrp06jV1ObIvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZSVpt4ST87Uwdf1yHq8uwTU2cnmheE230UhEx1nkn8=;
 b=Ov4ZE72dvWZ301bRB8KuY8FBkwfsrwPfcgI/+OU/JN80/p0s7j7xxnZVbQNIwUewP8qEs8CximMjrk178DGvAeNQwfr930nbu/jICTRLpz8BtStJ4O5LAWB/4BrKlJIPMnwoJpbZo8RlhnD9ObTQJJc8hmzrYmJvWhJzTG1DvAiuT1yr59X0uZOCf469TVlQJPoR8+bGKQHZ6HGhy3x2GoEBwlBDUzIwNtif91rhDyscUYdrqHNbx0h5Bp+0RcmRsH14lj25RvZZP/SwPOi7Ybgy/qK6M/WQ41QqJJsmVxeQjzVaqEwUQ9zwSqtZzZGX3clJ3lsi6qMmKDzJlJtxTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZSVpt4ST87Uwdf1yHq8uwTU2cnmheE230UhEx1nkn8=;
 b=qSfKL2Uomd6HVK/n7zJ7UfyZLysk4ep2uMmWPbTGOhzlwZawjv0fhTsyN/1spE0u+s/6yUeQ73tqqMJHtzE5joNleZyaGy/C3wtIwAtVJkUsaRzEah4z4kRigZD+K3mNNKtxFtnHQbwEDJIUVuhd3ayn156XJh8wes7HNykX9xo=
Received: from DS0PR18MB5368.namprd18.prod.outlook.com (2603:10b6:8:12f::17)
 by MW4PR18MB5160.namprd18.prod.outlook.com (2603:10b6:303:1b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Tue, 9 Jul
 2024 11:20:19 +0000
Received: from DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::ad53:bef2:cc17:13ac]) by DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::ad53:bef2:cc17:13ac%5]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 11:20:19 +0000
From: Srujana Challa <schalla@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Sunil Kovvuri
 Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH net,2/6] octeontx2-af: reduce cpt flt
 interrupt vectors for cn10kb
Thread-Topic: [EXTERNAL] Re: [PATCH net,2/6] octeontx2-af: reduce cpt flt
 interrupt vectors for cn10kb
Thread-Index: AQHay5YwoW0KgT7JFUifm/4tXJJzYLHjPg2AgAsMt2A=
Date: Tue, 9 Jul 2024 11:20:19 +0000
Message-ID: 
 <DS0PR18MB5368B2BEE3FC13B494A8F805A0DB2@DS0PR18MB5368.namprd18.prod.outlook.com>
References: <20240701090746.2171565-1-schalla@marvell.com>
 <20240701090746.2171565-3-schalla@marvell.com>
 <20240702102843.GE598357@kernel.org>
In-Reply-To: <20240702102843.GE598357@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5368:EE_|MW4PR18MB5160:EE_
x-ms-office365-filtering-correlation-id: ad45b22c-8e16-4a3f-246c-08dca0091deb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?NEZFNjlkRDFMNnVyVG9ieE8zdTduU1phZk5jT0ZiODl5aHhwSE9JL240UFU1?=
 =?utf-8?B?TGV2dDhObzdBMUYvbENVRlNNa1pVRWJwZkxtNTN2NWl4UjU5NmdJZXZuUWtz?=
 =?utf-8?B?Uk5EVXJGcUkwcE9ZK01VWEVFTGJvQUVoNngrZHZyT3VQRmVHOUFMMTVwbkIy?=
 =?utf-8?B?QnJ1WXJNYVpjeldjSkQ1d1l2WlJSOFpoOERXQkFTYlFRcGZNZyt6d0JpSW45?=
 =?utf-8?B?djlYb056VHVUNzJOVGxWQkF4QUpXRjRTcnZaU3RFckhrUWoxL1RLNDhFMzlp?=
 =?utf-8?B?bE9TL0dvSm1lcTIreER3b1gyQXJIcDM4TGg4ejZjWDlPOXRnZTY1RGIxTVRl?=
 =?utf-8?B?dWMyY3ZFTkJMYjFFNDBGamVUMnN3bGhTSWtOOWQ4c1huaHhpNENBZU5LQ25E?=
 =?utf-8?B?S1JpdEt0Mm55K01LY1lSTWJaZ1VyS0dBQ3d0ZS9DekRWM0RiY0tGRWVvV3dx?=
 =?utf-8?B?Ulk5QVFIV29DVDRSekJKYmN4UXdDdTVPWlkyaHhnNmRKR0JoNHY5MmQ5Q2VY?=
 =?utf-8?B?L0NQK0tBU3BlcDNEN3ZYRTlTWDdSWmZhWDZrQlU3UE9CZU9XS2JiL0taazN2?=
 =?utf-8?B?UFUrVkxZSUFjWks2bzRQTkhkdnRQQzFKczR6djIreTNXZnovSUxJbVN5cStt?=
 =?utf-8?B?OXNDd1JSZGl2WVAwR29uVlpFeWxsUnZLTlFpL3p0ODhzSS9aOXMyemdleWxv?=
 =?utf-8?B?Wi80TFhHUDh1cytwVVY3Y2VUZ1BCa0pmYTZ0Z0hBdUZiRFIxRExTVHpMbDdh?=
 =?utf-8?B?WjF0Zkg5c3plcW4wdnpZa3ZBR29iMGJFTVFnYzdiYi95V1ZuT3lDcWpuRjNR?=
 =?utf-8?B?YjFoYTYwb1Z1eVl2TDU3KzZLdjZIcFVHbHlNOTE1ZHNHQ2ZhQTZNYVRHdGsw?=
 =?utf-8?B?ZmtpVi9hUGVrWkF2VFBKWWFZTURnQ2U4TXY4SUJxN3ZMd2o4dWJjM29zbG1Q?=
 =?utf-8?B?Yk50Y1oyY1JXMTBRU1dnK0ZENVZaVGZZQm9IV2YybzFxZ3ppSnZzdG8yWUMw?=
 =?utf-8?B?VlRNTW04U0NlaVB1a0dvOWR4dzBqUGpxR1poSVNvUlRKVVRTU2UwWjB6cEpZ?=
 =?utf-8?B?ZG5JVTU2eWZ0RlJwMGpGeDI5d3k1M2RxR3NnaEg5SHNCL2l0WHVYVWRsY2Jz?=
 =?utf-8?B?U05iWVFObDQyalVMdENyeGdHYzYzblZKRk5rK3gxRGtFVWYzQVE4UEhNdjMz?=
 =?utf-8?B?NWk5TWtFQkRlUm5jMDRlcld5STJ0RjYrOG1lZzU2SEtMMlNsQ1ZzRjV5eUxT?=
 =?utf-8?B?Mk84ai9xTnRmR3B4dGxUTG1DVDhpR3JoRWZEZ1ZoQ2pQVzVtSE12UFM5ajBD?=
 =?utf-8?B?WDdSR2NpeTQrcjhQRmZqUCs0b0swSzhpK0dnYlh3TEhwbmNBZXdYYnpRTTh6?=
 =?utf-8?B?Q1RIRVNTeDJIV1pZTDJjTzRsVEsvNGpPb1VLTjdPSlcwVW1tYkswQ2NsUXp5?=
 =?utf-8?B?cnJ2ZDBPbEM2Q21lVjhzbmJGN2FReVJvM1JBYm8ySUdFSDdvYTdSRDA1QlVS?=
 =?utf-8?B?YVprY09DZi9WbG15YUNwZU4yNytZaDhqWTYvYWM5RC9zUTltTXJFRFNxK21N?=
 =?utf-8?B?UHBmM1ZSMG9CY1NxTDNBdlJENnorSVAvaFpKeFllK21XWmVXcWxKb0x5ZEYw?=
 =?utf-8?B?TmdKMzlqSzdtMjJNSksvQzNHTnJzSk9pNlMyalk5NUdCc0RuVW9oeDJSdzdH?=
 =?utf-8?B?TGlxakZGTHVVT3QwdFlNWTNlZ2ZveExMWU9UMkxCWW52N2FMTDhLbWZuNnp3?=
 =?utf-8?B?VEhEcDZLQVpTMXRHalJXWXdBbUtxRE5XQ1JoYXBmZVFMOWd1V3JVSVBYaUJV?=
 =?utf-8?B?dmYyY2JlU2JOOTJDUytEcm9DV2RKZ1pQL3ZyTm1ibUEvUnM2dThuMFBHUWRr?=
 =?utf-8?B?NmpSa0lqUGJrRkxiUVlJdlByZ1pvVlhTQkNWK050dDhPNkE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR18MB5368.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SzgxVzlnODk3Zy9qeHNpVzh2SENabVNIMTdHLzdXWlRsT2o3aG5uK05xUTBG?=
 =?utf-8?B?YmNmWGhyR0dvKzQ3M2ZRcGlQZ2Q0TjRqWGxBZ1E2QVZTUW1iKzhKWHdHVEhE?=
 =?utf-8?B?MkkvaTQ3L21KeCtjV1hvcVljaGE2L0tSdXhCZ2loaVNBTFArOUFPNzF3bVY2?=
 =?utf-8?B?NDU4aHU2a3htSTRuRlJITjZPUnFDK0llcE8xSUhpTlFieHl1VngrRmp5dHJK?=
 =?utf-8?B?bDhxK2F3bWxod1RtamZmWHVKcUxweEdiM2tpUjE0TTZGYlZKcmowTE1VNGZD?=
 =?utf-8?B?Q2dQT3I4QmdzbnZLZUNScFh2NFZKUkdSSkpNcSs1TGhwYVZoUEdFL1FvZmFS?=
 =?utf-8?B?bzBnenV6OUd3UUxxbzFNVXRFUWF2bGowbThoQTA1bUMyOU5vSlBEamJWY0xn?=
 =?utf-8?B?cU9pakp4SzJmYThxUUp6VkpEbHRlbitkNHprWU5uZlF4amswTk9nZ1Q1R1JR?=
 =?utf-8?B?RGk3MGVhcVV3ZXovbzlpUm5xSDZmSWlVKzhqcFJVb1FzUiswQUJlMWZZL25h?=
 =?utf-8?B?eEI0a21FeDJTRUFYYTRjRHcvbkI3RE9MaG5MTy8vV0w5em1uQzJnbWUzY1pk?=
 =?utf-8?B?MVJyQ0tuMy9FZ2R6UGxuZHNhZ2lrWkRKa2gwcXVseEpTd0xmanNmR0dPakpo?=
 =?utf-8?B?aVY3QXlqWVdFSTdxbVdoVHY0a1FJRHE1b1ZJaUpscnlrSHptcyt2bVlXcFJH?=
 =?utf-8?B?WmJTMnBlY3k0eUhsUE1PNlltanRiekFpS2RkNUZsK0R4UjkvZmdiYW9JRjBP?=
 =?utf-8?B?MlJaZTFYS081cUJjUm9ybUVyMTZIQVkxSHhPdVJDRWtXQXNBTHhvLzZQN3lv?=
 =?utf-8?B?VFQwNUtXUHFjSW9acHRBcHcwSXBDTkRrVHAyRi91SEJSUkdicmM0K0FoM1Mr?=
 =?utf-8?B?bUpLQnBMSlRZZHRoWHZLSlYwcVJVYTkxZmVZakYxRm1wcVBlajc3WUFtTTBZ?=
 =?utf-8?B?TG5FUHV3MlVSZkcrckNhSlNjWlkzWXdQaXAwMXYrcGtxVWdMSHovTDN4dHR1?=
 =?utf-8?B?RjhDckpjM29ESmxZcjMxODEydG9CVzRoRDA1d2xNNUVMMVBOU0ZWYW0wa0l6?=
 =?utf-8?B?NkZJTkh6eVlwZkpZOFhaQzRqdnRjQzYyckhZeGdpNjFZczJGNWQvTjEzOUln?=
 =?utf-8?B?cGhuM1U3N01KM1M4VG9ueWtTZEpTVDJBNHJCMHNMWDZFbWRlVUs3T0lqSnRH?=
 =?utf-8?B?cFRldGN5OWMraGJsNHFBRzRDbHNaVWN2cThNS0RXSUZMeml3YlRQZXlZOG5m?=
 =?utf-8?B?RnMvclFvNzFUNGdZOWNsZVBSZDJEMzVQWWY2QUpINFV6UGRwNENicFFOTlNl?=
 =?utf-8?B?NG5zckNSZjEwRVRaSzBGeG1NcHRRa3g3N1Y0eTZiNk1iSGJwOFloTCt5NjdH?=
 =?utf-8?B?U2hHR0VaUW8ySTRHcUJLTE5IRjJxRXJuV0Q3aklxd0hBdm5RdUJXRHNjTEh1?=
 =?utf-8?B?TC9ENWh0YUNISGYxUHZGYzlzS29oeSs2Tys3elFvbEdWYjBWYlhOQ2c0NGty?=
 =?utf-8?B?TGZmVkZQTGl4bHc5RGdhbVZhbmxsRkFmYmlhckxGTkUrZit5V1c1R2lSWlla?=
 =?utf-8?B?cCsvclpGVHg5YU0vWndYa0ovRjJFd1JsazMvVlFtRkRnOUhISkY5ckdESnZ2?=
 =?utf-8?B?aXFmejdxaXhwdlFkRXVucncvSXZXZjAraCtHUS9DTkEzNEtaK1B5bmRpRnBK?=
 =?utf-8?B?RTIzZCtEcWZYc0J3cGovckxlYWl1VFRoVjNOek85QWpWVzBueldacVV5S2FW?=
 =?utf-8?B?NE1YdlRVdEJ0MHNoT2xPcWwwSFlIcEZKTGpYakZhL1hKRW5YU1N2RWtiQW55?=
 =?utf-8?B?UjNVakNiWE5LZlQ2cm93OHBzTTlLSVZobnh0TklXYVpYZERwQ1VvbURnYjcw?=
 =?utf-8?B?bEwzUFBoeWR6OWZHYjMrMjFFWjJmV2NvZXovY3l1WDdpL3kxSlk5T1N5dW5k?=
 =?utf-8?B?ZE9jVXNZcTZZNXpFWVVhYXNFVnA1Smc4ZE1qWkxCRjdSRXBHUTNYMVdXNEE0?=
 =?utf-8?B?bGlIWHB6dnVVMW1jSVh4RW5HelloVDFyMnZJenVmT0kyNWw3bDBaQThuWUFj?=
 =?utf-8?B?Uk9VUXdzZkxvMVNzUXdmRi9aY1d3ZWFDUVp2Z0YzNkNzbXpDZzhYN1hOa0RV?=
 =?utf-8?Q?+/6jG/b1/zlj4ewa7E0kgxfee?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS0PR18MB5368.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad45b22c-8e16-4a3f-246c-08dca0091deb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 11:20:19.6527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uNEUTw+JEheP0hyNukgl+i1R6uTTgXrixRO+jy6bHi6xhjo4Vcre/eygEoCsBf1wq+D6/0ufUa8i/PCH4ID79w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR18MB5160
X-Proofpoint-ORIG-GUID: abkCZiUX9N8QZ6pzd8CVN0xO5dG850Fa
X-Proofpoint-GUID: abkCZiUX9N8QZ6pzd8CVN0xO5dG850Fa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-08_01,2024-05-17_01

PiBPbiBNb24sIEp1bCAwMSwgMjAyNCBhdCAwMjozNzo0MlBNICswNTMwLCBTcnVqYW5hIENoYWxs
YSB3cm90ZToNCj4gPiBPbiBuZXcgc2lsaWNvbihjbjEwa2IpLCB0aGUgbnVtYmVyIG9mIEZMVCBp
bnRlcnJ1cHQgdmVjdG9ycyBoYXMgYmVlbg0KPiA+IHJlZHVjZWQuIEhlbmNlLCB0aGlzIHBhdGNo
IG1vZGlmaWVzIHRoZSBjb2RlIHRvIG1ha2UgaXQgd29yayBmb3IgYm90aA0KPiA+IGNuMTBrYSBh
bmQgY24xMGtiLg0KPiA+DQo+IA0KPiBJIGFtIHRlbXB0ZWQgdG8gdGhpbmsgdGhpcyBpcyBtb3Jl
IGFib3V0IGVuYWJsaW5nIG5ldyBoYXJkd2FyZSB0aGFuIGZpeGluZyBhDQo+IGJ1Zy4gQnV0IEkg
ZG8gYWxzbyBzZWUgaG93IG9uZSBtaWdodCBhcmd1ZSBvdGhlcndpc2UuDQo+IA0KPiBJbiBhbnkg
Y2FzZSwgaWYgdGhpcyBpcyBhIGZpeCB0aGVuIGEgZml4ZXMgdGFnIHNob3VsZCBnbyBoZXJlLg0K
SeKAmWxsIGV4Y2x1ZGUgdGhlIHBhdGNoIGZyb20gdGhpcyBzZXJpZXMgYW5kIHN1Ym1pdCBpdCB0
byBuZXQtbmV4dC4NCg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNydWphbmEgQ2hhbGxhIDxzY2hhbGxh
QG1hcnZlbGwuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0
ZW9udHgyL2FmL21ib3guaCAgfCAgNSArLQ0KPiA+ICAuLi4vZXRoZXJuZXQvbWFydmVsbC9vY3Rl
b250eDIvYWYvcnZ1X2NwdC5jICAgfCA3MyArKysrKysrKysrKysrKysrLS0tDQo+ID4gIC4uLi9t
YXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnVfc3RydWN0LmggICAgICAgICB8ICA1ICstDQo+ID4gIDMg
ZmlsZXMgY2hhbmdlZCwgNjUgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvYWYv
bWJveC5oDQo+ID4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9t
Ym94LmgNCj4gPiBpbmRleCA0YTc3ZjZmZTI2MjIuLjQxYjQ2NzI0Y2IzZCAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9tYm94LmgNCj4g
PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9tYm94LmgN
Cj4gPiBAQCAtMTg0OCw4ICsxODQ4LDkgQEAgc3RydWN0IGNwdF9mbHRfZW5nX2luZm9fcmVxIHsN
Cj4gPg0KPiA+ICBzdHJ1Y3QgY3B0X2ZsdF9lbmdfaW5mb19yc3Agew0KPiA+ICAJc3RydWN0IG1i
b3hfbXNnaGRyIGhkcjsNCj4gPiAtCXU2NCBmbHRfZW5nX21hcFtDUFRfMTBLX0FGX0lOVF9WRUNf
UlZVXTsNCj4gPiAtCXU2NCByY3ZyZF9lbmdfbWFwW0NQVF8xMEtfQUZfSU5UX1ZFQ19SVlVdOw0K
PiA+ICsjZGVmaW5lIENQVF9BRl9NQVhfRkxUX0lOVF9WRUNTIDMNCj4gPiArCXU2NCBmbHRfZW5n
X21hcFtDUFRfQUZfTUFYX0ZMVF9JTlRfVkVDU107DQo+ID4gKwl1NjQgcmN2cmRfZW5nX21hcFtD
UFRfQUZfTUFYX0ZMVF9JTlRfVkVDU107DQo+ID4gIAl1NjQgcnN2ZDsNCj4gPiAgfTsNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9h
Zi9ydnVfY3B0LmMNCj4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgy
L2FmL3J2dV9jcHQuYw0KPiA+IGluZGV4IDk4NDQwYTAyNDFhMi4uMzgzNjNlYTU2YzZjIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2
dV9jcHQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgy
L2FmL3J2dV9jcHQuYw0KPiA+IEBAIC0zNyw2ICszNywzOCBAQA0KPiA+ICAJKF9yc3ApLT5mcmVl
X3N0c18jI2V0eXBlID0gZnJlZV9zdHM7ICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiA+ICB9
KQ0KPiA+DQo+ID4gKyNkZWZpbmUgTUFYX0FFICBHRU5NQVNLX1VMTCg0NywgMzIpDQo+ID4gKyNk
ZWZpbmUgTUFYX0lFICBHRU5NQVNLX1VMTCgzMSwgMTYpDQo+ID4gKyNkZWZpbmUgTUFYX1NFICBH
RU5NQVNLX1VMTCgxNSwgMCkNCj4gPiArc3RhdGljIHUzMiBjcHRfbWF4X2VuZ2luZXNfZ2V0KHN0
cnVjdCBydnUgKnJ2dSkgew0KPiA+ICsJdTE2IG1heF9zZXMsIG1heF9pZXMsIG1heF9hZXM7DQo+
ID4gKwl1NjQgcmVnOw0KPiA+ICsNCj4gPiArCXJlZyA9IHJ2dV9yZWFkNjQocnZ1LCBCTEtBRERS
X0NQVDAsIENQVF9BRl9DT05TVEFOVFMxKTsNCj4gPiArCW1heF9zZXMgPSBGSUVMRF9HRVQoTUFY
X1NFLCByZWcpOw0KPiA+ICsJbWF4X2llcyA9IEZJRUxEX0dFVChNQVhfSUUsIHJlZyk7DQo+ID4g
KwltYXhfYWVzID0gRklFTERfR0VUKE1BWF9BRSwgcmVnKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4g
bWF4X3NlcyArIG1heF9pZXMgKyBtYXhfYWVzOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICsvKiBOdW1i
ZXIgb2YgZmx0IGludGVycnVwdCB2ZWN0b3JzIGFyZSBkZXBlbmRzIG9uIG51bWJlciBvZiBlbmdp
bmVzDQo+ID4gK3RoYXQNCj4gPiArICogdGhlIGNoaXAgaGFzLiBFYWNoIGZsdCB2ZWN0b3IgcmVw
cmVzZW50cyA2NCBlbmdpbmVzLg0KPiA+ICsgKi8NCj4gPiArc3RhdGljIGludCBjcHRfMTBrX2Zs
dF9udmVjc19nZXQoc3RydWN0IHJ2dSAqcnZ1KSB7DQo+ID4gKwl1MzIgbWF4X2VuZ3M7DQo+ID4g
KwlpbnQgZmx0X3ZlY3M7DQo+ID4gKw0KPiA+ICsJbWF4X2VuZ3MgPSBjcHRfbWF4X2VuZ2luZXNf
Z2V0KHJ2dSk7DQo+ID4gKw0KPiA+ICsJZmx0X3ZlY3MgPSAobWF4X2VuZ3MgLyA2NCk7DQo+ID4g
KwlmbHRfdmVjcyArPSAobWF4X2VuZ3MgJSA2NCkgPyAxIDogMDsNCj4gPiArDQo+ID4gKwlyZXR1
cm4gZmx0X3ZlY3M7DQo+ID4gK30NCj4gPiArDQo+IA0KPiBJIHRoaW5rIHRoZSBjYWxsZXJzIG9m
IHRoaXMgZnVuY3Rpb24gYXNzdW1lIGl0IHdpbGwgbmV2ZXIgcmV0dXJuIGEgdmFsdWUgZ3JlYXRl
cg0KPiB0aGFuIDMuIFBlcmhhcHMgaXQgd291bGQgYmUgd29ydGggZW5mb3JjaW5nIHRoYXQsIG9y
IFdBUk5pbmcgaWYgaXQgbm90IHNvLiAgSSdtDQo+IHRoaW5raW5nIG9mIGEgY2FzZSBhIGZ3L2h3
IHJldmlzaW9uIGNvbWVzIGFsb25nIGFuZCB0aGlzIGFzc3VtcHRpb24gbm8NCj4gbG9uZ2VyIGhv
bGRzLg0KPiANCj4gPiAgc3RhdGljIGlycXJldHVybl90IGNwdF9hZl9mbHRfaW50cl9oYW5kbGVy
KGludCB2ZWMsIHZvaWQgKnB0cikgIHsNCj4gPiAgCXN0cnVjdCBydnVfYmxvY2sgKmJsb2NrID0g
cHRyOw0KPiANCj4gLi4uDQo=

