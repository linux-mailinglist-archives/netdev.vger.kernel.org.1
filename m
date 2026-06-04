Return-Path: <netdev+bounces-295238-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pZ1/N8F4IWo0HAEAu9opvQ
	(envelope-from <netdev+bounces-295238-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:08:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8256E640300
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:08:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="iO/WIFOF";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295238-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295238-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D6923072AB8
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 12:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B5747B429;
	Thu,  4 Jun 2026 12:59:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D793833F8A3;
	Thu,  4 Jun 2026 12:59:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577973; cv=none; b=dXl7bzIobFWLzyFryOH0XX8Aihf/pz9m+42JPizhRaJKQC8dANoP1vwo6JZADr6qWTS0R4GSeCBq7GduH88zrvZhfqFR4lNdQGne8aAi9Gq9n7a57O7hQCKYS5aYV5LvyEgZ3osvGzjvNNVuIiY+1q9N73pEGSx+eKmkiMJfvyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577973; c=relaxed/simple;
	bh=EgMRvBu5YzRiwRNtwLh6fB99d7xpTCuSwobg5a4x1T0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KZnJJP9FIlIGhKhwfOT/CVLZ3JSQZ4H9/eTNwOCq+yrVZ/RH3S2duUb7ws88d+FDbSIP+zkImwN3qTGy6uWHmkZxttrPQqKzkwzE54sSvvXVVfwsn0ekV3f+tft5cPyVGkxUfa+L5rNsIQiXE5aH95dvdkQAdOhUQA79LytWrKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iO/WIFOF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C981F00893;
	Thu,  4 Jun 2026 12:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780577970;
	bh=obLgFgbfsTgxgYKjwNEFpJIxnlo2UXx+ip5/KtopYow=;
	h=Date:From:To:Cc:Subject;
	b=iO/WIFOF/9oAhcI20MLOKf3IawGhKBDhswAFykHuGex8EWzlJR7N+dWzbyXjC6ZNC
	 YO2RUUwJr5srOliac/s+94K0XmJIX9wBRO9M2f5LiV04S2S1cAqKw3TTMLEWUHZ5up
	 uJ8CNns26YPbpHHTqxvfYOocBFMnciQu2Yqkr9JigFKV6q6ZppjNuXMwJ853n+cDMy
	 XFfdzb/lEZ4vQ6Jyw1LS+602CyhvhIv02K3Oklatvj+sBHlNqxdky1t2Ma4o5ZxcNf
	 dde52kYOrkExUnFmfkEeC+o4YpZ18j9dq6k++A9EPeFK75tXFzhBW4oVfCE4l0GkJa
	 KAKktEvJSwBng==
Date: Thu, 4 Jun 2026 13:59:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the vfs-brauner
 tree
Message-ID: <aiF2rsdpUb5LuhmZ@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DM+wrrA3zhYr83Bt"
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295238-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:ast@kernel.org,m:andrii@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:brauner@kernel.org,m:kartikey406@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-next@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8256E640300


--DM+wrrA3zhYr83Bt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  kernel/bpf/inode.c

between commit:

  a146500e11445 ("bpf: Add simple xattr support to bpffs")

=66rom the vfs-brauner tree and commit:

  b93c55b4932dd ("bpf: fix UAF by restoring RCU-delayed inode freeing in bp=
ffs")

=66rom the bpf-next tree.

This merge resolution definitely needs a double check.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc kernel/bpf/inode.c
index c3f79b5a2f8c0,188c774a469ca..0000000000000
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@@ -842,9 -768,12 +842,13 @@@ static void bpf_destroy_inode(struct in
 =20
  	if (!bpf_inode_type(inode, &type))
  		bpf_any_put(inode->i_private, type);
 +	simple_xattrs_free(&opts->xa_cache, &bi->xattrs, NULL);
  }
 =20
+ /*
+  * Called after RCU grace period - safe to free inode and anything
+  *  that might be accessed by RCU pathwalk (inode fields, i_link).
+  */
  static void bpf_free_inode(struct inode *inode)
  {
  	if (S_ISLNK(inode->i_mode))

--DM+wrrA3zhYr83Bt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmohdq0ACgkQJNaLcl1U
h9C/xwf+Ou85YMQWM49bpHCIPdrcn1qpCkDTO7jthITlYfCXD5EYFKzsZmuvrHD0
f1f9+vwESZUIqg0M+V+xofKyFp7tkslGhZhWaf82PQjNGjnePVTAwGDfkh05JIaf
Pokq/B3I2v55oopFLxMcsMwjlWoclWcakMrGtKPavZ8t0TOzxYSiuu8+QBj/r1SJ
0VGQFIkD3DHJHap3MlEhaquZ1RJwGQWALh44IyybqbEOfGeS6GStOSeXen+ykKkT
HOawpmgONJ8dAInEwDRy07m2iGK0vcE0IxWPYZfhB5hF9V3zgrWsQowOC3/vjrl6
K1M1Im4wy0R21v0Tu6+Y8384MxwiFg==
=05SM
-----END PGP SIGNATURE-----

--DM+wrrA3zhYr83Bt--

