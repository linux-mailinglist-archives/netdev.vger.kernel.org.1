Return-Path: <netdev+bounces-239874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9D2C6D6F2
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD08A365C4F
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34B02F5A09;
	Wed, 19 Nov 2025 08:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CvGwz+ZR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k9mhX9Nb"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8922F12AC
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 08:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763541096; cv=fail; b=j4ea68RFCNzKxVsyFhVk7dLot46lK1cz4+73jn3hJU8zgt1jKPghgRWfT2Gr1x59ROz9i6cC5xQOIKRoOuFCE4FcZJfGOFMgmuyvhts0Z7BKmP20nuWm6IjRXrdB9sl8v+iqBdJ+UvH82FFtlscRQjTi8PdznXB5xif0XZgv/SU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763541096; c=relaxed/simple;
	bh=jWMbUhgyTWUN6PToz5t6uMPV9Qor1sI9Bygnov1eRA4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dSpYKJXZyqwY9+d7IMOiQTkRYJl7HqBJM1ga334D7R39/dujfUawb5MmvII139rv3LLEmTIQ3ASFDn86UOvCpZoUdF56pm2o/tMfwS5Q/Hyay3wYErVbrmk1cyCyHtAIZF1+7kkPRmSCHScDEP2qS1xWxMQw7gC/YMIY+GR/DqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CvGwz+ZR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k9mhX9Nb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AILNIFT007531;
	Wed, 19 Nov 2025 08:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=DWK90KMCJJ1IXxq5YyaZH+fBkTNBnmcuhs1T6ftiZQw=; b=
	CvGwz+ZRkG61BiOKKnJT/sAcCghm4d4GNfR/dC/pwlw3A4Pq8ZahdSGdOgJhRul6
	HSGNrbsWpDI+e6pKem2zggRz6uNg9nS0KnMZSbX9lGST49AiR7gWC0uTtLUMpcoa
	6HcYAVi6YajXa2EafViSK07586lOFeZVlVM0+7/U2G0iNQ3uaQx4HZNlirmcvXSa
	b/FK5wT1iYvSYd0sRHyizOTE6DCALd1KA02J19OnSR4a3+vZDzZ6AJmDy6wjyL6S
	cZO2GAgN5NCi08xrCsWA401ef/fsc62xA77r/ufAtXSfCj0ZjBOiVg/o1qXwwO1z
	gKMc9423wl6NJORm5ZD9bA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej966gsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 08:30:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ7QI1N004322;
	Wed, 19 Nov 2025 08:30:55 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013070.outbound.protection.outlook.com [40.93.201.70])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefya1gjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 08:30:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMm18yCqbXTmdnxzILZtmkonYQxAF6Y7i5fQJLCFmCap06YOzZAoIQfgtelYBv3zRu9imwV6nNgbqa8bnBpCfdRzPLbPQPrtKmUOrg+r5vztQzc6VN1UFdc0elqODJSB4foqPQrBO3qksScgcv1g+uesecbP7lZwTP9kZ+YngIt6khFbzJ/HfRIZbXyCB8jWngJvE05IrTZ2pL3IvUGlluaTVTolC5vMR+eaz9omlPi3q5+5+ODoVndbDYNtVcXFZWg0hrHpTsZEhj7teYM/Tjorh5W9q3P1gVqAK5yiEZcqohjsfA6AOakSbSs+urEOH98rlnUeiUVLoqNJgeqyLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWK90KMCJJ1IXxq5YyaZH+fBkTNBnmcuhs1T6ftiZQw=;
 b=wrpjfrJ6HRNsvetSshVMOHkVOstxQgvKbMJfI1YmYrARIvEkxLJI8rh9x1TAGM35vDklV2Muxyu7Vsbch+qDQW3ef1bezaAx29y+75yKZLRorZhwH7c+kPtoHAeLeHIEWyDX8ufT1g8B99UXkxG+HTeHMvliUBtyfiOpfn5r2UjwxEuU37A/jONH0MK2CL+sM0HFw+wpgI1Qb5qH+0v9T4MiP6sHLHNZp9d8yz5Ozfz1G8Wkh+NBh9jvbq8DOpiUzvmOaQ4tw7y5LACx4XyD6LPQd+X1CjD08h3NoYwpVoKOMM4sfJjwpebwVyfZ+eFSPQiWYxmWhJjrSuS2IyBREQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWK90KMCJJ1IXxq5YyaZH+fBkTNBnmcuhs1T6ftiZQw=;
 b=k9mhX9NbnJSJQQ1XqtLIDry/QLh5zlEZY3d+xOMzvMDwugvylfUQ5BNxMKJfvP8bblXsDk9IrAWUeg6W2M81TQqa3HPUnU+3f2VlRtiFn39yqH5SCy1m+imkmjg+9sVUuaCKF6Pw64e0Fd0ELT95j03ZivxoXTmHVYSifUu3M5Q=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by PH7PR10MB6675.namprd10.prod.outlook.com (2603:10b6:510:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 08:30:51 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 08:30:51 +0000
Message-ID: <5ff95a71-69e5-4cb6-9b2a-5224c983bdc2@oracle.com>
Date: Wed, 19 Nov 2025 14:00:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH net-next v15 1/5] eea: introduce PCI
 framework
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Wen Gu <guwen@linux.alibaba.com>,
        Philo Lu <lulie@linux.alibaba.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Dong Yibo <dong100@mucse.com>,
        Lukas Bulwahn <lukas.bulwahn@redhat.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vivian Wang <wangruikang@iscas.ac.cn>,
        MD Danish Anwar <danishanwar@ti.com>,
        Dust Li <dust.li@linux.alibaba.com>
