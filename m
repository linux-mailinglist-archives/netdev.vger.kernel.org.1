Return-Path: <netdev+bounces-258975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJX2IIQdlGkpAAIAu9opvQ
	(envelope-from <netdev+bounces-258975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 08:49:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE71E149516
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 08:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F38E3008D07
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 07:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715362D7398;
	Tue, 17 Feb 2026 07:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWcpwiV9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CEB2D47F1
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 07:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771314533; cv=pass; b=WuqSeA3ii5imu2gVKX/dpf4RIfxw6l1kDki1JFF0Udo15k1+QJiYU3KA6OebRzKYPk7ftXXW9ku5XdxblbMP/O2zhJyRnpkufLyYFqBcZYykcBnCvRfSzgfOopydCQqTTy0gpVrWsHSEDyELCyNP958dAgo87EUrDbc2LxowdcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771314533; c=relaxed/simple;
	bh=PTMkhGN495EneID+0JQmT2Y8cXlVY+I8Ki+ll8ip1aA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNDKg/uel7OFlf4ktcNn0ETFSSfspk68kxGKcmoxMrTQNHusMr3GkA1sdNr5PMmSbNtWkIH8zKJOVWrvBj5k52FaFLrzfR89zz9FrzVkenIdx+4N10HT5OKWhVcLQdhNEYopHi0FHtwSfSU9R1RcxhRHnX9B+5vG78+O3ii95mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWcpwiV9; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59e614b3dbcso4151887e87.2
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 23:48:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771314530; cv=none;
        d=google.com; s=arc-20240605;
        b=UDzlK+XD8QA/9jc/z5A6oxMUTlqwkYVYL6uLoSmR4ReyfYnUND1TN+qdpGBccNzG5r
         Em7LBeFwBixqIZIOeYlsx5X/BnvDmBjrZHnoaB/DngsToGcGqIph1pfJmTOIHdpgY2VT
         0WQWY41UP2ccZ7GMwoin5u2PWIbehecUT8Gw6OWC0gclnUeZSz60ykOMYsgURx8tREaJ
         +LG9427OhjXSgH6a7tyCPPQwRjqhezUsmdPpv0U8VHHQ/l81795AFcltbl6JRJsO4eYU
         26l0GEV/vpQh2ZAX+IXHu6BqvoNTuB73i0FcHdAZKx4hsEu0/FC2VrttsgwNIa5z6plH
         LW9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m/HphQZQk8IQ38M0QP+mB410B5QX/NfkItlOLu+xjvE=;
        fh=DzKnuSN5u34EZik2lNYeTpyp5j1cqzB/xCPyZvR8DBE=;
        b=iRX9tI+af4k3dugOcZnOPXuMAjfBcMvnAkusibXxXQbqbZQ4GY9PO+TouA19PGfMZb
         xTb68nlc1gUiCgYm5NOclu66bzJhURcoOVRD+Q8vVz5PnbsMixWm7/kkNQ8b36IscwX2
         +BVMpPjlx7Xi7Q94waKQ0n6GDKYk3XSi2sWpVgJL/G0ELzQ6vZYzI+FlVmD2L8qmGeK6
         Ltlqb7KN6dqSvYQD6jOktOGfXkCPnmSIp38tmM6pl6IBdqWkVkoSWs87XwtAfvm4dS7V
         r6Op1pHfa4CJX2AxDoF3NjKyq0xqd5x06HbGGPZeuzjck85i/b+QjbHNseEfD5O0lOeq
         aodA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771314530; x=1771919330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/HphQZQk8IQ38M0QP+mB410B5QX/NfkItlOLu+xjvE=;
        b=QWcpwiV9Z32Fq0DrR+mQ4Djej2KriF3yqcmmXOFBDNJn4jXNut34Qb4Rg/ue3HpnH2
         DFxpVHd9aWnFrXqdse/+Z/05y/W8XPHcVYbozZab36ZvH/OHW2zGcjrDDMG7F4Ot82B+
         ukPHgLRBE45/xf1o81letd/WTkPUG38kTW53LBw7cSMQJHORM1St9YYvNEfD9wK5zjt1
         iGwKIxSXSXXI5x06ibE4mcm7aJR9L+FeakMeCNz2+CXipfOzk0oFxi03G5HZ9nOQK9jb
         qHZhQdSvRXEmJIAs3kVSp/+2fbgR/5YrkIww8Sx15TcmLoJy9JdFEHnpn3bAsLHpkKCG
         BpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771314530; x=1771919330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m/HphQZQk8IQ38M0QP+mB410B5QX/NfkItlOLu+xjvE=;
        b=gbQ0KJ5SoUqN8wPsygS6KDTPLTvrkPfUgWu8PXF5/hLismlKRuGDVyew5LKRbnGJqP
         YROu892x8l2Pxs+QkWL4PTN+wOCJLojCGnnWhBoozsPMzGVUchuipNLKDzIOz3Wbqw1E
         2R3VIOWNmnJWq8yLgMtl1hZGsx/AzL/U6hYpZNvE24d5H1L+MvMW2sDVxWdRWJUMM/A7
         fGLADdYk5Bhf0mp27pKckXO8jZ/lR2iEk3mriTm+QviKsYMARRCRlOhf0xg/uciGLTVC
         TsbGiD3H4GhmB8uRappOTfD2CpuE0YAZxRADOyvPB0Jc0jV/JZzlfXOR+BrMOZauUAIw
         PaBA==
X-Forwarded-Encrypted: i=1; AJvYcCVAxKpOrXp3WprKtlJVIntOlpdUDqujq8Xoke5g2Q/T6idylBFD33tvsysH61C/pQ4/7AGFQrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpG8/AUFlj5XygDZsZ0ibTiq8CBTHqaE5q2hN3R5DHHRlTucR5
	keskw2dhM5lUfz16dvtaz8Ovy5vOCiqYb8odvDGmTENzcmKGZwWZUqwDVD1qjgrDVQq7gA5nTue
	flgE/nNz5NtgdIYSNCSGT347FUso9ZRU=
X-Gm-Gg: AZuq6aKbmCslh08rECTn7ZXpiwQWHOd7MaZ8K07DDaKrrpEBtDZRHLst+OYQOIz7HEh
	eFZliyJ8sdRHcQCsY4tnuIYueT1Mjpd66jFmmNcwVc2SrZTV0XGEKSmiJ0pYoiCfjl1GijamPeA
	Rb8JSMj3S3MswOpyXw4bidXTLKPe72oR/6MVgS3ONhoJW4lovnyaXlXFueLtCfn5CDuYrz9Tk1w
	CgqUjo1fAflu9z5PxBl/A9G0sjX6uRT/3SCwTbr+e7N5BJ3FY84vTGeCGkhQ5gZHgTJntKkdAy2
	X+hDaJU=
X-Received: by 2002:a05:6512:3b9c:b0:59d:f5a8:27f with SMTP id
 2adb3069b0e04-59f69c3164bmr4022568e87.14.1771314529712; Mon, 16 Feb 2026
 23:48:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260214232456.A37oV4KQ@linutronix.de> <willemdebruijn.kernel.1682a93525c87@gmail.com>
 <20260215184608.8dk4hemG@linutronix.de>
In-Reply-To: <20260215184608.8dk4hemG@linutronix.de>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 17 Feb 2026 15:48:11 +0800
X-Gm-Features: AaiRm53OtelPTr6Q_NXE1c2AJJRD1Nys-IbXAOXdX9Jb1MXEiZcQwGJuxSKM6LI
Message-ID: <CAL+tcoAN_T8c4z5wN82FD-skyY=gJedX5X4VK=QDaQWz0isocg@mail.gmail.com>
Subject: Re: [PATCH net] net: Drop the lock in skb_may_tx_timestamp()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Kurt Kanzenbach <kurt@linutronix.de>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258975-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,google.com,kernel.org,linutronix.de,redhat.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE71E149516
X-Rspamd-Action: no action

Hi Sebastian,

On Mon, Feb 16, 2026 at 2:46=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-02-14 23:05:27 [-0500], Willem de Bruijn wrote:
> > > --- a/net/core/skbuff.c
> > > +++ b/net/core/skbuff.c
> > > @@ -5555,16 +5555,25 @@ static void __skb_complete_tx_timestamp(struc=
t sk_buff *skb,
> > >
> > >  static bool skb_may_tx_timestamp(struct sock *sk, bool tsonly)
> > >  {
> > > -   bool ret;
> > > +   struct socket *sock;
> > > +   struct file *file;
> > >
> > >     if (likely(tsonly || READ_ONCE(sock_net(sk)->core.sysctl_tstamp_a=
llow_data)))
> > >             return true;
> > >
> > > -   read_lock_bh(&sk->sk_callback_lock);
> > > -   ret =3D sk->sk_socket && sk->sk_socket->file &&
> > > -         file_ns_capable(sk->sk_socket->file, &init_user_ns, CAP_NET=
_RAW);
> > > -   read_unlock_bh(&sk->sk_callback_lock);
> > > -   return ret;
> > > +   /* The sk pointer remains valid as long as the skb is. The sk_soc=
ket and
> > > +    * file pointer may become NULL if the socket is closed. Both str=
uctures
> > > +    * (including file->cred) are RCU freed which means they can be a=
ccessed
> > > +    * within a RCU read section.
> >
> > The fields are not __rcu annotated. Is this common knowledge or is
> > there clear documentation of this behavior? Not disputing it, just not
> > familiar with the rules around these fields.
>
> The pointer is not RCU annotated because normally, within a syscall, the
> file descriptor does not vanish and so the pointer remains valid. The
> interrupt callback is an exception because we don't hold a reference on
> the fd. But since the underlying data structures have a RCU lifetime we
> could use it.
>
> sock_alloc() allocates a struct socket_alloc which contains the struct
> socket and struct inode (sock_alloc_inode()). This the sk_socket in
> struct sock. Once you close the socket via the close syscall and the
> last reference is gone then you end up in __fput(). The invoked
> ->release() callback is sock_close(). Here socket::file gets NULLed and
> proto::release should sock_orphan() the sock where sock::sk_socket gets
> NULLed (I don't see where else and packet_release() does so). The
> "struct sock" remains around because the skb has a reference on.
> Otherwise it would go, too.

If skb still exists, there is no way to do the real destruction of its
socket, at least I know it works for TCP. That means IIUC TCP doesn't
have such an issue?

I roughly know what you meant here, but still wondering if you can
provide a specific call trace or case where the socket using socket
timestamping feature leads to this NULL-pointer problem?

Thanks,
Jason

