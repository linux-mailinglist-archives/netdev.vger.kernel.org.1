Return-Path: <netdev+bounces-123584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F749965697
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 06:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3FA1F242EC
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 04:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCF4136327;
	Fri, 30 Aug 2024 04:55:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A57142624
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 04:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724993710; cv=none; b=U6nVOzFuP0l852nOO6pGmkJsd2hDcHx+moE0rc7CWI0X51GHOCDqNDxwUenfJA88N8Vb6rb6VQncgpZ9fJRmnxOjqO9K/Mnau36xn5pKGr6CcQXwjSAI9omihFWGlYy4jH/21WjqWIsB+5HijlXvggnW6tPYUcg8VthOhtkM9xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724993710; c=relaxed/simple;
	bh=4ebZuVSVPECGZb7x2I4i77gmMDYt9jsjdzMTsqir6vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvDAQTdOx+fYurIkXXNub+ixwuqPsXDb4b7gobv508za5MOwXexwkY3664sHHGB7gc5/7TPnWZ+ohwEHWtxyncrEdn+/nxVHVdsyN0Baa6Z3GmsgtGgo6ReBucY2y7wHtFjjmQlI7d6FsN1FR0BcMl1svqRiWwVulLrGKS6U/bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sjtek-0007qo-Ii; Fri, 30 Aug 2024 06:54:42 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sjtei-0044W3-WF; Fri, 30 Aug 2024 06:54:41 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sjtei-00EP15-2r;
	Fri, 30 Aug 2024 06:54:40 +0200
Date: Fri, 30 Aug 2024 06:54:40 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
Subject: Re: [PATCH net-next 2/6] net: ag71xx: update FIFO bits and
 descriptions
Message-ID: <ZtFQkM2vsg6-z-ML@pengutronix.de>
References: <20240829214838.2235031-1-rosenp@gmail.com>
 <20240829214838.2235031-3-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240829214838.2235031-3-rosenp@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Aug 29, 2024 at 02:48:21PM -0700, Rosen Penev wrote:
> Taken from QCA SDK. No functional difference as same bits get applied.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

This values can be confirmed by AR9341 documentation
8.19.20 ETH Configuration 4
8.19.21 ETH Configuration 5

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

