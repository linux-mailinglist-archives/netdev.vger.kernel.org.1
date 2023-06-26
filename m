Return-Path: <netdev+bounces-14061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C8573EBB2
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 22:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568EF1C209BB
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 20:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12EC14270;
	Mon, 26 Jun 2023 20:20:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850D414A80;
	Mon, 26 Jun 2023 20:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7354EC433C0;
	Mon, 26 Jun 2023 20:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687810803;
	bh=Maky/E8y47QdX20qkzXbLBDyC0PqI8ISHALA3ayx/pE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z3x8LFJljPHUMLCFgTv4ip85HVkbz8dW4da5UnZQbLpbXG0rpq+NuPVtunfh7HNhO
	 ffeMvEtX1ZvkZhKNMHIelkF/nQ+FBlECZJvIjTnzG7N3wIqKwDQNkNRlwQMeDBGcB3
	 YeWSVCB7ojeNPhK6JY986CD+MT+3BmGS3MSURUM0qK1j2g6eABEkTfxawCFfjvbYYp
	 l6w8gZAfR5b6z1mSKR4Dv3sxd3eaAfID8POBiJJB525MYbZPJh9WX1ir2CaC6wmK6d
	 jbgHz/2Un4DJEmh+CHU6DyrZoh/6OETTxPKpL56brXTcF9Xz29nQROIY+AUla1rTWU
	 38BQCfWMIdRWA==
Date: Mon, 26 Jun 2023 13:20:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev, Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next v4 0/2] net: stmmac: improve driver statistics
Message-ID: <20230626132001.2b0e2ac2@kernel.org>
In-Reply-To: <20230626152844.484-1-jszhang@kernel.org>
References: <20230626152844.484-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Jun 2023 23:28:42 +0800 Jisheng Zhang wrote:
> 1. don't clear network driver statistics in .ndo_close() and
> .ndo_open() cycle
> 2. avoid some network driver statistics overflow on 32 bit platforms
> 3. use per-queue statistics where necessary to remove frequent
> cacheline ping pongs.
> 
> NOTE: v1 and v2 are back ported from an internal LTS tree, I made
> some mistakes when backporting and squashing. Now, net-next + v3
> has been well tested with 'ethtool -s' and 'ip -s link show'.

## Form letter - net-next-closed

The merge window for v6.5 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after July 10th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


