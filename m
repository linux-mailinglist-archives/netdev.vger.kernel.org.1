Return-Path: <netdev+bounces-33384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E69179DA92
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 23:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7CA7281989
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 21:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A89B65B;
	Tue, 12 Sep 2023 21:09:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0072B64C
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 21:09:14 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7710FB3
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 14:09:13 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so98729041fa.3
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 14:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694552952; x=1695157752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpTQdutdLK5Js9H2W0UE2cCg2oR4DGbstl+LxtXKOOQ=;
        b=EEy5P0kTya/tuY2zlfjYtIUPV3cWKSFuA+0rPP6gs8Dcu8iD+zd5uVFpobcbu9WOrT
         AYE5q8uHSbN7QPhNQjWlyMEtYRSZDAC/QpX8D3wXriEVg11LatBRRh62CwUP7TRIgjR2
         2Sc8CIWiHnZLLCBbFpWWwjNW3sv+5nj108Xw01d9ByB+jKPkqtdRtmxCA/ewnKQZ6N2A
         784ooSAvpl4j8Vldo/XSjtq8DHbMzh1g5dM513MSntVoNChnAsSvCREZIr5Xyqbepts9
         WNbkiWCUrJ7/VRMUdjoWYvmeDJuD2lE1aG6lJ9hDJdWUulUkiOkk+UNQ0mKgSZztKde/
         5N8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694552952; x=1695157752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpTQdutdLK5Js9H2W0UE2cCg2oR4DGbstl+LxtXKOOQ=;
        b=pLkxD1dClSYi75ZhIj4cuFjfKHsLJX0Bw8xnAYn7iyKptztqAPmzOtNUtIhDC/T46D
         OYrvCbMqa8etqLYedS9mOUFJ3x3lwrBfPziM2EWZcOzdGh8C3WjjwQg67YiSyxlAjy31
         bvjQrKDxLED3yEw3Gb+E1cBsv7/JVx8ypIF8aJdiNkQbwpetuPh6WdohZLm2ue+Zy93l
         tYE+KdrRY1Ivd4fVTv0ThPI0/kqjyNnxX81Nf7WKvf95eSDShfeTt5VPH6c6Katw6OzR
         JXOH/XVM8vEEoviMq8o8+co03aceAxSldwirVxHO3ydJqSlJy4b2nBhKtlgSXULcm3gF
         RKmw==
X-Gm-Message-State: AOJu0YxxBOr10N9BZhjQ7C+QDQj9+TNHbl+ioumjk9oqgQDP4tCCLMSb
	t9ii+FYHHV0TG7nOJB1/wdttRLbAsUl2LVuAieb6fw==
X-Google-Smtp-Source: AGHT+IH6ALN+jLAuuvtH7WvAWXtXGU78jVYn5RSJp0h3TfCcTKe6fX9uZ72Znyr+gx+kjgZozdWZq3XLfdfBxaNSWd8=
X-Received: by 2002:a2e:8181:0:b0:2bc:d6a8:1ef2 with SMTP id
 e1-20020a2e8181000000b002bcd6a81ef2mr728515ljg.12.1694552951525; Tue, 12 Sep
 2023 14:09:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912013332.2048422-1-jrife@google.com> <65006891779ed_25e754294b8@willemb.c.googlers.com.notmuch>
 <1ca3ca8a-6185-bc55-de74-53991ffc6f91@iogearbox.net> <CADKFtnTOD2+7B5tH8YMHEnxubiG+Cs+t8EhTft+q51YwxjW9xw@mail.gmail.com>
 <CAF=yD-KKGYhKjxio9om1rz7pPe1uiRgODuXWvoLqrGrRbtWNkA@mail.gmail.com>
 <CADKFtnSgBZcpYBYRwr6WgnS6j9xH+U0W7bxSqt9ge5aumu4QQg@mail.gmail.com> <CAF=yD-JW+Gs+EeJk2jknU6ZL0prjRO41Q3EpVTOTpTD8sEOh6A@mail.gmail.com>
