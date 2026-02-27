Return-Path: <netdev+bounces-261939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPPWMxbaoWlcwgQAu9opvQ
	(envelope-from <netdev+bounces-261939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 18:53:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 352C81BBA71
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 18:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5519D3070DC2
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 17:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B4536213E;
	Fri, 27 Feb 2026 17:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="snCX9b5F"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023095.outbound.protection.outlook.com [40.93.196.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1FD362136;
	Fri, 27 Feb 2026 17:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772214589; cv=fail; b=nEG8V6/C4GmEEtHq/in+kaHea2r+wbQAOZfXLyTsfVaARBMUAhSZI5zQfnsAkWLujWVRUKlsXL7F2oZK+Usr9Oo1zBDMGQSvpTsoBe2i7x5O8yUQtqfTMAM7JLDPVDejdeaJQjYWuRWeM+W1yA6306M8uDgFDnVNyf3cyhNclC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772214589; c=relaxed/simple;
	bh=R5Ogm8/12NJb7+X47SYlHb8T4Wfb1hyR5EQS/cBWcyM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CVuADf9LrgbyxLd7WKgG6FhHSnkqiN+5Exq2t8g8crribg8pMMHpm2d18iDYZy2gNHcCMvF/RhRg/bn7Jy572LK3Opbi4ltPhy0UnpT1zOVITqcYERvzJckEZE8rQNBOiYUTQM4f0qpZ1qvwyHh09UN4WhIiTd6YQ0xtFKtFs04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=snCX9b5F reason="key not found in DNS"; arc=fail smtp.client-ip=40.93.196.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXhgxU/t/4zzpBbJb73uVrJkI99tF0IwGCrz61JAgkRubcOls3FejNpruN47Vd9j6X5KqkdeqFl8dEeAFLtalidkQQPI4nqlo7Z5zuDK5209BDp6aXTG0Qg8CpDlUoJfhgWuqpE8DJE4gKWSQZnM8r+9ZYS/CcaFwryFL/qbATU4VCh09Zq+L1/01lyM3Gak8OFr3lmkllun1mcXfTbPOXLL9G7PAM7+isQOzzr5TzjDQUeB6KPQ4muQsIkTvczlhM6unHIAPcMJLJZ9/wPxzFC4CQyyY3kYi/AKl2a9rOjDZGuXfPCgp87RgTdwpfil4hvQDao5LKnmDPVul/Cs4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Km+5t8IBPENZBtX9B2mJzUtSHKRhuGek+2VmgTFW7TE=;
 b=lEWR8XyVBhtz4Jh9OauXMz4jg9CROzOowYbV4fn1jqngxOGMW/+rWSQbVhzjk9piTOeGjjWfdncCDuZp2QIK0AUsjYiZWlLxsD7soS7j2fFe3gO+vyLSX107wgGJex5DraUcORuctNjrjuZve5fQi4zOUr703BY5Azq25xcGgzByfACh/uZWJz0wLK/yTVm14sBsZfAj1ZgMKOyIm0Jb6edMa+upZhVInma25O7kPDZqe93WF1eFhtAeJ1emWYlVNUNmvZnUSV+KIUMSxvxCB3wATp/u/6/rUGtQUvw9ICyJOvVbEMMywMC9RKLLLTKFolTWnZoPR9qsLZ2FXR+3ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Km+5t8IBPENZBtX9B2mJzUtSHKRhuGek+2VmgTFW7TE=;
 b=snCX9b5FEpaheF8OMO+UhwX/X3pm3Bh8fWPaFY0Pk7Ka4iBUGCmYaJbMoqHRZcurMrcz4dLpP1qRTQsFX2GhVOF7fr29pjM5dn9dq1bUQ+LXOIpcOs0yfxP936nFxoW0eZm7we56x+4tXuPozjDP1gu4bzQ2mzM4yxlbi24JGwM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 IA3PR01MB8723.prod.exchangelabs.com (2603:10b6:208:537::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.15; Fri, 27 Feb 2026 17:49:41 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 17:49:41 +0000
Message-ID: <faf38c7d-8f9c-40d1-8e8b-548b7047d06e@amperemail.onmicrosoft.com>
Date: Fri, 27 Feb 2026 12:49:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v31 2/2] mctp pcc: Implement MCTP over PCC Transport
To: Jakub Kicinski <kuba@kernel.org>,
 Adam Young <admiyo@os.amperecomputing.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20260224231055.393329-1-admiyo@os.amperecomputing.com>
 <20260224231055.393329-3-admiyo@os.amperecomputing.com>
 <20260226183252.10fb6003@kernel.org>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20260226183252.10fb6003@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY1P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::6) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|IA3PR01MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: d2298843-ce61-40da-34c1-08de76289547
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	3WJiGDkVVRrjGF7YKbtiojCrxopi3v6N0OPZOhnHEfllRyMmbk0uQvaNFV1N214ek/3KgiLOZK0n7KKi2tw9sL6UwFCEJSEqN1sqHmOj6BJfOYFGDj86nBlbuoaF3fMOyLh1GV27lNcz2kWauG2R7JtM/sh0118EhPFruKdGdYH5RvTLikAvLfpuhC00JCJOVWpqOLlaX9gOZr59VAg3B4rS7pGLNBw4R/BEvm+DqTH0cxQCWazWQgpMzU2BqP4OA3j9/7auceuokID/wa/Q2Z5X1nkh4lt+pJdI2TMzmhcqbZCuDrn4l58aUcshpH0WTP2e66GgGdNhYpE/uaDl+mYa8oz/syZhmWfht2cqeo8+ZPcFJlgWgZrwr6FEyea7vaecqjjRuuVH0k9kr6WMeT3vMb0CU8GH7apdynNh/Pqgc0MX9z+GyjbFYLjN37l637vHGxGLoVkNoPOjzyKum9tcRL9diFsy4oJmfP4jQ74tlX928AYJ5Vpm0e7qG6KJl5/IDnejiByE8+qIHwKqiau0YawggTg2dqriFwxtwJwSuRJTn0BNbnPzjji3OJ/TmrSif7m/TOpFf0plTeWd1tEurA/ZrUKR3TbMlQb85KPouPPFb47HWBqHh+zNVNnRBOvncA5gYSsVLTqz9UAEbtFC8c7qDWOBUt29rByLOWAlNloQy6Dea+xBPgTnsobFvcTHUQUKlN+rmsgXhOPZ5b0beaXeEM3KG2y8SIRfmNg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFo5RjF4bW1FM1BnMExTMTVpb1llcGRiUVlHV25EMUtBSTJSTkRkNkJTdGdW?=
 =?utf-8?B?TXViSkYrMXFTZzRtN2tzSFVTSDFBZEhGNHNIejRNZnJBMnpYZXhTWnZIVjVn?=
 =?utf-8?B?VzY5QWtjZFlyYUlaZC9KbkZDeDQ0dER0ZjhvaFZobVJLYndPbTlvaXVnTW0v?=
 =?utf-8?B?b09wRG5WSC9CZldzaWNzU0ZOeHQ0ekhDNVdLNkpXWWtodHJaV1kxeFJmTUg2?=
 =?utf-8?B?WXJaNjRkdis0Ly9ReldQR0RQclRTQmMvUkJLNkhTS0xEU0Q4eU1NcHF5d0cy?=
 =?utf-8?B?aWZoZWtUNlpLUEd6NFlBdXdBa3pSNWhqR3czalFObTk3NkV1eE5VMkZOSkJ5?=
 =?utf-8?B?UjZ4WEFZWmlzRCtXNlJiclpGTm9PUTgyTUJtS0hwQ3pCOUVRNjk4aDhQT0t5?=
 =?utf-8?B?cWV1Sy85Y0RLc2ZGVzJHeTBKUzdhSUJLVHF2VkdtN0dXblhLR1ZPZ3dWaEd2?=
 =?utf-8?B?MDhQdGVyaWtkWTV0cXhFS3paWnBkaTludzMxbVNLb2N4QTFSbHdUa2N2aTJo?=
 =?utf-8?B?eEdMdjh0RjhpQ3VkSXVieklhMXBRT0ZqZVZ2VVUvWDE0TkdQMlJ1emFKTExL?=
 =?utf-8?B?d2NiZm9hRjFWWlQ3YmFKckhSdTYvMTJvMXpqTmdxYzVYR2RzYmZ6MjRJN1Zv?=
 =?utf-8?B?cW1kWUMwbHlZOHBNN1RKTEJPaE9OWS9nL0NrcnRXWmlVeFlYVDB4YzB1N2k5?=
 =?utf-8?B?eTlBbHBzby9xY1BkRU9ySGhIb1RlbjNKZVpVdzRWTFhIM05id2Myc0lzUDBp?=
 =?utf-8?B?aC8vMVpUdXFocit0azAwZWVySGJNUzNBaWxSRExsYjZYeURmR2FKdkpRc2NB?=
 =?utf-8?B?NG5lREVtY2JUU1VvbS9CVkQ5UWhQRVdqVm1HZHVaUmQ4RVc4dlppTXF2dmlz?=
 =?utf-8?B?STFPQVdSY1hlQ3g2Qm5MdmhiUy9ZaThEWXVwMkVUYVpMWmR2NSt0SmNlbDNZ?=
 =?utf-8?B?V09lRURNUzVTNzkrcDJRQlZZSmVmejBhNGtBTUxNdFZYQmhCMW4rZjVrVDND?=
 =?utf-8?B?V0tydnR2T1lLdzhFYytIT1lJWkJpWTlhbjlKQU83K3J6YWhVUmxhbVJrTWgy?=
 =?utf-8?B?UUhPU3o3aG5nS0FNQ2Fxb2RKZzRSRkZkWEMyQlNHaUdGSXBwd25aa3dNa3hu?=
 =?utf-8?B?Um1JS05YT1B0TnJPc1Z3RWVPTHBQbFpBcUh5bG1xVUg2VHBER2dSVEt4Ym0z?=
 =?utf-8?B?MGhna2VsQUwxQVpKV3U3K3ltN2YrU2UzUSs2OERQbVhhUENIYnE2dkpPSUxr?=
 =?utf-8?B?Vnl2L3lmcVFkVkp4NW1VVnQ0b0VaSkxldWpPcVFvdVk1K2UzZ0xSc3RpdnhQ?=
 =?utf-8?B?b2UrYzZ0YkZKRzdHTDJBT0p5U3B3Y1U4bW01dWEwcFppcGlDM1NEUzVTUDhB?=
 =?utf-8?B?dmMyNlhWWmNuaS9HSGo2bnZ1MnhYanFjc1BqM3ZUUk5qbHdwM3VNQ1V4MnJY?=
 =?utf-8?B?NzdJaTVubVhZM1Z2cWpZZlR4aXo5ejVqdHRrMU1jZjdSamRjTlhxUE9NK3RM?=
 =?utf-8?B?SkFwSmJWblRLRm1vRURMdVpreUNUMVczVk9TMHlWeWQrVm1zeTUxaUxYZDZH?=
 =?utf-8?B?SlozMmlMRUVoeDhXZDU1NFVQUVNSY0tjbU9qV3RUcU5VRUxJTERoWnB1UkRp?=
 =?utf-8?B?SmlRa2o5ZVN0cVUvVk5kT1ExK3BWZlJaQW4yaDV3VExZVkhQY1pndHpEUFhv?=
 =?utf-8?B?dHNUMy9TZ1VPdngwMldWeit3bWdlOW42K0paM2M3aFFrbEJ1eUw3eDBsWmNO?=
 =?utf-8?B?c3NCOUU0T0ZVbDdKRWJqTFdsME85UkpYUlF2QXppRzQrRGZlc3hEYmpkK1Nt?=
 =?utf-8?B?MHJ4SEdwcG1OZlpGaTViT0JJc2FtM2M3dGtmWUU1OG5vQ3FHOWduNk85V28y?=
 =?utf-8?B?dWk5SSs5WkxtSWd2bXBrNzY3RHdsVU1jUW84cnd4SkNsRHF1Nk1Sdmtaa0lj?=
 =?utf-8?B?VjdtYmwrQk44QXo3bDdBMk9POXFyajFVaGtpU2dFVWF6WkZIeUMzdVZ4Uk5s?=
 =?utf-8?B?eEdzRis0eTB3YzJwS3AvbWk0Mm54Vm9rUmo3YUkyeTNqRXg4OTRNS0hKV3k2?=
 =?utf-8?B?RHBvRUxBS0hUcWtBZmtBMWp2Tlg5cVk3dTU5cHZBTHRqRTZEUVBSdkNzU1Rh?=
 =?utf-8?B?ejVWMHZuTzBBTVArY25FWkcveWNZM3RBZmZQTG56YndRWkZoTkRoWUR1bmZq?=
 =?utf-8?B?NGxaSXBrSTE0cGMxdFBMTjk5VENOazJ2ZDI2YnpUbUNGUEFCbUlHWlFrZ2xO?=
 =?utf-8?B?biswT0VhTHRnb1A3aWpsSXpzR3Ywa09nNllaQ21yTnE2WmhQWUFuOFpaTm82?=
 =?utf-8?B?dkhzZGFGNFlIQVZxVmFmQWhjd3FwUWw5WkRIeUxPUGhZcWJzUUZvQkUwaVdJ?=
 =?utf-8?Q?LeEwodku7lvhNDSC3v4zEspTseTugmWS1KI0KUrhNHmNV?=
X-MS-Exchange-AntiSpam-MessageData-1:
	Y+BLOcdT00+SLVUJoUoiWTDTkYtCQivPbey1bI4iTFSiqWevsbXTflpF
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2298843-ce61-40da-34c1-08de76289547
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 17:49:41.0007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hlXcraz+dsey3iUza2oG0AKYcXGOZSHCmJxAH1bkM7WO6ZOGUUnbFm5ROADSUGJCnc9QiUpg//zfLDFT1wZsO6xDfmizmktDIYCs6W93V8Qvm6Goet0HilOuOwnv+HMJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR01MB8723
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261939-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	DMARC_NA(0.00)[onmicrosoft.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	NEURAL_SPAM(0.00)[0.579];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amperemail.onmicrosoft.com:mid]
X-Rspamd-Queue-Id: 352C81BBA71
X-Rspamd-Action: no action


On 2/26/26 21:32, Jakub Kicinski wrote:
> On Tue, 24 Feb 2026 18:10:52 -0500 Adam Young wrote:
>> Implementation of network driver for
>> Management Component Transport Protocol(MCTP)
>> over Platform Communication Channel(PCC)
> make sure this builds cleanly with W=1 please:
>
> drivers/net/mctp/mctp-pcc.c:133:27: warning: variable 'outbox' set but not used [-Wunused-but-set-variable]
>    133 |         struct mctp_pcc_mailbox *outbox;
>        |                                  ^
Disregard previous.  Turns out -W=1 is not the same as W=1.....

