Return-Path: <netdev+bounces-57720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDFF813FAB
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4366B21BF8
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 02:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A3D804;
	Fri, 15 Dec 2023 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjlpmB7T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D337EC9
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 02:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA33DC433C9;
	Fri, 15 Dec 2023 02:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702606826;
	bh=Pkui+IcRmR9t+1GDCmHrytnvtj9xTYRt81SGhpMV5BI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WjlpmB7TJ0s9u74hwijO2v0oDk81eXcOJ255CQC/mhFiv7WP8THkUVlpeKIQ2O0eQ
	 A41QC60KDoNJ8HV19/wax+2f5e2pqKUOYX294621M7aS8LWjk6YWdmTHydI7PUPP8A
	 /VXTGizhRWlI7CGdUVvdd6T95wYP6VVJBdKBm1M08zkl4yHSSribeDr4pLknykSZ+l
	 1Q4So5Y9WN65J47zE9YzNHC1dDs6Hf/AqrzpDUkpRjcefvdiG+rlPioMZuhUFwY5cn
	 nmsT3JDZyhW0l5NSKp+IyT5JbgQAs3O7S2e7vGoO248W8SFcRkCcHNCDhoGXdqTdRn
	 b6Smwlh9ObECw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF2DDDD4EFC;
	Fri, 15 Dec 2023 02:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] page_pool: fix typos and punctuation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170260682584.8212.10268017784069557324.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 02:20:25 +0000
References: <20231213043650.12672-1-rdunlap@infradead.org>
In-Reply-To: <20231213043650.12672-1-rdunlap@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, hawk@kernel.org, ilias.apalodimas@linaro.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Dec 2023 20:36:50 -0800 you wrote:
> Correct spelling (s/and/any) and a run-on sentence.
> Spell out "multi".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> 
> [...]

Here is the summary with links:
  - page_pool: fix typos and punctuation
    https://git.kernel.org/netdev/net-next/c/fcb29877f7e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



