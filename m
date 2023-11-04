Return-Path: <netdev+bounces-46053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C9D7E104F
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 17:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E0F1C20940
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 16:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1D918026;
	Sat,  4 Nov 2023 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laAuGyzQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DBE156FA
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 16:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE55C433C7;
	Sat,  4 Nov 2023 16:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699114267;
	bh=QwQFuRelGSR+6v2zVom1dHUhiePAW6pQq8oZghmzFm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=laAuGyzQQlfuQNG/s0CF2wmFpT2EHOgpjWwvij0aepg8Nc1bYhXbTeIuRRZl6Zn0+
	 RnfU6uV8QSpmaaizLV1SpnH5AjJK0VxnjTA3RTbzJnjnTlvySwJNcn8CgHBdwetv+F
	 FW0JzUosevzlhhcwa0KXkN+Fj6mCHfvdUnwHtVhcUiBVCzV1q5R9gFUV3FN1U1hgw5
	 o3tmN1OwsigGvMY5Z8/XDufT3i9RulgHS/AGOaDPbij6KYA7mNinP/cmuaNbuE43yk
	 MCTw0aX+6Mv7XGeH3MFtL+/lz3tn9I3zEZF0NkBV5qIH9tQUfj+iDbJYHFawMFzef8
	 /L4UBdbWSeBoQ==
Date: Sat, 4 Nov 2023 12:10:52 -0400
From: Simon Horman <horms@kernel.org>
To: Ronald Wahl <rwahl@gmx.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Roger Quadros <rogerq@kernel.org>,
	Ronald Wahl <ronald.wahl@raritan.com>
Subject: Re: [PATCH] net: ethernet: ti: am65-cpsw: rx_pause/tx_pause controls
 wrong direction
Message-ID: <20231104161052.GL891380@kernel.org>
References: <20231031122005.13368-1-rwahl@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031122005.13368-1-rwahl@gmx.de>

On Tue, Oct 31, 2023 at 01:20:05PM +0100, Ronald Wahl wrote:
> From: Ronald Wahl <ronald.wahl@raritan.com>
> 
> The rx_pause flag says that whether we support receiving Pause frames.
> When a Pause frame is received TX is delayed for some time. This is TX
> flow control. In the same manner tx_pause is actually RX flow control.
> 
> Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>

Hi Ronald,

I am a little unclear if this patch addresses a user-visible bug, or
is adding a new feature.


If it is fixing a bug then it should be targeted at the net tree.
It should apply cleanly there, and the tree should be noted in the subject.

  Subject: [PATCH net] net: ethernet: ...

Also, if it is a bug fix, it should have a fixes tag, indicating the
revision(s) where the problem was introduced. This to assist in backporting
fixes. In this case perhaps the following is appropriate:

  Fixes: e8609e69470f ("net: ethernet: ti: am65-cpsw: Convert to PHYLINK")

It is probably not necessary to repost to address the above.
But please keep it in mind for future Networking patches.


On the other hand, if this is a new feature, then it should be targeted
at net-next:

  Subject: [PATCH net-next] net: ethernet: ...

And in that case the following applies.


## Form letter - net-next-closed

The merge window for v6.7 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after November 12th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

