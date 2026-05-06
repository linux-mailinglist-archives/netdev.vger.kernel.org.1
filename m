Return-Path: <netdev+bounces-284640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP94JoOX+mk6QAMAu9opvQ
	(envelope-from <netdev+bounces-284640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:21:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E834D5366
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D5F030471EF
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 01:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6768F23C368;
	Wed,  6 May 2026 01:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iC4six9g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BA31E531;
	Wed,  6 May 2026 01:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778030462; cv=none; b=NpHb2yvoOvOxJiqUFc2tolOdoWqCz/VTMW5EYi/KWOTmN0pcYFaSssyb+9zoprw2OKgelwqEq1B+W50z8AeIf+jquUQzzQdFYu9WsYjamxzZIwbqhZvPV5kITC5zucxyGHneRgekxPp3/wzy3Y12OMnhvVy35EznUNhfn4YNbQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778030462; c=relaxed/simple;
	bh=+CjBwsW7bIWchltAPR3Co2z+TOsbeorBJ93laHniDYk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nzF7+NsXeI8RwVB9xAfmHaIoQyRodgFN4A1hxUw+8fX8XxGM3gF94qqy5rrvDTJVu/QJCHrd1VzRTY9n4gKC9GylkXJy5lJCiO9ExODD/+RlRfOtFU6gZ2KXvU4h2nGHB5HSz8KmQuVXzqSfyk/5hfEyRaHZQjVjP/2OXO9Slsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iC4six9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBA1C2BCB4;
	Wed,  6 May 2026 01:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778030462;
	bh=+CjBwsW7bIWchltAPR3Co2z+TOsbeorBJ93laHniDYk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iC4six9gfZSVC71uo5nR8uk27YoYdOnjsDJM7KFQi2xwBYVApeMiph2QelxlJy2Pf
	 A2xFSgLGlmf4og7yJeu8HCVkN3iQ6bySUx6LdQOYpWtpjY0CxF4mYZrGDvhTBzDZ17
	 RTNBmNw+bI7o3/zXCTE1+eO962Xah4DeXQnhV9kQUtyaLzKkhGkl7An4GC189ES5Jd
	 gQddpn2dqPtgXa36ajOt5Z4WCNZSTb7XSciZlgBCoO4kTrf5i4e+gLKC14bXPfksN7
	 Y5Nk5bXODBj4wM6dTi+K8fZx62Zqw+ggdaLDCZf+mVjoT+PDme/5vKWjDnxZlWJfCc
	 aDY0IJw6W6Wlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF293930780;
	Wed,  6 May 2026 01:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] atm: solos-pci: Simplify initialisation of
 pci_device_id array
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177803041205.2335725.1428803814060061422.git-patchwork-notify@kernel.org>
Date: Wed, 06 May 2026 01:20:12 +0000
References: <20260504151202.2139919-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20260504151202.2139919-2-u.kleine-koenig@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29_=3Cu=2Ekleine-koenig?=@codeaurora.org,
	=?utf-8?q?=40baylibre=2Ecom=3E?=@codeaurora.org
Cc: 3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, msp@baylibre.com
X-Rspamd-Queue-Id: 13E834D5366
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.sourceforge.net,vger.kernel.org,baylibre.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-284640-lists,netdev=lfdr.de,netdevbpf];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.399];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  4 May 2026 17:12:01 +0200 you wrote:
> Use the convenience macro PCI_DEVICE to initialize .vendor, .device,
> .subvendor and .subdevice. Drop explicit zeros that the compiler also
> fills in.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---
> Hello,
> 
> [...]

Here is the summary with links:
  - [net-next] atm: solos-pci: Simplify initialisation of pci_device_id array
    https://git.kernel.org/netdev/net-next/c/17099a2f86cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



