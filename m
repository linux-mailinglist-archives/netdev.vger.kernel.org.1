Return-Path: <netdev+bounces-277605-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC4vF4B82WmJqAgAu9opvQ
	(envelope-from <netdev+bounces-277605-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 00:41:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C15583DD47E
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 00:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7FB23039DBB
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 22:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05673E0C7E;
	Fri, 10 Apr 2026 22:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFL4VLPp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4713E0C69;
	Fri, 10 Apr 2026 22:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775860861; cv=none; b=UGgBQnblCOQfsVHycXarL5F4D+smHrCZl+gn31L5cu7H18ywTl6DaE6IF8hZXPnV/ecDcV0kJn++8wXK4JvcUUvpZu7dXjLI/kDsXNSETZxlKKypQlmfjU/Dn/n70ggp4xIWXOH+0QGJp5Qn9ybfoa7Rm3uHvnSVb7KiJ5SkQ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775860861; c=relaxed/simple;
	bh=aIGzIaRL80ycn6DIDQoQBN+qIuaLMvNA3XN2zlYbL44=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XPy4ATSbLvwV5cDiMv0ebfIo9Ku698Cll2EFhtNPfKgs2SDb2Qg0VW0LYDnaQe5d4ehf9y73kf8qjG5mVMKskFWaY1GokJTsv1a3jcZvLC+7tebN9de/b6siNaLMkYDqp/N6T0H07wRTdnhX+wC2QROV0Qutsgbx+cpYvrAnM7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFL4VLPp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD9BC19421;
	Fri, 10 Apr 2026 22:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775860861;
	bh=aIGzIaRL80ycn6DIDQoQBN+qIuaLMvNA3XN2zlYbL44=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XFL4VLPpr5fbzpjWGXENqia1JwgF+o6VIJ+xsjlcxyDgdUSQp+HbpmTMO8r3Glpv2
	 3Rt1yihcqnbiedAWv2EvyvEtIoEFjU/JH0WYHkL0MM7+UkLbGLW4yW9OQORIGKu+fB
	 25U+gP5ERboYXRPe/g2HBp5mBOM7Xk8mlUPtz1HOG3rFhkhgKPFPY5fhi5yT9wjT+h
	 Twl0nyKSzB9Hh1R43OE8LMvpimpQ+AeUWtBYFCYsPQEfH0f+mqUiSER8AZKCjqxMR2
	 +7wYmMclnzBBVbMWOUd2FsSTNAJP1rLhhK2Dzmcd/m1D52f73/koHcDSFfNmBbtEvp
	 cmJMIh0kDYNZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D673809A88;
	Fri, 10 Apr 2026 22:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] Add selftests for ntuple (NFC) rules
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177586083553.2670415.5524532409783816468.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 22:40:35 +0000
References: <20260407164954.2977820-1-dimitri.daskalakis1@gmail.com>
In-Reply-To: <20260407164954.2977820-1-dimitri.daskalakis1@gmail.com>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, willemb@google.com,
 petrm@nvidia.com, dw@davidwei.uk, carges@cloudflare.com, cjubran@nvidia.com,
 daskald@meta.com, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277605-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email]
X-Rspamd-Queue-Id: C15583DD47E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 Apr 2026 09:49:52 -0700 you wrote:
> From: Dimitri Daskalakis <daskald@meta.com>
> 
> Thoroughly testing a device's NFC implementation can be tedious. The more
> features a device supports, the more combinations to validate.
> 
> This series aims to ease that burden, validating the most common NFC rule
> combinations.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] selftests: drv-net: Add ntuple (NFC) flow steering test
    https://git.kernel.org/netdev/net-next/c/18589df9344c
  - [net-next,2/2] selftests: drv-net: ntuple: Add dst-ip, src-port, dst-port fields
    https://git.kernel.org/netdev/net-next/c/a66374a3eb02

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



