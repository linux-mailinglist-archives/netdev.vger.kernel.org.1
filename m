Return-Path: <netdev+bounces-18568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0578C757BC7
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 14:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4D8281281
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 12:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B3DC8C8;
	Tue, 18 Jul 2023 12:28:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651DE1FD8
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 12:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD00C433C7;
	Tue, 18 Jul 2023 12:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689683283;
	bh=R8sOcqcXecALVQwiIRsJk5h3MaygnnkPbEwfmlj/MC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q1IBPkGMgdov8HhHI+SZXO385pfWvIlMvE3LMSZXQmHfb9Hn+z4mx1uteAhHMMtuP
	 G3FImlLNRgGDQ9xzJQea/AoRhq3ZC1kVDCKDjwlY1aR2O+3BnaXC8rHOq2nsdiiwGk
	 72qXvFSZTSGzU/0pXQe07bQKfv2y9K0hnm+E5tZ3NZGBIkD6SZHIJXYbd7DelAIAqn
	 jPLW5V80CesSSPUj/ldoM0APhDnOJQf11l/+zZ3bUowfJzcPMzZx+XHqsvufaToJN0
	 1FUhNZyRgJFNnLkZ9EWkrU0AhXLEQRQR3XWYZvSR1rUViFPp4+/2FrCIO3qqsVumoi
	 e+l0/ITnt0ciw==
Date: Tue, 18 Jul 2023 15:27:59 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lcherian@marvell.com,
	jerinj@marvell.com
Subject: Re: [net-next PATCH V3] octeontx2-af: Install TC filter rules in
 hardware based on priority
Message-ID: <20230718122759.GE8808@unreal>
References: <20230718044049.2546328-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718044049.2546328-1-sumang@marvell.com>

On Tue, Jul 18, 2023 at 10:10:49AM +0530, Suman Ghosh wrote:
> As of today, hardware does not support installing tc filter
> rules based on priority. This patch adds support to install
> the hardware rules based on priority. The final hardware rules
> will not be dependent on rule installation order, it will be strictly
> priority based, same as software.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
> v3 changes:
> - Addressed minor review comments from Leon Romanovsky
> 
> v2 changes:
> - Rebased the patch on top of current 'main' branch
> 
>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |   9 +-
>  .../marvell/octeontx2/af/rvu_npc_fs.c         |   9 +-
>  .../marvell/octeontx2/af/rvu_switch.c         |   6 +-
>  .../marvell/octeontx2/nic/otx2_common.h       |  11 +-
>  .../marvell/octeontx2/nic/otx2_devlink.c      |   1 -
>  .../marvell/octeontx2/nic/otx2_ethtool.c      |   1 +
>  .../marvell/octeontx2/nic/otx2_flows.c        |   2 +
>  .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 313 +++++++++++++-----
>  8 files changed, 248 insertions(+), 104 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

