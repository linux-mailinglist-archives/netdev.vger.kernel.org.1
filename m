Return-Path: <netdev+bounces-282648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHZ4JzPV8mnIugEAu9opvQ
	(envelope-from <netdev+bounces-282648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 06:06:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B9949D2B4
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 06:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 374A8300D14B
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D185360751;
	Thu, 30 Apr 2026 04:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="J/6iKiF/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2081434EF05;
	Thu, 30 Apr 2026 04:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777521968; cv=none; b=pHtqemTQ+N8OOHRo3gmcgpYd2jdKnchDtk9yCznIhRzkkVWjZrTvLYUSz+iho2sDsWMdo0iBaLmZQrMD0wJus+eCCgsbyDNPVQIAiVtRlWVAiIgkGD0sMwa7CmwS22ev3yx91bcVQNjZIBHkOPVzTw225jCb7XOIctqdLjqcXCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777521968; c=relaxed/simple;
	bh=BQENu23co3SMb4u8N1GqDuYRTkLNAK7HexkFY8nUhKw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjExQhKDzWoM32gea14cD+8i0i6a1zFEZxsowPSAfYca42jgGDf/b1HS2QgQFEfo6dVwZy20QIZT/gbuSTzwdG+8Q3ITUcFkUUCIvbe7RvqSmPQAQ7XTOJW9IhvMQoROjw4hyqgSk1ReWzrdQPvQ1T1fe+wetKTW3F91v5Z5nLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=J/6iKiF/; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U3ZAhv3727651;
	Wed, 29 Apr 2026 21:05:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=ZA3WYumYPFdNoVuxrMnxRqeM6
	ulrS77sx+9ffz93d1s=; b=J/6iKiF/H9cd6F53I+jvHZySnkRjA3vuu14r8BvSs
	KHw3c1TeZsss9coBAlxNQ6hlMwLyJHRKu6UaiDcY+bZEk2taMVG/CyA83TwlMomi
	dh2XGkzYfiAVLkjf+42YNxw4JuOXYwPoihO2HEwZfYgtjIiuITxtC8OIK+UPQsV+
	byC7QepIKTKDR3RbP2Q76bgK4yen2f8ubtofF/6SKf2q7QFoHNeHRuJ+guRoT4pR
	w2Y7U8N1JyYExnFKtNozvZQwIGBNNufij421iZtG+ps9rpBqHdjC4JeuK5Mn56dj
	eXDfI1nQeDJvUFpx0Yl9KwzlIBDbCIFm5f3V5jQsF1bJg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dun98hq9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 21:05:41 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 29 Apr 2026 21:05:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 29 Apr 2026 21:05:41 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id C0A743F7079;
	Wed, 29 Apr 2026 21:05:37 -0700 (PDT)
Date: Thu, 30 Apr 2026 09:35:36 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        Suman Ghosh
	<sumang@marvell.com>, Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v5 net 01/10] octeontx2-af: npc: cn20k: Propagate MCAM
 key-type errors on cn20k
Message-ID: <afLVECjkIYrC6dM3@rkannoth-OptiPlex-7090>
References: <20260429022722.1110289-1-rkannoth@marvell.com>
 <20260429022722.1110289-2-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260429022722.1110289-2-rkannoth@marvell.com>
X-Authority-Analysis: v=2.4 cv=BK+DalQG c=1 sm=1 tr=0 ts=69f2d515 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8
 a=AQwMLzV3eSe0zTKyFscA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDAzOCBTYWx0ZWRfX8sOySBR/vOaL
 klfd8bCBFtWi3bfTAyRQHNq+Vziqe9o5U8hpSsOn69vmJLbXm4j0EH2jTC+vnlBoSdqg1Cv0Q3W
 56hOoNx0DOWWZh0gr5pqXOdTRQeCtVkmwZznnEmS7wVxob4TN+t4XHLKPBLj1SZlbX2cIufXP+5
 x9LQUaYA5RmNwgulPR4im7L8mrUUIDekiALGAECowJO6D/vHTtWOaKTR3FwhdASyHq8tVIOndot
 b0TEIjnnEScdrfeU/OSLym9aFyr8rKitjODErlsWlLyANqHQpRD0tKTV6CtPTYfUtUVfEb0R/nv
 lUpNvvvvFN182s5eHvT25OsSSrJaAbbO49flgtXKZZULW++aMQYakU3v/iwXPpSYe59Niziufrl
 gR+IYwxELMn9BtBqAchSTKlyUdijTC8xiNPmMFr0H/LzAoYzMT+EsLWYEjX+1l5CIg6s3UZZx3M
 h/Ufb7M4yeZMI8JfizQ==
X-Proofpoint-GUID: iI7qlChDLiR_r35Q6vNys0O-ROoP7TAv
X-Proofpoint-ORIG-GUID: iI7qlChDLiR_r35Q6vNys0O-ROoP7TAv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Rspamd-Queue-Id: 39B9949D2B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282648-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

