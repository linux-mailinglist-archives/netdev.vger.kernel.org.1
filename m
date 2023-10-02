Return-Path: <netdev+bounces-37452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECD27B56C7
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 17:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8ACF6281E14
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 15:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3974A1CF9D;
	Mon,  2 Oct 2023 15:39:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E701A715
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 15:39:15 +0000 (UTC)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CC2B8;
	Mon,  2 Oct 2023 08:39:13 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d81afd5273eso18231359276.3;
        Mon, 02 Oct 2023 08:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696261153; x=1696865953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRvyABZPczFSZcoyIQXVdYUk+Ea3zUQJXaiYFDP+fxg=;
        b=JZtsgrLlHQOuijahodzMGHn0edbn9Sl5yoFxnEJZKV/jEW3i9mNox1IbwLsVLYv7Sx
         rZo4q4tvSCSaU/yHryat45AAeCznftaUP2/2nrsB2U1H98AfUM/CGPavBg+bjKDG2eXM
         8w1T8Hi/JQrjjdVJ3s0mWXfIIqoXNBhKK6BANuKsiBF9pHQZczts73nhKiLpZ+cA8Trf
         uKkQusK/nDQGqpErwqWxSOwunywwjLpM7fCtimNj9QcwotpIlMc/G3+SDapchZzfODUO
         Wm7fMLDYBb1htIi4edu+EAFZ8W6Yhh3hIhzGmBQZhB3WTGKfffQvkppXcRIo/t0Nan9z
         4mKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696261153; x=1696865953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRvyABZPczFSZcoyIQXVdYUk+Ea3zUQJXaiYFDP+fxg=;
        b=kHjbyRQAHdrv7WuOaGbSyHd6mDD3StjH4Tso6gYudY77ni2RGQRmFKXQxMhv80XmU6
         1e5Gyo6LZyIk1DBXPgK6RQ2sYqpmQUjDGdcHgMYdzyICvdZzqKW5oL1u9wRkpnZubbgR
         KfJPkoYLs2xOyu7jvjpFbJxEDJeb7FcgrycygK4X0lvq8JR1CbUYKLeqRkPUNu2JtdSD
         vv0uIx46TQd8T0eGmsIurqymbaAQviSFdKvmHRsx38zMB10ARsoSnocA1Ndu0LG0729+
         aLs3VVLMXgkphQqYwK3nKASHXz+bidJp6+oxIMY1hqdNhB4WREEvt/R6/8xcpHjowBAB
         0AWQ==
X-Gm-Message-State: AOJu0YxErg3in8ZEq6U4A998QxFyg3wx9AnFeNllAEa+X+/VHP4vrWlt
	cJjjX+BtqaY0RbgRqzKkf77bUlqDtrUD+Nx4TF3u8UGwDJo=
X-Google-Smtp-Source: AGHT+IENydjMyeuzCrBdfZZdIWXIq+qgMNkij+CGVTp3pEgELoZL1wECHCLiTSbOsANLl93q/9hcAHROcfpHxEwxjOk=
X-Received: by 2002:a5b:143:0:b0:d81:87d9:6ad0 with SMTP id
 c3-20020a5b0143000000b00d8187d96ad0mr10004726ybp.28.1696261152737; Mon, 02
 Oct 2023 08:39:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6ee630f777cada3259b29e732e7ea9321a99197b.1696172868.git.lucien.xin@gmail.com>
 <CADvbK_fE2KGLtqBxFUVikrCxkRjG_eodeHjRuMGWU=og_qk9_A@mail.gmail.com> <20231002151808.GD30843@breakpoint.cc>
In-Reply-To: <20231002151808.GD30843@breakpoint.cc>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 2 Oct 2023 11:39:01 -0400
Message-ID: <CADvbK_edFWwc3JGyyexCw+vKbpKsbftRDZD34sjRXCCWtGYLYg@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: handle the connecting collision properly in nf_conntrack_proto_sctp
To: Florian Westphal <fw@strlen.de>
Cc: network dev <netdev@vger.kernel.org>, netfilter-devel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 2, 2023 at 11:18=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> Xin Long <lucien.xin@gmail.com> wrote:
> > a reproducer is attached.
> >
> > Thanks.
>
> Do you think its worth it to turn this into a selftest?
I think so, it's a typical SCTP collision scenario, if it's okay to you
I'd like to add this to:

tools/testing/selftests/netfilter/conntrack_sctp_collision.sh

should I repost this netfilter patch together with this selftest or I
can post this selftest later?

Thanks.

