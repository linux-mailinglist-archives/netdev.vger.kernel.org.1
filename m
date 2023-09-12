Return-Path: <netdev+bounces-33370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D2779D9A5
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 21:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD15B2816E7
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 19:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D21A95F;
	Tue, 12 Sep 2023 19:36:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FF633E9
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 19:36:38 +0000 (UTC)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CCA1AE
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 12:36:37 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-44e84fbaab9so2504492137.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 12:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694547397; x=1695152197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+z5esQZbmnTYlwfmn98ZeiBi3A2WQdtXyQy2fqBUYI=;
        b=IKpK107Vdps/0+gh+SkOd6zwWMtZpGd+cLbX5gXhXgCnbOUuF2dLPRnxfIjd6L3JvH
         NYHINs7NACGiuWo9BZs4Stfmo1q4jOETpDfG5rHVNWBV6SrB5N4LF/7gUslMToELQFiF
         IKrBwLxpTaqB6wUiGsdZjNvjSr0TYiWVc7+xQsbw+bC8VTBomp4O2XdJ9rzsVyDl7XuZ
         Hjl8AXvhn1R1NDq/LVk1lSJA+z3i5IekkI8UM4hgJxZLTeFiD9+tAHxt3wpwTJPQDqE/
         9nHHxp7zUTkVkE418/PQaSpo7B9ou3WB4clUstR2/p2FyEmWfMfwF6MgHak/54bmta9T
         t8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694547397; x=1695152197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+z5esQZbmnTYlwfmn98ZeiBi3A2WQdtXyQy2fqBUYI=;
        b=KlU82THz2bKhrlvTKBT1QDij6L02bCQe4HChMyt56rtW7rkNnZ5tLNAAGHxaO11kyw
         uqjl8dptBi/Ul8zUDfZtha+Df2ZvuLn+rskZw9ay79yy6pwetrYEJpjkZ61tO14fdr6U
         9sYhe1hiM9uqW85T7Bpy7qonwTYolQ+n1vYvElBxSWGh01H+EIgjkoPScB34mwhLPvYg
         RZMfkwxJRIs6T6GVnl3Vc72Q2ZAjpZH0k/99Cr8S4XUjN6sx70JGwCD05BJ+CBtyy3+V
         3Jrb3Tp9Acbg2RpRProWqU5wOj/1eeFXOFxSEnOvw39+FCcwEZ4JOmW/g/jIwSpno4VR
         THug==
X-Gm-Message-State: AOJu0YzqxaJcignbRd2Z6IjS3jSfN1yoC95uvLnbB27nbhaqXJ9/x6jR
	o295iXZphVf68YlyOqvftzzVYRKoqj880FmyXY0=
X-Google-Smtp-Source: AGHT+IFCFZKp+VlxdCIeLE63ieyWfuu4jrzSTSWoJS2onZVPRv/9CTIMviXdp1hOxoKm1xoC6UJMF8tTygcgDyV0TeE=
X-Received: by 2002:a67:eb95:0:b0:44d:3c1b:2dc0 with SMTP id
 e21-20020a67eb95000000b0044d3c1b2dc0mr248371vso.26.1694547396449; Tue, 12 Sep
 2023 12:36:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912013332.2048422-1-jrife@google.com> <65006891779ed_25e754294b8@willemb.c.googlers.com.notmuch>
 <1ca3ca8a-6185-bc55-de74-53991ffc6f91@iogearbox.net> <CADKFtnTOD2+7B5tH8YMHEnxubiG+Cs+t8EhTft+q51YwxjW9xw@mail.gmail.com>
