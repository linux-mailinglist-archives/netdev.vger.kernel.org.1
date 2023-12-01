Return-Path: <netdev+bounces-53114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE51801632
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 23:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA07281E83
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 22:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8881619A3;
	Fri,  1 Dec 2023 22:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5S1EjNfA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F6794;
	Fri,  1 Dec 2023 14:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vfVmmsmmKXT0uItZ87WkQPPIdjFODnDFdDTSByaG0b4=; b=5S1EjNfA6vhRhkUsIkigM01q7W
	BhdJutwXJ3gdh3tnie3BufFf0X9y2EjlJluT0lsTSC7XmSfNxPBpapDokG9JpkVgorlQBNmvgTOhH
	wq9P4Pjj86Xe2Ujxg5gLytzIZyI9UMkgCNKEbvPoduPhhrhHEI24GsZy1XAdbOvyrnpk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r9BrD-001o1a-RG; Fri, 01 Dec 2023 23:19:35 +0100
Date: Fri, 1 Dec 2023 23:19:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiko Stuebner <heiko@sntech.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	quentin.schulz@theobroma-systems.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH 1/2] net: phy: micrel: use devm_clk_get_optional_enabled
 for the rmii-ref clock
Message-ID: <bfa25436-305e-4cdb-a6d0-55fcc45322f6@lunn.ch>
References: <20231201150131.326766-1-heiko@sntech.de>
 <20231201150131.326766-2-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201150131.326766-2-heiko@sntech.de>

On Fri, Dec 01, 2023 at 04:01:30PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> While the external clock input will most likely be enabled, it's not
> guaranteed and clk_get_rate in some suppliers will even just return
> valid results when the clock is running.
> 
> So use devm_clk_get_optional_enabled to retrieve and enable the clock
> in one go.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

