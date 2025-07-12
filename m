Return-Path: <netdev+bounces-206353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA6EB02BB5
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 17:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F4E94A02DA
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 15:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D141EA7CE;
	Sat, 12 Jul 2025 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2RwqASX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBAB4A24;
	Sat, 12 Jul 2025 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752334257; cv=none; b=qZzd7VIAaDf/I7+bVjDdX5iKdckMBX6V5cChrtum27SCmuthi4iBIuB4DODiL++M7v5mlCN40dR2fsmGN0rZx7ouQP6Hck3V6d4/X20MXjnuu55N3ErWW/H1mYgddlT7w3eDPUWNu95NjH62ZI+yNhBF+RCZuQm7GlbKQkwXkd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752334257; c=relaxed/simple;
	bh=265ml+LkyhdXVhTmnhknr5HyO7Ge+6RVUWnrYFIdREw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKOAXTCUIIfhfn83KV2CTfZS/GWsta7iuWTIUa+OapfO2HjR477veDrvlnfbwcJ5kfP8m5frhgsgyU31+KT3d3PLGFhZXSYTjy0I8/rXfvMsR4VIipXEdRmX4dgiBiC6e1CCaNTOypBpTmnDDudvgIiU9pabT8vfxopdvkje/lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2RwqASX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1479C4CEEF;
	Sat, 12 Jul 2025 15:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752334256;
	bh=265ml+LkyhdXVhTmnhknr5HyO7Ge+6RVUWnrYFIdREw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s2RwqASXqSx8Oh6JU7k89Go16dcL/GrUjUOPGS6FmwOXL2qyP6dmzZwOZ8/ffMqQ9
	 NcsOdGAPykesDGA/uF5PGUagCx1P5vb7UNs+BzxkLQ7J5rb+ELHrmM6PbNaoBu6VAh
	 5fupI6aDCfQiJ8hwvz5GPrROM8SOtRg37+BMxyTfxnlv5U83uDu9oF9ryBC+Rl4Wth
	 wo2TxnEt4soQsEGHDYW0tu+cNj6mYqWEekeUSJvW9fzaltbAl4mCKJ2V96SYPEHx4m
	 ril//CNglu6QZ5KrdRBdAzmtcf1PKAtWWyLlVM9dNQ/rBpNP2Av+Jg+qPaApoTT6Nf
	 KXRCWeNBmEq9Q==
Date: Sat, 12 Jul 2025 16:30:52 +0100
From: Simon Horman <horms@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v2 net-next] net: wangxun: fix VF drivers Kconfig
 dependencies and help text
Message-ID: <20250712153052.GF721198@horms.kernel.org>
References: <20250712055856.1732094-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250712055856.1732094-1-rdunlap@infradead.org>

+ Arnd

On Fri, Jul 11, 2025 at 10:58:56PM -0700, Randy Dunlap wrote:
> On x86_64, when CONFIG_PTP_1588_CLOCK_OPTIONAL=m,
> CONFIG_LIBWX can be set to 'y' by either of TXGBEVF=y or NGBEVF=y,
> causing kconfig unmet direct dependencies warning messages:
> 
> WARNING: unmet direct dependencies detected for LIBWX
>   Depends on [m]: NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_WANGXUN [=y] && PTP_1588_CLOCK_OPTIONAL [=m]
>   Selected by [y]:
>   - TXGBEVF [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_WANGXUN [=y] && PCI [=y] && PCI_MSI [=y]
>   - NGBEVF [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_WANGXUN [=y] && PCI_MSI [=y]
> 
> and subsequent build errors:
> 
> ld: vmlinux.o: in function `wx_clean_tx_irq':
> drivers/net/ethernet/wangxun/libwx/wx_lib.c:757:(.text+0xa48f18): undefined reference to `ptp_schedule_worker'
> ld: vmlinux.o: in function `wx_get_ts_info':
> drivers/net/ethernet/wangxun/libwx/wx_ethtool.c:509:(.text+0xa4a58c): undefined reference to `ptp_clock_index'
> ld: vmlinux.o: in function `wx_ptp_stop':
> drivers/net/ethernet/wangxun/libwx/wx_ptp.c:838:(.text+0xa4b3dc): undefined reference to `ptp_clock_unregister'
> ld: vmlinux.o: in function `wx_ptp_reset':
> drivers/net/ethernet/wangxun/libwx/wx_ptp.c:769:(.text+0xa4b80c): undefined reference to `ptp_schedule_worker'
> ld: vmlinux.o: in function `wx_ptp_create_clock':
> drivers/net/ethernet/wangxun/libwx/wx_ptp.c:532:(.text+0xa4b9d1): undefined reference to `ptp_clock_register'
> 
> Add dependency to PTP_1588_CLOCK_OPTIONAL for both txgbevf and ngbevf.
> This is needed since both of them select LIBWX and it depends on
> PTP_1588_CLOCK_OPTIONAL.
> 
> Drop "depends on PCI" for TXGBEVF since PCI_MSI implies that.
> Drop "select PHYLINK" for TXGBEVF since the driver does not use phylink.
> 
> Move the driver name help text to the module name help text for
> both drivers.
> 
> Fixes: 377d180bd71c ("net: wangxun: add txgbevf build")
> Fixes: a0008a3658a3 ("net: wangxun: add ngbevf build")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jiawen Wu <jiawenwu@trustnetic.com>
> Cc: Mengyuan Lou <mengyuanlou@net-swift.com>
> Cc: netdev@vger.kernel.org
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> ---
> v2: also drop PHYLINK for TXGBEVF, suggested by Jiawen Wu

Reviewed-by: Simon Horman <horms@kernel.org>

Arnd (CCed) has also posted a patch [1] for the unmet dependencies / build
errors portion of this patch. My 2c worth would be to take Arnd's patch and
for Randy then follow-up with an updated version of his patch with the
extra bits in it. But I don't feel strongly about this.

1. [PATCH] net: wangxun: fix LIBWX dependencies again
   https://lore.kernel.org/all/20250711082339.1372821-1-arnd@kernel.org/

