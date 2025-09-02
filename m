Return-Path: <netdev+bounces-219326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1126B40F9F
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65CBF1B62496
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 21:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93BA334716;
	Tue,  2 Sep 2025 21:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qhNg+vWr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DA71E51D
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 21:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756849879; cv=none; b=pHwXpTOKlgV98vBF5W3Do+BWbY5AzSVkqJnK4qb8LyFr3TErufiBHlJjm32/1mJdIC47FGoOp9Hur9jvdCFkrOcE8GPSYPcM+QliTNELWMunE/Bbe878BY+KrGRSKGpyeO5iZXxMyCrBmhcwGm38Jk4+V8MnU+KRvyUdKYGw10A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756849879; c=relaxed/simple;
	bh=BLs6fa6QwJZy0SpnW2oD062jzcHB7ihzGagWwQka0qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHL9wnQk00ervk30+DEmP0nXELlcQCk56KtDKi7PG7r+WVFx78EHKEJon2HXhBIFha7B7OFqrmoIcYgHET1hVr8hYgSbMgfOko9Y/9qLcFgotp7zIPtTl0abr+cIzWQJxz4BP1JXOjJI9/LZxZUZZ/n43FZQ6nO6RPBmJVSFEdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qhNg+vWr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1Y+XzpUmDAYvYIBvIs8sE+o6JrB7umn+Tcm6jtqGLX4=; b=qhNg+vWrulgoJZ5Ldq4zH17owi
	yXQrLFFW/AzBjB+TDPwACEPfWhG8EucGEiXGTkOfywjDBGm7xclI8Lsl81fFWcjl70QSxIcLZ4Hzd
	IrgKMpYdg70Flss9mIjVJts3MwQ1Ltq7EezTj5YQu1iJ2bd/6kMkwjhS1k/l52vx4sDQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1utYu9-006wB3-KK; Tue, 02 Sep 2025 23:51:05 +0200
Date: Tue, 2 Sep 2025 23:51:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Mathew McBride <matt@traverse.com.au>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net 1/3] net: phy: add phy_interface_weight()
Message-ID: <501b88e3-ff34-4bb4-b499-37f635e1b894@lunn.ch>
References: <aLSHmddAqiCISeK3@shell.armlinux.org.uk>
 <E1uslwn-00000001SOx-0a7H@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uslwn-00000001SOx-0a7H@rmk-PC.armlinux.org.uk>

On Sun, Aug 31, 2025 at 06:34:33PM +0100, Russell King (Oracle) wrote:
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

