Return-Path: <netdev+bounces-191720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B4FABCDC9
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 05:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 717461B64452
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 03:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E076258CD5;
	Tue, 20 May 2025 03:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQs3MICB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01845258CC9;
	Tue, 20 May 2025 03:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747711214; cv=none; b=t3KP/hUu83L+gWwgMUwNn80qOXI3ZQvI9nxeQqkAF+NojSVbFx5zZIgp3s3DAXH1Qd18OI/roRGcsLwdaVT+7V8YBnbn36j0i4hATi2cpYrqN2/GrvPM2ZrZgBQAFyo5ORUADNLtZXZHJLVHBLjvVayeuE9o5u6Bq0HOzpEPqV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747711214; c=relaxed/simple;
	bh=Dc4AFUtanuz400vhxPYk3mbW1obhtagdapOQGbYMT1w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AVUQISBJk+BOrnJFML9Tgqe7j7qWj6Tmfg3LnDpi+WE4D7YhgxQRQoSFOiQk1L1EcmISKzPotOaI7Yu6yfOh/Cv5mqiX8sf5HBSpoKq2T+dkxO6ekqeZYwLnRU71KAXSDDD7wWcJaJgkWMHWJYSJM+COcNYIv5HVKynVHcOKats=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQs3MICB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC00C4CEE4;
	Tue, 20 May 2025 03:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747711213;
	bh=Dc4AFUtanuz400vhxPYk3mbW1obhtagdapOQGbYMT1w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bQs3MICBsii5kz7CD5Vscd5l0Oag5UuSiCOnA9dYOHaXDEzIygYrWqoBUPj26MA0p
	 UO+f5Y6ZxaxJ+ccIxQjGoVAgzi91bprygw+YvDhD2L+P+9VLps25Uu/aZHM4d15h1e
	 Q6whY5f1SoOCzhkg7NOaNlmiBJKbhvd+Tbsze1f+sQWD89hG6rqdfgm5N8DNckaDpq
	 PQpWHEZyG0lvFYEWgE+gJwkr7AE+l2/2uUAbV5HUp2gGMDaGtwSNj4A835gZ3JS0iV
	 +2Sj3rYFRe65uwhGpxGNLtFaH4HKGO5BLZxL8vClloTTfbP9gQuHNKhsNE3e76QFYy
	 6nDF926MI8JXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC88380AA70;
	Tue, 20 May 2025 03:20:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 0/1] queue_api: reduce risk of name collision over
 txq
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174771124949.1146050.11012119455080440521.git-patchwork-notify@kernel.org>
Date: Tue, 20 May 2025 03:20:49 +0000
References: <cover.1747559621.git.gur.stavi@huawei.com>
In-Reply-To: <cover.1747559621.git.gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 18 May 2025 13:00:53 +0300 you wrote:
> Rename local variable in macros from txq to _txq.
> When macro parameter get_desc is expended it is likely to have a txq
> token that refers to a different txq variable at the caller's site.
> 
> Gur Stavi (1):
>   queue_api: reduce risk of name collision over txq
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/1] queue_api: reduce risk of name collision over txq
    https://git.kernel.org/netdev/net-next/c/84b21e61ebd6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



