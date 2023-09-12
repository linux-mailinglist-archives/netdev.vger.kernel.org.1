Return-Path: <netdev+bounces-33372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AACC379D9E4
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 22:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DBAC281ABB
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 20:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B84AD4F;
	Tue, 12 Sep 2023 20:07:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9CC1FA8
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 20:07:50 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451C8E4B
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 13:07:50 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a9f139cd94so684768066b.2
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 13:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694549269; x=1695154069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKYOyOOitx6ajIpHKZnGo+roK6FEVJpuzX2cgWQ1KVY=;
        b=JWp6iBpRb2V0rcH2ENKWS9+jKFqjPLbE2hmnHYwGf7nxDlA/ZUqaO/pc6onYgyL6ne
         azheXiVT0F8Ivwaav3oCD81y1oFTBUB7E1Z5FyzyUfaYfvV1LMq77iGCozMp/eaQzf3B
         Qir3XcNLcuJ9jIqGna/FtHA4arRFe1JE3Utnv4KX+jZ14TtbIt6tf3CjoiG2YnwAOrvG
         KrWv4KwVTu070LfDA0g/geilnfN6HWvg8eKX/Rfl+KUO/jFYX6AUu2OCAGe82u8DJU2E
         0ZwNu3WW/UF9bcIv3fybz80ae69uNdI3AuXOTF3LMjzLRg0Ui3AZ1UyJefXHEL6gxRys
         HDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694549269; x=1695154069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKYOyOOitx6ajIpHKZnGo+roK6FEVJpuzX2cgWQ1KVY=;
        b=OmGhEt1igbvmcjAvymmCnmJFp7cUmdc5UkhP90DBWrXyKm8zWravNXOi1HV5Wil028
         U0QIRYWH1eC3ASBd4T3CDdPq1/8q1VTSGyJskFb5ROT8PDQ3eTe6LS4pKpXYiMwkI+du
         zlTZT95YaHyXfv9li5wP7PqlqjIHz26J5YLbheF3byAFDaWHe5HF7hp1TDQnse340mUQ
         oe9P3UU2pjxebpIh/WbhA1pUq0aExhAxqLlT3/kFyXspa0E5QGWjQDsZZWLtbFdwgUSb
         PNDFc4fbETaSsgxfQjO6xIigPBzJ0I9AtrrhovmFo18kPPsK4CaZquMVdisItyX86UP8
         JxOQ==
X-Gm-Message-State: AOJu0YzFfw6LYcJIuXv/S3CiLb+7g8Z+K30q1qRd/qsTppvJMM+cYEV+
	J2qbtnSwmfAxYbivkAT/FoohOaakF3XQxFhJc54bq/Y/uaz78Q2BpA+lDA==
X-Google-Smtp-Source: AGHT+IEW3Bk3tLrY6KoJuBKvZAVzyYa9J9XVEu95KkNEKplkk79bEFQORFtfUH0qM/ezi6fM3sXETAnqbGgYdl+DZfA=
X-Received: by 2002:a17:906:4ca:b0:99c:3b4:940f with SMTP id
 g10-20020a17090604ca00b0099c03b4940fmr261267eja.27.1694549268560; Tue, 12 Sep
 2023 13:07:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912013332.2048422-1-jrife@google.com> <65006891779ed_25e754294b8@willemb.c.googlers.com.notmuch>
 <1ca3ca8a-6185-bc55-de74-53991ffc6f91@iogearbox.net> <CADKFtnTOD2+7B5tH8YMHEnxubiG+Cs+t8EhTft+q51YwxjW9xw@mail.gmail.com>
 <CAF=yD-KKGYhKjxio9om1rz7pPe1uiRgODuXWvoLqrGrRbtWNkA@mail.gmail.com>
In-Reply-To: <CAF=yD-KKGYhKjxio9om1rz7pPe1uiRgODuXWvoLqrGrRbtWNkA@mail.gmail.com>
From: Jordan Rife <jrife@google.com>
Date: Tue, 12 Sep 2023 13:07:36 -0700
Message-ID: <CADKFtnSgBZcpYBYRwr6WgnS6j9xH+U0W7bxSqt9ge5aumu4QQg@mail.gmail.com>
Subject: Re: [PATCH net] net: prevent address overwrite in connect() and sendmsg()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, dborkman@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Ideally these all would use the proper kernel-internal APIs.
> I care less about new code. If all examples are clear, that will do the r=
ight thing, or is a simple fix-up worst case.

Fair enough.

> The changes do seem like trivial one liners?

Looks like it. Still, it's going to take some time to patch+test each
of these. I'll start with NFS (SUNRPC), SMB, and Ceph, since I can
easily test them.

> Question is if changing all these callers is suitable for a patch targeti=
ng net.
One patch to net will be needed to add an address copy to
kernel_sendmsg(), but I guess I'll need to send some other patches to
the appropriate subsystem maintainers for SUNRPC, SMB, and Ceph to
swap out calls.

