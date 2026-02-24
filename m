Return-Path: <netdev+bounces-260508-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEvhITycnWnwQgQAu9opvQ
	(envelope-from <netdev+bounces-260508-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:40:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA9A187161
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CDA18302B46C
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E8D3815C2;
	Tue, 24 Feb 2026 12:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmeYc8Xm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D2425A2C9;
	Tue, 24 Feb 2026 12:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771936778; cv=none; b=jpTSemmc1KUbpYHB6BSVnw3kvwtzAL8/KeZdHoMKtGOKiCHRq0GLO2Ep7jj049EOKLZo/rC73jjuo6VMcpENJ/OuqspLZs3k1pg//u6FiJkHZcfF8Mxj6tpbWsJL2rvoXGyAua+LacZSAzxx2w29q3MwGZ9OqtkbXzT+6PXd3mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771936778; c=relaxed/simple;
	bh=YKI1upsRFHpQ70GhUF+nMVLZfbcZ0yrmnGFgevv0qF4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mRaSnPbnXVZgQjDq1i4M7EtrUpu7mX5dA9EHwZd2Hz5JtGcTJj2QH2eE4x3WmS+DVBSPv0VPVWRleVTNfLJrnoVt8WP2MaBnCnBRjDJKLqQlkMCA9JipC32sPQnKzBxvg8Solasf+Tk6CIAg/rtgFVYFkd5Yv7Oe5s45A+8bO2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmeYc8Xm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0A8C116D0;
	Tue, 24 Feb 2026 12:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771936777;
	bh=YKI1upsRFHpQ70GhUF+nMVLZfbcZ0yrmnGFgevv0qF4=;
	h=Date:From:To:Cc:Subject:From;
	b=UmeYc8Xmc8q6Ktw+pmpjpo4rcg2rpxPqLSrwhmop88ELBL6oqGNEFUfyO8nY4jYQV
	 njgml2tRuM0x+L5NVrghIbPf5VhJmV8K/sj9s1GcfqaPxOpyksU7kKSkq6wxd/sQZu
	 HGvo4R002MKuxjywktj/HwrpgJJ0CUqQSFQUQnxVB2v6XJF3iePXxJJ/vifAPer+sw
	 5cHFlAEzvJLq48o7hyaaQFesLtuWs9H6N91DjY9w4oa6QfLpvlhqELvaIS/+gsbdn6
	 v6heGMiR7IF8V8vbEkGWopsSbzFnDLNpaCWw/4OA90O6NjwQACnp8PhU9B2n05Bsqb
	 2iANhGgZ4e5nQ==
Date: Tue, 24 Feb 2026 12:39:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <aZ2cBWyiG_fKSjIq@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MRWQfcW/ZMqR3ZoK"
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260508-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Queue-Id: CBA9A187161
X-Rspamd-Action: no action


--MRWQfcW/ZMqR3ZoK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  tools/testing/selftests/bpf/prog_tests/align.c

between commit:

  05849ec34f3d7 ("selftests/bpf: Replace strncpy() with strscpy()")

=66rom the bpf tree and commit:

  f632de6e19553 ("selftests/bpf: Migrate align.c tests to test_loader frame=
work")

=66rom the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

(deleted the file)

--MRWQfcW/ZMqR3ZoK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmdnAQACgkQJNaLcl1U
h9CPLwf/WVi/v65yvxIWLU0e2i7lyr7/Gx18hXCvU8X+jNYcVqEmOjTGksRrkwEH
FhZBM8r6iOWq7LXevWqXgtlNfs8u+M7zwWw/GgH6aubqBGo84PMiNei66qhlLLWl
WTtkhpcazy5qizI/h3SXNJw0ywMUX8OefTRfpyJ0ywhEe/gi65QMeFMdwzv9rF4V
/V981ojtcQ46skIMA/YfDoEGTRnoOJOzEIoRg94HBKYMLOsjvqz87CF5hq1mcpKJ
Ol8MYGIhVF8GSOWM8/u613hTCrL9SZ+H+RJDBcjPo/GKlOb4BIh9hA+QZ64DiGgD
+tPDXy5IebLIo8HQX1qPApehFenxEA==
=fAsj
-----END PGP SIGNATURE-----

--MRWQfcW/ZMqR3ZoK--

