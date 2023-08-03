Return-Path: <netdev+bounces-24198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDA876F377
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 21:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA82128112C
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 19:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C032A25927;
	Thu,  3 Aug 2023 19:33:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A7B63BC
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 19:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9F7C433C7;
	Thu,  3 Aug 2023 19:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691091227;
	bh=Ky1I/LRB05twoS/uSnBT1JXJQyAGI67tFPlAx0aiNvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LbGP2U9K6OxNJhUH24jkK/lcqbevaiSipGkXbo2NNG9b9EPaVKw5iNSlYfrlJzxym
	 DBWqZzk98DCdEph/yTeU/75zVSweTTIbwrr3YKtZ5ZEJnZuTHJxuBpiOfbHFMmdGBp
	 pHjSZcQgfoRaa8sieCaZ85Wf5n8RZid6qOZirXbd9N/aCTvw+Ribx36TSEPAS37b4D
	 DD5bVFiVli/GtDt3SPCxOl8BftEuhwKhCRBVIeJlh3rE9WRrE5RlATnXL4TSSJNxzN
	 QP5rGRV4hJ/JQ49B3avYrdwCQbX92GHXCheqlLPzaGbCQEneVU8z355N6fM24ru0f2
	 jQJxIs7KXh/+A==
Date: Thu, 3 Aug 2023 21:33:41 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, bobby.eshleman@bytedance.com,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH -next] af_vsock: Remove unused declaration
 vsock_release_pending()/vsock_init_tap()
Message-ID: <ZMwBFdw8BTno3dn2@kernel.org>
References: <20230803134507.22660-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803134507.22660-1-yuehaibing@huawei.com>

On Thu, Aug 03, 2023 at 09:45:07PM +0800, Yue Haibing wrote:
> Commit d021c344051a ("VSOCK: Introduce VM Sockets") declared but never implemented
> vsock_release_pending(). Also vsock_init_tap() never implemented since introduction
> in commit 531b374834c8 ("VSOCK: Add vsockmon tap functions").
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Hi Yue Haibing,

FWIIW, I think this should be targeted at net-next.
In any case, the change looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

