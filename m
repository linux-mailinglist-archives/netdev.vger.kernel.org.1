Return-Path: <netdev+bounces-157141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C08A08FF2
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 13:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3403E3A3FD1
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 12:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA89205AB0;
	Fri, 10 Jan 2025 12:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4g7hBZR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C986219ABDE
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 12:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736510641; cv=none; b=MRgnObwql9Cv6/OZuUtoHn8kgBmcG9UBas4hezBhdpq9j11Z8VVq1FMhGMaUA4Z0TS2LkHGmm6ramrpWo9xbULhy6DCUVxWLaSyOEzcsHP75UjWXtzFu4rO4v7K4Iswtgz6EeJvQaxTzDITYPVhP2WFE4iNokwiH1Xmtc+/IID8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736510641; c=relaxed/simple;
	bh=eRzXOvHtlZRhcg30HnPSlmaL1/PDVL+/4kV4bJ7Ymnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Whlb6pOPf5hh5LMF2g3aNZyIgE7+pEL7edowx04kpq4whhqXgd23sShmHZ5m5a1+KL0HR0FzA0JRXmzK+DhLCFsr8sKMJN25GjcpuQhoWPo7KkKr88Y7P9WIb0mqy/7DPuZxlAjapNFpFGmdR75hPxfAi0n3XZXhtZtXQmxlAgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4g7hBZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910D5C4CED6;
	Fri, 10 Jan 2025 12:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736510641;
	bh=eRzXOvHtlZRhcg30HnPSlmaL1/PDVL+/4kV4bJ7Ymnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f4g7hBZRLP5YLSVBQVBZwAsfAXdXoLRWkHi0wmCKqJ+vg1qomSuuP+WzlyWtP8snu
	 pPkrt8dMh9Q5I2sfXKbPDtNGYJuy6xZlu64fM3gI7Qdnl0d4z7NxFgNeebsRndP+cl
	 tbrsDRxHscY5e7rbFxZGIXsUJpYbqoEfUm/iBP2sEavGaqOmfU1q2OfA2QLdt86z1P
	 M0zyEe7s/6C+ws8nXbPvIIyxYOlMVr7/cQr5IoU4qlewXOsymjadOzNzTMvtpsIYof
	 PFo90WMhYCiR9cNxFRqncZixd3SykflaPN8ty+mKxIuHBfJK1zNJTui06bOPWsp3E8
	 MzooKgYORFgyQ==
Date: Fri, 10 Jan 2025 12:03:57 +0000
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 1/2] net: txgbe: Add basic support for new AML
 devices
Message-ID: <20250110120357.GD7706@kernel.org>
References: <20250110084249.2129839-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110084249.2129839-1-jiawenwu@trustnetic.com>

On Fri, Jan 10, 2025 at 04:42:48PM +0800, Jiawen Wu wrote:
> There is a new 25/10 Gigabit Ethernet device.
> 
> To support basic functions, PHYLINK is temporarily skipped as it is
> intended to implement these configurations in the firmware. And the
> associated link IRQ is also skipped.
> 
> And Implement the new SW-FW interaction interface, which use 64 Byte
> message buffer.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

...

> @@ -2719,7 +2730,7 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
>  
>  	netdev->features = features;
>  
> -	if (wx->mac.type == wx_mac_sp && changed & NETIF_F_HW_VLAN_CTAG_RX)
> +	if (changed & NETIF_F_HW_VLAN_CTAG_RX && wx->do_reset)
>  		wx->do_reset(netdev);

Hi Jiawen Wu,

Here it is assumed that wx->do_reset may be NULL.  But there is an existing
call to wx->do_reset(), near the end of this function, that is not
conditional on wx->do_reset being non-NULL.  This does not seem consistent.

Flagged by Smatch.

>  	else if (changed & (NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_CTAG_FILTER))
>  		wx_set_rx_mode(netdev);

...

-- 
pw-bot: changes-requested

