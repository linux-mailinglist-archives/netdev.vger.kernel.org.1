Return-Path: <netdev+bounces-279670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id davHFN3T5WnEoQEAu9opvQ
	(envelope-from <netdev+bounces-279670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 09:21:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4028427AB6
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 09:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D22EE300D72B
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 07:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50AC3783C4;
	Mon, 20 Apr 2026 07:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwBbCURP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2582296BCF
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 07:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776669655; cv=none; b=tABM7Ew0G0vQLtC6IjL8eNwozsE0bkFpvZs180i/vA1x/zS6R+lTYQCkbF99lVHbnghbU/g3szk+I+T29BC8/ue/MXAeNg00WlPsQPvNys0dOUY1LzMR1pwq6ktaFLA4p4mSmQErPL4x/igj6rMuktpJCF8HuqQQgqnQkfchOy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776669655; c=relaxed/simple;
	bh=xDlIjLHGAoKn1DuIwoxmC7n5/0GRJIGPQDQkQQ26XZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UR4U463HZbWX6DJxjO32sGtEodCqv24gVcyWWw6415gdscdi2Vk1Ac7KPv3fWeENWG2/PkrWK+pZ+CxjgBiDt/Wx1+Jzc1711hDTWiSYfk6s5jY0r4RKtWTHbNM3mRcOtsQftamGoPRLUO7Gkv3DAQwVfnoQDru7J6j8yqe2UfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwBbCURP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2C9C2BCB3;
	Mon, 20 Apr 2026 07:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776669655;
	bh=xDlIjLHGAoKn1DuIwoxmC7n5/0GRJIGPQDQkQQ26XZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MwBbCURPXqrGD6Y9j2/rkAyKYBLYphz6v41HmH9c6GV+aaRSMss4KU8Q3FV+eqRa9
	 ZaDhMZVhnEQY6Krjb27xW9ttVH9l7L5S8vwUV86/2OxShpWcPfJBNw28pnJaKwU2IT
	 OhC6cNZ5MSLAcaw9exOeYtEzW/W3VYFlo4LJVCj3BGRZww444U/4eDuOotLsIGi3mU
	 uG4XO543jLui8+8Mp/8WDGFXUmEK4Njy4Pp3akJcrVaihWCslAP+4uQOQFsJKVEMUH
	 X2+DIODPqdv1bos6WYTZMrDxZf1BTXzcC8m84zKAwSXHhHL/k2QuiOQ2gQxsi4UJ1U
	 DqWLw8ACbUeUw==
Date: Mon, 20 Apr 2026 08:20:50 +0100
From: Simon Horman <horms@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	magnus.karlsson@intel.com, kuba@kernel.org, pabeni@redhat.com,
	przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com
Subject: Re: [PATCH v2 iwl-net] i40e: keep q_vectors array in sync with
 channel count changes
Message-ID: <20260420072050.GP280379@horms.kernel.org>
References: <20260416114046.642171-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416114046.642171-1-maciej.fijalkowski@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-279670-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,napi_threaded.py:url]
X-Rspamd-Queue-Id: B4028427AB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 01:40:46PM +0200, Maciej Fijalkowski wrote:
> For the main VSI, i40e_set_num_rings_in_vsi() always derives
> num_q_vectors from pf->num_lan_msix. At the same time, ethtool -L stores
> the user requested channel count in vsi->req_queue_pairs and the queue
> setup path uses that value for the effective number of queue pairs.
> 
> This leaves queue and vector counts out of sync after shrinking channel
> count via ethtool -L. The active queue configuration is reduced, but the
> VSI still keeps the full PF-sized q_vector topology.
> 
> That mismatch breaks reconfiguration flows which rely on vector/NAPI
> state matching the effective channel configuration. In particular,
> toggling /sys/class/net/<dev>/threaded after reducing the channel count
> can hang, and later channel-count changes can fail because VSI reinit
> does not rebuild q_vectors to match the new vector count.
> 
> Fix this by making the main VSI num_q_vectors follow the effective
> requested channel count, capped by the available MSI-X vectors. Update
> i40e_vsi_reinit_setup() to rebuild q_vectors during VSI reinit so the
> vector topology is refreshed together with the ring arrays when channel
> count changes.
> 
> Keep alloc_queue_pairs unchanged and based on pf->num_lan_qps so the VSI
> retains its full queue capacity.
> 
> Selftest napi_threaded.py was originally used when Jakub reported hang
> on /sys/class/net/<dev>/threaded toggle. In order to make it pass on
> i40e, use persistent NAPI configuration for q_vector NAPIs so NAPI
> identity and threaded settings survive q_vector reallocation across
> channel-count changes. This is achieved by using netif_napi_add_config()
> when configuring q_vectors.
> 
> $ export NETIF=ens259f1np1
> $ sudo -E env PATH="$PATH" ./tools/testing/selftests/drivers/net/napi_threaded.py
> TAP version 13
> 1..3
> ok 1 napi_threaded.napi_init
> ok 2 napi_threaded.change_num_queues
> ok 3 napi_threaded.enable_dev_threaded_disable_napi_threaded
> Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/intel-wired-lan/20260316133100.6054a11f@kernel.org/
> Fixes: d2a69fefd756 ("i40e: Fix changing previously set num_queue_pairs for PFs")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
> v2:
> - NULL vsi->tx_rings in i40e_vsi_alloc_arrays() (Sashiko)

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 35 +++++++++++++++++----
>  1 file changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 926d001b2150..1d2a4181966f 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -11403,10 +11403,14 @@ static void i40e_service_timer(struct timer_list *t)
>  static int i40e_set_num_rings_in_vsi(struct i40e_vsi *vsi)
>  {
>  	struct i40e_pf *pf = vsi->back;
> +	u16 qps;
>  
>  	switch (vsi->type) {
>  	case I40E_VSI_MAIN:
>  		vsi->alloc_queue_pairs = pf->num_lan_qps;
> +		qps = vsi->req_queue_pairs ?
> +		      min_t(u16, vsi->req_queue_pairs, pf->num_lan_qps) :

nit: It looks all the variables involved here u16.
     So min() can be used instead of min_t().

> +		      pf->num_lan_qps;
>  		if (!vsi->num_tx_desc)
>  			vsi->num_tx_desc = ALIGN(I40E_DEFAULT_NUM_DESCRIPTORS,
>  						 I40E_REQ_DESCRIPTOR_MULTIPLE);
> @@ -11414,7 +11418,8 @@ static int i40e_set_num_rings_in_vsi(struct i40e_vsi *vsi)
>  			vsi->num_rx_desc = ALIGN(I40E_DEFAULT_NUM_DESCRIPTORS,
>  						 I40E_REQ_DESCRIPTOR_MULTIPLE);
>  		if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags))
> -			vsi->num_q_vectors = pf->num_lan_msix;
> +			vsi->num_q_vectors = max_t(int, 1,
> +						   min_t(int, qps, pf->num_lan_msix));

