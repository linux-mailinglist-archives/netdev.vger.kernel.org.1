Return-Path: <netdev+bounces-186088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B6FA9D0FB
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 21:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 490CE7B95DA
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 19:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5982321C171;
	Fri, 25 Apr 2025 19:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVKsr8jb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355E1219A8B
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 19:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745607667; cv=none; b=R16pc5yY/oHWbLARRdqexVWhFP/EbT3WWMaxdtLbPY1crWrs+2Cj93Xt5T0rm5Y74lFY4YgnBrtPRccjQ+VaV3hQzXXAWukkmTnrHhANh/MWoe9JVsY6YWVZZkQF0BmjIrbfpNwBlgmTzgcJ19+eadJAO4L0KUI3A8/0t63ko28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745607667; c=relaxed/simple;
	bh=VHvh6YxjidR7M45LZ4tWz9QXZoSMR/D/FONrHEqhEX0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jgSTYBLGbH3bg8RuNHV2AHRXugPm0hCJxvSS+nnG0D7symLS4/iftz19Qi4YAlZqDy3CyvgVYdRjkWX6qRmLCnm32AA7gUO4YITck7hVO2ze6BPE1S0fp/GVsqM54SM1W71l+XDaEcTUsgH9STr1vXIPfm+qyj/8ig3ZAJoSFlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVKsr8jb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C92C4CEEB;
	Fri, 25 Apr 2025 19:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745607667;
	bh=VHvh6YxjidR7M45LZ4tWz9QXZoSMR/D/FONrHEqhEX0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GVKsr8jbIog6fqomVs/cqI1DLnmJAdMkXilR2gbBtQnFkrTN00sAwYc3YY2C+KpMl
	 QLRQ66WLZW+8oyW66WDNU/YXBQx0e6rT3WreWs3didNKeYTcYrEfDaKz82yxiTJ6Nk
	 wX7K+E3aXlHM1tYD6Za7cXNIUg97fyNJ2LCMm4lx/vDACX3LJDKaVSyeWzpC/8FP+L
	 5W8jDFtnZWOb7qg3Xxj1eOOor4ABWhCsDDYRcfxYB+/ZDn/ezddNk+zCt9YPg8kEMK
	 HYOo3aBN93lhyAhdoxahmIRtOb2CZ2LAHSYNpOD4nex40B0/caalsevEpk+ArdzBYf
	 +yX5TfVRzld0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1CB380CFD7;
	Fri, 25 Apr 2025 19:01:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] tcp: fastopen: observability
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174560770549.3803904.16842138915969136049.git-patchwork-notify@kernel.org>
Date: Fri, 25 Apr 2025 19:01:45 +0000
References: <20250423124334.4916-1-jgh@exim.org>
In-Reply-To: <20250423124334.4916-1-jgh@exim.org>
To: Jeremy Harris <jgh@exim.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Apr 2025 13:43:32 +0100 you wrote:
> Whether TCP Fast Open was used for a connection is not reliably
> observable by an accepting application when the SYN passed no data.
> 
> Fix this by noting during SYN receive processing that an acceptable Fast
> Open option was used, and provide this to userland via getsockopt TCP_INFO.
> 
> Jeremy Harris (2):
>   tcp: fastopen: note that a child socket was created
>   tcp: fastopen: pass TFO child indication through getsockopt
> 
> [...]

Here is the summary with links:
  - [v2,1/2] tcp: fastopen: note that a child socket was created
    https://git.kernel.org/netdev/net-next/c/bc2550b4e195
  - [v2,2/2] tcp: fastopen: pass TFO child indication through getsockopt
    https://git.kernel.org/netdev/net-next/c/2b13042d3636

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



