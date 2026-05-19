Return-Path: <netdev+bounces-289294-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KyvLpoMDGqFUwUAu9opvQ
	(envelope-from <netdev+bounces-289294-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:09:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 240D9578AC5
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3944330474E5
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 07:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488263B3894;
	Tue, 19 May 2026 07:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pTRO3Aj2"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011014.outbound.protection.outlook.com [52.101.57.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F5E2874E3;
	Tue, 19 May 2026 07:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174262; cv=fail; b=FnoJ56jDfNytb8XNqRHjSPZi8XYOwSNTdMIeXig2yV0IHbNjLCUbOo3FiANfS22wOeOYf/Arpvx7VRQeLYhJyS8v7Rt0hfIxns2OwFYf8+yjfef4yIyKyFPfC+3c2FvGiEiX40O5NBZ2QUeeQ9EUvGfVis1KD/p5i6tqY6gj2Rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174262; c=relaxed/simple;
	bh=DBlTPciHsnSbB7DUGnQhVkSRjdn5p1RAg7M9cS0E/PI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RojRLnrlVD0HgJbR0ybvUHYXiz1BSsJWyJevl5FaisM/jjufa3UoEg0alnd0iU8qMhMUcDMNNimoUvhhEB4hmRGK/sCjh/ypZWuTiG/piR9IGIJbflkXJSyb0yI9zTDCTW1kwcs5bd/fz/IWu/vrYWBluOT2yCJ7MjfTH3t6iZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pTRO3Aj2; arc=fail smtp.client-ip=52.101.57.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TnANcKn9DOjDY6oEMHYPTBYhByxkjV3AFaupz/TLd5EnwvfdTcAu2jrvjSRSsOItRkzTTXbInpjuHUdBI5pyvwzpBIPf3LXz3f8niqOfJcTd4/+UwNe2Mti2Nb9zxN0svnX4/8lzUNp7eNChZFW0cwfNtA+pv9ojMxCfVHD6CuWFHL1XEL873PF3XL6N6mVhkzSODRb9F+XtpNJjBYwKavWyu60+QTLK7Kqus88CvfNjqyPfXTnzAroX4e9v1rDxCjuOzz7v/sCKqfS9i2mkmVVjRjjiv59W2pGpG2wFb0QwKvFAL6ghvIovlQFfSWO3q1yqdLp5gYL0DVZQhl88Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kpxqaq1j2+A+nTN09x4s9iZCdIsq2LB9Mzr4twCNTvg=;
 b=XjwTpNAua/cyIbh5+zAKDfLuTaZDGI4LCAbsMWFtkYLhFCLbsh6iC+h8XW3HAdKz4o4BeRvCzXnMTx/463dNVYjaF6++EDLwVllWCrZ5mxYcHgnAyRvid3A/uKH3NrBhwIWyJatRcrqgr0xPgwX3Khhtcp3BPgdOaCffpf0sjqLXWfz10jdMK2XQzKUa879T7D5L8r8o5ydX96HwFQ7dfFP8/EJeAJ1+x39Awa5QmmDC0trM3lPEavoz0iOfDxBJmoMfSbHAerr4iknjWWu30h7jtOBm/ZAAALw+v6NkDCGQMvFE9bLNO1Xq69iHbETrZWc4sloD1oV7pCfcJDzngw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kpxqaq1j2+A+nTN09x4s9iZCdIsq2LB9Mzr4twCNTvg=;
 b=pTRO3Aj2hXRjHsEhs2gN79sJYtwG+UGeLL37SM1aRoJn6W7obLWzGzMkw4DB8FnU6l4bN3I5Gty6eE89N2epN21bvCjiRlThzubvayhhvpRrXq5rtlKHiXVy/9oTXO5f4FoD53EP4MZvAz9oz7aL2L1CuPpDO7U+7Zjb0m351n881yWqit75FH55s0HOK4QbPfANXIHU0Ocds+MbcuAwAtgBtfJEPxOh6pIhQ74coAjaIPlEqIatG30NzQPwk76jys/7P9O5t21zlWe+yLPuHhuJnBOsUyMMmni9Y9dSMY1tzJMZ2j+EnobzKYZgTmvWGMF7NjtS4bO1Vj7e/Ej1LQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19)
 by CH3PR12MB8401.namprd12.prod.outlook.com (2603:10b6:610:130::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 07:04:13 +0000
Received: from MW4PR12MB6802.namprd12.prod.outlook.com
 ([fe80::51f4:a3d9:b44e:9587]) by MW4PR12MB6802.namprd12.prod.outlook.com
 ([fe80::51f4:a3d9:b44e:9587%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 07:04:13 +0000
Message-ID: <364bb4db-2a45-4b01-b2bc-1f6fdff937ad@nvidia.com>
Date: Tue, 19 May 2026 10:04:03 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: net: Fix checksums in xdp_native
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Mohsin Bashir
 <mohsin.bashr@gmail.com>, Amery Hung <ameryhung@gmail.com>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 Carolina Jubran <cjubran@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20260513072355.1083381-1-noren@nvidia.com>
 <20260514183832.5ef205c1@kernel.org>
 <aa818076-6e5a-4b61-bc7f-0bfe3907fe2f@nvidia.com>
 <20260518143138.74839bf9@kernel.org>
Content-Language: en-US
From: Nimrod Oren <noren@nvidia.com>
In-Reply-To: <20260518143138.74839bf9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::16) To MW4PR12MB6802.namprd12.prod.outlook.com
 (2603:10b6:303:20f::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6802:EE_|CH3PR12MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: a53ac3a8-4bee-42a3-ab68-08deb574d50b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003|22082099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	RgZerwTYjaJh1BmiKgWcaXiECqcESNXUvsXs805Mr8nRrujhRkM274yUdyhH7k46HsvuDBoj66tH69gpDkZEidsPoyUsCkANBW/GLV1SNMJdLXh1gWmN95zwXwzTQPyXH4Vx0xWWRR7BIa34/KJTcyeps5nyIzJptYVcwtJIubTOSXNT7zryTmcwSF2GE1f+N/YBFx1MrHdVClqG8Cl66ZvXeBgRnrC93UsPzIsbwaNIwXaMcWu3/bTSTkbbu/x7tCPPmYPXhn98YVIRIq55F20R9udql/doCVxGJtPSL5CXageQxX/jQXgzrcXHezpQnrwLeS9P58erVhaFlmk42OGRIjA6iNTFLlngPkMSCnTHcqAq93UuH/O4uf4WT/bvrNFido5aeFM0eMtnl8ZHQ3gi283MoWZPJNGdE361NWzPi66UGXz6kSsCOFfHHOTbX/OXdkIoL7Vs1ksCYZKDdzjw6lbmP98Ej7TtjiyoHma0xE6cSUys+x9WdiSC+e+b2BamvaDX6cRA13N46A0WSxmpBQmUckFgFYU6/5S14rpjC8kRasADN3f5bNaxFO/af8f7yORIttY8cBvoX0hZK0V01UlB043ym+C9xQYiOEVti8pDn4lQ0zhMTqxTcpT/2DeWe5wKW9z7pPCXPJfRAl2svIFkV44kPscEMhFBgHXGWXGdzSltvJG0PafurWh5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003)(22082099003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGZkVS9GU1VRZzVSVWJldURlZ1Z0OEM5TEsyTFNUN25IZ2lXbmtFWDgvWjZo?=
 =?utf-8?B?NnhvakNTQTIwZTdZVC9QSFpBOTNlWWxlNDkvOWVjSG1sTklMcHI3SCs4RHJo?=
 =?utf-8?B?R2xsclhnbDhHRUw0M00rWWRaN0VFQjlOQ3d5WGJzVlpQVVJackJ2UHBZZmxH?=
 =?utf-8?B?SklMWXhLOGpoVG96RFh5Mm1ON2VPMEZZdThuNVhQMDFZMEZHd2xvd2tsRWw5?=
 =?utf-8?B?SVRFamZhOW9VeUlxUHhoZzI3WlF2alhLVlNNTndQc2dJazh0YndUS3N1QWhZ?=
 =?utf-8?B?K2p6a0N2RXFLdmZLaXlDTFppeDd0TVp6bDdHRzNYQVpaRDY4QzM3Rk5Ub3gv?=
 =?utf-8?B?eWs4a1NRY3c1b0FjV0RMS0paYWs3UmFpTVNCV3MvNnpsaEVpdUMzaFhvVzJ0?=
 =?utf-8?B?dmRtaWx0SzlpbWljMzFOcWtrK0sveVBUaXBQQVZPNWZFYXVQN0Y4TkgzUlV4?=
 =?utf-8?B?SGx5RXkrMXpLQ1c2MENFa3dURU4wYjRBQ2xvMnJSa3JEQ2ROdFBFQmhWV1JM?=
 =?utf-8?B?cnpmNFZrR0xKcVJBZ3pBY1hQTk10K3Y2M21oR3pyQkVsT2tIWUYwcE1PY0lR?=
 =?utf-8?B?VkVCR2xzTmU4ZHAzQUVqaURuWVczMER4N0R0cHJIY1JxVE9KanRSMUhLZmRw?=
 =?utf-8?B?MDdneXZpVys5dFp3RjNkMFY2NFhzWnNHak9CM252Tjh4SHp1dngrSkRFVlJn?=
 =?utf-8?B?TEpmQkVqQk54b1BpZXFDSGpSZWhDWlhnb0JtcEtlazd0b1dKN2hnVmp0dVhj?=
 =?utf-8?B?NDF2MEhOT3R4TEh5dmZSc2Z0UTB2TGdvQnI4WTFGYWdRN0x1cDc5R3FQeER4?=
 =?utf-8?B?YW1mMDRTZ1c1bkxVS2luRkYwK0JLMlYzZElteU5LZ1hkRWtFYVEwQld4cmpz?=
 =?utf-8?B?VzVSSnBSU3Buc284MVpNeTM1eURYNFlITUJmZlpHUFQxQy9DUzEyTzVwRXpN?=
 =?utf-8?B?bGF1TGw2UXl4dVVJVmZzcGxpYXlEWk1SaFZKNTlCQThQc3l6NGNobk9Camx0?=
 =?utf-8?B?aFdPUlZSOUdFVTEwS1JwbXJ3NTUxVEt4R1crZngzOWVFUHpkUE0vbDBLMDhW?=
 =?utf-8?B?d1lmVSsydTU0Z0NjaUNIRSsvM1lUeFQ2Unl2TXowSVRGTVRQMisrMUdTNHdH?=
 =?utf-8?B?U2tVY2IvQ0p4OE00aW9LZ3VwT0kxVWJhM0JOblAzNk1MMkI1RS8xeWhQN0RM?=
 =?utf-8?B?Nm1CSjUvajZEOVdPSGg1UHBIdkRQUm43UWIxMW5pdWN6NU1wbk9tWHFMRWFU?=
 =?utf-8?B?VjBhYm5vT0JaYlBEM3N5TUk3eklJSmVUd2dLcDZPL0RXRVp1UGVOVG9wUGRR?=
 =?utf-8?B?cGN2ek9Jc0lIMmUwWmorNUlid2VXR0hvcGpQT0lYakZubm5OTUE4dGRsTGJC?=
 =?utf-8?B?OHF3R0NHbWt1ZUtvTkx0Q3pjbU1QWldBT3E4QUdqRFAxYW45M0V3VUdtUW9W?=
 =?utf-8?B?ek1BaUVQcFdXWmxCQlVrUWJYcHV0RkNmYkhobU93c2FqOThkRGJkbVRTQnMr?=
 =?utf-8?B?QWhNRWgyeFFIdkYrd2tWa05Fbk93YkZ1dlh3YmpUR3grc0lQeDllbnFEYnJL?=
 =?utf-8?B?c0Jpc3ROdEdpTGNiKy9hNGVYeFFMbjRzYkxvaFp3UHozaE8ydWZET20rQUxr?=
 =?utf-8?B?NXc0bnFHTUlUMkxvbFVlckovTUFRS2thRUd4SVAxOG92YVFzVDhDeWhYMDlm?=
 =?utf-8?B?amxMYkZxL29rQlhaN3R2RTdxSEpJRFZuL05sU21qdTlLb2pNN1JRa2RIdmJl?=
 =?utf-8?B?SmlVTkVndzhlaXJoWEw5emhzMWdVODh6bzJ6cENMTzRkWk1RSXZNanRzRlpE?=
 =?utf-8?B?dHR1dUpzM0dqcU82eGt0S1ZncDlLbEVIdnEvNmRhQzVEaGJmSUZDTUQyRmVV?=
 =?utf-8?B?OFRoNXRJVUVCdlZ4U25Wb1dXdzNZSlN2RWtETFozaWhvMjVjR0tuSG5oY2cr?=
 =?utf-8?B?ZDJCaE5hOWlmUzJjVTQwUnV6NFFXZ2VzUmdRaWg0RFNSRjhoOFNzZlpwK3Rh?=
 =?utf-8?B?NVZmTUlNaExhbGJBVjZXa3huNkxxNlRyMFhxdk8vREJmemJwdG1xMk1GbzVT?=
 =?utf-8?B?dWFxc1U4YXJrbnJwbUVWN2ZHenBTeXR6RUJKZ0Y4d2gxWnMvSHkxUU5pckNt?=
 =?utf-8?B?anRibk42YjFCRWl2YXJIMUlpOG1CMW83ZjAvVDREa1dhK09FTFNrbTVEWTJT?=
 =?utf-8?B?YS9qWDZXMEdEVkVrUVJSL0RERGx5TlhVRjVMeVJlK3A0aHJna2t5VlVyRE1V?=
 =?utf-8?B?OSs4Y1B6djJxbG1JbjZOd1RUaGxEaTU3MmI2K3VJZldObGhPTW5vK0NUcnZK?=
 =?utf-8?Q?cFKnMQjCTgKwKVVlh/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a53ac3a8-4bee-42a3-ab68-08deb574d50b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 07:04:13.0248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMw+vzpARIrKKuBq2ZJCV16YePfb754sIcD8juCYU43J7Eq9E5FlV0LxWBvV/sPPjgcCzSQKdx7crX7kjEgwKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8401
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289294-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,nvidia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noren@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: 240D9578AC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 19/05/2026 0:31, Jakub Kicinski wrote:
> This patch needs a respin for the issues Sashiko pointed out, to be 
> clear.
Replied to Sashiko earlier (my reply went to sashiko-reviews and bpf
but not netdev - oops).

All issues are pre-existing and harmless, so I don't think they should
be addressed in a net fix.


