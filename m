Return-Path: <netdev+bounces-264340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QO5tMZ5tqWnH7AAAu9opvQ
	(envelope-from <netdev+bounces-264340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:48:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 69109210D53
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A7D933034263
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 11:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4A837F75B;
	Thu,  5 Mar 2026 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5klqwnAl"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013061.outbound.protection.outlook.com [40.93.196.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E49837FF73;
	Thu,  5 Mar 2026 11:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772711201; cv=fail; b=BzwLK9h4zVWsyyPh+xpYt6PUEmybmIKPWcjvPtLeD2lj+AAYzOoJ1ykHpr/NAMtHAx3/v/JJa6GIFpX7jZIpX3MVeaMocow9jExcRSeii9pAaSbCNvIBV3VblFuQJlrlVOuTZQgCIGN4TnFG50/RRv3VVAdNR2pEwXmUoaV6z3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772711201; c=relaxed/simple;
	bh=EV4bpnEc9FMOQ1I4kI0OrqNJycqHDVj64XXyGojE5Jw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T/O+aA3ck2jyF4maCge9uEvRhCRzL7GoK7KiqJY3hx1WlIKBqQfxGcfAoNsjZmH4HSHiRBx6g1g5dciTcTgdIB+0a5zh8Z9H9Oy08QIysJlE36NeNMU4v+5hfMV46nNxbMMrOai8LsEm4QYaNi5rPgLiiHlD7Wq1KGwgJv7G7qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5klqwnAl; arc=fail smtp.client-ip=40.93.196.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LEFyZasnpK5qXVLQyqNZHld33lHVcZ0sN6T2KCOlRzJ53JT+V/fXG3N3j1ptLd8KpJfGFOKIBoDH7MtjL6NmgS0USnR0FVF4i3bHFSu4l0NQQFgj7xS9vEPZ45o4LIkE3I9eAVsnS92qEx/7IU9Q73wMhXDrBO2FZk+c+0XFvDiVdvcoOsEuarhPYUj5XjCm60FQ/vahSYayr0lWxlLJefu9o5N6WrMbFE7K3veljEb3Je2bPFKxW4jS8ym6Es2M47nYEiwk9EZPJBKg5wagNaXW76Ec5GYXPyFaflmTUTMUc3euW9Tf11zYzGITy/Nn2YeGwD8rBPJDtxnD1vbe/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSs1KJrif5zMB/PtbsOT5UY9m/uAgfNK8rduQ0X5IuA=;
 b=MMxkflwQO5azQM/ZcJv2aGVVNxRkO29fMr6dn+J+3pmwPiyAOICtVZ+zX54tkPfXWPwOtjJ4Vk0SWcJYRKM5Tj8UApSzE4EF+pAR2DpgH82+115CF7KtFdP3LI6peBQuRmPYoWqsPxRFNyjlENPp8+aUH3AghEEPcKoFVxQvOG98Fy00U9eHmzFzfmxMLBr+cY+nFp9HujKOLmN325G0XWd3GlagVjhEn79v8Xw8LDWN6J+GRgXdbkY83ounzNTWvN5K6KKFbLG01mbK3M8IFoPOHPqYwne0xFpRLgdVBbXo4Rh0pG9ayzjGUuVaphXYjw5wAl7IvA5CFMscx5cILg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSs1KJrif5zMB/PtbsOT5UY9m/uAgfNK8rduQ0X5IuA=;
 b=5klqwnAlRyJNnj0EHuSFjkk3d+Q7nmh9bIsiLxQtb8HoiIXm1UhMExNvNHLMI9FvWLdOiliOyVD/apTlWkRz2AxIn4KLUQryuJuu0MhqB08q9K2puppKPRXwxkw76C9Tdn/SV8bs4PK25MQiufttbGD5lgS2Qckpdf3WwME3RYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 by DS7PR12MB8081.namprd12.prod.outlook.com (2603:10b6:8:e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 11:46:35 +0000
Received: from SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2]) by SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2%3]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 11:46:35 +0000
Message-ID: <ca273ea9-2d6f-4c01-b243-803835d08248@amd.com>
Date: Thu, 5 Mar 2026 17:16:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/8] xilinx: tsn: Add TSN Endpoint Ethernet MAC driver
 support
