Return-Path: <netdev+bounces-140915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8100D9B896F
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 03:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378141F22D86
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5932E14A4E7;
	Fri,  1 Nov 2024 02:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGHt8EIP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3551014A4D4
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730428833; cv=none; b=W4Yrq8nUA5nyZtdu49sYcRqeWcUvCXqC5cvaFzHXgtrBc/9vkN37Pkny4EgWWxJdMVbWstp0N8g70VcYfgFitcYw/xCZDb3KPS4pqsM0ff4d/FE3effFmy2I6Dphx/mMfO+d7lGRNYFjd9Y3ODy1HsHVdLKbnLTQSQ3ntWuzmZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730428833; c=relaxed/simple;
	bh=K8Y3iXz9zvxdjQSWFEQUj5/V8DZartTAVWEpNhL3ErM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pA0/Mr24z5nInAHBmikvQqK8E7ANAJlXEsh038sU8a2q2Y7B4XSW9VV2KTWH6ZaS9w0wOQGjK9jHnJDNca4+UTDT3qh5uBu2Ffcuy0sywPD6QjA8M7lfS1BN8lJGsJeA/UVbQbzVZnoevqo+/ACL2pSBp5o1O8HChhUo29ZIEKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGHt8EIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06A8C4CEC3;
	Fri,  1 Nov 2024 02:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730428832;
	bh=K8Y3iXz9zvxdjQSWFEQUj5/V8DZartTAVWEpNhL3ErM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AGHt8EIPx7Y6iObjSNgSapIiBmqcuUKT4ZDVNJ2eoxZywPyiiT16l4wDvep4lSeTS
	 CtjHTD9KCucu3yXFi11MyNBQsxaVC31uK9uCIdpjeARb3w3k5KkhzMH8PFCyCZnDx1
	 RtG80BRpB5LZiEYAAFzQ86ky84EZ6ZBiiJN+MHJWEAlAqCm31VO8PXF6QQZn6/1w3f
	 5nOQLqhKWJEPffDRqJZbjSYm/Doxll3vR/nh/bEZaGSg/rc6WBPtZnBjj2v99cCR2z
	 RkaQfWg9pqWrH1msvcHVFZwhWiDE+4Lx1K+08dpjnynIAJcrX0Pc2o1jnIWk2s4XYK
	 BacNVKmTR9i6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC6F380AC02;
	Fri,  1 Nov 2024 02:40:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dql: annotate data-races around dql->last_obj_cnt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173042884056.2159382.16074592490472097369.git-patchwork-notify@kernel.org>
Date: Fri, 01 Nov 2024 02:40:40 +0000
References: <20241029191425.2519085-1-edumazet@google.com>
In-Reply-To: <20241029191425.2519085-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Oct 2024 19:14:25 +0000 you wrote:
> dql->last_obj_cnt is read/written from different contexts,
> without any lock synchronization.
> 
> Use READ_ONCE()/WRITE_ONCE() to avoid load/store tearing.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] dql: annotate data-races around dql->last_obj_cnt
    https://git.kernel.org/netdev/net-next/c/a911bad094b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