In-Reply-To: <CAF=yD-JW+Gs+EeJk2jknU6ZL0prjRO41Q3EpVTOTpTD8sEOh6A@mail.gmail.com>
From: Jordan Rife <jrife@google.com>
Date: Tue, 12 Sep 2023 14:08:59 -0700
Message-ID: <CADKFtnTzqLw4F2m9+7BxZZW_QKm_QiduMb6to9mU1WAvbo9MWQ@mail.gmail.com>
Subject: Re: [PATCH net] net: prevent address overwrite in connect() and sendmsg()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, dborkman@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> If we take this path, it could be a single patch. The subsystem
> maintainers should be CC:ed so that they can (N)ACK it.
>
> But I do not mean to ask to split it up and test each one separately.
>
> The change from sock->ops->connect to kernel_connect is certainly
> trivial enough that compile testing should suffice.

Ack. Thanks for clarifying.

> The only question is whether we should pursue your original patch and
> accept that this will continue, or one that improves the situation,
> but touches more files and thus has a higher risk of merge conflicts.
>
> I'd like to give others some time to chime in. I've given my opinion,
> but it's only one.
>
> I'd like to give others some time to chime in. I've given my opinion,
> but it's only one.

Sounds good. I'll wait to hear others' opinions on the best path forward.

-Jordan

On Tue, Sep 12, 2023 at 1:49=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Tue, Sep 12, 2023 at 4:07=E2=80=AFPM Jordan Rife <jrife@google.com> wr=
ote:
> >
> > > Ideally these all would use the proper kernel-internal APIs.
> > > I care less about new code. If all examples are clear, that will do t=
he right thing, or is a simple fix-up worst case.
> >
> > Fair enough.
> >
> > > The changes do seem like trivial one liners?
> >
> > Looks like it. Still, it's going to take some time to patch+test each
> > of these. I'll start with NFS (SUNRPC), SMB, and Ceph, since I can
> > easily test them.
> >
> > > Question is if changing all these callers is suitable for a patch tar=
geting net.
> > One patch to net will be needed to add an address copy to
> > kernel_sendmsg(), but I guess I'll need to send some other patches to
> > the appropriate subsystem maintainers for SUNRPC, SMB, and Ceph to
> > swap out calls.
>
> If we take this path, it could be a single patch. The subsystem
> maintainers should be CC:ed so that they can (N)ACK it.
>
> But I do not mean to ask to split it up and test each one separately.
>
> The change from sock->ops->connect to kernel_connect is certainly
> trivial enough that compile testing should suffice.
>
> Note that kernel_connect actually uses READ_ONCE(sock->ops) because of
> a data race. All callers that call a socket that may be subject to
> IPV6_ADDRFORM should do that. Likely some of those open coded examples
> are affected, and do not. This is another example why using a single
> interface is preferable.
>
> > > Similarly, this could call kernel_sendmsg, and the extra copy handled=
 in that wrapper.
> >
> > Would it make more sense to do the address copy in sock_sendmsg()
> > instead? Are kernel callers "supposed" to use kernel_sendmsg() or is
> > it valid for them to use sock_sendmsg() as many of them seem to want
> > to do today. Seeing as sock_sendmsg() is called by kernel_sendmsg(),
> > adding the copy in sock_sendmsg() fixes this problem for callers to
> > both of these and avoids the need for patching all modules that call
> > sock_sendmsg().
>
> I think it is "supposed" to be the API for these cases. But as you
> show, clearly it isn't today. Practice trumps theory.
>
> The only question is whether we should pursue your original patch and
> accept that this will continue, or one that improves the situation,
> but touches more files and thus has a higher risk of merge conflicts.
>
> I'd like to give others some time to chime in. I've given my opinion,
> but it's only one.
>
>
>
> > -Jordan
> >
> > On Tue, Sep 12, 2023 at 12:36=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > On Tue, Sep 12, 2023 at 2:31=E2=80=AFPM Jordan Rife <jrife@google.com=
> wrote:
> > > >
> > > > > These should probably call kernel_connect instead.
> > > > > Similarly, this could call kernel_sendmsg, and the extra copy han=
dled in that wrapper.
> > > >
> > > > I was considering this approach initially, but one concern I had wa=
s
> > > > that there are other instances I see of modules calling ops->connec=
t()
> > > > directly (bypassing kernel_connect()):
> > > >
> > > > - net/netfilter/ipvs/ip_vs_sync.c: make_send_sock()
> > > > - drivers/block/drbd/drbd_receiver.c: drbd_try_connect()
> > > > - drivers/infiniband/hw/erdma/erdma_cm.c: kernel_bindconnect()
> > > > - drivers/infiniband/sw/siw/siw_cm.c: kernel_bindconnect()
> > > > - fs/ocfs2/cluster/tcp.c: o2net_start_connect()
> > > > - net/rds/tcp_connect.c: rds_tcp_conn_path_connect()
> > > >
> > > > and ops->sendmsg():
> > > >
> > > > - net/smc/af_smc.c: smc_sendmsg()
> > > > - drivers/vhost/net.c: vhost_tx_batch(), handle_tx_copy(), handle_t=
x_zerocopy()
> > > > - drivers/target/iscsi/iscsi_target_util.c: iscsit_fe_sendpage_sg()
> > > >
> > > > which (at least in theory) leaves them open to the same problem I'm
> > > > seeing with NFS/SMB right now. I worry that even if all these
> > > > instances were swapped out with kernel_sendmsg() and kernel_connect=
(),
> > > > it would turn into a game of whac-a-mole in the future as new chang=
es
> > > > or new modules may reintroduce direct calls to sock->ops->connect()=
 or
