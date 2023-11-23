Return-Path: <netdev+bounces-50459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FA37F5DF2
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 12:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7689DB2129B
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 11:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018CF23744;
	Thu, 23 Nov 2023 11:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YvsepGXQ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DBABC;
	Thu, 23 Nov 2023 03:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bL/fDkgepQ3rA2OLcMw0FSWOiPAvM6tlj7ZYw7lcpMA=; b=YvsepGXQCUjYIefk0oMpzQcstk
	JATmsjldZ0/kjiPdy3itbVphmXqZJ4Q8NIO0EhF15ImVWftA3Lwp649DaRm7Eo6cV6bTmRlNAiKFW
	RC/NzIzfakGaM7Tvztg54eGqxpvJ7ryuW++kd9UvE+KD5ZVt61cOeqEtkWu9lBSJxHEctCFnHTvjM
	0rPArvIpcghx4iAPqjfowacpX+nJSEk/3GORG/Xz3m2C4AJQ32gwBzTvxqMk+brwopefG9NRlI/qj
	levhleXcb90VQH/P3bmYSaDzOZNgKCw9ZOvWhJwdjMpNh0RnQtJttDq01pc/5P9yhjnVdOGhN/XA1
	dACn3b1A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47110)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1r681p-0001Uf-37;
	Thu, 23 Nov 2023 11:37:54 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1r681q-0006Ao-9n; Thu, 23 Nov 2023 11:37:54 +0000
Date: Thu, 23 Nov 2023 11:37:54 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Simon Horman <simon.horman@corigine.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v6 1/3] net: dsa: microchip: ksz8: Make flow
 control, speed, and duplex on CPU port configurable
Message-ID: <ZV85kq+axQ7o0Jkc@shell.armlinux.org.uk>
References: <20231123112051.713142-1-o.rempel@pengutronix.de>
 <20231123112051.713142-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123112051.713142-2-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Nov 23, 2023 at 12:20:49PM +0100, Oleksij Rempel wrote:
> +	if (!duplex)
> +		ctrl |= SW_HALF_DUPLEX;

	if (duplex == DUPLEX_HALF)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

