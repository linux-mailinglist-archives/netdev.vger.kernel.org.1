Return-Path: <netdev+bounces-229379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3C6BDB594
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 23:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0F634EBBD5
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 21:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3652F5327;
	Tue, 14 Oct 2025 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITc1ZMID"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C631F03C5;
	Tue, 14 Oct 2025 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760475623; cv=none; b=o3eKkKBKsF/C6TUYrMYLa8PHZ2a1NtzLZ//raxMWuYDZvmTkAF8IzYvou/J8AFU5imvT6SDQBpqZ1oAPMW/6JaS+48fmDsZrCo/IVL/+dmogBy+hyxWwtZimUTAoEFfvWACLn8l6z8twGjgmPazFksaqq7Vs66vBKoov8D4GnFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760475623; c=relaxed/simple;
	bh=LJfH2b1oAzBe6ROcyf6DI1EgazSfvh6S52X7jHMiAP4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lftCpOs0xi6Wm5T04mKmrwvCh2AKO5AHi8Zq16zEaoJlaf959l9sKwa7WCmyupKbO0IzYZkHKEHAijMFDzOpABkd2drT0U+ui5DYKTg237eL1V7KOEPC8EVuEowly4OrpvD4EySReYHGEleZBzQVdIuDeJH6Xzb1o6HQA6UuHs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITc1ZMID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1F3C4CEE7;
	Tue, 14 Oct 2025 21:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760475621;
	bh=LJfH2b1oAzBe6ROcyf6DI1EgazSfvh6S52X7jHMiAP4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ITc1ZMIDy8AKBRYsoow2aTVwflsvRWGwk71N5D1kxni9ttAFaBq2xY78d9OK4u/rH
	 Q1QiJnGwzesHgQJUjSDJG3G7uqmjTy3TWR5gTC0QQp4DjXEoezu7EFAoZq9jvz5xmY
	 kALKbHWg8XMHb6mkAkYxsvuHQCLOoO2js+5RfWwRCL50dNF5B4ziGIoWjf2Is8e8yJ
	 YwlUVNdjSv1LsRFb9tOHI1LurWnjyn6UggIr7kPhxmFT/qmkCxKKBoGLd5iGVPklrc
	 v6h3Yja3KfvQwV+LO9jTq/HH58Rj0Cj2SEsnZ5yXKeREmxiOhVEPZussiIywtxR2HO
	 cBaQonIdQBXnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE6C8380AAF2;
	Tue, 14 Oct 2025 21:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: add myself as maintainer for b53
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176047560651.96118.16712658555383570328.git-patchwork-notify@kernel.org>
Date: Tue, 14 Oct 2025 21:00:06 +0000
References: <20251013180347.133246-1-jonas.gorski@gmail.com>
In-Reply-To: <20251013180347.133246-1-jonas.gorski@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: florian.fainelli@broadcom.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Oct 2025 20:03:47 +0200 you wrote:
> I wrote the original OpenWrt driver that Florian used as the base for
> the dsa driver, I might as well take responsibility for it.
> 
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: add myself as maintainer for b53
    https://git.kernel.org/netdev/net/c/df5a1f4aeb6f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