References: <20251119034018.44673-1-xuanzhuo@linux.alibaba.com>
 <20251119034018.44673-2-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20251119034018.44673-2-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::16) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|PH7PR10MB6675:EE_
X-MS-Office365-Filtering-Correlation-Id: 853ecdf7-2b81-4145-fe58-08de2745f2d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cW9vWFdsRjhCcWRjMmR3NG5LSVJ0SWM5b2xtQXgzamtOQWxXVXA5cXNnaWVa?=
 =?utf-8?B?dlBBS2w5eFA2TFJhVnJMbmdnMWlGTkV4UFVnMnpoUzVlTVQ0TzJ6ZXZSUDVT?=
 =?utf-8?B?c1dIaHZIYkNZWHZvYUNpbHc4MGFPOTFncDlFVUxRSzZGYXlUZkdjRUJvSkQv?=
 =?utf-8?B?RHVqbDBTOE55RHVlZlVib0g1U0xGS2dudnZTTVBvQWFkcVdkbENWenM3ZTV6?=
 =?utf-8?B?QlZRcUt2WjlSU010TTZ3bC96dHdhMm92ZXZpdkxUTHdWemdPajlFTVFQaDFB?=
 =?utf-8?B?aHljQ3llT0E1WENaMTZmZzhZS2kxU0pqdmZZUnQzcUlVcVhRWTVRYjZvZmRQ?=
 =?utf-8?B?angzSzBSNDUxT05FbitEY2tIblgyN3paM3NsWDNSNFI5dXNGcVp4TnFxejgy?=
 =?utf-8?B?Vzkvbi94a2VJajBHN3BNOFZrblVUNkZqU1A0aFJZZHhkTUcrckoyN1o4UTVq?=
 =?utf-8?B?V0pSMXlKY1FyQ1Y3ZUFTTWJEQzBJUUlsSllweWY4ZWwvOTVQeERad0tNTDVP?=
 =?utf-8?B?eEN1UlIvVzhIY1JoektscndnTHF0eWVoc3JYeTBYTUt6QnNaYzlrcGEzbFV1?=
 =?utf-8?B?dWdWNncvTHdNemhoWm1ZRGdXSVJzNU5nVUhuRXEwcFZwQ1V3M3pWa1NwMjlk?=
 =?utf-8?B?ejJCSVN6bU5WbXIvaWt4T2NFa2tDN1JYY3ltNU5OaHF6TTIyU0lIMTZrVXNH?=
 =?utf-8?B?ZlRhaEFZWUNtV05UZlZlaVBucTRrSlJCYUp4TXBIL3pCSkRyNUVRamluKzBI?=
 =?utf-8?B?Vms1SXdwWmVRaG9QVk9NUFNqUFNLa1dKVk9OS0FPUnZISlpzUHBXRGZpcHRh?=
 =?utf-8?B?UWZ0RCs1Tm9iTzlWZkd6SWZYdXZlU3NOVjhQWXNzeXd4S2FKOC9vZDRnNEFl?=
 =?utf-8?B?UUpZVDZob0JCMEFOZ1luUjBBazlVYzcvTFMva1Q1VjNkMEFRNjQwNGxxOGFN?=
 =?utf-8?B?KzFFSEM3L0xPdmNEM25QT2xKQXRkdWRpWHV5N1JHaTU5Z1BmcVFVMnNQMU93?=
 =?utf-8?B?dW01d0VpYWdzOThRcFNvVXBGZkhLUjR3SnpyZUZNbndjckxXcks3WGVwMHQv?=
 =?utf-8?B?T25QY2pZa09yVnR6TnBoZWZBRWxBVHNHK0w0UndHNWl0ZVZYM3pnRGVHMFQ5?=
 =?utf-8?B?UmJIUGlUNDBJYXhuMnlUOXlsSHVlTnNnWWJseUZ4S3NNaHFacS93VVdNbkUv?=
 =?utf-8?B?UDU4L0Frb0VwQ3l1Y01VK2NYNGhPMU9TRUE0M2ppMUI1alZUczdmM1g5NlZK?=
 =?utf-8?B?WERKTWp5ZTFqd3BBVzhUN1o5dUVSR0FVOHVIUElOVFd3eHBLUjZ4VktqK3ZX?=
 =?utf-8?B?RVUwcDFsb0RqYlpHbkdsQ1NSUEhLTDBDblBaK0trYUFpRmRzYzdRK2lrbGVU?=
 =?utf-8?B?bHZ1OTVhTjdYSkRoKytYZElpd0pwbnUwRlpoMGhpMkJVckc5djF6TktTRWNj?=
 =?utf-8?B?c2g3WEUxdCt3cW5NaER6YU5WNmUweEdZMWpYTFdFMUpWMlAvamNMUXplcVVP?=
 =?utf-8?B?VGFISytMbTI4SWhKSG1aR0JWdXdpRDY0SU9yM0k2bURYejhQdXRwT2FPdUlU?=
 =?utf-8?B?aDA3TnpZVGo0cWhWV0NscHp6dHQvcVVEZElRYXkrUDBQT3BlS0FGTEdoSkxq?=
 =?utf-8?B?RWdOK3o1Z2ttcGtSK2xuaWRHQUp0Z1Azb3ExM0s1VkJIMUYzaDFBYU8xTTNu?=
 =?utf-8?B?UElXNXJuczJTbDZONElQTTdFamlGb3c4cGVvSVlOVHBnWERKTTJPalR6NjVp?=
 =?utf-8?B?R0xQWHAvTlRhNXVBN3p1ZWQ5TkZPOFB1OEtyR3IvcGRuTWY4Y2hqMmxrd3pK?=
 =?utf-8?B?UktaTGQyajY5TlF6ZktyZ0FUcVZoT015R2tIVk9XS1RtL2RCa0RyektreTJX?=
 =?utf-8?B?U2FyS2FoYWhsaUJhYnhIbGgyYmVqODkyaE5yNTRsSGxRT3dOSE1oVUF6bGNH?=
 =?utf-8?Q?sTCemJPjk0XWG/oiRuHT/kVYHYdL1gh3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHdEYUFmVmgrcmIxMXFSZTBGWTNtY2tlb1h2TUdLdjJjdjJaZnVpeFhKTmhQ?=
 =?utf-8?B?ZjdTTjdETVRoMUYxUDRqdGNtQXpJUXZsUlpiRDRJdXpQZ3NsS25JWnF3Yjhl?=
 =?utf-8?B?Z3EwRnp1TFJlK0h5Q1NLdS9jaHZMRlNEbmZsTW9PdU5JMzBQc1RYUHl2dHRX?=
 =?utf-8?B?bkljcXdIalpTOHd1NTFUY2IwcGRKTFE3ZEhyR2pLa1JxSy9tME1maWlRTGky?=
 =?utf-8?B?cG9yMENnMWFwSWhTZmFrK0NLNjMvY2IzalRocDErRldjcThtZ2k2cUtkQUNU?=
 =?utf-8?B?ZVU0WjdNKyticloxN0tBNU5RYkpaNkZjbk5USHh0VjJTUGdzODR5TE5EbGZq?=
 =?utf-8?B?UVlRUS9pZnhNbnRuU28wR3hJRkdqTlZWekFDNkJKVkgxRy9OY29idEJrM0Jr?=
 =?utf-8?B?N3dKcTduQlRJdTUwaTlJbHU0RmVOSDV3MEhDODdwWkpsYmRZNTFCQ1NkMHpl?=
 =?utf-8?B?M2NYT1dVdHR3MzdCZmlrRVVxMmp4YnRCTXpNL0JIWXFqWStkbXdITnF5YXBD?=
 =?utf-8?B?YXlXc1pHSmpvbENPQ25PTXp3RlpKbmNUV2FNelBEaFBISEdsbURyenVnYWxX?=
 =?utf-8?B?THpmZnRSUVBPTU1ESm9hdTVRNmFVdkpEN2ZoMW0xL0d4Y3VreUZGNnRIR1c0?=
 =?utf-8?B?YjZMVkQ3SDdxK0N6d1V3U2ExVkc5UEYyd3pNVXF6TlFscnZ1TFhjbFBhUWlJ?=
 =?utf-8?B?RG5JMzZaY0dWREtvNWpMV29QWDlQU0dSUVYxNzZFS3k4Tzl0MmRWVkJJYWpm?=
 =?utf-8?B?WUVZWjFQdWVzdEZGUk9mUlB3OTk4NnZIUlZ6aitHOVhIcWFWcnlOekxKZkpQ?=
 =?utf-8?B?Zm9SOWdON2hzemNERmVHdXcvYlF6VzlCNmNjOTRSOFdZUldlOXV5a3VPY3Yv?=
 =?utf-8?B?TjROTEV5ZjRCQVlzc1FEN1ZMUWt4bW5iR2lNY0gwL29jam9rYk5LY044RXNs?=
 =?utf-8?B?dHBaODVIWDkyeUc1amZMUTFLOUtCbGNreENyWldJNStLL1dQNE9VVVZOU0Jr?=
 =?utf-8?B?V1gyMHNlRlB3amlPV1dUenJYMHNsczhITjkzbFh2T2oxN3FjYTBtdDBVYS9o?=
 =?utf-8?B?NkpuRmgwT1NWMVZTUFNibkxndCtwSEVSbWVjQXJaTnM2NFFlczZlQUxPMkM1?=
 =?utf-8?B?ck9GTTBXTFBpWXd3MXl0cktzMCtyY2ZKM1ZsVFE1K1F1aHlMa0g1TndqTkRh?=
 =?utf-8?B?TCs3K0hUWk5ucVhlU05qc2dLbUswQmNhS3JJYkpjUTJ6U2t4S2g5THp4VlNN?=
 =?utf-8?B?dVdjYURaTktUeUVUOE1IVDh1eFVFNHliVGF6d1l2bzZ4SURWZGRXU1FkdmJt?=
 =?utf-8?B?enhnd1E5RjBHZzc2UmZGY2ltR01pM1MxK1dmalV1SzQ4Y1BPTkNIcHlnN05y?=
 =?utf-8?B?SDJiZEZzWlEzbXVYNDIzNDZvTGJzSHNxKzVvdVpkVkg1emVPeitzZ09EZDJJ?=
 =?utf-8?B?SHZCc3ZBcjJiOFI0NGxZRHhJNFd3dEFPQkorVFpMNEIvc0lGSmdXUkVmeUF4?=
 =?utf-8?B?aE9ITkdscWVTTC92RTUrZDRMYzk0OHhydHBjWkUzQ25McnAwNm1ueUZWRG5Q?=
 =?utf-8?B?aTFyMmExV2tiYTVtWSs4eTVDZVFHaGhmbk1lalJibnJaQW5GM0FpenRCb1p1?=
 =?utf-8?B?L1pOeHhJbEZlRmRKU1RXSnRGdU11cVJuQ0RXTXdpZm5LeUUzejFxNFNtNys3?=
 =?utf-8?B?UUpiZWl2TnIwMkxjRDZ4cElxZ1JUcXcrcEIzRXUrRkF2UkdlRWZVcDZaN0pY?=
 =?utf-8?B?Q2VadUcrSVVKeEptaldvQUFkZy9tRjNkcWxndW5xWnc0RUdmaGwvdmMyMGp4?=
 =?utf-8?B?T3JRa21jQkJWeFBxVVVjcjh0Slg4MTQ0ZVUxeGhmenRHTFY3SDljRVE3SUdk?=
 =?utf-8?B?aVo5NHZyMm5Rc0NvYkJ1bUJ1bVNGaUdqR2F6SjFjZThYUjNNMXVNSEZhb1RR?=
 =?utf-8?B?ZGJOYllFTWVWYTh4UlpGMHZSREhYaXNuNUwvZUN0NG1UbThldlBBVXF5MVgy?=
 =?utf-8?B?RTNsVzU4NzNBVU9WS3ExOTIvNE41ZmFpc1ZvdzhDNC9wUytNK2dkUEljRHRV?=
 =?utf-8?B?TmxBZUMwd0ZMRzRva1Nod2JWbjJuVGViSmhxNXRsUkFYVkswdWVDdGpNbW94?=
 =?utf-8?B?U09RZHF3R24vNFdpMFJoY1J4LzhTYTNUekZtQ0ZYMWQyVGpnb3NZZHlkZGxH?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d8PRqH5/2cQuIjiMGd+uvQSN5tYTaSI8fMhhuyl5iIO2YnXYNMYyeIu+maknwTrxSZiDTYc1ulx48vwxte3Pa2MO0tKV7I7kvcY+2/MsbZAF+AIeHy20qTcRiRZMT2KNoymAYZ2pvhLY8MjRRJkjpBNhN0pBk2O588mtHJ+1dCoPB6KKSZslChQlYyQn1ATr/1GftEi4wJUrrIta9q3yAOZk4Mr2osrFolhaftz6sMt9jxrk70ZraxBrK2mSAPMgRZTJTksscexnSRaKOLJLG7rjxoGAzDRrUwnbA2tzK13LdGc8McWO8tPTuO8qWGsR2Ah0fXYKPwQU4+qYMNJ85GdQfT/9fbOLiR2xuXGux53w38scWEuU1wKJ5kZLkRejSHw1NBIj/qM0+BiMqPUW+niZ8AFsNkA8IJ7rCGLxKSHzrIzW05AnHHfBXwozLA7XfPyNuhRrSBDOIGH5UHRlHlvuS2ZnverbBv0YiFW2BKiiSvaeeL37kNqjOlOiRIG4TUKjx1CL2zHsXfhlfi6uMJ24T8ABHBoSW2ivB13lzAvG4cZPvQxphVdfPPYV2fFcWISAgHGzaGDTFkp9evAO/1hPV4t/wqO2ZPJpXiHsjdY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 853ecdf7-2b81-4145-fe58-08de2745f2d8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 08:30:51.6663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLAv481gU7etLuTMGsu96R4RflADUJMaCpWgeuavzoI3fcSklXLLxqjol2NGpMRknVIi94gRVurB5S/fdjneYOOmWkvTVT/Nz8Fs13Ulq/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6675
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511190066
X-Authority-Analysis: v=2.4 cv=DYoaa/tW c=1 sm=1 tr=0 ts=691d8040 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=CEsYN1Sl0_GjIALbRD4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: egx_h4SXU7bLZZqPDvxcCdU_lWKssTI5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX/qiw2kG5NYjO
 SbmdCEIJxwsz5L/Mv5KvFE4+tcbZHP7A4oy5pzuE4pjS9UvPlfLxessbn/cpKYfsAp8OKUmYrjx
 N4oOlGEBdyya/m7qHZTfQBegRjN+MJPX5VaNcF9+ZYIeFWFjOjbF1Q6QcxA0sdz5CMXZSbIHiOP
 LBI6Kcdr/KlMJseCWIGIxJBl4exZaU6IbVhlgou2mOh0Xy3Ay57L1C9ZYpmB3o7XHwC8qwh8N9b
 D0paVRYrbn5FK+Pl/HcKW8/QJ3BXP2wXLsQOfWrxZuPZW/6N5uGTjmb3RiaNFs/qyGtq8kZ8pw8
 xMfgXaZHHy/47XUGWjNAz+qbGjBKal+QGaDLuKp8kKDO4AO4gy/Nj05LNitq+ud69j8mpJ3CRfG
 zERDWaJHI5IQwgdruKRHz6BNSUA+Nw==
