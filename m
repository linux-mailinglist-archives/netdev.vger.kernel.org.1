Return-Path: <netdev+bounces-125698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FCE96E461
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 22:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3AC289C93
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 20:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D7B1A4AA0;
	Thu,  5 Sep 2024 20:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KgipUqi7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t4ywTy/8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628351A2570;
	Thu,  5 Sep 2024 20:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725569312; cv=fail; b=Pz5beo2zDcZ0hr1MQFdfvZKvaHL5tQj6jKPlMwuBr/+O9W3bIXxrf/uf47PjXglsgB8cWT3PiB/kJ5cZZhIBjluSUOG3ShnRLRPXklzjb2gj7BaNKtUPoVjqmC4yEGVf32+NMEyLrPvs94DfsSxdLOopl42GMpu30G7ZtWFxtWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725569312; c=relaxed/simple;
	bh=ltSq8ko4wRxD5CIJEIdE1tNFzZ+BNfOl6fyxg8IxFVk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CTn0OALOAunuMFnhrZk6C7N9UbdJdcvYPkxxi9kDx6pyCODSUJvbMbJQeQUGTRS5Q6kb8yccgd+mw3QccFx1kqXZ1pXz+Z6+w/FWZ8NtLtuy5ymhBQ6dsLIklLuWTo2orWJG1654vawTVG9ZHg7bZBD2Ls+2lNlVFhJZ9JhC4PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KgipUqi7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t4ywTy/8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485KfVbn029783;
	Thu, 5 Sep 2024 20:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=03iRJlsCVHHjVX5kSUKRknbJdWzqOoCIM6vKGURgvBE=; b=
	KgipUqi7EARqy8iiG3HU5eWStffGBjDHxNci7sxe9Uaw90TK8TvKP3Zh6rTCwQjs
	zu4pnZkTjdyVMMjk+orTh7CZ91rzeZDkOap8wtWuStW5r5hR9YteA4pzrSFwh6x9
	tOnw6TAY40tENOKN65jce6mXL8HCBG48zJZuzPMPDvV+WF1aEh332FFLJp4ff0CA
	Gk59z2p0k9vc44g0QRDkN496qICMcOb4mWQeGI7LT98r2FuX4z3AIlZtoiWsOycB
	rHJSH5fs/kl8pvlj456a4hkpB+2Nt0ZJgqvJC9E3zlEs1L/C6FjHy/2SKasw7Ged
	Ht8p/2q7hyVJPK5CIHPXjA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41fhwjg99d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Sep 2024 20:48:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 485KEHw4006657;
	Thu, 5 Sep 2024 20:48:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41fhyc5dhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Sep 2024 20:48:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJ+f/w1RFrjGC3LNVF4pqGP+UW3Eayt5VkiNdYfPVe3oBLIYrk+cnBF92otpqgJq8eJZJcYFpDvGCGNrFwbsiS5JXzrjvuL7Xk9kbTe0D438ZWoImYgmu/vYEh/CZ3vkfDDEww3ha+Ay1esxLVEwvUevCVygPaqNbsHSaEOXxCPtTY+HJqm8iLQAyoVSyPO6Ncl0p3npzOA4uNNVdHXZOUWnroiCfiPuNqZvjMjQyHBB7MH9jWmoUvVGuJBRJu9NgWTFq6eaaZRL5xL4xoGQTPgll4SgTkoTqlJmaiivJG0Dd7xxhJUKNMSlDhANwWyqaDcU3Pjx31egtwzv541cig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03iRJlsCVHHjVX5kSUKRknbJdWzqOoCIM6vKGURgvBE=;
 b=sW1syYSBKw+XpcPVNUM2ILY4yd/kz9t/JqWrupn3FuTnREQO4gLZwo8LNijCheR0uPuNj/Vp3rZuupxvBymj+x2UMOfvPvo1pR3iTN4V8yQUY7Cy5OJPQ7JWmT7epXI82yDz6FfwczIEtlIH52j+8v4GWKlI2FF+PU10n3UIZC/U+DcUBT1vdvsnerc5Xvf1NBvR0fxMgevNN+oeaz4MiaR9hzeUOxpfknDqWQOGdmoQtb0xv3Ss7HbuIGF/ivZoK3g2FEdwh5Kh2HD+EAgb28dEyfDEmM6TgY9Qw29TCqddASixyZGbXkQVM8VAdanqVH5ODamYzDgoWzOVfBNsOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03iRJlsCVHHjVX5kSUKRknbJdWzqOoCIM6vKGURgvBE=;
 b=t4ywTy/812YG5T1+PVFmlb0XZc2p+Kl4zXf+8a8tdFBjFOxae2cRWNXjqUzJC7vjsokNiQ01YuB7Z4rT5c/UPdb7FIb7cXubg5JpX1BAUpnV6KW6VaMHH4rMlRG7zP7OCsIazVKlplMz9hqWlOrc2i16RDMZE4TfedEJwaYRRtc=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by SA1PR10MB6448.namprd10.prod.outlook.com (2603:10b6:806:29e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Thu, 5 Sep
 2024 20:48:18 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%6]) with mapi id 15.20.7939.016; Thu, 5 Sep 2024
 20:48:18 +0000
