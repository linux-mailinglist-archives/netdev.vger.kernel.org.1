Return-Path: <netdev+bounces-37241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3D27B45B5
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 08:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 451A328222F
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 06:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D94F8F50;
	Sun,  1 Oct 2023 06:56:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB2E20E1
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 06:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9638DC433C7;
	Sun,  1 Oct 2023 06:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696143398;
	bh=RMD1G/nyPZtMLFTDjB85KSKijoc7KVijnQjNSZL7adk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B15/fvzNUuNU4vcSKlOAALxKUcqGaJ0ts9uKq7ujnoi7h4nX7gvUxd7EAaf6DRLOz
	 +3VgpJQlbPogXVybdafnwND0ycdhph0mui2kOfd7jfJcv7t/9B4B+4QbK/DFENGNN4
	 v2Ok8cy/z91g6jxeJF5Q3ty+H4TtX+ZDeUUl1sZFHiN+QhKk/HLBd2mHoyNSk3SHDg
	 puqtos+siKhSekELWgDIHrLNk5mNqgMLpG/w4pjkyWvOo4/l0MjTO267a873x4aQm5
	 thXlBIt5dmYnKyzkv9alqwS83x8dl3qRPZ5FQC0y6foXpZ0vZrbqJJ/ORke5D2Pc0K
	 y3oADT9ynvqNA==
Date: Sun, 1 Oct 2023 08:56:34 +0200
From: Simon Horman <horms@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vladimir.oltean@nxp.com, s-vadapalli@ti.com,
	srk@ti.com, vigneshr@ti.com, p-varis@ti.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 net-next 0/4] net: ethernet: am65-cpsw: Add mqprio,
 frame pre-emption & coalescing
Message-ID: <20231001065634.GI92317@kernel.org>
References: <20230927072741.21221-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927072741.21221-1-rogerq@kernel.org>

On Wed, Sep 27, 2023 at 10:27:37AM +0300, Roger Quadros wrote:
> Hi,
> 
> This series adds mqprio qdisc offload in channel mode,
> Frame Pre-emption MAC merge support and RX/TX coalesing
> for AM65 CPSW driver.
> 
> Comparted to v4, this series picks up the coalesing patch.
> 
> Changelog information in each patch file.
> 
> cheers,
> -roger
> 
> Grygorii Strashko (2):
>   net: ethernet: ti: am65-cpsw: add mqprio qdisc offload in channel mode
>   net: ethernet: ti: am65-cpsw: add sw tx/rx irq coalescing based on
>     hrtimers
> 
> Roger Quadros (2):
>   net: ethernet: ti: am65-cpsw: Move code to avoid forward declaration
>   net: ethernet: ti: am65-cpsw-qos: Add Frame Preemption MAC Merge
>     support

...

For series,

Reviewed-by: Simon Horman <horms@kernel.org>


