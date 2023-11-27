Return-Path: <netdev+bounces-51346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A95E87FA427
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 16:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 638962817B3
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 15:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2C731A73;
	Mon, 27 Nov 2023 15:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DrZZL3v/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D7DE4;
	Mon, 27 Nov 2023 07:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CMxAbeP9zP9Pf1RjhRBAQNd8InGAbFxmlxKVc+wxsAM=; b=DrZZL3v/zZcNYXD0zQKz85lPF7
	jvZmd+ICIL0GduqeXveIgY9DgUNRZpjDB7+7fIatZm1fztwQ7WJzNTh+isMzZho3R+PX+6Sn/dHus
	8wfjf/snVyKSwskWtWqD+rdRKf4QfHmX+jNXFXPuBHN2X4WtuL8FRvca6jNDdcoMNlEwUxI9RfBoI
	AN4W7kcyvIhPZjP4KRMeIsK/H1LForVuJdo+jSQGHk1HKGfyhjPM1jWxNbxJBHc4fUqZqwFpLNMHe
	LUN2GInjfipAaNxBtXBCxEy6UDabIVBHv9GZEjWg69QyNqCAppiWktzLClpvDKFJKVAeEuKqVjqDY
	quaJZGhw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54294)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1r7dFp-000621-2I;
	Mon, 27 Nov 2023 15:10:33 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1r7dFr-00020n-Mz; Mon, 27 Nov 2023 15:10:35 +0000
Date: Mon, 27 Nov 2023 15:10:35 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v7 0/3] Fine-Tune Flow Control and Speed
 Configurations in Microchip KSZ8xxx DSA Driver
Message-ID: <ZWSxa4cgh/eMLCQA@shell.armlinux.org.uk>
References: <20231127145101.3039399-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127145101.3039399-1-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Nov 27, 2023 at 03:50:58PM +0100, Oleksij Rempel wrote:
> changes v7:
> - make pause configuration depend on MLO_PAUSE_AN
> - use duplex == DUPLEX_HALF

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks for addressing my feedback!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

