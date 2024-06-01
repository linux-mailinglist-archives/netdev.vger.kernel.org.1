Return-Path: <netdev+bounces-99927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B01178D710A
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 18:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505B6281FFA
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 16:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCE014F13D;
	Sat,  1 Jun 2024 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTRE8fQv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766601E49F
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717257855; cv=none; b=I3GKu0X/YF1GQnmj3FSppdjljd8jiVpHiO4OQtoEAXi570IKys0yLOkhuvm3aSpZlSDBDE5OfE5RCpqL5JnUOaAQKiP2dHdzGKp0U4B0y7QD/0xBuVOasv6P/OGbPnjlnuj+m8K9on6HiqojGxmq5127tJzrikqA52/s+HDNkD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717257855; c=relaxed/simple;
	bh=mPnFJXe0+f++tqIHTBEt+NjOnme7R3++MihxmiOltyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fK85OOArKSElV5NnGtfSu/wRJMw2FBCboYj9iSTWyd6recQlgnysFc7o+DNxa5TDSjHnO7R4QhREh46nYdtumJ4uB4Z45Wa8Ucjpbi7PDEYyN3/sFH2NZWVHpAlp9Z2SFSBL8uFHUWtFocOw7vPDdb4KoCAHE9NT0qm5Bdsq3tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTRE8fQv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E781C116B1;
	Sat,  1 Jun 2024 16:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717257855;
	bh=mPnFJXe0+f++tqIHTBEt+NjOnme7R3++MihxmiOltyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QTRE8fQvf/F9lKVA2D3esRCxsWtYzMd1Jz+62eTr2W4Z1i4K7WnvdPmQsGA0rZhTF
	 Ny7Wvh6DEqbAZKXUYyZE+e0bRfzPi4xW7Db3ZNmQHGCaZkKx/eu2XLLkkkjJMsE/SA
	 pqjjvwjMCOx9uovZiterirqJLEctVfuXUJFQqSRYIDez8yZtQn1RjbraF1Igt1neiO
	 xWa9LL5tMKPihohPihBq45hZ2QfS91ym7R5KlrGSZ9ViTxY10jMFDyw3nLt1X1s+9K
	 4NsYTfaPUZAvInpwxtX/lPa5iivTzf0/e0KOz1qrJ8v9MHeUOoPXQnOzyFS4zLP++S
	 iNZN5xrb0eAnQ==
Date: Sat, 1 Jun 2024 17:04:10 +0100
From: Simon Horman <horms@kernel.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Michael Chan <michael.chan@broadcom.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] bnxt_en: add timestamping statistics support
Message-ID: <20240601160410.GR491852@kernel.org>
References: <20240530204751.99636-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530204751.99636-1-vadfed@meta.com>

On Thu, May 30, 2024 at 01:47:51PM -0700, Vadim Fedorenko wrote:
> The ethtool_ts_stats structure was introduced earlier this year. Now
> it's time to support this group of counters in more drivers.
> This patch adds support to bnxt driver.
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>

...

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index 8763f8a01457..bf157f6cc042 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -5233,6 +5233,19 @@ static void bnxt_get_rmon_stats(struct net_device *dev,
>  	*ranges = bnxt_rmon_ranges;
>  }
>  
> +static void bnxt_get_ptp_stats(struct net_device *dev,
> +			       struct ethtool_ts_stats *ts_stats)
> +{
> +	struct bnxt *bp = netdev_priv(dev);
> +	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;

Hi Vadim,

If you need to update this patch for some other reason,
please consider arranging these local variables in
reverse xmas tree order - longest line to shortest.

In this case I think that would mean separating
the declaration and assignment of ptp, like this
(completely untested!):

	struct bnxt *bp = netdev_priv(dev);
	struct bnxt_ptp_cfg *ptp;

	ptp = bp->ptp_cfg;

Edward Cree's tool can be helpful here:
https://github.com/ecree-solarflare/xmastree

...

