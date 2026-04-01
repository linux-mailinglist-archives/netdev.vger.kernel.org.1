Return-Path: <netdev+bounces-273865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEcuF8OJzGlXTgYAu9opvQ
	(envelope-from <netdev+bounces-273865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:58:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 621C837412B
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 25DE43014913
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 02:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8938F3624C4;
	Wed,  1 Apr 2026 02:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdUfbYsK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA7E2773D8
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 02:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775012119; cv=none; b=uz+KuDJ6niiPEIsxykE+WIyiQY1sBG6td2fVb/9mob8SZWqLV9ntIp8Vvo+vs7+MS8flwqkSxMhWdCxrYBwMReEajmL/5oBf8e7OcmWN/kaNCYCy7sGJcLtC6uFuIAv25Yzf9IwRPYlmL9fasoa+qzWjgbmh+FXq6P9lJx4sLi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775012119; c=relaxed/simple;
	bh=4XjTME/d/I8gLXIsJGfAl48KenIFhlaqtwLW+oniLRo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H/U4lonJcLEgQeWrMVOLwoRz4vRMbMVSh0eCo7RweYCXllg4EYs6mniczfKAodoZ817Ercv91PIECJQFSzT+QHtH6g12HihpC9fAPnATJCXj6Erk5LUfo8hbQRzebHzyRkbDD2x75/BmyzDU5SvEpAsG4VqYZ4KSbrShPI3P8UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdUfbYsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB66C19423;
	Wed,  1 Apr 2026 02:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775012119;
	bh=4XjTME/d/I8gLXIsJGfAl48KenIFhlaqtwLW+oniLRo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tdUfbYsKefMuyiVs2mgJ/gF8HhsnqoCu1+xaLfv05W114W+ZvzvhR5gnsvKcJY6Gq
	 xXs0i9O8ZEdjPa6oEEkmo2IICbEhME2ZSOeO7Ew/bM7d3G+4v8pvJT0LolzAYZa83E
	 gz5uxMKFoSnJpys44Va28vYWe3HvwnDBRnrS+ozpz1/LJPKq3XIYzt97tErletIZ0D
	 Mf5OA7QhBgvyX+tgGgYVytNSgIw1OpK+uwLcZw0yTHo5b+VdA0fWfTk5lO/DLsypeA
	 b33zxzWh6lpWtUK1pu9hHl9cens64P0lGQ31dgmTbCrzINZFvf2/kMvSnEC/OYWoSR
	 ZZLzuX5Fp+IHQ==
Date: Tue, 31 Mar 2026 19:55:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kevin Hao <haokexin@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] net: macb: Remove dedicated IRQ handler
 for WoL
Message-ID: <20260331195517.68108163@kernel.org>
In-Reply-To: <20260328-macb-irq-v1-4-7b3e622fb46c@gmail.com>
References: <20260328-macb-irq-v1-0-7b3e622fb46c@gmail.com>
	<20260328-macb-irq-v1-4-7b3e622fb46c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273865-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 621C837412B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 28 Mar 2026 18:17:48 +0800 Kevin Hao wrote:
> In the current implementation, the suspend/resume path frees the
> existing IRQ handler and sets up a dedicated WoL IRQ handler, then
> restores the original handler upon resume. This approach is not used
> by any other Ethernet driver and unnecessarily complicates the
> suspend/resume process. After adjusting the IRQ handler in the previous
> patches, we can now handle WoL interrupts without introducing any
> overhead in the TX/RX hot path. Therefore, the dedicated WoL IRQ
> handler is removed.

Couple of sentences on testing (platform + flows) would be great here.

