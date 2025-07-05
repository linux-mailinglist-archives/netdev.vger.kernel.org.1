Return-Path: <netdev+bounces-204291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C716AF9ED2
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 09:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3C41BC40D8
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 07:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0554326B746;
	Sat,  5 Jul 2025 07:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spfl7yhj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C6E20B1F5
	for <netdev@vger.kernel.org>; Sat,  5 Jul 2025 07:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751701196; cv=none; b=S5rtOqgSa4zRSny7knuVFK6fAxzAqUhuaN6kPLPb8aQJvKuHjMv3N4FcpINCf70KB0SbEzfNon4qlngMn4sATRQasm4D3RmHv8gjaDQNtjJ4OXyZrfhIUARKYYfptP3HPvVLP5vK4G147xE5/RNfisoh6WSlluwo5qzK6lupSmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751701196; c=relaxed/simple;
	bh=4+smnfJ0bY+IFawuGcGZ/H4RoAnFNYqIwx8+xfv8nVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6UN+4dCXF/i0jqAQX3KFr4hCrBUqpC3lxQai+amol3hNwL0z2TTCr8NB2EyjqIV0uJhG9NEgeIYj9X5ujWr38R7SugGq98Whjw7rgFDji2sGfLg01iMjaF1quDLpf+7I+Uw7BYXf9CESIygsK3TvUctI5tDDy+M+IV7p1idgcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spfl7yhj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA7CC4CEE7;
	Sat,  5 Jul 2025 07:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751701196;
	bh=4+smnfJ0bY+IFawuGcGZ/H4RoAnFNYqIwx8+xfv8nVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=spfl7yhjw229noSAYcjPw2hNzzUOhogF/lLOZxen7eRbmvKUCPRZNDN0tHFNQztgV
	 vYIS3RH+1xiGAiDy1XQzXBF3ZrRF26ZQyDWb7LRFP30cQ7uV9TqZr5VoqzS7J5U+DS
	 srgEkfZhP8/vAtGvtXcbWA/gyGzBC54xzdVfrp+O9tcPWzVeWAV7c30qDWz5f8KCra
	 +bGme6OaEeT+KlAyM80rE+CChREQbYqD6g1dOocfwWJ8CRt1u9vIV+pnKK1nEKpbt+
	 rGJ9yHrY/BaOMyiZOM0Sy2LWgTaoqFAN0LZzO7lZaQXJjOJgmSBv/nVicriWOxCdFL
	 pksO9saAXJeMA==
Date: Sat, 5 Jul 2025 09:39:53 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 4/6] net: airoha: npu: Read NPU interrupt lines
 from the DTS
Message-ID: <aGjWySVX1VosLjyd@lore-desk>
References: <20250702-airoha-en7581-wlan-offlaod-v1-0-803009700b38@kernel.org>
 <20250702-airoha-en7581-wlan-offlaod-v1-4-803009700b38@kernel.org>
 <20250704145604.GD41770@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lvihB4WnHkB75gUf"
Content-Disposition: inline
In-Reply-To: <20250704145604.GD41770@horms.kernel.org>


--lvihB4WnHkB75gUf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Jul 02, 2025 at 12:23:33AM +0200, Lorenzo Bianconi wrote:
> > Read all NPU supported IRQ lines from NPU device-tree node.
> > This is a preliminary patch to enable wlan flowtable offload for EN7581
> > SoC.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> Hi Lorenzo,
>=20
> I think a bit more information is needed on how you plan to use this.
> Ideally in the form of a patch that does so.

Hi Simon,

These irqs are described in [0] (wlan irq line*). They are the irq lines fi=
red
by the NPU when the wlan traffic is not hw accelerated. These interrupts wi=
ll
be consumed by the MT76 driver (I will post the MT76 patches in the near fu=
ture).
I will improve the commit message in v2.

Regards,
Lorenzo

[0] https://github.com/torvalds/linux/blob/master/Documentation/devicetree/=
bindings/net/airoha%2Cen7581-npu.yaml

--lvihB4WnHkB75gUf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaGjWyQAKCRA6cBh0uS2t
rFk8AP96S3uwwMjqG+gxNeu0vYtPO8k0wpSE8h8jcVdsA9LSxwD/TgAgGrhtQ0MH
X/X+uJ3xtH8+ZjGezUAS+b0IkEiR+Ag=
=z6Q3
-----END PGP SIGNATURE-----

--lvihB4WnHkB75gUf--

