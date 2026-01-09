Return-Path: <netdev+bounces-248587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 879EED0BFC8
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 20:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FA63300E44F
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 19:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAAE2E2DF4;
	Fri,  9 Jan 2026 19:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="NKlO+Yr+"
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA322D7DF3;
	Fri,  9 Jan 2026 19:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767985284; cv=none; b=byRVM+g7dUTx0f66wxeDmhEabgyn+pd3eOUCP3admH/Bk6m9oq2LcANXSWzt++BV04gU5mhnVhMBCE+eL2IPRBAbuIfDKNq0SARusfNJsp1sAHISDeuoGtmu4cVvMEJdPSseLGQdm7CD7ys4MU071Lx03Q6aPatR8INzZImKqEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767985284; c=relaxed/simple;
	bh=/IU37Z97SXuWFbA+mUyau0HQD/kw5AVXBHwP0FjtMwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S4VN6Q6sDbawGFHYQDIUmmFCtfXMHFav3pTFGXK92RP0r/5Rli8Q79KrDuPZmBorN4yrOn9A2jZZIequryRq5vYSNN/tqvWYicor5BnEBR/ngkVge5/aMnZiaFlPggGQOPfLAfzwnGAuvPI4W0aUawblBEY/Lsn0ODwCzpWtHLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=NKlO+Yr+; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=OeweFw3yUXjrRcyiy2cr3jMXmJJei7ulqdxDcunsWNk=; b=NKlO+Yr+9H5IHftz7yq17xYjze
	1V/k3oO6vssk9e6UPN/t+W5R+d5HhBViDw5o2QDzbVwTqG1H8SS9dQDNR6tEFlGC0AqAKQd5O3U2S
	Cy0Q+q8WYkcZg/Hglpu4Fj4WCv+YmkDKtIiJneKxADsbBYE77MdVoP4xgEK/vTh6hqXH+o+2fCiVY
	qLtLLH5y9E5B0meVXB1wFaqhdcd2mWo4wNVr/AGKzjs6XahWRQ/iwsb0RSiCgfVR0xZc9EfMQS/Nk
	QaZD8DGZQqO5V/siiMsLahLQChTLm8DoGfnGCAZ39q0l2eB/zqob5NQ3n9EtNDAMpa29igzz2ys7x
	A5pi1cZw==;
Received: from [192.76.154.238] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1veHim-001fb6-87; Fri, 09 Jan 2026 20:00:28 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 David Wu <david.wu@rock-chips.com>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH net-next] dt-bindings: net: rockchip-dwmac: Allow "dma-coherent"
Date: Fri, 09 Jan 2026 20:00:28 +0100
Message-ID: <8189811.4vTCxPXJkl@phil>
In-Reply-To: <20260108225318.1325114-2-robh@kernel.org>
References: <20260108225318.1325114-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 8. Januar 2026, 23:53:18 Mitteleurop=C3=A4ische Normalzeit s=
chrieb Rob Herring (Arm):
> The GMAC is coherent on RK3576, so allow the "dma-coherent" property.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/=
Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> index d17112527dab..80c252845349 100644
> --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> @@ -85,6 +85,8 @@ properties:
>          - clk_mac_refout
>          - clk_mac_speed
> =20
> +  dma-coherent: true
> +
>    clock_in_out:
>      description:
>        For RGMII, it must be "input", means main clock(125MHz)
>=20