On 2026-04-29 at 07:57:13, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> npc_mcam_idx_2_key_type() can fail; callers used to ignore it and still
> used kw_type when enabling, configuring, copying, and reading MCAM entries.
> That could program or decode hardware with an undefined key type.
>
> Return -EINVAL when key-type lookup fails. Return -EINVAL from
> npc_cn20k_copy_mcam_entry() when src and dest key types differ instead of
> failing silently.
>
> Change npc_cn20k_{enable,config,copy,read}_mcam_entry() to return int on
> success or error. Thread those errors through the cn20k MCAM write and read
> mbox handlers, the cn20k baseline steer read path, NPC defrag move
> (disable/copy/enable with dev_err and -EFAULT), and the DMAC update path in
> rvu_npc_fs.c.
>
> Make npc_copy_mcam_entry() return int so the cn20k branch can return
> npc_cn20k_copy_mcam_entry() without a void/int mismatch, and fail
> NPC_MCAM_SHIFT_ENTRY when copy fails.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> index 7291fdb89b03..7170dcf26200 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
[ ... ]
> @@ -1375,11 +1395,13 @@ int rvu_mbox_handler_npc_cn20k_mcam_alloc_and_write_entry(struct rvu *rvu,
>  							  struct npc_mcam_alloc_and_write_entry_rsp *rsp)
>  {
>  	struct rvu_pfvf *pfvf = rvu_get_pfvf(rvu, req->hdr.pcifunc);
> +	struct npc_mcam_free_entry_req free_req = { 0 };
>  	struct npc_mcam_alloc_entry_req entry_req;
>This isn't a bug introduced here, but entry_req is allocated on the stack
>and is not zero-initialized. Its kw_type field does not appear to be set
>before calling rvu_mbox_handler_npc_mcam_alloc_entry().
>Could this uninitialized stack garbage lead to unpredictable bounds-check
>failures or random mcam allocation errors?

I see your concern regarding the uninitialized entry_req. The reason it was left as-is is that this patch
focuses specifically on the MCAM key-type error propagation logic. However, I agree that leaving stack garbage is suboptimal.
If you prefer not to bundle this with the current Smatch fix

> @@ -3607,9 +3640,30 @@ int npc_defrag_move_vdx_to_free(struct rvu *rvu,
>  				   NPC_AF_CN20K_MCAMEX_BANKX_STAT_EXT(midx,
>  								      bank));
>
> -		npc_cn20k_enable_mcam_entry(rvu, blkaddr, old_midx, false);
> -		npc_cn20k_copy_mcam_entry(rvu, blkaddr, old_midx, new_midx);
> -		npc_cn20k_enable_mcam_entry(rvu, blkaddr, new_midx, true);
> +		/* If bug happened during copy/enable mcam, then there is a bug in allocation
> +		 * algorithm itself. There is no point in rewinding and returning, as it
> +		 * will face further issue. Return error after printing error
> +		 */
> +		if (npc_cn20k_enable_mcam_entry(rvu, blkaddr, old_midx, false)) {
> +			dev_err(rvu->dev,
> +				"%s: Error happened while disabling old_mid=%u\n",
> +				__func__, old_midx);
> +			return -EFAULT;
> +		}
> +
> +		if (npc_cn20k_copy_mcam_entry(rvu, blkaddr, old_midx, new_midx)) {
> +			dev_err(rvu->dev,
> +				"%s: Error happened while copying old_midx=%u new_midx=%u\n",
> +				__func__, old_midx, new_midx);
> +			return -EFAULT;
> +		}
>When these early returns execute, the software vidx map has already been
>redirected to new_midx via a preceding call to npc_vidx_maps_modify().
>Since the early returns skip the remaining bookkeeping steps (updating
>mcam->entry2pfvf_map, freeing old_midx, and updating counts), does this leave
>the system in a corrupted state?
>Would the vidx now point to a new_midx that the user does not officially own
>(causing NPC_MCAM_PERM_DENIED on future accesses), while old_midx is left
>disabled and permanently leaked?

understand the concern regarding the vidx map falling out of sync. However, npc_defrag_move_vdx_to_free runs under a mutex, and
a failure during the copy/enable phase indicates the NPC block has entered a non-deterministic state.
In this specific 'should-never-happen' scenario, attempting a graceful software rewind could mask a critical fault or lead to further exceptions.
My intention with this Smatch fix was to ensure the error is at least caught and logged rather than silently ignored.
I can address a full transactional rollback mechanism in a separate hardening series for net-next.
But issue is graceful rollback can also fail as it is kind of another defrag process.

> @@ -2038,8 +2040,12 @@ void npc_mcam_enable_flows(struct rvu *rvu, u16 target)
>  				continue;
>  			}
>
> -			if (rule->vfvlan_cfg)
> -				npc_update_dmac_value(rvu, blkaddr, rule, pfvf);
> +			if (rule->vfvlan_cfg) {
> +				if (npc_update_dmac_value(rvu, blkaddr, rule, pfvf))
> +					dev_err(rvu->dev,
> +						"Update dmac failed for %u, target=%#x\n",
> +						rule->entry, target);
> +			}
>If npc_update_dmac_value() fails and returns an error like -EINVAL, execution
>falls through and logs the error, but continues processing the current rule.
>The code then computes a hardware offset via NPC_AF_MCAMEX_BANKX_ACTION()
>and unconditionally performs a direct hardware write using rule->entry.
>If rule->entry happens to be invalid or out-of-bounds, could this fall-through
>cause unrelated device registers to be corrupted, or trigger a data abort?
>Even though a later patch in this series hardens some helpers, is a continue
>statement missing here to protect the immediate rvu_write64() that follows?
>Additionally, this is not a regression in this patch, but I noticed that
>list_for_each_entry() is used to iterate over mcam->mcam_rules while
>holding mcam->lock.
>If npc_update_dmac_value() is called, it explicitly drops mcam->lock before
>invoking the mailbox handler.
>If a concurrent thread acquires the lock and deletes the current rule while
>it is dropped, will the list iteration resume with a use-after-free on the
>freed rule pointer?
>Should a safe list iteration macro be used instead, combined with reference
>counting to preserve the rule?
I acknowledge that dropping mcam->lock during list_for_each_entry is a significant architectural vulnerability.
However, fixing this properly requires moving to a reference-counted rule model or an RCU-based iteration to prevent regressions.
Since this series is a targeted bug fix for net focused on Smatch errors, I believe a full locking refactor is
too high-risk for this specific pull request. Will work on hardening patch to net-next.

