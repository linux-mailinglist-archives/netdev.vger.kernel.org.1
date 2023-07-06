Return-Path: <netdev+bounces-15732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 050BE7496FD
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 10:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09EE1C20CE3
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 08:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44E815CD;
	Thu,  6 Jul 2023 08:02:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0905115BA
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 08:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94CCC433C7;
	Thu,  6 Jul 2023 08:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688630547;
	bh=6QpwKPmnJCc+Qn4RbnyQAK3huFIb15xha54+tnXJrdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rz98atuOb83fjJuTXqpzUca5rAo9TjySUdzPYu4ldVibHR1zHrCBKMxehu9WUQmEY
	 9PTiM1ChwrCXD+ODKt4LQuPltdSxW3td1faHTEsdgfNhBMehBdq5mEkPRW1RlM5xkc
	 qqbFXtKKHt+SL6NNNk6mic/imQLwP0SrTu4tX2Nvhh9duqinFrC/UwWV3vbX3SCVh3
	 5c+i750b6JtQy3ktRSpDjKF28/wQ969rAnqdmxFA7UlJZUfv3X6B/iDYL9n1E0uuQ5
	 QRvYlcp96LWibhMzAIwHDvgvghV5/zNbhT1J8k6tuLEIS/WMfLl8rOHPfTu3BfXYST
	 xWVZLBXBXc6/w==
Date: Thu, 6 Jul 2023 11:02:22 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.kubiak@intel.com, sgoutham@marvell.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	sbhatta@marvell.com, gakula@marvell.com, schalla@marvell.com,
	hkelam@marvell.com
Subject: Re: [PATCH net v1] octeontx2-af: Promisc enable/disable through mbox
Message-ID: <20230706080222.GT6455@unreal>
References: <20230706042705.3235990-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706042705.3235990-1-rkannoth@marvell.com>

On Thu, Jul 06, 2023 at 09:57:05AM +0530, Ratheesh Kannoth wrote:
> In legacy silicon, promiscuous mode is only modified
> through CGX mbox messages. In CN10KB silicon, it is modified
> from CGX mbox and NIX. This breaks legacy application
> behaviour. Fix this by removing call from NIX.
> 
> Fixes: d6c9784baf59 ("octeontx2-af: Invoke exact match functions if supported")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> ---
> ChangeLog
> 
> v0 -> v1: Fix 80 lines checkpatch warnings
> ---
>  .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 11 ++-------
>  .../marvell/octeontx2/af/rvu_npc_hash.c       | 23 +++++++++++++++++--
>  2 files changed, 23 insertions(+), 11 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

