Return-Path: <netdev+bounces-65118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C6C839481
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303F01F258D8
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8319F6351A;
	Tue, 23 Jan 2024 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pschenker.ch header.i=@pschenker.ch header.b="F519chZT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF596281F
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706026678; cv=none; b=TBUNvYZ7oTSJ5dZgVMho29j9ysUS4JWUraZWG4vBQf3YC/snWQmF4zoAqEh5H0QHzbr22qgXSsZioX2/LIlpt1xGL/BLa2IxcMOVcr/UIXVcoR0+EfD1ZtWaRBpmLHrFhqF59ET8AqA0hERh8KqHIQ8itVAK7IfaoNSKWaiqSP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706026678; c=relaxed/simple;
	bh=1NG8wi6AszbC+t2mITn/X0WKvcHrmSYn4Gpm9d1E7n0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J26gu6KWzhQxTcrX1aPGwGktDGQOJ3gPTKlvX7zMawyUqDiXEZX7dJYofg3GDorOlJ6+R+u/i2/1HZn2kOw0+QlsT6CkR/UM99R221Q7bLBKuTPDFzjuFpymWbufI3NEPeQ8MNGEMw97fSAFkVhYu8YiP7wrr+/gyfnVddh79fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pschenker.ch; spf=pass smtp.mailfrom=pschenker.ch; dkim=pass (1024-bit key) header.d=pschenker.ch header.i=@pschenker.ch header.b=F519chZT; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pschenker.ch
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TKC1G3P7FzMqFgm;
	Tue, 23 Jan 2024 17:17:54 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4TKC1F6DShzr4;
	Tue, 23 Jan 2024 17:17:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
	s=20220412; t=1706026674;
	bh=1NG8wi6AszbC+t2mITn/X0WKvcHrmSYn4Gpm9d1E7n0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=F519chZTJVObdy2utWFWlWTH24Apz/VpWi/QpvB+KxeHkqtE98o1TTT1fXq61NgK6
	 5ee7pjWUiJ6viyIQyOFKs2nIBqE5c9DMoJf9YNJr6eotoDf8MMnfEpSR2aLfatIAmj
	 x21UmRMKRV8e5BCnndG/sC5Kc3wb1eONigMf0ILA=
Message-ID: <b2e232de11cee47a5932fccc2d151a9c7c276784.camel@pschenker.ch>
Subject: Re: [PATCH net-next v1 1/2] dt-bindings: net: dsa: Add KSZ8567
 switch support
From: Philippe Schenker <dev@pschenker.ch>
To: Conor Dooley <conor@kernel.org>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Conor Dooley
 <conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>, Vladimir
 Oltean <olteanv@gmail.com>, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com,  Marek Vasut <marex@denx.de>, Florian
 Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Jakub Kicinski
 <kuba@kernel.org>,  Andrew Lunn <andrew@lunn.ch>, Rob Herring
 <robh+dt@kernel.org>
Date: Tue, 23 Jan 2024 17:17:53 +0100
In-Reply-To: <20240123-ripening-tabby-b97785375990@spud>
References: <20240123135014.614858-1-dev@pschenker.ch>
	 <20240123-ripening-tabby-b97785375990@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Infomaniak-Routing: alpha



On Tue, 2024-01-23 at 16:06 +0000, Conor Dooley wrote:
> On Tue, Jan 23, 2024 at 02:50:13PM +0100, Philippe Schenker wrote:
> > From: Philippe Schenker <philippe.schenker@impulsing.ch>
> >=20
> > This commit adds the dt-binding for KSZ8567, a robust 7-port
> > Ethernet switch. The KSZ8567 features two RGMII/MII/RMII
> > interfaces,
> > each capable of gigabit speeds, complemented by five 10/100 Mbps
> > MAC/PHYs.
> >=20
> > Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>
>=20
> This device has all the same constraints as the other ones in this
> binding, why is it not compatible with any of them? If it isn't, the
> compatible should mention why it is not.

Hi Conor, Thanks for your message!

I need the compatible to make sure the correct ID of the switch is
being set in the driver as well as its features.

You mean I shall mention the reason in the commit-message, or where?

Philippe

>=20
> Cheers,
> Conor.
>=20
> > ---
> >=20
> > =C2=A0Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 1 =
+
> > =C2=A01 file changed, 1 insertion(+)
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > index c963dc09e8e1..52acc15ebcbf 100644
> > --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > @@ -31,6 +31,7 @@ properties:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - microchip,ksz9893
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - microchip,ksz9563
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - microchip,ksz8563
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - microchip,ksz8567
> > =C2=A0
> > =C2=A0=C2=A0 reset-gpios:
> > =C2=A0=C2=A0=C2=A0=C2=A0 description:
> > --=20
> > 2.34.1
> >=20

