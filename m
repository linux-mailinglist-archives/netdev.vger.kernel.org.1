Return-Path: <netdev+bounces-286314-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1Z9xNA6nAGpyLQEAu9opvQ
	(envelope-from <netdev+bounces-286314-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:41:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFFC504E16
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 731C73003363
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 15:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD22C39E6F0;
	Sun, 10 May 2026 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgE4Hygu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9870A34F462;
	Sun, 10 May 2026 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778427658; cv=none; b=nM5PWqBr0nTX9sVF/q1XN3I1OcJy+Su7TwBWM8OcAEBY08OsNI5ykWthdtxxvrWzZ0bGPW9bb/+wRrPPEOCbiel3+8BTsivEBjCyV2n7TmqvDamDaJWG6sYNMLlmjqRshqF2E5QaxNCrq1/xpnbyNSAArbuRLD3Tl+oprtmFH6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778427658; c=relaxed/simple;
	bh=3Ba8nArUkc0rBMDbyaLb2FOKzCKhhBn99SZYorKgm0M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QCoHDz9K68yvry8IMzSGTUd82xt+Te0s9Lv88nI7C7JEpZkGXtyn00R1PUvc48P80W68Xl9UoKMO1+HmY4hvYj4/2VksmtPzJG4skTj/qtQAY3wV4SG0otozTIfTF5qbVSL6qEofljZriD+uJW6of+X9f4zuM5gNPQ7A6byU3NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgE4Hygu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1B2C2BCB8;
	Sun, 10 May 2026 15:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778427658;
	bh=3Ba8nArUkc0rBMDbyaLb2FOKzCKhhBn99SZYorKgm0M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BgE4HyguHWSHaX8tbbPBbye1gpNmar864hDPP20vyS7EEGLbbazwvUS66diNdRGTm
	 KWuhoONHCwp/9uKOVcXm9ZYSHa6rB/Br6o4wT17iQAPjFCenjXr76LgTnDWHFNCo0p
	 6rz0WMWHmLCCixJrj6JZoxVNikvHx00pS84+Tkh8K7TsL9cU81yp0RzilnLEH02Km2
	 qzxSm8YbEQblUFV+ahuNxlKTjWQGyXRcQIBxuUKA+iQ05YDHmxcMUW2Dl/NGGlw+5h
	 7CDwju6oOIxDByJ4deMA42JuyJ58EvVh5MK4qpJ4QAno0RONK44lwb+YyfsBS9NwtC
	 fSJ1onv7gzpag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DDB393001B;
	Sun, 10 May 2026 15:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] tools/ynl: add missing uapi header deps in
 Makefile.deps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177842760554.1414591.3890317509091929731.git-patchwork-notify@kernel.org>
Date: Sun, 10 May 2026 15:40:05 +0000
References: <20260508204114.205896-1-sdf@fomichev.me>
In-Reply-To: <20260508204114.205896-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, donald.hunter@gmail.com,
 horms@kernel.org, sdf@fomichev.me, linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 6BFFC504E16
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,fomichev.me];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286314-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  8 May 2026 13:41:12 -0700 you wrote:
> When syncing ynl-cpp to net-next v7.0-rc3, typelimits.h (for ethtool) and
> dev_energymodel.h had to be manually hacked into the downstream
> Makefile.deps:
> 
>   https://github.com/linux-netdev/ynl-cpp/pull/16/changes/94bd9656423cab7dfce73dc824f75b59ef25668d
> 
> Fix the upstream Makefile.deps so that downstream copies stay in sync.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] tools/ynl: add missing uapi header deps in Makefile.deps
    https://git.kernel.org/netdev/net/c/46e9b0224475
  - [net-next,2/2] tools/ynl: add check-deps target to verify Makefile.deps completeness
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



