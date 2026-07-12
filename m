Return-Path: <netdev+bounces-306929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a9WTMjg8U2qYZAMAu9opvQ
	(envelope-from <netdev+bounces-306929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 09:03:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C12074406B
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 09:03:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=kcpx8UnM;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306929-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306929-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E35A930107EF
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 07:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDC730B514;
	Sun, 12 Jul 2026 07:03:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93AE2E7623
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 07:03:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783839798; cv=fail; b=Fd4FV/kSsIXZzjuJc+J8Ir5iqZhUkPC7cwdNdrzLUMzOQpglDNSLE3ueLgCufzEm3mRzV+Qkd4Ju/AzB1T2ZcAKhbMix7rA72Y5wjU4k0qV0wlBpPPCose+B+SHTMvsUyMCfYgpLf8tq7HkywDiz3qiEzjDvo4SD5zN7giA8A2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783839798; c=relaxed/simple;
	bh=CAWUJoLgFL/uGF4EMokSBxhhSK3frgZKOmwwHsRDexY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UkGXXGqxNgcMNZwwZ+VfK4l5rFFnfU3ysz903PaGlPTF4x786oAdqDMVEiuruRxWtAeN0Dnkph9L4qWhIebB2NQ/NxIdTXUAbwf9NGMt7I34QE016dew8QxB01XUimIFG5fb/WsiO6Z/hqFnkXMQakxhgICom4Z+SAUhZs5540A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kcpx8UnM; arc=fail smtp.client-ip=52.101.53.49
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3PEse3Wa6yupDlSMMaG4S7FdIWFFhJbGL25sA3swarbXRpJOJmTnmc8xp+DYfszEFHG5FY6zqEDNxFBMxUbIOSB9NRwtKSWwigw0X9Yy8QD0WD3PRWw7SqJRSxL53WOWdwF9Prd37jLN5d5x0ZH7G+yvNBjypZ5c4uCWwcaFApewNtU7klme3619oBaOMTW+8GqXOAVwjPjFt/DQalaHzdhhFnqrliDsd6VZXtotONdTPS/rWLvZ6M6lB3VpLSVFLIQuel03dVDy+ltMSK0MZEwFpf6SBV+/QKQELVXMndvKFaJnMOtVHGyp3MbOE6SJachxlOV9YtSczWk+zrPtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=if2G+if012lCym4CGy0f1/tVFmSTAof5+ALSctgzyMI=;
 b=BlNTrn1CJcs3fFlfwPBCDRiznTcjArFOmljLz4miqLBMFEYpzzIS7SPSTjhkUKXHkWiTULy+Aq94gA6/yl8wzTqgyJ28CeVn6Zj6JPcOf94j6Ud8/ojIkVxrEE+H9gBSrRQgmWtODtcgCPgTdytW3knt6Gupz/53vOjtWuPG3Jt4GaKhrHbpAWLyhkoIot4KiOD9DPvsC6aZhC8H/ysOaAXLFgawsrfeyjsrIn6qI7pHl027BF9wg/aCW0XMc+bSnnFoqPp5PYAYTmCeVQxTjno+CA0ThtZIVM9duhbNwx/AZ5QOVzsd4Se0IiRU8LliG7xZHOlvav9UqZBwYiFZTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=if2G+if012lCym4CGy0f1/tVFmSTAof5+ALSctgzyMI=;
 b=kcpx8UnMkEbWSfm4o3DtF++frBe++4UixU+N04bdAZeL7x9vWMY9SPuSyk3bHV6qtrXX0Z3HLrVKZ3Fe2Q5jeTxeYyaEIM53MI4qkNQ90/AdcTEStSqWGf7sf85Fe4w3LqYdCBd0JA/OG1t0sJc3mdszUawX7juodotuKWJc3OhQ7WkvgfgrcqKnlfYWr9gUF1RRdvaTTrwNjhfUhMaiXOwqMYhR7b9fMlnMngoTxgLbSCocE+o0J0yaswZ7L8/JnuwXfwxOpryPkq3hnyNVsfvHo7S4rhd0yHITXR9w9vBMhM0aDuqIjRaBKs7Vo4xscFfTT/OZG/NyqZKBJqFeTQ==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MW4PR12MB8612.namprd12.prod.outlook.com (2603:10b6:303:1ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Sun, 12 Jul
 2026 07:03:07 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0181.019; Sun, 12 Jul 2026
 07:03:07 +0000
Date: Sun, 12 Jul 2026 10:02:57 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: "Froehlich, Dominik" <dominik.froehlich@sap.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, petrm@nvidia.com,
	dsahern@gmail.com
Subject: Re: Questions about resilient next-hop groups (6.18.35)
Message-ID: <20260712070257.GA114193@shredder>
References: <AS2PR02MB95821AC8417044B6529728DAE2FE2@AS2PR02MB9582.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS2PR02MB95821AC8417044B6529728DAE2FE2@AS2PR02MB9582.eurprd02.prod.outlook.com>
X-ClientProxiedBy: FR3P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MW4PR12MB8612:EE_
X-MS-Office365-Filtering-Correlation-Id: 48cb5236-c910-4c4a-0695-08dedfe3a023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Fxy3mc46/Jqb/AbAHDIwI3ad6BBR9rZXyFCWxxv/9hub7NF0knafGe+1wRdt2S4uqkSVBLJ0uBsuWOf/nogOCG4hOOwxR6B8wxAIZjPGuUhzPJMqB0BVhccVWgNgtw5ZtVFRxF1xirI4mbQIGD5vBeorWOivMpKuoY7gSACdXmFoMRQGiKcOyg1xY8EyPz9IY6X5tJSoWKIDZMgWtpihQ35cJ1ctJA8WXx8bpROyVN7ZRqQdRSON0pDiFx5qPkf7TX4c7/3IyMMsJ1FTDrbUc+aR/9zNFV/BC0ex+zh2Ulwfru90GW4xXnMHPdn6NJJCqctZPsMv1ML5BNqW2A1OZ2aWMlIOejV/iQfXzvAZvVG3V733PnwoGJOma9XQEv+Dhq66yiqW/8EFOnl9h3pHeoB39D7scqMIneF8wiSvDYoaSh7Tk8sP7fu7xoRdSisFQg+8dq/swN3WwNEQhWesgwAUqK0BTNgXgCj3UdTXAcqydFuBg/3Fe9G43rZq9OCktRtJgJUG01dIr+uCnTHCDLlkwoKg1N0lEY0WL3cLyhNSFths2r8fk4pcMXz7rFN9DWgfeSD3YJxFv0Y1MnT1Qs+DTyBwjZWEIckm2Om+7/itYAYpszQlsqS5iu7wBVl0tkhx2unIS9EiSBAhryuQLfg/K4FvpJcLGcl6nlQSHqA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1U4UDBYK1dkK1RqYTBkcU1BeVVNRmN3aDhMVDByOStxM0R1a2lDZVdhL1Zx?=
 =?utf-8?B?cjE5SGVKRHRQY25ZQnk5NStzREc3MUlXL0lacms2QytpMlQ3a3E0MUc4K0Ir?=
 =?utf-8?B?Sk1ucUppdGdKOFgweWR1WjAzZFF5OEdKVVdzd091ejhSMXdFRlhwVEZUUDJB?=
 =?utf-8?B?SmZpdUpxbUZzaGJUSnJkYVZicTVZeHN6UjZYL0V1MWI2cWZaeWJtTExCd3BS?=
 =?utf-8?B?ZngrS05LVXQ0RzMvQzFya0I4cU5FMmVya29aclVxZ2xxajBUaUtkWnU1Q1lq?=
 =?utf-8?B?KzRPNWUyVnJqU1J0QytDdStEdlFRcXhDdnJyNUJYS3N2UUkwUE5ybFEvY2Zt?=
 =?utf-8?B?cm5md0pKZlZjNEM5bktJL01hT2FjRUtsUHJSKzV2dEYwMHhaUThpeUhvT05j?=
 =?utf-8?B?U2JaeSt6Yk5MNHN6NG9GdkUrUlphaERwMStpZFBBQ1grSzVPRDFjMHhFY29u?=
 =?utf-8?B?Y0xKUDROTjc2RDBTRHg2aUVhb2hYQ09zTEprTVNub0YvK3RtUXhJeSs2NXZv?=
 =?utf-8?B?MTJNWVVaUFQ1UHZZN3BkdThVR2pkOVZzbXg4Ym1uOUh6cm9IbXEvU3dQand2?=
 =?utf-8?B?eXhMQnhHMFJXdGVKWStjRFl2SW1oVGFwU3lqU2NnaTYvNzVEdEFBd0F5WXQv?=
 =?utf-8?B?aDNXckF5Yy94ZXBHdkpWVHpMSUpJcXYrKzYzZFNKOUR0OCthV0pzUWJ4VlJB?=
 =?utf-8?B?N0d2bW1jcXFBMkFaN2FQQ3BxSk1sdmlmek9SN3p6UXVkempLcVNlenBaU1Uz?=
 =?utf-8?B?NmlkeWsxQTJrZW40R1I0Vm5pT2FHL0Z3bUhpYVdwd1ZUVjBmRnhsaGhnK0JP?=
 =?utf-8?B?RFpNZUdpUzg2MWFtZmdLcU0rVWpRYjh5dlR5QndlNVp6UVZSWVRwMHdheHJZ?=
 =?utf-8?B?UVU3c0xtVGVqNmhGOHBUdW42TzNPU2pzaWVrNk5PcklUUUx2V0g5aDhLY0Rs?=
 =?utf-8?B?M0pVYWw0czE5NW9nUE05VjE1dXM1Q1pROXdqbVl0WnVxMVFPRFlXNmhQY0pF?=
 =?utf-8?B?UHZqbXUvTGc3M3FWYmxWeTRuc1RrdlNCNzM1U1BMR0piUHllU0Y5Mk1Ga1M3?=
 =?utf-8?B?b0lHTmliRndqdHczSUdUMDQrL0FHRXpNdElNalhtelRZalA2bG5NSVJUalBC?=
 =?utf-8?B?SmM5dTkzZGM5S01hb2Y2eTNvT0tqME9ONEkrL0tRT1c0VVVpcDN2TUMwUTB6?=
 =?utf-8?B?QVcyUFliWGI2QUgrVGRYZVNhM3kweXI4d2VxalcvNXA4NHBuMVRtT2J5ZVpq?=
 =?utf-8?B?dHdWTjBMdVBhN1ZCQ1lhcVZmbTFsdFVPOG1QS0ZGTGYxZ0VweGNLYm5mdnRU?=
 =?utf-8?B?VTBYZEdoKzcxRGlwY3VkSGZiWFpYRmltVGhBV0picGZ2TCtzUUZoWElVQThz?=
 =?utf-8?B?T254MlRjMndiL3l6YjhJaWY0RDBiSVIwaTl0NC9BQUlWa09vUnQwc1JUZ0Ur?=
 =?utf-8?B?V1c2eVFqWGRVNFVVakRVM1B0MkltM3NmUkZTUHVHRlEvUXBLVi9qbElOOTQ5?=
 =?utf-8?B?TzlJREFuRGdNUlY1UlBSTFkzR0ZZNXVoMVJJZnBDRlU3c0dtNU03RlJlanBV?=
 =?utf-8?B?Ukwxb29tQTVkc3RCV0VmaEVLWFNvbTM2SDlFYWx4cUNzYk9QUUt4QnJFTkJJ?=
 =?utf-8?B?K1plRTg3bmZGbTFsUFJNWlN0a0tsU2IzVXhZdTA0cWNUWnJPdi9ZS21DbVAy?=
 =?utf-8?B?YjZuZ01vaUlFdFYwQUkvRDIxWkppOGpHQ2c3R0ozOUE3MWhkNElocVhFWVBC?=
 =?utf-8?B?bVBLa2cvd0sxR0tmU3Z4WjdMZ2RGWW9jcDNWZkh3dnA3ZkRLMGgvQU02NVEy?=
 =?utf-8?B?TEo4OVlpODZKS3NlOGtJbFZkTmdQRlI1QjN2NlFxWDhKaWhoZnU0NzdSdzZ6?=
 =?utf-8?B?ckEwNkN1WkhlenhqenpNTkNtcUNaOG1RVEJ2cU9nT3U1SHlMS2VNbXYxeGRC?=
 =?utf-8?B?Si9lNnlZdVcyaWY2Wmx3dUVYL0JkZkVDTXZsN3F0MFBzam5BeVJPbHVBdHdX?=
 =?utf-8?B?M2QzTjV0Y2V2Y3dYZ3ViMHM4cWNXRGE3cUx6d3VGUUdGejd3TzdGS1FDRkJH?=
 =?utf-8?B?SHV4RTEwak1wNEd1cStXYWJGUUE4Y2ZBTys2dVJSSUtTaDlPM0pJbmxOM0ZU?=
 =?utf-8?B?d05ZY0hqVFQvbGxPeWtoOVdSOGRPNFVoOTNBZy9ZejlIVEg2TW84MFM0Q1M3?=
 =?utf-8?B?VzFZMVA4ZG9vTlQwNWJTREpaNCs1S2ZvNWl2bEVXNjJSYUVCSzhQUzdsWWlN?=
 =?utf-8?B?czhhUWlQU21USEVBeFVZNnhIOVEvTVFMY2p6UnpxRGVHdVFoT2V0dTlkY1hW?=
 =?utf-8?Q?ksos6QlYvl9xyqkPA9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48cb5236-c910-4c4a-0695-08dedfe3a023
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2026 07:03:07.2559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BsqwzWM3nlJbUy53gLmLPjGhe/R6sbiqB9i0xpt5Wj6pb1dsWVzl9I+LeHhwrU4lW+d1E/bTfcGmgYQN7oUFCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8612
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306929-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dominik.froehlich@sap.com,m:netdev@vger.kernel.org,m:petrm@nvidia.com,m:dsahern@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:from_mime,shredder:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C12074406B

On Thu, Jul 09, 2026 at 02:46:47PM +0000, Froehlich, Dominik wrote:
> Hello everyone,
> 
> I am running kernel 6.18.35 and I have the following multi path route setup:
> 
> 
> 10.181.0.0/16 nhid 400
>       nexthop dev bond0-ip6tnl0 weight 1
>       nexthop dev bond0-ip6tnl1 weight 1
> 100.80.0.0/12 nhid 400
>       nexthop dev bond0-ip6tnl0 weight 1
>       nexthop dev bond0-ip6tnl1 weight 1
> 100.112.0.0/13 nhid 400
>       nexthop dev bond0-ip6tnl0 weight 1
>       nexthop dev bond0-ip6tnl1 weight 1
> 
> 
> The links are ip6tnl devices sending traffic over an IPv6 tunnel to the other end.
> 
> I am using L4 ECMP hash policy:
> 
> ~ # sysctl net.ipv4.fib_multipath_hash_policy
> net.ipv4.fib_multipath_hash_policy = 1
> ~ # sysctl net.ipv6.fib_multipath_hash_policy
> net.ipv6.fib_multipath_hash_policy = 1
> 
> Here are the next hop definitions:
> 
> id 400 group 4000,128/4001,128 type resilient buckets 1024 idle_timer 60 unbalanced_timer 0 unbalanced_time 0
> id 4000 dev bond0-ip6tnl0 scope host
> id 4001 dev bond0-ip6tnl1 scope host
> 
> 
> So I have two equal weighted next hops with 512 buckets each.
> 
> Now I am running a TCP connection in a shell on a host in the 10.181.0.0/16 network over one of the next hops that continuously produces traffic to keep its bucket busy:
> 
> while true; do 
>   sleep 0.1
>   date
> done 
> 
> 
> Thu Jul  9 13:27:03 UTC 2026
> Thu Jul  9 13:27:03 UTC 2026
> Thu Jul  9 13:27:03 UTC 2026
> Thu Jul  9 13:27:04 UTC 2026
> (…)
> 
> This roughly sends 10 pkts/s.
> Now I want to drain next hop 4000 which is where my traffic is flowing:
> 
> 
> ip nexthop replace id 400 group 4000,1/4001,255 type resilient buckets 1024 idle_timer 60 unbalanced_timer 0
> 
> Assigning it a weight of 1 should reduce the number of buckets assigned to next hop 4000 to 4 and move idle buckets to next hop 4001.
> 
> However, what I am seeing is that the connection is immediately terminated.
> 
> 
> When I am changing the weights more slowly it kind of works:
> 
> ~ # ip nexthop replace id 400 group 4000,128/4001,128 type resilient idle_timer 60 unbalanced_timer 0
> ~ # ip nexthop replace id 400 group 4000,64/4001,192 type resilient idle_timer 60 unbalanced_timer 0
> ~ # ip nexthop replace id 400 group 4000,5/4001,250 type resilient idle_timer 60 unbalanced_timer 0
> ~ # ip nexthop replace id 400 group 4000,1/4001,255 type resilient idle_timer 60 unbalanced_timer 0
> 
> I can then see the buckets reduced to just 4 over time as expected:
> 
> Every 1.0s: ip nexthop bucket list nhid 4000                                                                                                                               2026-07-09 13:44:22
> 
> id 400 index 447 idle_time 135.51 nhid 4000
> id 400 index 631 idle_time 117.56 nhid 4000
> id 400 index 720 idle_time 73.11 nhid 4000
> id 400 index 742 idle_time 136.19 nhid 4000
> 
> 
> My guess is that my connection is in bucket index 720 as it has the lowest idle_time reported. 
> 
> My questions:
> - Why is the idle_time reported so high? There should be packets flowing through that bucket every 0.1 seconds, so I was expecting the idle_time to be near zero.
> - Why does my connection get cut immediately when draining rapidly but kind of stays alive when changing weights more slowly? Shouldn't it be a busy (undrainable) bucket either way?
> Bucket nr 720 already has idle_time higher than 60 so I think it would be migrated on any further weight changes - which would disrupt the existing connection again.
> - When / how is the idle_time of a bucket updated? The docs mention that “Every time a packet is forwarded through a bucket, this timer is updated to current jiffies value.” I found that the bucket idle_time is refreshed more frequently when fever buckets are used. But why does the number of buckets even matter here? Fewer buckets mean more flows per bucket, I get that. But if there is at least one busy connection in a bucket, shouldn't that be enough to flag it busy?

IIUC you are using resilient nexthop groups with locally originated
traffic when these groups are meant to be used with forwarded traffic.
TCP caches the route lookup result in the socket and uses the cached dst
entry instead of performing a route lookup each time, so the routing
layer is bypassed and the nexthop bucket is not marked as used.

You can try to force a route lookup by flushing the cache, but it's a
hack and not something I recommend doing in production (it affects the
entire system, not only the flow that you care about):

echo 1 > /proc/sys/net/ipv4/route/flush

