Return-Path: <netdev+bounces-27608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B31D77C87E
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 09:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8BE1C20C3A
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 07:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD33A94A;
	Tue, 15 Aug 2023 07:23:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E69185D
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 07:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1CEC433C7;
	Tue, 15 Aug 2023 07:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692084213;
	bh=SAJVTPj6a/KSVt4+2s/CS0eWuJ7sG1ZE1pgEArx6lk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EWMZseU/4wAu/3IOv6YlLY753sWJzdN5htIXql3SMvriEiwCeC+BK8uBED81J5ScQ
	 d9L+jLJGgCodeCWM5J+qjanBGJdxeDBeuWI55EBFpyhifnTRB8maE3WJWStdQLDWPN
	 IQ3r/nen3ysSykLJMHIZwN8H9y/ieYtfdl5kbsXo8vJsZyHvxIukLkP/f8JnikEt8a
	 +AoPszjTwAZEOb3ZWSusospWeIrUorzaHcdv4XW2jd0bZ6Gr7/Ix8doTwfW//giiz0
	 g4amA9vSrdIMmJ2iYsB+lm/E7rq2aibsnuWt8TgAvACsjIKkE4NIS3f+AlKDrhve0+
	 G156faoTIIlLg==
Date: Tue, 15 Aug 2023 10:23:28 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jialin Zhang <zhangjialin11@huawei.com>
Cc: shayagr@amazon.com, akiyano@amazon.com, darinzon@amazon.com,
	ndagan@amazon.com, saeedb@amazon.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	michal.kubiak@intel.com, yuancan@huawei.com, netdev@vger.kernel.org,
	liwei391@huawei.com, wangxiongfeng2@huawei.com
Subject: Re: [PATCH] net: ena: Use pci_dev_id() to simplify the code
Message-ID: <20230815072328.GI22185@unreal>
References: <20230815024248.3519068-1-zhangjialin11@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815024248.3519068-1-zhangjialin11@huawei.com>

On Tue, Aug 15, 2023 at 10:42:48AM +0800, Jialin Zhang wrote:
> PCI core API pci_dev_id() can be used to get the BDF number for a pci
> device. We don't need to compose it mannually. Use pci_dev_id() to
> simplify the code a little bit.
> 
> Signed-off-by: Jialin Zhang <zhangjialin11@huawei.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_netdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Patch should include target: [PATCH net-next] ....

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

