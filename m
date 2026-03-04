Return-Path: <netdev+bounces-263528-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGelIUiMp2kuiQAAu9opvQ
	(envelope-from <netdev+bounces-263528-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:35:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 348C21F97F2
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C0C21309C43F
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 01:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BF230EF91;
	Wed,  4 Mar 2026 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TK5sB7l0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D76430E837;
	Wed,  4 Mar 2026 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772587833; cv=none; b=c3uh71jucTCBeAGKQ92atFcJICjolCA9tLLkI+BMn91VSMFJhChiNrmbj5ylKwUhNrmdTOHvUcbdLlckvOuMog6mGTp0xNphT/WQHanMPl1ty5sApHUxT5z9fEPGkv/xrxIZEzYSBpQzlW8OQpmR712hArvp67cbOqzNY2sJbAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772587833; c=relaxed/simple;
	bh=9XDIQ1lW2/W6tY73S0xeg5sRD/f/ZwTOs5OGN6alcKk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WY7hiZB1LE5TTvk3eNVhpyvn70v4NWUeZY5vxIMajtoUI4s7XaG/UQNLK5vGBvE7YPzKDjCPtQ4IpIRpJFZxipXaTd20UmppzzrNDel6D0wePOkJpHpPQLP+Bghmz2gA/zxCG3JIxLYBHsn7v3zTBYc77XDSJszuMxzoqL0U2eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TK5sB7l0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B195C19422;
	Wed,  4 Mar 2026 01:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772587833;
	bh=9XDIQ1lW2/W6tY73S0xeg5sRD/f/ZwTOs5OGN6alcKk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TK5sB7l0iy6ihRp9hK++LT1i1m7w28nySkvx/vyo23WqSNLEPHnQPSg1x1WXNtydj
	 CBLkHqUumKBmSnhFWhlYg8lcx4Nclz98Ij43n7HjWrP8StpajZ5Edkm+L7eiCoDuGv
	 twuD4Uj5f8sbXLEgtQpdTfz6OyhIXBHJr29pWnMQkKwQ97FRNaqvzowGDh6JiMcT4J
	 Q7Bsp2i8Rw5Q5FJDv7GjKbx71JYsg6e7AQeeU8oholHYy3Xl5QE0Y8gVAkpiI+qRO9
	 6pR6Ag051Af1C0yrtfdi0o99GweKpbTOQVAyrIsOIGGQ01COgVR31UfLTUVuTrOQoj
	 jXmfvRIr/sZgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF173808200;
	Wed,  4 Mar 2026 01:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: netconsole: print diagnostic on
 busywait timeout in netcons_basic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177258783429.1546050.10122433930612295627.git-patchwork-notify@kernel.org>
Date: Wed, 04 Mar 2026 01:30:34 +0000
References: <20260302-netconsole_test_verbose-v1-1-b1be5d30cd7d@debian.org>
In-Reply-To: <20260302-netconsole_test_verbose-v1-1-b1be5d30cd7d@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
X-Rspamd-Queue-Id: 348C21F97F2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-263528-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 02 Mar 2026 06:40:39 -0800 you wrote:
> The script uses set -euo pipefail, so when busywait times out waiting
> for the netconsole message to arrive, it returns 1 and the script exits
> immediately without printing any error message. As reported by Jakub,
> this makes failures hard to diagnose since the test reports exit=1 with
> no explanation.
> 
> Handle the busywait failure explicitly so that a FAIL message is printed
> before exiting. This is how it looks like now:
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: netconsole: print diagnostic on busywait timeout in netcons_basic
    https://git.kernel.org/netdev/net-next/c/dfa77c0dd4ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



