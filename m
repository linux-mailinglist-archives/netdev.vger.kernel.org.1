Return-Path: <netdev+bounces-126755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FA797262B
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 02:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B250B22873
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 00:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC611DFF7;
	Tue, 10 Sep 2024 00:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="afch0kr3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K6wRL+oG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C16D3C0C;
	Tue, 10 Sep 2024 00:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725928165; cv=fail; b=REh9JA9uP6wChpFwOS4QtAIOD0yRxruBkk8Gjj96GUee3y4a7xGEybs/RJHPGLiURrNCpYcXg4Uh1G4AF2Dg/Ojrr7Umd3YiTCzqOkB/ezvsNivZkQ/utun+oPuI8zrJ9EgfBPEgEy+fhI4yTYxvyynyIvzgTYQsyAdyEmLR+r8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725928165; c=relaxed/simple;
	bh=W+YrSJWDKcus9c4XfXzPei07fgEuKSA0OtuOTK7v/rw=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tAvoRzGKD/LiHMofvP76hka44tgHMlagdRRNrGWurkjRCUV6O/kHBJjamHBkLY+HCj5Ont4i4phyvDfw/ou1rqzSMpzSIoJJGe04f4sVvtGjTRsVJbdkR0cXVIRZWsxKA9krGJi/dO1DvzxNumFaRaUHXEvOpXhnfVCLwn4xYtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=afch0kr3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K6wRL+oG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48A0MW1q024345;
	Tue, 10 Sep 2024 00:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:from:to:cc:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=RP5Y6GX29zxApitkIoIvpvoh+8H4PS74jY3sHHAA2uY=; b=
	afch0kr3JfziBgzC5LLTOC8vQRcYb56kOicfEGefMPOjpZF5bm0yPJcZ3OH9w0+b
	yH9FiYOhhWvKzBy+TeVXYTupBpxYDZ/7fS+xNeoZLq6IrxjMhbwYC/ScNJYasYsg
	aXxKP856W0MUR9b46upWTJfOKtQSulFRQcOXPCy2m8wuP1YjK1EIqRQZMCqK4UiI
	/gZlPJIxmaqTTfMdeB5zsMY6yYrZY+BI3F2IR1GBYceSRxjyGjC5TPNzpTOp0ZGH
	QNBpXgGRJFLhXuKmMY7cgqup+/1GScz0U6SOkZxNMioqqspHjKTpD/b3IDgHYYwC
	B7rVpJ3AfnSIKNUVr18OCA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41geq9m9e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 00:29:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 489N2kCg040800;
	Tue, 10 Sep 2024 00:29:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd999mc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 00:29:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tocUAyMIfErCw/+gCZ64DcfXcT50qxaZdOLDCJPsb6PgeQswGVlS3dHMxoWU7dkqXq5IoQm27ogpaQc/to+1nONFySu9pXlcxX9EXfEPrfS3CIDBEB9ZCdKH50RjRD6vVDPRzT68l7sRDRfJ1oFto5Id8ZnIZsknvnLsgbsfDQL7X2m69pyQ++DeqNfGMTjalredrg8avpIhUFWB8SSsX41RmXFVIbwsXzrcV4qS3csQbx5t3Ck37fTRCEAwvfsyXTqipJxGDEjiimumUQulxdIicarUbn7KsG9wf4ICC+FtGSOAfKShgbAu6HYhTwrUbPuRvpl+os0apw/3X6XDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RP5Y6GX29zxApitkIoIvpvoh+8H4PS74jY3sHHAA2uY=;
 b=U7+1A/SbD0cKzrfWDc3fIwhb2Fw1ls7jMRGZ9uW4xVnzjs8j6xIZxTSEC92VpRr7RGte/Z+hgHhty3CnO3oyGrpJySqrk2ongwVX2ItvgEe6VO+udTfK6lVWqntHXvky9FITPR/IHEt0P9nFBqjc3sTRO2E0XpkrveuHOs7FrOuVNO0Nn6yoUrnzEPyABseUEYqb7/ToOBRuj57mmCethJZeUvJ1BbtOrC/cQ0Et3k458gCn7glvJEiE8wZ7kf9mVWZ8plY0uS3s/hErLA69YXuNO16+ru+3CKzXAUi1V0FJgCmtK9u8DAtUWwbGOl6eaCtASIThNjRECqcyEkhtig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RP5Y6GX29zxApitkIoIvpvoh+8H4PS74jY3sHHAA2uY=;
 b=K6wRL+oGO2GWGhG5REhjvAsxMJhw7Im3XDS6HkggcVZ69vyrGHum+J41e0P64yrBHuXlGX3EJJAr98gUHr3AsRNvSn27WTh3dGV1vchE/BB0qYszaTFq/7gR1ihTn7oelafuBRcfKZJ4ylVo7P96IyYkM0qFHLybqAb3yDalqEc=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by SJ0PR10MB4655.namprd10.prod.outlook.com (2603:10b6:a03:2df::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Tue, 10 Sep
 2024 00:29:07 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%6]) with mapi id 15.20.7939.016; Tue, 10 Sep 2024
 00:29:07 +0000
