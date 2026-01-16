Return-Path: <netdev+bounces-250594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C88D38406
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 19:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D1463042808
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 18:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63C7338902;
	Fri, 16 Jan 2026 18:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zd0LYlgD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BE228135D
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 18:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768587058; cv=none; b=lnZ7KSeVV9A2swUdHldWPJo91n/txPH3Scm3BZF04qGROPnVqYWI8YwRaC/H2l92xypvvfz0TND20j+Ubr2PSs7Q8rSC6vwyMg0V+Hf5eKh/t1oL47+HtOUlCEDuP3S2zK4avSTTRgV5l6PP+yU9zk8OeOtNMiLaFACxbO5tK5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768587058; c=relaxed/simple;
	bh=n3THFwvtUR9pSC8IDO9AttXXT/OeL9IxiR82cObeKw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxF205J1xzcr42FDLVXsLlosCnpQ5Y4FRWye/9GNAkFxGsq9LapatFrOY66JMIxdSdDZ9Z6JSmgyswbuy9WFftRKmbFrNJ4/9q0D6/3Pj/yrRW3xnRWgVyKf6ZuKMMsxzbn/gv0TVPJl44p+3VYHGHdw2WjzyB5vIEYbPhK1Jhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zd0LYlgD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uF0LM1glmVMNdJs2O752P8TOFbY379fHdS5sSUyEfQU=; b=zd0LYlgD2qrp2YgW4uiNvrjIqy
	8Q8RFGRb/M8ewKpI60zBr0zhodM7YHmINCDcAm94yO8UU2FcSlyEwvsfeIGgog2rukobfoKidsuUl
	61+r2vq6TZiU3HsFeDLXzXunxvQMkheNyUtGIYTjj+wgtysLCnD9ukeb9DzHPFLRu1OM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vgoHe-0036Qn-2y; Fri, 16 Jan 2026 19:10:54 +0100
Date: Fri, 16 Jan 2026 19:10:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Damien Dejean <dam.dejean@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] net: phy: realtek: add RTL8224 pair swap support
Message-ID: <bde1d3a9-6378-49a9-bcc2-00f4038f5558@lunn.ch>
References: <20260116173920.371523-1-dam.dejean@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116173920.371523-1-dam.dejean@gmail.com>

On Fri, Jan 16, 2026 at 06:39:19PM +0100, Damien Dejean wrote:
> The RTL8224 has a register to configure a pair swap (from ABCD order to
> DCBA) providing PCB designers more flexbility when wiring the chip. The
> swap parameter has to be set correctly for each of the 4 ports before
> the chip can detect a link.

Does the PHY support auto MDI-X, where it figures out a working
combination at link up time? That allows you to use crossed or not
crossed cables.

Anyway, the DT property you are adding seems to be the same as
marvell,mdi-cfg-order. See commit:

1432965bf5ce ("dt-bindings: net: marvell,aquantia: add property to override MDI_CFG")

> +  realtek,mdi-pair-swap:

Maybe call this realtek,mdi-cfg-order and use the same binding?

> +    description:
> +      Enable or disable the swap of the ethernet pairs (from ABCD to DCBA).
> +      The "keep" setting will keep the pair configuration at whatever its
> +      current state is.
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum:
> +      - keep

You should not need keep. If the property is not present in DT, you by
default do nothing, which would be keep.

> diff --git a/drivers/net/phy/realtek/Kconfig b/drivers/net/phy/realtek/Kconfig
> index b05c2a1e9024..a741b34d193e 100644
> --- a/drivers/net/phy/realtek/Kconfig
> +++ b/drivers/net/phy/realtek/Kconfig
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config REALTEK_PHY
>  	tristate "Realtek PHYs"
> +	select PHY_PACKAGE
>  	help
>  	  Currently supports RTL821x/RTL822x and fast ethernet PHYs

Changes to DT bindings should be in a patch of its own.

    Andrew

---
pw-bot: cr

