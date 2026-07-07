Return-Path: <netdev+bounces-305488-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +mb5MSMKTWoZuAEAu9opvQ
	(envelope-from <netdev+bounces-305488-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 16:16:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9B171C714
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 16:16:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CM6PGvot;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305488-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305488-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CE783110658
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 14:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522783438BF;
	Tue,  7 Jul 2026 14:07:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBF73F39E9
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 14:07:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433241; cv=none; b=FXh9knnPQsldtlhCUrMViDY0fI6FJfd9/DJJKZlDmvwJ7XcYfIIE44RH6o8xeAAQ+ck2UyZVUcVb+OWHrmSMZH5JrpvHYLJ/0b2CK/KDQfvX/oyvWjRzv4NAw7EzYuUzrYGBTTmGDyuq8+TVaN3ZJLyn8q+HWquJhbOlmw7Zfbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433241; c=relaxed/simple;
	bh=VNOthrWDgMe51DaLNmRvGOgBRJChgBG+zoxmQTB7two=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyovHuyTUkYE5lUcehSLlTWAQLCHqVF4Fbl9SKzFaE0uyAAWkOMeUzQ6mC1zc1pytoCh1ljiHKZQtRH8oJJWxn6RJuPRzUnq5phdsZ07eevEN7IVGQ0ueAjwxFs0U5T0bH9/LPobeLZ7m/GxqAX3njydb/pa7dpqgQ80uf///5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CM6PGvot; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C91D1F000E9;
	Tue,  7 Jul 2026 14:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783433240;
	bh=TbDjUFQ8y2cf3ZfvpIyeJwcBu1+jogsuvp+HURk7B1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CM6PGvotwp6h5fdyxBXyxflZVxqRIjdiRW2OXD33cNNVC0zMekKtrZxd+aaTv7QId
	 xbWCGpMiIbAeXCmuCjzhTD9CHSjXRhIUJ+6cFbcXwWC5hHYRdM/F67ewYtDOkQtBCZ
	 Fi0BBIS4wBxYrYtbowP0d8Em/2klHQOz+4sHlqU7GRBbmEDEySHfqfVp2cvR15/OM2
	 3pMoF8UGBXlwy2rsSKDGYkU0fG91ecWQFAQ7DblX99E9OFVHBU1+oFpoZJrpsOG5K9
	 QXoK5s2k5V07JapW6vJcvQFIp56Lqp+O+zSt3JkKjBUB+V1SzHvJyPkZJkunl7ULmT
	 rUVGbkSw1T6FQ==
Date: Tue, 7 Jul 2026 16:07:17 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Aniket Negi <aniket.negi03@gmail.com>
Cc: netdev@vger.kernel.org, aniket.negi@airoha.com
Subject: Re: [PATCH net v4] net: airoha: fix MIB stats collection to be
 lossless
Message-ID: <ak0IFdwz1rDEekOO@lore-desk>
References: <akwczc23LOGbKfMl@lore-desk>
 <20260707132117.94902-1-aniket.negi03@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9OSNfM+DRPhE0WS3"
Content-Disposition: inline
In-Reply-To: <20260707132117.94902-1-aniket.negi03@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:aniket.negi03@gmail.com,m:netdev@vger.kernel.org,m:aniket.negi@airoha.com,m:aniketnegi03@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305488-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lore-desk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E9B171C714


--9OSNfM+DRPhE0WS3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo,
> Thanks for the review.
>=20
> > > +	for (i =3D AIROHA_GDM1_IDX; i <=3D AIROHA_GDM4_IDX; i++)
> > > +		airoha_fe_set(eth, REG_FE_GDM_MIB_CLEAR(i),
> > > +			      FE_GDM_MIB_RX_CLEAR_MASK | FE_GDM_MIB_TX_CLEAR_MASK);
> >
> > This configuration is not needed since we reset FE at module load.
>=20
> Agreed. The SCU FE reset clears MIB counters, so the explicit loop
> is redundant. Will drop it in v5.
>=20
> On Mon, 2 Jul 2026 22:59:32 +0000, Sashiko <sashiko@kernel.org> wrote:
> > With this patch the driver no longer has any users of
> > REG_FE_GDM_MIB_CLEAR, FE_GDM_MIB_RX_CLEAR_MASK or
> > FE_GDM_MIB_TX_CLEAR_MASK; grep in drivers/net/ethernet/airoha/
> > matches only the definitions in airoha_regs.h. Should these macros
> > be removed in the same patch that eliminates their only caller?
>=20
> What is your suggestions here, I prefer that definitions should=20
> be retained in airoha_regs.h as register documentation for future=20
> reference. Only the loop will be dropped.

correct.

Regards,
Lorenzo

>=20
> > nit: tmp is not so meaningful, maybe better something like data?
> > nit: I would prefer "+" instead of "|"
> > nit: please drop prev and just do:
> >       dev->stats.tx_ok_pkts =3D max(data, dev->stats.tx_ok_pkts);
> > please redo it for all the occurrences.
>=20
> Understood. Will rename tmp to data, and use '+' instead of '|' in v5.
>=20
> Thanks,
> Aniket

--9OSNfM+DRPhE0WS3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCak0IFQAKCRA6cBh0uS2t
rPZ6AP9X0jB9HpK99S27kDxkKP1oUt6TrTSfLBDGruyoe2yvWgEApoZ/M6U5vY9k
s1nkiMUPTYtBH0R5qY9C0At6wy1ubAE=
=asqu
-----END PGP SIGNATURE-----

--9OSNfM+DRPhE0WS3--

