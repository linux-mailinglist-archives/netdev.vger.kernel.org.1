Return-Path: <netdev+bounces-289461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLjkMe1kDGpXggUAu9opvQ
	(envelope-from <netdev+bounces-289461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:26:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 671B557F972
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF11C3078C0E
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867C73ED3AF;
	Tue, 19 May 2026 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eh7Y7WkF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624263ED3A2;
	Tue, 19 May 2026 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779196794; cv=none; b=AjIkJl55ws7367iJU0hesJZNwAaRnZ8K7IEZq/leB3EByD4RT7hCC1UfJUuv8nI6U7eT95FWfBnNB+Ng5sEZirtptU2jARpz81gnicFGNO+fAHpUNhE40/YzqiQdqit2iqhYHv+zNQ3LyOzVWWb7pcomY9poZYIH7FRFBQB80Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779196794; c=relaxed/simple;
	bh=42ZcZHg+/AYdTC7WkCun1qAZBKWnCha/MqxzfNUUHGY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W7SZjxHjQqaTxtP+ZUjt6l68d+wsjMQMHRJdzaMUGEhPc9uIBYC05xYPxSJUgokB1hkaPB6IPhHF+GcJ50YA97DyXt5PfeCZCMKcBxchljMxGNuttWwqLzSlsknYkw8EpolguzFRQduxrHKC+ETb5V0QKyRmdx5PvX25qF/QNVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eh7Y7WkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7ABC2BCC6;
	Tue, 19 May 2026 13:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779196794;
	bh=42ZcZHg+/AYdTC7WkCun1qAZBKWnCha/MqxzfNUUHGY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eh7Y7WkFEb7cKE5WPwRjgxCBOyjBBuEpFezopa6KjHKkgs7uAgAGQUbR1qL+Qlt4r
	 pmmQZd1fCxh8aQ/U5GRBLxJ8ieOVIYGaN14LMTlrbva6ekM5RVeECYQ7hcyLAxo1BC
	 tP7nm5okc9Y9egARsC5Vjj0Wi0xQZggEtLYQ7z68RVw0PN3/7Gl78EEJWX9BSSFTFh
	 nwJoYbEnu94jHztMLQr4wzOggfUer6SagYDLOhvfQZuMxHxuNKnzwjEgBc1glwF5k/
	 6Z7T3WrJMKPfmP42A5y+6HHSM3CqcAF2fo068N27ebtRsO1AY0VpCPeFh4BB217G+b
	 2E3mSJchnIyTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 797873930E1C;
	Tue, 19 May 2026 13:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v2] net/ethtool: drop duplicate TSCONFIG HWTSTAMP
 BUILD_BUG_ON from SET handler
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177919680536.2712297.15218921155790711948.git-patchwork-notify@kernel.org>
Date: Tue, 19 May 2026 13:20:05 +0000
References: <20260515032550.138572-1-zhaochenguang@kylinos.cn>
In-Reply-To: <20260515032550.138572-1-zhaochenguang@kylinos.cn>
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289461-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 671B557F972
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 15 May 2026 11:25:50 +0800 you wrote:
> BUILD_BUG_ON() is evaluated at compile time. The same three checks
> for __HWTSTAMP_TX_CNT, __HWTSTAMP_FILTER_CNT and __HWTSTAMP_FLAG_CNT
> are already present earlier in this file (tsconfig_reply_size()).
> Repeating them at the start of ethnl_set_tsconfig() does not
> strengthen the guarantee; remove the redundant block there and
> keep a single occurrence.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net/ethtool: drop duplicate TSCONFIG HWTSTAMP BUILD_BUG_ON from SET handler
    https://git.kernel.org/netdev/net-next/c/794cd1c77f53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



