Return-Path: <netdev+bounces-202947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC6EAEFDCA
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 17:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242D8481370
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 15:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66A1277C9F;
	Tue,  1 Jul 2025 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UC9AGye7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xl3Zw5O5"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA77275869;
	Tue,  1 Jul 2025 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382982; cv=fail; b=GsGjqMng6VsgcWlMGYzEn8nDYwL7lWM4qcYhZ9xy86jwZcz/7ZnoB5J9lPeMGJRVvxCnVKR0gFkP+RPg1nrXsP1Ol4HRSx0BOh1WXQa8Po8flER07/oI1FtWTZd/qUhhhU4wMjkqoRYl2JGVWVeMriDiiEqcpzD0ufW00cfMlhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382982; c=relaxed/simple;
	bh=Io1L/AY/Tslz4DuCAD2spdNIJTpr3lycClAx7Vxa9Mw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hqtcu2MMecYCeMxJmYwHhrr6uX7CcnndMMNfr1qJoV8R+HEwPl80Mqp/6G+pqhNQwCYTR4q4AJxNqJSov4VC0UZ5vfYySKC+uKAvI/OSo8M8vqoK7kgEMM2Iwnn4KduwWU8V8kfkXjHscnaRM8ZlL5dm1V+VfRNRnw+/6efHkks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UC9AGye7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xl3Zw5O5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561D9RD0024738;
	Tue, 1 Jul 2025 15:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5853hGdADK74L11FQ2nXgJD9upRqWL8pONax4X4AadI=; b=
	UC9AGye7at9tqpqeF5R0fG1RSbC6p7okg2yQnrQ2t7VEMp2GYRYxCykM1AISmlXt
	PQF+LgzuiCSTQesQBuxg3gJkVaKk/IyU14bg2ynGZ0MGGwmnf01Rvi44mh71j5Kq
	0SsmvjRFKF5j7d8QTnKH5jhkeD1a5BFzavd5fh3TQVJnWXqZnmT5GRO7vqrt8Rgs
	cF8NBVIUPZufkv7uz+uxOSJS9ofGtSQoCp80OaH+SXCn5jSqzJqXp1K8IX/iwpuR
	oMEX/4EvfHfjOlqyNsRs4OzDP+6bwiljdMSySsgkBBEuvOvDnw89h6fe9Gb+qHz/
	/rypGA8f9JhLxzc1MpXqNg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j704d1qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 15:16:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 561F1W6Q030635;
	Tue, 1 Jul 2025 15:16:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u9xsfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 15:16:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJeNCFmASTqYmPz4afBRRuZkMKOJ9KRFsCzEzNcyYEhMsYgK8TCSMXnMMqpxyw5UtOLpaLm9N45bwuxV05Cs14JGXs36OFZBCZklbIHeHbQ7Sq5YWgJHjr/ShCoxnECch5RNH69arKwU6ebfvz3EiZIwwGLnmNBiW0qxAiwphN/JXg+N+bObrBcRsFCB2lxO0YGirsSXX0gJSpgANhC8Ncid60d3ntnG0hhLd132867oSp5VZVFD4poszXHNC/UW2iIlZd9PwUpasTKF05N+JHohgkgXAdgaXaVYke6b3faaDzCGvHWnP1rRKa88nPbc8WkSB5dLHcLP9ds8wV1y4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5853hGdADK74L11FQ2nXgJD9upRqWL8pONax4X4AadI=;
 b=TY/tqb42PU0NQK1K+Z/lk1/dQQGBtK2VhTU7Tkg31LhuR9zr2yxOBfS+xwbZ43WRujA3IFGn0WvJ8qDD15Y4/2UouY75xergDf/it0egdtjHbl5RkYk2PKkLaCaJoj6Glm6oh4JDUbER+ti7mufEx79EJ0Gxu/p3Z22jeOL1dCC6e2DjerYWDo1QEcjxv6ugeo6mYYKf7lXv17vnzb/6sAc+iGPXJ812ipySe3Jvofw3VnThIRpMK2z3F/bw7CBV+hnlNIjIiQIpHR6BxNCcULs8Rrr5FVmsv67vjRED/ng+oYbFuScv5MStva8PNToH68JN2SVB+oGn1r5ZfNJwWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5853hGdADK74L11FQ2nXgJD9upRqWL8pONax4X4AadI=;
 b=xl3Zw5O5qrlUPuw9WNjr+Ju7GgG5V2SDW0odw6jROv2vHMY9rn1+zQ6AMQZCi9RXmFBzSuYs8bRy5MnTDCC4lVJ10Yz9/KSudtF4LVjCivnGStrlXGf5q61qARZqxmSzi62DB6zEs0ibZdatlh8ArScCWZLCR4w/l2XNsreWKKY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5584.namprd10.prod.outlook.com (2603:10b6:a03:3d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Tue, 1 Jul
 2025 15:16:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 15:16:12 +0000
Message-ID: <63db3af9-3cae-4a2e-829d-1896b4d94b14@oracle.com>
Date: Tue, 1 Jul 2025 11:16:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/handshake: Add new parameter
 'HANDSHAKE_A_ACCEPT_KEYRING'
To: Hannes Reinecke <hare@kernel.org>
Cc: kernel-tls-handshake@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
        netdev@vger.kernel.org
References: <20250701144657.104401-1-hare@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250701144657.104401-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0383.namprd03.prod.outlook.com
 (2603:10b6:610:119::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5584:EE_
X-MS-Office365-Filtering-Correlation-Id: fe4248a8-c787-4e0c-ed95-08ddb8b23722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elpQTkRyTGNMTnNvSVhqNTdHOXpzZlgySGwzUHI2Ujc1ci8xUkVQMnNLUXln?=
 =?utf-8?B?Skt2ZzlEbmEwaGxsWGVqcFhiM3RzVTFkOW5vNE1EbTA5a2JwT3hCZXlDalpH?=
 =?utf-8?B?VzdJWE52ZURkODRhMDhMckRoVGMxTzN3d0JIblNxNXlUR0pRZEQyVDUyYnhl?=
 =?utf-8?B?c2dLWlV2T2I1dlV3cDNVNkM5azB6VWkzZkpQL2I3THpZTUd5NXZtME9SellL?=
 =?utf-8?B?c0hVSkJyN2I4M25oWE5HTjA5c3B6NmRna0xmc2lhZ0hjL2VUYXhHQ08xRFM4?=
 =?utf-8?B?TDA2V28ycXBWRkZHcXdNaWVEVUxhUlREVDE0QU5ZMGlYNzJkaUgyNjF1anlW?=
 =?utf-8?B?cmhkTHBmTWpLdWpBUlZjb0ppMWdhbW5GWksyUS9HTTdKdW9STlR4N1JneGFY?=
 =?utf-8?B?YndUeFRRMEo2STNjY09DUENudkNKNWNyNFlqV2NKZmwya0xUNlhRQ3dQZEtC?=
 =?utf-8?B?VjJvRXRsSXA3c1lSVjdacWowd3Y5ZURydTNRMk1lNVEzekFNZ1ZGdTd3TGM4?=
 =?utf-8?B?aWJWdDNBZlFUM0Q1NkdJYzhnTSsvVXB0Y0pCcXZBdTFHcG1DdzZ1MjhJQk5o?=
 =?utf-8?B?a21RdU1haTROSDAvSlRXcDJMLzhpSUtoa2ZwOFVucTUxeEhBMkNCZ0lERG9H?=
 =?utf-8?B?RjFiWnlFSXFYZ0tnZ2E4M0NyMWhIdy9FODFmYk1FamdnRVYreDVtYTVWLzFC?=
 =?utf-8?B?NVhIdEh2dCtSa1JPbVJNZm1SNHNQNUUwZGhnbFdBa1FIVkt5Q1ZRU292V3hp?=
 =?utf-8?B?SmE3SnpWcmVuL1pIWHdBLzVCUjkySE1RQkkzMmx4SHh5eUVPdEVSUXMxdXRq?=
 =?utf-8?B?TjUwTU5xQ2tWTmd3dlpIYlVjelkyQzdtOWNqWUlFVHVia0VOOWRWVWptMVNY?=
 =?utf-8?B?eHIrYlpVYmprQmZtYVJZQ1kvWitkOG5EeWN2NGhPMHhySE5LS2NUOE1hM2dS?=
 =?utf-8?B?TllmUGFqd1E5dERmNzUycmg4NUwrdW9BeEsvRDcyMXpGSFVaUldqcm9jaHNS?=
 =?utf-8?B?TlJOWE1jNmM3cUMrWlRZUlRveFRxSjFnTkhEaDB5SlA3Uy9nVUJPbVRXcURQ?=
 =?utf-8?B?NWc1VkJjYVMwYkR6OUpRSW01QkhHL2YvTjN3Z3o4b29oZmFZWm9WMmZLUlEr?=
 =?utf-8?B?b2tSY242clIxMGN4akxPWmZhZC9DUEVveFpROTN6d0c1Znhaanl4QkdXRndw?=
 =?utf-8?B?Y3BOZ0U4c0xuMDdKMTRWaWZtL2xoVkk5K1Y2OVFQSFBLSDBwNTc0a21FOVVa?=
 =?utf-8?B?M2ZnNDVtTUtmNkp0RE9FY0FJM28yRGxvaHE4MXJidUlaVVlaMDF6Z3lEK3RB?=
 =?utf-8?B?bFVMcWl4SCtzK1BGZzdYbHFBNmd5dlVBVnd2ekYxUURIMDJXUHlLdk5lV09a?=
 =?utf-8?B?a2EzRGFrWGxqd29yeHpuRkZ3NEdySnF0UWIxVjdpRUpPNnMwOGp6bkEwVUVI?=
 =?utf-8?B?REtCbXdsb1phbDNzdWQ5a2MxM3MxNm4rN01WZE94OXhDUVdzQ1JtcERnMWJh?=
 =?utf-8?B?T0puZkdRRUp0RUNXOHVaRXVSUWpNWGNha3NnVitPNUpORFdnSUZGT0NMYXZB?=
 =?utf-8?B?Y1NNd294ZWI5VlFES2hyVUpBK09kTWkwakNjNExEMm1tSWFPQk52aGdxTVB6?=
 =?utf-8?B?NnlJbEFlVnpXU1ArcGhHcXRONEdESysxQ004UE1wa3VySW9FQmNCQ3pCbkJp?=
 =?utf-8?B?NFdsZEVZV1dmNEN4ekZ2YXFTYmRCQmpyUzhHODNvWGJ0YWoxQTk4b2Nhc3BQ?=
 =?utf-8?B?bEFjS2puZU9rN2xjS2FFYUdBSmV4YUFWaVdMQmR0NFN0Wk5PS1B3U0NicVpR?=
 =?utf-8?B?aVYxcVlpU1dweVIzVnJaQTQ1TU44TVQ4c29LY0JLUnZBL0dUVElnRXJqZGds?=
 =?utf-8?B?Q01wMkJLWmZjak52WGRDVXNSYkFOc2h3a0x1dEV0bTFFa3RVYUZ6YmF2dTlP?=
 =?utf-8?Q?lrFlPzFQYTg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UStUVnRuZWJDTGNHMFExZTJteDkyNi91ZFJtdWJDWGFNU0RpcVB2RWdIa1c1?=
 =?utf-8?B?aVdzYy9rUlNDRkYvcXF0QWpLbjNhZ05NN1hPRitvSmQ0UFpGNnAwYnhJN1RM?=
 =?utf-8?B?RXdPRjMvVmsxWlIxQ1Rzb201bit0NFh0NWRKUWFKeDFpWUhlTGhLZ3A2R2Uy?=
 =?utf-8?B?OTdoYzFHaFByQzZmNWlzZFg5N00zTS9rN3ZoVkJ6Wi92ckVIMDFDaXRVL0dn?=
 =?utf-8?B?Wmg3Z0hINDV6aUpGZ2dHVUxudkQ5c2RWbUd0SnE0Um1mU281NlY5V25UdVpZ?=
 =?utf-8?B?MTJaSVlnUnZ1cTVEbkZOdkJ5c3Zmbm9PR3ROTzhHUGlsSTlNQXVGYmxuL1h1?=
 =?utf-8?B?dmF0WUx0bmFjYVRUZVhsUENISS9JVGg4Zk9qcWs3dDNsUEY4bnNoUTBKR2Vx?=
 =?utf-8?B?azdNUU56NTAyWjdjZUF4cmJXUHY1WEE2U05OcVROUVlUQWdGVGpVMU5wL1cy?=
 =?utf-8?B?L1JzYWJpTktRVm14MW1YbC80UVM3aGFGRUpMMllaZnBmRjBlNGI2R2lEM0U4?=
 =?utf-8?B?MTFYZnJDemppZERKTDVWNkRSOUlqU3kwUE5HenJTUVE1cnZUZHMvZ20xZk90?=
 =?utf-8?B?WEFXTmhiSDVZVFhJVnRsM2tobG41WUtkSlU0OXF6WksvRTQ4Zk9TUVNOYUpR?=
 =?utf-8?B?T3UxLzVKNzRsNWxra204VUliTmwvSDdmU1d6Q1VBTG9vdTlES0VIek9kQ29a?=
 =?utf-8?B?eVpYcFJ6RHk4cUZBMUZvQ0ZqTVBDNHRINHB6U3M0ZU4wZ1kxUC9GNXd2L1Vt?=
 =?utf-8?B?eEFpS2ZjK29YdnJGaDd0dmZ5a2YwWWJEQUh4eWJxVkVSQ2dxWTZoK2VIMG4x?=
 =?utf-8?B?NWlucUJVYk1CSUkvbGVuUkEzU0grQjVqK0dDc3VHeWFNY2JRWlZzUllUWXgw?=
 =?utf-8?B?M0F4M3ZiNVRxaU5hYzBhbjMySFpnaHVzcy9lSnVlcHRvKy8wQU9iK3BCWGt0?=
 =?utf-8?B?TXltU01aTU45ZzBFQ0wrWk1YMXFoemlkOVdIaTJtYzhHSGxLa2FDNk9hcHc2?=
 =?utf-8?B?SzRkOGp1bWJFNVVQbnpxd3ZISmJKQVF5akt5N24xVWphakIyWm8rRm9aNkFs?=
 =?utf-8?B?UC96NUFtUnFRUFlKeEJRY292NWJma3A1aG5idmRuZnZpL1E5cjlwWUVyQmc3?=
 =?utf-8?B?Z05PeStJeGRWWmhFVEpsR0VyNXNPWDdzeUFxbHdJanJ5YmhQRDlxVytOSEw3?=
 =?utf-8?B?V1lGQ2RBNXZPRDFyZ0hYUEpaL3ArdW1vOU1lRlg0Yk1zM1J6N0xBa1RRTCtM?=
 =?utf-8?B?a1NIWkJBQ0RRbkJJeEFkZnRiT2lCQWJ2N1NmdExad2JxN1JNUTVDWVhkbHBa?=
 =?utf-8?B?VEFsMXpvQUNoSkczTndWZkI2UjY5VGJ4OEMzYUd2TEtFVk5XcW8rUFBMVmJ2?=
 =?utf-8?B?UHcyUlp6dG5yNWRYdFozMmtoMVBCYloza3M5VU1RTVV4UUVEZzFYR3c0Z3p4?=
 =?utf-8?B?Q0JQYTkxL0hMNlFYcytzVVE2OG9WaG1aR3lEQm1WUnZ0Z3ZwUGdQZ1NqU1hH?=
 =?utf-8?B?UVMwK0V5VzFobUtPdnZWSWdBV0d6Y2U2S3dhSXZvRUx2ZVlPMlNHVjB0YlJ6?=
 =?utf-8?B?YkZrVVBSVnV5a1hBZ2dha1ljSm5VV1VkWnJLeVR0QVpQTUV6OWFjbmtzUFR5?=
 =?utf-8?B?ZDAvUDlWaFJFbVNhL1RHd0dyVm1PNFlCbmxjcTc1UlhldWhBK0NqVlMvTmVN?=
 =?utf-8?B?QUNzQ0dRTUpLdTBTSXVCaUZoS1FUa2FJd2RmZW1iL2dacmhvZnVtT3p5eFg0?=
 =?utf-8?B?bmZ5dFQ4V3dDYjFxM0pBUndjb25zVGQ4a1VhTVZ1K3kyRXJaNnZEL1oreGZx?=
 =?utf-8?B?MVB0K1ZGc2doSHM4OU45UGN4L1lWcGxyM056UmJwb1ZBS0lYUHdQUEZMd09P?=
 =?utf-8?B?TmM3VFBlMmNqOWVwcktXd01nb3J4b2hCL1lzZUNCYXAxczA5T3drSkNiK1ov?=
 =?utf-8?B?OXRJWHF2YWliMlpIK2dZdk1hSWVKek9IUkdXZDBEdmd6RVRuaHNEUzZZL2h4?=
 =?utf-8?B?ZVN0YTRXblhJYTkvTXpkRHI4NmdFWDQ3RTJKN0lMWElIRjR1aGhBKzdTNXE1?=
 =?utf-8?B?MlRrY1QwcEFUdUZ5TnZPb0g1Si94MGZIOEo0dVRBVjJYYzZrdnhzenJ6ZkRD?=
 =?utf-8?Q?0JpX9CwZyaxLy32uSM7E98403?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pWVjIfqj5vI4Iad8HDheTj6Xr9G5rSq9gz4AUXD0uZSegS0bMUsTN+782pcaOzVmuiiM13cpCqNe8E8iq40zKp3/kJBpUK7yhrP0pOGRKrVoARoWMEXDo+dh8d7Y8gFqkpmy2Iy0qrhL5D6UUB8mFozKoXyVwiXtV6ss5k254nM6uN1Qo+wPcCy9sijHkSVoPu904Bmg8eOuJHkzOmhJadDVtCg9uRBJs7LLOhRYC+IztAwiFYuE1POF4T/0a2R8N4Cuji1iw6peJC4uFtHVyhc3mGiCDClyQ8WkQF4GemeCXwQPdZP3IVDLOuYZUUxs5PWzRHUNrw5PcrFYWfaMnqaaOfnhZIH0mozwOvIEPYzImQG8HG5YR7uUJKMWHG3zhZrzjhukPFZHpnAltvU3g7Sn457+aBOWX8Y2/w0POAt4RagwhoUdvkcQA9xjL0HY7QJqHKme/Ol/Oj93nNgQfrwqFtlGsxnHdZLw/HEovsYD/gScuC5SCdH/Xp1THLM3kZ01MygUnWBuyZwx+nlZ/Oqo62aQ7rMfCc0RJrwuaLUgLWrg+I9vvvwRepzX9TxmLFrNOsexH/ixgPf0ge8UqbucbpQL8vZ6MlEnGAj2HXI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4248a8-c787-4e0c-ed95-08ddb8b23722
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 15:16:12.8276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wlsbU4e6uQL0TVEWD8/tTl0XhL19AE7nrceM2KgTzPGHtMd0tKeq7RDmqBHw1jXqABZ3HkBrz57JBtWahHIwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5584
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507010101
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDEwMSBTYWx0ZWRfXwasmc8wmGdzD LzUH1CuZg7g1lPsFstrkH5EgljLvtBEeXm+P/2SzKu2EGUiZApblqEe61MZgJyoa1wBEu2XZfvb Bi+fNFN6cG4JVeOfOyT+csB5dWlqpfSYR6Uzk3E1az+YRWlf+4ooCSdBhOapAWHhXMuUqkBdM9S
 6qB9CKw09YLHS/DK8zfLJqYEGCXG2LIlru3htnhxW3Cy6HeAr/Tc/nAZRclwuxg3RgNxvInAUsV plBn3sibevfx3b/dE4DmWjnWpw+/GABaRbC6qYdGoO98OQfxsA+iHNEwQja6p07/DuX7CvnrUNh Z+6AfCCx9xZyMc6Mbo/5LXfRK37M+wlat/dalPmjAMAME9NW21IRNaWRB6nSjGFo+kiUD7jb5bw
 fbYxtvvNfMEUaMsbpi0vx65W5btOM+2UDKiXNVw/dn3JSqqOYaMFEuLvoDKto9ApQ/T6Xe5g
X-Authority-Analysis: v=2.4 cv=LcU86ifi c=1 sm=1 tr=0 ts=6863fbc1 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=1xwRwwhh19XafpQPO_cA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14723
X-Proofpoint-GUID: XuRCp3GOcoBoU-SgjbnEB68IKZ0F_yFW
X-Proofpoint-ORIG-GUID: XuRCp3GOcoBoU-SgjbnEB68IKZ0F_yFW

On 7/1/25 10:46 AM, Hannes Reinecke wrote:
> Add a new netlink parameter 'HANDSHAKE_A_ACCEPT_KEYRING' to provide
> the serial number of the keyring to use.
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>  Documentation/netlink/specs/handshake.yaml | 4 ++++
>  include/uapi/linux/handshake.h             | 1 +
>  net/handshake/tlshd.c                      | 6 ++++++
>  3 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
> index b934cc513e3d..a8be0b54755b 100644
> --- a/Documentation/netlink/specs/handshake.yaml
> +++ b/Documentation/netlink/specs/handshake.yaml
> @@ -71,6 +71,9 @@ attribute-sets:
>        -
>          name: peername
>          type: string
> +      -
> +        name: keyring
> +        type: u32
>    -
>      name: done
>      attributes:
> @@ -109,6 +112,7 @@ operations:
>              - peer-identity
>              - certificate
>              - peername
> +            - keyring
>      -
>        name: done
>        doc: Handler reports handshake completion
> diff --git a/include/uapi/linux/handshake.h b/include/uapi/linux/handshake.h
> index 3d7ea58778c9..662e7de46c54 100644
> --- a/include/uapi/linux/handshake.h
> +++ b/include/uapi/linux/handshake.h
> @@ -45,6 +45,7 @@ enum {
>  	HANDSHAKE_A_ACCEPT_PEER_IDENTITY,
>  	HANDSHAKE_A_ACCEPT_CERTIFICATE,
>  	HANDSHAKE_A_ACCEPT_PEERNAME,
> +	HANDSHAKE_A_ACCEPT_KEYRING,
>  
>  	__HANDSHAKE_A_ACCEPT_MAX,
>  	HANDSHAKE_A_ACCEPT_MAX = (__HANDSHAKE_A_ACCEPT_MAX - 1)
> diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
> index d6f52839827e..081093dfd553 100644
> --- a/net/handshake/tlshd.c
> +++ b/net/handshake/tlshd.c
> @@ -230,6 +230,12 @@ static int tls_handshake_accept(struct handshake_req *req,
>  		if (ret < 0)
>  			goto out_cancel;
>  	}
> +	if (treq->th_keyring) {
> +		ret = nla_put_u32(msg, HANDSHAKE_A_ACCEPT_KEYRING,
> +				  treq->th_keyring);
> +		if (ret < 0)
> +			goto out_cancel;
> +	}
>  
>  	ret = nla_put_u32(msg, HANDSHAKE_A_ACCEPT_AUTH_MODE,
>  			  treq->th_auth_mode);

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

