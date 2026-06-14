Return-Path: <netdev+bounces-299108-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CLniCtHyLWoYnQQAu9opvQ
	(envelope-from <netdev+bounces-299108-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 02:16:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DD36801A1
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 02:16:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=xf6BnHcp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299108-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299108-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50141300A8D2
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9221F3B85;
	Sun, 14 Jun 2026 00:16:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011038.outbound.protection.outlook.com [52.101.57.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E9C125A0
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 00:16:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781396172; cv=fail; b=l2E5TtssZ0fnTryyu+aiJ0ZyYZbONhZkw9uX81jGqnaP65SydffGvwyvOtaN6MyBcahFFF0kXntZPbcnGsofEytRlOvtCYP2nw/vEvfQyA4AC/6G3tk/hmf5UxjJGjt3/8Bc0MQ21sOqlNz65+fawVkrU9CpOD5DJlW7+PLbXjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781396172; c=relaxed/simple;
	bh=bp551bPi1Z8JqcZLTryKKrj+LuN4ZV1DLrjQ7OgCDn8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LXIOcl/sHqiIWQpCSsk/pTzGGqoqYak9F10//zddNxIyodzGTDTqYwkzfwjrzMJOEoae0Q31UaepLTC2giDrNMXmlqqL4lyL9FaBSHlHqwZgQHhKnjGjs7g3fVofIy7LF4emAG3pqdKY7HoibEgzzEHMi8MS8Ib6BiaVrYt2vC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xf6BnHcp; arc=fail smtp.client-ip=52.101.57.38
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQBtWiQIngHqr2t9xAEq6vr+egkz/x1GVlDFnToZVhChRXAyjfOp64DwmZjRplK4olfsuKCVxGvxbqv8HKpnv9oNFmXTpR0TwcECkOipP+ZZuvO+SIqpCmZKwBzGemXM+MbJkrF59k8+5umAgCCH0vVk90/Ro6AZw06PsxVUYfsL5zimsyRXVIAGplf18nNeJDX/C0AakSrkiFzRYqV949z9zqf0bnP0DUz2YxauQk5CKyarPBQyCcOGzHfDbti67i3YP87J03L3+IwjVZ0rNDlNtC11vV0SFjnwWiVXNQq/mYkaOA+1GuEG1XY9FZazTenDx7o56aJSkIbzl6w8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzMqkAjG5eJLPWXjW9/ufFvtW/fvMjbZLQvqT3Eukxg=;
 b=IZZBj6wNJy4+48GH7CvdC3WPc8QRGvV/gxchG5iCkkxfzKSm29XbXj+8Ro7DKnzj5XcV+LQ+rKyM56JsqHlGqCo1Tt1YtO3FeauRe+kP4T0AO2OVgVcbDdNof+7bA/R0eCLl+ZqPf4gOHycmzv2qgTDA69w/rv6acdE4yORl8n3K05WMdG3IGhkEM87n4lxk6WopomoA21H7goOCZ4KdULTX+e/fzUWH9zb0XuR+c2QF/k3Sk+NyszGu2qQ/9cgaj62U/JnOCqmc+wls8zvzkAmo/Ay0elOaOvXadIXgs53AISjBJ+iBU2ORp+6FN3gcQ9w8+M9FlXkUyOWWoGAu3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzMqkAjG5eJLPWXjW9/ufFvtW/fvMjbZLQvqT3Eukxg=;
 b=xf6BnHcpyGXW+m5g9aRvTe7ViyHO8HtMdyZM7guq8zQ7GnnYqWGcAbLmQn47PijtdRE2MRVCVgj4ewdX1kmIIJLGL0Q/AXX2vFFXb9gpbX6LDL7OqzYkfv2hKzv0BeSQt0tfahr4/cw7vRva6IlDfN/DID5Brwebod8rLCMPdA8=
Received: from MN2PR12MB3485.namprd12.prod.outlook.com (2603:10b6:208:c9::22)
 by MN0PR12MB5809.namprd12.prod.outlook.com (2603:10b6:208:375::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Sun, 14 Jun
 2026 00:16:03 +0000
Received: from MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9]) by MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9%5]) with mapi id 15.21.0092.017; Sun, 14 Jun 2026
 00:16:03 +0000
