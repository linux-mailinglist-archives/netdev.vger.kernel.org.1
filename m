Return-Path: <netdev+bounces-266423-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEwqBBHWsGnLngIAu9opvQ
	(envelope-from <netdev+bounces-266423-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:40:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F3225B05A
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B47613023ABE
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 02:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CF23290CB;
	Wed, 11 Mar 2026 02:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ptmo5TZ7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E4424A076;
	Wed, 11 Mar 2026 02:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773196809; cv=none; b=sbmP8p9q8KK2jcEavJJGK+q9mRq4nWhVdrtn6tjWzb80PUkKRx7WC/GLmvy7q5MKtFTCEfmltMsVfsJIdTvsvoP/MlwViFtc61aeQF+btuD7QnVaY5nH//BZTX4y8E6uconfTT/CCOQhJC63yscNv+Ib+LXHdALXQFDyrGfu8Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773196809; c=relaxed/simple;
	bh=Ucx5TIv2w1wnhufdoMWg7B8yvrx7FLI81e377GXvYnI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nMkmnuZtt6ei8agXK6aNzPF+2RRMXKmqw/zWpbesWIP9IPt6j9b+YCbaCjrwaF4or2aOcQ0V8RkNX713L0C5ZlN9AwrZCkcPOB3jty0uQ7UKMo9RsQ5AZPYh9ftDoUnhVoENUKKV2VH5fzBqur3TsCRpgvxjjnBu1T5/sNBLdPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ptmo5TZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2385CC19423;
	Wed, 11 Mar 2026 02:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773196809;
	bh=Ucx5TIv2w1wnhufdoMWg7B8yvrx7FLI81e377GXvYnI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ptmo5TZ78pjESmi8tgLeDaqIHI/RdVGlNsnkJ9D0t6SRYLBoB1OTAmVDyW0VRiu+b
	 HX4ZxLGRzCacasgybVASodGPbFqZtnwqPcH0bxsVns9y+odX61qS3ffhDDXPsIL6ia
	 I4TwWiS7dTBNYifyErJ9L3GVm2OY4b03nAbV2ZDDNOvJcsyp5Hk+bxpmwWuQ8CUaDb
	 ouv5ehIZEESgMesx97/x0pW+hPt7W0CloX96FPoeCNl8ZWnDoRGu39Am9HPdLg5dDs
	 lx+p0J9udo4YKxcJwQo0Q3O5s6zm+gl8fJwuRxmTkRBjgh/Onmzu8B5J/vBRQNsX4V
	 KU4lRAZEWoPMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F2D3808200;
	Wed, 11 Mar 2026 02:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net-shapers: clear hierarchy pointer and defer
 flush
 frees with RCU
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177319680555.3014711.8321881589100718655.git-patchwork-notify@kernel.org>
Date: Wed, 11 Mar 2026 02:40:05 +0000
References: <20260309173450.538026-1-p@1g4.org>
In-Reply-To: <20260309173450.538026-1-p@1g4.org>
To: Paul Moses <p@1g4.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Rspamd-Queue-Id: 01F3225B05A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-266423-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 09 Mar 2026 17:35:06 +0000 you wrote:
> net_shaper_lookup() and the GET dump path traverse shaper state
> under rcu_read_lock() without taking the shaper lock. During
> teardown, net_shaper_flush() freed both the shapers and the
> hierarchy with kfree(), but netdev->net_shaper_hierarchy still
> pointed at the freed hierarchy.
> 
> This lets GET readers race netdevice teardown and walk freed
> xarray state or freed shaper objects.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net-shapers: clear hierarchy pointer and defer flush frees with RCU
    (no matching commit)
  - [net,2/2] net-shapers: don't free reply skb after genlmsg_reply()
    https://git.kernel.org/netdev/net/c/57885276cc16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



