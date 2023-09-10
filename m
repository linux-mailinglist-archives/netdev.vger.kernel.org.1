Return-Path: <netdev+bounces-32734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8039D799EC2
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 17:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5871C20506
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 15:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBB779D7;
	Sun, 10 Sep 2023 15:04:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C491D2586
	for <netdev@vger.kernel.org>; Sun, 10 Sep 2023 15:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07270C433C8;
	Sun, 10 Sep 2023 15:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694358247;
	bh=cJBelSkt6YU5+Pe0SigO495hI7+BDh2yPucVWdt/8JY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HwmyS0nY7on0/YMi1AXOdOOzDsdX8XaOTMkt9QlECR8qFb1EV8f9zJFk2rTNmY12T
	 p2ukMoWaVVVlaREg4nKw5TQ7VShCDwcPiHOdeBVL8Fo9hqhDOfxMO2SST/vWqLbK8e
	 13ocJTRNDS36MgU7rECL7fbOT5ns+cEr8o5FZIqAJKKtvVmCinFKpS41TKojYEKFT0
	 YCXXlipBVsORkHptmjv+22SRNqIsbojw0fZQypwuQkr9RxxgJf706tYLUPjT2C8Wl8
	 reF1bGAZSjY+dPqDdRENAOZZ26Qu+YW/3MbQUl4AvOr/1CQpVVMm674nJa688/KDH2
	 k2bCIqeJdzmsw==
Date: Sun, 10 Sep 2023 17:04:02 +0200
From: Simon Horman <horms@kernel.org>
To: Ciprian Regus <ciprian.regus@analog.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Lennart Franzen <lennart@lfdomain.com>, netdev@vger.kernel.org
Subject: Re: [net] net:ethernet:adi:adin1110: Fix forwarding offload
Message-ID: <20230910150402.GH775887@kernel.org>
References: <20230908125813.1715706-1-ciprian.regus@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908125813.1715706-1-ciprian.regus@analog.com>

On Fri, Sep 08, 2023 at 03:58:08PM +0300, Ciprian Regus wrote:
> Currently, when a new fdb entry is added (with both ports of the
> ADIN2111 bridged), the driver configures the MAC filters for the wrong
> port, which results in the forwarding being done by the host, and not
> actually hardware offloaded.
> 
> The ADIN2111 offloads the forwarding by setting filters on the
> destination MAC address of incoming frames. Based on these, they may be
> routed to the other port. Thus, if a frame has to be forwarded from port
> 1 to port 2, the required configuration for the ADDR_FILT_UPRn register
> should set the APPLY2PORT1 bit (instead of APPLY2PORT2, as it's
> currently the case).
> 
> Fixes: bc93e19d088b ("net: ethernet: adi: Add ADIN1110 support")
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>

I think the subject prefix might be better written as:
'net: ethernet: adi: adin1110: '.
But that notwithstanding this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


