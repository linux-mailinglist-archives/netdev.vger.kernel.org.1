Return-Path: <netdev+bounces-286255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XTebIM5HAGqnFwEAu9opvQ
	(envelope-from <netdev+bounces-286255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 10:54:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4482503383
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 10:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF1163009560
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 08:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED93358369;
	Sun, 10 May 2026 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHhSZJ/Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A72C1BD9D0;
	Sun, 10 May 2026 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778403272; cv=none; b=dDOjtyPySDyv1HyUuwJRcWUTWlIJ3vx7Dfo5NyInH4qnMzO780bJu8nujmRb1rpmgWERnt6Mx7JG6sfn66xc6pcyYCzf3WCfcwbH5LAGLztpcbk+vAPiFqkNItFFsgf0FPLKI0HT/OpgRM1/O+I0s+UmLTBaDgYnCa/Kk3E/Pv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778403272; c=relaxed/simple;
	bh=MAQaklmd7U8b0GfjDnOUAlQ+QUbkiTVExvIOz1C9AvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpsGP4tdimKAXv5hIP645o1SM57bwPzvKuKd1lJr6vIZwRurM8/1pVJPkvbNmmuKu1nsWHxNXv8HpXmzilzIYfRGbXAohOkUBnZOSgXLtBqp/b1NBQeNkU+g7fTeTMt5GtC5eKkx0HsFMUAe6Pdq0xPJ6rLCjISgCnNX+KiyLYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHhSZJ/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120B4C2BCB8;
	Sun, 10 May 2026 08:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778403272;
	bh=MAQaklmd7U8b0GfjDnOUAlQ+QUbkiTVExvIOz1C9AvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aHhSZJ/ZCrUB2rR2anKZQfdJjz3bKjh2WUtTS3ts9y9ocC/+9PTkxJILr2o2Z0qnu
	 9uN+Tg89EWEpG/YrbTBfXPXJIARYcnRZU351GeDI4H+g3hATP5l7efUj4R6Arre2Y/
	 3Bph2Dw/ifjI25IfXcgPo9rp21OceJxCKdPOzByffVdPxxcSG9eLbh08ZcOC48KBdn
	 L2R08ojt8CvKk9zRT3R8ih8+5esUGh16Sld0q9waHxHzuZoYIXr+SvgJ8BtTkpOE5O
	 yUZP217TCZWFbWhZj2012gJ9AFwVuhgNCDuVzKMCspc+nU8JtPiQatVQnsmp1dHL3T
	 kI6jc+yupQTIg==
Date: Sun, 10 May 2026 09:54:26 +0100
From: Simon Horman <horms@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Linus Walleij <linusw@kernel.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abdulkader Alrezej <abdulkader.alrezej@gmail.com>,
	Yury Norov <ynorov@nvidia.com>
Subject: Re: [net-next PATCH v2 0/8] net: dsa: realtek: rtl8365mb: bridge
 offloading and VLAN support
Message-ID: <20260510085426.GS15617@horms.kernel.org>
References: <20260503-realtek_forward-v2-0-d064e220b391@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260503-realtek_forward-v2-0-d064e220b391@gmail.com>
X-Rspamd-Queue-Id: E4482503383
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286255-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid,sashiko.dev:url]
X-Rspamd-Action: no action

On Sun, May 03, 2026 at 03:18:20AM -0300, Luiz Angelo Daros de Luca wrote:
> This series introduces bridge offloading, FDB management, and VLAN support
> for the Realtek rtl8365mb DSA switch driver. The primary goal is to
> enable hardware frame forwarding between bridge ports, reducing CPU
> overhead and providing advanced features like VLAN and FDB isolation.
> 
> Some of these patches are based on original work by Alvin Šipraga,
> subsequently adapted and updated for the current net-next state.

Hi,

There is somewhat overlapping AI-generated review of this patchset
available at https://netdev-ai.bots.linux.dev/sashiko/ and
https://sashiko.dev/

I would appreciate it if you could look over that and address any issues
which represent new bugs or regressions. While I think that, in general,
any pre-existing problems that are flagged can be left as possible
follow-up.

