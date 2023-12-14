Return-Path: <netdev+bounces-57188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2B1812516
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCCAFB2119B
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628327F9;
	Thu, 14 Dec 2023 02:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlmDPF4H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455517EE
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 02:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6F8C433C8;
	Thu, 14 Dec 2023 02:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702519984;
	bh=dl6bXVaGaetNPS9qavZlOhXzgfopeDUt7Z61/X4VyoI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RlmDPF4HcFSOaulqr9YRAlXmJOHOUkkswDfB69BFAsHj1mvKwWsexJCcqxVnTGnRX
	 VyBaPY4qI1b43x63UTY365dISncZ5khk26S1E3hp7j5tSfBOddKT1QcyI47GQWimYW
	 4zB6NpZd0mSLuXJ4C2d0wObLVAyHZ+Bsc5DNIOMa+e5uqXeyi9394zmtYnY/MV9//j
	 /MkBKi+r5Dj+TDVxjnH8g9SUjiv7WmakCvCWT1ms3fQgDwj8Ji3fN4/m77S9SPsPag
	 Pvkv8dmW9MMkXybAS9LeYMsFaoeExSRA96aslaxgfvUzMEORj6Pk7XFOv0vEOqyClT
	 TgqWUUWLk3ulA==
Date: Wed, 13 Dec 2023 18:13:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>, David Epping
 <david.epping@missinglinkelectronics.com>, Harini Katakam
 <harini.katakam@amd.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v6 3/3] net: phy: add support for PHY package
 MMD read/write
Message-ID: <20231213181303.34833b32@kernel.org>
In-Reply-To: <6579db46.5d0a0220.d624a.80b4@mx.google.com>
References: <20231213105730.1731-1-ansuelsmth@gmail.com>
	<20231213105730.1731-3-ansuelsmth@gmail.com>
	<ZXnSB4YsuWZ0vdj2@shell.armlinux.org.uk>
	<6579d3df.050a0220.41f9b.a309@mx.google.com>
	<ZXnYKLOeStCuVXY7@shell.armlinux.org.uk>
	<6579db46.5d0a0220.d624a.80b4@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Dec 2023 17:26:43 +0100 Christian Marangi wrote:
> I tend to use cover letters only for big series, sorry for not being
> very clear about this.

FWIW in netdev the rule of thumb is "if there's more than 2 patches,
there's probably extra context". Even the 2 patch exception for cover
letters is mostly for when people post code + test, as two separate
patches. Cover letter stating that you have a series for xyz
pending, which will need this, seems like a straightforward ask..

