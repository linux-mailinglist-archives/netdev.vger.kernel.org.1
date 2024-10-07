Return-Path: <netdev+bounces-132811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A1E993440
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 19:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2D391F22FF9
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 17:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1FC1DC044;
	Mon,  7 Oct 2024 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HutyFkMO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5911DB546;
	Mon,  7 Oct 2024 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320327; cv=none; b=rmPFIlnvfvGFbaoKGB+a8baEIl/IvMQthLHBMKIsFTV1FsXfCquvgfwaxgXxz2itAS150tAFdDJ75oD6cRwBARa2pTCIdKYoFR+NSXIp2LKOCiYtTWPVvfp0vbxITegMxsbWwj3ypTW4b1AjVNBtk8noutUuJQS5TAttcbyZOnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320327; c=relaxed/simple;
	bh=MwCJN8f82bRgwtW/Er53kULMJxngyXKsZIzsJrwKFNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFCqhcvM1Z93ZYT9XPofP9v/2g1TzRd0+lhGGPueFzrg4psPpbucZravi+BTbRW08i3MrSVoTI1eyV2cUEWagE6N3azHyWy+84mGS2ugmJpiwr6QyHb6xXW1XEPeydBZO2XWhV5VhD1QwCc74ospfP0Jjt6iRbjHLlc7aUHyEYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HutyFkMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E6CC4CEC6;
	Mon,  7 Oct 2024 16:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728320327;
	bh=MwCJN8f82bRgwtW/Er53kULMJxngyXKsZIzsJrwKFNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HutyFkMOG0vIUu4OWwqShtP6v5sAs91rK5u4WheKlD71RJLwfa3IwKelC8rdFkw9F
	 oen2NbakPOICFT3/3kcr7iE4XjAdUg1AANyjAD8JFt+oCKJzG3nLIGQjOela8Cmh5x
	 ViGZuhP4Mo41e3YSnpCS3yX8B9dhilieO33DibDzqFpSB7amHG6UnX4OZROzhhiZQ+
	 hfvATIm9wO2GSBNIVm+TwnzB2JPzBBgXgx2MAqMDhIum5pN4N0CyUFINDvz4vPOYo4
	 a7i+sKsZZ0H3aWjAe8WGAszvcGtzVk/1v1S8GaVHIE7kzeetOeXK3RF/zAt1ZFoKyu
	 TI3U2VfyEISkw==
Date: Mon, 7 Oct 2024 17:58:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, michal.simek@amd.com, harini.katakam@amd.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	git@amd.com, Abin Joseph <abin.joseph@amd.com>
Subject: Re: [PATCH net-next v2 1/3] dt-bindings: net: emaclite: Add clock
 support
Message-ID: <20241007-thinness-thaw-04e1f6f12615@spud>
References: <1728313563-722267-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1728313563-722267-2-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="e0x8G5gUTJoubChr"
Content-Disposition: inline
In-Reply-To: <1728313563-722267-2-git-send-email-radhey.shyam.pandey@amd.com>


--e0x8G5gUTJoubChr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2024 at 08:36:01PM +0530, Radhey Shyam Pandey wrote:
> From: Abin Joseph <abin.joseph@amd.com>
>=20
> Add s_axi_aclk AXI4 clock support. Traditionally this IP was used on
> microblaze platforms which had fixed clocks enabled all the time. But
> since its a PL IP, it can also be used on SoC platforms like Zynq
> UltraScale+ MPSoC which combines processing system (PS) and user
> programmable logic (PL) into the same device. On these platforms instead
> of fixed enabled clocks it is mandatory to explicitly enable IP clocks
> for proper functionality.
>=20
> So make clock a required property and also define max supported clock
> constraints.
>=20
> Signed-off-by: Abin Joseph <abin.joseph@amd.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--e0x8G5gUTJoubChr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZwQTQQAKCRB4tDGHoIJi
0gBkAP4/9MGm9XwqeSe1JVLR1ePRaPhpfv2zfML3vcLrZWLKIwD+PC4VAJaGqFnG
NnG/IbPSBY0aYqryr2lIfQacaqxq6gY=
=xGdt
-----END PGP SIGNATURE-----

--e0x8G5gUTJoubChr--

