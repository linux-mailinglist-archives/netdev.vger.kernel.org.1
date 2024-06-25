Return-Path: <netdev+bounces-106701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 873B2917516
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 01:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89BF1C211F3
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 23:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC1017F4FE;
	Tue, 25 Jun 2024 23:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="d/VYFTt7"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C101494DE
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 23:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719359817; cv=none; b=LtkX9RJCgI7dbhui0ByEFDwOYo8gu3/Lg5j0klDuO4TTczvHK0XTQiiei0oGYAM/8NZUfqd0LOgFfKSkDFo1JEOH+R6dWffkDoyDl4AWT/RvRHQJhjw9yWekZ/ExXzstTZ0624OBLWcFjOkQ8fP6xgALlXzhsybEsEeI+Mo+edk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719359817; c=relaxed/simple;
	bh=B/BOz8hJdvZcvCYQbP8ja7AVokFlLC4NtFVCQhf62sA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UCPB8j4rtgEcbv7MuY58M1FfG7o58EtHQADQe/x+wyoua8sTwV/QiOq89L1Q7uYkH15BRHGinBZEo2PF6Wr/mzeQ9P+8tlwVOegrE1W5stH9kBh75XwP5DS+fDNLcgBAjl5oEItSf69ewlOxfO/DkcEjEfUvp2vlqkOI0f0kU2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=d/VYFTt7; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 201F620009;
	Wed, 26 Jun 2024 07:56:45 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1719359807;
	bh=B/BOz8hJdvZcvCYQbP8ja7AVokFlLC4NtFVCQhf62sA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=d/VYFTt7E+QDQyR/eXC/+m1U2AT0GFXpNBljPhzSbpi0EufbD7onpntl2x4L1b427
	 IagnUeDRNnSq0vLc3KJ/t3YfpiwIkpkFR8JabGnicPBFwyHPs1Tk3ZBcguIk+tSKBT
	 smctMMSE1ErWQPiWpnxf3JqyM5JjJDVfPB7utNhKqVzKT5gbqEtajWGysLLRoLIhxu
	 qviIG5kDfUxQfQ7dOksqGk+90UjP0+d8IYgFBrzhaEqKuUx0VVR8JpIjoqou8AgwMW
	 mjCBnNfS4Iha5rHmsrPSuDIk5rELNEx+TQtYc0xrUZYu1SxKAI4C1dgqxSx4mtqoDs
	 ncZnK1AXNVYQA==
Message-ID: <f93aadeee5963955df61be2a245d0857a2ba93c0.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next] net: Drop explicit initialization of struct
 i2c_device_id::driver_data to 0
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, Woojung Huh
 <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,  George
 McCollister <george.mccollister@gmail.com>, Ido Schimmel
 <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,  Matt Johnston
 <matt@codeconstruct.com.au>, Oleksij Rempel <o.rempel@pengutronix.de>, Kory
 Maincent <kory.maincent@bootlin.com>, netdev@vger.kernel.org
Date: Wed, 26 Jun 2024 07:56:44 +0800
In-Reply-To: <20240625083853.2205977-2-u.kleine-koenig@baylibre.com>
References: <20240625083853.2205977-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Uwe,

> These drivers don't use the driver_data member of struct
> i2c_device_id, so don't explicitly initialize this member.
>=20
> This prepares putting driver_data in an anonymous union which requires
> either no initialization or named designators. But it's also a nice
> cleanup on its own.
>=20
> While add it, also remove commas after the sentinel entries.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Thanks!

Reviewed-by: Jeremy Kerr <jk@codeconstruct.com.au> # for mctp-i2c

Cheers,


Jeremy

