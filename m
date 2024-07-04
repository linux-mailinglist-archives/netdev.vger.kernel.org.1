Return-Path: <netdev+bounces-109118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 745099270B5
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 09:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A831C2221C
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 07:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9F215DBB6;
	Thu,  4 Jul 2024 07:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fy8y5N8E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D99146581
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 07:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720078491; cv=none; b=oajUcK9ZVqt6h/ddGWA2AqZxYxKWptcoqY5vijcW6ptsHG70cbv/L26blFeXot4XgrKp4vf5RMd61SHzUYSJdFK4C24vmtCJYPSwi1gGL50BxGBaIbqM2Y7I7IFHcrxVV/ns0ul3wqMFsU9KAPyzZQ4lrGy4MzcXkHZ3q7R3slo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720078491; c=relaxed/simple;
	bh=XWbBHe7Lce6plnlh42+zkl4UYe7xZ+rHPaZ+wGaqH8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNT6bVedgES94rz8MONx3RXzS/x1Q9kKoau1OnbcGozbPGRnV/PDo4fK+oMz5HFaKf84JVb/+mR86VrE1wtzcJ1UYqRAnAh+fWWY4h6oMDpe4zCugF7jTQQTp752A5s12WjR5qORAeHKensJig+IEoUAXK+U+2DEiqpadXz6CtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fy8y5N8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3710EC3277B;
	Thu,  4 Jul 2024 07:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720078490;
	bh=XWbBHe7Lce6plnlh42+zkl4UYe7xZ+rHPaZ+wGaqH8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fy8y5N8EibW3pYJg44X55RnRQ43cmqAxIpV/L92kEUeO5Z9jIDZZero4kebkeoDnX
	 ZHhhY4mP2ahnEgdzZ+TIVG7zVN7XWhLvEGnHZJqbk1QlAsr2iJZsQy2HyhLQzz1uqu
	 vO95CGW7aS+LojDoAOzcTH37aDPKUjuZrHmyP7s8+X71Lz5RHyaLaJY/i+sC2I//e7
	 Mt2sE6mWincgBdvSbR0qhcwd6hSsmFQDqr4oTA/oLfqE53Jof22FV5tg/Y+oQRdRhj
	 TnvvskD/farzpKpfj4EJ5mF5fHRqoI+0O/AvwhgHcyWXyVW+9tEteBHJ89Opbclmq0
	 g2f4e1hIyBhQQ==
Date: Thu, 4 Jul 2024 08:34:46 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, ecree.xilinx@gmail.com,
	michael.chan@broadcom.com
Subject: Re: [PATCH net-next 02/11] net: ethtool: let driver declare max size
 of RSS indir table and key
Message-ID: <20240704073446.GW598357@kernel.org>
References: <20240702234757.4188344-1-kuba@kernel.org>
 <20240702234757.4188344-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702234757.4188344-3-kuba@kernel.org>

On Tue, Jul 02, 2024 at 04:47:47PM -0700, Jakub Kicinski wrote:
> Some drivers (bnxt but I think also mlx5 from ML discussions) change
> the size of the indirection table depending on the number of Rx rings.
> Decouple the max table size from the size of the currently used table,
> so that we can reserve space in the context for table growth.
> 
> Static members in ethtool_ops are good enough for now, we can add
> callbacks to read the max size more dynamically if someone needs
> that.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/linux/ethtool.h | 20 +++++++-----------
>  net/ethtool/ioctl.c     | 46 ++++++++++++++++++++++++++++++++---------
>  2 files changed, 44 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 3ce5be0d168a..dc8ed93097c3 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -173,6 +173,7 @@ static inline u32 ethtool_rxfh_indir_default(u32 index, u32 n_rx_rings)
>  struct ethtool_rxfh_context {
>  	u32 indir_size;
>  	u32 key_size;
> +	u32 key_off;
>  	u16 priv_size;
>  	u8 hfunc;
>  	u8 input_xfrm;

nit: key_off should have an entry in the kernel doc for
     struct ethtool_rxfh_context.

...

