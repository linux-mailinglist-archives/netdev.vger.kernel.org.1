Return-Path: <netdev+bounces-177551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2779EA7087C
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 18:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4DBE17675E
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AFE26463B;
	Tue, 25 Mar 2025 17:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoPEUwym"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C54C264637;
	Tue, 25 Mar 2025 17:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925002; cv=none; b=rkh0Z2XEHzu7+Gkeb0g4wqOwg3c99ruIsAPF8RrLj0K6fCtGtWK4o/Mq7OKc6jgigp2611oZFMKX4XdV+bGolvJchs0bKnyPqthAVJRgpRJb9lBuwZ4Z+dJFqa1echzZChAygWi6UEv3WStuAaCWa7Zc11cH3TC3LL0Mg4n6voc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925002; c=relaxed/simple;
	bh=/xbN3SNGco9nfK5R9dddb1UbuYDo9yRpHGHHAEqgBn0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K/1sJFojRjny3aBXwbs3DLC2CTo5NOMI0M22PaejdJySxNa/kKFlZdToqkIVlfxEiVTz/5MZVI/kEeFbmhz5m8mySxsQNsdkxwM97HtAOQamR3xBy6T345Ri20OAwKf2X7IKsnSVswSUd9F9VNL3AhZ8ReDxJWu6OLcnzM+IYUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoPEUwym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70770C4CEEA;
	Tue, 25 Mar 2025 17:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742925001;
	bh=/xbN3SNGco9nfK5R9dddb1UbuYDo9yRpHGHHAEqgBn0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IoPEUwymEujnt8i+mKcczKvDjfZawp9uTNJ9k9Kx+Qv+UpEWD9M1EYq43TUxSn00P
	 y/zz50dAGVM/Tt9zC7Wlzx28ATFVFvpy6fGg2b3tVORBCuoQR6IdKPZ/vTJeb8zvwH
	 4jYaHgtim4q9s9oPD5l7B03k9wyosvImI/dvryu9FY3QoXnnrPgtAmaHXosyVaibl6
	 PF3ba/klijgsvREj87Gcc2+JhZ6HAAE5qMkYcvRQohg3KDtkdpcvb5QN70hggnMt6W
	 kWGE/a7qdrU1cExJdQo7EuwDFmO1RTJhBnJMEyjIjDZR+Uge2VuNoyfv/upsRMXpkC
	 GUaIb6UglNPSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB614380CFE7;
	Tue, 25 Mar 2025 17:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/3] stmmac: Several PCI-related improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174292503778.665771.17608780007246481323.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 17:50:37 +0000
References: <20250324092928.9482-2-phasta@kernel.org>
In-Reply-To: <20250324092928.9482-2-phasta@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, chenhuacai@kernel.org, si.yanteng@linux.dev,
 fancer.lancer@gmail.com, guyinggang@loongson.cn, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Mar 2025 10:29:26 +0100 you wrote:
> Resend of v4, rebased onto net-next due to a merge conflict.
> 
> Changes in v4:
>   - Add missing full stop. (Yanteng)
>   - Move forgotten unused-variable-removes to the appropriate places.
>   - Add applicable RB / TB tags
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/3] stmmac: loongson: Remove surplus loop
    https://git.kernel.org/netdev/net-next/c/9db2426a324e
  - [net-next,v4,2/3] stmmac: Remove pcim_* functions for driver detach
    https://git.kernel.org/netdev/net-next/c/d327a12e636e
  - [net-next,v4,3/3] stmmac: Replace deprecated PCI functions
    https://git.kernel.org/netdev/net-next/c/45b761689a28

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



