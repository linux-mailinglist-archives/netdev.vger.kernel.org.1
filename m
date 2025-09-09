Return-Path: <netdev+bounces-221445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A93E2B50837
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5F71C630C8
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 21:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F432512F1;
	Tue,  9 Sep 2025 21:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3pLC60s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB0324EA9D;
	Tue,  9 Sep 2025 21:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757453579; cv=none; b=bverBrX9CxtVM1VcAUt9u7oPPsfXB0jcguokBwxOpDl4CJw3L9xWjcQTBdPA1I3JayvH5lArXhf2YpKdPNyyvKiCbWK3Pd3lQSYZTlA+3Jn6vTu2vNYfNo/AYyrlp7sDcT4Loq8J0di+EBl8GpXz002O5TrR22SeGsh/qbYQJwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757453579; c=relaxed/simple;
	bh=21lhlUmkr0Bx5L+PohyX4S47cPMRfDplBXFD4mWmKUg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=arPOBRaL3u+VxTsh1hU+jn0b9WuJ/GW7aaBCjVz9g688nlX2gdTWHnzobeIKJcOVXSQ7Fbs6I6TZAyv8FbodFf+GaYCl1zwqmNhf8lcmgOQeyAK1uc3lRfxHgn0zJi9gRD3HTltryPoig+YsVIk2wf65SVPv2iwf76mmLXAAgXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3pLC60s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF48C4CEF4;
	Tue,  9 Sep 2025 21:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757453578;
	bh=21lhlUmkr0Bx5L+PohyX4S47cPMRfDplBXFD4mWmKUg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O3pLC60sHOiSJDSsTP6Jk3penu5RDG/7ItDW3IJnEcmNBZ22S2ohf9XpJUlyw/NdN
	 sAMFPRMq2QxTTAeT/o3hcssH99xCT/LvQyBCjMLEtNexuIOaS/GqCTyMC8QMt8vTGm
	 Er27sYy+rKozyLd+PVos0IZutYXaRLi/pIJCXxtag5bKNs3wx/WrMS5p1L+uWfchRl
	 t4EXeNtwJL3n/ISoSU8mfbvjzm8U8Td8/5mTj2Ol+lrbz60jE3Hmy2yMzVb7Qv2hv4
	 VEPhsXKxkpd5+vJMih4TjrtEK8SCxbqnbgwNs0VHWtJMIVbXMdXJK6SQpirEPhW9hP
	 oWxceysH9RWVw==
Date: Tue, 9 Sep 2025 14:32:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Florian
 Fainelli <f.fainelli@gmail.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Lukasz Majewski <lukma@denx.de>, Jonathan Corbet <corbet@lwn.net>, Donald
 Hunter <donald.hunter@gmail.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Jiri Pirko <jiri@resnulli.us>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Russell King
 <linux@armlinux.org.uk>, Divya.Koppera@microchip.com, Sabrina Dubroca
 <sd@queasysnail.net>, Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v4 0/3] Documentation and ynl: add flow control
Message-ID: <20250909143256.24178247@kernel.org>
In-Reply-To: <20250909072212.3710365-1-o.rempel@pengutronix.de>
References: <20250909072212.3710365-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Sep 2025 09:22:09 +0200 Oleksij Rempel wrote:
> This series improves kernel documentation around Ethernet flow control
> and enhances the ynl tooling to generate kernel-doc comments for
> attribute enums.
> 
> Patch 1 extends the ynl generator to emit kdoc for enums based on YAML
> attribute documentation.
> Patch 2 regenerates all affected UAPI headers (dpll, ethtool, team,
> net_shaper, netdev, ovpn) so that attribute enums now carry kernel-doc.
> Patch 3 adds a new flow_control.rst document and annotates the ethtool
> pause/pause-stat YAML definitions, relying on the kdoc generation
> support from the earlier patches.

The reason we don't render the kdoc today is that I thought it's far
more useful to focus on the direct ReST generation. I think some of 
the docs are not rendered, and other may be garbled, but the main
structure of the documentation works quite well:

  https://docs.kernel.org/next/netlink/specs/dpll.html

Could you spell out the motivation for this change a little more?

