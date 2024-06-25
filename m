Return-Path: <netdev+bounces-106700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBC79174FE
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 01:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F40282900
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 23:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0129A135A7F;
	Tue, 25 Jun 2024 23:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLNoK+1f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E43184109
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719359429; cv=none; b=LD20wx+HdsLMOv/tHz6H7DGJFZZ4mObgA/9UXxW7NyJ6FKHHxgky0GN2Zoh2lYRzriZsecvOyAu+xyc6dzQXI8joTtzsJrsuf/NGiE22tlO171aUgkd1NSnE5B2+AtPL02Wcnka838mzInzAowfQYWoLARnNkWqR6IBXtZZAcro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719359429; c=relaxed/simple;
	bh=2j+yTsHOn9Kz5L2FLqKrad2zOWjIDeT9pA30Sfm0B+w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g54zIM1CdQdbeQvcbvV4i9ZJeX8c3zt9AQCm4KUTeckafuTvZzllI9W24K8MI0LRp9Nmv+SrOta5IapVS+EA4lml2GAB78cJSKuLTc71/JC9booB9pia0Glz/ebETk7f5tuMYgpLkPDWBca1nWK3l1RuOBUEOl2vG3BsnWyq2CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLNoK+1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44F82C32789;
	Tue, 25 Jun 2024 23:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719359429;
	bh=2j+yTsHOn9Kz5L2FLqKrad2zOWjIDeT9pA30Sfm0B+w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OLNoK+1fCTI5yCx73mLGCCrKwrJQPuRBn/GWRxBO7T0XJPga4EmCdeRy280tN1G2c
	 +6l8A9S4+P67YA4kJ+5vpxAhBRNAFSCtCt0rmrynlK1DommyrKpI5I7Hz2OVSep02y
	 TX1Qj6wfS+ORWRhxXuKe4IGhWZ8v6dqk94oCxc8UwaXELy6Oar/sKvuSgD4eR+ycnL
	 g3HbTyjYyHgjznZH68NKBTHPxQVfAxe2T3VEwrRzzYxagpO4zGnpQfBMsMfW8qTS4c
	 fF1MdiDoNt9l1Xbx6nE5h6heGc75bqy+pznX9RswuS8kCrvT9FIhH4dfoIdIzHxOYw
	 0lAKeAPvNjS6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A83BDE8DF2;
	Tue, 25 Jun 2024 23:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] ionic: use dev_consume_skb_any outside of napi
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171935942916.31030.1301680640703090877.git-patchwork-notify@kernel.org>
Date: Tue, 25 Jun 2024 23:50:29 +0000
References: <20240624175015.4520-1-shannon.nelson@amd.com>
In-Reply-To: <20240624175015.4520-1-shannon.nelson@amd.com>
To: Nelson@codeaurora.org, Shannon <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, brett.creeley@amd.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Jun 2024 10:50:15 -0700 you wrote:
> If we're not in a NAPI softirq context, we need to be careful
> about how we call napi_consume_skb(), specifically we need to
> call it with budget==0 to signal to it that we're not in a
> safe context.
> 
> This was found while running some configuration stress testing
> of traffic and a change queue config loop running, and this
> curious note popped out:
> 
> [...]

Here is the summary with links:
  - [v3,net] ionic: use dev_consume_skb_any outside of napi
    https://git.kernel.org/netdev/net/c/84b767f9e34f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



