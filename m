Return-Path: <netdev+bounces-284157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDdFDWlP+WkV7wIAu9opvQ
	(envelope-from <netdev+bounces-284157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:01:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A98C24C5E01
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4ADF6301E592
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 02:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00FB285060;
	Tue,  5 May 2026 02:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUX9vngn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD421175A98
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 02:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777946456; cv=none; b=fZ6Yr3CqRBzJT+1zg/1dN6Bx9hzfd2Litnu3xZ9t9r26kNBdDJfelA4GOON+eqHcAlPYodoV595D7h5glaeDqNYDLPeKPZXiu0zdCjjHgxFlHvGS24+lhI4TA15ttnpOM9k50RWctnHqu0m/QuZ07BWHg5i0UjtVTRlw1eMqsCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777946456; c=relaxed/simple;
	bh=Xq4SPB8L4DOs1+B+LJB0mFLC4BqJepp6yEOZqHGZnOA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Er5glYoybusg9fVy6zaBo43b+AFkzDVHHyiGTL6JBvHIc56+6MZ7E4OKt3rIMHAj1ZrHsBBwoofg15EKkRFaZAuFzJSTVsE4pIc8wDo8i6Qt0521k6giXJp4a8XEh7hcyQBNb/8rCm0bkGnk8ItuP693ESll6c0imYsCF713xTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUX9vngn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7514FC2BCB8;
	Tue,  5 May 2026 02:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777946456;
	bh=Xq4SPB8L4DOs1+B+LJB0mFLC4BqJepp6yEOZqHGZnOA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cUX9vngnH0H4fbf2UHGRBTVmLKozgtJhPEz9Qazoc1RDKzBmLJRgSWzy1jcRbtwC4
	 2iB+c7MAPoRQFixTaUPtJ13tMsIPyigSM6bIwImg4a3v97qIbNQbLVNhcXNO9GEPuf
	 EvdwgF+h18qCBdkTPklZ6ZA+bkdt+WtL7KttICMjFPzHMt7SbfmAzvOehK0ElX0GaW
	 VpemVo5cY5gMWg0nC49O7ifgMcIeeXec67pdfHHL3gcLDP3uTjsljEbe6CyxXZtO6d
	 F92RJMajvcmBFdEAJu7Dfmr8hcU7kz751XSge2JnjL3zapx9EnWpLoxlB4/QmL1R4b
	 96J9Oq8fSz8tA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF0B3930197;
	Tue,  5 May 2026 02:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] af_unix: Set gc_in_progress to true in unix_gc().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177794640704.1386640.10843392163753585620.git-patchwork-notify@kernel.org>
Date: Tue, 05 May 2026 02:00:07 +0000
References: <20260501073945.1884564-1-kuniyu@google.com>
In-Reply-To: <20260501073945.1884564-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org, sysroot314@gmail.com
X-Rspamd-Queue-Id: A98C24C5E01
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
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284157-lists,netdev=lfdr.de,netdevbpf];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  1 May 2026 07:39:41 +0000 you wrote:
> Igor Ushakov reported that unix_gc() could run with gc_in_progress
> being false if the work is scheduled while running:
> 
>   Thread 1         Thread 2                     Thread 3
>   --------         --------                     --------
>                    unix_schedule_gc()           unix_schedule_gc()
>                    `- if (!gc_in_progress)      `- if (!gc_in_progress)
>                       |- gc_in_progress = true     |
>                       `- queue_work()              |
>   unix_gc() <----------------/                     |
>   |                                                |- gc_in_progress = true
>   ...                                              `- queue_work()
>   |                                                       |
>   `- gc_in_progress = false                               |
>                                                           |
>   unix_gc() <---------------------------------------------'
>   |
>   ... /* gc_in_progress == false */
>   |
>   `- gc_in_progress = false
> 
> [...]

Here is the summary with links:
  - [v1,net] af_unix: Set gc_in_progress to true in unix_gc().
    https://git.kernel.org/netdev/net/c/d82ba05263c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



