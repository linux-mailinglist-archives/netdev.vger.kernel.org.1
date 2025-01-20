Return-Path: <netdev+bounces-159715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17858A16999
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 10:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96442162F69
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 09:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8967D1B043A;
	Mon, 20 Jan 2025 09:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFZ/cftG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6598D18FDA9
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 09:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737365406; cv=none; b=J287Pca5t69bhuCuxKdXYciE4LCwstZab8YhKMHBjUwmJbotn0tYuf/8eNnu46a4jwUv1KgfRBzzVZWx7/vJROlKuruY0ZmbeuiGA5F+ixR61JLdPSI3sYz54dTDJIPKn/fLbOyAn20zjnAk1Bnw2cj4CUnUtzmWQ+Ruo33qw/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737365406; c=relaxed/simple;
	bh=1A1AYoBSCfbJkGld+MgLZKSMhSf4nv3K2N5dXRjQx7o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TFrXVo8XnXBMxR/U3ojm+tYIH8N+WVMp3piVcW+3wZG3Bdbq5AHcS1RanzR/Adofxqq5FqQfI21cSSnAd1W8gsXlmyUxCb6xYbxBsbc+632iJVdX9Y0dB28BgO7bzmMjExY+taQKX7DamfNFbt2Prp98KIu8MQ2nSRWjNHmlqqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFZ/cftG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4ECEC4CEDD;
	Mon, 20 Jan 2025 09:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737365405;
	bh=1A1AYoBSCfbJkGld+MgLZKSMhSf4nv3K2N5dXRjQx7o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WFZ/cftG0RfBFdGCohcQ6Hp0w4D5iX1fJ1T5KKQHFNM+NNoRWTfDEPv+tisa9YZPm
	 4FMs4POfcJt3UIxAjrogKmUQlTckY9uAZ+2JkB4Vfs8TKoz4DTIe1D/E7z9ROpq8eg
	 HsW2zBgWzRM+zF4cJYrdBnnk4JsKU+KEh5ifGTDnR7RL2MVo2JVGhVM4oD2usorfee
	 Z7xfj12DGM/NKMgBwCls/2Kg9CRKFDmLuMhmwxdUj/yKyZG8IUcTzIpJREJzUR3zZ8
	 DpAZyyku9Tcf6+99eJ2IUlY3Q0SsD59faM2zhUD6GL2Skvjkoh0R7+ontOqvmICfOT
	 X/7fvR/Mi9eNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB33D380AA62;
	Mon, 20 Jan 2025 09:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] net: sched: refine software bypass handling in
 tc_run
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173736542978.3461630.14025965431425974608.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jan 2025 09:30:29 +0000
References: <76c421c64c640f5a5868c439d6be3c6d1548789e.1736951274.git.lucien.xin@gmail.com>
In-Reply-To: <76c421c64c640f5a5868c439d6be3c6d1548789e.1736951274.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, marcelo.leitner@gmail.com,
 ast@fiberby.net, shuali@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 15 Jan 2025 09:27:54 -0500 you wrote:
> This patch addresses issues with filter counting in block (tcf_block),
> particularly for software bypass scenarios, by introducing a more
> accurate mechanism using useswcnt.
> 
> Previously, filtercnt and skipswcnt were introduced by:
> 
>   Commit 2081fd3445fe ("net: sched: cls_api: add filter counter") and
>   Commit f631ef39d819 ("net: sched: cls_api: add skip_sw counter")
> 
> [...]

Here is the summary with links:
  - [v3,net-next] net: sched: refine software bypass handling in tc_run
    https://git.kernel.org/netdev/net-next/c/a12c76a03386

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



