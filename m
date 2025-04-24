Return-Path: <netdev+bounces-185428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD47A9A548
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1A6C176638
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 08:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D2F1F63CD;
	Thu, 24 Apr 2025 08:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gfrHpCPI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rxDmdpXk"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9051F418C;
	Thu, 24 Apr 2025 08:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745482113; cv=fail; b=mC8Q8cI1GNwnJPA9E6xQoikUwGHz3PhhZjeyzGKFD5mYXuEvaUkKnk5SBab2YZwF8fDPZwss4Sii2WvdsNzyhYTsOlBZbVwfVYwiTFhJG7HVJf56kOluzKHlbq0+Hg1WwJKPYGW/NFRrVQ1prPCQDujPNtoS7L3OrGPlVCGfjls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745482113; c=relaxed/simple;
	bh=ebDRrerPaTWuzh2Zmip9TlgOlmTjGZC5yLHihBTAjoI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ECLFVl819jqbsqjEa0K6qhzXixjS3x1gOwp+L8Iu7eAqPRXtcmsgfcahITlNu4MYV8gSPwHHdLN20gWL/wKyeNjIX/6a1+Wrdax6qY9IGut5oyTb7DHyIk0m3KesylLJtr4iFKCW0dvc31IGIAMvAtXba+6xqVyLiYFmA7m/qtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gfrHpCPI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rxDmdpXk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O7b3qC008972;
	Thu, 24 Apr 2025 08:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=o6se5hz+I+zH62zS
	m10ALIaoAnFtcJ9ZD2LxvQc4d5c=; b=gfrHpCPIEVUCYN88vHxPIaCqzTc8r4+O
	onYMMpjbWSGAlfv0rVyZmiPiMZfBU0ubVEtQ0MjJlObvFsOYHbsTH8b8UxtvDDLx
	/qzrWILBOEOrgRp7oAxfUkJ2qE6k9rJHL9ueTy14/N793N7ttj+tVirGw5xJ5uzc
	OeaDy5qoX67hYM5vMAUT4FcZGPSkwPX9EIoLIEYE9rUhqjObopxvGJCAJNiWrnR5
	M916LmqeSYiovsiaoW6Dj00rHjq+l2lKxFGXRaM8M+vabbzC/hfVg1fuukNMYzez
	dyWuPUV+gc5mpfR9pzU6wRI+Km8lpKyXt/hy3sMn6mmwVJY9eKb6eg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 467h2kg1c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 08:08:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53O6us0Y031804;
	Thu, 24 Apr 2025 08:08:08 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012054.outbound.protection.outlook.com [40.93.20.54])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 467gfr256v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 08:08:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W66Q5iYaNTbbwVOvddE4Y0AJVtbLmRIaQz1nMkQZwgQRImpAEHO6mDJ+sx5aA42YjqUcvCDIQX5lWj2VCFA6jFSc3WTYZvlkcm9Am5D5C5axMl7GiW7pHW0ro8j4+OhcEPDa7QBxOMV24gRWiT0xlnycNWKaTu8XNhqDP34aHiIR8j+TM+nrTczmgNdoSWff/iNU3p1mOPCAmTTssoo2f5vHBASoyE2HgynwqYotb86YaNxmc4HMz0YfU8Aug3rF+MO3iyqfwJ7k3TZlDjE4AWEHzqI4tvyFrJUix2+twx0k1iORVKPlIhB+xmJAXI1kmi408Lyhmxeoy0kLuWzZ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6se5hz+I+zH62zSm10ALIaoAnFtcJ9ZD2LxvQc4d5c=;
 b=B/7T+ukKbhs6KVYQXVwLbaU4joAsbZshAooCZV3T5d5sUC28D7CIGFxjj9Y18k7HxylrY07HEgwtz0o5x+i2XcJnUVllMPoUZYvQqT41y13jhzamS+etm7EUq7Z0rCdiIr1QEBwQR/p9XPaFlbDeOwPxZQSq7PxzAI+rR3sy7rDEjCaXkkumrbEdU9WrgHrzcXNXBVDIS2YWnUJvEoZF0gOUYBlCpFetjYfow6fDpD11/PXuxBlA9Rh9lnDdU/j8PHoW01/22nRC32I6coc2qR3AKr1vqZEGo6utbJj6FYvZBUF/SUTTR9kO4n3oSdueWGyf9AEogHmQGAcV6KXLyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6se5hz+I+zH62zSm10ALIaoAnFtcJ9ZD2LxvQc4d5c=;
 b=rxDmdpXkI2O/qb9V2cH31LOK3VwJwjL4/fyN/RN0awyfTgkYgCfTgAySV8KJYTiO7CKguFa7cHuZ2J87Mfa2U42gVT4VdNQjp1M+ZzpbQtrReCjiG0SSGQLn2fINwlzcZhUQIQkrfM8Mf4iMkTD4y5DNTLs/iUIwd0EJXAiiY7c=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by LV3PR10MB8156.namprd10.prod.outlook.com (2603:10b6:408:285::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 08:08:05 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 08:08:05 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Mateusz Guzik <mjguzik@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, Vlad Buslov <vladbu@nvidia.com>,
        Yevgeny Kliteynik <kliteyn@nvidia.com>, Jan Kara <jack@suse.cz>,
        Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Harry Yoo <harry.yoo@oracle.com>
Subject: [RFC PATCH 0/7] Reviving the slab destructor to tackle the percpu allocator scalability problem
Date: Thu, 24 Apr 2025 17:07:48 +0900
Message-ID: <20250424080755.272925-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0045.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:116::8) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|LV3PR10MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: 79d8ef32-6c20-46d5-a327-08dd83072464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjhneUM1VHRMM3ZNQXovRkpnVDhhL3VYaWdtOTNjY1hYSGFiVGlJZEljQkNG?=
 =?utf-8?B?ZVdMdW11T01ZanIwbTJUbkdXbkE4T0ViejRqMWRlcEZJWmtsbll6L2xWeDF0?=
 =?utf-8?B?d3YrT1pzOEZ2bmxLQWFlOVdKSUNRT0IrZkE5a3BrMFEraWpQZ2dRVWtQM1lq?=
 =?utf-8?B?NnhMRjJCUU85Q0phQUt4bjlvaEN4VkVQQ2pGbHNsRk1kWkFDcVkwSWVieTBZ?=
 =?utf-8?B?TnZOd1hyem41cXMxV2JFZ1BYUWYvaG5QcXJWa3VvNmRPYktXb2lud29YdWtV?=
 =?utf-8?B?aDJyTjNPMjF1RmlrcXdXRkNBampUcHBjbnJHOFlWaldUZzFyK0FpRlhTTUZa?=
 =?utf-8?B?NExoT3R4MW5ta0lsWU1Oa3hzZ3pPTkRnRFU0QXY5WkVock5PRjM5ZVd2UWo4?=
 =?utf-8?B?RWdLMW15REE2VWJuazJlZlRNbDAxbUhlS2tKb1dxSTlQdUVhQWovVVdRdHFk?=
 =?utf-8?B?clJmRFJyeVgxb0F0bEN4d0ZGZjgzWHJheS9QZFVMUG92TVdPSFY4QkF5Vno0?=
 =?utf-8?B?c0UydXZncDR0cFZTNjNzY1g2NC9kL3pNUGZzNE5VUE1SaGlmRnc3STBzc0o3?=
 =?utf-8?B?WUpOL0R1YVRwM2FabGNHZFlGWDN4R0FLOXY3RExTRmoxNHYyS0xzOFpCVmR4?=
 =?utf-8?B?aFU3ZklLb2h1YTBHSmZxYm1udm9qbXF0QmpnSklYbnROOFlPcTQ4YWdiUDZG?=
 =?utf-8?B?WUhwYXNwbjJHSWhwQzhRVDdpVk5JUkh0OER2a2c3ZndXWkNRcWlVRHErMVdV?=
 =?utf-8?B?NmFadjhOc3lZTVFaUmtXNk14QlpjSFdLNVBNUnhYdzd4aDhLVGtJVGxyb3V1?=
 =?utf-8?B?WmYrK2RmVWtTd1MrYW9razVkRkxGbjFxVC9RNUZHY1ZtSURENlprTGkyRkk5?=
 =?utf-8?B?NERybXB5NGhJZ0xMSTlqLzlSdGlJOCtWUW9CMUtTME1yaEF5bnpsTEdmVXpY?=
 =?utf-8?B?Z0N6UHJnamhXclZYVmpsUC9wRWJoaFBUT28zR21tQ0JtOTU0eHBKVVh3VTVI?=
 =?utf-8?B?YlU5SkNCSmRwckhLZGZnUFZoK0F1Mms5QSt5ODV5eGI3WmhTNEN6SG9HY0FF?=
 =?utf-8?B?WlMvUnVQSVdHRGJCdlR2QnpMZEx5a1N2MmY2aWpGZ2lLeUNCc2RXNnpUNHlZ?=
 =?utf-8?B?WUJFcUVXOXdVaXVjT0tIVHFhb3Q4VVpjNXBoQngweVpQUWxpTVBEZWJ2WGhQ?=
 =?utf-8?B?dmFEb09xcTBiSmp3TGxOMEwrMVI4cjJqNkFFTjh6SWo3Q3RZVDhoMlY5VXpD?=
 =?utf-8?B?eW1tekdiT3p6Uzl2UTc0TDh3eit5cENYQUR6QUVINHNDeFdhYndFR0tBaDJX?=
 =?utf-8?B?L20wRWZEbW96YklvOTBIUDdTbUhOclgzZnI1WWVSc05SY2tqVG9kSi9oMkgv?=
 =?utf-8?B?dzM1T2lrM1Qxb25mREtwbHNocUszSmxEYmpWTkxqMWg0ZUI4Q1JKanVkZmpW?=
 =?utf-8?B?R0NENWpObGJ5cFZJYUVKK2svUG9ZcVZOSVBOZHRBcUhpbzY0QS8zU0dHWXlF?=
 =?utf-8?B?bnpLd2Y3TlN6ZXprcklNT2lBeExEZ1hoenpMYVZNd094OTJhVm05OGdYZUVi?=
 =?utf-8?B?MTFzQ3VHbWdZTlFCZ29LbTE5MXVTdDBUdmN0M282WDFsUktHSXQ0aVlkZ2Mx?=
 =?utf-8?B?Ykh4SW82bUtUMGkvUnpQTndRdXVNeklJbWZRbXNNdE5pVG1BcEM0cWRoRUJ3?=
 =?utf-8?B?U09KSVFBUGw3eEdHNUdJTHpTL3dCZDZZS1JuV05XVWd5b0o0ZW9rcllHQito?=
 =?utf-8?B?WWJ6ZG5XdjN5Njh5dzR1bW80aVNpNXcxWVQxN0o0SklwQnFDUytEQTFudUtR?=
 =?utf-8?B?VEJFWndXRmQ5YU9tS2wwb2RzT2tRci85SFVIVnc4NFJLRjFyTzFLN3FoWHZj?=
 =?utf-8?B?UU8zbXQ5RUpFZ1l3bStmVzNKTmlVMUI4cmdGYnNBWTFsWHZBMmMyMnB4Ulla?=
 =?utf-8?Q?y2v4pJ5EkjQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2ZRNFhSWjM1cVl1OE1RZ2NYZGdTM2wwcUdiZnREb1VFbkNCYmJvVXEyT2Ns?=
 =?utf-8?B?akJUZkhtMUgyckhGOU1GK1FjUjhrNDF3d0lJVUJOVnZmM3Q2dXFWOW03aDBN?=
 =?utf-8?B?bktkSTVxZ3ArREJRL2U5VjI1UEpsbG13VGRrYjlxMndGbktVSm5oRUlFeFps?=
 =?utf-8?B?cWtFcnpIZkc2WGQycXdLNUQ1aHQ2dHRzeW1IL1dJNFBlRHVmOXlTdnhxMXN6?=
 =?utf-8?B?QlpDWWViM2FDRzA1dUo3QzdMSE5IejdIYUxNdHFZeWJ2V3VHM29aQk5MbXky?=
 =?utf-8?B?QTBhbEx1QXkrS2U3c3BqVHpFSjlUWFkvajJ5dlUzR1hGU0tqMnE2cVdZV3pi?=
 =?utf-8?B?eDUvRmg1cHhRazc5Wm9DMWtkWGE1VFIyWTJhR2xUdDdZK1MzZ1lJRWE0VmdQ?=
 =?utf-8?B?YTBoeTFMNml2UnFTY0J3b2U5aXIzTHpQSHhBOFdScVB0UFh1QzdYZkVlTEdr?=
 =?utf-8?B?S0JTU3VBQzhwSXVLTDk5cHBWRTJnTGFmVS96OFdseDdTWVpYcnBQQUxBOXA2?=
 =?utf-8?B?SUpocFNObG1xRGh5Ull6bXdYbjBVd01Pek9uY2NuTkVPZ1poS0FOeFF4RkNn?=
 =?utf-8?B?U1lzQm9qZXE0a01TblhIdmk1cHd1QmhSK3hRL21uOHZVUjBJNU44TDQ0dFd0?=
 =?utf-8?B?MkhkNDRndFc3SWUyS09lZmlVSFhkeEI0bk1waUhvWklBY0MrSU1BdnI3V2Ux?=
 =?utf-8?B?YldDNktHZ3JGWUdmUi9pQWhYZ0xxZDdPbXRLRE0vMEJqWTZ0TU9hTVgvVFFw?=
 =?utf-8?B?SUNBZFNsRWs5QjQrMU1lMTZzVk9aTjFDMTIyQmhPaythQ2ExcWt4eXp6T1ox?=
 =?utf-8?B?SVVSMzNOMEp0RU5RQ0o3R0R2dlNCNVZVdm1SeFUzd1N3SVdqTjViV0VoblpW?=
 =?utf-8?B?U0VBT2ppdmVHVlFKbUF0S3ZITWVqRExNUWthYWE2YnBJNjhydWxDamszZHBQ?=
 =?utf-8?B?NmVKcjdkcGdoZE9xSHVjTC91MlZJa3BHQzVYTWNxMHVEb0kxV3R5K25MTzFt?=
 =?utf-8?B?T3kwMCtZQ0NjN05naTlIUHdoTkQycjhvNEh5MnpaVCtQWUZNUU1OQWJ3ODNE?=
 =?utf-8?B?bHg3bGdFS0J5aGZORjk0Slp0ci95dXcyMXlwM1FEVGdYQmlsWEpmNGEzeGV3?=
 =?utf-8?B?SlB5NC80YjY5Slk4cU56NEhDa0VnWG91TWp3UTJqb2xQd2RpOVFhbFZZZlA4?=
 =?utf-8?B?aXA0TUFZa21zT3VrV0ZOOGNPdDRCT2NyaTRJck10Zlg3MTZpaW9IMHNuQ2xo?=
 =?utf-8?B?M3RWVThjT1BQRkNUZnJWeVVMUHQ2NmVyTTFjQjVERVI5U2tZaUR0b0J3L2RE?=
 =?utf-8?B?djlGQ0FmaGh4UFFKUVZ1SlpzelhoTjlRNWp6WWgvTTY1OFNPUVRzSzFOajB1?=
 =?utf-8?B?eEIzYlNuUkJHSVUyS3RVcTcyUEYyS1E3eVpGeVV0SkY3TWUwQkY2ekFIUnpx?=
 =?utf-8?B?Z2F6OEJ1L1AzSHZpbmFybVQ0Q1lHR0xBNFZmaHR5MThUL051TStUOTdnbDQv?=
 =?utf-8?B?eVZ6eS9GMkdoK0pld2hVK0twdXNldWliWTN5ZnVzdXFMUCtCMFBmTzBoMnhn?=
 =?utf-8?B?TktKb0pMYU4vejhhV1dVejlNaHJycUtuS0JKWWgvMVViMjROcVdSbzNsTVBR?=
 =?utf-8?B?QjFSN0pwM3FJdFdtTnNwb1lxWlU1WXZsUm5BcFRBSjdiYTZleUc3RFV4Qmdx?=
 =?utf-8?B?NDlTVnhVUVFVL0tFRFpSblNzT3RsemRhSmRGQkQ0bDNEa081RDdNTURWU2x5?=
 =?utf-8?B?Q083WjY4OEtjUC9KS0Y0bHdLYTVGeXlySXVzR2xoM0pnOUtkWGZsdG8xaTN4?=
 =?utf-8?B?VmtJM2ErNXoybFovbXVMNTFZZHBEWm05Z2lwZkdoQ2l4dnI0d3czR0lCU25U?=
 =?utf-8?B?bTdGVjhJY01HVUdkb29LSmJZbHA0M2V0c2l5bi95NWsrNFhXSlErOFNnOUV1?=
 =?utf-8?B?Q3E2a2NiQkZEYnBNZWJrbEZyc2szY1pNZGJXWHg5QWY3SGowMTZvbE1zSk5u?=
 =?utf-8?B?eUczc1ZaZnJQWnFZWk9reldoL29lRDgrMUppZkM3VkVJV0tIb0xWTS80OGJX?=
 =?utf-8?B?S0syNlM5Y3UxZWlkdWJGWWNFYmh1Q2RoTC9GN2RaczZTWldPOTBoNEV4Qi85?=
 =?utf-8?Q?RJNuh3QL+qwgphGUoZPco4s07?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y++dYvcBoU8VJr6Po1VrImlIwpOoKWngU/cP8g1ElXc/bK1Q1BXkUPdOXgHHFjyAt0YsxKvnrGW/iDWQ6SrN26AnDaB6vQbY5M3B+wh+yzSryncUUNrqIsq5PzFqvQBnfOTh0P8qVBlrJXSB/tbyuY9E0ctKm5v4ZzWkplqbxMkeIBs21ibobI+ODqZUI6AstBkvrU8tNZPOO1uXPxvxKZXYRFRxPEwPxa+d6BMpOk2haYt/+DNNYevr21pJ0C4MDBWKDQ0ZT28QPth8kCP19+LJ/yBl6H68+j4e/c3U0lJ2PGrgZfaeDVi+A3fwyGPC6FBYyg/uCZindrI++DPrSx0p4STF0zjq1eXrhRW17dzRQPxyhsRuWtHRe5bHljcZhTDbWUR4eSAlOw5Grc6BsHzGYHD0rdrP3aEpoCwy8z5dvdW+da7CHj8qKP4+dxLpb3UYBV7TQnS+P4ZCsWisS0twaHeYGVNNnS24CE9Js0doZFceqSwiI7GaNAI73dgmm9XC8D5zjIx+gQENzrdBFtYYzhaiO+u2DajVrtvK6U+HQi2hLrAPE6F0DtrzrOuJHg5lAbiK/oJKE/0x6jjOJ8Ye2igEYhjAvVwN2DDU4Z8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d8ef32-6c20-46d5-a327-08dd83072464
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 08:08:05.7482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjozRy0k/5LtCgE4OjgVGVRph+Qv3xTS/w66+vPJ12Hoeh/bIHezi1mffdWd6RDh6FE1+qo0CxlL4eomO6a8UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_04,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504240052
X-Proofpoint-GUID: OiR0Jer1MOxhydvJgIATOJ3K7eGBBHem
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA1MyBTYWx0ZWRfX+OR+Fy4XD7lH d1PMw8vg4IwqlzzNsrT3QgB0Y87Zijr1GVyI352x4N8uS0Z1QbtQNpf424l3WoxuhkCGVV7ciD6 j8o1nkXy4cyDkA/hKPKu+8CTpnp62zL205BS0ZCMigItCJ3//enx5u804bIvOcgmKHdUcfbU4z6
 GZBp5OVsrWuAutmj0Fsyg7K36en3j/LTI+biWmmQsBbuhIBnuN269DdS2cEw2h3CqAum+oCuzlC jSjbPTZK902vapBqdE/EhuMBWYejcVuTQLT1dWEEJitwsfHVQBXeIPSErjpD2uOALkNpgGgnOip zTdtBmHrhTZP3SEbsAIx946E/CGoquZfTT0F37hjmE5Qq9Qx3OEtUykoGWIblxFRtYDv1YviybH K+UkLi4z
