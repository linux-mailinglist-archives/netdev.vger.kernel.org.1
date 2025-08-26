Return-Path: <netdev+bounces-217064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D50B37397
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 22:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE383BF98A
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 20:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068A02DEA90;
	Tue, 26 Aug 2025 20:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EIKTXdQ8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FpJgSrYV"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F905238C23;
	Tue, 26 Aug 2025 20:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756238792; cv=fail; b=AGrkTdzvutAo9xQawEPdVO2m7oq2dYPFCzlN2yitc0xo1DiUdUYX4XDM8cLaGm3Pqu8ePeUz77rkAC6Jupkiz7ycLgyBryzEiBfeWRe3usZOJsDl4XomnwAJYolta2UhRVlwU/4pBKsMtKXucZzDlcJZ7OeumzgEPFe0P13ZqYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756238792; c=relaxed/simple;
	bh=2JyUK/H+48lVIiwS0zu7II1wXapiFMFUQKkoYJOmS6w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d2Qw0y4mnxmJKViGfHAFSLBKbROfXn6em8vnP4e8fC/DcWBcBIlhH3FHRrpdE3Knup3cw7NbS8/yoMedLDynEskeIwvYz7m4SIhPOPSr3kGUQYlVuJ9ICibvuHI9vEbZwouyVAMz01lTjP08mcLYW7fCloWYJZnEtyBAeTCBu9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EIKTXdQ8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FpJgSrYV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QItvJ4013507;
	Tue, 26 Aug 2025 20:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=05z8Jjrn3TXPGOwM4hEeWw0Ft09fdBoCkzxgYtJMNng=; b=
	EIKTXdQ8pJaHNm/DGiZHv+CHUeq2cJbPYfkCkMk3IK3yDCbemgyiIytXKga3GXnK
	tWOonYejjg23LRIaz7GsDrVuEvIkQOOM9H3/964nMKJhUI7++CFOHuAKNANLsaBh
	bfuPi1y3HcgXvXg+n5o+A18PFYh4cvdyk36zf5b1ZZNMchCsVF8pfiGXUxkfeB+3
	qQatW8pmc2BykmHFqOEDe72J0EmPYW/ET1fBdeyyAsDprkrwkXhyoz4SZjvFQr6X
	F0fGnCN00BUPIggHysGL8I+hPWAdtkg3hRDVsEa/z7DaSwx0kd8x8TMHLVQOSTOf
	9KYVugikQVAblCkkoXUq7w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q58s57tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 20:05:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57QJ58F7018954;
	Tue, 26 Aug 2025 20:05:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43a1pav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 20:05:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yudm7w6ICaAoHgJwQ3TZyyDdmYm3+AazrQ1/WD9Vdh1VxNPZoCqtB8Vfn62YdrKK0zdu0qD4S28sYK9KYS5EuPaWgAgmjJEOLdf9J7ix+NR8np6crw4YONiGC5nu4qI3PGDGpIJgncy3ynoYpFJ0xAKo2GMIi9LaA2LmofQSiJ4n+E0Fc6XOFnNhJyDJ53BxaBCkIwNVC2iZUhzmKMWsvCZLUvAkNPZx8CKvILZ0AIqXQAVAcTJdjDWIr4oLBfBzRHQb+bv12GXDlgSN/t63Oc810fpCZOL9bZZK+5KGruhO8J+YvbbkKYe6IeDlH2g/Nfn3XjMrdUjT6fIq14Q3Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05z8Jjrn3TXPGOwM4hEeWw0Ft09fdBoCkzxgYtJMNng=;
 b=I0oX1y99oUfg+vqUtLMMGbzfNymIQ9xSSMyWSjZKOduIfBadIlf7fAQvAARWGklr2H4FnyrKRPuk/0u125+AoDsUD+Tzdo4XjQTKaJ7E+SPIGtncw9Qi0K4WF8PJht8PlD1WR9rp+6BlCzdzJmfKZKGxACr2SxZTf0NU9Vz6HhqG7zqD8ql1kX5aTZiRRYZWjNANBYaOqGMT8qik7sZQT9bhy0LhKGMQQG4S1Ll6A649mz2t+K8FQFYEqFqgmXUYCDK4HXSQaKR2h2fT2ez+JEDTMqVZUknBU0Hok8Ub6sQQIUimdCyWMpsouBtM6Q6Uuc7sYzStNZbrxYNfYGwjsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05z8Jjrn3TXPGOwM4hEeWw0Ft09fdBoCkzxgYtJMNng=;
 b=FpJgSrYVjPT6o1ija63OhDSEf33YVdHFssWtmrSgvIl2XBNKG0Hg2WD5sfot2uFXET2ckukkfjTysiU90Au5ip5gkZwcrqlNrYXLeN+gys841dFAyxUZzaV4Qj5vTpSplo8ZZxZMPx5w2IQKwKrPn3T8baViU1bMYk6ffzsRBo0=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by PH8PR10MB6479.namprd10.prod.outlook.com (2603:10b6:510:22d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.22; Tue, 26 Aug
 2025 20:05:22 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.9052.017; Tue, 26 Aug 2025
 20:05:22 +0000
Message-ID: <1cad9cb1-bb70-40ac-a28a-488843625042@oracle.com>
Date: Wed, 27 Aug 2025 01:35:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v01 07/12] hinic3: Queue pair resource
 initialization
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <helgaas@kernel.org>,
        luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>,
        Shen Chenyang <shenchenyang1@hisilicon.com>,
        Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
        Shi Jing <shijing34@huawei.com>,
        Meny Yossefi <meny.yossefi@huawei.com>,
        Gur Stavi <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Suman Ghosh
 <sumang@marvell.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Joe Damato <jdamato@fastly.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <cover.1756195078.git.zhuyikai1@h-partners.com>
 <f1be4fdf9c760c29eb53763836796e8bc003bb1c.1756195078.git.zhuyikai1@h-partners.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <f1be4fdf9c760c29eb53763836796e8bc003bb1c.1756195078.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0363.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::15) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|PH8PR10MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b7abda-8bb5-4767-14d1-08dde4dbe364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTFjUEtnVUxXSno2WTRTUGkraG9TemNaNUlzRzlFQTFVcGFmZWJLOXZjWmh3?=
 =?utf-8?B?SUpXRlpVREVJTGhiRUJrd3lHV3JMblpOa1FpRGZFWkdqVnlTR1ZZVW5EVzll?=
 =?utf-8?B?ejQrbll3eitPU3NFcVBjYlV4eEFteFl5ZUFqZkdtWEpKVklWWWZKM0c4aUZ5?=
 =?utf-8?B?cWxhemFkdHBXaU9KTTdLZ2RSZ09uMHFSMEkxaG9pV2dxWS95OSszeTVBNUxa?=
 =?utf-8?B?enBHaHNDV2F0S3lHUUNqUXVMT2RjZEhYUmFNbDVGWTQ0L09Td0FRQ3RONEM1?=
 =?utf-8?B?QTgxUERaSGt3WUMzakZXeGlsMklEUGdkWHRvd3dYVllDUzdHQXlsRmlvUksw?=
 =?utf-8?B?NXVmZVI3dytVWTRlMEtrVExBTkQzeEtGMzllR1JMQitXSWdKQnluNXZ6dDhs?=
 =?utf-8?B?ajkyZ3g2SDN5QjhDS1hjTGVIUkt4QkpsK2IzbW1kRTVkcnoyVkVhWWw4bFl0?=
 =?utf-8?B?VVkzYXRCK3FCUWZpT2hldzBSWXhxWjV5MDdiSWZmKzNpMDlMZzkwTGhiQjlx?=
 =?utf-8?B?b1lzSTRRZlRwRmFCSVZodCtZS1JtSHphbFc3YU9IRHllTm1IT3BDbE1RSG01?=
 =?utf-8?B?RWtsKytlZ3FJOUZTYXhkRXJ0cFdCRWVsV3NVUmoyRGJZV3cyanQ4b21yRXkr?=
 =?utf-8?B?aFo4ZXZMRTJkRHBMV1JOb1VsQ0FFajdSbGdvZkMrcnVNdnVSZ01zb1oxY3hV?=
 =?utf-8?B?WnJsajZ5dWQ4bjlxZkZjRzdIS2xQcjFtMW1HVDhyd2FFeGZQVVNhbGRVOHVR?=
 =?utf-8?B?ajdmRlVYTkI5enhEOVVOa1pJLzNjVlQ3QkFLRmpMaEJDM3VUcnRJUW42NnMv?=
 =?utf-8?B?QU5aak52SDJrY0dmZVA1Mk1STFEwekNSTHJCclN4czlnbTRCNmZ6RTVlNGVT?=
 =?utf-8?B?NkduZ01DWGlHQXBmc3JCTjAzYk5uTmtIeGpkcUxvU3BRbGFQZzRsUUtuUmZK?=
 =?utf-8?B?TXR0TVcycGNVcXNjYWIxYzRRbWwvUVdNUlZLZXowaVhtdlM5Y0tLV0NZOFZm?=
 =?utf-8?B?YjE1QkpFNTlwbzk3dHJRQ3lvQmVmOFhzZ003UUJmU3FqZmhKSUpGMUorcEhZ?=
 =?utf-8?B?K2RXaUg0aC9uYzN5NEFxVnduSHJuZjcxU3N2Zk1GclFYVS8zYnMxUDRTVUJh?=
 =?utf-8?B?eng2N1BiSUtvenlObVVUalVBeTk4OGpnc09JTHk2NHF6NnRYQm9iMkUxaUJh?=
 =?utf-8?B?SFgxRzVaYmZpQXl3Sm5sT1BDU3FvTG5tNDlVaXZkUzhFWTJwNE1qRzZaRWlH?=
 =?utf-8?B?YyttMWdDMytSK1RvN0JybjQvYVlUcHBlZTIvVWpuREdBRFdMYjJpSjZ1UTNx?=
 =?utf-8?B?S2NNbG1Gb0paM0dVM3ZJdFdqRkxnamFMN3FUV1UyZE1EOU1qNGVOaXdOQnda?=
 =?utf-8?B?UkU5cHE0c1VEbFduOXEzTTRkdG5HV1crU2Z1ZnhZVDBIMG5jWnlEVmUrdnNv?=
 =?utf-8?B?UWtHQlhDeDhNN0o0bkRXMzNLZjNVK3NvUTlWbWwrZUxWRlNJZnhRQ0pDNzZZ?=
 =?utf-8?B?SDFGZWdwb1E1K2w4dVkzV1dvRTlMdEs3UDdqVzE0bHpTRVpONzdUWVNrek96?=
 =?utf-8?B?dFg5U0VhWUp2d3Q2Q2FhZ2EvV2FTdWVlWkFXdG03NzhQWnFlcEJreTVOSFFT?=
 =?utf-8?B?YVhkdDhQaVlkcVNyYWFhb3pEUHJ6eXFRMEppdGRRS2xsZWQvdWVDdkdGaC9j?=
 =?utf-8?B?SnV1REpCT1FNUW5veUZNd2FpSzBoK3c5V21SaTNqZWVlMFp5c2NpckhaNUx6?=
 =?utf-8?B?MkczQVdEQlNyQU1QbGlvQUZDdGNxSVlDa05tazZlL1dtaGprNzJ0bWZrOHR6?=
 =?utf-8?B?RWdxS202SkZGMURyT3Npa3dZNFc2T1ByMDA0MlhoWk55Z0ZUM3lyMWxDS1lJ?=
 =?utf-8?B?SzJZeFdweWZOZTJVY0JwK2hiMVRjMnoyblhXZEZFT3h1SUdzVm5sN0R6SitS?=
 =?utf-8?Q?2lz/DVIhOxE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUU3MWNnTFdNYWQvcU4xelR4MTFIV3FkMitlYUFmSXNiV1lyR2VEUXo5a3h1?=
 =?utf-8?B?SHlKaFNtMituT1QyZkY2Sm9tcDVVLzk4TEJOSU1qaWl2ZFFlZHVZaHlCNm13?=
 =?utf-8?B?bGlTRnA0akZQOE9QR1FML252a2VqZU5La2hXcENQNVBlNWxwTjJ2Y1hlbW5H?=
 =?utf-8?B?U1owd3FKNTRYemJQT2pWNVJwNE9XbWhYYzNrWkQ3MC8rV0JEZnJXaVQ1cm1G?=
 =?utf-8?B?cFpFT25ibFhpSmFsa0tRNzBQenR5eWh1RVlDZmFMY2laaURHT05wcUhuWmdV?=
 =?utf-8?B?NjBlM2hMSStpcmM5a01yTUNiVStNbURDalM5Uk1OeU9YenVpcXdSc2pLVWdx?=
 =?utf-8?B?b0g0bzg4cTlQeEZaOGhnQmhmdk40K1JtTWh4L0I0TWpET0haazlSNlIvZlA1?=
 =?utf-8?B?cTl6cXFjNFA3YlZ1cVpKQXYxc0FrZGxtZGk3eU9SeUc1ejRlVFZ3SFd5dmdV?=
 =?utf-8?B?YzhUZHJwQmZIU1pqbUI4UFlEZXk1RWZjNzVWTDB3NjJPM1lydjMvT2ZzYXdB?=
 =?utf-8?B?WFBCYXpDdUpVZ2pXTVVscUh6MlJjYk9qd255czB6dDNQQVhxbmpZRTJyV2cz?=
 =?utf-8?B?bnBlczNFNDVJYmFPcVEvVDNjdEZRdmcxRlJaMy85Q2ZmdHphUmhvbi9vNlZ4?=
 =?utf-8?B?My96Y1hTVVZHWXNQY3FISytDbGtoV0djU1puOGE4YmhHWG9HZ01VVFFNcWRt?=
 =?utf-8?B?dGNlNFBkRjhCRlRhcU94b2FxR1RDSGY0bEVEV2NENHZmUTlISVVJd1N0RUpp?=
 =?utf-8?B?RHBmdjIveEVXZUc3cUhnL1N1RnZBUCtUL0Z5VXd6WDQ5OGJ4eUcrK2Nrcyt2?=
 =?utf-8?B?MGdqUW1kc2k5cGk0MS84WmxGakl0N3c0d2dxU0Z6TTBmNHRCRlk5ZkptWXI3?=
 =?utf-8?B?Mkx4YzBoWFE3cTJSZHlUUFFaeHVXcFFlSkN4UU9obWVLdzFmVmpnQytlUzg1?=
 =?utf-8?B?REpISHhrNGJxbWhYQU9RMVdNSmIyeXBNWHZSOUphZHErQnBBdnZVdHhrV3Nw?=
 =?utf-8?B?TEhEMnl1UlJIdXJnMzA2am9sM2tveGlvTXpRYUs0bWhCVGVOYU5RS1V2bjVu?=
 =?utf-8?B?YTFtOG81a1U1ak9nSVlQS0l4TGYwa1dYeVA5VDFBQzVWUWZDRC9NWjRPdTVX?=
 =?utf-8?B?bUVMbWljUkVtOStiUi9sWnl4ZVUwUWZKRHplRzRLbnhhUDZmZW5lSE1kbUow?=
 =?utf-8?B?L04wRTJjb0x2UDVsWnozQ3dtVWZPT3g1VkNZYWwvT3QrcnZ6N2RUYkVHdVB2?=
 =?utf-8?B?Z0NTaVJNYWhTaHZPdVNpdnpnNFRQR0p1aDhKaE5NNG1yNjFpVm9GMEhnbDM5?=
 =?utf-8?B?L0I4SEx4WXVKd3BIU280YUdtYnJ3c0dqeGJ1MDE5SU04MGlhOGthWVRUUGFy?=
 =?utf-8?B?aDlFTmd3VHVqSnpHS3F2SG9WYUI2ZHhMT2JSQVlldE96dlRSRG5LczdoQVNX?=
 =?utf-8?B?dEdWQlNNOFJ5OXp3SkkrUmNKb01qZVJFdFpSUGJ6TWlzVll3bFJTYVkrb0VG?=
 =?utf-8?B?cUh6V1pQMTVENkdHSk9YNC9ISnZ3V1Ayay81N0VjSDhFbVdIRktSa002TkxZ?=
 =?utf-8?B?QmRMVUJRdVV3K2UyTEFuZERnQ20rcU8rN0VBV3Q1OHlQcEFLUWdFVnRhRVl5?=
 =?utf-8?B?Sm5nSjhveGM5LytZK2pETm5rbEVjRmhxNmFiS1NaeHRFYjJWQjNoOVFKL25N?=
 =?utf-8?B?VHhuVmZFc2toODJwZ3dBUjdJejhOUnk0MGdIK0tCQmlSc3ZLVWZzb1N3dGxI?=
 =?utf-8?B?d3E2YTNJcm9aaXN5YVlyUXdSdjZXV3FvRzdsOVpaaWVMOERWWW1RZ2ZEdjJD?=
 =?utf-8?B?MUZyb3o4eU9PLzFIN3c3RzNlSm1xTFQ0YnNJUjNEcGR0UTk4c09KMnZEemI4?=
 =?utf-8?B?YmJpQmhjZmZZMExTSlhlUW1wOTV1VXUyRi9YeFhldk5TdEdVRlF3RGx5TTgy?=
 =?utf-8?B?Yi9yVEtqb28rZklKR2xFVlUrMGZyV1ZMQmhCcGpkZE5UaW9IM1NYR3IyL3JL?=
 =?utf-8?B?cUJsMWp0aWtEK09wdmowMDByb0o5cUVTSHllMmhxRjdiSmdxNGQzZzBxQU13?=
 =?utf-8?B?YUFpRWxsS1dJMXFlRnJIU1ZtNzlzcG1CZkVIeStzSnhqamNPNUNiMi9GQVdK?=
 =?utf-8?B?WlJVMXlhTGh5Y0szOG1ESEFKMHNHZzhsOWV3cWtnOXMrYkw4ZlVjbStOVjRJ?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iM1eza3B0D28Vm6qm8VZVGuSqNOn2paWXg2cob421uxyY3CtJdRhYRVd5F/50PujR+7+QeTFI7GKJ7hIjIToAtCJuAqRyuLuIce4uEemlrZ91HFhr5NsgoyWe5QWPim3aGgsc9KCteA9d5ze8jFP0FzCjLBY/hY9UjFCTZe50dXY8v6Kks57SsfVe4ACkwPT9FAw1z0GiFdfTZlD/fxmTtFkofvVkFa6IEwIi5qAfK9M2TvIJ2NpfFH80+/R4/rhWxaAS34FoCQoXYni7J58mpfZLGR1BvjdDFKoFf4qP0wfBZO+wXWhOXXyUgL4KGDC5910mvzZoBU8/TCDybT0/0aHit5/kejqaPPDCN4pQylRHtbCfs0cK4UVGhs3pfFZnmWzWc4Nq94oDsg8lgtiraO22u+u0PosqAKCXdSGZ0siz4lEtixXQLfSOvCJKwUiRD8gVBXiFZeV3+UDQQ0RfFsz6kaUlnuX3EbiyUWmFZKwaE/YTRPrLpniI8C4cwz9q06nqP/wF45Bo0ndKPnRGAS9C3GtcemXiF1q0imq4fPEE+Nxi08Buxmd/K9vfhyd0Em/75aD0NBwTjo6x9CksYpt5fLZANMirYHnB63yxNo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b7abda-8bb5-4767-14d1-08dde4dbe364
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 20:05:22.3146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8ZFVrS/xG2NQIykfVtQndZtdatBskPvSAxDDmUWQauSOnY33o20mfHo8QXkI8idvL0gtNG4b4O1TNcKyuN6vlXGwRBqASXKKTyXowMwP34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6479
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508260176
X-Authority-Analysis: v=2.4 cv=J6mq7BnS c=1 sm=1 tr=0 ts=68ae1386 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=aB0PrB8DucyZvUVOxYQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 7ijhbArop42ZGHH60_oJd5Nh_D1zhDOe
X-Proofpoint-ORIG-GUID: 7ijhbArop42ZGHH60_oJd5Nh_D1zhDOe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyNyBTYWx0ZWRfXzpbjx6HRu6XP
 dY4Xr8o/UqAL2EGsyL+EeUwkRlbebL/ZXQVVT0o0PYDRmnmSQfAnrq9NxiRVGMB5iQtM3RDJC09
 kC5jUzz4wpbTJmZ5vn4gk4ezVdvvzPl7/Fst4qC8Hgc1Qug3FWX1fcvYoXrikuTgwQiLBxJK2Hv
 /Vm4eJmlypZZCH/o22wRRPSwNpJzhx+VZAvyB+/pJfbDuk4G5EKwBQiVq4wBUFXjQsdkTeMqzyX
 /dafo1AXwaPh5+yBGsLbeVYaEyajNa4MSmHdMDaevcpSZ2fGW2Vpzt1vgcj+VJRPA/QdZfi88tS
 WXVn9MJpC4RbqOr9yH73hTwznFcl1xSakcBKbE7K2BErJ2rETRo0tmaEsfgl9Ox+F34DczQp0VA
 6GoOjgQ6



On 8/26/2025 2:35 PM, Fan Gong wrote:
> +	err = hinic3_create_rq(hwdev, rq, q_id, rq_depth, qp_msix_idx);
> +	if (err) {
> +		dev_err(hwdev->dev, "Failed to create rq, qid: %u\n",
> +			q_id);
> +		goto err_destory_sq_wq;

typo err_destory_sq_wq -> err_destroy_sq_wq

> +	}
> +
> +	return 0;
> +
> +err_destory_sq_wq:
> +	hinic3_wq_destroy(hwdev, &sq->wq);
> +
> +	return err;
> +}

Thanks,
Alok

