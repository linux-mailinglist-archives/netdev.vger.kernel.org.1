Return-Path: <netdev+bounces-294693-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2taqJKDyH2pVtAAAu9opvQ
	(envelope-from <netdev+bounces-294693-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 11:23:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9743636200
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 11:23:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b=ccbG24od;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294693-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294693-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=windriver.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 788DA300CEB7
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 09:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFFF391E59;
	Wed,  3 Jun 2026 09:22:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA5038B147;
	Wed,  3 Jun 2026 09:22:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780478567; cv=fail; b=qdvuQfgXVF2cqnfiwuiaKMS4HimQqsSo07SPzQXP5XF+bWI3IfmSSmpSZFxxGJAeJUbKMH1dcJfTEfJJl/B2dMPgSON3JH9tu/kJf7RYMEOrhwL0RuKnSndtgPu57/t1Bn/K+R2VnewXwPUVBjMVsnCqp8Nai4358zkqCUEOwTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780478567; c=relaxed/simple;
	bh=Rb8ySZy8ODbzMoWHhmS/m8DDU3qBPcm8aEntyfRWNf8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g6YYRwZTuzK8SybCuh61OXe7SHqxqSDEyBm1sRS7//zj7OWGfbNIDGNPPhAY4SqjSHN8Yu9YjRrLnEU+ZH6UshcQNiFo68BKqRTUSs7vDXPJGUlNtCKXISwP9LtOczXAt+btnBQjw2hNuyQglFlX+wJbohlyUsmWO5tmjZwtRAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=ccbG24od; arc=fail smtp.client-ip=205.220.166.238
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6537K0Tq3579755;
	Wed, 3 Jun 2026 02:22:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=wSKyf7jvgLZ/uUOqmdeLbBdxP8vmulGW4KjiiRnCXdU=; b=
	ccbG24odCnorff5Q26dNoWm6JpGSTPsSoOyK+Cm2nzL3/vKxcpsB6YGwRxAnXOX4
	niXNqPb2JnqHs764jr8Nr5PO7EJIqA7USs1wq+o54NCfywsoH7+bT7mxJVoj6KGO
	b7ZQfJBqzGvzvABcGuwn/C1i7WdDcSzgQ30tG89YAYOP2FSYxW2d8OzvlcwR+vrl
	OFQqRCqmiF2X4dE8Kj+LuFMj6B7mhw2VTLuKy0O3j/hPcEZAY5tRHySqH9AGGWwt
	s+JdcJ3ApNIFulv2hTWw0qcZqoLwHLKj4lOAn3VNzAoehTPy9yiz9YV2YyDalKcF
	vCcRRqdhCAKkYXfrYjQzjQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013002.outbound.protection.outlook.com [40.93.201.2])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4efu61x9eb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 02:22:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTQN3Jy3YRQTLZ9F32cH588I/5t8E2z8CBFb24e1HylfDFeZ6XMyYb5a2fErwZaDhy/lnAQXv3ZkzkBQV3EYWGbSF4xlag6hYn1BZFDv5l1z4rsBy37MUFsGG16PmZt2VPMSJVRqS70TZJW6Ms15fIqXSIO6OQ/myZGmY0eQI0hx/ISx2LtZ7VDCSTAiUIUxVu2E6JxK9fcC9d436Df2JIE+JXMrW2wYyJ85Vp0+ACDb4+YWiQudElMNkN4q5PN9P7uLo6krGT1/ecr4BHvaJkBWqxbcUIEkFxd4kr0BenK3kStTwTWSsOGwWpMtxGQTp+pLch9uBO2Vb2PViAWMHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSKyf7jvgLZ/uUOqmdeLbBdxP8vmulGW4KjiiRnCXdU=;
 b=QOTtC7+byc3p+EJGS+uOM0O4F4ztu7rCSk+8z5B+VkzggoQgnc8xV1Qm3C9rZ/nBmDCHRSNqQJUECaAu6aw02IFCCgqSWLRYv1EOX0JDvnINny4ozqsPnyZe7i6Zbr6CQcqT6GE0SoQscROXXbdeHiRfpOMuv5d2vHnqOc3QbppKz3huwNgi+WGMeOvRMhqw4wzmFVJNU6Ok4RaSunqI3bOcCQ44ijJCBoBamZIdhivywawhksN6wQd5/Sv0sGGesuUcK0p/7DZHRn7jqyt4ek8Ta63HpNGZyhhIBhFMmLNMJXopxWHM83rAMp0Z6TEVdh1cALEK+3Svj7g/8rbLGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by IA1PR11MB6515.namprd11.prod.outlook.com (2603:10b6:208:3a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 09:22:17 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0071.015; Wed, 3 Jun 2026
 09:22:17 +0000
Message-ID: <492d7d3a-b4d1-4117-a0db-df75b2d13823@windriver.com>
Date: Wed, 3 Jun 2026 17:22:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] flow_dissector: fix uninit-value in __skb_flow_dissect()
 for ETH_ADDRS
