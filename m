Return-Path: <netdev+bounces-149215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4304D9E4C7F
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 03:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEDB01881884
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 02:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267C6188733;
	Thu,  5 Dec 2024 02:51:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7A02B9B7
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 02:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733367077; cv=none; b=D9xyxl1x2C6f08Gwk1wCGKpxYm3VoUUJ3PZ9sOGM7qQ9bo1WbGG4PQWU1tc5f3zNMn8na54mtE+obTrOVOv81H+2VR9ymRT4FQ3DKBIIZZeKo0PffplzdlDhuM1cA9L+UCEPYBhwRPDUzFJgkHmXJ3NGY5oxcA/Sqya3NWthkKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733367077; c=relaxed/simple;
	bh=5zCm4CNLZVX6DGzfPWhS8XZO5skhlT3YdXhutIb9o4g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=FouBj49chjRtIKQahOiN6PIRyVVA8ET9NBzcxwpZtCZlPZ0Htsiz9N1KsHcGN3gCx69pkBKWBeuy4XytxCX0zW7de3nYBD0xI0s/3QoxVJFrOMLiyB0ypETLvkauhhqZlnr7PMi4DT9jCXOGesDxhmdkzuBQ8DKLjJ36RxQ1zaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-198-XJ7RauEWMWiCk5q0CxqY9w-1; Thu, 05 Dec 2024 02:51:12 +0000
X-MC-Unique: XJ7RauEWMWiCk5q0CxqY9w-1
X-Mimecast-MFC-AGG-ID: XJ7RauEWMWiCk5q0CxqY9w
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 5 Dec
 2024 02:50:32 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 5 Dec 2024 02:50:32 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Oleksij Rempel' <o.rempel@pengutronix.de>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, "Jonathan
 Corbet" <corbet@lwn.net>
CC: "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, Russell King <linux@armlinux.org.uk>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: RE: [PATCH net-next v1 3/7] phy: replace bitwise flag definitions
 with BIT() macro
Thread-Topic: [PATCH net-next v1 3/7] phy: replace bitwise flag definitions
 with BIT() macro
Thread-Index: AQHbRVjnQkywrpUglUK7+rlkvzAGKrLW9Zbg
Date: Thu, 5 Dec 2024 02:50:32 +0000
Message-ID: <5fbf293df6bf4bf79f9a8ffd728c6e2c@AcuMS.aculab.com>
References: <20241203075622.2452169-1-o.rempel@pengutronix.de>
 <20241203075622.2452169-4-o.rempel@pengutronix.de>
In-Reply-To: <20241203075622.2452169-4-o.rempel@pengutronix.de>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5SZLWqBKwvzPpnHsjDT3ZcvNc8UnP-a-bYJu_ip36X0_1733367071
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Oleksij Rempel
> Sent: 03 December 2024 07:56
>=20
> Convert the PHY flag definitions to use the BIT() macro instead of
> hexadecimal values. This improves readability and maintainability.
>=20
> No functional changes are introduced by this modification.

Are you absolutely sure.
You are changing the type of the constants from 'signed int' to
'unsigned long' and that can easily have unexpected consequences.
Especially since MDIO_DEVICE_IS_PHY was negative.

=09David

>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  include/linux/phy.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 20a0d43ab5d4..a6c47b0675af 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -86,11 +86,11 @@ extern const int phy_10gbit_features_array[1];
>  #define PHY_POLL=09=09-1
>  #define PHY_MAC_INTERRUPT=09-2
>=20
> -#define PHY_IS_INTERNAL=09=090x00000001
> -#define PHY_RST_AFTER_CLK_EN=090x00000002
> -#define PHY_POLL_CABLE_TEST=090x00000004
> -#define PHY_ALWAYS_CALL_SUSPEND=090x00000008
> -#define MDIO_DEVICE_IS_PHY=090x80000000
> +#define PHY_IS_INTERNAL=09=09BIT(0)
> +#define PHY_RST_AFTER_CLK_EN=09BIT(1)
> +#define PHY_POLL_CABLE_TEST=09BIT(2)
> +#define PHY_ALWAYS_CALL_SUSPEND=09BIT(3)
> +#define MDIO_DEVICE_IS_PHY=09BIT(31)
>=20
>  /**
>   * enum phy_interface_t - Interface Mode definitions
> --
> 2.39.5
>=20

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


