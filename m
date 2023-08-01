Return-Path: <netdev+bounces-23410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD2C76BE21
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 21:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6E21C21060
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 19:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4209253B9;
	Tue,  1 Aug 2023 19:49:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746764DC6B
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 19:49:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A2EC433C8;
	Tue,  1 Aug 2023 19:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690919394;
	bh=jx8nkKfZnsZVXx8umqQAQuPAq5SYkh1NN4szn/H3sNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bNwin6nzcMICQLvRxBzXlbrrbYS5mevgyW4ev5/p1V2gMZk4sp1hxPE+mQJk1ZUSK
	 cAd8sET0dOL93qMWtn93DVNJhGN2P+bPFtVQYFCT2YoWV8hneWNw2y+yFGMofZmZkB
	 KWbWZWrDtS2I23Ciuad/sQK+v3f2OW4TKFCW7rkL1mbXwL3jdko7ymdyFsJbwb4wp0
	 NEwCnVpazNzcNLEhqUeDrn5sMa56oXfo79yHbZrpCdmiVt/Clsy/5UAzLN0ab+c3b3
	 ICWtz1I8dvpIEWfbQla+77y7RyDmhcdrIjIUZO4wIvLkcXIO1zD74WT6hNR75qZr/S
	 LQjwhqdGtjuAw==
Date: Tue, 1 Aug 2023 22:49:49 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Lin Ma <linma@zju.edu.cn>, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, fw@strlen.de, yang.lee@linux.alibaba.com,
	jgg@ziepe.ca, markzhang@nvidia.com, phaddad@nvidia.com,
	yuancan@huawei.com, ohartoov@nvidia.com, chenzhongjin@huawei.com,
	aharonl@nvidia.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net v1 1/2] netlink: let len field used to parse
 type-not-care nested attrs
Message-ID: <20230801194949.GC53714@unreal>
References: <20230731121247.3972783-1-linma@zju.edu.cn>
 <20230731120326.6bdd5bf9@kernel.org>
 <20230801081117.GA53714@unreal>
 <20230801105726.1af6a7e1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801105726.1af6a7e1@kernel.org>

On Tue, Aug 01, 2023 at 10:57:26AM -0700, Jakub Kicinski wrote:
> On Tue, 1 Aug 2023 11:11:17 +0300 Leon Romanovsky wrote:
> > IMHO, you are lowering too much the separation line between simple vs.
> > advanced use cases. 
> > 
> > I had no idea that my use-case of passing nested netlink array is counted
> > as advanced usage.
> 
> Agreed, that's a fair point. I'm guessing it was inspired by the
> ethtool stats? (Which in hindsight were a mistake on my part.)

I don't remember which part of kernel can be blamed for it. :)

> 
> For the longest time there was no docs or best practices for netlink.
> We have the documentation and more infrastructure in place now.
> I hope if you wrote the code today the distinction would have been
> clearer.
> 
> If we start adding APIs for various one-(two?)-offs from the past
> we'll never dig ourselves out of the "no idea what's the normal use
> of these APIs" hole..

I agree with this sentence, just afraid that it is unrealistic goal, due
to extensive flexibility in netlink UAPI toward user-space, which allows
you to shoot yourself in the foot without even noticing it.

Thanks