X-Proofpoint-ORIG-GUID: egx_h4SXU7bLZZqPDvxcCdU_lWKssTI5

> +
> +static int eea_pci_setup(struct pci_dev *pci_dev, struct eea_pci_device *ep_dev)
> +{
> +	int err, n;
> +
> +	ep_dev->pci_dev = pci_dev;
> +
> +	err = pci_enable_device(pci_dev);
> +	if (err)
> +		return err;
> +
> +	err = pci_request_regions(pci_dev, "EEA");
> +	if (err)
> +		goto err_disable_dev;
> +
> +	pci_set_master(pci_dev);
> +
> +	err = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(64));
> +	if (err) {
> +		dev_warn(&pci_dev->dev, "Failed to enable 64-bit DMA.\n");
> +		goto err_release_regions;
> +	}
> +
> +	ep_dev->reg = pci_iomap(pci_dev, 0, 0);
> +	if (!ep_dev->reg) {
> +		dev_err(&pci_dev->dev, "Failed to map pci bar!\n");
> +		err = -ENOMEM;
> +		goto err_release_regions;
> +	}
> +
> +	ep_dev->edev.rx_num = cfg_read32(ep_dev->reg, rx_num_max);
> +	ep_dev->edev.tx_num = cfg_read32(ep_dev->reg, tx_num_max);
> +
> +	/* 2: adminq, error handle*/
> +	n = ep_dev->edev.rx_num + ep_dev->edev.tx_num + 2;
> +	err = pci_alloc_irq_vectors(ep_dev->pci_dev, n, n, PCI_IRQ_MSIX);
> +	if (err < 0)
> +		goto err_unmap_reg;
> +
> +	ep_dev->msix_vec_n = n;

