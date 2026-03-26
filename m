Return-Path: <netdev+bounces-272003-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJPyOg0gxWnr6QQAu9opvQ
	(envelope-from <netdev+bounces-272003-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:01:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D022F334DA9
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26500303A86A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E25366DCC;
	Thu, 26 Mar 2026 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESl97Qfz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0FA31F9A6;
	Thu, 26 Mar 2026 12:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774526423; cv=none; b=INPRChZDNRPmZ97vpJSHVKtcc1nG7eZw9MGamwUk8sgGfIxCNG5Ju/t8QVldyVohVHBBaRksLWINvMe7j4xT7EJM4q9uNqzMSrWWOEAnddaVNhntmIT0Eem6tDcWuTP7yRBf8s8PmiUgpYi+EujbahDq4E5YQ94JbJWX1cijxOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774526423; c=relaxed/simple;
	bh=u2HJmS/78KG7FoybFH+fCZmDSRZd13BgRzNbeZyfrKk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y3MmpGPkmc0Tjmbcs81SOmC1hhUiAmW/tH2lbXhAHmpVjt8J/GXT/Rlag7bUCeijH0nW0bS4Awpr/nri4DrNDh5eCs6HJPFdQD3UCuLu4YLTZctfAckfDn9k54xlVTVetNUd59bcxKVh/OeY1fKa9WbESZiwN7Z4aUP+zQdRLwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESl97Qfz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA2CC116C6;
	Thu, 26 Mar 2026 12:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774526422;
	bh=u2HJmS/78KG7FoybFH+fCZmDSRZd13BgRzNbeZyfrKk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ESl97Qfzgv/NASh+RLt9v64k/t2hcJI1lA3HRFN1WIpBcQStEKirSqkSTjDuHraoA
	 YEn8Ytgy7KJBFC8qgrQonwh30OsPFOa7ZiNGDgDcYGfEcC0UpuNv8aWBy4ciwmfLat
	 hNTNQUQr5ODoPyH1edhPyaYIkV97zGGZInHMhHt0C8Vuv9RKpZH7PPjkdyFHevJdPv
	 +b05iWsSn48bgcmuaJFqPatJI63Ziw5m3v0sveETyqvxm4iYm/cMR/k7Rbitdk0RRC
	 c9iZrUjypX+NNDGqq0OyuNSqIxTbwDeRaLWnpi8x0hvnAFXjHfKc8SsjvDRfh2aa75
	 ZzsZy9y2i4Gkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E0B39E961D;
	Thu, 26 Mar 2026 12:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/3] net: dpaa2-mac: export standard
 statistics
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177452640929.2519455.2404595307977667457.git-patchwork-notify@kernel.org>
Date: Thu, 26 Mar 2026 12:00:09 +0000
References: <20260323115039.3932600-1-ioana.ciornei@nxp.com>
In-Reply-To: <20260323115039.3932600-1-ioana.ciornei@nxp.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272003-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D022F334DA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 23 Mar 2026 13:50:36 +0200 you wrote:
> This patch set adds support for standard ethtool statistics - rmon,
> eth-ctrl, eth-mac and pause - to dpaa2-mac and its users dpaa2-eth and
> dpaa2-switch.
> 
> The first patch extends the firmware APIs related to MAC counters and
> adds dpmac_get_statistics() which can be used to retrieve multiple counter
> values through a single firmware call.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/3] net: dpaa2-mac: extend APIs related to statistics
    https://git.kernel.org/netdev/net-next/c/fbf3fecf6ae1
  - [net-next,v5,2/3] net: dpaa2-mac: retrieve MAC statistics in one firmware command
    https://git.kernel.org/netdev/net-next/c/d369154d9d7f
  - [net-next,v5,3/3] net: dpaa2-mac: export standard statistics
    https://git.kernel.org/netdev/net-next/c/dd1d4ccb8602

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



