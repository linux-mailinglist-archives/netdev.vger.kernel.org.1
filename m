Return-Path: <netdev+bounces-48104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97317EC878
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 17:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24113B209AA
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 16:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9215339FCE;
	Wed, 15 Nov 2023 16:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MXMBGjCf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5109F381C6
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 16:23:32 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726EF83
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 08:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VmFI+NPXIfTjAkwgRWJJKuIkNi2NJKHv5CFGxtrpQT0=; b=MXMBGjCfEIeHASt1vzLH40pAUf
	Q7bbESK9iLVK43c+GdsOk6Y649qqvESgamrP96cMGWvNcYghG3TAeUrQ9Df7BRLCj3nZrBDtuuShn
	Krd+7/JGefF8aiTH0dntcd4YY1QLqGfzt+ccFfH5N+QEskWyTBR4biAp7AdCdIWL2f4Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r3Ifn-000GMd-BA; Wed, 15 Nov 2023 17:23:27 +0100
Date: Wed, 15 Nov 2023 17:23:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/3] net: phylink: use linkmode_fill()
Message-ID: <9186dfe0-71c6-410b-b71e-dc3efd917d92@lunn.ch>
References: <ZVSt2e9Z5swJNf+7@shell.armlinux.org.uk>
 <E1r3EEt-00CfCC-Jx@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1r3EEt-00CfCC-Jx@rmk-PC.armlinux.org.uk>

On Wed, Nov 15, 2023 at 11:39:23AM +0000, Russell King (Oracle) wrote:
> Use linkmode_fill() rather than open coding the bitmap operation.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

