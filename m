Return-Path: <netdev+bounces-264100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AS9NQTLqGlBxQAAu9opvQ
	(envelope-from <netdev+bounces-264100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 01:15:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1B62095CE
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 01:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4E0B3024941
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 00:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A0442AA9;
	Thu,  5 Mar 2026 00:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMvbfNck"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11C1288AD
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 00:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772669698; cv=pass; b=m279xL6DG76n2hbhFxH+GVWMzhBeeZWnpz37fFgfCNcl7l+ed/PbRs6SgiGOmPXnkqDIjCgGGMNWguyqMRr0pBdAuk8D8dn575+N1WZsh648+e+Oozze/pYdFabOj/PbPVxrZR81uQ6sn1CpRDImIc4T4/fKihKVtjcYiDUR+WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772669698; c=relaxed/simple;
	bh=SNH6I/hhPmgSL35V+oZOn5ErlBAd3yoW65QFOWZVpMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zi9/cIgUNYiNoes76xGfavPqKgzFWbUQvHqLm7kmDJTbxk7Hi7vdw0evLoVrKWVOEtUqoGrNJ3UpscmQVGMRq+6HqzpT0nnDEx67XTX+Dc5UcJKAedFiK35CkkfA8gZ+rXR2MIT/Pu8rQC4S2SbDsI4twJFDukVJeesifZSExX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMvbfNck; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5ff174502ffso5312240137.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 16:14:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772669695; cv=none;
        d=google.com; s=arc-20240605;
        b=gPH9an5j2hUSMIttAQrn4Vc0P6owsWOFARJqFidRoi0KO4uBg8zgcbWxMlTPGDa7cI
         2o3kbSz3nkwvE5chye6V2wpIUHdnXTvn5m4GtvDyLjPGO5a06pWxQQCeX54z8/LAt4l0
         L/mHaQf/B7lKUkNdn0KtaAy2SjGz9/Otd7M+3m+RcUjyXwIdubM1GQ7GDjrmjstLAjVr
         orV2p9lwjPemfV4MD/BAg1MHDEXVGvsAmAsQk/LBcaGskMBUtt6x+i6ZAQ8CN+aNCajW
         N0G3lN/gAevGd2Ft2XYWdjkn+PsJvSNS3JLw8ubC8M7Ydd97FQIeNXlrfbj/jsmmwT7b
         c+kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HSyN+e/bXp99YEHDDoss7T3ytoS/JigyhF1102UzIKE=;
        fh=jiW4o1YYuf7adDSeK5niuRv9/SknMoORELQnL4wb4GE=;
        b=YiV3TEMhvA2XlZ2vefeek7uhurHOb8+K+WYrfrhdQNpwQK5B8qAoo5LVo1xtD4Pd4r
         2Dg6HYcxzCQcjmkDa3avmbk7Cv1OSy91r7hGsr8d+LlMA/bnglYURl3cNY7lHVfJhtHk
         DdaaUwuBZ1ENYOSv6aHf7QzPNz0yxRQZVKSfbVaeUVmVdkr3jbfWpMlxWjdEBqKvv/ob
         ZZa1ZNNYS/gh1E09KJmGSu+t7BW1O0oIPcCfTD7DjVVLuXO3O2NR5+0zhFT/FpK21aay
         Rv7QlRz2Qhd/7MED08PAJYmx363e0XPx47HKe3cPyoBCIbJ0twQjYxAuYhzrEkUF711P
         oAXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772669695; x=1773274495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSyN+e/bXp99YEHDDoss7T3ytoS/JigyhF1102UzIKE=;
        b=gMvbfNckr7poFIay0xfEtVO85POu8CD81C22BjoCgh4dXKCUUv2Zk2hGr5pDneYXmX
         bhcUpFunTFbEzea+izqtxvpUlHD6/2qiasshOiKilYhtxaVA+xe3KWR/Ng8io3FriPKz
         wvQ4LuPJGOAiSY/FrhyCdUPHhu5qA2v1R/H3AA8ZXs6IkjiVq9sSQlAjrqGlAZB1/Kmk
         PFDgVYNT4jYmsSOnbgva+BbpeMBb5sWMg+RimSuAQuxz95oY5jxy3b42mXCrreeEanTv
         F3+XhdrX0WiD4YznA3mMieSETuHpYfQelEVSC+M6LoxKSRBeKke+UmvbsXeK09p4Dav2
         6nQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772669695; x=1773274495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HSyN+e/bXp99YEHDDoss7T3ytoS/JigyhF1102UzIKE=;
        b=XCL3NcADCnCFN7eZ84q7D62Q1OplIv/o5Wnmp/DXQReC8JwVLHRcNhDtOwdtrZAro1
         Yz36fxsVJZPB/Strq0Fx59w0ah0OsD1Uw1jz3Ae0GqHk9APAvc4+v8EizkLVoMXPLfkR
         hYrzVS6jNSsMJBGULGe8Z79f5rGWR3QY5cLcvBTksVfSRyJK2UJbF0U7kNQe30lptcuQ
         YCO6fksZ/CLtEr3IwPF+s2SPGQDv5ny9ifAF6zRsjLL0dDvu7DiSw1j9ALeLBhCF4mpl
         09zJbrTF26/xAT5Ea03Nd/dcwo0vEgm4EEhm7moZhkJWBEYADRYSJDRq2D72THzx9+f7
         D2vg==
X-Gm-Message-State: AOJu0YyRX0hNnHDbU9v/EWXfp+2/hrq6yUsYTh4D4Rm3DB2XtVkKqUZi
	pSp+N/dxsolh4Q7CF95F2U7IzRxc30Wwvmfax6YTb0PLQP2DQHfn5cL40lDy0RxwvHgmjv+lVBK
	8eO4C/7wZdcjrEIgvw/s/a2efgCsAOHw=
X-Gm-Gg: ATEYQzwc/9e7b6PEPsCsmSkexFrE/AXNKECYk0S8p2yieG6l2us+o+4zz8V8TBCjtw1
	A5zJBuvwxH4/iGhiZCrNMNh7vaIHWhoStmJ4Q3X0c5JW29wvS6gQUiMXfiMfMSSvFA4y6XRol2X
	/fQKtzXSbWkbzkIO7pX7YvEQPNOxIZZscLKR6spQy35/CEQQV83PsQty+75209/f0aV4yXb+VCR
	wljV49N0uV+Y135P7cUKxG0JDKl7pbEJa42nbDZxpzzvpoCmBxsDU2CXdLD0Mq45dPeqTBsddid
	btmrcZvOCHR5zZSWiDJ9j/acObSjTZfcAacWTE9JxhfuS8TdX2cXUvTkm2kW9/OlP4TW56OBoGQ
	mfLUiig==
X-Received: by 2002:a05:6102:2ace:b0:5ff:8b8:9f8c with SMTP id
 ada2fe7eead31-5ffaaf4b3bemr1900512137.26.1772669695494; Wed, 04 Mar 2026
 16:14:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771986861.git.lucien.xin@gmail.com> <08a63705058aff77dd54fb388870f0bca6036c95.1771986861.git.lucien.xin@gmail.com>
 <CAF6piCKOiwMz9Le2vBV4_W3R0NR3TW_je+ow4SCm5eX867awyg@mail.gmail.com>
In-Reply-To: <CAF6piCKOiwMz9Le2vBV4_W3R0NR3TW_je+ow4SCm5eX867awyg@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 4 Mar 2026 19:14:43 -0500
X-Gm-Features: AaiRm50hxZ3LZQ8rWfNDJR5FazO0dRJs8u8F_F7HjgEpz5HRVEpNVToAMcIZlRk
Message-ID: <CADvbK_dhG7LZaRnz9JihHtboQmTLmudptGF1P+w5gyi=6Ls_2g@mail.gmail.com>
Subject: Re: [PATCH net-next v10 15/15] quic: add packet parser base
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
X-Rspamd-Queue-Id: 7B1B62095CE
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
	TAGGED_FROM(0.00)[bounces-264100-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 4:16=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 2/25/26 3:34 AM, Xin Long wrote:
> > +/* Find the listening QUIC socket for an incoming packet.
> > + *
> > + * This function searches the QUIC socket table for a listening socket=
 that matches the dest
> > + * address and port, and the ALPN(s) if presented in the ClientHello. =
 If multiple listening
> > + * sockets are bound to the same address, port, and ALPN(s) (e.g., via=
 SO_REUSEPORT), this
> > + * function selects a socket from the reuseport group.
> > + *
> > + * Return: A pointer to the matching listening socket, or NULL if no m=
atch is found.
> > + */
> > +struct sock *quic_listen_sock_lookup(struct sk_buff *skb, union quic_a=
ddr *sa, union quic_addr *da,
> > +                                  struct quic_data *alpns)
> > +{
> > +     struct net *net =3D sock_net(skb->sk);
> > +     struct hlist_nulls_node *node;
> > +     struct sock *sk =3D NULL, *tmp;
> > +     struct quic_shash_head *head;
> > +     struct quic_data alpn;
> > +     union quic_addr *a;
> > +     u32 hash, len;
> > +     u64 length;
> > +     u8 *p;
> > +
> > +     hash =3D quic_listen_sock_hash(net, ntohs(sa->v4.sin_port));
> > +     head =3D quic_listen_sock_head(hash);
> > +
> > +     rcu_read_lock();
> > +begin:
> > +     if (!alpns->len) { /* No ALPN entries present or failed to parse =
the ALPNs. */
> > +             sk_nulls_for_each_rcu(tmp, node, &head->head) {
> > +                     /* If alpns->data !=3D NULL, TLS parsing succeede=
d but no ALPN was found.
> > +                      * In this case, only match sockets that have no =
ALPN set.
> > +                      */
> > +                     a =3D quic_path_saddr(quic_paths(tmp), 0);
> > +                     if (net =3D=3D sock_net(tmp) && quic_cmp_sk_addr(=
tmp, a, sa) &&
> > +                         quic_path_usock(quic_paths(tmp), 0) =3D=3D sk=
b->sk &&
> > +                         (!alpns->data || !quic_alpn(tmp)->len)) {
> > +                             sk =3D tmp;
> > +                             if (!quic_is_any_addr(a)) /* Prefer speci=
fic address match. */
> > +                                     break;
> > +                     }
> > +             }
> > +             goto out;
> > +     }
> > +
> > +     /* ALPN present: loop through each ALPN entry. */
> > +     for (p =3D alpns->data, len =3D alpns->len; len; len -=3D length,=
 p +=3D length) {
> > +             quic_get_int(&p, &len, &length, 1);
> > +             quic_data(&alpn, p, length);
> > +             sk_nulls_for_each_rcu(tmp, node, &head->head) {
> > +                     a =3D quic_path_saddr(quic_paths(tmp), 0);
> > +                     if (net =3D=3D sock_net(tmp) && quic_cmp_sk_addr(=
tmp, a, sa) &&
> > +                         quic_path_usock(quic_paths(tmp), 0) =3D=3D sk=
b->sk &&
> > +                         quic_data_has(quic_alpn(tmp), &alpn)) {
> > +                             sk =3D tmp;
> > +                             if (!quic_is_any_addr(a))
> > +                                     break;
> > +                     }
> > +             }
> > +             if (sk)
> > +                     break;
> > +     }
> > +out:
> > +     /* If the nulls value we got at the end of the iteration is diffe=
rent from the expected
> > +      * one, we must restart the lookup as the list was modified concu=
rrently.
> > +      */
> > +     if (!sk && get_nulls_value(node) !=3D hash)
> > +             goto begin;
> > +
> > +     if (sk && sk->sk_reuseport)
> > +             sk =3D reuseport_select_sock(sk, quic_addr_hash(net, da),=
 skb, 1);
> > +
> > +     if (sk && unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> > +             sk =3D NULL;
>
> Note that you could avoid the refcount if you keep using the sk in an
> RCU critical section. i.e. plain UDP does that. Same consideration for
> established lookup.
>
Doesn't seem easy to adjust the code for this, I will leave it as it is for=
 now.

Thanks.

