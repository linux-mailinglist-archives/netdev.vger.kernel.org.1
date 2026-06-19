Return-Path: <netdev+bounces-300717-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ih46GURDNWoaqgYAu9opvQ
	(envelope-from <netdev+bounces-300717-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 15:25:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3BC6A60F4
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 15:25:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uclouvain.be header.s=selector1 header.b=c7tUFKGi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300717-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300717-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=uclouvain.be;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FB5C301E9B9
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 13:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767EB38237B;
	Fri, 19 Jun 2026 13:25:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022138.outbound.protection.outlook.com [52.101.66.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16E33955C1
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 13:25:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781875518; cv=fail; b=f28a+0WYicTHSDq1bUhAqKHpNPzrvfDuB1dl/xxIztHG/CXfxkMJoO7f2CYah3mpZ9ph08Cd7Qa/gUo806UVBBhcxD2R9dhNwg5YeFP1roAXp7dg1CGc49gA8NKJV9Gu7l20rJpeLacGjptfQnuKDZ4/aVs0vT67ewRq0gXvUvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781875518; c=relaxed/simple;
	bh=9q8U8hQ+EgfeC16WU6DkC6nDZNFMHhAvDkEZLAy7sCI=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=F+bm1Xj1dmeYIs9++j9m7f9tP5jy0n8TXuljsLEQWl0X6dSN9EH4lKn15duMlbQohMg9IPdwLd2fGMm0PIz1UmLtXSNuWUVy5Ao2DLP2TkvCnnuYoCldAN7d9lxT1JuOOrQQCO9R5daO0RzbO/xwxt1plrY4eAOsaxtxz2BTWBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=c7tUFKGi; arc=fail smtp.client-ip=52.101.66.138
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XcTpXhMuNWcPoa2Y2m+x+Ekc4cS5a1C5FQGsJeyd/k+oEbdQsgDxCzxB6HmjEik5yP/zjuUIS3AafvZBDf18SHmETdbk+etSv5ObVyJVYRSRClqjobxChwsCHUKFa/Z9oHYPZArWWTZ+sB+41VHIAv5/jmFF61Oe0N86QO+BrQsjjs3b3NKetslkcK6Xngf2v8DVcwGGL7oUU/b72pLBbpJhQ5Mz/tcteImLcJ3vuNIei9+q7+1feO31FPODp2aEJBnXgnhDFiMbCZ4ADI35Edqz1pMYo3cadROd08YtA1kpOqi52l84U9wQ3lXfWHy5S7M1ykyCiICjF12Ld6g4cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSGSCen+MR/SEWjM/JY0GUeZOYqMID6cR1mQpk/NSk8=;
 b=Y6gqUMyXWEIgPhGamGrnpd4UtRdoYDt2Ui0TsGKn9iu2L1sD4vVRU2WxITboeSwOMY99p/DM1wEYB9Pe2EvB487ONrUsTGo9obxIktTbXsx+Ms9I04oojvQ7LmUXi3i9QVMzUXEwSFCM0RpPwJgrgCyfCZQqHaHnXy2BrpMZs+xsBSs7RS8t1WM7UTwdVGfeI2EyyHrh6PBwYReTrWzo+AVZ3yXZt0eRlaOARO3lkWVPMrhhBdKuhw+Pa2CH1heiFNVeBsPliMLNoz+BbhukvpDSWqRZeTOHPbdNVJmxIDXq1RC9b4s2YARm3zNMNj3+uhZFSG82q1jZf4NmoH0Zrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSGSCen+MR/SEWjM/JY0GUeZOYqMID6cR1mQpk/NSk8=;
 b=c7tUFKGi7hcfZ6MsZUEl37Ygy9yW2DwwizV33x76BBa17LT+5fTGizchLBsbWSrhPYpSAkl7It0c/7/y3G6EsBCmsSLxVRR19gb3p41AzPPqBG8ao22NMs4JoyFrOsnosiuCujFIkpNitEnNXGjmn1pT9v1buGcHgBt5/Uex/V5ETo1RIpEz+7n4V6I47HZHjFFCNcNEtDnbELCaIqvD2xOhji8IGWxE05BFUf613c+d1+S+L0WreHQw3Xew4knWkhbzf/bcYoXtIblLVqA7vsM4Yc0IRY0iTYQREO4YTqP6hVWVsONVLXDvu6mu/ApDDRMUP4EQGZsWn2oi+Qh5GQ==
Received: from DU7PR03MB10969.eurprd03.prod.outlook.com (2603:10a6:10:5b2::20)
 by DB9PR03MB7242.eurprd03.prod.outlook.com (2603:10a6:10:22b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Fri, 19 Jun
 2026 13:25:10 +0000
Received: from DU7PR03MB10969.eurprd03.prod.outlook.com
 ([fe80::75fe:525a:1f14:22cc]) by DU7PR03MB10969.eurprd03.prod.outlook.com
 ([fe80::75fe:525a:1f14:22cc%7]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 13:25:10 +0000
Message-ID: <3fe17ca9-25fa-4fb1-ba06-4463e0409a8b@uclouvain.be>
Date: Fri, 19 Jun 2026 15:25:09 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: andrea.mayer@uniroma2.it
Cc: netdev@vger.kernel.org
From: Anthony Doeraene <anthony.doeraene@uclouvain.be>
Subject: [Bug ?] Packet with End.X segment not correctly forwarded to nexthop
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR05CA0024.eurprd05.prod.outlook.com
 (2603:10a6:20b:311::29) To DU7PR03MB10969.eurprd03.prod.outlook.com
 (2603:10a6:10:5b2::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU7PR03MB10969:EE_|DB9PR03MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: eb306512-5e3c-4346-378c-08dece062fc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|786006|366016|1800799024|376014|56012099006|6133799003|11063799006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	lUpBIYBf8ysIXdwCqQay0n0FhS+lccFaW89MQecxwjN+FyV36f7km5PQUZ7PMsEE/TajWuoFVz52B8JAme1s9xwJBhhRI3ZjYo+nverIQrq4Km8iBVzvSdZt9oipqqgAT6I+TeR/7jEZOl/dsRBy8xT860oG3zx1hq74BF+0VpZfOTKXpu/cHpTXsG9Ee1rdLVQcbWp+EqV5TfL/6qaXt+q/DpGW7c76bmpJS1kZlyMy+KaKrbr7t9NJkHCOhcPQUM2gMyWwavl++V2WdcLB1zQSsy2Z2xy+4FqU05En8RIw2JeP8ihckoeBqWbLrSJ6elzR7BMG+yUQr82YJ87cgLO7gHYg+pfUv7pSliTsacVbq8fC0Mm2LGAyftWvzpIYD+0s3wGlk0xboZ80Hl4qaTzv7/czBu9YW8Z+7rtrMRW7pfDoIm2oLvhhV6M8A+2fwUIGgDmrhqW2U+UDxrwS3IxsI3NPt9p9As+Gr3tGxbji9uZ50rEfSlvzDZDtLOt6rkQjb63o52M2LE0ez7ya+5i4eIX+vEfeO4Y4mmJihf3H0f85GuQluFS1VrvliSj02SxlDi5nD/zRRJiZghmEr5hqH4pT/Ifiqhf9ezu9RFQzsmqdrLdpMybzM30NVQ/Z9jMeDOW7yLq8vDdExBe4614QLwQJ7fly/JG3lL37tRw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PR03MB10969.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(786006)(366016)(1800799024)(376014)(56012099006)(6133799003)(11063799006)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGxuSmNsZ096RU5KQnpyRVZtRHpZVEpwTjlJSzhWTldGZnVEVXdObzhCZ2xF?=
 =?utf-8?B?dGR5YmZVb21PWDk4TXFkeUpGUjkyRTl3U3NOUU5GSG5yNTdZRGpuaHRKSXV3?=
 =?utf-8?B?LzhOVHJ3NEJVUkFEMDc0cG5ZV05QbEdMMllxZExnT3c2OFVPYWs4VUc3eE9R?=
 =?utf-8?B?aFNTa3VsQTV5eUVWaURqZWQrTkl4TmVMSUd5Slp2N3E1clphZHYwVTQwVm84?=
 =?utf-8?B?TlJVV1RlRkVKV3ZSbDR5WHRSK2pDQzJrNWNIbEpoL09zOU5rakhkeDRNOXVz?=
 =?utf-8?B?U2ROeUVQeTJpcnduSC9JSHM4cDJyUzBhNEl4WU5CekVJR1J0WGgrcUE5NlNq?=
 =?utf-8?B?L2hTdkxxd0NRL3RBSldmZHo5NThBUGp0eFltc3JNUnUrc25LOUMwSTFLU0hv?=
 =?utf-8?B?TVZKQVdocVhWaEV5K20rN1JXV243RTR6WG5NSzRCK3VDV1FHQ3RxSnNtRUJw?=
 =?utf-8?B?Q2ZmeFlCT0diaWJJNGMrWnNGamJ4bmhvVWhPQXJMcmkxbDlVd1BVRWZkOTI1?=
 =?utf-8?B?UVlZU3VvZ3dEZ2NWd0UzZXRsU3VKSnZYZ0JpUW95V1BuUVNGRHN4L1ZMTWVU?=
 =?utf-8?B?cUpTb2t1L0hiTCtvUFdvMmJwMnNsS0pFcCtBK1lCcWJpZG5aQVJMRDRZT1FC?=
 =?utf-8?B?TDY2OXA2TG5DRkwrOCs5Z1MxTjUyemZCanpiRHZIdWFzNTFJYnVaTmpZQTZU?=
 =?utf-8?B?N2ZkUFk1enhUdTVQQWRmazl4MHZNb2JkQ3RpbXkxdVdGUXY0UVllN0Y2eFZL?=
 =?utf-8?B?UjRBWDBSOEJ3NVZLeTlQQVplVmZiMkF3ZWY2aWUwd28xcTVVRGRmL0hGNVBi?=
 =?utf-8?B?c084cC9YM1ZyMVhiZWxjVVF5UW52Vi9vSkhlRmpJQWdCVVIyUk9vOHNEOWJ6?=
 =?utf-8?B?Z1c4MHRmT0IxUS9tV25aYVBzRUxlSW5YeWVLUmQxTE9pYlVHbEZsVUxTbEVK?=
 =?utf-8?B?Z0hPeXRMelpPRjIraU9pWjBiakxDVFBQZEdnTGxOeUhFSDdubVU3UHl1OUw1?=
 =?utf-8?B?RzBrNEkrdm0yOXd4QmxIVkcrK3ZLamZHUUpUdUorTmpwZloyRzhWU2xFZWxQ?=
 =?utf-8?B?Qi90aHhkUGZOeU5JcVVQZWI5cWdjV3RGVjNoZktDUlpzSUoxRUgyOWMwdmZM?=
 =?utf-8?B?c013VUtEVzJKM09HWWViTFZBVGhnbUhLbjZ5Z2NJNTZSOGllVC80MXQrd0x2?=
 =?utf-8?B?VENVSmtZQTNTdGFZRDUwa0lUR1hxdmplaXA3d2Y0Q3VNWlF6cU43bzBTd0g0?=
 =?utf-8?B?MFRUMWtxcjA3ZjV5MUZiTFVzTEpEbFNWZGhGbEpUSS8rZmNyd0ZjT1hUclE2?=
 =?utf-8?B?ZzIzaGk4MjJmQXBmVk1JRGNacGQvSVpINkpqZkVxdjkvSm1iektMcytLaWk4?=
 =?utf-8?B?TUFXWWRZUE1JMEx3SU9BWTFwU1FEdStNdlpyUGYxZ3l2U1Jvd2g2ZEZNU245?=
 =?utf-8?B?bkw5RTNRQjZLQWt3cnRDMjQvZk91TUxyM1YvOTVMeUhBYngzMDdiVWJwaGtD?=
 =?utf-8?B?RHpQVHIyN3MrUkNOT0xlN1lZOVRxVVZCR3Z6TTQxWHN2S2xVdW5YbEtXZ0RY?=
 =?utf-8?B?MXYzK3BSN2V4RjJwRGl5VUhCOWg5d2FpMlpIa2xpQlY1elRmdlpmbkd6UnlS?=
 =?utf-8?B?OXl3VTgrQTVnMzMvdm5hUFZjT3piMW02N2dqTmlraXNYS3VYZmZDN2lNUTNO?=
 =?utf-8?B?KzE2SHNKTVNUbk0ra1hheEg2L3hpSzl5Ynora1BndW9qWEdOZ3hrbGpXM2V0?=
 =?utf-8?B?UmFoRldTZS8yeVZjYlp2QlBlb3JIZnVzN3h3QmhCTmFkRFhsLzZvTFd6UW94?=
 =?utf-8?B?MmRiQ3VZNUhOUC9hKzZSODRvUmpVTmF4RVFRR0YyWGh3UTlleEJNQVVhOTdn?=
 =?utf-8?B?ckczc1ZqSVQrVTdydkJEYnZDVUg4aTcwd3ZnMkJjOW5nVnY0Z0VXclVJMU5x?=
 =?utf-8?B?SlZ6TGVwSGg2MXFva2xCN0dIR2Q2OHk4c0doRC9nbkFHM2k0ekZkeldNSHFJ?=
 =?utf-8?B?MGV2aFhlRzV1YXhob25UM3FaTTJETXpsemRNbExBMEhFeFJRUTZ3VU1nSFZn?=
 =?utf-8?B?YWRocG1ZeTRqcTJOa0JhMmxSanhDK3VuL3JodTFKSHQwYWFGcndiM1dlQkFy?=
 =?utf-8?B?YmxqenZ6UThwMTZUb2hhOU5xcjN4RGk1cW1pZkh0N2tQczdLY2xrdVQrQVNk?=
 =?utf-8?B?eHhnSno2SUU3M09YNHBadXIvZHhlbVpLS1dDdjAybVpXbGRxcFZoK1hibXZV?=
 =?utf-8?B?c1c2ck11QnhlQTBNOURGemE4T2xoSGJneWIwbUwrNXJESUFVOXJaYTRsVUN3?=
 =?utf-8?B?Tzd5RVZCRkoxckRST2UzeXA5SlF3dnY5NDJJcS93bTFkalNScFB4U1hCQUE0?=
 =?utf-8?Q?kQSai2KGayWG+B72FtSn6ytR8/DsCMV+idJjhlIyRRXDq?=
X-MS-Exchange-AntiSpam-MessageData-1: gJm3WRAHwUqwJ6+jTHsBV0s68nKrltqubYE=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: eb306512-5e3c-4346-378c-08dece062fc3
X-MS-Exchange-CrossTenant-AuthSource: DU7PR03MB10969.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:25:10.2094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxa34+S1QRI+ZXfsfmFwRNg1dWYFCjYlKRPCehLsqx2ZGe+qKhgJnWPd2jk8yoWpOW7Lalgg4FZoYzx61537jGA1xFlS8Qgi85LDBfGgfG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7242
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[uclouvain.be,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[uclouvain.be:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[uclouvain.be:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrea.mayer@uniroma2.it,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300717-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[anthony.doeraene@uclouvain.be,netdev@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.doeraene@uclouvain.be,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB3BC6A60F4

Hello,

I am currently experimenting with SRv6 and VRFs, and I found some weird 
interactions between the two.

For the context, I need routers to have multiple VRFs, with each VRF 
having different routes to reach destinations.
Our routers not only send packets to a specific nexthop, but also 
specify the VRF that the nexthop
should use to forward these packets.
To achieve this goal, routes in these VRFs push two segments: a local 
End.X segment, and a End.DT46 segment.
Due to some implementation constraints, I want to have a single End.DT46 
segment shared by
all routers in the network.

Once packets are encapsulated by the VRF, the packet is sent in the main 
table to do a lookup for the nexthop.
As the End.DT46 segment is shared between routers and can not be used to 
learn the nexthop, I decided to
use an End.X segment to specify it.

However, what I observe in this scenario is that End.X segment 
processing function is never called, resulting
in the packet not being sent to the correct nexthop.

I am wondering if this is an expected behavior (i.e. a node should never 
push a local segment), or if it is a real bug ?

I am not well versed into the implementation details of SRv6 in the 
kernel, but I'm suspecting that this "bug" comes
from the fact that seg6_output_core calls dst_output, which does not 
allow an SRv6 segment function to be called.

A minimal example is given below, which creates two namespaces (r1, r2)  
and allows to reproduce this behavior.
(tested on a kernel compiled on virtme-ng from commit 
e771677c937da5808f7b6c1f0e4a97ec1a84f8a8)

Thank you in advance for the help and thanks for the SRv6 support on Linux,
Doeraene Anthony

File setup.sh
```
# Topology under test:
#
#                    fc00::1:1       fc00::1:2
# fc00::1 [ r1 ] ------------------------- [ r2 ] fc00::2
#
# Description:
# ============
#
# Each node has an additional VRF, which it can use to provide different
# routing decisions based on arbitrary rules (e.g. QoS aware forwarding)
# Routes in this VRF will encapsulate the packets and push segments to
# specify the nexthop (End.X) and the VRF the nexthop should use
# (End.DT46). The same End.DT46 segment is shared by all nodes
#
# Problem:
# ========
#
# Once segments are pushed, the End.X segment is never applied. As a
# result, the segment is not popped from the SL, and the packet is sent
# on an incorrect interface.
#
# Forwarding steps:
# =================
#
# - R1 sends the packet to fc00::2 in its VRF `myvrf`
# - This VRF encapsulates the packet and add two segments:
#   1) End.X segment to force the transmission of the packet on r1-r2
#   2) End.DT46 segment allowing r2 to know which VRF it should use
#      to forward the packet.
# - After encapsulation, r1 does a lookup in its main table for the
#   End.X segment, but does not pop the segment. The packet is thus
#   sent incorrectly on the dummy interface
#
# Running the example (with sudo):
# ====================
#
# 1) Start the topology
#
# bash setup.sh
#
# 2) Start pinging (leave in the background)
#
# ip netns exec r1 ping -I fc00::1 fc00::2
#
# 3) Check with tcpdump. We should see packets on r1-r2, and should not
#    see any packet on dum0
#
# ip netns exec r1 tcpdump -i dum0 -n
# ip netns exec r1 tcpdump -i r1-r2 -n


if [ -z "$(lsmod | grep vrf)" ]; then
     echo "Run modprobe vrf"
     exit 1
fi

nodes="r1 r2"
vrftable=10
localsid=90

# Create nodes
for node in $nodes; do
     ip netns add $node
     ip -n $node link set lo up
done

# Create loopback addresses
ip -n r1 addr add fc00::1 dev lo
ip -n r2 addr add fc00::2 dev lo

# Create links
ip link add r1-r2 type veth peer name r2-r1

ip link set r1-r2 netns r1
ip link set r2-r1 netns r2

ip -n r1 link set r1-r2 up
ip -n r2 link set r2-r1 up

# Configure IPs
ip -n r1 addr add dev r1-r2 fc00::1:1/112
ip -n r2 addr add dev r2-r1 fc00::1:2/112

# Add default routes
ip -n r1 -6 route add default via fc00::1:2
ip -n r2 -6 route add default via fc00::1:1


# Configure sysctls
for node in $nodes; do
     ip netns exec $node sysctl -w net.ipv6.conf.all.forwarding=1
     ip netns exec $node sysctl -w net.ipv6.conf.all.seg6_enabled=1
     ip netns exec $node sysctl -w net.vrf.strict_mode=1

     for itf in $(ip netns exec $node ls /sys/class/net); do
         ip netns exec $node sysctl net.ipv6.conf.$itf.seg6_enabled=1
     done
done

for node in $nodes; do
     # Create a dummy interface for End.X segments
     ip -n $node link add dum0 type dummy
     ip -n $node link set dum0 up

     # Create VRF
     ip -n $node link add myvrf type vrf table $vrftable
     ip -n $node link set dev myvrf up
done

# Create SID table route
ip -n r1 -6 rule add to fc00:1::/32 lookup $localsid prio 998
ip -n r1 -6 rule add to fc00:ffff::/32 lookup $localsid prio 999
ip -n r2 -6 rule add to fc00:2::/32 lookup $localsid prio 998
ip -n r2 -6 rule add to fc00:ffff::/32 lookup $localsid prio 999

# Create the DT46 segment associated with the VRF
ip -n r1 route add table $localsid fc00:ffff:: \
     encap seg6local \
     action End.DT46 vrftable $vrftable dev myvrf
ip -n r2 route add table $localsid fc00:ffff:: \
     encap seg6local \
     action End.DT46 vrftable $vrftable dev myvrf

# Create the End.X segment
ip -n r1 route add table $localsid fc00:1:2:: \
     encap seg6local action End.X nh6 fc00::1:2 oif r1-r2 dev dum0
ip -n r2 route add table $localsid fc00:2:1:: \
     encap seg6local action End.X nh6 fc00::1:1 oif r2-r1 dev dum0

# Setup routes (main table)
ip -n r1 route add fc00::2 dev myvrf

# Setup routes (VRF). R1 push an End.X into End.DT46 segment
ip -n r1 route add fc00::2 encap seg6 \
     mode encap \
     segs fc00:1:2::,fc00:ffff:: \
     dev r1-r2 via fc00::1:2 \
     table 10
```


