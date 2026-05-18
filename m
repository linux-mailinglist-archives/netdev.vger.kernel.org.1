Return-Path: <netdev+bounces-289203-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WATLBdWmC2p2KgUAu9opvQ
	(envelope-from <netdev+bounces-289203-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:55:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ACE575430
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92486302DA32
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 23:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C3E31618C;
	Mon, 18 May 2026 23:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmTKejbK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0894288C2F;
	Mon, 18 May 2026 23:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779148196; cv=none; b=WMBkR9Yh8prDUrvc9y2hYvkWOKyj8/Q6HDNWjhBegLasfDvy/ZsHrhX9/7y2aKoJ4++qweDTTOdh5hFprD2ldR3mrfQ9O9PKqV+NwXhHbxoetrs6HinqVVJT6iBaSQkKYIVSWj7R0hpuVw7ARk3XSEdxM7cLaKaw+xsmq4E1XwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779148196; c=relaxed/simple;
	bh=yGCNGixEt5849Bj8zCVefgJ4YgdrnG1EZa6yO0LYEvc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tYszpNHFb3ZNNhGVvChebo9qF0KFpY0cC9CeBd3CxqlFqYeLRti419I2b4uTH6NmgD45DQ05xpJ3rklWvMSKW9t53P7A3LK+PVuNUPojrJUe6ZlVdI+83B+k5GR+xCSV+2dVahbr18boGZbAzRJ9rq8bYYXnN2EAc9/dh51ro6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmTKejbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B98C2BCB8;
	Mon, 18 May 2026 23:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779148196;
	bh=yGCNGixEt5849Bj8zCVefgJ4YgdrnG1EZa6yO0LYEvc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BmTKejbKeKuySoS5MXzeAdogTk3LJaxynR06FYGCoe3oRCKFR5H8o0EQR8APYwmCl
	 UP9Bns6dCH+HnkpNbV7ozvOzUDde3EOyX1cOgv2IAmeM269612iFqtf49x17cyMUgt
	 86hC3rTni2CXdRB0IPTESKHfKWFuKWxGOF4orB0Dpg/Cfk1wTJHExVK+7AIF9bPucr
	 x0cYRq4dOJv0LnfNFNFWtsi3JSruOiAayav3xPyf07j4Cw9ZTszKdpNpVZpApOeUUE
	 NMUpP4dccatiUqkhsVcxFzwKLLCNogwywS9BQkfxAyFZwrEdI8T1C//kTf04F+ZF3m
	 BbZKLZV5TJq7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09863930CBF;
	Mon, 18 May 2026 23:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-05-14
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177914820764.2015817.6471364174458155858.git-patchwork-notify@kernel.org>
Date: Mon, 18 May 2026 23:50:07 +0000
References: <20260514172340.1515042-1-luiz.dentz@gmail.com>
In-Reply-To: <20260514172340.1515042-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289203-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 71ACE575430
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 May 2026 13:23:40 -0400 you wrote:
> The following changes since commit c78bdba7b9666020c0832150a4fc4c0aebc7c6ac:
> 
>   net: phy: DP83TC811: add reading of abilities (2026-05-14 15:17:12 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-14
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-05-14
    https://git.kernel.org/netdev/net/c/23f3b04f157c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



