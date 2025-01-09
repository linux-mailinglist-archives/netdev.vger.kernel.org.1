Return-Path: <netdev+bounces-156875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699C5A081DE
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 22:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 908843A72BF
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 21:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3B9202C31;
	Thu,  9 Jan 2025 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYHaqnKB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D91620103A;
	Thu,  9 Jan 2025 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736456418; cv=none; b=N53Lv+d3+JEYYuNBL7wAe12jQlK4UhwGv9bMhtmbuprUtAyBOCmG2jRQLbHUA7oMxQWEYeJRjWA/xMudKPWgeaaEu/FXyNvXf7A6VJM/vdABG5hiVnfd3igDfmJm1vhdPnTyXa/W/mWAMGm+nVMQ0ck2YKoqv73sOxvBAU7NvSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736456418; c=relaxed/simple;
	bh=Pj1y28/iN5gtQ8VIlKgJU1P1OZEuztWmerIVDNG0RLI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u6HgOqS8Jd8R+VFz1ZeMfEftQoAUCM/BYzsJHAQRWJzZs+gco5X1+L+Llzx8e2fwml8rBRwWkNAhZhon/vNioWo60Ozg0XmGHY3P5xtoSLMwsxdue2NOmchBXFNFgfqK+d9lyJy8LJxHmZa9kJDj1Gmm6uJWCfG7qKhxz4HmeAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYHaqnKB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D12C4CED2;
	Thu,  9 Jan 2025 21:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736456418;
	bh=Pj1y28/iN5gtQ8VIlKgJU1P1OZEuztWmerIVDNG0RLI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FYHaqnKBQMsDWO+DS2rm5NsQX+bLRr0/yoLn9NjGFvZir11jRYFHu6vWtrnmZSXFw
	 pW3Ipa2hf3qFQZw99b/HaCTmeBB8NMWZTm9EnJcijq2qaEr0+0NaOXG2NiZDtQWBNK
	 jTJRviaJoiV7HnkN9s8OQUkB9bjiGFvkzN8qxgHZVgh3j3AqYCdoMdHaYw/5witW5H
	 Ne2+K67/v2/oAhA9DT+9mvE6mmigxVuHh8kRrOz1RLEUfY68VS4i3QdFNh8KWlofim
	 +rkzY8r+htd/qDiEWSYQfosPE2CTCpF6vBsh6FBOON59fKga3vEo2Choj7NtS0Xqvt
	 UFq+clgVtLKEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBA1D380A97F;
	Thu,  9 Jan 2025 21:00:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/4] tools: ynl: add install target
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173645643977.1509145.2120615304366309873.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 21:00:39 +0000
References: <cover.1736343575.git.jstancek@redhat.com>
In-Reply-To: <cover.1736343575.git.jstancek@redhat.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: donald.hunter@gmail.com, stfomichev@gmail.com, kuba@kernel.org,
 jdamato@fastly.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 Jan 2025 14:56:13 +0100 you wrote:
> This series adds an install target for ynl. The python code
> is moved to a subdirectory, so it can be used as a package
> with flat layout, as well as directly from the tree.
> 
> To try the install as a non-root user you can run:
>   $ mkdir /tmp/myroot
>   $ make DESTDIR=/tmp/myroot install
> 
> [...]

Here is the summary with links:
  - [v4,1/4] tools: ynl: move python code to separate sub-directory
    https://git.kernel.org/netdev/net-next/c/ab88c2b3739a
  - [v4,2/4] tools: ynl: add initial pyproject.toml for packaging
    https://git.kernel.org/netdev/net-next/c/a12afefa2eab
  - [v4,3/4] tools: ynl: add install target for generated content
    https://git.kernel.org/netdev/net-next/c/1b038af9f752
  - [v4,4/4] tools: ynl: add main install target
    https://git.kernel.org/netdev/net-next/c/e5ad1d98234a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



