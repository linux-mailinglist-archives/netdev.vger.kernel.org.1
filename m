Return-Path: <netdev+bounces-297222-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TBiLENRWKGq+CQMAu9opvQ
	(envelope-from <netdev+bounces-297222-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 20:09:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6D3663332
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 20:09:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=fhFEqEkn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297222-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297222-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B018308A5E4
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 18:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361D03C3442;
	Tue,  9 Jun 2026 18:00:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FB637268F
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 18:00:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028016; cv=fail; b=bifBaZSWOwfIuyccmQ2CVHXag9SYe9Yxv0EmPl6kVoo13FvwZcOtgLuZv+imKh4XMRPM4N1L+xWIJ9E81TGh/YHV2qdk+DyXUQRqb/YQ7HjOgSRnrC7YWzQNo+ufNGKLQZi0RYU6cD83COL3xJXuZKyefsgq8dHUfuobp1qv3mE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028016; c=relaxed/simple;
	bh=zgmI2oZoD0See0Gs7B1CSJLcKVjUUzZiJ86RMr9j7J8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IMyHO3hNL3Pf6kfPA5N6niAiwk3z4r3qcuQvfVXewsihZyT0Vu3KaAAmWzb7gjXqOgJIM9hu33AZds8CY3ijw8BjTxqnS5ucovGUAV9sJidq62jt0Djmos2OD68nlteap2xy8WFujnMA84i3XfOkqhODND3HaxgElTs/nN/PTC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fhFEqEkn; arc=fail smtp.client-ip=40.107.209.11
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+I8d+nhXtyHt5jezmRK86ANJuwFWYCPGRCYbpe/F1qjv7h9aYeMGK8rP+tDeDU9L4j+XEd3ToR79Kk/4ixm3y7iEuBumQqPqvaE4C4MBNwpvO4YfE5TWvlyFLo4v3+nUuapjimjUu+X3fxgl54zhg/gyJLAT0iPF4J8JgNYN2X8E0m96uSI6mTKb3NX/acwBfDjRqmMy3KpH0HtNmFreCYdbMNUzUGYBatLNXZq6KpsRD/sm5jU99CyR+CftYPfY3nNh1jertgRpSxrsVUH6Cf5ro5sTRWAVclomU+XtP/fiPMorK32BwqJB32Mf+YgHOXxx3L9jY8eoUWiT5N99w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AM5IG9KG9i3pnghVDhxZXGL4+6AC75vezvTLoW1ZIHM=;
 b=U6VsPz18uGC9P+1fyScRuXB318bsZM+JWxH/j1N77SYxWwP7zZAZR6SaaklK+3AqgKgl8cn86fHP/VQwFaoVfG0sPBn99QFeXFw9INiuTT2TJWirweKYMDgi7OxaxwFsz3VyW23gSBtNOSRfF5zZbRlkhZB4md+6x/Pk6PjqtRr2JFdcaPWRPyqRwmkqzw9L3jPzzRbFYCbYOk0HauusuOCk9VH5Vy0oZ9vMZtUnjfiKkEea0DnlGv41cZWAcXF1i3JzPC+mp4IZ09TxqGoupU4K5W29haOwkcFrlal/lL491mKn+9TbknJNfViWHtQTwt9jlSuA3pZXODq3BMCaUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AM5IG9KG9i3pnghVDhxZXGL4+6AC75vezvTLoW1ZIHM=;
 b=fhFEqEknbEt20SIL8W3LApVNYRsFZMiLUwPYH+jA1e6ebj+Gq0kwoMGTnccofIdSVO0TEalRgyEISmmsUUpeaKAopM9+8l+uIibqmV35s7k+PjoYX1LPA3NlY3tOs3SvuyBAX8y6kpTTAR+nRt8htnwRDiuCmOifZXpKvIwlYHQ=
Received: from DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) by
 IA0PR12MB8227.namprd12.prod.outlook.com (2603:10b6:208:406::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 18:00:07 +0000
Received: from DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a]) by DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 18:00:07 +0000
Message-ID: <f2d17ae9-ec9f-46db-b46a-a2bb680c3460@amd.com>
Date: Tue, 9 Jun 2026 11:00:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/5] ionic: Get "link_down_count" ext link
 stat from firmware
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, brett.creeley@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
References: <20260512224421.25236-3-eric.joyner@amd.com>
 <20260515012747.1292575-1-kuba@kernel.org>
