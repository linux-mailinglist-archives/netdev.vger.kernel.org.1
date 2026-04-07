Return-Path: <netdev+bounces-275808-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFeyFBNc1GlrtQcAu9opvQ
	(envelope-from <netdev+bounces-275808-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:21:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE4D3A8AA2
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCCD1304F2F0
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 01:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20A7211A09;
	Tue,  7 Apr 2026 01:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QU5LBr+A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E96A1FFC59
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 01:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775524832; cv=none; b=GZoqqqs/W/1M4ETy/CUn3sqjdKKpfJlSpd2D1hSxmf+U/JKaHWl64CIlb6gQcGM2jlmfD7FBQLYTPfQkr4q17V65DaLnnm9TH/jLU840Y/3hqVAMpIeEwIYjFEzsBNLj1RWjTGkYQm3wOAfTSCBcfZKu0JMM/NsjzXy5hj0I3Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775524832; c=relaxed/simple;
	bh=cUEBRPkuWGBaxiM43UYH6nZcMElAH6ucnYaDmMh1/U8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CLZYNfoawUbOx/GS5hLzfOyku7dbX/MduIdtBCYuk8bTC2nlrCtC0TUPICPAB8C8pC0/En8Eq+0EroFsTk97/DJF0EHMVZ+qBqCIG3rrdOOwG2B2Zn/+YHp4hEJmA4DC7vRP4XyVszi1sNXnIwEL7fkQMDUWUT1yvTB2n/kBqt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QU5LBr+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D649C2BC9E;
	Tue,  7 Apr 2026 01:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775524832;
	bh=cUEBRPkuWGBaxiM43UYH6nZcMElAH6ucnYaDmMh1/U8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QU5LBr+AAxyNlQTmN8FSgGhs56BBcaDXUXPaV7QbdZVlzHyOwB2t2sAKadnHcgP3E
	 7F02UkCnpo9EG7kuB0AksxjWqlhv0KUjfo4XWxWgvjle1CU4PmAxT3epN7RRfUMmmU
	 xRNwr8K6EHbKSoLuVRwe40/RJQlPlCiVjRmhIFkkN/k+k0M2n1Q2TIOSvsyDR3WoFo
	 yidSKek+EGBpotvMd9obx7xuIBm4Bek7JmKTgWvsuNkv+dYeIc9l/2pxq9hvV55X+z
	 dUpXMfIHbPQqcYa7gDY4DlD41cRJgECLu5zZFW2AYiasiqdgqTk6IKL8VhXQTPVX3y
	 cxxXhYCmGM7ig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DDC3809A28;
	Tue,  7 Apr 2026 01:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mctp: defer creation of dst after
 source-address check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177552481054.3328957.124110111149778948.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 01:20:10 +0000
References: 
 <20260403-dev-mctp-dst-defer-v1-1-9c2c55faf9e9@codeconstruct.com.au>
In-Reply-To: 
 <20260403-dev-mctp-dst-defer-v1-1-9c2c55faf9e9@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: matt@codeconstruct.com.au, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-275808-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ACE4D3A8AA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 03 Apr 2026 10:24:51 +0800 you wrote:
> Sashiko reports:
> 
> > mctp_dst_from_route() increments the device reference count by calling
> > mctp_dev_hold(). When a valid route is found and dst is NULL, the
> > structure copy is bypassed and rc is set to 0.
> 
> Instead of optimistically creating a dst from the final route (then
> releasing it if the saddr is invalid), perform the saddr check first.
> 
> [...]

Here is the summary with links:
  - [net-next] net: mctp: defer creation of dst after source-address check
    https://git.kernel.org/netdev/net-next/c/f32ba0963119

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



