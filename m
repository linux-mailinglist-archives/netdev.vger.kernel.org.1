Return-Path: <netdev+bounces-285418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMGCEk+3/GkqTAAAu9opvQ
	(envelope-from <netdev+bounces-285418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 18:01:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8002F4EBBC7
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 18:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3AE223016B58
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 16:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261192288CB;
	Thu,  7 May 2026 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="0CNOzXzi"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021074.outbound.protection.outlook.com [52.101.62.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39C3EDAAD;
	Thu,  7 May 2026 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169660; cv=fail; b=D4V/aJzAcX0+Lo4RQN+JrIcif8ekVkjua+TbyGASCjTUQYQpK1kyjZkpY5a6ifSalDoNGGcuVBw3zhyHWSMOJEEYXQ8jaUeJvMcL6zAko6OO30vDBpfj86hgtWgc4kgtP3CqRqQdY672YGyYyWm3WdBKie/wihBe02qKaii/eSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169660; c=relaxed/simple;
	bh=FHoljygzMT8Dv0Hbdsd4wTnlOB7s+hTxEuVSwf1NhQY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L3fuZsS9zHJaatsnIBY4qTtj+vV5xbhNa+KTJc1AAJZlwNhwdYg7PbzWBjAAo/radmjsL2KqHIe2Q9m9roXx+8QsZCs6ist55xOejxAohcDPwjkT2yPkLw0iqxV6cysG2f899ejNWEhQEQgew7ozipx6BdoDrEK0ajS0WFa33B4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=0CNOzXzi reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.62.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5bOH174GtoszNUzoL0OjWWyp8Q4foKKMkjk3GxpqHBjB1L4HEAPyX+HxEeEguWZcl+Ba6/V8sFMRAn7vza1/nPBDK+YA9INW1NDGyvjz9QlzqSQLG3e+N6aGv1PvHRtwFHKYOlSGXK8pkbiUR6Rql/e9Iy6CK9nEtSu/Y8rpRXJHIQHZZoZONDSJPmX2EaTpgDijpBmDqLOBZFZB+MIOWVXPUo/Vt1Sildm8gqUtB/mfaRYK8Lo+++T7thCTUgpehkUzouR3EzxrEwXXFDAobRjkdnuB0ngso0iJYmBXPgFXPy8wKFoXog9Pp3BFG/qT205vqV81wmPg7zPrJqQdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBtBInLJOVw/NdOidUMFZcTObyMNsYchZwj5UislrUc=;
 b=IpuHT6gOXCYD1dAPAI9I3qHQYvbRtxprNTNpRgduqRDJMyPBiFH3cq1CNsvhaXDdzAz+zkZM3lWgJfQ5vQZBeryOTjwsHpcYhP4wKRGf/GjrHx8EhnPS/Zgg4ivft8ALNyR55YpYJjm145F4eFQN+8MclBr+YPo4+YlO5hk0SpLrcSYgxBO7ZNj/qB5yc9hmdZqD8RYpu8BX+cQQ9Dob3JmI+8h86oijCHB6H6dB4Q0LlSp2CVah9SDzzRCAGl5hI1Vs78iICW3kHQn0rhm+553l7ttWQ7y1zycyj/zLDJwtanKDc28HK9jvSEvbnXPs4Wgpwpntg+NV7r6TqlzJwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBtBInLJOVw/NdOidUMFZcTObyMNsYchZwj5UislrUc=;
 b=0CNOzXziy5aZa+HTS061MAoD6/KIcZaPu1JYTUU32Qu4AiaiDkeNt5iPyrewQGIBU9Nbp+oPzUgeV33pKqcxoHS1hrQGFkkB8Eg4BlptnmX/QzkgV5f7B4VYU+0INZ3Cb+H+EqSjQ1VY+6m74yYqlne/vMEaW91mm42Hzi1CwFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 DS0PR01MB994107.prod.exchangelabs.com (2603:10b6:8:2f8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.15; Thu, 7 May 2026 16:00:53 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9891.017; Thu, 7 May 2026
 16:00:53 +0000
Message-ID: <3ca74f8c-fa9f-4a26-a54a-90ab4fa652cb@amperemail.onmicrosoft.com>
Date: Thu, 7 May 2026 12:00:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v39] mctp pcc: Implement MCTP over PCC Transport
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
References: <20260506214327.276069-1-admiyo@os.amperecomputing.com>
 <04015745fb7223f6d7dc262ae505daf0272586fb.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <04015745fb7223f6d7dc262ae505daf0272586fb.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0108.namprd05.prod.outlook.com
 (2603:10b6:a03:334::23) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|DS0PR01MB994107:EE_
X-MS-Office365-Filtering-Correlation-Id: 3420a330-63cc-4331-b76d-08deac51d0fa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024|55112099003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	zhRw96iiuak3bJgXputq1nR4PS9v9VlVvxx8pP32j6BgYIzqLlXf1xodLfaSGlU3h2vhU8Y/Hh9TK3xUI2VFHmFNWBGhBnT+bUvx9mIGuWPyoQoEWd/9UsB8Pc6IutdJqQvyAI7pP62Cx+Tv53uORCwm+fv02xZPCdfDwhAHnurvpoVTJS6RnnEUxwAAnq/D+4y4QFEUGf/O+2G0JB+orRuLArqTEQju2cCalfBaKH19WoyleMsGOBc2+dQeEHgDoE7XitLyV3bgOC08FbDZgELUhcwzmmNMwER6k+Xp8DdbnzJo9ioB0cYWCy3+VHSEWmYhe5QAYAAGUtaP4q50vaSQF8r2X4vX6O3iUqliVlvfYJBhIlwowblSxYDvnxs/aww7LzuWWB47RP8WPMShM2yx4CJ9/R9gYjDKoaCMg9KRbJgsKAMnYJ+XBZO5L9NS7ma09r78VKxJAZJfNDte1Ct2WZiAIgyuGbMwc5w2vwIh9keYkxaA4VDjmcsROx2dHOJLelAPpOp2UyapUZmojR9xWGC5bOcqgk2nH+6aS/4YE1AXpTX/+WF3b/7KW4ZLTd0A1nrvbseKzOK+oo+FAZd/mAjIPTD5UmijGr59hIgipUmsGXWmoaSmD8W3FZ/Y9NyPba5CP+i3/Eh4VQehG2xHVotDUwET1FbGAD/pPJvY4QLpS41tcHxEUdmnGj8b
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(55112099003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTdTaisveHlSeXFZUHFUSlNFai9rTUZsMDkvT3oxWWthcFZ5cVNIc3RzdEV2?=
 =?utf-8?B?bW1hRE9KR2lBU3Roakw3WXdxUHI1dGFhSjI2Sk9TeDJBQm5mcFVDQmNPWWNt?=
 =?utf-8?B?TVU2SXc0NGVuZHBNLzd4cXFLSzVYUDVwcFZIWjNvV21uMkJHaEVjbGZSR05J?=
 =?utf-8?B?Qk9OWEdHdXhTZG5rcEh1dkNGMi9pQmxvaGdTMDNUT3ZIRTdUM2h0Y3NxMUkr?=
 =?utf-8?B?RTFWKzRzaHVQQndxUlM2M0ZNVDU2YjBwTjl3TFJUVDYycWFzaVJ0aDZnSXV0?=
 =?utf-8?B?aXBaTm90Q213WjZ6anp2VHV4U3ZPTWxGN2FSNjlIV3EwMCt4NlpFK3ZtdWZG?=
 =?utf-8?B?Q2FNTHYwVVdqNU0yTm9yUU9ETnFNb004dTZidjJ1b3BzYk9QcmtPS1BTNDha?=
 =?utf-8?B?bGlETVF6R2dNVXdSeUp0L3JpTnVNM1JIVWNSclg3d0s3OVhLR2x4NlNSVFg2?=
 =?utf-8?B?R0NWWE1sUzJNdzRicU5ZNVFWc0pRb2pxQ05pa1ZPdmlIaktJT3Qxa29GVmtq?=
 =?utf-8?B?dHFCeUJpb3VlS1hGaUFWU2NkY2Q0TkU5S1B3RWJEVm1TWjk5VmZxbWhuTFBY?=
 =?utf-8?B?cnhlUHRzck1XZ1JiakpPZlJJcXNTZzNoTCs2a05XVFk0NEgwcWJNQTR0MG5y?=
 =?utf-8?B?alhHS1Q3cEl1MFZYL2VUbkhDRXMzakR3TENZMGtVcWh5Y1JDVEJuaWk3YkFW?=
 =?utf-8?B?YW4reHhQeTBCVmpQbUtLVjVLcGlaejBsWEhJTjdhSnhRUTBTU2ExK2xYRWoy?=
 =?utf-8?B?NDJhV09WdGtYQWR4Y2J2TzZFQm5RbUd2OGRTUlN1TEd2UXBPbTZ0cmJHRTBj?=
 =?utf-8?B?Z2IySUNKRUVpZ1RFSS8yb0t2aEtlVXh0YVJXS1VlaUU3OEpoR3dsQ0RWeW56?=
 =?utf-8?B?N3RuaGZGVk9UQkg4UDl4Sk4zWk1zMktkYm13OHFETVNJaUNSOVZkbnJnZm5x?=
 =?utf-8?B?ajlFbG11Qy9pcUs5azNGL0k3REZ6Q0g1aUJNbzM5Z0JSWlYva0Z6RDdiNFhy?=
 =?utf-8?B?ZitpYlJtNzNCWUdkN3JxWVZIK1VFZ0JBT2FpUUxrdmx1ZFkrTjdnQlRmbHVa?=
 =?utf-8?B?c1l4Mkd5aVhaLy9QWTB5bFZXV2ZnVXhES2J0SFB1c3FUbnllUVY0VkdiaThz?=
 =?utf-8?B?NnB5ZzV1ZDE0SGViYWcyOWg0bWpSRVhxdDEvdUo3alJZbjJNWHpmSFZ1UjlY?=
 =?utf-8?B?bVRuRHBnN3NLUFREbjlBSFpXeGo5cFVWQkNWbWRrUDJvN0E2dXlQalBUc2tS?=
 =?utf-8?B?N0xzWUFuTXFwS3JBL0YrUE5mTHgxb2cvdiszQ1IvaXN6YkFuc3drUGR1WlJa?=
 =?utf-8?B?bldFdE9lNE9ia3FYMVptWW5MaldhaTNCeWRUQzdFaG1ZMXpPQlhOVWZrdk0v?=
 =?utf-8?B?Wi9NVEg0bE9xNk1WNEZ5Q2VJelZ0ZE9Sd2dpY3c0MU5yMXpsUHJxMkJWUFh4?=
 =?utf-8?B?ME9RUjNxU1NPM0lIVHN5dVdwNTluWEEzWlljVDdkWFRIWE5qS3JkbXVyZGMr?=
 =?utf-8?B?Y040SHFsaFVvMTlVZmZ3d2J5dDhYWDBEOG53REN6c0treEc0N291dDBpaXRE?=
 =?utf-8?B?ZzVEYVhXa0ZQM2J6VjB1S2pXdGtWY3YvakVHRFB3R0NreThTcVRiRUlqcVBq?=
 =?utf-8?B?QVdBMjR1aWtQeFR2R2NLSy92VnFOckRWeWVKNm10bWdZMUpNblpUNWs4ZmFv?=
 =?utf-8?B?UlZsK0V3MzZDa05WaWlCOVR3VFFxcjM4ZlBZeU5WemxzbjhVam41VlNnc1Ex?=
 =?utf-8?B?Skk0NjFsbnVaU3ZZQ0d0NGxGU1FnelM1SHNtald3UXJOYi9iaTNoOVZyVjVV?=
 =?utf-8?B?bnNucWdzNk1YMjBWYmdaQWlRdXV3YVJIT0wyazk3VGdKRVFET2lGYk1oMzdm?=
 =?utf-8?B?Z0NnOTl6Nm5kNVJ6M2VrRHRiK3h3MWxaMWdaK1E5WjZOb2EzSEtCc1J0Z1Qy?=
 =?utf-8?B?Sk9rQnlRNXlKWlhCb3lNWk9UMUtoeVoxaFpyekg5Mjh1ejFTWlY0aWgyYTFN?=
 =?utf-8?B?aXJKTERlMUhCV1RZaVRrcTl2NHFaSTdCNFdCcTdjcFJST0l3bGlBTU52Q1VS?=
 =?utf-8?B?aXFjWmFEQWxNSU4wLzRZY2lpUkkvb3dHaDZUREc1Tk1kM3A4b2JkbjlBUTRX?=
 =?utf-8?B?UTVmK0VyMWk2ZFZBSWNsWk1Ydk1lZG9xTGQ5dUJIZXdqK0ZCSk9acytHaHNv?=
 =?utf-8?B?ejQ1SkJGTUtzNUNOV1J0QzdaZTNwUm41YkF0eUxvZFVrMksyY2R6eDNZMXFa?=
 =?utf-8?B?R2V2THVGVFpnc2lMUDdtWmR3cXdRYzhrZStsQjJmYlBvRlVYY0VPWEpTNVVv?=
 =?utf-8?B?bDFzQ2hwZTlEQ3dGMkNLUVBhOUhqNVZudXMxejRodHgyaHpQZWRYVFdydjdr?=
 =?utf-8?Q?drmamGdWqbJR49ZrLZVjHtRU+KH8dXqUQrqCM14h/TBxR?=
X-MS-Exchange-AntiSpam-MessageData-1:
	Kh1TY53TWKjMGP1KTRIQ726glDxCmVwK+oKU/qvjpJ+g6y7WO+WJ/zZM
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3420a330-63cc-4331-b76d-08deac51d0fa
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 16:00:53.4206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0IP1evsWA1Kmg7yC9P7nWmk8IL/Txx2Z38c8sULa4fUlbS4g+gYmylSbZjOeU1SyVfMG7F8ZR0q1jXXWwBHXOANNb4xzGcIpQP9x6hCnsScLUjlsCkeyjfujXy/SdkX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR01MB994107
X-Rspamd-Queue-Id: 8002F4EBBC7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-285418-lists,netdev=lfdr.de];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	RCVD_TLS_LAST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.7.a.0.0.1.0.0.e.9.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	DMARC_NA(0.00)[onmicrosoft.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_SPAM(0.00)[0.989];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amperemail.onmicrosoft.com:mid]
X-Rspamd-Action: no action

All the other will be taken in as changes

On 5/6/26 23:02, Jeremy Kerr wrote:
>> +static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int r)
>> +{
>> +       struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +       struct sk_buff *skb = mssg;
>> +
>> +       /*
>> +        * If there is a packet in flight during driver cleanup
>> +        * It may have been freed already.
>> +        */
>> +       if (!mssg)
>> +               return;
>> +       /*
>> +        * If the return code is non-zero, we should not report the packet
>> +        * as transmitted.  However, we are in IRQ context right now, and we
>> +        * cannot safely write transmission statistics.
>> +        */
> This reads as if you're not updating stats at all, but you do so in
> mctp_pcc_tx_prepare(). I don't think this comment is necessary - if
> you really want to mention this, add a comment on the
> dev_dstats_tx_add() to indicate why you're calling it early.

This comment is in prep for a fairly large change in the PCC layer to 
address it.

This statistic should be reported in tx_done, but cannot be done safely 
yet.  The fix is to get tx_done out of a hard-irq handler. I will submit 
that as a follow on changes to mailbox/pcc.c and mctp-pc.c



