Return-Path: <netdev+bounces-302545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uFIlLnc9QmoR2gkAu9opvQ
	(envelope-from <netdev+bounces-302545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:40:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 266436D8549
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:40:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=hinx2uMP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302545-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302545-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D106630094DD
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505DD3B19B9;
	Mon, 29 Jun 2026 09:39:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012029.outbound.protection.outlook.com [40.107.209.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176C73F9F41;
	Mon, 29 Jun 2026 09:39:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782725993; cv=fail; b=DIe0k2Z83ujyV88tGDIs/6ozCboOG3NHo/bUEDbHHTuD2mb4QSCqn2M4QpwQPQ2KT9wc2Ev9Kkj1TcPYZTiqMwkUQJk6aTdZBkTNcMj5OdqgdOrpxP3FLVnMBityadGxUDl1JmLWklywxFetF6HjTBVHuZGeSbMbCmcgg22WP2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782725993; c=relaxed/simple;
	bh=kqCfx825k9YdFWmJR+68zP4e49hIRIRrIkmmJWl9deI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U3gINuuysHLqygimLwbsJXQiqDun+DLu3ySV/rcJtoCbtvNJ2cp1KZsZ/tS0NI2EP4Smv096vMl4wqq/DKB96tNCHyAcHzv2/PkV9vbSfQ/kZQvRSbbnijyah8tpYJxdu3LtGcqio/HCloP8jwZ5dwrootCUeacCZijppqfRVy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hinx2uMP; arc=fail smtp.client-ip=40.107.209.29
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alLAYaqk+TUFYtWg1Hx+K/gYO7Vgb/vlGldClWCf3zHribaKqU9tjvziVU1j1BnBrDcRHCdskwTa+M/5J5/jhLYaOKAOmEmNF38uA3uKdEd+EiTMjc4/Jdb0Hkj7kaBJHu1UMU6u8mNV5Frt/Jm1jT221+aBfK16eJVo8e8TjkztYgXUPwSZwG4U1wHco9dfxBrm+mi5q0XkOLtNrxpj6pTf03GLFgwjl1VJTxG3T62ggQhhePTK0ALHcv7qAMxLU/i5IckmuqYJ+37X/BV5uUnhb0UrItmpIJbsEUNaXVPGhtGJIo6z/o4iSHIb5v/7IToXMqdyaLiJiNnHYuwo5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTNRmu0BnXQV0IfAjMzKEVRAl4MsMaAgrhcPrepmsCs=;
 b=OX8w9O0gmj7QzDeaSMMlTherfzsws7lSoqox5kc2FWGwNgVSnlqWL4sSIjvyVwo0kK8w86SgIMTyRWofIyBEuSrkPHoJAvHIUgjcfDGYAL/e/oti0qf4z63k5uAjzjt4fiExF46IpcJICDKwcZmXwJ09h8JSKPaFBeSalL9TogkHt7XS03mwIlrrZskEeC52IJYXMGJgiHHfCf+SyUB2BDaEEP11bmGjgLSdfdC6fYeIOqxmA/MjOi/KvDrVQ+Q2SuTcXMXID0vDhddv+ivJcEWJkhUzEBA72YqUyut5gE8DGenf50B/VVL85c8HifpVNImm973Bt54ZvQ0YCpzaSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTNRmu0BnXQV0IfAjMzKEVRAl4MsMaAgrhcPrepmsCs=;
 b=hinx2uMPgQ801rNPKVJwHMTcBJNSISVXZ0mrBTeVIID5mMZKQ4I9xFMt1Ju3N4G7lQRVYiS27QED3EAm2gNtq7CZ2U1eu3EYRR+Y84lvKPbPwL6gaYt2e3a75h7SjQTB4I+KEw/GFeD77qkeqpbOGuj+8m5ho5qV/ynpUcCG2697bCjUIw4nbpPh1Bk4YuhcbUftKNPlCBJziA1tfumRG1HUdQom4vwvojaupn4n5Le5wHrWbooiFIDbZ6g6AyXc4ZFlC19IMillVBB37fMQSD2QEIpKOjVTOK42UA2Oe666J+bDHVhpUdt/9o8JNPZbls7AahNT3dDIiyH7YMHo7Q==
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by MW9PR12MB999207.namprd12.prod.outlook.com (2603:10b6:303:301::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Mon, 29 Jun
 2026 09:39:48 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 09:39:48 +0000
Message-ID: <89b04dff-3cc6-4ce7-8909-30552aed653d@nvidia.com>
Date: Mon, 29 Jun 2026 11:39:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-vdpa: Expose ASID group change after DRIVER_OK via
 backend feature
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Tariq Toukan <tariqt@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org
References: <20260511094504.1619893-2-dtatulea@nvidia.com>
 <CAJaqyWc6gA=TU-YMYdttH3_MjBo+644kgmah1XZnvxP58Gxzag@mail.gmail.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <CAJaqyWc6gA=TU-YMYdttH3_MjBo+644kgmah1XZnvxP58Gxzag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0223.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::16) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|MW9PR12MB999207:EE_
X-MS-Office365-Filtering-Correlation-Id: d2ab9994-b5ee-4bb2-b136-08ded5c25c1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8+JIQeo7YItV78slYxS+CZr0x3854KftV4gAhxeACU2Y0bP7UBrhL6I7ISPIlD6J5hTGVdxZJXmS0piEBQjiJJMlZ2LzBROoE1OO5PAKNQsnvb/LqFNuigp+OgrGK4jj02G9Ntw6k4QP91XAO1KWfQ1QiioaZYMl59Mq3DJNtS5kHzm/4gXbIjgD976xR7PSLsf1Y+1HWTURlgpichvQDmbXE1WhPy24X3G8yaBt6iBH+z2vRI6x/6H3uONO7ZXs+qdHc0n8DCqXFG9rP5pR87c/XI5RW9yiMGVj4p52yKSR5gD/OZjIVIpVk3P9je3HYZX70qUeF2+PyApUzcp4qd/m7BN6MKP5i5cxD0g5BgKUzqWh37T322BTZknPha9TIiREOLo1mGTrApw+yt3oZAEe2iYyua4cmmY0lF0MKhKjCI/vAjVTFtjxgL8mKmdQlVfHPGzCwxuIitueQ2NweAYdGrFDHHf7RWEM6DsAKI9iSLeLhs26+nCTwH+O4GFRMSY30DrEM97fx+JqCtsDMfdbEaLZ9mdjoX0GaaRpHi27NeHP03XOSBSrtUNWv0etHfxc9YpeqYpJG6NDMnH3lP9SAwbxIyb0BWG59+5lrZR6F/zOa848Zj7ZuFmDVs+D++x5yB/W9XCF3iHscq0Oseho5FvGQ5vrZSLRp4H6+34=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWx6YWk3SVVlbkVOOGZsVEhzVkovNlJJaW1mb3BXTTdzSVdzK3ZMQTZmL3VG?=
 =?utf-8?B?MGJrNkQxemtrNDVzVXBiNjVvdTlwVS94bGxNZXpUSko2YWVRK0dJYWxWUnll?=
 =?utf-8?B?aEdKRWJCb2ZoTWduZjhVbE9wMHVhNnFOeDd4R0ZHOGJHNzhuUUVERVlUb0tW?=
 =?utf-8?B?NnNSYVlJWE1XZTBneHpkaVhaOEhyTkRWYXdnTTBTdzJPQ3ZXMEY5cVVkbHZC?=
 =?utf-8?B?NHBETEJGazNwTmtNYWdBSk05ZkZiSGpOT2hLejl6N0NWamxZS0N6QWJYZXE0?=
 =?utf-8?B?b2VuUStENDJibStUd2dYUEZBTTV0TjVnQ0ZwRnNKajErMm44L2NJZkdvaUEy?=
 =?utf-8?B?aWRCcHhnV29UTXJ0NGM0MWc3b3FIaXR4WjY5ajJMakhuclhTSHNIVGlVbDdH?=
 =?utf-8?B?WW9HNmF2aldiRnBrTzZDT0V0dFl5Qk1uTnE5bjg3cFhKMVdFaGQzdWRTbHZL?=
 =?utf-8?B?bFdBTitwRXI2bnkrKzNEZzJiMDViMWxQTVZOa3A3d3h5TzlDMmlRVENJS1RX?=
 =?utf-8?B?YzJpUDRrSWxvT2VWZmptQ0N6WTBmZ3orUTJrTmcxdHB0ckNpZmFaSlhoREZn?=
 =?utf-8?B?OTI2dzhwSDhMTHpFZWVLWVBHQ1dOZEo4S1N1WXFuYmJXaVR5YUdhYmtBM0I4?=
 =?utf-8?B?Vkd3WkNNc2QzeGZDVEt3SitKVVhGdkxhZmVDQk1QQ0FVNmlFUmpZazQ2L3c3?=
 =?utf-8?B?QnVEUHUwUU9QYnhycm90eHpUQ3FVNDQ4V2ExNzhqTmtJcUtFQUlxZGZINWJP?=
 =?utf-8?B?N0RVWk5VczJJQmd2bE9mOG9aMmNoRFVYZUwvMm1ZVWl2YkNUZE40RG1hRzJN?=
 =?utf-8?B?bDRJbWdlYjV4V3NZcHVNQ2FNYytmMzZLM1RSLzFCNmxMcXVhckxZbVVza3Iz?=
 =?utf-8?B?N0RDeFd0TGlEbGtqY0JLOFVRdzVmdlJFUHduMnVTR3F5aG5MSGtPRVBsWnFF?=
 =?utf-8?B?L256ODhkbUJXVE1MQ1pBUkZKWlF2NFJNenlrQ1BHQ3VWR2ZETXBzSE5KRDQ2?=
 =?utf-8?B?R1B5NWppQWR6R1NtQWlycW1ERmdBZ1VWNWlKY3c2ZEVIYm5RNEQyZElFbDl3?=
 =?utf-8?B?dVNEOFlMWWYwNEhWNWx0SHpPVVhKelRzUFRZSS9DdE5RdTMrVDJzQUZ5ZWU2?=
 =?utf-8?B?VHlhMmlLdVhmZTErRFRqRWJzYzRuVW9wVVBIaHpuazFlQW1wNE5aVk5PYVZh?=
 =?utf-8?B?elpkOThGUi80Y0FPV0FybEYxam5salp4WElDNlZQcFFaRnhDVHhManpvYlJG?=
 =?utf-8?B?cnF6U0NjSzdEZFVGTkJ6NjNvN1FBZ3gyK1YyVlhsaDdNN3ZUTUJURGpXYThK?=
 =?utf-8?B?eGVKc1VWTHpqUXM4d3NqcmtYdXg0ZlNHcVZ5eSsxTlU4ekJ0T3JVdXlmY3NU?=
 =?utf-8?B?YVowS1U0bmc3aUd6cysvMUZBTGZodWZsVm1NWW1ISllXL2EwWWt4M0o3NXR5?=
 =?utf-8?B?KzVxb1NkTzAwSHF3QjE5ZTcvRnBycENBay9lR0VLME9tbVM3dUxZZXR1VnZS?=
 =?utf-8?B?UXp5YWJRVGliOEFoM2hNb09sallJbTUraVNhS1RIRzRDd3lCRWl1YmZKWlF2?=
 =?utf-8?B?RUlCMTEvZzE4TXRSanVjMDVORy94OVM3a0UvakFFbkl2aE5zUE04L09yekt0?=
 =?utf-8?B?WXpMeEo0Z210ek5oSndQd0VWWXdEbVFGbnlMTTg5Y2Qxa2NBZDE3M3JjWHJJ?=
 =?utf-8?B?VXZ6Q3pRQVlNNno2NlZOc2NORnZ0TnhCQ2RHOTNTUS9KWWh2OG1OR3djZFZu?=
 =?utf-8?B?MVdNVS9NUk9kdGUyb0N3b0prTEYxWEhiNWhyOHh0VXZrYjFPNm1CSTVMVWtW?=
 =?utf-8?B?SXNOb1B4ZGxpYS9uT0I3V3pCSlVkaEh2OFZjdVFwK3Y5WjZaQWU5M3ZpUnV3?=
 =?utf-8?B?QVJ1dDBkdGdOdHBOK0JKeGdKb2EwNEZOWmtPVGFhQXhRcHF4Nnc0dzc0MW5H?=
 =?utf-8?B?VEtGTkwreXJNYnQwMnNTbk5hZkZlZ29vNTNTZkdvbTdWZlhaWkRnQ3lra1dy?=
 =?utf-8?B?L1p1TTZYYzNBVmsrNTFrZElyRzU2TUZ3dEcyUUZGWjVqM1ordWdONnNNWmI2?=
 =?utf-8?B?SXFUQTBRUU9ZWS9iSmVxN3RtaUF6bkZJcjd5WTFkVzA3QnFnMW9KcGU4akdS?=
 =?utf-8?B?aitFWkJjTU1STURtWW54NmhnVjNGTFN4d3NwWEkwckN4Y0VqQXhtTlhoUGlM?=
 =?utf-8?B?T1dFaVNKWVhWSmJvSk5ycDJlVmsvV3pNdHZid3o3Y0RXU2VFR290WUpiL3hS?=
 =?utf-8?B?RzFNd3dKa2hRVmovVCtOQ0s0d3luS3J0VTgzUm0yendwSmdBOEhtOS9nZWpk?=
 =?utf-8?B?K2FqZmJRVE01aVYyTitzdEw3dExnRy9JUXRMTHZoUmt3VE90Q1ZsUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ab9994-b5ee-4bb2-b136-08ded5c25c1c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 09:39:48.1382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSMRecHuTyFREIa6eYsl4jfhsV0Ekhym//ej1uFuA/wk/E6UDFAqMxYgKADp6nSM7rjAxgdUF2VgIvhKQL+ZbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW9PR12MB999207
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302545-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dtatulea@nvidia.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:eperezma@redhat.com,m:virtualization@lists.linux.dev,m:mst@redhat.com,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:tariqt@nvidia.com,m:shshitrit@nvidia.com,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 266436D8549



On 21.05.26 10:26, Eugenio Perez Martin wrote:
> On Mon, May 11, 2026 at 11:46 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>
>> The commit in the fixes tag blocked VHOST_VDPA_SET_GROUP_ASID operations
>> once DRIVER_OK is set. That is too strict for devices which can safely
>> handle this during live migration flows.
>>
>> Bring back this behavior under a new vhost backend feature flag. The
>> feature is supported by mlx5 and vdpa_sim devices.
>>
>> Fixes: 3543b04a4ea3 ("vhost: forbid change vq groups ASID if DRIVER_OK is set")
>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
>> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> 
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> 
>> ---
>>  drivers/vdpa/mlx5/net/mlx5_vnet.c |  3 ++-
>>  drivers/vdpa/vdpa_sim/vdpa_sim.c  |  3 ++-
>>  drivers/vhost/vdpa.c              | 13 +++++++++++--
>>  include/uapi/linux/vhost_types.h  |  4 ++++
>>  4 files changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index ad0d5fbbbca8..f89177957c76 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -2906,7 +2906,8 @@ static void unregister_link_notifier(struct mlx5_vdpa_net *ndev)
>>
>>  static u64 mlx5_vdpa_get_backend_features(const struct vdpa_device *vdpa)
>>  {
>> -       return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK);
>> +       return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) |
>> +              BIT_ULL(VHOST_BACKEND_F_GROUP_ASID_AFTER_DRIVER_OK);
>>  }
>>
>>  static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> index 8cb1cc2ea139..253c7fb35ea0 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> @@ -428,7 +428,8 @@ static u64 vdpasim_get_device_features(struct vdpa_device *vdpa)
>>
>>  static u64 vdpasim_get_backend_features(const struct vdpa_device *vdpa)
>>  {
>> -       return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK);
>> +       return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) |
>> +              BIT_ULL(VHOST_BACKEND_F_GROUP_ASID_AFTER_DRIVER_OK);
>>  }
>>
>>  static int vdpasim_set_driver_features(struct vdpa_device *vdpa, u64 features)
>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>> index 692564b1bcbb..67b3f49fa709 100644
>> --- a/drivers/vhost/vdpa.c
>> +++ b/drivers/vhost/vdpa.c
>> @@ -682,7 +682,8 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>>                         return -EFAULT;
>>                 if (idx >= vdpa->ngroups || s.num >= vdpa->nas)
>>                         return -EINVAL;
>> -               if (ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK)
>> +               if ((ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK) &&
>> +                   !vhost_backend_has_feature(vq, VHOST_BACKEND_F_GROUP_ASID_AFTER_DRIVER_OK))
>>                         return -EBUSY;
>>                 if (!ops->set_group_asid)
>>                         return -EOPNOTSUPP;
>> @@ -791,7 +792,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
>>                                  BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST) |
>>                                  BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
>>                                  BIT_ULL(VHOST_BACKEND_F_RESUME) |
>> -                                BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK)))
>> +                                BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) |
>> +                                BIT_ULL(VHOST_BACKEND_F_GROUP_ASID_AFTER_DRIVER_OK)))
>>                         return -EOPNOTSUPP;
>>                 if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
>>                      !vhost_vdpa_can_suspend(v))
>> @@ -805,6 +807,13 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
>>                 if ((features & BIT_ULL(VHOST_BACKEND_F_DESC_ASID)) &&
>>                      !vhost_vdpa_has_desc_group(v))
>>                         return -EOPNOTSUPP;
> 
> Ouch to me here. By reading the errno manual:
> 
> Nit: By reading errno(3):
> ENOTSUP - Operation not supported (POSIX.1-2001).
> EOPNOTSUPP - Operation not supported on socket (POSIX.1-2001).
> 
> I picked the wrong constant even if they share the same errno value
> (by the same page of the manual). MST, is it worth changing it?
> 
>> +               if (features & BIT_ULL(VHOST_BACKEND_F_GROUP_ASID_AFTER_DRIVER_OK)) {
>> +                       if (!(features & BIT_ULL(VHOST_BACKEND_F_IOTLB_ASID)))
>> +                               return -EINVAL;
>> +                       if (!(vhost_vdpa_get_backend_features(v) &
>> +                               BIT_ULL(VHOST_BACKEND_F_GROUP_ASID_AFTER_DRIVER_OK)))
>> +                               return -EOPNOTSUPP;
>> +               }
>>                 if ((features & BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST)) &&
>>                      !vhost_vdpa_has_persistent_map(v))
>>                         return -EOPNOTSUPP;
>> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
>> index 1c39cc5f5a31..ec1ff8a2e260 100644
>> --- a/include/uapi/linux/vhost_types.h
>> +++ b/include/uapi/linux/vhost_types.h
>> @@ -197,5 +197,9 @@ struct vhost_vdpa_iova_range {
>>  #define VHOST_BACKEND_F_DESC_ASID    0x7
>>  /* IOTLB don't flush memory mapping across device reset */
>>  #define VHOST_BACKEND_F_IOTLB_PERSIST  0x8
>> +/* Device supports changing the group ASID after DRIVER_OK.
>> + * Requires VHOST_BACKEND_F_IOTLB_ASID.
>> + */
>> +#define VHOST_BACKEND_F_GROUP_ASID_AFTER_DRIVER_OK  0x9
>>
>>  #endif
>> --
>> 2.54.0
>>
> 

Gentle ping. Is this patch missing anything?

Thanks,
Dragos


