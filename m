Return-Path: <netdev+bounces-299864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AsryOIRbMWrLhwUAu9opvQ
	(envelope-from <netdev+bounces-299864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:19:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8672F690665
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:19:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=virtuozzo.com header.s=selector2 header.b=Z8AHqwGK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299864-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299864-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=virtuozzo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6FD6F3098E73
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCF7376A07;
	Tue, 16 Jun 2026 14:10:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023121.outbound.protection.outlook.com [40.107.162.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20803A451D;
	Tue, 16 Jun 2026 14:10:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619046; cv=fail; b=elQfpnXlAGFE/Zf1BTu3H1eOmIMfzT+2HPduqYYWG7zh4CbHH78W9BNgnxCpM4KqnEZnO50MwlCHGxWajWM4EoaVRF3Kqisd88be+2iavPRdaw9UKnQkEa5qlcV8N2kqDQp/T8LYU0xOZgv6yxAglgwnUy6hOwbCXJxtoM0m38E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619046; c=relaxed/simple;
	bh=94GFxqFiDUw+Wb9ZnccFDh8WLw/s6Z9D7J0s6h7+Jho=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=frp8aK8FBJqdxEn5BWgXgSpX6SkS3yKxXcVRqEcABDjhphIJik6qye4+FW+U4PauljzPTZPfKoglkgdFfegjTS05dH5l02/OjQHlt5rJEi9eLrWS7CrCe2A75GbIvO0+Lunwsp/6wQRrXE1woVkq2CH1IlwbzisDAWYijyR706I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=Z8AHqwGK; arc=fail smtp.client-ip=40.107.162.121
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQHRvrJ+SVE+RBySQjmk/qeYvnED+TSkSUnk4i1OVLpSV+gcb6JMGUDDcIYNH2JbtS31iaa1/b2y9raIxeC4IXPFl2zOjofwletPBP3uq/vsGCjTG2PPg+52juDIBhvuc+UomB+/FP2Mq/WKeFvE1M9psDc1Ab6JJEkT2w3TWQSmngx2i4sF7p4DfTJutLP7HwJfEc8XTi5wlz3KHJoy5Dd1ZysMsK+t/+nJ3qIOx/O+gzDJpBkQjcH3htCjiOOPl4rimYrezVfQ+1+2zY23FRvMKbrXflWKCpTVskiSRET4DToyJNpnIVR4DxjpsTgPCtvCCqR+xr+9TS64SE0jrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/J1XShNxq+GR8v6JNVU+6xpDj4AWjHa9ivxaRtv0h9E=;
 b=HwLAOjkyoXiw7SssPLAQElLJ111Ue1jL4ui61AdTMxAUkf+U9glITGSFBUFjItc/X8Ng3f2VoA3U54qJGo/1LU0HGyb6v7BI4JPmYmATcehuJ73XGM/Ias25C33LPd8tucFJf72/8tM1uve7EPpBR6ONDNdbrbIzDch5dQ+yvqlW2zfD4uDe8eT6yj3IEo1bYjP1Mg2O6DUpAnc5cbqb2w2hzOFwAvkZXKUGR0LmM9aEYnTHOC+WM6IrRN6+IXHEn6ECHryVQsjmoxvh+z9KqS+vyamuNBvY2FBhGE+nBgCFKI6edteOFlANnlvDD0m1LyDmJyCAdwfR4T9Mfsf4AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/J1XShNxq+GR8v6JNVU+6xpDj4AWjHa9ivxaRtv0h9E=;
 b=Z8AHqwGKHDDIjXtp7q/OzU3f+8HzUeJTgk83n3NJF95R0g3WkySgTTYlkIZQWrC0uD1VNdnhkDXbNm11c13E3k4WsrO2vDDxuMSJnz098SzTXSdNXJ4H9yvvHQ2bRKwTUXaSYEu97fJcazCLB8a5tpULMHAFQc9l/wfqydPsvL6xxxyavqkGGCNMrtCTuclaSxuTxhctKXu1qQCl/cYpK8APUc0V0ynoIPp2MKNniYM4ref8BX4eh70YFakiWbn0I6G3yH8E6+YfsQxflniBlWxpqOaU6UZqYqbFPoNYtZKWjK+pvfy7Xh4BqSIQnAAB8AxMFykPEZO17drxWx9Tsg==
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB4PR08MB8152.eurprd08.prod.outlook.com
 (2603:10a6:10:380::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 14:10:40 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 14:10:40 +0000
Message-ID: <129f5833-3a7f-4b2d-a965-20903e4e2fb5@virtuozzo.com>
Date: Tue, 16 Jun 2026 17:10:38 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] vhost/vsock: add VHOST_RESET_OWNER ioctl
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com,
 stefanha@redhat.com, maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
 <20260612165718.433546-3-andrey.drobyshev@virtuozzo.com>
 <ajFRRmA9req1muX6@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <ajFRRmA9req1muX6@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0083.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::16) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB4PR08MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: 8274d277-2807-4f4f-40d3-08decbb10bd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|22082099003|18002099003|5023799004|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	LVc8Fr3iMRD6PtzxBJges5OLHtzqlNIxPvAzvVV8gHOxeBBZo/inZX5dbGOckzW4qUSeWDb+4BEFHnUZH64ijD8jbOCvPxSUdDG8u74o6SQCV0O6XGyntA8j+2MyH33BbAJSqJ20mjhNq9Y2wJ48+0ntXvJWbgwgT6BaMchFLPzTg7cl8To46OP5O2gDol2wfY6Dc+4sEdBwYs/6bIprKNmxU9A3WLFFfHG2D1I6SX2HCixXLyfoVjt/QJuO0v+wutx2GCVwMyfiltY1yd5d575MrEWsPQugZPygKYDMqYOiG3QaFr/WiEK6mVMu2t8V3emZZ78vkrP8cgEEdm+CCogKjhTjpsZ6N7xt4SQH+oPKf57XxFVyFWBv/hydIrtJiOfto2GR5dTA3gaL8iT66qo4QaJZQp/SrnY5S8IAN4a1kXZfd0/sazICUWzINcFtaV4uucLtGp3qo0UBYkFXqM7hXZtuQayOBLFcpGc95VDZUTgvsmxW7MT+qBd5SQYtg99LskwHfb6dL4AJC2p0gkxyg6WuNlsPrQ/JQSd+TPiwG3wBHPQTKTJcnbBRJsi26HWm1zciMoYiNTShKojijcaKzPZlDjrcv5VohiEXg5Ed8KbVjxPC1HpqXpnQJHD0agkTz27wUNd1UUNuCXRuzw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(5023799004)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVorSTU0RUtRaXhkcVFMTXpGVkVGK29wdUUzN3MvU3NWa2xjcm9SNE84RWRu?=
 =?utf-8?B?NGNGZFZrdzRlZUgzUjZJM2thZXFreXdiRE5GbHg3WmJuSHVEeG1vbjhqN1pu?=
 =?utf-8?B?MElaZERZbEtqNWpnbm51RjVvQjZuVTRvRGxNSUlIRXFCQVp3azZZM1Y5OU1E?=
 =?utf-8?B?VTJ5WUJsWTVaMWE1WmtDenNWa3FEYXM1YXVPSHJRSVZvR3hoV0dvZEpqTWx1?=
 =?utf-8?B?UzNvYXdYOWRsMVNWN0V5TkdTM082cXprazlXaE1BZXFIQlVPRHIrWWZxeDgw?=
 =?utf-8?B?UFpQVHpmVWNSTlc5Vm8vTWdNMlBDRmo3VUQweUF4VVlhcDU3SFRFazJkNzJW?=
 =?utf-8?B?Mzl3eGxFclZnbnlEUHAxbjNpbitIMkt4QTVjN1h2RjhqTC9ERm9rcnhDU1h6?=
 =?utf-8?B?OHVhdWYxSDVTcUZkNHFmZUlpdEpnKy93QTRQL2l0elU2U1lkZGdGbC9NUHVH?=
 =?utf-8?B?dEtiT0U3eHdRZWVENDJrakFsSzVFYVUzaVJIK05BUjl5YXRad3pIVi8wMHpH?=
 =?utf-8?B?STVWbURNTU44S0IwYzFoWW9RbDdKQWJRN2c0SU1mL3FqaEFrNkhaSklZZ2c0?=
 =?utf-8?B?cGJNblZNUlovaURuRjVOSUJ5Y21Hc3V5VmhJU01lbGh5VjUwL0U4NklXZHYz?=
 =?utf-8?B?TnMyTVR2SFplY0prQzZNOUFHYjVWbjk0K3dsWjJUVDRqRVd5YWxMdjR6Z3Nw?=
 =?utf-8?B?WGsvTStFZVJpdXdhT0FqSnJkTXBsYjJnOGtRWWZxQ3RTSW42cE1QdjRqbGhN?=
 =?utf-8?B?QS9FUmRKcW9nUThBOGhXdGhsWTAwMnhndEd3NFEvb0xYdXloYnVkeHZyVTc4?=
 =?utf-8?B?dllEUjJpZHNtZytQVzdwSHI1OFBoSDJ4ODVlRnVBRFgxa1dhWU9TQjlNR3hO?=
 =?utf-8?B?VWNOSitpN25tRU03V29MWVBPaG9lUTBhd2oyTTIxNFBEQytNcm9lWkMzUFg3?=
 =?utf-8?B?T2JZRnVMVjRJSEp2bTBwbTR4S0hhUTVGZHYvdmNpN3ZRc3NhQzJmTFhwTlB0?=
 =?utf-8?B?bHM3YkNBR3B1UXhIR2VDYTFVRXNwdW1sSXkzRU1vYStsWldwMG5lZEpBdFBJ?=
 =?utf-8?B?Wlo4bWpaZVFYNkhQcUVOTzAvNnZRTm51ellsNTNyY042SEpHcmg0QTZicDYy?=
 =?utf-8?B?eVBid0tTWStiOXNCWFB5aVdtbHRZK0MyNmNhcmpNTlR4OW9zT0RvZUN2WTNE?=
 =?utf-8?B?d3FGOWZlMzBwUkF4UnYwMzkzS0F5UThyMktTbEViZVM0ZGdaU1BkQ0gvVnhl?=
 =?utf-8?B?QVJibElSRnlQVzd4d0srZEFlQ3JVc3FqN3Y2UFAzWU8xQWM2OUdpeHk5Sllo?=
 =?utf-8?B?YVdXTkVIZGRrTmFZMitOalVvTk0rdUNEWDFsbVdnUndsdGIrTHdMNzFPNzM3?=
 =?utf-8?B?Z25VMkhmYVh4YlNHYXhxMjFGZDJ1ZHg1WkZLeEpPOXF1WCtTRUNzRTM2S01E?=
 =?utf-8?B?QWU1WExENWgzMFNBYS9wcGVlQlRhMnFNeGJtZWpXOHhGQW5aTGtEdkU3ZVdS?=
 =?utf-8?B?VU5Oa1ZTdEdsSm96cWpKa0hYUHFXU1ZzRU8rRUlLeFU1bldwanRGQjRSemtx?=
 =?utf-8?B?enY4N2dSbnNKcnR3QUQrUTZrbXVJcEZ3bUxnL1BwT3BEWkVyTk1FZlRhNmov?=
 =?utf-8?B?VU9BYUlQV0daT2s4eDc3cXdtMG5BYUdZS2QweDBWY2hIRy8rNXF2YVlnQjE3?=
 =?utf-8?B?YWlnTzFzK3U0Rnp6YWFwb2NKR3RER0I3b04zR0tkMklMWUhoS0R1L3lVTzhB?=
 =?utf-8?B?UGNDblJHc3dxdTdocjlXQURIdUhhY2dkVDdQdWFoZ2dlSTBNaE1NNDhHdTFL?=
 =?utf-8?B?VVhXZWJ0WUVOVkFuSk02YllrTEg2QXREU1dpUllZaWVNbG9seTRHeEZlcXdo?=
 =?utf-8?B?Z2hySGVkY1pmZjB2Q0J1akMrZGZMUUUraTFQc0ZZc2pxTHdCemFSVURlWUln?=
 =?utf-8?B?MGtGd0gxTTZRQklsZlk2THhYN2JrY04yWHIrSVA4Q0oxOS9LdFl2N1hkUDVm?=
 =?utf-8?B?bGlGMVFCWnlqMXg3eFBNMTFsWCt5NTZlNzV2R1Q1QzgzenJ3ME55NHVBUW4r?=
 =?utf-8?B?V1AvZGNaZG1aZVFHbVpqbDY3dkdISEJUTlVLdTBwSGlzWEw1Mzh0WHU2Ykg5?=
 =?utf-8?B?THh0K3hJdnBEM1R6cy9mUlRZcUcyQmpxaXQ1K08vcFZvdmhkZE80MnRsZ2RC?=
 =?utf-8?B?RU5zd090a0QrZSt6RkZ6MEN0UzFhYVBIYk9NeDZkZzcyNWNseXBTWFpHdEVs?=
 =?utf-8?B?aGtleGdXdFhNbmx6cGFKVnN2djl6TXJGbGc3bzRUNDJFc0xBM0VLa2xBT3Jp?=
 =?utf-8?B?YUlwaFJBdE53V1Qrai9iOUdFSnFWb3dONGV4cllCZ0dXUnJNMUtZV3FtcDlj?=
 =?utf-8?Q?rifIr47SeYdR8o8g=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8274d277-2807-4f4f-40d3-08decbb10bd0
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 14:10:40.2944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRkvJeoAUy8pMYE1GiaAENssv26y5uCxcH0ODslqwgBjaf67IpyQWUqE9DNUjn5xZUUBp6Dvjb0r9wUfx5lmMzezZUopZVMS1wnbxfSVYfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8152
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299864-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sgarzare@redhat.com,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:mst@redhat.com,m:stefanha@redhat.com,m:maciej.szmigiero@oracle.com,m:bchaney@akamai.com,m:mark.kanda@oracle.com,m:ptikhomirov@virtuozzo.com,m:den@openvz.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8672F690665

On 6/16/26 4:48 PM, Stefano Garzarella wrote:
> On Fri, Jun 12, 2026 at 07:57:16PM +0300, Andrey Drobyshev wrote:
>> From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>>
>> This ioctl is needed for QEMU's CPR (checkpoint-restore) migration of
>> the guest with vhost-vsock device.  For this to work, we need to reset
>> the device ownership on the source side by calling RESET_OWNER, and then
>> claim it on the dest side by calling SET_OWNER.  We expect not to lose any
>> AF_VSOCK connection while this happens.
>>
>> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>> ---
>> drivers/vhost/vsock.c | 28 ++++++++++++++++++++++++++++
>> 1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> index b12221ce6faf..e629886e5cf8 100644
>> --- a/drivers/vhost/vsock.c
>> +++ b/drivers/vhost/vsock.c
>> @@ -894,6 +894,32 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
>> 	return -EFAULT;
>> }
>>
>> +static int vhost_vsock_reset_owner(struct vhost_vsock *vsock)
>> +{
>> +	struct vhost_iotlb *umem;
>> +	long err;
>> +
>> +	mutex_lock(&vsock->dev.mutex);
>> +	err = vhost_dev_check_owner(&vsock->dev);
>> +	if (err)
>> +		goto done;
>> +	umem = vhost_dev_reset_owner_prepare();
>> +	if (!umem) {
>> +		err = -ENOMEM;
>> +		goto done;
>> +	}
>> +	/* Follows vhost_vsock_dev_release closely except for guest_cid drop */
>> +	vsock_for_each_connected_socket(&vhost_transport.transport,
>> +					vhost_vsock_reset_orphans);
> 
> In vhost_vsock_reset_orphans() we have:
> 
> 	rcu_read_lock();
> 
> 	/* If the peer is still valid, no need to reset connection */
> 	if (vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk))) {
> 		rcu_read_unlock();
> 		return;
> 	}
> 
> IIUC we are not removing the guest cid from the hash table, so this 
> check will be always true, and nothing is done.
> 
> So, is this call really useful?
>

