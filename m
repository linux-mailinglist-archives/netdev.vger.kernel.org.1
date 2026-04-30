Return-Path: <netdev+bounces-282655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNipKu7X8mnIugEAu9opvQ
	(envelope-from <netdev+bounces-282655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 06:17:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADD249D444
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 06:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D4523003303
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CDB278156;
	Thu, 30 Apr 2026 04:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="AOSY7x2g"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF3875809;
	Thu, 30 Apr 2026 04:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777522573; cv=none; b=WaNxt8JZ+UzeS7rKNErimky5lgZsVZSUVw6kq6NsoembqznUSkrSPh7O/sj6gsuNrTEOICwN14SxcZCnz8cExyIxjNonsjqg566Afgx7sh3oM+sfOv9Qpkb0JqGKcUKtYP2JJeBQrAY1U99LhUMfyxbNBAi/EoZxj9COjy7kRGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777522573; c=relaxed/simple;
	bh=jSyYsIQcu4TaDmrCODtyO7zsfwM6oS6URsKS5R+ials=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5LLTamh9q/VxkoOYw51N7Gn4C9ftyoRXTkb7u4gKX0y03k35A5Uy9ek37bkQeTtHxhPYWxLTMRFM2PrsXOur/kt9QBa5v0m49VuFzXVZhOBs+vsTS/H7UAgwxecU9YgiUVInOesYsQNBGNiVuV27K/HLviwSoliPXro4S2Y+Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=AOSY7x2g; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U18rZr4076526;
	Wed, 29 Apr 2026 21:15:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=Egfi6wVZUVARzGrQGjY9dXRho
	4raJ2Q0NEWYHbJeZps=; b=AOSY7x2g+EZ/14ySOixzLXGxeGDmzpNZwEWtyYlQA
	C4zZcQmQ+TYDsy7xhnY0SqpNKQv6Xg9+8UAdwLZ3gKaKQzLRY/+sAm10+L5X9sY8
	68HHIhoV6xc4tgxMjZR5xa4p2UVJrplchsvD8tHg31S4UDj1JoNPxUh6kNWSg9Dr
	c0FslHRUOKMU4nUU8p+KAhqgQXnfUhlpAvwDvWVhKtMYVqzj+HXvf/XnO7+VgqVC
	dVYBsJ2ikmFwEJw/rBJYS4GJqArEV9kEXdXtjPxcN8YGp/43bZcAwyZaOvacDrYb
	Gc/KCjbFX1Okl5Nb3mrqQfggflE5QUnZO/4FtcQmmvUbg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4du6r3c30b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 21:15:48 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 29 Apr 2026 21:15:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 29 Apr 2026 21:15:48 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 2D3933F7062;
	Wed, 29 Apr 2026 21:15:44 -0700 (PDT)
Date: Thu, 30 Apr 2026 09:45:44 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: Re: [PATCH v5 net 09/10] octeontx2-af: npc: cn20k: Tear down default
 MCAM rules explicitly on free
Message-ID: <afLXcOpeJB556CYg@rkannoth-OptiPlex-7090>
References: <20260429022722.1110289-1-rkannoth@marvell.com>
 <20260429022722.1110289-10-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260429022722.1110289-10-rkannoth@marvell.com>
X-Proofpoint-GUID: Ct9VffNEYfCMlPDSdp625rIiHd_ySt17
X-Proofpoint-ORIG-GUID: Ct9VffNEYfCMlPDSdp625rIiHd_ySt17
X-Authority-Analysis: v=2.4 cv=RKWD2Yi+ c=1 sm=1 tr=0 ts=69f2d774 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8
 a=wkDOlcWBEPNGzFRsfSsA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA0MCBTYWx0ZWRfX9b85DUTFd/J0
 qukniHEHAaUQ3RzwqogWmLtgekx/OsBwP9R3ol9cFBrUy3oc1Rtgb+lnvfhOGJqrDHtoIrE17fH
 +V/lChtxpqvme+nm/HCeJC2IrPg62U6bTwVhbpLV+Rmyxh0Z7TsIW97B1a8Rasx7Tvn53Vh8Jvn
 TbQcy4bOvIkwVznPmpaFzE2Cn5Rj58PIV1JnHp2vY4xB/dzWAgF9D+CHsdFIpuR4ySwJex5Yj9X
 1GSHBsNCQoOLyJba11UNim/QV9wy/QA5ky+fnTeQlwDIFp9MR4Ddzbub2eGwDcrM9QEjDP8WNtP
 YbADTLn9XTkJYPe7M+RxD2ex1Ox4bclOQ2nIgBLrNpzBcbjd3JNEISbt4JKi6xC+xEUJrXl/mN0
 +Y+lxRZEXXz/eBnv6I9wH549CmdCuAIRAUpXweuOK8jCUnnyfkBb2rFpHLP6AQZB4P6kBw22X9P
 xbl+UpprmM7UGHFzd5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Rspamd-Queue-Id: 0ADD249D444
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282655-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:dkim,marvell.com:email];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]

