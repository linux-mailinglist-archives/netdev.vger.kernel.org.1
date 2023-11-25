Return-Path: <netdev+bounces-51041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B827F8C9F
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 18:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D0F1F20CD1
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 17:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE78229435;
	Sat, 25 Nov 2023 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6DkOk+fN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AF511F
	for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 09:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hzKQeKwuPN92ytxd9BiqytW2bvrpppvKaeKJ0swLypw=; b=6DkOk+fNuKZLwnOEwr1odOmQ7T
	K5jDvzLROGauIt+9Vq6KTn+KcuwpODuwQihJpx0bdrJ1sX7fDOfbW8tDy8w8S3gvHtoevUkEqO0BD
	THkFXBn9XCMVMU6KWRP/vSc30PQHB4/jCfga4U/OLwCETICGYrWLzaJ3pYP69ACkn1hw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r6wAZ-001CMh-Ex; Sat, 25 Nov 2023 18:10:15 +0100
Date: Sat, 25 Nov 2023 18:10:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 04/10] net: phy: bcm84881: fill in
 possible_interfaces
Message-ID: <c0fccaba-d5a8-4ad1-a435-e5109e45ed65@lunn.ch>
References: <ZWCWn+uNkVLPaQhn@shell.armlinux.org.uk>
 <E1r6VI0-00DDLf-Tb@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1r6VI0-00DDLf-Tb@rmk-PC.armlinux.org.uk>

On Fri, Nov 24, 2023 at 12:28:08PM +0000, Russell King (Oracle) wrote:
> Fill in the possible_interfaces member. This PHY driver only supports
> a single configuration found on SFPs.
> 
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