> Similarly, this could call kernel_sendmsg, and the extra copy handled in =
that wrapper.

Would it make more sense to do the address copy in sock_sendmsg()
instead? Are kernel callers "supposed" to use kernel_sendmsg() or is
it valid for them to use sock_sendmsg() as many of them seem to want
to do today. Seeing as sock_sendmsg() is called by kernel_sendmsg(),
adding the copy in sock_sendmsg() fixes this problem for callers to
both of these and avoids the need for patching all modules that call
sock_sendmsg().

-Jordan

On Tue, Sep 12, 2023 at 12:36=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Tue, Sep 12, 2023 at 2:31=E2=80=AFPM Jordan Rife <jrife@google.com> wr=
ote:
> >
> > > These should probably call kernel_connect instead.
> > > Similarly, this could call kernel_sendmsg, and the extra copy handled=
 in that wrapper.
> >
> > I was considering this approach initially, but one concern I had was
> > that there are other instances I see of modules calling ops->connect()
> > directly (bypassing kernel_connect()):
> >
> > - net/netfilter/ipvs/ip_vs_sync.c: make_send_sock()
> > - drivers/block/drbd/drbd_receiver.c: drbd_try_connect()
> > - drivers/infiniband/hw/erdma/erdma_cm.c: kernel_bindconnect()
> > - drivers/infiniband/sw/siw/siw_cm.c: kernel_bindconnect()
> > - fs/ocfs2/cluster/tcp.c: o2net_start_connect()
> > - net/rds/tcp_connect.c: rds_tcp_conn_path_connect()
> >
> > and ops->sendmsg():
> >
> > - net/smc/af_smc.c: smc_sendmsg()
> > - drivers/vhost/net.c: vhost_tx_batch(), handle_tx_copy(), handle_tx_ze=
rocopy()
> > - drivers/target/iscsi/iscsi_target_util.c: iscsit_fe_sendpage_sg()
> >
> > which (at least in theory) leaves them open to the same problem I'm
> > seeing with NFS/SMB right now. I worry that even if all these
> > instances were swapped out with kernel_sendmsg() and kernel_connect(),
> > it would turn into a game of whac-a-mole in the future as new changes
> > or new modules may reintroduce direct calls to sock->ops->connect() or
> > sock->ops->sendmsg().
>
> Ideally these all would use the proper kernel-internal APIs.
>
> I care less about new code. If all examples are clear, that
> will do the right thing, or is a simple fix-up worst case.
>
> Question is if changing all these callers is suitable for a patch
> targeting net.
>
> The changes do seem like trivial one liners?
>
> > -Jordan
> >
> >
> >
> > On Tue, Sep 12, 2023 at 7:22=E2=80=AFAM Daniel Borkmann <daniel@iogearb=
ox.net> wrote:
> > >
> > > On 9/12/23 3:33 PM, Willem de Bruijn wrote:
> > > > Jordan Rife wrote:
> > > >> commit 0bdf399342c5 ("net: Avoid address overwrite in kernel_conne=
ct")
> > > >> ensured that kernel_connect() will not overwrite the address param=
eter
> > > >> in cases where BPF connect hooks perform an address rewrite. Howev=
er,
> > > >> there remain other cases where BPF hooks can overwrite an address =
held
> > > >> by a kernel client.
> > > >>
> > > >> =3D=3DScenarios Tested=3D=3D
> > > >>
> > > >> * Code in the SMB and Ceph modules calls sock->ops->connect() dire=
ctly,
> > > >>    allowing the address overwrite to occur. In the case of SMB, th=
is can
> > > >>    lead to broken mounts.
> > > >
> > > > These should probably call kernel_connect instead.
> > > >
> > > >> * NFS v3 mounts with proto=3Dudp call sock_sendmsg() for each RPC =
call,
> > > >>    passing a pointer to the mount address in msg->msg_name which i=
s
> > > >>    later overwritten by a BPF sendmsg hook. This can lead to broke=
n NFS
> > > >>    mounts.
> > > >
> > > > Similarly, this could call kernel_sendmsg, and the extra copy handl=
ed
> > > > in that wrapper. The arguments are not exacty the same, so not 100%
> > > > this is feasible.
> > > >
> > > > But it's preferable if in-kernel callers use the kernel_.. API rath=
er
> > > > than bypass it. Exactly for issues like the one you report.
> > >
> > > Fully agree, if it's feasible it would be better to convert them over=
 to
> > > in-kernel API.
> > >
> > > >> In order to more comprehensively fix this class of problems, this =
patch
> > > >> pushes the address copy deeper into the stack and introduces an ad=
dress
> > > >> copy to both udp_sendmsg() and udpv6_sendmsg() to insulate all cal=
lers
> > > >> from address rewrites.
> > > >>
> > > >> Signed-off-by: Jordan Rife <jrife@google.com>

