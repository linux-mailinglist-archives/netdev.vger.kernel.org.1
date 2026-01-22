Return-Path: <netdev+bounces-252155-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GchLROWcWngJgAAu9opvQ
	(envelope-from <netdev+bounces-252155-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:14:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA26613A5
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A19AB4A60DC
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D4C3D333B;
	Thu, 22 Jan 2026 03:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltkk0MlY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E883ACA60;
	Thu, 22 Jan 2026 03:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769051415; cv=none; b=pnjt8n39Hol98zB3HwPAf6mPA/ypBTqqGwGajcLkZvdB4HhauwaRWzKoWscnUfh2Djh+eYE+lotiFYZf3zSHWKqGJfxXunu8mNxYWEdLZvuxAqYfOwY1YfG1Cb9ReCAvc5n2/SQTCMhYpL6c1bHVqeiBpKjQ6D1EXi4fN8HRRi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769051415; c=relaxed/simple;
	bh=J01YD7KY4hnSzkWASrXaPhKp7sXQ0SZRpOToFM6BZTQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pgdvmDGum9HMSNrXcZLdbBguLJxmNywmgznK3kO0rV39dlCdY9DAfXRqqvJn98wyImYUBiUsAnDFBl5LC68w1T+Jm1pU+ihZ7jrTL2wDN70Gb9hs80f48aOgxczNdCR0NMJJTJuIosj0NeKmtw5cG/Qu9s4anOlUwe3b7o6QPS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltkk0MlY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87470C4CEF1;
	Thu, 22 Jan 2026 03:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769051414;
	bh=J01YD7KY4hnSzkWASrXaPhKp7sXQ0SZRpOToFM6BZTQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ltkk0MlYULFeKPZ0mpoxSKmkKNrFk6A8toF5w5F+1bZWey+fAGhLgz0y5f0xFvmva
	 /y8+KQOcEl8pXKrNOF2KzJAWx08qGLkMAsfodsr0QrpYWmAndC7um3S7VKPohMm6dI
	 qExtrGp2m54+QvR1/7sP9DPbMUsyyMGBQsT1Haxv5X4cgJK8SgV0nyMU7Km9Nn8jI7
	 MB20kt1vkg4w9vr9j7q2VMuidHACzPBUaqutYAIEzsfgSmZD1Qa/nyL2/wDvKSPRkw
	 zyrZAqDzcFWKOUjOvCrKMDdFKxwckb+cnnVY6XYnKH7/T88kRdbGn3VpCsCikL4CCx
	 2YS+jLtT6VjyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8C0623808200;
	Thu, 22 Jan 2026 03:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V3 0/2] Add devm_clk_bulk_get_optional_enable() helper and
 use
 in AXI Ethernet driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176905141134.1535278.5816404258279074051.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 03:10:11 +0000
References: <20260116192725.972966-1-suraj.gupta2@amd.com>
In-Reply-To: <20260116192725.972966-1-suraj.gupta2@amd.com>
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, radhey.shyam.pandey@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
 sean.anderson@linux.dev, linux@armlinux.org.uk, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bmasney@redhat.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-252155-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 5BA26613A5
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 17 Jan 2026 00:57:22 +0530 you wrote:
> This patch series introduces a new managed clock framework helper function
> and demonstrates its usage in AXI ethernet driver.
> 
> Device drivers frequently need to get optional bulk clocks, prepare them,
> and enable them during probe, while ensuring automatic cleanup on device
> unbind. Currently, this requires three separate operations with manual
> cleanup handling.
> 
> [...]

Here is the summary with links:
  - [V3,1/2] clk: Add devm_clk_bulk_get_optional_enable() helper
    https://git.kernel.org/netdev/net-next/c/820ce0c8e98a
  - [V3,2/2] net: xilinx: axienet: Use devres for resource management in probe path
    https://git.kernel.org/netdev/net-next/c/808d077f5b53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



