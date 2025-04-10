Return-Path: <netdev+bounces-180966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC21A834EC
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42C28C14C8
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 00:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0038623;
	Thu, 10 Apr 2025 00:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEZnFdVA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCAA38B
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 00:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744243584; cv=none; b=E5J6xNyXfwkLoBzOb4ljPX3t45hn+JJvdgRoS7+AWEhzh6K9NZjqjonO/Pga3dYUqZVjQT/lpJTOg5+xffyl3uvf7BRJWQpli1r4MpdMu0AKYGtyJdhLaF+y1dzuefOwKd0LknrVx3qf6qcJcBabEhXAHmJY47IJqAsn+wOoyYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744243584; c=relaxed/simple;
	bh=izIK3A9dM6aBf5IwS23exoul59mylfLlld7xWyBFTTY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SnKpGESD6b8QVzH5++F+LcZMQi0Bt7RanX6BhjYEQGTdBER7IckLjJ8NWRUfv+AImW7ZoXQKhxhxltK5kZSm5giwm2iSJCtAddshQdm8wQ+iRn9Gw8IlcIwcLw7mHkcJnbDzpiC4CQvUoUQFencEjdxZOE/o2xUddzgkmrXNPwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEZnFdVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA33BC4CEE2;
	Thu, 10 Apr 2025 00:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744243583;
	bh=izIK3A9dM6aBf5IwS23exoul59mylfLlld7xWyBFTTY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qEZnFdVANSRcL2YFW/cA7T/M8c8fE/FIKVceaIKK+PEmipx+O4BI0P5BAbmpBkijR
	 k4ptb75xmOAhQRxT1OpLCgmsuY0bFufgafD4sECf2LA1tX/OwEhC98UI5EEy8be6gV
	 ZoPNvFDozYJckBxS+picFgloXXstdZHU7YKCfSjk+mpNFcYC5oT4WGWmcWDYf6H1Yr
	 p9dpti4kjzek/UwBMhrsJknH7y+xXBQjz4lJ74bAgnE1htGa/7s83XXXbG+yInioC1
	 MW7iLgSmzC8gcJMgzv3idNiuAkJf5RSkRkOhzEpRjJUt3i16ZOCNWbgMRqDJR/a72V
	 DUtVZkFraRjiA==
Date: Wed, 9 Apr 2025 17:06:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>
Subject: Re: [PATCH net-next] io_uring/zcrx: enable tcp-data-split in
 selftest
Message-ID: <20250409170622.5085484a@kernel.org>
In-Reply-To: <20250409163153.2747918-1-dw@davidwei.uk>
References: <20250409163153.2747918-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Apr 2025 09:31:53 -0700 David Wei wrote:
> For bnxt when the agg ring is used then tcp-data-split is automatically
> reported to be enabled, but __net_mp_open_rxq() requires tcp-data-split
> to be explicitly enabled by the user.

> diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
> index 9f271ab6ec04..6a0378e06cab 100755
> --- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
> +++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
> @@ -35,6 +35,7 @@ def test_zcrx(cfg) -> None:
>      rx_ring = _get_rx_ring_entries(cfg)
>  
>      try:
> +        ethtool(f"-G {cfg.ifname} tcp-data-split on", host=cfg.remote)

You should really use defer() to register the "undo" actions
individually. Something like:

         ethtool(f"-G {cfg.ifname} tcp-data-split on", host=cfg.remote)
         defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}", host=cfg.remote)
         ethtool(f"-G {cfg.ifname} rx 64", host=cfg.remote)
         defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}", host=cfg.remote)
         ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}", host=cfg.remote)
         defer(ethtool, f"-X {cfg.ifname} default", host=cfg.remote)
         ...

This patch is fine. But could you follow up and convert the test fully?