X-Proofpoint-ORIG-GUID: OiR0Jer1MOxhydvJgIATOJ3K7eGBBHem

Overview
========

The slab destructor feature existed in early days of slab allocator(s).
It was removed by the commit c59def9f222d ("Slab allocators: Drop support
for destructors") in 2007 due to lack of serious use cases at that time.

Eighteen years later, Mateusz Guzik proposed [1] re-introducing a slab
constructor/destructor pair to mitigate the global serialization point
(pcpu_alloc_mutex) that occurs when each slab object allocates and frees
percpu memory during its lifetime.

Consider mm_struct: it allocates two percpu regions (mm_cid and rss_stat),
so each allocate–free cycle requires two expensive acquire/release on
that mutex.

We can mitigate this contention by retaining the percpu regions after
the object is freed and releasing them only when the backing slab pages
are freed.

How to do this with slab constructors and destructors: the constructor
allocates percpu memory, and the destructor frees it when the slab pages
are reclaimed; this slightly alters the constructor’s semantics,
as it can now fail.

This series is functional (although not compatible with MM debug
features yet), but still far from perfect. I’m actively refining it and
would appreciate early feedback before I improve it further. :)

This series is based on slab/for-next [2].

Performance Improvement
=======================

I measured the benefit of this series for two different users:
exec() and tc filter insertion/removal.

