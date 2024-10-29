Return-Path: <netdev+bounces-140001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6F79B4FC4
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 17:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487EE283197
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 16:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24CF198A31;
	Tue, 29 Oct 2024 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CX4RJ8cZ"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6380F7DA81;
	Tue, 29 Oct 2024 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730220592; cv=none; b=K7OqScYsGgZeRW6cirZfonKNUsPxAuIJdUt06cod5dSr+APKYQsgp9Y4pFYAlf39+xN/hOwg/uNQ4n7wnYuSCtkU2TFLirPpFVrGZxh/KrVDSSKw3Q7sAjivchoIvahgKLUmYXFXq9x2YoVpZxt0kDpiQ99+sCObFHb1fH8KcBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730220592; c=relaxed/simple;
	bh=NUvBGApMTpUXZBtyvuCf09+ZVpOnEgSubz8I3oGHx58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H13u8RV3TQ7eLBzuqaCiSfJPHC4JZdKnttE5QTgednr8Zu5CG2dHyHh60QH1jrRxx8TswAo5rxmKRBDZZ8v3X5PzeDa/UxZeqPUxWXf3+aXI1YmDEbSoPj6T1StBY/V5FRcXGlwIqx+gWwaAsRyzcHxJ3RspCpK2jwnw0N5uTDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CX4RJ8cZ; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 39197C000A;
	Tue, 29 Oct 2024 16:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730220581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oq/IS9y6GR5X9s4TTxcOReHZgXOpsa/vs1MEDyVylIc=;
	b=CX4RJ8cZS5ZeBT/6yylQuM+pYRreeVQM6VZwtFBKPx+wENb36vCSJumMhr9qJj29JEBLat
	rdAl8lxGTT+unSsLghqdj6WuLh+l2GZYk9xfTTrhXS3rBfncOb3jnb8fmpVAtEsizLzhkg
	XiSdIQJ5ULsE8Pr32t0IE0YWkLgwh4XG+Qtcgu6bBRdImTp+tlXXZK2r3DNc+bOm66oMno
	ivSbr9IrVGWJ2Wu6E9kfmYIbUdq3721H90h+OC5BHCyLKNayy/qZJesQPYpejhU5uVYgS2
	c92bDybPZ6rmHeGMcshpIZxFCWvx/VrTPRGLekCe+qd6byS5lANUVP5D4FsD9A==
Date: Tue, 29 Oct 2024 17:49:39 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Robert Joslyn <robert_joslyn@selinc.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <lee@kernel.org>
Subject: Re: [RFC PATCH 2/2] net: selpcimac: Add driver for SEL PCIe network
 adapter
Message-ID: <20241029174939.1f7306df@fedora.home>
In-Reply-To: <20241028223509.935-3-robert_joslyn@selinc.com>
References: <20241028223509.935-1-robert_joslyn@selinc.com>
	<20241028223509.935-3-robert_joslyn@selinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello,

On Mon, 28 Oct 2024 15:35:08 -0700
Robert Joslyn <robert_joslyn@selinc.com> wrote:

> Add support for SEL FPGA based network adapters. The network device is
> implemented as an FPGA IP core and enumerated by the selpvmf driver.
> This is used on multiple devices, including:
>  - SEL-3350 mainboard
>  - SEL-3390E4 card
>  - SEL-3390T card

Make sure that you get the right people as recipients for this
patchset. You would need at least the net maintainers, make sure to use
the scripts/get_maintainers.pl tool to know who to send the patch to.

> 
> Signed-off-by: Robert Joslyn <robert_joslyn@selinc.com>
> ---
>  MAINTAINERS                                  |   1 +
>  drivers/net/ethernet/Kconfig                 |   1 +
>  drivers/net/ethernet/Makefile                |   1 +
>  drivers/net/ethernet/sel/Kconfig             |  31 +
>  drivers/net/ethernet/sel/Makefile            |  22 +
>  drivers/net/ethernet/sel/ethtool.c           | 404 ++++++++
>  drivers/net/ethernet/sel/ethtool.h           |  17 +
>  drivers/net/ethernet/sel/hw_interface.c      | 410 ++++++++
>  drivers/net/ethernet/sel/hw_interface.h      |  46 +
>  drivers/net/ethernet/sel/mac_main.c          | 155 +++
>  drivers/net/ethernet/sel/mdio.c              | 166 ++++
>  drivers/net/ethernet/sel/mdio.h              |  15 +
>  drivers/net/ethernet/sel/mii.c               | 422 +++++++++
>  drivers/net/ethernet/sel/mii.h               |  21 +
>  drivers/net/ethernet/sel/mii_interface.c     | 133 +++
>  drivers/net/ethernet/sel/mii_interface.h     |  23 +
>  drivers/net/ethernet/sel/netdev.c            | 946 +++++++++++++++++++
>  drivers/net/ethernet/sel/netdev.h            |  24 +
>  drivers/net/ethernet/sel/netdev_isr.c        | 245 +++++
>  drivers/net/ethernet/sel/netdev_isr.h        |  20 +
>  drivers/net/ethernet/sel/netdev_rx.c         | 785 +++++++++++++++
>  drivers/net/ethernet/sel/netdev_rx.h         |  17 +
>  drivers/net/ethernet/sel/netdev_tx.c         | 647 +++++++++++++
>  drivers/net/ethernet/sel/netdev_tx.h         |  22 +
>  drivers/net/ethernet/sel/pci_mac.h           | 290 ++++++
>  drivers/net/ethernet/sel/pci_mac_hw_regs.h   | 370 ++++++++
>  drivers/net/ethernet/sel/pci_mac_sysfs.c     | 642 +++++++++++++
>  drivers/net/ethernet/sel/pci_mac_sysfs.h     |  14 +
>  drivers/net/ethernet/sel/sel_pci_mac_ioctl.h |  25 +
>  drivers/net/ethernet/sel/sel_phy.h           |  91 ++
>  drivers/net/ethernet/sel/sel_phy_broadcom.c  | 316 +++++++
>  drivers/net/ethernet/sel/sel_phy_broadcom.h  |  15 +
>  drivers/net/ethernet/sel/sel_phy_marvell.c   | 458 +++++++++
>  drivers/net/ethernet/sel/sel_phy_marvell.h   |  15 +
>  drivers/net/ethernet/sel/sel_phy_ti.c        | 419 ++++++++
>  drivers/net/ethernet/sel/sel_phy_ti.h        |  14 +
>  drivers/net/ethernet/sel/sel_soft_phy.c      |  98 ++
>  drivers/net/ethernet/sel/sel_soft_phy.h      |  15 +
>  drivers/net/ethernet/sel/semaphore.h         |  85 ++
>  drivers/net/ethernet/sel/sfp.c               | 615 ++++++++++++
>  drivers/net/ethernet/sel/sfp.h               |  61 ++

I haven't reviewed the code itself as this is a biiiiig patch, I
suggest you try to split it into more digestable patches, focusing on
individual aspects of the driver.

One thing is the PHY support as you mention in the cover-letter, in the
current state this driver re-implements PHY drivers from what I
understand. You definitely need to use the kernel infra for PHY
handling.

As it seems this driver also re-implements SFP entirely, I suggest you
look into phylink [1]. This will help you supporting the PHYs and SFPs.
You can take a look at the mvneta.c and mvpp2 drivers for examples.

Make sure you handle the mdio bus control using the dedicated framework
(see mii_bus et al.).

I'd be happy to give you more reviews, but this would be a more
manageable task with smaller patches :)

Best regards,

Maxime

