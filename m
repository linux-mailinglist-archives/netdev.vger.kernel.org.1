Return-Path: <netdev+bounces-19471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CBF75ACDE
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 13:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 913DC281DE6
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 11:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FED917742;
	Thu, 20 Jul 2023 11:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3275417729
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 11:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C002CC433C9;
	Thu, 20 Jul 2023 11:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689852021;
	bh=JhATuRWld8m326cJcmmXb4ZQphF/aYh/S/jht5BqXV4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jujlkXLqkvSTcrvMuNFQcD5mZ61KkQZWerecUP/9GJxQLu4op8k658OsY20R6bXac
	 Pnscig1MFJ8vSGrmnk+AIbtbjGi1zbebK7oM/W7+JE14u5OJuKfs1wg94svQEvmKsz
	 PrsfaTM+Pro4ZmCjzKE7+vUCZ+Q2lBdPVn5+s2KCmOqBzW5biuG+ovGsRuVMl29MMJ
	 ylFsNu+ZVsrsZTrMqZYmL5fEEqzttF6AFuJxbP56hN0PUPKQN7yPYwI+h2gP84Frn8
	 cOCTo/zgzpTYgkAeQvt4IfkDsLlUnoczE7zgPSH+rNS9328+BclyosriWVhJaOuhNo
	 Do7uPJnXjTfMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A3AD7E21EF6;
	Thu, 20 Jul 2023 11:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: add TCP_OLD_SEQUENCE drop reason
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168985202166.22827.15771843060649946489.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jul 2023 11:20:21 +0000
References: <20230719064754.2794106-1-edumazet@google.com>
In-Reply-To: <20230719064754.2794106-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 19 Jul 2023 06:47:54 +0000 you wrote:
> tcp_sequence() uses two conditions to decide to drop a packet,
> and we currently report generic TCP_INVALID_SEQUENCE drop reason.
> 
> Duplicates are common, we need to distinguish them from
> the other case.
> 
> I chose to not reuse TCP_OLD_DATA, and instead added
> TCP_OLD_SEQUENCE drop reason.
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: add TCP_OLD_SEQUENCE drop reason
    https://git.kernel.org/netdev/net-next/c/b44693495af8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



