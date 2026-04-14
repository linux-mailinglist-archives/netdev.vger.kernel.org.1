Return-Path: <netdev+bounces-278301-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPORCV7k3WnDkwkAu9opvQ
	(envelope-from <netdev+bounces-278301-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 08:53:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 784C13F646F
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 08:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9456A30166E9
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 06:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B363633F5B6;
	Tue, 14 Apr 2026 06:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqQWRIgc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9038630E0FB
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 06:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776149449; cv=none; b=Eqk1whxe1EY/5r2mM65T2zi7P1T+c6ZvYd502bdUwiE9xKjPpYSRL8ez6ywshmYbpX7RfQeHsRBnDxNA3KLNwZcSUov/KeRrVXD8DRepD90LM0SarGuwZ3097iX2vQQutvyblQrDQugydhPT/nYrYyW7SxegxJ6N1ovbySee9ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776149449; c=relaxed/simple;
	bh=J7urA2Y9K/1/xQ3Pfm3NoRFKtOG7BaAW7PeZ+LWeRww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l94yvEU1COa/VLAqMzE65Tj+sLNNS44g5lFxiTbitpCNSkRyGPJuil38wit+F8jFtz/4RjtH+jBnYwikPsSw9WteVeerTE8qGnriaThn0SSOTOzJBy63ID/Mqhg3y+6se74IDjnNb8senX1SPVNY9lnNgLTXlbIXH/QMrgF39XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqQWRIgc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24650C2BCB3;
	Tue, 14 Apr 2026 06:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776149449;
	bh=J7urA2Y9K/1/xQ3Pfm3NoRFKtOG7BaAW7PeZ+LWeRww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IqQWRIgcFqS9gj2NS9UOweLrccR9X2jgkZLSsKnCmEcOJLaqLGn9CGumfKg566s2n
	 OjxP/eTIUItS8CU91+kQqk3UEd8Pdg4yyltgwMScyBmbjBrhbnVn0sv050l5dscXNL
	 sGkuTazS5AVl1h0B1JOyNqOPt4HPNP699JuCfV/CGA6bClHzl3+exbejRR18DohI6C
	 meJqnUWqZj0fOkXx6ns05iqqL4xmmHSga/foSEQRtJedmXIbdwKeni4HbHeGk0B2Id
	 C9mZ4++TZQEN2YaYezwUm2oXczqTEVraedNwjERslf2cEO+HG5AxJv14Lwql323k+p
	 ItIRi7V6Bt/6Q==
Date: Tue, 14 Apr 2026 08:50:47 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: Add missing bits in
 airoha_qdma_cleanup_tx_queue()
Message-ID: <ad3jxzIN8UqTnsa2@lore-desk>
References: <20260410-airoha_qdma_cleanup_tx_queue-fix-net-v1-1-b7171c8f1e78@kernel.org>
 <20260413225709.3648413-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W0h9puXbvySZQQQC"
Content-Disposition: inline
In-Reply-To: <20260413225709.3648413-1-kuba@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278301-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 784C13F646F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--W0h9puXbvySZQQQC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: airoha: Add missing bits in airoha_qdma_cleanup_tx_queue()
>=20
> This commit resets DMA TX descriptors in airoha_qdma_cleanup_tx_queue
> and synchronizes TX_DMA_IDX to TX_CPU_IDX to notify the hardware that
> the ring is empty.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 9285a68f435fe..963ab7b8d166b 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -1044,13 +1044,17 @@ static int airoha_qdma_init_tx(struct airoha_qd=
ma *qdma)
> [ ... ]
> >  	spin_lock_bh(&q->lock);
> >  	for (i =3D 0; i < q->ndesc; i++) {
> > -		struct airoha_queue_entry *e =3D &q->entry[i];
> > +		struct airoha_qdma_desc *desc =3D &q->desc[i];
> > =20
> > +		e =3D &q->entry[i];
>=20
> Can this result in a NULL pointer dereference?
>=20
> If airoha_qdma_init_tx_queue() sets q->ndesc before allocating q->entry a=
nd
> q->desc, and devm_kzalloc() fails, the error path jumps to
> airoha_hw_cleanup().
>=20
> Because q->ndesc > 0, this cleanup loop would execute and dereference
> q->entry[i] and q->desc[i], which may not have been allocated.

ack, I will fix it in v2.

>=20
> [ ... ]
> > +		/* Reset DMA descriptor */
> > +		WRITE_ONCE(desc->ctrl, 0);
> > +		WRITE_ONCE(desc->addr, 0);
> > +		WRITE_ONCE(desc->data, 0);
> > +		WRITE_ONCE(desc->msg0, 0);
> > +		WRITE_ONCE(desc->msg1, 0);
> > +		WRITE_ONCE(desc->msg2, 0);
>=20
> Is it safe to modify these DMA descriptors and reset the ring indices bel=
ow
> without waiting for the hardware DMA engine to become idle?
>=20
> In airoha_dev_stop(), the driver clears GLOBAL_CFG_TX_DMA_EN_MASK to requ=
est
> the hardware DMA engine to stop, but it does not appear to poll
> GLOBAL_CFG_TX_DMA_BUSY_MASK to ensure it has actually stopped.
>=20
> Modifying the DMA descriptors and internal ring indices while the hardware
> is still actively processing in-flight descriptors could potentially lead
> to corrupted DMA fetches or IOMMU faults.

This is already fixed here:
https://lore.kernel.org/netdev/20260411-airoha-fix-ndo_stop-v1-1-caddaa1817=
39@kernel.org/

>=20
> >  		q->queued--;
> >  	}
> > +
> > +	e =3D list_first_entry(&q->tx_list, struct airoha_queue_entry,
> > +			     list);
> > +	index =3D e - q->entry;
> > +	/* Set TX_DMA_IDX to TX_CPU_IDX to notify the hw the QDMA TX ring is
> > +	 * empty.
> > +	 */
> > +	airoha_qdma_rmw(qdma, REG_TX_CPU_IDX(qid), TX_RING_CPU_IDX_MASK,
> > +			FIELD_PREP(TX_RING_CPU_IDX_MASK, index));
> > +	airoha_qdma_rmw(qdma, REG_TX_DMA_IDX(qid), TX_RING_DMA_IDX_MASK,
> > +			FIELD_PREP(TX_RING_DMA_IDX_MASK, index));
>=20
> Could list_first_entry() be called on an empty list here?
>=20
> If q->tx_list is empty (for example, if allocation failed in
> airoha_qdma_init_tx_queue or if no entries had a valid dma_addr), calling
> list_first_entry() returns an invalid pointer.
>=20
> The subsequent pointer arithmetic would produce a garbage index value,
> which is then written to the REG_TX_CPU_IDX and REG_TX_DMA_IDX registers.

ack, I will fix it in v2.

Regards,
Lorenzo

> --=20
> pw-bot: cr

--W0h9puXbvySZQQQC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCad3jxwAKCRA6cBh0uS2t
rFjtAQDyhrwFh+QugKLUMHuIU38dxPrvgRB5D8rTrcU3XsBnLwD+OGPN6+RIDOmR
LGc8ZXJFrgJs1j1ZTN/W9OLa44BQFww=
=b+XE
-----END PGP SIGNATURE-----

--W0h9puXbvySZQQQC--

