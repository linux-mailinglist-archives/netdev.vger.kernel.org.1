Return-Path: <netdev+bounces-206355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 377C7B02BEC
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 18:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 845371694F8
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 16:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D867A283C93;
	Sat, 12 Jul 2025 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AxA+nFnG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F541AB6F1;
	Sat, 12 Jul 2025 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752337946; cv=none; b=ocw/4oUHh1l5kgIFErwE6klUvCBlQazm3XUrXz9JSfdjCHAsVdF1sFX+cMziTl7z5rzNkUCW7wlkKCel831ZT74ZMvDT1ibYwW8el2HsZjzvA8NhJTdZHv9LnBjU7omBYThpsmHmQqP/+j1Tg5yPaZS8GRbCRekfwwECtvky4R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752337946; c=relaxed/simple;
	bh=2OeTGhXF6BQGAi9CBq27Z9TE1vSK5cZSL2nTo/JBNTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbQhBmX5Rawg/kP6OnGq452TuMu1LZHKezQnI1xryEQwRF7QVLYmThxOlzxEXQ6IdCZxeGOA4swEA364MFDv0bXrkoRkjyYWsi+/BAttVOKxgQsvOMX2NE6gf415S9oo2NCeZRa5uCs3scoH7/NgnYXc+QAvQFPwk8OnuYsTpcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AxA+nFnG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1CWNvcxeqqvuIE8fZRowqcdIOV8TwkXNqais4wIPVO8=; b=AxA+nFnGJVYShl56Enz2ZS5ad6
	P3+xZgv9E/maYYztYjdf7EE8jgGoIGq5TUyZbJhz9UFJY5/gScIUwv65EAIvOhaYNdqtG604fQ6Ob
	xaRkLYEwr9AgcbE1iwUawSPlZ+oVK6p1hotzdJ2eA+E3fw2vUdI8hIbSkEXZyLfjCvA8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uad92-001Jjk-Ta; Sat, 12 Jul 2025 18:32:12 +0200
Date: Sat, 12 Jul 2025 18:32:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 net-next 3/3] net: fec: add fec_set_hw_mac_addr()
 helper function
Message-ID: <2eaa25f5-231a-4a94-badd-fbf90946adad@lunn.ch>
References: <20250711091639.1374411-1-wei.fang@nxp.com>
 <20250711091639.1374411-4-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711091639.1374411-4-wei.fang@nxp.com>

On Fri, Jul 11, 2025 at 05:16:39PM +0800, Wei Fang wrote:
> In the current driver, the MAC address is set in both fec_restart() and
> fec_set_mac_address(), so a generic helper function fec_set_hw_mac_addr()
> is added to set the hardware MAC address to make the code more compact.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

