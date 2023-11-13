Return-Path: <netdev+bounces-47366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E66547E9D1D
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 14:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D28280CCF
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 13:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7F4200CA;
	Mon, 13 Nov 2023 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="je3dHoCn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C94200BF
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 13:27:38 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C42D73;
	Mon, 13 Nov 2023 05:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=N5ifv1cr6Ysi7QPGqvW0ehIcDLlLuWs8Rj6Ky69UHAU=; b=je3dHoCn6b3t6S74Hk3VwSNVR2
	k7nLyA7xmawN/r1qIDf3laVJcPA3UIjfg4Mp0AevaMa4IHK7fCHkXUcdD+WTUIIwZp71PfyP490p7
	K/kpTT4A3qeUy1h5m9XSCSxs8c4iThbYuumVnYMYRqivxwX8XVkmsxfzJQVuEmeTEHgw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r2WyQ-00044h-6r; Mon, 13 Nov 2023 14:27:30 +0100
Date: Mon, 13 Nov 2023 14:27:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vladimir.oltean@nxp.com, s-vadapalli@ti.com,
	r-gunasekaran@ti.com, srk@ti.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: ethernet: am65-cpsw: Error out if
 Enable TX/RX channel fails
Message-ID: <5be409cd-8c72-4ca6-b6aa-ba588672b885@lunn.ch>
References: <20231113110708.137379-1-rogerq@kernel.org>
 <20231113110708.137379-4-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113110708.137379-4-rogerq@kernel.org>

On Mon, Nov 13, 2023 at 01:07:08PM +0200, Roger Quadros wrote:
> k3_udma_glue_enable_rx/tx_chn returns error code on failure.
> Bail out on error while enabling TX/RX channel.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

