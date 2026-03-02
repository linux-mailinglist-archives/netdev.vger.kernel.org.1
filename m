Return-Path: <netdev+bounces-262784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EY1AknfpWkvHgAAu9opvQ
	(envelope-from <netdev+bounces-262784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 20:04:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F321DE999
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 20:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C31183003BFB
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 19:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7D631B131;
	Mon,  2 Mar 2026 19:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AtxPzpXk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B90330D27
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 19:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772478274; cv=pass; b=ld3GJYhgm7uj+RMKfSs+yFSzlSgGUFTntxBYdEF66KGeSXmbqnqK6WbaB9MfRR+8soJcLrS3YqIvP6we9uEICE8IkNFvWl4QvQtXNifl3CEOdBimROwq2PeLV5umoNKPw/BMbxR3DOX52Zs6sWTJpLDHNSzaE00D/NeVd+AYkJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772478274; c=relaxed/simple;
	bh=iaV4ZZSm5IfDxIWbZdv1Xe5KHTf3l7PSHCaE09Zv0/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZsbZEKwDKqb2cwl4anEE8rxw0lKTyoAri5cjIMcREf4qx3QeWQMif1dgWGWaQ1kuNPxk4Bnr/KU+IZDBhYih0sJqb3bfhOa8tEiiQZKIZokPE2EQv3tOrrdYEvVYBHPt0aFAVsgP7n6OIaFmck3IsErRaabL/pW3rn8eitoTq4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AtxPzpXk; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1275750cfc7so899324c88.0
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 11:04:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772478268; cv=none;
        d=google.com; s=arc-20240605;
        b=A1bWqqAPzLVtWE9VzvqSUziGkQOXvqn1EKU2cpY+X+ANCOYl+niufbQteeI36SvlfF
         qtexqBhXOStRzX5KDjMjIDMkhtgroZaSfmqsdQsJ9TX+11gRalvrFB4CkIHA3qxdxWbv
         CwABEynH7Ql008GltaM7o03TC6bO+xWMKDAIunSxX6e4PwYGdyB346oM7TmCNWiOhYZX
         HI7ZtcQzXizyU4iLvm6y3F5IjQKxKGAY9hksEBzb50dT/JBHx9kICaDaa2cAlI0AtJyw
         CRT6ZFi+y/9Os1W0NkzBoJrwOZFEV1jghOzJ4Z5zapsxiqDp/FUqWskst7M2thV8LgZ4
         Y16g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CnTgWycVTJcgSF7BZ25W3n3Ihq0kMTnpBefWNp/Qjq8=;
        fh=36/VSJVVKLbIvlHy2ZZlnU83RLnzPS8vYNGT192JU7g=;
        b=CO3SEMxqxh3b5Hw240uGLaMyS/whmgVZKnXsjLMgaTejx9cLVL2g+tj6kWa+ehh28L
         TXA1ux+t0V37xq3V1FfPsFhL1gZNTyQzQ9e47gikZzOT2ZwMAGqlb0V/sKQULBksba8A
         9sHnBpJmgYpGl3KGjOS6rk9VuiQGfsBzrZQ4gJk33XQYcSYi68o3rhzp1RTcJ0k+Mu4T
         I0vTYMrjI9RiW1vF/9J0bjmnuxBDKmpm9dKCccm7FhJ1U6QXgT8+TMTv/sx6+aFYSVAz
         O0X//qFGCLVPrSLJdFUMwZep2MC5QgSrSedu45VrsCsmxFUAqhs9s/PexN2tOOvLfw9O
         VWTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772478268; x=1773083068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnTgWycVTJcgSF7BZ25W3n3Ihq0kMTnpBefWNp/Qjq8=;
        b=AtxPzpXkFSXzOncKBgHKYHZqwTD/wBngutWJxGuCPsoQoJraFE4BTOFByL6StqWw2J
         x3xYf1HklLptppspH50IrazjZYR+GsWQAOBdd1+MxlRGR5WvZs5p/t9LPOohK2eYeMQC
         21tPHUd4hWs2JXt/hZDNZwK3SRlCaBjsO1ofHWvRgdrdAgyFjkmIOFh8We5UU/eCq6HE
         U/d9dXbFyy6l5fb/lEYyKdGIxtCuZM3UnkHQ7xTHvytXUWLmS70AhiKEZJarHLUmFJ0A
         0Nt/pBUk/tvwdT4IzNDHtlWuQxuvmPMwWZURGySxmAvVOkKWuytjKk4WkfUGCAm/Qiia
         3+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772478268; x=1773083068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CnTgWycVTJcgSF7BZ25W3n3Ihq0kMTnpBefWNp/Qjq8=;
        b=AXGEYDpLKchMuzdFVihCAJo6qq5ApZ32rgfRzfHUGnuo4YP9IDcvaOsQ7n2SVFz80V
         Lx3bSixA1riFI87+yqQXsBkyeJOr7ExqUaqqSw3TZWsCtZvlYIokGjIMey4hwcKvEdOs
         ubrd/GhpGncoPbb46vGCl7HU65s0BNY/+Wd2juoiK9mEdP/EmIfapS+DCzlWVFiwQceP
         7EY6FaIqjuAOOF1UYlwLyzr+Rj43f08NO4Fx6/yjN+h2ajRoHl9AGi92aEZpSlWFwyjC
         SrjJghaOgTEr5ysTXN5wfiWIGLfvFJIj5xiIbtVYsDZIeGMZ9Ys5UQnyrEKwQONGxuxe
         wkVg==
X-Forwarded-Encrypted: i=1; AJvYcCWpj6KN2YIGhqRd8d7Jg/v7CAAWQuB4LQUpJXknzEGS8nU8fMB3DrH7PJ1U5HK80aPb/ImWFss=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcQtIKeOmdTVNh+WVLezH/q9edOU01m4NDaIhHUM/I153nWOAM
	rgorI/fdMvFTH4EHxjYczo7NzLQ82sQTUGUTC/ePO52LDuCV70NmdIlndCtoYlDGU5rpy5/q0uu
	W4My2/7hCp5Avp1ttwyCK40YPoWR3yZPQHGrk+Dlq
X-Gm-Gg: ATEYQzyVqQFxsJ7vtVnBVDSUDXaicw5qCmR0OZmLK7ksje34DeJ1quJ15QRGyUcESBN
	x38n4+lFVr7f5d5Xsbcv2yuOJm9ebnMcQaK2hTyaTdqp35ADTGb1nMIVgQ+/z0aS+HEfy5ge+bs
	Eh/81qEgs5cIKXhGmktanrSn+L/WUCjcXcFrAaawRwn0HEqiX3fOI5jFt7/Vby9tr9hnKW7e8IZ
	GjRFQgMHR3oMo/jsQ3slW5pduBmlU2aaHTZG0Ua+yWyd0SaVuFGtmCitQzgfvGFBUnAPDWb11Q+
	c9WZUUOzdmkLqbxZCqqhpwX0mOS2fAiz41tkTnAMJVwOKH110Bor5D9wFdMIOm/jBksowm6D
X-Received: by 2002:a05:7022:4583:b0:127:5cda:fb7d with SMTP id
 a92af1059eb24-1278fc2c5fbmr6725903c88.6.1772478267810; Mon, 02 Mar 2026
 11:04:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228221800.1082070-9-kuniyu@google.com> <20260302131218.679806-2-horms@kernel.org>
In-Reply-To: <20260302131218.679806-2-horms@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 2 Mar 2026 11:04:16 -0800
X-Gm-Features: AaiRm52f4neOROzS8PSpA-Ua4K4XoMGuAP4z2XAso4A5gDKi-QEm07GtG0vvHDg
Message-ID: <CAAVpQUBPkufdBby+WdQx4Tsbz_UwaziENX6V1tW64ao2v79qhQ@mail.gmail.com>
Subject: Re: [v3,net-next,08/15] ipmr: Move unregister_netdevice_many() out of ipmr_free_table().
To: Simon Horman <horms@kernel.org>
Cc: edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, 
	netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net, 
	kuni1840@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 04F321DE999
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,redhat.com,kernel.org,vger.kernel.org,davemloft.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-262784-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 5:12=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> ipmr: Move unregister_netdevice_many() out of ipmr_free_table().
>
> This commit refactors network device cleanup in the IP multicast routing
> code by moving unregister_netdevice_many() from ipmr_free_table() to its
> callers, enabling batched cleanup across multiple tables per netns.
>
> > diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> > index d15e05662b09..7e2aa2026f01 100644
> > --- a/net/ipv4/ipmr.c
> > +++ b/net/ipv4/ipmr.c
>
> [ ... ]
>
> > @@ -349,8 +355,13 @@ static int __net_init ipmr_rules_init(struct net *=
net)
> >
> >  static void __net_exit ipmr_rules_exit(struct net *net)
> >  {
> > +     LIST_HEAD(dev_kill_list);
> > +
> >       ASSERT_RTNL();
> > -     ipmr_free_table(net->ipv4.mrt);
> > +
> > +     ipmr_free_table(net->ipv4.mrt, &dev_kill_list);
> > +     unregister_netdevice_many(&dev_kill_list);
> > +
> >       net->ipv4.mrt =3D NULL;
> >  }
>
> In the !CONFIG_IP_MROUTE_MULTIPLE_TABLES version of ipmr_rules_exit(),
> does this sequence lead to a use-after-free?
>
> ipmr_free_table() calls kfree(mrt) to free the table:
>
> net/ipv4/ipmr.c:ipmr_free_table() {
>     ...
>     rhltable_destroy(&mrt->mfc_hash);
>     kfree(mrt);
> }
>
> Then unregister_netdevice_many() is called, which triggers NETDEV_UNREGIS=
TER
> notifications. The global notifier ipmr_device_event() handles this event
> and calls ipmr_for_each_table().
>
> In the non-MULTIPLE_TABLES case, ipmr_for_each_table() expands to:
>
>     for (mrt =3D net->ipv4.mrt; mrt; mrt =3D NULL)
>
> Since net->ipv4.mrt still points to the freed memory at this point (it's
> only set to NULL after unregister_netdevice_many() completes), won't
> ipmr_device_event() access mrt->vif_table and mrt->maxvif from a freed
> slab object?
>
> The CONFIG_IP_MROUTE_MULTIPLE_TABLES version appears safe because
> list_del(&mrt->list) removes the table from the iteration list before
> kfree().
>
> Should net->ipv4.mrt =3D NULL be moved before calling
> unregister_netdevice_many(), or before calling ipmr_free_table()?

Exactly, although the bug disappears in the next patch,
I'll fix this in v4.

Thanks !


>
> > @@ -425,18 +436,16 @@ static struct mr_table *ipmr_new_table(struct net=
 *net, u32 id)
> >                             ipmr_expire_process, ipmr_new_table_set);
> >  }
> >
> > -static void ipmr_free_table(struct mr_table *mrt)
> > +static void ipmr_free_table(struct mr_table *mrt, struct list_head *de=
v_kill_list)
> >  {
> >       struct net *net =3D read_pnet(&mrt->net);
> > -     LIST_HEAD(dev_kill_list);
> >
> >       WARN_ON_ONCE(!mr_can_free_table(net));
> >
> >       timer_shutdown_sync(&mrt->ipmr_expire_timer);
> >       mroute_clean_tables(mrt, MRT_FLUSH_VIFS | MRT_FLUSH_VIFS_STATIC |
> >                           MRT_FLUSH_MFC | MRT_FLUSH_MFC_STATIC,
> > -                         &dev_kill_list);
> > -     unregister_netdevice_many(&dev_kill_list);
> > +                         dev_kill_list);
> >       rhltable_destroy(&mrt->mfc_hash);
> >       kfree(mrt);
> >  }

