Return-Path: <netdev+bounces-147200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAC79D834C
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 11:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B154028197E
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 10:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B5518787F;
	Mon, 25 Nov 2024 10:25:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE072AD17
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 10:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732530332; cv=none; b=n1q7vVsHmO9bGLygR3Dp0gYaOW1P5i4OpOaxSmHAVPGKaXtaT1SqqzyQ6K74Uhys3Lk7pvGgIXKvyNkcB6p1JJb9Yactwns9bdZi11qNCed4ORLE57cbVmaZXf+Q/0QJevUvr07o7cnam1aPF0KADpnFqflkFrgtm9iJOAu5A80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732530332; c=relaxed/simple;
	bh=I+RX/TmhWq4W9+r2o2PeZORuyPTs7I0CRhujUzcI1dg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C0YEzLDnlgFMhpYZQIbnWoIig1+rDKpUCa7preK/Gw6MAi8lYQ5TkYYrR48SzTz5N2J80eK+hUt1AHQ08Ht2YG38bljx9jKvckhZa16FTgKUuFnPzLy+Rwt+QfYQSXtIPQH6tkmiZYz7Qq7KxklbSpyhJ0gerdml0kb/P+jFk9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tFWH9-0000Jo-SO; Mon, 25 Nov 2024 11:25:03 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tFWH2-0003zT-24;
	Mon, 25 Nov 2024 11:24:57 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tFWGy-000CmW-11;
	Mon, 25 Nov 2024 11:24:52 +0100
Message-ID: <cc93cc7332e97e31f90edc13496951dc0df12744.camel@pengutronix.de>
Subject: Re: [PATCH net-next v3 1/7] dt-bindings: net: ftgmac100: support
 for AST2700
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Jacky Chou <jacky_chou@aspeedtech.com>, andrew+netdev@lunn.ch, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com,  robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, ratbert@faraday-tech.com,  netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>
Date: Mon, 25 Nov 2024 11:24:52 +0100
In-Reply-To: <20241120075017.2590228-2-jacky_chou@aspeedtech.com>
References: <20241120075017.2590228-1-jacky_chou@aspeedtech.com>
	 <20241120075017.2590228-2-jacky_chou@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Mi, 2024-11-20 at 15:50 +0800, Jacky Chou wrote:
> The AST2700 is the 7th generation SoC from Aspeed.
> Add compatible support for AST2700 in yaml.
>=20
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml=
 b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> index 9bcbacb6640d..fffe5c51daa9 100644
> --- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> +++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> @@ -21,6 +21,7 @@ properties:
>                - aspeed,ast2400-mac
>                - aspeed,ast2500-mac
>                - aspeed,ast2600-mac
> +              - aspeed,ast2700-mac
>            - const: faraday,ftgmac100
> =20
>    reg:
> @@ -33,7 +34,7 @@ properties:
>      minItems: 1
>      items:
>        - description: MAC IP clock
> -      - description: RMII RCLK gate for AST2500/2600
> +      - description: RMII RCLK gate for AST2500/2600/2700
> =20
>    clock-names:
>      minItems: 1

Given patch 3, I would expect a resets property to be defined and
possibly added to the list of required properties for aspeed,ast2700-
mac.

regards
Philipp

