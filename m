Return-Path: <netdev+bounces-280602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPpFIDSt6WnxhAIAu9opvQ
	(envelope-from <netdev+bounces-280602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 07:25:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 134D344D463
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 07:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E663D3008301
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 05:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FE735DA77;
	Thu, 23 Apr 2026 05:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="brGPwVEy"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013053.outbound.protection.outlook.com [40.107.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF093D994
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 05:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776921904; cv=fail; b=ZbtaDKWJ2QjDGahAL/6AkDoBKv1Jv+rLWo1JQ40UMkXF1dlZOGFKhwJpP/wFXUaASH+Rd7fdRLezmiVNti2xqM+JJbv/343PXPWd7rVb++KNBlS+x8LaScNKPiY5VfOYBuDTydc98hvtbbFueS+teCdmytwf4fhE6c6v1Td2g4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776921904; c=relaxed/simple;
	bh=nnRcSEZ5iZr43XfFZUZrjkKH27ONKp5W/3FYi1yBYSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C4MefswxplKdcBlj6mLmgH1QXMNss0u8konQiEugueuojDDnSbg8fKhu0RURN6PsEilN9JZ6flE+TluXHWs9BKXcOzi4DN06T8M2pL4ZJnMZH/SnGgLT5JCidZ5n208j6VBxxIMcGxq9Vr3uakZ4apjCGGt9KZzrGk3A4p3u2+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=brGPwVEy; arc=fail smtp.client-ip=40.107.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9uRq0yXujxFeVIIGDtty/NYp3d2No4Jd0GFprRDKrIMkJe7Ijo/O/bdQ6JCZY6zgHSIlNgF/TpLWfI64nISh6ONhxQOMy3ebwE1mwcR9lfR4cobBVwhd+G6CRQpArCQW3NoffFPUVPNCJYn3fbgxRkYJBVS1hYQhFVsKEYEh0Xj9bOnYx3JZC9eS9QqeiFsT3fP48GYZAos9VkliLRa6WktvrKiykI9qHVrMSkfzM/o1YCwixa+H9WJH2C3xIT7vCYkzeTCJlsMbSgs0FTYb/wsMtoUkQv2id1eLa/OKoqfd906l0GmRdFmounRXqmuJPhmX4+8+15SOewo14F7qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3nKwIry0XkyomKPHP5C0OzUt2Ggd4aiKkL4mCUV9R4=;
 b=IohCW+Z8kRY0++PwQje8+vYFSyk+sdU5tqHER1lP+47LPtT1utDd9ulZXcVRCe8u5WWeLLFtnYGXe3YNCLTIENSSO1RlJ8YU2nH3iBjePydTnEYzwNdUFIopiflzNCCf4s/dhwp+URh1dRIEgb7nMf95hU42V3fR14JtwQuEZs+y+fLLlBh0AcIjhWzmLYp45jjilzuS5gQDGyIdlEUeGiRCpHYG3+CQ0Mkm4jH9biKCbabAnDe+pwkSlLFIYf17+2o82CXcl3Hrd/X+1oj14RLxb7qB168kh0qVZrqxhrxmBl8EzUMRMTXzxRI4qG/cS2vITpkt55b1wnqrxJlPlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3nKwIry0XkyomKPHP5C0OzUt2Ggd4aiKkL4mCUV9R4=;
 b=brGPwVEy1RWy+ZCL3n9IUVljhmTZtZbS+9n8Ia8MeJGSD6jONvJsXbWJFBf6/2fLLOFzDrGD/PsBHCTTEuqIiJWZjdbc+o/SDYJSNgiuRrVJz3PV4D4r8g0nCUSP+qTgimgE9F+TdG3gxycgXEhMBYmmSvdlmU3WxUgoeJUSpL4XQi3EhC8HhDUgP//hIpoT2ZlmxE6fO+6UWrXonNXq+WtXIeithjkN7Cs0hS+Zt9y3K4mhcX6QYFuVYBYMMxlkhvKvBxSOZdZD2qObohJVb43wMr1Kyr5uuhbHjc9NBukYxv9vBvpWmzAsnHnryb6FrhOW4FHDSOd5ZoIp8gXvPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA1PR12MB6385.namprd12.prod.outlook.com (2603:10b6:208:38b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 23 Apr
 2026 05:24:55 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 05:24:55 +0000
Date: Thu, 23 Apr 2026 08:24:46 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, edumazet@google.com, dsahern@kernel.org,
	tom@herbertland.com, willemdebruijn.kernel@gmail.com,
	justin.iurman@gmail.com, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net v3] ipv6: Cap TLV scan in ip6_tnl_parse_tlv_enc_lim
Message-ID: <20260423052446.GA1179379@shredder>
References: <20260421202406.717885-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421202406.717885-1-daniel@iogearbox.net>
X-ClientProxiedBy: TL2P290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::9)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA1PR12MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dd404b0-f38d-4c01-e97b-08dea0f8a751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|11006099003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IeB/x6jMN+W+kvgoxtKWvYX4HaUeUUwfoUKulzfEXyJiQlOxw1cC24CDOQys7RtoRQabawsSrn561sgFbYFDjWy7rtdoPqw2aOfNTSPCbCQ+uZDO4x2OETQskI/CNmBG2zYL7/1sL4SWTMf/SEhM/fKEMQTKuqCNsGeQV66gFW7ORHIjG34n0ah93Ejxfmj79BWpctWhrS/xsLNwCL9nnwCiY+8ylfq/3qkLsrMrBj6zOyIu4Cc8JR263I8Emr5yUSTEW84cJmUSfmWJ0rcqnkHJPYPj4/ijbAnH9UM6zdIu3uM25GkkcfZVIkfae2a7Pj2rnKq+9ZND7TYbeb/kfimijCwakwM8fU8us+RzvvbBRRdgGgKBNob5Qv8ujp1EjsZTbKTWrbe5N1KFV8rlW8G3CSxJBp+EBO0I2VjLzIvob2isynprKLjTHMbbkRqkwAgENc6gwgSXEATAnls+Ng/gY/aTPr4IcePslYeQ75u8r5v08CNkhMwPo8hM7yRGg/yuusgSQjbNl+BEDQZv7BduEYDj7NWfnmJ+wfSFaJRm7sGFftJGdAcT3DN2iOO1LlhwU1crAP8nSn8U40TRa68yXE16XEVoCEp36xP8+/d7DhvT8sYs04zIRrF+QAqlwIIOBKKlehArH4E0/aNt7+afe7Yc0/zlQvuGwGPEL8wyT9UH9ZwHNY3K5HNoUJ9jJ2lI92oXfjhpRkQUiq2GwAGQ1vaJ7WYJFe3k7KBgbnc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(11006099003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ouR+zOc7E1Yw6C/v3vvO6et5/OKgruHKjbkPkCMuvU2bhsC/Kr1wRv1Oe7ij?=
 =?us-ascii?Q?t4f5tSDHwUgLnrkwWcimiRAnvVuc8NDMYZF16PoVk3tFfqmtfTD/aA0Mm2m/?=
 =?us-ascii?Q?8kDin3FoFw8TAj7KYVLKDDakglEBKplXMNYk4BpoB9NknvgIqyK/ZhkM1Iw1?=
 =?us-ascii?Q?eu0gHM0Djldrz2BDyBtO9gVV6pE9HTRGajWRC+56a3QqaWTXZz7b6Wm6IGsF?=
 =?us-ascii?Q?/SaiSSjUtdwfiTpczKu+QPsSkV50BnThV/+G5zopIS4DSXZSgC7zvmZHZ6Nf?=
 =?us-ascii?Q?efBeYZn/cXcjIDLt51Jt9Q1I0cvKUeNAzUk4czZPMXeQnqAY5PJ5tDT0AzN2?=
 =?us-ascii?Q?VC5+mXBWueXU+FFQUl3I6QAz06stO/dmnFxHahH1Z9JttLJBayoNj4y+c30g?=
 =?us-ascii?Q?twmPYNmjIjIzDXOWKAlazlGJgXUDOdlr02tvJE3azcWKHMDVlg+hXuNXfO6h?=
 =?us-ascii?Q?NOIJ/OD8bbJShy7+O1pWui5pvnX0BhzX6bQkUoxRMFO3pOJ0lG5ggzGcSbzN?=
 =?us-ascii?Q?whWUo9/JKeizUo2E7tzLaF6jwjVF7vmvulUUphZCVYwFIfGGzu+9kQz3ehWM?=
 =?us-ascii?Q?8KrXB1609lp8GElpzrttYCSJwBmJzVYgk423a3CF2aiEJN/S6ybaNtzfPmGK?=
 =?us-ascii?Q?vIrqL3v033PO7ap8GstKs0HVA4/Il9kR7NF06Jge+ia0L3jfuA4tAKg51pbb?=
 =?us-ascii?Q?ngMTHdm06tyqzBWIUNFYQ+EBerzGkwQgBDFTpGaO6V/UWNj6DiEsKzrU0dYT?=
 =?us-ascii?Q?B78S9iG0ftfSDs27DvnIN1sj1aqA+kIFNPqHJnHsNHgM0EgLnC7o09w0qCot?=
 =?us-ascii?Q?GATZpqdZ+dAfEZsW1MpYzb/lNob1MlDcDm4yDKvIl82BhLKL7KmV1c2TO+d5?=
 =?us-ascii?Q?LExxcjCAhjHYA7ZDD4dy9dM/7TpoS+adiGtPoutYTeH6ekLLbIbBzn/4tiuU?=
 =?us-ascii?Q?YbQ5iRsFlLob5PNswTdD29V6IDxNEdl2RscCRH2ZWxr2GiAnpxi1uGOiMtmn?=
 =?us-ascii?Q?kIB67eLIRJmcdWqi7thMf4OId616aqRr0dLadfbOVNot8ObeL1lNfHajFeoU?=
 =?us-ascii?Q?234+Vq9eqbIZN+5XVQCIknGJGmhk3OzvTOvFBuZ2sugZ7GWvDDBCFHbiud1t?=
 =?us-ascii?Q?jdBUoYoM9xUfxdkAOYv3Hv1qSyHfu8VLxTDFjNzk3VQgbPsqkIAWdJK1Pk4A?=
 =?us-ascii?Q?jeXJ3PA0BmNoxAiVREZHjMSUnGcA9Mp7nycV1J+glcuv/VdEyjT/7SeOUIDd?=
 =?us-ascii?Q?UfT+Cv6xUr3HNYy5JLVcZHSUL3QMHYycQSOoYGKxNQ7NfnH7iMnY534VRk/u?=
 =?us-ascii?Q?GsoVa3UcgMXQdwH0vaAACyS4FOwxcF7b8oqYzgU8Ft17//LHXT/uQXYXSrSg?=
 =?us-ascii?Q?Ag5Qdi4G0nlzyM62iOiU7KDaOMZkVdg0QhUdoX24u09j7p9dHHbOxh1QmlzY?=
 =?us-ascii?Q?/E80ZK6oxmunATu6q0vCgc42N6zzlQBxXj/3d7IeIILHRK7EfLPs8yTDdsmA?=
 =?us-ascii?Q?3YTV++GzQDxkbuOHx+sc8v+dXbGr0nKcykdUVIW97pHxg9QybO9O4C31o0W4?=
 =?us-ascii?Q?w2Vn65Foe68ecsBU3ydfTBzmLIc+bmr6b/xr9UtGX2f1n/2DaKXKl1ITj/4I?=
 =?us-ascii?Q?ZCofC+XQmwWdsBluWrooWlZkJeSyrkANLxyklsLM219vsxU3lojHjffO/xSe?=
 =?us-ascii?Q?GIBDO8tcq8GRSBtPemVLlODImzDr/7E3exy008pLrvwbmn+h?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd404b0-f38d-4c01-e97b-08dea0f8a751
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 05:24:55.5919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPfQCYGQKVd1MihV5yStVG0qm2XMHdBmWlql0CX7d53Vy+YI1H0LniCNnf6wkvgiuH5NEsw8sVj3LivKkYkm0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6385
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280602-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,herbertland.com,gmail.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: 134D344D463
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 10:24:06PM +0200, Daniel Borkmann wrote:
> Commit 47d3d7ac656a ("ipv6: Implement limits on Hop-by-Hop and
> Destination options") added net.ipv6.max_{hbh,dst}_opts_{cnt,len}
> and applied them in ip6_parse_tlv(), the generic TLV walker
> invoked from ipv6_destopt_rcv() and ipv6_parse_hopopts().
> 
> ip6_tnl_parse_tlv_enc_lim() does not go through ip6_parse_tlv();
> it has its own hand-rolled TLV scanner inside its NEXTHDR_DEST
> branch which looks for IPV6_TLV_TNL_ENCAP_LIMIT. That inner
> loop is bounded only by optlen, which can be up to 2048 bytes.
> Stuffing the Destination Options header with 2046 Pad1 (type=0)
> entries advances the scanner a single byte at a time, yielding
> ~2000 TLV iterations per extension header.
> 
> Reusing max_dst_opts_cnt to bound the TLV iterations, matching
> the semantics from 47d3d7ac656a, would require duplicating
> ip6_parse_tlv() to also validate Pad1/PadN payload. It would
> also mandate enforcing max_dst_opts_len, since otherwise an
> attacker shifts the axis to few options with a giant PadN and
> recovers the original DoS. Allowing up to 8 options before the
> tunnel encapsulation limit TLV is liberal enough; in practice
> encap limit is the first TLV. Thus, go with a hard-coded limit
> IP6_TUNNEL_MAX_DEST_TLVS (8).
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Given that you are targeting net and that the issue was always present,
I would use:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

