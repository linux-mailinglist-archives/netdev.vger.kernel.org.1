Return-Path: <netdev+bounces-28346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF0077F1BB
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 10:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55ED9281DD8
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 08:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F43DDC5;
	Thu, 17 Aug 2023 08:03:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A961CDDBB
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 08:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B48C433CA;
	Thu, 17 Aug 2023 08:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692259436;
	bh=Is87yHwZ1B1uxPat0vcIkBqyx+Zw8erbKEizG+GfstU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bQLR4MEq2JoEpHF1AUMYvEPK/6suai95ibE5Mnb7vbTiyeKhWtN7iP7NUzj4C9kIc
	 q2RjZKrqjoGoS8UxomkLr5FSX0Faxg60c2DTPoTGNkXEOmabw8/JrIqpbwPnO4CCSI
	 Uouosn2YCdx4EQ7FbxlIU7Jwn4aD6FzT0kRlmrc1qnIP6WdC1DILnWPrM2p0LbGlkg
	 k7A+pXUs3ZYYzv6CyADPZvjOr8+5WDhTAOLOhUSMNs12gMreMxiJOlcHpcNCIex0h1
	 vQaRPbFuSReKpInvkneWhmWZ9RPubG2/N7ua0H4XuUM/VH5pH1onPGctTOcOlPfMgy
	 ukQb5LTrHNHOw==
Date: Thu, 17 Aug 2023 11:03:51 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: netdev@vger.kernel.org, Mirko Lindner <mlindner@marvell.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] sky2: Remove redundant NULL check for
 debugfs_create_dir
Message-ID: <20230817080351.GE22185@unreal>
References: <20230817073017.350002-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817073017.350002-1-ruanjinjie@huawei.com>

On Thu, Aug 17, 2023 at 03:30:17PM +0800, Ruan Jinjie wrote:
> Since debugfs_create_dir() returns ERR_PTR, IS_ERR() is enough to
> check whether the directory is successfully created. So remove the
> redundant NULL check.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
>  drivers/net/ethernet/marvell/sky2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