msix_vec_n = err; as n is not granted

  or
drivers/vdpa/alibaba/eni_vdpa.c#n167
like this -> if (ret != vectors)
although I am not fully convinced it is ideal.

> +
> +	ep_dev->db_base = ep_dev->reg + EEA_PCI_DB_OFFSET;
> +	ep_dev->edev.db_blk_size = cfg_read32(ep_dev->reg, db_blk_size);
> +
> +	return 0;
> +
> +err_unmap_reg:
> +	pci_iounmap(pci_dev, ep_dev->reg);
> +	ep_dev->reg = NULL;
> +
> +err_release_regions:
> +	pci_release_regions(pci_dev);
> +
> +err_disable_dev:
> +	pci_disable_device(pci_dev);
> +
> +	return err;
> +}
> +
> +void __iomem *eea_pci_db_addr(struct eea_device *edev, u32 off)
> +{
> +	return edev->ep_dev->db_base + off;
> +}
> +
> +u64 eea_pci_device_ts(struct eea_device *edev)
> +{
> +	struct eea_pci_device *ep_dev = edev->ep_dev;
> +
> +	return cfg_readq(ep_dev->reg, hw_ts);
> +}
> +
> +static int eea_init_device(struct eea_device *edev)
> +{
> +	int err;
> +
> +	err = eea_device_reset(edev);
> +	if (err)
> +		return err;
> +
> +	eea_pci_io_set_status(edev, BIT(0) | BIT(1));
> +
> +	err = eea_negotiate(edev);
> +	if (err)
> +		goto err;
> +
> +	/* do net device probe ... */
> +
> +	return 0;
> +err:
> +	eea_add_status(edev, EEA_S_FAILED);
> +	return err;
> +}
> +
> +static int __eea_pci_probe(struct pci_dev *pci_dev,
> +			   struct eea_pci_device *ep_dev)
> +{
> +	int err;
> +
> +	pci_set_drvdata(pci_dev, ep_dev);
> +
> +	err = eea_pci_setup(pci_dev, ep_dev);
> +	if (err)
> +		return err;
> +
> +	err = eea_init_device(&ep_dev->edev);
> +	if (err)
> +		goto err_pci_rel;
> +
> +	return 0;
> +
> +err_pci_rel:
> +	eea_pci_release_resource(ep_dev);
> +	return err;
> +}
> +
> +static void __eea_pci_remove(struct pci_dev *pci_dev, bool flush_ha_work)

what is use of flush_ha_work

> +{
> +	struct eea_pci_device *ep_dev = pci_get_drvdata(pci_dev);
> +	struct device *dev = get_device(&ep_dev->pci_dev->dev);
> +
> +	pci_disable_sriov(pci_dev);
> +
> +	eea_pci_release_resource(ep_dev);
> +
> +	put_device(dev);
> +}
> +
Thanks,
Alok

