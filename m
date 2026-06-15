Return-Path: <netdev+bounces-299593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FXhPHuxXMGqbRwUAu9opvQ
	(envelope-from <netdev+bounces-299593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:52:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 78745689982
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:52:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AcwldZtp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299593-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299593-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BFB233018CC7
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC943B71B5;
	Mon, 15 Jun 2026 19:50:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51353B6C15;
	Mon, 15 Jun 2026 19:50:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553040; cv=none; b=l9NyZr1kx6OEKC0o7Y+UVd7so7F930NEK7KIM8Ro0RnVhFuXb7PpcK3va5tpAtfD3cD2Cv4SQseBu6rgPU0z+51SBGRV4RIwmPI873Lv/bqG2OGw84T/Z6ZrvCjksxwg3FmfvxosLFrO/YdFopZRe7GaUjzg5I/pTyWt8+dsWIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553040; c=relaxed/simple;
	bh=+zjYenbvR4hNz5hqUt6lf0xQGmgyAdIvyxvP78gNJYY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XnLYl7vn/ii14AobOlltM9XkaWHPWux/9tetUtr624hYzip+EUbVhAlOdBVZGrHYArjaqtfGToKffRJsjKOx0iq5plwFFTOWT5KrwEaSa1N2Wh55g2i0UbT8V9d9AIS7nQINLGS9saxZDnL6o7vVrNqBhCbo5UqJ1nM3qHnJYPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcwldZtp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845DE1F000E9;
	Mon, 15 Jun 2026 19:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781553039;
	bh=HRb69Vt9qNCZG1VZ44TyeKMWLcVltyKO5fVS6+m5V7U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AcwldZtpKn6zPwV7MP0aaZWL0uPypjav9RX69UgvoCa5ETTRQFqmhE8hVhtK80UDy
	 cda62i3QRi/1SVjdDxU/GQ0ZavfqwawupQxijA4vzE7Cv7VtdXOzwH5r941JSYYID8
	 nQ7cBIZ0xzHvGAKX5BTyv0SX+QqdNBFEbmqHQEsOYDkZp275GMW+6NFxaD6RjqcHP7
	 VyYGXQeqp3IEOqrf4yFXzTQFI8yuAa1S84lpzNJ0WATYrEaBvhdYJPg7TW/38bb5NU
	 2RxGvA1HJ+cvRbUderwq/o7LJRZc8jD8amCjmlUgDH02sdKhVh5heTKZqkUQJYnXQz
	 x8B7YeTMjgXLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09DD3839A06;
	Mon, 15 Jun 2026 19:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: hellcreek: replace kcalloc with struct_size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178155303438.269508.7505045066778798171.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 19:50:34 +0000
References: <20260608045640.5172-1-rosenp@gmail.com>
In-Reply-To: <20260608045640.5172-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, kurt@linutronix.de, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linutronix.de,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-299593-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:kurt@linutronix.de,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78745689982

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  7 Jun 2026 21:56:40 -0700 you wrote:
> One fewer allocation for the priv struct.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/dsa/hirschmann/hellcreek.c | 14 +++++---------
>  drivers/net/dsa/hirschmann/hellcreek.h |  2 +-
>  2 files changed, 6 insertions(+), 10 deletions(-)

Here is the summary with links:
  - net: dsa: hellcreek: replace kcalloc with struct_size
    https://git.kernel.org/netdev/net-next/c/e3d202a1ed7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



