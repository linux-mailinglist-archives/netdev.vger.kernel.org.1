Return-Path: <netdev+bounces-219192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D3CB4064D
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 16:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084BC1886B48
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAAA2DFF28;
	Tue,  2 Sep 2025 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGGOM86H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF99E226CF1;
	Tue,  2 Sep 2025 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756822298; cv=none; b=GHBq8UoOwJaqcZTT5aOxmSEwPIo7vjnKvrPNhOGj4JmlXo79rwbOyuORRYW9lvIoEA98jhU0rVsK1tVs8mH6OJAGRnLyEj0WAD7G4idDNPGVXLsscSYsZ258ty1aFsXNt2kqbG34TcVwFMu+AfGI51zBuGgAHQbf7eKFDwr2mtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756822298; c=relaxed/simple;
	bh=T3wyZ6jtecqFDOGjVL1fyOX/b7Gmqgj53Psy+nVhaxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TnQ3wrmQCNCZXB0veX2/D6vEWtj3Z83aeSOxoktlA81DmNbPaIySidsD7R5NoOCPcLM6tW9D/xb2xnTI6tYOJtabiBKZbXCpoAPqpep2g+McCD2ZPZYAoetI1h60MI4XdYugNhQipjJPIIQC5/y/iWMIysE2SftZLHNw9oZlV1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGGOM86H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1832C4CEED;
	Tue,  2 Sep 2025 14:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756822298;
	bh=T3wyZ6jtecqFDOGjVL1fyOX/b7Gmqgj53Psy+nVhaxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PGGOM86HcFpJ3YVUjeAOSaRCxRnk6EAQ2f9GFx0xl2YwcXWNHKEAJVJ+lRasFvNEo
	 z6HTyRa9bLS8/m8dWbDjncohPJhC6GhJL6VWIA762BxoY3L7/CbCnl6RZ9Qhlqu/Yx
	 64PeucOP6FW6oiDD6kzJMuUaGwETnec1ChpGjbODt0C+85o8nea6e8T7EsbfVgysSY
	 1Pv5bbO+g9W/E+zOwqsKrf3Lm676SKYj3soWjgdy4EM0a+8vz4wyZynCuTda//V8Rj
	 qOwRGcwlm9N2cYeMRlvDwk6M8YPJ1zoCmcrFKzMSjLmhLlrdACcj6bz42+tDl08JGl
	 SziNxYvIE6v7w==
Date: Tue, 2 Sep 2025 16:11:34 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Conley Lee <conleylee@foxmail.com>
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, wens@csie.org, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] arm: dts: add nand device in
 sun7i-a20-haoyu-marsboard.dts
Message-ID: <stdtaaoxpnwbinjk72nutik4dsh77iywfqpoogtgxhebkuxcl3@yhnu5u2wvtsb>
References: <tencent_57056C4B1E98EF5C0517A5685B2E4D060508@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="zip2peffqy3jbkf7"
Content-Disposition: inline
In-Reply-To: <tencent_57056C4B1E98EF5C0517A5685B2E4D060508@qq.com>


--zip2peffqy3jbkf7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] arm: dts: add nand device in
 sun7i-a20-haoyu-marsboard.dts
MIME-Version: 1.0

On Mon, Sep 01, 2025 at 05:05:21PM +0800, Conley Lee wrote:
> The Haoyu MarsBoard-A20 comes with an 8G Hynix NAND flash,
> and this commit adds this NAND device in the device tree.
>=20
> Signed-off-by: Conley Lee <conleylee@foxmail.com>

MLC NANDs are very unreliable, we must not enable them by default in the
current state of UBI / UBIFS.

Maxime

--zip2peffqy3jbkf7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaLb7BwAKCRAnX84Zoj2+
dguyAX9u3yR4AN55O69wO/UyeI+BKx82ca33p0QxRMC9v3A6uvffoiSuhq3FxYFT
tauF1e0Bf2nxCJpegHoktTqCPgJG1BXoVvCkL7sJHt0f6IDGzK+M5LJLOSLE7qap
ur39lheVPw==
=Z7CA
-----END PGP SIGNATURE-----

--zip2peffqy3jbkf7--