> > > > sock->ops->sendmsg().
> > >
> > > Ideally these all would use the proper kernel-internal APIs.
> > >
> > > I care less about new code. If all examples are clear, that
> > > will do the right thing, or is a simple fix-up worst case.
> > >
> > > Question is if changing all these callers is suitable for a patch
> > > targeting net.
> > >
> > > The changes do seem like trivial one liners?
> > >
> > > > -Jordan
> > > >
> > > >
> > > >
> > > > On Tue, Sep 12, 2023 at 7:22=E2=80=AFAM Daniel Borkmann <daniel@iog=
earbox.net> wrote:
> > > > >
> > > > > On 9/12/23 3:33 PM, Willem de Bruijn wrote:
> > > > > > Jordan Rife wrote:
> > > > > >> commit 0bdf399342c5 ("net: Avoid address overwrite in kernel_c=
onnect")
> > > > > >> ensured that kernel_connect() will not overwrite the address p=
arameter
> > > > > >> in cases where BPF connect hooks perform an address rewrite. H=
owever,
> > > > > >> there remain other cases where BPF hooks can overwrite an addr=
ess held
> > > > > >> by a kernel client.
> > > > > >>
> > > > > >> =3D=3DScenarios Tested=3D=3D
> > > > > >>
> > > > > >> * Code in the SMB and Ceph modules calls sock->ops->connect() =
directly,
> > > > > >>    allowing the address overwrite to occur. In the case of SMB=
, this can
> > > > > >>    lead to broken mounts.
> > > > > >
> > > > > > These should probably call kernel_connect instead.
> > > > > >
> > > > > >> * NFS v3 mounts with proto=3Dudp call sock_sendmsg() for each =
RPC call,
> > > > > >>    passing a pointer to the mount address in msg->msg_name whi=
ch is
> > > > > >>    later overwritten by a BPF sendmsg hook. This can lead to b=
roken NFS
> > > > > >>    mounts.
> > > > > >
> > > > > > Similarly, this could call kernel_sendmsg, and the extra copy h=
andled
> > > > > > in that wrapper. The arguments are not exacty the same, so not =
100%
> > > > > > this is feasible.
> > > > > >
> > > > > > But it's preferable if in-kernel callers use the kernel_.. API =
rather
> > > > > > than bypass it. Exactly for issues like the one you report.
> > > > >
> > > > > Fully agree, if it's feasible it would be better to convert them =
over to
> > > > > in-kernel API.
> > > > >
> > > > > >> In order to more comprehensively fix this class of problems, t=
his patch
> > > > > >> pushes the address copy deeper into the stack and introduces a=
n address
> > > > > >> copy to both udp_sendmsg() and udpv6_sendmsg() to insulate all=
 callers
> > > > > >> from address rewrites.
> > > > > >>
> > > > > >> Signed-off-by: Jordan Rife <jrife@google.com>

