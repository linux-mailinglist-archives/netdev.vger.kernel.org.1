Return-Path: <netdev+bounces-218008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 852ECB3AD04
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 23:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16AD1C867E6
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 21:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D743B27AC44;
	Thu, 28 Aug 2025 21:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnU9QyU9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C017404E
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 21:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756418029; cv=none; b=ZGGQEI7p7/XngEKjkP0QB08MHqxZEsFK958DETNjcfJAhUi2heCpdEKsNtYh+XsYBDry5AEAWd8iqIwIQY1D5Vdf98TbPxINHp8cp/pJHVuY2Begnmj0iarXW5WrS789ESS33ftOoxL4QmJPvdxOMPGM2SPRlgtP6uUqtf0UKso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756418029; c=relaxed/simple;
	bh=3bNC3RLCFdjWrW7LXg3Ia8zeee0R/LGJCPW5Qz13j2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYR/WnkQDUDivQtnWZrLxeTcZGQvCamvmiIC8fyj4W/T2ZK4DI7Msj89bmXeBTTFHXnCnjSMYQIaETC1Go7wOd6sLjlUcIka1mIs4IUwdRDjHB+Ui7DptYB254NxajbhbLrSpubl88UhdxuhGMTIJF+SLL+H454+SUyaU5J93qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnU9QyU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB074C4CEEB;
	Thu, 28 Aug 2025 21:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756418029;
	bh=3bNC3RLCFdjWrW7LXg3Ia8zeee0R/LGJCPW5Qz13j2c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TnU9QyU9+aIqClV8VseE9IA7rENhOKuhWoisEjVseinymSFZSsbTQ80OEv67CcINe
	 bfQ1dA2J8n0945s+5vrHX/U1dqnjXBl2pIpefOnKyFdK4SsBikLzRwkuKG/poZNNkB
	 UoSCp3tlVu2n7QA34aLn+b87eRcAwcRqykYsHKqyzguJ2MSkNitBqEMfgFnffkjAUE
	 LcwC1xYX8vVa9dxYl0GE4CMBvFxY1SdnrS9Xhoj4JxG4v+qT/tZSvI+6Io6YQxmZUk
	 vmSMoJ5U1IC+S0nK/SV+E+Uo/Wrc4hq0iXNdArC5fctNVfTpbC0YB41nvGrVUpEk80
	 HQ4QVpDVTyM+Q==
Message-ID: <ea8cce79-5ad5-42d2-9857-2f969f36b504@kernel.org>
Date: Thu, 28 Aug 2025 15:53:48 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/8] net: dst: introduce dst->dev_rcu
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20250828195823.3958522-1-edumazet@google.com>
 <20250828195823.3958522-2-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250828195823.3958522-2-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/25 1:58 PM, Eric Dumazet wrote:
> Followup of commit 88fe14253e18 ("net: dst: add four helpers
> to annotate data-races around dst->dev").
> 
> We want to gradually add explicit RCU protection to dst->dev,
> including lockdep support.
> 
> Add an union to alias dst->dev_rcu and dst->dev.
> 
> Add dst_dev_net_rcu() helper.
> 
> Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/dst.h | 16 +++++++++++-----
>  net/core/dst.c    |  2 +-
>  net/ipv4/route.c  |  4 ++--
>  3 files changed, 14 insertions(+), 8 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



