Return-Path: <netdev+bounces-275499-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RcJAJQX10ml5cgcAu9opvQ
	(envelope-from <netdev+bounces-275499-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 01:49:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD41C3A0456
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 01:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02FC130063BF
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 23:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13601282F34;
	Sun,  5 Apr 2026 23:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="x+AlIvYk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF4B1AB6F1;
	Sun,  5 Apr 2026 23:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775432962; cv=none; b=Ydf6AFodc2rs7wfFQmAq0iEKn1EsmFzJUZtlGipqQre+sRCpQq9dAv49i2Z9FsVFFg9bcX2sqOQ22jrVAJ3OmTVVByhFhN13MO9vVdLmmir8AvdbEcOBVcZR8Jh51+uZpdlZUKOHK3Jqy2L/L6Jrd8NND/ZkU8LoWs7pwi8+sZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775432962; c=relaxed/simple;
	bh=ByVakQaqWOdVbTt8cRRx+RrqV7H0NZvlLdiCELhpm2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rg1OGTsAYqoBb56OjUg6uloFZqpn3w0oEM9vhezY/r5nrsQWOQRjBs+Xzh+q4EWSfjxdaNRlIcX7ISeZePs8US4NolaDjrJUkCZkAJ5wDJOqphjvkmhRDQZruyc/lKqzJ+eqKxsyQGZqKPxk6wj5k1GAZ5534si5uuxwdt2yJlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=x+AlIvYk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=j6+gdbDZZdlGyn80LUvHgvPnYmuishTMRVpglZve2KM=; b=x+AlIvYk1zjc1NzfvxMUMcblyJ
	p5ythXWUplKBGwLsHSKorJK8fIen5rtkoQBt9Ns9LZdeePG2UbvQJyOAL1ThnJhpx7LGz+y4Teqca
	V+9PWGgC/kp1xwTk/SR8EnLihhioCzQgdJKCrmvV5GpV73caHrRJc1M+xQ8+PpMt+FNc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w9XDM-00Evl5-Or; Mon, 06 Apr 2026 01:49:12 +0200
Date: Mon, 6 Apr 2026 01:49:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
Cc: pavan.chebbi@broadcom.com, mchan@broadcom.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, lszubowi@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] tg3: Add PowerEdge R740xd to AER quirk list
Message-ID: <bbd6d9df-9698-41d3-808b-c751bc1c4576@lunn.ch>
References: <20260404225023.1254-1-rayfraytech@gmail.com>
 <975ec123-e3df-41d5-bb15-f3af8af2c340@lunn.ch>
 <CAJioSGcBb3eRtgQXHWx+Bhw4M422dyAo-0yXO-XwU7h4hmwmEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJioSGcBb3eRtgQXHWx+Bhw4M422dyAo-0yXO-XwU7h4hmwmEQ@mail.gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275499-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: DD41C3A0456
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 05, 2026 at 12:56:11PM +0200, Oskar Ray-Frayssinet wrote:
> On Sun, Apr 05, 2026 at 01:03:00AM +0200, Andrew Lunn wrote:
> > When you look at tg3_restart_aer_quirk_table[] they are all Dell.
> > Are there any Dell systems which actually work? Would it make sense
> > to mark all Dell systems as broken and enable the quirk?
> 
> That's a good point. I don't know if there are Dell systems where
> the quirk would cause harm. Do you know if it's safe to apply the
> quirk to all Dell systems, or should we be cautious and keep the
> per-model approach?

You might want to ask on the PCI list.

As far as i see, with 30 seconds for searching and reading
documentation, AER, Advanced Error Reporting is an optional feature of
PCIe. Since it is optional, it seems like disabling it during shutdown
should not have any negative effects. Except for systems where it
actually works, and there are real errors during shutdown and
resume. It will be harder to debug such errors since you don't get the
advanced error report.

      Andrew