To: Jiayuan Chen <jiayuan.chen@linux.dev>, Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260603030810.3593625-1-yun.zhou@windriver.com>
 <CANn89iL2OnKcFOV7hHON=70670bC9vsUXBFm3nADU89qgepVfA@mail.gmail.com>
 <2fe4890d-842b-4595-b0db-6859579ca6ef@windriver.com>
 <CANn89iJhZTztRYSoNsUhN0y2UUucm5g5=jHAWKqN1wLOpeJoMA@mail.gmail.com>
 <df784239-b995-47d0-8cc2-c6c8e01182de@linux.dev>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <df784239-b995-47d0-8cc2-c6c8e01182de@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To CH0PR11MB5332.namprd11.prod.outlook.com
 (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|IA1PR11MB6515:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f8e6b2-646d-482c-685a-08dec1519ad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	uyG0rsOfLvKg47HsrJQ/DoEfCwuh2WoVN3em/sDWAZzgPXgIlTwFGwXElZTrXR8/dv/BrNzhmqWTA+rG6QjlkXdh7XcYqSuiYBQ0U3FPo/yLJ4XEZuSvhzT6bpVZUZJG3cWNDFcj5xlzkvOxFzM9YRI8Q0o0BWRqjDfLzR0s5fsvHxqXermbBH9A8l2513Tsjrr+ZtvkYv0PLxdRWfsLrEDRY+2+nxe0Eb5rAgIHQtv/wQynhv/Gk9NMl1mGaRd1KkLn2NS7v8EkFMJrwrG71vI0U9oqX0FiS8tfGOJuQxETuU1j1vcKmNJQBx6PGIxOvonrZe/iQPdKywYicx7edEM11Uf6bUoNnlp1JHnlQ0qzyjFclPEdj1uJ46B61GR5l+bz9IrNXZ7MZ9HQ7JKsdAtOpY5DwXN8274+E4ZpQGWwjK32S11JbqCir4WnVJGaC0ptvYBE7vJbp5R3Is4zpNxPGovKQelWsWZDC0fEK0HhgvvjB3ifLfnma+I0Kpk0AoKdYDwaFFGhkTnj3Ew+XffjfU1My4DSM6TagmGHQyE2yeqWC3ay+c0i095d1jZkLsmuL6e/eloVh2Uryx5G2bG+4ZYNadxX5pjLZTA2EwzpFbrQikd7eYRb7dH0+DKFaXYAZHpMTCJ8/E6jCKa60A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHYrTTZkWTJjRnl1QXlQQmtlcnVRM2lJNm43OEVhYzJzUldKOTMvM2pWSnZK?=
 =?utf-8?B?V0VHZWo0TzVOU054b2NZYVF2TlFNTDZwRWpBSG8wV1UxcmRWRS93aDRYSENT?=
 =?utf-8?B?S0s4RjRjV1EvNWhYSTZIVmZCT0NVTFlXa1FhUnE2NVVpRWFRUkV0WDJLb3BG?=
 =?utf-8?B?c0x1MzVmRzF5OU5laGlHQ25GL3RHbjE0Q2cyR2ljVU1pbENWeUlHUy9vdU5o?=
 =?utf-8?B?REdmMEtQRDEyWWEwRDM2MlBMZ2MwdXYwVWE3aFRxZUV2KzdHZThlaE1SR2JN?=
 =?utf-8?B?WlJBdTN0UzZWRkNnMnNsckoxUXgxWFFaOVNrR2FHbWtkNDF1VHIrdElyNEVK?=
 =?utf-8?B?ZFNXUUNZeXdrbDRTcXFSREV6Q0VCQkxHdVg0NG9yV0phRjk4Qm9kR0krRENJ?=
 =?utf-8?B?S2cxV0hwMHNYOXVKS29UR3c4YlpnOTEwNzEvTDZHK3VySDlRRUlOT1VVZGo5?=
 =?utf-8?B?d3dKdmM0M2xUTkdoRzFEMjVLcXhDUlRWTEJKVmF0WElnaFBReWNXUEsySnB5?=
 =?utf-8?B?aHFva3VPc2NLdFZBNVRVV2MyTHlRSG85ME5mZWhhbVg4TStpY0RZZWVqNDEw?=
 =?utf-8?B?T1pCVlEzWFk0eWVUazM1VUZHai9VQXRGK3lqMkJJdlVtUWN0NjJ0NVNzdnMz?=
 =?utf-8?B?ajQzTjFiVmtvMXF2aXFySE1CNW4yaWE1bUJRQUNyZHRtZkRBQWtaTmRENVlW?=
 =?utf-8?B?V2h2UmhWMVkrTTVqNVVDWG15UHpNTnMrZzQ0NEZNZk1SZHVFWkRIeTF2RGM5?=
 =?utf-8?B?S3hZOUsxaG5OL3cveUljaU85S2hFYks5eTF1RUhNZGNWUHk2ZW9GeTNRV1FP?=
 =?utf-8?B?Vmp3S2VsK3lpWEt4dlR1dFZ1dDlSbkRQbUxWQlZCa0xkajc2T0t1VFlvMmN4?=
 =?utf-8?B?UDVvbjdkSjRCbCtId1JxK3ZZUndPR0dacDB1dGs4Qkxnc1J6czg5R3FVaFRP?=
 =?utf-8?B?cTZkd01sKzRnTDJDbUdUQzNMZHhlWCttUEpUOUFrZFBUZ29vRXNIcitSeDBB?=
 =?utf-8?B?dFdCTnk5SEMyYUJIcEZXN0xzd3o2bVY1alk2eEZIZmQxYzJrbzJMaEtjR25L?=
 =?utf-8?B?UnF2V0JMQjBudnBxdHJXWjVNVG9OakR3ZHZoditaWWp2WVBCd0pITVk3YTMx?=
 =?utf-8?B?bHo5akljZHN0VWxDRjlFSm1VcWZDYnhmR1NRWFFvWCtiN2d6R3J6b3lLOFVs?=
 =?utf-8?B?bC9uOS9oQlVDbE9lQU5rTUk1bmVZYW9FMVh6dGpxbFNEcE9wcURVcWNyeWtU?=
 =?utf-8?B?QXVSR1JSVTg5UDhKYTRzdEhERHR1eWVmV1FXYjhTQWpoeTBreENVTWxqWmY3?=
 =?utf-8?B?Z2hURk1WdUlPZm5odmp3am5mWHFsSHdRMXJsaDRuTlYrTzM4TDRva1ZlOUpy?=
 =?utf-8?B?S3hXaXlqa3JFSmpTMzh4SllacnM0V3FOOGV4cDNjM01GMTBoMThhdWx1Y2tM?=
 =?utf-8?B?c3J5eFdQT1g0ZjFuc3poN3dqZXNQZERsQkR0Sm9iMUMrcER1Wk5DTG9TT0Vn?=
 =?utf-8?B?RFFCaDFBbVZoYUI4bGF3bFJPd2pwd1NhMHJJRGthSHAzOVVSb25qQnp4WWda?=
 =?utf-8?B?dER1QWp1YXU3a3JlTWtETjJlMkI3cWhhL0VTZytSUkRQUmtJWU9aaldDV2ZZ?=
 =?utf-8?B?RmhHZWdxQmo5T3hvNHZhL1c3bnBrU01ZQU9WMnVmSmFQMGxueXpObE5WRHNx?=
 =?utf-8?B?bEJaLzhDdTlibmtyZFpuMDdlWDlvdFBGTjZZZTdsUmtTbFltVlhSejEyYll5?=
 =?utf-8?B?TTZXOVc0Yzg2L210RGZtWDBVeU9zdVdIMmVoOGRJQ1EwckJxV0hUSjJuRTJ1?=
 =?utf-8?B?UkhOd0ZaUHR3OFZrYWZ3eE9LQWpTOXE0ak5WWVpYRk1BSHJGTVNKdnlWTGVD?=
 =?utf-8?B?SUdvQXdIOW8vd0swMWRFRjZ1SXowWGZPWHpNQkR1dm91RmZ2cWxGdk9xN0M4?=
 =?utf-8?B?aWo2c3psbitxTVNzKzkwT2lzaHFyUXllS0Znc08vVEdZbXo4NURlOFU4ZWdh?=
 =?utf-8?B?VDZOUnZCWTRqS3ZZZFR3YmdlWlBFVGtJS2pZL3lpNFdGcWN3aEVRZ0haVUtJ?=
 =?utf-8?B?Y1YwM3JkUlhkSFVpaDZyQlhqSGZONE40bDFXeWhoeXpFeVh6cDNUd1M4TXEx?=
 =?utf-8?B?NjVLZXVuNHBCNGIwemZUR1ZkeVNKUTMxNHB0clVjYUJBZXBtb3JUeUw2d1Rt?=
 =?utf-8?B?eUVuSHFrM1M5QnpsTUI3YnNSRXh2NjRYNTJlT1g0TWhxaTVNa1hBbzZnN25m?=
 =?utf-8?B?allsR056QnU4RklrbHRYS0MxOVJ5dUNGNjZHUjVoSWtRM1RQVVBxS1lZVW5j?=
 =?utf-8?B?Zk5naklPMEZCTnJidDlEU0RObVBNc3oyUEE5S3NkVkJYeVFNZG1VUT09?=
X-Exchange-RoutingPolicyChecked:
	Dmmd44mXVUM2NFhHzujhdf3oxP6tw22/0+gFLFsdxro+Uz22eiGOSxP01FRo5FvODUBDTJtzmny/hTeKw9cou+RlFQJr59j6DFSkOsQ7zQJxprl1WuR8Ibq96Bsa10HGxY+lnGb/0H/SpfRnQBCLk/rgtSx8nM8BA7ahXh5afE5O2zlM8UB++66P7amXTnLk6d/B2w+jJOA8nGJ5mH0hjO1Eal688HXnRSF8JKb+SE7f1T2o4baoC4RHbB7J/75gB6YmzEqy4P91hWmfdlTvBv5qPffjxT7FR6JlrbMmL+JW/fFW0TBXIm+VA1Bz5wV64V2+IkDp6ecYscEDU3KlYg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f8e6b2-646d-482c-685a-08dec1519ad2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 09:22:17.3179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UEVq2c7Z8REnw1VtXyiFpy0zrnB14Z2fQIchIAZdOFpMfQ5TKDaYoexhj8rxIhP5NElXNqs9E/l1ds9Jd5xyGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6515
X-Proofpoint-ORIG-GUID: OPkrJaK7ZRYeNKi1R-NBGVI67_SG3VLZ
X-Authority-Analysis: v=2.4 cv=PLg/P/qC c=1 sm=1 tr=0 ts=6a1ff24c cx=c_pps
 a=IyT5loBvHZYA5YPQi3EYsQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=t7CeM3EgAAAA:8
 a=E3fMownYBTMgEjRTmoEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: OPkrJaK7ZRYeNKi1R-NBGVI67_SG3VLZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA4OSBTYWx0ZWRfX8tHosqRnNY5d
 sgBy2rlSjXGAjAFSbWslkFVsB00mWaFW5zVqjKiqiiSHyWrNKtT6eR2WddyBJAfQ4nLQzmMD90t
 R1hOeTMWBBNIXjrbvnV+NNEFLzY7BCiZHGaC7zazJOCThDyBJEYyQcZS0Eeya+2Nn0hdYW6AsjB
 SlDaNXusyQ5BLsN/np6U/4ouvKSSKfJmwr5CnArxOFdcoxBa+G52vXrMx3ZyuhuoxFFyYw1AB6r
 veMdlOKRtV97sAPMvIxCCy9jctrdfjbY26/tzEx4xavnpWTIYEyZ/PQzR4ko3V5y8ovvYc+RV0W
 leSdAQKEalmCgwOvn0uOV0JW5UifnpwU74w6CJyGQcAl+HKNvn2D3uM2U39/XkwqtzFjGkwqJdM
 ZR6LORZLXlb8pSuLFIspT2FQ5EMm+2iumqAA8fvaUM2zCYVdr2WtzitEYcOhboY4ft082IB3IuH
 EGg1KzL9FT4LjlTLnvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030089
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294693-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,windriver.com:mid,windriver.com:dkim,windriver.com:from_mime,windriver.com:email,syzkaller.appspot.com:url];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9743636200



