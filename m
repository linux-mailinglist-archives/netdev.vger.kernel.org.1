Return-Path: <netdev+bounces-292251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGtBCNvGFmpVrwcAu9opvQ
	(envelope-from <netdev+bounces-292251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:26:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCD35E2AB1
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C27C73087773
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DF13EDE62;
	Wed, 27 May 2026 10:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="g/IYIFIM"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023140.outbound.protection.outlook.com [40.107.159.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7DB37AA7F;
	Wed, 27 May 2026 10:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779877329; cv=fail; b=akAlXjUvyMos0jxO9h2cw7TNqGy0ljLOq29Su8mt/jZHZ8wj/AVbpeUloiUJgB3Qz7DS7tY5QAq6OEpxq3ZwYwoHDSOsfY1my1JLL54D99gdSXO+FeO6ceIc/GSJm+NfDX8UAiomkyPalPqbNS5H29OWWB4VqHI7lmZ4838BnFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779877329; c=relaxed/simple;
	bh=HGHlZCgVxPsHduuohrQwmuwD3YxW3xO06R6dIvygIj0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PpSEK/4j7oXbNhr1IsP7dMXWgoAAdilC0dPyx3oOQJWo9MQ9aEhEMdCvSrrAP5z+ixpGipW83BjC7+JosYFiSp1oMdxTupdrBWab4orzu4b7ANhKiB8PuvojfE8Xno1MYzQfApHTZcS9fT3snZMBaBvnyaDJ2RTgQNGatYStS1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=g/IYIFIM; arc=fail smtp.client-ip=40.107.159.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQnwRq7y/Hx+67qZcgrtYZZS+O1/YlXAeVUKX3WDjcHmseG7KLlYtzsO+mm1XWh02IjvhNEAB+ySz2pZFW+2RmY2SOwHuu/9wokhpX4u+/HMN9yMy9LE1D6nDyJpVFAS2sFhmQNYgIItd5DItgyq2RWp/hRFEssLPgR8RcGe3YWRg20VdZHOoGv7cVN+Y+b0rY4OqudSCasSChbgOETZD+KwWZvIO1QII70wX903oj9nJNso2CegQYdrR7+6l4kI/3tiaH70GwTwuYC4yDepwclmZMT4pv+7T9y2l2FyVKyXnPMXbZraABl2Ig7O55YKaotHoKe9daSC7Hdy1s6rVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PS43qXwJoM33CZPi1OsHc6s+xRDL8sYrsx1wLitIIPg=;
 b=IGiYaOss5Q58QV1qP+g8W1Ingx9dCr63eVaWP39lnw/iJ3nCY/cvUIOdI1dFpfg59WApGnE03wJn6YcnBc8QbpU2TbzjOyTxYrnAJJBILDqSlwG/m6O80O/fcPEjFKEVza3oBK5FmnJxcsF0bCO4qanLJ0id5aNboXyAvZI2Cv1xXcipxFmFhTAh5Vn4hVvPReHMY1FZKmaKC140q+PBe3EZ6zU1UTFKQ9+VOMJGb4NHYPnE1pdAvdPKDfJcCsH0sdqGjzvrFSnWDYLa30rm4tmudamxvrnDOFXhbZmjIsH4XvmX4yE9YO/UCo4QbLpmeEKaSEuFnCKba/agbS0y2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PS43qXwJoM33CZPi1OsHc6s+xRDL8sYrsx1wLitIIPg=;
 b=g/IYIFIMyWjXV1hggVtksZUj+3NH63258ozGTYhl9xbKR0NACKH5cF4+lozEQg87dNKN691pKnaQlxDA3SmH8PTXvVqIpaSBTzsQjuP6r9nGYCxSEWBQdk8rhz1BEP3jOeMwb1czBsimWdEmHFL8Ydn/+V8CAJrXudFSE8Z+EQHgJkQ44jWxVxI2mA1yapurNaieuryJFz+bK6qpQGppQnky3c71KQZ+xb3gwrwC9Vz2Uo2kasSkvKvqLLm6dGKIC+FjM0bLslaq3POu46LIoKo9tu6vxLHvPwuVv8uy0VPHvEjg5r3bp1RHe2A4PwxiZZW0i6+aQQZ1YzD5CrCt/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by PA2PR06MB9200.eurprd06.prod.outlook.com (2603:10a6:102:406::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 10:22:00 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69%7]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 10:22:00 +0000
Message-ID: <38fc139e-3858-4037-b2de-700d7b092ce7@vaisala.com>
Date: Wed, 27 May 2026 13:21:58 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: fec: fix pinctrl default state restore order on
 resume
To: Wei Fang <wei.fang@nxp.com>
Cc: "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20260527-b4-fec-resume-pinctrl-order-v2-1-293096f48703@vaisala.com>
 <DBBPR04MB75001DF6E52F4316085D551388082@DBBPR04MB7500.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <DBBPR04MB75001DF6E52F4316085D551388082@DBBPR04MB7500.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: GV2PEPF0002398A.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::37c) To AS5PR06MB9040.eurprd06.prod.outlook.com
 (2603:10a6:20b:676::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR06MB9040:EE_|PA2PR06MB9200:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0c2812-4e38-49bb-af18-08debbd9ca21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|22082099003|18002099003|11063799006|56012099006|4143699003|4133799003;
X-Microsoft-Antispam-Message-Info:
	CPuF/6NFO+2EG/JKzh+N+jEJn4KV1Ga2MgbGM9otx16wBrPxVO6/nUtyRQ1iw0tURn6EYuC5ENI83E8vgJ5vVNiIm3mSbPSLQZNiBTsWdYls2fv5gULYhKTc2QVujz9HAIVjeTd/7+zAq5jgqGtJw64d/wcoHlrsz7BCGdwGeWzRsQo1eHavijl/hRdc2jgAYxp001D9ZiLLxhYebY0Yx3T/SnRmiMWFuezfGcWyWbeILibSEaiRv5L0pM/04YVptCX8QQ+P40Qpz7P8AMwG7eN5sZfQ1Rd+EYSIxjlrS8xFCF4rytf62k7aj/Q0PA8GTH9VQ1Gf8yUCRqW4OQ7lBmBm6kItSMc04XFDdcR09nH+A5YCLHtoyatvqQLzOKVZqLeu2NRGckZuSLD6zEp73qdrFX68Dz4uaDb3jVxbUdxGIO+qAfBcJpY2jlIZV66FaDyIpgtEYXDncInQlkOpco8sXUxVz7LgQkKFDor7BpwaNJ5C5X3hr3rvvV0Nzf/uhrSfA8wX1wcs7XeEyy9l0b/jdNLXmfNsGnR5nja6HNafUcZtKL4SEgu80EE/jsHGOy3FNGEymfCqfSv4u/WNx/5JpmBTzSlH+JgOkrTPPm68tsuOY7AkjvRfR0EPGezdwXSr4geLdW5M0LIJmhydbw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(4133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1JHbzZHMTRNWmtOb2tvNmVOVk9WaSs4M2VvSUM5WkpycGF0RW9zUzZERUtI?=
 =?utf-8?B?dUplcDRiQUdwME9CM21wV1pQTjhraVRzNWpWazYrT2V4emNnVzh4UDI3c1gr?=
 =?utf-8?B?cTlBcnJocUtjSFV0OWNMRStvdnlGRm9SOVdDOG02Y1ZDYVNNMVZkTThLZVlE?=
 =?utf-8?B?SmNDamQrMUxVWmlVUEd6aS9iZE44QTlVTDlFekc4UEx3NkUyWUxDZVBrSVY5?=
 =?utf-8?B?TVJaczQ3MzMwQncwaE1kWUJDb0Yvak9CbVk4bzN0Q3gvSGZvZDFXdnZyNHRX?=
 =?utf-8?B?a2VDSHBpUWdvajdNQXBVekZSeFgxeTdIRlA4RE90dzhaQnJZS3BOYkJrc1lw?=
 =?utf-8?B?aTNmTFdWaU8rMWlVZ3dzYXVyajJXd1NseWY2UXJMWGtjWHVWQ3IxTENtbTk1?=
 =?utf-8?B?MGY5NmFqWkd4VWk2cmpSN1JTd3FhdzJWcG56dGk4S0N5OEhyRC9BaHBoMFJO?=
 =?utf-8?B?RFc0dHRGWGRLSzdwUEJmQ1VnM1ZRTE13WVp6K2YrQklkZGVxM2ZWNlA2RkFi?=
 =?utf-8?B?ZVAvOXNWTjl4Ny9HSG1MTlVoM0M4R2RtYkZXRFJId1JFblNybEhlRXBTMXZz?=
 =?utf-8?B?RWpVcTRNM210eUxiODR5bnVTOVV2TklCVDQ1U0szMzRuMDQ2N1pqNGFzaG45?=
 =?utf-8?B?VkFTR2RWbTl4Rjg0VGlXc2ZiQTZEYzRYS200QU9uYndTejB4Wm1GUFNrSWFM?=
 =?utf-8?B?dXQ5U0I2MmJzcmljbU5Tb1VTdkYzRXh6d3dvV0lxMStVV0U2elVtem5Tdk0y?=
 =?utf-8?B?Zng1aGRmOFNPODhlTXk2a2xWSzhlQkF5azJwQWZwSUFoREJmQTlTQjd6d1ZC?=
 =?utf-8?B?bHQwYStOc0xDNUxRWTd4R2tHbnpKZTYyWHNPUTc4a1lmenF0TUdTbkNUWDVD?=
 =?utf-8?B?UTFwMEZUamRVR0NVVDRzV29QN0tsWHpadWVIdTY5VmVaVnV3S3E2QnVqQXZB?=
 =?utf-8?B?aVEzeDZqNzczdVRJTVlIbnloSmZNZ0d3WjZwdDU3cG92WXJYa0JwcURiS0JN?=
 =?utf-8?B?U3dzVmxLcGx6eFAwK3hkQ09uUXN2dW1odkptRnFxY2NhTnBnR01oV1V2czVU?=
 =?utf-8?B?QitwVlQvL2VHYjl1T2UxUGMwYkR2NWhLRXJiK2tpTjV0cnZxYkwwcjhwSjFM?=
 =?utf-8?B?NWVvQXY4UWZ4QlpNQjl4bWpHNHhBckpBVER3cGhrdzBuQUVmdjZvR3JFdm9y?=
 =?utf-8?B?eTZkZXdYTURUSXdJck5BZ3RHdUxXOHIvYVRyZWRrSnNKUTFxek5vL1BaYk1q?=
 =?utf-8?B?MlNlQ1doSHI0MHVhQmppWUxKdUl1dlJqQ1RaUzlXTWFPMk55VWt2VWxwcW9s?=
 =?utf-8?B?cTJMOUhJWDIzZHBGWDdjVWE5dFZnSHNVaDBUNVZaL2R0N3RxbU1rTUVneHND?=
 =?utf-8?B?ZjBlSGlkcGlIZmJVSlg4ZDh5eDlhZjJsYVBJeFQwb2tIYWxoSVBOdmJidFM0?=
 =?utf-8?B?b1FlWkxnN1dUbTdhRXlEck1vN0xBK3M2MUIzK21UMzF3S0tVdldxWkF4czVC?=
 =?utf-8?B?M0lOREJjTVo0WFRJMTFQeGZPSTRVNWlhK1c1UHNndkZsU3kvam5jOFpsU0E5?=
 =?utf-8?B?ZmtucjhvTkszbHAveHVodHY3TXh3VlJCRnJjcEU2aHZxSzNPRkpJbVBvaDJz?=
 =?utf-8?B?SGhFbzZLTFlmdmtPWkpJTys1MEwxN1RCb1NlTVpqYlVEWkdmOGFYQVBxNXVw?=
 =?utf-8?B?VGRGK1ptUDM5TVdlbiszSXNsVndJWEhlN1QwbUNkUldFMk5sbVVuQVlpWWxy?=
 =?utf-8?B?VFlkVHduZ1dVYnduWEhacW5yNWxDck1FWlYvL3ByVm5wUEZNSlR1WEs4dGpu?=
 =?utf-8?B?RlRmcXFJME1Bbm1OOGVPYVpyNzBTYlUySGtXWGRnU2JsQVh5ZHRPY0Q1NUlD?=
 =?utf-8?B?RGx5Tk0wY2dWelpEdjQ2MDRBczVBRUgycE5WRGNQZmlKS1pjM3lpc2pRbHVV?=
 =?utf-8?B?aitwZmNoamhQRmJPdXZMcnhhM0RoMXY5TVpla2JZOTJzbDZIRlRvT3NsT3dw?=
 =?utf-8?B?NWhGYmwzTWs2azFaQ2s4cnhhTTVUUmVjVEUrdjFTQXJ2WmJpM2VjN0NJcWVG?=
 =?utf-8?B?N2IzOXlWcUpOWmttWndCeVhsM0N1ZGNOU2NQWXRSZTNpQ29obHpPKzRXMlNF?=
 =?utf-8?B?K0E1NklNRU5oUHcxYzN5Z0t4Ymw4cXBGeklPQkdTaU50Z1YxYlpJbXBJY3Qr?=
 =?utf-8?B?VThvNDRxc2FFK3M2VlJBL0U3a0RRdExRK1hVMU9naCtwWVRzcHo5ZjhOalFo?=
 =?utf-8?B?d3BldVdsVWNoTjBXK0J2Zng4bHBmSmhmVHlNWXFaNnZMRXBKU3dwbUsxZTJI?=
 =?utf-8?B?WlI0WDk0MWtQVlQzYmhoSndqbWhaK2svYWRPOWV0UjZuUkUxdDdyWXJkblly?=
 =?utf-8?Q?UJDktIWtL+wJRc38=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0c2812-4e38-49bb-af18-08debbd9ca21
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 10:22:00.7527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7ZiLIzXt1g4W49xQJTVgYuKrwDYMMzblLzx8ZA9zffpwCtASlceyII6r5dybjwnAIoUEtAfpNM2HFS8FVKnLHym0Os2tIFTa60rXRgzKM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR06MB9200
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[vaisala.com,reject];
	R_DKIM_ALLOW(-0.20)[vaisala.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292251-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[vaisala.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tapio.reijonen@vaisala.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vaisala.com:mid,vaisala.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8CCD35E2AB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 5/27/26 10:47, Wei Fang wrote:
> Please wait at least 24 hours before sending a revised version. Give reviewers
> enough time to provide feedback.
> See https://elixir.bootlin.com/linux/v7.1-rc5/source/Documentation/process/maintainer-netdev.rst#L15
> 
>> @@ -5594,12 +5594,12 @@ static int fec_resume(struct device *dev)
>>                  if (fep->rpm_active)
>>                          pm_runtime_force_resume(dev);
>>
>> -               ret = fec_enet_clk_enable(ndev, true);
>> -               if (ret) {
>> -                       rtnl_unlock();
>> -                       goto failed_clk;
>> -               }
>>                  if (fep->wol_flag & FEC_WOL_FLAG_ENABLE) {
>> +                       ret = fec_enet_clk_enable(ndev, true);
>> +                       if (ret) {
>> +                               rtnl_unlock();
>> +                               goto failed_clk;
>> +                       }
>>                          fec_enet_stop_mode(fep, false);
>>                          if (fep->wake_irq) {
>>                                  disable_irq_wake(fep->wake_irq);
>> @@ -5612,6 +5612,11 @@ static int fec_resume(struct device *dev)
>>                          fep->wol_flag &= ~FEC_WOL_FLAG_SLEEP_ON;
>>                  } else {
>>
>> pinctrl_pm_select_default_state(&fep->pdev->dev);
>> +                       ret = fec_enet_clk_enable(ndev, true);
>> +                       if (ret) {
>> +                               rtnl_unlock();
>> +                               goto failed_clk;
>> +                       }
>>                  }
> 
> I think fec_enet_clk_enable() can be moved before fec_restart(), and there is
> no need to call fec_enet_clk_enable() separately in the if...else... branches.
> 
> Or move pinctrl_pm_select_default_state() before fec_enet_clk_enable(),
> as shown below:
> 
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -5644,6 +5644,7 @@ static int fec_resume(struct device *dev)
>                  if (fep->rpm_active)
>                          pm_runtime_force_resume(dev);
> 
> +               pinctrl_pm_select_default_state(&fep->pdev->dev);
>                  ret = fec_enet_clk_enable(ndev, true);
>                  if (ret) {
>                          rtnl_unlock();
> 
>>                  fec_restart(ndev);
>>                  netif_tx_lock_bh(ndev);
> 
Agreed, the second form is cleaner -- it keeps the fix to a one-line 
move of pinctrl_pm_select_default_state() and drops the branch 
duplication I had in v2.


Calling it unconditionally is safe for the WoL path as well: 
fec_suspend() only selects the sleep pinctrl state on the non-WoL path 
and leaves the pins in the default state when WoL is enabled, so on a 
WoL resume the device is already in the default state and the call is a 
no-op.


I'll send v3 with this shape.


Many thanks for the review,
Tapio Reijonen


