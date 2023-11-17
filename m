Return-Path: <netdev+bounces-48734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C137EF5E9
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D4D8B209C8
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C46632C88;
	Fri, 17 Nov 2023 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ilTve3hJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F248D7A;
	Fri, 17 Nov 2023 08:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oDai2uoUm5vGeh5ZPqmeEdbdW8V1DW0OcsGodmj2JN4=; b=ilTve3hJgBLOOHEHLwsdUxBU9m
	T1cjCITI+p46Ua07x8MkBdIff0FlO9gxDgGNZQTV7PBc4ZxjqlYXOsnf3viut+Ey4sMu/PjY/ZHad
	oqw/hQn4/d/ZPYjeGyk0Mky0SXq559m0dn/EVtKPhFD3IB0xmpP+D5rPMRnMDhEUXbS8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r41RB-000SG3-8k; Fri, 17 Nov 2023 17:11:21 +0100
Date: Fri, 17 Nov 2023 17:11:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vladimir.oltean@nxp.com, s-vadapalli@ti.com,
	r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com,
	u.kleine-koenig@pengutronix.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/4] net: ethernet: ti: am65-cpsw: Re-arrange
 functions to avoid forward declaration
Message-ID: <755fc764-0c68-4171-9af0-507f8bbe5357@lunn.ch>
References: <20231117121755.104547-1-rogerq@kernel.org>
 <20231117121755.104547-3-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117121755.104547-3-rogerq@kernel.org>

On Fri, Nov 17, 2023 at 02:17:53PM +0200, Roger Quadros wrote:
> Re-arrange am65_cpsw_nuss_rx_cleanup(), am65_cpsw_nuss_xmit_free() and
> am65_cpsw_nuss_tx_cleanup() to avoid forward declaration.
> 
> No functional change.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

