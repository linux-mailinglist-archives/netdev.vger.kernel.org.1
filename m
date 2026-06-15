Return-Path: <netdev+bounces-299555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Cva/CNg3MGpvQAUAu9opvQ
	(envelope-from <netdev+bounces-299555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:35:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E0B688E7B
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:35:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=ekEKjoRM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299555-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299555-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD76830D2A99
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 17:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278904183DE;
	Mon, 15 Jun 2026 17:30:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A504183C1
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 17:30:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544604; cv=fail; b=jHsVS4L9E3/WCLxqQcIdqDuWD38oVNIDNJT3KYMHI44l758sv9quU0R8fr+9DkhddxXuqLmgOJR6cIPbtmtLvOHr6I4iyRgvq6OlwKoxT57IPUmyCr8Dd1acfv/quqpnadnPKPL/cvjDCqS99AGdemheZ7w7xPk5hmEGscJzEF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544604; c=relaxed/simple;
	bh=C0ZEoBF8m6WvnfL5ka+z55fLHREO12Wv3hhUUq8AMSo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lPOGhEeqIK3XFc7S8lHm6bALVUh5YpkCHggxWmc3yoZzy5c+FeXPb4mSDzXx4SfOfEfy+IkpDkUb2QbWHHNxWau87kioeot2D4/TK2AWtAp/pUJnPVuRZFFktHcxUkCeFMEcDCgPCYAYU/aiH/Btp2aenV6AaBmQmGncE6rVxDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ekEKjoRM; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKypxl45uJgSlOh8U/WBvLPYo2poQFRCOZOR1bhjQuWiAhHH0q3maIMyJCHpwcSMc0uS8SLxNFpags6lGABQ/J3oivBfGC1+CWO25uAWec7fulxbHIIRyteiNOdFn5ZVPG3jO/Gcin3wDiMPPxx9YSUmLIcd8/y+IYIb8m+xc3slCnTOhF2rVkPjnroX33Tdir4/jYl2OqAcJ08rjGdIVKQoY37WcUtttTpXxCV38okCgbiYgN72NWVyuJ9UZGl44rrkVjcL0Yb0rQECcWXi1iNnUbS6I10QxApxDRaRi53QMU8XTReKYoxxfT/jX3itVDEQHztxv2qOAubF35a0vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BF89Uv6F6y1t76iBcfD2QR1MOrNZVdnkyF5vhwJnhGo=;
 b=hAeruFGxhx8D6Y61oGKgxi8HvzLQ8Tx66zMKiYsSI5czCfG0ziwyn36lEuaUOLcFVM88ZQVWsXSYRqrPuE43yPY8vTrlCtsyyiNvgo43fxNR5VnNXNu+s7nvutlBMhXE/fldnSYkgbRbz7geozqNBDmIkt7B+CC49A3EW3gi83hd05iQPLnHsSFMuwnvY5/cagS/eQ+TniH0oATV6eLtL+k83aalcVhUzA2xNiIGW4lkYV9a1kyeQbzOheTHLVS+hfWj0+iVGIbMQ605NuN9vbghX5tDmIqliPd4zL2fJuyZOJo0rroFR0c9lznz1EdIvJB6A9+HD+ZSTFuuu4Yo3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BF89Uv6F6y1t76iBcfD2QR1MOrNZVdnkyF5vhwJnhGo=;
 b=ekEKjoRMBg6IH81q+8ro52ejr+HcFPomW6x2QBjYmEucnH5n6JPwD/dtgpPnZWDpY+UPgnBpmhVt7cNEbId7MUbqVSzRxBCiDNBnCx7o1zOvykvbyKXVlrpGNQ5hpl54SXvNa61ajLxT891DJhAYx2ltN11MGtecfhwJUvA9pKE=
Received: from DM4PR12MB5389.namprd12.prod.outlook.com (2603:10b6:5:39e::8) by
 SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 17:29:58 +0000
Received: from DM4PR12MB5389.namprd12.prod.outlook.com
 ([fe80::1f4e:98f9:2c94:8e4e]) by DM4PR12MB5389.namprd12.prod.outlook.com
 ([fe80::1f4e:98f9:2c94:8e4e%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 17:29:57 +0000
Message-ID: <3193fb6f-d786-4b8a-ace3-d63264c95529@amd.com>
Date: Mon, 15 Jun 2026 10:29:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] eth: ionic: delete the incorrect link_down_count
 reporting
To: Breno Leitao <leitao@debian.org>, Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 brett.creeley@amd.com, eric.joyner@amd.com
References: <20260615170153.592171-1-kuba@kernel.org>
 <ajAye8LnVeqkcGLZ@gmail.com>
Content-Language: en-US
From: "Creeley, Brett" <bcreeley@amd.com>
In-Reply-To: <ajAye8LnVeqkcGLZ@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0057.namprd04.prod.outlook.com
 (2603:10b6:610:77::32) To DM4PR12MB5389.namprd12.prod.outlook.com
 (2603:10b6:5:39e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5389:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: ec870795-eddf-4774-1ee4-08decb03b862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	JGVoT6DDKzdrv3mmK+Bl1JKldPn8yz0q5E4+zewg8U5EXddTFvG0/R9M8OH6ZYKNmBOJeO2NhPa8EoG9w2t46iJcuo5CPYGCtCIhvssOl9yHzGuV4nSZQ2UlDZwXn5/cHiczhKTYm/ZI8igZZCY6NFUGDeAPX1h3Y2YxWwbkXKl6yzvyEVQdjaIzVM6V110ZQ/7pGW8CiBtlp49xfQ2y+BHDr6prBgIYlHHqWs6fJzG+4qvO2rDCNwiJScH2TWig9cItMwXBoxF9/8qj8SoLe5inegcTcjYAmuAJ3wFvxH46jyxPT0nXwMjiVjVweanUpWpsTnhwxkMMwwjUODLIAGvHTyMQMF53DM/VJRMye3qTMCTzvEVIz0Eno21R8tXfDRmmwH2oJWKopH68v8U3thP9Dn7ZRMW3dh77M/ywPPWeTu8JV7nDm5MbFWJzhCQejaUaKa2hQ/QL/epudu3aWY8i9NUHVSPbXfi/+Kuz84/zG87reNqwIAAucwTm+4HRPohQrNqPbLTpiz+0C0brSx3jQekI4h3fRQOg1j2XR9UV+bGIlwgILzhz6ORlATwarmu81gCgTYs5KmQU1t4yU6Ni2VUKz6hGG53LFyNIj0kFvsRHytgcXwpvUrbocNTjwadPy7cFFt+r0tTSU3PA+2jhX/zSSSw7/0i8IJ0gg/VZhRWztUWDyFryfCjRkgXvwpYf1PtkMZbwHpruc15+Dg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5389.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmpOQjNycUFZSEY5TnRmUnR0OHUzdGZDWDlpb2RnRGlXb1cxNTAzOFNDTkt6?=
 =?utf-8?B?eXY4L0ZHeWJ1TWVEeWlnUVUvaXc3SFgzeGExWVRIMjZWdzRsU0M3cThKekla?=
 =?utf-8?B?RUl4dDc2QzJaVnJOTi9RSXlJVWN4ZkZhYXI4V1NDU1g2ekRTbHFQT0QzZ2ZK?=
 =?utf-8?B?US9nU1ArOFo5a0FLdUNjSUdNNWxNK3ZCM21RM0FTODlsbC9kd2JiVmRtR1RP?=
 =?utf-8?B?SkJYbmVQQjdGTHIybHNSVE5uSkd6dkdJWlk5bGFZRHRFZFZoclNCcG5tUWFF?=
 =?utf-8?B?V29aNWNaZHdXb1kzR1dOY2NwUFlEZUlxRXE2UVJQbnRxMFJGaDhFb09RNWMr?=
 =?utf-8?B?aExtS3loa21qeDlSQlNkdUJ5K0NQYWdWalhIVkxkYUo4SmdOclZxM0NaeVl2?=
 =?utf-8?B?bWpuL0tQTnZXNTJoQk84WE5rM1NNeHVqOUJCdlVCYjlVcHIvOW45S21qS05t?=
 =?utf-8?B?S21Rb2V1cGlZaE52NXkvK09xZUkvZFk2TEx1VUFNRjJqNFhFYXZVa2k4cUxp?=
 =?utf-8?B?MlAwZGtXTXhtcXpQc2hUUFhXa3ZqUU5tM2lWdFBGMDNOajBHSXlURnkrWktL?=
 =?utf-8?B?cXdvVEpBcFRuMi8waHpPdzVFSCtTQUlyZXNnOWxSSmFoYjVvWkxwWGNOL2lh?=
 =?utf-8?B?VlFWRzhKUExDRWo0NjdpamFzSUptT3NjMzU0MXExNU1SWU94Sm80WnRFV3da?=
 =?utf-8?B?bml4TUcyVm5LNTBJamlTQVBKVi8zVXhRY0ZNbTRWTDdscFpHRHgzSSs1dVJr?=
 =?utf-8?B?UnBXeFhxalpCN1U3emVHUjZGQ0dCaDRIbkhVVjAyNWlJMm5FSUFNdFY2clJV?=
 =?utf-8?B?RFlIM3FaZ1lsZzlPalcwRktRK3RZRTE3bXozenh3Y3J5UExEeHphSzExa0xk?=
 =?utf-8?B?c1NTRlhsdExXeVhWeks5T1dtUmcrRFlrT3hvUzB3c2p0MUZudlNVMFo3dTVO?=
 =?utf-8?B?QUpOeGRLeGFXbVhtMFNLRVZWcHIyamwyQkEycm5vY0xjWXc5d1kzbFd6ekMr?=
 =?utf-8?B?dW5xZytaOXN0Tm9ZVWVtdk1EVytwUXhNZ2ZFcDM4dGt3L2ZzcnRWeXJicXVB?=
 =?utf-8?B?MzUxcHkvcTZ1MkFOajVPVkdUMGJOZjdaSzd1ZU1NazVVMGoyRmhUckJENk1a?=
 =?utf-8?B?cFdKWE4yNEhuRmUwc2x5UFRFRVZST1orK3JOOGU0VUNzWW1MbDVaVFppQ0FI?=
 =?utf-8?B?Q3VhcnpXQVE4Tk5Wbzh3TFVIbkxTYUwxY1BTQmZ4VXQ2RzdIVmpxZVhybzNo?=
 =?utf-8?B?QVA4d2tqVWJoeFA1S1lTeE9MOFpWajNocFdJaS91cGdYVHRieE42MGt0MFlj?=
 =?utf-8?B?SlFOTnV1TEZJakkxVG5CK3VTMTJNTWdOM2ZDWHF4NWVIL1luWFZRVU1xSEk2?=
 =?utf-8?B?TFQ5QmxrUWF1eERXL3orYldaZHhWMWNQT1Nqa1o3SVU1cWViVFFacy9BS1VV?=
 =?utf-8?B?RFA0RWNHeUJrT2pHUmxsL213QnVQNVA0VURBYXJSUlg4QisxL2NWeUk4UWd5?=
 =?utf-8?B?NXVkYVR2VDRKZjRYaDdJMHAraUQyRXhjM1FPNnZnbE9HRGhsZ1Q0Q2YweEVF?=
 =?utf-8?B?dDNLc1hpeGtMRDgybFB0bEQwbGl3WHMrYVJKZnhqSEFXemREK1RycmxCcU5i?=
 =?utf-8?B?U0daaDF5SlZMWHRkdmhKRXNKVzBiQU05M25Gb1NneDdmOXdxL0gvYUJrMHN4?=
 =?utf-8?B?R2wvcStjaGhoVWZ2WkVBUW9VVkN1TnQ1b2hQWVc5bmpJazhpUWhEbEVlVXky?=
 =?utf-8?B?VFFsMUwyRHR6Ny9HbTJQRVIrdCtacDBZQ0ZDaDdBYU9WNlNEa21ORVRhTk5S?=
 =?utf-8?B?UWphYjRIMTRtT3hlb2xRT1NxdHk4NU03MmlTVlM0a0pLMGowcTJROHVhZkpV?=
 =?utf-8?B?ZnRNMG56QUp1S084YjJjRWk0WFE0WSs0N244WFNPK1oyLzRpK2N6OUNqUER3?=
 =?utf-8?B?NGpGZXJaYStFU1B3Zkl6QU9vaTBjbkdDUFNRZEVoVE9oVXZjMnkrY2R0UTVp?=
 =?utf-8?B?K0hUMEZ2UUlyUk42L3NkNSt2cmxqK3ZzL290TlBuT2tMOWFuZTQ1cDVjQXM4?=
 =?utf-8?B?TGJEWHg3QVUxREptNmtXc2wvSkhyOEpHUzY4bmdSV01NVll2Rlp3K3Q3VTBp?=
 =?utf-8?B?aTVSSVpUY1NCd3RITmNoa1JUM3JMZ0JoTmRSelhaeDVvcjJ4VWJmYmpFTFBr?=
 =?utf-8?B?Yk9Fc29vaytVRmVOR2d0d2pxL1dkblg0NDNRM1B3OVdkMmdEK2ZIVkJ0ekZ6?=
 =?utf-8?B?RmJjdUxOSjJ0OUowNG1YdU5HaXBOWkVpVEJjU3YyQWJTWEZMWVFZS0RtMDlU?=
 =?utf-8?B?eE1tTGN0aXJEVzJ6bk10YStJZVQ4aG9mRTAydDh5V3kwNFR6WmJBQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec870795-eddf-4774-1ee4-08decb03b862
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5389.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 17:29:57.3219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j46z2CCRWv9SMV9QEy4JHcU+cJd7X45WMlM4OuutKnJ5P+ZqyyFz+G/+pz8n+5LsDzZuom2MuJop4ssyXoXMiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299555-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[bcreeley@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcreeley@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73E0B688E7B



On 6/15/2026 10:14 AM, Breno Leitao wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On Mon, Jun 15, 2026 at 10:01:53AM -0700, Jakub Kicinski wrote:
>> The definition of the statistic is quite clear,
>> struct ethtool_link_ext_stats says:
>>
>>     This statistic counts when PHY _actually_ went down, or lost link.
>>
>> Reportedly this is not how the device-counted stat on ionic behaves.
>> The goal is to detect flapping links, due to bad cabling.
>> ionic reportedly uses this for some firmware stat of how many times
>> the traffic was stopped. This is _not_ what should be reported here.
>>
>> Link: https://lore.kernel.org/20260610061830.51037-1-eric.joyner@amd.com
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Acked-by: Breno Leitao <leitao@debian.org>
>
> CC: brett.creeley@amd.com
>> CC: eric.joyner@amd.com
>> CC: leitao@debian.org
>> ---
>>   drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 10 ----------
>>   1 file changed, 10 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
>> index 78a802eb159f..f7dcfe3d032d 100644
>> --- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
>> @@ -111,15 +111,6 @@ static void ionic_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
>>        memcpy_fromio(p + offset, idev->dev_cmd_regs->words, size);
>>   }
>>
>> -static void ionic_get_link_ext_stats(struct net_device *netdev,
>> -                                  struct ethtool_link_ext_stats *stats)
>> -{
>> -     struct ionic_lif *lif = netdev_priv(netdev);
>> -
>> -     if (lif->ionic->pdev->is_physfn)
>> -             stats->link_down_events = lif->link_down_count;
> It seems this is the only place where link_down_count is read. Maybe you
> want to kill it as well?

It still shows in debugfs, but we'd be fine with it being removed 
completely in favor of the correct implementation from Eric at: 
https://lore.kernel.org/netdev/20260614205303.48088-5-eric.joyner@amd.com/.

Thanks,

Brett


