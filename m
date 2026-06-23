Return-Path: <netdev+bounces-301284-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0ruvJlktOmqu3QcAu9opvQ
	(envelope-from <netdev+bounces-301284-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 08:53:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E94BD6B4A69
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 08:53:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=OQAh560x;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301284-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301284-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65E41300D87A
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 06:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C759A3A960F;
	Tue, 23 Jun 2026 06:52:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010031.outbound.protection.outlook.com [52.101.46.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD3C31578E;
	Tue, 23 Jun 2026 06:52:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782197557; cv=fail; b=ZxAIk/1UaJVzvjLJz9hXnRIgjL/aA27t4UTHwNQF5QS6PTIinT7S6p9z+4IKE1MEcLNmDNfFSJaZiHSaNnpq/9yKDFewn+N1eXZcmvbZRN+G4phMn/M/W83xYggXCGVVLvd4BqjJYGl201ETQemKrgRyNQOz8/PGKwDbQKY9IRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782197557; c=relaxed/simple;
	bh=rZMuZdn5/6jdonO1LJqOMzH90MQgezsaeCiavB/LDpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hdCD9AJDH9tzvtaIf6/w+uGlRhz0QCp7w29pxNAsyLGIAeJt7jtFU9yCWvJZKQvSc1uXDRhSBCgbmeerhCx7uwikWFhRUdJKnnjtwi8AFlsFFRcl69FvYwkhJnHmVa1ZS9zOP4cVXG+58fLlVYjdaMrJF9jrGB17lSJa0Pl3osY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OQAh560x; arc=fail smtp.client-ip=52.101.46.31
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHLY0udK/0pzR57FkO+PLv4Ff3nDDul3lK+bmkSEl3d41BKhTR49cIc/hGgIMSQN4nG03pQk26iL6olmwPDwIlOCQ5pS7/8mbHSM/zFYIH+7CDecWiTmzkEd+0AObJAdjKO2Q5b1NjLmJrPbsoI8G/+aL3U5KsyaUVSTqM8YbzmFl2iKxpb8wDJt59wdLC+EafubBLeaxhz02FmeApmn92xrhFSCMGgCAOAQLIJ7SovxoIkI91MKGHNjMHRo3lBNAe/5jZJRrx3pk3Ur97qZCECQxo2EEzvdIA2KWghaIt7qMz8CagzP5RrHe/LBUnQ1KwfuR8W172uwGWWSghC9ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yjPo7x2C9zptQ4k1DEnCljgr5KoodxhBl6xLAAZMsY=;
 b=sdojGkpyDUfLIlWEZl3S+5G9NtDLu03N5GuaTjO0+pAuFRWxVKNYGQTTeHoXlZczlfCFtDzbzU9UARYPXA1DFZYZZydcyKFxEPcdEiGk/UJiGIGPJ/xBjejMbk4WjvzJ3xIM9+TfXaolnfABCQ9oyst6ynPGlchUBHNAkaGBoPAYvQRNw+DZov/1xfNQcI2zwhsZe4VraTIDSY3sSvcUyUFQDFrViSNFb1AQv6u2UKit6DAzk3/raJrx4nQQJnQwgx/KF32ppcGZ0QbxPcUxTeXFIm5Z9r927+tjDdMqzvmrCzltx7Pn7pPRnfVoXk3dyXYQuyQwgKgrV3u4QB5/gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yjPo7x2C9zptQ4k1DEnCljgr5KoodxhBl6xLAAZMsY=;
 b=OQAh560xbgmaTLDEDWEGjufH/eLf2Iu+YPxFuUSN1i09bKko/VdvBFo/MoeYXILQODmoko/ZEc3eN6wDDAjiw+7uRY9g7RtK7yTZOEKxr2wU5vLL2eu1pRgoUTZ1wOecOeUBIeHmG6HsOgpkLLHf0IjR4q9PQ21aaFSKPrKA/b5gg6c8+2MQuiGB/VUE6fDBYMxt6SMBctozSkZbyQe53ChZNMn72QXhZh/7fe6RWDvg4CG+K7VjDGTdsjSg23SkjyfxX31uK7pLVOejoSRYF4pVW+Fn9iYnhzws6pMY3gfy+l1SALvk22GmuidVIhIsj4OXX4f9TqKr4VMi7ty9jg==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 06:52:28 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 06:52:28 +0000
Date: Tue, 23 Jun 2026 09:52:18 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>, Jussi Maki <joamaki@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Weiming Shi <bestswngs@gmail.com>,
	Ido Schimmel <idosch@idosch.org>, David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH net] net, bpf: check master for NULL in
 xdp_master_redirect()
Message-ID: <20260623065218.GA378121@shredder>
References: <20260620201531.180123-1-xmei5@asu.edu>
 <7791b9cc-86f4-424b-aa1a-d1a869814130@linux.dev>
 <CAPpSM+TRJaqSSUs6tBp_CBSVUJMiDZm01o5BK6aCNak8vuQi+w@mail.gmail.com>
 <20260622155854.75977aac@kernel.org>
 <CAPpSM+Q4O704OaUAXqKpL6ffvudTfqzzLzLExziUExgvxQWmxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPpSM+Q4O704OaUAXqKpL6ffvudTfqzzLzLExziUExgvxQWmxw@mail.gmail.com>
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BL1PR12MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: efd975a3-d3f1-4602-bc22-08ded0f3fd8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|376014|1800799024|56012099006|18002099003|22082099003|4143699003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	8BWGQIZP/9M3FDIW6eSzCpB0V+u9MRa9oWhQOKxIfi6htGeaJTYnrGAGVg8ZqdDjMGlIJxzzYzPZqhsxQxj5Jsr1mzTeb7uoRk2jxDo1iksDRFxDP1xko1kiv+cD4dIroB04ToMAC4VPUQ/mw2Os01CtcLEcJHg8p4BPEYsxdwax3bnjYlq2slS03tnNCFTHYSQeWqWTaBCgUSK9efeQgT/SjynUD2UVNRT6DT5Osf7fCKyAzpxh4f4D0RN+meoOk87HcOuqeAmTzpIKS5iXeJfq7jHeR3oPPEXbAzaHDVf1Rx9joYI2LqfEUl7nwxUQ9X1ifIchJIP+GM6mnzpu5MAOvfuei392CLk4CznohEtLv/KB5gs/6wHewGZnkg6uByHcxT1k9lYM/bmhihXIWbZEMepYZRvBQLArAlcx/Zdxz7B+DNdVg43PtUy/EDt0G/it05U2cBCmiKesvlz/NkNOu9cKAZ2CNoJR3oXWEECQuWpZQQUZ3hp1/p3bmQeNU8XSEpByGDZwsGEcrBbBOpQI8T92vtlEsPYQ0qk213feepM2m7T04WcrqoUmvD65xZiVap7prHgez6XN8DWhe7UaNYyxLJo3JZndRSgH4llG6jvIWR65KNLVecrgLWq0m4VUCGZrEfIrDc13bDs3LyyOvnaJt6pZ17KIzjaRbOA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUQ0NTZHaG1Gbk53SW9RVXY3bGhmNDIvRUtMQksxMytQQWJIeVZZRkZ5Q2JB?=
 =?utf-8?B?VHNLbzg5VjZrcmlZQkgzckJhQVE3TGluQzFpL2ZrbzhEQktDTDJYbElkWTBW?=
 =?utf-8?B?NTNYOVZJUUtieGhySEVLWUhJTWp3MEZiY1A1WWsvYXc5YTB3ZWFQWGpKYlBE?=
 =?utf-8?B?LzdheHZCclVvdzE2TzVZalVtMmhiQ1B3RXBvWEdwQU9RcTFiM2paSENFVm9C?=
 =?utf-8?B?KzNJS01JK0NaUXpaY05lSGdkVE9GQnduOGRvUXVpZ2NQMnB1ckNINnlxMnRY?=
 =?utf-8?B?cjRabTNIQmRweU9CVlN3MUpBQzB4V09nOFBjaXppNGNsa2xXWUx4bmRxczIx?=
 =?utf-8?B?K05Vdkhrd245bktnYXRCRjFDaEcvdkdXU1dhZFJDMkd3WmEya0JESXRYdmxv?=
 =?utf-8?B?NUhzNjdxbm1JQU05ODNJRXc3MXFsbzhwZk9PbEpYL0s0UG9OaHVGdG5pdkRr?=
 =?utf-8?B?OFREQWZjbCt1Q1gydWJzcVV0dmdSRHlBVnY4T01NRlpCWm9GdGNoSEg4VUhC?=
 =?utf-8?B?RTNYYlVYSUd1Si9TeFpCVmlpUEpqdnBOZ0VRaTdrOTIwS0huSnM4M3NGWUg2?=
 =?utf-8?B?djdwUC9oYk8xSEtJZWpLdDJMbkczN3BpL0VsbmNLVTc5VHp5N2lCalFITktT?=
 =?utf-8?B?eWk0N2FWNDBRb2JJNlBKQTROTWNvQUFRY2Y1U3dCekJ1MWdTM1E4TCsxOU1J?=
 =?utf-8?B?ZWpScWFQVXZZR3VXT1g3WjNLQkMzSVBtVkhtK2ZwRzk5M0ZiTlVocThoRHo4?=
 =?utf-8?B?NzhKaG5WS014b0lFV1F3ZGlSdWZtODZ0OFV1L2VjK0hDQ3M0R1Qza0QvQWlv?=
 =?utf-8?B?cWlCYzBLZlZLdHdNSEtuSjVya054SEd3RTAxdWpTVmRON2w2WXpwN005bHlW?=
 =?utf-8?B?Q2dMRm9Ca1pnbTU2Zm9LUTdDM0xyNjVOZFRPVmF4Z2QxOFBHUllKcFNFYURN?=
 =?utf-8?B?SE5Idjl6di9QbGRXM0F6RC9QeGc1TW4xbklCWktldmJyWHl1QlhxVUIxWXBt?=
 =?utf-8?B?bThjUmJ1OHk1VWljWnp4YkxvTXlwMkRBbXdVQnVMS0taYXRJL1dwNnNPeHFD?=
 =?utf-8?B?dUd3QmNicHhjRDBiQkdsS2dDUHFTTUJUK1JUZkcxU2pJWTRUYWVlbXJmMm40?=
 =?utf-8?B?bXRQL1AyNWcwdFZhN1JXWEhNZjMyNjk5cWgybnRSb0ZMT1k5ZjVVaEt1b0kw?=
 =?utf-8?B?WDd4c2UzVGVmVTRPT1dHWVBHTFVJd21hbUVocFFTTm1uVTlPTUJWUXA1OFhC?=
 =?utf-8?B?SGZmY1lzazBDb1JSTGRnYTdDcFF5TU9PKzIreldQVGFRR3NiVWNXQkZBdmFV?=
 =?utf-8?B?aUlteFVyTHowOVo5NHJoV2FwNFlKNmlMY0JETjNpNmFBdGg5NWJEZm1STmhH?=
 =?utf-8?B?OW93ajJqWEFjd0QwUSt6YWQva2JuU0V4MnRoamhZeG1yOElxVmZlQUpiYWdC?=
 =?utf-8?B?L2VIOWgrNFVGRnl4OXBJRWZtSXl4TmE2RjJ5NzNNY3FkcnpBT2VlMVlxRlk5?=
 =?utf-8?B?MWtNWjgrcldtdG12SFJhQ2hvTUQ1UEhwMmdkeXhMQ2tOdG5WNk90MTB0cWhR?=
 =?utf-8?B?bGFxNjZLOXo0bDh0RzU3dUorKzRKelJENUFIWVRYdlFMZkRoeHJZc09jalor?=
 =?utf-8?B?dWQ4ZGhobGtDZFk3cFlaZm5PbDBPemNpSWFqOWdYVUJmUGRkN2tyNjB2Zk5I?=
 =?utf-8?B?ZGYzL3VnYTNUTUVSS0dNY0UxbFB1cktoSjI2NlBUcEhiTG5tREZJNlovSnZ1?=
 =?utf-8?B?clNXMkJiTFkzOWxRQUU2cnp0NklvbitSOFoyUjB3dUNwamRCUEdIVnJtamZ3?=
 =?utf-8?B?YnBHVGJqTGc2YTNXNWtlU09POWExVElOTTVoR1pMRjRuMEVKMUNTV1VQTTY3?=
 =?utf-8?B?VUJzR0dIZHUxcjYxVHRKTXdMczJLUXhTd09VSWNZOEE4dWlzSks3S0dVdTlJ?=
 =?utf-8?B?SlhrTTAvaGlDTFlZdDdWSkJnb3FJUEJBK2dJam52YmRzbUlROEN3RVc1bEVK?=
 =?utf-8?B?T1REdWdCM2VIQklkd3F5QWRLaEVWVlVTMXVjRE1Sc2RVUFRORThOZWIzNjA5?=
 =?utf-8?B?L2dQSDlBaGJsKzFxa2xtQ05LSDBXcHVUZlNjYmdPeS9UZmo2L1NFS3UyREV3?=
 =?utf-8?B?K3VYSDBnM3pPeXNNRU9jSTV6ZnFUMTRtdkJtZzFVNXBZZ1hpWGlyMmUya1pO?=
 =?utf-8?B?T08zaHJzY0JNWG5XVHdvcUZlZHFncWM3ZWdkVEIvbFRHVTExYlBvdUJTdERW?=
 =?utf-8?B?T3RHdEFsMVZBa2w4TnA1S3R0Z1ZQVUwzdU8xNGFadmw2eGNrVlRNUmFpdjBR?=
 =?utf-8?Q?omvyUrDv9iesLIyzSr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd975a3-d3f1-4602-bc22-08ded0f3fd8d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 06:52:28.3948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBews7ymKlOtYjWFGT/8QGvbsceVHQYittzqE6VD8ZyJBhbPSEtAuihCerKEIY1J0ldI26JsKJhXdrgplcVCnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301284-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:kuba@kernel.org,m:jiayuan.chen@linux.dev,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:hawk@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:ast@kernel.org,m:joamaki@gmail.com,m:pabeni@redhat.com,m:bestswngs@gmail.com,m:idosch@idosch.org,m:dsahern@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,iogearbox.net,vger.kernel.org,gmail.com,fomichev.me,redhat.com,idosch.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:from_mime,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E94BD6B4A69

On Mon, Jun 22, 2026 at 04:34:06PM -0700, Xiang Mei wrote:
> On Mon, Jun 22, 2026 at 3:58 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > Can you double-confirm that this triggers on current HEAD
> > of linux/master ? I thought commit 2674d603a9e6 ("vrf: Fix a potential
> > NPD when removing a port from a VRF") was supposed to prevent all the
> > torn master fetches. Adding VRF folks to CC.
> 
> Yes.
> 
> We have triggered the crash on 56abdaebbf0da304b860bed1f2b5a85f5a6a16a0,
> which is the latest for net.git, and 2674d603a9e6 was applied. We can
> still trigger the crash:

2674d603a9e6 was only for VRF ports, so it doesn't help with this case
(bond port). Also, the problem that 2674d603a9e6 fixed is a bit
different. We had a NULL check after netdev_master_upper_dev_get_rcu(),
but the issue was that this master device was not necessarily a VRF
master.

Looking at __bond_release_one(), assuming that
netdev_master_upper_dev_get_rcu() returned a master device, I believe it
must be a bond because you have a synchronize_rcu() after
bond_upper_dev_unlink().

