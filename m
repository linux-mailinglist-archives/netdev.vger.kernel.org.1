Return-Path: <netdev+bounces-21924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7360876549D
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 15:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2693A28235A
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 13:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426B9171B1;
	Thu, 27 Jul 2023 13:10:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CD6168A5
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 13:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943EEC433C7;
	Thu, 27 Jul 2023 13:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690463412;
	bh=Dp5yC+ImgrYVfJ4yywPkWJAd8MEX+O3an98CdugAXFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iHX/tf3ZvbSg8lZ+jy388A0zN8tLw6tATRbWobqNmXHCP67nXiqI34RPshUmMHEQv
	 cm1bsnsJojG0seb58Fbs3jcP2BccfWMXIpfHkhJycoBfWE+VNg39UIJ4o5Ie9QwfAV
	 /7CFZ50rm7y2XcPUYRN+ELaRf1Yb/XHN4bso0vYafoZdEPIQhg+qHTiV6rZz+5jasO
	 KNc6yRWebjBqyrxNrTwRLHAU91ejQ8XRipDttz6Tt6Y7LVMz/Di49ovPpyAQyM8UAL
	 XmHy6YxwEK36pVxIrTKdp0Hlly+X+Hpkx+6R9FC44b+OxytbrYCs00DQSedjWLjb9Y
	 BN3z/38jbrx/Q==
Date: Thu, 27 Jul 2023 16:10:08 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, sd@queasysnail.net
Subject: Re: [PATCH net-next v2 2/2] net: convert some netlink netdev
 iterators to depend on the xarray
Message-ID: <20230727131008.GB2652767@unreal>
References: <20230726185530.2247698-1-kuba@kernel.org>
 <20230726185530.2247698-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726185530.2247698-3-kuba@kernel.org>

On Wed, Jul 26, 2023 at 11:55:30AM -0700, Jakub Kicinski wrote:
> Reap the benefits of easier iteration thanks to the xarray.
> Convert just the genetlink ones, those are easier to test.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/linux/netdevice.h |  3 ++
>  net/core/netdev-genl.c    | 37 +++++---------------
>  net/ethtool/netlink.c     | 59 ++++++++-----------------------
>  net/ethtool/tunnels.c     | 73 +++++++++++++++------------------------
>  4 files changed, 52 insertions(+), 120 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