Content-Language: en-US
From: Eric Joyner <eric.joyner@amd.com>
In-Reply-To: <20260515012747.1292575-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0342.namprd03.prod.outlook.com
 (2603:10b6:610:11a::16) To DS4PR12MB9708.namprd12.prod.outlook.com
 (2603:10b6:8:278::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9708:EE_|IA0PR12MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd1fe08-99f5-4e10-03cb-08dec650f095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|6133799003|22082099003|18002099003|4143699003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ZWCjH2q5UXTGBjmoi/QmnSaqMD5u/Iu0VM8lGwK/vJQO5QyVYpPTNe03XkEGVwYhU61S+n4mhVVe0cVTHr7TgLpZqS8I3oBp6UTPJ9N8rhKID+ohZP4pyQXNxu6RfPgxWijIIJSTqc/iuN5znfZhKKcKbK78yhj9goXU6XXMpuWRO2egPHU1VaVaPdwtqfTfPnmsNy5Hf9o93sezN/F93PTVBapvm4vuw1IoD5Ak8wk+yza6d3wTX5rmCz6HOt46IAEWc9f37KS/MamF2a+cECYAy5tIVdohgElWLA+nh0AKaj+64/1GDYcXCkyMl4bE6dyNQB4eY0Y/gSi2pMAfEBDFXhINsp2DdDpyeuf10NzWQrnsuJPN5qB7fnr2dsdv58Ns3wmkjthv/sZvv+rxfJDVM8pbyft5URWQ4gEt9r+XWad1swFPuWHDzRL1v7L9W0CXxhb2tJpc6rjsUivSCHfvCFAB3G01lHcAAPFaH1UW6ObTgHXbm6BFzIIPozOqvkwdI+aPwrfqBputE3ormlZedzIEEVzf6hrSt0/wDb5kLTzLqHd/3KXYPGZrE0XNPoYj+8ijGDYStH4jAaX+h9YlVRZeIbENIhEl94vpU9tgYa6PHKMQJLNKrR5eH/315U+lf+keXElWS+ZmdqKrOMvDAceI3YY61dojbmn9MOTbW9iOLxPVz2T9rHzmlEK+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9708.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(6133799003)(22082099003)(18002099003)(4143699003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkQ4Y3k2ZHkwV2pjc2o3SnZHcnBhUmc5UlJWNEErSUVlQkRLSkZKSW1nMVFU?=
 =?utf-8?B?ME5POExvejBrKzRROWFYN2k2bGRqOXlsVjdEZmFrTVUxZ0s1Z21zbGVEeUI5?=
 =?utf-8?B?Nm9lNGlwK1k2RWltdGkxbm1yTTJTeFdsRDBmay9xNXhVUFp1V25rZG5zZDFK?=
 =?utf-8?B?aHF6SUo3cWdmWEpvVkhRWWFNalI5R3FYYUJaeFJhd1NqZ0tRWTVPMGhOblJj?=
 =?utf-8?B?QnRLa21ZODlRank1T2xEV0xtck5nd1VwRDBvMURqN0JoSDhOZi93NTl6cnpM?=
 =?utf-8?B?YXFPVjRmc3RBY0EwUW1TcDZrSzJQVXVHS3R1VHExLzFXTEo1RWtNbW9scGQ1?=
 =?utf-8?B?TEx1Yk80SzVuKytiRGNvdWZHYXdHY2RXZ3JreGJOMG9wZFc4ZWpVT2ZIVmhq?=
 =?utf-8?B?YVdXMTVZV0hQa250amRHd2FYMzJEdzRySDJKUHUwQi9wUk9KRTVNMTRXTEV4?=
 =?utf-8?B?NktURjcvcWdFbW1sZUJxOXVtdHlTc1FRdS9raktwTlhtWDN0UEpNNCtzdHJB?=
 =?utf-8?B?NkErZXNiY2Nzd01STlhFakpOV3NKRElKckNYTS8zMUxnZkJGbGFMKzVaVmVL?=
 =?utf-8?B?bDMzNDRVL0hIRHVpaUFNQ1ZxVjZnWjZWbm1UK0JYZjEydFppaURzbytLNFdv?=
 =?utf-8?B?dFJVaHUzU0JpVmdydVBSVkV0Q1g4aG4xejExUnZnQjZyUG9CT1RYOWJOV0Fu?=
 =?utf-8?B?U3FPa3NoN0R0ZytOVllmNTJyZytKeW4wM3R2ek5ncG1OMS9uUzFzUDg5TlRH?=
 =?utf-8?B?Sk45QUZvODNQQWpMVnc5b085Q295L0s5VVc0L2VyYW5EN0FHRnBOblp0M1RH?=
 =?utf-8?B?cWhzOExLTXlwQU02VkdEcmVHRTcvczdJWElJV3RRZU5HdkhMWGFBdzVKUC9l?=
 =?utf-8?B?bFMyMTZnZC95V01iN2JPVkZENjhuRC9ReFpHWmkwaUE5TEY5bGNGSC8ybHBR?=
 =?utf-8?B?ZmZJUElvS2lOWFNkcm8yRVNSamVZbkNLaVdFV0NBVzJqdENzUGd2bW9Tdi9O?=
 =?utf-8?B?SWlCR09kOXFobVVVRVo0L2pkK2Q3dXlOR1plcis3VmN5NFkzNHBVT1dPcStt?=
 =?utf-8?B?QTQxNWR0a0NoVEZBQm9UcFlCTnpnYkM3b09WeUZUYmNGNG84b0FZM2QvTERV?=
 =?utf-8?B?YWhIZm8zS3phK1IrT1krVWt0RXc0ZzYySCsxOXpqZDYydUhiYjFPc1lid3F0?=
 =?utf-8?B?bkdjWGZDeWpNamdGQUVqalJXQVE0TEVuazNaVmR4L0lXcy95MUlvRzFUa0k1?=
 =?utf-8?B?bFVIU1Q4cWdhS1dxamNFNE44amhpT20zVU0vTmYwQ00xeXV3TDB5ZWpiQVIz?=
 =?utf-8?B?eThjK3gvTXlUaVZxYjZzS0xkckJvSGNXT1lGUitTTFJlSVY3YnVTTDlYSTRx?=
 =?utf-8?B?bVVpRmFZYURZQ3JGLzhPUXZkMXVIY2p5T0xzZ3FVMWtkNTBrWlJnQ3BOUGJs?=
 =?utf-8?B?U01jaE9MVFYwN3J3THUyQ3k1dWViSFFHcnl0SDBPdGpvVmdPUWx3MU0yaFZQ?=
 =?utf-8?B?bURsY1NDUzdNVlFJWFlBTFE3S0xwRVU3OTNqdjhTVFRkMnV1TGkxcGRxUTFu?=
 =?utf-8?B?MGtRSithNGlnTUUrOWd0d1ZuSUlpRlhqeFIrbU5EbzVkbzFpTGJ0LytvOCs3?=
 =?utf-8?B?S0tkTVk5T0tjNVc4dzRiTDlKM01ZZ21XblJSTHRtRGhSNWVpeWhZcjRCVjQ4?=
 =?utf-8?B?ZjdLdjRPTVRnak9hKzdzcm85VjVXRW01Q1VrR1kzSGZCc0NHcmw0OFplQkNq?=
 =?utf-8?B?TFJrbDVEUzhDLzNUeWJucTE3WlI4MThDYk1wZFF4bk9QOGpHOG1DUHMrUnRM?=
 =?utf-8?B?VDdaQ0pORHdaWmJmbUVicGN4S1hrckdUdUFTRVBYMnRLR3lROWpvbmNqYTI3?=
 =?utf-8?B?a0RwcHIvQlNBdTFHQ2NHamppVExLT2QvaUZHY2wwZE93WUFlbHNwODRPRndK?=
 =?utf-8?B?cGw1eWNtTUozUXNteHQxdENoQmJFNnlnd3JPUmk0SWNzcnF1Z3FrTlJJZEpK?=
 =?utf-8?B?cDBzNXBBQjR0dDN3NmRGMjZvMGhReUEvU3dYbUpDalQxdjBEeXN6ZGlkTGc1?=
 =?utf-8?B?dVlnQWd3YlhtMUJBSmxQSWxnZ1AvekM4T1V3YzJzSjFkMHM1bVJmM0M5WmJi?=
 =?utf-8?B?ejk5RjNqUy82NlZiQWNmRXBLbUNWYURYclB4Y1I5WXNXOHRUQ3NOWmtYNW04?=
 =?utf-8?B?WVZHemt0YWhGYWxjRmU1QTZya3V5VURtK0puSjdvUlZtRHRHL0RGQVdBb0hV?=
 =?utf-8?B?VFBIek5tMS9ReVRsR01ucDNocUtVV0N4emRGUFlVbmoyVFoxYTBrUytrZlMx?=
 =?utf-8?Q?m5k6mnSHcTD+DLFe6U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd1fe08-99f5-4e10-03cb-08dec650f095
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 18:00:07.0631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIXbjKj+ZIJ1pPmOZwtiwwGQO/5Ew7fv2yYaCJ+hqR8XtT15gZzuCP7c0CKR8OLN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8227
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297222-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,amd.com:dkim,amd.com:mid,amd.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E6D3663332

On 5/14/2026 6:27 PM, Jakub Kicinski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.

Man, it's been forever since I've been able to get back to this.

> ---
> [Low]
> Should this NULL check sit inside the is_physfn branch below? The
> port_info pointer is only dereferenced on the PF path, so a VF calling
> ethtool on link ext stats will now log a netdev_err even though the VF
> path never reads port_info.

Sure.

> 
> The message is also unrate-limited and reachable from userspace via
> ethtool. port_info is freed and set to NULL in ionic_port_reset() and
> reallocated in ionic_port_init() on FW reset / FLR / PCI error recovery
> paths (ionic_reset_prepare()/ionic_reset_done() in ionic_bus_pci.c, and
> ionic_restart_lif() in ionic_lif.c), so any ethtool query during that
> transient window will emit a kernel log line where the previous code
> silently did nothing.
> 
>>
>> -     if (lif->ionic->pdev->is_physfn)
>> -             stats->link_down_events = lif->link_down_count;
>> +     if (ionic->pdev->is_physfn)
>> +             stats->link_down_events =
>> +                 le16_to_cpu(ionic->idev.port_info->status.link_down_count);
>>  }

I can use netdev_err_once() here, instead? There's no "netdev_err_ratelimited()"
like how there is for struct device and "dev_err_ratelimited()", interestingly.
Would that be more appropriate in the future?

There's also a similar issue in ionic_get_link_ksettings() below (and maybe
elsewhere?), but that can be fixed in a separate patch.

