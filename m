Return-Path: <netdev+bounces-21158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD09762976
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 05:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D98281B4E
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 03:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFC94C99;
	Wed, 26 Jul 2023 03:50:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADA315C9
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 03:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0ACC433C8;
	Wed, 26 Jul 2023 03:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690343416;
	bh=ftcsCLg9opVFQHziuDWuK9Vb2WB4UKQzFSr8yuWJn+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UapXkKZWjB5irsf6WvxvkX0NxSOH8OxcvH33it7pEs+5uhDVMfMhCagyW4tz4giqF
	 8F1BRl81hoBX7zabo/6LlCebQQbH5ocfRU6vzgwd7JqVSgHttTKVU75niVKUa1yMjk
	 LzBzzKZkKBl73T59+35uzhHskhG/+jYXuA19usbjQ9y9urUI7x7Fq9EYE+hFqIFvVA
	 pZN7xONXstZnPTh6+8OkBw/Zouh+akDslk6ta3f/mZGEwB8SlGInrRIh7McBit9eqJ
	 nMDoyyyOK0zAZU/de0k+LkAPAsr1cM6uf985ELbQUXmbpzqdCJHcvGShTYmOr2WzwN
	 fpr38k32ZvgTA==
Date: Tue, 25 Jul 2023 20:50:14 -0700
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
Subject: Re: [PATCH v11 07/10] net: ti: icssg-prueth: Add ICSSG Stats
Message-ID: <20230725205014.04e4bba3@kernel.org>
In-Reply-To: <20230724112934.2637802-8-danishanwar@ti.com>
References: <20230724112934.2637802-1-danishanwar@ti.com>
	<20230724112934.2637802-8-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jul 2023 16:59:31 +0530 MD Danish Anwar wrote:
> +	/* Rx */
> +	ICSSG_STATS(rx_packets, true),
> +	ICSSG_STATS(rx_broadcast_frames, false),
> +	ICSSG_STATS(rx_multicast_frames, false),

There is a standard stat for mcast.

> +	ICSSG_STATS(rx_crc_errors, true),
> +	ICSSG_STATS(rx_mii_error_frames, false),
> +	ICSSG_STATS(rx_odd_nibble_frames, false),
> +	ICSSG_STATS(rx_frame_max_size, false),
> +	ICSSG_STATS(rx_max_size_error_frames, false),
> +	ICSSG_STATS(rx_frame_min_size, false),
> +	ICSSG_STATS(rx_min_size_error_frames, false),
> +	ICSSG_STATS(rx_over_errors, true),
> +	ICSSG_STATS(rx_class0_hits, false),
> +	ICSSG_STATS(rx_class1_hits, false),
> +	ICSSG_STATS(rx_class2_hits, false),
> +	ICSSG_STATS(rx_class3_hits, false),
> +	ICSSG_STATS(rx_class4_hits, false),
> +	ICSSG_STATS(rx_class5_hits, false),
> +	ICSSG_STATS(rx_class6_hits, false),
> +	ICSSG_STATS(rx_class7_hits, false),
> +	ICSSG_STATS(rx_class8_hits, false),
> +	ICSSG_STATS(rx_class9_hits, false),
> +	ICSSG_STATS(rx_class10_hits, false),
> +	ICSSG_STATS(rx_class11_hits, false),
> +	ICSSG_STATS(rx_class12_hits, false),
> +	ICSSG_STATS(rx_class13_hits, false),
> +	ICSSG_STATS(rx_class14_hits, false),
> +	ICSSG_STATS(rx_class15_hits, false),
> +	ICSSG_STATS(rx_smd_frags, false),
> +	ICSSG_STATS(rx_bucket1_size, false),
> +	ICSSG_STATS(rx_bucket2_size, false),
> +	ICSSG_STATS(rx_bucket3_size, false),
> +	ICSSG_STATS(rx_bucket4_size, false),

Are the bucket sizes configurable? Can we set the bucket sizes
to standard RMON ones and use ethtool RMON stats?

