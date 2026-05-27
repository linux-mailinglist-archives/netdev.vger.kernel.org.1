Return-Path: <netdev+bounces-292043-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPCdHXtLFmrZkQcAu9opvQ
	(envelope-from <netdev+bounces-292043-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:40:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D1F5DE4B4
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A62B73011E8B
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432EC327BFA;
	Wed, 27 May 2026 01:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjA4yeD1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0CC3264CE;
	Wed, 27 May 2026 01:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846007; cv=none; b=t/L0o0ID32rol6zIKoVtWJkJnlI4zAF/8miyuGt2f2NbS1bFzxKZ12cAmDDF8q+AkGhMYcihbNYsnyjmlTSUsSa8A5TUhQMBE3qqYzSyjnnKZ6rGXzWHNMQRyIL+XqIgaV57F6dLIjoEY7uUx7pdpNB/OiN9K0OGRW2eTcWWJ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846007; c=relaxed/simple;
	bh=wdEqVU25TkoImJ3uHsaTMj+ujkhhHhTwYJ14pLFeKfg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gZVXUTM97ERoAsm/c10J1w4BcQK7rbX1zLwu0t+IiFHifKivzeOx5z5HE+PuW8diRHaPEtEGiI5HBulCHl7CGhkJwE6uUE0WJBtrCp5VOBnQeiAvmCP0z+Kacu5TznRGnGyIPyLtQC825eLLYFHo0YOQ+h0Bq5gmt85ZkoNYDTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjA4yeD1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EED21F000E9;
	Wed, 27 May 2026 01:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779846004;
	bh=5K4X2aR+rSPryk8cmE6pR6yWpD5CBXWJBfQZio97I1E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MjA4yeD1IBFHCXzT0XkJkK76mwMCvX/I66F2RM8n5NNHmlyPZIIzPpdgvYm7vsFFg
	 C+KWANnGNeMcvHQmajYIQ9CrPm3dS+hxPUXZNO6+wRwweXuKhJrEYH+YDa0Da+rOCR
	 QKYTsD/WX+MemKOQTImR6L0vkoXUmscvFk/kBbFkW15llltjbbI/WEph1K1f+d7rbm
	 ex/vLCs0OhUXIuc9+j0m4Kmq1Hxqj9uTL9vLwwtyhvdHKsGTx6XUQqbhhH8QnigT/R
	 OpO5jvuaT1NdZeDWtXr8E1X9jk3bY3rQKQfvAagUrNoPVg4w/YLZ+WvhIh/EtHQIS1
	 pvSP6kJZO2SwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B9C380CEED;
	Wed, 27 May 2026 01:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] NFC for v7.1-rc5
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177984600990.4043619.4352308425874213846.git-patchwork-notify@kernel.org>
Date: Wed, 27 May 2026 01:40:09 +0000
References: <217c0646-8a30-4037-b613-580c2b189729@ixit.cz>
In-Reply-To: <217c0646-8a30-4037-b613-580c2b189729@ixit.cz>
To: David Heidelberg <david@ixit.cz>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, oe-linux-nfc@lists.linux.dev
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292043-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B7D1F5DE4B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 May 2026 14:30:43 +0200 you wrote:
> The following changes since commit 7fd2df204f342fc17d1a0bfcd474b24232fb0f32:
> 
>    Linux 7.1-rc2 (2026-05-03 14:21:25 -0700)
> 
> are available in the Git repository at:
> 
>    https://codeberg.org/linux-nfc/linux.git tags/nfc-7.1-rc6
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] NFC for v7.1-rc5
    https://git.kernel.org/netdev/net/c/e66c456f7ce4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



