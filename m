Return-Path: <netdev+bounces-144941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D239C8D0A
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D524281C53
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 14:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22833D0C5;
	Thu, 14 Nov 2024 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVLCTY4h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE762EAE5
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731595220; cv=none; b=ZtW2lGP39o+N8xV9DS1pAl9g5FYrZE/geZn8rrOXN+JkqT/tHs0r+hFNsYF8WmkCpVDAGPeQSm9ahs3ME3aD5eTum6NLBXlXB7ZaZoFpwp4q/WHgub+DINHyt4oj0RBhemy8ko7eBRCt38WYs0pKbgE0AO0beXRc9jYVyAqP4cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731595220; c=relaxed/simple;
	bh=R6HWlFhqxVCVvURCJYlhJqzNe7VztGRlyy5JjOoV0EM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DjoKdvxYPGdt9E5Gl38DrL26rUkgVSlNxqIQdXK6mlQwkI8HMqSbIfNHkmHPn6lVAbsr34M41O4lhV0gpSjUaTi004x7ifd32sqS72WC/k4vw+n4y3yzZ8liKIAIXPYzlih6GORfwa+e7Ye6CZKS6vD9xJbxi4/3kUcqEgLb578=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVLCTY4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED750C4CECD;
	Thu, 14 Nov 2024 14:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731595220;
	bh=R6HWlFhqxVCVvURCJYlhJqzNe7VztGRlyy5JjOoV0EM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VVLCTY4hmQRe+F/CyGPnz6QyNT+tW3inRpH8JmYlKq5sGny/w5N2KwZwMFmkeP4Nj
	 Wrsa/htly2nplwFJ97FFScpCZ7vYcy6OPQa/Lxxt+GzeEyWs4DBnFrSrw75/Fswte4
	 TKWhQ3ed7UGLVKhHalMuPedqzw4lvrKLYoBr1ja2VNwW9PlVVW3eHIdb0e6IKt3RwY
	 C0STbRUhSrJxiMADs2TsGRpN7T/99sjQXDgEzjsxr8n+FQM4SJuSDVPI4QaBSnszSW
	 t/pEO0DkoItd7gewlnrd4WqBl7Ql1VkIqsnusUDzG8t1/5XretkS5mYMlRo1qtKBXO
	 +nbZjGydJs+uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF0F3809A80;
	Thu, 14 Nov 2024 14:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] eth: fbnic: Add support to dump registers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173159523051.1944485.15705866008945262491.git-patchwork-notify@kernel.org>
Date: Thu, 14 Nov 2024 14:40:30 +0000
References: <20241112222605.3303211-1-mohsin.bashr@gmail.com>
In-Reply-To: <20241112222605.3303211-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
 andrew@lunn.ch, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, kernel-team@meta.com,
 sanmanpradhan@meta.com, vadim.fedorenko@linux.dev, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 12 Nov 2024 14:26:05 -0800 you wrote:
> Add support for the 'ethtool -d <dev>' command to retrieve and print
> a register dump for fbnic. The dump defaults to version 1 and consists
> of two parts: all the register sections that can be dumped linearly, and
> an RPC RAM section that is structured in an interleaved fashion and
> requires special handling. For each register section, the dump also
> contains the start and end boundary information which can simplify parsing.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] eth: fbnic: Add support to dump registers
    https://git.kernel.org/netdev/net-next/c/3d12862b216d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



