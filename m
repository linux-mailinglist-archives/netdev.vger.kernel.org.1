Return-Path: <netdev+bounces-147693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 237069DB3C7
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 09:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC73216232E
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 08:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0361494B5;
	Thu, 28 Nov 2024 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYY93fa6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5B553E23;
	Thu, 28 Nov 2024 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732782623; cv=none; b=HzvzQp6TZ8E0Htro1XJ+1WGqTSkritA+ECSRXpxNvOlDVv8OvyLqf61qbn8IKkRyug8i7p/k8pYueW6xFVkItbwoEEgyRDybuE675G9gBs9iAtdCN9CAOl3Dlr7bW9RcDyJtB2PUnA+XtlazLbVdWSDulaOawtsQQJWuNDczSwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732782623; c=relaxed/simple;
	bh=+BeTZDPf/Q+lU/HFNfxc0ynbF0oEQatVZGw9k0Un3BQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W3JaoNPxMD89+ztK1t61A1F7EwA47EalIiTuIPRunxVYRhNX6qI3eMCGntvRbfvFuC11tGBxovx9STWq1AZNAKQPRQY1TE8z80ur2RuEj/K1mOCLzulOiXYtd6iBoZ5k7maGYEvo51bk/m4qDLKdqNQAidZn3UCCqSdXf3w+waU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYY93fa6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D6DC4CECE;
	Thu, 28 Nov 2024 08:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732782623;
	bh=+BeTZDPf/Q+lU/HFNfxc0ynbF0oEQatVZGw9k0Un3BQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GYY93fa6WBcInZoP61wT9Rt9uwMh1yGEv8ASashLgJ22M8E/5ENZ1RjLO956mdxbS
	 tR9pwx5kOCY6pjaJhmCw8mQsBlIkR0s0w1jq7RiS3pkRJ2xdUu5QHtDECBvzbeE0A+
	 5FqmaTjFl2UjyROUoJOQkfwhB3+cOg1Os8uu+g/SISdDhtad6ZJWyiQFKS8cBCzvxA
	 zjie6O3cLVv5lhDh/actobYEFOlD5kAyvTz4hyBqyG07lpZiL1WHwOqQLPdL5gLsPT
	 o6biPPuE69/aOwWG+/DwAJQoRkdsyNTGcBgnswSOO3RW8h8JeuXavGsfmQsGcosq7U
	 dJXXh3RE0NFhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DA6380A944;
	Thu, 28 Nov 2024 08:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-11-26
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173278263631.1659134.10005290182153801734.git-patchwork-notify@kernel.org>
Date: Thu, 28 Nov 2024 08:30:36 +0000
References: <20241126165149.899213-1-luiz.dentz@gmail.com>
In-Reply-To: <20241126165149.899213-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 26 Nov 2024 11:51:49 -0500 you wrote:
> The following changes since commit 5dfd7d940094e1a1ec974d90f6d28162d372b56b:
> 
>   Merge branch 'bnxt_en-bug-fixes' (2024-11-26 15:29:34 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-11-26
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-11-26
    https://git.kernel.org/netdev/net/c/8d5c1b8c3e71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



