Return-Path: <netdev+bounces-280200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BawMgCx52lZ/QEAu9opvQ
	(envelope-from <netdev+bounces-280200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 19:16:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 512E043DD1E
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 19:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6ED2303816D
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 17:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B237282F16;
	Tue, 21 Apr 2026 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUWlT5Q+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48065274B43
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776791716; cv=none; b=jnIAdVSi08+ghlOQXoKaxkVndNiYUR6K50PaE3ck/P7p52nA3AOVJtOHlu4sTIfP2FHfLJCnpL1nl8RPDfdmiSDTpmbFMhwf9ucV49YCaykYrlaWBVLNjuE5cmcodEoQb6u4Fb4yOTooHTzpjnk1EZGOEkU+Q2zAqR23RbKUvtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776791716; c=relaxed/simple;
	bh=RqhR1ifSH6h4hvW6eeD7CwMBkMSMvldNwfsFYP4qNmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAhAbEy4IVQmI3glV5Jn72y4LLMDxDaE5OxiACg77GVZ/QLHiInYrdClSixEBZelqNtQXy7revphn13RN5QPo4c0r7wSQc7wv6jiDT/BRnVxwsXIvWiGneREO/1ww7SbZQQ2zEhkEQGV3YV5E6A0nSYfoqBGzNIMTUwkujIx0KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUWlT5Q+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929A2C2BCB9;
	Tue, 21 Apr 2026 17:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776791715;
	bh=RqhR1ifSH6h4hvW6eeD7CwMBkMSMvldNwfsFYP4qNmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rUWlT5Q+3y+u3fqIKUlf0nWl/6k7hCOiuN29BFQbtY2bjazd9bj/k9ITK+ij7fnrx
	 nhvL+hsakPFUmPNV4Kmf6QWFsUayVjeJwbHcBqSQjx/LqrUGkdQaJfsQPhgGMWuauH
	 /IHtsxUrdSL+FnY7BVlwdAqH5BD5IKcaI6Mi2mEhfDfcFDAFNDOjlaqLWENyxciLkY
	 iLR6x66KoRKltZflLw4FEuJD9mT3Z07bN/DVe6yrHspaiRCrlSoaGU30GFLDO7EfDJ
	 of5x6ouRdD5DaLzW1ArbRrNF9J81ypTFqND92qC14mV/QZBFJsX9sroJqLK1CG4+L1
	 iruZLVKTvKvLg==
Date: Tue, 21 Apr 2026 19:15:13 +0200
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
Message-ID: <aeewoVjN7EHLZTW_@lore-desk>
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
	protocol="application/pgp-signature"; boundary="l/XyUOK+TbmoSNvA"
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
	TAGGED_FROM(0.00)[bounces-280200-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 512E043DD1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--l/XyUOK+TbmoSNvA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

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
>=20
> Also the pre-existing issues mentioned WRT patch 1/2 makes such patch
> IMHO almost ineffective, I think you should address them in the same seri=
es.
>=20
> Note that you should have commented on sashiko review on the ML, it
> would have saved a significant amount of time on us.

Since this series is marked as 'Changes Requested', it is not clear to me w=
hat
next steps are. I guess we have two possible approach here:

1) - Post patch 1/2 ("net: airoha: Move ndesc initialization at
     end of airoha_qdma_init_tx()") with the series available upstream
     (not merged yet) in [0] where I am fixing similar issues for
     airoha_qdma_init_rx_queue() and airoha_qdma_tx_irq_init().
   - Post patch 2/2 ("net: airoha: Add missing bits in
     airoha_qdma_cleanup_tx_queue()") with a fix for airoha_ndo_stop() wait=
ing
     for TX/RX DMA engine to complete before running
     airoha_qdma_cleanup_tx_queue().

2) - Since all the issues rised by Sashiko are not strictly related to this
     series and they are already fixed in pending patches, just apply the f=
ixes
     separately without the needs to repost this series.

Which approach do you prefer?

Regards,
Lorenzo

[0] https://patchwork.kernel.org/project/netdevbpf/cover/20260420-airoha_qd=
ma_init_rx_queue-fix-v2-0-d99347e5c18d@kernel.org/

>=20
> /P
>=20

--l/XyUOK+TbmoSNvA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaeewoQAKCRA6cBh0uS2t
rEaHAQCcKtKEMHUCG+eY2o4NV0BnCt9GTc/hVJ/zktJkukChSAD+OUbxW5LM+Bve
eEnUENXdlph4WMO5XEHV38IciwKqQw0=
=Rgkr
-----END PGP SIGNATURE-----

--l/XyUOK+TbmoSNvA--

