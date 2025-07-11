Return-Path: <netdev+bounces-206113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8A0B01991
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 12:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85D41C420B4
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 10:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8086E27F730;
	Fri, 11 Jul 2025 10:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GK2u7IoD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hIkqG+5+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C8427D786;
	Fri, 11 Jul 2025 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752229091; cv=fail; b=DRBXsFfnOCmS9ckM+ySUaMyrUsHA0CcO3tv/iobwZ5myQ8yqD05eN3VIHATU8gR47SgRYMLkijRh+JEHVk+gUV0i08dRkzIq2C42ib4Q3LgCcrYPxIYJtsjI/UtwzAzZT+YA5rdMpIbntJw9P4xWDZZBX1fFQVUWm3vjI7PISTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752229091; c=relaxed/simple;
	bh=/mZv2uMSMfXaVJlpn9lwMJcaNXPH55jnqW1fugqGpCQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BMc2PTulX7D4PGFpDiwjU1Y9ol9yqq18DDICxCdsFo+gQFDqxt/xWIcM6lunhmoJrt1h+17xbEGOHRowhzIqccDuPATx2ZP7sJ+hgBtKHOqM/KksWquJ/5m6Ls5Z3TmrKtwP5fNWkYMJrXzQbdGR+tOMyQLsuC0tsJ6JseIlrYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GK2u7IoD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hIkqG+5+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BA6uPZ010271;
	Fri, 11 Jul 2025 10:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ph+T5dHfcuISupS/eSgzloT3juw55f+pg0iGxY29luY=; b=
	GK2u7IoDYXo6PwNhEmXhPK9gYvmGG8lvzADynhcP0bZAuc7PHItpHy/46OQG1RJw
	Z8oxKK2BCkhsXUuyCOy7PV93mQwJIkfkUAbVNsBNi2BT/i3D9lHJsmV+3/2JXUt/
	V4HtqzPGdl5SzgxC8fSYsCnGDkU+Zi2gpZW60WkRLc/JwDW7jDGjHo2XoXXhMThe
	WpVzs3JBj/PTihAmM5beuzI3fJekOlNW+1giDU5IpbWV/yc0RIYn+vL9G95uSi+V
	GN3BGMmTbSnuDlC3rXH+Ojn1zdxXKgEAHK8DHO9wAjpDRS5mL/G0UDoV4u+mwLdi
	EFOBYsowGBAYUhOu1oOmVQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u0jsr0dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 10:17:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56B8WUdR014191;
	Fri, 11 Jul 2025 10:17:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgdducx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 10:17:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YirESXbGNpEzs7ew8f8luYhl+UD877+ny98+sqiRHF68OUo1PD1gUoIg2UuRY4R4BIma8JLCo8GNkYQXLtXpfUjMTzRHKzXTzo8jwJybxX2z9tIUWW5CRzCY9sf4ZHL+yuV9BJHL4SB2o9d+NJEnMvz54akW5UPcJGpq9/rOF8AEIvcm4nO9Ao4iWd49IdEZ6M0F3SiPNz12ZOjqZPpBv650+xYVHFUvTO6UiacjFAVAFtB7GqpMfrNdekl9RcdbqRE9noFE4rzhhquebRnhbARbyvJFnCbwfsIhp5symY1cgycmwQALYBxPrpJObLENsZhxUYFwDRJdbM3H/LSLvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ph+T5dHfcuISupS/eSgzloT3juw55f+pg0iGxY29luY=;
 b=ikJfz+lGgaVwnD2tw2UTbvdMVApQ6IoJ56VAClB2PYj2uD0IlJtxDqbq8OUYCEX7nzyElQlPY94ygvEkQs5IwWvLDVOUVKFB6/p+XLrmlY2RQWjW0FfiCY0XTtJumxjNOeRooIv0G8pK96h4N5qjqiy7+47I9EkcMJjF2wS+XjMu6PgTC8Bcmt4fBym86QFJckT7JO8+LD8WAz0q5gX885q1a9+wD+TO5wF4STLDsxpb7spJzRav7q3M6BkWCHX6fRrJlnAgsf75Xj/UPj0/4xTGrH/bFaoZARyZ5jxKSt4n8J0gDayopNNiTN2h9zFat+XL4QiKoDDwv5tVBbUOSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ph+T5dHfcuISupS/eSgzloT3juw55f+pg0iGxY29luY=;
 b=hIkqG+5+00Wk/r+p8iaIdID/KWpCgQykYMuTaPWKkaUISoV78oEycKIM0QdT6l8x/G48Hf5b+Olx+x92zLZUit0J2e3clPyXqSzecVbAc+Q+dLrbgztl2/pVzZn0p1exBE4OB2pmU93oauV4C9bFEfJ7D9ytDiT6yy00xU7xW0Q=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by PH7PR10MB7838.namprd10.prod.outlook.com (2603:10b6:510:30a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 10:17:53 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 10:17:53 +0000
Message-ID: <7334d51a-65d3-43ed-8a33-eedeeb810045@oracle.com>
Date: Fri, 11 Jul 2025 15:47:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH net-next v2] net: thunderx: Fix format-truncation
 warning in bgx_acpi_match_id()
