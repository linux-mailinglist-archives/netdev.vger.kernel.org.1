Return-Path: <netdev+bounces-297874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mBqOBQMMKmpYhwMAu9opvQ
	(envelope-from <netdev+bounces-297874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 03:14:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E1C66D9B7
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 03:14:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=B6RRhqQ6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297874-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297874-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BC5730C9207
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9CF1E7C2E;
	Thu, 11 Jun 2026 01:14:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013067.outbound.protection.outlook.com [40.107.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5C41E7660
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 01:14:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781140455; cv=fail; b=J0AdKN4yVv4AC3sK4iwQwLfwqcBoxKmKpl4xtgt/Bp4jtEuBOn45zful2HJKCAS0mMgGXEYSQtnK1B1LKQDPyxdsQYt7qrNZVwOHGt1fBQI72XfRFdMnreyfQY+bnG1MAZy4gpOaeZZEiGaPoPh0341iRChZeyVFGZfPa7I/9z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781140455; c=relaxed/simple;
	bh=c7F2V0NNlbHMDHfahyzIxCycxd4h/djZxzVOhp9eLIE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s/00O0TSaBzaKCLY2pCiUWjjaVMjEjQcStuRSaDr34jaikeKhh51djGpwGjfi42Qz0zQyty5yqq3RS+R5Kgw4MEJqiaTrLbJ+65BlBv5sT2ZYrcgYuVa8oz6VoQ4A7H66CdZYoFRAkQzSPynb2FR7yHqoT6rDrPWBx6KaL96hKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B6RRhqQ6; arc=fail smtp.client-ip=40.107.201.67
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDIA/JZW6EZXmsRB2UDXZVnvBebt6S79TatavS9V0qKvbnGL5JO47Ysdjb3Wn9o/HMiYO+kS/WhsrVqo++YHyAZoOCT2jDlu5iYUL/5J9kQ3Y9+004eekP3K7SCmd+jo5riCUObeW4JVbE4tFA/kK5pGfVYExbQ/Aaew62xgeou70JNi15kpCYaf1SNdoCbfmIgHUGQ1w34psyxCHIT9iSG/Kfx2ra4tTvXQt6awqmmn+V+HxqH3pAiPxVzxh2BM7huhv/sZ0V1x9fAqNLvn/+3LxbEnbZRtYoqTp2I63XSA8lf1tS8Ghjmy/BCPHp5qrmnw1AO7apzwjbe3XJQPNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yc7k/og2OyqFuuCHEljoIKdmE0wVKrdBpxHzxnjs6jA=;
 b=I/OdXs3uopwOfxMqlXxg9QxFNAqgvtQrPfmr8GvITJUyvoESv3pEhRrOORCXhtTDycgPjKfyNcnsqSNGjIFPhQPoT8yWsQ31LhAISZq29CmEmUsz1F0dfXRpohvZAz2oPRjqpoylXOAIkr0QRSbSv68oSCTHl7xL9/i3gXEpktrzTnv/RlxyLvNg3CMQNrNHZAJW7dPX+HhHyUGg76gIC+ZrPb4WwVVN/vM0wQOBD44dCTHt8DtWltEeEl/dXy5h+g047fHQtMV57XMQYrdsh+wXi85SH8i/8g2srA4fFPJvxUHiHRHspTxhXgStp3NpiIXiC4TCKUKjUNsweOUAPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yc7k/og2OyqFuuCHEljoIKdmE0wVKrdBpxHzxnjs6jA=;
 b=B6RRhqQ6Wf1kwzzYE/vNU36/6+FkwEYF586LYM7v0ImEYhfirPo6dnvvoaa2XIZD5FToEZQrJYZRdFLRRac2uwiC3RBGf45VkOhVO+lyeHrJE9/AJyHWUJrPWc4W0YOtZEqR6vEbvnDKONLSy5VL0ccgYdYRzsJsgRlgrvvJlhg=
Received: from MN2PR12MB3485.namprd12.prod.outlook.com (2603:10b6:208:c9::22)
 by SJ2PR12MB8805.namprd12.prod.outlook.com (2603:10b6:a03:4d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 01:14:08 +0000
Received: from MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9]) by MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9%5]) with mapi id 15.21.0092.011; Thu, 11 Jun 2026
 01:14:08 +0000
Message-ID: <75c74b95-097a-47c9-9a55-a4150394abf8@amd.com>
Date: Wed, 10 Jun 2026 18:14:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/6] pds_core: Add PLDM firmware update and
 host backed memory support
To: netdev@vger.kernel.org
Cc: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>,
 jacob.e.keller@intel.com
