Return-Path: <netdev+bounces-269988-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEl1HpN/vWnH+QIAu9opvQ
	(envelope-from <netdev+bounces-269988-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:10:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E872DE52F
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04D1C3064E18
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E92D3876D1;
	Fri, 20 Mar 2026 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="pqb96bTh"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022077.outbound.protection.outlook.com [52.101.53.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFA0282F32;
	Fri, 20 Mar 2026 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025957; cv=fail; b=g/RL2YV7hsW3cf7OAFwQAQXN4gvADkMlQ/RBv5LmILuikO6uj2AcRMtM/DWU1wITegF8Xi087CBr+y3+lKfwXQ9mQrusbAFxgikYdqNA6nTEu3Hb813uqTBjX1zTiKZ/FaNexxH+XKMVsrF+pEaeVbUT7o7HVemz6HU+4rvWcfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025957; c=relaxed/simple;
	bh=TWcgviehPViXONqc5vXq8Irf2Z5ksqhO8eKCfgwyDv0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vmv2gjHOUIx9i18mtOl4hl6+c7aj92NiYq1nWl6rdknGlqTcaTjXwhklGSykN0hLwkavzFBG60y+DYlk0Pu/jMngpWQk6FXGQhgwSKmAwJ8S9piRpt2Ct5g5ohQZOe7g77LpI945VVua9ssDJ5Hb5Q8RvSFKXpuyYjdx23+E9+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=pqb96bTh reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.53.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abI+RJsMpRsZVRhR4o7nddvafkYlU2hpqknruRh1sza+I9peHR8iYZbq3BmVYHlNTBYHMrje5mPoYCJqMzL9aJBDiOuG08n0nAo4/Rx1nh1WqTV/5jBoxiTjEK1/WkQfT8kRamMQS3Sc6+ffdCL7f7qZ4ZtjTCrWOp3qBVSaghPdf3W0eCEKF5VP8AdqNrDUICF4VMRH+o5ZaahxzhMSB04gAJcDv/JZ/KRXXxyT8pxPECg4ndv1kwHGsLiZWsBFTFgW1zeeQkv/m4/ZPWlK6gCemIb+H/qVPB/lkHtIk9qhlohj1Oqpi3Q4/pegMAtKruGNDZZs/ibIBYRY1d/aew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/cEmsaUz8n1tAtguRIKXqWvA91rz35EWhHh6KIckZ4=;
 b=tyNu2EM9erA4f0H9oIZgWcyCXtkoaVsUUMeEHsZiWeDtMhujlaxSYkGlhg00mg/NmaQGNl9Y2GkWKdU0pD+URWp+uo4K6VKcwCejiCXKwuLg54kUFFUn5znARPRj9EM6ZAuTH7s1CqH+Qlqy3iOQl4kWvdtUJ/NEUDPTxeBEvE55LqMuXn9avNcySJlpnsOj1bliUWxm2+sc5Z8H9gvyezgip4m3x9NhlKIoC+/h8kjmwR7K4Yq5QKi8f1k1a7xVMXrEeYGfjHejpa3528HwYt1QW4aZFuYgv6SjIiEL71fD5QLdYpqBXcoTBojoaLA3OuYzw0gnbZnrr3CTFAsxnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/cEmsaUz8n1tAtguRIKXqWvA91rz35EWhHh6KIckZ4=;
 b=pqb96bThsYYjJPvz7cCYAjmqUvzWowAgqW+urZW+8cPucGHwM5WhFyerOlHqAtP4oe1GJNhtA9fZm5S4PxiudAnmdmypxmSSn4GASSCexdBFOSAuKrn34HAMXq83q5WeW1FZUH5Ity/mVhJxwDFpIuaodQk2vKYw1r3ahbk5iVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CH7PR01MB8978.prod.exchangelabs.com (2603:10b6:610:249::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.20; Fri, 20 Mar 2026 16:59:00 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9723.018; Fri, 20 Mar 2026
 16:59:09 +0000
Message-ID: <b0b0c9f2-d6c4-4cf8-b17e-76e73683484d@amperemail.onmicrosoft.com>
Date: Fri, 20 Mar 2026 12:59:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v34 1/1] mctp pcc: Implement MCTP over PCC Transport
To: Adam Young <admiyo@os.amperecomputing.com>,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20260317224309.645480-1-admiyo@os.amperecomputing.com>
 <20260317224309.645480-2-admiyo@os.amperecomputing.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20260317224309.645480-2-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR15CA0195.namprd15.prod.outlook.com
 (2603:10b6:930:82::11) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CH7PR01MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: 215e6f60-908c-4eac-8f4d-08de86a200a4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|55112099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	c2yPu82EtimSLesleDMypb9Iwi+KIyP7FEaqSMC793P2b9re5vCCTKaOjD0aZMRzTzO4uGHB8m0yQhNCNEk183SYQUUl7CWj6Z7Cp6R/N2CbIb3Fu8vwbtgfsChSs1Qy7IX1f/2mVedbzlo3SY1/8Yvp9wIFo7o6pc3KIw3cz3cVP4r2XUH4Jwly5nhxgTzXeQfJBddAnbsZZsybpZ5sWSM97dyuqSYJ2jx1YWbHrowd0phwgT8fB50SEfrubIkiuTOID/MIWIztf+VG7J9qG9VivmCx2NW15+DP3A8pOlSGIpWvU24QmLKQhWMeTjId5d98sng1eF2b1WB8bcluwZjMWn1FJMDsOxnhy98YGK2g/UGV81GGu5nfmx0mQ3Ir7Kkmr+bTzGHUG0TproclW3Ypx/Brsz7dsVMc1XdxsavgnX7VslfItMcbBo53nRi3gntV0n2U5Gn0o4yC6w4KppebczOOFVHrSEDK3iEtjWiOGtgwnTU0Qwpb/XyoIRu5pMhjRwLZubnn+dtdHllFqMzhbQg4VtKRTwfGqHmWq2WMkDxaOxCpSSBTC/OaiBeuyOXcXYyIUXn75LJFOqv8T0aKL3Jvq32bOpX1eMfhuULL59kpD8d+boi+YaKW87TNCVVwF+ObepajGf6ybxNJQxH0cyVhvloBElHs1b2/f+43cS1ep033FxRHbdRZGVsH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(55112099003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkpQbms4MDcyNlc0Z3lJYmNwOWQ0UUw4TU5pRnE0Y1dZQjkyMmlPdkJOTURj?=
 =?utf-8?B?akhidWk5TE1rRDhJemR1Nlk1OFNDbk9KVzNQUVpTOVlKRGZXMnNFVjM1YWVk?=
 =?utf-8?B?S3dXWXlWRSt0K1B6Mk5mbmE0VUIrVU9kRUNqeFVxQUQ2N1pEU0RzVGpDTUFk?=
 =?utf-8?B?MVdFRjFScWdKcWE3N1hNMVhlV012djhuanFmZmFYTjN0cDQzV2dkRUY5bEU1?=
 =?utf-8?B?amxKZW5RY0Rwb0RpdDVvYjh2Z0NkYU9Ba0Y0S0hPWFltQVJ1b2paNWwvZXZz?=
 =?utf-8?B?MGhYRldIV3hlQU9HalU2WUR4MVNQWEpQQWFXbEZIT0FlTmlRc3pDYmU1aDVU?=
 =?utf-8?B?bENMbFl2b01CRy9CWEF1dFd0UGl6UFlLalZLbDcrT1FYb1hEVkxKTGdmdmtY?=
 =?utf-8?B?aDFPN1N3RVFoWTVLSzhFYkdYTkVTak1ENjBQY1hoNFg1ZXRZMFM2bzQybWQ4?=
 =?utf-8?B?dE10a3R4M2dxWUlJVGt4MjVpSStrdFBlTEUzenVWR0ZrdGluUFJIWENpb3p5?=
 =?utf-8?B?MjdKYkFyQ1IwSXZEREowVjdrcFVsMGFUNnlNUkxYSEkybHRGajdET3htbGV0?=
 =?utf-8?B?Z3V5eEdEUThnd21XZjAzQzF6bnFINm9TZ1FTdFh3OXhGOUlyTXQzTFVxU1J4?=
 =?utf-8?B?ck9nTk1aS2V0RmVMKzBuOUs4UmJDQlVENXJjbU1kZWdrUkk2NmxvZjNpcnZ3?=
 =?utf-8?B?R0x0THdiZmhVU3BBakJya09xMTU3aStOTG1UOWZsYXNOYmE2K2dHSmgrWmRv?=
 =?utf-8?B?dHpqMTcwUElpYSt3SklqcEtDNWVqeEg3S1hYNGJMRVkrMG5nVmJNQ2dyR0NM?=
 =?utf-8?B?MFR4elp0VDJXTE9hb1k0ZFZQNXJHRUNoUmhCSlY1MG9PbW1SR1F1VWkvYnlB?=
 =?utf-8?B?a1NXYVJjK3lhVkVvc3EyL1lOaW13ajhSN0FrUXpva2J3di9CWXdDZjdWYkNB?=
 =?utf-8?B?aG9WQVRrNW9uNFFwbEliK3NRa0s3cklFZVplQlZwcjhIT0pTYjUySkhUZC9Z?=
 =?utf-8?B?OUc2ZjNmcEFCbXIxb2J6LzBIYnNtZXVQYnhaWFVwSlNXSGxUdnQwd21nbUNi?=
 =?utf-8?B?Y0dHZDM0Zzh2QWVqVUFiYXRscmpGZzZKaGpUdENCNlgvYVdQYjd6KzN6R3dW?=
 =?utf-8?B?aUVpN3k2WUsxNS82NkNDbkZSZHpoUG8zeVRZK3VKdno4SnlmKzZyOUtWTFJq?=
 =?utf-8?B?anFEVVNJRGZEMTV2Ukt3NUhnSGdMaTB5Vm9wRTQzbk5rd2d4TTZEQkZ3Q3dQ?=
 =?utf-8?B?VnF3bUdOZllqTXRJUmJORE1wWkdmTzM1YW1uQTBoWDRjS3VJdWZSVUxxOGNO?=
 =?utf-8?B?LzI1SVpFT204YXFtK2c0NkZwNnZ0N2xoUGpraHpTNkxkMjgrbytrY0M3UDdz?=
 =?utf-8?B?ZWhXREN5bmFaN1RScDAvMXVSeG5GdkhuZFFWUjRXV3BIRUU4VE4xckpza3N6?=
 =?utf-8?B?WkQvdm1zWUkrMFRrVUg2OVFrUTlvc2tUVXdXRzNqdTJKN1l2bStYN0pXU3My?=
 =?utf-8?B?N2dDbkw3dWxnOEhCYVdtNGJlNE5wTC9EYUNES3VDRlpteGtlenlEd0drY1Vv?=
 =?utf-8?B?K243SDVUTHFaa0MzeXFrZTR0V3kzVlgxZ0drbzFockY2RVNONXpQTHNvUW82?=
 =?utf-8?B?QVByaWJXVTF3bHpYN2FlT3VTcS8rVTBiV3NuWW5RVEJmZTMzTnphVGcyUWxJ?=
 =?utf-8?B?Qnlob29VcERicUY1QjdKRXVGdVB5R0c4U3lwYXVpTDIwZHllOGFuSmRUY05D?=
 =?utf-8?B?d29HWjB4TFpRenlaekp4Z0ZEV0ltTk9sNWxpOUxBazZXZXFmc010ZkI1N1Bp?=
 =?utf-8?B?VEt6QmJLT2hDeDVWYmRNR2JtenBiVDI2ZTUwNHZRT0VNTHNuQ1dmelg3Ymhv?=
 =?utf-8?B?R0s5dHBVOFRHR3grZG9lZU5NTEJCOFhGR1NnWmtWVDNjd3p6L29kbWprZHEx?=
 =?utf-8?B?clJ5VDVOSmFBNjJjM2lrdnN5Z3BtOFgzUExpK3p6K3l5Ly9GQkNmSGlhTHhS?=
 =?utf-8?B?cVhIRFduZ3F2UFBxL0x5NFVNdW9VYysvUnM1YlprNmxFbm1VV0x3Q0NWTG8x?=
 =?utf-8?B?emxsbkdwWUp0WkdUWEc5WXJldFZreWFJY05BRWRoYWROUjd4WCs2UXlEYUhS?=
 =?utf-8?B?MVR0OThIbTJWZmdaaFA1dFdzTEVtNyt3dWVLL3gxcUFhanpmd1RrSE9aRmFP?=
 =?utf-8?B?aUtuZEQxNXJZTVlDTXBIRS9UQmhidG5qaEFsN3lDdmNiN3o0b3NxblAxYU0r?=
 =?utf-8?B?ZzVkaHVsMXAzdXBNTGJQTWNQSEcvYnZqK1dvOTNUc3ZPMmNCRTFTTDFYcVJp?=
 =?utf-8?B?aW1tZWVoUHI5Z2Zwc3RYSFhqcmNoM0tOalIrVU1uVHQ0dEMrdXprTXlqOWI4?=
 =?utf-8?Q?FwzmDuBcWGvRyY9l4sLkuXP9bpcKIEe6tclkxpJVYG6Mb?=
X-MS-Exchange-AntiSpam-MessageData-1:
	vQaB4/tlDNoZ2n3AWGFRmoFtPwrQHzLdN0JeCIOXmUQMF/mPVU6xNrP0
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 215e6f60-908c-4eac-8f4d-08de86a200a4
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 16:59:08.8986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fgyFO6YWQFEP/LFUfoWzTCw/cT28FOQcl6UwHuToK1W4356aax6gz0u/5stwbZRvHJ1lbvLSiP2r+7cZLt/2V+QqzL4GUf5kobRlRzQNXVsazmnhMCfARGKn5Jrb6PiL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR01MB8978
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269988-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	DMARC_NA(0.00)[onmicrosoft.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	NEURAL_SPAM(0.00)[0.909];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,dmtf.org:url,amperemail.onmicrosoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amperecomputing.com:email]
X-Rspamd-Queue-Id: 21E872DE52F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I just discovered a flaw in this implementation.  Withdrawing it from 
consideration.

On 3/17/26 18:43, Adam Young wrote:
> Implementation of network driver for
> Management Component Transport Protocol(MCTP)
> over Platform Communication Channel(PCC)
>
> DMTF DSP:0292
> https://www.dmtf.org/sites/default/files/standards/documents/\
> DSP0292_1.0.0WIP50.pdf
>
> MCTP devices are specified via ACPI by entries in DSDT/SSDT and
> reference channels specified in the PCCT. Messages are sent on a type
> 3 and received on a type 4 channel.  Communication with other devices
> use the PCC based doorbell mechanism; a shared memory segment with a
> corresponding interrupt and a memory register used to trigger remote
> interrupts.
>
> Unlike the existing PCC Type 2 based drivers, the mssg parameter to
> mbox_send_msg is actively used. The data section of the struct sk_buff
> that contains the outgoing packet is sent to the mailbox, already
> properly formatted as a PCC exctended message.
>
> If the mailbox ring buffer is full, the driver stops the incoming
> packet queues until a message has been sent, freeing space in the
> ring buffer.
>
> When the Type 3 channel outbox receives a txdone response interrupt,
> it consumes the outgoing sk_buff, allowing it to be freed.
>
> Bringing up an interface creates the channel between the network driver
> and the mailbox driver. This enables communication with the remote
> endpoint, to include the receipt of new messages. Bringing down an
> interface removes the channel, and no new messages can be delivered.
> Stopping the interface also frees any packets that are cached in the
> mailbox ringbuffer.
>
> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
>
> change 1:  size may be negative
> change 2: use constant for checking MCTP signature
> change 3: put PCC data into the skb
> ---
>   MAINTAINERS                 |   5 +
>   drivers/net/mctp/Kconfig    |  13 ++
>   drivers/net/mctp/Makefile   |   1 +
>   drivers/net/mctp/mctp-pcc.c | 366 ++++++++++++++++++++++++++++++++++++
>   4 files changed, 385 insertions(+)
>   create mode 100644 drivers/net/mctp/mctp-pcc.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ff6f17458f19..43bc37f859d6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15288,6 +15288,11 @@ F:	include/net/mctpdevice.h
>   F:	include/net/netns/mctp.h
>   F:	net/mctp/
>   
> +MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP) over PCC (MCTP-PCC) Driver
> +M:	Adam Young <admiyo@os.amperecomputing.com>
> +S:	Maintained
> +F:	drivers/net/mctp/mctp-pcc.c
> +
>   MAPLE TREE
>   M:	Liam R. Howlett <Liam.Howlett@oracle.com>
>   R:	Alice Ryhl <aliceryhl@google.com>
> diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
> index cf325ab0b1ef..77cd4091050c 100644
> --- a/drivers/net/mctp/Kconfig
> +++ b/drivers/net/mctp/Kconfig
> @@ -47,6 +47,19 @@ config MCTP_TRANSPORT_I3C
>   	  A MCTP protocol network device is created for each I3C bus
>   	  having a "mctp-controller" devicetree property.
>   
> +config MCTP_TRANSPORT_PCC
> +	tristate "MCTP PCC transport"
> +	depends on ACPI
> +	help
> +	  Provides a driver to access MCTP devices over PCC transport,
> +	  A MCTP protocol network device is created via ACPI for each
> +	  entry in the DSDT/SSDT that matches the identifier. The Platform
> +	  communication channels are selected from the corresponding
> +	  entries in the PCCT.
> +
> +	  Say y here if you need to connect to MCTP endpoints over PCC. To
> +	  compile as a module, use m; the module will be called mctp-pcc.
> +
>   config MCTP_TRANSPORT_USB
>   	tristate "MCTP USB transport"
>   	depends on USB
> diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
> index c36006849a1e..0a591299ffa9 100644
> --- a/drivers/net/mctp/Makefile
> +++ b/drivers/net/mctp/Makefile
> @@ -1,4 +1,5 @@
>   obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
>   obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
>   obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
> +obj-$(CONFIG_MCTP_TRANSPORT_PCC) += mctp-pcc.o
>   obj-$(CONFIG_MCTP_TRANSPORT_USB) += mctp-usb.o
> diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
> new file mode 100644
> index 000000000000..f8d620795349
> --- /dev/null
> +++ b/drivers/net/mctp/mctp-pcc.c
> @@ -0,0 +1,366 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * mctp-pcc.c - Driver for MCTP over PCC.
> + * Copyright (c) 2024-2026, Ampere Computing LLC
> + *
> + */
> +
> +/* Implementation of MCTP over PCC DMTF Specification DSP0256
> + * https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/hrtimer.h>
> +#include <linux/if_arp.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/platform_device.h>
> +#include <linux/skbuff.h>
> +#include <linux/string.h>
> +
> +#include <acpi/acpi_bus.h>
> +#include <acpi/acpi_drivers.h>
> +#include <acpi/acrestyp.h>
> +#include <acpi/actbl.h>
> +#include <acpi/pcc.h>
> +#include <net/mctp.h>
> +#include <net/mctpdevice.h>
> +
> +#define MCTP_SIGNATURE          "MCTP"
> +#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
> +#define MCTP_MIN_MTU            68
> +#define PCC_DWORD_TYPE          0x0c
> +
> +struct mctp_pcc_mailbox {
> +	u32 index;
> +	struct pcc_mbox_chan *chan;
> +	struct mbox_client client;
> +};
> +
> +/* The netdev structure. One of these per PCC adapter. */
> +struct mctp_pcc_ndev {
> +	struct net_device *ndev;
> +	struct acpi_device *acpi_device;
> +	struct mctp_pcc_mailbox inbox;
> +	struct mctp_pcc_mailbox outbox;
> +};
> +
> +/**
> + * mbox_write_to_buffer - copy the contents of the data
> + * pointer to the shared buffer.  Confirms that the command
> + * flag has been set prior to writing.  Data should be a
> + * properly formatted extended data buffer.
> + * pcc_mbox_write_to_buffer
> + * @pchan: channel
> + * @len: Length of the overall buffer passed in, including the
> + *       Entire header. The length value in the shared buffer header
> + *       Will be calculated from len.
> + * @data: Client specific data to be written to the shared buffer.
> + * Return: number of bytes written to the buffer.
> + */
> +static int mbox_write_to_buffer(struct pcc_mbox_chan *pchan, int len, void *data)
> +{
> +	struct acpi_pcct_ext_pcc_shared_memory *pcc_header = data;
> +	/*
> +	 * The PCC header length includes the command field
> +	 * but not the other values from the header.
> +	 */
> +	pcc_header->length = len - sizeof(struct acpi_pcct_ext_pcc_shared_memory) + sizeof(u32);
> +
> +	if (len > pchan->shmem_size)
> +		return 0;
> +
> +	memcpy_toio(pchan->shmem,  data, len);
> +
> +	return len;
> +}
> +
> +static void mctp_pcc_client_rx_callback(struct mbox_client *cl, void *mssg)
> +{
> +	struct acpi_pcct_ext_pcc_shared_memory pcc_header;
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct mctp_pcc_mailbox *inbox;
> +	struct mctp_skb_cb *cb;
> +	struct sk_buff *skb;
> +	int size;
> +
> +	mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, inbox.client);
> +	inbox = &mctp_pcc_ndev->inbox;
> +	memcpy_fromio(&pcc_header, inbox->chan->shmem, sizeof(pcc_header));
> +	size = pcc_header.length - sizeof(pcc_header.command) + sizeof(pcc_header);
> +
> +	if (size <= sizeof(pcc_header)) {
> +		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
> +		return;
> +	}
> +	if (memcmp(&pcc_header.command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH) != 0) {
> +		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
> +		return;
> +	}
> +
> +	if (size > mctp_pcc_ndev->ndev->mtu)
> +		dev_dbg(cl->dev, "MCTP_PCC bytes available exceeds MTU");
> +
> +	skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
> +	if (!skb) {
> +		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
> +		return;
> +	}
> +	skb_put(skb, size);
> +	skb->protocol = htons(ETH_P_MCTP);
> +	memcpy_fromio(skb->data, inbox->chan->shmem, size);
> +	dev_dstats_rx_add(mctp_pcc_ndev->ndev, size);
> +	skb_pull(skb, sizeof(pcc_header));
> +	skb_reset_mac_header(skb);
> +	skb_reset_network_header(skb);
> +	cb = __mctp_cb(skb);
> +	cb->halen = 0;
> +	netif_rx(skb);
> +}
> +
> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
> +{
> +	struct acpi_pcct_ext_pcc_shared_memory *pcc_header;
> +	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
> +	int len = skb->len;
> +	int rc;
> +
> +	rc = skb_cow_head(skb, sizeof(*pcc_header));
> +	if (rc) {
> +		dev_dstats_tx_dropped(ndev);
> +		kfree_skb(skb);
> +		return NETDEV_TX_OK;
> +	}
> +
> +	pcc_header = skb_push(skb, sizeof(*pcc_header));
> +	pcc_header->signature = PCC_SIGNATURE | mpnd->outbox.index;
> +	pcc_header->flags = PCC_CMD_COMPLETION_NOTIFY;
> +	memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
> +	pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
> +
> +	rc = mbox_send_message(mpnd->outbox.chan->mchan, skb);
> +	if (rc < 0) {
> +		//Remove the header in case it gets sent again
> +		skb_pull(skb, sizeof(*pcc_header));
> +		netif_stop_queue(ndev);
> +		return NETDEV_TX_BUSY;
> +	}
> +
> +	return NETDEV_TX_OK;
> +}
> +
> +static void mctp_pcc_tx_prepare(struct mbox_client *cl, void *mssg)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct mctp_pcc_mailbox *outbox;
> +	struct sk_buff *skb = mssg;
> +	int len_sent;
> +
> +	mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, outbox.client);
> +	outbox = &mctp_pcc_ndev->outbox;
> +
> +	if (!skb)
> +		return;
> +
> +	len_sent = mbox_write_to_buffer(outbox->chan, skb->len, skb->data);
> +	if (len_sent == 0)
> +		dev_dstats_tx_dropped(mctp_pcc_ndev->ndev);
> +	else
> +		dev_dstats_tx_add(mctp_pcc_ndev->ndev, len_sent);
> +}
> +
> +static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int r)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct sk_buff *skb = mssg;
> +
> +	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, outbox.client);
> +	dev_consume_skb_any(skb);
> +	netif_wake_queue(mctp_pcc_ndev->ndev);
> +}
> +
> +static int mctp_pcc_ndo_open(struct net_device *ndev)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
> +	struct mctp_pcc_mailbox *outbox, *inbox;
> +
> +	outbox = &mctp_pcc_ndev->outbox;
> +	inbox = &mctp_pcc_ndev->inbox;
> +
> +	outbox->chan = pcc_mbox_request_channel(&outbox->client, outbox->index);
> +	if (IS_ERR(outbox->chan))
> +		return PTR_ERR(outbox->chan);
> +
> +	inbox->client.rx_callback = mctp_pcc_client_rx_callback;
> +	inbox->chan = pcc_mbox_request_channel(&inbox->client, inbox->index);
> +	if (IS_ERR(inbox->chan)) {
> +		pcc_mbox_free_channel(outbox->chan);
> +		return PTR_ERR(inbox->chan);
> +	}
> +	return 0;
> +}
> +
> +static int mctp_pcc_ndo_stop(struct net_device *ndev)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
> +
> +	pcc_mbox_free_channel(mctp_pcc_ndev->outbox.chan);
> +	pcc_mbox_free_channel(mctp_pcc_ndev->inbox.chan);
> +	return 0;
> +}
> +
> +static const struct net_device_ops mctp_pcc_netdev_ops = {
> +	.ndo_open = mctp_pcc_ndo_open,
> +	.ndo_stop = mctp_pcc_ndo_stop,
> +	.ndo_start_xmit = mctp_pcc_tx,
> +};
> +
> +static void mctp_pcc_setup(struct net_device *ndev)
> +{
> +	ndev->type = ARPHRD_MCTP;
> +	ndev->hard_header_len = sizeof(struct acpi_pcct_ext_pcc_shared_memory);
> +	ndev->tx_queue_len = 0;
> +	ndev->flags = IFF_NOARP;
> +	ndev->netdev_ops = &mctp_pcc_netdev_ops;
> +	ndev->needs_free_netdev = true;
> +	ndev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
> +}
> +
> +struct mctp_pcc_lookup_context {
> +	int index;
> +	u32 inbox_index;
> +	u32 outbox_index;
> +};
> +
> +static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
> +				       void *context)
> +{
> +	struct mctp_pcc_lookup_context *luc = context;
> +	struct acpi_resource_address32 *addr;
> +
> +	if (ares->type != PCC_DWORD_TYPE)
> +		return AE_OK;
> +
> +	addr = ACPI_CAST_PTR(struct acpi_resource_address32, &ares->data);
> +	switch (luc->index) {
> +	case 0:
> +		luc->outbox_index = addr[0].address.minimum;
> +		break;
> +	case 1:
> +		luc->inbox_index = addr[0].address.minimum;
> +		break;
> +	}
> +	luc->index++;
> +	return AE_OK;
> +}
> +
> +static void mctp_cleanup_netdev(void *data)
> +{
> +	struct net_device *ndev = data;
> +
> +	mctp_unregister_netdev(ndev);
> +}
> +
> +static int initialize_MTU(struct net_device *ndev)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct mctp_pcc_mailbox *outbox;
> +	struct pcc_mbox_chan *pchan;
> +	int mctp_pcc_mtu;
> +
> +	mctp_pcc_mtu = MCTP_MIN_MTU;
> +	mctp_pcc_ndev = netdev_priv(ndev);
> +	outbox = &mctp_pcc_ndev->outbox;
> +	pchan = pcc_mbox_request_channel(&outbox->client, outbox->index);
> +	if (IS_ERR(pchan))
> +		return -1;
> +
> +	mctp_pcc_mtu = pchan->shmem_size;
> +	pcc_mbox_free_channel(pchan);
> +
> +	mctp_pcc_mtu = mctp_pcc_mtu - sizeof(struct acpi_pcct_ext_pcc_shared_memory);
> +	ndev->mtu = MCTP_MIN_MTU;
> +	ndev->max_mtu = mctp_pcc_mtu;
> +	ndev->min_mtu = MCTP_MIN_MTU;
> +
> +	return 0;
> +}
> +
> +static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
> +{
> +	struct mctp_pcc_lookup_context context = {0};
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct device *dev = &acpi_dev->dev;
> +	struct net_device *ndev;
> +	acpi_handle dev_handle;
> +	acpi_status status;
> +	char name[32];
> +	int rc;
> +
> +	dev_dbg(dev, "Adding mctp_pcc device for HID %s\n",
> +		acpi_device_hid(acpi_dev));
> +	dev_handle = acpi_device_handle(acpi_dev);
> +	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
> +				     &context);
> +	if (!ACPI_SUCCESS(status)) {
> +		dev_err(dev, "FAILED to lookup PCC indexes from CRS\n");
> +		return -EINVAL;
> +	}
> +
> +	snprintf(name, sizeof(name), "mctppcc%d", context.inbox_index);
> +	ndev = alloc_netdev(sizeof(*mctp_pcc_ndev), name, NET_NAME_PREDICTABLE,
> +			    mctp_pcc_setup);
> +	if (!ndev)
> +		return -ENOMEM;
> +
> +	mctp_pcc_ndev = netdev_priv(ndev);
> +
> +	mctp_pcc_ndev->inbox.index = context.inbox_index;
> +	mctp_pcc_ndev->inbox.client.dev = dev;
> +	mctp_pcc_ndev->outbox.index = context.outbox_index;
> +	mctp_pcc_ndev->outbox.client.dev = dev;
> +
> +	mctp_pcc_ndev->outbox.client.tx_prepare = mctp_pcc_tx_prepare;
> +	mctp_pcc_ndev->outbox.client.tx_done = mctp_pcc_tx_done;
> +	mctp_pcc_ndev->acpi_device = acpi_dev;
> +	mctp_pcc_ndev->ndev = ndev;
> +	acpi_dev->driver_data = mctp_pcc_ndev;
> +
> +	rc = initialize_MTU(ndev);
> +	if (rc)
> +		goto free_netdev;
> +
> +	rc = mctp_register_netdev(ndev, NULL, MCTP_PHYS_BINDING_PCC);
> +	if (rc)
> +		goto free_netdev;
> +
> +	return devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
> +free_netdev:
> +	free_netdev(ndev);
> +	return rc;
> +}
> +
> +static const struct acpi_device_id mctp_pcc_device_ids[] = {
> +	{ "DMT0001" },
> +	{}
> +};
> +
> +static struct acpi_driver mctp_pcc_driver = {
> +	.name = "mctp_pcc",
> +	.class = "Unknown",
> +	.ids = mctp_pcc_device_ids,
> +	.ops = {
> +		.add = mctp_pcc_driver_add,
> +	},
> +};
> +
> +module_acpi_driver(mctp_pcc_driver);
> +
> +MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
> +
> +MODULE_DESCRIPTION("MCTP PCC ACPI device");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");

