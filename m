Return-Path: <netdev+bounces-170877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2781DA4A626
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 23:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0992A189C1A3
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 22:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB58B1CAA64;
	Fri, 28 Feb 2025 22:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzJxxe0I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C9923F372;
	Fri, 28 Feb 2025 22:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740782999; cv=none; b=Q3iHTfRqIkwWw79Q9AjlF/Q1OhGxrVUyuTJodPq6NIQvgH3GkwKc8LadgxjiX8cy5RCPkTAv2eXrKf+vCQVs7qBpgpVSTp3fFLhq5IKpPL5RaK8SEZKgQaIse4AIJ/Lbk47iAvCBVgd3JS5XjgE72Jjx3yEMkQj0Wph2jUtL6UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740782999; c=relaxed/simple;
	bh=s7Nf2adSH5BDcXCVGGZpAXZJJVoEW91G/qdka9/JpzE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C2QoyjQRhWLjfOcS2HzY1Ef3CwJ0Ad6zswSQOQ45I+Ah6B4d1MJiRcukb813pM48KrwaAuuxyouE672rlIMCfGp6F7aoOJm7BtEm6ayIuzbyL6zwfw9FlytdqzWIW7vNH5IX5LPYLBDyTg1NoDWUtNhKTjnc26XrBPrHG0BHrpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzJxxe0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A77CC4CED6;
	Fri, 28 Feb 2025 22:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740782999;
	bh=s7Nf2adSH5BDcXCVGGZpAXZJJVoEW91G/qdka9/JpzE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nzJxxe0IHdlsVg3uIXnrkV4+RM69AfgYxCyo49kRbSxFmZFRw3aqSojojrTMhewNx
	 yXyavHQTOV7/1uhdjcd0tct0fHqLFZ1nt1i3psWlFz76afVY36TmmMWRWhkMw5lGXE
	 vrEP/UzU0Fzp+xYpOuG3/TU7hXnjE/VEYqVxLtk/a5yVrTLvmF4QMqgOwUTu0vTl2C
	 LsK0hXPXFcEsSwazZSc0qipz1A1tgvpWRhxDQg7Ef87xly7a7dD8mHp0jUPaHCpqL5
	 OAdWnmNndp5/D0WoeVaABRxNiP014/NRt5/kx8TjlXsrmrJt6s0m3UgHC+JyT/bOwd
	 krxi3sf4EoyQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE10D380CFF1;
	Fri, 28 Feb 2025 22:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-02-27
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174078303151.2301678.10893967573522233933.git-patchwork-notify@kernel.org>
Date: Fri, 28 Feb 2025 22:50:31 +0000
References: <20250227223802.3299088-1-luiz.dentz@gmail.com>
In-Reply-To: <20250227223802.3299088-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Feb 2025 17:38:02 -0500 you wrote:
> The following changes since commit 1e15510b71c99c6e49134d756df91069f7d18141:
> 
>   Merge tag 'net-6.14-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-02-27 09:32:42 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-02-27
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-02-27
    https://git.kernel.org/netdev/net/c/0fd7b2a43260

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



