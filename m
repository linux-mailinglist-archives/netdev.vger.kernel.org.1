Return-Path: <netdev+bounces-280831-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMpdIiRi6mmrygIAu9opvQ
	(envelope-from <netdev+bounces-280831-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 20:17:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A93455FC0
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 20:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5723D30B302D
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EF83AC0CE;
	Thu, 23 Apr 2026 18:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eC6iXVmT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B883AC0C6
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 18:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776967855; cv=none; b=t9TtR0IGwq99dJa92AtUiysqbsS/ibv07lyYsdjXPy9T3/GqP18kZtERWQYc9+uCiFxkuQ4Hvftgw2eKZ1og/KeVJDrtQwcKqYOKR5IFYItCfXeBXUEQcrEq1GGL5OJoPZb/NRUWxpG53L6zW3HrmhjcQio6pubOONUJH+9epf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776967855; c=relaxed/simple;
	bh=0/LCGq1kO8z8IA3b9q4vj3tLww4ivIaxVZvrT4DPYUw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QYvD9a4g8dxnH3/9euy/jiyvtEzuVwn7yl5aAiQIsSuLzW6Ut74V/4dkQDNfPwWPNdOxaJnFnG+x7l0q7YkNLQtM5JU+qAk3lhS8Fye67gyqUxrp0CZdTNUfuB5vnHQ/mzriqo5gH4JknEIvxVT3CLwO7aZcmEJPk+72Je1zWQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eC6iXVmT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A435C2BCAF;
	Thu, 23 Apr 2026 18:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776967855;
	bh=0/LCGq1kO8z8IA3b9q4vj3tLww4ivIaxVZvrT4DPYUw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eC6iXVmT7gdEeJXdDKm6VjPmYVsRH8AQ212g7QSntASIyH57fvDGhk80L3w1DDgp0
	 DfNNtvVHvtEO8POb72S60K9NXrMiVh2CujybZbMqEGDZoUss/oGRJc0CoN9ULi24nS
	 YoMnWv6o4Jn1hj+Qy8HWx/iYWSg/AQtIy32z6T0OErhT+bip68+aRhccqc6i1zQm1Z
	 V1ZiETRixZBP1JF5atic8e1gQbmdAxeEaZgKi9uChkMvrqq0doXQf4a8iRsw5kEIgf
	 Y41E8rHGAS0Gk33pLlB45rcPBo43Dknvsd3SKnFXuKTU/VVrUYR9vLpW2z8ZmNNDaz
	 tKEBWLV+SmwjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E7A38111D6;
	Thu, 23 Apr 2026 18:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] nfp: fix swapped arguments in
 nfp_encode_basic_qdr()
 calls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177696781629.700507.12737092787538195809.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 18:10:16 +0000
References: <20260422160536.61855-1-aleksei.kodanev@bell-sw.com>
In-Reply-To: <20260422160536.61855-1-aleksei.kodanev@bell-sw.com>
To: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, horms@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, oss-drivers@corigine.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280831-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6A93455FC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Apr 2026 16:05:36 +0000 you wrote:
> There is a mismatch between the passed arguments and the actual
> nfp_encode_basic_qdr() function parameter names:
> 
>   static int nfp_encode_basic_qdr(u64 addr, int dest_island, int cpp_tgt,
>                                   int mode, bool addr40, int isld1,
>                                   int isld0)
>   {
>       ...
> 
> [...]

Here is the summary with links:
  - [net,v2] nfp: fix swapped arguments in nfp_encode_basic_qdr() calls
    https://git.kernel.org/netdev/net/c/4078c5611d75

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



