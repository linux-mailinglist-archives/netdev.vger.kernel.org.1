Return-Path: <netdev+bounces-293273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAx0Fn8DGmrK0ggAu9opvQ
	(envelope-from <netdev+bounces-293273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 23:22:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E08E3608D7B
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 23:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 49A3230320D8
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCC537C906;
	Fri, 29 May 2026 21:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T87l5yZT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8946134F259;
	Fri, 29 May 2026 21:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780089724; cv=none; b=J7hmEsAWPLmN+vixVmpHe7ql+LraqKmwy3XI+3NZIbnut/JDUgNi/y73EkFET7r2rRkLt4+LiXVsCyCF2l+HFbcPcxEyJ5Rx9bRXkJaWZJLoFsvB2RxF5cMhhPUmYskXSI/1ttoVarmXV6LtAx/G2GzPktgdJsu0+simFaOAfoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780089724; c=relaxed/simple;
	bh=Z0Q81DR75ij1BSLIGrbt0bBT/rPWPRp4fN2GHrduizE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MQM5TMkyauFGlnZRlJwOVqVuI9fqQBn9wR4qdOONndc72ss/uBRR5pQSKSq5kltJ3/g5Q37XSoHWmPUAjtHm4lvQsUujgEgSP0KmmjaK2Upm9zVWTGPuWJgJ6s5qnFhrM3jWfuC3W4sNw53yZ8qR2Nchmr5kX8H30uz7dHYiI1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T87l5yZT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856E01F00893;
	Fri, 29 May 2026 21:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780089723;
	bh=R28NUxrfnTMqjPoLnPNaeUgljfTWfMYuYCqLndSjl4E=;
	h=Date:From:To:Cc:Subject;
	b=T87l5yZTVEDtE5QBcQQWIYTtilEICfEGmKthEdQ9FM+sxXs3nmOGqey55LS2qTACL
	 YHdwHYfDj07T1PmZZztCe+kimMm5WrlvgrpnvVzOeUTLORVxERqVb6ivF2GvuAdV+C
	 nLj1X4CnZI9UJuUJcJknc9czhQS2tQoId7QxIyiRY+q56wI7/kYeGD8AB5PzaE9hmB
	 c7HBSNQkHroMJQlCUvFIt+047l4gFB4iS2vISGA5NJnMIvTLLxDqjxobWbfUzjJLA0
	 VxMfMA0bZ3ct0t/F0lCP41q6yjwxfBPJbMNok2DeUEzh8St6ebv85SbtH3yogvDwwR
	 w8xRAMxJvcj6Q==
Date: Fri, 29 May 2026 22:21:58 +0100
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Aditya Garg <gargaditya@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <ahoDdhD_o5iVnr44@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BjKJ4qadb+3Nu2dK"
Content-Disposition: inline
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293273-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E08E3608D7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--BjKJ4qadb+3Nu2dK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/microsoft/mana/mana_en.c

between commit:

  17bfe0a8c014e ("net: mana: Add NULL guards in teardown path to prevent pa=
nic on attach failure")

=66rom the net tree and commit:

  d07efe5a6e641 ("net: mana: Use per-queue allocation for tx_qp to reduce a=
llocation size")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/net/ethernet/microsoft/mana/mana_en.c
index cc48cd06cb15d,c9b1df1ed1098..0000000000000
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@@ -355,9 -355,9 +355,9 @@@ netdev_tx_t mana_start_xmit(struct sk_b
  	if (skb_cow_head(skb, MANA_HEADROOM))
  		goto tx_drop_count;
 =20
 -	txq =3D &apc->tx_qp[txq_idx].txq;
 +	txq =3D &apc->tx_qp[txq_idx]->txq;
  	gdma_sq =3D txq->gdma_sq;
 -	cq =3D &apc->tx_qp[txq_idx].tx_cq;
 +	cq =3D &apc->tx_qp[txq_idx]->tx_cq;
  	tx_stats =3D &txq->stats;
 =20
  	BUILD_BUG_ON(MAX_TX_WQE_SGL_ENTRIES !=3D MANA_MAX_TX_WQE_SGL_ENTRIES);
@@@ -614,7 -614,7 +614,7 @@@ static void mana_get_stats64(struct net
  	}
 =20
  	for (q =3D 0; q < num_queues; q++) {
 -		tx_stats =3D &apc->tx_qp[q].txq.stats;
 +		tx_stats =3D &apc->tx_qp[q]->txq.stats;
 =20
  		do {
  			start =3D u64_stats_fetch_begin(&tx_stats->syncp);
@@@ -685,11 -685,11 +685,11 @@@ void mana_pre_dealloc_rxbufs(struct man
  		put_page(virt_to_head_page(mpc->rxbufs_pre[i]));
  	}
 =20
 -	kfree(mpc->das_pre);
 +	kvfree(mpc->das_pre);
  	mpc->das_pre =3D NULL;
 =20
  out2:
 -	kfree(mpc->rxbufs_pre);
 +	kvfree(mpc->rxbufs_pre);
  	mpc->rxbufs_pre =3D NULL;
 =20
  out1:
@@@ -806,11 -806,11 +806,11 @@@ int mana_pre_alloc_rxbufs(struct mana_p
  	num_rxb =3D num_queues * mpc->rx_queue_size;
 =20
  	WARN(mpc->rxbufs_pre, "mana rxbufs_pre exists\n");
 -	mpc->rxbufs_pre =3D kmalloc_array(num_rxb, sizeof(void *), GFP_KERNEL);
 +	mpc->rxbufs_pre =3D kvmalloc_array(num_rxb, sizeof(void *), GFP_KERNEL);
  	if (!mpc->rxbufs_pre)
  		goto error;
 =20
 -	mpc->das_pre =3D kmalloc_objs(dma_addr_t, num_rxb);
 +	mpc->das_pre =3D kvmalloc_objs(dma_addr_t, num_rxb);
  	if (!mpc->das_pre)
  		goto error;
 =20
@@@ -1262,12 -1262,6 +1262,12 @@@ static int mana_query_vport_cfg(struct=20
 =20
  	*max_sq =3D resp.max_num_sq;
  	*max_rq =3D resp.max_num_rq;
 +
 +	if (*max_sq =3D=3D 0 || *max_rq =3D=3D 0) {
 +		netdev_err(apc->ndev, "Invalid max queues from vPort config\n");
 +		return -EPROTO;
 +	}
 +
  	if (resp.num_indirection_ent > 0 &&
  	    resp.num_indirection_ent <=3D MANA_INDIRECT_TABLE_MAX_SIZE &&
  	    is_power_of_2(resp.num_indirection_ent)) {
@@@ -1282,9 -1276,6 +1282,9 @@@
  	apc->port_handle =3D resp.vport;
  	ether_addr_copy(apc->mac_addr, resp.mac_addr);
 =20
 +	apc->vport_max_sq =3D *max_sq;
 +	apc->vport_max_rq =3D *max_rq;
 +
  	return 0;
  }
 =20
@@@ -1439,11 -1430,6 +1439,11 @@@ static int mana_cfg_vport_steering(stru
 =20
  	netdev_info(ndev, "Configured steering vPort %llu entries %u\n",
  		    apc->port_handle, apc->indir_table_sz);
 +
 +	apc->steer_rx =3D rx;
 +	apc->steer_rss =3D apc->rss_state;
 +	apc->steer_update_tab =3D update_tab;
 +	apc->steer_cqe_coalescing =3D req->cqe_coalescing_enable;
  out:
  	kfree(req);
  	return err;
@@@ -2338,26 -2324,21 +2338,26 @@@ static void mana_destroy_txq(struct man
  		return;
 =20
  	for (i =3D 0; i < apc->num_queues; i++) {
 -		debugfs_remove_recursive(apc->tx_qp[i].mana_tx_debugfs);
 -		apc->tx_qp[i].mana_tx_debugfs =3D NULL;
 +		if (!apc->tx_qp[i])
 +			continue;
 =20
 -		napi =3D &apc->tx_qp[i].tx_cq.napi;
 -		if (apc->tx_qp[i].txq.napi_initialized) {
 +		debugfs_remove_recursive(apc->tx_qp[i]->mana_tx_debugfs);
 +		apc->tx_qp[i]->mana_tx_debugfs =3D NULL;
 +
 +		napi =3D &apc->tx_qp[i]->tx_cq.napi;
 +		if (apc->tx_qp[i]->txq.napi_initialized) {
  			napi_synchronize(napi);
  			napi_disable_locked(napi);
  			netif_napi_del_locked(napi);
 -			apc->tx_qp[i].txq.napi_initialized =3D false;
 +			apc->tx_qp[i]->txq.napi_initialized =3D false;
  		}
 -		mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i].tx_object);
 +		mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i]->tx_object);
 =20
 -		mana_deinit_cq(apc, &apc->tx_qp[i].tx_cq);
 +		mana_deinit_cq(apc, &apc->tx_qp[i]->tx_cq);
 =20
 -		mana_deinit_txq(apc, &apc->tx_qp[i].txq);
 +		mana_deinit_txq(apc, &apc->tx_qp[i]->txq);
 +
 +		kvfree(apc->tx_qp[i]);
  	}
 =20
  	kfree(apc->tx_qp);
@@@ -2366,7 -2347,7 +2366,7 @@@
 =20
  static void mana_create_txq_debugfs(struct mana_port_context *apc, int id=
x)
  {
 -	struct mana_tx_qp *tx_qp =3D &apc->tx_qp[idx];
 +	struct mana_tx_qp *tx_qp =3D apc->tx_qp[idx];
  	char qnum[32];
 =20
  	sprintf(qnum, "TX-%d", idx);
@@@ -2405,7 -2386,7 +2405,7 @@@ static int mana_create_txq(struct mana_
  	int err;
  	int i;
 =20
 -	apc->tx_qp =3D kzalloc_objs(struct mana_tx_qp, apc->num_queues);
 +	apc->tx_qp =3D kzalloc_objs(struct mana_tx_qp *, apc->num_queues);
  	if (!apc->tx_qp)
  		return -ENOMEM;
 =20
@@@ -2425,16 -2406,10 +2425,16 @@@
  	gc =3D gd->gdma_context;
 =20
  	for (i =3D 0; i < apc->num_queues; i++) {
 -		apc->tx_qp[i].tx_object =3D INVALID_MANA_HANDLE;
 +		apc->tx_qp[i] =3D kvzalloc_obj(*apc->tx_qp[i]);
 +		if (!apc->tx_qp[i]) {
 +			err =3D -ENOMEM;
 +			goto out;
 +		}
 +
 +		apc->tx_qp[i]->tx_object =3D INVALID_MANA_HANDLE;
 =20
  		/* Create SQ */
 -		txq =3D &apc->tx_qp[i].txq;
 +		txq =3D &apc->tx_qp[i]->txq;
 =20
  		u64_stats_init(&txq->stats.syncp);
  		txq->ndev =3D net;
@@@ -2452,7 -2427,7 +2452,7 @@@
  			goto out;
 =20
  		/* Create SQ's CQ */
 -		cq =3D &apc->tx_qp[i].tx_cq;
 +		cq =3D &apc->tx_qp[i]->tx_cq;
  		cq->type =3D MANA_CQ_TYPE_TX;
 =20
  		cq->txq =3D txq;
@@@ -2481,7 -2456,7 +2481,7 @@@
 =20
  		err =3D mana_create_wq_obj(apc, apc->port_handle, GDMA_SQ,
  					 &wq_spec, &cq_spec,
 -					 &apc->tx_qp[i].tx_object);
 +					 &apc->tx_qp[i]->tx_object);
 =20
  		if (err)
  			goto out;
@@@ -2584,7 -2559,7 +2584,7 @@@ static void mana_destroy_rxq(struct man
  	if (rxq->gdma_rq)
  		mana_gd_destroy_queue(gc, rxq->gdma_rq);
 =20
 -	kfree(rxq);
 +	kvfree(rxq);
  }
 =20
  static int mana_fill_rx_oob(struct mana_recv_buf_oob *rx_oob, u32 mem_key,
@@@ -2724,7 -2699,7 +2724,7 @@@ static struct mana_rxq *mana_create_rxq
 =20
  	gc =3D gd->gdma_context;
 =20
 -	rxq =3D kzalloc_flex(*rxq, rx_oobs, apc->rx_queue_size);
 +	rxq =3D kvzalloc_flex(*rxq, rx_oobs, apc->rx_queue_size);
  	if (!rxq)
  		return NULL;
 =20
@@@ -3192,23 -3167,6 +3192,23 @@@ static int mana_init_port(struct net_de
  	eth_hw_addr_set(ndev, apc->mac_addr);
  	sprintf(vport, "vport%d", port_idx);
  	apc->mana_port_debugfs =3D debugfs_create_dir(vport, gc->mana_pci_debugf=
s);
 +
 +	debugfs_create_u64("port_handle", 0400, apc->mana_port_debugfs,
 +			   &apc->port_handle);
 +	debugfs_create_u32("max_sq", 0400, apc->mana_port_debugfs,
 +			   &apc->vport_max_sq);
 +	debugfs_create_u32("max_rq", 0400, apc->mana_port_debugfs,
 +			   &apc->vport_max_rq);
 +	debugfs_create_u32("indir_table_sz", 0400, apc->mana_port_debugfs,
 +			   &apc->indir_table_sz);
 +	debugfs_create_u32("steer_rx", 0400, apc->mana_port_debugfs,
 +			   &apc->steer_rx);
 +	debugfs_create_u32("steer_rss", 0400, apc->mana_port_debugfs,
 +			   &apc->steer_rss);
 +	debugfs_create_bool("steer_update_tab", 0400, apc->mana_port_debugfs,
 +			    &apc->steer_update_tab);
 +	debugfs_create_u32("steer_cqe_coalescing", 0400, apc->mana_port_debugfs,
 +			   &apc->steer_cqe_coalescing);
  	debugfs_create_u32("current_speed", 0400, apc->mana_port_debugfs,
  			   &apc->speed);
  	return 0;
@@@ -3338,21 -3296,13 +3338,21 @@@ static int mana_dealloc_queues(struct n
 =20
  	if (apc->tx_qp) {
  		for (i =3D 0; i < apc->num_queues; i++) {
 -			txq =3D &apc->tx_qp[i].txq;
 +			txq =3D &apc->tx_qp[i]->txq;
  			tsleep =3D 1000;
  			while (atomic_read(&txq->pending_sends) > 0 &&
  			       time_before(jiffies, timeout)) {
  				usleep_range(tsleep, tsleep + 1000);
  				tsleep <<=3D 1;
  			}
 +			if (atomic_read(&txq->pending_sends)) {
 +				err =3D pcie_flr(to_pci_dev(gd->gdma_context->dev));
 +				if (err) {
 +					netdev_err(ndev, "flr failed %d with %d pkts pending in txq %u\n",
 +						   err, atomic_read(&txq->pending_sends),
 +						   txq->gdma_txq_id);
 +				}
 +			}
  			if (atomic_read(&txq->pending_sends)) {
  				err =3D
  				    pcie_flr(to_pci_dev(gd->gdma_context->dev));
@@@ -3367,7 -3317,7 +3367,7 @@@
  		}
 =20
  		for (i =3D 0; i < apc->num_queues; i++) {
 -			txq =3D &apc->tx_qp[i].txq;
 +			txq =3D &apc->tx_qp[i]->txq;
  			while ((skb =3D skb_dequeue(&txq->pending_skbs))) {
  				mana_unmap_skb(skb, apc);
  				dev_kfree_skb_any(skb);
@@@ -3746,11 -3696,6 +3746,11 @@@ int mana_probe(struct gdma_dev *gd, boo
  	if (ac->num_ports > MAX_PORTS_IN_MANA_DEV)
  		ac->num_ports =3D MAX_PORTS_IN_MANA_DEV;
 =20
 +	debugfs_create_u16("num_vports", 0400, gc->mana_pci_debugfs,
 +			   &ac->num_ports);
 +	debugfs_create_u8("bm_hostmode", 0400, gc->mana_pci_debugfs,
 +			  &ac->bm_hostmode);
 +
  	ac->per_port_queue_reset_wq =3D
  		create_singlethread_workqueue("mana_per_port_queue_reset_wq");
  	if (!ac->per_port_queue_reset_wq) {
@@@ -3873,11 -3818,6 +3873,11 @@@ void mana_remove(struct gdma_dev *gd, b
 =20
  	mana_gd_deregister_device(gd);
 =20
 +	if (gc->mana_pci_debugfs) {
 +		debugfs_lookup_and_remove("bm_hostmode", gc->mana_pci_debugfs);
 +		debugfs_lookup_and_remove("num_vports", gc->mana_pci_debugfs);
 +	}
 +
  	if (suspending)
  		return;
 =20

--BjKJ4qadb+3Nu2dK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoaA3YACgkQJNaLcl1U
h9DncAf+IuTvoiRF/DwyJ730PWJw3YdsUgN+EA96MLbozWCFQ5REr3QP6f+APdxR
+3XEm4NMSYCTt5nsacSRClR6AzKduWrfZxxau/bLEWBa5CwRgOUp7s1xOIQG20Of
hFLq5ed6dfxnOXR4eAK4/wwY0ErRBTjc0kOnXR3hf5huxmVgNUeJd25Ahjm9ABGQ
OIT2VySbReMaccieG5TfCD7thXAAZ++7nnTHbNnTASobtxzwKE/HyHS6MtlIko+y
b/kjmKIcPWYAfSS4kuYxzwHxH/7X83ArSOvVzMPayH6mCkC7fN7qkuEWBwDxYiM6
eb+UKu8jQQmV/Q72Co9scpUrBfvxGg==
=pWsu
-----END PGP SIGNATURE-----

--BjKJ4qadb+3Nu2dK--

