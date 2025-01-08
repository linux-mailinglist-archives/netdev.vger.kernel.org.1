Return-Path: <netdev+bounces-156125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D08EDA05089
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 03:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2780118867FD
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 02:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9519015B0EF;
	Wed,  8 Jan 2025 02:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RImOIx1n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B4D13CF9C
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 02:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736302821; cv=none; b=qMGqkgsKLBsW6cm0OTj+uDxerMv2tWG2/RibXTeGvwSj22Lakck8W95Ff95igMNhrR0IP3JP5JQPBF9UsvaU8hJNVnKmmYojW45oD2yOu09kwmg5DcCdQeq3++x0ZridHbMQNozxd+dn9o2J6SrhJnKALDies9HlfiWU7N4DkY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736302821; c=relaxed/simple;
	bh=7DlerrEmAlQi6pH8MC6mF1hzA2AFR38yUaHQuOz6akc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Rm0rPJyc5W1HHJZDwk5iOYlzievRZQaGjpFgnZpRzyD0wUwL4A+WaUYD1o8k+7wca8vt+ecMQ5wurvxYJQqwansu8wrwgGJVDy8FY8EEvLrHHER4cUdu46EakPI18sHS9zy7DUVipYQkTE3Hkl7v5UyUZbhNRmKj6z7JJWHxYJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RImOIx1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12738C4CED6;
	Wed,  8 Jan 2025 02:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736302819;
	bh=7DlerrEmAlQi6pH8MC6mF1hzA2AFR38yUaHQuOz6akc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RImOIx1nLJ72UxKB7AoBlavQ2APAqsWpz1ODsll9qmcmuriFbU8efeMrKt/Sf4AXC
	 nlOYw/n2shC4pXi4wRAuXHflTy90Qiht1MrKZAyGB6IyFUirHAXrwIRMY00oE4COlI
	 G8Nv2WTiEv7cOZ1Epk7tgpYTg3mIPnPy2/rYebotKoRVG/qBeO3jttVkAQZIACA2eo
	 o3T9L02ultOOcvj9C7biyzm+xPWhpgMXe/XGUPa/oYQE8AVL9ZmhtzjK9OHp8LonAs
	 EbV2mgS5BsW7Y1sjPGef6c5gly3RldgnJJirntCipBdTidzjyIxMqKZ9ROo+pXZTSk
	 v1WY32u7Vnk2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDB2380A97E;
	Wed,  8 Jan 2025 02:20:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] tools: ynl: decode link types present in
 tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173630284048.168808.10944441436532472211.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jan 2025 02:20:40 +0000
References: <20250107022820.2087101-1-kuba@kernel.org>
In-Reply-To: <20250107022820.2087101-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, donald.hunter@gmail.com, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  6 Jan 2025 18:28:17 -0800 you wrote:
> Using a kernel built for the net selftest target to run drivers/net
> tests currently fails, because the net kernel automatically spawns
> a handful of tunnel devices which YNL can't decode.
> 
> Fill in those missing link types in rt_link. We need to extend subset
> support a bit for it to work.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] tools: ynl: correctly handle overrides of fields in subset
    https://git.kernel.org/netdev/net-next/c/69072db934df
  - [net-next,v2,2/3] tools: ynl: print some information about attribute we can't parse
    https://git.kernel.org/netdev/net-next/c/7aae6505351e
  - [net-next,v2,3/3] netlink: specs: rt_link: decode ip6tnl, vti and vti6 link attrs
    https://git.kernel.org/netdev/net-next/c/6ffdbb93a59c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



