Return-Path: <netdev+bounces-191933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 271B8ABDF7F
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 17:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80EB67B4387
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 15:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B731526159E;
	Tue, 20 May 2025 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzJbViYv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860F92512CA;
	Tue, 20 May 2025 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747756098; cv=none; b=AC7gWSZreIUbSEucxst34m/I8sUhInryj0Zsqo+5U6EPDWpx+mi6RejMPHUCE8hG0wt58jhItC1SAv9UbmKIWzOS+XR9pb+cwT0UUsY+V6vUcVar3BQwVbgcbc4+SjCcD8hxzeO63G2QIbj7mwTLV6kFBtTkCg4rLQ6Hs0iL/xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747756098; c=relaxed/simple;
	bh=Na7JhdnilcYOMSmY3FiOD82OSlegu9QIZHVGHZNYf+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZRVOCBhY6JOnrJfCfkK+dRcZiWXQX4hiuA7kiI4kZ45wrJopUjNVwi/8Y+lFVBvO22LAQvd8L8oBHpZNsivUYdFQc21s6fFE3+IKS3mT5c4En+oh4SEnjNv2bHaKEYjjWvjA9rLsUi2jinN2ez/VfyxAvdUo6WqnIwVgSw7Brk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzJbViYv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F137C4CEE9;
	Tue, 20 May 2025 15:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747756097;
	bh=Na7JhdnilcYOMSmY3FiOD82OSlegu9QIZHVGHZNYf+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BzJbViYvKnuAovyYZe09dS8NHjgji+yJvJjuR77hWD1aTLvfIMRMqREH51Mgyw/N0
	 uHKKvfu7s81RbqRBRgxYia/WZO/dyro9Q/kkhBvveaZsuZXSKudaGql50akbvQQ0f0
	 jjtgC2yV/mQZSkdR/vToznC/FldLOt2sG6EXLsBQGhV4N6QNCbCeVD4HgWIMpEvB/Q
	 fPrC+/JqRvSVoOLdH7c5EDdDH2N02XOU5K4xpgz+adNfY2HuGXGa9v5bMLIW9DFyA/
	 ZzM4GiiVkqRWR4QTxFyk9/W+a70WuyagPXo3wYdnr+dChOLTJhGrn3CjQVUy2tFdso
	 IoF2Nc9Y1bONg==
Date: Tue, 20 May 2025 16:48:11 +0100
From: Conor Dooley <conor@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, mturquette@baylibre.com,
	sboyd@kernel.org, p.zabel@pengutronix.de, BMC-SW@aspeedtech.com
Subject: Re: [net 2/4] dt-bindings: clock: ast2600: Add reset definitions for
 MAC1 and MAC2
Message-ID: <20250520-exile-obvious-b72b7db702d0@spud>
References: <20250520092848.531070-1-jacky_chou@aspeedtech.com>
 <20250520092848.531070-3-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UvQk65mnV/tHD2qu"
Content-Disposition: inline
In-Reply-To: <20250520092848.531070-3-jacky_chou@aspeedtech.com>


--UvQk65mnV/tHD2qu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 20, 2025 at 05:28:46PM +0800, Jacky Chou wrote:
> Add ASPEED_RESET_MAC1 and ASPEED_RESET_MAC2 reset definitions to
> the ast2600-clock binding header. These are required for proper
> reset control of the MAC1 and MAC2 ethernet controllers on the
> AST2600 SoC.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--UvQk65mnV/tHD2qu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaCykOwAKCRB4tDGHoIJi
0giFAP9mpUDwyGsaZ4s+JSGA8E4mfSJLTl4kzfMX6Vy3keT5qgD/eKnvov8kgNkW
zNvHBzlyYwGeF2M/jKKSqLaqEjzsCwU=
=TAV4
-----END PGP SIGNATURE-----

--UvQk65mnV/tHD2qu--

