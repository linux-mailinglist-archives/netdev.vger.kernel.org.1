Return-Path: <netdev+bounces-295004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wfFhOdTUIGou8QAAu9opvQ
	(envelope-from <netdev+bounces-295004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 03:28:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B3D63C328
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 03:28:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iwtmN91e;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295004-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295004-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 690293017078
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 01:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FBE26A08A;
	Thu,  4 Jun 2026 01:28:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAE5261B8A
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 01:28:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780536530; cv=none; b=bBWzHHziSEAnIOWA8gxSFH3KkYkWExax/CewnjSut2HP1OTeup8HEM7MydMwx2vHhRX/e1zHoChSbaN0cXIOtJH4SZ6dRNw4nYywlhZb1qsrXmZXwPyedyLB8V+nUan57ZCnlLjXZlWr6MyGTVpDYBbqztgs9STcD1/54R5k5Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780536530; c=relaxed/simple;
	bh=XXJTN921D0Qg9yGJo6SUNIWvKkw1jd+xe9XAptilOp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7MFtI0MVEpPQaVIyhzsbAM4xNvQSuh8SD1s1xum9oxSYt4ucrVGtya2cFkRaVEcmZOFX8TrwcdIRF9oEKnpVgENcZ/yhloGd6Qltwu899KzoS3TSxVioM6hvVQN6ZFgEG6NezQKiJQzgUK4D4OT3kJQ4lbI7cAhh6TXr+XplXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwtmN91e; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7961F00893;
	Thu,  4 Jun 2026 01:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780536529;
	bh=rxYTPom1nJe5E4NoXek/uQYMSFFi5c325tRy+4t3r7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iwtmN91eZHYuv1L4x7e3wvFn8TvJ22IUIxFdbLZwARFqF7iQeU5qqiJd9SEJTYnit
	 aaJf+Cg49FjjGYwfpMbSVlSldvDFJ8g0A/7KIqqPmb877Ok3GoBwHNR8dVhu/ThMkk
	 SJSPTWBrvYP8odRTw7NVFoaHOle2ec+wXmjltjeyaf0o56/TPDyL2gnqMtbtNW3xk5
	 Ops3H/xaihNcSXjbCNBVcTtvSANFU6s/uGJhriVmDVEXe/u465aAPDoBjUhA9BYp4F
	 rt8rQdMN77qfJKEwPKf+LjszOgqM5XxxSt3cSYlkSeRz0UaK9wnwOUX2OM4qtz3TlU
	 /Qk/4F8GHYGkQ==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	poros@redhat.com,
	arkadiusz.kubalewski@intel.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	aleksandr.loktionov@intel.com,
	pmenzel@molgen.mpg.de,
	sx.rinitha@intel.com
Subject: Re: [PATCH net 1/3] i40e: keep q_vectors array in sync with channel count changes
Date: Wed,  3 Jun 2026 18:27:07 -0700
Message-ID: <20260604012707.2843206-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602225513.393338-2-anthony.l.nguyen@intel.com>
References: <20260602225513.393338-2-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:kuba@kernel.org,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:poros@redhat.com,m:arkadiusz.kubalewski@intel.com,m:przemyslaw.kitszel@intel.com,m:horms@kernel.org,m:aleksandr.loktionov@intel.com,m:pmenzel@molgen.mpg.de,m:sx.rinitha@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295004-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63B3D63C328

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
i40e: keep q_vectors array in sync with channel count changes

This patch makes the main VSI's num_q_vectors track the effective
requested channel count and rebuilds q_vectors during VSI reinit so the
vector topology is refreshed together with the ring arrays. It also
switches to netif_napi_add_config() so NAPI identity survives q_vector
reallocation across channel-count changes.

Link: https://lore.kernel.org/intel-wired-lan/20260316133100.6054a11f@kernel.org/

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 6d4f9218dc68..c3fbe14ff2d3 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c

[ ... ]

> @@ -14264,12 +14264,26 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
>  
>  	pf = vsi->back;
>  
> +	if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags)) {
> +		i40e_put_lump(pf->irq_pile, vsi->base_vector, vsi->idx);
> +		vsi->base_vector = 0;
> +	}
> +
>  	i40e_put_lump(pf->qp_pile, vsi->base_queue, vsi->idx);
> +	i40e_vsi_free_q_vectors(vsi);
>  	i40e_vsi_clear_rings(vsi);
> +	i40e_vsi_free_arrays(vsi);
>  
> -	i40e_vsi_free_arrays(vsi, false);
>  	i40e_set_num_rings_in_vsi(vsi);
> -	ret = i40e_vsi_alloc_arrays(vsi, false);
> +	ret = i40e_vsi_alloc_arrays(vsi);
> +	if (ret)
> +		goto err_vsi;
> +
> +	/* Rebuild q_vectors during VSI reinit because the effective channel
> +	 * count may change num_q_vectors. Keep vector topology aligned with the
> +	 * queue configuration after ethtool's .set_channels() callback.
> +	 */
> +	ret = i40e_vsi_setup_vectors(vsi);
>  	if (ret)
>  		goto err_vsi;