To: Jakub Kicinski <kuba@kernel.org>
Cc: sgoutham@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        darren.kenny@oracle.com, linux-kernel@vger.kernel.org
References: <20250708175250.2090112-1-alok.a.tiwari@oracle.com>
 <20250710153422.6adae255@kernel.org>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250710153422.6adae255@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0104.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::7) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|PH7PR10MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c3f9c3-da83-4665-1e1e-08ddc0643231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDl0SW51KzNORlZQa3ZFQ280OWVXTGVRZnVHUk1ZaStiQnVxSjVtKzVqT09o?=
 =?utf-8?B?U29hbzdIVUxRQVFyQ2pDRDd0azlWSmFGTU5kQzFCWWhjY044bXdHaXZLUDlm?=
 =?utf-8?B?Z3lwRTBXZHpwd1lieW44QzdBd0hMN0w3UXZXQ0x6cVpUMVkwSWpuVjd5V3VP?=
 =?utf-8?B?aTNnZVNZZXp3Y3ZyZTRRQ2VROVB1TXFZak5OWWtYSmpqZzh4SHRaWHVGWWZX?=
 =?utf-8?B?dzVScjdDQVQ3YzdWMDV6NWxDdzlySE9qSDhkOUtNYmJuZWJmaWVZcEtJRTlT?=
 =?utf-8?B?RHRiWWdEblUrb2EzRXd0eEFVQkIxYUhwbVY5a3ZxZjdoOE9BL2UvWkFGMHc3?=
 =?utf-8?B?bmRWdC9nNmVrWHV5ZFdndXFWdFdoUkxSaTZIaUc1ZDhpUXNadHZERi9JZUh5?=
 =?utf-8?B?K0ZOczBSaUgvL2lIY3o3RlZuZ3lhajRQNnphaUJKK3Y1S1FJM1IyVlExVTEw?=
 =?utf-8?B?WjNJVlM3YTBCT25yQ05tb1V4YVJxZHRIeG9hZEw1Yy9SamZORFVHc3JKMWtw?=
 =?utf-8?B?M0RUOVRjdm5yVXhLeHVHa1RmdC9QZ1JyVDFOZzZUMmd5QVE4NmVkUnhHZUds?=
 =?utf-8?B?QXVFeFJ5c1p2anB4ZnY5T3kyM1pMUXRCQm1wakFXbnpMMWJOTFVYeS9CdzI3?=
 =?utf-8?B?NzRxSXhYKy8wc0cySTZYNGJTakZVVlcxcGpXQnJUYlY3YWdtTlEyZ01OeGpU?=
 =?utf-8?B?VnVwVEU5ZDNTUUVoekQ4Q09EbDlxYnc5bUdoM3pKVVRHVFBCTHdDQyt2M2pr?=
 =?utf-8?B?VFFqeCt0cTFGalNVQk1Ib1NEcnNDQjhldnVyanl6NEd1SlZ3ZlFhc1pKZnh4?=
 =?utf-8?B?VGp4ME5EMlFGcXBDeUZQckJQbzZhWGJBVU5ubGpDRXBMVTNPWEFwZ0k4UGJZ?=
 =?utf-8?B?QlhOZytDbkFzcFhSa0JzMVo3MlJUY1B5a3NldW85aG00c0lmdTN2M2FIbUhp?=
 =?utf-8?B?VThSNUN4dFNpYmtjZEtvcmN3RGdPcDlBRDdiaWR4Y1ZKTDNaNjIwMUVOODlB?=
 =?utf-8?B?clNzeW5KS0J5ODlRaFhaLzl6eDdwY0hwQzV4UklxL1NLaWJDMGJ2U05PQ3dB?=
 =?utf-8?B?bzB3TjZ1Q216elI1QXpyYWlTbCtZMk5NN2xzYUNXalRCOVlGMm12NTJwa3RE?=
 =?utf-8?B?MXVLYlJWR2hMSFNOU3NCUTN3Tk5XcjhFUDlZbzliWnJxa3EzL3hKUjh1OUQy?=
 =?utf-8?B?ZVdHNjZjaE5za1dYQWRmd2ozSmFocm1CeGc5ZW9CNHVHNlF4b1dXbEZNYm9w?=
 =?utf-8?B?Z1lWS25vMUdsUnl0VHNycDkzeGMzdFIrWDRYcGxDRzN0b1ViL2p4OEFqeVFG?=
 =?utf-8?B?K1V0MGlZc0RlMUN0QTFQaXFPZGkxTDhRZUN4ZjdoZEhYNW5zbjl0WlZRWjdH?=
 =?utf-8?B?QkJyV1QzRFlqdlFxUnFmV3I1TXltMlpCREFENzlBYjZNbWYwZE92Z1huUEl2?=
 =?utf-8?B?WmUxL2k3eXNzcWJaakV4bUN2SGlSeEwrcm83Wnd0WWxienlDN091NTAyNU1s?=
 =?utf-8?B?ZlMvU0s4OEpoNndlMkovY2tFRDdZcUtiODVEUzRUNS9JeHpmUDlnTmRvQVho?=
 =?utf-8?B?MUpSMyttMmNPVFVLcis5RDVXVHFKL29rUEwwdE5ZYkt2UTF3MXIwVzFnSjEr?=
 =?utf-8?B?YVNuM3JTSndlSUFSQUl2Nzg3RGFnMWpSVHh3TjZOSENoVnJnMzB5MEljNmty?=
 =?utf-8?B?YTAxZlVMK1FHWmxEb0JWK1dSRU5IMlFSa21FelA4aDVZa1RJOTU3V1F0dmNQ?=
 =?utf-8?B?NEpLcVI3QXVpWkxGY2U2WTM2R2V2MTlKcHVXK2hZZ2tYbnMzTjdMbjQxcFMv?=
 =?utf-8?B?Sk1xVXZzcG5nN0pONjJzK2wzTWcrajBQc2xaWHo0amxhaVhsY2xaZTJqVDli?=
 =?utf-8?B?QVhnYUJpN2tMM1ZtQ2RLVU9QdkVzN3AyVzNzNDVsclBRYWkyN1ZDM3Y2K3gv?=
 =?utf-8?Q?4M5aX7UdtvU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVJjSHRnZ2l2Rm5ldER4b3pUdEFTOVUzY1BEd3ZhVFprM0tSU2NpYWtFVjly?=
 =?utf-8?B?UnpWcjZjdVNRWUhUdTZLNTMxR3p3T3RBZktHa3Qyd2t4QzhhN0ZXQ0RtMmdE?=
 =?utf-8?B?cGltcHduWjg5YmRKa1FFdXAvYTFLOTN5TXpsd3V6bEttZCtYcHVGemUwMzRG?=
 =?utf-8?B?TFFidkFaaFpnTmZHWERsMkV2MmlWc2pqL211TW95b0owMk41aWx5eEEwWi9I?=
 =?utf-8?B?WXBTMTY2NUM0VDFjVHpVcFZaMlhBLytVODF6dkJmMHE4UFdtWDBZbk1rTXNF?=
 =?utf-8?B?d0hOeDJLTElvSjR4d21jdWNaNEZITHF2bVVETlcrd0phMnc0Q3lTYnQ3TzZj?=
 =?utf-8?B?MCtUcTZqZzBvdnd1QlVPbHpseDRycC8vVDZwWEdXZGVUaDZKWnZNYnp6VEhq?=
 =?utf-8?B?ZTFBTW4zc3BLTGdDRWI2ZFkybnhhRHh6NXA2bndZQVBEUCtFMVVwbmZPYStx?=
 =?utf-8?B?NEdwQ0lURzZZZVhmbU9YR2dFNCt5WXBrdUtVZlBVU2RFQU5JZ2QybXdHelg1?=
 =?utf-8?B?b25JQ0RjaUpOV1pMaFhwL2dONWFzQjdIN2prWTZCTzJjd0xESmhxcm5tYTFP?=
 =?utf-8?B?c3FjTWp0cklBTmJMaFl1WCtnODVBeS8xVUtaa1Y3NTlsbmZ2Vjg1dXRONzFZ?=
 =?utf-8?B?NlRtaGZtM2FIcmo5MTVlR1JzQXRWdUJrYjVWeXZ5dVpyNFYrZVRvNEc5L1pa?=
 =?utf-8?B?Z2w5VndYY093eGVsckxhZktseTZWVS9qWTlKY0xRY2VUYm4zTUkzK1c3c0h4?=
 =?utf-8?B?Q0dLY29KT21XL000eG5RT1d0ZDFNNmppbW5iLzFwL2hMQjJRcXA4OVZ4ci9J?=
 =?utf-8?B?ampHeUlUbFNOZFVFVDlrUjN0MzJ4eU1VMzZuU3NCanFZdlJQZlUrUUlLSHQ5?=
 =?utf-8?B?YXlESW13NmRXVlhmSis5UkovcGViczRXQ1FtWkpXeXJFTnpab2VzL2Y4Z05s?=
 =?utf-8?B?V2YxeHZRU1FsTGNvbytWc1lVQWx2YUlybTkrVnRBWGhSSnlYZCsvNnNhdU8z?=
 =?utf-8?B?YXVoazV3Rkt1cHRXS0M0Q3liRFNWNzlubGRBYlR3eXNRUk02TUpLTktGUitS?=
 =?utf-8?B?UlZjNWt6ZUN2ODMwSDNlWnVsbEtHdURKY3hxeWE5Qi9zK3AySzVmTGg0SFR6?=
 =?utf-8?B?YzRMa0hpb1V2emNvdWQ1MVdLSVJVZlVDMXVOMjBqYkxaSmhkaERDL3hIYVV4?=
 =?utf-8?B?Z3ZLaEx3M1lZMUgvdHJwY1J6UVFGY05WbG91ZCtPNzkrUm40L3c2dVB0a1FT?=
 =?utf-8?B?Y2xGK3hlaUlZa05XTy9DcUxHUUJkWlgzWGlNYTFLd2g5Q29FdXVrVjQyQytr?=
 =?utf-8?B?SEpBZFNJS1VKS1ppdGdBYmFXd2IzdlppWkZNb0pZWVBqNjFwNmcvbEdkc0JJ?=
 =?utf-8?B?R0xRTXdoblpIek1hZTdYWkZtbjVOd2ZreUNBSEdueWJScm1qb3hUbkxzam5k?=
 =?utf-8?B?S1NLaUF1RGxaSU40eVA0Z1Z3NXcyYm5Fb29ibHRrdGpDcVZNNkg5c2x1blRy?=
 =?utf-8?B?Sk5sejFpWWpkTTYzN2Mwc0tIM3dKSTNvcGtEMTZ3aUZNZGI5cGRMNlZkMWYv?=
 =?utf-8?B?MDg1VFZoMFZBS1M5K3hJUjVHK1pia2wvNUlyNHBUUnAwSng2MjBIWkROWVBB?=
 =?utf-8?B?bDZqblBSRHR4L3dCM0gxT3B1NWVvbytBanUxeHZhT3RZdElUMW9aNVg4bFlj?=
 =?utf-8?B?OWNoVkdjT3B2WnJ2VDhPQmNnZlFneXhkbVl6ZzltMzk0VkprTGFoa3pRQURy?=
 =?utf-8?B?ZFN6eDQ4NkwxdnJBNVF0N09IUlBocmQ0VDVXZDFwL0FFakxBZExZM3dxT0lX?=
 =?utf-8?B?MkFRK3RKR05iVVBDYkRUbURnQndEZmovakJhOEpOMm5HdEhzS29HZmZPUjJE?=
 =?utf-8?B?d0xQOXAzbisxYVZZN3pIVDZPQXNnOEFXKzc2ME1QR0R4QTNTVFdaOE1XVFVO?=
 =?utf-8?B?WldxdWg1c1p2N1ZOWWhBTUhmdWpPMkpOazRCWFRaZGViR0dSM0hwc0VISTJs?=
 =?utf-8?B?RFRKTEc2QlU5eWZWc2RyQ1JFeW9RVWRHd0hQMEpVU2xkK0pmOVFUek8zeTRB?=
 =?utf-8?B?azVtWjdFUDUrb05acHVXQWFiSTBvdUdscmR6NXN1eTN3cHB0cVV1K2lqZWx0?=
 =?utf-8?B?UnBhUUFERFg2bkNiNVh1akhOTDVKT2M1aFkyenhpRUE4UEw2Vm1Pemd1UGdI?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FmrKJrA1au4BJ2aszCUGGtb13Zgu0COr+Z10CpkbTHffpjQccChn5cS6D6jkJ9d6xXRj00hPc1V0PoVTXP/AAbB19s/gcDBJf9D6KHJRYLv6VZ+iJmuRhrjPZVkN9SheG5M4cYZIh3MvMUc8hEUHcotOyiwIX3Kqq6vWjiDTENri/YnDIzw0IjZ82/SmW+p2eqVacfHMUFaGAyYTEWgk+u1PgcHn1ZsbBreNSGAQPzIa7CQGEbj/0DbCUuzMqbUEkgoBtR4tpE+wyYlxAJ3r2C6JlB9s0qty/bcfgmn1tlJIdFHLN0q63pHU1T4UP9Fwzam1wnmVYvFqedi+ZaFWwaHc1RfMS9b+8KH068VjcxhrgUuTpYxE8TR8VVKqvrBUwc5mMxrBadmYSSTwZqvWfc+ElELkMlQQuYmDTaE8N6ScSgo7qn347R16YhTDP9FvYuKU374/kFTHXtP4KQb3D0XAlWqNusXCtioUYCLV7rRZobTbkr35KJnUQgexWRw75Wij/0dDZtnlIt0tKojxpHS6SWh/vTwucfkRFEx9z6Y4MDRZQUKPr1xgz9Fgbz6Su48rST2qeTKcrmoQNuLt3juR2dPfOcvzPsRsgh4BKtM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c3f9c3-da83-4665-1e1e-08ddc0643231
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 10:17:53.2137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PzRx/CQna8/VzkLiUaxpsxRfji2nHycnSHgpa7gmh8RAn27psFzj31AOE6yEZFFm2MJ+WoLfNO4ZNL5Usma1ILtx3i2+d14mG+Y1sRKHVJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7838
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=927 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507110072
X-Proofpoint-ORIG-GUID: 21KE_WVY5hAuoRUwq4Y-lF-sEgMv6h1m
X-Authority-Analysis: v=2.4 cv=ZdcdNtVA c=1 sm=1 tr=0 ts=6870e4d4 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=rxq7D4UWlkjjAgJpD5MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12062
X-Proofpoint-GUID: 21KE_WVY5hAuoRUwq4Y-lF-sEgMv6h1m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MiBTYWx0ZWRfX5euBQCSJv4BQ uS4HOh3FSPIi6K+rxhGfOA7Wa1Jvb6i44uop9xaXQCjOLVlXtdLUjJ3fIywJFwq8+0ZEB7v8rXj Q29RZVs9ZdijSexrnIbWgx9d4d4KISamfiDX+mlfpFItfwFQW2c9ivBsizSAXnQk/Co6xDDVN/U
 w6kaY79RPiLXk3groH5U4xV6f87lWRK6C22zDzxBYWu+dIZNIrpdtmIRS0G7UKfBe4AgdXMBYBl mw+FVwELznawNwQfp7uuWIp49byhD0fOevdD8vblzpO3SA2Dr9rgkNDN1xRdjxF7Wmpt9REhOND 4kHRzP4PSUzYcJ1tB0JWKHKrSmSWRvdoudoIo+StZwTaed9yHL7gNkaPVHW/TjnJVzyInaVM7Pz
 vvOg0cf6rFENR35F88q35CrCYdD8mROKIQRJ5b7Kdyrkx/Nh7RCVWtNI1sioDIr2Q7pqLG3Z



