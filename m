Return-Path: <netdev+bounces-300087-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2olzLCdmMmrQzQUAu9opvQ
	(envelope-from <netdev+bounces-300087-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:17:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 278F3697D19
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:17:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Tc2o8afQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300087-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300087-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 388B0300852F
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 09:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9493F39A7F2;
	Wed, 17 Jun 2026 09:17:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87603399350
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 09:17:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781687843; cv=none; b=j2viA8TyHNbRjGurDC6HNa1yvi1jLHxbELZsO7lt9+drE/sNDmYsnSeREoCO5CjthM36vYfqmGhCvEkZp2+KI2hvazIZBKGFIbfY/WPWzqPkcGQdJBR8TOAHT74FyAEdhNbJN5vK7U+YQ5cXhPcg82pNwEZVrY5eUcv62Ik7RCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781687843; c=relaxed/simple;
	bh=NKLImyI3HYH86Vh5hC947ygnor4EsnF46Gid2tc64Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYYwEhfXwRLzAY5jaoM99SxWFr054gCNmofaMYLqHtVsGiUUMrF8klwJ0cMph7uvlPrSs1fAA99Ra7bTS5ZyPHurvjolcc3zEM8M7zzAJoFTz+Dejs3QMb5MEnAZqFG4CeD+AK4IJc7o6zc3zuqx83Srq25eHek+IDmb5e1jp3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tc2o8afQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B671F000E9;
	Wed, 17 Jun 2026 09:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781687842;
	bh=ZnXuxdsvCZXi+yhcRRlP0nnKlUJzsEw2xOj6/CVvJuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tc2o8afQpKiwso4i+pUMbegXm9w4FdsldOJEIycWlQuBKzvzKP/80uB25ERY7H9to
	 rlTBV9HS2My1rfz+o5ejfrZv7pxmZVA/3VLl0xw+1VpT9WdMAaKAWs2fQlF642MRWp
	 R0fZrndsiKF6U6XD4tFD/tYT8DBjO/HryBTGwlRuKeptvYqTlfyqRpuLmqBTa3OAwh
	 9j9K164Ij7Ja+gPqjqgK4f0zErjFpRDU0dtYxFsvmZ3zYO7nwHGO0sOdRGvdsT3kqX
	 /nGioXXdZFVhPWbAzswPyQ096Fsff7VYQk1V1GJ3Rz20/AAqQwlk9iPVEJZVPjwkyo
	 zcJ2kCDF+XuZQ==
Date: Wed, 17 Jun 2026 11:17:20 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, nbd@nbd.name,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: airoha: Fix TX scheduler queue mask loop upper
 bound
Message-ID: <ajJmIIpju9P3oyne@lore-desk>
References: <178166704952.2212140.11002626760717132754@gmail.com>
 <178168650178.2224380.3950331731013129336@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VyUTMvxzWiaGc/iq"
Content-Disposition: inline
In-Reply-To: <178168650178.2224380.3950331731013129336@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:win847@gmail.com,m:netdev@vger.kernel.org,m:nbd@nbd.name,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-300087-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lore-desk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 278F3697D19


--VyUTMvxzWiaGc/iq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, Jun 17, 2026, Lorenzo Bianconi wrote:
> > Even if the current codebase supports just AIROHA_NUM_QOS_CHANNEL (4), =
the hw
> > exposes 32 hw QoS channels (AIROHA_NUM_TX_RING). Here we are just clear=
ing the
> > configuration, so I guess the current implementation is correct.
>=20
> Hi Lorenzo,
>=20
> You are right that there is no functional impact, and I agree this
> should not go to net. Let me explain the register layout I was worried
> about, and you can decide whether it is worth a net-next cleanup or
> should just be dropped.
>=20
> The two macros are:
>=20
> 	REG_QUEUE_CLOSE_CFG(_n)             =3D 0x00a0 + ((_n) & 0xfc)
> 	TXQ_DISABLE_CHAN_QUEUE_MASK(_n, _m) =3D BIT((_m) + (((_n) & 0x3) << 3))
>=20
> REG_QUEUE_CLOSE_CFG() masks the channel with 0xfc, and the bit macro
> folds the channel with & 0x3 (mod 4) shifted by 3. So one 32-bit
> register holds 4 channels x 8 queues, 8 queue bits per channel:
>=20
> 	channel 0 -> reg 0x00a0, bits  0..7
> 	channel 1 -> reg 0x00a0, bits  8..15
> 	channel 2 -> reg 0x00a0, bits 16..23
> 	channel 3 -> reg 0x00a0, bits 24..31
> 	channel 4 -> reg 0x00a4, bits  0..7
> 	...
>=20
> In airoha_qdma_set_chan_tx_sched() the loop variable 'i' is passed as
> the *queue* argument _m, not as a channel:
>=20
> 	for (i =3D 0; i < AIROHA_NUM_TX_RING; i++)   // i =3D 0..31
> 		airoha_qdma_clear(qdma, REG_QUEUE_CLOSE_CFG(channel),
> 				  TXQ_DISABLE_CHAN_QUEUE_MASK(channel, i));
>=20
> Since each channel only has AIROHA_NUM_QOS_QUEUES (8) queues, the correct
> logic is to clear the 8 queue bits belonging to 'channel'. With i running
> up to 31 the BIT() shift instead walks past those 8 bits and into the bit
> ranges of the other channels folded into the same register. For channel 0
> the accumulated mask becomes 0xffffffff, i.e. it touches channels 1..3 as
> well.
>=20
> This is harmless today only because REG_QUEUE_CLOSE_CFG is written
> exclusively here, via airoha_qdma_clear() (RMW clear), and the register
> resets to 0 and is never set anywhere -- so clearing extra bits is a
> no-op. Functionally the current code is fine, as you say.
>=20
> The point is just the loop-bound semantics: 'i' is a per-channel queue
> index, so the bound should be AIROHA_NUM_QOS_QUEUES (8), not
> AIROHA_NUM_TX_RING (32). The two happen to be related (32 =3D=3D 4 channe=
ls *
> 8 queues) but mean different things.
>=20
> Since there is no functional change, feel free to drop this if you would
> rather not carry a cosmetic patch. If you think the clarity is worth it I
> can resend against net-next without the Fixes tag.
>=20
> Thanks,
> Wayen
>=20

Sorry you are right, I misread the code, your patch is correct. Since as you
pointed out REG_QUEUE_CLOSE_CFG() is actually never set at the moment and t=
he
default register value is 0, I would repost this patch for net-next as soon=
 as
it is opened (this will avoid merge conflicts).

Regards,
Lorenzo

--VyUTMvxzWiaGc/iq
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCajJmHwAKCRA6cBh0uS2t
rFNyAP9PkgQvfxp6CioRi0IbaYkDxw09bkje9eUMjIyNtTw65AEAnUSecAOlA8Ng
x0S8I6Vr7K3l5fdREJxsd22doNsKKwY=
=kBNZ
-----END PGP SIGNATURE-----

--VyUTMvxzWiaGc/iq--

