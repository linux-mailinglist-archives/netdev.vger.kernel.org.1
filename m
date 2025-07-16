Return-Path: <netdev+bounces-207360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C03CB06CF6
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 07:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED2977A29C1
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 05:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B0525C70F;
	Wed, 16 Jul 2025 05:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u6wJDG2q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F01A1DF26B;
	Wed, 16 Jul 2025 05:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752642599; cv=none; b=sdH6whosOfn1yLzbPHyU15v9iM33rOvMoKgcGHE7KO623RwxsqxdoGIHvpB1hHzHAtLtnfNOghEfXoHqa82kay3nODqXKunvpLA/RmriXW93Cc4DCRM/5bhsgbNXWSHwoKlg1rgD9vxQgTNaIKHpGaKhdi8gGAlESlAQ/GS9PnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752642599; c=relaxed/simple;
	bh=cOqdqIUO7fxmsC4oJLZT5RjBxfuL037AGc3yeM3iP/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcSsJu+gXusLs4sBbkEpqcxb37WhttvZdm1evmXHcckN8UHro2MRHM9ATxpM/8zgfrPtVFSj0rLwJfjln2FCqvT0JtH6bdUuZ1yHQBEtjNd+AGElNYwXmj31aRH1JpsigxmBBimgo/DtyEIqMTK2QHlyZiEtSeXtWplsweHY5e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u6wJDG2q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5A9C4CEF0;
	Wed, 16 Jul 2025 05:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752642598;
	bh=cOqdqIUO7fxmsC4oJLZT5RjBxfuL037AGc3yeM3iP/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u6wJDG2qJ9PFcVAuQRvzw4syFpfe12yzoyafiri8z/8PLrxjmgN5PWVZN9zrFFwFU
	 qsAn2LaSYuEw5pbSn4RLfMv0isxRHjK4cep5eBorAgYFkvTTRQ0XrB6zCMCaS5RnYE
	 axk7qMx/nxk7a8zcUGh7uVTJxDRtHvU+jRCX+8Dc=
Date: Wed, 16 Jul 2025 07:09:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Dave Ertman <david.m.ertman@intel.com>,
	Saravana Kannan <saravanak@google.com>,
	Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH net v2 1/4] auxiliary: Support hexadecimal ids
Message-ID: <2025071637-doubling-subject-25de@gregkh>
References: <20250716000110.2267189-1-sean.anderson@linux.dev>
 <20250716000110.2267189-2-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716000110.2267189-2-sean.anderson@linux.dev>

On Tue, Jul 15, 2025 at 08:01:07PM -0400, Sean Anderson wrote:
> Support creating auxiliary devices with the id included as part of the
> name. This allows for hexadecimal ids, which may be more appropriate for
> auxiliary devices created as children of memory-mapped devices. If an
> auxiliary device's id is set to AUXILIARY_DEVID_NONE, the name must
> be of the form "name.id".
> 
> With this patch, dmesg logs from an auxiliary device might look something
> like
> 
> [    4.781268] xilinx_axienet 80200000.ethernet: autodetected 64-bit DMA range
> [   21.889563] xilinx_emac.mac xilinx_emac.mac.80200000 net4: renamed from eth0
> [   32.296965] xilinx_emac.mac xilinx_emac.mac.80200000 net4: PHY [axienet-80200000:05] driver [RTL8211F Gigabit Ethernet] (irq=70)
> [   32.313456] xilinx_emac.mac xilinx_emac.mac.80200000 net4: configuring for inband/sgmii link mode
> [   65.095419] xilinx_emac.mac xilinx_emac.mac.80200000 net4: Link is Up - 1Gbps/Full - flow control rx/tx
> 
> this is especially useful when compared to what might happen if there is
> an error before userspace has the chance to assign a name to the netdev:
> 
> [    4.947215] xilinx_emac.mac xilinx_emac.mac.1 (unnamed net_device) (uninitialized): incorrect link mode  for in-band status
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
> Changes in v2:
> - Add example log output to commit message

I rejected v1, why is this being sent again?

confused,

greg k-h

