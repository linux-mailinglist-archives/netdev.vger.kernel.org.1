Return-Path: <netdev+bounces-259000-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBU+BuhHlGn0BwIAu9opvQ
	(envelope-from <netdev+bounces-259000-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 11:50:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8583714B00B
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 11:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 863D2301CC5B
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 10:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A85329369;
	Tue, 17 Feb 2026 10:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQhKWL10"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44D72D8DB8
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 10:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771325413; cv=none; b=tM9U1nVcbFeNuxAAtxnv1FEAnXNUXZfJMCblb77QUhNvkQBdnvVIuIFbenIL2fxIYf8sZoouucvucaH5/HLX31XPCrXaoJ14DeXEl2LMRGpk9PNJqTZ25TEQqbHHdTTlBtHUUIT8lSmoPRF5M6KUyIr6bo/JccVAAfDsMNZxFWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771325413; c=relaxed/simple;
	bh=PC5p/CDAwIVMjtZM3I/7AqMbPdgPhW+eyEXIKLydqac=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IXzhSxnQ3+Tl2MbcudYFMj2BjoDnR6jK0XpMCO7+KtaMX4OLdNme7dL2NyOyGJP362jq32aBpySNqNCK6zsLkJ4m3jVToymPZLYN0aM7+A6Wk0LlQ55qyc+ixYpMlS/ueDoB1xdr+PbMP2qLv4UQABK4qhU42kQ4CHTeW75UVtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQhKWL10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53633C19423;
	Tue, 17 Feb 2026 10:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771325413;
	bh=PC5p/CDAwIVMjtZM3I/7AqMbPdgPhW+eyEXIKLydqac=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hQhKWL10LJc191vpBUntQGiGavg0K7rQJEa+DcuWNVqoeiWAxS2+2SYKbeH8sszaD
	 9Cm7TYINZJ1y2GtcL2oo+8qiBviR4aVBakmlAiOLj68MuzPujy0j7+1jWpa6sh/zoQ
	 sV5qrsPf9i5tPLq2R97AekKhL+C1I4Fb/VzjE2ca5NwbNDYpkstJsEas5apklB7uCR
	 lwiM3c+2rgFVYWiimFyelIyirbO2FXRZqk+a7rExDizohZzrP70TXtq4W1vXSIaXMi
	 fyF2niRgmwcPbjIzXUCFCZiAgL+BXJc425ecjEcsvQb55O/sPSsimHSpadMp2Zw1Ml
	 jgaKKprWqReyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8539A380AAD0;
	Tue, 17 Feb 2026 10:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ovpn: tcp - don't deref NULL sk_socket member after
 tcp_close()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177132540508.17858.16179352070683627641.git-patchwork-notify@kernel.org>
Date: Tue, 17 Feb 2026 10:50:05 +0000
References: <20260212213130.11497-1-antonio@openvpn.net>
In-Reply-To: <20260212213130.11497-1-antonio@openvpn.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 sd@queasysnail.net
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259000-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8583714B00B
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 12 Feb 2026 22:31:19 +0100 you wrote:
> When deleting a peer in case of keepalive expiration, the peer is
> removed from the OpenVPN hashtable and is temporary inserted in a
> "release list" for further processing.
> 
> This happens in:
> ovpn_peer_keepalive_work()
>   unlock_ovpn(release_list)
> 
> [...]

Here is the summary with links:
  - [net] ovpn: tcp - don't deref NULL sk_socket member after tcp_close()
    https://git.kernel.org/netdev/net/c/94560267d6c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



