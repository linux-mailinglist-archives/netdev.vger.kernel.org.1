Return-Path: <netdev+bounces-285859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHkMMejw/WlJkwAAu9opvQ
	(envelope-from <netdev+bounces-285859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:19:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2214D4F79EA
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 354273015732
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 14:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931C03E7148;
	Fri,  8 May 2026 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbMfbNRl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703971397;
	Fri,  8 May 2026 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778249957; cv=none; b=sUTYcVmPKuiOHvs1HIrWYg2+eZB/A2hS0vesHRe9Zlo2fYkJJUtXw4xOApkyWjPBuA+EZ5hxNfEImjwMGQRtmKZ0KM3sIrr7jZbxyuJcVcxhgajS+4gqKAqPCDLqWTou2gKXFfGMSo9+8IeadQP16N96EJKlrUr/Pg3CfvJrfJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778249957; c=relaxed/simple;
	bh=U43IRTUeEFC+y+FoudadK4oeMVSSy37ArbZ6hs+eIIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2KFoh3mxpKVJM0kM80GuvKS1WL2hEYZ2wmkqFaHQxSTomtUYfj50Iezsa4MgKHO18BzL8+sPrHQbLxJDZE/3/iDqjo2LiNRY8ImPmimNJqAmjJoPKhkW3POCebPCtjqqejs5pSQV4RLRaFSwdenSUIFv1BcxT8yLFlVCwOxUa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbMfbNRl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD2DC2BCB0;
	Fri,  8 May 2026 14:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778249957;
	bh=U43IRTUeEFC+y+FoudadK4oeMVSSy37ArbZ6hs+eIIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WbMfbNRlW4bsPoDerwDHrarui7U8wGbbxQ/K0zs9bmR8aVX/jqJd8oEO1ysnxjkEy
	 5hd3J2tsn4+H0lzT3g28Xh2RQiiBgjHZf5ZnZ3h5W8dlipS/D/aGdZhHnQPJxVJWyl
	 mU5T/XlfoWpwzkpkykOGwiXL80H5MZtCN3TLIZ15qtZFyH2kkS4QMoAfFkrInx55wY
	 LXFRNG924FoItItZDkqfvp5MH6K6KiOHks0OlZYIh/lHzq4v0wyHKGnICDAdIRzUqK
	 k4an71xacgInraN530QG29cnc3Q08c0iWCdVCgBFRhM2LWZAQAQ2hgEKwO4L1E29vD
	 i0EVNe5UfkRnw==
From: Simon Horman <horms@kernel.org>
To: aleksander.lobakin@intel.com
Cc: 'Simon Horman' <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kohei@enjuk.jp,
	jacob.e.keller@intel.com,
	aleksandr.loktionov@intel.com,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5 4/5] ice: implement Rx queue management ops
Date: Fri,  8 May 2026 15:08:00 +0100
Message-ID: <20260508140758.1200568-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505152923.1040589-5-aleksander.lobakin@intel.com>
References: <20260505152923.1040589-5-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2214D4F79EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-285859-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ice: implement Rx queue management ops

This commit wires the ice driver into the netdev queue management ops
framework, reusing the existing per-queue disable/reconfig/enable paths
originally added for XSk. With it, ice reportedly passes the io_uring
zcrx selftests.

> diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
> index 1add82d894bb..4e0b8895c303 100644
> --- a/drivers/net/ethernet/intel/ice/ice_base.c
> +++ b/drivers/net/ethernet/intel/ice/ice_base.c

[ ... ]

