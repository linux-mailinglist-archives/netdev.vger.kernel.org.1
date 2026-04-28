Return-Path: <netdev+bounces-281804-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UM5rGy6b8Gl3WAEAu9opvQ
	(envelope-from <netdev+bounces-281804-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:34:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E50E483D54
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 61554305060A
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DAB3FBEAA;
	Tue, 28 Apr 2026 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asPmjCR4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D4F3FB7EE;
	Tue, 28 Apr 2026 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777375248; cv=none; b=qSIfLNeMORSJIg1JNRT3rlbcIzaOQDs3EY/n1vT8+uI9NwfWBwtsAQ3PeBo/B9ucCdpIyluLUMRsN11aHDVUKYEAzOqBNKrYRDrERqpYBw7eKmmRfu1hZL9lVptVP6EoX4kejzDEq+CzQheQfDLIB8k0AmZdr4byMQSjNNRFp1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777375248; c=relaxed/simple;
	bh=KGFKAgwtRz2K/CMIbzYXDZhvuYsQPZQI/mpsU/tkeeA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d1RtQEqzhiM7PwjTiJDekNpRF66h50+SpDs/XpVpvjzjYNnnZ5lkvDbdDNepIPuJYq3siTGCgC+PfzmT3YrmCtGbRXrq71dGRRkBPfzJ+2dT6bQn7HJ5J+NfVdtOJj5UUL7IfREOdMzD/U5CS0Vn1vnNr6iM0kKYvGfScUV5RFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asPmjCR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04296C2BCAF;
	Tue, 28 Apr 2026 11:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777375248;
	bh=KGFKAgwtRz2K/CMIbzYXDZhvuYsQPZQI/mpsU/tkeeA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=asPmjCR4od7z0Ai4puGIBiWoLcVJPYAFcG+t5nLLW7egn97QELviIthENLmLO8vee
	 I8j2H1xfrCWzde4/KOnQ4NKK/lDAsw/AGDqTeq9SgMM1E2izG8jDflNkzXBe+3/0Wf
	 0bskO84RHfmGs2qcVR5ujo3yBmcFfgVcKEQOUDqvVEFpJtV3SGcZ1Zss62XiQk+QEn
	 6TB8TTC2DytrTPXlZ4iUi21QjyFRhMPf9pcgqfJlMjfCrwZ51caHNfeoNDoRpNbPCy
	 YKQCDXIGK9GVVFIz5iRhi8IMI4PqdpgszjIY1KnGqJzQizkT6Q9TdIeQ5MOXxUKY7O
	 cJlJN/4+EvL7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CC7393019D;
	Tue, 28 Apr 2026 11:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: mctp i2c: check length before marking flow
 active
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177737520480.421689.2467854297040801595.git-patchwork-notify@kernel.org>
Date: Tue, 28 Apr 2026 11:20:04 +0000
References: <20260423074741.201460-1-william@wkennington.com>
In-Reply-To: <20260423074741.201460-1-william@wkennington.com>
To: William A. Kennington III <william@wkennington.com>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 wsa@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 0E50E483D54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281804-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 23 Apr 2026 00:46:52 -0700 you wrote:
> Currently, mctp_i2c_get_tx_flow_state() is called before the packet length
> sanity check. This function marks a new flow as active in the MCTP core.
> 
> If the sanity check fails, mctp_i2c_xmit() returns early without calling
> mctp_i2c_lock_nest(). This results in a mismatched locking state: the
> flow is active, but the I2C bus lock was never acquired for it.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: mctp i2c: check length before marking flow active
    https://git.kernel.org/netdev/net/c/4ca07b9239bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



