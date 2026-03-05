Return-Path: <netdev+bounces-264160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDEILx/yqGnDzQAAu9opvQ
	(envelope-from <netdev+bounces-264160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 04:01:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E7320A652
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 04:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB2EC30A5E91
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 03:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B551927603C;
	Thu,  5 Mar 2026 03:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T31YCYAS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90774233704;
	Thu,  5 Mar 2026 03:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772679620; cv=none; b=P2UDk1Uec1jSIEElbBc8ZGeBrTBtJegyDSVOWcpXzruSqiipNwbcIipexHpEhAMrFbgkqtKk3w4/EmrlU5+hoVV1cBQ5AZnM/uapFeerZ1A7kEn7UtW5WQw1dXz5Hirp9ylm/8iDlz2JzNl8Js0i05I36ySp4mnYfsucVNk3f4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772679620; c=relaxed/simple;
	bh=CIFARvST/HBl0kWjH/Q6WVPSLFyivKHDDwO9fUZ7lyM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oAG2PB6AQ5GzfUO4v3CjXWHenp2pTLEnV+xhpFdxaKzz9ANgloCej5tclf7laY8wxyqYLgVokV4Kr4gkLlF4scvH5JzBPCBX+VjwffN9SI3XBy+MxADTTCk8zcayS8Uvl58qoqTLpQqw9bBvkeBOHuFmFnaqKui41NuzRjHHvwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T31YCYAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA7AC2BC87;
	Thu,  5 Mar 2026 03:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772679620;
	bh=CIFARvST/HBl0kWjH/Q6WVPSLFyivKHDDwO9fUZ7lyM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T31YCYASGPJXDC4k7Kr0rJ+D0z+cNyXTmgaIjLUi17a8K2p36sMVpgVsIKllsOBwR
	 7fIvfApMh5Z9+3oXTo/yRgSg4sT+HVPU5PV1JgZR8dHE0wYbx07LXsWXBuR8uePhrk
	 vNTTw1LhmojNdw9GuZw55taOWBDfwjPSYmUD8DSAh7xoQh/XnUThnDj8WnhMaS5cEN
	 +hDyO0L04kNlofXEBkyHtuJlqA2fomc/+8ju8NSKYdtsL/cB0YsKNJ3DJeuSV8J662
	 dGEmRY66TlN87hLUnSIE5XdhcqTKZIzy9DG5GitpbC74LzOj4wB7JYE7WTGcUWu5fq
	 oChwc8RJ9FN/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C353808200;
	Thu,  5 Mar 2026 03:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: update the README
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177267962079.2494418.3670597460321692756.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 03:00:20 +0000
References: <20260303213626.2320308-1-kuba@kernel.org>
In-Reply-To: <20260303213626.2320308-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
X-Rspamd-Queue-Id: 16E7320A652
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264160-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Mar 2026 13:36:25 -0800 you wrote:
> I have added some instructions for driver authors on the NIPA wiki:
>   https://github.com/linux-netdev/nipa/wiki/Guidance-for-test-authors
> last year. Given the increasingly common use of LLMs let's add those
> in tree as well. Hopefully this will decrease the number of review
> comments we have to give to AI-assisted noobs.
> 
> While at it sync the overall instructions with what's on the GitHub
> as well.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: update the README
    https://git.kernel.org/netdev/net-next/c/d37f53822c4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



