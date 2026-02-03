Return-Path: <netdev+bounces-256068-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFmzBbhPgWmLFgMAu9opvQ
	(envelope-from <netdev+bounces-256068-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 02:30:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FE6D361E
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 02:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91DB6300C5B5
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 01:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AF323D7EC;
	Tue,  3 Feb 2026 01:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gl9wCQ0o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F0B22D795;
	Tue,  3 Feb 2026 01:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770082215; cv=none; b=pLfi2EKZjVXyXlHKD7EaJ4sJPw3+cluCBfnsUR34Gnf1kuT2FidobQdFWI8G/Qry+/sDqm6zR/3Jxw23G+pJekrpKlrB3ARb97eG9igULL9CE0C8T+uZrnxjpb5BuBj8oZBpEGLGLOe00cJTGYrdA3C3x+kXAcRkk6p4sOafq2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770082215; c=relaxed/simple;
	bh=GR1inyhKGpOoFWWZgqo3HpJhl5nqG5Lh23Hox7yvCW0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FUdUCThxqp1wrao9Xk5iGpmRsh4F8LAxZd5aCB1GnxuYOBq0u1IKK/sPX2HIJigfKWqMr8PqIiViXmHpCrmCat7iRPDbrOOXNnXU+HT2cOZEFnfxgFFJY9mfaDvpKTu9jX6YMmYZ96pAUO9yRKDH3R9G/OdqiFerZZvfyv9rhMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gl9wCQ0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18858C19422;
	Tue,  3 Feb 2026 01:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770082215;
	bh=GR1inyhKGpOoFWWZgqo3HpJhl5nqG5Lh23Hox7yvCW0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gl9wCQ0omzQZpVaHxGSe0scTZ+6N0d2cOVjz5EOzr748f0nMt51FdqprpqXXzUV3u
	 Z4mL/deLJFzFps6ISghGuq89ipMrJWfXjxlWvtFvw2u5zKmTKtFG++cKew+02jz2Hh
	 hYHsUJabcm8aAzndBdepXfu8kgubR0Qs7WspvQRJDv11Nqg9jJakSr8VvgFXFqKuNg
	 nZIgJqRjPVCpUlw1KxkR1EN9sVZISQc5qz4HG99/nFLTsMfbQ6NrC9CzYsdHQrdmWR
	 J0Na2bBLRbhpKCPEvrsjjCHEYKR1eZT/WQwIzOWCYPG35uOFMt14lJDIBQEoOxhAR1
	 PR6T6hZSON5RQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 16ED13808200;
	Tue,  3 Feb 2026 01:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: phy: dp83867: Always program R/SGMII
 enable
 bits
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177008221161.1265245.1415470766926068713.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 01:30:11 +0000
References: <20260129171205.3868605-1-sean.anderson@linux.dev>
In-Reply-To: <20260129171205.3868605-1-sean.anderson@linux.dev>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, edumazet@google.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,vger.kernel.org,kernel.org,redhat.com,davemloft.net,google.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256068-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75FE6D361E
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 29 Jan 2026 12:12:03 -0500 you wrote:
> The hardware designers at my company neglected to read the datasheet for
> this PHY and did not add appropriate resistors to configure it for
> SGMII. Add support for configuring the it based on phy-mode instead of
> relying on the resistors for a suitable default.
> 
> 
> Sean Anderson (2):
>   net: phy: dp83867: Program TX FIFO for all interfaces
>   net: phy: dp83867: Always program R/SGMII enable bits
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: phy: dp83867: Program TX FIFO for all interfaces
    https://git.kernel.org/netdev/net-next/c/d700b2a44051
  - [net-next,2/2] net: phy: dp83867: Always program R/SGMII enable bits
    https://git.kernel.org/netdev/net-next/c/3d0721cfcf57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



