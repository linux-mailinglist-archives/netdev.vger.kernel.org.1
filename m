Return-Path: <netdev+bounces-181096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA93A83AD6
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 245C79E09E9
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16856205AA9;
	Thu, 10 Apr 2025 07:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wyf/xc9C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E620A205AA5
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 07:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744269401; cv=none; b=D3gDP9US2fyF45AQZjy1aWr4DFYZYzDqahO3HwnVDW3gB7w/rXnmH2ncLiK9XI85kB0jOv/ErseLGV0RcDsplFtESk1A3YSypspcMxnthqdViK8e/kXwd91qy9MShWLCp9s4DoONpX3T9yXb86fWIBEVm9x0Bkp1UdGVNSZvgIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744269401; c=relaxed/simple;
	bh=m6s8SJ1hYayKV7qLClv8Iavh8Zvv3LC6jgfJaiRLauE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYHBbKndPJVy+SKv0DLvg04G5/VpJl5pfkKf64RC+X4ZRhkjkL6vDvKUE69ZQQoGo8iBYJw6w8KmSJYerX2v6m08LxUlrcr2+4mXX4A3qFgxmHfYz9fbSyYERjEXLR7seFypj5pVP+NRU23ZXmBQ8EqFLBecmxkrJAhNBH6MZj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wyf/xc9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B00AC4CEDD;
	Thu, 10 Apr 2025 07:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744269400;
	bh=m6s8SJ1hYayKV7qLClv8Iavh8Zvv3LC6jgfJaiRLauE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wyf/xc9C4YwqJzO2eIeXu8d//gsVeWCr8NmsGVxPywQvV+lNM9iS9kxKFUsU9miHa
	 vuTwmsmecM3KeK8l4UL9nfWrVNCZy0rS/UkFXH8Y9mBSTFS/2JCSpeG2IUqFKLIgNh
	 rahYuAvf6cEWHFm7nX7uqlx7rx/TAwVFGRymWuFqBf2jRSRcKRQtH5DEQ7hPtnfv1Y
	 BkpxQz0KZzeOue22niXVLNNd5Yzvn5axbIMbSTSLYpUulevGXkKmnQjGTFAnrbAH3c
	 +0J4/bTrLc/mKNeZ22UhEN4w69NXuV+pdjwcJbiFr8k92CXz618EmChpTtqgZ+R28Z
	 O2Ug/HbTptx2A==
Date: Thu, 10 Apr 2025 09:16:37 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH net-next v2] net: airoha: Add matchall filter offload
 support
Message-ID: <Z_dwVVEWJp_VFBB4@lore-desk>
References: <20250409-airoha-hw-rx-ratelimit-v2-1-694e4fda5c91@kernel.org>
 <20250409163737.2b6c13e3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vr9WzxqUsueq2Hu9"
Content-Disposition: inline
In-Reply-To: <20250409163737.2b6c13e3@kernel.org>


--vr9WzxqUsueq2Hu9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, 09 Apr 2025 01:15:32 +0200 Lorenzo Bianconi wrote:
> > +	airoha_fe_wr(eth, REG_PPE_DFT_CPORT0(0),
> > +		     FIELD_PREP(DFT_CPORT_MASK(7), FE_PSE_PORT_CDM1) |
> > +		     FIELD_PREP(DFT_CPORT_MASK(6), FE_PSE_PORT_CDM1) |
> > +		     FIELD_PREP(DFT_CPORT_MASK(5), FE_PSE_PORT_CDM1) |
> > +		     FIELD_PREP(DFT_CPORT_MASK(4), FE_PSE_PORT_CDM1) |
> > +		     FIELD_PREP(DFT_CPORT_MASK(4), FE_PSE_PORT_CDM1) |
>=20
> Coccicheck spotted that the previous line is duplicated..
>=20
> > +		     FIELD_PREP(DFT_CPORT_MASK(3), FE_PSE_PORT_CDM1) |
> > +		     FIELD_PREP(DFT_CPORT_MASK(2), FE_PSE_PORT_CDM1) |
> > +		     FIELD_PREP(DFT_CPORT_MASK(1), FE_PSE_PORT_CDM1) |
> > +		     FIELD_PREP(DFT_CPORT_MASK(0), FE_PSE_PORT_CDM1));
> > +	airoha_fe_wr(eth, REG_PPE_DFT_CPORT0(1),
> > +		     FIELD_PREP(DFT_CPORT_MASK(7), FE_PSE_PORT_CDM2) |
> > +		     FIELD_PREP(DFT_CPORT_MASK(6), FE_PSE_PORT_CDM2) |
> > +		     FIELD_PREP(DFT_CPORT_MASK(5), FE_PSE_PORT_CDM2) |
> > +		     FIELD_PREP(DFT_CPORT_MASK(4), FE_PSE_PORT_CDM2) |
> > +		     FIELD_PREP(DFT_CPORT_MASK(4), FE_PSE_PORT_CDM2) |
>=20
> .. and here.
>=20
> > +		     FIELD_PREP(DFT_CPORT_MASK(3), FE_PSE_PORT_CDM2) |
> > +		     FIELD_PREP(DFT_CPORT_MASK(2), FE_PSE_PORT_CDM2) |
> > +		     FIELD_PREP(DFT_CPORT_MASK(1), FE_PSE_PORT_CDM2) |
> > +		     FIELD_PREP(DFT_CPORT_MASK(0), FE_PSE_PORT_CDM2));
> --=20
> pw-bot: cr

ack, I will fix them in v3.

Regards,
Lorenzo

--vr9WzxqUsueq2Hu9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ/dwVQAKCRA6cBh0uS2t
rJJ3AQDcVrSpTTdSIus3bj+lu3WIoqb3wBPZz2xLxzFleoFWVgD/cu8WjRUgCIom
wA3SRQG3EzL/ROFBeSPAzg7pV0UZRgY=
=fX2L
-----END PGP SIGNATURE-----

--vr9WzxqUsueq2Hu9--

