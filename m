Return-Path: <netdev+bounces-132997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6655B99430F
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 10:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7981C23E58
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 08:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2316D1D1F7E;
	Tue,  8 Oct 2024 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsokQ1M5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA981D094B;
	Tue,  8 Oct 2024 08:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728377429; cv=none; b=K9oqR9EW4AVLqbPaj5RGprILWMfDsMyf3INmVoh030yDiJoBfuYA0rzdpdU2zGYsIBekOU53CFp+9kUmVGO/m9Zx0WcqWbhp5igqU9uneWRSfArxWmm2JlszdtejZ430p9cuMnfkKOJ62U0Mj6c+i2wmVUn0CpoTwkRTyYmLA+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728377429; c=relaxed/simple;
	bh=1wUAZhoZVygiFNyWjWPKnwduky1SuDymb4RxDcT3/UM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cjZEzSsOYmHnAnpli7y0yVQ4S+cOH5UcJLa43C40okeElXAT8vNnTTciOQpr2OPancGJX6fryNqUwz5tekS2HWGKGgx6CeAxq5/LwTzVkY6AHasfHmfRTbXUiaPO4IpFSw562Jv12eJJHy4y1ygU833RXQ4NwQQASPD2KecA6Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsokQ1M5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FA7C4CEC7;
	Tue,  8 Oct 2024 08:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728377427;
	bh=1wUAZhoZVygiFNyWjWPKnwduky1SuDymb4RxDcT3/UM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NsokQ1M5wnp6nzu8ElnIo/ajNtQcIXkJZlJXR5xFDBTye+mIhcxYUCn/EwEKkbSc+
	 lmjl+ZXPzqMWn2CuuyElClP+xx3ADABY7Z9teOWKBe+vnf3G4tJtW6+sNC5tfhHpRy
	 +vDgIN/73WcPR14mxrCxeuKL4/HwzSPekrWnHQYUMe06lApnr93ltvFZgqPMPLmyj6
	 HQC5GvdT727CKcQv+bSmyxs9YI9BwfwjzsYyK4iM/bkyPv62s7Xn0nPd+wfLf7ctcC
	 1nzXXve1j1tHaKU90HjIcd2qDbbOinD8AcrnvGSBlRVNEkASu1nqdvDsrWmSB8FNQZ
	 iFPKbzaDpxDFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD5E3810938;
	Tue,  8 Oct 2024 08:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] fix ti-am65-cpsw-nuss module removal
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172837743149.451237.11798001139573438705.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 08:50:31 +0000
References: <20241004041218.2809774-1-nico@fluxnic.net>
In-Reply-To: <20241004041218.2809774-1-nico@fluxnic.net>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, grygorii.strashko@ti.com, vigneshr@ti.com,
 rogerq@kernel.org, npitre@baylibre.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  4 Oct 2024 00:10:32 -0400 you wrote:
> Fix issues preventing rmmod of ti-am65-cpsw-nuss from working properly.
> 
> v3:
> 
>   - more patch submission minutiae
> 
> v2: https://lore.kernel.org/netdev/20241003172105.2712027-2-nico@fluxnic.net/T/
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: ethernet: ti: am65-cpsw: prevent WARN_ON upon module removal
    https://git.kernel.org/netdev/net/c/47f9605484a8
  - [net,v3,2/2] net: ethernet: ti: am65-cpsw: avoid devm_alloc_etherdev, fix module removal
    https://git.kernel.org/netdev/net/c/03c96bc9d3d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



