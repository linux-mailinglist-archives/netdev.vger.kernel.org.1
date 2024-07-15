Return-Path: <netdev+bounces-111479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CB993147F
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 14:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388251F225F1
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 12:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE63018C199;
	Mon, 15 Jul 2024 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlCT+jqe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA64D4C66
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721047166; cv=none; b=j0fz0JM0dwU1PEc9xY+7HLaVSA2ruaPe0YgRnWfUKqI4O8i6tSvfiDyjGabIJaveq+vLWPqCI/KpuCYfWDx2L89iTlhJdi+xwQ3i41YsVYt8NipetUstEtcjwXepd5+EtOaPMB0MnmJiDuaXZHyE/xi37BtLuf2nGnLLBmtQAq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721047166; c=relaxed/simple;
	bh=OQ3e44CBQLNh64zML8893FYmghmT7vnAyPPNVRvRj+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKbq/eWCR1Ye/zm9oejxkFElYG2X14J52XYCnsLCReJIq97bER9/uw3HhxybPskFs6f9V+VbXH2Io8Wl4KmtsN/PvIzwczZaNwv+tTfFPcO8YI9p8K4nQhtIUMdCejEbZvau/un4K8m2cVSysE0W7iWRmJbhT/nKHbDBMIddtvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlCT+jqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BF1C32782;
	Mon, 15 Jul 2024 12:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721047166;
	bh=OQ3e44CBQLNh64zML8893FYmghmT7vnAyPPNVRvRj+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZlCT+jqe9fHkKSTqRqCeqef82dJ1fqbW+eI2oJGGPzHfNIeHu4tzEgzXBxkqCR0rw
	 T5taRIaub2QvZ76gepUx46jnK49YtrXc8mEGniThngNLDc4OEa6aBmVQ5RPhJvysUj
	 ZJgE+sEz+LZmFls3Df/WzEw/UUNas2dsTAoXHFJSZe3AvsZFQoqG20o6BG8z4C4rN9
	 pVkdj4p5cKy1I3kKw7ddh5wavKFLw2TIhnE5iZv3o5Vuqj/MgmzUOCGCkqsfD4LGcr
	 NtMjSRNbCA3tuPV5IMdWdYUPs3gsLpp9D7RoW9DnplREgEFaHbrt7rDy2TE6guyuLt
	 EosHJWaotZqEw==
Date: Mon, 15 Jul 2024 13:39:23 +0100
From: Simon Horman <horms@kernel.org>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v5 08/17] xfrm: iptfs: add new iptfs xfrm mode
 impl
Message-ID: <20240715123923.GB45692@kernel.org>
References: <20240714202246.1573817-1-chopps@chopps.org>
 <20240714202246.1573817-9-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240714202246.1573817-9-chopps@chopps.org>

On Sun, Jul 14, 2024 at 04:22:36PM -0400, Christian Hopps wrote:
> From: Christian Hopps <chopps@labn.net>
> 
> Add a new xfrm mode implementing AggFrag/IP-TFS from RFC9347.
> 
> This utilizes the new xfrm_mode_cbs to implement demand-driven IP-TFS
> functionality. This functionality can be used to increase bandwidth
> utilization through small packet aggregation, as well as help solve PMTU
> issues through it's efficient use of fragmentation.
> 
>   Link: https://www.rfc-editor.org/rfc/rfc9347.txt
> 
> Multiple commits follow to build the functionality into xfrm_iptfs.c
> 
> Signed-off-by: Christian Hopps <chopps@labn.net>
> ---
>  net/xfrm/Makefile     |   1 +
>  net/xfrm/xfrm_iptfs.c | 206 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 207 insertions(+)
>  create mode 100644 net/xfrm/xfrm_iptfs.c
> 
> diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
> index 512e0b2f8514..5a1787587cb3 100644
> --- a/net/xfrm/Makefile
> +++ b/net/xfrm/Makefile
> @@ -21,5 +21,6 @@ obj-$(CONFIG_XFRM_USER) += xfrm_user.o
>  obj-$(CONFIG_XFRM_USER_COMPAT) += xfrm_compat.o
>  obj-$(CONFIG_XFRM_IPCOMP) += xfrm_ipcomp.o
>  obj-$(CONFIG_XFRM_INTERFACE) += xfrm_interface.o
> +obj-$(CONFIG_XFRM_IPTFS) += xfrm_iptfs.o
>  obj-$(CONFIG_XFRM_ESPINTCP) += espintcp.o
>  obj-$(CONFIG_DEBUG_INFO_BTF) += xfrm_state_bpf.o
> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> new file mode 100644
> index 000000000000..414035a7a208
> --- /dev/null
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ -0,0 +1,206 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* xfrm_iptfs: IPTFS encapsulation support
> + *
> + * April 21 2022, Christian Hopps <chopps@labn.net>
> + *
> + * Copyright (c) 2022, LabN Consulting, L.L.C.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/icmpv6.h>
> +#include <net/gro.h>
> +#include <net/icmp.h>
> +#include <net/ip6_route.h>
> +#include <net/inet_ecn.h>
> +#include <net/xfrm.h>
> +
> +#include <crypto/aead.h>
> +
> +#include "xfrm_inout.h"
> +
> +struct xfrm_iptfs_config {
> +	u32 pkt_size;	    /* outer_packet_size or 0 */
> +};
> +
> +struct xfrm_iptfs_data {
> +	struct xfrm_iptfs_config cfg;
> +
> +	/* Ingress User Input */
> +	struct xfrm_state *x;	    /* owning state */
> +	u32 payload_mtu;	    /* max payload size */
> +};
> +
> +/* ========================== */
> +/* State Management Functions */
> +/* ========================== */
> +
> +/**
> + * iptfs_get_inner_mtu() - return inner MTU with no fragmentation.
> + * @x: xfrm state.
> + * @outer_mtu: the outer mtu
> + */

Hi Christian,

Please consider including a "Return:" or "Returns:" section
in the Kernel doc for functions that return values.

Likewise elsewhere in this patchset.

Flagged by: ./scripts/kernel-doc -none -Wall

> +static u32 iptfs_get_inner_mtu(struct xfrm_state *x, int outer_mtu)

...

