Return-Path: <netdev+bounces-286295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PGWEd2cAGoGLAEAu9opvQ
	(envelope-from <netdev+bounces-286295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 16:57:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4851504AB3
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 16:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A4B6300CC08
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 14:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B7439DBF4;
	Sun, 10 May 2026 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HVv68S+L"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011001.outbound.protection.outlook.com [40.107.208.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C34128395;
	Sun, 10 May 2026 14:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778424938; cv=fail; b=iPR0QRB0MBbMjbkKFXEEZKfRGe6ilqK1jlYdutJoz3tPuoWG9X/vCmD+PzIOQFfqKPAhn3/3FRMAx0i75Fk3MeFz/nYgBL4pArRVU2L3v+Ls4xUoXSreUyTzeR8gI9RbHSlPITUTBlA20SIOci8l1ppjkdDFjWGsEF+n7+O0hA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778424938; c=relaxed/simple;
	bh=lzD6n3Pz+5U0lgD+lv8WJHcpA0mfbEsFybpoDWzkN4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iP5DLN4wxEoeKmO85aJTvN0CHYoqmYELZQXlpC8NVkc16ncP2bOMrteWabN0vk8/+dha0mpAHbUnGanikUoporqiLAwAe7T0+sU/VcAQUC1Mk0briIR9xGdXDgWzrZMbYql8dZIwXIAJEFkwPB/XXCnRganmFO9+e3cPL0JJb3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HVv68S+L; arc=fail smtp.client-ip=40.107.208.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hW3uVvYvxJpPrghitLeY5roRawoQNhVW/E2u0c1r7Vk7gtGDXiuLbPttikAycdz1AusvWKnWvNcL95KdjqBnnd9ifGv37+kxI37qMCuO1j+0M4hNkiUkD2nXNhVm1fHFynFJnvLtbv0VAaDRmwNqMjockCcwW4UzjmDIANzvTOJp5YJlu1mD5pqVI6YGyzJsSX2ZHWrbbFi0zJ1tX4L3EJcyl0bD8ErFGScbq6CNHyHc3UaLcbxaOQqmfOx1yYkIkZjzhiXsmrXjzSEwy6z8dqoORuCmr+u/S9dbDLa7aLx6RXcCZ28zLUIJFoHAvMPJkqgvRRFpWjkUzLfJmN9htA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNI5bNeP3H/9eGGBRDAht93iXqDrv9ghHaHtbenzDj0=;
 b=AwJ1r9Vm/7Q3D+BWsCp6T9O5z8fLeTOREK2InOxY0KNzeGcscdujAGRt++6f6iUcOTKuyiRI9jen0IEEXuw6MPgBb5mnogAhlqKrS+0Kpb7NMjzBMPtYrnvUM+Yk879I1OMi50w4kq0MJyMCc3O5/WlK3QwFX8LOw5YJo14q8qTlcgjgo2tXO+QEL7FltUAIPbDjT6PfbAsGl2om1+W9U2lA3lunJ+SBbKoF989KjnGKjY0uGm4u1C1bKf8aEJCqFYvdKvdpoMFAbFCva/CDrKFxr4R8BbC1bLMKxvzuUyiSwMrlpddBzdAD0CChe0gs6SN7iGiNE/gpahD871bUcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNI5bNeP3H/9eGGBRDAht93iXqDrv9ghHaHtbenzDj0=;
 b=HVv68S+LVj0DXdlrYRoejzB1FDIF6qGhgGugSFWRx1WtNbD5FDC1bj1JJOXAFlEHC1v4YAcWjYdd8zMWmrleJm0bfLK8YAfa3VgzX7SoPyIIooeY5WmVcowbbxsjSr5NAQH0kSefIePnXRBMWXp9XhHPuLn0ZLCir3+zh8NYongEn1Eg5adrUyCec7gzo3z+Cdij/JBnPtgFjVuQHQD9v6fXskP2vD6xckgYBwcfRbOdiODudnPqkaerpQKG+KBVOLFNUojExuZ1EHQZgUi5lnbJWYAg03DZQvia4UDZtbBGv2uHM2Ya/9ojyMpecCTl/GEuVKX5Z/ANdv2YTm0bpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA1PR12MB7365.namprd12.prod.outlook.com (2603:10b6:806:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Sun, 10 May
 2026 14:55:33 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9891.021; Sun, 10 May 2026
 14:55:33 +0000
Date: Sun, 10 May 2026 17:55:22 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	horms@kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
	=?utf-8?Q?=C5=81ukasz?= Stelmach <steelman@post.pl>
Subject: Re: [PATCH 1/2 net v3] ipv6: addrconf: fix temp address generation
 after prefix deprecation
Message-ID: <20260510145522.GA98198@shredder>
References: <20260507132828.3923-1-fmancera@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507132828.3923-1-fmancera@suse.de>
X-ClientProxiedBy: FR4P281CA0335.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA1PR12MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: 32544910-2760-4cce-a8a3-08deaea42f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vYZ7aDaIcsf4CD/Au+MCfoQXxYgMNM2qNaZnyn+PLwRO8m29/PdE+2wLQIZMxOMY6SptC1CknZnSNGkIcJ6XWyFRJXf61JsybNm3b5tsHjpr26rd5wNuwNrLdVZf2M2zwR+rSuUfCU+TjUClAcM5QcQV2LwWUHKwvBki5BmfaqxhPK3DHiqChBYwSKTAlVVlbkTh0/FvV2IJ0W12jwHTvANLB30qTV6PlJr6E7jjihsqk8d62/0Z7u44gLFcMKrs6K+iUPMHs/lC1l2I5BB46Xbo1x1l0nqstUawbze7UYKYQ9RKakXCtdAstUtN5VvdoIDgoRF8Q8gIHTefUXk9RG4ys6xJlEi59jm1iBk80p6JO2W281gggeKsKQ56F1gDIrdH37xly31XszUYejQ5qMVOOhwpoROY17hYlc9f95XlzzefVqGOkNhTYGLbYNwuRQD6oitO0BF1ePwC8K3GB+KrW33XBkCf7INa+ltIiYzwyEtjhmwamqAQ2aNjExx8+LOK/zwQb8VNbpTImOfxiGtTzAUScbXnOCrCOznkCaPzu1LTJXlAgDmNjpHLhTnlJIVfrMVGur/qZybxt0NxSQ+WuHAm6Zpi+k+z4eIko4azmWcnSzI3dnnu1+YhUBST45pFYCv6TkXWYuPCK8cXwnEDMqnIO54N8kEGJ00hQjRjeOfyE3UYlYCu7dP9z3Kr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aAj1xvSQ9v9KuhUb4+b//HDcHI+TITWhJ7M6PBo0X5UXLDR/oyNUAQ7C3iss?=
 =?us-ascii?Q?BgTS+mhxGimAY4nMWCX3YyES3zGsvTTBtDSq9VAwgj4OjSswjIxN4xfZX8ZW?=
 =?us-ascii?Q?5B73iY5bTOSiqTSlR7N6ELeTovTHOXtbFwuP0MoJccHkh9zzs/VY6TOoo31q?=
 =?us-ascii?Q?kvKARac4xoQPWP/YCkFgUVXg40NyWwPlKFkQe9r3Ph5ASrfP6k9I2f4sXl1D?=
 =?us-ascii?Q?whve+p/ZK77+OYEGPq9866NBpq/2UdOPzvhL8/eEso+bLkdQYQtnEsOnrEnP?=
 =?us-ascii?Q?8R+Lk7wYBt5/JyLWiXvx/sg5EdPzbXDt0EU/lMGu8uB90ICdXLYiSpT9g087?=
 =?us-ascii?Q?HSMZsaX32R+PyxhcJivj52NMib71t8foh7Q0rL0EruOb+5GogBmhcJXkphr7?=
 =?us-ascii?Q?ae5s9oU1HHXJO5LHLh1wpk2ac/0NInBAcFSuCGAysvdj9gQNGsp5btvAkyY+?=
 =?us-ascii?Q?YlYapzriPxRbpUbBQNHEPLbzwUt82QYIylVyVSAeP/oYfa1Eofoomd9DT7Si?=
 =?us-ascii?Q?5Dxe06fUnbbul88SQHk1bymxuYTjh2qBxzCSUmRbQYuKN6HJpLQWh5z5bSdH?=
 =?us-ascii?Q?isevmt2JnCftNaYCwNVhGmWlzGRJ2VJKsUbR1+s2KLWBkIuT698U/zPi96t7?=
 =?us-ascii?Q?QG+QdI92PFgR4FvmV5Kpg9LYeN3RcZ7eEPpUkLniAUeSB024Sa3nefGdkIAY?=
 =?us-ascii?Q?E8yOiXC4Cchn9ArT6V1yHLesLnQXu0iIGRH7fmDrCNzsuPnNhiZLmMjJX7+1?=
 =?us-ascii?Q?t60+IM5VE06cnkeeWpLkT7N83/rlAg/CVbr9JZM52Uec9hNAdi/wM91rCQX2?=
 =?us-ascii?Q?u6F+kFBu/sTgCg3VdoMA8y/IkKnkPE7BWb+h6mF4b5qBwKSKR4+Wvu59Hvk8?=
 =?us-ascii?Q?acaNwhRT23EyofIncdGv1ZXdHVGCuLyyUsRvmJuJs8RTuQPKoyf33cKjkrzZ?=
 =?us-ascii?Q?GHJTNI18LAm+ZEuC0Wwi8bCjA1SiAb3IRAov+WVqptznaKIC7wnlo0QaO1WS?=
 =?us-ascii?Q?x0dWDgdva5pcbB3jz8TQITcxuUulRblXuLcshEAddY/DixvWixkZUCHvLZ8B?=
 =?us-ascii?Q?IfDsLUSprYFrGyI+SvSKv5HCvD8TGVVoGJv2F/ZINoLEqpa/9Ea2TndaVUei?=
 =?us-ascii?Q?4w8DWOVz2HJ+kYLW5q6dWb3SstpUif4C2pvmaxgDekCC57A79ANTSZ5KDiMU?=
 =?us-ascii?Q?7vTDzJHRI9ikImNdyOrS0WkEUijHzN24qWGRqa41//DKJf7wwFWiFiKs25Xz?=
 =?us-ascii?Q?gyemXusNztkOBu3ZlAJVh+7h41BCZZvviEPjpikFXRQdmiXx7BfQxC2hwBEF?=
 =?us-ascii?Q?xrVOD3yJtWy13spLV/ORPU+/RsTvmK7RLIidgdZfhQz2qyOL0jZU5zXLL/aH?=
 =?us-ascii?Q?rH7ybp/muet0zQtoQpg1zPDnKwT7ORUD0jTSkaLmMt1KRPw3Nn1LFDM7YpHw?=
 =?us-ascii?Q?rC/jDd71X6DPhTy5q5Q7slUev4cGr4aPFC6WhFoWEkUOLV1LmKSoSk3LOLCi?=
 =?us-ascii?Q?es8ryPdAZIu1RmmJ9lqiflCn/hPGIW99AdnsS0cWj+qbaIvdv4SvSUhFxV3l?=
 =?us-ascii?Q?qza9smfdekOlGn4a99vEZPGoaOu7wVqMK0L4f2XLAszjQvXdq+z1Mj5uvaB4?=
 =?us-ascii?Q?XToT0ESboTRm2HAhPWdNnkx14Wdeop2gPJQ6aM1c2X1I22BPYBlUa5zxejlD?=
 =?us-ascii?Q?xUZNRN17dSW6c/oPWL03gP/YreBO3h6H/296oxNNHnHIGCcB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32544910-2760-4cce-a8a3-08deaea42f6c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 14:55:32.9434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIAAwr+pW/0dFth7/sgR8IRls9DyOufhclU5Z4zJFGUdXiNpb1rKOx8NtxhKGUckem0ZZPA8oYSO91dKayYJng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7365
X-Rspamd-Queue-Id: E4851504AB3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286295-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 03:28:27PM +0200, Fernando Fernandez Mancera wrote:
> When a router temporarily deprecates an IPv6 prefix (either by sending a
> Router Advertisement with Preferred Lifetime = 0 or by letting the
> lifetime expire) and later restores it, the kernel permanently loses its
> ability to generate temporary privacy addresses (RFC 8981) for that
> prefix.
> 
> This happens because the address worker attempts to generate a
> replacement temporary address when the current one nears expiration. As
> the base prefix is deprecated already, the generation fails after
> marking the temporary address already having spawned a replacement
> (ifp->regen_count++).
> 
> When the router eventually restores the prefix, the temporary address
> becomes active again. However, once it naturally expires, the address
> worker sees this temporary address already tried to generate one and
> skips the regeneration.
> 
> Fix this by verifying that the base prefix has sufficient preferred
> lifetime remaining before attempting to generate a new temporary
> address. In addition, make ipv6_create_tempaddr() return meaningful
> error codes. This way, we can catch if a 0-lft RA arrived just after we
> passed the verification mentioned above. If we don't have sufficient
> preferred lifetime remaining, the worker will keep the next timer as it
> is.

I didn't go through all the Sashiko comments, but at least some of them
seem valid. I wonder if we can simplify this and do the following
instead:

When updating all the temporary addresses (f.e., because we received a
RA), instead of only creating a temporary address if none exist, also
create a temporary address if all the existing ones already regenerated
a temporary address, as otherwise no temporary address will ever be
created. Something like [1]. I didn't run it through Sashiko, but I did
confirm that your test fails without it and passes with it.

[1]
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 5476b6536eb7..3eaa583bb08d 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2597,6 +2597,7 @@ static void manage_tempaddrs(struct inet6_dev *idev,
 {
 	u32 flags;
 	struct inet6_ifaddr *ift;
+	bool all_regen = true;
 
 	read_lock_bh(&idev->lock);
 	/* update all temporary addresses in the list */
@@ -2637,6 +2638,8 @@ static void manage_tempaddrs(struct inet6_dev *idev,
 		ift->tstamp = now;
 		if (prefered_lft > 0)
 			ift->flags &= ~IFA_F_DEPRECATED;
+		if (!ift->regen_count)
+			all_regen = false;
 
 		spin_unlock(&ift->lock);
 		if (!(flags&IFA_F_TENTATIVE))
@@ -2644,12 +2647,14 @@ static void manage_tempaddrs(struct inet6_dev *idev,
 	}
 
 	/* Also create a temporary address if it's enabled but no temporary
-	 * address currently exists.
+	 * address currently exists or if all the temporary addresses already
+	 * regenerated an address.
 	 * However, we get called with valid_lft == 0, prefered_lft == 0, create == false
 	 * as part of cleanup (ie. deleting the mngtmpaddr).
 	 * We don't want that to result in creating a new temporary ip address.
 	 */
-	if (list_empty(&idev->tempaddr_list) && (valid_lft || prefered_lft))
+	if ((list_empty(&idev->tempaddr_list) || all_regen)
+	    && (valid_lft || prefered_lft))
 		create = true;
 
 	if (create && READ_ONCE(idev->cnf.use_tempaddr) > 0) {

