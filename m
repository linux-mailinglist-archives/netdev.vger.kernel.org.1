Return-Path: <netdev+bounces-291353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PE/FL1qFGoqNQcAu9opvQ
	(envelope-from <netdev+bounces-291353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 17:29:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F5F5CC44A
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 17:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A079B3007B12
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 15:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0C13F413E;
	Mon, 25 May 2026 15:28:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9C93F4121
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779722930; cv=none; b=kFOmeaHwIBudy7NtLB9ocFqtmaLMpc376IICrLsfaGUIuhpnvwkymmVlt0+U2CRCquYAI7oQbQK6lQ6yKzlJamAdmziGZbUjihjfsUgcP1U+VchXZWzl0WR+wWKneM8wMGo5Uds0b3Qq95tFsB5FPkii3fj1ZIkXr3Jst+NIB7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779722930; c=relaxed/simple;
	bh=GOVP3GMXI6e3nmcvhFapqkltBbBYJYx9rhPAYRvjY/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfEBGFk4SsW3+7vOjjqzgEoPiGtuz0FaTddW9Qd5xc46eQbYNh4QUa/Sa5RHF0gQLJ3x7yTRg/HONO1jozdL4mnXNe7v1wLukszmYPm+DMnJ5mvM/acdUcKQRPtZALccAG8v5EFVhMBdUcVTaIeo2JlrjK1xGQH5koYpYNEmpUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49039a8851fso40744005e9.2
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 08:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779722926; x=1780327726;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9DXGt1MHlBlB682MDc2YdgnoSfbUc4QharEAHt1q++E=;
        b=TAI44F6cEM92TKaX3N3eAJDHXabhBzm8a166y1KbQ3II9WSnMbSARrEOZTJo1neAp0
         y2QrNR1MMNn+taeyYQsal/33/FpAnGx2oM+zExIBpgQQh4DdvMB4LtVHMLDfoSYbnJg9
         Ohtt5w26OelU62F6b61qCgQPyfaoPuAkytAqLz9M1GDdkx8MNHYyjzD6fIexX/cjKRkz
         IazT5OecJsHpBgPhO9yXBrNx7QJLlNr7/Sk2H1d+O+vIQ1NnE+Cc7Cc7SH/P9GW159pJ
         iOlnvMmhYnKj7vugXhbcZTTxpJ1KcRftGBhqIWdQoPJsz6nPuhBwnJxr04WjYTfp56Nr
         rC7g==
X-Forwarded-Encrypted: i=1; AFNElJ+btE2uY8KARNJzWOHE6Gw8G3dCoatVLZvM3WHj+stQdxmNnJ19D7AjS0iljWiOMhVjwBFlpoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6RBFzys5HxdvRhxjEVFPyKR5onBvTqZ4ZRnAHEJPcagT9+X0d
	9MXlaspMma6HyINs0oFkAorlLdsrO0ZenSreNRuEm5q2gollfasGc3uu
X-Gm-Gg: Acq92OEpxRO4eHSTqe8XN+YN7wsbstTV1cjkIY5okDj9VmfpChSykNBh0i6BVdnf1kS
	9YIyb4z6WgT2sro5K7B2R4B7+7I6Rh38JzH4or3gAjLpJ+BGG15/9J1qVHpBdBVNV22ZulPh6WB
	xNsHvvkY9/sIuEABBNWuT4rOsI4D5T1oMSuy0qHDUq63+D1FHwIoPTu0YkNTMgkkpBxwk8JoqgP
	76FTVxP+BJjEkTzFjvAgvwadxHSOVFsXaOjCiAaoq6UDTqMDsoOtSHobDI+DR8hp0PytS6Ums8+
	LErgG3Eu2KSq1UEQry7+p2WsdssljoQSWvHk7L1kusXIMTUMmQF0Etykr6AeGBH7hEJxjPDWDR4
	TiRkacH5OsIexP5S/+pgs/IrTrSP1A1OSkHERQIA/IijsKVicYvPNyKw4b1kD5Ad95hQ+kzeqAe
	FUz251gfhUCwB3gdgyu0AIADwBDXlTStw=
X-Received: by 2002:a05:600c:8599:b0:48a:525b:e148 with SMTP id 5b1f17b1804b1-490424ac7ccmr180474405e9.4.1779722926359;
        Mon, 25 May 2026 08:28:46 -0700 (PDT)
Received: from gmail.com ([62.197.47.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49042cebaaasm89265365e9.36.2026.05.25.08.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 08:28:45 -0700 (PDT)
Date: Mon, 25 May 2026 16:28:44 +0100
From: Breno Leitao <leitao@debian.org>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: Avoid checksumming unreadable skb tail on trim
Message-ID: <ahRqi5ECb3LMHiWb@gmail.com>
References: <20260522120643.242974-1-bjorn@kernel.org>
 <ahB2VbotEW5GD8K5@gmail.com>
 <CAJ+HfNh6pYEQKPhKxDp=8VgtweqwTZysHAfOEj3g5pJZJYYq0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+HfNh6pYEQKPhKxDp=8VgtweqwTZysHAfOEj3g5pJZJYYq0Q@mail.gmail.com>
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[debian.org : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-291353-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 44F5F5CC44A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 01:18:51PM +0000, Björn Töpel wrote:
> On Fri, 22 May 2026 at 17:39, Breno Leitao <leitao@debian.org> wrote:
> >
> > On Fri, May 22, 2026 at 02:06:40PM +0200, Björn Töpel wrote:
> > > pskb_trim_rcsum_slow() keeps CHECKSUM_COMPLETE valid by subtracting
> > > the checksum of the bytes removed from the skb tail. That assumes the
> > > removed bytes can be read.
> > >
> > > io_uring zcrx skbs may contain unreadable net_iov frags. With fbnic
> > > header/data split, small TCP/IPv4 packets can carry Ethernet padding
> > > in such a frag. ip_rcv_core() trims the skb to iph->tot_len before TCP
> > > sees it, and the CHECKSUM_COMPLETE adjustment then calls
> > > skb_checksum() on the padding.
> > >
> > > This is exposed by IPv4 because small TCP/IPv4 frames can be shorter
> > > than the Ethernet minimum payload. TCP/IPv6 frames are large enough in
> > > the normal zcrx path, so they do not hit the same padding trim.
> > >
> > > Keep the existing checksum adjustment for readable skbs. If the
> > > remaining packet is fully linear, drop CHECKSUM_COMPLETE and let the
> > > stack validate the packet after trimming. If unreadable payload would
> > > remain, fail the trim; the checksum cannot be adjusted without reading
> > > the trimmed tail.
> > >
> > > Also clear skb->unreadable when trimming removes all frags.
> > >
> > > Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
> > > Signed-off-by: Björn Töpel <bjorn@kernel.org>
> >
> > Reviewed-by: Breno Leitao <leitao@debian.org>
> 
> Thanks, Breno!
> 
> > > +static int pskb_trim_rcsum_complete(struct sk_buff *skb, unsigned int len)
> > > +{
> > > +     int delta = skb->len - len;
> >
> > I suppose this is not unsigned/size_t because csum_block_sub() requires
> > an 'int', is this right?
> 
> Yup, both skb_checksum() length and csum_block_sub() offset are int,
> and it also keeps the existing parent function's local type unchanged
> after the move.
> 
> > >  /* Note : use pskb_trim_rcsum() instead of calling this directly
> > >   */
> >
> > I think you can make this a one-line comment, or just a proper kdoc.
> 
> Yes, but note that this was not an addition from me. I can fix it up
> if there are more changes required!

oh, nevermind. I misread it.

Thanks


