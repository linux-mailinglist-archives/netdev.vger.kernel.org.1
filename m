Return-Path: <netdev+bounces-240613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8021FC76F1A
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 03:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 793D14E654D
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 02:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8716C2DEA77;
	Fri, 21 Nov 2025 02:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ju4E49ze"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639C42DE71C
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 02:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690452; cv=none; b=q2UU5ho1bOthbtWAGUSOng+ZzHT7qD3NZ4rGVIiNB2d/fd9Zlk+FJGNJpOqwXv3tuYvoOLPrrL9Qc92wD7zdZtv7pbrnmFS96IvHGgSNio4BileeYgAemGOkcupkaM5Ji218Bxgj3bwJ64wbGRNeocteAMnnoR0lXRfVV8vSUiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690452; c=relaxed/simple;
	bh=42NTZzvi6TY8uXx0RJviohhysxaeeZnMlylxxlKMhVI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JqAHtg3QtMDx4do32KxhS/BzbzuBEMMsG0y2jqdUW4Me3xkgCfDxD4SV9GQ2TBzKDuRyn1VttkkkhICC3ZmaGLjkaG0s1/4nvs2Y6aiIeKYab0YMeUZ8zTCdeFQ/DfEbRvrtTBiW/XfkuZUEHowU4uacb9R8Y3sii39MXagiD1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ju4E49ze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB79C4CEF1;
	Fri, 21 Nov 2025 02:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763690452;
	bh=42NTZzvi6TY8uXx0RJviohhysxaeeZnMlylxxlKMhVI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ju4E49zeuQNDWJtbEpAl1pcAIONAZtdzZCb+mBa9vnXWMn7GgC8PgKvFBu/K0ieqo
	 E75iXlcDK0hxhkP/uyb0n573B9pgdH6qDVHsFadpP+EjjKeMjXbFCg5O5M4jlWXD6i
	 UvLCN+sHbPZNDmrekc87+Fi9xYeKkGn76LKliwhH62aw0wsMZk7+QWGklKcNUM+R0r
	 Kr9MuhwEsD7/QnhtQxUc8uE7MBEprb0xZgsTpIXYSlyhB0tMonqh6b/EEzBrCaEfFw
	 F76lGBhHTsDIj2FWxsVxdWg3QFX0c4hcCO2xeYaTajNbfXHIUxhoD3OVcNCfZkcM/d
	 Q2CgKEfE0vRrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F343A41003;
	Fri, 21 Nov 2025 02:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/2] tcp: tcp_rcvbuf_grow() changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176369041676.1856901.6756331761484147922.git-patchwork-notify@kernel.org>
Date: Fri, 21 Nov 2025 02:00:16 +0000
References: <20251119084813.3684576-1-edumazet@google.com>
In-Reply-To: <20251119084813.3684576-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, jonesrick@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Nov 2025 08:48:11 +0000 you wrote:
> First pach is minor and moves tcp_moderate_rcvbuf in appropriate group.
> 
> Second patch is another attempt to keep small sk->sk_rcvbuf for DC
> (small RT) TCP flows for optimal performance.
> 
> Eric Dumazet (2):
>   tcp: tcp_moderate_rcvbuf is only used in rx path
>   tcp: add net.ipv4.tcp_rcvbuf_low_rtt sysctl
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/2] tcp: tcp_moderate_rcvbuf is only used in rx path
    https://git.kernel.org/netdev/net-next/c/6d5dea68246e
  - [v2,net-next,2/2] tcp: add net.ipv4.tcp_rcvbuf_low_rtt
    https://git.kernel.org/netdev/net-next/c/ecfea98b7d0d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



