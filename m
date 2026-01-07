Return-Path: <netdev+bounces-247822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF3ACFEFBC
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 18:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0797835D8F9E
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 16:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066433A7F6F;
	Wed,  7 Jan 2026 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dn+EQqKn"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1179639B497
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767803599; cv=none; b=TsI8URVcZf5PhtBY77d3TdP7CY9K3AXb7cxhMhQoX+AtKi9CfqbJlGcpq0FShg80deCUuuGZ8qQIkef2MaITQSh4lqSsKugDKvj6T9sQcqIbrSQNAa3TQY4WXSOTRZrvObUt1dxMbaWtpvGNRLQbR3y2gc8PFvD5Omw5Q597HKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767803599; c=relaxed/simple;
	bh=6rfQSbtDvJyNdLjzZB9S/VXqYVh1Q+oBgdtCYo6Cml8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EYbOd852bH870l/hs3PxC0Hns89s/wbLae5CS+VpWxg0jEEeDDZ3v38F+VcCNYIpTzVMPNgQLMBwPaRg7m7rDzCMj+SNb2Bs0m/ZcgyxT+EiuTZXxLyp+eDLOzY2mXx4OKAKwRMr6UYjcAJZ+kYha62mHZZakmo8UnkhLmvVTK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dn+EQqKn; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ac64856a-d283-4f06-b334-f0bb5013a865@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767803577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=61A7r253e06+u+rNHIvmt1qtEkkPMc45kP4G79SpTyE=;
	b=dn+EQqKn9gK/JnEb03wgeWezRIzXs4T4rb3GzcRKMuUmuQ71nKxGRS+0KCP+LlZ8X8Hd9e
	GSXWm2ZGoCYMDleeey3p1juY6ygv5+qoTaG9cYLcN+iIV/Zgn9z7njQK4WVdrN7KFHcz1/
	GNexM9fuNDvC8QIfZC6u9jdc2E3aemI=
Date: Wed, 7 Jan 2026 16:32:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/2] net: ti: icssg-prueth: Add Frame Preemption
 MAC Merge support
To: Meghana Malladi <m-malladi@ti.com>, horms@kernel.org,
 jacob.e.keller@intel.com, afd@ti.com, pmohan@couthit.com,
 basharath@couthit.com, vladimir.oltean@nxp.com, rogerq@kernel.org,
 danishanwar@ti.com, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <20260107125111.2372254-1-m-malladi@ti.com>
 <20260107125111.2372254-2-m-malladi@ti.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260107125111.2372254-2-m-malladi@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 07/01/2026 12:51, Meghana Malladi wrote:
> This patch adds utility functions to configure firmware to enable
> IET FPE. The highest priority queue is marked as Express queue and
> lower priority queues as pre-emptable, as the default configuration
> which will be overwritten by the mqprio tc mask passed by tc qdisc.
> Driver optionally allow configure the Verify state machine in the
> firmware to check remote peer capability. If remote fails to respond
> to Verify command, then FPE is disabled by firmware and TX FPE active
> status is disabled.
> 
> This also adds the necessary hooks to enable IET/FPE feature in ICSSG
> driver. IET/FPE gets configured when Link is up and gets disabled when link
> goes down or device is stopped.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> ---
>   drivers/net/ethernet/ti/Makefile             |   2 +-
>   drivers/net/ethernet/ti/icssg/icssg_prueth.c |   9 +
>   drivers/net/ethernet/ti/icssg/icssg_prueth.h |   2 +
>   drivers/net/ethernet/ti/icssg/icssg_qos.c    | 319 +++++++++++++++++++
>   drivers/net/ethernet/ti/icssg/icssg_qos.h    |  48 +++
>   5 files changed, 379 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
>   create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h
> 
> diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
> index 93c0a4d0e33a..2f588663fdf0 100644
> --- a/drivers/net/ethernet/ti/Makefile
> +++ b/drivers/net/ethernet/ti/Makefile
> @@ -35,7 +35,7 @@ ti-am65-cpsw-nuss-$(CONFIG_TI_K3_AM65_CPSW_SWITCHDEV) += am65-cpsw-switchdev.o
>   obj-$(CONFIG_TI_K3_AM65_CPTS) += am65-cpts.o
>   
>   obj-$(CONFIG_TI_ICSSG_PRUETH) += icssg-prueth.o icssg.o
> -icssg-prueth-y := icssg/icssg_prueth.o icssg/icssg_switchdev.o
> +icssg-prueth-y := icssg/icssg_prueth.o icssg/icssg_switchdev.o icssg/icssg_qos.o
>   
>   obj-$(CONFIG_TI_ICSSG_PRUETH_SR1) += icssg-prueth-sr1.o icssg.o
>   icssg-prueth-sr1-y := icssg/icssg_prueth_sr1.o
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index f65041662173..668177eba3f8 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -378,6 +378,12 @@ static void emac_adjust_link(struct net_device *ndev)
>   		} else {
>   			icssg_set_port_state(emac, ICSSG_EMAC_PORT_DISABLE);
>   		}
> +
> +		if (emac->link) {
> +			icssg_qos_link_up(ndev);
> +		} else {
> +			icssg_qos_link_down(ndev);
> +		}

I believe this chunk can be incorporated into if-statement right above

>   	}
>   
>   	if (emac->link) {

[...]

