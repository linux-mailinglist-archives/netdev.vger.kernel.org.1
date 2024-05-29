Return-Path: <netdev+bounces-99079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C43188D3A47
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 17:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75800281C96
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 15:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AFF15B97D;
	Wed, 29 May 2024 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFxG5yzW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332901B810
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716995200; cv=none; b=XwyW2IQGwOL/J5CWczMCW+UViqvQvqRU7j8S/oBRMg82HDNTWdAkeKwF5UlkHL6F/tsy96ra1RVNNxMF3042ZZ2bRsRjIb7rBfXnGaTx2PVHRgJ8ujjOZlZzTKxOSUpl0ACYKr5DyaCQcJfayS5MK5Ym87dT8r1qullFJ/LLp/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716995200; c=relaxed/simple;
	bh=yxA56lcClYQgcxSH9kn0eLVYQZH1vrJtSUbCUV2semo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mdqdse07kKuQduY6cyInfYayjkaQr1eBz4V+PKqJV74W/ZUgg7Yrlsezp43iYCS6TtYvITR2vXLsZsQeIUtJ3ttkjXMo5mArte1+XsqnXfQoDFJtxO78yDGfYY6KVnNyC1rUnjzfGdY8JsH48uoJSNuFmsyIa0WLS52TDa6r5rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFxG5yzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40132C113CC;
	Wed, 29 May 2024 15:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716995199;
	bh=yxA56lcClYQgcxSH9kn0eLVYQZH1vrJtSUbCUV2semo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hFxG5yzWTMSQT6N3jnRJ0bnhcPnsNZQrECVd7k7ZcJ0gU9IthcYCQ24pPqO85Y66K
	 An4W5By91u6ZfG8k4kir6NbaXA2e4deuoTzIFGibG1dDoNNuTxDukt37L1ATnMJvVV
	 qMPaHWpvJuTMneZP5DDgOuF26pVUdRdfO5IKn47zfZ7n8W25H+9u89ZZS972lZ2v/6
	 jcKZEbxn4hRIL4kNuHoho/1NaCRwPOjnvhIp/z8qsJoW9WX1GCXHWNvQKLPlVJF2/2
	 Gepy5hc0yc0tcXGj5cIyOzuNW3SdNzoxpCNpO/FaFlxn0J5PucRmHZ0fZ5BOfFfNHY
	 2FQ124DiJNopw==
Date: Wed, 29 May 2024 17:06:36 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, arinc.unal@arinc9.com, daniel@makrotopia.org,
	dqfext@gmail.com, sean.wang@mediatek.com, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	linux-mediatek@lists.infradead.org, lorenzo.bianconi83@gmail.com,
	nbd@nbd.name
Subject: Re: [PATCH net-next] net: dsa: mt7530: Add debugfs support
Message-ID: <ZldEfH1Yy0cH2-OS@lore-desk>
References: <0999545cf558ded50087e174096bb631e59b5583.1716979901.git.lorenzo@kernel.org>
 <20240529133130.namqhprxpvhzgkzr@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/RtT3VCISYzBUF7O"
Content-Disposition: inline
In-Reply-To: <20240529133130.namqhprxpvhzgkzr@skbuf>


--/RtT3VCISYzBUF7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo,
>=20
> On Wed, May 29, 2024 at 12:54:37PM +0200, Lorenzo Bianconi wrote:
> > Introduce debugfs support for mt7530 dsa switch.
> > Add the capability to read or write device registers through debugfs:
> >=20
> > $echo 0x7ffc > regidx
> > $cat regval
> > 0x75300000
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
>=20
> Apart from the obvious NACK on permitting user space to alter random
> registers outside of the driver's control.
>=20
> Have you looked at /sys/kernel/debug/regmap/? Or at ethtool --register-du=
mp?

ack, regmap sysfs is fine to dump registers value.
It was just very handy for me to have the capability to change registers
during development (moreover we already have something similar in mt76).
Anyway it is probably something more related to development so I do not
have a strong opinion on it and we discard the patch.

Regards,
Lorenzo

--/RtT3VCISYzBUF7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZldEfAAKCRA6cBh0uS2t
rLDnAP9swkHUjJEKW5Ab+4GBdK/KDD+HxQLITJ12/+o/AUuj+gD/bpboxwJozpMB
vKM1pXtTs/fZ3qr4bBQx/eqgvfRbhQk=
=+fhy
-----END PGP SIGNATURE-----

--/RtT3VCISYzBUF7O--

