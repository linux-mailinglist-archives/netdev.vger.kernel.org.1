Return-Path: <netdev+bounces-173326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82306A58577
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 16:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE653AAA38
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 15:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0571D187553;
	Sun,  9 Mar 2025 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rbmnHJiW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196398836;
	Sun,  9 Mar 2025 15:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741535217; cv=none; b=VHspcF/glRCTZSBrVIP9yjQRhzFSCoH4guI7i6g9nPjOn+eYSn68daHuKdM2/SM1ymFCmu7cMYbYTR+0U9klnoBvInem4O0eN92jGcvkzH1cbiQ5hr+GzrZbJGDqMmoj0ZyNTaY8fkH8Q99QAQPtyF3o5OT/WsXxhOGx3siADWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741535217; c=relaxed/simple;
	bh=OqIURxiKQqRpTrx/sTIzJKqubsWIT5kp5CUKfwFi9p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plkxqBOKHHhzH+tUQ9EH8+/+w+wTWgVagFM12NWh8qhj3GKefeIQClp/9lALn65evS7C46LKhN5sOAAYIxiTrze66piozVYsnw+uDHthcXmuWr76t8/7JehknknExg2AjwfcMuTjWt694BOWug5LagyiGJ5S1IAgW4vz7DnMby8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rbmnHJiW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=d8uFgmPJEzex6xleGPGMhuPODKGJhQE42y/cWzBkaxw=; b=rbmnHJiWvIguG1SnZFs2WBypEN
	78QWwPpC2VxRr4+o5JIfakVqQU8ZUtEHsDheu9DQCD4AGTzm7NA0non9+ZUg3Q2G5EcmilAGx5yQ3
	FdsdjIOHsxA3Pu+Ki3vrMmF+AZBg8RW0xdmeC9G2rmaRrSASxck1nxWobJxxEMWsyqdQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1trIrY-003kLm-8D; Sun, 09 Mar 2025 16:46:48 +0100
Date: Sun, 9 Mar 2025 16:46:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Hanyuan Zhao <hanyuan-z@qq.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew+netdev@lunn.ch,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: net: add enc28j60's irq-gpios node
 description and binding example
Message-ID: <a406f363-0f2d-4ebb-8eec-053d9d148502@lunn.ch>
References: <tencent_8031D017AFE5E266C43F62C916C709009E06@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_8031D017AFE5E266C43F62C916C709009E06@qq.com>

On Sun, Mar 09, 2025 at 03:48:38PM +0800, Hanyuan Zhao wrote:
> This patch allows the kernel to automatically requests the pin, configures
> it as an input, and converts it to an IRQ number, according to a GPIO
> phandle specified in device tree. This simplifies the process by
> eliminating the need to manually define pinctrl and interrupt nodes.
> Additionally, it is necessary for platforms that do not support pin
> configuration and properties via the device tree.
> 
> Signed-off-by: Hanyuan Zhao <hanyuan-z@qq.com>
> ---
>  .../bindings/net/microchip,enc28j60.txt       | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/microchip,enc28j60.txt b/Documentation/devicetree/bindings/net/microchip,enc28j60.txt
> index a8275921a896..e6423635e55b 100644
> --- a/Documentation/devicetree/bindings/net/microchip,enc28j60.txt
> +++ b/Documentation/devicetree/bindings/net/microchip,enc28j60.txt

The DT Maintainers have a strong preference that you first convert to
yaml, and then make extension.

> @@ -8,6 +8,8 @@ the SPI master node.
>  Required properties:
>  - compatible: Should be "microchip,enc28j60"
>  - reg: Specify the SPI chip select the ENC28J60 is wired to
> +
> +Required interrupt properties with pin control subsystem:
>  - interrupts: Specify the interrupt index within the interrupt controller (referred
>                to above in interrupt-parent) and interrupt type. The ENC28J60 natively
>                generates falling edge interrupts, however, additional board logic

You should be able to use the interrupts property and just point it
at a GPIO controller that supports interrupts.

We really need a better understanding of:

> Additionally, it is necessary for platforms that do not support pin
> configuration and properties via the device tree.

    Andrew

---
pw-bot: cr