On 6/3/26 16:54, Jiayuan Chen wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender 
> and know the content is safe.
>
> On 6/3/26 4:33 PM, Eric Dumazet wrote:
>> On Wed, Jun 3, 2026 at 1:16 AM Zhou, Yun <yun.zhou@windriver.com> wrote:
>>>
>>>
>>> On 6/3/26 13:44, Eric Dumazet wrote:
>>>> CAUTION: This email comes from a non Wind River email account!
>>>> Do not click links or open attachments unless you recognize the 
>>>> sender and know the content is safe.
>>>>
>>>> On Tue, Jun 2, 2026 at 8:08 PM Yun Zhou <yun.zhou@windriver.com> 
>>>> wrote:
>>>> Please add a Closes: tag
>>> I will add a Closes link in v2.
>>> Closes: https://syzkaller.appspot.com/bug?extid=fa2f5b1fb06147be5e16
>>>> I found some not relevant syzbot report :
>>>>
>>>> https://lore.kernel.org/netdev/6a196faf.c16d89a8.217f2c.0002.GAE@google.com/ 
>>>>
>>> This should be the same issue. And it can be reproduced by
>>> https://syzkaller.appspot.com/text?tag=ReproC&x=12924152580000
>> Please investigate which device allowed to send an Ethernet packet
>> smaller than the ethernet header.
>>
>> We do not want to add tests all over the places, we should fix the 
>> origin.
>>
>> Look for dev->min_header_len
>>
>> Thanks.
>
>
> It's TUN.
>
> I think we should reject loading "tc filter ... flower eth_dst
> aa:bb:cc:dd:ee:ff ... " if dev->hard_header_len <
> sizeof(flow_dissector_key_eth_addrs)
>
I will add checks in fl_change()

Thanks very much for your suggestion.

