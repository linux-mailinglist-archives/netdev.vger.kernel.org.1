Return-Path: <netdev+bounces-269077-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGk4ILzCumkGbgIAu9opvQ
	(envelope-from <netdev+bounces-269077-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:20:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3672BE142
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 62009300827C
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17032D1914;
	Wed, 18 Mar 2026 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lprrT1gp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8FF288C0E;
	Wed, 18 Mar 2026 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773847223; cv=none; b=MUszHO1OmbawgZqdImOh5lp9pJhRlxF48LSecIu05lYHl8TxvCEASXttT+uMcTGekiDGBROq+HQ5zyIjQ+Xf0L7PEBluwnkFcN92KY5C4PecFxeC99XEOGYVXUij1w1F8lGAGVXJQHO7iNLPTdDfO9EtmnBMvDHXbq/017ZLMlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773847223; c=relaxed/simple;
	bh=Ma4TVtqtgPGmyp7UaF3ESRqHWGTSTz2Uotl1yIDrIBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4emKr/S6//kgN7xeI1+baEA8tY3PbAz2jWD/iwoAQQxOf+KtupPpAqsFShEnZUxLbzh4LG7bO3uqs4+lau+Q1VEeRSDm7vGRAOEbTCRnMJBC1FFS+U19JMl1U0TSlx9UcQpH5G9LAUp2m+75woO6NCOFUJQVVYLzJZahTB29P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lprrT1gp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC921C19421;
	Wed, 18 Mar 2026 15:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773847223;
	bh=Ma4TVtqtgPGmyp7UaF3ESRqHWGTSTz2Uotl1yIDrIBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lprrT1gp8Xa3a+aaJYXqUHrGvpZ5Cdc31KsjgHyb365YhwAURtj7AwirBgr1h1Wi9
	 dRiKDrTKH7FWrQMjc0Z0c/c+7qUi8VbR9OAduQCxjpoKo9OQwKENZJBLFAXaKYmFva
	 kpAs/pI1xr0rYXbaSUpe6pCVrldbXbrt0BoVF0bzUw8kAeI/T+dv0/tMzTU+8nwwhH
	 sMFryihceM2eHx76Pv6l8vmZl0rx6flGJnEtm4xUrIiTQbwgRdbjh+GqM2W4ljhX7E
	 B3tp8Hp+D6+NpuEY2AWlLNP/jyOB7skggLYfQ/aoUhSp1cjlQxjbbYaLcRNeNq4yCC
	 LFoX5PvI225hQ==
From: Simon Horman <horms@kernel.org>
To: sbhatta@marvell.com
Cc: Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	lcherian@marvell.com,
	bbhushan2@marvell.com,
	linux-kernel@vger.kernel.org,
	sgoutham@marvell.com,
	gakula@marvell.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com
Subject: Re: [net-next,2/4] octeontx2-af: npa: cn20k: Add DPC support
Date: Wed, 18 Mar 2026 15:20:16 +0000
Message-ID: <20260318152016.1908789-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1773665859-4036-3-git-send-email-sbhatta@marvell.com>
References: <1773665859-4036-3-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-269077-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.961];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 1F3672BE142
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: npa: cn20k: Add DPC support

CN20k introduces 32 diagnostic and performance counters that are shared
across all NPA LFs. Counters being shared, each PF driver need to
request for a counter with the required configuration to the AF, so that
a counter can be allocated and mapped to the respective LF with the
requested configuration. Add new mbox messages, npa_dpc_alloc/free to
handle this. Also ensure all the LF to DPC counter mappings are cleared
at the time of LF free/teardown.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -213,6 +213,10 @@
>  M(NPA_HWCTX_DISABLE,	0x403, npa_hwctx_disable, hwctx_disable_req, msg_rsp)\
>  M(NPA_CN20K_AQ_ENQ,	0x404, npa_cn20k_aq_enq, npa_cn20k_aq_enq_req,	\
>  				npa_cn20k_aq_enq_rsp)			\
> +M(NPA_CN20K_DPC_ALLOC,	0x405, npa_cn20k_dpc_alloc, npa_cn20k_dpc_alloc_req, \
> +				npa_cn20k_dpc_alloc_rsp)		\
> +M(NPA_CN20K_DPC_FREE,	0x406, npa_cn20k_dpc_free, npa_cn20k_dpc_free_req, \
> +				msg_rsp)				\

