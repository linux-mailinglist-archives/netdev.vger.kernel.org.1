Return-Path: <netdev+bounces-14626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BA8742BBA
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 20:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11227280944
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 18:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A0A1426A;
	Thu, 29 Jun 2023 18:08:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BBC13AF9
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 18:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB51C433C8;
	Thu, 29 Jun 2023 18:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688062128;
	bh=J1HhAqe1G1kupfw8pHqBlXxV+2iR6/KMfRPKcrQ5OOU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jjKgGwPzeGHZyxIUm4UT/m3QDeekdGwlEXjPjd3pUZ151So2PzUBZrvzv0AVfdzjs
	 Kgj283RkgWGPDJgc+tSKe7DW6jG1dY6V9UfdsNqx/45gvF2ErRNxhqfzmUhcvFH0nx
	 SL50ORW/MsiswPfd0EpBWocY9jKtCnp7bTNifr27JYLJAVrsbTtN1mk5Og8dCnjByH
	 clW3Q+dHH84zTkc/l/VGeBv6R1Ie7kvE/zvFPcRCOik2YEGxl3ZcYWLWB3tFXsTVGN
	 o0f6pdh9Pt3kqp7tfXVNTUhm0byoAHEbS6yk4LKZEFh2PCTmQuuQyMC0ZBtTH+7qX2
	 cVYh5Dq/CVE4w==
Date: Thu, 29 Jun 2023 11:08:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <idosch@nvidia.com>, <petrm@nvidia.com>,
 <jiri@resnulli.us>, <vadimp@nvidia.com>, <yuehaibing@huawei.com>
Subject: Re: [PATCH net,v2] mlxsw: minimal: fix potential memory leak in
 mlxsw_m_linecards_init
Message-ID: <20230629110846.17a4c23d@kernel.org>
In-Reply-To: <20230628100116.2199367-1-shaozhengchao@huawei.com>
References: <20230628100116.2199367-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Jun 2023 18:01:16 +0800 Zhengchao Shao wrote:
> The line cards array is not freed in the error path of
> mlxsw_m_linecards_init(), which can lead to a memory leak. Fix by
> freeing the array in the error path, thereby making the error path
> identical to mlxsw_m_linecards_fini().
> 
> Fixes: 01328e23a476 ("mlxsw: minimal: Extend module to port mapping with slot index")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>

Could you please resend with Ido's review tag included?

Due to unforeseen mail server issues (it wouldn't be a merge window
without vger imploding, eh?) the patch did not make it to patchwork
or email archives.

