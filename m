Return-Path: <netdev+bounces-260788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMDOBgWwnmlxWwQAu9opvQ
	(envelope-from <netdev+bounces-260788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:17:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 716F71940EC
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C6DE3074F17
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 08:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F79131195A;
	Wed, 25 Feb 2026 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dh3I7Jtz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0757D311587
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 08:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772007324; cv=pass; b=I288T0lKRA0xCJdn3WLy1ROqikt6pDqgQ/zI1wrQdROtZPExMkr4ima0+1HkT/U2YxLs+H4LvAVXX48auWu27JfQtLXMRhArizSqhLuPoawNeT2ZTPDLmzGWV4aQ43J/KTy8fy6IbLmZn2b7dlNAM81edGMdr6KB9B9Idf6yiqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772007324; c=relaxed/simple;
	bh=cY3zSVRHHJ9BQVNhL7zT5pcIaJD8nWf/AITldh4B1gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GwWmaXkToDWVm6STnz6XCHoiowt2xGJi7mwc4hVS/PWmAvXrVkTpTxqofbZzu7k1JPZVxeK8qUHIgDbRlzdk3KXiV7LGulaoMPGxwKMJhrJPm8WNOzx0M+7b+N4fbAQ4fjflrBoL6BVtSLAQz+EZolNVLtRhp+ubc4eJHjGyyAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dh3I7Jtz; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506a747448dso53697481cf.0
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 00:15:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772007322; cv=none;
        d=google.com; s=arc-20240605;
        b=lr/CEBw7nFcUhQw8cYGHGN4uzvVHlXFeeIVkh3UJcU2T8pToOZYr8yblcMDFQhXfWL
         +WJi3JmCW+XxPiIHIbgofyPLowRXSN0DLF8WYPuUNqSBZpguXR+pJifPptTPCgLS3DIR
         YiyqCOHFmTD7g65yiOhfUWQ+OOm0tK9MrIICEmVNJUBQxkxM01yMrJPU1GF4Wqr9zOJL
         W42RD7fTBTVVcfYV07JwBm+R7Afsdq8D1oMkXibGL3gXJB85aCDtYgNd84moYpPx+lFl
         f8BaF6qZylp92jjX/h9iweBDBL+LIhKxtCv0RUoVWDy5t1Cv5y9HCG9XNP3jmo9aEgea
         AfsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A+zd1Qef+gHdKi2og3MhumWj0kDR52RCsxG045c//es=;
        fh=M7DcgeGzaEFDIrs1Lo0dQcmfYbU+VQa4lv2TQMT/0yk=;
        b=Ziy7mhOWJitYH617I7WOaa2KYjwBcH+6uVPKeq/ng0v0+lngs2VDh6hS5BiaImlqWw
         GgYsjm0ZqRB+AOGiqvynXS068FjaN/9+0zICpEKpWhxOMEyL5O3ZMLmr84scx3QuGmXA
         4GA6qXJDdQhk4mlOXm2bBPusF5TX5kHLUrcaEO7/sbfBsx3Sahmd6uHlDEHTpaSWT0m5
         5zmZipIYzccbyYqYpiTxKEaB3u/fvtCLb8gXn8A4Gxt+J/g3mOvFBVCZLsbJRJN/ne2f
         gO9CZaHS4eeGdGRSCczv2aQaZsChc49gX0GKqBjHks7tFyxWQi9w2BokJWP9KRkg1ozI
         e8Pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772007322; x=1772612122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+zd1Qef+gHdKi2og3MhumWj0kDR52RCsxG045c//es=;
        b=Dh3I7JtzRxEk2h8Ncf36a8tOXvb6t2I7AiBUoK3Fo1Q2Qa4xZUGyLJesS94gbQxKie
         jv376NXt12c1fxUNW1ZCdDLXd0hzLEkUYDI9OmGy45/hJASXhfIfkbxFzM9mMTrZRZ3K
         f995En5BRbBr9jdKmyBc7wYyi4ymCdgHj6XOZefH6Fv3XOYnO+upo6UqdWGk/dUpslsO
         APIpt2G2YOEu6+UNKUBMxHqJZx7iXYR1iEW1LAhGSxEY00qLFIWILqSdUnU3zVQ0BK+S
         NdHcZl93rZuaDeoTt+dZLzqUhdG8lIq9dTowZRRi9xNT80HdVzVqQvFUrsdByIVEYVy4
         f0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772007322; x=1772612122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A+zd1Qef+gHdKi2og3MhumWj0kDR52RCsxG045c//es=;
        b=mgdycQhsM4OLNe6EiyPcXnDaY1dbJKA5G5w8J3dpqzOMmyJDWCKl5594QSRoNH8NJe
         mRjt+pvD5eMbx1kf829XNi6xZjqhZB8zZu3ijeKJnKSwgLQeo+PDIZN+vAGtJV6b6IYO
         4lDWPuf303czQesStoA0b1yeNAwh20CBLW9BbAgVgMffryT+7LaG9Bf7jPQpcsrSdmPJ
         8C6JPsCEC9NvYj93nTjz/Q2haDm080tJrP3bURZLyaww9VxDKHgqK7+2JkQHimILO9QU
         tK/vOjNuqe7yYwl9h9F0EZtqXgilGXbECbDu602W+99WvyoVxRCkGorARKbJefR0mhIT
         uINQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSeoewgV4x9NbsXDKzL/E6UGOd5/Akm1YI9imPzzPOyC/nNy9fwM8H/CoffdTpsXxZItQ9Ovc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVCmv0vl2Lgrui0dd9agMgy0eW+oUnKeIGJmIGCKo7r8EYkkt6
	aCFpcoy6Yx3xiq6LsolFGZ/DK1KsWruN0O320XuMq9cAZq+zVANRJuQ+KCgY9gJYRbDtvOADq+u
	3m4DaoN7BnyO5djOSxYWZzkFuamywbtNP64pX3x8A
X-Gm-Gg: ATEYQzz7OoYBSyeEcfcFNFNlgXYqSU+GiBz+LG3f1WGD4aqPepPzmuGPSNVLBqYOHUt
	8O/IcDksqdpUW7lN36ZoEIIDpQyKClv5pN4MqXJn1vZs9wH/3EYDqwllSK7M9cKacUdSclVmoX6
	b2xU53lkJqecziEsyEq1iGTiN9Kmlj69vSn3GMGQsq1AfF3yLeOxahUp62ooC30ZutaZOPi6V8E
	59GdHtg5XXA4FGfLPDbuN2Pqo/JfeESF72Q1MbsW7g0Mko9d4Gv8oYlEdplX7Vg8xy7UO0vUNfT
	J/0tsY5vYKPSuYxOqZiK1pnydSRGU/mLVTu+hWHxuA==
X-Received: by 2002:ac8:7d8a:0:b0:4ed:1948:a8a2 with SMTP id
 d75a77b69052e-5073a2d9ed4mr20789521cf.40.1772007321368; Wed, 25 Feb 2026
 00:15:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224114113.344-1-hdanton@sina.com> <CANn89i+HrHVrV6S1fmGn62-8odQOuzyC1pnzOo+SBfN6xRZE=g@mail.gmail.com>
 <aZ6l3vTgXLsqaJHc@cae.in-ulm.de>
In-Reply-To: <aZ6l3vTgXLsqaJHc@cae.in-ulm.de>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 25 Feb 2026 09:15:10 +0100
X-Gm-Features: AaiRm52JxmH2eKubLmStPMe75UFFsAJhn6-v7KKATe0Pxd1TrQ5s0GI6DXRTRoo
Message-ID: <CANn89iJAgR91+=6RzviiP8hK1iHxH0M4gY_MSaF-aOdmq143-Q@mail.gmail.com>
Subject: Re: [PATCH net] dst: fix races in rt6_uncached_list_del() and rt_del_uncached_list()
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzbot+179fc225724092b8b2b2@syzkaller.appspotmail.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260788-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[sina.com,vger.kernel.org,syzkaller.appspotmail.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.990];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,179fc225724092b8b2b2];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,c--e.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 716F71940EC
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 8:33=E2=80=AFAM Christian A. Ehrhardt <lk@c--e.de> =
wrote:
>
>
> Hi,
>
> On Tue, Feb 24, 2026 at 12:58:25PM +0100, Eric Dumazet wrote:
> > On Tue, Feb 24, 2026 at 12:41=E2=80=AFPM Hillf Danton <hdanton@sina.com=
> wrote:
> > >
> > > On Mon, 12 Jan 2026 10:38:25 +0000 Eric Dumazet wrote:
> > > > syzbot was able to crash the kernel in rt6_uncached_list_flush_dev(=
)
> > > > in an interesting way [1]
> > > >
> > > > Crash happens in list_del_init()/INIT_LIST_HEAD() while writing
> > > > list->prev, while the prior write on list->next went well.
> > > >
> > > > static inline void INIT_LIST_HEAD(struct list_head *list)
> > > > {
> > > >       WRITE_ONCE(list->next, list); // This went well
> > > >       WRITE_ONCE(list->prev, list); // Crash, @list has been freed.
> > > > }
> > > >
> > > > Issue here is that rt6_uncached_list_del() did not attempt to lock
> > > > ul->lock, as list_empty(&rt->dst.rt_uncached) returned
> > > > true because the WRITE_ONCE(list->next, list) happened on the other=
 CPU.
