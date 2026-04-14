Return-Path: <netdev+bounces-278525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEUNIsli3mlqDgAAu9opvQ
	(envelope-from <netdev+bounces-278525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:52:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFE33FC2A7
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E95C930298C8
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EBC3ED11C;
	Tue, 14 Apr 2026 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7L1R1dO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A963ED118
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181840; cv=none; b=uFYE5kGoc3/8RasRT0a0NdxMBetm0l2TKUKdBpNAf8kVeLY9RvCm7Xx3HeT7GPLvY9JeZaFiojxUiuqgVVlPI8Byap9CD193S59ywkl0Lbvvc4vmZSMyFlyPM38uTszbYlsOXRdT1Dj5f1JFaxva7i18zDMAZjbI3sp1P7RERVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181840; c=relaxed/simple;
	bh=xFTSK6+Cltdgnow3Z2DaeJZdd2h3JmVzxg0j3t3MWS8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BLpuV3Isq/8kbvGUIbqk5R/GEuHwEBABYidjvxCo2mxBUD4YpeKsx+CSwsU0/gLWvWLzE5ItdG79bGcf+6MJDADqCaVB8eS6PjsqRJ3wX9Uy3GOV0CR6eScAbuhk5PDdYFKodd3qfKM1UEazzFVpNJb7qyHkxRzOCHolofltQPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7L1R1dO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02188C19425;
	Tue, 14 Apr 2026 15:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776181840;
	bh=xFTSK6+Cltdgnow3Z2DaeJZdd2h3JmVzxg0j3t3MWS8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T7L1R1dOjzR68j1G08OmwXRbMTJsvDjX8pM7FhBlcmSK2qjOiOy4FzSLDGWcVqYeY
	 nBoB7UB9QKOrl/Ioba9maPx872MvriIfvJa4DPtAO9rQIGKZ1vS0EuKq8hVBm1ngBF
	 iSFxQl52Lbohl0cL8WTANXjJFIZtzeVqKhb9kJEmGBROzpHA4cSc+CccgaNDo7Sf8K
	 LNd2wqfqRyX3JdyfCAbJz6SqMksl/ePz8I5UtQEWh99RtMiJ8bWaQj8RC+H17Zki41
	 GBWWG9RVR4cmSHuXJs3cP3zZkZVq0UnlMZKE1cXwIc3EtZFZHLUmeWJ8dHsAziFQkC
	 MpMSz02GND+6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9D703809A06;
	Tue, 14 Apr 2026 15:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: Add netkit selftest files
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177618181055.1350742.14553442162453167616.git-patchwork-notify@kernel.org>
Date: Tue, 14 Apr 2026 15:50:10 +0000
References: <20260414075249.611608-1-daniel@iogearbox.net>
In-Reply-To: <20260414075249.611608-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, dw@davidwei.uk,
 pabeni@redhat.com, razor@blackwall.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278525-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8DFE33FC2A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Apr 2026 09:52:49 +0200 you wrote:
> The following selftest files are related to netkit and should have
> netkit folks in Cc for review:
> 
>   - tools/testing/selftests/bpf/prog_tests/tc_netkit.c
>   - tools/testing/selftests/drivers/net/hw/nk_qlease.py
>   - tools/testing/selftests/net/nk_qlease.py
> 
> [...]

Here is the summary with links:
  - [net-next] MAINTAINERS: Add netkit selftest files
    https://git.kernel.org/netdev/net-next/c/bc28831d7a09

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



