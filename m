Return-Path: <netdev+bounces-256916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEpFCbT/g2nYwgMAu9opvQ
	(envelope-from <netdev+bounces-256916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:25:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C02EDF50
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8274301BF66
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 02:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BCF2BE053;
	Thu,  5 Feb 2026 02:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIQ0oU+C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF782BE031;
	Thu,  5 Feb 2026 02:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770258325; cv=none; b=bEzOXgdhBEBll1SgqWbQg8FGfkzVtQtnE5chrtrDp/W6R+r4oiAxhZr5bwa3W9oTfiT1OxxGKBAj3LaALHMCnR6O7Gv7PtG1vwPXK6OVvYEMt2KMppcHQAn+RiBcPbuKUa2cCbhR+dOayIByHIVqTKJaezZQDWI/1nOsM8S0ZwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770258325; c=relaxed/simple;
	bh=E927iexo5Hdj1aTgLq6/mH6txLCyePxLlbwpx7uFv/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkwvbkP0sidS6mJoL3wWXy84EMjaBGQZu0l9Kx5gbH30Bg0vcybX0Z/7asNcjDo+EFhJl3Ga5/vRCX2hmn+ZrrCc4la1mXFtMf4AjJ6fVhNh09032bAbLmbTlL9XWKPAe9j/nMX9xGXEZES0BjvSNLb8CWTUSk/CW1/juVFuuLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIQ0oU+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DB0C16AAE;
	Thu,  5 Feb 2026 02:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770258325;
	bh=E927iexo5Hdj1aTgLq6/mH6txLCyePxLlbwpx7uFv/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sIQ0oU+CiK73IJk4HovmiUZS0jDwLKvSmkD1mbfR2q+j6h7J4riNGpoxIIClQnmNo
	 TpeOQHmbTse2/EILDUBUj7yfwk6X5oHwf+IbG/rfGYoOTkhmBhazKbhHjhQf52JijY
	 dwS99Euuwt9Pk+fyk/JviRLuDivEekN2nseAKLFr1nua9UYRVIgDmmCDQXjV4ZMWq1
	 p36z/4nWrTJkggxkBHY8pkbgHwmd4t6QVgc757WqO8RjjuGyh3aVzX3Y22WoaPW59f
	 AEK0IAU4VnbSGLb7EHjoAERaU7ijtAdtWB1BkOEGXgLVkR9bocF63sCpOkvTIRgppJ
	 kdQWOZIh0IZRw==
From: Jakub Kicinski <kuba@kernel.org>
To: rkannoth@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	sgoutham@marvell.com,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sumang@marvell.com,
	sbhatta@marvell.com,
	davem@davemloft.net
Subject: Re: [net-next,v8,08/13] octeontx2-af: npc: cn20k: Add new mailboxes for CN20K silicon
Date: Wed,  4 Feb 2026 18:25:23 -0800
Message-ID: <20260205022523.2271076-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202074607.2535569-9-rkannoth@marvell.com>
References: <20260202074607.2535569-9-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256916-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 85C02EDF50
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: npc: cn20k: Add new mailboxes for CN20K silicon

This patch adds new mailboxes for CN20K silicon to support an updated
struct mcam_entry with 8 keywords instead of 7, maintaining backward
compatibility by using separate structures and mailbox handlers.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h

[ ... ]

>     Due to new requirements in CN20K, the existing `struct mcam_entry` needed
>     to be updated. Previously, it contained two arrays, `kw` and `kw_mask`,
>     each of size 7 (keyword size). To support CN20K requirements, the size of
>     these arrays has been increased from 7 to 8.

This isn't a bug, but the commit message description appears inaccurate. The
code shows that struct mcam_entry retains NPC_MAX_KWS_IN_KEY = 7, while a new
struct cn20k_mcam_entry was created with NPC_CN20K_MAX_KWS_IN_KEY = 8. Could
the commit message be updated to reflect that a new structure was created
rather than the existing one being resized?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c

[ ... ]

> @@ -706,6 +707,21 @@ static int rvu_setup_msix_resources(struct rvu *rvu)
>  	rvu->msix_base_iova = iova;
>  	rvu->msixtr_base_phy = phy_addr;
>
> +	if (is_rvu_otx2(rvu) || is_cn20k(rvu->pdev))
> +		return 0;
> +
> +	altaf_intr_data = &rvu->fwdata->altaf_intr_info;

Is rvu->fwdata guaranteed to be non-NULL here? Looking at rvu_fwdata_init(),
it can fail in several cases (cgx_get_fwdata_base() failure, ioremap_wc()
failure, or is_rvu_fwdata_valid() explicitly setting fwdata to NULL), and
rvu_setup_hw_resources() does not check its return value before calling
rvu_setup_msix_resources().

The platform check (is_rvu_otx2 || is_cn20k) does not guarantee fwdata is
valid since fwdata initialization depends on firmware availability, not
silicon version.

> +	if (altaf_intr_data->gint_paddr) {
> +		iova = dma_map_resource(rvu->dev, altaf_intr_data->gint_paddr,
> +					PCI_MSIX_ENTRY_SIZE,
> +					DMA_BIDIRECTIONAL, 0);
> +
> +		if (dma_mapping_error(rvu->dev, iova))
> +			return -ENOMEM;
> +
> +		altaf_intr_data->gint_iova_addr = iova;

Does altaf_intr_data->gint_iova_addr get unmapped anywhere? Looking at
rvu_free_hw_resources(), only rvu->msix_base_iova is unmapped. If this second
DMA mapping fails, does the first mapping (stored at rvu->msix_base_iova)
also leak?

[ ... ]

> +static void rvu_notify_altaf(struct rvu *rvu, u16 pcifunc, u64 op)
> +{
> +	int pf, vf;
> +
> +	if (!rvu->fwdata)
> +		return;
> +
> +	if (op == ALTAF_FLR) {
> +		pf = rvu_get_pf(rvu->pdev, pcifunc);
> +		set_bit(pf, rvu->fwdata->altaf_intr_info.flr_pf_bmap);
> +		if (pcifunc & RVU_PFVF_FUNC_MASK) {
> +			vf = pcifunc & RVU_PFVF_FUNC_MASK;
> +			set_bit(vf, rvu->fwdata->altaf_intr_info.flr_vf_bmap);

Can this overflow flr_vf_bmap[]? RVU_PFVF_FUNC_MASK is 0x3FF allowing vf
values 0-1023, but flr_vf_bmap is declared as unsigned long flr_vf_bmap[2]
which provides only 128 bits on 64-bit systems. If vf >= 128, set_bit() will
write beyond the array bounds.

[ ... ]

> @@ -3269,6 +3316,13 @@ static int rvu_register_interrupts(struct rvu *rvu)
>  	if (ret)
>  		goto fail;
>
> +	for (i = 0; i < rvu->num_vec; i++) {
> +		if (strstr(&rvu->irq_name[i * NAME_SIZE], "Mbox") ||
> +		    strstr(&rvu->irq_name[i * NAME_SIZE], "FLR"))

Is it safe to call strstr() on all entries in irq_name[]? The array is
allocated with devm_kmalloc_array() which does not zero-initialize memory.
IRQ names are only set via sprintf() for specific vector indices, so unnamed
vectors will contain uninitialized data without a null terminator. Could this
cause strstr() to read past the buffer?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c

[ ... ]

> @@ -3111,7 +3115,7 @@ int rvu_mbox_handler_npc_mcam_write_entry(struct rvu *rvu,
>  	if (rc)
>  		goto exit;
>
> -	if (req->set_cntr &&
> +	if (!is_cn20k(rvu->pdev) && req->set_cntr &&
>  	    npc_mcam_verify_counter(mcam, pcifunc, req->cntr)) {
>  		rc = NPC_MCAM_INVALID_REQ;
>  		goto exit;

Should this explicitly reject req->set_cntr for CN20K? Other handlers
(rvu_mbox_handler_npc_mcam_alloc_counter, free_counter, unmap_counter)
return NPC_MCAM_INVALID_REQ for CN20K, but this function skips validation
and proceeds. Would it be more consistent to return an error if
is_cn20k(rvu->pdev) && req->set_cntr?

[ ... ]

> @@ -3482,12 +3498,20 @@ int rvu_mbox_handler_npc_mcam_clear_counter(struct rvu *rvu,
>  		struct npc_mcam_oper_counter_req *req, struct msg_rsp *rsp)
>  {
>  	struct npc_mcam *mcam = &rvu->hw->mcam;
> -	int blkaddr, err;
> +	int blkaddr, err, index, bank;
>
>  	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
>  	if (blkaddr < 0)
>  		return NPC_MCAM_INVALID_REQ;
>
> +	if (is_cn20k(rvu->pdev)) {
> +		index = req->cntr & (mcam->banksize - 1);
> +		bank = npc_get_bank(mcam, req->cntr);
> +		rvu_write64(rvu, blkaddr,
> +			    NPC_AF_CN20K_MCAMEX_BANKX_STAT_EXT(index, bank), 0);
> +		return 0;
> +	}

On CN20K, req->cntr is treated as an entry index since statistics are
per-entry. Should npc_mcam_verify_entry() be called to verify ownership
before clearing? Without validation, any VF could clear statistics for
entries owned by other VFs or the PF.

[ ... ]

> @@ -3504,12 +3528,23 @@ int rvu_mbox_handler_npc_mcam_counter_stats(struct rvu *rvu,
>  			struct npc_mcam_oper_counter_rsp *rsp)
>  {
>  	struct npc_mcam *mcam = &rvu->hw->mcam;
> -	int blkaddr, err;
> +	int blkaddr, err, index, bank;
> +	u64 regval;
>
>  	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
>  	if (blkaddr < 0)
>  		return NPC_MCAM_INVALID_REQ;
>
> +	if (is_cn20k(rvu->pdev)) {
> +		index = req->cntr & (mcam->banksize - 1);
> +		bank = npc_get_bank(mcam, req->cntr);
> +		regval = rvu_read64(rvu, blkaddr,
> +				    NPC_AF_CN20K_MCAMEX_BANKX_STAT_EXT(index,
> +								       bank));
> +		rsp->stat = regval;
> +		return 0;
> +	}

Similar to the clear function above, the CN20K path reads per-entry
statistics without ownership validation. Should npc_mcam_verify_entry()
be called before returning statistics? This could allow a VF to read
traffic statistics for entries owned by other VFs.

