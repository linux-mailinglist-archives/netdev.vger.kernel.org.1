Return-Path: <netdev+bounces-206303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924F5B0285F
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 02:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EB4A5410D4
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 00:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD1F136658;
	Sat, 12 Jul 2025 00:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1k+o1cd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B4B2F43
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 00:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752280794; cv=none; b=b45RPyf7Ym2T/ZOF9GiFm6ihhMw2gcELlD07bLNVRn0zoiG9sH0EXn74hnoB3RK+kTj4ZU0CkjAJo4tiK8JjOGp1Msqd+WIe6S8Y8FVGE3t75WHosEJHBhcm6NKO0sLYJLaSxgFuVohWdGdpTTp9rx4kwvOeNdux1FWOJ77m8Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752280794; c=relaxed/simple;
	bh=AnCrGCq9QusUeCbIleHDvrzunIFdSeSe5GLJE2HZibU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EsMXuzg8+t7xjoGfmscA4ywM8XQXsWbkYWNuYBK5G3524DrcKCIhwpIy01hGQzU5k8kCbECeN7S7ffoO618vuhyJYn0n9q/LegzNbEt3uicJPt8PaDQ4m+AIodTY30BiLZYmyDT87j0WJR6dauyG7ufOr7BJEsMG01W/PEj1unY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1k+o1cd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D3EC4CEED;
	Sat, 12 Jul 2025 00:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752280793;
	bh=AnCrGCq9QusUeCbIleHDvrzunIFdSeSe5GLJE2HZibU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A1k+o1cdgbWODHMxTcu95epA4UvUIKo1Lgl+Ej+hV4AUGlJdn1oBMrHi9+jpjYHUp
	 G5RdqdVf3zXgf7vz6rdirpoYyxzr5l1B1RW0LYirepHsN7h+Z/GapbozJ+v5TEgaEB
	 qLNIXHy9msTQ2m+HCNktSj5IyuOvTDCOZFWsRy4YlFfwvnfsl9fk5BVoI7m0EcAf6F
	 p2Z3IQUIf7C+v9QUaXutuo6I6HWZzpKreTnj8Xv2DbgpL2+ofPYJILNArbxADBwBmK
	 NdrbQF64P+9jHYqlsky6U9Uh6iNLy21XQaR0xSY5OVUQJmwc7o/8Vs/hg/vRk5qyp8
	 8N80tQEodOHqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EABEA383B275;
	Sat, 12 Jul 2025 00:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests/net: packetdrill: add --mss option to
 three tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175228081549.2448508.320514294012274288.git-patchwork-notify@kernel.org>
Date: Sat, 12 Jul 2025 00:40:15 +0000
References: <20250710155641.3028726-1-edumazet@google.com>
In-Reply-To: <20250710155641.3028726-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, horms@kernel.org, kuniyu@google.com,
 willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Jul 2025 15:56:41 +0000 you wrote:
> Three tests are cooking GSO packets but do not provide
> gso_size information to the kernel, triggering this message:
> 
> TCP: tun0: Driver has suspect GRO implementation, TCP performance may be compromised.
> 
> Add --mss option to avoid this warning.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests/net: packetdrill: add --mss option to three tests
    https://git.kernel.org/netdev/net-next/c/f0600fe94986

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



