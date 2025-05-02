Return-Path: <netdev+bounces-187375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAA1AA6B84
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 09:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411F61BA5F59
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 07:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B173321A94F;
	Fri,  2 May 2025 07:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAkB8YHC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5CD1A0BC9
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 07:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746170693; cv=none; b=AOMOiDIW8P2pCYVaIaZnAN1m+7mlvZOz0wLMQnp+RoeNuTW4giBCZrxEX/CDqU0CYCOWnKCwolNPbYmuYQZii9JXT3LvtWvZ5YfWw5bc8h5U0PA5+0q3nOfacBURbpbRhi7yHIvPrP4Bq2ObBvvyZqCNiAFVUFv5cTnVJZl6cl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746170693; c=relaxed/simple;
	bh=xBVcTSqslDhrYoHxQhgGftWrfyvr7UPOdVSdqhSYldQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwo4QGCzEAFHh7rAZQ9hyfiGTIgk4TmbJNfMv2SK/CCK2W6OIx4Qy5IOyEYw+/gjDJryHnl5R/aKPk8IcUzmtAG8Z+eGDbNDyPF0yGTHLpSkcGiApCyRsQTdxtQb1blGpTJFj48eORtV0NVwA8UZOyI0DkavVDlddyBJObwAtt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAkB8YHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EE4C4CEE4;
	Fri,  2 May 2025 07:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746170692;
	bh=xBVcTSqslDhrYoHxQhgGftWrfyvr7UPOdVSdqhSYldQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FAkB8YHCAzyCDzXwJKoSUPr5WZ6fEnearravg1Of1dPwt3uTGeTIOom6RrQPiD0CY
	 4Yf0xHar9Z84goeBj0zNLvwgK3Rjy4d9RbXBGylAlhap3YIwo5PkR0SeF0W3d8KaV1
	 2Id6Xisig1TJQMEwnYWo0ilFsvbRyXE8MavWucAjtntnlEDIzGRsD8vLNEzfl4LW9X
	 +GCbyZudlxvGHkep/kcrPIdE9S/gbYv4OEzWD5aGLjWFV1NRNTKekgs6yVc4CWWQgX
	 cRw+Zg4oWvAd8ge6kbNaRk5m1hjwEstQ9vNg8iC6X4oWruAFmtXBscXaI7PDGtWZQk
	 TOBWDQvhRCvOQ==
Date: Fri, 2 May 2025 09:24:49 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net v4] net: airoha: Add missing filed to ppe_mbox_data
 struct
Message-ID: <aBRzQaonAK0IyAsu@lore-desk>
References: <20250429-airoha-en7581-fix-ppe_mbox_data-v4-1-d2a8b901dad0@kernel.org>
 <20250501071518.50c92e8c@kernel.org>
 <aBPdyn580lxUMJKz@lore-desk>
 <20250501174140.6dc31b36@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8z+Krzeqpybywa3l"
Content-Disposition: inline
In-Reply-To: <20250501174140.6dc31b36@kernel.org>


--8z+Krzeqpybywa3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, 1 May 2025 22:47:06 +0200 Lorenzo Bianconi wrote:
> > On May 01, Jakub Kicinski wrote:
> > > On Tue, 29 Apr 2025 16:17:41 +0200 Lorenzo Bianconi wrote: =20
> > > > Moreover, add __packed attribute to ppe_mbox_data struct definition=
 and
> > > > make the fw layout padding explicit in init_info struct. =20
> > >=20
> > > Why? everything looks naturally packed now :( =20
> >=20
> > What I mean here is the padding in the ppe_mbox_data struct used by the=
 fw running
> > on the NPU, not in the version used by the airoha_eth driver, got my po=
int?
> > Sorry, re-reading it, it was not so clear, I agree.
>=20
> You mean adding the "u8 rsv[3];" ? that is fine.
> I don't get why we also need to add the 3 __packed

I agree the __packed attributes are not mandatory at the moment, we just ag=
reed
with Jacob that is fine to add them. Do you prefer to get rid of them?

Regards,
Lorenzo

--8z+Krzeqpybywa3l
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaBRzQQAKCRA6cBh0uS2t
rEj4AQDe3T0L3mBOJoJrm2ODy4pvV1izGwKl5Xcprsl1zcOb5AD/TU2XoaKwtEM+
Kj3qInfF17qy9bHaZFyNa6OmGmWI8AQ=
=7uwp
-----END PGP SIGNATURE-----

--8z+Krzeqpybywa3l--

