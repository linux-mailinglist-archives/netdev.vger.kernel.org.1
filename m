Return-Path: <netdev+bounces-128985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A9697CB5D
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 17:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36F8282C77
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 15:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C1F1A42A5;
	Thu, 19 Sep 2024 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXJ19tKC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F811A3BD3;
	Thu, 19 Sep 2024 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726758616; cv=none; b=iSmrEb4ZRo7VtVGDflXflSteHQGjfALCPYEHK6tbWtqvOrisdt7lTcdDAncIlX+Z4vteupicOmBb7tilnrVc17tk8km1KyLENmcyg56l82KlN8fYvlvb0QNqJcUVOy8Y8UA0wS9og/rLjM789xkJg8RVEEm9YnA46pIRUn/x0gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726758616; c=relaxed/simple;
	bh=Mj1MR3Dw/TqPRYxfxnRC0YmPJ5ACiuJJvIONjkmxu1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HseCF17OO0YVk0r8JE4mcE8tqQaVxKmrRywjyPHmyNB0Spz9i3WxPNXf/hJSjz3ACKDvnwWtL4zarBqt5DpCSzL3S0wfe/4I6Ew7cPSOCNPYSM3p2Psf+WjuaDkCt01HgVZCT7vAQtkxebo+UfvipqJaPIROlUyXhXXgXIz/e20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXJ19tKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808F7C4CEC4;
	Thu, 19 Sep 2024 15:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726758616;
	bh=Mj1MR3Dw/TqPRYxfxnRC0YmPJ5ACiuJJvIONjkmxu1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aXJ19tKColUGOf4joHhrbgN502gULr1tVc4rnatH4KXxRr7TGbpAd//zH7uXKcPWh
	 LFBClDL80NA/8rjNIz5UJADydhoh2BvlMsaRDcaDF1aZijaS44XKHRLoX/8XaB75IM
	 m8fJgx7fE8XcVV2Wsyapj8xwv3Ny0rQtMMuMhC2Z4m5zW0IL5a/IwORxhYD6m6ORXK
	 eDI0JONp9S1vivdH8icFVLLN+Ql/PdRSo1yov/yGJz5DeT3QqzVvsGA0p+0PMi1MLx
	 V1svwTqed8JoA2B3Mxhlk8qwKKFm8lqah3oQt1qKmwxqDjGHFvP3o1+60VqrSjaJ5u
	 7e+Oy9w1Od7Cg==
Date: Thu, 19 Sep 2024 16:10:11 +0100
From: Simon Horman <horms@kernel.org>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
	jerinj@marvell.com, hkelam@marvell.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	rsaladi2@marvell.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] octeontx2-af: Change block parameter to const pointer in
 get_lf_str_list
Message-ID: <20240919151011.GG1571683@kernel.org>
References: <20240919091935.68209-2-riyandhiman14@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919091935.68209-2-riyandhiman14@gmail.com>

On Thu, Sep 19, 2024 at 02:49:36PM +0530, Riyan Dhiman wrote:
> Convert struct rvu_block block to const struct rvu_block *block in
> get_lf_str_list() function parameter. This improves efficiency by
> avoiding structure copying and reflects the function's read-only
> access to block.
> 
> Fixes: e77bcdd1f639 (octeontx2-af: Display all enabled PF VF rsrc_alloc entries.)
> Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>

Hi Riyan,

Thanks for your patch.

While I agree that this is a nice change I don't feel that it is
a fix, typically something that addresses a user-visible bug.

I suggest that the patch should be treated as an enhancement.
It should not have a Fixes tag. And it should be targeted at
net-next (as opposed to net, which is, in general, for fixes).

	Subject: [PATCH net-next] ...

Please note that net-next is currently closed for the v6.12 merge window.
It should reopen after v6.12-rc1 has been released, likely during
the week of the 30th September.

So please consider reposting your patch once net-next has reopened.

Link: https://docs.kernel.org/process/maintainer-netdev.html

-- 
pw-bot: defer