You're right, and it's most probably an artifact from mimicking the
vhost_vsock_dev_release() implementation, as mentioned in the comment.
In our case this whole iteration is a no-op, we better remove it.

BTW earlier I received some feedback from Sashiko AI reviewer, which
also spotted that same issue (and some more interesting races):

https://sashiko.dev/#/patchset/20260612165718.433546-1-andrey.drobyshev@virtuozzo.com

Apparently it only CC's its reviews to kvm@vger.kernel.org so you can't
see them right away.  Just wanted to let you know to save your time
here.  I'll send a v2 with respect to Sashiko remarks.  But of course
would be great if you spot some more issues here.


>> +	vhost_vsock_drop_backends(vsock);
>> +	vhost_vsock_flush(vsock);
>> +	vhost_dev_stop(&vsock->dev);
>> +	vhost_dev_reset_owner(&vsock->dev, umem);
>> +done:
>> +	mutex_unlock(&vsock->dev.mutex);
>> +	return err;
>> +}
>> +
>> static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
>> 				  unsigned long arg)
>> {
>> @@ -937,6 +963,8 @@ static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
>> 			return -EOPNOTSUPP;
>> 		vhost_set_backend_features(&vsock->dev, features);
>> 		return 0;
>> +	case VHOST_RESET_OWNER:
>> +		return vhost_vsock_reset_owner(vsock);
>> 	default:
>> 		mutex_lock(&vsock->dev.mutex);
>> 		r = vhost_dev_ioctl(&vsock->dev, ioctl, argp);
>> -- 
>> 2.47.1
>>
> 


