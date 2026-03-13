Return-Path: <netdev+bounces-267835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFbaKke3tWkj4AAAu9opvQ
	(envelope-from <netdev+bounces-267835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 20:30:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF6A28E98B
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 20:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6516300B8F0
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 19:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43FF349B0C;
	Sat, 14 Mar 2026 19:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="9Sm5/vxO"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022112.outbound.protection.outlook.com [40.93.195.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA424267B07;
	Sat, 14 Mar 2026 19:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773516609; cv=fail; b=mAYLT2iYO/NzrH705QMBQ4UEsgWBUKz8+irxgsEoBJwVclfNmcOfWxFlC75H7qON6JHNQjoinSvAmTv9R0w4Fm29xcA/+j+ROw3inYqi7jrnUqXM0RIRbuB3WCa8EMKZM91ijgNFktcS/QQ+gsKKZvsuCsoqYbc9EAnABV74HOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773516609; c=relaxed/simple;
	bh=fH7Z1YzQ0irm4/0Mr5JZ0u8/tgDCOwFhWEUuNrpYkA4=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n1/Iz2a7xYWCr+yv64f7fM+UT0JqwU4C2w/fozufbAZ30AuEgfuG1pitV394ysetRxdH/4wJDuqBpTQDe5O32gSNVcZwzLC0wmY0Zwe7lcxfWvRvDdkjVyUjRrddEvGX14HyZjSPtsuiyk7BgJxCOeqAWaJprVST8piqqiQKgno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=9Sm5/vxO reason="key not found in DNS"; arc=fail smtp.client-ip=40.93.195.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5HF5Nn/l3yIdk8wWSEQG408zUH2sX8nwaAzHeM7I3Ieenj8NuLJXPzui7z2V4mc7cYFpG1tDVO2LTA24GlRqbmFdP703ORMgvnsO9pP1AXhENxJAGqlEvKfxjTPDf0UlV1vp8ccKo6IbXTD9d2TRj1WfIhztTdBnQ6Bq7D9XsH9UqrSE04cR6DhIojnUmXTlxyohXxxnOb+gCFERdUUg6S+OZQvN76qfCEv2wkLiE7jeEFBrvUUna7CFKDUBHr7Hu6rgSc1ijj89HWX4jRjYmn+CSTIhAOarQ9UZVP2Qd/XNh4qsia6NDFmKth02SpYL1lFfaYcmyPUMabWz/5+TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWiXH80cuvF8lWVJNWV9nrbWIqW8LjzR4IoUHHQFJJY=;
 b=h3cbeTIoWsRrmUQrUPtk+T+4voWNYSGzVEjcDnY3jRsISjS/6qc/UV+F9p9z4g2xFeiIPvAx753UBvotXNJgh3bGVtADyYi3oqfW2xGPmwQdhoZiJ++6KgL9pL8vMCST/VUNWUrSVY/dTNzwDAlUaqa2e676ZMu88HfQ92FnGLD5dLTRCe8qfVtYcEguK/M3wpcn/svcz8UZUOtDPVRdbVNA26fh54LQwaJp0JabMeiUPcjou4qLhe7qEfJkGc24ckqX2Ba/v1O/jSkQHfLAJw79iPxSlP29fPpijHUzANHbIDcxV3Wx5VxWbyJIvXk24oRbFLqWCC1jKLDv9sZGtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWiXH80cuvF8lWVJNWV9nrbWIqW8LjzR4IoUHHQFJJY=;
 b=9Sm5/vxOn4nu1Fr3q5dKck/Libs6m8EFZR0m63K5ndZRqoZvRqsf7swlOBgfQG5Nqn+GoaTj5TsopLdd+51ra4qFlqr/AWAS03TxqFk/GS/LazIui1FZvPfI485QU/GczbDfteNMH5Sq9GvaJ6071yKq9waQHTGW9VpSBpJgfKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SJ2PR01MB8483.prod.exchangelabs.com (2603:10b6:a03:55f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.21; Sat, 14 Mar 2026 19:29:52 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9700.017; Sat, 14 Mar 2026
 19:29:41 +0000
Message-ID: <b2811dac-5bb0-4d9f-882d-a8b40e49a37d@amperemail.onmicrosoft.com>
Date: Fri, 13 Mar 2026 12:22:23 -0400
User-Agent: Mozilla Thunderbird
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
Subject: Re: [net-next v32 2/2] mctp pcc: Implement MCTP over PCC Transport
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
References: <20260303213649.237851-1-admiyo@os.amperecomputing.com>
 <20260303213649.237851-3-admiyo@os.amperecomputing.com>
 <d0c4ad6f1a5b7ed4326e3b4a64dfe1f21042da3e.camel@codeconstruct.com.au>
Content-Language: en-US
In-Reply-To: <d0c4ad6f1a5b7ed4326e3b4a64dfe1f21042da3e.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0365.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::10) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SJ2PR01MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: 96f5863f-d927-4045-1356-08de82000a2d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|56012099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	TrQ4tR7qw6vLZt/3FShU7N/xM54ucGy/1/fWSZBAFFDS3SvpuGAexuPnFHFtOlw5cyYKFA5G71jmvZmv/mRHKbCBeduHWDlr5x4k5+KlanojNQlorfmlijtHJ7fMAPozwGPNB+TqcuLxx9X57jLALDb+vhMoM7JQRWAg0+wHk8YhGfCsDsyPtHaaqG4+Z/j4dCo4LwV7VSOoOsCKImjEsVqGqZK+0rP73HpwUBrGS+gf0CrU824l/GpgFdvB19GOLTlQo0wJ7vFsdQggzeaexSoPZHbruzk9RAq7qt1ShLyuKJbGOjTFvVYGSUkVbEkh8L362SA05yApaDJHJaXVOE12SK9JMBpnQOH0Gy8xu08eK+9e107ScmeQ9Ioth8mTqX4q5UI2SUU5XWVEWog/d0wuz2KeerEgf5JAO80k1sFbD7Wnicc8TlA5NSfdoOxUqyO2w7SqlxpKGZ/QyBz+lQIFFBo2j+GGxJX+f9+z2v2IqZ1CLjq84BrIrw7pKPH0sFtE2FQPJ8ybM6iYWcml8nvFS0XTqS2I5iLAjG8f8dRGZGHJ10XADhBYv97bdRJtHnMBvzbU9D+VpQJrWFj7vqlYZXyq/7+aWSgBv2E9YwKzgM3Gd6pbWTdn6b+jbXcPDp87SYusjCxBo4CVLUWBtgXctGYoOyYzaieaU382WiDy2IHDIoek+0FuvYc4uEiAiyPnM9OF+r248PGhDt0NgFr3H/0+Exznc1K4K2wPKdo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUVwdDdhZGVKYzQxTU5sTDFBc1MzaGxVckZoajBETlBCOHJUcC9lam1OQ0pj?=
 =?utf-8?B?UDlMRnVjTEp2eFZJbHdNdE51cE40U0ZZVHY3WVhiVEUxWWpCWlJkb1FKUHRD?=
 =?utf-8?B?MFRZR1o0VUp1UTdscURFa2xmMTYxdTFpcmpiakdBa09na0NEaUFsWFBybjVa?=
 =?utf-8?B?d1NlYW5ZV3g2R0JVZTN1RDlpVVdXb2pVa0lHc1Q3SURvdVppL0xweEFVaVlU?=
 =?utf-8?B?UkVsT3FuWU04RUN1M2RMbis5SnNEQlJxRFQyL2xnbnM0R1hLNFRNZDhNY1hp?=
 =?utf-8?B?MUt5L3ZZNFpPQzlwSVYwelRodEZBUEhzWEJxRE1VQzEzb1YwWU9VWis5bDJi?=
 =?utf-8?B?N25PdlBUY1FibEVOUzVrd0dKQkJUNXUvdGRiOUNjOXJXODBtR0FzVVdqdjk0?=
 =?utf-8?B?VTRoSWhWUmVjeWM5RkdsbUZVdmh6a0dvQUpWSGRLcFBLaTRodVlYUWxVcnRC?=
 =?utf-8?B?UlBRMTZLeFl4Vk0vdGg0enpTNmQ1MlFxeU54YWJ1YzBOS1A3UnlqV3RHY3JW?=
 =?utf-8?B?OFJiUmVYVitNUDM1VDlnbnlxMXV2TkNaZmZvNElZS1FabTNmNERMdlNKSVR0?=
 =?utf-8?B?akpidE5sS1JnajluL0hoTGxKQWlScitiR2pRMWVvUXlGU3hQRGxxMlBmS1pi?=
 =?utf-8?B?cFNQc1RYTXRvei94RFhkSXRydFNIcDZiRkwxQ0I2cWFNVDF6a0tkNWl6cGJp?=
 =?utf-8?B?SGpKV2lJOU9xTkl0Z2hmS2lWUnA2aHZydUZhSGpCTEt5NEsraWM3NkVicCtS?=
 =?utf-8?B?VWs4YnZvSmwzSTRlZll5YzEvNjVjcFp3b0RDODhnZVhyS0V5cmozL2hLMWZC?=
 =?utf-8?B?eVJlMVBWT1FFbVFNZjh3T3ZkVWNhc2I2Q1lNbnVKQ3JyQ0JOaDM1QndIK045?=
 =?utf-8?B?QVQ1bHNDSmQzYjNPb3hrdnp0SGFubEFCUnFaMVJwOE5XcEJRS2JpaHhHSzcx?=
 =?utf-8?B?MHZYMGVCTW1GUzNTaGJ0ZzIrSkFmb0tDMGZpcklOT0I3Z01NQVVOa1FuN2xV?=
 =?utf-8?B?RS9rVjRyWEF2MVB1WTR4N0pJVU5UWWZwOHFneGhUc2NSSGFhZFN0YWp0akNa?=
 =?utf-8?B?MGdUOGxkVC81VFVzK29lZ0xpQVIyQkE4eWw3SHBOYnNvWDdIaEVRNm82dkVk?=
 =?utf-8?B?TFRSbTRzZFBLRHM1QlRBR0Q1SjZlTnJjdWxSOVcycGQzcklpT29Od3JTc2tM?=
 =?utf-8?B?TGFYN0xhRng1WVBLNTVzT2ZRMGgrOWwvVGxkNUpGMTdNMjB1SHh2QkFVR0x4?=
 =?utf-8?B?c29VYU1LNnpseS9hazdZSVMrUVFJampwWWgzelptSFI0Yk16R05DVXdWdHUv?=
 =?utf-8?B?ditSRktoK2FiUXI2NHpFL0JvdHFNM1dlZitFRnpaMk5MZExTaUVvejM2NUxU?=
 =?utf-8?B?d0hTWmFsUVBFcG02OTFDT3VCRWhDcW44QzNFYmwvUlIwNktOYlNjVCtuQkQw?=
 =?utf-8?B?TzZWQ0xOVGNBWDZwUlI0VzZpejMwelgxTmZWS1l1MnhYRCs5NEttSHNzT3Np?=
 =?utf-8?B?MWZ1ZXBKbUhqbjcrUnBUcEFIRHMxc1ZGOENBSGd4cG90NVhCV3ptNjZDV3NT?=
 =?utf-8?B?V3RQVFdIZU9OWEMxajRNMlpEYk83QXlKeFlBZFlVeHQwdE5wMDNSTjhTR0hM?=
 =?utf-8?B?R05yc0RQZW5vMVZZY05MWkxJQkhMUHpyN3Q4KzBCbkl1ZDNOSU9BamJYb1JK?=
 =?utf-8?B?cGd6WEFHMUNzNXF2eEJmSUp4V1ZTWlNTaUpBOVZPMjJIKzZ2d0Q5MVN5QTVh?=
 =?utf-8?B?Q29INVdjOUJUci9seFhsYm5KL2dCaXpjdlBld2NYcXlHME91Y1dYOFFUVktw?=
 =?utf-8?B?d2ZVOW5VMjFKNzB0bHFrWGIvRC9OWmpCTkJJb1pnK3hmQTFFK1VxUGE3R1Y0?=
 =?utf-8?B?L1MvTG5iU0dSVzRPTERQZ3NtdkNXeUxnRGRybThySnppWWpndWZacjhNcktE?=
 =?utf-8?B?WGpzTzdGMEZRL1NmWFJYQitwSlhiOFNVYWNiNXUwdUY5S0JMV2RVVGQxazRh?=
 =?utf-8?B?aDJTcm9EdFQzcUl3R01sejRvNGw0M2JLSm5uM3EyNnJ3TEZZUmJ0QjVoN1pW?=
 =?utf-8?B?RTZtTkh6bEhnL2xNdE1EK3lVL24wVmVYMlo2ZTZEVFdyQUtlTm42WWhrbFpS?=
 =?utf-8?B?ZVBLV1YxSTFZS0pkOVNXN3E2RHJub0VQdG9OYVpjWDN1WnFQS1ltUnVKRStz?=
 =?utf-8?B?ejlLdmxwZUlyZlFzZldESG5KaFhpZHNPOG1OVUNkUnJBNUs3WGZHK0oybmxp?=
 =?utf-8?B?c1BMVVhwSlJZc0RJelNEbVlPVEZuaU5va2xUdlF4WUxpbFJHVURQajFJdlpm?=
 =?utf-8?B?U2pRVTdRRVNTcHQ3aXdIbDd4UExOcWM3K0gxZVBreFFlOFgzRDlWVndBcEI3?=
 =?utf-8?Q?lc64NlRdzNzHyMi/61OKs3eLifRqQdUyLf6yuX2ZMdA1l?=
X-MS-Exchange-AntiSpam-MessageData-1:
	RMbJUHOictxe2vDJTLjKdgVfkKk6cUyaD5dXqZ8c6+4pFRlZindqKvxA
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f5863f-d927-4045-1356-08de82000a2d
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2026 19:29:41.7500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNWsMeebSy8i/gl9S9uee4RMhaFSDoOXupyP6zhZP601ZU5yK/CZFZFcsf28dl0+ZQfeqHfzgaWNMG59u1pjSfkEZQqvA2oYi2vLcEZHegAqy7xwgFeYoIOVTI1AtQfX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8483
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DATE_IN_PAST(1.00)[27];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267835-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	DMARC_NA(0.00)[onmicrosoft.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	NEURAL_SPAM(0.00)[0.901];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,dmtf.org:url,amperemail.onmicrosoft.com:mid]
X-Rspamd-Queue-Id: AAF6A28E98B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/3/26 20:12, Jeremy Kerr wrote:
> Hi Adam,
>
> This is looking pretty concise now, nice work. A few things inline:
>
>> diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
>> index c36006849a1e..0a591299ffa9 100644
>> --- a/drivers/net/mctp/Makefile
>> +++ b/drivers/net/mctp/Makefile
>> @@ -1,4 +1,5 @@
>>  obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
>>  obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
>>  obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
>> +obj-$(CONFIG_MCTP_TRANSPORT_PCC) += mctp-pcc.o
>>  obj-$(CONFIG_MCTP_TRANSPORT_USB) += mctp-usb.o
>> diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
>> new file mode 100644
>> index 000000000000..d0e7699ebe82
>> --- /dev/null
>> +++ b/drivers/net/mctp/mctp-pcc.c
>> @@ -0,0 +1,322 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * mctp-pcc.c - Driver for MCTP over PCC.
>> + * Copyright (c) 2024-2025, Ampere Computing LLC
> Minor, but if you end up re-rolling: -2026.
Lets hope that it goes not further with this first commit.
>
>> + *
>> + */
>> +
>> +/* Implementation of MCTP over PCC DMTF Specification DSP0256
>> + * 
>> https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/hrtimer.h>
>> +#include <linux/if_arp.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mailbox_client.h>
>> +#include <linux/module.h>
>> +#include <linux/netdevice.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/skbuff.h>
>> +#include <linux/string.h>
>> +
>> +#include <acpi/acpi_bus.h>
>> +#include <acpi/acpi_drivers.h>
>> +#include <acpi/acrestyp.h>
>> +#include <acpi/actbl.h>
>> +#include <acpi/pcc.h>
>> +#include <net/mctp.h>
>> +#include <net/mctpdevice.h>
>> +
>> +#define MCTP_SIGNATURE          "MCTP"
>> +#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
>> +#define MCTP_MIN_MTU            68
>> +#define PCC_DWORD_TYPE          0x0c
>> +
>> +struct mctp_pcc_mailbox {
>> +       u32 index;
>> +       struct pcc_mbox_chan *chan;
>> +       struct mbox_client client;
>> +};
>> +
>> +/* The netdev structure. One of these per PCC adapter. */
>> +struct mctp_pcc_ndev {
>> +       struct net_device *ndev;
>> +       struct acpi_device *acpi_device;
>> +       struct mctp_pcc_mailbox inbox;
>> +       struct mctp_pcc_mailbox outbox;
>> +};
>> +
>> +static void mctp_pcc_client_rx_callback(struct mbox_client *cl, void 
>> *mssg)
>> +{
>> +       struct acpi_pcct_ext_pcc_shared_memory pcc_header;
>> +       struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +       struct mctp_pcc_mailbox *inbox;
>> +       struct mctp_skb_cb *cb;
>> +       struct sk_buff *skb;
>> +       int size;
>> +
>> +       mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, 
>> inbox.client);
>> +       inbox = &mctp_pcc_ndev->inbox;
>> +       size = pcc_mbox_query_bytes_available(inbox->chan);
>> +       if (size == 0)
>> +               return;
> Your new pcc_mbox_query_bytes_available() returns -1 on error, but you
> don't handle that here.

I've dropped QUery bytes, as well as the the other help functions from 
mailbox/pcc.  This error case didn't really make sense on its own.


>
>
>> +       skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
>> +       if (!skb) {
>> +               dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
>> +               return;
>> +       }
>> +       skb_put(skb, size);
>> +       skb->protocol = htons(ETH_P_MCTP);
>> +       pcc_mbox_read_from_buffer(inbox->chan, size, skb->data);
>> +       dev_dstats_rx_add(mctp_pcc_ndev->ndev, skb->len);
>> +       skb_reset_mac_header(skb);
>> +       skb_pull(skb, sizeof(pcc_header));
> Do you want to check that the header describes a valid MCTP-over-PCC
> packet?

Yes I do.  Specifically, I can now check that the packet is both a PCC 
and and MCTP packet by looking at the signature.

Of course, that data is written into a shared buffer, and I don't think 
there is an safe way to check that the data has actually updated (no 
sequence numbers).  But this is an improvement, and will catch some data 
corruption issues.

>
>> +       skb_reset_network_header(skb);
>> +       cb = __mctp_cb(skb);
>> +       cb->halen = 0;
>> +       netif_rx(skb);
>> +}
>> +
>> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct 
>> net_device *ndev)
>> +{
>> +       struct acpi_pcct_ext_pcc_shared_memory *pcc_header;
>> +       struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
>> +       int len = skb->len;
>> +       int rc;
>> +
>> +       rc = skb_cow_head(skb, sizeof(*pcc_header));
>> +       if (rc) {
>> +               dev_dstats_tx_dropped(ndev);
>> +               kfree_skb(skb);
>> +               return NETDEV_TX_OK;
>> +       }
>> +
>> +       pcc_header = skb_push(skb, sizeof(*pcc_header));
>> +       pcc_header->signature = PCC_SIGNATURE | mpnd->outbox.index;
>> +       pcc_header->flags = PCC_CMD_COMPLETION_NOTIFY;
>> +       memcpy(&pcc_header->command, MCTP_SIGNATURE, 
>> MCTP_SIGNATURE_LENGTH);
>> +       pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
>> +
>> +       rc = mbox_send_message(mpnd->outbox.chan->mchan, skb);
>> +       if (rc < 0) {
>> +               netif_stop_queue(ndev);
>> +               return NETDEV_TX_BUSY;
> If you return NETDEV_TX_BUSY here, and the core does a retransmit,
> you will end up prepending another header.

Good catch.  I can skb_pull the pcc header out before returning the packet.


>
> Just to confirm from earlier discussions: you have no way to determine
> that the channel is unavailable in advance, right?

That is correct.  The failure mode here would be if the ring buffer was 
full, which could happen if we have too many incoming packets and the 
backend is processing them slowly. mbox_send_message will only fail if 
the the ring buffer is full, but does not check anything further along 
in the process.  So A TX_BUSY seems appropriate.


>
>> +       }
>> +
>> +       dev_dstats_tx_add(ndev, len);
>> +       return NETDEV_TX_OK;
>> +}
>> +
>> +static void mctp_pcc_tx_prepare(struct mbox_client *cl, void *mssg)
>> +{
>> +       struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +       struct mctp_pcc_mailbox *outbox;
>> +       struct sk_buff *skb = mssg;
>> +       int len_sent;
>> +
>> +       mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, 
>> outbox.client);
>> +       outbox = &mctp_pcc_ndev->outbox;
>> +
>> +       if (!skb)
>> +               return;
>> +
>> +       len_sent = pcc_mbox_write_to_buffer(outbox->chan, skb->len, 
>> skb->data);
>> +       if (len_sent == 0)
>> +               netdev_info(mctp_pcc_ndev->ndev,  "packet dropped");
> You probably don't want a netdev_info() here, perhaps netdev_dbg().

I will remove logging for now, as I don't report on other dropped packets.


>
> Or, could you increment the tx_dropped stat? I see you're doing all the
> stats accounting in start_xmit - I'm not familiar with the PCC API, but
> there seem to be failure paths past that point. Is it possible to
> distinguish between successful tx and dropped tx in the tx_done
> callback, and do the accounting there, perhaps?
>
> Or is this a trivial-enough case (len > shmem_size) to not worry about
> accounting?

I think that stats can move here from start_xmit.  This is the point 
that we know that the packet has actually made it across the wire or 
not, so recording success or failure here is correct.


I just realized that I am reporting the number of bytes sent including 
the pcc header.  I suspect that will mess up the byte accounting: these 
are being reported on MCTP links, and they have no way of knowing that 
they should be removing the PCC header length.  Should I be removing the 
pcc Header length from the byte counts for packets-sent?


>
> Cheers,
>
>
> Jeremy

