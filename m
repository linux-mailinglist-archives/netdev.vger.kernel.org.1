Return-Path: <netdev+bounces-260459-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBLpNRuGnWmVQQQAu9opvQ
	(envelope-from <netdev+bounces-260459-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:06:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AA9185DCB
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0B6C3174C6D
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCD037996F;
	Tue, 24 Feb 2026 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idCbTOck"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91EB37882A;
	Tue, 24 Feb 2026 10:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771930799; cv=none; b=X2eXm7a+W8zo2fQu0meopFiU8YFo98Y3IwRPPVezF88LgbEx6DuQXJp4pWtNyNiz/bG24zhBzt5hOmehY+wyMvfGzmorxLqpjYlPjFbKBclLrbv/QClRl+T1dSZ8fnq+EgbPdfA2KHEOEdPYbvGb4GmJlEagIz6DeWRzEwvZ4CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771930799; c=relaxed/simple;
	bh=386LSHBlNFd7T4k7VF6bYhFGY+tcT4lOcmBFBxlYj2Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y2N9HOALJU7kxhyjnn1WmA0RpZn3ze4oWo/azdcipyxytq8bjdixIEt4B5uksQFhxedpiuAUYFClLMjY48En8EBBkkosc7H0+0MpPnG24LDtle3+wbNBVPJ0DzgeVkWRGSKcN+MBrf8jj94OJpPTUDvfTIf24fjfYuiW6uGpGEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idCbTOck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B900EC2BC86;
	Tue, 24 Feb 2026 10:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771930799;
	bh=386LSHBlNFd7T4k7VF6bYhFGY+tcT4lOcmBFBxlYj2Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=idCbTOckONKq6EM/zljhci+ONJy5DUJWhmuFmXabcVgWSrQXMK9HpN6KdiWYrL6M3
	 sCVce/IXZpKlfPtKPbdDWVV2zrmeilGUAm+fHfHz87nVcEBwkXtUjN5/OiBpMrQX2w
	 nEE7N5vx2fuxyUsvVkkfLSqtJpf3pz5qH3PIIiFBisWmWiJ9XFy7CMBSHM8KvOqro/
	 5FMmCT8/qbtCmgNgXmvt6IrPsr/sOReZipK5EgCzD2dKW/1oedv5tRkUl8gmIDF7LT
	 PxDYRIhpwz3HAbezt0OVjZ5Mb14FIINj2t6fKKWlk/0/POdWcECvgSld/KnMyoyo/b
	 6gOWH0HA3XInQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EBD3808200;
	Tue, 24 Feb 2026 11:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: usb: pegasus: enable basic endpoint checking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177193080555.3448395.2288227716514692633.git-patchwork-notify@kernel.org>
Date: Tue, 24 Feb 2026 11:00:05 +0000
References: <20260222050633.410165-1-n7l8m4@u.northwestern.edu>
In-Reply-To: <20260222050633.410165-1-n7l8m4@u.northwestern.edu>
To: Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: petkan@nucleusys.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-260459-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 44AA9185DCB
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 22 Feb 2026 05:06:33 +0000 you wrote:
> pegasus_probe() fills URBs with hardcoded endpoint pipes without
> verifying the endpoint descriptors:
> 
>   - usb_rcvbulkpipe(dev, 1) for RX data
>   - usb_sndbulkpipe(dev, 2) for TX data
>   - usb_rcvintpipe(dev, 3)  for status interrupts
> 
> [...]

Here is the summary with links:
  - [net] net: usb: pegasus: enable basic endpoint checking
    https://git.kernel.org/netdev/net/c/3d7e6ce34f4f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



