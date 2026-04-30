Return-Path: <netdev+bounces-282986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O2DN3HB82mw6gEAu9opvQ
	(envelope-from <netdev+bounces-282986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 22:54:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 410ED4A7F35
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 22:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F48F3002A06
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 20:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030EA377031;
	Thu, 30 Apr 2026 20:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzuADWQn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C6B35C1A0
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 20:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777582252; cv=none; b=IWT65UgtCfBPyhNi5KA/KPMj9fpqdFwaXzJVjNwl2EPzO3iFN7ECq+iIBkDQkIM3lliHL1b4MVhikK++/MutnA3qgYe2EfUcL8MC4AYtDRAwW05cUEv0cF6rgN3lJYlmko9G7xtVim9/EnZqv7b60/yMMuzNaH0Gsr4dnAyBpP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777582252; c=relaxed/simple;
	bh=CFgfpR9D5FEp93q+wOjAvPsmxavUw22WMhsnYPtT4Ms=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nh2vFmbU2SvzLgJqsVJHeyE9Bb4GPEos3gDG78yOTpDsAmfPRahQxZrFVNYP0lvXykWJfEq3CMoHH5dW5C94GrRv+mO1KTPJv2cAOk2fN4/Ug3kdmfnEAQxv7i0tOWqTQM3Jcpm9rCNqBw1qlnvlOaTmRE1ly1cxa0H5cPtAdCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzuADWQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737C1C2BCB3;
	Thu, 30 Apr 2026 20:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777582252;
	bh=CFgfpR9D5FEp93q+wOjAvPsmxavUw22WMhsnYPtT4Ms=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kzuADWQn3zoGqhLxtMCV8Q8Xe87zzXTF+/PbXUqa+Q4v3AGW+dNqRKgiBvSFjABQ8
	 kpCpBjh3AbPNHi4gYHb3GI2LPbGubIH/FBeAF3KYKJz7l9mK+JVghiFI/y82l9iuPj
	 4Xl0SOYfRtXHzU15kxKg/gmJ2L2Z+ckcId1vE2ci/+ZCrbONkZCIP3Ma/fv5ApafZH
	 XmoICNshS6D/NGb0tBPuOBv99Uf4uoQbvWYFwfbPm9nqe1wESJ53PLv7XApBHGTBwz
	 S+6dy41vGY6YRNC7fm+W+pfcL35TdBjpJAKBjPtqATd/bPxd5Uh50M1bdwKVF+O2yZ
	 m4aAclclpyfzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0317A380AA7D;
	Thu, 30 Apr 2026 20:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mctp: test: remove skb dumps from test
 output
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177758220580.3198946.7586606245510104457.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 20:50:05 +0000
References: 
 <20260429-dev-mctp-test-skb-dump-v1-1-13fd5789ef71@codeconstruct.com.au>
In-Reply-To: 
 <20260429-dev-mctp-test-skb-dump-v1-1-13fd5789ef71@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: matt@codeconstruct.com.au, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
X-Rspamd-Queue-Id: 410ED4A7F35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-282986-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,codeconstruct.com.au:email]

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Apr 2026 16:27:31 +0800 you wrote:
> We're currently dumping skb info in our fragment input test, which makes
> interpreting the TAP test output a bit awkward.
> 
> Remove the skb dumps.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> 
> [...]

Here is the summary with links:
  - [net-next] net: mctp: test: remove skb dumps from test output
    https://git.kernel.org/netdev/net-next/c/8ca4bff2ff3e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



