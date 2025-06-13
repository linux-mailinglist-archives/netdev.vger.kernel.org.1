Return-Path: <netdev+bounces-197305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49235AD80B6
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 04:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCED63B5B24
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 01:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2291E8338;
	Fri, 13 Jun 2025 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvSZiZll"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21FB1C84AD;
	Fri, 13 Jun 2025 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749779999; cv=none; b=aOnrJ198i2ShhFDl7b38D26NJ2bYXkrpjepxhBfSk1iK3UGYby71vtHV6tcqNvShWGAw18bUtuWMK3apPH2Qtxeikc4drzY40ENJSTIYnkMI38mC6EE1qoetrBme0yZddjeE8Un2/WEaQVV6oGBGw6ttCxDq9+OhLpbVZ+PAxs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749779999; c=relaxed/simple;
	bh=PdQx8SDHF2OkhNpbxe9NUNMzYfyqf5xrF8iOKtmIe6w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qJ6QXu7CkdDeKW+FN3hwVWx3rZxNSsiYcM3e3o6GGbxbHBxLwi71RFdmNb5VJGAUZQzYDL8AOQcDhInv5CtVw6XREjz7XGxjpq1D5SF05QqiIjhp/6f+9L5vVbFv7OFioP8f5EGjCT6Reaw8k6pwljvBYuE8Ko8UeFm3s0BQVIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvSZiZll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3510CC4CEEA;
	Fri, 13 Jun 2025 01:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749779999;
	bh=PdQx8SDHF2OkhNpbxe9NUNMzYfyqf5xrF8iOKtmIe6w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jvSZiZll3nclK2PkENuIpFcnJ3jFjDsRG5/lkj6Wf5Y+8aqqRPDnZwsN0QOBqju3l
	 TylGIwx2vptMxQtlUva/uZEe66ngjecMKHthn4WGGI3ztulC5qJfdcxhqc1Q0bYVqC
	 TDzrZz6RecObZP14lcKo+dCK0Kv/RjgNQhBm9sxD8ciiyKhgsFXCXuTHjmo2qbG8Qz
	 ApJyrbT6MmXeA0xBPq2EBX5ifuNYzyAndXsG1ZFh8kW2wDZcT9WZ8y1/Sf8WnS9L83
	 rPGc+GlSDvAp7+6ONLir4xuuYc5V4rz4WRTK8YMYDhgU3jOeV/s4ESBT2j0LOdwzAn
	 Jx3QO9Njoueqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BB239EFFD1;
	Fri, 13 Jun 2025 02:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: Use dev_fwnode()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174978002900.187534.13912380514697676901.git-patchwork-notify@kernel.org>
Date: Fri, 13 Jun 2025 02:00:29 +0000
References: <20250611104348.192092-15-jirislaby@kernel.org>
In-Reply-To: <20250611104348.192092-15-jirislaby@kernel.org>
To: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, woojung.huh@microchip.com,
 UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
 edumazet@google.com, pabeni@redhat.com, Thangaraj.S@microchip.com,
 Rengarajan.S@microchip.com, richardcochran@gmail.com,
 linux-usb@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Jun 2025 12:43:43 +0200 you wrote:
> irq_domain_create_simple() takes fwnode as the first argument. It can be
> extracted from the struct device using dev_fwnode() helper instead of
> using of_node with of_fwnode_handle().
> 
> So use the dev_fwnode() helper.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: netdev@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - net: Use dev_fwnode()
    https://git.kernel.org/netdev/net-next/c/6d4e01d29d87

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



