Return-Path: <netdev+bounces-33380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDCB79DA3F
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 22:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7D71C20CF5
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 20:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C3BAD55;
	Tue, 12 Sep 2023 20:49:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E5A8F4B
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 20:49:04 +0000 (UTC)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B833199
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 13:49:04 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-45088c95591so2895437137.3
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 13:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694551743; x=1695156543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqUoNDg8mtKfTCDS6D7uwoNxyp9g9WwIHoet9NtlqA8=;
        b=bIB5i1Va3aKxTVI5uhXPmyntuv0jm8zY6NOrxF6A08gf9mvkOlp6NJ5rRbXpAEYpB/
         voVN1x26r9zrAMhUmib7WX0SsQvM8sutGukbu9iEPtjNo4EWDzxhVTcqH45lzpAO2Dm4
         oUgT4LKFPPU3kJ4l+LtxovuC6mg4dus4corki/LUmjtxL3PwqdIOVwPOG5d1SAuZBAIH
         NLL/Mo9Svc/xLZ60NH6+XG//tPDLvuzujq5Z0MXY8wqtQfciS/zcVqPCgxXNLZNgnQKI
         TXjluqNlQ+blfRtxzcxvw7zyaaIX/91m6i4/XCnaVuc053/mAUTRcxg51/RlrIByUuqB
         Yx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694551743; x=1695156543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqUoNDg8mtKfTCDS6D7uwoNxyp9g9WwIHoet9NtlqA8=;
        b=tWHCMj+tJHETsS3jnoHJCEMmptOWDOrMoK9qB8qBwU2x2iFI4A6dEY5Ez5lAZmVqL9
         RIsXREwJ4h3HLRXPEDZgQBufWQQq2OEp9ljC289Kea9KoLGQbRU6pW/cO+KClIOPxvJE
         l/x1xUE4Ykcojr4yduhIOvmc0MUWkklBfTTEv8LsDX1eytgPBldkAN8Z0qTg2fMqIvjr
         PpR9WDwtI0THpb7ioFsPuAvFlaV4ufj9W0viKEInNll/h0k7FdL1IKDft7fC/cj5e9iG
         Qu7uSQcC4lFsLLf9nCCynn3ETvzbFKXJ+0pA+7vUQZSnXwldJOxTcaAYYMzRmlJOp7Nc
         HA2Q==
X-Gm-Message-State: AOJu0YwLFWBDWSr6aGt3/wQTFZLBdx4X1aR6OjjG47NNpfS0kma6pZvf
	fOdMENVPUoi5hEYscmMFx34TtJSv5eNqbACf7ieXVTvy
X-Google-Smtp-Source: AGHT+IFm+Ezo9mIZ5fne0lPyQiF06l6mTsKBYvpJdKaADXts68Z3LzvDT2LRfl88qFZxnxbxAGX0h6nOcqswCDRr3JU=
X-Received: by 2002:a67:e35a:0:b0:44d:482a:5444 with SMTP id
 s26-20020a67e35a000000b0044d482a5444mr555171vsm.21.1694551743041; Tue, 12 Sep
 2023 13:49:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912013332.2048422-1-jrife@google.com> <65006891779ed_25e754294b8@willemb.c.googlers.com.notmuch>
 <1ca3ca8a-6185-bc55-de74-53991ffc6f91@iogearbox.net> <CADKFtnTOD2+7B5tH8YMHEnxubiG+Cs+t8EhTft+q51YwxjW9xw@mail.gmail.com>
 <CAF=yD-KKGYhKjxio9om1rz7pPe1uiRgODuXWvoLqrGrRbtWNkA@mail.gmail.com> <CADKFtnSgBZcpYBYRwr6WgnS6j9xH+U0W7bxSqt9ge5aumu4QQg@mail.gmail.com>
In-Reply-To: <CADKFtnSgBZcpYBYRwr6WgnS6j9xH+U0W7bxSqt9ge5aumu4QQg@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 12 Sep 2023 16:48:25 -0400
Message-ID: <CAF=yD-JW+Gs+EeJk2jknU6ZL0prjRO41Q3EpVTOTpTD8sEOh6A@mail.gmail.com>
Subject: Re: [PATCH net] net: prevent address overwrite in connect() and sendmsg()
To: Jordan Rife <jrife@google.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, dborkman@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 4:07=E2=80=AFPM Jordan Rife <jrife@google.com> wrot=
e:
>
> > Ideally these all would use the proper kernel-internal APIs.
> > I care less about new code. If all examples are clear, that will do the=
 right thing, or is a simple fix-up worst case.
>
> Fair enough.
>
> > The changes do seem like trivial one liners?
>
> Looks like it. Still, it's going to take some time to patch+test each
> of these. I'll start with NFS (SUNRPC), SMB, and Ceph, since I can
> easily test them.
>
> > Question is if changing all these callers is suitable for a patch targe=
ting net.
> One patch to net will be needed to add an address copy to
> kernel_sendmsg(), but I guess I'll need to send some other patches to
> the appropriate subsystem maintainers for SUNRPC, SMB, and Ceph to
> swap out calls.

If we take this path, it could be a single patch. The subsystem
maintainers should be CC:ed so that they can (N)ACK it.

But I do not mean to ask to split it up and test each one separately.

The change from sock->ops->connect to kernel_connect is certainly
trivial enough that compile testing should suffice.

Note that kernel_connect actually uses READ_ONCE(sock->ops) because of
a data race. All callers that call a socket that may be subject to
IPV6_ADDRFORM should do that. Likely some of those open coded examples
are affected, and do not. This is another example why using a single
interface is preferable.

