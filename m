Return-Path: <netdev+bounces-200930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5418EAE75D8
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 06:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883C5166EE2
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 04:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2C533086;
	Wed, 25 Jun 2025 04:30:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEB63D76
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 04:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750825840; cv=none; b=f5C89IN1AMh/weI+1biuzkCrX1oi6EeO4Cs99BEck9XZ/u8NFPhk80CSkrJN9cx/ztYF+J2BL8WiJ4YOw6jQifmBVVNLATWP7oBYJzZ6ZI4S7sZfT5+pudHNwWBirDUnw4Ymjb3DA2PSEogPY5J1nJR0un5C2L0Tn8Rb1uBvoxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750825840; c=relaxed/simple;
	bh=CDhdarVAzEtR0LH4qgY/QhcVx6vv9bKM4UUgxrfm+G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N95UHWRrHJJOQD3u5ciDqj26zg1pcPPs8p0lgNJ0R5e9kOHXPfEx1hq6R9J6qj6s0wUNEr4sjN72cc/LVdAqBDyWgC1J6wduSgSjCOlOiq6JjJrOZYDfcDoLsk2tsTGL9BlYus3stPByd/GqdIeujEUSSA+bYh7qoqFlTr9KpQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uUHmM-00016z-Dj; Wed, 25 Jun 2025 06:30:34 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uUHmK-005DsF-1v;
	Wed, 25 Jun 2025 06:30:32 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uUHmK-00H34n-1R;
	Wed, 25 Jun 2025 06:30:32 +0200
Date: Wed, 25 Jun 2025 06:30:32 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	gerhard@engleder-embedded.com
Subject: Re: [PATCH net] net: selftests: fix TCP packet checksum
Message-ID: <aFt7aJc6cU5vrOmi@pengutronix.de>
References: <20250624183258.3377740-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250624183258.3377740-1-kuba@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Jun 24, 2025 at 11:32:58AM -0700, Jakub Kicinski wrote:
> The length in the pseudo header should be the length of the L3 payload
> AKA the L4 header+payload. The selftest code builds the packet from
> the lower layers up, so all the headers are pushed already when it
> constructs L4. We need to subtract the lower layer headers from skb->len.
> 
> Fixes: 3e1e58d64c3d ("net: add generic selftest support")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reported-by: Oleksij Rempel <o.rempel@pengutronix.de>
Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

