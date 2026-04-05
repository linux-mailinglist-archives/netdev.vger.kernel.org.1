Return-Path: <netdev+bounces-275465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DCAKSuO0mmCYwcAu9opvQ
	(envelope-from <netdev+bounces-275465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 18:30:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2312739EFC2
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 18:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 010DA3005EBB
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 16:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A9A3101CE;
	Sun,  5 Apr 2026 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQuCdStp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D5C3081D7
	for <netdev@vger.kernel.org>; Sun,  5 Apr 2026 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775406633; cv=none; b=Fssu+pd8kQW1rXW/+9JDQkmIBTXfa1OrEwLoFjPQpuaXhFQv4ZmdGyldkhGdSfXTRqpvBBhu3MN1Wsgt8KjsOTfY3A2+ys/Dh8XSKHCRw1uuwu1M4IDBYqyTPHXs83P1+kT9wPBlCjcQ32c7XbB8LhM63bHbX4h/l8QPJUKyDMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775406633; c=relaxed/simple;
	bh=lBWMngCCUs5rKnqoAh6ZjPsAXejdhCHwH28wD0fw83A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KviINXVJtNDq+C0idxfCGHTS5ZrxDvkBSQRHZ6S6+A5bjnnY99x3yDZlv7Etwab8VaFJzCQzJE3AMTZ5ywwkToeH/snc08+5+YuX/xCFbi1WEqXk/wy0/g+4DuTwQUqLPW7fnHCT6T/QJ47EGG6ZT9uLMgUaP0/5jLJMMtUh8LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQuCdStp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD41C2BC9E;
	Sun,  5 Apr 2026 16:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775406632;
	bh=lBWMngCCUs5rKnqoAh6ZjPsAXejdhCHwH28wD0fw83A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uQuCdStpOboFzXBtfNBkXlFYb9rs8aGNoHNYx43d6svTJrB2U5DxCPo6clJw6FARi
	 0lErEYATrivK9w1duhef8CmKx80dVHEC0KEn0f7w54EAXKKXQGYye5cjs/y6eEjIgW
	 P6K8l/2eWjj/jb+tMdQQz4TS3OkztT225aF9DsXviqSIdjUvNvABBav/ehTAKyHToM
	 CLxR2WwDME53c0pcyfsSL+m68LglHypMI9zo2sS1uwE6Q0Z2i3Pnl/dYmcy92hufOl
	 bO4UQPFPXHrvIK6cA+RhKQFQKajzay7DyObsFhnlj3j4dCcbt+SgQlYCGZENhxR/82
	 nrPuhro+LRO2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE3E3809A22;
	Sun,  5 Apr 2026 16:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] dpll: add direction and state filtering for
 pin
 show
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177540661216.1987085.1275270670326202022.git-patchwork-notify@kernel.org>
Date: Sun, 05 Apr 2026 16:30:12 +0000
References: <20260331135918.49567-1-poros@redhat.com>
In-Reply-To: <20260331135918.49567-1-poros@redhat.com>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, stephen@networkplumber.org,
 ivecera@redhat.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275465-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 2312739EFC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue, 31 Mar 2026 15:59:18 +0200 you wrote:
> Allow filtering pins by direction (input/output) and state
> (connected/disconnected/selectable) in the pin show command.
> These filters match against parent-device nested attributes and
> can be combined with the parent-device filter to check a specific
> parent-device relationship.
> 
> Example: dpll pin show parent-device 0 direction input state connected
> Signed-off-by: Petr Oros <poros@redhat.com>
> 
> [...]

Here is the summary with links:
  - [iproute2-next] dpll: add direction and state filtering for pin show
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=90a9c94bdb79

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



