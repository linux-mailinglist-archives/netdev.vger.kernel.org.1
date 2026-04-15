Return-Path: <netdev+bounces-278853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKeWFuDR32kNZQAAu9opvQ
	(envelope-from <netdev+bounces-278853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 19:58:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E82406F18
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 19:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D00E3025799
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 17:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA433D890F;
	Wed, 15 Apr 2026 17:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hd4LhKje"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96B1367F3C
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 17:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776275932; cv=none; b=BtThuqiQtpzOoPQuBoOdfXfVgX5AxN9yrSwbWr7Im71QmJ/NXGs17ZToiowPYY4atT7zlNLPtLd9VCcEdMfCQZzdSALGCYHm8bKeCPmDyUNwI3GcBmoI/F+yBJeE7C/DK7J9DFJuNB+GBQWQXtXx2cokY/6xsNpBssytP0U16Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776275932; c=relaxed/simple;
	bh=zOaTL2NNkh6dUpZwCq8yCW+BdPc/jYidrV0dsURT6W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqfTEOmXGSXZfNrQNmSLpKnmzf/4Q5CKJbhXMVevW0wk89mI3YTiy7e0R12v6iq0qmnhh0GTs7LQ69MhqLSZaWfPDnd32+ANKJzp4eK6Azj/gTF4nfqPVhiJCcYnuCVVDxvguNDQFhuQSpzO2Du/jnMW573GJ4RgYkAaZETyaow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hd4LhKje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11729C19424;
	Wed, 15 Apr 2026 17:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776275932;
	bh=zOaTL2NNkh6dUpZwCq8yCW+BdPc/jYidrV0dsURT6W0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hd4LhKjeERgPr4m0ddcWMGu5i9MGZ9zXikQHCi98iXlS3evOK/FP5JYwQSu2adcoy
	 7H4Koez7sDTZyHubivMUWfy6jqNm/TtRWVMLG+gON7v7TvjqNe4Kn4uABmXNH/tFCA
	 undKq6SCceEza5YNvbMnRXlGZUUzgdAEoGAHFP7AskuYhVHyqJ1GCro/VIGJyabqJI
	 dlRbgSJv8autY9Vao+IYD4iRs0PJMDz+JX2Qc8jUXW0Ah9G8zNItOnjGdj715zHjF+
	 xgEXu9/ZyRmsdBwicVOVTtgc1o431kae3N4A9POgEYaLsPkVs4Oxi4EXsliiruCua5
	 kDmjqFHer3vEA==
Date: Wed, 15 Apr 2026 19:58:50 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] net: airoha: Add missing bits in
 airoha_qdma_cleanup_tx_queue()
Message-ID: <ad_R2kp2toH35Z0p@lore-desk>
References: <20260414-airoha_qdma_cleanup_tx_queue-fix-net-v2-1-875de57cc022@kernel.org>
 <20260415164643.GQ772670@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iThq3ydaXqdTfH2R"
Content-Disposition: inline
In-Reply-To: <20260415164643.GQ772670@horms.kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278853-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03E82406F18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--iThq3ydaXqdTfH2R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, Apr 14, 2026 at 08:50:52AM +0200, Lorenzo Bianconi wrote:
> > Similar to airoha_qdma_cleanup_rx_queue(), reset DMA TX descriptors in
> > airoha_qdma_cleanup_tx_queue routine. Moreover, reset TX_DMA_IDX to
> > TX_CPU_IDX to notify the NIC the QDMA TX ring is empty.
> >=20
> > Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN75=
81 SoC")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> > Changes in v2:
> > - Move q->ndesc initialization at end of airoha_qdma_init_tx routine in
> >   order to avoid any possible NULL pointer dereference in
> >   airoha_qdma_cleanup_tx_queue()
>=20
> This seems to be a separate issue.
> If so, I think it should be split out into a separate patch.

Sorry, I missed this comment.
Ack. I will repost splitting this in two separated patches.

Regards,
Lorenzo

