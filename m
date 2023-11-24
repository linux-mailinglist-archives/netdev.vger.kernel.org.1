Return-Path: <netdev+bounces-50924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFB67F785E
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 16:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A5C280ECA
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 15:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5C331758;
	Fri, 24 Nov 2023 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="in9l82si"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEB1199A
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 07:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lAI+7EHKYHKuVwTkv6fo2Kvjf0/1EEAjpcrDhu93+Uk=; b=in9l82siKyIgXjHeIZXghNwMFl
	xO6XHS9KPOnoN2gwL5benC9HIJv2D/KCMICBIQpi9iBY/+RAXcy/XnnrbMUZyhTsES8I+Gx746CHw
	Ce5PrlMLzff0mElZeeXYJkR5L7C5d4bR12Wzj04eYV82gCRjA85S5elhP7auUKVYa2/U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r6YVk-0016z1-Rd; Fri, 24 Nov 2023 16:54:32 +0100
Date: Fri, 24 Nov 2023 16:54:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Greg Ungerer <gerg@kernel.org>
Cc: rmk+kernel@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCHv2 1/2] net: dsa: mv88e6xxx: fix marvell 6350 switch
 probing
Message-ID: <2117b82b-d99e-4181-be80-cc2253c9eb95@lunn.ch>
References: <20231124041529.3450079-1-gerg@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124041529.3450079-1-gerg@kernel.org>

On Fri, Nov 24, 2023 at 02:15:28PM +1000, Greg Ungerer wrote:
> As of commit de5c9bf40c45 ("net: phylink: require supported_interfaces to
> be filled") Marvell 88e6350 switches fail to be probed:
> 
>     ...
>     mv88e6085 d0072004.mdio-mii:11: switch 0x3710 detected: Marvell 88E6350, revision 2
>     mv88e6085 d0072004.mdio-mii:11: phylink: error: empty supported_interfaces
>     error creating PHYLINK: -22
>     mv88e6085: probe of d0072004.mdio-mii:11 failed with error -22
>     ...
> 
> The problem stems from the use of mv88e6185_phylink_get_caps() to get
> the device capabilities. Create a new dedicated phylink_get_caps for the
> 6351 family (which the 6350 is one of) to properly support their set of
> capabilities.
> 
> According to chip.h the 6351 switch family includes the 6171, 6175, 6350
> and 6351 switches, so update each of these to use the correct
> phylink_get_caps.
> 
> Fixes: de5c9bf40c45 ("net: phylink: require supported_interfaces to be filled")
> Signed-off-by: Greg Ungerer <gerg@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

