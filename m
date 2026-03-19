Return-Path: <netdev+bounces-269380-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEcuL4XIu2leoQIAu9opvQ
	(envelope-from <netdev+bounces-269380-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 10:57:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D26642C924C
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 10:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 04B8E30AD5A3
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F3034AAE2;
	Thu, 19 Mar 2026 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4tiAHSV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609CD2E8E16;
	Thu, 19 Mar 2026 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773912622; cv=none; b=M7QwlGnHsYPG9ynkoVG5bCa96u8Plslsp/zwbGRefM1z+zQjuI9kBYJ65Alcpx5vLfex/yB5uRLrdc2VKi5eljzaDRH5f5oI7gHSwoYQpNYVi14GfY2JqapMmrTW8M64/2z15O1S6UhOi3w4gMnORdBtdCIcT4UiZn1yHVSqW4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773912622; c=relaxed/simple;
	bh=g5EM4pX9cYmpw2XboZ/HmxQq/VtdJvm/30bzyVmZW18=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZaxGpQTaIObR37c/ofNzNJ/YffW16+D4lQ9SAqYktSBv45XT+IIWHjaiXjVmYVOinQVSTunFTzk3S7W9xBv9HV/lsgSyBWZXyO+QPhNr2iUMLwxjDr1w14fVLdzMNs3qgaqulIsU+zEKVudInfFlyiRJrElyAW9nUwo6XvCGAWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4tiAHSV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF33C19424;
	Thu, 19 Mar 2026 09:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773912622;
	bh=g5EM4pX9cYmpw2XboZ/HmxQq/VtdJvm/30bzyVmZW18=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S4tiAHSVczUMZbwvYfsDOOcsj/4OltTS4CLc+ckNSEoC6vJk6c1skyVt6xg4A0QCb
	 N8x0zfqXKr0QdmMWPuFhLxTIi0IPdm5G9g49WBlacHnF0gPtFQZVvUZIn02hI836Ql
	 2pFeXbxYSDEAstt6zX19hFI1016lq++pzMegg729Le6+020FwDtl/cwT+j5GLu9dgd
	 x7dYY4FpKLvLsUOKugedSjBVivdRE1z/29aKF3JplV2bFvLHIEoxHW8z5KkjGWaHE2
	 SPv2f4NNU5fvyXUyl2Qave2TBOe/1oCezmjSCr1ljIe68rTavn6Joj6Mn63ayvlVip
	 XiVaAgC2EaLMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0293808200;
	Thu, 19 Mar 2026 09:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests/net: packetdrill: improve
 tcp_rcv_neg_window.pkt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177391261329.1113925.12303763027691478280.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 09:30:13 +0000
References: 
 <20260316-improve_tcp_neg_usable_wnd_test-v1-1-f16d5e365107@gmail.com>
In-Reply-To: 
 <20260316-improve_tcp_neg_usable_wnd_test-v1-1-f16d5e365107@gmail.com>
To: Simon Baatz <gmbnomis@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-269380-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D26642C924C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 16 Mar 2026 19:51:10 +0100 you wrote:
> From: Simon Baatz <gmbnomis@gmail.com>
> 
> The test depends on accepting a packet that is larger than the
> advertised window and that does not trigger an immediate ACK.
> 
> Previously, the test might still pass even if kernel behavior changed
> unexpectedly. Add assertions verifying that the large packet was
> accepted and no ACK was sent.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests/net: packetdrill: improve tcp_rcv_neg_window.pkt
    https://git.kernel.org/netdev/net-next/c/96a584db75bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



