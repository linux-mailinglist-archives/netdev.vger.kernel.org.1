Return-Path: <netdev+bounces-306172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QazKCuCCT2rJiQIAu9opvQ
	(envelope-from <netdev+bounces-306172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 13:15:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C80D7301F7
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 13:15:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=Nvidia.com header.s=selector2 header.b=I2sxC+Tv;
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=nvidia.com (policy=reject);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306172-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306172-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9F46F300602B
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 10:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B8B3F44CB;
	Thu,  9 Jul 2026 10:23:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011060.outbound.protection.outlook.com [40.107.208.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791123AFB1B
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 10:23:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783592584; cv=fail; b=uYTThDWs0Bi0aOb/ZaZnsYoVqdJqSQpwyKwYW8cJPigXHYf9xwmmB+JpLZI7U0j7+5EndwHcVdWP/c/us8eOs7rTiL6J8HGntE759NyaoIkreJoKCTPnzhsfvW+I/pNSmTkpYMOchc1SHnlDnQ0Xod1PLCr9lc86EtSP69q3twU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783592584; c=relaxed/simple;
	bh=Z4i755tCzHcrPxwXX8vg0rMKRxmAX6jlbxIfGOenqJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZsLPd+KVh2gZb3uCg6OzcQ56fgZGd7tlq7ixU1HjO6ckT5+WA7abcfS5XoH8vviyYAhmbRgeIb7wLHVcAQWRF2SbzsPt5hucGTnU5CIl1OZ6T/FvcBrP13mRmGV814BEJ/LRnvh0Q4K5UyxuSTkMYjRb5BSaB91uWAZPTr4IhZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I2sxC+Tv reason="signature verification failed"; arc=fail smtp.client-ip=40.107.208.60
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ts+1ZF/rVCdMFu65kNMpOtKOjm/8Xxsbt423lpxb2KMjyINPN3+RkRj1oV7ocx4KCm3zjfAA8EiHSj/QSrCV6BHhm276KDjK3S6veXjO5KlTTfYuJuuYj61F5bGi5hwpiQELxSm3SmaM+Gwdd4nhK8vo1BbcN/DTl4O86Fwkdp64FsIkVsXv1zgCzwzlvLIWeEsNy2RusFbsNzT678FKfZG84sZlGSK1c005eRu6Ulk0NkjnaNrKjM6iLiDIXYwevLfl4c6/eIjMndPY1ymn/jov9Wl/LyYM+lQt40HrmMm43tJYE6VnwlQsMvbNtPWt9cczvicK3FPuUWpQ576r6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1L8P/4dgonUAU2RoX5MZPnfyrhQ7juC3DmrIaU4YyAA=;
 b=lfwNWAEeHpNhNS0B0KpssR+xEs61gygEdyhVwW6Ye2xb+ATkPy7JOYhidZhVZaBVtMne0DFdko8dXKELWRCd1YLSd3MTqxFJn9ObSOLWML47x21u9Ne3QOrBynF7fNHEwq2n1edvW1JJqauwWqSZ+TFvn+Bq1FB7hhSNOfT812jD4L+JMxSAFBYViHizHtxdU+rZhK0UWXAqVlv7SNYfoxyAsKSkRdKHR1oxhLjNOFdX1+I7Q6W7gjXvi6QZl0ELVoqpBmiaXVqahOkyl3AteUOuGKQ7IfYmbJzxHM6qDl//C2n9IxZlTHjDZvudfv08LykbToJChh8VyvlIK7J3Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1L8P/4dgonUAU2RoX5MZPnfyrhQ7juC3DmrIaU4YyAA=;
 b=I2sxC+Tvaa+YP1fUe54QfczQOmRWU3GagXbJrhr/dF+Bw2fLJ8i/cb6LCMVevK0rE0IrwObk+fS5VVWqeBxp6LBZ03qOwysmeW6xg5RJpRGlsWQ4i8wCkLgDhf88OjPYFKTDJB0Y9S+K7d52KhaL2xEQGDBo+3n0RQe6imW0a3UCl4DK1CLuHZo9BlFNceT/fGPPai5ToXCdd8kvE7ueW+dsXTcnLhjN14FBQmY+9aLAnrAOcNYkJ+JWGOUktI6R17Uyc5snbiaq/t2aU5EtTV6qZCVumNWZaJtCeml4/4S54OmP+Yzmti71ecIiBYqgZlsDi1H4vRh8GykTdvhE8w==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB9323.namprd12.prod.outlook.com (2603:10b6:8:1b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 10:22:59 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0181.010; Thu, 9 Jul 2026
 10:22:59 +0000
Date: Thu, 9 Jul 2026 13:22:47 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jack Ma <jack4it@hotmail.com>
Cc: David Ahern <dsahern@kernel.org>, Roopa Prabhu <roopa@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: VXLAN FDB nexthop groups: per-nexthop UDP dst port / VNI
 feasibility
Message-ID: <20260709102247.GA1536940@shredder>
References: <BL3PR17MB60675DF2E8769ABDA85CCE74E5FF2@BL3PR17MB6067.namprd17.prod.outlook.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BL3PR17MB60675DF2E8769ABDA85CCE74E5FF2@BL3PR17MB6067.namprd17.prod.outlook.com>
X-ClientProxiedBy: FR4P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB9323:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ce109d-6144-4456-7fa2-08dedda40ca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|56012099006|5023799004|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	oK20DbfdLJwOBd2ojZQmhWPTJCngfXEBhovXupGztnbKHB+Fk5Yl/Ss4k+tM+vyelQ70CK2w7LDpwXy92fNZ5hrX/99IL5RibZL/2mT35Ec/qu8CNzkBerPI/F6vM8zlFfIIOBQQLrhqKMHLIAkphcqNbncXjaeRkZThVUbgQGWN/Hg6/VnTBE1jbg/UJ8Xh2Cfh1yRGWxyFG7QwzCw+mYv+X9a2yn12+8STZWxGkhkY6tPxvTac8ANZMpJLiglzpxHVKt90mTfvhY+lYhZq00U9SZgdfXGzw3GGyERxeZQh6BnAl8+tE8s0/5zbk4aYPm5Ju+dVeCl1NYmx2+2zvKfqiNjo51s3tn6hEbswZu9H0qlVisePMWYZKJwhMC3DAcQzg5ClaGRyt5+D6Vo5LbgWZNPdZTAOoulj7D1zpL+76L9FaXqoMmGePRmNnfRTCby3xq0eGnTkPzsQ4Fu/Bb52P60s6arsKvI+ZRbuVNhBoEz76X2G3DzRrvebv/a2mwQ7GPszQ2zEHObSRE4qzm7x4KmhLoilFwm5EWJHFwmIAV0Z5rD83Nw+XaELRlgVPbxSFRTyd1x555hXyQrrpNL2LUFAlp+CACeCuEilICUnhW8cklWbBUEWjPgegDhDp5Yadu/MDOG8E+ItSUdXNfw01e9MtxzqxZu7oyBciUk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?rLeWyDkcRTrNjCAzPiU56k5AAd2uOvZ06UzEJst3N3fnFD1TJ3pPSS7V0V?=
 =?iso-8859-1?Q?+iVGbDFnjhYcGjTnSVnv8Whw3kZ5o7N+W/SqFn9Ns8yBGGABDqRGNSKzNk?=
 =?iso-8859-1?Q?jCJVZIlUd6LMXQ+1GtMBmOSBfmQmeD+YPZrPYCkRB0yvhDrQc5WiZOY4Vu?=
 =?iso-8859-1?Q?hOF1gUrtFBjwILXUHWbBKivqbvD6WZOKRhezz/mLcbL31BEZWaWysu8OCe?=
 =?iso-8859-1?Q?1CTN6WeJBNJaqPi+Mbggl7N8h0KORGZmgltKQ5v2D1dktdFiM/q7Nerpsl?=
 =?iso-8859-1?Q?mcg3thCn9S8aaGPMLCbKoK+ume/3CLPQWd68GnCY1tNSIIX+RghjCBdAsu?=
 =?iso-8859-1?Q?wibtfdRZ2NYPuFX0k/zlkDgZoIut2Dp0QJrs/McfsaXcJpA7c7B7I0z27n?=
 =?iso-8859-1?Q?csLlbkqsAWMPhpQG/FVTjVi636UcTgSaJF+cKugiO7/EfhUkrjEjJPw5Pk?=
 =?iso-8859-1?Q?lnXCPy+3oNiYDtA9xKXqCaJG57m7iGav5d5zgbSO25JyctEoXw1j5O3I9w?=
 =?iso-8859-1?Q?8kCYBsj288gjBITeaOSEiokv0m9GvIAmPoCk5qgm+qkDIr6sIQLd3y3Gnq?=
 =?iso-8859-1?Q?9RG6lmz/MdmrpgMEvy+m1//QQcoCMBdA5a50rywz4fWie7GmexOyZYGYTw?=
 =?iso-8859-1?Q?52QoOO/MwnwYm5lfcdgEJ0g+9szKSp4a+TXRmN2J2ZUT9H7kzgoxU1aDgB?=
 =?iso-8859-1?Q?1p2aKMsnZxfMiZdVXo94CK8dId7UWTh8Z8CGIOYvnkhT5C0Eo1nFjEfuRu?=
 =?iso-8859-1?Q?m3/0nRUBEy2az2cX5SAaToxTtzMffZYr1zYcMaHAqkb1f5K3spn2TLUmHx?=
 =?iso-8859-1?Q?wt7OVywobNUwa4NUBU+NLgjNYLP1+e98YETu6rJBycRfzCscq+NCR23Y4p?=
 =?iso-8859-1?Q?JZpM6uTSO05s4Lt6Yasyy6i5d2C1zT1tPIRwfgKRccQBsUHGX6SIaWp4Q1?=
 =?iso-8859-1?Q?YeUuRqOWjesnqdmK59yHAIiIFfFNBGr4oKx0MkKocWDhOAqFh1Yms/PcR7?=
 =?iso-8859-1?Q?/dBdcgR+sqLUadz/wU8SsJbEdtvwb+0y0zEaU8jScy13n7K/kn2c6Nb2d0?=
 =?iso-8859-1?Q?yKzYgDqWOtZuGAKFvF5u5lyoxD+U9YQ6Bu0KVr1iUJi70de26snfgMXFAe?=
 =?iso-8859-1?Q?TG2lTcLzwaW6TkRvvSzLuRh5t/fAp1t9PDjV2zJtP00WOOOD2EGER0Ul3b?=
 =?iso-8859-1?Q?RDPM+Jri4Wn6DAH9s1m17xDDgu8eIbiZTuB0mmINHWXRtEGDTCb+GO5z95?=
 =?iso-8859-1?Q?oPhckDbo0cncsnm1wWGt3FJgecePg7RbVlWr7G31LJ9HPCuPm5f57iIg5N?=
 =?iso-8859-1?Q?t85sCc5s18+8bAAHUnc7ojrpmzdM5JyFfR0SxTu/5iUkccTWkdjJXaumuH?=
 =?iso-8859-1?Q?OFs/HRlT2jTJZSN7+S3yxyj2gBJX9/6Ti4p7J231AqNZvudradcHFPfq6n?=
 =?iso-8859-1?Q?mY2EAet1V41akDpNWcCMkQaNTZN5Fzwb1F/mUD9tP5J4OxAX5CEIPP9rjm?=
 =?iso-8859-1?Q?aiv9P0HUwc0/O+R6NDZINJ6TlByR3eCF93/yGouHNiE2hTmlCU+cwgiOux?=
 =?iso-8859-1?Q?dcK13gBFdDFeMrDZpuRCG1rOQ1L/PvGc3c969lq2GplU8Vg3Vx5IxrRaDX?=
 =?iso-8859-1?Q?Br9/iD8W9wQDs2xoFOTEoLWjWBXEPZSSg5hC5iaZC9L1sVWQrDotM2y04X?=
 =?iso-8859-1?Q?QoWkGOriXOL/T23RmHWtzWXj/kNzW+YpboNf+4Q5dKqA5F1XEk1ypp+JZ1?=
 =?iso-8859-1?Q?r6ii7qCV0p7VhGr7ZTo+yZNgwTW6aFHUiYT6NBWxuxQoW8At83YDvdpqKg?=
 =?iso-8859-1?Q?dO43IJHlqA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ce109d-6144-4456-7fa2-08dedda40ca1
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 10:22:59.3831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g3UHKgj1aZl5CRuoGfczlnCRyVQdYWL+yEEySQ9d/0Gs4AsVFT+rcxrzlDDVYVNHV9tgWSKNiPqsf2l4Fnfo7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9323
X-Rspamd-Action: no action
X-Spamd-Result: default: False [4.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jack4it@hotmail.com,m:dsahern@kernel.org,m:roopa@nvidia.com,m:netdev@vger.kernel.org,m:razor@blackwall.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306172-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[hotmail.com];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shredder:mid,ebpf.io:url,vger.kernel.org:from_smtp,nvidia.com:from_mime,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C80D7301F7

Please use plain text instead of HTML. Otherwise your emails won't make
it to the list.

On Wed, Jul 08, 2026 at 05:52:05AM +0000, Jack Ma wrote:
>    Hi David, Ido, Roopa,
>    I am using VXLAN FDB nexthop groups (ip nexthop add ... fdb, then
>    bridge fdb add ... nhid) to do L2 ECMP across a set of HA endpoints.
>    In my design each leg is a distinct (VTEP IP, UDP destination port)
>    pair: several endpoints live behind the same node IP and are
>    disambiguated by the VXLAN UDP destination port.
>    Reading the current code (v6.12), it looks like an FDB nexthop can
>    only carry a gateway IP, so a per-leg port cannot be expressed:
>      * vxlan_fdb_nh_path_select() copies only nhc_gw into the synthetic
>        rdst; remote_port and remote_vni stay zero
>        (include/net/vxlan.h).
>      * vxlan_xmit_one() then falls back to the device-wide port:
>        dst_port = rdst->remote_port ? rdst->remote_port
>                                     : vxlan->cfg.dst_port
>        (drivers/net/vxlan/vxlan_core.c).
>      * rtm_to_nh_config() rejects NHA_ENCAP and NHA_OIF on fdb nexthops
>        ("Fdb attribute can not be used with encap, oif or blackhole",
>        net/ipv4/nexthop.c).
>      * vxlan_fdb_parse() rejects NDA_PORT / NDA_VNI / NDA_IFINDEX when
>        NDA_NH_ID is present ("DST, VNI, ifindex and port are mutually
>        exclusive with NH_ID").
>    The original commits (38428d68719c "nexthop: support for fdb ecmp
>    nexthops" and 1274e1cc4226 "vxlan: ecmp support for mac fdb entries")
>    say "these nexthops only have ip", which matches the EVPN multihoming
>    use case where every VTEP in the segment shares one UDP destination
>    port.
>    My questions:
>      1. Was IP-only a deliberate scoping decision for the EVPN-MH use
>         case, or is there a deeper reason a per-nexthop UDP destination
>         port (and VNI) could not be carried on an fdb nexthop, for
>         example via NHA_ENCAP / lwtunnel, which route nexthops already
>         accept?

IP-only was specific for EVPN-MH and it simply reuses the gateway IP
that is already present in the nexthop structure.

>      2. If legs genuinely need distinct UDP destination ports, is the
>         per-remote rdst path (bridge fdb ... dst ... port ...) the
>         intended mechanism, with the understanding that it gives
>         head-end replication semantics rather than nexthop-object ECMP?

Yes, but you will get packet replication instead of load balancing,
which I believe is not what you want.

>      3. Would you be open in principle to a patch that lets an fdb
>         nexthop carry a per-nexthop dst port (and VNI)? If so I am happy
>         to prototype it as an RFC.

I have some questions for you before I answer yours.

Can you explain why different VTEPs need to share a single IP? With
different IPs you can simply reuse the existing FDB nexthops without any
changes.

In addition, why disambiguate by the VXLAN UDP destination port and not
VNI? Even if we allow attaching tunnel encapsulation to FDB nexthops via
NHA_ENCAP, there does not seem to be uAPI in place to encode the
destination port (see ip_tun_policy).

Assuming you can live with a fixed port, I think you can achieve what
you want with BPF and no kernel changes. You can call
bpf_skb_set_tunnel_key [1] from a TC bpf program attached to the egress
of the VXLAN device (configured in "external" mode) and have it encode
the relevant VTEP based on the calculated hash.

[1] https://docs.ebpf.io/linux/helper-function/bpf_skb_set_tunnel_key/

