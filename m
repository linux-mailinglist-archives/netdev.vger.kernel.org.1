Return-Path: <netdev+bounces-54180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3B880631F
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 01:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EFCAB210B2
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 00:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFC8A3C;
	Wed,  6 Dec 2023 00:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sYYj1LXe"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B461A2;
	Tue,  5 Dec 2023 16:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZowHgJwHbLNG5um7ode501HNWFXI0JGKi/xZLjVzRjk=; b=sYYj1LXeyhNfrnBTuKq34KJWRh
	yzr/Xd/92Q0hojZYD+xj8Ut4AfIWBL59l5G9u0mqVTiRy+u1wtIUXb5jgmhgmo1+3umZUrK+gCMIs
	kB0hoWmBXoWiwWYKwN7fFbZJdNCIsK2AkWh2JHXCz7ScY9IE+wOle4XwOdARHbU7pG+0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rAfNX-0029lB-NZ; Wed, 06 Dec 2023 01:03:03 +0100
Date: Wed, 6 Dec 2023 01:03:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
	florian.fainelli@broadcom.com,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: phy: Only resume phy if it is suspended
Message-ID: <7e3208aa-3adf-47ec-9e95-3c88a121e8a3@lunn.ch>
References: <20231205234229.274601-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205234229.274601-1-justin.chen@broadcom.com>

On Tue, Dec 05, 2023 at 03:42:29PM -0800, Justin Chen wrote:
> Resuming the phy can take quite a bit of time. Lets only resume the
> phy if it is suspended.

Humm...

https://lore.kernel.org/netdev/6d45f4da-c45e-4d35-869f-85dd4ec37b31@lunn.ch/T/

If Broadcom PHYs are slow to resume, maybe you should solve this in
the broadcom resume handler, read the status from the hardware and
only do the resume if the hardware is suspended.

     Andrew

