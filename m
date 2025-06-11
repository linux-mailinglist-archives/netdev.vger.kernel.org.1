Return-Path: <netdev+bounces-196683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA21AD5E12
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 20:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7C361793B3
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 18:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667A2221567;
	Wed, 11 Jun 2025 18:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lsaceU4x"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D05B20C494;
	Wed, 11 Jun 2025 18:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749666371; cv=none; b=c+Th9Ui9vSOp0OuUDLJMZ3j6Chs3OLRXWxNWoWpVUjDOGZlhYQjiul5DBQuKaw8OLt4/R92rL6RUf5O5zDUwNiMJV5Zc2Yr+c1udxf+kqL8M111Y6My5u2rJQlR4Av6IQirybxwYgXYxPn6r7v3kK0rPBsttHkcE4tXKMuUFkz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749666371; c=relaxed/simple;
	bh=X5nIp4Du5EP+28y6NroWhGcnMI/IpDxiHC8/nV44wFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1WzDW3YShr9BE8QhF7mDCqQfB7YN6ZfrlyokvpNRimzK9xEeOUUNE74x6DCx3knzTSSlEVOJoOOd7Yfc3bXK0Obm/4/GKdlTFBBFezg4x97wp4B4bXeuHE/cE7XwujkNSHPCRhq9idixuzcDFaGYB1qov8xt41Ry9jfLT63W20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lsaceU4x; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=neALwql1yvZkvXtKYl9+4IX5+TOVPty8265XtgK9DCw=; b=lsaceU4xlstsL7AtpYN5CkMT86
	sxKOK799kjkTYpoUyxccLNHkRFTk+Gpr+7g3SOWJSAYAioCvFwfOjsgdGpJn9gFkvYudJldxKqZF2
	NtN59+GseynlQjVo7G1TYNlZ40eQNl6ViPIpgPZV90amvqg9sh1CW0HCuBgKvDKo7sDk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uPQ96-00FR5L-Am; Wed, 11 Jun 2025 20:25:56 +0200
Date: Wed, 11 Jun 2025 20:25:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Lechner <dlechner@baylibre.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RESEND] net: mdio: mux-gpio: use
 gpiod_multi_set_value_cansleep
Message-ID: <d4899393-f465-4139-ac3d-8e652c4dd1dc@lunn.ch>
References: <20250611-net-mdio-mux-gpio-use-gpiod_multi_set_value_cansleep-v1-1-6eb5281f1b41@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-net-mdio-mux-gpio-use-gpiod_multi_set_value_cansleep-v1-1-6eb5281f1b41@baylibre.com>

On Wed, Jun 11, 2025 at 01:11:36PM -0500, David Lechner wrote:
> Reduce verbosity by using gpiod_multi_set_value_cansleep() instead of
> gpiod_set_array_value_cansleep().
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> This is a resend of a patch from the series "[PATCH v3 00/15] gpiolib:
> add gpiod_multi_set_value_cansleep" [1].
> 
> This patch never got acked so didn't go picked up with the rest of that
> series. The dependency has been in mainline since v6.15-rc1 so this
> patch can now be applied independently.

It is not surprising it did not get picked up when it is mixed in with
a lot of other subsystems. Please always post a patchset per
subsystem.

This also appears to be version 4.

Since you did not annotate the Subject: line with the tree this is
for, i'm not sure the CI system will accept it an run the tests.

https://patchwork.kernel.org/project/netdevbpf/patch/20250611-net-mdio-mux-gpio-use-gpiod_multi_set_value_cansleep-v1-1-6eb5281f1b41@baylibre.com/

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

	Andrew

