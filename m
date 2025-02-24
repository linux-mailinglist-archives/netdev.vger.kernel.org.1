Return-Path: <netdev+bounces-169028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EE7A42263
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 15:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70CBC3BD3CF
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 13:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16380259499;
	Mon, 24 Feb 2025 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="o1k1I8O8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8425B25744A;
	Mon, 24 Feb 2025 13:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405225; cv=none; b=DaP+XSH2FtVTLaHQAKjHmtYvvH1eeQiINIfcWaPEktYTWeRtWYW4Hejx0DheH9TsymYtcico1S/EjkxdXDeYM+OheySOjhw94SZbPcNXuYCITeZifXNEXOEQISfob9bAeBcsXUDo3FjgMYvBFo8EKt00w/R0QEiHlyky6DYDYqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405225; c=relaxed/simple;
	bh=+0fVRFojAPaGCk0kjhWR6deAUNC6V61mrO7QnJO5Gec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeUmhAlaMyrH6eoH6Q3WzDcqUQ227P8yVaOo1S/O6/yT9A5UAZVGbLkhrGZxaJw1vHcUMK7ay130fRNnhgBV4OHrz9cRcssVGYK5UbUtxW+EfADbTtycXkqiY9G+MV3ctPZ5vBUi0IAftJ0p64b23Eo7cog6+rIPW4CApatmHUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=o1k1I8O8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kmukkXqExqlfdB9kboV9/OW7eMvGP0k7DUtnzMx2NWI=; b=o1k1I8O8vos488sLu1Z1Xz7Aya
	bbsLP3VWce1GaquLcOsAZqj/NenU3zopHgdEzZjx+s7x/tHQP19WkdDPyt4Jubfa0G3/uKbnrr8/F
	Pfabdj3Sr0ulTaYOW/Kd6ezpKjIZ/5kxqhFWp7NpMpoU41E5etSPRB98ELmkQzu1Y4Xs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tmYtk-00HAy6-EH; Mon, 24 Feb 2025 14:53:28 +0100
Date: Mon, 24 Feb 2025 14:53:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: lxu@maxlinear.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH net-next 2/2] net: phy: mxl-gpy: add LED dimming support
Message-ID: <ce7d9ef9-e788-4e36-84ec-ef8b858c1050@lunn.ch>
References: <20250222183814.3315-1-olek2@wp.pl>
 <20250222183814.3315-2-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222183814.3315-2-olek2@wp.pl>

On Sat, Feb 22, 2025 at 07:38:14PM +0100, Aleksander Jan Bajkowski wrote:
> Some PHYs support LED dimming. The use case is a router that dims LEDs
> at night. In the GPY2xx series, the PWM control register is common to
> all LEDs. To avoid confusing users, only the first LED used has
> brightness control enabled.

Please Cc: the LED mailing list, and Lee Jones.

I've no idea myself what is the normal way to represent a single
brightness control shared by a number of LEDs. I would like to ensure
whatever we do with PHYs is the same as what other LEDs do. I had a
quick look at leds-class.rst, but i did not see anything there.

    Andrew

---
pw-bot: cr

