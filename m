Return-Path: <netdev+bounces-260494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Iw7BsKSnWlKQgQAu9opvQ
	(envelope-from <netdev+bounces-260494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:00:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 766DA186B09
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E33F3096B26
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB5C3806D3;
	Tue, 24 Feb 2026 11:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GMVN6icq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B423806C9
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 11:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771934319; cv=pass; b=bS/zP542ZSKYyWdW1DiPojvt0pJ+NxIr9n3g394eYlZNn7jL03SjusxrcfriHsPUFJjVqCmxJG1xjlucRrYIJIReUz9wznbWcUV8f/1aGjLj8Tfohgxd4e5scTCtqdIV6mHtkCIzd3gfjAvl0EriRistJflFcsr9XOkZMZUT8rY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771934319; c=relaxed/simple;
	bh=6POzo9hMot4hGxn+dv8cIhBpoaXPn/KwHvNU3FExQcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xe77PWnn/71fVLVytAVxvTKF4EFePx4ZaXZtcKQcHrNd1t3bi7aXZUpJY9/bGw5juACj+qXu7CWD6GSrMM41ZihoChPwrGuV9dzdG968dhvHqTpehnAzf4JGd+RM/hHXNCvXuZtrKusuGerEzQOrwm95ODWHJU+V+lDbVwtljFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GMVN6icq; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-506a297c14bso46406731cf.2
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 03:58:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771934317; cv=none;
        d=google.com; s=arc-20240605;
        b=Z5BjkiivmEUbLrcHkMFsxxAHee73GzkYkg9DzbQM4x+tj2jsobH1agLQpTZ9kbiqiO
         63i0f5aJmMHVdxCTx3cHYaES8gMB9lgHXWJtkiLVG2p8hcTvA8ErNqzS9cdAqyHb6ZqE
         YSUyVXglqO/XteLVR8ZaxFfshL/AlhT67Bw29yVsvsRtBOMia9oWY8kprksPm9g8UsKV
         1djLQutBiVd4u9dsQzaUXg3Fe1ugeN90b3eGg8zcb6CF2NmOg3SdTru4I4ifmy8KjnFw
         tsxr+kAcIeFu8Jou/LB87+eYGCvOsBjwO51RIMLBOJA/E5C3quFq1c5dTct5QzIxwPSM
         Vc4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y0BCMqyTaLGLUvoBxhT6hoRmuZfB2WJ5yYRCvYMqiWQ=;
        fh=3qTK1A0tfD1bDqFJy7bMbt/EnduPqKzgRP9wPyrix5g=;
        b=C3Xx3jj1zAxY5Ms855/1JcXNfNuwes9Og/DK2QnNdtqe8ytI7nsA1DV/YuKY8p05ij
         DDj1XbHicF77aOEle+yrqbLssA9NhkRMpfqTgJ9BYtjWJ1zFJOYJy0fc66PsPDelVb3A
         BP0vHbxpZyL1UdnN8t3l9xeyh4z7AwSwXVdkt7MwV8gOY5wq7rjn0A43m4g+OuBf/8eq
         aBpn49oMxA0LwS7ddOgMYEDTd3ooTLLR614VMOFYNynsCcU338K/ycuoYLUCfsHcxjL2
         8mGmfTabSGTIdc/SzhDkdhDACPjRU7CZ79ZrJvizTgDOZrI3Cj2rgJTPLtM9AqfWkNLc
         I2xA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771934317; x=1772539117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0BCMqyTaLGLUvoBxhT6hoRmuZfB2WJ5yYRCvYMqiWQ=;
        b=GMVN6icqfBf5988BHuTm6xLE0QNfxhJKt9GCxTOGGhAH4Wu2r9lBExjKA2NC81ipJC
         L+GKGTAP3zlx5NTDo5v+O5xWIAUz/lG22y68izB0o72Y0FMnAbvnPCkpHNmPg767EpXF
         vKp6NXgf7nY06vQTodUqso+RmFxya2zaDHZqkONfQ5EsgOxJBGysk5wsFFtv54GtS0Nq
         MnYfs8ko81fAuKD6WROSPDmOI/rGjnsT3BeX89gqSFlfaIlH1Xx5eKFXgYi6YJy5e0Ky
         FGC6NWEQ6TsHdYVqQ8/S9u2URTYmpRXqxLkvkogNM82Lb5A+1QR4rNMFxPVeuF5NTN7t
         CV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771934317; x=1772539117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y0BCMqyTaLGLUvoBxhT6hoRmuZfB2WJ5yYRCvYMqiWQ=;
        b=iW0ejXrFZnQM7ocyBQqIwVjMpifb27wHeZDL2Yibc3Um+dU0JA0GA/cp8Sucwa6Li8
         uVBGsRmQlpZCLdSNqUfrpZP/CSVyI2n0H1EwmRmMlvSCtQ6jc0VvR0GwRSRE/M1zt8Km
         Oj0SyNcim95ABkQNfGpyIHw35eckfLAeplt1MacsFLeuc14cMamQgH/rQ+ICE0KwVlSm
         9+zdYOJIySrsTCCJq7n657XbAbKoSC6KFf3nSXCk6Bk7fE4546BYbXyFaMVonCRQCJ7l
         xCzbk9mBdpvxFVeK33WYoGKmfAo9z40vPvMVDfCOoBXEeaZbeMvQaxFQeDH5l4YpjWzl
         97HA==
X-Forwarded-Encrypted: i=1; AJvYcCXNwsHfvU5T1S14cIWRqoNAvlef2U1UfN2rzmPvuf9dvcgVitwstlNtgrVZGHnzk2pLLCHicWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Fj3j+B0Rgl57un06s5g6AsI6eYhENU59CpddVl1axwCYf/f3
	4Ikxx5IjdpNJlnMdAGP6OS9ssKGgXsYfJ2iZnRr+UYqvu9jdymlxDc+3fLXVQN1n6j9OZX/d7FQ
	pORovJ9VtjYq+gO6He7XbP1PacTk8yBQ/Sw8tcr2Q
X-Gm-Gg: AZuq6aLEcemk6Xnn/lbZqUlKA83JRaiydOPGRYIW+m6BMpfwcghO+bVFjdbx2ByC5U8
	NdnLsc19P1QzlSMvW9fPZ4iuULNQLTTSR9kQyiOmHdCOSVlbZqw9GiWokbbYlSDwr4WkQFDkWUy
	AZH5qm0db9jhtmY345sSU/qZdHREnuRT8mbHJhIjbFtA+dVxTu9Pa7N57aYmOHnZTjySSjgdPKy
	snbvOG1VUzcuEgfsUJWho2mqHh7LidRyVuyAqPPyBq3hWcjz9QQP5iftXRRuhjpm8SKWoxgdBiq
	eUkDdVEio9tEEhWY59HsIa8l8NbNNizgm8Yxnc9UBC/VBdZgXr/C
X-Received: by 2002:a05:622a:593:b0:507:3d3:6cd4 with SMTP id
 d75a77b69052e-5070bba6bd9mr163273461cf.9.1771934316335; Tue, 24 Feb 2026
 03:58:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112103825.3810713-1-edumazet@google.com> <20260224114113.344-1-hdanton@sina.com>
In-Reply-To: <20260224114113.344-1-hdanton@sina.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 24 Feb 2026 12:58:25 +0100
X-Gm-Features: AaiRm50XJQX9sOulNvBvOPY2ZW4QjTARc20DB926L3aLpO9UvZRRdWy_mmWWMgU
Message-ID: <CANn89i+HrHVrV6S1fmGn62-8odQOuzyC1pnzOo+SBfN6xRZE=g@mail.gmail.com>
Subject: Re: [PATCH net] dst: fix races in rt6_uncached_list_del() and rt_del_uncached_list()
To: Hillf Danton <hdanton@sina.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
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
	TAGGED_FROM(0.00)[bounces-260494-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[sina.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,179fc225724092b8b2b2];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sina.com:email]
X-Rspamd-Queue-Id: 766DA186B09
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 12:41=E2=80=AFPM Hillf Danton <hdanton@sina.com> wr=
ote:
>
> On Mon, 12 Jan 2026 10:38:25 +0000 Eric Dumazet wrote:
> > syzbot was able to crash the kernel in rt6_uncached_list_flush_dev()
> > in an interesting way [1]
> >
> > Crash happens in list_del_init()/INIT_LIST_HEAD() while writing
> > list->prev, while the prior write on list->next went well.
> >
> > static inline void INIT_LIST_HEAD(struct list_head *list)
> > {
> >       WRITE_ONCE(list->next, list); // This went well
> >       WRITE_ONCE(list->prev, list); // Crash, @list has been freed.
> > }
> >
> > Issue here is that rt6_uncached_list_del() did not attempt to lock
> > ul->lock, as list_empty(&rt->dst.rt_uncached) returned
> > true because the WRITE_ONCE(list->next, list) happened on the other CPU=
.
> >
> > We might use list_del_init_careful() and list_empty_careful(),
> > or make sure rt6_uncached_list_del() always grabs the spinlock
> > whenever rt->dst.rt_uncached_list has been set.
> >
> > A similar fix is neeed for IPv4.
> >
> FYI list corruption in dst_destroy() [1] happened after this fix.
>
>
> [1] Subject: Re: [syzbot] [kernel?] INFO: task hung in restrict_one_threa=
d_callback
> https://lore.kernel.org/lkml/699d155f.050a0220.247d23.0377.GAE@google.com=
/

Seems unrelated.

Are you seeing anything wrong with my patch ?

