Return-Path: <netdev+bounces-259522-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uERuNfpDl2kiwQIAu9opvQ
	(envelope-from <netdev+bounces-259522-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:10:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE92160F6E
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BCA6B301223F
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F382133D6FA;
	Thu, 19 Feb 2026 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4YmZzZC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F74148850;
	Thu, 19 Feb 2026 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521014; cv=none; b=Via4lf5ip/+XMy0hcBMbkKgtmjLbYO9I/pN6Iw/+cJffqqdHMjwsJA7pCC7w22C2gG9CV4dhJJbOGa/15r1gPGvlY3Sx9RWu6cu6p215xihyQJwB9Ro7/oxkEuTDNccJvmXxwzfI+ZQ7zE/Ckba9JY2rfjysGo0qdTujBu9/FGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521014; c=relaxed/simple;
	bh=4rWC649bPHWDwbAUy6fyZ7LfezATYtqNzYp84uIcB20=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fdmobf15S2xgQaE2sHEQNYi/5FP4CluKE1zbiEMqpRfAZnNef8F5pWY/ifPOf2K9HKgTDEr2DTd2OK1/cTkM1hCpNpnlPPCengad/64n4l9vwDN67mBItXjXPek/sbLgKJ81sem+c2xyfgbEyTW8qXw0XhHxkfcjbznrF2PJl4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4YmZzZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CE7C4CEF7;
	Thu, 19 Feb 2026 17:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771521014;
	bh=4rWC649bPHWDwbAUy6fyZ7LfezATYtqNzYp84uIcB20=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g4YmZzZCRSFVjObEPAdBYaA6NiPtulw4WVlNQSEY66Dti6oVEXIaZYG3+B6SfWaUw
	 JI8ilFC5GZZmri2Kc/NTQfVoE9gjAZR+qDh9aQTqZ9ko/kFSeWJv2mn3EYy+EZzrqn
	 npi8UpEjs3v50uinHoZ7RiEZTIZGFdLnA2eErYNoFcYVa2dDMsxWWmmOnjQxYxbsHK
	 B3wSpQBc+3E1xCMqKVRmlk3GeyMkjBreQzwMMn8B9AZgXPvnhRfWIJI8bevq3AXPVv
	 14tuQbh5aPZN/dDV1MIEtPEDUmL/i/AHPQoAoZYN6avFmP1FNKNU5Edqny6I+6SttY
	 vMuuJf92/zSoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 85263380CEF3;
	Thu, 19 Feb 2026 17:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] eth: fbnic: Advertise supported XDP features.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177152100533.2305599.11657483743425478987.git-patchwork-notify@kernel.org>
Date: Thu, 19 Feb 2026 17:10:05 +0000
References: <20260218030620.3329608-1-dimitri.daskalakis1@gmail.com>
In-Reply-To: <20260218030620.3329608-1-dimitri.daskalakis1@gmail.com>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: davem@davemloft.net, alexanderduyck@fb.com, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, mohsin.bashr@gmail.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259522-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,fb.com,kernel.org,google.com,redhat.com,lunn.ch,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,meta.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7EE92160F6E
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 17 Feb 2026 19:06:20 -0800 you wrote:
> Drivers are supposed to advertise the XDP features they support. This was
> missed while adding XDP support.
> 
> Before:
> $ ynl --family netdev --dump dev-get
> ...
>  {'ifindex': 3,
>   'xdp-features': set(),
>   'xdp-rx-metadata-features': set(),
>   'xsk-features': set()},
> ...
> 
> [...]

Here is the summary with links:
  - [net] eth: fbnic: Advertise supported XDP features.
    https://git.kernel.org/netdev/net/c/e977fcb3a318

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



