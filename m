Return-Path: <netdev+bounces-185434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F57A9A59A
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA4577AC967
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 08:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77337207DFE;
	Thu, 24 Apr 2025 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eHgsFupC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Kk31Kqwk"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC6A1F4622;
	Thu, 24 Apr 2025 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745482670; cv=fail; b=SSoi7Sv78zy6L6UCNlcGjB3Tf96z/5o3rdsz3r7VKFGl+UDTvQIe6PFWxSnaII1G2LV2ZY774aopCm9aJPBu+MorGnQyUIfk810rZd9WEVsqrvtMru+RNW2Md+jBZE7t6kB8HZIjd3p5GogHQOZ/mtrMq7fsBlwpHJYmtuGRkqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745482670; c=relaxed/simple;
	bh=z6uJNGzYJDb9vV37HfPCCuFkbkOoi6AuCaMlMQ5jdGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ksQnE8wjlnQLd+0L1D2u9+iVXujYGL2hwNfUEx2gwhVg5SFzNGzys3KrmfHU/RfmEdNF1Y7dJgrYshqP8jhZlTxcljvmNf/U9YZoIzvqaAJxye2uNYxeufru01lOREcxzM+vJb21x32qrmQVqS5cEY/rL5EZku500J2ZSlQpQ/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eHgsFupC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Kk31Kqwk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O6ttQX005503;
	Thu, 24 Apr 2025 08:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Bc2L65wxnUxBeI3n4mrAHo69R4uH/SWMKuyIpMBn6fE=; b=
	eHgsFupCGkZeusebKgmm6bplK7btRdr6WXrZnCxhmUzlTLDZHk/mAsKywoLR+kPI
	N9NWi74oqBkZuzBa3FU0/y9Qh3WxeGUkCps9jcXhdCePxdjhOq5FDXbcdV6Hlhdn
	YSZNhSHDR25bsbz4yOYFJN+4NxugH4BrPlUgnKe+pBVGSGkSil+W9h5MN1xaHAUa
	cvxBD/yxPRV/UQWI7Fb3ob3JbRKyovl3szmxU4Rw82CwJql/Cl+CXi/NtSyS7hXt
	/HragOLoovGBUEpwYJyvMY8WTDJm9ZPuUVI7WOS9afExTGxtd4hbUjWlAliZZDgN
	LMvYkgq0m0nOtk/uJ02hJA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 467fmk86pj-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 08:17:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53O8832h030957;
	Thu, 24 Apr 2025 08:08:38 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012050.outbound.protection.outlook.com [40.93.20.50])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466k06xrde-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 08:08:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOI80bKt3sYlb3Rc/ps9eNpvC9Q0gCmM82mCaSf9Uc2tPbfxVA2d1i4jWCdm/Y9y1XX4lyNXGkxzckU0XBHeaP7H01Bzuoi8OtupNJqKVUVsXn12Ipr5u4OHoY3x62poTJf+Df0a1e82YxSdv2D0xxBDOD/yF75AHzyHcvKF9g9vi6V13PS5uIKp+8nT/gor8JvkPczerePAx3SL1WbgZq24sMuYbPDCSOwK7QYgEoyfxdl9CTW3Rf79cDmwaMkNd6sb5upmJ+lUEFaUZp8/ORBH99UcnFBQnWewFp08kcJqbPuexTOMWQXm7PDoLzlwOqo2B1Nm5qrrVAtiQcyztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bc2L65wxnUxBeI3n4mrAHo69R4uH/SWMKuyIpMBn6fE=;
 b=VgZBxC0DMd3J5FYbUtkUUqQL85dNv1Fw5NkzTxZxeI3Q9K1Z/5UxysUzV4DLTI2D91xUrcv7QgBsrtYe7CfCfc7Rl6bXA3nLWw5y7+dKGh53Q69NRuXNPlSduM6n8K2HlOaJ0AaCRgIhCcrrRf0CY3B68qCpJPLvJj6q18OQmmmCch7WlvlMphCMLiu3bvQ84yTm9pXg1Gfxc7R0Z4zdnjTdig/txIzIGQsjb2f12TPAuAUz58ugAWpiqbcBkgHWtCTt/xRfl/+MM54PzwFT/QA4/2Py1pAejK9xqF/MQMzANm5PBVMZ5URpj+PjXzrS7Qv6WEII1ibrZoCLMXEVxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bc2L65wxnUxBeI3n4mrAHo69R4uH/SWMKuyIpMBn6fE=;
 b=Kk31KqwktAhrujmIqm6x+Vq5C+Xof+1SFMTqPJabnVaSC03b68TjXe9ibgqCeHSw6bqtPhYfNGhm4jafvEh4KzVVtCSgyTGJ6Svz8+Iz4naf8JwNdEODuxT7ZErxs2ZrQ+oQzYZQRE1knSJVCXmlRHTXDqR4B7Vz6tYnG7zpOYI=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by LV3PR10MB8156.namprd10.prod.outlook.com (2603:10b6:408:285::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 08:08:28 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 08:08:28 +0000
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
Subject: [RFC PATCH 4/7] net/sched/act_api: use slab ctor/dtor to reduce contention on pcpu alloc
Date: Thu, 24 Apr 2025 17:07:52 +0900
Message-ID: <20250424080755.272925-5-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424080755.272925-1-harry.yoo@oracle.com>
References: <20250424080755.272925-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0177.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ca::6) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|LV3PR10MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb647c8-0ecf-4fa4-ed69-08dd830731b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JHtVAr2dMi1xjAyBhlert4eli+pdw0gki3Clu9g9A4ka2euzm7yCED5B+GjD?=
 =?us-ascii?Q?nG2KR2YDrexQWzofdRVVY6cg3EWCaxmIU/Zw/JFQrS61KzG/iVB4Otlhyvg8?=
 =?us-ascii?Q?F7lOFTooXLfskDB8i85cgamVjJXP1o1dLAreI64S6GQ7bjG4CcXV5lNoRCFB?=
 =?us-ascii?Q?Um8pa4g4aqa6L/RnE1u9bPLDRZeERa4/0GCmcwVcdIDguFD43s2B7SnumOsU?=
 =?us-ascii?Q?2hLjF+zTNu0v8I8RkhiXEQAnuCWvcecIVFlbjgIKcHl497o6wz4yDHVNBmis?=
 =?us-ascii?Q?SiPoYA7KPu2QAc3aNdO3H8px4rQ4EkUmQ/dyCxwIxFsbUO+tGvKzCL1XpyUJ?=
 =?us-ascii?Q?DjboY9K9+UJKl5UzaCO5NveeEqn34EWHaGgQ8sUEk5iCy7dycMSxprUrNwFG?=
 =?us-ascii?Q?LyHvs9lkpiQcWTP50ViIE1BaS2aVtYPGPSe4eTkPyKcT4xWlpqKpMl7vr03r?=
 =?us-ascii?Q?HEHU1Cyy/GFTYgerUh/2kKUN1+u/U0v/bNgImGskJN3b87XkYE8NQVLP7B9e?=
 =?us-ascii?Q?m/QLHdgLW07bZ9pE4JdYD1aCEeGLLh5yY+XYnr3RqcnxQHPyHr5PRwtJLY17?=
 =?us-ascii?Q?JQhvj0zijuFpz14CzkNI8dyLFEQ1/W+Bw6aL6vEcH/gGV5TYwirMU+tl1fgB?=
 =?us-ascii?Q?tPFWXD41YqnlZebfXWnRxV8Zy5P7YTFmu8mYG4KhKggFNMAYoY4yfdiINzNx?=
 =?us-ascii?Q?PSzITfgPexfXQlq89BPzjnxMTMXVF/3Ionst6R90kmVrQctcC8z2BxsnDRVc?=
 =?us-ascii?Q?RtMoytxQiPGA5eB60oV332e9fLv7q8XCHAxNz/AoMVkCZLltLAFEufMtTJqH?=
 =?us-ascii?Q?cL0jRC9DQctI0B7geizBCR0EHrEZ55T8LXDtFarSgHnTR9lu6OlT3lFU/Hq2?=
 =?us-ascii?Q?xEqlfPNaL6M+ALzAGL0LqRsPoVOEkMKIN/FlxxOVN6hB9G1eA/rITE8pZexc?=
 =?us-ascii?Q?q8RaAGo/CXGjLVN9n8UcytV9M5QkcabRc5U4ZONIcelraJepW4aBym5/AkSh?=
 =?us-ascii?Q?qs3o79XI8r5nOuTI6y984VryXYbjudmBFBVw8sWSgLJspyLyaq23QatMwcIp?=
 =?us-ascii?Q?fnpVE0ZNXgmnOe5OZHBxtbegpSa+NTuOkwGFcoNzVq+gg9hws1Z0hHvwfiJ5?=
 =?us-ascii?Q?0PQCKw3j9Zs6PwhZ0aA+iOcw7YZsOujBMxp4NHhd7ybkpz++VCCk8mkPX7EJ?=
 =?us-ascii?Q?loX2MSkfF2nAtQlUVl3SnbHi+VAtTLaFxOMv5ftxq4Gdu8W3U8VrNsxlzCww?=
 =?us-ascii?Q?le0x0/ZfnDszWBsI5jaTov9wWNp2s/7Viey4IwKmFcwFuctLszYb57mfNaJM?=
 =?us-ascii?Q?mWt52VwbtO2YwHNLDDskfxv1Zr69jbZZvr8cpRAcp+h1GYv9NuHRomsExuBI?=
 =?us-ascii?Q?lEvlAIqC6nYj/og4hI/smJFIdwlR1PSxaYHV8KmGX/jnjQJfhJ9JgahzrQlL?=
 =?us-ascii?Q?olXbX7kk2PU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P+MNZxspAmm6g986bH/g9ByUZLDTtMQuAFMsY7kF8sQ5v1FlYJ8RS0ciKsZR?=
 =?us-ascii?Q?eQXJjdhQkcqDze7Ffk0pgqYhs7FlmuzbEhRRUJ60u3dnlOA/Q2vQ38UfbU4M?=
 =?us-ascii?Q?vO0EDrXbq5Ok+J0XN0mjz5qlOfAV0GOqS2QXv2Yet0bsdRqp30/vMD+CyLnL?=
 =?us-ascii?Q?yTIQ5O0cNSLp15DAgbjnmi6Y1ME3V7Qm/ISDeF1tOQS8/D7gZw55FkGALEWm?=
 =?us-ascii?Q?swJ+sEgx3ps8Jpe14SQCkI9/69Y9+O0p8usn/fJCeoTzCISIPdouYS8U67RJ?=
 =?us-ascii?Q?bmBQZCFESjbfDmgSty4+DUOvTpMucaHEB1vRIfpdg/AJhtFv+UEvD7lM7APZ?=
 =?us-ascii?Q?5F2knUeRRZtuNtGAsqm1NfNZmPRmreiR5L/8igkNQ0DSETAXUxLiAvBXFgjV?=
 =?us-ascii?Q?5ujXVpvrqCaqsQZ+QfYVzP8IW0WAfgOXJM8C2LWw96jG+I3z/dkl7U4Qif0b?=
 =?us-ascii?Q?6loEwplIBtBlur3izppkySdh3hZZbmBxIggc5F8G0b0dfz7zSz/mDGLqh6bQ?=
 =?us-ascii?Q?YmmqQ+4Uj06FhQ25ry2SaLsomfFIAUydqc7rpeAtcLUGs4JDx10PPVcdprfn?=
 =?us-ascii?Q?rE7M8dmTsUsoWNr1hgzWfquvsCjuJUAEDUPJWRd65ED34BV4TRhkFaXEuLRK?=
 =?us-ascii?Q?kxnJXMD+Y/lUmHqu0bhIcZnybGrsyzQ7omyP5eVsEZxb/cU75/dAjcNO/COf?=
 =?us-ascii?Q?ERrLm/g/d/f+ImsgE5ZqAKItADdk3btYrXpS+1uknsatNp+cT9Qv24EDi2PW?=
 =?us-ascii?Q?2qtOLygfAn8WWqstXUNXTfl6sJBPQCpfJ5oqrf6hWJ6eQgJtAZqz2Lr0LRiZ?=
 =?us-ascii?Q?jd6QJt92Z/fwbHKCxd2ccDC78FnGpKMJiWY7wsqxZH5NXQw7Xni60Dcge0Sv?=
 =?us-ascii?Q?HoCdEMB7E1AgfPJYE3wV6utAbPozj48I5vEMujaDxZW11t2RbQqpJs9XyNDc?=
 =?us-ascii?Q?R/NieU/c24YKMlbGyfr6df9uExsTsKgnvB81lh4BIIpQ7ElTeZe8+AjTt0q2?=
 =?us-ascii?Q?GpkAHMPNavrtIT9nQ27On3TEh+42E3nbTgxcUjLqKZA7mdwM2g7JQIJPuFrd?=
 =?us-ascii?Q?RYldPvnDYXELeZ8mvOvzYFxcu1vXc3kvrMMH+2uDUQQI2VjOh8JRhJjYpxEW?=
 =?us-ascii?Q?/oc/32yUsT87vHm5FddMpjlq4yJwtqJkCuhXmcTLipXgj8U5uYSeK2sIopbh?=
 =?us-ascii?Q?yGObKOvdONtHqN1gqgKWuayQmcWvwLk39RncLvDWVDaGPwvnKzzAPozHRApD?=
 =?us-ascii?Q?TP0XML4PvNaTLfXm55CyubwgZPEVlD8EzpQMZgj43bZ0+jj63qVv9seiwC3i?=
 =?us-ascii?Q?tl7FHu23A6+aNs5M27HC+dlypfAZMt4j2umwLv9enGUtlkWG+Mr3CJ52PFQK?=
 =?us-ascii?Q?D8ttXIkVqrVPta2kTDQPi7Khcv08pubdx3cmaoffq2FFS/NeoCtl+Il5YOPZ?=
 =?us-ascii?Q?9q5lhOfGdBi9LKnyiNEGG+QSbUU1n61EeEGLbdYMf586MBlIblFlry0KCGDi?=
 =?us-ascii?Q?lK+ubl0wQ1z2JpY1ujVBXWSY1UN5vnAoujuTuFgc+W9HOsci8xpsv6YTeaoQ?=
 =?us-ascii?Q?93p99ALGzUYpWATn36h2wUQhEy+l6mk8QbA/TiGT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kF4hGBiK5zV5ao+8OsHZVIk86/ovTh+8BOx1PDvMycneprz8G8LHrdlz+iqX2jLnWatYVkNZifdI1HdhyhUz9OVYYJBI8b6+O01istBuNN5X6hCFXlhAqKQcsO3uKJSvjJuSa1tfnFSD9qjIjIPRFSeVa2gykbmHEpq8nIZS6ALxeSaXCwQyIxUjzh2GIvI8vC1TWHDhvNzUcXl9WoR6+FbAYBT20mvGjF1TmAHdUWkHtLjFvm1NDNuPfLBujo5vW7UcshmX/+muAchbJMxVbp98qhOl96wn6XC6RrvNcHxG+nQzSL2sL0yChaY2P+LZILF7r9s6Ll8udOGRD1IGnBTOh5i+Jl0wXFREC6TTiJhtx+agiK+b8/4WF2hjxZu0ZCvOd1zFaQtFbNyglQxAz5MyTS5iuvRGFHqoAyCXiLN+BX00urW6f/i5rb6NO1p3oqvasYHm+x7cYZg2eFcmfitx/oUKZTSwfyyh+AMnBGAdCh0NSf1otqRj7wabAbaFcBdymQkksX7sj3q/dQh2tI6GVtdlLbw0XjXhF0KhP++uTJ3ylnt+aCOvy7NLi+1I33A9P1sQjegZKvwaWpzZ7/XAJ15fcdp2ak0wHDRkKfs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb647c8-0ecf-4fa4-ed69-08dd830731b1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 08:08:28.1415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: krdnLpQqIlLAPATYGOQeuqqDW9JlCRRq+Y6aqo7lN3e02I9dUv+wLLhhCWWmGByvjzApdBkQo82Fp+5Og+Vgrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_04,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504240053
