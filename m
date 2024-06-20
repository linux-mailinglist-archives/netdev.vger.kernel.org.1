Return-Path: <netdev+bounces-105326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829E891073A
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 16:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102FE2849C6
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE7D1AF693;
	Thu, 20 Jun 2024 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ies5kZvC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D225B1AD9C6;
	Thu, 20 Jun 2024 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718891963; cv=none; b=E4sXRh4Ij1OVqOYjpUiuTc0nDVSsdejcgyUj2q3bD68AWgc+OQEgAyKk3KBK7z3jhZ/n3rjCtSufxOXmRHaCm5w5fl/yu2xsrZfnmHacJ7gXJXgwqGzztZA1cpUtNwRBKQCAuwFa09ONaph8IlWZBjKnKS+MWrLenCRnysrprOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718891963; c=relaxed/simple;
	bh=Z8ykrk5YoWwEuFbj1k4TUc4xuI2OXNR4A6IYRWxVNWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGAmDZ707lwMSnpLMSH9XbwwLnlbDI4aBRzI7gv1xgQeXKcv5DlbbCdBUZ4JWBcu7+ZEaQ+omhRqkew4xZoAEtS8zxwKwvSFpQsp0uhz8TflbBqWb9Ip/B3CstxbJ0txmQiTr0SmdNNHO91YiuD+XPkD2L+3XNlCmh3jsRmUB7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ies5kZvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CEFDC32786;
	Thu, 20 Jun 2024 13:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718891963;
	bh=Z8ykrk5YoWwEuFbj1k4TUc4xuI2OXNR4A6IYRWxVNWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ies5kZvCDEdEO5yAghIHv8V1zLcS6yhwHCeMNvPmfOwkWVclOLSfb56gZs/8EK8B/
	 e37Z7VOww7TDvkHRgdB1X0Ors/+sPow6JwHjreCPMEajdgvfzE+N/hcFKqI3Dbuw6J
	 nXP7VpQT9yX8ZVgtu+Y3klXN5byrkBnb8HrUg+PtyKMzAtjeQnFCdDgiG+FWuFCg1U
	 4jDa2R2mof19EKJZ3PnDlMc0qF6MePTNPn3b2IohnZtPGxbz5LH6IIm3yok4blm5U+
	 xxO5MrMJn9bYcu0ctXgpIOJ4LDViJYuSObQPhRSwvMPv9F3MHJgtsoUlazCcGxVhO1
	 CzUk5v3Uoa/7w==
Date: Thu, 20 Jun 2024 14:59:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/4] dt-bindings: ethernet-phy: add optional brr-mode
 flag
Message-ID: <20240620-rocky-impure-7fd0caf9f01d@spud>
References: <20240619150359.311459-1-kamilh@axis.com>
 <20240619150359.311459-4-kamilh@axis.com>
 <20240619-plow-audacity-8ee9d98a005e@spud>
 <20240619163803.6ba73ec5@kernel.org>
 <20240620-eskimo-banana-7b90cddfd9c3@wendy>
 <9f8628dd-e11c-4c91-ad46-c1e01f17be1e@lunn.ch>
 <20240620063532.653227a1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wRUHkzBBSbDnLgU6"
Content-Disposition: inline
In-Reply-To: <20240620063532.653227a1@kernel.org>


--wRUHkzBBSbDnLgU6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 06:35:32AM -0700, Jakub Kicinski wrote:
> On Thu, 20 Jun 2024 14:59:53 +0200 Andrew Lunn wrote:
> > > BTW Jakub, am I able to interact with the pw-bot, or is that limited =
to
> > > maintainers/senior netdev reviewers? Been curious about that for a
> > > while.. =20
> >=20
> > https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#u=
pdating-patch-status

Hmm, thanks for the link Andrew. In theory I should be able to use it
then, I wonder if it is smart enough to detect that conor@kernel.org is
the same person as conor+dt@kernel.org.
I'll have to try it at some point and find out :)

>=20
> One thing that may not be immediately obvious is that this is our local
> netdev thing, so it will only work on netdev@ and bpf@.
> We could try to convince Konstantin to run it for all pw instances, we
> never tried.

ngl, I'd love to have it on the riscv instance. Things are hectic for me
this month, but I might just ~harass~ask him about it after that..

Thanks,
Conor.

--wRUHkzBBSbDnLgU6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnQ1jgAKCRB4tDGHoIJi
0rRhAP9GP2eEIbEhKtBPnUJSJDp9esWXhxgUbmNib0nMWearkwEAs7lANltzZdpy
rfh95/1jdKE5NFdhAgYWW/VfAVviGg4=
=NT0+
-----END PGP SIGNATURE-----

--wRUHkzBBSbDnLgU6--

