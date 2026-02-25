Return-Path: <netdev+bounces-260756-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKUtKBB2nmnhVQQAu9opvQ
	(envelope-from <netdev+bounces-260756-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 05:09:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE06191800
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 05:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 069B43005175
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 04:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57E6246788;
	Wed, 25 Feb 2026 04:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPB5NxPQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C971ACEDF;
	Wed, 25 Feb 2026 04:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771992587; cv=none; b=U95sm7MtDKWOUmqJ9hItAt2krIj2XJ5le6xlwKwEEKomdmcGq8gISty4u9aDNEXtm8+tHU+NPucsSLWjBigSOdfkaYwW6LszHU9QR5AYq2VNDf6alsSz/N5liMC7LghecJ3fwufYkkCquVMCJjNrCH97EAVBDj4/afamTh6U+G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771992587; c=relaxed/simple;
	bh=amBYYcNYoxZBtRFJeYOYnIs8UOcXEBTJrLIKwlbwpA0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=okGmeByjpk4f1H8a6fcEvn9R8qTD0wxE8MWd3c8cSABESanx6GQR3PjdJME160QuJuT2sVsAE2kWeyLhV/eSxTq4UFlFC3ZtDRebA3+3sTA5QqAeV3aA7ibxzvf3SrwsV7YxKFGl9DT6ECWblf6/DUmzsjmqGc4YUowdHUbr6/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPB5NxPQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323DEC116D0;
	Wed, 25 Feb 2026 04:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771992587;
	bh=amBYYcNYoxZBtRFJeYOYnIs8UOcXEBTJrLIKwlbwpA0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FPB5NxPQ7E4H93gjeBNIVWPlxFeb/Ln2OgOAVYctYCxLdHouG4PZkxdCAuoYoB3AS
	 1fQWP965VBgaJ/uJg8ECW8agpFN8ayunKI4Y/c95f8KiY1bj/7ihvYQI1kJ7IlkSz2
	 U2bGDYoxg4byxSGNLSrvsRxRCPwugFw0NkVneklla3TBDIGeSWVOgOFjflmtqLZIKc
	 gGZlolCZj2Z7Vf+3Fo4nx0g92hxf9D3kAgHQE7+jMXjvbVvYBVDmNKEGSBJ9V+d47a
	 o2IlgA2GFRteDwa9vGqp5ttNc5LbJ6EacrfqO/unY8DpjaOJlSb6frysr6hlmW9ZAD
	 PlDAreQXLqXbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EE6380820E;
	Wed, 25 Feb 2026 04:09:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] selftests: net: py: improve bkg() error
 reporting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177199259254.36698.9217423862791376479.git-patchwork-notify@kernel.org>
Date: Wed, 25 Feb 2026 04:09:52 +0000
References: <20260223202633.4126087-1-kuba@kernel.org>
In-Reply-To: <20260223202633.4126087-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 petrm@nvidia.com, gal@nvidia.com, leitao@debian.org,
 linux-kselftest@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260756-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1EE06191800
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Feb 2026 12:26:30 -0800 you wrote:
> bkg() is a helper for running commands in the background.
> When init or body of a with() block fails check if the bkg()
> process already exited and report its status (including stdout/
> /stderr). This significantly improves debugability.
> 
> Jakub Kicinski (3):
>   selftests: net: py: avoid masking exceptions in bkg() failures
>   selftests: net: py: use repr(cmd) for failure exceptions
>   selftests: net: py: add cmd info for ksft_wait failure
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] selftests: net: py: avoid masking exceptions in bkg() failures
    https://git.kernel.org/netdev/net-next/c/d99aa5912c3a
  - [net-next,2/3] selftests: net: py: use repr(cmd) for failure exceptions
    https://git.kernel.org/netdev/net-next/c/04abab18e120
  - [net-next,3/3] selftests: net: py: add cmd info for ksft_wait failure
    https://git.kernel.org/netdev/net-next/c/6e4dff20021a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



