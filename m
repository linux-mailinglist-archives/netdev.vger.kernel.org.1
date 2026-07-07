Return-Path: <netdev+bounces-305404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 88lhGxXXTGqmqgEAu9opvQ
	(envelope-from <netdev+bounces-305404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 12:38:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FD671A7B0
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 12:38:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fG7eHL4w;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305404-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305404-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D18B310253D
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 10:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF7C2DA759;
	Tue,  7 Jul 2026 10:30:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEABD317177;
	Tue,  7 Jul 2026 10:30:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420234; cv=none; b=qXAMr5gAoL8mW33skW6rKN0kLcK6tQYRMnEd3oHF97Q+wTe7m2CdYq/pl9SDSLRkxvQP5IZHDV1Cn/NQAhIvmhSbKOmP4InwG7lpNDm5PCG7se+XAwxzr4nN8iI13TSqvvQyGYJXPicEccdU8Cf6lJBsCTAUZV++IGfV9YDrp6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420234; c=relaxed/simple;
	bh=P1LPUyfTT6UNum5H1lPiHnGnvr9XA7zAn97Ggh5udtA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X70dvFV7CSDX59JrQfEkNYIaX+SOSHX8sc7zKwbQIXZ05NtbPJToKTLHwHDUXRKm5NMypJOe7/EZ4rBzFvKpmHLw8MVzxyoMXYAoHufM4cm0Spzu8zAT/yec9EnsN4SO/9LI4q1zB5bO80MjXrJuxkauEVX+ddRrrGnF78A2U+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fG7eHL4w; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01ACB1F000E9;
	Tue,  7 Jul 2026 10:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783420233;
	bh=V27VjV4O2guipQj7TJBil7hD2n4t6eT/HIHVLroM7DI=;
	h=Date:From:To:Cc:Subject;
	b=fG7eHL4wb5Owayi0Cvoua3RnstPq3sZeo/FUyxWFjV/YgUgZZSakL0Nz9hbV61BAN
	 NQwREMGsOFA5XXGvXXFKnmms+6lgk51XOsA9xtP7cS+kPzhjG+VhksHtxCaZRI+9HX
	 XEC98Dt0afBO593we0EniHIDr24XJL2mpJYif5doMg6k1aU7HQPlAqaWm890JU0hcy
	 aefQJdk29gFbSBzyNHmC8OboBt/CUgdYZDeh0aRYKtT2sN3maowMr+fdziSMfvFW10
	 adb0Wpv4m7G7BQAqs1A87E2gC21GqWAhm2xJVzQWU1WXG8UBjlAo7xS321VBDv3yjT
	 n7eTfSAxgwXOw==
Date: Tue, 7 Jul 2026 11:30:29 +0100
From: Mark Brown <broonie@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Missing signoff in the bpf-next tree
Message-ID: <akzVRW-FyZ8HCDdx@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e8+9Np68LcNTiq9c"
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305404-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:ast@kernel.org,m:andrii@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-next@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sirena.org.uk:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4FD671A7B0


--e8+9Np68LcNTiq9c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit

  83a93e3b80bd3 ("selftests/bpf: libarena: Replace leftover st_ prefix with test_")

is missing a Signed-off-by from its author

--e8+9Np68LcNTiq9c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpM1UQACgkQJNaLcl1U
h9ALQgf/foItRvZA/3Ri6vG1+O/n1a71wTFxutjBdm8YxgWjCXWDi2u5MTlKxRh9
4h5nslBeD2UQ4gHy0gM0MFHbZR7lQ3UyERXVRiXacLJyXjBhC4BxpY4BLeAqy7+f
UbC4HQ0kQS+ylxKLEILBFdSwrUvWK74f7mEyeYiBjL+6SFofqwBxuwaV6TZsAfEd
xjlRCDd/7TM9v8GKaapz8besB7g5VkFeIGgJPfCnPMDbf3p9EG4yoCH7FtOeF8Ia
jKuNxiPZ8M31lIyWb29HMvQFpOxsYmAuVr5xY15mXg9odIsREnmCgCeSgKnxKzia
s7vQHZBwMPfd0QGWgE3Uv0cYkd6OZA==
=8LRB
-----END PGP SIGNATURE-----

--e8+9Np68LcNTiq9c--

