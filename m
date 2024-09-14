Return-Path: <netdev+bounces-128359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE2E9791E2
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 17:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D2F71C2178D
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 15:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64471D0178;
	Sat, 14 Sep 2024 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWk6yPJN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964E739ACC;
	Sat, 14 Sep 2024 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726328777; cv=none; b=aY/pxRsC0eVbxpWfa41NAPep2F1/tn6pymC2XNagbbg8MXjVyGlmE0JdZDoUVXHcQmqbhjEJUOtvIbm17BhcYFhDigxkOpmg4g7QIbDN8YMkxQLeuLAdRrbkNsT9IsHyuiRsvnHPBlojFG9Mb2CU3ljM0pUfMBku1YXND3KV6yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726328777; c=relaxed/simple;
	bh=E+sZ1BUnpUiXyBvhWY2ZCb218Q3rYMJ5THsYte1+QpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOTGean3XRurduot6y6A/G/mr0BAOa31xOMm5WZ6klBs4PLY1V84EGSoGf2WgiEuwV10KuUK/ENiEm7oL/c5BGEhXWdbd/CxqhKnpUhvoOO4BKWQYOMLW/dsrBRuBZevy7IuBqtVOPz6sLIJuF2u7zzjOJidkD+E1FHlt4xCtWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWk6yPJN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF73C4CEC0;
	Sat, 14 Sep 2024 15:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726328777;
	bh=E+sZ1BUnpUiXyBvhWY2ZCb218Q3rYMJ5THsYte1+QpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nWk6yPJNceiPrsyqSGJ2uY1SbcWnosV9794sfjTVLLX/hacgn06FlOJoyizfZI/3E
	 OsvPzBuBfmmk13ZSWN7OP1s40K/ia9oUUmyF0hbY6We5OWcOHXXk28WhrV7DNCJZYD
	 ZSYlK2S/zr1XupLEuofLNTTscHk1BmFmKaNpupcF+a60ovJw/ULHg1jpVFcnMKJ+Um
	 puqcF2OFZI+lv1y9eDaQo40zuhhnUMjF//hyVmx/0sSWzKg1O39rNuwG7VEy4yfDqt
	 Lm37rRl/djFUCAMAXV8wrDbv58/MNKl9nS4jWc0GtVIMInuk9KgXeBr+dQCO3TQDPh
	 RQZx0IOri7y0w==
Date: Sat, 14 Sep 2024 16:46:12 +0100
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Bryan Whitehead <bryan.whitehead@microchip.com>,
	Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] net: lan743x: clean up a check in
 lan743x_netdev_open()
Message-ID: <20240914154612.GG11774@kernel.org>
References: <f2483839-687f-4f30-b5fa-20eac90c1885@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2483839-687f-4f30-b5fa-20eac90c1885@stanley.mountain>

On Sat, Sep 14, 2024 at 12:59:01PM +0300, Dan Carpenter wrote:
> The "adapter->netdev->phydev" and "netdev->phydev" pointers are different
> names for the same thing.  Use them consistently.  It makes the code more
> clear to humans and static checkers alike.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Hi Dan,

net-next is currently closed, other than for bug fixes.
So please repost this once it re-opens, after v6.12-rc1 is released.

> ---
> I noticed a different static checker warning that I never reported because it
> was too old.  However, I think it's a valid issue.
> drivers/net/ethernet/microchip/lan743x_main.c:109 lan743x_pci_init() warn: missing error code 'ret'
> I think we should set an error code on that path.  It disables the PCI device
> and then we continue to do PCI stuff even though the device is disabled.

Yes, I agree.

I tend to think that is a bug. Though perhaps
there is no urgency in fixing it as it seems unlikely
to occur in practice and it seems to date back to when the
driver was added in 2018 / v4.17.

commit 23f0703c125b ("lan743x: Add main source files for new lan743x driver")

...

-- 
pw-bot: defer

