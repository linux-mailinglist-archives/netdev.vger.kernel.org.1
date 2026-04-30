Return-Path: <netdev+bounces-282928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOTAGvl682nH4QEAu9opvQ
	(envelope-from <netdev+bounces-282928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:53:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB234A52D2
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14C3B3031CC6
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A557F44BC88;
	Thu, 30 Apr 2026 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMvDqa/s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838892E7F20
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564252; cv=none; b=AY2iCgg7Z81GCYjOoPp2/7GM25nCBTkKHepqM4uDuiKWPXP+1y+2XErQs3hs/OGHiDYSruppI4IkwlJENEzTDYoyoojngIoH8ykm38cKsbm0K6i5UW6upJ6uAntsuyTifvr0Ce7R+DtcB6PMbjm48BXsZ/ejXypHuLTtd3Eb844=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564252; c=relaxed/simple;
	bh=i17bkRA9ZM8Zb6B2YOoJQwthaj4FCYcd/reu6I/vOBU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gph5aW3xaFPblS8XbPlXSGoP3XtNPtspjGFB+3NLWLzfn8dy6P6ryOEsz7Gzs+OO6u7va6GPonFm0enQZrf2FTn6UrqPml1jK+I11S8cyAljmPom45dLYo0zorJ4mVk9G4bOySRO3gkjAYbePKPr9OKBch7moqOtZU2dAAxGfb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMvDqa/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D0AC2BCB3;
	Thu, 30 Apr 2026 15:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777564252;
	bh=i17bkRA9ZM8Zb6B2YOoJQwthaj4FCYcd/reu6I/vOBU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OMvDqa/sM5SgC+9LKZFGdYZ2QdHGtqtmuCKr16CO+HAI5pU2ZJzmqSWge1LbbeWtl
	 /1pNdolFtKh39Sk0LSImJ4fsdd7B3owqorFQ2GCS7hu0Bv0uBJcH238AgoHmg/FOKD
	 s+L2Ra7w6VlhRMf77Lmj2+bi5SjHL2L427oeL3djyL4KY3U1Y+5MlAdI4K9vcJALqw
	 zVMjuXEcicOW/CTvQQjT/4krhOJpF2cbLD18f93ATG0eHhe2FupshkrQWE1dUUcXKA
	 8erLmmovW0gxsK/e13V7EUse4a1kC0GgFuJyWTKNumFeMFL3C46cO4LdtwzCBPOEyW
	 yfxyNHIdb51mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CC2380AA5D;
	Thu, 30 Apr 2026 15:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] man: remove libnetlink man page
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177756420680.3067548.17200337241738648432.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 15:50:06 +0000
References: <20260427172827.300214-1-stephen@networkplumber.org>
In-Reply-To: <20260427172827.300214-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
X-Rspamd-Queue-Id: CCB234A52D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282928-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:email]

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Mon, 27 Apr 2026 10:28:27 -0700 you wrote:
> The iproute2 libnetlink is not a public and stable API.
> Having a man page encourages users to think it is available.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  man/Makefile          |   2 +-
>  man/man3/Makefile     |  18 ----
>  man/man3/libnetlink.3 | 200 ------------------------------------------
>  3 files changed, 1 insertion(+), 219 deletions(-)
>  delete mode 100644 man/man3/Makefile
>  delete mode 100644 man/man3/libnetlink.3

Here is the summary with links:
  - [iproute2-next] man: remove libnetlink man page
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=fa2309a9e91e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



