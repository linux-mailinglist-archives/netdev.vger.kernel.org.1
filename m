Return-Path: <netdev+bounces-278330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPJ0Mof23WlolgkAu9opvQ
	(envelope-from <netdev+bounces-278330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:10:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E65A83F6F90
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FC10303F7FD
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 08:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B968F3876DA;
	Tue, 14 Apr 2026 08:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NmRQ9hC2"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AD51DA23
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 08:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776153930; cv=fail; b=kHqDRgn8DaNLyXt3+wtNWXWM+peXI3GmQTROQJaGv2JH61kbpbhAZfY5gbmraG3/hlIpWpkw746KEu57mgMqm3px/H4NeM0hWgG/keU7My5QuXob2j6uW2iPi+mZbCI9+qFvasVLgBrgSzM3DJUGw0e5ThjpvnO1k+XnvJ8Nf4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776153930; c=relaxed/simple;
	bh=jq3648GC3PhRnWP4Ynx6Lhh8TvH8QbIf9TGIv/y58/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Keb/R3+Vip2t3+Mz85E7hQgzP7GZWXRXH3F3KfzjG2w5irYwBg0zAJPn4SqZ4C2sSweXCKE/Oy0BSvnEPFtZ3pMC3T3m+tYb87cqHknGQmtNnnwMt9M3Lbgp72xiCDcJ1JcAiQbpJ4N6HZ8RVr+V7TxM7mFIWIdEds/ydmI9aI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NmRQ9hC2; arc=fail smtp.client-ip=52.101.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQSxFr7Ld4Xcl2yb9BV6QRUXMzzY4u8wYMOTHu4E0WJsSqzkkKgR3u3RU9gtD74C748gZLHmbpMqLbJNA9lQSxjuXMpLi4hOg57HSi+GnJN2vLbjR5U4eYvzkMUfoFnhctCFkde6p0dDK2Ij8ozwXUrfwjSGgVj4PR1uaMME3xfi3CfQDJJzvtBpAEg0y+Mkob7GF7RUvUwqrcyJIe3BXLb+GAyC0o3JrrkOjEzp6O4i4BgDgIQbgO0763BMslJ+8nyztLsojEL/Xyn9Tigj7otkLo0JlNeKH0UiDhXsCHZ46XuD0CcBuqukRKFl8kRAiXatpDU/inIcEfX4r8v8ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WFjyGsZIm/3KH6EwbeN4pozDTuM3lpvz7iiQfLTQ/Y=;
 b=eBS2Wp4c6ee02yw0idpKTAcBIUuXii5ArsIERBwpgcUhomH2tQyt3BnGq/+6EqZP1j7AIArM+PpRXYRWmf3qKEa8q4rtHdhfPesdNUMXu7ddqHnGuONn5mQ5hTOqZtEUzqJBNIt4fXjTvfG+evX/pWU1qPElr48MWVJRPAJ6NslNY/28eOxt8LrkQJW40fPmHOhSfpNK6y7VtrpP/k+JCZ4X7r0BbbJTbFa1XncfWG/2SqQprECWwBIlQWYS8YxWWiaXxZuxLh9X7CcBsmUnHFREUkK2g17j9ebcv3/l2eDX1hnT+WOf1Slv/xoe5XctSVP+s7RGYgIu9C55fcblTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WFjyGsZIm/3KH6EwbeN4pozDTuM3lpvz7iiQfLTQ/Y=;
 b=NmRQ9hC21MeiXqjEl8kVbzwxHsoRLT9ng6tuV3cC8VtDh6uo4+OGTuWGcbePpokCnSkCIqN7BNHoSCAjzOsaBpvbi4SwuEII2lU+uzesRisJKAJ8FQwVyWRSXoYYwgEitk9Pg+uSs1bHwCXifX1BoCFIx5GBIbTJLM7VAQ4fW+Ut2kLfU/9EY4MUn7AcfDGmGllNeD1spP51SamfT4mkWN5Jrhz6A5ARdB97GjJ3mqd0GBiLAR6N6X8zXKjcTzZ/GioxsDv05TwAhM4uWEMGMTmtD2rNMud7nkYpk1LC+s9tq19qKm6jtjsYmHOOqaeiRqSCHF1mpCiI2E43Gctr1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BL1PR12MB5707.namprd12.prod.outlook.com (2603:10b6:208:386::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 08:05:25 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 08:05:24 +0000
Date: Tue, 14 Apr 2026 11:05:14 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org, razor@blackwall.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, makita.toshiaki@lab.ntt.co.jp,
	vyasevic@redhat.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
	yuantan098@gmail.com, bird@lzu.edu.cn, enjou1224z@gmail.com,
	zcliangcn@gmail.com
Subject: Re: [PATCH net 1/1] net: bridge: use a stable FDB dst snapshot in
 RCU readers
Message-ID: <20260414074722.GA321402@shredder>
References: <cover.1776043229.git.zcliangcn@gmail.com>
 <6570fabb85ecadb8baaf019efe856f407711c7b9.1776043229.git.zcliangcn@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6570fabb85ecadb8baaf019efe856f407711c7b9.1776043229.git.zcliangcn@gmail.com>
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BL1PR12MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: fad5f4b4-a7ae-41ec-5587-08de99fc9514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0DhECPObE6v8pkQDtuSyd/OYLK9DQdtRyFcpSX4ZOrev6/DUTljFTAa8ZDSmIFFTOZ1CoJRspcWeWTSZl9D7v7cXUh+P22PvFpLy4Fm4lYiaE2MkVl55aUqFXpARFEOf2fjMGjRD1cUr7QA5F0VkKwB8O5AB/N1MSZmRisC1wx0xMc6gR1XlRAd7o/PKeAVxzW0RunulYzJAKzth/YN0m01VkXQB43SQTy6DZdd+duP4i8vTbVn6rQSLDRAJnccxK9t2CR1zcAMm9Xi3hycSXO8x3x2L2SQlRc13LmsdK6wU0b669E3HuKQiK03cWwv7TEjnglWTj4hPlHQQdI+GKfYrvuH5qtsg8FZ+md2Bpjc2jMnvol2LDuknxcChkcBYI4YuD9lnUFa88UxQaeCE2KKPFuewHDEi+dVSD58tzep2+yHgowPs9j0C6yh5yewpowy+kVumqChwYTsRma/SnwnjPffibi6MICaa784nWhAnOJSpxk6LpHD31Sr2/1AE8HkhnznPMu46YQULCILYp2jskNcTRQExuSbv4nyoTfgAqq0UF/TZXgg9PQJxKsLN0gJJwtyOYkAGdEddTA1X5hGjoU8MoVOZmwofIdqM2oRz+/gx7Kwcu8/vjLuHcKpWxeRB7VYPRiVyapSHGIq318hEKGMjMtXiLWdb28HLWSdSW+dy6YSaao0NqAeH1ZyM/uQLxaKiMrtY/goVg7GdXGl+YcoBqie4Ph8QeoOH5hY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sTpOoqwZ/gKJU1J8Xm/c2Qg1kDSD2ymz3fsMpeqh1UbjEc9io6/cho8TRUKy?=
 =?us-ascii?Q?d5KOU9S8s3ipRNnQK9QcdPNrau+xqPbB1tyei3NOGUsKxiXf2wtRa4nS9WP4?=
 =?us-ascii?Q?rtJJUizKzUMw62NYkkKjhQuJQcGD5EDuOIoUaZsCfzdzXTmQjwUYheAcN9+L?=
 =?us-ascii?Q?9bygX7htKEPAARjtLl64vgDYUcZI5pyWEtyMCADHE3ywbY6q1a9fBjB+qzPz?=
 =?us-ascii?Q?7E+8cJWrVTlz0MV6o9cQfwiyoDJs5mWWh6fXRCQxIiMBXBkm3Ls+2KVmvJC4?=
 =?us-ascii?Q?Q2eQxe/0aO4SaA4rodQ6Yngk2L7I6Zgr09pYb3397mg1bbaGNd/hYGuENzIf?=
 =?us-ascii?Q?5w2o3iqGRc+hSdChQM5hb0E421ihNg5lbgp72t9iE/rcvYBNUREW4ej7OWWT?=
 =?us-ascii?Q?JcnCV+/1I45SbrvbwoLXqftvW32R3WSToUI8T1HDlg3rbqPGvJ2Pndd8nLLb?=
 =?us-ascii?Q?JIR8d8cVVv0EUs1dJqbTgCzlVFiT6Fol0kVgnRFpeFk+JFKkdgi1XR66oudo?=
 =?us-ascii?Q?+/w9hQbzs7aJnrTf/mUUSVLtup/9aOYrBzJo2nbbS5fI8cqsyXWJmC2LHJ+L?=
 =?us-ascii?Q?qWJIHsxM1y1T8I9GPRpvQ8gTuIOodNepKsh5YYU+VSe6IXl+rpy/+E3HOEmW?=
 =?us-ascii?Q?I2BlSqZPpQmvg/GrsgP3IttHrkl6Zr+TCNQKbA5+Bir+6wFFlctmG88aorFH?=
 =?us-ascii?Q?GIXTqPRoWXmFsUAxcUIgMyzFGLFHWlx5s6acWRunUSj1yvMCArWUAurfQh3C?=
 =?us-ascii?Q?W87vu5mYt7RoMT9vSyqaqoqvne9FEY3QAs0jGMKplQxXhBXacHhVWF+m0L+N?=
 =?us-ascii?Q?et5SFMp0Znkqs94I3S/V2EGvsBEOOBm03p+GPq1Ra1Pmn5kkEmB8K8DgGDSc?=
 =?us-ascii?Q?PXJH43MtqQUzPQtnb92Q3RWXbquzUgFyK1xpQLrw6ZMOrFzzJLYtnrJ0tMpg?=
 =?us-ascii?Q?i/RPiC6dCFjFQ9EpDhGoKn73wIldM1jwVdRvo6xcLFPJuD8X5zBilNFMYeYd?=
 =?us-ascii?Q?qG2/3Cg5+W5iXK9cnJgo8zXWOXu2CTGNVpvG3EWm+EvCewYko6S+F1OgD0ZC?=
 =?us-ascii?Q?y5n6vneHMAYeeTNqRllNYfMkVkInwVj9qCxquWRjhGHeiQx0ZwbjLp4bv8bK?=
 =?us-ascii?Q?VM4rH7/A3w0OWuf2y0oMxahHXU/AawgQcw1aKDTOom/hV/54SHeJD8U6CcTF?=
 =?us-ascii?Q?xrHPWVrEu44G5Y+CPntsWdtE5r8NVKDTj97OHc8cnViChFvEFQyqzlIhsybk?=
 =?us-ascii?Q?A3QxGoi8IrhJJ9KfyDJFCcs0aug4j3yf7BrlfSWBxoqqCar+nOWY3XCUh/2R?=
 =?us-ascii?Q?gy8mmFFTKl/qf+8vycSYiFTBLE0j3Gb1TIGMlNq8xxqnjAco8cyLqqh37HfT?=
 =?us-ascii?Q?U6Odlc2P8VhLaTDRwT97dk/VX80N63zotiT810thY2LmxI1Ok++IMWqf16ha?=
 =?us-ascii?Q?UhLpY8uTLmDaLScoSqfnfRiNYKfXP9NtjIAdiUEiMEEPJBSlWwjHEKKZWz/d?=
 =?us-ascii?Q?eAEi2w2m1QxKnM2P/fzm3CgS8ngTacSoMEaT6MzRlOWQ7PsQbF+p1oakARAu?=
 =?us-ascii?Q?WugCyG4cHEuo20YBCf6WY00aroEhE3dveaT64YJsDd6YuvKC4jOkhY+045zw?=
 =?us-ascii?Q?FxTRM6xXyshtHwSptZDqn+Dnxm6TPqUMcLnuphIa8SIGmR6tG9gr6k+RylLw?=
 =?us-ascii?Q?5BydeCvCXqEcHuzxLJdrvxqd6TzSOQxd+uVA2akGqJJbsgYeXLpDnBeLNySF?=
 =?us-ascii?Q?Ke3P/ehl9w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad5f4b4-a7ae-41ec-5587-08de99fc9514
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 08:05:24.6807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzO1UBN0+xFgW+Nzd56X8SIReigS+7yGYkCWEXUXdRZUzvj5ItZ/GMNBxm7fcFhrPfvpBii6HZM1FRxRO40SVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5707
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278330-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,davemloft.net,google.com,kernel.org,redhat.com,lab.ntt.co.jp,gmail.com,lzu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E65A83F6F90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 05:08:46PM +0800, Ren Wei wrote:
> From: Zhengchuan Liang <zcliangcn@gmail.com>
> 
> Local FDB entries can be rewritten in place by `fdb_delete_local()`, which
> updates `f->dst` to another port or to `NULL` while keeping the entry
> alive. Several bridge RCU readers inspect `f->dst`, including
> `br_fdb_fillbuf()` through the `brforward_read()` sysfs path.
> 
> These readers currently load `f->dst` multiple times and can therefore
> observe inconsistent values across the check and later dereference.
> In `br_fdb_fillbuf()`, this means a concurrent local-FDB update can change
> `f->dst` after the NULL check and before the `port_no` dereference,
> leading to a NULL-ptr-deref.
> 
> Fix this by taking a single `READ_ONCE()` snapshot of `f->dst` in each
> affected RCU reader and using that snapshot for the rest of the access
> sequence. Also publish the in-place `f->dst` updates in `fdb_delete_local()`
> with `WRITE_ONCE()` so the readers and writer use matching access patterns.

Sashiko is complaining [1] about missing READ_ONCE() annotations in some
places, but I can handle them in net-next in a similar fashion to commit
3e19ae7c6fd6 ("net: bridge: use READ_ONCE() and WRITE_ONCE() compiler
barriers for fdb->dst").

It's also complaining [2] about a not very interesting possible bug in
br_fdb_dump() which is pre-existing.

> 
> Fixes: 960b589f86c7 ("bridge: Properly check if local fdb entry can be deleted in br_fdb_change_mac_address")
> Cc: stable@kernel.org
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Tested-by: Ren Wei <enjou1224z@gmail.com>
> Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

[1]
"
Are there other RCU readers that still need this protection?

For instance, in br_dev_xmit(), br_fdb_find_rcu() returns a local FDB entry
which is then passed to br_forward(). If a concurrent fdb_delete_local()
sets the entry's dst to NULL, could this cause a NULL pointer dereference if
br_forward() is inlined and the compiler emits multiple loads?

Similarly, br_handle_frame_finish() appears to perform an unmarked read of
dst->dst, which might race with br_fdb_update().

Also, in br_fdb_delete_by_port(), f->dst is read directly without
READ_ONCE(). While called under br->hash_lock, the br_fdb_update()
fast path updates f->dst locklessly. Could this trigger KCSAN warnings due
to an unmarked data race?
"

[2]
"
Does passing f to fdb_fill_info() allow a concurrent update to change
the destination port after the filtering check?

fdb_fill_info() executes a new READ_ONCE(fdb->dst). If f->dst changes
between the filter_dev check above and the call to fdb_fill_info(), the
dumped entry might claim to be on a device that doesn't match the requested
filter_dev.

Should fdb_fill_info() be updated to accept the dst snapshot instead?
"

