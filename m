Return-Path: <netdev+bounces-219768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0539B42E79
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 02:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5C0566D21
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 00:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C567214D2B7;
	Thu,  4 Sep 2025 00:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgdwO+8w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B1114A9B
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 00:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756947211; cv=none; b=BFSUcN6WRDPD1SfUIs00T7h7tLE9XYZwUmS7Gu2Xws4ybizzSnY+MPkY1oRvMhY5uFggS0/q6cuxzDwK75H65GKFlyNT4FHr31XYS9/skJ6NJn7ive5mQ1mvq5EL9gP7jLoeqfhTOtu6dsv8m0/nouV7LUYt5oISpXnuG8nc/b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756947211; c=relaxed/simple;
	bh=PRZRjRSX2JA9lvFNL/WZkeCUWyYQfQ1+r6Jp/WjO5pw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lxArfhULWDPa6KSRZYsFZht3yegf/lERvTXoB3n4uR3uV8K5rlM6ezF3cygTZzgjWFh6C/HVjKCtDuh2CfXALfB3EDjGIx90Ny/kAIHbx0Is+6JOnDo/RRgz1Ot8JpE0NsN2kdIMqa2+HNYMeZroK3v8SMX70X4NBXFUmg5qQEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgdwO+8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CDAC4CEE7;
	Thu,  4 Sep 2025 00:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756947211;
	bh=PRZRjRSX2JA9lvFNL/WZkeCUWyYQfQ1+r6Jp/WjO5pw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NgdwO+8wAFHW6LdO/eVyFoEDcchaE2YqsA5D3ztR5fafA1jCL3Sm2HpA+DttiBmGc
	 /ClJ8qp+GmwYYnTJU8T9YOjXhS90FeHJPWLUrw8FyTxBolt4XzJGSy8nL8t0W2PzgV
	 UcbGAKWYK2FD5eO7qPzQESFhUvGz/BcbTfUAHxbHjGOJZ7rhFG/TCfFiZtQemB8Qxc
	 WcZGqDmvoyw8Z0D3YBkpBRmlPmPZO4j/So44m5f9fmvANi4hxPhdvrXUGOY7PDZKlw
	 ImnIcmjuDEbWXJJgYaxxcGoPzh0qRUHNnMIRolv4044ETy6YaRJap3cAH9+do8qtX7
	 Nz0JutItWH87A==
Date: Wed, 3 Sep 2025 17:53:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next 01/11] net: stmmac: mdio: provide address
 register formatter
Message-ID: <20250903175330.6937a8a5@kernel.org>
In-Reply-To: <E1utmli-00000001s00-49Uk@rmk-PC.armlinux.org.uk>
References: <aLg24RZ6hodr711j@shell.armlinux.org.uk>
	<E1utmli-00000001s00-49Uk@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 03 Sep 2025 13:39:18 +0100 Russell King (Oracle) wrote:
> +/**
> + * stmmac_mdio_format_addr() - format the address register
> + * @priv: struct stmmac_priv pointer
> + * @pa: 5-bit MDIO package address
> + * @gr: 5-bit MDIO register address (C22) or MDIO device address (C45)

If you're willing to oblige kdoc it wants Return: to be documented.
Similar comment on patch 9 where stmmac_clk_csr_set() gains a return
value.

