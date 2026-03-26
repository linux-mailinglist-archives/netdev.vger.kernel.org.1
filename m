Return-Path: <netdev+bounces-271844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPNvNI3CxGku3QQAu9opvQ
	(envelope-from <netdev+bounces-271844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:22:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5CB32F56F
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 011733058BCB
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 05:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1482838E132;
	Thu, 26 Mar 2026 05:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8arjRtF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8573638F937
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 05:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774502501; cv=pass; b=KsIWw9wEhCf9K/UibdqXGem10mssKQG2cSq3slBiGWLuVqAoFFXZsbi5qEI7WLABWk3NR4jRZwgFfvJTywdskVpBptemGrhlFP8eAMefdBQtN77NmH7Y4bkSl/jg1UvYwZACLRqDGR52wEnSyz7aMYGkM+0bJxEELYb2VXNkm6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774502501; c=relaxed/simple;
	bh=TwOjNawHZcvu6bKAZEd7yNNLUF2uchJ7ieTotE8bpHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OkS3C9s4O1nC7fbZDXXLHtjp7ap0Po5UyTLRASpNh89gYtQSjuA1cQDxyMibkR32sJA3qGEYFkeGxkLHnOePq2c2ll3osTnR6oe1wAe94XeDffmqdPUCxp2WcuaiUHv8ZgwCkhnoa6cistJGR/XzohlunJtiU0ud3Xogk3zz50A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8arjRtF; arc=pass smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-67c250b84fcso12260eaf.2
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 22:21:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774502498; cv=none;
        d=google.com; s=arc-20240605;
        b=C6ZIcD8eMrcT86KCPjEdoH3YfdIZOQ8pOnWg76NHZGucCHE7Y3jUniW5s+UeNU9JyE
         cC4R/qJ5ATUuBB7KKl9ucdUGnG5WKKz7sWPsBHzMqvia6kYYdMVEai4gFqIbDl4VAh3i
         DShUZvpXI0svmcqVEgDvcsJaKjxGpyHB8O7EHx4eopxY2nyB4O9TbEZwQIcEbqnZLKZV
         p8hVUxLeapGlWSZVmzZHNdRjQzTdZcer4Kc+QGRqsmtYGpIb4obKkN+pQN0V40n7aAlv
         j7vfZIyArDjV6tFZpWziXTsuXUCjpSc1gX8ciIqMFzqhktG003WpX8AmFWSvVL64U+QC
         zFZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KBXxT7A4addWnwUC4Ooc5v2872Ii1RAK/n+C1wI/nxQ=;
        fh=MO4kOiRoSmSqy560U29XlA0H8ig6s4aWpNTErF0Y/u4=;
        b=BmjJZhahl29tQM/T7w4MkLB5YEo/62q5uEvyZ3arMV8wqnqtCvCM1QgW6WiLcfbcOT
         EnfmoJgZzA4DYok4G6d4KMLMGMnyRk5fwQ6JXLyhpMf3ypTRlfqKNVsEofOU0G77vePo
         veVcX459So6mGL2W0OwZ0oCfGUGx0EeuTkwmbyQI84PwZoi3NjAGnPKxhF5PxnvQwV/M
         ePwQN0x0CMXwbiQkwyeKLweiaUUFlliKfpiyDBiDyJXCK7VvpYMHmi3e82z4uat4rrbe
         ojfaho8yGhhJYL+rZuoqR9gfcMn/PzpuYnMS0uP64k+56guMHG9if+hKJZnzUp+/2ns4
         zHIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774502498; x=1775107298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBXxT7A4addWnwUC4Ooc5v2872Ii1RAK/n+C1wI/nxQ=;
        b=U8arjRtFL7Vfce6t0N0chGbVCfe0/+OpupwIDw2mP39m8LhSAoqbok8y/CanOePmpi
         GIcLzuJ1NUbu+ndqz5Z5W0G89F1t8BH7Qt74SIyrd+sSbgsL5TAnPLppMq5iECq2mLVR
         dLAVppGJ/epaOpABUnIWuSmEYUrwISyhEx6iYHeJ5Quy3hI3RiN7NRBPL07CFNDciRib
         t7aZB1Dbdat73q3oWYAnTh0huLmbiuGrj+ruxW9d3VjTziOi4UGaq+fObvId9NeIzKr9
         gv0dckHzfbM75BJ7UNzRUNFrzUZAgIMzoJgdT/XcICZulmXE41fpVgcqH9nWV2ZaYzGD
         c0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774502498; x=1775107298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KBXxT7A4addWnwUC4Ooc5v2872Ii1RAK/n+C1wI/nxQ=;
        b=dWKJnnxjkEPjxpLRTMEF/3B3Hd/pus8H4Y5bTZvaH6Bb40Ah5yGlz73NTf35HBs+ed
         62GBN/8Cbdv2oJeAYOXr9JzTICzRFzaFru26BHxKGcKRcd0Trd1U7tO9DDMQ9SpbTsCc
         9wdEgZUsNUvsrQZmxgtRO/zVcM9m36/zZBhrVcrLGU53Rn3+j8K9aVilA0QjWuQpIuHF
         R8m8n6D6SQos2RfyhXQDy6S7RJdT2Semrdpj6k/WkAt1NwgNJ+2xY9M4k1/Q79GVhFRj
         ztpnGjt0nmzwlRTL4jjVd8yt4/uwAv28dAnUn8d6VEOAljDLVQZ5+/1Fc1IR32IysXtZ
         ivdg==
X-Forwarded-Encrypted: i=1; AJvYcCXT/d4XLQzupqzq/11h4J91cK80bBWrMA8S6+hDfel97tFrk5QrFiS5SCNNwdVTMuP2sXBmJrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRAJI0p6YhqbokVJmYZldP+DtOaLFDKjjg3E0SIA8n+dXI2CPb
	0sWDjQMedEFDg+ZW+ggqGHrcpr8IzLBLRYu5DMUnEA46pns1MlkI1njKz7Ikzfig13bxZSiZwj1
	0kbaq5JCtuS8SNUU2b0QB2lY2Lr+aK8Y=
X-Gm-Gg: ATEYQzy1ceSYJGIOGEfXwXNZL+x6MIOxVmjpZ/64qgZFaDbeg22uxYSl0AgUy1hD04A
	lVjK9I5xZ13ibjJ1WzyYgTkr/RmhXvONB7w0K9C9L0Y3zozvLJFia2e4FZ+94mu8uWKkp+sukpH
	GgzjDW6thw+AgROtjkW199wOfmG/zsPka/WoVl0pV4XVQreipberSn3IksYk5ATY/7kmqvKzU4J
	Ths+7bhdguvYN7y+dwuAnCwPxURmSQSC68TLwnD+lRZ15v7O9sLNYr37NeD86r1DgBXqmBavRLZ
	3BNNJA==
X-Received: by 2002:a05:6820:4489:b0:67b:d8ff:1ac7 with SMTP id
 006d021491bc7-67dff3d6175mr1808520eaf.1.1774502498330; Wed, 25 Mar 2026
 22:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322040704.991766-4-weibunny.kernel@gmail.com> <20260323182405.177135-1-horms@kernel.org>
In-Reply-To: <20260323182405.177135-1-horms@kernel.org>
From: Wei Wang <weibunny.kernel@gmail.com>
Date: Wed, 25 Mar 2026 22:21:27 -0700
X-Gm-Features: AQROBzC-vXnSW3ni3PVuZ1P8Y0z5HDuc6b9utEuLiB0TgaYlAaZ_Yu4tQLTc3xY
Message-ID: <CAGqc4nXDBw4DG1zdxDSktm9eih6A-ndcSff9kGbdb4WHcqw56Q@mail.gmail.com>
Subject: Re: [PATCH v7 net-next 3/5] psp: add a new netdev event for dev unregister
To: Simon Horman <horms@kernel.org>
Cc: edumazet@google.com, willemdebruijn.kernel@gmail.com, 
	netdev@vger.kernel.org, weibunny@fb.com, daniel.zahka@gmail.com, 
	bobbyeshleman@meta.com, kuba@kernel.org, davem@davemloft.net, dw@davidwei.uk, 
	andrew+netdev@lunn.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271844-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,gmail.com,vger.kernel.org,fb.com,meta.com,kernel.org,davemloft.net,davidwei.uk,lunn.ch];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,linux.dev:url]
