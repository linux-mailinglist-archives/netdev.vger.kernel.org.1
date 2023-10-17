Return-Path: <netdev+bounces-41773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9167CBE14
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B09B1C208A5
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 08:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B2D3C6B2;
	Tue, 17 Oct 2023 08:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1MTSSzH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A035BE6D
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD41C433C7;
	Tue, 17 Oct 2023 08:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697532619;
	bh=Z+kUJOkdirhX3e+4tHPAo0b6kXKMcGq8clE0sSwvY/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m1MTSSzHpu1HJqjwaitWxs5J1qRuGzK19hQyQx+YVUU5TcNRbdUO03tvEnv6VaDcD
	 lUYzUZ0j00JUKMMqBCSqv+NiSNyZQgnA1yBm8ArhSKgj1nKS58e6bZGOvym7CQ0Ywl
	 0rdy99UIbdEliTQkcN/4Q5kOFw7qSiq6JTf6vVWT1j1aWmoEg4yk8u2oN3T6azWC4E
	 yPMockLaldhkSmINolWKd9VHIitqEmL7GSfS1SxqZCqsmfQTWEuAi+EXLTlRRDtyI7
	 +LkfhRhL1ZspD0jNYsdcKuNaJuI0kh5hReyzUecaXzHqdQFMz+q/rOv9+O/4Hg4Brf
	 Dl55tfgzbbEjg==
Date: Tue, 17 Oct 2023 10:50:16 +0200
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com
Subject: Re: [patch net-next v3 2/7] devlink: call peernet2id_alloc() with
 net pointer under RCU read lock
Message-ID: <20231017085016.GJ1751252@kernel.org>
References: <20231013121029.353351-1-jiri@resnulli.us>
 <20231013121029.353351-3-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013121029.353351-3-jiri@resnulli.us>

On Fri, Oct 13, 2023 at 02:10:24PM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> peernet2id_alloc() allows to be called lockless with peer net pointer
> obtained in RCU critical section and makes sure to return ns ID if net
> namespaces is not being removed concurrently. Benefit from
> read_pnet_rcu() helper addition, use it to obtain net pointer under RCU
> read lock and pass it to peernet2id_alloc() to get ns ID.
> 
> Fixes: c137743bce02 ("devlink: introduce object and nested devlink relationship infra")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


