Return-Path: <netdev+bounces-127987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7669776D0
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 04:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00DC61C20A4F
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 02:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2655284037;
	Fri, 13 Sep 2024 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gePyLcAk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03145F4EE
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 02:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726194030; cv=none; b=KcoPpTmmjAAXPn/kXTfbgDIPRzRXzOLXHiGyZjLTRsqEsKmtXxzAwf3LgjK1g6GCnHMETyI4krUeEqPCkr2WU31FIvRWt23XxZ15oNIstT3vnanVdwe0SB3PtMdc47zRQmGnVtwxbLSZInYK407vg/x33T3e9ljlXmNfAFwLoNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726194030; c=relaxed/simple;
	bh=ShZTfgc32Kujwgttx2c29XC/Ug9XkKQI31jwDhbB+dA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LyGQL9shvCTd3DbOrJfLx+1tDq6J5fSgOZc+9ZukBqKw0D5yoP5Flw1s5EziLgo9gbrqpggkCoZ36EhiDLxIK98nymtCEzQnReJLiNnVJK2PQSg727XuCuP9lnRT2UBA9wrsLbOlGzhVywh/Sa/3lZ+DpVvpPJ22y28umuwvHoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gePyLcAk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0C2C4CEC3;
	Fri, 13 Sep 2024 02:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726194029;
	bh=ShZTfgc32Kujwgttx2c29XC/Ug9XkKQI31jwDhbB+dA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gePyLcAkaxyjnlal+3xcjmuRqybXHnMUpfMah6lXWuiFipNMoB0Lq0l9FiKjp61xE
	 KAJrDNqDy0z0uT3cSSJur9gnyLrGnd6S0PrSx7Mr6c35I/PJpx3d4lNJuHF1eNgv0y
	 YHZPnZwY4tOMIcQMo+T96xO6MoelkZMCZFZspZjGFGS3Z36azdxkBtqXQC3YNxcJ3K
	 gXRR3DT9WcUBnVT6VngbesBO7w8F0suCT1tvy4q4mqLWZ6N7ZdG7tOdyQf25uQAI00
	 euoCtpTi+xm2nXP4SewajLZAAJG3d7BBIxmfFLzZuiZ5c+q5MXYDLCoJLie1V/HfMg
	 yTnDYHlyKAC4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEB63806644;
	Fri, 13 Sep 2024 02:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] selftests/net: packetdrill: netns and two
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172619403076.1789147.13967765917295767532.git-patchwork-notify@kernel.org>
Date: Fri, 13 Sep 2024 02:20:30 +0000
References: <20240911000154.929317-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20240911000154.929317-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, ncardwell@google.com,
 matttbe@kernel.org, willemb@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Sep 2024 19:59:56 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> 1/3: run in nets, as discussed, and add missing CONFIGs
> 2/3: import tcp/zerocopy
> 3/3: import tcp/slow_start
> 
> Willem de Bruijn (3):
>   selftests/net: packetdrill: run in netns and expand config
>   selftests/net: packetdrill: import tcp/zerocopy
>   selftests/net: packetdrill: import tcp/slow_start
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] selftests/net: packetdrill: run in netns and expand config
    https://git.kernel.org/netdev/net-next/c/cded7e0479c9
  - [net-next,2/3] selftests/net: packetdrill: import tcp/zerocopy
    (no matching commit)
  - [net-next,3/3] selftests/net: packetdrill: import tcp/slow_start
    https://git.kernel.org/netdev/net-next/c/e874be276ee4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



