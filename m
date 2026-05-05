Return-Path: <netdev+bounces-284573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QO4JGLJI+mmJMAMAu9opvQ
	(envelope-from <netdev+bounces-284573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 21:44:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E174D3388
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 21:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B319C3014C7A
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 19:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A64248C3F9;
	Tue,  5 May 2026 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BK6MABbw"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013034.outbound.protection.outlook.com [40.93.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF84C3D9025
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 19:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010287; cv=fail; b=fjzWBnMi3slhRVrdDm5vEuhLcnTbQ9sxxyi+YL54mLctXWRAFngXX7m5eWv4EaMKgWIs7X6eopiPCT16YrmAyHOoQ6WUCpyW2PV2kIlPvsyDEWhd7pthodFg+hBiFtp/BN5kQnNqIdH/SUs5T0Rr9p5p4gFM3SY5mZ7MjyLSsI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010287; c=relaxed/simple;
	bh=YHN+0xknhE7QXeihIj1cP/ziWPicEUT6haDs3L9gC7c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rdrPIzkabMDFj83nDimhK4pD2hdX6bFA2M14tTfk+4CqHtaMH0wmSh6FEUWqQ/Qz3gLcIAswlun4tv4p3s9vZf5ps1gBVqbgRNYDhMNhtqMdompVL3hwPNDtAnBNnMJtHY82WtgLYJ8EzXxtlVeohVsYRgaZdv85uunsU/hUFkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BK6MABbw; arc=fail smtp.client-ip=40.93.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrvbAf9fUraiby32skXN8gts8vr/8NjM7/O0bevNjFkPdeMrHdxX/4L4DfpDlku0wCZhoa2OMqtEaDHRM3uLyJdUOJU21IU0KoCdcffyUieyuUAVZbUdzAWlmituUJwuMWBa9hbGt5jEELmxs+qOoqcxjMer0Dh27LV72l97JcSrZXYRSPDVvzUEr/ksUXPKrHFavtqAlVP57dpy/KYe57TfIntB5J586y3xpieEaHy67qYG3i3KuJBBWC8tfwVp9+9+unT1WgoN/uUB7iOZPNFGiYR1p7XQ5vHdrJZWjlA+cr88GpzeU56VxjvGKL86SzcHaWY6z42W3vIaLPp5sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETzylYvxo+no25cebCAqPKVgGCcMdJ4V8A78Vs2E2Qk=;
 b=YWB/ZGWq/3XRQwWY+nR7Tt5VdNYN4cEBr+hu2WVdqbLyPo1Txt+J41LCtzHo5siixt6j/+p6OuJQRByBWDTGoT56+QSlPE9fuWtlNNYFe15ybXkkLR1d16ekkUNjb/sIlvHBGGTWf3wafA99Ly7ozAQjUG91z0+oWExCfQrLM+a7GzX25RsIc9q6WqNBf6jfcd8V4l0vJh821JSuOhtvNc4xJ9uPXlNWnakwkO2Kd9F2fzQHTiU/ne+sJqONua/80RhWHLyWLFIXI48MWsPElBP64gvt5KYIJmQ01F1I+1xjJfibiE7BkTLS4lyfGixDlB1SWSQl1pp22eFUAAuLCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETzylYvxo+no25cebCAqPKVgGCcMdJ4V8A78Vs2E2Qk=;
 b=BK6MABbwWsXyJP0cloq1kjW8a4GfZjfv6/Khu2fojhuQ7uIIkD0AT96V2P+UrIF+85I0E3wRpXsNquDs3lVRb2Hobyk38/arube1E9j7ISjgXsshTP/eQbjrQ6kwzxbzgWWTq37JuhzLcFTXucy5dHIitXEISEsribyRa/BPvyg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) by
 CYYPR12MB8751.namprd12.prod.outlook.com (2603:10b6:930:ba::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.25; Tue, 5 May 2026 19:44:43 +0000
Received: from DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a]) by DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 19:44:43 +0000
Message-ID: <59f14ee6-da4b-4572-918b-f11059a19d18@amd.com>
Date: Tue, 5 May 2026 12:44:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] ionic: Add .get_fec_stats ethtool handler
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20260501031555.43259-1-eric.joyner@amd.com>
 <20260501031555.43259-6-eric.joyner@amd.com>
 <20260501164142.77cb73e7@kernel.org>
