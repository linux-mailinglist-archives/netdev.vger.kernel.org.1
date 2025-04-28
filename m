Return-Path: <netdev+bounces-186595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3F7A9FD62
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 01:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AD905A824A
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 23:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35F02153F7;
	Mon, 28 Apr 2025 23:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCpATGTS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ECE1CD15;
	Mon, 28 Apr 2025 23:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881204; cv=none; b=JrRB/M4EbS+7V1nvdn0vjzA6qmFGTif4MSt7WSwgMdQfjSpCG5bffEDxsQO0JRKQG3947yCs2eshk4HmXmmJovZw9zEZcb/6933EnsiRSYsNYmICrxJnpBIwqTlXHT9y2VVM9QrrovzDjz4xa3hLgBlN+1Cnp3rfPgFFEuqN444=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881204; c=relaxed/simple;
	bh=Hyqk3hXF8RoDZe0RFSQDUQvXvCQhaScYWf9CTGFhpzY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MILryQ3wubUtSNs4f3n51StX1dOyfRcbRlPyuvIp0JJDSZtWrME37+cGqriU6aXNFWufwuPNkFye0uSQGHdEotgXqo1Z+6nuCB0hs9oclrK2IL6tmDOTxRdIyL4YbbE6EUSGUU3H9WEPEd9NH/Yv1Q65Dt8vJC1UziX0EwHfqtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCpATGTS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A836C4CEE4;
	Mon, 28 Apr 2025 23:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745881204;
	bh=Hyqk3hXF8RoDZe0RFSQDUQvXvCQhaScYWf9CTGFhpzY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BCpATGTSbTD45BRbQPhiWumhcdVHFVaxEMh6XEmJAPmdPwgdtAZObQFRm9wv1ybYc
	 FlQoeU+iUAZWDqxIxHEV7c8d9THU19F0i5/Gcqu4dZOqwEZ/c9ZnS1J8J/3So+WP2Z
	 jLk40MOE9ZQ5TJWjJEG5ttwI2V1LNbKjWd2H/bwMa5gawZi8bGAST0PaClmzTNNA02
	 DduD/gK397EkP1O6KYKhb2ET7cPvxe2tC5l3b4iCd32oOnUEcD5hUiGi+YGn3W9PP3
	 52WpIF/uijbqOslqhRkqJGCicDVNgB5myQYdako4p8vEAP5JnsQSg9+Vdsbi+fl7n2
	 D2QV7Iw0gJj/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BC03822D43;
	Mon, 28 Apr 2025 23:00:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netlink: specs: ethtool: Remove UAPI duplication of
 phy-upstream enum
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174588124275.1071900.5630286475181995503.git-patchwork-notify@kernel.org>
Date: Mon, 28 Apr 2025 23:00:42 +0000
References: <20250425171419.947352-1-kory.maincent@bootlin.com>
In-Reply-To: <20250425171419.947352-1-kory.maincent@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 maxime.chevallier@bootlin.com, thomas.petazzoni@bootlin.com, andrew@lunn.ch,
 kuba@kernel.org, donald.hunter@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Apr 2025 19:14:18 +0200 you wrote:
> The phy-upstream enum is already defined in the ethtool.h UAPI header
> and used by the ethtool userspace tool. However, the ethtool spec does
> not reference it, causing YNL to auto-generate a duplicate and redundant
> enum.
> 
> Fix this by updating the spec to reference the existing UAPI enum
> in ethtool.h.
> 
> [...]

Here is the summary with links:
  - [net-next] netlink: specs: ethtool: Remove UAPI duplication of phy-upstream enum
    https://git.kernel.org/netdev/net/c/10c34b7d71a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