exec() throughput
-----------------

The performance of exec() is important when short-lived processes are
frequently created. For example: shell-heavy workloads and running many
test cases [3].

I measured exec() throughput with a microbenchmark:
  - 33% of exec() throughput gain on 2-socket machine with 192 CPUs,
  - 4.56% gain on a desktop with 24 hardware threads, and
  - Even 4% gain on a single-threaded exec() throughput.

Further investigation showed that this was due to the overhead of
acquiring/releasing pcpu_alloc_mutex and its contention.

See patch 7 for more detail on the experiment.

Traffic Filter Insertion and Removal
------------------------------------

Each tc filter allocates three percpu memory regions per tc_action object,
so frequently inserting and removing filters contend heavily on the same
mutex.

In the Linux-kernel tools/testing tc-filter benchmark (see patch 4 for
more detail), I observed a 26% reduction in system time and observed
much less contention on pcpu_alloc_mutex with this series.

I saw in old mailing list threads Mellanox (now NVIDIA) engineers cared
about tc filter insertion rate; these changes may still benefit
workloads they run today.

Feedback Needed from Percpu Allocator Folks
===========================================

As percpu allocator is directly affected by this series, this work
will need support from the percpu allocator maintainers, and we need to
address their concerns.

They will probably say "This is a percpu memory allocator scalability
issue and we need to make it scalable"? I don't know.

