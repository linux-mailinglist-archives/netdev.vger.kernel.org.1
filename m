Return-Path: <netdev+bounces-128760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC38297B886
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 09:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43E78B21816
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 07:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859BF165F04;
	Wed, 18 Sep 2024 07:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFG6JUTG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D850273DC;
	Wed, 18 Sep 2024 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726644553; cv=none; b=Op9cflTGvgKj3M5nf3LvnLl1MY+tzMPEM3G1KFuj9SZOSyQzk/P4nTt+1LAv+SnmXrC51S8+xgGLPskGBB6TkqnuLz/hOoexrQa+N7hxrIGcU6rxETru0wrXaery4q9UgVuqpgtC6Bo0e4eTcTFwUtv/ztuAZut99Ldpw4XAtLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726644553; c=relaxed/simple;
	bh=Qzi8RKheJD4aU+pdRmw0bFCBZCU+kkF86nWPHdYqM2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyM8bYW0YyCEmF/30+cQJ8Ad7dJwSAYA+M12Ry9IuQL7X+iPzZMKTFNpuJer8wmi3VaQTuUUTW3uSueJBlxzVbQWYWbXg6wKg9QUCOPvayNYsokEpYp8T5fJxbttTwJx+/KP8+Ol603vkbqENj4dV/kLpnpar5RWSTxKkMCQgvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFG6JUTG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D26C4CECD;
	Wed, 18 Sep 2024 07:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726644552;
	bh=Qzi8RKheJD4aU+pdRmw0bFCBZCU+kkF86nWPHdYqM2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OFG6JUTGTqJsIde723lJVYUq1IBodLCwPwckCGqvRK2yvYBRpSnO8Oaa9H2l+8k4L
	 K5bQS2V0VT+C7/XbsGSWe+LjPBjmXenY4kbxdan2h+LkbJBfXTg1AriTkFaIfTgOqQ
	 nqv4YGQeMjD8F7cf8117O7Lv6d8Su07pvE2gFho6PExz3b6GvQrkVBd9OZp6mDwodI
	 IYPHpO1XYAMgcRrOn8T2LDCTFXATodvCzOOar3WZ4gj+BeJmlVjRanD3WSsOyraVla
	 HDt0pgWDuUDO0+gTOMr7HHmk7IHCccTspTpJC7Xek44gtoFSwuvUIS4fKmnE6xponf
	 aZIGyOR5k2lJQ==
Date: Wed, 18 Sep 2024 08:29:09 +0100
From: Simon Horman <horms@kernel.org>
To: Ronak Doshi <ronak.doshi@broadcom.com>
Cc: netdev@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] vmxnet3: support higher link speeds from
 vmxnet3 v9
Message-ID: <20240918072909.GT167971@kernel.org>
References: <20240917225947.23742-1-ronak.doshi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917225947.23742-1-ronak.doshi@broadcom.com>

On Tue, Sep 17, 2024 at 03:59:46PM -0700, Ronak Doshi wrote:
> Until now, vmxnet3 was default reporting 10Gbps as link speed.
> Vmxnet3 v9 adds support for user to configure higher link speeds.
> User can configure the link speed via VMs advanced parameters options
> in VCenter. This speed is reported in gbps by hypervisor.
> 
> This patch adds support for vmxnet3 to report higher link speeds and
> converts it to mbps as expected by Linux stack.
> 
> Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
> Acked-by: Guolin Yang <guolin.yang@broadcom.com>
> ---
>  drivers/net/vmxnet3/vmxnet3_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
> index b70654c7ad34..bb514b72c8b5 100644
> --- a/drivers/net/vmxnet3/vmxnet3_drv.c
> +++ b/drivers/net/vmxnet3/vmxnet3_drv.c
> @@ -201,6 +201,8 @@ vmxnet3_check_link(struct vmxnet3_adapter *adapter, bool affectTxQueue)
>  
>  	adapter->link_speed = ret >> 16;
>  	if (ret & 1) { /* Link is up. */

Hi Ronak,

I think it would be nice to add a comment regarding the logic added below,
particularly the inequality.  It took me more than one reading to
understand it in the presence of the patch description. I expected may have
remained a mystery without some accompanying text.

> +		if (VMXNET3_VERSION_GE_9(adapter) && adapter->link_speed < 10000)

Please consider limiting Networking code to 80 columns wide where it
can trivially be achieved, as appears to be the case here.

checkpatch can be run with an option to flag this.

> +			adapter->link_speed = adapter->link_speed * 1000;

>  		netdev_info(adapter->netdev, "NIC Link is Up %d Mbps\n",
>  			    adapter->link_speed);
>  		netif_carrier_on(adapter->netdev);

net-next is currently closed for the v6.12 merge window.
Please repost this patch after it reopens, which will be after
v6.12-rc1 is released, most likely a little under two weeks from now.

-- 
pw-bot: changes-requested

