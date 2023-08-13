Return-Path: <netdev+bounces-27089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E55B677A57C
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 09:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C31E280F37
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 07:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DD81C20;
	Sun, 13 Aug 2023 07:57:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1099E17C5
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 07:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B24C433C8;
	Sun, 13 Aug 2023 07:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691913443;
	bh=xjpF0/VqHAovvaQnnxEb0iO93o8G4A2JMIzGz1RJ2jQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PuWXxpr27zJex4nueGA5MsqUNau5XHpBfyNbN8lE9iSJjT0iN0Onx4D7AbG/id3RN
	 vgnF7tiqVjyfn4KXU1lwgZWth8EqVF3IIsy/meKMhYglphlBYEcYiQtO3IA3rITLgu
	 YwI65/423VCcANoc1cFekxsdkfWbHxRFQvCPo+Adv3jQiRjv2UyUTxU6CyPmvJwTuP
	 RrLaGRWEslrY6E2tdjg5twsp3CtaLtM+z6ovloEK/CXFzz25yGZVbEsx79KXiWa6nF
	 cASXrHSCUzzEeg6mcK9jiwrsg6As9mYVDvzHAFQ9sKnhLUxeCPz8buNhSqW4eUM1/f
	 ZGFDoGYKpBFcw==
Date: Sun, 13 Aug 2023 10:57:19 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, j.vosburgh@gmail.com,
	andy@greyhouse.net, weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next 1/5] bonding: add modifier to initialization
 function and exit function
Message-ID: <20230813075719.GB7707@unreal>
References: <20230809124107.360574-1-shaozhengchao@huawei.com>
 <20230809124107.360574-2-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809124107.360574-2-shaozhengchao@huawei.com>

On Wed, Aug 09, 2023 at 08:41:03PM +0800, Zhengchao Shao wrote:
> Some functions are only used in initialization and exit functions, so add
> the __init/__net_init and __net_exit modifiers to these functions.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  drivers/net/bonding/bond_debugfs.c | 4 ++--
>  drivers/net/bonding/bond_main.c    | 2 +-
>  drivers/net/bonding/bond_sysfs.c   | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

