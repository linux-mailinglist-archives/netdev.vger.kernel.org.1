Return-Path: <netdev+bounces-49663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021BF7F2FF0
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 14:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B174F282B51
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 13:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A8954F82;
	Tue, 21 Nov 2023 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBlZrkGQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73CE53818
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 13:55:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B47C433C7;
	Tue, 21 Nov 2023 13:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700574956;
	bh=foz5FNq/8MrqFI76R9JfR0GGlNAVOFYomFtBVuyfcCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nBlZrkGQW6DqsJNma9NHSyKzM1SpiUVNX6tAJHiyEjMchb+y16sZV+rwsBIUYZR/b
	 SdDXdeb8nQXfAYRMCafExEDpxCOaSqCvpGWiBefPOMHKna9zevbgY1Xymyfn0lCwwP
	 Tg+kupeNyndc9BFdIu2t49YY/pcXYJcKt9Lv6mQ+1PMZ+RgIT6zQfZk/kAc5hnuGNW
	 3Pq5sdvsb4i/XSH+pzeT8HmdhUGm3VlBdEyQZGMWWxt+dJ2My4xTBwfx0jlLUR/7RY
	 +rrekn76nh1OYqLWJMX6XEoDWvYaKuRfl1ak204UCNI7mR3HGYkJ7gNI6/chUov1So
	 3GZgYm0taHMPQ==
Date: Tue, 21 Nov 2023 13:55:51 +0000
From: Simon Horman <horms@kernel.org>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, wojciech.drewek@intel.com, bigeasy@linutronix.de,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, srk@ti.com
Subject: Re: [PATCH net-next v2] net: hsr: Add support for MC filtering at
 the slave device
Message-ID: <20231121135551.GB269041@kernel.org>
References: <20231121053753.32738-1-r-gunasekaran@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121053753.32738-1-r-gunasekaran@ti.com>

On Tue, Nov 21, 2023 at 11:07:53AM +0530, Ravi Gunasekaran wrote:
> From: Murali Karicheri <m-karicheri2@ti.com>
> 
> When MC (multicast) list is updated by the networking layer due to a
> user command and as well as when allmulti flag is set, it needs to be
> passed to the enslaved Ethernet devices. This patch allows this
> to happen by implementing ndo_change_rx_flags() and ndo_set_rx_mode()
> API calls that in turns pass it to the slave devices using
> existing API calls.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
> Changes since v1:
> * Renamed "hsr_ndo_set_rx_mode" to "hsr_set_rx_mode" based on Wojciech's comment
> * Picked up Wojciech's Reviewed-by tag from v1
> * Rebased to tip of linux-next
> 
> v1: https://lore.kernel.org/netdev/20231120110105.18416-1-r-gunasekaran@ti.com/

Thanks Ravi,

I confirm that the review of v1 has been addressed.
This patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

