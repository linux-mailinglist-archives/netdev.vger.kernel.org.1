Return-Path: <netdev+bounces-204730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9607EAFBE9F
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 01:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8CC42233D
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 23:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE3B1E832E;
	Mon,  7 Jul 2025 23:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/apHQql"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728C91898F8;
	Mon,  7 Jul 2025 23:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751931141; cv=none; b=bAqukjpS7i412Qoys/kETjoPF5rRd/C9bp2U6Hm1OmdqJBuh5dMcPykuoYJbgBGCbhthwgbiFqVIslA6B+I0wbYclyDHLfVWENUMmx8WGK1FJZq6Gh0QyZwnfj5ZT4Kun3MoIknAKHYHGnWY6uzNV+jkEhv/ifx1GMfAHdFDArM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751931141; c=relaxed/simple;
	bh=U97JriCOyEIK9HD84xI6GbkYDX4CMEd6VnA4JNnzx+4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mo8ehIum6xSRrnoy03vaPnucPLhIuzR/Wu7v/YoI2os9wTIVDTqUR5WUX3KDrznVl+JY/ZVKg12DydTnlsKCLfcqu1Tkoqe33d4CAd4OIbIG47w9+MHjQJK7BwSqjrxn/yJEsjIgDWArbHwUUukbxjIkYbSFQ6TmzGmW2QAoV7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/apHQql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5181C4CEE3;
	Mon,  7 Jul 2025 23:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751931141;
	bh=U97JriCOyEIK9HD84xI6GbkYDX4CMEd6VnA4JNnzx+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X/apHQqlbXy7p2Zvh3/+8SEsydUPVimg4Nz2cU4+KBh3L2FYfBDnL4OcJBtmROZhr
	 1rFCqs0vPjN2pPuH8k8n6LlZ6N3LvTpHF6ILVp38HpSM1KJInccg0csg/GEY+sF1fM
	 +pHZ/SonCkf1WuhKlbVFv8GTeJaxrpDvoyKUqR9tvsv1FnPhTCpky47WpPs0JQuAik
	 2kvKFQ+6wi1nqG6H9uf+8UdmgAP1QIa1WNdRgDFcjE8Sq8Xjp0ctgtkR/BXbmYIwFk
	 ydCNbSkFnazLnBXXfl/Zc7MLEFVzRLg5mI/Adjw/8cEWghxfVK0BWmhmJgvq+QXl/m
	 kA+JXIUzhXrkg==
Date: Mon, 7 Jul 2025 16:32:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Florian Fainelli <f.fainelli@gmail.com>, Eric
 Dumazet <edumazet@google.com>, Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH net] net: phy: Don't register LEDs for genphy
Message-ID: <20250707163219.64c99f4d@kernel.org>
In-Reply-To: <20250707195803.666097-1-sean.anderson@linux.dev>
References: <20250707195803.666097-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon,  7 Jul 2025 15:58:03 -0400 Sean Anderson wrote:
> -	if (IS_ENABLED(CONFIG_PHYLIB_LEDS))
> +	if (IS_ENABLED(CONFIG_PHYLIB_LEDS) && !phy_driver_is_genphy(phydev) &&
> +	    !phy_driver_is_genphy_10g(phydev))

Breaks build for smaller configs:

drivers/net/phy/phy_device.c: In function =E2=80=98phy_probe=E2=80=99:
drivers/net/phy/phy_device.c:3506:14: error: implicit declaration of functi=
on =E2=80=98phy_driver_is_genphy_10g=E2=80=99; did you mean =E2=80=98phy_dr=
iver_is_genphy=E2=80=99? [-Werror=3Dimplicit-function-declaration]
 3506 |             !phy_driver_is_genphy_10g(phydev))
      |              ^~~~~~~~~~~~~~~~~~~~~~~~
      |              phy_driver_is_genphy
--=20
pw-bot: cr

