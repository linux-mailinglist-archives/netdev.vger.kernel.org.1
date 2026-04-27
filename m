Return-Path: <netdev+bounces-281217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFbwIh7e7mlhywAAu9opvQ
	(envelope-from <netdev+bounces-281217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 05:55:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B7A46CAA1
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 05:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 650AC300DF45
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 03:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A14366563;
	Mon, 27 Apr 2026 03:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="QKLk3+Ly"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B1938F620;
	Mon, 27 Apr 2026 03:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777262035; cv=none; b=oP7aXi9SAxH+5IjQEwcX6gZqRgYVmD8liUhVxwxeHHaDzYnOf9Zi9P+CYKHHeiKtEARXmvpxFSVgpvfj3cpleh2/PCwQl716ypFgS3Cq5+Gf+J1nNoc9BwOwqlBc2tCPJ1ELm9+dY03sq/QgZUNQD2KivQE56R4DbLBz4TRx+Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777262035; c=relaxed/simple;
	bh=BPBhLey554e/WhBNjX5WxpGqCo4cNR81hVEdfrHsqXI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DU7M66ev0AROfPcf9d4Cz5cIcYdTiCwItXHHGSNzjJusNmYI12+9+tOdKvtRAiATmdDM5S3qXFgPeTbW1x3IBOsu5LXBkoUpmVGPcqc/Bnjeot4+u7on33jDsqv83orRqW0ok2g6AnTpxNtLlR4WD3GPxAX96OZ9aPTQqkn25Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=QKLk3+Ly; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QNlXQJ2712746;
	Sun, 26 Apr 2026 20:53:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=SjPahOfIb7EJiaMDNC2PzXKjl
	Z59j9mizLGj8cCu6Xk=; b=QKLk3+Ly4h3m3Uwzu7R6C7VGWiSNHHwvRQG427k5m
	7w0hL+LrOixapzRSWBLWHCeXvmZ8+pYBpIMHhq/DYFuYakFNfFkQmeeb2dMT4eNQ
	NrRPILhwdd61DlhXJqjaDwot6+ft5l10kMktjVFTUCQ3OAvQbOJn5B5xukbcImFg
	jBpD1DBYYUYRFjO9Kf3NujZF4dlyXOvP92yETQ0rz22utyk8k3Gt8EATPYVupeI+
	haMiwYT/m/bOxheVy6Q7ZvADzreaXjyWPs8xfWStuKYMqx0xNklrGHKS4D5H+gSe
	wp+X38cYuyf1c5q9ky/AsGY3CIBGpLznguXnHMOHr3PDg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4drw4fjnnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Apr 2026 20:53:45 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 26 Apr 2026 20:53:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 26 Apr 2026 20:53:44 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id D16B33F7041;
	Sun, 26 Apr 2026 20:53:41 -0700 (PDT)
Date: Mon, 27 Apr 2026 09:23:40 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: Re: [PATCH v3 net 10/11] octeontx2-af: npc: cn20k: Tear down default
 MCAM rules explicitly on free
Message-ID: <ae7dxGHcrtXxRGCG@rkannoth-OptiPlex-7090>
References: <20260423104317.2707923-1-rkannoth@marvell.com>
 <20260423104317.2707923-11-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260423104317.2707923-11-rkannoth@marvell.com>
X-Proofpoint-ORIG-GUID: pRvKany1h_7NUBDWreT6Z8cBgraKIEmT
X-Proofpoint-GUID: pRvKany1h_7NUBDWreT6Z8cBgraKIEmT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDAzNyBTYWx0ZWRfX58S8OzqqenFu
 6S8iYDWRYOFHqfLxh6VbgN6XOWwB0pJNGjYVNoz5Ehu8XBUcFcX8MNUddWGwW0ImDsULAjlRHr7
 uDO5b0s/UZipguiU5gn2ci1pMAvvyfqokjOlxCkShwlUVnsYobg0QH8e4k9SOenRz6XyTEZpsfI
 qgZtZaHnzDxcon7rKizBJITWtbAyC+VfoT3Sa9abr+LO7C2Yigp7PcBDRkfBzzK3xRJBUAIy7VM
 utAx77jB26ZzzaezKNMXbEdnkjcGNOaLYaZFzDDRq3RpER8VX3Bomca99Vk6h8yb1XR6PdDP3hH
 DyaXLS4TdUp1gFTs+SvVe/PWE8GM0tV/dXPtA1Wy+f+Y06kFYeOveG031LyVoPkTacDKo0qdvZj
 KIgTS8Uuy8zVW2iz9b0RkgwpqCnAV0C3hxwkXKl+rS+AwKpjDsq4EamawAEt8XsRpYWs8eu6Sjv
 eOn0ftCoDXghILNH6ZQ==
X-Authority-Analysis: v=2.4 cv=X/Ni7mTe c=1 sm=1 tr=0 ts=69eeddc9 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=vUcn5b9BnrkzDTcP8egA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_01,2026-04-21_02,2025-10-01_01
X-Rspamd-Queue-Id: 35B7A46CAA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281217-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]

