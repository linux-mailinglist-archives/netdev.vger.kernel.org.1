Return-Path: <netdev+bounces-32140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A42579304B
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 22:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7018C281085
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 20:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9177ADF68;
	Tue,  5 Sep 2023 20:48:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11278DDD2
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 20:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37F3C433C8;
	Tue,  5 Sep 2023 20:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693946910;
	bh=/OBGVPSLoF4kXGH1AeHs0t7JFWo4oDqDHK3FiK3OxfY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pmtjt2Smg53XsBWTdFubwGFOewywLgUmOmzIFJIALjRU4fs6g+D+N+vUi95P2AaUP
	 jf2+K6+XR8yu+T3LrPUtRej7cn01+dlBtFqxdC6/FGYMbPSrGeQjmQPkqSDvzZ3QZ7
	 KRdAyVrW1TfUS4gCujAJdWi5bzrjOsIkVjn7He2QjTQw3lpttlbMUWnQRLkgYCPeXp
	 YFFpmOhMEhVhC3xnjfMjAk8WP8oprmL93kgRlZpCfNq6UBVJfRKAxahD0ZYAH7wX21
	 JHj7Dw5qOUHDqNHBVvpvKWYpOTHz7HXXGmtPMkAqzEWQ35bQ0MYhMW6z4yE1zKv3hd
	 PDDgd/tadjBYw==
Date: Tue, 5 Sep 2023 13:48:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>, Andrew
 Lunn <andrew@lunn.ch>, davem@davemloft.net, Woojung Huh
 <woojung.huh@microchip.com>, Vladimir Oltean <olteanv@gmail.com>, Oleksij
 Rempel <o.rempel@pengutronix.de>, Florian Fainelli <f.fainelli@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>, Michael
 Walle <michael@walle.cc>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 Arun Ramadoss <arun.ramadoss@microchip.com>, Oleksij Rempel
 <linux@rempel-privat.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [net v4] net: phy: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Message-ID: <20230905134828.74d37681@kernel.org>
In-Reply-To: <20230905093315.784052-1-lukma@denx.de>
References: <20230905093315.784052-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Sep 2023 11:33:15 +0200 Lukasz Majewski wrote:
> Fixes: 69d3b36ca045 ("net: dsa: microchip: enable EEE support") (for KSZ9477).
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

No need to repost for just this, but if there is a v5:
 - no empty line between Fixes and other tags
 - add the comment after '#' i.e.:

Fixes: 69d3b36ca045 ("net: dsa: microchip: enable EEE support") # for KSZ9477

