Return-Path: <netdev+bounces-303317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E88oGX4IRGoengoAu9opvQ
	(envelope-from <netdev+bounces-303317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:18:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F19186E725F
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:18:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=U+FEk1EO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303317-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303317-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8E8230328D8
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EBA3E0749;
	Tue, 30 Jun 2026 18:18:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03523DF00C
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 18:18:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782843516; cv=pass; b=tNGRFh3SdGGhakJaaWgytPnkyVA6P3z7Z9iDagDlPXnuftLIXXVr6AyqHzbBXOEs424ACAWkjPTRs2zTLn6aSc5k+1eDZSS+Rq6HQlmhdZqE8wKciJccyaNJLbId+VL0RWXyeCwZZf0lFbTLECu/pRk5G/7ENBvalVbBNnDt4OE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782843516; c=relaxed/simple;
	bh=D7pWqv9qadXnG7/eNmqv6/JPm+vTpfQ/ezdHwN6Ik7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ib7A456k4+qNyvWLJY/r06lUyoRFm7vLFaAsdX1XEtCvcQS4gsHMiX5NsF/dL0og4vrJ5qiBInS1YQl40vzIp7UqjFFtDgmFFKaNKvGumaNHMgRr/ON+nh489KjxhIcTjURunCcWGPsWnktc4bJzuCv6NEWgN5gCGBADTYeqBDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=U+FEk1EO; arc=pass smtp.client-ip=209.85.210.170
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84347ad88edso4148495b3a.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 11:18:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782843511; cv=none;
        d=google.com; s=arc-20260327;
        b=doggLZc633koeIQeoDY8omPAMVYZC1GOe5ZPHzE0JTpPgS47KuirPfgWsOKZhh2+7S
         MCf44VinQR8ooCMnKYGufIcZ5r+2sw6WWS7ZcxulvJdN7JamAaQ8NDwG+Ez/kSi4pxfq
         Ymep5MRSOGJqffAk3+rWiUXg1VQ8VgHUopvEjtFDlXTn1V7f9eIMekggUwC7u7mnX/nM
         fx4GfsMimIicTVyebUUX7levH7xGvbLkopH9yHJUmef/IZ6LVw96HacdQgcMxW771aSk
         aUxxpw3QAKNDvLDO5sIa6Un62iUpXnnPOswk5D5SaCAPT11qdLezAgI6X3v4l01pUAlh
         8mpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jHHcQEADeEYM8NgWJTNCVWKKAnE3ygKO49DHhHbmJ18=;
        fh=QdTTXFJdEk8eCovqHDwH/hdJDZl5nEtkCSQnE9Ewp0I=;
        b=na6W5e+ULJ/6KK4f/YcJIKN4p7HgKhzm+7BHo1GQTYhcaxwhnZ0OOfCVw1XQXhDuGB
         9pPccg5m24zNu/WEpjVpQ5LcejmFh6ut2/foupQX2irG8tQTsQsJwadR6bY+GkCg80Em
         MmNUFDSxFLXV1qHMwsFCBI9PxXGiFYqElwJEHG2lCkaDisCv5GZXOuka5gAHmP8MMOci
         cc6VWorK9e+JEO4DfFEiOsid60aINZA8eVAEU2rz4K/Rf54p1Z+QcVlhndyjDi4TZfoe
         mYK+2ch2IiddBiq7/ZJ6mV1OueAw1pCOsmVKtnH2W/UkItmLVa5oLWy0TzrxhU4yHP/E
         f0ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782843511; x=1783448311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHHcQEADeEYM8NgWJTNCVWKKAnE3ygKO49DHhHbmJ18=;
        b=U+FEk1EORjslgWxiCYj0ayv2t1GotS7aUy5prhuna+y+J8WiDx9vGL8Cw9uuTGqkWJ
         A3GQoA8i5K2WAjo8aLv94iApIRwmXHeGVlF34puyjvSeNBL0kaspRa25TKVg1P4lGcgE
         TP4k3S5gclJv2kUU4fRk3M2qmpc9oplrk/ee6p63fSVEcOIHFAESktlapU2JMjOjY3xK
         PRm1hzUSKMqPCzkgR6TtfSXSSsB5El31q5Xg92xZAFOJd4QAFQOlne/e386E0UkwbTfm
         /4Yr79cMLyVnJmcfA1cu5ku/NtM3WsjR1FWnM1460tqj1li27osLoCtyhABWghguVCoH
         ONGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782843511; x=1783448311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jHHcQEADeEYM8NgWJTNCVWKKAnE3ygKO49DHhHbmJ18=;
        b=UWznWKINgJbm1NbiVLCSDEzkADDwjxG+kkspOQLrVO7dbJc8r1ex8GevxmBXFvXnV+
         K7Opf9YeD3RuT5pvSePRCqWNpCZ5P7M/b9YqggBdsTSrLIRtfLfnr8FRowzSZI+7M6uP
         UR+t6zzHgBnKI03oXm+JtLl2UKuBz4+YAIOLpXhKv7zVfgYJBwt2BUiaeadERNfqCxd4
         I+TRuzRLAU92daEsj9ci1IX0Mqvm5Q+reTNWLJRyzQfuiIe+SdKaS9vT3DZmJpMr4xak
         tIfHwk5/qsl5F/GM328XxW6p62BbQg6nVAnynRCCh+/m1vozXrGKl+9pi1WiwWGXpsUA
         bN+g==
X-Forwarded-Encrypted: i=1; AHgh+RrFZ/CQpKegasaXVx+xJDlIcRtNxny07ua+K7Ptb+6erih9drVwRAZz/1l4KnVVGFEi/vfFYGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi4YM5tmye8egIiCnMaWbguu8PiXNEqrA2AmFAPR7W8PDgERZ3
	Z33NixoZ/iww9+bW0Elr678m1+z1vypeIDq3+CYun27boRl7i2CZhsBdTJBou/RRt+TDPcd+oH4
	89w4g8o3aon2e3hFISykUaBGcfYE63GgXdOUe/iBb
X-Gm-Gg: AfdE7ckupdMDvzKO3GtsAK8pSAbvKfbdOY5/VGq638KN9fADhpfG7LOGGPh2cJEgBz0
	OjsH4wvKfrAyQoA9Fj6mmXoHPmRsgesA1hGHkBeFe9TCSNP3ZKX0xNs3KcqoA/NJHDjXEIG9YAK
	br8MbqIv6K90k2CrwDBfF7Et/6QLjpMS9WLejApL6JoKfncCvJlGJjxJyWBXpjJSh9Igcx0XwGQ
	snQBHp/Pqd5YvDZ5kS6CFrEdWdY6T1JaZFz72mv4RJV6l5W6RVXSIpPiluRuWYepcIFl+1XWu9o
	yjlW0Dor/E7qW8MX7ZLurX2ssTu4
X-Received: by 2002:a05:6a00:b93:b0:847:9178:f396 with SMTP id
 d2e1a72fcca58-8479eef471emr4195023b3a.16.1782843510931; Tue, 30 Jun 2026
 11:18:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627014948.3049512-1-xmei5@asu.edu> <cbd7c6c1-15e9-4a9a-aaca-4cbb5bd157c7@linux.ibm.com>
In-Reply-To: <cbd7c6c1-15e9-4a9a-aaca-4cbb5bd157c7@linux.ibm.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 30 Jun 2026 11:18:19 -0700
X-Gm-Features: AVVi8CcyJq-cPQIEnlscPzhDQpAH5DOCEd3nRx8zRWlCVhBcIiSkb9NH_NYuMpQ
Message-ID: <CAPpSM+Sbro9psvZGmQ4cpm=wRMc9M-nHXxdzsgkL35hHDSCCaQ@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: fix UAF in smc_cdc_rx_handler() by pinning
 the socket
To: Sidraya Jayagond <sidraya@linux.ibm.com>
Cc: "D . Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Wenjia Zhang <wenjia@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>, 
	Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
	netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Hans Wippel <hwippel@linux.ibm.com>, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, Weiming Shi <bestswngs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sidraya@linux.ibm.com,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:wenjia@linux.ibm.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:hwippel@linux.ibm.com,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:bestswngs@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-303317-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux.alibaba.com,linux.ibm.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F19186E725F

On Mon, Jun 29, 2026 at 10:40=E2=80=AFPM Sidraya Jayagond <sidraya@linux.ib=
m.com> wrote:
>
>
>
> On 27/06/26 7:19 am, Xiang Mei wrote:
> > smc_cdc_rx_handler() looks up the connection by token under the link
> > group's conns_lock, drops the lock, and then dereferences conn and the
> > smc_sock derived from it, ending in sock_hold(&smc->sk) inside
> > smc_cdc_msg_recv(). No reference is held across the lock release.
> >
> > The only reference pinning the socket while the connection is
> > discoverable in the link group is taken in smc_lgr_register_conn()
> > (sock_hold) and dropped in __smc_lgr_unregister_conn() (sock_put), both
> > under conns_lock. Once the handler drops conns_lock, a concurrent
> > close() -> smc_release() -> smc_conn_free() -> smc_lgr_unregister_conn(=
)
> > can drop that reference and free the smc_sock, so the handler's later
> > sock_hold() runs on freed memory:
> >
> >   WARNING: lib/refcount.c:25 at refcount_warn_saturate
> >   Workqueue: rxe_wq do_work
> >    refcount_warn_saturate (lib/refcount.c:25)
> >    smc_cdc_msg_recv (net/smc/smc_cdc.c:430)
> >    smc_cdc_rx_handler (net/smc/smc_cdc.c:502)
> >    smc_wr_rx_tasklet_fn (net/smc/smc_wr.c:445)
> >    tasklet_action_common (kernel/softirq.c:938)
> >    handle_softirqs (kernel/softirq.c:622)
> >   Kernel panic - not syncing: panic_on_warn set
> >
> > Only SMC-R is affected. The SMC-D receive tasklet is stopped by
> > tasklet_kill(&conn->rx_tsklet) in smc_conn_free() before the connection
> > is unregistered, so it cannot run concurrently with the free.
> >
> > Take the socket reference while still holding conns_lock, so the
> > registration reference can no longer be the last one, and drop it once
> > the handler is done.
> >
> > Fixes: d7b0e37c1ac1 ("net/smc: restructure CDC message reception")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> >  net/smc/smc_cdc.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
> > index 619b3bab3824..b809139d7e87 100644
> > --- a/net/smc/smc_cdc.c
> > +++ b/net/smc/smc_cdc.c
> > @@ -483,21 +483,27 @@ static void smc_cdc_rx_handler(struct ib_wc *wc, =
void *buf)
> >       lgr =3D smc_get_lgr(link);
> >       read_lock_bh(&lgr->conns_lock);
> >       conn =3D smc_lgr_find_conn(ntohl(cdc->token), lgr);
> > +     if (conn && !conn->out_of_sync)
> > +             sock_hold(&container_of(conn, struct smc_sock, conn)->sk)=
;
> > +     else
> > +             conn =3D NULL;
> >       read_unlock_bh(&lgr->conns_lock);
> > -     if (!conn || conn->out_of_sync)
> > +     if (!conn)
> >               return;
> >       smc =3D container_of(conn, struct smc_sock, conn);
> >
>
> Fix looks correct.
> A few nits on the implementation:
> container_of() is called twice for the same conn. The conn =3D NULL
> sentinel and the second post unlock check can also be dropped. Flip the
> condition, early return inside the lock, compute smc once:
>
>         if (!conn || conn->out_of_sync) {
>                 read_unlock_bh(&lgr->conns_lock);
>                 return;
>         }
>         smc =3D container_of(conn, struct smc_sock, conn);
>         sock_hold(&smc->sk);
>         read_unlock_bh(&lgr->conns_lock);
>
> Also please initialize smc =3D NULL at declaration, it's not a bug now
> since the early return guards it, just to make it refactor safe.
>

Thanks so much for the review!

Both suggestions are good. v2 takes the reference under conns_lock and
returns early inside the lock. And smc is also initialized to NULL at
declaration.

Will send v2.

Xiang


> >       if (cdc->prod_flags.failover_validation) {
> >               smc_cdc_msg_validate(smc, cdc, link);
> > -             return;
> > +             goto out;
> >       }
> >       if (smc_cdc_before(ntohs(cdc->seqno),
> >                          conn->local_rx_ctrl.seqno))
> >               /* received seqno is old */
> > -             return;
> > +             goto out;
> >
> >       smc_cdc_msg_recv(smc, cdc);
> > +out:
> > +     sock_put(&smc->sk);
> >  }
> >
> >  static struct smc_wr_rx_handler smc_cdc_rx_handlers[] =3D {
>