X-Proofpoint-GUID: UtXUFSJ4Jl60hY1YNT5uPOBa5aCIleKw
X-Proofpoint-ORIG-GUID: UtXUFSJ4Jl60hY1YNT5uPOBa5aCIleKw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA1MyBTYWx0ZWRfX+iqNPwB+QO2U m8v99tiFZVVeBhUNSqrZOs9qiEblWFgPMou5iMUSxNXxRibaZROpVCW8PDPypddzv21ScCmTDOf LAXAdt9CFjbS92zqxLoidHsj28bLTj7lV2CuWNHmiVHJHCHxWFs85G4P2tPfXhPQ1MHx6zFp/yC
 8NlMA+qbvGCf7ZRolOCrDbTMhQHpBpz6zezij5yg3ZVAHL2rYdAIxQfTiKSumX0tHOTovxgf16q 8AagxwgQy7Lv+imjlx9JnGWK6UnXA0+DxDcDDKwqFlG5jIhSNLrfamwIr2u3gibSm6zzosRL4hk 7RYfaMT99d2gdagBc4rGlm+OE/axJJNlxDms70W61FGL50iGzA0/cphNUeMZfmRvEi30Kewxv/8 suPKEpnE

A tc_action object allocates three percpu memory regions and stores their
pointers within the object. For each object's lifetime, this requires
acquiring and releasing the globak lock, pcpu_alloc_mutex three times.

