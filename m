Return-Path: <netdev+bounces-44294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E367D773E
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3E4281D84
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 21:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DA537157;
	Wed, 25 Oct 2023 21:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhHLXM4c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD18522C;
	Wed, 25 Oct 2023 21:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EA9C433C8;
	Wed, 25 Oct 2023 21:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698271176;
	bh=FXh3Ybrebr/+Js1FhuGaszskuuHKYGlgnfDkMM4tAAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KhHLXM4cfTGTGeGv8+z8igpASojb9gPJgkmfMKtp47yAVdGZw17msJeGgO+gI5/4Q
	 4EmzQ55ic/XC+B/n/rb5p8oep/6uFopul3g9fgraBCeWg9AE9UkTEUnVyJ9DtuUP9q
	 1r3JkwBXgQ+tg/QW20O09brzuHKkg5QfeH9x3nNF/F4hQV+NuURuqE9/j5kLhBBYUE
	 Yu/ygR31OhHL/MRzVdpsXMdMBTI8t+h5IR2tcJzRjkdS9Wp8tURVRRpwPY2gO7wu7X
	 KkKOdi8HpeUDIpHxXXA7R0g0uzJzzi6ztvoBVK2it5EXbM3Ee5Hk8rgdpWysZW4kxK
	 D2m1tWZ2Odapw==
Date: Wed, 25 Oct 2023 14:59:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean
 <olteanv@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Arun Ramadoss
 <arun.ramadoss@microchip.com>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring
 <robh+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com, "Russell King
 (Oracle)" <linux@armlinux.org.uk>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v7 5/9] net: dsa: microchip: ksz9477: Add Wake
 on Magic Packet support
Message-ID: <20231025145934.22218b3e@kernel.org>
In-Reply-To: <20231023093343.2370248-6-o.rempel@pengutronix.de>
References: <20231023093343.2370248-1-o.rempel@pengutronix.de>
	<20231023093343.2370248-6-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Oct 2023 11:33:39 +0200 Oleksij Rempel wrote:
> +	struct net_device *slave = dsa_to_port(ds, port)->slave;
> +	const unsigned char *addr = slave->dev_addr;

Doesn't apply any more, after Florian's slave -> user rename.
Please rebase and s/slave/user/ as needed.

