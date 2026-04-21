Return-Path: <netdev+bounces-280095-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEL8LsBm52ld7wEAu9opvQ
	(envelope-from <netdev+bounces-280095-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:00:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B996443A602
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E457300DEF0
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 11:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A6439C009;
	Tue, 21 Apr 2026 11:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nucleusys.com header.i=@nucleusys.com header.b="Ixwmcvox"
X-Original-To: netdev@vger.kernel.org
Received: from lan.nucleusys.com (lan.nucleusys.com [92.247.61.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0384E38C401;
	Tue, 21 Apr 2026 11:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.247.61.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776772796; cv=none; b=KvLgI4VsMGotRubq+FNZNVGvkRkhgu9RQy8+PqM+ajnsmFhJBFaVx7aWtN1duU9ldCK0qP/43eglC4GtzJU8R+prwNoAaMYvFgXCmIkMIgoB6YBqy7SQjly1ni/EghTwNn7JVB7LACJpLBa/1Vdy9AWtHHHqwdcLQuA+8QsAjPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776772796; c=relaxed/simple;
	bh=T25uiAUIhbJ8joCG1bS4JMt3QxHeB8To+1GhGxAJsGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aah2Yqoz0VPgjEOFQkm9dG1cPuTVCV4UutLrkA5cbjEg+pIly/r5V4m0TLphuyd9jh9G+TPbWW6xUENMHJxPEM6/s0WfJtsn198LXyLUKCF3hgwCnm0wVqDRPJqJ+ajmtZ+qOZbO7AgyLzfshTX3XCTl+KCZk9D5Y6eRNny3/x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nucleusys.com; spf=pass smtp.mailfrom=nucleusys.com; dkim=pass (2048-bit key) header.d=nucleusys.com header.i=@nucleusys.com header.b=Ixwmcvox; arc=none smtp.client-ip=92.247.61.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nucleusys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nucleusys.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nucleusys.com; s=xyz;
	t=1776772478; bh=T25uiAUIhbJ8joCG1bS4JMt3QxHeB8To+1GhGxAJsGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IxwmcvoxzBfJzaTDaKRsB8D5qcNsRMa86Vsauzmln1YTZaH3hDLlCllrP+gTJX/e3
	 /PmTB9VL2doNXsEKaJ1CwwihDiKi2ImFcTcxnRG+a7xE1dGt9NuWvjpqcYpqrGcLpe
	 4FR/OF2YlYklYwy0E+ITpQzuCffppG8z5mrrT/XMYE/b9huDq7Ei8RRtrAbdKa3wVy
	 n7VZjB6dsbhhZLBg/bC/RlgdYvTNnyBLu1DJVEyJ9FyRW/WUvPA2q0aF/ZB9384hj1
	 s9nzSnqAKKarnM/9GMCnN5N1tZ9LFsUqYxujchi3rTxielU8yy7gXonwmbEyQXigoS
	 S9qn1d9HdBoDQ==
Received: from bender.k.g (unknown [192.168.234.1])
	by lan.nucleusys.com (Postfix) with ESMTPSA id 32EED3FB18;
	Tue, 21 Apr 2026 14:54:38 +0300 (EEST)
Date: Tue, 21 Apr 2026 14:54:37 +0300
From: Petko Manolov <petkan@nucleusys.com>
To: Morduan Zang <zhangdandan@uniontech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: rtl8150: free skb on usb_submit_urb() failure
 in xmit
Message-ID: <20260421115437.GB15539@bender.k.g>
References: <678BC10BB9E39322+20260421111025.15833-1-zhangdandan@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <678BC10BB9E39322+20260421111025.15833-1-zhangdandan@uniontech.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nucleusys.com,reject];
	R_DKIM_ALLOW(-0.20)[nucleusys.com:s=xyz];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280095-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nucleusys.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petkan@nucleusys.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bender.k.g:mid]
X-Rspamd-Queue-Id: B996443A602
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26-04-21 19:10:25, Morduan Zang wrote:
> When rtl8150_start_xmit() fails to submit the tx URB, the URB is never
> handed to the USB core and write_bulk_callback() will not run.  The
> driver returns NETDEV_TX_OK, which tells the networking stack that the
> skb has been consumed, but nothing actually frees the skb on this
> error path:
> 
>   dev->tx_skb = skb;
>   ...
>   if ((res = usb_submit_urb(dev->tx_urb, GFP_ATOMIC))) {
>           ...
>           /* no kfree_skb here */
>   }
>   return NETDEV_TX_OK;
> 
> This leaks the skb on every submit failure and also leaves dev->tx_skb
> pointing at memory that the driver itself may later free, which is
> fragile.
> 
> Free the skb with dev_kfree_skb_any() in the error path and clear
> dev->tx_skb so no stale pointer is left behind.

Another approach would be to use skb_copy_from_linear_data() to a static buffer
and free the skb right away.  Take a look at pegasus_start_xmit() in
drivers/net/usb/pegasus.c.  This comes at the cost of yet another memcpy,
though.

The above is not to say i don't like your current approach, just FYI.


		Petko

