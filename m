Return-Path: <netdev+bounces-57106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EF781220B
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 960661C210E8
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 22:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A421681854;
	Wed, 13 Dec 2023 22:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ymmFUvjZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3395DCF
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 14:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EUgE5DLNIHiHDAd1jHooBex6WZ+a+tKC674WRCyoFi4=; b=ymmFUvjZa1sYWhsfk17B+hTTkN
	77Ycdcfq4HX3jY+8UuIJmncXDXhGMJ7bn7xBZMb8w2pi4p6QsbBYlRKcPkvzBB4PJNTwGZMrSXkBb
	eMjEFts5f5ITlHJpc16k4Dseg6Vvz92wzr3s4OT9N31+7//O3m7Djlc0r/GL/cqwaDSc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rDY2x-002rlq-FE; Wed, 13 Dec 2023 23:49:43 +0100
Date: Wed, 13 Dec 2023 23:49:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next 2/2] net: mdio-mux: be compatible with parent
 buses which only support C45
Message-ID: <28eac550-e48c-401d-a111-05c6b4c9e4c0@lunn.ch>
References: <20231213152712.320842-1-vladimir.oltean@nxp.com>
 <20231213152712.320842-3-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213152712.320842-3-vladimir.oltean@nxp.com>

On Wed, Dec 13, 2023 at 05:27:12PM +0200, Vladimir Oltean wrote:
> After the mii_bus API conversion to a split read() / read_c45(), there
> might be MDIO parent buses which only populate the read_c45() and
> write_c45() function pointers but not the C22 variants.
> 
> We haven't seen these in the wild paired with MDIO multiplexers, but
> Andrew points out we should treat the corner case.
> 
> Link: https://lore.kernel.org/netdev/4ccd7dc9-b611-48aa-865f-68d3a1327ce8@lunn.ch/
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

