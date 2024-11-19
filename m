Return-Path: <netdev+bounces-146105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA47E9D1F11
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 05:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C571F220E9
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 04:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14C819067C;
	Tue, 19 Nov 2024 04:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8w/YX/x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDCE18A950
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 04:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731988836; cv=none; b=A1BIqQGHgAD5GCS0VKhW7fUZdRaz1tRp6P9Yu2MBQGAVpXkYcyksR6uHLtusSKJX9SmQJ1TidVsqVdHaT1bJtpYjsxoNX/6OmKILc4FwGfaARAYJfqPNxJuo9EBgst6n6/Coq61CX0ClkScG6XQVyna/EOenqmIIwTx9Ib4Ro7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731988836; c=relaxed/simple;
	bh=H/l5xrciMXlyQBTIz9b8sTFLZf2JhBIFJA68qPy9/mM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YfbbpAohjC+qoP6VaUs4EBemc9d7fJLlGrW6syHkq1q+7uope5Fl5IPj6Ev1mW/fb/JwEmCZHiTUvsKaCWEPUiZpErpjRMotxLSnWdgh99zjPThPwqcDL0UuJv0wsJ+8n1pEwzShiV8zILQ6AV29U5rldL2CO9utXFyooZ7uj+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8w/YX/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4858DC4DE1B;
	Tue, 19 Nov 2024 04:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731988836;
	bh=H/l5xrciMXlyQBTIz9b8sTFLZf2JhBIFJA68qPy9/mM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U8w/YX/xtMN+SaN7j8goDXxNUu+eHxzF5ImEPtFjg6xKSRFi75yJ8QptwBm3vRVyg
	 Ag5EIaMrkE41dKwagrDuWQ8I3rz+SF0yLok8jaZBNO/t8GXlHXZwUrSMbv1UDXCkvw
	 LrbbLRPRkKGcZ4B9rhZn7cdoJAC2Tjo3RL789ymTJTD8Cr63yfcthHaRlLf8IdTSs3
	 s78pQ4t8DCPUATL68hw1UwSLzie2nZNQwslhHU94j/xSOdo6C+EDByOtsvcfMHFqp3
	 VSiVp1o7buMx+qiaKP4ZXBwjPPIkI92YgpAzVq1aa8yzku9TssQI03mu3bq/MGU+eQ
	 x0W4x6tERx3Wg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACF23809A80;
	Tue, 19 Nov 2024 04:00:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: net: add more info to error in
 bpf_offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173198884774.97799.11108809880161471249.git-patchwork-notify@kernel.org>
Date: Tue, 19 Nov 2024 04:00:47 +0000
References: <20241115201236.1011137-1-kuba@kernel.org>
In-Reply-To: <20241115201236.1011137-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 Nov 2024 12:12:36 -0800 you wrote:
> bpf_offload caught a spurious warning in TC recently, but the error
> message did not provide enough information to know what the problem
> is:
> 
>   FAIL: Found 'netdevsim' in command output, leaky extack?
> 
> Add the extack to the output:
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: net: add more info to error in bpf_offload
    https://git.kernel.org/netdev/net-next/c/920efe3e13f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



