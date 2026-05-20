Return-Path: <netdev+bounces-290141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gC1AHI5KDmoM9gUAu9opvQ
	(envelope-from <netdev+bounces-290141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:58:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7409559D083
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D3973022FC2
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 23:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC03B3CE4A2;
	Wed, 20 May 2026 23:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="5xOFwZyQ"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021139.outbound.protection.outlook.com [52.101.57.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FAF347FEE;
	Wed, 20 May 2026 23:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779320978; cv=fail; b=XsY2z8q+8XG5j/dRGQFM1cOveBZe9LtEY8ouRFhDixQtd9uf36qXp1D79yCkfckwWT6eq+KaZVA+vrYr4F721RqUZYDTKdRHUsrTP+lBP2AjE4eW5Y00tiWmmdEKf+pF1/BcxbIxPift0kkP9FEr0/2m/RVe5189GqNorP8qNpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779320978; c=relaxed/simple;
	bh=pADA1uN1kp5y7UDDeae9amrym5Ry4+wsMPljul7skMs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YuAQUGNYJ96IDWM+jqH/dzIZzLcTjkWAC4b18XNpc8Zr2dnOMzq1WDcxzcXoF4gz4h5+BqnqVd01SobRnnYmlv+ikVAurYqlmizt0OyUnlx6P41Ctx0ThQ2QXrcNFZiSgkjYSN5Ewa7zJjAxURBijakN+5Xwh2KKaVyl7+D+T24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=5xOFwZyQ reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.57.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATN0Hy93qoy/HUXtqegejYXKR1FSJOfY8ye9V+7nDfpbkLjT4apduMRVD9F5FS09dTYcfIyRhwFJjX+lHdtdCtrrnuH1owsoxeFelc0mryg2T7wxMkilLxpvQY6O+uMcUSSGtPLU4G0NDLBWa1Pi55+/ZpMbeF3u1DA1NgwtayvNHOjw5kwfNbFNylZZbpl56DwU02Aj9ybCbjgKWq2oKuNzWJE2WdJ/RVeh7xpRiQ57hAbzITeQH4jNfeJJhuX1Vb5qu7Aiqqn4sVvYvgMWcROqzcm/tDhhn+gwiHnMEQFXO1kfN4oIrhZyu6aMaVC85xPdy77wwf5hIZX86tS3GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9z0YHh/Hn68HJBP8NrqfR7p3kQ391FRXZGH8A01N6M=;
 b=fiYL2VAJ2YEeBj+0wOEGJ9//qRpeViuFkTvrhbA8w2LUOy2d/KwAB9aRO1JPfDHV57RyIrBDmQyR8204zNiwrVRactwCLQVjHRPydplVugT9Dq40IQ2KjvO1Mo//6opsd436dcqyWHAlNi+sg9BTkYBJXTLvPLjBzfFHp5GWvpxUWmz2pgU/xhQKcaonAZc036o1corqLiWe4p3fkXF7LzL4GPtxueP8hGBA+r9Kl9HUzssCcG4OY1EYaX+gR6w7OvH84ehMMRYEPTe52EEI+HJE5eB3nK1pv++7Q1zolMFu/Ifplj3nWcfeLtq2RB1cdrZW+EGe0o5SgU72RGJzDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9z0YHh/Hn68HJBP8NrqfR7p3kQ391FRXZGH8A01N6M=;
 b=5xOFwZyQcfK4SdXEj3usUiM14slB7vsZziRBKkfCftbrxMLAzKnNQu9fc7vhe+JNt4LE9Z7JbU8gFmSZli0nzMO6I3haACPr5o+ZxTLh8ktKsFgzYu99vT8hO/QCUawc4y74VW3Ybd30eQ194bNL78NS2RtFHLmxGQG1wNMjJk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 PH7PR01MB7979.prod.exchangelabs.com (2603:10b6:510:27a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.23; Wed, 20 May 2026 23:49:30 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.21.0025.023; Wed, 20 May 2026
 23:49:30 +0000
Message-ID: <1e2ecd0f-c5ae-47a9-b0bc-4489848afcda@amperemail.onmicrosoft.com>
Date: Wed, 20 May 2026 19:49:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v42] mctp pcc: Implement MCTP over PCC Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>,
 Adam Young <admiyo@os.amperecomputing.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matt Johnston <matt@codeconstruct.com.au>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20260518203900.30720-1-admiyo@os.amperecomputing.com>
 <bca423e86899791f96c626b10f816ac1bff8059e.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <bca423e86899791f96c626b10f816ac1bff8059e.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:930:8::17) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|PH7PR01MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: 76f91001-68d1-4a7f-7df0-08deb6ca6f56
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|11063799006|22082099003|18002099003|921020|55112099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	JNs86cOORBr6go/E9Knnfd262dLHDgt63NvmXlCzFPVg95eHF7ko/JUA6Enho6HlPUtx3fUitVXKp2YCqMK/3UCHtUzsMJQZhO/op7+Za/9RJyuwDSNRTMJNuYAyLJDLPcoxBc4vFG9imUEqArBF3HYk3ujj6iik/DteD3CD1PMNiipi6wG/pa4ZZUM6yhNwcEsxRj4jltT39/yvkbxpsBNVUO0QUaQihPzB6/Qv8ncXZwJ0kVB0wAFMFni+Jffqw7YM5HP/0hhMweeL4Uj2wsWXFglAKR0WD47f+AXp2TI914Sld//W+gM3jQuwFS4ZVTxa5P7RKsOJf9EItt5GIwEuoRujxnmI47mUT1e/zQAf2uZUQG6JI9WzK6sNNalVnxhiEOWkc0V28hLYeaBE2zhGNicPl/ht5xT+AHzFhV3UCoD6jj44HqrAOu6nVeBkcEoAjCfzUfs3ZzjK7P6R3mKJqRixkpidzU9ltQXFjY8O1mQT4pR0JWOKnzIe+noz//bhTYUwlCrBEzptUKYvcGD+1aMrtiA6uYc8t1GAjQ0qzlabGUVOoaamtZjggpqGcf5PK1GY+F+BjySFXfecOvHtzf0Rjzr6598nx3xjn9OE1G8jYmxazhH6Ucq44VRjrj85ItV46EQzoYZzOI/RcxK2bjYoS5xzIh4Q1ApLPo158+Uw4yKXze54XpAgXNphVWLSRaR4nyo+szCK65lvYWFGT5VNyEhYWfB+Q8XDebw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(11063799006)(22082099003)(18002099003)(921020)(55112099003)(56012099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TldXZXJGeDUwQ0JOTk9IZzI0QlZWbnJqempxRUhhWXF5ZkkybE1YaE5UbmN0?=
 =?utf-8?B?SlVaVmZKcHY0NG00c2dENXNLMjZQb2xFTHE0cmttNE9XU1BMMlB4T0pUZUxl?=
 =?utf-8?B?SURmNDczNWZrQmFldjRSelY0Q2RxKzFpQStRSjY0K2xjSzRNeGkveEFIbmVN?=
 =?utf-8?B?OVFzVkFvVlNiUXhIbkhnb1hIZ0xyVTc0dGpJeHZubjRpdzVPQVZrS1IyUjZn?=
 =?utf-8?B?dzZEdk8xaS8yWVZ6M0tzU00zZ3lkNWlrOGRnVTdId0tZWmJGK2pIajM1N2hx?=
 =?utf-8?B?bEhiMlgwWU5PcGd2eWpReUdvNkNRMXNGdFkwZDdjOUdQVHQ0NWQzOGhwRlBv?=
 =?utf-8?B?aWEva3F1QitnYm54dldJQ3VFSE9kQ0dQT0JlZHFQaHpqNUR3OVdnVXFKUVc4?=
 =?utf-8?B?UWNtYjdQT2wrYndLbnA0SWZiVHA0R0tPMlgvSlp4Z1cxVmZjdWFidnVPZXg3?=
 =?utf-8?B?VmludUhyK0dROENHVnN4TTV2NVllOTNsWGdQS3VtK0FYWnoyb1M2TnBiT3Iw?=
 =?utf-8?B?MUtxcjczK0J6WGpVZ1VhWUcvSWMremsxTU9MYjF2ZVI5a05KNTB3eGtkZmdl?=
 =?utf-8?B?VTFweStYZWVrYm1wd1J5ODJIMnF4MitCOHRmTktLTndsUEtUdUNHQ252MXhh?=
 =?utf-8?B?TFNhNnJrWHFzK3dDaEtReCtIWnQ1ZEs2QUFxMmh5OGtZSmRBZStYNUZJTm05?=
 =?utf-8?B?RlN6WHJLdlA5ZVZtUzJtekZCNU1yYXNJV1FqTXhqK3J0c25KTU1PREdYM3dF?=
 =?utf-8?B?RnRheG9EeGQ2VHNveVpxQm9GUlRhK2NEM2FYV3RFV1gvaDcwUHBBMkZLa25a?=
 =?utf-8?B?S3hZOXlHNzZaVDh6Y2prYjJvUktOcjg3Vzg0a1dZNEJRSWV4cVY2T2RiQlVG?=
 =?utf-8?B?Snk3WjdXT1VqOEhlSmFWM3ZaVVFmK3RuOGxVZkgxSUpWdzZoNlMvcmoxVEZx?=
 =?utf-8?B?c2RiL3NvSlNNS1YzMUcrTm1rN2pWT1pjU3VHa1BXamdOOHVreU5YMmFsdFVL?=
 =?utf-8?B?K3JoaWdQaWdTeGR4TWNoRmZpVGRUNDlUUk9JcmE5SXgvckNiT09SaHNQWWcy?=
 =?utf-8?B?T3c1dVoxSlVCR0xvWlRXL2RqZmRjOWdYMnJVY0l0TnF0a001dEJQa3NHdlRn?=
 =?utf-8?B?TmJhTW9CZEt5SzNCbDg2RzBBRnloTDhmMUExNWFaeFpXVE5LK0p6OFRraUd6?=
 =?utf-8?B?UzZIY2hzaHpBKzVhVEFCVytSbXM0TEREUitlMVhRMkFXTUZWMW55YVZ1Nk85?=
 =?utf-8?B?dWI1ZEU0RUpQbS93S1ZWNVFwOVFLMGNrc213ZVY5QTZRZ2lwbWRGeElVVlBT?=
 =?utf-8?B?RWl2czJGdjZRTkhJdnZSakRVeHE4OGtxNjNQTFNsbGNMOE9xS2h5VDA3ckJR?=
 =?utf-8?B?WjNNd1NDR3BkajZRQnVOdzVPTy9ZdngzSGtjZTc4U0JKSWN0YjdLUXhYTHU1?=
 =?utf-8?B?ekh5Uyt3YmVvRHRjZDdJWXFDeUhKQUFwQmZzdkRHdUhPMmdqeDdhaHFlVFVM?=
 =?utf-8?B?T2dscjREWUtBOExEME1WNEVFbEJEdXIvcTI1VGppUmdzSzRrSDRLR1Z5V0x6?=
 =?utf-8?B?ZVRxN2FOVGtPK0VJQkpaM0ZKTnpITUNsdFBnblkxMHFyU0d0d0w4T1dhSUll?=
 =?utf-8?B?bnRRcVpRS3kzdlRVaWgzL04reElrZjVpT3E0bjd3bllPdjRld251V05HOGx6?=
 =?utf-8?B?K0ZEYUNxWjdXSDRmaGFwbFpjT2wvYTlPV1JtTVl0c3JZUEJiNVhqUkNOamtL?=
 =?utf-8?B?Z1NXc2VQdXpDbWNhbnRCUjFBZWxjYXVBUElvZEdHNEZIMEEvdWp4SmNQc2VC?=
 =?utf-8?B?N2dZV1FTZk5udVhkNXdoYmpZVlp5TlQ4RXkzU3NvSjRpVkdlUUdpSVpDT3Bh?=
 =?utf-8?B?dktXWTd1dEhNWk9FZDhoSm8vQTZoUTBLUlg4ZEZFeWRIbDA3L3BWcXVQaEZP?=
 =?utf-8?B?aHFHNzRhWDk3UEl5TGF4WjJPRFY5MVprVmd3REh2QVhjbmw3RXQveElhUTU2?=
 =?utf-8?B?M3d0WStFKzR2WmZvVlNoWGZEY1M0M1UxYXlXeXVlbzhoUEViWmM2NDFCUUZ1?=
 =?utf-8?B?ZnlFb3kwdjRJL09yK1ZsTFhqbnVOZWhBb3Z6bnRYTVhJK0FMaDJuVENIQ2Nm?=
 =?utf-8?B?UVhva0FPM1JHOTlNZVZRcHI2MWUvaUJDZmorTjd2WlErTmsvZWlYcnNKOGZv?=
 =?utf-8?B?d1MrblhGTVg0WWx6RlBVWjczSXRaSjRvc1JvYkRDNUpBUTBGTktFZ2tnUzUw?=
 =?utf-8?B?cU9FMzZFalp1bWZ5VFlMSmVCaExGc3BHWkhwWHltdFMvRlREajB5dm95Um1Q?=
 =?utf-8?B?ekpiYUpZWEVnWHRHVmJmWHliREZEN2NjQlpuUWszUzRlOTZ1VGVYVnl4OFNM?=
 =?utf-8?Q?3wUMaTKNLvnIYCgM8SXvo+X/0Ds31M/qbZM45qiDa1oIC?=
X-MS-Exchange-AntiSpam-MessageData-1: bRrwx+b4kwEZKg==
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f91001-68d1-4a7f-7df0-08deb6ca6f56
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 23:49:30.2922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfzhXSHCB2R/BrLksnYw6WLHOv6TO0uuTnS6pZ2Loax5x+LflXTV+jjkOASbajtqWh53UkxPMvETP0ZLQDJGbd3anPXeJ7aJcyH4k6XqV65vXKPuycmofcpjRan7G7Ts
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7979
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290141-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[onmicrosoft.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.422];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,amperemail.onmicrosoft.com:mid]
X-Rspamd-Queue-Id: 7409559D083
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/19/26 00:06, Jeremy Kerr wrote:
> I don't think you need a wake (vs start), since you're running in the
> same softirq context as the stop.

I am going to keep the wake, as it is less surprising, and more in 
keeping with how other drivers do it.  It might be a minor performance 
hit, but inconsequential to any known workloads.