Message-ID: <2dd7aea9-93a1-4fbb-91a8-b7f3acd02a60@oracle.com>
Date: Mon, 9 Sep 2024 17:29:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 unix_stream_read_actor (2)
From: Shoaib Rao <rao.shoaib@oracle.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net,
        kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com,
        syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
References: <e500b808-d0a6-4517-a4ae-c5c31f466115@oracle.com>
 <20240905203525.26121-1-kuniyu@amazon.com>
 <19ce4e18-f1e0-44c4-b006-83001eb6ae24@oracle.com>
 <CANn89iK0F6W2CGCAz5HWWSzpLzV_iMvJYz0=qp3ZyrpDhjws2Q@mail.gmail.com>
 <c45d66d7-64fc-4fa8-8c38-ab2e9ca65635@oracle.com>
 <2abf390b-91ff-4f37-a54d-0ceac3e0ee61@oracle.com>
Content-Language: en-US
In-Reply-To: <2abf390b-91ff-4f37-a54d-0ceac3e0ee61@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::35) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|SJ0PR10MB4655:EE_
X-MS-Office365-Filtering-Correlation-Id: 8745e040-0e3f-46f5-79a9-08dcd12f94b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFFRZTRKRFg2eG1kL3paSFhvbk1ZNmNqNG8rUjJqd1l4UklwM3dBSW1lNzIv?=
 =?utf-8?B?ZC9sZm1hNlN4YWUxaTVidW96VDJEYmxGMUpIUm5XNitQemt5UWNSM2FBSWNP?=
 =?utf-8?B?M1BTcjZoL0tUZW1kT2hNQkFMTVFwc3lleEVLRXVwditMbXV2eEs3WUp4WHZr?=
 =?utf-8?B?bzRoZWZWc0RHNHJ1L0JVVTZpRTdFMjdQZHdadFd2OG1QQ2pFYktjK05vYzIw?=
 =?utf-8?B?WXA5UkxEL3BTYjdjUHp1ay9lcHYvOGJNR0lwcDA0aHJiTFE1R2pHY1M5VnFB?=
 =?utf-8?B?SmxBSWkybW5iTWZtOCtUMytob0VTeEpUeHp4STlDdWY1TXB6TktoUGh4dFNk?=
 =?utf-8?B?RDVreDdBLzQ5ZVhpcldMbXJ5eXNBZDlLNHl3Z1JRby9CbCtzSlFJTzlDOFVj?=
 =?utf-8?B?WDlhOWJxN1NMbnRkUFlCZjUwb3ZmWWhDZE5zV2JXV1FTK2x6aVl0SHJ5T21h?=
 =?utf-8?B?SHJVNzl1WHZkZVU5a01UUUk1VmNoeTEwRmU5a0NnZGFRajhYQ2V1ZGlqYTdW?=
 =?utf-8?B?dDhBa1Q3Mnp1UWEwSjFTZWE2Zkl2T1dObEdCYTVWZlhPUjlJYThLSDBFNklS?=
 =?utf-8?B?MkZocUJQdlkxUUl1cVlvaU1ia1p1QXA2QkJ5SFRDZjVyMkZGaEo0L2dsUUJi?=
 =?utf-8?B?cG8wVVBBRnlOWTlNWjUwT0F0TTBTNGhkTk9NbHUvY3lPQ3VtbFFhbHFaaXg5?=
 =?utf-8?B?MkRMdUZ0czU3bk5GdVpFOERxMkdSSXhXM3dmc2xsWGwrajZSK2dqaktMQjdE?=
 =?utf-8?B?Z1dXT1dzYy9PUVllaDJOOWZ0RFB5RkhnblR3MGpKUUY1TlFUazh2RHhyNzE0?=
 =?utf-8?B?dEFzbDVSSGVqZks5UURWMHRYWUtNQzIyblMvaHhqNUZuSG9MUDgyUjMydlBO?=
 =?utf-8?B?YUZzUUNXVFF2a0Y4TDY5QU96a1NPUnpoaWZ4QkFwcTI1OGNOM1RyRG4vMXBK?=
 =?utf-8?B?djRjQXlUYVFqRmhmWHR4QWh2VCtPZElFMnR5M2xZMkRCZHBCODVtNVhQT0dp?=
 =?utf-8?B?Y2xvWm5Tdm5QbTZwcXhwdzBzRElLWW52bHM0aytieXg3c2xtb3JlTm15VGFE?=
 =?utf-8?B?SG9QdlhGNnVodlByek9hMndVS0taOWZTR3VzWVUwY0UrU1pPTjNLMHFybmpW?=
 =?utf-8?B?QTFoUWFsL29xa3lJSDA2KzJ5RURPeVBUZndKSHF0aVh2RXU0VE5CU05sc1U0?=
 =?utf-8?B?UjAzUi9ZcWJCSE0zZkt6SUtPVmVUSGxtVG1LLzh0dVdVNDB3M2FEY3QvSGVv?=
 =?utf-8?B?Z1BHT21iWkxPOGhyczJOOVNsWFl1T2x3bkJYMlhiMHpQMXBQUDlWMEhiUFVa?=
 =?utf-8?B?YWdWZUJNZVI3TzFjZnl1ZmxyUmljdXVhZHR3VU82bC9KNzlDNnQ4Vi9EQjN1?=
 =?utf-8?B?ZENiOXVqc2NtQ2RsNmlGVm9HeE93RWR0YXR5NDU3QVdkU21KcVdibS9SOTlT?=
 =?utf-8?B?Sk9sRjluOUdWa3BzaXBkbHpDeGthL0d6V2R2TnFGSExOb05hL2pYeFhST3RJ?=
 =?utf-8?B?SjhDaW8rQnFRYldaN01ycGpyaHdGL0tMNURpTExVYzlMV05zRHpUaGEvSXNh?=
 =?utf-8?B?U3NQOTZHdVJSSkZWSjN5RzdIK3FyekNIeWh6cjd3VkJyYjNOK05PTjRjYWZG?=
 =?utf-8?B?bk5GV0p5NHl2ZVN5YnZOQmNDMU1Mb2sxWDNZdjlPQ21yM2diRmJZdU5wNGND?=
 =?utf-8?B?K1Urak9DbXZZb1pHai8vU0UzdFpVQ3I1VUJFdmRLMGh1SVVLaStDWkdRc0FS?=
 =?utf-8?Q?orFFWUspUQ3zUtlqHQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2QzdmRQRW14UzhtYkYyNUYwM2FTTU80S2k1TUlJcm4xWXoyaERPTGRNcXd2?=
 =?utf-8?B?TGtSbHJVVWJMdnN4TncyQ3lKelY3bGlQNVI5RXNsbjRhaWExdWtYTjUxMnpM?=
 =?utf-8?B?ZE5ySmpLMmlLWjFXT3E4N3UrRVlJYzdtdjBuVHlxQkoreFJRK0RVb3pLeDdh?=
 =?utf-8?B?NWpkQ3RuQzVOMG0zdGdGTEpxQ203QkRYVi8zRUxtdDY0azlaczkvU0xsczdE?=
 =?utf-8?B?M21YYm92NG8zUmRERm9XSXNieXZLa3JqNy9BNStGY04rS0ZIazBvYUROS1c3?=
 =?utf-8?B?OWEzNWFzV1oxMXdIUTZmZW9UbjYvVExYWnNUQUtIc24yTHpIUlA4MzlVUi9G?=
 =?utf-8?B?dFZZbUhVbUhGRmd4QklZMk8wODFGVHgybG5IYytoRFdOakkwOWxvZGRIclpL?=
 =?utf-8?B?VU9wZ3Iyc3dYMGRsTXhrbWFnUHBzcEZMcWE0MWFScWJZcjZJc3VMaUxmbW90?=
 =?utf-8?B?d2pwRmtFYnVTUGJwZmlMNFprVWIzUTdtdFVLSUVlS2EzYi92M1E4dnBJWVlT?=
 =?utf-8?B?ZlJRZGdMSG00TGpjQ2pYNW1kNXZ5RzJWUEorRDFzTjgyVDE1bisxSE1NWUVI?=
 =?utf-8?B?b3RTUlE4NVg5SXBCczRZeloyQnRxNzcxdmFoTjNHakdYN01qU1hYblpxUzJs?=
 =?utf-8?B?ZjJiRVlucGhRbVk1R295cy9pZHMvU3lrK3hJOXVhVXAzaFB4d2tPeTd6eGZy?=
 =?utf-8?B?SWtlNHg4YWl2SnJvd0dDOXJpU1g5Y1pSUHhndGxTakJodmtpQzNxaWxpUVNt?=
 =?utf-8?B?ZU1ialA1SkU4Q2ZzZG0rcnlJdDRKQmZIcWYxNWZDbFVZVXVZb2lqMGNZMnJw?=
 =?utf-8?B?UzRTQXRYRlhwWnpTbEp6VXEyQThJM0pyb09DeWRJNEliMzR1dEo4U2dpd1lM?=
 =?utf-8?B?UDN0dmMxTk90aGFzUzJVUWNjUkdZMEVINUZ3b2ZwY0w0QlUxS1pkMTYvbWgx?=
 =?utf-8?B?eGE5QURCK1F0YXgyTmtNaTFPN3o5Z2E5bFNxSW1LNm5maHcvSkJ6SXFyU0RD?=
 =?utf-8?B?RW13cXByZy9KeXZJdWIwbjR3ZUJidEhFR0NUL3NVQ1h5WWlkSFJueUZGQ01N?=
 =?utf-8?B?azlMdElROWJ2bTl2ak1idFM3TmEwa3VJUHROUWhRekRSazBHR0tOcWhuWU5F?=
 =?utf-8?B?d0pQVk1wRjlDanMyMHBFLzY1V3ZQOGpSOWdGWE9pd3o2L3ljVmoxUEJiZWND?=
 =?utf-8?B?K3F0L2JQZ0c3N2dyV01Fdm9VSEtWYnFnYU5RM0x4YTlSaTNZTk1aVkU5RVFB?=
 =?utf-8?B?dml5Zjh4OFp5TkZRN2t6Wk1sZk1SVTRyQWxDVmczTXFFUThlSlNJYmplMG5R?=
 =?utf-8?B?WEFtTnNMMkswY2M3d2xFSkxFeEtUbEdqb2VJSjlCeGMvN2JPVC9meGVuN2VZ?=
 =?utf-8?B?MTJQYjRUN3pKRS9RelVVMUZiNVF0a0x0RHRFOHRkWEYwNU0xdVkrUlJQeU5z?=
 =?utf-8?B?bDlYdFhjWk55U0E2bFJuRjNBM1JBOHZ2UHpJdUNmOXhKMVhtSHhLNTZNS29x?=
 =?utf-8?B?TXlaTlhNcERkMmxpQlJEVExjeks2UFBYczJxeTZ0Qi9JTVhCMUI0M1pTVDJY?=
 =?utf-8?B?TWpqOVQzY3dTdUFYL29sMVhNc094RDhXdSt4WkRRODgxQm1KSnQ3OVE5d3kr?=
 =?utf-8?B?WmZhNG9mYnpINE9TM24zQ0FSb3hsc0VLQ21NdnhhOFNMdWNvMlZmOXVYUjRZ?=
 =?utf-8?B?OW9mTXQ3T202dmlJMnJlUXNOZi9oMzQwbEFXWjd4aFZtSFhEVkRRNGkwZHBu?=
 =?utf-8?B?OFlEcStZcjVHYkRlV09tWE9tUXFSTVZnSEpTakxPZ01WM050UjFBUFpaYlBn?=
 =?utf-8?B?SFBUMXM3cjIvYjlIS0k3UjFyaDZIaDZvYWJuUTJWRDNJYWQ3MUZaMVR1Uk9s?=
 =?utf-8?B?R2FqaWN4RmpuNjNhcm44ZEU3NGV1SGpaeWdGTHdQZ2RFQkw0T1R2Tm9QZEZm?=
 =?utf-8?B?MDdCTy94SE5BaFZkb0Fpbm4zOFFLWUJHUlhhOTBmVkJuZ2c5SXNrM1Y4NFBs?=
 =?utf-8?B?Y3dEL3NLVWRXTk9aVUp6RlVuNVY0V0RtQVR1ZFRrRlhWcUo0ZE5mYWdtV05q?=
 =?utf-8?B?SzY5WGRja2NMajZ5dHFpbW5VYXZSVmJpeGJmZWFEa3FXNFppRUViTzZueUJs?=
 =?utf-8?Q?J/5qpY8pNNIxNLsEHJYIz1plU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iv2OThloGjHoZbpwK+kVcPoG0SiZvbHUyTFEbBuud/XJryubS2Hqg5ybN1XcA5vwyosYhWOSS8MJ8ZZbX27fc5RliuB98NJ/5tIEJjTLyrebA7A2lZDJcZs8p+CNeUZYWcKhMuduYGYavoHkCESvYjg9VLPjpplbbMJpJjrTisDZHx01/KYXMpJkF+/r1C8BX9X55DCOwO5++XaeT3qknG3GdtShL1CD0cOjwLQgtUinzvgOcUbu561huO/F8ERSSOp1M4yf1ZXnt/E9qUbEtOfeTexGAH64PDQBj5t6GKA+WdFJn9WMoPD7qVkrXM9pSPXQbu6EzW18OayzeJjuU1Bx1dNujh/fCwOBUpSszzkRXmKuUFlw6/5JCeMBCwCWmubRYrB1b7SU7Kl5ySKQgnZMAww9KGwHFSNdP7Da2jGa7wd4RsJlRLkq9QXItDfU1sOPq8f92Jt70EbdFjMoB78DRJe7joCZ3a+CIzXihDFZUdKA6rFIlnTmcL1RK0g8q/yn338tlh1V0fe8v2CJ4bd9wHxSN38zvVu0pShPUpM9JJt9Gs6KAHKnUAO3wLRkNO5XUuKixqm6wUVWVx2WzfJ5GPra6tmFUQd8eW+4SWY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8745e040-0e3f-46f5-79a9-08dcd12f94b7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 00:29:07.0793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ppjCFZKajpKW9g7Fm+qYER7b1WswkRJqOOcbmchmZTiiW/e4sJnHIlD1C3V9bspoGw4PHJifkGpLWODDGhcVWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4655
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409100001
X-Proofpoint-ORIG-GUID: VE0SA1A_D396l2dLDJB0RVimNii95O5D
X-Proofpoint-GUID: VE0SA1A_D396l2dLDJB0RVimNii95O5D



