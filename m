Return-Path: <netdev+bounces-227788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D09BBB72E1
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 16:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302B019E7F3E
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 14:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957FB156F20;
	Fri,  3 Oct 2025 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sb1vnkWg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q5ihR0Cy"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101B82AF1B
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759501687; cv=fail; b=kT90thVxw0VI2Uxo3eSU03Uki215/oLJ+bEk1rk4H2FQB3PX8Eqjsumrgw83G14rHrHh673JmLJ2+aj/fpgA3WZRg+UTEbWofA/Esq7DPQ6k3angOsW3uepHHjuNdK7+gD1jOXoVLoUKPZ10ZhhCY44TMoIDJyA0VkWLIvqfNME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759501687; c=relaxed/simple;
	bh=Os0s1HkMYr+qre1ELxoyJl11zrIE0p3BUB+ka0+3GhY=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=Zp7MfCHFpiRD+ek0pq+FaQSEfWFuSKL7HqPhs4EC0KEeKle8+28F/yQYgTHlCo0Yy6Ul/4McOTFsFdzqRXr4VAOpZ6V7bpUzghuSmrMsJYlIaxFQkTUYdeig3dApkq9JMXnyA4cbtMlR6uCwszP5Tqikb6lsAVp+JpCZ2plXHBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Sb1vnkWg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q5ihR0Cy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593EC1BW010815;
	Fri, 3 Oct 2025 14:27:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=mVMwEWwF5YeYl3OO
	KJPwwcdcYjFeH+n5JCVne5PbCg8=; b=Sb1vnkWgq35b7MdTFzzh/dOpPw/rB2fZ
	YNY85WZ12ZqmquKOQO4IuuKRN3KJyGEa2p6TJ0OeP72OSOQ26o/jQujKOJNw6dmI
	ZRWyGYJAhagjFrtYESbhF2JefPDSVahn5CVw2wxhDCajlUluQc+EW+pvrzLhLEcK
	zoopz/Lcoi7n6BXrso13nZc6znpr39A2HdUbtzi1hpTKrmH70XgIGu1maQB7/gdb
	PtzIUSECCRpYnqjmzFsA8r5x+zohrhxHujFPJrm/LV1mMbYHSqr0SpbYur9pKKoG
	2XWZnGz0amyNghOCqqeDz+DrBGPqnYQX65tSDGV67+sEXNvEmhm5cw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49jefa08dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Oct 2025 14:27:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 593Cwrox002528;
	Fri, 3 Oct 2025 14:27:40 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49hw1931vk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Oct 2025 14:27:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1gYczgggsOIwoHr/eYvcEytzsZXR3fphnDIXj6Y8ezZkCMHNMCW/6gUgKa5oYCWXBBOcPNPGOvKbPuvDidqoattbn4OI1aHGq9fTSNW388s0cvIwSQBVdhP/xLf/wqucjZ5YyghBe9C6Sc5/a0DIhrztpqobeJwZ61XmdHmzQP8IGh2cu3nsad9Ga06Bs+O6IjaqnKuUgxHN7MbiSlt3s3BwyK2YV79VItjyU0rx0Hl8eNVOQPE84c77hmgsnQDAXJD9dTtu/ISWL/VM2kkMTtv+XMPi+CK+qWZJ5K1e9veyME1DGXy0seumCpNmXg0SuUdaeABUoUfaUEy+H2cUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVMwEWwF5YeYl3OOKJPwwcdcYjFeH+n5JCVne5PbCg8=;
 b=PC2vtzGCLfdufHo63xuvcjTo6SMJD7hCHYjy405YXf/NXUi4dR7lQVu++aRyxDQYA7cS/XRdeHI0UduU/URkVBD9kTQ3kjZLVBk5NxPJ5vhLj+9tlHmdT9gfaZfgq9Csz3ZLysUUaeZltk5YwcYbw9GuQUzO5VZ7JE7TVOF1dEOA+nScOv8N9qETyaXe225FuuIj16GHWUUuZzHNda22c3AAMQPYgQamwz0x7vtxsgb/YvqQBwfL0wcXg7fhkmDBa8YYp4uHLk2bo5QFzzlXlXyFcBStedrFG4Y+NodOKROZl3d2W5g6uVf/f8BT7wghrJZUbRf1RK8WkDeWbUqTaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVMwEWwF5YeYl3OOKJPwwcdcYjFeH+n5JCVne5PbCg8=;
 b=q5ihR0Cyg6+gtj6yPchhkhFO9+6elTXJFjPYJKm1nP3gYhU5YesOMeGKFLrUT4oFxNT+XzRUfPh844AN59SHyl1NFxAHCNs1K04MoKTLUH+wA5y6eQLjyKr03h14N7hIALjZFLUuUp2HwmyP9Aygj5hghuLbr7VpkDSXorztHMw=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SN4PR10MB5623.namprd10.prod.outlook.com (2603:10b6:806:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 14:27:31 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9182.015; Fri, 3 Oct 2025
 14:27:31 +0000
Message-ID: <306929b1-0119-4c5a-8284-b78d9025e37d@oracle.com>
Date: Fri, 3 Oct 2025 19:57:24 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: vburru@marvell.com, sedara@marvell.com,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, kuba@kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
Subject: [Query] octeon_ep: correct mailbox response type in get_mtu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0511.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::12) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SN4PR10MB5623:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a26a4c8-0222-4841-0763-08de0288fcb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWRVNGw3YW1jUkVzY3NoTzY4ZUkyejFseEFJYWthWGVTOGtNMlpJelN3WE9o?=
 =?utf-8?B?OGRlS0FCQ1ZnclNzYXhSbk10eHNBVU1qV3R2ZTBoSHZzenZZYXZSY011YjJB?=
 =?utf-8?B?NUlsdFdSRzhFNUlWakdKS3J4SllxVm53YU9vQm96eWtUVkcrbmg0OEp4b2VO?=
 =?utf-8?B?SmFVTEJqSW91ck0vd2JuUzdKdllpZFVlaDZxSXFoejlsdXFNSGZqWnF5dGpE?=
 =?utf-8?B?bm51SmFoSWQ0eUVPdnM0bzJQRDc3SXM4MUtwbXNGL1pPQ1lYSVlhcGgySjVQ?=
 =?utf-8?B?UUtGUmZqNjJXaEdEekJEa2VaalhibDlHVTl2NjdvWEt2VFNGZUliVmdPYnYr?=
 =?utf-8?B?eGk5YXdmM3V6UlRoREJPRmxVZlhQOTJrdFBtU3hEbHZxbHA1cW1vOEgwb1dP?=
 =?utf-8?B?V1NOR0Q4eHB0bjhKZndyWGZJVm5peGxTeEsvL01uTkc0dkExSWIyNENoN010?=
 =?utf-8?B?SFo4RXN6c1E3TXRWcjdjSy92VkpZcjFpM2pra2hjVHFyelVtVGxEZVpzT0Vk?=
 =?utf-8?B?RUNmK3dDQzdsdGszQk54U2krV3dFWGFoNTZoNVByL1hJQUtCMzFSK1U5YnRp?=
 =?utf-8?B?NU1BTEg5SDJqekFGTWl0QXp0Zkt1ZVJWeFlkWnNHTHFLdVJTNWl3Tmh6WExp?=
 =?utf-8?B?SVRpWXl1VVFTZlFLMlErNDU4RzZFNmR6a2h3Mkl3N3MrRWUxU1ZqZW5xZDRl?=
 =?utf-8?B?cDVrQ1BmdE5HcjRubXVadUNSTzFDWktVRktDMTFmRVZHdWI0aG85UmlBbm02?=
 =?utf-8?B?ODUyV2tJRFM4ajU4SE9jWE1walpXSWU5ZmZ3alFkWHRVYmlaVTFvSEZvV1JX?=
 =?utf-8?B?Q1FHQlFLalVjZzlwMHlCZEpIRjVjSHpGRjJiYVhsN0xhVnhwUW1meW9adU5p?=
 =?utf-8?B?THY1ME9Qc29uZklpUDRXNUowc3JsZHZxaTB5YVk2bkhqb1A2K0pnamxRbWs1?=
 =?utf-8?B?NDE4eU5Bcm9wQitlcmsrSTlGc0pFQzNFam44ek93OWxrUmVoNmJ2WkN2ek5N?=
 =?utf-8?B?SU9FTGxqSTBPMEpaN0pkZzdJdHpXTTRBKzQxQkJRUGlDVG51aStUNFVXZlJZ?=
 =?utf-8?B?dXJ0QVY1d3J6YkhWRmtEalpKQkt0U3pxVkZLQndKQTJVU1dJbng1a3JaZnZF?=
 =?utf-8?B?TEdQbW9FbUd3djZVajkxNnBQbjVwbGtuYWN3by8wTGxFQVpxdGl5RGF5VUhG?=
 =?utf-8?B?N3hUUGZuVTRPRXlGR2RreC9KR2JZNWcxazd6TW44Ti9YOVlmdFBFY3dWenAx?=
 =?utf-8?B?YlBPRWl4dXZkRWp4bnNWbjRlcGNlTXJtRTRpWm1lWkxZeFg0T1RxdWNZaGJM?=
 =?utf-8?B?dmFEMEFIcHRlK25lcEtaamVBZWF3VXQ0SGFybzhHcHF5UEhFaVIyOWNEWlBZ?=
 =?utf-8?B?cVh5SVFCaFN5UzdnZlpJVUtaaTBSdnJMVkpEbnc3aHMrVGo1cmRZMWxJR2Ry?=
 =?utf-8?B?MUFlWG8rK0g3UFRFcTR0OCtSdUVSS3F0UmduYkthZE5ncTdqWEh1NkEvc002?=
 =?utf-8?B?eDZJVHF4KzQ1OVdENHY2bGVmdWtTekpNUzM3bU1FVm9LK0JHbXZuMkFHL1k3?=
 =?utf-8?B?RG1UL3pDbUpiVXRaVXdCTzk5VFhMUklEN1JvWk5VbGFIRzNTYkRvY0JOVlVD?=
 =?utf-8?B?T2ZIckIzS2NUYkM3OXhERkp4a0pXZUY5U2RabjByZ1FaTmU0aFRzaFFMYVhY?=
 =?utf-8?B?dkx5UDVHTm5lREhIaDVHZnBoNGxad2d1WHVLcDYzck1LWlpaWGFFekJZY21n?=
 =?utf-8?B?cGZiVDhmSExRaFBlSnFFekJ6QUVJVEVIWFBoMTBoaGlwdXo3VXhPS1ZlbmZH?=
 =?utf-8?B?TlR3c2hBYXBiWnNOK0tXUWh0OU94dENBVFNpUGxCY05jNXR1dTBzdk1NanJF?=
 =?utf-8?B?NFR4Zmtodll0RlM3eUhBMlNzblJvWmtGdDZVOHY0RWs4ZHdvNzZjT1AyR3dE?=
 =?utf-8?Q?bRkH0CM6dQ4I+N2GA4r1iCvJQWMLc1z5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RE9ONVc3Y2E5SlpUOTFiTEE4Z0tQM0JCVXFzMjlac0pCNitRZUJ5SWt3RzI3?=
 =?utf-8?B?OTZFSkhzc3YwTWErcnQrd01iaFlVNlplUlBndllSc1hVbm1pejhOaTBiZkRL?=
 =?utf-8?B?bzFkNVpuaUg4ejlUa2cvUjlXbTJVNFhxclc1VFVReVZZeWpXcVlUbHlKb0w2?=
 =?utf-8?B?S3daZlVZdW1NOGt1eml3VnJnVlMvc0J1WEZiZ2pMd2xGOElvcjJybVpMMnFo?=
 =?utf-8?B?ckFVOTFPbW5ZMm5GcjBObGNkdFh4eFhDbWJ3Q2d0bUZubHFueWIxZVR2UXVp?=
 =?utf-8?B?Ty9pQWNnUW14c0NXUlFBVnB4aXltRkIvWmNVbHdpUFRIVXgrb2NoL0VIUGs3?=
 =?utf-8?B?TXdSVCtVQXh6bnhJbkVZRm82ckhVYW1CUnBhT2hySmdDUmxRQ004T1BTMGZK?=
 =?utf-8?B?S3ZhVUhCSklnN3QvY2hQOVIrdTl1OTZKRVAzaDBocEh1S3hJL0o2OEZDbHFx?=
 =?utf-8?B?QTlNUXFwZ2xtbTFEb0NlL0RBTmR5TUtqMFc3eXFqek40WmVsVGp4Mm13bnBT?=
 =?utf-8?B?WUdxOUdUZCsrc0ZtTmV4eHlha1kyZG93VXZ3dm1vVG1DVHNrbE5LRVVodWYz?=
 =?utf-8?B?MXhnZ0k0aEVWZm1pZkErcEw2SzVwVmhiNDJ2aUpiQXArU3RXVzJZdmNVVitn?=
 =?utf-8?B?UmZpVlhnMGVTMEplL2RZUkZjMFFwS2ZQTk94cGdJSlhMNjFlRG0vMkI3Z2pH?=
 =?utf-8?B?eDRQV1ArMUNBcGwwK0JxY3dLWG54SFdHZTU0VDk2dnV1ckJUYXA0YUkzUFF1?=
 =?utf-8?B?dXNFR0dpbW1CNklMNmlzWGxyMFVEZWx0ZCtkZTJVbk5PNVNGWnNtME5ZMTBt?=
 =?utf-8?B?VVAwNWFtbGx3blhGVTJ3Q2J2N0JmNlRtOTBENW56WFNJWXl4RklNeUpQTG1B?=
 =?utf-8?B?T2N4YWtRVEpiZ0RzS1BDNlpMQzI3RWdtNmtUUFh3MmNUTnBQNCtkSS9ERDN0?=
 =?utf-8?B?TCtBRUZxRzVFck9tMmxheGpJL2prVVovWE8xYnU5VEZZVjRCSWFxaFlLZnJP?=
 =?utf-8?B?SFBSdGNWcms4aTdIc0NtT2xZZGhGbTlBS2ttK1BnbmRQQkJIdUpnTnRwL2Ja?=
 =?utf-8?B?WlRDcFpOYjV5M0I2Sit3NkZjM0IzYVUrMDhhRXZaeStwM2JyeGZjYnJHeFZM?=
 =?utf-8?B?ejdaZkVwaXYzMzZJdDNJMG4xSTFXVTRkS2lIQXl4Z1pGcGFUSnZISUVMWUxD?=
 =?utf-8?B?V1FKVndwNk1pMjNGVzQvQ3RkdFRWZnFtaWJKWDQva3RybEYvemRGdFZZamFn?=
 =?utf-8?B?R0twblRUbG1ua2piYjJjeDNRY3FEbnhXaitQMC84cEZOTTZkYzBRNnRoK0lj?=
 =?utf-8?B?T0NsakV4dTFzemQ1cFFwRVJ3dW5zZzQ2ZzdkN08ybzJEbDk2YUIyUDdPbjBW?=
 =?utf-8?B?Qkg1YXlaa2JBdDNpeUJZTzllVTRVdi9raU1odE9oR0UrSU9GVkhEc1V4MEkz?=
 =?utf-8?B?N3ZtOEJ0QTdRZ001OENQQmE2d0E5eFhzL2VUcUtXbXRaUlY1aVo5Yk5wN3gx?=
 =?utf-8?B?TzVsRVlWbGs0VXMzc1F4aGl1eXJyVG1lYWZMK1dDUFY5TG0ycEpteHR6WkFV?=
 =?utf-8?B?ZWtGVWlseTRKcUVGMTBlRE43TEZMQ1VVOVFOdHV4bTN6TFhkYkllc3RFb0hT?=
 =?utf-8?B?bGhsamQ5RHBReUdaeE12NXlZZzYydG1yMEs5dkNtSEdJUERtTndnTzJJSm1M?=
 =?utf-8?B?ZitKcC9TK2RUM2pkRTVzSUtHVUVRTHVDS1VadnRVVXlPZUlaQUtlN0pMYzlP?=
 =?utf-8?B?NUdiYUNsUUU3OUN5TDAwbUJ6ZW9QMmx6VXNJS05ycmZwOGJ2RHBsYmxENUhl?=
 =?utf-8?B?bzQxY3FjdE5lU2dmZlYySGhNZlRuVzI0dXNyTW5ydCtwdXVnVmR3VHdtQXZw?=
 =?utf-8?B?TnMveXdDVnhvZ0dJNXZ2R05XWkNqZ2dtZDBkaHFCN2VHdG1LaHRQRXl6dTNn?=
 =?utf-8?B?dVArdDk0bVVITi90dVZvME44YS93aE5lVVIxUXFXcDlwclFkMlFGS05PWUpN?=
 =?utf-8?B?QUlqaFNCYlRLU3ZnSU51RkFnYTQ4enVsbjExSDZVVWFNK3JPSmV5dHFBZGI2?=
 =?utf-8?B?TnFPUHVmODEwanRKbk9mWFp4RkF5OGp1VEdFOWVNM1BqMCtLYmhvZUI1a3Fi?=
 =?utf-8?B?MTlGNVl3VGpoalNveFhuUDE2RVY4QkFrM05wdFdRWGxOdHBQUnlZRnlwTHlz?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Cno+hDW1aCGi+yXq3nhOQse4P6wYvLvD4dSiDBDGaBEwz6137+Rzn7NXer/znUXvN9EVm8+KDXxwW5nrX9xrEN6WcXzkPV/8N5SxNWy6ndcCmrCZPtm4L9CLIVkUKIVBjo9hp8k/H20xnSBpT1PgZqFelB/jsoxwY9apdbooambfgCvHER71bH+isXkf2fI6UDy/KyU/DIWOq6IUIopbVROupA6I05FhsA5xcpAvbrlVQFhmclH2dVtGmhRQhxyhRX3zjIO4lifuxeXIsVxTHCCvUicF6l2ZFNzyMpoUnTGbt2EBqiLXtlwEJGVcwsuTBud0GTKy4xqRvq12aziA4JLRBKcCunbKgZNtcdv4c/2KlPaBx3iogrdhJ5Tpmcq9yiw5C97tNrJEfkEGLZFlf/N7ePf+csn2j+kWf5Gd+/fcsLOlSj5MCABl6eNmxZSd0t8W+jUktTGqCZJItlz0mXnuVxTKkyfsFxMNTz+9AjlwIn7oo3n+iE++kWizP3pO5r5W+b4cc2YdwAs03TpJM7Setr5GOGx6AVXydSo8T4+OshgFXIvI5tptblXZvGgiXhKwTnWiFrKrPjflgDOLeQBmlHGKWwQA6pup1yjOfY8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a26a4c8-0222-4841-0763-08de0288fcb5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 14:27:31.5026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mB05NI9MxZA7HLXfg7NH6fp5Ilx095G5uoRWHLholk7CSDCNkH5oXovGbV0YAEnYzZom0lzFHrRjSAdGr4L21aVSJO75fer9eJEHOzXhriY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5623
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_04,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=669 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510030118
X-Proofpoint-ORIG-GUID: RogGx0VTW55M9stdPKcXmLjTBmEZh1OZ
X-Authority-Analysis: v=2.4 cv=NazrFmD4 c=1 sm=1 tr=0 ts=68dfdd5c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=pqtgmS9heNDJaLncxFYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: RogGx0VTW55M9stdPKcXmLjTBmEZh1OZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAzMDA5OSBTYWx0ZWRfX0STWrxZPjS3L
 zvk2gG+P8KAPcPWYnuyonjwUwOOXJAQRZqM0o6qFd6bAE5KEMwaWsEIs1Si+rNL0EQmN6D49MQH
 ZgH3jkwY7cg6SzHU4ifttua7wGwuylwX5HTZY9yIpLd4byRUzmhqO6D83Q7rSk66AKr+g+PuL9A
 onFiXfb4uCyG+bCIwRs8O0z82IXQVZvXyQ+iT/CBlbrKn0TH0vkJINe92zc37STIXT0nkfTvnJA
 gh4+f6ztrdDAfmQ3JQq7afRgcFhbvYJ+WQ5aJCyIHsTw/D5YMWUJMBz7DnlxWSkq7o4ds9fR4rk
 88v4jxpIqZoxVKWUf3/1vTY4GMk7R5wktwsH09uy6pBcQ5BJqA1bdZ71kPGtC3ABUBgbp464z1E
 BKiuyTkzye58DceCXxq+OcUzG33PFA==

Hi,

Since this function is octep_pfvf_get_mtu,
shouldn’t the response type be s_get_mtu rather than s_set_mtu?”

---

--- a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
@@ -146,7 +146,7 @@ static void octep_pfvf_get_mtu(struct octep_device 
*oct, u32 vf_id,
  {
         int max_rx_pktlen = oct->netdev->max_mtu + (ETH_HLEN + 
ETH_FCS_LEN);

-       rsp->s_set_mtu.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
+       rsp->s_get_mtu.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK; //propose change
         rsp->s_get_mtu.mtu = max_rx_pktlen;
  }


Thanks,
Alok

