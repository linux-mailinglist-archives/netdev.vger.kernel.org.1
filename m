Return-Path: <netdev+bounces-35580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDA27A9CD4
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F2C2832DD
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195D716416;
	Thu, 21 Sep 2023 19:23:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245601173D
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 19:23:12 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802E2FF97B
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 12:15:13 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-41761e9181eso70341cf.1
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 12:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695323712; x=1695928512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYHYZl5JCecQKv+vnuzpegBMsC0MwRfityrQ25PgO1M=;
        b=ICpaWEjrwcfOIv70jS9PdQ3poWq3lloA5QEKzPcW0Xgmb9BT34mSXhLcm8zZiAz1j5
         pykF/MVONxrDJRhxn/QHsWBqaDE+5z5ypsj7zNHOzw6gd+bnOcIcT7cKwqDGpUosZ99c
         eGWUBJfQhT3DeJNrp+fnXE6DLAuYFuQiGC+B/0rb6J+XhGhmtJkcf4C+WiiO+pTxL/R6
         nawST5gSBtYvcBR6GXg4t16H3m7VEcm1+/8m1zVHqUsnG0KlUDsWIYpOHV8edG1mxGBD
         FpfZ1Wrjr3tyYTyoQjo3pLcGcDCOI2ZyHgtCzLG0et2VonDLADiYxp7xb/umNDHXXPgR
         /CYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695323712; x=1695928512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYHYZl5JCecQKv+vnuzpegBMsC0MwRfityrQ25PgO1M=;
        b=NziGEmsyKpVl0KhI9TIOD0HhR643ou8LB3vAiS60YwI1FAWFnHqkDDYdFINa64zIhp
         MrB9CD2c9JcMtvW2bqwVKblebpwliVmzgz9yVwy2B8mTA5W8f3qAARiX0sZvKF/ancLu
         4b5v/DYW0Dit29DrgN1XHqVpFKRspkSlz+5d5Yp3Rh5sJkxv2J025sobHDb6b2LXZyF3
         S+sy1LGUQl8wn1lbRT+As5laflTitKM4qtCF7aCcPpjNgc3B5eIlyTifzmxCigil9G7C
         yinxbgUwX2Tm6u9slAuDHmxH9Le1Bc/2JGEDbSlvRXJ5gJkjaK1h4wiaXHQPIwLbqVF6
         f3hg==
X-Gm-Message-State: AOJu0Yx069yqgpWbo+4VAC80AbldOA29tkewtPb73dncZBzF5QJB59WL
	h9+WTgHximqUs6eJRpN53Zu/IreG8NJom3EXueFSeA==
X-Google-Smtp-Source: AGHT+IHtXYLn5TxXDzUtOJ3wrsIdtNaNp+jqe3EK8rusJ2uurHBcJCBDP+CSkDyzYEy83wxhmB3Vk6oW7iHpCdLN+m4=
X-Received: by 2002:a05:622a:11c3:b0:3de:1aaa:42f5 with SMTP id
 n3-20020a05622a11c300b003de1aaa42f5mr340382qtk.15.1695323712406; Thu, 21 Sep
 2023 12:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230921133021.1995349-1-edumazet@google.com> <20230921133021.1995349-4-edumazet@google.com>
 <3473bea6-00c8-2949-5029-122b599be9b2@kernel.org>
In-Reply-To: <3473bea6-00c8-2949-5029-122b599be9b2@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Sep 2023 21:15:01 +0200
Message-ID: <CANn89iJmqwihU3qqxYZ1Y7qZ9X0OabEc91r4T8gi6+1OA8voaw@mail.gmail.com>
Subject: Re: [PATCH net-next 3/8] inet: implement lockless IP_TOS
To: David Ahern <dsahern@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 21, 2023 at 9:10=E2=80=AFPM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 9/21/23 7:30 AM, Eric Dumazet wrote:
> > Some reads of inet->tos are racy.
> >
> > Add needed READ_ONCE() annotations and convert IP_TOS option lockless.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  include/net/ip.h                              |  1 -
> >  net/dccp/ipv4.c                               |  2 +-
> >  net/ipv4/inet_diag.c                          |  2 +-
> >  net/ipv4/ip_output.c                          |  4 +--
> >  net/ipv4/ip_sockglue.c                        | 29 ++++++++-----------
> >  net/ipv4/tcp_ipv4.c                           |  9 +++---
> >  net/mptcp/sockopt.c                           |  8 ++---
> >  net/sctp/protocol.c                           |  4 +--
> >  .../selftests/net/mptcp/mptcp_connect.sh      |  2 +-
> >  9 files changed, 28 insertions(+), 33 deletions(-)
> >
>
> include/net/route.h dereferences sk tos as well.

Right, thanks for catching this.

> net/ipv4/icmp.c has a setting of it

This is safe, the socket is private to the current thread ( sk =3D
icmp_xmit_lock()) and not visible to other threads.

