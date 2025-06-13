Return-Path: <netdev+bounces-197531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B20DAD90D3
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 17:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577853BB313
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 15:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0811E1E19;
	Fri, 13 Jun 2025 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KED7AWjr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA511ADC90
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749827351; cv=none; b=r3103uRgLEURtr/WCYUViqqNp3Pz12Jl04Hktdc8FI09i+4NnYIdCEEg4lHELcJyGne4okLoPBLfGtZrrJPbnjeDwJ1hVqv6D87Y0z61jzl9TRM9uCwKzfhznAoP4Bm8Bx0VxmdXKGEmnD+TqCDp7Ojdve1PHE6bqzo7mojkoMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749827351; c=relaxed/simple;
	bh=BdnvW0gWFk3+13trYxV+r06fL7hZnlA7tjtQNhQcTkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2iTul/pz3MIOs0Thls5xoJQzvQ6w/PR6wmR75XaxHNQJJc8WuQdKMWvIS9Y5E8mLzNDLhY3oRyU+Vr4fWJS4/UKbrglTVo3qBZtnKZrZd46sJhFGFW7Cc0GCKygUo8FzuPdT5QP4acXMeKwNSK/zueN4dfadfW1wveZFEYx/v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KED7AWjr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=j4ICKtMw+qQJxyXsWW5VvIUO6LjmIhKjhfDtJQSOE5E=; b=KED7AWjrvqVKPxjqaedrsao97F
	byz2nwkKU6KVfjOnOF16SAm+DtYTIK68+YGGhTbC3tFNFBsYlxsboUY6GmVRMwDHggPpUDiRFASQt
	65lItn6USFuUxysvzs8vG/r8BdHvdmvkSgACSXOQXaLN8rJQFxKEpCWIFVriuC70Y40Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uQ61d-00FjUX-CN; Fri, 13 Jun 2025 17:09:01 +0200
Date: Fri, 13 Jun 2025 17:09:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/4] net: phy: move definition of struct
 mdio_board_entry to mdio-boardinfo.c
Message-ID: <ff9fb98a-34b1-4cdd-a5d5-f31f91feb909@lunn.ch>
References: <6ae7bda0-c093-468a-8ac0-50a2afa73c45@gmail.com>
 <0afe52d0-6fe6-434a-9881-3979661ff7b0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0afe52d0-6fe6-434a-9881-3979661ff7b0@gmail.com>

On Wed, Jun 11, 2025 at 10:10:27PM +0200, Heiner Kallweit wrote:
> Struct mdio_board_entry isn't used outside mdio-boardinfo.c, so remove
> the definition from the header file.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

