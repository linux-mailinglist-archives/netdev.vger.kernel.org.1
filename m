Return-Path: <netdev+bounces-277830-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBbECozG22lHGgkAu9opvQ
	(envelope-from <netdev+bounces-277830-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:21:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 907F03E4BCE
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDA72301477A
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 16:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003092FA0DF;
	Sun, 12 Apr 2026 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RohSaMcB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FF52F5468
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776010847; cv=none; b=CrIEgKZjybH7NN1rRMcr3ZH3oaMgpB36MaQsB34wkPUpYuDey+KJMJUz0EUgp0kfnbw4GYbtFuQEFZDXTU5n1OoUDg8hIQT2DpfytJOYtfhalf5p+ThG61xUbOxgDCWL5XKSKx+6Gres0mPnN1zmIXQD1rldddcLkXb3tOt3RSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776010847; c=relaxed/simple;
	bh=zIPrNtZMbMKummVw6ySBOc4k+wRW4ue3/u8QNdo20LU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jVZiRNip+8ETl+hNEAM/oqC4ao9akW0EDgop9eDxk8w65a4l1lh48oh68zJI63yH2wqJyjr8CbS8VSCFNfyHR58eqI5TgEseK+aJ4VPX4IyIrOYnh+VrM7XFtvcUwHZTkH+/muEJrz8pGlbxeujNHZCSOwVjETDAh/eqRbcA9DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RohSaMcB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDA2C19424;
	Sun, 12 Apr 2026 16:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776010847;
	bh=zIPrNtZMbMKummVw6ySBOc4k+wRW4ue3/u8QNdo20LU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RohSaMcBYDtwtHgaGyIpmE1T4HwapM8DApBOgv0hsNt4bpvt9jnBGwfSgVgPim4Za
	 py72AVxzlkCA1i1aV2QLyb04AMqND72eWBHGWcfeT/VOB0u5CUydeP+htNHiuSVUr2
	 hHyb7UflxePUancI9UxysW7xvpx4ovcRxDhG+4zWmUNPLzS+gCss+h3Ihb8BeKe22f
	 dga+hqUXXL5TZl9cTeWItXV4G2p0zIwXgrN27L0XI/zEEv8Bh9jnVopK4mKy2JaGPu
	 FRzAOG5N2+1cqwSX0KArezNTR+fdBmQLyHkNfgSZoED+CT2FsV3Mf9Ot67e4gtOeYB
	 X0wSNH3atV8JQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD4E3809A8B;
	Sun, 12 Apr 2026 16:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: Rename ifq_idx to rxq_idx in netif_mp_*
 helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177601082004.3330556.11704145630770008538.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 16:20:20 +0000
References: <20260410130602.552600-1-daniel@iogearbox.net>
In-Reply-To: <20260410130602.552600-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, dw@davidwei.uk,
 pabeni@redhat.com, razor@blackwall.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277830-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 907F03E4BCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Apr 2026 15:06:02 +0200 you wrote:
> Rename the leftover ifq_idx parameter naming to rxq_idx to be
> consistent with the rest of the file and the header declaration.
> Back then this was taken out of the queue leasing series given
> the cleanup is independent. No functional change.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Link: https://lore.kernel.org/netdev/20260131160237.07789674@kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next] net: Rename ifq_idx to rxq_idx in netif_mp_* helpers
    https://git.kernel.org/netdev/net-next/c/59818773bab6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



