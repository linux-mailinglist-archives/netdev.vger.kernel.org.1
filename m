Return-Path: <netdev+bounces-24202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F274776F394
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 21:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABACC28234D
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 19:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF51C2592F;
	Thu,  3 Aug 2023 19:41:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36FC25178
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 19:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CB0C433CA;
	Thu,  3 Aug 2023 19:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691091677;
	bh=Zc2Fnl9uLCazlZvghpF6ZZNgi6AQk+SX/wzfu6Cayvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e7Mi0+4LvXoMpCchq9a2gy1ktzO7J+cEiu5HgVrxiP1zrJK5sBNMpcLrXss8BouLB
	 DiTn6UeTlUC/lnL7JO60AonktV4kvR0E8nBtiyQHkNvaT5gJbv9kRmy5wuRt71BlYr
	 kdDxCfyHgFdPguXdQMNEKU37xUktSbRcySFsVBFa8OkSOo8r620jfi+N8pOrIrPS2v
	 /rInMA3x81TrxuURbWSi2BeTNvRagn9NN5f3Dw4belGqiOXj5uWuC7XfteEd0KnexG
	 96ssQDSt+Z7k/G7vKcmk1126wp9FvzAtCdaQz5ZFz3IWMUINNfhV4gCre9mss6eky/
	 s/Drle4b9X0Rw==
Date: Thu, 3 Aug 2023 21:41:11 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	lanhao@huawei.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: hns3: Remove unused function declarations
Message-ID: <ZMwC12FZrutH7tEa@kernel.org>
References: <20230803135138.37456-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803135138.37456-1-yuehaibing@huawei.com>

On Thu, Aug 03, 2023 at 09:51:38PM +0800, Yue Haibing wrote:
> Commit 1e6e76101fd9 ("net: hns3: configure promisc mode for VF asynchronously")
> left behind hclge_inform_vf_promisc_info() declaration.
> And commit 68c0a5c70614 ("net: hns3: Add HNS3 IMP(Integrated Mgmt Proc) Cmd Interface Support")
> declared but never implemented hclge_cmd_mdio_write() and hclge_cmd_mdio_read().
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