> @@ -1577,3 +1593,81 @@ int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
>
>  	return fail;
>  }
> +
> +/**
> + * ice_qp_ena - Enables a queue pair
> + * @vsi: VSI of interest
> + * @q_idx: ring index in array
> + *
> + * Returns 0 on success, negative on failure.
> + */
> +int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
> +{
> +	return __ice_qp_ena(vsi, q_idx, ice_vsi_cfg_single_rxq(vsi, q_idx));
> +}
> +
> +static int ice_queue_start(struct net_device *dev,
> +			   struct netdev_queue_config *qcfg,
> +			   void *per_queue_mem, int idx)
> +{
> +	const struct ice_netdev_priv *priv = netdev_priv(dev);
> +	struct ice_rx_ring *real = priv->vsi->rx_rings[idx];
> +	struct ice_rx_ring *new = per_queue_mem;
> +	struct napi_struct *napi;
> +	int ret;
> +
> +	real->pp = new->pp;
> +	real->rx_fqes = new->rx_fqes;
> +	real->hdr_fqes = new->hdr_fqes;
> +	real->hdr_pp = new->hdr_pp;
> +
> +	real->hdr_truesize = new->hdr_truesize;
> +	real->truesize = new->truesize;
> +	real->rx_hdr_len = new->rx_hdr_len;
> +	real->rx_buf_len = new->rx_buf_len;
> +
> +	memcpy(&real->xdp_rxq, &new->xdp_rxq, sizeof(new->xdp_rxq));
> +
> +	ret = ice_setup_rx_ctx(real);
> +	if (ret)
> +		return ret;

Simon says: I believe that the issue flagged immediately below is
            a false positive; the cleanup logic unwinds things correctly.

	    However, the two other issues flagged further down do seem to be
	    of concern.

ice_queue_start() eagerly copies new->pp, new->rx_fqes, new->hdr_pp,
new->hdr_fqes and the entire new->xdp_rxq into real before ice_setup_rx_ctx()
has succeeded.

If ice_setup_rx_ctx() returns an error here, the function bails out with
real already pointing at new_mem's page pools and fqes arrays.

The core netdev_rx_queue_reconfig() rollback then invokes
ndo_queue_start(dev, qcfg_old, old_mem, rxq_idx), which repeats the same
eager overwrite using old_mem and calls ice_setup_rx_ctx() again.  If the
second ice_setup_rx_ctx() also fails, the core proceeds to
ndo_queue_mem_free(dev, old_mem), and ice_queue_mem_free() will tear down
the page pools whose pointers real->pp / real->hdr_pp are still aliasing.

Would it be safer to stash the existing real->pp / real->rx_fqes /
real->hdr_pp / real->hdr_fqes / real->xdp_rxq on entry and restore them if
ice_setup_rx_ctx() fails, so that a failed rollback cannot leave real with
dangling pointers to a pool that ice_queue_mem_free() is about to destroy?

> +
> +	napi = &real->q_vector->napi;
> +
> +	page_pool_enable_direct_recycling(real->pp, napi);
> +	if (real->hdr_pp)
> +		page_pool_enable_direct_recycling(real->hdr_pp, napi);
> +
> +	ret = ice_alloc_rx_bufs(real, ICE_DESC_UNUSED(real));
> +
> +	return __ice_qp_ena(priv->vsi, idx, ret);

ice_alloc_rx_bufs() is declared bool and returns !!cleaned_count, so it
yields 0 on full success and 1 on partial/failed allocation:

bool ice_alloc_rx_bufs(struct ice_rx_ring *rx_ring, unsigned int cleaned_count)
{
    ...
    return !!cleaned_count;
}

That bool is then passed straight into __ice_qp_ena()'s fail parameter,
which only overwrites fail via 'if (!fail) fail = err;', so a value of 1
propagates unchanged to ice_queue_start()'s return value.

netdev_rx_queue_reconfig() treats any non-zero return as failure and
propagates it back to userspace (netlink, ethtool, io_uring zcrx install),
where the callers expect a negative errno.

Before this patch, ice_qp_ena() obtained its fail value from
ice_vsi_cfg_single_rxq(), which returns a signed errno.

Should this be converted to a proper negative errno before being handed
to __ice_qp_ena(), for example:

	ret = ice_alloc_rx_bufs(real, ICE_DESC_UNUSED(real)) ? -ENOMEM : 0;

> +}
> +
> +static int ice_queue_stop(struct net_device *dev, void *per_queue_mem,
> +			  int idx)
> +{
> +	const struct ice_netdev_priv *priv = netdev_priv(dev);
> +	struct ice_rx_ring *real = priv->vsi->rx_rings[idx];
> +	int ret;
> +
> +	ret = __ice_qp_dis(priv->vsi, idx);
> +	if (ret)
> +		return ret;
> +
> +	page_pool_disable_direct_recycling(real->pp);
> +	if (real->hdr_pp)
> +		page_pool_disable_direct_recycling(real->hdr_pp);
> +
> +	ice_zero_rx_ring(real);
> +	memcpy(per_queue_mem, real, sizeof(*real));
> +
> +	return 0;
> +}

Can this leak inflight page pool buffers?

ice_zero_rx_ring(real) is called before the memcpy to per_queue_mem, and
ice_zero_rx_ring() resets both indices:

void ice_zero_rx_ring(struct ice_rx_ring *rx_ring)
{
    ...
    rx_ring->next_to_clean = 0;
    rx_ring->next_to_use = 0;
}

So per_queue_mem captures a ring where next_to_clean == next_to_use == 0.

The core then invokes ndo_queue_mem_free(dev, old_mem), and the recycle
loop in ice_queue_mem_free() is guarded by exactly those two indices:

void ice_queue_mem_free(struct net_device *dev, void *per_queue_mem)
{
    ...
    for (u32 i = rx_ring->next_to_clean; i != rx_ring->next_to_use; ) {
        libeth_rx_recycle_slow(rx_ring->rx_fqes[i].netmem);

        if (rx_ring->hdr_pp)
            libeth_rx_recycle_slow(rx_ring->hdr_fqes[i].netmem);

        if (unlikely(++i == rx_ring->count))
            i = 0;
    }
    ...
    ice_rxq_pp_destroy(rx_ring);
}

With 0 != 0 false on entry, the loop never runs, so any buffers that were
in rx_fqes[old_ntc..old_ntu) (and hdr_fqes[] when header split is on) are
never returned via libeth_rx_recycle_slow().  ice_rxq_pp_destroy() then
kvfree()s the fqes arrays and calls page_pool_destroy() with outstanding
inflight references that are no longer tracked anywhere.

The new ice_clean_rx_ring() wrapper keeps the original ordering:

void ice_clean_rx_ring(struct ice_rx_ring *rx_ring)
{
    ice_queue_mem_free(rx_ring->netdev, rx_ring);
    ice_zero_rx_ring(rx_ring);
}

Should ice_queue_stop() follow the same ordering and perform the memcpy
before ice_zero_rx_ring(real), so the recycle loop in ice_queue_mem_free()
sees the real ntc/ntu values?

> +
> +const struct netdev_queue_mgmt_ops ice_queue_mgmt_ops = {
> +	.ndo_queue_mem_alloc	= ice_queue_mem_alloc,
> +	.ndo_queue_mem_free	= ice_queue_mem_free,
> +	.ndo_queue_mem_size	= sizeof(struct ice_rx_ring),
> +	.ndo_queue_start	= ice_queue_start,
> +	.ndo_queue_stop		= ice_queue_stop,
> +};

[ ... ]

