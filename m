Return-Path: <netdev+bounces-251115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A44D3ABA3
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59190300A3FA
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7860C37C107;
	Mon, 19 Jan 2026 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMmrHQY7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D6A37BE8A;
	Mon, 19 Jan 2026 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832523; cv=none; b=nf0tNftp27mq1ueH7TYhIVLoS6Q4tTwEqMjzmacZYi2VBXlvVKktZuqZOjLDDX92qJMhbZBwerB8xDTP+kophMXnjOi7jQCs+MBdWrGREcYlL/BSpjfDX42M6N27IfpFOtkGRHGDqFeLTi9RuXAToDUNhj1HP5Ktnto7ivCkGbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832523; c=relaxed/simple;
	bh=WBVpoKw8o9yBTcLvYiB2MF9kp550pzlScPkaZSf4FHo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h2oRM3pYm8cXxfXd2yCTTafJq9Y0c1ERubn3p/SN8Jg93+eZ//wq1VLTliUkVVaTUuMJ3cuoMmJdvmk8NUHRy0pEdTC8cHeZmUL4afl8iMFJEAAMnQxyFMjLYv+W57J4bMMdovNia/CMppwAI6mUhhoohY7WFEfO3UXTo468xW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMmrHQY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4928FC116C6;
	Mon, 19 Jan 2026 14:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768832520;
	bh=WBVpoKw8o9yBTcLvYiB2MF9kp550pzlScPkaZSf4FHo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LMmrHQY75YP81mnTbne6AYMWH2t5+SXGO+KcQdm33ygwcjN5TrprexEO0Nqant2mm
	 DacPvdxfx0G7NEpn+FxcKQ2Q3d2PTBcsRH8+HLG8StXnFzHqHGP/7jcaCGXJUkiIj6
	 jeUp1k3XyPBZ9IIU+i0ufTPAhIPAWUJhHszmIAZfsHkl5iTPVUmaN/OekbGd707DTh
	 ALvDrVbaHZpsvYNRcUE9wsqR2xdYPPqc2sfqa3CoYWNsf48fNZbD8dF0ugv5GiztOs
	 PoDcXpf88Teo5iQha79Vc+qksB91FocSmo2DrOGluVzjDby1WU6K2FbTOgk91q8itf
	 cpeWlzqUwiijg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BADA3A55FAF;
	Mon, 19 Jan 2026 14:18:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] docs: netdev: refine 15-patch limit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176883230977.1426077.11179349834998989169.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 14:18:29 +0000
References: <20260115-15-minutes-of-fame-v2-1-70cbf0883aff@kernel.org>
In-Reply-To: <20260115-15-minutes-of-fame-v2-1-70cbf0883aff@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, corbet@lwn.net, netdev@vger.kernel.org,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Jan 2026 13:54:00 +0000 you wrote:
> The 15 patch limit is intended by the maintainers to cover
> all outstanding patches on the mailing list on a per-tree basis.
> Not just those in a single patchset. Document this practice accordingly.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
> Changes in v2:
> - Clarify that the limit is per-tree. (Jakub)
> - Link to v1: https://lore.kernel.org/r/20260113-15-minutes-of-fame-v1-1-0806b418c6fd@kernel.org
> 
> [...]

Here is the summary with links:
  - [v2] docs: netdev: refine 15-patch limit
    https://git.kernel.org/netdev/net/c/ff7737946812

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



