Return-Path: <netdev+bounces-276829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JfVF8AY12lXKwgAu9opvQ
	(envelope-from <netdev+bounces-276829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 05:10:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B80F43C5F52
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 05:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B4DE3010DA7
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 03:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BAD3537FB;
	Thu,  9 Apr 2026 03:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fz6t7oEU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E08340A57
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 03:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775704246; cv=none; b=c5iABKKIXM1c/izMofNauAx+fjniNptIW+LSMi5LwdxJldu0+LSK4Q4a67MpFaYqrh6LKlHKf1f3eC3A7M8rgBvHpjaq0O0yEXVPxeNQfucKGZrSIuZU/5U51Ckm2+YAF4d7AgMC333se3Is6FwwtlcTuQtof4BGB27PBrVA37s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775704246; c=relaxed/simple;
	bh=JGTx9VwO1XXHxnoKQTK/TWF/7pkqt4Ipn/S2mmFrE20=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dJUofd4zddaSpXrLoxSxOoiyz2q9WBt2KLqCCLhrBw1oqVqPiae3SkSbq6ISazHYI219RJZw8T6Uwp58TwhyIo/Nml6RcZK0dDEQzk/gfqvse2LbPXp0K9zhrvOvnZfE6fTsBkjjhkjXNcjCItVCkCbk2hiIhGBPxzTw+jYHjMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fz6t7oEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D37AC19421;
	Thu,  9 Apr 2026 03:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775704245;
	bh=JGTx9VwO1XXHxnoKQTK/TWF/7pkqt4Ipn/S2mmFrE20=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fz6t7oEUPq8iiGxO5yrRQ7d1UV9zkGLFqx7qTfEr2sgkL+Jyg6tsgLsDaoFVhDNpa
	 R/yOkNIghlq+Nqjv9cCHMMrbyTt8+I22evMyT2QJrw5EsesG8/VtRIH+d8fCMQcPA3
	 b6vGIEfC3u/hyERGf4AwUe5PdvyD2nRouoiS2T46TFU8Hv+JfhDDH3Z9JP+H1PWABj
	 /IBZO5mRPsT81+vE2Vdf+G7qhWsPLnqU/PVAam2ZYT8bm3oWoRLKJGYPpLWmTGG7yd
	 G1I1kUipHrwvlQ3L0TuLgYfnL/P99WclKQ/Fm1k/tbSRE5obqh0cYo7DJLVPfmeAnC
	 Q3vZHC59Gv8tA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DF2393079A;
	Thu,  9 Apr 2026 03:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/9][pull request] Intel Wired LAN Driver Updates
 2026-04-06 (idpf, ice, ixgbe, ixgbevf, igb, e1000)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177570422179.975519.14795159087259405758.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 03:10:21 +0000
References: <20260406213038.444732-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260406213038.444732-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276829-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: B80F43C5F52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon,  6 Apr 2026 14:30:27 -0700 you wrote:
> Emil converts to use spinlock_t for virtchnl transactions to make
> consistent use of the xn_bm_lock when accessing the free_xn_bm bitmap,
> while also avoiding nested raw/bh spinlock issue on PREEMPT_RT kernels.
> He also sets payload size before calling the async handler, to make sure
> it doesn't error out prematurely due to invalid size check for idpf.
> 
> Kohei Enju changes WARN_ON for missing PTP control PF to a dev_info() on
> ice as there are cases where this is expected and acceptable.
> 
> [...]

Here is the summary with links:
  - [net,1/9] idpf: fix PREEMPT_RT raw/bh spinlock nesting for async VC handling
    https://git.kernel.org/netdev/net/c/591478118293
  - [net,2/9] idpf: improve locking around idpf_vc_xn_push_free()
    https://git.kernel.org/netdev/net/c/d086fae65006
  - [net,3/9] idpf: set the payload size before calling the async handler
    https://git.kernel.org/netdev/net/c/8e2a2420e267
  - [net,4/9] ice: ptp: don't WARN when controlling PF is unavailable
    https://git.kernel.org/netdev/net/c/bb3f21edc705
  - [net,5/9] ice: fix PTP timestamping broken by SyncE code on E825C
    https://git.kernel.org/netdev/net/c/bf6dbadb72b9
  - [net,6/9] ixgbe: stop re-reading flash on every get_drvinfo for e610
    https://git.kernel.org/netdev/net/c/d8ae40dc20cb
  - [net,7/9] ixgbevf: add missing negotiate_features op to Hyper-V ops table
    https://git.kernel.org/netdev/net/c/4821d563cd7f
  - [net,8/9] igb: remove napi_synchronize() in igb_down()
    https://git.kernel.org/netdev/net/c/b1e067240379
  - [net,9/9] e1000: check return value of e1000_read_eeprom
    https://git.kernel.org/netdev/net/c/d3baa34a4707

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



