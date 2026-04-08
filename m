Return-Path: <netdev+bounces-276533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAxtC8dT1mm8DQgAu9opvQ
	(envelope-from <netdev+bounces-276533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:10:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B84643BC9B7
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28EF73007BB5
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 13:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E0F3CBE93;
	Wed,  8 Apr 2026 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1Cm/gnN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F5538A715;
	Wed,  8 Apr 2026 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775653828; cv=none; b=lKUFnLyuiaa4Bv/iTstGoqB02aD2VVu8fQaCWEwsmiPG8fKd04+CsF1J7GTdFt2IDXxuqREPiPjpPxcYTJtCzgt0e5GIiVCa3jip3VEvwadzfZjSJNbXXp/sKmIDIBWnPicupmRxQ/xkIp06/cMtTPN/W4mIBk1IomCja+aNTUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775653828; c=relaxed/simple;
	bh=2jrQkvbOoMMZmUGotqn3VCNdfbae0aM9rV4pSStr6G8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i3CkJIyK0rPkBMGkAzOul9Q00ftv4t9Ul+ZE26UoTooaYDmxeJF46byQxAaoQbz4oHr+SD9cBPeN2riS4j5NOCaKbEBK+3EIkpLQj20/y/9ngng0diEcHOKjg63h1TvAtf89wuTuuwyP3yhqazrcOJYbybRVDkXaSTqbdlQYgio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1Cm/gnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB98C19421;
	Wed,  8 Apr 2026 13:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775653828;
	bh=2jrQkvbOoMMZmUGotqn3VCNdfbae0aM9rV4pSStr6G8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g1Cm/gnNxCygY4m1n8jEDLMWmqgethrpuC0WX9utoGJxqCv/pr1WVDC7Iv3SRQ3Gs
	 QfwcrXSNsMkUrNPhEuhh6X+pQ55/QL02jDsZwCMA4pUZm7znnYAuuAywaY9EyM6z6G
	 1NqxLsWwWVFS2tt7ArW2LttS1LcggruG6zauCMrfy6ek3X2HwmBZQa8vFktshzdMrR
	 lHwGHFbKI3V86fvVXb/c17ZfJjP5PNPpnXIB0lW6RNUpZFPYDJ9NuSPfsWQmk6RD3m
	 YMk97sBoiU2g7LE3Uj+zTPb4hPxAFZfNaF8gcuVCcnxAnhRKz5ohhj6Ruc0tD60w8q
	 rZxZAPxip95/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCDE3809A3C;
	Wed,  8 Apr 2026 13:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND][next] Bluetooth: hci.h: Avoid a couple
 -Wflex-array-member-not-at-end warnings
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177565380504.258768.1367030329813803809.git-patchwork-notify@kernel.org>
Date: Wed, 08 Apr 2026 13:10:05 +0000
References: <adVmLsJCQrBCMDD6@kspp>
In-Reply-To: <adVmLsJCQrBCMDD6@kspp>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276533-lists,netdev=lfdr.de,bluetooth];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B84643BC9B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 7 Apr 2026 14:16:46 -0600 you wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> struct hci_std_codecs and struct hci_std_codecs_v2 are flexible
> structures, this is structures that contain a flexible-array member
> (__u8 codec[]; and struct hci_std_codec_v2 codec[];, correspondingly.)
> 
> [...]

Here is the summary with links:
  - [RESEND,next] Bluetooth: hci.h: Avoid a couple -Wflex-array-member-not-at-end warnings
    https://git.kernel.org/bluetooth/bluetooth-next/c/710f92b5b912

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



