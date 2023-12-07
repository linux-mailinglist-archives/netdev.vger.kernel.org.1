Return-Path: <netdev+bounces-55014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C09B8092E5
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 22:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCA8A1C208CC
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 21:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4F75024A;
	Thu,  7 Dec 2023 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8f4SjyT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DADE4E637
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 21:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8113FC433C8;
	Thu,  7 Dec 2023 21:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701982834;
	bh=ZzzQMPvW63IUMpJw7M9FcUuFUYHTyPS/qZ9rHOWzE0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o8f4SjyTNd2EwTx9BcZjJTbPCbaJcynwwY95j8B8DYHf7fvRHFdnKLhoTQCMBfN+R
	 VRQzr6sFgmoDEL9UYNyRTY7dlO6Yjg2BTl9efF2SLmhkk9DLNK1PxMN7hf2da7486e
	 y6kdaJ+iU4JFKEdBk+T0RlP9uiWxRZr1A4TzvMHfH4tFFV4tN6GEpUZ5yDL3ddPoJE
	 5wtWyN98j9mHE/yq+/ZbPBJxfneXGHHKKuBReyEqzllyUQ+F10GFs24m0sluX3hH0r
	 9xLmuhBa7qrttCk87BgfWq93id5lAElAgNDvKB3HVMc30q7Yvwa3ciltebcIowjKRU
	 5ErxTFQh2jEwQ==
Date: Thu, 7 Dec 2023 21:00:28 +0000
From: Simon Horman <horms@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, jiri@resnulli.us,
	marcelo.leitner@gmail.com, vladbu@nvidia.com,
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next v3 3/5] rtnl: add helper to send if skb is not
 null
Message-ID: <20231207210028.GL50400@kernel.org>
References: <20231206164416.543503-1-pctammela@mojatatu.com>
 <20231206164416.543503-4-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206164416.543503-4-pctammela@mojatatu.com>

On Wed, Dec 06, 2023 at 01:44:14PM -0300, Pedro Tammela wrote:
> This is a convenience helper for routines handling conditional rtnl
> events, that is code that might send a notification depending on
> rtnl_has_listeners/rtnl_notify_needed.
> 
> Instead of:
>    if (skb)
>       rtnetlink_send(...)
> 
> Use:
>       rtnetlink_maybe_send(...)
> 
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Reviewed-by: Simon Horman <horms@kernel.org>


