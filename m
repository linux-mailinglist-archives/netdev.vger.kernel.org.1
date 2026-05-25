Return-Path: <netdev+bounces-291294-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFQTOS4wFGqUKgcAu9opvQ
	(envelope-from <netdev+bounces-291294-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 13:19:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F34B55C9E10
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 13:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8C723003498
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD84D349CED;
	Mon, 25 May 2026 11:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOqMUpme"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3674A37E2EB
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 11:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779707945; cv=none; b=k3wKdWo16P5Ipkd2cUA3mK7KkB1Y1OOySdIq2baLJSI6gtRt8Cr2QTwLgjq3dWDpCHhqMrxHXbzyOf7j8M/vYvxZwkW6SJFpGPaVBH8BQc24WbCo0N7ICcUmz6t1zVq/UUoXPz+O3gJDWKtdQfwVW1NCf6dxJwyEotojYO9rysE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779707945; c=relaxed/simple;
	bh=PUZ0UICi1ovBbjSz2x1Ovz2G2i3u+uWN1AUA1O+p3CQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asZlVx9+dQGBeb6jSMnpYnHnxTE/t/eH+DX0MOSdnSa+Gbqh4JTqxulKPmsp44/sIiuiLo69kxOvzXCPu4YyQrsNmJ/LLk3U5OE+RcPERa4qiU20LGoZrjvGMzphSqCIqRVOdw8gi7lBpjEMypzsp5/cad7+lroQyU0Q9FpiPKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOqMUpme; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D257E1F000E9
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 11:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779707943;
	bh=qtDJ93rsJYs083vmRe/7jpJ6l0bXjgpZ0j5Uu1p7nxA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XOqMUpmep/eTpUCxeW7saOYu+vXLvFBvYDhx0feNndYCTtMHC7u8LuiK+KprGhnGE
	 U0ZBOHa5Otg+mTlEKCURGpVsJHz/jw5FYy6zsT2DFkN4tLhgygBYAWP7sXANifHHzi
	 Ue/a9Tg2BPHNAh1MFWMi5CakDqCbc2rrcKUIiZfmTuKOQXpMDO5G7RUgXBCH0fb46Q
	 X91YTeNVphhswVro45GBe0tuacnZckd43Ufh/YHMSVqgZrK5fmHkzXTqngCTzcHkTX
	 bwACriyMPeYBUXQN1C0v676neDwOFfd60U0x1XDO45WQU2IpNWSgIDlPIPslGQ5HGK
	 8WqTSJ+inqzNQ==
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8b7105dfb35so126391596d6.3
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 04:19:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+BY/cgZsuM/bQAYGA4Bqn3C0VUOaq6w/WDXjz9VXNXAAjC133j9MeezSSrNeI4oIipECbrXRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw88VQq5QEyvysv1aNuA4O2HbeVZm3AkINMNmEP2W1d4uc5F1J6
	nY4KO61NlVBI2MOBH22+D8keUGCXutv3J7k3sIuWj5t0ru66v5QaKyejLz/FxSGncjNdydl0J8h
	nrvNN/30LeHIOxJmC5MjLt6OTAnxVFXI=
X-Received: by 2002:a05:6214:242a:b0:8cc:c85:8aac with SMTP id
 6a1803df08f44-8cc7b57ee02mr241678216d6.21.1779707943141; Mon, 25 May 2026
 04:19:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522120643.242974-1-bjorn@kernel.org> <ahB2VbotEW5GD8K5@gmail.com>
In-Reply-To: <ahB2VbotEW5GD8K5@gmail.com>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Mon, 25 May 2026 13:18:51 +0200
X-Gmail-Original-Message-ID: <CAJ+HfNh6pYEQKPhKxDp=8VgtweqwTZysHAfOEj3g5pJZJYYq0Q@mail.gmail.com>
X-Gm-Features: AVHnY4IhQVe8DuFMlKW7ZZLoP_5FhHNvi5cK3hRxVJ_uuJ17L1O_B-HPDwF1AGo
Message-ID: <CAJ+HfNh6pYEQKPhKxDp=8VgtweqwTZysHAfOEj3g5pJZJYYq0Q@mail.gmail.com>
Subject: Re: [PATCH net] net: Avoid checksumming unreadable skb tail on trim
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.45 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.71)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[mail.gmail.com:server fail,sin.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291294-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F34B55C9E10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 22 May 2026 at 17:39, Breno Leitao <leitao@debian.org> wrote:
>
> On Fri, May 22, 2026 at 02:06:40PM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
> > pskb_trim_rcsum_slow() keeps CHECKSUM_COMPLETE valid by subtracting
> > the checksum of the bytes removed from the skb tail. That assumes the
> > removed bytes can be read.
> >
> > io_uring zcrx skbs may contain unreadable net_iov frags. With fbnic
> > header/data split, small TCP/IPv4 packets can carry Ethernet padding
> > in such a frag. ip_rcv_core() trims the skb to iph->tot_len before TCP
> > sees it, and the CHECKSUM_COMPLETE adjustment then calls
> > skb_checksum() on the padding.
> >
> > This is exposed by IPv4 because small TCP/IPv4 frames can be shorter
> > than the Ethernet minimum payload. TCP/IPv6 frames are large enough in
> > the normal zcrx path, so they do not hit the same padding trim.
> >
> > Keep the existing checksum adjustment for readable skbs. If the
> > remaining packet is fully linear, drop CHECKSUM_COMPLETE and let the
> > stack validate the packet after trimming. If unreadable payload would
> > remain, fail the trim; the checksum cannot be adjusted without reading
> > the trimmed tail.
> >
> > Also clear skb->unreadable when trimming removes all frags.
> >
> > Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
> > Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
>
> Reviewed-by: Breno Leitao <leitao@debian.org>

Thanks, Breno!

> > +static int pskb_trim_rcsum_complete(struct sk_buff *skb, unsigned int =
len)
> > +{
> > +     int delta =3D skb->len - len;
>
> I suppose this is not unsigned/size_t because csum_block_sub() requires
> an 'int', is this right?

Yup, both skb_checksum() length and csum_block_sub() offset are int,
and it also keeps the existing parent function's local type unchanged
after the move.

> >  /* Note : use pskb_trim_rcsum() instead of calling this directly
> >   */
>
> I think you can make this a one-line comment, or just a proper kdoc.

Yes, but note that this was not an addition from me. I can fix it up
if there are more changes required!


Thanks!
Bj=C3=B6rn

