Return-Path: <netdev+bounces-22463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7657678F7
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 01:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A58280FAF
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 23:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE15200BC;
	Fri, 28 Jul 2023 23:28:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216B5525C
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 23:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE25C433C7;
	Fri, 28 Jul 2023 23:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690586892;
	bh=N20Vk1GZBKbVhd/c7KSr0gihKQDzhVZnKCVob6v+czU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XUZsSBiFbCZZaJwrhaBuhM1808/CLZm+760rfWaKfE51P6dJK5wuE/XiPCfKpkrVe
	 Qb1q5/8xLSNDLBHalbX5FjqtoA5zg4idQMUek4DT6vZPNlKOIAsitxt7Qvk65UcSYE
	 s6RWO/vecfnWTPVhvFyBNNXjkAyqQSgmqIxZuZMqv98VEQv+/jLF4IRuy1OCShcFej
	 tMLxOKsrsJcRVlZ6B5wsaoovJcuWQ2t8UbhTYfdaeWS+VgyHnMfHrzvDskt4o+bNoB
	 vCJLZ2cOJnCeA+s+SJ1rLxkYwzugIBe7HOJ2tEb8daIEVOcIuR1YNVwyC/wbuIX0i1
	 rhsNYQD7NkljQ==
Date: Sat, 29 Jul 2023 00:28:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
Message-ID: <ZMRPCA9FqzIXFQe6@finisterre.sirena.org.uk>
References: <20230728-synquacer-net-v2-1-aea4d4f32b26@kernel.org>
 <0a208142-1c71-f997-4d77-961d3bc91343@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UtDpsnXQ6n8IQycD"
Content-Disposition: inline
In-Reply-To: <0a208142-1c71-f997-4d77-961d3bc91343@gmail.com>
X-Cookie: Give him an evasive answer.


--UtDpsnXQ6n8IQycD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 28, 2023 at 03:54:08PM -0700, Florian Fainelli wrote:
> On 7/28/23 15:51, Mark Brown wrote:
> > As documented in acd7aaf51b20 ("netsec: ignore 'phy-mode' device
> > property on ACPI systems") the SocioNext SynQuacer platform ships with
> > firmware defining the PHY mode as RGMII even though the physical
> > configuration of the PHY is for TX and RX commits.

> Did you mean to write "delays" instead of "commits" here?

Yes.

--UtDpsnXQ6n8IQycD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTETwQACgkQJNaLcl1U
h9C/Ogf+MbQ7lE8cIU7YhtnQ52ZRDq9f99ZpfPN6FMQYNt/Hz7s0DTbyZk/U0ReF
mxo+EpFHJB3ck2wycqM0z1S0LoH6VxRdOc/OOel+EJ9sHKM4nOkrVP7kF9fObiNu
3b8sfA5crWTTecPuLMWf/4cD/WatD3gi3g6vKvmJ+OWe/iP8Um6AXxuQhX9M2MB4
3wgsYxE6ZoVUSaDArbnIbDYJuOXaean3Th7kORwEy2ehu3aSoJqEBfAPz1sh5Ax2
KH/PURBbodgXkumPpYoz82uNgV2n6oQ3HVAV7gr3z7rNDKEvqZ+mQY/MEvoyK3aS
FhZ/6abugxn46XrQYFTT+32Rp7l1hQ==
=ZiOC
-----END PGP SIGNATURE-----

--UtDpsnXQ6n8IQycD--

