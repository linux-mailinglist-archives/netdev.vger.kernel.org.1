Return-Path: <netdev+bounces-45139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C65A47DB184
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 00:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8ACA1C208D6
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 23:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089B214F9C;
	Sun, 29 Oct 2023 23:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="BfwlPqQh"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C1212E67
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 23:38:09 +0000 (UTC)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11A049E9
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 16:38:08 -0700 (PDT)
Received: from [192.168.68.112] (ppp118-210-136-142.adl-adc-lon-bras33.tpg.internode.on.net [118.210.136.142])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9FBA3200DB;
	Mon, 30 Oct 2023 07:38:03 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1698622686;
	bh=uQ79xB5YhPIfE2hH2dVbu1kiew+Mskxe69aNbKAuZDs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BfwlPqQhvvSmDnbsI8yNuvNGSKOYs/DpzKBGWuBC1Ov/aXafXZeNKTkUX1ehgr+SE
	 HYBSXqOu2ZkdPPt6/0Vp6CTTYcmTnzzQBegAxBlFDkCWve+HZnl5vcepGSdaIFJoHS
	 ZyfNoybdHx/x/HJIp/PJKr7bgunz/6fxk23VPNjuoA4Dvlzu/n6lpTOw9X5xRB0C14
	 2DzFFyXJrckSOSyewiBRqpqnSqGpgzCmSo3L/hGO4BqsUWtbJExLkGo0nPyr6fuBCC
	 iUNUs14pyWj+TZDcz2SNGxoZsY6Pm2Qm8Zv1MwgDIh5rl0cdQj0doqZU0U9/sIgoRR
	 JyGzf1ifclvAw==
Message-ID: <047262194fb29f08504c1d4a1d1b39b2e3ba2146.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 net-next 2/2] net: mdio: fill in missing
 MODULE_DESCRIPTION()s
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Andrew Lunn <andrew@lunn.ch>, netdev <netdev@vger.kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	 <rmk+kernel@armlinux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Joel Stanley <joel@jms.id.au>
Date: Mon, 30 Oct 2023 10:08:01 +1030
In-Reply-To: <20231028184458.99448-3-andrew@lunn.ch>
References: <20231028184458.99448-1-andrew@lunn.ch>
	 <20231028184458.99448-3-andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2023-10-28 at 20:44 +0200, Andrew Lunn wrote:
> W=3D1 builds now warn if a module is built without a
> MODULE_DESCRIPTION(). Fill them in based on the Kconfig text, or
> similar.
>=20
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/mdio/acpi_mdio.c    | 1 +
>  drivers/net/mdio/fwnode_mdio.c  | 1 +
>  drivers/net/mdio/mdio-aspeed.c  | 1 +

For the Aspeed change:

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>