Message-ID: <19ce4e18-f1e0-44c4-b006-83001eb6ae24@oracle.com>
Date: Thu, 5 Sep 2024 13:48:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 unix_stream_read_actor (2)
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com,
        syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
References: <e500b808-d0a6-4517-a4ae-c5c31f466115@oracle.com>
 <20240905203525.26121-1-kuniyu@amazon.com>
Content-Language: en-US
From: Shoaib Rao <rao.shoaib@oracle.com>
In-Reply-To: <20240905203525.26121-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:40::20) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|SA1PR10MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: d971e910-ddf6-4c61-ea7d-08dccdec121b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0ZqbW15eVNNeU1SM2dtRHR2Q1ROclNvbTFyamUyNEQzQmNOSGNFdVBkbmFp?=
 =?utf-8?B?ZXRsY0RaWWtMd29NeFVQVEdqZzF6OEJmdzZJWG5qdis2MVN4REhHZGczQ3RS?=
 =?utf-8?B?cVR1WDcxRmRkS3VUbnExQnAveFhDSnEvbFp2UWxKdGkzTU5YeUtjaFBMTnVx?=
 =?utf-8?B?SW1HVkFoMXFSbjZUcTkrVkhxcDNwUXV4NElxMnc1RlUxOEJ6VGtzekRKUmNi?=
 =?utf-8?B?Rm54emV6eUhTU0RVYTR1a3RSTXREc1hRc3V4RFYwcFZ5NTNMZU1LaFJmZW9R?=
 =?utf-8?B?YWhKYlB2Nkl0QWJJUG1TZ3B0bXZjQlBHNGdDNTBnS001LzBlMzRrdXhEM1oy?=
 =?utf-8?B?UUhzREttQ3BTME4zNk5WTmxwZWFDckg4clV6OE9BdTgwNlhMTGdsYzFpU011?=
 =?utf-8?B?TURQc09mbnhzYlpyUmFpSFFUL3k0S0ZVOGNBbnVIWjVHVlZoYW9VVTRJdXcr?=
 =?utf-8?B?cTNPYlR5Nm5QYTFZQXlodGJCcnowNjZVZ2tsOFNXc1d2dEcwUVFZckZ6RENq?=
 =?utf-8?B?SVExamh3cXp4QnErbmdRZzdjdTBjSSs1ZXg4NVcrVDF1emZUanZ5NFFtYlBV?=
 =?utf-8?B?aFo5TzBBUWVFOHZtQW5mUUp0RURaR3o1NnZEY1dJTVlmbU5zbW5lSStCc01G?=
 =?utf-8?B?UWNxTXJkelgwUVpWcHBJZU1MNit0TlBua3l6U0RYZThZckYzVTBEbWZBNXkr?=
 =?utf-8?B?MlRObTIyTWFBdC90bnZHL1c5aXdGd0xtalBEZUppbDVTRnAyMHFYLzNlcGt5?=
 =?utf-8?B?Nm5QYkJYTjd2dkVIVlJjWVk3SnhwZWsyd0JLbnhCMDVQZ0svdzljbzB0eDdv?=
 =?utf-8?B?cFhmSEZLZ0liNk5vU1RPTnV0Ry9yWG1wQzRpZHA3YngxVE00ZlZMUit4eXJF?=
 =?utf-8?B?U3RRRnJ4aks3T2YrNi9YbGZvNTRJTmRlQWQvU0IxbWpRL3FlckRwR0E2UWRl?=
 =?utf-8?B?WE44TDZHSjZBN0V2TjV6MGFzT2VlV2pSZkpHYVY3RlkzK3YvSjhCZlBtM00x?=
 =?utf-8?B?a0JkdGhLa2FOOTVaQWNjTHg1eGNDdW5MbStNMVZGTTJXWlRWRENKd1VyY1Uz?=
 =?utf-8?B?cEowMlRzRVU3R0JLRHQ1cENlQTZBUmI4dVJ4T2d1L0EyY0hzUnI2NExQdUhy?=
 =?utf-8?B?RytmWEN6TnViSkhnMERqTlllUUFXd3l3UGRaUHNnK21rWHRQTGphVWE4am05?=
 =?utf-8?B?WWdHcnFaQ2hRV0c3Zml6OHQ4ZDUrZkErbnA1QXNUUDFpajZ4L2dkcEp4MnJT?=
 =?utf-8?B?allqSVo2cXJXUklER1BERFlXQlN4NkkzWWhFOWFzYmVqZzdOQlNhNXdpemNq?=
 =?utf-8?B?c2Nsdm5qQy90TituRlRNSk9LNkR3MFkrcU5kQ2h2YzhHcjZuNFlvYk4wS1E2?=
 =?utf-8?B?ak0vL2piR0I3MFFibENRakNDQXpSVlhJc3p1SnF0VUI4SVEvckFjOXphL0hY?=
 =?utf-8?B?eXVsSHE3Ulg0Q1NLZ2tUd3JGZzdXL1NVdjNhSjVvcGlVeHVOY0hjUm5jWWlz?=
 =?utf-8?B?NHlMeHl3NUluWXpzSWtSODhVRHJ6dDRScXdmcENnSndMVmYvN1NqanJZdmpw?=
 =?utf-8?B?R3dNZDMzTHVLMFp6ZVZFaGhlTXg5cCswNUJpQytWMC9pblN0UzBFZkFBN1hh?=
 =?utf-8?B?WVQ0dHV2N3VkYUlXYVV4VHRXVnFzTnVKVmV1YTBsMkVTN0tkQzdWZ2lJZStq?=
 =?utf-8?B?WlJqK0hQN1plVWlyT1o4dTkxaGNzNlp2eFdjenF3N29FaEEraU5ERkhkSlhw?=
 =?utf-8?B?RHM2c0pMQTJyNHVhNU1kM25JRGdjZCtVVlEvV3hIYzkrNXpxVUFWcmRmOTg2?=
 =?utf-8?Q?mL6j8HklnHeP7AiESfiJE04D1ItqDbjTFc9oQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qm5DUWpCNGQ5STl2ZXM5aDl6Y2NKUER0QlJ6ZVYraGsvSXdZU2FrQmxlaWls?=
 =?utf-8?B?c0VOT1VoMkw3RUxURERzTVZGZWU4ck9telN0OFQrUjdZdlhWamRCWjFJMEpS?=
 =?utf-8?B?VHBUVUJVSlNhS3RjY3QzRzl1OTlBMVQzanVBQm1seWs3UDU2NE4vcWcybzlB?=
 =?utf-8?B?QjVhd2I2R1NmSHhJYnRlaEo5V1Q0SHpPc2dTZEV5MEZYSmVyMExva2gzdWpy?=
 =?utf-8?B?TkY1N1B0eXlFbEtLS1NSMG9UTnR5OURybVhVUlBIQ3l6U1NnY2JqbzVJMEt0?=
 =?utf-8?B?Q0JBZ2pGSEpkTHk1bXVEb1doV00zSU14K3Mrc2ZzRzFBemdPOVg5dnZFaXBl?=
 =?utf-8?B?NVJQakpUblNDUzNka3VxdE9FUmFMREpTalJ0MHYwUkRjbGZoblNJMS9SRlVR?=
 =?utf-8?B?SmxuYmdZTkx4VWh6Y3hzTFU4ZGh5UWtwYXdMOWg4Q2FyRGx2bzR0QWJTTXB4?=
 =?utf-8?B?Q09mZGt4Q2Y5MGlIalBRaitvWmJJNEdYaWllalVhZVh4RlQyeXYrZitWSmRM?=
 =?utf-8?B?UCtqVG5UNStsZzJxeXFLUitXSXd0enNFTmV2Znd2SXRMMy8yWko0ejd1MkJz?=
 =?utf-8?B?ZFlyTit3YkFBTFBycTNMbkdXOHA0M3ZHMStoKzcrU3JnNS9oTHhpczJaaUVM?=
 =?utf-8?B?M0ZtakE4Q2hHNlYvbWx6Unp6UGNjdFZqY2laQjJnTlh5d2h5UHovYVdoRm1q?=
 =?utf-8?B?ZTlSMW83ZSt5Ym5STUlUcXEySkhVdkNzY3Jnak1UTHByaWRwOTUvRklHTmZ6?=
 =?utf-8?B?VHJRcUtyU0RDMHRRVHNyWCttWHdZL0JxdW1NV0ZoU2l2NTRwZTFQY3VRU1g0?=
 =?utf-8?B?clBFVnlkQ1l3VEcxUGpzTDBDTWZCbWhiL2VVZjBxZmtIOGsrNHFmR2VSb1ln?=
 =?utf-8?B?emt4QzU1QkkxUTBFd0h6cFN2cXRBR01vS0gyS3JJNUxoU1VZWExpdXYvUXp2?=
 =?utf-8?B?NnpjVHd2SGVZZkpGcUVFOGRSdGY2UmszN0RHSTJGaHVZL1RBSEZLVWlLdkdk?=
 =?utf-8?B?V2psZDVmZ0xJZ2xMd2pwbzdwNTVOeDZNQkZUL3JjSUViZkdXMVBqeDNROXhO?=
 =?utf-8?B?SUtJVElQTTQxVTkvMkxaeFJsWHNrZXcvWDlxcnJ5SnNCRDVtb3J6QzhpRVlI?=
 =?utf-8?B?WVhscXQyVzNwdG4rMS82d2JYTXhENzhsN21qdG8rUitoSCt4VGN4V1JHU0Yz?=
 =?utf-8?B?bzdVYzR0RnBEZFNUK1pWaE1KVUgxem9SYlo5VWJUU0NIRnlGUjZtNlBkRnBi?=
 =?utf-8?B?eDhVaXJobnA4elhsQ1VvUEY0ckN2NUJlY0V4T3kwOWwzd0VTT3k1cFVRV2py?=
 =?utf-8?B?QVk2WmxmUU5ycHJWTUduUkc4UmFyRThuNmw0c1o4NytRdC9aaVhCV210M3dk?=
 =?utf-8?B?SXJhSjVmRWtYUkhLZVJEd0lUcUV0ODRzTDNGcGMrL1EzWFBFUldpZSt4VVhx?=
 =?utf-8?B?b3g4VGx3QUc0cjBvVDZLZWhhK0sxdmtMeDJ2QXp0citsdUV4NVFCemg1VVkz?=
 =?utf-8?B?LzQ2cUxsR3AvUDUxWGpIS0VrcHBsR0VpdUdxWWQralZLTE1NSmNRZml3NS84?=
 =?utf-8?B?dERtUU13ankrL0ZrVVFpVG1FMS9xVTlqeXR2R05rWVA4V01vb2lPZUY1Z2gv?=
 =?utf-8?B?N01zRlB2VTR6QUk0Y2VCZ3JXK3BhMzl5ZUFpK3N1L0pBSjVHTC80dFF6czAv?=
 =?utf-8?B?cmJ2TGFTQ3E2dS8zNkZYcW1la05ub1FNQVBjTXFWeHlPeVpxdFFkbHVOdUpC?=
 =?utf-8?B?OWVaeG51cUFITTFHZnh5SHd1VkZVdzFaU042eHpLNkEyQ1lnODMzdkoyalpV?=
 =?utf-8?B?OUozdlNlcFNBeVVHbC9DaWllbGdkTXpJaHg2L1YrU2IyemxlSSsxSy9kanI1?=
 =?utf-8?B?STRCeUFRbHlvTWtLVW9zZFhrYmFCL1RMUEtjT0dzK2o4dlJuTWRtd25NZVNO?=
 =?utf-8?B?OHhQY0hCVC9VS00vY08vbWp3elA1blpxM2hySHZkb3JlTzJPdC9Ma2lsOXpC?=
 =?utf-8?B?YjlnRnc5UXVkTE9iRnZQUzlZUEtBUUlnVEFDQ0dqdDU4Vy94TCtVbm9oTWpC?=
 =?utf-8?B?dWJ3WmYrVW1oVkh6VkJna29hSnhvdmd4RkRqSHZVSVlUa0ZsMUF0R1NLd1pH?=
 =?utf-8?B?MUFTRktRdExvVUxZOTE3ai9iU0plcFZmOTZSd3N4dFVLOGtZRm1helJ3Vi9a?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ogTnGejsWwb8gUSK9YGhVfD9/HznE18QnX6mx2HnoUR7NuhvQJf1639SEQA0cY4fxmecJ3E7t1nl50YSjoZfmDvX3QaTQF/veryWCUfaqCs+ligVj8/0lYY/dfdsNQgMgFUVtEeJeIqZr20f8kMND2LLFornB00CzFEqivTI8SgiR4Rp3dGiUfStzosbI0GDvjRmFt+vDC5ZY4DGb5RM1ZmhlRzJG/oHY1sSuTiPVhAup8vhbF7qODEeFhShOr8nJQY5wZ0L4xW/UPnacphmcutNWvCNPIxP8krirVQ8FWpwFcmsSLEW3UqRxlVWTkUBNm8HLUKunGfYjXPZDvxNr6zrD9eTYe4y8hVK6aflZFU/f5I6vIvxO1PtnSg3kQQgWF7O7oEZoDBGt98eZij0dgrEwHO0jCoS47i4GzpWdd6M5EL2vXeLsWK8crjQ0jf0tLZ1lvQkn0dQEKrf5fBcDz/1fJnM9hdtput441OdFMNmcASRfAC1ORFVt5XgtUsdtAq0wxDOb7jePmB1bm1hMbGAEha7xzUldJU7OkcNOS+bwbHEMxK4jt9Nc+IwX+RzHQvTtSPmApZzZZBc0T7IqVD7pGUxRBOSaeuBbJWa2Bk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d971e910-ddf6-4c61-ea7d-08dccdec121b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 20:48:18.1881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5MFs08OSCFePju+VmpLBD9XE5Vqz8LNXVYovlk/EjD+eVdoPvaSUinqdhNoHOjkwCPYPNWTIn+Mb8hCEYB64Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6448
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_16,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409050154
X-Proofpoint-ORIG-GUID: SmcI6_Kot35vxfRyA_lEwLR7OJZJXl0T
X-Proofpoint-GUID: SmcI6_Kot35vxfRyA_lEwLR7OJZJXl0T


