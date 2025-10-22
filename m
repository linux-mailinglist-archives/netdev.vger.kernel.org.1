Return-Path: <netdev+bounces-231812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB119BFDBB2
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CF3E4FF382
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 17:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6AE2E3AE6;
	Wed, 22 Oct 2025 17:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3eIwWDQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9E72E1C63;
	Wed, 22 Oct 2025 17:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155787; cv=none; b=isI20DE+rTblz3CrurTsaKiTBM+xsbzREtqJCcmr7wAk8ASkF1wHot9unDZHT3LhKlo7Ks9Qdd2WXg3z5X6Ysma/9g1msdxWgB0LDb+DeJRpFR1p+IEkgOebGJlHDhDjKgpt7ROrKFiVHXF5tS0XzJipIXZd01zVghfny0Hq1TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155787; c=relaxed/simple;
	bh=oNEg5P+Ttc8VSR9Q4md86Pd8eZOASwjjfO0iGgVd1+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFx7aulN2aBysfGP+Pvc83HHVjLwmY1g8kCvgQT8UNaG5DYBN8SAMBlooW2Y5kZDhqGKPFzjUK9IuMNX3bDEn8vUzM5a//TqzCTpaO2PbS9dB3MU6PGAUHaTwJKh1yDjdAYub+qYGZv2WPCDiHtcRsuwA388dR2Qe/tFXU91MfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3eIwWDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EBEC4CEE7;
	Wed, 22 Oct 2025 17:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761155787;
	bh=oNEg5P+Ttc8VSR9Q4md86Pd8eZOASwjjfO0iGgVd1+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h3eIwWDQ0Z/3Tp00SmF6KNlW5DQO+WCU/0e4Py0iUdRh3uPFKb1CbCBeGYjdNPhxa
	 Q5/b4YkMYd3z9R3+RfmFIVWlPp+sdU6RKBYIGlIwjYQ25JK/iieveVI7B9UhMK3e/o
	 QTffdutMsttq4tOKfO7oDszhtAhTuJxuo+hcWqgLTeLq/c6FJgcIHsmzqv3KtUvXy5
	 74Q6KdeV48RSg0QLZu6d2Wj7jC1sjq1VHOnruwNHOKQX48130vGdgg69fCC247MLx2
	 7bADJU56kALSUEt0fuOh1OzzGOEczjpXm5V9oqpD6k3XK/Qp4W75wB3snxyfGNSvoP
	 hBQJHYU0kzuYA==
Date: Wed, 22 Oct 2025 18:56:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: net: snps,dwmac: Sync list of Rockchip
 compatibles
Message-ID: <20251022-undiluted-vengeful-5d25f15a6619@spud>
References: <20251021224357.195015-1-heiko@sntech.de>
 <20251021224357.195015-3-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AaSWsIAoSnlBIPJU"
Content-Disposition: inline
In-Reply-To: <20251021224357.195015-3-heiko@sntech.de>


--AaSWsIAoSnlBIPJU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--AaSWsIAoSnlBIPJU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPkaxgAKCRB4tDGHoIJi
0mfgAP9tWrOwSjhvFyojtCqJcCnn/wgCp39OALg2qGN24SiWxQD/XHloj44IFaQA
Me576GhEl5516HV+ViBK6c+zTMkVngE=
=vUEM
-----END PGP SIGNATURE-----

--AaSWsIAoSnlBIPJU--

