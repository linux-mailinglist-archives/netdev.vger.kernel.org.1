Return-Path: <netdev+bounces-110770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A8492E3C9
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 11:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4DEE1C20E75
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 09:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1B91553BC;
	Thu, 11 Jul 2024 09:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSVUouXE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277E5155CA5
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720691534; cv=none; b=c7z+n5XmZWwaZI6allcsvuJM8wQl/Mg6S6vdFntTW39gZRM2MklzMsN4G39646EAz8Mekn5HblSy8tKHIMx74kLrWbLEOpiF0pZ8Clki7bXsE4TpVuaxeTCvCGPm0GtYSjA4WOjz4AsZn224nFGegDaqkr1OD3wsrLjNnAPK4IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720691534; c=relaxed/simple;
	bh=Fu35hxmDR9Gq3xD8lJA5i7ke7At3NG9zw26Lz8MwLCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpJZ9K5zcQybc0KqIhkea3OmSvtoRkyKaNgkn/qbqU1I22BaDhIIryZUlPEUOqrvHNlrnQmt1WDi+QsiPDqv8QeILfNvkOILFjkD5GkOSJam9S5gtA54FKSML9X4WqXEE9+xu8fUoQYKRuF3ks7mz5Q6dCUwuWTw5y2OKenYwjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSVUouXE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3BFC116B1;
	Thu, 11 Jul 2024 09:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720691533;
	bh=Fu35hxmDR9Gq3xD8lJA5i7ke7At3NG9zw26Lz8MwLCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LSVUouXEYuXgWD50KbxbnQhBPULy5AwIqvwg5rjQsqXXrfgD+4uxIP9KiQwXlbtUE
	 ENMujl5vk8P28+zjdUxK+tJPpC0QoSSojA66yZdu3upXWeV1qFCnmmhftDigveci+W
	 WJ+QKq56RfKSF3kUjgr97LHtpFLv1okoINDaunmE+dr9n4/2fL9MVQ8QcVhmNs5vvL
	 WbSse+Rzr6uVhwk2EucuttUAJze/I2v4amYWP5e7jIeIwaBqPkgBdNPsqOiyHgHolS
	 ztZVHwyHhvPoJg2IWAfAerbnDxskYjYHwclcQ4aBVlMpyjKc+ZA0HcbNSgRfg4bD09
	 2eDyEEqDq75OQ==
Date: Thu, 11 Jul 2024 12:52:08 +0300
From: Leon Romanovsky <leon@kernel.org>
To: steffen.klassert@secunet.com
Cc: Mike Yu <yumike@google.com>, netdev@vger.kernel.org,
	stanleyjhu@google.com, martinwu@google.com,
	chiachangwang@google.com
Subject: Re: [PATCH ipsec v3 0/4] Support IPsec crypto offload for IPv6 ESP
 and IPv4 UDP-encapsulated ESP data paths
Message-ID: <20240711095208.GN6668@unreal>
References: <20240710111654.4085575-1-yumike@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710111654.4085575-1-yumike@google.com>

On Wed, Jul 10, 2024 at 07:16:50PM +0800, Mike Yu wrote:
> Currently, IPsec crypto offload is enabled for GRO code path. However, there
> are other code paths where the XFRM stack is involved; for example, IPv6 ESP
> packets handled by xfrm6_esp_rcv() in ESP layer, and IPv4 UDP-encapsulated
> ESP packets handled by udp_rcv() in UDP layer.
> 
> This patchset extends the crypto offload support to cover these two cases.
> This is useful for devices with traffic accounting (e.g., Android), where GRO
> can lead to inaccurate accounting on the underlying network. For example, VPN
> traffic might not be counted on the wifi network interface wlan0 if the packets
> are handled in GRO code path before entering the network stack for accounting.
> 
> Below is the RX data path scenario the crypto offload can be applied to.
> 
>   +-----------+   +-------+
>   | HW Driver |-->| wlan0 |--------+
>   +-----------+   +-------+        |
>                                    v
>                              +---------------+   +------+
>                      +------>| Network Stack |-->| Apps |
>                      |       +---------------+   +------+
>                      |             |
>                      |             v
>                  +--------+   +------------+
>                  | ipsec1 |<--| XFRM Stack |
>                  +--------+   +------------+
> 
> v2 -> v3:
> - Correct ESP seq in esp_xmit().
> v1 -> v2:
> - Fix comment style.
> 
> Mike Yu (4):
>   xfrm: Support crypto offload for inbound IPv6 ESP packets not in GRO
>     path
>   xfrm: Allow UDP encapsulation in crypto offload control path
>   xfrm: Support crypto offload for inbound IPv4 UDP-encapsulated ESP
>     packet
>   xfrm: Support crypto offload for outbound IPv4 UDP-encapsulated ESP
>     packet
> 
>  net/ipv4/esp4.c         |  8 +++++++-
>  net/ipv4/esp4_offload.c | 17 ++++++++++++++++-
>  net/xfrm/xfrm_device.c  |  6 +++---
>  net/xfrm/xfrm_input.c   |  3 ++-
>  net/xfrm/xfrm_policy.c  |  5 ++++-
>  5 files changed, 32 insertions(+), 7 deletions(-)

Steffen,

If it helps, we tested v2 version and it didn't break anything for us :).
But we didn't test this specific functionality.

Thanks

> 
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 
> 

