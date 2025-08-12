Return-Path: <netdev+bounces-213100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FE1B23A88
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 23:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BCB6171E17
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 21:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14692D7386;
	Tue, 12 Aug 2025 21:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="on9S1vBq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6212D7380
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 21:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755033615; cv=none; b=ZJ6ehDryaY9kjfm10fYcce462ySSWlRrSHlSJ1SXf0M26LwqzfRRnaDCVaT+FXpWDjzpolf4+17S69d5PWd/eVzbB8talcPQ3WyW6mvy86Y41F4EkTQaPw0hZ9v2DdlnN6h0LWdWw1g34ltKNOZkOnWKmcSXhFMzwg+s+2MBQzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755033615; c=relaxed/simple;
	bh=fgxWCFK27s6p5CvDuWjFVWXjTBQdQBGIgg6V8H+QmqE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WSUaNJu/d+v7f1IbTaG+oQ1f1LPWbkv3QjhtLVhdBid9fcoaqC7rp+2sZI/Ki12vneCKH+uzQpyyq3Q7XzRXA2CDLkrhHSQHtQy93CyXiSKHZd+FCtgak5UHVUkcq+dmOdfWRFPILL6Xly/c2XXx2NDx+MDWA7Y4StlMvjKSRQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=on9S1vBq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76222C4CEF0;
	Tue, 12 Aug 2025 21:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755033615;
	bh=fgxWCFK27s6p5CvDuWjFVWXjTBQdQBGIgg6V8H+QmqE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=on9S1vBq/2DiJmaHtL19Iq++EaT+kYt3cL4t0akbptE5tawOWrxM7AVZdQdrYlmQu
	 bX0hT6KP08tR53kYhRvPYumtA54wugupuK6MXTMqvyfDaZ8h4/4P3INJz+f7wUYOtn
	 iboZPqfZf+bN7vKypb47egt1D3Wv2k4pUPQ27JD+4orh6PV6sRaog5vqc+5UiiNI0O
	 3jq6kE47zOkEFnA6QeT02p1zcgI7veLexSf18hOGnjTpZJedSNQtSQTKfU+aQCa3Tu
	 nl20ywfoCs+Hl2HtaFmpukWKGxoon1h4f7M1ioSB+SHD+8h2dGOgUx3CQLvNOITW3o
	 CnrqWIgkSzxoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBDD383BF51;
	Tue, 12 Aug 2025 21:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] phonet: add __rcu annotations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175503362750.2827924.13612421553345530740.git-patchwork-notify@kernel.org>
Date: Tue, 12 Aug 2025 21:20:27 +0000
References: <20250811145252.1007242-1-edumazet@google.com>
In-Reply-To: <20250811145252.1007242-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, courmisch@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 Aug 2025 14:52:52 +0000 you wrote:
> Removes following sparse errors.
> 
> make C=2 net/phonet/socket.o net/phonet/af_phonet.o
>   CHECK   net/phonet/socket.c
> net/phonet/socket.c:619:14: error: incompatible types in comparison expression (different address spaces):
> net/phonet/socket.c:619:14:    struct sock [noderef] __rcu *
> net/phonet/socket.c:619:14:    struct sock *
> net/phonet/socket.c:642:17: error: incompatible types in comparison expression (different address spaces):
> net/phonet/socket.c:642:17:    struct sock [noderef] __rcu *
> net/phonet/socket.c:642:17:    struct sock *
> net/phonet/socket.c:658:17: error: incompatible types in comparison expression (different address spaces):
> net/phonet/socket.c:658:17:    struct sock [noderef] __rcu *
> net/phonet/socket.c:658:17:    struct sock *
> net/phonet/socket.c:677:25: error: incompatible types in comparison expression (different address spaces):
> net/phonet/socket.c:677:25:    struct sock [noderef] __rcu *
> net/phonet/socket.c:677:25:    struct sock *
> net/phonet/socket.c:726:21: warning: context imbalance in 'pn_res_seq_start' - wrong count at exit
> net/phonet/socket.c:741:13: warning: context imbalance in 'pn_res_seq_stop' - wrong count at exit
>   CHECK   net/phonet/af_phonet.c
> net/phonet/af_phonet.c:35:14: error: incompatible types in comparison expression (different address spaces):
> net/phonet/af_phonet.c:35:14:    struct phonet_protocol const [noderef] __rcu *
> net/phonet/af_phonet.c:35:14:    struct phonet_protocol const *
> net/phonet/af_phonet.c:474:17: error: incompatible types in comparison expression (different address spaces):
> net/phonet/af_phonet.c:474:17:    struct phonet_protocol const [noderef] __rcu *
> net/phonet/af_phonet.c:474:17:    struct phonet_protocol const *
> net/phonet/af_phonet.c:486:9: error: incompatible types in comparison expression (different address spaces):
> net/phonet/af_phonet.c:486:9:    struct phonet_protocol const [noderef] __rcu *
> net/phonet/af_phonet.c:486:9:    struct phonet_protocol const *
> 
> [...]

Here is the summary with links:
  - [net-next] phonet: add __rcu annotations
    https://git.kernel.org/netdev/net-next/c/86e3d52bd3e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



