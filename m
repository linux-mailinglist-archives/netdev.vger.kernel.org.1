Return-Path: <netdev+bounces-24169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B15E076F15C
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 20:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0502822F3
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 18:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE7125179;
	Thu,  3 Aug 2023 18:04:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1581C1F16D;
	Thu,  3 Aug 2023 18:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B72AC433C8;
	Thu,  3 Aug 2023 18:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691085865;
	bh=LL1vrsFy1dssemldmNBSbAHGGN6JdRVz0pM8JMK6Sjg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OIDBPg8rvoHvEGa7a643/FQCsSpb3gW7M98X+HcIe/tlhzkqA/Xrl9Q4D/GWtIdHh
	 LnX1m5dA6U5wiey88/ZMQ5TNvcrJAguG05HCk+Ypbu0C+v5eppsr5yIN/uxPfZIUF7
	 OUwe1PVdk3FZs+byIV72nuXc5R1gWf8EJgLjr9LuBGS5heK++1d3+cDhUVkktUBpqG
	 0wXGwBPFwYvZg4D1IVebZ1rzkvXV1tmV1/AdIqsqJCicOr5K6lXmwWkpd5x04sdHzO
	 84KfJmeWUci5tVWsxXcRFSnJOgYNhq5TZkfEXw9vnOexEO12gcvtplspcsZ63qpc30
	 J1oijLslIa3wg==
Date: Thu, 3 Aug 2023 11:04:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Xiang Yang <xiangyang3@huawei.com>, martineau@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH -next] mptcp: fix the incorrect judgment for
 msk->cb_flags
Message-ID: <20230803110424.5ca643c9@kernel.org>
In-Reply-To: <d3fa9b41-078b-4bb5-9f5c-d8768b787f4d@tessares.net>
References: <20230803072438.1847500-1-xiangyang3@huawei.com>
	<d3fa9b41-078b-4bb5-9f5c-d8768b787f4d@tessares.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Aug 2023 18:32:15 +0200 Matthieu Baerts wrote:
> This Coccicheck report was useful, the optimisation in place was not
> working. But there was no impact apart from testing more conditions
> where there were no reasons to.
> 
> The fix is then good to me but it should land in -net, not in net-next.
> 
> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> I don't know if it is needed to have a re-send just to change the subject.

Looks trivial enough to apply without a repost, but are you sure 
you don't want to take it into your tree? Run the selftests and all?

