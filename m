Return-Path: <netdev+bounces-159859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC66A1734A
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 20:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C507F1887169
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 19:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE401EE007;
	Mon, 20 Jan 2025 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="by2giJS6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AD51B6D15
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 19:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737402610; cv=none; b=ZMsDCMvw4he8EFFLvPq/1yaaTHdekn05AOy8zJsWXaTbBDo4QbX4NR5oQXGH0PA+pHHEIAebnvj/IE4mvuT9QQe4O5EVNTyQ2AbIiR1QJi0sWOKiDav9lkOnMT/u8IElkTvFdFo/9YzH1DW2AjZbb464gUISqD6ygV7U7KFTZbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737402610; c=relaxed/simple;
	bh=GE1vLGYtBlli9ihoiiS6p0aBkgkGAd9NoRZlfs8PlEo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Uh7CALq2lattO6c2aRLNHlWdUZJevtknI266uJyR1rEoqJ5YEFjHvZDjeU2qcfNJGpIJfGgjzeE+gvObleAftWj404LSJGztSAoCCazffeNAui8eboxJtaiDJKHEO3tl2Ggaslk57T7mwM992SZTWM2QrGZpb3NZfJMAwNgizlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=by2giJS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0636FC4CEDD;
	Mon, 20 Jan 2025 19:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737402609;
	bh=GE1vLGYtBlli9ihoiiS6p0aBkgkGAd9NoRZlfs8PlEo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=by2giJS6M5JRx5YzmT18750/hYy16OZeR5IF6O5AKbq3OVoX0hpt6faNQY8JYjVRJ
	 vNJ1qaBwZmV6nIhJqSbhjbDeDkqgNTiy3L9aiTs7AbgXflANAB7eulMthx4jbpDy0J
	 hD0MhMsao7A+B6sF5eCQ/Fk4pf5O3rROAtkppZGPco23sd0Fhn/EmHI/QZ7FKfEwqU
	 HIPQCEywnJEdz9C5rEj8PlAgC06mtgPsw0KenFVtWtA33CevPZYExxv5ZsBmkB+vvJ
	 BVwsdU/wqM+Zt9f0B9fWqakKCQO6I+8uupRSh1m3BRI8j3tqmP9Wptj+DBEXhsW7Rb
	 nkKofPK1V+/tw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EBA380AA62;
	Mon, 20 Jan 2025 19:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/9] af_unix: Set skb drop reason in every
 kfree_skb() path.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173740263273.3632610.3181574831893647079.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jan 2025 19:50:32 +0000
References: <20250116053441.5758-1-kuniyu@amazon.com>
In-Reply-To: <20250116053441.5758-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, donald.hunter@redhat.com,
 kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Jan 2025 14:34:33 +0900 you wrote:
> There is a potential user for skb drop reason for AF_UNIX.
> 
> This series replaces some kfree_skb() in connect() and
> sendmsg() paths and sets skb drop reason for the rest of
> kfree_skb() in AF_UNIX.
> 
> Link: https://lore.kernel.org/netdev/CAAf2ycmZHti95WaBR3s+L5Epm1q7sXmvZ-EqCK=-oZj=45tOwQ@mail.gmail.com/
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/9] net: dropreason: Gather SOCKET_ drop reasons.
    https://git.kernel.org/netdev/net-next/c/454d402481d4
  - [v3,net-next,2/9] af_unix: Set drop reason in unix_release_sock().
    https://git.kernel.org/netdev/net-next/c/c32f0bd7d483
  - [v3,net-next,3/9] af_unix: Set drop reason in unix_sock_destructor().
    https://git.kernel.org/netdev/net-next/c/4d0446b7a214
  - [v3,net-next,4/9] af_unix: Set drop reason in __unix_gc().
    https://git.kernel.org/netdev/net-next/c/c49a157c33c4
  - [v3,net-next,5/9] af_unix: Set drop reason in manage_oob().
    https://git.kernel.org/netdev/net-next/c/533643b091dd
  - [v3,net-next,6/9] af_unix: Set drop reason in unix_stream_read_skb().
    https://git.kernel.org/netdev/net-next/c/bace4b468049
  - [v3,net-next,7/9] af_unix: Set drop reason in unix_dgram_disconnected().
    https://git.kernel.org/netdev/net-next/c/b3e365bbf4f4
  - [v3,net-next,8/9] af_unix: Reuse out_pipe label in unix_stream_sendmsg().
    https://git.kernel.org/netdev/net-next/c/3b2d40dc13c2
  - [v3,net-next,9/9] af_unix: Use consume_skb() in connect() and sendmsg().
    https://git.kernel.org/netdev/net-next/c/085e6cba85ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



