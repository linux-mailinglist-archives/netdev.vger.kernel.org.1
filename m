Return-Path: <netdev+bounces-294047-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDOGBRt9HmrnjgkAu9opvQ
	(envelope-from <netdev+bounces-294047-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 08:50:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F036292B3
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 08:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DD53304DFF3
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 06:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EFC3A7193;
	Tue,  2 Jun 2026 06:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mVGn27Vj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FF6BA45;
	Tue,  2 Jun 2026 06:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780382789; cv=none; b=bngQCtbdjhoxS/xEFrWC1cwOwkCz8wdfR1bkCowkinjVpde16XUsTSvTH/zT3CRw55VqNfS1NLyXkL0z1ZefkiJhgbBZ0PMmvRg+aVUJubDcnSNrTURX8oVRUoJZZifaUu5LVFdukO4TGS0SAdZHYVbERZJMTEwRjIDrNhitX0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780382789; c=relaxed/simple;
	bh=h8B6zqP1n0FflT7YHW2lWYdU6MgeQCCTwtOtxwL9iHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkrrI+YmQufB9VeOKunBUiOhtDXUdBbJdpWZpVGPhhtt4MIrrDLEmbJ/sqytFqxcpJACiD2wJ5TXmRuEu2EnjarrowRzrBt5kV7y/DKPdcLyH+S+6nt7tA3hgPK4SIXS0bE7+znEWorrs5kk3VscxTid4cLfmpwIJKY1QeMalSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mVGn27Vj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876D01F00893;
	Tue,  2 Jun 2026 06:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780382788;
	bh=PleAjPFfBrplT4ylTQmKOn/ycmA34mile0CXUYNdL3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mVGn27VjBYlBXigY19uQZMGy1qDeaz2fzAGuUicaPA2kPhFlhogeDIvscFLUeipaI
	 jpIYR7uUt3QJDgPV8vv2B/X6SDosAyUaVfmZKvQPQZXEAtsxzC+710PFRiBfCt7zBb
	 RIdBUe91H8C649x3A0Al+eSO1vNNXlfi0OSgJBzk=
Date: Tue, 2 Jun 2026 08:45:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Grewstad <dogestad24@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, jic23@kernel.org, jacobsfeder@gmail.com,
	linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, hjk@hansjkoch.de, davem@davemloft.net,
	netdev@vger.kernel.org
Subject: Re: [RFC] drivers/staging/axis-fifo: TODO file and subsystem
 direction
Message-ID: <2026060203-protozoan-widow-1b41@gregkh>
References: <CAD03fjaBJGtNATBxaYO-PAxdKC=HxYgE+M7HQ_a0O+3Sp9Mruw@mail.gmail.com>
 <84d8f2a1-6562-47a9-93d7-2d7ff33c31c0@lunn.ch>
 <CAD03fjah2GMedDtauPQjP0++3USpy6tm3AUemgAjVHS=5Nirtg@mail.gmail.com>
 <8f7eb9c7-6695-450c-81c4-fb96643adbc2@lunn.ch>
 <CAD03fja5oG3-BrQoy4+LEmCWPYGW_JWDEkaPndjSVz=PbRj4wg@mail.gmail.com>
 <2026060202-wad-skittle-263f@gregkh>
 <CAD03fjaHmsYpLj_PU48AW7h=E6XdMpqKsS7wQtDQKnEkGpa93g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD03fjaHmsYpLj_PU48AW7h=E6XdMpqKsS7wQtDQKnEkGpa93g@mail.gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294047-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,hansjkoch.de,davemloft.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 73F036292B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jun 02, 2026 at 12:07:48PM +0530, Grewstad wrote:
> On Tue, Jun 2, 2026 at 11:28 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > If no one is using it, why don't we just delete it then?  It can come
> > back if someone shows a real use-case for it.
> 
> Yes, this is what i was thinking. These boards are generally used for
> development and research teams can probably maintain a patch if
> they really want it. As you said, it can always come back if a
> user-space application depends on it.
> 
> One drawback that comes to mind is a development group may
> currently be maintaining a proprietary application that depends on it.

Then they will speak up when the driver goes away and we can revert the
removal quite easily.  It's not like code is ever "gone" for forever.

thanks,

greg k-h

