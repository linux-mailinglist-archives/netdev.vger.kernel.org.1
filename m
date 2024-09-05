Return-Path: <netdev+bounces-125688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6627196E3DC
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 22:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E6D281DBB
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 20:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB7A1A08C6;
	Thu,  5 Sep 2024 20:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GCks/FH6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rtoh+GoC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987C11A0707;
	Thu,  5 Sep 2024 20:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567335; cv=fail; b=tU34dDZ8Hv9uKqLOZc/EggC9063Ld8eRcwGMPBJE2HcC4xGFl8ejwUxJy5XVHYv8yMtaMBxB3XzXRVaGVJikt00q/pqq1/zrZrunSA8FZ5NHlPj8XNO5GPHP1RHxBJMhnwlq2HDXeAkC2n7W0ASnjOwVkCs9YT1VpGlANxd1Gtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567335; c=relaxed/simple;
	bh=hYcZckAID2O7m8Myof/igqX9Kdg9zzxCMlsrCZzUc2E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M8dCCyPLkfQ6E+nLU+Fba1xPB5A/WFGdmDyLO+Z/krhNGt9CTXfiClUTfQ0eTvRIXauLijobqLPN8UCvh+INePEFp2fQftE7tWZ9qWnCqWxAoSrtRcP8X060l5ag7fvHpLPjk9p+zbGZdYCk6bSEuavB9W9N0gs+FyDGVDjPnpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GCks/FH6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rtoh+GoC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485IXXEu029228;
	Thu, 5 Sep 2024 20:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=wZ93OVB7Q44xGVd5HM9uG9zh8QdUVOmXKl8blC9yY5U=; b=
	GCks/FH6r3Oetm0WHRszLjqEp13TK9duTab9QlPAQxh/nar7Cxj3zocvPEw2vsWE
	PpIC1l8sZZIWebVF1tiOTu++GSqYwmkvQoVs4fqxuy3XiLlU0xivY60ErZyYU9/w
	1c0on4PSiYyJkz5YfFCQW2nCfjLv5yN/Oxy/JTV6JnEYAmB0HlNlySY2MpGGsC9G
	iOYutmc/kf0CEvX6L8vSKYnfzbWGXpvTdcx4eexc3jifqZOKDhGIaPkUmb2mRgvs
	w73mhXEZrtFoVXGRelDs/zkroHWjpYDzX5d8MJhD5lWRGwedvE5bWEtqp2/nhTWn
	l4ij7Q6/P0zC/MMQev9K0Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41fhwhg6sj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Sep 2024 20:15:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 485KBm0a040898;
	Thu, 5 Sep 2024 20:15:23 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41fhyb4cun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Sep 2024 20:15:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZ98+bsF9nqwzM0n9GX2a45wmEz3O9A63M1gNX0uu1apN+9x8DxLmZoAw4WA6bw54eNqwbXZtxv060pM/0s7pEnaU2dO4/7Pym7gWCWuUNnLybkMZ01ZFbLgx7pFbZ8mRG1ffs8QPpVINAXGKiRL/Abkjj/5kGpXaP5OPtfOUjPFNESAxJUfk+o8+QacfoBjMxOuW2f3qbTz8btSu91hAr9AUbLN75qWEi0uyWdmEShD7KsmuczIBa4OWmI75nnt1ZVUkyniNG2ECkzQgDAUEQKIO4xpkTsO6nmkkdTE8i+YrxCVUlSa88NUgnO092hUITifiGGzbn6RDNsCYGw3WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZ93OVB7Q44xGVd5HM9uG9zh8QdUVOmXKl8blC9yY5U=;
 b=Uv7QO1KCVR0EB/Otsfe3zIg3TESwwtrlFIm0/s+/itvQLEI/Zlg+t69/Ffa7TIqperWZU3FmQyi+M44cCISVgqY01kj5tuWOhCr4QYzCYAPvWK9MklqnniYeuvP2KtQTr7+xQZE3giZrY7lIB3F68znFlgKl0oTCtYx/YzbZF5FKinHrRKOOIODkvw7qcUG53lAqzw/aGOfFRu86CJwQL9iV6f0ANshYmyUqGmCR3uAyKavSInYTT73JaUhhR5kmWRvRt+iMIqtjcrNXNTYuikJPDwI/U+rFa2+fx+vxTfqOOdM02XIx5TJs6/LdEdt2OG9yxSa3rEnqnEiw/UTszQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZ93OVB7Q44xGVd5HM9uG9zh8QdUVOmXKl8blC9yY5U=;
 b=rtoh+GoCaG6d3Pnx28qw3n/wV6pKej3y7XlJd9SIW96WRziFjHskpHjm7h+nmjOXbjUF7KaPnJlD4+/kHWxSw0MRcryCp5qS9R+leFZhmzH6PCf6pM0cwHi33mL+Hp7iVooD4WPT/XYK5YcdQaRR9amgirUcrkBkQRudDe4V6Uk=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by IA1PR10MB6147.namprd10.prod.outlook.com (2603:10b6:208:3a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.13; Thu, 5 Sep
 2024 20:15:21 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%6]) with mapi id 15.20.7939.016; Thu, 5 Sep 2024
 20:15:21 +0000
