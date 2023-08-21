Return-Path: <netdev+bounces-29420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2310978311D
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 21:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52DD51C2098F
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 19:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37B511719;
	Mon, 21 Aug 2023 19:51:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91E111718
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 19:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618DBC433C9;
	Mon, 21 Aug 2023 19:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692647489;
	bh=lYureIqoiww5yLxIe0QdjNWRWlWNN+mmMOlJ+c0pViM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UvxW7/ncJOnpUYxPyXMBDw0IT/RZUaHey/2zD5pZTzJBnnYyWhKPhnwqMVewHgWuE
	 eQyzqbE/XMdCERsXOT8Jjt21+9GfXAkhPCQmoKvKDmVlTsVB3pdHq9Co4jDSZMKIW1
	 0W/2emQNCMAFjq76SK5sztSi2TdnKL2DYpBPLpBQgu5nTQXnFUA/uszhlgU88/WwzC
	 L8qwJkpG8ll3F2Ffp1rEqnObLIwncqBx2sfX+LPSYJOs1t7awoaQimyOxtlAFlFs2B
	 4uYDGZKo4sAsQd84bnrL4orDf7GR/uWhcv+76D5Ufm+zYvbTi0zzFTAZmG4wo1KzpY
	 yLA/lrNVSuGrA==
Date: Mon, 21 Aug 2023 21:51:24 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: aelior@marvell.com, manishc@marvell.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] qed/qede: Remove unused declarations
Message-ID: <20230821195124.GE2711035@kernel.org>
References: <20230821130002.36700-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821130002.36700-1-yuehaibing@huawei.com>

On Mon, Aug 21, 2023 at 09:00:02PM +0800, Yue Haibing wrote:
> Commit 8cd160a29415 ("qede: convert to new udp_tunnel_nic infra")
> removed qede_udp_tunnel_{add,del}() but not the declarations.
> Commit 0ebcebbef1cc ("qed: Read device port count from the shmem")
> removed qed_device_num_engines() but not its declaration.
> Commit 1e128c81290a ("qed: Add support for hardware offloaded FCoE.")
> declared but never implemented qed_fcoe_set_pf_params().
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


