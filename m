Return-Path: <netdev+bounces-48103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02D67EC875
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 17:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1041C20915
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 16:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF8439FC5;
	Wed, 15 Nov 2023 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FZIj1HCp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC48381C6
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 16:23:22 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D743583
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 08:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XAMWbdkEQoX8FZNHtfqr576oxZo45yiB/LsvDRnsnek=; b=FZIj1HCp/uiYyI8WE8fVgPu/nI
	V3O8tiQTV7Mi9GORvuOXOlES5mXrJ1WzPqStxbecGPbG1gDPMmhWH+bApxFTA7vXoPfDmSL9QRkaB
	N014Y/NbohKJTqNuCyrn/q5gSIv5w8cKCxRtgD3udjqTtJ4K4xtjFUZnuhPXrYGAqPYs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r3Ifd-000GMF-6s; Wed, 15 Nov 2023 17:23:17 +0100
Date: Wed, 15 Nov 2023 17:23:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/3] net: linkmode: add linkmode_fill() helper
Message-ID: <2bc9b6ec-6830-4c6a-894c-597f52f664b9@lunn.ch>
References: <ZVSt2e9Z5swJNf+7@shell.armlinux.org.uk>
 <E1r3EEo-00CfC6-Ez@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1r3EEo-00CfC6-Ez@rmk-PC.armlinux.org.uk>

On Wed, Nov 15, 2023 at 11:39:18AM +0000, Russell King (Oracle) wrote:
> Add a linkmode_fill() helper, which will allow us to convert phylink's
> open coded bitmap_fill() operations.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

