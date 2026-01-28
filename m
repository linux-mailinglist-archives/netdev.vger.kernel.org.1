Return-Path: <netdev+bounces-254063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNGyF0FweWmIxAEAu9opvQ
	(envelope-from <netdev+bounces-254063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:11:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13ECA9C2BE
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0323A30488DA
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FBA2882B4;
	Wed, 28 Jan 2026 02:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsI3heEO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B07287506;
	Wed, 28 Jan 2026 02:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769566215; cv=none; b=lAWgphcrvNY/VyLdyiQ0NVUI+Gy4iO1XHpNaxqALLVkw0qMBhIn8eYdgQs0sxhCF4yOW6AkdN058Zi1UPQeGnYIDWU8YkXX4dGCqcNtHCl1FR3VGEwd8CKU4DNa1bYG5XgMoa5UDLS4BJHoL+QLiyHFg0zjaGXWSBJ7utmgklZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769566215; c=relaxed/simple;
	bh=dTBjPkn5O5q/ETZPhlMmdldzzfdl4D5Bk3eAKkmspY0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ALK1qahMgcf2H49FPhBtUcRd51SISLhB3hwVmLEwQdoh3Z5mgJhQmBhuX99FuuRWy17L5QGZGzXXnGC67hhhmpdfqRs5rl7BL3GTYYM1sryGCczR1JlagzW/tjHuBQBd8Fj3ItOwLv81fIrv7z/VwBJ1Wx3yw07NKa/109f5nvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsI3heEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A36EC19425;
	Wed, 28 Jan 2026 02:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769566215;
	bh=dTBjPkn5O5q/ETZPhlMmdldzzfdl4D5Bk3eAKkmspY0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WsI3heEOCavHzRffJMJgX6qRKoDBGNPyJZGlGN1/rKfL36XImDpjfkY7S1+fs/GeS
	 ie2ksHsE9Tx20Zv/UPubJd+fx1uvAofJw6BZKqlpQKA+Gd58jaw5K79gMHvlkDgtXC
	 Y2h5ITm0cz06w+OvxIjdMbMjwES3IoTGJHaIF5nfGdanPNJ9FW9/tdWk44vDAYj32I
	 Hy7+jjx2K4x5n9UNUZPdI2SeAiwSCFfw+EauvGAplIeeYe7K4fFxo+9Dxwm9Rh92ix
	 snahaCQwYebXvTTRBrL9Vfcs8IaYvIVRPYfNKgc3V8Dvuwx+AiBRI1WHQZVLVuFVpx
	 ONbmgfXdWEs2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1194C380AA76;
	Wed, 28 Jan 2026 02:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] selftests: ptp: use KSFT_SKIP exit code for skip
 scenarios
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176956620884.1477771.11915691910625079904.git-patchwork-notify@kernel.org>
Date: Wed, 28 Jan 2026 02:10:08 +0000
References: <20260126061532.12532-1-junjie.cao@intel.com>
In-Reply-To: <20260126061532.12532-1-junjie.cao@intel.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: shuah@kernel.org, richardcochran@gmail.com,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254063-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13ECA9C2BE
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Jan 2026 14:15:31 +0800 you wrote:
> The kselftest framework defines KSFT_SKIP=4 as the standard exit code
> for skipped tests. However, phc.sh currently uses a mix of 'exit 0' and
> 'exit 1' to indicate skip conditions, which can confuse test harnesses
> and CI systems.
> 
> This patch introduces ksft_skip=4 variable and unifies all skip exit
> paths to use 'exit $ksft_skip', consistent with other selftests like
> net/lib.sh and net/fib_nexthops.sh.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] selftests: ptp: use KSFT_SKIP exit code for skip scenarios
    https://git.kernel.org/netdev/net-next/c/166e664e702e
  - [v2,2/2] selftests: ptp: treat unsupported PHC operations as skip
    https://git.kernel.org/netdev/net-next/c/239f09e258b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



