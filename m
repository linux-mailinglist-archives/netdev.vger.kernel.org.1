Return-Path: <netdev+bounces-127518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44CD975A36
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130231C22D13
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 18:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913361B3F3D;
	Wed, 11 Sep 2024 18:20:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC63319EEC8
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 18:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726078851; cv=none; b=VtkxgvAAyWv+h+P7K7hbjGR6nr3wBcVPf6fTeaMFBE2PKYyQ50FT0mfrDdyCWKJkWOuZIVtLLNxqZHr7whrLkWmSlEDOiuKH4T0hCUGxZLptBmN8III3p6+kyMclhLgZao+/K9G1OL8bTCUX1tOPcdg0XmBJXxlRWjIxnOLc//8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726078851; c=relaxed/simple;
	bh=1H2EI+0GRLEB72QkBDvRPf0ONHR8qQk/RF3PuX0MaFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajkc4QPDnwvznP2IGwii16KMPYFQ2qUadYuoupjCwZV2+ZCX5DEKFjN+6cB1RGEyz10b6ceoKsOeRk827HUZTE0bQgoLORCVTn5H2C39U6HJabfyWiJC5uzj7pxoLlbdqDgbgwSsDnDanwCMmoJnbLl7kyOazQa4FprECG+DvBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1soRxB-0005lj-Ri; Wed, 11 Sep 2024 20:20:33 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1soRxA-007C5u-8v; Wed, 11 Sep 2024 20:20:32 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1soRxA-001z2E-0X;
	Wed, 11 Sep 2024 20:20:32 +0200
Date: Wed, 11 Sep 2024 20:20:32 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Chris Snook <chris.snook@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, kernel@collabora.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: ethernet: ag71xx: Remove dead code
Message-ID: <ZuHfcDLty0IULwdY@pengutronix.de>
References: <20240911135828.378317-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240911135828.378317-1-usama.anjum@collabora.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Sep 11, 2024 at 06:58:27PM +0500, Muhammad Usama Anjum wrote:
> The err variable isn't being used anywhere other than getting
> initialized to 0 and then it is being checked in if condition. The
> condition can never be true. Remove the err and deadcode.
> 
> Move the rx_dropped counter above when skb isn't found.
> 
> Fixes: d51b6ce441d3 ("net: ethernet: add ag71xx driver")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
 
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

