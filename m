Return-Path: <netdev+bounces-22252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A38B766B7B
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 13:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6C281C2186A
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 11:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AB3125D0;
	Fri, 28 Jul 2023 11:14:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489A5D304
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 11:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF74FC433C7;
	Fri, 28 Jul 2023 11:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690542871;
	bh=DyopT+4UgnWothBICg+l70RvQhLb7xR2eXZ5gYcIXuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=trC36qPC+VVT4J8dMMkBUfRd3XToGXizQz/qb9QJxJ3cPqPmHa8FNSsyIfcslTJrJ
	 cnx413cijMJbF8azIrd71l0KpNzulTPP1Yskvm3kLiVEauHBbq7N5WwLOMkzwPb6wv
	 6Nd+K3GyZw4jUFtYuQsixklgz3YuexWuiZXJpGciuBNUbZri3egK8hKuzgfH7DrPQa
	 It28yztF3KkuJmIrWiKIkkmH/vQQxOhynx7IXaaqv6hCRx0cURbp8gum0+HBPPj8mX
	 E+nI0+TG8S4plwzoMoyaKRYOJZeiGqmBkIOuv+FkXv+Rsp/QTI88ZepyUh5n6envhn
	 EvvfmBBXv/4KQ==
Date: Fri, 28 Jul 2023 12:14:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>,
	Jassi Brar <jaswinder.singh@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
Message-ID: <e61f2781-45bc-4928-8a84-e80e3543cf47@sirena.org.uk>
References: <20230727-synquacer-net-v1-1-4d7f5c4cc8d9@kernel.org>
 <CAMj1kXH_4OEY58Nb9yGHTDvjfouJHKNVhReo0mMdD_aGWW_WGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N2aIURLae8eqFiup"
Content-Disposition: inline
In-Reply-To: <CAMj1kXH_4OEY58Nb9yGHTDvjfouJHKNVhReo0mMdD_aGWW_WGQ@mail.gmail.com>
X-Cookie: Ontogeny recapitulates phylogeny.


--N2aIURLae8eqFiup
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 28, 2023 at 07:45:44AM +0200, Ard Biesheuvel wrote:
> On Thu, 27 Jul 2023 at 23:52, Mark Brown <broonie@kernel.org> wrote:

> > As documented in acd7aaf51b20 ("netsec: ignore 'phy-mode' device
> > property on ACPI systems") the SocioNext SynQuacer platform ships with
> > firmware defining the PHY mode as RGMII even though the physical
> > configuration of the PHY is for TX and RX commits.  Since
> > bbc4d71d63549bc ("net: phy: realtek: fix rtl8211e rx/tx delay config")
> > this has caused misconfiguration of the PHY, rendering the network
> > unusable.

> Wouldn't this break SynQuacers booting with firmware that lacks a
> network driver? (I.e., u-boot?)

> I am not sure why, but quite some effort has gone into porting u-boot
> to this SoC as well.

Yes, it'd be break them.  I wasn't aware that any other firmwares
existed.

--N2aIURLae8eqFiup
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTDoxEACgkQJNaLcl1U
h9DRGQf/Yz8ze1JwwcnvNBbJMrRkJxjbXPDtWcHPUHch9LjBwLY2LO7zEAz9Mp9K
6idj6J5RcdvRXAbgAA/Zq4H1OHcvwGGlppKuyVvi9Q79yQZtZSVHXr3kiwyYiyxa
VNqCgVhCkYR5FQbvrH4/9/cv7F8w3fweznRDSF0rBNd8GQHG5N7id/AHrOqhg7K4
mxzdMsAVDfO5wU+JNrziF+v979F76t1PkvrNkCmbvqcAYcWyXWMFekjIYil82Y18
zrNqaWWMRJmycVR9Rr1UQvWNhqWyKVHz5IUBaP3mIpV53qplr17FiJkfwrw5gM6q
8IRIOf5vI9mcQeCoByDoCbVQKu1z4g==
=7npc
-----END PGP SIGNATURE-----

--N2aIURLae8eqFiup--

