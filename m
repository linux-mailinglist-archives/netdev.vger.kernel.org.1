Return-Path: <netdev+bounces-226510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8C4BA12A1
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 21:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD063A1C61
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 19:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CBD31B83A;
	Thu, 25 Sep 2025 19:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVUmysBX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7619631B829;
	Thu, 25 Sep 2025 19:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758828333; cv=none; b=ezWyWHyaV8ga9je91K/oRjTMdD4okftmfu7kIwhvEDvoKOk/6mmJh9zL6TscPsJtZXelt0L00ptpUptWOg36L0AYd384kLGHldFSSzaoSVy595s5vrk25w8e9YlT4fh+tSZAbonsVEcQsn/YeW0YNMvZszr4atqfI0a6vgn6B3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758828333; c=relaxed/simple;
	bh=0WqDH+Ptb/z6NI8Zp6WcjeVisQWM4In7zspEI8GYWFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJyl1b8o9QmAjYFHpHyzdwftMG3uhJ70T6LFm2nfJXCJsbQeZLNEFF9tghH3JQA/Ji6n+WclpF4IoEewuIWzZkLmt/CAbcpbzjhOtag1J2wwmE1jghSAqS8dC/nOjjqL4nDLokxjIY0yzV5C+1AlBZ83VcOVtblL5wKuFdGfjD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVUmysBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83C3C4CEF7;
	Thu, 25 Sep 2025 19:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758828333;
	bh=0WqDH+Ptb/z6NI8Zp6WcjeVisQWM4In7zspEI8GYWFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IVUmysBX9lAUhUCQny0ELnZuJpYoLibvlbm5y8DP3ru/efDs7/ia3/yyM65Z2p05k
	 8OGroFWhufzikOo0De3bTZ3EMNzyGtuOY0Mc3u3k3vUbFiadhkbCiaMNCV0sBNX3L9
	 jv6LLoyPiMzm3nTAM/qobpMjD3/3aBx5TQwK/2DDiWlbnBa30i2oFi5/SRcpKu0AaE
	 aed3twE7ldL+MfR1pEPoLHbvOih2jFwFEN0zKK5x7GdzlITrJ2wBpJjlA37Qc4WOv1
	 6e7JDi0mXgPLtrArOMHpQ0a9iUFfQ/GGlITg+kOULb07Xp1MHOARBVRqwt9I9IvbH9
	 ymrGcCiUkKctg==
Date: Thu, 25 Sep 2025 20:25:27 +0100
From: Conor Dooley <conor@kernel.org>
To: Robert Marko <robert.marko@sartura.hr>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
	lars.povlsen@microchip.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, luka.perkov@sartura.hr,
	benjamin.ryzman@canonical.com
Subject: Re: [PATCH net] dt-bindings: net: sparx5: correct LAN969x register
 space windows
Message-ID: <20250925-outscore-paternity-69ff215963e8@spud>
References: <20250925132109.583984-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vLz2jGEcwewmv5kk"
Content-Disposition: inline
In-Reply-To: <20250925132109.583984-1-robert.marko@sartura.hr>


--vLz2jGEcwewmv5kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--vLz2jGEcwewmv5kk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNWXJwAKCRB4tDGHoIJi
0vnbAP91mV0T/4HeVsHGDqLadF3xVkxmrX7YYZ4na6tzg843qgEA/DjI3IHzSkCM
qZg5Ndw8iJ7RzgnX0pegaHvRfXwYQAs=
=vQNG
-----END PGP SIGNATURE-----

--vLz2jGEcwewmv5kk--

