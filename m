Return-Path: <netdev+bounces-289211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFBWC42pC2oGKwUAu9opvQ
	(envelope-from <netdev+bounces-289211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:06:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 990445755EF
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 605CD301D4E2
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 00:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CBD200C2;
	Tue, 19 May 2026 00:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S86m1JU8"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013015.outbound.protection.outlook.com [40.93.196.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F7518AE3
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 00:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779149192; cv=fail; b=FxIGvFeQfhS/jy807yzbe7pLwdb0vu5KILEoW4PuY/WbCzcWkqKaBM0SepMsAJ2iSVYFvQfiTcKyJ2zk379o4waeq8ikGT2kJ1E6r/ysDRZN+/RhVVnqIMS5IvndLT3Rsol+/IajThDRAL7e3LyUIt7XRv/Q4dHHB68yAciayc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779149192; c=relaxed/simple;
	bh=IUMMb+ULTihOqGQ3kjCVBeN9fhRZV1eRFcgIOgFOgBw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IGVSKuNmrwYbOuiXrY0SaNGuUMCA90t2RzzCW/unIo7w5jCvwWhvxImib+6vS+B1h0XBd2zJG3THi/qsyV6HF93TECs4NsEDoeG16KErPFjmZVc1A9gJlb/VRLkpHVTrM02FaW78K+g6zPE3A7j8LDgnkst6v3Uso+T0JGoUwGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S86m1JU8; arc=fail smtp.client-ip=40.93.196.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jgd8K9RUxb6mI7TGxfpFUv1e0QaLulJc0rLyTci6rMa+CuJLxZHgpP08C0hsY02Tzqvr/H4ZjI4+ZjzOyJrI9XgK+UARtZVtY3FHRVNLVnw9hgIUuVjMeHAv2c08ksqejX9WK6CFG7JLShb8tL2p/jIe27SVOg7A/xSubBZsTxqiD21aszQWtEl6qgfJMfctbbETeSZvAF/iTCDpwUX8RYDs06GkYQKzejEVEkHi0shodG59+EquAD7lI2KiQczJ5gPkzqbUVGBOpKCpTAidREHbKph0nzqDACX7pQpyRNuEfQoGRJUIt0VVMfUjqeLOvG8msw+OQha4fRUFS+Ek3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhwGlO2ekZuyFNbTX6PnUnPSoUL98THDqNnur9vPhpo=;
 b=IlJW/kR2/8kdzPdM6FrK/imry2BDp5WrO8n+vtIme4NZelZTOFEHUDhAkdPjwEEQXNjm2Jpnm+TTW1MIU0p6hvBs1uFVWMDOR2LNR4asF9Q6iSV1ZQuzmoC7VZ21ng02qcMSc3I7KWpRUSN3cfSNoMddHz5wdZanhpb3bADoqJnYj3rftHzvRSG9aK1x8BKmdaFvQx7Bxbpz/iW4ihDJNaX7yRAq51zyB4HlnCm8iNT0FSbO7q6rAHOvp6qH6ZpHtGEMCx1tBoEUyv6G2BmdDSrGdPegQ4Sk9Jxso/S4U3LMz4LQdV/TPicCp9BTVrH+zDoPgjsZT+pB7ZtZf936BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhwGlO2ekZuyFNbTX6PnUnPSoUL98THDqNnur9vPhpo=;
 b=S86m1JU8M9b/RxHot5rVpo5WrcLyVnRnSe+KNDPt9jtWw6mdPGTsuMdyPqSWcorktMm25qiXBmYLWv5/t0dtEmpzRV73aDGnJchWJlDmacUHMuSmf7gpVeQJvwvh8h2uCBv8ZyKhHi2+wz32uJq+d49vclJSH7dHqgTCI/3hKes=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) by
 PH7PR12MB6491.namprd12.prod.outlook.com (2603:10b6:510:1f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 00:06:27 +0000
Received: from DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a]) by DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a%6]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 00:06:27 +0000
Message-ID: <70a655a0-4e43-4b8a-8e7c-f4436e2a8f1f@amd.com>
Date: Mon, 18 May 2026 17:06:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/5] ionic: Add .get_fec_stats ethtool handler
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20260512224421.25236-1-eric.joyner@amd.com>
 <20260512224421.25236-6-eric.joyner@amd.com>
 <20260514183209.48fa771a@kernel.org>
 <8fb773c1-411a-4b61-915f-5111210abe1f@amd.com>
 <20260515160223.1a6b62ea@kernel.org>