> 
> [Medium]
> The firmware-supplied link_down_count is a __le16 in struct
> ionic_port_status (ionic_if.h), so the value saturates at 65,535. The
> previous lif->link_down_count was an unsigned int (32-bit), and the
> ethtool field stats->link_down_events is u64 and treated as monotonic
> by userspace consumers (per the comment on struct
> ethtool_link_ext_stats in include/linux/ethtool.h).
> 
> Without driver-side rollover detection that accumulates the carry into
> a wider counter, after 65,536 link bounces the reported value will
> appear to go backward to a small number. Should the driver detect a
> firmware value smaller than the previously-read value and fold the
> delta into a 32/64-bit running tally before assigning to
> stats->link_down_events?

Is this a big enough issue to deal with? Is link really going to go down
sixty-five thousand times while the driver is loaded? I guess we could have a
running tally, but that seems like more effort than this is worth.

> 
> [Medium]
> Does this change make link_down_events non-persistent across firmware
> resets? port_info lives in DMA-coherent memory that
> ionic_port_reset() frees and clears:
> 
> drivers/net/ethernet/pensando/ionic/ionic_main.c:ionic_port_reset() {
>     ...
>     dma_free_coherent(...);
>     idev->port_info = NULL;
>     ...
> }
> 
> and ionic_port_init() reallocates a fresh zeroed page. These are
> called from the FLR / PCI error recovery path
> (ionic_reset_prepare()/ionic_reset_done() in ionic_bus_pci.c) and from
> ionic_restart_lif() in ionic_lif.c, so FW-reset events that previously
> left the driver-resident counter untouched will now zero this stat.
> 
> The commit message does not mention this behavioral change. Should the
> driver snapshot the firmware value before each reset and accumulate it
> across reset boundaries to keep the ethtool counter monotonic?

This count doesn't get reset in the firmware when the device the ionic driver
binds to gets reset; the freshly zeroed page will get the count from the
firmware again soon after the reset occurs.

> 
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
>> index 637e635bbf03..eb7e552bc12e 100644
>> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
>> @@ -179,7 +179,6 @@ static void ionic_link_status_check(struct ionic_lif *lif)
>>               }
>>       } else {
>>               if (netif_carrier_ok(netdev)) {
>> -                     lif->link_down_count++;
>>                       netdev_info(netdev, "Link down\n");
>>                       netif_carrier_off(netdev);
>>               }
> --
> pw-bot: cr


