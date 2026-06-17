Return-Path: <netdev+bounces-300103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z4UXGLhuMmqKzwUAu9opvQ
	(envelope-from <netdev+bounces-300103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:54:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3A069822D
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:53:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=UMhTiNId;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300103-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300103-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A34F6319E7AA
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 09:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A3F37F732;
	Wed, 17 Jun 2026 09:42:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A219839280C;
	Wed, 17 Jun 2026 09:42:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689357; cv=fail; b=OIu7a7Ortf8dSTJpDzB4ZOyowQ4TnHqYsoYCeucrZkRbsIw7hpMhZz/X+fiViKO6CRyXx+HaSwrkIT8zbx+lE61jgwyiEa1HAoZQG25y1k0EgJFwKnTV0AV2FFu758v+EQvCJxVLc6o5iQ0tMeAKdCZbytp0oJvt2cWQdW3kd+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689357; c=relaxed/simple;
	bh=7wtAfOdHonqG5qmbPPo5J71jaJ+iPRO5d/JfQTDtyXI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dun5IwDDI7fWGgtGT5EwpDuOeZO03H/YrCt/hgC/1cRcx6KXw4Sy13vMmXgRWvESyGBXCslvLi1jd9eW+UiSImFy7cj9z4YRNyaRAIX3wJY7aNtOkhl19qRZsKg2MQkHLLfjC5PLwcy+hgqNHIb4aXBpExCsNrn07O/5rat7/xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UMhTiNId; arc=fail smtp.client-ip=52.101.52.29
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOYnAX4ylGjj17Nj86xf8jTGGsiT0CuqTNbfDDi3l9aJce6bf4H1axshPytCgN8VV90kw68+Q5WBuXEWXV70UB0U9j4oaSOrYVHzo80NUVtC0GfCLEZZgAQdlGuDHM+WkX5RBdUIrfM5WLnw+HGyFt4Xoni2uLGnB1y5/HX9xuAo4r38R/JbpS6asD4IN7OoRBKRXWWTkvl3NdLM2/tdNqCqGdcrMSu/c/Z1/NGs3OWiFkTjBtgKJsuFLctX2riqMfytZU1eiuY7mOYwvf0vU/ZZWDoNduV0cpNWjYOcw3lkwADcIvdzKkAbQ/NUqJVZB0AzYBsowLDA4hottoOnUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ne7aAlgdB+LiOZkPKzOxbp9QcbSTl7nWdCF0DDEoxo=;
 b=HmvN94tD+nPidg3mr6Y+HM4CY+hPEX7D5EmZ08MGAyta0UI+0A9y5yit8i4SUXt69w/lkvZMiY2YKDfAPaojsHxJo4Rev2vXJ0835Zji6PpODmkW98v/Hys5SYuQhZCsP6BaC9WLIxVdUZ/aDJJHR2dU9DG/KScVfjPFwBfztUD+DLbmOgRZj3N60NrNGfmK+bZRhPNb2wdjGGhziWdF6yXffsD2gY1BeJjnVNW8vc0Kgaj/o5S0NQrWFCB8rs3/sSyJmILrtF9xO+YrL+J2g/i78vMT8IfnOr9Vuw7B6rWqTo0yJTbJH6Nkvrfj9L8nHZFDnFdX70Jl2ZhkiYVUbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ne7aAlgdB+LiOZkPKzOxbp9QcbSTl7nWdCF0DDEoxo=;
 b=UMhTiNIdY/qRG5F8d7MC8uQmDQpS5BBK4jo4u1VNmOoRhM/rWL6TPi0Qnsst0iCxsacmeUUbeKQXJ+ROrdeiYmYGJ4ts/lJIjm/SPd3DvTola1b+kRLSxmkcw/3lAPXidNBu2ttahoplMy/ZbgIKHGQWCtT0Jpd+MnCO+ZdOZYA=
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 DS0PR12MB6488.namprd12.prod.outlook.com (2603:10b6:8:c3::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Wed, 17 Jun 2026 09:42:30 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 09:42:29 +0000
Message-ID: <a423702c-05f6-4b4b-9ad4-fcaec2e07957@amd.com>
Date: Wed, 17 Jun 2026 10:42:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v27 4/5] sfc: obtain and map cxl range using
 devm_cxl_probe_mem
To: "Dan Williams (nvidia)" <djbw@kernel.org>,
 alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20260609215755.8685-1-alejandro.lucero-palau@amd.com>
 <20260609215755.8685-5-alejandro.lucero-palau@amd.com>
 <6a28a206bf61a_4fa78100e4@djbw-dev.notmuch>
 <96ee638f-3b10-4baa-a6df-5a79efee8b8f@amd.com>
 <dcc502fa-1a06-465a-abab-9b039b9c2672@amd.com>
 <50d8e423-8248-4e26-901b-010d14d22e67@amd.com>
 <6a31a948d61f5_9b8551006b@djbw-dev.notmuch>
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <6a31a948d61f5_9b8551006b@djbw-dev.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::20) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|DS0PR12MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c5960c6-abc5-4bd7-ad8e-08decc54bf92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|921020|11063799006|4143699003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	cSQ3eXiZh+4tNjeZiycNCpobSFzVQlYMAGphCOn/DimLUd9DHNzE0y6jPR5IfujTGuKBnuvZCWlWsWGX2q2Fv+soPzXsyiu9wZl56azS8fqNFnwL5YCGwqXLdne1EPJWAX94jWYZ60jVaKqVLuYKaxZYQWS3OjGavikYIYtmWd8qt33wFD7cbpl2n2DXwTz8s+8wKItqtSX9qCfQjSeicnzfCOLf2d61tkOAQX3P2haZdMaGgW9bm7km3Fk27lFfMlo8c/IULcjCAiB2AUSf2QcH2QvnzW8tej3pmz9SNWC8NE9zwWxWKSlM6zXT7s6ecdHNisoB7FhmHor5cwqMIogUC12p4KFQbHa+K4neJt9z/VRXio4Ssq5y1o22yzeGjbPYVIRFxCZTaQgg+2U2i091dk50+ghCtBWvxySjxFl9oOtZm0f0tltl8TeuqamaDh9Ef1Z50cgdcwgYHYit2oP2ioX9dctY2ITUW6aaCUcPWRj2o2DxIm4YVe+MBFcQnGvI7skxxs1DEfEmcS1x3R+pa7z0BoH1psKq6OJeZrcnm2K9xW6h5aPOhexd0buD2DrQmYyk+q4pBJfK21ZuH4CIViE0FLDJKVpVQ5Yw8xMhHkxT+qpgGOuHiz1rCw8jy3Sx1C7swglRwCuh3x2PIRII6k+Z9X3cWZX+7fqvD3lZ/+yoB/F6EWjDVBTU098zUiGifkuPZXN6XFq1fP3/XYCQNdh2gVh/jXbLcmowbz4ZAYuLuNfiCya/BB32sfTv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(921020)(11063799006)(4143699003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXBOVFBBUDg1M1JVMXlMYmd6bndzR09DQkRWSWRpdmJ3TUNZbTBSaHhoa3Jo?=
 =?utf-8?B?dlBKUFk4K1pWL2NCN0QrOVVkSlAxSTFhekExVWp4NXZwK0hxdUUrR3lZT3Js?=
 =?utf-8?B?aytSYllLTGxaakRjZWluM0ZsNUllSkJJSTlZMy9YckI3Wm5yYzFZWjJQSTg5?=
 =?utf-8?B?LzdMWHhkcHJKRGUzTlVXLzZhOUZDZGxMY09VcCtoUmJrTU5WWmV1bURzT0tY?=
 =?utf-8?B?c3ZOWCtTb3VwTC9lYTBheXNaRmJpaFkycHdwN3dzakFNbW9mOThMQnZYNGUx?=
 =?utf-8?B?OVpqM21pcm9iZDNsZDg1MG0rZGo0VTR6WFdabnYzeVhnalpSaFczdHRaQXFh?=
 =?utf-8?B?WUNxNzlRa216eURPeGhxUk4yNFNFTUhQYldST2dHMDhCc0xOdC9oT01tcmFQ?=
 =?utf-8?B?bitXbCtIQllLNkp6aWlFUllYYmhQR3ducHJyVTZJaU1zT3NDVW12anR4MTVR?=
 =?utf-8?B?MUw2akJUMlh3NnRYYlRBWG5OSVhXcU4zdzFGbkY5RTZwNUdoWTRlalhoUUU0?=
 =?utf-8?B?bURrSTFwaFUvSGQyOCtWcmt4YURKT0p1MGI5NFg3VVM2OGsxOUlOWEowWmFj?=
 =?utf-8?B?VTJQLy9WcG8rWlhLaVlDbTBLUEpmK3B2MDFzb09KRFRPblo2dnN2Rms1WER1?=
 =?utf-8?B?RFhRT1ZxL052R2xNOXhtR01HVzFHUzkxV2JBa3dTZUIzcHFiY0pabEU4UnRY?=
 =?utf-8?B?OXZJMTI4bUsrVmY0ay9RTEJMSFhEVENJaUVpaUd5blE5Ry9pTnRkaitDK0dx?=
 =?utf-8?B?WkFrZzlHd1lqZjNFVWY5RkZ3QVdyZEpiNFBKck93ZDRxUWljaGt6VndiV1lQ?=
 =?utf-8?B?QStLbGNFTlk2aW9tNEZZTEJIVzhkb2RNOEYxa0ZuYXF5RTVidXJkOEhaNm0x?=
 =?utf-8?B?a2NNYVNCeVBEaWpzeHMxRFdxS2t3STV1TmFNeFphMGNCdmpYN2U0VTZMN1pQ?=
 =?utf-8?B?VnlVQ3FlVFo3SXpGQi9ZSldQcHhjOFJTZ0JPejcwUllORVBxV0ZLdXYzWUFV?=
 =?utf-8?B?c0lJb1FwWmxqbktOb09LK3NXUzQzYWtrWk04MnZqZXF2TXVRaElxdFdTME55?=
 =?utf-8?B?VFhSa051anRDOUs2T2xwMjBQQmEyVzArajVyTXJRQWIrMTRJbkJrSzh1M0dw?=
 =?utf-8?B?L3J2R0FJQ2Y2MlJhNXFST1Rvem9tVy9lN3ZxcEVwV0pMUS9MVy81N3J6UzRp?=
 =?utf-8?B?TGpBdlJGVkMwaTMyTVJER1hJTFprZ3o5eHhyVmxKSDQvWVdSMUloUTBYVm9B?=
 =?utf-8?B?TTBHTHlxK0ZKT2Z1S0V1M2c2VmFieVFQbEFzQnNta2o1cWgrV3ltQ1Q0aFBx?=
 =?utf-8?B?Z3MwTks2SW1nL1JnZXZRZU1YNE5xTXBFL1pmbW9VMUxsV093SnE2SG5kWnFp?=
 =?utf-8?B?V1VTTHhSbkVSbE9sTXVNYk1VMzVnL0lzcHd1dmRRQ2ZQWldzdm9JbElwcm5q?=
 =?utf-8?B?T0R4T2FyMThrYkVHbU53dFlWdUptUFh4TlNuQzEydFRUY1pINURVSXMza0JP?=
 =?utf-8?B?U2N0NUpaTkhpNFlIbXkzRURXNmRjZEQ1RTZCZEtYdkhBOGNqT3huaDlWVktM?=
 =?utf-8?B?eWxsM0tNeXJxMFVnYmFmSUxNZlkzZDhaMC9Vci9hQUVmb1dnMXNOSTNYRkdN?=
 =?utf-8?B?UkFJRU8wRlQ3Q0VSbURWSzlBbkV2WFZYcEU1ZkhHNnhtTW5TclhhTUJxaEor?=
 =?utf-8?B?K1RxdUplemZlQ0l0dEp6bmV4bGlzVkxIamtJYVY3QmN4T1pRZTMvM2VDRUk3?=
 =?utf-8?B?bWsyNjdCZU1wYjV0aFZmZGJMZVZHSEhwTHNTMHlJRW5OQndXdGpVWjR5eVpL?=
 =?utf-8?B?WEc5bzZJUEZPRktyWjZUNkJacW9IbGJMVHQyZmR0Mm1iSHlOUUJqYTJnck9J?=
 =?utf-8?B?Qk5TeEVQRkpjOG9FaXl4S3AyWm1CNnZXZU9CTEVaOE85bnFDb0pDRGh6MHVG?=
 =?utf-8?B?N3dYWkUvZ3pzWTlvVUczeFd1OThZa2dUTlZZeG92WUNXc0lIQ1pYOXFPc2tQ?=
 =?utf-8?B?WUZZb1JERjRvbUtrMTNLUjVMSlF0a0EvNFFYM2JEdEJGYjlVVWNkU3ZZUUNF?=
 =?utf-8?B?QUVQYVVaT0dIWm5tc2IwV2tMckZyQkdiUGRmbGt3U1pqOWxZaFFCWkVTK3RB?=
 =?utf-8?B?UG40TENCUzZIbk5BNGdtcVNRTy9yeVhXUGszdzdqVURJNzJLOWJqWGVBdDBM?=
 =?utf-8?B?NnV4bGtjcWovN0NPRzlCNHl1NWZqMWUybiswcFNHcG9OL21hVTZkcTZFWTBE?=
 =?utf-8?B?YnkxN1RqYkU0TWV2ajFvMlZ3MXpjcWl0dEpqY0MramFNRU8ydlBEcHMra21T?=
 =?utf-8?B?TStMbGFIdFFMTVdBOXF4VFFlYU5ZMWhQU3JqdnVCcFJ4WjJXcnN0Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5960c6-abc5-4bd7-ad8e-08decc54bf92
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 09:42:29.7917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scohybuXKwtwoT9WKlB7j1+hUzWaxeSiGJh1A0e494QGd+vRaEo4IEQDNDs0JrmmvBovfBBZ7xfxpDTc1Zs9tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6488
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300103-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:djbw@kernel.org,m:alejandro.lucero-palau@amd.com,m:linux-cxl@vger.kernel.org,m:netdev@vger.kernel.org,m:edward.cree@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dave.jiang@intel.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF3A069822D


On 6/16/26 20:51, Dan Williams (nvidia) wrote:
> Alejandro Lucero Palau wrote:
>> On 6/10/26 14:56, Alejandro Lucero Palau wrote:
>>> On 6/10/26 07:10, Alejandro Lucero Palau wrote:
>>>> On 6/10/26 00:30, Dan Williams (nvidia) wrote:
>>>>> alejandro.lucero-palau@ wrote:
>>>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>>>
>>>>>> Use core API for safely obtain the CXL range linked to an HDM
>>>>>> committed
>>>>>> by the BIOS. Map such a range for being used as the ctpio buffer.
>>>>>>
>>>>>> A potential user space action through sysfs unbinding or core cxl
>>>>>> modules remove will trigger sfc driver device detachment, with that
>>>>>> case
>>>>>> not racing with this mapping as this is done during driver probe and
>>>>>> therefore protected with device lock against those user space actions.
>>>>>>
>>>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>>>> ---
>>>>>>    drivers/net/ethernet/sfc/efx.c     |  1 +
>>>>>>    drivers/net/ethernet/sfc/efx_cxl.c | 24 ++++++++++++++++++++++++
>>>>>>    drivers/net/ethernet/sfc/efx_cxl.h |  3 +++
>>>>>>    3 files changed, 28 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/net/ethernet/sfc/efx.c
>>>>>> b/drivers/net/ethernet/sfc/efx.c
>>>>>> index 90ccbe310386..578054c21e79 100644
>>>>>> --- a/drivers/net/ethernet/sfc/efx.c
>>>>>> +++ b/drivers/net/ethernet/sfc/efx.c
>>>>>> @@ -984,6 +984,7 @@ static void efx_pci_remove(struct pci_dev
>>>>>> *pci_dev)
>>>>>>        efx_fini_io(efx);
>>>>>>          probe_data = container_of(efx, struct efx_probe_data, efx);
>>>>>> +    efx_cxl_exit(probe_data);
>>>>>>          pci_dbg(efx->pci_dev, "shutdown successful\n");
>>>>>>    diff --git a/drivers/net/ethernet/sfc/efx_cxl.c
>>>>>> b/drivers/net/ethernet/sfc/efx_cxl.c
>>>>>> index 4d55c08cf2a1..d5766a40e2cf 100644
>>>>>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>>>>>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>>>>>> @@ -18,6 +18,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>>>>>    {
>>>>>>        struct efx_nic *efx = &probe_data->efx;
>>>>>>        struct pci_dev *pci_dev = efx->pci_dev;
>>>>>> +    struct range cxl_pio_range;
>>>>>>        struct efx_cxl *cxl;
>>>>>>        u16 dvsec;
>>>>>>        int rc;
>>>>>> @@ -75,9 +76,32 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>>>>>            return -ENODEV;
>>>>>>        }
>>>>>>    +    cxl->cxlmd = devm_cxl_probe_mem(&cxl->cxlds, &cxl_pio_range);
>>>>>> +    if (IS_ERR(cxl->cxlmd)) {
>>>>>> +        pci_err(pci_dev, "CXL accel memdev creation failed\n");
>>>>>> +        return PTR_ERR(cxl->cxlmd);
>>>>>> +    }
>>>>>> +
>>>>>> +    cxl->ctpio_cxl = ioremap_wc(cxl_pio_range.start,
>>>>>> +                    range_len(&cxl_pio_range));
>>>>>> +    if (!cxl->ctpio_cxl) {
>>>>>> +        pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
>>>>>> +            &cxl_pio_range);
>>>>>> +        return -ENOMEM;
>>>>> Dave caught the iounmap leak, but another concern is since you want to
>>>>> continue operation if efx_cxl_init() fails then you probably also want
>>>>> to release the successful attachment to the CXL domain if this happens.
>>>>
>>>> I will do that.
>>>>
>>> Looking at this issue, I think an error when creating the memdev or
>>> during the region attach triggers the memdev removal, but ...
>>>
>>>
>>>>> Minor since something else is likely to fail if ioremap is not
>>>>> reliable.
>>>
>>> .. if we want to specifically do that with an unlikely (but possible)
>>> ioremap error something else needs to be exported like
>>> cxl_memdev_unregister(). Are you happy with that approach?
>>>
>> I have just tested with this:
>>
>> +void cxl_memdev_remove(void *_cxlmd)
>> +{
>> +       struct cxl_memdev *cxlmd = _cxlmd;
>> +       struct device *dev = &cxlmd->dev;
>> +
>> +       devm_remove_action_nowarn(cxlmd->cxlds->dev, cxl_memdev_unregister,
>> +                                 cxlmd);
>> +
>> +       cdev_device_del(&cxlmd->cdev, dev);
>> +       cxl_memdev_shutdown(dev);
>> +       put_device(dev);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_remove, "CXL");
>>
>>
>> only called if the ioremap fails.
>>
>>
>> Please, let me know if you like this approach before sending another
>> version.
> A devres group can automatically cleanup after devm_cxl_memdev_probe()
> in the error path with no new exports needed from the CXL core.
> Something like:
>
>          void *group = devres_open_group(cxl->cxlds.dev, NULL, GFP_KERNEL);
>          int rc = 0;
>
>          if (!group)
>                  return -ENOMEM;
>          
>          cxl->cxlmd = devm_cxl_probe_mem(&cxl->cxlds, &cxl_pio_range);
>          if (IS_ERR(cxl->cxlmd)) {
>                  pci_err(pci_dev, "CXL accel memdev creation failed\n");
>                  rc = PTR_ERR(cxl->cxlmd);
>                  goto out;
>          }
>
>          cxl->ctpio_cxl =
>                  ioremap_wc(cxl_pio_range.start, range_len(&cxl_pio_range));
>          if (!cxl->ctpio_cxl) {
>                  pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
>                          &cxl_pio_range);
>                  rc = -ENOMEM;
>          }
>
> out:
>          if (rc)
>                  devres_release_group(group);
>          else
>                  devres_remove_group(group);
>          return rc;


OK. I will use this in v28 instead of that export.


Thanks


