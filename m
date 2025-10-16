Return-Path: <netdev+bounces-229831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1573BE1203
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 02:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A14CD4E7CED
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 00:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6634B18A6C4;
	Thu, 16 Oct 2025 00:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhHV2ymW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FB115B54A
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 00:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760575222; cv=none; b=E6dX7dds7EDX68XXycvT4aD8DsT/LZR7XbNkKXr/VpydtsTrpek5BCEc4hfe/r1MkwhvpBaoEb3raI1QvP0tP/xn6sBDvXzThjOG6wJcSKjTBeax5i/ASfnAxKof+PyQx2s38oXh45vyoq9l+woWLR9uXBsaL8N3AZc1YT9uc40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760575222; c=relaxed/simple;
	bh=zijU/6iwRksQd1z5qAVmU5GlEs+lPJKIFaDhcF4c5LU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tLFaIIfmm4XXog5vw8rwlAGeCxruJHBD2mjzAjpF1KNun6+ttXEwPkgVr/npHlZ0UkZaHc+6sJbge25viFQjyeo3xUlxHe6zSVnaKtNmE0zkreEAjkePmjIHZTaWiF0/STSRVmt9ro3En0HctrQPoueON1yDkx7hf3WreGjKrN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhHV2ymW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC709C4CEF8;
	Thu, 16 Oct 2025 00:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760575221;
	bh=zijU/6iwRksQd1z5qAVmU5GlEs+lPJKIFaDhcF4c5LU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZhHV2ymW45XKLZwdDVpJtT2N5zssmRP6/CagyP694dIa1t+ZdjKYVdPx2UavNJQzH
	 NtbqcdSY9mtMB2IofavNKkmXGaPU2c7K6+8mpLpzXkfrL0zuHu11BrBNwXdSTMMGUm
	 txKCNSp7dr2WAfd6JZyo0gzESWcNGKLjyETe05kwYPbvxTdg1rEdzYrnfRdyDHhSMd
	 cSuaelN7Xwcw+jcsikQTg4pRDaRrRTG50ZhOp5P5lMwbGGMxNDlQZ9PMTSdufkIhgk
	 i6rHHzjfnnfqA7I64qtRetCqvsWav9RE/6Rkbe7AVy3jUW3Wvc87g4aWjHVZrvlGit
	 BT9QnCy8f38Ow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F4B380DBE9;
	Thu, 16 Oct 2025 00:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: remove obsolete
 WARN_ON(refcount_read(&sk->sk_refcnt)
 == 1)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176057520625.1111692.18071564994043587746.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 00:40:06 +0000
References: <20251014140605.2982703-1-edumazet@google.com>
In-Reply-To: <20251014140605.2982703-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, luoxuanqiang@kylinos.cn,
 kuniyu@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Oct 2025 14:06:05 +0000 you wrote:
> sk->sk_refcnt has been converted to refcount_t in 2017.
> 
> __sock_put(sk) being refcount_dec(&sk->sk_refcnt), it will complain
> loudly if the current refcnt is 1 (or less) in a non racy way.
> 
> We can remove four WARN_ON() in favor of the generic refcount_dec()
> check.
> 
> [...]

Here is the summary with links:
  - [net-next] net: remove obsolete WARN_ON(refcount_read(&sk->sk_refcnt) == 1)
    https://git.kernel.org/netdev/net-next/c/e5b670e5439b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



