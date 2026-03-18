Return-Path: <netdev+bounces-269073-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G4FIN3Fumk8bwIAu9opvQ
	(envelope-from <netdev+bounces-269073-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:33:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD862BE4B7
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A14A31D1473
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D253E123D;
	Wed, 18 Mar 2026 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHaAI+WH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE4F3D6CA3;
	Wed, 18 Mar 2026 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846404; cv=none; b=fG5qhlRuazvzWVW9x1Z05FRQ7SWlGEmW59BPdda9QxukakfkS5jk+lAy0xsc+a+nglqKgZF0Sk9G/Mz7bEl5grLbNwphSKznfnwcer4z5kC1Zle8CoUUy6ZTyz6EDaGryU6CA3Kf2o1p3KdQkFeCwrRIdxYg5IWmVNzcE27Wa1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846404; c=relaxed/simple;
	bh=0e0eOce6zy/L0Xth/VK/97Y1TpGLZR5R3S/mz0gyweo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBoxZ128Y1yefiUrDJASfmKi4DgdBmBulns1n0YnudA98Q7djvSMYRFRW96j7FjTVDjCAliBV3tMcR4Ak78/zftyM82EW9iq2XGVnhrOjhNDRK/2nXAOg+t1KtOh1cjw5GNVrRBCV3BekEAdf/vG8EujSCmvpNdiQLUuZCB6+Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHaAI+WH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7995C19421;
	Wed, 18 Mar 2026 15:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773846404;
	bh=0e0eOce6zy/L0Xth/VK/97Y1TpGLZR5R3S/mz0gyweo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BHaAI+WHo1t/9xNdkkeVipmjROMznISqaqXUhPpTdYlJJVpu2sEhGHiJ47hcuaaNP
	 Dhi936gq5MJ1IKdEKndSG68uxYyvOhSYeQys+d0O0K2E1y1v6YgpaXmS+R3rkOZOnH
	 WGS75ua/lV9G5mGx3jlAA5I4I9r29Ng4FjqCn61Bi6ucfNxJcfG/cupgH8wBJsFLtn
	 5OO/8qRQVGB+NEYymJw7CC+VLKuG1chD5cg+cekS0JYSGw3PdbD5UeBYUOTbqOG8Q3
	 v0EcvTDPLe6FpCbKZ5P1bWwWaUFLzc98ZjjJO3Cy1HAKRbW8YgLupg5Nyr+aeOWwKL
	 Tia1zuT/izy7g==
From: Simon Horman <horms@kernel.org>
To: sbhatta@marvell.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	gakula@marvell.com,
	bbhushan2@marvell.com,
	sgoutham@marvell.com,
	pabeni@redhat.com,
	lcherian@marvell.com,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	kuba@kernel.org,
	davem@davemloft.net
Subject: Re: [net-next,4/4] octeontx2-pf: cn20k: Use unified Halo context
Date: Wed, 18 Mar 2026 15:06:21 +0000
Message-ID: <20260318150621.1905126-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1773665859-4036-5-git-send-email-sbhatta@marvell.com>
References: <1773665859-4036-5-git-send-email-sbhatta@marvell.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-269073-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.976];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EBD862BE4B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-pf: cn20k: Use unified Halo context

Use unified Halo context present in CN20K hardware for
octeontx2 netdevs instead of aura and pool contexts.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
> index a5a8f4558717..db2742588bf6 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c

[ ... ]

