Return-Path: <netdev+bounces-233764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4C3C18009
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 03:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86851C23796
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D582820DB;
	Wed, 29 Oct 2025 02:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1IVfK03"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659A513B58C;
	Wed, 29 Oct 2025 02:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761703682; cv=none; b=K+5sb5O7UvqDB+gKc8B2odzgGlFABmFS6lb/L4W5tIYf7Br/S02adFZnbZKscTy/GfFy5WSH9vOFa6hikJwgJVQ0vDtDeLuQU8H3GzHaSXhWfQu72+o0roHwTVCMip67btvoo0OXq0Kecq/Jpj93l0kiu2xik8bQlGCZmOLfl1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761703682; c=relaxed/simple;
	bh=x7M+GHSAVsoCL8DBq5oS9mhQFrezimpsQJKSbDMb0Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e1EcpsI2+R2V9VMnMElE+x6PnqKVkBDEHfOFfZXY1AWJ7e8U7+pm/CtDD1th0THnnc4QBsHyFw7CgwLO3NZvCNSAnDbpLsEdfnLVwwusOs+wrf75Jf235eOTQNASGXqlIXe9DBMvH01G6/AkSlYw5oSWoz4xvkTs/NH2FEAJi1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1IVfK03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D74C4CEE7;
	Wed, 29 Oct 2025 02:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761703681;
	bh=x7M+GHSAVsoCL8DBq5oS9mhQFrezimpsQJKSbDMb0Gc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u1IVfK03hZKQI7NsIO5yORbLzwnlFsm2l7P6fV5SopDDEbyxQztF/FsGChkl1PmOR
	 O18obhqBxxgcmW/fpLgUMEEiZ1nSKnRxADKho0M+Hrr07HhkBQE0I//ZieGQIbyCDg
	 bc9sUqSYK858+pr5heIbd1prRgnz+8+z6/5OcQpGuwmsujZGfUgvkj4zMIR455uHcf
	 krfFAO8pkMUO6LA1jN4xBqLJAdibw6voIbfRJCfrfWLvV4Hy11R4B6o7kXp4nwsdZm
	 iIYELGunUmwsEV09GTyr1048zD93zBD4efqvrGKDwKwpUd3EJOfHfFJ7ypM7NOewRA
	 InGNm5L81k9CA==
Date: Tue, 28 Oct 2025 19:08:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell
 King <linux@armlinux.org.uk>, danishanwar@ti.com, srk@ti.com,
 linux-omap@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 8/9] net: ethernet: ti: am65-cpsw: add
 network flow classification support
Message-ID: <20251028190800.2ee4f80e@kernel.org>
In-Reply-To: <20251024-am65-cpsw-rx-class-v5-8-c7c2950a2d25@kernel.org>
References: <20251024-am65-cpsw-rx-class-v5-0-c7c2950a2d25@kernel.org>
	<20251024-am65-cpsw-rx-class-v5-8-c7c2950a2d25@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Oct 2025 23:46:07 +0300 Roger Quadros wrote:

> +/* rxnfc_lock must be held */
> +static void am65_cpsw_del_rule(struct am65_cpsw_port *port,
> +			       struct am65_cpsw_rxnfc_rule *rule)
> +{
> +	int loc;
> +
> +	/* reverse location as higher locations have higher priority
> +	 * but ethtool expects lower locations to have higher priority
> +	 */
> +	loc = port->rxnfc_max - rule->location - 1;
> +
> +	cpsw_ale_policer_clr_entry(port->common->ale, loc,
> +				   &rule->cfg);
> +	list_del(&rule->list);
> +	port->rxnfc_count--;
> +	port->policer_in_use_bitmask &= ~BIT(rule->location);

__clear_bit()
Please use bitmap helpers everywhere, especially for scanning 
the bitmap to find unused bits

> +	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
> +
> +	switch (rxnfc->cmd) {
> +	case ETHTOOL_GRXRINGS:

please implement ::get_rx_ring_count instead
-- 
pw-bot: cr

