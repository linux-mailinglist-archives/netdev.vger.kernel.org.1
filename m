Return-Path: <netdev+bounces-51135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4107F94CB
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 19:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E0CB28102E
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 18:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1036FC0D;
	Sun, 26 Nov 2023 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WpYks8pH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C3EF7;
	Sun, 26 Nov 2023 10:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NDXLFxpUsTuPhTjVM1aK4p4em/oxzx34dIvrIxa7By0=; b=WpYks8pHGWIk3goxh312e99NVt
	6NXlIT7FPT+EYS7EpPG1MAs73JgBWoIFmRuJcvswZDiMXeiFGFfYF6OkudHyjHX+sh05UAsyJ8use
	AkBWb60peZxJIbrmxZzVaylAfBSdfmxMuUKQCnOyEvPWJ70ZHqOAsfWVEJT43fnFibmE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r7Jee-001GPj-98; Sun, 26 Nov 2023 19:14:52 +0100
Date: Sun, 26 Nov 2023 19:14:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	David Epping <david.epping@missinglinkelectronics.com>,
	Harini Katakam <harini.katakam@amd.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 3/3] net: phy: add support for PHY package MMD
 read/write
Message-ID: <4166bb2a-66ef-4757-b05b-7d5d7a415c67@lunn.ch>
References: <20231126003748.9600-1-ansuelsmth@gmail.com>
 <20231126003748.9600-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126003748.9600-3-ansuelsmth@gmail.com>

On Sun, Nov 26, 2023 at 01:37:48AM +0100, Christian Marangi wrote:
> Some PHY in PHY package may require to read/write MMD regs to correctly
> configure the PHY package.
> 
> Add support for these additional required function in both lock and no
> lock variant.

You are assuming the PHY only supports C45 over C22. But what about
those PHYs which have native C45? And maybe don't have C22 at all?

You should refactor the code of __phy_read_mmd() into a helper and use
it here.

   Andrew

