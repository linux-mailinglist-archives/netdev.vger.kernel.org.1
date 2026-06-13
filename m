Return-Path: <netdev+bounces-298916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vjYVI7YMLWq/ZwQAu9opvQ
	(envelope-from <netdev+bounces-298916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 09:54:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A15567E0A3
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 09:54:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=t1JQej0W;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298916-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298916-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69133300A488
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 07:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF0B36F916;
	Sat, 13 Jun 2026 07:54:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E557175A81;
	Sat, 13 Jun 2026 07:54:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781337266; cv=none; b=jRCHTHM89rczHNcxVzTG6hvxAfAZoIaVc+eN6CKM6ekM33Xfu9+auo5gLRlqxhk/JrejlNlbvyJaAiqdZVOLbao+q9UOJxZLvPKIGva6Uqk6Badf3m5poTOwdkzUtkCPbzCq2ne7rJametpRyDU0uaxpkk9b3w8G2hOp0fX9CK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781337266; c=relaxed/simple;
	bh=I7TM6p7Jd+LMycfsbvG9o53bN+61uM7hWmSeH706uGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNCqJ9FkpmZfMZWU3/c4jDhfFIQ8IA8uxTonui3S+qsO10IjQglg8OaFF1nVJ7ZVtOngoGtyEHMHS9BXu3hcwwdxP+rQNXW5yV9vfuRSeFjvPIiqr/iJdbHmtNlZRL/eyOqFV0InDzZkDfIjYehL3+Z9kJuvjSiQcsqAYlx//r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=t1JQej0W; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jKr6D0QomrXndRUM0kTG+EY+S4tjgLHhIqD9NsgnK+8=; b=t1JQej0WP+uA8ctP2eqhWVi1Is
	LeuVqI1nI9iXHR4N/INYtri+j+tIdmlqT4EkBrOU3Ce1Em93h+QmJJbRKjwrY5demAueHPaxODGZR
	cYJ8Kz2w+JQ05eZcbqQGQhCSMyq2adyC36CpTQ+s4EzOGjaG492rjErQubowflSnI2xE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wYJC4-007RtV-20; Sat, 13 Jun 2026 09:54:16 +0200
Date: Sat, 13 Jun 2026 09:54:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Gabriel Ramos Barbosa Mota <maguraa53@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, deller@gmx.de,
	fero@drama.obuda.kando.hu, netdev@vger.kernel.org,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: net and video: remove legacy 16-bit and non-x86
 hardware drivers
Message-ID: <d66c7e93-b39a-4e79-b047-528e094b51d6@lunn.ch>
References: <20260613033138.601841-1-maguraa53@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613033138.601841-1-maguraa53@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298916-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,gmx.de,drama.obuda.kando.hu,vger.kernel.org,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:maguraa53@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:deller@gmx.de,m:fero@drama.obuda.kando.hu,m:netdev@vger.kernel.org,m:linux-fbdev@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A15567E0A3

You need to commit message to justify why these should be removed.

Also, please remove each driver one by one, so that if there are
users, it is easier to revert.

Please also look at the discussion about these MAC drivers over the
last couple of months. We discussed removing some of them, but they
still have users, and one of them gained a new Maintainer.

    Andrew

---
pw-bot: cr

