Return-Path: <netdev+bounces-243071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00580C9931D
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 22:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9C1663454BA
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 21:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB08B27E7EC;
	Mon,  1 Dec 2025 21:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6XrzaOr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3AA26F476;
	Mon,  1 Dec 2025 21:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764625094; cv=none; b=Ft/BdGufo05vo9Xoxuphwe788fI61/cZJz+3kl8a+3pAQ1qKzCZqUvYygP+/I48ZLw7So3lSCrBiqtpI53z1PGZzD63LRjuXiSieIPY1ZnIQGXF1oUZcP5Up8kGyXE7MoFqcUNYRh0FDjSzirpCZYSwNi4GqWNCTkEMpTJYSQ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764625094; c=relaxed/simple;
	bh=e1V01lKz5AU9gCi6d5SJsdrP6BcX4ltNaDCw2bIE/00=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tBa8TMkWh1WYppxe38SgzlhxPQ+/GA/LTXaepk52bGoRAm2Mk+peO8dt5tK1KA2Ms1Eq6PO7OpKASdHpJxbSmn70pSuhDJJDVIGqWOrXE/3CVUAY80D5d37NObcz3q13Fgs4OH1Po6fXvQqYRt3xcmeLvy/4uaYvSMqxw0+CIt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6XrzaOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA28C116C6;
	Mon,  1 Dec 2025 21:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764625094;
	bh=e1V01lKz5AU9gCi6d5SJsdrP6BcX4ltNaDCw2bIE/00=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V6XrzaOrIPktJYW1rEn9r/avEy6se9NUQHyYLL/4eS24naGOi1xDhBDQHXqC3NfE0
	 cz+67xCbzlfQpb2r5yzlm0iNTIvTTvwncfViYbEzsLS/A61wBe/iueQy8o9tJwnmlz
	 KxlmL0nozpLRqFe7EaWpfFgY1AcjlBm8CVqNAXv5h24t+bSPwpzGEgnRr+QW3FK9TD
	 JKU2uoQ4OEXmgkOxRcLcHyv9RNqzl68R6JTxUbAjxLpNGHGTsjWLxE+s0g6bHLutja
	 c94brx1deiSJ6meDtZE3Z0fAeIGkU9w+XhPBj09Wnm3I8eRGNzr9SzQ7Lp9p3N030Q
	 y/5QpbYb2Dj9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B581D381196A;
	Mon,  1 Dec 2025 21:35:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-11-11
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176462491427.2545331.7721394115979070560.git-patchwork-notify@kernel.org>
Date: Mon, 01 Dec 2025 21:35:14 +0000
References: <20251111141357.1983153-1-luiz.dentz@gmail.com>
In-Reply-To: <20251111141357.1983153-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Nov 2025 09:13:57 -0500 you wrote:
> The following changes since commit 96a9178a29a6b84bb632ebeb4e84cf61191c73d5:
> 
>   net: phy: micrel: lan8814 fix reset of the QSGMII interface (2025-11-07 19:00:38 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-11-11
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-11-11
    https://git.kernel.org/bluetooth/bluetooth-next/c/27bcc05b8869

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



