Return-Path: <netdev+bounces-306212-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XIKQHcyUT2pokAIAu9opvQ
	(envelope-from <netdev+bounces-306212-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 14:32:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5601731005
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 14:32:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Q2gfnxiZ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306212-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306212-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F6C13011840
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 12:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAC73F23AF;
	Thu,  9 Jul 2026 12:27:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA14379EF2;
	Thu,  9 Jul 2026 12:27:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600048; cv=none; b=gKnrFOhyxM+G9BAL9R7Ead1Er/fASRFyfdz101robpSzW3ZYJLYOraXkZRucnRCzYrvOX0GSBRuoJStDoxCa63PvLT82qdbTNwBhUTLd6eaXRaN5SDzFJYnmTtNYYIs2usOBwPvEH5vugW6iVA0eGG7Ea5ikeC1+rGz2UWHSDZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600048; c=relaxed/simple;
	bh=D6sFePdHfg9/lQaT+pvy/ALPB+0TLGP+dk980qsNpV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oe/eNr1bn8cu38sRa4s93WY9M9z0NJF2OknnoD/1xhe5Tz8xJCd2WDJBquq/0jHMmBr6MjCViJbTAqaYD/y9/m360Lqq4LqwHHSrx9AN8qrtc2Up9UC2mN4Ycl/WXWFIOEJv9g2RVutPACTl5sdirH4OxbGY0gzwZANq5sLgBu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2gfnxiZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6C71F000E9;
	Thu,  9 Jul 2026 12:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783600047;
	bh=aPiI4acebEamfHqZdOJ7ZViugkZJ59S192ufQqTKWu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q2gfnxiZTKur91gL45oISEsS66q0C2fspHsKa1xHrpymOUeWFGClZpcKaAsw5KNH2
	 98cfbMIRL4Nmgh7MaQMDZ2dssjVzOFXWNOj6Q+bglaVSr+E4PYt4OkivDiVnEvsTB/
	 v6u/CkiW62IJAxyBkzTudsHwTyyGpDBqD6Mon95wRBa2Vewj7nYLiM5OndNJ/AQ9K9
	 cakRN/sTAZm5TTM3yWgMQQlMR24ezcVsVfxcJY3B624DfX95cVIZCSjtUfOj1DNThF
	 dyyHtrR7PKztwT4KCC7zHHh5CZjnDl2JIoOGLdamLpU58REiXsadJyjl6OZ8vcm4Ur
	 nBgIlc3jnF+RA==
From: Simon Horman <horms@kernel.org>
To: rkannoth@marvell.com
Cc: Simon Horman <horms@kernel.org>,
	davem@davemloft.net,
	gakula@marvell.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	sgoutham@marvell.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hkelam@marvell.com
Subject: Re: [PATCH v2 net] octeontx2-af: Block VFs from clobbering special CGX PKIND state
Date: Thu,  9 Jul 2026 13:26:49 +0100
Message-ID: <20260709122648.1552103-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703024157.3526879-1-rkannoth@marvell.com>
References: <20260703024157.3526879-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rkannoth@marvell.com,m:horms@kernel.org,m:davem@davemloft.net,m:gakula@marvell.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:sgoutham@marvell.com,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:hkelam@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306212-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C5601731005

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
octeontx2-af: Block VFs from clobbering special CGX PKIND state

This patch prevents VF NIX LF allocation from resetting the CGX RX PKIND
and default TX parse config when the shared LMAC has HiGig2 or EDSA
parsing enabled. It adds cgx_get_pkind() and a new
rvu_cgx_is_pkind_config_permitted() helper, then gates the pkind and TX
parse writes in nix_interface_init() and rvu_mbox_handler_nix_lf_alloc().

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> index 4ff3935ed3fe..2be1da3476ac 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> @@ -1355,3 +1355,35 @@ void rvu_mac_reset(struct rvu *rvu, u16 pcifunc)
>  	if (mac_ops->mac_reset(cgxd, lmac, !is_vf(pcifunc)))
>  		dev_err(rvu->dev, "Failed to reset MAC\n");
>  }
> +
> +/* Do not allow CGX-mapped VFs to overwrite PKIND when special parse kinds
> + * (HiGig, EDSA, etc.) are in use on the shared LMAC.
> + */
> +bool rvu_cgx_is_pkind_config_permitted(struct rvu *rvu, u16 pcifunc)
> +{
> +	int pf, err, rxpkind;
> +	u8 cgx_id, lmac_id;
> +	void *cgxd;
> +
> +	pf = rvu_get_pf(rvu->pdev, pcifunc);
> +
> +	if (!(pcifunc & RVU_PFVF_FUNC_MASK))
> +		return true;
> +
> +	if (!is_pf_cgxmapped(rvu, pf))
> +		return true;
> +
> +	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
> +	cgxd = rvu_cgx_pdata(cgx_id, rvu);
> +	err = cgx_get_pkind(cgxd, lmac_id, &rxpkind);
> +	if (err)
> +		return false;
> +
> +	switch (rxpkind) {
> +	case NPC_RX_HIGIG_PKIND:
> +	case NPC_RX_EDSA_PKIND:
> +		return false;
> +	default:
> +		return true;
> +	}
> +}