>=20
> > - Check if q->tx_list is empty in airoha_qdma_cleanup_tx_queue()
> > - Link to v1: https://lore.kernel.org/r/20260410-airoha_qdma_cleanup_tx=
_queue-fix-net-v1-1-b7171c8f1e78@kernel.org
>=20
> I think it was covered in the review Jakub forwarded for v1.  But FTR,
> Sashiko has some feedback on this patch in the form of an existing bug
> (that should almost certainly be handled separately from this patch).
>=20
> > ---
> >  drivers/net/ethernet/airoha/airoha_eth.c | 41 ++++++++++++++++++++++++=
++------
> >  1 file changed, 34 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 9e995094c32a..3c1a2bc68c42 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -966,27 +966,27 @@ static int airoha_qdma_init_tx_queue(struct airoh=
a_queue *q,
> >  	dma_addr_t dma_addr;
> > =20
> >  	spin_lock_init(&q->lock);
> > -	q->ndesc =3D size;
> >  	q->qdma =3D qdma;
> >  	q->free_thr =3D 1 + MAX_SKB_FRAGS;
> >  	INIT_LIST_HEAD(&q->tx_list);
> > =20
> > -	q->entry =3D devm_kzalloc(eth->dev, q->ndesc * sizeof(*q->entry),
> > +	q->entry =3D devm_kzalloc(eth->dev, size * sizeof(*q->entry),
> >  				GFP_KERNEL);
> >  	if (!q->entry)
> >  		return -ENOMEM;
> > =20
> > -	q->desc =3D dmam_alloc_coherent(eth->dev, q->ndesc * sizeof(*q->desc),
> > +	q->desc =3D dmam_alloc_coherent(eth->dev, size * sizeof(*q->desc),
> >  				      &dma_addr, GFP_KERNEL);
> >  	if (!q->desc)
> >  		return -ENOMEM;
> > =20
> > -	for (i =3D 0; i < q->ndesc; i++) {
> > +	for (i =3D 0; i < size; i++) {
> >  		u32 val =3D FIELD_PREP(QDMA_DESC_DONE_MASK, 1);
> > =20
> >  		list_add_tail(&q->entry[i].list, &q->tx_list);
> >  		WRITE_ONCE(q->desc[i].ctrl, cpu_to_le32(val));
> >  	}
> > +	q->ndesc =3D size;
> > =20
> >  	/* xmit ring drop default setting */
> >  	airoha_qdma_set(qdma, REG_TX_RING_BLOCKING(qid),
> > @@ -1051,13 +1051,17 @@ static int airoha_qdma_init_tx(struct airoha_qd=
ma *qdma)
> > =20
> >  static void airoha_qdma_cleanup_tx_queue(struct airoha_queue *q)
> >  {
> > -	struct airoha_eth *eth =3D q->qdma->eth;
> > -	int i;
> > +	struct airoha_qdma *qdma =3D q->qdma;
> > +	struct airoha_eth *eth =3D qdma->eth;
> > +	int i, qid =3D q - &qdma->q_tx[0];
> > +	struct airoha_queue_entry *e;
> > +	u16 index =3D 0;
> > =20
> >  	spin_lock_bh(&q->lock);
> >  	for (i =3D 0; i < q->ndesc; i++) {
> > -		struct airoha_queue_entry *e =3D &q->entry[i];
>=20
> super nit: In v2 e is always used within a block (here and in the hunk be=
low).
>            So I would lean towards declaring e in the blocks where it is
> 	   used.
>=20
> 	   No need to repost just for this!
>=20
> > +		struct airoha_qdma_desc *desc =3D &q->desc[i];
> > =20
> > +		e =3D &q->entry[i];
> >  		if (!e->dma_addr)
> >  			continue;
> > =20
> > @@ -1067,8 +1071,31 @@ static void airoha_qdma_cleanup_tx_queue(struct =
airoha_queue *q)
> >  		e->dma_addr =3D 0;
> >  		e->skb =3D NULL;
> >  		list_add_tail(&e->list, &q->tx_list);
> > +
> > +		/* Reset DMA descriptor */
> > +		WRITE_ONCE(desc->ctrl, 0);
> > +		WRITE_ONCE(desc->addr, 0);
> > +		WRITE_ONCE(desc->data, 0);
> > +		WRITE_ONCE(desc->msg0, 0);
> > +		WRITE_ONCE(desc->msg1, 0);
> > +		WRITE_ONCE(desc->msg2, 0);
> > +
> >  		q->queued--;
> >  	}
> > +
> > +	if (!list_empty(&q->tx_list)) {
> > +		e =3D list_first_entry(&q->tx_list, struct airoha_queue_entry,
> > +				     list);
> > +		index =3D e - q->entry;
> > +	}
> > +	/* Set TX_DMA_IDX to TX_CPU_IDX to notify the hw the QDMA TX ring is
> > +	 * empty.
> > +	 */
> > +	airoha_qdma_rmw(qdma, REG_TX_CPU_IDX(qid), TX_RING_CPU_IDX_MASK,
> > +			FIELD_PREP(TX_RING_CPU_IDX_MASK, index));
> > +	airoha_qdma_rmw(qdma, REG_TX_DMA_IDX(qid), TX_RING_DMA_IDX_MASK,
> > +			FIELD_PREP(TX_RING_DMA_IDX_MASK, index));
> > +
> >  	spin_unlock_bh(&q->lock);
> >  }
> > =20
> >=20
> > ---
> > base-commit: 2cd7e6971fc2787408ceef17906ea152791448cf
> > change-id: 20260410-airoha_qdma_cleanup_tx_queue-fix-net-93375f5ee80f
> >=20
> > Best regards,
> > --=20
> > Lorenzo Bianconi <lorenzo@kernel.org>
> >=20

--iThq3ydaXqdTfH2R
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCad/R2gAKCRA6cBh0uS2t
rAsxAQCKyKMvs7z3VGfMqDQMFX/Z8atbBA5QK1r7fjjqMBvsBgD/Us/x1vWTr9QG
hilddlamKDc07tzQ7aqXHFHN3z0CLwM=
=b3Np
-----END PGP SIGNATURE-----

--iThq3ydaXqdTfH2R--

