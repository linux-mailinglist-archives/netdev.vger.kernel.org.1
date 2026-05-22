Return-Path: <netdev+bounces-290854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGN5A/hjEGrvWwYAu9opvQ
	(envelope-from <netdev+bounces-290854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:11:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B63F5B5E87
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92F68301947F
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 14:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB0139D3D4;
	Fri, 22 May 2026 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlk4fkF4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAAC39D3C1;
	Fri, 22 May 2026 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779458587; cv=none; b=l2PrpDtd6t4Pvlk126cD1raT/6RM8IBSV3yIDeaK5bgZIsTLtV5iBbQI3ZBpb2gyQkowke1zowWLc2uTzyHIufroNTnYLnYrLCCBVXVaNcfkl74rbYBOMRsWlGsN0kRfMOxxXBIz0U2T2CRRrtRUjUmBRA5hZumw2zavyLuBdc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779458587; c=relaxed/simple;
	bh=MFcGyZ6x19kmOkCQNEmXGxdd8HznahcUHUi52XxB0lI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3jEUzmU8q1wEA5iYIcGYrwZyZtljsNlalxtW7WiRHlDgYaVVYQGHDaGHmsCssM4NH27q1uX/4y52NWaMRBSpwcF8syBA4D5F7KO64tZG9OthpR4AcGcMvFarLKcYVuVqArYtzInihyDgruvESU5YW67ETHFkYFXMsioURaSFUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlk4fkF4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD6E1F000E9;
	Fri, 22 May 2026 14:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779458582;
	bh=IyDcrSKktn1ZCMTnnwdSh4F6gptZFtXVehO4WDLXfig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nlk4fkF4KzDFQKaQxogAg8D38Vzyn74Ls+qSEbiawR+tNtEqDGtTvqGY3wF4pin55
	 9v2M7s58bz1FILHQ7ylJSGUFo5SF2HBcp98xTrR42SIh+U/1sIhTgRyKLVnZ/ASWUP
	 bDLoQ73cALbFmlxlgROpgaj129Kgllgtz5xd3zYLCn4XyMKU5JiWj5y702DHPA/Pi9
	 M9gbFO87fGlK9LkfCQ77L78sWC35DYOyYy3IRwKqhPyN8Y+zd1CAjU3GUhiaM2ZgBN
	 c4uPQ1CTAtoDwt5dGMRAV6Ofhg2JO6krLzeTd4wxqd/Pn8efQmx0jxZe0+vwguqiGI
	 6A/E5dbTrtWsA==
Date: Fri, 22 May 2026 07:03:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, Jacob Keller
 <jacob.e.keller@intel.com>, Mohsin Bashir <mohsin.bashr@gmail.com>, "Mike
 Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Pavel Begunkov
 <asml.silence@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] fbnic: Support larger zcrx receive buffers
Message-ID: <20260522070301.52c2d1b9@kernel.org>
In-Reply-To: <20260522113225.241337-3-bjorn@kernel.org>
References: <20260522113225.241337-1-bjorn@kernel.org>
	<20260522113225.241337-3-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290854-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org,intel.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7B63F5B5E87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 22 May 2026 13:32:21 +0200 Bj=C3=B6rn T=C3=B6pel wrote:
> io_uring zcrx can provide receive buffers larger than PAGE_SIZE
> through QCFG_RX_PAGE_SIZE. Advertise the parameter and use the
> configured size when creating the PPQ page pool.
>=20
> The NIC still consumes PPQ buffers as 4 KiB BDQ fragments. For larger
> zcrx buffers, allocate the page pool with the requested order and set
> the PPQ fragment shift from rx_page_size, so one net_iov can cover
> multiple hardware fragments.
>=20
> The core validates the zcrx request and checks that the imported
> memory can be represented as rx_buf_len-sized DMA chunks. Fbnic still
> has to validate the rendered queue configuration against its own BDQ
> geometry: larger receive buffers consume multiple 4 KiB PPQ entries,
> and the PPQ must retain usable depth after that expansion.
>=20
> Use the rendered per-queue rx_page_size on the normal open path as
> well. This preserves a memory-provider binding made while the netdev
> is down instead of falling back to the default PPQ geometry on open.

