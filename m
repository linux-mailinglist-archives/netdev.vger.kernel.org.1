Return-Path: <netdev+bounces-284572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFUxMolI+mmJMAMAu9opvQ
	(envelope-from <netdev+bounces-284572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 21:44:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 572594D336A
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 21:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA9083016B40
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 19:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9DD4A2E12;
	Tue,  5 May 2026 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZAVCW28h"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010029.outbound.protection.outlook.com [52.101.61.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A0E3CAE7D
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 19:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010247; cv=fail; b=lEbQ0C4tQ5p8q1fpQocOJ0jMvC2yZk9WtTJmfMb1UMZqB/Ce6W205hgHhbxqZzPKapvDIqwQCRVBBRtlpCE9IDvDzPRMXU1uOFbNHHUcGtOmfBFQvSIHSLzAlqdmqAVpkgEeTG1HrREgPIpOEZrOEwMIVDM47UCadJ1lqQ9lLiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010247; c=relaxed/simple;
	bh=7F1JEqpP4q4Yqugc9zraECEh8KSRGEm/6bWpA/3Xg1k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j7QWbl8HzRqeRHMyNSSt4o0in3JkBwsQ+ko1oLaoGoa56Qu/+kzEnKVdmwaQ8WVlsbhJ+CgPBQ4plla0bFs/f8nGBD2zncsEVvxZVm9xV7lWWdpMLxXUn1NMRC+4aNVYZVRERNMXebAET8KEXZsu8AyVj6EeXbP5lT5IsdYlm7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZAVCW28h; arc=fail smtp.client-ip=52.101.61.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+ANyF6JKGwIBfNAYByqGbjMTEC8vgOvn1A00/er+wHwxRe12HPU3BWfqjzSf6XA/cexScgEJhPAjoGKecYREstFEwRH+psygOfE9qf4+xKo0flItJrJcNyAUjmS73Bdc2du1UGZDtZAaG0OartFbysod3zKiJ4jU1lYzX9GJFpqk6t+ikzBRQCuwAvwaiBv/TODAzPbMBl96mBBm7cswVMBNIzxLvzDQShERJTmUz/D2KMh9vHNtT3PfcJj5jUQMElNmatRinS7FgWwcHgiNhqPRfnkXC0fjUkG1QwwUd/AH2Ti2Yoe2cbOOJnmfCtmjcJOQWGOdl5XCCxSY+gzIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioW/QTcqmnE8SoJzsaU6tJrLicZzay0vE35QI2igXHM=;
 b=TrS/StmgBRreMduddHbgTBH9eA5lUADhcOTCdSwkaRcUFIYsSgfcNPcoc67YL42zvA0ax376504Ww0n+rG3i2gd8tCWjzEjFAjlzxWlw1G6wdafdZ19IhTHkjP/GTkQmJbAIWtD3SKYz44quBu5n+IgS+4vJFkL9cMJospXtlYj/qrOfDdq81GtgQFgYsxl+wmhPxC+7w5QniAO/Q99UVt0SaE+EXIJb8cJXJrtECu0UL/7KoLAXRoNP9tzeCz5ta6/iFajvmnwkDiUx7ASUt5gZjws3s/oLfTBpWydIWXXsYDWVH2Ujh6MRfcJAase7fEMrcAIK3b1YUWXKKpWWUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioW/QTcqmnE8SoJzsaU6tJrLicZzay0vE35QI2igXHM=;
 b=ZAVCW28h0jtO1a7+w3jRw63pqALNjn0GBNGt9q9f7Ygt6tlSyiD/Rvm6VNOwECwuwtsuRgM3UvVnBceRUpMSEfSfyg2p6nMSHZAJu/iB8uO81oPd22C/5nHZdTIzLVzjCkQRN4FpQJvaB4WjkjH7W5kYKUO9zbZCqkL1ylXGGig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) by
 PH7PR12MB6442.namprd12.prod.outlook.com (2603:10b6:510:1fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 19:43:56 +0000
Received: from DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a]) by DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 19:43:56 +0000
Message-ID: <e5d3c314-e6b0-4f18-b17e-752fea4dcb16@amd.com>
Date: Tue, 5 May 2026 12:43:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] ionic: Add .get_fec_stats ethtool handler
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org
Cc: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20260501031555.43259-1-eric.joyner@amd.com>
 <20260501031555.43259-6-eric.joyner@amd.com>
 <6eabe3df-08b2-4237-a989-a8e3a9bdf37f@linux.dev>