[ ... ]

> +struct npa_cn20k_dpc_alloc_req {
> +	struct mbox_msghdr hdr;
> +	u16 dpc_conf;
> +};
> +
> +struct npa_cn20k_dpc_alloc_rsp {
> +	struct mbox_msghdr hdr;
> +	u8 cntr_id;
> +};
> +
> +struct npa_cn20k_dpc_free_req {
> +	struct mbox_msghdr hdr;
> +	u8 cntr_id;
> +};

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c

[ ... ]

> +int npa_cn20k_dpc_free(struct rvu *rvu, struct npa_cn20k_dpc_free_req *req)
> +{
> +	struct rvu_hwinfo *hw = rvu->hw;
> +	u16 pcifunc = req->hdr.pcifunc;
> +	int cntr, lf, blkaddr, ridx;
> +	struct rvu_block *block;
> +	struct rvu_pfvf *pfvf;
> +	u64 val, lfmask;
> +
> +	pfvf = rvu_get_pfvf(rvu, pcifunc);
> +
> +	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPA, 0);
> +	if (!pfvf->npalf || blkaddr < 0)
> +		return NPA_AF_ERR_AF_LF_INVALID;
> +
> +	block = &hw->block[blkaddr];
> +	lf = rvu_get_lf(rvu, block, pcifunc, 0);
> +	if (lf < 0)
> +		return NPA_AF_ERR_AF_LF_INVALID;
> +
> +	/* 0 to 63 lfs -> idx 0, 64 - 127 lfs -> idx 1 */
> +	ridx = lf >> 6;
> +	lfmask = BIT_ULL(ridx ? lf - NPA_DPC_LFS_PER_REG : lf);
> +	cntr = req->cntr_id;
> +
> +	ridx = 2 * cntr + ridx;
                         ^^^^

Does this code need bounds checking on req->cntr_id?

The cntr_id field is u8 (range 0-255) and comes from the mbox request
without validation. Looking at npa_cn20k_dpc_alloc():

    cntr = rvu_alloc_rsrc(&rvu->npa_dpc);
    if (cntr < 0)
        return cntr;
    rsp->cntr_id = cntr;

The alloc path returns values bounded by NPA_DPC_MAX (32) through
rvu_alloc_rsrc(). However, the free path directly uses req->cntr_id:

    cntr = req->cntr_id;

    ridx = 2 * cntr + ridx;

When cntr_id >= 64, this causes rvu_free_rsrc() to call
__clear_bit(cntr_id, bmap) where bmap was allocated for only 32 bits:

rvu_npa_init():
    rvu->npa_dpc.max = NPA_DPC_MAX;
    err = rvu_alloc_bitmap(&rvu->npa_dpc);

rvu_alloc_bitmap() allocates BITS_TO_LONGS(32) = 1 long = 64 bits on
64-bit systems. For cntr_id values >= 64, __clear_bit() accesses
bmap[cntr_id/64] which is out of bounds, causing a heap out-of-bounds
write.

The alloc path is protected because find_first_zero_bit() is bounded by
rsrc->max, but rvu_free_rsrc() has no bounds check on the id parameter.

Should npa_cn20k_dpc_free() check cntr_id against NPA_DPC_MAX before
using it?

> +
> +	val = rvu_read64(rvu, blkaddr, NPA_AF_DPC_PERMITX(ridx));
> +	/* Check if the counter is allotted to this LF */
> +	if (!(val & lfmask))
> +		return 0;
> +
> +	/* Revert permission */
> +	val &= ~lfmask;
> +	rvu_write64(rvu, blkaddr, NPA_AF_DPC_PERMITX(ridx), val);
> +
> +	/* Free this counter */
> +	rvu_free_rsrc(&rvu->npa_dpc, req->cntr_id);
> +
> +	return 0;
> +}

[ ... ]

