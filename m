Return-Path: <netdev+bounces-25506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF03774667
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7E4F1C20EE7
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B38A154A7;
	Tue,  8 Aug 2023 18:55:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A9115494
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77698C433C8;
	Tue,  8 Aug 2023 18:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691520941;
	bh=xdoAQE4gvzbaXW7o5SJ9HdR0FcwDH36dp+qmn+f4fo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gq4NafKKliHvETbjjE8/CokMXDjhlDKsd+DZt2GFBq4oCaFlOfSbY4n/YZWvrpQXo
	 F1usTtCvSybe8lcgahbjyVlTxBz/rpZjfWoTkLBdTMx7KDC3wQK2gIePqEg9XI8TPv
	 Af8diQebYZb4p6jNbBE7XdrGDblaqa2lIO1jwqkVHKzpf42BH1E6f3tQuD5QzMsRiO
	 vA+8CyFpu9maED4iiI9lBeNwBmnil/mA2WKi8cLs5olS10arMvC+RPGU1PJCQ4QOvg
	 FMbBQjA0lYN0kFLXmtPNlqeyv1Aa9/NoqxLnkM5Llk7MCUzERIWa3hOVT+f/o0gO3F
	 7/fek79Q79nRw==
Date: Tue, 8 Aug 2023 21:55:34 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: tariqt@nvidia.com, yishaih@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jgg@ziepe.ca, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 02/10] mlx4: Rename member mlx4_en_dev.nb to
 netdev_nb
Message-ID: <20230808185534.GH94631@unreal>
References: <20230804150527.6117-1-petr.pavlu@suse.com>
 <20230804150527.6117-3-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804150527.6117-3-petr.pavlu@suse.com>

On Fri, Aug 04, 2023 at 05:05:19PM +0200, Petr Pavlu wrote:
> Rename the mlx4_en_dev.nb notifier_block member to netdev_nb in
> preparation to add a mlx4 core notifier_block.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Tested-by: Leon Romanovsky <leon@kernel.org>
> ---
>  drivers/net/ethernet/mellanox/mlx4/en_main.c   | 14 +++++++-------
>  drivers/net/ethernet/mellanox/mlx4/en_netdev.c |  2 +-
>  drivers/net/ethernet/mellanox/mlx4/mlx4_en.h   |  2 +-
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

