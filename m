Return-Path: <netdev+bounces-217117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EEAB37666
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 03:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957D23B82CE
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 01:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C7A15E5C2;
	Wed, 27 Aug 2025 01:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYtyTETl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DF93595C
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 01:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756256422; cv=none; b=t82bdS4Na8oQBh7zbfqxtrTQ8PJESJJ60TbMfUVQXxP0nWIcsuCnSE4eOQwJe0NZFWV3c58YlvF9Dng49bW4b1TtjF9jtXjy4N26frDrVuV6T58L6XRNDZU51NHnhL1PleyTDbUjFIXqmrNNlJGa4uUjpLemSlfA1/Bwc18CcXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756256422; c=relaxed/simple;
	bh=nxKvnMuORqtzdryqYWVNnkje0nJtXRZOPXZr2bKxkfg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=llPB9ze4/wHVZ1H6i5+/U3syBD6HJ0nKozZhPi6PMb2dSixUBeFnXDZMNvkAg7M58wH3SwDG5QfInsyDvBvkve4hGb5Ske+vJMXzYlYnb+TRWsQ/1MZK6As0zRDe46+kp5OcWy++6+KCaHTsaKKpE6B35KwbgGcabVYgff47n8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYtyTETl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2298EC4CEF1;
	Wed, 27 Aug 2025 01:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756256422;
	bh=nxKvnMuORqtzdryqYWVNnkje0nJtXRZOPXZr2bKxkfg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rYtyTETlJ+7TMfJA81hwCRmLDtJvkoRqOs1aUiStP9nb5lyZfPSh46slwKiG9xqDD
	 U7RzcDT+6VQc9BI64jp+H2RVaIuYqA4zAsN+XUjfpjjaAsRaUYSdR+vCZJQxXFPbQx
	 GTrQ0AcGtO0lGshy+fuOjGL1nRGmGR9c/3YlsE9hkOT6plDJq3m0sWud/BgQqkSp0j
	 bds2OYGEdbhvfIFGH+YpzqZwsrGBBfAM5w3cVmDxEPXmej2mPXoB6UxOgtP1kFKjw8
	 VSlVxKEHmCcIiDFr2lM7ravyTDVm2hD5Mdr2pJCwF9wIBsWCz0fYjKs18FnfES4qS6
	 iC4vFlM/nUAEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAECC383BF70;
	Wed, 27 Aug 2025 01:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] ipv4: Convert ->flowi4_tos to dscp_t.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175625642950.155051.8630920604442661062.git-patchwork-notify@kernel.org>
Date: Wed, 27 Aug 2025 01:00:29 +0000
References: 
 <29acecb45e911d17446b9a3dbdb1ab7b821ea371.1756128932.git.gnault@redhat.com>
In-Reply-To: 
 <29acecb45e911d17446b9a3dbdb1ab7b821ea371.1756128932.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, horms@kernel.org,
 ap420073@gmail.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 ecree.xilinx@gmail.com, pablo@netfilter.org, laforge@gnumonks.org,
 dsahern@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, martin.lau@linux.dev, daniel@iogearbox.net,
 john.fastabend@gmail.com, sdf@fomichev.me, ast@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
 kadlec@netfilter.org, fw@strlen.de, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, marcelo.leitner@gmail.com, lucien.xin@gmail.com,
 idosch@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Aug 2025 15:37:43 +0200 you wrote:
> Convert the ->flowic_tos field of struct flowi_common from __u8 to
> dscp_t, rename it ->flowic_dscp and propagate these changes to struct
> flowi and struct flowi4.
> 
> We've had several bugs in the past where ECN bits could interfere with
> IPv4 routing, because these bits were not properly cleared when setting
> ->flowi4_tos. These bugs should be fixed now and the dscp_t type has
> been introduced to ensure that variables carrying DSCP values don't
> accidentally have any ECN bits set. Several variables and structure
> fields have been converted to dscp_t already, but the main IPv4 routing
> structure, struct flowi4, is still using a __u8. To avoid any future
> regression, this patch converts it to dscp_t.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] ipv4: Convert ->flowi4_tos to dscp_t.
    https://git.kernel.org/netdev/net-next/c/1bec9d0c0046

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