On 2026-04-29 at 07:57:21, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> npc_cn20k_dft_rules_free() used the NPC MCAM mbox "free all" path, which
> does not match how cn20k tracks default-rule MCAM slots indexes.
>
> Resolve the default-rule indices, then for each valid slot clear the bitmap
> entry, drop the PF/VF map, disable the MCAM line, clear the target
> function, and npc_cn20k_idx_free(). Remove any matching software mcam_rules
> nodes. On hard failure from idx_free, WARN and stop so the box stays up for
> analysis.
>
> In npc_mcam_free_all_entries(), prefetch the same default-rule indices and,
> on cn20k, skip bitmap clear and idx_free when the scanned entry is one of
> those reserved defaults (they are released by npc_cn20k_dft_rules_free).
>
> Fixes: 09d3b7a1403f ("octeontx2-af: npc: cn20k: Allocate default MCAM indexes")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Patch 9: [PATCH v5 net 09/10] octeontx2-af: npc: cn20k: Tear down default MCAM rules explicitly on free

>  free_rules:
> +	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
> +	if (blkaddr < 0)
> +		return;
>Can this lead to a resource leak if blkaddr < 0?
>The tracking entries are removed from xa_pf2dfl_rmap via xa_erase() earlier
>in the function, before validating the block address. If rvu_get_blkaddr()
>fails and returns early, the rules remain allocated but the tracking
>information is permanently lost.
This condition will never fail for NPC block. This condition is there because of legacy coding method where every function
has this check. We need to put an effort to remove all these check from all functions and should have only one check during probe time to
validate this. That should be a candidate for net-next.

> +	for (int i = 0; i < 4; i++) {
> +		if (ptr[i] == USHRT_MAX)
> +			continue;
>
> -	free_req.hdr.pcifunc = pcifunc;
> -	free_req.all = 1;
> -	rc = rvu_mbox_handler_npc_mcam_free_entry(rvu, &free_req, &rsp);
> -	if (rc)
> -		dev_err(rvu->dev,
> -			"%s: Error deleting default entries (pcifunc=%#x\n",
> -			__func__, pcifunc);
> +		mutex_lock(&mcam->lock);
> +		npc_mcam_clear_bit(mcam, ptr[i]);
> +		mcam->entry2pfvf_map[ptr[i]] = NPC_MCAM_INVALID_MAP;
> +		npc_cn20k_enable_mcam_entry(rvu, blkaddr, ptr[i], false);
> +		mcam->entry2target_pffunc[ptr[i]] = 0x0;
> +		mutex_unlock(&mcam->lock);
>Is it possible for another thread to allocate this index before the rules
>list is cleaned up?
>The mcam->lock is released immediately after npc_mcam_clear_bit() is called,
>which makes the index available in the software bitmap. If a concurrent
>thread allocates this same index and adds its own rule to mcam->mcam_rules,
>could the subsequent list_for_each_entry_safe() loop mistakenly delete and
>free the newly allocated rule?
No. These are allocated thru mbox messages and are processed serially by AF driver.
So multiple thread issue wont happen.

> +
> +		rc = npc_cn20k_idx_free(rvu, &ptr[i], 1);
> +		if (rc) {
> +			/* Non recoverable error. Let us WARN and return. Keep system alive to
> +			 * enable debugging
> +			 */
> +			WARN(1, "%s Error deleting default entries (pcifunc=%#x) mcam_idx=%u\n",
> +			     __func__, pcifunc, ptr[i]);
> +			return;
>Does returning here leak the mcam_rules entries?
>If npc_cn20k_idx_free() fails, the function returns early. This skips the
>trailing list deletion loop, permanently leaking the rule structures for the
>failed index and any previously successful indices. Additionally, because
>npc_mcam_clear_bit() was already called for these indices, they appear
>available in the software bitmap, meaning subsequent allocations might get an
>index while the old rule node is still dangling.
Yes. we need that state to debug the issue if it ever happens than freeing mcam rule entries, as mcam rule entries
debugfs provide more information to debug. so lets keep this way.

>  		}
> +
> +		/* Update entry2counter mapping */
> +		cntr = mcam->entry2cntr_map[index];
> +		if (cntr != NPC_MCAM_INVALID_MAP)
> +			npc_unmap_mcam_entry_and_cntr(rvu, mcam,
> +						      blkaddr, index,
> +						      cntr);
>Does this unintentionally disable default rules in hardware?
>The calls to npc_enable_mcam_entry(..., false) and
>npc_unmap_mcam_entry_and_cntr(...) now occur before the cn20k_dft_rl check
>and the if (!cn20k_dft_rl) block. If a VF resets its filters (e.g., via an
>all=1 free request), its default rules (like UCAST or BCAST) appear to be
>permanently disabled in hardware and their counters unmapped, which might
>cause the VF to lose network connectivity until completely reinitialized.
> +
> +		if (!is_cn20k(rvu->pdev) || cn20k_dft_rl)
> +			continue;
> +
> +		rc = npc_cn20k_idx_free(rvu, &index, 1);
> +		if (rc)
> +			dev_err(rvu->dev,
> +				"Failed to free mcam idx=%u pcifunc=%#x\n",
> +				index, pcifunc);
>  	}
>  }
VF has only UCAST rules.

