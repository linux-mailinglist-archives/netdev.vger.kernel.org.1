Return-Path: <netdev+bounces-118886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BD59536CF
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93FFB1F21751
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF13A1A7076;
	Thu, 15 Aug 2024 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRfbZjeV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E4C19F49C;
	Thu, 15 Aug 2024 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723734861; cv=none; b=VKXPTs1ACgmWHs5MHAnf90Fex0Bxn7+RYeFcoCvlnaLYx4BRT0IOBlDgY3uT5OAubCTVcqGUfofICQ1ExoVZJYSSTJIxNDnHHaNna1Yg11csuY/dac2Ay1SecmcSEajK4ZrpcqD8yQlnOYlHZyh77hQQ0ld4hoj9SsPJZ1prNv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723734861; c=relaxed/simple;
	bh=FNgpL4QvKomdKoPpzz2z+UC5rh2pSU5iv9CfujetvtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcHNz8lDBxl9ZMD/onkuy3BVX2Ns6K3uT0quB8+KH25m5fKDGjrNNs5ZldjNf7XWfjN3tP5qUy3za/f+M40xq7d8HH52myx5x8+zGVY9UJRQgGTyJvnn61I1qDHfgXuDS1FQfkQWmhFfKvIRqPpHt6VzXcotPT9oGxckpZ9v9eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRfbZjeV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9874C32786;
	Thu, 15 Aug 2024 15:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723734861;
	bh=FNgpL4QvKomdKoPpzz2z+UC5rh2pSU5iv9CfujetvtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qRfbZjeVu1rkoB0XPW8l6ToTZ9pBYgdNx1MISgYY0q0+VtS10tO+OCzkGQN68LZOv
	 z3DS4BvzBgzUmJQOgX7zEy+jh1qoLJFpTWwlFrKUtPg5HWks92B14qk5RkdvdrKDmj
	 +i6y092oGQ9a/ow8j1J67EUBDrDqkyZU59zYy77J17lwT4MBhwVQJzaVDl1ntgA9yo
	 RcJIEEhZrMkRQ00KTA9DJNI8D566HWSPvLxRjEnzoJ7/G1OtC/xZE3XNXWMSY/kiZ8
	 KWxiIqXIk9X0ugmi6NA0m8CRAGWP2KWoQUzB/35Ggect2I7jyDiWucsrNiznX1CHft
	 KcNK0rRejC7fw==
Date: Thu, 15 Aug 2024 16:14:15 +0100
From: Simon Horman <horms@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next v2 4/7] net: ti: icssg-prueth: Add support for
 HSR frame forward offload
Message-ID: <20240815151415.GK632411@kernel.org>
References: <20240813074233.2473876-1-danishanwar@ti.com>
 <20240813074233.2473876-5-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813074233.2473876-5-danishanwar@ti.com>

On Tue, Aug 13, 2024 at 01:12:30PM +0530, MD Danish Anwar wrote:

...

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> index f678d656a3ed..40bc3912b6ae 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> @@ -239,6 +239,7 @@ struct icssg_firmwares {
>   * @iep1: pointer to IEP1 device
>   * @vlan_tbl: VLAN-FID table pointer
>   * @hw_bridge_dev: pointer to HW bridge net device
> + * @hsr_dev: pointer to the HSR net device
>   * @br_members: bitmask of bridge member ports
>   * @prueth_netdevice_nb: netdevice notifier block
>   * @prueth_switchdev_nb: switchdev notifier block

I think you also need to add Kernel doc entries for @hsr_members and
@is_hsr_offload_mode.

Flagged by W=1 builds and ./scripts/kernel-doc -none

> @@ -274,11 +275,14 @@ struct prueth {
>  	struct prueth_vlan_tbl *vlan_tbl;
>  
>  	struct net_device *hw_bridge_dev;
> +	struct net_device *hsr_dev;
>  	u8 br_members;
> +	u8 hsr_members;
>  	struct notifier_block prueth_netdevice_nb;
>  	struct notifier_block prueth_switchdev_nb;
>  	struct notifier_block prueth_switchdev_bl_nb;
>  	bool is_switch_mode;
> +	bool is_hsr_offload_mode;
>  	bool is_switchmode_supported;
>  	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
>  	int default_vlan;
> -- 
> 2.34.1
> 

