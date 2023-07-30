Return-Path: <netdev+bounces-22647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BAE7686AD
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 19:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D7628169C
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 17:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5E010941;
	Sun, 30 Jul 2023 17:25:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABE7DDD4
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 17:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32ADAC433C7;
	Sun, 30 Jul 2023 17:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690737945;
	bh=bh6u2MzpdMnVE6tLD8Ry8Qo9sUET08WImS5mG9hAsUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V3DYeWUxkkTtvJPmLrvSEdvr6G+VBhrYIDWO+DlnsJN8cLlwTChpbSrNyyMSBjP0l
	 3Eg4ZO9P+j4YuMDnAfPexv6pDEG9GzKoXseXB1GT7ZLP+/MBzuTM9EtNO9eVxUeddc
	 OFrqIKtF8ZuWzVvvIy7igqCoo5nsLiQXzSIRySt7kGTe3YrTghhdQzDCoF2ZKkXwXh
	 +VWqz7VbLI1eUq/BqA4FTGFeHqh2iGQaw+jMrUJajudaYRDiVmTGBkmdq2gShkCXvZ
	 kn1sj7nzZKdWDcfeiuSzU5hazyKAnYWxnRYQ9gWjcq5BMB2EJ3E/5TGl3dQLqVv98A
	 H+vSi/e6FIMfA==
Date: Sun, 30 Jul 2023 19:25:41 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
	alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/smc: Remove unused function declarations
Message-ID: <ZMadFUMmqgVXvjMe@kernel.org>
References: <20230729121929.17180-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729121929.17180-1-yuehaibing@huawei.com>

On Sat, Jul 29, 2023 at 08:19:29PM +0800, Yue Haibing wrote:
> commit f9aab6f2ce57 ("net/smc: immediate freeing in smc_lgr_cleanup_early()")
> left behind smc_lgr_schedule_free_work_fast() declaration.
> And since commit 349d43127dac ("net/smc: fix kernel panic caused by race of smc_sock")
> smc_ib_modify_qp_reset() is not used anymore.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


