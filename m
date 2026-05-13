Return-Path: <netdev+bounces-287563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGiqGD1oBGpVIAIAu9opvQ
	(envelope-from <netdev+bounces-287563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:02:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EDE532AF6
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 138C4304C9F5
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBCA3FD128;
	Wed, 13 May 2026 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ie2Xdk9i"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013027.outbound.protection.outlook.com [40.93.196.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7473B38E8B0
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 12:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778673713; cv=fail; b=KV0gwU/fGtvvA34sdPKJilbwPNmXro5tiQgZqW3NVmnLsPIsuCzsmOG0iZKLkJ3mO/WDM0pvL8FqB1Qtd1QY4m2ZoOUF79hMUnOKHq0iYwv8mqTaFXoxBEbcVQpI9xiHcu49RkiVsVWAqOs8f7Cx+VmZ8GWn3leSYmBwlArvN2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778673713; c=relaxed/simple;
	bh=lTe5lqKwCDmS4/o716Oeph61IrXSAzG8vhqcK1dUrIg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JzCkw9VHSiLIAVZ0Zh92H30/70cMXndolKaXBzYkpvVyvxh405lC4njrJDlX3nJV+qIkLN/SWXj1Cb3ianLHjKYiIEPb+yf3sFDCud43sWH7UUPuqR62chZvz5CUAroAZ0mZe9W3FgfhQErqMZgAmx+mo61EVtpX9x7rBt1Bark=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ie2Xdk9i; arc=fail smtp.client-ip=40.93.196.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbMulhWPC6RRYooXRPXc/0Oe1S0cwiMid6IDrP5dWi8JAo+Cz5X7JN0PTFoRtYny6fAQDY8DgEVqT4xmLDfwcFt4Nzkpbaa/F5Qzr3ugQSCdYbGYSSyrRLNCZXqQ4DHfMfRQ8Nw0VqoX5MYySRY9pjoJag1DbInCbAhPJplwjjH6aYycSop+8BTM0+/uuM5a3sbZkOvOjw2S3JVWReY/ReT6lc/HR5lEgothGkfMfl7fcp+8DnV3KvcD1A+rqT1viGiyjijZS3Jp13vjLAW+FYxB10qKJqj8ztcgCmkyWYK49YvylBXTT3jrKQypMytRZKSC2DjTHDair7vLHMiS3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txJSxIZ1OxiDOKQGjA2xuQdg1wVmyNoMfb4hvD5a76Y=;
 b=O0NbA6zk8MeGh8CmLCrvm1f0KKjFIZ3gfAQAIbSSMdQ7WLt2hKDTjKPfqqtx2RznMOEbN6tRyE+N+zAEf9Gt2zyz+Go9HVZZ8f+0MSRm2ukOtEbVydjnyOcWjSZEyOQFjfXrm6twTJI5wr2mnN2BBeHiS7uvzTPfE+CFTZIp4l0n/bFfOjbXmuJER9EvRiTP3cGMgES5r2LwrLnwe8DHEAxEgDNzs67EvLtfKdTTOyYoVCzupmypsrjgkeOH3azHXN4I+i+lpUsd+yZRHBOG5Y4Y0PrU1dZOTJlmjWjoDhXSWb4LRP6ogAAVKDmT+ISBkxySwHup503EYQqomj5zSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txJSxIZ1OxiDOKQGjA2xuQdg1wVmyNoMfb4hvD5a76Y=;
 b=ie2Xdk9ioXTBYEG+psO6mcYB7w5pA+SLbXRbp4c0XqbDmuUJDq26YZ3JA3mn9Auifl8932AGomRU1A73FiDpmKVUVkANO0d3GCJQMa5PyppHd2ip8KmgDiMMrrqJRDwsjldf2eIf2oBPufvOdP6AppvJZve67PnOExIYX8rheRmtsCODMBlNLMRRO755NI6udmD66PYRUnpudd00ifNzrrZv/DQt+00QLETG5ePiCB2Ht4jCtD9+H/Kzar4LxuewxbzfmJj5nz/999b4Y2aOkwi5YjHka4E05yr+Y5jIuHZXGJ2VTBoNE/rhwT+2yvmbytgoX68Xc7uhXFPtDlM1VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15)
 by CH3PR12MB8536.namprd12.prod.outlook.com (2603:10b6:610:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 12:01:46 +0000
Received: from DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385]) by DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 12:01:46 +0000
Message-ID: <c4279000-dd9a-4e59-ae0d-6dcc5c7b03a2@nvidia.com>
Date: Wed, 13 May 2026 15:01:40 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] udp: Fix UDP length on last GSO_PARTIAL segment
To: Alice Mikityanska <alice.kernel@fastmail.im>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>,
 Willem de Bruijn <willemb@google.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20260513074349.2152146-1-gal@nvidia.com>
 <f75c1cf5-b5ad-47db-952f-faad9f0a33ed@app.fastmail.com>
 <f356add6-e173-4020-a8af-8cc70aec955d@nvidia.com>
 <ea0d0e1c-bfc2-4271-94d7-3bec2f2e85a3@app.fastmail.com>
 <c129979f-7494-433c-92c4-6d4290add4d9@nvidia.com>
 <23e6e0f4-29ee-4f86-b02d-8c8d881c51f7@app.fastmail.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <23e6e0f4-29ee-4f86-b02d-8c8d881c51f7@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11)
 To DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5248:EE_|CH3PR12MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bfac103-3dbf-44ec-1ed3-08deb0e76812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003|11063799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5FRp/Gcv3tK9E6pzt2ycBXIyqLpUzRQruvIU6WtL5QEGl9Pz+Wh2yVjT/jlgIfdijSktFajtPFY9og2PuE4bF4MWUIDVHsIZCe80ekI84K35gmtbEm0Q1tuyX+gdqPtFt26T6XwKuaCDll48OrnXyFCsfwGcBG77GbAzZf9V4OUMmhuG24B2L1DqZ/TcxcxSnQMJ74cClcuiik/vBxi6z+OeYQ5u4OXIOIZj1IFhvuCXNOOJUu2N6xJGmARRPagjYJr9NglFFIJ8l+bRbF346VWBSePr/FVxw00TmqTjKsy8sFuF4OHFy5KNl0iQWsIE3MrdjoOHrh42oDsyx82iWXKEZajRiRCw4Nsha0QL+Wti5HbkEjtpbwyulvtZ2qj3mqdWF+bAgZ5Ed2ZXD3yN6PZ31jXBgWzit/F7w0XwHKrQCWcwGEAEyFljfP5zxA8UrUW6OPao93HU+q1JdnP70XfWEZEJ7XxTiYR0+EDG7DFcIcgHAcuykOoSdVDGD5zwZUvDYHE4527cjHa14vTAn6oQbgIbakmX1IdOXu4FZOpCrC27rzvZjDyopvjaZnAr70+oGN+NevCNIimnRVcpl4WY+uARl2guyjVH8WBK062sCiMQ/Z3w3KteLviW7U405oUrgG8/6TC1wjeNY83qe5WwFhZVHmXrR9Kf+sFA0T1wGKNKtEyXraaB6PlB5545WRUmKVR/S+8xP9ctn/djXQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003)(11063799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEdIUHRXK2RKUVVwZ29oQlQ4bEV1R1orYTlFZTdEd3prai9tZU1TSkxHL0d2?=
 =?utf-8?B?bzhDVkxxb3FRTkxnNUw1Z05FUFU5VjBpUnp0d01ENzB0NllJS2l5WlhncEVZ?=
 =?utf-8?B?cktJVmZwQ0dqQmNoeWpUT091ZHRPVUNOREFZR0RFdGUxT3FPRHJqYWNqckFO?=
 =?utf-8?B?cmNxd1laSjZyTjcrUmFMV1JYNXBGMjI2dGRKbWFOVmhra0VQRmwwb1dCRjRZ?=
 =?utf-8?B?MGdNcUtQaVVVclpER3hOVDVub0MrUUtaWVlqVnpoSG91QitJWmM0T2NRM2xO?=
 =?utf-8?B?Z3hieUR0dk94dVZIV3EzNU1ZRTdZZTY1bGFGS2IrRmpsTDhNWm5sMXJXbURn?=
 =?utf-8?B?UDhZNDUzVjRmSUFQczlhd05pYXNjeDd2M2JuejhaZHVFZEtsYk40aFJubDVp?=
 =?utf-8?B?WDNFZ3lDNzJBa1ZTelIwR2NFN0NWRi91NndFYmhuWkFNcHZCNE9sWEU2MU92?=
 =?utf-8?B?MVpKM2p1ajR6alVaMkZ2U211SFB4VThJRkp5WnY1TGdRUzFOb2o0ejZzVmhE?=
 =?utf-8?B?ZjJLcnNVMThGYzZ6MXdQUklWaTI4OTJpaWFGODR0aUFJdWxiMDdrVWgyYTAy?=
 =?utf-8?B?aXdGNUtOWG1oekdTRThvdE1sa1ZhcktJaTJPTzZBNm82VDZ0VkZlbnB1WEsw?=
 =?utf-8?B?K2FzNStoZUpDV1p3dG1PUXI5ai9LYnl6S1lzcGJFNGhnd09CUG00THlSK2pT?=
 =?utf-8?B?eCtRRm9UdnFiSkVtVGMvYm9WbWlYMkJzaXpvWTN3NkJtbzRkbXM0Z1ZQQTQ1?=
 =?utf-8?B?V2FzM0haUGs1VnVCMjZOSlFxWlRNNVI4WmttcEg5QkpmdzQzenFPMGRxY2Nz?=
 =?utf-8?B?VDRrR3MyZXRUWmVFc0VzbXdVYnB6eHRuL2QzTTRsZjhYdnJWR0g5eXdHUnlX?=
 =?utf-8?B?UlZkbzV6YUFmL1BOTncxbU0yaDRwY0ZBUmgxaXljUUxNSzlZNkF0aXo4TW0x?=
 =?utf-8?B?ZXJlL0p2OG10bk5UT2cvN3Q0RDEzRUpNdndRYzhLS3JxalFVa3JBUlJsWW5V?=
 =?utf-8?B?SDA4VlZobE9PVzR6cFFmUGpTbkxYYVQwZGhvNitOUU95ZlQyQXNqdi8xbjRL?=
 =?utf-8?B?Ujd1TGJsVGt5Vzl1WkEwS1pTb1cycm41MENjckJ5YStwUWwzejhsSkNVSHJq?=
 =?utf-8?B?amdEOXBOQjBPdENOTTBnQ2krWmJNWXpXYVZNdk15RHcwM0l1Z1BRdnRsTDZV?=
 =?utf-8?B?Rjd3SVo1blpoS2Y4Z0xUQnY2TUZ1NzM5c3dFWldNVjVUOS9WL0ozNUpkVk1N?=
 =?utf-8?B?OWRoWS9MZXJzc1lTWVljYUpaTmZhcm9NUUhxcUg1NDIyVHRnbGJDWkJ4U2Uy?=
 =?utf-8?B?bXcxeGJxS1ZEVTRHSTVPOC9JVlhHbklNTTQyVFVPRnpXekZpM0grZVhqUjlw?=
 =?utf-8?B?QXlGL0FXZU9lN3FZYTR3dFBnVWQ4eEFHcnphSFpkVXpHK3NEaEZpYmJmTkhG?=
 =?utf-8?B?RHhmM3dpMGZJQ3FxVVp2QVgxUzBJdC9wcEQ2V3ZpWlpzRGYrZTdQeXpRcmhZ?=
 =?utf-8?B?QndMaXJmNnBnTExEUTN5UmhrdEVPOGpZcXdJYU9lZzZJa21WYkJhdWFrcWR4?=
 =?utf-8?B?cjRrL2hiSkNxeitSR0FaNVJzNTJ4aVQ0ektiSVp4eUU3d29OanVHQ1NhNFQ3?=
 =?utf-8?B?Q2w4ZjNDVDhMRVBza1RuVVc5ZTBGSHFFQ1Ria0t0TUpBTlVQUCtCSlZCM2U4?=
 =?utf-8?B?bFNhYkRHYWxxa2F0SXdYaXlWSk9ZYmtDYmJvZzNaT3NFZ09YaDJteHZOTnd6?=
 =?utf-8?B?bEp1MTlWUjNZU3o4M3NtdkhvejV0RDZwQ2IvZDhhbU1jc1BlNDJpTU1RazJw?=
 =?utf-8?B?Q2xDVUhWK0M2enRFVWx3VVRzbmlzWEFNVlphdm9uRG1WY3UxRC9WN05lYWJG?=
 =?utf-8?B?c1pEZ2pjZTVtUEZ6K0szUDc3aG5qbnlOd2dHQlRQWTdLS3hka0NOZ0UyNHpp?=
 =?utf-8?B?UThPV2hLTmdEZHJFZWdjRHIwc3pxSDZjWVBDZmVjaXd5WTRjcXlERUlEYWxh?=
 =?utf-8?B?VGxhTC9ERGZGQlpYc0w5NEU4YlBrTytNYlFQNzdxODV2enJBL0RzWHRqZ2NF?=
 =?utf-8?B?L0x0cVRSSTVKZ2tQUi9CUWVpZHZ0cEhDT09pWGZlQmVpd3BBeWJxSEg1c3Y2?=
 =?utf-8?B?TjkwWDF1SUhQU1pxSzJOSUNWOVRkL2xSRDg1T05ZQUwxQ0tYMEVLbDdEUW1S?=
 =?utf-8?B?QkpxU1hKWmZ0MEhKR1cwK3hNa0szdHdCaTY5b2krVmV3MHBBeXVMTUtHYUZM?=
 =?utf-8?B?bjhmdHkvNGRzQUgyaCtzZzZTSEpzaW9vUG5TbTNFNTVGcmdBQnQ1NzZCbmhG?=
 =?utf-8?Q?TiphYWo/4WsPSmYix7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfac103-3dbf-44ec-1ed3-08deb0e76812
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 12:01:46.6250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDbPvs3r3hph8jtkTpPO6caJ5bjVrMCTdUZhDRW8eiH6Ljoe58Zi4yKT6AlVUpAD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8536
X-Rspamd-Queue-Id: 07EDE532AF6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287563-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[fastmail.im,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,linux.dev:email]
X-Rspamd-Action: no action

On 13/05/2026 14:48, Alice Mikityanska wrote:
> On Wed, May 13, 2026, at 13:28, Gal Pressman wrote:
>> On 13/05/2026 13:08, Alice Mikityanska wrote:
>>> On Wed, May 13, 2026, at 11:43, Gal Pressman wrote:
>>>> On 13/05/2026 12:17, Alice Mikityanska wrote:
>>>>> On Wed, May 13, 2026, at 09:43, Gal Pressman wrote:
>>>>>> Following the cited commit, __udp_gso_segment() writes single MSS length
>>>>>> in the UDP header.
>>>>>> The cited patch doesn't account for the fact that the last segment could
>>>>>> be a GSO skb by itself. This could happen when the size of the packet is
>>>>>> a multiple of MSS, hence the first segment is also the last one (there
>>>>>> is no need for a remainder skb).
>>>>>>
>>>>>> When the post-loop segment is a GSO skb, assign the single MSS length in
>>>>>> the UDP header.
>>>>>>
>>>>>> Fixes: b10b446ce7ad ("udp: gso: Use single MSS length in UDP header for 
>>>>>> GSO_PARTIAL")
>>>>>> Reported-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>>>>>> Closes: 
>>>>>> https://lore.kernel.org/all/6c3fb15e-711d-4b8d-b152-e03d9b05293f@linux.dev/
>>>>>> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>>>>>> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>>>>>> Signed-off-by: Gal Pressman <gal@nvidia.com>
>>>>>> ---
>>>>>>  net/ipv4/udp_offload.c | 2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
>>>>>> index a0813d425b71..71df45f9488a 100644
>>>>>> --- a/net/ipv4/udp_offload.c
>>>>>> +++ b/net/ipv4/udp_offload.c
>>>>>> @@ -604,7 +604,7 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>>>>>>  		       seg->data_len);
>>>>>>  	check = csum16_add(csum16_sub(uh->check, uh->len), newlen);
>>>>>>
>>>>>> -	uh->len = newlen;
>>>>>> +	uh->len = skb_is_gso(seg) ? msslen : newlen;
>>>>>>  	uh->check = check;
>>>>>
>>>>> This is going to have the same checksum bug as your first commit, which
>>>>> I'm fixing in [1]. You should use the right value of either msslen or
>>>>> newlen when modifying check a couple of lines above.
>>>>
>>>> I tend to agree that the checksum seems to have the wrong value, the
>>>> reason I chose not to change it is because my work only moved the UDP
>>>> length assignment from the drivers to the stack.
>>>>
>>>> The "wrong" checksum value was used regardless of my change,
>>>
>>> The wrong checksum was visible only inside the driver, and since the
>>> hardware didn't care (due to the offload), it worked well. It was the
>>> driver business to make sure the corresponding hardware likes the
>>> packet. After commit b10b446ce7ad ("udp: gso: Use single MSS length in
>>> UDP header for GSO_PARTIAL"), however, the wrong checksum moved one
>>> abstraction layer higher - to the networking stack, which attempts to
>>> keep the checksum correct for a more generic case. It's not the same,
>>> and while I'm trying to fix one occurrence, I'd prefer not to
>>> introduce more.
>>>
>>>> and I
>>>> prefer not to change it as part of this work.
>>>>
>>>>>
>>>>> That said, maybe you can base your patch on top of my checksum fix? For
>>>>> the last packet, it will then be:
>>>>>
>>>>> if (!skb_is_gso(seg))
>>>>>         newlen = /* the new value */;
>>>>> /* keep newlen as is otherwise: my newlen is your msslen */
>>>>> check = csum16_add(csum16_sub(uh->check, uh->len), newlen);
>>>>> uh->len = newlen;
>>>>> uh->check = check;
>>>>>
>>>>> [1]: https://lore.kernel.org/netdev/20260512165648.386518-3-alice.kernel@fastmail.im/
>>>>
>>>> As I mentioned in the other thread, this fix goes to net, I can't take
>>>> your patch.
>>>
>>> Ah, that's right. Still, I guess you can take mine to net for the
>>> checksum fix.
>>
>> Do you think it is suitable for net?
> 
> This is always a mystery to me... I've had different experiences:
> sometimes I am asked to resubmit less important fixes to -next,
> sometimes a fix is a fix and must go to net. This one is a refactoring
> useful for my further patches + the checksum fix, which we get for free
> and which I considered not important enough to submit to net (hardware
> offload fixes the checksum in most cases anyway). Following the "a fix
> is a fix" logic, we may try sending it to net. What do you think?

IMHO, the motivation you provided in your previous message for the
checksum fix is convincing, but as I said, I think the commit message
should be phrased to explain the bug rather than the refactoring (and
add a Fixes tag).