X-Rspamd-Queue-Id: 6F5CB32F56F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 11:24=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> psp: add a new netdev event for dev unregister
>
> This commit adds a netdev notifier to handle device unregistration events
> and clean up PSP device associations when the associated network device i=
s
> removed.
>
> > diff --git a/net/psp/psp.h b/net/psp/psp.h
> > index 0f9c4e4e52cb..fd7457dedd30 100644
> > --- a/net/psp/psp.h
> > +++ b/net/psp/psp.h
> > @@ -15,6 +15,7 @@ extern struct mutex psp_devs_lock;
> >
> >  void psp_dev_free(struct psp_dev *psd);
> >  int psp_dev_check_access(struct psp_dev *psd, struct net *net, bool ad=
min);
> > +void psp_attach_netdev_notifier(void);
> >
> >  void psp_nl_notify_dev(struct psp_dev *psd, u32 cmd);
> >
> > diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
> > index 178b848989f1..db4593e76fa7 100644
> > --- a/net/psp/psp_main.c
> > +++ b/net/psp/psp_main.c
>
> [ ... ]
>
> > +/**
> > + * psp_attach_netdev_notifier() - register netdev notifier on first us=
e
> > + *
> > + * Register the netdevice notifier when the first device association
> > + * is created. In many installations no associations will be created a=
nd
> > + * the notifier won't be needed.
> > + *
> > + * Must be called without psd->lock held, due to lock ordering:
> > + * rtnl_lock -> psd->lock (the notifier callback runs under rtnl_lock
> > + * and takes psd->lock).
> > + */
> > +void psp_attach_netdev_notifier(void)
> > +{
> > +     if (READ_ONCE(psp_notifier_registered))
> > +             return;
> > +
> > +     mutex_lock(&psp_devs_lock);
> > +     if (!psp_notifier_registered) {
> > +             register_netdevice_notifier(&psp_netdev_notifier);
> > +             WRITE_ONCE(psp_notifier_registered, true);
>                                                              ^^^^
>
> What happens if register_netdevice_notifier() fails? The function ignores
> the return value and sets psp_notifier_registered to true anyway.
>
> register_netdevice_notifier() can fail with errors like -ENOMEM or errors
> from replaying existing device registrations. If registration fails,
> psp_notifier_registered will be permanently set to true, preventing any
> future registration attempts.
>
> This means the notifier will never be registered, so NETDEV_UNREGISTER
> events will be silently missed and PSP device associations will never be
> cleaned up on device removal.

Adding the failing check in the next version.

>
> > +     }
> > +     mutex_unlock(&psp_devs_lock);
> > +}
> > +
> >  static int __init psp_init(void)
> >  {
> >       mutex_init(&psp_devs_lock);
>
> [ ... ]
>
> > diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
> > index aa60a8277829..44e00add4211 100644
> > --- a/net/psp/psp_nl.c
> > +++ b/net/psp/psp_nl.c
> > @@ -515,6 +515,13 @@ int psp_nl_dev_assoc_doit(struct sk_buff *skb, str=
uct genl_info *info)
> >
> >       psp_nl_notify_dev(psd, PSP_CMD_DEV_CHANGE_NTF);
> >
> > +     /* Register netdev notifier for assoc cleanup on success.
> > +      * Must drop psd->lock to ensure lock ordering: rtnl_lock -> psd-=
>lock
> > +      */
> > +     mutex_unlock(&psd->lock);
> > +     psp_attach_netdev_notifier();
> > +     mutex_lock(&psd->lock);
> > +
>
> Can dropping psd->lock here create a use-after-free window?
>
> The pre_doit callback psp_device_get_and_lock() obtains psd via xa_load()
> and holds psd->lock, but does NOT take a refcount on psd.
>
> When psd->lock is dropped here, psp_dev_unregister() can acquire both
> psp_devs_lock and psd->lock, complete teardown, and call psp_dev_put()
> which drops the refcount to 0:
>
> net/psp/psp_main.c:psp_dev_unregister() {
>     ...
>     mutex_lock(&psp_devs_lock);
>     ...
>     mutex_lock(&psd->lock);
>     ...
>     xa_erase(&psp_devs, psd->id);
>     ...
>     mutex_unlock(&psd->lock);
>     mutex_unlock(&psp_devs_lock);
>
>     psp_dev_put(psd);  // can trigger psp_dev_free()
> }
>
> This would trigger psp_dev_free() which calls mutex_destroy(&psd->lock)
> and kfree_rcu(psd, rcu).
>
> When this function then calls mutex_lock(&psd->lock), it operates on a
> destroyed mutex and logically freed memory. The post_doit callback
> psp_device_unlock() would then call mutex_unlock(&psd->lock) on the same
> destroyed mutex.
>
> Should a refcount be taken on psd before dropping the lock, or should the
> notifier registration be moved outside the doit handler?
>

Will move psp_attach_netdev_notifier() to pre_doit handler.

> >       return psp_nl_reply_send(rsp, info);
> >  }

