Return-Path: <netdev+bounces-282821-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOkABpJE82kMzAEAu9opvQ
	(envelope-from <netdev+bounces-282821-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:01:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F39BE4A282C
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19B693001A73
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB283FB074;
	Thu, 30 Apr 2026 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lL3BLbjX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3B83DA5A8
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777550451; cv=none; b=hB+Wu+3KjujbZwN3p/Z6T2CDgQ8vcRqA7G0WCMuFYDuFuT8/MaEKWe19ueChVfTfZReOlTuRZUeEUOwjxPUWZldPh0qml+mMY1ZVWi2mzSHqaaJn9MhszhisEG/QLqx70lxLeuZjKfTot+Ln1JCBHu7DtYnBNN4MzyxAoYq2cJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777550451; c=relaxed/simple;
	bh=RG9IEDOsBeOpwKtUb5eGNe+T0/r7yU4nK0ZncTHpdws=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CVZm725g0tGa7ScYYe/roVDlSWeBYJLvsztVf0tVmEz/ZkG6S4a1TzAUm7jzcPfyvTI9zEq2KDr/Vmg60S1otJ6Pwm6nAMwKkU/GwkJMUuCw2tLozu/ybYaOyacqWohhrQUjYS6+wdBArNXJHMlUbqBPwWMzgqoaJjVyaO7ptcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lL3BLbjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA9AC2BCB3;
	Thu, 30 Apr 2026 12:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777550450;
	bh=RG9IEDOsBeOpwKtUb5eGNe+T0/r7yU4nK0ZncTHpdws=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lL3BLbjXOPgJwoFQuibWARvNrXJlXGTclczv5fnV5rKvYHMGdClmF+jxPCLBSx/De
	 3y5LXG8fKqEHkcg5LSOwrQ4tCXXMWObpZkPjXX3fZc2Iuc38JZahl8tySFue8hDbqw
	 XshiItQvW6ZNr7vAjAdz1SRhtdCOfa3xrk9a6bnmi2P5htt5P6Z43rBegsv3yUD40s
	 BZ2bTMW0jMzHZxyNDvBx4W/FLPUWwoI1mUY73xWgQhQyk2yDp4VrzptnUZxFK6v8VH
	 xEaMdUdBwnHjZOIWiKBnkEBqyDkPIb8ZYAXnyy+e7ZKF6AZFa0nVjciAiuLqNYRIBY
	 5cYMyK5QmAr3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FA8380AA48;
	Thu, 30 Apr 2026 12:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: cls_flower: revert unintended changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177755040555.2971425.11109375477567832879.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 12:00:05 +0000
References: 
 <043026a53ff84da88b17648c4b0d17f0331749cb.1777447863.git.pabeni@redhat.com>
In-Reply-To: 
 <043026a53ff84da88b17648c4b0d17f0331749cb.1777447863.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 william@wkennington.com, jk@codeconstruct.com.au
X-Rspamd-Queue-Id: F39BE4A282C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-282821-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[codeconstruct.com.au:query timed out];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,codeconstruct.com.au:email]

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 29 Apr 2026 09:39:11 +0200 you wrote:
> While applying the blamed commit 4ca07b9239bd ("net: mctp i2c: check
> length before marking flow active"), I unintentionally included
> unrelated and unacceptable changes.
> 
> Revert them.
> 
> Fixes: 4ca07b9239bd ("net: mctp i2c: check length before marking flow active")
> Reported-by: Jeremy Kerr <jk@codeconstruct.com.au>
> Closes: https://lore.kernel.org/netdev/bd8704fe0bd53e278add5cde4873256656623e2e.camel@codeconstruct.com.au/
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net] net/sched: cls_flower: revert unintended changes
    https://git.kernel.org/netdev/net/c/1e01abec8565

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



