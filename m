Return-Path: <netdev+bounces-261002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA4XDpUQn2neYgQAu9opvQ
	(envelope-from <netdev+bounces-261002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:09:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0B319938E
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D061B305328C
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1393D4104;
	Wed, 25 Feb 2026 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="co2AlpS4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C25A3D3D03;
	Wed, 25 Feb 2026 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772031821; cv=none; b=PbIQeW9D0kuWJZan9fLOvLW4x+ud0AGPIQnQtkCtnbpmu4oYt4CdVbgsaaHNlv0orkvg85UlVhTNPhDGo2BKjMOLnjBPAu7ziM1ADLfBO3EWK+hhBUQSK5uEwfRO7+D6lTWgZqusnxnKrsIyWo8P3a/wyTfTsOFZ6fo1o1Psssc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772031821; c=relaxed/simple;
	bh=QN7ZJdtc/ozhlLaHW7uYptsjLSToVtIBzHuU8im4kWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VSGq6UU8vkIE9jELdEvZ+DYxZgE2h4C5bYCpfaWEPvxVYLC7iurAEWGNgUoN9IevWkYtRVdqPxalrkZE434uhhrOvr+k7Fv/cYh19qDhRI5Y6NSFUlZ/J5z/2ocZgl4HdyhSVbhv3wwEDUICvyGPv7fSPS1gxAyVE17/Ja8aeOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=co2AlpS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD7CC116D0;
	Wed, 25 Feb 2026 15:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772031820;
	bh=QN7ZJdtc/ozhlLaHW7uYptsjLSToVtIBzHuU8im4kWQ=;
	h=Date:From:To:Cc:Subject:From;
	b=co2AlpS4vccR71sVZhjLLQB/sBtysZ0Gax8OcAyig2RHhbQH3rCWGENT0hpzF3dag
	 ChTTsW/XGpdzxjfl84Bbcqg26wOrELu4NT9w7QJXyfeOrP7iJ60WSQODJ61eNDA5+H
	 YN+Yklolv4pNJou1qESNUzIsADhIMwN1d6SY4M+oBjs9FD1S5ngb2zD6+IKSIgEMtS
	 1/31MUMQea2LvX5jSwyoGj9u38FoYVG9NrzVyQa9dCSAFTU2zdc41qHKeJ5oh6O3EU
	 zMDVV2MfklThyIA27kYhUNAlKxPq3fkWBff+vlbD8yzwu7R4FMBVLMVILNR5UEOTxs
	 830vylWV/LSJg==
Date: Wed, 25 Feb 2026 15:03:36 +0000
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <aZ8PSFLzBrEU3I89@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QMKYyv9/62lws9d/"
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261002-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF0B319938E
X-Rspamd-Action: no action


--QMKYyv9/62lws9d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  include/net/inet_connection_sock.h

between commit:

  858d2a4f67ff6 ("tcp: fix potential race in tcp_v6_syn_recv_sock()")

=66rom the net tree and commit:

  fcd3d039fab69 ("tcp: make tcp_v{4,6}_send_check() static")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc include/net/inet_connection_sock.h
index 5cb3056d6ddc7,bbc9355871c76..0000000000000
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@@ -42,10 -42,7 +42,9 @@@ struct inet_connection_sock_af_ops=20
  				      struct request_sock *req,
  				      struct dst_entry *dst,
  				      struct request_sock *req_unhash,
 -				      bool *own_req);
 +				      bool *own_req,
 +				      void (*opt_child_init)(struct sock *newsk,
 +							     const struct sock *sk));
- 	u16	    net_header_len;
  	int	    (*setsockopt)(struct sock *sk, int level, int optname,
  				  sockptr_t optval, unsigned int optlen);
  	int	    (*getsockopt)(struct sock *sk, int level, int optname,

--QMKYyv9/62lws9d/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmfD0cACgkQJNaLcl1U
h9Dofwf7BX6pxkyrHNFlvAU7ffZ/Q2hssJ8XCjwdBJXKoxWISMCUCUAOy0En9lzO
kVRXlFPfkztphCl9Pj4wD6C08Jix5E/tqmkDgInKSNafHR2zcD819D3NALLx9pd4
Z3yIQJvuZcsikuMBYUupuOopb0Flp3VvUgAVlPSdQY9PADZnxW7l6QD6RxEya8Ep
JySihEGGPrNbtO/7/15cJYTInuGaUUikSe95u5d3a9nsVSZowNo/rZ5ujK8N6hdr
WPEFUBGMUIn6dO0tc8jgPoLnne8nfXz3h3a4uU82YW2UiAmcRQp7wFhWInG0kKFN
h7c4k/Dntn5Kf1hInM91w429n31o+Q==
=LLwQ
-----END PGP SIGNATURE-----

--QMKYyv9/62lws9d/--

