Return-Path: <netdev+bounces-224941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EB3B8BAF2
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 02:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724553B5FE3
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 00:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D83B15539A;
	Sat, 20 Sep 2025 00:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtR3Vq61"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29765140E5F
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 00:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758327622; cv=none; b=kK+4cTg4zv1iKz5h9CCIdx8G27Xqcd39NGuFxEi3TPW73+T0t1j6XJVZKey9kAKToGuemeBQ+C2PJZiACuvcY5ahPI57vyhIVa6wDwZKb/ecJTMGYRr6pfvkJ4nD8VGc07Uq74OK41fQbPp61S7OcTzK2tkXI9E/5hPuEMI8YcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758327622; c=relaxed/simple;
	bh=NSG9yu8qlAMFI8LJWLPCptIsn2GrXlE8mzCZZOdbDzQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DBRrbLHaeHgjYReXZm76eob8r2fXUpm2UNF5lAFw9cgLAhUi+uxmn81wjTKgm6dUoy+p53vIcdXRrPOXTze6bZbuPkesB3TJ28gucrZi2gIHjJCE73YL2gO+jB0OhsdwG/JSdPtGHEFgZuoUbWR0CTHcKvQpdCauO/yU6Ma8Nnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtR3Vq61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5970C4CEF0;
	Sat, 20 Sep 2025 00:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758327621;
	bh=NSG9yu8qlAMFI8LJWLPCptIsn2GrXlE8mzCZZOdbDzQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UtR3Vq61H+YWFVPZSXt+psxgZKqjvecYFijwjhxlf62UU7jV7/elJuJ7Dtyvl4CBM
	 Fmwd9WUPOK5SWR4+WVzbZPkw7HttKwqDB4SyJsJCF/PKjCLSHQSH/nuJ03jz6frZkG
	 2aEJ70yMktKhC/yHiWk23krhhOmJDTTa8X9vVTUD/ZGK/GQBcdXHA4H1X0H/tXfjEP
	 sr9dDPjAXcmkdAm8re9dl7KcfI2WJCpEmxrEo4PpI1LuXT0EsSWvjsPTR/aNEdWiME
	 1FQqXLKO1oLAM/1Zpf+32ORiFNa0GzYXMaq26xhG7HFzYLURGMdhVe3yEPYBXoHUEF
	 OD1CIlOqQEbYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CB939D0C20;
	Sat, 20 Sep 2025 00:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] address miscellaneous issues with
 psp_sk_get_assoc_rcu()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175832762074.3747217.34211334385616229.git-patchwork-notify@kernel.org>
Date: Sat, 20 Sep 2025 00:20:20 +0000
References: <20250918155205.2197603-1-daniel.zahka@gmail.com>
In-Reply-To: <20250918155205.2197603-1-daniel.zahka@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Sep 2025 08:52:01 -0700 you wrote:
> There were a few minor issues with psp_sk_get_assoc_rcu() identified
> by Eric in his review of the initial psp series. This series addresses
> them.
> 
> Daniel Zahka (3):
>   psp: make struct sock argument const in psp_sk_get_assoc_rcu()
>   psp: fix preemptive inet_twsk() cast in psp_sk_get_assoc_rcu()
>   psp: don't use flags for checking sk_state
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] psp: make struct sock argument const in psp_sk_get_assoc_rcu()
    https://git.kernel.org/netdev/net-next/c/f8d2f8205be8
  - [net-next,2/3] psp: fix preemptive inet_twsk() cast in psp_sk_get_assoc_rcu()
    https://git.kernel.org/netdev/net-next/c/803cdb6ddca3
  - [net-next,3/3] psp: don't use flags for checking sk_state
    https://git.kernel.org/netdev/net-next/c/28bb24dadd0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



