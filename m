Return-Path: <netdev+bounces-123414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E90B964C15
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 18:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB771F2323B
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 16:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670B71B5830;
	Thu, 29 Aug 2024 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRBWKkfz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA091B151C;
	Thu, 29 Aug 2024 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950359; cv=none; b=hK7TlpTLG3lkEqpWYk/uQHoEy8D6+IkGSFxUtZyDoUnA2vebGbLnI4ZIsRk/4Qc1LMNw/mkrfagTO95kZyQaY+83FDr/h8AeOScjzfTaUVwNiIy7Zt5QIcb33TcCbOuC2FWA56U2rBMMreS0b4y0WnS0Romwo6nNdGyYvMebFDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950359; c=relaxed/simple;
	bh=dpcjacSyZ0wDA5iUfrSXiOJl110RtbPxhTCYt96yME0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQ+hQUV6izRYz/oIjoRC2v2Ni6s03u5Vfgc+WM/d4ZfhqHF9YYAYx2ooIFNpSx4F4KKcNY2boDar1R79qTta7UvtCPqVtRG5ihTwgepbAxROTFpze//miYrlNCzEf5THWfgjlBYBqu2hxehQgrrRv/ajnF7bB2uDRN4VZLe9OvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRBWKkfz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E907C4CEC1;
	Thu, 29 Aug 2024 16:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724950358;
	bh=dpcjacSyZ0wDA5iUfrSXiOJl110RtbPxhTCYt96yME0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mRBWKkfzZaGg0P7VYohoCehlB1b6sx+YN+5B4sx78PjOcnj86ngo/n9ZiO3iI2Ih2
	 BJlr5kun7SALyn1l3EqHrY3mzPhpP54Uym+jpJ5qrShzAIz3x4LmcfgTW7VYz4K1c3
	 UW49umMDKDvunI9Amdj0YTFvu6qZCegpYdaGoIqUVh80a2WapvQj3FoQ8aVJZC2Evi
	 crt3ql6hKCR72Tw8ROhNJJZu3/hmj5+4MSVQBJagLcJzE8XxKjHGmUxPTmMpQNv7t0
	 d2yMIsPdL8LxZkBCpQP8wvT3MPK4tElmraOb+eGuRXzjqOW1UT3Hsja5ry8tqhsSff
	 RJSqAhWqVtazw==
Date: Thu, 29 Aug 2024 17:52:34 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org, o.rempel@pengutronix.de,
	p.zabel@pengutronix.de
Subject: Re: [PATCHv2 net-next] net: ag71xx: update FIFO bits and descriptions
Message-ID: <20240829165234.GV1368797@kernel.org>
References: <20240828223931.153610-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828223931.153610-1-rosenp@gmail.com>

