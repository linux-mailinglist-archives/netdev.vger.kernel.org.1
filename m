Return-Path: <netdev+bounces-231810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDC4BFDB9A
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6A524EBD34
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 17:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783B32E266C;
	Wed, 22 Oct 2025 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fk9S5V7e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEA52E1C63;
	Wed, 22 Oct 2025 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155752; cv=none; b=pLu61XrPQ0PVWuLaf/q0k1XxYRGUNpYv8Gnm4Lf9Ss+VfWhvERHtD/Z1fwiouikhJhMzaQdopbMsW+18Xz92TROejirdPZMpMtRG3rsr3lqH+zxAcwS8a7gJVrS2GjCHziO3+ZC2k7FzmhRNJv4FykaQzmP2Jv+WGtDX0LsNm2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155752; c=relaxed/simple;
	bh=C4WuYHaDzOP7+5zsJBlMugIAzvOKES0c4U08yVlUha4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQ2pArcDFEMMAzgaAxXlziBsfTWXVWLz1+KUPvOUaTLz0c0fWLIR2aiFRCVIP8NGlnTIAtBh5yoU8AlHPRz/Ka/pioPkuQcOHrQYyE1ZF8TzXebOn/Zbx8+tS03EsfntL//E96fxE+/5g/iWncn/GiFgdkZitQucPq+Y4bBgtUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fk9S5V7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835D7C4CEE7;
	Wed, 22 Oct 2025 17:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761155752;
	bh=C4WuYHaDzOP7+5zsJBlMugIAzvOKES0c4U08yVlUha4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fk9S5V7eEiFrlEDfbx7V9oyHJlLOWGHygvtyMyraCARInFo0KmETtDUzOf2p1Ipw6
	 6nyW8KLbplP3ZAsl4PX8BaF/YoYpFBtOihcQ9bAI6o4mjx/D7xc2oG43zlyGo7gKBF
	 OQb6lqLoNHiG7PHBaLBr43FPj3R+XZE4H0tCzbcEELdGJazZcFl7nUo4ds0AgoWebH
	 iUxvMP7RkxiqtRqFZ+T/EYFHsylTPNrZ5fHnN4986owhuV6F8nM+vBgq72xl7BlyBn
	 y4SVGE0AbEibkPXne1+TysAx6epzcc4JEuRRC/kmkwrUw1K0knbR/qbprlmoPSn8NR
	 f6nU0TUYJaP3w==
Date: Wed, 22 Oct 2025 18:55:47 +0100
From: Conor Dooley <conor@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: net: snps,dwmac: move rk3399 line to
 its correct position
Message-ID: <20251022-surname-aids-07567ac4c90b@spud>
References: <20251021224357.195015-1-heiko@sntech.de>
 <20251021224357.195015-2-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8oMUtKEfj3uyR5ub"
Content-Disposition: inline
In-Reply-To: <20251021224357.195015-2-heiko@sntech.de>


--8oMUtKEfj3uyR5ub
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--8oMUtKEfj3uyR5ub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPkaowAKCRB4tDGHoIJi
0vhUAQD07Lru5LY8cJVEUyj0XoKXH6lq06oo4YlBtD+fb4aaAQEAzhXIx+h09vQZ
vTn5EbrWpkEDq8A58evzNByWLJxDZAY=
=1A+K
-----END PGP SIGNATURE-----

--8oMUtKEfj3uyR5ub--