> +static u32 fbnic_qcfg_rx_page_size(const struct netdev_queue_config *qcf=
g)
> +{
> +	return qcfg->rx_page_size ?: PAGE_SIZE;

Isn't there a callback to set the defaults so that the driver doesn't
have to do this sort of stuff?

> +}
> +
> +static u32 fbnic_rx_page_frag_count(u32 rx_page_size)
> +{
> +	return rx_page_size / FBNIC_BD_FRAG_SIZE;
> +}
> +
> +static u8 fbnic_rx_page_frag_shift(u32 rx_page_size)
> +{
> +	return ilog2(fbnic_rx_page_frag_count(rx_page_size));
> +}
> +
> +static int fbnic_validate_rx_page_size(struct fbnic_net *fbn, u32 rx_pag=
e_size,
> +				       struct netlink_ext_ack *extack)
> +{
> +	u32 frag_count, ppq_bufs;
> +
> +	if (!is_power_of_2(rx_page_size)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "rx_page_size must be a power of 2");
> +		return -EINVAL;
> +	}
> +
> +	if (rx_page_size < PAGE_SIZE) {

If the PAGE_SIZE =3D=3D 64kB it should be fine to have smaller frags, no?
Or something breaks?

> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "rx_page_size must be at least PAGE_SIZE");
> +		return -EINVAL;
> +	}
> +
> +	if (!IS_ALIGNED(rx_page_size, FBNIC_BD_FRAG_SIZE)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "rx_page_size must be 4K aligned");

"multiple" is probably a better word than "aligned" for size params?

> +		return -EINVAL;
> +	}
> +
> +	frag_count =3D fbnic_rx_page_frag_count(rx_page_size);
> +	ppq_bufs =3D fbn->ppq_size / frag_count;
> +	/* The PPQ is sized in 4K hardware fragments, but the software ring
> +	 * has one entry per page-pool allocation. Keep at least two entries so
> +	 * empty/full ring accounting still leaves one postable buffer.
> +	 */
> +	if (ppq_bufs < 2) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "rx_page_size leaves too few PPQ buffers");

Maybe "rx-jumbo ring size too small for rx_page_size" ?

Core does revalidate the config on ring size changes, right?

> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int
>  fbnic_alloc_qt_page_pools(struct fbnic_net *fbn, struct fbnic_q_triad *q=
t,
> -			  unsigned int rxq_idx)
> +			  unsigned int rxq_idx, u32 rx_page_size)
>  {
>  	struct page_pool_params pp_params =3D {
>  		.order =3D 0,
> @@ -1596,6 +1649,8 @@ fbnic_alloc_qt_page_pools(struct fbnic_net *fbn, st=
ruct fbnic_q_triad *qt,
> =20
>  	qt->sub0.page_pool =3D pp;
>  	if (netif_rxq_has_unreadable_mp(fbn->netdev, rxq_idx)) {
> +		pp_params.order =3D ilog2(rx_page_size) - PAGE_SHIFT;
> +		pp_params.max_len =3D rx_page_size;
>  		pp_params.flags |=3D PP_FLAG_ALLOW_UNREADABLE_NETMEM;
>  		pp_params.dma_dir =3D DMA_FROM_DEVICE;
> =20
> @@ -2018,12 +2073,19 @@ static int fbnic_alloc_tx_qt_resources(struct fbn=
ic_net *fbn,
> =20
>  static int fbnic_alloc_rx_qt_resources(struct fbnic_net *fbn,
>  				       struct fbnic_napi_vector *nv,
> -				       struct fbnic_q_triad *qt)
> +				       struct fbnic_q_triad *qt,
> +				       u32 rx_page_size)
>  {
>  	struct device *dev =3D fbn->netdev->dev.parent;
>  	int err;
> =20
> -	err =3D fbnic_alloc_qt_page_pools(fbn, qt, qt->cmpl.q_idx);
> +	err =3D fbnic_validate_rx_page_size(fbn, rx_page_size, NULL);
> +	if (err)
> +		return err;
> +
> +	qt->sub1.frag_shift =3D fbnic_rx_page_frag_shift(rx_page_size);
> +
> +	err =3D fbnic_alloc_qt_page_pools(fbn, qt, qt->cmpl.q_idx, rx_page_size=
);
>  	if (err)
>  		return err;
> =20
> @@ -2087,7 +2149,13 @@ static int fbnic_alloc_nv_resources(struct fbnic_n=
et *fbn,
> =20
>  	/* Allocate Rx Resources */
>  	for (j =3D 0; j < nv->rxt_count; j++, i++) {
> -		err =3D fbnic_alloc_rx_qt_resources(fbn, nv, &nv->qt[i]);
> +		struct netdev_queue_config qcfg;
> +		u32 rx_page_size;
> +
> +		netdev_queue_config(fbn->netdev, nv->qt[i].cmpl.q_idx, &qcfg);
> +		rx_page_size =3D fbnic_qcfg_rx_page_size(&qcfg);
> +		err =3D fbnic_alloc_rx_qt_resources(fbn, nv, &nv->qt[i],
> +						  rx_page_size);
>  		if (err)
>  			goto free_qt_resources;
>  	}
> @@ -2852,9 +2920,16 @@ static int fbnic_queue_mem_alloc(struct net_device=
 *dev,
>  	const struct fbnic_q_triad *real;
>  	struct fbnic_q_triad *qt =3D qmem;
>  	struct fbnic_napi_vector *nv;
> +	u32 rx_page_size =3D fbnic_qcfg_rx_page_size(qcfg);
> +	int err;
> =20
> -	if (!netif_running(dev))
> -		return fbnic_alloc_qt_page_pools(fbn, qt, idx);
> +	if (!netif_running(dev)) {
> +		err =3D fbnic_validate_rx_page_size(fbn, rx_page_size, NULL);

Hm. Is the validate callback not called in case the device is down?

> +		if (err)
> +			return err;
> +
> +		return fbnic_alloc_qt_page_pools(fbn, qt, idx, rx_page_size);
> +	}
> =20
>  	real =3D container_of(fbn->rx[idx], struct fbnic_q_triad, cmpl);
>  	nv =3D fbn->napi[idx % fbn->num_napi];
> @@ -2864,11 +2939,20 @@ static int fbnic_queue_mem_alloc(struct net_devic=
e *dev,
>  	qt->sub0.frag_shift =3D real->sub0.frag_shift;
>  	fbnic_ring_init(&qt->sub1, real->sub1.doorbell, real->sub1.q_idx,
>  			real->sub1.flags);
> -	qt->sub1.frag_shift =3D real->sub1.frag_shift;
>  	fbnic_ring_init(&qt->cmpl, real->cmpl.doorbell, real->cmpl.q_idx,
>  			real->cmpl.flags);
> =20
> -	return fbnic_alloc_rx_qt_resources(fbn, nv, qt);
> +	return fbnic_alloc_rx_qt_resources(fbn, nv, qt, rx_page_size);
> +}
> +
> +static int fbnic_validate_qcfg(struct net_device *dev,
> +			       struct netdev_queue_config *qcfg,
> +			       struct netlink_ext_ack *extack)
> +{
> +	struct fbnic_net *fbn =3D netdev_priv(dev);
> +
> +	return fbnic_validate_rx_page_size(fbn, fbnic_qcfg_rx_page_size(qcfg),
> +					   extack);
>  }
> =20
>  static void fbnic_queue_mem_free(struct net_device *dev, void *qmem)
> @@ -2970,4 +3054,6 @@ const struct netdev_queue_mgmt_ops fbnic_queue_mgmt=
_ops =3D {
>  	.ndo_queue_mem_free	=3D fbnic_queue_mem_free,
>  	.ndo_queue_start	=3D fbnic_queue_start,
>  	.ndo_queue_stop		=3D fbnic_queue_stop,
> +	.ndo_validate_qcfg	=3D fbnic_validate_qcfg,
> +	.supported_params	=3D QCFG_RX_PAGE_SIZE,
>  };


