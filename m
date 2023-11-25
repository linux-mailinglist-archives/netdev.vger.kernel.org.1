Return-Path: <netdev+bounces-51044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9CA7F8CA4
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 18:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B9A51C20B58
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 17:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FE029439;
	Sat, 25 Nov 2023 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ACEjkAog"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E55B6
	for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 09:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fSmfdtsTg0+qMplNWKu2haM6wH0Qz6DYZUBI174S1X4=; b=ACEjkAogfm0Tf8xYoART/M6+q4
	qeeWbQkHAvYskXIjbw6QvXbXbJ+13GGsJNooQLynvBrWyAfgDi8/9rD2jZk0IvylMOEvJiF4Km+jO
	Cb66Jdj/XRFn8Z/5lFaQcs1sgGAcnk255Tq+bcsvEUgEbG831I6oUXI5M5vMxcAOodFA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r6wDT-001CPH-T8; Sat, 25 Nov 2023 18:13:15 +0100
Date: Sat, 25 Nov 2023 18:13:15 +0100
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
Subject: Re: [PATCH net-next 07/10] net: phylink: pass PHY into
 phylink_validate_one()
Message-ID: <7699e304-6436-4782-b7d1-2617f3a4b42e@lunn.ch>
References: <ZWCWn+uNkVLPaQhn@shell.armlinux.org.uk>
 <E1r6VIG-00DDLx-Cb@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1r6VIG-00DDLx-Cb@rmk-PC.armlinux.org.uk>

On Fri, Nov 24, 2023 at 12:28:24PM +0000, Russell King (Oracle) wrote:
> Pass the phy (if any) into phylink_validate_one() so that we can
> validate each interface with its rate matching setting.
> 
> Tested-by: Luo Jie <quic_luoj@quicinc.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

