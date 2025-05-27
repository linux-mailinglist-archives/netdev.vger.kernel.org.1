Return-Path: <netdev+bounces-193670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8BFAC508D
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 16:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F59F17578E
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 14:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BB4278170;
	Tue, 27 May 2025 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dkn/sBqo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F771DF254;
	Tue, 27 May 2025 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748355203; cv=none; b=f1Yji/Hmpq2F8D8VlX/Nzy4hk0Iw1T0Nt+51wlvBYrqCCuc8nWzVMNLCEu5dSNw1g6jPo57JJK81/gbZK8Z9iTDZm3xxGiELmhdLbLym3nX0lkhtFT6n6yrNwwPswnDEj7zROo5Ww25IkdvGd78pOftyY8OyxNAhpsN9Qno6CIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748355203; c=relaxed/simple;
	bh=s1/Fl3iRmGCQlCudqjCG+PZ70PcwovATM6h2BAyhIz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKCPVFvKKAfL+2q7UjOl4sliNWnmopPrFxURJw/4VhEnDlehGHgs5QP/rMyVZIcVWA9fsMox/E3EzEReLDNPvKiF2VhF+e4hMbc50hv7ypZ5fdLdk0W/iEDJT7uDB5HtksZicUlwrB1fIA14sj9NdW8IAnKu4b9omNx/4yinJ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dkn/sBqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4886C4CEED;
	Tue, 27 May 2025 14:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748355202;
	bh=s1/Fl3iRmGCQlCudqjCG+PZ70PcwovATM6h2BAyhIz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dkn/sBqocoIftLHlFTZ2LSlb4tK30ZM9SKUm8A/A+h5H7XH2GqTiTqzc/tYvAejl0
	 LwGIrtc//qPJNWvU51AoNto0CnTUxzaHfxd6wY7i/6WskrxAZv9vI5rXySLi47l9ha
	 FTFaDaYQgxEexSY6vd5F1CAiXEuTXtpbisYVWW2EU9ddhinJhoOJCrXYqKL1PS/ETU
	 FdErHUk5oVgvfzMcfbxPOIV0UKzqiEQJk+Of/8t05Fb8LoS5gWg6m9uGNfT6bhnL0I
	 oFYM+7YuUq8g7x7Kbsqc8D0O2fy5PiLCrmYrhVNKMZV/daF9cXkTOZFMpu9/icjRNv
	 UG4yWwL98RTMA==
Date: Tue, 27 May 2025 15:13:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [net 1/4] dt-bindings: net: ftgmac100: Add resets property
Message-ID: <20250527-sandy-uninvited-084d071c4418@spud>
References: <20250520092848.531070-1-jacky_chou@aspeedtech.com>
 <20250520092848.531070-2-jacky_chou@aspeedtech.com>
 <20250520-creature-strenuous-e8b1f36ab82d@spud>
 <SEYPR06MB51346A27CD1C50C2922FE30C9D64A@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oF1MzhfhQDns9knz"
Content-Disposition: inline
In-Reply-To: <SEYPR06MB51346A27CD1C50C2922FE30C9D64A@SEYPR06MB5134.apcprd06.prod.outlook.com>


--oF1MzhfhQDns9knz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 02:20:48AM +0000, Jacky Chou wrote:
> Hi Conor Dooley,
>=20
> Thank you for your reply
>=20
> > > +  resets:
> > > +    maxItems: 1
> > > +    description:
> > > +      Optional reset control for the MAC controller (e.g. Aspeed
> > > + SoCs)
> >=20
> > If only aspeed socs support this, then please restrict to just your pro=
ducts.
> >=20
>=20
> The reset function is optional in driver.
> If there is reset function in the other SoC, it can also uses the reset p=
roperty in their SoC.

"if", sure. But you don't know about any other SoCs, so please restrict
it to the systems that you do know have a reset.

--oF1MzhfhQDns9knz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaDXIfAAKCRB4tDGHoIJi
0gH9AQCRLkHk3neNHshJkYAPhnXtXcmS1T4OLHZhP/AyJZlligEAroQq3M9Xp8gF
CRE717jgbijLXCXCNR11jW1nOPCN7g4=
=2CfM
-----END PGP SIGNATURE-----

--oF1MzhfhQDns9knz--

