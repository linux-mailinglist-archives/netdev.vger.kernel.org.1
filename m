Return-Path: <netdev+bounces-276772-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eINJAVII12myKggAu9opvQ
	(envelope-from <netdev+bounces-276772-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:00:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 734113C5691
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E7C73019121
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 02:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3251F4C8C;
	Thu,  9 Apr 2026 02:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLAewpr5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEA72BB13
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 02:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775700046; cv=none; b=Xc6gqWvFvo7YYoP9kujkuDd7WkV3ufOCz3xZTzuoTxzX0ZEQjQNncTOVzYKJih+/Zk4CUz3lp3G1h80Rzbk5jiVxHvHAjb6EHALA+eCTCgAw5n1KNotTCrYEF75nWWy60IRRpp7lQbFgMoGAdjXDtWLgbVPv8LjUZas7zf4axOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775700046; c=relaxed/simple;
	bh=NqCqoxTlJGUsqP6wQX+3pm+KUwSuwEiblLkFYcUEGJQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aFBCuTkU9pLQNk0YAuDvuTbNgeqDrAjVbmlBhtN1TK7dVP+oPkctImXq6gLtvdmA+UPZaXMDZkBHLPt3cZAuu5fLH55Y2MUt0T6j8ZQ1eitaBUwJkyvZ0KGq0uoDQdNvWX4K+rou5ePVO/Mf2A2ks6XMoGYjKjYeNSUOQUbaERw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLAewpr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C68CC19421;
	Thu,  9 Apr 2026 02:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775700046;
	bh=NqCqoxTlJGUsqP6wQX+3pm+KUwSuwEiblLkFYcUEGJQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CLAewpr5ErzebWhIt4H88iKvyj1yYnnrzsVRzfitdBP2sFcXEO6mxFRcxmolx//AE
	 vhp7vd+63DmO0y88qhcZulJQd00e9Qv4hZbYthGvP9CNrO+6NphkW8ZC/lgc0eRj8U
	 TmDXzd2tImSCLr/65dV7Nmr2Jg2SICOMgNpNowOWD5kWa86axxkNig8z0udWrL/05t
	 VyAMtQFg2bfU3+VxxN17WN44lKgzX8dEuWMahPpbLnT5xHSASbOHmLBlPWHYJdjMa1
	 KLpIMI6Jy6fCf60QoGliZwj1bsVy5e12GP2ir4hypMiNICH2o9byfz3iehHw5wo3Zm
	 uZuiflgz2V3Uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE163930793;
	Thu,  9 Apr 2026 02:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/8] xfrm: clear trailing padding in build_polexpire()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177570002230.953143.9369644013047810016.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 02:00:22 +0000
References: <20260408095925.253681-2-steffen.klassert@secunet.com>
In-Reply-To: <20260408095925.253681-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276772-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 734113C5691
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Wed, 8 Apr 2026 11:58:57 +0200 you wrote:
> From: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
> 
> build_expire() clears the trailing padding bytes of struct
> xfrm_user_expire after setting the hard field via memset_after(),
> but the analogous function build_polexpire() does not do this for
> struct xfrm_user_polexpire.
> 
> [...]

Here is the summary with links:
  - [1/8] xfrm: clear trailing padding in build_polexpire()
    https://git.kernel.org/netdev/net/c/71a98248c63c
  - [2/8] xfrm: account XFRMA_IF_ID in aevent size calculation
    https://git.kernel.org/netdev/net/c/7081d46d3231
  - [3/8] xfrm: Wait for RCU readers during policy netns exit
    https://git.kernel.org/netdev/net/c/069daad4f2ae
  - [4/8] xfrm: hold dev ref until after transport_finish NF_HOOK
    https://git.kernel.org/netdev/net/c/1c428b038400
  - [5/8] xfrm: fix refcount leak in xfrm_migrate_policy_find
    https://git.kernel.org/netdev/net/c/83317cce60a0
  - [6/8] xfrm_user: fix info leak in build_mapping()
    https://git.kernel.org/netdev/net/c/1beb76b2053b
  - [7/8] xfrm_user: fix info leak in build_report()
    https://git.kernel.org/netdev/net/c/d10119968d0e
  - [8/8] net: af_key: zero aligned sockaddr tail in PF_KEY exports
    https://git.kernel.org/netdev/net/c/426c355742f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