Message-ID: <e500b808-d0a6-4517-a4ae-c5c31f466115@oracle.com>
Date: Thu, 5 Sep 2024 13:15:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 unix_stream_read_actor (2)
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com,
        syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
References: <13a58eb5-d756-46a3-81f0-aba96184b266@oracle.com>
 <20240905194616.20503-1-kuniyu@amazon.com>
Content-Language: en-US
From: Shoaib Rao <rao.shoaib@oracle.com>
In-Reply-To: <20240905194616.20503-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::8) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|IA1PR10MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: 53425c4c-e2ba-4943-4f0b-08dccde7779f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHJjUGI3VVVsZFVMSTc5Mkc4MTdlSlpXL1hTUkpCRzZISVJuc0dwajVqSjZ0?=
 =?utf-8?B?UnFKd09Ob0xWN09nOE5JZFlya0hDUng4V3NpWTJBREdEbzAza3g4VVp1TitJ?=
 =?utf-8?B?cy9xbndkQTdRZjMzeEJBVDE4UkF0WG84eWg3QnZWRWYyM015T1dwYWVvWmxK?=
 =?utf-8?B?VnRrSDNwRmpEa1JEencydXVDZEZWSGMwYUNNQWZFU3p4YWJvTWNmcS92RHhv?=
 =?utf-8?B?ai84cGJUbE0ySWpHWVRxQXRFS1hIdzJNUE5VN0x0dGVZeVQwOVFBN2RIZVZp?=
 =?utf-8?B?Ri9ML0E1UkVDQXhzdGw0VzJBY3NYY2FZbk5SQjFOSzZRMnJjY0hSUm1FQWdR?=
 =?utf-8?B?WHdmR1M2SWVCemZwSkl4YmlOdVhlUWVBOFl4N3FCcnNtdGdiMGluYXJPdEwr?=
 =?utf-8?B?T1I3amJZQ08ySVlpR1hlQzBHQ0haekNrWHVyZVB6ZDJtSWswOTYvQmE2SFE1?=
 =?utf-8?B?amVaV2pSUFlaRzR3dFB1N3RhQnNmWVVDWXpLZHBSV0luaWhSTFhVQ2UxQWcy?=
 =?utf-8?B?anYya2UwOE9jS3BUeHRxZlgxTWhwMTJXT0NITFlpZWg2aUs3TEFzWUpvdWxp?=
 =?utf-8?B?SGVKemsxRVNhNUN2ZWpPYkwvWFVTRDZITWRpbnN6QlVEREQ5K2dDa1pwd1BT?=
 =?utf-8?B?aHYzMDFoVjFHWTBiZUdtMmROMlRKRkhoTkFybzUvdmdsSWdqVmpQMkk4RFM0?=
 =?utf-8?B?cVhqMjlCbGd5V2VHdlNNbXgyem93Y0YyMlYzU1RMNVdDNENGYURLbE50aUtM?=
 =?utf-8?B?RGEzVGg5TXllM1RNaTFlY0xPVTVoS3pxU21nQXduRkZYVnYrRW9NU01LNzNS?=
 =?utf-8?B?K1kyMSsrcE5HQS84MGpoOXYwLzZ5dnFMbnRmZVFqajJ4eSthb09JSlZEWE95?=
 =?utf-8?B?L1hhUTRCM2tIbnV1UVFtWFV3NnpBQjNHS2w0N2daNjlQQkx5VEZ5RHVxY1RN?=
 =?utf-8?B?UXBCWi9NZVhGT2liSkl3em1FdENwWWN5a1F4L0NPLzBOdkxYdEQ4QVo5R1Z3?=
 =?utf-8?B?OTRxYjJNaTkzNkozTU9NdDczTjhLUWdWRHkyUXcrc2lTdXhLTFBDZ2h5TFEz?=
 =?utf-8?B?OTNCc3VhaXdoR3k0NUlkNXlJRytPeTNTMTFwRnVJMFFCUFl5YnRtcHBaOW9B?=
 =?utf-8?B?Q0tsVERmRThnTlU4Uk5QblpiaGNnTytJZnFtMDRGTjBnQkRRUjRKYlBHb2Yz?=
 =?utf-8?B?OGtoWWpzUEVORnlaV2R5eStLekJLTkRuZXZ6KzlKN1k1blAzRXBFVStKUmM5?=
 =?utf-8?B?Q2ZsZW10RTdnMTFyKzVlT01oQVE1L2I4b2dSdnY4d2xNL3VadnRnOS9GazJm?=
 =?utf-8?B?dG5QMmpRU1dyYjNKQzg5N25JK0hyRjhrVUZWVWM0RjdRNzRJMTg5T1phTGFa?=
 =?utf-8?B?OE93OUlTeWpOK2d0RndldE5aT0FZN2hwY0J5cjI0QTFncXRYUHg4SlpXYzNi?=
 =?utf-8?B?SnNhQURaSGltek9YQjI2ZE1FbG9uVjhqajRNeTdFRGNTaVU2czlKN2tqSXJy?=
 =?utf-8?B?K3lHVTlEWjJSQXZwU3ZhMHF4WnhHcE42M21KeUJGMFFXRGJzKzQwNzBPV0lr?=
 =?utf-8?B?QWlTbkdKR0t6UUhRSlFvdHRweE5DOGdYN3JNODdpVmxJRkZOZ1htYlFJWmYx?=
 =?utf-8?B?VVZjUGpXdlNia0sySWthcWNCTkJKQTdDdU5yeWxiV0RzdXpjQklJVGtzNWE5?=
 =?utf-8?B?b1d2UGltc1FtemJvdk9EbXUzQVRCcTJ6MDZxMkt4M3VEYmo2NnJyZUpQYzVK?=
 =?utf-8?B?Ui9wMDNheDdtZy9qcmpBbnpGakxvQURzaCtPYW5VeGR1M3dsVUIvZFhYbEdy?=
 =?utf-8?B?c1ZoVzBITWNNaEJyTXlqZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkZKN0VsMFZhWkk5RE5xVll5UGc4ejAzT2xJR0hsQ0ptVmNrSnJiL1ZzMHV5?=
 =?utf-8?B?Qm5rdTVYUlFMb1pwYWpwWERVZnV4S3RtVHl6c3c4Q2ljMmlIdkk3ZFREZ253?=
 =?utf-8?B?WkFUeVB3anNqSVZVK2dGTHl5QkN0ZGZPeUN1ejNvbUVzamJSK3FoY1U3bFBU?=
 =?utf-8?B?RjRqTHdsdTB1NlBXM09xMWlDdnBoTU9XNHBLeElTSUQ0RWNXdGNrZGczOEdw?=
 =?utf-8?B?bTZZNzh3RmpnTnhnQWtBUnVtU3BCMktMUTNwMmVEZDBUTzVFRUxLUTdMcVgy?=
 =?utf-8?B?cU85MEtRSHRQNk03Nk1aZ3ZLaldSaTMxbDZYQ1VkSll2eFpoK2xHY2JBSSsr?=
 =?utf-8?B?VDVLZDcveVlTek4xbmsxR000c3hlMThCNi9McndTK2tuanN1WUk0bEpFL2w5?=
 =?utf-8?B?RE1ZT2srRUJuUEhDNUMxZlkzcDBDVmpKWUtONE5GSW94T3FTbHh6MFpSZytj?=
 =?utf-8?B?b2pmc3d3RTJUUlMxZ0I2VHY3Y1NPMnFtYS9CN1FnT2Z6QVkzS2J6OGlwOE4y?=
 =?utf-8?B?TGhTUzUrdnowL09YalY5UWhUSEdJMHhhL2ZCcHBjREkrbFMzR21xaHVPRUlp?=
 =?utf-8?B?RTlYaGtaS1h0cjV4UFRiL09Xa2VNZTZxeEJ4dkdWVm5RanpjeWF1SytjVERi?=
 =?utf-8?B?emJ2VDIzMEM0d2xWKzBFZG9hazJQYzBibWJFZTQyS0JFc0FNQ21YSlBBeGx2?=
 =?utf-8?B?cnhqd1o1ajJOUnNmNFZhWmhST09VZUpTblNwV0tJcS91K2dxUVJxVFcxWGxE?=
 =?utf-8?B?a2pMeTMwR2pzUHE0K3A5dUpaOXNRVnRmSklxNEZjNk52T2J1bmZ5cHVSSnFQ?=
 =?utf-8?B?VUE2eDg0KzU3S1dPS3NzSTdUT0piQkdBN3l5N1JHQ1hTQ09wV0tDaVF6dG1w?=
 =?utf-8?B?cVdUTng2UEdSMXRBRktIaTRPa3ZCL3lRY3owZ1NNaGZFRVpwMUhCcU91akt2?=
 =?utf-8?B?b0lzY0tyQmR2QS9JejFkYlh4Znh5bndvWk93MlhKSzMyaWZYRE50cnNGbXlJ?=
 =?utf-8?B?OHhSamd3d3VYNVVISjZCVG5zckZBY3RJdUdiVGlvcVM3Z0JHNkU5SVp3eTN0?=
 =?utf-8?B?VUxPUFRoZ1liUWJiSWVVZFh0dFFtTGJuaUtQM3ZtWk1oTDBhRWRqeDdFbm9G?=
 =?utf-8?B?dGloZXNFOTFMdmE0NFNRS05FVVo1RTBJRlRKaTlGZ2NUb0pFd0dXK1pzR0pM?=
 =?utf-8?B?SHpucWpJUTNhdi9nOHNFK3pZMlg0OFd0TUpINE5FQk9Odk1Wdi9jemdnY3V0?=
 =?utf-8?B?MUI5YmtkZ2U3YXFDZVk1cEJaOHZOb0RtS0xKSUFucHcwNjk1Q2o0bHF0T2d1?=
 =?utf-8?B?ck9YTHI1d0t5bTVmTjBTMStSaGp6MEdkTXdUM3o5VXhNK2J2U3pyYnFkTjZx?=
 =?utf-8?B?T3lFQlFYcVdFS0o0SVRYQlh4aVlJYzZrQU1EaForbzRLSXhPcXd5RzNRYUF0?=
 =?utf-8?B?UGZwYWtrL0orc3IxUzFFaGxtZkpSaHVnYTRwSTZKRzJMTEpvQU9HaGxqZTVn?=
 =?utf-8?B?VkJDZ3FyaGFLaGxQQVNUR0ZvWUc3ZWZkN3M4Y1dJdWVqS0dhU01yOFRyZzJj?=
 =?utf-8?B?dGx1Z1h6a09VY0Rwd3ZPeithZ2ZBMVNlUlFzcmxDNGVzNDVqYkRtUlFXbmJ5?=
 =?utf-8?B?ek1zZVVhaDBySERWUXpYVE9MdldMQnhTVXg3WTYvQnlMT1RJU1VlZ1JNUkEz?=
 =?utf-8?B?Rm16QXUzcTZYSlFOK2xzaGxwQUFIR21PZkY4b00xbDB2VW80NzU1VmtZNTRC?=
 =?utf-8?B?SU93ZUEwVVhYMDVuMTljNVRPUlRuYWNGTDV4UFlqMXMrSE1kdkRyVkNhejRo?=
 =?utf-8?B?bEtJcjVVbHo1SzlRRzFHUm91RnowcHduT1U5VUtJSGN1UTRhdkwxbDN6NDEv?=
 =?utf-8?B?d2VBVy9mMG94VXVSN1duTWgrNFRyZUduTzdoano4eDZOMVpTanZpQ2prTWRl?=
 =?utf-8?B?Mm54b0tPdDNoV1ZkZU4xeVFaaHhOMGtyS2QyL2hJY3RDbmJLS0g4SUFDRFVa?=
 =?utf-8?B?VHE3Z3Y2aFpBdTRQM1pISlcxUytmOUJISTNJeXRuTXBRMWtVUWJkSDNJYW05?=
 =?utf-8?B?NlJWUXovZTNyendvYWZHdzdEQkR6dWV1QmgrK3NpQmgrOGFuZXJoT1czNzZT?=
 =?utf-8?B?NXFzeVRybmJpSEc5S08vbDFpM1E0L1RhSTFMNEpsbzc3Z3JFY1dmOXFYeW8y?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VUHnW72eH6cUp5/x9qQUkdtNaQ7qx3s6FLod0HTTXpDD7OLj6Ag9Jo8GQenyuJs8yipDfgEuZVnrxPGzkXYYUWvlDzZr7gpElkKVjzcocisyiHGaTbH7ivBz5djMvc/ZB8Kx5LS6nI5SMjwAK9xiQPb0nkZRYP5FbV/Cv16YflYJof7jkI1x3Vr8fxjhAWF7jJNt0HPau1GRA3X5fONumm6ooV+kNtgiibYZsgZl3O8ll/S1ddMvBuIpfnwZPpFIZTVKg5cD0QGO/StCsUgzHPnQz3uhSg7zTO3SFg2u/ciKNUDXuRvODg57qC6HIlFX8G8gNs9LZtgDjStV9+jL2+TP9h6akWwD+SKSHUFc5OzuuNRz0a2paTKr+y9uG96LXWe9fMDeEr9o8Xcx9KrthWg8hy6wpN9HXs2FlNtcYQ9tvz9oM/CamxTZD+54OWBIiCBPXYBPC1cxjHWC6FbzK+P/oc2PNpyxtk01HI4NS0VzbP8cYJUotDfYMjQuDHUJtxeeCjL/tv+bX/y1AVcB5AtbG192UB9uWT6P+aJYG0WKKb3y/F6Mt3TuncxYHQWoJD1gJxiE8OeinLnTs6qklmf1Qnp4NadjXk1+8Ezv7bU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53425c4c-e2ba-4943-4f0b-08dccde7779f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 20:15:20.9788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4GR6392108pueySU7iVJ3NWp/q/CiZWqnykm5kKoVrhGhI5YK14zpBN/fX0CvZYp7o5TVKN1ws9+s6iiXd1LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6147
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_15,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409050150
X-Proofpoint-ORIG-GUID: Z1WnxLzm-4fxeiN8DbEmJidvd9mMJwWB
X-Proofpoint-GUID: Z1WnxLzm-4fxeiN8DbEmJidvd9mMJwWB


