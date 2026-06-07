Return-Path: <netdev+bounces-296267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7B84O3+qJWoKKQIAu9opvQ
	(envelope-from <netdev+bounces-296267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 19:29:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B2C65113D
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 19:29:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=fJoVabPR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296267-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296267-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A5D43010B9D
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 17:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB352FB632;
	Sun,  7 Jun 2026 17:28:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306742EEE74;
	Sun,  7 Jun 2026 17:28:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780853304; cv=none; b=I3zyMV0OfTVMR9Dts+XJ+5P7Nf7rfTeSAoUxO0QDzLo43Ew1wB247or1Ig58/fX3hBp268aZIbsAP3YF0KkexArD9vmNkqcV3XkbCJ2/hkrPKKL7wT9G7g8kS86tcxpM83cs73t6rQqLcAiFmBfOT0kesBEvwbarOJ/SYLQbUsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780853304; c=relaxed/simple;
	bh=g6Qssiyd/0gNBdIF+YVWj7h6uA4J1vqU8FZUZN3RMP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7osp+L6mYy3veA4FAP9iyG5ASgmLow39LUEIWgnVXFTdm6bZo2m/f1g/XUHhEs4sGFwFDZSfS19KdulwTs8KJ9PTP63AbDXFFAsEDo4FEsafA/gYLgQZSGpAjkdWlzr3GaPHU0q6Io37OQl/+KaH030XZjsB2EO1MZyqyjERW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fJoVabPR; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vkRXkBHTm1p59dLWdZH+b6kuiXEG97WGreWW32kZBcI=; b=fJoVabPRm7sSrD8SYBAPv9XVuB
	LT8iLJLArRNeO/aE9RYUAGc2UybhReA9LeCxwjmdNXi7ZZ2uG+pKUCZklygP0URF0PSHp8/fxButY
	By5OHnJhEYiimEZgKMRhn04GSJXudvFgLOUK+4Ah64tvzeWqNi1ZgfbX0AN1nryfapdw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wWHI2-006UPP-OB; Sun, 07 Jun 2026 19:28:02 +0200
Date: Sun, 7 Jun 2026 19:28:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v13 2/9] net: dsa: realtek: rtl8365mb: reject
 unsupported topologies
Message-ID: <9f8d3ee8-4249-4cb2-925d-53b2996239db@lunn.ch>
References: <20260606-realtek_forward-v13-0-b9e409687cbe@gmail.com>
 <20260606-realtek_forward-v13-2-b9e409687cbe@gmail.com>
 <617aa489-4f0c-4fe0-8cf3-55c98f4d4d9e@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <617aa489-4f0c-4fe0-8cf3-55c98f4d4d9e@yahoo.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:namiltd@yahoo.com,m:luizluca@gmail.com,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:yury.norov@gmail.com,m:linux@rasmusvillemoes.dk,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yurynorov@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296267-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[yahoo.com];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:from_mime,lunn.ch:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43B2C65113D

On Sun, Jun 07, 2026 at 02:55:07PM +0200, Mieczyslaw Nalewaj wrote:
> On 6/6/2026 10:29 AM, Luiz Angelo Daros de Luca wrote:
> > Explicitly enforce the presence of a CPU port (-EINVAL) and reject DSA
> > cascade links (-EOPNOTSUPP) during setup to prevent silent failures.
> > 
> > These topologies were already non-functional. Without a CPU port, the
> > driver does not activate CPU tagging. Additionally, the switch hardware
> > was not designed to be cascaded, and DSA links never worked because
> > CPU tagging is not enabled for them.
> > 
> > Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> > Reviewed-by: Linus Walleij <linusw@kernel.org>
> > Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> > ---
> [...]
> >drivers/net/dsa/realtek/rtl8365mb.c:rtl8365mb_get_stats64() {
> >    ...
> >	mb = priv->chip_data;
> >	p = &mb->ports[port];
> >	spin_lock(&p->stats_lock);
> >	memcpy(s, &p->stats, sizeof(*s));
> >	spin_unlock(&p->stats_lock);
> >}
> 
> Sashiko reports a potential deadlock around stats_lock, however I couldn't find a call chain reaching rtl8365mb_get_stats64() from softirq context. Can anyone point to such a path?

Enable CONFIG_PROVE_LOCKING and use the device, get the statistics
etc. If you hit the two paths with a potential deadlock you will get a
report.

	Andrew

