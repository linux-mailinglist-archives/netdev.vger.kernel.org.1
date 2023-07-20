Return-Path: <netdev+bounces-19341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8503D75A523
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 06:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9D21C212CE
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 04:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6791385;
	Thu, 20 Jul 2023 04:35:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D783EA5E
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 04:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA84C433C7;
	Thu, 20 Jul 2023 04:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689827745;
	bh=d9AKXeTNlZzlG6Phg9AfyhYmnmjPYT0tp1CULN8PnW0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tdUV0RbGmzIwaSAjaKh1P8L51/7NeYy5KHuzTpZOA8DKcu95ZMO98l2AIdF8ssFLk
	 +hVY7sxUBU/CPgVDRlj7bhcDWQYwSu/XTdzZsWv/KpW+U6zSZeTsp/odnEpgJdJy3m
	 Flr51URsP0sXic6+U+vwqDFj66/q5UwK5ABjyJJw+97lIBIT7cDvifPW8b0mqXUltF
	 c6+YbvPcUBNLp2j1AlRGARLJwSBrUC/2pL4IMfUbkkhqCnAsdNT41rT0DKRb5DHCYM
	 4OEypzDEWCnyRuqkLiy550qt/hqle4rqyVOq8AM9GP3IL+LLyMw0u81HBR3bQCkcaF
	 5oQssBwS6uE2A==
Date: Wed, 19 Jul 2023 21:35:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Roger Quadros <rogerq@kernel.org>,
 Simon Horman <simon.horman@corigine.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Lunn <andrew@lunn.ch>, Richard Cochran
 <richardcochran@gmail.com>, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring
 <robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 <nm@ti.com>, <srk@ti.com>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v10 2/2] net: ti: icssg-prueth: Add ICSSG ethernet
 driver
Message-ID: <20230719213543.0380e13e@kernel.org>
In-Reply-To: <20230719082755.3399424-3-danishanwar@ti.com>
References: <20230719082755.3399424-1-danishanwar@ti.com>
	<20230719082755.3399424-3-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The patch is too big to review.

Please break it apart separating into individual features, targeting
around 10 patches in the series. That will make it easier for reviewers
to take a look at the features in which they have expertise.

See two things which jumped out at me immediately below:

On Wed, 19 Jul 2023 13:57:55 +0530 MD Danish Anwar wrote:
> +	ICSSG_STATS(rx_crc_error_frames),

> +	ICSSG_STATS(rx_max_size_error_frames),
> +	ICSSG_STATS(rx_frame_min_size),
> +	ICSSG_STATS(rx_min_size_error_frames),
> +	ICSSG_STATS(rx_overrun_frames),

> +	ICSSG_STATS(rx_64B_frames),
> +	ICSSG_STATS(rx_bucket1_frames),
> +	ICSSG_STATS(rx_bucket2_frames),
> +	ICSSG_STATS(rx_bucket3_frames),
> +	ICSSG_STATS(rx_bucket4_frames),
> +	ICSSG_STATS(rx_bucket5_frames),
> +	ICSSG_STATS(rx_total_bytes),
> +	ICSSG_STATS(rx_tx_total_bytes),
> +	/* Tx */
> +	ICSSG_STATS(tx_good_frames),
> +	ICSSG_STATS(tx_broadcast_frames),
> +	ICSSG_STATS(tx_multicast_frames),
> +	ICSSG_STATS(tx_odd_nibble_frames),
> +	ICSSG_STATS(tx_underflow_errors),
> +	ICSSG_STATS(tx_frame_max_size),
> +	ICSSG_STATS(tx_max_size_error_frames),
> +	ICSSG_STATS(tx_frame_min_size),
> +	ICSSG_STATS(tx_min_size_error_frames),
> +	ICSSG_STATS(tx_bucket1_size),
> +	ICSSG_STATS(tx_bucket2_size),
> +	ICSSG_STATS(tx_bucket3_size),
> +	ICSSG_STATS(tx_bucket4_size),
> +	ICSSG_STATS(tx_64B_frames),
> +	ICSSG_STATS(tx_bucket1_frames),
> +	ICSSG_STATS(tx_bucket2_frames),
> +	ICSSG_STATS(tx_bucket3_frames),
> +	ICSSG_STATS(tx_bucket4_frames),
> +	ICSSG_STATS(tx_bucket5_frames),
> +	ICSSG_STATS(tx_total_bytes),

Please use standard stats:
https://docs.kernel.org/next/networking/statistics.html

And do not duplicate those stats in the ethool -S output.

> +static const char emac_ethtool_priv_flags[][ETH_GSTRING_LEN] = {
> +	"iet-frame-preemption",
> +	"iet-mac-verify",
> +};

What are these? We have a proper ethtool API for frame preemption.
-- 
pw-bot: cr