In workloads that frequently create and destroy TC filters, this leads
to severe lock contention due to the globl lock.

By using the slab constructor/destructor pair, the contention on
pcpu_alloc_mutex is shifted to the creation and destruction of slabs
(which contains multiple objects), which occur far less frequently than
allocating and freeing individual tc_action objects.

When tested with the following command, a 26% reduction in system time
was observed.

$ cd tools/testing/selftests/tc-testing
$ sudo python3 tdc.py -f ./tc-tests/filters/flower.json -d <NIC name>

Lock contention as measured with `perf lock record/report`:

Before:
                Name   acquired  contended     avg wait   total wait     max wait     min wait

                       15042346   15042346      3.82 us     57.40 s       4.00 ms       316 ns
    pcpu_alloc_mutex   10959650   10959650      7.10 us      1.30 m       3.76 ms       313 ns

After:
                Name   acquired  contended     avg wait   total wait     max wait     min wait

                       15488031   15488031      5.16 us      1.33 m  5124095.50 h        316 ns
    pcpu_alloc_mutex    7695276    7695276      3.39 us     26.07 s       4.03 ms       284 ns

The contention has moved from pcpu_alloc_mutex to other locks (which are not
symbolized and appear as blank in the output above).

Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 net/sched/act_api.c | 82 +++++++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 26 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 839790043256..60cde766135a 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -112,6 +112,8 @@ struct tcf_chain *tcf_action_set_ctrlact(struct tc_action *a, int action,
 }
 EXPORT_SYMBOL(tcf_action_set_ctrlact);
 
