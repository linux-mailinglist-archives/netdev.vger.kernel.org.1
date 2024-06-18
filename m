Return-Path: <netdev+bounces-104546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B6D90D2F4
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 15:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C895B29BAA
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6077113A3F6;
	Tue, 18 Jun 2024 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfbD3tnc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE5127446
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717430; cv=none; b=jhVYJooKAhRtLBW4r7T86FOQDmCvSzNgDA1Hir2yY0TsX3wKWLNNsiUKjfY1p9UId8Hm/rcuHbv41JBCt1FQULGCCJagsnGYmVHwRHevBlAIenFZxLDr91dy8h+betg4UJHWtRS83r6VSv3/BSVHCOrjC6WIfoG+zZfI3Qlnn38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717430; c=relaxed/simple;
	bh=3hnQgP1ZNX+4XQ9TWKBbVsrtcFlYdDGuaTYtV6PeBCY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j/z6AJ6zv7HLChS7L1tMEdjIMY7C7K/xniyve6c+9II1Tr1GA13bQw4Djf9frrfPVN3xXbjfIVnNGLI0UMMmt3E/NuwLDX093PV3ixUkHjz+jm0o4QpiYAcBnqSCt6TMuDoXd5M7+LjLwhJ8qk3So/IPV3J/YOFyfyQOjOqYoRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfbD3tnc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABF8FC4AF48;
	Tue, 18 Jun 2024 13:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718717429;
	bh=3hnQgP1ZNX+4XQ9TWKBbVsrtcFlYdDGuaTYtV6PeBCY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qfbD3tncLwt5UrUlCcdfjvapLTYEOmf3Qq0bXfhopoukUiwXBS9kFV310GoVnpf1U
	 V5Q5fRUEU6JVyJYbx9sh1cxpvJBprYV3eAhXXeIwUJxsSq6hGT7uWo/t9gUmEhuRVQ
	 xKmx3pW1OGVy2AsiHznPFjAAf1tohC69njftsWI0NE6JrYVGvMHQf6It25AUQbQZbP
	 qjwXC8Uxe6pkb+KXc1umtJ4FXDLJklCwNuwmk6tNLZ2n7mbTQ82GO32ijsafB/TeA2
	 yUdr2LjtRCdui+86o+XSelZfDLXMh+GqLIGdCQnmy8AWgwKJJaSuXKAbJW7X6FwLPP
	 peGtPPnWK4JNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 972DFC32768;
	Tue, 18 Jun 2024 13:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sched: act_ct: add netns into the key of
 tcf_ct_flow_table
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171871742961.9870.6907835901252320291.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jun 2024 13:30:29 +0000
References: <1db5b6cc6902c5fc6f8c6cbd85494a2008087be5.1718488050.git.lucien.xin@gmail.com>
In-Reply-To: <1db5b6cc6902c5fc6f8c6cbd85494a2008087be5.1718488050.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, paulb@mellanox.com,
 yossiku@mellanox.com, marcelo.leitner@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 15 Jun 2024 17:47:30 -0400 you wrote:
> zones_ht is a global hashtable for flow_table with zone as key. However,
> it does not consider netns when getting a flow_table from zones_ht in
> tcf_ct_init(), and it means an act_ct action in netns A may get a
> flow_table that belongs to netns B if it has the same zone value.
> 
> In Shuang's test with the TOPO:
> 
> [...]

Here is the summary with links:
  - [net] sched: act_ct: add netns into the key of tcf_ct_flow_table
    https://git.kernel.org/netdev/net/c/88c67aeb1407

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



