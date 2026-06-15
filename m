Return-Path: <netdev+bounces-299518-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8rQVCtcgMGoAOgUAu9opvQ
	(envelope-from <netdev+bounces-299518-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 17:57:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCA1687F9F
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 17:57:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=qE61y84b;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299518-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299518-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 206D33006B5C
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8184071FC;
	Mon, 15 Jun 2026 15:57:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C374071D0;
	Mon, 15 Jun 2026 15:57:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781539024; cv=none; b=oSMK/4fwYb04/EeoTFbW2dc+UJnizNWg64+RuJ8GpN82EJRFsjcHH4S8BlsnKGr+M3gPnnjZlXN8B3vLJlW8J8q3vZuJaGS4S6IM4cUD/0saRoTFN7Qk3+GgH9mgtjR9mn7swoC8O8X5ya5VZE0t9Fagusrq1G4gGcy6bj94LpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781539024; c=relaxed/simple;
	bh=9DlfF3EFBHkzeuQHHb/zDDjnIvxfrKX6jQr/6dSSxls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0G/FDTvm2waSe6IraEsKO6y6WXTRTtz7OWaHx2tUvpITMnNUYsTwziProX3ScfYj/X7trsHUBdlIvdXVfHW0VFPmIlDYq+rED2EYXZrjR5NBpGJx7FxnQOrXKZfps99UjvDu0X6hgzpcb+XdA0i7XwFmK23O4TMd9spO8QBLlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qE61y84b; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Nqx4b4PhavDoBw85ZcXFI5T45guTiq32b+oAUPWx6A0=; b=qE61y84bREqLZDvZuLSyxYpnPY
	tFUA0cVojuL9Z2gKT6SFOQhm0ZbtrA1pGaQsQhejzykJ/TF6SFye2iKHLjnhwSdJllsFU1L40b5P5
	f+pBSm2l7bMQZMUL4zLMfTP3yG/iNrwI76QNaM3ghlRRms6GgeVzyl4Q2wXzs7NZnIug=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZ9gE-007pQS-PV; Mon, 15 Jun 2026 17:56:54 +0200
Date: Mon, 15 Jun 2026 17:56:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: mmyangfl@gmail.com, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	de.ge@motor-comm.com
Subject: Re: [RESEND PATCH v1] net: dsa: motorcomm: add yt92xx dsa driver
Message-ID: <774d976a-779f-4f11-b003-ca3381d8cfa0@lunn.ch>
References: <20260615111235.3544282-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615111235.3544282-1-kyle.switch@motor-comm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299518-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kyle.switch@motor-comm.com,m:mmyangfl@gmail.com,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ming.xu@motor-comm.com,m:xiaolin.xu@motor-comm.com,m:jianmin.wang@motor-comm.com,m:de.ge@motor-comm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,motor-comm.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ACCA1687F9F

On Mon, Jun 15, 2026 at 07:12:35PM +0800, Kyle Switch wrote:
> Add yt92xx dsa driver supports yt921x and yt922x switch series.
> To support more switch series in the future (e.g., yt923x), the most common configurations are abstracted into switch operation interfaces, due to yt921x and yt922x share similar register layouts and operational logic.
> 
> - Merge drivers/net/dsa/yt921x.c and the new yt922x support into a
>   unified yt92xx.c driver.
> 
> - Add support for yt922x, which can operate with either 4 bytes or
>   8 bytes DSA tag.
> 
> - Not change yt921x behaviour but use common switch apis

You should comment about why you resent.

Also, you should of waited 24 hours.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Anyway, please don't send it yet again until you have broken it up
into lots of smaller patches.

You also have a lot of work to do to bring this code up to Mainline
standards. Please spend some time looking at other DSA drivers, and
network drivers. Anything your driver does which no other driver does,
is probably wrong. Please start with a small patchset with just the
core code, enough to have the ports act as independent interfaces,
nothing more. You can then submit further patchsets for offloading
bridges, statistics, trunks, ptp etc.

    Andrew

---
pw-bot: cr