> > Similarly, this could call kernel_sendmsg, and the extra copy handled i=
n that wrapper.
>
> Would it make more sense to do the address copy in sock_sendmsg()
> instead? Are kernel callers "supposed" to use kernel_sendmsg() or is
> it valid for them to use sock_sendmsg() as many of them seem to want
> to do today. Seeing as sock_sendmsg() is called by kernel_sendmsg(),
> adding the copy in sock_sendmsg() fixes this problem for callers to
> both of these and avoids the need for patching all modules that call
> sock_sendmsg().

I think it is "supposed" to be the API for these cases. But as you
show, clearly it isn't today. Practice trumps theory.

The only question is whether we should pursue your original patch and
accept that this will continue, or one that improves the situation,
but touches more files and thus has a higher risk of merge conflicts.

I'd like to give others some time to chime in. I've given my opinion,
but it's only one.



> -Jordan
>
> On Tue, Sep 12, 2023 at 12:36=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > On Tue, Sep 12, 2023 at 2:31=E2=80=AFPM Jordan Rife <jrife@google.com> =
wrote:
> > >
> > > > These should probably call kernel_connect instead.
> > > > Similarly, this could call kernel_sendmsg, and the extra copy handl=
ed in that wrapper.
> > >
> > > I was considering this approach initially, but one concern I had was
> > > that there are other instances I see of modules calling ops->connect(=
)
> > > directly (bypassing kernel_connect()):
> > >
> > > - net/netfilter/ipvs/ip_vs_sync.c: make_send_sock()
> > > - drivers/block/drbd/drbd_receiver.c: drbd_try_connect()
> > > - drivers/infiniband/hw/erdma/erdma_cm.c: kernel_bindconnect()
> > > - drivers/infiniband/sw/siw/siw_cm.c: kernel_bindconnect()
> > > - fs/ocfs2/cluster/tcp.c: o2net_start_connect()
> > > - net/rds/tcp_connect.c: rds_tcp_conn_path_connect()
> > >
> > > and ops->sendmsg():
> > >
> > > - net/smc/af_smc.c: smc_sendmsg()
> > > - drivers/vhost/net.c: vhost_tx_batch(), handle_tx_copy(), handle_tx_=
zerocopy()
> > > - drivers/target/iscsi/iscsi_target_util.c: iscsit_fe_sendpage_sg()
> > >
> > > which (at least in theory) leaves them open to the same problem I'm
> > > seeing with NFS/SMB right now. I worry that even if all these
> > > instances were swapped out with kernel_sendmsg() and kernel_connect()=
,
> > > it would turn into a game of whac-a-mole in the future as new changes
> > > or new modules may reintroduce direct calls to sock->ops->connect() o=
r
> > > sock->ops->sendmsg().
> >
> > Ideally these all would use the proper kernel-internal APIs.
> >
> > I care less about new code. If all examples are clear, that
> > will do the right thing, or is a simple fix-up worst case.
> >
> > Question is if changing all these callers is suitable for a patch
> > targeting net.
> >
> > The changes do seem like trivial one liners?
> >
> > > -Jordan
> > >
> > >
> > >
> > > On Tue, Sep 12, 2023 at 7:22=E2=80=AFAM Daniel Borkmann <daniel@iogea=
rbox.net> wrote:
> > > >
> > > > On 9/12/23 3:33 PM, Willem de Bruijn wrote:
> > > > > Jordan Rife wrote:
> > > > >> commit 0bdf399342c5 ("net: Avoid address overwrite in kernel_con=
nect")
> > > > >> ensured that kernel_connect() will not overwrite the address par=
ameter
> > > > >> in cases where BPF connect hooks perform an address rewrite. How=
ever,
> > > > >> there remain other cases where BPF hooks can overwrite an addres=
s held
> > > > >> by a kernel client.
> > > > >>
> > > > >> =3D=3DScenarios Tested=3D=3D
> > > > >>
> > > > >> * Code in the SMB and Ceph modules calls sock->ops->connect() di=
rectly,
> > > > >>    allowing the address overwrite to occur. In the case of SMB, =
this can
> > > > >>    lead to broken mounts.
> > > > >
> > > > > These should probably call kernel_connect instead.
> > > > >
> > > > >> * NFS v3 mounts with proto=3Dudp call sock_sendmsg() for each RP=
C call,
> > > > >>    passing a pointer to the mount address in msg->msg_name which=
 is
> > > > >>    later overwritten by a BPF sendmsg hook. This can lead to bro=
ken NFS
> > > > >>    mounts.
> > > > >
> > > > > Similarly, this could call kernel_sendmsg, and the extra copy han=
dled
> > > > > in that wrapper. The arguments are not exacty the same, so not 10=
0%
> > > > > this is feasible.
> > > > >
> > > > > But it's preferable if in-kernel callers use the kernel_.. API ra=
ther
> > > > > than bypass it. Exactly for issues like the one you report.
> > > >
> > > > Fully agree, if it's feasible it would be better to convert them ov=
er to
> > > > in-kernel API.
> > > >
> > > > >> In order to more comprehensively fix this class of problems, thi=
s patch
> > > > >> pushes the address copy deeper into the stack and introduces an =
address
> > > > >> copy to both udp_sendmsg() and udpv6_sendmsg() to insulate all c=
allers
> > > > >> from address rewrites.
> > > > >>
> > > > >> Signed-off-by: Jordan Rife <jrife@google.com>