What do you say?

Some hanging thoughts:
- Tackling the problem on the slab side is much simpler, because the slab
  allocator already caches objects per CPU. Re-creating similar logic
  inside the percpu allocator would be redundant.

  Also, since this is opt-in per slab cache, other percpu allocator
  users remain unaffected.

- If fragmentation is a concern, we could probably allocate larger percpu
  chunks and partition them for slab objects.

- If memory overhead becomes an issue, we could introduce a shrinker
  to free empty slabs (and thus releasing underlying percpu memory chunks).

Patch Sequence
==============

Patch #1 refactors freelist_shuffle() to allow the slab constructor to
fail in the next patch.

Patch #2 allows the slab constructor fail.

Patch #3 implements the slab destructor feature.

Patch #4 converts net/sched/act_api to use the slab ctor/dtor pair. 

Patch #5, #6 implements APIs to charge and uncharge percpu memory and
percpu counter.

Patch #7 converts mm_struct to use the slab ctor/dtor pair. 

Known issues with MM debug features
===================================

The slab destructor feature is not yet compatible with KASAN, KMEMLEAK,
and DEBUG_OBJECTS.

KASAN reports an error when a percpu counter is inserted into the
percpu_counters linked list because the counter has not been allocated
yet.

DEBUG_OBJECTS and KMEMLEAK complain when the slab object is freed, while
the associated percpu memory is still resident in memory.

