Return-Path: <netdev+bounces-37950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F74F7B7F8A
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 14:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3BFB82813CA
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 12:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADA0125AE;
	Wed,  4 Oct 2023 12:44:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C33101F6
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 12:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79B6C433C7;
	Wed,  4 Oct 2023 12:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696423497;
	bh=0V0CfSRBKlx72H+jVZOyuYK8/XWD0Ufu/CzgXYZ2O+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rA8u+ti5zQwp6pG/YRmBSlYK8lqLYxqkxUB3u1xwjiCTjdR9quZyawcvKv3IO1CHQ
	 u8TmnVCF5XBgbgAXTMGGwVGSrJ5/ob/bB7nwlB/z1uH4ZXHRvUbPjjeMwivzpcYbXS
	 ogkfDqx0dTRWcBJClGsUy4bm39ZtoBuuWj7PGUvWfWCPoxd9D6+81LI3kEZhpZQmI7
	 Y7iQR9WbfjBLoJVH1LyJKuq75WR0wiTd/+0wqqSG7jnY7ovrVQDPusI0hg3HpOZZwE
	 B4yf1Kb+MWP1/5pcdHrPtUmdIBi/n+6PXyscXm/zgsqJDjC55SUgY1k+toAwVZ/MtO
	 9qk7qaX5ABWAA==
Date: Wed, 4 Oct 2023 14:44:53 +0200
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: skb_queue_purge_reason() optimizations
Message-ID: <ZR1eRZhuR9OXNw+M@kernel.org>
References: <20231003181920.3280453-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003181920.3280453-1-edumazet@google.com>

On Tue, Oct 03, 2023 at 06:19:20PM +0000, Eric Dumazet wrote:
> 1) Exit early if the list is empty.
> 
> 2) splice the list into a local list,
>    so that we block hard irqs only once.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