nit: On the left side, all values seem to be either constants or u16.
     So I think you can use clamp() here, and simply assign the resulting
     value to num_q_vectors, which is an int.

>  		else
>  			vsi->num_q_vectors = 1;
>  

...

> @@ -14265,12 +14272,27 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
>  
>  	pf = vsi->back;
>  
> +	if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags)) {
> +		i40e_put_lump(pf->irq_pile, vsi->base_vector, vsi->idx);
> +		vsi->base_vector = 0;
> +	}
> +
>  	i40e_put_lump(pf->qp_pile, vsi->base_queue, vsi->idx);
>  	i40e_vsi_clear_rings(vsi);
>  
> -	i40e_vsi_free_arrays(vsi, false);
> +	i40e_vsi_free_q_vectors(vsi);
> +	i40e_vsi_free_arrays(vsi, true);

nit: with this patch applied the free_vectors argument (the 2nd parameter)
     of i40e_vsi_free_arrays is always passed as true by callers.
     So I think that, as a follow-up, it can be removed.

     Similarly for i40e_vsi_alloc_arrays.

>  	i40e_set_num_rings_in_vsi(vsi);
> -	ret = i40e_vsi_alloc_arrays(vsi, false);
> +
> +	ret = i40e_vsi_alloc_arrays(vsi, true);
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
>  

...

