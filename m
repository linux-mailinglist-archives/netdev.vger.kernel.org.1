Return-Path: <netdev+bounces-148450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F9D9E1B2E
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 12:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60BC7B25755
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 11:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915981E048B;
	Tue,  3 Dec 2024 11:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6DOcKyr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2B518C03A
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 11:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733225415; cv=none; b=UTo9UtV1ZBdVTI0r+InBVwOX0Xs72RkUF/mmATCu14pYiFqbQNauRN/1Vv0lmUVEulmi6kWmv9ofsnjXcxNs5e7BG1MlYZ+99lvjO4lsWhfL57xQ+QjrUjXjvegUv5dCUWPTz9OZWgSzhj2/5xzGaW+g11hh4ZSZFfL7nbkZMc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733225415; c=relaxed/simple;
	bh=aG0aNw1fFA+6/6jfgcizd+su+UQ3cnKHAKufRvaedcg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FyqAlGWrBrAEyf7kBeZWOpv4C38kcI3M45DhXMJ2yTdei4gDiz8QeNnlq+lhQA423xyiOhXc17MKHrWBxCs2tQgx9lKn9h9WmIeE4I3ybcuVpIbhTbXoU82ATSooYUfbz0GeXaV5iBZugqvZUTEiP/s2pCdpyFAEyI86fWRjE6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6DOcKyr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0119AC4CECF;
	Tue,  3 Dec 2024 11:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733225415;
	bh=aG0aNw1fFA+6/6jfgcizd+su+UQ3cnKHAKufRvaedcg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V6DOcKyrnMtdz2CLPDaN1QJeAMJ+g3F4xSqHESiGcgsq7NbYVw5BZa5tulsP+mdQz
	 K4pbBSZSuAGnaHJuZkb/BBRb8KPnUxaR+x4K1Gx0SbFw38ufqQs8Xlv0E8Ah2jx0fJ
	 bpqdfE52x44LMNQnIYPUuYLCPGPQEIkxtl8gFcaeCIFlQ90JOqJLb10ntPyMBNNJ8E
	 6sZPhNjd8tMD/L8XmjAURzbbcMUgxlf6HBoQlkSYKzg5/IKoDapfAglR3/p68E113G
	 raPVnBhaT1EReCQLNeYhDzuM5Wtc/DP1mrhw/jxioJmO501Rb37IOQYDyTOTujybGr
	 X9i/GkbGWSX1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D753806656;
	Tue,  3 Dec 2024 11:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: hsr: must allocate more bytes for RedBox support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173322542926.28419.3829425753490071863.git-patchwork-notify@kernel.org>
Date: Tue, 03 Dec 2024 11:30:29 +0000
References: <20241202100558.507765-1-edumazet@google.com>
In-Reply-To: <20241202100558.507765-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+7f4643b267cc680bfa1c@syzkaller.appspotmail.com, lukma@denx.de

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  2 Dec 2024 10:05:58 +0000 you wrote:
> Blamed commit forgot to change hsr_init_skb() to allocate
> larger skb for RedBox case.
> 
> Indeed, send_hsr_supervision_frame() will add
> two additional components (struct hsr_sup_tlv
> and struct hsr_sup_payload)
> 
> [...]

Here is the summary with links:
  - [net] net: hsr: must allocate more bytes for RedBox support
    https://git.kernel.org/netdev/net/c/af8edaeddbc5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



