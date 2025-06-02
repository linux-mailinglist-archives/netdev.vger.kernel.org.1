Return-Path: <netdev+bounces-194634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAF0ACBA7B
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 19:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1CE73B0C1C
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 17:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31732248A0;
	Mon,  2 Jun 2025 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3c57b/q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC0D22157E
	for <netdev@vger.kernel.org>; Mon,  2 Jun 2025 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748886718; cv=none; b=etTGRGI6ciSFe/MHZ2yIZblKz9by8sjYCJLC7OLMGXw2c50LnJCvwBQjAY1PwfUF/UZ0qXw+zyiwNzFaRRTlVL3fwXjkB5rBd1w5CwR5CdKJgKifhgDx45viEjp8h3+eMA9IBgxvFpqFicAtZSdEWvxx31Erth3ZimE1g2ZaZA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748886718; c=relaxed/simple;
	bh=H20oARnwguLVFi0luYgWxOb5qnom2+HQL/iTM1arNqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtOGcaxy3GYT0PTI9yXLTvjrUXGNcQkWmnjA3qJnMeXc3tGKBDQA+2WayULhbWZXhH+4JkGcACiiPhPbf6vmRb0j8Fmskx/cGjvhIu5PnlnpEcNwvcdh5L06hLy15N69IdQC+GV7SNvsoYulvZ8LsF4lSaRy+I1obUe0DoU0SuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3c57b/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE01C4CEEB;
	Mon,  2 Jun 2025 17:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748886718;
	bh=H20oARnwguLVFi0luYgWxOb5qnom2+HQL/iTM1arNqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I3c57b/q5sC7VlHE+QTwvCeWrhi2u0XZOeLUwcTSOMHzvsgdVHVF1/e3JxL3LGYj2
	 njHmW+hCkfLrE2iWaeRNlAnhPEOdaQHxhse/btLMxpJHD+s5zqdstkYmbZJVFsBBwH
	 X5qBcWdsLJx3AVGXUS0v21Sc1t4SOLG1TdMb9frBSloqFGJDlRA7a+0jZgRcU9R6MX
	 fBpWs22G7eFTaKC1rkzNpskxb9kDB/vbnNPnYO0fnS7EoendwDw5QMTkPi+oLZUXFF
	 bWpOeZlkEKSGvJA5jltUiqygDql/EWuA8ukesb17KgfhPzT7TwFFfszDUrRvwXJr4i
	 nNJypcK4qdzww==
Date: Mon, 2 Jun 2025 19:51:55 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: airoha: Fix IPv6 hw acceleration in bridge
 mode
Message-ID: <aD3ku-c4n-im8wJF@lore-desk>
References: <20250529-airoha-flowtable-ipv6-fix-v1-0-7c7e53ae0854@kernel.org>
 <20250529-airoha-flowtable-ipv6-fix-v1-2-7c7e53ae0854@kernel.org>
 <20250530180637.GR1484967@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WGm1eKw4kD/fuTp9"
Content-Disposition: inline
In-Reply-To: <20250530180637.GR1484967@horms.kernel.org>


--WGm1eKw4kD/fuTp9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, May 29, 2025 at 05:52:38PM +0200, Lorenzo Bianconi wrote:
> > ib2 and airoha_foe_mac_info_common have not the same offsets in
> > airoha_foe_bridge and airoha_foe_ipv6 structures. Fix IPv6 hw
> > acceleration in bridge mode resolving ib2 and airoha_foe_mac_info_common
> > overwrite in airoha_ppe_foe_commit_subflow_entry routine.
>=20
> I'd lean towards splitting this into two patches. One to address the issue
> described above, and one to address the issue described below.

ack, I will do in v2.

Regards,
Lorenzo

>=20
> > Moreover, set
> > AIROHA_FOE_MAC_SMAC_ID to 0xf in airoha_ppe_foe_commit_subflow_entry()
> > to configure the PPE module to keep original source mac address of the
> > bridged packets.
> >=20
> > Fixes: cd53f622611f ("net: airoha: Add L2 hw acceleration support")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> ...

--WGm1eKw4kD/fuTp9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaD3kuwAKCRA6cBh0uS2t
rJZeAQDU2f/xsrBtwpH4Z5GZn40kGaIkjZNPpkzQMUOzR/F22gEA0l4SEdoCpmuj
iCwUL0hgCrxws4X1lZ0eEaGAYtxo7go=
=Lqy3
-----END PGP SIGNATURE-----

--WGm1eKw4kD/fuTp9--