On 9/5/2024 1:35 PM, Kuniyuki Iwashima wrote:
> From: Shoaib Rao <rao.shoaib@oracle.com>
> Date: Thu, 5 Sep 2024 13:15:18 -0700
>> On 9/5/2024 12:46 PM, Kuniyuki Iwashima wrote:
>>> From: Shoaib Rao <rao.shoaib@oracle.com>
>>> Date: Thu, 5 Sep 2024 00:35:35 -0700
>>>> Hi All,
>>>>
>>>> I am not able to reproduce the issue. I have run the C program at least
>>>> 100 times in a loop. In the I do get an EFAULT, not sure if that is
>>>> intentional or not but no panic. Should I be doing something
>>>> differently? The kernel version I am using is
>>>> v6.11-rc6-70-gc763c4339688. Later I can try with the exact version.
>>> The -EFAULT is the bug meaning that we were trying to read an consumed skb.
>>>
>>> But the first bug is in recvfrom() that shouldn't be able to read OOB skb
>>> without MSG_OOB, which doesn't clear unix_sk(sk)->oob_skb, and later
>>> something bad happens.
>>>
>>>     socketpair(AF_UNIX, SOCK_STREAM, 0, [3, 4]) = 0
>>>     sendmsg(4, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\333", iov_len=1}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, MSG_OOB|MSG_DONTWAIT) = 1
>>>     recvmsg(3, {msg_name=NULL, msg_namelen=0, msg_iov=NULL, msg_iovlen=0, msg_controllen=0, msg_flags=MSG_OOB}, MSG_OOB|MSG_WAITFORONE) = 1
>>>     sendmsg(4, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\21", iov_len=1}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, MSG_OOB|MSG_NOSIGNAL|MSG_MORE) = 1
>>>> recvfrom(3, "\21", 125, MSG_DONTROUTE|MSG_TRUNC|MSG_DONTWAIT, NULL, NULL) = 1
>>>     recvmsg(3, {msg_namelen=0}, MSG_OOB|MSG_ERRQUEUE) = -1 EFAULT (Bad address)
>>>
>>> I posted a fix officially:
>>> https://urldefense.com/v3/__https://lore.kernel.org/netdev/20240905193240.17565-5-kuniyu@amazon.com/__;!!ACWV5N9M2RV99hQ!IJeFvLdaXIRN2ABsMFVaKOEjI3oZb2kUr6ld6ZRJCPAVum4vuyyYwUP6_5ZH9mGZiJDn6vrbxBAOqYI$
>> Thanks that is great. Isn't EFAULT,  normally indicative of an issue
>> with the user provided address of the buffer, not the kernel buffer.
> Normally, it's used when copy_to_user() or copy_from_user() or
> something similar failed.
>
> But this time, if you turn KASAN off, you'll see the last recvmsg()
> returns 1-byte garbage instead of -EFAULT, so actually KASAN worked
> on your host, I guess.

No it did not work. As soon as KASAN detected read after free it should 
have paniced as it did in the report and I have been running the 
syzbot's C program in a continuous loop. I would like to reproduce the 
issue before we can accept the fix -- If that is alright with you. I 
will try your new test case later and report back. Thanks for the patch 
though.

Regards,

Shoaib


