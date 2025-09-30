Return-Path: <netdev+bounces-227308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AE3BAC26E
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 11:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25947482EC9
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 09:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E6E2F3C3A;
	Tue, 30 Sep 2025 09:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIHwYuhY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783B72BE7B1;
	Tue, 30 Sep 2025 09:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222814; cv=none; b=kgsnifCJv2KLmDBQVmJ1Smb7xUbDv8Uems3snCTr9iVUwV3GD+HkoKImyOlDvUDqzWLdZbUbkAsaMmYqRk8T26j5ELVwdVSQU0hAX1yGTnHEx1AQzCTlr+Duh7y8ob9zOPTwcetl1MDrTF+3xSsGskTb9/ic1HDxaeq+PZBwias=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222814; c=relaxed/simple;
	bh=CXza0DCQpDDLC4T55TTY0tnPc3ewNhc/n6NLvFjrCJU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ARMUvN1QZOV9DMUcb3wQpW+zKRtlO2hvzTtqXPYY+RhQTb/Mz088xJuV4Jx3iZ6F42EEtGWdztLJVsW3oeHtuPUB1Ox4qrAYAhb2pb2Sd29Q3q6ioymRlF1YSz7jwdVAouxBaTKxb+HlC/vjhfOkjvGIqlExaiiBz3eCVr6gRpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIHwYuhY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE5FC4CEF0;
	Tue, 30 Sep 2025 09:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759222813;
	bh=CXza0DCQpDDLC4T55TTY0tnPc3ewNhc/n6NLvFjrCJU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IIHwYuhYkmPrUxfSSeL1obJJapQrwjJk7NFPyKSi+mmU2/HXW2m9h+wdMBMOs/rmt
	 oN8UMUlPVg9h8mpbbuF29j4YhFuv5n29+EvUdGqE7QyGPmTiXG1503KjBTwB6Sm+4K
	 fWBAM9hbBt6FMU4zAw+5lZGBS10FzpKb/CBmnUlex0o2Fp3loVTVh+/GsgdeOqmjFo
	 0EJB6po0Ln/1VhioGg00qQ1n+hcd944hQ7BFkZJtnJkS0nHDRyh/XsqDAhLgFJy9Qn
	 sRKoDp+WrNwIzhZDy9nhRw24PHc//58HuGzBnX7yTD4E5PAo2hol9LVOV3jcohBHHb
	 jsXVL0uYn6wVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF2239D0C1A;
	Tue, 30 Sep 2025 09:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: enetc: initialize SW PIR and CIR based HW PIR
 and
 CIR values
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175922280676.1902251.2156544414820844961.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 09:00:06 +0000
References: <20250926013954.2003456-1-wei.fang@nxp.com>
In-Reply-To: <20250926013954.2003456-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Frank.Li@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 26 Sep 2025 09:39:53 +0800 you wrote:
> Software can only initialize the PIR and CIR of the command BD ring after
> a FLR, and these two registers can only be set to 0. But the reset values
> of these two registers are 0, so software does not need to update them.
> If there is no a FLR and PIR and CIR are not 0, resetting them to 0 or
> other values by software will cause the command BD ring to work
> abnormally. This is because of an internal context in the ring prefetch
> logic that will retain the state from the first incarnation of the ring
> and continue prefetching from the stale location when the ring is
> reinitialized. The internal context can only be reset by the FLR.
> 
> [...]

Here is the summary with links:
  - [net] net: enetc: initialize SW PIR and CIR based HW PIR and CIR values
    https://git.kernel.org/netdev/net/c/2aff4420efc2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