> +int cn20k_npa_alloc_dpc(struct otx2_nic *nic)
> +{
> +	struct npa_cn20k_dpc_alloc_req *req;
> +	struct npa_cn20k_dpc_alloc_rsp *rsp;
> +	int err;
> +
> +	req = otx2_mbox_alloc_msg_npa_cn20k_dpc_alloc(&nic->mbox);
> +	if (!req)
> +		return -ENOMEM;
> +
> +	/* Count successful ALLOC requests only */
> +	req->dpc_conf = 1ULL << 4;
> +
> +	err = otx2_sync_mbox_msg(&nic->mbox);
> +	if (err)
> +		return err;
> +
> +	rsp = (struct npa_cn20k_dpc_alloc_rsp *)otx2_mbox_get_rsp(&nic->mbox.mbox,
> +								  0, &req->hdr);
> +
> +	nic->npa_dpc = rsp->cntr_id;
                       ^^^^

Can this dereference crash?  The otx2_mbox_get_rsp() call can return
ERR_PTR(-ENODEV) on error.  In mbox.c, otx2_mbox_get_rsp() returns an error
pointer if there's a message count mismatch or ID mismatch:

drivers/net/ethernet/marvell/octeontx2/af/mbox.c:otx2_mbox_get_rsp() {
    ...
    if (!mbox->dev->msgs_acked)
        return ERR_PTR(-ENODEV);
    ...
    if (msgs_acked != 1)
        return ERR_PTR(-ENODEV);
    ...
}

Every other caller of otx2_mbox_get_rsp() in this driver checks IS_ERR()
before dereferencing:

drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c:cn10k_alloc_leaf_profile() {
    ...
    rsp = (struct nix_bandprof_get_hwinfo_rsp *)
          otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
    if (IS_ERR(rsp))
        return PTR_ERR(rsp);
    ...
}

drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c:__cn20k_tc_alloc_entry() {
    ...
    rsp = (struct npc_mcam_alloc_entry_rsp *)otx2_mbox_get_rsp(...);
    if (IS_ERR(rsp))
        return PTR_ERR(rsp);
    ...
}

drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:otx2_alloc_mcam_entries() {
    ...
    rsp = (struct npc_mcam_alloc_entry_rsp *)otx2_mbox_get_rsp(...);
    if (IS_ERR(rsp)) {
        ...
        return PTR_ERR(rsp);
    }
    ...
}

> +
> +	return 0;
> +}
> +
> +int cn20k_npa_free_dpc(struct otx2_nic *nic)
> +{
> +	struct npa_cn20k_dpc_free_req *req;
> +	int err;
> +
> +	req = otx2_mbox_alloc_msg_npa_cn20k_dpc_free(&nic->mbox);
> +	if (!req)
> +		return -ENOMEM;
> +
> +	req->cntr_id = nic->npa_dpc;
> +
> +	err = otx2_sync_mbox_msg(&nic->mbox);
> +
> +	return err;
> +}

Does this need the mbox lock?  Every other function in
otx2_free_hw_resources() that performs mbox operations acquires the
mbox lock.

For example, otx2_ctx_disable() does:

drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:otx2_ctx_disable() {
    ...
    mutex_lock(&mbox->lock);
    if (nixlf) {
        ...
        otx2_sync_mbox_msg(mbox);
    }
    ...
    mutex_unlock(&mbox->lock);
}

And cn10k_free_all_ipolicers() does:

drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c:cn10k_free_all_ipolicers() {
    ...
    mutex_lock(&pfvf->mbox.lock);
    ...
    otx2_sync_mbox_msg(&pfvf->mbox);
    mutex_unlock(&pfvf->mbox.lock);
}

In contrast, cn20k_npa_alloc_dpc() is called from otx2_init_hw_resources()
under the mbox lock:

drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:otx2_init_hw_resources() {
    ...
    mutex_lock(&pf->mbox.lock);
    ...
    if (is_cn20k(pf->pdev))
        cn20k_npa_alloc_dpc(pf);
    ...
    mutex_unlock(&pf->mbox.lock);
}

Without the lock here in cn20k_npa_free_dpc(), could concurrent mbox access
from VF mbox forwarding corrupt the shared mbox buffer?  VF mbox forwarding
runs from the mbox_pfvf_wq workqueue via otx2_forward_vf_mbox_msgs().

[ ... ]

