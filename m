Return-Path: <netdev+bounces-291212-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPUyMGQlE2pB8QYAu9opvQ
	(envelope-from <netdev+bounces-291212-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 18:20:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 135BD5C316D
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 18:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 054543020A6C
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 16:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284983A8FEA;
	Sun, 24 May 2026 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hpm1pYC7"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013015.outbound.protection.outlook.com [40.107.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3542258CD0;
	Sun, 24 May 2026 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779639241; cv=fail; b=R5Lch89aTltJ/NHVvYeBLzJuA771RhhCq9XemtcGUY42pKfGQ66XZZ9ANjOcmSujBQ2OHQyCFLOOHaSgXtUhGcLJP9XVtn+Fs3KmmYJgf5C2pV0sb+Y4qSIa9uIywWcqKzc4RG6M2FsosoQBjt5zwWnOmiOZwqNFfeEhXUK490g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779639241; c=relaxed/simple;
	bh=8x73j/iUDheOFpKTn+JbquB13Ku+u3jLXKNgQbxZpFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nR/jz5p96Db+QllKQEQG2+K9Y/IsC0vEXbtSnABAXg6F3O7Ivl+0Qp/mnzjymIrVc6mLJQy4MDdD/EJ6GqMCOFolqEuV4ngqTnoajqhWIlw1f4LBY9+M7iiMhQoe14MZCGsXSpNOEr4vq6HdbNTtlRlYQYsDoFuRb92n8rv1kZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hpm1pYC7; arc=fail smtp.client-ip=40.107.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e35noiz/Bnp2SybezuXV5QVa4wOiALekeDBOmKwbuDsCH+0EtpYUU8sHrmP1pR9tn/vyebYLYprPyHEMJ3rDuUTr6AXywksGeY/gIGQUflzTyIUBOGiFNMmUaxf/PPPGunNjE+cZsjNMJ04T0PKId9k9lryTuVvGSMOUixHlqIlNQtwjIPniiyMWeBMGPwkdSN0UDjOpuny+jklUE6FKQYQ5pqwEb4iEps3EmTLhZhTmaDPtJZdwt4hX31B8DD+pGzglBalZlQV+SCXlqdpt60Vis7c/gHG8JqmR9ddV3iLGblcxdN6jQRMNdN0pSoiAzFUiD4nCa4LMoWrR/8I21w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToJTg0M1YnGEPm39rC+RuffPeR8oxam07VchpqEQkAQ=;
 b=Wd4QI37JPrWWknYrnSqj7A602a9dcGZftEXWTSimgU38yatJWgs/a9EPJfYkwEWZLGCGcfGjTepOHdJwkF0GkiY3MIoMJvKY9iqILksmaDVBYkF0qLEkCeLKp5RyDDGIjQcoZatzzwvonsN3D5rwc+/en34x9EMZqsYoWVbaioum3yJb0DijlrJnnLvQjrEc7Djj+JNlQ85od8LNGFzgTw3moWX4IavSrxqD53mQ2juIO3+R4yAVBhsluQ8N11BL/I1Vy+GtqXtVKS1K1vms5/Jt2Ob41bLC5rspy8DdX5rlostGzvjyQVP8qL1sz9Rs67j6c/ogoSRUk6ewCT088Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToJTg0M1YnGEPm39rC+RuffPeR8oxam07VchpqEQkAQ=;
 b=hpm1pYC7HPmZBoQIvpdg42JMbDIkCLgwmbZ/7nYcIS1dNuGYharxUCHYd2HHWvnLoSchawVBU5X1lb6jnnOrEoYzW4ov7rch3DvVBSvJMst92w+6CyCR1AmpUAD8JPtVB0cfcUS7XrS3eULUJq7p4ZSusUD8pPUT98e6dZgwrkiUVx3WyuE/7uNEb98o7YttBg5xx8egdD9ZRaa6YIRTtLezrZ5wDJWalsYGXIcUevJYeTTlTnztB+6a2EVFWgfigqMcwXJyJcB01XwcGGVkOAbdarxWchfmvXvvsatc2vyRLRScaDuU3LlJN8NmoIEPleVxhM9qUqudl8rAA2vgvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB7340.namprd12.prod.outlook.com (2603:10b6:930:50::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sun, 24 May
 2026 16:13:52 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 16:13:52 +0000
Date: Sun, 24 May 2026 19:13:43 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	horms@kernel.org, pabeni@redhat.com, edumazet@google.com,
	davem@davemloft.net, dsahern@kernel.org,
	=?utf-8?Q?=C5=81ukasz?= Stelmach <steelman@post.pl>
Subject: Re: [PATCH 1/2 net-next v5] ipv6: addrconf: fix temp address
 generation after prefix deprecation
Message-ID: <20260524161343.GA110992@shredder>
References: <20260523103811.3790-1-fmancera@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260523103811.3790-1-fmancera@suse.de>
X-ClientProxiedBy: FR4P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ca2a5d-1649-4388-1206-08deb9af7278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kJ48ud1FbBoesqjBfNMlBBeeJ1O7R5QZXAVDYzt31ieMeTeMJw8gAWYBbndy+L0B5MKWI4IoXaRcUvX9lfTwwCHDf70TWjDOprJP7e+etgGefspQAlzCdpQxwijObwim0OD2EowdgjVDkBSrANGSS/07o7kTImcvxn9MNWwvgPdiO7JPlmomxXYwqaApKAP7QE1sCxtaFnNoED/ljwkZSFNFHLdab9zdDFjvxncqpdCekcnPuAr/UcQUvS+S0ThwSc8khry9sBfQHSY/+BwuZN3kWLhKzxZj4+AYbEMsDKTJDWDvLXh+iytXEjfj9Mx9xv+PZ4MGajr4YzykGKupuUQbHIEO8dHYsbaIn53hWGI07DMIp03JOXZiHZ8zR7CEAmugUCHu9MzyjpjG+EfzNrBT8hsL7MdUs9yhZCXifH/WyNARsq9hxg+WV44CBUtUWnaYvPrNS+RpYlCg89Qqd0zwQfpnJ5XoPX+c0npL5ue2ftF1Hic9KYe6hXS4+rsAmdEic1ehmEQamnTp4sjzYPnJ5OQVVoGrv9iDVZIVyVlWXy3JhMWk0r5hNXdDrEc7zshYX3p2gnI7YJJWJWeFosvUhLZstpBxYLm8AzwhtFUaAGHgmMyHjs27zWvse6k/qocukb2t/dvHBapMW/3C0z3hJeWwp93utegACSHxqhHbCL9grZNXKwbF+r0S4WbESRad+xw7xTGQz8rVEwFANw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0FzR3JDNnd0c1BzUURZRW1BTnVKa0JXWGJ1WWZXZEs5Z2IvWU03UzRwMVIv?=
 =?utf-8?B?bUwwMkprUGpiQm9ZWENhTUp0NG9COGp4L3hTcG9oeDh5SkJqUXRucjNNNHpa?=
 =?utf-8?B?RzIyZFpXMktSRm1zNjMvMktEcDdzQnBIckFqMkFOQi9wdkQ0VDZTa2JiMUdH?=
 =?utf-8?B?R0I4aTUzNmZNLzFrV1NDRGttVzd0aHBrYkpmNGpIdm0xcUFZNEtuT2xrSDFG?=
 =?utf-8?B?bXFVUlA2MmZQTmpEdkVLK1pNNVJIeWRuRnR2TmROdld3UWZJcWJ1c0YyRVBu?=
 =?utf-8?B?SUJoWElBZ3AxQkpoQkN1am5FZGFZalJBdm9Nemc3aGhNNkRsNno2WUY4UzNz?=
 =?utf-8?B?Ly83Vkdpd0t5MTFoRHZXSjZhM2hrRGdoVDE1YjlGTWVKWFBJQlE2VUpaYmd5?=
 =?utf-8?B?YUhwUmJyV2FlZ3JWbWhzWTFQbC9lOXVGWlRzcVAvWHNJQjM2MG52cmczT0Er?=
 =?utf-8?B?R1BpclBzVXNkRmZaY1pRRG5BV292N1lUelpWZ3NzSTFVWS9vQUlXNlFQNGF5?=
 =?utf-8?B?ZnQ0bjdhM2luQTJGUkdSS1dKNzd6ZXFaWkZhbCtWWGkwTG1EeTNTd3JHZXVH?=
 =?utf-8?B?Z25BdFpGeVJ1M2pLSnFxUERIeVRFNEVPbUxEM215UEtXcGYwU3dWVmtrZXBr?=
 =?utf-8?B?ZFJCaFdpV1JtMGx5THJYOG1wcERxNS95SWtwbysyeDdTR1lnRXFFbE1aRDRk?=
 =?utf-8?B?Nm1FaVZvMkJSODBzZHoyWTdzMW5RYW9GOUFXR3lqaTRZUFVWdkZBUksvUW5X?=
 =?utf-8?B?ZmhETGNRTEZlZ3dUcnl2djFNTFdYTUdBQ0g3eVhRK3E1c3Q1R3NqUHM2V2NT?=
 =?utf-8?B?MkIzMUZhUXFHTXR3b1F4RXAvT1pZTmJoeTBQZFpQTnM3dGZRZnJuaDFiY0tO?=
 =?utf-8?B?d3FtcjZ3U3dpWWtkWHpTcFVWeVFRZjVaYXRKbVlSclkrUTUzWmYxUHB6RmdL?=
 =?utf-8?B?aW5vNE5yTmhXQTc2clUvTTNBVXZldllDU1JlbkU4cnlqdXg5U2VBUXJXc2xP?=
 =?utf-8?B?byt5enhVNTJJSXU1OUlhV2pxYmtzb3ZXQ28rQUEzOWFhM3FjNVppR2dkMUEz?=
 =?utf-8?B?alRUdU1FNFc5eWV3Rjk2M2Q3Y0R0Tm9odzBjWHl1MGRMbUNDT0RaOEQ1eHNL?=
 =?utf-8?B?blI2dUw3c25wenBPYTBaS2pFc1BFN1FrTXZmbUQveVJBb0lZSmt0TFdWVS9P?=
 =?utf-8?B?ckJEYURLckFtVWVHczc5dlAzcmQ3bDlDcEVCZ0JLaFBsS2w3b3Z0SWViVWNo?=
 =?utf-8?B?OGRNTy8xb2pOQmJ3TTdCNW9ZUnRKakhBaEx5QVpJN3JyUkRjUTRkbnRjUmVD?=
 =?utf-8?B?ek1qMXNEMGhHejN0ME45V1FTUzBYVjkreGR1d0ViaXdtTGU1cGM3QUdnTGs0?=
 =?utf-8?B?dHRLNHNXb2pBTFY1NDFpTGR4UzRKYjhJSjYxSXFVa3ZhN3NCZGFiSEtmQzVQ?=
 =?utf-8?B?blhVUUo1ZHRWeWJLenFrejV1UnJkdXBESGdEclFhd0xKZ0RaZnQzeG9GNVJO?=
 =?utf-8?B?RFJnUlFHazZ3Z1lRZVEwamVhbFplTlYvZitiT3JBajloQndyYnhFT2Y0dTY3?=
 =?utf-8?B?QUlDTWJVR0thcDdDSERyNTNsTGNKL0prenFoaFpLeGo2UnZ3bXpRYnlCaWxj?=
 =?utf-8?B?Q1BtelRkaDB5WldRaXR6V0t0WWVMVit2UHpRQ1JKamtSU3ljZkJPdHFEVmRR?=
 =?utf-8?B?MDNTTkJuNVVIejIzQUJBQmZJRFFYVmZxSTgyUjhNYjQwTTZQWDdhakZ4V2t3?=
 =?utf-8?B?TDhlMWVzRnUrekxDT2RFVGh3dWVCd2dQb2o3dmZEcmd6bm12elF5N2ZLSUR6?=
 =?utf-8?B?dUp2R2o1dzFQZVk3aENSVk95aDdNb25lMUpjY3k3SmVyMUdqcGRDM2xtTHl5?=
 =?utf-8?B?Mi9mNUhQYjRXbjA2enZUUUdrcXhNaEJRUUdoUFEyblBzSkdDZ1VTMmlIT3VE?=
 =?utf-8?B?L3htaDd0azY1MFpFQXB2akxLd2Y2R2J1cHEveFFYaFVOSHNScEl1Um1EK2tM?=
 =?utf-8?B?U0JaN2RndTdBSDF5aDFNVS9RTjI0cUV3bitLREJDbkJXTk42SFBlM0ExQmt1?=
 =?utf-8?B?eDA0Ukc4akljbEtOVHRRL3pTTnFOWFBGNUtpdFJUemdOdEp4SXUzYk1NU3lO?=
 =?utf-8?B?THYzZ3FNdHdiMUUyTlN3RVZWRFlRMEFzb0FGSWJTYlRHUjVDNVNVc0MrZkVl?=
 =?utf-8?B?SFZxS3JQYU5jOWtLV3h6d3VSVm02cXFmMlhjNStSc2lXNUZjMWxTMFRZRFNV?=
 =?utf-8?B?eXF0NUFzc1EveWFJMHpqZlRYWEV1dUdoSTZvTnpWZTNNeGtkYTZuaG5OQ1M1?=
 =?utf-8?Q?zbIgkxa+WXTuURNIbR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ca2a5d-1649-4388-1206-08deb9af7278
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 16:13:52.6409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBIiBgLfeHvwmCjJtzj7xagCAT2aOb0ubYiuNgG/qVRR+wAnmxiHSmgb3H0fDDVlm8vgMMPx9NQfOCBR48ECNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7340
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291212-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,post.pl:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 135BD5C316D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 23, 2026 at 12:38:10PM +0200, Fernando Fernandez Mancera wrote:
> When a router temporarily deprecates an IPv6 prefix (either by sending a
> Router Advertisement with Preferred Lifetime = 0 or by letting the
> lifetime expire) and later restores it, the kernel permanently loses its
> ability to generate temporary privacy addresses (RFC 8981) for that
> prefix.
> 
> This happens because the address worker attempts to generate a
> replacement temporary address when the current one nears expiration. As
> the base prefix is deprecated already, the generation fails after
> marking the temporary address as already having spawned a replacement
> (ifp->regen_count++).
> 
> When the router eventually restores the prefix, the temporary address
> becomes active again. However, once it naturally expires, the address
> worker sees this temporary address already tried to generate one and
> skips the regeneration.
> 
> Fix the issue by resetting the regen_count check of the latest temp
> address generated for the prefix updated by the incoming RA.
> 
> Reported-by: Łukasz Stelmach <steelman@post.pl>
> Closes: https://lore.kernel.org/netdev/87340td30q.fsf%25steelman@post.pl/
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

