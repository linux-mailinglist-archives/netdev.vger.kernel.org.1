Return-Path: <netdev+bounces-214809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 665FCB2B595
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 02:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880071B2692A
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 00:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAB61CDFD5;
	Tue, 19 Aug 2025 00:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJ11UAqk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38171AF0B6;
	Tue, 19 Aug 2025 00:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755564609; cv=none; b=J/EKiPjjBFcgMgdtb+7VZuluFqWQ6c6pffdB4XksF98cOCM/7n4XgCAun5F8pMjGBz85w+O/9RYa5yW0jZTBd0m/yq00teYfzq+KYieMOr6UDMpvKZxSFraimYpRd1YllBwwsjV/DVteigco8oEB546IVQP8BXuX8tgcu7pLvaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755564609; c=relaxed/simple;
	bh=UA9sSoPrJYKulw6y+ZVGBCPijt7UdH+EO3q2M49KNws=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PPTjWI4JxBebACP3lq4IiEJ2AtFbm0HQ2TcbVPgBLzKzqhozaMbRaY1Cmyel81Vof9cXhy5zdkL4DhFwocuIRIdIq+zVKnvARKDPKrctzC4e+RonU9Mh8bAK+EyWVvX9ed6rsZgnxwn2l9tG3SVft45iA6DvczUoTnOIaGjm8IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJ11UAqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FA0C4CEEB;
	Tue, 19 Aug 2025 00:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755564609;
	bh=UA9sSoPrJYKulw6y+ZVGBCPijt7UdH+EO3q2M49KNws=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dJ11UAqkWbhCAZRiY6YgVFdIoR3kcvVB9q1hgjy0zLdLukecfOrpwbhKYLTknP0E6
	 vzeKe6BKG102tBpaJvx01G1kGZnE/zSt0QCwbccDnQJBZTEewxQ8IlqOwCilyBfuWa
	 fYkc2hpALU5xYCmyvphsAmZli/vVo2H7ZaiDzgvwwFYCaS4xmBCNLlYhoyNfItoN0n
	 D8rGySTe2UFAyNnYyvI8orYd4KrzyH8w4g/w9EOdc61FLUnbN5T+y6L5r6acD493LT
	 fBVtUPsG7l9zV/A8rTjH87yw5nFFUSbIvZWlESLfUI+LEuNYFygVkM0h4pVC0bbn+U
	 JpCmsohHYZL/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D31383BF4E;
	Tue, 19 Aug 2025 00:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] docs: netdev: refine the clean-up patch examples
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175556461899.2964462.4786637899718513652.git-patchwork-notify@kernel.org>
Date: Tue, 19 Aug 2025 00:50:18 +0000
References: <20250815165242.124240-1-kuba@kernel.org>
In-Reply-To: <20250815165242.124240-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 Aug 2025 09:52:42 -0700 you wrote:
> We discourage sending trivial patches to clean up checkpatch warnings.
> There are other tools which lead to patches of similarly low value
> like some coccicheck warnings. The warnings are useful for new code
> but fixing them in the existing code base is a waste of review time.
> 
> Broaden the example given in the doc a little bit.
> 
> [...]

Here is the summary with links:
  - [net-next] docs: netdev: refine the clean-up patch examples
    https://git.kernel.org/netdev/net-next/c/ab4ee77ed9bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



