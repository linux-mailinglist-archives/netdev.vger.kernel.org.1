Return-Path: <netdev+bounces-239244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62833C6635F
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 22:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 916A54E7221
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 21:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5626834CFAA;
	Mon, 17 Nov 2025 21:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfesFpQq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A150312812;
	Mon, 17 Nov 2025 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413718; cv=none; b=J10r3x1PPcwVsJIb24ezXYdC54CPOWgRn17hb5Tow77FUgAoSD/QGWFjohmUJVsvGZ0gio/HswApCF9SNePwIxp9m7kXY+n7bYlnBqhYsKyPMmFXqbTjxwkEr20PE7Uc0fHwJ6bL/6qiOZx33NBjFE/bY7pZxNTmxVfg8CLSQ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413718; c=relaxed/simple;
	bh=et//iptFPngI7sYYUefBHRZ7sY39xbXQ7hu+yX8dUcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwIqyEQYpunhP8+P4yIObUe23uqpvmyvVsxWwKMkYtUuwQShTiPn36lDeseTEBkZakQoJcmtQPYToPwrzIXoRHxh7nZSx34wp8kIm86G5YwYRpMLJdfMzIH9zZ7YH+TTLmT+vV7Du6xR6gbevcjE1IsPp4lMDpRWWr/JZJU6H8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfesFpQq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822D7C113D0;
	Mon, 17 Nov 2025 21:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763413717;
	bh=et//iptFPngI7sYYUefBHRZ7sY39xbXQ7hu+yX8dUcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KfesFpQqzx04GaNVMV3gCHnCuhE2/mF+CsDWHYlzMyca+2KsG79h3QrsHDQnPaJb/
	 yd5kOT8reNgPLb5mf6+5SL+NJrtqjO0CIOqn3bzHFlLISXWzLtrM1GRWQU0bzy8Dp9
	 RzRWRQYAMxhNNKs1/ErIdJJzV8Q1Wh1QJjUF2GeHCa97yYFNizZjzE9U05XZG+nnvE
	 UK3PHHrTB22FzuZEU2hfneF9IYhRQ/H1/l7s6VN/rh8Krzd1JhgMcV59dV1BVDMWMk
	 uvh9x3hg60gFCHuaoaXncb1U6ZWTKHVKjruO/gQUW/yahh8XpR8r/Cuexqp6E81feE
	 +YrybfJkIuoew==
Date: Mon, 17 Nov 2025 21:08:29 +0000
From: Simon Horman <horms@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, danishanwar@ti.com,
	rogerq@kernel.org, pmohan@couthit.com, basharath@couthit.com,
	afd@ti.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, alok.a.tiwari@oracle.com,
	pratheesh@ti.com, j-rameshbabu@ti.com, vigneshr@ti.com,
	praneeth@ti.com, srk@ti.com, rogerq@ti.com, krishna@couthit.com,
	mohan@couthit.com
Subject: Re: [PATCH net-next v5 2/3] net: ti: icssm-prueth: Adds switchdev
 support for icssm_prueth driver
Message-ID: <aRuOzelPTiwaoNop@horms.kernel.org>
References: <20251113101229.675141-1-parvathi@couthit.com>
 <20251113101229.675141-3-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113101229.675141-3-parvathi@couthit.com>

On Thu, Nov 13, 2025 at 03:40:22PM +0530, Parvathi Pudi wrote:

...

> @@ -222,12 +229,14 @@ struct prueth_emac {
>  	const char *phy_id;
>  	u32 msg_enable;
>  	u8 mac_addr[6];
> +	unsigned char mc_filter_mask[ETH_ALEN]; /* for multicast filtering */
>  	phy_interface_t phy_if;
>  
>  	/* spin lock used to protect
>  	 * during link configuration
>  	 */
>  	spinlock_t lock;
> +	spinlock_t addr_lock;   /* serialize access to VLAN/MC filter table */

addr_lock does not appear to be initialised anywhere.

...

> +static int icssm_prueth_switchdev_obj_del(struct net_device *ndev,
> +					  const void *ctx,
> +					  const struct switchdev_obj *obj)
> +{
> +	struct switchdev_obj_port_mdb *mdb = SWITCHDEV_OBJ_PORT_MDB(obj);
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth *prueth = emac->prueth;
> +	struct netdev_hw_addr *ha;
> +	u8 hash, tmp_hash;
> +	int ret = 0;
> +
> +	switch (obj->id) {
> +	case SWITCHDEV_OBJ_ID_HOST_MDB:
> +		dev_dbg(prueth->dev, "MDB del: %s: vid %u:%pM  port: %x\n",
> +			ndev->name, mdb->vid, mdb->addr, emac->port_id);
> +		hash = icssm_emac_get_mc_hash(mdb->addr, emac->mc_filter_mask);
> +		netdev_for_each_mc_addr(ha, prueth->hw_bridge_dev) {

Is there anything stopping this event from occurring when
the port is not the lower device of a bridge - before being added
or after being removed?

If not, then passing prueth->hw_bridge_dev to netdev_for_each_mc_addr()
will result in a null pointer dereference.

...

