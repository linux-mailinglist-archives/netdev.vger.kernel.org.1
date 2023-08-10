Return-Path: <netdev+bounces-26530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C21977801D
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 248EB280F88
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA26C22EE4;
	Thu, 10 Aug 2023 18:18:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4812150C
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 18:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0DBC433C7;
	Thu, 10 Aug 2023 18:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691691499;
	bh=LZ135UBTPZt3pIDDTVIcNZXzNUl/4m86OF1+bRutaqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AJo7F5dzD/o49kmcIkU+dnKS3nexFxAOyS+y071/KIfoNc75nUpGEmI+7GGExOlP8
	 Hu5e/yszcB7ASO1fobwCF2ZZM7gae2miOpmBzi4KPHE0/FT6s8+XJmWhwEZrQtTJcl
	 Uc1pdElpX5Csn+yJp1sV826gg6mRQoHTxJEwZyjzd+4KpPvUkj842c4R3xCr8kvfJL
	 E18RNVAoENOKBSFXK9HyZ4vixId0HLUqydCC5XaAnuFOg2bxht1DAY1ZLg9x/+Qh4n
	 SBcNtRwKt+Er0L8kFAX71pqXYdSwkItCrGFYc6njOrvR+Gf060na4DOvWa5y/irwh8
	 SmmoSpXeGE74A==
Date: Thu, 10 Aug 2023 20:18:15 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: santosh.shilimkar@oracle.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
Subject: Re: [PATCH net-next] rds: rdma: Remove unused declaration
 rds_rdma_conn_connect()
Message-ID: <ZNUp52ABFThqAETb@vergenet.net>
References: <20230809144007.28212-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809144007.28212-1-yuehaibing@huawei.com>

On Wed, Aug 09, 2023 at 10:40:07PM +0800, Yue Haibing wrote:
> Since commit 55b7ed0b582f ("RDS: Common RDMA transport code")
> rds_rdma_conn_connect() is never implemented and used.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


