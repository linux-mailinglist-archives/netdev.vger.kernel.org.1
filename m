Return-Path: <netdev+bounces-74105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 141A886002E
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 18:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452691C238E3
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 17:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3DB15696C;
	Thu, 22 Feb 2024 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCnNDK7A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4684155A5C;
	Thu, 22 Feb 2024 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624669; cv=none; b=Kb7Czhz508WCv7fWNnqm6i+BwtT0JPu0Zc99HuLFGmihw5kNPyI6Ju37ejgewZduWzdqasRuMZyE4vS+0PihWn4OXpCwG6/hRRGcIs3Mjou7G3D+wSG6eCnvhLPsHJGaGgziPcESH02tNFhAh07ZAjwFLIk6PyQvvskXXy+OJbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624669; c=relaxed/simple;
	bh=NlepLU1IkX5NFGOdm1Fp+waf/GdME+Xd7+O2IGTpcGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJXxen35T8Ha4sVz62iC/PTHasw1bCGG0e9KrmJeduN3rEJePVsOPkO5Y1Ca29aZEb30PT+oyDqavkMjCBKn5XENdPxJymqrJ2yQiQnShkq1Z56OsNocgqdvQAcIYn9ZMTr85qNslnm92Ap3AW0PpmDIBq7mwWNH8E+iiBkpQFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCnNDK7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EE6C433C7;
	Thu, 22 Feb 2024 17:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708624669;
	bh=NlepLU1IkX5NFGOdm1Fp+waf/GdME+Xd7+O2IGTpcGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TCnNDK7ANhJpdzwCBCRy2xDVk78UIk0xDNsQG2zwV6yjRwM2UlNBvVvGe+3DUUHdl
	 C4ukqvrf/91XtmT3KU+wWhLliHWuM/xUepWZur7luVJH+U1OICS1zKqtfSPFlwPOCs
	 +v9qY+41/qxcPFvemjPX4BKT16V26xlD0Sk3s+e+spBpv0ufFGWtYMeBX9yZSAQcjT
	 uTYg+IfA9sVSWiL7FLGss9Bhv5gOn3xIz+5M8Pb841aWf/H8FoXBeosTJk8kBgFe2p
	 PFiS2p6U36+D8my8LaUfQUwkTicx+qEjdAojqQnZmflgsfpb4xBXAMNEQXw181yXjz
	 Pqlk0e4d7RQsg==
Date: Thu, 22 Feb 2024 17:57:44 +0000
From: Conor Dooley <conor@kernel.org>
To: Diogo Ivo <diogo.ivo@siemens.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	jan.kiszka@siemens.com
Subject: Re: [PATCH net-next v3 01/10] dt-bindings: net: Add support for
 AM65x SR1.0 in ICSSG
Message-ID: <20240222-rebate-squiggle-d6801d506994@spud>
References: <20240221152421.112324-1-diogo.ivo@siemens.com>
 <20240221152421.112324-2-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Hhfnaeilk2i9ejhd"
Content-Disposition: inline
In-Reply-To: <20240221152421.112324-2-diogo.ivo@siemens.com>


--Hhfnaeilk2i9ejhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 03:24:07PM +0000, Diogo Ivo wrote:
> Silicon Revision 1.0 of the AM65x came with a slightly different ICSSG
> support: Only 2 PRUs per slice are available and instead 2 additional
> DMA channels are used for management purposes. We have no restrictions
> on specified PRUs, but the DMA channels need to be adjusted.
>=20
> Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--Hhfnaeilk2i9ejhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdeLGAAKCRB4tDGHoIJi
0h3SAPwIj1Tsf7UlvzD0iQym9nQVdjpmIASXKB1SDp7tg3Pn4QD+Jk8XT0oG4HMP
rwBe4sL/qYwJsYrE5yqJgujYHCUC0wM=
=Z4S5
-----END PGP SIGNATURE-----

--Hhfnaeilk2i9ejhd--