On 7/11/2025 4:04 AM, Jakub Kicinski wrote:
> On Tue,  8 Jul 2025 10:52:43 -0700 Alok Tiwari wrote:
>> Increase the buffer size from 5 to 8 and use sizeof(bgx_sel) in
>> snprintf() to ensure safety and suppress the warning.
>>
>> Build warning:
>>    CC      drivers/net/ethernet/cavium/thunder/thunder_bgx.o
>>    drivers/net/ethernet/cavium/thunder/thunder_bgx.c: In function
>> ‘bgx_acpi_match_id’:
>>    drivers/net/ethernet/cavium/thunder/thunder_bgx.c:1434:27: error: ‘%d’
>> directive output may be truncated writing between 1 and 3 bytes into a
>> region of size 2 [-Werror=format-truncation=]
>>      snprintf(bgx_sel, 5, "BGX%d", bgx->bgx_id);
>>                               ^~
>>    drivers/net/ethernet/cavium/thunder/thunder_bgx.c:1434:23: note:
>> directive argument in the range [0, 255]
>>      snprintf(bgx_sel, 5, "BGX%d", bgx->bgx_id);
>>                           ^~~~~~~
>>    drivers/net/ethernet/cavium/thunder/thunder_bgx.c:1434:2: note:
>> ‘snprintf’ output between 5 and 7 bytes into a destination of size 5
>>      snprintf(bgx_sel, 5, "BGX%d", bgx->bgx_id);
> 
> Hm, why are you making it 8 when the max length is 7 ? 🤔️

yes, 7 is max range. I will send v3 with this change.

Thanks,
Alok