Content-Language: en-US
From: Eric Joyner <eric.joyner@amd.com>
In-Reply-To: <6eabe3df-08b2-4237-a989-a8e3a9bdf37f@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:a03:40::49) To DS4PR12MB9708.namprd12.prod.outlook.com
 (2603:10b6:8:278::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9708:EE_|PH7PR12MB6442:EE_
X-MS-Office365-Filtering-Correlation-Id: 75df6c44-a863-44ef-b212-08deaadea50a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jtac02Yh3ladjGveLZ2cZWuYonaQMRWpd10YBLnTmLkEMmTmd8caq8E6UwoowwuOQzlPSZnx5cvArQTlFMngYrXWWIMUK+wyFUYJ+QRK3FZa+cJF7nXQClxTIDybhLm1zSL43oyiOUhi3Vh4VwO4XaFRBZPhjMGew7ZpGbsyVcEQCCYRCvWywcUBIOkCl33bcHcVwCmhffs0YbnVF77Xbt0Eb33YyhUmO1EOIKhqcW+NopmdSo31mTfIXWT0Trt1GN9KLGnpnNXAEy/z/xFu3U2ugb5m3t873J4IeM00C03oVBvY9SzFXdSvN0325sabP+G/+LoDs6XR6JLOucpGkDyDivzncv8oOjVVhfTIUDGhHwUHQEG0J3F0vUkw6ER0xd/4yEld+G9vGKMgIyAc4z/CbrB0GD5idhjb0+GG3KV4KoXhKnazKxOJvJqw7vXnAop+bRBorNKUNAzzLCiHiLZ42mAFFfkuKfaeLjNjL/deIIqcFfmnUTG+LWO7dhitBj7awCi07S6qCmwOHWjv2DG7pbpZFxSPO2hxC7R/BBmUfDpfs6Sb3ez4BY1pO7uKZrEpguIa6zTzwgTIsBd7EZack6AISuSEkKqawTbHcqnonBsQoJD+f1c/ouj/P5UsQX0NRqQbHWlgntCRRUDyOVJR66v6g0VsLJXl63DCQqmYqwc9tR9fgeYpeXlKquk2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9708.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUY0U0dkYURvTnJyV3dOSGl0K3MwM09qTjVubXg0cHlJMFlsRHQ2d29JSTJr?=
 =?utf-8?B?UTZmT3d0SkVjZ0NIMXRocFhUblc3SWgweUpBZ3E2YmVZNktsc3lFYmFnNmJ2?=
 =?utf-8?B?b1YrS0FWZXRQYVJYZXRCVTFMNkl3V29JcUR5VTQ5SjFaS01INDAxV3FoSFRM?=
 =?utf-8?B?VDZud2oyV3NLTjBScmJBWGlHalY1bzMxQmlpbUdwMzhObTRLVDUvQU16cmpJ?=
 =?utf-8?B?dXd2RlhXYjlDdjRmMTNPSXZ2MVY3UkZTTGNFVDVqRnhFREVoVGpXa01URVR0?=
 =?utf-8?B?ZSs2MnBwKzNZRzFnWngvbFRZME5uL1NUSDBtVGtsVko0RlF5c2hCVGp1WEVy?=
 =?utf-8?B?VFBlYjNoOHpuSFJFWUk2TlRpbHNOeXU3WjdURnRNU2tzQmpLazdWVFVENmZR?=
 =?utf-8?B?bWtJRlMzM3hzM25wcWZvbVVRem9aQ3oyNnF2UkEyWXQ2dzM0Ny9oRDdMYXFH?=
 =?utf-8?B?UGx5ZDRqeTQzRjVCa2g3MmhQRTExNk5pNDh4YVdhTHZuWVBwbVBLWGVRSjV2?=
 =?utf-8?B?cjVFd1BFZmJkSEZyUVlhY2ZaSzVPLzZsQTEzeVJxK05SaThLNlhYOEtPUjM0?=
 =?utf-8?B?L0JjTnNmSmZyai9BMWZoMFhaTlVyTm5FY0c5YXppdkF4MHFOV2NVeDFYYUtT?=
 =?utf-8?B?c2Jwai9LaDEvakJvVVRGdFpNQWdac3hSRVhJWFdJSGpDdjhqWDBSVmpDN2Y0?=
 =?utf-8?B?SEMvMXZTMUFaNEphTmRSZjJQNHB1M3Q4TER2N3RtYTlRdVpQNWUzb2FURWhD?=
 =?utf-8?B?WUpCMHdPOHV2S0IvTmc0dEJaL28zWjhPZEZLSUpSbWlWNTNOWGphY1VaUnpB?=
 =?utf-8?B?aGJNZHRkUWZqY1o1RC9JdDZxTjFhWDR3dys3MEdEUkZPQnJocFUyd1p5WHky?=
 =?utf-8?B?RGQ4engyRDA4V0szRk9CdDFkTFRjTGM5V0p5alRFRnRFd1FGZ285RFp5YmdG?=
 =?utf-8?B?dGM5c2ZWeC9HbmRFclNWMUZvVmlYZlladUdqV0FHYUc3SkkzRDV6dUNBVmw5?=
 =?utf-8?B?TWhEL3U4cjl4V2w0bU1ZbDlvTHZoUGVWUzliMTA2bFJHa2xFRFFUSkhkYTU2?=
 =?utf-8?B?SmpMdnNPRmxhbUN6cWozMGVkMzAySHI0Wkh5a3NOUjFUd1MxaHdZb2hLRHJF?=
 =?utf-8?B?MHRNNm5jbkxzaWJBY0t4bUorR3BKV2xvOWdvT0pqVkdsSkRiM20vSmdFYzY0?=
 =?utf-8?B?K1FZSjc3ZGw2MGZ0N2tEQmRQbVMzaUNZU05ydWdxbHJnS0YxTS84WlgrZXlI?=
 =?utf-8?B?a0hKVG5UTmxTUngvYXdPc1I2YnI4N1NMeTVZK211Y2pmWTFYaldjbXBWV1lj?=
 =?utf-8?B?QVU2c2NJWTh4MVAvU1dxY0hQdjlUbTZjUmh4S0k5VVcwYjhVYVMrT2laa01Z?=
 =?utf-8?B?eEcvelB0NHZBRk94dDJZVCt2MFBybmhrZGl6Qy92TjVqQXN6R2FFQmw0Vk0w?=
 =?utf-8?B?dzhyeEpCWGxCelVUWFlBeTlseW9PSHJGQUZUeTVCOWZOWnk4Q1d4U0RGN1hD?=
 =?utf-8?B?dElkd0g1Nk1Zdkl5UWFQTm5WazVIN0tYbGE0RXZ6Mis2QTBMbW52YUN2MHpX?=
 =?utf-8?B?cDdTdzhJM282SmhSNFpRM3JjR0J4SE5Jd1V4a1c0K1JZUWVmMll2WkhaclpK?=
 =?utf-8?B?OWdMa3dSZ1JxNytpSUt4bEdCY1ZaSHAyNG9NdFV2M3B6SkV2dVM3QjFpZnlm?=
 =?utf-8?B?VHlwa3JTeWJaNllkKzVkODRFSWxiaDl1dFNFMUNod2JObEM5TEZFc0xpOE5I?=
 =?utf-8?B?UHFjMHA1MUs5TXdLeHQ4VFB4L1laVlhTUmhSNTZuNDFOWWc5Rm1VblE3N1Bl?=
 =?utf-8?B?VnlLT3VMa3BqZ1QwVTVpdlVlVXRaM3FHSjVVN2ZLdldpUHBRWEhTU05aMzdk?=
 =?utf-8?B?SnQvUGlFQ2IvTDNJcTZENG5qS1hDZlo5elhuTHZvWnVtdHBZdHFJZ0ZIZ1BQ?=
 =?utf-8?B?MTRickNXUExzWmljSjBON3JYQTk0VDZBTXZ6TnRvTlJndXBjMjgzUS90ZjBm?=
 =?utf-8?B?UlVhalN2aXVwdG1vV3F4Slk1R05VSnYxWlVnRmRZYjloTHpzcVZMSWQzZjRL?=
 =?utf-8?B?MVExNlFRV2tnN3p0UGd4eGpERDBJeG1jMHVTOUIxandZNU5qRzJxUVlPam5X?=
 =?utf-8?B?UUdqTjZqVGN4anBDVjh5UXFPSVVyT3c2REJWTFpmb0lFZlpIdlBvMTFuZ1lU?=
 =?utf-8?B?dkVnUDI5WHJCeFAxSjhQcjNpdnUvMHoyVG9wSEF3MURIT25kdktlWGhnYVBa?=
 =?utf-8?B?OXcvaGJXVk1VT3hNUy9KQ09aOHdmNEdxeWdKMTFPMWVSREU4MElyZ2dVODUy?=
 =?utf-8?Q?E13k8WxLfSQN9eFatX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75df6c44-a863-44ef-b212-08deaadea50a
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 19:43:56.3075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/Et/aiNLtu0wIwk9s1pkgqPrY5tJnDcDOdtV4ix+FNV1EhUXTvQPWGrIjUjwUeY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6442
X-Rspamd-Queue-Id: 572594D336A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284572-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[aka.ms];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,aka.ms:url,linux.dev:email]