On 2026-04-23 at 16:13:16, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> npc_cn20k_dft_rules_free() used the NPC MCAM mbox "free all" path, which
> does not match how cn20k tracks default-rule MCAM slots indexes.
>
> Resolve the default-rule indices, then for each valid slot clear the
> bitmap entry, drop the PF/VF map, disable the MCAM line, clear the
> target function, and npc_cn20k_idx_free(). Remove any
> matching software mcam_rules nodes. On hard failure from idx_free, WARN
> and stop so the box stays up for analysis.
>
> In npc_mcam_free_all_entries(), prefetch the same default-rule indices
> and, on cn20k, skip bitmap clear and idx_free when the scanned entry is
> one of those reserved defaults (they are released by
> npc_cn20k_dft_rules_free). Still disable the entry and tear down counter
> mapping for every matching index.
>
> Fixes: 09d3b7a1403f ("octeontx2-af: npc: cn20k: Allocate default MCAM indexes")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

>> octeontx2-af: npc: cn20k: Tear down default MCAM rules explicitly on free
>[ ... ]
>> Resolve the default-rule indices, then for each valid slot clear the
>> bitmap entry, drop the PF/VF map, disable the MCAM line, clear the
>> target function, and npc_cn20k_idx_free(). Remove any
>> matching software mcam_rules nodes. On hard failure from idx_free, WARN
>> and stop so the box stays up for analysis.
>The commit message says "WARN and stop", but looking at the code below,
>there doesn't appear to be a stop.

ACK. will add a "return" from here. This issue indicates fundemental error in mcam allocation
algorithm. There is no point in graceful handling of error. Returning from here would allow the
debugger to understand the current state of the system and debug the issue.

>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>> index 6d3166960a3f2a..54a25d9c55053e 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>> @@ -4228,14 +4228,47 @@ void npc_cn20k_dft_rules_free(struct rvu *rvu, u16 pcifunc)
>[ ... ]
>> +	for (int i = 0; i < 4; i++) {
>> +		if (ptr[i] == USHRT_MAX)
>> +			continue;
>>
>> -	free_req.hdr.pcifunc = pcifunc;
>> -	free_req.all = 1;
>> -	rc = rvu_mbox_handler_npc_mcam_free_entry(rvu, &free_req, &rsp);
>> -	if (rc)
>> -		dev_err(rvu->dev,
>> -			"%s: Error deleting default entries (pcifunc=%#x\n",
>> -			__func__, pcifunc);
>> +		mutex_lock(&mcam->lock);
>> +		npc_mcam_clear_bit(mcam, ptr[i]);
>Can this lead to a double-free of the default rules?
>If an unprivileged VF manually frees its default rule by sending an
>NPC_MCAM_FREE_ENTRY mailbox message,

default entiries are always allocated by Kernel; not by an unprivileged VF manually.

>the single-entry free handler
>(rvu_mbox_handler_npc_mcam_free_entry) frees the hardware index and clears
>the software bitmap, but it does not remove the index from the AF's internal
>xa_pf2dfl_rmap xarray.
>When the VF is later detached, this code fetches the same index from the
>xarray and unconditionally calls npc_mcam_clear_bit(), which increments
>mcam->bmap_fcnt++ and artificially inflates the free count.
>> +		mcam->entry2pfvf_map[ptr[i]] = NPC_MCAM_INVALID_MAP;
>> +		npc_cn20k_enable_mcam_entry(rvu, blkaddr, ptr[i], false);
>> +		mcam->entry2target_pffunc[ptr[i]] = 0x0;
>> +		mutex_unlock(&mcam->lock);
>> +
>> +		rc = npc_cn20k_idx_free(rvu, &ptr[i], 1);
>Since the subbank bitmap was already cleared by the single-entry free
>handler, wouldn't npc_cn20k_idx_free() return -EINVAL for the already
>freed index?
>> +		if (rc) {
>> +			/* Non recoverable error. Let us WARN and return. Keep system alive to
>> +			 * enable debugging
>> +			 */
>> +			WARN(1, "%s Error deleting default entries (pcifunc=%#x) mcam_idx=%u\n",
>> +			     __func__, pcifunc, ptr[i]);
>Does this allow an unprivileged VF to trigger kernel warnings (causing a DoS
>if panic_on_warn is enabled) by freeing its default rules before detaching?

default entiries are always allocated by Kernel; not by an unprivileged VF manually.

>Also, the inline comment says "Let us WARN and return", but there is no
>return or break statement here. Does this just continue the loop instead of
>stopping as intended?

>> +
>> +			/* Clear entries from mcam_rules, whose indexes are successfully freed
>> +			 * by npc_cn20k_idx_free().
>> +			 */
>> +			ptr[i] = USHRT_MAX;
>> +		}
>> +	}

