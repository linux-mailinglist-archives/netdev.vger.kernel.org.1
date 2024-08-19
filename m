Return-Path: <netdev+bounces-119754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A62956D75
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 16:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985421C22CC7
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 14:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2F7171E55;
	Mon, 19 Aug 2024 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfh57Gcr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A4C171E40
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724078278; cv=none; b=djiDTFr/RCB4KLpDr3oNTNgutm5HFZxQbF0ymasFjANq2Tlt5FzewvheWro6FGdMo/w3EKv2qzB5TAyGAURpN+qMZhl29y2O9JXw+0VIiUFmfYDlSAoSJN6UB/KJ10pp48Jm6pqdYB/N6DLa7kETQOzBGD3c3F6PJvFzM/3Gch0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724078278; c=relaxed/simple;
	bh=vEniP9l6jsZ2mPP5VixL2Y1LE3rQ2K1LaKUJU0RGhfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9NikTB+CEYmaPzKffOjicfKLbquYBMt2rdIwm0fyxXj7n0EPgvLQGsvItwBHr4TO676fvt8wF8x1Ik59rvSGciS93C+FL//E+RlQvk6lXkEfnc5iHpXoEkF2QbARk1WIL+AA77XqkpHdMHkUyvrEXrdCKlA2yDw3GlCQesuNiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfh57Gcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF96C32782;
	Mon, 19 Aug 2024 14:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724078278;
	bh=vEniP9l6jsZ2mPP5VixL2Y1LE3rQ2K1LaKUJU0RGhfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mfh57GcrPY9teLAkP0obWwqLXJtSX3FadnRKu47WgnhVOrdBtRDQHBKIT12uBvx35
	 oybArTdAFh/IkrAksMhIVqJfEzUzqIvFwcsGjO+ET6zSqPQ6x11R/mnG261gStfSlU
	 tguN6y4YOpzSaMZLaQGB0066rBiGJPPDHjvkyFL0MYN3fubo42ixXc8EAZ5Qch7fZl
	 Fx4xCkdI8L/C3KO+pTwGQGPcsP8KLaKSgDie9cbvq/+hB2rvLqO2VmUBH0h2TOQCYo
	 ZxXKRcPx1qKdC+C0dYO92xTRfvU7wB931T992u0t6NDTRTibW/cVUgCn7GkPQQThUn
	 sTZQc1ORvpAng==
Date: Mon, 19 Aug 2024 15:37:53 +0100
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCHv2 net-next 1/3] bonding: add common function to check
 ipsec device
Message-ID: <20240819143753.GF11472@kernel.org>
References: <20240819075334.236334-1-liuhangbin@gmail.com>
 <20240819075334.236334-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819075334.236334-2-liuhangbin@gmail.com>

On Mon, Aug 19, 2024 at 03:53:31PM +0800, Hangbin Liu wrote:
> This patch adds a common function to check the status of IPSec devices.
> This function will be useful for future implementations, such as IPSec ESN
> and state offload callbacks.
> 
> Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c | 43 +++++++++++++++++++++++----------
>  1 file changed, 30 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index f9633a6f8571..250a2717b4e9 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -418,6 +418,34 @@ static int bond_vlan_rx_kill_vid(struct net_device *bond_dev,
>  /*---------------------------------- XFRM -----------------------------------*/
>  
>  #ifdef CONFIG_XFRM_OFFLOAD
> +/**
> + * bond_ipsec_dev - return the device for ipsec offload, or NULL if not exist
> + *                  caller must hold rcu_read_lock.
> + * @xs: pointer to transformer state struct
> + **/
> +static struct net_device bond_ipsec_dev(struct xfrm_state *xs)

Hi Hangbin,

Based on the implementation of the function, it looks like it should return
'struct net_device *' rather than 'struct net_device' (a '*' is missing).

> +{
> +	struct net_device *bond_dev = xs->xso.dev;
> +	struct net_device *real_dev;
> +	struct bonding *bond;
> +	struct slave *slave;
> +
> +	if (!bond_dev)
> +		return NULL;
> +
> +	bond = netdev_priv(bond_dev);
> +	slave = rcu_dereference(bond->curr_active_slave);
> +	real_dev = slave ? slave->dev : NULL;
> +
> +	if ((BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP) ||
> +	    !slave || !real_dev || !xs->xso.real_dev)
> +		return NULL;
> +
> +	WARN_ON(xs->xso.real_dev != slave->dev);
> +
> +	return real_dev;
> +}
> +
>  /**
>   * bond_ipsec_add_sa - program device with a security association
>   * @xs: pointer to transformer state struct

-- 
pw-bot: cr

