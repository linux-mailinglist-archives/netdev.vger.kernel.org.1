Return-Path: <netdev+bounces-264090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sErAF1zCqGkIxAAAu9opvQ
	(envelope-from <netdev+bounces-264090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 00:38:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B0A208FEE
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 00:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D89E3040D84
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 23:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E6C372695;
	Wed,  4 Mar 2026 23:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjKGLcxr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C6F35F5EE
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 23:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772667481; cv=pass; b=d2qxTftxxheE7KIyLvvq7zB35Be1Nto/CkQZxPoNOZCmiKYzGqFQZNjcFe90Qkp/mL5K9q8kC5I21hx6FZ11UYoq2LfQ2szJLLaqInaWZLMMl4yll+uPBq3N3CEovaLXy0Z531ORmj0sRDunzzmuIerX0/ncZhEGI5TDIGDLmls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772667481; c=relaxed/simple;
	bh=w1TG5DyyD/MOa39o2nEmPuagdIYdEe1dCKPHHwXRuCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJtudRc0+qli6gPKkPG8AJzomamdj5eom1hBiqqA5KyOt6z3pPO1/eNMfbIR2UM7bFiy0IBW4EzgSlpn5rHJQJF8+EJfSrYX4xfDQ1Z3R0C/HuPpyX0bAvdbK7LskfSp3LsWgCVXvVnaNRJUfZP2Yohp1YOCtAQkZpFGR2eFmBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjKGLcxr; arc=pass smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5ffabb1dfbaso671619137.3
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 15:38:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772667479; cv=none;
        d=google.com; s=arc-20240605;
        b=TeNns4WY0YjAN1QlJUTP9TFCkce+agxjXg7o0k9CauGz8H9UQPZbZvjw0+YTw0aurV
         pZXrWdGapZoZ6+lJTO6C5hxWEywj67btr/iIjX0ZmHcz+NKvSPa2aEE/eB0v7hVUmmvS
         Hkje/k4irO3u3iZoGO1IN4tpnBpKpjOQUcynKt6D3sTOGm4JFtng/9ZihMYpf8ZV8agC
         k6pgKvM5peo2AYOVss3NLhhGnMWDfVEE8M4Rps4jfRw+gnmiLIV36d7NuO3A8wlh3syF
         yxZZfzUTNmMZfnokUvpEMk2gAijOBihh6SMIQVVLjbA9o0XAZYbVRUvKSbtJV5Xlj17d
         qAGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f2lsS6J1KrbGRFoggFb+7TwDvtJ+7CgdNNb0+XNMCDA=;
        fh=h9wC/zPtX5EHJ98iCan3KSCZ5ZjSWkxkVznle25J3f0=;
        b=EUVy3NIBaRWmN4MoFgcDzetW7f2xYjGlUBLm3cAk614PgL7+pGn6ct3HNyBFu8hSjt
         R0znpYoegTr+2DY+BAa3sxX1nYgSyzPR7oe1SEE4PGBm4aXPt7+J1vBoeLvCXlLoTYgP
         Gm9h0RtfzxbVWi1mlkTn5UrvCOagN2Fc1RJwKe+bQPC7lBnP89SxfucQKrspROoB2Si0
         BR7suyCmklr9o9+MAlgIdprhVbw3oIonZqemmjrZ5vTRMoCXo4o6kU5fQOw6R6d4pli2
         Bn4+WJ7OWUOfI6plpw+53u/8N6gKlq2+wderT81tfVcGVibMnTBcPHBAyAUeSyiGTzZ5
         BcjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772667479; x=1773272279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2lsS6J1KrbGRFoggFb+7TwDvtJ+7CgdNNb0+XNMCDA=;
        b=JjKGLcxrB9cR872n139JcVQYpMCorug6rQAWD5KqvQhW258szruhbN9OlFXFzUlOt9
         X2Zu087AkIi9ZYFPkUWlzCqz7fAXTrRqOslXKGTKX+9k+Zsr04xyFbjAzFS2mA2mw9NP
         Gy+QFffUq31sgIPkI7LryX2p0X+hbo5vY0O56plT45zfIzp4Luy6hhXz8rONsRxmGTIw
         ro/3/WS6lZow37jqINXeeZ7VEnJmAZ4owjYbgO79Bq2gYCYddWt3QIoHB1u+7XAxAWgd
         Sg75IZGxw7HMx0sjP4veUSF64QcoqaQTMo7CM5EhY5BG2bUOnh0InU12LgwvvResmfo8
         httg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772667479; x=1773272279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f2lsS6J1KrbGRFoggFb+7TwDvtJ+7CgdNNb0+XNMCDA=;
        b=bTsWj4opaKAUxlCgfJmBeZz+XTGoXF7TsLI660E3GCVy9ZBtbLatgpCBRvEMReQJX/
         q9TojqekS7vVoxEcuervJHcKBF6XsR8DcXKGTc7U4oxflquAZjb6OHGoB99alSC8XkwU
         sWmWbH+eMTsT2paGSyCD0CVJUNzOBOKWjI6AQk8qbvZDDxyAgZorCte8WS5BmuRVQyCE
         JhNUaESvfu81XO5Qits7wyy5Avv80V0gpEC6XngjjZl0SYk+tvts8OcuKFvtkTUvZW8d
         PzyqQQn0GQX5ccfrJH7n1x0Dt/DC0Q4JaHgBRezDMpw6ea4R0uKLJElNBfINpl91qdA+
         LGfg==
X-Forwarded-Encrypted: i=1; AJvYcCU+EVMjvXbqwBmhHSNdfwn0gOuR95H0llOGSqq8xeubrFbRqmfYD2t+WBBvEinCvSFbl8xMzFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz36mZwQzn8L55t2N8ItUM+36I/peB7wR8FdBqPZ7Aq15TTqaoI
	kxDUvSjOeZm6UyWzDBqyBraPpRZOYZDs5uk8I+IeV4T2ieYuDHQtrJc/zUbVMNM+ESnZekySt5R
	xgMNSLf6qel9gjcDdxwYz5Jd8kTxqFX4=
X-Gm-Gg: ATEYQzw8WO9ggTUfxmqeem5mtByQBpUFIBufaZ5YEYGzNRhL9DQOiRY8nSd/N2yjQY1
	QYxW/+lCED08uG0f5T1cRtUkQS6M1EoEofU93ouNqJmUHlzT3hapOR0SFCs566ZEB+kXTGe06kr
	29zX6O5FfXrnGjKHcNHJOLuCP9q6La59UO5JDj8IRm2DZxOhriAb60pwTE82ThPGsD3s4LyZrV8
	3TZMwX2rkYEufLz9gRikMJPsCXkxXcCN1JHJwwiBv4GfCu8+dZBxYVc55OCH/FEvtLYbpj19ORx
	EhZB1rqmT+X8Qy4hs3t2WEggBj2JHo96pME+lC9/LhTevSKib7Wfx1xClzwLf50Kvmq8Db+QtqM
	0XIz2IC/RyM4zBknH
X-Received: by 2002:a05:6102:510f:b0:5ff:a34:6ce8 with SMTP id
 ada2fe7eead31-5ffaaf1af3amr1982362137.20.1772667479118; Wed, 04 Mar 2026
 15:37:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <08a63705058aff77dd54fb388870f0bca6036c95.1771986861.git.lucien.xin@gmail.com>
 <20260303083351.35558-1-pabeni@redhat.com>
In-Reply-To: <20260303083351.35558-1-pabeni@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 4 Mar 2026 18:37:46 -0500
X-Gm-Features: AaiRm51OBlwUOZC4nFNNd6vu4H5gc_uzuMHgB2908jHUlSejY2ws0x0OMALq7Fk
Message-ID: <CADvbK_e-Tkb8aVzSy4WhVogETvQy16TrFdtWROtf3Y6oC+PczQ@mail.gmail.com>
Subject: Re: [net-next,v10,15/15] quic: add packet parser base
To: Paolo Abeni <pabeni@redhat.com>
Cc: hepengtao@xiaomi.com, kuba@kernel.org, jlayton@kernel.org, metze@samba.org, 
	davem@davemloft.net, kernel-tls-handshake@lists.linux.dev, horms@kernel.org, 
	hare@suse.de, aahringo@redhat.com, tfanelli@redhat.com, mail@johnericson.me, 
	andrew.gospodarek@broadcom.com, linkinjeon@kernel.org, dhowells@redhat.com, 
	matttbe@kernel.org, xiyou.wangcong@gmail.com, dreibh@simula.no, 
	jbaron@akamai.com, quic@lists.linux.dev, pc@manguebit.com, 
	marc@fiuczynski.com, edumazet@google.com, alibuda@linux.alibaba.com, 
	steved@redhat.com, illiliti@protonmail.com, tom@talpey.com, 
	marcelo.leitner@gmail.com, sd@queasysnail.net, linux-cifs@vger.kernel.org, 
	netdev@vger.kernel.org, mbuhl@openbsd.org, smfrench@gmail.com, 
	chuck.lever@oracle.com, daniel@haxx.se
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 20B0A208FEE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264090-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[xiaomi.com,kernel.org,samba.org,davemloft.net,lists.linux.dev,suse.de,redhat.com,johnericson.me,broadcom.com,gmail.com,simula.no,akamai.com,manguebit.com,fiuczynski.com,google.com,linux.alibaba.com,protonmail.com,talpey.com,queasysnail.net,vger.kernel.org,openbsd.org,oracle.com,haxx.se];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 3:34=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> quic: add packet parser base
>
> This patch uses 'quic_packet' to handle packing of QUIC packets on the
> receive (RX) path. It introduces mechanisms to parse the ALPN from
> client Initial packets to determine the correct listener socket.
> Received packets are then routed and processed accordingly.
>
> > diff --git a/net/quic/packet.c b/net/quic/packet.c
> > index a56edc745bb1..a23ce99a6656 100644
> > --- a/net/quic/packet.c
> > +++ b/net/quic/packet.c
>
> [ ... ]
>
> > +/* Extract the Destination Connection ID (DCID) from a QUIC Long heade=
r packet. */
> > +int quic_packet_get_dcid(struct quic_conn_id *dcid, struct sk_buff *sk=
b)
> > +{
> > +     u32 plen =3D skb->len;
> > +     u8 *p =3D skb->data;
> > +     u64 len;
> > +
> > +     if (plen < QUIC_HLEN + QUIC_VERSION_LEN)
> > +             return -EINVAL;
> > +     plen -=3D (QUIC_HLEN + QUIC_VERSION_LEN);
> > +     p +=3D (QUIC_HLEN + QUIC_VERSION_LEN);
> > +
> > +     if (!quic_get_int(&p, &plen, &len, 1) ||
> > +         len > plen || len > QUIC_CONN_ID_MAX_LEN)
> > +             return -EINVAL;
> > +     quic_conn_id_update(dcid, p, len);
> > +     return 0;
> > +}
>
> This parsing logic looks nearly identical to what's already in
> quic_packet_get_version_and_connid().  Both skip QUIC_HLEN +
> QUIC_VERSION_LEN, read the length byte, validate against
> QUIC_CONN_ID_MAX_LEN, and call quic_conn_id_update().
>
> Could quic_packet_get_dcid() call quic_packet_get_version_and_connid()
> with dummy parameters, or could both share a helper to extract just the
> DCID portion?
>
No, they work on different forms of QUIC packet, one for short header and
the other for long header packets.

> > diff --git a/net/quic/path.c b/net/quic/path.c
> > index 9414c4f813c5..655f38af4107 100644
> > --- a/net/quic/path.c
> > +++ b/net/quic/path.c
> > @@ -17,6 +17,8 @@
> >  #include "family.h"
> >  #include "path.h"
> >
> > +extern int quic_packet_rcv(struct sock *sk, struct sk_buff *skb, u8 er=
r);
>
> Could this include packet.h instead? The canonical declaration already
> exists in packet.h (after this patch). Using 'extern' here creates a
> duplicate signature.
>
> If the signature in packet.h changes later, this extern could silently
> become stale depending on calling conventions. Since packet.h has no
> include directives and wouldn't create a circular dependency, including
> it would keep the declaration in sync.
>
No, let's not have this dependency for now.

Thanks.
> > +
> >  static int quic_udp_rcv(struct sock *sk, struct sk_buff *skb)
> >  {
> >       memset(skb->cb, 0, sizeof(skb->cb));
>

