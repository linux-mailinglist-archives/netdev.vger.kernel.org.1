Return-Path: <netdev+bounces-14053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 117F073EB3E
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 21:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3E171C209A3
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 19:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8E313AE8;
	Mon, 26 Jun 2023 19:46:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E64C13ADE
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 19:46:37 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7D61709;
	Mon, 26 Jun 2023 12:46:35 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-98d25cbbb43so565552366b.1;
        Mon, 26 Jun 2023 12:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687808793; x=1690400793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYOPBCfst1hOLcTekNGiwIU4PTN/NBPYoCMl0rwNDSg=;
        b=IgPLBG1ZHvJCpcegSofCz3EVlsXsR7zLTPgluudeLyDCNDPsszmL4T78i1iY113tjX
         0SJNfOGbH2djvphb6XH8s0+AHqstNP+ApKDlOz+nnymr+pz8RGQ2/MGb6s0GIsXtq8J+
         kCb16h1sFhBoDyQs23iDvbb3bibhlxtupnUTiYoxjLn4Xqe66d06/ImIAlMDqAhIgUys
         M3vL/V/J9OzxAUDTnhE0xm4FuheAzgVJOnYEGhrkyt5vmiboIedL22ipVgf2z0EmGjg8
         9nBKikt9jMWbwlnm6cZaFH672dP/hForU2+SZj0WHmx89Zp6Y/9RVHd3OmbCS6Ylolbe
         ekjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687808793; x=1690400793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYOPBCfst1hOLcTekNGiwIU4PTN/NBPYoCMl0rwNDSg=;
        b=TG/9MBDloG9ZM2FkLFfPt75zn029r0RKTiuQa9h2oBBRISEwvQp7xvyHXnktiRm8gV
         3tvzklx/a0yKVvkr5JV/0WJnMY7ie4zowfvDkoxb8Ceyt25dOpU8JRL1oCDauyRLxQiP
         +Dn48ryzj3rtKed0lRSe1yFSUgICW+zjC9CM4LHrnFm1z0Mzxm4P2CqAHCJs2xXoe/dX
         bf6gUaRWGbe+iov3eiE32rRzR6ACPbq3SYq1pGhZhikEHNVPUY2vwPP0kHWshABJmM7L
         44+vZFo5hR1yOeRrj9y+/B8Wf9Q0uFM8c2ZArnk12Va0MlS4WwC/0nMOPxjtrZVX+bE/
         0eZA==
X-Gm-Message-State: AC+VfDwd6oafHCT1wAKo0qhU/t88RaagjtmkDrQRTMqxAUu5+lGO+oyV
	Q8Dm8aripI6GWOicZbgRer4d2XR6W9R2RkTfhBM=
X-Google-Smtp-Source: ACHHUZ5Q2vebHsuhvUC+xkjwu8BQxSwJ4QTfzHobL6xUT43t2QPqmYrK6IME2u1khRM/1XRzruh2kjdOmGU79v4VbdY=
X-Received: by 2002:a17:907:9449:b0:988:b58d:5e0 with SMTP id
 dl9-20020a170907944900b00988b58d05e0mr19037318ejc.16.1687808793231; Mon, 26
 Jun 2023 12:46:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3101881.1687801973@warthog.procyon.org.uk> <CAOi1vP9-5eE6fjJ8rjvMCqGx7y94FHBDi2iNdZQfjPL=pugNWg@mail.gmail.com>
 <3105002.1687807098@warthog.procyon.org.uk>
In-Reply-To: <3105002.1687807098@warthog.procyon.org.uk>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 26 Jun 2023 21:46:21 +0200
Message-ID: <CAOi1vP-q8Yx6fntSnM+Zf77nQBryvm1+++cyg-NQvvVOa5eEDg@mail.gmail.com>
Subject: Re: [PATCH net-next] libceph: Partially revert changes to support MSG_SPLICE_PAGES
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 9:18=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Ilya Dryomov <idryomov@gmail.com> wrote:
>
> > This patch appears to be mangled.
>
> Mangled?  Did you see tab -> space conversion?  I see that in your reply,=
 but
> in the copy I got it's fine.

It turns out that it applies fine with "git am" but "git apply --check"
complains as follows:

error: patch fragment without header at line 203: @@ -450,10 +482,6 @@
static int write_partial_message_data(struct ceph_con=3D

I think it's due to the quoted-printable encoding.  I didn't have any
issues with your previous patches using the same automation so I just
assumed the patch to be mangled in the usual way.

Sorry for the noise, now that I can see the cumulative diff, I will
review shortly.

Thanks,

                Ilya

