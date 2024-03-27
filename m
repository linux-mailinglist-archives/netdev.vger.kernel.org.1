Return-Path: <netdev+bounces-82680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9061588F1A3
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 23:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 924141C2B011
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 22:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29F4153813;
	Wed, 27 Mar 2024 22:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ba8aXH8U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989E1153511;
	Wed, 27 Mar 2024 22:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711577433; cv=none; b=kqV4ruboyW2wdK3TNl5Qmf5eDWd1rE+aaq5CKdoBMhHQMecQKLj3U96bVpandnO8M9hGK3F9bQezM8OvAfEqcZXjFvtjXHucQhjdGf7UrSZXDY3PegwKGRqWoQpoCtEXAEBjX5q8htL2MN5qDYpN25gaygj6FVNDLXV89VzY9C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711577433; c=relaxed/simple;
	bh=++k0Av1KN6XD6lDnmn+sB/vOhM/0gXGBQQjyUi7oo/E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Mo5w9aP1/LQK25UgrfL9v3X4wzUikYLL2YZRy70KnOW4cH0BuY1zrFdt1Dl1V/iub9H9zEpLYV6Gs5RRxEC8I6vpD1cwe5mhvxcADz5AcnKnZlbOsC6/5Da6jvzgv0+ov5J7CVzsrqQfzOetts+9SdggvHshfS1aIfBhcf0mwD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ba8aXH8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34264C433F1;
	Wed, 27 Mar 2024 22:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711577433;
	bh=++k0Av1KN6XD6lDnmn+sB/vOhM/0gXGBQQjyUi7oo/E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ba8aXH8Ut+LFva1gZgboycMtv8egaEOlXjkLLeKkBpQL9a4CsPU1zmlNIbrjzNPCG
	 j+6L03vnNxf2WT2ph+yXJPR+UgbybXXZCMiqNGlQOvGdS8eWhRIFgvJ3ihkfrcPkuh
	 4lkwCrUCGp5n/tFrflKUgEsbVPhVrjUHNetcaRFoGeICgJDt2msA6/iycVvzB20Yav
	 H6HLSQEtlqorO2zjJw+uZwhYyCNHh31eeMewU1jE96cxU6SwppJ1qhPc/4T+PTix13
	 yizJKaHs3hMEPEM2urEUgJHOk7w1V0/JNVMFhQ6wSJP+xHNAoE/r1Y68ytjd3/MBDP
	 QPheC0340Haog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21C26D9505F;
	Wed, 27 Mar 2024 22:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: Remove CONFIG_X86 and CONFIG_DYNAMIC_FTRACE
 guard from the tcp-cc kfuncs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171157743313.7147.9400834997000407590.git-patchwork-notify@kernel.org>
Date: Wed, 27 Mar 2024 22:10:33 +0000
References: <20240322191433.4133280-1-martin.lau@linux.dev>
In-Reply-To: <20240322191433.4133280-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, netdev@vger.kernel.org, kernel-team@meta.com,
 jolsa@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 22 Mar 2024 12:14:32 -0700 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> The commit 7aae231ac93b ("bpf: tcp: Limit calling some tcp cc functions to CONFIG_DYNAMIC_FTRACE")
> added CONFIG_DYNAMIC_FTRACE guard because pahole was only generating
> btf for ftrace-able functions. The ftrace filter had already been
> removed from pahole, so the CONFIG_DYNAMIC_FTRACE guard can be
> removed.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Remove CONFIG_X86 and CONFIG_DYNAMIC_FTRACE guard from the tcp-cc kfuncs
    https://git.kernel.org/bpf/bpf-next/c/88be2ea40f94
  - [bpf-next,2/2] selftests/bpf: Test loading bpf-tcp-cc prog calling the kernel tcp-cc kfuncs
    https://git.kernel.org/bpf/bpf-next/c/74c8edc68573

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



