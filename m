Return-Path: <netdev+bounces-259714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJMAGMZhmGkVHgMAu9opvQ
	(envelope-from <netdev+bounces-259714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 14:29:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB66167D0F
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 14:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F0FB3047BE2
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 13:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7657D346AF1;
	Fri, 20 Feb 2026 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="nIctPtnq"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012024.outbound.protection.outlook.com [40.107.209.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B069346ADC;
	Fri, 20 Feb 2026 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771594142; cv=fail; b=nXzcKYUiHwYfEsqfYH1EKQJe/8S6UifLjkIkOk0rkc4Xb7D65DZv8IRuAEx01E0u6obQ/btl9q4Nvrs6OgyoZOiU+qyp2j8bndUH1TQ3rDqu2msrXo6XgHCAhvNsyIk5d3adez7ogDqxQIktMQWtFUe6jBMM0zYKMpg6IYDySEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771594142; c=relaxed/simple;
	bh=DIxWt63TzrUXOVx3f4TV58WDC76lHWcpNcRSeXJ6YLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G54BAWSNngt8koeuGeR345xJfF7THWhF8lp98xLk/2AhsPvd/Cy1JhA//SnjhBTSdPfpNJh7WvKMzTLmfHmgmzy2rW9rX5k7Z13x0cuWy+y70T7dkh13oT7VJzwUeTxND/7LskFQgjrao4Tw+edTuhTNEYy8MqlovFusGwdUxFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=nIctPtnq; arc=fail smtp.client-ip=40.107.209.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tl9zTmCPfNiPw3UWmaysFsPdcMTxLXfHy4Z++n6sUUU+ubDHQXSoPbOJgTzlAfCtGF71JfNogWeHf+ghOpznNWdBWZJtmyM2+v2JSFtn6+EdUzfvTba+g3xKJfBDKkWotRJFFdJndNXF4aLI/MNnKkCqjCaR186W8SxKw8KZZjnZXg/9BxW7VbSZsvFok7CPYKVwVNtv5l8vwOV6s58fIeW7i9WW1nkOwcAapqTF8cl9O3hzNtGASjXDJnZJ4ijD5b/IryvlG9HNHjcFqKHGy97Tet4TDOA6bdCRX+tqXHH7SVqdSXJM6y745eYZ+ceuNr/y/9PxOI7mqUWvk0J8xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/TX6eZngLJ9OhUAsEbLNgtKS6Dh5pjPL9gUrvZleBo=;
 b=J4U+5wgS3sdf+fsW1EqPUKPQl3NfU0fFtBYLJpVRuZ5pX5a97X38TaTHm9PXEf0CaYfLlII69G38SCmeq26FGWtCymnP0KJM9hkUruZdUKjm/K3nn0gCH1arMizej55Lc82AtIKUgRySYX0KWAby46NT6geP8ZuYHJRcE6pYxUXr0H3TP6+svfHBA0wl0t5OTtYvc9WB2smgRQ4AS11KmIKMnFjQGUhpmhGdWXR9LJShOwPTxYGmvsjRb9EhDb7UImqmICrp74N3lSt9XUXzlihgEG2DqsvJVRSmejWN3frObkb02oT7D7J+0siKMeUW9lNLeFYVcdT+4t9q7eW4rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/TX6eZngLJ9OhUAsEbLNgtKS6Dh5pjPL9gUrvZleBo=;
 b=nIctPtnqTOyZo3uJTFXKf6GtTT/NF4fzZ2FJFl+2bYHZ9u8EP5EUOTXkRe8Ih+X093+d+73RDTb1f+HH+UJlmRS13iN3nvEhfb1+KJTv0OiMoqFRYN/XONMP5IMwNKBEwZylaRG1B6YS9kOLJfxqhSMx8cpz9R6XBJtpeyYfKr0+QuDTQuafveqrM/7xf3WY4W9BjKp2QUhSFeFppvb09iktMskUtjtBQWzQ1g/Oj0wiEyMJKoyirsEQr9fBZzHsSwuop8uySss2579RJcmUmtmd8/n1ksBYpAnFpvagM7tuzzrtCJDXpmJoouJDaaWJuJpol0GKwcNr6tNN0iaKpw==
Received: from SJ0PR13CA0187.namprd13.prod.outlook.com (2603:10b6:a03:2c3::12)
 by LV3PR22MB4766.namprd22.prod.outlook.com (2603:10b6:408:1d8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 13:28:58 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::73) by SJ0PR13CA0187.outlook.office365.com
 (2603:10b6:a03:2c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Fri,
 20 Feb 2026 13:28:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay1.compute.ge-healthcare.net;
Received: from atlrelay1.compute.ge-healthcare.net (165.85.157.49) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 13:28:56 +0000
Received: from zeus (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id D75CF1A2CC;
	Fri, 20 Feb 2026 15:28:54 +0200 (EET)
Date: Fri, 20 Feb 2026 15:28:54 +0200
From: Ian Ray <ian.ray@gehealthcare.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfc: nxp-nci: allow GPIOs to sleep
Message-ID: <aZhhljVG907fI6jC@zeus>
References: <20260220115906.102470-1-ian.ray@gehealthcare.com>
 <d991e47a-0275-4f8d-afef-0e26fbd2bfdc@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d991e47a-0275-4f8d-afef-0e26fbd2bfdc@lunn.ch>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|LV3PR22MB4766:EE_
X-MS-Office365-Filtering-Correlation-Id: e1bbc5fa-29cb-4480-716b-08de7084000c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDhYdlBVR3d2UzdQT1orZHRJWm0xMFNYclVUNzNMTXo1ZEFuN0VzMjhEOWtr?=
 =?utf-8?B?bEJEenZwS3NoYlBqaTFYLytLM21HY2dJWnRJNnM3SkdGQkNGKzdkVlprejU0?=
 =?utf-8?B?eTVRYi9KdjBVd1VuQjhFS2lkQ1pMK1UrRnZCY2VkMUlWNStXVSsrc3lNQnFS?=
 =?utf-8?B?aHNsNmpVaE0wSmpPWWYwNXRWaGVpRjBFRVVBbUcvL2IyclF6MDc2TVN0aXNG?=
 =?utf-8?B?NFEyY1llTEJwaVFPQW1RdXRqbUpaSy9KZWhDUStHZzNkNFZsdzM5NEY2ZVAv?=
 =?utf-8?B?cG5YNjNlYTNFYVZHY1BZTTBzcEt6aFpDNExOaVZZOFVWVnprZXhObEFyOE9F?=
 =?utf-8?B?N0Jlekl1eldkN3lNRUNoaFY3R2M1U0dYalQ0ZTl6WGNrb05SWU5NMGlZUFNh?=
 =?utf-8?B?WjVpK2lNRkUxaGRQKzFJZzdVS2U0TW5WUHU4ZVJXQ3g2VXExZy9NNHF4NWlm?=
 =?utf-8?B?aktyd2VjSXpBQlhNSUt5MC95R3ovU3hUMVRjRHVyS0dZRXptMjNvSDBRZHF6?=
 =?utf-8?B?S2UwVXoxc1gzMkRFaUZDZDE1UVBpaGUxMXM1ZVBNWmhoUUJid0hNU0l1YllT?=
 =?utf-8?B?NkRDenIraThWQno0bjU3bHYyQ1hIdFpmWXBKNnhVUloxR09odVVuL1lxcHVM?=
 =?utf-8?B?SEdRVlB2bXc1ZDY1aHJrdEFQb1Uxa0M3ekE0cHBEN0VKVEpWbzRlcUJQL1NV?=
 =?utf-8?B?dncza05qNHdxSTh0Ni9vSzF1dW1jc21lV0FEVWVLZXgyenlrenIyUHUzWWdJ?=
 =?utf-8?B?cU4yOFNOV2xTMWdjaXpUd3RaRlB1WmtPYzRLTVBCaXk5OXZvNU9iS3VvS2VP?=
 =?utf-8?B?L1hrMUlxQXFHUm0vSGZER2JUK1k3SE85aEp6K1Rtd244d1d1SWZCTkYyWXU0?=
 =?utf-8?B?R0M2QlloWHVJNmcwa1hUMVdnWTcwS2VnUHc5c3Z4djlwTFNwaGt1VUlqZ0ZE?=
 =?utf-8?B?WG9vOE1oVWczYUVwdTdSQ2RXVHlkMHE3aU40NS9QVlpUR1hkSzhYajQzMStL?=
 =?utf-8?B?YkVpSzhoeHVvbGs0NDVtNFdvd2lhTjJxYW8rM1ZwMEpTUlZKeDJuS0VmUURL?=
 =?utf-8?B?WUhDNDBGdWUvSjZRcWRZbTNpMGlucG5wK0VPQ0h4U3p3ZktxNVNMRFdteXVk?=
 =?utf-8?B?MXFFM3lsRVdHRGxuU1Q2MHFKb3QwYjA5aytURm1sa2NjU2FBZVREcWJYNHJX?=
 =?utf-8?B?Q1lRNisyU1RRNS85RndBUEhxTTdCbE5GQXlVYlNsY2ZLVVBjRzM1c2xYLy94?=
 =?utf-8?B?SXp1cFJIRStDNGZIWHl3ME12ZVZHbXk1Y05VOTZDUFlocHRla2c2bWFRam5T?=
 =?utf-8?B?a3hYYkpNWHhZVWNLU0hqZTcvd2hRUUhRdzN5aTI3VVhNaFRQdEo3cEdhRlFL?=
 =?utf-8?B?c3RUZ0lJWGZ1RUlzZ3VQaGl1VjNMWU5tdDdiOXdGOFVaRngwWFI5ZGc0S0hj?=
 =?utf-8?B?ajBydmxLMW9mVElmQXJCVXp4Y3FSUU9USU0yWThQZy9SMmwzdFNscFpKRURB?=
 =?utf-8?B?YXNyUFFiN1BFVjl0K1kvRmVLaFZlYStubkROK3NlMTNnQlA4R0U4VmFoR0ts?=
 =?utf-8?B?VkNkaUdDV2pOeTBuZEhBT29vQVlndUROckNmS3NHVXg4OVQzRjBMV2ZHNTFM?=
 =?utf-8?B?Uk5SZWhWSUNTQ3NaVDYzOHI5Qkk1SzlkTHRtc05xYUhDdmhJQ29nQzExdFFR?=
 =?utf-8?B?V24xYlRnUS84S1BtYTE1ZWJieHRlbDh1Z21tMUtUNnhiV0JJTlJnd0hOWjZD?=
 =?utf-8?B?WVVDYUVjR0J0cHJ0ZlczRFBrMmR2aEtwcHVvT0l4NlF1eDlsbzZxOGtIWkg0?=
 =?utf-8?B?Ris4LzZzWkcwbVQxRnZqcllSZEJEbXQ0UW5sOTJjNld4YzAxWkUvTC9Yb0pq?=
 =?utf-8?B?ZTJXeFlGR2c3dmZEQ1ZUZGVOQTg2RHJjVFM2OUlEeUZLZERMNjVkdEx2anM4?=
 =?utf-8?B?MFdpSGJsQWoxR0NKQUpwKzlBMUF6aktsSDE4dXQ4VWVYSTJuUTB4cXlBbGI5?=
 =?utf-8?B?QUN0SExkSjkvUGJwM1d1dy9SN3lZMmUzTHBNMkFCaEUyQTRPZ01sNWZmN0tW?=
 =?utf-8?B?Y3pubnVoUEMxT2VOdU83TUp1WWZtZlJPdFV4TElQalhLTWVyV0tMR2wxc2hi?=
 =?utf-8?B?L1QxTTdiejRDUVVLTGlPYWVFS1IyVEl2bEtlYmZhZFQ2dXNDYWdGWGsvSkdF?=
 =?utf-8?B?VlZKeVNvcTBRZ3FqT3lMb2d2a0FGLzQyZFZtZXZxRVUyQ2wxSmswc1JkYXN0?=
 =?utf-8?B?ZElVMllnK0hYZXdYaGV0dVoyK21RPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:atlrelay1.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9RE/VmMPK0DPjVcYIw/BrRNWds4kinmA1fk9nMlTQdx2ehZMjCckfbAoZeKaMWbIS5xa+DO4FRylnXs5hMgdC/1DXPjXY05eOIIEawJ+M/lHRNhiapBCZv6ZsFySNSIZQqo2xbZkNB92oyvTT85rNUFgKOHzbnNoNyf2154+1xHMyI96ooYrhzWWQyBHXlg2GIeJ1KA2PpEWBFWMprQRUG/ZV6wk/EHQ0DKIZN0sigBt0/xlVUmmNfkUEazJFmb7JLmVmLiaHClIcf9RztIdvgdJ033XcUBgvS7ZAErJfaZKKpt1skwDKRZKPDnmrKA8hRvfFcm0W0WID569yJqEg7n4BmOmZ1vIQuT5hqNk2BYVK7Pn8ua5Q5Z0EMC7PIyNBPouOOvHhc8pjuSu2pqaYof1il3bB9ixtuvGjI+ZkJRNbFEeB96JTzuDQ5dDs0FP
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 13:28:56.8975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1bbc5fa-29cb-4480-716b-08de7084000c
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[atlrelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR22MB4766
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[gehealthcare.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gehealthcare.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259714-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gehealthcare.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ian.ray@gehealthcare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gehealthcare.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EEB66167D0F
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 02:19:34PM +0100, Andrew Lunn wrote:
> CAUTION: This email originated from outside of GE HealthCare. Only open links or attachments if you trust the sender. Report suspicious emails using Outlook’s “Report” button.
> 
> On Fri, Feb 20, 2026 at 01:59:05PM +0200, Ian Ray wrote:
> > Allow the firmware and enable GPIOs to sleep.
> >
> > This fixes a `WARN_ON' and allows the driver to operate GPIOs which are
> > connected to I2C GPIO expanders.
> >
> > -- >8 --
> > kernel: WARNING: CPU: 3 PID: 2636 at drivers/gpio/gpiolib.c:3880 gpiod_set_value+0x88/0x98
> > -- >8 --
> 
> Are there in tree boards which have this problem? Should this be part
> of stable?

I could not find any (I am working on a board which I have not submitted
upstream as yet).

> 
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> 
> Did you use ./scripts/get_maintainer.pl to get the To: and Cc: list?
> It is very unusual to see an empty To:.
> 

I did.  This driver is marked as an orphan.

>         Andrew

Regards,
Ian

