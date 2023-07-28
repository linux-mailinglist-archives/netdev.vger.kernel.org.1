Return-Path: <netdev+bounces-22365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B05E7672FF
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 19:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCDD11C20DDA
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CF5154B2;
	Fri, 28 Jul 2023 17:11:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452D912B8D
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 17:11:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B54DC433C7;
	Fri, 28 Jul 2023 17:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690564308;
	bh=AAaybvDEoIYa8SNwcf6zrgWekWtZs1E1cclOj0P0xGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qRj94Pm6uKJdU81TDj0CI2H2F5aueaFXcQOpL2ab7dqaF0YKwUW/Eu6Me390hnDVd
	 qzm1D1+ausnsuksANnQ8IVrUjHo9n4CEPSNXp3003IWdC/eh7Ju6IMC8WHubGtylgr
	 h4cdhGVTqzCCqXsWDpH3SF5ctIWUMNVCIZybx0F4tqzza8YmiKX1HLYwNmvce8wY0I
	 qPPvekKRYgafITZ3msu86uLoujFMgH/lBXiRvOgSOqowlHR3Kn7mNUv3DWuhmzb1ee
	 /NqGU+5zFqgGblsEYaAKdgVzXpgB+butnhbKyRqZIG2DDTiiDJ1ERCTu7oW9xwQP/y
	 4Q1rZk1WIYSww==
Date: Fri, 28 Jul 2023 18:11:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jassi Brar <jaswinder.singh@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
Message-ID: <8ed87590-4f0e-423a-a326-c4f6bef24596@sirena.org.uk>
References: <20230727-synquacer-net-v1-1-4d7f5c4cc8d9@kernel.org>
 <CAMj1kXH_4OEY58Nb9yGHTDvjfouJHKNVhReo0mMdD_aGWW_WGQ@mail.gmail.com>
 <6766e852-dfb9-4057-b578-33e7d6b9e08e@lunn.ch>
 <46853c47-b698-4d96-ba32-5b2802f2220a@sirena.org.uk>
 <CADQ0-X_pXKvUxLW23vEyH=9aZ6iLA2jOKz8QX6aqwQmxFcPY8Q@mail.gmail.com>
 <7f21c1d3-331d-4bff-8a4c-f6e235a3dd6a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lq4m8BNCVR9lFfHi"
Content-Disposition: inline
In-Reply-To: <7f21c1d3-331d-4bff-8a4c-f6e235a3dd6a@lunn.ch>
X-Cookie: Ontogeny recapitulates phylogeny.


--lq4m8BNCVR9lFfHi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 28, 2023 at 07:07:36PM +0200, Andrew Lunn wrote:
> On Fri, Jul 28, 2023 at 09:35:00PM +0900, Masahisa Kojima wrote:

> > "rgmii-id" is correct, configured by board level.
> > The latest EDK2 firmware was already modified to use the correct value
> > for DT(Thank you, Ard).
> > http://snapshots.linaro.org/components/kernel/leg-96boards-developerbox-edk2/100/

Thanks, that does seem to be working.

> If the firmware has been fixed, i would actually do something like:

> 	err = of_get_phy_mode(pdev->dev.of_node, &priv->phy_interface);
> 	if (err)
> 		return err;

> 	if (of_machine_is_compatible("socionext,developer-box") &&
> 	    priv->phy_interface != PHY_INTERFACE_MODE_RGMII_ID) {
> 	    	pr_warn(FW_WARN, "Working around broken firmware. Please upgrade your firmware");
> 		priv->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
> 	}

It is not clear to me that the release channels for this firmware are
sufficiently clear to users for this to be constructive.

--lq4m8BNCVR9lFfHi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTD9soACgkQJNaLcl1U
h9D4Sgf/UHOMDMFTFA+SW8Kb+pTyDRKEvHUDBcGyL2NKYKqFb1wFaFceH334F9QQ
dO1YmxicEUWeQva2NfhfNVdSHu6mJzG5Hkvrlr65LAzzIG+AFtPgLZwZfWQpXfNs
kPuLBMQQCSnV8XQhkFrgc4buO2hEjwEVukFzAi+sLUbY2UdTGgVjCjM2JrAYcEtQ
Njv4bXo4I3wgEq6cOt8VUTqaMQiVxsdQVcz9s7w/kg6yLooJmq+4aZRDlGcfWXkj
ly8kK7uBq4BAM8yEnhi/Gcb8rAQ0ac1ZHLzymAtSe/YdcMwrsFoDw6OD+OohP+6v
QGrwZEUDeoZOzerlcdhg98wQxl9wUg==
=LWJ8
-----END PGP SIGNATURE-----

--lq4m8BNCVR9lFfHi--

