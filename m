Return-Path: <netdev+bounces-78075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8B4873FF2
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 19:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB041C221E0
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 18:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB8C13E7C0;
	Wed,  6 Mar 2024 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="B9RG7Owk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD29313DBB1
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709750949; cv=none; b=hhtlVUOvdPTSgTwidQt/xFRPYxx5DENNZwHeAxr8w2a6BxyxwZ+SeDNplyhBVO/FaHonC7qBHSUrVDqmX/ZFJbbE/VeL9QRPhMjlzArcB61UJwjJtDcPywg2Q7whi51pU/Get+BCHDL+P/9RYiHi4HKIh+arYsy2YoLr+uSFRL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709750949; c=relaxed/simple;
	bh=UV36caWT8oWJKQYKKPWCaq3pKLuggmYqO302rllQNkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmAUY0tJFr+OmSj+NUYg+23AjZFclLSYoenUbU+hz4YVFXeXFNSwUQS+Gthvu2TfdIRcVT+jCqdEaNidhGay2FZZ0XUJc1c+JhWFcj7FHmphPWM6y3OuMIqGP/zthSjOCGu35Z5byQSkrBhsVUL4zzHd/FLVu+3R2nOBcREpJRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=B9RG7Owk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0Z7kG/yZn/pkG6Z6qasZ+1EfQ3M3k+t5eznRmbjHOc0=; b=B9RG7OwkHIAG+Zc15zqqs5g81e
	n11Fb4986gjhADZzcAsaAiD5L/8pKIpnM87DsG/XpIrkyq9KN4uNEpToj7ys/5qdZh1m07xT6B//v
	p94HslN6H311WqIzTVg1f6fDelp5jIcOaqD9eVokvItlzRwtBSOB4AR+alBgt8OduAAE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rhwKX-009WR8-5D; Wed, 06 Mar 2024 19:49:29 +0100
Date: Wed, 6 Mar 2024 19:49:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: marvell: add comment about
 m88e1111_config_init_1000basex()
Message-ID: <dbc1c53a-fc09-4e69-a907-6a6b497593c6@lunn.ch>
References: <E1rhos4-003yuQ-5p@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1rhos4-003yuQ-5p@rmk-PC.armlinux.org.uk>

On Wed, Mar 06, 2024 at 10:51:36AM +0000, Russell King (Oracle) wrote:
> The comment in m88e1111_config_init_1000basex() is wrong - it claims
> that Autoneg will be enabled, but this doesn't actually happen.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