On 9/5/2024 12:46 PM, Kuniyuki Iwashima wrote:
> From: Shoaib Rao <rao.shoaib@oracle.com>
> Date: Thu, 5 Sep 2024 00:35:35 -0700
>> Hi All,
>>
>> I am not able to reproduce the issue. I have run the C program at least
>> 100 times in a loop. In the I do get an EFAULT, not sure if that is
>> intentional or not but no panic. Should I be doing something
>> differently? The kernel version I am using is
>> v6.11-rc6-70-gc763c4339688. Later I can try with the exact version.
> The -EFAULT is the bug meaning that we were trying to read an consumed skb.
>
> But the first bug is in recvfrom() that shouldn't be able to read OOB skb
> without MSG_OOB, which doesn't clear unix_sk(sk)->oob_skb, and later
> something bad happens.
>
>    socketpair(AF_UNIX, SOCK_STREAM, 0, [3, 4]) = 0
>    sendmsg(4, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\333", iov_len=1}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, MSG_OOB|MSG_DONTWAIT) = 1
>    recvmsg(3, {msg_name=NULL, msg_namelen=0, msg_iov=NULL, msg_iovlen=0, msg_controllen=0, msg_flags=MSG_OOB}, MSG_OOB|MSG_WAITFORONE) = 1
>    sendmsg(4, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\21", iov_len=1}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, MSG_OOB|MSG_NOSIGNAL|MSG_MORE) = 1
>> recvfrom(3, "\21", 125, MSG_DONTROUTE|MSG_TRUNC|MSG_DONTWAIT, NULL, NULL) = 1
>    recvmsg(3, {msg_namelen=0}, MSG_OOB|MSG_ERRQUEUE) = -1 EFAULT (Bad address)
>
> I posted a fix officially:
> https://urldefense.com/v3/__https://lore.kernel.org/netdev/20240905193240.17565-5-kuniyu@amazon.com/__;!!ACWV5N9M2RV99hQ!IJeFvLdaXIRN2ABsMFVaKOEjI3oZb2kUr6ld6ZRJCPAVum4vuyyYwUP6_5ZH9mGZiJDn6vrbxBAOqYI$

Thanks that is great. Isn't EFAULT,  normally indicative of an issue 
with the user provided address of the buffer, not the kernel buffer.

Shoaib