On Wed, Aug 28, 2024 at 03:38:47PM -0700, Rosen Penev wrote:
> Taken from QCA SDK. No functional difference as same bits get applied.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: forgot to send to netdev
>  drivers/net/ethernet/atheros/ag71xx.c | 48 +++++++++++++--------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
> index db2a8ade6205..692dbded8211 100644
> --- a/drivers/net/ethernet/atheros/ag71xx.c
> +++ b/drivers/net/ethernet/atheros/ag71xx.c
> @@ -149,11 +149,11 @@
>  #define FIFO_CFG4_MC		BIT(8)	/* Multicast Packet */
>  #define FIFO_CFG4_BC		BIT(9)	/* Broadcast Packet */
>  #define FIFO_CFG4_DR		BIT(10)	/* Dribble */
> -#define FIFO_CFG4_LE		BIT(11)	/* Long Event */
> -#define FIFO_CFG4_CF		BIT(12)	/* Control Frame */
> -#define FIFO_CFG4_PF		BIT(13)	/* Pause Frame */
> -#define FIFO_CFG4_UO		BIT(14)	/* Unsupported Opcode */
> -#define FIFO_CFG4_VT		BIT(15)	/* VLAN tag detected */
> +#define FIFO_CFG4_CF		BIT(11)	/* Control Frame */
> +#define FIFO_CFG4_PF		BIT(12)	/* Pause Frame */
> +#define FIFO_CFG4_UO		BIT(13)	/* Unsupported Opcode */
> +#define FIFO_CFG4_VT		BIT(14)	/* VLAN tag detected */
> +#define FIFO_CFG4_LE		BIT(15)	/* Long Event */
>  #define FIFO_CFG4_FT		BIT(16)	/* Frame Truncated */
>  #define FIFO_CFG4_UC		BIT(17)	/* Unicast Packet */
>  #define FIFO_CFG4_INIT	(FIFO_CFG4_DE | FIFO_CFG4_DV | FIFO_CFG4_FC | \
> @@ -168,28 +168,28 @@
>  #define FIFO_CFG5_DV		BIT(1)	/* RX_DV Event */
>  #define FIFO_CFG5_FC		BIT(2)	/* False Carrier */
>  #define FIFO_CFG5_CE		BIT(3)	/* Code Error */
> -#define FIFO_CFG5_LM		BIT(4)	/* Length Mismatch */
> -#define FIFO_CFG5_LO		BIT(5)	/* Length Out of Range */
> -#define FIFO_CFG5_OK		BIT(6)	/* Packet is OK */
> -#define FIFO_CFG5_MC		BIT(7)	/* Multicast Packet */
> -#define FIFO_CFG5_BC		BIT(8)	/* Broadcast Packet */
> -#define FIFO_CFG5_DR		BIT(9)	/* Dribble */
> -#define FIFO_CFG5_CF		BIT(10)	/* Control Frame */
> -#define FIFO_CFG5_PF		BIT(11)	/* Pause Frame */
> -#define FIFO_CFG5_UO		BIT(12)	/* Unsupported Opcode */
> -#define FIFO_CFG5_VT		BIT(13)	/* VLAN tag detected */
> -#define FIFO_CFG5_LE		BIT(14)	/* Long Event */
> -#define FIFO_CFG5_FT		BIT(15)	/* Frame Truncated */
> -#define FIFO_CFG5_16		BIT(16)	/* unknown */
> -#define FIFO_CFG5_17		BIT(17)	/* unknown */
> +#define FIFO_CFG5_CR		BIT(4)  /* CRC error */
> +#define FIFO_CFG5_LM		BIT(5)	/* Length Mismatch */
> +#define FIFO_CFG5_LO		BIT(6)	/* Length Out of Range */
> +#define FIFO_CFG5_OK		BIT(7)	/* Packet is OK */
> +#define FIFO_CFG5_MC		BIT(8)	/* Multicast Packet */
> +#define FIFO_CFG5_BC		BIT(9)	/* Broadcast Packet */
> +#define FIFO_CFG5_DR		BIT(10)	/* Dribble */
> +#define FIFO_CFG5_CF		BIT(11)	/* Control Frame */
> +#define FIFO_CFG5_PF		BIT(12)	/* Pause Frame */
> +#define FIFO_CFG5_UO		BIT(13)	/* Unsupported Opcode */
> +#define FIFO_CFG5_VT		BIT(14)	/* VLAN tag detected */
> +#define FIFO_CFG5_LE		BIT(15)	/* Long Event */
> +#define FIFO_CFG5_FT		BIT(16)	/* Frame Truncated */
> +#define FIFO_CFG5_UC		BIT(17)	/* Unicast Packet */
>  #define FIFO_CFG5_SF		BIT(18)	/* Short Frame */
>  #define FIFO_CFG5_BM		BIT(19)	/* Byte Mode */
>  #define FIFO_CFG5_INIT	(FIFO_CFG5_DE | FIFO_CFG5_DV | FIFO_CFG5_FC | \
> -			 FIFO_CFG5_CE | FIFO_CFG5_LO | FIFO_CFG5_OK | \
> -			 FIFO_CFG5_MC | FIFO_CFG5_BC | FIFO_CFG5_DR | \
> -			 FIFO_CFG5_CF | FIFO_CFG5_PF | FIFO_CFG5_VT | \
> -			 FIFO_CFG5_LE | FIFO_CFG5_FT | FIFO_CFG5_16 | \
> -			 FIFO_CFG5_17 | FIFO_CFG5_SF)
> +			 FIFO_CFG5_CE | FIFO_CFG5_LM | FIFO_CFG5_L0 | \

			                               FIFO_CFG5_LO

> +			 FIFO_CFG5_OK | FIFO_CFG5_MC | FIFO_CFG5_BC | \
> +			 FIFO_CFG5_DR | FIFO_CFG5_CF | FIFO_CFG5_UO | \
> +			 FIFO_CFG5_VT | FIFO_CFG5_LE | FIFO_CFG5_FT | \
> +			 FIFO_CFG5_UC | FIFO_CFG5_SF)
>  
>  #define AG71XX_REG_TX_CTRL	0x0180
>  #define TX_CTRL_TXE		BIT(0)	/* Tx Enable */

Please consider a patch to allow compilation of this driver with
COMPILE_TEST in order to increase build coverage.

-- 
pw-bot: cr