On 5/5/2026 6:54 AM, Vadim Fedorenko wrote:
> [You don't often get email from vadim.fedorenko@linux.dev. Learn why this is
> important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Caution: This message originated from an External Source. Use proper caution
> when opening attachments, clicking links, or responding.
> 
> 
> On 01/05/2026 04:15, Eric Joyner wrote:
>> Several FEC error statistics being collected can be reported in a
>> dedicated ethtool callback for FEC errors, so implement the handler that
>> does so. This includes 802.3ck FEC histogram data that some newer
>> hardware collects.
>>
>> Assisted-by: Claude:claude-4.6-sonnet
>> Signed-off-by: Eric Joyner <eric.joyner@amd.com>
>> ---
>>   .../ethernet/pensando/ionic/ionic_ethtool.c   | 51 +++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/
>> net/ethernet/pensando/ionic/ionic_ethtool.c
>> index 78a802eb159f..fe1f753b6115 100644
>> --- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
>> @@ -418,6 +418,56 @@ static int ionic_get_fecparam(struct net_device *netdev,
>>       return 0;
>>   }
>>
>> +static const struct ethtool_fec_hist_range ionic_fec_ranges[] = {
>> +     { 0, 0},
>> +     { 1, 1},
>> +     { 2, 2},
>> +     { 3, 3},
>> +     { 4, 4},
>> +     { 5, 5},
>> +     { 6, 6},
>> +     { 7, 7},
>> +     { 8, 8},
>> +     { 9, 9},
>> +     { 10, 10},
>> +     { 11, 11},
>> +     { 12, 12},
>> +     { 13, 13},
>> +     { 14, 14},
>> +     { 15, 15},
>> +     { 0, 0},
>> +};
>> +
>> +static void
>> +ionic_fill_fec_hist(const struct ionic_port_extra_stats *extra_stats,
>> +                 struct ethtool_fec_hist *hist)
>> +{
>> +     int i;
>> +
>> +     hist->ranges = ionic_fec_ranges;
>> +     for (i = 0; i < ETHTOOL_FEC_HIST_MAX - 1; i++)
>> +             hist->values[i].sum = extra_stats->fec_codeword_error_bin[i];
>> +}
> 
> ETHTOOL_FEC_HIST_MAX = 17, you defined 16 bins, but iterating over 15 of
> them. Looks like bin {15, 15} will be lost in stats.
> 
> 

This looks correct to me -- (ETHTOOL_FEC_HIST_MAX - 1) = 16, so starting with
i=0, it'll iterate through the 16 bins and ignore the 17th end marker bin. Bin
15 does get included and gets its sum set.

- Eric

