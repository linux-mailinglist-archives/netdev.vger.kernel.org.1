Return-Path: <netdev+bounces-29101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 642A77819DB
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 16:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E981C209D0
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 14:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1D46AB3;
	Sat, 19 Aug 2023 14:03:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AA846B1
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 14:03:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AA1C433C7;
	Sat, 19 Aug 2023 14:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692453831;
	bh=mrJyFUN9U5faKJQqVn/J/5CdUzJSntmAL7ZqeF81W9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NPG7J+A6YMBxDWk2bRx3bye26W//6iO/oBGFyjWyGxeVS0IgdPubFCrvDFWsEUaHz
	 0MCGkjx0uaNXgK6wQCRmVHh6X+6DqM1fi0Ub+MVwiHPkoZ32T9+abSLXmzLgfOCJIL
	 Yq2Ugypeim7ZUz65f5QuwzS2YVi2Q9XMcxOJEI466tV+rhOfDD9bgDyS5afiwFDnh4
	 6oiekw7Du6WhX9aa/viHAU/gke2SwAzT/zH45/1OTvWnhwjgAHZlaNVTQ2jXepr5og
	 ok9nvcl3SWDbzgtcXVJv01t303N9spQ8lFIiByXq01J9ZU4XRfNEMVkBP83ruLERTn
	 cXo1fUuVzER7w==
Date: Sat, 19 Aug 2023 16:03:48 +0200
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: add skb_queue_purge_reason and
 __skb_queue_purge_reason
Message-ID: <ZODLxBR7XP+vS9t5@vergenet.net>
References: <20230818094039.3630187-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818094039.3630187-1-edumazet@google.com>

On Fri, Aug 18, 2023 at 09:40:39AM +0000, Eric Dumazet wrote:
> skb_queue_purge() and __skb_queue_purge() become wrappers
> around the new generic functions.
> 
> New SKB_DROP_REASON_QUEUE_PURGE drop reason is added,
> but users can start adding more specific reasons.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


