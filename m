Return-Path: <netdev+bounces-48105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F5E7EC879
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 17:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 220731F27C6C
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 16:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2BA39FE2;
	Wed, 15 Nov 2023 16:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bBv6xZiF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16008381C6
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 16:23:47 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4103DAB
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 08:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=H3l8DMFZ7oZLbhBLIoZ0A6PKwkJvwkOe29U6Tdywbi0=; b=bBv6xZiFqBwjSZY7c9D9xgk+Mc
	rxC7k/h88U+UNLLu/eSpXIToLtzfYYYuJFqwhjmdYRFbVAZAmHiK7DAqIZ+c1/PvNPfcoJqENTTEZ
	2Tk4qelE5qr1Rmc2Co85MztE1RKg/g+vZ6pKrgI2uRThIteySy7+bNZbOYPXUUjcwQoA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r3Ig2-000GNP-2z; Wed, 15 Nov 2023 17:23:42 +0100
Date: Wed, 15 Nov 2023 17:23:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/3] net: sfp: use linkmode_*() rather than open
 coding
Message-ID: <2c9afe09-59a2-4c81-8897-71ee9fb57b69@lunn.ch>
References: <ZVSt2e9Z5swJNf+7@shell.armlinux.org.uk>
 <E1r3EEy-00CfCI-O7@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1r3EEy-00CfCI-O7@rmk-PC.armlinux.org.uk>

On Wed, Nov 15, 2023 at 11:39:28AM +0000, Russell King (Oracle) wrote:
> Use the linkmode_*() helpers rather than open coding the calls to the
> bitmap operators.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