+static struct kmem_cache *tc_action_cache;
+
 /* XXX: For standalone actions, we don't need a RCU grace period either, because
  * actions are always connected to filters and filters are already destroyed in
  * RCU callbacks, so after a RCU grace period actions are already disconnected
@@ -121,15 +123,15 @@ static void free_tcf(struct tc_action *p)
 {
 	struct tcf_chain *chain = rcu_dereference_protected(p->goto_chain, 1);
 
-	free_percpu(p->cpu_bstats);
-	free_percpu(p->cpu_bstats_hw);
-	free_percpu(p->cpu_qstats);
 
 	tcf_set_action_cookie(&p->user_cookie, NULL);
 	if (chain)
 		tcf_chain_put_by_act(chain);
 
-	kfree(p);
+	if (p->cpu_bstats)
+		kmem_cache_free(tc_action_cache, p);
+	else
+		kfree(p);
 }
 
 static void offload_action_hw_count_set(struct tc_action *act,
@@ -778,27 +780,20 @@ int tcf_idr_create(struct tc_action_net *tn, u32 index, struct nlattr *est,
 		   struct tc_action **a, const struct tc_action_ops *ops,
 		   int bind, bool cpustats, u32 flags)
 {
-	struct tc_action *p = kzalloc(ops->size, GFP_KERNEL);
+	struct tc_action *p;
 	struct tcf_idrinfo *idrinfo = tn->idrinfo;
 	int err = -ENOMEM;
 
+	if (cpustats)
+		p = kmem_cache_alloc(tc_action_cache, GFP_KERNEL);
+	else
+		p = kzalloc(ops->size, GFP_KERNEL);
+
 	if (unlikely(!p))
 		return -ENOMEM;
 	refcount_set(&p->tcfa_refcnt, 1);
 	if (bind)
 		atomic_set(&p->tcfa_bindcnt, 1);
-
-	if (cpustats) {
-		p->cpu_bstats = netdev_alloc_pcpu_stats(struct gnet_stats_basic_sync);
-		if (!p->cpu_bstats)
-			goto err1;
-		p->cpu_bstats_hw = netdev_alloc_pcpu_stats(struct gnet_stats_basic_sync);
-		if (!p->cpu_bstats_hw)
-			goto err2;
-		p->cpu_qstats = alloc_percpu(struct gnet_stats_queue);
-		if (!p->cpu_qstats)
-			goto err3;
-	}
 	gnet_stats_basic_sync_init(&p->tcfa_bstats);
 	gnet_stats_basic_sync_init(&p->tcfa_bstats_hw);
 	spin_lock_init(&p->tcfa_lock);
@@ -812,7 +807,7 @@ int tcf_idr_create(struct tc_action_net *tn, u32 index, struct nlattr *est,
 					&p->tcfa_rate_est,
 					&p->tcfa_lock, false, est);
 		if (err)
-			goto err4;
+			goto err;
 	}
 
 	p->idrinfo = idrinfo;
@@ -820,14 +815,11 @@ int tcf_idr_create(struct tc_action_net *tn, u32 index, struct nlattr *est,
 	p->ops = ops;
 	*a = p;
 	return 0;
-err4:
-	free_percpu(p->cpu_qstats);
-err3:
-	free_percpu(p->cpu_bstats_hw);
-err2:
-	free_percpu(p->cpu_bstats);
-err1:
-	kfree(p);
+err:
+	if (cpustats)
+		kmem_cache_free(tc_action_cache, p);
+	else
+		kfree(p);
 	return err;
 }
 EXPORT_SYMBOL(tcf_idr_create);
@@ -2270,8 +2262,46 @@ static const struct rtnl_msg_handler tc_action_rtnl_msg_handlers[] __initconst =
 	 .dumpit = tc_dump_action},
 };
 
+static int tcf_action_ctor(void *object) {
+	struct tc_action *p = object;
+
+	p->cpu_bstats = netdev_alloc_pcpu_stats(struct gnet_stats_basic_sync);
+	if (!p->cpu_bstats)
+		goto err1;
+	p->cpu_bstats_hw = netdev_alloc_pcpu_stats(struct gnet_stats_basic_sync);
+	if (!p->cpu_bstats_hw)
+		goto err2;
+	p->cpu_qstats = alloc_percpu(struct gnet_stats_queue);
+	if (!p->cpu_qstats)
+		goto err3;
+	return 0;
+
+err3:
+	free_percpu(p->cpu_bstats_hw);
+err2:
+	free_percpu(p->cpu_bstats);
+err1:
+	return -ENOMEM;
+}
+
+static void tcf_action_dtor(void *object) {
+	struct tc_action *p = object;
+
+	free_percpu(p->cpu_bstats);
+	free_percpu(p->cpu_bstats_hw);
+	free_percpu(p->cpu_qstats);
+}
+
 static int __init tc_action_init(void)
 {
+	struct kmem_cache_args kmem_args = {
+		.ctor = tcf_action_ctor,
+		.dtor = tcf_action_dtor,
+	};
+
+	tc_action_cache = kmem_cache_create("tc_action",
+					    sizeof(struct tc_action),
+					    &kmem_args, SLAB_PANIC);
 	rtnl_register_many(tc_action_rtnl_msg_handlers);
 	return 0;
 }
-- 
2.43.0


