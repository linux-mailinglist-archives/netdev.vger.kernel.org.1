Return-Path: <netdev+bounces-266009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AN0fDT35r2mmdwIAu9opvQ
	(envelope-from <netdev+bounces-266009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:58:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 815EB249D34
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C88A314FBEC
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A637A372688;
	Tue, 10 Mar 2026 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ll4ooBFw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834471F3D56;
	Tue, 10 Mar 2026 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773139808; cv=none; b=IJemUxpP6EN5812JaDeTJCdI7xO4DOKGVngLbJ5V+hYD6meikLiIsQfti84EyUsLVdXrLLX/huDVVP/Z8Vk7wa34TvH+AxwSssPnWwSRVBT49z/VhFKtdcZIo0LJCfdHt88sG4rQ6KzLpSO1ieOukEM1sQyKdWnJqqguZzzlbck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773139808; c=relaxed/simple;
	bh=+WZCUwj9wOZLW5BgabvQZQsWHdNInRB76UgzhpwK+mg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YNKsYKY6rxvk2Eu9NkYeQPCB5bBnRwb+Db5atRPwAdiUdVtHwqPscnOgGKvPSxh2eXDfVVL/P4XyMteC80YY5UKvSsCKhY++LOaGV4jocye20bRSMWiGTvXBeOgd3ESgUaaB3jXoJpkxDv4MZJ3dbOFxa3DPIpsXJ0lQj+SSO7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ll4ooBFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D73C19423;
	Tue, 10 Mar 2026 10:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773139808;
	bh=+WZCUwj9wOZLW5BgabvQZQsWHdNInRB76UgzhpwK+mg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ll4ooBFwEpJqDW7kpa+yk38PSkiVVqqGLbUG8UvMh7/ltNHQwjU+G6Np6Rp4TehfW
	 QFIKYZp/sLNWU5DNv9JjQpaingkA78HqMyaQYBS+5cakXlY0T+Qe0glEQzNSuLvDkp
	 +JOdRhcLL/X83lRM2ARwSPRUeJWeZsSrS8ayVA8K0vPNxRryVwnD46EmZNcYAqwuUS
	 DRln3c+xuPNh77X0QoG2mlT3YBT0XvDK1IIDas0l+GsUD+JHvDR43cfBrAWqfy6xEM
	 fGDQbRc7YH+ga5JvGemsldBxro/hxLT38cKnF7HWBWU6xGFEZ6r6kOyXT6nulap5/e
	 L8nsiu39W7Rwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE013808200;
	Tue, 10 Mar 2026 10:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] mctp: route: hold key->lock in
 mctp_flow_prepare_output()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177313980505.2187053.18363180029918103615.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 10:50:05 +0000
References: <20260306031402.857224-1-dg573847474@gmail.com>
In-Reply-To: <20260306031402.857224-1-dg573847474@gmail.com>
To: Chengfeng Ye <dg573847474@gmail.com>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 815EB249D34
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-266009-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  6 Mar 2026 03:14:02 +0000 you wrote:
> mctp_flow_prepare_output() checks key->dev and may call
> mctp_dev_set_key(), but it does not hold key->lock while doing so.
> 
> mctp_dev_set_key() and mctp_dev_release_key() are annotated with
> __must_hold(&key->lock), so key->dev access is intended to be
> serialized by key->lock. The mctp_sendmsg() transmit path reaches
> mctp_flow_prepare_output() via mctp_local_output() -> mctp_dst_output()
> without holding key->lock, so the check-and-set sequence is racy.
> 
> [...]

Here is the summary with links:
  - [v3] mctp: route: hold key->lock in mctp_flow_prepare_output()
    https://git.kernel.org/netdev/net/c/7d86aa41c073

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



