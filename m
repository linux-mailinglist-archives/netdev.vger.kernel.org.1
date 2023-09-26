Return-Path: <netdev+bounces-36272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFE07AEB9B
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 13:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 253091C20831
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 11:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9890226E22;
	Tue, 26 Sep 2023 11:41:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874CA26E0F
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 11:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0700C433C8;
	Tue, 26 Sep 2023 11:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695728471;
	bh=xayddD/UkGvMFL+wjIXW7FBKA1JN27wJEBHqp+aZGc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pD2rkyKidfdtF/GsiBFXYbwt5HP0gHPAGz4mexcij7dv0gTpQ3Eh9ZokjHii72WOJ
	 dxf6FVK18gYzSBkS7CPt+hctajmRYIuUd/2z9HvY6Rag6l70skrZCL57kApl/+afsj
	 V8SXRPJvt/v957XRfnojIoznopkeHvFbm8xU6aMOoFrR8pgn62jZ4gCYYEdluO48iP
	 rsC5m1j6pwv5Rak1ZNOUHOwXKE/CHdMCNFVJVdk/E8xP1sEl5f+U2Y/mg4UB4uWZTk
	 YqYU1RYkFPK8y93ClqRko9awFHAfWZ0VKGnhNjzKOnj5LgvIFtec4Fr1BUjVCRvFju
	 2NYjMZpT/aBmQ==
Date: Tue, 26 Sep 2023 14:41:04 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: Albert Huang <huangjie.albert@bytedance.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	RDMA mailing list <linux-rdma@vger.kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH net-next] net/smc: add support for netdevice in
 containers.
Message-ID: <20230926114104.GL1642130@unreal>
References: <20230925023546.9964-1-huangjie.albert@bytedance.com>
 <20230926104831.GJ1642130@unreal>
 <76a74084-a900-d559-1f63-deff84e5848a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76a74084-a900-d559-1f63-deff84e5848a@linux.ibm.com>

On Tue, Sep 26, 2023 at 01:14:04PM +0200, Alexandra Winter wrote:
> 
> 
> On 26.09.23 12:48, Leon Romanovsky wrote:
> > This patch made me wonder, why doesn't SMC use RDMA-CM like all other
> > in-kernel ULPs which work over RDMA?
> > 
> > Thanks
> 
> The idea behind SMC is that it should look an feel to the applications
> like TCP sockets. So for connection management it uses TCP over IP;
> RDMA is just used for the data transfer.

I think that it is not different from other ULPs. For example, RDS works
over sockets and doesn't touch or reimplement GID management logic.

Thanks

