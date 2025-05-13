Return-Path: <netdev+bounces-190262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DC7AB5F0E
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 00:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974A78C04A4
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 22:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CB7202961;
	Tue, 13 May 2025 22:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NX0zv1U9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37578B672;
	Tue, 13 May 2025 22:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747174198; cv=none; b=Qtsi82zcNnk5jUMKQRtV+CZseYQj6pUWsONyPIf4WyxWm6e4WcJGYlwJ+iR348pZlGh1HcREoDgISJKQDab0rL3yx9elYBHClVH5DORqPTTF+kkzJ+vzGZR/UEWggVKJ/547CbgMHIrvUMyUiGvAA9P4JwRINXJNGIRebQK0Oxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747174198; c=relaxed/simple;
	bh=CuoB0qR21auBIS7t8r+wUd5t5czoU7L/4n2tHTDAVMY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=euHfynTFZo/gTMU+04VKWmWkpqo+daWM2WDwq3ojIQbJe0oBIeeyO3w4zbVV6FH4E6XgHoCwaQQ4NByfvN1LBXx28S0Q7r2Cng9XL4/NPnjdwU34TXXYnEl+h2rCHObswBdLC6WpQh5Uc/haLb/D/tsa5z/74l+NWRwooGJBLxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NX0zv1U9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FF5C4CEE4;
	Tue, 13 May 2025 22:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747174197;
	bh=CuoB0qR21auBIS7t8r+wUd5t5czoU7L/4n2tHTDAVMY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NX0zv1U9qLOYcC5F1x5pkTC1jQTpAa3hQpPn+Kg6LcAKwAv8cBvRYyrCwNaPFC4pK
	 pIwdJrXwcJeb0atAGMVwWVnI78aELEOysxZmLMTJGqLWu6uFQ8dOeLCZlP4Ss0VB1/
	 0jQiOs4C5fy+0dazakyEt8zegNCHCBKHaIpPpsslKeDzJRmVZWkZW6d7hrJqx6k7Zl
	 MgGPx218VJq8gRS7L3sMtYV1+eK36zwIchYDX7CKybnwm/FLxuviBoc7wXvfBLvtkR
	 bDP0hsFz2D6gtWQSHnX/cXIojIgHvAPCpTQnpIxm9enkBppCn5v4J8LvNJlwcWAsXs
	 ct9YJbyi1XTtQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710A4380DBE8;
	Tue, 13 May 2025 22:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] vsock/test: Fix occasional failure in SIOCOUTQ tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174717423527.1805570.13155176594875742702.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 22:10:35 +0000
References: <20250507151456.2577061-1-kshk@linux.ibm.com>
In-Reply-To: <20250507151456.2577061-1-kshk@linux.ibm.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: sgarzare@redhat.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 May 2025 10:14:56 -0500 you wrote:
> These tests:
>     "SOCK_STREAM ioctl(SIOCOUTQ) 0 unsent bytes"
>     "SOCK_SEQPACKET ioctl(SIOCOUTQ) 0 unsent bytes"
> output: "Unexpected 'SIOCOUTQ' value, expected 0, got 64 (CLIENT)".
> 
> They test that the SIOCOUTQ ioctl reports 0 unsent bytes after the data
> have been received by the other side. However, sometimes there is a delay
> in updating this "unsent bytes" counter, and the test fails even though
> the counter properly goes to 0 several milliseconds later.
> 
> [...]

Here is the summary with links:
  - [net,v2] vsock/test: Fix occasional failure in SIOCOUTQ tests
    https://git.kernel.org/netdev/net/c/7fd7ad6f36af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



