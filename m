Return-Path: <netdev+bounces-54525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEB9807619
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 18:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A01281D4A
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECB549F7D;
	Wed,  6 Dec 2023 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CXBtRYln"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86AED3;
	Wed,  6 Dec 2023 09:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lAZ9nI3AnS0SLIGSfNh7gWXoYcgJuboGn4WiQFw6uGE=; b=CXBtRYlnjFDan4M4CiH+JdrUwF
	SuzhFI6CVgSw9Vpb8N3OlHYsE+f4ma5r+c4UzgAc63SYsNdf4kIvPa5KhdGczLuk6b/KeR8Vh/krw
	xhg/cNMVBfv7coKiSmY+ZnyE+MW7HZ8k2a5UosVHIlbDt2r73GE9wiQ7zvQPb5sIpJXA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rAvOY-002ESH-JS; Wed, 06 Dec 2023 18:09:10 +0100
Date: Wed, 6 Dec 2023 18:09:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 02/12] net: phy: at803x: move disable WOL to
 specific at8031 probe
Message-ID: <3fc86d32-7faf-46d1-aff1-816f103acd5b@lunn.ch>
References: <20231201001423.20989-1-ansuelsmth@gmail.com>
 <20231201001423.20989-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201001423.20989-3-ansuelsmth@gmail.com>

On Fri, Dec 01, 2023 at 01:14:12AM +0100, Christian Marangi wrote:
> Move the WOL disable call to specific at8031 probe to make at803x_probe
> more generic and drop extra check for PHY ID.
> 
> Keep the same previous behaviour by first calling at803x_probe and then
> disabling WOL.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

