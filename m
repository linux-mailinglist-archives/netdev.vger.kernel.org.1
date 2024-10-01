Return-Path: <netdev+bounces-130775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9798898B7C4
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 11:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10547281DC6
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 09:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E0319ABCB;
	Tue,  1 Oct 2024 09:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ho4HyHEk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A446F192D63
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773232; cv=none; b=J9kkMYQ7KuyXS09w7GI8WgQj6J+6SjnjtVmsY8T9LT7yyJydZ/lnIlBpE8ev3jUf9guKyOYGjknaJK4glusmQQY7zI02m7Re3y/eCMCNqqENzYDg5LTF90dl/Oj6JKlk1DNqKI8aXhydncUVXFLvue1cjczWLymojG+7ENEfiIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773232; c=relaxed/simple;
	bh=vgzygWcbPXcxgE5SVWg1VyZWTWQCVL+s9LrmAZvo5fc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qScG/NiE5UzhZ/Mfxix2xWxYwTuUnTOHpXZXAO0z35osRVH7d016k4spwTqUH0sW5RocZVjUkt8qt8Qz+gwy9rOnHzvHcuZi0oLZfL6GWmTUoyKFpnmw4XSRHAM5S6ESDdoY/fBrZ5cUinCPvLo7VN57YvFr/fqYWYXAGR6IgXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ho4HyHEk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A754C4CEC6;
	Tue,  1 Oct 2024 09:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727773230;
	bh=vgzygWcbPXcxgE5SVWg1VyZWTWQCVL+s9LrmAZvo5fc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ho4HyHEkmn7+URL1vk4QME5ygQ+AwrbkaU31u/Y1vjrHnoFsHYdPOJb7m0wtBXNkV
	 jL5qVW4BkV82RILH7dSDS8/ccgtxAH2DJAhmCoa3FKh8Frhpavd/ZQf8EnVQLML9g+
	 FO1mpUzgId7HDidu5NG+/Ut5sYQs/HNMUtEVIMqVgGp32JK96BMuw+JyG1fJKO7NB4
	 z93ZhaXgp3mrxj1A5zjBoWgl6Nw0RyTP7zNt+pjuAHzx8YD0aqX8RxEW0a6W4MKTDw
	 TgNVkLVabfa+OjIMVXVq3QpuBnpRcRL/J9zNtywK3dY5yZhOKMYR7OpOPJJ4B2kKOd
	 vFo49Hq8Kg9tw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CB9380DBF7;
	Tue,  1 Oct 2024 09:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net: Add netif_get_gro_max_size helper for GRO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172777323327.272646.15311876422169022209.git-patchwork-notify@kernel.org>
Date: Tue, 01 Oct 2024 09:00:33 +0000
References: <20240923212242.15669-1-daniel@iogearbox.net>
In-Reply-To: <20240923212242.15669-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 23 Sep 2024 23:22:41 +0200 you wrote:
> Add a small netif_get_gro_max_size() helper which returns the maximum IPv4
> or IPv6 GRO size of the netdevice.
> 
> We later add a netif_get_gso_max_size() equivalent as well for GSO, so that
> these helpers can be used consistently instead of open-coded checks.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: Add netif_get_gro_max_size helper for GRO
    https://git.kernel.org/netdev/net/c/e8d4d34df715
  - [net,2/2] net: Fix gso_features_check to check for both dev->gso_{ipv4_,}max_size
    https://git.kernel.org/netdev/net/c/e609c959a939

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



