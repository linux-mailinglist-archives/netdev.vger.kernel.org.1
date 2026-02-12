Return-Path: <netdev+bounces-258521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cI+cNn1Zjmn2BgEAu9opvQ
	(envelope-from <netdev+bounces-258521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 23:51:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5B91319C4
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 23:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEBDA30ADF0C
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 22:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388C62773E9;
	Thu, 12 Feb 2026 22:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/xvdLyz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA5D8632A
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 22:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770936563; cv=pass; b=d9nWillxHPO0pjNGneoInF/OvujG/8px88+n5Bc5/qP9RvEzbGxL90pF+t+wEiEQ6XS7Yi6g2ySSKGrin8oBHuMX0xwp3U54m4ece6Fy0NqugqgQSA/PP8qkt8OYI2fF9YqYdkbgby9R8qKVzXv9YBZtyYTkayZCLYiGJXe5uDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770936563; c=relaxed/simple;
	bh=ifntE/EPdPfbX+VP3mHL+9ifThnW5nLpY6X9W95PacI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c6kiwUK7kCwbRd7+DliUFaZ1ysTNWCZZ26s5su6Rr8pB8FpN8h3NzR3VswNRzG5TCm+vMpe0wrSG8bHzcL3svc7XHjSCBHQhqFWd/FW+Gxz9c8JGFu3Hm1QSoj72XVvI+Lb2u9YkAqMtPVY/H5d1yEEwzpoqVyQxux2dzE51/n8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/xvdLyz; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64ad79df972so356412d50.1
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 14:49:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770936561; cv=none;
        d=google.com; s=arc-20240605;
        b=e+BYnmmJxcbqaRfk/QkFT44glo9nj4pjNXpHEWm/TvIskv2eoICk5vzEoALDHiSCLf
         qM1TnOSSc4SJXfbmd/TMtlfU+Zx3TMW2kRWWzX0fJ/DxXbQNULC1ERqORO+IfC4qGG2X
         v5EuVqrJ89G39rTUicqG6U8GitnfWkF5pgjwaxtOOJz0k+TY2az0JU8Nnbvza90SSJ/N
         hOl9UL9CGNz7RPo3U8tH4A3L883LWrZM3/occdeZx97129W7pwwBbk20WZysc9aoIDNU
         qjDWsAUmuDQixK1KVOWNb6Cbzluny9lacp+XPckW09yPATPJvj1YKrko2gTaY78V81jH
         zoTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JkIuzBUaKXI2hxdkycFm8+6x6+escMdwDH5lNfciKVc=;
        fh=xfc740ZgLOaDI6tngKhQ1EZMvIPxuhsmpyUC4HtO9UM=;
        b=fs5KcOg4mhhTE01aWF3RQqCvQnGDI+h08srdcf+M098A1YM+2p1qHWZLyAI0Lt8Gk8
         JIzBAyj98sxvnYq1iOKSd2yfXiIxxAvA0Jq6meX1FsxgoWa6dHgrSqLvJtn9LVYaiFb1
         7/HgxWqyYut+cKeRoChnqk4MNgwdIDnZtvVdPDHKMBS0Ob3UvBxXVaIowYTSmoIQqeZj
         bnN2Y6bmyKIv4xlKdr36YS9NyUYCHitFZb2/hdkNPBQgVAmfHZPSCMwOnPIYKtAZ5NNw
         SUIpnrXmaiyDmfOCSfvkTZxL5K1iqutdlxj61VtWPdjHghzB3dvpu+c1+RYgcWditORf
         lomQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770936561; x=1771541361; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JkIuzBUaKXI2hxdkycFm8+6x6+escMdwDH5lNfciKVc=;
        b=P/xvdLyzfbx20U2zZLqFCWga64S2P+vqzaorUnVewqBBTwmxB/tthG8jLJguI6gctN
         NadB962lA093ez1up75LSUVKix81es6h+qBcOHrC0sGX3hbKEucXD3md2kQzTRdzyFz7
         h2N77vKEDEPgbfrgFZ3rpeKTaBS1Lgzvj8Pq7UkWuxj53nB8xnt09UV0ZW6kBS5bgFm3
         yz/9ljGpgQM7NwFPneMaHXlnso3FZB4CClIkw4mx6SlAQH/U6MZ/7d3MGgSVc9Nt7h0U
         tcDFSvJUgHwCKhl/eHh8X+pZUKgQ4pHUUBlsm3/cVHjf3fxg6LTrw2czHrcp616TVMj3
         JJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770936561; x=1771541361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkIuzBUaKXI2hxdkycFm8+6x6+escMdwDH5lNfciKVc=;
        b=hPqtR2wiTMBYIE/Dkv8S430L4xx/l8lNNsHwhR2w4izqX2nyPfzkOVnr4mMinrkkDF
         hlF7fkpertmngc/uLY/eWe+7nwcj3JcasFyGA4ECAqLJZyP52W6DQtQqENSa5pOD8K64
         qV4Kw6nNWptJVzP/UxymgpCZb1N3GV0oIus2TCwxn+RXTS4Lt4uvi3Pigz9OfazuYHaP
         bvnkXiLEiQBuS/Z4t7wGRi//kky8cJ6n9+n3UGKtFjZ+MBsf2Qxsm1R58A/iql3Mw+JA
         w1IJ2PbT8e1Nsbws2vTYiok2iV53pSXtHJw5buvn4b7zofrLaqErj8g+CtycAOHqjB2c
         ExiA==
X-Forwarded-Encrypted: i=1; AJvYcCVvRhrI7zm5TjQ75mpzgnVUoxI2nbWwOJ2CP35WTbq1OC/2scpFxWrH4Vpz+1izbfZ2UMKXNBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGLEA7UPfJN+XOLlDv8waEDVlBsRb3kwbcgDFXO7H5Ic1WCI7q
	rB9Z5wF7gINUAYNWphcOy2XdjOYSSmDb+a1SQQE3151FhnvZFlRhURJqTItEkXKxB2qjXbsm9oh
	26RivJrU4+I+Yn0HtPVpPhhDIK+Wc4nw=
X-Gm-Gg: AZuq6aJGXHhuHfmBK1Dg62TUqiHzhQevK71K4pN1SOhKc18Cp0BurxvAy/3jgaRS+Cp
	C08W/M8mJ5HARWBjzuQWZ7J12jalWPFN9H2qraZb5AUovfJXpVdnqghGc3Gm9BeUE2IXEHUD/6J
	plgGzZWZWa39KwKnRZ93FudBc9X5gU2W3oLrAFm0361fywBBIgL0hITnxQeEP0hwCitFG5nJDgP
	z+lqfujbKd7Yjilxco0tTX+XdA3E54y4MhlV3AYAJ0feC3A2zSZ2ear45GzkQ4QMWGtO+NoCWj3
	wj3YviCWnCTIZ6S9iV9t4K92GgIopmiUCkXM1GE=
X-Received: by 2002:a53:c049:0:20b0:64a:f289:28d7 with SMTP id
 956f58d0204a3-64c14b8571dmr589460d50.36.1770936560994; Thu, 12 Feb 2026
 14:49:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122033605.148626-1-the.latticeheart@gmail.com> <willemdebruijn.kernel.f1685fbda48c@gmail.com>
In-Reply-To: <willemdebruijn.kernel.f1685fbda48c@gmail.com>
From: Soichiro Ueda <the.latticeheart@gmail.com>
Date: Fri, 13 Feb 2026 07:49:10 +0900
X-Gm-Features: AZwV_Qimw5wesj6xvKC9dYdAo55WBupvmbZ156nNX-MG8GHuO80dKlU117eH2Zw
Message-ID: <CAGq10mhEmopBfXDz-7fFNH-xmXsrx5TOqyT3dQhvRtytv4BiMQ@mail.gmail.com>
Subject: Re: [PATCH v1 net] selftests: af_unix: drain after peek and verify
 SO_PEEK_OFF reset
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Miao Wang <shankerwangmiao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258521-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thelatticeheart@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4A5B91319C4
X-Rspamd-Action: no action

Hi Willem,
Thank you for your review and helpful comments.

> Soichiro Ueda wrote:
> > Extend the so_peek_off selftest to validate behavior after MSG_PEEK.
> >
> > After exercising SO_PEEK_OFF via MSG_PEEK, drain the receive queue with a
> > non-peek recv() and verify that it can receive all the content in the
> > buffer and SO_PEEK_OFF returns back to 0.
> >
> > This improvement is suggested by Miao Wang when the so_peek_off selftest
> > was added.
> >
> > Link: https://lore.kernel.org/all/7B657CC7-B5CA-46D2-8A4B-8AB5FB83C6DA@gmail.com/
> > Suggested-by: Miao Wang <shankerwangmiao@gmail.com>
> > Signed-off-by: Soichiro Ueda <the.latticeheart@gmail.com>
> > ---
> >  .../selftests/net/af_unix/so_peek_off.c       | 49 +++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >
> > diff --git a/tools/testing/selftests/net/af_unix/so_peek_off.c b/tools/testing/selftests/net/af_unix/so_peek_off.c
> > index 86e7b0fb522d..813e3b3655d3 100644
> > --- a/tools/testing/selftests/net/af_unix/so_peek_off.c
> > +++ b/tools/testing/selftests/net/af_unix/so_peek_off.c
> > @@ -76,6 +76,19 @@ FIXTURE_TEARDOWN(so_peek_off)
> >               ASSERT_STREQ(str, buf);                         \
> >       } while (0)
> >
> > +#define peekoffeq(fd, expected)                                      \
> > +     do {                                                    \
> > +             int off = -1;                                   \
> > +             socklen_t optlen = sizeof(off);         \
> > +             int ret;                                        \
> > +                                                             \
> > +             ret = getsockopt(fd, SOL_SOCKET, SO_PEEK_OFF,   \
> > +                              &off, &optlen);                \
> > +             ASSERT_EQ(0, ret);                              \
> > +             ASSERT_EQ((socklen_t)sizeof(off), optlen);      \
> > +             ASSERT_EQ(expected, off);                       \
> > +     } while (0)
> > +
> >  #define async                                                        \
> >       for (pid_t pid = (pid = fork(),                         \
> >                         pid < 0 ?                             \
> > @@ -92,6 +105,14 @@ TEST_F(so_peek_off, single_chunk)
> >
> >       recveq(self->fd[1], "aaaa", 4, MSG_PEEK);
> >       recveq(self->fd[1], "bbbb", 100, MSG_PEEK);
> > +
> > +     if (variant->type == SOCK_STREAM) {
> > +             recveq(self->fd[1], "aaaa", 4, 0);
> > +             recveq(self->fd[1], "bbbb", 100, 0);
> > +     } else {
> > +             recveq(self->fd[1], "aaaabbbb", 100, 0);
> > +     }
> > +     peekoffeq(self->fd[1], 0);
>
> Do you want to test peekoffeq before the non-peek read too?
>

That is a great point. I should verify that the offset has correctly
advanced before it gets reset to 0 by the non-peek read. I will add
this check in v2.

> >  }
> >
> >  TEST_F(so_peek_off, two_chunks)
> > @@ -101,6 +122,13 @@ TEST_F(so_peek_off, two_chunks)
> >
> >       recveq(self->fd[1], "aaaa", 4, MSG_PEEK);
> >       recveq(self->fd[1], "bbbb", 100, MSG_PEEK);
> > +
> > +     if (variant->type == SOCK_STREAM)
> > +             recveq(self->fd[1], "aaaa", 4, 0);
> > +     else
> > +             recveq(self->fd[1], "aaaa", 100, 0);
>
> Why this difference in length?
>
> Because stream read will block if > 4, while datagram does not?
>
> If so, can perhaps use 4 for both or explicitly use non-blocking read.
>
> > +     recveq(self->fd[1], "bbbb", 100, 0);
> > +     peekoffeq(self->fd[1], 0);
> >  }

For SOCK_DGRAM, I used 100 simply to ensure the entire first packet
was consumed. But using 4 for both is cleaner and consistent. I will
unify the length to 4 in the next version.

I will send v2 shortly with these changes.

