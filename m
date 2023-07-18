Return-Path: <netdev+bounces-18718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 249997585DE
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 21:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8632810BD
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 19:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF013171CB;
	Tue, 18 Jul 2023 19:55:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52D210946
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 19:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D68C433C7;
	Tue, 18 Jul 2023 19:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689710142;
	bh=gshhwkunm0Nkznr6q9yEkdRdIiyNHnhVMZurRxoSIOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lgSBOvWQdpxF3liRy3mjW5e2MFL87uVxkeVJ1V2wPudywexzVM18dF3ko8cfRL/EH
	 +VwKa8cr4Kojk/tBS5K9Qgl/+UXz39EWbpO3NmAtzd6k3bK6WcfCseH6RjE4b9UEcm
	 mXH6ANOp6IJ5J4HdWrjaWQ2bH7ueTtEr2KM+8PHf40GJni1e8zVZaR9s5f7b4rCTZv
	 jWVCDticxRP5dKAu4n0O0N+dSF/tm9SBR1ORKXtt5NZBYCmt29WxD09jfTvNVNotFL
	 HRTWsdMlFS+2DBMXp81oqy6bufzJUfwty4TFn9hCwiv1zt0UbDxJBxcaLPon+du3S8
	 Cdw8dFvA/BYxQ==
Date: Tue, 18 Jul 2023 20:55:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	gregkh@linuxfoundation.org, linux@leemhuis.info, krzk@kernel.org
Subject: Re: [PATCH docs v2] docs: maintainer: document expectations of small
 time maintainers
Message-ID: <71224ff9-98d0-4148-afb8-d35b45519c79@sirena.org.uk>
References: <20230718155814.1674087-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LSdGOUQcgKsH6g7g"
Content-Disposition: inline
In-Reply-To: <20230718155814.1674087-1-kuba@kernel.org>
X-Cookie: You are as I am with You.


--LSdGOUQcgKsH6g7g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 18, 2023 at 08:58:14AM -0700, Jakub Kicinski wrote:

> We appear to have a gap in our process docs. We go into detail
> on how to contribute code to the kernel, and how to be a subsystem
> maintainer. I can't find any docs directed towards the thousands
> of small scale maintainers, like folks maintaining a single driver
> or a single network protocol.

I'm not super comfortable with all of the musts here but this is
probably fine so

Reviewed-by: Mark Brown <broonie@kernel.org>

One note:

> +Maintainers must be human, however, it is not acceptable to add a mailing
> +list or a group email as a maintainer. Trust and understanding are the
> +foundation of kernel maintenance and one cannot build trust with a mailing
> +list.

If you're revising this I'd add a note about the L: tag in MAINTAINERS
here, or possibly just adding a list in addition to humans.  It is
sensible and often helpful for companies to want to get mail copied to a
wider distribution list internally but they're not really what we mean
by list since external people typically can't join them.

--LSdGOUQcgKsH6g7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS27jgACgkQJNaLcl1U
h9CIIgf+LLz2FFY+gdDkyU+XJv8nVYZJr7tmYVzdbjT94MAsKgVXjd/DcXrUdISB
gItU3VHXnC2vXX+rgEUOSZwEBQ2HXi/Grj4As79eV6n29QwE4yMDZ2GIOhcDKqvH
2GZGDLYaShzkKQNzin2eyCkjVd9ZCquoNCpU8trTaUz56uX3DmuyD2JwqDWnqX1v
OkPdZHhfAF1jy9XPo1CNXMjgnhP3yNawqptigD7c/bVGY76VjwJ0pphpPij93BQl
eHMTeQceIZGAPnDtxJAcxFHojjZ9UoHPcit1hMLuIn4xSIIMMOJDVS2fyrcLTynJ
qg2xILiUbAc4zJlKhCe2eLYe8eM4sg==
=guc9
-----END PGP SIGNATURE-----

--LSdGOUQcgKsH6g7g--

