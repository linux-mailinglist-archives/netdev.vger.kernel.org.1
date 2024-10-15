Return-Path: <netdev+bounces-135389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C7C99DB06
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 03:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FAF1C20D92
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 01:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B890DDBB;
	Tue, 15 Oct 2024 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWn0Iweh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479EBAD2C
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 01:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728954028; cv=none; b=GjTXwhdpJUd+28B+lnHrst4P1NIJ1BoA9aSAQfNR0TzF2bU5j3W/uE+8WnDrAIoffz4wbBp0B+TD62FexSjZYzT+PeDM6SrsPMo4phJDZGC223SaMKDMBAnsed92txxLbbgZIwdtvQSkmEiHlCK52q0+ubeTJKOGVoim8WYhkcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728954028; c=relaxed/simple;
	bh=GBFBEp0ZFzk8tCvBx0eDLXhhZCO1pI1cyLDutoyO57I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PVLWFnYkzTxurYwR88OKJDfkLDWx+TUXjZGNGFbMgoLpUqkTGTD9wl2EeF4P2bmh+0Tgp3EkM8GsNNurpOZ601VU7pUMLTBhXRlbFP2+e5ghsFcGw0jZV2ksdFYSoLmzxKOJOKO6mQGYXkvZgQuTTPk79MAGvF9ifIkimpUzN+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWn0Iweh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B50C4CEC3;
	Tue, 15 Oct 2024 01:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728954027;
	bh=GBFBEp0ZFzk8tCvBx0eDLXhhZCO1pI1cyLDutoyO57I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RWn0IwehWRFFK4/RCy83tsmj3jsCbwhLdxeWk7Yn9j2pPRelFbD4Q7TdT4bf1F50T
	 tkRrh0AxKBUFjJFx81PVz4uQPKjb9Sp7pfgD/uouW0Ydl9WJMimejeFIP5KIXHE9UB
	 H3KDEHwNyWu1xW2hH0XMlX2UNxnRHp1shS6vyviZpyynFPLegfIZIBfnSPX6G6cn7h
	 koupPG4l0IgASm+X7+E8Fut3J5iaxSmczCsiO45WqCy4BOxqo91mmfWM5BXngwDeHH
	 3QJKrxQzt76HZFMpG0SuUjsO5LVW+6z/d785E3G4SOSAmlU/ll4wDvBV99cLYUNjQ2
	 d25NLBfKgJpXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD3A3822E4C;
	Tue, 15 Oct 2024 01:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/5] tcp: add skb->sk to more control packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172895403276.684316.13099111913312204295.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 01:00:32 +0000
References: <20241010174817.1543642-1-edumazet@google.com>
In-Reply-To: <20241010174817.1543642-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 martin.lau@kernel.org, kuniyu@amazon.com, ncardwell@google.com,
 brianvv@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Oct 2024 17:48:12 +0000 you wrote:
> Currently, TCP can set skb->sk for a variety of transmit packets.
> 
> However, packets sent on behalf of a TIME_WAIT sockets do not
> have an attached socket.
> 
> Same issue for RST packets.
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/5] net: add TIME_WAIT logic to sk_to_full_sk()
    https://git.kernel.org/netdev/net-next/c/78e2baf3d96e
  - [v3,net-next,2/5] net_sched: sch_fq: prepare for TIME_WAIT sockets
    https://git.kernel.org/netdev/net-next/c/bc43a3c83cad
  - [v3,net-next,3/5] net: add skb_set_owner_edemux() helper
    https://git.kernel.org/netdev/net-next/c/5ced52fa8f0d
  - [v3,net-next,4/5] ipv6: tcp: give socket pointer to control skbs
    https://git.kernel.org/netdev/net-next/c/507a96737d99
  - [v3,net-next,5/5] ipv4: tcp: give socket pointer to control skbs
    https://git.kernel.org/netdev/net-next/c/79636038d37e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



