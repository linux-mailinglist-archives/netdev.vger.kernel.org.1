Return-Path: <netdev+bounces-244769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49181CBE611
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 15:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52D283088BA7
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 14:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81CC32BF46;
	Mon, 15 Dec 2025 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCVml93r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7E932936D;
	Mon, 15 Dec 2025 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808904; cv=none; b=cMToac/izdHDTYxSzrMrLbASC4CxC3kM5SOeu4hirPSbgi3Ar7OWfT6neG2gWgi64XriMNNvjzTEH/RUhVL6+40KQZ6Kg9huF2tOUTbIoIfuYMmEWnpBCA7b3GjiDytgEucZclAOFJL9C/B6E3uxZsWXLj3C3+0Tm+xDh5UuRwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808904; c=relaxed/simple;
	bh=DGbhxhBCi2P25vodMBSXEvwNQHtgyOMT7/HM9huN1xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Orq1ahdCSGBBZUfrMZwDdUFHLepRnKDm4zEHgi7CU3h1BNjMc+EgdB6gtCUqDiS+fVWzcK3RPLMW9nxTouhrpSUqZSFsJxgxFCj/pfMztDvs2Eq/WU8pI82crOYzDgyUIyYghFrMmGRC1wbdQ3WgzosXo3j8isvGRsF3u1fqkVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCVml93r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2D1C4CEF5;
	Mon, 15 Dec 2025 14:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765808904;
	bh=DGbhxhBCi2P25vodMBSXEvwNQHtgyOMT7/HM9huN1xU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PCVml93rYj19A2rcJyWtm0rNAD2ud2zXyzXWmwc02QF98zZ+mCIgwwGTE4jnvPcle
	 C4F2eskrG2j3WDF2mVeUzZQa1GDcK/Gqyl7F/sX7L8xMYQI5QVn3C74NcMMbHo2w+E
	 toG37s0VED1bvrJ1QVmbLVw8j6DfdKaw24Q2b/WeT1NHSLQIFFQvCojJHB7os7AKJb
	 hff8GVrksvShAFF4d4zwRcZenq3flScGMg0FCURx4wvKgEPXrXkxXKVrSuGKFdBtC+
	 EZCSMp6sQr1n7G6LgIvGj+koLmvVPvcsDOdtqvWq/9AqyXRkNoJp2zrqfykomGaCoT
	 gIHvgyrvE561g==
Date: Mon, 15 Dec 2025 14:28:17 +0000
From: Simon Horman <horms@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next v3 2/4] net: dsa: add tag formats for
 MxL862xx switches
Message-ID: <aUAbAWUWUyJqACoz@horms.kernel.org>
References: <cover.1765757027.git.daniel@makrotopia.org>
 <de01f08a3c99921d439bc15eeafd94e759688554.1765757027.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de01f08a3c99921d439bc15eeafd94e759688554.1765757027.git.daniel@makrotopia.org>

On Mon, Dec 15, 2025 at 12:11:43AM +0000, Daniel Golle wrote:

...

> diff --git a/net/dsa/tag_mxl862xx.c b/net/dsa/tag_mxl862xx.c
> new file mode 100644
> index 0000000000000..9c5e5f90dcb63
> --- /dev/null
> +++ b/net/dsa/tag_mxl862xx.c
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * DSA Special Tag for MaxLinear 862xx switch chips
> + *
> + * Copyright (C) 2025 Daniel Golle <daniel@makrotopia.org>
> + * Copyright (C) 2024 MaxLinear Inc.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/etherdevice.h>
> +#include <linux/skbuff.h>
> +#include <net/dsa.h>
> +#include "tag.h"
> +
> +#define MXL862_NAME	"mxl862xx"
> +
> +/* To define the outgoing port and to discover the incoming port a special
> + * tag is used by the GSW1xx.
> + *
> + *       Dest MAC       Src MAC    special TAG        EtherType
> + * ...| 1 2 3 4 5 6 | 1 2 3 4 5 6 | 1 2 3 4 5 6 7 8 | 1 2 |...
> + *                                |<--------------->|
> + */
> +
> +#define MXL862_HEADER_LEN 8
> +
> +/* Byte 7 */
> +#define MXL862_IGP_EGP GENMASK(3, 0)
> +
> +static struct sk_buff *mxl862_tag_xmit(struct sk_buff *skb,
> +				       struct net_device *dev)
> +{
> +	struct dsa_port *dp = dsa_user_to_port(dev);
> +	struct dsa_port *cpu_dp = dp->cpu_dp;
> +	unsigned int cpu_port = cpu_dp->index + 1;
> +	unsigned int usr_port = dp->index + 1;
> +	__be16 *mxl862_tag;

Hi Daniel,

Please arrange local variables in reverse xmas tree order.
Even if it means separating declaration and initialisation.

FWIIW, I would probably go for:

	struct dsa_port *dp = dsa_user_to_port(dev);
	struct dsa_port *cpu_dp = dp->cpu_dp;
	unsigned int cpu_port, usr_port;
	__be16 *mxl862_tag;

	cpu_port = cpu_dp->index + 1;
	usr_port = dp->index + 1;

> +
> +	if (!skb)
> +		return skb;
> +
> +	/* provide additional space 'MXL862_HEADER_LEN' bytes */
> +	skb_push(skb, MXL862_HEADER_LEN);
> +
> +	/* shift MAC address to the beginnig of the enlarged buffer,

s/beginnig/beginning/

> +	 * releasing the space required for DSA tag (between MAC address and
> +	 * Ethertype)
> +	 */
> +	dsa_alloc_etype_header(skb, MXL862_HEADER_LEN);
> +
> +	/* special tag ingress */
> +	mxl862_tag = dsa_etype_header_pos_tx(skb);
> +	mxl862_tag[0] = htons(ETH_P_MXLGSW);
> +	mxl862_tag[1] = 0;
> +	mxl862_tag[2] = htons(usr_port + 16 - cpu_port);
> +	mxl862_tag[3] = htons(FIELD_PREP(MXL862_IGP_EGP, cpu_port));
> +
> +	return skb;
> +}

...

