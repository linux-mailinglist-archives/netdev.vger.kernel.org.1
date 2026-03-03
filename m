Return-Path: <netdev+bounces-263087-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOvJAI2npmkNSgAAu9opvQ
	(envelope-from <netdev+bounces-263087-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 10:19:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B91A1EBB76
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 10:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC4083016AEB
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 09:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8E8386445;
	Tue,  3 Mar 2026 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mst4J6zB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzhlLUmT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D7C38228A
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 09:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772529545; cv=pass; b=t4pT81+RZqrd7UHqMUnFPIASjSpEhVWwr6vNv+Rn7EdLR2P2On9YXq2hRFkmuCWhUii8FZbpjqHxwSJDZpo4+zegtsuG5yNwOmPT6kd7b6lBxN/f6n9jUGsUutXzKsJ8pG1O/VFXJmv1Jtx4FSaq0nNptH+D48ascnv6ybhXdKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772529545; c=relaxed/simple;
	bh=Sl9s33PI2gXIErv/itE1S5taIbog6hFU7zftnmcZCok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9f5CCCd1925QmJ2gD4wuruUFwfGbPwLlX9uVxFOuknWvLMf4a9pGrYwxWo+MFqUl5pTJHHxoXIlYlGDtVE0xQh2XsNWsH69RQ/HyZzQv5wzL2CUsg7Zqe9iC9HWCF67TG/q+IFiHSKdYbtO4J1LGcpXuhx2CbQo7FZd2HUv59Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mst4J6zB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fzhlLUmT; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772529543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S88HPomaSqnbxnsyYWFXX9R+c+6772O9y0Gq71iEev0=;
	b=Mst4J6zBUPIL4FZt0lygM0nI/F/fp3chWh/meNKyEM/Pen6pKxl4jq5GtL5zOwbHKs9nOR
	jNYvyJkMeQaFGTHUHf8B78wZ6SQw99kHBcQWXOu19PCRBMEWC64gXB8xfBs0KitunPvY92
	9HEJG/2iH41Awd5xzZoox/aNyZomi6A=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-hfxKwC_8MbWH6JffkyvCjA-1; Tue, 03 Mar 2026 04:19:01 -0500
X-MC-Unique: hfxKwC_8MbWH6JffkyvCjA-1
X-Mimecast-MFC-AGG-ID: hfxKwC_8MbWH6JffkyvCjA_1772529541
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7983f854288so92877897b3.3
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 01:19:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772529541; cv=none;
        d=google.com; s=arc-20240605;
        b=AUjnCQ7RTfgszBX6mHhUajx5ey0eBSTUGr3RIeIxySnipq1TAOykQLGsDR/i81F0gD
         C1YK9j9/lET+7+UZKGUEgSMIxo8llbSrOx+RhZYkblcxgQSu6AGU+v0RTO+frcizoARN
         O38EWCzBvzs/18UqX0dvK2LmhAbSbrgMArs+xCK2b0A843wniBsz83zsv0jCpPM8TaiJ
         TwPhXSYIx75S96D7KoINzAjNj1GaWLwt3IreVp+M+DZI5uDIbBl6GBl59w00/tMwIxIh
         QefMdSpELTwL/59gydfeKhClmfcXGIb7J+wGaJP4udB6cMbzVUiCMv5hcdUBKR+rpNlZ
         e9qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=S88HPomaSqnbxnsyYWFXX9R+c+6772O9y0Gq71iEev0=;
        fh=fNRYm4a8gFRoudusp2YQCN22zq2/3g2EJosD74DyjbQ=;
        b=LgjrObEblc71d/7ljsRRF+WFkO481WXB3z2e9hOl4AHJpbNgmZYk7XPM8Q/JNBSCFz
         nr5b30SLka1o0xxpN8NAz7SCCuLGlPWwqAQZ8XDYHqN8S3fMeELr9rVSsBRfwJRArp5L
         0DMFOX1XiCro50tnMzt2hwoa9P+2XWiH+2DmQavNkUnYVuTiF0snmEQPv+MCMkR89rq6
         167H2qJrMO6qSulX9C45WHDaQA0nlPJX+mM+UTE8XU32b4KAR9hWQsgE3idufRoJGrcJ
         b5BCIGZuAPc9DPcP9Qbg+6oIWgnM9pCmObGHYHfTxZhAazUE0PQLKbsgYysIXyfkTqDB
         rGdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772529541; x=1773134341; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S88HPomaSqnbxnsyYWFXX9R+c+6772O9y0Gq71iEev0=;
        b=fzhlLUmTemsvpsZ5B8OowV8sI/k6/8l7VDFNGInSOxgyoYx9xIPGFpDXxsR7SO1ROE
         fIWtiXIvMMq7j8TLrYYGdh42ek9C59l7C9gpLAi8bw2rGZ5XOhpbaCWMnj+ihOCTi4Zq
         Lu6omGfUe5od6KPi0/43SwBDnSgW0ryhOKLshXOUzAjzpEvDc8/7Q02F5X7dY6m2wMT5
         Ho5ow8CdJwFnjM4hDvKE2VhI5GZSSeWS+UmJC5XMWsX4mEoGMuxRoA4so/GMhPibPpHJ
         QwreyzmYTuPDg+XRYp/YKbmlNKQpnOve7L8akyJnwgp0ql3xP3pesofyuOZ8YeM9dzVj
         m5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772529541; x=1773134341;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S88HPomaSqnbxnsyYWFXX9R+c+6772O9y0Gq71iEev0=;
        b=wcf/vb4ktLWyifDsWXQumbErUPunROXJQP70FF+OTnjpXsj0XxRCze2z1Ee3oZi934
         b0G618gGJgMyz0KNnUvjRjGx9qGbw2QnOgvv6lg1sZ4XEWZeZ2nW12qVJSHfa/P3nqtP
         6Cg+au6nzzJm7ua/TuJOOR8n/txt/NmKyaURlQ4kfZ9P0hwALqVi+NR8RPAzcjCor5eS
         FQUMSX0g+NKkcxpNiXC2B0HtCDlNN7P01CwfPqeRZ7oHrgMWTA2OotE0ETCFgtQFxXx0
         Xmfmy6GW8yNjIQK+4PsJNiYJ44kk4mG1uN1Q40LufIrs78VW5CzWNWlqnJoZyGcm+bz5
         l6WA==
X-Forwarded-Encrypted: i=1; AJvYcCWf6e0vNVAwrn/TX9CozeLTAdLkw2+oGbF/Y5ywrf2/bEGQbQZpBqdKchkT2QPo2LwPdT9Btzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZfa9Z+V/C28EoxSJrnXK6hA94fUyKWAGZB5L6Xz7Hbewwrn33
	VMl3HsqLK5zVYxFqSnNr2LvPrXqYsqpvGh6Bci6LEvCccyxs8SjPWWnE3tUFsS7ju97L/OxcRA2
	yimqIvblvH14Im3ueT4kGC9yXLY9iroiZxBUoIYt84xIxToVRrNw6hhAYECQcyQtzJgCxzC6gC5
	1L3Ah+2GSzYt/6Q8wmH2DHOVMs425aqFEG
X-Gm-Gg: ATEYQzwJSg2LWDDF4a837Kar6BDA6OK0pH0EBcOAMwiGKuZgOEq4PGxChAtbrikJRFu
	alm62VXm+1ah9R9pZmvjvWIP4NkOAup2cnlQ2GEqD3c7l8E1T9QeaWKNSwr+T9D1Jv6vNwMNtTZ
	RWS94Nq4y6BvVh4tWhQw0fwSnH1L8l+hxJCjqK2ujQaCDR90EUgfyVKqtTlPuMJcbwk07NxuMzB
	67g8O8=
X-Received: by 2002:a05:690c:89:b0:798:67be:f8fa with SMTP id 00721157ae682-798854ef3aamr139425827b3.17.1772529541172;
        Tue, 03 Mar 2026 01:19:01 -0800 (PST)
X-Received: by 2002:a05:690c:89:b0:798:67be:f8fa with SMTP id
 00721157ae682-798854ef3aamr139425527b3.17.1772529540751; Tue, 03 Mar 2026
 01:19:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771986861.git.lucien.xin@gmail.com> <e49a24b97a25a9c25bd33411b8212978dd566bd3.1771986861.git.lucien.xin@gmail.com>
In-Reply-To: <e49a24b97a25a9c25bd33411b8212978dd566bd3.1771986861.git.lucien.xin@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 3 Mar 2026 10:18:49 +0100
X-Gm-Features: AaiRm53rJ3wV-QBG6V--xu4Px23a7wXyR_Jsp_m9nNP5uOat2VsXjJ9xQsdj7Tk
Message-ID: <CAF6piCJDWjOmgkspuk28qAF8+9xj_o-zTXkUdB+3_waZqaMXBA@mail.gmail.com>
Subject: Re: [PATCH net-next v10 14/15] quic: add packet builder base
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>, quic@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, 
	Tyler Fanelli <tfanelli@redhat.com>, Pengtao He <hepengtao@xiaomi.com>, 
	Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
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
X-Rspamd-Queue-Id: 9B91A1EBB76
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263087-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,samba.org,openbsd.org,redhat.com,xiaomi.com,simula.no,vger.kernel.org,gmail.com,manguebit.com,talpey.com,lists.linux.dev,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com,fiuczynski.com];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.989];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 2/25/26 3:34 AM, Xin Long wrote:
> +/* Transmit a QUIC packet, possibly encrypting and bundling it. */
> +int quic_packet_xmit(struct sock *sk, struct sk_buff *skb)
> +{
> +     struct quic_packet *packet = quic_packet(sk);
> +     struct quic_skb_cb *cb = QUIC_SKB_CB(skb);
> +     struct net *net = sock_net(sk);
> +     int err;
> +
> +     /* Skip encryption if taglen == 0 (e.g., disable_1rtt_encryption). */
> +     if (!packet->taglen[quic_hdr(skb)->form])
> +             goto xmit;
> +
> +     cb->crypto_done = quic_packet_encrypt_done;
> +     /* Associate skb with sk to ensure sk is valid during async encryption completion. */
> +     WARN_ON(!skb_set_owner_sk_safe(skb, sk));

This is the TX path, how can sk refcout be 0 here? Possibly use
skb_set_owner_r() directly? At least use the WARN_ON_ONCE() variant and
add a comment documenting why is needed.

> +     err = quic_crypto_encrypt(quic_crypto(sk, packet->level), skb);
> +     if (err) {
> +             if (err != -EINPROGRESS) {
> +                     QUIC_INC_STATS(net, QUIC_MIB_PKT_ENCDROP);
> +                     kfree_skb(skb);
> +                     return err;
> +             }
> +             QUIC_INC_STATS(net, QUIC_MIB_PKT_ENCBACKLOGS);
> +             return err;
> +     }
> +     if (!cb->resume) /* Encryption completes synchronously. */
> +             QUIC_INC_STATS(net, QUIC_MIB_PKT_ENCFASTPATHS);
> +
> +xmit:
> +     if (quic_packet_bundle(sk, skb))
> +             quic_packet_flush(sk);
> +     return 0;
> +}
> +
> +/* Create and transmit a new QUIC packet. */
> +int quic_packet_create_and_xmit(struct sock *sk)
> +{
> +     struct quic_packet *packet = quic_packet(sk);
> +     struct sk_buff *skb;
> +     int err;
> +
> +     err = quic_packet_number_check(sk);
> +     if (err)
> +             goto err;
> +
> +     if (packet->level)
> +             skb = quic_packet_handshake_create(sk);
> +     else
> +             skb = quic_packet_app_create(sk);
> +     if (!skb) {
> +             err = -ENOMEM;
> +             goto err;
> +     }
> +
> +     err = quic_packet_xmit(sk, skb);
> +     if (err && err != -EINPROGRESS)
> +             goto err;
> +
> +     /* Return 1 if at least one ACK-eliciting (non-PING) frame was sent. */
> +     return !!packet->frames;
> +err:
> +     pr_debug("%s: err: %d\n", __func__, err);
> +     return 0;
> +}
> +
> +/* Flush any coalesced/bundled QUIC packets. */
> +void quic_packet_flush(struct sock *sk)
> +{
> +     struct quic_path_group *paths = quic_paths(sk);
> +     struct quic_packet *packet = quic_packet(sk);
> +
> +     if (packet->head) {
> +             quic_lower_xmit(sk, packet->head,
> +                             quic_path_daddr(paths, packet->path), &paths->fl);
> +             packet->head = NULL;
> +     }
> +}
> +
> +void quic_packet_init(struct sock *sk)
> +{
> +     struct quic_packet *packet = quic_packet(sk);
> +
> +     INIT_LIST_HEAD(&packet->frame_list);
> +     packet->taglen[0] = QUIC_TAG_LEN;
> +     packet->taglen[1] = QUIC_TAG_LEN;
> +     packet->mss[0] = QUIC_MIN_UDP_PAYLOAD;
> +     packet->mss[1] = QUIC_MIN_UDP_PAYLOAD;

The magic number above looks quite obscure, and AFAICS looking at struct
quick_packet comments have different meaning. Please use some macro instead.


/P


