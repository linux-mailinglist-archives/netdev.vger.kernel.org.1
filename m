Return-Path: <netdev+bounces-277220-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDp4CJZq2GkhdAgAu9opvQ
	(envelope-from <netdev+bounces-277220-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:12:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4AF3D1C22
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE97B3009391
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 03:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C522F4A14;
	Fri, 10 Apr 2026 03:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKvmwDqv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE27175A75;
	Fri, 10 Apr 2026 03:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775790636; cv=none; b=gHM4PEp4BNt0mjKlMSJQ1Q2nd9vB5WpIBmt2RZgFZreBfvJB1OdXj6MSnDFAT4LcYJfeNt2t/XGqh6Nfi5M+0l5zdyT+wPp+XtzsJLqSqrU3NOG84w2NaIfCvEaWfhAjHXsuN6KVDawBmS8VztZ5crQuBX43/n7jZtHYtX4oFjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775790636; c=relaxed/simple;
	bh=4j2eh4mER1CzK18+0czj/YEhVEMELQyD7wyOSgyhEOE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UUEDQyoBkEdKvwge83F8yIeYMKf2g4dN4gUlx2Jq1DpcAHsB5T9mtTZNvMQpTbuDcLWnrJ5M4qpDlM91YcEAqTrG9oTsoRXaImNOv0zNxnzQms+BvFYm+wGGG9bf7qapThWfR4AzJvI/5I5IWo7MKNe+9wZDLom8IbSTlRJO5ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKvmwDqv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0D0C4CEF7;
	Fri, 10 Apr 2026 03:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775790636;
	bh=4j2eh4mER1CzK18+0czj/YEhVEMELQyD7wyOSgyhEOE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kKvmwDqvDHnuKb5vFuZQDbZlGDueKqx69jc/Tu9krEn3Vd0uIUfeYRCnko7LdB0B7
	 ngh3CHtxa2/t8LhOvgahnX9mxahp2/YN+99wZU0yBHblS2YVzGif5zVOMWcC4cfP+C
	 2hgqrYUGnFIFyLQAaXUKOKbqmfAE7SVLTofpBsao7ApNwfrLU2dd7+aKiquB5WLPxD
	 2BwAb81H74sC0zcPviPAz5yRTU7Iz6Ir2/2HPYG2+Dii5jvNN5aZU/qrJnQ2k2sN1e
	 OpE74XfvtIgHos2cDVmX0fN7aIUxCV93dfFcq+rfBuQ5IZb4latSRfxMtBvn55DDcr
	 uV4mNTvNh1j7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE593809A22;
	Fri, 10 Apr 2026 03:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v8 0/4] macsec: Add support for VLAN filtering in
 offload
 mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177579061105.1844106.11250785795431819587.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 03:10:11 +0000
References: <20260408115240.1636047-1-cratiu@nvidia.com>
In-Reply-To: <20260408115240.1636047-1-cratiu@nvidia.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, sd@queasysnail.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, sdf@fomichev.me, dw@davidwei.uk, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, dtatulea@nvidia.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277220-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D4AF3D1C22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 8 Apr 2026 14:52:36 +0300 you wrote:
> This short series adds support for VLANs in MACsec devices when offload
> mode is enabled. This allows VLAN netdevs on top of MACsec netdevs to
> function, which accidentally used to be the case in the past, but was
> broken. This series adds back proper support.
> 
> As part of this, the existing nsim-only MACsec offload tests were
> translated to Python so they can run against real HW and new
> traffic-based tests were added for VLAN filter propagation, since
> there's currently no uAPI to check VLAN filters.
> 
> [...]

Here is the summary with links:
  - [net,v8,1/4] selftests: Migrate nsim-only MACsec tests to Python
    https://git.kernel.org/netdev/net/c/e1ab601bb230
  - [net,v8,2/4] nsim: Add support for VLAN filters
    https://git.kernel.org/netdev/net/c/c89f194b6b8e
  - [net,v8,3/4] selftests: Add MACsec VLAN propagation traffic test
    https://git.kernel.org/netdev/net/c/26555673bc78
  - [net,v8,4/4] macsec: Support VLAN-filtering lower devices
    https://git.kernel.org/netdev/net/c/a363b1c8be87

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



