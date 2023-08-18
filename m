Return-Path: <netdev+bounces-28942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D27781326
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 20:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3231C216BE
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C66B1B7F0;
	Fri, 18 Aug 2023 18:57:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08761B7D6
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 18:57:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEED6C433C8;
	Fri, 18 Aug 2023 18:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692385059;
	bh=fv/YYb3G79cUIhqviOxhsIiBdv4mGX2JwCYM6ITqusY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jg5Lk3YV8urrZSH3kVlW/415SKMtgRWrWMfVf47GKQ+J/tVt9Vgw9Z2UZgnOol/qC
	 7afiKAiWB0o2SKDPCZ81iT+idyLOlQjuI/imkQWQ6+pNxyTCIKgTEgo8EX4ztGqAeV
	 Bi57ox0dgjOd7Q0I5HJG+7JwrttKkcNDuOZWacjdHlqu67P/DGs1BDxjMahqbpvV/s
	 MLr6SpB5/ZU7c2r5KMgjvbPA75aL+KWFAAmR/98dFybAuo8zrYRe60OQ0X8EuVH8yb
	 3qCPxEfFXkU9Z63lIY2R9fRZANzoARQJ/ecahP7npEeftfdwhlDTVyBPtwXbjq8yt/
	 +HT32omfYIFJw==
Date: Fri, 18 Aug 2023 21:57:32 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: madalin.bucur@nxp.com, sean.anderson@seco.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	pantelis.antoniou@gmail.com, camelia.groza@nxp.com,
	christophe.leroy@csgroup.eu, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next] net: freescale: Remove unused declarations
Message-ID: <20230818185732.GK22185@unreal>
References: <20230817134159.38484-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817134159.38484-1-yuehaibing@huawei.com>

On Thu, Aug 17, 2023 at 09:41:59PM +0800, Yue Haibing wrote:
> Commit 5d93cfcf7360 ("net: dpaa: Convert to phylink") removed
> fman_set_mac_active_pause()/fman_get_pause_cfg() but not declarations.
> Commit 48257c4f168e ("Add fs_enet ethernet network driver, for several
> embedded platforms.") declared but never implemented
> fs_enet_platform_init() and fs_enet_platform_cleanup().
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/freescale/fman/mac.h        | 4 ----
>  drivers/net/ethernet/freescale/fs_enet/fs_enet.h | 5 -----
>  2 files changed, 9 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

