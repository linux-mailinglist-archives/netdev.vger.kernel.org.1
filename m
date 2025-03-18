Return-Path: <netdev+bounces-175714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FC0A67380
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 13:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 431253AD33B
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 12:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B9C20ADDC;
	Tue, 18 Mar 2025 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGRu1vVJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24EF290F
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299798; cv=none; b=Rn4Dv3W6Q0ZRITYSbXAT+7vEg+IsE3mrziHZOhg7Xl/lh8Cg9mwDlzyQxwC27Zugl3bRgpBRliRdY0BXlc8YHZYtRhUrr64sRz5DCEoJenk9s7hHiVMFbqkvkmR7zolsl9SD1R1gAExkpSvcasBbSgIJ+2G41vo1LUolog6WsPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299798; c=relaxed/simple;
	bh=RGpSRzPFu+S3yD/YdOllInWJlFNVRiLSKizHXl2xfkA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gex4ViU9ctxmllMdc2SBqrWDFkkf5iVweByPAHtXqJg/DtdFeoQxI0AD04ZZo1IKJS+pmN70CSMj/4SEHVVd+VazvmeGq281YhnwgfiW2JJiaD6VitN2lkwj0/gQ2VbHysfWb/vuCzoYCVDHm7nVLXpSJ+TwCaDiv7SG5PT/SrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGRu1vVJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AB5C4CEDD;
	Tue, 18 Mar 2025 12:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742299798;
	bh=RGpSRzPFu+S3yD/YdOllInWJlFNVRiLSKizHXl2xfkA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EGRu1vVJWaw1Rla7XAAFOo/7nUVoCDe1kyNgrlVUEppv0CJzMTHzrjA1f9lTgTl7M
	 11+fL/fojZ5jFrt8wcUrhaw5k/oaAdTQWQEn6j59NY39KN8yX46txknzysAensR8DT
	 M9hs5c9ZkeyN4j8qq0KHr4IgEKTFyN1SYQpKLnhaHmwDfOtW/D+RTgGRGfHiuQ9yvV
	 4/lxRw3uIEtnmw4njLuzsQy9A/+4J6VuK6J9riGDw6+in10WjVhO9VRMW+m2XPYQov
	 xNjY2/PEuSQOectn0oVdkM5BbLoeYNmOjVC1ocymWtE7VxhUeA1ZAWq4gnH2WOiAQJ
	 XViEh2fQhtEaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0CB380DBE8;
	Tue, 18 Mar 2025 12:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] ipv6: Set errno after ip_fib_metrics_init() in
 ip6_route_info_create().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174229983352.286709.12622598738555328723.git-patchwork-notify@kernel.org>
Date: Tue, 18 Mar 2025 12:10:33 +0000
References: <20250312013854.61125-1-kuniyu@amazon.com>
In-Reply-To: <20250312013854.61125-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 11 Mar 2025 18:38:48 -0700 you wrote:
> While creating a new IPv6, we could get a weird -ENOMEM when
> RTA_NH_ID is set and either of the conditions below is true:
> 
>   1) CONFIG_IPV6_SUBTREES is enabled and rtm_src_len is specified
>   2) nexthop_get() fails
> 
> e.g.)
> 
> [...]

Here is the summary with links:
  - [v1,net] ipv6: Set errno after ip_fib_metrics_init() in ip6_route_info_create().
    https://git.kernel.org/netdev/net/c/9a81fc3480bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



