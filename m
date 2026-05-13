Return-Path: <netdev+bounces-287689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDPkFZSyBGoQNQIAu9opvQ
	(envelope-from <netdev+bounces-287689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 19:19:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEB9537E8B
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 19:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CBB4430011BD
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFBD4DBD72;
	Wed, 13 May 2026 17:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="SIq9IEUp"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020076.outbound.protection.outlook.com [52.101.46.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AE13563DD;
	Wed, 13 May 2026 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778692098; cv=fail; b=FeI3iJDD9MaODxINDdAK6wU5uiUsoU12qBbr0yE2mLqsfKCeQ7MFQCQLXPxXV0J8wShBKIH0W+FGaJZH+nwSoU15mJY4HbeE6/Ir5QNLPmlXo2dWND8cYCFvydLQ8CBpW4vlneI2YpU5awPgZ8Dpamk8Z0wp/r/EXpU5cM21NgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778692098; c=relaxed/simple;
	bh=RAC2d2l2DwHZ764TOezZb2cJAKAGwwSzV59Tnz7HSh4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=klAN863YbcreZxTa9xSAWrNR8x+yli1VoBxJYOpE3xYMzXEZIKROweM7jMH89wLmz4Mx3cfbtvI4cqCcWX8j8DJzU9njFHiAfbkyoUwjiatLyqepD5pdUHnw5rFJdcGUs2y9SZ7JmsUzFdmRvyT4vLt4s+qmKUVf9svTrpL8O7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=SIq9IEUp reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.46.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXVRmL05HuTwEeCP4UglvydVkFpQAK+1uKqZ3sFNXmdBUOSw4JB/55WxKAIvkI4EKszzSIsclI2wPdRuSzYhFh15hTV9M5viQVxq646GR7uKQnUOqB5Du/VpkspJcHOpfF5T2rdrXtZ6+r0J3qW5KcFz0hVTBRAvdooLk+e8/C0OBzp7a9rF52Ee2AS1s1tsU7yYxftOW7S+T90yieD4PO54xP2Cue9sMHUEecnU/t1fAf2we8Fa4HM53ElWDybkhLlZJ6+/Jole/yM0PRKpt3dNWbyOL25QTqBwJlcgFUd5+DPoRJjbpW1nEc+/Z2yWSopvDzgFdAvTsNfJ62E4Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egqVXwQUXY/ZsQNYgkDV99NgLXuv4UPK+XZCnBhD2bA=;
 b=rzruIL4sJqGVRWkU0Ivt+DrcMxpqw1h9NuQETwYOHrZdjoBsn3+GSMLDkSNJ8niOPTCMy4I353hiTvRxoUHnizeRlCoa6eSaQZcrYA0/AHyIBrJDPlq7rfDcZA60Iy7OwgGJAN3eMwx3XCHUMDyIhyyBgPJNCmxEgdfj20rHMiVwHxqGx+9FDd/ws+NoVTHRsM2SKAvt/ffax9zPSgYuSCTvxG218rdhy2ZJzT/n1Q0gNw2XgYmWRF0BJDRoZDaf2KjAa+aGlSnm5NnPBo9V57azoYfN97zc9ZltEcmrxPZeRTAQgx3UgkSHvqAWmBl/OVdIlnC/kmvaSpHFTEDebQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egqVXwQUXY/ZsQNYgkDV99NgLXuv4UPK+XZCnBhD2bA=;
 b=SIq9IEUp+D69O4+TpBeUX3tT+qbLURFm0b27A+t+Y44NnqdfXNpkYb6M0I95SdPY5hygWCVVj4frcS/DDtuSqOeE/tcY0rwYdZ6qNc5JKfOVAc2jg7YFO1vh7FemiQErjH4fjm9/dMpK1ypb1+OLFRBuE4sIRRPO+uCk4+eHIaE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 PH0PR01MB6777.prod.exchangelabs.com (2603:10b6:510:93::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.18; Wed, 13 May 2026 17:08:04 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.21.0025.012; Wed, 13 May 2026
 17:08:04 +0000
Message-ID: <0ed53cec-6a01-48c3-9689-b815edccc184@amperemail.onmicrosoft.com>
Date: Wed, 13 May 2026 13:08:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v41] mctp pcc: Implement MCTP over PCC Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>,
 Adam Young <admiyo@os.amperecomputing.com>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20260510163228.443778-1-admiyo@os.amperecomputing.com>
 <9f4d364ebbbbbb697fcee022991a546e60692f11.camel@codeconstruct.com.au>
 <9519a497-c10c-4abc-bcf9-414467f74ba3@amperemail.onmicrosoft.com>
 <71b7c8f40efc25fadb0aede6be888986364f2d53.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <71b7c8f40efc25fadb0aede6be888986364f2d53.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0383.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::28) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|PH0PR01MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 86923aa1-7964-44b6-6214-08deb1123217
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|3023799003|4143699003|56012099003|18002099003|22082099003|11063799003|55112099003;
X-Microsoft-Antispam-Message-Info:
	s09464ulEsPSutWSzWRE375k1w7QFrdlRbBt9ocQXyf0jsHEJFvRrqDOgcK5dBd15s3kQQu/nUhWcklE81pJwv7TS7zagboLFpstvAXW33YlTYK0g/DUtOulgK4pTAcbD3MMoE4gGsPxA5hW4KMVBPYdjtFrZU5x2Is+3gOpE7xYdcqjDhIFejzjIAqFDm78YcHb659f8vidlZ3Vi9mZhaJTL/Jdi9RoT3+DtjfP57KEdbmY/T/Wc9YTSXbvl0XHWU3YsgdYQRPlifnsjtomair1GtkfgP3IRvpG94O484oCeXy+ikviWMmpUIPEt6blo2z87dvUrLF529Iu1WlguFg36J43dDDTw5fCRMwJjdlMYQEcJ7YScJhE+olmKLrn2Dmn3wdvflI3bae4VCComFLyDMxnKZuBIjFlKY98Tz/g1oEr2AF62wJBG80Tb3bqDRLcP6Wlpss2YoDmLjeegoEIYHHHhD2Hza1d0g/z6zPNmrzsNmwnlumBU2pu+yoADMcj+r95Q0y9igcjCW/06dOL1QVA8FmIzeg+Gx+ygFSKkfI6FTxIjnwPL9MpWPUUuJPzcOl0ioyikgDJZg5N9melNsEBdOUPnA3+4ud0DYH4Axzk8B6ikE5LzWPhUWYr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(3023799003)(4143699003)(56012099003)(18002099003)(22082099003)(11063799003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkZwM3N6T2FSOGxhRTVFMXZQWGpGaC8rQWhXeGU4cFo5YzdPTlVKTElKUEJt?=
 =?utf-8?B?elpMSmFPZjJiNnFKWjI4d3ZmWWltY2NIem5FcnRtVk1RZk9UdTFaVWk0RmJ5?=
 =?utf-8?B?RWgyNCtrNDlERjJjOHlSc3Q1Q3M3OWNBTFZBTUQ0N25TdEtPOVBpeGFuNFdj?=
 =?utf-8?B?Ti9tTmFxMWU4TFlVYi9yRFBzOExVMW1NeW1CQ0o2OW54OGIwK296QUF4K0Ft?=
 =?utf-8?B?NVRiSW1SS3J1WGtDYW9Edm1CRDhJZlZSelNyZVh6Rlp1dUJYejN5WFZMYzZM?=
 =?utf-8?B?aTQrbFhoQVkwNGRrTjN1cHNuQ3I2KzE2cUQvdG9VYVJxa0xjazE3K1BuaTBP?=
 =?utf-8?B?azlPT1dVeHhWRkJMZkVUYVlUbXA1WjRnTWsrcDk0TkFyd2Q3VUZDMXhFTGV6?=
 =?utf-8?B?VFB0MDAvd1NTZkRhejJsNFE5S0dhSlc2MVdSOW9mak1Yb3Y0bkwvdi9PYUFV?=
 =?utf-8?B?YkF3WlM1N1lxM0ZlRzJmYzlicXZJYnhnbklIamZVdzZTT2E4eTk5OXdwaDN5?=
 =?utf-8?B?NXJydXdoU05POVdLWEpRTUlhS0Rpb2FQT1NWRG4xSTZ3Z2dFbWh1RWU0d0dF?=
 =?utf-8?B?Z2IvOFkxMmEvVXdkNFd3MXdrck4vYXdBbGFQcGhSTnE4NTg0RXcyNE92dVlZ?=
 =?utf-8?B?OTc2SE82SjlzUWxHOG10NnI1aHJCaGhKZmNaNS90Y0srMTRlM0d0QlZXNEYv?=
 =?utf-8?B?ejllNkNpR1dRZzRMQlF0UlR0N2JPZ1AwMDgxOUNFNU8xREFzR1FwOGtaaUM5?=
 =?utf-8?B?dy9zb2cvMjNaL0p0bTJaa2pQVmZYYlkyS2FocERKaTBaeWRMSFpGWHJzUTd3?=
 =?utf-8?B?Q1N5NWxMYVBtVkExMlNJUGhYSHNFQjQ4N2Y2TlN0MW9TTThmRWk5elh1S1g2?=
 =?utf-8?B?UUpuTzUveU1Ebk5VY1ZMemxiSURTYSsvKzIrZVRMN2NneHVENTY1RnZYZmM4?=
 =?utf-8?B?YWRNQWdNZytWOEllbnhINVRFZ0xHeml1WWtZYlFsT3NYL2p3dTBpMmxpempX?=
 =?utf-8?B?a0hVTndyaHQ4VFhMNlpCc2wzanJXUkIyNEYyZmdjYXJVWnRydGd3aXpyTGRY?=
 =?utf-8?B?UWxtNzlXd0dwTmVsak1yd2pqeVBQNWJxL0FYczkraXJqaERwVE5Ec21MMkVK?=
 =?utf-8?B?RURoa1BINDdwRlhxSWJ0bUlBaUE3QTVBYkxUbEpFN3ZnTWVHcXNnaEtHZEly?=
 =?utf-8?B?b2RxRnE4V2pEZ2FMZUYrUExiTG5GK1BDSE13L3RtR1RodElOTVRCL1FhWjM0?=
 =?utf-8?B?QnJsUTd2OUNmaGt0TDUvUXRZRTlOSzBYVGdyc2tMalQvNGsxY2l3d2cyTUR0?=
 =?utf-8?B?WUcvVjZnaG1ERk42c285SUxmK2V3cXVNeFZvUlUwZkNpQThpdjI2R1lrL3Fl?=
 =?utf-8?B?MGNXNW4xRFphc0hGSzFrZnM4eGRWeGYvRjZGazdXM09BajNJZ1RBTS9ZT2Rx?=
 =?utf-8?B?L08wT3UxOTZtbVlxbXEzRVg2L0g4ZXRldTh3OGZMN3NpY1FGZjMrK2g0T09Q?=
 =?utf-8?B?Qzg3aC9pbzFZVkxOaVR3aFZXcUxyM3hFaEErZUtpUnZBcFY5RWJCbEdOUG5M?=
 =?utf-8?B?MFNzNktpQ1ZkMWlCS1Zra05HWjJyMlNWempaK09RbGVSSWxqQnk1SGYzelJP?=
 =?utf-8?B?VGJIVTFiaHU4MU1yaERDblJQdm03VmdzLytab05qclp6Zzh2ZzdOcVA3UFY2?=
 =?utf-8?B?azJtaFdUd0hRRFJpYk5qaTVQcC95WWtyNk5lSk9abU1uSzZScFB5bW1zdkpG?=
 =?utf-8?B?aHd2MW1TR1pXSW5hV0xyZkIrak50ckVHVVB1ZzVsdXYzN2YvL2pHRlJYdVVC?=
 =?utf-8?B?WVh3ZGlZUDRRQUlJR3p1bXdnNEpteGt6UWhXVGp3aUovdGIzNmgyR1ZleTJC?=
 =?utf-8?B?blV6WHg1K21PTUdUOHVlNUxNeDhVdEVUTUtWVGxxNjNoWnM4UFYyNkZuWVp2?=
 =?utf-8?B?VThQM3RtdkR6TFVUYzdEZ2I1ZWNOTkpFNlpmNVF1ZXdyc3hjMGFSTGJObFds?=
 =?utf-8?B?YlJ0SWhKb2l2WEdGUFdYd0w1LyswS3ZqYXBnWVNkeU0vblgxT3lsMmdHZDFR?=
 =?utf-8?B?L0ZxTzlXdlllN2FnamhicDVRWHI2bG5LZWVab2ZrYUVDZkFHWThvWmRqTjVp?=
 =?utf-8?B?aG5BcVM5SGExRWpqd2hHcFNSenZoS2xENUxGb2lFdmp4b25PRXNYUm92dzZD?=
 =?utf-8?B?T0Q0Y0JaRjZ6dk1HdEVkWkNWUmNNNzk1bXp4TVdFUklzK3U2VXlQLzJGZ2Ja?=
 =?utf-8?B?clJSK3Z5aHBIMlpwNmdseVNBMzExT1VPbUpHYzhlVDJnbWxyMXhwUGtpOVpD?=
 =?utf-8?B?TnE2Z0h2N2k0NUJmUlNaNFo0UTdUUzFnTlpnbFZtL1Z5NVZvNktoN3M1REV5?=
 =?utf-8?Q?DT4SfHusUO/Ds6eZ+4SZ2PcrZUgXmPFx6QYLPiZTauV3Y?=
X-MS-Exchange-AntiSpam-MessageData-1:
	fqEKjmKeViHOKmuzgaMtDeTHFOhXwyG1hF/RlhFqKtR0CW9fr7mOU/D4
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86923aa1-7964-44b6-6214-08deb1123217
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 17:08:04.2381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bbJ12Sc/lKT+Ap6Z1reEH0ZKpd6tKdRZ0Ky2A2mwiDC76SRu2MrxoZBwYAkJJyM6PyLPzCbEoigHaO9t3C0G4qONWcU/elfoBsAT3YvKxYei5HUsVcLZFmN3zcnNJlQh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6777
X-Rspamd-Queue-Id: 4EEB9537E8B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287689-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	DMARC_NA(0.00)[onmicrosoft.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	NEURAL_SPAM(0.00)[0.444];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url,checkstyle.sh:url]
X-Rspamd-Action: no action


On 5/12/26 00:07, Jeremy Kerr wrote:
> Hi Adam,
>
>> Sorry, I should have been more explicit here.  I am not certain what is
>> going to happen with fragmentation, so I want to be protected against
>> future changes.
> Nothing is going to happen with fragmentation. Your driver will only see
> linear skbs in the ndo_start_xmit callback.
>
> Adding the skb_linearize() there is unnecessary, and creates ambiguity
> about the structure of the skbs that we're dealing with in that path.
>
>> The check in validate_xmit_skb() is good, as it protects against the
>> current set up. So my option was to put a comment in here and hope both
>> changes happened together, or to just try and get this portion of the
>> driver solid against the change.
> I'm not clear on what changes you're referring to here?
>
>> And I thought that was what you were suggesting in the comment. The
>> original comment sounded more like an "here is an optimization" instead
>> of "this is important enough to kick back"
> It's less of an optimisation, and more removing something that is
> unneeded, and potentially confusing ("why is the driver doing this?")?
>
>> As for spacing, I get that there is a style, but it really should be
>> encoded in checkstyle.sh or something and automated.  My own tendency is
>> to put way too many spaces in to chunk things together, and I end up
>> going over-draconian on stripping them out to try and meet the expected
>> layout.
> I'm not too fussed about the style at the level you have here, these are
> suggestions to clean up if you're already re-rolling. My confusion is
> that you had applied my feedback to one part of the code, but not to the
> area I had commented on (which has the same style structure).
>
> You also had some sashiko feedback on v40. I'm not sure whether all
> items are relevant (I *think* you're OK for the first, for example), but
> worth confirming:
>
> https://sashiko.dev/#/patchset/20260508032953.337036-1-admiyo%40os.amperecomputing.com

I'd like to address this part specifically:



 > +static int mctp_pcc_stop(struct net_device *ndev)
 > +{
 > +    struct mctp_pcc_ndev *mctp_pcc_ndev;
 > +    unsigned int count, idx;
 > +    struct mbox_chan *chan;
 > +    struct sk_buff *skb;
 > +
 > +    mctp_pcc_ndev = netdev_priv(ndev);
 > +    chan = mctp_pcc_ndev->outbox.chan->mchan;
 > +    pcc_mbox_free_channel(mctp_pcc_ndev->inbox.chan);
 > +    scoped_guard(spinlock_irqsave, &chan->lock) {
 > +        skb = chan->active_req;
 > +        chan->active_req = NULL;
 > +        if (skb) {
 > +            dev_dstats_tx_dropped(ndev);
 > +            dev_consume_skb_any(skb);
 > +        }
 > +        while (chan->msg_count > 0) {
 > +            count = chan->msg_count;
 > +            idx = chan->msg_free;
 > +            if (idx >= count)
 > +                idx -= count;
 > +            else
 > +                idx += MBOX_TX_QUEUE_LEN - count;
 > +            skb = chan->msg_data[idx];
 > +            dev_dstats_tx_dropped(ndev);
 > +            dev_consume_skb_any(skb);
 > +            chan->msg_count--;
 > +        }
 > +    }
Is it safe to directly access and modify internal mailbox controller
structures here?
By manually clearing chan->active_req and freeing the active skb while the
hardware controller might be actively transmitting it, could this cause a
use-after-free or double-free? If the controller's interrupt handler runs
concurrently, it might dereference the now-freed skb.
Should the driver treat struct mbox_chan as an opaque handle and rely on
the standard APIs instead of manually clearing the queue?

End Sashiko Output

There is no way to clear the SKBs in the ringbuffer without using the 
internal mailbox controller structures.  THere is no callback to flush 
old messages.  Thus, this is done inline in the client code using the 
tools available.

The first step in the code above is to free the channel.  That will both 
disable the interrupt and unmap the shared memory.  The primary way we 
could get a use-after-free is by the code executing from the interrupt 
handler, which is why we need to disable it before this point.

MCTP stop should be called after the MCTP infrastructure has removed the 
device as a viable target for forwarding packets. Thus, we should not 
get another tx request after this function gets called.




> Cheers,
>
>
> Jeremy

