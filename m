Return-Path: <netdev+bounces-43688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C837D43E1
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 02:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8E1BB20CF5
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 00:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46494110A;
	Tue, 24 Oct 2023 00:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="B8VfHiqk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5688F10E5
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 00:24:31 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8AA10C;
	Mon, 23 Oct 2023 17:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1698107068;
	bh=VHG3qd0ihqSbQoervLNrF0qsR2BSCx5XwGkeZm5mMJw=;
	h=Date:From:To:Cc:Subject:From;
	b=B8VfHiqkm/9nfuJmVNKEvFAeiPqH1H0ap5GAPk+cBi5qGgddSX30Zy7qdV2kEDa7S
	 e89qqkyBRrHXoOGMrP25V/aHizh+IzgOKBWBX1xd0YQxaRWVEw6yfNw2DoOdP9LA/j
	 S0ig817d0NhJjZmma2iQr6mvsAVviY8RxE++ZaPZaD4yBmy6vKbga17IlAQaS6WA8k
	 mrOvPY4z7qU4xwrcPNPRZkdzdgv1Ly7kMVtahTWePkuz0o6+QTF0wyFdqQA1HnuJlh
	 dnWEBTLAxzwD1BMrEPC0Le3eOsfa+RXA0wGtco1oo1a7BaXZsf50uaHNTt+ZCsZyac
	 hpBg3E4Y0DaPg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SDt964JWwz4wdB;
	Tue, 24 Oct 2023 11:24:26 +1100 (AEDT)
Date: Tue, 24 Oct 2023 11:24:24 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kalle Valo <kvalo@kernel.org>, Johannes
 Berg <johannes@sipsolutions.net>
Cc: Wireless <linux-wireless@vger.kernel.org>, Networking
 <netdev@vger.kernel.org>, Avraham Stern <avraham.stern@intel.com>, Gregory
 Greenman <gregory.greenman@intel.com>, Johannes Berg
 <johannes.berg@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the net-next tree with the wireless
 tree
Message-ID: <20231024112424.7de86457@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Nw9FIGoSTm34d8mrxtC=U0K";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Nw9FIGoSTm34d8mrxtC=U0K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/mac80211/rx.c

between commit:

  91535613b609 ("wifi: mac80211: don't drop all unprotected public action f=
rames")

from the wireless tree and commit:

  6c02fab72429 ("wifi: mac80211: split ieee80211_drop_unencrypted_mgmt() re=
turn value")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc net/mac80211/rx.c
index 8f6b6f56b65b,051db97a92b4..000000000000
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@@ -2468,14 -2469,15 +2469,14 @@@ ieee80211_drop_unencrypted_mgmt(struct=20
 =20
  		/* drop unicast public action frames when using MPF */
  		if (is_unicast_ether_addr(mgmt->da) &&
 -		    ieee80211_is_public_action((void *)rx->skb->data,
 -					       rx->skb->len))
 +		    ieee80211_is_protected_dual_of_public_action(rx->skb))
- 			return -EACCES;
+ 			return RX_DROP_U_UNPROT_UNICAST_PUB_ACTION;
  	}
 =20
- 	return 0;
+ 	return RX_CONTINUE;
  }
 =20
- static int
+ static ieee80211_rx_result
  __ieee80211_data_to_8023(struct ieee80211_rx_data *rx, bool *port_control)
  {
  	struct ieee80211_sub_if_data *sdata =3D rx->sdata;

--Sig_/Nw9FIGoSTm34d8mrxtC=U0K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU3DrgACgkQAVBC80lX
0GxQowgAjrrkc0sOifGahOamyKGt/SatG8ExWc66k2mkZDrxIkTp97v9XTACMawX
ghc6Tr6alRgFWvjNGXGDZkR/l9nEqOz+UQKzjRV7FL3RtssbglmEQvO5B7M0XO1L
LmZPuQIk1fbMIh9fC5QwFjQkQvRCH0E0IcFvwmqx6WGg/F+8a8HhM9gQPyhIy0UD
nZCrQR938eNkEfWUJPJSWA4c79NYYwzxqgyAO7+wYRw/ywj56wMEEKN6TEujjed9
k3knHieuIrlgjbSPDTlkIbqTq0p+7U46xOmhuybHn7aIDTWPKts+91suTTrTnZHJ
sCqklT3h+BQlsNlrTSSR9iOC6oJBzA==
=zLiy
-----END PGP SIGNATURE-----

--Sig_/Nw9FIGoSTm34d8mrxtC=U0K--

