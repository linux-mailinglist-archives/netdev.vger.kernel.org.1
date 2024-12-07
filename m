Return-Path: <netdev+bounces-149919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B439E8202
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 21:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3411884249
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 20:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB0514A0B9;
	Sat,  7 Dec 2024 20:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M+dE+J5Z"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6373E28F5
	for <netdev@vger.kernel.org>; Sat,  7 Dec 2024 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733604454; cv=none; b=ReVEkc2LtGHQjPR5o1oSJSDySe8D4ouZ/VJ1sYzJn5DsVzPNuUDQym5NzalWn63woP8MN48kaglq1Lm9mDYBHyZ6Or42Fh/19KItHia7iKgCPATgxq6p5Jz1qc67ZOJxFFXaE/BrtTOyfzV6GgulUteTeSh81r5WoNPt2L/R2cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733604454; c=relaxed/simple;
	bh=4JrY1TwBaoL5uZ5wPOs1ZkTUfS0ZkAbwFMZc8BAQeE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H78kDG4TsL++DLtkouQLNhQQDanKCcVflv/t1C1oJ+fwM8MERsdAE4vxLFLzKzSxS+OkuVfqNlExgpsWXvdjbEjllSRB4MykkUMHHZdKek4La283iVA5Kowrr5a4X4hq/S4K+sm9wgOuOYcSaXJoag5dI6z/uDQtsJw3Y3Gd83o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=M+dE+J5Z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=T5Da1dSGUun5jYIHdetMXcnVQ26y5IlwxR92LgqkbNM=; b=M+
	dE+J5Zkpv7ipPsl4BT+EUx9ZR3AZnMcOSC3fRyWSV70LAX/qbUsox4WdIZTG2bzHFFupbbdkpXhyT
	VYbCiwdZpE10aRmEwUlG2dw4I8uzGHNzFElni6aTXs+rrBO0nm+g0ZLSxreBtc3ga3/WtIK/XcVle
	SxzYX9R1rB44w0U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tK1i7-00FVNF-BL; Sat, 07 Dec 2024 21:47:31 +0100
Date: Sat, 7 Dec 2024 21:47:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@jo-so.de>
Cc: netdev@vger.kernel.org, Christian Eggers <ceggers@arri.de>
Subject: Re: KSZ8795 not detected at start to boot from NFS
Message-ID: <a578b29f-53f0-4e33-91a4-3932fa759cd1@lunn.ch>
References: <ojegz5rmcjavsi7rnpkhunyu2mgikibugaffvj24vomvan3jqx@5v6fyz32wqoz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ojegz5rmcjavsi7rnpkhunyu2mgikibugaffvj24vomvan3jqx@5v6fyz32wqoz>

On Sat, Dec 07, 2024 at 08:53:38AM +0100, Jörg Sommer wrote:
> Hi,
> 
> I'm trying to load the root filesystem via NFS with a
> NET_DSA_MICROCHIP_KSZ8795_SPI attached to an TI_DAVINCI_EMAC. With 5.10 it
> works, but with later versions the kernel fails to detect the switch. It is
> since
> 
> commit 8c4599f49841dd663402ec52325dc2233add1d32
> Author: Christian Eggers <ceggers@arri.de>
> Date:   Fri Nov 20 12:21:07 2020 +0100
> 
>     net: dsa: microchip: ksz8795: setup SPI mode
> 
>     This should be done in the device driver instead of the device tree.
> 
>     Signed-off-by: Christian Eggers <ceggers@arri.de>
>     Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> diff --git drivers/net/dsa/microchip/ksz8795_spi.c drivers/net/dsa/microchip/ksz8795_spi.c
> index 8b00f8e6c02f..f98432a3e2b5 100644
> --- drivers/net/dsa/microchip/ksz8795_spi.c
> +++ drivers/net/dsa/microchip/ksz8795_spi.c
> @@ -49,6 +49,12 @@ static int ksz8795_spi_probe(struct spi_device *spi)
>         if (spi->dev.platform_data)
>                 dev->pdata = spi->dev.platform_data;
> 
> +       /* setup spi */
> +       spi->mode = SPI_MODE_3;
> +       ret = spi_setup(spi);
> +       if (ret)
> +               return ret;
> +
>         ret = ksz8795_switch_register(dev);
> 
>         /* Main DSA driver may not be started yet. */
> 
> The kernel reports
> 
> [    1.912756] ksz8795-switch: probe of spi0.1 failed with error -22
> …
> [    2.048054] davinci_emac 1e20000.ethernet: incompatible machine/device type for reading mac address
> [    2.062352] davinci_emac davinci_emac.1: failed to get EMAC clock
> [    2.068632] davinci_emac: probe of davinci_emac.1 failed with error -16
> 
> It tries to initialize the switch before the ethernet of the SoC is ready.
> 
> Before this commit the kernel returned EPROBE_DEFER instead of EINVAL (or
> ENODEV) as a quick

This is often true for DSA switches, that the first probe fails with
EPROBE_DEFER, because the conduit ethernet is not ready.

What i don't understand from your description is why:

> +       /* setup spi */
> +       spi->mode = SPI_MODE_3;
> +       ret = spi_setup(spi);
> +       if (ret)
> +               return ret;
> +

is causing this issue. Is spi_setup() failing?

	Andrew

