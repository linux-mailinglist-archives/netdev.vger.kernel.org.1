Return-Path: <netdev+bounces-223826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC09B7DB25
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D2C164169
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 00:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD211DB154;
	Wed, 17 Sep 2025 00:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0hP5AXc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC8031BCB3
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 00:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758069618; cv=none; b=BJC8Svl1I99WHaY1N/2hsql7hUutyx5Cka9SoX6bqB4C/ZwBdGBbau+dBJH9mexdm7E8Cu4LulsOatJjF5xczZWucna3ywR8KMEp1ISmepSwPW94uxQBb3ay9GFAMg9vTGxXdSmFPWIf0X1i9GgaELZwKdo6DQTat5BMwPKymo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758069618; c=relaxed/simple;
	bh=rnDkxy/4mWZk9SkftVtBJu0BQs1wlm10vns+kUnGYNw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hnpR02cuWCoRgIfnrSIaX4lYOSC4XPoCiS2nK8rwQVYi6Z9dFyLa0iYN8GEQzmFz8qiWMw+sb3s64v5ZxHqAmXiP24gJwGMBuD0/t1bXr97znzYY94YOKiAyWymOX5XDm9+Zy8lOfOY/Z31q0/Fb7Opw12NteMIp3rEN8tsdUUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0hP5AXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BF0C4CEEB;
	Wed, 17 Sep 2025 00:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758069616;
	bh=rnDkxy/4mWZk9SkftVtBJu0BQs1wlm10vns+kUnGYNw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l0hP5AXcwPeYBvMEvlEmlVvBsl6m6jUSC93yAG/BD9y8jn3IKysIoZ/jjW2HvPYG5
	 tjBKeSfdHwFtleLXnhUKFMllM98p6OFkuJUKCNO1AnxyM+oN/SE8j/TtlAhTRoHXVK
	 LDAScw8CDRJGrDcoQsQbErJ7L1BH9AMDJeP+EV3s79jh/BO4zoHctarF67SetFjW3+
	 JEcAs/QMdmioyBjDay3ERpZr+wS8hUjGEoVRqtm6JgKajhKLESThnC+ANc+vlSo3XX
	 3jcTUpDJkmP87eBEyYooWU1LKZtS3lcEPXmUQPaI/xRKfi0ht5V9Pa3t1saaf0qg6F
	 k3pD12SKBnZCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFA339D0C1A;
	Wed, 17 Sep 2025 00:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/4] batman-adv: Start new development cycle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175806961775.1416090.18211005840484684861.git-patchwork-notify@kernel.org>
Date: Wed, 17 Sep 2025 00:40:17 +0000
References: <20250916122441.89246-2-sw@simonwunderlich.de>
In-Reply-To: <20250916122441.89246-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org

Hello:

This series was applied to netdev/net-next.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Tue, 16 Sep 2025 14:24:38 +0200 you wrote:
> This version will contain all the (major or even only minor) changes for
> Linux 6.18.
> 
> The version number isn't a semantic version number with major and minor
> information. It is just encoding the year of the expected publishing as
> Linux -rc1 and the number of published versions this year (starting at 0).
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] batman-adv: Start new development cycle
    https://git.kernel.org/netdev/net-next/c/e89888a1e778
  - [net-next,2/4] batman-adv: remove network coding support
    https://git.kernel.org/netdev/net-next/c/87b95082db32
  - [net-next,3/4] batman-adv: keep skb crc32 helper local in BLA
    https://git.kernel.org/netdev/net-next/c/d5d80ac74f80
  - [net-next,4/4] batman-adv: remove includes for extern declarations
    https://git.kernel.org/netdev/net-next/c/629a2b18e872

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



