Return-Path: <netdev+bounces-258541-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ofyBBnyRjmlFDAEAu9opvQ
	(envelope-from <netdev+bounces-258541-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 03:50:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4396D13277D
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 03:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CFC1B30138D7
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 02:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A650423EA8B;
	Fri, 13 Feb 2026 02:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jB3ryfhR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8386523EA80;
	Fri, 13 Feb 2026 02:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770951021; cv=none; b=g3S3tCtZfBM6btOdD+gCm04tsaJZnQ9tjm/4zl4hlkf1wdL0wY2huKQghLqdnNaqYxQ+FPtjk8EcgupvpylUpcwji1qedMKyh2/Ad+96tY4JPuvgfgEaOPU56hbUfRxBF3uzhFPWhbNmx7yrwT7Mg5hJu6KG6VCNMVrhonZTSZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770951021; c=relaxed/simple;
	bh=2JThHSlFcLyyC8mG+++S4UZ/Y3FGP1QCqT0OBLCLTiI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CdaPXCSOoz9oTUy2JupNp2NSvXecRISVMYeYbq6s5PU2K8X9ZumzmzT82CEZhaBQwYSBiPnRdvUSEn4HFQJa2l+E1fE8sqpRqoWAcu9jIfXC0590eXUy8z2xQYvEq1a7cUHP0KrxI+M19eWEs1EWRrJvg1KxLVnb1u/Sa3jAvME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jB3ryfhR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3016CC4CEF7;
	Fri, 13 Feb 2026 02:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770951021;
	bh=2JThHSlFcLyyC8mG+++S4UZ/Y3FGP1QCqT0OBLCLTiI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jB3ryfhRUtr1g1Pa3HDBOA8omM1nfHOn9XdCsCu+zYuWPp3bB80dqdWwU6kbKp1ja
	 mHqRJhOFKirwUKzpAX2V3ScroJ2V4cVY9dRfogsNk6SCOTdbo8IIPHDiXMN2+Hxybs
	 ZAlezLBanhwVb0xeXsKFqMRjGAYcF3Ngke+tf1ODsiW0vAL4wHxbURz67H7v83mWLb
	 1SX1KRYI1CG/turyeurFXvbrs7uUXl8xNm+ZUK3lrnQIEgf42dUape9Bb75PK+FGJv
	 eCXW0PPL+tSsIUtYA9HVuhZoK3rFdtoFkeqpID1VuqJ+JqE9xabrsUF32F0jEfxjD5
	 bTzAAWnbiQSfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8534F3931093;
	Fri, 13 Feb 2026 02:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: drv-net: limit RPS test CPUs to supported
 range
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177095101507.1819996.991647235143515391.git-patchwork-notify@kernel.org>
Date: Fri, 13 Feb 2026 02:50:15 +0000
References: <20260210093110.1935149-1-gal@nvidia.com>
In-Reply-To: <20260210093110.1935149-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 shuah@kernel.org, willemb@google.com, petrm@nvidia.com,
 linux-kselftest@vger.kernel.org, noren@nvidia.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258541-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4396D13277D
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Feb 2026 11:31:10 +0200 you wrote:
> The _get_unused_cpus() function can return CPU numbers >= 16, which
> exceeds RPS_MAX_CPUS in toeplitz.c. When this happens, the test fails
> with a cryptic message:
> 
>   # Exception| Traceback (most recent call last):
>   # Exception|   File "/tmp/cur/linux/tools/testing/selftests/net/lib/py/ksft.py", line 319, in ksft_run
>   # Exception|     func(*args)
>   # Exception|   File "/tmp/cur/linux/tools/testing/selftests/drivers/net/hw/toeplitz.py", line 189, in test
>   # Exception|     with bkg(" ".join(rx_cmd), ksft_ready=True, exit_wait=True) as rx_proc:
>   # Exception|          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   # Exception|   File "/tmp/cur/linux/tools/testing/selftests/net/lib/py/utils.py", line 124, in __init__
>   # Exception|     super().__init__(comm, background=True,
>   # Exception|   File "/tmp/cur/linux/tools/testing/selftests/net/lib/py/utils.py", line 77, in __init__
>   # Exception|     raise Exception("Did not receive ready message")
>   # Exception| Exception: Did not receive ready message
> 
> [...]

Here is the summary with links:
  - [net] selftests: drv-net: limit RPS test CPUs to supported range
    https://git.kernel.org/netdev/net/c/ed6788c5a761

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



