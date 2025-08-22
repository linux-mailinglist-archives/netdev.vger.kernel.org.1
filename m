Return-Path: <netdev+bounces-215933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F5CB30FAA
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 08:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564445A0358
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 06:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40822E6138;
	Fri, 22 Aug 2025 06:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRruwPa2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEED26F46E
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 06:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755845909; cv=none; b=CANTaxMyeImKtBTo2PPwRQw2EZd1qf6X2qmeVtAEsZicHBqxzU5WOskNMMfgKxdRCwvph/3ClJETD/cNuaKcV0pD+xPRwQZfxPwXgBNkygixZiB4gA0q9g+OyO7JopfBDOPSn+czGQgxJlpATLkjfQiCcJ11Bc8BDggftT+HYFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755845909; c=relaxed/simple;
	bh=T2OOvaetRekViwpWZDX1ZK/yH7uyIW3shMywUpOOlxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJ4QBkf1bveJzvGSyayDNBbguFxHJ7J9r39SivTDMbhNBBT/Xkf8J/Y2wI8arENJs4MEkApeez0IrtnrlljZr0Ev50xPwoOOo2N5fMs0h02xig4wr5UYVggrrui9h+crmkubewuHxcMxPE9VZMLaU8vHpf2aeVK4WLT3RaHo5jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRruwPa2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE274C4CEF1;
	Fri, 22 Aug 2025 06:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755845909;
	bh=T2OOvaetRekViwpWZDX1ZK/yH7uyIW3shMywUpOOlxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nRruwPa2J+pVfV2fgXy+iNSSeEj3+I56tBkOlfhAw4BACVn6qcdcQEzG5//OtJ4Tg
	 exq+PYjVN2n06OBZHvd0Clj/ECkEmb8E2EdVMbh78/fI8Lr4nm/OYjDP1IyrfQfukK
	 RRO8Yek0juZs/UKK6wzNy3tdzhePNbh5if4+g1BqKvF6ajNBe3KJ5517zyzXTlFgEj
	 dCR2ti76UGr6CRn15LzOuK1dcjFGDO7Khs9AwdeoLRWoc42X1CTH/CznCMBA+UkgkZ
	 pc3DdnOLM/rAPDD78UnsuWnaq0VwTQIA/Bac84RCKDjkH1RBr4xGXq0IGt1Mn4yoU9
	 1YYYrxd4Rt63w==
Date: Fri, 22 Aug 2025 08:58:25 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: airoha: Add airoha_ppe_dev struct
 definition
Message-ID: <aKgVEYMftYgdynxw@lore-rh-laptop>
References: <20250819-airoha-en7581-wlan-rx-offload-v1-0-71a097e0e2a1@kernel.org>
 <20250819-airoha-en7581-wlan-rx-offload-v1-2-71a097e0e2a1@kernel.org>
 <20250821183453.4136c5d3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bI5eS4cqrdc40bK1"
Content-Disposition: inline
In-Reply-To: <20250821183453.4136c5d3@kernel.org>


--bI5eS4cqrdc40bK1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, 19 Aug 2025 14:21:07 +0200 Lorenzo Bianconi wrote:
> > +	pdev =3D of_find_device_by_node(np);
> > +
>=20
> did you mean to put the of_node_put() here?
>=20
> > +	if (!pdev) {
> > +		dev_err(dev, "cannot find device node %s\n", np->name);
> > +		of_node_put(np);
> > +		return ERR_PTR(-ENODEV);
> > +	}
> > +	of_node_put(np);

I moved the of_node_put() here (and in the if branch) in order to fix a sim=
ilar
issue fixed by Alok for airoha_npu.

commit 3cd582e7d0787506990ef0180405eb6224fa90a6
Author: Alok Tiwari <alok.a.tiwari@oracle.com>
Date:   Tue Jul 15 07:30:58 2025 -0700

    net: airoha: fix potential use-after-free in airoha_npu_get()

Regards,
Lorenzo

> > +
> > +	if (!try_module_get(THIS_MODULE)) {
> > +		dev_err(dev, "failed to get the device driver module\n");
> > +		goto error_pdev_put;
> > +	}

--bI5eS4cqrdc40bK1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaKgVDgAKCRA6cBh0uS2t
rGuBAP9Voa1N8BTwWGerU5BZPH3ybdyhYo91i0eFxtZOcrg97wD+MxvDDaf3M3+D
IBzTULPBlvRpUoww5fFHGXXfxPTS/wU=
=caXj
-----END PGP SIGNATURE-----

--bI5eS4cqrdc40bK1--