In-Reply-To: <CADKFtnTOD2+7B5tH8YMHEnxubiG+Cs+t8EhTft+q51YwxjW9xw@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 12 Sep 2023 15:35:58 -0400
Message-ID: <CAF=yD-KKGYhKjxio9om1rz7pPe1uiRgODuXWvoLqrGrRbtWNkA@mail.gmail.com>
Subject: Re: [PATCH net] net: prevent address overwrite in connect() and sendmsg()
To: Jordan Rife <jrife@google.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, dborkman@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 2:31=E2=80=AFPM Jordan Rife <jrife@google.com> wrot=
e:
>
> > These should probably call kernel_connect instead.
> > Similarly, this could call kernel_sendmsg, and the extra copy handled i=
n that wrapper.
>
> I was considering this approach initially, but one concern I had was
> that there are other instances I see of modules calling ops->connect()
> directly (bypassing kernel_connect()):
>
> - net/netfilter/ipvs/ip_vs_sync.c: make_send_sock()
> - drivers/block/drbd/drbd_receiver.c: drbd_try_connect()
> - drivers/infiniband/hw/erdma/erdma_cm.c: kernel_bindconnect()
> - drivers/infiniband/sw/siw/siw_cm.c: kernel_bindconnect()
> - fs/ocfs2/cluster/tcp.c: o2net_start_connect()
> - net/rds/tcp_connect.c: rds_tcp_conn_path_connect()
>
> and ops->sendmsg():
>
> - net/smc/af_smc.c: smc_sendmsg()
> - drivers/vhost/net.c: vhost_tx_batch(), handle_tx_copy(), handle_tx_zero=
copy()
> - drivers/target/iscsi/iscsi_target_util.c: iscsit_fe_sendpage_sg()
>
> which (at least in theory) leaves them open to the same problem I'm
> seeing with NFS/SMB right now. I worry that even if all these
> instances were swapped out with kernel_sendmsg() and kernel_connect(),
> it would turn into a game of whac-a-mole in the future as new changes
> or new modules may reintroduce direct calls to sock->ops->connect() or
> sock->ops->sendmsg().

Ideally these all would use the proper kernel-internal APIs.

I care less about new code. If all examples are clear, that
will do the right thing, or is a simple fix-up worst case.

Question is if changing all these callers is suitable for a patch
targeting net.

The changes do seem like trivial one liners?

> -Jordan
>
>
>
> On Tue, Sep 12, 2023 at 7:22=E2=80=AFAM Daniel Borkmann <daniel@iogearbox=
.net> wrote:
> >
> > On 9/12/23 3:33 PM, Willem de Bruijn wrote:
> > > Jordan Rife wrote:
> > >> commit 0bdf399342c5 ("net: Avoid address overwrite in kernel_connect=
")
> > >> ensured that kernel_connect() will not overwrite the address paramet=
er
> > >> in cases where BPF connect hooks perform an address rewrite. However=
,
> > >> there remain other cases where BPF hooks can overwrite an address he=
ld
> > >> by a kernel client.
> > >>
> > >> =3D=3DScenarios Tested=3D=3D
> > >>
> > >> * Code in the SMB and Ceph modules calls sock->ops->connect() direct=
ly,
> > >>    allowing the address overwrite to occur. In the case of SMB, this=
 can
> > >>    lead to broken mounts.
> > >
> > > These should probably call kernel_connect instead.
> > >
> > >> * NFS v3 mounts with proto=3Dudp call sock_sendmsg() for each RPC ca=
ll,
> > >>    passing a pointer to the mount address in msg->msg_name which is
> > >>    later overwritten by a BPF sendmsg hook. This can lead to broken =
NFS
> > >>    mounts.
> > >
> > > Similarly, this could call kernel_sendmsg, and the extra copy handled
> > > in that wrapper. The arguments are not exacty the same, so not 100%
> > > this is feasible.
> > >
> > > But it's preferable if in-kernel callers use the kernel_.. API rather
> > > than bypass it. Exactly for issues like the one you report.
> >
> > Fully agree, if it's feasible it would be better to convert them over t=
o
> > in-kernel API.
> >
> > >> In order to more comprehensively fix this class of problems, this pa=
tch
> > >> pushes the address copy deeper into the stack and introduces an addr=
ess
> > >> copy to both udp_sendmsg() and udpv6_sendmsg() to insulate all calle=
rs
> > >> from address rewrites.
> > >>
> > >> Signed-off-by: Jordan Rife <jrife@google.com>

