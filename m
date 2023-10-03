Return-Path: <netdev+bounces-37549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C46A27B5E89
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 03:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 6F2171C20825
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 01:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1535763D;
	Tue,  3 Oct 2023 01:19:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C08634
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 01:19:54 +0000 (UTC)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA3FBF;
	Mon,  2 Oct 2023 18:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1696295987;
	bh=8FPUqQ2tGHzRi6jvQYSkQAbQgwzDG1edMbYV+4jhFQQ=;
	h=Date:From:To:Cc:Subject:From;
	b=qU0eHRV8g20jDk45yHEWbe4WsHY1Y5I9xvqwoCa3qpUTv5dbppC4QFZlrUBGd9soC
	 Mc7z/LsLtYIyyX0zNMOM/T2Kq+cFg0D1OQ5Sm1vf1oG8WFj4fD51tRmI5z8CQVW7aZ
	 GBLSH7raB2W08fK8ZSK16mcucV8yR1HZCKrrDTBHqguR0LbooAuxGe0KfNp8KwEpYp
	 mYwGVDMFhzvmb3rDT1/NtK9Q8BKsY6CCSQWifsL2Mwk5Fv6YrbCJk+GKMAC8gv68Vt
	 oZkRPyIk8RZzquvA8IQgW2ClcYgoaV/WHzoG3uCCAtNi94+3Z2wLm1iORUAzkopoCS
	 0mH64mRMGhJNA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4S00Nf5ZGyz4xPf;
	Tue,  3 Oct 2023 12:19:46 +1100 (AEDT)
Date: Tue, 3 Oct 2023 12:19:45 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
 <johan.hedberg@gmail.com>, David Miller <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Networking <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the bluetooth tree
Message-ID: <20231003121945.3f5b6a07@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1qfh..isupAFvsP_MnhTPqJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--Sig_/1qfh..isupAFvsP_MnhTPqJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the net tree as different commits
(but the same patches):

  0ef9e5c1af4c ("Bluetooth: ISO: Fix handling of listen for unicast")
  190b32220f99 ("Bluetooth: btusb: add shutdown function for QCA6174")
  2eb5e4369bc4 ("Bluetooth: Avoid redundant authentication")
  8ee19a4f17bc ("Bluetooth: hci_core: Fix build warnings")
  9f0fcb5aa550 ("Bluetooth: Fix hci_link_tx_to RCU lock usage")
  b78e04e5f353 ("Bluetooth: Delete unused hci_req_prepare_suspend() declara=
tion")
  c0c64dc267e4 ("Bluetooth: hci_codec: Fix leaking content of local_codecs")
  da10fc7a9dc3 ("Bluetooth: hci_sync: Fix handling of HCI_QUIRK_STRICT_DUPL=
ICATE_FILTER")

--=20
Cheers,
Stephen Rothwell

--Sig_/1qfh..isupAFvsP_MnhTPqJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUbbDEACgkQAVBC80lX
0GxxBQf+MOoeUJlVz+LXnquZtn5h5+KRuI3S0BcRp03KTU6ryhfZiMc9qiXFazHO
rPvTdVca0SYpBgv8KtUMWvm8iyxH/MjXUQdDyjP7aMuLKl8gRvLxhAymokLkbFBw
iQoslGiTNfa/n6LUw58+LogR2/4vlihM8c4wvASpk85eQUeyv708CB+ZNi7o2KuO
7g9sB3IGFwMZPGP2jy9y2ejWWuSA4mZ8rKkuMFj+oi4Ie+z/+MaeK3ALvlFa1aOE
9VfhcbKk4ozPVuyf/KL7AkGHP8UjRQQZCjpSD+GaguuE9knxvC5f250oH4QohOgm
dtgjDRbInUx/bQcJWT2Ag/HdVy965g==
=FckR
-----END PGP SIGNATURE-----

--Sig_/1qfh..isupAFvsP_MnhTPqJ--

