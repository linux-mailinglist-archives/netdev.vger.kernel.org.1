Return-Path: <netdev+bounces-71142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D42852709
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 02:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 424FD286559
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 01:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11D51EB33;
	Tue, 13 Feb 2024 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4809Rso"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3B11804A
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707788426; cv=none; b=uCDmffAFyHodxaiXDhrtNGuz578MoWr+v7+GSuhxFheSDknlTnzWoIgjIUgwocNl24l/wka7q/9cWeY6ngM9txIJtsMzOqpcwfoDUJYFHr0zqFXJpffzzYalsIhNRsX4PChnTF2V1iEX7fGJBBxB0z0OlRyGeWoBVT9vkaYRZcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707788426; c=relaxed/simple;
	bh=kcWcjZ5AO/GlLeZ8wINrfAOxk82Sv96wZuZOIygYE64=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NLO128SdRp9fu2KY62JwVdHsQk9XmLRuudUWTgHtJkyFWSidXVmJ9C7J8MjMQ+ZDw19QqZsLg0aA32vqsbWYoOxY8/3D0aJAN3E9PxAuo+VIvlDTPRnWEC3RDSsR3X1qREhj5Xnzuif4Z3xhH+gQko/vK4GNQAa8WMyPvJFQh/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4809Rso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72F01C43141;
	Tue, 13 Feb 2024 01:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707788426;
	bh=kcWcjZ5AO/GlLeZ8wINrfAOxk82Sv96wZuZOIygYE64=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z4809RsoBId2lpOkUcDVRadBkwfgQ8KORclEjYy/Ad4v0uZMkO1HOSBHlRLsdq1Hr
	 yWmbAdSnMlIAFKpM0SwDAlrBnhF56W67iJZQYR0IQpLeLUf5acDtRsS2dRp1ex1ouM
	 CZlUoCXfwht5qOoZUW44S0rqCGHorz7FOPQyGAyHr8CiiG6OmyZj5uJxNWlB2arBwI
	 e0gUoxDsyztqiAc1nBaSoEgOOnjyYGJl5TFsKWFLzaaiZQeaC0E09U6p+TVqdn6+Dl
	 sNW1KknfSp9V+b164oBPly+6n1PCiPBYNvWWwPeyDgAOXzFWGBwB/rbN0yZaqQRkCA
	 r+INDZ0IN5yNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 627CCD84BC6;
	Tue, 13 Feb 2024 01:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv4: Set the routing scope properly in
 ip_route_output_ports().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170778842639.15795.17520877450881378161.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 01:40:26 +0000
References: <dacfd2ab40685e20959ab7b53c427595ba229e7d.1707496938.git.gnault@redhat.com>
In-Reply-To: <dacfd2ab40685e20959ab7b53c427595ba229e7d.1707496938.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, dsahern@kernel.org,
 jchapman@katalix.com, ap420073@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 9 Feb 2024 17:43:37 +0100 you wrote:
> Set scope automatically in ip_route_output_ports() (using the socket
> SOCK_LOCALROUTE flag). This way, callers don't have to overload the
> tos with the RTO_ONLINK flag, like RT_CONN_FLAGS() does.
> 
> For callers that don't pass a struct sock, this doesn't change anything
> as the scope is still set to RT_SCOPE_UNIVERSE when sk is NULL.
> 
> [...]

Here is the summary with links:
  - [net-next] ipv4: Set the routing scope properly in ip_route_output_ports().
    https://git.kernel.org/netdev/net-next/c/a3522a2edb3f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



