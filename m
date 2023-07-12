Return-Path: <netdev+bounces-17138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F9375087F
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 14:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EAAF281980
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 12:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE085200A7;
	Wed, 12 Jul 2023 12:39:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BDF1F957
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 12:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE1BC433C8;
	Wed, 12 Jul 2023 12:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689165557;
	bh=V30cr/gIRf6hxwNzJhqq8lbR26epNHKX64BaObglznY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mROMGWvAOwvuk+ntgC9S66YVGhyyXWYKjFYvw3h66wtIyDYpPLpPiCQRRGSEi1zCt
	 SORGcejBdCx/dFrTORlu0rXiww4RXLeR/O0p1w39FNA3tVwLqO6AbLX8czY9aldPy1
	 JzTpZDUQLdZDlbSKzWy/+OVukhd5qpz5AOL8J0WtJMeYQ0eZEaXlfTmXxGuOodjSgF
	 /BFuJIPqEiX98ORwCh2h2RJ0SB2HTrLicfddol2Jvw7mJMxLNAZLMtE/+eShyEldS5
	 9p0KBlgcgJZypSoPF7sZ1HasO6ngnOXfQF7T9xV/jlieikXRdPLzpv2bs9fiNQHx/U
	 lsvae1yDsFWHA==
Date: Wed, 12 Jul 2023 15:39:14 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net PATCH 2/3] octeontx2-af: Fix hash extraction enable
 configuration
Message-ID: <20230712123914.GC41919@unreal>
References: <20230712111604.2290974-1-sumang@marvell.com>
 <20230712111604.2290974-3-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712111604.2290974-3-sumang@marvell.com>

On Wed, Jul 12, 2023 at 04:46:03PM +0530, Suman Ghosh wrote:
> As of today, hash extraction was enabled by default for the default
> MKEX profile. This patch fixes that and enable the support based on
> customer specific MKEX profile.
> 
> Fixes: a95ab93550d3 ("octeontx2-af: Use hashed field in MCAM key")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
>  .../marvell/octeontx2/af/rvu_npc_fs.c         | 22 +++++++---
>  .../marvell/octeontx2/af/rvu_npc_fs.h         |  4 ++
>  .../marvell/octeontx2/af/rvu_npc_hash.c       | 43 ++++++++++++++++++-
>  .../marvell/octeontx2/af/rvu_npc_hash.h       |  8 ++--
>  4 files changed, 65 insertions(+), 12 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

