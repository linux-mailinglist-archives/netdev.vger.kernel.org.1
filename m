Return-Path: <netdev+bounces-174662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 729B0A5FBB3
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 17:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8358F7A2ECF
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 16:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A6926A0C2;
	Thu, 13 Mar 2025 16:27:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA5P264CU001.outbound.protection.outlook.com (mail-francecentralazon11020108.outbound.protection.outlook.com [52.101.167.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E84269D1F
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883225; cv=fail; b=YD376KLIHbLn8RLTTQPftRZPhIZLupnKfL1IYJHUDUPfoPeAkIm60jh6cnyilr3jETxdFUjN+iq0XC+co5KydQMqPd7L3WuQoML18OwMVtPKyk09S51Ni78AN7nn5XhGIv6AG95PYldTsmE+h7Tauu6ST2ptPCFjhI/KC44IobQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883225; c=relaxed/simple;
	bh=MMgw5rbFRaDUCD8Xlkp4wmFButFay+eJUjA88B8Z5xs=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=C+tSyBAOXS1PZ89jATWQO3ZqqddvnqLGRZGJv3SvfXrttD2X40slkA04PI5UMBOnGGEhOKbdFzmW7UWQBkRFqyQm5XUUqYw7hJLvRUHeWhyQlEOMDviw0SUqqFud5jYR2rTWukuWoC/Vhi3d4F6AyxTi3BCj47P5oY08VnH0Tt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=randorisec.fr; spf=pass smtp.mailfrom=randorisec.fr; arc=fail smtp.client-ip=52.101.167.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=randorisec.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=randorisec.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2a4e7Pc5jhFUcA/aft2oK10sQcHAYh1q3sm+H63ZbDuU52cH0hw1UU5t+Q42cqfhtHqXMF8z14qPWQKPZ/2q2A27CkTRnPmLqw8ag0heqy7pAna5em6ndI1exsJ0WWIwqp5psxTHFS6FqcXGcjXAEcuGIZZ3xDUfYKBwwQyo/Pz9hWzmlSG+ABouwrkIBywJy0SqYLBcK5xfVmLg9e8cOZakg52skvXJgCVe+HRl93Vac0o2qRBlWQPeV5lFojOJsdX/C0ge7WEXIQMO2z2PIi6DUN/hlxL0ikLsRyoBvM3/8kVMbN3AfLjLKLX7K06606gXCksWrmxDaM2Dm4FaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzirWgqPWGPdUkD99vIpXN+HpjxcoLgpV9gIYpRiHXk=;
 b=fDBqpR6+n4B3BRvxWp4fXKUaOhx70LuEU8g4PdAjL1siaiwIsf6/THxxDFBOE3bdQOD48KoEoObHzhcJ+TvGeLWFj0fgjNpg3KjvCUjqDcuKm2kupzPat57hdA4+UzpgIlt7O3s4CdOG7QEq/lBTTsbWEV5j2wDGe6n5zemc3lDHSKx+Dqhf1RYYcR4A88gEpdwKLNw5ekaTbyfbc9GdMf2DKVfVBBx/fc2qqx8/M6QxMzjz5Joh/Q+e3GsyCBiIIm9ihjP2qADrF3VKG/L6z4FxnB6M8t8vq5x0B7KZh6nCjqcIyBQMY3LemYT/G3GO8jyfiAUahnWDuqGsd0LcpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=randorisec.fr; dmarc=pass action=none
 header.from=randorisec.fr; dkim=pass header.d=randorisec.fr; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=randorisec.fr;
Received: from MRXP264MB0246.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:16::23)
 by PARP264MB6297.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:4a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 16:26:59 +0000
Received: from MRXP264MB0246.FRAP264.PROD.OUTLOOK.COM
 ([fe80::d6fd:76c4:7058:d7a2]) by MRXP264MB0246.FRAP264.PROD.OUTLOOK.COM
 ([fe80::d6fd:76c4:7058:d7a2%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 16:26:59 +0000
Message-ID: <81b2a80e-2a25-4a5f-b235-07a68662aa98@randorisec.fr>
Date: Thu, 13 Mar 2025 17:26:57 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matttbe@kernel.org>, martineau@kernel.org,
 geliang@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, horms@kernel.org,
 mptcp@lists.linux.dev, hanguelkov@randorisec.fr,
 Davy Douhine <davy@randorisec.fr>
From: Arthur Mongodin <amongodin@randorisec.fr>
Subject: [PATCH net] mptcp: Fix data stream corruption in the address
 announcement
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0231.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1e::27) To MRXP264MB0246.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:16::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRXP264MB0246:EE_|PARP264MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d5cc5b8-c5fb-4c01-fb94-08dd624be0cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWRWeFJyODZWbXVieTRxRFJKcFFsQ0hkMUdSc29uYmVjdFdrWFFOM0N2QVdy?=
 =?utf-8?B?UkdRZURmSWIybCtjRXBZQjMxcnNnbklIZ2NjMklmYnM5aEM5Zi84bTRlMG1J?=
 =?utf-8?B?Q3dHZis3d0NuMU93bTgwRFBhTmZpZVpCSm4rbUo1WnlUaVNJRjVDQ3ViRm9s?=
 =?utf-8?B?ejZyMUpSM0tXSDAvS015QitGZVJhWERmNzVic2hSR1JaOXQ2VkhYMVdvK3JN?=
 =?utf-8?B?eFowc3ppU2tHWGhFbVZST2d5UGIxeHMrUmlEaVdmclVGQmRsYXNBYW1POFhT?=
 =?utf-8?B?bGFmOVhrRUNyNXZra3htQ2RjcHh4MUJhQjBKcm1TSW5SQzBzSG1CZGFPdmJS?=
 =?utf-8?B?cVJHZ0VwaE5Md1gzTEtsOFJqUU9IQkl5dzZhOWZ2ZWdTbk5jbVdLVUM5dTdC?=
 =?utf-8?B?L3ozVmZmYlhEUDJYZnJ3aXdLTGZJMXJjUXBRYkhVMXZrVENUbm0xRXRkelVP?=
 =?utf-8?B?cVlMUWcvRU1SWlVLS0VuRTNWTE13UXlFTzUxakhjbDFoR0VKZ2dUQVR2ZjhS?=
 =?utf-8?B?OEFET3BsMjdUL1hJODJ3UWozTmpvRXVkYlo3ZGI3UlVheUVoeGxGWW9xMFVO?=
 =?utf-8?B?NTVlT1NPK3k3WGNDNnVWcTJOQmlyUnNoQWZIT3l2ZG5qTFdXbWVWNDF6WEN2?=
 =?utf-8?B?ZFJoY3RPSGJFZklxRmEzWVpVdFRHVXdBM2kvRXhpYnV3RklOaWFXdVRxQWU2?=
 =?utf-8?B?QS96OUY2bkhLUWJzeFI2SUwwVS83VVNJU0xGc0NHeHp6eXRHalFlWk16eW5P?=
 =?utf-8?B?N0xhbXc2L2ZFLzhndlZjR3AzaUtBdUQzcDVTV0RESm12a3VmcFdXam9haWN0?=
 =?utf-8?B?bGl0K3RIQi9ib3lvYS9YQ0wwZ3BYa2hIZTVLcWtQekYveGJtNXliRkpKVTRW?=
 =?utf-8?B?OE1RZGppeG5tbVRsNHNaenlNMkVsdzJBbDNLUFc2clUyaE1yclUvWVBsT1N3?=
 =?utf-8?B?aGZCbWZGWEtpbnBBKytEMFU1TWZicWNQTFIrcjVlSjYrOThwUHo5d2wyL2xN?=
 =?utf-8?B?ajlzNDVvalRsbnNNMXFZZFZ5SU9HdU1GTUk3UjJYK0dWK2tiN09jQVdOWith?=
 =?utf-8?B?NHJmMjRrSDhsdGRRalJRU0Z4WkljUWN5blQ5TThiR2dxaGVsbWdVQUdLMGZY?=
 =?utf-8?B?TEtHQnVwb2E3dDh3dmF3TENRTU1YWGtoaXNTMjNaZGVLV0JkalVpUkJEWDNt?=
 =?utf-8?B?L3B1OHM2ZjFQczBUQXBDc2poeEdJaHRPWVRHRjk3WnV4bURyM3p5VG1jMXJG?=
 =?utf-8?B?dXJYOG5YSWhQajhPTWdaM0JZMm5MbzBZREJWTUJ6ZE1Zem9RODNONk1FejBy?=
 =?utf-8?B?dk10Mk9MYWRwMHFWQmMvWVZDczQ1MzNDY2QrMHovQnpsclo1cjBLRDVtV3lY?=
 =?utf-8?B?ZU5Na0lSRTNUL2M2ZGVDV25BTUF5VUNGVE9Gem9kZmozWXdtTnJEaXFZTlM2?=
 =?utf-8?B?bkZhK1h4QVl2dzFCMGxhWEIxTWRza2NPNFo1V3cvREFvNExTOVhxZzZOQVJB?=
 =?utf-8?B?NFFyYlRpSVExL1ZmcnZSK2Q5ZXJsb2dLREJHZG1pdXgvS3ZKMW5xSTFCT1dJ?=
 =?utf-8?B?VFVab0M0NldLTVk2TFJpV1ZzbEZ2d3FCdTMrRXkvdGdTWDhKZmlseWxDMkd1?=
 =?utf-8?B?ZVZtRk1iMzFGaFhCemkxbWcveklJUmltTnlWbVI1aFlLMUZLQjBuVnZrTDNm?=
 =?utf-8?B?c3dva0MyS3JPMVN5OVVXWXVXeTJzWVA0K1E2R0MvZkJvdkhaMnhFUGFrN09L?=
 =?utf-8?B?bmhUM3VPbTVxWTZ0WmpLb1VtQ01GbFptNy9JUXRBRDVMWTM4QnhSZXlkdFhW?=
 =?utf-8?B?UURqSHIrUXpHRGRsNHJ0NERnOUxZbmdNcHRjcmo3TmJDRkdKVUcxL2F0TWNK?=
 =?utf-8?Q?BfwMa5cBIeQKb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRXP264MB0246.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWFibkJRZFh0SmN0YW8zdDhYdGNpOEdTeTdrZDBBbWtwellWUk42ZEtrbCtm?=
 =?utf-8?B?S1h5N1hGY25EL2Y4YnFJS2lEZTdiaXVPRWtGZUpseWlqT0MydVZCMEVURG5p?=
 =?utf-8?B?bDhLN0E2SzlJQWJRZks2SWtyZFM4dFhqNVF0TEZUWi9rbHRoU1U3c2NBaDR5?=
 =?utf-8?B?Tk9Day96WjZGVjBOaXY4MUxEbEx6U3RPVlhlY2hNN0sxWVEyeDlGUmV6azk2?=
 =?utf-8?B?aEZLbXJkMSswMXpvbGwwWlBWTUM4ejhac0VJNEpyUERkVmRMbnY5ZGkzeThZ?=
 =?utf-8?B?cTJvMkFzQk1OajZITXkyT2NPblNLUEl6UDZGZDF4RCs5NzBlNVcxaTZZck9R?=
 =?utf-8?B?RUVZUDNmeXZObnF3azBLRElGa2ZNckNHL0pIc2xnY1JROFFKZ2VlbVRWTWpa?=
 =?utf-8?B?QzFlOW5FTWlBYzJWSDBBQ2JOeksxZFphMmR0eXg0L3ROTkZIVWJYNkx3SitU?=
 =?utf-8?B?WWp5VHZIRzBaT251bTZ2N3piNlFnZFFFTldRb0VaMDJjbElBLy9iSDEyK3g0?=
 =?utf-8?B?YXIwRmJOSWFJd21BcVV3SW1hQUFwVitydkJRMUdkNHJpMmZSVG1mV3g3Mk5z?=
 =?utf-8?B?WCtSM1pHb2phbFFNWWRKcGkxcnJjOTZrMEpwOEg3SnlyM0NFYVVzaStlV3h4?=
 =?utf-8?B?SzdDUmNPdFFiSDlMLzJvLzh4KytJSzNHalVHakFxQWJoVy92NFZoVHQ0Wlgy?=
 =?utf-8?B?VkoyNVZpTno1Wk1qdzJNSTVHSmdHWGpFQVRuV3YyakovSE9hTFlTdWQ2WDBN?=
 =?utf-8?B?a0lvS3l1b1U4T1R4cXIvVXYyc3pLTldxYUtoNGtJL2lMRFp2R2NMVmxNd0VD?=
 =?utf-8?B?SlhMRFNyRXRsSnNXamlqU3pvLzJxdUJldTd1ZnhGUTdrL3djRmFFOWlOWGR5?=
 =?utf-8?B?cGRPaHFrOXV1YVRiQTJoM2JvWWU3UGh6cS9yUGJwaTh3TUpzNnFNUjBybUc5?=
 =?utf-8?B?Q1k5d3dCcHZYTy8zTnhqOXZCN2drZU5ZeWh6eDVtOTFHVmlWSFhWNWk0OTZp?=
 =?utf-8?B?eFl6SFZoV2liWVZOVkRzQU1JMTNlTHp3VTZKWVhEZ1FEVGtSbjNxZGlCMUZ2?=
 =?utf-8?B?bGFIRng5LzBBK1JCYk1MNUhwd1Jlc0xFd21DYVhEVGRYOFA1NE1NTG9kcWRU?=
 =?utf-8?B?L0FLazZxQzBzbWFYUmtkYmdDSWcvUXNOVWdHeUVyK0dYbnFMZ3laaUFyRGly?=
 =?utf-8?B?czBjdmt0OVd5S0lxNTdFbEw5MmhPMUxsUFcra3NmTnlQZDU1WnJ6UnVvYWNV?=
 =?utf-8?B?WUdHeUhBOG5vYVRwTjJjUC83SUxWK1AzUEJaVEtEb1FaMUlqSFNrc1VZdmsy?=
 =?utf-8?B?b3FUOHh2RENBZ29iK1o4cThSK0QrTytQSGVneFhhNUt5RmRtZnNIYzBJaWNJ?=
 =?utf-8?B?RmF0Z1VaejZTYy96WkJOem1ncld4bEY4Q1k3dDBHZzF1ak5VOWNRNnAvKzM3?=
 =?utf-8?B?VkF2L0I4Mm1mdEtJeHgyQm1aazNka0hIYVpCV0ZvRVp0ZHNFZ2pUcGdkUEt3?=
 =?utf-8?B?cXBxdEdMMUtiRHgrSGl3TVVxY1pURXFOTThnZkd5WkxzUWxSVTRwVXp0TEVz?=
 =?utf-8?B?YmczMEQ3L09UTjBpekk3YWZpREdIMVhUU0ZSemFLM2lJaVFmRjBpY04yVWdG?=
 =?utf-8?B?VXBXZzk5Q2RrVW9XWGhXY01xQmo0UTJMZGdidXRpV0pRc1E5bHNNeXc5OTU1?=
 =?utf-8?B?TEtWd1JqT0tZcWRvc0hiT3Q2SExRdUYyQk4xUCsrRmhSelRDQTZGWXpOT0hl?=
 =?utf-8?B?dnY4aWt1TGk2U0hlSlNwUUdoL3d4ZkpnZXEvaTJsaDRlRythRFVTbnIyUUlz?=
 =?utf-8?B?NmJKOWJkVm1lRVJNWnQyS2hFRUUzM0JGcWUwcytXOEpmWGxXeGY5M0xPKzdw?=
 =?utf-8?B?L1BwTjdoUUVqa0FmUkhMZXhsZytrYzczalR0MnNFalZGbFpFTGkxakNNcEIx?=
 =?utf-8?B?MEVVVE40MUdIZXVjQW90cWdaMkRZRlE0UHNwamRNWUphazlZbUl3WThHdHRQ?=
 =?utf-8?B?ZjZmSnpBbFc0L3Uya2ltd1didWJRTGN2RlJNRTB1OXpRODBmK3YvVEhlVkha?=
 =?utf-8?B?NHpjSHFlZjREck1wMUJvQW9qYzhOdFZ1YTBOL2F4c0NLeS9NbldaOHNuNE5C?=
 =?utf-8?Q?mTdfOOWMD/3UCbF4hr0ylIRty?=
X-OriginatorOrg: randorisec.fr
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5cc5b8-c5fb-4c01-fb94-08dd624be0cb
X-MS-Exchange-CrossTenant-AuthSource: MRXP264MB0246.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 16:26:59.0983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c1031ca0-4b69-4e1b-9ecb-9b3dcf99bc61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJ3L2C4wfpHQ0+SoXzxRSpDsH5sx0EHZqQ2pBqk8Jbz1q64XMqK3rF0KgC8dINBA31bvYNaAmSn74TXCnVZP6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB6297

The DSS and ADD_ADDR options should be exclusive and not send together.
The call to the mptcp_pm_add_addr_signal() function in the
mptcp_established_options_add_addr() function could modify opts->addr, 
thus also opts->ext_copy as they belong to distinguish entries of the 
same union field in mptcp_out_options. If the DSS option should not be 
dropped, the check if the DSS option has been previously established and 
thus if we should not establish the ADD_ADDR option is done after 
opts->addr (thus opts->ext_copy) has been modified.
This corruption may modify stream information send in the next packet
with invalid data.
Using an intermediate variable, prevents from corrupting previously
established DSS option. The assignment of the ADD_ADDR option
parameters in done once we are sure that the DSS option has been dropped
or it has not been established previously.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Fixes: 1bff1e43a30e ("mptcp: optimize out option generation")
Signed-off-by: Arthur Mongodin <amongodin@randorisec.fr>
---
  net/mptcp/options.c | 6 ++++--
  1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index fd2de185bc93..23949ae2a3a8 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -651,6 +651,7 @@ static bool 
mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
  	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
  	bool drop_other_suboptions = false;
  	unsigned int opt_size = *size;
+	struct mptcp_addr_info addr;
  	bool echo;
  	int len;

@@ -659,7 +660,7 @@ static bool 
mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
  	 */
  	if (!mptcp_pm_should_add_signal(msk) ||
  	    (opts->suboptions & (OPTION_MPTCP_MPJ_ACK | OPTION_MPTCP_MPC_ACK)) ||
-	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, &opts->addr,
+	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, &addr,
  		    &echo, &drop_other_suboptions))
  		return false;

@@ -672,7 +673,7 @@ static bool 
mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
  	else if (opts->suboptions & OPTION_MPTCP_DSS)
  		return false;

-	len = mptcp_add_addr_len(opts->addr.family, echo, !!opts->addr.port);
+	len = mptcp_add_addr_len(addr.family, echo, !!addr.port);
  	if (remaining < len)
  		return false;

@@ -689,6 +690,7 @@ static bool 
mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
  		opts->ahmac = 0;
  		*size -= opt_size;
  	}
+	opts->addr = addr;
  	opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
  	if (!echo) {
  		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDRTX);
-- 
2.47.2


