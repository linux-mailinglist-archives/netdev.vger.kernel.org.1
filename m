Return-Path: <netdev+bounces-268334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNxiJSuQuGnifwEAu9opvQ
	(envelope-from <netdev+bounces-268334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:20:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE6F2A1E3D
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 031FF301DDB7
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1FC371041;
	Mon, 16 Mar 2026 23:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="+GIFBITc"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020118.outbound.protection.outlook.com [52.101.46.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009DF364E93;
	Mon, 16 Mar 2026 23:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773703209; cv=fail; b=D28bK6ubPGzaA4TSyR/UTkZ8sSPScsG0/zJik70oMbd7LSSqy3OIl44YemCk85XBMj2lrc/8fbbrK1L9GfWnhOL6eqj4hT3YllZJiYeRBYETwb4+QYRY9X+UP7WA06COCh/F936X5dlkELQYnCj+Z3TWiZNAg17Rd42g6trB/sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773703209; c=relaxed/simple;
	bh=cqtxks5gr2ByFaq0tgb/k2EIXt5P9WzCH5FBj+O2BUE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jtKVZoBm3Xurc+dtUy/wsmYj8q4xmHxRxM7cRhRdz3z5BISrWEKibGVVT8AQN9LXWomw8ld3dfFWQyWftgrzTtpCSxGbvDHb02My+5lV4zN6ak8NcPSuk5sFAEskkwGlCYVxEqyrX8Zcm3vQhTKd6Ygx7J+i0NYjJjuBwqX3miI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=+GIFBITc reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.46.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+KtTTMJCzh1tgXGyqb5kBlvuqqQnlGNstmbMu5ILFHHDj2XJNAxCy2OBlf65B3Qw/aeEN1wqAj8I8QfYLaGUPDtcOD1ZL7oNZgk81DhwWYM4PYQ1rA4XNMsoEbNzgTtHsL+qhEHTVRe83r/ooLfA4KOGfxBXbGTJ4T2iVY6awEf8yQUblQhaCBDduQwhUljoJnIM7F+rK3MksQQUYEWP8PxEpOF7mxkR67hazNjjXHCaihyG1s9Hf33DgfI0qLTbZ64hNK8tJmNmTXnmleRFDVBB+odVS3czT0pgCQFN8Ez+1jyWO69V00vxOpVgqlnf2PYxZVh4243ibKKytn3DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dqfr6tvoz3GuA6yZmOvlrW2qFarGs1wA7JUoMuGbCsM=;
 b=atsYtDl0VfUmaQ2fegY951WmygHDy6cdA4GaifeUGdIR+OwKKUsasYVmb/kOJzAKYeV89L5dDkbgJdoBqG199z46V2pzjf9dNGf4n0COIJtQaMuIaVvATQ3tKK4BQHrg0TdPqCFFpXZ3bxdq6aCQ2RNChw+eXZT9wL41S0TMybYK2fhtojFa1uRDeQ+QoHPprGgVgmFWdcuM6ArhLhjlHuREYqlEc0rTHzVAkwvmJVfv3Yhrk2lODOW4ItV8hpAqtJYP6UwrVHvrXD0tVzYvRBP962KbNkYuLHulm3lsC8UTzTl1cWKsOqmuZZ8ncVnw88N1uYcnz5gIOfDWUuW5fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dqfr6tvoz3GuA6yZmOvlrW2qFarGs1wA7JUoMuGbCsM=;
 b=+GIFBITc5dT8btnvO/KEbDe6+IvjKJZVzo7AY5zH+324eSiqkb9WQMb5bxi03dYPqxi4P5RnK9Pau32mPm9WRgxuQhLcjEV0OC01Sz0DYkdff7xQoNrDcNjpuyG1ziba/z6zk0JYR6gdArJzyZVp8khBnt+ODbqMWGbVqqGPEvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from DS2PR01MB9205.prod.exchangelabs.com (2603:10b6:8:279::8) by
 PHXPR01MB994646.prod.exchangelabs.com (2603:10b6:510:3cd::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.25; Mon, 16 Mar 2026 23:20:04 +0000
Received: from DS2PR01MB9205.prod.exchangelabs.com
 ([fe80::77ce:5069:26a0:c0e1]) by DS2PR01MB9205.prod.exchangelabs.com
 ([fe80::77ce:5069:26a0:c0e1%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 23:19:49 +0000
Message-ID: <112a9a4c-0557-41c4-9ccf-f10e0cdd510d@amperemail.onmicrosoft.com>
Date: Mon, 16 Mar 2026 19:20:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v33 1/1] mctp pcc: Implement MCTP over PCC Transport
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
References: <20260316035626.363698-1-admiyo@os.amperecomputing.com>
 <20260316035626.363698-2-admiyo@os.amperecomputing.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20260316035626.363698-2-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYZPR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:930:a1::28) To DS2PR01MB9205.prod.exchangelabs.com
 (2603:10b6:8:279::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR01MB9205:EE_|PHXPR01MB994646:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fc499ae-83c9-481f-8539-08de83b28507
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|10070799003|376014|366016|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	/jpLQd2Bf1oJcSaFtI/xrrDdrACHhLLjR3XfoO6WxrsrGCc+tpUPve1Enq8KWS+g9j1/RRPaJ/LzayLstXUoDuYlZXce6kToy8erXis5ZREi0x7UvENbcu8hKIYDGpGeCIqVUdnxdiHHZ46nnT2lnd//t8IreoyPKnOQO0MERenfMCkuLLzrMoPIsCGM14xM+ucGD+CeE/BiSX/QurD9eeGtZfxDNCfIOm9OB7n3DTkdNkkYgBp4RVPuLQlxu8MAnNbR/ko+EqI1j+jSoU6s3lfLXQdfoKtiiif4ChwXua/oe74K2FSL/6Nm7kKfNO3qJcbePg1QLTqPJqntOyS+W5eQvsnDMyDn2/9TgYLUefkLgOSL1O/FsezU6G3GD+LUzlxI7n29VmeLGgkAtTV+k+JzSpIknooJwQeyeOpJyuzcv34gLVleYsdRyL4L7uxIII86m4Sr77r4Kr6EZOj0mfRaVy6KR8SLqLgRZhkM65wLm4V0wPnkW4h6k/5cDvdv0oxPddC7ASL3hU48y/iM4MaXeNq+dTha9+8R15D6cWU4TBbaeCZWu+4N8sWZ7sGLocEuuo/WhdBdDRVUYZlmihU6cE+LfjxEg+gqR/oE9o122NWusFXS1F3NnFVf33FxCgcUfWWXDWmWUG56FumyL1L+Fc5w5NWTt9YIvx5g6VOgbZcV+9mxSByv0PGTIuxKfqsSwMEb6Fa9jczm44JLdHmY5sU3ZI1DgnnEGALFtg4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR01MB9205.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(10070799003)(376014)(366016)(22082099003)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlNpQVVwT2lWeGpDbUg1NWZLcTJhUjUyRHVxeDZwUU5DRzZjcFlZK3hhMmla?=
 =?utf-8?B?L3BPY2lCT0FlMWtsZCszdVFFZExxOUZTTXEzL2ZtQmRDNzc3b1dpeThvRkk4?=
 =?utf-8?B?eldFRHU3YVE3LytTczRHV253cThobk9pWFNqM1FkK3dMS0hyanh5anFqTzNR?=
 =?utf-8?B?cXgyUTUyeXdDdWJ3NDJ5eVdYd2I4UVZIN3FIRUsvYzJBNFFwL3BNME1lYVBj?=
 =?utf-8?B?SzMrMDgxQW1jdzFqLzN4YVB1cjdiWU5zSWtDS2VlWUtueS9YbyswdjN0UW1O?=
 =?utf-8?B?S2tEaURxeFJTdjlHLzJFUEc1NGpZbjZ5cFhtckV0d1RUNDY1N0NWTWlVMUl4?=
 =?utf-8?B?c28zVlM5dzZaYnZBalhFeUNPeFZ2bzVXeTlDQlNRUzY4Q3J0cWVNcXRaMnFY?=
 =?utf-8?B?WlNNZm9WV2o2Vit2bE1ObllrVksxV0Y4UnM4Nk92QnJWaXdzUll1Qm4zOGpn?=
 =?utf-8?B?RXFtSERUZEhBODkrWkFPZVR1NDY0aXpRZ015UnErZGN6ck91VGw0WjExU2hN?=
 =?utf-8?B?dVFDdU5MNC9xTHFPamVjRUlQM09wQngrVHZhS3V2UlNrT0dYT2Q5dUxzVnhL?=
 =?utf-8?B?bTZLbFFGZ2FWNk13VndwdGhDUTcyQVFYQjA2ZHQ1d1BqamIwZzJYV3FvKzhx?=
 =?utf-8?B?anU2Zit5Wk1LQllLTWNyNk14YSt4azV1RmZwUlFWTVpJUWVBN2hRK0t3SjFk?=
 =?utf-8?B?dGJwRVdzMWtHRWdWLzVwUk5sOEtmMHI1TDJhOFBKTXF2dkhzQzRUVWRPU1Vt?=
 =?utf-8?B?VlRUVXBiNHVwbDlBWWswTXprNmdkSXNCN3hBbnMwblU4SCtVUW9hSHltdWhJ?=
 =?utf-8?B?dENLbWFHdXhUdTdyaDBRT1ZOZ2YrZklFbEIzeW1RU05vSHZ6R1FQV1JWb0xC?=
 =?utf-8?B?ZVdQOENLSHZlbGx6OGRnTVN2cTFjRERmRnl5MjlZemVselpWSWtNSG1VMzB3?=
 =?utf-8?B?eHJFcjFTOWlGZ25SMTVhMzVRN1B0UXJIaEpFRy9iOTRMNFloZ3p2WTB4dEpl?=
 =?utf-8?B?c1IwVnhmMUdUV0licXFuY2wvOW9lSU1iS2RpYmNFMXZiNmo0b29RUmpVNGhi?=
 =?utf-8?B?Y1hDWlU2eUVKLzRpdXB0Zk90MHVHdE1nV0IyaHo4RnE3c2xmV0NiVnltNmhl?=
 =?utf-8?B?K3I2T3p2eVBscGJ1bXF6VkFOYWJHZFlYMUx5bGR2NGxxeHl0c25ZQmZHL0VF?=
 =?utf-8?B?d1FteHUvUlNzZUNXbGYxanVqM1dHMUtBU1dTSTRvUjNsM1hqK1RPaGhtelNU?=
 =?utf-8?B?ZzQ1UHZsK0NwZmEva3l3OGRFTnRaN1didnd5eDVZZ0tuMnI3cU91RWVGVVVZ?=
 =?utf-8?B?T29FYVJPYSs0aUcvQ0dmakxkaVpWR1JkQ1dKanY4YXl3UXdhN1RhVmJyaVdv?=
 =?utf-8?B?M3I0dzlWNlF1QVNtUUxobHMwaEY4emJvSGdtRUswajlpNUFoK0RHRitwN0Yx?=
 =?utf-8?B?alNuTncxTHJBaHZMQ01iL0U3bm5JNTFUSDdTdjVQQURYV1pxREtRMnZBSk1K?=
 =?utf-8?B?YkV3NkVNaGZhZEJ6R1FBSFNWSm45MnhmaitJR2kwM3d4TWRMcS9tU3BKNnov?=
 =?utf-8?B?eGZUYms4cTNRNHpHZmM5RjJQR3lBK1E2VERlZUJMT29FSHBqdnVCWDZURHB2?=
 =?utf-8?B?bU5sUkRvYi9mWEpEbDlic0VOanF2b1ZiSW51cHpPcFYweElZSHZhdzFCZTV6?=
 =?utf-8?B?NHlzMS84cTIzTUN3Y2FNN3BTNDVkOFVBNHExd0c4SG0xRnBiTlVaZm9LaXVy?=
 =?utf-8?B?NThoM3RNclRzSFBnNlBBTjAvMHgxMUxmTjJ3dldZN2h1Uk5pSWVYSDZObDlM?=
 =?utf-8?B?eE10VGNnNDdLMEZOWlBXQjVJZ1RMUGxNazQyeXc1R0phM3JtclhkMGg4UGN4?=
 =?utf-8?B?aHFWbXgzdVh3N2ZFbEV4WHZNUTEyNytNY3JOU3E5cEhlMndPd1NHaU9rYnZT?=
 =?utf-8?B?VjBsZFpuY2dhMU5WTVlxUzJkd2ZxYU1QZ0ZIOWFITFBhS0hlKzlnOThQTUNx?=
 =?utf-8?B?Z3RxRGJpSEx4T2lzWDFwUWVOT2xhVWJKOEJBVS82ZWdJd3o1QklwdHpWL2xU?=
 =?utf-8?B?b25mUDVUalE2SnhaYXVocEtwWHJUaHU5TU5TT2wza0s5REZFRkI1TElFMzFG?=
 =?utf-8?B?YkkxT28yN2QwNFpzTjJScnBtdDNianVxWXZYeXJDUnpaUjNxdm42N2c4N0JP?=
 =?utf-8?B?c0RFR2hjTkx5SjErMS9OSWdNd2tnZ2JRalVmZnBzeW9lM0NMeGRFMzJLWmtk?=
 =?utf-8?B?UUordWdjelBEM0NxeE1WRU1qNWx6a3JpcDRRcWpZY0dJbHdjOFFRcUNkaDZu?=
 =?utf-8?B?OU9odkNVc01wWTB4NmtRb3RjYUhPb2gxYlptOGY2a0JsbWg3MnBuMnliVkpo?=
 =?utf-8?Q?zUdQ+zpnMpAGozSIq8qiDJLH2+GMFEBYnb4YNu3hOXOTI?=
X-MS-Exchange-AntiSpam-MessageData-1:
	E4PLxNARhnpArD7e+6s9zvio0svNm02JiHQmgZit2vfm9fhl4XR8p9kZ
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc499ae-83c9-481f-8539-08de83b28507
X-MS-Exchange-CrossTenant-AuthSource: DS2PR01MB9205.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 23:19:49.5385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJpVDKGLu3MdIfEW0sXD49E1ghnUfBjlCg06AHNhKvukomzWreSwOdcTYVJqcdlukh6sv4FI05YVIgDIuV+zVAyGz1oHIdNOTnY9GfZT8ketj6udbnbpws0TgFANImBu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR01MB994646
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268334-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	DMARC_NA(0.00)[onmicrosoft.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.883];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1AE6F2A1E3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

One question people might have about the diff from the previous patch is 
the lack of a register check before reading or writing the shared 
buffer.  That check was already done in the mailbox/pcc.c code that 
calls these, and thus is not required to be performed as second time.  
That allowed me to inline the reads and make the static version of the 
write function in the MCTP driver.

