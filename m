Return-Path: <netdev+bounces-251112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 277FFD3ABC5
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03A2D3081B5B
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5265337C11B;
	Mon, 19 Jan 2026 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIZex5KW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4F937C112;
	Mon, 19 Jan 2026 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832519; cv=none; b=TJJu68CiomzzZYZjDkMd3/r9wqBAYgNxEr/TTNwbsRrM3L2zkzw6YlwiLPLKN6uHAIJWYVM2fVKdyC1ihoFy/IJBtwS9hSpbJUo6ZQAFfIiDUtQRiiuErTUfG4lcXlpoYaLOIrc8RDrOvLJolDsMRw9UVqG4zyWWGuvmooq6slc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832519; c=relaxed/simple;
	bh=F1tg593Iulac28hQwmPWj1e2taFZOfYwB5QY91k2WWQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RLi099wBqwg8q5Sse16rU9B7TDOsQPmUuGJS/ABupwMRBxj8pkv2zTjTWoF8CgHIpV66BSo5lfZJ3JaGGUdXGaJLqDbER+4VQSgzMWPFzyy+A3U20SONcMXbIrPQ+NeBczuokfBjNOm0YRuHQfjobGj1kA7GoQ8L9Uj7YefIYUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIZex5KW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACBDC19424;
	Mon, 19 Jan 2026 14:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768832518;
	bh=F1tg593Iulac28hQwmPWj1e2taFZOfYwB5QY91k2WWQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KIZex5KWQ11CVUuq5Iqk/xPIqxlElIyWymZ+5HR3XQybyfPHU2Y+sSFr145mem6Al
	 7r93vekqelj9XyiUACSDWdson1WGMXNbbQiGDeIg8d7SMzDrHdBYB7gpQjFwfbD9tg
	 SmgbDkKBvAtvwPalaiQGtqzmKG7kzABO3VRUjxIIZZkizuTmZxfGGYTrEkTyOE46YP
	 R7doprWJGADOauE1Vecy7UVmpguJyhjzqYMDcmoOFcNgUQzEQLwM58uYMKeRW8hvEe
	 WUj6AsBC5/L5xRkU64mbrJxVp8idwKrFA/7FvRuoShvOZ4EGeweyW2tFvVOOYqtYtS
	 JgvDMw6Nn+wbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5A003A55FAF;
	Mon, 19 Jan 2026 14:18:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] Revert "nfc/nci: Add the inconsistency check between
 the
 input data length and count"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176883230827.1426077.9411051878811984292.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 14:18:28 +0000
References: <20260113202458.449455-1-cascardo@igalia.com>
In-Reply-To: <20260113202458.449455-1-cascardo@igalia.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, eadavis@qq.com,
 davem@davemloft.net, krzk@kernel.org, bongsu.jeon@samsung.com,
 kernel-dev@igalia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Jan 2026 17:24:58 -0300 you wrote:
> This reverts commit 068648aab72c9ba7b0597354ef4d81ffaac7b979.
> 
> NFC packets may have NUL-bytes. Checking for string length is not a correct
> assumption here. As long as there is a check for the length copied from
> copy_from_user, all should be fine.
> 
> The fix only prevented the syzbot reproducer from triggering the bug
> because the packet is not enqueued anymore and the code that triggers the
> bug is not exercised.
> 
> [...]

Here is the summary with links:
  - [net] Revert "nfc/nci: Add the inconsistency check between the input data length and count"
    https://git.kernel.org/netdev/net/c/f40ddcc0c0ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



