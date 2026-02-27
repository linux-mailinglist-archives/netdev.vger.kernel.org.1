Return-Path: <netdev+bounces-261938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JDyGI7ZoWlcwgQAu9opvQ
	(envelope-from <netdev+bounces-261938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 18:51:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A77E11BBA1E
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 18:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B623312CBA8
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 17:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD323612E6;
	Fri, 27 Feb 2026 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="f+URTy1K"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020082.outbound.protection.outlook.com [52.101.201.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ED0348479;
	Fri, 27 Feb 2026 17:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772214474; cv=fail; b=ok3y7XJkTrnkzCOviQapHbr++N9ni7acAHRJ3P5l0Yl/66H9tDzJa74oKNvdpNh5F7rus2KfZWSivxQ8igru7YHeMkOu+ZyF+LgxCTUHMuYPMkU0XjxUq/5XLNvG0PLiclAkJFLB/yEZebJYKRmN+sncDsT1qMAvq27cyxaG+V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772214474; c=relaxed/simple;
	bh=TwdSeForohRj5WPwsvx+OyODPAjFd0PUYJmr6c/57BY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wfu0CAx/ZVRGZMW1Ke32vTElia6fL17SGIohuF1/ye+NYWBmn0duWKrS+J+rljHBg0z+Xv0AXlIa/KDnGLhOZeaFTStPOLO4X9zBeGTtOHfWoE/aqiPsb6XMkbEyWsh6VFw9TqacyGNz4GIIpKRifftjWKIEHYaxGjoQfXlbczc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=f+URTy1K reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.201.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXwB4zYTzxtnaLydverNFvIZxjgWusuQt/4+r+RwmaaZR78Dsu5wR+FLrxbSHR9t4A1m/QMNAr5ejzb02WveN7kjKtgJkdWW8urGux3Csvc/KZwsVUq0mZIeZnle9UAxaUzms0fJdnXT7y+SRn7kPjJgSN0L4afpBSV4J70CzJtagaaONUhclklabr7Kobb0QTaq2RDRCTzqxhMUkpmZclUjsgUQxBSU+Mo/HlHq4g5rZGajeRBZBhL/teonRgmkCtwkgrAvPGnc7Qp4gCpgPVdDrNj4rGYZ/44eicuNzly/AtHVZpNJXGA06jVZjMDHSWeNLjAW67DU1l9jBKqwug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyM0E6WXmEKSLMqV+MGRibYLiQOp4R4XLLgOpwqQExw=;
 b=LZr1QBJz3OADc2L38u/C67bAnpOel10eavNetRn/icsuF4sohsJ9IFMcDovVErOGuGgTfJmg5K1fU5RuBcQkQTurYCZ0uZS0CyOPrPcTEVIbkvE7hYjY4LQ1tOtR4+IiOn40UCZJjopeGHIiLzJJeqCV2/owiRJGQ2/9m2osMmIYMkWPV59xkhLphSqTHKAcT34N450rubs+ZF1qo2TqVz2cqK1HVu+HO1QS3YndBbb6WHiNW432/rhvTCo7uRc1tJIBzkkykFkSm73Rl2R8TPB8Zu3gHCFoiZzE2YKzMNkG093S2qFH8RMKX1yEuUKXkIXdf7kc8yTig7l00w4GFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyM0E6WXmEKSLMqV+MGRibYLiQOp4R4XLLgOpwqQExw=;
 b=f+URTy1KtEVvsEd7tjQthaQxkNzAteafCCwzJB53iF+dIvwtJB+2VqMmM8+qxuL32MPYsJyNMfJpIyKgf3rUxyhpkpIZKCB11SWhnmjOe0i30ei85TyCCSg/vJ9karjsDjt5lZwyeW6AvCTM3xM7+urDWghjAEuGBv05w5vBx84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CO1PR01MB7339.prod.exchangelabs.com (2603:10b6:303:156::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.14; Fri, 27 Feb 2026 17:47:46 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 17:47:44 +0000
Message-ID: <4382aa4f-cc67-4813-a79e-f77f103d5ab7@amperemail.onmicrosoft.com>
Date: Fri, 27 Feb 2026 12:47:38 -0500
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
X-ClientProxiedBy: BY1P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::9) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CO1PR01MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ff1497-cbbc-44a6-0bda-08de76284ff5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	qRgbAsp5sUxZl3XEiRA1mw+kgg+x+IZmW3W53zco/r1na5EMtt5VKDqWhkeoOaZc7vdSnPwMuU/1Ao746yKNL2ocFN0HlNC2xkXJPITA4fA1yJKUyAusQM78kVGB/acHee6LW/b/Si7h6AzbkmKlqLqraUgBxNF+dxCJcXNif29BWaddtRazk8cDywTqY83NK16JaSVy7tBqKXx+FqHffGxjrVS81lc1ILI4XfgYBz8IWZAw70MDlshHjMtgPfmgTqjqs0QyFtkyhm4jfUXZ7cF/eLjnGDiYgJUiBuOvveVtZLw4BRf7z7O4H01AaLeFt29BmunA2HLkaa0H3wE7XE1LBunABEzKECtS/8v0LWT+31CSGz1XJYsz9xcqWccLf+UaNcBtcpXOieCfYMXMEHZgTbMnDQOoe5hcxpR6vqlt9hEWpcf1Ms1831+q7YB4msTq2nYO3cCdelxOvwgbKyBzKOUl8Uhxt++eXTZcSUw9XocxhMg7OI1aQ0/x8wUz8A3cYeFS95K+8sI4CsdNukuogBYfIEpsxfHYaivzwmND4l0zgbNszUxubgS7TMRbOo++2v0l1yMML7CIqUpGZRIOx8SzWoFjcN+XZPzlmIey2Tkj3ASov3qa8yj6R4+pMK9cDnRBj+45kgoCft2fyi0tmDlnWdyCsC+2c03YdOFt7bJCL6Gvx2CzTqVU+dL85p4u+mWAngpg2dFBL5uglFA4+hoRljFJnr1EGPP96fM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXZGdGxXVGdNMHZJdmtYT1o4Y0owc1puRlJ5T2FlNmxHSW1jbFNCbVdXRkNT?=
 =?utf-8?B?WkZEQmFLZTk5WC9zLzRMRmhGbEdWQmliOXJTY2lRM1cvWVB0RVp0bis1N0Zn?=
 =?utf-8?B?d2oyWGFnMWlHdXcyaEg2Q2x4a2haWHNqZUs4NHRiMGUrd2piV3BWOWQyVUZ1?=
 =?utf-8?B?WnJWa1l0dExHeVA0RFhFWnpXS1p5QWxDTWFZQmZhWXRYMG5DcG1GZTlDbDZy?=
 =?utf-8?B?d0N6T29tMHE3dXVUSXBTZzV0QkQ3WkZuTWhRNTl2Qis3aEs3c1NIdnlwaUo2?=
 =?utf-8?B?OFBudkFwOVJycENxTnh5VU5odHdxTU1iNzVnWUJSZGtVUTFqcDRaOTA1SlQw?=
 =?utf-8?B?OHl3U2luN0plNWxYNGUzRjRLT0ZRYi95Ykgxa2tQZGltTFh4UlluRG9XY2dr?=
 =?utf-8?B?TGdsWlFiMFFReldNV3UrQ3hhQ0lSYUxhZkpqNExNNHE2bDJoS0NCVUZDeFUr?=
 =?utf-8?B?dmU5YkF5ZzBFNCt3YzRYaWZGUlpyODVwRzlxZnlYQ3dnYUpWaG9WVGsva0xk?=
 =?utf-8?B?dXhRdDRUMDBaZlRSU0tBZHlLbkNqUnJlM1o3TmtycnRyelJlVDJneStHZlRU?=
 =?utf-8?B?ejdXMlVIOTl2TitSU2tkZWtSVUxueEdEYzQ0RHNHY0pBb215ZjN3QWduNzhX?=
 =?utf-8?B?a01RWlgxSHUxMzdrNmpHWHBLY21sbE12UzlzM3pkNlV4ZTNDbFpzN0lqVXE3?=
 =?utf-8?B?QUdINENNa2srZFNPVjZJSyt1QUdrOW4xNkx6aThEckNDSkU5YkJHVDlYNldY?=
 =?utf-8?B?dzFyZ05zaWlWY1JFVm1EemU5Wjhwd2E3NE1aMUhacnRnMnBuWkU5QmdDaVcz?=
 =?utf-8?B?WHptT3BHQ2IvdTJrQ1R5M01MSGg4YUZLVzlvREFlT2p2NFFNL21pc2FESW40?=
 =?utf-8?B?aVhmcGRwSWFSZGRIRWs1VEhOWjlYQnpDbDZsRG8xbWkrNHR6TXRXOUNTZUJB?=
 =?utf-8?B?QUdiYlZXWmd4Ty95SHBPRmFiSzl3U3ZaalBmZUI5RENLb24rbHhCbjFPRFc4?=
 =?utf-8?B?WFhEWXVKWVUrYVhTK2VZR1hjcW1VYm9FYWpwRit1c2dOamtwT1oyRDZCQWtF?=
 =?utf-8?B?akVlaTRpNTF4MFV6eVplSkJOc0NSd2o2ZDVMNzFlV2V6bkNjRDFSbWd1QUtB?=
 =?utf-8?B?b2p5Uk80bEN4d1pwRGlEMWVVSEdSSlozOXU5NDEwZnVXSkNSL3dwditrMVBt?=
 =?utf-8?B?M0x2UENtZFFPaFZHNXkwUjZETlNlWkpVN0oyc1dWMG9Kdll1REJMQnpXc1Vt?=
 =?utf-8?B?ZmRmZytNcTdUclpTOVVGT3ZtUitBRlBPL0dPNGsvQjJBaUFSNFY5WlFSRzhZ?=
 =?utf-8?B?RSswbUl1Nkh0Q01JWVFNc2wycHBCS2U5bHZNN3JwTkNCSDBaS1o4R0hJZ2du?=
 =?utf-8?B?bVY0cGo4MEs1UnhqbWxFZStHOVB2bEtkaFlEWEUzcFpoODl6SHhGNVJzNXF2?=
 =?utf-8?B?azZIWUcxc1hrYytmazlqazA1YmtkRWdQS08xVll0N3FGanN5RWlCUjZsWXVD?=
 =?utf-8?B?RzkzaHBDM2dqL2FPOUJsRW5qckplanJ3TThCVXExb044cTJ2OVNmS3A1ck5L?=
 =?utf-8?B?QzdsdDJVbVFudDlzeVk0UHJMejYvYlYySUphZlB2eVlBc09iaVdiQ3RjYk1v?=
 =?utf-8?B?Q3UyYXVMUUowV3dTUDQza0JMTS9wUGhlQ0dRMHlWQkFoeEtUZDFUQzNIQnFQ?=
 =?utf-8?B?MEdWd002NFBlNEZUUmZrWXRjTWE1a3EzcExROWh6YjhVZU9qdFYwdzlhaHJW?=
 =?utf-8?B?WEUwWDZLYjFReHJYZWVqK2V1Rnd1WjBPdzdlVE5LbE5ablF3Q1lyQnVtV1R6?=
 =?utf-8?B?SXppYXRmN2pTN29QUWxDSnR2QWl1YStKRVYvWXZiaG13NGZBSFMvQWRocnlL?=
 =?utf-8?B?TlBtTmNMTmppMCtVWDJnNkM1NVV3ME1IUFFkQzNRdUNSU0s0TDQ1OGZ0TFFC?=
 =?utf-8?B?Vk9OcWNvS21DdVlqckxYMXZRWS9IUm9lNEdqbWNwSzM4WStXOUUwRWVMODI1?=
 =?utf-8?B?eGtadnd1c0xBbUxQV3RkS2lSR3dxdDY2ZEl6ZU9qRXVGMUZCK2tqS2t6YUJM?=
 =?utf-8?B?NWY4QUJDcmJ0c2JBV1ZQSGJYZ2dTUmk3ZXJ5QmVXYU1CbmVlTkVSNDU1dkE1?=
 =?utf-8?B?QlhwNkJSQ1B5dGdIb0RUd3JMSTB4MUdjMGNVNVFSUTQ5NktvbHgzalJPU29H?=
 =?utf-8?B?bkhySVdiV0lDWVhvRTBQRkhxU2hoN0RqRGVOdk82bWFENW5LcjR3Y1ZES1ds?=
 =?utf-8?B?ZEpsdXFUMi8ybjVXWEdRVG5SdFU3dy92NjdUL0MzbHI2MWsxUXpvSEJkWUNQ?=
 =?utf-8?B?KzdGS2hiRHN5S2cvZEYyV2Y0Qi9LMjhWS2VDZnk0cE1kWElVNVo0bk4vaVVL?=
 =?utf-8?Q?/6kQeE+Q3T6JU25qsfUJyOfJLCKl/wsAGlQskrOYpWIM8?=
X-MS-Exchange-AntiSpam-MessageData-1:
	cmymqwdcqO0Sm8TqLt4ojqgpKIiwDmYHCZDzrDB1gqnDFYlOCY6psQng
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ff1497-cbbc-44a6-0bda-08de76284ff5
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 17:47:44.7015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxQL6+eEy8UASSIeH94IVdgC4T9HyJqSCBSIYGAas8PZzhNuabahRPPbQ7ZtT8WFs2DgjaElT9mP+hYbv5uTXfmM3LvsQpBoRrsiPzdbeU58ZeozEolS88TtivggQM1q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB7339
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261938-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	DMARC_NA(0.00)[onmicrosoft.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	NEURAL_SPAM(0.00)[0.591];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A77E11BBA1E
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

Sorry about that, but building on both ARM64 and x86_64 with -W=1 did 
not report that issue.  Is there another tool I should be using?



