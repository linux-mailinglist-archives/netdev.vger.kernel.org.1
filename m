Return-Path: <netdev+bounces-51043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 851DD7F8CA1
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 18:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FDCE281299
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 17:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1248729439;
	Sat, 25 Nov 2023 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hrgI4r5W"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FD6E1
	for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 09:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QtmAy6WUaz7DD4FEsbMRJCi9BGO2jSEKtkIaW7hMEYU=; b=hrgI4r5WOxBztuCfHdG9LvabD4
	dBcE5tipPZzsrIt/g4ETWtL1AALA6sa2XxzxLdjEgX1bPSlKZ7zTvYmyUjtMF3ora6/1krnRvIBne
	VbPkiw8rlZXYQ0WxuWWRdqB6k3CGvFS0cPja0gaKIEwYtFWU/IADtc9cIYQzj0fXpDRc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r6wCc-001COS-1L; Sat, 25 Nov 2023 18:12:22 +0100
Date: Sat, 25 Nov 2023 18:12:22 +0100
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
Subject: Re: [PATCH net-next 06/10] net: phylink: split out per-interface
 validation
Message-ID: <61bf87ef-a2f3-4945-b0e6-6c13801beb80@lunn.ch>
References: <ZWCWn+uNkVLPaQhn@shell.armlinux.org.uk>
 <E1r6VIB-00DDLr-7g@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1r6VIB-00DDLr-7g@rmk-PC.armlinux.org.uk>

On Fri, Nov 24, 2023 at 12:28:19PM +0000, Russell King (Oracle) wrote:
> Split out the internals of phylink_validate_mask() to make the code
> easier to read.
> 
> Tested-by: Luo Jie <quic_luoj@quicinc.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