To: Andrew Lunn <andrew@lunn.ch>, "Neeli, Srinivas" <srinivas.neeli@amd.com>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "Simek, Michal" <michal.simek@amd.com>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "git (AMD-Xilinx)" <git@amd.com>
References: <20260219054911.2017362-1-srinivas.neeli@amd.com>
 <5f884e29-151a-4ee7-9e1a-d7e1f84d9f6c@lunn.ch>
 <SN7PR12MB81478FB396CDD9929618C2D69368A@SN7PR12MB8147.namprd12.prod.outlook.com>
 <28b232f1-5814-4b3a-af28-1eab023743c0@lunn.ch>
Content-Language: en-US
From: "Neeli, Srinivas" <srneeli@amd.com>
In-Reply-To: <28b232f1-5814-4b3a-af28-1eab023743c0@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::24) To SN7PR12MB8147.namprd12.prod.outlook.com
 (2603:10b6:806:32e::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8147:EE_|DS7PR12MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: e8257193-4710-43f0-e4dc-08de7aacda32
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	ZDTt68rSf/nTyEafCB2pwyGZ7a+ufMIYfRRo2s7fMpDbmHC8aIi7CfdypS5Nsm7PhTUWqeylISEY/2tDpOARmIOaQxGam8c/3YpqNYp3vHNzx0jTeAxVtYuU9GeBx/wdhHjIsFgQ3hacWUZ5BCOEKes82Q5rFOUCs5fSQxWrG7TfjldR1pQpbJvaNoPa1ZuhmFJdjZEa213+vP269o5ARJZeV6yzC2bCL+DNPVNonYE7vr/12Tt6+lHUlMUOYcnTnZG4ysh9sioKdkE36xq/chGVz5lDFx5aBd4oTCJ7k4346BNneYAe0kezdTwH8ZWAgEz+n71brQEzYuRAXTpH5QQ3M3dXEJCCR+ZGH/nhAgHoDP9IRwFymgVtclJy8H0XbtyR0zzydu+hdnw0xITYHp8beyuBeqFlUmOScJOIMez5KEIscdv++kLqryYluqTRXxtPVOf8OgOqM9fkHqpLz2OIdxZ2blVsiR904FSh1hJgOOUnshgvIZ1tRxSoGOfbRbo8REZ1gdKz2EBwNbsWLx5rteqO/qxl1wL1iBq4nYyGQoAeu+4DBA/Is9nfYOvepUoPyEZ3KI3j+o8iBQeKkbxT3KxDH07nQjwqtSvUOZZlK5i2bTEvyvnhJWXfEIV6GRGKvNxQsr9GT7QHGtq7sLWruniRvGBMnz2IfVoFXMiJjffVpTDkdreVqiACTRh/RG4TlxMNgIGL1CEqekyBi11g+AhnBJFkha7UK7rthtY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N25MYkFobmk5dGZmM2pzekJwaTJUOFU4WjIxYXlza3MzNmErdUtWQXhCLzQ1?=
 =?utf-8?B?WnBtdTFwKzcraG9ZYUNIaEFKUW1KWkNZbmJlT3lsc2RnOVpGUmJmZFRUNndX?=
 =?utf-8?B?UVQvYmM5b3dWa2s3azMwMWpTcXZQdSswby9pd2pCSVU2N0d4eHhzR0NWQ1ZT?=
 =?utf-8?B?OXlGbXI5N0FtTW5EK2xod1JwZmRHWEhncUVMN2VoR1ZkSytUZFBTTFZBMUh3?=
 =?utf-8?B?V0YrWDRVTk5pWFZZcmNzbG5YZ3dBdm44VXN5cGZnSmdaUG04ajhiMGVHUmNQ?=
 =?utf-8?B?YzRrdHE3OVhqRGZEY20veWoyYUhXRGpORm5xVnZPaCtrODlSNHlJN01uU0wy?=
 =?utf-8?B?Y3ZPQVpteGZycDhMcDFvbW1YN2RPS3dUY0hFeE1ndTFmSXBwZHBZN0szRGZO?=
 =?utf-8?B?d1Jpd1NaSEhER3VOQ2ErWVBqOEYyd3NERUY5N1BMZFZ5S1ZWRzhBc05nVkNv?=
 =?utf-8?B?WkFhYngxQ1A3YnROVGNpRm91VXQvemlIVlU3SEhMMTY1bTkzbmxVdTk5NTd4?=
 =?utf-8?B?RXM4TE9ydFBaWkUvSGlpb25JSDJlKzZpT0I3MFo0Zmc0YWR2djAzT0pYMTZy?=
 =?utf-8?B?SU5wdyszUXo3V2FON1pvWFRuUGFXNG5ZeE1JZXIrNWQwcWY3Q2R2dDgweUxk?=
 =?utf-8?B?ZmVMT1U0ZHJaSExUdDlRZ29saVZEemhPNlE4YTQ4NEszVlRLWTVOSTVYQkRs?=
 =?utf-8?B?UHhWQXZFckJhdG0zWkVnRXZNT0hiWEZpc1YzUDhZWWhFWUgrcnBrRUIxVFpT?=
 =?utf-8?B?dlI2RGx1aFZidWpaMVdLOFNOeUxPMUZIdjhuZGVsSEdGa0lQUU5lT0NTK3lE?=
 =?utf-8?B?RXZCdFpYSnB1c0lPUFIvZVVyV2dUdTZXOTBCZkxDYk1ia3hOVTFvbVdOVUhD?=
 =?utf-8?B?YzB5RmZQNWszNmZTWEZPSjF4d1lsb0l1aVdvdDBjcktCWHByUWY3RnIrOWtZ?=
 =?utf-8?B?aWhCOGlVQjc0M05QM2Uwd3VEcEhNb0N1bGxDOUFkNW4yZ0cwREJQRS9YQ0lD?=
 =?utf-8?B?WkJqTjVxZXh6K3R5djV0bHA3SGR4QWRudkUrZm1sT0o5cHZadFo2ajM4UGJI?=
 =?utf-8?B?OEdxaitZRktDejVhbWNCeDRZelVPelF0QlB2YnY4bERLaVFldTVUa1dtdE1Z?=
 =?utf-8?B?bHdmcmVoYjFhTXNlNExQbTlib1l6V0FRVnVLUWxFVzF3dHZlMVhublQ5R3hl?=
 =?utf-8?B?WTdVdTZHZmxDdzIvQ1IvM09teHlubHEwTjRJSllxV0hnZ2U4VEN6Z0hXWDFp?=
 =?utf-8?B?MFpTZllXZlptT0NKZ0JlQWo4bzQ4RW1KY0szWGFFWnc5TTlmQUpiK3YyM2dP?=
 =?utf-8?B?ZURTUjB6cXRsZ1E2SGpQQitnRndRVjV1YzRoY09aaE04czdCMFVUV0xhYURk?=
 =?utf-8?B?Z3pwY0hhSVFWR05RN3lEL1F3MHMwUy9CaDVHMmZ5MzNhN0JOQ3NsY2tzQ0l6?=
 =?utf-8?B?VVFtN3lGREljY1lEOFh0WmxDNmdVNDl0WjQwNGFnM0l4VmxVUG9XTVJQUE5J?=
 =?utf-8?B?ZDdaekFSbGttc2FaOXdLRW5JcFMyZ3ZNY2dYdllxSlNWM3ltMXk0c2g2U2Jh?=
 =?utf-8?B?N2xPN3RzZE5Hc0R3KzgxQ1M5SlZpVFFML1p1ZGpVeGVSVTJuczFMaXF0MVVJ?=
 =?utf-8?B?Q2k0c050cnJpbGxOeHhqWHl3T2RnS3dTQ015OWV5dVRRZmFNUzhLODBQcG9B?=
 =?utf-8?B?dFdubGVYQVdvK29xbXRzVmNMSEY3RWZPS2ZwVDFiWFhDYmZjS25haktXeHVu?=
 =?utf-8?B?NUdBbGRyT3VvdzJTQmVYR04vbzR2dzVZb2FBQ0h3MTNRNzdEMzA3Y2pyMXZy?=
 =?utf-8?B?bTgyZDlTcC9DdC9pNHJGVE9Yb1JCOUtwTjROVk1uUzFuVVFUOG05eU1TOGtt?=
 =?utf-8?B?MnYzdHpDN2NBTEd6NG81TWV6d01PVlM3OVR3RmVaMXBibGNieGpmTFowcWhp?=
 =?utf-8?B?QzR1Y1VoRnRzMlhXYS9WTnZsYkJHaXVHaTZ1eWI4dVNOQVFmb3paMGd2UDZo?=
 =?utf-8?B?NVB6MlplT0Fpc29rYk1RSVBsdHA4ZG1iRmZqRHFRczNQcGx5N2V0YlhFNjlF?=
 =?utf-8?B?dEoxMUhxWi9NYnZWOXJPTVA3YjNVWHlxNHRkRDlkUVhpaDJMSnRtZHlFWUtt?=
 =?utf-8?B?azg2KzdmS3pxNHhsenc4YVpCTVdRcUlwQU1oNUgwcnFvRnc2UHhsNVBjQ3ky?=
 =?utf-8?B?MWRPWXpYSkpVWG1wQjM1K3JQQXR3L2pDaUh0dFZRTVlsUG1pRFRVN1R4ZXRj?=
 =?utf-8?B?Mi9YTXBHZ3lXSnpDQTEyVTJnTVB5LytlaDFSZ1J6dlVoV2U0aU9uck5mc0tY?=
 =?utf-8?B?end5OHRDSGNoN09aK2x4cENiT2tEYWtCMk1sS0xrNkdTY2RUbE55QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8257193-4710-43f0-e4dc-08de7aacda32
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 11:46:35.0752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3qJHf2R1QQ451sn7m9g5NtRtkxtv9ri2mSzBWleeWSRrKlT69ZAn1NwKLe4ZPPXC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8081
X-Rspamd-Queue-Id: 69109210D53
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264340-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,amd.com,gmail.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srneeli@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Andrew,

On 2/20/2026 7:06 PM, Andrew Lunn wrote:
> On Fri, Feb 20, 2026 at 12:59:16PM +0000, Neeli, Srinivas wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
> Sorry, i'm not part of AMD...
>
>>> So how does the host send a frame out Port 2? Is there an extra header
>>> on the frame sent by EndPoint, which the switch interprets?
>>>
>> In this RFC, I configured all switch ports in forward mode. As a
>> result, when a frame is sent from the internal endpoint, it is
>> flooded to both external ports.  To forward packets to a specific
>> port instead of flooding, either static switch CAM entries need to
>> be configured or address learning should be enabled so the switch
>> can learn CAM entries dynamically.
> Despite not being part of AMD, this part is important.
>
> I don't care about how the RFC works, i want to know how the hardware
> works, to ensure you have the correct choice of DSA vs pure switchdev.
>
> Take the example of running Spanning Tree Protocol. The bridge needs
> to send the BPDU out a specific port. What mechanism is used to do
> that? It also needs to know which port a BPDU ingressed.
>
> 	Andrew


Hi Andrew,

I would like to briefly share an overview of our TSN switch capabilities 
and seek your guidance on the most appropriate Linux framework for the 
driver implementation specifically whether switchdev or DSA would be the 
better fit.

TSN Switch Capabilities
-----------------------
Our TSN subsystem supports the following IEEE TSN clauses:

IEEE 802.1Qbv – Time-Aware Shaper (scheduled traffic using gate control)
IEEE 802.1Qbu / IEEE 802.3br – Frame preemption
IEEE 802.1Qci – Per-Stream Filtering and Policing (PSFP), including: 
SDU-based filtering and Meter-based policing
IEEE 802.1CB – Frame Replication and Elimination for Reliability (FRER)
IEEE 802.1AS / IEEE 1588 – Time synchronization (PTP / gPTP)

Hardware Architecture Overview
------------------------------
The switch consists of three ports:

Port 0: Connected to the CPU (control/endpoint port)
Port 1: Connected to MAC1
Port 2: Connected to MAC2

MAC1 and MAC2 are capable of transmitting and receiving PTP packets, 
with received packets stored in internal BRAM. They will not be 
forwarded by switch to the internal endpoint (EP) and MAC network 
drivers xmit's and receives the PTP frames.
The switch forwards frames based on VLAN port membership and the CAM 
entries and switch supports TSN features such as CBS, Qci (PSFP) and 
802.1CB (FRER) through hardware configuration.
The CPU is intended to operate purely in the control plane and is not 
part of the forwarding data path.

Thank you very much for your time and guidance. Please let us know if 
any additional details would be helpful.


Best regards,
Neeli Srinivas


