Return-Path: <netdev+bounces-251735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCoaAT1BcGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:00:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FB15023D
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3EF6880AD5
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0408B347FCC;
	Wed, 21 Jan 2026 03:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spNmSRom"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904FF352956
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 03:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768964408; cv=none; b=Dp69Q8rp+55VGo7Bt//BH+5sTYLEuV94fVZ5tbyS218EPLdWwgItlkJjKi9vuyg89XP0fc6QzbyXzlRNsRcDzIOX4ASpoDvwgnBU6aapeNDmYTbFKFmNgu3Udpjg8Ecw7tcfZtIGd6nh+bXrjy/cQEBQKMUxKeScxfNybnVBKa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768964408; c=relaxed/simple;
	bh=NDWZeIue5dEa8N9fwp4wrJF6ZVdgi4TWcwi7vjtdL28=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GeCl+4wHy5DdJadMqJLVCr3hjaezdFgbPX4AEvrMrHebh/uRE4klIiVgr1BKsxlcqYg1jkErBdhYvk/rsPnqbOYO7/C+r8f3RwWoWUe8e68ZURXN84W8nvRamZbuWrJkkSw7dZGXwdEZ1yBwLL5wwQLcgdLR6dkLJCxfBDj9d7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spNmSRom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9B4C16AAE;
	Wed, 21 Jan 2026 03:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768964408;
	bh=NDWZeIue5dEa8N9fwp4wrJF6ZVdgi4TWcwi7vjtdL28=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=spNmSRomNHCqERGZrgIn7zK+sWHBdJpmixTRATstofhjg5Ke0POSI2anfKA9+O0Wy
	 nporK26lr1xayhpTCS4Fr3afqom05vnJDVGbydrAS7g4Z+89w0UOgOGdrJ8B3/ZSiN
	 H7/4WIbZpbqWBz2cUBZcJiHr+8qJp3Wc4qONI2cVQAEnm92UESBqlpFN27nODPnvE/
	 zc+RCDH1wG49CsxtHe4JVrjoM/xZxgARCYg2SdqmQFVW53PEgJ7WKccNH4AWC0FQu4
	 hAJ1KCHBmJXodjt3XF0axgFxvvSaH2wxafURqptzixkyOuvQy+E6aBcX3QVoMy01gE
	 zsg9scb60YKMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8F6E380820D;
	Wed, 21 Jan 2026 03:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: simplify PHY fixup registration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896440535.705266.12272025131173137791.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 03:00:05 +0000
References: <e7394cc8-5895-4d02-a8fe-802345c7c547@gmail.com>
In-Reply-To: <e7394cc8-5895-4d02-a8fe-802345c7c547@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, andrew+netdev@lunn.ch, linux@armlinux.org.uk,
 pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251735-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 84FB15023D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 18 Jan 2026 23:16:27 +0100 you wrote:
> Based on the fact that either bus_id-based matching or phy_uid-based
> matching is used, the code can be simplified. PHY_ANY_ID and
> PHY_ANY_UID are not needed. Ensure that phy_id_compare() is called
> only if phy_uid_mask isn't zero, because a zero value would always
> result in a match.
> In addition change the return value type of phy_needs_fixup() to bool.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: simplify PHY fixup registration
    https://git.kernel.org/netdev/net-next/c/0d035fb5dcd9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



