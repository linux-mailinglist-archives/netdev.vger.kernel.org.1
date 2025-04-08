Return-Path: <netdev+bounces-180506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BFFA81944
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 01:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D6B74A01A2
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 23:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BDA254B02;
	Tue,  8 Apr 2025 23:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gyst2M4A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7102505A6
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 23:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744154599; cv=none; b=PZ0uUJyOT+arz1NJ67+busswppcwcY1OB6KaXsFhvb/UAyzB40f+LhmxD0qAfH7qiMFVFwkEaGq1GVTqzS5mPnfxMju+n+R2xQMpN3GG8CWq6PdavjnQ4Okdge+T7zWZclXFQOzANVYpCb92oy5FPhTlTYvBb8WkuT7HJVyisZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744154599; c=relaxed/simple;
	bh=AmfA72V8Vw03Zdmlew9o49WWKH6ePWrUbPUuTBpunUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXc8lQMuzMXnf5jGQIzEGWjFOS1HKdEPA6clIpIT0axwBt//iXvcDzs4+q/mfDfKHcS9kcJpLv/eOiJNaX34wOvSOYLiuLiwQrHaVtM2g1yAHQCZNydyA2/C++WhyjHvHv16vzu8Uma2uUmL0tCoQdGd3QgeU33vuU1t2IhDurc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gyst2M4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF9EC4CEE5;
	Tue,  8 Apr 2025 23:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744154598;
	bh=AmfA72V8Vw03Zdmlew9o49WWKH6ePWrUbPUuTBpunUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gyst2M4AwzOVJegnnBiZF/Y4KoVPdq/VYsKbwqL86ee5PVcx4wKdLzFdI8Xubhj4M
	 /hE9Df/AwToq/vAlPZEv51QWFGmX54H9fqngPx7FvDLnhX/JDhX/6woTd0YewpdWKx
	 pRBRJKsGEZM3wVceaOOrZsBCvgRkmN8lZo00LIzMOfSYEZxwHitMW0lmezxbc5Dni2
	 l8DVyaIofT8c4VJIEte3GCxWetobkSW1OGZDQF1BuS4agwenOdeWVOmz23SgWYiWEu
	 CU0g+j3/CCsMT0+f3yVCt3WBg6+EUCmseAaKiY/2ndGxRDn+7fmoNyOeoqYrxnGgNf
	 HbyiemZYbbDsw==
Date: Wed, 9 Apr 2025 01:23:15 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: airoha: Add
 airoha_ppe_foe_flow_remove_entry_locked()
Message-ID: <Z_Wv458ebLOBlvHp@lore-desk>
References: <20250407-airoha-flowtable-l2b-v1-0-18777778e568@kernel.org>
 <20250407-airoha-flowtable-l2b-v1-2-18777778e568@kernel.org>
 <Z/WDPBMIPSCkbg9e@localhost.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fHlcF3L1BnZPAha3"
Content-Disposition: inline
In-Reply-To: <Z/WDPBMIPSCkbg9e@localhost.localdomain>


--fHlcF3L1BnZPAha3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Apr 07, 2025 at 04:18:31PM +0200, Lorenzo Bianconi wrote:
> > Introduce airoha_ppe_foe_flow_remove_entry_locked utility routine
> > in order to run airoha_ppe_foe_flow_remove_entry holding ppe_lock.
> > This is a preliminary patch to L2 offloading support to airoha_eth
> > driver.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> Could you please explain the reason of introducing the *_remove_entry_loc=
ked
> function if "airoha_ppe_foe_flow_remove_entry()" is still never called ou=
t of
> "airoha_ppe_foe_flow_remove_entry_locked()" context (at least in this
> series)?
> I would expect that it can be useful if you have an use case when you want
> to call "airoha_ppe_foe_flow_remove_entry()" from another function that
> has already taken the lock, but I haven't found such a context.

ack, you are right. I guess we can drop
airoha_ppe_foe_flow_remove_entry_locked(). I will fix it in v2.

Regards,
Lorenzo

>=20
> Thanks,
> Michal
>=20

--fHlcF3L1BnZPAha3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ/Wv4wAKCRA6cBh0uS2t
rD6jAP0VCuU67+0Hmp6FoJCYXcDJXP2tbLCdbL7J9QZsGtWOVAD+LNXbCESniFgd
w97KzvP3u3bXDzN6nfqYBcqzw9afugY=
=Tg6q
-----END PGP SIGNATURE-----

--fHlcF3L1BnZPAha3--

