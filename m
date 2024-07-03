Return-Path: <netdev+bounces-108978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5869266AF
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 19:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852C71F217AE
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6816318308B;
	Wed,  3 Jul 2024 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ge1v/Eff"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4123E181B8C;
	Wed,  3 Jul 2024 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026283; cv=none; b=l+Q2yAjPGuqZoFeqNCOlO3iWkzJ0mILkzcMXe61Ik2XTtNW8uSq75i9OV4VweP5veL3mkaf1D+gD/GPo/By71Z9Gx5pJFBiDuOcPfwEd8Ho6EkuN0ObzVLoJgsYII7sSXI9VXcCSHiQfn9e17PQL83LjCMzh+2Gklz4eLCW0x/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026283; c=relaxed/simple;
	bh=eG4hXBWlxUmQ7rJcyBWXvDQU0AevoqNlx1Qhy5g+EE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbFksgY9rXIKnyVQnRLvzOQTK/0kOnzZJT/shrwJu1jX7eBk/Fg8zRXYMETSiiQB+Sxu2LorjM/mPnDnIKr+/QudiuXbB9EI5ZPbDgyGJsIT0XaUhaDS50gPhcIoU9cLKf54kRV8zevhzVCTr3ew8x4wAbFmkNdhhhsNdntIl+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ge1v/Eff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4DEC2BD10;
	Wed,  3 Jul 2024 17:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720026282;
	bh=eG4hXBWlxUmQ7rJcyBWXvDQU0AevoqNlx1Qhy5g+EE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ge1v/Effi/qHdfdWOIVepZTm3dJyNA/Q0U/fw2zXTRez3XIWHCTHYGhYU/Lnku7T2
	 qGrH4Nttmk+UFdbvEUP3+yYi9/aOXsSaRF5mKOMNqCg/JYS30cMcb/6xM3G4lAZ9ul
	 THmmmlY4n9Hp7xAX4g3KMyQ7hpzuNl8Gw//eU5IjGT9tLEZuKsI6toTBoQ/IdLU9nH
	 NOORk6B99titaD2+XyFuW8tWhrmnIpngcsNiqQrZfuMtSEGL825RUVfh9XKywOIXXa
	 RNzbpaJTrFLD03my8riB2kFvyyKSul8HUNImWLjtHz8tm1ZkL9f+cx8jGmjHRA2N9I
	 yp9qdaZ905mZQ==
Date: Wed, 3 Jul 2024 18:04:38 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
	rkannoth@marvell.com, jdamato@fastly.com, pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net-next v22 08/13] rtase: Implement net_device_ops
Message-ID: <20240703170438.GB598357@kernel.org>
References: <20240701115403.7087-1-justinlai0215@realtek.com>
 <20240701115403.7087-9-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701115403.7087-9-justinlai0215@realtek.com>

On Mon, Jul 01, 2024 at 07:53:58PM +0800, Justin Lai wrote:
> 1. Implement .ndo_set_rx_mode so that the device can change address
> list filtering.
> 2. Implement .ndo_set_mac_address so that mac address can be changed.
> 3. Implement .ndo_change_mtu so that mtu can be changed.
> 4. Implement .ndo_tx_timeout to perform related processing when the
> transmitter does not make any progress.
> 5. Implement .ndo_get_stats64 to provide statistics that are called
> when the user wants to get network device usage.
> 6. Implement .ndo_vlan_rx_add_vid to register VLAN ID when the device
> supports VLAN filtering.
> 7. Implement .ndo_vlan_rx_kill_vid to unregister VLAN ID when the device
> supports VLAN filtering.
> 8. Implement the .ndo_setup_tc to enable setting any "tc" scheduler,
> classifier or action on dev.
> 9. Implement .ndo_fix_features enables adjusting requested feature flags
> based on device-specific constraints.
> 10. Implement .ndo_set_features enables updating device configuration to
> new features.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Reviewed-by: Simon Horman <horms@kernel.org>


