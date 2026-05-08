Return-Path: <netdev+bounces-286047-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePCBBvlv/mnNqgAAu9opvQ
	(envelope-from <netdev+bounces-286047-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 01:21:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8321D4FCB69
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 01:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC74F3023A50
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 23:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E413D367F39;
	Fri,  8 May 2026 23:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPw4DV+7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BB512CD8B;
	Fri,  8 May 2026 23:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778282474; cv=none; b=YfKvJpFYxcgYBYQSX0PWLuK6XVAvxgCJPBae16mvd/qGk8LROR/1LNUUKRT0sIodCim6kB1SuagrNuUBf4rz9+L6S2qjPJQ1ZqJQJainUtwxg3aMOEGvotPm77w9Zjey5mdkPCVhYYuJZkbdPYMqGTeSZEQBaZobD6h5NrAegyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778282474; c=relaxed/simple;
	bh=pSIUvfmRSzTJPBMVYA+UHNzV3MqNiOvXD7aLrFNv8iU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m+QXyMNnnisRHEYdlQLGWC6CS+opGk9CrYCsyowELE7GfRO7xC5+UKSHV+R6JbOPtjZpL4MDvvM0FHUSiyld0ZmGvSrNq9MZrluDYG9Jwskh2L2F56c2vfaFHsJmGK/qiZZFiQfK4jp6bq5invSmg6nUeJXk9nfLBL4BBX6PhxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPw4DV+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6113BC2BCB0;
	Fri,  8 May 2026 23:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778282474;
	bh=pSIUvfmRSzTJPBMVYA+UHNzV3MqNiOvXD7aLrFNv8iU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bPw4DV+7wsPKkNOsTOLgrgMu+oLF0NAj8SYua046g4s/bW0h8onDrgfRUniXOVNr2
	 McknivoYGLBenx2Hne0MKpcyqoCQ/0jGxxjEn9caMkeHMfmfwMdLpHVzKBqSwhA+G8
	 YBJpltvGZucUJM6N1UbKuZL3/f/MqTCNDo7rA/7cJWS6vE2BXoSbkGttLDIsauaHUH
	 I5MH5Rh9gaM3mWmApHe+qBL+2q+dr59C5n/5PT4iN/Qz9BOqngcRYpUBrjOFjFaBaE
	 BFE/EUMZgR/sfXvnSnAsq+U7UBit14hWkieYUT2UXGoW8wyOk6K0uAqjFVBynEF/zx
	 llSiJ9ipMsiGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C5E38119DB;
	Fri,  8 May 2026 23:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phy: dp83867: add MDI-X management
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177828242263.890779.7434407913066087321.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 23:20:22 +0000
References: <20260506141918.13136-1-l.ellero@asem.it>
In-Reply-To: <20260506141918.13136-1-l.ellero@asem.it>
To: Luca Ellero <l.ellero@asem.it>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 8321D4FCB69
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286047-lists,netdev=lfdr.de,netdevbpf];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 May 2026 16:19:06 +0200 you wrote:
> ethtool on this phy device always reports "MDI-X: Unknown" and doesn't
> support forcing it to on or off.
> This patch adds support for reading/forcing MDI-X mode from ethtool
> properly.
> 
> Signed-off-by: Luca Ellero <l.ellero@asem.it>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: dp83867: add MDI-X management
    https://git.kernel.org/netdev/net-next/c/be0e8db6935f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



