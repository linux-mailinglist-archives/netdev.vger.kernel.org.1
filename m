Return-Path: <netdev+bounces-256954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDtgK9shhGkDzgMAu9opvQ
	(envelope-from <netdev+bounces-256954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 05:51:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D73EE95C
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 05:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 942DD3019815
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 04:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2651E1DC985;
	Thu,  5 Feb 2026 04:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGYerrrJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047632EA48F
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 04:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770267020; cv=none; b=ekm5KqD7z/MUUhQ7XDYykTcC2arE169lwMhmsu/b8DsXs8NB9YdcGEKz8pdNmhKlpOTkaLsN2jqfcmwY5BafomgFs7h0vXq80bZRwvonoaR7QOFuSczGD+niTXwA+8eETjXldgl6xLe/oMEOcXX6GPRLWtYI7VEgqUrxxqzL5DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770267020; c=relaxed/simple;
	bh=qseW78hTkEKmEuXh780JT4GDvzvK1kCW4d7l964LbmE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=olRWCIRwawTXtZZ2k9hGDNyH7zjRK/kf9IpOKBAKBtrbm7w3ukLR9aTW30ebpM660NbD921i5YZIaa35Fga5IEj3L7ccMVlEiaRqznlcNiK+CvrFfIY0ZUOQ5IpgmqEjQz9vyrHFFM0yA186Z2n45+Sd6/h51YN6T0u4NTln0z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGYerrrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A07C2BC9E;
	Thu,  5 Feb 2026 04:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770267019;
	bh=qseW78hTkEKmEuXh780JT4GDvzvK1kCW4d7l964LbmE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BGYerrrJke3cFa10Z9xIfYqvbqt0TXf2/SKzxWEyqsnlNST/SUrF4GzClfbf8Ov8h
	 fBzNxTxL3B8exigXniyiANIzpK2L3H6cVvbVSYdOf6hjmDzE2QNMym1I39pvMqimQf
	 XS4B32dSSd7MuTkpLE/mAWnN76YqAKVA/r9hxh9ISaUFXqwz5A8pdxWXRUCe+IRGMK
	 lnlIm4FNGrA4JfSGvwCPkqv/t/eC+ZrxVL+Xp7AI3urSXHztrxBsyVuBc64gc7jLYh
	 K0BjTYBQLljFN+MENMePZS1T7YiR63htZrNMC6RodanO2eovEC+ppsWPlx1xdjz7C3
	 Ln0r7MM5cYIAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C22543808200;
	Thu,  5 Feb 2026 04:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: split tcp_check_space() in two parts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177026701757.165764.8982996972541300841.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 04:50:17 +0000
References: <20260203050932.3522221-1-edumazet@google.com>
In-Reply-To: <20260203050932.3522221-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-256954-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vmlinux.new:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42D73EE95C
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Feb 2026 05:09:32 +0000 you wrote:
> tcp_check_space() is fat and not inlined.
> 
> Move its slow path in (out of line) __tcp_check_space()
> and make tcp_check_space() an inline function for better TCP performance.
> 
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 2/2 grow/shrink: 4/0 up/down: 708/-582 (126)
> Function                                     old     new   delta
> __tcp_check_space                              -     521    +521
> tcp_rcv_established                         1860    1916     +56
> tcp_rcv_state_process                       3342    3384     +42
> tcp_event_new_data_sent                      248     286     +38
> tcp_data_snd_check                            71     106     +35
> __pfx___tcp_check_space                        -      16     +16
> __pfx_tcp_check_space                         16       -     -16
> tcp_check_space                              566       -    -566
> Total: Before=24896373, After=24896499, chg +0.00%
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: split tcp_check_space() in two parts
    https://git.kernel.org/netdev/net-next/c/309dd9942155

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



