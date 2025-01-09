Return-Path: <netdev+bounces-156834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A07A07F3A
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 18:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF741694A2
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA0F1991A1;
	Thu,  9 Jan 2025 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkPvYxt2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EFB17B421;
	Thu,  9 Jan 2025 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444908; cv=none; b=CN7hQJAkI4MmIduGXSDlU4dvUQaDAdmmziZCqdE5E9XPUnGW80e5t8z1j3PjmtLQ6wVrn7jVbYrbdbhpYhCiHffoanYai9hZXZTe8fQHatTZprvobwkDgF+wn8Jusu2pglOPV/4YT5bXaJtuzzf87Sb+HGm802QUobW4It06XFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444908; c=relaxed/simple;
	bh=nwF2wJILxsbe6koxpQXtd2nB0Ync5bXMj6SGjlKEwFg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NMvGR5jrvGeVxttx0WS8gNpxzFxoYXjxpxH0guoVpgD/58fAxgAK/6VNil8lbq+Dr1xxqQzQM+ZESL4xb9TGjSaGsFwxrA/hVAAAKnMWM1pQX+DHUzN8zCHw+oqP5/5U8xIlv6uedku5IWGzFvV5NPT017/MtWgiBWAm5hr4M8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkPvYxt2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2F8C4CED2;
	Thu,  9 Jan 2025 17:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736444906;
	bh=nwF2wJILxsbe6koxpQXtd2nB0Ync5bXMj6SGjlKEwFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VkPvYxt2FS2k3iUsJ4zwxKlOa035hiDEkOR/4Hk6a4AB0gYPBGPBcp24psEFdOszZ
	 VqQCPATEjH+6kyywBS58K8xkRNUJ6mB4lpb8BidsaItN5Ka3BjizPmVAlSGzp75Ljw
	 uDNGvXwcqA1xxlbJ+eB/Q1XdyONsQbgfjWho0RwWAB+f3/ZPwqUfvskIuQvZkRoI1Y
	 ddhCj9YaEK7WaQEfzjOb+mLjEzeApMHolc+18E+sbKkuMH6Ba99A+548gY7W3430rx
	 Fe5jCIXIPHaUPbkS0AwuCYsrjq2fTbuPm+fSZVr5B7ENVP0ryfp23x1oIma9aXTCic
	 pYL+DD42vyGeA==
Date: Thu, 9 Jan 2025 09:48:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v6 2/7] net: ethtool: plumb PHY stats to PHY
 drivers
Message-ID: <20250109094824.39cef463@kernel.org>
In-Reply-To: <Z4AHEEX1c0gcGEV6@pengutronix.de>
References: <20250109094457.97466-1-o.rempel@pengutronix.de>
	<20250109094457.97466-3-o.rempel@pengutronix.de>
	<20250109080758.608e6e1a@kernel.org>
	<Z4AHEEX1c0gcGEV6@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 9 Jan 2025 18:27:44 +0100 Oleksij Rempel wrote:
> > So we traded on set of static inlines for another?
> > What's wrong with adding a C source which is always built in?
> > Like drivers/net/phy/stubs.c, maybe call it drivers/net/phy/accessors.c
> > or drivers/net/phy/helpers.c =20
>=20
> I chose the current stubs approach based on existing examples like
> hw_timestamps. Any implementation, including the current one, will have
> zero kernel size impact because each function is only used once. While
> moving them to a C source file is an option, it doesn't seem necessary
> given the current usage pattern. Do we really want to spend more time on
> this for something that won=E2=80=99t impact functionality or size? :)

If we keep following existing approaches we'll not have any chance=20
to improve :/

But if you feel strongly it's fine. You do need to respin to fix what
Simon pointed out tho, either way.

