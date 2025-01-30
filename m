Return-Path: <netdev+bounces-161671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D078BA23281
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 18:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4866D161B8D
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 17:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCF81EE7C4;
	Thu, 30 Jan 2025 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wg5Da+OR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1C32770C
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738257009; cv=none; b=Mea6YZMX7sMEWLQNCdkZRZ8rMJdbABRvha3DPRRzZXr3p/oJk/BEAIxcaDNxv1FIbK7q+ZW9gWaqgHwDv6TPJinDXQ68FqGy43DZT/peLnskEmDC+DsxEJTc2fCSHgiRFWMT4TRp60ea1z/cpowQ44M5519DEp61CjQ2EZV9+XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738257009; c=relaxed/simple;
	bh=dCgLL8L5wAw2aXY+EZI+B2Uq5u9q7/e8HyXuQKwAA34=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y+8YRC8oQ8sQKVVvOKIaOh1awD7z0B98xG058tqBgjC7CFip9DnAmVIViTEyB/IwVY3+XQWyeQ0zspYGp392s1/4yYfBzceD0Fjx2M5iS4N82S28Cn8eAv04uzV2IQvLKU9CczmTpdhc8/cXpVWH5pqmwS1N55M5w0DZqxaEJ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wg5Da+OR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E5BC4CEE2;
	Thu, 30 Jan 2025 17:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738257009;
	bh=dCgLL8L5wAw2aXY+EZI+B2Uq5u9q7/e8HyXuQKwAA34=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Wg5Da+ORsFU8LqsKe2pzfnAO1HmFJQVWCqHTgTzTZTJmNap9jRvd1CKKHs+MXetpr
	 yo+TWDciOSX4YhsAynVdBaDAf0pbAuVH+ox5WTFntUFZZjqf22yTxl5lmulpisWx6O
	 pRiyEggp+T8maBsxWlp6Z1YB91/pbOP0OdiBo39p7Gw9p0bRqsaF2KYFZxxVA4IXql
	 e1vT9U+rcZbXwszTJgShWzpvg0vkeQz3QQmLmkZsk2zduZNZXwtgoAetrRL4yYO1jg
	 H9O1lXrW4lqEZwuvEvRyLNKoBKNiFGKLO2att9izPCFfbeztgGjgH2Wb7yr/iyxmA1
	 dKpyE1Kwn8X0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB7E8380AA66;
	Thu, 30 Jan 2025 17:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: revert RTNL changes in
 unregister_netdevice_many_notify()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173825703539.1021356.11890208234479484104.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jan 2025 17:10:35 +0000
References: <20250129142726.747726-1-edumazet@google.com>
In-Reply-To: <20250129142726.747726-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, eric.dumazet@gmail.com,
 syzbot+5b9196ecf74447172a9a@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Jan 2025 14:27:26 +0000 you wrote:
> This patch reverts following changes:
> 
> 83419b61d187 net: reduce RTNL hold duration in unregister_netdevice_many_notify() (part 2)
> ae646f1a0bb9 net: reduce RTNL hold duration in unregister_netdevice_many_notify() (part 1)
> cfa579f66656 net: no longer hold RTNL while calling flush_all_backlogs()
> 
> This caused issues in layers holding a private mutex:
> 
> [...]

Here is the summary with links:
  - [net] net: revert RTNL changes in unregister_netdevice_many_notify()
    https://git.kernel.org/netdev/net/c/e759e1e4a4bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