> > > >
> > > > We might use list_del_init_careful() and list_empty_careful(),
> > > > or make sure rt6_uncached_list_del() always grabs the spinlock
> > > > whenever rt->dst.rt_uncached_list has been set.
> > > >
> > > > A similar fix is neeed for IPv4.
> > > >
> > > FYI list corruption in dst_destroy() [1] happened after this fix.
> > >
> > >
> > > [1] Subject: Re: [syzbot] [kernel?] INFO: task hung in restrict_one_t=
hread_callback
> > > https://lore.kernel.org/lkml/699d155f.050a0220.247d23.0377.GAE@google=
.com/
> >
> > Seems unrelated.
> >
> > Are you seeing anything wrong with my patch ?
>
> I'm certainly not an expert on this code and I might well be wrong
> but it seems that with your patch your are racing against a list
> delete in rt6_uncached_list_flush_dev which removes the item from
> the list but does not reset dst.rt_uncached_list.

Both rt_del_uncached_list() and rt6_uncached_list_flush_dev() use
list_del_init()
with the spinlock held. No race is possible.

>
> So I think you want to keep the list_empty() check but do it
> under the lock?

A second list_del_init() is a NOP, so adding a list_empty() would only
add extra code
for a condition which is already handled.

>
> Best regards,
> Christian

Thanks.

