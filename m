Return-Path: <netdev+bounces-264089-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAxkBse/qGnVwwAAu9opvQ
	(envelope-from <netdev+bounces-264089-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 00:27:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B61D3208F82
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 00:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A9273018D63
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 23:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4526036CDF8;
	Wed,  4 Mar 2026 23:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izqTeLNJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0491366835
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 23:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772666819; cv=pass; b=SZtPe+60aoFaySijVynmJ3T2kn8hOKJifTx06RfwLyN7fxi4XA8V9ZQwUBNPn+QeyTzeZVvvW17/x11BQqzijjElQyFK9hAYYQShjNZjdvKHZXniixrW2iSfMVWVnKdzRzkCHS4U8N6A+ejD4AMMTyVLZcR+Qgxwb3xo7NHYukw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772666819; c=relaxed/simple;
	bh=mNEKFaRMnDHfe0orczkAXGRlU1VB7gl1INEnkvG/KwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iI3GdHd9q6lgdvgebq6ymguf6QYgdEC0d52rm0zIyhJ6zZ9FJhzY8Ueo+uYBmVNQHR7K9Mz2JMaCuN88uXvifWkXwsowC5gGJBggUMvxYb9FvXsCAUCFjiopRlUcwJZz2JnWmhy6WPr+sNPdVdHWFlreaEw/n+SaE/dM4/y/q4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izqTeLNJ; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5ffa0b23a1aso702679137.3
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 15:26:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772666817; cv=none;
        d=google.com; s=arc-20240605;
        b=F3ndgbr814G6qB5kCA60Us6PKr5g6/ga6nl8w9EKbQsHpPGkj717nEMoumJcfJOhGd
         EtJH1SBC9c0poVroNtYaSbPKbwzzCi1VY57n3gx8yD5HFR2lwcVARS+9RuG3wANJqKUh
         Uqhx4wvo8zOiYS4GDlUINYYuZESNu3HNKC8YbXB0wPMasX3lnQdOSjuaak2yirGZNrEm
         JVnlBAoKWMFmvmzryAejzbgPsJ+yX4flFLK6SifkBAglZClC81vrDplFzn5BJ2a8MOUm
         RUfCbR/t6RpX8mwJIgTiTPn05li+mEBBToxSHrjm2w+TfGyfaCjVXc9vIfkDFTSehGlz
         RslA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cTFDYsqZ964fQZj00eGDb1NQ/WjjGh2BRCQyhHEgw9o=;
        fh=jiW4o1YYuf7adDSeK5niuRv9/SknMoORELQnL4wb4GE=;
        b=NIU5yoB9b9ezBbFgRVkReXgn/sm5jYbFJFkLOuTCIvkXHH3qbfIuvK4FAjnVCtPywq
         xLO0dWhT7RKU8xci0NzzIa/Gk1ahHG/od4Zc7yGjGKl7MOe37Bi29uMvJ/dfuxLoczrU
         d/aN/3VgRqcaC5GK9Fv+YoWzTX+OAuVD9Oz31Uyqkt+F+TAv3zrp8aicZQ1BQWvZHS8K
         jXK6U3yq2B4nNGGqs0qccE1D+YEquxgyR2SqwJrw+xCi+yjU6N0t8yiqAmi9ZPxYCI2E
         N3IGL7N/QTdPldPcWiTU8kUKEwqGrH4y+CqXg5IajWS3mlamdI1W/atA6SbCO0yC6SHd
         xY4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772666817; x=1773271617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTFDYsqZ964fQZj00eGDb1NQ/WjjGh2BRCQyhHEgw9o=;
        b=izqTeLNJ3HfRvPWHAlCZs+OC5FPcEQu2CpDIzTlRJWn0fztcypamBGdhwNXJigHZOC
         kQxTZh+l7zyd90FHTiPScMAVWQQZZ1iXYgDZsJ1fgVUxzzI+IoB+ps7HCaoz/baECq1J
         v4R1ClyKQy8b060NiH8s9fvZCWRO/Iu9T2j1nRWlHkfpUWHPjcsrgPPQwegt8OnlQzsa
         LI9MbZU/a0gPDuK+oL+KigeI7YbZEvsZgEVtXHTve8PBLsuPweVY0jpWSdt9W2zJUh55
         kOU0QjGiIE3F0Ica82vaD3XjGcqq4fbKnwu+H0RlwCNmVm4NcCaf4oM9mEwfyRzGDOjg
         3YZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772666817; x=1773271617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cTFDYsqZ964fQZj00eGDb1NQ/WjjGh2BRCQyhHEgw9o=;
        b=U1viNVmzZ7zWI03QTN0CI3WWbM4SE4ungxPz5KrhGmgYrKg88rwxnefYJTbFfVtSS+
         q77zK87DJ8wdTxUbnw5iFvEAIdJtm4cfG8nEwbuJRR1NLMtXwHMGAAUzpJ8jzXnkM3LG
         6f8LZ7nbtQ8xonib5fPWmy4SlKrZ1mvBmU4oq+bWhrbVyVUnW1NhhfiMhuGB1p9C/Vdl
         hlKxYjvH5UQZtfUuEzlGrED6yEUlkRmrRpPszDbAzbEOHeP994T7DGxGMLT48k+P73TP
         ANx8GtMDZ0lkMghQGHo7iBPGM14dRZ24nD/ZVI5Jb9Gqa9lUzhQsDi+yWt/AzwtPXRtP
         pXfw==
X-Gm-Message-State: AOJu0Yw4W4jYFkYHD4LP/Ew+Fo8W9AuvUCzNN2tz2QD5cqqqkpoQTkCC
	Vx5LFl/b/CHYm0FxcM9aZj1DHYNzEG83BSb6WIcbvqu9SgKv0hptOIj6xtAivEMcRp8bAHICNRE
	7AIoPiyJLme1Ce/EL8cf1eUIBvW1fLMg=
X-Gm-Gg: ATEYQzxFCzt4MQggCLwdYjPZa5fEPKdgJcGMEtLFB2ATbr4n4ofAN1ew5Ni3eRB9oMy
	BsApe66hfuV3FWWABMZqh0d177eWKOb8IlVEKFw3+7OtzTdJSh2PrxjwsHbq/+Ts4zWggY2wBSc
	UgF3w4D09DFMGum+CA2wbVfd+lX6Wj574m7u+/Mr+7Ou37BREDXi78O1mA4HbRireERcKUF9MUR
	0N5K5bLwneG1ci8loda0dOXWUJxw9nlXipr1rrE61WW3BA2H5LL1FW83qs4hc5gH2dYW+mZzOZi
	i3i4YmoUu2+UgwhliWRiO5FDVvRcvEIFz1OCutG3bz7begoPazfQal76ghj5LGVrGoUfQfXrSwr
	Md8iObaS3ry35L/P7
X-Received: by 2002:a05:6102:6106:20b0:5ff:b684:f796 with SMTP id
 ada2fe7eead31-5ffb684fcb5mr841879137.13.1772666816783; Wed, 04 Mar 2026
 15:26:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771986861.git.lucien.xin@gmail.com> <e49a24b97a25a9c25bd33411b8212978dd566bd3.1771986861.git.lucien.xin@gmail.com>
 <CAF6piCJDWjOmgkspuk28qAF8+9xj_o-zTXkUdB+3_waZqaMXBA@mail.gmail.com>
In-Reply-To: <CAF6piCJDWjOmgkspuk28qAF8+9xj_o-zTXkUdB+3_waZqaMXBA@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 4 Mar 2026 18:26:43 -0500
X-Gm-Features: AaiRm51sN3852302sTemIODlyAcPk2eG-uFfqRRmkPhePbFyqTDKIq6vNte4qKM
Message-ID: <CADvbK_djqHEaj1nO1mAR0h9qpkTUX1cXGMPEjrswySM_1bXNvw@mail.gmail.com>
Subject: Re: [PATCH net-next v10 14/15] quic: add packet builder base
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
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, 
	"Marc E . Fiuczynski" <marc@fiuczynski.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B61D3208F82
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
	TAGGED_FROM(0.00)[bounces-264089-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,davemloft.net,kernel.org,google.com,samba.org,openbsd.org,redhat.com,xiaomi.com,simula.no,gmail.com,manguebit.com,talpey.com,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com,fiuczynski.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 4:19=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 2/25/26 3:34 AM, Xin Long wrote:
> > +/* Transmit a QUIC packet, possibly encrypting and bundling it. */
> > +int quic_packet_xmit(struct sock *sk, struct sk_buff *skb)
> > +{
> > +     struct quic_packet *packet =3D quic_packet(sk);
> > +     struct quic_skb_cb *cb =3D QUIC_SKB_CB(skb);
> > +     struct net *net =3D sock_net(sk);
> > +     int err;
> > +
> > +     /* Skip encryption if taglen =3D=3D 0 (e.g., disable_1rtt_encrypt=
ion). */
> > +     if (!packet->taglen[quic_hdr(skb)->form])
> > +             goto xmit;
> > +
> > +     cb->crypto_done =3D quic_packet_encrypt_done;
> > +     /* Associate skb with sk to ensure sk is valid during async encry=
ption completion. */
> > +     WARN_ON(!skb_set_owner_sk_safe(skb, sk));
>
> This is the TX path, how can sk refcout be 0 here? Possibly use
> skb_set_owner_r() directly? At least use the WARN_ON_ONCE() variant and
> add a comment documenting why is needed,
>
skb_set_owner_r() will do memory account with the skb->truesize, which
is not what it wants here. skb_set_owner_sk_safe() is used to keep the
sk not released during async encryption completion, as the comment
above says.

I don't see another set_owner_sk helper for this. Please let me know if
you have a better way for this.

For now I will change from WARN_ON() to WARN_ON_ONCE(), but still keep
skb_set_owner_sk_safe().

> > +     err =3D quic_crypto_encrypt(quic_crypto(sk, packet->level), skb);
> > +     if (err) {
> > +             if (err !=3D -EINPROGRESS) {
> > +                     QUIC_INC_STATS(net, QUIC_MIB_PKT_ENCDROP);
> > +                     kfree_skb(skb);
> > +                     return err;
> > +             }
> > +             QUIC_INC_STATS(net, QUIC_MIB_PKT_ENCBACKLOGS);
> > +             return err;
> > +     }
> > +     if (!cb->resume) /* Encryption completes synchronously. */
> > +             QUIC_INC_STATS(net, QUIC_MIB_PKT_ENCFASTPATHS);
> > +
> > +xmit:
> > +     if (quic_packet_bundle(sk, skb))
> > +             quic_packet_flush(sk);
> > +     return 0;
> > +}
> > +
> > +/* Create and transmit a new QUIC packet. */
> > +int quic_packet_create_and_xmit(struct sock *sk)
> > +{
> > +     struct quic_packet *packet =3D quic_packet(sk);
> > +     struct sk_buff *skb;
> > +     int err;
> > +
> > +     err =3D quic_packet_number_check(sk);
> > +     if (err)
> > +             goto err;
> > +
> > +     if (packet->level)
> > +             skb =3D quic_packet_handshake_create(sk);
> > +     else
> > +             skb =3D quic_packet_app_create(sk);
> > +     if (!skb) {
> > +             err =3D -ENOMEM;
> > +             goto err;
> > +     }
> > +
> > +     err =3D quic_packet_xmit(sk, skb);
> > +     if (err && err !=3D -EINPROGRESS)
> > +             goto err;
> > +
> > +     /* Return 1 if at least one ACK-eliciting (non-PING) frame was se=
nt. */
> > +     return !!packet->frames;
> > +err:
> > +     pr_debug("%s: err: %d\n", __func__, err);
> > +     return 0;
> > +}
> > +
> > +/* Flush any coalesced/bundled QUIC packets. */
> > +void quic_packet_flush(struct sock *sk)
> > +{
> > +     struct quic_path_group *paths =3D quic_paths(sk);
> > +     struct quic_packet *packet =3D quic_packet(sk);
> > +
> > +     if (packet->head) {
> > +             quic_lower_xmit(sk, packet->head,
> > +                             quic_path_daddr(paths, packet->path), &pa=
ths->fl);
> > +             packet->head =3D NULL;
> > +     }
> > +}
> > +
> > +void quic_packet_init(struct sock *sk)
> > +{
> > +     struct quic_packet *packet =3D quic_packet(sk);
> > +
> > +     INIT_LIST_HEAD(&packet->frame_list);
> > +     packet->taglen[0] =3D QUIC_TAG_LEN;
> > +     packet->taglen[1] =3D QUIC_TAG_LEN;
> > +     packet->mss[0] =3D QUIC_MIN_UDP_PAYLOAD;
> > +     packet->mss[1] =3D QUIC_MIN_UDP_PAYLOAD;
>
> The magic number above looks quite obscure, and AFAICS looking at struct
> quick_packet comments have different meaning. Please use some macro inste=
ad.
>
Sure.

