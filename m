Return-Path: <netdev+bounces-279540-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1eQrAZ/S42kwLAEAu9opvQ
	(envelope-from <netdev+bounces-279540-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 20:51:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C967421FEE
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 20:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31C27301F1AC
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 18:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD033264C1;
	Sat, 18 Apr 2026 18:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUuRiWIJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA91425771
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 18:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776538266; cv=none; b=NzQBBgi/5o1p2mZR9wEqUsZGYegfM/GMYce+ej9l2TtV2R6niZrJGNRxiKVF+VMYG4XA9J570epmmq/nGK16owDLUn3gn/pl63KhbQNURt1nIm6C3uYqFVs3rmmLJH5qIyT1DQHdfBgR4ObhINv3fRAsaaKw38FTzkhe/bOIJUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776538266; c=relaxed/simple;
	bh=Q5DTuA/zPzioCH//drfyN/uLOpQo8/b0XDU/FtQ/PrI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l78HSI2mRPuKKh9qng6/7x8DA0EinF79zEhQvROKsyCL+AdzoBn5LsuReo3vZr97F0FxdVHpE/q+03iILESgywNGNlkU/rUbQC0kI7dYmmXxsozAwYtyWYZygnwEolm4Jvc+wbnHibciyz/EwNer/tYQzT51UNnkOcEB8pZor1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUuRiWIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F58C19424;
	Sat, 18 Apr 2026 18:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776538266;
	bh=Q5DTuA/zPzioCH//drfyN/uLOpQo8/b0XDU/FtQ/PrI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GUuRiWIJQb3RzuNws8wrVOCXULbXutIw+ZLnKAY9P45LjvY9He0s04n4T12sc3VlT
	 5wBIb8Zd/ihhXmGmUWVw8LXXqUvEfNSRo3efUJA54ACauxTH90/tZDgNZDszqIZTVs
	 rRbO+iiNemQk35XDWclsoY+ArXdKclMSr+mxSnFbcnBM/N1OcCXnIJcIecDnndOXrz
	 +c2Kcm7O+QQ8fb3WTsSoxo1PbZtSiQ0FamS2e/R2JjGEOalMtQ7d9fQy1yZu0CFt7p
	 dBG7i50NgcpgyFjpLNnSwtPLN7v4vhq2Kp0GYQRjggjy064AOglhBZyv8U7aNt490A
	 q1/Weozoi/1Lg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF4D380CEDD;
	Sat, 18 Apr 2026 18:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 00/14] tcp: take care of
 tcp_get_timestamping_opt_stats()
 races
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177653823280.501769.1738086546525489971.git-patchwork-notify@kernel.org>
Date: Sat, 18 Apr 2026 18:50:32 +0000
References: <20260416200319.3608680-1-edumazet@google.com>
In-Reply-To: <20260416200319.3608680-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-279540-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C967421FEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Apr 2026 20:03:05 +0000 you wrote:
> tcp_get_timestamping_opt_stats() does not own the socket lock,
> this is intentional.
> 
> It calls tcp_get_info_chrono_stats() while other threads could
> change chrono fields in tcp_chrono_set(). It also reads many
> tcp socket fields that can be modified by other cpus/threads.
> 
> [...]

Here is the summary with links:
  - [net,01/14] tcp: annotate data-races in tcp_get_info_chrono_stats()
    https://git.kernel.org/netdev/net/c/267bf3cf9a6f
  - [net,02/14] tcp: add data-race annotations around tp->data_segs_out and tp->total_retrans
    https://git.kernel.org/netdev/net/c/21e92a38cfd8
  - [net,03/14] tcp: add data-races annotations around tp->reordering, tp->snd_cwnd
    https://git.kernel.org/netdev/net/c/829ba1f329cb
  - [net,04/14] tcp: annotate data-races around tp->snd_ssthresh
    https://git.kernel.org/netdev/net/c/fd571afb05eb
  - [net,05/14] tcp: annotate data-races around tp->delivered and tp->delivered_ce
    https://git.kernel.org/netdev/net/c/faa886ad3ce5
  - [net,06/14] tcp: add data-race annotations for TCP_NLA_SNDQ_SIZE
    https://git.kernel.org/netdev/net/c/124199444de4
  - [net,07/14] tcp: annotate data-races around tp->bytes_sent
    https://git.kernel.org/netdev/net/c/ee43e957ce2e
  - [net,08/14] tcp: annotate data-races around tp->bytes_retrans
    https://git.kernel.org/netdev/net/c/5efc7b9f7cbd
  - [net,09/14] tcp: annotate data-races around tp->dsack_dups
    https://git.kernel.org/netdev/net/c/a984705ca88b
  - [net,10/14] tcp: annotate data-races around tp->reord_seen
    https://git.kernel.org/netdev/net/c/62585690e6b2
  - [net,11/14] tcp: annotate data-races around tp->srtt_us
    https://git.kernel.org/netdev/net/c/290b693ce7c9
  - [net,12/14] tcp: annotate data-races around tp->timeout_rehash
    https://git.kernel.org/netdev/net/c/71c675358b71
  - [net,13/14] tcp: annotate data-races around (tp->write_seq - tp->snd_nxt)
    https://git.kernel.org/netdev/net/c/3a63b3d16056
  - [net,14/14] tcp: annotate data-races around tp->plb_rehash
    https://git.kernel.org/netdev/net/c/9e89b9d03a2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