References: <20260608223256.12357-1-nikhil.rao@amd.com>
Content-Language: en-US
From: "Rao, Nikhil" <nikhirao@amd.com>
In-Reply-To: <20260608223256.12357-1-nikhil.rao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0383.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::28) To MN2PR12MB3485.namprd12.prod.outlook.com
 (2603:10b6:208:c9::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3485:EE_|SJ2PR12MB8805:EE_
X-MS-Office365-Filtering-Correlation-Id: 39662014-b229-460a-a3bb-08dec756bd00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	V0C7XCd0DNw5wnCPYPmDf8EAV7VRUKBeDxCd/fbyYtiTXNXJ21udRO0IStE+NpFxV816q0v3cerniOilncdexrrPX2rVC0HCtyOANEa7LANhDkndz4UvF6Wcw9fowB+SQcflIZrHSRU5tprbTTVNxzga7YQn3VlJZEP4keZ2FWQhHp0Lhj/IL5ZOoqwrsL2aplK3a1/4usXxG/BeK+dJ6hXqlWXeD0GwlXSbtJzOVgvz3VWjpx9yu5uZMpd1tAwUr2fW2BiXVucAjUXB/5CnLkx7oLfHZI/8o5CaiDjVIG8c4xBEdM5kTfWJdNnp0f+wdKl4i5uW7pTLytyKPSoYhBbBTID1D7+6pw6/dgav3XbAebRash6v/z19KZeeJeh5wLACX4FUP1ptAo2ry3+IHBzSYy2N2aThv1oczJc7N1HrR9Tx9vMsf3J8zYW9MprF6OQVPc57jd/7ClFfQYUI5tvWCsiB8YxVLVdXQhE4Qf1q8Pfe9IKgyxnpR5lmEO6HE5nPyBTcjvG7hdZw65yRTqG4zvtjWenk0Mbyf4Kc8JYd2SDniR/5lw+aeq7sOX+RQPQR/YqBKXT1oZQUvTheCQYq7EoV9A9DjbMWjewnIPIE3sbS+7U/VjDeTRSMVS1szWqFCaXF4xnwf4QTNVZ7qPW4KbB0fVM9GTy9FFBUMYotMln06pi32UOXSYJFnUO9WWhFbeL+3D5tOmWAkk6k2w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3485.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDlEcmlUNzlYV1RkVEt6ZjlNU1Nlc2FXNkEyblBtZWRRbmRLbEJ6aitzdzN5?=
 =?utf-8?B?SFdxRGt3OGpaOWFxNFVpS2E5dWl1bU1hRDhYZ24vaXhDUm1tbm1iZHR4QjlO?=
 =?utf-8?B?YnFGbE9WUlZ5ZTZpaDJVZHYzNE8wN0dRRzlGOHdPOWc4TGxKdU1hLzVDUkI1?=
 =?utf-8?B?dDlROWdjZ216cVhFdTVJUXg4MHVCc1VRMG40dU4xL1FDMDZQUEpGLzFUNTRF?=
 =?utf-8?B?MjU1YmhuZU1MejQ0bGVDMFJFR2JnOHhHWjNSNkROazY3akk5eHpGc05rSzBI?=
 =?utf-8?B?TWt5bnRjejE4L28rc0NURGgybEtFNUpNTWtWK3Q4RGM4enY4Wjl5OFJmUDJF?=
 =?utf-8?B?K2YySjcxeExBc0hEcGxVVERwSlRsSzF6a01JMm5PK3FhcHRuU1VjVkQvTlhK?=
 =?utf-8?B?MCt5L1JnVkh2M0dYcnRQMjdkSEhqSTBub3l3RjRKM3lXSG9xOGxlRXJ4NzAz?=
 =?utf-8?B?SDA2TlZSN1ppUDJPOUU2LzQ1Y0M4akhXRXNQSVdPbDYxMW1ZTk5nMFJnMHh2?=
 =?utf-8?B?dFhtaEtpeTBVdFBtWE5DQTBQR3A2MmhyVDA2K2R1OCtpNVlqUWI2bkorVnJy?=
 =?utf-8?B?SEgwTGZvZm14eklyMkU4amNGUjd0dlRoVFVBVkdRanlxWXpiRFVRbGt3MUQz?=
 =?utf-8?B?ZFo0Q3NNTFhzdlVJVjl3enNoblI5NHFTbzN2OGdjVlhrRkkyd0FiQ3lhWmlH?=
 =?utf-8?B?NXZaeUxBRUlUUDAyT25wY0M0cFlZSmRoK3NKaU1Sb2wrSU9NYll6Y0owYWd5?=
 =?utf-8?B?ZDl3MkU0MXN6QStKUEZnQ0d4VHFaZTBFSkt0TEJTVmVzTFl2anI3cWNEU2Ex?=
 =?utf-8?B?TFp0bVk5KzJBNllzdWN4cXFsenlET2NlbXU2d2FXcTUvL0U5ZjlMOHNULzVE?=
 =?utf-8?B?OTdqM3YxTGtCRnlweEZHd3dHSUhORVM1YXlUbUpyOVdsNUJLTElDTGRwb0k4?=
 =?utf-8?B?OGhaN0RkL1czT1NEUkNteHRJY3B4SktZMFk5OXlHNEQ2STNSTVBaZWFFOFlZ?=
 =?utf-8?B?bUl6SWw3WUw0R2Q1Q1RxaVI1ZVAxZ1ZFV2dNUDhCVFlicXdYTWNWY1RoY1Bm?=
 =?utf-8?B?WXBQTUVrYUdhSUdNbzY1Wk5tMkJZTVlsYS9vNXZ5M3F5dE9IQmh2L0w3UXNH?=
 =?utf-8?B?OUZGYmoxQlpHUE8yMFVxN3VzcW4rRVdSYU0yRjByVTQwQWRhUVlNa0gyb2JB?=
 =?utf-8?B?TXF2OERxK0FJZHM4U3Z5bFBwaDVqT1JablE0Uk9UdWNPc3dEbTFIRUZYSExa?=
 =?utf-8?B?cHQ4dTIreUkwMG1BUnAreTZJOVd3Ti9RZ2p6TTlzNVA5dlpiREJLcFRWckNs?=
 =?utf-8?B?U3BFN3lGWVZmUDJaMitjZHJZOHZZcS83NW9iU1NCWkxlTjBRa1BuOW0yMHp2?=
 =?utf-8?B?dUtBdGNFNWdMcDVQYUNZYU1EWWF5N1dJdWJmREFobG5iQW12ZnhRTk1iNjNT?=
 =?utf-8?B?c0FPZ0Q1bXVUWk1pRmFWb0RaQXBqLzFteTRoTzdMalBSSkpaTWwrWDN5SjU0?=
 =?utf-8?B?QmJoM3N0YjBYeS9zR2ZPcVpta0FxcmVlMmVsNW9lSElKUVhCTjBzR2pWOUF6?=
 =?utf-8?B?NUU2a3ZDckdKbEM0aml5bjZTMXJXMFBBL2pZVjgyakZVT1RrbnF4ZUxyMDBH?=
 =?utf-8?B?SGJUbDh1emJVOS9MNC9UQVo1S2tZM3E0WW9KdS8vMkJ1TXA3SDRSbC9BUE01?=
 =?utf-8?B?TSs2WFdMY0NkTG1VNk84LzQ1ZUJ4YkVkVzhTeDVhTSthUXFzdjFiSm5nbUlz?=
 =?utf-8?B?ZHNLMW1VdXZ2L3kzdStubFprVzdBajlsbi8xVTVyc1MxTE5nTXlVZHZTOVFD?=
 =?utf-8?B?VnNoeGRyZ0IzMWhaR0xKMWIyM0U2NFdNaDNWd2FIVXhPQi8wdGo3L2p2OUpq?=
 =?utf-8?B?Y3ZVWGUwQVl3SzIyanc1K0gzUXlYTXh6MUUxQkxaWDJiU09BK3BpakNZT1RV?=
 =?utf-8?B?RjNoRjQ0VktZcjZwNjlBM2xoWk9wN05FQ05oMEpiMGN5c0oxR1FjNnNCTjl2?=
 =?utf-8?B?eGR6V1UvU1ZpWW1jSzkySkdXQmh4RGNueHVnbkdEVkRTRmJXS3pZQkxPTUFS?=
 =?utf-8?B?RnVCdVV1UUNYNFVHK1hKeVVMN1lraXVMeDE5cGl2emZIclQ3U1k2bEtRMWtQ?=
 =?utf-8?B?QjFWYWZ5MEo0NDhqN0U1WFRwemlXVHhxd0RwWFVveG1HbVVLUmZpRGN3MzJY?=
 =?utf-8?B?M1NXYlpFKy9Ucms4Z1ZqQlluaWJEOVJORmIwc2t4d1Z5WlQ3NjJVTjhtYVRD?=
 =?utf-8?B?aWt5NldrZk42QU1IT3hOaTVhVUtINXVxQTF5QWIvaGF1dk96Q1lSOUxuSXhF?=
 =?utf-8?B?dFVKdENjenUxWFpwaEZFOEYxcmVoMm5kUnlDL3BPajVzSTNpUU5jQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39662014-b229-460a-a3bb-08dec756bd00
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3485.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 01:14:08.6979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jc8x4aIbRGrPp8HcjrDWzNTGcahdu3O+9OgKKWO3PSdr3watonMe1YvGGePqladaiH+mvICJppGgQVJtaKF4rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8805
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297874-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nikhirao@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:eric.joyner@amd.com,m:jacob.e.keller@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhirao@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85E1C66D9B7

Hi all,

Following up on the sashiko AI findings for this series.

=== Gemini Findings ===

Patch 1:
 > Workqueue use-after-free in pdsc_remove()

Fixed. Sent separately via net:
https://lore.kernel.org/all/20260610025952.196470-1-nikhil.rao@amd.com/

Patch 3:
 > DMA use-after-free with deferred DMA

False positive. The devcmd interface processes one command at a time
in firmware. When a command times out, the DMA buffer is added to the
deferred list. pdsc_deferred_dma_free() runs after the next command
completes - and that command cannot complete until firmware finishes
the timed-out command. By design, the buffer is only freed after
firmware is done with it.

Patch 5:
 > Order-10 (4MB) allocation is fragmentation-sensitive

Not actionable. IOMMU cannot be assumed on all target systems. CMA
requires boot-time reservation which is not practical. Allocation
failure is handled gracefully - firmware operates without host-backed
memory.

=== Claude Findings ===

Patch 3:
 > DMA-after-free in deferred DMA cleanup

False positive. Same answer as Gemini - devcmd serialization in
firmware guarantees the timed-out command completes before the next
command (and thus the deferred free).

 > pdsc_deferred_dma_add() runs outside devcmd_lock, ordering issue

Not a bug. The race can occur, but it's benign. The entry stays on
the deferred list and is freed on the next successful command or in
pdsc_remove(). No leak or use-after-free.

 > Spinlock held while iterating unbounded list

Valid observation. Could splice to local list and process lock-free.
Will address as a follow-up.

 > extack never propagated through PLDM update path

Valid observation. The PLDM update path returns errno but doesn't
populate extack with detailed messages. Usability improvement, not a
functional bug.

 > F_UPDATE_BY_NAME not checked

False positive. F_UPDATE_BY_NAME is checked in pdsc_dl_info_get() -
it sets DEVLINK_INFO_VERSION_TYPE_COMPONENT. Devlink's component
lookup only matches that type. Components without the flag are
rejected by devlink.

 > version-0 returns success instead of error

Intentional. Version 0 means firmware lacks component info support.
Returning success allows legacy/full-image flash to proceed. The
warning prompts users to update.

 > Vendor-specific component names

Compliant with devlink-info.rst. Driver-specific component names are
allowed when documented. These are documented in
Documentation/networking/devlink/pds_core.rst.

 > kdoc "only supports" wording

False positive. When the capability bit is set, driver uses PLDM
exclusively (no legacy fallback). The kdoc is accurate.

 > Various style issues (buffer size, redundant condition, variable
 > scope, slot_id type)

Style. Not bugs.

Patch 4:
 > Cache check can't distinguish "never queried" from "returned empty"

Low. Valid edge case - a "loaded" flag would avoid repeated queries
when num_components is 0. Minor optimization.

 > Error propagation changed

Intentional. If component/fw-list query fails, driver still reports
main FW version.

 > Warning message says "component info" for V1 path

Low. Wording could be path-specific but functional behavior is correct.

Patch 5:
 > DMA cleanup teardown lacks firmware handshake

Addressed by fix sent via net:
https://lore.kernel.org/all/20260604213637.3844317-1-nikhil.rao@amd.com/
pci_clear_master() is now called early in pdsc_teardown(), before
any memory is freed.

 > Streaming vs coherent DMA

False positive. Host memory is for firmware use only - driver doesn't
access after setup. Requires contiguous physical memory without IOMMU
dependency.

 > Partial provisioning ignored

Intentional. Partial provisioning is acceptable and documented in the
cover letter. Firmware operates with whatever host memory was
successfully allocated.

 > Comment about truncation is wrong

False positive. The original code used PAGE_SIZE << MAX_PAGE_ORDER,
which can exceed 4GB on some platform configs (large page sizes +
high MAX_PAGE_ORDER). Fixed 4MB avoids the truncation. Comment is
accurate.

 > pdsc_stop_health_thread() should be separate patch

Functionally equivalent. pdsc_stop_health_thread() adds a redundant
cancel_work_sync() but destroy_workqueue() flushes anyway. Leftover
from v2 when pdsc_host_mem_del() was in this path. Can revert to
timer_shutdown_sync() if preferred.

=== Summary ===

- 1 bug fixed (workqueue UAF + pci_clear_master ordering) - sent via net
- 0 bugs in this series requiring fixes
- Style/doc observations (none blocking):
   - Spinlock iteration could use splice pattern (will follow up)
   - Unused constant PDSC_FW_COMPONENT_FULL_NAME_BUFLEN
   - Buffer size magic number
   - Redundant condition !err || err != -EAGAIN
   - slot_id u16 vs u8 mismatch
   - Comment/warning wording could be clearer

Thanks,
Nikhil

