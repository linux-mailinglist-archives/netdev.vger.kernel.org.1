Return-Path: <netdev+bounces-37710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A75E7B6B37
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 16:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 587651C20860
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 14:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B307F30FB4;
	Tue,  3 Oct 2023 14:17:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C662940B
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 14:17:47 +0000 (UTC)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A509CAB;
	Tue,  3 Oct 2023 07:17:45 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d8168d08bebso1042170276.0;
        Tue, 03 Oct 2023 07:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696342665; x=1696947465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lqefmjYJWK3tGZa7hTGKrUkp1vISerRSIwtUB6OaaU=;
        b=Au4Odsnc8Nw/MYqfLkLRoTfdYhtPzG3oZe86goBhJbUTAtxy7XbQFz8Dk+rBsEvE1b
         E9AFIhg9DdFabtEe09+Q2ljyP6kLdkgTca5qjMJDU1XhCrycKw4DXp+QTP1VhFNYg7MR
         xEY0mMlvKMcIyy04v1VkrR7cYzT+7+EdqSOzeE565Ubg8F5oRUnoJGO/DAE6wgJS02XH
         b1Yrin2PiRFyWVWuj5eMoDRHcKeCvXB0hLTodmEk5ybfL2SlLYDZYjYQZIRXPmTNCPDX
         62HCnA1gmJv4WyYPYNfL5i7sRBUGzbZhvNf3Afaq/IHMFlyPVCEQM3n2dcdF/bk45ztw
         Khag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696342665; x=1696947465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lqefmjYJWK3tGZa7hTGKrUkp1vISerRSIwtUB6OaaU=;
        b=pBt2J4CmrNWZyjIBU82z3aglhaxst0FSH/xh2QzXwTjmY94ciho3LlmNJcwuIWUeS2
         RCe7lGqChzOcAu4lHklhYkx0RqFCp9bq2uULvdAtDNXa3CO3DJKDFUMEqXsM0fvNXJJe
         hAkKYIciPdZN3RSdVmfrZGWXJgLKKthv4e1fS4LC0YSnoNBizFOZ/hCkOLMhOJ6O1bHT
         m0TJ8YBFLQpN6oOS/7cdj2RU5A13V5pDXyv3ivuaUWO8+7j4L5zbBC+P3gweLBtIBnI2
         mZ7jDxDtmcoxHf1/NFW1zJyVTdv7p+bElpjbcDa3nmUDNsTQKxlfiA5HbciinCLRjzqT
         USrQ==
X-Gm-Message-State: AOJu0YxwrLbgWkPdFjPjbHEsjv+1dH9EXLQEzye4lm7eZ6q2T6TsZIDv
	KJ9KzGzlc+i9BqYJgX7eQ3UNEmgq13cuPhT0ebI=
X-Google-Smtp-Source: AGHT+IFSQH5Yz8SjE9LGYpd/qJZBqdtYmj/8cvdNUPqmSP90OX2ANnWog9fmCvrR0G/GxkgcTfT6AM/X4/UHiAcj9Dk=
X-Received: by 2002:a25:a2c6:0:b0:d78:132a:2254 with SMTP id
 c6-20020a25a2c6000000b00d78132a2254mr13214932ybn.37.1696342664703; Tue, 03
 Oct 2023 07:17:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6ee630f777cada3259b29e732e7ea9321a99197b.1696172868.git.lucien.xin@gmail.com>
 <ZRwOVyKQR8MBjpBh@kernel.org>
In-Reply-To: <ZRwOVyKQR8MBjpBh@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 3 Oct 2023 10:17:33 -0400
Message-ID: <CADvbK_fK03UO3R=70J+VoGVm_LJuzZbh+_=0doceS8DCPJYBVA@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: handle the connecting collision properly in nf_conntrack_proto_sctp
To: Simon Horman <horms@kernel.org>
Cc: network dev <netdev@vger.kernel.org>, netfilter-devel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 3, 2023 at 8:51=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Sun, Oct 01, 2023 at 11:07:48AM -0400, Xin Long wrote:
>
> ...
>
> > @@ -481,6 +486,24 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
> >                           old_state =3D=3D SCTP_CONNTRACK_CLOSED &&
> >                           nf_ct_is_confirmed(ct))
> >                               ignore =3D true;
> > +             } else if (sch->type =3D=3D SCTP_CID_INIT_ACK) {
> > +                     struct sctp_inithdr _ih, *ih;
> > +                     u32 vtag;
> > +
> > +                     ih =3D skb_header_pointer(skb, offset + sizeof(_s=
ch), sizeof(*ih), &_ih);
> > +                     if (ih =3D=3D NULL)
> > +                             goto out_unlock;
> > +
> > +                     vtag =3D ct->proto.sctp.vtag[!dir];
> > +                     if (!ct->proto.sctp.init[!dir] && vtag && vtag !=
=3D ih->init_tag)
> > +                             goto out_unlock;
> > +                     /* collision */
> > +                     if (ct->proto.sctp.init[dir] && ct->proto.sctp.in=
it[!dir] &&
> > +                         vtag !=3D ih->init_tag)
>
> The type of vtag is u32. But the type of ct->proto.sctp.vtag[!dir] and in=
it_tag
> is __be32. This doesn't seem right (and makes Sparse unhappy).
You're right, I will fix it and re-post with tag:

Fixes: 9fb9cbb1082d ("[NETFILTER]: Add nf_conntrack subsystem.")

Thanks.
>
> > +                             goto out_unlock;
> > +
> > +                     pr_debug("Setting vtag %x for dir %d\n", ih->init=
_tag, !dir);
> > +                     ct->proto.sctp.vtag[!dir] =3D ih->init_tag;
> >               }
> >
> >               ct->proto.sctp.state =3D new_state;
> > --
> > 2.39.1
> >
> >

