Return-Path: <netdev+bounces-120385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C45959189
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 02:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC386B240FA
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 00:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5876717BB31;
	Wed, 21 Aug 2024 00:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osa15b3m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3496917B4F5
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 00:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198440; cv=none; b=IVIvW7EaG2j7jFy7fgYibR+fSLca8vL4xO7zNrHOCMWK7aGqMJslkXOwSg+s4Ht3yuxGByWSmmnG22MPYDUrYT/hCKMVSaoDNQ28wJXf6S6LBhSXISNy6M6Rq+jLnxGQFKyKDKVq3lm+3nlahPS+M8+vh/ZuYWLpBIWPtktcgE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198440; c=relaxed/simple;
	bh=1Edkebq4l2apbgbhKjrkkcL85AUW3CB5mlWw4qTlMnI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OI0jEFZRO6NweIHj4Fkrl3L/3NiV90Y9Cq7OV0CI7OqYoJ+pLHi83yt/nD/nYuR4N9DCW4BlFoGCXHffwnsKdcY1NQRxTdGS/AwDUgRbxyHi0HICWh5cWfAHNSVcXEcUWrRALk1eWcsP1Zi+vNhACc7ikSW4+OVE5f3ZGM+wGas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osa15b3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A667AC4AF13;
	Wed, 21 Aug 2024 00:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724198439;
	bh=1Edkebq4l2apbgbhKjrkkcL85AUW3CB5mlWw4qTlMnI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=osa15b3m9OU03xYGjEQAT4uEk3BSX6z7wlKgc9TgmrzyXEPNuYI2Io7z50yleYUNq
	 yXZsrHQJHQnxQv9G8/+DnPjXHR9kRAR87xLCs8Yb3JI3qk5jx4D4W/O7fmkylDp00A
	 4m2AILeU/qq7vhIXSyf921tZR6Vjo+fTeQwKNBo8R1yrop1wPrQlCmrM04D36EonO2
	 maOfvgGBDIKwMCtzE4uNSl8hxxQnVyP2t5TdZlCQIESTRRs5ZCAUtGbSMnnkpH7LFi
	 jhVCA12QuOtFAGSMK8HKDaohhlcua4OZvjRMaY7bZrMircu35M4PVYV+u80rTRkZbO
	 92/jHqZMubHsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DF63804CB5;
	Wed, 21 Aug 2024 00:00:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] l2tp: use skb_queue_purge in l2tp_ip_destroy_sock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172419843899.1275153.9977387677867492945.git-patchwork-notify@kernel.org>
Date: Wed, 21 Aug 2024 00:00:38 +0000
References: <20240819143333.3204957-1-jchapman@katalix.com>
In-Reply-To: <20240819143333.3204957-1-jchapman@katalix.com>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, tparkin@katalix.com,
 xiyou.wangcong@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Aug 2024 15:33:33 +0100 you wrote:
> Recent commit ed8ebee6def7 ("l2tp: have l2tp_ip_destroy_sock use
> ip_flush_pending_frames") was incorrect in that l2tp_ip does not use
> socket cork and ip_flush_pending_frames is for sockets that do. Use
> __skb_queue_purge instead and remove the unnecessary lock.
> 
> Also unexport ip_flush_pending_frames since it was originally exported
> in commit 4ff8863419cd ("ipv4: export ip_flush_pending_frames") for
> l2tp and is not used by other modules.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] l2tp: use skb_queue_purge in l2tp_ip_destroy_sock
    https://git.kernel.org/netdev/net-next/c/bc3dd9ed04d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



