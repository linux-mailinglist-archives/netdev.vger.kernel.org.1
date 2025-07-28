Return-Path: <netdev+bounces-210538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A23F8B13D68
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12493ADF19
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 14:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3640026463A;
	Mon, 28 Jul 2025 14:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FkJT12Nt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4AF16DEB1;
	Mon, 28 Jul 2025 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713691; cv=none; b=QQBKyA2A3O0Cdq07H+XmafaoDap1JFwXlubvbebIAEHi5q9KQXhxqwwvYduPyTsYjifp/Fp8fZguNiRDQKHeXGSNFA2eKg0Fpy4YLpMjIDTVssslw498dT//EjLtlrsBlEF9qHVAJ5qcAuqSofeyY9fB6jp0ezel5j8ZLt+WDl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713691; c=relaxed/simple;
	bh=ddg4IC4/1r1N45bMbhL7R41OSeyNZjrSS4ddL67Tmic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQpbIfi0jLjDggDe4OpWNh6hrkcKN0U9FLo5RgjYrkDS0PL2tbg9bD/uiSyHGpIH3qpTUKsToqX4+XdBygotlYR//0S5zNYOhoQbc8F7HzOhPg3hCIKESch4SKsMrabNHGzyXPGdDnhg78onpuF22qaZ6yDtXm9CnHqMxLq1eBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FkJT12Nt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yciS6WThtOFQjebRhU9cNTCa8lTgZg8esDAWYVn97c8=; b=FkJT12NtevMagAkHUGHx9c/4ys
	WxCaQf0eB3zbVS3r0GSwJ22i3hf5NO/yuKgSA5KulKlnAbHrOPB4+u+F1SJRQ+ohya2cBr2Q9fIhF
	Q7hdCjrWUPaOwhR5Dv4g5l7PJyJMJW0iJpRmbzF9iZAUbEuh184jdLcvcbCyPIfOl/Sw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ugP2Q-003691-T3; Mon, 28 Jul 2025 16:41:14 +0200
Date: Mon, 28 Jul 2025 16:41:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Michael Walle <mwalle@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roger Quadros <rogerq@kernel.org>, Simon Horman <horms@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] Revert "net: ethernet: ti: am65-cpsw: fixup PHY
 mode for fixed RGMII TX delay"
Message-ID: <57823bd1-265c-4d01-92d9-9019a2635301@lunn.ch>
References: <20250728064938.275304-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728064938.275304-1-mwalle@kernel.org>

On Mon, Jul 28, 2025 at 08:49:38AM +0200, Michael Walle wrote:
> This reverts commit ca13b249f291f4920466638d1adbfb3f9c8db6e9.
> 
> This patch breaks the transmit path on an AM67A/J722S. This SoC has an
> (undocumented) configurable delay (CTRL_MMR0_CFG0_ENET1_CTRL, bit 4).

Is this undocumented register only on the AM67A/J722S?

The patch being reverted says:

   All am65-cpsw controllers have a fixed TX delay

So we have some degree of contradiction here.

> The u-boot driver (net/ti/am65-cpsw-nuss.c) will configure the delay in
> am65_cpsw_gmii_sel_k3(). If the u-boot device tree uses rgmii-id this
> patch will break the transmit path because it will disable the PHY delay
> on the transmit path, but the bootloader has already disabled the MAC
> delay, hence there will be no delay at all.

We have maybe 8 weeks to fix this, before it makes it into a released
kernel. So rather than revert, i would prefer to extend the patch to
make it work with all variants of the SoC.

Is CTRL_MMR0_CFG0_ENET1_CTRL in the Ethernet address space? Would it
be possible for the MAC driver to read it, and know if the delay has
been disabled? The switch statement can then be made conditional?

If this register actually exists on all SoC variants, can we just
globally disable it, and remove the switch statement?

	 Andrew
	

