Return-Path: <netdev+bounces-298787-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id alSyOP1lLGrKQQQAu9opvQ
	(envelope-from <netdev+bounces-298787-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 22:03:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 828AE67C3C5
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 22:03:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RQVFQJ8c;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298787-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298787-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBC8031AC391
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 20:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5303B3BE2;
	Fri, 12 Jun 2026 20:02:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B03A3AB5DA
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 20:02:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781294576; cv=pass; b=B1eNXsbu6VLFGdnZAe6HWK/HfOwEfeyZ7thOqUVad8PN0UHNcIW40nW206VS6IvgT+VtPsWMnM6kWpvfHA9QtWWXHnYDVVwpiAk0cqSvO4XxAPjk7lGrl2b+eSqh9XqDc2GVf8m+QrT/3SBk7I9IylWVilnPbqCb8c7PCoPmcRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781294576; c=relaxed/simple;
	bh=eBM9QSHnNg0yWihYVzLeuUCGsIulxfJM0tYOquM7h3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcfDxmLzu3zmUPLtB+G3VwgQ2r3W2OWsxnezKT9/XNOjs7Ks2Ze1ChydKTlFxoZKR8Bfy9owPdOdwic4KgH6VKS6nw2Ouep1y/1244aLGPibUSqWFtd/oxqgdGfYQTX3QIshWIwt4zWnAEie1uWh9NjePd5ncbeKMaJBZpy2RcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQVFQJ8c; arc=pass smtp.client-ip=209.85.210.181
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84231305a80so872596b3a.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 13:02:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781294574; cv=none;
        d=google.com; s=arc-20240605;
        b=MC0EjeLcHvoR1gVb/I9wEcDOy64OrL/DDZGc0hNVUEUq+wESr0AjTR7uA7rb33diJw
         BuRWFo3Eg6CsnVBIuBS0KLv5BYUzAv4A3djfdTW6Or39sQ6UZ5GaemSpTJp/mv3+Mz0f
         cH0sg5uEldpNELFOK16GdUpno0hgO8PjRWtIG4itd0NaD0C5+KqNB1aUJfAVMcjZhxE1
         3Flt9Kzbjrg1d4/5LK19FslzK1n45bDGXA8yeKVXEMXPJjvvXxqkn91K91GJVES9AbB8
         XbNJ/OAEn0/3mS5AQdllip9jSIDFyb3/WKfUB85mm1QZLG/Km8J3fXLQC0bpeeVJo81Z
         DnVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/3ckXfoM94ds90NzKWwX8bgBQKTOJG1riGpLfhC5Wz8=;
        fh=64w4Cm65Oku8tiA/A6vBrY6EXrgvRqOIY54/EI5UbYU=;
        b=a/ASHvtE1xTSm6hNXngQ1OAEaMVUAb4CtQ3MaODIaOUrGxCxMJewBUc7uOketqiDIi
         RIROMH/ny/3F6q9ky3uMJQPWaGDQlM2lehjmNpcW5e8a7UXAx5BanffUGHLnaKDOmiTY
         0R+om3uaxc7S31xSt22FtCgxiwAF3TAG15kykfSNh/gcB+7wqADPuZ/ZBdOTr6KHnAgn
         Di0g0dHgsPZN0Tz0+Y/yRMeSqzjVqcmKGvEOCQ/LR0DmI6THaRpqYASW7qtZy6xXmi2r
         0sd3phT5a66GUCGOjc9kXaXXgvjyhzMCf/wazEG81737GHiWYKK8VYRWpGaBeWaJZo6j
         PFqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781294574; x=1781899374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3ckXfoM94ds90NzKWwX8bgBQKTOJG1riGpLfhC5Wz8=;
        b=RQVFQJ8cR6wHmJGDVyCbOj3f4dtfewL0GyFg1YiUpDhGs+Y5WhkjJUotSCdnH0txjj
         Ry6ILU1gB0ZxISjJVsN5aS0jxd9cRMkBXMD/OG1d1Dvq1DBGxFHkV/mBP/Atw+UtbHzg
         TdZEWxN6GFwhCxaa511lLD/n0Kkl6SaBRjfc0fYhY5pJY6ps/arxdAJSIXN9PPgHzf/Y
         sqkwfAoLyHzUwUqDjy7aIt0AP6FzkDH2bBWoK/jZoxj751780js8/ATUUyPEwxDhElpE
         BfzMSmcXiAJebvMpnmzPxDyRDWOwKLL+ivXNBjPVaDJwJZ0+EJMd3QaTVar+vqSHwZID
         DYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781294574; x=1781899374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/3ckXfoM94ds90NzKWwX8bgBQKTOJG1riGpLfhC5Wz8=;
        b=QmAEGIH9GjgE4Fb11ddycpsyu22ekWu65h6668mMqcJpVfNKzePuXnlotJSot4PG8A
         b2iHYgRf9MLaW/+IKqa4/zFLekHY5giocL+6vHd3OggTXmYpZoTjyVpudV4bupn4Rmcg
         KQLkeNjiPEnYtFwRpAkBsGFNGj9Y2cwrq82n7iLI2aIfM2GR2JjDWtuh8VU/kXwX24IF
         5WeFdlthtEzgiT7SJHnFgogLrv7zrDzWgocCXI+2AYHP5G15uuifdzjZcvT73ib44xA4
         mCKH9Mad66Xwj7Drogy4tI16B/rUCzk9Crzp9iWVze75JXfEjN+CpOo92oQBI7uGpYxh
         VpmA==
X-Gm-Message-State: AOJu0YwCYnh1ht9P6+zIoRlhthOgSPg9wU4FRLnyTWNTwpibklthoiAT
	88mmaCn1l8hdx04kta1bJJuiZuZvMPJwbCDpH89/i4JPdcW7o9U63SZdq+vrUhDT9CA6goaQL4g
	9KekNkrvvNZGYTdXPfcn4eCdXXRPlNtE=
X-Gm-Gg: Acq92OGjHL8GD9PGDeRgki34nI0GLHOYYvJtqckMeWtGeLAHBMB1GyuYFbbovS2L2hq
	8zxoM11eZWhnSKCjO/1Dj4wErBA8MFKotYdwcjBARGawyQphpeA6Y029vhoLJKqb1QuQqbXV/NE
	QvbFi+qxF1LWl9P+9/ITnouo7dqh45l/aLNDV2PX61rbkLD/LwR8qxxTcxVBzFNg2LvaBitS8fU
	xCRfB89V8WrdRdJBt5MTRbLHQCLltAYH8HV5DKv4DOcRIyFEu5VoYFuiPglASKpChxVSSQ2lAuf
	rSQFWqgBBuknI2fdNiz6xeBDRVJEYrHI760NqTdOj3jF4swgwp44pIrbIOBZHUWypP12PeN6rXz
	da8dpag==
X-Received: by 2002:a05:6a00:3e26:b0:82f:3828:a009 with SMTP id
 d2e1a72fcca58-844e1939ff5mr1193301b3a.3.1781294573804; Fri, 12 Jun 2026
 13:02:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0565988e6b54dac937fa00cdb3b09adef9650be6.1780855297.git.lucien.xin@gmail.com>
 <20260611081928.137149-1-pabeni@redhat.com>
In-Reply-To: <20260611081928.137149-1-pabeni@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 12 Jun 2026 16:02:40 -0400
X-Gm-Features: AVVi8Cfml8mlE4tV34oK4_w8pEjk-qeT6RUnEUAlc7Ph7rvhFYhaxjVtMLJiDiY
Message-ID: <CADvbK_efGf9t4HxtJtLVo2LBKM_N_mNQS_vLVadwk=o16X3jUA@mail.gmail.com>
Subject: Re: [PATCH net-next v13 07/15] quic: add connection id management
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, edumazet@google.com, horms@kernel.org, metze@samba.org, 
	mbuhl@openbsd.org, tfanelli@redhat.com, hepengtao@xiaomi.com, 
	dreibh@simula.no, linux-cifs@vger.kernel.org, smfrench@gmail.com, 
	linkinjeon@kernel.org, tom@talpey.com, kernel-tls-handshake@lists.linux.dev, 
	chuck.lever@oracle.com, jlayton@kernel.org, steved@redhat.com, hare@suse.de, 
	aahringo@redhat.com, dhowells@redhat.com, matttbe@kernel.org, 
	mail@johnericson.me, xiyou.wangcong@gmail.com, alibuda@linux.alibaba.com, 
	jbaron@akamai.com, illiliti@protonmail.com, sd@queasysnail.net, 
	marcelo.leitner@gmail.com, daniel@haxx.se, andrew.gospodarek@broadcom.com, 
	mef@scarletmail.rutgers.edu, paul@jakma.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:quic@lists.linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:horms@kernel.org,m:metze@samba.org,m:mbuhl@openbsd.org,m:tfanelli@redhat.com,m:hepengtao@xiaomi.com,m:dreibh@simula.no,m:linux-cifs@vger.kernel.org,m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:tom@talpey.com,m:kernel-tls-handshake@lists.linux.dev,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:steved@redhat.com,m:hare@suse.de,m:aahringo@redhat.com,m:dhowells@redhat.com,m:matttbe@kernel.org,m:mail@johnericson.me,m:xiyou.wangcong@gmail.com,m:alibuda@linux.alibaba.com,m:jbaron@akamai.com,m:illiliti@protonmail.com,m:sd@queasysnail.net,m:marcelo.leitner@gmail.com,m:daniel@haxx.se,m:andrew.gospodarek@broadcom.com,m:mef@scarletmail.rutgers.edu,m:paul@jakma.org,m:xiyouwangcong@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298787-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,davemloft.net,kernel.org,google.com,samba.org,openbsd.org,redhat.com,xiaomi.com,simula.no,gmail.com,talpey.com,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com,scarletmail.rutgers.edu,jakma.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 828AE67C3C5

On Thu, Jun 11, 2026 at 4:19=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> From: AI Reviewer <ai@example.com>
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> Now I have enough information to produce the report.
>
> commit e00266d0eea858a744fd827548eb8ebc6868f92c
> Author: Xin Long <lucien.xin@gmail.com>
>
> quic: add connection id management
>
> This commit introduces struct quic_conn_id_set for managing QUIC
> Connection IDs along with helpers to add, remove, and look up source
> and destination CIDs, including a global hash table for source CID
> lookup on the RX path.
>
> > diff --git a/net/quic/connid.c b/net/quic/connid.c
> > new file mode 100644
> > index 000000000000..b1a39feb827e
> > --- /dev/null
> > +++ b/net/quic/connid.c
> > @@ -0,0 +1,256 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/* QUIC kernel implementation
> > + * (C) Copyright Red Hat Corp. 2023
> > + *
> > + * This file is part of the QUIC kernel implementation
> > + *
> > + * Initialization/cleanup for QUIC protocol support.
> > + *
> > + * Written or modified by:
> > + *    Xin Long <lucien.xin@gmail.com>
> > + */
> > +
> > +#include <linux/quic.h>
> > +#include <net/sock.h>
> > +
> > +#include "common.h"
> > +#include "connid.h"
> > +
> > +/* Lookup a source connection ID (scid) in the global source connectio=
n ID hash
> > + * table.
> > + */
> > +struct quic_conn_id *quic_conn_id_lookup(struct net *net, u8 *scid, u3=
2 len)
> > +{
> > +     struct quic_shash_head *head =3D quic_source_conn_id_head(net, sc=
id, len);
> > +     struct quic_source_conn_id *s_conn_id;
> > +     struct quic_conn_id *conn_id =3D NULL;
> > +     struct hlist_nulls_node *node;
> > +
> > +     hlist_nulls_for_each_entry_rcu(s_conn_id, node, &head->head, node=
) {
> > +             if (net !=3D sock_net(s_conn_id->sk))
> > +                     continue;
> > +             if (s_conn_id->common.id.len !=3D len ||
> > +                 memcmp(scid, &s_conn_id->common.id.data, len))
> > +                     continue;
> > +             if (likely(refcount_inc_not_zero(&s_conn_id->sk->sk_refcn=
t)))
> > +                     conn_id =3D &s_conn_id->common.id;
> > +             break;
> > +     }
>
> [Critical]
> Can s_conn_id->sk be freed while this RCU walk is running?  The
> s_conn_id itself is freed via call_rcu() in quic_source_conn_id_free(),
> but the struct sock it points to does not appear to be RCU-protected.
>
> A grep across this series for SOCK_RCU_FREE and SLAB_TYPESAFE_BY_RCU
> under net/quic returns no matches, and quic_init_sock() does not call
> sock_set_flag(sk, SOCK_RCU_FREE), so sk_destruct() will free the sock
> synchronously rather than after a grace period.
>
> Consider this sequence:
>
>   CPU0 (RX path, rcu_read_lock held)        CPU1 (close path)
>   hlist_nulls_for_each_entry_rcu(..)
>     /* sees s_conn_id still linked */
>                                             sk_destruct()
>                                               quic_destroy_sock()
>                                                 quic_conn_id_set_free()
>                                                   /* unhash + call_rcu
>                                                      defers s_conn_id
>                                                      free, but not sk */
>                                               sk_prot_free()  /* sk gone =
*/
>     sock_net(s_conn_id->sk)         /* UAF read of freed sock */
>     refcount_inc_not_zero(
>         &s_conn_id->sk->sk_refcnt)  /* UAF refcount op */
>
> Once quic_packet_get_sock() (in the later 'quic: add packet parser
> base' patch) wires this lookup into every short- and long-header
> packet, an incoming packet racing with close() on the matching socket
> would dereference freed sock memory.
>
> Would setting SOCK_RCU_FREE on the QUIC sockets, switching the proto
> slabs to SLAB_TYPESAFE_BY_RCU, taking sock_hold() when the sk pointer
> is stored in s_conn_id, or otherwise gating the sk free behind an RCU
> grace period address this?
>

This is not an issue, as sock_set_flag(sk, SOCK_RCU_FREE) will be called
in quic_hash(), which will be added in the patchset-2.


> > +
> > +/* Check if a given stateless reset token exists in any connection ID =
in the
> > + * connection ID set.
> > + */
> > +bool quic_conn_id_token_exists(struct quic_conn_id_set *id_set, u8 *to=
ken)
> > +{
> > +     struct quic_common_conn_id *common;
> > +     struct quic_dest_conn_id *dcid;
> > +
> > +     dcid =3D (struct quic_dest_conn_id *)id_set->active;
> > +     if (memchr_inv(dcid->token, 0, QUIC_CONN_ID_TOKEN_LEN) &&
> > +         !memcmp(dcid->token, token, QUIC_CONN_ID_TOKEN_LEN))
> > +             return true; /* Fast path. */
> > +
> > +     list_for_each_entry(common, &id_set->head, list) {
> > +             dcid =3D (struct quic_dest_conn_id *)common;
> > +             if (common =3D=3D id_set->active)
> > +                     continue;
> > +             if (memchr_inv(dcid->token, 0, QUIC_CONN_ID_TOKEN_LEN) &&
> > +                 !memcmp(dcid->token, token, QUIC_CONN_ID_TOKEN_LEN))
> > +                     return true;
> > +     }
> > +     return false;
> > +}
>
> [Medium]
> Is memcmp() the right comparison primitive for the stateless reset
> token here?  RFC 9000 section 10.3 treats the token as a secret that
> authorises tearing down a connection, and the commit message states
> this helper is used during stateless reset processing on incoming
> packets.
>
> lib/string.c's memcmp() returns at the first differing byte (and
> performs unaligned word-sized loads on architectures that allow it),
> so the time taken to return false leaks how many leading bytes of the
> supplied token match a stored token.  Would crypto_memneq() from
> <crypto/algapi.h>, which is constant-time, be more appropriate for
> comparing the token bytes?
>

OK, will change to crypto_memneq() and replace 4 similar places.

> > +
> [ ... ]
> > +/* Add a connection ID with sequence number and associated private dat=
a to the
> > + * connection ID set.
> > + */
> > +int quic_conn_id_add(struct quic_conn_id_set *id_set,
> > +                  struct quic_conn_id *conn_id, u32 number, void *data=
)
> > +{
> [ ... ]
> > +     /* Locate insertion point to keep list ordered by number. */
> > +     list =3D &id_set->head;
> > +     list_for_each_entry(common, list, list) {
> > +             if (number =3D=3D common->number)
> > +                     return 0; /* Ignore if it already exists on the l=
ist. */
> > +             if (number < common->number) {
> > +                     list =3D &common->list;
> > +                     break;
> > +             }
> > +     }
> [ ... ]
> > +     list_add_tail(&common->list, list);
> > +
> > +     if (number =3D=3D quic_conn_id_last_number(id_set) + 1) {
> > +             if (!id_set->active)
> > +                     id_set->active =3D common;
> > +             id_set->count++;
> > +
> > +             /* Increment count for consecutive following IDs. */
> > +             list_for_each_entry_continue(common, &id_set->head, list)=
 {
> > +                     if (common->number !=3D ++number)
> > +                             break;
> > +                     id_set->count++;
> > +             }
> > +     }
> > +     return 0;
> > +}
>
> [Medium]
> Does this function correctly maintain id_set->count when a CID is
> inserted before all existing entries?  The loop above explicitly
> handles the "number < common->number" case, suggesting out-of-order
> insertion is intended to be supported.
>
> Consider starting from list=3D[5], count=3D1 (so first=3D5, last=3D5) and
> calling quic_conn_id_add(..., number=3D3, ...):
>
>   - The location loop sets list =3D &common(5)->list and breaks.
>   - list_add_tail() inserts common(3) before common(5),
>     yielding list=3D[3, 5].
>   - The post-insert check evaluates:
>         quic_conn_id_last_number(id_set)
>             =3D quic_conn_id_first_number(id_set) + count - 1
>             =3D 3 + 1 - 1
>             =3D 3
>     so the test "number =3D=3D last + 1" becomes "3 =3D=3D 4" and the cou=
nt
>     update branch is skipped.
>
> The end state is list=3D[3, 5] with count still 1, so entry 5 is
> silently uncounted.
This is expected, count only count contiguous connection IDs.

> A subsequent quic_conn_id_remove(id_set, 3)
> then trips the WARN_ON_ONCE(number >=3D last_number) because
> last_number reads as 3.
>

This will never happen, the callers will prevent passing the last
seqno to quic_conn_id_remove().

Thanks.

> Should the count adjustment also handle the case where the inserted
> CID lowers first_number?
>
> > +
> > +/* Remove consecutive connection IDs from the set with sequence number=
s less
> > + * than or equal to a number.
> > + */
> > +void quic_conn_id_remove(struct quic_conn_id_set *id_set, u32 number)
> [ ... ]
> --
> This is an AI-generated review.
>

