Return-Path: <netdev+bounces-303394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LZ0SAXVGRGoArwoAu9opvQ
	(envelope-from <netdev+bounces-303394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 00:43:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 437816E8768
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 00:43:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QiGzyGF6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303394-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303394-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BE7B3014C33
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 22:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723042DC765;
	Tue, 30 Jun 2026 22:42:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592E040D574;
	Tue, 30 Jun 2026 22:42:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782859377; cv=none; b=qM77HRUBQpoKm83jHKnM3w5DlThJtxb3RkLgywyCjSHoKq5Nluh9UCc4l3KrvLuRZkHUv1fZYjMahay6Vw5u6I+FgbYZ11vwyWEoPllYQuUv6vOoGin/9PpiMJG5eyxHQMigePFYWG7JHxn9VjEQZ75Eksc7kATApeSv+wslYsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782859377; c=relaxed/simple;
	bh=luNVmqhdNWNPyAJ0G9onacvp8OC3uiAo1Jp3h3h/H7w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oA7pu7kivJd8JJcJeGxrO8iugGiUdvaDbruJdwcaNvBw+cPbZmtjrCtujNNQP3AVYxbDKYCN+lFxOsqzoaLBHfFp3Ws/XWJSMzZfvKUUumAoLrvO55u1v9jzxE2mlk5J3Zohgn0A82Jfffo4C2cwYevI6GLNFMBr1laSDFvJZhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiGzyGF6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10471F000E9;
	Tue, 30 Jun 2026 22:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782859376;
	bh=kGD5WRMQdZ0R+3egv71JkQENkPVVjj9qHKXmH1pqyNM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QiGzyGF6P7Iuj+S3oUqZ8t96qYBQszc+u7XoKV1SPrGYJG73TtkADOMrh7VfonEpT
	 KgCYhOUEUjIeSm7r5IzOcxZKnFe+zzdPqzcY7aaBU4NwV1lWkMZGX3NH5S4ndXDsq2
	 yaFLhDtlc+ZhQ6t7Ibha5528oMpD/bsvtRWc6uQ7iwvnuqPt+6S2NkDNxJ/g9VTFkZ
	 LypyibTSbTu0nEb53RpRH4YqReCXtqtklKyC8TVwMjcUToJl1HRU2upqIm+LHxYTkW
	 6zC3tSz30EKthKaIUx+BT1YmMmUnmb9vY7h+8jApw/e81R+1KFtLPvbAOOFfJ6+Nb6
	 qHmUICs7XUcQw==
Date: Tue, 30 Jun 2026 15:42:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Tianchu Chen" <tianchu.chen@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net: usb: cx82310_eth: stop parsing reboot marker as
 packet
Message-ID: <20260630154255.2954c33a@kernel.org>
In-Reply-To: <e87b8ecf4bbcf87635d144508bf35377dd5397b3@linux.dev>
References: <700e16e9523d7f1299b00df75b13a3c66b6e517b@linux.dev>
	<20260629174458.6ebf647d@kernel.org>
	<e87b8ecf4bbcf87635d144508bf35377dd5397b3@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303394-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tianchu.chen@linux.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 437816E8768

On Tue, 30 Jun 2026 10:30:53 +0000 Tianchu Chen wrote:
> June 30, 2026 at 8:44 AM, "Jakub Kicinski" <kuba@kernel.org mailto:kuba@kernel.org?to=%22Jakub%20Kicinski%22%20%3Ckuba%40kernel.org%3E > wrote:
> > On Thu, 25 Jun 2026 15:32:04 +0000 Tianchu Chen wrote:
> > > From: Tianchu Chen <flynnnchen@tencent.com>
> > >  
> > >  Discovered by Atuin - Automated Vulnerability Discovery Engine.
> > >  
> > >  cx82310_rx_fixup() treats an RX length of 0xffff as a device reboot
> > >  marker and schedules work to re-enable ethernet mode, but then continues
> > >  processing the marker as a normal packet length. This is an out-of-bounds
> > >  heap write controlled by the usb device.
> > >   
> > Where? Can you be more specific in the commit message? At a glance 
> > the accesses seem to be bound-checked with skb->len.
> > -- 
> > pw-bot: cr
> >  
> 
> 
> The "len > skb->len" check bounds the source read, but the overflow is on the
> destination buffer.
> 
> The buggy path is:
> 
> 	if (len == 0xffff) {
> 		netdev_info(dev->net, "router was rebooted, re-enabling ethernet mode");
> 		schedule_work(&priv->reenable_work);
> 		/* <- BUG: missing return; 0xffff bypasses the oversized-length reject */
> 	} else if (len > CX82310_MTU) {
> 		netdev_err(dev->net, "RX packet too long: %d B\n", len);
> 		return 0;
> 	}
> 	if (len > skb->len) {
> 		dev->partial_len = skb->len; // skb->len is bounded by the USB transfer size (4K)
> 		dev->partial_rem = len - skb->len;
> 		memcpy((void *)dev->partial_data, skb->data,
> 		       dev->partial_len); /* <- TRIGGER: can copy 4K bytes into 1516-byte partial_data */

If skb->len (== dev->partial_len) is not bound-checked to the size
of dev->partial_data - aren't there more paths that could hit this
overflow? Are you fixing the right thing?

> ...
> ...
> 	}
> 
> For normal oversized lengths, the len > CX82310_MTU branch rejects
> before this copy. But 0xffff is special-cased and falls through. With a
> 4096-byte RX URB, after the 2-byte length header is pulled, skb->len can
> be 4094, while partial_data is allocated as dev->hard_mtu
> (CX82310_MTU + 2, 1516 bytes).
> 
> So the source read is bounded by skb->len; the destination write is not.
> 
> I am happy to send a v2 with this spelled out more clearly in the commit message
> if needed.
> 
> Best regards,
> Tianchu Chen
> 


