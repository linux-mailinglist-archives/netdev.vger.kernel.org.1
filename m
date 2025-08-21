Return-Path: <netdev+bounces-215469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE86B2EB67
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 04:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3ED564E0618
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 02:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6B8257444;
	Thu, 21 Aug 2025 02:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mjw0Zmyk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49418248F73
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 02:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755744598; cv=none; b=DWOgPYJQlTAUrxEw4ZJHBKl6folgHm4okoPp/rIwyj9Yc+uIiD6GNXnBvsizt0f2CsPJlBA0Bu1Ib0uKT3G0wKfTmmq1knK+OYXpuA1wqyPQ1aWg5VltnSWp+E4vPg7y4pLRBs+0H/eHWW7cRiOltTGR1AqttfZml3Iob42rBDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755744598; c=relaxed/simple;
	bh=FLQWBrTFLUNYv1xeWmwswcvvYHXjOm5Nr/5TAmN82Ms=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TGZmI1bqeY1SQ7vw+EJJRO25PshlBtWhRi2CSA1QzVCrbKfOt0qx8CF/Ww2RpUvORV873KL8gbEEkntzHrX3MubxV25zuPGMhQ6nQ2FAdxMOBqECwBndzwt8DvDbESQGlPXf9GgadSjNpxlvyrh9ECx89OFN86UjrKsY15E1x9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mjw0Zmyk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F15C4CEE7;
	Thu, 21 Aug 2025 02:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755744597;
	bh=FLQWBrTFLUNYv1xeWmwswcvvYHXjOm5Nr/5TAmN82Ms=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Mjw0ZmykYjGSF7zlXUQL35JbxU006MMrYYvTys+NZSnlyrCVafLQlVHvxkjHP/A4D
	 vQBkVYvWtIF6z0IohQY6zRE10OC9wof36uv0RY7tZchmic7x0+FklKi2jYMwd+bfDF
	 GlelSrnWP8OetHa2Eqdnc+XYIJ0PHBdmu6QLbwtGsEJRJsVEqciJ7oE1n44ontIdry
	 hKQONZ7Jm9hyNyTHzyEUIuSp9jiPOG7khWe2NmKQxcr9YAJEZGcFKVl+Q1H4kpQWsW
	 QiQzNUcARG8VadvaKHUgOxt6b+aGoLTZ5RT4wXdvjZOh/fqI4rnvQHuk0ZimbsiTOB
	 qrlQr4157Ud+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BA9383BF4E;
	Thu, 21 Aug 2025 02:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] selftests/net: packetdrill: Support single
 protocol test.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175574460725.485172.1295467090167643389.git-patchwork-notify@kernel.org>
Date: Thu, 21 Aug 2025 02:50:07 +0000
References: <20250819231527.1427361-1-kuniyu@google.com>
In-Reply-To: <20250819231527.1427361-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 Aug 2025 23:14:57 +0000 you wrote:
> Currently, we cannot write IPv4 or IPv6 specific packetdrill tests
> as ksft_runner.sh runs each .pkt file for both protocols.
> 
> Let's support single protocol test by checking --ip_version in the
> .pkt file.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> 
> [...]

Here is the summary with links:
  - [v1,net-next] selftests/net: packetdrill: Support single protocol test.
    https://git.kernel.org/netdev/net-next/c/a5c10aa3d1ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