[High]
Can the err_vsi path here cause a use-after-free of vsi via netdev_priv?

Reinit is invoked from i40e_rebuild() -> i40e_setup_pf_switch(pf, true,
...) on an already-registered netdev (vsi->netdev_registered == true),
and struct i40e_netdev_priv keeps a pointer at the vsi. The err_vsi
label only calls i40e_vsi_clear() which kfrees the vsi without
unregistering vsi->netdev, destroying the devlink port, or deleting
the FW VSI element:

drivers/net/ethernet/intel/i40e/i40e_main.c:i40e_vsi_clear() {
    ...
    i40e_put_lump(pf->qp_pile, vsi->base_queue, vsi->idx);
    i40e_put_lump(pf->irq_pile, vsi->base_vector, vsi->idx);

    bitmap_free(vsi->af_xdp_zc_qps);
    i40e_vsi_free_arrays(vsi);
    i40e_clear_rss_config_user(vsi);
    ...
    kfree(vsi);
    ...
}

If i40e_vsi_alloc_arrays() or the newly added i40e_vsi_setup_vectors()
fails (e.g. kzalloc of q_vectors, kzalloc of an individual q_vector,
or i40e_get_lump(irq_pile)), would a subsequent ndo_* callback on the
still-registered netdev dereference the freed vsi through
netdev_priv()?

Two new failure points the patch routes into err_vsi were not reachable
before: the unconditional q_vectors kzalloc in i40e_vsi_alloc_arrays()
and the entire i40e_vsi_setup_vectors() call.

> @@ -14281,7 +14295,7 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
>  		dev_info(&pf->pdev->dev,
>  			 "failed to get tracking for %d queues for VSI %d err %d\n",
>  			 alloc_queue_pairs, vsi->seid, ret);
> -		goto err_vsi;
> +		goto err_lump;
>  	}
>  	vsi->base_queue = ret;
>  
> @@ -14305,7 +14319,6 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
>  	return vsi;
>  
>  err_rings:
> -	i40e_vsi_free_q_vectors(vsi);
>  	if (vsi->netdev_registered) {
>  		vsi->netdev_registered = false;
>  		unregister_netdev(vsi->netdev);
> @@ -14315,6 +14328,8 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
>  	if (vsi->type == I40E_VSI_MAIN)
>  		i40e_devlink_destroy_port(pf);
>  	i40e_aq_delete_element(&pf->hw, vsi->seid, NULL);
> +err_lump:
> +	i40e_vsi_free_q_vectors(vsi);
>  err_vsi:
>  	i40e_vsi_clear(vsi);
>  	return NULL;

Should the new err_lump label, and the existing err_vsi exits from the
two allocation steps above, instead unwind through the err_rings block
(unregister_netdev / free_netdev / i40e_devlink_destroy_port /
i40e_aq_delete_element) the way i40e_vsi_setup()'s err_msix path does?

The pre-patch code had the same defective err_vsi target for the
qp_pile and arrays paths, but the patch adds two new failure points
(the unconditional q_vectors kzalloc and the new
i40e_vsi_setup_vectors() call) that route into it during reset
rebuild, where vsi->netdev is already registered.

