Return-Path: <netdev+bounces-140568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA689B70B9
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 00:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1284028261E
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 23:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151E5215008;
	Wed, 30 Oct 2024 23:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Var1IqHN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12F01D04A6;
	Wed, 30 Oct 2024 23:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730332223; cv=none; b=pVHiiwQBoTw0qR7c+0Swz1IFF66bS5PmSOjCAcyhEB6mJshaQwiU+IMknW8Ab5Z8CPLLc/ns6M/ZQdvpLSiCvbvFuHEqSxXsadRVrW72pMlJmRds1Z3jzH52U3Sxb9+V8hj0Oh58UN2htfPB2MptSBaM6tgZ6NFEzjft3ebZ2Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730332223; c=relaxed/simple;
	bh=yKfvyFHnqwH4Gv8CuyMwWba0GzSktN0CMcAlF/ilRsc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gNwRGa3JECyXTVyjQlA8hpoRN7C+q6bxZjv6ismNbhQ5+/JPjkEYx1CRVchoPh5cHyUsi59VaWOVGiWChMkBF6hJVs8kyrszf2doc3gxaGmijDN1BiVZA5HeV0cN/kGA6DFdZPKfbSAWUUaotW/IZpBsgZ4C/qoeQTrCgxvoWjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Var1IqHN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EA4C4AF53;
	Wed, 30 Oct 2024 23:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730332222;
	bh=yKfvyFHnqwH4Gv8CuyMwWba0GzSktN0CMcAlF/ilRsc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Var1IqHN6gQYqK+cjHVywMHYOlls/HOEyHjnhZk8B4gPzTrICD/nZHuzj0+vSpphA
	 9ZzZrTt7ot4FpiseEo2agNgmBjxYnKhifOFmfC0+jmqBd2JDBOx2/09RZGzpMaPNm1
	 z5PJY82LuEIibbkjwmRxkBLKpdzfFILoAp4AITfNjcwVqlkABNDBX3JxBYFWRwlc2o
	 KmpwiDBh4xcjf+v257Sm+E8AIZMxEQE9TN7dN05rk4QKJTAJQNcIRLuc1vuKemSiZv
	 d91a1W1dSszLAi45JEXKryRquhFWNqaIXkuOYmGKhVYfR61+Bj3/SgDi0rwAWV12N9
	 rWN+aQ9C3Djkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71029380AC22;
	Wed, 30 Oct 2024 23:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] tests: hsr: Increase timeout to 50 seconds
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173033223026.1495543.3228017262057371335.git-patchwork-notify@kernel.org>
Date: Wed, 30 Oct 2024 23:50:30 +0000
References: <20241028082757.2945232-1-jiangyunshui@kylinos.cn>
In-Reply-To: <20241028082757.2945232-1-jiangyunshui@kylinos.cn>
To: Yunshui Jiang <jiangyunshui@kylinos.cn>
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Oct 2024 16:27:56 +0800 you wrote:
> The HSR test, hsr_ping.sh, actually needs 7 min to run. Around 375s to
> be exact, and even more on a debug kernel or kernel with other network
> security limits. The timeout setting for the kselftest is currently 45
> seconds, which is way too short to integrate hsr tests to run_kselftest
> infrastructure. However, timeout of hundreds of seconds is quite a long
> time, especially in a CI/CD environment. It seems that we need
> accelerate the test and balance with timeout setting.
> 
> [...]

Here is the summary with links:
  - [v2] tests: hsr: Increase timeout to 50 seconds
    https://git.kernel.org/netdev/net-next/c/365836e010a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



