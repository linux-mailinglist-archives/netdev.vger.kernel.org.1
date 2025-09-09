Return-Path: <netdev+bounces-221477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDE9B5095E
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 01:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9AF31BC641A
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603AF292B44;
	Tue,  9 Sep 2025 23:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnVLeE+4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3954F28E571
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 23:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757461807; cv=none; b=DqSoINOMl3TNGiAMcs9iqrq16+JwwSQd3hH/lg4707ACR5+qGEvCOiMp/YKZpG4u6rWMAmP0kfy1haWxgug0JgdA//zzCc5rgVCti3lQposzfUjZM/RLHy3dNC2C4xIWj0rVrkNhgEBFAGCUbPZc+JuV4o7+5+Zfmhfey8mB6yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757461807; c=relaxed/simple;
	bh=jrNoEqJM4dj6Scz61rN0p08E01VS4lrXTwQYcE1DmEc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O/+TfpUIWFJeasDix5wnWMS52g5+QIBZO/IF21H4lEzwFVsB5f8/2FR/j+WmeVxFxaHD6ZuVElHDP17XCqg3F7Ib2nzxSBQmKyR7UihBK7MCCGCIZrQT2AKTzmwiwY/s3FSyXXib0dEMZo6vXkZG1BCzdN9nJvEAuPBMt7pUdOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnVLeE+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1310FC4CEF4;
	Tue,  9 Sep 2025 23:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757461807;
	bh=jrNoEqJM4dj6Scz61rN0p08E01VS4lrXTwQYcE1DmEc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AnVLeE+4wsAwctv6hS8P75HHfTsg3yHn58QVFzI0JvF4JZqF4F0jzQoUaU3ib2YDg
	 9J5ZGiT3swNyHN4SYeisALPwGWNlFY6lIpUiAWLUpdIlU5JisCdYZHtO+qTOZdPZdH
	 84gA6h1MVCwkXpg9RSnWCLX9kwKfaliWecCAjQ5nZc5eHpNSiboHCQNG4XBZqoUuBv
	 tBxUx/W1QbV8u8MuLiE2eBslkd3kcxmWMffAc3I01rKdK/ypEVwxrLPwH0urKzeBRu
	 HpUMskgbDsmabF1T1aJFfBiD9/0hSQp38Og4r1KAy7LkuW41Gntx4wJfcPtw6ugoE8
	 CxMxguZMuhvbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EF1383BF69;
	Tue,  9 Sep 2025 23:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv4: udp: fix typos in comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175746181023.849476.3424024894371594568.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 23:50:10 +0000
References: <20250907192535.3610686-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250907192535.3610686-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: dsahern@kernel.org, willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  7 Sep 2025 12:25:32 -0700 you wrote:
> Correct typos in ipv4/udp.c comments for clarity:
> "Encapulation" -> "Encapsulation"
> "measureable" -> "measurable"
> "tacking care" -> "taking care"
> 
> No functional changes.
> 
> [...]

Here is the summary with links:
  - [net-next] ipv4: udp: fix typos in comments
    https://git.kernel.org/netdev/net-next/c/d436b5abba4f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



