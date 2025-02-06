Return-Path: <netdev+bounces-163456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2120DA2A4CC
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 10:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61FEE168CD3
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88BF226899;
	Thu,  6 Feb 2025 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJJSInY/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48B422688F
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834803; cv=none; b=QZEcdItLhYbJqeORr6L3xxLC01J5I0SUooy9Q5QWWz8PpKn9YrY90cp7FQGS8e5g5BWSlUiq5GeriZCahmKXz04kncQgE7JmlZJXFlnJvpKI/K3RGG9ffSjBqaEKL3Y38khSskkscd9pW6Wl+brecOrmm4On59514bqP4E0NOL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834803; c=relaxed/simple;
	bh=EJ1QDcvIB6Em6HRR4NpWLJsXYKdhtrlIqZ8NprSU/vk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dJ/b5+lwItaL5ZgEUGdYdcuyTJfAEhz/zdwxeWucVPfwhzCRKUyzzAgEtfT8kTIZFL0ziFGd+b6E84TSaN3sn7VSTviNVpoALZlIvI6Dayh48c0tXmVzvFRnxKCd9SOP2VEMiD5s7Ye6dtn3u+Z1D83ehd3GB9HwZxkzlBxLPKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJJSInY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0E3C4CEDD;
	Thu,  6 Feb 2025 09:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738834803;
	bh=EJ1QDcvIB6Em6HRR4NpWLJsXYKdhtrlIqZ8NprSU/vk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nJJSInY/L359DPrhptw71ddoTqPJTlcAJXpclMDWbO/LWqRye+By2o5GvuTu5rC87
	 CqIQKLgsO3AUIOlF4Mqc0QuQzmyif/CuX8hH70/VTafj3ze2pfXcfImYNhw2kHP9y6
	 K7WYqxmkrtdrO8Yr1QpacZ85gJTN9ZGEZoKDrvseTZT9xPoKAVunqwScHy3P+YKJDp
	 Ob82wnbnZazD0aZ32a2tvTUXpyxWEHXOqdQXR/m9iwGrnzJPiDLaTgwTvmIt2zl250
	 WdE/NRduw5XNpzxPf2YMFattZxvpm8wxXz94B9/X8edZW/j8tPsAfknjfNJLVQscpZ
	 3oSqH+0x8WU1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC1B380AAD9;
	Thu,  6 Feb 2025 09:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/2] MAINTAINERS: add entry for ethtool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173883483078.1410600.7435481884720252709.git-patchwork-notify@kernel.org>
Date: Thu, 06 Feb 2025 09:40:30 +0000
References: <20250204215729.168992-1-kuba@kernel.org>
In-Reply-To: <20250204215729.168992-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  4 Feb 2025 13:57:29 -0800 you wrote:
> Michal did an amazing job converting ethtool to Netlink, but never
> added an entry to MAINTAINERS for himself. Create a formal entry
> so that we can delegate (portions) of this code to folks.
> 
> Over the last 3 years majority of the reviews have been done by
> Andrew and I. I suppose Michal didn't want to be on the receiving
> end of the flood of patches.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] MAINTAINERS: add entry for ethtool
    https://git.kernel.org/netdev/net/c/1e3835a8aea5
  - [net,v2,2/2] MAINTAINERS: add a sample ethtool section entry
    https://git.kernel.org/netdev/net/c/82b02a7c4599

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



