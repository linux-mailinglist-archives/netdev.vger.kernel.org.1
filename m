Return-Path: <netdev+bounces-296755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x/W/KdREJ2qjuAIAu9opvQ
	(envelope-from <netdev+bounces-296755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:40:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2994465B037
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:40:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nDN3GQ4w;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296755-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296755-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0E863015CB7
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 22:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363953B3886;
	Mon,  8 Jun 2026 22:40:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3481238B7A1;
	Mon,  8 Jun 2026 22:40:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780958418; cv=none; b=OeioOVMoEoPY4fIF5OYFGdhRVfD4eWpsKGwdBzhdUO6ae1UoYHteURiifxZjMwrYwlE1v9JQEBId0rXT62oiET9wD4IfWB61q+zjZpd0fx9zm6e5roAFCQmrHQM9yll1Y4re1IESmMPpLByl0rxCbG4vYnUjDyXUZ9FVYb6LW7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780958418; c=relaxed/simple;
	bh=OACwnzi0kI0en+UEH2pxo2bVWDTgK1Uq5eYeMsjsGRA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dgPm2mmp+PSG1b5kRDc1v1V2wx3rDwvukyk7/7nl8GCSt7PP+1nOFqJZKQWhRa+jhsRznroVDbz9EVlEJ6ZvR1NjKC+tdh4j3DBC6aW4DWP1VUlYOZ5sM/8dN2/xlhmSzCXitXK0Yb0UTmlgpRlLqPpK24xvlLVbhOXnSarRQxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDN3GQ4w; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77BD91F00893;
	Mon,  8 Jun 2026 22:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780958416;
	bh=M8nOicOlTfte/KI7cVfb83QF0FdOUbxS7QionoYVBZE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nDN3GQ4wTdfyy69pVW0gsM3NBakREk0mdjhpqPH+SXHphXdt9EbT+pyQeBFoYPfDe
	 /vPn3XXniwwPExv3gZVNBN7tLYULbU/iQqyWWDY+AihQvNMKkXFxdgmPdhw2i40Y9R
	 SaY3rpMYQrwiOxWH/F4+qTusU3WxGddMw61rM024kH0yHiCnCTLaWyKbG+4U0seo6I
	 RQyxrMGVAJ9WvbZlpPQNmmmgGzlLCo7lRdGqroxB9cm6vhgoG9yd/jZz44m3gfJy2/
	 mjt2rz5mwUcyYLPwwVO7J3mOcHFw4yTuuym2C9XWmlpryJFz4rJq3StEo0Imj6uswv
	 6l7HDZfbjkKjw==
Date: Mon, 8 Jun 2026 15:40:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
 <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
 <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v19 net-next 1/9] octeontx2-af: Enforce single RVU AF
 probe
Message-ID: <20260608154014.1b7c8be1@kernel.org>
In-Reply-To: <20260605063245.3553861-2-rkannoth@marvell.com>
References: <20260605063245.3553861-1-rkannoth@marvell.com>
	<20260605063245.3553861-2-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296755-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rkannoth@marvell.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:horms@kernel.org,m:jiri@resnulli.us,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2994465B037

On Fri, 5 Jun 2026 12:02:37 +0530 Ratheesh Kannoth wrote:
> There is only one admin-function PCI device per system.
> Reject any additional AF probe with -EBUSY so the driver model matches
> hardware and automated reviewers can rely on a single bound instance.

Could you point me to a PCI networking driver written in the last two
decades which would have this sort of limitation?

At the very least you need to explain in the commit message **why**
correctly handling multiple devices in a system is beyond your
abilities.
-- 
pw-bot: cr

