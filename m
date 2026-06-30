Return-Path: <netdev+bounces-303389-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y1WHK1hARGqgrQoAu9opvQ
	(envelope-from <netdev+bounces-303389-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 00:16:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 034536E85B6
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 00:16:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kMHgZF4B;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303389-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303389-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9387304C10A
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 22:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA3828CF5F;
	Tue, 30 Jun 2026 22:16:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1F72405E1;
	Tue, 30 Jun 2026 22:16:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782857814; cv=none; b=DG8uOQZfJATcpGFKRuPuqAeGm9gevou709CGWdPzarpPTp2dqnTgRbkFJW0lx978yZJimrm/jgvles7wPsJymDAQvokjbsI0lat+VxeyIq0YfwXaX/kwA1MlxwKwy5LcvOVgqDYO9M1vTfdumzxk1XHM+Ap+BfrreF6L1OU2/i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782857814; c=relaxed/simple;
	bh=htrANcxd20nmrILXwJpsOCDJVICGkLLOXJVouWan+x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4/LyJV5RhIxiyWJWc6PAWh921/dSkHW2Oj3qLsNXAWch0FQmPcOzWBWjVCQy8RyeuyVewF/3XZwvS1eFmwZop7gIV50NlvS9MHOVgcPiPB9xhqur09D1TuQxdGnlJ+S+8AzivRZ74TNylNRk+Yh2/+e6ASbjdD9xUBbRFcAnWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMHgZF4B; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCA11F000E9;
	Tue, 30 Jun 2026 22:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782857812;
	bh=DGltGEycY+hCI/dvIu1mTklnBJ/JnDR2WIlHuuRxAUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kMHgZF4Brk/SBFDdKiygIwML/E2u0M6ucnpL8qOX70RwLlQsAqlL7E7rYBNrKlNz0
	 9YnCOk0VLQHXe/WHB5xHI4RoyO9YXPWmhE+Wqh9X1ztAyAXCtKkgOHveeNm0FRk0aa
	 NxLuQnU8iHtYKhgNSmtrQuw3o8EFtUTA4nP+kXhET1ZBZnAedK6Ya0+CaHT8SxT2Zk
	 DfIbK40rCHUXjUBjNpZnakArNCRLTHoEC6BN8fRUDOM0TTmSApwbzbOH2x6GERet3M
	 rGmfbFsCwEST7dHNxVHerJQJ07eQifuwPxYC11kDOxIHUF3JpIM7d3kbzBpzNgwfTQ
	 aVfc5BYfoEQNA==
Date: Wed, 1 Jul 2026 00:16:49 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Vladimir Vdovin <deliran@verdict.gg>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
	hawk@kernel.org, john.fastabend@gmail.com, kuba@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 0/7] xdp: RX checksum metadata hint and
 checksum assertion over redirect
Message-ID: <akRAUTAqVKkxmoVa@lore-desk>
References: <20260630191510.81402-1-deliran@verdict.gg>
 <akQyT2d0wNF5F5LG@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2QzZE0hPxBRkFxHX"
Content-Disposition: inline
In-Reply-To: <akQyT2d0wNF5F5LG@devvm7509.cco0.facebook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:sdf.kernel@gmail.com,m:deliran@verdict.gg,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:sdf@fomichev.me,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:sdfkernel@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-303389-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[verdict.gg,vger.kernel.org,kernel.org,iogearbox.net,linux.dev,fomichev.me,gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 034536E85B6


--2QzZE0hPxBRkFxHX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 30, Stanislav Fomichev wrote:
> On 06/30, Vladimir Vdovin wrote:
> > This series lets XDP programs work with the hardware RX checksum verdic=
t:
> > read what the NIC concluded about a packet, and carry a "the L4 checksum
> > is correct" assertion across a redirect so the stack does not revalidate
> > it in software.
> >=20
> > When an XDP program redirects a frame to a cpumap (or any other path th=
at
> > rebuilds an skb from an xdp_frame via __xdp_build_skb_from_frame()), the
> > HW RX checksum status is lost and the stack revalidates the L4 checksum=
 in
> > software.
> >=20
> > Two kfuncs are added:
> >=20
> >  - bpf_xdp_metadata_rx_csum(): a device-bound RX-metadata hint, like the
> >    existing rx_hash / rx_vlan_tag ones.  It reports enum xdp_csum_status
> >    (XDP_CSUM_NONE / XDP_CSUM_VERIFIED) and is implemented for mlx5e, ice
> >    and veth.
> >=20
> >  - bpf_xdp_assert_rx_csum(): a generic, non-device-bound kfunc that lets
> >    the program assert the L4 checksum is correct.  It sets a buff flag
> >    that rides into the xdp_frame, and __xdp_build_skb_from_frame() turns
> >    it into skb->ip_summed =3D CHECKSUM_UNNECESSARY.  The kernel cannot
> >    verify the assertion; the program takes responsibility, as it already
> >    does when rewriting packet contents.
> >=20
> > Posted as RFC to get feedback on:
> >=20
> >  - whether the read hint (bpf_xdp_metadata_rx_csum() and its driver
> >    support) belongs in this series at all.  bpf_xdp_assert_rx_csum() is
> >    self-contained and already covers the main use case: a program that
> >    computes or fixes the L4 checksum itself, or trusts the source, and
> >    wants the rebuilt skb to skip software revalidation.  The read hint =
is
> >    an optimization for programs that did not touch the payload and only
> >    want to relay the hardware verdict.  These could just as well be two
> >    independent series (assert-only first);
> >  - the kfunc naming, bpf_xdp_assert_rx_csum() in particular.
> >=20
> > Testing:
> >=20
> >  - new selftest xdp_cpumap_rx_csum drives a frame through a native-XDP
> >    veth into a cpumap redirect and checks, via fexit on
> >    __xdp_build_skb_from_frame(), that the rebuilt skb is
> >    CHECKSUM_UNNECESSARY iff the program called bpf_xdp_assert_rx_csum();
> >  - xdp_metadata calls bpf_xdp_metadata_rx_csum() over veth and checks b=
oth
> >    verdicts: XDP_CSUM_NONE for an AF_XDP-injected frame and
> >    XDP_CSUM_VERIFIED for one sent through the stack.
>=20
> This was posted somewhat recently from Lorenzo (and had a fair bit of
> discussion), but there haven't been a follow up:
> https://lore.kernel.org/bpf/20260217-bpf-xdp-meta-rxcksum-v3-0-30024c50ba=
71@kernel.org/

Hi Vladimir and Stanislav,

AFAIK in my series we are just missing the drv self-test requested by Jakub.
I have not the time to look into it yet.
@Vladimir: if you have any free-cycles, do you agree to introduce the missi=
ng
 test requested by Jakub to my series? Thanks in advance.

Regards,
Lorenzo

--2QzZE0hPxBRkFxHX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCakRAUQAKCRA6cBh0uS2t
rJlfAP9EMrP2/gOvhi9eqC1JNW/IWpiF6PrNN6R2YRl24hFYlAEAz/5TB17FzPlv
NM+ZJLjwBy9VKzOmrrIYnBhkMsAr8wM=
=X6ts
-----END PGP SIGNATURE-----

--2QzZE0hPxBRkFxHX--

