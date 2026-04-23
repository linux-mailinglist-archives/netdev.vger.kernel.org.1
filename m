Return-Path: <netdev+bounces-280597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNZNMrKi6WnafwIAu9opvQ
	(envelope-from <netdev+bounces-280597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 06:40:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2EC44CFE6
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 06:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9100D307EF07
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 04:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D09A314A79;
	Thu, 23 Apr 2026 04:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KycePIB6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE87F35957
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 04:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918650; cv=none; b=L8fgEJLfku+RSh7gS870ClZ7QZFnCiZooAlmZWJnvhq4nzLA0iOFIZATTFNVc4XwMXbrncrFsX+PSjkbxmyLjAvsCHs6UTlav3eBBgO379476yFTweHdJbB5u77MvlapSEMz24eVehEMpcAuXr+i7fKtE6dluQypdEjl5cAg6XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918650; c=relaxed/simple;
	bh=4NyDlqqxqz+E2io9iYbFcByU5IqGKyFhqmer2c98i+s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q5hl22VjZ8m7jq03H7I7jA6kNwodMe1kaxRypCcIbotpONgOFZ++3pa2sRXDlUFWei3WYxZ1agr6/v/zVZbcCBeoVOPzmJFIT8lRVCHEmSWa91JUaryRGH0XeY5FtuuoIjYUPynSasC1c9iQwYHDrJrHBaJFNWr+PYMFYRNvQc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KycePIB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19520C2BCB2;
	Thu, 23 Apr 2026 04:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776918649;
	bh=4NyDlqqxqz+E2io9iYbFcByU5IqGKyFhqmer2c98i+s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KycePIB68nu79kmCIm8xoQku4oIHH+6gNXpjyxBCV9bWNyuTo+BPk/0QS8qOVQXBT
	 A6Yhkd3zxSt0FVcST/3WpmP1DIHRqI0SbszVdMpuntJWK/EFJdYzIk7oZy/tLJ+9Is
	 bNlTSzWUpgKfsxwV09m3ASkq2HhfnjTX6+xJdrRvMSSAhd2gjYXrVVc3+9Y+VBmHu7
	 ul/v42Nu5UQkxB/cMJjxbGnIgSAlOWz1MZro0g721mtKSO//aZ1OrN29g3tw6+9gwP
	 lvKENUE0kU3BrNNigYMqPM/a6XDwd2cfrJsfPtwIMrtPTRNfzPTVzxMCz4UmmMpdp9
	 f6mJb39LD2fTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDC63809A86;
	Thu, 23 Apr 2026 04:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: sch_red: annotate data-races in
 red_dump_stats()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177691861105.4157517.1463150138385112453.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 04:30:11 +0000
References: <20260421142309.3964322-1-edumazet@google.com>
In-Reply-To: <20260421142309.3964322-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-280597-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A2EC44CFE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Apr 2026 14:23:09 +0000 you wrote:
> red_dump_stats() only runs with RTNL held,
> reading fields that can be changed in qdisc fast path.
> 
> Add READ_ONCE()/WRITE_ONCE() annotations.
> 
> Alternative would be to acquire the qdisc spinlock, but our long-term
> goal is to make qdisc dump operations lockless as much as we can.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: sch_red: annotate data-races in red_dump_stats()
    https://git.kernel.org/netdev/net/c/a8f5192809ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



