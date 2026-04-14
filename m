Return-Path: <netdev+bounces-278452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKWmMTI/3mlJpwkAu9opvQ
	(envelope-from <netdev+bounces-278452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:20:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A7B3FA6AD
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D77EF3079234
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8DC3E6DE1;
	Tue, 14 Apr 2026 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R363Qf9v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E2C3E6DD9
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776172504; cv=none; b=mkH9Qlouax0ovHNdkcqYh0uRfvl/gY8EwqAEwe47D4UIq7AAMCjY0a6LQHPZIIQePg79JgVvSegYxy92BeXaT/UT3ab9Z8emnQc89Fm4Y0Wdvo9HiF+BrKGQwSUaDeGHuRfXrhmgtrnzM3LRLClaOtCwrgLOeLHvI3VETtMF5Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776172504; c=relaxed/simple;
	bh=wEv5mqvmrSOGSAYKMInPhiGsKDkCJqa9FtAb0FRnrAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aN2naDMWL1wsoKj3feAKbSXuyyJJBf/JlfhdQrzzH32wtR3RTsEeOFf9OUyJZshj1ui8GHwVVSIeLsNc9zoriSLSxa1omuWel41nURlaQe22VjH75amNDrLdXIFzy0SIEnsGZrJr2Unev/VTycI1RjAZUEJtUdyGik+WFYifD3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R363Qf9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE2CC19425;
	Tue, 14 Apr 2026 13:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776172504;
	bh=wEv5mqvmrSOGSAYKMInPhiGsKDkCJqa9FtAb0FRnrAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R363Qf9vqymirGwgv+28hUY+lIpw1XfX7/+X8NapLj91KX6VFRlnSChUhkW9hf6Ni
	 MgOY8g1U3o2JTWjuVvvso4iobwr1xBF44PSAKodTwTSO31TrbH4G+Y9XWccc/vxBhD
	 nLc97t9hQrdRf2IOLOtRAlgYXfPAX7Rmit/EVDwpXkeS93hb0r2HlFsgyr4zCi/7d9
	 1jAWQpXyMuULNW7FZAR8u1Gg+VaiWJBH8hYJwLOg85vqfEZopbK5y+8F5G8lLRljo0
	 BXUjjJKtBKYIvHRnrHhX1CmFHveGov7AkrtIDhsQnZqpw6vyetHYsXqe0co5UCb7/e
	 PM/7L5AI+V5fg==
Date: Tue, 14 Apr 2026 15:15:01 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: Wait for NPU PPE configuration to
 complete in airoha_ppe_offload_setup()
Message-ID: <ad491UEDZFUoxpoF@lore-desk>
References: <20260412-airoha-wait-for-npu-config-offload-setup-v1-1-f4e0aa2a5d85@kernel.org>
 <20260414124641.754059-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+y3x5upWOivh3efE"
Content-Disposition: inline
In-Reply-To: <20260414124641.754059-1-horms@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278452-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 26A7B3FA6AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--+y3x5upWOivh3efE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: 'Simon Horman' <horms@kernel.org>
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
>     net: airoha: Wait for NPU PPE configuration to complete in airoha_ppe=
_offload_setup()
>=20
> This commit adds a poll loop in airoha_ppe_offload_setup() to wait for th=
e NPU
> PPE configuration to complete before running airoha_ppe_hw_init().
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/eth=
ernet/airoha/airoha_ppe.c
> > index c2c32b6833df9..52199f6b39f9b 100644
> > --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> > +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> [ ... ]
> > @@ -1340,6 +1341,13 @@ static int airoha_ppe_offload_setup(struct airoh=
a_eth *eth)
> >  	if (err)
> >  		goto error_npu_put;
> > =20
> > +	/* Wait for NPU PPE configuration to complete */
> > +	err =3D read_poll_timeout(airoha_fe_rr, val, val, USEC_PER_MSEC,
> > +				100 * USEC_PER_MSEC, false, eth,
> > +				REG_PPE_PPE_FLOW_CFG(0));
>=20
> If the SoC has multiple PPE instances, is it sufficient to only wait for
> REG_PPE_PPE_FLOW_CFG(0)?
>=20
> Later in airoha_ppe_hw_init(), the code iterates up to eth->soc->num_ppe,
> initializing all available instances:
>=20
> drivers/net/ethernet/airoha/airoha_ppe.c:airoha_ppe_hw_init() {
>     ...
> 	for (i =3D 0; i < eth->soc->num_ppe; i++) {
> 		...
> 		airoha_fe_wr(eth, REG_PPE_TB_BASE(i),
> 			     ppe->foe_dma + sram_tb_size);
>     ...
> }

ack, let me look into it, I will post a v2.

>=20
> If we only poll PPE 0, could the driver race with the NPU firmware's
> initialization of subsequent PPEs?
>=20
> Additionally, does this poll condition properly ensure the hardware is re=
ady?
> Since the break condition is simply `val`, it exits immediately if the re=
gister
> contains any non-zero value.
>=20
> If the register retains a non-zero value from a previous session (like ac=
ross
> driver reloads), or if an unclocked domain returns 0xFFFFFFFF, this poll =
might
> succeed immediately and bypass the wait.
>=20
> Could we clear the register before polling, or wait for a specific bit in=
stead?

I guess check val !=3D 0 is enough since we reset the FE block and defualt
register value is 0 for both REG_PPE_PPE_FLOW_CFG(0) and
REG_PPE_PPE_FLOW_CFG(1).

Regards,
Lorenzo

>=20
> > +	if (err)
> > +		goto error_npu_put;
> > +
> >  	ppe_num_stats_entries =3D airoha_ppe_get_total_num_stats_entries(ppe);

--+y3x5upWOivh3efE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCad491QAKCRA6cBh0uS2t
rHlaAP4rfMeHRF6mcqYQkq2q6DoKFIguOTwyIQc/8amuWQy1qwEAkQYNgGlR1Tiy
Sp8gdjxgWaIvIlF8f9kYq/GTEaZjxQc=
=Ngyp
-----END PGP SIGNATURE-----

--+y3x5upWOivh3efE--

