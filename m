Return-Path: <netdev+bounces-221918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8658B525B0
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44381C27D2E
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569DE156661;
	Thu, 11 Sep 2025 01:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwXNKMFS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D92346BF;
	Thu, 11 Sep 2025 01:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757553613; cv=none; b=TR17OvvjrqXtkm18W5BEC7DI3eZYeg/tHV30hLmH5AWNsYYtFjQ7th5d4+uBZRO1pdUs2tfJtPuFMOA7K38zU1kfADhR/zD0feu6IDP+P4vd7ZNsXI4QrbTkWJZzEMwgcpOB/NYjVN3UtBdfAp+bo/ukM541+BKsA1yHfYgI9rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757553613; c=relaxed/simple;
	bh=JrsAE3DudXpygIBh+cQxJTpyw6cSMLRJAioIz1JeHQc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bDAu4uSBYq03r2y48VoUL8NijfsqGbA/JRc07vicHgYhoywl8Jbj1aHb1wnc/A2A7q1lUSwaiXVeNWNr5G75hqZm8seXsPI5H7lfET2g6gR9nrlO9TbGNh7t8ldAxZSudm2FnDmukRgZFnxag2OFb2XSWFmokOhw/Bs0fOJycEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwXNKMFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9D7C4CEEB;
	Thu, 11 Sep 2025 01:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757553612;
	bh=JrsAE3DudXpygIBh+cQxJTpyw6cSMLRJAioIz1JeHQc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jwXNKMFSd+Z+48vmfPOHspdim+MokURq4pIkiDVsU6gg/7eGdKMJQA5o8vFCoO/A7
	 VvnFcQhBawSk0/MBXrI+Fgb70Pomccs+Jc/M07vOF5nN4rLd8bgPKDeLT7Z0UBRlKp
	 Doc4INHpRjbKLnSntuT5hWugvD7fJ1NL49FJ+Sxg+BlAjnQnVFdJTLQq5BpqX0SZTf
	 +x6N0BqxP43CVwi2fjYD2TKqZ17tGBAROErHEj2NIslyls04lsNcTh9kWXndouj7Or
	 b4EGy39tuIRPzWbm4V0VSQU9e7ozEaldfsOj7KxsHqpwJKrF4YHq9jjwYr/x6+9HPk
	 tUqXoaz3KDsMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE00A383BF69;
	Thu, 11 Sep 2025 01:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] tools: ynl: fix errors reported by Ruff
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175755361550.1619866.7130732289820892310.git-patchwork-notify@kernel.org>
Date: Thu, 11 Sep 2025 01:20:15 +0000
References: <20250909-net-next-ynl-ruff-v1-0-238c2bccdd99@kernel.org>
In-Reply-To: <20250909-net-next-ynl-ruff-v1-0-238c2bccdd99@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 09 Sep 2025 23:07:46 +0200 you wrote:
> When looking at the YNL code to add a new feature, my text editor
> automatically executed 'ruff check', and found out at least one
> interesting error: one variable was used while not being defined.
> 
> I then decided to fix this error, and all the other ones reported by
> Ruff. After this series, 'ruff check' reports no more errors with
> version 0.12.12.
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] tools: ynl: fix undefined variable name
    https://git.kernel.org/netdev/net-next/c/7a3aaaa9fce7
  - [net-next,2/8] tools: ynl: avoid bare except
    https://git.kernel.org/netdev/net-next/c/287bc89bb41f
  - [net-next,3/8] tools: ynl: remove assigned but never used variable
    https://git.kernel.org/netdev/net-next/c/02962ddb3936
  - [net-next,4/8] tools: ynl: remove f-string without any placeholders
    https://git.kernel.org/netdev/net-next/c/d8e0e25406a1
  - [net-next,5/8] tools: ynl: remove unused imports
    https://git.kernel.org/netdev/net-next/c/389712b0da1f
  - [net-next,6/8] tools: ynl: remove unnecessary semicolons
    https://git.kernel.org/netdev/net-next/c/616129d6b421
  - [net-next,7/8] tools: ynl: use 'cond is None'
    https://git.kernel.org/netdev/net-next/c/10d32b0ddcc1
  - [net-next,8/8] tools: ynl: check for membership with 'not in'
    https://git.kernel.org/netdev/net-next/c/f6259ba70e7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