Content-Language: en-US
From: Eric Joyner <eric.joyner@amd.com>
In-Reply-To: <20260515160223.1a6b62ea@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:a03:505::29) To DS4PR12MB9708.namprd12.prod.outlook.com
 (2603:10b6:8:278::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9708:EE_|PH7PR12MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b48ca9-bf59-4598-3bfb-08deb53a78bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|4143699003|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	LkEk0ve+FspdryDOM7OZhOWdVV/e2DTJhf0i6vVF0tYY3YBk1YdGtGCK5wNJPQ21jS9Ez97ZDQV8dbNhbSnfRjjvnP5+4EODHkqdVLkHpHDS/v/2LBqlzmQ9eQtrKZeIjbednxN+ipb10SHuUznXv8ELM99Ts5lKlBGvJMe2/NjoBZCUCJr8TXvB/V77IB4Fyx+MGYevsE/W89RkzOAPo6d+b7ZEIRdGa57Q4H9/PFQpFVGNfLyDKK77T/w5uUB0267STR73xuSnLPMWr6Or1Z1wJGsC1ztr0nsfnPXpLVqAVQCnWpUMhfo2RJ84QxEyD5xWR8mH8YtRqzFeA+NS2pYyspeEGU2BlHFHro3Su9xSTfZSebWfDXXR1w0q2FCSuJi8uYMXphsYN2jGnc95aShy9QdBuflcoBM4kgbE6uLFHI6BAYOUcyqztUq3xitluDluMqatfp4R11kriNiZwP/jLmc+gP2hE22Q/zQxgnoyqAu9YbyhB7qhCiInSt4Z7Ms0bOAykQprv3Fd1ir0SafYwcSRGjPgbs8Y9Gn3IiOek9fUmoU7rW2sa5e02aBZtpKZT7D9bJjfDbwaiXyolUYu21lFvUqh/B9F5w446PC+lIwa1DTFvzhYWN5xKTZQJas9lWhaKNhu5Qai2Q5VAW+rMz5JSTaNS8GJNdqoL0104zpOdC53N5tux3StxJmg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9708.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(4143699003)(56012099003)(22082099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3ppR0FYbVprWHA4OU5UNHBpbmtnaEUzOEorbTAvMStFZ1hKcDdJMG9ZSVBn?=
 =?utf-8?B?T3NyTnhNVjFWYW5Fdk93MVdWbzlMTEtFaGs1dnNybWErMGhqV3RGVXN2bk9S?=
 =?utf-8?B?eWNxakgwQjIxb3o1R2J1VnBvMkFRWUIxNU1TK1BoWGxVM0tkVTlrR2ZweFRN?=
 =?utf-8?B?UGFralB1WWVta3JVZlpsSGRMZmY0NVFFRE8yUXNaUFJYY1NVcnlrejZDaVJI?=
 =?utf-8?B?bTlYYTZ5YkRzMEoxdUV6MURVdzN1UzhFeHdUU2c0NXphZTcxNS9hN1hPaEFh?=
 =?utf-8?B?T29zNkJ4bmYyNVphSVBRMFRRcDdRTWhrRUFVdjVaaWtuWWYxZVFFVlVxOGQr?=
 =?utf-8?B?eFRXVWVjUzJOQmpUY0J2UUVUYy9RVExoSEowK2JJUU9zblZOZmdIYmYwWlhw?=
 =?utf-8?B?RnptTWp0R0tjU0lwOUoyMTNQOUxnY1NYSXVDOEFORkpDQ0tZaEFiZU9VcU5J?=
 =?utf-8?B?WklPdmlqT3JoU2dGenJ5YTk1TWQyYy82TkQyaUtaMDN0VGNOM1oxVGEra1ow?=
 =?utf-8?B?WmVGcy9vLzhmN2xmbk5rTW9oM0F4c0s3WkVDOHllUmR6YTRZU0NIK0FISFk5?=
 =?utf-8?B?RHJwanNQNDdEWWZia2VCN2toVFQwR29kS2w3WE9EVnZMMTRaa2N4cnBmMjRM?=
 =?utf-8?B?b3N3RnVleWNBOEJBNlJsYmVWVmZscVBCOTRNK2ZXUTQ5RHRaUVNCSk0yTzA0?=
 =?utf-8?B?WHdhK1R5OHlUaFNZdndJc3hId0M5dDhxTE04RmtOdnZzYk1VWm1hVlAzaExp?=
 =?utf-8?B?SXZNSHZ6MUcyMDZBR0k3NFBOK0NyNFhCNm1sYklmWHNIclRDaTFrQ2xZQ21l?=
 =?utf-8?B?SmNlUGZSS1VWaWZmVEFuMHI1enpCZktTOWJLR0RFdWN1cC9wTkdMQzNZSXQ5?=
 =?utf-8?B?TmF5cTdmRkZUT0xIL3ZYN0EzV1pFZEplUjE0T2h1eFp1N0tNaUNFci8rREpa?=
 =?utf-8?B?SzZMeGRMQm16Y3I2VTIxTDNRL2x1MXpYVDNjRXpuRldYN0lQVUduUHZDVDlu?=
 =?utf-8?B?T0lhMkRrUnMwRG1XYnNKbWEvMEVUT0dwb0E3V2ROaVYrM3p5Ym5UbkhISnpU?=
 =?utf-8?B?RTF6WWpZcVJZdDN3eFd1azBFRlJadjV2enJpTVEzeGNqRVg2dGRqWkhKdzhS?=
 =?utf-8?B?T1VCZU1lWUwzT2pVRm5zWWVkeFJhZGxzQW4yZnFtYUZLa1NaZzQvalMya1A0?=
 =?utf-8?B?dXRiUXM5bnBkdVNXNEx0N25jYllURTR6M0NBT0hoYlRPT1lIS1BFNW9aRDB0?=
 =?utf-8?B?UEplaE42MDhONFQxdDROWEdRZnZsUHNpdC9FZ1d0aVR3SXdlRFR2VkM2WUYw?=
 =?utf-8?B?c0w1elZFN1hWUHZSR2NLOHcwdkRMYWk3bkFZcFhyWjBFVDBWT29vVEFkcnNr?=
 =?utf-8?B?K2dCYmh6QUljVVNId05NTkdIalhKUGN0OWhFRkd2b2lxZ1VBYTJMQU8xUmJt?=
 =?utf-8?B?TElWaWEyMG1QeGhBN1IwRS9MSVBiUXVOQkZGY0MyczQzUjhlUzdzWGVaRHdB?=
 =?utf-8?B?WGE2dW10WkEybTN2WkxoK20wMWJDdGlLVXVSU3ozOXJ5Q2U2SkN3dFNPUXNj?=
 =?utf-8?B?bTl1SjBLMkdhZEkydXZ6dFRha1FlVjFqVzkxNU5GcjJucGNZR0tHVEluMkcz?=
 =?utf-8?B?Zm91eDlwV05rZktMbkszOVZpUmdYY05ka1FLakdTZXJjWGZwRElCdkE0eDBz?=
 =?utf-8?B?STZVMmdXMGV2TWVlcVR2UDhVUUl3K2lMWUpRQW5kQWhDYjg1TDc5Ty9Md1dI?=
 =?utf-8?B?WmhTdTNBSHNOa20zcVpCamF6bWNDUDJRTjh3azUxRUFaOFcwazNDUk42Zitj?=
 =?utf-8?B?WXp0OHd1RkJxaXJhT1ZhUVBXSVNELzkrbEdIajJHS2RQM2FJalNDYjhMVzFy?=
 =?utf-8?B?cFlrd0wyU3l0djBwaUNqS25UVDNjNC9nL2kwd01tQWtlU1VqTmVYTXV3dnBx?=
 =?utf-8?B?ZFl1bXRRNHpHYm1pTVp0cXZqaE16UksrR3pMb211OVJTamIrSGpLTjk1VEQ5?=
 =?utf-8?B?cVFUcmpXSGNlenozSXhWak9XTmdjRHFkOXBwcDBRSWpaNUVzR3F0WlNCOGdl?=
 =?utf-8?B?MnpmWUdodFB1OGJxci9TR0xiWXgxWmgzN0dodHgraUdwTCtBcmlldmhIMkFB?=
 =?utf-8?B?NUlJRzFvUWxVVWc1bUVtb1pQRWU5RHg4UmZFQTc0MGRQOEM5K0hxMHpucGx1?=
 =?utf-8?B?MXpiTi9LR3Nyb25WVHhQanpxT2RFVTQrL2hubWJYT09WRWVFNVFPRnhZRDlt?=
 =?utf-8?B?NHdWSzNOWFI2eEg5bUJhTHl6NG5SSTRibkN2dDBPTUdRZnY5d2crZkFvdG9o?=
 =?utf-8?Q?RCvpnx7WLWuWR36avf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b48ca9-bf59-4598-3bfb-08deb53a78bb
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 00:06:27.2664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUhShxqiFg5bFy2QIPbR6jWCRxPRFM2FqlbCPJZjacbdYJuDzNJaJ7jmf8ca2v+O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6491
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289211-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:mid,amd.com:dkim]
X-Rspamd-Queue-Id: 990445755EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/15/2026 4:02 PM, Jakub Kicinski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Fri, 15 May 2026 12:59:04 -0700 Eric Joyner wrote:
>> On 5/14/2026 6:32 PM, Jakub Kicinski wrote:
>>> On Tue, 12 May 2026 15:44:21 -0700 Eric Joyner wrote:
>>>> This includes 802.3ck FEC histogram data that some newer
>>>> hardware collects.
>>>
>>> Ah. "Some newer hardware"? As Sashiko points out the standard stats
>>> are designed trying to avoid "does 0 mean unsupported or 0" ambiguity.
>>> You need to figure out if the device reports them and if not - don't
>>> set ranges.
>>
>> Unfortunately, there's no proper/good way to do this. A stopgap measure
>> would be to use a rough proxy measure like checking the ASIC generation; and
>> then we can implement a better way in the firmware/driver following that.
> 
> The FW definitely knows, so it's a SMOC.
> Could you respin just patch 2 for now, or does it suffer from the same
> shortcoming?

Sorry, what I wrote should've said "there's no proper/good way to do this by
only making changes in software".

You're right that the firmware knows; to that end I'm almost done changing the
firmware to act similarly to how this interface distinguishes valid statistics,
and have the firmware report "-1" for these new extra stats if the hardware
doesn't actually collect the stat.

Does that sound good? I'm planning on rerolling this patch series with support
for that.

- Eric

