Return-Path: <netdev+bounces-79337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EF1878C83
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 02:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F06281C80
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 01:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1626B17FD;
	Tue, 12 Mar 2024 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STAs2s6g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07B7EC3;
	Tue, 12 Mar 2024 01:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710208240; cv=none; b=CePuQa/6kTeDd2LIRDwCGTNR0j4tLHR4fyoC35r2dCStjQVPin3o6baHsEtfmAxZn8VOg715n9QcFFhYQ9JAE9ZmTb8BbEZD3OehbZUXZIm70P6ocQzzf6MgmuMpajwOQ/Xly90Usr5zUIaRnl7t9NNjjYyhHEXU9/zzYD2MZnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710208240; c=relaxed/simple;
	bh=BFjGnwOGFHBQRHTA8b+awizpTb0bUcD/BMa4iLWLGZQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NF5Se/pRGvQry8eqJgnnBo9Lyj99YXtvMPsjxHW20uxiplt+ZPJcvlR72Ie3eusZ+xNQT8leC8WcJWiDQ1efUkCxli8w8RAMDmAaNECT7/0wBSQLpmik8A6bcHc6aQJhpt36cKJgdL4LHS0yQ9Qiql4Q9LkWQOMUw7218xZ4JsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STAs2s6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52BD0C43390;
	Tue, 12 Mar 2024 01:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710208239;
	bh=BFjGnwOGFHBQRHTA8b+awizpTb0bUcD/BMa4iLWLGZQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=STAs2s6gxBl3pjhuKnHA98XC7/Y+oflKHenEacjayiZoq9q7JCUHk+Cqco++yMW6G
	 igd/l/CgaPbBh1M23vFAwP0G7QtDCYTVEksEJA3XuAiocjlUBen2KTG3NW6yk21akz
	 WjSRzk6VAB5NIg6oRmXDV8gQhxnS3OG2Z02QaHRBkaJlGxwL/eaupd9+WfuJSN9L0S
	 KUdyWTj+Vz2GzW+rXldwIzEwxPeC2NzuhzyzJAVfddEWXPwKN596KI7P9FOVkfEhhv
	 +8BTvPwXQSWUL6NfwXql8HkCZchPsuHlWN5iaGEvKedlFIH/ks5Kxwp6KqYDoQXveT
	 Z1kHSG/SuaDBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36625C395F1;
	Tue, 12 Mar 2024 01:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2024-03-11
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171020823921.14498.2639220288507217275.git-patchwork-notify@kernel.org>
Date: Tue, 12 Mar 2024 01:50:39 +0000
References: <20240312003646.8692-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20240312003646.8692-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 kernel-team@fb.com

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 Mar 2024 17:36:46 -0700 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 59 non-merge commits during the last 9 day(s) which contain
> a total of 88 files changed, 4181 insertions(+), 590 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2024-03-11
    https://git.kernel.org/netdev/net-next/c/5f20e6ab1f65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



