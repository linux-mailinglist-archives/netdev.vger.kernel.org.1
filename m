Return-Path: <netdev+bounces-253686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEq+IbwzeGlRowEAu9opvQ
	(envelope-from <netdev+bounces-253686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:40:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5858FAD3
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 367C8300E0DF
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8E430FC08;
	Tue, 27 Jan 2026 03:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gyzd3sRf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799DC30FC16;
	Tue, 27 Jan 2026 03:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769485225; cv=none; b=d1o2+DgT/wyEz0YrepydI83BjGvmShuy++2AFU9JAuUQjTI1q3zQ1EUMyv+yAS25HWgLaAV8kw1qWSDCT1PgE7OfMJSaJAAoI3GSJPHcAYyUaqX7MmisWA/EIljlRbcQSOIzHRfb584qcIwXbIf5cAsKhM2XRYVuq2huqe0w+H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769485225; c=relaxed/simple;
	bh=EyDnbg/lleTVYrMGxGhuMVvM5X0Rlth/QSi6mgOon/o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y2kV27MRq7vUofhyRaRrQ3A2CaSUUvQqDVhz3NjVXaZ5ogdXLsf6ulACzniuYjbAnrEtG3ME77thOh5EbSlB7kgvvTGsJcLrS2jS9/m4sXaBbpOs1dR8RvURE5b1+yzJSsTUEalbblwPG3jetH6n0KXxMlciZzVxRk+D5E2MS4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gyzd3sRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7F3C116C6;
	Tue, 27 Jan 2026 03:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769485225;
	bh=EyDnbg/lleTVYrMGxGhuMVvM5X0Rlth/QSi6mgOon/o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gyzd3sRfVZtmLP0TJa/6iLfbwsIZDUX1D7ANHm7vCV21TRq9hE29rbLAabdATgIKl
	 vd7YFi5xBeY8C1raE1F9tGzKK/P7E3T1jKVTmi1MSOruDCCMWjB1UTNyS8VDY5q5Nh
	 OvWJMMpwoQfjhBKtB1CXg3wt6FqbFRiCEPgp9z+BRbVMfznWguyjq9JLCVKjh67zGt
	 yh3+XFa6BkX+bFYQlk/w+dotCGdmoscZ4N9w9zStjy2NKj2XnkTdAjLGLL11RGgHU+
	 orda3Hd0UNuFHwdyKB52NaxSnNM04/GXxdGgWDVP4BDPhTZW6dH2GWqw7Ngdin7hWk
	 V0/+qFGL2r8UQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8F05380A961;
	Tue, 27 Jan 2026 03:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] selftests: net: fix wrong boolean evaluation
 in
 __exit__
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176948521934.672496.14936979307496072577.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 03:40:19 +0000
References: <20260125105524.773993-1-gal@nvidia.com>
In-Reply-To: <20260125105524.773993-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 horms@kernel.org, shuah@kernel.org, joe@dama.to, sdf@fomichev.me,
 linux-kselftest@vger.kernel.org, noren@nvidia.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253686-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C5858FAD3
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 25 Jan 2026 12:55:24 +0200 you wrote:
> The __exit__ method receives ex_type as the exception class when an
> exception occurs. The previous code used implicit boolean evaluation:
> 
>     terminate = self.terminate or (self._exit_wait and ex_type)
>                                                    ^^^^^^^^^^^
> 
> In Python, the and operator can be used with non-boolean values, but it
> does not always return a boolean result.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftests: net: fix wrong boolean evaluation in __exit__
    https://git.kernel.org/netdev/net-next/c/a84a1fe0fb2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



