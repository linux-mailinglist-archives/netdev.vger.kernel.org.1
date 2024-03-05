Return-Path: <netdev+bounces-77334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 060A48714D2
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 05:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10A55B20EFA
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 04:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2E629416;
	Tue,  5 Mar 2024 04:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpTyW3qk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFA129A2
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 04:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709613479; cv=none; b=kk0bp3hnlFHNIrHKLKiwVSa/g/Bjv8+lGH7vnf0BOaOfQVS5zrsjnOn4a1yucn0S7k3YD9WPm4nxo/KkIO20ivn6Kff78iqxsTWh/h0xrF5SFNvex/q/6m9qxHHyu8wJenl0HrTC/l3ADV46UnP4A7gRu+04F+ju8clU0VyynHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709613479; c=relaxed/simple;
	bh=GZLdtY+d88AuME/c0JacyTOzCBzJSWWWPe2iHlLSRMw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m5IXWiUHo522gNVq0j67TLLkjydWe3H4Zr0tRklm/d7+sbS6UtReUVWjGr0bgIBosrCc6D7Jtu7TjbWw8AregnKRj3zSQwJdklQUDhqlsaLRakSu9zGmQoRIeU14Kp/nDA+0+aOarjVG3atPVcgBL7/OuTxUKzLyz1lDmWwuXls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpTyW3qk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E251C433C7;
	Tue,  5 Mar 2024 04:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709613479;
	bh=GZLdtY+d88AuME/c0JacyTOzCBzJSWWWPe2iHlLSRMw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PpTyW3qkcJNgIq68+LbRBDXF6fNrVDf4s+6njTkqOFTXGq3icBRPWrw7/L6rbJvjv
	 5y14EO4xZKuMjTX+A6FtbLKOykzNDaPmngC0O4SAj8OuDq/MX8xzBMKtWb/emFrL1v
	 p2LFOdryd6aJ58WDViQ1hv1dISk51kmwRFfqv2uvxKzZua8F1JXW3lRkmv5bdRgJES
	 6rwLcivkEl8LV8HkpFBNKSgY4zckpIj5CRsRAKyAqheFcqM8fZjhLig8vrWaRmp4Ss
	 73GbfdKG4NRRDsDskWRZXNZRYNpwsLI+ZA9hwWCVtDK9p0Sc0jOFRFXqIVeS0J587B
	 gU0GM0oXvjSmw==
Date: Mon, 4 Mar 2024 20:37:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: William Tu <witu@nvidia.com>
Cc: <netdev@vger.kernel.org>, <jiri@nvidia.com>, <bodong@nvidia.com>,
 <tariqt@nvidia.com>, <yossiku@nvidia.com>
Subject: Re: [PATCH RFC v2 net-next 1/2] devlink: Add shared descriptor
 eswitch attr
Message-ID: <20240304203758.2fd0f6be@kernel.org>
In-Reply-To: <20240301011119.3267-1-witu@nvidia.com>
References: <20240301011119.3267-1-witu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Mar 2024 03:11:18 +0200 William Tu wrote:
> Add two eswitch attrs: shrdesc_mode and shrdesc_count.
> 
> 1. shrdesc_mode: to enable a sharing memory buffer for
> representor's rx buffer, 

Let's narrow down the terminology. "Shared memory buffer"
and "shared memory pool" and "shrdesc" all refer to the same
thing. Let's stick to shared pool?

> and 2. shrdesc_count: to control the
> number of buffers in this shared memory pool.

_default_ number of buffers in shared pool used by representors?

If/when the API to configure shared pools becomes real it will
presumably take precedence over this default?

> When using switchdev mode, the representor ports handles the slow path
> traffic, the traffic that can't be offloaded will be redirected to the
> representor port for processing. Memory consumption of the representor
> port's rx buffer can grow to several GB when scaling to 1k VFs reps.
> For example, in mlx5 driver, each RQ, with a typical 1K descriptors,
> consumes 3MB of DMA memory for packet buffer in WQEs, and with four
> channels, it consumes 4 * 3MB * 1024 = 12GB of memory. And since rep
> ports are for slow path traffic, most of these rx DMA memory are idle.
> 
> Add shrdesc_mode configuration, allowing multiple representors
> to share a rx memory buffer pool. When enabled, individual representor
> doesn't need to allocate its dedicated rx buffer, but just pointing
> its rq to the memory pool. This could make the memory being better
> utilized. The shrdesc_count represents the number of rx ring
> entries, e.g., same meaning as ethtool -g, that's shared across other
> representors. Users adjust it based on how many reps, total system
> memory, or performance expectation.

Can we use bytes as the unit? Like the page pool. Descriptors don't
mean much to the user.

> The two params are also useful for other vendors such as Intel ICE
> drivers and Broadcom's driver, which also have representor ports for
> slow path traffic.
> 
> An example use case:
> $ devlink dev eswitch show pci/0000:08:00.0
>   pci/0000:08:00.0: mode legacy inline-mode none encap-mode basic \
>   shrdesc-mode none shrdesc-count 0
> $ devlink dev eswitch set pci/0000:08:00.0 mode switchdev \
>   shrdesc-mode basic shrdesc-count 1024
> $ devlink dev eswitch show pci/0000:08:00.0
>   pci/0000:08:00.0: mode switchdev inline-mode none encap-mode basic \
>   shrdesc-mode basic shrdesc-count 1024
> 
> Note that new configurations are set at legacy mode, and enabled at
> switchdev mode.

>  Documentation/netlink/specs/devlink.yaml | 17 ++++++++++
>  include/net/devlink.h                    |  8 +++++
>  include/uapi/linux/devlink.h             |  7 ++++
>  net/devlink/dev.c                        | 43 ++++++++++++++++++++++++
>  net/devlink/netlink_gen.c                |  6 ++--
>  5 files changed, 79 insertions(+), 2 deletions(-)

ENODOCS

> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
> index cf6eaa0da821..58f31d99b8b3 100644
> --- a/Documentation/netlink/specs/devlink.yaml
> +++ b/Documentation/netlink/specs/devlink.yaml
> @@ -119,6 +119,14 @@ definitions:
>          name: none
>        -
>          name: basic
> +  -
> +    type: enum
> +    name: eswitch-shrdesc-mode
> +    entries:
> +      -
> +        name: none
> +      -
> +        name: basic

Do we need this knob?
Can we not assume that shared-pool-count == 0 means disabled?
We can always add the knob later if needed, right now it's
just on / off with some less direct names.

>    -
>      type: enum
>      name: dpipe-header-id
> @@ -429,6 +437,13 @@ attribute-sets:
>          name: eswitch-encap-mode
>          type: u8
>          enum: eswitch-encap-mode
> +      -
> +        name: eswitch-shrdesc-mode
> +        type: u8

u32, netlink rounds sizes up to 4B, anyway

> +        enum: eswitch-shrdesc-mode
> +      -
> +        name: eswitch-shrdesc-count
> +        type: u32
>        -
>          name: resource-list
>          type: nest

