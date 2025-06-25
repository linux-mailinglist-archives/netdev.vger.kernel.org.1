Return-Path: <netdev+bounces-201037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6928DAE7E82
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1B216F466
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8891E29DB84;
	Wed, 25 Jun 2025 10:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpaksek3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5837629DB6B;
	Wed, 25 Jun 2025 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845975; cv=none; b=qdNZtpiHca/lb0KjgDmZYxvdQyglyIS1EwsVia97dpabtKLAtCVkEbRWCnBd3CBgdmY+j8dyIeTDMQLdpQ5ubzE+TAkVGTfHuC2PfgZjVIN05XUTzqgCLiZfMp0LYFxbEQbqbOFgG0oGmmp411PB/czTv0MqHWXN0d+eqVk3AKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845975; c=relaxed/simple;
	bh=aiLkgFC5NuellT8bZtBM3vhInrcKao1RCG4PgvpJiNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTWISj2Gde29vFUwOeIjPhB5fPrWFNoZwynTDJSTdE856GVUmL89EKtxVJk1OiGvPLp+qDFC6twOllyFYzvul2V/yllrbMYdplAB10z+aGpaTk42o1/kWp0cReVZpqC9Mp+OWioiyXqKHpakT45F/+6+lV+JmzKIqeloQcnpKUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpaksek3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE43C4CEEE;
	Wed, 25 Jun 2025 10:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750845974;
	bh=aiLkgFC5NuellT8bZtBM3vhInrcKao1RCG4PgvpJiNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hpaksek3nM8YbhFbsO8KJsdqx99hUU/RXs6iuJsmYp7HiYiOqWc1H0W5osUru5Bom
	 qh2nKibrYU0JdXMuS8bun4z8VocDxHXMOGZzuXMD6rXdU8dryfotWkka91KSPUU2fI
	 lDsnOiea8ik+f1HJAKvmgjYLkEpUHuPNWGcjnOryLZXZ7UJyXJ23Pxf6jVOrCZotFm
	 s9n5yWyvUBPqyrFvQp3bS1+lOidKSHksRfqYdYgXn+V7USu6plTCTQSpTV7DIoi56l
	 hJp6UdurW9b26rFfsKf3tLULzFSZDH1PyUEkNRGQdLRudxB3XACFJlYrtqmQbTGezd
	 blQdXEQrC8xKg==
Date: Wed, 25 Jun 2025 11:06:10 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Ayush Sawal <ayush.sawal@chelsio.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 6/7] net: splice: Drop nr_pages_max
 initialization
Message-ID: <20250625100610.GO1562@horms.kernel.org>
References: <20250624-splice-drop-unused-v1-0-cf641a676d04@rbox.co>
 <20250624-splice-drop-unused-v1-6-cf641a676d04@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-splice-drop-unused-v1-6-cf641a676d04@rbox.co>

On Tue, Jun 24, 2025 at 11:53:53AM +0200, Michal Luczaj wrote:
> splice_pipe_desc::nr_pages_max was initialized unnecessary in commit
> 41c73a0d44c9 ("net: speedup skb_splice_bits()"). spd_fill_page() compares
> spd->nr_pages against a constant MAX_SKB_FRAGS, which makes setting
> nr_pages_max redundant.
> 
> Remove the assignment. No functional change intended.
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
> Probably the same thing in net/smc/smc_rx.c:smc_rx_splice()?

Yes, it seems so to me.