I don't expect fixing these issues to be too difficult, but I need to
think a little bit to fix it.

[1] https://lore.kernel.org/linux-mm/CAGudoHFc+Km-3usiy4Wdm1JkM+YjCgD9A8dDKQ06pZP070f1ig@mail.gmail.com

[2] https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=slab/for-next

[3] https://lore.kernel.org/linux-mm/20230608111408.s2minsenlcjow7q3@quack3

[4] https://lore.kernel.org/netdev/vbfmunui7dm.fsf@mellanox.com

Harry Yoo (7):
  mm/slab: refactor freelist shuffle
  treewide, slab: allow slab constructor to return an error
  mm/slab: revive the destructor feature in slab allocator
  net/sched/act_api: use slab ctor/dtor to reduce contention on pcpu
    alloc
  mm/percpu: allow (un)charging objects without alloc/free
  lib/percpu_counter: allow (un)charging percpu counters without
    alloc/free
  kernel/fork: improve exec() throughput with slab ctor/dtor pair

 arch/powerpc/include/asm/svm.h            |   2 +-
 arch/powerpc/kvm/book3s_64_mmu_radix.c    |   3 +-
 arch/powerpc/mm/init-common.c             |   3 +-
 arch/powerpc/platforms/cell/spufs/inode.c |   3 +-
 arch/powerpc/platforms/pseries/setup.c    |   2 +-
 arch/powerpc/platforms/pseries/svm.c      |   4 +-
 arch/sh/mm/pgtable.c                      |   3 +-
 arch/sparc/mm/tsb.c                       |   8 +-
 block/bdev.c                              |   3 +-
 drivers/dax/super.c                       |   3 +-
 drivers/gpu/drm/i915/i915_request.c       |   3 +-
 drivers/misc/lkdtm/heap.c                 |  12 +--
 drivers/usb/mon/mon_text.c                |   5 +-
 fs/9p/v9fs.c                              |   3 +-
 fs/adfs/super.c                           |   3 +-
 fs/affs/super.c                           |   3 +-
 fs/afs/super.c                            |   5 +-
 fs/befs/linuxvfs.c                        |   3 +-
 fs/bfs/inode.c                            |   3 +-
 fs/btrfs/inode.c                          |   3 +-
 fs/ceph/super.c                           |   3 +-
 fs/coda/inode.c                           |   3 +-
 fs/debugfs/inode.c                        |   3 +-
 fs/dlm/lowcomms.c                         |   3 +-
 fs/ecryptfs/main.c                        |   5 +-
 fs/efs/super.c                            |   3 +-
 fs/erofs/super.c                          |   3 +-
 fs/exfat/cache.c                          |   3 +-
 fs/exfat/super.c                          |   3 +-
 fs/ext2/super.c                           |   3 +-
 fs/ext4/super.c                           |   3 +-
 fs/fat/cache.c                            |   3 +-
 fs/fat/inode.c                            |   3 +-
 fs/fuse/inode.c                           |   3 +-
 fs/gfs2/main.c                            |   9 +-
 fs/hfs/super.c                            |   3 +-
 fs/hfsplus/super.c                        |   3 +-
 fs/hpfs/super.c                           |   3 +-
 fs/hugetlbfs/inode.c                      |   3 +-
 fs/inode.c                                |   3 +-
 fs/isofs/inode.c                          |   3 +-
 fs/jffs2/super.c                          |   3 +-
 fs/jfs/super.c                            |   3 +-
 fs/minix/inode.c                          |   3 +-
 fs/nfs/inode.c                            |   3 +-
 fs/nfs/nfs42xattr.c                       |   3 +-
 fs/nilfs2/super.c                         |   6 +-
 fs/ntfs3/super.c                          |   3 +-
 fs/ocfs2/dlmfs/dlmfs.c                    |   3 +-
 fs/ocfs2/super.c                          |   3 +-
 fs/openpromfs/inode.c                     |   3 +-
 fs/orangefs/super.c                       |   3 +-
 fs/overlayfs/super.c                      |   3 +-
 fs/pidfs.c                                |   3 +-
 fs/proc/inode.c                           |   3 +-
 fs/qnx4/inode.c                           |   3 +-
 fs/qnx6/inode.c                           |   3 +-
 fs/romfs/super.c                          |   3 +-
 fs/smb/client/cifsfs.c                    |   3 +-
 fs/squashfs/super.c                       |   3 +-
 fs/tracefs/inode.c                        |   3 +-
 fs/ubifs/super.c                          |   3 +-
 fs/udf/super.c                            |   3 +-
 fs/ufs/super.c                            |   3 +-
 fs/userfaultfd.c                          |   3 +-
 fs/vboxsf/super.c                         |   3 +-
 fs/xfs/xfs_super.c                        |   3 +-
 include/linux/mm_types.h                  |  40 ++++++---
 include/linux/percpu.h                    |  10 +++
 include/linux/percpu_counter.h            |   2 +
 include/linux/slab.h                      |  21 +++--
 ipc/mqueue.c                              |   3 +-
 kernel/fork.c                             |  65 +++++++++-----
 kernel/rcu/refscale.c                     |   3 +-
 lib/percpu_counter.c                      |  25 ++++++
 lib/radix-tree.c                          |   3 +-
 lib/test_meminit.c                        |   3 +-
 mm/kfence/kfence_test.c                   |   5 +-
 mm/percpu.c                               |  79 ++++++++++------
 mm/rmap.c                                 |   3 +-
 mm/shmem.c                                |   3 +-
 mm/slab.h                                 |  11 +--
 mm/slab_common.c                          |  43 +++++----
 mm/slub.c                                 | 105 ++++++++++++++++------
 net/sched/act_api.c                       |  82 +++++++++++------
 net/socket.c                              |   3 +-
 net/sunrpc/rpc_pipe.c                     |   3 +-
 security/integrity/ima/ima_iint.c         |   3 +-
 88 files changed, 518 insertions(+), 226 deletions(-)

-- 
2.43.0


