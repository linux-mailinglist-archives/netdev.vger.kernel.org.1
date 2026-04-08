Return-Path: <netdev+bounces-276563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIMDOxZi1mmDEwgAu9opvQ
	(envelope-from <netdev+bounces-276563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 16:11:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 965013BD726
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 16:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42F2F3060A2F
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 14:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5233D2FE1;
	Wed,  8 Apr 2026 14:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOnEJHP+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1093C9440;
	Wed,  8 Apr 2026 14:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775657415; cv=none; b=ZIDRmF/ltPfBqGc2GOTiRh+7So+9A5f94XfoDPrIvy2x6HiHPQH8WwzwUwV74isQIhsNNSeXH1SJf/lF3gKCWPb4mu83m7vxrqP4uI1rtVTAHiUFBCdZAt17d7RjlLi5dMmn9BnhZnRtlKxpCsQrO9Stl2jed07QzuZko9mMxkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775657415; c=relaxed/simple;
	bh=dAXEW/i+Kbo6bb/B2w8p6zRHdD8CxxYy/Gv2arj5Tjk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K/FRblWpZP3OVgBSMoS/M0NTAkme3vK3Hu9E2j+iGdToRGtOV35MFZdnWTOmYvj01XcOzyf1rF2zIozDT7ygfFvOuDlsBSCbzZtQgFWAPdPrvtIJCwqN5xrMV9olAGvKJnwtegQXxvCpUJmO3sd0i7pVq/Gy0JodrDL3b9G6b+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOnEJHP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80892C2BCB0;
	Wed,  8 Apr 2026 14:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775657415;
	bh=dAXEW/i+Kbo6bb/B2w8p6zRHdD8CxxYy/Gv2arj5Tjk=;
	h=Date:From:To:Cc:Subject:From;
	b=gOnEJHP+goliqm7m06a2WYC6bXyZtt23KGsuvEGCAYDCs/pSoRytHybmQ3piO3/MT
	 CX8NyGMx3yeZxWONKS/YsOjM71paJH0RVJmSArrwc4eCuQzd5MIfEvQsVhDHOg9blH
	 /41sePEdfJLmYUM4UPVC6CsDFgLJNB4r+cmK95230dWygG0Wh45GIp440M2+bQjKbR
	 P/azZbeuhUMeYOePvEqivrs2AolI9k+PQ2bBpWMEPIbci8LgoK0YHIKB6qPdGyG0x5
	 YtoTHVoer7r+p9Bx/vU9OwBGTyJfEyqpLngyoi+lP3AqmIaObb4MP/1TSua9xN3QDr
	 id9iKNulZ+aUw==
Date: Wed, 8 Apr 2026 15:10:10 +0100
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>,
	Justin Iurman <justin.iurman@6wind.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the net-next tree with the netfilter tree
Message-ID: <adZhwtOYfo-0ImSa@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u4w8RTArVaw04ONj"
Content-Disposition: inline
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276563-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.105.105.114:from];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 965013BD726
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--u4w8RTArVaw04ONj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/ipv6/seg6_iptunnel.c

between commit:

  c3812651b522f ("seg6: separate dst_cache for input and output paths in se=
g6 lwtunnel")

=66rom the netfilter tree and commit:

  78723a62b969a ("seg6: add per-route tunnel source address")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc net/ipv6/seg6_iptunnel.c
index d6a0f7df90807,e76cc0cc481ec..0000000000000
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@@ -48,8 -48,8 +48,9 @@@ static size_t seg6_lwt_headroom(struct=20
  }
 =20
  struct seg6_lwt {
 -	struct dst_cache cache;
 +	struct dst_cache cache_input;
 +	struct dst_cache cache_output;
+ 	struct in6_addr tunsrc;
  	struct seg6_iptunnel_encap tuninfo[];
  };
 =20

--u4w8RTArVaw04ONj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnWYcIACgkQJNaLcl1U
h9B8dQf/f6aVI2wZkWNTd95iVGzaYY4dAIwcCgFdyJPBUneYdP7PJOZyZAGc8IIH
5JyMCKHMVFqokIMWuLlcsOVCzthuHHNWB2Hwa89c76KF87cgXz3Gs5d98K1doPP8
VoMcm3YGNQ1qARbCscf2HPOKiyKrU3mb90ncbMYti6w4D0E62K+5YZdQIRSNkgBE
lIL/2Dl6pekFRXJVTPxWmQ1IyDHi9DngDuGZXX+toSbe2opsrozA2lFsBxjDzrJC
FE6HLJhkyl4cGc/aPXnRa+XrBRKEHqnQQ9xUpUZlR1fFcGGWNRvxyrkdeVn388vr
kluJ9ODserSet2bCmR3FDSQfEWEMRQ==
=4Ego
-----END PGP SIGNATURE-----

--u4w8RTArVaw04ONj--

