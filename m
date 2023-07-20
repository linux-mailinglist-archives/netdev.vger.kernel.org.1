Return-Path: <netdev+bounces-19598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CCF75B54C
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 19:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443B0282034
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 17:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8092FA43;
	Thu, 20 Jul 2023 17:14:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDA02FA2C
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 17:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0891BC433C8;
	Thu, 20 Jul 2023 17:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689873266;
	bh=/sCTDKu7Y/9YwOel3/H9ilGvBUrz9mL9LhZ3Oi3p9kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uqd5sWm9GA6elmeRDpvOTG2iRqR0li5scbTMwn/+eIH8oNPYAm59qtWDx5nc/qa1w
	 kM5zQ2LHosrqb+0qJYsBNrIyfmpjToRP/j/7Cch4kfkBqr8r33MV6F8nl1KQsWUfRF
	 GMlnAXtYNaIvylNRx+FypmaLiKpta5hojlIxnOXhpLWlf+YnLq9YbxPsTvq8Vt4VFV
	 nYaPm4MO7ygGHSxDGb/+YV0CkcTVbspT3x70pq0gQdAT9DlM6WtVeXvqSNCGPsoyQ+
	 sdwiNpGm07nTdtEhwfJGOnYPTMqH47ZGrUBg+Uu2Tw0UsTh7anLvz20TZ0V6GyUTJn
	 XMx+4eCC60GNA==
Date: Thu, 20 Jul 2023 18:14:20 +0100
From: Conor Dooley <conor@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v1 0/6] net: dsa: microchip: provide Wake on LAN
 support
Message-ID: <20230720-unmapped-frostbite-17534e2a0c70@spud>
References: <20230720132556.57562-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0C2AQsgm4evWVLHo"
Content-Disposition: inline
In-Reply-To: <20230720132556.57562-1-o.rempel@pengutronix.de>


--0C2AQsgm4evWVLHo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 20, 2023 at 03:25:50PM +0200, Oleksij Rempel wrote:

>   dt-bindings: net: dsa: microchip: add wakeup-source property
>   dt-bindings: net: dsa: microchip: add local-mac-address property
>     support

For these two,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.


--0C2AQsgm4evWVLHo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLlrbAAKCRB4tDGHoIJi
0s88AQDK7+qrIHL1o7b28ssKUMhMLAGTdOzYQI0YxgptNtbk9AD8DDbx7UZo+K7M
FdYBjRr2VwN3BVPdOSAnGcB0hUomFgM=
=Kf5+
-----END PGP SIGNATURE-----

--0C2AQsgm4evWVLHo--

