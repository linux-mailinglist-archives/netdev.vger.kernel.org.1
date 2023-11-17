Return-Path: <netdev+bounces-48735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D12787EF5F9
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7831F225B1
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F8D30657;
	Fri, 17 Nov 2023 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kSln5Bis"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E48D79
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 08:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kKD4kHraV6mshodE4RrGR89HkHqanKLrQHohK5xJ4Co=; b=kSln5BisI4XcYechxMiSZlABnf
	GBfnAc7W3ibHSU4FMb8LuAO8YyA340Mti5hEps5f71ZNbnMt35t4duvscsR5Abk1t/YSfihnbKPhN
	588BHl+G4tehYGepKKFBKLi1z5OZ+HKqWx2xfYzmJOMEwIQouEpSc+MxdeIVEVybEp/M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r41Uz-000SIq-Ep; Fri, 17 Nov 2023 17:15:17 +0100
Date: Fri, 17 Nov 2023 17:15:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: phylink: use for_each_set_bit()
Message-ID: <84b4b1b4-83e7-477b-9316-21c7a76689aa@lunn.ch>
References: <E1r3yPo-00CnKQ-JG@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1r3yPo-00CnKQ-JG@rmk-PC.armlinux.org.uk>

> +		t = *state;
> +		t.interface = interface;
> +		if (!phylink_validate_mac_and_pcs(pl, s, &t)) {
> +			linkmode_or(all_s, all_s, s);
> +			linkmode_or(all_adv, all_adv, t.advertising);
>  		}
>  	}
>  
> +
>  	linkmode_copy(supported, all_s);

Adding another blank line here was probably unintentional?

Otherwise:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

