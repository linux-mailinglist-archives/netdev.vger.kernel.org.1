Return-Path: <netdev+bounces-58741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92168817F26
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 02:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C12812855F3
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 01:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350467F8;
	Tue, 19 Dec 2023 01:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9/UUhSJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EDC137C;
	Tue, 19 Dec 2023 01:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D025C433C8;
	Tue, 19 Dec 2023 01:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702948257;
	bh=XSXcT+s+rHwW3ZIbEJcgFFnfbd+lqcGIP50ulWjsvl4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W9/UUhSJZk+wOgVxZ90xJBZoRZhDmqbTNxux/aBAq2TBp9gwRvj2zrOnqbVO3lxfz
	 /9qrvdiohmXDEZVlyI0og5A1oddNjslUzYwsH3qPKeFZxY4MA8SnQOwVFtcbNuqkwj
	 Br8+/auq9EyOGBSks5KHR2MSr2Dx3b+hq1UiX+F/hYJl8EOL0VF7MlSonPJBQdqBvg
	 3OjO0Aw9m9W9/vIXyDnq8lb5Gk+QXHxS6mtJLvbyB71eemCi3GMnpp9oXraR88xeCc
	 rXLIFS6ulfEZ3zX05GXCbU0V7ntfYENuZZkJwhJ3c07D9rYlKDf3UwyBUEMT3odoo1
	 QGh3ZXgbzrlpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F30AD8C98B;
	Tue, 19 Dec 2023 01:10:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2023-12-18
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170294825725.17422.14867129364522571389.git-patchwork-notify@kernel.org>
Date: Tue, 19 Dec 2023 01:10:57 +0000
References: <20231219000520.34178-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20231219000520.34178-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, daniel@iogearbox.net, andrii@kernel.org,
 torvalds@linuxfoundation.org, peterz@infradead.org, brauner@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 Dec 2023 16:05:20 -0800 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> This PR is larger than usual and contains changes in various parts of the kernel.
> 
> The main changes are:
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2023-12-18
    https://git.kernel.org/netdev/net-next/c/c49b292d031e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



