Return-Path: <netdev+bounces-259088-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8A7qFv+UlGnNFgIAu9opvQ
	(envelope-from <netdev+bounces-259088-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:19:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9666514E077
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47114302C6CC
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81C136D4E0;
	Tue, 17 Feb 2026 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NhRRT++r"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC5E21423C;
	Tue, 17 Feb 2026 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771345147; cv=none; b=d+j/hEqXd/hPWeV29+4fMD8ZD54NPcIZ1BT50WKJCopx7/bnXLvELdYVKqPRcpOHdc3bH9cRw4dt+NU5jBtd2KXZfhYYCiJbCQoOo0dZQ0ZScl0/Z2L6uLIXVOqaS9nFhMH8OZ3wAoY1AXpOESyGRoPs2mcSJALjdglfDM3FIqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771345147; c=relaxed/simple;
	bh=4iIanjQFicUdbZHRHIdOpjPkHk6tWxPkLtOn8Ct+Khc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpvTbVlHX/CH26ILzz6QNMURtOHb3FFeMGBdmUUWC+dsFpw6YJG/gWdVSyvkdKTeXy/KIiJtWrZ16LRGNyETHR2qpLIj2qZXk3P+y0uFHtzPzQ6TViptHyM/91oUE2u4CKBAD6BqMsyFmmvqDDMjyeHv/fwMrfYNkRhKUo8he10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NhRRT++r; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PlPHgvEewjWWxsmr8WaBg4rdwZetFGFPF5F6xSfv7i8=; b=NhRRT++r/7X/+UlWgHPDYMHZ7N
	FLJe6v/yJRn6GspJhBwBOM1653TP2hor/8qWiisOCBtzCUc0H+Pr930vMbJr+r5T9xtL2h6yUKV1D
	L7qaTdodiYwItMIZ++LuLGZn2TRupdzZS5aaLk+wPwmBgVgcYNdeT2G84mfagk+9QiEA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vsNmp-007fA0-JU; Tue, 17 Feb 2026 17:18:55 +0100
Date: Tue, 17 Feb 2026 17:18:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Cedric Jehasse <cedric.jehasse@luminex.be>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH RFC net-next v2] net: dsa: mv88e6xxx: Add partial support
 for TCAM entries
Message-ID: <cb537f04-8146-4f69-b44a-ec14617eabb9@lunn.ch>
References: <20260217-net-next-mv88e6xxx-tcam-v2-1-d84cf420da46@luminex.be>
 <ab9b4278-2c0a-4ed5-9da0-2a7a3f928ed7@lunn.ch>
 <PR3P194MB1505A036B48F93F124CE241AEA6DA@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PR3P194MB1505A036B48F93F124CE241AEA6DA@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259088-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9666514E077
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 03:55:02PM +0000, Cedric Jehasse wrote:
> Hi,
> 
> >> +#define mv88e6xxx_tcam_match_set(key, _offset, data, mask) \
> >> +     do { \
> >> +             typeof(_offset) (offset) = (_offset); \
> >> +             BUILD_BUG_ON((offset) + sizeof((data)) > TCAM_MATCH_SIZE); \
> >> +             __mv88e6xxx_tcam_match_set(key, offset, sizeof(data), \
> >> +                                        (u8 *)&(data), (u8 *)&(mask)); \
> >> +     } while (0)
> >> +
> >> +static inline void __mv88e6xxx_tcam_match_set(struct mv88e6xxx_tcam_key *key, unsigned int offset,
> >> +                                           size_t size, u8 *data, u8 *mask)
> >> +{
> >> +     memcpy(&key->frame_data[offset], data, size);
> >> +     memcpy(&key->frame_mask[offset], mask, size);
> >> +}
> >
> >I want to look at these two in more detail, i don't like macros like
> >this, nor inline functions in header files. But maybe they are needed.
> 
> The macro is used as a compile time buffer overflow protection.

Functions are better, so that you get the compiler doing type
checking. But the typeof(_offset) suggests you might be passing
different types? But offset should just be an unsigned int? As i said,
i want to look in more detail.

And i don't see why __mv88e6xxx_tcam_match_set() cannot be a normal
function, and let the compile decide if it should be inlined. There is
nothing performance sensitive here, this is not the hot path.

> >> +             mv88e6xxx_tcam_match_set(key, 16, match.key->n_proto, match.mask->n_proto);
> >> +             mv88e6xxx_tcam_match_set(key, 27, match.key->ip_proto, match.mask->ip_proto);
> >
> >What are these magic numbers?
> 
> The offset in the frame used for matching. The Ethertype is at offset 16, the ip protocol at offset 27.

These are the sort of numbers which probably appear other places, and
so might have #defines for them. Otherwise, please do add local
#defines.

	Andrew

