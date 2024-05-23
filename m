Return-Path: <netdev+bounces-97755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E048CD076
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 12:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8142B1C2250C
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 10:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E470013FD8B;
	Thu, 23 May 2024 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBw5ml6l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CC913CF98
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716460828; cv=none; b=nVjD+INmByspmtTmhd144KjdvTZ7+U+6ezY2JmcTiTQ2iw+cDBH7i99TrECMuOV+ja1vdrwudo/cS5tCKXFUgTh40OmztGv8WOBuM4qFgPgQqbxLzGk2FXjoUE+gGgqqydjxUO+k+5g7X+9FLcig50JHpbB+cFs+lSWdGadDcnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716460828; c=relaxed/simple;
	bh=hyNalhUOLxxLhfM1W+2XBEta4ZWUh4Rd7lrEjzOtQTQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hzJkFAr74ZDAyX7iCFcstg4mhBq9ryHw4U4zXL72ChFdsiCmr8Ya+e+/t/bTwQa3jMOFtgITrSRteUqEzxNRKrkfCZhyB36NmdwfS4tTNMJKdWrI5F7b5LbWkj82l4m98fV5vXOqbcJsHzTeE+eabs1fWOesxA0yWjMEnhB09Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBw5ml6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B3DFC32789;
	Thu, 23 May 2024 10:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716460828;
	bh=hyNalhUOLxxLhfM1W+2XBEta4ZWUh4Rd7lrEjzOtQTQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MBw5ml6lgkAkTD2FekqmhtJptQX7NrDNdOPVLy8eCVJ3Q6OjyQ5H3QdlfIRVedWU/
	 kG3U5WgGh+oRr+jbgiWjoAsX80S3OG5OrUIIWJgV7XgRMe7F1YPMWJnWJ2qy+g6OvP
	 D3PeU0ykoM0e4tSOaZsRu1JbWLhKVWIuCC1t0Hi0qXRzYPIYL2uioavmUTDNgHuFgu
	 694DxzlAUTbRNNJqGAi7+4D3g6129TZGSqI4dGW0MpOlNNieTrFT2WHrzzp/2LcjdB
	 PqEVMyhylXnNVfxDs7RmK985DbE/kOgDzuTZwp8YKMOvDbx4INmYAarSXVC2vEsKQC
	 GNQdoOmz9j8SA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47BC7C43333;
	Thu, 23 May 2024 10:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: remove 64 KByte limit for initial tp->rcv_wnd value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171646082828.30155.10245469375676223396.git-patchwork-notify@kernel.org>
Date: Thu, 23 May 2024 10:40:28 +0000
References: <20240521134220.12510-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240521134220.12510-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, dsahern@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, ncardwell@google.com,
 netdev@vger.kernel.org, kernelxing@tencent.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 21 May 2024 21:42:20 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Recently, we had some servers upgraded to the latest kernel and noticed
> the indicator from the user side showed worse results than before. It is
> caused by the limitation of tp->rcv_wnd.
> 
> In 2018 commit a337531b942b ("tcp: up initial rmem to 128KB and SYN rwin
> to around 64KB") limited the initial value of tp->rcv_wnd to 65535, most
> CDN teams would not benefit from this change because they cannot have a
> large window to receive a big packet, which will be slowed down especially
> in long RTT. Small rcv_wnd means slow transfer speed, to some extent. It's
> the side effect for the latency/time-sensitive users.
> 
> [...]

Here is the summary with links:
  - [net] tcp: remove 64 KByte limit for initial tp->rcv_wnd value
    https://git.kernel.org/netdev/net/c/378979e94e95

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



