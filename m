Return-Path: <netdev+bounces-280086-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PLAIDlj52l07gEAu9opvQ
	(envelope-from <netdev+bounces-280086-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:44:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BD543A309
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B91BB304EA8A
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 11:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1382C2D5937;
	Tue, 21 Apr 2026 11:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeCEUSmk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4914279334
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 11:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776771762; cv=none; b=XbM05+Rk78SQGhCLLGINrZ/07jJYyerLtsI9P7ZBoDI/RceKEcI5Ne8Q9C3gz4JG64UAtRZR/y2Z5FHKv28pkE1ntezP+K86FV3J4ztJiaZ6zUU6TjDqu1j5Zd7+/GjglLm1GVal6R5AqyvDi+mgBHmGf5TAxHB1WnmCnxlsUZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776771762; c=relaxed/simple;
	bh=9UhTW9xT7PdHQrQSt9P+asq3NpsjAt8tMVdcCDFl78I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qto+/7vwbbIyTOFNhtNlr2cMoxufaE2YiRVp4+rSLfAN6dF7AkQRmhgUAaIbdupv04YPbalIGig0U0DLYMvrBKt4CW6nlpn8BHQEeSJ1kPXZfmLl8rdVWG9TR/6FkeYO1QKg9eeWC0tHEmCWo0rGkqvjfrP+WGFus0VMBy+gtP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeCEUSmk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41949C2BCB0;
	Tue, 21 Apr 2026 11:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776771761;
	bh=9UhTW9xT7PdHQrQSt9P+asq3NpsjAt8tMVdcCDFl78I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LeCEUSmkVB7uDQbwNH6WRxnJreyKKHzxK/ZZmuB6Q5UziA7vQCDoWWZ9i+jnMGkdq
	 9F+W3EKsO+r8UBoKx/C+YTOY2fT+5KlChTL2EZz965qH6ardSN8LV0Pjg6VFnnEdzq
	 FyjSWLiztf3GRR2pLP4eL5Bk/+dCYSCuex+lfg9HkBhIfnQAn3Yf5fw4n2NmntGpLf
	 URmBj3TABIIgCgA4nFPh1IzXz+mJr6WmnMgHZb5jnViTsH5Me1PRlDY96hcq6SLAbr
	 q8C5S815mprEyJYWuMMwyL4lkVhiMLg6+B3bfPXOnidS5tLhwXFFx6nM0s14DGSyFQ
	 tqDfew4Ilc86Q==
Date: Tue, 21 Apr 2026 13:42:39 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v4 2/2] net: airoha: Add missing bits in
 airoha_qdma_cleanup_tx_queue()
Message-ID: <aedir5VqgERpKiQo@lore-desk>
References: <20260417-airoha_qdma_cleanup_tx_queue-fix-net-v4-0-e04bcc2c9642@kernel.org>
 <20260417-airoha_qdma_cleanup_tx_queue-fix-net-v4-2-e04bcc2c9642@kernel.org>
 <210f5d0b-6232-4c0f-adff-3a97d54159b3@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WAIgI6lpLNOsZ8Vj"
Content-Disposition: inline
In-Reply-To: <210f5d0b-6232-4c0f-adff-3a97d54159b3@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-280086-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D7BD543A309
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--WAIgI6lpLNOsZ8Vj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 21, Paolo Abeni wrote:
> On 4/17/26 8:36 AM, Lorenzo Bianconi wrote:
> > @@ -1055,8 +1058,33 @@ static void airoha_qdma_cleanup_tx_queue(struct =
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
>=20
> Sashiko has some complains on this patch that look legit to me.

Hi Paolo,

I looked at the issue reported by Sashiko for patch 2/2 and I will send
a dedicated patch to address it but I guess this problem is not strictly
related to this patch since we already have the reported issue upstream
even without this patch (please consider dma_unmap_single() in
airoha_qdma_cleanup_tx_queue()).
Moreover, in this patch I want to just add missing bits in
airoha_qdma_cleanup_tx_queue().

>=20
> Also the pre-existing issues mentioned WRT patch 1/2 makes such patch
> IMHO almost ineffective, I think you should address them in the same seri=
es.

The issue reported by Sashiko for patch 1/2 are already addressed in the
following upstream series:
https://patchwork.kernel.org/project/netdevbpf/cover/20260420-airoha_qdma_i=
nit_rx_queue-fix-v2-0-d99347e5c18d@kernel.org/

>=20
> Note that you should have commented on sashiko review on the ML, it
> would have saved a significant amount of time on us.

I guess the main issue here is Sashiko is not currently sending the feedbac=
ks
on the ML, right?

Regards,
Lorenzo

>=20
> /P
>=20

--WAIgI6lpLNOsZ8Vj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaedirwAKCRA6cBh0uS2t
rKm2AQCJX5EFjUoZOgA0dMAtp47WwtsT6OLTasYJncph2WOH2gEAxwIuV7Vj/njE
4ErUezlEWo5xp4HVolf/2sJQ1K6Xzw8=
=DOYM
-----END PGP SIGNATURE-----

--WAIgI6lpLNOsZ8Vj--

