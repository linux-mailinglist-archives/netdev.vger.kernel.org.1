Return-Path: <netdev+bounces-80717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CFA880A0E
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 04:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B38FB21E3B
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 03:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5642010A16;
	Wed, 20 Mar 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhMsKjZx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BDA101EC
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710904229; cv=none; b=AXnAcROVYajohy2zB0lbwXBSv7YeUuT9hvGapkG9SkgqdHIBrYNumo8BxkxZcLsyosbFDdwhFZ9spl1j942zMd0hJZC3chC2WZ2na4xXSFrTFBis7DDCLgxa+peeIiR5AY5yUhw5K+tEyUVEA81YRZOqw+rH25h8M2QTvUxOgUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710904229; c=relaxed/simple;
	bh=XC9LExbGc4sgbkJI9YoBREazlw1B/FA8E0LAhQeZFR8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PL2cHD1zDQXwN53mbr8vOGPjC9JTrrpPStl7YIK6HYuQVVJsaEyB9OjkAt2So8g5QPgp0h4zE1F2QY+Pl21gqZvPkdxNLB+t/Ffobl03jzm+ygnFjnTSD1UjhBHfRwB1RRLoGVULfh1M231wyJ101O61rQZA4J4doiykUCX9R0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhMsKjZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9255C43399;
	Wed, 20 Mar 2024 03:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710904228;
	bh=XC9LExbGc4sgbkJI9YoBREazlw1B/FA8E0LAhQeZFR8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WhMsKjZx7xhqlOML+imkD9o0nN5SCxBZOI18RIxK9X348h3MuHlyMRQANHChjHBvN
	 d5ZguWd9cmCffCTe1gF0G/W/zbOn3xI7isT8EQrGK14GWLGAToQXULvZj9CFMIrXCE
	 f22iMuJWeVwEXNyqbqxxi2bnGZawe0MS7Fgw3G5pbZJMQ/dGV/XxCMsinnL809EcUp
	 fQmpK4ESauqYOWtHl4CfcQgQCUAYJGkVZoljVPLo4xXiMBElCT+RfCIK/0EjVFXxd9
	 Az1HbY6VpKpCqYxeRKFmwLt2WDhenefBic+HHOpbjoxeZQgvIh+BhdjCb08Sd6YYSH
	 1VuOWmGYYdBtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B837ED98301;
	Wed, 20 Mar 2024 03:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net] devlink: fix port new reply cmd type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171090422875.19504.8889845619032895082.git-patchwork-notify@kernel.org>
Date: Wed, 20 Mar 2024 03:10:28 +0000
References: <20240318091908.2736542-1-jiri@resnulli.us>
In-Reply-To: <20240318091908.2736542-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, parav@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 Mar 2024 10:19:08 +0100 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Due to a c&p error, port new reply fills-up cmd with wrong value,
> any other existing port command replies and notifications.
> 
> Fix it by filling cmd with value DEVLINK_CMD_PORT_NEW.
> 
> [...]

Here is the summary with links:
  - [net] devlink: fix port new reply cmd type
    https://git.kernel.org/netdev/net/c/78a2f5e6c15d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



