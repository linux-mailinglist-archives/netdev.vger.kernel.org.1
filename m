Return-Path: <netdev+bounces-261149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WxnBJpa5n2n5dQQAu9opvQ
	(envelope-from <netdev+bounces-261149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:10:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C9B1A0552
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EEB2B3015B8C
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E2F314B82;
	Thu, 26 Feb 2026 03:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpSHxhvg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0CE19CCF5;
	Thu, 26 Feb 2026 03:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772075407; cv=none; b=q61yp9s4TqHC2W8Hgzpny9RcTzzOyG1952cwkLgrkAG5uzTCdTth/2SS+2Al4sskY1ILdjJHvstPt0YSXCcaKQPBhROl5IvXtdj858UYuQ3snL3ZiPQpcLXzyNCqcisHioaCiE9RIr4vKF8upgMGqPUoEafAzX9+swebfAy22y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772075407; c=relaxed/simple;
	bh=Iam7PncFOpUQ16hUdhzEUV/z3lh8+hl2Iv3l0b8oDhE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u6MGUUV/p2RMPvJnsHpLXkWNKcT7cLJgsrIW5QsdwIC8t5DXvTgH5E2PBu70dj2oqS7/4BJdqHv4k2DwkjHlXGLElcTgW+Yrq86HL4rGhPkCgaOGbVPxBn69wAud2wizYmUaSTifJemJv90yJx2WffQhjplGKtByHMHNSyFp0k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpSHxhvg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A67C116D0;
	Thu, 26 Feb 2026 03:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772075407;
	bh=Iam7PncFOpUQ16hUdhzEUV/z3lh8+hl2Iv3l0b8oDhE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fpSHxhvgyiikhw+byfDgZBtaolTuLSKpp68nqam7sfqFRDsp6znDdvnGgv2nh1S/H
	 DphRlJPLcj8LEAEXFG2J6EFe4Fth0XGZPLzsWszqSu1yJ460q5hH58YpvI15gisMhT
	 tOQS4IQQvAQmG75UjOWy94ISjRqzN5oYyOa9RXkL+/N+vleNhcCAvr3dGwhgFFSySG
	 NVG5wpqhSWPUCjgvWjtIJfoxTb/kgwDJEgkv2oNsKlNQyJTs+/kAUGD9zXMeGGOJwS
	 Ep7+G9LzmMYY44LYt/M1AWS3a5MT6UR+9uq4r5nbXHkHsVzm/MAJkT/VU0zlIsfpGn
	 R+uKqo2duk67Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02F13380A94B;
	Thu, 26 Feb 2026 03:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: usb: kaweth: validate USB endpoints
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177207541180.1014739.15278757505426867455.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 03:10:11 +0000
References: <2026022305-substance-virtual-c728@gregkh>
In-Reply-To: <2026022305-substance-virtual-c728@gregkh>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261149-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: B7C9B1A0552
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Feb 2026 14:00:06 +0100 you wrote:
> The kaweth driver should validate that the device it is probing has the
> proper number and types of USB endpoints it is expecting before it binds
> to it.  If a malicious device were to not have the same urbs the driver
> will crash later on when it blindly accesses these endpoints.
> 
> Cc: stable <stable@kernel.org>
> Assisted-by: gkh_clanker_2000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> [...]

Here is the summary with links:
  - [net] net: usb: kaweth: validate USB endpoints
    https://git.kernel.org/netdev/net/c/4b063c002ca7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