Message-ID: <7e1e35d2-92dd-4737-a465-37aa6155ced1@amd.com>
Date: Sat, 13 Jun 2026 17:15:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/6] pds_core: Add PLDM firmware update and
 host backed memory support
To: Jakub Kicinski <kuba@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
References: <20260608223256.12357-1-nikhil.rao@amd.com>
 <75c74b95-097a-47c9-9a55-a4150394abf8@amd.com>
 <41d3815e-f060-4003-9974-42530addc641@intel.com>
 <9e0a17e1-006d-473a-adff-ab76bf91d0ab@amd.com>
 <1264de6d-a669-4afa-ad08-594d956e101a@intel.com>
 <20260613135811.1b1f7e65@kernel.org>
Content-Language: en-US
From: "Rao, Nikhil" <nikhirao@amd.com>
In-Reply-To: <20260613135811.1b1f7e65@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0026.namprd21.prod.outlook.com
 (2603:10b6:a03:114::36) To MN2PR12MB3485.namprd12.prod.outlook.com
 (2603:10b6:208:c9::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3485:EE_|MN0PR12MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eb7b3fe-b4d2-4161-cc5b-08dec9aa1e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|4143699003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Ex6rLoRytkZB2a7RqoerlanSWpiyqDigZrMtiCLk+zI1Mjugxy+8qYHSd1sm8r7CK6Mjend6Us3zVL8saK/KuSItibXCncgCHklaAVgNBBE0IjZtnCBP932Baw94YJKYj5wsmhDHMmZ3XdJ6EntGZTKmbZ8vI3csYK7GeNdD0WNnvyQ880xRWIi1A15RiEBVKqtPTOgXXdMt7oqF4Pv0VVersL+r7KQxOc0/6wn4Q+6r675/iF6ZG6/rEsYoqeCzvKpZ1pzsYXeYj8Kne+B9ieuOgXnwdryj1z3wEZ1AbFXoR/3lT0ZXg3VZ7RpnQWoYkBfY19Ko/pxWk1s3hc71DOIAcf8exi05qwi6mAfgPv8SuVNAEIoH8RmLVznyQWfPUccM/USMoGXUr2tE9wYhxkqrqqczv6BADzH5pfMCDuaycemfxkCupkalnmyNiv8ItixcUENaBR8nm/SfWMv0qQDWhhZ6ADkrOAqMdyffW0kUyYpK21DkPRmLfHy8YiFzfeE/gyy08cwX7+YbX0TEAQVYGtYVyubQU1Bl7gYVjdkTTTPDH04XzMHpbEmoLM/zu9AUgDDI0u+bZ66FfRgIQofq3GlYM0QGxtKYHH8psM48RvN3Uiuh3Vf6BK3hmiz0s+gb5eh4YHuvRSGJcr1RtVtZepjgqS/jJvGs8bcWAxH5thFkaFGKCD5DI0Mc0voS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3485.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(4143699003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjNiRXJZYzhZY3NVV1B1ZUtBNFp4QmNkMWl5NFVYV3Qyb0l5TENma09WaWht?=
 =?utf-8?B?QUwyamVoejFvSGUzM216WXc2VXNqWlV1NGl4RGNlN3M2NFl3QjNmeDZoV3Rz?=
 =?utf-8?B?bkVvR2gyUmI3YktaekpRN1ZBcnB1dzR6YVpVcE1ZdVFTOFV3dy9FM01OK1JY?=
 =?utf-8?B?WHM2TTljT2xieW9sWlJkeW4rMEY2blRXK1ZiTDRjUk50VGYwbDg0TTRjc0Nw?=
 =?utf-8?B?cVd5NTM3Sm1SNFpyTWFRdm9ZUVdDNXZJbkcwd3FCV2JMKzFiOHRjcUNwNnN5?=
 =?utf-8?B?dmVidDFQY2hLNmtFRkNUVzlSQWRLb3dUb2dQbmZwZ0t4NzcraHZyd3hzWGFo?=
 =?utf-8?B?MVFQN29KdHhtUTdnNFozd3pnYnR0b1IxUUZNQTh3UW9oRjI5Z0hGK20zbWJy?=
 =?utf-8?B?TG4zNzNXZk90bldaUXR3aDZYYUdyYUhEbllHWjBEQWQxa0lYdzE0OFc5d0gz?=
 =?utf-8?B?ZVByWmlzS3lSa0IrcUtkaUxqem14NWJhSkFrZ0dnVDF3VkJsSXB4NC82THE3?=
 =?utf-8?B?bjNvcEdNNzg3ZGZRT3dob0Y1U1dZS1RqM3NNY0Q1SURHZGV4MWVsdHpQeUU4?=
 =?utf-8?B?U2hFQ2ZwZk82UFFiMWM4cSsrRmViYUk2dm9FLzVPNFdsTmwyL2NhVnVJdzJV?=
 =?utf-8?B?QTJYandnY1FSR2xlWU1EcHB1d0NZQk5YUHFUUk1FQzNQZm5sS215dFZKQ0VP?=
 =?utf-8?B?YWZmS2t5WktwbmtoOWNsbDlsSkpVaW1VSTgzckVrTUVvRUZjMEdjbGRNblo0?=
 =?utf-8?B?SUFQaWdLcmF0Tzk2TnJTSlI1RG00ZGNydGFZTDRrWVBNdDdqM1JWQzFINDJj?=
 =?utf-8?B?bU1zZUN4bXhoTWYxT3M0c3JqTEcvQ1BwVkZhQXFscXVKQ2V1bXk1UFVDOXpp?=
 =?utf-8?B?Nm1HRkk1UlVQYy9LZW1tRVRUN2tZY0oxclpiUUh4SDM2cHROZWdDL3pDTHhB?=
 =?utf-8?B?YWpjYW91d2M1bjBZN01jc1JiRFl1N0MwMHk0bEMwMXBCcXZPeEs3ZENJeUVD?=
 =?utf-8?B?VlhNZytFeWV3MTA1ME40emhRQ055S0kwV0FrTXNjbnRZVmJFaHQzVy8yK09x?=
 =?utf-8?B?SWQzaU4vd1NPM2kxa2hVR2VUczZvcTFNRjlsU0JCZ1R6Szk4UjMzNGcrbVZY?=
 =?utf-8?B?dlV4aVhheVJLYUZWM2d6ZlRxM1huM1pISDhiQmYrTWNIcm83L3RzaGs0Y3g4?=
 =?utf-8?B?U0wrQWE1TThiODdGYVlMUnV1dnZMQWZkaU1uWU1MTEZGR3FqK2grSXFVWVhC?=
 =?utf-8?B?QVFSc2Fmbm5DOEc3SjJCaVpDTzZKbnJrTndyUVByVXB5bCs3TUttS1Q0WWdr?=
 =?utf-8?B?OHJ2aVZaQ1VadGdPTXNjSGFCcWx4c1J3cUREQ1RuM1crcTBjUDZUbGJuOXY1?=
 =?utf-8?B?NDRWMFhnT214Kzk0K1ZvUjFESTJjRnAyR2lCeXdnOG5QbWhIK2RsRENsbXdB?=
 =?utf-8?B?OFZCcDd6SVhQeEluVGxBTW9iR3ZFakdNSDN3YXdFNmtGUUs4QVN1QmQ0d29q?=
 =?utf-8?B?WXlwNEpsR004Zzg4OUdxcmpYUy9XeWxMekRFbkFYbkd5S09MSm1TNDl3UkZi?=
 =?utf-8?B?ckg5NGl1YnFsSEVXd0ZPbS9HeVYwODEzNVJVRkVYd2k2ZHNoay90RWJRMWRX?=
 =?utf-8?B?cncwOUhvMlBWcm5Qa0l2Q21obm4yVmtWZTlWSEhOaW9ZeXpiWXhqaXhTeU5F?=
 =?utf-8?B?N29PQlF2SWtLaEg3ODN3Qzk4RzlnUW1MbCtXMERQMUpsMkR6WHdmcFFmbjlq?=
 =?utf-8?B?NVRyOWZvYUlmT2hTVXZ6eHVPVHM5QWFIMWlWNTJtbW5sQk4xZ0ROTEZyU05p?=
 =?utf-8?B?cHpocVNIdmJlL2tKNTA2WGcwSFRDTEFNNUdWYjdtTXJBbkdJOE9TZm92RmZY?=
 =?utf-8?B?Y1RaMlhRSG9acVdiWDJ3eVlGZHdXUkpVVFEyTlJ0VGU1Q2VLbVlvQjhtODRm?=
 =?utf-8?B?SElCQk00Z05GYVlVWS9WNWQ5Z05LczdRLzlVdDl3aXJWZnd1ZkYydzJ6bHpm?=
 =?utf-8?B?bVdpRHhXTHRaZXlaM2tubnJPaHpXSHUzR3dTZXJYTU1YU0hxQmU3Tkg1TFM5?=
 =?utf-8?B?ZCtVSnFuRkNtREwyT3JmL1VhcGN5SGZLM0V0OXFFZEMxZnFsZExqR1JlL3dV?=
 =?utf-8?B?ZWkwYktNR084aGNXOXhPZEdpNE95TlpqMGdXTU44dFFRaTRpNGNPZGUzam95?=
 =?utf-8?B?OGtUeWdIcnlzSlBmYmJwazlaV21oRE5tTTZEYm5FZWpySUVSY0dEU3d6Ym5C?=
 =?utf-8?B?cWZSbGEvRW1pNXo5SzlOZ2piellCQ1U1VGVsbDVaN3NEVkN2RDJwMXI4V09I?=
 =?utf-8?B?SFVmUkh5Q2JiRGdpRlphUGlpaUNuVElZSGh2UVBOOWtza1l0REI0UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb7b3fe-b4d2-4161-cc5b-08dec9aa1e83
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3485.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 00:16:02.8973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //Wqu0grFB0pKRCL+/mzJgTbrkPlXBAaBtgfxfTbDL6pH6U28iT2uo4W7lj9rp54gQH+EMTQL0tMGpw3tPx07g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5809
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
	TAGGED_FROM(0.00)[bounces-299108-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nikhirao@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:jacob.e.keller@intel.com,m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:eric.joyner@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 54DD36801A1

On 6/13/2026 1:58 PM, Jakub Kicinski wrote:
> On Thu, 11 Jun 2026 11:53:13 -0700 Jacob Keller wrote:
>> On 6/11/2026 10:15 AM, Rao, Nikhil wrote:
>>>> The preference is to use generic names when possible/feasible. I think
>>>> at least some of your name choices could align with the generic ones.
>>>>
>>>> Could you explain why fw.mainfw was selected and fw.mgmt was deemed not
>>>> suitable?
>>>
>>> This component handles both control and data path, so fw.mgmt didn't
>>> feel right since devlink-info.rst explicitly excludes data path from
>>> that definition. We went with fw.mainfw to indicate it's the primary
>>> firmware component
>>
>> It might make sense to extend or add a new definition in this case.
>> Technically you could also report both fw.mgmt and fw.app together, but
>> I think that would be more confusing.
>>
>> Perhaps Jakub has a suggestion on the name or policy here. The
>> maintainer preference has generally been to use or extend standardized
>> names first unless the name or component is clearly unique to the device.
> 
> If it covers both datapath and mgmt then shouldn't it be just "fw" ?
> Right now driver reports something "running"-only as "fw", looks off

Will change the PLDM component from "fw.mainfw" to just "fw".

For identity version 2+, the PLDM code reports both running and stored 
versions. For version 1 (no PLDM), will retain the dev_info.fw_version 
running-only report.

Thanks,
Nikhil

