Return-Path: <netdev+bounces-254902-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KIcBou3e2k0IAIAu9opvQ
	(envelope-from <netdev+bounces-254902-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 20:39:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A45B40B7
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 20:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 817AD3005AB6
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 19:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E1F328B49;
	Thu, 29 Jan 2026 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBskQaXk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AD43271EB
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 19:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769715589; cv=pass; b=WgFiTCOZkv1Ul4NZQQo/lii28ZKfRiyeGqKDqAWrFSJ5FL/8DeNh86MRtfgCWsNiCCezjcH5Yiz82TIYMyxFgnli8WKHYfbKj/0H7t1nJxT/GEPBlDIIKhHMhrLZdS/RHPdnqALNBPRORSktOQrAiO2/n7l6bE5vM+cBbgorGX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769715589; c=relaxed/simple;
	bh=slWb1gPv2FtqXq1twLRiSOtOOA1QvUUzSYzROoZg1Y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMzlIaORqB7gdifpTFCR66Bxbw/5TaEQYAZOHMOyzv1dH3iS6axdd/WNxzgXVjV/+aMGOJRz37HLlf259CMyR+4dkP8lRN05acMN6vZwokNbdkboVQlpPtnG8LNHJQKSKYI9i00IGFh6ozYTfY9KkNGJeEXIjFhS6tA1zbWiues=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBskQaXk; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-352c414bbbeso1488936a91.0
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 11:39:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769715587; cv=none;
        d=google.com; s=arc-20240605;
        b=io5d6RKzEU1N1B4EKz53ZIA/W2h+d9VL/nHq5OG2SWDB1q+gdLChh1Li4aUEfF3iaD
         /pGxkegXsp15YwJJui/8xXzcIblI30MdRwUgHDNFYlHRedULhYjs6SY3JFZaQFqqkZ2u
         VKJSFJ6h0cgF4U/ls57zcPu/mdATzRGLCguhCVYbLcH2jKVCva2X7kvHGk9/eOIFhv6o
         BsimEd+RNeBF0AH7wYOGhS+PDz0BjY+3Y93sPb4WWfuAePB91U9CreXOOQlPRF61bn9U
         hK9tvjFRkv3nu2AD0DcTvESbip2qB6iQQksnvxzYLnojsN+Yh4+eTU3GZwX7TNU0hFng
         IfPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=76tIsRX/4Fg/g4PCHkk+TBEOGwkN2KFdE8yBjFB4Hrg=;
        fh=fDbUfIcx4Ncec9AV4wxOHXS/c8ilfxJ4Jm8OWBj8/eg=;
        b=YgzjFR5ClgD7F88gRjvI8Rcp/hcXSgB/d9MT44TIbWpBlQdaNMtesAbfROAY9OMhYE
         VcUnWc5rKzf6Fo+IDKkU7ADsqnz+Fxs4m1El5aZ1vU8jvLtxFA61d8CJc/3/0MW24rA+
         5U3OnLDy7zMh+sGHH9GMn3rBwYjlbK+jXr5IK9rwP0b+QCNIaeEoXUErufP1zqFJy+KM
         cxFGIBUuKXGIOatpYnCC+Sh0z+Sil6YnfTxgRs/faQhLnuDVnnpvkMLNU9DgKGw5jJjw
         rnYXiUZ+Dphv7EZWDt1igR3WsP0ZUO2CTiyy+xZS5ZORAl9UOeAQk1bOm0VSwR/KqY9O
         Jb+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769715587; x=1770320387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76tIsRX/4Fg/g4PCHkk+TBEOGwkN2KFdE8yBjFB4Hrg=;
        b=eBskQaXk2hQaEIK86G5J0Iyuznrw1oI+qxFpSkyfjH4X/Yw2JJRtEjEp2EPpyZLGJV
         KVDcaAy0zRkFE8JpigO72TLmHotHxmjgJorVXIXpoO8SyKZ1IVMDD/n468JZcRld9ZD9
         lK09kaph6FaXUv+6wCBSYLzPN0b6P4xes2zpDpBMRXBiNQm8zL9KqsKLxEf8PUjTR9Rb
         CdIBnGY37raWztdpv9odTDzrH+OSHmX1R62r9jP94/C90ni36ZO9zpdbcxJWCmsBpoXZ
         SwtcUUzNNTnbw7GNiobI7xbvZk8QVNyL2wQkZuCXzsz/0Sx5r/El1/YT4EWJxub41r/x
         lPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769715587; x=1770320387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=76tIsRX/4Fg/g4PCHkk+TBEOGwkN2KFdE8yBjFB4Hrg=;
        b=fQbAsVbLa9yStkXseLEl91gkmdnzj5gd5Fd9zlM/35lnR60RSOY69m+hCdBjUG1Ofg
         Qcaxx0s77+7bBARs6gjoJTYSbtRZSh06f4lGt4/3ylA0UjIzpazef1peCc5AG3ZumRcg
         Y1Wjr7u8NRUczkletV4h8E0ehBP/YcY6LPYgmzIIOz2c0oGNByFJIPScKNZQHoBBfVz/
         D9wIGLfy1O+p52PN8mF/ghXoyJZcG3nSZZj7EtnJ7KOHIv7qtR3B0SNofi3WrTfztYL1
         RIDIs7V1WirbwTVnrBq/b7NkBxPqHjpUd7lD62TAThorJTl3X5AVNRPXJetM8j6Hd/+K
         YoPg==
X-Gm-Message-State: AOJu0Yxe/oy0hw9NhiwQ2IQKIp7XqxoccYELIiFIgp7eqhcuVJ4gUf7F
	anks3JjpLeGNOLir+4jBjkB2wHYUw52N8LRLpjHdLE7382zIrnDnj439uy8V2hXUO/IJFaRePdY
	Z5PXV+g5Cywz8hYAbDHS4AxfrGQLpG/4=
X-Gm-Gg: AZuq6aJz1vRUUwR5WyzQyUJ2g6/Wc/swBPT9yMGAnegWNP/+gtHpFzp2h8LQ4NDGKqx
	ZJfena8auD8hfVU+GwY1ubiNSGzI3r9/tD3u0h4pfFUORV3aM9BtelNPEA4/9QQG9/NrsuySdOH
	rDlAzYwaPhiGqKhRgivKG4A+dijTkrJlhZuVW33Ezh6fXN7VipXWiXiaJ1rzPPixUPQlB9CpRcb
	drvnj1dlBDpNNDj5mlTmrqJzjDqoRDGa1+DKQ8gSIwz7wzrtcZqUO1QfASGLVsIjod62Y25Y7bT
	ONUgIFKBW077P/ODu8wOwV2vZFnybw==
X-Received: by 2002:a17:90b:33c1:b0:34a:c671:50df with SMTP id
 98e67ed59e1d1-35429b2e55cmr3308198a91.17.1769715587450; Thu, 29 Jan 2026
 11:39:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769439073.git.lucien.xin@gmail.com> <4ec3ade7dfc709658a2b1839dbe29c9467b25fdf.1769439073.git.lucien.xin@gmail.com>
 <b0045978-ea65-422b-8260-d079b43eb553@redhat.com>
In-Reply-To: <b0045978-ea65-422b-8260-d079b43eb553@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 29 Jan 2026 14:39:36 -0500
X-Gm-Features: AZwV_QhlVoBaCiIz5kopBTHIpw23-lZlR_vHRkTAGEfDtCF_CgQBWEVXy3dNJWo
Message-ID: <CADvbK_d9FE+Z72JpdFER65dJ7X19Or_m0sLBPdWOZP9DPbksQA@mail.gmail.com>
Subject: Re: [PATCH net-next v8 14/15] quic: add packet builder base
To: Paolo Abeni <pabeni@redhat.com>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
	Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, Alexander Aring <aahringo@redhat.com>, 
	David Howells <dhowells@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, 
	John Ericson <mail@johnericson.me>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"D . Wythe" <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>, 
	illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Daniel Stenberg <daniel@haxx.se>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254902-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,davemloft.net,kernel.org,google.com,samba.org,openbsd.org,redhat.com,xiaomi.com,simula.no,gmail.com,manguebit.com,talpey.com,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A9A45B40B7
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 11:40=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 1/26/26 3:51 PM, Xin Long wrote:
> > +/* Configure the QUIC packet header and routing based on encryption le=
vel and path. */
> > +int quic_packet_config(struct sock *sk, u8 level, u8 path)
> > +{
> > +     struct quic_conn_id_set *dest =3D quic_dest(sk), *source =3D quic=
_source(sk);
> > +     struct quic_packet *packet =3D quic_packet(sk);
> > +     struct quic_config *c =3D quic_config(sk);
> > +     u32 hlen =3D QUIC_HLEN;
> > +
> > +     /* If packet already has data, no need to reconfigure. */
> > +     if (!quic_packet_empty(packet))
> > +             return 0;
> > +
> > +     packet->ack_eliciting =3D 0;
> > +     packet->frame_len =3D 0;
> > +     packet->ipfragok =3D 0;
> > +     packet->padding =3D 0;
> > +     packet->frames =3D 0;
> > +     hlen +=3D QUIC_PACKET_NUMBER_LEN; /* Packet number length. */
> > +     hlen +=3D quic_conn_id_choose(dest, path)->len; /* DCID length. *=
/
> > +     if (level) {
> > +             hlen +=3D 1; /* Length byte for DCID. */
> > +             hlen +=3D 1 + quic_conn_id_active(source)->len; /* Length=
 byte + SCID length. */
> > +             if (level =3D=3D QUIC_CRYPTO_INITIAL) /* Include token fo=
r Initial packets. */
> > +                     hlen +=3D quic_var_len(quic_token(sk)->len) + qui=
c_token(sk)->len;
> > +             hlen +=3D QUIC_VERSION_LEN; /* Version length. */
> > +             hlen +=3D QUIC_PACKET_LENGTH_LEN; /* Packet length field =
length. */
> > +             /* Allow fragmentation if PLPMTUD is enabled, as it no lo=
nger relies on ICMP
> > +              * Toobig messages to discover the path MTU.
> > +              */
> > +             packet->ipfragok =3D !!c->plpmtud_probe_interval;
> > +     }
> > +     packet->level =3D level;
> > +     packet->len =3D (u16)hlen;
> > +     packet->overhead =3D (u8)hlen;
>
> Given the above math, it looks like hlen can never be > 255, but
> possibly a DEBUG_NET_WARN_ON_ONCE() could save from future bug and make
> the code more clear?
>
sounds good.

> > +
> > +     if (packet->path !=3D path) { /* If the path changed, update and =
reset routing cache. */
> > +             packet->path =3D path;
> > +             __sk_dst_reset(sk);
> > +     }
> > +
> > +     /* Perform routing and MSS update for the configured packet. */
> > +     if (quic_packet_route(sk) < 0)
> > +             return -1;
> > +     return 0;
> > +}
> > +
> > +static void quic_packet_encrypt_done(struct sk_buff *skb, int err)
> > +{
> > +     /* Free it for now, future patches will implement the actual defe=
rred transmission logic. */
> > +     kfree_skb(skb);
> > +}
> > +
> > +/* Coalescing Packets. */
> > +static int quic_packet_bundle(struct sock *sk, struct sk_buff *skb)
> > +{
> > +     struct quic_skb_cb *head_cb, *cb =3D QUIC_SKB_CB(skb);
> > +     struct quic_packet *packet =3D quic_packet(sk);
> > +     struct sk_buff *p;
> > +
> > +     if (!packet->head) { /* First packet to bundle: initialize the he=
ad. */
> > +             packet->head =3D skb;
> > +             cb->last =3D skb;
> > +             goto out;
> > +     }
> > +
> > +     /* If bundling would exceed MSS, flush the current bundle. */
> > +     if (packet->head->len + skb->len >=3D packet->mss[0]) {
> > +             quic_packet_flush(sk);
> > +             packet->head =3D skb;
> > +             cb->last =3D skb;
> > +             goto out;
>
> The same code is duplicate a few lines above; you could reduce
> duplication jumping to a common label.
>
will add a goto label at the end for this:

init:
        packet->head =3D skb;
        cb->last =3D skb;
        goto out;

Thanks.

