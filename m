Return-Path: <netdev+bounces-34313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179D67A3120
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 17:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6AC28214F
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 15:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D76814275;
	Sat, 16 Sep 2023 15:34:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF6A12B9A
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 15:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3217BC433C7;
	Sat, 16 Sep 2023 15:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694878459;
	bh=RdDZPLFEo/rep3G/EYR6iQccvFHq02ff6Uft8SoULpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fRV5fOA5i/oiztva45eZ94ZEA0D3UIS0T+UqpJ6uIsRHFSlGPpGy3byGJQIMua+rp
	 b7RmMzyimhWgDo/JhPx5S5WVRyK5/8CXkTKnER/NyeHYl8p+JiP5mLUV52L9NGHsoz
	 cil37iOIsJs/iKTGTJcOQixj7zPHmt6ZtCJ8Nec6dirQXV3G7Glvos35VOuKvFv0Lz
	 R5iWfrXjB8opxqnuvEfVAw7g1J5gyq8efsZiD57GG0RSjWeJQmwvAt9FtcPqN7kjG6
	 P26Txzp58GOxQfxcngWYznW4ktfjS/i/PofTI3EXLrbrwl0IbHLQxKf1Ly7g75ISrp
	 JLnbbghPvcUEA==
Date: Sat, 16 Sep 2023 17:34:15 +0200
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/5] net: hns3: add cmdq check for vf periodic
 service task
Message-ID: <20230916153415.GF1125562@kernel.org>
References: <20230915095305.422328-1-shaojijie@huawei.com>
 <20230915095305.422328-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915095305.422328-2-shaojijie@huawei.com>

On Fri, Sep 15, 2023 at 05:53:01PM +0800, Jijie Shao wrote:
> From: Jie Wang <wangjie125@huawei.com>
> 
> When the vf cmdq is disabled, there is no need to keep these task running.
> So this patch skip these task when the cmdq is disabled.
> 
> Signed-off-by: Jie Wang <wangjie125@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Hi Jinjie Shao,

if this is a fix then it's probably appropriate to include a Fixes tag.

