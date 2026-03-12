Return-Path: <netdev+bounces-267211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJJsCKols2nMSgAAu9opvQ
	(envelope-from <netdev+bounces-267211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 21:44:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF262797D5
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 21:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7227304F1A1
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 20:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D78A39937A;
	Thu, 12 Mar 2026 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3lwowGz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC1435A3BA;
	Thu, 12 Mar 2026 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773348014; cv=none; b=ul5BK/oHmClWd2Pf9brmTEBNQEmWZbqQXlKCWy8C82udumt+0LsZks5/oEqLPQu1S+08T8TK2/f9IBYfHkic9ApKC5d07udlA+IdWV2ztG/gwReRSxXnVX+PRQtZzctnTK8DPPucjJ73wRcw8ES0fiGO1E8q5iQhLoLdw4dY2wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773348014; c=relaxed/simple;
	bh=vZt4PZoc19xqDusWpGughBjwOf/2j8qR1VrA18xVyH0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RPck2wwrmvuSNDkdFBEuIrBUrhKJDdoNzvgw4/rwIcxnHpKsrytQysDl6C3vQwyt/qIfjpXTsQzYn1ep0j6XcLgdyDsTqR029FTFntBCN0bmS9lT05E6jU2IC+y4Cgybr29fbnVEv+7FIgWQA6uW/uLad4jVgIpWduWAWw17Rfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3lwowGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7B7C2BC86;
	Thu, 12 Mar 2026 20:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773348014;
	bh=vZt4PZoc19xqDusWpGughBjwOf/2j8qR1VrA18xVyH0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C3lwowGzG+acbpJG2HrYTOtFDaajebXU2e+4cq/BTkHCEAqd+B3XqJR4jnsWM+7Mw
	 DBsswVActKjyr8F5aaMWwlgjhns7/LrhpdSX/b0yEoibLK+9OsS98DK4HvknFRe2lc
	 UTQVRifAqpec0nA/mbhyHBMhIE1Uesrl94XFSPrLBcHPHVv9PG44M1y5cFPlqARf6C
	 +bkDm9oOAZK9Tr4gHLr4CPfLZC6hY/jN+hykVi+BvkmXUSsUYsn4CWDGxITHhwxcZz
	 PTg10C8mGoNOZpaz+U2DX/p0mKy7lu6hqLomX4cFTF/YEd7sDyqhQwD82/Zob5g7So
	 jN52nkzSZWcQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE693808200;
	Thu, 12 Mar 2026 20:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3 net-next] net: xgbe: use device_get_mac_addr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177334800929.549113.17311063509925018044.git-patchwork-notify@kernel.org>
Date: Thu, 12 Mar 2026 20:40:09 +0000
References: <20260310194647.3794-1-rosenp@gmail.com>
In-Reply-To: <20260310194647.3794-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Raju.Rangoju@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267211-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0DF262797D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Mar 2026 12:46:46 -0700 you wrote:
> device_get_mac_addr is basically device_property_read_u8_array with an
> is_valid_ether_addr call. Allows just checking for ret.
> 
> Remove XGBE_MAC_ADDR_PROPERTY. device_get_mac_addr supports more
> properties than just "mac-address".
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> 
> [...]

Here is the summary with links:
  - [PATCHv3,net-next] net: xgbe: use device_get_mac_addr
    https://git.kernel.org/netdev/net-next/c/29ca18505d58

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