Content-Language: en-US
From: Eric Joyner <eric.joyner@amd.com>
In-Reply-To: <20260501164142.77cb73e7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:40::30) To DS4PR12MB9708.namprd12.prod.outlook.com
 (2603:10b6:8:278::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9708:EE_|CYYPR12MB8751:EE_
X-MS-Office365-Filtering-Correlation-Id: ad784695-956d-4e78-b488-08deaadec12c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zedQQgY6dtPNMAAWH7EC9AYs+WuCR79tFPdi7TbLPS9tXbDhJ3McpW4jMFG3ZKv0c5fVMNJprElMwVobdchgwGt155A3qVmASUzJWn1yjiT+uod/2iR5pgC7yJxRVFGy/hgExdKwKcyku2PZWPJ+xVvp3+3uq2QnXMbru9SSn7JK7w+mBTn0TAOL8N7WA7FybmB6zCYbE5KZW51+cyQ7J5X0WBWf1KNfjTQRa7gNalo9sxImm2M7QRn8XIn/yvZOJg1gRBv+xJclPclAkqWE625uuYqeGn0sca/PMT2G0+h6hqR4JMfqp5jOi13mKhQsQt2jknEWjgmiO75zJrbOxu1glz53X6I+8k6T7wqq36AC8A1e9rqk0j5M0Xc4YAFhR3ayRpuc6InmN40xUrzaEVts4jsl7cBjqHKh9KE1jm7Hwr+oMdyyru34XFJwV2Q9W6GIedo0Be2wFeXtu3IEJmb0D/fPA6+UYJDShUplaVBJGQpFzMMzl0CeXWDNvc9prcC39rPLE3edtX15H227aReBm+ZTjvH9HNzxBjG19S2D6FIBJSJ9mktMvH5Cd2FDBrCJhBN6A5nBPPPxajK3gdrUvXkvYPAKF8jCmHAQXsIX4bCPAzkdwRANqvtHY/OYmgm12shOoMeMjLnmcF++hLEdkIZiKC0mtBjGlNYMS1fuptaPaU1RHtBKrVKnioiv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9708.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmhSQVJkRmdVTDNpU3dieTdaalllT1UvVmRjS3BpWVBHL0M1REozSmNRcWZr?=
 =?utf-8?B?ZzdvZDZ0QTQwZDkwa3Yya01aL3d6QzNYUXpNZzBxMG5QS0M2Q2RHd0NVNGgz?=
 =?utf-8?B?ajdNVDQyWDRJWmR5c2JDanllQWtzTTc5QkI4d3NxTGQzWTRncFNIWkRCeE9C?=
 =?utf-8?B?MnBXVW1Pd0I4QjJpTlhCNFFlaC9VUDd4a25GSVNJUHhIYnI0RmZNcU9seG5t?=
 =?utf-8?B?YmU3R1dnWXdyNkRyQUJyamg2OGJXME84cFQ2bEJ1T2M3MnVEMm5vMjV0Tzhv?=
 =?utf-8?B?OGgySUcxekx1L2JjdDVMd2Y3WkQ3VExCSDd6KzNVaTFvd1diVzZZNHVGdlN3?=
 =?utf-8?B?dWlFUDJoNFdEaGpWN0hIZ0RlT0I4c2toT0FEQ3h6Zm53MGJYR3o4QmxEZjRX?=
 =?utf-8?B?UDRSdlVaY3BMY01SUlUrcUcvVjE2NnljR3dNdWwwMDZDU055Z1RzV0ZZTEYr?=
 =?utf-8?B?d0N0NHdGQ3k3dHE1YjlRWlFWc3I1aVBTZjAvR3pOd043MWdxRG9Cc1E2MFBJ?=
 =?utf-8?B?a2UwcHVxY0p0aXZ5NlZIVEZseiszb0pvSEpTOWJEUkFCVk01NWRoYWk4ZC9x?=
 =?utf-8?B?Tk9lNkJVbWlOUXhDdjlKRmt6ZVYxUTJtc2JYZWg2bE9yNkRkbDgvdXVMSDN2?=
 =?utf-8?B?M3h4K0ZhUmdJbU5vQW5TYWdrWmlwMlY0SU1Qa2dQb1paMDI2UmU0TUJPN0Y4?=
 =?utf-8?B?czNJRExMUWxWelp1YW5HVERhN1pPb0ZabTVWSllPQnhicUtSR1l0WDFITFRz?=
 =?utf-8?B?WitUZXptaEZteUhqang4Y0FhY2pTWE56RllhZnRaYWFFZ1Rjd1QvcVkxRU1m?=
 =?utf-8?B?alFlcXkvbUZjVHFmZWl1dFBTWFl6VFAwbWZyUzlrTWZ4N3o3dDhoR3cvOVFv?=
 =?utf-8?B?MmxTcC8rTGNqaThjN0w3Vm1QZ29nVkpGT0JBUHl5a1hISWxXVGNuaEUrR3dF?=
 =?utf-8?B?enVVTmE5cTdHaFpwNXRmZ1N4UmMrSkoxQ21XYVBRNDNva0lVVUp2NzV3MXp3?=
 =?utf-8?B?TnZvTWw5QlNocWhmSmRJTHcvY2U5MUhqR01mQ0dsWFBGNTBxQzNZQVdEaHdu?=
 =?utf-8?B?QXBLeHFHdEkxVmVMdUV6NElOR0xqbUNNZVdQSEFwZ0R0Uk5kNGN3azNaQkJx?=
 =?utf-8?B?VWhjWnArT1NkNDdPMEpRQUZTRzJydm4zQlR0NGx4UCtYKzdaQldOQ25XdTFj?=
 =?utf-8?B?WGtMQkdZVSs3aWNLd3R2QUtDMDlRVjdyQktyK2ZMQTdZOEFndUVaais2SWNq?=
 =?utf-8?B?ay9xRFZUWkpRWDVORGxsZkxMR3R2cEMwbXZodjRtWDV6L1pkenp3NVZ6R0ZC?=
 =?utf-8?B?RzNhQjRGeEF5MmI0N3JDT3JyMWw5Z1VPMUZqQ3hvbmEvNG1zUFprYjBRdjll?=
 =?utf-8?B?M1pGejdjb1RiVHFhb3lxTDRaTmllbjhnZFhQTmI3cFBUNU01SnB6QTNLOVZW?=
 =?utf-8?B?WXMzaXZtcW5YVU5MNGwyWUtYallDMjNOdm1GY0lMc2xmN3l0OWtna0hCTDFP?=
 =?utf-8?B?WFQ3bHk2bDRvNWJBUnBNem84QlVnSHhwQkprb2RiSDY0VHlsbHdIeThyM2dt?=
 =?utf-8?B?cHZRWnZOTEhxU3hLczZqdWRqNU9oS09yZHhmTHdkcitNbU15OU15eEc1d05r?=
 =?utf-8?B?ZHZYSGVKZWYrdHJOWnhVYW5DanJZMUdPeFBlNlFWL1NLUXZ4ME5MM1dnWUdk?=
 =?utf-8?B?K3hDenNpUkhxNU8zclVOWE9mbHlFYjVHQlRLVmhXZ05SOFVrREFKT3JTRTRP?=
 =?utf-8?B?ZkVlZCs2dlZaUGxkSnd5OC85dGd4Z1lXSGE4WXczeXF0WUhvaFJ2dGlOQ01J?=
 =?utf-8?B?TGtwaWxrL01FZmk2YUlwUkhTV3Ercm5EYXRDUEhGYTRQZU54Sm8zTDJ5SlZM?=
 =?utf-8?B?RE84T3A2U3pKQU05OU5VRTRLczdjUXhvd05yQkUwYmkwdUE0bnI4RVUyaEtF?=
 =?utf-8?B?Z2ZmN0ZjUUg4Q2w2clJrNlpQNm1XYVc3RFZhYXVrb3VhOHhWZVRTLzNYK0sz?=
 =?utf-8?B?VTBmWDV4S3NxcE56ZUdNMlE2RFBXUlArYUJZNnd1bEdJNzBjYVpFc2ExVkVM?=
 =?utf-8?B?YlZsclY5amduajQ4d0hNQjluVWVqZVY1QkpSdnA2ZkE3eWFoelluV2xiWkVG?=
 =?utf-8?B?ZFUwaVRBTm9mRzR1VmhjR3pZb1lqNS9VL1UzU3RaLzR6VnNUbWtEQkV6OUlh?=
 =?utf-8?B?YVdNOEhjYlpzZUk5UjhsOHhsUE5jUllTR3NmZUNGQXBEbjIwUmpWYUFRZW5m?=
 =?utf-8?B?eWFBd2xueUE0ckp1c0hsSmVHUjZmeTZycXB1UUN1Um5rUXM3RjE4WFp4bXph?=
 =?utf-8?Q?OHnNYDdavsTtEHaVXX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad784695-956d-4e78-b488-08deaadec12c
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 19:44:43.5835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkvmlZdPh4z+3hCG1juOPgjDR9RkTDj6HtnKIWh0xjJ51iLT2IwCDxOGMTblp9aC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8751
X-Rspamd-Queue-Id: C4E174D3388
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284573-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:dkim,amd.com:mid]

On 5/1/2026 4:41 PM, Jakub Kicinski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Thu, 30 Apr 2026 20:15:55 -0700 Eric Joyner wrote:
>> Several FEC error statistics being collected can be reported in a
>> dedicated ethtool callback for FEC errors, so implement the handler that
>> does so. This includes 802.3ck FEC histogram data that some newer
>> hardware collects.
> 
> sparse says:
> 
> drivers/net/ethernet/pensando/ionic/ionic_ethtool.c:449:37: warning: incorrect type in assignment (different base types)
> drivers/net/ethernet/pensando/ionic/ionic_ethtool.c:449:37:    expected unsigned long long [usertype] sum
> drivers/net/ethernet/pensando/ionic/ionic_ethtool.c:449:37:    got restricted __le64 const

Yeah, I'm missing a cpu_to_le64(); I'll add it in the next version of this patchset.

- Eric