On 9/6/2024 10:06 PM, Shoaib Rao wrote:
> 
> On 9/6/2024 9:48 AM, Shoaib Rao wrote:
>>
>> On 9/6/2024 5:37 AM, Eric Dumazet wrote:
>>> On Thu, Sep 5, 2024 at 10:48 PM Shoaib Rao <rao.shoaib@oracle.com> 
>>> wrote:
>>>>
>>>> On 9/5/2024 1:35 PM, Kuniyuki Iwashima wrote:
>>>>> From: Shoaib Rao <rao.shoaib@oracle.com>
>>>>> Date: Thu, 5 Sep 2024 13:15:18 -0700
>>>>>> On 9/5/2024 12:46 PM, Kuniyuki Iwashima wrote:
>>>>>>> From: Shoaib Rao <rao.shoaib@oracle.com>
>>>>>>> Date: Thu, 5 Sep 2024 00:35:35 -0700
>>>>>>>> Hi All,
>>>>>>>>
>>>>>>>> I am not able to reproduce the issue. I have run the C program 
>>>>>>>> at least
>>>>>>>> 100 times in a loop. In the I do get an EFAULT, not sure if that is
>>>>>>>> intentional or not but no panic. Should I be doing something
>>>>>>>> differently? The kernel version I am using is
>>>>>>>> v6.11-rc6-70-gc763c4339688. Later I can try with the exact version.
>>>>>>> The -EFAULT is the bug meaning that we were trying to read an 
>>>>>>> consumed skb.
>>>>>>>
>>>>>>> But the first bug is in recvfrom() that shouldn't be able to read 
>>>>>>> OOB skb
>>>>>>> without MSG_OOB, which doesn't clear unix_sk(sk)->oob_skb, and later
>>>>>>> something bad happens.
>>>>>>>
>>>>>>>      socketpair(AF_UNIX, SOCK_STREAM, 0, [3, 4]) = 0
>>>>>>>      sendmsg(4, {msg_name=NULL, msg_namelen=0, 
>>>>>>> msg_iov=[{iov_base="\333", iov_len=1}], msg_iovlen=1, 
>>>>>>> msg_controllen=0, msg_flags=0}, MSG_OOB|MSG_DONTWAIT) = 1
>>>>>>>      recvmsg(3, {msg_name=NULL, msg_namelen=0, msg_iov=NULL, 
>>>>>>> msg_iovlen=0, msg_controllen=0, msg_flags=MSG_OOB}, MSG_OOB| 
>>>>>>> MSG_WAITFORONE) = 1
>>>>>>>      sendmsg(4, {msg_name=NULL, msg_namelen=0, 
>>>>>>> msg_iov=[{iov_base="\21", iov_len=1}], msg_iovlen=1, 
>>>>>>> msg_controllen=0, msg_flags=0}, MSG_OOB|MSG_NOSIGNAL|MSG_MORE) = 1
>>>>>>>> recvfrom(3, "\21", 125, MSG_DONTROUTE|MSG_TRUNC|MSG_DONTWAIT, 
>>>>>>>> NULL, NULL) = 1
>>>>>>>      recvmsg(3, {msg_namelen=0}, MSG_OOB|MSG_ERRQUEUE) = -1 
>>>>>>> EFAULT (Bad address)
>>>>>>>
>>>>>>> I posted a fix officially:
>>>>>>> https://urldefense.com/v3/__https://lore.kernel.org/ 
>>>>>>> netdev/20240905193240.17565-5-kuniyu@amazon.com/__;!! 
>>>>>>> ACWV5N9M2RV99hQ! 
>>>>>>> IJeFvLdaXIRN2ABsMFVaKOEjI3oZb2kUr6ld6ZRJCPAVum4vuyyYwUP6_5ZH9mGZiJDn6vrbxBAOqYI$
>>>>>> Thanks that is great. Isn't EFAULT,  normally indicative of an issue
>>>>>> with the user provided address of the buffer, not the kernel buffer.
>>>>> Normally, it's used when copy_to_user() or copy_from_user() or
>>>>> something similar failed.
>>>>>
>>>>> But this time, if you turn KASAN off, you'll see the last recvmsg()
>>>>> returns 1-byte garbage instead of -EFAULT, so actually KASAN worked
>>>>> on your host, I guess.
>>>> No it did not work. As soon as KASAN detected read after free it should
>>>> have paniced as it did in the report and I have been running the
>>>> syzbot's C program in a continuous loop. I would like to reproduce the
>>>> issue before we can accept the fix -- If that is alright with you. I
>>>> will try your new test case later and report back. Thanks for the patch
>>>> though.
>>> KASAN does not panic unless you request it.
>>>
>>> Documentation/dev-tools/kasan.rst
>>>
>>> KASAN is affected by the generic ``panic_on_warn`` command line 
>>> parameter.
>>> When it is enabled, KASAN panics the kernel after printing a bug report.
>>>
>>> By default, KASAN prints a bug report only for the first invalid 
>>> memory access.
>>> With ``kasan_multi_shot``, KASAN prints a report on every invalid 
>>> access. This
>>> effectively disables ``panic_on_warn`` for KASAN reports.
>>>
>>> Alternatively, independent of ``panic_on_warn``, the ``kasan.fault=`` 
>>> boot
>>> parameter can be used to control panic and reporting behaviour:
>>>
>>> - ``kasan.fault=report``, ``=panic``, or ``=panic_on_write`` controls 
>>> whether
>>>    to only print a KASAN report, panic the kernel, or panic the 
>>> kernel on
>>>    invalid writes only (default: ``report``). The panic happens even if
>>>    ``kasan_multi_shot`` is enabled. Note that when using asynchronous 
>>> mode of
>>>    Hardware Tag-Based KASAN, ``kasan.fault=panic_on_write`` always 
>>> panics on
>>>    asynchronously checked accesses (including reads).
>>
>> Hi Eric,
>>
>> Thanks for the update. I forgot to mention that I I did set /proc/sys/ 
>> kernel/panic_on_warn to 1. I ran the program over night in two 
>> separate windows, there are no reports and no panic. I first try to 
>> reproduce the issue, because if I can not, how can I be sure that I 
>> have fixed that bug? I may find another issue and fix it but not the 
>> one that I was trying to. Please be assured that I am not done, I 
>> continue to investigate the issue.
>>
>> If someone has a way of reproducing the failure please kindly let me 
>> know.
>>
>> Kind regards,
>>
>> Shoaib
>>
> I have tried reproducing using the newly added tests but no luck. I will 
> keep trying but if there is another occurrence please let me know. I am 
> using an AMD system but that should not have any impact.
> 
> Shoaib
> 

I have some more time investigating the issue. The sequence of packet 
arrival and consumption definitely points to an issue with OOB handling 
and I will be submitting a patch for that.

kasan does not report any issue because there are none. While the 
handling is incorrect, at no point freed memory is accessed. EFAULT 
error code is returned from __skb_datagram_iter()

/* This is not really a user copy fault, but rather someone 

  * gave us a bogus length on the skb.  We should probably 

  * print a warning here as it may indicate a kernel bug. 

  */ 


fault: 

     iov_iter_revert(to, offset - start_off); 

     return -EFAULT;

As the comment says, the issue is that the skb in question has a bogus 
length. Due to the bug in handling, the OOB byte has already been read 
as a regular byte, but oob pointer is not cleared, So when a read with 
OOB flag is issued, the code calls __skb_datagram_iter with the skb 
pointer which has a length of zero. The code detects it and returns the 
error. Any doubts can be verified by checking the refcnt on the skb.

My conclusion is that the bug report by syzbot is not caused by the 
mishandling of OOB, unless there was code added to disregard the skb 
length and read a byte.

The error being returned is confusing. The callers should not pass this 
error to the application. They should process the error.

Shoaib


