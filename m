Return-Path: <netdev+bounces-255484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oa7AIGNDfmndWgIAu9opvQ
	(envelope-from <netdev+bounces-255484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 19:01:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 195B7C3734
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 19:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A5DF30065EE
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866D6365A15;
	Sat, 31 Jan 2026 18:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pwIOK6Ca"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6657A33D6E3
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 18:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769882461; cv=pass; b=G14p4zosrQjpTcLlTL3VN1Ih2nRfnX+FKeTcCZ0X19vExYnOJjTbjlq5hxk6Y4H9snk6K77WdsYYFMNDN4FkBGBDuhMfGnfLr4ym9kGflhJTFD1+73L90RtV7BCjv9x9mOWjoigqM68zYsMlXT1fP2PqiR6i9M+7PK2NDW8Xps0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769882461; c=relaxed/simple;
	bh=x6EhicmvsIORcv2Wj/fthNPVt/aqXjI3o5YcJJ87xig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bdiZDtQndZ1hLSiDY7BFvCll69voYb6LNLoMX+UTahi7Dc8sqAe4TZHNDCcuaAJaigYWjEDRwIrsxt4BES6R69CY6Bna8FOpvPTgy/ZWjQZp7+FrvXc/tWpWNt/KRDYcFvmlLlC0l7Qhsvxj06XNImwGwkpkFNMCzTWIUFwX8pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pwIOK6Ca; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5029aa94f28so27346731cf.1
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 10:00:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769882458; cv=none;
        d=google.com; s=arc-20240605;
        b=hx9sYWidD7lnWg9vT7yPUb4nDZ9i3e8yzh8a4fRi6c119yDJGooTCAT7OUqjlqplXk
         L3hR8ZO66qOj44pVYLnG8WI/PWK0bOrNZoOqkyhM+1ZqLfbeXkajhVfA0sNh4IUZUYGy
         ty0nRne8co4pwN9NvbgG2lvZ+y/bJBeC+3C/uVOjc76w/Sn3RNybTq5M7sqHrR80SvtW
         SNp0bASmewdjJvKKYecfk4ZkkG8jOmkuPk5n/dst2jX/loX31q9WekdTSLazgQvx1DXg
         fCK6t7XtHFSe5FH6AQYzcHp6sQ5HHESB2gUFox+eP111bsb8uIInZlR4dBByrilXVPD5
         bXiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sgNckIufnj2Azhwp2/JuXSIz0qrsLqnvaLAyrHeRjA4=;
        fh=ARKuBZ1HVE67qZy9UsF0xrLaGRZu7izCp+gCdvEqrtk=;
        b=DKNvsWMlTM8dQxPmy4R38iOQKrfEt0fgqYNZnDdpa6RIDpz3wwItDLWjCelsI104tg
         EGfd1r+T6aH+TG7WJgraBWIG/hmEDKx7jFPUIxIQ1aOzffk2wxRtjp6Y4u2OOHpNUGOa
         +4bBGyIuU+G+Y3nCR3v1CkDre7wrK1BvTrKvSRvoxJk/MjLEqqkLE8txh6V8kjF6ofmi
         m+Ym6hqSJgDWWfUnK6D5XvjG5yv4t36l9S6elecflkO9c5y6Fyfd9LXAaeKSwewvwC6P
         W/A0ZygC+UK2nHWxnnJ01ldHNaTB7Fvy0DkPuYGxv2Fv3w35I7ikHGuTpdImnX72R8/s
         erSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769882458; x=1770487258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgNckIufnj2Azhwp2/JuXSIz0qrsLqnvaLAyrHeRjA4=;
        b=pwIOK6Cag1r3aoN4xYqqfPYv4MbDqp9RlIHxoN/junQpsVEmQN42lQ8w4YcV7tbXO0
         Zubt/5VTvfxKguGnx6+fp3YpAHyyEX6gJgl9/nV1qAw1g9dHdyPLmbMRiyowIsxZ64fj
         8HrzC+YEVFDqCkVEcQKHDR4+JygPg5/OKrsb9hLQz7rFu0nWju/7gPz2Tyz60IkD9Ura
         3yMWunodkcOZf3BTHruKSr5DmOBbsYCKIoX0FyzZueqffnXoyVHyIy8F7NDichnkn2Fb
         HK7f/RHgl9LFVVa+NMCJuAJs/LvDb4XAIYj4rSYvkiqKTuhA8xplELslDd1mGkqIQkBf
         Se9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769882458; x=1770487258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sgNckIufnj2Azhwp2/JuXSIz0qrsLqnvaLAyrHeRjA4=;
        b=dHiDbS6jY7ifjAUd/pz1xGTbZ3Bk642I3h8n4WmkHC5JtvAmRFNyaCXX+IOQcRCu44
         ZCCv6fKHYFlEOjFwW8Tnd8yFSksRp5P+w7cJ1vwwrtA9+MyXdaoexjxiKyFC34p8/ows
         2Zdmj9XhXdWmpy4pmqDVi3qmlGjqyjGwil5ELi9Rso9VQwzBOYigcWkbrDQoVB8xnee0
         PqmJBJZfQNJO2k4pI8D+xUxkjZnhlZNAAnNRKNYv4Zk3qSPT4vafd1lOfcCTwen1fgN5
         OXi+mkLh8jvRHqzsPkDLzSy4b6IjjkLx9e/WA2FrQE/jgB6eVPlyJQ9mPibu7ucMeoaE
         3Rkg==
X-Forwarded-Encrypted: i=1; AJvYcCX0xQmYPcNj/zVm+feYhTynGvvCgtjEhagu9ONcJi0cJUmInLb8UfuMo23RmKS2C52IS3l8YQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp7pFUPz7H3DUCBdBB81DYP9oGj8/UZghWcgzf0HXrPPaoh0Yy
	2LFZrE7UTqdR0WrwJBEYvH+mAdPblUuuEBf5M47WGMKazmJBB6IYh/FacTe8ttDKm+83TfWHRyj
	OjK/2Q4uHaJvxIfWWIcyFHPAl1BPbv6VSDT08jqz2
X-Gm-Gg: AZuq6aKipZNfy2reKJ+QfPUIhwzOkmrkLlQlgrQ4QHvsz3198AFiFht/dd3RkAVMGbt
	QAnA62yvkCvYIgsc0QS+st/8UBcQZGwj9Hjn8Zh+7KM4VwBwhRJYnRmgWqSFU0IkYRIIQdWcjZk
	itTFwvlOahun1nhryvqZCMoL+Csnrh8/74ydR8D7nKhn3P48n3/Zj4lXlTC9t5eAOPoH3jphMM4
	55smu8yhxkT4PWUaxjNb6w+tXMt5jLifBHy32/PeBioCOogW5Wc752ANzmN6Pbrk+g+yBIBE7za
	kzy+
X-Received: by 2002:a05:622a:342:b0:501:4ff7:2641 with SMTP id
 d75a77b69052e-5036a934216mr131835051cf.37.1769882457729; Sat, 31 Jan 2026
 10:00:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128070359.6762-1-fengwei_yin@linux.alibaba.com>
 <20260130191845.404c5e64@kernel.org> <willemdebruijn.kernel.39472926ed88e@gmail.com>
 <CANn89i+pv6ECtn5zrPYgUfcKkoEMF1BABfxQb13yTP41QhcGvg@mail.gmail.com>
In-Reply-To: <CANn89i+pv6ECtn5zrPYgUfcKkoEMF1BABfxQb13yTP41QhcGvg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 31 Jan 2026 19:00:46 +0100
X-Gm-Features: AZwV_QjIqDHn7ugPppv7WGJ1U_sl8a32sYbk19WHxOse6RGaiVS3HjK8rqBzcf8
Message-ID: <CANn89iKRRKPnWjJmb-_3a=sq+9h6DvTQM4DBZHT5ZRGPMzQaiA@mail.gmail.com>
Subject: Re: [PATCH] net: procfs: Fix RCU stall and soft lockup in ptype_seq_next()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, fengwei_yin@linux.alibaba.com, davem@davemloft.net, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255484-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 195B7C3734
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 6:50=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Sat, Jan 31, 2026 at 6:41=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jakub Kicinski wrote:
> > > On Wed, 28 Jan 2026 15:03:59 +0800 fengwei_yin@linux.alibaba.com wrot=
e:
> > > > The root cause is in ptype_seq_next(): when iterating over packet
> > > > types, it's possible that a packet type entry (pt) has been removed=
,
> > > > its dev set to NULL, and pt->af_packet_net is not initialized.
> > > > In that case, the function may return the same 'nxt' pointer indefi=
nitely.
> > > > This results in an infinite loop under RCU read-side critical secti=
on,
> > > > causing an RCU stall and eventually a soft lockup.
> > > >
> > > > Fix the issue by properly handling the case where 'nxt' points to
> > > > an empty list, ensuring forward progress in the iterator.
> > >
> > > > @@ -247,7 +247,7 @@ static void *ptype_seq_next(struct seq_file *se=
q, void *v, loff_t *pos)
> > > >
> > > >     if (pt->af_packet_net) {
> > > >  net_ptype_all:
> > > > -           if (nxt !=3D &net->ptype_all && nxt !=3D &net->ptype_sp=
ecific)
> > > > +           if (!list_empty(nxt) && nxt !=3D &net->ptype_all && nxt=
 !=3D &net->ptype_specific)
> > > >                     goto found;
> > > >
> > > >             if (nxt =3D=3D &net->ptype_all) {
> > > > @@ -267,6 +267,9 @@ static void *ptype_seq_next(struct seq_file *se=
q, void *v, loff_t *pos)
> > > >                     return NULL;
> > > >             nxt =3D ptype_base[hash].next;
> > > >     }
> > > > +
> > > > +   if (list_empty(nxt))
> > > > +           return NULL;
> > > >  found:
> > > >     return list_entry(nxt, struct packet_type, list);
> > > >  }
> > >
> > > I'm not sure this fix works, TBH, we're dealing with an RCU list here=
.
> > > The elements are not deleted with list_del_init(), so they won't
> > > look "empty".
> > >
> > > If the pt entries are under RCU protection I think the issue is that
> > > af_packet is clearing pt->dev before waiting for the grace period to
> > > expire.
> > >
> > > Willem, is there a reason for that or just convenience?
> >
> > That would be wrong. Do we see it doing that somewhere?
> >
> > These handlers should get removed with dev_remove_pack. Or
> > __dev_remove_pack and observe the RCU grace period some other way.
> > I can review these, but was not aware of any abuses.
> >
>
> packet_notifier()
>
> case NETDEV_DOWN:
> if (dev->ifindex =3D=3D po->ifindex) {
> spin_lock(&po->bind_lock);
> if (packet_sock_flag(po, PACKET_SOCK_RUNNING)) {
> __unregister_prot_hook(sk, false);
> /* removed without a synchronize_rcu() */
> sk->sk_err =3D ENETDOWN;
> if (!sock_flag(sk, SOCK_DEAD))
> sk_error_report(sk);
> }
> if (msg =3D=3D NETDEV_UNREGISTER) {
> packet_cached_dev_reset(po);
> WRITE_ONCE(po->ifindex, -1);
> netdev_put(po->prot_hook.dev,
>    &po->prot_hook.dev_tracker);
> po->prot_hook.dev =3D NULL;                       // pointer set to NULL
> }
> spin_unlock(&po->bind_lock);
> }
> break;

And other places as well...

I would suggest adding proper RCU protection to prot_hook.dev