[High]
Is the exclusion actually enforced against the other writers of these
registers?

rvu_npc_set_parse_mode() also calls cgx_set_pkind() and writes
NIX_AF_LFX_TX_PARSE_CFG(nixlf) directly, and it is reachable from the
rvu_mbox_handler_npc_set_pkind mbox handler as well as from
rvu_nix_lf_teardown(). None of those paths take cgxd->lock.

Consider this interleaving on a shared LMAC:

    CPU A (PF)                       CPU B (VF)
    rvu_mbox_handler_npc_set_pkind
      rvu_npc_set_parse_mode
        (no cgxd->lock held)
                                     mutex_lock(&cgxd->lock)
                                     cgx_get_pkind() -> default
                                     rvu_cgx_is_pkind_config_permitted()
                                       returns true
                                     cgx_set_pkind(default)
                                     rvu_npc_set_pkind(default)
                                     mutex_unlock(&cgxd->lock)
        cgx_set_pkind(HIGIG)
        write NIX_AF_LFX_TX_PARSE_CFG

Or the reverse order, where CPU B's write clobbers CPU A's HiGig
programming after CPU A has already installed it. Since
rvu_npc_set_parse_mode() does not acquire cgxd->lock, does the check in
rvu_cgx_is_pkind_config_permitted() effectively close the race the
commit message describes?

Additionally, the comment on struct cgx's lock in lmac_common.h reads:

    /* Lock to serialize read/write of global csrs like
     * RPMX_MTI_STAT_DATA_HI_CDC etc
     */
    struct mutex		lock;

Is cgxd->lock the intended lock to serialize per-NIX-LF register writes
like NIX_AF_LFX_TX_PARSE_CFG, or should a different mechanism be used?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index 0297c7ab0614..4e72d6e072d5 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c

[ ... ]

> @@ -1509,11 +1517,14 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
>  	u16 bcast, mcast, promisc, ucast;
>  	struct rvu_hwinfo *hw = rvu->hw;
>  	u16 pcifunc = req->hdr.pcifunc;
> +	u8 cgx_id = 0, lmac_id = 0;
>  	bool rules_created = false;
>  	struct rvu_block *block;
>  	struct rvu_pfvf *pfvf;
>  	u64 cfg, ctx_cfg;
> +	struct cgx *cgxd;
>  	int blkaddr;
> +	int pf;
>  
>  	if (!req->rq_cnt || !req->sq_cnt || !req->cq_cnt)
>  		return NIX_AF_ERR_PARAM;
> @@ -1685,8 +1696,18 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
>  	rvu_write64(rvu, blkaddr, NIX_AF_LFX_RX_CFG(nixlf), req->rx_cfg);
>  
>  	/* Configure pkind for TX parse config */
> -	cfg = NPC_TX_DEF_PKIND;
> -	rvu_write64(rvu, blkaddr, NIX_AF_LFX_TX_PARSE_CFG(nixlf), cfg);
> +	if (is_pf_cgxmapped(rvu, rvu_get_pf(rvu->pdev, pcifunc))) {
> +		pf = rvu_get_pf(rvu->pdev, pcifunc);
> +		rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
> +		cgxd = rvu_cgx_pdata(cgx_id, rvu);
> +
> +		mutex_lock(&cgxd->lock);
> +		if (rvu_cgx_is_pkind_config_permitted(rvu, pcifunc)) {
> +			cfg = NPC_TX_DEF_PKIND;
> +			rvu_write64(rvu, blkaddr, NIX_AF_LFX_TX_PARSE_CFG(nixlf), cfg);
> +		}
> +		mutex_unlock(&cgxd->lock);
> +	}

[High]
Does this outer is_pf_cgxmapped() guard change behavior for LBK, SDP and
representor NIX LFs?

Prior to this patch the write of NPC_TX_DEF_PKIND to
NIX_AF_LFX_TX_PARSE_CFG(nixlf) was unconditional for every NIX LF that
reached this point. is_pf_cgxmapped() returns false when
pf < PF_CGXMAP_BASE (e.g. AF PF0 that owns LBK VFs) and for SDP PFs (via
the is_sdp_pf() exclusion):

    static inline bool is_pf_cgxmapped(struct rvu *rvu, u8 pf)
    {
        return (pf >= PF_CGXMAP_BASE && pf <= rvu->cgx_mapped_pfs) &&
            !is_sdp_pf(rvu, rvu_make_pcifunc(rvu->pdev, pf, 0));
    }

For those non-CGX cases the register is now left at whatever
rvu_lf_reset() leaves behind rather than NPC_TX_DEF_PKIND.

The commit message describes the intent narrowly:

    a VF NIX LF alloc must not reset the LMAC RX PKIND or default TX
    parse config over the PF setup.

rvu_cgx_is_pkind_config_permitted() already returns true for non-VF and
for non-CGX-mapped pcifuncs. Would gating solely on
rvu_cgx_is_pkind_config_permitted() (without the outer
is_pf_cgxmapped()) match the stated intent and preserve prior behavior
for LBK, SDP and representor NIX LFs?

