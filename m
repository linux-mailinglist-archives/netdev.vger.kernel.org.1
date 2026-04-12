Return-Path: <netdev+bounces-277869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJHCDQ/m22laIgkAu9opvQ
	(envelope-from <netdev+bounces-277869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:35:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B70FF3E56A6
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F08F53002751
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B83832BF4B;
	Sun, 12 Apr 2026 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmOd5h7k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6885D299959;
	Sun, 12 Apr 2026 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776018913; cv=none; b=eUdp92HU2arwYDmpjRkQsmskGtkb0/ojguG0aNOCi+fv9msd2c8kUX4BIaVbOZ0nIAYOypF/ZwPaVl7YSuEMIZbOVIqXpzC15mChbzBhxkDNwZ3xapUwQF6cz6nDszl+8bRy6ra+26NPsWzj0oPgu/dnv6ivxxOEHBKfOTg8S1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776018913; c=relaxed/simple;
	bh=XPwUHgNq2qtTn7bqtP5nQ1J+tXQwpc+1SLa64zfPhOw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klasybDncBoyG386RwSUYekBs2aEbrVYdtZup8G5KIb5psLe4TMaAhm7ALhr8Z36gmfZCkBty8bJBUBWfLPMNHaYS9TYO1i0lXdInl7YFeUMxnaN59Fkb3fAu3cZ2pUacXAHIwIfRa+pPzl1mNWnQCxgEehihEbIDLKt6bW0qOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmOd5h7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01FAC19424;
	Sun, 12 Apr 2026 18:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776018913;
	bh=XPwUHgNq2qtTn7bqtP5nQ1J+tXQwpc+1SLa64zfPhOw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EmOd5h7krvO3mNhae72gv3XrC7ZetJjadFYtVxtQfdteLn/WNUuPaTqikMdYOGAge
	 uKdwL5vPC9778qAqTQvlzVteGGr9fiz0o9EKEluZr+gmo7G/On8KI31Db6x73CE9Wm
	 2hhm7807OgWCzT8AWKALT9vkkgqvuG+4jYsYEHmty5yf67Ppb1jrtQtYTRMQ3iCo7x
	 0JgM1eBdwvDi+SblBQ0PymswViIqethhPbWpKd/biUBpYu8IsB3L/cKyeP/6Hvxzz+
	 XoV9VY6piSZXukn7laSzgp7lZE3f55WzvSa67gZRHQBnNysnFcp2s1oRngn7rRUixV
	 WIKokqYjZ5c6g==
Date: Sun, 12 Apr 2026 11:35:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Nicolai Buchwitz <nb@tipi-net.de>, Heiner Kallweit
 <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] net: phy: add support for disabling
 autonomous EEE
Message-ID: <20260412113511.36272247@kernel.org>
In-Reply-To: <20260406-devel-autonomous-eee-v1-0-b335e7143711@tipi-net.de>
References: <20260406-devel-autonomous-eee-v1-0-b335e7143711@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[tipi-net.de,gmail.com,davemloft.net,google.com,redhat.com,broadcom.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277869-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B70FF3E56A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 06 Apr 2026 09:13:06 +0200 Nicolai Buchwitz wrote:
> Some PHYs implement autonomous EEE where the PHY manages EEE
> independently, preventing the MAC from controlling LPI signaling.
> This conflicts with MACs that implement their own LPI control.

AFAIU the discussion that followed was about.. future work?
So this series is good as is. Applied, please LMK if I misread,
I'll drop it.

