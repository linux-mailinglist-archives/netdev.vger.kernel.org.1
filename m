Return-Path: <netdev+bounces-250217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 780B2D2527F
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 16:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 475323041932
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 14:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06DA3A35A8;
	Thu, 15 Jan 2026 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlSnY+wN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830D93446D3;
	Thu, 15 Jan 2026 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768489058; cv=none; b=paH7Q23WXcM3lbspBiAYhe7+QT3tqTRE3v+kyR0i+kcFoW1lgCHbVgo2VIxYRO8dH2KlOv+GoSS9JiWvz2H7Jf+vh31KML3y6QSzjK9HUhCLV9sWxWB2+ez6EJBKUKSf84EzZsQ6aVUm45IShu1WN/ZinEieYyRKVHfth50972k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768489058; c=relaxed/simple;
	bh=ikCvdOXi3FprM5XeYlF5j+h1c627PrYNjEIksGSN63U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tn60CgXGkqYRFWs0Mo9yyuRjg1PK+zfqbFHc7x2IDD81lRA10T17zFJwpD1vPRcTU6D35SnaIEr0lwC0eq+0w+3SjzDatTlUjtOL7hA5LOQo9B8nq/zr8ZET2NWWIgTc4rJToXQqXbnD79DcOnwXA4w59ShlF3hvCzDoTv9syjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlSnY+wN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E4AC116D0;
	Thu, 15 Jan 2026 14:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768489057;
	bh=ikCvdOXi3FprM5XeYlF5j+h1c627PrYNjEIksGSN63U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DlSnY+wNH4LqKcXJ2MRlFDUISiNZuAB1mAjqkVlqcJNlJChcmrxrif0kWS5qipu67
	 2fKSrtqHbwKa+0Sj1AzvuOi6VUSeSp8EPTrPcWPvv05faBO5kj9WSgqFfcvxcul46T
	 UAjmlFtBA8IQU2J+jtN6fLMHrSFA0MrX2iuWWPcEUCTN7h011EvACFTlDa/+g5yUdu
	 zYQAoLtyQZOwuW5Ib0NBeZLKrCX1xgJARCcA8rDjXerrSHIMhdnWZsE3Vce1zc/OWO
	 gBo6YXCctfSPvfh5AE0noWgFT8EYR5pejOqHDitfjr9mYV9rUy7a7Q1Expt0Q4yqBX
	 AEMb2yxvonClQ==
Date: Thu, 15 Jan 2026 14:57:32 +0000
From: Simon Horman <horms@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: vadim.fedorenko@linux.dev, jacob.e.keller@intel.com, afd@ti.com,
	pmohan@couthit.com, basharath@couthit.com, vladimir.oltean@nxp.com,
	rogerq@kernel.org, danishanwar@ti.com, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next 1/2] net: ti: icssg-prueth: Add Frame Preemption
 MAC Merge support
Message-ID: <aWkAXHXHHOD9SDBt@horms.kernel.org>
References: <20260107125111.2372254-1-m-malladi@ti.com>
 <20260107125111.2372254-2-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107125111.2372254-2-m-malladi@ti.com>

On Wed, Jan 07, 2026 at 06:21:10PM +0530, Meghana Malladi wrote:
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

...

>  /* The buf includes headroom compatible with both skb and xdpf */
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c

...

> +static int emac_tc_setup_mqprio(struct net_device *ndev, void *type_data)
> +{
> +	struct tc_mqprio_qopt_offload *mqprio = type_data;
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth_qos_mqprio *p_mqprio;
> +	int ret;
> +
> +	if (mqprio->qopt.hw == TC_MQPRIO_HW_OFFLOAD_TCS)
> +		return -EOPNOTSUPP;
> +
> +	if (!mqprio->qopt.num_tc) {
> +		netdev_reset_tc(ndev);
> +		p_mqprio->preemptible_tcs = 0;

Hi MD & Meghana,

p_mqprio is dereferenced here.
But it isn't initialised yet.

Flagged by Clang 21.1.7 W=1 build for arm64.

> +		return 0;
> +	}
> +
> +	ret = prueth_mqprio_validate(ndev, mqprio);
> +	if (ret)
> +		return ret;
> +
> +	p_mqprio = &emac->qos.mqprio;
> +	memcpy(&p_mqprio->mqprio, mqprio, sizeof(*mqprio));
> +	netdev_set_num_tc(ndev, mqprio->qopt.num_tc);
> +
> +	return 0;
> +}

...

