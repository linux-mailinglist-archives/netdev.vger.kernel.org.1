Return-Path: <netdev+bounces-288526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bQ0zFpDBB2p+HAMAu9opvQ
	(envelope-from <netdev+bounces-288526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:00:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92387559A87
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 02:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CFD8301B702
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 00:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4E527587D;
	Sat, 16 May 2026 00:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jneYhsdP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6972E414;
	Sat, 16 May 2026 00:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778893195; cv=none; b=VZB7wBe8eE+sUQy2u/1ucf9hEmZd73QJdPtVjhisgje8/qi158TzGCXQEMJNT1JN6RFHGw0loSbOu/kfOXcFiaBQph5Q2dFw/7/xS9G+fJWsdQhh4F9CuM9RmzbkHUtDzCPRtaXxkI4luKBL57kn77rdhmRvfm5e3NFtG7RSXOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778893195; c=relaxed/simple;
	bh=2pVJJlZ0Eb7rpBi8UOwaBVnbCd39L41vvxqv4Kv1jQo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Oj2D/6mdNRl/LmT1yOshwvoSdaYru8Epjb+1xnZwf9SUUT7cj2h8NLfHkuXVoSKcg1oOVt9mNTZVQZ/RadmBPRDNMVn1kzplYe1NVbNw+oAT7yms6hQPpLuhV+Bw2Amwz4P92WGoEetFQd2ih8O2og8ew39tYAW10mmOyEEpK9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jneYhsdP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7485C2BCB0;
	Sat, 16 May 2026 00:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778893194;
	bh=2pVJJlZ0Eb7rpBi8UOwaBVnbCd39L41vvxqv4Kv1jQo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jneYhsdPptylrKftYRJDWKr4ycQZh1MmIdMP3I6CdQsua/B1f04vku2oX2hg6tpQ6
	 I2n5hDkcMbyXmCZVTRqormnMbgExflI+fEaysGDeWKsXLuFgNWvC1DmvDX9Yxrc6rZ
	 MGV9xdKC5rItipO+ysX0LhEQKLXZCarLvbMDcK5s/JTufvWOFtON+GVCrnMuHs2Qsg
	 HSArnFFVbTXj8bK9Y24BNEnUS2pxEPFQCMBvUlMDu/iQa79O9xO1hAipUe0am4RB8t
	 SE4G7uSGbzakkUOyz04nXxO6n1F7zj70BiI3SnxwOn7cNjAfA6Z237tFfdCtz7tdcC
	 XXdbP2KCLFkTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198693930A23;
	Sat, 16 May 2026 01:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] llc: avoid sparse cast-truncates warning in
 counter
 clamps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177889320765.213149.8462629823417636008.git-patchwork-notify@kernel.org>
Date: Sat, 16 May 2026 01:00:07 +0000
References: <20260513092253.3035961-1-avinash.duduskar@gmail.com>
In-Reply-To: <20260513092253.3035961-1-avinash.duduskar@gmail.com>
To: Avinash Duduskar <avinash.duduskar@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 92387559A87
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288526-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 May 2026 14:52:53 +0530 you wrote:
> llc_conn_ac_inc_npta_value() and llc_conn_ac_inc_tx_win_size()
> clamp their counters to the maximum valid 7-bit value via
> (u8) ~LLC_2_SEQ_NBR_MODULO. LLC_2_SEQ_NBR_MODULO is defined as
> ((u8) 128) in include/net/llc_pdu.h, but the (u8) cast does not
> prevent integer promotion of the operand of ~: ~128 is computed
> as int (0xffffff7f), and the surrounding (u8) cast truncates
> back to 0x7f. The result is correct (127), but the implicit
> truncation is flagged by sparse:
> 
> [...]

Here is the summary with links:
  - [net-next] llc: avoid sparse cast-truncates warning in counter clamps
    https://git.kernel.org/netdev/net-next/c/3931012141aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



